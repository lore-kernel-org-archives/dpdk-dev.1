Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9429FCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:01:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F50C40656;
	Fri, 10 Oct 2025 09:01:40 +0200 (CEST)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 1A817402C5;
 Fri, 10 Oct 2025 09:01:36 +0200 (CEST)
X-QQ-mid: zesmtpgz5t1760079693t9b8b0a95
X-QQ-Originating-IP: hBspBk7M4LrOKC3qRicBD/B0L2sUF8mUqn2QYcrIz7k=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 10 Oct 2025 15:01:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18367594034813863808
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v3 2/4] net/rnp: fix Tunnel-TSO VLAN header untrusted loop
 bound
Date: Fri, 10 Oct 2025 15:01:20 +0800
Message-Id: <20251010070122.161401-3-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010070122.161401-1-caowenbo@mucse.com>
References: <20251010070122.161401-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OFelQXFBryTbee3PVYCXXHw+oRU22R5szAu+8+QqZRq9ISDmSdFgE99f
 lzyvoNmiDZ09w9CLeCnWdtmMYBjs+sfVd48hLnXSkEUBQS2Q5JSoLZFpIIaD1Ajsr7O3MJU
 z1h8vIbRUvJxrIjetqs9POAwDjZlpBMTeVScq3RiN/clwgM5qcjQvnGrWU+FhIKRgjgrpdk
 2/Yqqmr+RRvhh+Kz2nutwdNrkrB5fhnTg+f1ycz9ZjSIF8J27C7eh6H9k2wkeUnf6r64PfU
 ecYcOLODQjcSFeWhPH0y/6FTiDZMu0QpewhzIP7qCE5SQ5ktfmUhLTDUtVf2HC51HYxfQzB
 5HdDWcXRu4G+3BBJ49OS8Q8SQLLLv73iab7+MiZ66CTpFlmR9B8ji8uR0x+9gkx29iKX2Gr
 0feu/zAJ7DXC3CJXpdW9bz+cgGHt2ijDxrtpeQhCMUtFMJYFEB/v+lWkYkGlJv2XZQpYZ7H
 e7Zy9CC3+GLZi39A7SjOoaoHXz8FP8avXIibdYn9xRcyL+/Hshd943cjXyEbpWeTXQhFbfo
 GjHedeL2ugs77cLvsI5PZVe6qqBTa/wfdu4CcWyWTDYKHofUBlQTNR5tbHAx688o70uwCp4
 Xq74HmfdhTJpVAC2mkne2y7yt4iFYt6uIYX+2X6df5897jBoN41MhHGT1PwTXD2zPVepe9C
 1WyA4b/ew2NNNtrylSdAdMXLUBAbX6o5gIwGVHh+AVtNyxbXl9gUaAdl8LgiWxNGXiqXGLX
 bGwYUWX6muPS+Su/qnLsMDE3c8DSuKGA/qdFDbyRg+egcRRmRTY8ysbousmwyyvrN0YSFEP
 J+1IDDcqS6K4lzAMBIb65x7YRNnPXxcAQpRRadpW8K+SP9VIsKvoxLYLNbkt3ycLuI6Wu2D
 hIgQKSpZZCJwAGtzK5wvuGzb9Bq8uVpmy9tQfgd+ACF6OHZxRNytJ+H4FLCJYhG6ZXZqQZh
 LDG1VP/qIrxIDxZYPxqgcW6kBp8hjZxasn/IzpJnSwK8OPEQcxEx98aQYO+hhRGGywZCbG5
 Nn0022hJ3OIWOCh1JRiPmOkAYEPAkXsAdijpf1nePkzl1pCFRxxkzJL2sn0sthB2+BUTRDT
 ueO6aHPO6v/BpX4qKnK0sla0GGM/YhPOg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0
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

