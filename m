Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B739CCA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 06:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15BBE40E03;
	Wed, 13 Aug 2025 08:44:55 +0200 (CEST)
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com
 [115.124.28.50]) by mails.dpdk.org (Postfix) with ESMTP id E84D040A6E
 for <dev@dpdk.org>; Wed, 13 Aug 2025 08:44:40 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eELCnnx_1755067478 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 13 Aug 2025 14:44:38 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 14/16] net/nbl: add nbl device Tx and Rx burst
Date: Tue, 12 Aug 2025 23:44:08 -0700
Message-Id: <20250813064410.3894506-15-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
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

Implement NBL device Tx and Rx burst

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 104 +++++-
 drivers/net/nbl/nbl_dev/nbl_dev.h             |   8 +
 drivers/net/nbl/nbl_dispatch.c                |  62 ++++
 drivers/net/nbl/nbl_ethdev.c                  |   9 +-
 drivers/net/nbl/nbl_ethdev.h                  |  19 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c |   1 +
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   2 +
 drivers/net/nbl/nbl_hw/nbl_txrx.c             | 325 ++++++++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.h             |  19 +-
 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h         |  91 +++++
 drivers/net/nbl/nbl_include/nbl_def_channel.h |   4 +
 drivers/net/nbl/nbl_include/nbl_def_common.h  |   1 +
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |   3 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |   7 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  31 ++
 15 files changed, 679 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_txrx_ops.h

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 54e15757eb..b32ab839d5 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -289,6 +289,98 @@ void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 	disp_ops->release_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), queue_id);
 }
 
+int nbl_dev_infos_get(struct rte_eth_dev *eth_dev __rte_unused, struct rte_eth_dev_info *dev_info)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ring_mgt *ring_mgt = &dev_mgt->net_dev->ring_mgt;
+	struct nbl_board_port_info *board_info = &dev_mgt->common->board_info;
+	u8 speed_mode = board_info->speed;
+
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+	dev_info->max_mtu = NBL_MAX_JUMBO_FRAME_SIZE - NBL_PKT_HDR_PAD;
+	dev_info->max_rx_pktlen = NBL_FRAME_SIZE_MAX;
+	dev_info->max_mac_addrs = dev_mgt->net_dev->max_mac_num;
+	dev_info->max_rx_queues = ring_mgt->rx_ring_num;
+	dev_info->max_tx_queues = ring_mgt->tx_ring_num;
+	/* rx buffer size must be 2KB, 4KB, 8KB or 16KB */
+	dev_info->min_rx_bufsize = NBL_DEV_MIN_RX_BUFSIZE;
+	dev_info->flow_type_rss_offloads = NBL_RSS_OFFLOAD_TYPE;
+
+	dev_info->hash_key_size = NBL_EPRO_RSS_SK_SIZE;
+
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = 32768,
+		.nb_min = 128,
+		.nb_align = 1,
+		.nb_seg_max = 128,
+		.nb_mtu_seg_max = 128,
+	};
+
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = 32768,
+		.nb_min = 128,
+		.nb_align = 1,
+		.nb_seg_max = 128,
+		.nb_mtu_seg_max = 128,
+	};
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G;
+	dev_info->max_rx_pktlen = NBL_FRAME_SIZE_MAX;
+
+	dev_info->default_rxportconf.nb_queues = ring_mgt->rx_ring_num;
+	dev_info->default_txportconf.nb_queues = ring_mgt->tx_ring_num;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				    RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				    RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				    RTE_ETH_TX_OFFLOAD_UDP_TSO |
+				    RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_CHECKSUM |
+				    RTE_ETH_RX_OFFLOAD_SCATTER;
+
+	switch (speed_mode) {
+	case NBL_FW_PORT_SPEED_100G:
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_100G;
+		/* FALLTHROUGH */
+	case NBL_FW_PORT_SPEED_50G:
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_50G;
+		/* FALLTHROUGH */
+	case NBL_FW_PORT_SPEED_25G:
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_25G;
+		/* FALLTHROUGH */
+	case NBL_FW_PORT_SPEED_10G:
+		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_10G;
+		break;
+	default:
+		dev_info->speed_capa = RTE_ETH_LINK_SPEED_25G;
+	}
+
+	return 0;
+}
+
+int nbl_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct rte_eth_link link = { 0 };
+
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	link.link_status = !!dev_mgt->net_dev->eth_link_info.link_status;
+	if (link.link_status)
+		link.link_speed = dev_mgt->net_dev->eth_link_info.link_speed;
+
+	return rte_eth_linkstatus_set(eth_dev, &link);
+}
+
+int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats)
+{
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+
+	return disp_ops->get_stats(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), rte_stats);
+}
+
 struct nbl_dev_ops dev_ops = {
 };
 
