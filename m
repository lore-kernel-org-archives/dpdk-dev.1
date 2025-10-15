Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEDACCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:08:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 131F6410ED;
	Wed, 15 Oct 2025 12:07:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id AACAF40276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:07:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522856; x=1792058856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7o0D+9lpbf7BG5BV3z5Z9mkfGIQwLoD1mhTW8SBR41E=;
 b=a24o6xAnKUg7vlYsKtFT2hmNCbdKUUAsi2PMnXaaomFyVOf2Au7oKlNK
 Ap07N64LKlfc/dTOs+/sH4cnpt4Sn/Sf/uyEQA1j2r3DSyUS0z2F3cnv1
 FZjJVAV5+cEQnxUyXQAGrSqW8RYEqsTzo3bxetTFyGaeEz/lAZwy0hMp5
 HQRm+YnxeR87Yey+zK+lnkR3y46r71Uim87QSJpC17ioaxYzD+BRDC7RU
 lHEovwWy4CaE+hfK5pPv+KNlMNJ849bxT7gRSMxk0As1j0Tzi6EqMU4E7
 eC9Kfdy4zr3AgUJ9a33NoAguFqL99oUFWNQLXCldqnqK/C9iaOvMhAs30 Q==;
X-CSE-ConnectionGUID: RCvSwWs0SKO/ix6JKyDcXA==
X-CSE-MsgGUID: m4tFdqjgQAi98E/fjfW3VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371820"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:36 -0700
X-CSE-ConnectionGUID: SJW4TO4bRXivcwwSREJnng==
X-CSE-MsgGUID: or2NhaptSTCgYz+LrczZlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262637"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:35 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 6/7] net/i40e: reformat the Rx path infos array
Date: Wed, 15 Oct 2025 10:07:22 +0000
Message-Id: <20251015100723.1603296-7-ciara.loftus@intel.com>
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
---
 drivers/net/intel/i40e/i40e_rxtx.c | 149 +++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2bd0955225..255414dd03 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3290,42 +3290,129 @@ i40e_recycle_rxq_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
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
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS
+		}
+	},
+	[I40E_RX_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts,
+		.info = "Scalar Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.extra.scattered = true
+		}
+	},
+	[I40E_RX_BULK_ALLOC] = {
+		.pkt_burst = i40e_recv_pkts_bulk_alloc,
+		.info = "Scalar Bulk Alloc",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.extra.bulk_alloc = true
+		}
+	},
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
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_SSE_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector SSE Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_AVX2] = {
+		.pkt_burst = i40e_recv_pkts_vec_avx2,
+		.info = "Vector AVX2",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_AVX2_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec_avx2,
+		.info = "Vector AVX2 Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_256,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
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
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_AVX512_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec_avx512,
+		.info = "Vector AVX512 Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_VECTOR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_512,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
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
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_NEON_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector Neon Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
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
+			.extra.bulk_alloc = true
+		}
+	},
+	[I40E_RX_ALTIVEC_SCATTERED] = {
+		.pkt_burst = i40e_recv_scattered_pkts_vec,
+		.info = "Vector AltiVec Scattered",
+		.features = {
+			.rx_offloads = I40E_RX_SCALAR_OFFLOADS,
+			.simd_width = RTE_VECT_SIMD_128,
+			.extra.scattered = true,
+			.extra.bulk_alloc = true
+		}
+	},
 #endif
 };
 
-- 
2.34.1

