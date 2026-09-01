Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6287C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:18:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 326F8410D3;
	Tue,  1 Sep 2026 18:16:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E01EB40B95
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279374; x=1819815374;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JmHYwvAnKtn/6Pq9isEjibrQ6meGKuaQBi3ruOuvPRM=;
 b=hlpPL6a4sw2O7jv1H+RtWglVlcwoAl5TBnDNAxu1lUj3A7PlcaBFhH3/
 7a1+VMhsbhwTgGR0GvH4EHRtxBstCdwCpylHjYgpeekVFAVyUQl2qs/Ww
 HTKqD3v0F4v7CUgqav1fZoln6cdk2wt4dWKIlorBvATRBe7XdFE0C1G1K
 CT5+BM2ulxorpTpqGmQnvoC1iuW7fLecZwk7rc43iAqCnuafdBNZZJ9jQ
 lQhdlFbHV5+BZ0ZoXzKGIJV57pyjEus9y2DJp2ix7Wu1lqy6t+lyu67uy
 y/L7dVN8x+nC0D9fjsztw4sGjO87kcrjVkCw/pHLWk5H90sz3g1PMffY0 g==;
X-CSE-ConnectionGUID: 1f7NErdJSFu8YoCRiIys6Q==
X-CSE-MsgGUID: RLEA4WlbT1eSNuItVa0+mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656121"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656121"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:13 -0700
X-CSE-ConnectionGUID: qVWgBvjQRJy5pS97fvzHzQ==
X-CSE-MsgGUID: MTus2VWhRCaZQq2K1JpDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032597"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v15 21/25] bus/fslmc: use the new VFIO IOMMU mode API
Date: Tue,  1 Sep 2026 17:15:27 +0100
Message-ID: <c034c6d2c04765954b1cc96526db982ac58a9ea8.1788278993.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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
 lib/eal/linux/eal_vfio.c       | 18 ++++++++++--------
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d55c414ead..aeef49a5ff 100644
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
+			dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
 		return RTE_IOVA_VA;
 
 	return RTE_IOVA_PA;
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index c2b6ac1f3f..0926ec9349 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -204,7 +204,7 @@ fslmc_vfio_add_group(int vfio_group_fd,
 	group->fd = vfio_group_fd;
 	group->groupid = iommu_group_num;
 	rte_strscpy(group->group_name, group_name, sizeof(group->group_name));
-	if (dev_vfio_noiommu_is_enabled() > 0)
+	if (dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
 		group->iommu_type = VFIO_NOIOMMU_IOMMU;
 	else
 		group->iommu_type = VFIO_TYPE1_IOMMU;
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 3d3a6c6bb0..f35bf77730 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -589,20 +589,22 @@ vfio_group_assign_device(struct vfio_container *cfg, const char *sysfs_base,
 		return VFIO_EXISTS;
 	}
 
+	/* allocate new device in config */
+	dev = vfio_device_create(cfg, vfio_global_cfg.mode);
+	if (dev == NULL) {
+		EAL_LOG(ERR, "No space to track new VFIO device");
+		return VFIO_NO_SPACE;
+	}
+
+	/* allocate strings for sysfs path and device address */
 	sysfs_dup = strdup(sysfs_base);
 	dev_dup = strdup(dev_addr);
 	if (sysfs_dup == NULL || dev_dup == NULL) {
 		EAL_LOG(ERR, "Cannot allocate memory for device %s", dev_addr);
 		free(sysfs_dup);
 		free(dev_dup);
-		return VFIO_NO_MEM;
-	}
-
-	/* allocate new device in config */
-	dev = vfio_device_create(cfg, vfio_global_cfg.mode);
-	if (dev == NULL) {
-		EAL_LOG(ERR, "No space to track new VFIO device");
-		return VFIO_NO_SPACE;
+		ret = VFIO_NO_MEM;
+		goto device_erase;
 	}
 
 	/* store sysfs path and device address */
-- 
2.52.0