@@ -404,12 +496,17 @@ static int nbl_dev_leonis_start(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
 	int ret = 0;
 
 	dev_mgt->common = NBL_ADAPTER_TO_COMMON(adapter);
 	ret = nbl_dev_common_start(dev_mgt);
 	if (ret)
 		return ret;
+
+	disp_ops->get_link_state(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt),
+				 dev_mgt->net_dev->eth_id,
+				 &dev_mgt->net_dev->eth_link_info);
 	return 0;
 }
 
@@ -606,7 +703,7 @@ static int nbl_dev_setup_net_dev(struct nbl_dev_mgt *dev_mgt,
 	return ret;
 }
 
-int nbl_dev_init(void *p, __rte_unused struct rte_eth_dev *eth_dev)
+int nbl_dev_init(void *p, struct rte_eth_dev *eth_dev)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 	struct nbl_dev_mgt **dev_mgt;
@@ -660,6 +757,11 @@ int nbl_dev_init(void *p, __rte_unused struct rte_eth_dev *eth_dev)
 			       eth_dev->data->mac_addrs[0].addr_bytes);
 
 	adapter->state = NBL_ETHDEV_INITIALIZED;
+	disp_ops->get_resource_pt_ops(NBL_DEV_MGT_TO_DISP_PRIV(*dev_mgt),
+				      &(*dev_mgt)->pt_ops, 0);
+
+	eth_dev->tx_pkt_burst = (*dev_mgt)->pt_ops.tx_pkt_burst;
+	eth_dev->rx_pkt_burst = (*dev_mgt)->pt_ops.rx_pkt_burst;
 
 	return 0;
 
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index dca2233749..577a28b32d 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -17,6 +17,9 @@
 #define NBL_DEV_MGT_TO_ETH_DEV(dev_mgt)		((dev_mgt)->net_dev->eth_dev)
 #define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
 
+#define NBL_FRAME_SIZE_MAX		(9600)
+#define NBL_DEV_MIN_RX_BUFSIZE	2048
+
 struct nbl_dev_ring {
 	u16 index;
 	u64 dma;
@@ -37,6 +40,7 @@ struct nbl_dev_ring_mgt {
 struct nbl_dev_net_mgt {
 	struct rte_eth_dev *eth_dev;
 	struct nbl_dev_ring_mgt ring_mgt;
+	struct nbl_eth_link_info eth_link_info;
 	u16 vsi_id;
 	u8 eth_mode;
 	u8 eth_id;
@@ -49,6 +53,7 @@ struct nbl_dev_mgt {
 	struct nbl_channel_ops_tbl *chan_ops_tbl;
 	struct nbl_dev_net_mgt *net_dev;
 	struct nbl_common_info *common;
+	struct nbl_resource_pt_ops pt_ops;
 };
 
 struct nbl_product_dev_ops *nbl_dev_get_product_ops(enum nbl_product_type product_type);
@@ -63,5 +68,8 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool);
 void nbl_tx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
 void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
+int nbl_dev_infos_get(struct rte_eth_dev *eth_dev __rte_unused, struct rte_eth_dev_info *dev_info);
+int nbl_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused);
+int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats);
 
 #endif
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index cec164ed5a..9382b76ce6 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -761,6 +761,57 @@ static void nbl_disp_chan_remove_cqs_req(void *priv, u16 vsi_id)
 	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
 }
 
