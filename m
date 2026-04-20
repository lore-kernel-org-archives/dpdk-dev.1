Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B59F55809
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5428740654;
	Mon, 20 Apr 2026 12:31:06 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id C7D0A40654
 for <dev@dpdk.org>; Mon, 20 Apr 2026 12:31:04 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98E801516;
 Mon, 20 Apr 2026 03:30:58 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 787EE3F99C;
 Mon, 20 Apr 2026 03:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776681064; bh=grlWmZuX0WcbpaJPIuAHxOuDeZSPnf/YgKESzAH5vvA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vHZ36aKjHkkoLTsPcAr7Tq33AzyYqQ0DAYdi7hJPB+Q1K/3cjtZI5AXqd5A6uOB4X
 Cwq86BKKUQGmz1ZMhWPSHvnCxuvSfq6rXBRVkwz02kShiSMcgUEjIvGp7YeSwwH/fy
 z5qpu29rikVyboMuUh9PSAlp3mPLjM54Zq3zmu2A=
From: Jay Wang <jay.wang2@arm.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v2 3/3] net/iavf: add NEON support for Rx flex desc
Date: Mon, 20 Apr 2026 10:30:38 +0000
Message-ID: <20260420103042.2836732-4-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420103042.2836732-1-jay.wang2@arm.com>
References: <20260417130833.2503592-1-jay.wang2@arm.com>
 <20260420103042.2836732-1-jay.wang2@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch adds the NEON-optimised Rx paths to process receive flex
descriptor.

Signed-off-by: Jay Wang <jay.wang2@arm.com>
---
 drivers/net/intel/iavf/iavf.h               |   2 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  23 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 521 +++++++++++++++++++-
 3 files changed, 541 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 3e71d345a9..360d728f3a 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -335,6 +335,8 @@ enum iavf_rx_func_type {
 	IAVF_RX_BULK_ALLOC_FLEX_RXD,
 	IAVF_RX_NEON,
 	IAVF_RX_NEON_SCATTERED,
+	IAVF_RX_NEON_FLEX_RXD,
+	IAVF_RX_NEON_SCATTERED_FLEX_RXD,
 	IAVF_RX_AVX2,
 	IAVF_RX_AVX2_SCATTERED,
 	IAVF_RX_AVX2_OFFLOAD,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 645bc5ccf6..8e711950ff 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -713,7 +713,7 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ad->rx_bulk_alloc_allowed = false;
 	}
 
-#if defined RTE_ARCH_X86 || defined RTE_ARCH_ARM
+#if defined RTE_ARCH_X86 || defined RTE_ARCH_ARM64
 	/* check vector conflict */
 	if (ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh) &&
 			iavf_rxq_vec_setup(rxq)) {
@@ -3571,6 +3571,27 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 			.bulk_alloc = true
 		}
 	},
+	[IAVF_RX_NEON_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_vec_flex_rxd,
+		.info = "Vector Neon Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.flex_desc = true,
+			.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_NEON_SCATTERED_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_scattered_pkts_vec_flex_rxd,
+		.info = "Vector Scattered Neon Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_128,
+			.scattered = true,
+			.flex_desc = true,
+			.bulk_alloc = true
+		}
+	},
 #endif
 };
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 9c91b6bac1..9d7281e172 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -16,12 +16,445 @@
 
 #include "../common/rx_vec_arm.h"
 
-static inline void
+#define PKTLEN_SHIFT     10
+#define IAVF_UINT16_BIT (CHAR_BIT * sizeof(uint16_t))
+
+static __rte_always_inline void
 iavf_rxq_rearm(struct ci_rx_queue *rxq)
 {
 	ci_rxq_rearm(rxq);
 }
 
