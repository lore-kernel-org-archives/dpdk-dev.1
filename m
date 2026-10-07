Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF11CCA6002
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 383B742E87;
	Wed,  7 Oct 2026 09:33:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1DCF342E48
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fSkLhJEZcVpoepWGTy/BurqDHsgNwAr2nfztX6kkgMM=;
 b=PW/51mw4GVvSXR2QO3UnhD6SHtlF2bI+C8V1KLPwpcVuxNEDoyskJWORDTCgrWs8dcD2OL
 imKohIbIUl/RwM8IB+yHwJpRVXz2uec7vAfJOzSvOby+PTjqh97xlvAMC9SLC4owkzB8Ts
 +izskxAkEiigSPx+9vQSf6n5y/7PzUY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-FuAxC0rxOEWOTKZSKYh50A-1; Wed,
 07 Oct 2026 03:33:46 -0400
X-MC-Unique: FuAxC0rxOEWOTKZSKYh50A-1
X-Mimecast-MFC-AGG-ID: FuAxC0rxOEWOTKZSKYh50A_1791358425
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8EA819352EE; Wed,  7 Oct 2026 07:33:44 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2AD4472; Wed,  7 Oct 2026 07:33:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v19 24/26] vfio: introduce VFIO mode
Date: Wed,  7 Oct 2026 09:32:02 +0200
Message-ID: <20261007073206.567001-25-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SWPM9rCon-XNEr6MNptL1liv-VjCT1jJBBS0W_EBJyg_1791358425
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

Currently, VFIO code is a bit of an incoherent mess internally, with API's
bleeding into each other, inconsistent returns, and a certain amount of
spaghetti stemming from organic growth.

Refactor VFIO code to achieve the following goals:

- Make all error handling consistent, and provide/document rte_errno values
  returned from API's to indicate various conditions.

- Introduce new "VFIO mode" concept. This new API will tell caller which
  VFIO mode is in use, allowing callers to know when to call group number
  vs device number API

- Perform device setup in device assign, and make device setup use shared
  code path with device assign and explicitly assuming default container.
  This is technically not necessary for group mode as device set up is a
  two-step process in that mode, but coming cdev mode will have a
  single-step device setup, and it would be easier if the worked the same
  way under the hood.

- Add device deduplication based on sysfs path and device address.

- Make VFIO internals more readable. Introduce a lot of infrastructure and
  more explicit validation, rather than over-reliance on sentinel values
  and implicit assumptions. This will also make it easier to integrate cdev
  mode down the line, as it will rely on most of this infrastructure.

- Change `dev_vfio_container_destroy` so this function now releases and
  closes all group and device resources associated with the container
  being destroyed by this call

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 config/arm/meson.build           |    1 +
 config/meson.build               |    1 +
 lib/eal/linux/eal_vfio.c         | 1679 +++++++++++++-----------------
 lib/eal/linux/eal_vfio.h         |   77 +-
 lib/eal/linux/eal_vfio_group.c   |  422 +++++++-
 lib/eal/linux/eal_vfio_mp_sync.c |   43 +-
 lib/eal/linux/include/dev_vfio.h |  104 +-
 7 files changed, 1318 insertions(+), 1009 deletions(-)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 27b549a052..2b73cbef7e 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -147,6 +147,7 @@ implementer_cavium = {
     'description': 'Cavium',
     'flags': [
         ['RTE_MAX_VFIO_GROUPS', 128],
+        ['RTE_MAX_VFIO_DEVICES', 256],
         ['RTE_MAX_LCORE', 96],
         ['RTE_MAX_NUMA_NODES', 2]
     ],
diff --git a/config/meson.build b/config/meson.build
index 344f68822b..aa1e83b1e2 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -386,6 +386,7 @@ dpdk_conf.set('RTE_ENABLE_TRACE_FP', get_option('enable_trace_fp'))
 dpdk_conf.set('RTE_PKTMBUF_HEADROOM', get_option('pkt_mbuf_headroom'))
 # values which have defaults which may be overridden
 dpdk_conf.set('RTE_MAX_VFIO_GROUPS', 64)
+dpdk_conf.set('RTE_MAX_VFIO_DEVICES', 256)
 dpdk_conf.set('RTE_DRIVER_MEMPOOL_BUCKET_SIZE_KB', 64)
 dpdk_conf.set('RTE_LIBRTE_DPAA2_USE_PHYS_IOVA', true)
 if get_option('mbuf_refcnt_atomic')
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index d2fe459774..fb6cf496e6 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -33,20 +33,53 @@
  * rte_errno convention:
  *
  * - EINVAL: invalid parameters
+ * - ENOTSUP: current mode does not support this operation
+ * - ENXIO: VFIO not initialized
  * - ENODEV: device not managed by VFIO
+ * - ENOSPC: no space in config
+ * - EEXIST: device already assigned
+ * - ENOENT: group or device not found
+ * - ENOMEM: memory allocation failed
+ * - EIO: underlying VFIO operation failed
  */
 
-/* per-process VFIO config */
+/* functions can fail for multiple reasons, and errno is tedious */
+enum vfio_result {
+	VFIO_SUCCESS,
+	VFIO_ERROR,
+	VFIO_EXISTS,
+	VFIO_NOT_SUPPORTED,
+	VFIO_NOT_MANAGED,
+	VFIO_NOT_FOUND,
+	VFIO_NO_SPACE,
+	VFIO_NO_MEM,
+};
+
+/* per-process, per-container data */
 static struct vfio_container vfio_containers[RTE_MAX_VFIO_CONTAINERS];
 
+#define VFIO_CONTAINER_FOREACH(cfg) \
+	for ((cfg) = &vfio_containers[0]; \
+		(cfg) < &vfio_containers[RTE_DIM(vfio_containers)]; \
+		(cfg)++)
+
+#define VFIO_CONTAINER_FOREACH_ACTIVE(cfg) \
+	VFIO_CONTAINER_FOREACH((cfg)) \
+		if (((cfg)->active))
+
+/* for containers, we need to initialize the fd, and mem maps lock */
+#define VFIO_CONTAINER_INITIALIZER \
+	((struct vfio_container){ \
+		.mem_maps = { .lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER, }, \
+		.container_fd = -1, \
+	})
+
 struct vfio_config vfio_global_cfg = {
+	.mode = DEV_VFIO_MODE_NONE,
 	.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN,
 	.default_cfg = &vfio_containers[0]
 };
 
-/* whether VFIO is enabled (usable) in this process */
-static bool vfio_enabled;
-
 static int
 vfio_check_module(enum dev_vfio_module module)
 {
@@ -92,9 +125,6 @@ vfio_check_module(enum dev_vfio_module module)
 static int vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map);
 
-static int vfio_container_group_bind(int container_fd, int iommu_group_num);
-static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
-
 static int
 is_null_map(const struct vfio_user_mem_map *map)
 {
@@ -372,275 +402,120 @@ vfio_noiommu_is_enabled(void)
 	return c == 'Y';
 }
 
-static int
-vfio_open_group_fd(int iommu_group_num, bool mp_request)
+bool
+vfio_container_is_default(struct vfio_container *cfg)
 {
-	int vfio_group_fd;
-	char filename[PATH_MAX];
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-
-	/* if not requesting via mp, open the group locally */
-	if (!mp_request) {
-		/* try regular group format */
-		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
-		vfio_group_fd = open(filename, O_RDWR);
-		if (vfio_group_fd < 0) {
-			/* if file not found, it's not an error */
-			if (errno != ENOENT) {
-				EAL_LOG(ERR, "Cannot open %s: %s",
-						filename, strerror(errno));
-				return -1;
-			}
-
-			/* special case: try no-IOMMU path as well */
-			snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT,
-				iommu_group_num);
-			vfio_group_fd = open(filename, O_RDWR);
-			if (vfio_group_fd < 0) {
-				if (errno != ENOENT) {
-					EAL_LOG(ERR,
-						"Cannot open %s: %s",
-						filename, strerror(errno));
-					return -1;
-				}
-				return -ENOENT;
-			}
-			/* noiommu group found */
-		}
-
-		return vfio_group_fd;
-	}
-	/* if we're in a secondary process, request group fd from the primary
-	 * process via mp channel.
-	 */
-	p->req = VFIO_SOCKET_REQ_GROUP;
-	p->group_num = iommu_group_num;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	vfio_group_fd = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-	    mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
-			vfio_group_fd = mp_rep->fds[0];
-		} else if (p->result == VFIO_SOCKET_NO_FD) {
-			EAL_LOG(ERR, "Bad VFIO group fd");
-			vfio_group_fd = -ENOENT;
-		}
-	}
-
-	free(mp_reply.msgs);
-	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
-		EAL_LOG(ERR, "Cannot request VFIO group fd");
-	return vfio_group_fd;
+	return cfg == vfio_global_cfg.default_cfg;
 }
 
 static struct vfio_container *
-get_vfio_cfg_by_group_num(int iommu_group_num)
+vfio_container_get_by_fd(int container_fd)
 {
 	struct vfio_container *cfg;
-	unsigned int i, j;
-
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		cfg = &vfio_containers[i];
-		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++) {
-			if (cfg->vfio_groups[j].group_num ==
-					iommu_group_num)
-				return cfg;
-		}
-	}
-
-	return NULL;
-}
 
-static int
-vfio_get_group_fd(struct vfio_container *cfg, int iommu_group_num)
-{
-	struct vfio_group *cur_grp = NULL;
-	int vfio_group_fd;
-	unsigned int i;
-
-	/* check if we already have the group descriptor open */
-	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
-		if (cfg->vfio_groups[i].group_num == iommu_group_num)
-			return cfg->vfio_groups[i].fd;
-
-	/* Lets see first if there is room for a new group */
-	if (cfg->vfio_active_groups == RTE_DIM(cfg->vfio_groups)) {
-		EAL_LOG(ERR, "Maximum number of VFIO groups reached!");
-		return -1;
-	}
-
-	/* Now lets get an index for the new group */
-	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
-		if (cfg->vfio_groups[i].group_num == -1) {
-			cur_grp = &cfg->vfio_groups[i];
-			break;
-		}
-
-	/* This should not happen */
-	if (cur_grp == NULL) {
-		EAL_LOG(ERR, "No VFIO group free slot found");
-		return -1;
-	}
-
-	/*
-	 * When opening a group fd, we need to decide whether to open it locally
-	 * or request it from the primary process via mp_sync.
-	 *
-	 * For the default container, secondary processes use mp_sync so that
-	 * the primary process tracks the group fd and maintains VFIO state
-	 * across all processes.
-	 *
-	 * For custom containers, we open the group fd locally in each process
-	 * since custom containers are process-local and the primary has no
-	 * knowledge of them. Requesting a group fd from the primary for a
-	 * container it doesn't know about would be incorrect.
-	 */
-	const struct internal_config *internal_conf = eal_get_internal_configuration();
-	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
-			(cfg == vfio_global_cfg.default_cfg);
+	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
+		return vfio_global_cfg.default_cfg;
 
-	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
-	if (vfio_group_fd < 0) {
-		EAL_LOG(ERR, "Failed to open VFIO group %d",
-			iommu_group_num);
-		return vfio_group_fd;
+	VFIO_CONTAINER_FOREACH_ACTIVE(cfg) {
+		if (cfg->container_fd == container_fd)
+			return cfg;
 	}
-
-	cur_grp->group_num = iommu_group_num;
-	cur_grp->fd = vfio_group_fd;
-	cfg->vfio_active_groups++;
-
-	return vfio_group_fd;
+	return NULL;
 }
 
 static struct vfio_container *
-get_vfio_cfg_by_group_fd(int vfio_group_fd)
+vfio_container_get_by_group_num(int group_num)
 {
 	struct vfio_container *cfg;
-	unsigned int i, j;
+	struct vfio_group *grp;
 
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		cfg = &vfio_containers[i];
-		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++)
-			if (cfg->vfio_groups[j].fd == vfio_group_fd)
+	VFIO_CONTAINER_FOREACH_ACTIVE(cfg) {
+		VFIO_GROUP_FOREACH_ACTIVE(cfg, grp)
+			if (grp->group_num == group_num)
 				return cfg;
 	}
-
 	return NULL;
 }
 
 static struct vfio_container *
-get_vfio_cfg_by_container_fd(int container_fd)
+vfio_container_create(void)
 {
-	unsigned int i;
-
-	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
-		return vfio_global_cfg.default_cfg;
+	struct vfio_container *cfg;
 
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		if (vfio_containers[i].container_fd == container_fd)
-			return &vfio_containers[i];
+	/* find an unused container config */
+	VFIO_CONTAINER_FOREACH(cfg) {
+		if (!cfg->active) {
+			*cfg = VFIO_CONTAINER_INITIALIZER;
+			cfg->active = true;
+			return cfg;
+		}
 	}
-
+	/* no space */
 	return NULL;
 }
 
