Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBDEC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:44:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8647406BB;
	Mon, 31 Aug 2026 04:44:03 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8FFC4402BB
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:43:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADH0T9t6pRqG9ijBg--.54831S2;
 Mon, 31 Aug 2026 10:43:58 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 30/47] net/sxe2: optimize NEON Tx descriptor fill
Date: Mon, 31 Aug 2026 10:43:57 +0800
Message-ID: <20260831024357.3231065-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADH0T9t6pRqG9ijBg--.54831S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1rAF13JryxuF4Utw18Xwb_yoWrAF4Dpr
 WfXrW7CrnxJr43W34Ska15X3WYga4YgrnagFs7uF9Ivr1xJ3Wv9FyUta47Ar109Fy8Zw4F
 vrs2kay3KayrCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v3
 8UUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Add sxe2_tx_desc_fill_4_neon_simple() to write four data descriptors
with a single vst1q_u64_x4 store, and use it in
sxe2_tx_pkts_vec_neon_batch() for the non-offload path to reduce the
number of per-packet descriptor stores.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx_vec_neon.c | 77 ++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 7 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
index b51cc55368..6b4c70c7ac 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_neon.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
@@ -34,6 +34,52 @@ sxe2_tx_desc_fill_one_neon(volatile union sxe2_tx_data_desc *desc,
 	vst1q_u64(RTE_CAST_PTR(uint64_t *, desc), data_desc);
 }
 
+static __rte_always_inline void
+sxe2_tx_desc_fill_4_neon_simple(volatile union sxe2_tx_data_desc *desc,
+				struct rte_mbuf **pkts)
+{
+	uint64x2_t d0, d1, d2, d3;
+	uint64x2x4_t v;
+	const uint64_t cmd_base = ((uint64_t)SXE2_TX_DESC_DTYPE_DATA) |
+				((uint64_t)SXE2_TX_DATA_DESC_CMD_EOP) <<
+				SXE2_TX_DATA_DESC_CMD_SHIFT;
+
+	d0 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[0]),
+		cmd_base |
+		((uint64_t)pkts[0]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((uint64_t)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[0]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d1 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[1]),
+		cmd_base |
+		((uint64_t)pkts[1]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((uint64_t)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[1]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d2 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[2]),
+		cmd_base |
+		((uint64_t)pkts[2]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((uint64_t)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[2]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+	d3 = (uint64x2_t){
+		rte_pktmbuf_iova(pkts[3]),
+		cmd_base |
+		((uint64_t)pkts[3]->data_len) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT |
+		((uint64_t)SXE2_TX_DATA_DESC_MACLEN_VAL(pkts[3]->l2_len))
+				<< SXE2_TX_DATA_DESC_OFFSET_SHIFT
+	};
+
+	v.val[0] = d0;
+	v.val[1] = d1;
+	v.val[2] = d2;
+	v.val[3] = d3;
+	vst1q_u64_x4(RTE_CAST_PTR(uint64_t *, desc), v);
+}
+
 static __rte_always_inline uint16_t
 sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts,
 			uint16_t nb_pkts, bool with_offloads)
@@ -67,10 +113,18 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 
 	if (tx_num >= res_num) {
 		sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, res_num);
-
-		for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
-			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
-					SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+		if (with_offloads) {
+			for (i = 0; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+				sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+						SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+			}
+		} else {
+			for (i = 0; i + 3 < res_num - 1; i += 4, tx_pkts += 4, desc += 4)
+				sxe2_tx_desc_fill_4_neon_simple(desc, tx_pkts);
+			for (; i < res_num - 1; ++i, ++tx_pkts, ++desc) {
+				sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+						SXE2_TX_DATA_DESC_CMD_EOP, false);
+			}
 		}
 
 		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts++,
@@ -87,9 +141,18 @@ sxe2_tx_pkts_vec_neon_batch(struct sxe2_tx_queue *txq, struct rte_mbuf **tx_pkts
 
 	sxe2_tx_pkts_mbuf_fill_vec(buffer, tx_pkts, tx_num);
 
-	for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
-		sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
-				SXE2_TX_DATA_DESC_CMD_EOP, with_offloads);
+	if (with_offloads) {
+		for (i = 0; i < tx_num; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+					SXE2_TX_DATA_DESC_CMD_EOP, true);
+		}
+	} else {
+		for (i = 0; i + 3 < tx_num; i += 4, tx_pkts += 4, desc += 4)
+			sxe2_tx_desc_fill_4_neon_simple(desc, tx_pkts);
+		for (; i < tx_num; ++i, ++tx_pkts, ++desc) {
+			sxe2_tx_desc_fill_one_neon(desc, *tx_pkts,
+					SXE2_TX_DATA_DESC_CMD_EOP, false);
+		}
 	}
 
 	next_use += tx_num;
-- 
2.52.0

