Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E3CD6E49
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 16:16:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68D0B4068E;
	Fri, 29 May 2026 18:16:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F2161400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 18:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780071376; x=1811607376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Y5HXcaauRrWeLCe94R0BxYRbuMZ5EqUbcmsx5QqyctQ=;
 b=GBnguX3cFuoJV9Mt+b/N8FeLmVxDeNyi0nG3K7u4rxVcZPQ/AUbRyJ+b
 WH1Y0xD5DYfN9HLwvx40mGU/vXDjjSqGWq7v5OqgFg0TGwMQsiv/rrdZ9
 aOx7QAzee3pj2EnRuuUt6gf23hcZTuY+qzJHhswyIKZLWddJnY6uItsnU
 Na8sd+xYsjSEda0DNo0MwsofBoWpn8ymtBTQCQf9/+anTY4I8PNnn8NmX
 rdV+wdwPxt49kjcfkz0TDxLqoS5L/T93N+Yut34epRnkxwtXURiibCqpz
 OBXRcHXJGZAfzTB8egX1V7JsgzhGIZdROPjM+8scCoyJlmsK3fa35dipa A==;
X-CSE-ConnectionGUID: dmWiKkC0Q92S0gaysQ3kSA==
X-CSE-MsgGUID: 1aWHrEDhS5GXRVMXOlRVxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="106375654"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="106375654"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 09:16:06 -0700
X-CSE-ConnectionGUID: YPMBkqLOTDSWTUT+LAof0Q==
X-CSE-MsgGUID: VrvU6ohxQG+jbC3tFs7VMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266756067"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 29 May 2026 09:16:04 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/6] eal/memory: allocate all VA space in one go
Date: Fri, 29 May 2026 17:15:50 +0100
Message-ID: <fe2f88f7645f745af7fec6565097b2078c3bcdcb.1780071269.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780071269.git.anatoly.burakov@intel.com>
 <cover.1780071269.git.anatoly.burakov@intel.com>
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

Instead of allocating VA space per memseg list in dynmem mode, allocate it
all in one go, and then assign memseg lists portions of that space. In a
similar way, for dynmem initialization in secondary processes, also attach
all VA space in one go. Legacy/32-bit paths are untouched.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_dynmem.c | 54 ++++++++++++++++++++----
 lib/eal/common/eal_common_memory.c | 22 ++++++++++
 lib/eal/common/eal_memcfg.h        |  6 +++
 lib/eal/common/eal_private.h       | 13 ++++++
 lib/eal/freebsd/eal_memory.c       | 12 ++----
 lib/eal/linux/eal_memory.c         | 68 +++++++++++++++++++++++++++++-
 6 files changed, 157 insertions(+), 18 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index c25197f2e9..40cc989ed9 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -24,11 +24,16 @@ eal_dynmem_memseg_lists_init(void)
 	struct memtype {
 		uint64_t page_sz;
 		int socket_id;
+		unsigned int n_segs;
+		size_t mem_sz;
+		size_t va_offset;
 	} memtypes[RTE_MAX_MEMSEG_LISTS] = {0};
 	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, max_mem_per_type;
+	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
+	void *mem_va_addr = NULL;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -103,17 +108,16 @@ eal_dynmem_memseg_lists_init(void)
 	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
 	max_mem_per_type = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
 			max_mem / n_memtypes);
+	mem_va_len = 0;
+	mem_va_page_sz = 0;
 
-	/* go through all mem types and create segment lists */
-	msl_idx = 0;
+	/* calculate total VA space and offsets for all mem types */
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
 		unsigned int n_segs;
 		struct memtype *type = &memtypes[cur_type];
 		uint64_t pagesz;
-		int socket_id;
 
 		pagesz = type->page_sz;
-		socket_id = type->socket_id;
 
 		/*
 		 * we need to create a segment list for this type. we must take
@@ -126,17 +130,42 @@ eal_dynmem_memseg_lists_init(void)
 		 */
 		n_segs = max_mem_per_type / pagesz;
 		n_segs = RTE_MIN(n_segs, (unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
+		type->n_segs = n_segs;
+		type->mem_sz = (size_t)pagesz * type->n_segs;
+		mem_va_page_sz = RTE_MAX(mem_va_page_sz, (size_t)pagesz);
+		mem_va_len = RTE_ALIGN_CEIL(mem_va_len, pagesz);
+		type->va_offset = mem_va_len;
+		mem_va_len += type->mem_sz;
+	}
+
+	mem_va_addr = eal_get_virtual_area(NULL, &mem_va_len,
+			mem_va_page_sz, 0, 0);
+	if (mem_va_addr == NULL) {
+		EAL_LOG(ERR, "Cannot reserve VA space for memseg lists");
+		goto out;
+	}
+
+	/* go through all mem types and create segment lists */
+	msl_idx = 0;
+	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
+		struct memtype *type = &memtypes[cur_type];
+		uint64_t pagesz;
+		int socket_id;
+
+		pagesz = type->page_sz;
+		socket_id = type->socket_id;
 
 		EAL_LOG(DEBUG, "Creating segment list: n_segs:%u socket_id:%i hugepage_sz:%" PRIu64,
-			n_segs, socket_id, pagesz);
+			type->n_segs, socket_id, pagesz);
 
 		msl = &mcfg->memsegs[msl_idx];
 
