Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECD7EEA854
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 21:33:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8375402E2;
	Thu, 12 Feb 2026 22:33:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B778402DB
 for <dev@dpdk.org>; Thu, 12 Feb 2026 22:33:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uXRpYTRlV0q6cCc7hBmtjVd6qEpE9V9PeWsuDHKzIR8=;
 b=UR+qI74kK886MlCV0p5a6BJI57RQA5KSeqLfJvcGm+2UPNpwXARzhZV6uur+wRFX8bq2aB
 L7xEOkd9J2CKd1/uPlf6xv6ob8/H8BtRQDyxRYFYvRKveND4dzD0B/kAeKn3TGcY+KM6ie
 bRJKVXSoiFC6C0roud8oyE9SFWj0km0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-W48j8rByPqG5t26X1nQtMQ-1; Thu,
 12 Feb 2026 16:33:41 -0500
X-MC-Unique: W48j8rByPqG5t26X1nQtMQ-1
X-Mimecast-MFC-AGG-ID: W48j8rByPqG5t26X1nQtMQ_1770932020
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55DF018004BB; Thu, 12 Feb 2026 21:33:40 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.32.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBC6E3000225; Thu, 12 Feb 2026 21:33:37 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk 1/2] hash: free replaced data on overwrite when RCU is
 configured
Date: Thu, 12 Feb 2026 22:33:16 +0100
Message-ID: <20260212213313.1376294-6-rjarry@redhat.com>
In-Reply-To: <20260212213313.1376294-5-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: koWeXtJAHjjQJ9iHauDxAluxewovv1LOV2BSYmkjY4I_1770932020
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

When rte_hash_add_key_data() overwrites an existing key, the old data
pointer is silently lost. With RCU-protected readers still potentially
accessing the old data, the application has no safe way to free it.

When RCU is configured with a free_key_data_func callback, automatically
enqueue the old data for deferred freeing via the RCU defer queue on
overwrite. In SYNC mode, synchronize and call free_key_data_func
directly.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_hash.c                   | 134 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   6 ++
 lib/hash/rte_cuckoo_hash.c             | 106 ++++++++++++++-----
 lib/hash/rte_hash.h                    |   8 +-
 4 files changed, 229 insertions(+), 25 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 3fb3d96d0546..56a7779e09b9 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2342,6 +2342,137 @@ test_hash_rcu_qsbr_dq_reclaim(void)
 	return 0;
 }
 
