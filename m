Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8B3C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E14A40679;
	Fri, 28 Aug 2026 15:07:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id A390B40B95
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922470; x=1819458470;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pY4ITT74IgYGtuaKCHKl7mJXJF7YCvCxoo6T3Ie6hL0=;
 b=VYlcFJQvvEw7QNadK+Ey4DwkemYCUrSiCWpqJC73ta/or91G7JsWCE1T
 QOZJJXSEupOWQBsL+nuEobiSEfLSAYzOSPsa6WbIPVVg+FZNDbovkLdb/
 FIXo8qkxfiilfWGIvldiVFsYRfrkx1d4Jf6fwapd5qv1bZd5JhO0Gxnr1
 9dfKQqTiiXkYdqYv25mBrAZhlQC02Ztq41iBQ8AqdNibNTCeGqN9oi+AM
 V/E6HyypxKxlhx4E2WE1YXoSphog6nGxSGe2LoOEI4a6H6HXVoAyoVwel
 itTsdIEvMBT7B6rkYrka8BY5819PLbcqnQIgS4WPmskZkZcKyUb1bIOOJ A==;
X-CSE-ConnectionGUID: uqmRJn1CRR6NatD7phLXwg==
X-CSE-MsgGUID: 2EhIUt6GSgeS2GwspKZ0xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964653"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:49 -0700
X-CSE-ConnectionGUID: jZemP8KaSnql945M2FzkNQ==
X-CSE-MsgGUID: +IbxT2oWRridHu8kjM4gOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271960352"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v14 24/25] vfio: remove no-IOMMU check API
Date: Fri, 28 Aug 2026 14:06:52 +0100
Message-ID: <f6a084ecb7638619f7395c3c2dc49840524473cd.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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
 lib/eal/freebsd/eal.c      |  7 -------
 lib/eal/include/dev_vfio.h | 14 --------------
 lib/eal/linux/eal_vfio.c   |  7 -------
 3 files changed, 28 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 753aaf8656..e857ce7309 100644
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
index 6404dd08c3..02978bf80a 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -177,20 +177,6 @@ __rte_internal
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
index 1cd1a44eef..df0cc1284c 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1325,13 +1325,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
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

