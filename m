Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAB4CAC5AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Sep 2025 07:00:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F90640A84;
	Thu, 25 Sep 2025 08:59:23 +0200 (CEST)
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com
 [115.124.28.123])
 by mails.dpdk.org (Postfix) with ESMTP id 7401940663
 for <dev@dpdk.org>; Thu, 25 Sep 2025 08:59:13 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.en46bnm_1758783550 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 25 Sep 2025 14:59:10 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v11 08/17] net/nbl: add complete device init and uninit
 functionality
Date: Wed, 24 Sep 2025 23:58:45 -0700
Message-Id: <20250925065854.2907820-9-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925065854.2907820-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250925065854.2907820-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

NBL device is a concept of low level device which used to manage
hw resource and to interact with fw

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_core.c                    |   4 +-
 drivers/net/nbl/nbl_core.h                    |   7 +
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 296 ++++++++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  32 ++
 drivers/net/nbl/nbl_dispatch.c                | 460 +++++++++++++++++-
 drivers/net/nbl/nbl_ethdev.c                  |   2 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  30 +-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  51 ++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |   7 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   7 +-
 .../net/nbl/nbl_include/nbl_def_resource.h    |  18 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  61 +++
 13 files changed, 948 insertions(+), 28 deletions(-)

diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index c21a12728f..ce6c09769b 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -34,8 +34,10 @@ int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev
 {
 	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	const struct nbl_product_core_ops *product_base_ops = NULL;
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
 	int ret = 0;
 
+	common->eth_dev = eth_dev;
 	nbl_init_func_caps(pci_dev, &adapter->caps);
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
@@ -72,7 +74,7 @@ int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev
 chan_init_fail:
 	product_base_ops->hw_remove(adapter);
 hw_init_fail:
-	return -EINVAL;
+	return ret;
 }
 
 void nbl_core_remove(struct nbl_adapter *adapter)
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 73188f83d9..0ec7148e5a 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -46,6 +46,12 @@
 #define NBL_ADAPTER_TO_DISP_OPS_TBL(adapter)	((adapter)->intf.dispatch_ops_tbl)
 #define NBL_ADAPTER_TO_DEV_OPS_TBL(adapter)	((adapter)->intf.dev_ops_tbl)
 
+#define NBL_ADAPTER_TO_COMMON(adapter)		(&((adapter)->common))
+
+#define NBL_IS_NOT_COEXISTENCE(common)		({ typeof(common) _common = (common);	\
+						_common->nl_socket_route < 0 ||		\
+						_common->ifindex < 0; })
+
 struct nbl_core {
 	void *hw_mgt;
 	void *res_mgt;
@@ -80,6 +86,7 @@ struct nbl_adapter {
 	struct nbl_interface intf;
 	struct nbl_func_caps caps;
 	enum nbl_ethdev_state state;
+	struct nbl_common_info common;
 };
 
 int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 4eff95b50f..645fbf9901 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -60,15 +60,131 @@ static void nbl_dev_leonis_uninit(void *adapter)
 	nbl_dev_teardown_chan_queue((struct nbl_adapter *)adapter);
 }
 
