Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EF1CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50AA842EBE;
	Wed,  7 Oct 2026 10:11:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id BBE3942EBE
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDT+fUILQvU1qLhYQjaOFyLiKxj3mUNRhtrzWjTixvI=;
 b=HNtl3Xjm5h+KsG2NB7o3kDUX4qzR8y28vufvREgHLKtCJXoNT4IVO6MiaGPDdR4pgb2RaO
 TS97aCrwW6VQZjJHf8IIZfnovhkgmHu8c8V5B8ZwhtkKJfpoBpSLhGSM/m1BuUvSATRwPk
 QYB2IAJS4yJGLAdL/16Wn5/mnM3Gmow=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-0puJ__jSO1ysiUYt2BOfMg-1; Wed,
 07 Oct 2026 04:11:48 -0400
X-MC-Unique: 0puJ__jSO1ysiUYt2BOfMg-1
X-Mimecast-MFC-AGG-ID: 0puJ__jSO1ysiUYt2BOfMg_1791360707
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 471D4197730A; Wed,  7 Oct 2026 08:11:47 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74F3D1800446; Wed,  7 Oct 2026 08:11:46 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 20/26] vfio: separate group-based IOMMU types
Date: Wed,  7 Oct 2026 10:10:17 +0200
Message-ID: <20261007081026.574382-21-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KvZLYNvyzG-LhZGa8OETJm9kMBMmquVTJQxrnuIYifc_1791360707
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

Move group-based IOMMU types to a new file.

Notes:
- vfio_has_supported_extensions won't close vfio_container_fd anymore,
  this is consolidated in its caller,
- as we switched to an imported uapi header for VFIO some time ago,
  there is no need to check VFIO_IOMMU_SPAPR_INFO_DDW anymore,

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_vfio.c       | 524 +--------------------------------
 lib/eal/linux/eal_vfio.h       |   2 +
 lib/eal/linux/eal_vfio_group.c | 521 ++++++++++++++++++++++++++++++++
 lib/eal/linux/meson.build      |   1 +
 4 files changed, 525 insertions(+), 523 deletions(-)
 create mode 100644 lib/eal/linux/eal_vfio_group.c

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 7ad8a22cbb..bd267d1796 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -81,46 +81,12 @@ vfio_check_module(enum dev_vfio_module module)
 	return 1;
 }
 
-static int vfio_type1_dma_map(struct vfio_container *);
-static int vfio_type1_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
-static int vfio_spapr_dma_map(struct vfio_container *);
-static int vfio_spapr_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
-static int vfio_noiommu_dma_map(struct vfio_container *);
-static int vfio_noiommu_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
 static int vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map);
 
 static int vfio_container_group_bind(int container_fd, int iommu_group_num);
 static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
 
-/* IOMMU types we support */
-static const struct vfio_iommu_ops iommu_types[] = {
-	/* x86 IOMMU, otherwise known as type 1 */
-	{
-		.type_id = VFIO_TYPE1_IOMMU,
-		.name = "Type 1",
-		.partial_unmap = false,
-		.dma_map_func = &vfio_type1_dma_map,
-		.dma_user_map_func = &vfio_type1_dma_mem_map
-	},
-	/* ppc64 IOMMU, otherwise known as spapr */
-	{
-		.type_id = VFIO_SPAPR_TCE_v2_IOMMU,
-		.name = "sPAPR",
-		.partial_unmap = true,
-		.dma_map_func = &vfio_spapr_dma_map,
-		.dma_user_map_func = &vfio_spapr_dma_mem_map
-	},
-	/* IOMMU-less mode */
-	{
-		.type_id = VFIO_NOIOMMU_IOMMU,
-		.name = "No-IOMMU",
-		.partial_unmap = true,
-		.dma_map_func = &vfio_noiommu_dma_map,
-		.dma_user_map_func = &vfio_noiommu_dma_mem_map
-	},
-};
-
 static int
 is_null_map(const struct vfio_user_mem_map *map)
 {
@@ -1205,29 +1171,6 @@ vfio_get_iommu_type(void)
 	return vfio_global_cfg.ops->type_id;
 }
 
-const struct vfio_iommu_ops *
-vfio_set_iommu_type(int vfio_container_fd)
-{
-	unsigned idx;
-	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_ops *t = &iommu_types[idx];
-
-		int ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU,
-				t->type_id);
-		if (!ret) {
-			EAL_LOG(INFO, "Using IOMMU type %d (%s)",
-					t->type_id, t->name);
-			return t;
-		}
-		/* not an error, there may be more supported IOMMU types */
-		EAL_LOG(DEBUG, "Set IOMMU type %d (%s) failed, error "
-				"%i (%s)", t->type_id, t->name, errno,
-				strerror(errno));
-	}
-	/* if we didn't find a suitable IOMMU type, fail */
-	return NULL;
-}
-
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_device_info)
 int
 dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
