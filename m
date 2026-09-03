Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7983C624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99243427D7;
	Thu,  3 Sep 2026 03:56:58 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD18427C2;
 Thu,  3 Sep 2026 03:56:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACX_znl05hq+BlABw--.23816S2;
 Thu, 03 Sep 2026 09:56:54 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 31/48] net/sxe2: fix NEON Rx ptype mapping and memory
 ordering
Date: Thu,  3 Sep 2026 09:56:53 +0800
Message-ID: <20260903015653.162227-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_znl05hq+BlABw--.23816S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr15ZrWDXFWftFW8tFW5Jrb_yoWDKF15pF
 W5Gr4UJF18ta13Kwn3AFsxZ34UCFW7tr1093yru34Fya1xJr4IvF90yr9rAFWkGF9rC3sY
 va17Wa17Xay2krJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8KsjUU
 UUU
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

Reorder the descriptor lane mapping in the NEON Rx path to use the
natural d0/d1/d2/d3 order for desc_lo/desc_hi, and update the
staterr zip (16-bit), the shuffle masks and the ptype lane
selection accordingly.

Correct the DD count in the NEON Rx path: count the leading run of done
descriptors with rte_ctz64() instead of rte_popcount64(), which
could hand up a descriptor the hardware has not yet written when DD
bits are not contiguous.

Fix the FNAV/FDIR lane order in sxe2_rx_desc_fnav_flags_neon() to
match the natural descriptor order used by the ptype and offload
paths, so FDIR flags land on the correct mbuf.

Drop three of the four rte_atomic_thread_fence(acquire) barriers
between descriptor loads; the single acquire fence after the
descriptor set is loaded is sufficient for the Rx producer/consumer
ordering.

Fixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")
Cc: stable@dpdk.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx_vec_neon.c | 136 +++++++++++++-------------
 1 file changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_neon.c b/drivers/net/sxe2/sxe2_txrx_vec_neon.c
index 6b4c70c7ac..72338ee61a 100644
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
@@ -247,8 +249,8 @@ sxe2_rx_desc_fnav_flags_neon(uint64x2_t descs_arr[4])
 	uint32x4_t d2 = vreinterpretq_u32_u64(descs_arr[2]);
 	uint32x4_t d3 = vreinterpretq_u32_u64(descs_arr[3]);
 
-	descs_tmp1 = vzip1q_u32(d1, d0);
-	descs_tmp2 = vzip1q_u32(d3, d2);
+	descs_tmp1 = vzip1q_u32(d0, d1);
+	descs_tmp2 = vzip1q_u32(d2, d3);
 
 	uint64x2_t a = vreinterpretq_u64_u32(descs_tmp1);
 	uint64x2_t b = vreinterpretq_u64_u32(descs_tmp2);
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

