Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B454EF55809
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Apr 2026 10:31:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99F7D402DF;
	Mon, 20 Apr 2026 12:30:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id D1DE7402E4
 for <dev@dpdk.org>; Mon, 20 Apr 2026 12:30:57 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784E91516;
 Mon, 20 Apr 2026 03:30:51 -0700 (PDT)
Received: from cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com
 (cesw-grace-nv-1s-n2-01.lab.cambridge.arm.com [10.7.10.64])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72EDB3F915;
 Mon, 20 Apr 2026 03:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776681057; bh=LHFEkeq/8c8iysjC5rLdoOprNhV7n96+B1VszjtvDnM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vXbfv/BXLbqhhJ+Cy79KtLCzOy0Dp8j+hLbwFyZDFEfcrbAuUZkWAt6dbxwcjapqP
 OWCDF24tiDvbhhwnkSFceVPsCY/9HYXrTtRpaVSnJKLgv0PfcHf4EMQiyuGLP+nQeW
 Nbmii/WfJNA0g7PwJ7KX5KXKsnRrLpivyXYnWp7A=
From: Jay Wang <jay.wang2@arm.com>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	nd@arm.com,
	Jay Wang <jay.wang2@arm.com>
Subject: [PATCH v2 1/3] net/iavf: add Rx scattered function for 32B desc
Date: Mon, 20 Apr 2026 10:30:36 +0000
Message-ID: <20260420103042.2836732-2-jay.wang2@arm.com>
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

Added the scattered burst function on AArch64 so that we can leverage
the NEON-optimised Rx raw burst function to handle scattered packets for
the legacy 32B descriptor.

Signed-off-by: Jay Wang <jay.wang2@arm.com>
---
 drivers/net/intel/iavf/iavf.h               |   1 +
 drivers/net/intel/iavf/iavf_rxtx.c          |  16 ++-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c | 110 +++++++++++++++++++-
 drivers/net/intel/iavf/meson.build          |   2 +-
 4 files changed, 122 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 403c61e2e8..e4936f3566 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -334,6 +334,7 @@ enum iavf_rx_func_type {
 	IAVF_RX_BULK_ALLOC,
 	IAVF_RX_BULK_ALLOC_FLEX_RXD,
 	IAVF_RX_NEON,
+	IAVF_RX_NEON_SCATTERED,
 	IAVF_RX_AVX2,
 	IAVF_RX_AVX2_SCATTERED,
 	IAVF_RX_AVX2_OFFLOAD,
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 4ff6c18dc4..15566a0e18 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3551,16 +3551,26 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 		}
 	},
 #endif
-#elif defined RTE_ARCH_ARM
+#elif defined(RTE_ARCH_ARM64)
 	[IAVF_RX_NEON] = {
 		.pkt_burst = iavf_recv_pkts_vec,
 		.info = "Vector Neon",
 		.features = {
-			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS,
 			.simd_width = RTE_VECT_SIMD_128,
 			.bulk_alloc = true
 		}
 	},
+	[IAVF_RX_NEON_SCATTERED] = {
+		.pkt_burst = iavf_recv_scattered_pkts_vec,
+		.info = "Vector Scattered Neon",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_128,
+			.scattered = true,
+			.bulk_alloc = true
+		}
+	},
 #endif
 };
 
@@ -3839,7 +3849,7 @@ iavf_set_rx_function(struct rte_eth_dev *dev)
 	if (adapter->rx_bulk_alloc_allowed) {
 		req_features.bulk_alloc = true;
 		default_path = IAVF_RX_BULK_ALLOC;
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
 		if (iavf_rx_vec_dev_check(dev) != -1)
 			req_features.simd_width = iavf_get_max_simd_bitwidth();
 #endif
diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
index 28c90b2a72..45e377d728 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_neon.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2022 Intel Corporation
- * Copyright(c) 2022 Arm Limited
+ * Copyright(c) 2022-2026 Arm Limited
  */
 
 #include <stdint.h>
@@ -145,8 +145,6 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		   struct rte_mbuf **__rte_restrict rx_pkts,
 		   uint16_t nb_pkts, uint8_t *split_packet)
 {
-	RTE_SET_USED(split_packet);
-
 	volatile union ci_rx_desc *rxdp;
 	struct ci_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
@@ -164,6 +162,13 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		4, 5, 6, 7    /* octet 4~7, 32bits rss */
 		};
 
+	uint8x16_t eop_check = {
+		0x02, 0x00, 0x02, 0x00,
+		0x02, 0x00, 0x02, 0x00,
+		0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00
+	};
+
 	uint16x8_t crc_adjust = {
 		0, 0,         /* ignore pkt_type field */
 		rxq->crc_len, /* sub crc on pkt_len */
@@ -238,6 +243,13 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		vst1q_u64((uint64_t *)&rx_pkts[pos], mbp1);
 		vst1q_u64((uint64_t *)&rx_pkts[pos + 2], mbp2);
 
+		if (split_packet) {
+			rte_mbuf_prefetch_part2(rx_pkts[pos]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 1]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 2]);
+			rte_mbuf_prefetch_part2(rx_pkts[pos + 3]);
+		}
+
 		/* pkts shift the pktlen field to be 16-bit aligned*/
 		uint32x4_t len3 = vshlq_u32(vreinterpretq_u32_u64(descs[3]),
 					    len_shl);
