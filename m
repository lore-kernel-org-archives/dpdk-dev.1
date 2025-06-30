Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A65FC83000
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 05:58:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A722B4060A;
	Mon, 30 Jun 2025 07:58:15 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 1DA474060A;
 Mon, 30 Jun 2025 07:58:12 +0200 (CEST)
X-QQ-mid: esmtpsz17t1751263089t03127f75
X-QQ-Originating-IP: RB53x4yGhYOyeEeXxX5C/3wVuGWSjHBlVu81TGFbxEI=
Received: from sunshaojie-Precision-5820-Tower ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Jun 2025 13:58:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2718828629859666175
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v2 3/3] net/rnp: fix TSO segmentation for packets of 64KB
Date: Mon, 30 Jun 2025 13:57:53 +0800
Message-Id: <20250630055753.35445-4-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250630055753.35445-1-caowenbo@mucse.com>
References: <20250630055753.35445-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NENrrmtYLi89o5IhAhB8V+rEum1xaNHJZinAdjvxhX2KCKyNKL/Qyj5D
 NeLOi2yeKqIR0Cqlt7JWpM5G/CYFCFmb886QMgehUm7oEEmxhZZh9J2FU2KxY7kOPFByRT4
 fY5YqUsvKJmMQ59qRWUPocoCVff1eiSCQrBemNOKgtidHWZj364IYGo/MWBFgFEKOha9a5g
 ng+8RLVgb47GAblJCeVk7e4Quv4JcDK872H4YJj/znKNfbS4MTtV95gP0nKg9YNh/CQMi0W
 TWPD3OmbHJcphCuBQUyOjmi0krZve0xj3nJPXlCNdj4fpTDa0vCxx3kmyYgMrFqR+uiDUYe
 H9fwSKGX/PclAQ8SJAYO3NG9g0pwyvdAw7m/ceQEo/6ppdihuuZikxnK7Ax/gejdxYmrj0F
 0y5LDgGVDvVjBa+8AKX7M0ImlzTGJ5R8Vf1GMe0u+rGhZOuT8UiTmEszkWHUGQqhDaaIJRR
 vzTfgWvqqEYTLUuhpRFMIWLFoBhT6GcCPK/zwBQd+ZtjOMQUMz8HyERa+jOmDW04FA2ArKL
 MM22LkwWT4ahw4r1rQW0atoajJ/F4bz1+LdNDM8e/XuJeZ0Fgz47d91DsAb2WNu8ziNDvlq
 U1tQovFHCmFDxeHHQ7psyTuGrMUcGmDrCJtdnJjJf4XsWYXi5oHYLvK3zIo2NXnjYLgNe8J
 bZEKv5FEY3S/9hVYEJUtXt1sixr6aJyskbrZmc4lv00Pc0KrVa4vifXMXW+2Ts0R7+iuk0r
 MGlLRhC5zml6BEpJYpBkC3TMTLomTL5xlrQQ7REHQ0KSJQM2rXaYxdAgAM5ZRwbss3agFGR
 vl5vASiTDqzfdZdG1bJjIB6W3OpxMg8eSJL/8cwU/U4YptqO9i4TMiuYGuxCJAputyfAu+n
 LN/IJ7TozK4aOh7VmrQ2DW6S34RzlgoLY8vPZZr50N+NqTnBK9s370tAq3o/L4HkBuuxUh2
 u8A1UQYtYUpFjpoHjajQzX1B7i4KPRIRv2ChK7gj5k1/butAEjgqgnKhZbPhFIV2okMh9+T
 a3Izjk/COalwBM7ayBw9NNH4xF4kflhKSsImfHphGuQ6f2i3P3
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

