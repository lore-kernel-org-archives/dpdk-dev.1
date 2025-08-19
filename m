Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C09CA0EF5
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 10:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AECB40B98;
	Tue, 19 Aug 2025 12:23:28 +0200 (CEST)
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com
 [115.124.28.121])
 by mails.dpdk.org (Postfix) with ESMTP id 7DE6940669
 for <dev@dpdk.org>; Tue, 19 Aug 2025 12:23:15 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eJiaSXO_1755598993 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 19 Aug 2025 18:23:13 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v5 15/17] net/nbl: add nbl ethdev infos get
Date: Tue, 19 Aug 2025 03:22:35 -0700
Message-Id: <20250819102237.3067518-16-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
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

Implement NBL ethdev infos get functions

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c            | 55 ++++++++++++++++++++
 drivers/net/nbl/nbl_dev/nbl_dev.h            |  4 ++
 drivers/net/nbl/nbl_ethdev.c                 |  1 +
 drivers/net/nbl/nbl_ethdev.h                 | 19 +++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h |  2 +
 drivers/net/nbl/nbl_include/nbl_include.h    |  7 +++
 6 files changed, 88 insertions(+)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 0880f7313c..68b6d0a318 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -296,6 +296,61 @@ void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id)
 	disp_ops->release_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), queue_id);
 }
 
+int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_info)
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
+	dev_info->min_rx_bufsize = NBL_DEV_MIN_RX_BUFSIZE;
+	dev_info->flow_type_rss_offloads = NBL_RSS_OFFLOAD_TYPE;
+	dev_info->hash_key_size = NBL_EPRO_RSS_SK_SIZE;
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = 32768,
+		.nb_min = 128,
+		.nb_align = 1,
+		.nb_seg_max = 128,
+		.nb_mtu_seg_max = 128,
+	};
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = 32768,
+		.nb_min = 128,
+		.nb_align = 1,
+		.nb_seg_max = 128,
+		.nb_mtu_seg_max = 128,
+	};
+	dev_info->default_rxportconf.nb_queues = ring_mgt->rx_ring_num;
+	dev_info->default_txportconf.nb_queues = ring_mgt->tx_ring_num;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
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
 int nbl_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused)
 {
 	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(eth_dev);
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 49e91fe24f..78c36dbeaf 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -17,6 +17,9 @@
 #define NBL_DEV_MGT_TO_ETH_DEV(dev_mgt)		((dev_mgt)->net_dev->eth_dev)
 #define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
 
+#define NBL_FRAME_SIZE_MAX			(9600)
+#define NBL_DEV_MIN_RX_BUFSIZE			(2048)
+
 struct nbl_dev_ring {
 	u16 index;
 	u64 dma;
@@ -65,6 +68,7 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 		       const struct rte_eth_rxconf *conf, struct rte_mempool *mempool);
 void nbl_tx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
 void nbl_rx_queues_release(struct rte_eth_dev *eth_dev, uint16_t queue_id);
+int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_info);
 int nbl_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete __rte_unused);
 int nbl_stats_get(struct rte_eth_dev *eth_dev, struct rte_eth_stats *rte_stats);
 
diff --git a/drivers/net/nbl/nbl_ethdev.c b/drivers/net/nbl/nbl_ethdev.c
index c412525435..f30aca2b7f 100644
--- a/drivers/net/nbl/nbl_ethdev.c
+++ b/drivers/net/nbl/nbl_ethdev.c
@@ -38,6 +38,7 @@ const struct eth_dev_ops nbl_eth_dev_ops = {
 	.rx_queue_setup = nbl_rx_queue_setup,
 	.tx_queue_release = nbl_tx_queues_release,
 	.rx_queue_release = nbl_rx_queues_release,
+	.dev_infos_get = nbl_dev_infos_get,
 	.link_update = nbl_link_update,
 	.stats_get = nbl_stats_get,
 };
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
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
index bd2c844dfa..5480d30f0d 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -30,6 +30,8 @@
 #define NBL_ETH_OVERHEAD \
 	(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN + NBL_VLAN_TAG_SIZE * 2)
 
+#define NBL_EPRO_RSS_SK_SIZE			(40)
+
 struct nbl_dev_user_channel_msg {
 	u16 msg_type;
 	u16 dst_id;
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index ad726683e1..2fb65283fd 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -114,6 +114,13 @@ struct nbl_board_port_info {
 	u8 rsv[6];
 };
 
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
 struct nbl_common_info {
 	const struct rte_eth_dev *eth_dev;
 	u16 vsi_id;
-- 
2.34.1

