Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AC8CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:46:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B2840687;
	Tue, 14 Oct 2025 10:45:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 15FAF40665
 for <dev@dpdk.org>; Tue, 14 Oct 2025 10:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431541; x=1791967541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tZ3eIRdor60US9v+TbscndyNw/Gle2wwcY0D3joAzZY=;
 b=enEs8XuEByHz4+GTSWQZpSieVuaSEo3Y3X/9qwpVuCOe9VVbxJXZZ9aL
 ZsLxOr50PgRDbe9SYkWTURITfz8WurcaXwTAwpf/h/mrG3Ca4IigEUeEu
 7zw9pWA7SpQgZn1zDFvssQ9Q1PuO4q1HWOX8tPwxU7QFRdU36ygxI63GP
 B9w56YHJCn/jIICwlfsY0q6PneY36cRedFl2n9gSfRBkPu7AEFeJ+kWe7
 4/AlFOSTmxcikByVy3+6XJB3qKsjXuesAnPNmkoGm8irsFyxq+TFoGmzJ
 ATPWPmc6VVr/8LyiUPiNvwPqo2IQdez1jlcMjdc1AYzNLcMkKCP4reejd A==;
X-CSE-ConnectionGUID: Ev/nS+T5SeqLnbonbvu+sQ==
X-CSE-MsgGUID: jlb4SPkWRj+JZnUld0ALhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796262"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796262"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:41 -0700
X-CSE-ConnectionGUID: O+Kg+WRTQEOQin6deBKeYw==
X-CSE-MsgGUID: uwRt51n/TOKeTOSnj62w2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630674"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:40 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 5/6] net/i40e: reformat the Rx path infos array
Date: Tue, 14 Oct 2025 08:45:16 +0000
Message-Id: <20251014084517.1407407-6-ciara.loftus@intel.com>
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
 drivers/net/intel/i40e/i40e_rxtx.c | 126 ++++++++++++++++++++++-------
 1 file changed, 95 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2bd0955225..c09696262d 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3290,42 +3290,106 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
 }
 
 static const struct ci_rx_path_info i40e_rx_path_infos[] = {
-	[I40E_RX_DEFAULT] = { i40e_recv_pkts, "Scalar",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED}},
-	[I40E_RX_SCATTERED] = { i40e_recv_scattered_pkts, "Scalar Scattered",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.scattered = true}}},
-	[I40E_RX_BULK_ALLOC] = { i40e_recv_pkts_bulk_alloc, "Scalar Bulk Alloc",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_DISABLED, {.bulk_alloc = true}}},
+	[I40E_RX_DEFAULT] = {
+		.pkt_burst = i40e_recv_pkts,
+		.info = "Scalar",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED}},
+	[I40E_RX_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts,
+		.info = "Scalar Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.scattered = true}},
+	[I40E_RX_BULK_ALLOC] = {
+		.pkt_burst = i40e_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_DISABLED,
+			.extra.bulk_alloc = true}},
 #ifdef RTE_ARCH_X86
-	[I40E_RX_SSE] = { i40e_recv_pkts_vec, "Vector SSE",
-		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[I40E_RX_SSE_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector SSE Scattered",
-		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
-	[I40E_RX_AVX2] = { i40e_recv_pkts_vec_avx2, "Vector AVX2",
-		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256, {.bulk_alloc = true}}},
-	[I40E_RX_AVX2_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx2, "Vector AVX2 Scattered",
-		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
-			{.scattered = true, .bulk_alloc = true}}},
+	[I40E_RX_SSE] = {
+		.pkt_burst = i40e_recv_pkts_vec,
+		.info = "Vector SSE",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_SSE_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector SSE Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_AVX2] = {
+		.pkt_burst = i40e_recv_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_AVX2_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec_avx2,
+		.info = "Vector AVX2 Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
 #ifdef CC_AVX512_SUPPORT
-	[I40E_RX_AVX512] = { i40e_recv_pkts_vec_avx512, "Vector AVX512",
-		{I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
-	[I40E_RX_AVX512_SCATTERED] = { i40e_recv_scattered_pkts_vec_avx512,
-		"Vector AVX512 Scattered", {I40E_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512,
-			{.scattered = true, .bulk_alloc = true}}},
+	[I40E_RX_AVX512] = {
+		.pkt_burst = i40e_recv_pkts_vec_avx512,
+		.info = "Vector AVX512",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_AVX512_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec_avx512,
+		.info = "Vector AVX512 Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
 #endif
 #elif defined(RTE_ARCH_ARM64)
-	[I40E_RX_NEON] = { i40e_recv_pkts_vec, "Vector Neon",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[I40E_RX_NEON_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector Neon Scattered",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
+	[I40E_RX_NEON] = {
+		.pkt_burst = i40e_recv_pkts_vec,
+		.info = "Vector Neon",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_NEON_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector Neon Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
 #elif defined(RTE_ARCH_PPC_64)
-	[I40E_RX_ALTIVEC] = { i40e_recv_pkts_vec, "Vector AltiVec",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128, {.bulk_alloc = true}}},
-	[I40E_RX_ALTIVEC_SCATTERED] = { i40e_recv_scattered_pkts_vec, "Vector AltiVec Scattered",
-		{I40E_RX_SCALAR_OFFLOADS, RTE_VECT_SIMD_128,
-			{.scattered = true, .bulk_alloc = true}}},
+	[I40E_RX_ALTIVEC] = {
+		.pkt_burst = i40e_recv_pkts_vec,
+		.info = "Vector AltiVec",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.bulk_alloc = true}},
+	[I40E_RX_ALTIVEC_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector AltiVec Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true}},
 #endif
 };
 
-- 
2.34.1

