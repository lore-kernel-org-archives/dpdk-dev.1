Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F904C35FFC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE394065B;
	Wed, 19 Mar 2025 18:30:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7B6AE4065C
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:30:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742405416; x=1773941416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HWqlTMZp1SbtkOdkcG+svvtR92lQq8NTO0hoLOcxAto=;
 b=AY0fqjR9XWR9pok0/Wi91g2ZUJVxsOX26HvJ+dNqjuioo5sLg+DM0/gV
 kVZpQMVWWpU38Pj67Rwb32fU80OTB9vIfB2AWbsGxxM6JnYRxmiq4D40p
 e6n9lRM4cdHpIg9NDeCofPuxt6bFMsd2tKoX5WNy3RWXEKp0zijC8Zwcb
 JHp/aIhJsf4BP+X2olFSFCexmI5lFWjHF+4LnjAk4trVCWayJ8ClU4NZW
 qLKzVTAQVqU2Isar2FxGtoS6C9XET5w82YSdtVgJBESf+T8HDe9AxEme+
 ZGAEIAkhVnLxU2lWv2Irni6EMMd6wogif2uh2t83TfICY8A22THodHSll Q==;
X-CSE-ConnectionGUID: lwKQfMtKT6WzYbl8rUw5ug==
X-CSE-MsgGUID: aMykvJtERLmCUYamlVXkhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43741976"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="43741976"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2025 10:30:16 -0700
X-CSE-ConnectionGUID: rF3NB3itQ1aqj+4FWesiQg==
X-CSE-MsgGUID: 43JbHT/tST697kGfFwtPXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; d="scan'208";a="153722558"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.28])
 by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 10:30:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, Bruce Richardson <bruce.richardson@intel.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Vamsi Attunuru <vattunuru@marvell.com>
Subject: [PATCH v4 04/11] drivers/net: remove AVX2 build-time define
Date: Wed, 19 Mar 2025 17:29:34 +0000
Message-ID: <20250319172942.2992053-5-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319172942.2992053-1-bruce.richardson@intel.com>
References: <20250314172339.12777-1-bruce.richardson@intel.com>
 <20250319172942.2992053-1-bruce.richardson@intel.com>
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
2.43.0

