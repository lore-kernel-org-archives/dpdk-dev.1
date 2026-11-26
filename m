Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B7606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA93F406FF;
	Thu, 26 Nov 2026 08:34:53 +0100 (CET)
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com
 [115.124.28.49])
 by mails.dpdk.org (Postfix) with ESMTPS id CEBED40656
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:45 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00239096-3.47215e-05-0.997574;
 FP=9401261170686952664|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037034184;
 MF=dimon.zhao@nebula-matrix.com; NM=1; PH=DS; RN=4; RT=4; SR=0;
 TI=SMTPD_---.kAe1Yw1_1795678481; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Yw1_1795678481 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:42 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 10/11] net/nbl: support draco hardware VLAN offload
Date: Thu, 26 Nov 2026 15:34:27 +0800
Message-ID: <20261126073430.3168813-11-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Advertise VLAN insertion and stripping capabilities for draco PFs.
Fill the Tx extension header for hardware VLAN insertion and
report stripped VLAN metadata from the Rx extension header.

Configure Rx VLAN parsing through the VLAN offload callback using
mailbox requests to the managing PF. Provide a local dispatch
wrapper using the optional resource callback for the MGT path.

Keep the leonis software VLAN paths unchanged and update the
VLAN offload callback declaration to match its implementation.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c             | 31 ++++++++++++++-----
 drivers/net/nbl/nbl_dev/nbl_dev.h             |  2 +-
 drivers/net/nbl/nbl_dispatch.c                | 30 ++++++++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c             | 16 ++++++++--
 drivers/net/nbl/nbl_include/nbl_def_channel.h |  6 ++++
 .../net/nbl/nbl_include/nbl_def_dispatch.h    |  1 +
 .../net/nbl/nbl_include/nbl_def_resource.h    |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h     |  7 +++++
 8 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 531ac96..a5b1cda 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -81,7 +81,8 @@ static int nbl_dev_txrx_start(struct rte_eth_dev *eth_dev)
 		param.local_queue_id = i + ring_mgt->queue_offset;
 		param.intr_en = 0;
 		param.intr_mask = 0;
-		param.half_offload_en = 0;
+		/* Draco needs the extended header to report stripped VLAN tags. */
+		param.half_offload_en = adapter->caps.product_type == NBL_DRACO_TYPE;
 		param.extend_header = 1;
 		param.split = 0;
 		param.rxcsum = 1;
@@ -400,7 +401,7 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 	param.conf = conf;
 	param.mempool = mempool;
 	param.product = adapter->caps.product_type;
