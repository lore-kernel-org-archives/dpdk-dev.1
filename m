Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86377606A32C
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Rk7FWOFI
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEB0841149;
	Tue,  3 Nov 2026 15:53:59 +0100 (CET)
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
 by mails.dpdk.org (Postfix) with ESMTPS id 2A9DE41149
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:58 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=5aKnp7e4kr7TvrrcURGrSuv3j8BVZB+Tj9kASwEov/I=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717637; v=1; x=1794322437;
 b=Rk7FWOFIn6ZHbzQurgw4Ce6ZS8SyKvIzJL9qj5dYjSViDoUQ5vmX22JCOOYNK+IrrMiC4mjk
 3gIcZscQ5rB8uykHPCji6Bv0qwOEX1s8EN2xCAKbx1WHztXAyb/olgJjEFk2eyLpue3tnPkZubB
 EjkG1tWVTM2psDQR1Og2RHDI=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 453af1e90c0f484d;
 Tue, 03 Nov 2026 14:53:57 +0000
X-Mizu-Trace-ID: 453af1e90c0f484d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 005/227] member: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:23 +0800
Message-ID: <20261103145306.487255-6-chengwen.feng@linux.dev>
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

Rename socket_id fields of rte_member_parameters and
rte_member_setsum to numa_id, keeping socket_id as a deprecated
union alias, and update in-tree users accordingly.

Also rename socket parameters and comments to the NUMA node
terminology, and switch internal calls to rte_zmalloc_numa().

No functional change.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_member.c         |  6 +++---
 app/test/test_member_perf.c    |  4 ++--
 lib/member/rte_member.c        |  8 ++++----
 lib/member/rte_member.h        | 20 ++++++++++++++++++--
 lib/member/rte_member_heap.h   | 18 +++++++++---------
 lib/member/rte_member_ht.c     |  4 ++--
 lib/member/rte_member_sketch.c | 24 ++++++++++++------------
 lib/member/rte_member_vbf.c    |  4 ++--
 8 files changed, 52 insertions(+), 36 deletions(-)

diff --git a/app/test/test_member.c b/app/test/test_member.c
index 23447196c3..1ba4156367 100644
--- a/app/test/test_member.c
+++ b/app/test/test_member.c
@@ -107,7 +107,7 @@ static struct rte_member_parameters params = {
 		.false_positive_rate = 0.03,
 		.prim_hash_seed = 1,
 		.sec_hash_seed = 11,
-		.socket_id = 0			/* NUMA Socket ID for memory. */
+		.numa_id = 0			/* NUMA Socket ID for memory. */
 };
 
 /* for sketch definitions */
@@ -146,7 +146,7 @@ test_member_find_existing(void)
 		.false_positive_rate = 0.03,
 		.prim_hash_seed = 1,
 		.sec_hash_seed = 11,
-		.socket_id = 0			/* NUMA Socket ID for memory. */
+		.numa_id = 0			/* NUMA Socket ID for memory. */
 	};
 
 	/* Create */
@@ -182,7 +182,7 @@ test_member_create_bad_param(void)
 		.false_positive_rate = 0.03,
 		.prim_hash_seed = 1,
 		.sec_hash_seed = 11,
-		.socket_id = 0			/* NUMA Socket ID for memory. */
+		.numa_id = 0			/* NUMA Socket ID for memory. */
 	};
 
 	printf("Expected error section begin...\n");
diff --git a/app/test/test_member_perf.c b/app/test/test_member_perf.c
index db6b8a18ef..5bf75bf8d4 100644
--- a/app/test/test_member_perf.c
+++ b/app/test/test_member_perf.c
@@ -140,7 +140,7 @@ struct rte_member_parameters member_params = {
 		.false_positive_rate = 0.03,
 		.prim_hash_seed = 0,
 		.sec_hash_seed = 1,
-		.socket_id = 0,			/* NUMA Socket ID for memory. */
+		.numa_id = 0,			/* NUMA Socket ID for memory. */
 	};
 
 static int
