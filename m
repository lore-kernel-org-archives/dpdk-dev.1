Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D77CAC582
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Sep 2025 06:19:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CCBB40B8F;
	Fri, 12 Sep 2025 08:18:20 +0200 (CEST)
Received: from out28-99.mail.aliyun.com (out28-99.mail.aliyun.com
 [115.124.28.99]) by mails.dpdk.org (Postfix) with ESMTP id 3F03440693
 for <dev@dpdk.org>; Fri, 12 Sep 2025 08:18:09 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.edSA7pg_1757657886 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 12 Sep 2025 14:18:07 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v8 13/17] net/nbl: add nbl device start and stop ops
Date: Thu, 11 Sep 2025 23:17:48 -0700
Message-Id: <20250912061752.2091320-14-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250912061752.2091320-1-dimon.zhao@nebula-matrix.com>
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

Implement NBL device start and stop functions

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 172 +++++++++++++++++-
 drivers/net/nbl/nbl_dispatch.c                | 121 +++++++++++-
 drivers/net/nbl/nbl_hw/nbl_txrx.c             |  72 +++++++-
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  14 +-
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  20 ++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |   6 +-
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   2 +-
 .../net/nbl/nbl_include/nbl_def_resource.h    |   4 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   9 +-
 9 files changed, 389 insertions(+), 31 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 887b7e8bad..2df0b8d78c 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -44,21 +44,179 @@ int nbl_dev_configure(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
+static int nbl_dev_txrx_start(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ring_mgt *ring_mgt = &dev_mgt->net_dev->ring_mgt;
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_txrx_queue_param param = {0};
+	struct nbl_dev_ring *ring;
+	int ret = 0;
+	int i;
+
+	eth_dev->data->scattered_rx = 0;
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
+		ring = &ring_mgt->tx_rings[i];
+		param.desc_num = ring->desc_num;
+		param.vsi_id = dev_mgt->net_dev->vsi_id;
+		param.dma = ring->dma;
+		param.local_queue_id = i + ring_mgt->queue_offset;
+		param.intr_en = 0;
+		param.intr_mask = 0;
+		param.extend_header = 1;
+		param.split = 0;
+
+		ret = disp_ops->setup_queue(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, true);
+		if (ret) {
+			NBL_LOG(ERR, "setup_tx_queue failed %d", ret);
+			return ret;
+		}
+
+		ring->global_queue_id =
+			disp_ops->get_vsi_global_qid(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+						     param.vsi_id, param.local_queue_id);
+		eth_dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		ring = &ring_mgt->rx_rings[i];
+		param.desc_num = ring->desc_num;
+		param.vsi_id = dev_mgt->net_dev->vsi_id;
+		param.dma = ring->dma;
+		param.local_queue_id = i + ring_mgt->queue_offset;
+		param.intr_en = 0;
+		param.intr_mask = 0;
+		param.half_offload_en = 1;
+		param.extend_header = 1;
+		param.split = 0;
+		param.rxcsum = 1;
+
+		ret = disp_ops->setup_queue(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, false);
+		if (ret) {
+			NBL_LOG(ERR, "setup_rx_queue failed %d", ret);
+			return ret;
+		}
+
+		ret = disp_ops->alloc_rx_bufs(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+		if (ret) {
+			NBL_LOG(ERR, "alloc_rx_bufs failed %d", ret);
+			return ret;
+		}
+
+		ring->global_queue_id =
+			disp_ops->get_vsi_global_qid(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+						     param.vsi_id, param.local_queue_id);
+		disp_ops->update_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+		eth_dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	ret = disp_ops->cfg_dsch(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, true);
+	if (ret) {
+		NBL_LOG(ERR, "cfg_dsch failed %d", ret);
+		goto cfg_dsch_fail;
+	}
+	ret = disp_ops->setup_cqs(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				  dev_mgt->net_dev->vsi_id, eth_dev->data->nb_rx_queues, true);
+	if (ret)
+		goto setup_cqs_fail;
+
+	return ret;
+
+setup_cqs_fail:
+	disp_ops->cfg_dsch(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, false);
+cfg_dsch_fail:
+	disp_ops->remove_all_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				    dev_mgt->net_dev->vsi_id);
+
+	return ret;
+}
+
 int nbl_dev_port_start(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	int ret;
+
+	if (adapter == NULL)
+		return -EINVAL;
+
+	ret = nbl_userdev_port_config(adapter, NBL_USER_NETWORK);
+	if (ret)
+		return ret;
+
+	ret = nbl_dev_txrx_start(eth_dev);
+	if (ret) {
+		NBL_LOG(ERR, "dev_txrx_start failed %d", ret);
+		nbl_userdev_port_config(adapter, NBL_KERNEL_NETWORK);
+		return ret;
+	}
+
+	common->pf_start = 1;
 	return 0;
 }
 
+static void nbl_clear_queues(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	int i;
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++)
+		disp_ops->stop_tx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
+		disp_ops->stop_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+}
+
+static void nbl_dev_txrx_stop(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+
+	disp_ops->cfg_dsch(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id, false);
+	disp_ops->remove_cqs(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id);
+	disp_ops->remove_all_queues(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), dev_mgt->net_dev->vsi_id);
+}
+
 int nbl_dev_port_stop(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	common->pf_start = 0;
+	rte_delay_ms(NBL_SAFE_THREADS_WAIT_TIME);
+
+	nbl_clear_queues(eth_dev);
+	nbl_dev_txrx_stop(eth_dev);
+	nbl_userdev_port_config(adapter, NBL_KERNEL_NETWORK);
 	return 0;
 }
 