-	param.rx_hash_en = 0;
+	param.rx_hash_en = adapter->caps.product_type == NBL_DRACO_TYPE;
 	ret =  disp_ops->start_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, &rx_ring->dma);
 	if (ret) {
 		NBL_LOG(ERR, "start_rx_ring failed %d", ret);
@@ -466,7 +467,7 @@ int nbl_dev_infos_get(struct rte_eth_dev *eth_dev, struct rte_eth_dev_info *dev_
 	dev_info->default_txportconf.nb_queues = ring_mgt->tx_ring_num;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_SCATTER;
-	if (adapter->caps.product_type == NBL_LEONIS_TYPE && !common->is_vf) {
+	if (!common->is_vf) {
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	}
@@ -815,12 +816,26 @@ int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask)
+int nbl_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 {
-	/*
-	 * No hardware or state change needed since
-	 * receive does VLAN in software based on rxmode.offload
-	 */
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	struct nbl_adapter *adapter = ETH_DEV_TO_NBL_DEV_PF_PRIV(dev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_DEV_MGT_TO_DISP_OPS(dev_mgt);
+	uint64_t offloads = dev_conf->rxmode.offloads;
+	void *disp_priv = NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt);
+	u16 vsi_id = dev_mgt->net_dev->vsi_id;
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		if (adapter->caps.product_type == NBL_DRACO_TYPE) {
+			if (offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+				return disp_ops->cfg_rx_vlan_parse(disp_priv, vsi_id,
+								   NBL_RX_VLAN_PARSE_CVLAN);
+			else
+				return disp_ops->cfg_rx_vlan_parse(disp_priv, vsi_id,
+								   NBL_RX_VLAN_PARSE_OFF);
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.h b/drivers/net/nbl/nbl_dev/nbl_dev.h
index 9fa8a9d..4554594 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.h
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.h
@@ -98,6 +98,6 @@ int nbl_xstats_reset(struct rte_eth_dev *eth_dev);
 int nbl_mtu_set(struct rte_eth_dev *eth_dev, uint16_t mtu);
 int nbl_promiscuous_enable(struct rte_eth_dev *eth_dev);
 int nbl_promiscuous_disable(struct rte_eth_dev *eth_dev);
-int nbl_vlan_offload_set(__rte_unused struct rte_eth_dev *dev, __rte_unused int mask);
+int nbl_vlan_offload_set(struct rte_eth_dev *dev, int mask);
 
 #endif
diff --git a/drivers/net/nbl/nbl_dispatch.c b/drivers/net/nbl/nbl_dispatch.c
index c693d8d..5e67dc0 100644
--- a/drivers/net/nbl/nbl_dispatch.c
+++ b/drivers/net/nbl/nbl_dispatch.c
@@ -1046,6 +1046,32 @@ static int nbl_disp_set_mtu(void *priv, u16 vsi_id, u16 mtu)
 	return ret;
 }
 
+static int nbl_disp_cfg_rx_vlan_parse(void *priv, u16 vsi_id, u16 rx_vlan_mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
+	struct nbl_resource_ops *res_ops;
+	int ret = 0;
+
+	res_ops = NBL_DISP_MGT_TO_RES_OPS(disp_mgt);
+	ret = NBL_OPS_CALL(res_ops->cfg_rx_vlan_parse,
+			   (NBL_DISP_MGT_TO_RES_PRIV(disp_mgt), vsi_id, rx_vlan_mode));
+	return ret;
+}
+
+static int nbl_disp_chan_cfg_rx_vlan_parse_req(void *priv, u16 vsi_id, u16 rx_vlan_mode)
+{
+	struct nbl_dispatch_mgt *disp_mgt = priv;
+	const struct nbl_channel_ops *chan_ops = NBL_DISP_MGT_TO_CHAN_OPS(disp_mgt);
+	struct nbl_chan_param_cfg_rx_vlan_parse param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+
+	param.vsi_id = vsi_id;
+	param.rx_vlan_mode = rx_vlan_mode;
+	NBL_CHAN_SEND(chan_send, NBL_DISP_MGT_GET_DST_ID(disp_mgt),
+		      NBL_CHAN_MSG_CFG_RX_VLAN_PARSE, &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_DISP_MGT_TO_CHAN_PRIV(disp_mgt), &chan_send);
+}
+
 static int nbl_disp_chan_set_mtu_req(void *priv, u16 vsi_id, u16 mtu)
 {
 	struct nbl_dispatch_mgt *disp_mgt = (struct nbl_dispatch_mgt *)priv;
@@ -1296,6 +1322,10 @@ do {									\
 			 NBL_DISP_CTRL_LVL_MGT,				\
 			 NBL_CHAN_MSG_SET_PROSISC_MODE,			\
 			 nbl_disp_chan_set_promisc_mode_req, NULL);	\
+	NBL_DISP_SET_OPS(cfg_rx_vlan_parse, nbl_disp_cfg_rx_vlan_parse,	\
+			 NBL_DISP_CTRL_LVL_MGT,				\
+			 NBL_CHAN_MSG_CFG_RX_VLAN_PARSE,			\
+			 nbl_disp_chan_cfg_rx_vlan_parse_req, NULL);	\
 	NBL_DISP_SET_OPS(set_mtu, nbl_disp_set_mtu,			\
 			 NBL_DISP_CTRL_LVL_MGT,	NBL_CHAN_MSG_MTU_SET,	\
 			 nbl_disp_chan_set_mtu_req,			\
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 7ba8758..dbb6bc9 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -119,8 +119,11 @@ static inline u16 nbl_prep_tx_ehdr_leonis(union nbl_tx_extend_head *head, struct
 
 static inline u16 nbl_prep_tx_ehdr_draco(union nbl_tx_extend_head *head, struct rte_mbuf *mbuf)
 {
-	RTE_SET_USED(head);
-	RTE_SET_USED(mbuf);
+	if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+		head->draco.vlan_tag = mbuf->vlan_tci;
+		head->draco.vlan_etype = NBL_TX_VLAN_ETYPE_0X8100;
+		head->draco.vlan_vld = 1;
+	}
 	return 0;
 }
 
@@ -751,6 +754,15 @@ nbl_res_txrx_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
 			rx_mbuf->data_len = rx_desc->len - rxq->exthdr_len;
 			rx_mbuf->pkt_len = rx_desc->len - rxq->exthdr_len;
 			rx_mbuf->port = rxq->port_id;
+			if (rxq->product == NBL_DRACO_TYPE) {
+				rx_mbuf->ol_flags = 0;
+				rx_mbuf->vlan_tci = 0;
+				if (rx_ext_hdr->draco.vlan & 0xFFF) {
+					rx_mbuf->vlan_tci = rx_ext_hdr->draco.vlan;
+					rx_mbuf->ol_flags = RTE_MBUF_F_RX_VLAN |
+						RTE_MBUF_F_RX_VLAN_STRIPPED;
+				}
+			}
 			rx_mbuf->data_off = RTE_PKTMBUF_HEADROOM + rxq->exthdr_len;
 		} else {
 			last_mbuf->next = rx_entry->mbuf;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 9e36dfa..c28d5f3 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -258,6 +258,7 @@ enum nbl_chan_msg_type {
 	NBL_CHAN_GET_USTORE_PKT_DROP_STATS,
 	NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
 
+	NBL_CHAN_MSG_CFG_RX_VLAN_PARSE = 500,
 	NBL_CHAN_MSG_MTU_SET = 501,
 	NBL_CHAN_MSG_SET_RXFH_INDIR = 506,
 
@@ -443,6 +444,11 @@ struct nbl_chan_param_set_promisc_mode {
 	u16 mode;
 };
 
+struct nbl_chan_param_cfg_rx_vlan_parse {
+	u16 vsi_id;
+	u16 rx_vlan_mode;
+};
+
 struct nbl_chan_param_set_mtu {
 	u16 vsi_id;
 	u16 mtu;
diff --git a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
index ebf94d3..0ddac3a 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_dispatch.h
@@ -19,6 +19,7 @@ enum {
 };
 
 struct nbl_dispatch_ops {
+	int (*cfg_rx_vlan_parse)(void *priv, u16 vsi_id, u16 rx_vlan_mode);
 	int (*configure_msix_map)(void *priv, u16 num_net_msix, u16 num_others_msix,
 				  bool net_msix_mask_en);
 	int (*destroy_msix_map)(void *priv);
diff --git a/drivers/net/nbl/nbl_include/nbl_def_resource.h b/drivers/net/nbl/nbl_include/nbl_def_resource.h
index fd33bff..c301965 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_resource.h
@@ -87,6 +87,7 @@ struct nbl_resource_ops {
 	void (*get_link_state)(void *priv, u8 eth_id, struct nbl_eth_link_info *eth_link_info);
 	int (*set_promisc_mode)(void *priv, u16 vsi_id, u16 mode);
 	int (*set_mtu)(void *priv, u16 vsi_id, u16 mtu);
+	int (*cfg_rx_vlan_parse)(void *priv, u16 vsi_id, u16 rx_vlan_mode);
 };
 
 struct nbl_resource_ops_tbl {
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 09b73c1..ecf8267 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -80,6 +80,13 @@ struct nbl_func_caps {
 	u32 rsv:31;
 };
 
+enum nbl_rx_vlan_parse_mode {
+	NBL_RX_VLAN_PARSE_OFF = 1,
+	NBL_RX_VLAN_PARSE_CVLAN,
+	NBL_RX_VLAN_PARSE_SVLAN,
+	NBL_RX_VLAN_PARSE_CVLAN_OR_SVLAN,
+};
+
 struct nbl_start_rx_ring_param {
 	u16 queue_idx;
 	u16 nb_desc;
-- 
2.53.0

