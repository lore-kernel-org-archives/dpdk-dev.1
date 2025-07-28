Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB7FC87FC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 15:19:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A91840667;
	Mon, 28 Jul 2025 17:19:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DF3EE402EE
 for <dev@dpdk.org>; Mon, 28 Jul 2025 17:19:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753715960; x=1785251960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aT0xBClxtRtIrkwqXOYv0ae43RqSWB1b8qXbwfJ6L54=;
 b=BBwcXrfVhQBlmm1/KBIgDl8JXRrxaFD2GrRaQmUH40eR+qvpZkuBJT6i
 VqBz9CJAymKDIXAxdhMZceJ8jQGycNLXPLLWczZ3MuSJQIaGtiUWI9C7S
 Jo43X8dHgWAvSnxcNzxmamjS4B0bgTIKK576ERvc91/ManlwOltGbYRqg
 H5AOoFuucFWhUO3aPXpQwBHcHIMfJjIwdREreyoipePmKyaPrSsTokuFf
 vJMZm0PmEuTmZaWgRpqQPBcyRNia+2rPutYTX9u9HWtmFieo6EX2SuEjI
 IRlJs4B8kwbOwNiZu0+EyjIKRA10fpVDYrLIMc1+hiehyEJ+V1qTlADo0 w==;
X-CSE-ConnectionGUID: yUN7QJuPQzaCmwx0uV1y+g==
X-CSE-MsgGUID: 54iNP3XiT1WQQswdJIZaPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67404234"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="67404234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 08:19:19 -0700
X-CSE-ConnectionGUID: dtkyfeZpQe23wPw0y68bYg==
X-CSE-MsgGUID: zJVADPxNSUqCtKiWN+mYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="199586028"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 08:19:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/3] eal/linux: remove fallbacks for old Linux versions
Date: Mon, 28 Jul 2025 16:19:06 +0100
Message-ID: <20250728151908.338534-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250728151908.338534-1-bruce.richardson@intel.com>
References: <20250630132904.1704901-1-bruce.richardson@intel.com>
 <20250728151908.338534-1-bruce.richardson@intel.com>
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

All supported linux versions support F_ADD_SEALS (Linux 3.17+) and
MFD_HUGETLB (Linux 4.14+), so no need to have #ifdefs and fallbacks to
support systems which do not support those features.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/linux/eal_memalloc.c | 174 +++++------------------------------
 lib/eal/linux/eal_memory.c   |   7 --
 2 files changed, 24 insertions(+), 157 deletions(-)

diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index e354efc95d..1e60e21620 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -16,10 +16,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <setjmp.h>
-#ifdef F_ADD_SEALS /* if file sealing is supported, so is memfd */
 #include <linux/memfd.h>
-#define MEMFD_SUPPORTED
-#endif
 #ifdef RTE_EAL_NUMA_AWARE_HUGEPAGES
 #include <numa.h>
 #include <numaif.h>
@@ -47,24 +44,6 @@ const int anonymous_hugepages_supported =
 #define RTE_MAP_HUGE_SHIFT 26
 #endif
 
-/*
- * we've already checked memfd support at compile-time, but we also need to
- * check if we can create hugepage files with memfd.
- *
- * also, this is not a constant, because while we may be *compiled* with memfd
- * hugetlbfs support, we might not be *running* on a system that supports memfd
- * and/or memfd with hugetlbfs, so we need to be able to adjust this flag at
- * runtime, and fall back to anonymous memory.
- */
-static int memfd_create_supported =
-#ifdef MFD_HUGETLB
-		1;
-#define RTE_MFD_HUGETLB MFD_HUGETLB
-#else
-		0;
-#define RTE_MFD_HUGETLB 4U
-#endif
-
 /*
  * not all kernel version support fallocate on hugetlbfs, so fall back to
  * ftruncate and disallow deallocation if fallocate is not supported.
@@ -236,11 +215,10 @@ get_seg_memfd(struct hugepage_info *hi __rte_unused,
 		unsigned int list_idx __rte_unused,
 		unsigned int seg_idx __rte_unused)
 {
-#ifdef MEMFD_SUPPORTED
 	int fd;
 	char segname[250]; /* as per manpage, limit is 249 bytes plus null */
 
-	int flags = RTE_MFD_HUGETLB | pagesz_flags(hi->hugepage_sz);
+	int flags = MFD_HUGETLB | pagesz_flags(hi->hugepage_sz);
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -273,8 +251,6 @@ get_seg_memfd(struct hugepage_info *hi __rte_unused,
 		}
 	}
 	return fd;
-#endif
-	return -1;
 }
 
 static int
