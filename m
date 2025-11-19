Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA8CF319B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F33C40B99;
	Wed, 19 Nov 2025 12:08:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D242240A6B
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550519; x=1795086519;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=u2IwLXFug4dgtck4bjRxL7SYVMcWF6XoufyDBohW02A=;
 b=bQSoqxPFKRUbJee7ssDMvIKScb2MNiCG0CCLdlZT8QoZ/7FqnDIRNr7S
 8Bugl2/4NQ1wy7ZUv2r22CFnOXQjUBbtDijbfokywIqawKW2xwdnsEuk2
 RD5Obbm3vBk0/fpCTjYViHNGStc8djWuectCZMqJTk9yJZOo9HyrcsSMO
 iQtEUZk9FPhR4ssieQUKRe2iJCvtV5LsgPyatGr5qnWycppartze/AFhs
 LwpHFzBj9AdEzRhBBKZkCdIdopwBxdc6URVfbYmzTCVdI88gha6oLlIER
 ddZiMGw4rmUKbMVwGhV2bqSyr2cFQ6usuy9YmNNYBJe6aOajF3HVICxRN w==;
X-CSE-ConnectionGUID: H5058bsnRAeBs7csz6S8pg==
X-CSE-MsgGUID: x+HQnabLTVe6R377JznlsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744972"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744972"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:38 -0800
X-CSE-ConnectionGUID: rdfMjxDeTzmnOTNa302ycQ==
X-CSE-MsgGUID: FJOHpZVyTUuYIfjLJ1F0Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158209"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 11/18] vfio: remove group-based API
Date: Wed, 19 Nov 2025 11:08:09 +0000
Message-ID: <d121d52ca65299d1f97e2806ff4751f65acef062.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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
 lib/eal/include/rte_vfio.h       | 72 --------------------------------
 lib/eal/linux/eal_vfio.c         | 47 ++++++++++-----------
 lib/eal/linux/eal_vfio.h         |  2 +
 lib/eal/linux/eal_vfio_mp_sync.c |  2 +-
 5 files changed, 26 insertions(+), 130 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index a7360db7a7..f66ac01ba2 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -848,13 +848,6 @@ int rte_vfio_noiommu_is_enabled(void)
 	return 0;
 }
 
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
@@ -873,14 +866,6 @@ rte_vfio_get_container_fd(void)
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
@@ -897,24 +882,6 @@ rte_vfio_container_destroy(__rte_unused int container_fd)
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
index e7e2ee950b..941b7d0541 100644
--- a/lib/eal/include/rte_vfio.h
+++ b/lib/eal/include/rte_vfio.h
@@ -136,24 +136,6 @@ int rte_vfio_is_enabled(const char *modname);
 __rte_internal
 int rte_vfio_noiommu_is_enabled(void);
 
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
-rte_vfio_clear_group(int vfio_group_fd);
-
 /**
  * @internal
  * Parse IOMMU group number for a device.
@@ -218,24 +200,6 @@ __rte_internal
 int
 rte_vfio_get_container_fd(void);
 
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
-rte_vfio_get_group_fd(int iommu_group_num);
-
 /**
  * @internal
  * Create a new container for device binding.
@@ -297,42 +261,6 @@ int
 rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
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
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num);
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
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num);
-
 /**
  * @internal
  * Perform DMA mapping for devices in a container.
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 02fec64658..7893d334eb 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -67,6 +67,9 @@ static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
 		uint64_t iova, uint64_t len, int do_map);
 
+static int vfio_container_group_bind(int container_fd, int iommu_group_num);
+static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
+
 /* IOMMU types we support */
 static const struct vfio_iommu_type iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
@@ -532,9 +535,8 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_get_group_fd)
 int
-rte_vfio_get_group_fd(int iommu_group_num)
+vfio_get_group_fd_by_num(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -731,9 +733,8 @@ vfio_sync_default_container(void)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_clear_group)
-int
-rte_vfio_clear_group(int vfio_group_fd)
+static int
+vfio_clear_group(int vfio_group_fd)
 {
 	int i;
 	struct vfio_config *vfio_cfg;
@@ -787,7 +788,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -813,14 +814,14 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(ERR, "%s cannot get VFIO group status, "
 			"error %i (%s)", dev_addr, errno, strerror(errno));
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
 		EAL_LOG(ERR, "%s VFIO group is not viable! "
 			"Not all devices in IOMMU group bound to VFIO or unbound",
 			dev_addr);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -841,7 +842,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -865,7 +866,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -882,7 +883,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				rte_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -951,7 +952,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			rte_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -988,7 +989,7 @@ rte_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		rte_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1026,9 +1027,9 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get the actual group fd */
-	vfio_group_fd = rte_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "rte_vfio_get_group_fd failed for %s",
+		EAL_LOG(INFO, "vfio_get_group_fd_by_num failed for %s",
 				   dev_addr);
 		ret = vfio_group_fd;
 		goto out;
@@ -1064,7 +1065,7 @@ rte_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (rte_vfio_clear_group(vfio_group_fd) < 0) {
+		if (vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -2091,7 +2092,7 @@ rte_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			rte_vfio_container_group_unbind(container_fd,
+			vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2122,7 +2123,7 @@ rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 		return -1;
 	}
 
-	ret = rte_vfio_container_group_bind(vfio_container_fd,
+	ret = vfio_container_group_bind(vfio_container_fd,
 			iommu_group_num);
 	if (ret < 0) {
 		EAL_LOG(ERR,
@@ -2134,9 +2135,8 @@ rte_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_bind)
-int
-rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
+static int
+vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2149,9 +2149,8 @@ rte_vfio_container_group_bind(int container_fd, int iommu_group_num)
 	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vfio_container_group_unbind)
-int
-rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
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
index 22136f2e8b..3eaeef2fc8 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -34,7 +34,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	case SOCKET_REQ_GROUP:
 		r->req = SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
-		fd = rte_vfio_get_group_fd(m->group_num);
+		fd = vfio_get_group_fd_by_num(m->group_num);
 		if (fd < 0 && fd != -ENOENT)
 			r->result = SOCKET_ERR;
 		else if (fd == -ENOENT)
-- 
2.47.3

