Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6170DCCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E21CF40EF0;
	Wed, 15 Oct 2025 12:07:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id CE1AC40E22
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522856; x=1792058856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1aTrNIFXcuiPYxkWPGldYZlfOV1UAzZaKpra0rxEpXs=;
 b=fcchzBsINYUSWXFYXHcXrcaNWFa8ABPv9AsEMwtm12PYFMBV8JmLytun
 D669+rqiO8cXKq8inVT/CNJSVem4nYKIbNBppE12V81hK0L0clnBqI25y
 LjOVrz/WhC4FiesdPVPmPD1NVnSOAdFj8JOJL/nEcrw8s4WAo+VI9AV81
 Igu6/qkQBi5TdHGkeZ38jYaVLpgvR5pgpjJQxWWOxMgIBXokmmng00huw
 XckIFDVU9VS3qILgvq/ITL+1uBbztgZMuDbprIsvXw0LzuHRQIwIvMdvw
 28rGb8Fa0xaFtz9EhJiarcYKI2ebsWIAM4NY/iSmRonkzpqm3StMxiaY/ g==;
X-CSE-ConnectionGUID: rrTUqfNER9yu2NHfO9+UHA==
X-CSE-MsgGUID: 30Ol17LNQc+SRJPOPfAuUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371811"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371811"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:35 -0700
X-CSE-ConnectionGUID: 9wUidsZyRI+Myh+sfbWYwg==
X-CSE-MsgGUID: FZlqnDwbQKiF4dOWEGFDAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262630"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:34 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 5/7] net/iavf: reformat the Rx path infos array
Date: Wed, 15 Oct 2025 10:07:21 +0000
Message-Id: <20251015100723.1603296-6-ciara.loftus@intel.com>
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
* Removed reduntant assignment to zero value (IAVF_RX_NO_OFFLOADS) and
remove its definitions as it is not used any more.
* Newline for closing braces.
* Removed assignment of RTE_VECT_SIMD_DISABLED to simd_width, the
selection logic can work when this is set to zero for the scalar path.
---
 drivers/net/intel/iavf/iavf_rxtx.c | 337 ++++++++++++++++++++++-------
 drivers/net/intel/iavf/iavf_rxtx.h |   1 -
 2 files changed, 258 insertions(+), 80 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index e217328823..a3ef13c791 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3720,99 +3720,278 @@ iavf_xmit_pkts_no_poll(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts);
 
 static const struct ci_rx_path_info iavf_rx_path_infos[] = {
-	[IAVF_RX_DISABLED] = {iavf_recv_pkts_no_poll, "Disabled",
-		{IAVF_RX_NO_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.disabled = true}}},
-	[IAVF_RX_DEFAULT] = {iavf_recv_pkts, "Scalar",
-		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED}},
-	[IAVF_RX_SCATTERED] = {iavf_recv_scattered_pkts, "Scalar Scattered",
-		{IAVF_RX_SCALAR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
-			{.scattered = true}}},
-	[IAVF_RX_FLEX_RXD] = {iavf_recv_pkts_flex_rxd, "Scalar Flex",
-		{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.flex_desc = true}}},
-	[IAVF_RX_SCATTERED_FLEX_RXD] = {iavf_recv_scattered_pkts_flex_rxd, "Scalar Scattered Flex",
-		{IAVF_RX_SCALAR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_DISABLED,
-				{.scattered = true, .flex_desc = true}}},
-	[IAVF_RX_BULK_ALLOC] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
-		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
-	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {iavf_recv_pkts_bulk_alloc, "Scalar Bulk Alloc Flex",
-			{IAVF_RX_SCALAR_FLEX_OFFLOADS, RTE_VECT_SIMD_DISABLED,
-			{.flex_desc = true, .bulk_alloc = true}}},
+	[IAVF_RX_DISABLED] = {
+		.pkt_burst = iavf_recv_pkts_no_poll,
+		.info = "Disabled",
+		.features = {
+			.extra.disabled = true
+		}
+	},
+	[IAVF_RX_DEFAULT] = {
+		.pkt_burst = iavf_recv_pkts,
+		.info = "Scalar",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS
+		}
+	},
+	[IAVF_RX_SCATTERED] = {
+		.pkt_burst = iavf_recv_scattered_pkts,
+		.info = "Scalar Scattered",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.extra.scattered = true
+		}
+	},
+	[IAVF_RX_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_flex_rxd,
+		.info = "Scalar Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS,
+			.extra.flex_desc = true
+		}
+	},
+	[IAVF_RX_SCATTERED_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_scattered_pkts_flex_rxd,
+		.info = "Scalar Scattered Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.extra.scattered = true,
+			.extra.flex_desc = true
+		}
+	},
+	[IAVF_RX_BULK_ALLOC] = {
+		.pkt_burst = iavf_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_BULK_ALLOC_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_FLEX_OFFLOADS,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #ifdef RTE_ARCH_X86
-	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector SSE",
-		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[IAVF_RX_SSE_SCATTERED] = {iavf_recv_scattered_pkts_vec, "Vector Scattered SSE",
-		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
-	[IAVF_RX_SSE_FLEX_RXD] = {iavf_recv_pkts_vec_flex_rxd, "Vector Flex SSE",
-		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_128,
-			{.flex_desc = true, .bulk_alloc = true}}},
+	[IAVF_RX_SSE] = {
+		.pkt_burst = iavf_recv_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_SSE_SCATTERED] = {
+		.pkt_burst = iavf_recv_scattered_pkts_vec,
+		.info = "Vector Scattered SSE",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_SSE_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_vec_flex_rxd,
+		.info = "Vector Flex SSE",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_SSE_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_flex_rxd, "Vector Scattered SSE Flex",
-		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			RTE_VECT_SIMD_128,
-			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
-	[IAVF_RX_AVX2] = {iavf_recv_pkts_vec_avx2, "Vector AVX2",
-		{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
-	[IAVF_RX_AVX2_SCATTERED] = {iavf_recv_scattered_pkts_vec_avx2, "Vector Scattered AVX2",
-		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
-			{.scattered = true, .bulk_alloc = true}}},
-	[IAVF_RX_AVX2_OFFLOAD] = {iavf_recv_pkts_vec_avx2_offload, "Vector AVX2 Offload",
-		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_flex_rxd,
+		.info = "Vector Scattered SSE Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
+				       RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX2] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX2_SCATTERED] = {
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx2,
+		.info = "Vector Scattered AVX2",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX2_OFFLOAD] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx2_offload,
+		.info = "Vector AVX2 Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX2_SCATTERED_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx2_offload, "Vector Scattered AVX2 offload",
-		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
-			{.scattered = true, .bulk_alloc = true}}},
-	[IAVF_RX_AVX2_FLEX_RXD] = {iavf_recv_pkts_vec_avx2_flex_rxd, "Vector AVX2 Flex",
-		{IAVF_RX_VECTOR_FLEX_OFFLOADS, RTE_VECT_SIMD_256,
-			{.flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx2_offload,
+		.info = "Vector Scattered AVX2 Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX2_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx2_flex_rxd,
+		.info = "Vector AVX2 Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_avx2_flex_rxd, "Vector Scattered AVX2 Flex",
-		{IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_256,
-			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx2_flex_rxd,
+		.info = "Vector Scattered AVX2 Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_pkts_vec_avx2_flex_rxd_offload, "Vector AVX2 Flex Offload",
-			{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_256,
-				{.flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_pkts_vec_avx2_flex_rxd_offload,
+		.info = "Vector AVX2 Flex Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload,
-		"Vector Scattered AVX2 Flex Offload",
-		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			RTE_VECT_SIMD_256,
-			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload,
+		.info = "Vector Scattered AVX2 Flex Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
+				       RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #ifdef CC_AVX512_SUPPORT
-	[IAVF_RX_AVX512] = {iavf_recv_pkts_vec_avx512, "Vector AVX512",
-		{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
+	[IAVF_RX_AVX512] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX512_SCATTERED] = {
-		iavf_recv_scattered_pkts_vec_avx512, "Vector Scattered AVX512",
-		{IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
-			{.scattered = true, .bulk_alloc = true}}},
-	[IAVF_RX_AVX512_OFFLOAD] = {iavf_recv_pkts_vec_avx512_offload, "Vector AVX512 Offload",
-		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx512,
+		.info = "Vector Scattered AVX512",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX512_OFFLOAD] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx512_offload,
+		.info = "Vector AVX512 Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX512_SCATTERED_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx512_offload, "Vector Scattered AVX512 offload",
-		{IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
-			{.scattered = true, .bulk_alloc = true}}},
-	[IAVF_RX_AVX512_FLEX_RXD] = {iavf_recv_pkts_vec_avx512_flex_rxd, "Vector AVX512 Flex",
-		{IAVF_RX_VECTOR_FLEX_OFFLOADS, RTE_VECT_SIMD_512,
-			{.flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx512_offload,
+		.info = "Vector Scattered AVX512 Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[IAVF_RX_AVX512_FLEX_RXD] = {
+		.pkt_burst = iavf_recv_pkts_vec_avx512_flex_rxd,
+		.info = "Vector AVX512 Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD] = {
-		iavf_recv_scattered_pkts_vec_avx512_flex_rxd, "Vector Scattered AVX512 Flex",
-		{IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER, RTE_VECT_SIMD_512,
-			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx512_flex_rxd,
+		.info = "Vector Scattered AVX512 Flex",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX512_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_pkts_vec_avx512_flex_rxd_offload, "Vector AVX512 Flex Offload",
-		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_512,
-			{.flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_pkts_vec_avx512_flex_rxd_offload,
+		.info = "Vector AVX512 Flex Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 	[IAVF_RX_AVX512_SCATTERED_FLEX_RXD_OFFLOAD] = {
-		iavf_recv_scattered_pkts_vec_avx512_flex_rxd_offload,
-		"Vector Scattered AVX512 Flex offload",
-		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			RTE_VECT_SIMD_512,
-			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
+		.pkt_burst = iavf_recv_scattered_pkts_vec_avx512_flex_rxd_offload,
+		.info = "Vector Scattered AVX512 Flex Offload",
+		.features = {
+			.rx_offloads = IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS |
+				       RTE_ETH_RX_OFFLOAD_SCATTER,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.flex_desc = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #endif
 #elif defined RTE_ARCH_ARM
-	[IAVF_RX_SSE] = {iavf_recv_pkts_vec, "Vector Neon",
-		{IAVF_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
+	[IAVF_RX_SSE] = {
+		.pkt_burst = iavf_recv_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.rx_offloads = IAVF_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true
+		}
+	},
 #endif
 };
 
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 44be29caf6..5c9339b99f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -55,7 +55,6 @@
 		RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_QINQ_INSERT)
 
-#define IAVF_RX_NO_OFFLOADS 0
 /* basic scalar path */
 #define IAVF_RX_SCALAR_OFFLOADS (			\
 		RTE_ETH_RX_OFFLOAD_VLAN_STRIP |		\
-- 
2.34.1