-int
-vfio_get_group_fd_by_num(int iommu_group_num)
+static void
+vfio_container_erase(struct vfio_container *cfg)
 {
-	struct vfio_container *cfg;
-
-	if (!vfio_enabled)
-		return -1;
-
-	/* get the vfio_container it belongs to */
-	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
+	if (cfg->container_fd >= 0 && close(cfg->container_fd))
+		EAL_LOG(ERR, "Error when closing container, %d (%s)", errno, strerror(errno));
 
-	return vfio_get_group_fd(cfg, iommu_group_num);
+	*cfg = VFIO_CONTAINER_INITIALIZER;
 }
 
-static int
-get_vfio_group_idx(int vfio_group_fd)
+static struct vfio_device *
+vfio_device_create(struct vfio_container *cfg, enum dev_vfio_mode mode)
 {
-	struct vfio_container *cfg;
-	unsigned int i, j;
-
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		cfg = &vfio_containers[i];
-		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++)
-			if (cfg->vfio_groups[j].fd == vfio_group_fd)
-				return j;
-	}
+	struct vfio_device *dev;
 
-	return -1;
-}
+	/* is there space? */
+	if (cfg->n_devices == RTE_DIM(cfg->devices))
+		return NULL;
 
-static void
-vfio_group_device_get(int vfio_group_fd)
-{
-	struct vfio_container *cfg;
-	int i;
+	VFIO_DEVICE_FOREACH(cfg, dev) {
+		if (dev->active)
+			continue;
+		dev->active = true;
+		dev->mode = mode;
+		/* set to invalid fd */
+		dev->fd = -1;
 
-	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return;
+		cfg->n_devices++;
+		return dev;
 	}
-
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-	else
-		cfg->vfio_groups[i].devices++;
+	/* should not happen */
+	EAL_LOG(WARNING, "Could not find space in device list for container");
+	return NULL;
 }
 
 static void
-vfio_group_device_put(int vfio_group_fd)
+vfio_device_erase(struct vfio_container *cfg, struct vfio_device *dev)
 {
-	struct vfio_container *cfg;
-	int i;
+	if (dev->fd >= 0 && close(dev->fd))
+		EAL_LOG(ERR, "Error when closing device, %d (%s)", errno, strerror(errno));
 
-	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return;
+	if (dev->mode == DEV_VFIO_MODE_GROUP) {
+		free(dev->sysfs_base);
+		free(dev->dev_addr);
 	}
-
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-	else
-		cfg->vfio_groups[i].devices--;
+	*dev = (struct vfio_device){0};
+	cfg->n_devices--;
 }
 
-static int
-vfio_group_device_count(int vfio_group_fd)
+static struct vfio_device *
+vfio_device_get_by_addr(struct vfio_container *cfg, const char *sysfs_base, const char *dev_addr)
 {
-	struct vfio_container *cfg;
-	int i;
-
-	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
-		return -1;
-	}
+	struct vfio_device *dev;
 
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0) {
-		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
-		return -1;
+	VFIO_DEVICE_FOREACH_ACTIVE(cfg, dev) {
+		/* only group mode have sysfs_base and dev_addr */
+		if (dev->mode != DEV_VFIO_MODE_GROUP)
+			continue;
+		if (strcmp(dev->sysfs_base, sysfs_base) == 0 &&
+				strcmp(dev->dev_addr, dev_addr) == 0)
+			return dev;
 	}
-
-	return cfg->vfio_groups[i].devices;
+	return NULL;
 }
 
 static void
@@ -676,9 +551,7 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 	while (cur_len < len) {
 		/* some memory segments may have invalid IOVA */
 		if (ms->iova == RTE_BAD_IOVA) {
-			EAL_LOG(DEBUG,
-				"Memory segment at %p has bad IOVA, skipping",
-				ms->addr);
+			EAL_LOG(DEBUG, "Memory segment at %p has bad IOVA, skipping", ms->addr);
 			goto next;
 		}
 		if (type == RTE_MEM_EVENT_ALLOC)
@@ -692,417 +565,484 @@ vfio_mem_event_callback(enum rte_mem_event type, const void *addr, size_t len,
 }
 
 static int
-vfio_sync_default_container(void)
+vfio_register_mem_event_callback(void)
 {
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-	int iommu_type_id;
-	unsigned int i;
-
-	/* cannot be called from primary */
-	if (rte_eal_process_type() != RTE_PROC_SECONDARY)
-		return -1;
-
-	/* default container fd should have been opened in dev_vfio_enable() */
-	if (!vfio_enabled || vfio_global_cfg.default_cfg->container_fd < 0) {
-		EAL_LOG(ERR, "VFIO support is not initialized");
-		return -1;
-	}
+	int ret;
 
-	/* find default container's IOMMU type */
-	p->req = VFIO_SOCKET_REQ_IOMMU_TYPE;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
+	ret = rte_mem_event_callback_register(VFIO_MEM_EVENT_CLB_NAME, vfio_mem_event_callback,
+		NULL);
 
-	iommu_type_id = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-			mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == VFIO_SOCKET_OK)
-			iommu_type_id = p->iommu_type_id;
-	}
-	free(mp_reply.msgs);
-	if (iommu_type_id < 0) {
-		EAL_LOG(ERR,
-			"Could not get IOMMU type for default container");
+	if (ret && rte_errno != ENOTSUP) {
+		EAL_LOG(ERR, "Could not install memory event callback for VFIO");
 		return -1;
 	}
+	if (ret)
+		EAL_LOG(DEBUG, "Memory event callbacks not supported");
+	else
+		EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
 
-	/* we now have an fd for default container, as well as its IOMMU type.
-	 * now, set up default VFIO container config to match.
-	 */
-	for (i = 0; i < RTE_DIM(iommu_types); i++) {
-		const struct vfio_iommu_ops *t = &iommu_types[i];
-		if (t->type_id != iommu_type_id)
-			continue;
-
-		/* we found our IOMMU type */
-		vfio_global_cfg.ops = t;
-
-		return 0;
-	}
-	EAL_LOG(ERR, "Could not find IOMMU type id (%i)",
-			iommu_type_id);
-	return -1;
+	return 0;
 }
 
 static int
-vfio_clear_group(int vfio_group_fd)
+vfio_setup_dma_mem(struct vfio_container *cfg)
 {
-	int i;
-	struct vfio_container *cfg;
-
-	if (!vfio_enabled)
-		return -1;
+	struct vfio_user_mem_maps *user_mem_maps = &cfg->mem_maps;
+	int i, ret;
 
-	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO group fd!");
+	/* do we need to map DPDK-managed memory? */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() == RTE_PROC_PRIMARY)
+		ret = vfio_global_cfg.ops->dma_map_func(cfg);
+	else
+		ret = 0;
+	if (ret) {
+		EAL_LOG(ERR, "DMA remapping failed, error %i (%s)", errno, strerror(errno));
 		return -1;
 	}
 
