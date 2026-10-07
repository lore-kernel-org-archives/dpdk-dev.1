Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B889CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F6A642EC9;
	Wed,  7 Oct 2026 10:11:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2E4EB42EC8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EJ/k40PL/WsltOgP+eGSvliw5FH6G3mHKXeN4ge1IQ=;
 b=AV9NMSYOMOA4qZ3q+yb7TUuR2PMsLHWpv20Glbu60L07hFtHVmb5NFCWS9NWLPOHCjuAm+
 Blj1apNpYA6GKROit3Ns/F3VuBfk8mQtdJDqK/g0EKVlF5yuOxPdc3iv7jOID7guxDsml+
 MCQRMfPsUk2NZAXni4JWNPsB+AAQGKw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-hCgNwEDCOjScdTZKPAHHoA-1; Wed,
 07 Oct 2026 04:11:44 -0400
X-MC-Unique: hCgNwEDCOjScdTZKPAHHoA-1
X-Mimecast-MFC-AGG-ID: hCgNwEDCOjScdTZKPAHHoA_1791360703
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF1EA180065D; Wed,  7 Oct 2026 08:11:43 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F211741D; Wed,  7 Oct 2026 08:11:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 19/26] vfio: declare global configuration
Date: Wed,  7 Oct 2026 10:10:16 +0200
Message-ID: <20261007081026.574382-20-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xOub5B4bRnIaxE1vCuywM3CemKVhT25pDc15lNPVUEA_1791360703
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

Move containers under a single global variable.
Rename the IOMMU callbacks structure and have a single global ops.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_vfio.c | 85 ++++++++++++++++++----------------------
 lib/eal/linux/eal_vfio.h | 16 ++++++--
 2 files changed, 51 insertions(+), 50 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index c050e022da..7ad8a22cbb 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -31,7 +31,10 @@
 
 /* per-process VFIO config */
 static struct vfio_container vfio_containers[RTE_MAX_VFIO_CONTAINERS];
-static struct vfio_container *default_vfio_cfg = &vfio_containers[0];
+
+struct vfio_config vfio_global_cfg = {
+	.default_cfg = &vfio_containers[0]
+};
 
 /* whether VFIO is enabled (usable) in this process */
 static bool vfio_enabled;
@@ -91,7 +94,7 @@ static int vfio_container_group_bind(int container_fd, int iommu_group_num);
 static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
 
 /* IOMMU types we support */
-static const struct vfio_iommu_type iommu_types[] = {
+static const struct vfio_iommu_ops iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
 	{
 		.type_id = VFIO_TYPE1_IOMMU,
@@ -498,7 +501,7 @@ vfio_get_group_fd(struct vfio_container *cfg, int iommu_group_num)
 	 */
 	const struct internal_config *internal_conf = eal_get_internal_configuration();
 	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
-			(cfg == default_vfio_cfg);
+			(cfg == vfio_global_cfg.default_cfg);
 
 	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
 	if (vfio_group_fd < 0) {
@@ -536,7 +539,7 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	unsigned int i;
 
 	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
-		return default_vfio_cfg;
+		return vfio_global_cfg.default_cfg;
 
 	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
 		if (vfio_containers[i].container_fd == container_fd)
@@ -556,7 +559,7 @@ vfio_get_group_fd_by_num(int iommu_group_num)
 
 	/* get the vfio_container it belongs to */
 	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : default_vfio_cfg;
+	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
 
 	return vfio_get_group_fd(cfg, iommu_group_num);
 }
@@ -640,6 +643,7 @@ static void
 vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 		void *arg __rte_unused)
 {
+	struct vfio_container *cfg = vfio_global_cfg.default_cfg;
 	struct rte_memseg_list *msl;
 	struct rte_memseg *ms;
 	size_t cur_len = 0;
@@ -654,11 +658,9 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 		/* Maintain granularity of DMA map/unmap to memseg size */
 		for (; cur_len < len; cur_len += page_sz) {
 			if (type == RTE_MEM_EVENT_ALLOC)
-				vfio_dma_mem_map(default_vfio_cfg, vfio_va,
-						 vfio_va, page_sz, 1);
+				vfio_dma_mem_map(cfg, vfio_va, vfio_va, page_sz, 1);
 			else
-				vfio_dma_mem_map(default_vfio_cfg, vfio_va,
-						 vfio_va, page_sz, 0);
+				vfio_dma_mem_map(cfg, vfio_va, vfio_va, page_sz, 0);
 			vfio_va += page_sz;
 		}
 
@@ -676,11 +678,9 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 			goto next;
 		}
 		if (type == RTE_MEM_EVENT_ALLOC)
-			vfio_dma_mem_map(default_vfio_cfg, ms->addr_64,
-					ms->iova, ms->len, 1);
+			vfio_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
 		else
-			vfio_dma_mem_map(default_vfio_cfg, ms->addr_64,
-					ms->iova, ms->len, 0);
+			vfio_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 0);
 next:
 		cur_len += ms->len;
 		++ms;