+static void *old_data;
+
+static void
+test_hash_free_key_data_func(void *p __rte_unused, void *key_data)
+{
+	old_data = key_data;
+}
+
+/*
+ * Test automatic RCU free on overwrite via rte_hash_add_key_data.
+ *  - Create hash with RW_CONCURRENCY_LF and RCU QSBR in DQ mode
+ *    with a free_key_data_func callback that increments a counter.
+ *  - Register a pseudo reader thread.
+ *  - Add key with data (void *)1.
+ *  - Overwrite same key with data (void *)2 via rte_hash_add_key_data.
+ *  - Report quiescent state, trigger reclamation.
+ *  - Verify the free callback was called exactly once.
+ *  - Delete the key, report quiescent state, reclaim again.
+ *  - Verify the free callback was called a second time.
+ */
+static int
+test_hash_rcu_qsbr_replace_auto_free(void)
+{
+	struct rte_hash_rcu_config rcu = {
+		.v = NULL,
+		.mode = RTE_HASH_QSBR_MODE_DQ,
+		.free_key_data_func = test_hash_free_key_data_func,
+		.key_data_ptr = NULL,
+	};
+	struct rte_hash_parameters params = {
+		.name = "test_replace_auto_free",
+		.entries = 16,
+		.key_len = sizeof(uint32_t),
+		.hash_func = NULL,
+		.hash_func_init_val = 0,
+		.socket_id = SOCKET_ID_ANY,
+		.extra_flag = RTE_HASH_EXTRA_FLAGS_RW_CONCURRENCY_LF,
+	};
+	struct rte_hash *hash = NULL;
+	uint32_t key = 55;
+	int32_t status;
+	int ret = -1;
+	size_t sz;
+
+	printf("\n# Running RCU replace auto-free test\n");
+
+	hash = rte_hash_create(&params);
+	if (hash == NULL) {
+		printf("hash creation failed\n");
+		goto end;
+	}
+
+	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
+	rcu.v = rte_zmalloc(NULL, sz, RTE_CACHE_LINE_SIZE);
+	if (rcu.v == NULL) {
+		printf("RCU QSBR alloc failed\n");
+		goto end;
+	}
+	status = rte_rcu_qsbr_init(rcu.v, RTE_MAX_LCORE);
+	if (status != 0) {
+		printf("RCU QSBR init failed\n");
+		goto end;
+	}
+
+	status = rte_hash_rcu_qsbr_add(hash, &rcu);
+	if (status != 0) {
+		printf("RCU QSBR add failed\n");
+		goto end;
+	}
+
+	/* Register pseudo reader */
+	status = rte_rcu_qsbr_thread_register(rcu.v, 0);
+	if (status != 0) {
+		printf("RCU QSBR thread register failed\n");
+		goto end;
+	}
+	rte_rcu_qsbr_thread_online(rcu.v, 0);
+
+	old_data = NULL;
+
+	/* Add key with data = (void *)1 */
+	status = rte_hash_add_key_data(hash, &key, (void *)(uintptr_t)1);
+	if (status != 0) {
+		printf("failed to add key (status=%d)\n", status);
+		goto end;
+	}
+
+	/* Overwrite same key with data = (void *)2 */
+	status = rte_hash_add_key_data(hash, &key, (void *)(uintptr_t)2);
+	if (status != 0) {
+		printf("failed to overwrite key (status=%d)\n", status);
+		goto end;
+	}
+
+	/* Reader quiescent and reclaim */
+	rte_rcu_qsbr_quiescent(rcu.v, 0);
+	rte_hash_rcu_qsbr_dq_reclaim(hash, NULL, NULL, NULL);
+
+	if (old_data != (void *)(uintptr_t)1) {
+		printf("old data should be 0x1 but is %p\n", old_data);
+		goto end;
+	}
+
+	/* Delete the key */
+	status = rte_hash_del_key(hash, &key);
+	if (status < 0) {
+		printf("failed to delete key (status=%d)\n", status);
+		goto end;
+	}
+
+	/* Reader quiescent and reclaim again */
+	rte_rcu_qsbr_quiescent(rcu.v, 0);
+	rte_hash_rcu_qsbr_dq_reclaim(hash, NULL, NULL, NULL);
+
+	if (old_data != (void *)(uintptr_t)2) {
+		printf("old data should be 2 but is %p\n", old_data);
+		goto end;
+	}
+
+	ret = 0;
+end:
+	if (rcu.v != NULL) {
+		rte_rcu_qsbr_thread_offline(rcu.v, 0);
+		rte_rcu_qsbr_thread_unregister(rcu.v, 0);
+	}
+	rte_hash_free(hash);
+	rte_free(rcu.v);
+
+	return ret;
+}
+
 /*
  * Do all unit and performance tests.
  */
@@ -2423,6 +2554,9 @@ test_hash(void)
 	if (test_hash_rcu_qsbr_dq_reclaim() < 0)
 		return -1;
 
+	if (test_hash_rcu_qsbr_replace_auto_free() < 0)
+		return -1;
+
 	return 0;
 }
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index afdf1af06c20..693034bcb0d2 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -87,6 +87,12 @@ New Features
   * Added support for AES-XTS cipher algorithm.
   * Added support for SHAKE-128 and SHAKE-256 authentication algorithms.
 
+* **Added automatic deferred free on hash data overwrite.**
+
+  When RCU is configured with a ``free_key_data_func`` callback,
+  ``rte_hash_add_key_data`` now automatically defers freeing the old data
+  pointer on key overwrite via the RCU defer queue.
+
 
 Removed Items
 -------------
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index da12825c6ed2..0b979dc3be0b 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -75,6 +75,7 @@ EAL_REGISTER_TAILQ(rte_hash_tailq)
 struct __rte_hash_rcu_dq_entry {
 	uint32_t key_idx;
 	uint32_t ext_bkt_idx;
+	void *old_data;
 };
 
 RTE_EXPORT_SYMBOL(rte_hash_find_existing)
