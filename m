Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC24C98318
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 16:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6967043254;
	Thu, 24 Sep 2026 18:13:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id BD32043005
 for <dev@dpdk.org>; Thu, 24 Sep 2026 18:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790266434; x=1821802434;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HmEPDt5q9rOpn6QydzjAs2FWt6dj7RXw/aqMgLsORrY=;
 b=OwVGjuG6pyfgwcFWyCaR3CEAjLszcTG1hULhy33hO4/MuEXrWtrh3641
 o9c5SbmUWIP7oykIu6NT251yz5UYQDz8fD+w57XpaZpBgMrqjpnmeUy7v
 HuOvCH0vwfJKyD/GxnaO0Ue66rnHDHZebsdKBjSrMT3zLevMV5V2wxEeI
 wiSWAk5IA+1Hx0fZHthp/2UKvKyY+sZ/kynmWSAXsKeFpG+MfMriDpLYL
 kY6MIKjYn5r2OS+otOrIMssk5Jl3Zxw2CSrbcMN+dt4qsUvvhiPhVBYH0
 wC7MnSgBUmBTZO7iMgjeXfTUY9aAMPmanU63uuz7LzC81/N6UUYuB9qO6 w==;
X-CSE-ConnectionGUID: PqaG7AalSluQHT4Bh454hg==
X-CSE-MsgGUID: YcXyahWeQ/OZKILPoSkPWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90000628"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90000628"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 09:13:53 -0700
X-CSE-ConnectionGUID: oaLKvIoHSAO0oxiUuLstjg==
X-CSE-MsgGUID: M6BERo68SeuTX2hAHFOzzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277829988"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 09:13:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v18 06/29] vfio: do proper teardown on VFIO cleanup
Date: Thu, 24 Sep 2026 17:13:13 +0100
Message-ID: <e3406f77f337822f918cc86ddfb479726a475e2f.1790266166.git.anatoly.burakov@intel.com>
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

Currently, VFIO cleanup only unregisters multiprocess callback, but does
not destroy containers, groups, and user mem maps. Do all of that on VFIO
cleanup. We don't actually need a per-config enabled flag, as container fd
should be enough to determine whether the config is active.

