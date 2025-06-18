Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D1C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 11:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5062042D92;
	Wed, 18 Jun 2025 13:05:42 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 346CE42D90;
 Wed, 18 Jun 2025 13:05:38 +0200 (CEST)
X-QQ-mid: esmtpgz10t1750244735t7b692825
X-QQ-Originating-IP: w0MEG03rf58iRG7BGADaS6iy5a993uGS9tbSGMKj6f4=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 19:05:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8175233228688132742
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v0 3/3] net/rnp: fix TSO segmentation for packets of 64KB
Date: Wed, 18 Jun 2025 19:05:16 +0800
Message-Id: <20250618110516.90113-4-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618110516.90113-1-caowenbo@mucse.com>
References: <20250618110516.90113-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: M/zeJvo3IvQszds0Jj47/n6Tf4204AWKX1H5I91WLzf3146oOgRnFAsi
 qr5gw/0JsCGMUK1MQrNqexQRSYsdX5jWgddyyPyXSu5YpOa8dqqsjWMQZ970UbEe3SinOb9
 +r8MGTMwnXKA06XNOBM+dbyF1VMCn7vbij7h66YCnhB36H5aCKl1T7hmEmxlG3NeWgRH3PV
 yUukGthNIes6Ypoc5pj4AP5q+5OYOj4O9kWsftkscuVvINLWzTI8KMSGmJVYeAQbLRf8pnq
 b3MTpUdkFcykoO+tQBQ3735LC51rn4hBVpa8pE3VY5chk4DcsifndNFiJPoaRDIancEqaqp
 bmW/buSF1xhxJi/U3UC+bdus68nAI6GPOVIF2wqyTthSCLGQ9CDkHCCaBYW2cb2F+FYtyOq
 KbqnAoGCbi1e2SltIKCcVAdPgq4rvjCLqLhDHnQd5FoLcbQQnz8lmit2lOVt3T8T60pA8dY
 myb6UGN2ZAyAE7X2zXzyN/gorESgUyHJpPgfOnCtHr0ZzgpTnQBOxc8b7REtP/ToC9S1rLV
 WF51GX007V5IHwHY2svfyNfug2IAuX5b0yBmX+zpj9f2Bcfso9FU/ctLBXx1SLNnX0vaUMA
 KPVY6Z9l1bY1fSd0RCqSo41QV7Xwt0vayB8vVvK9cdIq4sNBRUfjSTwXlfbdIVkUKI7jKxr
 lyo7V8IEohZpxYNCXUN4uQHnIH/kNcoH2mJpTgFvSZYaOx3ZiwRY8mKB4qXoWLFzinYbfO9
 E/5zrXlUecQf+dN7LJr6UMsJ3iv1k2fsS6iUOVj/p/6zjt0qYLy2z0CkQ/SzZhC02WSglxN
 HiUSf8aetpHNvUrdUVL4Izj4VHffPkxLUkamyg/szGih5910oDlzhbTB448Rb8ctjl+mHR0
 Od91sCmDrrqyeBjuwtVyrwqjVdF+gzEd6VPf3n5PcNt9hHKto5lRodC74JtC/Gg7KR8Scjf
 6474bbYmoT1SGCJfbT5on/P0GPlqlyw2OJvvVeO3aDcuEyi8SAM2MyFUDNITs4COE+ses1e
 9EQkGZTUmN2E9oEKPQ
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
across multiple descriptors,Otherwise, it may cause
TSO fragmentation anomalies.

Fixes: 4530e70f1e32 ("net/rnp: support Tx TSO offload")
Cc: stable@dpdk.org

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/rnp_rxtx.c | 48 ++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 62e2eec007..eacee1a8de 100644
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
@@ -1392,6 +1407,10 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -1414,8 +1433,11 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
@@ -1428,11 +1450,29 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
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
2.25.1

