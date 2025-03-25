Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD00C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Mar 2025 16:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D569040651;
	Tue, 25 Mar 2025 17:03:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9EF8140656
 for <dev@dpdk.org>; Tue, 25 Mar 2025 17:03:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742918601; x=1774454601;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sDl7FEpygHXm0+lHJAhBBwNIZgUfqjd44HAaB/+NtSg=;
 b=K+Jvs84rSlCEmY5tPoTQr86daPwMB+VVytnQUKdldL0ejKAUOjf6VUUJ
 xyhN2l+msDrUNj7AHZETNEvP0gVf3Qoujh0qsoSZmkR/71/3tM/SjrxmM
 ktZ6iGTlE4SDC9YubTAm2ok4FbsENEnnU3uQEaPeaJUblI1SHIGcfjTx6
 0z+XEAmY/OdbP2O1fvXn4rELej+pw9TY0e052mEwHZ/Lg27etI9C8+vE8
 FMCWHT7fPUxIA2Y7QB3zksYBxzVKsZpJIueArgYFThL45JyHxLEtZBack
 9Aq3okJwYarZsb8AoyHHajRrlkNXRVoER9BAc028f8iHVFcT2+57R+Hrs w==;
X-CSE-ConnectionGUID: CDlvjltxSHCgM1QHyWsxPg==
X-CSE-MsgGUID: h0R2a5GLTmSeH7Zlpz22lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="61565741"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="61565741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 09:03:20 -0700
X-CSE-ConnectionGUID: lKnlXKTIQ32XG/hTHyGkcA==
X-CSE-MsgGUID: SvgmBNaDTd+GV2MD6Yrn5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; d="scan'208";a="129086651"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by fmviesa005.fm.intel.com with ESMTP; 25 Mar 2025 09:03:18 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v5 04/11] drivers/net: remove AVX2 build-time define
Date: Tue, 25 Mar 2025 16:02:46 +0000
Message-ID: <20250325160254.1724560-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325160254.1724560-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250325160254.1724560-1-bruce.richardson@intel.com>
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

Since all supported compilers can generate AVX2 code, we will always
enable the build of the AVX2 files on x86. This means that
CC_AVX2_SUPPORT is always true on x86, so it can be removed and a
regular "#ifdef RTE_ARCH_x86" used in its place.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/bnxt/bnxt_ethdev.c        | 2 --
 drivers/net/octeon_ep/meson.build     | 1 -
 drivers/net/octeon_ep/otx_ep_ethdev.c | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index a0e3cd8bbe..2f37f5aa10 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3258,8 +3258,6 @@ static const struct {
 #if defined(RTE_ARCH_X86)
 	{bnxt_crx_pkts_vec,		"Vector SSE"},
 	{bnxt_recv_pkts_vec,		"Vector SSE"},
-#endif
-#if defined(RTE_ARCH_X86) && defined(CC_AVX2_SUPPORT)
 	{bnxt_crx_pkts_vec_avx2,	"Vector AVX2"},
 	{bnxt_recv_pkts_vec_avx2,	"Vector AVX2"},
 #endif
diff --git a/drivers/net/octeon_ep/meson.build b/drivers/net/octeon_ep/meson.build
index 9bf4627894..a4a7663d1d 100644
--- a/drivers/net/octeon_ep/meson.build
+++ b/drivers/net/octeon_ep/meson.build
@@ -15,7 +15,6 @@ sources = files(
 
 if arch_subdir == 'x86'
     sources += files('cnxk_ep_rx_sse.c')
-    cflags += ['-DCC_AVX2_SUPPORT']
     sources_avx2 = files('cnxk_ep_rx_avx.c')
 endif
 
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 8b14734b0c..10f2f8a2e0 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -91,11 +91,9 @@ otx_ep_set_rx_func(struct rte_eth_dev *eth_dev)
 		eth_dev->rx_pkt_burst = &cnxk_ep_recv_pkts;
 #ifdef RTE_ARCH_X86
 		eth_dev->rx_pkt_burst = &cnxk_ep_recv_pkts_sse;
-#ifdef CC_AVX2_SUPPORT
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256 &&
 		    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1)
 			eth_dev->rx_pkt_burst = &cnxk_ep_recv_pkts_avx;
-#endif
 #elif defined(RTE_ARCH_ARM64)
 		eth_dev->rx_pkt_burst = &cnxk_ep_recv_pkts_neon;
 #endif
@@ -105,11 +103,9 @@ otx_ep_set_rx_func(struct rte_eth_dev *eth_dev)
 		eth_dev->rx_pkt_burst = &cn9k_ep_recv_pkts;
 #ifdef RTE_ARCH_X86
 		eth_dev->rx_pkt_burst = &cn9k_ep_recv_pkts_sse;
-#ifdef CC_AVX2_SUPPORT
 		if (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256 &&
 		    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1)
 			eth_dev->rx_pkt_burst = &cn9k_ep_recv_pkts_avx;
-#endif
 #elif defined(RTE_ARCH_ARM64)
 		eth_dev->rx_pkt_burst = &cn9k_ep_recv_pkts_neon;
 #endif
-- 
2.45.2