+static void nbl_dev_mailbox_interrupt_handler(__rte_unused void *cn_arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)cn_arg;
+	const struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	chan_ops->notify_interrupt(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+}
+
+static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	const struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_board_port_info *board_info;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(net_dev->eth_dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	u8 *mac;
+	int ret;
+
+	board_info = &dev_mgt->common->board_info;
+	disp_ops->get_board_info(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), board_info);
+	mac = net_dev->eth_dev->data->mac_addrs->addr_bytes;
+
+	disp_ops->clear_flow(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+
+	if (NBL_IS_NOT_COEXISTENCE(common)) {
+		ret = disp_ops->configure_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, 1, 0);
+		if (ret)
+			goto configure_msix_map_failed;
+
+		ret = disp_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, true);
+		if (ret)
+			goto enable_mailbox_irq_failed;
+
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					  NBL_CHAN_INTERRUPT_READY, true);
+
+		ret = rte_intr_callback_register(intr_handle,
+						 nbl_dev_mailbox_interrupt_handler, dev_mgt);
+		if (ret) {
+			NBL_LOG(ERR, "mailbox interrupt handler register failed %d", ret);
+			goto rte_intr_callback_register_failed;
+		}
+
+		ret = rte_intr_enable(intr_handle);
+		if (ret) {
+			NBL_LOG(ERR, "rte_intr_enable failed %d", ret);
+			goto rte_intr_enable_failed;
+		}
+
+		ret = disp_ops->add_macvlan(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					    mac, 0, net_dev->vsi_id);
+		if (ret)
+			goto add_macvlan_failed;
+
+		ret = disp_ops->add_multi_rule(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+		if (ret)
+			goto add_multi_rule_failed;
+	}
+
+	return 0;
+
+add_multi_rule_failed:
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		disp_ops->del_macvlan(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), mac, 0, net_dev->vsi_id);
+add_macvlan_failed:
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		rte_intr_disable(intr_handle);
+rte_intr_enable_failed:
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		rte_intr_callback_unregister(intr_handle,
+					     nbl_dev_mailbox_interrupt_handler, dev_mgt);
+rte_intr_callback_register_failed:
+	if (NBL_IS_NOT_COEXISTENCE(common)) {
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					  NBL_CHAN_INTERRUPT_READY, false);
+		disp_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, false);
+	}
+enable_mailbox_irq_failed:
+	if (NBL_IS_NOT_COEXISTENCE(common))
+		disp_ops->destroy_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+configure_msix_map_failed:
+	return ret;
+}
+
 static int nbl_dev_leonis_start(void *p)
 {
-	RTE_SET_USED(p);
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	int ret = 0;
+
+	dev_mgt->common = NBL_ADAPTER_TO_COMMON(adapter);
+	ret = nbl_dev_common_start(dev_mgt);
+	if (ret)
+		return ret;
 	return 0;
 }
 
 static void nbl_dev_leonis_stop(void *p)
 {
-	RTE_SET_USED(p);
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net_mgt *net_dev = dev_mgt->net_dev;
+	struct nbl_common_info *common = dev_mgt->common;
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	const struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(net_dev->eth_dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	u8 *mac;
+
+	mac = net_dev->eth_dev->data->mac_addrs->addr_bytes;
+	if (NBL_IS_NOT_COEXISTENCE(common)) {
+		rte_intr_disable(intr_handle);
+		rte_intr_callback_unregister(intr_handle,
+					     nbl_dev_mailbox_interrupt_handler, dev_mgt);
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					  NBL_CHAN_INTERRUPT_READY, false);
+		/* wake up pipe read in nbl_chan_thread_polling_task */
+		chan_ops->notify_interrupt(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+		disp_ops->enable_mailbox_irq(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), 0, false);
+		disp_ops->destroy_msix_map(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+		disp_ops->del_multi_rule(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+		disp_ops->del_macvlan(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), mac, 0, net_dev->vsi_id);
+	}
 }
 
 static void nbl_dev_remove_ops(struct nbl_dev_ops_tbl **dev_ops_tbl)
@@ -90,6 +206,154 @@ static int nbl_dev_setup_ops(struct nbl_dev_ops_tbl **dev_ops_tbl,
 	return 0;
 }
 
+static int nbl_dev_setup_rings(struct nbl_dev_ring_mgt *ring_mgt)
+{
+	int i;
+	u8 ring_num = ring_mgt->rx_ring_num;
+
+	ring_num = ring_mgt->rx_ring_num;
+	ring_mgt->rx_rings = rte_calloc("nbl_dev_rxring", ring_num,
+					sizeof(*ring_mgt->rx_rings), 0);
+	if (!ring_mgt->rx_rings)
+		return -ENOMEM;
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->rx_rings[i].index = i;
+
+	ring_num = ring_mgt->tx_ring_num;
+	ring_mgt->tx_rings = rte_calloc("nbl_dev_txring", ring_num,
+					sizeof(*ring_mgt->tx_rings), 0);
+	if (!ring_mgt->tx_rings) {
+		rte_free(ring_mgt->rx_rings);
+		ring_mgt->rx_rings = NULL;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < ring_num; i++)
+		ring_mgt->tx_rings[i].index = i;
+
+	return 0;
+}
+
+static void nbl_dev_remove_rings(struct nbl_dev_ring_mgt *ring_mgt)
+{
+	rte_free(ring_mgt->rx_rings);
+	ring_mgt->rx_rings = NULL;
+
+	rte_free(ring_mgt->tx_rings);
+	ring_mgt->tx_rings = NULL;
+}
+
+static void nbl_dev_remove_net_dev(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_ring_mgt *ring_mgt = &net_dev->ring_mgt;
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+
+	disp_ops->remove_rss(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+	disp_ops->remove_q2vsi(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+	disp_ops->free_txrx_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+	disp_ops->remove_rings(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+	nbl_dev_remove_rings(ring_mgt);
+	disp_ops->unregister_net(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+
+	rte_free(net_dev);
+	NBL_DEV_MGT_TO_NET_DEV(dev_mgt) = NULL;
+}
+
+static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
+				 const struct rte_eth_dev *eth_dev,
+				 struct nbl_common_info *common)
+{
+	struct nbl_dev_net_mgt *net_dev;
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_register_net_param register_param = { 0 };
+	struct nbl_register_net_result register_result = { 0 };
+	struct nbl_dev_ring_mgt *ring_mgt;
+	const struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int ret = 0;
+
+	net_dev = rte_zmalloc("nbl_dev_net", sizeof(struct nbl_dev_net_mgt), 0);
+	if (!net_dev)
+		return -ENOMEM;
+
+	NBL_DEV_MGT_TO_NET_DEV(dev_mgt) = net_dev;
+	NBL_DEV_MGT_TO_ETH_DEV(dev_mgt) = eth_dev;
+	ring_mgt = &net_dev->ring_mgt;
+
+	register_param.pf_bar_start = pci_dev->mem_resource[0].phys_addr;
+	ret = disp_ops->register_net(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				     &register_param, &register_result);
+	if (ret)
+		goto register_net_failed;
+
+	ring_mgt->tx_ring_num = register_result.tx_queue_num;
+	ring_mgt->rx_ring_num = register_result.rx_queue_num;
+	ring_mgt->queue_offset = register_result.queue_offset;
+
+	net_dev->vsi_id = disp_ops->get_vsi_id(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+	disp_ops->get_eth_id(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id,
+			     &net_dev->eth_mode, &net_dev->eth_id);
+	net_dev->trust = register_result.trusted;
+
+	if (net_dev->eth_mode == NBL_TWO_ETHERNET_PORT)
+		net_dev->max_mac_num = NBL_TWO_ETHERNET_MAX_MAC_NUM;
+	else if (net_dev->eth_mode == NBL_FOUR_ETHERNET_PORT)
+		net_dev->max_mac_num = NBL_FOUR_ETHERNET_MAX_MAC_NUM;
+
+	common->vsi_id = net_dev->vsi_id;
+	common->eth_id = net_dev->eth_id;
+
+	disp_ops->clear_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+	disp_ops->register_vsi2q(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), NBL_VSI_DATA, net_dev->vsi_id,
+				 register_result.queue_offset, ring_mgt->tx_ring_num);
+	ret = nbl_dev_setup_rings(ring_mgt);
+	if (ret)
+		goto setup_rings_failed;
+
+	ret = disp_ops->alloc_rings(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				    register_result.tx_queue_num,
+				    register_result.rx_queue_num,
+				    register_result.queue_offset);
+	if (ret) {
+		NBL_LOG(ERR, "alloc_rings failed ret %d", ret);
+		goto alloc_rings_failed;
+	}
+
+	ret = disp_ops->alloc_txrx_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+					  net_dev->vsi_id,
+					  register_result.tx_queue_num);
+	if (ret) {
+		NBL_LOG(ERR, "alloc_txrx_queues failed ret %d", ret);
+		goto alloc_txrx_queues_failed;
+	}
+
+	ret = disp_ops->setup_q2vsi(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), net_dev->vsi_id);
+	if (ret) {
+		NBL_LOG(ERR, "setup_q2vsi failed ret %d", ret);
+		goto setup_q2vsi_failed;
+	}
+
+	ret = disp_ops->setup_rss(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				  net_dev->vsi_id);
+
+	return ret;
+
+setup_q2vsi_failed:
+	disp_ops->free_txrx_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				   net_dev->vsi_id);
+alloc_txrx_queues_failed:
+	disp_ops->remove_rings(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+alloc_rings_failed:
+	nbl_dev_remove_rings(ring_mgt);
+setup_rings_failed:
+	disp_ops->unregister_net(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt));
+register_net_failed:
+	rte_free(net_dev);
+
+	return ret;
+}
+
 int nbl_dev_init(void *p, __rte_unused const struct rte_eth_dev *eth_dev)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
@@ -98,12 +362,15 @@ int nbl_dev_init(void *p, __rte_unused const struct rte_eth_dev *eth_dev)
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
 	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+	struct nbl_common_info *common = NULL;
+	struct nbl_dispatch_ops *disp_ops;
 	int ret = 0;
 
 	dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
 	dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
 	chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
 	dispatch_ops_tbl = NBL_ADAPTER_TO_DISP_OPS_TBL(adapter);
+	common = NBL_ADAPTER_TO_COMMON(adapter);
 	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
 
 	*dev_mgt = rte_zmalloc("nbl_dev_mgt", sizeof(struct nbl_dev_mgt), 0);
@@ -114,6 +381,7 @@ int nbl_dev_init(void *p, __rte_unused const struct rte_eth_dev *eth_dev)
 
 	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
 	NBL_DEV_MGT_TO_DISP_OPS_TBL(*dev_mgt) = dispatch_ops_tbl;
+	disp_ops = NBL_DEV_MGT_TO_DISP_OPS(*dev_mgt);
 
 	if (product_dev_ops->dev_init)
 		ret = product_dev_ops->dev_init(adapter);
@@ -125,10 +393,28 @@ int nbl_dev_init(void *p, __rte_unused const struct rte_eth_dev *eth_dev)
 	if (ret)
 		goto set_ops_failed;
 
+	ret = nbl_dev_setup_net_dev(*dev_mgt, eth_dev, common);
+	if (ret)
+		goto setup_net_dev_failed;
+
+	eth_dev->data->mac_addrs =
+		rte_zmalloc("nbl", RTE_ETHER_ADDR_LEN * (*dev_mgt)->net_dev->max_mac_num, 0);
+	if (!eth_dev->data->mac_addrs) {
+		NBL_LOG(ERR, "allocate memory to store mac addr failed");
+		ret = -ENOMEM;
+		goto alloc_mac_addrs_failed;
+	}
+	disp_ops->get_mac_addr(NBL_DEV_MGT_TO_DISP_PRIV(*dev_mgt),
+			       eth_dev->data->mac_addrs[0].addr_bytes);
+
 	adapter->state = NBL_ETHDEV_INITIALIZED;
 
 	return 0;
 
+alloc_mac_addrs_failed:
+	nbl_dev_remove_net_dev(*dev_mgt);
+setup_net_dev_failed:
+	nbl_dev_remove_ops(dev_ops_tbl);
 set_ops_failed:
 	if (product_dev_ops->dev_uninit)
 		product_dev_ops->dev_uninit(adapter);
@@ -144,11 +430,17 @@ void nbl_dev_remove(void *p)
 	struct nbl_dev_mgt **dev_mgt;
 	struct nbl_dev_ops_tbl **dev_ops_tbl;
 	const struct nbl_product_dev_ops *product_dev_ops = NULL;
+	const struct rte_eth_dev *eth_dev;
 
 	dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
 	dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
 	product_dev_ops = nbl_dev_get_product_ops(adapter->caps.product_type);
+	eth_dev = (*dev_mgt)->net_dev->eth_dev;
+
+	rte_free(eth_dev->data->mac_addrs);
+	eth_dev->data->mac_addrs = NULL;
 
+	nbl_dev_remove_net_dev(*dev_mgt);
 	nbl_dev_remove_ops(dev_ops_tbl);
 	if (product_dev_ops->dev_uninit)
 		product_dev_ops->dev_uninit(adapter);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 57c30951f8..4df9383919 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -13,10 +13,42 @@
 #define NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)	((dev_mgt)->chan_ops_tbl)
 #define NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->ops)
 #define NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->priv)
+#define NBL_DEV_MGT_TO_NET_DEV(dev_mgt)		((dev_mgt)->net_dev)
+#define NBL_DEV_MGT_TO_ETH_DEV(dev_mgt)		((dev_mgt)->net_dev->eth_dev)
+#define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
+
+struct nbl_dev_ring {
+	u16 index;
+	u64 dma;
+	u16 local_queue_id;
+	u16 global_queue_id;
+	u32 desc_num;
+};
+
+struct nbl_dev_ring_mgt {
+	struct nbl_dev_ring *tx_rings;
+	struct nbl_dev_ring *rx_rings;
+	u16 queue_offset;
+	u8 tx_ring_num;
+	u8 rx_ring_num;
+	u8 active_ring_num;
+};
+
+struct nbl_dev_net_mgt {
+	const struct rte_eth_dev *eth_dev;
+	struct nbl_dev_ring_mgt ring_mgt;
+	u16 vsi_id;
+	u8 eth_mode;
+	u8 eth_id;
+	u16 max_mac_num;
+	bool trust;
+};
 
 struct nbl_dev_mgt {
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dev_net_mgt *net_dev;
+	struct nbl_common_info *common;
 };
 
 const struct nbl_product_dev_ops *nbl_dev_get_product_ops(enum nbl_product_type product_type);
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 8d04e87f5c..6d578bb30f 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -47,14 +47,9 @@ static int nbl_disp_destroy_msix_map(void *priv)
 static int nbl_disp_chan_destroy_msix_map_req(void *priv)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
-	const struct nbl_channel_ops *chan_ops;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send;
 
-	if (!disp_mgt)
-		return -EINVAL;
-
-	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
-
 	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DESTROY_MSIX_MAP, NULL, 0, NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
@@ -98,13 +93,11 @@ static int nbl_disp_chan_alloc_txrx_queues_req(void *priv, u16 vsi_id,
 					       u16 queue_num)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
-	const struct nbl_channel_ops *chan_ops;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_param_alloc_txrx_queues param = {0};
 	struct nbl_chan_param_alloc_txrx_queues result = {0};
 	struct nbl_chan_send_info chan_send;
 
-	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
-
 	param.vsi_id = vsi_id;
 	param.queue_num = queue_num;
 
@@ -119,18 +112,17 @@ static void nbl_disp_free_txrx_queues(void *priv, u16 vsi_id)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
 	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
 	NBL_OPS_CALL(res_ops->free_txrx_queues, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
 }
 
 static void nbl_disp_chan_free_txrx_queues_req(void *priv, u16 vsi_id)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
-	const struct nbl_channel_ops *chan_ops;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_param_free_txrx_queues param = {0};
 	struct nbl_chan_send_info chan_send;
 
-	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
-
 	param.vsi_id = vsi_id;
 
 	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_FREE_TXRX_QUEUES, &param,
@@ -263,12 +255,10 @@ nbl_disp_chan_setup_queue_req(void *priv,
 			      bool is_tx)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
-	const struct nbl_channel_ops *chan_ops;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_param_setup_queue param = {0};
 	struct nbl_chan_send_info chan_send;
 
-	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
-
 	memcpy(&param.queue_param, queue_param, sizeof(param.queue_param));
 	param.is_tx = is_tx;
 
@@ -288,12 +278,10 @@ static void nbl_disp_remove_all_queues(void *priv, u16 vsi_id)
 static void nbl_disp_chan_remove_all_queues_req(void *priv, u16 vsi_id)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
-	const struct nbl_channel_ops *chan_ops;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_param_remove_all_queues param = {0};
 	struct nbl_chan_send_info chan_send;
 
-	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
-
 	param.vsi_id = vsi_id;
 
 	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
@@ -301,6 +289,382 @@ static void nbl_disp_chan_remove_all_queues_req(void *priv, u16 vsi_id)
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
+static int nbl_disp_get_mac_addr(void *priv __rte_unused, u8 *mac)
+{
+	rte_eth_random_addr(mac);
+
+	return 0;
+}
+
+static int nbl_disp_get_mac_addr_req(void *priv __rte_unused, u8 *mac)
+{
+	rte_eth_random_addr(mac);
+
+	return 0;
+}
+
+static int nbl_disp_register_net(void *priv,
+				struct nbl_register_net_param *register_param,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->register_net,
+			(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), register_param, register_result));
+}
+
+static int nbl_disp_chan_register_net_req(void *priv,
+				struct nbl_register_net_param *register_param,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_register_net_info param = {0};
+	struct nbl_chan_send_info chan_send;
+	int ret = 0;
+
+	param.pf_bar_start = register_param->pf_bar_start;
+	param.pf_bdf = register_param->pf_bdf;
+	param.vf_bar_start = register_param->vf_bar_start;
+	param.vf_bar_size = register_param->vf_bar_size;
+	param.total_vfs = register_param->total_vfs;
+	param.offset = register_param->offset;
+	param.stride = register_param->stride;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REGISTER_NET,
+		      &param, sizeof(param),
+		      (void *)register_result, sizeof(*register_result), 1);
+
+	ret = chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+	return ret;
+}
+
+static int nbl_disp_unregister_net(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->unregister_net, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static int nbl_disp_chan_unregister_net_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_UNREGISTER_NET, NULL,
+		      0, NULL, 0, 1);
+
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt),
+				  &chan_send);
+}
+
+static u16 nbl_disp_get_vsi_id(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->get_vsi_id, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt)));
+}
+
+static u16 nbl_disp_chan_get_vsi_id_req(void *priv)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_vsi_id param = {0};
+	struct nbl_chan_param_get_vsi_id result = {0};
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_VSI_ID, &param,
+		      sizeof(param), &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	return result.vsi_id;
+}
+
+static void nbl_disp_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->get_eth_id, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+					   vsi_id, eth_mode, eth_id));
+}
+
+static void nbl_disp_chan_get_eth_id_req(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_get_eth_id param = {0};
+	struct nbl_chan_param_get_eth_id result = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_ETH_ID,  &param, sizeof(param),
+		      &result, sizeof(result), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+
+	*eth_mode = result.eth_mode;
+	*eth_id = result.eth_id;
+}
+
+static int nbl_disp_chan_setup_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->setup_q2vsi,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static int nbl_disp_chan_setup_q2vsi_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_q2vsi param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_Q2VSI, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_q2vsi(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->remove_q2vsi,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_remove_q2vsi_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_q2vsi param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_Q2VSI, &param,
+		      sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_chan_register_vsi2q(void *priv, u16 vsi_index, u16 vsi_id,
+					u16 queue_offset, u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->register_vsi2q,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_index,
+			     vsi_id, queue_offset, queue_num));
+}
+
+static int nbl_disp_chan_register_vsi2q_req(void *priv, u16 vsi_index, u16 vsi_id,
+					    u16 queue_offset, u16 queue_num)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_register_vsi2q param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_index = vsi_index;
+	param.vsi_id = vsi_id;
+	param.queue_offset = queue_offset;
+	param.queue_num = queue_num;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REGISTER_VSI2Q, &param, sizeof(param),
+		      NULL, 0, 1);
+
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_chan_setup_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->setup_rss,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static int nbl_disp_chan_setup_rss_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_rss param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_RSS, &param,
+		      sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_remove_rss(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->remove_rss,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_remove_rss_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_rss param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_RSS, &param,
+		      sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_chan_get_board_info(void *priv, struct nbl_board_port_info *board_info)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(board_info);
+}
+
+static void nbl_disp_chan_get_board_info_req(void *priv, struct nbl_board_port_info *board_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_BOARD_INFO, NULL,
+		      0, board_info, sizeof(*board_info), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_clear_flow(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->clear_flow, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_clear_flow_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_FLOW, &vsi_id, sizeof(vsi_id),
+		      NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_add_macvlan(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->add_macvlan,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), mac, vlan_id, vsi_id));
+}
+
+static int
+nbl_disp_chan_add_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_chan_param_macvlan_cfg param = {0};
+
+	memcpy(&param.mac, mac, sizeof(param.mac));
+	param.vlan = vlan_id;
+	param.vsi = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MACVLAN,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_del_macvlan(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->del_macvlan,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), mac, vlan_id, vsi_id));
+}
+
+static void
+nbl_disp_chan_del_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_chan_param_macvlan_cfg param = {0};
+
+	memcpy(&param.mac, mac, sizeof(param.mac));
+	param.vlan = vlan_id;
+	param.vsi = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MACVLAN,
+		      &param, sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_add_multi_rule(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->add_multi_rule, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static int nbl_disp_chan_add_multi_rule_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_add_multi_rule param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MULTI_RULE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_del_multi_rule(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->del_multi_rule, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_del_multi_rule_req(void *priv, u16 vsi)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_del_multi_rule param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi = vsi;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MULTI_RULE,
+		      &param, sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
 #define NBL_DISP_OPS_TBL						\
 do {									\
 	NBL_DISP_SET_OPS(configure_msix_map, nbl_disp_configure_msix_map,			\
@@ -360,6 +724,66 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_CLEAR_QUEUE,			\
 			 nbl_disp_chan_clear_queues_req, NULL);		\
+	NBL_DISP_SET_OPS(get_mac_addr, nbl_disp_get_mac_addr,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 -1, nbl_disp_get_mac_addr_req, NULL);		\
+	NBL_DISP_SET_OPS(register_net, nbl_disp_register_net,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REGISTER_NET,			\
+			 nbl_disp_chan_register_net_req,		\
+			 NULL);						\
+	NBL_DISP_SET_OPS(unregister_net, nbl_disp_unregister_net,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_UNREGISTER_NET,			\
+			 nbl_disp_chan_unregister_net_req, NULL);	\
+	NBL_DISP_SET_OPS(get_vsi_id, nbl_disp_get_vsi_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_VSI_ID,\
+			 nbl_disp_chan_get_vsi_id_req, NULL);		\
+	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
+			 nbl_disp_chan_get_eth_id_req, NULL);		\
+	NBL_DISP_SET_OPS(setup_q2vsi, nbl_disp_chan_setup_q2vsi,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_SETUP_Q2VSI,			\
+			 nbl_disp_chan_setup_q2vsi_req, NULL);		\
+	NBL_DISP_SET_OPS(remove_q2vsi, nbl_disp_chan_remove_q2vsi,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REMOVE_Q2VSI,			\
+			 nbl_disp_chan_remove_q2vsi_req, NULL);		\
+	NBL_DISP_SET_OPS(register_vsi2q, nbl_disp_chan_register_vsi2q,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_REGISTER_VSI2Q,			\
+			 nbl_disp_chan_register_vsi2q_req, NULL);	\
+	NBL_DISP_SET_OPS(setup_rss, nbl_disp_chan_setup_rss,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_RSS,	\
+			 nbl_disp_chan_setup_rss_req, NULL);		\
+	NBL_DISP_SET_OPS(remove_rss, nbl_disp_chan_remove_rss,		\
+			 NBL_DISP_CTRL_LVL_MGT,	NBL_CHAN_MSG_REMOVE_RSS,\
+			 nbl_disp_chan_remove_rss_req, NULL);		\
+	NBL_DISP_SET_OPS(get_board_info, nbl_disp_chan_get_board_info,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_BOARD_INFO,			\
+			 nbl_disp_chan_get_board_info_req, NULL);	\
+	NBL_DISP_SET_OPS(clear_flow, nbl_disp_clear_flow,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CLEAR_FLOW,			\
+			 nbl_disp_chan_clear_flow_req, NULL);		\
+	NBL_DISP_SET_OPS(add_macvlan, nbl_disp_add_macvlan,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_ADD_MACVLAN,			\
+			 nbl_disp_chan_add_macvlan_req, NULL);		\
+	NBL_DISP_SET_OPS(del_macvlan, nbl_disp_del_macvlan,		\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_DEL_MACVLAN,			\
+			 nbl_disp_chan_del_macvlan_req, NULL);		\
+	NBL_DISP_SET_OPS(add_multi_rule, nbl_disp_add_multi_rule,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_ADD_MULTI_RULE,			\
+			 nbl_disp_chan_add_multi_rule_req, NULL);	\
+	NBL_DISP_SET_OPS(del_multi_rule, nbl_disp_del_multi_rule,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_DEL_MULTI_RULE,			\
+			 nbl_disp_chan_del_multi_rule_req, NULL);	\
 } while (0)
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 5f4aa94240..c072756318 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -29,7 +29,7 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.dev_configure = nbl_dev_configure,
 	.dev_start = nbl_dev_port_start,
 	.dev_stop = nbl_dev_port_stop,
-	.dev_close = nbl_dev_port_close,
+	.dev_close = nbl_dev_close,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 1fe12be11d..d33c1f43e3 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -28,6 +28,7 @@ struct nbl_txrx_mgt {
 	rte_spinlock_t tx_lock;
 	struct nbl_res_tx_ring **tx_rings;
 	struct nbl_res_rx_ring **rx_rings;
+	u16 queue_offset;
 	u8 tx_ring_num;
 	u8 rx_ring_num;
 };
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 20f338bd63..5c5caa55eb 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -7,16 +7,36 @@
 
 static int nbl_res_txrx_alloc_rings(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(tx_num);
-	RTE_SET_USED(rx_num);
-	RTE_SET_USED(queue_offset);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+
+	txrx_mgt->tx_rings = rte_calloc("nbl_txrings", tx_num,
+					sizeof(struct nbl_res_tx_ring *), 0);
+	if (!txrx_mgt->tx_rings) {
+		NBL_LOG(ERR, "Allocate the tx rings array failed");
+		return -ENOMEM;
+	}
+
+	txrx_mgt->rx_rings = rte_calloc("nbl_rxrings", rx_num,
+					sizeof(struct nbl_res_rx_ring *), 0);
+	if (!txrx_mgt->tx_rings) {
+		NBL_LOG(ERR, "Allocate the rx rings array failed");
+		rte_free(txrx_mgt->tx_rings);
+		return -ENOMEM;
+	}
+
+	txrx_mgt->queue_offset = queue_offset;
+
 	return 0;
 }
 
 static void nbl_res_txrx_remove_rings(void *priv)
 {
-	RTE_SET_USED(priv);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_txrx_mgt *txrx_mgt = res_mgt->txrx_mgt;
+
+	rte_free(txrx_mgt->tx_rings);
+	rte_free(txrx_mgt->rx_rings);
 }
 
 static int nbl_res_txrx_start_tx_ring(void *priv,
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 8848a733e7..0a5dd0ab3a 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -314,6 +314,57 @@ struct nbl_chan_param_enable_mailbox_irq {
 	bool enable_msix;
 };
 
+struct nbl_chan_param_register_net_info {
+	u16 pf_bdf;
+	u64 vf_bar_start;
+	u64 vf_bar_size;
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+	u64 pf_bar_start;
+};
+
+struct nbl_chan_param_get_vsi_id {
+	u16 vsi_id;
+	u16 type;
+};
+
+struct nbl_chan_param_get_eth_id {
+	u16 vsi_id;
+	u8 eth_mode;
+	u8 eth_id;
+	u8 logic_eth_id;
+};
+
+struct nbl_chan_param_register_vsi2q {
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+};
+
+struct nbl_chan_param_cfg_q2vsi {
+	u16 vsi_id;
+};
+
+struct nbl_chan_param_cfg_rss {
+	u16 vsi_id;
+};
+
+struct nbl_chan_param_macvlan_cfg {
+	u8 mac[RTE_ETHER_ADDR_LEN];
+	u16 vlan;
+	u16 vsi;
+};
+
+struct nbl_chan_param_add_multi_rule {
+	u16 vsi;
+};
+
+struct nbl_chan_param_del_multi_rule {
+	u16 vsi;
+};
+
 struct nbl_chan_send_info {
 	uint16_t dstid;
 	uint16_t msg_type;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 75768142e8..df5743e82d 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -11,6 +11,13 @@
 	({ typeof(func) _func = (func);	\
 	 (!_func) ? 0 : _func para; })
 
+#define NBL_ONE_ETHERNET_PORT			(1)
+#define NBL_TWO_ETHERNET_PORT			(2)
+#define NBL_FOUR_ETHERNET_PORT			(4)
+
+#define NBL_TWO_ETHERNET_MAX_MAC_NUM		(512)
+#define NBL_FOUR_ETHERNET_MAX_MAC_NUM		(1024)
+
 struct nbl_dma_mem {
 	void *va;
 	uint64_t pa;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index a1f7afd42a..3a1139d76a 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -23,8 +23,12 @@ struct nbl_dispatch_ops {
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv);
 	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
-	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
+	int (*register_net)(void *priv,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv);
 	int (*get_mac_addr)(void *priv, u8 *mac);
+	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
 	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
 	int (*add_multi_rule)(void *priv, u16 vsi);
 	void (*del_multi_rule)(void *priv, u16 vsi);
@@ -66,6 +70,7 @@ struct nbl_dispatch_ops {
 	u16 (*xmit_pkts)(void *priv, void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts);
 	u16 (*recv_pkts)(void *priv, void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
 	u16 (*get_vsi_global_qid)(void *priv, u16 vsi_id, u16 local_qid);
+	void (*get_board_info)(void *priv, struct nbl_board_port_info *board_info);
 
 	void (*dummy_func)(void *priv);
 };
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 8ed19387c2..775f5813ea 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -16,6 +16,18 @@ struct nbl_resource_ops {
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv, u16 func_id);
 	int (*enable_mailbox_irq)(void *priv, u16 func_id, u16 vector_id, bool enable_msix);
+	int (*register_net)(void *priv,
+			    struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv);
+	u16 (*get_vsi_id)(void *priv);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id);
+	int (*setup_q2vsi)(void *priv, u16 vsi_id);
+	void (*remove_q2vsi)(void *priv, u16 vsi_id);
+	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
+			      u16 queue_offset, u16 queue_num);
+	int (*setup_rss)(void *priv, u16 vsi_id);
+	void (*remove_rss)(void *priv, u16 vsi_id);
 	int (*alloc_rings)(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset);
 	void (*remove_rings)(void *priv);
 	int (*start_tx_ring)(void *priv, struct nbl_start_tx_ring_param *param, u64 *dma_addr);
@@ -43,6 +55,12 @@ struct nbl_resource_ops {
 	int (*get_txrx_xstats)(void *priv, struct rte_eth_xstat *xstats, u16 *xstats_cnt);
 	int (*get_txrx_xstats_names)(void *priv, struct rte_eth_xstat_name *xstats_names,
 				     u16 *xstats_cnt);
+	int (*add_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
+	void (*del_macvlan)(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id);
+	int (*add_multi_rule)(void *priv, u16 vsi_id);
+	void (*del_multi_rule)(void *priv, u16 vsi_id);
+	int (*cfg_multi_mcast)(void *priv, u16 vsi_id, u16 enable);
+	void (*clear_flow)(void *priv, u16 vsi_id);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 2101de36a8..d29d6fe7e6 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -51,6 +51,13 @@ typedef int8_t s8;
 /* Used for macros to pass checkpatch */
 #define NBL_NAME(x)					x
 
+enum {
+	NBL_VSI_DATA = 0,	/* default vsi in kernel or independent dpdk */
+	NBL_VSI_CTRL,
+	NBL_VSI_USER,		/* dpdk used vsi in coexist dpdk */
+	NBL_VSI_MAX,
+};
+
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
@@ -98,4 +105,58 @@ struct nbl_txrx_queue_param {
 	u16 rxcsum;
 };
 
+struct nbl_board_port_info {
+	u8 eth_num;
+	u8 speed;
+	u8 rsv[6];
+};
+
+struct nbl_common_info {
+	const struct rte_eth_dev *eth_dev;
+	u16 vsi_id;
+	u16 instance_id;
+	int devfd;
+	int eventfd;
+	int ifindex;
+	int iommu_group_num;
+	int nl_socket_route;
+	int dma_limit_msb;
+	u8 eth_id;
+	/* isolate 1 means kernel network, 0 means user network */
+	u8 isolate:1;
+	/* curr_network 0 means kernel network, 1 means user network */
+	u8 curr_network:1;
+	u8 is_vf:1;
+	u8 specific_dma:1;
+	u8 dma_set_msb:1;
+	u8 rsv:3;
+	struct nbl_board_port_info board_info;
+};
+
+struct nbl_register_net_param {
+	u16 pf_bdf;
+	u64 vf_bar_start;
+	u64 vf_bar_size;
+	u16 total_vfs;
+	u16 offset;
+	u16 stride;
+	u64 pf_bar_start;
+};
+
+struct nbl_register_net_result {
+	u16 tx_queue_num;
+	u16 rx_queue_num;
+	u16 queue_size;
+	u16 rdma_enable;
+	u64 hw_features;
+	u64 features;
+	u16 max_mtu;
+	u16 queue_offset;
+	u8 mac[RTE_ETHER_ADDR_LEN];
+	u16 vlan_proto;
+	u16 vlan_tci;
+	u32 rate;
+	bool trusted;
+};
+
 #endif
-- 
2.34.1