@@ -763,10 +764,11 @@ enqueue_slot_back(const struct rte_hash *h,
 
 /* Search a key from bucket and update its data.
  * Writer holds the lock before calling this.
+ * If old_data is non-NULL, save the previous data pointer before overwriting.
  */
 static inline int32_t
 search_and_update(const struct rte_hash *h, void *data, const void *key,
-	struct rte_hash_bucket *bkt, uint16_t sig)
+	struct rte_hash_bucket *bkt, uint16_t sig, void **old_data)
 {
 	int i;
 	struct rte_hash_key *k, *keys = h->key_store;
@@ -776,6 +778,8 @@ search_and_update(const struct rte_hash *h, void *data, const void *key,
 			k = (struct rte_hash_key *) ((char *)keys +
 					bkt->key_idx[i] * h->key_entry_size);
 			if (rte_hash_cmp_eq(key, k->key, h) == 0) {
+				if (old_data != NULL)
+					*old_data = k->pdata;
 				/* The store to application data at *data
 				 * should not leak after the store to pdata
 				 * in the key store. i.e. pdata is the guard
@@ -807,7 +811,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
 		struct rte_hash_bucket *sec_bkt,
 		const struct rte_hash_key *key, void *data,
 		uint16_t sig, uint32_t new_idx,
-		int32_t *ret_val)
+		int32_t *ret_val, void **old_data)
 {
 	unsigned int i;
 	struct rte_hash_bucket *cur_bkt;
@@ -817,7 +821,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
 	/* Check if key was inserted after last check but before this
 	 * protected region in case of inserting duplicated keys.
 	 */
-	ret = search_and_update(h, data, key, prim_bkt, sig);
+	ret = search_and_update(h, data, key, prim_bkt, sig, old_data);
 	if (ret != -1) {
 		__hash_rw_writer_unlock(h);
 		*ret_val = ret;
@@ -825,7 +829,7 @@ rte_hash_cuckoo_insert_mw(const struct rte_hash *h,
 	}
 
 	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
-		ret = search_and_update(h, data, key, cur_bkt, sig);
+		ret = search_and_update(h, data, key, cur_bkt, sig, old_data);
 		if (ret != -1) {
 			__hash_rw_writer_unlock(h);
 			*ret_val = ret;
@@ -872,7 +876,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash *h,
 			const struct rte_hash_key *key, void *data,
 			struct queue_node *leaf, uint32_t leaf_slot,
 			uint16_t sig, uint32_t new_idx,
-			int32_t *ret_val)
+			int32_t *ret_val, void **old_data)
 {
 	uint32_t prev_alt_bkt_idx;
 	struct rte_hash_bucket *cur_bkt;
@@ -892,7 +896,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash *h,
 	/* Check if key was inserted after last check but before this
 	 * protected region.
 	 */
-	ret = search_and_update(h, data, key, bkt, sig);
+	ret = search_and_update(h, data, key, bkt, sig, old_data);
 	if (ret != -1) {
 		__hash_rw_writer_unlock(h);
 		*ret_val = ret;
@@ -900,7 +904,7 @@ rte_hash_cuckoo_move_insert_mw(const struct rte_hash *h,
 	}
 
 	FOR_EACH_BUCKET(cur_bkt, alt_bkt) {
-		ret = search_and_update(h, data, key, cur_bkt, sig);
+		ret = search_and_update(h, data, key, cur_bkt, sig, old_data);
 		if (ret != -1) {
 			__hash_rw_writer_unlock(h);
 			*ret_val = ret;
@@ -997,7 +1001,8 @@ rte_hash_cuckoo_make_space_mw(const struct rte_hash *h,
 			struct rte_hash_bucket *sec_bkt,
 			const struct rte_hash_key *key, void *data,
 			uint16_t sig, uint32_t bucket_idx,
-			uint32_t new_idx, int32_t *ret_val)
+			uint32_t new_idx, int32_t *ret_val,
+			void **old_data)
 {
 	unsigned int i;
 	struct queue_node queue[RTE_HASH_BFS_QUEUE_MAX_LEN];
@@ -1023,7 +1028,7 @@ rte_hash_cuckoo_make_space_mw(const struct rte_hash *h,
 				int32_t ret = rte_hash_cuckoo_move_insert_mw(h,
 						bkt, sec_bkt, key, data,
 						tail, i, sig,
-						new_idx, ret_val);
+						new_idx, ret_val, old_data);
 				if (likely(ret != -1))
 					return ret;
 			}
@@ -1076,6 +1081,33 @@ alloc_slot(const struct rte_hash *h, struct lcore_cache *cached_free_slots)
 	return slot_id;
 }
 
+/*
+ * When RCU is configured with a free function, auto-free the overwritten
+ * data pointer via RCU.
+ */
+static inline void
+__hash_rcu_auto_free_old_data(const struct rte_hash *h, void *old_data_val)
+{
+	if (h->hash_rcu_cfg == NULL || h->hash_rcu_cfg->free_key_data_func == NULL)
+		return;
+
+	if (h->dq != NULL) {
+		/* DQ mode: enqueue with sentinel key_idx=0 */
+		struct __rte_hash_rcu_dq_entry rcu_dq_entry = {
+			.key_idx = 0,
+			.ext_bkt_idx = EMPTY_SLOT,
+			.old_data = old_data_val,
+		};
+		if (rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) != 0)
+			HASH_LOG(ERR, "Failed to push QSBR FIFO");
+	} else {
+		/* SYNC mode */
+		rte_rcu_qsbr_synchronize(h->hash_rcu_cfg->v, RTE_QSBR_THRID_INVALID);
+		h->hash_rcu_cfg->free_key_data_func(
+			h->hash_rcu_cfg->key_data_ptr, old_data_val);
+	}
+}
+
 static inline int32_t
 __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 						hash_sig_t sig, void *data)
@@ -1092,6 +1124,7 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 	struct lcore_cache *cached_free_slots = NULL;
 	int32_t ret_val;
 	struct rte_hash_bucket *last;
+	void *saved_old_data = NULL;
 
 	short_sig = get_short_sig(sig);
 	prim_bucket_idx = get_prim_bucket_index(h, sig);
@@ -1103,18 +1136,20 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 
 	/* Check if key is already inserted in primary location */
 	__hash_rw_writer_lock(h);
-	ret = search_and_update(h, data, key, prim_bkt, short_sig);
+	ret = search_and_update(h, data, key, prim_bkt, short_sig,
+				&saved_old_data);
 	if (ret != -1) {
 		__hash_rw_writer_unlock(h);
-		return ret;
+		goto overwrite;
 	}
 
 	/* Check if key is already inserted in secondary location */
 	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
-		ret = search_and_update(h, data, key, cur_bkt, short_sig);
+		ret = search_and_update(h, data, key, cur_bkt, short_sig,
+					&saved_old_data);
 		if (ret != -1) {
 			__hash_rw_writer_unlock(h);
-			return ret;
+			goto overwrite;
 		}
 	}
 
@@ -1153,33 +1188,39 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 
 	/* Find an empty slot and insert */
 	ret = rte_hash_cuckoo_insert_mw(h, prim_bkt, sec_bkt, key, data,
-					short_sig, slot_id, &ret_val);
+					short_sig, slot_id, &ret_val,
+					&saved_old_data);
 	if (ret == 0)
 		return slot_id - 1;
 	else if (ret == 1) {
 		enqueue_slot_back(h, cached_free_slots, slot_id);
-		return ret_val;
+		ret = ret_val;
+		goto overwrite;
 	}
 
 	/* Primary bucket full, need to make space for new entry */
 	ret = rte_hash_cuckoo_make_space_mw(h, prim_bkt, sec_bkt, key, data,
-				short_sig, prim_bucket_idx, slot_id, &ret_val);
+				short_sig, prim_bucket_idx, slot_id, &ret_val,
+				&saved_old_data);
 	if (ret == 0)
 		return slot_id - 1;
 	else if (ret == 1) {
 		enqueue_slot_back(h, cached_free_slots, slot_id);
-		return ret_val;
+		ret = ret_val;
+		goto overwrite;
 	}
 
 	/* Also search secondary bucket to get better occupancy */
 	ret = rte_hash_cuckoo_make_space_mw(h, sec_bkt, prim_bkt, key, data,
-				short_sig, sec_bucket_idx, slot_id, &ret_val);
+				short_sig, sec_bucket_idx, slot_id, &ret_val,
+				&saved_old_data);
 
 	if (ret == 0)
 		return slot_id - 1;
 	else if (ret == 1) {
 		enqueue_slot_back(h, cached_free_slots, slot_id);
-		return ret_val;
+		ret = ret_val;
+		goto overwrite;
 	}
 
 	/* if ext table not enabled, we failed the insertion */
