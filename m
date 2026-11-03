Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAD606B250
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pzkoF59l
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 291A340430;
	Tue,  3 Nov 2026 15:53:31 +0100 (CET)
Received: from mta0.migadu.com (out-165.mta0.migadu.com [91.218.175.165])
 by mails.dpdk.org (Postfix) with ESMTPS id 4A2894042F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:30 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=nojYTeJ12Qi2i+vMTjQWcnGUBQhHbdB2+ORK0Idjnjw=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717610; v=1; x=1794322410;
 b=pzkoF59lIhnyaYzCqNfUAtrjZULtTXWAOk0xsXl/5Zwu+2X7j3JRKS36XrG80NGeEPJQeVEz
 2bitu1qvsdFEw2q+oehlNKAa667kbyQDf/9FyjO4TWwq3RpA3pECkoqPwjnj3Ie9XzbT7uoOB4N
 Wid0pxAmXeSznysYwUxzvz8M=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 79eaf3ea987fcc5c;
 Tue, 03 Nov 2026 14:53:30 +0000
X-Mizu-Trace-ID: 79eaf3ea987fcc5c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 002/227] mempool: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:20 +0800
Message-ID: <20261103145306.487255-3-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, trace arguments, internal variables,
comments and telemetry keys to the NUMA node terminology, and switch
internal calls to the NUMA-named APIs (rte_zmalloc_numa(),
rte_malloc_heap_numa_is_external(), RTE_NUMA_ID_ANY).

No functional change.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/proc-info/main.c                          |  2 +-
 doc/guides/rel_notes/deprecation.rst          | 10 ++++
 drivers/compress/nitrox/nitrox_comp_reqmgr.c  |  8 +--
 drivers/event/cnxk/cnxk_tim_evdev.c           |  2 +-
 drivers/mempool/bucket/rte_mempool_bucket.c   | 10 ++--
 .../mempool/octeontx/rte_mempool_octeontx.c   |  4 +-
 drivers/mempool/ring/rte_mempool_ring.c       |  2 +-
 drivers/mempool/stack/rte_mempool_stack.c     |  2 +-
 drivers/net/mlx4/mlx4_mr.c                    |  2 +-
 lib/ethdev/rte_ethdev_telemetry.c             |  2 +-
 lib/eventdev/rte_eventdev.c                   |  2 +-
 lib/mempool/mempool_trace.h                   |  4 +-
 lib/mempool/rte_mempool.c                     | 60 +++++++++----------
 lib/mempool/rte_mempool.h                     | 38 +++++++-----
 14 files changed, 83 insertions(+), 65 deletions(-)

diff --git a/app/proc-info/main.c b/app/proc-info/main.c
index 9c22fb8f01..1e5eee6787 100644
--- a/app/proc-info/main.c
+++ b/app/proc-info/main.c
@@ -1121,7 +1121,7 @@ show_port(void)
 
 			printf(" mempool %s socket %d",
 			       queue_info.mp->name,
-			       queue_info.mp->socket_id);
+			       queue_info.mp->numa_id);
 
 			if (queue_info.conf.offloads != 0)
 				show_offloads(queue_info.conf.offloads, rte_eth_dev_rx_offload_name);
diff --git a/doc/guides/rel_notes/deprecation.rst b/doc/guides/rel_notes/deprecation.rst
index 02b495f6a8..a6ff573d18 100644
--- a/doc/guides/rel_notes/deprecation.rst
+++ b/doc/guides/rel_notes/deprecation.rst
@@ -16,6 +16,16 @@ Other API and ABI deprecation notices are to be posted below.
 Deprecation Notices
 -------------------
 
+* lib: The public structures use ``socket_id`` to refer to a NUMA node,
+  which conflates CPU sockets with NUMA memory nodes.
+  The field is renamed to ``numa_id``, keeping ``socket_id``
+  as a deprecated union alias.
+  The following structures are affected: ``rte_hash_parameters``,
+  ``rte_fbk_hash_params``, ``rte_member_parameters`` /
+  ``rte_member_setsum`` and ``rte_mempool``
+  (more structures will follow in this release).
+  Applications should switch to ``numa_id``.
+
 * kvargs: The function ``rte_kvargs_process`` will get a new parameter
   for returning key match count. It will ease handling of no-match case.
 