-	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0)
-		return -1;
-	cfg->vfio_groups[i].group_num = -1;
-	cfg->vfio_groups[i].fd = -1;
-	cfg->vfio_groups[i].devices = 0;
-	cfg->vfio_active_groups--;
+	/*
+	 * not all IOMMU types support DMA mapping, but if we have mappings in the list - that
+	 * means we have previously mapped something successfully, so we can be sure that DMA
+	 * mapping is supported.
+	 */
+	for (i = 0; i < user_mem_maps->n_maps; i++) {
+		struct vfio_user_mem_map *map;
+		map = &user_mem_maps->maps[i];
+
+		ret = vfio_global_cfg.ops->dma_user_map_func(cfg, map->addr, map->iova, map->len,
+			1);
+		if (ret) {
+			EAL_LOG(ERR, "Couldn't map user memory for DMA: "
+				"va: 0x%" PRIx64 " iova: 0x%" PRIx64 " len: 0x%" PRIu64,
+				map->addr, map->iova, map->len);
+			return -1;
+		}
+	}
 
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_setup_device)
-int
-dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd)
+static enum vfio_result
+vfio_group_assign_device(struct vfio_container *cfg, const char *sysfs_base, const char *dev_addr,
+		struct vfio_device **out_dev)
 {
-	struct vfio_group_status group_status = {
-			.argsz = sizeof(group_status)
-	};
-	struct vfio_container *cfg;
-	struct vfio_user_mem_maps *user_mem_maps;
-	int vfio_container_fd;
-	int vfio_group_fd;
+	struct vfio_group_config *group_cfg = &cfg->group_cfg;
+	struct vfio_group *grp;
+	struct vfio_device *dev;
 	int iommu_group_num;
-	rte_uuid_t vf_token;
-	int i, ret;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	enum vfio_result res;
+	int ret;
 
-	if (sysfs_base == NULL || dev_addr == NULL || vfio_dev_fd == NULL) {
-		rte_errno = EINVAL;
-		return -1;
+	/* if this device is already assigned, reuse it instead of opening a second fd */
+	dev = vfio_device_get_by_addr(cfg, sysfs_base, dev_addr);
+	if (dev != NULL) {
+		*out_dev = dev;
+		return VFIO_EXISTS;
 	}
 
-	if (!vfio_enabled)
-		return -1;
-
-	/* get group number */
-	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret < 0)
-		return -1;
-
-	/* get the actual group fd */
-	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
-	if (vfio_group_fd < 0 && vfio_group_fd != -ENOENT)
-		return -1;
-
-	/*
-	 * if vfio_group_fd == -ENOENT, that means the device
-	 * isn't managed by VFIO
-	 */
-	if (vfio_group_fd == -ENOENT) {
-		rte_errno = ENODEV;
-		return -1;
+	/* allocate new device in config */
+	dev = vfio_device_create(cfg, vfio_global_cfg.mode);
+	if (dev == NULL) {
+		EAL_LOG(ERR, "No space to track new VFIO device");
+		return VFIO_NO_SPACE;
 	}
 
-	/*
-	 * at this point, we know that this group is viable (meaning, all devices
-	 * are either bound to VFIO or not bound to anything)
-	 */
-
-	/* check if the group is viable */
-	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
-	if (ret) {
-		EAL_LOG(ERR, "%s cannot get VFIO group status, "
-			"error %i (%s)", dev_addr, errno, strerror(errno));
-		close(vfio_group_fd);
-		vfio_clear_group(vfio_group_fd);
-		return -1;
-	} else if (!(group_status.flags & VFIO_GROUP_FLAGS_VIABLE)) {
-		EAL_LOG(ERR, "%s VFIO group is not viable! "
-			"Not all devices in IOMMU group bound to VFIO or unbound",
-			dev_addr);
-		close(vfio_group_fd);
-		vfio_clear_group(vfio_group_fd);
-		return -1;
+	/* allocate strings for sysfs path and device address */
+	dev->sysfs_base = strdup(sysfs_base);
+	dev->dev_addr = strdup(dev_addr);
+	if (dev->sysfs_base == NULL || dev->dev_addr == NULL) {
+		EAL_LOG(ERR, "Cannot allocate memory for device %s", dev_addr);
+		free(dev->sysfs_base);
+		dev->sysfs_base = NULL;
+		free(dev->dev_addr);
+		dev->dev_addr = NULL;
+		res = VFIO_NO_MEM;
+		goto device_erase;
 	}
 
-	/* get the vfio_container it belongs to */
-	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
-	vfio_container_fd = cfg->container_fd;
-	user_mem_maps = &cfg->mem_maps;
-
-	/* check if group does not have a container yet */
-	if (!(group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET)) {
+	/* remember to register mem event callback for default container in primary */
+	bool need_clb = vfio_container_is_default(cfg) &&
+		rte_eal_process_type() == RTE_PROC_PRIMARY;
 
-		/* add group to a container */
-		ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER, &vfio_container_fd);
-		if (ret) {
-			EAL_LOG(ERR,
-				"%s cannot add VFIO group to container, error "
-				"%i (%s)", dev_addr, errno, strerror(errno));
-			close(vfio_group_fd);
-			vfio_clear_group(vfio_group_fd);
-			return -1;
+	/* get group number for this device */
+	ret = vfio_group_get_num(sysfs_base, dev_addr, &iommu_group_num);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot get IOMMU group for %s", dev_addr);
+		res = VFIO_ERROR;
+		goto device_erase;
+	} else if (ret == 0) {
+		res = VFIO_NOT_MANAGED;
+		goto device_erase;
+	}
+
+	/* group may already exist as multiple devices may share group */
+	grp = vfio_group_get_by_num(cfg, iommu_group_num);
+	if (grp == NULL) {
+		/* no device currently uses this group, create it */
+		grp = vfio_group_create(cfg, iommu_group_num);
+		if (grp == NULL) {
+			EAL_LOG(ERR, "Cannot allocate group for device %s", dev_addr);
+			res = VFIO_NO_SPACE;
+			goto device_erase;
 		}
 
-		/*
-		 * pick an IOMMU type and set up DMA mappings for container
-		 *
-		 * needs to be done only once, only when first group is
-		 * assigned to a container and only in primary process.
-		 * Note this can happen several times with the hotplug
-		 * functionality.
-		 */
-		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
-				cfg->vfio_active_groups == 1 &&
-				vfio_group_device_count(vfio_group_fd) == 0) {
-			const struct vfio_iommu_ops *t;
-
-			/* select an IOMMU type which we will be using */
-			t = vfio_set_iommu_type(vfio_container_fd);
-			if (!t) {
-				EAL_LOG(ERR,
-					"%s failed to select IOMMU type",
-					dev_addr);
-				close(vfio_group_fd);
-				vfio_clear_group(vfio_group_fd);
-				return -1;
-			}
-			/* lock memory hotplug before mapping and release it
-			 * after registering callback, to prevent races
-			 */
-			rte_mcfg_mem_read_lock();
-			if (cfg == vfio_global_cfg.default_cfg)
-				ret = t->dma_map_func(cfg);
-			else
-				ret = 0;
-			if (ret) {
-				EAL_LOG(ERR,
-					"%s DMA remapping failed, error "
-					"%i (%s)",
-					dev_addr, errno, strerror(errno));
-				close(vfio_group_fd);
-				vfio_clear_group(vfio_group_fd);
-				rte_mcfg_mem_read_unlock();
-				return -1;
-			}
+		/* open group fd */
+		ret = vfio_group_open_fd(cfg, grp);
+		if (ret == -ENOENT) {
+			EAL_LOG(DEBUG, "Device %s (IOMMU group %d) not managed by VFIO",
+				dev_addr, iommu_group_num);
+			res = VFIO_NOT_MANAGED;
+			goto group_erase;
+		} else if (ret < 0) {
+			EAL_LOG(ERR, "Cannot open VFIO group %d for device %s",
+				iommu_group_num, dev_addr);
+			res = VFIO_ERROR;
+			goto group_erase;
+		}
 
-			/* re-map all user-mapped segments */
-			rte_spinlock_recursive_lock(&user_mem_maps->lock);
+		/* prepare group (viability + container attach) */
+		ret = vfio_group_prepare(cfg, grp);
+		if (ret < 0) {
+			res = VFIO_ERROR;
+			goto group_erase;
+		}
 
-			/* this IOMMU type may not support DMA mapping, but
-			 * if we have mappings in the list - that means we have
-			 * previously mapped something successfully, so we can
-			 * be sure that DMA mapping is supported.
-			 */
-			for (i = 0; i < user_mem_maps->n_maps; i++) {
-				struct vfio_user_mem_map *map;
-				map = &user_mem_maps->maps[i];
-
-				ret = t->dma_user_map_func(cfg, map->addr, map->iova, map->len, 1);
-				if (ret) {
-					EAL_LOG(ERR, "Couldn't map user memory for DMA: "
-							"va: 0x%" PRIx64 " "
-							"iova: 0x%" PRIx64 " "
-							"len: 0x%" PRIu64,
-							map->addr, map->iova,
-							map->len);
-					rte_spinlock_recursive_unlock(
-							&user_mem_maps->lock);
-					rte_mcfg_mem_read_unlock();
-					return -1;
-				}
+		/* set up IOMMU type once per container */
+		if (!group_cfg->iommu_type_set) {
+			ret = vfio_group_setup_iommu(cfg);
+			if (ret < 0) {
+				res = VFIO_ERROR;
+				goto group_erase;
 			}
-			rte_spinlock_recursive_unlock(&user_mem_maps->lock);
-
-			/* register callback for mem events */
-			if (cfg == vfio_global_cfg.default_cfg)
-				ret = rte_mem_event_callback_register(
-					VFIO_MEM_EVENT_CLB_NAME,
-					vfio_mem_event_callback, NULL);
-			else
-				ret = 0;
-			/* unlock memory hotplug */
-			rte_mcfg_mem_read_unlock();
+			group_cfg->iommu_type_set = true;
+		}
 
-			if (ret && rte_errno != ENOTSUP) {
-				EAL_LOG(ERR, "Could not install memory event callback for VFIO");
-				return -1;
+		/* set up DMA memory once per container */
+		if (!cfg->dma_setup_done) {
+			rte_spinlock_recursive_lock(&cfg->mem_maps.lock);
+			ret = vfio_setup_dma_mem(cfg);
+			rte_spinlock_recursive_unlock(&cfg->mem_maps.lock);
+			if (ret < 0) {
+				EAL_LOG(ERR, "DMA remapping for %s failed", dev_addr);
+				res = VFIO_ERROR;
+				goto group_erase;
 			}
-			if (ret)
-				EAL_LOG(DEBUG, "Memory event callbacks not supported");
-			else
-				EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
+			cfg->dma_setup_done = true;
 		}
-	} else if (rte_eal_process_type() != RTE_PROC_PRIMARY &&
-			cfg == vfio_global_cfg.default_cfg &&
-			vfio_global_cfg.ops == NULL) {
-		/* if we're not a primary process, we do not set up the VFIO
-		 * container because it's already been set up by the primary
-		 * process. instead, we simply ask the primary about VFIO type
-		 * we are using, and set the VFIO config up appropriately.
-		 */
-		ret = vfio_sync_default_container();
-		if (ret < 0) {
-			EAL_LOG(ERR, "Could not sync default VFIO container");
-			close(vfio_group_fd);
-			vfio_clear_group(vfio_group_fd);
-			return -1;
+
+		/* set up mem event callback if needed */
+		if (need_clb && !group_cfg->mem_event_clb_set) {
+			ret = vfio_register_mem_event_callback();
+			if (ret < 0) {
+				res = VFIO_ERROR;
+				goto group_erase;
+			}
+			group_cfg->mem_event_clb_set = true;
 		}
-		/* we have successfully initialized VFIO, notify user */
-		const struct vfio_iommu_ops *t = vfio_global_cfg.ops;
-		EAL_LOG(INFO, "Using IOMMU type %d (%s)", t->type_id, t->name);
 	}
 
-	rte_eal_vfio_get_vf_token(vf_token);
+	/* open dev fd */
+	ret = vfio_group_setup_device_fd(dev_addr, grp, dev);
+	if (ret < 0) {
+		EAL_LOG(ERR, "Cannot open VFIO device %s, error %i (%s)", dev_addr, errno,
+			strerror(errno));
+		res = VFIO_ERROR;
+		goto group_erase;
+	}
 
-	/* get a file descriptor for the device with VF token firstly */
-	if (!rte_uuid_is_null(vf_token)) {
-		char vf_token_str[RTE_UUID_STRLEN];
-		char dev[PATH_MAX];
+	/*
+	 * we do not need to look in other configs: if we were to attempt to use
+	 * a different container, the kernel wouldn't have allowed us to bind the
+	 * group to the container in the first place.
+	 */
+	*out_dev = dev;
+	return VFIO_SUCCESS;
+group_erase:
+	/* this may be a pre-existing group so only erase it if it has no devices */
+	if (grp->n_devices == 0)
+		vfio_group_erase(cfg, grp);
+	/* if we registered callback, unregister it */
+	if (group_cfg->n_groups == 0 && group_cfg->mem_event_clb_set) {
+		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+		group_cfg->mem_event_clb_set = false;
+	}
+device_erase:
+	vfio_device_erase(cfg, dev);
+	return res;
+}
 
-		rte_uuid_unparse(vf_token, vf_token_str, sizeof(vf_token_str));
-		snprintf(dev, sizeof(dev),
-			 "%s vf_token=%s", dev_addr, vf_token_str);
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_assign_device)
+int
+dev_vfio_container_assign_device(int container_fd, const char *sysfs_base, const char *dev_addr)
+{
+	struct vfio_container *cfg;
+	enum vfio_result res;
+	struct vfio_device *dev;
 
-		*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD,
-				     dev);
-		if (*vfio_dev_fd >= 0)
-			goto out;
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
 	}
 
-	/* get a file descriptor for the device */
-	*vfio_dev_fd = ioctl(vfio_group_fd, VFIO_GROUP_GET_DEVICE_FD, dev_addr);
-	if (*vfio_dev_fd < 0) {
-		/* if we cannot get a device fd, this implies a problem with
-		 * the VFIO group or the container not having IOMMU configured.
-		 */
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
 
-		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed",
-				dev_addr);
-		close(vfio_group_fd);
-		vfio_clear_group(vfio_group_fd);
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
+	/* protect memory configuration while setting up IOMMU/DMA */
+	rte_mcfg_mem_read_lock();
 
-	/* device is now set up */
-out:
-	vfio_group_device_get(vfio_group_fd);
+	switch (vfio_global_cfg.mode) {
+	case DEV_VFIO_MODE_GROUP:
+		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		res = VFIO_NOT_SUPPORTED;
+		break;
+	}
+	rte_mcfg_mem_read_unlock();
 
-	return 0;
+	switch (res) {
+	case VFIO_SUCCESS:
+		return 0;
+	case VFIO_EXISTS:
+		rte_errno = EEXIST;
+		return -1;
+	case VFIO_NOT_MANAGED:
+		EAL_LOG(DEBUG, "Device %s not managed by VFIO", dev_addr);
+		rte_errno = ENODEV;
+		return -1;
+	case VFIO_NO_SPACE:
+		EAL_LOG(ERR, "No space in VFIO container to assign device %s", dev_addr);
+		rte_errno = ENOSPC;
+		return -1;
+	case VFIO_NO_MEM:
+		EAL_LOG(ERR, "Memory allocation failed for device %s", dev_addr);
+		rte_errno = ENOMEM;
+		return -1;
+	default:
+		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
+		rte_errno = EIO;
+		return -1;
+	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_release_device)
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_setup_device)
 int
-dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
-		    int vfio_dev_fd)
+dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd)
 {
 	struct vfio_container *cfg;
-	int vfio_group_fd;
-	int iommu_group_num;
+	struct vfio_device *dev;
+	enum vfio_result res;
 	int ret;
 
-	if (sysfs_base == NULL || dev_addr == NULL) {
+	if (sysfs_base == NULL || dev_addr == NULL || vfio_dev_fd == NULL) {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	if (!vfio_enabled)
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
+	}
 
-	/* we don't want any DMA mapping messages to come while we're detaching
-	 * VFIO device, because this might be the last device and we might need
-	 * to unregister the callback.
-	 */
 	rte_mcfg_mem_read_lock();
 
-	/* get group number */
-	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret < 0) {
-		EAL_LOG(WARNING, "%s not managed by VFIO driver",
-			dev_addr);
-		goto out;
-	}
-
-	/* get the actual group fd */
-	vfio_group_fd = vfio_get_group_fd_by_num(iommu_group_num);
-	if (vfio_group_fd < 0) {
-		EAL_LOG(INFO, "vfio_get_group_fd_by_num failed for %s", dev_addr);
-		ret = vfio_group_fd;
-		goto out;
-	}
+	switch (vfio_global_cfg.mode) {
+	case DEV_VFIO_MODE_GROUP:
+	{
+		int iommu_group_num;
 
-	/* get the vfio_container it belongs to */
-	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	cfg = cfg ? cfg : vfio_global_cfg.default_cfg;
+		/* find group number */
+		ret = vfio_group_get_num(sysfs_base, dev_addr, &iommu_group_num);
+		if (ret < 0)
+			goto assign_fail;
+		else if (ret == 0)
+			goto not_managed;
 
-	/* At this point we got an active group. Closing it will make the
-	 * container detachment. If this is the last active group, VFIO kernel
-	 * code will unset the container and the IOMMU mappings.
-	 */
+		/* find config by group */
+		cfg = vfio_container_get_by_group_num(iommu_group_num);
+		if (cfg == NULL)
+			cfg = vfio_global_cfg.default_cfg;
 
-	/* Closing a device */
-	if (close(vfio_dev_fd) < 0) {
-		EAL_LOG(INFO, "Error when closing vfio_dev_fd for %s",
-				   dev_addr);
+		res = vfio_group_assign_device(cfg, sysfs_base, dev_addr, &dev);
+		break;
+	}
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
 		ret = -1;
-		goto out;
+		goto unlock;
 	}
 
-	/* An VFIO group can have several devices attached. Just when there is
-	 * no devices remaining should the group be closed.
-	 */
-	vfio_group_device_put(vfio_group_fd);
-	if (!vfio_group_device_count(vfio_group_fd)) {
-
-		if (close(vfio_group_fd) < 0) {
-			EAL_LOG(INFO, "Error when closing vfio_group_fd for %s",
-				dev_addr);
-			ret = -1;
-			goto out;
-		}
-
-		if (vfio_clear_group(vfio_group_fd) < 0) {
-			EAL_LOG(INFO, "Error when clearing group for %s",
-					   dev_addr);
-			ret = -1;
-			goto out;
-		}
+	switch (res) {
+	case VFIO_NOT_MANAGED:
+not_managed:
+		EAL_LOG(DEBUG, "Device %s not managed by VFIO", dev_addr);
+		rte_errno = ENODEV;
+		ret = -1;
+		goto unlock;
+	case VFIO_SUCCESS:
+	case VFIO_EXISTS:
+		break;
+	case VFIO_NO_SPACE:
+		EAL_LOG(ERR, "No space in VFIO container to assign device %s", dev_addr);
+		rte_errno = ENOSPC;
+		ret = -1;
+		goto unlock;
+	case VFIO_NO_MEM:
+		EAL_LOG(ERR, "Memory allocation failed for device %s", dev_addr);
+		rte_errno = ENOMEM;
+		ret = -1;
+		goto unlock;
+	default:
+assign_fail:
+		EAL_LOG(ERR, "Error assigning device %s to container", dev_addr);
+		rte_errno = EIO;
+		ret = -1;
+		goto unlock;
 	}
-
-	/* if there are no active device groups, unregister the callback to
-	 * avoid spurious attempts to map/unmap memory from VFIO.
-	 */
-	if (cfg == vfio_global_cfg.default_cfg && cfg->vfio_active_groups == 0 &&
-			rte_eal_process_type() != RTE_PROC_SECONDARY)
-		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME,
-				NULL);
+	*vfio_dev_fd = dev->fd;
 
 	/* success */
 	ret = 0;
 
-out:
+unlock:
+	rte_mcfg_mem_read_unlock();
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_release_device)
+int
+dev_vfio_release_device(const char *sysfs_base __rte_unused, const char *dev_addr, int vfio_dev_fd)
+{
+	struct vfio_container *cfg = NULL, *icfg;
+	struct vfio_device *dev = NULL, *idev;
+	int ret;
+
+	if (sysfs_base == NULL || dev_addr == NULL) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	rte_mcfg_mem_read_lock();
+
+	/* we need to find both config and device */
+	VFIO_CONTAINER_FOREACH_ACTIVE(icfg) {
+		VFIO_DEVICE_FOREACH_ACTIVE(icfg, idev) {
+			if (idev->fd != vfio_dev_fd)
+				continue;
+			cfg = icfg;
+			dev = idev;
+			goto found;
+		}
+	}
+found:
+	if (dev == NULL) {
+		EAL_LOG(ERR, "Device %s not managed by any container", dev_addr);
+		rte_errno = ENOENT;
+		ret = -1;
+		goto unlock;
+	}
+
+	switch (vfio_global_cfg.mode) {
+	case DEV_VFIO_MODE_GROUP:
+	{
+		int iommu_group_num = dev->group;
+		struct vfio_group_config *group_cfg = &cfg->group_cfg;
+		struct vfio_group *grp;
+
+		bool need_clb = vfio_container_is_default(cfg) &&
+			rte_eal_process_type() == RTE_PROC_PRIMARY;
+
+		/* find the group */
+		grp = vfio_group_get_by_num(cfg, iommu_group_num);
+		if (grp == NULL) {
+			/* shouldn't happen because we already know the device is valid */
+			EAL_LOG(ERR, "IOMMU group %d not found in container", iommu_group_num);
+			rte_errno = EIO;
+			ret = -1;
+			goto unlock;
+		}
+
+		/* close device handle */
+		vfio_device_erase(cfg, dev);
+
+		/* remove device from group */
+		grp->n_devices--;
+
+		/* was this the last device? */
+		if (grp->n_devices == 0)
+			vfio_group_erase(cfg, grp);
+
+		/* if no more groups left, remove callback */
+		if (need_clb && group_cfg->n_groups == 0 && group_cfg->mem_event_clb_set) {
+			rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+			group_cfg->mem_event_clb_set = false;
+		}
+		break;
+	}
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
+		ret = -1;
+		goto unlock;
+	}
+	ret = 0;
+unlock:
 	rte_mcfg_mem_read_unlock();
+
 	return ret;
 }
 
+static int
+vfio_sync_mode(struct vfio_container *cfg, enum dev_vfio_mode *mode)
+{
+	struct vfio_mp_param *p;
+	struct rte_mp_msg mp_req = {0};
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {5, 0};
+
+	/* request container from primary via mp_sync */
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+	p = (struct vfio_mp_param *)mp_req.param;
+	p->req = VFIO_SOCKET_REQ_CONTAINER;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		struct rte_mp_msg *mp_rep = &mp_reply.msgs[0];
+
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
+			cfg->container_fd = mp_rep->fds[0];
+			*mode = p->mode;
+			free(mp_reply.msgs);
+			return 0;
+		}
+	}
+
+	free(mp_reply.msgs);
+	EAL_LOG(ERR, "Cannot request container_fd");
+	return -1;
+}
+
 static int
 vfio_sync_iova_mode(enum dev_vfio_iova_mode *iova_mode)
 {
@@ -1133,6 +1073,63 @@ vfio_sync_iova_mode(enum dev_vfio_iova_mode *iova_mode)
 	return -1;
 }
 