+static void nbl_release_queues(struct rte_eth_dev *eth_dev)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	int i;
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++)
+		disp_ops->release_tx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++)
+		disp_ops->release_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), i);
+}
+
 int nbl_dev_port_close(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	/* pf may not start, so no queue need release */
+	if (common->pf_start)
+		nbl_release_queues(eth_dev);
+
 	return 0;
 }
 
@@ -189,7 +347,7 @@ static int nbl_dev_common_start(struct nbl_dev_mgt *dev_mgt)
 	u8 *mac;
 	int ret;
 
-	board_info = &dev_mgt->common->board_info;
+	board_info = &common->board_info;
 	disp_ops->get_board_info(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), board_info);
 	mac = net_dev->eth_dev->data->mac_addrs->addr_bytes;
 
@@ -262,9 +420,9 @@ static void nbl_dev_leonis_stop(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
-	struct nbl_dev_net_mgt *net_dev = dev_mgt->net_dev;
-	struct nbl_common_info *common = dev_mgt->common;
-	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	struct nbl_dev_net_mgt *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	const struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	const struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
 	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(net_dev->eth_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index 4a1108db90..ca80d5f977 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -416,6 +416,31 @@ static void nbl_disp_chan_get_eth_id_req(void *priv, u16 vsi_id, u8 *eth_mode, u
 	*eth_id = result.eth_id;
 }
 
+static u16 nbl_disp_get_vsi_global_qid(void *priv, u16 vsi_id, u16 local_qid)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->get_vsi_global_qid,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, local_qid));
+}
+
+static u16
+nbl_disp_chan_get_vsi_global_qid_req(void *priv, u16 vsi_id, u16 local_qid)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_vsi_qid_info param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+	param.local_qid = local_qid;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
 static int nbl_disp_chan_setup_q2vsi(void *priv, u16 vsi_id)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
@@ -569,8 +594,7 @@ static void nbl_disp_chan_clear_flow_req(void *priv, u16 vsi_id)
 	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
 	struct nbl_chan_send_info chan_send = {0};
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_FLOW, &vsi_id, sizeof(vsi_id),
-		      NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CLEAR_FLOW, &vsi_id, sizeof(vsi_id), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -595,8 +619,7 @@ nbl_disp_chan_add_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
 	param.vlan = vlan_id;
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MACVLAN,
-		      &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MACVLAN, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -621,8 +644,7 @@ nbl_disp_chan_del_macvlan_req(void *priv, u8 *mac, u16 vlan_id, u16 vsi_id)
 	param.vlan = vlan_id;
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MACVLAN,
-		      &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MACVLAN, &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -643,8 +665,7 @@ static int nbl_disp_chan_add_multi_rule_req(void *priv, u16 vsi_id)
 
 	param.vsi = vsi_id;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MULTI_RULE,
-		      &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_ADD_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
 	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -665,8 +686,74 @@ static void nbl_disp_chan_del_multi_rule_req(void *priv, u16 vsi)
 
 	param.vsi = vsi;
 
