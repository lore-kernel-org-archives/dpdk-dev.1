Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1093ACE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADCEF427B4;
	Fri, 14 Nov 2025 18:41:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 80C8A41132
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142057; x=1794678057;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=UoFNxaX0dPma4c08MJmIP4MEuhS/hLDhqQFUJ/+nl4g=;
 b=IK6BmctTHK2HEYX+az3G2we1stQmMeCjUO8VRDBjbHuhl0yldEo4f6yW
 CSHHqBHJWuft5E/Qgnl7PpuSvCgl57wmoTQn0rlJlTY2G1vZG38mxrjek
 pWZR3JkTi33/4+YFJ2Cm/Jrywo5ZZamhtxJcMO3k9FwOZW+qmVxvsMS1W
 PDZjF3QMeE9TGQRjaFJZ51NnLEQpg0t09aSJfOjyD09sQ/pgQbp5EgD96
 AM9mowEC9EUvRLc92Tp+eBkWND0WH0kDuqPAzl5Wv7xWADYMvhlMwDHzq
 BwoHeBMHL/yhQcvej+1/45VwL0Z9eorid2wxwljhgrB1mmXUPTxNY4mH4 A==;
X-CSE-ConnectionGUID: CPkpFkBkT2aedZDd/wv8hg==
X-CSE-MsgGUID: bcPYBy4VS8m4Cj7yPOBkzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864307"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864307"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:56 -0800
X-CSE-ConnectionGUID: fQqxvsSBQ7Gqmo5lE134vA==
X-CSE-MsgGUID: iNrmonaOQZOIhXkF89QnNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650806"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 15/19] bus/fslmc: use the new VFIO mode API
Date: Fri, 14 Nov 2025 17:40:25 +0000
Message-ID: <7a80c84f2a4a113f9ce7b7897a0aeacde2e5f577.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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
index 49c61c9d2d..17b97d46bc 100644
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
index 550d4e0e8d..c20f7a26a3 100644
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

