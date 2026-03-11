Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE7E104C007
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Mar 2026 10:59:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE2DB40E64;
	Wed, 11 Mar 2026 11:59:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id E918F40431
 for <dev@dpdk.org>; Wed, 11 Mar 2026 11:58:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773226740; x=1804762740;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cgOpS8E485Meq7F+n9kQuiyQdANiGW5VMU+i4gUgUSM=;
 b=K1H/4htbnU6Y77MLL2ZsXkDxG2/clLfFWcwMwYYEvjFfFuL2AnvVYOD7
 WwaPSJYRp6PZE2jn60VdCU3cCYbYt9UXQaAK14kRmdBbSY5+7P5O0luEx
 a/zLnEmd8NBPovnGnTVuB83oXCB5cM54iec7rImRCtBl9+yzzi4/zzniY
 2wlKW/yHrNGZGPn9/PYa1svKTWsgwn8sE993/zlIxWznR4V03h5iYJzTD
 R1pU275v71UGqflucARaG1pMYzhmq2rPqB0glbqeZ9hQ5/Ay9b+dpT+30
 eIooIH2ZnKlbpOvTofKm6SbJ+DFor72IjcPA2tGmvZGWfY2uHJGErLQ4J A==;
X-CSE-ConnectionGUID: jvceb2K/SzKwlIgvskfFpg==
X-CSE-MsgGUID: Ca/lVJ/rQM6d4o98ORmk0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74481621"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="74481621"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 03:59:00 -0700
X-CSE-ConnectionGUID: 4RtR1QXPSoGGUTFxdfGnPw==
X-CSE-MsgGUID: 6tXh+ywcQQCbIikrGaGvRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="250928198"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 11 Mar 2026 03:58:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 2/5] eal/memory: allocate all VA space in one go
Date: Wed, 11 Mar 2026 10:58:50 +0000
Message-ID: <7bfc0e9862a878ae9077e88f4d8c634d704677b6.1773225702.git.anatoly.burakov@intel.com>
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

Instead of allocating VA space per memseg list in dynmem mode, allocate it
all in one go, and then assign memseg lists portions of that space. In a
similar way, for dynmem initialization in secondary processes, also attach
all VA space in one go. Legacy/32-bit paths are untouched.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_dynmem.c | 56 ++++++++++++++++++++-----
 lib/eal/common/eal_common_memory.c | 22 ++++++++++
 lib/eal/common/eal_memcfg.h        |  6 +++
 lib/eal/common/eal_private.h       | 13 ++++++
 lib/eal/linux/eal_memory.c         | 66 +++++++++++++++++++++++++++++-
 5 files changed, 152 insertions(+), 11 deletions(-)

diff --git a/lib/eal/common/eal_common_dynmem.c b/lib/eal/common/eal_common_dynmem.c
index 86da2bd80b..bfc4de6698 100644
--- a/lib/eal/common/eal_common_dynmem.c
+++ b/lib/eal/common/eal_common_dynmem.c
@@ -24,11 +24,16 @@ eal_dynmem_memseg_lists_init(void)
 	struct memtype {
 		uint64_t page_sz;
 		int socket_id;
+		unsigned int n_segs;
+		size_t mem_sz;
+		size_t va_offset;
 	} *memtypes = NULL;
 	int i, hpi_idx, msl_idx, ret = -1; /* fail unless told to succeed */
 	struct rte_memseg_list *msl;
 	uint64_t max_mem, max_mem_per_type;
+	size_t mem_va_len, mem_va_page_sz;
 	unsigned int n_memtypes, cur_type;
+	void *mem_va_addr = NULL;
 	struct internal_config *internal_conf =
 		eal_get_internal_configuration();
 
@@ -108,18 +113,16 @@ eal_dynmem_memseg_lists_init(void)
 	max_mem = (uint64_t)RTE_MAX_MEM_MB << 20;
 	max_mem_per_type = RTE_MIN((uint64_t)RTE_MAX_MEM_MB_PER_TYPE << 20,
 			max_mem / n_memtypes);
+	mem_va_len = 0;
+	mem_va_page_sz = 0;
 
-	/* go through all mem types and create segment lists */
-	msl_idx = 0;
+	/* calculate total VA space and offsets for all mem types */
 	for (cur_type = 0; cur_type < n_memtypes; cur_type++) {
-		unsigned int n_segs;
 		unsigned int max_segs_per_type;
 		struct memtype *type = &memtypes[cur_type];
 		uint64_t pagesz;
-		int socket_id;
 
 		pagesz = type->page_sz;
-		socket_id = type->socket_id;
 
 		/*
 		 * we need to create a segment list for this type. we must take
@@ -133,25 +136,58 @@ eal_dynmem_memseg_lists_init(void)
 		max_segs_per_type = max_mem_per_type / pagesz;
 		max_segs_per_type = RTE_MIN(max_segs_per_type,
 				(unsigned int)RTE_MAX_MEMSEG_PER_TYPE);
-		n_segs = max_segs_per_type;
+		type->n_segs = max_segs_per_type;
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
 
 		EAL_LOG(DEBUG, "Creating segment list: "
 				"n_segs:%i socket_id:%i hugepage_sz:%" PRIu64,
-			n_segs, socket_id, pagesz);
+			type->n_segs, socket_id, pagesz);
 
 		msl = &mcfg->memsegs[msl_idx++];
 
-		if (eal_memseg_list_init(msl, pagesz, n_segs, socket_id, true))
+		if (eal_memseg_list_init(msl, pagesz, type->n_segs, socket_id, true))
 			goto out;
 
-		if (eal_memseg_list_alloc(msl, 0)) {
-			EAL_LOG(ERR, "Cannot allocate VA space for memseg list");
+		if (eal_memseg_list_assign(msl,
+				RTE_PTR_ADD(mem_va_addr, type->va_offset))) {
+			EAL_LOG(ERR, "Cannot assign VA space for memseg list");
 			goto out;
 		}
 	}
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
 	free(memtypes);
 	return ret;
 }
diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index e8e41bb741..b91e765cbf 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -271,6 +271,28 @@ eal_memseg_list_alloc(struct rte_memseg_list *msl, int reserve_flags)
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
index 40408d61b4..b62b71369a 100644
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
diff --git a/lib/eal/linux/eal_memory.c b/lib/eal/linux/eal_memory.c
index 568d5da124..3b2afee852 100644
--- a/lib/eal/linux/eal_memory.c
+++ b/lib/eal/linux/eal_memory.c
@@ -1883,7 +1883,59 @@ memseg_primary_init(void)
 }
 
 static int
-memseg_secondary_init(void)
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
+		EAL_LOG(DEBUG, "Attaching segment list: "
+				"n_segs:%u socket_id:%d hugepage_sz:%" PRIu64,
+			msl->memseg_arr.len, msl->socket_id, msl->page_sz);
+	}
+
+	return 0;
+}
+
+static int
+memseg_secondary_init_legacy(void)
 {
 	struct rte_mem_config *mcfg = rte_eal_get_configuration()->mem_config;
 	int msl_idx = 0;
@@ -1912,6 +1964,18 @@ memseg_secondary_init(void)
 	return 0;
 }
 
+static int
+memseg_secondary_init(void)
+{
+	const struct internal_config *internal_conf =
+		eal_get_internal_configuration();
+
+	if (!internal_conf->legacy_mem)
+		return memseg_secondary_init_dynmem();
+
+	return memseg_secondary_init_legacy();
+}
+
 int
 rte_eal_memseg_init(void)
 {
-- 
2.47.3