@@ -1193,17 +1234,21 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 	 */
 	__hash_rw_writer_lock(h);
 	/* We check for duplicates again since could be inserted before the lock */
-	ret = search_and_update(h, data, key, prim_bkt, short_sig);
+	ret = search_and_update(h, data, key, prim_bkt, short_sig,
+				&saved_old_data);
 	if (ret != -1) {
 		enqueue_slot_back(h, cached_free_slots, slot_id);
-		goto failure;
+		__hash_rw_writer_unlock(h);
+		goto overwrite;
 	}
 
 	FOR_EACH_BUCKET(cur_bkt, sec_bkt) {
-		ret = search_and_update(h, data, key, cur_bkt, short_sig);
+		ret = search_and_update(h, data, key, cur_bkt, short_sig,
+					&saved_old_data);
 		if (ret != -1) {
 			enqueue_slot_back(h, cached_free_slots, slot_id);
-			goto failure;
+			__hash_rw_writer_unlock(h);
+			goto overwrite;
 		}
 	}
 
@@ -1263,6 +1308,11 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 	__hash_rw_writer_unlock(h);
 	return slot_id - 1;
 
+overwrite:
+	if (saved_old_data != NULL)
+		__hash_rcu_auto_free_old_data(h, saved_old_data);
+	return ret;
+
 failure:
 	__hash_rw_writer_unlock(h);
 	return ret;
