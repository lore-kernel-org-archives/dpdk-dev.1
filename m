Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E0606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55AC740616;
	Thu, 26 Nov 2026 08:34:47 +0100 (CET)
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com
 [115.124.28.218])
 by mails.dpdk.org (Postfix) with ESMTPS id 0E9D840431
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:43 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00372776-6.8842e-05-0.996203;
 FP=12139378155542186573|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037028158; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1YuY_1795678480; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1YuY_1795678480 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:40 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 07/11] net/nbl: support draco queue setup and release
Date: Thu, 26 Nov 2026 15:34:24 +0800
Message-ID: <20261126073430.3168813-8-dimon.zhao@nebula-matrix.com>
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

Add draco Tx and Rx extended header definitions and initialize
the default Tx header when setting up a queue.

Use a 16-byte Tx header and select the Rx header length through
rx_hash_en, which defaults to zero for a 12-byte Rx header.
RSS hash reporting is not enabled.

Preserve the leonis header lengths and fallback Tx header stride,
and reuse the common queue allocation and release paths.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_dev/nbl_dev.c         |  1 +
 drivers/net/nbl/nbl_hw/nbl_resource.h     | 71 +++++++++++++++++++++++
 drivers/net/nbl/nbl_hw/nbl_txrx.c         | 31 ++++++++--
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 4 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/net/nbl/nbl_dev/nbl_dev.c b/drivers/net/nbl/nbl_dev/nbl_dev.c
index 643cc74..8d2195f 100644
--- a/drivers/net/nbl/nbl_dev/nbl_dev.c
+++ b/drivers/net/nbl/nbl_dev/nbl_dev.c
@@ -404,6 +404,7 @@ int nbl_rx_queue_setup(struct rte_eth_dev *eth_dev, u16 queue_idx,
 	param.conf = conf;
 	param.mempool = mempool;
 	param.product = adapter->caps.product_type;
+	param.rx_hash_en = 0;
 	ret =  disp_ops->start_rx_ring(NBL_DEV_MGT_TO_DISP_PRIV(dev_mgt), &param, &rx_ring->dma);
 	if (ret) {
 		NBL_LOG(ERR, "start_rx_ring failed %d", ret);
diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 2d4f5d6..688dba9 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -75,6 +75,49 @@ union nbl_tx_extend_head {
 		u32 l3_csum_en :1;
 		u32 rsv1 :3;
 	} leonis;
+
+	struct nbl_tx_ehdr_draco {
+		/* DW0 */
+		u32 mac_len :5;
+		u32 ip_len :5;
+		u32 l4_len :4;
+		u32 l4_type :2;
+		u32 inner_ip_type :2;
+		u32 external_ip_type :2;
+		u32 external_ip_len :5;
+		u32 l4_tunnel_len :7;
+		/* DW1 */
+		u32 l4_tunnel_type :2;
+		u32 l4s_sid :15;
+		u32 l4s_sync_ind :1;
+		u32 l4s_redun_ind :1;
+		u32 l4s_redun_head_ind :1;
+		u32 l4s_hdl_ind :1;
+		u32 l4s_pbrac_mode :1;
+		u32 rsv0 :2;
+		u32 acl_tag :8;
+		/* DW2 */
+		u32 dport_info :9;
+		u32 dport_id :9;
+#define NBL_TX_DPORT_ID_LAG_OFT_DRACO	(2)
+		u32 dport :2;
+		u32 fwd :2;
+		u32 rss_lag_en :1;
+		u32 inner_l4_csum_en :1;
+		u32 inner_l3_csum_en :1;
+		u32 outer_l4_csum_en :1;
+		u32 outer_l3_csum_en :1;
+		u32 sc_idx :3;
+		u32 sc_vld :1;
+		u32 mc_en :1;
+		/* DW3 */
+		u32 vlan_tag :16;
+		u32 vlan_etype :1;
+#define NBL_TX_VLAN_ETYPE_0X8100	(0)
+#define NBL_TX_VLAN_ETYPE_0X88A8	(1)
+		u32 vlan_vld :1;
+		u32 rsv1 :14;
+	} draco;
 };
 
 union nbl_rx_extend_head {
@@ -108,6 +151,34 @@ union nbl_rx_extend_head {
 		u32 rsv2 :4;
 		u32 num_buffers :8;
 	} leonis;
+	struct nbl_rx_ehdr_draco {
+		/* DW0 */
+		/* 0x0:eth, 0x1:host, 0x2:emp, 0x3:bmc */
+		u32 sport :2;
+		u32 dport_info :9;
+		/* sport = 0, sport_id[3:0] = eth id,
+		 * sport = 1, sport_id[9:0] = host vsi_id,
+		 */
+		u32 sport_id :9;
+		u32 ptype :8;
+		u32 checksum_report :4;
+		/* DW1 */
+		u32 checksum_status :1;
+		u32 rsv0 :2;
+		u32 l4s_sid :11;
+		u32 l4s_hdl_ind :1;
+		u32 l4s_tcp_offset :14;
+		u32 l4s_resync_ind :1;
+		u32 l4s_check_ind :1;
+		u32 l4s_dec_ind :1;
+		/* DW2 */
+		u32 error_code :4;
+		u32 rsv1 :4;
+		u32 vlan:16;
+		u32 num_buffers :8;
+		/* DW3 */
+		u32 udf_value_l :32;
+	} draco;
 	struct nbl_rx_ehdr_common {
 		u32 dw0;
 		u32 dw1;
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 7beae85..8a1669e 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -111,6 +111,13 @@ static inline u16 nbl_prep_tx_ehdr_leonis(union nbl_tx_extend_head *head, struct
 	return 0;
 }
 
+static inline u16 nbl_prep_tx_ehdr_draco(union nbl_tx_extend_head *head, struct rte_mbuf *mbuf)
+{
+	RTE_SET_USED(head);
+	RTE_SET_USED(mbuf);
+	return 0;
+}
+
 static int nbl_res_txrx_start_tx_ring(void *priv,
 				      struct nbl_start_tx_ring_param *param,
 				      u64 *dma_addr)
@@ -125,6 +132,7 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	const struct rte_memzone *net_hdr_mz;
 	char vq_hdr_name[NBL_VQ_HDR_NAME_MAXSIZE];
 	struct nbl_tx_ehdr_leonis ext_hdr = {0};
+	struct nbl_tx_ehdr_draco draco_hdr = {0};
 	uint64_t offloads;
 	u32 size;
 
@@ -149,6 +157,15 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 		ext_hdr.fwd = NBL_TX_FWD_TYPE_NORMAL;
 		memcpy(&tx_ring->default_hdr, &ext_hdr, sizeof(struct nbl_tx_ehdr_leonis));
 		break;
+	case NBL_DRACO_TYPE:
+		tx_ring->exthdr_len = sizeof(struct nbl_tx_ehdr_draco);
+		tx_ring->prep_tx_ehdr = nbl_prep_tx_ehdr_draco;
+		draco_hdr.mac_len = RTE_ETHER_HDR_LEN >> 1;
+		draco_hdr.ip_len = sizeof(struct rte_ipv4_hdr) >> 2;
+		draco_hdr.l4_len = sizeof(struct rte_tcp_hdr) >> 2;
+		draco_hdr.fwd = NBL_TX_FWD_TYPE_NORMAL;
+		memcpy(&tx_ring->default_hdr, &draco_hdr, sizeof(draco_hdr));
+		break;
 	default:
 		tx_ring->exthdr_len = sizeof(union nbl_tx_extend_head);
 		break;
@@ -358,6 +375,11 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	case NBL_LEONIS_TYPE:
 		rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_leonis);
 		break;
+	case NBL_DRACO_TYPE:
+		rx_ring->exthdr_len = sizeof(struct nbl_rx_ehdr_draco);
+		if (!param->rx_hash_en)
+			rx_ring->exthdr_len -= sizeof(u32);
+		break;
 	default:
 		rx_ring->exthdr_len = sizeof(union nbl_rx_extend_head);
 	};
@@ -563,14 +585,16 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 						    -required_headroom);
 		} else {
 			can_push = 0;
-			u = (union nbl_tx_extend_head *)(&tx_region[desc_index]);
+			u = RTE_PTR_ADD(tx_region,
+				       (size_t)desc_index * txq->exthdr_len);
 		}
 
 		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			if (likely(can_push)) {
 				if (rte_vlan_insert(&tx_pkt)) {
 					can_push = 0;
-					u = (union nbl_tx_extend_head *)(&tx_region[desc_index]);
+					u = RTE_PTR_ADD(tx_region,
+						       (size_t)desc_index * txq->exthdr_len);
 				}
 			}
 			if (unlikely(!can_push)) {
@@ -607,8 +631,7 @@ nbl_res_txrx_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts, u
 			head_flags |= NBL_VRING_DESC_F_NEXT;
 			txe->mbuf = NULL;
 			/* padding */
-			head_desc->addr = net_hdr_mem +
-					RTE_PTR_DIFF(&tx_region[desc_index], tx_region);
+			head_desc->addr = net_hdr_mem + (size_t)desc_index * txq->exthdr_len;
 			head_desc->len = tx_extend_len;
 			txe->first_id = head_index;
 			desc_index++;
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index 0203e43..09b73c1 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -87,6 +87,7 @@ struct nbl_start_rx_ring_param {
 	enum nbl_product_type product;
 	const struct rte_eth_rxconf *conf;
 	struct rte_mempool *mempool;
+	bool rx_hash_en;
 };
 
 struct nbl_start_tx_ring_param {
-- 
2.53.0

