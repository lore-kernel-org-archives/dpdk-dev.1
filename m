Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0ECDCCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:10:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D27540647;
	Thu,  6 Nov 2025 15:10:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id C32A64013F;
 Thu,  6 Nov 2025 15:10:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438203; x=1793974203;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ijvFJg77pduU1VJIviABOKW1Bp+3TSWW8omB2O1rW+s=;
 b=L7gIL8VT0dm8X/Xu684UxL4vf/NuxfdVqb/2az51M/OcyFTescg0LGv3
 /EC7szNJVPduevGPWsq/wslR2oaVqoMrB8gduZh+j6RSZkaB3OLUOvaXX
 1BIZ+kB2S4rBY4rMghHwWUof+qB0nrGdpRtpNcBz+VeQJlBaAJioirsC3
 pXUJ+nnxfO+fJjgKnFMrbG2NqD9LnXVI+ziVvdcWEvQHmLiVewbV6ggTx
 XbGIFHN+dwzbYU08pVzbLQE2iO7SKNfNWzGBiBI34C7Kgw76E2WzfaFEF
 G60qmHKxaZE3zGwkT1ARBa4fvZlPvGbgbpC/uwVvY/T6q7D0YiesmeLnL w==;
X-CSE-ConnectionGUID: EZR7qqjqQQyAV1U6RR4S0w==
X-CSE-MsgGUID: ccDva8YVTiGHk2LFkLZ51Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185282"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185282"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:02 -0800
X-CSE-ConnectionGUID: A/PTMk8sQdyhBvcYzkvkTA==
X-CSE-MsgGUID: x/KlaFv8R6CeMoK9+aTdEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054686"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:00 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [RFC PATCH 01/19] eal: fix variable shadowing
Date: Thu,  6 Nov 2025 14:09:30 +0000
Message-ID: <20251106140948.2894678-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

Fix a range of variable shadowing issues flagged by -Wshadow:

* In tracing code, rename local variables to remove shadowing in the
  code.  The file-level variable "trace" is kept as-is, but the shorter
  name "t" is used for function-local vars.
* In options code, rename the "args" variable to "out_args" in the
  telemetry callback, to fix shadowing issues there.
* In malloc code, remove the redefinition of aligned_end, and just use
  the already-defined local variable in the last block of code in the
  function.

Bugzilla ID: 1742
Bugzilla ID: 1743
Fixes: 29d985cad8db ("trace: implement memory allocation")
Fixes: f330b01df996 ("eal: define the parameters in argparse format")
Fixes: 4d8bdd8b56a1 ("malloc: fix ASan handling for unmapped memory")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 lib/eal/common/eal_common_options.c | 12 ++--
 lib/eal/common/eal_common_trace.c   | 89 ++++++++++++++---------------
 lib/eal/common/malloc_heap.c        |  2 +-
 3 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/lib/eal/common/eal_common_options.c b/lib/eal/common/eal_common_options.c
index b1fb670ea0..820725884f 100644
--- a/lib/eal/common/eal_common_options.c
+++ b/lib/eal/common/eal_common_options.c
@@ -339,21 +339,21 @@ int
 handle_eal_info_request(const char *cmd, const char *params __rte_unused,
 		struct rte_tel_data *d)
 {
-	char **args;
+	char **out_args;
 	int used = 0;
 	int i = 0;
 
 	if (strcmp(cmd, EAL_PARAM_REQ) == 0)
-		args = eal_args;
+		out_args = eal_args;
 	else
-		args = eal_app_args;
+		out_args = eal_app_args;
 
 	rte_tel_data_start_array(d, RTE_TEL_STRING_VAL);
-	if (args == NULL || args[0] == NULL)
+	if (out_args == NULL || out_args[0] == NULL)
 		return 0;
 
-	for ( ; args[i] != NULL; i++)
-		used = rte_tel_data_add_array_string(d, args[i]);
+	for ( ; out_args[i] != NULL; i++)
+		used = rte_tel_data_add_array_string(d, out_args[i]);
 	return used;
 }
 
