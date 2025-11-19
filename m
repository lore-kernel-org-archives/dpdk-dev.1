Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3558CF318B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:03:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E71540A4B;
	Wed, 19 Nov 2025 12:02:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CB7C402C3
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550146; x=1795086146;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CAbMWAn3Y5WPW3uCiBtD2OsYjcnkknEUwRLePkHiqKs=;
 b=iSJJF6EipE861NyFjqsP1Ij4WlckYUxFwdaviXgyi2SkDsesDdqCFVE+
 4P3BbpzQakNZUz54UWrhg6fJrA5InGGpi0UjBH9Gt2dVCkdY+joELyc/R
 4QMRigOKNfqIW3vy8wYSBn9sL+MnZjsGvuFkogo8qSiuiABfzdxjIpom9
 nobjnCcm3zLto/l+dJNM4ZSs53GKay8E+VLHqkNCqVW/0RuIWypVK628z
 EAAbtdsIrK3i9SwZ+YQFCfK5t4bindnsDlP5ufVvXNdLCiQLzUd20tiPK
 bSShh+aUbwtWKelCq8N+d749w8VT/H9TAW7pbx5OKDG2KNS5KK2s0HoJH Q==;
X-CSE-ConnectionGUID: YSkcjEA2Tk25xco5P3e5rw==
X-CSE-MsgGUID: Q43Cq6g9QdaYeClZn/fj5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942136"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942136"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:25 -0800
X-CSE-ConnectionGUID: suCs34ShRZeBrN6h+97Ttw==
X-CSE-MsgGUID: 7PGhXzyuRuusPAURVU1lEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409258"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 13/17] bus/fslmc: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:01:56 +0000
Message-ID: <ecf17757a9c0cee5ce7af14a2df444e249d1b34e.1763549737.git.anatoly.burakov@intel.com>
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

FSLMC bus only supports operating in group mode, and relies on no-IOMMU
mode checks. Use the new VFIO API's to query no-IOMMU status, as well as
protect the bus from initializing in non-group mode.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 10 +++++++++-
 drivers/bus/fslmc/fslmc_vfio.c |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4529ec5085..82b53bcc54 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -335,6 +335,13 @@ rte_fslmc_scan(void)
 		goto scan_fail;
 	}
 
+	/* for container groups to work, VFIO must be in group mode */
+	if (rte_vfio_get_mode() != RTE_VFIO_MODE_GROUP &&
+			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU) {
+		ret = -EINVAL;
+		goto scan_fail;
+	}
+
 	ret = fslmc_get_container_group(group_name, &groupid);
 	if (ret != 0)
 		goto scan_fail;
@@ -582,7 +589,8 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	if (fslmc_all_device_support_iova() != 0 && rte_vfio_noiommu_is_enabled() == 0)
+	if (fslmc_all_device_support_iova() != 0 &&
+			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 4b11b38322..afde967e34 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -192,7 +192,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (rte_vfio_noiommu_is_enabled() > 0)
+	if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
-- 
2.47.3