@@ -306,6 +318,32 @@ _recv_raw_pkts_vec(struct ci_rx_queue *__rte_restrict rxq,
 		staterr = vzipq_u16(sterr_tmp1.val[1],
 				    sterr_tmp2.val[1]).val[0];
 
+		/* C* extract and record EOP bit */
+		if (split_packet) {
+			uint8x16_t eop_shuf_mask = {
+				0x00, 0x02, 0x04, 0x06,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF,
+				0xFF, 0xFF, 0xFF, 0xFF
+			};
+			uint8x16_t eop_bits;
+
+			/* and with mask to extract bits, flipping 1-0 */
+			eop_bits = vmvnq_u8(vreinterpretq_u8_u16(staterr));
+			eop_bits = vandq_u8(eop_bits, eop_check);
+			/* the staterr values are not in order, as the count
+			 * of dd bits doesn't care. However, for end of
+			 * packet tracking, we do care, so shuffle. This also
+			 * compresses the 32-bit values to 8-bit
+			 */
+			eop_bits = vqtbl1q_u8(eop_bits, eop_shuf_mask);
+
+			/* store the resulting 32-bit value */
+			vst1q_lane_u32((uint32_t *)split_packet,
+				vreinterpretq_u32_u8(eop_bits), 0);
+			split_packet += IAVF_VPMD_DESCS_PER_LOOP;
+		}
+
 		staterr = vshlq_n_u16(staterr, IAVF_UINT16_BIT - 1);
 		staterr = vreinterpretq_u16_s16(
 				vshrq_n_s16(vreinterpretq_s16_u16(staterr),
@@ -341,6 +379,72 @@ iavf_recv_pkts_vec(void *__rte_restrict rx_queue,
 	return _recv_raw_pkts_vec(rx_queue, rx_pkts, nb_pkts, NULL);
 }
 
+/*
+ * vPMD receive routine that reassembles single burst of 32 scattered
+ * packets.
+ *
+ * Notice:
+ * - nb_pkts < IAVF_VPMD_DESCS_PER_LOOP, just return no packet
+ */
+static __rte_always_inline uint16_t
+iavf_recv_scattered_burst_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts)
+{
+	struct ci_rx_queue *rxq = rx_queue;
+	uint8_t split_flags[IAVF_VPMD_RX_BURST] = {0};
+
+	/* get some new buffers */
+	uint16_t nb_bufs = _recv_raw_pkts_vec(rxq, rx_pkts, nb_pkts,
+						split_flags);
+
+	if (nb_bufs == 0)
+		return 0;
+
+	/* happy day case, full burst + no packets to be assembled */
+	const uint64_t *split_fl64 = (uint64_t *)split_flags;
+	if (!rxq->pkt_first_seg &&
+			split_fl64[0] == 0 && split_fl64[1] == 0 &&
+			split_fl64[2] == 0 && split_fl64[3] == 0)
+		return nb_bufs;
+
+	/* reassmble any packets that need reassembly */
+	unsigned int i = 0;
+	if (!rxq->pkt_first_seg) {
+		/* find the first split flag, and only reassmeble then */
+		while (i < nb_bufs && !split_flags[i])
+			i++;
+		if (i == nb_bufs)
+			return nb_bufs;
+		rxq->pkt_first_seg = rx_pkts[i];
+	}
+	return i + ci_rx_reassemble_packets(&rx_pkts[i], nb_bufs - i,
+			&split_flags[i], &rxq->pkt_first_seg, &rxq->pkt_last_seg,
+			rxq->crc_len);
+}
+
+/*
+ * vPMD receive routine that reassembles scattered packets.
+ */
+uint16_t
+iavf_recv_scattered_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
+		uint16_t nb_pkts)
+{
+	uint16_t retval = 0;
+
+	while (nb_pkts > IAVF_VPMD_RX_BURST) {
+		uint16_t burst;
+		burst = iavf_recv_scattered_burst_vec(rx_queue,
+				rx_pkts + retval, IAVF_VPMD_RX_BURST);
+		retval += burst;
+		nb_pkts -= burst;
+		if (burst < IAVF_VPMD_RX_BURST)
+			return retval;
+	}
+	/* The last one burst or nb_pkts <= IAVF_VPMD_RX_BURST */
+	return retval + iavf_recv_scattered_burst_vec(rx_queue,
+			rx_pkts + retval, nb_pkts);
+}
+
 void __rte_cold
 iavf_rx_queue_release_mbufs_neon(struct ci_rx_queue *rxq)
 {
diff --git a/drivers/net/intel/iavf/meson.build b/drivers/net/intel/iavf/meson.build
index f9576586f6..50630a88c8 100644
--- a/drivers/net/intel/iavf/meson.build
+++ b/drivers/net/intel/iavf/meson.build
@@ -29,7 +29,7 @@ sources = files(
 if arch_subdir == 'x86'
     sources_avx2 += files('iavf_rxtx_vec_avx2.c')
     sources_avx512 += files('iavf_rxtx_vec_avx512.c')
-elif arch_subdir == 'arm'
+elif arch_subdir == 'arm' and dpdk_conf.get('RTE_ARCH_64')
     sources += files('iavf_rxtx_vec_neon.c')
 endif
 
-- 
2.43.0

