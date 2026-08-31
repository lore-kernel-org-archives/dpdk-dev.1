Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C4CC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:44:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F366940A6F;
	Mon, 31 Aug 2026 04:44:10 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 7B86240431;
 Mon, 31 Aug 2026 04:44:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADH0T9z6pRqcNijBg--.54833S2;
 Mon, 31 Aug 2026 10:44:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 31/47] net/sxe2: fix NEON Rx ptype mapping and memory
 ordering
Date: Mon, 31 Aug 2026 10:44:03 +0800
Message-ID: <20260831024403.3231082-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADH0T9z6pRqcNijBg--.54833S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr1rCFW7uw4xCr48ArWkWFg_yoWDWF45pF
 W5GF4UGF18tw43Kwn3AFsxZ34UCFWxtr1I9395u34Fya1xJr4IvFWYyr9rAFW8GF9rC3sY
 vanrWa17Xay2krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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

Compute the descriptor lower/upper dwords (desc_lo/desc_hi) once per
loop iteration and pass them to sxe2_rx_desc_ptype_fill_neon() and
sxe2_rx_desc_offloads_para_fill_neon(). Map the packet_type lanes
from desc_lo lanes 1/3/5/7, fixing the previous lane ordering that
mapped pkt0/1/2/3 from lanes 5/1/7/3.

Drop three of the four rte_atomic_thread_fence(acquire) barriers
between the descriptor loads in sxe2_rx_pkts_common_vec_neon(); the
single acquire fence after the descriptor set is loaded is sufficient
for the Rx producer/consumer ordering.

Fixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")
Cc: stable@dpdk.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx_vec_neon.c | 132 +++++++++++++-------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
index 6b4c70c7ac..0b139b8269 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_neon.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
@@ -213,22 +213,24 @@ uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue,
 }
 
 static __rte_always_inline void
-sxe2_rx_desc_ptype_fill_neon(uint16x8_t staterr, struct rte_mbuf **__rte_restrict rx_pkts)
+sxe2_rx_desc_ptype_fill_neon(uint32x4_t desc_lo,
+							 struct rte_mbuf **__rte_restrict rx_pkts,
+							 const uint32_t *__rte_restrict ptype_tbl)
 {
-	uint16x8_t ptype_mask = {
-		0, 0x3FFULL,
-		0, 0x3FFULL,
-		0, 0x3FFULL,
-		0, 0x3FFULL,
+	const uint32x4_t ptype_mask = {
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
+		SXE2_RX_DESC_PTYPE_MASK_NO_SHIFT << 16,
 	};
 	uint16x8_t ptype_all;
 
-	ptype_all = vandq_u16(staterr, ptype_mask);
+	ptype_all = vreinterpretq_u16_u32(vandq_u32(desc_lo, ptype_mask));
 
-	rx_pkts[3]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
-	rx_pkts[2]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
-	rx_pkts[1]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
-	rx_pkts[0]->packet_type = sxe2_ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+	rx_pkts[0]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
+	rx_pkts[1]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
+	rx_pkts[2]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+	rx_pkts[3]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
 }
 
 static __rte_always_inline uint32x4_t
@@ -271,9 +273,10 @@ sxe2_rx_desc_fnav_flags_neon(uint64x2_t descs_arr[4])
 static __rte_always_inline void
 sxe2_rx_desc_offloads_para_fill_neon(struct sxe2_rx_queue *rxq,
 			volatile union sxe2_rx_desc *desc,
-			uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
+			uint64x2_t descs[4], uint32x4_t desc_lo, uint32x4_t desc_hi,
+			struct rte_mbuf **rx_pkts)
 {
-	uint32x4_t desc_lo, desc_hi, flags, tmp_flags;
+	uint32x4_t flags, tmp_flags;
 	const uint64x2_t mbuf_init = {rxq->mbuf_init_value, 0};
 	uint64x2_t rearm0, rearm1, rearm2, rearm3;
 
@@ -330,23 +333,6 @@ sxe2_rx_desc_offloads_para_fill_neon(struct sxe2_rx_queue *rxq,
 		0, 0, 0, 0, 0, 0, 0, 0
 	};
 
-	{
-		uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
-		uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
-		uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
-		uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
-		uint64x2_t f64, t64;
-
-		flags = vzip2q_u32(d1, d0);
-		tmp_flags = vzip2q_u32(d3, d2);
-		f64 = vreinterpretq_u64_u32(flags);
-		t64 = vreinterpretq_u64_u32(tmp_flags);
-		desc_lo = vreinterpretq_u32_u64(vcombine_u64(vget_low_u64(f64),
-							     vget_low_u64(t64)));
-		desc_hi = vreinterpretq_u32_u64(vcombine_u64(vget_high_u64(f64),
-							     vget_high_u64(t64)));
-	}
-
 	desc_lo = vandq_u32(desc_lo, desc_msk);
 	desc_hi = vandq_u32(desc_hi, rss_msk);
 
@@ -505,25 +491,39 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		uint64x2_t descs[SXE2_RX_NUM_PER_LOOP_NEON];
 		uint8x16_t pkt_mb1, pkt_mb2, pkt_mb3, pkt_mb4;
 		uint64x2_t mbp1, mbp2;
+		uint32x4_t desc_lo, desc_hi;
 		uint16x8_t staterr;
 		uint16x8_t tmp;
 		uint16_t bit_num;
 
 		descs[3] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 3));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[2] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 2));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[1] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc + 1));
