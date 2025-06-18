Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BE7C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 11:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5E5842D80;
	Wed, 18 Jun 2025 13:05:38 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id BA7AE42D7F;
 Wed, 18 Jun 2025 13:05:35 +0200 (CEST)
X-QQ-mid: esmtpgz10t1750244731t792b845e
X-QQ-Originating-IP: YlDXAZfU4PYHIIgIlh1sNhBaGDpdgH/CDyH+IOa1Jzo=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 19:05:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14686765710679645309
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v0 2/3] net/rnp: fix Tunnel-TSO VLAN header untrusted loop
 bound
Date: Wed, 18 Jun 2025 19:05:15 +0800
Message-Id: <20250618110516.90113-3-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618110516.90113-1-caowenbo@mucse.com>
References: <20250618110516.90113-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NOH1TaCqk/M+JaoVPRxVUQQLsx/AH6pV8EPjWi4CjP72pZP363bc1xVL
 mj9vLeT7RlcvSQ0kVTjWuCDYXijhF2kgFPnE5U860DbjzxhgLdXcgMi1BRqaWfINZ/GFdkQ
 HpGHbx4RH7SnRAinL4R29pjLfVb3ESPqR2mu28DMScj6mSz8RIJlPkI/Z8YuCSsOBhtu4lJ
 evqtU0gajAPce6DIACZR4yTZ+YhtArQbS+ykmrmcQfDg0g987bQUkdl1wO2ntXxD/bm1p29
 youJepB7MJJMuKN3pqOl6s1uj8Sn+tw8jRpzFhvOq8Gzi/8YrVJcj1r6FnFy6wwU726eTGE
 +8B9Q6+0U2f8kkhJee5jSkVjvUVhP1gPt1O7R8qImr9Nm7oN75+UeXS8xA+SZYbUWYdx0wL
 p8UeXXj2d5qsrydjzxY651Ox8hfCF/8odS8xIY3XZjQY+XUEtPLPVJB4dgVA6q3zJaq+DWt
 WM9vC1hvBPV1OSu0YFXyRw7MhVs3V40N5Y8Wq0h2SXi33SqVmeic25cHeNiXnTmjOYxgx0/
 3TMyFyqGUZIcloF+757W9DsyK6gVBSBFHxBVIF1WlLALKAtpMDPuh84O4bchWBP37/QtQty
 HgzRKlHtkv8X7GNNARW68g5y4dsZ2Euxl3DmVS58De4ssEobC1KlkTXYUFKvU5tWrz4tNEW
 DP3m0Vy8UtjVp5bzh665e6x+pzWbbq72JKcas0Yyze26tHYj3cJAjMXG4c6WiFO8Qcnv/ec
 LPQ+O1svTCgMI59/oOW5ENqxS05afcbmwx5M2mDvvmV2Rj9mMTgCD7WmnqmQRvn5ygkYY1u
 TUFPZow8jem0iVgZBnTg/kxTa/VitAn3oKJ5vgZyhCbC5f2iT0S1e25G+CGJhOTG2jcR35e
 6d+zK5nOS27qzcaPZf5bfSI65kCcwcuaRxrwSSKO414r49yrleFtvCsra7o0RSsYpvZBS7/
 2J3WFg2I1nlxlp2Rupmuxq2zb0c0PqpqT3VhfASqzx2lfAQt8DiPT7CxKT/j8s/21OQ549V
 DejtgajA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
---
 drivers/net/rnp/rnp_rxtx.c | 62 +++++++++++++++++++++++++++-----------
 drivers/net/rnp/rnp_rxtx.h |  1 +
 2 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index da08728198..62e2eec007 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1205,6 +1205,7 @@ rnp_build_tx_control_desc(struct rnp_tx_queue *txq,
 	}
 	txbd->c.qword0.tunnel_len = tunnel_len;
 	txbd->c.qword1.cmd |= RNP_CTRL_DESC;
+	txq->tunnel_len = tunnel_len;
 }
 
 static void
@@ -1243,7 +1244,8 @@ rnp_padding_hdr_len(volatile struct rnp_tx_desc *txbd,
 	txbd->d.mac_ip_len |= l3_len;
 }
 
-static void
+#define RNP_MAX_VLAN_HDR_NUM	(4)
+static int
 rnp_check_inner_eth_hdr(struct rte_mbuf *mbuf,
 			volatile struct rnp_tx_desc *txbd)
 {
@@ -1251,25 +1253,48 @@ rnp_check_inner_eth_hdr(struct rte_mbuf *mbuf,
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
@@ -1296,8 +1321,6 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 		tx_desc->d.cmd |= RNP_TX_L4TYPE_SCTP;
 		break;
 	}
-	tx_desc->d.mac_ip_len = mbuf->l2_len << RNP_TX_MAC_LEN_S;
-	tx_desc->d.mac_ip_len |= mbuf->l3_len;
 	if (mbuf->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
 		tx_desc->d.cmd |= RNP_TX_IP_CKSUM_EN;
 		tx_desc->d.cmd |= RNP_TX_L4CKSUM_EN;
@@ -1306,9 +1329,8 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 	}
 	if (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 		/* need inner l2 l3 lens for inner checksum offload */
-		tx_desc->d.mac_ip_len &= ~RNP_TX_MAC_LEN_MASK;
-		tx_desc->d.mac_ip_len |= RTE_ETHER_HDR_LEN << RNP_TX_MAC_LEN_S;
-		rnp_check_inner_eth_hdr(mbuf, tx_desc);
+		if (rnp_check_inner_eth_hdr(mbuf, tx_desc) < 0)
+			tx_desc->d.cmd &= ~RNP_TX_TSO_EN;
 		switch (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
 		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
 			tx_desc->d.cmd |= RNP_TX_VXLAN_TUNNEL;
@@ -1317,6 +1339,9 @@ rnp_setup_csum_offload(struct rte_mbuf *mbuf,
 			tx_desc->d.cmd |= RNP_TX_NVGRE_TUNNEL;
 			break;
 		}
+	} else {
+		tx_desc->d.mac_ip_len = mbuf->l2_len << RNP_TX_MAC_LEN_S;
+		tx_desc->d.mac_ip_len |= mbuf->l3_len;
 	}
 }
 
@@ -1414,6 +1439,7 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
2.25.1

