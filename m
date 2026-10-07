Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF90CA5FF1
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:12:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D603842EB0;
	Wed,  7 Oct 2026 10:11:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4A5A642EC0
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fbXTtbUkvbPvCnmCJCKI+OTQxF5cLdg1xkCk3/Oa344=;
 b=c1A4o8cZ51KhagXP+iyj7mFBdA5h9AviigxIa0atwzFN4L5iqLUe9QxNF+OWrpvlT6eRDB
 h+HCPLZKTPOmim1+yT8WN7A4ywadLh5Ik51jA0bVs+A6UGqudOuLbYftYo8MCfX5M5Q76/
 LpVtuEXL0+AkjfUqvizODiFAyFZQyx0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-pXeK0Z5SO3iXVvqiBRY1iQ-1; Wed,
 7 Oct 2026 08:11:41 +0000
X-MC-Unique: pXeK0Z5SO3iXVvqiBRY1iQ-1
X-Mimecast-MFC-AGG-ID: pXeK0Z5SO3iXVvqiBRY1iQ_1791360700
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950AF1955F39; Wed,  7 Oct 2026 08:11:40 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D63A30000E6; Wed,  7 Oct 2026 08:11:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RESEND][PATCH v19 18/26] vfio: rename some internal types and macros
Date: Wed,  7 Oct 2026 10:10:15 +0200
Message-ID: <20261007081026.574382-19-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9h_-J6ZQ1Z_aapdTZGh03BBAl2soOGPIpXg0LCi7mgo_1791360700
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

Some types and macros will be used in multiple code units in later
commits.
Prefix them with vfio_/VFIO_.

Rename vfio_config as vfio_container and pass it instead of the
container FD.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_vfio.c         | 548 ++++++++++++++-----------------
 lib/eal/linux/eal_vfio.h         |  50 ++-
 lib/eal/linux/eal_vfio_mp_sync.c |  26 +-
 3 files changed, 298 insertions(+), 326 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 144920d1d0..c050e022da 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -29,36 +29,9 @@
 
 #define VFIO_MEM_EVENT_CLB_NAME "vfio_mem_event_clb"
 
-/* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
- * recreate the mappings for DPDK segments, but we cannot do so for memory that
- * was registered by the user themselves, so we need to store the user mappings
- * somewhere, to recreate them later.
- */
-#define EAL_VFIO_MAX_USER_MEM_MAPS 256
-struct user_mem_map {
-	uint64_t addr;  /**< start VA */
-	uint64_t iova;  /**< start IOVA */
-	uint64_t len;   /**< total length of the mapping */
-	uint64_t chunk; /**< this mapping can be split in chunks of this size */
-};
-
-struct user_mem_maps {
-	rte_spinlock_recursive_t lock;
-	int n_maps;
-	struct user_mem_map maps[EAL_VFIO_MAX_USER_MEM_MAPS];
-};
-
-struct vfio_config {
-	int vfio_container_fd;
-	int vfio_active_groups;
-	const struct vfio_iommu_type *vfio_iommu_type;
-	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
-	struct user_mem_maps mem_maps;
-};
-
 /* per-process VFIO config */
-static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
-static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
+static struct vfio_container vfio_containers[RTE_MAX_VFIO_CONTAINERS];
+static struct vfio_container *default_vfio_cfg = &vfio_containers[0];
 
 /* whether VFIO is enabled (usable) in this process */
 static bool vfio_enabled;
@@ -105,14 +78,14 @@ vfio_check_module(enum dev_vfio_module module)
 	return 1;
 }
 
-static int vfio_type1_dma_map(int);
-static int vfio_type1_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_spapr_dma_map(int);
-static int vfio_spapr_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_noiommu_dma_map(int);
-static int vfio_noiommu_dma_mem_map(int, uint64_t, uint64_t, uint64_t, int);
-static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
-		uint64_t iova, uint64_t len, int do_map);
+static int vfio_type1_dma_map(struct vfio_container *);
+static int vfio_type1_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_spapr_dma_map(struct vfio_container *);
+static int vfio_spapr_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_noiommu_dma_map(struct vfio_container *);
+static int vfio_noiommu_dma_mem_map(struct vfio_container *, uint64_t, uint64_t, uint64_t, int);
+static int vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
+		uint64_t len, int do_map);
 
 static int vfio_container_group_bind(int container_fd, int iommu_group_num);
 static int vfio_container_group_unbind(int container_fd, int iommu_group_num);
@@ -146,10 +119,9 @@ static const struct vfio_iommu_type iommu_types[] = {
 };
 
 static int
-is_null_map(const struct user_mem_map *map)
+is_null_map(const struct vfio_user_mem_map *map)
 {
-	return map->addr == 0 && map->iova == 0 &&
-			map->len == 0 && map->chunk == 0;
+	return map->addr == 0 && map->iova == 0 && map->len == 0 && map->chunk == 0;
 }
 
 /* we may need to merge user mem maps together in case of user mapping/unmapping
@@ -158,8 +130,8 @@ is_null_map(const struct user_mem_map *map)
 static int
 user_mem_map_cmp(const void *a, const void *b)
 {
-	const struct user_mem_map *umm_a = a;
-	const struct user_mem_map *umm_b = b;
+	const struct vfio_user_mem_map *umm_a = a;
+	const struct vfio_user_mem_map *umm_b = b;
 
 	/* move null entries to end */
 	if (is_null_map(umm_a))
@@ -196,14 +168,14 @@ user_mem_map_cmp(const void *a, const void *b)
  * mappings that will be kept.
  */
 static int