@@ -539,66 +515,40 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 		EAL_LOG(ERR, "Anonymous hugepages not supported, in-memory mode cannot allocate memory");
 		return -1;
 	}
-	if (internal_conf->in_memory && !memfd_create_supported &&
-			internal_conf->single_file_segments) {
-		EAL_LOG(ERR, "Single-file segments are not supported without memfd support");
-		return -1;
-	}
 
-	/* in-memory without memfd is a special case */
+	/* use memfd for in-memory mode */
 	int mmap_flags;
 
-	if (internal_conf->in_memory && !memfd_create_supported) {
-		const int in_memory_flags = MAP_HUGETLB | MAP_FIXED |
-				MAP_PRIVATE | MAP_ANONYMOUS;
-		int pagesz_flag;
+	/* takes out a read lock on segment or segment list */
+	fd = get_seg_fd(path, sizeof(path), hi, list_idx, seg_idx, &dirty);
+	if (fd < 0) {
+		EAL_LOG(ERR, "Couldn't get fd on hugepage file");
+		return -1;
+	}
 
-		pagesz_flag = pagesz_flags(alloc_sz);
-		fd = -1;
-		dirty = false;
-		mmap_flags = in_memory_flags | pagesz_flag;
+	if (internal_conf->single_file_segments) {
+		map_offset = seg_idx * alloc_sz;
+		ret = resize_hugefile(fd, map_offset, alloc_sz, true, &dirty);
+		if (ret < 0)
+			goto resized;
 
-		/* single-file segments codepath will never be active
-		 * here because in-memory mode is incompatible with the
-		 * fallback path, and it's stopped at EAL initialization
-		 * stage.
-		 */
-		map_offset = 0;
+		fd_list[list_idx].count++;
 	} else {
-		/* takes out a read lock on segment or segment list */
-		fd = get_seg_fd(path, sizeof(path), hi, list_idx, seg_idx,
-				&dirty);
-		if (fd < 0) {
-			EAL_LOG(ERR, "Couldn't get fd on hugepage file");
-			return -1;
+		map_offset = 0;
+		if (ftruncate(fd, alloc_sz) < 0) {
+			EAL_LOG(DEBUG, "%s(): ftruncate() failed: %s", __func__, strerror(errno));
+			goto resized;
 		}
-
-		if (internal_conf->single_file_segments) {
-			map_offset = seg_idx * alloc_sz;
-			ret = resize_hugefile(fd, map_offset, alloc_sz, true,
-					&dirty);
-			if (ret < 0)
-				goto resized;
-
-			fd_list[list_idx].count++;
-		} else {
-			map_offset = 0;
-			if (ftruncate(fd, alloc_sz) < 0) {
-				EAL_LOG(DEBUG, "%s(): ftruncate() failed: %s",
+		if (internal_conf->hugepage_file.unlink_before_mapping &&
+				!internal_conf->in_memory) {
+			if (unlink(path)) {
+				EAL_LOG(DEBUG, "%s(): unlink() failed: %s",
 					__func__, strerror(errno));
 				goto resized;
 			}
-			if (internal_conf->hugepage_file.unlink_before_mapping &&
-					!internal_conf->in_memory) {
-				if (unlink(path)) {
-					EAL_LOG(DEBUG, "%s(): unlink() failed: %s",
-						__func__, strerror(errno));
-					goto resized;
-				}
-			}
 		}
-		mmap_flags = MAP_SHARED | MAP_POPULATE | MAP_FIXED;
 	}
+	mmap_flags = MAP_SHARED | MAP_POPULATE | MAP_FIXED;
 
 	huge_register_sigbus();
 
@@ -754,12 +704,6 @@ free_seg(struct rte_memseg *ms, struct hugepage_info *hi,
 
 	eal_mem_set_dump(ms->addr, ms->len, false);
 
-	/* if we're using anonymous hugepages, nothing to be done */
-	if (internal_conf->in_memory && !memfd_create_supported) {
-		memset(ms, 0, sizeof(*ms));
-		return 0;
-	}
-
 	/* if we are not in single file segments mode, we're going to unmap the
 	 * segment and thus drop the lock on original fd, but hugepage dir is
 	 * now locked so we can take out another one without races.
@@ -1624,16 +1568,6 @@ eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
-	if (internal_conf->in_memory || internal_conf->no_hugetlbfs) {
-#ifndef MEMFD_SUPPORTED
-		/* in in-memory or no-huge mode, we rely on memfd support */
-		return -ENOTSUP;
-#endif
-		/* memfd supported, but hugetlbfs memfd may not be */
-		if (!internal_conf->no_hugetlbfs && !memfd_create_supported)
-			return -ENOTSUP;
-	}
-
 	if (internal_conf->single_file_segments) {
 		fd = fd_list[list_idx].memseg_list_fd;
 	} else if (fd_list[list_idx].len == 0) {
@@ -1647,37 +1581,6 @@ eal_memalloc_get_seg_fd(int list_idx, int seg_idx)
 	return fd;
 }
 
-static int
-test_memfd_create(void)
-{
-#ifdef MEMFD_SUPPORTED
-	const struct internal_config *internal_conf =
-		eal_get_internal_configuration();
-	unsigned int i;
-	for (i = 0; i < internal_conf->num_hugepage_sizes; i++) {
-		uint64_t pagesz = internal_conf->hugepage_info[i].hugepage_sz;
-		int pagesz_flag = pagesz_flags(pagesz);
-		int flags;
-
-		flags = pagesz_flag | RTE_MFD_HUGETLB;
-		int fd = memfd_create("test", flags);
-		if (fd < 0) {
-			/* we failed - let memalloc know this isn't working */
-			if (errno == EINVAL) {
-				memfd_create_supported = 0;
-				return 0; /* not supported */
-			}
-
-			/* we got other error - something's wrong */
-			return -1; /* error */
-		}
-		close(fd);
-		return 1; /* supported */
-	}
-#endif
-	return 0; /* not supported */
-}
-
 int
 eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 {
@@ -1685,16 +1588,6 @@ eal_memalloc_get_seg_fd_offset(int list_idx, int seg_idx, size_t *offset)
 	const struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
-	if (internal_conf->in_memory || internal_conf->no_hugetlbfs) {
-#ifndef MEMFD_SUPPORTED
-		/* in in-memory or no-huge mode, we rely on memfd support */
-		return -ENOTSUP;
-#endif
-		/* memfd supported, but hugetlbfs memfd may not be */
-		if (!internal_conf->no_hugetlbfs && !memfd_create_supported)
-			return -ENOTSUP;
-	}
-
 	if (internal_conf->single_file_segments) {
 		size_t pgsz = mcfg->memsegs[list_idx].page_sz;
 
@@ -1747,26 +1640,7 @@ eal_memalloc_init(void)
 			return -1;
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY &&
 			internal_conf->in_memory) {
-		int mfd_res = test_memfd_create();
-
-		if (mfd_res < 0) {
-			EAL_LOG(ERR, "Unable to check if memfd is supported");
-			return -1;
-		}
-		if (mfd_res == 1)
-			EAL_LOG(DEBUG, "Using memfd for anonymous memory");
-		else
-			EAL_LOG(INFO, "Using memfd is not supported, falling back to anonymous hugepages");
-
-		/* we only support single-file segments mode with in-memory mode
-		 * if we support hugetlbfs with memfd_create. this code will
-		 * test if we do.
-		 */
-		if (internal_conf->single_file_segments &&
-				mfd_res != 1) {
-			EAL_LOG(ERR, "Single-file segments mode cannot be used without memfd support");
-			return -1;
-		}
+		EAL_LOG(DEBUG, "Using memfd for anonymous memory");
 		/* this cannot ever happen but better safe than sorry */
 		if (!anonymous_hugepages_supported) {
 			EAL_LOG(ERR, "Using anonymous memory is not supported");
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index e433c1afee..ee964446c7 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -20,9 +20,6 @@
 #include <limits.h>
 #include <signal.h>
 #include <setjmp.h>
-#ifdef F_ADD_SEALS /* if file sealing is supported, so is memfd */
-#define MEMFD_SUPPORTED
-#endif
 #ifdef RTE_EAL_NUMA_AWARE_HUGEPAGES
 #include <numa.h>
 #include <numaif.h>
@@ -1161,9 +1158,7 @@ eal_legacy_hugepage_init(void)
 		size_t mem_sz;
 		struct rte_memseg_list *msl;
 		int n_segs, fd, flags;
-#ifdef MEMFD_SUPPORTED
 		int memfd;
-#endif
 		uint64_t page_sz;
 
 		/* nohuge mode is legacy mode */
@@ -1188,7 +1183,6 @@ eal_legacy_hugepage_init(void)
 		fd = -1;
 		flags = MAP_PRIVATE | MAP_ANONYMOUS;
 
-#ifdef MEMFD_SUPPORTED
 		/* create a memfd and store it in the segment fd table */
 		memfd = memfd_create("nohuge", 0);
 		if (memfd < 0) {
@@ -1213,7 +1207,6 @@ eal_legacy_hugepage_init(void)
 				flags = MAP_SHARED;
 			}
 		}
-#endif
 		/* preallocate address space for the memory, so that it can be
 		 * fit into the DMA mask.
 		 */
-- 
2.48.1