Adds support for boundary checking in the VLAN header
and corrects protocol header type verification.

Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
Cc: stable@dpdk.org

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/rnp_rxtx.c | 70 ++++++++++++++++++++++++++------------
 drivers/net/rnp/rnp_rxtx.h |  1 +
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index da08728198..ee31f17cad 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1205,6 +1205,7 @@ rnp_build_tx_control_desc(struct rnp_tx_queue *txq,
 	}
 	txbd->c.qword0.tunnel_len = tunnel_len;
 	txbd->c.qword1.cmd |= RNP_CTRL_DESC;
+	txq->tunnel_len = tunnel_len;
 }
 
 static void
@@ -1243,40 +1244,66 @@ rnp_padding_hdr_len(volatile struct rnp_tx_desc *txbd,
 	txbd->d.mac_ip_len |= l3_len;
 }
 
-static void
-rnp_check_inner_eth_hdr(struct rte_mbuf *mbuf,
+#define RNP_MAX_VLAN_HDR_NUM	(4)
+static int
+rnp_check_inner_eth_hdr(struct rnp_tx_queue *txq,
+			struct rte_mbuf *mbuf,
 			volatile struct rnp_tx_desc *txbd)
 {
 	struct rte_ether_hdr *eth_hdr;
 	uint16_t inner_l2_offset = 0;
 	struct rte_vlan_hdr *vlan_hdr;
 	uint16_t ext_l2_len = 0;
-	uint16_t l2_offset = 0;
+	char *vlan_start = NULL;
 	uint16_t l2_type;
 
-	inner_l2_offset = mbuf->outer_l2_len + mbuf->outer_l3_len +
-		sizeof(struct rte_udp_hdr) +
-		sizeof(struct rte_vxlan_hdr);
+	inner_l2_offset = txq->tunnel_len;
+	if (inner_l2_offset + sizeof(struct rte_ether_hdr) > mbuf->data_len) {
+		RNP_PMD_LOG(ERR, "Invalid inner L2 offset");
+		return -EINVAL;
+	}
 	eth_hdr = rte_pktmbuf_mtod_offset(mbuf,
 			struct rte_ether_hdr *, inner_l2_offset);
 	l2_type = eth_hdr->ether_type;
-	l2_offset = txbd->d.mac_ip_len >> RNP_TX_MAC_LEN_S;
-	while (l2_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
-			l2_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
-		vlan_hdr = (struct rte_vlan_hdr *)
-			((char *)eth_hdr + l2_offset);
-		l2_offset += RTE_VLAN_HLEN;
-		ext_l2_len += RTE_VLAN_HLEN;
+	vlan_start = (char *)(eth_hdr + 1);
+	while ((l2_type == RTE_BE16(RTE_ETHER_TYPE_VLAN) ||
+		l2_type == RTE_BE16(RTE_ETHER_TYPE_QINQ)) &&
+		(ext_l2_len < RNP_MAX_VLAN_HDR_NUM * RTE_VLAN_HLEN)) {
+		if (vlan_start + ext_l2_len >
+				rte_pktmbuf_mtod(mbuf, char*) + mbuf->data_len) {
+			RNP_PMD_LOG(ERR, "VLAN header exceeds buffer");
+			break;
+		}
+		vlan_hdr = (struct rte_vlan_hdr *)(vlan_start + ext_l2_len);
 		l2_type = vlan_hdr->eth_proto;
+		ext_l2_len += RTE_VLAN_HLEN;
 	}
-	txbd->d.mac_ip_len += (ext_l2_len << RNP_TX_MAC_LEN_S);
+	if (unlikely(mbuf->l3_len == 0)) {
+		switch (rte_be_to_cpu_16(l2_type)) {
+		case RTE_ETHER_TYPE_IPV4:
+			txbd->d.mac_ip_len = sizeof(struct rte_ipv4_hdr);
+			break;
+		case RTE_ETHER_TYPE_IPV6:
+			txbd->d.mac_ip_len = sizeof(struct rte_ipv6_hdr);
+			break;
+		default:
+			break;
+		}
+	} else {
+		txbd->d.mac_ip_len = mbuf->l3_len;
+	}
+	ext_l2_len += sizeof(*eth_hdr);
+	txbd->d.mac_ip_len |= (ext_l2_len << RNP_TX_MAC_LEN_S);
+
+	return 0;
 }
 
 #define RNP_TX_L4_OFFLOAD_ALL   (RTE_MBUF_F_TX_SCTP_CKSUM | \
 				 RTE_MBUF_F_TX_TCP_CKSUM | \
 				 RTE_MBUF_F_TX_UDP_CKSUM)
 static inline void
-rnp_setup_csum_offload(struct rte_mbuf *mbuf,
+rnp_setup_csum_offload(struct rnp_tx_queue *txq,
+		       struct rte_mbuf *mbuf,
 		       volatile struct rnp_tx_desc *tx_desc)
 {
 	tx_desc->d.cmd |= (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) ?
@@ -1296,8 +1323,6 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 		tx_desc->d.cmd |= RNP_TX_L4TYPE_SCTP;
 		break;
 	}
-	tx_desc->d.mac_ip_len = mbuf->l2_len << RNP_TX_MAC_LEN_S;
-	tx_desc->d.mac_ip_len |= mbuf->l3_len;
 	if (mbuf->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
 		tx_desc->d.cmd |= RNP_TX_IP_CKSUM_EN;
 		tx_desc->d.cmd |= RNP_TX_L4CKSUM_EN;
@@ -1306,9 +1331,8 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 	}
 	if (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 		/* need inner l2 l3 lens for inner checksum offload */
-		tx_desc->d.mac_ip_len &= ~RNP_TX_MAC_LEN_MASK;
-		tx_desc->d.mac_ip_len |= RTE_ETHER_HDR_LEN << RNP_TX_MAC_LEN_S;
-		rnp_check_inner_eth_hdr(mbuf, tx_desc);
+		if (rnp_check_inner_eth_hdr(txq, mbuf, tx_desc) < 0)
+			tx_desc->d.cmd &= ~RNP_TX_TSO_EN;
 		switch (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 			tx_desc->d.cmd |= RNP_TX_VXLAN_TUNNEL;
@@ -1317,6 +1341,9 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 			tx_desc->d.cmd |= RNP_TX_NVGRE_TUNNEL;
 			break;
 		}
+	} else {
+		tx_desc->d.mac_ip_len = mbuf->l2_len << RNP_TX_MAC_LEN_S;
+		tx_desc->d.mac_ip_len |= mbuf->l3_len;
 	}
 }
 
@@ -1329,7 +1356,7 @@ rnp_setup_tx_offload(struct rnp_tx_queue *txq,
 	if (flags & RTE_MBUF_F_TX_L4_MASK ||
 	    flags & RTE_MBUF_F_TX_TCP_SEG ||
 	    flags & RTE_MBUF_F_TX_IP_CKSUM)
-		rnp_setup_csum_offload(tx_pkt, txbd);
+		rnp_setup_csum_offload(txq, tx_pkt, txbd);
 	if (flags & (RTE_MBUF_F_TX_VLAN |
 		     RTE_MBUF_F_TX_QINQ)) {
 		txbd->d.cmd |= RNP_TX_VLAN_VALID;
@@ -1414,6 +1441,7 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		} while (m_seg != NULL);
 		txq->stats.obytes += tx_pkt->pkt_len;
 		txbd->d.cmd |= RNP_CMD_EOP;
+		txq->tunnel_len = 0;
 		txq->nb_tx_used = (uint16_t)txq->nb_tx_used + nb_used_bd;
 		txq->nb_tx_free = (uint16_t)txq->nb_tx_free - nb_used_bd;
 		if (txq->nb_tx_used >= txq->tx_rs_thresh) {
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index 8639f0892d..dd72ac7d3f 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -110,6 +110,7 @@ struct rnp_tx_queue {
 	uint16_t nb_tx_free; /* avail desc to set pkts */
 	uint16_t nb_tx_used; /* multiseg mbuf used num */
 	uint16_t last_desc_cleaned;
+	uint16_t tunnel_len;
 	uint16_t tx_tail;
 
 	uint16_t tx_next_dd; /* next to scan writeback dd bit */
-- 
2.34.1