@@ -220,7 +220,7 @@ setup_keys_and_data(struct member_perf_params *params, unsigned int cycle,
 	}
 	member_params.false_positive_rate = VBF_FALSE_RATE;
 	member_params.key_len = params->key_size;
-	member_params.socket_id = test_socket_id;
+	member_params.numa_id = test_socket_id;
 	member_params.num_keys = entry_cnt;
 	member_params.name = "test_member_ht";
 	member_params.is_cache = 0;
diff --git a/lib/member/rte_member.c b/lib/member/rte_member.c
index 5ff32f1e45..a213504425 100644
--- a/lib/member/rte_member.c
+++ b/lib/member/rte_member.c
@@ -115,7 +115,7 @@ rte_member_create(const struct rte_member_parameters *params)
 	if (params->type == RTE_MEMBER_TYPE_SKETCH) {
 		snprintf(ring_name, sizeof(ring_name), "SK_%s", params->name);
 		sketch_key_ring = rte_ring_create_elem(ring_name, sizeof(uint32_t),
-				rte_align32pow2(params->top_k), params->socket_id, 0);
+				rte_align32pow2(params->top_k), params->numa_id, 0);
 		if (sketch_key_ring == NULL) {
 			MEMBER_LOG(ERR, "Sketch Ring Memory allocation failed");
 			return NULL;
@@ -145,16 +145,16 @@ rte_member_create(const struct rte_member_parameters *params)
 	}
 
 	/* Create a new setsum structure */
-	setsum = rte_zmalloc_socket(params->name,
+	setsum = rte_zmalloc_numa(params->name,
 			sizeof(struct rte_member_setsum), RTE_CACHE_LINE_SIZE,
-			params->socket_id);
+			params->numa_id);
 	if (setsum == NULL) {
 		MEMBER_LOG(ERR, "Create setsummary failed");
 		goto error_unlock_exit;
 	}
 	strlcpy(setsum->name, params->name, sizeof(setsum->name));
 	setsum->type = params->type;
-	setsum->socket_id = params->socket_id;
+	setsum->numa_id = params->numa_id;
 	setsum->key_len = params->key_len;
 	setsum->num_set = params->num_set;
 	setsum->prim_hash_seed = params->prim_hash_seed;
