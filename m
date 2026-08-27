Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259F4C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:17:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFBAE40E1F;
	Thu, 27 Aug 2026 17:15:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 2FF5E4065A
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843720; x=1819379720;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=agAOGE8Xldhu02d4xY8b+9eZMzXUD2v6GTwt6zWiZsw=;
 b=H09z/qd/47ylcCrPgZJMyOPXj5TDQiOgSpaSoGru62X+qqwxeCuONKVn
 QexZdDadvwklh29iA3kfGh3MadEUH8sgX8Guu/Cn1WcfY7X30AVsPTBVb
 1Y0COg10CwgnCPycvrkl5fvVhfuCBUT1ER5a41TF58UUmKN3fXEZ1O7it
 pZBGjyyqXsf0hKUAEYXmHxQiHA21kSP+/jJZN7hV7hm+ymcKcAr53qFia
 Jp3BYtTmUCv0wcjU7rCxhokD8o1Q5k5aAOSrOEs14MoaOPTWIYv++ffca
 9c5MP1dbZRLPUhCjZ8szL/p9dFeZB/2b0pDDVTcMF44LCbgrHzSU+CfTy g==;
X-CSE-ConnectionGUID: N5+AGp4CRXW59QI4rt41jQ==
X-CSE-MsgGUID: HwYPAujrSw2LHsdWHtGLHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371668"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371668"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:19 -0700
X-CSE-ConnectionGUID: xdHy6+QBQw2bpZEXOp+6pw==
X-CSE-MsgGUID: mBvUMppwRGmVUNpjmNo7Ig==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:19 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v13 23/24] vfio: remove no-IOMMU check API
Date: Thu, 27 Aug 2026 16:14:26 +0100
Message-ID: <387367dbb9c3376d5ff4916fccbdf8a2874bbe43.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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
mode API, so remove it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      |  6 ------
 lib/eal/include/dev_vfio.h | 14 --------------
 lib/eal/linux/eal_vfio.c   |  7 -------
 3 files changed, 27 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 55e1ee63b2..b3bf97b4ef 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -856,12 +856,6 @@ int dev_vfio_is_enabled(__rte_unused const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int dev_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
 dev_vfio_get_group_num(__rte_unused const char *sysfs_base,
diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index d833e7878e..a3e4b63743 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -180,20 +180,6 @@ __rte_internal
 enum dev_vfio_mode
 dev_vfio_get_mode(void);
 
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
-dev_vfio_noiommu_is_enabled(void);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index ab808ed0a9..86498a3571 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1330,13 +1330,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int
-dev_vfio_noiommu_is_enabled(void)
-{
-	return vfio_global_cfg.mode == DEV_VFIO_MODE_NOIOMMU;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
-- 
2.52.0