-		if (eal_memseg_list_init(msl, pagesz, n_segs, socket_id, msl_idx, true))
+		if (eal_memseg_list_init(msl, pagesz, type->n_segs, socket_id, msl_idx, true))
 			goto out;
 
-		if (eal_memseg_list_alloc(msl, 0)) {
-			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
+		if (eal_memseg_list_assign(msl,
+				RTE_PTR_ADD(mem_va_addr, type->va_offset))) {
+			EAL_LOG(ERR, "Cannot assign VA space for memseg list");
 			goto out;
 		}
 		msl_idx++;
@@ -144,6 +173,15 @@ eal_dynmem_memseg_lists_init(void)
 	/* we're successful */
 	ret = 0;
 out:
+	if (ret != 0) {
+		if (mem_va_addr != NULL)
+			eal_mem_free(mem_va_addr, mem_va_len);
+	} else {
+		/* store the VA space data in shared config */
+		mcfg->mem_va_addr = (uintptr_t)mem_va_addr;
+		mcfg->mem_va_len = mem_va_len;
+		mcfg->mem_va_page_sz = mem_va_page_sz;
+	}
 	return ret;
 }
 
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index 1c9ea9b7c2..e7d534ed75 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -270,6 +270,28 @@ eal_memseg_list_alloc(struct rte_memseg_list *msl, int reserve_flags)
 	return 0;
 }
 
