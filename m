Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768ED104C007
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D34A40E3E;
	Wed, 11 Mar 2026 11:59:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CF3E540431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773226739; x=1804762739;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=1A39QAMJOSSrMfANMGCKvPayAEXUUdRikianwoaNsdY=;
 b=mA3fV6VCxMmICcmL4nzhIUXKtlUnCgf4NXAx03gw92TbKOHkSvo5YqnA
 ZLle2oXMNdYib+U0tJNnDY66nHcFrFrq2EBF1BOnPO6w0Hpd8Gfq386Wk
 lDoQzybXZluiYvG/dYJC7mQTxrrxLcEJOHFmf2crMnV0dn5dwIsld6CcF
 z1pg9fS+wkleVa57vgkJcG6MDbXx042vkFdVdjy+oYbsnsS0tnvER8BnG
 S1gxiuFgw4WOSix9RaPEog+gk5Kal+su8Ph5iHOMoj72POZQHj72h9yYi
 ChZmHzsY1sSFQRdRGbPPRIM2Kphxtw45W6TKW3BNrLkZqHJrvwZU1TSkl g==;
X-CSE-ConnectionGUID: D3+AkJgiTFiW7AOjnXeLHA==
X-CSE-MsgGUID: E/wkwns+QfyudK7ib3Lb3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74481619"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74481619"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 03:58:59 -0700
X-CSE-ConnectionGUID: aN/O1L+QRY+JFJP2LK2+uQ==
X-CSE-MsgGUID: 86W6jIS7TyW96GXcDbTjEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="250928197"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 03:58:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/5] eal/memory: always use one segment per memory type
Date: Wed, 11 Mar 2026 10:58:49 +0000
Message-ID: <e167cf792fed73f26dc0f9883849a51261e266c1.1773225702.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773225702.git.anatoly.burakov@intel.com>
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

Initially, the dynamic memory mode has used multiple segment lists for
backing of different memory types, with the motivation being that it should
be easier for secondary processes to map many smaller segments than fewer
but larger ones, but in practice this does not seem to make any difference.

To reduce the amount of complexity in how memory segment lists are handled,
collapse the multi-list logic to always use single segment list.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 config/rte_config.h                           |  2 -
 .../prog_guide/env_abstraction_layer.rst      |  4 -
 lib/eal/common/eal_common_dynmem.c            | 97 +++++--------------
 lib/eal/common/eal_common_memory.c            |  7 +-
 lib/eal/common/eal_private.h                  |  2 +-
 lib/eal/freebsd/eal_memory.c                  | 70 ++++---------
 lib/eal/linux/eal_memalloc.c                  |  2 +-
 lib/eal/linux/eal_memory.c                    | 87 ++++++-----------
 8 files changed, 80 insertions(+), 191 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index a2609fa403..0447cdf2ad 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -43,8 +43,6 @@
 #define RTE_MAX_HEAPS 32
 #define RTE_MAX_LCORE_VAR 131072
 #define RTE_MAX_MEMSEG_LISTS 128
-#define RTE_MAX_MEMSEG_PER_LIST 8192
-#define RTE_MAX_MEM_MB_PER_LIST 32768
 #define RTE_MAX_MEMSEG_PER_TYPE 32768
 #define RTE_MAX_MEM_MB_PER_TYPE 65536
 #define RTE_MAX_TAILQ 32
diff --git a/doc/guides/prog_guide/env_abstraction_layer.rst b/doc/guides/prog_guide/env_abstraction_layer.rst
index d716895c1d..04368a3950 100644
--- a/doc/guides/prog_guide/env_abstraction_layer.rst
+++ b/doc/guides/prog_guide/env_abstraction_layer.rst
@@ -204,10 +204,6 @@ of virtual memory being preallocated at startup by editing the following config
 variables:
 
 * ``RTE_MAX_MEMSEG_LISTS`` controls how many segment lists can DPDK have
-* ``RTE_MAX_MEM_MB_PER_LIST`` controls how much megabytes of memory each
-  segment list can address
-* ``RTE_MAX_MEMSEG_PER_LIST`` controls how many segments each segment list
-  can have
 * ``RTE_MAX_MEMSEG_PER_TYPE`` controls how many segments each memory type
   can have (where "type" is defined as "page size + NUMA node" combination)
 * ``RTE_MAX_MEM_MB_PER_TYPE`` controls how much megabytes of memory each
diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 8f51d6dd4a..86da2bd80b 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -28,7 +28,6 @@ eal_dynmem_memseg_lists_init(void)
 	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, max_mem_per_type;
-	unsigned int max_seglists_per_type;
 	unsigned int n_memtypes, cur_type;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