diff --git a/lib/eal/common/eal_common_trace.c b/lib/eal/common/eal_common_trace.c
index be041c45bb..2ef5637cdd 100644
--- a/lib/eal/common/eal_common_trace.c
+++ b/lib/eal/common/eal_common_trace.c
@@ -270,33 +270,32 @@ trace_point_dump(FILE *f, struct trace_point *tp)
 static void
 trace_lcore_mem_dump(FILE *f)
 {
-	struct trace *trace = trace_obj_get();
+	struct trace *t = trace_obj_get();
 	struct __rte_trace_header *header;
 	uint32_t count;
 
-	rte_spinlock_lock(&trace->lock);
-	if (trace->nb_trace_mem_list == 0)
+	rte_spinlock_lock(&t->lock);
+	if (t->nb_trace_mem_list == 0)
 		goto out;
-	fprintf(f, "nb_trace_mem_list = %d\n", trace->nb_trace_mem_list);
+	fprintf(f, "nb_trace_mem_list = %d\n", t->nb_trace_mem_list);
 	fprintf(f, "\nTrace mem info\n--------------\n");
-	for (count = 0; count < trace->nb_trace_mem_list; count++) {
-		header = trace->lcore_meta[count].mem;
+	for (count = 0; count < t->nb_trace_mem_list; count++) {
+		header = t->lcore_meta[count].mem;
 		fprintf(f, "\tid %d, mem=%p, area=%s, lcore_id=%d, name=%s\n",
 		count, header,
-		trace_area_to_string(trace->lcore_meta[count].area),
+		trace_area_to_string(t->lcore_meta[count].area),
 		header->stream_header.lcore_id,
 		header->stream_header.thread_name);
 	}
 out:
-	rte_spinlock_unlock(&trace->lock);
+	rte_spinlock_unlock(&t->lock);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_trace_dump, 20.05)
 void
 rte_trace_dump(FILE *f)
 {
-	struct trace_point_head *tp_list = trace_list_head_get();
-	struct trace *trace = trace_obj_get();
+	struct trace *t = trace_obj_get();
 	struct trace_point *tp;
 
 	fprintf(f, "\nGlobal info\n-----------\n");
@@ -304,13 +303,13 @@ rte_trace_dump(FILE *f)
 		rte_trace_is_enabled() ? "enabled" : "disabled");
 	fprintf(f, "mode = %s\n",
 		trace_mode_to_string(rte_trace_mode_get()));
-	fprintf(f, "dir = %s\n", trace->dir);
-	fprintf(f, "buffer len = %d\n", trace->buff_len);
-	fprintf(f, "number of trace points = %d\n", trace->nb_trace_points);
+	fprintf(f, "dir = %s\n", t->dir);
+	fprintf(f, "buffer len = %d\n", t->buff_len);
+	fprintf(f, "number of trace points = %d\n", t->nb_trace_points);
 
 	trace_lcore_mem_dump(f);
 	fprintf(f, "\nTrace point info\n----------------\n");
-	STAILQ_FOREACH(tp, tp_list, next)
+	STAILQ_FOREACH(tp, trace_list_head_get(), next)
 		trace_point_dump(f, tp);
 }
 
@@ -331,7 +330,7 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_mem_per_thread_alloc, 20.05)
 void
 __rte_trace_mem_per_thread_alloc(void)
 {
-	struct trace *trace = trace_obj_get();
+	struct trace *t = trace_obj_get();
 	struct __rte_trace_header *header;
 	uint32_t count;
 
@@ -341,30 +340,30 @@ __rte_trace_mem_per_thread_alloc(void)
 	if (RTE_PER_LCORE(trace_mem))
 		return;
 
-	rte_spinlock_lock(&trace->lock);
+	rte_spinlock_lock(&t->lock);
 
-	count = trace->nb_trace_mem_list;
+	count = t->nb_trace_mem_list;
 
 	/* Allocate room for storing the thread trace mem meta */
-	trace->lcore_meta = realloc(trace->lcore_meta,
-		sizeof(trace->lcore_meta[0]) * (count + 1));
+	t->lcore_meta = realloc(t->lcore_meta,
+		sizeof(t->lcore_meta[0]) * (count + 1));
 
 	/* Provide dummy space for fast path to consume */
-	if (trace->lcore_meta == NULL) {
+	if (t->lcore_meta == NULL) {
 		trace_crit("trace mem meta memory realloc failed");
 		header = NULL;
 		goto fail;
 	}
 
 	/* First attempt from huge page */
-	header = eal_malloc_no_trace(NULL, trace_mem_sz(trace->buff_len), 8);
+	header = eal_malloc_no_trace(NULL, trace_mem_sz(t->buff_len), 8);
 	if (header) {
-		trace->lcore_meta[count].area = TRACE_AREA_HUGEPAGE;
+		t->lcore_meta[count].area = TRACE_AREA_HUGEPAGE;
 		goto found;
 	}
 
 	/* Second attempt from heap with proper alignment */
-	size_t mem_size = trace_mem_sz(trace->buff_len);
+	size_t mem_size = trace_mem_sz(t->buff_len);
 	void *aligned_ptr = NULL;
 	int ret = posix_memalign(&aligned_ptr, 8, mem_size);
 	header = (ret == 0) ? aligned_ptr : NULL;
@@ -376,14 +375,14 @@ __rte_trace_mem_per_thread_alloc(void)
 	}
 
 	/* Second attempt from heap is success */
-	trace->lcore_meta[count].area = TRACE_AREA_HEAP;
+	t->lcore_meta[count].area = TRACE_AREA_HEAP;
 
 	/* Initialize the trace header */
 found:
 	header->offset = 0;
-	header->len = trace->buff_len;
+	header->len = t->buff_len;
 	header->stream_header.magic = TRACE_CTF_MAGIC;
-	rte_uuid_copy(header->stream_header.uuid, trace->uuid);
+	rte_uuid_copy(header->stream_header.uuid, t->uuid);
 	header->stream_header.lcore_id = rte_lcore_id();
 
 	/* Store the thread name */
@@ -392,11 +391,11 @@ __rte_trace_mem_per_thread_alloc(void)
 	thread_get_name(rte_thread_self(), name,
 		__RTE_TRACE_EMIT_STRING_LEN_MAX);
 
-	trace->lcore_meta[count].mem = header;
-	trace->nb_trace_mem_list++;
+	t->lcore_meta[count].mem = header;
+	t->nb_trace_mem_list++;
 fail:
 	RTE_PER_LCORE(trace_mem) = header;
-	rte_spinlock_unlock(&trace->lock);
+	rte_spinlock_unlock(&t->lock);
 }
 
 static void