-		rte_atomic_thread_fence(rte_memory_order_acquire);
 		descs[0] = vld1q_u64(RTE_CAST_PTR(uint64_t *, desc));
 
 		rte_atomic_thread_fence(rte_memory_order_acquire);
-
 		descs[3] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 3), descs[3], 0);
 		descs[2] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 2), descs[2], 0);
 		descs[1] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc + 1), descs[1], 0);
 		descs[0] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, desc), descs[0], 0);
 
+		{
+			uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
+			uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
+			uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
+			uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
+
+			uint32x4_t q1_01 = vzip2q_u32(d0, d1);
+			uint32x4_t q1_23 = vzip2q_u32(d2, d3);
+			uint64x2_t q1_01_64 = vreinterpretq_u64_u32(q1_01);
+			uint64x2_t q1_23_64 = vreinterpretq_u64_u32(q1_23);
+
+			desc_lo = vreinterpretq_u32_u64(vcombine_u64(vget_low_u64(q1_01_64),
+							vget_low_u64(q1_23_64)));
+			desc_hi = vreinterpretq_u32_u64(vcombine_u64(vget_high_u64(q1_01_64),
+							vget_high_u64(q1_23_64)));
+		}
+
 		mbp1 = vld1q_u64((uint64_t *)&buffer[i]);
 		mbp2 = vld1q_u64((uint64_t *)&buffer[i + 2]);
 