diff --git a/drivers/compress/nitrox/nitrox_comp_reqmgr.c b/drivers/compress/nitrox/nitrox_comp_reqmgr.c
index e46faaf7e9..42358cd14f 100644
--- a/drivers/compress/nitrox/nitrox_comp_reqmgr.c
+++ b/drivers/compress/nitrox/nitrox_comp_reqmgr.c
@@ -620,7 +620,7 @@ static int softreq_init(struct nitrox_softreq *sr,
 
 	err = create_sglist_from_mbuf(&sr->src, sr->op->m_src,
 				      sr->op->src.offset,
-				      sr->op->src.length, 0, mp->socket_id);
+				      sr->op->src.length, 0, mp->numa_id);
 	if (unlikely(err))
 		return err;
 
@@ -630,7 +630,7 @@ static int softreq_init(struct nitrox_softreq *sr,
 			sr->op->dst.offset,
 			rte_pktmbuf_pkt_len(sr->op->m_dst) - sr->op->dst.offset,
 			need_decomp_threshold ? 1 : 0,
-			mp->socket_id);
+			mp->numa_id);
 	if (unlikely(err))
 		return err;
 
@@ -1161,10 +1161,10 @@ static void req_pool_obj_init(struct rte_mempool *mp, void *arg, void *obj,
 	sr = obj;
 	sr->src.sgl = rte_zmalloc_socket(NULL,
 				sizeof(*sr->src.sgl) * NITROX_ZIP_SGL_COUNT,
-				8, mp->socket_id);
+				8, mp->numa_id);
 	sr->dst.sgl = rte_zmalloc_socket(NULL,
 				sizeof(*sr->dst.sgl) * NITROX_ZIP_SGL_COUNT,
-				8, mp->socket_id);
+				8, mp->numa_id);
 	if (sr->src.sgl == NULL || sr->dst.sgl == NULL) {
 		NITROX_LOG_LINE(ERR, "Failed to allocate zip_sgl memory");
 		*err = -ENOMEM;
diff --git a/drivers/event/cnxk/cnxk_tim_evdev.c b/drivers/event/cnxk/cnxk_tim_evdev.c
index 41f1d20cec..11945e0e6e 100644
--- a/drivers/event/cnxk/cnxk_tim_evdev.c
+++ b/drivers/event/cnxk/cnxk_tim_evdev.c
@@ -37,7 +37,7 @@ cnxk_tim_chnk_pool_populate_aligned(struct rte_mempool *mp, size_t align)
 	stride = (size_t)mp->header_size + mp->elt_size + mp->trailer_size;
 	len = stride * mp->size;
 
-	mem = rte_zmalloc_socket("cnxk_tim_chunks", len, align, mp->socket_id);
+	mem = rte_zmalloc_socket("cnxk_tim_chunks", len, align, mp->numa_id);
 	if (mem == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/mempool/bucket/rte_mempool_bucket.c b/drivers/mempool/bucket/rte_mempool_bucket.c
index 6fee10176b..d3f626e064 100644
--- a/drivers/mempool/bucket/rte_mempool_bucket.c
+++ b/drivers/mempool/bucket/rte_mempool_bucket.c
@@ -67,7 +67,7 @@ bucket_stack_create(const struct rte_mempool *mp, unsigned int n_elts)
 				   sizeof(struct bucket_stack) +
 				   n_elts * sizeof(void *),
 				   RTE_CACHE_LINE_SIZE,
-				   mp->socket_id);
+				   mp->numa_id);
 	if (stack == NULL)
 		return NULL;
 	stack->limit = n_elts;