+static __rte_always_inline uint32x4_t
+iavf_flex_rxd_to_fdir_flags_vec(const uint32x4_t fdir_id0_3)
+{
+#define FDID_MIS_MAGIC	0xFFFFFFFFu
+	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR != (1u << 2));
+	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR_ID != (1u << 13));
+
+	const uint32x4_t pkt_fdir_bit = vdupq_n_u32((uint32_t)(RTE_MBUF_F_RX_FDIR |
+			RTE_MBUF_F_RX_FDIR_ID));
+	const uint32x4_t fdir_mis_mask = vdupq_n_u32(FDID_MIS_MAGIC);
+
+	/* desc->flow_id field == 0xFFFFFFFF means fdir mismatch */
+	uint32x4_t fdir_mask = vceqq_u32(fdir_id0_3, fdir_mis_mask);
+
+	/* xor with 0xFFFFFFFF bit-reverses the mask */
+	fdir_mask = veorq_u32(fdir_mask, fdir_mis_mask);
+	const uint32x4_t fdir_flags = vandq_u32(fdir_mask, pkt_fdir_bit);
+
+	return fdir_flags;
+}
+
+static __rte_always_inline void
+iavf_flex_rxd_to_olflags_v(struct ci_rx_queue *rxq, uint64x2_t descs[4],
+		struct rte_mbuf **rx_pkts)
+{
+	const uint64x2_t mbuf_init = {rxq->mbuf_initializer, 0};
+	uint64x2_t rearm0, rearm1, rearm2, rearm3;
+
+	uint32x4_t tmp_desc, flags, rss_vlan;
+
+	/* mask everything except checksum, RSS, and VLAN flags
+	 * bit fields defined in enum iavf_rx_flex_desc_status_error_0_bits
+	 * bit 7:4 for checksum
+	 * bit 12 for RSS indication
+	 * bit 13 for VLAN indication
+	 */
+	const uint32x4_t desc_mask = {0x30f0, 0x30f0, 0x30f0, 0x30f0};
+	const uint32x4_t cksum_mask = {
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_MASK | RTE_MBUF_F_RX_L4_CKSUM_MASK |
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD,
+	};
+
+	/* map the checksum, rss and vlan fields to the checksum, rss
+	 * and vlan flags.
+	 */
+	const uint8x16_t cksum_flags = {
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_L4_CKSUM_BAD |
+		 RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_GOOD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_GOOD) >> 1,
+		(RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD >> 20 | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD |
+		 RTE_MBUF_F_RX_L4_CKSUM_BAD | RTE_MBUF_F_RX_IP_CKSUM_BAD) >> 1
+	};
+
+	const uint8x16_t rss_vlan_flags = {
+		0, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+		RTE_MBUF_F_RX_RSS_HASH | RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED,
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+		0, 0, 0, 0,
+	};
+
+	/* extract status_error0 field from 4 descriptors,
+	 * and mask out everything else not in desc_mask
+	 */
+	flags = vzip2q_u32(vreinterpretq_u32_u64(descs[0]),
+				vreinterpretq_u32_u64(descs[1]));
+	tmp_desc = vzip2q_u32(vreinterpretq_u32_u64(descs[2]),
+				vreinterpretq_u32_u64(descs[3]));
+	tmp_desc = vreinterpretq_u32_u64(vzip1q_u64(vreinterpretq_u64_u32(flags),
+				vreinterpretq_u64_u32(tmp_desc)));
+
+	tmp_desc = vandq_u32(tmp_desc, desc_mask);
+
+	/* shift each 32-bit lane right by 4 so that we can use
+	 * the checksum bit as an index into cksum_flags
+	 */
+	tmp_desc = vshrq_n_u32(tmp_desc, 4);
+	flags = vreinterpretq_u32_u8(vqtbl1q_u8(cksum_flags,
+				vreinterpretq_u8_u32(tmp_desc)));
+	/* shift left by 1 bit since we shift right by 1 bit
+	 * in cksum_flags
+	 */
+	flags = vshlq_n_u32(flags, 1);
+
+	/* first check the outer L4 checksum */
+	uint32x4_t l4_outer_mask = {0x6, 0x6, 0x6, 0x6};
+	uint32x4_t l4_outer_flags = vandq_u32(flags, l4_outer_mask);
+	l4_outer_flags = vshlq_n_u32(l4_outer_flags, 20);
+
+	/* then check the rest of cksum bits */
+	uint32x4_t l3_l4_mask = {~0x6, ~0x6, ~0x6, ~0x6};
+	uint32x4_t l3_l4_flags = vandq_u32(flags, l3_l4_mask);
+	flags = vorrq_u32(l3_l4_flags, l4_outer_flags);
+
+	/* only keep the cksum flags in flags */
+	flags = vandq_u32(flags, cksum_mask);
+
+	/* map RSS, VLAN flags in HW desc to RTE_MBUF */
+	tmp_desc = vshrq_n_u32(tmp_desc, 8);
+	rss_vlan = vreinterpretq_u32_u8(vqtbl1q_u8(rss_vlan_flags,
+				vreinterpretq_u8_u32(tmp_desc)));
+
+	/* merge the flags */
+	flags = vorrq_u32(flags, rss_vlan);
+
+	/* check the additional fdir_flags if fdir is enabled */
+	if (rxq->fdir_enabled) {
+		const uint32x4_t fdir_id0_1 =
+			vzip2q_u32(vreinterpretq_u32_u64(descs[0]),
+				vreinterpretq_u32_u64(descs[1]));
+		const uint32x4_t fdir_id2_3 =
+			vzip2q_u32(vreinterpretq_u32_u64(descs[2]),
+				vreinterpretq_u32_u64(descs[3]));
+		const uint32x4_t fdir_id0_3 =
+			vreinterpretq_u32_u64(vzip2q_u64(vreinterpretq_u64_u32(fdir_id0_1),
+				vreinterpretq_u64_u32(fdir_id2_3)));
+		const uint32x4_t fdir_flags =
+			iavf_flex_rxd_to_fdir_flags_vec(fdir_id0_3);
+
+		/* merge with fdir_flags */
+		flags = vorrq_u32(flags, fdir_flags);
+
+		/* write fdir_id to mbuf */
+		rx_pkts[0]->hash.fdir.hi = vgetq_lane_u32(fdir_id0_3, 0);
+		rx_pkts[1]->hash.fdir.hi = vgetq_lane_u32(fdir_id0_3, 1);
+		rx_pkts[2]->hash.fdir.hi = vgetq_lane_u32(fdir_id0_3, 2);
+		rx_pkts[3]->hash.fdir.hi = vgetq_lane_u32(fdir_id0_3, 3);
+	}
+
+	/* At this point, we have the 4 sets of flags in the low-16-bits
+	 * of each 32-bit value in flags.
+	 * We want to extract these, and merge them with the mbuf init data
+	 * so we can do a single 16-byte write to the mbuf to set the flags
+	 * and all the other initialization fields. Extracting the appropriate
+	 * flags means that we have to do a shift and blend for each mbuf
+	 * before we do the write.
+	 */
+	rearm0 = vsetq_lane_u64(vgetq_lane_u32(flags, 0), mbuf_init, 1);
+	rearm1 = vsetq_lane_u64(vgetq_lane_u32(flags, 1), mbuf_init, 1);
+	rearm2 = vsetq_lane_u64(vgetq_lane_u32(flags, 2), mbuf_init, 1);
+	rearm3 = vsetq_lane_u64(vgetq_lane_u32(flags, 3), mbuf_init, 1);
+
+	/* compile time check */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
+					 offsetof(struct rte_mbuf, rearm_data) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
+					 RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
+
+	/* write the rearm data and the olflags in one write */
+	vst1q_u64((uint64_t *)&rx_pkts[0]->rearm_data, rearm0);
+	vst1q_u64((uint64_t *)&rx_pkts[1]->rearm_data, rearm1);
+	vst1q_u64((uint64_t *)&rx_pkts[2]->rearm_data, rearm2);
+	vst1q_u64((uint64_t *)&rx_pkts[3]->rearm_data, rearm3);
+}
+
+static __rte_always_inline void
+iavf_flex_rxd_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **rx_pkts,
+	uint32_t *ptype_tbl)
+{
+	const uint16x8_t ptype_mask = {
+		0, IAVF_RX_FLEX_DESC_PTYPE_M,
+		0, IAVF_RX_FLEX_DESC_PTYPE_M,
+		0, IAVF_RX_FLEX_DESC_PTYPE_M,
+		0, IAVF_RX_FLEX_DESC_PTYPE_M
+	};
+
+	uint32x4_t ptype_01 = vzip1q_u32(vreinterpretq_u32_u64(descs[0]),
+				vreinterpretq_u32_u64(descs[1]));
+	uint32x4_t ptype_23 = vzip1q_u32(vreinterpretq_u32_u64(descs[2]),
+				vreinterpretq_u32_u64(descs[3]));
+	uint32x4_t ptype_all_u32 =
+				vreinterpretq_u32_u64(vzip1q_u64(vreinterpretq_u64_u32(ptype_01),
+					vreinterpretq_u64_u32(ptype_23)));
+	uint16x8_t ptype_all = vreinterpretq_u16_u32(ptype_all_u32);
+
+	ptype_all = vandq_u16(ptype_all, ptype_mask);
+
+	rx_pkts[0]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 1)];
+	rx_pkts[1]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 3)];
+	rx_pkts[2]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 5)];
+	rx_pkts[3]->packet_type = ptype_tbl[vgetq_lane_u16(ptype_all, 7)];
+}
+
+/**
+ * vPMD raw receive routine for flex RxD,
+ * only accept(nb_pkts >= IAVF_VPMD_DESCS_PER_LOOP)
+ *
+ * Notice:
+ * - nb_pkts < IAVF_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a IAVF_VPMD_DESCS_PER_LOOP power-of-two
+ */
+static inline uint16_t
+_recv_raw_pkts_vec_flex_rxd(struct ci_rx_queue *__rte_restrict rxq,
+		   struct rte_mbuf **__rte_restrict rx_pkts,
+		   uint16_t nb_pkts, uint8_t *split_packet)
+{
+	struct iavf_adapter *adapter = rxq->iavf_vsi->adapter;
+	uint32_t *ptype_tbl = adapter->ptype_tbl;
+	volatile union ci_rx_flex_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
+	uint16_t nb_pkts_recd;
+	int pos;
+
+	uint16x8_t crc_adjust = {
+		0, 0,			/* ignore pkt_type field */
+		rxq->crc_len,	/* sub crc on pkt_len */
+		0,				/* ignore high 16 bits of pkt_len */
+		rxq->crc_len,	/* sub crc on data_len */
+		0, 0, 0			/* ignore non-length fields */
+	};
+
+	/* mask to shuffle from flex descriptor to mbuf */
+	const uint8x16_t shuf_msk = {
+		0xFF, 0xFF,		/* pkt_type set as unknown */
+		0xFF, 0xFF,		/* pkt_type set as unknown */
+		4, 5,			/* octet 4~5, low bits pkt_len */
+		0xFF, 0xFF,		/* skip high 16 bits pkt_len, zero out */
+		4, 5,			/* octet 4~5, 16 bits data_len */
+		10, 11,			/* octet 10~11, 16 bits vlan_macip */
+		0xFF, 0xFF,		/* rss hash parsed separately */
+		0xFF, 0xFF,
+	};
+
+	/* compile-time check the above crc_adjust layout is correct */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			 offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+
+	/* 4 packets DD mask */
+	const uint16x8_t dd_check = {
+		0x0001, 0x0001, 0x0001, 0x0001,
+		0, 0, 0, 0
+	};
+
+	/* 4 packets EOP mask */
+	const uint8x16_t eop_check = {
+		0x2, 0, 0x2, 0, 0x2, 0, 0x2, 0,
+		0, 0, 0, 0, 0, 0, 0, 0
+	};
+
+	/* nb_pkts has to be floor-aligned to IAVF_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, IAVF_VPMD_DESCS_PER_LOOP);
+
+	rxdp = rxq->rx_flex_ring + rxq->rx_tail;
+	rte_prefetch0(rxdp);
+
+	/* see if we need to rearm the Rx queue */
+	if (rxq->rxrearm_nb > rxq->rx_free_thresh)
+		iavf_rxq_rearm(rxq);
+
+	/* check if there is actually a packet available */
+	if (!(rxdp->wb.status_error0 &
+			rte_cpu_to_le_32(1 << IAVF_RX_FLEX_DESC_STATUS0_DD_S)))
+		return 0;
+
+	/* move the next 'n' mbufs into the cache */
+	sw_ring = &rxq->sw_ring[rxq->rx_tail];
+
+	/* A. load 4 packets in a loop
+	 * [A*. mask out the unused dirty fields in flex desc]
+	 * B. copy 4 mbuf point from swring to rx_pkts
+	 * C. count the number of DD bits in the 4 packets
+	 * [C*. extract the end-of-packet bit, if requested]
+	 * D. fill info from flex desc to mbuf
+	 */
+	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
+		 pos += IAVF_VPMD_DESCS_PER_LOOP,
+		 rxdp += IAVF_VPMD_DESCS_PER_LOOP) {
+		uint64x2_t descs[IAVF_VPMD_DESCS_PER_LOOP];
+		uint8x16_t pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
+		uint16x8_t sterr_tmp1, sterr_tmp2;
+		uint64x2_t mbp1, mbp2;
+		uint16x8_t staterr;
+		uint16x8_t tmp;
+		uint64_t stat;
+
+		/* A.1 load descs[3-0] */
+		descs[3] = vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 3));
+		descs[2] = vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 2));
+		descs[1] = vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 1));
+		descs[0] = vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 0));
+
+		/* use acquire fence to order loads of descriptor qwords */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		/* A.2 reload qword0 to make it ordered after qword1 load */
+		descs[3] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 3),
+					descs[3], 0);
+		descs[2] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 2),
+					descs[2], 0);
+		descs[1] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 1),
+					descs[1], 0);
+		descs[0] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp),
+					descs[0], 0);
+
+		/* B.1 load 4 mbuf pointers */
+		mbp1 = vld1q_u64((uint64_t *)&sw_ring[pos]);
+		mbp2 = vld1q_u64((uint64_t *)&sw_ring[pos + 2]);
+
+		/* B.2 copy 4 mbuf pointers into rx_pkts */
+		vst1q_u64((uint64_t *)&rx_pkts[pos], mbp1);
+		vst1q_u64((uint64_t *)&rx_pkts[pos + 2], mbp2);
+
+		/* prefetch mbufs if it is a chained buffer */
+		if (split_packet) {
+			rte_mbuf_prefetch_part2(rx_pkts[pos]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 3]);
+		}
+
+		iavf_flex_rxd_to_olflags_v(rxq, descs, &rx_pkts[pos]);
+
+		/* D.1 pkts convert format from desc to pktmbuf */
+		pkt_mb3 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[3]), shuf_msk);
+		pkt_mb2 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[2]), shuf_msk);
+		pkt_mb1 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[1]), shuf_msk);
+		pkt_mb0 = vqtbl1q_u8(vreinterpretq_u8_u64(descs[0]), shuf_msk);
+
+		/* D.2 pkts set in in_port/nb_seg and remove crc */
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb3), crc_adjust);
+		pkt_mb3 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb2), crc_adjust);
+		pkt_mb2 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb1), crc_adjust);
+		pkt_mb1 = vreinterpretq_u8_u16(tmp);
+		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb0), crc_adjust);
+		pkt_mb0 = vreinterpretq_u8_u16(tmp);
+
+		/* D.3 copy final data to rx_pkts */
+		vst1q_u8((void *)&rx_pkts[pos + 3]->rx_descriptor_fields1, pkt_mb3);
+		vst1q_u8((void *)&rx_pkts[pos + 2]->rx_descriptor_fields1, pkt_mb2);
+		vst1q_u8((void *)&rx_pkts[pos + 1]->rx_descriptor_fields1, pkt_mb1);
+		vst1q_u8((void *)&rx_pkts[pos + 0]->rx_descriptor_fields1, pkt_mb0);
+
+		iavf_flex_rxd_to_ptype_v(descs, &rx_pkts[pos], ptype_tbl);
+
+		/* C.1 filter staterr info only */
+		sterr_tmp2 = vzip2q_u16(vreinterpretq_u16_u64(descs[2]),
+						vreinterpretq_u16_u64(descs[3]));
+		sterr_tmp1 = vzip2q_u16(vreinterpretq_u16_u64(descs[0]),
+						vreinterpretq_u16_u64(descs[1]));
+
+		/* C.2 get 4 pkts status_error0 value */
+		staterr = vzip1q_u16(sterr_tmp1, sterr_tmp2);
+
+		/* C* extract and record EOP bits */
+		if (split_packet) {
+			uint8x16_t eop_bits;
+
+			/* and with mask to extract bits, flipping 1-0 */
+			eop_bits = vmvnq_u8(vreinterpretq_u8_u16(staterr));
+			eop_bits = vandq_u8(eop_bits, eop_check);
+
+			/* store the 32-bit value */
+			vst1q_lane_u32((uint32_t *)split_packet,
+							vreinterpretq_u32_u8(eop_bits), 0);
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP;
+		}
+
+		/* C.3 count available number of descriptors */
+		/* mask everything except DD bit */
+		staterr = vandq_u16(staterr, dd_check);
+		/* move the status bit (bit0) into the sign bit (bit15)
+		 * of each 16-bit lane
+		 */
+		staterr = vshlq_n_u16(staterr, IAVF_UINT16_BIT - 1);
+
+		/* reinterpret staterr as a signed 16-bit and
+		 * arithmetic-shift-right by 15
+		 * each lane becomes 0xFFFF if original DD bit was 1, otherwise 0.
+		 * then interpret back to unsigned u16 vector
+		 */
+		staterr = vreinterpretq_u16_s16(vshrq_n_s16(vreinterpretq_s16_u16(staterr),
+					IAVF_UINT16_BIT - 1));
+
+		/* reinterpret u16x8 vector as u64x2, and fetch the low u64
+		 * which contains the first four 16-bit lanes, and invert all bits
+		 */
+		stat = ~vgetq_lane_u64(vreinterpretq_u64_u16(staterr), 0);
+
+		if (unlikely(stat == 0)) {
+			nb_pkts_recd += IAVF_VPMD_DESCS_PER_LOOP;
+		} else {
+			nb_pkts_recd += rte_ctz64(stat) / IAVF_UINT16_BIT;
+			break;
+		}
+	}
+
+	/* Update our internal tail pointer */
+	rxq->rx_tail = (uint16_t)(rxq->rx_tail + nb_pkts_recd);
+	rxq->rx_tail = (uint16_t)(rxq->rx_tail & (rxq->nb_rx_desc - 1));
+	rxq->rxrearm_nb = (uint16_t)(rxq->rxrearm_nb + nb_pkts_recd);
+
+	return nb_pkts_recd;
+}
+
 static inline void
 desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
 		  uint64x2_t descs[4], struct rte_mbuf **rx_pkts)