+static enum dev_vfio_mode
+vfio_select_mode(void)
+{
+	struct vfio_container *cfg;
+	enum dev_vfio_mode mode = DEV_VFIO_MODE_NONE;
+	enum dev_vfio_iova_mode iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
+
+	cfg = vfio_container_create();
+	/* cannot happen */
+	if (cfg == NULL || cfg != vfio_global_cfg.default_cfg) {
+		EAL_LOG(ERR, "Unexpected VFIO config structure");
+		return DEV_VFIO_MODE_NONE;
+	}
+
+	/* for secondary, just ask the primary for the container and mode */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		if (vfio_sync_mode(cfg, &mode) < 0 || vfio_sync_iova_mode(&iova_mode) < 0)
+			goto err;
+
+		/* primary handles DMA setup for default containers */
+		cfg->dma_setup_done = true;
+		vfio_global_cfg.iova_mode = iova_mode;
+		return mode;
+	}
+	/* if we failed mp sync setup, we cannot initialize VFIO */
+	if (vfio_mp_sync_setup() < 0)
+		return DEV_VFIO_MODE_NONE;
+
+	/* try group mode first */
+	if (vfio_group_enable(cfg) == 0) {
+		/* check for noiommu */
+		int ret = vfio_noiommu_is_enabled();
+		if (ret < 0)
+			goto err_mpsync;
+		vfio_global_cfg.iova_mode = ret == 1 ?
+				DEV_VFIO_IOVA_MODE_PA :
+				DEV_VFIO_IOVA_MODE_VA;
+		return DEV_VFIO_MODE_GROUP;
+	}
+err_mpsync:
+	vfio_mp_sync_cleanup();
+err:
+	vfio_container_erase(cfg);
+	vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
+
+	return DEV_VFIO_MODE_NONE;
+}
+
+static const char *
+vfio_mode_to_str(enum dev_vfio_mode mode)
+{
+	switch (mode) {
+	case DEV_VFIO_MODE_GROUP: return "group";
+	default: return "not initialized";
+	}
+}
+
 static const char *
 vfio_iova_mode_to_str(enum dev_vfio_iova_mode iova_mode)
 {
@@ -1147,30 +1144,13 @@ RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_enable)
 int
 dev_vfio_enable(void)
 {
-	/* initialize group list */
-	unsigned int i, j;
 	int vfio_available;
-	DIR *dir;
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
+	enum dev_vfio_mode mode = DEV_VFIO_MODE_NONE;
 
-	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
-
-	if (vfio_enabled)
+	/* if already enabled, nothing to do */
+	if (vfio_global_cfg.mode != DEV_VFIO_MODE_NONE)
 		return 0;
 
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		vfio_containers[i].container_fd = -1;
-		vfio_containers[i].vfio_active_groups = 0;
-		vfio_containers[i].mem_maps.lock = lock;
-
-		for (j = 0; j < RTE_DIM(vfio_containers[i].vfio_groups); j++) {
-			vfio_containers[i].vfio_groups[j].fd = -1;
-			vfio_containers[i].vfio_groups[j].group_num = -1;
-			vfio_containers[i].vfio_groups[j].devices = 0;
-		}
-	}
-
 	EAL_LOG(DEBUG, "Probing VFIO support...");
 
 	/* check if vfio module is loaded */
@@ -1184,56 +1164,20 @@ dev_vfio_enable(void)
 
 	/* return 0 if VFIO modules not loaded */
 	if (vfio_available == 0) {
-		EAL_LOG(DEBUG,
-			"VFIO modules not loaded, skipping VFIO support...");
+		EAL_LOG(DEBUG, "VFIO modules not loaded, skipping VFIO support...");
 		return 0;
 	}
+	EAL_LOG(DEBUG, "VFIO module 'vfio' loaded, attempting to initialize VFIO...");
+	mode = vfio_select_mode();
 
-	/* VFIO directory might not exist (e.g., unprivileged containers) */
-	dir = opendir(DEV_VFIO_DIR);
-	if (dir == NULL) {
-		EAL_LOG(DEBUG,
-			"VFIO directory does not exist, skipping VFIO support...");
-		return 0;
-	}
-	closedir(dir);
-
-	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
-		if (vfio_mp_sync_setup() == -1) {
-			vfio_global_cfg.default_cfg->container_fd = -1;
-		} else {
-			/* open a default container */
-			vfio_global_cfg.default_cfg->container_fd = vfio_open_container_fd(false);
-		}
-	} else {
-		/* get the default container from the primary process */
-		vfio_global_cfg.default_cfg->container_fd = vfio_open_container_fd(true);
-	}
-
-	/* check if we have VFIO driver enabled */
-	if (vfio_global_cfg.default_cfg->container_fd != -1) {
-		vfio_enabled = true;
-
-		if (internal_conf->process_type == RTE_PROC_PRIMARY) {
-			int ret = vfio_noiommu_is_enabled();
-			if (ret < 0) {
-				EAL_LOG(ERR, "Cannot determine IOVA mode");
-				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
-			} else if (ret == 1) {
-				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_PA;
-			} else {
-				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_VA;
-			}
-		} else {
-			if (vfio_sync_iova_mode(&vfio_global_cfg.iova_mode) < 0)
-				vfio_global_cfg.iova_mode = DEV_VFIO_IOVA_MODE_UNKNOWN;
-		}
-
-		EAL_LOG(NOTICE, "VFIO support initialized: IOVA as %s",
-			vfio_iova_mode_to_str(vfio_global_cfg.iova_mode));
-	} else {
+	/* have we initialized anything? */
+	if (mode == DEV_VFIO_MODE_NONE)
 		EAL_LOG(NOTICE, "VFIO support could not be initialized");
-	}
+	else
+		EAL_LOG(NOTICE, "VFIO support initialized: %s mode, IOVA as %s",
+			vfio_mode_to_str(mode), vfio_iova_mode_to_str(vfio_global_cfg.iova_mode));
+
+	vfio_global_cfg.mode = mode;
 
 	return 0;
 }
@@ -1249,15 +1193,12 @@ RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_is_enabled)
 int
 dev_vfio_is_enabled(void)
 {
-	return vfio_enabled;
+	return vfio_global_cfg.default_cfg->active;
 }
 
 int
 vfio_get_iommu_type(void)
 {
-	if (!vfio_enabled)
-		return -1;
-
 	if (vfio_global_cfg.ops == NULL)
 		return -1;
 
@@ -1275,96 +1216,22 @@ dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 		return -1;
 	}
 
-	if (!vfio_enabled)
-		return -1;
-
-	if (vfio_dev_fd < 0)
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
+	}
 
 	ret = ioctl(vfio_dev_fd, VFIO_DEVICE_GET_INFO, device_info);
 	if (ret) {
 		EAL_LOG(ERR, "Cannot get device info, error %i (%s)", errno, strerror(errno));
+		rte_errno = errno;
 		return -1;
 	}
 
 	return 0;
 }
 