@@ -702,7 +702,7 @@ vfio_sync_default_container(void)
 		return -1;
 
 	/* default container fd should have been opened in dev_vfio_enable() */
-	if (!vfio_enabled || default_vfio_cfg->container_fd < 0) {
+	if (!vfio_enabled || vfio_global_cfg.default_cfg->container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
 		return -1;
 	}
@@ -732,12 +732,12 @@ vfio_sync_default_container(void)
 	 * now, set up default VFIO container config to match.
 	 */
 	for (i = 0; i < RTE_DIM(iommu_types); i++) {
-		const struct vfio_iommu_type *t = &iommu_types[i];
+		const struct vfio_iommu_ops *t = &iommu_types[i];
 		if (t->type_id != iommu_type_id)
 			continue;
 
 		/* we found our IOMMU type */
-		default_vfio_cfg->vfio_iommu_type = t;
+		vfio_global_cfg.ops = t;
 
 		return 0;
 	}
@@ -845,7 +845,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 
 	/* get the vfio_container it belongs to */
 	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : default_vfio_cfg;
+	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
 	vfio_container_fd = cfg->container_fd;
 	user_mem_maps = &cfg->mem_maps;
 
@@ -874,7 +874,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
 				cfg->vfio_active_groups == 1 &&
 				vfio_group_device_count(vfio_group_fd) == 0) {
-			const struct vfio_iommu_type *t;
+			const struct vfio_iommu_ops *t;
 
 			/* select an IOMMU type which we will be using */
 			t = vfio_set_iommu_type(vfio_container_fd);
@@ -890,7 +890,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			 * after registering callback, to prevent races
 			 */
 			rte_mcfg_mem_read_lock();
-			if (cfg == default_vfio_cfg)
+			if (cfg == vfio_global_cfg.default_cfg)
 				ret = t->dma_map_func(cfg);
 			else
 				ret = 0;
@@ -905,8 +905,6 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 				return -1;
 			}
 
-			cfg->vfio_iommu_type = t;
-
 			/* re-map all user-mapped segments */
 			rte_spinlock_recursive_lock(&user_mem_maps->lock);
 
@@ -936,7 +934,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			rte_spinlock_recursive_unlock(&user_mem_maps->lock);
 
 			/* register callback for mem events */
-			if (cfg == default_vfio_cfg)
+			if (cfg == vfio_global_cfg.default_cfg)
 				ret = rte_mem_event_callback_register(
 					VFIO_MEM_EVENT_CLB_NAME,
 					vfio_mem_event_callback, NULL);
@@ -955,8 +953,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 				EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
 		}
 	} else if (rte_eal_process_type() != RTE_PROC_PRIMARY &&
-			cfg == default_vfio_cfg &&
-			cfg->vfio_iommu_type == NULL) {
+			cfg == vfio_global_cfg.default_cfg &&
+			vfio_global_cfg.ops == NULL) {
 		/* if we're not a primary process, we do not set up the VFIO
 		 * container because it's already been set up by the primary
 		 * process. instead, we simply ask the primary about VFIO type
@@ -970,10 +968,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			return -1;
 		}
 		/* we have successfully initialized VFIO, notify user */
-		const struct vfio_iommu_type *t =
-				default_vfio_cfg->vfio_iommu_type;
-		EAL_LOG(INFO, "Using IOMMU type %d (%s)",
-				t->type_id, t->name);
+		const struct vfio_iommu_ops *t = vfio_global_cfg.ops;
+		EAL_LOG(INFO, "Using IOMMU type %d (%s)", t->type_id, t->name);
 	}
 
 	rte_eal_vfio_get_vf_token(vf_token);
@@ -1053,7 +1049,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 
 	/* get the vfio_container it belongs to */
 	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : default_vfio_cfg;
+	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
 
 	/* At this point we got an active group. Closing it will make the
 	 * container detachment. If this is the last active group, VFIO kernel
@@ -1092,7 +1088,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	/* if there are no active device groups, unregister the callback to
 	 * avoid spurious attempts to map/unmap memory from VFIO.
 	 */
-	if (cfg == default_vfio_cfg && cfg->vfio_active_groups == 0 &&
+	if (cfg == vfio_global_cfg.default_cfg && cfg->vfio_active_groups == 0 &&
 			rte_eal_process_type() != RTE_PROC_SECONDARY)
 		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME,
 				NULL);
@@ -1124,7 +1120,6 @@ dev_vfio_enable(void)
 	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
 		vfio_containers[i].container_fd = -1;
 		vfio_containers[i].vfio_active_groups = 0;
-		vfio_containers[i].vfio_iommu_type = NULL;
 		vfio_containers[i].mem_maps.lock = lock;
 
 		for (j = 0; j < RTE_DIM(vfio_containers[i].vfio_groups); j++) {
@@ -1163,18 +1158,18 @@ dev_vfio_enable(void)
 
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
-			default_vfio_cfg->container_fd = -1;
+			vfio_global_cfg.default_cfg->container_fd = -1;
 		} else {
 			/* open a default container */
-			default_vfio_cfg->container_fd = vfio_open_container_fd(false);
+			vfio_global_cfg.default_cfg->container_fd = vfio_open_container_fd(false);
 		}
 	} else {
 		/* get the default container from the primary process */
-		default_vfio_cfg->container_fd = vfio_open_container_fd(true);
+		vfio_global_cfg.default_cfg->container_fd = vfio_open_container_fd(true);
 	}
 
 	/* check if we have VFIO driver enabled */
