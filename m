Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928F9C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:16:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B40F40DD1;
	Thu, 27 Aug 2026 17:15:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B6C6B40DC9
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843712; x=1819379712;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4s+24Jiy8OMsiklsA/UyzmLLDwuSeeoBIDAXjSBQAGE=;
 b=Nih2zyM+j2ejQepkBgMxbv4UkKyKEpkfUVkrIM2MlShV+FXHx3GIlHNq
 EphzqfvLBSXhhXIUM5+wWWt/WO3Bxdp3gGIF2I9wClZkxmVcELvLcgc1l
 MK6LZ8zbXXymHDGHRWIqmo+E6X3D+8XhahK1GfddWjwBp/OGfSAxICf7e
 WLHyUfbC5961E9drQDivpL4wZyZJ50mrE1ebSWL3RiOIHHGeLW+C5/edk
 mSai8S54Orzyuyj9Qh/2999Lfn67A5nLWEvLrly0LUeHy4pmoVLlEqLu1
 AZqZadiAVfofeNVKJjyOKwgIzKKNyno2FNGz2eAJVXdx3tLLpPcYgr9in Q==;
X-CSE-ConnectionGUID: mWh9UBcjRpK8cWE9qZENaQ==
X-CSE-MsgGUID: px4o1GicSYGI5Uecxmh6jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371644"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371644"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:11 -0700
X-CSE-ConnectionGUID: 7SikXTkkQOe8tw8jw1Hf+A==
X-CSE-MsgGUID: KfPlUuY/Q96wDchTf2KBRA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v13 17/24] vfio: remove group-based API
Date: Thu, 27 Aug 2026 16:14:20 +0100
Message-ID: <1049f3f141beac68a7fdb7e80cc1b4042a692b91.1787843386.git.anatoly.burakov@intel.com>
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

All drivers have been adjusted to not use the VFIO group API directly and
instead rely on container device assignment model, so the group API is no
longer useful and can be removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c            | 33 ---------------
 lib/eal/include/dev_vfio.h       | 72 --------------------------------
 lib/eal/linux/eal_vfio.c         | 47 ++++++++++-----------
 lib/eal/linux/eal_vfio.h         |  2 +
 lib/eal/linux/eal_vfio_mp_sync.c |  2 +-
 5 files changed, 26 insertions(+), 130 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 0650abf406..44b5e820fe 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -862,13 +862,6 @@ int dev_vfio_noiommu_is_enabled(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_clear_group)