@@ -429,7 +429,7 @@ bucket_init_per_lcore(unsigned int lcore_id, void *arg)
 	if (mp->flags & RTE_MEMPOOL_F_SP_PUT)
 		rg_flags |= RING_F_SP_ENQ;
 	bd->adoption_buffer_rings[lcore_id] = rte_ring_create(rg_name,
-		rte_align32pow2(mp->size + 1), mp->socket_id, rg_flags);
+		rte_align32pow2(mp->size + 1), mp->numa_id, rg_flags);
 	if (bd->adoption_buffer_rings[lcore_id] == NULL)
 		goto error;
 
@@ -466,7 +466,7 @@ bucket_alloc(struct rte_mempool *mp)
 		return rc;
 
 	bd = rte_zmalloc_socket("bucket_pool", sizeof(*bd),
-				RTE_CACHE_LINE_SIZE, mp->socket_id);
+				RTE_CACHE_LINE_SIZE, mp->numa_id);
 	if (bd == NULL) {
 		rc = -ENOMEM;
 		goto no_mem_for_data;
@@ -506,7 +506,7 @@ bucket_alloc(struct rte_mempool *mp)
 	}
 	bd->shared_orphan_ring =
 		rte_ring_create(rg_name, rte_align32pow2(mp->size + 1),
-				mp->socket_id, rg_flags);
+				mp->numa_id, rg_flags);
 	if (bd->shared_orphan_ring == NULL) {
 		rc = -rte_errno;
 		goto cannot_create_shared_orphan_ring;
@@ -522,7 +522,7 @@ bucket_alloc(struct rte_mempool *mp)
 		rte_ring_create(rg_name,
 				rte_align32pow2((mp->size + 1) /
 						bd->obj_per_bucket),
-				mp->socket_id, rg_flags);
+				mp->numa_id, rg_flags);
 	if (bd->shared_bucket_ring == NULL) {
 		rc = -rte_errno;
 		goto cannot_create_shared_bucket_ring;
diff --git a/drivers/mempool/octeontx/rte_mempool_octeontx.c b/drivers/mempool/octeontx/rte_mempool_octeontx.c
index 631e521b58..7658731b04 100644
--- a/drivers/mempool/octeontx/rte_mempool_octeontx.c
+++ b/drivers/mempool/octeontx/rte_mempool_octeontx.c
@@ -21,7 +21,7 @@ octeontx_fpavf_alloc(struct rte_mempool *mp)
 
 	pool = octeontx_fpa_bufpool_create(object_size, memseg_count,
 						OCTEONTX_FPAVF_BUF_OFFSET,
-						mp->socket_id);
+						mp->numa_id);
 	rc = octeontx_fpa_bufpool_block_size(pool);
 	if (rc < 0)
 		goto _end;
@@ -48,7 +48,7 @@ octeontx_fpavf_free(struct rte_mempool *mp)
 	uintptr_t pool;
 	pool = (uintptr_t)mp->pool_id;
 
-	octeontx_fpa_bufpool_destroy(pool, mp->socket_id);
+	octeontx_fpa_bufpool_destroy(pool, mp->numa_id);
 }
 
 static __rte_always_inline void *
diff --git a/drivers/mempool/ring/rte_mempool_ring.c b/drivers/mempool/ring/rte_mempool_ring.c
index c6aa935eea..2c297e4856 100644
--- a/drivers/mempool/ring/rte_mempool_ring.c
+++ b/drivers/mempool/ring/rte_mempool_ring.c
@@ -96,7 +96,7 @@ ring_alloc(struct rte_mempool *mp, uint32_t rg_flags)
 	 * in this function for that condition.
 	 */
 	r = rte_ring_create(rg_name, rte_align32pow2(mp->size + 1),
-		mp->socket_id, rg_flags);
+		mp->numa_id, rg_flags);
 	if (r == NULL)
 		return -rte_errno;
 
diff --git a/drivers/mempool/stack/rte_mempool_stack.c b/drivers/mempool/stack/rte_mempool_stack.c
index 11c1243bec..eae85ef1fc 100644
--- a/drivers/mempool/stack/rte_mempool_stack.c
+++ b/drivers/mempool/stack/rte_mempool_stack.c
@@ -20,7 +20,7 @@ __stack_alloc(struct rte_mempool *mp, uint32_t flags)
 		return -rte_errno;
 	}
 