@@ -45,8 +44,7 @@ eal_dynmem_memseg_lists_init(void)
 	 *
 	 * deciding amount of memory going towards each memory type is a
 	 * balancing act between maximum segments per type, maximum memory per
-	 * type, and number of detected NUMA nodes. the goal is to make sure
-	 * each memory type gets at least one memseg list.
+	 * type, and number of detected NUMA nodes.
 	 *
 	 * the total amount of memory is limited by RTE_MAX_MEM_MB value.
 	 *
@@ -57,19 +55,9 @@ eal_dynmem_memseg_lists_init(void)
 	 * smaller page sizes, it can take hundreds of thousands of segments to
 	 * reach the above specified per-type memory limits.
 	 *
-	 * additionally, each type may have multiple memseg lists associated
-	 * with it, each limited by either RTE_MAX_MEM_MB_PER_LIST for bigger
-	 * page sizes, or RTE_MAX_MEMSEG_PER_LIST segments for smaller ones.
-	 *
-	 * the number of memseg lists per type is decided based on the above
-	 * limits, and also taking number of detected NUMA nodes, to make sure
-	 * that we don't run out of memseg lists before we populate all NUMA
-	 * nodes with memory.
-	 *
-	 * we do this in three stages. first, we collect the number of types.
-	 * then, we figure out memory constraints and populate the list of
-	 * would-be memseg lists. then, we go ahead and allocate the memseg
-	 * lists.
+	 * each memory type is allotted a single memseg list. the size of that
+	 * list is calculated here to respect the per-type memory and segment
+	 * limits that apply.
 	 */
 
 	/* create space for mem types */
@@ -109,89 +97,56 @@ eal_dynmem_memseg_lists_init(void)
 	/* number of memtypes could have been lower due to no NUMA support */
 	n_memtypes = cur_type;
 
+	/* can we fit all memtypes into the memseg lists? */
+	if (n_memtypes > RTE_MAX_MEMSEG_LISTS) {
+		EAL_LOG(ERR, "Too many memory types detected: %u. Please increase "
+			"RTE_MAX_MEMSEG_LISTS in configuration.", n_memtypes);
+		goto out;
+	}
+
 	/* set up limits for types */
 	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
 	max_mem_per_type = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
 			max_mem / n_memtypes);
-	/*
-	 * limit maximum number of segment lists per type to ensure there's
-	 * space for memseg lists for all NUMA nodes with all page sizes
-	 */
-	max_seglists_per_type = RTE_MAX_MEMSEG_LISTS / n_memtypes;
-
-	if (max_seglists_per_type == 0) {
-		EAL_LOG(ERR, "Cannot accommodate all memory types, please increase RTE_MAX_MEMSEG_LISTS");
-		goto out;
-	}
 
 	/* go through all mem types and create segment lists */
 	msl_idx = 0;
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
-		unsigned int cur_seglist, n_seglists, n_segs;
-		unsigned int max_segs_per_type, max_segs_per_list;
+		unsigned int n_segs;
+		unsigned int max_segs_per_type;
 		struct memtype *type = &memtypes[cur_type];
-		uint64_t max_mem_per_list, pagesz;
+		uint64_t pagesz;
 		int socket_id;
 
 		pagesz = type->page_sz;
 		socket_id = type->socket_id;
 
 		/*
-		 * we need to create segment lists for this type. we must take
+		 * we need to create a segment list for this type. we must take
 		 * into account the following things:
 		 *
-		 * 1. total amount of memory we can use for this memory type
-		 * 2. total amount of memory per memseg list allowed
+		 * 1. total amount of memory to use for this memory type
+		 * 2. total amount of memory allowed per type
 		 * 3. number of segments needed to fit the amount of memory
 		 * 4. number of segments allowed per type
-		 * 5. number of segments allowed per memseg list
-		 * 6. number of memseg lists we are allowed to take up
 		 */
-
-		/* calculate how much segments we will need in total */
 		max_segs_per_type = max_mem_per_type / pagesz;
