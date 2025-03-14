Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6135C282EC
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Mar 2025 17:45:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE94640662;
	Fri, 14 Mar 2025 18:44:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 0EA504065D
 for <dev@dpdk.org>; Fri, 14 Mar 2025 18:44:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741974292; x=1773510292;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O+urjUx9NCYEOlNmq/jpcRtZZEZQtklGvmzur2EwCOU=;
 b=HZBIbi6ZKhuK9G1uAMje4J64jDKww/QQ2DPNKqOIf0mdmrMY/O1S8gfb
 A8JJT+CJSgxGTZPxFFPsjbFjavdV4qU2GflvjPYIlAbUJMVGVWYCrXcoP
 eY72XSxIe6wW2GW8grSQqlZTZTKW1sMrh+TRJReqOaWmnbwy2BUvXwW/O
 QziZ3TlLegFu8fCetCN1W7lMtEDphf5+ViPvQL26Ec0UazDXAZZlE0lnW
 +rTrYDjrDF8l2Ng7gOBhDqYUApRDNIC29aMlCF8lIC7AX2nstxe/TUG2o
 semq9eC65jdGieyE9RQ7goSUaNsGaUNKbteYdLOvOAjg0ggkXHcahJrHp Q==;
X-CSE-ConnectionGUID: 4gBxljgdSJSrW4BPvGOpOg==
X-CSE-MsgGUID: qHjSPtF8SgiFrX3YNbbXZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11373"; a="46925703"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="46925703"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2025 10:44:52 -0700
X-CSE-ConnectionGUID: hAROsm6iRJSDXXpjjSdGpA==
X-CSE-MsgGUID: 7Cnnv7iISGyaTEA1+Xh//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; d="scan'208";a="125528758"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa003.fm.intel.com with ESMTP; 14 Mar 2025 10:44:50 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v2 4/4] drivers/net: remove AVX2 build-time define
Date: Fri, 14 Mar 2025 17:44:38 +0000
Message-ID: <20250314174439.112658-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314174439.112658-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250314174439.112658-1-bruce.richardson@intel.com>
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
---
 drivers/net/bnxt/bnxt_ethdev.c        | 2 --
 drivers/net/octeon_ep/meson.build     | 1 -
 drivers/net/octeon_ep/otx_ep_ethdev.c | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 144d4377bd..a318604c20 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -3238,8 +3238,6 @@ static const struct {
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
2.43.0

