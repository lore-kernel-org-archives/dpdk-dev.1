Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46051CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 07:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B72FD40670;
	Fri, 10 Oct 2025 09:01:42 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id 98B074065A;
 Fri, 10 Oct 2025 09:01:40 +0200 (CEST)
X-QQ-mid: zesmtpgz5t1760079696t937c1237
X-QQ-Originating-IP: wOq967usb9X/HLCw/Yf9GRFMgng+676f3XZVa+LYq4M=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 10 Oct 2025 15:01:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16117421607332920216
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v3 3/4] net/rnp: fix TSO segmentation for packets of 64KB
Date: Fri, 10 Oct 2025 15:01:21 +0800
Message-Id: <20251010070122.161401-4-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010070122.161401-1-caowenbo@mucse.com>
References: <20251010070122.161401-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MMsIiB3OVv48x2y/PlkoDoeOPzGXN4jSrQb9S6Z6Md8HO8VTAw0O4d+m
 UxenxzEdzPzZKhLKkXed3oamgFr/IXKQzDhSxiQHAazdcJWabyHBcMFmjVsnoyYFRxqqRi/
 vsuFE5DsIobZ9Khn62iKhOKSNFmzFUoIEkC1gpN1ae3qdzdaSoQe0C/bM99B31mYybgKLnA
 hOts3AXObT+/9MhbSEuMkizuXtPE8lmgKf1BPUI2g45rjfT5vE3zgwMPkr+ZSUqaBxlN/nN
 r8uSWFLplIM0s4YgdXpTWt7Mrw7wdLuUibZ7Gy47J1LPWwLRHKmr3TE5Q4X23/oHqzYrdVJ
 u3eFRBsb+k2/DIWZZRMereM1Ac6lIaVywscaDlaRdvzTaXFxx1ekl1/PfGKvC8g51uylrU2
 9sL+D29FPvb1sEbFofU+S6LlhJjaez5LuhSzKATqIlU2bSRBewkkfUImkul5KnzJPVeV/HE
 asklO2DCqzTJdeaVrbf71+exCHNkt0xCNKDA0WclqACOJBw6lPNMHkAbCbz4FDOaiMEA9Vv
 nNH/EI486d9lbKYOBF2Lhy0gmKHDi6vxpGe5eW8RjfszG2axcu662P/DIjQP5vew73J0tfa
 eFqFxveNlSMtND50wG0z16TZw9angbMzTyPFpElR8t12nTjbgg/FfKMbHHRGwSwb1wi+Zzs
 z22cf1G7J3gyAT2dl4fPX4zBDB44ZATJdOZw8pNAiF2s50ED26rv3Md6zvHm687xfhW6VGn
 e8rQH08WqAukh/sBu2MSkFtVUvt/jLCaZPDbH5VsNUGQzW9H8AL4Z/42iSbr+TjpMTWHU0N
 QftVr63nGN8c/3Z6yiJaUKqh7FRnFNDcKwJ+EpnBN2XVnYAIm1F4an/9TC1FgpGWNxD3cop
 U2zkpgbNTxqr2neioNBw3aYIChHbxsq2eAiq6O7ETORIiPD4hL1cm3nbtS55YMmm/PA3aGf
 6G2/GQ0yjtNxd99LnrQZLlye1HN+6l2fAumhzom8KCbCcIURc0qHFX0+gylIqlMyeP1fkTf
 /WPplk4B8P13AXUXp0KdrD/I++ZQx+IhDwraslZxBjJOXR7Ft4vgL1QidpwG/e+tBxAP75l
 cCg0RyECtkILyLsh0oJ84g=
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

Packets exceeding 64KB TSO size must be fragmented
across multiple descriptors,Otherwise,it may cause
TSO fragmentation anomalies.

Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
Cc: stable@dpdk.org

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/rnp_rxtx.c | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index ee31f17cad..81e8c6ba44 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1157,6 +1157,21 @@ rnp_need_ctrl_desc(uint64_t flags)
 	return (flags & mask) ? 1 : 0;
 }
 
+#define RNP_MAX_TSO_SEG_LEN	(4096)
+static inline uint16_t
+rnp_calc_pkt_desc(struct rte_mbuf *tx_pkt)
+{
+	struct rte_mbuf *txd = tx_pkt;
+	uint16_t count = 0;
+
+	while (txd != NULL) {
+		count += DIV_ROUND_UP(txd->data_len, RNP_MAX_TSO_SEG_LEN);
+		txd = txd->next;
+	}
+
+	return count;
+}
+
 static void
 rnp_build_tx_control_desc(struct rnp_tx_queue *txq,
 			  volatile struct rnp_tx_desc *txbd,
@@ -1394,6 +1409,10 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_pkt = tx_pkts[nb_tx];
 		ctx_desc_use = rnp_need_ctrl_desc(tx_pkt->ol_flags);
 		nb_used_bd = tx_pkt->nb_segs + ctx_desc_use;
+		if (tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+			nb_used_bd = (uint16_t)(rnp_calc_pkt_desc(tx_pkt) + ctx_desc_use);
+		else
+			nb_used_bd = tx_pkt->nb_segs + ctx_desc_use;
 		tx_last = (uint16_t)(tx_id + nb_used_bd - 1);
 		if (tx_last >= txq->attr.nb_desc)
 			tx_last = (uint16_t)(tx_last - txq->attr.nb_desc);
@@ -1416,8 +1435,11 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		m_seg = tx_pkt;
 		first_seg = 1;
 		do {
+			uint16_t remain_len = 0;
+			uint64_t dma_addr = 0;
+
 			txbd = &txq->tx_bdr[tx_id];
-			txbd->d.cmd = 0;
+			*txbd = txq->zero_desc;
 			txn = &txq->sw_ring[txe->next_id];
 			if ((first_seg && m_seg->ol_flags)) {
 				rnp_setup_tx_offload(txq, txbd,
@@ -1430,11 +1452,29 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 				rte_pktmbuf_free_seg(txe->mbuf);
 				txe->mbuf = NULL;
 			}
+			dma_addr = rnp_get_dma_addr(&txq->attr, m_seg);
+			remain_len = m_seg->data_len;
 			txe->mbuf = m_seg;
+			while ((tx_pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
+					unlikely(remain_len > RNP_MAX_TSO_SEG_LEN)) {
+				txbd->d.addr = dma_addr;
+				txbd->d.blen = rte_cpu_to_le_32(RNP_MAX_TSO_SEG_LEN);
+				dma_addr += RNP_MAX_TSO_SEG_LEN;
+				remain_len -= RNP_MAX_TSO_SEG_LEN;
+				txe->last_id = tx_last;
+				tx_id = txe->next_id;
+				txe = txn;
+				if (txe->mbuf) {
+					rte_pktmbuf_free_seg(txe->mbuf);
+					txe->mbuf = NULL;
+				}
+				txbd = &txq->tx_bdr[tx_id];
+				*txbd = txq->zero_desc;
+				txn = &txq->sw_ring[txe->next_id];
+			}
 			txe->last_id = tx_last;
-			txbd->d.addr = rnp_get_dma_addr(&txq->attr, m_seg);
-			txbd->d.blen = rte_cpu_to_le_32(m_seg->data_len);
-			txbd->d.cmd &= ~RNP_CMD_EOP;
+			txbd->d.addr = dma_addr;
+			txbd->d.blen = rte_cpu_to_le_32(remain_len);
 			m_seg = m_seg->next;
 			tx_id = txe->next_id;
 			txe = txn;
-- 
2.34.1

