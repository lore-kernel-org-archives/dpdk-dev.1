Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D764CEE33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210D540A6F;
	Tue, 18 Nov 2025 17:29:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 346834027A
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483394; x=1795019394;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=CAbMWAn3Y5WPW3uCiBtD2OsYjcnkknEUwRLePkHiqKs=;
 b=du9D2p/5aQUKOEGmIGCTqFHvRoF6/fm2OlffgxEBYhanIkKFqlAUttGe
 XNOVqA/p1QNzHJO2DhfAGvi9vAmxSl0apwf33ypylBv8ReMPPb60BV+D7
 MIG1PJUa9oHVZ9G57K5aJZnMOnskxjPyJAuL4w5gbq57XCGksyR/Hwb95
 mZ/z+P/GBu6gBlBqdNIxOJTJ/uV+BZrcYS2CiFKzFYTKiJK4C1UKC0NgU
 B8QgmYbcmrtxQoRwm585ygWp+/Skg0nT1umEsna+oOxbuJYDj957WpzE2
 RgerxQ3J5LFUDXQyPL2obR5Pe/vNwLkWd9rFLDKOS3zKe7ATVh5GLiPlo A==;
X-CSE-ConnectionGUID: XrOAOpZ1Q2GgLHc1ZDnRHQ==
X-CSE-MsgGUID: 7nk5USqDTxKOyL5X/d+VTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550650"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550650"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:53 -0800
X-CSE-ConnectionGUID: FLNp3mAwQQ+axE6Es363nw==
X-CSE-MsgGUID: pRgNMF5XTbaIIU74yCt29g==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 16/20] bus/fslmc: use the new VFIO mode API
Date: Tue, 18 Nov 2025 16:29:17 +0000
Message-ID: <c412840ac723acdb51b7c0be37f5753fa079ed88.1763483254.git.anatoly.burakov@intel.com>
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