+int
+eal_memseg_list_assign(struct rte_memseg_list *msl, void *addr)
+{
+	size_t page_sz, mem_sz;
+
+	page_sz = msl->page_sz;
+	mem_sz = page_sz * msl->memseg_arr.len;
+
+	if (addr == NULL || addr != RTE_PTR_ALIGN(addr, page_sz)) {
+		rte_errno = EINVAL;
+		return -1;
+	}
+
+	msl->base_va = addr;
+	msl->len = mem_sz;
+
+	EAL_LOG(DEBUG, "VA assigned for memseg list at %p, size %zx",
+			addr, mem_sz);
+
+	return 0;
+}
+
 void
 eal_memseg_list_populate(struct rte_memseg_list *msl, void *addr, int n_segs)
 {
diff --git a/lib/eal/common/eal_memcfg.h b/lib/eal/common/eal_memcfg.h
index 60e2089797..2b3b3b62ba 100644
--- a/lib/eal/common/eal_memcfg.h
+++ b/lib/eal/common/eal_memcfg.h
@@ -49,6 +49,12 @@ struct rte_mem_config {
 
 	struct rte_memseg_list memsegs[RTE_MAX_MEMSEG_LISTS];
 	/**< List of dynamic arrays holding memsegs */
+	uintptr_t mem_va_addr;
+	/**< Base VA address reserved for dynamic memory memseg lists. */
+	size_t mem_va_len;
+	/**< Length of VA range reserved for dynamic memory memseg lists. */
+	size_t mem_va_page_sz;
+	/**< Page size alignment used for dynamic memory VA reservation. */
 
 	struct rte_tailq_head tailq_head[RTE_MAX_TAILQ];
 	/**< Tailqs for objects */
diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index 70f7b46699..0c0544beaf 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -322,6 +322,19 @@ eal_memseg_list_init(struct rte_memseg_list *msl, uint64_t page_sz,
 int
 eal_memseg_list_alloc(struct rte_memseg_list *msl, int reserve_flags);
 
+/**
+ * Assign a pre-reserved VA range to a memory segment list.
+ *
+ * @param msl
+ *  Initialized memory segment list with page size defined.
+ * @param addr
+ *  Starting address of list VA range.
+ * @return
+ *  0 on success, (-1) on failure and rte_errno is set.
+ */
+int
+eal_memseg_list_assign(struct rte_memseg_list *msl, void *addr);
+
 /**
  * Populate MSL, each segment is one page long.
  *
diff --git a/lib/eal/freebsd/eal_memory.c b/lib/eal/freebsd/eal_memory.c
index 9b820f5dc9..56c1ecca2b 100644
--- a/lib/eal/freebsd/eal_memory.c
+++ b/lib/eal/freebsd/eal_memory.c
@@ -362,8 +362,6 @@ memseg_primary_init(void)
 	for (hpi_idx = 0; hpi_idx < (int) internal_conf->num_hugepage_sizes;
 			hpi_idx++) {
 		uint64_t max_type_mem, total_type_mem = 0;
-		uint64_t avail_mem;
-		unsigned int avail_segs;
 		struct hugepage_info *hpi;
 		uint64_t hugepage_sz;
 		unsigned int n_segs;
@@ -391,11 +389,8 @@ memseg_primary_init(void)
 		 * so we will allocate more and put spaces between segments
 		 * that are non-contiguous.
 		 */
-		avail_segs = (hpi->num_pages[0] * 2) - 1;
-		avail_mem = avail_segs * hugepage_sz;
-
-		max_type_mem = RTE_MIN(avail_mem, max_type_mem);
-		n_segs = max_type_mem / hugepage_sz;
+		n_segs = RTE_MIN((hpi->num_pages[0] * 2) - 1,
+				max_type_mem / hugepage_sz);
 		if (n_segs == 0)
 			continue;
 
@@ -409,12 +404,11 @@ memseg_primary_init(void)
 		if (eal_memseg_list_init(msl, hugepage_sz, n_segs, 0, msl_idx, false))
 			return -1;
 
-		total_type_mem = n_segs * hugepage_sz;
 		if (memseg_list_alloc(msl)) {
 			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
 			return -1;
 		}
-
+		total_type_mem = n_segs * hugepage_sz;
 		total_mem += total_type_mem;
 		msl_idx++;
 	}
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 691d8eb3cc..b4960ffa54 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1893,8 +1893,59 @@ memseg_primary_init(void)
 	return eal_dynmem_memseg_lists_init();
 }
 
+static int __rte_unused
+memseg_secondary_init_dynmem(void)
+{
+	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
+	int msl_idx = 0;
+	struct rte_memseg_list *msl;
+	void *mem_va_addr;
+	size_t mem_va_len;
+
+	if (mcfg->mem_va_addr == 0 || mcfg->mem_va_len == 0 ||
+			mcfg->mem_va_page_sz == 0) {
+		EAL_LOG(ERR, "Missing shared dynamic memory VA range from primary process");
+		return -1;
+	}
+
+	mem_va_addr = (void *)(uintptr_t)mcfg->mem_va_addr;
+	mem_va_len = mcfg->mem_va_len;
+
+	if (eal_get_virtual_area(mem_va_addr, &mem_va_len,
+			mcfg->mem_va_page_sz, 0, 0) == NULL) {
+		EAL_LOG(ERR, "Cannot reserve VA space for hugepage memory");
+		return -1;
+	}
+
+	for (msl_idx = 0; msl_idx < RTE_MAX_MEMSEG_LISTS; msl_idx++) {
+
+		msl = &mcfg->memsegs[msl_idx];
+
+		/* skip empty and external memseg lists */
+		if (msl->memseg_arr.len == 0 || msl->external)
+			continue;
+
+		if (rte_fbarray_attach(&msl->memseg_arr)) {
+			EAL_LOG(ERR, "Cannot attach to primary process memseg lists");
+			eal_mem_free(mem_va_addr, mem_va_len);
+			return -1;
+		}
+
+		if (eal_memseg_list_assign(msl, msl->base_va)) {
+			EAL_LOG(ERR, "Cannot assign VA space for hugepage memory");
+			eal_mem_free(mem_va_addr, mem_va_len);
+			return -1;
+		}
+
+		EAL_LOG(DEBUG, "Attaching segment list: n_segs:%u socket_id:%d hugepage_sz:%" PRIu64,
+			msl->memseg_arr.len, msl->socket_id, msl->page_sz);
+	}
+
+	return 0;
+}
+
 static int
-memseg_secondary_init(void)
+memseg_secondary_init_legacy(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int msl_idx = 0;
@@ -1923,6 +1974,21 @@ memseg_secondary_init(void)
 	return 0;
 }
 
+static int
+memseg_secondary_init(void)
+{
+#ifdef RTE_ARCH_64
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+
+	/* for 32-bit dynmem init is same as legacy */
+	if (!internal_conf->legacy_mem)
+		return memseg_secondary_init_dynmem();
+#endif
+
+	return memseg_secondary_init_legacy();
+}
+
 int
 rte_eal_memseg_init(void)
 {
-- 
2.47.3