-process_maps(struct user_mem_map *src, size_t src_len,
-		struct user_mem_map newmap[2], uint64_t vaddr, uint64_t len)
+process_maps(struct vfio_user_mem_map *src, size_t src_len, struct vfio_user_mem_map newmap[2],
+		uint64_t vaddr, uint64_t len)
 {
-	struct user_mem_map *src_first = &src[0];
-	struct user_mem_map *src_last = &src[src_len - 1];
-	struct user_mem_map *dst_first = &newmap[0];
+	struct vfio_user_mem_map *src_first = &src[0];
+	struct vfio_user_mem_map *src_last = &src[src_len - 1];
+	struct vfio_user_mem_map *dst_first = &newmap[0];
 	/* we can get at most two new segments */
-	struct user_mem_map *dst_last = &newmap[1];
+	struct vfio_user_mem_map *dst_last = &newmap[1];
 	uint64_t first_off = vaddr - src_first->addr;
 	uint64_t last_off = (src_last->addr + src_last->len) - (vaddr + len);
 	int newmap_len = 0;
@@ -218,8 +190,8 @@ process_maps(struct user_mem_map *src, size_t src_len,
 	}
 	if (last_off != 0) {
 		/* if we had start offset, we have two segments */
-		struct user_mem_map *last =
-				first_off == 0 ? dst_first : dst_last;
+		struct vfio_user_mem_map *last = first_off == 0 ? dst_first : dst_last;
+
 		last->addr = (src_last->addr + src_last->len) - last_off;
 		last->iova = (src_last->iova + src_last->len) - last_off;
 		last->len = last_off;
@@ -232,15 +204,15 @@ process_maps(struct user_mem_map *src, size_t src_len,
 
 /* erase certain maps from the list */
 static void
-delete_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *del_maps,
+delete_maps(struct vfio_user_mem_maps *user_mem_maps, struct vfio_user_mem_map *del_maps,
 		size_t n_del)
 {
 	unsigned int i;
 	size_t j;
 
 	for (i = 0, j = 0; i < RTE_DIM(user_mem_maps->maps) && j < n_del; i++) {
-		struct user_mem_map *left = &user_mem_maps->maps[i];
-		struct user_mem_map *right = &del_maps[j];
+		struct vfio_user_mem_map *left = &user_mem_maps->maps[i];
+		struct vfio_user_mem_map *right = &del_maps[j];
 
 		if (user_mem_map_cmp(left, right) == 0) {
 			memset(left, 0, sizeof(*left));
@@ -251,15 +223,15 @@ delete_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *del_maps,
 }
 
 static void
-copy_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *add_maps,
+copy_maps(struct vfio_user_mem_maps *user_mem_maps, struct vfio_user_mem_map *add_maps,
 		size_t n_add)
 {
 	unsigned int i;
 	size_t j;
 
 	for (i = 0, j = 0; i < RTE_DIM(user_mem_maps->maps) && j < n_add; i++) {
-		struct user_mem_map *left = &user_mem_maps->maps[i];
-		struct user_mem_map *right = &add_maps[j];
+		struct vfio_user_mem_map *left = &user_mem_maps->maps[i];
+		struct vfio_user_mem_map *right = &add_maps[j];
 
 		/* insert into empty space */
 		if (is_null_map(left)) {
@@ -272,10 +244,10 @@ copy_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *add_maps,
 
 /* try merging two maps into one, return 1 if succeeded */
 static int
-merge_map(struct user_mem_map *left, struct user_mem_map *right)
+merge_map(struct vfio_user_mem_map *left, struct vfio_user_mem_map *right)
 {
 	/* merge the same maps into one */
-	if (memcmp(left, right, sizeof(struct user_mem_map)) == 0)
+	if (memcmp(left, right, sizeof(struct vfio_user_mem_map)) == 0)
 		goto out;
 
 	if (left->addr + left->len != right->addr)
@@ -293,13 +265,12 @@ merge_map(struct user_mem_map *left, struct user_mem_map *right)
 }
 
 static bool
-addr_is_chunk_aligned(struct user_mem_map *maps, size_t n_maps,
-		uint64_t vaddr, uint64_t iova)
+addr_is_chunk_aligned(struct vfio_user_mem_map *maps, size_t n_maps, uint64_t vaddr, uint64_t iova)
 {
 	unsigned int i;
 
 	for (i = 0; i < n_maps; i++) {
-		struct user_mem_map *map = &maps[i];
+		struct vfio_user_mem_map *map = &maps[i];
 		uint64_t map_va_end = map->addr + map->len;
 		uint64_t map_iova_end = map->iova + map->len;
 		uint64_t map_va_off = vaddr - map->addr;
@@ -312,17 +283,15 @@ addr_is_chunk_aligned(struct user_mem_map *maps, size_t n_maps,
 		bool addr_is_aligned = (map_va_off % map->chunk) == 0;
 		bool iova_is_aligned = (map_iova_off % map->chunk) == 0;
 
-		if (addr_in_map && iova_in_map &&
-				addr_is_aligned && iova_is_aligned)
+		if (addr_in_map && iova_in_map && addr_is_aligned && iova_is_aligned)
 			return true;
 	}
 	return false;
 }
 
 static int
-find_user_mem_maps(struct user_mem_maps *user_mem_maps, uint64_t addr,
-		uint64_t iova, uint64_t len, struct user_mem_map *dst,
-		size_t dst_len)
+find_user_mem_maps(struct vfio_user_mem_maps *user_mem_maps, uint64_t addr, uint64_t iova,
+		uint64_t len, struct vfio_user_mem_map *dst, size_t dst_len)
 {
 	uint64_t va_end = addr + len;
 	uint64_t iova_end = iova + len;
@@ -331,18 +300,14 @@ find_user_mem_maps(struct user_mem_maps *user_mem_maps, uint64_t addr,
 	int i, ret;
 
 	for (i = 0, j = 0; i < user_mem_maps->n_maps; i++) {
-		struct user_mem_map *map = &user_mem_maps->maps[i];
+		struct vfio_user_mem_map *map = &user_mem_maps->maps[i];
 		uint64_t map_va_end = map->addr + map->len;
 		uint64_t map_iova_end = map->iova + map->len;
 
-		bool start_addr_in_map = (addr >= map->addr) &&
-				(addr < map_va_end);
-		bool end_addr_in_map = (va_end > map->addr) &&
-				(va_end <= map_va_end);
-		bool start_iova_in_map = (iova >= map->iova) &&
-				(iova < map_iova_end);
-		bool end_iova_in_map = (iova_end > map->iova) &&
-				(iova_end <= map_iova_end);
+		bool start_addr_in_map = (addr >= map->addr) && (addr < map_va_end);
+		bool end_addr_in_map = (va_end > map->addr) && (va_end <= map_va_end);
+		bool start_iova_in_map = (iova >= map->iova) && (iova < map_iova_end);
+		bool end_iova_in_map = (iova_end > map->iova) && (iova_end <= map_iova_end);
 
 		/* do we have space in temporary map? */
 		if (j == dst_len) {
@@ -371,16 +336,16 @@ find_user_mem_maps(struct user_mem_maps *user_mem_maps, uint64_t addr,
 
 /* this will sort all user maps, and merge/compact any adjacent maps */
 static void
-compact_user_maps(struct user_mem_maps *user_mem_maps)
+compact_user_maps(struct vfio_user_mem_maps *user_mem_maps)
 {
 	unsigned int i;
 
-	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps),
-			sizeof(user_mem_maps->maps[0]), user_mem_map_cmp);
+	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps), sizeof(user_mem_maps->maps[0]),
+		user_mem_map_cmp);
 
 	/* we'll go over the list backwards when merging */
 	for (i = RTE_DIM(user_mem_maps->maps) - 2; i != 0; i--) {
-		struct user_mem_map *l, *r;
+		struct vfio_user_mem_map *l, *r;
 
 		l = &user_mem_maps->maps[i];
 		r = &user_mem_maps->maps[i + 1];
@@ -396,8 +361,8 @@ compact_user_maps(struct user_mem_maps *user_mem_maps)
 	/* the entries are still sorted, but now they have holes in them, so
 	 * sort the list again.
 	 */
-	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps),
-			sizeof(user_mem_maps->maps[0]), user_mem_map_cmp);
+	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps), sizeof(user_mem_maps->maps[0]),
+		user_mem_map_cmp);
 }
 
 static int
@@ -444,7 +409,7 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 	/* if we're in a secondary process, request group fd from the primary
 	 * process via mp channel.
 	 */
-	p->req = SOCKET_REQ_GROUP;
+	p->req = VFIO_SOCKET_REQ_GROUP;
 	p->group_num = iommu_group_num;
 	strcpy(mp_req.name, EAL_VFIO_MP);
 	mp_req.len_param = sizeof(*p);
@@ -455,9 +420,9 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 	    mp_reply.nb_received == 1) {
 		mp_rep = &mp_reply.msgs[0];
 		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
+		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
 			vfio_group_fd = mp_rep->fds[0];
-		} else if (p->result == SOCKET_NO_FD) {
+		} else if (p->result == VFIO_SOCKET_NO_FD) {
 			EAL_LOG(ERR, "Bad VFIO group fd");
 			vfio_group_fd = -ENOENT;
 		}
@@ -469,18 +434,18 @@ vfio_open_group_fd(int iommu_group_num, bool mp_request)
 	return vfio_group_fd;
 }
 
-static struct vfio_config *
+static struct vfio_container *
 get_vfio_cfg_by_group_num(int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	unsigned int i, j;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++) {
-			if (vfio_cfg->vfio_groups[j].group_num ==
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		cfg = &vfio_containers[i];
+		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++) {
+			if (cfg->vfio_groups[j].group_num ==
 					iommu_group_num)
-				return vfio_cfg;
+				return cfg;
 		}
 	}
 
@@ -488,28 +453,27 @@ get_vfio_cfg_by_group_num(int iommu_group_num)
 }
 
 static int
-vfio_get_group_fd(struct vfio_config *vfio_cfg,
-		int iommu_group_num)
+vfio_get_group_fd(struct vfio_container *cfg, int iommu_group_num)
 {
 	struct vfio_group *cur_grp = NULL;
 	int vfio_group_fd;
 	unsigned int i;
 
 	/* check if we already have the group descriptor open */
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num)
-			return vfio_cfg->vfio_groups[i].fd;
+	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
+		if (cfg->vfio_groups[i].group_num == iommu_group_num)
+			return cfg->vfio_groups[i].fd;
 
 	/* Lets see first if there is room for a new group */
-	if (vfio_cfg->vfio_active_groups == RTE_DIM(vfio_cfg->vfio_groups)) {
+	if (cfg->vfio_active_groups == RTE_DIM(cfg->vfio_groups)) {
 		EAL_LOG(ERR, "Maximum number of VFIO groups reached!");
 		return -1;
 	}
 
 	/* Now lets get an index for the new group */
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num == -1) {
-			cur_grp = &vfio_cfg->vfio_groups[i];
+	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
+		if (cfg->vfio_groups[i].group_num == -1) {
+			cur_grp = &cfg->vfio_groups[i];
 			break;
 		}
 
@@ -534,7 +498,7 @@ vfio_get_group_fd(struct vfio_config *vfio_cfg,
 	 */
 	const struct internal_config *internal_conf = eal_get_internal_configuration();
 	bool mp_request = (internal_conf->process_type == RTE_PROC_SECONDARY) &&
-			(vfio_cfg == default_vfio_cfg);
+			(cfg == default_vfio_cfg);
 
 	vfio_group_fd = vfio_open_group_fd(iommu_group_num, mp_request);
 	if (vfio_group_fd < 0) {
@@ -545,28 +509,28 @@ vfio_get_group_fd(struct vfio_config *vfio_cfg,
 
 	cur_grp->group_num = iommu_group_num;
 	cur_grp->fd = vfio_group_fd;
-	vfio_cfg->vfio_active_groups++;
+	cfg->vfio_active_groups++;
 
 	return vfio_group_fd;
 }
 
-static struct vfio_config *
+static struct vfio_container *
 get_vfio_cfg_by_group_fd(int vfio_group_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	unsigned int i, j;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
-			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
-				return vfio_cfg;
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		cfg = &vfio_containers[i];
+		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++)
+			if (cfg->vfio_groups[j].fd == vfio_group_fd)
+				return cfg;
 	}
 
 	return NULL;
 }
 
-static struct vfio_config *
+static struct vfio_container *
 get_vfio_cfg_by_container_fd(int container_fd)
 {
 	unsigned int i;
@@ -574,9 +538,9 @@ get_vfio_cfg_by_container_fd(int container_fd)
 	if (container_fd == DEV_VFIO_DEFAULT_CONTAINER_FD)
 		return default_vfio_cfg;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		if (vfio_cfgs[i].vfio_container_fd == container_fd)
-			return &vfio_cfgs[i];
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		if (vfio_containers[i].container_fd == container_fd)
+			return &vfio_containers[i];
 	}
 
 	return NULL;
@@ -585,28 +549,28 @@ get_vfio_cfg_by_container_fd(int container_fd)
 int
 vfio_get_group_fd_by_num(int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 
 	if (!vfio_enabled)
 		return -1;
 
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
+	/* get the vfio_container it belongs to */
+	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
+	cfg = cfg ? cfg : default_vfio_cfg;
 
-	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
+	return vfio_get_group_fd(cfg, iommu_group_num);
 }
 
 static int
 get_vfio_group_idx(int vfio_group_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	unsigned int i, j;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
-			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		cfg = &vfio_containers[i];
+		for (j = 0; j < RTE_DIM(cfg->vfio_groups); j++)
+			if (cfg->vfio_groups[j].fd == vfio_group_fd)
 				return j;
 	}
 
@@ -616,11 +580,11 @@ get_vfio_group_idx(int vfio_group_fd)
 static void
 vfio_group_device_get(int vfio_group_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	int i;
 
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
 		return;
 	}
@@ -629,17 +593,17 @@ vfio_group_device_get(int vfio_group_fd)
 	if (i < 0)
 		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
 	else
-		vfio_cfg->vfio_groups[i].devices++;
+		cfg->vfio_groups[i].devices++;
 }
 
 static void
 vfio_group_device_put(int vfio_group_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	int i;
 
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
 		return;
 	}
@@ -648,17 +612,17 @@ vfio_group_device_put(int vfio_group_fd)
 	if (i < 0)
 		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
 	else
-		vfio_cfg->vfio_groups[i].devices--;
+		cfg->vfio_groups[i].devices--;
 }
 
 static int
 vfio_group_device_count(int vfio_group_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	int i;
 
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
 		return -1;
 	}
@@ -669,7 +633,7 @@ vfio_group_device_count(int vfio_group_fd)
 		return -1;
 	}
 
-	return vfio_cfg->vfio_groups[i].devices;
+	return cfg->vfio_groups[i].devices;
 }
 
 static void
@@ -738,14 +702,13 @@ vfio_sync_default_container(void)
 		return -1;
 
 	/* default container fd should have been opened in dev_vfio_enable() */
-	if (!vfio_enabled ||
-			default_vfio_cfg->vfio_container_fd < 0) {
+	if (!vfio_enabled || default_vfio_cfg->container_fd < 0) {
 		EAL_LOG(ERR, "VFIO support is not initialized");
 		return -1;
 	}
 
 	/* find default container's IOMMU type */
-	p->req = SOCKET_REQ_IOMMU_TYPE;
+	p->req = VFIO_SOCKET_REQ_IOMMU_TYPE;
 	strcpy(mp_req.name, EAL_VFIO_MP);
 	mp_req.len_param = sizeof(*p);
 	mp_req.num_fds = 0;
@@ -755,7 +718,7 @@ vfio_sync_default_container(void)
 			mp_reply.nb_received == 1) {
 		mp_rep = &mp_reply.msgs[0];
 		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK)
+		if (p->result == VFIO_SOCKET_OK)
 			iommu_type_id = p->iommu_type_id;
 	}
 	free(mp_reply.msgs);