diff --git a/lib/member/rte_member.h b/lib/member/rte_member.h
index 6d9740e0f1..9f9b74b421 100644
--- a/lib/member/rte_member.h
+++ b/lib/member/rte_member.h
@@ -171,7 +171,15 @@ struct __rte_cache_aligned rte_member_setsum {
 
 
 	/* Second cache line should start here. */
-	uint32_t socket_id;          /* NUMA Socket ID for memory. */
+	union {
+		/** NUMA node ID for memory. */
+		uint32_t numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		uint32_t socket_id;
+	};
 	char name[RTE_MEMBER_NAMESIZE]; /* Name of this set summary. */
 #ifdef RTE_ARCH_X86
 	bool use_avx512;
@@ -316,7 +324,15 @@ struct __rte_cache_aligned rte_member_parameters {
 	 */
 	uint32_t extra_flag;
 
-	int socket_id;			/**< NUMA Socket ID for memory. */
+	union {
+		/** NUMA node ID for memory. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 };
 
 /**
diff --git a/lib/member/rte_member_heap.h b/lib/member/rte_member_heap.h
index d551c85a75..40e4991e38 100644
--- a/lib/member/rte_member_heap.h
+++ b/lib/member/rte_member_heap.h
@@ -38,7 +38,7 @@ struct node {
 struct minheap {
 	uint32_t key_len;
 	uint32_t size;
-	uint32_t socket;
+	uint32_t numa_id;
 	struct hash *hashtable;
 	struct node *elem;
 };
@@ -134,9 +134,9 @@ resize_hash_table(struct minheap *hp)
 			hp->hashtable->num_item / ((float)hp->hashtable->bkt_cnt * HASH_BKT_SIZE));
 		MEMBER_LOG(ERR, "Sketch Minheap HT resize happen!");
 		rte_free(hp->hashtable);
-		hp->hashtable = rte_zmalloc_socket(NULL, sizeof(struct hash) +
+		hp->hashtable = rte_zmalloc_numa(NULL, sizeof(struct hash) +
 						new_bkt_cnt * sizeof(struct hash_bkt),
-						RTE_CACHE_LINE_SIZE, hp->socket);
+						RTE_CACHE_LINE_SIZE, hp->numa_id);
 
 		if (hp->hashtable == NULL) {
 			MEMBER_LOG(ERR, "Sketch Minheap HT allocation failed");
@@ -170,10 +170,10 @@ rte_member_minheap_find(struct minheap *hp, const void *key)
 
 static int
 rte_member_minheap_init(struct minheap *heap, int size,
-			uint32_t socket, uint32_t seed)
+			uint32_t numa_id, uint32_t seed)
 {
-	heap->elem = rte_zmalloc_socket(NULL, sizeof(struct node) * size,
-				RTE_CACHE_LINE_SIZE, socket);
+	heap->elem = rte_zmalloc_numa(NULL, sizeof(struct node) * size,
+				RTE_CACHE_LINE_SIZE, numa_id);
 	if (heap->elem == NULL) {
 		MEMBER_LOG(ERR, "Sketch Minheap elem allocation failed");
 		return -ENOMEM;
@@ -184,9 +184,9 @@ rte_member_minheap_init(struct minheap *heap, int size,
 	if (hash_bkt_cnt == 0)
 		hash_bkt_cnt = 1;
 
-	heap->hashtable = rte_zmalloc_socket(NULL, sizeof(struct hash) +
+	heap->hashtable = rte_zmalloc_numa(NULL, sizeof(struct hash) +
 					hash_bkt_cnt * sizeof(struct hash_bkt),
-					RTE_CACHE_LINE_SIZE, socket);
+					RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (heap->hashtable == NULL) {
 		MEMBER_LOG(ERR, "Sketch Minheap HT allocation failed");
@@ -196,7 +196,7 @@ rte_member_minheap_init(struct minheap *heap, int size,
 
 	heap->hashtable->seed = seed;
 	heap->hashtable->bkt_cnt = hash_bkt_cnt;
-	heap->socket = socket;
+	heap->numa_id = numa_id;
 
 	return 0;
 }
diff --git a/lib/member/rte_member_ht.c b/lib/member/rte_member_ht.c
index 8c89a949c8..1f82d0fe16 100644
--- a/lib/member/rte_member_ht.c
+++ b/lib/member/rte_member_ht.c
@@ -95,9 +95,9 @@ rte_member_create_ht(struct rte_member_setsum *ss,
 
 	size_bucket_t = sizeof(struct member_ht_bucket);
 
-	struct member_ht_bucket *buckets = rte_zmalloc_socket(NULL,
+	struct member_ht_bucket *buckets = rte_zmalloc_numa(NULL,
 			num_buckets * size_bucket_t,
-			RTE_CACHE_LINE_SIZE, ss->socket_id);
+			RTE_CACHE_LINE_SIZE, ss->numa_id);
 
 	if (buckets == NULL) {
 		MEMBER_LOG(ERR, "memory allocation failed for HT "
diff --git a/lib/member/rte_member_sketch.c b/lib/member/rte_member_sketch.c
index b753bac1bd..0d551f4bd7 100644
--- a/lib/member/rte_member_sketch.c
+++ b/lib/member/rte_member_sketch.c
@@ -160,7 +160,7 @@ rte_member_create_sketch(struct rte_member_setsum *ss,
 		ss->sketch_delete = sketch_delete_scalar;
 	}
 
-	ss->socket_id = params->socket_id;
+	ss->numa_id = params->numa_id;
 
 	if (ss->count_byte == 0)
 		num_col = 4.0 / params->error_rate / params->sample_rate;
@@ -171,23 +171,23 @@ rte_member_create_sketch(struct rte_member_setsum *ss,
 	else
 		num_col = 4.0 / params->error_rate;
 
-	ss->table = rte_zmalloc_socket(NULL,
+	ss->table = rte_zmalloc_numa(NULL,
 			sizeof(uint64_t) * num_col * ss->num_row,
-			RTE_CACHE_LINE_SIZE, ss->socket_id);
+			RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (ss->table == NULL) {
 		MEMBER_LOG(ERR, "Sketch Table memory allocation failed");
 		return -ENOMEM;
 	}
 
-	ss->hash_seeds = rte_zmalloc_socket(NULL, sizeof(uint64_t) * ss->num_row,
-			RTE_CACHE_LINE_SIZE, ss->socket_id);
+	ss->hash_seeds = rte_zmalloc_numa(NULL, sizeof(uint64_t) * ss->num_row,
+			RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (ss->hash_seeds == NULL) {
 		MEMBER_LOG(ERR, "Sketch Hashseeds memory allocation failed");
 		return -ENOMEM;
 	}
 
-	ss->runtime_var = rte_zmalloc_socket(NULL, sizeof(struct sketch_runtime),
-					RTE_CACHE_LINE_SIZE, ss->socket_id);
+	ss->runtime_var = rte_zmalloc_numa(NULL, sizeof(struct sketch_runtime),
+					RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (ss->runtime_var == NULL) {
 		MEMBER_LOG(ERR, "Sketch Runtime memory allocation failed");
 		rte_free(ss);
@@ -204,8 +204,8 @@ rte_member_create_sketch(struct rte_member_setsum *ss,
 	ss->key_len = params->key_len;
 	runtime->heap.key_len = ss->key_len;
 
-	runtime->key_slots = rte_zmalloc_socket(NULL, ss->key_len * ss->topk,
-					RTE_CACHE_LINE_SIZE, ss->socket_id);
+	runtime->key_slots = rte_zmalloc_numa(NULL, ss->key_len * ss->topk,
+					RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (runtime->key_slots == NULL) {
 		MEMBER_LOG(ERR, "Sketch Key Slots allocation failed");
 		goto error;
@@ -217,13 +217,13 @@ rte_member_create_sketch(struct rte_member_setsum *ss,
 					&i, sizeof(uint32_t));
 
 	if (rte_member_minheap_init(&(runtime->heap), params->top_k,
-			ss->socket_id, params->prim_hash_seed) < 0) {
+			ss->numa_id, params->prim_hash_seed) < 0) {
 		MEMBER_LOG(ERR, "Sketch Minheap allocation failed");
 		goto error_runtime;
 	}
 
-	runtime->report_array = rte_zmalloc_socket(NULL, sizeof(struct node) * ss->topk,
-					RTE_CACHE_LINE_SIZE, ss->socket_id);
+	runtime->report_array = rte_zmalloc_numa(NULL, sizeof(struct node) * ss->topk,
+					RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (runtime->report_array == NULL) {
 		MEMBER_LOG(ERR, "Sketch Runtime Report Array allocation failed");
 		goto error_runtime;
diff --git a/lib/member/rte_member_vbf.c b/lib/member/rte_member_vbf.c
index 5ad9487fad..9eb3f4a6f3 100644
--- a/lib/member/rte_member_vbf.c
+++ b/lib/member/rte_member_vbf.c
@@ -118,8 +118,8 @@ rte_member_create_vbf(struct rte_member_setsum *ss,
 		"The new calculated vBF false positive rate is %.5f",
 		num_keys_per_bf, ss->bits, ss->num_hashes, fp_one_bf, new_fp);
 
-	ss->table = rte_zmalloc_socket(NULL, ss->num_set * (ss->bits >> 3),
-					RTE_CACHE_LINE_SIZE, ss->socket_id);
+	ss->table = rte_zmalloc_numa(NULL, ss->num_set * (ss->bits >> 3),
+					RTE_CACHE_LINE_SIZE, ss->numa_id);
 	if (ss->table == NULL)
 		return -ENOMEM;
 
-- 
2.55.0

