Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE5CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63FBF427BE;
	Fri, 14 Nov 2025 18:41:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 9103F427B1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:41:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142060; x=1794678060;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=GgtPaDehiGy3OtT63mbcAeLD8035w+YJ8k7tIPFMX4w=;
 b=jDSo22ksEzhFICuB1S/WwVDr+JoPRJFWNv6PMAnibHrjn6SCJpoyNPkC
 ceCvBvp0mEwsj3WaEiXIM9t/YWVFIIdjWVilnL90AunFXyfAlsZr0ot/Q
 RMg9ndPAWKSjmLrmc1Kdg6PcqWpe0DM/yDwkToRaaBMBWGNO5db6W5l0u
 7GGo3SHmEywBDOjW1x5TbjrfrJUath/OgrG0H5i8kzn+3x+J30UWMAEqm
 ZFnsl1ynodmv6uQySghbQtavQbeqyfrZ979G5D7+AfoPaVuvcqFLsDmoD
 xOZIXZuinG045HB0jRuGvzkTQvf8Z0Xwy9wA3aKM4FyIBXi6eDG9ilCFl A==;
X-CSE-ConnectionGUID: 7o7HmaQeTsyhh70SWTVZow==
X-CSE-MsgGUID: ubqtCC0hT4CUzoLOWvOlVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864317"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864317"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:41:00 -0800
X-CSE-ConnectionGUID: iuJCah0eReKbP7rBg44oSg==
X-CSE-MsgGUID: aIgHqa1sSAObYHn2zNvo4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650844"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v2 18/19] vfio: remove group API functions
Date: Fri, 14 Nov 2025 17:40:28 +0000
Message-ID: <78c7d385b5ca38f077852dde8a40e7c7ca7e3625.1763142008.git.anatoly.burakov@intel.com>
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

These functions are not used by anything in DPDK, and they are built around
group API which is no longer the only VFIO API available. Remove these
functions to reduce API surface.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c      |  39 --------
 lib/eal/include/rte_vfio.h | 110 ----------------------
 lib/eal/linux/eal_vfio.c   | 185 -------------------------------------
 3 files changed, 334 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index efdb9dd369..efca7f8463 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -842,19 +842,6 @@ int rte_vfio_is_enabled(__rte_unused const char *modname)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_noiommu_is_enabled)
