Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CE5C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:18:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72C4C410E6;
	Tue,  1 Sep 2026 18:16:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A0ABD40DCD
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279377; x=1819815377;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=dx9rIUUxENsNXHDHdghEG7Xc4NlaCtGnK0pAw9SAbjo=;
 b=LYeYxwl2vRbGAi2rCtwbbVkR1ZXr9ihIoux6P4pWN7t7ytcIdN21urRX
 CMDzsjXnoi3gsIIHL9zXThCRYtuuda4Y5judIbeajKJpVQzXl5WteVfua
 IrLIplrxikJfmZtyhK6uLjKJGrlWQo4xdk60iSKO3bHMhCLX2ZOfcf6YA
 wjLKITsopTTG1nfU0x9adcEcppL8a5i2BbWRxrTl15YFubh+rP4OuQoQd
 e25BFySdMILQnGxwi7iWl3fKeahQ0C6xRIvLKreoyDIy/m5Q+RLMShipV
 UtRXlabl5A6WzuruWZ0nSv7M1JUS6UpWvvbPdivvgtn4EW8xOVJyj6ci1 g==;
X-CSE-ConnectionGUID: ooA0YJDYQyeDpzzcmt/DOQ==
X-CSE-MsgGUID: mQKA+BhbR7a0KqHO9r61Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656129"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656129"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:16 -0700
X-CSE-ConnectionGUID: 7rp7Ci8fSm21A4og0HCwaw==
X-CSE-MsgGUID: 8xVAfxqwRB+ARRrLIKrMzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032610"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v15 24/25] vfio: remove no-IOMMU check API
Date: Tue,  1 Sep 2026 17:15:30 +0100
Message-ID: <0d4f608df95e4858f8c0fd498ae1095560abbd6e.1788278993.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

The `dev_vfio_noiommu_is_enabled()` check has now been replaced by the new
IOMMU mode API, so remove it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      |  7 -------
 lib/eal/include/dev_vfio.h | 14 --------------
 lib/eal/linux/eal_vfio.c   |  7 -------
 3 files changed, 28 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 574a3a9fa4..62b8e04ea1 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -860,13 +860,6 @@ dev_vfio_is_enabled(__rte_unused const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int
-dev_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
 dev_vfio_get_group_num(__rte_unused const char *sysfs_base,
diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index c62d38e524..cd7232ccd5 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -203,20 +203,6 @@ __rte_internal
 enum dev_vfio_iommu_mode
 dev_vfio_get_iommu_mode(void);
 
-/**
- * @internal
- * Check if VFIO NOIOMMU mode is enabled.
- *
- * This function is only relevant on Linux.
- *
- * @return
- *   1 if enabled.
- *   0 if not enabled or not supported.
- */
-__rte_internal
-int
-dev_vfio_noiommu_is_enabled(void);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index f35bf77730..884710be11 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1400,13 +1400,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int
-dev_vfio_noiommu_is_enabled(void)
-{
-	return vfio_global_cfg.iommu_mode == DEV_VFIO_IOMMU_MODE_UNSAFE;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
-- 
2.52.0

