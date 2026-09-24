Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802B3C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95CE143300;
	Thu, 24 Sep 2026 18:14:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 510AF43314
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266463; x=1821802463;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rjj4buUm0eE8bdC037my+G4Mm1fdpQf6aAt9ZdTlL1w=;
 b=IUWtWW2v5rs5ElcUIifLkHxYwKMhwwLMi1Lzr3iKTjMudMUb0IB/jXdP
 P6hrZB9kvd0yabQdZhu0a5Y9c78QufefembxkcuZSz18btH354Rm97Tzi
 QVnNIhyYsmNANUEG2DGMDMLNUsv/ejkyz55/fRCyHBYB1fZGfnic+EvGz
 Sns1IDsMmPanrcSYetsvGZrU7QXWnu2s7w+k+YY4+WMgife14Ke054zl2
 7RnJwQXCB4zJUP5uI2vN0t56z4JPWZd6cYHg95WlTca8V0efuPizCTNla
 IQI2UWFhWy6s55n5UaQxq/hLdOazL6ytFxMBwVcL0p22lZ44gA1FWZawc Q==;
X-CSE-ConnectionGUID: 2pZ0TH4dRbmYYhfCAX1+fw==
X-CSE-MsgGUID: xMNJY2V/T5mrT93/hwN9TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000761"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000761"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:14:22 -0700
X-CSE-ConnectionGUID: AYy4Gt2eSGOF4LicjUBrIg==
X-CSE-MsgGUID: K6h9dugvSXmzmhMSY1Lazg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277830120"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:14:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v18 25/29] bus/fslmc: use the new VFIO IOVA mode API
Date: Thu, 24 Sep 2026 17:13:32 +0100
Message-ID: <d09067a44dbd20a79922ad2885c77399b28ea9a5.1790266167.git.anatoly.burakov@intel.com>
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

FSLMC bus only supports operating in group mode, and relies on no-IOMMU
mode checks. Use the new VFIO API's to query no-IOMMU status as well as to
protect the bus from initializing in non-group mode.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 10 +++++++++-
 drivers/bus/fslmc/fslmc_vfio.c |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d55c414eada..afb45e15db2 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -332,6 +332,13 @@ rte_fslmc_scan(void)
 		goto scan_fail;
 	}
 
+	/* for container groups to work, VFIO must be in group mode */
+	if (dev_vfio_get_mode() != DEV_VFIO_MODE_GROUP) {
+		DPAA2_BUS_DEBUG("DPAA2: VFIO not in group mode");
+		ret = -EINVAL;
+		goto scan_fail;
+	}
+
 	ret = fslmc_get_container_group(group_name, &groupid);
 	if (ret != 0)
 		goto scan_fail;
@@ -500,7 +507,8 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
+	if (fslmc_all_device_support_iova() != 0 &&
+			dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_VA)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index c2b6ac1f3f7..8e80336d517 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -204,7 +204,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (dev_vfio_noiommu_is_enabled() > 0)
+	if (dev_vfio_get_iova_mode() == DEV_VFIO_IOVA_MODE_PA)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
-- 
2.52.0