-int rte_vfio_noiommu_is_enabled(void)
-{
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
-int rte_vfio_clear_group(__rte_unused int vfio_group_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_num)
 int
 rte_vfio_get_group_num(__rte_unused const char *sysfs_base,
@@ -873,14 +860,6 @@ rte_vfio_get_container_fd(void)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
-int
-rte_vfio_get_group_fd(__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
@@ -897,24 +876,6 @@ rte_vfio_container_destroy(__rte_unused int container_fd)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
-int
-rte_vfio_container_group_bind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
-int
-rte_vfio_container_group_unbind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(__rte_unused int container_fd,
diff --git a/lib/eal/include/rte_vfio.h b/lib/eal/include/rte_vfio.h
index bfa59094fe..b8830cef20 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -170,42 +170,6 @@ __rte_internal
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
-/**
- * @internal
- * Remove group fd from internal VFIO tracking.
- *
- * This function is only relevant on Linux in group mode.
- *
- * @param vfio_group_fd
- *   VFIO group fd.
- *
- * @return
- *   0 on success.
- *   <0 on failure, rte_errno is set.
- *
- * Possible rte_errno values include:
- * - ENOENT  - Group not found.
- * - ENXIO   - VFIO support not initialized.
- * - ENOTSUP - Unsupported VFIO mode.
- */
-__rte_internal
-int
-rte_vfio_clear_group(int vfio_group_fd);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
@@ -279,28 +243,6 @@ __rte_internal
 int
 rte_vfio_get_container_fd(void);
 
-/**
- * @internal
- * Return file descriptor for an open VFIO group.
- *
- * This function is only relevant on Linux in group mode.
- *
- * @param iommu_group_num
- *   IOMMU group number.
- *
- * @return
- *   Non-negative group file descriptor on success.
- *   <0 on failure, rte_errno is set.
- *
- * Possible rte_errno values include:
- * - ENOENT  - Group not found.
- * - ENXIO   - VFIO support not initialized.
- * - ENOTSUP - Unsupported VFIO mode.
- */
-__rte_internal
-int
-rte_vfio_get_group_fd(int iommu_group_num);
-
 /**
  * @internal
  * Create a new VFIO container for device assignment and DMA mapping.
@@ -387,58 +329,6 @@ int
 rte_vfio_container_assign_device(int vfio_container_fd,
 		const char *sysfs_base, const char *dev_addr);
 
-/**
- * @internal
- * Bind an IOMMU group to a container.
- *
- * This function is only relevant on Linux in group mode.
- *
- * @param container_fd
- *   Container file descriptor.
- * @param iommu_group_num
- *   IOMMU group number to bind to container.
- *
- * @return
- *   0 on success.
- *   <0 on failure, rte_errno is set.
- *
- * Possible rte_errno values include:
- * - ENODEV  - IOMMU group not managed by VFIO.
- * - ENOSPC  - No space in VFIO container to track the group.
- * - EINVAL  - Invalid container file descriptor.
- * - ENXIO   - VFIO support not initialized.
- * - ENOTSUP - Unsupported VFIO mode.
- */
-__rte_internal
-int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
-
-/**
- * @internal
- * Unbind an IOMMU group from a container.
- *
- * This function is only relevant on Linux in group mode.
- *
- * @param container_fd
- *   Container file descriptor.
- * @param iommu_group_num
- *   IOMMU group number to unbind from container.
- *
- * @return
- *   0 on success.
- *   <0 on failure, rte_errno is set.
- *
- * Possible rte_errno values include:
- * - ENOENT  - VFIO group not found in container.
- * - ENODEV  - Container not managed by VFIO.
- * - EINVAL  - Invalid container file descriptor.
- * - ENXIO   - VFIO support not initialized.
- * - ENOTSUP - Unsupported VFIO mode.
- */
-__rte_internal
-int
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
-
 /**
  * @internal
  * Perform DMA mapping for devices in a container.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 7d5edc7865..4479945683 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -429,37 +429,6 @@ vfio_device_erase(struct container *cfg, struct vfio_device *dev)
 	cfg->n_devices--;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
-int
-rte_vfio_get_group_fd(int iommu_group_num)
-{
-	struct container *cfg;
-	struct vfio_group *grp;
-
-	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
-		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENXIO;
-		return -1;
-	}
-	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
-			vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
-		EAL_LOG(ERR, "VFIO not initialized in group mode");
-		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	CONTAINER_FOREACH_ACTIVE(cfg) {
-		GROUP_FOREACH_ACTIVE(cfg, grp)
-			if (grp->group_num == iommu_group_num)
-				return grp->fd;
-	}
-
-	/* group doesn't exist */
-	EAL_LOG(ERR, "IOMMU group %d not bound to any VFIO container", iommu_group_num);
-	rte_errno = ENOENT;
-	return -1;
-}
-
 static void
 vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 		void *arg __rte_unused)
@@ -508,48 +477,6 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
-int
-rte_vfio_clear_group(int vfio_group_fd)
-{
-	struct container *cfg;
-	struct vfio_group *grp;
-	struct vfio_device *dev;
-
-	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
-		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENXIO;
-		return -1;
-	}
-
-	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP &&
-			vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
-		EAL_LOG(ERR, "VFIO not initialized in group mode");
-		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	/* find our group */
-	CONTAINER_FOREACH_ACTIVE(cfg) {
-		GROUP_FOREACH_ACTIVE(cfg, grp) {
-			if (grp->fd != vfio_group_fd)
-				continue;
-			/* clear out all devices within this group */
-			DEVICE_FOREACH_ACTIVE(cfg, dev) {
-				if (dev->group != grp->group_num)
-					continue;
-				vfio_device_erase(cfg, dev);
-			}
-			/* clear out group itself */
-			vfio_group_erase(cfg, grp);
-			return 0;
-		}
-	}
-
-	rte_errno = ENOENT;
-	return -1;
-}
-
 static int
 vfio_register_mem_event_callback(void)
 {
@@ -1385,13 +1312,6 @@ container_dma_unmap(struct container *cfg, uint64_t vaddr, uint64_t iova,
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
@@ -1494,111 +1414,6 @@ rte_vfio_container_destroy(int container_fd)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
-int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
-{
-	struct container *cfg;
-	struct vfio_group *grp;
-	int ret;
-
-	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
-		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENXIO;
-		return -1;
-	}
-	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP && vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
-		EAL_LOG(ERR, "VFIO not initialized in group mode");
-		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	cfg = vfio_container_get_by_fd(container_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
-		rte_errno = EINVAL;
-		return -1;
-	}
-
-	/* does the group already exist and already bound? */
-	grp = vfio_group_get_by_num(cfg, iommu_group_num);
-	if (grp != NULL)
-		return 0;
-
-	/* group doesn't exist, create it */
-	grp = vfio_group_create(cfg, iommu_group_num);
-	if (grp == NULL) {
-		EAL_LOG(ERR, "Failed to bind VFIO group %d", iommu_group_num);
-		rte_errno = ENOSPC;
-		return -1;
-	}
-
-	/* group created, now open fd */
-	ret = vfio_group_open_fd(cfg, grp);
-	if (ret == -ENOENT) {
-		EAL_LOG(ERR, "IOMMU group %d not managed by VFIO", iommu_group_num);
-		vfio_group_erase(cfg, grp);
-		rte_errno = ENODEV;
-		return -1;
-	} else if (ret < 0) {
-		EAL_LOG(ERR, "Cannot open VFIO group %d", iommu_group_num);
-		rte_errno = errno;
-		vfio_group_erase(cfg, grp);
-		return -1;
-	}
-
-	/* we're done */
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
-int
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
-{
-	struct container *cfg;
-	struct vfio_group *grp;
-	struct vfio_device *dev;
-
-	if (vfio_cfg.mode == RTE_VFIO_MODE_NONE) {
-		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENODEV;
-		return -1;
-	}
-
-	if (vfio_cfg.mode != RTE_VFIO_MODE_GROUP && vfio_cfg.mode != RTE_VFIO_MODE_NOIOMMU) {
-		EAL_LOG(ERR, "VFIO not initialized in group mode");
-		rte_errno = ENOTSUP;
-		return -1;
-	}
-
-	/* find container */
-	cfg = vfio_container_get_by_fd(container_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
-		rte_errno = EINVAL;
-		return -1;
-	}
-
-	/* find the group */
-	grp = vfio_group_get_by_num(cfg, iommu_group_num);
-	if (grp == NULL) {
-		EAL_LOG(ERR, "VFIO group %d not found in container", iommu_group_num);
-		rte_errno = ENOENT;
-		return -1;
-	}
-
-	/* remove all devices from this group */
-	DEVICE_FOREACH_ACTIVE(cfg, dev) {
-		if (dev->group != grp->group_num)
-			continue;
-		vfio_device_erase(cfg, dev);
-	}
-
-	vfio_group_erase(cfg, grp);
-
-	return 0;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_dma_map)
 int
 rte_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova, uint64_t len)
-- 
2.47.3