@@ -1249,39 +1192,6 @@ dev_vfio_get_device_info(int vfio_dev_fd, struct vfio_device_info *device_info)
 	return 0;
 }
 
-int
-vfio_has_supported_extensions(int vfio_container_fd)
-{
-	int ret;
-	unsigned idx, n_extensions = 0;
-	for (idx = 0; idx < RTE_DIM(iommu_types); idx++) {
-		const struct vfio_iommu_ops *t = &iommu_types[idx];
-
-		ret = ioctl(vfio_container_fd, VFIO_CHECK_EXTENSION,
-				t->type_id);
-		if (ret < 0) {
-			EAL_LOG(ERR, "Could not get IOMMU type, error "
-					"%i (%s)", errno, strerror(errno));
-			close(vfio_container_fd);
-			return -1;
-		} else if (ret == 1) {
-			/* we found a supported extension */
-			n_extensions++;
-		}
-		EAL_LOG(DEBUG, "IOMMU type %d (%s) is %s",
-				t->type_id, t->name,
-				ret ? "supported" : "not supported");
-	}
-
-	/* if we didn't find any supported IOMMU types, fail */
-	if (!n_extensions) {
-		close(vfio_container_fd);
-		return -1;
-	}
-
-	return 0;
-}
-
 /*
  * Open a new VFIO container fd.
  *
@@ -1325,6 +1235,7 @@ vfio_open_container_fd(bool mp_request)
 		if (ret) {
 			EAL_LOG(ERR,
 				"No supported IOMMU extensions found!");
+			close(vfio_container_fd);
 			return -1;
 		}
 
@@ -1417,439 +1328,6 @@ dev_vfio_get_group_num(const char *sysfs_base,
 	return 1;
 }
 
-static int
-type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
-{
-	struct vfio_container *cfg = arg;
-
-	/* skip external memory that isn't a heap */
-	if (msl->external && !msl->heap)
-		return 0;
-
-	/* skip any segments with invalid IOVA addresses */
-	if (ms->iova == RTE_BAD_IOVA)
-		return 0;
-
-	return vfio_type1_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
-}
-
-static int
-vfio_type1_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
-		int do_map)
-{
-	struct vfio_iommu_type1_dma_map dma_map;
-	struct vfio_iommu_type1_dma_unmap dma_unmap;
-	int ret;
-
-	if (do_map != 0) {
-		memset(&dma_map, 0, sizeof(dma_map));
-		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
-		dma_map.vaddr = vaddr;
-		dma_map.size = len;
-		dma_map.iova = iova;
-		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
-				VFIO_DMA_MAP_FLAG_WRITE;
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
-		if (ret) {
-			/**
-			 * In case the mapping was already done EEXIST will be
-			 * returned from kernel.
-			 */
-			if (errno == EEXIST) {
-				EAL_LOG(DEBUG,
-					"Memory segment is already mapped, skipping");
-			} else {
-				EAL_LOG(ERR,
-					"Cannot set up DMA remapping, error "
-					"%i (%s)", errno, strerror(errno));
-				return -1;
-			}
-		}
-	} else {
-		memset(&dma_unmap, 0, sizeof(dma_unmap));
-		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
-		dma_unmap.size = len;
-		dma_unmap.iova = iova;
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot clear DMA remapping, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		} else if (dma_unmap.size != len) {
-			EAL_LOG(ERR, "Unexpected size %"PRIu64
-				" of DMA remapping cleared instead of %"PRIu64,
-				(uint64_t)dma_unmap.size, len);
-			rte_errno = EIO;
-			return -1;
-		}
-	}
-
-	return 0;
-}
-
-static int
-vfio_type1_dma_map(struct vfio_container *cfg)
-{
-	return rte_memseg_walk(type1_map, cfg);
-}
-
-/* Track the size of the statically allocated DMA window for SPAPR */
-uint64_t spapr_dma_win_len;
-uint64_t spapr_dma_win_page_sz;
-
-static int
-vfio_spapr_dma_do_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
-		int do_map)
-{
-	struct vfio_iommu_spapr_register_memory reg = {
-		.argsz = sizeof(reg),
-		.vaddr = (uintptr_t) vaddr,
-		.size = len,
-		.flags = 0
-	};
-	int ret;
-
-	if (do_map != 0) {
-		struct vfio_iommu_type1_dma_map dma_map;
-
-		if (iova + len > spapr_dma_win_len) {
-			EAL_LOG(ERR, "DMA map attempt outside DMA window");
-			return -1;
-		}
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
-		if (ret) {
-			EAL_LOG(ERR,
-				"Cannot register vaddr for IOMMU, error "
-				"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-		memset(&dma_map, 0, sizeof(dma_map));
-		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
-		dma_map.vaddr = vaddr;
-		dma_map.size = len;
-		dma_map.iova = iova;
-		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
-				VFIO_DMA_MAP_FLAG_WRITE;
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot map vaddr for IOMMU, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-	} else {
-		struct vfio_iommu_type1_dma_map dma_unmap;
-
-		memset(&dma_unmap, 0, sizeof(dma_unmap));
-		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
-		dma_unmap.size = len;
-		dma_unmap.iova = iova;
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
-		if (ret) {
-			EAL_LOG(ERR, "Cannot unmap vaddr for IOMMU, error "
-					"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-
-		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
-		if (ret) {
-			EAL_LOG(ERR,
-				"Cannot unregister vaddr for IOMMU, error "
-				"%i (%s)", errno, strerror(errno));
-			return -1;
-		}
-	}
-
-	return ret;
-}
-
-static int
-vfio_spapr_map_walk(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
-{
-	struct vfio_container *cfg = arg;
-
-	/* skip external memory that isn't a heap */
-	if (msl->external && !msl->heap)
-		return 0;
-
-	/* skip any segments with invalid IOVA addresses */
-	if (ms->iova == RTE_BAD_IOVA)
-		return 0;
-
-	return vfio_spapr_dma_do_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
-}
-
-struct spapr_size_walk_param {
-	uint64_t max_va;
-	uint64_t page_sz;
-	bool is_user_managed;
-};
-
-/*
- * In order to set the DMA window size required for the SPAPR IOMMU
- * we need to walk the existing virtual memory allocations as well as
- * find the hugepage size used.
- */
-static int
-vfio_spapr_size_walk(const struct rte_memseg_list *msl, void *arg)
-{
-	struct spapr_size_walk_param *param = arg;
-	uint64_t max = (uint64_t) msl->base_va + (uint64_t) msl->len;
-
-	if (msl->external && !msl->heap) {
-		/* ignore user managed external memory */
-		param->is_user_managed = true;
-		return 0;
-	}
-
-	if (max > param->max_va) {
-		param->page_sz = msl->page_sz;
-		param->max_va = max;
-	}
-
-	return 0;
-}
-
-/*
- * Find the highest memory address used in physical or virtual address
- * space and use that as the top of the DMA window.
- */
-static int
-find_highest_mem_addr(struct spapr_size_walk_param *param)
-{
-	/* find the maximum IOVA address for setting the DMA window size */
-	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
-		static const char proc_iomem[] = "/proc/iomem";
-		static const char str_sysram[] = "System RAM";
-		uint64_t start, end, max = 0;
-		char *line = NULL;
-		char *dash, *space;
-		size_t line_len;
-
-		/*
-		 * Example "System RAM" in /proc/iomem:
-		 * 00000000-1fffffffff : System RAM
-		 * 200000000000-201fffffffff : System RAM
-		 */
-		FILE *fd = fopen(proc_iomem, "r");
-		if (fd == NULL) {
-			EAL_LOG(ERR, "Cannot open %s", proc_iomem);
-			return -1;
-		}
-		/* Scan /proc/iomem for the highest PA in the system */
-		while (getline(&line, &line_len, fd) != -1) {
-			if (strstr(line, str_sysram) == NULL)
-				continue;
-
-			space = strstr(line, " ");
-			dash = strstr(line, "-");
-
-			/* Validate the format of the memory string */
-			if (space == NULL || dash == NULL || space < dash) {
-				EAL_LOG(ERR, "Can't parse line \"%s\" in file %s",
-					line, proc_iomem);
-				continue;
-			}
-
-			start = strtoull(line, NULL, 16);
-			end   = strtoull(dash + 1, NULL, 16);
-			EAL_LOG(DEBUG, "Found system RAM from 0x%" PRIx64
-				" to 0x%" PRIx64, start, end);
-			if (end > max)
-				max = end;
-		}
-		free(line);
-		fclose(fd);
-
-		if (max == 0) {
-			EAL_LOG(ERR, "Failed to find valid \"System RAM\" "
-				"entry in file %s", proc_iomem);
-			return -1;
-		}
-
-		spapr_dma_win_len = rte_align64pow2(max + 1);
-		return 0;
-	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
-		EAL_LOG(DEBUG, "Highest VA address in memseg list is 0x%"
-			PRIx64, param->max_va);
-		spapr_dma_win_len = rte_align64pow2(param->max_va);
-		return 0;
-	}
-
-	spapr_dma_win_len = 0;
-	EAL_LOG(ERR, "Unsupported IOVA mode");
-	return -1;
-}
-
-
-/*
- * The SPAPRv2 IOMMU supports 2 DMA windows with starting
- * address at 0 or 1<<59.  By default, a DMA window is set
- * at address 0, 2GB long, with a 4KB page.  For DPDK we
- * must remove the default window and setup a new DMA window
- * based on the hugepage size and memory requirements of
- * the application before we can map memory for DMA.
- */
-static int
-spapr_dma_win_size(void)
-{
-	struct spapr_size_walk_param param;
-
-	/* only create DMA window once */
-	if (spapr_dma_win_len > 0)
-		return 0;
-
-	/* walk the memseg list to find the page size/max VA address */
-	memset(&param, 0, sizeof(param));
-	if (rte_memseg_list_walk(vfio_spapr_size_walk, &param) < 0) {
-		EAL_LOG(ERR, "Failed to walk memseg list for DMA window size");
-		return -1;
-	}
-
-	/* we can't be sure if DMA window covers external memory */
-	if (param.is_user_managed)
-		EAL_LOG(WARNING, "Detected user managed external memory which may not be managed by the IOMMU");
-
-	/* check physical/virtual memory size */
-	if (find_highest_mem_addr(&param) < 0)
-		return -1;
-	EAL_LOG(DEBUG, "Setting DMA window size to 0x%" PRIx64,
-		spapr_dma_win_len);
-	spapr_dma_win_page_sz = param.page_sz;
-	rte_mem_set_dma_mask(rte_ctz64(spapr_dma_win_len));
-	return 0;
-}
-
-static int
-vfio_spapr_create_dma_window(struct vfio_container *cfg)
-{
-	struct vfio_iommu_spapr_tce_create create = {
-		.argsz = sizeof(create), };
-	struct vfio_iommu_spapr_tce_remove remove = {
-		.argsz = sizeof(remove), };
-	struct vfio_iommu_spapr_tce_info info = {
-		.argsz = sizeof(info), };
-	int ret;
-
-	ret = spapr_dma_win_size();
-	if (ret < 0)
-		return ret;
-
-	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
-	if (ret) {
-		EAL_LOG(ERR, "Cannot get IOMMU info, error %i (%s)",
-			errno, strerror(errno));
-		return -1;
-	}
-
-	/*
-	 * sPAPR v1/v2 IOMMU always has a default 1G DMA window set.  The window
-	 * can't be changed for v1 but it can be changed for v2. Since DPDK only
-	 * supports v2, remove the default DMA window so it can be resized.
-	 */
-	remove.start_addr = info.dma32_window_start;
-	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
-	if (ret)
-		return -1;
-
-	/* create a new DMA window (start address is not selectable) */
-	create.window_size = spapr_dma_win_len;
-	create.page_shift  = rte_ctz64(spapr_dma_win_page_sz);
-	create.levels = 1;
-	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-#ifdef VFIO_IOMMU_SPAPR_INFO_DDW
-	/*
-	 * The vfio_iommu_spapr_tce_info structure was modified in
-	 * Linux kernel 4.2.0 to add support for the
-	 * vfio_iommu_spapr_tce_ddw_info structure needed to try
-	 * multiple table levels.  Skip the attempt if running with
-	 * an older kernel.
-	 */
-	if (ret) {
-		/* if at first we don't succeed, try more levels */
-		uint32_t levels;
-
-		for (levels = create.levels + 1;
-			ret && levels <= info.ddw.levels; levels++) {
-			create.levels = levels;
-			ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-		}
-	}
-#endif /* VFIO_IOMMU_SPAPR_INFO_DDW */
-	if (ret) {
-		EAL_LOG(ERR, "Cannot create new DMA window, error "
-				"%i (%s)", errno, strerror(errno));
-		EAL_LOG(ERR,
-			"Consider using a larger hugepage size if supported by the system");
-		return -1;
-	}
-
-	/* verify the start address  */
-	if (create.start_addr != 0) {
-		EAL_LOG(ERR, "Received unsupported start address 0x%"
-			PRIx64, (uint64_t)create.start_addr);
-		return -1;
-	}
-	return ret;
-}
-
-static int
-vfio_spapr_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
-		int do_map)
-{
-	int ret = 0;
-
-	if (do_map) {
-		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 1)) {
-			EAL_LOG(ERR, "Failed to map DMA");
-			ret = -1;
-		}
-	} else {
-		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 0)) {
-			EAL_LOG(ERR, "Failed to unmap DMA");
-			ret = -1;
-		}
-	}
-
-	return ret;
-}
-
-static int
-vfio_spapr_dma_map(struct vfio_container *cfg)
-{
-	if (vfio_spapr_create_dma_window(cfg) < 0) {
-		EAL_LOG(ERR, "Could not create new DMA window!");
-		return -1;
-	}
-
-	/* map all existing DPDK segments for DMA */
-	if (rte_memseg_walk(vfio_spapr_map_walk, cfg) < 0)
-		return -1;
-
-	return 0;
-}
-
-static int
-vfio_noiommu_dma_map(struct vfio_container *cfg __rte_unused)
-{
-	/* No-IOMMU mode does not need DMA mapping */
-	return 0;
-}
-
-static int
-vfio_noiommu_dma_mem_map(struct vfio_container *cfg __rte_unused, uint64_t vaddr __rte_unused,
-		uint64_t iova __rte_unused, uint64_t len __rte_unused, int do_map __rte_unused)
-{
-	/* No-IOMMU mode does not need DMA mapping */
-	return 0;
-}
-
 static int
 vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
 		int do_map)
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 78b8ac4a36..5dae09b125 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -70,6 +70,8 @@ struct vfio_iommu_ops {
 	vfio_dma_func_t dma_map_func;
 };
 