While we're at it, also harden the API against repeated
initialization and attempts at using the API without having VFIO
initialized.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio.c | 154 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 5 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 6c77076bc3e..8959a161530 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -46,7 +46,6 @@ struct user_mem_maps {
 };
 
 struct vfio_config {
-	int vfio_enabled;
 	int vfio_container_fd;
 	int vfio_active_groups;
 	const struct vfio_iommu_type *vfio_iommu_type;
@@ -58,6 +57,9 @@ struct vfio_config {
 static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
 static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 
+/* whether VFIO is enabled (usable) in this process */
+static bool vfio_enabled;
+
 static int vfio_type1_dma_map(int);
 static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_spapr_dma_map(int);
@@ -538,6 +540,11 @@ rte_vfio_get_group_fd(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	/* get the vfio_config it belongs to */
 	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
 	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
@@ -686,7 +693,7 @@ vfio_sync_default_container(void)
 		return -1;
 
 	/* default container fd should have been opened in rte_vfio_enable() */
-	if (!default_vfio_cfg->vfio_enabled ||
+	if (!vfio_enabled ||
 			default_vfio_cfg->vfio_container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
 		return -1;
@@ -738,6 +745,11 @@ rte_vfio_clear_group(int vfio_group_fd)
 	int i;
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
@@ -773,6 +785,11 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	/* get group number */
 	ret = rte_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
 	if (ret == 0) {
@@ -1019,6 +1036,11 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	int iommu_group_num;
 	int ret;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	/* we don't want any DMA mapping messages to come while we're detaching
 	 * VFIO device, because this might be the last device and we might need
 	 * to unregister the callback.
@@ -1111,6 +1133,9 @@ rte_vfio_enable(const char *modname)
 
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
+	if (vfio_enabled)
+		return 0;
+
 	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfgs[i].vfio_container_fd = -1;
 		vfio_cfgs[i].vfio_active_groups = 0;
@@ -1167,7 +1192,7 @@ rte_vfio_enable(const char *modname)
 	/* check if we have VFIO driver enabled */
 	if (default_vfio_cfg->vfio_container_fd != -1) {
 		EAL_LOG(INFO, "VFIO support initialized");
-		default_vfio_cfg->vfio_enabled = 1;
+		vfio_enabled = true;
 	} else {
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
 	}
@@ -1180,12 +1205,15 @@ int
 rte_vfio_is_enabled(const char *modname)
 {
 	const int mod_available = rte_eal_check_module(modname) > 0;
-	return default_vfio_cfg->vfio_enabled && mod_available;
+	return vfio_enabled && mod_available;
 }
 
 int
 vfio_get_iommu_type(void)
 {
+	if (!vfio_enabled)
+		return -1;
+
 	if (default_vfio_cfg->vfio_iommu_type == NULL)
 		return -1;
 
@@ -1222,6 +1250,11 @@ rte_vfio_get_device_info(const char *sysfs_base, const char *dev_addr,
 {
 	int ret;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	if (device_info == NULL || *vfio_dev_fd < 0)
 		return -1;
 
@@ -1357,7 +1390,7 @@ rte_vfio_get_container_fd(void)
 	 * The default container is set up during rte_vfio_enable().
 	 * This function does not create a new container.
 	 */
-	if (!default_vfio_cfg->vfio_enabled)
+	if (!vfio_enabled)
 		return -1;
 
 	return default_vfio_cfg->vfio_container_fd;
@@ -1373,6 +1406,11 @@ rte_vfio_get_group_num(const char *sysfs_base,
 	char *tok[16], *group_tok, *end;
 	int ret;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	memset(linkname, 0, sizeof(linkname));
 	memset(filename, 0, sizeof(filename));
 
@@ -2073,6 +2111,11 @@ rte_vfio_container_create(void)
 {
 	unsigned int i;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	/* Find an empty slot to store new vfio config */
 	for (i = 1; i < RTE_DIM(vfio_cfgs); i++) {
 		if (vfio_cfgs[i].vfio_container_fd == -1)
@@ -2101,6 +2144,16 @@ rte_vfio_container_destroy(int container_fd)
 	struct vfio_config *vfio_cfg;
 	unsigned int i;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
+	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD) {
+		EAL_LOG(ERR, "Cannot destroy default VFIO container");
+		return -1;
+	}
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2126,6 +2179,11 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2143,6 +2201,11 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	struct vfio_config *vfio_cfg;
 	unsigned int i;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
@@ -2183,6 +2246,11 @@ rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
@@ -2204,6 +2272,11 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 {
 	struct vfio_config *vfio_cfg;
 
+	if (!vfio_enabled) {
+		rte_errno = ENODEV;
+		return -1;
+	}
+
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
@@ -2218,9 +2291,80 @@ rte_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
 }
 
+static int
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
+			continue;
+		}
+		if (group->fd >= 0 && close(group->fd) < 0) {
+			EAL_LOG(ERR, "Cannot close VFIO group %d: %s",
+				group->group_num, strerror(errno));
+			continue;
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
+		return -1;
+	}
+
+	if (vfio_cfg->vfio_container_fd >= 0 &&
+			close(vfio_cfg->vfio_container_fd) < 0) {
+		EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
+		return -1;
+	}
+
+	vfio_cfg->vfio_container_fd = -1;
+	vfio_cfg->vfio_iommu_type = NULL;
+
+	vfio_cfg->mem_maps.n_maps = 0;
+	memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
+
+	return 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_cleanup)
 void
 rte_vfio_cleanup(void)
 {
+	unsigned int i;
+	bool stuck = false;
+
+	if (!vfio_enabled)
+		return;
+
 	vfio_mp_sync_cleanup();
+
+	/* mem events can only be unregistered from the primary process */
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+
+	/* cleanup all initialized configs */
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
+		if (vfio_cfgs[i].vfio_container_fd != -1)
+			stuck |= vfio_cleanup_config(&vfio_cfgs[i]) != 0;
+	}
+
+	/* failed to deinitialize some configs, so don't set VFIO as disabled */
+	if (stuck)
+		return;
+
+	vfio_enabled = false;
 }
-- 
2.52.0

