Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE92C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7504D40DDC;
	Thu, 27 Aug 2026 17:15:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A149340DF6
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843717; x=1819379717;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=36t/+6tp+OMnGirkVC8F1HOekMs+awgzQw0lym82Yco=;
 b=IHy+5xhbTatnN0qZl1sBF5HBIpsXx9TDcyhyDpmZwU1SBbHdCtBkyHbO
 jLYH/lguQFlK9fvwSbahNclytSPqTPXvvBFq3RB1m1fGZsk3EeDELJMRJ
 DqbRX8zmzY67eOQ9/US5ksrsbPFjl0r6O4PRU6n86jiJCCWqSEyF6RRto
 qj/bk/TpgbcyexrfqOUeYpLUwJnFYNcBlsLOzNOm42j9axP86WqMAqsaa
 p/cC8r60KPT6HqdMRWAFXyWRXWJsFqpVTmdQN3o7M1qyqLMYTnwtG0gxa
 Xi1CAkDTo575QlFx4B14OrwWRAabSNuzxnXzC6yTBN/V2KtavaWIo/vMz g==;
X-CSE-ConnectionGUID: zadYO+DZQu6SgDgTR1701w==
X-CSE-MsgGUID: RvnC+qaVTPCUPkGLA0/CCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371658"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371658"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:16 -0700
X-CSE-ConnectionGUID: w/xATkmXToe7pahByZiZPA==
X-CSE-MsgGUID: Izw1nQ7FTvm7kOM3K3w6og==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v13 20/24] bus/fslmc: use the new VFIO mode API
Date: Thu, 27 Aug 2026 16:14:23 +0100
Message-ID: <f62652a759cd50b2ba7ed45d83c33db9ebc99948.1787843386.git.anatoly.burakov@intel.com>
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

FSLMC bus only supports operating in group mode, and relies on no-IOMMU
mode checks. Use the new VFIO API's to query no-IOMMU status, as well as
protect the bus from initializing in non-group mode.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c  | 11 ++++++++++-
 drivers/bus/fslmc/fslmc_vfio.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d55c414ead..8bfbdac52e 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -332,6 +332,14 @@ rte_fslmc_scan(void)
 		goto scan_fail;
 	}
 
+	/* for container groups to work, VFIO must be in group mode */
+	if (dev_vfio_get_mode() != DEV_VFIO_MODE_GROUP &&
+			dev_vfio_get_mode() != DEV_VFIO_MODE_NOIOMMU) {
+		DPAA2_BUS_DEBUG("DPAA2: VFIO not in group mode");
+		ret = -EINVAL;
+		goto scan_fail;
+	}
+
 	ret = fslmc_get_container_group(group_name, &groupid);
 	if (ret != 0)
 		goto scan_fail;
@@ -500,7 +508,8 @@ rte_dpaa2_get_iommu_class(void)
 		return RTE_IOVA_DC;
 
 	/* check if all devices on the bus support Virtual addressing or not */
-	if (fslmc_all_device_support_iova() != 0 && dev_vfio_noiommu_is_enabled() == 0)
+	if (fslmc_all_device_support_iova() != 0 &&
+			dev_vfio_get_mode() != DEV_VFIO_MODE_NOIOMMU)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index c2b6ac1f3f..c416ef9f68 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -204,7 +204,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (dev_vfio_noiommu_is_enabled() > 0)
+	if (dev_vfio_get_mode() == DEV_VFIO_MODE_NOIOMMU)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
-- 
2.52.0