+extern const struct vfio_iommu_ops iommu_types[3];
+
 /* get the vfio container that devices are bound to by default */
 int vfio_open_container_fd(bool mp_request);
 
diff --git a/lib/eal/linux/eal_vfio_group.c b/lib/eal/linux/eal_vfio_group.c
new file mode 100644
index 0000000000..e588cd3014
--- /dev/null
+++ b/lib/eal/linux/eal_vfio_group.c
@@ -0,0 +1,521 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2018 Intel Corporation
+ */
+
+#include <uapi/linux/vfio.h>
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <rte_common.h>
+#include <rte_errno.h>
+#include <rte_log.h>
+#include <rte_memory.h>
+
+#include "eal_vfio.h"
+#include "eal_private.h"
+
+static int vfio_type1_dma_map(struct vfio_container *);
+static int vfio_type1_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_spapr_dma_map(struct vfio_container *);
+static int vfio_spapr_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_noiommu_dma_map(struct vfio_container *);
+static int vfio_noiommu_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+
+/* IOMMU types we support */
+const struct vfio_iommu_ops iommu_types[] = {
+	/* x86 IOMMU, otherwise known as type 1 */
+	{
+		.type_id = VFIO_TYPE1_IOMMU,
+		.name = "Type 1",
+		.partial_unmap = false,
+		.dma_map_func = &vfio_type1_dma_map,
+		.dma_user_map_func = &vfio_type1_dma_mem_map
+	},
+	/* ppc64 IOMMU, otherwise known as spapr */
+	{
+		.type_id = VFIO_SPAPR_TCE_v2_IOMMU,
+		.name = "sPAPR",
+		.partial_unmap = true,
+		.dma_map_func = &vfio_spapr_dma_map,
+		.dma_user_map_func = &vfio_spapr_dma_mem_map
+	},
+	/* IOMMU-less mode */
+	{
+		.type_id = VFIO_NOIOMMU_IOMMU,
+		.name = "No-IOMMU",
+		.partial_unmap = true,
+		.dma_map_func = &vfio_noiommu_dma_map,
+		.dma_user_map_func = &vfio_noiommu_dma_mem_map
+	},
+};
+
+const struct vfio_iommu_ops *
+vfio_set_iommu_type(int vfio_container_fd)
+{
+	for (unsigned int idx = 0; idx < RTE_DIM(iommu_types); idx++) {
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
+
+		int ret = ioctl(vfio_container_fd, VFIO_SET_IOMMU, t->type_id);
+		if (ret == 0)
+			return t;
+		/* not an error, there may be more supported IOMMU types */
+		EAL_LOG(DEBUG, "Set IOMMU type %d (%s) failed, error %i (%s)", t->type_id, t->name,
+			errno, strerror(errno));
+	}
+	/* if we didn't find a suitable IOMMU type, fail */
+	return NULL;
+}
+
+static int
+type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
+{
+	struct vfio_container *cfg = arg;
+
+	/* skip external memory that isn't a heap */
+	if (msl->external && !msl->heap)
+		return 0;
+
+	/* skip any segments with invalid IOVA addresses */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	return vfio_type1_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
+}
+
+static int
+vfio_type1_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
+{
+	struct vfio_iommu_type1_dma_map dma_map;
+	struct vfio_iommu_type1_dma_unmap dma_unmap;
+	int ret;
+
+	if (do_map != 0) {
+		memset(&dma_map, 0, sizeof(dma_map));
+		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+		dma_map.vaddr = vaddr;
+		dma_map.size = len;
+		dma_map.iova = iova;
+		dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		if (ret) {
+			/**
+			 * In case the mapping was already done EEXIST will be
+			 * returned from kernel.
+			 */
+			if (errno == EEXIST) {
+				EAL_LOG(DEBUG, "Memory segment is already mapped, skipping");
+			} else {
+				EAL_LOG(ERR, "Cannot set up DMA remapping, error %i (%s)", errno,
+					strerror(errno));
+				return -1;
+			}
+		}
+	} else {
+		memset(&dma_unmap, 0, sizeof(dma_unmap));
+		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+		dma_unmap.size = len;
+		dma_unmap.iova = iova;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot clear DMA remapping, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		} else if (dma_unmap.size != len) {
+			EAL_LOG(ERR, "Unexpected size %"PRIu64
+				" of DMA remapping cleared instead of %"PRIu64,
+				(uint64_t)dma_unmap.size, len);
+			rte_errno = EIO;
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+vfio_type1_dma_map(struct vfio_container *cfg)
+{
+	return rte_memseg_walk(type1_map, cfg);
+}
+
+/* Track the size of the statically allocated DMA window for SPAPR */
+static uint64_t spapr_dma_win_len;
+static uint64_t spapr_dma_win_page_sz;
+
+static int
+vfio_spapr_dma_do_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
+{
+	struct vfio_iommu_spapr_register_memory reg = {
+		.argsz = sizeof(reg),
+		.vaddr = (uintptr_t) vaddr,
+		.size = len,
+		.flags = 0
+	};
+	int ret;
+
+	if (do_map != 0) {
+		struct vfio_iommu_type1_dma_map dma_map;
+
+		if (iova + len > spapr_dma_win_len) {
+			EAL_LOG(ERR, "DMA map attempt outside DMA window");
+			return -1;
+		}
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot register vaddr for IOMMU, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		}
+
+		memset(&dma_map, 0, sizeof(dma_map));
+		dma_map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+		dma_map.vaddr = vaddr;
+		dma_map.size = len;
+		dma_map.iova = iova;
+		dma_map.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot map vaddr for IOMMU, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		}
+
+	} else {
+		struct vfio_iommu_type1_dma_unmap dma_unmap;
+
+		memset(&dma_unmap, 0, sizeof(dma_unmap));
+		dma_unmap.argsz = sizeof(struct vfio_iommu_type1_dma_unmap);
+		dma_unmap.size = len;
+		dma_unmap.iova = iova;
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot unmap vaddr for IOMMU, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		}
+
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
+		if (ret) {
+			EAL_LOG(ERR, "Cannot unregister vaddr for IOMMU, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		}
+	}
+
+	return ret;
+}
+
+static int
+vfio_spapr_map_walk(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
+{
+	struct vfio_container *cfg = arg;
+
+	/* skip external memory that isn't a heap */
+	if (msl->external && !msl->heap)
+		return 0;
+
+	/* skip any segments with invalid IOVA addresses */
+	if (ms->iova == RTE_BAD_IOVA)
+		return 0;
+
+	return vfio_spapr_dma_do_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
+}
+
+struct spapr_size_walk_param {
+	uint64_t max_va;
+	uint64_t page_sz;
+	bool is_user_managed;
+};
+
+/*
+ * In order to set the DMA window size required for the SPAPR IOMMU
+ * we need to walk the existing virtual memory allocations as well as
+ * find the hugepage size used.
+ */
+static int
+vfio_spapr_size_walk(const struct rte_memseg_list *msl, void *arg)
+{
+	struct spapr_size_walk_param *param = arg;
+	uint64_t max = (uint64_t) msl->base_va + (uint64_t) msl->len;
+
+	if (msl->external && !msl->heap) {
+		/* ignore user managed external memory */
+		param->is_user_managed = true;
+		return 0;
+	}
+
+	if (max > param->max_va) {
+		param->page_sz = msl->page_sz;
+		param->max_va = max;
+	}
+
+	return 0;
+}
+
+/*
+ * Find the highest memory address used in physical or virtual address
+ * space and use that as the top of the DMA window.
+ */
+static int
+find_highest_mem_addr(struct spapr_size_walk_param *param)
+{
+	/* find the maximum IOVA address for setting the DMA window size */
+	if (rte_eal_iova_mode() == RTE_IOVA_PA) {
+		static const char proc_iomem[] = "/proc/iomem";
+		static const char str_sysram[] = "System RAM";
+		uint64_t start, end, max = 0;
+		char *line = NULL;
+		char *dash, *space;
+		size_t line_len;
+
+		/*
+		 * Example "System RAM" in /proc/iomem:
+		 * 00000000-1fffffffff : System RAM
+		 * 200000000000-201fffffffff : System RAM
+		 */
+		FILE *fd = fopen(proc_iomem, "r");
+		if (fd == NULL) {
+			EAL_LOG(ERR, "Cannot open %s", proc_iomem);
+			return -1;
+		}
+		/* Scan /proc/iomem for the highest PA in the system */
+		while (getline(&line, &line_len, fd) != -1) {
+			if (strstr(line, str_sysram) == NULL)
+				continue;
+
+			space = strstr(line, " ");
+			dash = strstr(line, "-");
+
+			/* Validate the format of the memory string */
+			if (space == NULL || dash == NULL || space < dash) {
+				EAL_LOG(ERR, "Can't parse line \"%s\" in file %s", line,
+					proc_iomem);
+				continue;
+			}
+
+			start = strtoull(line, NULL, 16);
+			end   = strtoull(dash + 1, NULL, 16);
+			EAL_LOG(DEBUG, "Found system RAM from 0x%" PRIx64 " to 0x%" PRIx64,
+				start, end);
+			if (end > max)
+				max = end;
+		}
+		free(line);
+		fclose(fd);
+
+		if (max == 0) {
+			EAL_LOG(ERR, "Failed to find valid \"System RAM\" entry in file %s",
+				proc_iomem);
+			return -1;
+		}
+
+		spapr_dma_win_len = rte_align64pow2(max + 1);
+		return 0;
+	} else if (rte_eal_iova_mode() == RTE_IOVA_VA) {
+		EAL_LOG(DEBUG, "Highest VA address in memseg list is 0x%" PRIx64, param->max_va);
+		spapr_dma_win_len = rte_align64pow2(param->max_va);
+		return 0;
+	}
+
+	spapr_dma_win_len = 0;
+	EAL_LOG(ERR, "Unsupported IOVA mode");
+	return -1;
+}
+
+
+/*
+ * The SPAPRv2 IOMMU supports 2 DMA windows with starting
+ * address at 0 or 1<<59.  By default, a DMA window is set
+ * at address 0, 2GB long, with a 4KB page.  For DPDK we
+ * must remove the default window and setup a new DMA window
+ * based on the hugepage size and memory requirements of
+ * the application before we can map memory for DMA.
+ */
+static int
+spapr_dma_win_size(void)
+{
+	struct spapr_size_walk_param param;
+
+	/* only create DMA window once */
+	if (spapr_dma_win_len > 0)
+		return 0;
+
+	/* walk the memseg list to find the page size/max VA address */
+	memset(&param, 0, sizeof(param));
+	if (rte_memseg_list_walk(vfio_spapr_size_walk, &param) < 0) {
+		EAL_LOG(ERR, "Failed to walk memseg list for DMA window size");
+		return -1;
+	}
+
+	/* we can't be sure if DMA window covers external memory */
+	if (param.is_user_managed)
+		EAL_LOG(WARNING, "Detected user managed external memory which may not be managed by the IOMMU");
+
+	/* check physical/virtual memory size */
+	if (find_highest_mem_addr(&param) < 0)
+		return -1;
+	EAL_LOG(DEBUG, "Setting DMA window size to 0x%" PRIx64, spapr_dma_win_len);
+	spapr_dma_win_page_sz = param.page_sz;
+	rte_mem_set_dma_mask(rte_ctz64(spapr_dma_win_len));
+	return 0;
+}
+
+static int
+vfio_spapr_create_dma_window(struct vfio_container *cfg)
+{
+	struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create), };
+	struct vfio_iommu_spapr_tce_remove remove = { .argsz = sizeof(remove), };
+	struct vfio_iommu_spapr_tce_info info = { .argsz = sizeof(info), };
+	int ret;
+
+	ret = spapr_dma_win_size();
+	if (ret < 0)
+		return ret;
+
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+	if (ret) {
+		EAL_LOG(ERR, "Cannot get IOMMU info, error %i (%s)", errno, strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * sPAPR v1/v2 IOMMU always has a default 1G DMA window set.  The window
+	 * can't be changed for v1 but it can be changed for v2. Since DPDK only
+	 * supports v2, remove the default DMA window so it can be resized.
+	 */
+	remove.start_addr = info.dma32_window_start;
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+	if (ret)
+		return -1;
+
+	/* create a new DMA window (start address is not selectable) */
+	create.window_size = spapr_dma_win_len;
+	create.page_shift  = rte_ctz64(spapr_dma_win_page_sz);
+	create.levels = 1;
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+	/*
+	 * The vfio_iommu_spapr_tce_info structure was modified in
+	 * Linux kernel 4.2.0 to add support for the
+	 * vfio_iommu_spapr_tce_ddw_info structure needed to try
+	 * multiple table levels.  Skip the attempt if running with
+	 * an older kernel.
+	 */
+	if (ret) {
+		/* if at first we don't succeed, try more levels */
+		uint32_t levels;
+
+		for (levels = create.levels + 1;
+			ret && levels <= info.ddw.levels; levels++) {
+			create.levels = levels;
+			ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+		}
+	}
+	if (ret) {
+		EAL_LOG(ERR, "Cannot create new DMA window, error %i (%s)", errno,
+			strerror(errno));
+		EAL_LOG(ERR, "Consider using a larger hugepage size if supported by the system");
+		return -1;
+	}
+
+	/* verify the start address  */
+	if (create.start_addr != 0) {
+		EAL_LOG(ERR, "Received unsupported start address 0x%" PRIx64,
+			(uint64_t)create.start_addr);
+		return -1;
+	}
+	return ret;
+}
+
+static int
+vfio_spapr_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
+{
+	int ret = 0;
+
+	if (do_map) {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 1)) {
+			EAL_LOG(ERR, "Failed to map DMA");
+			ret = -1;
+		}
+	} else {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 0)) {
+			EAL_LOG(ERR, "Failed to unmap DMA");
+			ret = -1;
+		}
+	}
+
+	return ret;
+}
+
+static int
+vfio_spapr_dma_map(struct vfio_container *cfg)
+{
+	if (vfio_spapr_create_dma_window(cfg) < 0) {
+		EAL_LOG(ERR, "Could not create new DMA window!");
+		return -1;
+	}
+
+	/* map all existing DPDK segments for DMA */
+	if (rte_memseg_walk(vfio_spapr_map_walk, cfg) < 0)
+		return -1;
+
+	return 0;
+}
+
+static int
+vfio_noiommu_dma_map(struct vfio_container *cfg __rte_unused)
+{
+	/* No-IOMMU mode does not need DMA mapping */
+	return 0;
+}
+
+static int
+vfio_noiommu_dma_mem_map(struct vfio_container *cfg __rte_unused, uint64_t vaddr __rte_unused,
+		uint64_t iova __rte_unused, uint64_t len __rte_unused, int do_map __rte_unused)
+{
+	/* No-IOMMU mode does not need DMA mapping */
+	return 0;
+}
+
+int
+vfio_has_supported_extensions(int vfio_container_fd)
+{
+	unsigned int n_extensions = 0;
+	int ret;
+
+	for (unsigned int idx = 0; idx < RTE_DIM(iommu_types); idx++) {
+		const struct vfio_iommu_ops *t = &iommu_types[idx];
+
+		ret = ioctl(vfio_container_fd, VFIO_CHECK_EXTENSION, t->type_id);
+		if (ret < 0) {
+			EAL_LOG(ERR, "Could not get IOMMU type, error %i (%s)", errno,
+				strerror(errno));
+			return -1;
+		} else if (ret == 1) {
+			/* we found a supported extension */
+			n_extensions++;
+		}
+		EAL_LOG(DEBUG, "IOMMU type %d (%s) is %s", t->type_id, t->name,
+			ret ? "supported" : "not supported");
+	}
+
+	/* if we didn't find any supported IOMMU types, fail */
+	if (n_extensions == 0)
+		return -1;
+
+	return 0;
+}
diff --git a/lib/eal/linux/meson.build b/lib/eal/linux/meson.build
index 29ba313218..5ec8eddaa2 100644
--- a/lib/eal/linux/meson.build
+++ b/lib/eal/linux/meson.build
@@ -16,6 +16,7 @@ sources += files(
         'eal_thread.c',
         'eal_timer.c',
         'eal_vfio.c',
+        'eal_vfio_group.c',
         'eal_vfio_mp_sync.c',
 )
 
-- 
2.54.0

