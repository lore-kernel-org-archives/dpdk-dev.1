Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA968CA1009
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:14:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 270ED40E1C;
	Wed,  3 Sep 2025 17:14:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5C25C40E16
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:14:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhGsLWyBZYW2Hvi/I9Ba6Km0jEzHnSIdyx8CWe3EwUU=;
 b=C9/S7gUV+9RZAye+RupJ4yQ+4+aVCMXeC2HYi8RyVBlDci2ey6FX+307IKYy/EcsXTReWj
 d6CF5o7Ecwr/scfFAXzRNMNB8/KmoACqBglWWmspP8syfYrmj6smDg6ACWHzCLJtNbE8Zu
 5d8QtoZFpvJpq/uGlfPmAzNPvwBCreI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-P-ve-HWMM1eNY9fBN7R0sA-1; Wed,
 03 Sep 2025 11:14:07 -0400
X-MC-Unique: P-ve-HWMM1eNY9fBN7R0sA-1
X-Mimecast-MFC-AGG-ID: P-ve-HWMM1eNY9fBN7R0sA_1756912446
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0735B1800359; Wed,  3 Sep 2025 15:14:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 216D030001B0; Wed,  3 Sep 2025 15:14:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com
Subject: [RFC v2 5/9] eal/linux: remove more internal VFIO macros
Date: Wed,  3 Sep 2025 17:13:22 +0200
Message-ID: <20250903151327.1964490-6-david.marchand@redhat.com>
In-Reply-To: <20250903151327.1964490-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151327.1964490-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JcCMq7I4kBlM6cXpx4YtBFm6DLwvgiTWha0o4qa5YFE_1756912446
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

