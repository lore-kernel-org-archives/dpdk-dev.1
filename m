Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293ECFCE08D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 14:19:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D12C740A79;
	Thu, 26 Feb 2026 15:18:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id F4103406FF
 for <dev@dpdk.org>; Thu, 26 Feb 2026 15:18:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772115488; x=1803651488;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PgY9RVVw40ON8zA8NEjmnZgAg0kRB24dM8yVGjghL08=;
 b=Z3Gi1F+/wHv7FSJtAjMx/yxKIH+OchYwnZ8OaGz74ENu83TKWv1QbPxJ
 EFQoiLZPqLXkMhsZzkB7pOLB585yvOrOuSTbo2S6j8gaPF04oeXfidrH0
 yeApw1h1MJZHmZ4ihZdWVgPoAeUaB0C9gL4S38gTTTkBf528WfBgFUbrr
 eIYcyfLwvtW1Ckmq80nEtSkyF/4qa5xv53kOHMIRqQCGez8o7YIJgZCRB
 RoIK+ny9z2V3iZThDeZe1ArsKY2raKGea4RMYouqzUOGM1y5KXsQEu/av
 f5eTmrrgTUMf/Lzrbmz+PB++3Jawf0kRjIH1AT+yLX4fCvPnfVb3RKT9R g==;
X-CSE-ConnectionGUID: BMy2Ve4mS/S8dP7fXnUa1g==
X-CSE-MsgGUID: kGzFZ0zaQg2bU87dJHhjXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84271146"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="84271146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:18:07 -0800
X-CSE-ConnectionGUID: rlxvNGrZQvGUl/khEZhUAQ==
X-CSE-MsgGUID: gSh4zCp1SRWlVmselrbOmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="220719441"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 26 Feb 2026 06:18:07 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 14/18] bus/fslmc: use the new VFIO mode API
Date: Thu, 26 Feb 2026 14:17:37 +0000
Message-ID: <3f01db6aaaa900ed372938882e98cb29ffa4c423.1772115412.git.anatoly.burakov@intel.com>
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

FSLMC bus only supports operating in group mode, and relies on no-IOMMU
mode checks. Use the new VFIO API's to query no-IOMMU status, as well as
protect the bus from initializing in non-group mode.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 10 +++++++++-
 drivers/bus/fslmc/fslmc_vfio.c |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index abdb0ad50d..d486c41ef1 100644
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