@@ -787,13 +750,13 @@ static int
 vfio_clear_group(int vfio_group_fd)
 {
 	int i;
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 
 	if (!vfio_enabled)
 		return -1;
 
-	vfio_cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_group_fd(vfio_group_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO group fd!");
 		return -1;
 	}
@@ -801,10 +764,10 @@ vfio_clear_group(int vfio_group_fd)
 	i = get_vfio_group_idx(vfio_group_fd);
 	if (i < 0)
 		return -1;
-	vfio_cfg->vfio_groups[i].group_num = -1;
-	vfio_cfg->vfio_groups[i].fd = -1;
-	vfio_cfg->vfio_groups[i].devices = 0;
-	vfio_cfg->vfio_active_groups--;
+	cfg->vfio_groups[i].group_num = -1;
+	cfg->vfio_groups[i].fd = -1;
+	cfg->vfio_groups[i].devices = 0;
+	cfg->vfio_active_groups--;
 
 	return 0;
 }
@@ -816,8 +779,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 	struct vfio_group_status group_status = {
 			.argsz = sizeof(group_status)
 	};
-	struct vfio_config *vfio_cfg;
-	struct user_mem_maps *user_mem_maps;
+	struct vfio_container *cfg;
+	struct vfio_user_mem_maps *user_mem_maps;
 	int vfio_container_fd;
 	int vfio_group_fd;
 	int iommu_group_num;
