Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84634FCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 741D840B9A;
	Thu, 26 Feb 2026 15:18:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 1A9914066E
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115491; x=1803651491;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MgQ/fhBZaImtyHVpa3bdlWJ6pjBeyFmqY1mKWB0gVTs=;
 b=IufjQAXqSoQnzTXSc+E0oXWsJno8pn+aUX6bqUsZL5A5ImSixm4bG1Gw
 nCj6bc90RvMP/8PIKVdxRS3Gq07r4JvsYMs4anY4buoB1eUj1JaauOZjv
 hRkxhWtVyvmal5So+bElAWCu0S1VsgwuFY6CIMHiqtC+zVzQEcBes/TRJ
 B1nAib4D4G6Fi1qbpWi5Lg40kEkGk49yHMPJ/bn1KsNemyt8ENS0VutAn
 s7m3hNtWKoRvnBX/lVRVUycTbRFqBVvfzyFcbf16Epnq4WycSwuXm584P
 mcM5LIRzs0Aqo7RKlIFXi59gybQ3uTZDVom2zXGpiw/BLH2j7fz2Vi4Ie g==;
X-CSE-ConnectionGUID: zz09y6axSkG4Huw1IS/NNA==
X-CSE-MsgGUID: ginL3cc+T/uHmYOgV308ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271161"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271161"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:18:10 -0800
X-CSE-ConnectionGUID: FLmtadkaQneSxjoCsh60SQ==
X-CSE-MsgGUID: XrfhLCJDTPC9lD1eVHZRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719489"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:18:10 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 17/18] vfio: remove no-IOMMU check API
Date: Thu, 26 Feb 2026 14:17:40 +0000
Message-ID: <211d83af6d9ce198e03f08dea1098726f20647c8.1772115412.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1772115411.git.anatoly.burakov@intel.com>
 <cover.1772115411.git.anatoly.burakov@intel.com>
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
index 86ac148c88..84bb618484 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -844,12 +844,6 @@ int rte_vfio_is_enabled(__rte_unused const char *modname)
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