-int dev_vfio_clear_group(__rte_unused int vfio_group_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
 dev_vfio_get_group_num(__rte_unused const char *sysfs_base,
@@ -887,14 +880,6 @@ dev_vfio_get_container_fd(void)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
-int
-dev_vfio_get_group_fd(__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
@@ -911,24 +896,6 @@ dev_vfio_container_destroy(__rte_unused int container_fd)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
-int
-dev_vfio_container_group_bind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_unbind)
-int
-dev_vfio_container_group_unbind(__rte_unused int container_fd,
-		__rte_unused int iommu_group_num)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_map)
 int
 dev_vfio_container_dma_map(__rte_unused int container_fd,
diff --git a/lib/eal/include/dev_vfio.h b/lib/eal/include/dev_vfio.h
index 85b4dbd3fc..98b7d7b442 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -145,24 +145,6 @@ int dev_vfio_is_enabled(const char *modname);
 __rte_internal
 int dev_vfio_noiommu_is_enabled(void);
 
-/**
- * @internal
- * Remove group fd from internal VFIO group fd array.
- *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
- * @param vfio_group_fd
- *   VFIO Group FD.
- *
- * @return
- *   0 on success.
- *   <0 on failure.
- */
-__rte_internal
-int
-dev_vfio_clear_group(int vfio_group_fd);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
@@ -227,24 +209,6 @@ __rte_internal
 int
 dev_vfio_get_container_fd(void);
 
-/**
- * @internal
- * Open VFIO group fd or get an existing one.
- *
- * This function is only relevant to linux and will return
- * an error on BSD.
- *
- * @param iommu_group_num
- *   iommu group number
- *
- * @return
- *  > 0 group fd
- *  < 0 for errors
- */
-__rte_internal
-int
-dev_vfio_get_group_fd(int iommu_group_num);
-
 /**
  * @internal
  * Create a new container for device binding.
@@ -306,42 +270,6 @@ int
 dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 		const char *dev_addr);
 
-/**
- * @internal
- * Bind a IOMMU group to a container.
- *
- * @param container_fd
- *   the container's fd
- *
- * @param iommu_group_num
- *   the iommu group number to bind to container
- *
- * @return
- *   group fd if successful
- *   <0 if failed
- */
-__rte_internal
-int
-dev_vfio_container_group_bind(int container_fd, int iommu_group_num);
-
-/**
- * @internal
- * Unbind a IOMMU group from a container.
- *
- * @param container_fd
- *   the container fd of container
- *
- * @param iommu_group_num
- *   the iommu group number to delete from container
- *
- * @return
- *    0 if successful
- *   <0 if failed
- */
-__rte_internal
-int
-dev_vfio_container_group_unbind(int container_fd, int iommu_group_num);
-
 /**
  * @internal
  * Perform DMA mapping for devices in a container.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 29c03d01b4..345558f43a 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -70,6 +70,9 @@ static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
 		uint64_t iova, uint64_t len, int do_map);
 
+static int vfio_container_group_bind(int container_fd, int iommu_group_num);
+static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
+
 /* IOMMU types we support */
 static const struct vfio_iommu_type iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
@@ -535,9 +538,8 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-dev_vfio_get_group_fd(int iommu_group_num)
+vfio_get_group_fd_by_num(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -734,9 +736,8 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_clear_group)
-int
-dev_vfio_clear_group(int vfio_group_fd)
+static int
+vfio_clear_group(int vfio_group_fd)
 {
 	int i;
 	struct vfio_config *vfio_cfg;
@@ -790,7 +791,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -816,14 +817,14 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(ERR, "%s cannot get VFIO group status, "
 			"error %i (%s)", dev_addr, errno, strerror(errno));
 		close(vfio_group_fd);
-		dev_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
 		EAL_LOG(ERR, "%s VFIO group is not viable! "
 			"Not all devices in IOMMU group bound to VFIO or unbound",
 			dev_addr);
 		close(vfio_group_fd);
-		dev_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -844,7 +845,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -868,7 +869,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -885,7 +886,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -954,7 +955,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -991,7 +992,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		dev_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1029,9 +1030,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get the actual group fd */
-	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "dev_vfio_get_group_fd failed for %s",
+		EAL_LOG(INFO, "vfio_get_group_fd_by_num failed for %s",
 				   dev_addr);
 		ret = vfio_group_fd;
 		goto out;
@@ -1067,7 +1068,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (dev_vfio_clear_group(vfio_group_fd) < 0) {
+		if (vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -2097,7 +2098,7 @@ dev_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			dev_vfio_container_group_unbind(container_fd,
+			vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2129,7 +2130,7 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 		return -1;
 	}
 
-	ret = dev_vfio_container_group_bind(vfio_container_fd,
+	ret = vfio_container_group_bind(vfio_container_fd,
 			iommu_group_num);
 	if (ret < 0) {
 		EAL_LOG(ERR,
@@ -2141,9 +2142,8 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
-int
-dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
+static int
+vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2156,9 +2156,8 @@ dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_unbind)
-int
-dev_vfio_container_group_unbind(int container_fd, int iommu_group_num)
+static int
+vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
 	struct vfio_group *cur_grp = NULL;
 	struct vfio_config *vfio_cfg;
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 89c4b5ba45..30389fb274 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -51,6 +51,8 @@ vfio_set_iommu_type(int vfio_container_fd);
 int
 vfio_get_iommu_type(void);
 
+int vfio_get_group_fd_by_num(int iommu_group_num);
+
 /* check if we have any supported extensions */
 int
 vfio_has_supported_extensions(int vfio_container_fd);
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index ae1c8b40b9..66341a701a 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -34,7 +34,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	case SOCKET_REQ_GROUP:
 		r->req = SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
-		fd = dev_vfio_get_group_fd(m->group_num);
+		fd = vfio_get_group_fd_by_num(m->group_num);
 		if (fd < 0 && fd != -ENOENT)
 			r->result = SOCKET_ERR;
 		else if (fd == -ENOENT)
-- 
2.52.0

