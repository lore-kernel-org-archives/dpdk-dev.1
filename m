Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B77BC98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E24143320;
	Thu, 24 Sep 2026 18:14:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E395E43314
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266465; x=1821802465;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9EHGJ6dEmJaM2ZqbMOqo896N/dgG6OlUFJ2+sgTQsH4=;
 b=lUm29c9D4P8UAKNqsrCZMPlnklZUuV/ae+59dgnn4qk+LTN4QYtVLXQ6
 Vo/5Ulcx7+yOefcYE0c1Iv/GdpdywcpQdQMR5G9qPSdTlF9cnm8KuL8sU
 i7wayzlO8AXEFCvKAlp1GeyGRIlNbpvxvIriIg4HqGRaH5wxryV39r7XI
 bO9qYC1OFf2JKU7MoGa84rFusBBYzAcgA8AD5SPlgVfkSgBgTcdRObMAJ
 wcE4xxbMlI+0CgvHfLKvYUvqMtvD4rgyBgeco3hJQTADNr/gFDOnWLyXK
 9tqyDpF/GxhPdCNXg+gJJBiHjyzi3xikU0ksqtM+kIlA5p6e5bKhcyHk7 A==;
X-CSE-ConnectionGUID: UfBXHBHbSWakh1qitLnHHw==
X-CSE-MsgGUID: gSC9ezSXTfim+R/Mb0c4kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000774"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000774"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:25 -0700
X-CSE-ConnectionGUID: uKoK7BfGS+OPpns/7LWnsA==
X-CSE-MsgGUID: zHlDjUMLRVKNXut9RdMm1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830124"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 28/29] vfio: remove no-IOMMU check API
Date: Thu, 24 Sep 2026 17:13:35 +0100
Message-ID: <b14218e2a7545d3b3e7d74122cffe198deab28c5.1790266167.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1790266165.git.anatoly.burakov@intel.com>
 <cover.1790266165.git.anatoly.burakov@intel.com>
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
IOVA mode API, so remove it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/include/dev_vfio.h | 14 --------------
 lib/eal/linux/eal_vfio.c   |  7 -------
 2 files changed, 21 deletions(-)

diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index bca5bb36a6b..2f693ff761d 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -227,20 +227,6 @@ __rte_internal
 enum dev_vfio_iova_mode
 dev_vfio_get_iova_mode(void);
 
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
index e0cf806bbf8..57981270841 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -1452,13 +1452,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_noiommu_is_enabled)
-int
-dev_vfio_noiommu_is_enabled(void)
-{
-	return vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_PA;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
-- 
2.52.0