-/*
- * Open a new VFIO container fd.
- *
- * If mp_request is true, requests a new container fd from the primary process
- * via mp channel (for secondary processes that need to open the default container).
- *
- * Otherwise, opens a new container fd locally by opening /dev/vfio/vfio.
- */
-int
-vfio_open_container_fd(bool mp_request)
-{
-	int ret, vfio_container_fd;
-	struct rte_mp_msg mp_req, *mp_rep;
-	struct rte_mp_reply mp_reply = {0};
-	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
-	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
-
-	/* if not requesting via mp, open a new container locally */
-	if (!mp_request) {
-		vfio_container_fd = open(DEV_VFIO_CONTAINER_PATH, O_RDWR);
-		if (vfio_container_fd < 0) {
-			EAL_LOG(ERR, "Cannot open VFIO container %s, error %i (%s)",
-				DEV_VFIO_CONTAINER_PATH, errno, strerror(errno));
-			return -1;
-		}
-
-		/* check VFIO API version */
-		ret = ioctl(vfio_container_fd, VFIO_GET_API_VERSION);
-		if (ret != VFIO_API_VERSION) {
-			if (ret < 0)
-				EAL_LOG(ERR,
-					"Could not get VFIO API version, error "
-					"%i (%s)", errno, strerror(errno));
-			else
-				EAL_LOG(ERR, "Unsupported VFIO API version!");
-			close(vfio_container_fd);
-			return -1;
-		}
-
-		ret = vfio_has_supported_extensions(vfio_container_fd);
-		if (ret) {
-			EAL_LOG(ERR,
-				"No supported IOMMU extensions found!");
-			close(vfio_container_fd);
-			return -1;
-		}
-
-		return vfio_container_fd;
-	}
-	/*
-	 * if we're in a secondary process, request container fd from the
-	 * primary process via mp channel
-	 */
-	p->req = VFIO_SOCKET_REQ_CONTAINER;
-	strcpy(mp_req.name, EAL_VFIO_MP);
-	mp_req.len_param = sizeof(*p);
-	mp_req.num_fds = 0;
-
-	vfio_container_fd = -1;
-	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 &&
-	    mp_reply.nb_received == 1) {
-		mp_rep = &mp_reply.msgs[0];
-		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
-			vfio_container_fd = mp_rep->fds[0];
-			free(mp_reply.msgs);
-			return vfio_container_fd;
-		}
-	}
-
-	free(mp_reply.msgs);
-	EAL_LOG(ERR, "Cannot request VFIO container fd");
-	return -1;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_container_fd)
 int
 dev_vfio_get_container_fd(void)
@@ -1373,19 +1240,18 @@ dev_vfio_get_container_fd(void)
 	 * The default container is set up during dev_vfio_enable().
 	 * This function does not create a new container.
 	 */
-	if (!vfio_enabled)
-		return -1;
+	if (vfio_global_cfg.mode != DEV_VFIO_MODE_NONE)
+		return vfio_global_cfg.default_cfg->container_fd;
 
-	return vfio_global_cfg.default_cfg->container_fd;
+	EAL_LOG(ERR, "VFIO support not initialized");
+	rte_errno = ENXIO;
+	return -1;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
 int
 dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num)
 {
-	char linkname[PATH_MAX];
-	char filename[PATH_MAX];
-	char *tok[16], *group_tok, *end;
 	int ret;
 
 	if (sysfs_base == NULL || dev_addr == NULL || iommu_group_num == NULL) {
@@ -1393,42 +1259,24 @@ dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
 		return -1;
 	}
 
-	if (!vfio_enabled)
-		return -1;
-
-	memset(linkname, 0, sizeof(linkname));
-	memset(filename, 0, sizeof(filename));
-
-	/* try to find out IOMMU group for this device */
-	snprintf(linkname, sizeof(linkname),
-			 "%s/%s/iommu_group", sysfs_base, dev_addr);
-
-	ret = readlink(linkname, filename, sizeof(filename));
-
-	/* if the link doesn't exist, no VFIO for us */
-	if (ret < 0) {
-		rte_errno = ENODEV;
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
-
-	ret = rte_strsplit(filename, sizeof(filename),
-			tok, RTE_DIM(tok), '/');
-
-	if (ret <= 0) {
-		EAL_LOG(ERR, "%s cannot get IOMMU group", dev_addr);
+	if (vfio_global_cfg.mode != DEV_VFIO_MODE_GROUP) {
+		EAL_LOG(ERR, "VFIO not initialized in group mode");
+		rte_errno = ENOTSUP;
 		return -1;
 	}
-
-	/* IOMMU group is always the last token */
-	errno = 0;
-	group_tok = tok[ret - 1];
-	end = group_tok;
-	*iommu_group_num = strtol(group_tok, &end, 10);
-	if ((end != group_tok && *end != '\0') || errno != 0) {
-		EAL_LOG(ERR, "%s error parsing IOMMU number!", dev_addr);
+	ret = vfio_group_get_num(sysfs_base, dev_addr, iommu_group_num);
+	if (ret < 0) {
+		rte_errno = EINVAL;
+		return -1;
+	} else if (ret == 0) {
+		rte_errno = ENODEV;
 		return -1;
 	}
-
 	return 0;
 }
 
@@ -1440,15 +1288,11 @@ vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint
 
 	if (!t) {
 		EAL_LOG(ERR, "VFIO support not initialized");
-		rte_errno = ENODEV;
 		return -1;
 	}
 
 	if (!t->dma_user_map_func) {
-		EAL_LOG(ERR,
-			"VFIO custom DMA region mapping not supported by IOMMU %s",
-			t->name);
-		rte_errno = ENOTSUP;
+		EAL_LOG(ERR, "VFIO custom DMA region mapping not supported by IOMMU %s", t->name);
 		return -1;
 	}
 
@@ -1467,7 +1311,6 @@ container_dma_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uin
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
 	if (user_mem_maps->n_maps == RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "No more space for user mem maps");
-		rte_errno = ENOMEM;
 		ret = -1;
 		goto out;
 	}
@@ -1532,12 +1375,11 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	 * the start and the end of our requested unmap. We need to collect all
 	 * maps that include our unmapped region.
 	 */
-	n_orig = find_user_mem_maps(user_mem_maps, vaddr, iova, len,
-			orig_maps, RTE_DIM(orig_maps));
+	n_orig = find_user_mem_maps(user_mem_maps, vaddr, iova, len, orig_maps,
+		RTE_DIM(orig_maps));
 	/* did we find anything? */
 	if (n_orig < 0) {
 		EAL_LOG(ERR, "Couldn't find previously mapped region");
-		rte_errno = EINVAL;
 		ret = -1;
 		goto out;
 	}
@@ -1552,14 +1394,11 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	if (!has_partial_unmap) {
 		bool start_aligned, end_aligned;
 
-		start_aligned = addr_is_chunk_aligned(orig_maps, n_orig,
-				vaddr, iova);
-		end_aligned = addr_is_chunk_aligned(orig_maps, n_orig,
-				vaddr + len, iova + len);
+		start_aligned = addr_is_chunk_aligned(orig_maps, n_orig, vaddr, iova);
+		end_aligned = addr_is_chunk_aligned(orig_maps, n_orig, vaddr + len, iova + len);
 
 		if (!start_aligned || !end_aligned) {
 			EAL_LOG(DEBUG, "DMA partial unmap unsupported");
-			rte_errno = ENOTSUP;
 			ret = -1;
 			goto out;
 		}
@@ -1577,7 +1416,6 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	newlen = (user_mem_maps->n_maps - n_orig) + n_new;
 	if (newlen >= RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "Not enough space to store partial mapping");
-		rte_errno = ENOMEM;
 		ret = -1;
 		goto out;
 	}
@@ -1585,20 +1423,13 @@ container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, u
 	/* unmap the entry */
 	if (vfio_dma_mem_map(cfg, vaddr, iova, len, 0)) {
 		/* there may not be any devices plugged in, so unmapping will
-		 * fail with ENODEV/ENOTSUP rte_errno values, but that doesn't
-		 * stop us from removing the mapping, as the assumption is we
-		 * won't be needing this memory any more and thus will want to
-		 * prevent it from being remapped again on hotplug. so, only
-		 * fail if we indeed failed to unmap (e.g. if the mapping was
-		 * within our mapped range but had invalid alignment).
+		 * fail, but that doesn't stop us from removing the mapping,
+		 * as the assumption is we won't be needing this memory any
+		 * more and thus will want to prevent it from being remapped
+		 * again on hotplug. Ignore the error and proceed with
+		 * removing the mapping from our records.
 		 */
-		if (rte_errno != ENODEV && rte_errno != ENOTSUP) {
-			EAL_LOG(ERR, "Couldn't unmap region for DMA");
-			ret = -1;
-			goto out;
-		} else {
-			EAL_LOG(DEBUG, "DMA unmapping failed, but removing mappings anyway");
-		}
+		EAL_LOG(DEBUG, "DMA unmapping failed, but removing mappings anyway");
 	}
 
 	/* we have unmapped the region, so now update the maps */
@@ -1614,30 +1445,42 @@ RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_create)
 int
 dev_vfio_container_create(void)
 {
-	unsigned int i;
+	struct vfio_container *cfg;
+	int container_fd;
 
-	if (!vfio_enabled)
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO not initialized");
+		rte_errno = ENXIO;
 		return -1;
-
-	/* Find an empty slot to store new vfio config */
-	for (i = 1; i < RTE_DIM(vfio_containers); i++) {
-		if (vfio_containers[i].container_fd == -1)
-			break;
 	}
-
-	if (i == RTE_DIM(vfio_containers)) {
-		EAL_LOG(ERR, "Exceed max VFIO container limit");
+	cfg = vfio_container_create();
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "Reached VFIO container limit");
+		rte_errno = ENOSPC;
 		return -1;
 	}
 
-	/* Create a new container fd */
-	vfio_containers[i].container_fd = vfio_open_container_fd(false);
-	if (vfio_containers[i].container_fd < 0) {
-		EAL_LOG(NOTICE, "Fail to create a new VFIO container");
-		return -1;
+	switch (vfio_global_cfg.mode) {
+	case DEV_VFIO_MODE_GROUP:
+	{
+		container_fd = vfio_group_open_container_fd();
+		if (container_fd < 0) {
+			EAL_LOG(ERR, "Fail to create a new VFIO container");
+			rte_errno = EIO;
+			goto err;
+		}
+		cfg->container_fd = container_fd;
+		break;
 	}
-
-	return vfio_containers[i].container_fd;
+	default:
+		EAL_LOG(NOTICE, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
+		goto err;
+	}
+	return container_fd;
+err:
+	vfio_container_erase(cfg);
+	return -1;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_destroy)
@@ -1645,218 +1488,133 @@ int
 dev_vfio_container_destroy(int container_fd)
 {
 	struct vfio_container *cfg;
-	unsigned int i;
-
-	if (!vfio_enabled)
-		return -1;
+	struct vfio_device *dev;
 
-	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD) {
-		EAL_LOG(ERR, "Cannot destroy default VFIO container");
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
 
-	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	cfg = vfio_container_get_by_fd(container_fd);
 	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
+		EAL_LOG(ERR, "VFIO container fd not managed by VFIO");
+		rte_errno = ENODEV;
 		return -1;
 	}
 
-	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
-		if (cfg->vfio_groups[i].group_num != -1)
-			vfio_container_group_unbind(container_fd,
-				cfg->vfio_groups[i].group_num);
-
-	close(container_fd);
-	cfg->container_fd = -1;
-	cfg->vfio_active_groups = 0;
-
-	return 0;
-}
-
-RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_assign_device)
-int
-dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
-		const char *dev_addr)
-{
-	int iommu_group_num;
-	int ret;
-
-	if (sysfs_base == NULL || dev_addr == NULL) {
+	/* forbid destroying default container */
+	if (vfio_container_is_default(cfg)) {
+		EAL_LOG(ERR, "Cannot destroy default VFIO container");
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	ret = dev_vfio_get_group_num(sysfs_base, dev_addr, &iommu_group_num);
-	if (ret < 0) {
-		EAL_LOG(ERR, "Cannot get IOMMU group number for device %s", dev_addr);
-		return -1;
-	}
-
-	ret = vfio_container_group_bind(vfio_container_fd, iommu_group_num);
-	if (ret < 0) {
-		EAL_LOG(ERR, "Cannot bind IOMMU group %d for device %s", iommu_group_num,
-			dev_addr);
-		return -1;
-	}
-
-	return 0;
-}
-
-static int
-vfio_container_group_bind(int container_fd, int iommu_group_num)
-{
-	struct vfio_container *cfg;
-
-	if (!vfio_enabled)
-		return -1;
-
-	cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
-		return -1;
-	}
-
-	return vfio_get_group_fd(cfg, iommu_group_num);
-}
-
-static int
-vfio_container_group_unbind(int container_fd, int iommu_group_num)
-{
-	struct vfio_group *cur_grp = NULL;
-	struct vfio_container *cfg;
-	unsigned int i;
-
-	if (!vfio_enabled)
-		return -1;
+	switch (vfio_global_cfg.mode) {
+	case DEV_VFIO_MODE_GROUP: {
+		struct vfio_group *grp;
 
-	cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
-		return -1;
-	}
+		/* erase all devices */
+		VFIO_DEVICE_FOREACH_ACTIVE(cfg, dev) {
+			EAL_LOG(DEBUG, "Device in IOMMU group %d still open, closing", dev->group);
+			/*
+			 * technically we could've done back-reference lookup and closed our groups
+			 * following a device close, but since we're closing and erasing all groups
+			 * anyway, we can afford to not bother.
+			 */
+			vfio_device_erase(cfg, dev);
+		}
 
-	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++) {
-		if (cfg->vfio_groups[i].group_num == iommu_group_num) {
-			cur_grp = &cfg->vfio_groups[i];
-			break;
+		/* erase all groups */
+		VFIO_GROUP_FOREACH_ACTIVE(cfg, grp) {
+			EAL_LOG(DEBUG, "IOMMU group %d still open, closing", grp->group_num);
+			vfio_group_erase(cfg, grp);
 		}
+		break;
 	}
-
-	/* This should not happen */
-	if (cur_grp == NULL) {
-		EAL_LOG(ERR, "Specified VFIO group number not found");
+	default:
+		EAL_LOG(ERR, "Unsupported VFIO mode");
+		rte_errno = ENOTSUP;
 		return -1;
 	}
 
-	if (cur_grp->fd >= 0 && close(cur_grp->fd) < 0) {
-		EAL_LOG(ERR,
-			"Error when closing vfio_group_fd for iommu_group_num "
-			"%d", iommu_group_num);
-		return -1;
-	}
-	cur_grp->group_num = -1;
-	cur_grp->fd = -1;
-	cur_grp->devices = 0;
-	cfg->vfio_active_groups--;
+	/* erase entire config */
+	vfio_container_erase(cfg);
 
 	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_map)
 int
-dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
 	struct vfio_container *cfg;
 
-	if (!vfio_enabled)
-		return -1;
-
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
+		return -1;
+	}
+
+	cfg = vfio_container_get_by_fd(container_fd);
 	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	if (container_dma_map(cfg, vaddr, iova, len) < 0) {
+		rte_errno = EIO;
 		return -1;
 	}
 
-	return container_dma_map(cfg, vaddr, iova, len);
+	return 0;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_unmap)
 int
-dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
 	struct vfio_container *cfg;
 
-	if (!vfio_enabled)
-		return -1;
-
 	if (len == 0) {
 		rte_errno = EINVAL;
 		return -1;
 	}
 
-	cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (cfg == NULL) {
-		EAL_LOG(ERR, "Invalid VFIO container fd");
+	if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE) {
+		EAL_LOG(ERR, "VFIO support not initialized");
+		rte_errno = ENXIO;
 		return -1;
 	}
 
-	return container_dma_unmap(cfg, vaddr, iova, len);
-}
-
-static int
-vfio_cleanup_config(struct vfio_container *cfg)
-{
-	unsigned int i;
-
-	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++) {
-		struct vfio_group *group = &cfg->vfio_groups[i];
-
-		if (group->group_num == -1)
-			continue;
-		if (group->devices != 0) {
-			EAL_LOG(ERR, "Cannot cleanup VFIO group %d with %d devices",
-				group->group_num, group->devices);
-			continue;
-		}
-		if (group->fd >= 0 && close(group->fd) < 0) {
-			EAL_LOG(ERR, "Cannot close VFIO group %d: %s",
-				group->group_num, strerror(errno));
-			continue;
-		}
-
-		group->group_num = -1;
-		group->fd = -1;
-		group->devices = 0;
-		cfg->vfio_active_groups--;
-	}
-
-	/* if there are still active groups, we cannot cleanup the container */
-	if (cfg->vfio_active_groups != 0) {
-		EAL_LOG(ERR, "Cannot cleanup VFIO container with %d active groups",
-			cfg->vfio_active_groups);
+	cfg = vfio_container_get_by_fd(container_fd);
+	if (cfg == NULL) {
+		EAL_LOG(ERR, "Invalid VFIO container fd");
+		rte_errno = EINVAL;
 		return -1;
 	}
 
-	if (cfg->container_fd >= 0 && close(cfg->container_fd) < 0) {
-		EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
+	if (container_dma_unmap(cfg, vaddr, iova, len) < 0) {
+		rte_errno = EIO;
 		return -1;
 	}
 
-	cfg->container_fd = -1;
-
-	cfg->mem_maps.n_maps = 0;
-	memset(cfg->mem_maps.maps, 0, sizeof(cfg->mem_maps.maps));
-
 	return 0;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_mode)
+enum dev_vfio_mode
+dev_vfio_get_mode(void)
+{
+	return vfio_global_cfg.mode;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_iova_mode)
 enum dev_vfio_iova_mode
 dev_vfio_get_iova_mode(void)
@@ -1868,27 +1626,26 @@ RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_cleanup)
 void
 dev_vfio_cleanup(void)
 {
-	unsigned int i;
-	bool stuck = false;
-
-	if (!vfio_enabled)
-		return;
+	struct vfio_container *cfg;
 
 	vfio_mp_sync_cleanup();
 
-	/* mem events can only be unregistered from the primary process */
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
-		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+	VFIO_CONTAINER_FOREACH_ACTIVE(cfg) {
+		struct vfio_group_config *group_cfg = &cfg->group_cfg;
+		struct vfio_device *dev;
+		struct vfio_group *grp;
 
-	/* cleanup all initialized configs */
-	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
-		if (vfio_containers[i].container_fd != -1)
-			stuck |= vfio_cleanup_config(&vfio_containers[i]) != 0;
-	}
+		VFIO_DEVICE_FOREACH_ACTIVE(cfg, dev)
+			vfio_device_erase(cfg, dev);
+		VFIO_GROUP_FOREACH_ACTIVE(cfg, grp)
+			vfio_group_erase(cfg, grp);
 
-	/* failed to deinitialize some configs, so don't set VFIO as disabled */
-	if (stuck)
-		return;
+		/* callback is only registered for the default container in the primary */
+		if (group_cfg->mem_event_clb_set) {
+			rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
+			group_cfg->mem_event_clb_set = false;
+		}
 
-	vfio_enabled = false;
+		vfio_container_erase(cfg);
+	}
 }
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index ce81526daf..080372a42f 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -6,6 +6,7 @@
 #define EAL_VFIO_H_
 
 #include <rte_common.h>
+#include <rte_spinlock.h>
 
 #include <stdint.h>
 
