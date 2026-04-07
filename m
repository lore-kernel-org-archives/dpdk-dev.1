Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05837FF5104
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:12:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC3384060A;
	Tue,  7 Apr 2026 17:12:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5CFA54025F
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:12:43 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C955B3293;
 Tue,  7 Apr 2026 08:12:36 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 63B5E3F7D8;
 Tue,  7 Apr 2026 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1775574762; bh=ogCINwqwglDMF6cfm/voSqktWXBpV56u0O0ns7SxJSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R9b0HHjsjJDKh9Ae/yWD0A9BrCJpJt+nzrdyS7/vMD1D1E4ocd1gBuVSdah88ol3U
 PJpwcFEtuwBHlBTj+sQyLPg94uddoHnmBKKnDbQJ7Gk5gMz52TwX4qk4Krp+pVTYOc
 NVraqkq9PSLc273s9SgRRMKhlvZ7GuC/DXW7M+xs=
From: Jay Wang <jay.wang2@arm.com>
To: Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v1 1/1] net/ice: add Neon-optimised Rx/Tx vector paths
Date: Tue,  7 Apr 2026 15:12:22 +0000
Message-ID: <20260407151225.1416270-2-jay.wang2@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407151225.1416270-1-jay.wang2@arm.com>
References: <20260324162525.4083381-3-jay.wang2@arm.com>
 <20260407151225.1416270-1-jay.wang2@arm.com>
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

This patch adds the Neon-optimised Rx and Tx paths to the ice driver.

Tested on Ampere One platform with Intel E810-C NIC and 100G connection.
Tested with a single core and testpmd io forwarding mode. Observed
~30% performance boost in the above test compared to the default scalar
path.

Signed-off-by: Jay Wang <jay.wang2@arm.com>
---
 .mailmap                                  |   1 +
 drivers/net/intel/ice/ice_ethdev.h        |   3 +
 drivers/net/intel/ice/ice_rxtx.c          |  53 +-
 drivers/net/intel/ice/ice_rxtx.h          |   6 +
 drivers/net/intel/ice/ice_rxtx_vec_neon.c | 747 ++++++++++++++++++++++
 drivers/net/intel/ice/meson.build         |   2 +
 6 files changed, 810 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/intel/ice/ice_rxtx_vec_neon.c

diff --git a/.mailmap b/.mailmap
index beccc84425..dfe92b0399 100644
--- a/.mailmap
+++ b/.mailmap
@@ -695,6 +695,7 @@ Javen Xu <javen_xu@realsil.com.cn>
 Jay Ding <jay.ding@broadcom.com>
 Jay Jayatheerthan <jay.jayatheerthan@intel.com>
 Jay Rolette <rolette@infiniteio.com>
+Jay Wang <jay.wang2@arm.com>
 Jay Zhou <jianjay.zhou@huawei.com>
 Jayaprakash Shanmugam <jayaprakash.shanmugam@intel.com>
 Jean Dao <jean.dao@6wind.com>
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 4b3718f715..f6fd3bf106 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -204,6 +204,8 @@ enum ice_rx_func_type {
 	ICE_RX_AVX512_SCATTERED,
 	ICE_RX_AVX512_OFFLOAD,
 	ICE_RX_AVX512_SCATTERED_OFFLOAD,
+	ICE_RX_NEON,
+	ICE_RX_NEON_SCATTERED,
 };
 
 enum ice_tx_func_type {
@@ -213,6 +215,7 @@ enum ice_tx_func_type {
 	ICE_TX_AVX2_OFFLOAD,
 	ICE_TX_AVX512,
 	ICE_TX_AVX512_OFFLOAD,
+	ICE_TX_NEON,
 };
 
 struct ice_adapter;
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 31b74be9ba..b34231c212 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -2515,7 +2515,9 @@ ice_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 	    ad->rx_func_type == ICE_RX_AVX512 ||
 	    ad->rx_func_type == ICE_RX_AVX512_SCATTERED ||
 	    ad->rx_func_type == ICE_RX_AVX512_OFFLOAD ||
-	    ad->rx_func_type == ICE_RX_AVX512_SCATTERED_OFFLOAD)
+	    ad->rx_func_type == ICE_RX_AVX512_SCATTERED_OFFLOAD ||
+	    ad->rx_func_type == ICE_RX_NEON ||
+	    ad->rx_func_type == ICE_RX_NEON_SCATTERED)
 		return ptypes;
 
 	return NULL;