-	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MULTI_RULE,
-		      &param, sizeof(param), NULL, 0, 1);
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_DEL_MULTI_RULE, &param, sizeof(param), NULL, 0, 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_cfg_dsch(void *priv, u16 vsi_id, bool vld)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->cfg_dsch, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, vld));
+}
+
+static int nbl_disp_chan_cfg_dsch_req(void *priv, u16 vsi_id, bool vld)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_dsch param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+	param.vld = vld;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_CFG_DSCH, &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_setup_cqs(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	return NBL_OPS_CALL(res_ops->setup_cqs,
+			    (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, real_qps, rss_indir_set));
+}
+
+static int nbl_disp_chan_setup_cqs_req(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_setup_cqs param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+	param.real_qps = real_qps;
+	param.rss_indir_set = rss_indir_set;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_SETUP_CQS, &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static void nbl_disp_remove_cqs(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	NBL_OPS_CALL(res_ops->remove_cqs, (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id));
+}
+
+static void nbl_disp_chan_remove_cqs_req(void *priv, u16 vsi_id)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_remove_cqs param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	param.vsi_id = vsi_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_REMOVE_CQS, &param, sizeof(param), NULL, 0, 1);
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
@@ -747,6 +834,11 @@ do {									\
 	NBL_DISP_SET_OPS(get_eth_id, nbl_disp_get_eth_id,		\
 			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_GET_ETH_ID,\
 			 nbl_disp_chan_get_eth_id_req, NULL);		\
+	NBL_DISP_SET_OPS(get_vsi_global_qid,				\
+			 nbl_disp_get_vsi_global_qid,			\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,		\
+			 nbl_disp_chan_get_vsi_global_qid_req, NULL);	\
 	NBL_DISP_SET_OPS(setup_q2vsi, nbl_disp_chan_setup_q2vsi,	\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_SETUP_Q2VSI,			\
@@ -789,6 +881,15 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_DEL_MULTI_RULE,			\
 			 nbl_disp_chan_del_multi_rule_req, NULL);	\
+	NBL_DISP_SET_OPS(cfg_dsch, nbl_disp_cfg_dsch,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_CFG_DSCH,	\
+			 nbl_disp_chan_cfg_dsch_req, NULL);		\
+	NBL_DISP_SET_OPS(setup_cqs, nbl_disp_setup_cqs,			\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_SETUP_CQS,	\
+			 nbl_disp_chan_setup_cqs_req, NULL);		\
+	NBL_DISP_SET_OPS(remove_cqs, nbl_disp_remove_cqs,		\
+			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_REMOVE_CQS,\
+			 nbl_disp_chan_remove_cqs_req, NULL);		\
 } while (0)
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 97240d4fcc..a25d493b6d 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -56,7 +56,7 @@ static void nbl_res_txrx_stop_tx_ring(void *priv, u16 queue_idx)
 		tx_ring->desc[i].flags = 0;
 	}
 
-	tx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	tx_ring->avail_used_flags = NBL_PACKED_DESC_F_AVAIL_BIT;
 	tx_ring->used_wrap_counter = 1;
 	tx_ring->next_to_clean = NBL_TX_RS_THRESH - 1;
 	tx_ring->next_to_use = 0;
@@ -166,7 +166,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	tx_ring->notify_qid =
 		(res_mgt->res_info.base_qid + txrx_mgt->queue_offset + param->queue_idx) * 2 + 1;
 	tx_ring->ring_phys_addr = (u64)NBL_DMA_ADDRESS_FULL_TRANSLATE(common, memzone->iova);
-	tx_ring->avail_used_flags = BIT(NBL_PACKED_DESC_F_AVAIL);
+	tx_ring->avail_used_flags = NBL_PACKED_DESC_F_AVAIL_BIT;
 	tx_ring->used_wrap_counter = 1;
 	tx_ring->next_to_clean = NBL_TX_RS_THRESH - 1;
 	tx_ring->next_to_use = 0;
@@ -312,8 +312,62 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 
 static int nbl_res_alloc_rx_bufs(void *priv, u16 queue_idx)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(queue_idx);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_res_rx_ring *rxq = NBL_RES_MGT_TO_RX_RING(res_mgt, queue_idx);
