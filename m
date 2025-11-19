Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352C8CF319B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:10:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0B0C40BA4;
	Wed, 19 Nov 2025 12:08:51 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 4787640DCA
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550528; x=1795086528;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=N96IKIHfIlFj0WZ6cvHrPNf2+phtF8pbjYPDFrr9cZY=;
 b=guzYjf8ky07G/MoO00j4I08hQw+CYMBOZnO2rdShzRg3lT9aSXCxkfCs
 6O5fpzsBUu9/ifIi2ENJIxZHyUzAp4G32AkXj/zfkV6mgsKc7osDMNYbz
 XwMT0b7qv8sUiDDRs5O54sPCDY6lmOvxO4WBTCyny2SvMzvhnIl5t2nu6
 3p9ZaoJDCw2+1d1PU4gmoqrgIB/0AK5xjUEiEPZo/CVy+SRfLm4SppOnD
 H5Lr42cqV0EeA+UIRQ1rJmTZ78CG7gg6d8dUAHEp1r49juWREq0jwX5C2
 RvF3921AoOwqYq2j+YNlOGKnat/Iu5rmwXA0XobdUtJ4unahbxDaJuHYW g==;
X-CSE-ConnectionGUID: IeyvZXVPSeaS2mOpRtzIjA==
X-CSE-MsgGUID: JG3EZlDvQ4qT+waC1Va5aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65745002"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65745002"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:48 -0800
X-CSE-ConnectionGUID: OMdDnV9LSmK2TWjkksJjpw==
X-CSE-MsgGUID: C1H97gHHToGqA0bX+WCFyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158246"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 17/18] vfio: remove no-IOMMU check API
Date: Wed, 19 Nov 2025 11:08:15 +0000
Message-ID: <dd009ea8412bba780b5bc40533f0202bdf8071a8.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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