@@ -543,7 +543,8 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		pkt_mb1 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[0]), rvp_shuf_mask);
 
 		if (do_offload) {
-			sxe2_rx_desc_offloads_para_fill_neon(rxq, desc, descs, &rx_pkts[i]);
+			sxe2_rx_desc_offloads_para_fill_neon(rxq, desc, descs, desc_lo,
+							     desc_hi, &rx_pkts[i]);
 		} else {
 			const uint64x2_t mbuf_init = {
 				rxq->mbuf_init_value,
@@ -578,55 +579,48 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 			rte_prefetch_non_temporal(desc + SXE2_RX_NUM_PER_LOOP_NEON);
 
 		{
-			uint32x4_t d0 = vreinterpretq_u32_u64(descs[0]);
-			uint32x4_t d1 = vreinterpretq_u32_u64(descs[1]);
-			uint32x4_t d2 = vreinterpretq_u32_u64(descs[2]);
-			uint32x4_t d3 = vreinterpretq_u32_u64(descs[3]);
-			uint32x4_t sterr_tmp1 = vzip2q_u32(d1, d0);
-			uint32x4_t sterr_tmp2 = vzip2q_u32(d3, d2);
-			uint32x4_t sterr_u32 = vzip1q_u32(sterr_tmp1, sterr_tmp2);
-
-			staterr = vreinterpretq_u16_u32(sterr_u32);
+			uint16x8_t sterr_tmp1 = vzip2q_u16(vreinterpretq_u16_u64(descs[0]),
+							   vreinterpretq_u16_u64(descs[2]));
+			uint16x8_t sterr_tmp2 = vzip2q_u16(vreinterpretq_u16_u64(descs[1]),
+							   vreinterpretq_u16_u64(descs[3]));
+			staterr = vzip1q_u16(sterr_tmp1, sterr_tmp2);
 		}
 
-		sxe2_rx_desc_ptype_fill_neon(staterr, &rx_pkts[i]);
+		sxe2_rx_desc_ptype_fill_neon(desc_lo, &rx_pkts[i], sxe2_ptype_tbl);
 
 		if (umbcast_flags != NULL) {
-			uint32x4_t umbcast_mask = {
-				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
-				SXE2_RX_DESC_STATUS_UMBCAST_MASK, SXE2_RX_DESC_STATUS_UMBCAST_MASK,
-			};
-
+			const uint32x4_t umbcast_mask =
+				vdupq_n_u32(SXE2_RX_DESC_STATUS_UMBCAST_MASK);
 			uint8x16_t umbcast_shuf_mask = {
-				0x0B, 0x03, 0x0F, 0x07,
+				3, 7, 11, 15,
 				0xFF, 0xFF, 0xFF, 0xFF,
 				0xFF, 0xFF, 0xFF, 0xFF,
 				0xFF, 0xFF, 0xFF, 0xFF,
 			};
 			uint8x16_t umbcast_bits =
-				vreinterpretq_u8_u32(vandq_u32(vreinterpretq_u32_u16(staterr),
-							       umbcast_mask));
+				vreinterpretq_u8_u32(vandq_u32(desc_lo, umbcast_mask));
 
 			umbcast_bits = vqtbl1q_u8(umbcast_bits, umbcast_shuf_mask);
-			vst1q_lane_u32((uint32_t *)umbcast_flags,
-					vreinterpretq_u32_u8(umbcast_bits), 0);
+			*(uint32_t *)umbcast_flags =
+				vgetq_lane_u32(vreinterpretq_u32_u8(umbcast_bits), 0);
 			umbcast_flags += SXE2_RX_NUM_PER_LOOP_NEON;
 		}
 
 		if (split_rxe_flags) {
 			uint8x16_t eop_shuf_mask = {
-					0x08, 0x00, 0x0C, 0x04,
+					0, 2, 4, 6,
 					0xFF, 0xFF, 0xFF, 0xFF,
 					0xFF, 0xFF, 0xFF, 0xFF,
 					0xFF, 0xFF, 0xFF, 0xFF};
 			uint8x16_t eop_bits;
 			uint32x4_t rxe_mask = {
-				0x2080, 0x2080, 0x2080, 0x2080
+				0x20802080, 0x20802080, 0x20802080, 0x20802080
 			};
 			uint32x4_t rxe_bits;
 			uint32x4_t eop_mask;
 
-			eop_mask = vshlq_n_u32(vdupq_n_u32(1), SXE2_RX_DESC_STATUS_EOP_SHIFT);
+			eop_mask = vdupq_n_u32((1U << SXE2_RX_DESC_STATUS_EOP_SHIFT) |
+					(1U << (SXE2_RX_DESC_STATUS_EOP_SHIFT + 16)));
 			eop_bits = vandq_u8(vmvnq_u8(vreinterpretq_u8_u16(staterr)),
 					vreinterpretq_u8_u32(eop_mask));
 
@@ -650,12 +644,22 @@ sxe2_rx_pkts_common_vec_neon(struct sxe2_rx_queue *rxq, struct rte_mbuf **rx_pkt
 		}
 
 		{
-			uint32x4_t dd_mask = vdupq_n_u32(1);
-			uint32x4_t sterr_dd = vandq_u32(vreinterpretq_u32_u16(staterr), dd_mask);
-			uint16x4_t packed_lo = vmovn_u32(sterr_dd);
-			uint64_t dd64 = vget_lane_u64(vreinterpret_u64_u16(packed_lo), 0);
-
-			bit_num = (uint16_t)rte_popcount64(dd64);
+			const uint16x8_t dd_check = {
+				0x0001, 0x0001, 0x0001, 0x0001,
+				0, 0, 0, 0
+			};
+			uint16x8_t sterr_dd;
+			uint64_t stat;
+			sterr_dd = vandq_u16(staterr, dd_check);
+			sterr_dd = vshlq_n_u16(sterr_dd, 15);
+			sterr_dd =
+				vreinterpretq_u16_s16(vshrq_n_s16(vreinterpretq_s16_u16(sterr_dd),
+								  15));
+			stat = ~vgetq_lane_u64(vreinterpretq_u64_u16(sterr_dd), 0);
+			if (likely(stat == 0))
+				bit_num = SXE2_RX_NUM_PER_LOOP_NEON;
+			else
+				bit_num = (uint16_t)(rte_ctz64(stat) / 16);
 		}
 		done_num += bit_num;
 		if (likely(bit_num != SXE2_RX_NUM_PER_LOOP_NEON))
-- 
2.52.0

