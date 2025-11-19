Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9802CF318B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:03:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C60540A70;
	Wed, 19 Nov 2025 12:02:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id AF0494065D
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550149; x=1795086149;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=N96IKIHfIlFj0WZ6cvHrPNf2+phtF8pbjYPDFrr9cZY=;
 b=j6oNbIYpQX/WkXKEC7DYqPP8aSmKbdM02NXV0oZ+Dnz2wTurSBToO/Wh
 GK0CNEzluEZfnUAVuvNkSrTQnCaSn+wzPjEaXGbwGvUDdb22U/EC4T0Sg
 z4pjTv453YFea0fVGfWjW89cIzOyfFGTy3Olg8LODBF9ysQYysNoBSeOs
 F6T5UcW/7u3p8U32RNtyfiZmYP7WiYet9I3kXXZ8vq9+UPp2S3EAGICAk
 w2ctjh62iIiIlvpElq0zG9axpepHjuP4Xx9W997zSNftsfDeJtf/Ug9ZZ
 NugPdaB/lnSCT1/vjsbVjBnF6InLlsjoQ8mYzCkbmL3CO7TuVRVsulUla g==;
X-CSE-ConnectionGUID: 7OWy9PFqQXSIjBgnnH/mPA==
X-CSE-MsgGUID: xT45fk5HQMWjjIt0q4IAUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942161"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942161"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:28 -0800
X-CSE-ConnectionGUID: pfDdqkmjQFy0JClI+g651g==
X-CSE-MsgGUID: AjJg0s8DTs65GAPE9C6jbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409272"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 16/17] vfio: remove no-IOMMU check API
Date: Wed, 19 Nov 2025 11:01:59 +0000
Message-ID: <dd009ea8412bba780b5bc40533f0202bdf8071a8.1763549737.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763549736.git.anatoly.burakov@intel.com>
 <cover.1763549736.git.anatoly.burakov@intel.com>
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