+	struct nbl_rx_entry *rx_entry = rxq->rx_entry;
+	volatile struct nbl_packed_desc *rx_desc;
+	struct nbl_rx_entry *rxe;
+	struct rte_mbuf *mbuf;
+	u64 dma_addr;
+	int i;
+	u32 frame_size = rxq->eth_dev->data->mtu + NBL_ETH_OVERHEAD + rxq->exthdr_len;
+	u16 buf_length;
+
+	rxq->avail_used_flags = NBL_PACKED_DESC_F_AVAIL_BIT | NBL_PACKED_DESC_F_WRITE_BIT;
+	rxq->used_wrap_counter = 1;
+
+	for (i = 0; i < rxq->nb_desc; i++) {
+		mbuf = rte_mbuf_raw_alloc(rxq->mempool);
+		if (mbuf == NULL) {
+			NBL_LOG(ERR, "RX mbuf alloc failed for queue %u", rxq->queue_id);
+			return -ENOMEM;
+		}
+		dma_addr = NBL_DMA_ADDRESS_FULL_TRANSLATE(rxq, rte_mbuf_data_iova_default(mbuf));
+		rx_desc = &rxq->desc[i];
+		rxe = &rx_entry[i];
+		rx_desc->addr = dma_addr;
+		rx_desc->len = mbuf->buf_len - RTE_PKTMBUF_HEADROOM;
+		rx_desc->flags = rxq->avail_used_flags;
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+		rxe->mbuf = mbuf;
+	}
+
+	rxq->next_to_clean = 0;
+	rxq->next_to_use = 0;
+	rxq->vq_free_cnt = 0;
+	rxq->avail_used_flags ^= NBL_PACKED_DESC_F_AVAIL_USED;
+
+	buf_length = rte_pktmbuf_data_room_size(rxq->mempool) - RTE_PKTMBUF_HEADROOM;
+	if (buf_length >= NBL_BUF_LEN_16K) {
+		rxq->buf_length = NBL_BUF_LEN_16K;
+	} else if (buf_length >= NBL_BUF_LEN_8K) {
+		rxq->buf_length = NBL_BUF_LEN_8K;
+	} else if (buf_length >= NBL_BUF_LEN_4K) {
+		rxq->buf_length = NBL_BUF_LEN_4K;
+	} else if (buf_length >= NBL_BUF_LEN_2K) {
+		rxq->buf_length = NBL_BUF_LEN_2K;
+	} else {
+		NBL_LOG(ERR, "mempool mbuf length should be at least 2kB, but current value is %u",
+			buf_length);
+		nbl_res_txrx_stop_rx_ring(res_mgt, queue_idx);
+		return -EINVAL;
+	}
+
+	if (frame_size > rxq->buf_length)
+		rxq->eth_dev->data->scattered_rx = 1;
+
+	rxq->buf_length = rxq->buf_length - RTE_PKTMBUF_HEADROOM;
+
 	return 0;
 }
 