@@ -3356,6 +3358,26 @@ static const struct ci_rx_path_info ice_rx_path_infos[] = {
 		}
 	},
 #endif
+#elif defined(RTE_ARCH_ARM64)
+	[ICE_RX_NEON] = {
+		.pkt_burst = ice_recv_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.bulk_alloc = true
+		}
+	},
+	[ICE_RX_NEON_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec,
+		.info = "Vector Neon Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.scattered = true,
+			.bulk_alloc = true
+		}
+	},
 #endif
 };
 
@@ -3384,6 +3406,15 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 			if (ice_rx_vec_dev_check(dev) == -1)
 				rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	}
+#elif defined(RTE_ARCH_ARM64)
+	if (ad->ptp_ena || !ad->rx_bulk_alloc_allowed) {
+		rx_simd_width = RTE_VECT_SIMD_DISABLED;
+	} else {
+		rx_simd_width = ice_get_max_simd_bitwidth();
+		if (rx_simd_width >= RTE_VECT_SIMD_128)
+			if (ice_rx_vec_dev_check(dev) == -1)
+				rx_simd_width = RTE_VECT_SIMD_DISABLED;
+	}
 #endif
 
 	req_features.simd_width = rx_simd_width;
@@ -3404,6 +3435,14 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 		for (i = 0; i < dev->data->nb_rx_queues; i++)
 			if (dev->data->rx_queues[i])
 				ice_rxq_vec_setup(dev->data->rx_queues[i]);
+#elif defined(RTE_ARCH_ARM64)
+	int i;
+
+	if (ice_rx_path_infos[ad->rx_func_type].features.simd_width >= RTE_VECT_SIMD_128)
+		/* Vector function selected. Prepare the rxq accordingly. */
+		for (i = 0; i < dev->data->nb_rx_queues; i++)
+			if (dev->data->rx_queues[i])
+				ice_rxq_vec_setup(dev->data->rx_queues[i]);
 #endif
 
 out:
@@ -3535,6 +3574,16 @@ static const struct ci_tx_path_info ice_tx_path_infos[] = {
 		.pkt_prep = ice_prep_pkts
 	},
 #endif
+#elif defined(RTE_ARCH_ARM64)
+	[ICE_TX_NEON] = {
+		.pkt_burst = ice_xmit_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.tx_offloads = ICE_TX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128
+		},
+		.pkt_prep = rte_eth_tx_pkt_prepare_dummy
+	},
 #endif
 };
 
@@ -3718,7 +3767,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 
 	req_features.simple_tx = ad->tx_simple_allowed;
 
-#ifdef RTE_ARCH_X86
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 	if (ice_tx_vec_dev_check(dev) != -1)
 		req_features.simd_width = ice_get_max_simd_bitwidth();
 #endif
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 77ed41f9fd..999b6b30d6 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -261,6 +261,12 @@ const uint32_t *ice_dev_supported_ptypes_get(struct rte_eth_dev *dev,
 void ice_select_rxd_to_pkt_fields_handler(struct ci_rx_queue *rxq,
 					  uint32_t rxdid);
 
+uint16_t ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+				uint16_t nb_pkts);
+uint16_t ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+				uint16_t nb_pkts);
+uint16_t ice_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+				uint16_t nb_pkts);
 int ice_rx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_tx_vec_dev_check(struct rte_eth_dev *dev);
 int ice_rxq_vec_setup(struct ci_rx_queue *rxq);