@@ -115,9 +548,6 @@ desc_to_olflags_v(struct ci_rx_queue *rxq, volatile union ci_rx_desc *rxdp,
 	vst1q_u64((uint64_t *)&rx_pkts[3]->rearm_data, rearm3);
 }
 
-#define PKTLEN_SHIFT     10
-#define IAVF_UINT16_BIT (CHAR_BIT * sizeof(uint16_t))
-
 static inline void
 desc_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **__rte_restrict rx_pkts,
 		uint32_t *__rte_restrict ptype_tbl)
@@ -379,6 +809,19 @@ iavf_recv_pkts_vec(void *__rte_restrict rx_queue,
 	return _recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
 }
 
+/*
+ * Notice:
+ * - nb_pkts < IAVF_VPMD_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts > IAVF_VPMD_RX_BURST, only scan IAVF_VPMD_RX_BURST
+ *   numbers of DD bits
+ */
+uint16_t
+iavf_recv_pkts_vec_flex_rxd(void *__rte_restrict rx_queue,
+		struct rte_mbuf **__rte_restrict rx_pkts, uint16_t nb_pkts)
+{
+	return _recv_raw_pkts_vec_flex_rxd(rx_queue, rx_pkts, nb_pkts, NULL);
+}
+
 /*
  * vPMD receive routine that reassembles single burst of 32 scattered
  * packets.
@@ -445,6 +888,76 @@ iavf_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
 			rx_pkts + retval, nb_pkts);
 }
 
+/**
+ * vPMD receive routine that reassembles single burst of 32 scattered packets
+ * for flex RxD
+ *
+ * Notice:
+ * - nb_pkts < IAVF_VPMD_DESCS_PER_LOOP, just return no packet
+ */
+static uint16_t
+iavf_recv_scattered_burst_vec_flex_rxd(void *rx_queue,
+				       struct rte_mbuf **rx_pkts,
+				       uint16_t nb_pkts)
+{
+	struct ci_rx_queue *rxq = rx_queue;
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
+	unsigned int i = 0;
+
+	/* get some new buffers */
+	uint16_t nb_bufs = _recv_raw_pkts_vec_flex_rxd(rxq, rx_pkts, nb_pkts,
+					      split_flags);
+	if (nb_bufs == 0)
+		return 0;
+
+	/* happy day case, full burst + no packets to be joined */
+	const uint64_t *split_fl64 = (uint64_t *)split_flags;
+
+	if (!rxq->pkt_first_seg &&
+	    split_fl64[0] == 0 && split_fl64[1] == 0 &&
+	    split_fl64[2] == 0 && split_fl64[3] == 0)
+		return nb_bufs;
+
+	/* reassemble any packets that need reassembly*/
+	if (!rxq->pkt_first_seg) {
+		/* find the first split flag, and only reassemble then*/
+		while (i < nb_bufs && !split_flags[i])
+			i++;
+		if (i == nb_bufs)
+			return nb_bufs;
+		rxq->pkt_first_seg = rx_pkts[i];
+	}
+	return i + ci_rx_reassemble_packets(&rx_pkts[i], nb_bufs - i, &split_flags[i],
+			&rxq->pkt_first_seg, &rxq->pkt_last_seg, rxq->crc_len);
+}
+
+/**
+ * vPMD receive routine that reassembles scattered packets for flex RxD
+ */
+uint16_t
+iavf_recv_scattered_pkts_vec_flex_rxd(void *rx_queue,
+				      struct rte_mbuf **rx_pkts,
+				      uint16_t nb_pkts)
+{
+	uint16_t retval = 0;
+
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
+		uint16_t burst;
+
+		burst = iavf_recv_scattered_burst_vec_flex_rxd(rx_queue,
+						rx_pkts + retval,
+						IAVF_VPMD_RX_BURST);
+		retval += burst;
+		nb_pkts -= burst;
+		if (burst < IAVF_VPMD_RX_BURST)
+			return retval;
+	}
+
+	return retval + iavf_recv_scattered_burst_vec_flex_rxd(rx_queue,
+						      rx_pkts + retval,
+						      nb_pkts);
+}
+
 static __rte_always_inline void
 iavf_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
 	 uint64_t flags)
-- 
2.43.0