@@ -333,8 +387,14 @@ static void nbl_res_txrx_release_rx_ring(void *priv, u16 queue_idx)
 
 static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
 {
-	RTE_SET_USED(priv);
-	RTE_SET_USED(index);
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	struct nbl_res_rx_ring *rx_ring = NBL_RES_MGT_TO_RX_RING(res_mgt, index);
+
+	hw_ops->update_tail_ptr(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				 rx_ring->notify_qid,
+				 ((!!(rx_ring->avail_used_flags & NBL_PACKED_DESC_F_AVAIL_BIT)) |
+				 rx_ring->next_to_use));
 }
 
 /* NBL_TXRX_SET_OPS(ops_name, func)
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.h b/drivers/net/nbl/nbl_hw/nbl_txrx.h
index 197da844ab..9f7bcec5c3 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.h
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.h
@@ -7,15 +7,25 @@
 
 #include "nbl_resource.h"
 
+#define NBL_PACKED_DESC_F_NEXT			(0)
+#define NBL_PACKED_DESC_F_WRITE			(1)
 #define NBL_PACKED_DESC_F_AVAIL			(7)
 #define NBL_PACKED_DESC_F_USED			(15)
-#define NBL_VRING_DESC_F_NEXT			(1 << 0)
-#define NBL_VRING_DESC_F_WRITE			(1 << 1)
+#define NBL_PACKED_DESC_F_NEXT_BIT		(1 << NBL_PACKED_DESC_F_NEXT)
+#define NBL_PACKED_DESC_F_WRITE_BIT		(1 << NBL_PACKED_DESC_F_WRITE)
+#define NBL_PACKED_DESC_F_AVAIL_BIT		(1 << NBL_PACKED_DESC_F_AVAIL)
+#define NBL_PACKED_DESC_F_USED_BIT		(1 << NBL_PACKED_DESC_F_USED)
+#define NBL_PACKED_DESC_F_AVAIL_USED		(NBL_PACKED_DESC_F_AVAIL_BIT | \
+						 NBL_PACKED_DESC_F_USED_BIT)
 
 #define NBL_TX_RS_THRESH			(32)
 #define NBL_TX_HEADER_LEN			(32)
 #define NBL_VQ_HDR_NAME_MAXSIZE			(32)
 
 #define NBL_DESC_PER_LOOP_VEC_MAX		(8)
+#define NBL_BUF_LEN_16K				(16384)
+#define NBL_BUF_LEN_8K				(8192)
+#define NBL_BUF_LEN_4K				(4096)
+#define NBL_BUF_LEN_2K				(2048)
 
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 0c90a5db18..935e4e66b1 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -336,6 +336,11 @@ struct nbl_chan_param_get_eth_id {
 	u8 logic_eth_id;
 };
 
+struct nbl_chan_vsi_qid_info {
+	u16 vsi_id;
+	u16 local_qid;
+};
+
 struct nbl_chan_param_register_vsi2q {
 	u16 vsi_index;
 	u16 vsi_id;
@@ -365,6 +370,21 @@ struct nbl_chan_param_del_multi_rule {
 	u16 vsi;
 };
 
+struct nbl_chan_param_cfg_dsch {
+	u16 vsi_id;
+	bool vld;
+};
+
+struct nbl_chan_param_setup_cqs {
+	u16 vsi_id;
+	u16 real_qps;
+	bool rss_indir_set;
+};
+
+struct nbl_chan_param_remove_cqs {
+	u16 vsi_id;
+};
+
 struct nbl_chan_send_info {
 	uint16_t dstid;
 	uint16_t msg_type;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 14823dd998..bd2c844dfa 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -21,11 +21,15 @@
 #define NBL_DEV_USER_TYPE	('n')
 #define NBL_DEV_USER_DATA_LEN	(2044)
 
-#define NBL_DEV_USER_PCI_OFFSET_SHIFT		40
+#define NBL_DEV_USER_PCI_OFFSET_SHIFT		(40)
 #define NBL_DEV_USER_OFFSET_TO_INDEX(off)	((off) >> NBL_DEV_USER_PCI_OFFSET_SHIFT)
 #define NBL_DEV_USER_INDEX_TO_OFFSET(index)	((u64)(index) << NBL_DEV_USER_PCI_OFFSET_SHIFT)
 #define NBL_DEV_SHM_MSG_RING_INDEX		(6)
 
+#define NBL_VLAN_TAG_SIZE			(4)
+#define NBL_ETH_OVERHEAD \
+	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + NBL_VLAN_TAG_SIZE * 2)
+
 struct nbl_dev_user_channel_msg {
 	u16 msg_type;
 	u16 dst_id;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index 3a1139d76a..a6f5ffe585 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -63,7 +63,7 @@ struct nbl_dispatch_ops {
 	int (*setup_rss)(void *priv, u16 vsi_id);
 	void (*remove_rss)(void *priv, u16 vsi_id);
 	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
-	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
 	void (*remove_cqs)(void *priv, u16 vsi_id);
 	int (*set_rxfh_indir)(void *priv, u16 vsi_id, u32 *indir, u32 indir_size);
 	void (*clear_queues)(void *priv, u16 vsi_id);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 775f5813ea..8f14c3be72 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -22,6 +22,7 @@ struct nbl_resource_ops {
 	int (*unregister_net)(void *priv);
 	u16 (*get_vsi_id)(void *priv);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id);
+	u16 (*get_vsi_global_qid)(void *priv, u16 vsi_id, u16 local_qid);
 	int (*setup_q2vsi)(void *priv, u16 vsi_id);
 	void (*remove_q2vsi)(void *priv, u16 vsi_id);
 	int (*register_vsi2q)(void *priv, u16 vsi_index, u16 vsi_id,
@@ -61,6 +62,9 @@ struct nbl_resource_ops {
 	void (*del_multi_rule)(void *priv, u16 vsi_id);
 	int (*cfg_multi_mcast)(void *priv, u16 vsi_id, u16 enable);
 	void (*clear_flow)(void *priv, u16 vsi_id);
+	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
+	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
+	void (*remove_cqs)(void *priv, u16 vsi_id);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 823498d48f..d994347a7f 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -51,7 +51,9 @@ typedef int16_t s16;
 typedef int8_t s8;
 
 /* Used for macros to pass checkpatch */
-#define NBL_NAME(x)					x
+#define NBL_NAME(x)				x
+#define BIT(a)					(1 << (a))
+#define NBL_SAFE_THREADS_WAIT_TIME		(20)
 
 enum {
 	NBL_VSI_DATA = 0,	/* default vsi in kernel or independent dpdk */
@@ -71,8 +73,6 @@ struct nbl_func_caps {
 	u32 rsv:31;
 };
 
-#define BIT(a)			(1 << (a))
-
 struct nbl_start_rx_ring_param {
 	u16 queue_idx;
 	u16 nb_desc;
@@ -130,9 +130,10 @@ struct nbl_common_info {
 	/* curr_network 0 means kernel network, 1 means user network */
 	u8 curr_network:1;
 	u8 is_vf:1;
+	u8 pf_start:1;
 	u8 specific_dma:1;
 	u8 dma_set_msb:1;
-	u8 rsv:3;
+	u8 rsv:2;
 	struct nbl_board_port_info board_info;
 };
 
-- 
2.34.1