-		/* limit number of segments to maximum allowed per type */
 		max_segs_per_type = RTE_MIN(max_segs_per_type,
 				(unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
-		/* limit number of segments to maximum allowed per list */
-		max_segs_per_list = RTE_MIN(max_segs_per_type,
-				(unsigned int)RTE_MAX_MEMSEG_PER_LIST);
+		n_segs = max_segs_per_type;
 
-		/* calculate how much memory we can have per segment list */
-		max_mem_per_list = RTE_MIN(max_segs_per_list * pagesz,
-				(uint64_t)RTE_MAX_MEM_MB_PER_LIST << 20);
-
-		/* calculate how many segments each segment list will have */
-		n_segs = RTE_MIN(max_segs_per_list, max_mem_per_list / pagesz);
-
-		/* calculate how many segment lists we can have */
-		n_seglists = RTE_MIN(max_segs_per_type / n_segs,
-				max_mem_per_type / max_mem_per_list);
-
-		/* limit number of segment lists according to our maximum */
-		n_seglists = RTE_MIN(n_seglists, max_seglists_per_type);
-
-		EAL_LOG(DEBUG, "Creating %i segment lists: "
+		EAL_LOG(DEBUG, "Creating segment list: "
 				"n_segs:%i socket_id:%i hugepage_sz:%" PRIu64,
-			n_seglists, n_segs, socket_id, pagesz);
+			n_segs, socket_id, pagesz);
 
-		/* create all segment lists */
-		for (cur_seglist = 0; cur_seglist < n_seglists; cur_seglist++) {
-			if (msl_idx >= RTE_MAX_MEMSEG_LISTS) {
-				EAL_LOG(ERR,
-					"No more space in memseg lists, please increase RTE_MAX_MEMSEG_LISTS");
-				goto out;
-			}
-			msl = &mcfg->memsegs[msl_idx++];
+		msl = &mcfg->memsegs[msl_idx++];
 
-			if (eal_memseg_list_init(msl, pagesz, n_segs,
-					socket_id, cur_seglist, true))
-				goto out;
+		if (eal_memseg_list_init(msl, pagesz, n_segs, socket_id, true))
+			goto out;
 
-			if (eal_memseg_list_alloc(msl, 0)) {
-				EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
-				goto out;
-			}
+		if (eal_memseg_list_alloc(msl, 0)) {
+			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
+			goto out;
 		}
 	}
 	/* we're successful */
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index dccf9406c5..e8e41bb741 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -40,7 +40,7 @@
  * which is a multiple of hugepage size.
  */
 
-#define MEMSEG_LIST_FMT "memseg-%" PRIu64 "k-%i-%i"
+#define MEMSEG_LIST_FMT "memseg-%" PRIu64 "k-%i"
 
 static void *next_baseaddr;
 static uint64_t system_page_sz;
@@ -228,12 +228,11 @@ eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
 
 int
 eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
-		int n_segs, int socket_id, int type_msl_idx, bool heap)
+		int n_segs, int socket_id, bool heap)
 {
 	char name[RTE_FBARRAY_NAME_LEN];
 
-	snprintf(name, sizeof(name), MEMSEG_LIST_FMT, page_sz >> 10, socket_id,
-		 type_msl_idx);
+	snprintf(name, sizeof(name), MEMSEG_LIST_FMT, page_sz >> 10, socket_id);
 
 	return eal_memseg_list_init_named(
 		msl, name, page_sz, n_segs, socket_id, heap);
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index e032dd10c9..40408d61b4 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -306,7 +306,7 @@ eal_memseg_list_init_named(struct rte_memseg_list *msl, const char *name,
  */
 int
 eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
-	int n_segs, int socket_id, int type_msl_idx, bool heap);
+		int n_segs, int socket_id, bool heap);
 
 /**
  * Reserve VA space for a memory segment list
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index cd608db9f9..36dcc04ce4 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -190,7 +190,7 @@ rte_eal_hugepage_init(void)
 				break;
 			}
 			if (msl_idx == RTE_MAX_MEMSEG_LISTS) {
-				EAL_LOG(ERR, "Could not find space for memseg. Please increase RTE_MAX_MEMSEG_PER_LIST "
+				EAL_LOG(ERR, "Could not find space for memseg. Please increase "
 					"RTE_MAX_MEMSEG_PER_TYPE and/or RTE_MAX_MEM_MB_PER_TYPE in configuration.");
 				return -1;
 			}
@@ -320,23 +320,6 @@ rte_eal_using_phys_addrs(void)
 	return 0;
 }
 
-static uint64_t
-get_mem_amount(uint64_t page_sz, uint64_t max_mem)
-{
-	uint64_t area_sz, max_pages;
-
-	/* limit to RTE_MAX_MEMSEG_PER_LIST pages or RTE_MAX_MEM_MB_PER_LIST */
-	max_pages = RTE_MAX_MEMSEG_PER_LIST;
-	max_mem = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_LIST << 20, max_mem);
-
-	area_sz = RTE_MIN(page_sz * max_pages, max_mem);
-
-	/* make sure the list isn't smaller than the page size */
-	area_sz = RTE_MAX(area_sz, page_sz);
-
-	return RTE_ALIGN(area_sz, page_sz);
-}
-
 static int
 memseg_list_alloc(struct rte_memseg_list *msl)
 {
@@ -380,9 +363,10 @@ memseg_primary_init(void)
 			hpi_idx++) {
 		uint64_t max_type_mem, total_type_mem = 0;
 		uint64_t avail_mem;
-		int type_msl_idx, max_segs, avail_segs, total_segs = 0;
+		int max_segs, avail_segs;
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
+		unsigned int n_segs;
 
 		hpi = &internal_conf->hugepage_info[hpi_idx];
 		hugepage_sz = hpi->hugepage_sz;
@@ -413,40 +397,28 @@ memseg_primary_init(void)
 
 		max_type_mem = RTE_MIN(avail_mem, max_type_mem);
 		max_segs = RTE_MIN(avail_segs, max_segs);
+		n_segs = RTE_MIN(max_type_mem / hugepage_sz, (uint64_t)max_segs);
+		if (n_segs == 0)
+			continue;
+
+		if (msl_idx >= RTE_MAX_MEMSEG_LISTS) {
+			EAL_LOG(ERR,
+				"No more space in memseg lists, please increase RTE_MAX_MEMSEG_LISTS");
+			return -1;
+		}
 
-		type_msl_idx = 0;
-		while (total_type_mem < max_type_mem &&
-				total_segs < max_segs) {
-			uint64_t cur_max_mem, cur_mem;
-			unsigned int n_segs;
-
-			if (msl_idx >= RTE_MAX_MEMSEG_LISTS) {
-				EAL_LOG(ERR,
-					"No more space in memseg lists, please increase RTE_MAX_MEMSEG_LISTS");
-				return -1;
-			}
-
-			msl = &mcfg->memsegs[msl_idx++];
-
-			cur_max_mem = max_type_mem - total_type_mem;
-
-			cur_mem = get_mem_amount(hugepage_sz,
-					cur_max_mem);
-			n_segs = cur_mem / hugepage_sz;
-
-			if (eal_memseg_list_init(msl, hugepage_sz, n_segs,
-					0, type_msl_idx, false))
-				return -1;
+		msl = &mcfg->memsegs[msl_idx++];
 
-			total_segs += msl->memseg_arr.len;
-			total_type_mem = total_segs * hugepage_sz;
-			type_msl_idx++;
+		if (eal_memseg_list_init(msl, hugepage_sz, n_segs,
+				0, false))
+			return -1;
 
-			if (memseg_list_alloc(msl)) {
-				EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
-				return -1;
-			}
+		total_type_mem = n_segs * hugepage_sz;
+		if (memseg_list_alloc(msl)) {
+			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
+			return -1;
 		}
+
 		total_mem += total_type_mem;
 	}
 	return 0;
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index a39bc31c7b..87e40e4465 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -283,7 +283,7 @@ get_seg_fd(char *path, int buflen, struct hugepage_info *hi,
 	} else {
 		out_fd = &fd_list[list_idx].fds[seg_idx];
 		huge_path = eal_get_hugefile_path(path, buflen, hi->hugedir,
-				list_idx * RTE_MAX_MEMSEG_PER_LIST + seg_idx);
+				list_idx * RTE_MAX_MEMSEG_PER_TYPE + seg_idx);
 	}
 	if (huge_path == NULL) {
 		EAL_LOG(DEBUG, "%s(): hugefile path truncated: '%s'",
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index bf783e3c76..568d5da124 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -740,7 +740,7 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 		break;
 	}
 	if (msl_idx == RTE_MAX_MEMSEG_LISTS) {
-		EAL_LOG(ERR, "Could not find space for memseg. Please increase RTE_MAX_MEMSEG_PER_LIST "
+		EAL_LOG(ERR, "Could not find space for memseg. Please increase "
 			"RTE_MAX_MEMSEG_PER_TYPE and/or RTE_MAX_MEM_MB_PER_TYPE in configuration.");
 		return -1;
 	}
@@ -822,23 +822,6 @@ remap_segment(struct hugepage_file *hugepages, int seg_start, int seg_end)
 	return seg_len;
 }
 
-static uint64_t
-get_mem_amount(uint64_t page_sz, uint64_t max_mem)
-{
-	uint64_t area_sz, max_pages;
-
-	/* limit to RTE_MAX_MEMSEG_PER_LIST pages or RTE_MAX_MEM_MB_PER_LIST */
-	max_pages = RTE_MAX_MEMSEG_PER_LIST;
-	max_mem = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_LIST << 20, max_mem);
-
-	area_sz = RTE_MIN(page_sz * max_pages, max_mem);
-
-	/* make sure the list isn't smaller than the page size */
-	area_sz = RTE_MAX(area_sz, page_sz);
-
-	return RTE_ALIGN(area_sz, page_sz);
-}
-
 static int
 memseg_list_free(struct rte_memseg_list *msl)
 {
@@ -995,7 +978,7 @@ prealloc_segments(struct hugepage_file *hugepages, int n_pages)
 
 			/* now, allocate fbarray itself */
 			if (eal_memseg_list_init(msl, page_sz, n_segs,
-					socket, msl_idx, true) < 0)
+					socket, true) < 0)
 				return -1;
 
 			/* finally, allocate VA space */