No need to redefine some VFIO_* macros that look like a define coming
from standard linux/vfio.h header.
Use RTE_DIM() and remove unneeded checks (like in get_vfio_group_idx()
where j can't be >= RTE_DIM(vfio_cfg->vfio_groups)).

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 lib/eal/linux/eal_vfio.c | 97 ++++++++++++++++++++--------------------
 lib/eal/linux/eal_vfio.h |  3 --
 2 files changed, 49 insertions(+), 51 deletions(-)

diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index dfc3bd6e62..1eab90a261 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -29,7 +29,7 @@
  * was registered by the user themselves, so we need to store the user mappings
  * somewhere, to recreate them later.
  */
-#define VFIO_MAX_USER_MEM_MAPS 256
+#define EAL_VFIO_MAX_USER_MEM_MAPS 256
 struct user_mem_map {
 	uint64_t addr;  /**< start VA */
 	uint64_t iova;  /**< start IOVA */
@@ -40,7 +40,7 @@ struct user_mem_map {
 struct user_mem_maps {
 	rte_spinlock_recursive_t lock;
 	int n_maps;
-	struct user_mem_map maps[VFIO_MAX_USER_MEM_MAPS];
+	struct user_mem_map maps[EAL_VFIO_MAX_USER_MEM_MAPS];
 };
 
 struct vfio_config {
@@ -48,12 +48,12 @@ struct vfio_config {
 	int vfio_container_fd;
 	int vfio_active_groups;
 	const struct vfio_iommu_type *vfio_iommu_type;
-	struct vfio_group vfio_groups[VFIO_MAX_GROUPS];
+	struct vfio_group vfio_groups[RTE_MAX_VFIO_GROUPS];
 	struct user_mem_maps mem_maps;
 };
 
 /* per-process VFIO config */
-static struct vfio_config vfio_cfgs[VFIO_MAX_CONTAINERS];
+static struct vfio_config vfio_cfgs[RTE_MAX_VFIO_CONTAINERS];
 static struct vfio_config *default_vfio_cfg = &vfio_cfgs[0];
 
 static int vfio_type1_dma_map(int);
@@ -183,10 +183,10 @@ static void
 delete_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *del_maps,
 		size_t n_del)
 {
-	int i;
+	unsigned int i;
 	size_t j;
 
-	for (i = 0, j = 0; i < VFIO_MAX_USER_MEM_MAPS && j < n_del; i++) {
+	for (i = 0, j = 0; i < RTE_DIM(user_mem_maps->maps) && j < n_del; i++) {
 		struct user_mem_map *left = &user_mem_maps->maps[i];
 		struct user_mem_map *right = &del_maps[j];
 
@@ -202,10 +202,10 @@ static void
 copy_maps(struct user_mem_maps *user_mem_maps, struct user_mem_map *add_maps,
 		size_t n_add)
 {
-	int i;
+	unsigned int i;
 	size_t j;
 
-	for (i = 0, j = 0; i < VFIO_MAX_USER_MEM_MAPS && j < n_add; i++) {
+	for (i = 0, j = 0; i < RTE_DIM(user_mem_maps->maps) && j < n_add; i++) {
 		struct user_mem_map *left = &user_mem_maps->maps[i];
 		struct user_mem_map *right = &add_maps[j];
 
@@ -321,13 +321,13 @@ find_user_mem_maps(struct user_mem_maps *user_mem_maps, uint64_t addr,
 static void
 compact_user_maps(struct user_mem_maps *user_mem_maps)
 {
-	int i;
+	unsigned int i;
 
-	qsort(user_mem_maps->maps, VFIO_MAX_USER_MEM_MAPS,
+	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps),
 			sizeof(user_mem_maps->maps[0]), user_mem_map_cmp);
 
 	/* we'll go over the list backwards when merging */
-	for (i = VFIO_MAX_USER_MEM_MAPS - 2; i >= 0; i--) {
+	for (i = RTE_DIM(user_mem_maps->maps) - 2; i != 0; i--) {
 		struct user_mem_map *l, *r;
 
 		l = &user_mem_maps->maps[i];
@@ -344,7 +344,7 @@ compact_user_maps(struct user_mem_maps *user_mem_maps)
 	/* the entries are still sorted, but now they have holes in them, so
 	 * sort the list again.
 	 */
-	qsort(user_mem_maps->maps, VFIO_MAX_USER_MEM_MAPS,
+	qsort(user_mem_maps->maps, RTE_DIM(user_mem_maps->maps),
 			sizeof(user_mem_maps->maps[0]), user_mem_map_cmp);
 }
 
@@ -423,11 +423,11 @@ static struct vfio_config *
 get_vfio_cfg_by_group_num(int iommu_group_num)
 {
 	struct vfio_config *vfio_cfg;
-	int i, j;
+	unsigned int i, j;
 
-	for (i = 0; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < VFIO_MAX_GROUPS; j++) {
+		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++) {
 			if (vfio_cfg->vfio_groups[j].group_num ==
 					iommu_group_num)
 				return vfio_cfg;
@@ -441,30 +441,30 @@ static int
 vfio_get_group_fd(struct vfio_config *vfio_cfg,
 		int iommu_group_num)
 {
-	int i;
+	struct vfio_group *cur_grp = NULL;
 	int vfio_group_fd;
-	struct vfio_group *cur_grp;
+	unsigned int i;
 
 	/* check if we already have the group descriptor open */
-	for (i = 0; i < VFIO_MAX_GROUPS; i++)
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num)
 			return vfio_cfg->vfio_groups[i].fd;
 
 	/* Lets see first if there is room for a new group */
-	if (vfio_cfg->vfio_active_groups == VFIO_MAX_GROUPS) {
+	if (vfio_cfg->vfio_active_groups == RTE_DIM(vfio_cfg->vfio_groups)) {
 		EAL_LOG(ERR, "Maximum number of VFIO groups reached!");
 		return -1;
 	}
 
 	/* Now lets get an index for the new group */
-	for (i = 0; i < VFIO_MAX_GROUPS; i++)
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num == -1) {
 			cur_grp = &vfio_cfg->vfio_groups[i];
 			break;
 		}
 
 	/* This should not happen */
-	if (i == VFIO_MAX_GROUPS) {
+	if (cur_grp == NULL) {
 		EAL_LOG(ERR, "No VFIO group free slot found");
 		return -1;
 	}
@@ -487,11 +487,11 @@ static struct vfio_config *
 get_vfio_cfg_by_group_fd(int vfio_group_fd)
 {
 	struct vfio_config *vfio_cfg;
-	int i, j;
+	unsigned int i, j;
 
-	for (i = 0; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < VFIO_MAX_GROUPS; j++)
+		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
 			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
 				return vfio_cfg;
 	}
@@ -502,12 +502,12 @@ get_vfio_cfg_by_group_fd(int vfio_group_fd)
 static struct vfio_config *
 get_vfio_cfg_by_container_fd(int container_fd)
 {
-	int i;
+	unsigned int i;
 
 	if (container_fd == RTE_VFIO_DEFAULT_CONTAINER_FD)
 		return default_vfio_cfg;
 
-	for (i = 0; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		if (vfio_cfgs[i].vfio_container_fd == container_fd)
 			return &vfio_cfgs[i];
 	}
@@ -532,11 +532,11 @@ static int
 get_vfio_group_idx(int vfio_group_fd)
 {
 	struct vfio_config *vfio_cfg;
-	int i, j;
+	unsigned int i, j;
 
-	for (i = 0; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfg = &vfio_cfgs[i];
-		for (j = 0; j < VFIO_MAX_GROUPS; j++)
+		for (j = 0; j < RTE_DIM(vfio_cfg->vfio_groups); j++)
 			if (vfio_cfg->vfio_groups[j].fd == vfio_group_fd)
 				return j;
 	}
@@ -557,7 +557,7 @@ vfio_group_device_get(int vfio_group_fd)
 	}
 
 	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0 || i > (VFIO_MAX_GROUPS - 1))
+	if (i < 0)
 		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
 	else
 		vfio_cfg->vfio_groups[i].devices++;
@@ -576,7 +576,7 @@ vfio_group_device_put(int vfio_group_fd)
 	}
 
 	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0 || i > (VFIO_MAX_GROUPS - 1))
+	if (i < 0)
 		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
 	else
 		vfio_cfg->vfio_groups[i].devices--;
@@ -595,7 +595,7 @@ vfio_group_device_count(int vfio_group_fd)
 	}
 
 	i = get_vfio_group_idx(vfio_group_fd);
-	if (i < 0 || i > (VFIO_MAX_GROUPS - 1)) {
+	if (i < 0) {
 		EAL_LOG(ERR, "Wrong VFIO group index (%d)", i);
 		return -1;
 	}
@@ -1086,7 +1086,7 @@ int
 rte_vfio_enable(const char *modname)
 {
 	/* initialize group list */
-	int i, j;
+	unsigned int i, j;
 	int vfio_available;
 	DIR *dir;
 	const struct internal_config *internal_conf =
@@ -1094,13 +1094,13 @@ rte_vfio_enable(const char *modname)
 
 	rte_spinlock_recursive_t lock = RTE_SPINLOCK_RECURSIVE_INITIALIZER;
 
-	for (i = 0; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfgs); i++) {
 		vfio_cfgs[i].vfio_container_fd = -1;
 		vfio_cfgs[i].vfio_active_groups = 0;
 		vfio_cfgs[i].vfio_iommu_type = NULL;
 		vfio_cfgs[i].mem_maps.lock = lock;
 
-		for (j = 0; j < VFIO_MAX_GROUPS; j++) {
+		for (j = 0; j < RTE_DIM(vfio_cfgs[i].vfio_groups); j++) {
 			vfio_cfgs[i].vfio_groups[j].fd = -1;
 			vfio_cfgs[i].vfio_groups[j].group_num = -1;
 			vfio_cfgs[i].vfio_groups[j].devices = 0;
@@ -1895,7 +1895,7 @@ container_dma_map(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 
 	user_mem_maps = &vfio_cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
-	if (user_mem_maps->n_maps == VFIO_MAX_USER_MEM_MAPS) {
+	if (user_mem_maps->n_maps == RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "No more space for user mem maps");
 		rte_errno = ENOMEM;
 		ret = -1;
@@ -1935,11 +1935,12 @@ static int
 container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 		uint64_t len)
 {
-	struct user_mem_map orig_maps[VFIO_MAX_USER_MEM_MAPS];
+	struct user_mem_map orig_maps[RTE_DIM(vfio_cfg->mem_maps.maps)];
 	struct user_mem_map new_maps[2]; /* can be at most 2 */
 	struct user_mem_maps *user_mem_maps;
-	int n_orig, n_new, newlen, ret = 0;
+	int n_orig, n_new, ret = 0;
 	bool has_partial_unmap;
+	unsigned int newlen;
 
 	user_mem_maps = &vfio_cfg->mem_maps;
 	rte_spinlock_recursive_lock(&user_mem_maps->lock);
@@ -2005,7 +2006,7 @@ container_dma_unmap(struct vfio_config *vfio_cfg, uint64_t vaddr, uint64_t iova,
 
 	/* can we store the new maps in our list? */
 	newlen = (user_mem_maps->n_maps - n_orig) + n_new;
-	if (newlen >= VFIO_MAX_USER_MEM_MAPS) {
+	if (newlen >= RTE_DIM(user_mem_maps->maps)) {
 		EAL_LOG(ERR, "Not enough space to store partial mapping");
 		rte_errno = ENOMEM;
 		ret = -1;
@@ -2077,15 +2078,15 @@ RTE_EXPORT_SYMBOL(rte_vfio_container_create)
 int
 rte_vfio_container_create(void)
 {
-	int i;
+	unsigned int i;
 
 	/* Find an empty slot to store new vfio config */
-	for (i = 1; i < VFIO_MAX_CONTAINERS; i++) {
+	for (i = 1; i < RTE_DIM(vfio_cfgs); i++) {
 		if (vfio_cfgs[i].vfio_container_fd == -1)
 			break;
 	}
 
-	if (i == VFIO_MAX_CONTAINERS) {
+	if (i == RTE_DIM(vfio_cfgs)) {
 		EAL_LOG(ERR, "Exceed max VFIO container limit");
 		return -1;
 	}
@@ -2104,7 +2105,7 @@ int
 rte_vfio_container_destroy(int container_fd)
 {
 	struct vfio_config *vfio_cfg;
-	int i;
+	unsigned int i;
 
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
@@ -2112,7 +2113,7 @@ rte_vfio_container_destroy(int container_fd)
 		return -1;
 	}
 
-	for (i = 0; i < VFIO_MAX_GROUPS; i++)
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++)
 		if (vfio_cfg->vfio_groups[i].group_num != -1)
 			rte_vfio_container_group_unbind(container_fd,
 				vfio_cfg->vfio_groups[i].group_num);
@@ -2144,9 +2145,9 @@ RTE_EXPORT_SYMBOL(rte_vfio_container_group_unbind)
 int
 rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 {
-	struct vfio_config *vfio_cfg;
 	struct vfio_group *cur_grp = NULL;
-	int i;
+	struct vfio_config *vfio_cfg;
+	unsigned int i;
 
 	vfio_cfg = get_vfio_cfg_by_container_fd(container_fd);
 	if (vfio_cfg == NULL) {
@@ -2154,7 +2155,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 		return -1;
 	}
 
-	for (i = 0; i < VFIO_MAX_GROUPS; i++) {
+	for (i = 0; i < RTE_DIM(vfio_cfg->vfio_groups); i++) {
 		if (vfio_cfg->vfio_groups[i].group_num == iommu_group_num) {
 			cur_grp = &vfio_cfg->vfio_groups[i];
 			break;
@@ -2162,7 +2163,7 @@ rte_vfio_container_group_unbind(int container_fd, int iommu_group_num)
 	}
 
 	/* This should not happen */
-	if (i == VFIO_MAX_GROUPS || cur_grp == NULL) {
+	if (cur_grp == NULL) {
 		EAL_LOG(ERR, "Specified VFIO group number not found");
 		return -1;
 	}
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index e7d855c032..413c8f18df 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -69,9 +69,6 @@ struct vfio_iommu_spapr_tce_info {
 #define RTE_VFIO_SPAPR VFIO_SPAPR_TCE_v2_IOMMU
 #endif
 
-#define VFIO_MAX_GROUPS RTE_MAX_VFIO_GROUPS
-#define VFIO_MAX_CONTAINERS RTE_MAX_VFIO_CONTAINERS
-
 /*
  * we don't need to store device fd's anywhere since they can be obtained from
  * the group fd via an ioctl() call.
-- 
2.51.0