diff --git a/drivers/net/intel/ice/ice_rxtx_vec_neon.c b/drivers/net/intel/ice/ice_rxtx_vec_neon.c
new file mode 100644
index 0000000000..afd038efb5
--- /dev/null
+++ b/drivers/net/intel/ice/ice_rxtx_vec_neon.c
@@ -0,0 +1,747 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ * Copyright(c) 2026 Arm Limited
+ */
+
+#include "ice_rxtx_vec_common.h"
+
+#include "../common/rx_vec_arm.h"
+
+#include <rte_vect.h>
+
+#define ICE_UINT16_BIT	(CHAR_BIT * sizeof(uint16_t))
+
+static __rte_always_inline uint32x4_t
+ice_flex_rxd_to_fdir_flags_vec(const uint32x4_t fdir_id0_3)
+{
+#define FDID_MIS_MAGIC 0xFFFFFFFFu
+	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR != (1u << 2));
+	RTE_BUILD_BUG_ON(RTE_MBUF_F_RX_FDIR_ID != (1u << 13));
+
+	const uint32x4_t pkt_fdir_bit = vdupq_n_u32((uint32_t)(RTE_MBUF_F_RX_FDIR |
+		RTE_MBUF_F_RX_FDIR_ID));
+
+	const uint32x4_t fdir_mis_mask = vdupq_n_u32(FDID_MIS_MAGIC);
+
+	/* desc->flow_id field == 0xFFFFFFFF means fdir mismatch */
+	uint32x4_t fdir_mask = vceqq_u32(fdir_id0_3, fdir_mis_mask);
+
+	/* XOR with 0xFFFFFFFF bit-reverses the mask */
+	fdir_mask = veorq_u32(fdir_mask, fdir_mis_mask);
+	const uint32x4_t fdir_flags = vandq_u32(fdir_mask, pkt_fdir_bit);
+
+	return fdir_flags;
+}
+
+static __rte_always_inline void
+ice_rxq_rearm(struct ci_rx_queue *rxq)
+{
+	ci_rxq_rearm(rxq);
+}
+
+static __rte_always_inline void
+ice_flex_rxd_to_olflags_v(struct ci_rx_queue *rxq, uint64x2_t descs[4],
+	struct rte_mbuf **rx_pkts)
+{
+	const uint64x2_t mbuf_init = {rxq->mbuf_initializer, 0};
+	uint64x2_t rearm0, rearm1, rearm2, rearm3;
+
+	uint32x4_t tmp_desc, flags, rss_vlan;
+
+	/* mask everything except checksum, RSS and VLAN flags
+	 * bit fields defined in enum ice_rx_flex_desc_status_error_0_bits
+	 * bit7:4 for checksum.
+	 * bit12 for RSS indication.
+	 * bit13 for VLAN indication.
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
+		RTE_MBUF_F_RX_OUTER_L4_CKSUM_MASK | RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD
+	};
+
+	/* map the checksum, rss and vlan fields to the checksum, rss
+	 * and vlan flag.
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
+		0, 0, 0, 0
+	};
+
+	/* extract status_error0 field from 4 descriptors,
+	 * and mask out everything else not in desc_mask
+	 */
+	flags = vzip2q_u32(vreinterpretq_u32_u64(descs[0]),
+			vreinterpretq_u32_u64(descs[1]));
+	tmp_desc = vzip2q_u32(vreinterpretq_u32_u64(descs[2]),
+			vreinterpretq_u32_u64(descs[3]));
+	tmp_desc = vreinterpretq_u32_u64(vzip1q_u64(vreinterpretq_u64_u32(flags),
+			vreinterpretq_u64_u32(tmp_desc)));
+
+	tmp_desc = vandq_u32(tmp_desc, desc_mask);
+
+	/* shift each 32-bit lane right by 4 so that we can use
+	 * the checksum bit as an index into cksum_flags
+	 */
+	tmp_desc = vshrq_n_u32(tmp_desc, 4);
+	flags = vreinterpretq_u32_u8(vqtbl1q_u8(cksum_flags,
+			vreinterpretq_u8_u32(tmp_desc)));
+
+	/* shift left by 1 bit because we shift right by 1 bit
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
+	/* we need to mask out the redundant bits introduced by RSS or
+	 * VLAN fields.
+	 */
+	flags = vandq_u32(flags, cksum_mask);
+
+	/* map RSS, VLAN flags in HW desc to RTE_MBUF */
+	tmp_desc = vshrq_n_u32(tmp_desc, 8);
+	rss_vlan = vreinterpretq_u32_u8(vqtbl1q_u8(rss_vlan_flags,
+			vreinterpretq_u8_u32(tmp_desc)));
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
+				ice_flex_rxd_to_fdir_flags_vec(fdir_id0_3);
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
+	/**
+	 * At this point, we have the 4 sets of flags in the low 16-bits
+	 * of each 32-bit value in flags.
+	 * We want to extract these, and merge them with the mbuf init data
+	 * so we can do a single 16-byte write to the mbuf to set the flags
+	 * and all the other initialization fields. Extracting the
+	 * appropriate flags means that we have to do a shift and blend for
+	 * each mbuf before we do the write.
+	 */
+	rearm0 = vsetq_lane_u64(vgetq_lane_u32(flags, 0), mbuf_init, 1);
+	rearm1 = vsetq_lane_u64(vgetq_lane_u32(flags, 1), mbuf_init, 1);
+	rearm2 = vsetq_lane_u64(vgetq_lane_u32(flags, 2), mbuf_init, 1);
+	rearm3 = vsetq_lane_u64(vgetq_lane_u32(flags, 3), mbuf_init, 1);
+
+	/* compile time check */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, ol_flags) !=
+			offsetof(struct rte_mbuf, rearm_data) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, rearm_data) !=
+			RTE_ALIGN(offsetof(struct rte_mbuf, rearm_data), 16));
+
+	/* write the rearm data and the olflags in one write */
+	vst1q_u64((uint64_t *)&rx_pkts[0]->rearm_data, rearm0);
+	vst1q_u64((uint64_t *)&rx_pkts[1]->rearm_data, rearm1);
+	vst1q_u64((uint64_t *)&rx_pkts[2]->rearm_data, rearm2);
+	vst1q_u64((uint64_t *)&rx_pkts[3]->rearm_data, rearm3);
+}
+
+static __rte_always_inline void
+ice_flex_rxd_to_ptype_v(uint64x2_t descs[4], struct rte_mbuf **rx_pkts,
+	uint32_t *ptype_tbl)
+{
+	const uint16x8_t ptype_mask = {
+		0, ICE_RX_FLEX_DESC_PTYPE_M,
+		0, ICE_RX_FLEX_DESC_PTYPE_M,
+		0, ICE_RX_FLEX_DESC_PTYPE_M,
+		0, ICE_RX_FLEX_DESC_PTYPE_M
+	};
+
+	uint32x4_t ptype_01 = vzip1q_u32(vreinterpretq_u32_u64(descs[0]),
+			vreinterpretq_u32_u64(descs[1]));
+	uint32x4_t ptype_23 = vzip1q_u32(vreinterpretq_u32_u64(descs[2]),
+			vreinterpretq_u32_u64(descs[3]));
+	uint32x4_t ptype_all_u32 =
+			vreinterpretq_u32_u64(vzip1q_u64(vreinterpretq_u64_u32(ptype_01),
+				vreinterpretq_u64_u32(ptype_23)));
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
+ * vPMD raw receive routine, only accept(nb_pkts >= ICE_VPMD_DESCS_PER_LOOP)
+ *
+ * Notice:
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - floor align nb_pkts to a ICE_VPMD_DESCS_PER_LOOP power-of-two
+ */
+static __rte_always_inline uint16_t
+_ice_recv_raw_pkts_vec(struct ci_rx_queue *rxq, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts, uint8_t *split_packet)
+{
+	volatile union ci_rx_flex_desc *rxdp;
+	struct ci_rx_entry *sw_ring;
+	uint16_t nb_pkts_recd;
+	int pos;
+	uint32_t *ptype_tbl = rxq->ice_vsi->adapter->ptype_tbl;
+
+	uint16x8_t crc_adjust = {
+		0, 0,	/* ignore pkt_type field */
+		rxq->crc_len,	/* sub crc on pkt_len */
+		0,	/* ignore high-16bits of pkt_len */
+		rxq->crc_len,	/* sub crc on data_len */
+		0, 0, 0	/* ignore non-length fields */
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
+	const uint8x16_t eop_shuf_mask = {
+		0x06, 0x02, 0x04, 0x00,
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF,
+		0xFF, 0xFF, 0xFF, 0xFF
+	};
+
+	/* compile-time check the above crc_adjust layout is correct */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
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
+	/* nb_pkts has to be floor-aligned to ICE_VPMD_DESCS_PER_LOOP */
+	nb_pkts = RTE_ALIGN_FLOOR(nb_pkts, ICE_VPMD_DESCS_PER_LOOP);
+
+	rxdp = rxq->rx_flex_ring + rxq->rx_tail;
+	rte_prefetch0(rxdp);
+
+	/* see if we need to rearm the Rx queue */
+	if (rxq->rxrearm_nb > ICE_VPMD_RXQ_REARM_THRESH)
+		ice_rxq_rearm(rxq);
+
+	/* check to see if there is actually a packet available */
+	if (!(rxdp->wb.status_error0 &
+	      rte_cpu_to_le_32(1 << ICE_RX_FLEX_DESC_STATUS0_DD_S)))
+		return 0;
+
+	/* compile-time verification of the shuffle mask again */
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, pkt_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 4);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, data_len) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 8);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, vlan_tci) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 10);
+	RTE_BUILD_BUG_ON(offsetof(struct rte_mbuf, hash) !=
+			offsetof(struct rte_mbuf, rx_descriptor_fields1) + 12);
+
+	/* move the next 'n' mbufs into the cache */
+	sw_ring = &rxq->sw_ring[rxq->rx_tail];
+
+	/* A. load 4 packets in one loop
+	 * [A*. mask out 4 unused dirty fields in desc]
+	 * B. copy 4 mbuf pointers from sw_ring to rx_pkts
+	 * C. count the number of DD bits among the 4 packets
+	 * [C*. extract the end-of-packet bit, if requested]
+	 * D. fill info. from desc to mbuf
+	 */
+	for (pos = 0, nb_pkts_recd = 0; pos < nb_pkts;
+		 pos += ICE_VPMD_DESCS_PER_LOOP,
+		 rxdp += ICE_VPMD_DESCS_PER_LOOP) {
+		uint64x2_t descs[ICE_VPMD_DESCS_PER_LOOP];
+		uint8x16_t pkt_mb0, pkt_mb1, pkt_mb2, pkt_mb3;
+		uint16x8_t sterr_tmp1, sterr_tmp2;
+		uint64x2_t mbp1, mbp2;
+		uint16x8_t staterr;
+		uint16x8_t tmp;
+		uint64_t stat;
+
+		/* A.1 load descs[3-0] */
+		descs[3] =  vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 3));
+		descs[2] =  vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 2));
+		descs[1] =  vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 1));
+		descs[0] =  vld1q_u64(RTE_CAST_PTR(uint64_t *, rxdp + 0));
+
+		/* use acquire fence to order loads of descriptor qwords */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		/* A.2 reload qword0 to make it ordered after qword1 load */
+		descs[3] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 3),
+				descs[3], 0);
+		descs[2] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 2),
+				descs[2], 0);
+		descs[1] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp + 1),
+				descs[1], 0);
+		descs[0] = vld1q_lane_u64(RTE_CAST_PTR(uint64_t *, rxdp),
+				descs[0], 0);
+
+		/* B.1 load 4 mbuf pointers */
+		mbp1 = vld1q_u64((uint64_t *)&sw_ring[pos]);
+		mbp2 = vld1q_u64((uint64_t *)&sw_ring[pos + 2]);
+
+		/* B.2 copy 4 mbuf pointers into rx_pkts  */
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
+		ice_flex_rxd_to_olflags_v(rxq, descs, &rx_pkts[pos]);
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
+#ifndef	RTE_NET_INTEL_USE_16BYTE_DESC
+
+		/**
+		 * needs to load 2nd 16B of each desc for RSS hash parsing,
+		 * will cause performance drop to get into this context.
+		 */
+		if (rxq->ice_vsi->adapter->pf.dev_data->dev_conf.rxmode.offloads &
+				RTE_ETH_RX_OFFLOAD_RSS_HASH) {
+			/* load bottom half of every 32B desc */
+			const uint64x2_t raw_desc_bh3 =
+					vld1q_u64(RTE_CAST_PTR(const uint64_t *,
+						&rxdp[3].wb.status_error1));
+			const uint64x2_t raw_desc_bh2 =
+					vld1q_u64(RTE_CAST_PTR(const uint64_t *,
+						&rxdp[2].wb.status_error1));
+			const uint64x2_t raw_desc_bh1 =
+					vld1q_u64(RTE_CAST_PTR(const uint64_t *,
+						&rxdp[1].wb.status_error1));
+			const uint64x2_t raw_desc_bh0 =
+					vld1q_u64(RTE_CAST_PTR(const uint64_t *,
+						&rxdp[0].wb.status_error1));
+
+			/**
+			 * to shift the 32b RSS hash value to the
+			 * highest 32b of each 128b before mask
+			 */
+			uint64x2_t rss_hash3 = vshlq_n_u64(raw_desc_bh3, 32);
+			uint64x2_t rss_hash2 = vshlq_n_u64(raw_desc_bh2, 32);
+			uint64x2_t rss_hash1 = vshlq_n_u64(raw_desc_bh1, 32);
+			uint64x2_t rss_hash0 = vshlq_n_u64(raw_desc_bh0, 32);
+
+			const uint32x4_t rss_hash_msk = {0, 0, 0, 0xFFFFFFFFu};
+
+			rss_hash3 =
+				vreinterpretq_u64_u32(vandq_u32(vreinterpretq_u32_u64(rss_hash3),
+					rss_hash_msk));
+			rss_hash2 =
+				vreinterpretq_u64_u32(vandq_u32(vreinterpretq_u32_u64(rss_hash2),
+					rss_hash_msk));
+			rss_hash1 =
+				vreinterpretq_u64_u32(vandq_u32(vreinterpretq_u32_u64(rss_hash1),
+					rss_hash_msk));
+			rss_hash0 =
+				vreinterpretq_u64_u32(vandq_u32(vreinterpretq_u32_u64(rss_hash0),
+					rss_hash_msk));
+
+			pkt_mb3 = vorrq_u8(pkt_mb3, vreinterpretq_u8_u64(rss_hash3));
+			pkt_mb2 = vorrq_u8(pkt_mb2, vreinterpretq_u8_u64(rss_hash2));
+			pkt_mb1 = vorrq_u8(pkt_mb1, vreinterpretq_u8_u64(rss_hash1));
+			pkt_mb0 = vorrq_u8(pkt_mb0, vreinterpretq_u8_u64(rss_hash0));
+		}
+#endif
+
+		/* D.3 copy final data to rx_pkts */
+		vst1q_u8((void *)&rx_pkts[pos + 3]->rx_descriptor_fields1, pkt_mb3);
+		vst1q_u8((void *)&rx_pkts[pos + 2]->rx_descriptor_fields1, pkt_mb2);
+		vst1q_u8((void *)&rx_pkts[pos + 1]->rx_descriptor_fields1, pkt_mb1);
+		vst1q_u8((void *)&rx_pkts[pos + 0]->rx_descriptor_fields1, pkt_mb0);
+
+		ice_flex_rxd_to_ptype_v(descs, &rx_pkts[pos], ptype_tbl);
+
+		/* C.1 filter staterr info only */
+		sterr_tmp2 = vzip2q_u16(vreinterpretq_u16_u64(descs[3]),
+				vreinterpretq_u16_u64(descs[2]));
+		sterr_tmp1 = vzip2q_u16(vreinterpretq_u16_u64(descs[1]),
+				vreinterpretq_u16_u64(descs[0]));
+
+		/* C.2 get 4 pkts status_error0 value */
+		staterr = vzip1q_u16(sterr_tmp2, sterr_tmp1);
+
+		/* C* extract and record EOP bits */
+		if (split_packet) {
+			uint8x16_t eop_bits;
+			/* and with mask to extract bits, flipping 1-0 */
+			eop_bits = vmvnq_u8(vreinterpretq_u8_u16(staterr));
+			eop_bits = vandq_u8(eop_bits, eop_check);
+			/* the staterr values are not in order, even though
+			 * the count of DD bits doesn't care. However, for
+			 * end of packet tracking, we do care, so shuffle.
+			 * Previously: descs[3] descs[1] descs[2] descs[0]
+			 * Shuffled: descs[0] descs[1] descs[2] descs[3]
+			 */
+			eop_bits = vqtbl1q_u8(eop_bits, eop_shuf_mask);
+
+			/* store the resulting 32-bit value */
+			vst1q_lane_u32((uint32_t *)split_packet,
+					vreinterpretq_u32_u8(eop_bits), 0);
+			split_packet += ICE_VPMD_DESCS_PER_LOOP;
+		}
+
+		/* C.3 count available number of descriptors */
+		/* mask everything except DD bit */
+		staterr = vandq_u16(staterr, dd_check);
+		/* move the statue bit (bit0) into the sign bit (bit15)
+		 * of each 16-bit lane
+		 */
+		staterr = vshlq_n_u16(staterr, ICE_UINT16_BIT - 1);
+		/* reinterpret staterr as a signed 16-bit and
+		 * arithmetic-shift-right by 15
+		 * each lane becomes 0xFFFF if original DD bit was 1, otherwise 0.
+		 * then interpret back to unsigned u16 vector
+		 */
+		staterr = vreinterpretq_u16_s16(vshrq_n_s16(vreinterpretq_s16_u16(staterr),
+				ICE_UINT16_BIT - 1));
+
+		/* reinterpret u16x8 vector as u64x2, and fetch the low u64
+		 * which contains the first four 16-bit lanes, and invert
+		 * all bits.
+		 */
+		stat = ~vgetq_lane_u64(vreinterpretq_u64_u16(staterr), 0);
+
+		if (unlikely(stat == 0)) {
+			nb_pkts_recd += ICE_VPMD_DESCS_PER_LOOP;
+		} else {
+			nb_pkts_recd += rte_ctz64(stat) / ICE_UINT16_BIT;
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
+/**
+ * Notice:
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
+ * - nb_pkts > ICE_VPMD_RX_BURST, only scan ICE_VPMD_RX_BURST
+ *   numbers of DD bits
+ */
+uint16_t
+ice_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts)
+{
+	return _ice_recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
+}
+
+/**
+ * vPMD receive routine that reassembles single burst of 32 scattered packets
+ *
+ * Notice:
+ * - nb_pkts < ICE_VPMD_DESCS_PER_LOOP, just return no packet
+ */
+static uint16_t
+ice_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts)
+{
+	struct ci_rx_queue *rxq = rx_queue;
+	uint8_t split_flags[ICE_VPMD_RX_BURST] = {0};
+
+	/* get some new buffers */
+	uint16_t nb_bufs = _ice_recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
+						split_flags);
+	if (nb_bufs == 0)
+		return 0;
+
+	/* happy day case, full burst + no packets to be joined */
+	const uint64_t *split_fl64 = (uint64_t *)split_flags;
+
+	/* check no split flags in both previous and current bursts */
+	if (!rxq->pkt_first_seg &&
+		split_fl64[0] == 0 && split_fl64[1] == 0 &&
+		split_fl64[2] == 0 && split_fl64[3] == 0)
+		return nb_bufs;
+
+	/* reassemble any packets that need reassembly */
+	unsigned int i = 0;
+
+	if (!rxq->pkt_first_seg) {
+		/* find the first split flag, and only reassemble then */
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
+ * vPMD receive routine that reassembles scattered packets.
+ */
+uint16_t
+ice_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+	uint16_t nb_pkts)
+{
+	uint16_t retval = 0;
+
+	while (nb_pkts > ICE_VPMD_RX_BURST) {
+		uint16_t burst;
+
+		burst = ice_recv_scattered_burst_vec(rx_queue,
+				rx_pkts + retval,
+				ICE_VPMD_RX_BURST);
+		retval += burst;
+		nb_pkts -= burst;
+		if (burst < ICE_VPMD_RX_BURST)
+			return retval;
+	}
+
+	return retval + ice_recv_scattered_burst_vec(rx_queue,
+			rx_pkts + retval,
+			nb_pkts);
+}
+
+static __rte_always_inline void
+ice_vtx1(volatile struct ci_tx_desc *txdp, struct rte_mbuf *pkt,
+	 uint64_t flags)
+{
+	uint64_t high_qw = (CI_TX_DESC_DTYPE_DATA |
+		((uint64_t)flags << CI_TXD_QW1_CMD_S) |
+		((uint64_t)pkt->data_len << CI_TXD_QW1_TX_BUF_SZ_S));
+
+	uint64x2_t descriptor = {rte_pktmbuf_iova(pkt), high_qw};
+	vst1q_u64(RTE_CAST_PTR(uint64_t *, txdp), descriptor);
+}
+
+static __rte_always_inline void
+ice_vtx(volatile struct ci_tx_desc *txdp, struct rte_mbuf **pkt,
+	uint16_t nb_pkts, uint64_t flags)
+{
+	int i;
+
+	for (i = 0; i < nb_pkts; ++i, ++txdp, ++pkt)
+		ice_vtx1(txdp, *pkt, flags);
+}
+
+static __rte_always_inline uint16_t
+ice_xmit_fixed_burst_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+	uint16_t nb_pkts)
+{
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+	volatile struct ci_tx_desc *txdp;
+	struct ci_tx_entry_vec *txep;
+	uint16_t n, nb_commit, tx_id;
+	uint64_t flags = CI_TX_DESC_CMD_DEFAULT;
+	uint64_t rs = CI_TX_DESC_CMD_RS | CI_TX_DESC_CMD_DEFAULT;
+	int i;
+
+	/* cross rx_thresh boundary is not allowed */
+	nb_pkts = RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+
+	if (txq->nb_tx_free < txq->tx_free_thresh)
+		ci_tx_free_bufs_vec(txq, ice_tx_desc_done, false);
+
+	nb_pkts = (uint16_t)RTE_MIN(txq->nb_tx_free, nb_pkts);
+	nb_commit = nb_pkts;
+	if (unlikely(nb_pkts == 0))
+		return 0;
+
+	tx_id = txq->tx_tail;
+	txdp = &txq->ci_tx_ring[tx_id];
+	txep = &txq->sw_ring_vec[tx_id];
+
+	txq->nb_tx_free = (uint16_t)(txq->nb_tx_free - nb_pkts);
+
+	n = (uint16_t)(txq->nb_tx_desc - tx_id);
+	if (nb_commit >= n) {
+		ci_tx_backlog_entry_vec(txep, tx_pkts, n);
+
+		for (i = 0; i < n - 1; ++i, ++tx_pkts, ++txdp)
+			ice_vtx1(txdp, *tx_pkts, flags);
+
+		/* write with RS for the last descriptor in the segment */
+		ice_vtx1(txdp, *tx_pkts++, rs);
+
+		nb_commit = (uint16_t)(nb_commit - n);
+
+		tx_id = 0;
+		txq->tx_next_rs = (uint16_t)(txq->tx_rs_thresh - 1);
+
+		/* avoid reach the end of ring */
+		txdp = &txq->ci_tx_ring[tx_id];
+		txep = &txq->sw_ring_vec[tx_id];
+	}
+
+	ci_tx_backlog_entry_vec(txep, tx_pkts, nb_commit);
+
+	ice_vtx(txdp, tx_pkts, nb_commit, flags);
+
+	tx_id = (uint16_t)(tx_id + nb_commit);
+	if (tx_id > txq->tx_next_rs) {
+		txq->ci_tx_ring[txq->tx_next_rs].cmd_type_offset_bsz |=
+			rte_cpu_to_le_64(((uint64_t)CI_TX_DESC_CMD_RS) <<
+					 CI_TXD_QW1_CMD_S);
+		txq->tx_next_rs =
+			(uint16_t)(txq->tx_next_rs + txq->tx_rs_thresh);
+	}
+
+	txq->tx_tail = tx_id;
+
+	ICE_PCI_REG_WC_WRITE(txq->qtx_tail, txq->tx_tail);
+
+	return nb_pkts;
+}
+
+uint16_t
+ice_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
+	uint16_t nb_pkts)
+{
+	uint16_t nb_tx = 0;
+	struct ci_tx_queue *txq = (struct ci_tx_queue *)tx_queue;
+
+	while (nb_pkts) {
+		uint16_t ret, num;
+
+		num = (uint16_t)RTE_MIN(nb_pkts, txq->tx_rs_thresh);
+		ret = ice_xmit_fixed_burst_vec(tx_queue, &tx_pkts[nb_tx], num);
+		nb_tx += ret;
+		nb_pkts -= ret;
+		if (ret < num)
+			break;
+	}
+
+	return nb_tx;
+}
+
+
+int __rte_cold
+ice_rxq_vec_setup(struct ci_rx_queue *rxq)
+{
+	rxq->vector_rx = 1;
+	rxq->mbuf_initializer = ci_rxq_mbuf_initializer(rxq->port_id);
+	return 0;
+}
+
+int __rte_cold
+ice_rx_vec_dev_check(struct rte_eth_dev *dev)
+{
+	return ice_rx_vec_dev_check_default(dev);
+}
+
+int __rte_cold
+ice_tx_vec_dev_check(struct rte_eth_dev *dev)
+{
+	return ice_tx_vec_dev_check_default(dev);
+}
+
+enum rte_vect_max_simd
+ice_get_max_simd_bitwidth(void)
+{
+	return RTE_MIN(128, rte_vect_get_max_simd_bitwidth());
+}
diff --git a/drivers/net/intel/ice/meson.build b/drivers/net/intel/ice/meson.build
index 293577676f..1dc7c0109a 100644
--- a/drivers/net/intel/ice/meson.build
+++ b/drivers/net/intel/ice/meson.build
@@ -33,6 +33,8 @@ endif
 if arch_subdir == 'x86'
     sources_avx2 += files('ice_rxtx_vec_avx2.c')
     sources_avx512 += files('ice_rxtx_vec_avx512.c')
+elif arch_subdir == 'arm'
+    sources += files('ice_rxtx_vec_neon.c')
 endif
 
 sources += files(
-- 
2.43.0