+static void nbl_disp_get_res_pt_ops(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	NBL_OPS_CALL(res_ops->get_resource_pt_ops,
+		     (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), pt_ops, offload));
+}
+
+static void nbl_disp_get_link_state(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+
+	/* if do not have res_ops->get_link_state(), default eth is up */
+	if (res_ops->get_link_state) {
+		res_ops->get_link_state(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt),
+					eth_id, eth_link_info);
+	} else {
+		eth_link_info->link_status = 1;
+		eth_link_info->link_speed = RTE_ETH_LINK_SPEED_25G;
+	}
+}
+
+static void nbl_disp_chan_get_link_state_req(void *priv, u8 eth_id,
+					     struct nbl_eth_link_info *eth_link_info)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_chan_param_get_link_state param = {0};
+	struct nbl_chan_send_info chan_send;
+
+	chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+
+	param.eth_id = eth_id;
+
+	NBL_CHAN_SEND(chan_send, 0, NBL_CHAN_MSG_GET_LINK_STATE, &param, sizeof(param),
+		      eth_link_info, sizeof(*eth_link_info), 1);
+	chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
+static int nbl_disp_get_stats(void *priv, struct rte_eth_stats *rte_stats)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	return res_ops->get_stats(NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), rte_stats);
+}
+
 #define NBL_DISP_OPS_TBL						\
 do {									\
 	NBL_DISP_SET_OPS(configure_msix_map, nbl_disp_configure_msix_map,			\
@@ -894,6 +945,17 @@ do {									\
 	NBL_DISP_SET_OPS(remove_cqs, nbl_disp_remove_cqs,		\
 			 NBL_DISP_CTRL_LVL_MGT, NBL_CHAN_MSG_REMOVE_CQS,\
 			 nbl_disp_chan_remove_cqs_req, NULL);		\
+	NBL_DISP_SET_OPS(get_resource_pt_ops,				\
+			 nbl_disp_get_res_pt_ops,			\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
+	NBL_DISP_SET_OPS(get_link_state, nbl_disp_get_link_state,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_GET_LINK_STATE,			\
+			 nbl_disp_chan_get_link_state_req, NULL);	\
+	NBL_DISP_SET_OPS(get_stats, nbl_disp_get_stats,			\
+			 NBL_DISP_CTRL_LVL_ALWAYS, -1,			\
+			 NULL, NULL);					\
 } while (0)
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index 4113a81ac1..f30aca2b7f 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -11,15 +11,11 @@ RTE_LOG_REGISTER_SUFFIX(nbl_logtype_driver, driver, INFO);
 static int nbl_dev_release_pf(struct rte_eth_dev *eth_dev)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
-	struct nbl_dev_ops_tbl *dev_ops_tbl;
-	struct nbl_dev_ops *dev_ops;
 
 	if (!adapter)
 		return -EINVAL;
 	NBL_LOG(INFO, "start to close device %s", eth_dev->device->name);
-	dev_ops_tbl = NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
-	dev_ops = NBL_DEV_OPS_TBL_TO_OPS(dev_ops_tbl);
-	dev_ops->dev_close(eth_dev);
+	nbl_dev_port_close(eth_dev);
 	nbl_core_stop(adapter);
 	nbl_core_remove(adapter);
 	return 0;
@@ -42,6 +38,9 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.rx_queue_setup = nbl_rx_queue_setup,
 	.tx_queue_release = nbl_tx_queues_release,
 	.rx_queue_release = nbl_rx_queues_release,
+	.dev_infos_get = nbl_dev_infos_get,
+	.link_update = nbl_link_update,
+	.stats_get = nbl_stats_get,
 };
 
 static int nbl_eth_dev_init(struct rte_eth_dev *eth_dev)
diff --git a/drivers/net/nbl/nbl_ethdev.h b/drivers/net/nbl/nbl_ethdev.h
index e20a7b940e..4d522746c0 100644
--- a/drivers/net/nbl/nbl_ethdev.h
+++ b/drivers/net/nbl/nbl_ethdev.h
@@ -10,4 +10,23 @@
 #define ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev) \
 	((struct nbl_adapter *)((eth_dev)->data->dev_private))
 
+#define NBL_MAX_JUMBO_FRAME_SIZE		(9600)
+#define NBL_PKT_HDR_PAD				(26)
+#define NBL_RSS_OFFLOAD_TYPE ( \
+	RTE_ETH_RSS_IPV4 | \
+	RTE_ETH_RSS_FRAG_IPV4 | \
+	RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_SCTP | \
+	RTE_ETH_RSS_NONFRAG_IPV4_OTHER | \
+	RTE_ETH_RSS_IPV6 | \
+	RTE_ETH_RSS_FRAG_IPV6 | \
+	RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_SCTP | \
+	RTE_ETH_RSS_NONFRAG_IPV6_OTHER | \
+	RTE_ETH_RSS_VXLAN | \
+	RTE_ETH_RSS_GENEVE | \
+	RTE_ETH_RSS_NVGRE)
+
 #endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
index b785774f67..e7036373f1 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_res_leonis.c
@@ -105,6 +105,7 @@ int nbl_res_init_leonis(void *p, struct rte_eth_dev *eth_dev)
 	NBL_RES_MGT_TO_CHAN_OPS_TBL(&(*res_mgt_leonis)->res_mgt) = chan_ops_tbl;
 	NBL_RES_MGT_TO_PHY_OPS_TBL(&(*res_mgt_leonis)->res_mgt) = phy_ops_tbl;
 	NBL_RES_MGT_TO_ETH_DEV(&(*res_mgt_leonis)->res_mgt) = eth_dev;
+	NBL_RES_MGT_TO_COMMON(&(*res_mgt_leonis)->res_mgt) = &adapter->common;
 
 	ret = nbl_res_start(*res_mgt_leonis);
 	if (ret)
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 543054a2cb..ad5ac22d61 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -46,6 +46,7 @@ struct nbl_res_tx_ring {
 	volatile uint8_t *notify;
 	struct rte_eth_dev *eth_dev;
 	struct nbl_common_info *common;
+	struct nbl_txq_stats txq_stats;
 	u64 default_hdr[2];
 
 	enum nbl_product_type product;
@@ -86,6 +87,7 @@ struct nbl_res_rx_ring {
 	volatile uint8_t *notify;
 	struct rte_eth_dev *eth_dev;
 	struct nbl_common_info *common;
+	struct nbl_rxq_stats rxq_stats;
 	uint64_t mbuf_initializer; /**< value to init mbufs */
 	struct rte_mbuf fake_mbuf;
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index e0791d2408..d0acbe867d 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -4,6 +4,7 @@
 
 #include "nbl_txrx.h"
 #include "nbl_include.h"
+#include "nbl_txrx_ops.h"
 
 static int nbl_res_txrx_alloc_rings(void *priv, u16 tx_num, u16 rx_num, u16 queue_offset)
 {
@@ -397,6 +398,328 @@ static void nbl_res_txrx_update_rx_ring(void *priv, u16 index)
 				 rx_ring->next_to_use));
 }
 
+static inline void nbl_fill_rx_ring(struct nbl_res_rx_ring *rxq,
+				    struct rte_mbuf **cookie, uint16_t fill_num)
+{
+	volatile struct nbl_packed_desc *rx_desc;
+	struct nbl_rx_entry *rx_entry;
+	uint64_t dma_addr;
+	uint16_t desc_index, i, flags;
+
+	desc_index = rxq->next_to_use;
+	for (i = 0; i < fill_num; i++) {
+		rx_desc = &rxq->desc[desc_index];
+		rx_entry = &rxq->rx_entry[desc_index];
+		rx_entry->mbuf = cookie[i];
+
+		flags = rxq->avail_used_flags;
+		desc_index++;
+		if (desc_index >= rxq->nb_desc) {
+			desc_index = 0;
+			rxq->avail_used_flags ^= NBL_PACKED_DESC_F_AVAIL_USED;
+		}
+		if ((desc_index & 0x3) == 0) {
+			rte_prefetch0(&rxq->rx_entry[desc_index]);
+			rte_prefetch0(&rxq->desc[desc_index]);
+		}
+
+		cookie[i]->data_off = RTE_PKTMBUF_HEADROOM;
+		rx_desc->len =
+			rte_cpu_to_le_32(cookie[i]->buf_len - RTE_PKTMBUF_HEADROOM);
+		dma_addr = NBL_DMA_ADDERSS_FULL_TRANSLATE(rxq,
+							  rte_mbuf_data_iova_default(cookie[i]));
+		rx_desc->addr = rte_cpu_to_le_64(dma_addr);
+
+		rte_io_wmb();
+		rx_desc->flags = flags;
+	}
+
+	rxq->vq_free_cnt -= fill_num;
+	rxq->next_to_use = desc_index;
+}
+
+static u16
+nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u16 extend_set)
+{
+	struct nbl_res_tx_ring *txq;
+	union nbl_tx_extend_head *tx_region;
+	volatile struct nbl_packed_desc *tx_ring;
+	struct nbl_tx_entry *sw_ring;
+	volatile struct nbl_packed_desc *tx_desc, *head_desc;
+	struct nbl_tx_entry *txe;
+	struct rte_mbuf *tx_pkt;
+	union nbl_tx_extend_head *u;
+	rte_iova_t net_hdr_mem;
+	uint64_t dma_addr;
+	u16 nb_xmit_pkts;
+	u16 desc_index, head_index, head_flags;
+	u16 data_len, header_len = 0;
+	u16 nb_descs;
+	u16 can_push;
+	u16 required_headroom;
+	u16 tx_extend_len;
+	u16 addr_offset;
+
+	txq = tx_queue;
+	tx_ring = txq->desc;
+	sw_ring = txq->tx_entry;
+	desc_index = txq->next_to_use;
+	txe = &sw_ring[txq->next_to_use];
+	tx_region = txq->net_hdr_mz->addr;
+	net_hdr_mem = NBL_DMA_ADDERSS_FULL_TRANSLATE(txq, txq->net_hdr_mz->iova);
+
+	if (txq->vq_free_cnt < NBL_TX_FREE_THRESH)
+		nbl_tx_free_bufs(txq);
+
+	for (nb_xmit_pkts = 0; nb_xmit_pkts < nb_pkts; nb_xmit_pkts++) {
+		required_headroom = txq->exthdr_len;
+		tx_extend_len = txq->exthdr_len;
+		addr_offset = 0;
+
+		tx_pkt = *tx_pkts++;
+		if (txq->vlan_tci && txq->vlan_proto) {
+			required_headroom += sizeof(struct rte_vlan_hdr);
+			/* extend_hdr + ether_hdr + vlan_hdr */
+			tx_extend_len = required_headroom + sizeof(struct rte_ether_hdr);
+		}
+
+		if (rte_pktmbuf_headroom(tx_pkt) >= required_headroom) {
+			can_push = 1;
+			u = rte_pktmbuf_mtod_offset(tx_pkt, union nbl_tx_extend_head *,
+						    -required_headroom);
+		} else {
+			can_push = 0;
+			u = (union nbl_tx_extend_head *)(&tx_region[desc_index]);
+		}
+		nb_descs = !can_push + tx_pkt->nb_segs;
+
+		if (nb_descs > txq->vq_free_cnt) {
+			/* need retry */
+			nbl_tx_free_bufs(txq);
+			if (nb_descs > txq->vq_free_cnt)
+				goto exit;
+		}
+
+		head_index = desc_index;
+		head_desc = &tx_ring[desc_index];
+		txe = &sw_ring[desc_index];
+
+		if (!extend_set)
+			memcpy(u, &txq->default_hdr, txq->exthdr_len);
+
+		if (txq->offloads)
+			header_len = txq->prep_tx_ehdr(u, tx_pkt);
+
+		head_flags = txq->avail_used_flags;
+		head_desc->id = tx_pkt->tso_segsz;
+
+		/* add next tx desc to tx list */
+		if (!can_push) {
+			head_flags |= NBL_VRING_DESC_F_NEXT;
+			txe->mbuf = NULL;
+			/* padding */
+			head_desc->addr = net_hdr_mem +
+					RTE_PTR_DIFF(&tx_region[desc_index], tx_region);
+			head_desc->len = tx_extend_len;
+			txe->first_id = head_index;
+			desc_index++;
+			txq->vq_free_cnt--;
+			if (desc_index >= txq->nb_desc) {
+				desc_index = 0;
+				txq->avail_used_flags ^= NBL_PACKED_DESC_F_AVAIL_USED;
+			}
+		}
+
+		do {
+			tx_desc = &tx_ring[desc_index];
+			txe = &sw_ring[desc_index];
+			txe->mbuf = tx_pkt;
+
+			data_len = tx_pkt->data_len;
+			dma_addr = rte_mbuf_data_iova(tx_pkt);
+			tx_desc->addr = NBL_DMA_ADDERSS_FULL_TRANSLATE(txq, dma_addr) + addr_offset;
+			tx_desc->len = data_len - addr_offset;
+			addr_offset = 0;
+
+			if (desc_index == head_index) {
+				tx_desc->addr -= txq->exthdr_len;
+				tx_desc->len += txq->exthdr_len;
+			} else {
+				tx_desc->flags = txq->avail_used_flags | NBL_VRING_DESC_F_NEXT;
+				head_flags |= NBL_VRING_DESC_F_NEXT;
+			}
+
+			tx_pkt = tx_pkt->next;
+			txe->first_id = head_index;
+			desc_index++;
+			txq->vq_free_cnt--;
+			if (desc_index >= txq->nb_desc) {
+				desc_index = 0;
+				txq->avail_used_flags ^= NBL_PACKED_DESC_F_AVAIL_USED;
+			}
+		} while (tx_pkt);
+		tx_desc->flags &= ~(u16)NBL_VRING_DESC_F_NEXT;
+		head_desc->len += (header_len << NBL_TX_TOTAL_HEADERLEN_SHIFT);
+		rte_io_wmb();
+		head_desc->flags = head_flags;
+		txq->next_to_use = desc_index;
+	}
+
+exit:
+	/* kick hw_notify_addr */
+	rte_write32(txq->notify_qid, txq->notify);
+	txq->txq_stats.tx_packets += nb_xmit_pkts;
+	return nb_xmit_pkts;
+}
+
+static u16
+nbl_res_txrx_pf_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	return nbl_res_txrx_xmit_pkts(tx_queue, tx_pkts, nb_pkts, 0);
+}
+
+static u16
+nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	struct nbl_res_rx_ring *rxq;
+	volatile struct nbl_packed_desc *rx_ring;
+	volatile struct nbl_packed_desc *rx_desc;
+	struct nbl_rx_entry *sw_ring;
+	struct nbl_rx_entry *rx_entry;
+	struct rte_mbuf *rx_mbuf, *last_mbuf;
+	uint32_t num_sg = 0;
+	uint16_t nb_recv_pkts = 0;
+	uint16_t desc_index;
+	uint16_t fill_num;
+	volatile union nbl_rx_extend_head *rx_ext_hdr;
+	int drop;
+	struct rte_mbuf *new_pkts[NBL_RXQ_REARM_THRESH];
+
+	rxq = rx_queue;
+	rx_ring = rxq->desc;
+	sw_ring = rxq->rx_entry;
+	desc_index = rxq->next_to_clean;
+	while (nb_recv_pkts < nb_pkts) {
+		rx_desc = &rx_ring[desc_index];
+		rx_entry = &sw_ring[desc_index];
+		drop = 0;
+
+		if (!desc_is_used(rx_desc, rxq->used_wrap_counter))
+			break;
+
+		rte_io_rmb();
+		if (!num_sg) {
+			rx_mbuf = rx_entry->mbuf;
+			last_mbuf = rx_mbuf;
+
+			rx_ext_hdr = (union nbl_rx_extend_head *)((char *)rx_mbuf->buf_addr +
+								  RTE_PKTMBUF_HEADROOM);
+			num_sg = rx_ext_hdr->common.num_buffers;
+
+			rx_mbuf->nb_segs = num_sg;
+			rx_mbuf->data_len = rx_desc->len - rxq->exthdr_len;
+			rx_mbuf->pkt_len = rx_desc->len - rxq->exthdr_len;
+			rx_mbuf->port = rxq->port_id;
+			rx_mbuf->data_off = RTE_PKTMBUF_HEADROOM + rxq->exthdr_len;
+		} else {
+			last_mbuf->next = rx_entry->mbuf;
+			last_mbuf = rx_entry->mbuf;
+
+			last_mbuf->data_len = rx_desc->len;
+			last_mbuf->pkt_len = rx_desc->len;
+			last_mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+			rx_mbuf->pkt_len += rx_desc->len;
+		}
+
+		rxq->vq_free_cnt++;
+		desc_index++;
+
+		if (desc_index >= rxq->nb_desc) {
+			desc_index = 0;
+			rxq->used_wrap_counter ^= 1;
+		}
+
+		if (--num_sg)
+			continue;
+		if (drop) {
+			rte_pktmbuf_free(rx_mbuf);
+			continue;
+		}
+		rx_pkts[nb_recv_pkts++] = rx_mbuf;
+	}
+
+	/* BUG on duplicate pkt free */
+	if (unlikely(num_sg))
+		rte_pktmbuf_free(rx_mbuf);
+	/* clean memory */
+	rxq->next_to_clean = desc_index;
+	fill_num = rxq->vq_free_cnt;
+	/* to be continue: rx free thresh */
+	if (fill_num > NBL_RXQ_REARM_THRESH) {
+		if (likely(!rte_pktmbuf_alloc_bulk(rxq->mempool, new_pkts, NBL_RXQ_REARM_THRESH)))
+			nbl_fill_rx_ring(rxq, new_pkts, NBL_RXQ_REARM_THRESH);
+	}
+
+	rxq->rxq_stats.rx_packets += nb_recv_pkts;
+
+	return nb_recv_pkts;
+}
+
+static void nbl_res_get_pt_ops(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload)
+{
+	RTE_SET_USED(priv);
+	RTE_SET_USED(offload);
+	pt_ops->tx_pkt_burst = nbl_res_txrx_pf_xmit_pkts;
+	pt_ops->rx_pkt_burst = nbl_res_txrx_recv_pkts;
+}
+
+static int nbl_res_txrx_get_stats(void *priv, struct rte_eth_stats *rte_stats)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct rte_eth_dev *eth_dev = res_mgt->eth_dev;
+	struct nbl_res_rx_ring *rxq;
+	struct nbl_rxq_stats *rxq_stats;
+	struct nbl_res_tx_ring  *txq;
+	struct nbl_txq_stats *txq_stats;
+	uint32_t i;
+	uint16_t idx;
+
+	/* Add software counters. */
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
+		rxq = eth_dev->data->rx_queues[i];
+		if (unlikely(rxq  == NULL))
+			return -EINVAL;
+
+		rxq_stats = &rxq->rxq_stats;
+		idx = rxq->queue_id;
+
+		rte_stats->q_ipackets[idx] += rxq_stats->rx_packets;
+		rte_stats->q_ibytes[idx] += rxq_stats->rx_bytes;
+
+		rte_stats->ipackets += rxq_stats->rx_packets;
+		rte_stats->ibytes += rxq_stats->rx_bytes;
+		rte_stats->rx_nombuf += rxq_stats->rx_nombuf;
+		rte_stats->ierrors += rxq_stats->rx_ierror;
+	}
+
+	for (i = 0; i < eth_dev->data->nb_tx_queues; i++) {
+		txq = eth_dev->data->tx_queues[i];
+		if (unlikely(txq  == NULL))
+			return -EINVAL;
+		txq_stats = &txq->txq_stats;
+		idx = txq->queue_id;
+
+		rte_stats->q_opackets[idx] += txq_stats->tx_packets;
+		rte_stats->q_obytes[idx] += txq_stats->tx_bytes;
+
+		rte_stats->opackets += txq_stats->tx_packets;
+		rte_stats->obytes += txq_stats->tx_bytes;
+		rte_stats->oerrors += txq_stats->tx_errors;
+	}
+
+	return 0;
+}
+
 /* NBL_TXRX_SET_OPS(ops_name, func)
  *
  * Use X Macros to reduce setup and remove codes.
@@ -413,6 +736,8 @@ do {										\
 	NBL_TXRX_SET_OPS(stop_rx_ring, nbl_res_txrx_stop_rx_ring);		\
 	NBL_TXRX_SET_OPS(release_rx_ring, nbl_res_txrx_release_rx_ring);	\
 	NBL_TXRX_SET_OPS(update_rx_ring, nbl_res_txrx_update_rx_ring);		\
+	NBL_TXRX_SET_OPS(get_resource_pt_ops, nbl_res_get_pt_ops);		\
+	NBL_TXRX_SET_OPS(get_stats, nbl_res_txrx_get_stats);			\
 } while (0)
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.h b/drivers/net/nbl/nbl_hw/nbl_txrx.h
index 5cf6e83c3f..d0d4b6128d 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.h
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.h
@@ -18,10 +18,19 @@
 #define NBL_PACKED_DESC_F_AVAIL_USED		(NBL_PACKED_DESC_F_AVAIL_BIT | \
 						 NBL_PACKED_DESC_F_USED_BIT)
 
-#define NBL_TX_RS_THRESH			(32)
 #define NBL_TX_HEADER_LEN			(32)
 #define NBL_VQ_HDR_NAME_MAXSIZE			(32)
 
+#define NBL_VRING_DESC_F_NEXT			RTE_BIT64(0)
+#define NBL_VRING_DESC_F_WRITE			RTE_BIT64(1)
+#define NBL_FREE_DESC_THRES			16
+#define NBL_USED_DESC_THRES			32
+#define NBL_TX_TOTAL_HEADERLEN_SHIFT		24
+#define NBL_TX_FREE_THRESH			32
+#define NBL_TX_RS_THRESH			32
+
+#define NBL_RXQ_REARM_THRESH			32
+
 #define NBL_DESC_PER_LOOP_VEC_MAX		(8)
 #define NBL_BUF_LEN_16K				(16384)
 #define NBL_BUF_LEN_8K				(8192)
@@ -114,6 +123,14 @@ union nbl_rx_extend_head {
 		u32 num_buffers :8;
 		u32 hash_value;
 	} leonis;
+
+	struct nbl_rx_ehdr_common {
+		u32 dw0;
+		u32 dw1;
+		u32 dw2:24;
+		u32 num_buffers:8;
+		u32 dw3;
+	} common;
 };
 
 #endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h b/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
new file mode 100644
index 0000000000..2ab4b09683
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx_ops.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_TXRX_OPS_H_
+#define _NBL_TXRX_OPS_H_
+
+#define NBL_TX_MAX_FREE_BUF_SZ		64
+#define NBL_RXQ_REARM_THRESH		32
+
+static __rte_always_inline struct rte_mbuf *nbl_pktmbuf_prefree_seg(struct rte_mbuf *m)
+{
+	if (likely(m))
+		return rte_pktmbuf_prefree_seg(m);
+
+	return NULL;
+}
+
+static __rte_always_inline int
+desc_is_used(volatile struct nbl_packed_desc *desc, bool wrap_counter)
+{
+	uint16_t used, avail, flags;
+
+	flags = desc->flags;
+	used = !!(flags & NBL_PACKED_DESC_F_USED_BIT);
+	avail = !!(flags & NBL_PACKED_DESC_F_AVAIL_BIT);
+
+	return avail == used && used == wrap_counter;
+}
+
+static __rte_always_inline int
+nbl_tx_free_bufs(struct nbl_res_tx_ring *txq)
+{
+	struct rte_mbuf *m, *free[NBL_TX_MAX_FREE_BUF_SZ];
+	struct nbl_tx_entry *txep;
+	uint32_t n;
+	uint32_t i;
+	uint32_t next_to_clean;
+	int nb_free = 0;
+
+	next_to_clean = txq->tx_entry[txq->next_to_clean].first_id;
+	/* check DD bits on threshold descriptor */
+	if (!desc_is_used(&txq->desc[next_to_clean], txq->used_wrap_counter))
+		return 0;
+
+	n = 32;
+
+	 /* first buffer to free from S/W ring is at index
+	  * tx_next_dd - (tx_rs_thresh-1)
+	  */
+	/* consider headroom */
+	txep = &txq->tx_entry[txq->next_to_clean - (n - 1)];
+	m = nbl_pktmbuf_prefree_seg(txep[0].mbuf);
+	if (likely(m)) {
+		free[0] = m;
+		nb_free = 1;
+		for (i = 1; i < n; i++) {
+			m = nbl_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (likely(m)) {
+				if (likely(m->pool == free[0]->pool)) {
+					free[nb_free++] = m;
+				} else {
+					rte_mempool_put_bulk(free[0]->pool,
+							     (void *)free,
+							     nb_free);
+					free[0] = m;
+					nb_free = 1;
+				}
+			}
+		}
+		rte_mempool_put_bulk(free[0]->pool, (void **)free, nb_free);
+	} else {
+		for (i = 1; i < n; i++) {
+			m = nbl_pktmbuf_prefree_seg(txep[i].mbuf);
+			if (m)
+				rte_mempool_put(m->pool, m);
+		}
+	}
+
+	/* buffers were freed, update counters */
+	txq->vq_free_cnt = (uint16_t)(txq->vq_free_cnt + NBL_TX_RS_THRESH);
+	txq->next_to_clean = (uint16_t)(txq->next_to_clean + NBL_TX_RS_THRESH);
+	if (txq->next_to_clean >= txq->nb_desc) {
+		txq->next_to_clean = NBL_TX_RS_THRESH - 1;
+		txq->used_wrap_counter ^= 1;
+	}
+
+	return 32;
+}
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 9b331924dc..481a725a3d 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -381,6 +381,10 @@ struct nbl_chan_param_remove_cqs {
 	u16 vsi_id;
 };
 
