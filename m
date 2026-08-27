Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42763C61DC4
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EBC940A73;
	Thu, 27 Aug 2026 17:14:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3EE7540150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843694; x=1819379694;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=IUm0YyQP/r8qX198tVGlOxOP/QNRBMP09iW1V1t/VqE=;
 b=Id/6wyGXM3nTA/Zj5V1PxvJ7i0PFfJNbvLYWOM9JggvSz6Z9JsQdlx+y
 CnWvs9Ai3HnD6GgTZXZgqYI46w5cn3mBVzsooySTa+pB6KNMvw5mHnQ3m
 px2lrFIxnJZ9+jOWUiYSrGDf9D/hZqVkrSIit4EM+JV5KbYr2Hkot6Qnx
 H3rT4kM2zrCRiCHWX0cHjnBWml4uZ48LpKiQtuhkMpqYdKGhMdYTVab1x
 b1SjbtEstkhCWE2FvPPkHgSJRB7zstDwmzZ1J5MQpiUDCXMual69aDORi
 BVc78uTBMhll565Fh47qqqJYhaG1/e0w5Bko3ryde5fsLkaMU1VHNUXW/ w==;
X-CSE-ConnectionGUID: 7tdJ4KoUSLuHtKZ2jQJ85Q==
X-CSE-MsgGUID: p1/rUlgySZ6b/HooJt1M1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371589"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371589"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:14:53 -0700
X-CSE-ConnectionGUID: SblrlwFeTDiNbnC/he8zvQ==
X-CSE-MsgGUID: qlslqGPvRg+IIctaVbUDoA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:14:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v13 05/24] vfio: do proper teardown on VFIO cleanup
Date: Thu, 27 Aug 2026 16:14:08 +0100
Message-ID: <29177ea6b9fdb0872ead75be16e4abcbadcdf295.1787843386.git.anatoly.burakov@intel.com>
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

Currently, VFIO cleanup only unregisters multiprocess callback, but does
not destroy containers, groups, and user mem maps. Do all of that on VFIO
cleanup. In order to distinguish between config that is not initialized vs.
config that has been initialized but happens to have fd == 0, move the
global VFIO enabled flag out of the config, and add a separate per-config
"enabled" flag that can be checked to avoid attempting to clean up configs
that were never initialized in the first place.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio.c | 77 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 6c77076bc3..84bb845e96 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -46,7 +46,7 @@ struct user_mem_maps {
 };
 
 struct vfio_config {
-	int vfio_enabled;
+	bool enabled;
 	int vfio_container_fd;
 	int vfio_active_groups;
 	const struct vfio_iommu_type *vfio_iommu_type;
@@ -58,6 +58,9 @@ struct vfio_config {
 static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
 static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 
+/* whether VFIO is enabled (usable) in this process */
+static bool vfio_enabled;
+
 static int vfio_type1_dma_map(int);
 static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_spapr_dma_map(int);
@@ -686,7 +689,7 @@ vfio_sync_default_container(void)
 		return -1;
 
 	/* default container fd should have been opened in rte_vfio_enable() */
-	if (!default_vfio_cfg->vfio_enabled ||
+	if (!vfio_enabled ||
 			default_vfio_cfg->vfio_container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
 		return -1;
@@ -1112,6 +1115,7 @@ rte_vfio_enable(const char *modname)
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
 	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
+		vfio_cfgs[i].enabled = false;
 		vfio_cfgs[i].vfio_container_fd = -1;
 		vfio_cfgs[i].vfio_active_groups = 0;
 		vfio_cfgs[i].vfio_iommu_type = NULL;
@@ -1167,7 +1171,8 @@ rte_vfio_enable(const char *modname)
 	/* check if we have VFIO driver enabled */
 	if (default_vfio_cfg->vfio_container_fd != -1) {
 		EAL_LOG(INFO, "VFIO support initialized");
-		default_vfio_cfg->vfio_enabled = 1;
+		default_vfio_cfg->enabled = true;
+		vfio_enabled = true;
 	} else {
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
 	}
@@ -1180,7 +1185,7 @@ int
 rte_vfio_is_enabled(const char *modname)
 {
 	const int mod_available = rte_eal_check_module(modname) > 0;
-	return default_vfio_cfg->vfio_enabled && mod_available;
+	return vfio_enabled && mod_available;
 }
 
 int
@@ -1357,7 +1362,7 @@ rte_vfio_get_container_fd(void)
 	 * The default container is set up during rte_vfio_enable().
 	 * This function does not create a new container.
 	 */
-	if (!default_vfio_cfg->vfio_enabled)
+	if (!vfio_enabled)
 		return -1;
 
 	return default_vfio_cfg->vfio_container_fd;
@@ -2090,6 +2095,7 @@ rte_vfio_container_create(void)
 		EAL_LOG(NOTICE, "Fail to create a new VFIO container");
 		return -1;
 	}
+	vfio_cfgs[i].enabled = true;
 
 	return vfio_cfgs[i].vfio_container_fd;
 }
@@ -2113,6 +2119,7 @@ rte_vfio_container_destroy(int container_fd)
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
+	vfio_cfg->enabled = false;
 	vfio_cfg->vfio_container_fd = -1;
 	vfio_cfg->vfio_active_groups = 0;
 	vfio_cfg->vfio_iommu_type = NULL;
@@ -2218,9 +2225,69 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
 }
 
+static void
+vfio_cleanup_config(struct vfio_config *vfio_cfg)
+{
+	unsigned int i;
+
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
+		struct vfio_group *group = &vfio_cfg->vfio_groups[i];
+
+		if (group->group_num == -1)
+			continue;
+		if (group->devices != 0) {
+			EAL_LOG(ERR, "Cannot cleanup VFIO group %d with %d devices",
+				group->group_num, group->devices);
+			return;
+		}
+		if (group->fd >= 0 && close(group->fd) < 0) {
+			EAL_LOG(ERR, "Cannot close VFIO group %d: %s",
+				group->group_num, strerror(errno));
+			return;
+		}
+
+		group->group_num = -1;
+		group->fd = -1;
+		group->devices = 0;
+		vfio_cfg->vfio_active_groups--;
+	}
+
+	/* if there are still active groups, we cannot cleanup the container */
+	if (vfio_cfg->vfio_active_groups != 0) {
+		EAL_LOG(ERR, "Cannot cleanup VFIO container with %d active groups",
+			vfio_cfg->vfio_active_groups);
+		return;
+	}
+
+	if (vfio_cfg->vfio_container_fd >= 0 &&
+			close(vfio_cfg->vfio_container_fd) < 0) {
+		EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
+		return;
+	}
+
+	vfio_cfg->vfio_container_fd = -1;
+	vfio_cfg->enabled = false;
+	vfio_cfg->vfio_iommu_type = NULL;
+
+	vfio_cfg->mem_maps.n_maps = 0;
+	memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
 void
 rte_vfio_cleanup(void)
 {
+	unsigned int i;
+
 	vfio_mp_sync_cleanup();
+
+	/* mem events can only be unregistered from the primary process */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+
+	/* cleanup all enabled configs, ignore failures */
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
+		if (vfio_cfgs[i].enabled)
+			vfio_cleanup_config(&vfio_cfgs[i]);
+	}
 }
-- 
2.52.0