@@ -411,7 +410,7 @@ trace_mem_per_thread_free_unlocked(struct thread_mem_meta *meta)
 void
 trace_mem_per_thread_free(void)
 {
-	struct trace *trace = trace_obj_get();
+	struct trace *t = trace_obj_get();
 	struct __rte_trace_header *header;
 	uint32_t count;
 
@@ -419,37 +418,37 @@ trace_mem_per_thread_free(void)
 	if (header == NULL)
 		return;
 
-	rte_spinlock_lock(&trace->lock);
-	for (count = 0; count < trace->nb_trace_mem_list; count++) {
-		if (trace->lcore_meta[count].mem == header)
+	rte_spinlock_lock(&t->lock);
+	for (count = 0; count < t->nb_trace_mem_list; count++) {
+		if (t->lcore_meta[count].mem == header)
 			break;
 	}
-	if (count != trace->nb_trace_mem_list) {
-		struct thread_mem_meta *meta = &trace->lcore_meta[count];
+	if (count != t->nb_trace_mem_list) {
+		struct thread_mem_meta *meta = &t->lcore_meta[count];
 
 		trace_mem_per_thread_free_unlocked(meta);
-		if (count != trace->nb_trace_mem_list - 1) {
+		if (count != t->nb_trace_mem_list - 1) {
 			memmove(meta, meta + 1,
 				sizeof(*meta) *
-				 (trace->nb_trace_mem_list - count - 1));
+				 (t->nb_trace_mem_list - count - 1));
 		}
-		trace->nb_trace_mem_list--;
+		t->nb_trace_mem_list--;
 	}
-	rte_spinlock_unlock(&trace->lock);
+	rte_spinlock_unlock(&t->lock);
 }
 
 void
 trace_mem_free(void)
 {
-	struct trace *trace = trace_obj_get();
+	struct trace *t = trace_obj_get();
 	uint32_t count;
 
-	rte_spinlock_lock(&trace->lock);
-	for (count = 0; count < trace->nb_trace_mem_list; count++) {
-		trace_mem_per_thread_free_unlocked(&trace->lcore_meta[count]);
+	rte_spinlock_lock(&t->lock);
+	for (count = 0; count < t->nb_trace_mem_list; count++) {
+		trace_mem_per_thread_free_unlocked(&t->lcore_meta[count]);
 	}
-	trace->nb_trace_mem_list = 0;
-	rte_spinlock_unlock(&trace->lock);
+	t->nb_trace_mem_list = 0;
+	rte_spinlock_unlock(&t->lock);
 }
 
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_trace_point_emit_field, 20.05)
diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index 13a56e490e..39240c261c 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -1044,9 +1044,9 @@ malloc_heap_free(struct malloc_elem *elem)
 	/* if we unmapped some memory, we need to do additional work for ASan */
 	if (unmapped) {
 		void *asan_end = RTE_PTR_ADD(asan_ptr, asan_data_len);
-		void *aligned_end = RTE_PTR_ADD(aligned_start, aligned_len);
 		void *aligned_trailer = RTE_PTR_SUB(aligned_start,
 				MALLOC_ELEM_TRAILER_LEN);
+		aligned_end = RTE_PTR_ADD(aligned_start, aligned_len);
 
 		/*
 		 * There was a memory area that was unmapped. This memory area
-- 
2.48.1

