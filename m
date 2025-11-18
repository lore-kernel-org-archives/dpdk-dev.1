Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921BCEE33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DB8840A81;
	Tue, 18 Nov 2025 17:30:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 53D6440A71
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483397; x=1795019397;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f9e3/M9wARQ1Iv5XU6BdjAWvSITDsQ6acQYWHUrse1k=;
 b=FRYFtdEOHlh3lJtJ40bfNARUai217kEC5VKzImXGNh05C9udtWTcxwfK
 gWFVX4BLYgBVU3ZfOrnSH3aoBNfsWmeshYlWsCeZO9CxBPNmRPZyQ/gNf
 LOkvENE9PfeIxkgLav9I4SyleVGdyRigRELerjaeET8bldRnAnBMK64gv
 GJky/0cMEAU0w11ECAhg6dt0bud5I8noAvhuDEkTApE0bMwJDRisClw7A
 WGMwMH4eCD+YObKBeky5SAvnydfuIbtDr6L0PHyz0j/Tl5lf+dmV0ZV3C
 dooSwqgP/N21jeUZVinN8xFOLC76YzS2GV/s/dIxT6mShbjrfh9hhBtoL w==;
X-CSE-ConnectionGUID: PYVgVKc/Rku4C2/T38l78g==
X-CSE-MsgGUID: HbhlMRMNQTeicVxedZIf9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550667"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:57 -0800
X-CSE-ConnectionGUID: Q26+FCRHSXevZnTxclV0AQ==
X-CSE-MsgGUID: DgiYNOGRS2uZG9O2OyCg1Q==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v3 19/20] vfio: remove no-IOMMU check API
Date: Tue, 18 Nov 2025 16:29:20 +0000
Message-ID: <59400928f519e2cb0b119bdf23dda8cf3b143550.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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
index 7b3ce875a8..d850ef2c4f 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -842,12 +842,6 @@ int rte_vfio_is_enabled(__rte_unused const char *modname)
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
index b6d7b4591f..2730cfa67d 100644
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
index 8545552308..2e9ad7dbb4 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1310,13 +1310,6 @@ container_dma_unmap(struct container *cfg, uint64_t vaddr, uint64_t iova,
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