-	if (default_vfio_cfg->container_fd != -1) {
+	if (vfio_global_cfg.default_cfg->container_fd != -1) {
 		EAL_LOG(INFO, "VFIO support initialized");
 		vfio_enabled = true;
 	} else {
@@ -1204,18 +1199,18 @@ vfio_get_iommu_type(void)
 	if (!vfio_enabled)
 		return -1;
 
-	if (default_vfio_cfg->vfio_iommu_type == NULL)
+	if (vfio_global_cfg.ops == NULL)
 		return -1;
 
-	return default_vfio_cfg->vfio_iommu_type->type_id;
+	return vfio_global_cfg.ops->type_id;
 }
 
-const struct vfio_iommu_type *
+const struct vfio_iommu_ops *
 vfio_set_iommu_type(int vfio_container_fd)
 {
 	unsigned idx;
 	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_type *t = &iommu_types[idx];
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
 
 		int ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU,
 				t->type_id);
@@ -1260,7 +1255,7 @@ vfio_has_supported_extensions(int vfio_container_fd)
 	int ret;
 	unsigned idx, n_extensions = 0;
 	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_type *t = &iommu_types[idx];
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
 
 		ret = ioctl(vfio_container_fd, VFIO_CHECK_EXTENSION,
 				t->type_id);
@@ -1372,7 +1367,7 @@ dev_vfio_get_container_fd(void)
 	if (!vfio_enabled)
 		return -1;
 
-	return default_vfio_cfg->container_fd;
+	return vfio_global_cfg.default_cfg->container_fd;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
@@ -1859,7 +1854,7 @@ static int
 vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
 		int do_map)
 {
-	const struct vfio_iommu_type *t = cfg->vfio_iommu_type;
+	const struct vfio_iommu_ops *t = vfio_global_cfg.ops;
 
 	if (!t) {
 		EAL_LOG(ERR, "VFIO support not initialized");
@@ -1908,7 +1903,7 @@ container_dma_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uin
 		goto out;
 	}
 	/* do we have partial unmap support? */
-	has_partial_unmap = cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = vfio_global_cfg.ops->partial_unmap;
 
 	/* create new user mem map entry */
 	new_map = &user_mem_maps->maps[user_mem_maps->n_maps++];
@@ -1966,7 +1961,7 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	}
 
 	/* do we have partial unmap capability? */
-	has_partial_unmap = cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = vfio_global_cfg.ops->partial_unmap;
 
 	/*
 	 * if we don't support partial unmap, we must check if start and end of
@@ -2125,7 +2120,6 @@ dev_vfio_container_destroy(int container_fd)
 	close(container_fd);
 	cfg->container_fd = -1;
 	cfg->vfio_active_groups = 0;
-	cfg->vfio_iommu_type = NULL;
 
 	return 0;
 }
@@ -2305,7 +2299,6 @@ vfio_cleanup_config(struct vfio_container *cfg)
 	}
 
 	cfg->container_fd = -1;
-	cfg->vfio_iommu_type = NULL;
 
 	cfg->mem_maps.n_maps = 0;
 	memset(cfg->mem_maps.maps, 0, sizeof(cfg->mem_maps.maps));
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index cd37790ad2..78b8ac4a36 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -44,7 +44,6 @@ struct vfio_group {
 struct vfio_container {
 	int container_fd;
 	int vfio_active_groups;
-	const struct vfio_iommu_type *vfio_iommu_type;
 	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
 	struct vfio_user_mem_maps mem_maps;
 };
@@ -63,7 +62,7 @@ typedef int (*vfio_dma_func_t)(struct vfio_container *cfg);
 typedef int (*vfio_dma_user_func_t)(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map);
 
-struct vfio_iommu_type {
+struct vfio_iommu_ops {
 	int type_id;
 	const char *name;
 	bool partial_unmap;
@@ -74,8 +73,17 @@ struct vfio_iommu_type {
 /* get the vfio container that devices are bound to by default */
 int vfio_open_container_fd(bool mp_request);
 
-/* pick IOMMU type. returns a pointer to vfio_iommu_type or NULL for error */
-const struct vfio_iommu_type *
+/* global configuration */
+struct vfio_config {
+	struct vfio_container *default_cfg;
+	const struct vfio_iommu_ops *ops;
+};
+
+/* current configuration */
+extern struct vfio_config vfio_global_cfg;
+
+/* pick IOMMU type. returns a pointer to vfio_iommu_ops or NULL for error */
+const struct vfio_iommu_ops *
 vfio_set_iommu_type(int vfio_container_fd);
 
 int
-- 
2.54.0