@@ -1566,6 +1616,15 @@ __hash_rcu_qsbr_free_resource(void *p, void *e, unsigned int n)
 			*((struct __rte_hash_rcu_dq_entry *)e);
 
 	RTE_SET_USED(n);
+
+	/* Overwrite case: free old data only, do not recycle slot */
+	if (rcu_dq_entry.old_data != NULL) {
+		h->hash_rcu_cfg->free_key_data_func(
+			h->hash_rcu_cfg->key_data_ptr,
+			rcu_dq_entry.old_data);
+		return;
+	}
+
 	keys = h->key_store;
 
 	k = (struct rte_hash_key *) ((char *)keys +
@@ -1870,6 +1929,7 @@ __rte_hash_del_key_with_hash(const struct rte_hash *h, const void *key,
 		/* Key index where key is stored, adding the first dummy index */
 		rcu_dq_entry.key_idx = ret + 1;
 		rcu_dq_entry.ext_bkt_idx = index;
+		rcu_dq_entry.old_data = NULL;
 		if (h->dq == NULL) {
 			/* Wait for quiescent state change if using
 			 * RTE_HASH_QSBR_MODE_SYNC
diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
index f692e0868dcf..e33f0aea0f5e 100644
--- a/lib/hash/rte_hash.h
+++ b/lib/hash/rte_hash.h
@@ -226,7 +226,9 @@ rte_hash_max_key_id(const struct rte_hash *h);
  * Thread safety can be enabled by setting flag during
  * table creation.
  * If the key exists already in the table, this API updates its value
- * with 'data' passed in this API. It is the responsibility of
+ * with 'data' passed in this API. If RCU is configured with a
+ * free_key_data_func callback, the old data is automatically
+ * deferred-freed via RCU. Otherwise, it is the responsibility of
  * the application to manage any memory associated with the old value.
  * The readers might still be using the old value even after this API
  * has returned.
@@ -253,7 +255,9 @@ rte_hash_add_key_data(const struct rte_hash *h, const void *key, void *data);
  * Thread safety can be enabled by setting flag during
  * table creation.
  * If the key exists already in the table, this API updates its value
- * with 'data' passed in this API. It is the responsibility of
+ * with 'data' passed in this API. If RCU is configured with a
+ * free_key_data_func callback, the old data is automatically
+ * deferred-freed via RCU. Otherwise, it is the responsibility of
  * the application to manage any memory associated with the old value.
  * The readers might still be using the old value even after this API
  * has returned.
-- 
2.53.0

