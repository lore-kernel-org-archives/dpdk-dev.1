Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0863C7115A
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:11:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D76BE42DB1;
	Wed, 18 Jun 2025 14:11:32 +0200 (CEST)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id A142642D7B;
 Wed, 18 Jun 2025 14:11:30 +0200 (CEST)
X-QQ-mid: esmtpgz13t1750248687tf81333fb
X-QQ-Originating-IP: 3gUASBuBQpp9HhNOvza7MiSCIEG0LfvXcaO2+LBo3O0=
Received: from localhost.localdomain ( [203.174.112.180])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 18 Jun 2025 20:11:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6455213620305623119
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: stephen@networkplumber.org,
	Wenbo Cao <caowenbo@mucse.com>
Cc: dev@dpdk.org,
	yaojun@mucse.com,
	stable@dpdk.org
Subject: [PATCH v1 3/3] net/rnp: fix TSO segmentation for packets of 64KB
Date: Wed, 18 Jun 2025 20:11:13 +0800
Message-Id: <20250618121113.17302-4-caowenbo@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618121113.17302-1-caowenbo@mucse.com>
References: <20250618121113.17302-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OewEkx7CcodnOQ1xe/BZ8yHkoP7EoDKmkpFQdOsMQWWb95f+nnd2m3Eh
 NfK0iYGkOd/lXjiSOXGvLc0HHWZG7CPORVhQlDiKBf1tpSnXwZlz5MTVEj1Fwban0lcMQa6
 hH+N1ZdGIt4JmJ6Nv3+nwNyH8ZVB4sQY8BPoqZoJkCEGjVlIx8arFpm3fwCWu5YyCZcavEK
 891poFG0O/uN6TkoltB9auS1jdSEYhy0scEabWdMSndHYtSjQRLT7OX7r1VFOccP5mR9lAa
 Ws0zr25QSXJ/FiV+X0kaPyZrkfcdRahL/crOdMRtRTiuSEU0No94grHMuiygDTB6oYsWcIi
 KD4RdiifiFJt78W6oSvCF/XYcK2iS3MVhQQoFw62/PNP4tE9vwLSN8j6ANXdcoctLXbDNBL
 th/OS2qvmLIjAJQWKCvlWpYN9PsLIGDok9/vPBAc2f5MzoKxpE/VFPneGdhtnFFsKPKSIa4
 PlRITBhvTZEiWsZ5dC4Hs1qS888Q6TTMSQgBFih1JHYSzZ98o1KAMqeqeSvNEzLSLZJc9xo
 D7u21jEQqgCHa4V2J0dRI8zN64WN4DTilKJCnpA8iXNHuyKKjGc4NvzIkaYvwYdlJaTrIy7
 qz6lRwFEZLBpqMuMRwwd+n6OPEB0lQi35eIVePTIuIoD2qDYupf1iQg30uk5m8XLRprtOSw
 FL6S/hqKIemozFyT5ZKoZXtVvOYF2+J6q7+2DUAArZVtiVP24YRsO8bqQQMAR3ZQw1cd8/f
 Pi/L4+6YgoI6QQTnJB7KGleh3gi36qmm8432TMmGNrK8B7XHLxzRVc5JxpBb6yOA8ed1YSQ
 j5mLqYixaUV8zHrSMHvVe2a7JqWnT7cVHDeSGDhKxUCEx+vBY5ybqY8fKdn7yiNFXD7f1/o
 UjNHF551TOCncsjUiYQzWpaC12He6of9ACpESGwdYXYKjnXVHecCcsUR1KOD1Olwp9Y0497
 XH628NEmxNmcg5/ZlSpN9TEKTEBbJY40By+Nwq7dP2r77ZwPsJKlNftYUjUCdUkRlnQ32Ib
 kzQsZ47/vlCj+LbMA03ezLHnByT69Uni+w6yQsF21Ogxj0dTcvgMPsc9A/Nih+1hpWn1smO
 3twqvQl0U8HXBylVh0uYacUMFFtHfeqoQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
2.25.1