+struct nbl_chan_param_get_link_state {
+	u8 eth_id;
+};
+
 struct nbl_chan_send_info {
 	uint16_t dstid;
 	uint16_t msg_type;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index 238c7139e3..75ba1777f1 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -17,6 +17,7 @@
 
 #define NBL_TWO_ETHERNET_MAX_MAC_NUM		(512)
 #define NBL_FOUR_ETHERNET_MAX_MAC_NUM		(1024)
+#define NBL_EPRO_RSS_SK_SIZE			(40)
 
 #define NBL_DEV_USER_TYPE	('n')
 #define NBL_DEV_USER_DATA_LEN	(2044)
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index a6f5ffe585..0139b37ad1 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -23,6 +23,7 @@ struct nbl_dispatch_ops {
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv);
 	int (*enable_mailbox_irq)(void *p, u16 vector_id, bool enable_msix);
+	void (*get_resource_pt_ops)(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload);
 	int (*register_net)(void *priv,
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
@@ -71,6 +72,8 @@ struct nbl_dispatch_ops {
 	u16 (*recv_pkts)(void *priv, void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts);
 	u16 (*get_vsi_global_qid)(void *priv, u16 vsi_id, u16 local_qid);
 	void (*get_board_info)(void *priv, struct nbl_board_port_info *board_info);
+	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
+	int (*get_stats)(void *priv, struct rte_eth_stats *rte_stats);
 
 	void (*dummy_func)(void *priv);
 };
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index 16773903dd..c14fdc773e 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -11,11 +11,17 @@
 #define NBL_RES_OPS_TBL_TO_OPS(res_ops_tbl)		((res_ops_tbl)->ops)
 #define NBL_RES_OPS_TBL_TO_PRIV(res_ops_tbl)		((res_ops_tbl)->priv)
 
+struct nbl_resource_pt_ops {
+	eth_rx_burst_t rx_pkt_burst;
+	eth_tx_burst_t tx_pkt_burst;
+};
+
 struct nbl_resource_ops {
 	int (*configure_msix_map)(void *priv, u16 func_id, u16 num_net_msix, u16 num_others_msix,
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv, u16 func_id);
 	int (*enable_mailbox_irq)(void *priv, u16 func_id, u16 vector_id, bool enable_msix);
+	void (*get_resource_pt_ops)(void *priv, struct nbl_resource_pt_ops *pt_ops, bool offload);
 	int (*register_net)(void *priv,
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
@@ -65,6 +71,7 @@ struct nbl_resource_ops {
 	int (*cfg_dsch)(void *priv, u16 vsi_id, bool vld);
 	int (*setup_cqs)(void *priv, u16 vsi_id, u16 real_qps, bool rss_indir_set);
 	void (*remove_cqs)(void *priv, u16 vsi_id);
+	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 4b2360a18d..14c41a0139 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -69,6 +69,13 @@ enum nbl_product_type {
 	NBL_PRODUCT_MAX,
 };
 
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
 struct nbl_func_caps {
 	enum nbl_product_type product_type;
 	u32 is_vf:1;
@@ -166,4 +173,28 @@ struct nbl_register_net_result {
 	bool trusted;
 };
 
+struct nbl_eth_link_info {
+	u8 link_status;
+	u32 link_speed;
+};
+
+struct nbl_rxq_stats {
+	uint64_t rx_packets;
+	uint64_t rx_bytes;
+	uint64_t rx_nombuf;
+	uint64_t rx_multi_descs;
+
+	uint64_t rx_ierror;
+	uint64_t rx_drop_noport;
+	uint64_t rx_drop_proto;
+};
+
+struct nbl_txq_stats {
+	uint64_t tx_packets;
+	uint64_t tx_bytes;
+	uint64_t tx_errors;
+	uint64_t tx_descs;
+	uint64_t tx_tso_packets;
+};
+
 #endif
-- 
2.34.1