@@ -880,18 +843,17 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		return -1;
 	}
 
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
-	vfio_container_fd = vfio_cfg->vfio_container_fd;
-	user_mem_maps = &vfio_cfg->mem_maps;
+	/* get the vfio_container it belongs to */
+	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
+	cfg = cfg ? cfg : default_vfio_cfg;
+	vfio_container_fd = cfg->container_fd;
+	user_mem_maps = &cfg->mem_maps;
 
 	/* check if group does not have a container yet */
 	if (!(group_status.flags & VFIO_GROUP_FLAGS_CONTAINER_SET)) {
 
 		/* add group to a container */
-		ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER,
-				&vfio_container_fd);
+		ret = ioctl(vfio_group_fd, VFIO_GROUP_SET_CONTAINER, &vfio_container_fd);
 		if (ret) {
 			EAL_LOG(ERR,
 				"%s cannot add VFIO group to container, error "
@@ -910,7 +872,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 		 * functionality.
 		 */
 		if (internal_conf->process_type == RTE_PROC_PRIMARY &&
-				vfio_cfg->vfio_active_groups == 1 &&
+				cfg->vfio_active_groups == 1 &&
 				vfio_group_device_count(vfio_group_fd) == 0) {
 			const struct vfio_iommu_type *t;
 
@@ -928,8 +890,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			 * after registering callback, to prevent races
 			 */
 			rte_mcfg_mem_read_lock();
-			if (vfio_cfg == default_vfio_cfg)
-				ret = t->dma_map_func(vfio_container_fd);
+			if (cfg == default_vfio_cfg)
+				ret = t->dma_map_func(cfg);
 			else
 				ret = 0;
 			if (ret) {
@@ -943,7 +905,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 				return -1;
 			}
 
-			vfio_cfg->vfio_iommu_type = t;
+			cfg->vfio_iommu_type = t;
 
 			/* re-map all user-mapped segments */
 			rte_spinlock_recursive_lock(&user_mem_maps->lock);
@@ -954,13 +916,10 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			 * be sure that DMA mapping is supported.
 			 */
 			for (i = 0; i < user_mem_maps->n_maps; i++) {
-				struct user_mem_map *map;
+				struct vfio_user_mem_map *map;
 				map = &user_mem_maps->maps[i];
 
-				ret = t->dma_user_map_func(
-						vfio_container_fd,
-						map->addr, map->iova, map->len,
-						1);
+				ret = t->dma_user_map_func(cfg, map->addr, map->iova, map->len, 1);
 				if (ret) {
 					EAL_LOG(ERR, "Couldn't map user memory for DMA: "
 							"va: 0x%" PRIx64 " "
@@ -977,7 +936,7 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 			rte_spinlock_recursive_unlock(&user_mem_maps->lock);
 
 			/* register callback for mem events */
-			if (vfio_cfg == default_vfio_cfg)
+			if (cfg == default_vfio_cfg)
 				ret = rte_mem_event_callback_register(
 					VFIO_MEM_EVENT_CLB_NAME,
 					vfio_mem_event_callback, NULL);
@@ -996,8 +955,8 @@ dev_vfio_setup_device(const char *sysfs_base, const char *dev_addr, int *vfio_de
 				EAL_LOG(DEBUG, "Installed memory event callback for VFIO");
 		}
 	} else if (rte_eal_process_type() != RTE_PROC_PRIMARY &&
-			vfio_cfg == default_vfio_cfg &&
-			vfio_cfg->vfio_iommu_type == NULL) {
+			cfg == default_vfio_cfg &&
+			cfg->vfio_iommu_type == NULL) {
 		/* if we're not a primary process, we do not set up the VFIO
 		 * container because it's already been set up by the primary
 		 * process. instead, we simply ask the primary about VFIO type
@@ -1060,7 +1019,7 @@ int
 dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		    int vfio_dev_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	int vfio_group_fd;
 	int iommu_group_num;
 	int ret;
@@ -1092,9 +1051,9 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 		goto out;
 	}
 
-	/* get the vfio_config it belongs to */
-	vfio_cfg = get_vfio_cfg_by_group_num(iommu_group_num);
-	vfio_cfg = vfio_cfg ? vfio_cfg : default_vfio_cfg;
+	/* get the vfio_container it belongs to */
+	cfg = get_vfio_cfg_by_group_num(iommu_group_num);
+	cfg = cfg ? cfg : default_vfio_cfg;
 
 	/* At this point we got an active group. Closing it will make the
 	 * container detachment. If this is the last active group, VFIO kernel
@@ -1133,7 +1092,7 @@ dev_vfio_release_device(const char *sysfs_base, const char *dev_addr,
 	/* if there are no active device groups, unregister the callback to
 	 * avoid spurious attempts to map/unmap memory from VFIO.
 	 */
-	if (vfio_cfg == default_vfio_cfg && vfio_cfg->vfio_active_groups == 0 &&
+	if (cfg == default_vfio_cfg && cfg->vfio_active_groups == 0 &&
 			rte_eal_process_type() != RTE_PROC_SECONDARY)
 		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME,
 				NULL);
@@ -1162,16 +1121,16 @@ dev_vfio_enable(void)
 	if (vfio_enabled)
 		return 0;
 
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		vfio_cfgs[i].vfio_container_fd = -1;
-		vfio_cfgs[i].vfio_active_groups = 0;
-		vfio_cfgs[i].vfio_iommu_type = NULL;
-		vfio_cfgs[i].mem_maps.lock = lock;
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		vfio_containers[i].container_fd = -1;
+		vfio_containers[i].vfio_active_groups = 0;
+		vfio_containers[i].vfio_iommu_type = NULL;
+		vfio_containers[i].mem_maps.lock = lock;
 
-		for (j = 0; j < RTE_DIM(vfio_cfgs[i].vfio_groups); j++) {
-			vfio_cfgs[i].vfio_groups[j].fd = -1;
-			vfio_cfgs[i].vfio_groups[j].group_num = -1;
-			vfio_cfgs[i].vfio_groups[j].devices = 0;
+		for (j = 0; j < RTE_DIM(vfio_containers[i].vfio_groups); j++) {
+			vfio_containers[i].vfio_groups[j].fd = -1;
+			vfio_containers[i].vfio_groups[j].group_num = -1;
+			vfio_containers[i].vfio_groups[j].devices = 0;
 		}
 	}
 
@@ -1204,19 +1163,18 @@ dev_vfio_enable(void)
 
 	if (internal_conf->process_type == RTE_PROC_PRIMARY) {
 		if (vfio_mp_sync_setup() == -1) {
-			default_vfio_cfg->vfio_container_fd = -1;
+			default_vfio_cfg->container_fd = -1;
 		} else {
 			/* open a default container */
-			default_vfio_cfg->vfio_container_fd = vfio_open_container_fd(false);
+			default_vfio_cfg->container_fd = vfio_open_container_fd(false);
 		}
 	} else {
 		/* get the default container from the primary process */
-		default_vfio_cfg->vfio_container_fd =
-			vfio_open_container_fd(true);
+		default_vfio_cfg->container_fd = vfio_open_container_fd(true);
 	}
 
 	/* check if we have VFIO driver enabled */
-	if (default_vfio_cfg->vfio_container_fd != -1) {
+	if (default_vfio_cfg->container_fd != -1) {
 		EAL_LOG(INFO, "VFIO support initialized");
 		vfio_enabled = true;
 	} else {
@@ -1381,7 +1339,7 @@ vfio_open_container_fd(bool mp_request)
 	 * if we're in a secondary process, request container fd from the
 	 * primary process via mp channel
 	 */
-	p->req = SOCKET_REQ_CONTAINER;
+	p->req = VFIO_SOCKET_REQ_CONTAINER;
 	strcpy(mp_req.name, EAL_VFIO_MP);
 	mp_req.len_param = sizeof(*p);
 	mp_req.num_fds = 0;
@@ -1391,7 +1349,7 @@ vfio_open_container_fd(bool mp_request)
 	    mp_reply.nb_received == 1) {
 		mp_rep = &mp_reply.msgs[0];
 		p = (struct vfio_mp_param *)mp_rep->param;
-		if (p->result == SOCKET_OK && mp_rep->num_fds == 1) {
+		if (p->result == VFIO_SOCKET_OK && mp_rep->num_fds == 1) {
 			vfio_container_fd = mp_rep->fds[0];
 			free(mp_reply.msgs);
 			return vfio_container_fd;
@@ -1414,7 +1372,7 @@ dev_vfio_get_container_fd(void)
 	if (!vfio_enabled)
 		return -1;
 
-	return default_vfio_cfg->vfio_container_fd;
+	return default_vfio_cfg->container_fd;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_get_group_num)
@@ -1465,10 +1423,9 @@ dev_vfio_get_group_num(const char *sysfs_base,
 }
 
 static int
-type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
-		void *arg)
+type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
 {
-	int *vfio_container_fd = arg;
+	struct vfio_container *cfg = arg;
 
 	/* skip external memory that isn't a heap */
 	if (msl->external && !msl->heap)
@@ -1478,13 +1435,12 @@ type1_map(const struct rte_memseg_list *msl, const struct rte_memseg *ms,
 	if (ms->iova == RTE_BAD_IOVA)
 		return 0;
 
-	return vfio_type1_dma_mem_map(*vfio_container_fd, ms->addr_64, ms->iova,
-			ms->len, 1);
+	return vfio_type1_dma_mem_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
 }
 
 static int
-vfio_type1_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map)
+vfio_type1_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
 {
 	struct vfio_iommu_type1_dma_map dma_map;
 	struct vfio_iommu_type1_dma_unmap dma_unmap;
@@ -1499,7 +1455,7 @@ vfio_type1_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
 				VFIO_DMA_MAP_FLAG_WRITE;
 
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
 		if (ret) {
 			/**
 			 * In case the mapping was already done EEXIST will be
@@ -1521,8 +1477,7 @@ vfio_type1_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 		dma_unmap.size = len;
 		dma_unmap.iova = iova;
 
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_DMA,
-				&dma_unmap);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
 		if (ret) {
 			EAL_LOG(ERR, "Cannot clear DMA remapping, error "
 					"%i (%s)", errno, strerror(errno));
@@ -1540,9 +1495,9 @@ vfio_type1_dma_mem_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 }
 
 static int
-vfio_type1_dma_map(int vfio_container_fd)
+vfio_type1_dma_map(struct vfio_container *cfg)
 {
-	return rte_memseg_walk(type1_map, &vfio_container_fd);
+	return rte_memseg_walk(type1_map, cfg);
 }
 
 /* Track the size of the statically allocated DMA window for SPAPR */
@@ -1550,8 +1505,8 @@ uint64_t spapr_dma_win_len;
 uint64_t spapr_dma_win_page_sz;
 
 static int
-vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map)
+vfio_spapr_dma_do_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
 {
 	struct vfio_iommu_spapr_register_memory reg = {
 		.argsz = sizeof(reg),
@@ -1569,8 +1524,7 @@ vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 			return -1;
 		}
 
-		ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_REGISTER_MEMORY, &reg);
 		if (ret) {
 			EAL_LOG(ERR,
 				"Cannot register vaddr for IOMMU, error "
@@ -1586,7 +1540,7 @@ vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 		dma_map.flags = VFIO_DMA_MAP_FLAG_READ |
 				VFIO_DMA_MAP_FLAG_WRITE;
 
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_MAP_DMA, &dma_map);
 		if (ret) {
 			EAL_LOG(ERR, "Cannot map vaddr for IOMMU, error "
 					"%i (%s)", errno, strerror(errno));
@@ -1601,16 +1555,14 @@ vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 		dma_unmap.size = len;
 		dma_unmap.iova = iova;
 
-		ret = ioctl(vfio_container_fd, VFIO_IOMMU_UNMAP_DMA,
-				&dma_unmap);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_UNMAP_DMA, &dma_unmap);
 		if (ret) {
 			EAL_LOG(ERR, "Cannot unmap vaddr for IOMMU, error "
 					"%i (%s)", errno, strerror(errno));
 			return -1;
 		}
 
-		ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
+		ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY, &reg);
 		if (ret) {
 			EAL_LOG(ERR,
 				"Cannot unregister vaddr for IOMMU, error "
@@ -1623,10 +1575,9 @@ vfio_spapr_dma_do_map(int vfio_container_fd, uint64_t vaddr, uint64_t iova,
 }
 
 static int
-vfio_spapr_map_walk(const struct rte_memseg_list *msl,
-		const struct rte_memseg *ms, void *arg)
+vfio_spapr_map_walk(const struct rte_memseg_list *msl, const struct rte_memseg *ms, void *arg)
 {
-	int *vfio_container_fd = arg;
+	struct vfio_container *cfg = arg;
 
 	/* skip external memory that isn't a heap */
 	if (msl->external && !msl->heap)
@@ -1636,8 +1587,7 @@ vfio_spapr_map_walk(const struct rte_memseg_list *msl,
 	if (ms->iova == RTE_BAD_IOVA)
 		return 0;
 
-	return vfio_spapr_dma_do_map(*vfio_container_fd,
-		ms->addr_64, ms->iova, ms->len, 1);
+	return vfio_spapr_dma_do_map(cfg, ms->addr_64, ms->iova, ms->len, 1);
 }
 
 struct spapr_size_walk_param {
@@ -1782,7 +1732,7 @@ spapr_dma_win_size(void)
 }
 
 static int
-vfio_spapr_create_dma_window(int vfio_container_fd)
+vfio_spapr_create_dma_window(struct vfio_container *cfg)
 {
 	struct vfio_iommu_spapr_tce_create create = {
 		.argsz = sizeof(create), };
@@ -1796,7 +1746,7 @@ vfio_spapr_create_dma_window(int vfio_container_fd)
 	if (ret < 0)
 		return ret;
 
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_GET_INFO, &info);
 	if (ret) {
 		EAL_LOG(ERR, "Cannot get IOMMU info, error %i (%s)",
 			errno, strerror(errno));
@@ -1809,7 +1759,7 @@ vfio_spapr_create_dma_window(int vfio_container_fd)
 	 * supports v2, remove the default DMA window so it can be resized.
 	 */
 	remove.start_addr = info.dma32_window_start;
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
 	if (ret)
 		return -1;
 
@@ -1817,7 +1767,7 @@ vfio_spapr_create_dma_window(int vfio_container_fd)
 	create.window_size = spapr_dma_win_len;
 	create.page_shift  = rte_ctz64(spapr_dma_win_page_sz);
 	create.levels = 1;
-	ret = ioctl(vfio_container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+	ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
 #ifdef VFIO_IOMMU_SPAPR_INFO_DDW
 	/*
 	 * The vfio_iommu_spapr_tce_info structure was modified in
@@ -1833,8 +1783,7 @@ vfio_spapr_create_dma_window(int vfio_container_fd)
 		for (levels = create.levels + 1;
 			ret && levels <= info.ddw.levels; levels++) {
 			create.levels = levels;
-			ret = ioctl(vfio_container_fd,
-				VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+			ret = ioctl(cfg->container_fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
 		}
 	}
 #endif /* VFIO_IOMMU_SPAPR_INFO_DDW */
@@ -1856,20 +1805,18 @@ vfio_spapr_create_dma_window(int vfio_container_fd)
 }
 
 static int
-vfio_spapr_dma_mem_map(int vfio_container_fd, uint64_t vaddr,
-		uint64_t iova, uint64_t len, int do_map)
+vfio_spapr_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
 {
 	int ret = 0;
 
 	if (do_map) {
-		if (vfio_spapr_dma_do_map(vfio_container_fd,
-			vaddr, iova, len, 1)) {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 1)) {
 			EAL_LOG(ERR, "Failed to map DMA");
 			ret = -1;
 		}
 	} else {
-		if (vfio_spapr_dma_do_map(vfio_container_fd,
-			vaddr, iova, len, 0)) {
+		if (vfio_spapr_dma_do_map(cfg, vaddr, iova, len, 0)) {
 			EAL_LOG(ERR, "Failed to unmap DMA");
 			ret = -1;
 		}
@@ -1879,42 +1826,40 @@ vfio_spapr_dma_mem_map(int vfio_container_fd, uint64_t vaddr,
 }
 
 static int
-vfio_spapr_dma_map(int vfio_container_fd)
+vfio_spapr_dma_map(struct vfio_container *cfg)
 {
-	if (vfio_spapr_create_dma_window(vfio_container_fd) < 0) {
+	if (vfio_spapr_create_dma_window(cfg) < 0) {
 		EAL_LOG(ERR, "Could not create new DMA window!");
 		return -1;
 	}
 
 	/* map all existing DPDK segments for DMA */
-	if (rte_memseg_walk(vfio_spapr_map_walk, &vfio_container_fd) < 0)
+	if (rte_memseg_walk(vfio_spapr_map_walk, cfg) < 0)
 		return -1;
 
 	return 0;
 }
 
 static int
-vfio_noiommu_dma_map(int __rte_unused vfio_container_fd)
+vfio_noiommu_dma_map(struct vfio_container *cfg __rte_unused)
 {
 	/* No-IOMMU mode does not need DMA mapping */
 	return 0;
 }
 
 static int
-vfio_noiommu_dma_mem_map(int __rte_unused vfio_container_fd,
-			 uint64_t __rte_unused vaddr,
-			 uint64_t __rte_unused iova, uint64_t __rte_unused len,
-			 int __rte_unused do_map)
+vfio_noiommu_dma_mem_map(struct vfio_container *cfg __rte_unused, uint64_t vaddr __rte_unused,
+		uint64_t iova __rte_unused, uint64_t len __rte_unused, int do_map __rte_unused)
 {
 	/* No-IOMMU mode does not need DMA mapping */
 	return 0;
 }
 
 static int
-vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
-		uint64_t len, int do_map)
+vfio_dma_mem_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len,
+		int do_map)
 {
-	const struct vfio_iommu_type *t = vfio_cfg->vfio_iommu_type;
+	const struct vfio_iommu_type *t = cfg->vfio_iommu_type;
 
 	if (!t) {
 		EAL_LOG(ERR, "VFIO support not initialized");
@@ -1930,20 +1875,18 @@ vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		return -1;
 	}
 
-	return t->dma_user_map_func(vfio_cfg->vfio_container_fd, vaddr, iova,
-			len, do_map);
+	return t->dma_user_map_func(cfg, vaddr, iova, len, do_map);
 }
 
 static int
-container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+container_dma_map(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
-	struct user_mem_map *new_map;
-	struct user_mem_maps *user_mem_maps;
+	struct vfio_user_mem_map *new_map;
+	struct vfio_user_mem_maps *user_mem_maps;
 	bool has_partial_unmap;
 	int ret = 0;
 
-	user_mem_maps = &vfio_cfg->mem_maps;
+	user_mem_maps = &cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
 	if (user_mem_maps->n_maps == RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "No more space for user mem maps");
@@ -1952,7 +1895,7 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		goto out;
 	}
 	/* map the entry */
-	if (vfio_dma_mem_map(vfio_cfg, vaddr, iova, len, 1)) {
+	if (vfio_dma_mem_map(cfg, vaddr, iova, len, 1)) {
 		/* technically, this will fail if there are currently no devices
 		 * plugged in, even if a device were added later, this mapping
 		 * might have succeeded. however, since we cannot verify if this
@@ -1965,7 +1908,7 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		goto out;
 	}
 	/* do we have partial unmap support? */
-	has_partial_unmap = vfio_cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = cfg->vfio_iommu_type->partial_unmap;
 
 	/* create new user mem map entry */
 	new_map = &user_mem_maps->maps[user_mem_maps->n_maps++];
@@ -1982,17 +1925,16 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 }
 
 static int
-container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
-		uint64_t len)
+container_dma_unmap(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova, uint64_t len)
 {
-	struct user_mem_map orig_maps[RTE_DIM(vfio_cfg->mem_maps.maps)];
-	struct user_mem_map new_maps[2]; /* can be at most 2 */
-	struct user_mem_maps *user_mem_maps;
+	struct vfio_user_mem_map orig_maps[RTE_DIM(cfg->mem_maps.maps)];
+	struct vfio_user_mem_map new_maps[2]; /* can be at most 2 */
+	struct vfio_user_mem_maps *user_mem_maps;
 	int n_orig, n_new, ret = 0;
 	bool has_partial_unmap;
 	unsigned int newlen;
 
-	user_mem_maps = &vfio_cfg->mem_maps;
+	user_mem_maps = &cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
 
 	/*
@@ -2024,7 +1966,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	}
 
 	/* do we have partial unmap capability? */
-	has_partial_unmap = vfio_cfg->vfio_iommu_type->partial_unmap;
+	has_partial_unmap = cfg->vfio_iommu_type->partial_unmap;
 
 	/*
 	 * if we don't support partial unmap, we must check if start and end of
@@ -2064,7 +2006,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 	}
 
 	/* unmap the entry */
-	if (vfio_dma_mem_map(vfio_cfg, vaddr, iova, len, 0)) {
+	if (vfio_dma_mem_map(cfg, vaddr, iova, len, 0)) {
 		/* there may not be any devices plugged in, so unmapping will
 		 * fail with ENODEV/ENOTSUP rte_errno values, but that doesn't
 		 * stop us from removing the mapping, as the assumption is we
@@ -2134,31 +2076,31 @@ dev_vfio_container_create(void)
 		return -1;
 
 	/* Find an empty slot to store new vfio config */
-	for (i = 1; i < RTE_DIM(vfio_cfgs); i++) {
-		if (vfio_cfgs[i].vfio_container_fd == -1)
+	for (i = 1; i < RTE_DIM(vfio_containers); i++) {
+		if (vfio_containers[i].container_fd == -1)
 			break;
 	}
 
-	if (i == RTE_DIM(vfio_cfgs)) {
+	if (i == RTE_DIM(vfio_containers)) {
 		EAL_LOG(ERR, "Exceed max VFIO container limit");
 		return -1;
 	}
 
 	/* Create a new container fd */
-	vfio_cfgs[i].vfio_container_fd = vfio_open_container_fd(false);
-	if (vfio_cfgs[i].vfio_container_fd < 0) {
+	vfio_containers[i].container_fd = vfio_open_container_fd(false);
+	if (vfio_containers[i].container_fd < 0) {
 		EAL_LOG(NOTICE, "Fail to create a new VFIO container");
 		return -1;
 	}
 
-	return vfio_cfgs[i].vfio_container_fd;
+	return vfio_containers[i].container_fd;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_destroy)
 int
 dev_vfio_container_destroy(int container_fd)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	unsigned int i;
 
 	if (!vfio_enabled)
@@ -2169,21 +2111,21 @@ dev_vfio_container_destroy(int container_fd)
 		return -1;
 	}
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
 		return -1;
 	}
 
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
-		if (vfio_cfg->vfio_groups[i].group_num != -1)
+	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++)
+		if (cfg->vfio_groups[i].group_num != -1)
 			vfio_container_group_unbind(container_fd,
-				vfio_cfg->vfio_groups[i].group_num);
+				cfg->vfio_groups[i].group_num);
 
 	close(container_fd);
-	vfio_cfg->vfio_container_fd = -1;
-	vfio_cfg->vfio_active_groups = 0;
-	vfio_cfg->vfio_iommu_type = NULL;
+	cfg->container_fd = -1;
+	cfg->vfio_active_groups = 0;
+	cfg->vfio_iommu_type = NULL;
 
 	return 0;
 }
@@ -2218,39 +2160,39 @@ dev_vfio_container_assign_device(int vfio_container_fd, const char *sysfs_base,
 static int
 vfio_container_group_bind(int container_fd, int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 
 	if (!vfio_enabled)
 		return -1;
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
 		return -1;
 	}
 
-	return vfio_get_group_fd(vfio_cfg, iommu_group_num);
+	return vfio_get_group_fd(cfg, iommu_group_num);
 }
 
 static int
 vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
 	struct vfio_group *cur_grp = NULL;
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 	unsigned int i;
 
 	if (!vfio_enabled)
 		return -1;
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
 		return -1;
 	}
 
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
-		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num) {
-			cur_grp = &vfio_cfg->vfio_groups[i];
+	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++) {
+		if (cfg->vfio_groups[i].group_num == iommu_group_num) {
+			cur_grp = &cfg->vfio_groups[i];
 			break;
 		}
 	}
@@ -2270,7 +2212,7 @@ vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	cur_grp->group_num = -1;
 	cur_grp->fd = -1;
 	cur_grp->devices = 0;
-	vfio_cfg->vfio_active_groups--;
+	cfg->vfio_active_groups--;
 
 	return 0;
 }
@@ -2280,7 +2222,7 @@ int
 dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 
 	if (!vfio_enabled)
 		return -1;
@@ -2290,13 +2232,13 @@ dev_vfio_container_dma_map(int container_fd, uint64_t vaddr, uint64_t iova,
 		return -1;
 	}
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
 		return -1;
 	}
 
-	return container_dma_map(vfio_cfg, vaddr, iova, len);
+	return container_dma_map(cfg, vaddr, iova, len);
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(dev_vfio_container_dma_unmap)
@@ -2304,7 +2246,7 @@ int
 dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
-	struct vfio_config *vfio_cfg;
+	struct vfio_container *cfg;
 
 	if (!vfio_enabled)
 		return -1;
@@ -2314,22 +2256,22 @@ dev_vfio_container_dma_unmap(int container_fd, uint64_t vaddr, uint64_t iova,
 		return -1;
 	}
 
-	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
-	if (vfio_cfg == NULL) {
+	cfg = get_vfio_cfg_by_container_fd(container_fd);
+	if (cfg == NULL) {
 		EAL_LOG(ERR, "Invalid VFIO container fd");
 		return -1;
 	}
 
-	return container_dma_unmap(vfio_cfg, vaddr, iova, len);
+	return container_dma_unmap(cfg, vaddr, iova, len);
 }
 
 static int
-vfio_cleanup_config(struct vfio_config *vfio_cfg)
+vfio_cleanup_config(struct vfio_container *cfg)
 {
 	unsigned int i;
 
-	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
-		struct vfio_group *group = &vfio_cfg->vfio_groups[i];
+	for (i = 0; i < RTE_DIM(cfg->vfio_groups); i++) {
+		struct vfio_group *group = &cfg->vfio_groups[i];
 
 		if (group->group_num == -1)
 			continue;
@@ -2347,26 +2289,26 @@ vfio_cleanup_config(struct vfio_config *vfio_cfg)
 		group->group_num = -1;
 		group->fd = -1;
 		group->devices = 0;
-		vfio_cfg->vfio_active_groups--;
+		cfg->vfio_active_groups--;
 	}
 
 	/* if there are still active groups, we cannot cleanup the container */
-	if (vfio_cfg->vfio_active_groups != 0) {
+	if (cfg->vfio_active_groups != 0) {
 		EAL_LOG(ERR, "Cannot cleanup VFIO container with %d active groups",
-			vfio_cfg->vfio_active_groups);
+			cfg->vfio_active_groups);
 		return -1;
 	}
 
-	if (vfio_cfg->vfio_container_fd >= 0 && close(vfio_cfg->vfio_container_fd) < 0) {
+	if (cfg->container_fd >= 0 && close(cfg->container_fd) < 0) {
 		EAL_LOG(ERR, "Cannot close VFIO container: %s", strerror(errno));
 		return -1;
 	}
 
-	vfio_cfg->vfio_container_fd = -1;
-	vfio_cfg->vfio_iommu_type = NULL;
+	cfg->container_fd = -1;
+	cfg->vfio_iommu_type = NULL;
 
-	vfio_cfg->mem_maps.n_maps = 0;
-	memset(vfio_cfg->mem_maps.maps, 0, sizeof(vfio_cfg->mem_maps.maps));
+	cfg->mem_maps.n_maps = 0;
+	memset(cfg->mem_maps.maps, 0, sizeof(cfg->mem_maps.maps));
 
 	return 0;
 }
@@ -2388,9 +2330,9 @@ dev_vfio_cleanup(void)
 		rte_mem_event_callback_unregister(VFIO_MEM_EVENT_CLB_NAME, NULL);
 
 	/* cleanup all initialized configs */
-	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
-		if (vfio_cfgs[i].vfio_container_fd != -1)
-			stuck |= vfio_cleanup_config(&vfio_cfgs[i]) != 0;
+	for (i = 0; i < RTE_DIM(vfio_containers); i++) {
+		if (vfio_containers[i].container_fd != -1)
+			stuck |= vfio_cleanup_config(&vfio_containers[i]) != 0;
 	}
 
 	/* failed to deinitialize some configs, so don't set VFIO as disabled */
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 30389fb274..cd37790ad2 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -9,6 +9,28 @@
 
 #include <stdint.h>
 
+/* hot plug/unplug of VFIO groups may cause all DMA maps to be dropped. we can
+ * recreate the mappings for DPDK segments, but we cannot do so for memory that
+ * was registered by the user themselves, so we need to store the user mappings
+ * somewhere, to recreate them later.
+ */
+#define EAL_VFIO_MAX_USER_MEM_MAPS 256
+
+/* user memory map entry */
+struct vfio_user_mem_map {
+	uint64_t addr;  /**< start VA */
+	uint64_t iova;  /**< start IOVA */
+	uint64_t len;   /**< total length of the mapping */
+	uint64_t chunk; /**< this mapping can be split in chunks of this size */
+};
+
+/* user memory maps container (common for all API modes) */
+struct vfio_user_mem_maps {
+	rte_spinlock_recursive_t lock;
+	int n_maps;
+	struct vfio_user_mem_map maps[EAL_VFIO_MAX_USER_MEM_MAPS];
+};
+
 /*
  * we don't need to store device fd's anywhere since they can be obtained from
  * the group fd via an ioctl() call.
@@ -19,18 +41,26 @@ struct vfio_group {
 	int devices;
 };
 
+struct vfio_container {
+	int container_fd;
+	int vfio_active_groups;
+	const struct vfio_iommu_type *vfio_iommu_type;
+	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
+	struct vfio_user_mem_maps mem_maps;
+};
+
 /* DMA mapping function prototype.
- * Takes VFIO container fd as a parameter.
+ * Takes VFIO container config as a parameter.
  * Returns 0 on success, -1 on error.
  */
-typedef int (*vfio_dma_func_t)(int);
+typedef int (*vfio_dma_func_t)(struct vfio_container *cfg);
 
 /* Custom memory region DMA mapping function prototype.
- * Takes VFIO container fd, virtual address, physical address, length and
+ * Takes VFIO container config, virtual address, physical address, length and
  * operation type (0 to unmap 1 for map) as a parameters.
  * Returns 0 on success, -1 on error.
  */
-typedef int (*vfio_dma_user_func_t)(int fd, uint64_t vaddr, uint64_t iova,
+typedef int (*vfio_dma_user_func_t)(struct vfio_container *cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len, int do_map);
 
 struct vfio_iommu_type {
@@ -62,12 +92,12 @@ void vfio_mp_sync_cleanup(void);
 
 #define EAL_VFIO_MP "eal_vfio_mp_sync"
 
-#define SOCKET_REQ_CONTAINER 0x100
-#define SOCKET_REQ_GROUP 0x200
-#define SOCKET_REQ_IOMMU_TYPE 0x400
-#define SOCKET_OK 0x0
-#define SOCKET_NO_FD 0x1
-#define SOCKET_ERR 0xFF
+#define VFIO_SOCKET_REQ_CONTAINER 0x100
+#define VFIO_SOCKET_REQ_GROUP 0x200
+#define VFIO_SOCKET_REQ_IOMMU_TYPE 0x400
+#define VFIO_SOCKET_OK 0x0
+#define VFIO_SOCKET_NO_FD 0x1
+#define VFIO_SOCKET_ERR 0xFF
 
 struct vfio_mp_param {
 	int req;
diff --git a/lib/eal/linux/eal_vfio_mp_sync.c b/lib/eal/linux/eal_vfio_mp_sync.c
index 66341a701a..f394f3d227 100644
--- a/lib/eal/linux/eal_vfio_mp_sync.c
+++ b/lib/eal/linux/eal_vfio_mp_sync.c
@@ -31,46 +31,46 @@ vfio_mp_primary(const struct rte_mp_msg *msg, const void *peer)
 	memset(&reply, 0, sizeof(reply));
 
 	switch (m->req) {
-	case SOCKET_REQ_GROUP:
-		r->req = SOCKET_REQ_GROUP;
+	case VFIO_SOCKET_REQ_GROUP:
+		r->req = VFIO_SOCKET_REQ_GROUP;
 		r->group_num = m->group_num;
 		fd = vfio_get_group_fd_by_num(m->group_num);
 		if (fd < 0 && fd != -ENOENT)
-			r->result = SOCKET_ERR;
+			r->result = VFIO_SOCKET_ERR;
 		else if (fd == -ENOENT)
 			/* if VFIO group exists but isn't bound to VFIO driver */
-			r->result = SOCKET_NO_FD;
+			r->result = VFIO_SOCKET_NO_FD;
 		else {
 			/* if group exists and is bound to VFIO driver */
-			r->result = SOCKET_OK;
+			r->result = VFIO_SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
 		break;
-	case SOCKET_REQ_CONTAINER:
-		r->req = SOCKET_REQ_CONTAINER;
+	case VFIO_SOCKET_REQ_CONTAINER:
+		r->req = VFIO_SOCKET_REQ_CONTAINER;
 		fd = dev_vfio_get_container_fd();
 		if (fd < 0)
-			r->result = SOCKET_ERR;
+			r->result = VFIO_SOCKET_ERR;
 		else {
-			r->result = SOCKET_OK;
+			r->result = VFIO_SOCKET_OK;
 			reply.num_fds = 1;
 			reply.fds[0] = fd;
 		}
 		break;
-	case SOCKET_REQ_IOMMU_TYPE:
+	case VFIO_SOCKET_REQ_IOMMU_TYPE:
 	{
 		int iommu_type_id;
 
-		r->req = SOCKET_REQ_IOMMU_TYPE;
+		r->req = VFIO_SOCKET_REQ_IOMMU_TYPE;
 
 		iommu_type_id = vfio_get_iommu_type();
 
 		if (iommu_type_id < 0)
-			r->result = SOCKET_ERR;
+			r->result = VFIO_SOCKET_ERR;
 		else {
 			r->iommu_type_id = iommu_type_id;
-			r->result = SOCKET_OK;
+			r->result = VFIO_SOCKET_OK;
 		}
 		break;
 	}
-- 
2.54.0

