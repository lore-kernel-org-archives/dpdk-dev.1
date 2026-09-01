Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B5C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:17:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54CD940ED9;
	Tue,  1 Sep 2026 18:16:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6252940E6E
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279367; x=1819815367;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hObBtqiVl0kWCfvw1B3BdSYkFEKTEZkvVB9Il4jXUrg=;
 b=LXbdS3kLIKQ0p6Kf8LwBrxwndzhefxc8pbiSGn+lTkxwH22DMMUNnq/Q
 0L2KwP5i5ols6BFq+O9MUCOHMuaPr07HMQdEHWi82Hl8RcQwKdlVjkDNe
 saWp6mR90DwO/PbwP4+s0bsi+y7vZefabzeSGIxndC02Aje4PmMpIf5/A
 UKI35kPuLf9Tex0j1Y6gp1MhJKJQGXmlBsAVujt5csJa6cNnS51NyDnjD
 3M2l6t4NZqhBUQYPkCv3IR2ASWmFUIgn6wBR2eD7Pb5cNug+OiRS7AU73
 DPuG41I+t+Cxk2+Gwayf/A0gEQhTOqkAfGmU08SBCMqb72Rp8gBKLYaZr Q==;
X-CSE-ConnectionGUID: zhbhH+cAS4yfcHbptbhBiQ==
X-CSE-MsgGUID: MUOicy5JSb+5uCYlI1XXaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656108"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656108"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:07 -0700
X-CSE-ConnectionGUID: yd2m1Pr8SGm3m+ipOeeoXQ==
X-CSE-MsgGUID: BvBBepn9SguqTQrXo1DCbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032574"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v15 18/25] vfio: remove group-based API
Date: Tue,  1 Sep 2026 17:15:24 +0100
Message-ID: <2b7232fb4b97261086875b75a4f7f5375a4a8efe.1788278992.git.anatoly.burakov@intel.com>
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

All drivers have been adjusted to not use the VFIO group API directly and
instead rely on container device assignment model, so the group API is no
longer useful and can be removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/freebsd/eal.c            | 34 ---------------
 lib/eal/include/dev_vfio.h       | 72 --------------------------------
 lib/eal/linux/eal_vfio.c         | 47 ++++++++++-----------
 lib/eal/linux/eal_vfio.h         |  2 +
 lib/eal/linux/eal_vfio_mp_sync.c |  2 +-
 5 files changed, 26 insertions(+), 131 deletions(-)

diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index 31340bb49a..b607ea50b8 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -867,14 +867,6 @@ dev_vfio_noiommu_is_enabled(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_clear_group)
-int
-dev_vfio_clear_group(__rte_unused int vfio_group_fd)
-{
-	rte_errno = ENOTSUP;
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
 dev_vfio_get_group_num(__rte_unused const char *sysfs_base,
@@ -893,14 +885,6 @@ dev_vfio_get_container_fd(void)
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
@@ -917,24 +901,6 @@ dev_vfio_container_destroy(__rte_unused int container_fd)
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
index eb8697e75c..f2dbf46481 100644
--- a/lib/eal/include/dev_vfio.h
+++ b/lib/eal/include/dev_vfio.h
@@ -142,24 +142,6 @@ int dev_vfio_is_enabled(const char *modname);
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
@@ -224,24 +206,6 @@ __rte_internal
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
@@ -303,42 +267,6 @@ int
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
index ae53d95de5..985df228d1 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -71,6 +71,9 @@ static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
 		uint64_t iova, uint64_t len, int do_map);
 
+static int vfio_container_group_bind(int container_fd, int iommu_group_num);
+static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
+
 /* IOMMU types we support */
 static const struct vfio_iommu_type iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
@@ -536,9 +539,8 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-dev_vfio_get_group_fd(int iommu_group_num)
+vfio_get_group_fd_by_num(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -740,9 +742,8 @@ vfio_sync_default_container(void)
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
@@ -806,7 +807,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -832,14 +833,14 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
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
 
@@ -860,7 +861,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -884,7 +885,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -901,7 +902,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -970,7 +971,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -1007,7 +1008,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr,
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		dev_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1050,9 +1051,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
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
@@ -1088,7 +1089,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (dev_vfio_clear_group(vfio_group_fd) < 0) {
+		if (vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -2149,7 +2150,7 @@ dev_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			dev_vfio_container_group_unbind(container_fd,
+			vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2181,7 +2182,7 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 		return -1;
 	}
 
-	ret = dev_vfio_container_group_bind(vfio_container_fd,
+	ret = vfio_container_group_bind(vfio_container_fd,
 			iommu_group_num);
 	if (ret < 0) {
 		EAL_LOG(ERR,
@@ -2193,9 +2194,8 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
-int
-dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
+static int
+vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2213,9 +2213,8 @@ dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
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