@@ -1831,7 +1814,7 @@ memseg_primary_init_32(void)
 			uint64_t max_pagesz_mem, cur_pagesz_mem = 0;
 			uint64_t hugepage_sz;
 			struct hugepage_info *hpi;
-			int type_msl_idx, max_segs, total_segs = 0;
+			unsigned int n_segs;
 
 			hpi = &internal_conf->hugepage_info[hpi_idx];
 			hugepage_sz = hpi->hugepage_sz;
@@ -1840,62 +1823,48 @@ memseg_primary_init_32(void)
 			if (hpi->num_pages[socket_id] == 0)
 				continue;
 
-			max_segs = RTE_MAX_MEMSEG_PER_TYPE;
 			max_pagesz_mem = max_socket_mem - cur_socket_mem;
 
 			/* make it multiple of page size */
 			max_pagesz_mem = RTE_ALIGN_FLOOR(max_pagesz_mem,
 					hugepage_sz);
+			n_segs = RTE_MIN(max_pagesz_mem / hugepage_sz,
+					(unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
 
 			EAL_LOG(DEBUG, "Attempting to preallocate "
 					"%" PRIu64 "M on socket %i",
 					max_pagesz_mem >> 20, socket_id);
 
-			type_msl_idx = 0;
-			while (cur_pagesz_mem < max_pagesz_mem &&
-					total_segs < max_segs) {
-				uint64_t cur_mem;
-				unsigned int n_segs;
+			if (n_segs == 0)
+				continue;
 
-				if (msl_idx >= RTE_MAX_MEMSEG_LISTS) {
-					EAL_LOG(ERR,
-						"No more space in memseg lists, please increase RTE_MAX_MEMSEG_LISTS");
-					return -1;
-				}
+			if (msl_idx >= RTE_MAX_MEMSEG_LISTS) {
+				EAL_LOG(ERR,
+					"No more space in memseg lists, please increase RTE_MAX_MEMSEG_LISTS");
+				return -1;
+			}
 
-				msl = &mcfg->memsegs[msl_idx];
+			msl = &mcfg->memsegs[msl_idx];
 
-				cur_mem = get_mem_amount(hugepage_sz,
-						max_pagesz_mem);
-				n_segs = cur_mem / hugepage_sz;
+			if (eal_memseg_list_init(msl, hugepage_sz,
+					n_segs, socket_id, true)) {
+				/* failing to allocate a memseg list is a serious error. */
+				EAL_LOG(ERR, "Cannot allocate memseg list");
+				return -1;
+			}
 
-				if (eal_memseg_list_init(msl, hugepage_sz,
-						n_segs, socket_id, type_msl_idx,
-						true)) {
-					/* failing to allocate a memseg list is
-					 * a serious error.
-					 */
-					EAL_LOG(ERR, "Cannot allocate memseg list");
+			if (eal_memseg_list_alloc(msl, 0)) {
+				/* if we couldn't allocate VA space, try smaller page sizes. */
+				EAL_LOG(ERR, "Cannot allocate VA space for memseg list, retrying with different page size");
+				/* deallocate memseg list */
+				if (memseg_list_free(msl))
 					return -1;
-				}
-
-				if (eal_memseg_list_alloc(msl, 0)) {
-					/* if we couldn't allocate VA space, we
-					 * can try with smaller page sizes.
-					 */
-					EAL_LOG(ERR, "Cannot allocate VA space for memseg list, retrying with different page size");
-					/* deallocate memseg list */
-					if (memseg_list_free(msl))
-						return -1;
-					break;
-				}
-
-				total_segs += msl->memseg_arr.len;
-				cur_pagesz_mem = total_segs * hugepage_sz;
-				type_msl_idx++;
-				msl_idx++;
+				continue;
 			}
+
+			cur_pagesz_mem = n_segs * hugepage_sz;
 			cur_socket_mem += cur_pagesz_mem;
+			msl_idx++;
 		}
 		if (cur_socket_mem == 0) {
 			EAL_LOG(ERR, "Cannot allocate VA space on socket %u",
-- 
2.47.3