-	s = rte_stack_create(name, mp->size, mp->socket_id, flags);
+	s = rte_stack_create(name, mp->size, mp->numa_id, flags);
 	if (s == NULL)
 		return -rte_errno;
 
diff --git a/drivers/net/mlx4/mlx4_mr.c b/drivers/net/mlx4/mlx4_mr.c
index e307029b15..5e2c2dbf85 100644
--- a/drivers/net/mlx4/mlx4_mr.c
+++ b/drivers/net/mlx4/mlx4_mr.c
@@ -1226,7 +1226,7 @@ mlx4_mr_update_ext_mp_cb(struct rte_mempool *mp, void *opaque,
 	mr = rte_zmalloc_socket(NULL,
 				RTE_ALIGN_CEIL(sizeof(*mr),
 					       RTE_CACHE_LINE_SIZE),
-				RTE_CACHE_LINE_SIZE, mp->socket_id);
+				RTE_CACHE_LINE_SIZE, mp->numa_id);
 	if (mr == NULL) {
 		WARN("port %u unable to allocate memory for a new MR of"
 		     " mempool (%s).",
diff --git a/lib/ethdev/rte_ethdev_telemetry.c b/lib/ethdev/rte_ethdev_telemetry.c
index ca7f4681c9..146acec174 100644
--- a/lib/ethdev/rte_ethdev_telemetry.c
+++ b/lib/ethdev/rte_ethdev_telemetry.c
@@ -537,7 +537,7 @@ eth_dev_handle_port_rxq(const char *cmd __rte_unused,
 
 	rte_tel_data_start_dict(d);
 	rte_tel_data_add_dict_string(d, "mempool_name", qinfo.mp->name);
-	rte_tel_data_add_dict_uint(d, "socket_id", qinfo.mp->socket_id);
+	rte_tel_data_add_dict_uint(d, "socket_id", qinfo.mp->numa_id);
 
 	rx_thresh = &qinfo.conf.rx_thresh;
 	rte_tel_data_add_dict_uint(d, "host_threshold", rx_thresh->hthresh);
diff --git a/lib/eventdev/rte_eventdev.c b/lib/eventdev/rte_eventdev.c
index 53d17d7a00..71de25a3ab 100644
--- a/lib/eventdev/rte_eventdev.c
+++ b/lib/eventdev/rte_eventdev.c
@@ -1513,7 +1513,7 @@ rte_event_vector_pool_create(const char *name, unsigned int n,
 	if (ret < 0)
 		goto err;
 
-	rte_eventdev_trace_vector_pool_create(mp, mp->name, mp->socket_id,
+	rte_eventdev_trace_vector_pool_create(mp, mp->name, mp->numa_id,
 		mp->size, mp->cache_size, mp->elt_size);
 
 	return mp;
diff --git a/lib/mempool/mempool_trace.h b/lib/mempool/mempool_trace.h
index 60e47cf67b..4baec51427 100644
--- a/lib/mempool/mempool_trace.h
+++ b/lib/mempool/mempool_trace.h
@@ -113,10 +113,10 @@ RTE_TRACE_POINT(
 
 RTE_TRACE_POINT(
 	rte_mempool_trace_cache_create,
-	RTE_TRACE_POINT_ARGS(uint32_t size, int socket_id,
+	RTE_TRACE_POINT_ARGS(uint32_t size, int numa_id,
 		struct rte_mempool_cache *cache),
 	rte_trace_point_emit_u32(size);
-	rte_trace_point_emit_i32(socket_id);
+	rte_trace_point_emit_i32(numa_id);
 	rte_trace_point_emit_ptr(cache);
 	rte_trace_point_emit_u32(cache->len);
 )
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 069aabaa70..0e49cdfd1e 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -116,7 +116,7 @@ arch_mem_object_align(unsigned int obj_size)
 #endif
 
 struct pagesz_walk_arg {
-	int socket_id;
+	int numa_id;
 	size_t min;
 };
 
@@ -127,14 +127,14 @@ find_min_pagesz(const struct rte_memseg_list *msl, void *arg)
 	bool valid;
 
 	/*
-	 * we need to only look at page sizes available for a particular socket
-	 * ID.  so, we either need an exact match on socket ID (can match both
-	 * native and external memory), or, if SOCKET_ID_ANY was specified as a
-	 * socket ID argument, we must only look at native memory and ignore any
-	 * page sizes associated with external memory.
+	 * we need to only look at page sizes available for a particular NUMA
+	 * node ID.  So, we either need an exact match on NUMA node ID (can match
+	 * both native and external memory), or, if RTE_NUMA_ID_ANY was specified
+	 * as a NUMA node ID argument, we must only look at native memory and
+	 * ignore any page sizes associated with external memory.
 	 */
-	valid = msl->socket_id == wa->socket_id;
-	valid |= wa->socket_id == SOCKET_ID_ANY && msl->external == 0;
+	valid = msl->socket_id == wa->numa_id;
+	valid |= wa->numa_id == RTE_NUMA_ID_ANY && msl->external == 0;
 
 	if (valid && msl->page_sz < wa->min)
 		wa->min = msl->page_sz;
@@ -143,12 +143,12 @@ find_min_pagesz(const struct rte_memseg_list *msl, void *arg)
 }
 
 static size_t
-get_min_page_size(int socket_id)
+get_min_page_size(int numa_id)
 {
 	struct pagesz_walk_arg wa;
 
 	wa.min = SIZE_MAX;
-	wa.socket_id = socket_id;
+	wa.numa_id = numa_id;
 
 	rte_memseg_list_walk(find_min_pagesz, &wa);
 
@@ -462,8 +462,8 @@ rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
 	bool alloc_in_ext_mem;
 	int ret;
 
-	/* check if we can retrieve a valid socket ID */
-	ret = rte_malloc_heap_socket_is_external(mp->socket_id);
+	/* check if we can retrieve a valid NUMA node ID */
+	ret = rte_malloc_heap_numa_is_external(mp->numa_id);
 	if (ret < 0)
 		return -EINVAL;
 	alloc_in_ext_mem = (ret == 1);
@@ -472,7 +472,7 @@ rte_mempool_get_page_size(struct rte_mempool *mp, size_t *pg_sz)
 	if (!need_iova_contig_obj)
 		*pg_sz = 0;
 	else if (rte_eal_has_hugepages() || alloc_in_ext_mem)
-		*pg_sz = get_min_page_size(mp->socket_id);
+		*pg_sz = get_min_page_size(mp->numa_id);
 	else
 		*pg_sz = rte_mem_page_size();
 
@@ -581,7 +581,7 @@ rte_mempool_populate_default(struct rte_mempool *mp)
 		do {
 			mz = rte_memzone_reserve_aligned(mz_name,
 				RTE_MIN((size_t)mem_size, max_alloc_size),
-				mp->socket_id, mz_flags, align);
+				mp->numa_id, mz_flags, align);
 
 			if (mz != NULL || rte_errno != ENOMEM)
 				break;
@@ -763,7 +763,7 @@ mempool_cache_init(struct rte_mempool_cache *cache, uint32_t size)
  */
 RTE_EXPORT_SYMBOL(rte_mempool_cache_create)
 struct rte_mempool_cache *
-rte_mempool_cache_create(uint32_t size, int socket_id)
+rte_mempool_cache_create(uint32_t size, int numa_id)
 {
 	struct rte_mempool_cache *cache;
 	size_t sizeof_cache = sizeof(struct rte_mempool_cache) + size * sizeof(void *);
@@ -773,8 +773,8 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
 		return NULL;
 	}
 
-	cache = rte_zmalloc_socket("MEMPOOL_CACHE", sizeof_cache,
-				  RTE_CACHE_LINE_SIZE, socket_id);
+	cache = rte_zmalloc_numa("MEMPOOL_CACHE", sizeof_cache,
+				  RTE_CACHE_LINE_SIZE, numa_id);
 	if (cache == NULL) {
 		RTE_MEMPOOL_LOG(ERR, "Cannot allocate mempool cache.");
 		rte_errno = ENOMEM;
@@ -783,7 +783,7 @@ rte_mempool_cache_create(uint32_t size, int socket_id)
 
 	mempool_cache_init(cache, size);
 
-	rte_mempool_trace_cache_create(size, socket_id, cache);
+	rte_mempool_trace_cache_create(size, numa_id, cache);
 	return cache;
 }
 
@@ -803,9 +803,9 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache)
 /* create an empty mempool */
 RTE_EXPORT_SYMBOL(rte_mempool_create_empty)
 struct rte_mempool *
-rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
-	unsigned cache_size, unsigned private_data_size,
-	int socket_id, unsigned flags)
+rte_mempool_create_empty(const char *name, unsigned int n, unsigned int elt_size,
+	unsigned int cache_size, unsigned int private_data_size,
+	int numa_id, unsigned int flags)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	struct rte_mempool_list *mempool_list;
@@ -911,7 +911,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 		goto exit_unlock;
 	}
 
-	mz = rte_memzone_reserve(mz_name, mempool_size, socket_id, mz_flags);
+	mz = rte_memzone_reserve(mz_name, mempool_size, numa_id, mz_flags);
 	if (mz == NULL)
 		goto exit_unlock;
 
@@ -926,7 +926,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	mp->mz = mz;
 	mp->size = n;
 	mp->flags = flags;
-	mp->socket_id = socket_id;
+	mp->numa_id = numa_id;
 	mp->elt_size = objsz.elt_size;
 	mp->header_size = objsz.header_size;
 	mp->trailer_size = objsz.trailer_size;
@@ -987,16 +987,16 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 /* create the mempool */
 RTE_EXPORT_SYMBOL(rte_mempool_create)
 struct rte_mempool *
-rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
-	unsigned cache_size, unsigned private_data_size,
+rte_mempool_create(const char *name, unsigned int n, unsigned int elt_size,
+	unsigned int cache_size, unsigned int private_data_size,
 	rte_mempool_ctor_t *mp_init, void *mp_init_arg,
 	rte_mempool_obj_cb_t *obj_init, void *obj_init_arg,
-	int socket_id, unsigned flags)
+	int numa_id, unsigned int flags)
 {
 	struct rte_mempool *mp;
 
 	mp = rte_mempool_create_empty(name, n, elt_size, cache_size,
-		private_data_size, socket_id, flags);
+		private_data_size, numa_id, flags);
 	if (mp == NULL)
 		return NULL;
 
@@ -1281,7 +1281,7 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 
 	fprintf(f, "mempool <%s>@%p\n", mp->name, mp);
 	fprintf(f, "  flags=%x\n", mp->flags);
-	fprintf(f, "  socket_id=%d\n", mp->socket_id);
+	fprintf(f, "  numa_id=%d\n", mp->numa_id);
 	fprintf(f, "  pool=%p\n", mp->pool_data);
 	fprintf(f, "  iova=0x%" PRIx64 "\n", mp->mz->iova);
 	fprintf(f, "  nb_mem_chunks=%u\n", mp->nb_mem_chunks);
@@ -1625,7 +1625,7 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 	rte_tel_data_add_dict_string(info->d, "name", mp->name);
 	rte_tel_data_add_dict_uint(info->d, "pool_id", mp->pool_id);
 	rte_tel_data_add_dict_uint(info->d, "flags", mp->flags);
-	rte_tel_data_add_dict_int(info->d, "socket_id", mp->socket_id);
+	rte_tel_data_add_dict_int(info->d, "numa_id", mp->numa_id);
 	rte_tel_data_add_dict_uint(info->d, "size", mp->size);
 	rte_tel_data_add_dict_uint(info->d, "cache_size", mp->cache_size);
 	rte_tel_data_add_dict_uint(info->d, "elt_size", mp->elt_size);
@@ -1655,7 +1655,7 @@ mempool_info_cb(struct rte_mempool *mp, void *arg)
 	rte_tel_data_add_dict_uint(info->d, "mz_len", mz->len);
 	rte_tel_data_add_dict_uint(info->d, "mz_hugepage_sz",
 				  mz->hugepage_sz);
-	rte_tel_data_add_dict_int(info->d, "mz_socket_id", mz->socket_id);
+	rte_tel_data_add_dict_int(info->d, "mz_numa_id", mz->socket_id);
 	rte_tel_data_add_dict_uint(info->d, "mz_flags", mz->flags);
 }
 
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index b34cd893b1..9ede776a67 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -245,7 +245,15 @@ struct __rte_cache_aligned rte_mempool {
 	void *pool_config;               /**< optional args for ops alloc. */
 	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
 	unsigned int flags;              /**< Flags of the mempool. */
-	int socket_id;                   /**< Socket id passed at create. */
+	union {
+		/** NUMA node ID passed at create. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint32_t size;                   /**< Max size of the mempool. */
 	uint32_t cache_size;             /**< Size of per-lcore default local cache. */
 
@@ -1084,9 +1092,9 @@ rte_mempool_free(struct rte_mempool *mp);
  * @param obj_init_arg
  *   An opaque pointer to data that can be used as an argument for
  *   each call to the object constructor function.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in the case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in the case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   The *flags* arguments is an OR of following flags:
@@ -1117,11 +1125,11 @@ rte_mempool_free(struct rte_mempool *mp);
  *    - ENOMEM - no appropriate memory area found in which to create memzone
  */
 struct rte_mempool *
-rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
-		   unsigned cache_size, unsigned private_data_size,
+rte_mempool_create(const char *name, unsigned int n, unsigned int elt_size,
+		   unsigned int cache_size, unsigned int private_data_size,
 		   rte_mempool_ctor_t *mp_init, void *mp_init_arg,
 		   rte_mempool_obj_cb_t *obj_init, void *obj_init_arg,
-		   int socket_id, unsigned int flags)
+		   int numa_id, unsigned int flags)
 	__rte_malloc __rte_dealloc(rte_mempool_free, 1);
 
 /**
@@ -1145,9 +1153,9 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
  *   The size of the private data appended after the mempool
  *   structure. This is useful for storing some private data after the
  *   mempool structure, as is done for rte_mbuf_pool for example.
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in the case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the socket identifier in the case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   Flags controlling the behavior of the mempool. See
@@ -1159,7 +1167,7 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
 struct rte_mempool *
 rte_mempool_create_empty(const char *name, unsigned int n, unsigned int elt_size,
 			 unsigned int cache_size, unsigned int private_data_size,
-			 int socket_id, unsigned int flags)
+			 int numa_id, unsigned int flags)
 		__rte_malloc __rte_dealloc(rte_mempool_free, 1);
 
 /**
@@ -1351,12 +1359,12 @@ rte_mempool_cache_free(struct rte_mempool_cache *cache);
  *   The size of the mempool cache. See rte_mempool_create()'s cache_size
  *   parameter description for more information. The same limits and
  *   considerations apply here too.
- * @param socket_id
- *   The socket identifier in the case of NUMA. The value can be
- *   SOCKET_ID_ANY if there is no NUMA constraint for the reserved zone.
+ * @param numa_id
+ *   The NUMA node ID in the case of NUMA. The value can be
+ *   RTE_NUMA_ID_ANY if there is no NUMA constraint for the reserved zone.
  */
 struct rte_mempool_cache *
-rte_mempool_cache_create(uint32_t size, int socket_id)
+rte_mempool_cache_create(uint32_t size, int numa_id)
 	__rte_malloc __rte_dealloc(rte_mempool_cache_free, 1);
 
 /**
-- 
2.55.0

