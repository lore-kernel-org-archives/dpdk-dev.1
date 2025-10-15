Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92BBCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:08:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29FCA410E3;
	Wed, 15 Oct 2025 12:07:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A2C3440E25
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522857; x=1792058857;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2MXOv/W1X+OVovDM0f6y5uQveu141XRG3c2IgcLOdHo=;
 b=gXUPr+6pWCSIJnSwvv7S/G1cj3ktcUG/BUORR9FVpKLGPUH5A7km8E2C
 sNjU2dv3yktUS2gmRKeZMUa5lbHFvB/sZGA7vohqKSSztmAvjK/k/J80/
 c02VZItIhyReFr72UhWCOp2Uo/cDGwmnYj+p/tSSporSZry5rg4pnxK3j
 SSwIXh6lYaQUkjonQrlBkXTTekZbuodz6sUlQIa4c1hs0xZb49hNXx1Sv
 Zm4TMM/H7wJ0MZI/EaokSlZwhMvwhO1FZ85ukRJAja76um36zd3DrlLpD
 fI1kSRaGBettOOuwZ24YxT85Fsyp50h0CnCyRLvazrR130xb2gyteeNJc A==;
X-CSE-ConnectionGUID: /xHMktucROG4f+t2GVB1dg==
X-CSE-MsgGUID: AxEphtMGRMeRGw5wk19v9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371825"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371825"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:37 -0700
X-CSE-ConnectionGUID: 6EnMCCjAS0CERrd6TGH7XA==
X-CSE-MsgGUID: 0VQcs6tLTcu0yMnKbigvzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262643"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 7/7] net/ice: reformat the Rx path infos array
Date: Wed, 15 Oct 2025 10:07:23 +0000
Message-Id: <20251015100723.1603296-8-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
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

In order to improve readability, reformat the rx path infos array.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Newline for closing braces.
* Removed assignment of RTE_VECT_SIMD_DISABLED to simd_width, the
selection logic can work when this is set to zero for the scalar path.
* Removed unused define ICE_RX_NO_OFFLOADS
---
 drivers/net/intel/ice/ice_rxtx.c | 147 ++++++++++++++++++++++++-------
 drivers/net/intel/ice/ice_rxtx.h |   1 -
 2 files changed, 116 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 411b353417..2c87e56da4 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3667,41 +3667,126 @@ ice_xmit_pkts_simple(void *tx_queue,
 }
 
 static const struct ci_rx_path_info ice_rx_path_infos[] = {
-	[ICE_RX_DEFAULT] = {ice_recv_pkts, "Scalar",
-		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED}},
-	[ICE_RX_SCATTERED] = {ice_recv_scattered_pkts, "Scalar Scattered",
-		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.scattered = true}}},
-	[ICE_RX_BULK_ALLOC] = {ice_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
-		{ICE_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
+	[ICE_RX_DEFAULT] = {
+		.pkt_burst = ice_recv_pkts,
+		.info = "Scalar",
+		.features = {
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS
+		}
+	},
+	[ICE_RX_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts,
+		.info = "Scalar Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
+			.extra.scattered = true
+		}
+	},
+	[ICE_RX_BULK_ALLOC] = {
+		.pkt_burst = ice_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc",
+		.features = {
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
+			.extra.bulk_alloc = true
+		}
+	},
 #ifdef RTE_ARCH_X86
-	[ICE_RX_SSE] = {ice_recv_pkts_vec, "Vector SSE",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[ICE_RX_SSE_SCATTERED] = {ice_recv_scattered_pkts_vec, "Vector SSE Scattered",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
-	[ICE_RX_AVX2] = {ice_recv_pkts_vec_avx2, "Vector AVX2",
-		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
-	[ICE_RX_AVX2_SCATTERED] = {ice_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
-		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
-			{.scattered = true, .bulk_alloc = true}}},
-	[ICE_RX_AVX2_OFFLOAD] = {ice_recv_pkts_vec_avx2_offload, "Offload Vector AVX2",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
+	[ICE_RX_SSE] = {
+		.pkt_burst = ice_recv_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_SSE_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec,
+		.info = "Vector SSE Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_AVX2] = {
+		.pkt_burst = ice_recv_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_AVX2_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx2,
+		.info = "Vector AVX2 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_AVX2_OFFLOAD] = {
+		.pkt_burst = ice_recv_pkts_vec_avx2_offload,
+		.info = "Offload Vector AVX2",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true
+		}
+	},
 	[ICE_RX_AVX2_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx2_offload, "Offload Vector AVX2 Scattered",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256,
-			{.scattered = true, .bulk_alloc = true}}},
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx2_offload,
+		.info = "Offload Vector AVX2 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #ifdef CC_AVX512_SUPPORT
-	[ICE_RX_AVX512] = {ice_recv_pkts_vec_avx512, "Vector AVX512",
-		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
-	[ICE_RX_AVX512_SCATTERED] = {ice_recv_scattered_pkts_vec_avx512, "Vector AVX512 Scattered",
-		{ICE_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
-			{.scattered = true, .bulk_alloc = true}}},
-	[ICE_RX_AVX512_OFFLOAD] = {ice_recv_pkts_vec_avx512_offload, "Offload Vector AVX512",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
+	[ICE_RX_AVX512] = {
+		.pkt_burst = ice_recv_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_AVX512_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx512,
+		.info = "Vector AVX512 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[ICE_RX_AVX512_OFFLOAD] = {
+		.pkt_burst = ice_recv_pkts_vec_avx512_offload,
+		.info = "Offload Vector AVX512",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true
+		}
+	},
 	[ICE_RX_AVX512_SCATTERED_OFFLOAD] = {
-		ice_recv_scattered_pkts_vec_avx512_offload, "Offload Vector AVX512 Scattered",
-		{ICE_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512,
-			{.scattered = true, .bulk_alloc = true}}},
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx512_offload,
+		.info = "Offload Vector AVX512 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #endif
 #endif
 };
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 6dac592eb4..141a62a7da 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -80,7 +80,6 @@
 #define ICE_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ ICE_TX_OFFLOAD_MASK)
 
-#define ICE_RX_NO_OFFLOADS 0
 /* basic scalar path */
 #define ICE_RX_SCALAR_OFFLOADS (				\
 			RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
-- 
2.34.1

