Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BD6CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D37FB42EB9;
	Wed,  7 Oct 2026 10:11:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8EFAE42E87
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWHAeCRuhFric/SUuroHNxJiNStVyWCS3gNkVsp7988=;
 b=M+jZ1yXX6DkGLa67dEoy2JkQTc8pfUnkvI52Xgz9uWMnbvDO2sHKzhCVAPxK/naV3qsVKk
 M48Yu/aSTF7t3X/IQVO6T5/W3tOCMlsd5xY8BCgYM6SC/281C8vDc2TIOxhlHlKWXzprww
 3bHL1i01vY3k5bR3D5OiEnePw8o9HIs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-RNREmpjPN5WddzS-yDQnhg-1; Wed,
 07 Oct 2026 04:11:37 -0400
X-MC-Unique: RNREmpjPN5WddzS-yDQnhg-1
X-Mimecast-MFC-AGG-ID: RNREmpjPN5WddzS-yDQnhg_1791360697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01A7718009DA; Wed,  7 Oct 2026 08:11:37 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33F4930000E6; Wed,  7 Oct 2026 08:11:36 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 17/26] vfio: remove group-based API
Date: Wed,  7 Oct 2026 10:10:14 +0200
Message-ID: <20261007081026.574382-18-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BBpeKDY8asQmDB-ubjOk2_BMG_C6-ycrTezjKEb_vqY_1791360697
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

All drivers have been adjusted to not use the VFIO group API directly and
instead rely on container device assignment model, so the group API is no
longer useful and can be removed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/linux/eal_vfio.c         | 48 +++++++++++------------
 lib/eal/linux/eal_vfio.h         |  2 +
 lib/eal/linux/eal_vfio_mp_sync.c |  2 +-
 lib/eal/linux/include/dev_vfio.h | 66 --------------------------------
 4 files changed, 26 insertions(+), 92 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index d6a6e2d30a..144920d1d0 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -114,6 +114,9 @@ static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
 static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
 		uint64_t iova, uint64_t len, int do_map);
 
+static int vfio_container_group_bind(int container_fd, int iommu_group_num);
+static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
+
 /* IOMMU types we support */
 static const struct vfio_iommu_type iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
@@ -579,9 +582,8 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_fd)
 int
-dev_vfio_get_group_fd(int iommu_group_num)
+vfio_get_group_fd_by_num(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -781,9 +783,8 @@ vfio_sync_default_container(void)
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
@@ -842,7 +843,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		return -1;
 
 	/* get the actual group fd */
-	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
 		return -1;
 
@@ -868,14 +869,14 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
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
 
@@ -896,7 +897,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 				"%s cannot add VFIO group to container, error "
 				"%i (%s)", dev_addr, errno, strerror(errno));
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 
@@ -920,7 +921,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 					"%s failed to select IOMMU type",
 					dev_addr);
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				return -1;
 			}
 			/* lock memory hotplug before mapping and release it
@@ -937,7 +938,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 					"%i (%s)",
 					dev_addr, errno, strerror(errno));
 				close(vfio_group_fd);
-				dev_vfio_clear_group(vfio_group_fd);
+				vfio_clear_group(vfio_group_fd);
 				rte_mcfg_mem_read_unlock();
 				return -1;
 			}
@@ -1006,7 +1007,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		if (ret < 0) {
 			EAL_LOG(ERR, "Could not sync default VFIO container");
 			close(vfio_group_fd);
-			dev_vfio_clear_group(vfio_group_fd);
+			vfio_clear_group(vfio_group_fd);
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
@@ -1043,7 +1044,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
 				dev_addr);
 		close(vfio_group_fd);
-		dev_vfio_clear_group(vfio_group_fd);
+		vfio_clear_group(vfio_group_fd);
 		return -1;
 	}
 
@@ -1084,10 +1085,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	}
 
 	/* get the actual group fd */
-	vfio_group_fd = dev_vfio_get_group_fd(iommu_group_num);
+	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
 	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "dev_vfio_get_group_fd failed for %s",
-				   dev_addr);
+		EAL_LOG(INFO, "vfio_get_group_fd_by_num failed for %s", dev_addr);
 		ret = vfio_group_fd;
 		goto out;
 	}
@@ -1122,7 +1122,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 			goto out;
 		}
 
-		if (dev_vfio_clear_group(vfio_group_fd) < 0) {
+		if (vfio_clear_group(vfio_group_fd) < 0) {
 			EAL_LOG(INFO, "Error when clearing group for %s",
 					   dev_addr);
 			ret = -1;
@@ -2177,7 +2177,7 @@ dev_vfio_container_destroy(int container_fd)
 
 	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
-			dev_vfio_container_group_unbind(container_fd,
+			vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
@@ -2205,7 +2205,7 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 		return -1;
 	}
 
-	ret = dev_vfio_container_group_bind(vfio_container_fd, iommu_group_num);
+	ret = vfio_container_group_bind(vfio_container_fd, iommu_group_num);
 	if (ret < 0) {
 		EAL_LOG(ERR, "Cannot bind IOMMU group %d for device %s", iommu_group_num,
 			dev_addr);
@@ -2215,9 +2215,8 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_group_bind)
-int
-dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
+static int
+vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
 
@@ -2233,9 +2232,8 @@ dev_vfio_container_group_bind(int container_fd, int iommu_group_num)
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
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index e7ac17fb9a..08f4c902e7 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -144,21 +144,6 @@ int dev_vfio_is_enabled(void);
 __rte_internal
 int dev_vfio_noiommu_is_enabled(void);
 
-/**
- * @internal
- * Remove group fd from internal VFIO group fd array.
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
@@ -214,21 +199,6 @@ __rte_internal
 int
 dev_vfio_get_container_fd(void);
 
-/**
- * @internal
- * Open VFIO group fd or get an existing one.
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
@@ -288,42 +258,6 @@ int
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
-- 
2.54.0

