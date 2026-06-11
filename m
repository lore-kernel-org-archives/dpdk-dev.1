Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF844CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:11:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4AD24333C;
	Thu, 11 Jun 2026 17:09:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 17AA843245
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190586; x=1812726586;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=8qzcE2Bs2dhTOld/kYb4fIc1o09bR5Vj6awpUO+1UFE=;
 b=BRF5b203WmrkTT9yLNTxLowaUpS7DTnKPX+WPRQ9nLixozjE9p7zDvAF
 WPxYt41HfVSA+dDF6arhz5WTLzJ66fQp2s25d8y0wb6xrVoJY9tkvNLUU
 wSLP8RtZFpiJcYcpRggGnxP61Z8lnPYQzZlSQA1kGWikJlXn9miAw83E0
 6NRvY1o9+bfAx51qNvG0N+ROh5qaLujDAfJwxoIjun5uyib1MYS0fwobG
 3ZM+xGel2CtLWvSJQKcdKT5g+5dK6fINCzGhd9d1BvNcW0atNO1+inu0U
 SVJJ8Du6CS7guLHO9uuBywMicvFWuYsYEcmIYVUtRDfqTuUg+BVJyjukT w==;
X-CSE-ConnectionGUID: wIBpdg7ASwCjCCppXfKVlw==
X-CSE-MsgGUID: OszntAqBRm2YVJdO3zanGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845422"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845422"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:45 -0700
X-CSE-ConnectionGUID: f2cONg0VRCGPO5323JhQoA==
X-CSE-MsgGUID: x8avPL5qRmeZEFnxdlRFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625441"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 17/18] vfio: remove no-IOMMU check API
Date: Thu, 11 Jun 2026 16:09:09 +0100
Message-ID: <21e69c92f3d50a6cdb341fa10ec69b20f10025b2.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
References: 
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

The `rte_vfio_noiommu_is_enabled()` check has now been replaced by the new
mode API, so remove it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      |  6 ------
 lib/eal/include/rte_vfio.h | 14 --------------
 lib/eal/linux/eal_vfio.c   |  7 -------
 3 files changed, 27 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 6c1d1e3751..bb05a969a9 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -850,12 +850,6 @@ int rte_vfio_is_enabled(__rte_unused const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
-int rte_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index 0af41c3610..c4ba0e5cda 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -170,20 +170,6 @@ __rte_internal
 enum rte_vfio_mode
 rte_vfio_get_mode(void);
 
-/**
- * @internal
- * Check if VFIO NOIOMMU mode is enabled.
- *
- * This function is only relevant on Linux in group mode.
- *
- * @return
- *   1 if enabled.
- *   0 if not enabled or not supported.
- */
-__rte_internal
-int
-rte_vfio_noiommu_is_enabled(void);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 708d14ad51..c104008a43 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1278,13 +1278,6 @@ container_dma_unmap(struct container *cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
-int
-rte_vfio_noiommu_is_enabled(void)
-{
-	return vfio_cfg.mode == RTE_VFIO_MODE_NOIOMMU;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
-- 
2.47.3