@@ -38,16 +39,39 @@ struct vfio_user_mem_maps {
  * the group fd via an ioctl() call.
  */
 struct vfio_group {
+	bool active;
 	int group_num;
 	int fd;
-	int devices;
+	int n_devices;
 };
 
+/* device tracking (common for group and cdev modes) */
+struct vfio_device {
+	bool active;
+	enum dev_vfio_mode mode;
+	int fd;
+	int group; /**< back-reference to group list */
+	char *sysfs_base; /**< sysfs path prefix */
+	char *dev_addr;   /**< device address */
+};
+
+/* group mode specific configuration */
+struct vfio_group_config {
+	bool iommu_type_set;
+	bool mem_event_clb_set;
+	size_t n_groups;
+	struct vfio_group groups[RTE_MAX_VFIO_GROUPS];
+};
+
+/* per-container configuration */
 struct vfio_container {
+	bool active;
+	bool dma_setup_done;
 	int container_fd;
-	int vfio_active_groups;
-	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
 	struct vfio_user_mem_maps mem_maps;
+	struct vfio_group_config group_cfg;
+	int n_devices;
+	struct vfio_device devices[RTE_MAX_VFIO_DEVICES];
 };
 
 /* DMA mapping function prototype.
@@ -64,6 +88,7 @@ typedef int (*vfio_dma_func_t)(struct vfio_container *cfg);
 typedef int (*vfio_dma_user_func_t)(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map);
 
+/* mode-independent ops */
 struct vfio_iommu_ops {
 	int type_id;
 	const char *name;
@@ -72,14 +97,10 @@ struct vfio_iommu_ops {
 	vfio_dma_func_t dma_map_func;
 };
 
-extern const struct vfio_iommu_ops iommu_types[3];
-
-/* get the vfio container that devices are bound to by default */
-int vfio_open_container_fd(bool mp_request);
-
 /* global configuration */
 struct vfio_config {
 	struct vfio_container *default_cfg;
+	enum dev_vfio_mode mode;
 	enum dev_vfio_iova_mode iova_mode;
 	const struct vfio_iommu_ops *ops;
 };
@@ -87,21 +108,42 @@ struct vfio_config {
 /* current configuration */
 extern struct vfio_config vfio_global_cfg;
 
-/* pick IOMMU type. returns a pointer to vfio_iommu_ops or NULL for error */
-const struct vfio_iommu_ops *
-vfio_set_iommu_type(int vfio_container_fd);
+#define VFIO_GROUP_FOREACH(cfg, grp) \
+	for ((grp) = &((cfg)->group_cfg.groups[0]); \
+		(grp) < &((cfg)->group_cfg.groups[RTE_DIM((cfg)->group_cfg.groups)]); \
+		(grp)++)
 
-int
-vfio_get_iommu_type(void);
+#define VFIO_GROUP_FOREACH_ACTIVE(cfg, grp) \
+	VFIO_GROUP_FOREACH((cfg), (grp)) \
+		if ((grp)->active)
 
-int vfio_get_group_fd_by_num(int iommu_group_num);
+#define VFIO_DEVICE_FOREACH(cfg, dev) \
+	for ((dev) = &((cfg)->devices[0]); \
+		(dev) < &((cfg)->devices[RTE_DIM((cfg)->devices)]); \
+		(dev)++)
 
-/* check if we have any supported extensions */
-int
-vfio_has_supported_extensions(int vfio_container_fd);
+#define VFIO_DEVICE_FOREACH_ACTIVE(cfg, dev) \
+	VFIO_DEVICE_FOREACH((cfg), (dev)) \
+		if ((dev)->active)
 
+int vfio_get_iommu_type(void);
 int vfio_mp_sync_setup(void);
 void vfio_mp_sync_cleanup(void);
+bool vfio_container_is_default(struct vfio_container *cfg);
+
+/* group mode functions */
+int vfio_group_enable(struct vfio_container *cfg);
+int vfio_group_open_container_fd(void);
+int vfio_group_get_num(const char *sysfs_base, const char *dev_addr,
+		int *iommu_group_num);
+struct vfio_group *vfio_group_get_by_num(struct vfio_container *cfg, int iommu_group);
+struct vfio_group *vfio_group_create(struct vfio_container *cfg, int iommu_group);
+void vfio_group_erase(struct vfio_container *cfg, struct vfio_group *grp);
+int vfio_group_open_fd(struct vfio_container *cfg, struct vfio_group *grp);
+int vfio_group_prepare(struct vfio_container *cfg, struct vfio_group *grp);
+int vfio_group_setup_iommu(struct vfio_container *cfg);
+int vfio_group_setup_device_fd(const char *dev_addr, struct vfio_group *grp,
+		struct vfio_device *dev);
 
 #define EAL_VFIO_MP "eal_vfio_mp_sync"
 
@@ -119,6 +161,7 @@ struct vfio_mp_param {
 	union {
 		int group_num;
 		int iommu_type_id;
+		enum dev_vfio_mode mode;
 		enum dev_vfio_iova_mode iova_mode;
 	};
 };
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
index e588cd3014..aef3e9f27a 100644
--- a/lib/eal/linux/eal_vfio_group.c
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -1,25 +1,31 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2010-2018 Intel Corporation
+ * Copyright(c) 2010-2025 Intel Corporation
  */
 
 #include <uapi/linux/vfio.h>
 
-#include <errno.h>
+#include <dirent.h>
+#include <fcntl.h>
 #include <inttypes.h>
 #include <stdbool.h>
-#include <stdio.h>
+#include <stdint.h>
 #include <stdlib.h>
-#include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#include <rte_common.h>
-#include <rte_errno.h>
 #include <rte_log.h>
+#include <rte_errno.h>
+#include <rte_eal_memconfig.h>
 #include <rte_memory.h>
+#include <rte_string_fns.h>
+#include <dev_vfio.h>
 
 #include "eal_vfio.h"
 #include "eal_private.h"
+#include "eal_internal_cfg.h"
+
+#define DEV_VFIO_DIR "/dev/vfio"
+#define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
 
 static int vfio_type1_dma_map(struct vfio_container *);
 static int vfio_type1_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
@@ -29,7 +35,7 @@ static int vfio_noiommu_dma_map(struct vfio_container *);
 static int vfio_noiommu_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
 
 /* IOMMU types we support */
-const struct vfio_iommu_ops iommu_types[] = {
+static const struct vfio_iommu_ops iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
 	{
 		.type_id = VFIO_TYPE1_IOMMU,
@@ -56,8 +62,8 @@ const struct vfio_iommu_ops iommu_types[] = {
 	},
 };
 
-const struct vfio_iommu_ops *
-vfio_set_iommu_type(int vfio_container_fd)
+static const struct vfio_iommu_ops *
+vfio_group_set_iommu_type(int vfio_container_fd)
 {
 	for (unsigned int idx = 0; idx < RTE_DIM(iommu_types); idx++) {
 		const struct vfio_iommu_ops *t = &iommu_types[idx];
@@ -134,7 +140,6 @@ vfio_type1_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova
 			EAL_LOG(ERR, "Unexpected size %"PRIu64
 				" of DMA remapping cleared instead of %"PRIu64,
 				(uint64_t)dma_unmap.size, len);
-			rte_errno = EIO;
 			return -1;
 		}
 	}
@@ -491,7 +496,175 @@ vfio_noiommu_dma_mem_map(struct vfio_container *cfg __rte_unused, uint64_t vaddr
 	return 0;
 }
 
+struct vfio_group *
+vfio_group_create(struct vfio_container *cfg, int iommu_group)
+{
+	struct vfio_group *grp;
+
+	if (cfg->group_cfg.n_groups >= RTE_DIM(cfg->group_cfg.groups)) {
+		EAL_LOG(ERR, "Cannot add more VFIO groups to container");
+		return NULL;
+	}
+	VFIO_GROUP_FOREACH(cfg, grp) {
+		if (grp->active)
+			continue;
+		cfg->group_cfg.n_groups++;
+		grp->active = true;
+		grp->group_num = iommu_group;
+		grp->fd = -1;
+		return grp;
+	}
+	/* should not happen */
+	return NULL;
+}
+
+void
+vfio_group_erase(struct vfio_container *cfg, struct vfio_group *grp)
+{
+	struct vfio_group_config *group_cfg = &cfg->group_cfg;
+
+	if (grp->fd >= 0 && close(grp->fd) < 0)
+		EAL_LOG(ERR, "Error when closing group fd %d", grp->fd);
+
+	*grp = (struct vfio_group){0};
+	group_cfg->n_groups--;
+
+	/* if this was the last group in config, erase IOMMU setup and unregister callback */
+	if (group_cfg->n_groups == 0) {
+		cfg->dma_setup_done = false;
+		group_cfg->iommu_type_set = false;
+	}
+}
+
+struct vfio_group *
+vfio_group_get_by_num(struct vfio_container *cfg, int iommu_group)
+{
+	struct vfio_group *grp;
+
+	VFIO_GROUP_FOREACH_ACTIVE(cfg, grp) {
+		if (grp->group_num == iommu_group)
+			return grp;
+	}
+	return NULL;
+}
+
+static int
+vfio_open_group_sysfs(int iommu_group_num)
+{
+	char filename[PATH_MAX];
+	int fd;
+
+	if (vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_VA)
+		snprintf(filename, sizeof(filename), DEV_VFIO_GROUP_FMT, iommu_group_num);
+	else if (vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_PA)
+		snprintf(filename, sizeof(filename), DEV_VFIO_NOIOMMU_GROUP_FMT, iommu_group_num);
+
+	/* reset errno before open to differentiate errors */
+	errno = 0;
+	fd = open(filename, O_RDWR);
+
+	/* we have to differentiate between failed open and non-existence */
+	if (errno == ENOENT)
+		return -ENOENT;
+	return fd;
+}
+
+static int
+vfio_group_request_fd(int iommu_group_num)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	int vfio_group_fd = -1;
+
+	p->req = VFIO_SOCKET_REQ_GROUP;
+	p->group_num = iommu_group_num;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
+			vfio_group_fd = mp_rep->fds[0];
+		} else if (p->result == VFIO_SOCKET_NO_FD) {
+			EAL_LOG(ERR, "Bad VFIO group fd");
+			vfio_group_fd = -ENOENT;
+		}
+	}
+
+	free(mp_reply.msgs);
+	return vfio_group_fd;
+}
+
 int
+vfio_group_open_fd(struct vfio_container *cfg, struct vfio_group *grp)
+{
+	int vfio_group_fd;
+
+	/* we make multiprocess request only in secondary processes for default config */
+	if ((rte_eal_process_type() != RTE_PROC_PRIMARY) && (vfio_container_is_default(cfg)))
+		vfio_group_fd = vfio_group_request_fd(grp->group_num);
+	else
+		vfio_group_fd = vfio_open_group_sysfs(grp->group_num);
+
+	/* pass the non-existence up the chain */
+	if (vfio_group_fd == -ENOENT)
+		return vfio_group_fd;
+	else if (vfio_group_fd < 0) {
+		EAL_LOG(ERR, "Failed to open VFIO group %d", grp->group_num);
+		return vfio_group_fd;
+	}
+	grp->fd = vfio_group_fd;
+	return 0;
+}
+
+static const struct vfio_iommu_ops *
+vfio_group_sync_iommu_ops(void)
+{
+	struct rte_mp_msg mp_req, *mp_rep;
+	struct rte_mp_reply mp_reply = {0};
+	struct timespec ts = {.tv_sec = 5, .tv_nsec = 0};
+	struct vfio_mp_param *p = (struct vfio_mp_param *)mp_req.param;
+	int iommu_type_id;
+	unsigned int i;
+
+	/* find default container's IOMMU type */
+	p->req = VFIO_SOCKET_REQ_IOMMU_TYPE;
+	rte_strscpy(mp_req.name, EAL_VFIO_MP, sizeof(mp_req.name));
+	mp_req.len_param = sizeof(*p);
+	mp_req.num_fds = 0;
+
+	iommu_type_id = -1;
+	if (rte_mp_request_sync(&mp_req, &mp_reply, &ts) == 0 && mp_reply.nb_received == 1) {
+		mp_rep = &mp_reply.msgs[0];
+		p = (struct vfio_mp_param *)mp_rep->param;
+		if (p->result == VFIO_SOCKET_OK)
+			iommu_type_id = p->iommu_type_id;
+	}
+	free(mp_reply.msgs);
+	if (iommu_type_id < 0) {
+		EAL_LOG(ERR, "Could not get IOMMU type from primary process");
+		return NULL;
+	}
+
+	/* we now have an fd for default container, as well as its IOMMU type.
+	 * now, set up default VFIO container config to match.
+	 */
+	for (i = 0; i < RTE_DIM(iommu_types); i++) {
+		const struct vfio_iommu_ops *t = &iommu_types[i];
+		if (t->type_id != iommu_type_id)
+			continue;
+
+		return t;
+	}
+	EAL_LOG(ERR, "Could not find IOMMU type id (%i)", iommu_type_id);
+	return NULL;
+}
+
+static int
 vfio_has_supported_extensions(int vfio_container_fd)
 {
 	unsigned int n_extensions = 0;
@@ -519,3 +692,232 @@ vfio_has_supported_extensions(int vfio_container_fd)
 
 	return 0;
 }
+
+int
+vfio_group_open_container_fd(void)
+{
+	int ret, vfio_container_fd;
+
+	vfio_container_fd = open(DEV_VFIO_CONTAINER_PATH, O_RDWR);
+	if (vfio_container_fd < 0) {
+		EAL_LOG(DEBUG, "Cannot open VFIO container %s, error %i (%s)",
+			DEV_VFIO_CONTAINER_PATH, errno, strerror(errno));
+		return -1;
+	}
+
+	/* check VFIO API version */
+	ret = ioctl(vfio_container_fd, VFIO_GET_API_VERSION);
+	if (ret != VFIO_API_VERSION) {
+		if (ret < 0)
+			EAL_LOG(DEBUG, "Could not get VFIO API version, error %i (%s)", errno,
+				strerror(errno));
+		else
+			EAL_LOG(DEBUG, "Unsupported VFIO API version!");
+		close(vfio_container_fd);
+		return -1;
+	}
+
+	ret = vfio_has_supported_extensions(vfio_container_fd);
+	if (ret) {
+		EAL_LOG(DEBUG, "No supported IOMMU extensions found!");
+		close(vfio_container_fd);
+		return -1;
+	}
+
+	return vfio_container_fd;
+}
+
+int
+vfio_group_enable(struct vfio_container *cfg)
+{
+	int container_fd;
+	DIR *dir;
+
+	/* VFIO directory might not exist (e.g., unprivileged containers) */
+	dir = opendir(DEV_VFIO_DIR);
+	if (dir == NULL) {
+		EAL_LOG(DEBUG, "VFIO directory does not exist, skipping VFIO group support...");
+		return 1;
+	}
+	closedir(dir);
+
+	/* open a default container */
+	container_fd = vfio_group_open_container_fd();
+	if (container_fd < 0)
+		return -1;
+
+	cfg->container_fd = container_fd;
+	return 0;
+}
+
+int
+vfio_group_prepare(struct vfio_container *cfg, struct vfio_group *grp)
+{
+	struct vfio_group_status group_status = {
+		.argsz = sizeof(group_status)};
+	int ret;
+
+	/*
+	 * We need to assign group to a container and check if it is viable, but there are cases
+	 * where we don't need to do that.
+	 *
+	 * For default container, we need to set up the group only in primary process, as secondary
+	 * process would have requested group fd over IPC, which implies it would have already been
+	 * set up by the primary.
+	 *
+	 * For custom containers, every process sets up its own groups.
+	 */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		EAL_LOG(DEBUG, "Skipping setup for VFIO group %d", grp->group_num);
+		return 0;
+	}
+
+	/* check if the group is viable */
+	ret = ioctl(grp->fd, VFIO_GROUP_GET_STATUS, &group_status);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get VFIO group status for group %d, error %i (%s)",
+			grp->group_num, errno, strerror(errno));
+		return -1;
+	}
+
+	if ((group_status.flags & VFIO_GROUP_FLAGS_VIABLE) == 0) {
+		EAL_LOG(ERR, "VFIO group %d is not viable! "
+			"Not all devices in IOMMU group bound to VFIO or unbound",
+			grp->group_num);
+		return -1;
+	}
+
+	/* set container for group if necessary */
+	if ((group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET) == 0) {
+		/* add group to a container */
+		ret = ioctl(grp->fd, VFIO_GROUP_SET_CONTAINER, &cfg->container_fd);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot add VFIO group %d to container, error %i (%s)",
+				grp->group_num, errno, strerror(errno));
+			return -1;
+		}
+	} else {
+		/* group is already added to a container - this should not happen */
+		EAL_LOG(ERR, "VFIO group %d is already assigned to a container", grp->group_num);
+		return -1;
+	}
+	return 0;
+}
+
+int
+vfio_group_setup_iommu(struct vfio_container *cfg)
+{
+	const struct vfio_iommu_ops *ops;
+
+	/*
+	 * Setting IOMMU type is a per-container operation (via ioctl on container fd), but the ops
+	 * structure is global and shared across all containers.
+	 *
+	 * For secondary processes with default container, we sync ops from primary. For all other
+	 * cases (primary, or secondary with custom containers), we set IOMMU type on the container
+	 * which also discovers the ops.
+	 */
+	if (vfio_container_is_default(cfg) && rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		/* Secondary process: sync ops from primary for default container */
+		ops = vfio_group_sync_iommu_ops();
+		if (ops == NULL)
+			return -1;
+	} else {
+		/* Primary process OR custom container: set IOMMU type on container */
+		ops = vfio_group_set_iommu_type(cfg->container_fd);
+		if (ops == NULL)
+			return -1;
+	}
+
+	/* Set or verify global ops */
+	if (vfio_global_cfg.ops == NULL) {
+		vfio_global_cfg.ops = ops;
+		EAL_LOG(INFO, "IOMMU type set to %d (%s)", ops->type_id, ops->name);
+	} else if (vfio_global_cfg.ops != ops) {
+		/* This shouldn't happen on the same machine, but log it */
+		EAL_LOG(WARNING, "Container has different IOMMU type (%d - %s) "
+			"than previously set (%d - %s)",
+			ops->type_id, ops->name, vfio_global_cfg.ops->type_id,
+			vfio_global_cfg.ops->name);
+	}
+
+	return 0;
+}
+
+int
+vfio_group_setup_device_fd(const char *dev_addr, struct vfio_group *grp, struct vfio_device *dev)
+{
+	rte_uuid_t vf_token;
+	int fd;
+
+	rte_eal_vfio_get_vf_token(vf_token);
+
+	if (!rte_uuid_is_null(vf_token)) {
+		char vf_token_str[RTE_UUID_STRLEN];
+		char devaddr[PATH_MAX];
+
+		rte_uuid_unparse(vf_token, vf_token_str, sizeof(vf_token_str));
+		snprintf(devaddr, sizeof(devaddr), "%s vf_token=%s", dev_addr, vf_token_str);
+
+		fd = ioctl(grp->fd, VFIO_GROUP_GET_DEVICE_FD, devaddr);
+		if (fd >= 0)
+			goto out;
+	}
+	/* get a file descriptor for the device */
+	fd = ioctl(grp->fd, VFIO_GROUP_GET_DEVICE_FD, dev_addr);
+	if (fd < 0) {
+		/*
+		 * if we cannot get a device fd, this implies a problem with the VFIO group or the
+		 * container not having IOMMU configured.
+		 */
+		EAL_LOG(WARNING, "Getting a vfio_dev_fd for %s failed", dev_addr);
+		return -1;
+	}
+out:
+	dev->fd = fd;
+	/* store backreference to group */
+	dev->group = grp->group_num;
+	/* increment number of devices in group */
+	grp->n_devices++;
+	return 0;
+}
+
+int
+vfio_group_get_num(const char *sysfs_base, const char *dev_addr, int *iommu_group_num)
+{
+	char linkname[PATH_MAX];
+	char filename[PATH_MAX];
+	char *tok[16], *group_tok, *end;
+	int ret, group_num;
+
+	memset(linkname, 0, sizeof(linkname));
+	memset(filename, 0, sizeof(filename));
+
+	/* try to find out IOMMU group for this device */
+	snprintf(linkname, sizeof(linkname), "%s/%s/iommu_group", sysfs_base, dev_addr);
+
+	ret = readlink(linkname, filename, sizeof(filename));
+
+	/* if the link doesn't exist, no VFIO for us */
+	if (ret < 0)
+		return 0;
+
+	ret = rte_strsplit(filename, sizeof(filename), tok, RTE_DIM(tok), '/');
+	if (ret <= 0) {
+		EAL_LOG(ERR, "%s cannot get IOMMU group", dev_addr);
+		return -1;
+	}
+
+	/* IOMMU group is always the last token */
+	errno = 0;
+	group_tok = tok[ret - 1];
+	end = group_tok;
+	group_num = strtol(group_tok, &end, 10);
+	if (end == group_tok || *end != '\0' || errno != 0) {
+		EAL_LOG(ERR, "%s error parsing IOMMU number!", dev_addr);
+		return -1;
+	}
+	*iommu_group_num = group_num;
+
+	return 1;
+}
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index aa90ab7bd0..e079c11dbf 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -32,21 +32,31 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 
 	switch (m->req) {
 	case VFIO_SOCKET_REQ_GROUP:
+	{
+		struct vfio_container *cfg = vfio_global_cfg.default_cfg;
+		struct vfio_group *grp;
+
+		if (vfio_global_cfg.mode != DEV_VFIO_MODE_GROUP) {
+			EAL_LOG(ERR, "VFIO not initialized in group mode");
+			r->result = VFIO_SOCKET_ERR;
+			break;
+		}
+
 		r->req = VFIO_SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
-		fd = vfio_get_group_fd_by_num(m->group_num);
-		if (fd < 0 && fd != -ENOENT)
-			r->result = VFIO_SOCKET_ERR;
-		else if (fd == -ENOENT)
-			/* if VFIO group exists but isn't bound to VFIO driver */
+		grp = vfio_group_get_by_num(cfg, m->group_num);
+		if (grp == NULL) {
+			/* group doesn't exist in primary */
 			r->result = VFIO_SOCKET_NO_FD;
-		else {
-			/* if group exists and is bound to VFIO driver */
+		} else {
+			/* group exists and is bound to VFIO driver */
+			fd = grp->fd;
 			r->result = VFIO_SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
 		break;
+	}
 	case VFIO_SOCKET_REQ_CONTAINER:
 		r->req = VFIO_SOCKET_REQ_CONTAINER;
 		fd = dev_vfio_get_container_fd();
@@ -54,6 +64,7 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 			r->result = VFIO_SOCKET_ERR;
 		else {
 			r->result = VFIO_SOCKET_OK;
+			r->mode = vfio_global_cfg.mode;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
@@ -62,6 +73,12 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	{
 		int iommu_type_id;
 
+		if (vfio_global_cfg.mode != DEV_VFIO_MODE_GROUP) {
+			EAL_LOG(ERR, "VFIO not initialized in group mode");
+			r->result = VFIO_SOCKET_ERR;
+			break;
+		}
+
 		r->req = VFIO_SOCKET_REQ_IOMMU_TYPE;
 
 		iommu_type_id = vfio_get_iommu_type();
@@ -75,6 +92,13 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 		break;
 	}
 	case VFIO_SOCKET_REQ_IOVA_MODE:
+		if (vfio_global_cfg.mode == DEV_VFIO_MODE_NONE ||
+				vfio_global_cfg.iova_mode == DEV_VFIO_IOVA_MODE_UNKNOWN) {
+			EAL_LOG(ERR, "VFIO IOVA mode is not initialized");
+			r->result = VFIO_SOCKET_ERR;
+			break;
+		}
+
 		r->req = VFIO_SOCKET_REQ_IOVA_MODE;
 		r->iova_mode = vfio_global_cfg.iova_mode;
 		r->result = VFIO_SOCKET_OK;
@@ -95,8 +119,11 @@ vfio_mp_sync_setup(void)
 {
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		int ret = rte_mp_action_register(EAL_VFIO_MP, vfio_mp_primary);
-		if (ret && rte_errno != ENOTSUP)
+		if (ret && rte_errno != ENOTSUP) {
+			EAL_LOG(ERR, "Multiprocess sync setup failed: %d (%s)",
+					rte_errno, rte_strerror(rte_errno));
 			return -1;
+		}
 	}
 
 	return 0;
diff --git a/lib/eal/linux/include/dev_vfio.h b/lib/eal/linux/include/dev_vfio.h
index f3ce665366..afc4213815 100644
--- a/lib/eal/linux/include/dev_vfio.h
+++ b/lib/eal/linux/include/dev_vfio.h
@@ -18,15 +18,14 @@
 #include <stdint.h>
 
 #include <rte_compat.h>
+#include <rte_common.h>
 
 #ifdef __cplusplus
 extern "C" {
 #endif
 
-#define DEV_VFIO_DIR "/dev/vfio"
 #define DEV_VFIO_CONTAINER_PATH "/dev/vfio/vfio"
 #define DEV_VFIO_GROUP_FMT "/dev/vfio/%u"
-#define DEV_VFIO_NOIOMMU_GROUP_FMT "/dev/vfio/noiommu-%u"
 
 /* we don't need an actual definition, only pointer is used */
 struct vfio_device_info;
@@ -44,6 +43,20 @@ enum dev_vfio_module {
 	DEV_VFIO_MODULE_VFIO_PCI, /**< VFIO PCI module. */
 };
 
+/**
+ * @enum dev_vfio_mode
+ * Enumeration of VFIO operational modes.
+ *
+ * These modes define how VFIO devices are accessed.
+ *
+ * - DEV_VFIO_MODE_NONE: VFIO is not enabled.
+ * - DEV_VFIO_MODE_GROUP: Legacy group mode.
+ */
+enum dev_vfio_mode {
+	DEV_VFIO_MODE_NONE = 0, /**< VFIO not enabled */
+	DEV_VFIO_MODE_GROUP,    /**< Group mode */
+};
+
 /**
  * @enum dev_vfio_iova_mode
  * IOVA modes.
@@ -79,7 +92,13 @@ enum dev_vfio_iova_mode {
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - ENOSPC  - No space in VFIO container to track the device.
  * - EINVAL  - Invalid parameters.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
+ * - ENOMEM  - Memory allocation failed for device tracking.
  */
 __rte_internal
 int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_dev_fd);
@@ -88,6 +107,10 @@ int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfi
  * @internal
  * Release a device managed by VFIO driver.
  *
+ * @note As a result of this function, all internal resources used by the device will be released,
+ *       so if the device was using a non-default container, it will need to be reassigned to the
+ *       container before it can be used again.
+ *
  * @param sysfs_base
  *   Sysfs path prefix.
  * @param dev_addr
@@ -100,7 +123,11 @@ int dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfi
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - ENOENT  - Device not found in any container.
  * - EINVAL  - Invalid parameters.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd);
@@ -109,9 +136,16 @@ int dev_vfio_release_device(const char *sysfs_base, const char *dev_addr, int fd
  * @internal
  * Initialize VFIO.
  *
+ * In case of success, `dev_vfio_get_mode()` can be used to retrieve the VFIO mode in use.
+ *
  * @return
  *   0 on success.
- *   <0 on failure.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Operation not supported.
  */
 __rte_internal
 int dev_vfio_enable(void);
@@ -148,6 +182,16 @@ int dev_vfio_module_is_loaded(enum dev_vfio_module module);
 __rte_internal
 int dev_vfio_is_enabled(void);
 
+/**
+ * @internal
+ * Get current VFIO mode.
+ *
+ *   VFIO mode currently in use.
+ */
+__rte_internal
+enum dev_vfio_mode
+dev_vfio_get_mode(void);
+
 /**
  * @internal
  * Get current VFIO IOVA mode.
@@ -175,7 +219,10 @@ dev_vfio_get_iova_mode(void);
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
  * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -200,6 +247,8 @@ dev_vfio_get_group_num(const char *sysfs_base, const char *dev_addr, int *iommu_
  *
  * Possible rte_errno values include:
  * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -207,11 +256,15 @@ dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info);
 
 /**
  * @internal
- * Get the default VFIO container fd
+ * Get the default VFIO container file descriptor.
  *
  * @return
- *  > 0 default container fd
- *  < 0 if VFIO is not enabled or not supported
+ *   Non-negative container file descriptor on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -219,7 +272,7 @@ dev_vfio_get_container_fd(void);
 
 /**
  * @internal
- * Create a new container for device binding.
+ * Create a new VFIO container for device assignment and DMA mapping.
  *
  * @note Any newly allocated DPDK memory will not be mapped into these
  *       containers by default, user needs to manage DMA mappings for
@@ -230,8 +283,14 @@ dev_vfio_get_container_fd(void);
  *       devices between multiple processes is not supported.
  *
  * @return
- *   the container fd if successful
- *   <0 if failed
+ *   Non-negative container file descriptor on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENOSPC  - Maximum number of containers reached.
+ * - EIO     - Underlying VFIO operation failed.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -239,14 +298,20 @@ dev_vfio_container_create(void);
 
 /**
  * @internal
- * Destroy the container, unbind all vfio groups within it.
+ * Destroy a VFIO container and unmap all devices assigned to it.
  *
  * @param container_fd
- *   the container fd to destroy
+ *   File descriptor of container to destroy.
  *
  * @return
- *    0 if successful
- *   <0 if failed
+ *   0 on success.
+ *   <0 on failure, rte_errno is set.
+ *
+ * Possible rte_errno values include:
+ * - ENODEV  - Container not managed by VFIO.
+ * - EINVAL  - Invalid container file descriptor.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -272,7 +337,14 @@ dev_vfio_container_destroy(int container_fd);
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - ENODEV  - Device not managed by VFIO.
+ * - EEXIST  - Device already assigned to the container.
+ * - ENOSPC  - No space in VFIO container to assign device.
  * - EINVAL  - Invalid container file descriptor.
+ * - EIO     - Error during underlying VFIO operations.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
+ * - ENOMEM  - Memory allocation failed for device tracking.
  */
 __rte_internal
 int
@@ -297,7 +369,10 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - EIO     - DMA mapping operation failed.
  * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
@@ -321,7 +396,10 @@ dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova, uint
  *   <0 on failure, rte_errno is set.
  *
  * Possible rte_errno values include:
+ * - EIO     - DMA unmapping operation failed.
  * - EINVAL  - Invalid parameters.
+ * - ENXIO   - VFIO support not initialized.
+ * - ENOTSUP - Unsupported VFIO mode.
  */
 __rte_internal
 int
-- 
2.54.0

