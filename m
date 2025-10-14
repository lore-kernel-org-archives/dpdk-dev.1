Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A74CCCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:46:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DBA140695;
	Tue, 14 Oct 2025 10:45:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 10EC64064C
 for <dev@dpdk.org>; Tue, 14 Oct 2025 10:45:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431542; x=1791967542;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eg41+TDQPCD+xu3OA7fASIEqkm5QitVuyP3qLyqMukE=;
 b=mADTgnBVbZwIrItXibQwFMTdTFA275VgIJfC3u4fD6obayvBUH/RdJ+s
 fO3tb9MONiap4F6kYT6naYdg8d7t0prD3XZMpWN5t5Tvw6GB2/evHdmqx
 JGyk8Z6LnnNZ/fV0T/S/DOtN4abHanrsTTsFfLttMwVpAzg+Xtw+yXFg9
 EAuRLMWBjAmOl2pzOnAblUCjmJ73J0QVMLyWh4C25GCHftkGA26E8Mmgb
 Zy8WoDFXQoPjvo6e9fGaNK/MGX3PZtXOe1X5Xf9K7nV7v+3Wk+CS8x6kB
 0PHLJ5QLkBQcD4bHaINnqFYiVH0wokcJGNiAbqbt5NzWaLvwDDSaGdX0H Q==;
X-CSE-ConnectionGUID: Wp5Ih8FYTaKZao57tQmrFQ==
X-CSE-MsgGUID: x3FPlarbTRikEO3hJw+JLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796263"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796263"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:42 -0700
X-CSE-ConnectionGUID: ck0+Ly10TjS/kBrOe9z7XQ==
X-CSE-MsgGUID: buS1scKURg2BJ0/bq8XWSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630677"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 6/6] net/ice: reformat the Rx path infos array
Date: Tue, 14 Oct 2025 08:45:17 +0000
Message-Id: <20251014084517.1407407-7-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014084517.1407407-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
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
 drivers/net/intel/ice/ice_rxtx.c | 124 +++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 411b353417..acc36ceb50 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3667,41 +3667,103 @@ ice_xmit_pkts_simple(void *tx_queue,
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
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED}},
+	[ICE_RX_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts,
+		.info = "Scalar Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.scattered = true}},
+	[ICE_RX_BULK_ALLOC] = {
+		.pkt_burst = ice_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc",
+		.features = {
+			.rx_offloads = ICE_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.bulk_alloc = true}},
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
+			.extra.bulk_alloc = true}},
+	[ICE_RX_SSE_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec,
+		.info = "Vector SSE Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
+	[ICE_RX_AVX2] = {
+		.pkt_burst = ice_recv_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true}},
+	[ICE_RX_AVX2_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx2,
+		.info = "Vector AVX2 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
+	[ICE_RX_AVX2_OFFLOAD] = {
+		.pkt_burst = ice_recv_pkts_vec_avx2_offload,
+		.info = "Offload Vector AVX2",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true}},
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
+			.extra.bulk_alloc = true}},
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
+			.extra.bulk_alloc = true}},
+	[ICE_RX_AVX512_SCATTERED] = {
+		.pkt_burst = ice_recv_scattered_pkts_vec_avx512,
+		.info = "Vector AVX512 Scattered",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
+	[ICE_RX_AVX512_OFFLOAD] = {
+		.pkt_burst = ice_recv_pkts_vec_avx512_offload,
+		.info = "Offload Vector AVX512",
+		.features = {
+			.rx_offloads = ICE_RX_VECTOR_OFFLOAD_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true}},
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
+			.extra.bulk_alloc = true}},
 #endif
 #endif
 };
-- 
2.34.1

