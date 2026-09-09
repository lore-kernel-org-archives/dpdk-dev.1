Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAB6C79F8C
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:05:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C743242D27;
	Wed,  9 Sep 2026 12:03:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id D23C541144
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948186; x=1820484186;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HFI7M3gn4H7dyn5AUwYCEo9wsm5Wi+DljV9uIBi/4DQ=;
 b=DxkS4Owp05i59R0kTlcFVcOJyG4ueExZlS2V/lhQtChtqu9w4++5uYwv
 e50fLrkGohjT6/6IHbqTaf4kqLJW79z8sTdxbS/qIS1AxUZPlIdWHkHo5
 bG5RuzHN5fiKCUx4tBQk5UPxDhLftBzLZOl4AfSjKndXqt1br0at+jnfj
 hit77uyam2OFvIuKY0m9cchJb+C5ccIJwOetM/ylpyDVks7yVeQPO6FTi
 mpSxMkaFG7gLVwqGADvYF+ZJ25wgiYBpQBXXAUaiWEyqRcCo3qhBz7ZFT
 hjaX0kMOUg+r3G0W568/5H+OltPvG4LIuhlrdhqkcr4fiamL81RcLyV70 A==;
X-CSE-ConnectionGUID: z/1LxO+QTQqV0iBNu7RiWQ==
X-CSE-MsgGUID: g1bSvQEkT1edyoXNF+3Ljg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492301"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:03:06 -0700
X-CSE-ConnectionGUID: R1Oq/484Q6eXn/x1W/xLRQ==
X-CSE-MsgGUID: DXZ7qvIiQjWaohQeaeMiUg==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:03:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v16 25/26] vfio: remove no-IOMMU check API
Date: Wed,  9 Sep 2026 11:02:18 +0100
Message-ID: <f85dd79d792172ec6a252b3cf83bada095cf0a52.1788947938.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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
index af48f95d8f..0415c621ea 100644
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

