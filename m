Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DFEF01812
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Mar 2026 08:47:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E26940A7D;
	Fri,  6 Mar 2026 09:47:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5D61640278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 09:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772786852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcvuOeyMvecr3qnM3pHpukp5YSJw2VJRtiHW2BgTTHg=;
 b=FwtGRsz8PZKJKw+N3rUu0KKrqq9A0r3JyacdMRFP19Avn3n5EQRiTwuDrmxfn+5XjilPSJ
 OiiZCQWoEvI918hoiCyWOy7tF06PnSTsv0GADlpudMwcamNA6hdDgGiINNoLLdXhwSZKOX
 RbR9eTXc4KYulHR3Ek4A+TDr0VDZC1k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-Jnd-rMv3MNS1qTAuYWzjjw-1; Fri,
 06 Mar 2026 03:47:31 -0500
X-MC-Unique: Jnd-rMv3MNS1qTAuYWzjjw-1
X-Mimecast-MFC-AGG-ID: Jnd-rMv3MNS1qTAuYWzjjw_1772786849
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 742CF19560A5; Fri,  6 Mar 2026 08:47:29 +0000 (UTC)
Received: from ringo.home (unknown [10.44.33.178])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E0AB1958DC7; Fri,  6 Mar 2026 08:47:26 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Ray Kinsella <mdr@ashroe.eu>, Ruifeng Wang <ruifeng.wang@arm.com>,
 Dharmik Thakkar <dharmikjayesh.thakkar@arm.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
	stable@dpdk.org
Subject: [PATCH dpdk v3 2/2] hash: free replaced data on overwrite when RCU is
 configured
Date: Fri,  6 Mar 2026 09:47:12 +0100
Message-ID: <20260306084710.492520-6-rjarry@redhat.com>
In-Reply-To: <20260306084710.492520-4-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260306084710.492520-4-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zpwp3Y1SxMBqOkeVotZ5wTPKRcIu14YSPVIGdVVtYac_1772786849
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

Cc: stable@dpdk.org
Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_hash.c                   | 134 +++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   7 ++
 lib/hash/rte_cuckoo_hash.c             |  38 ++++++-
 lib/hash/rte_hash.h                    |   8 +-
 4 files changed, 184 insertions(+), 3 deletions(-)

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
index b4499ec066f8..e772fd3cb9b7 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -106,6 +106,13 @@ New Features
   Added handling of the key combination Control+L
   to clear the screen before redisplaying the prompt.
 
+* **Added automatic deferred free on hash data overwrite.**
+
+  When RCU is configured with a ``free_key_data_func`` callback,
+  ``rte_hash_add_key_data`` now automatically defers freeing the old data
+  pointer on key overwrite via the RCU defer queue.
+
+
 Removed Items
 -------------
 
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 36b3b477a55b..69dcfdfc398a 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -75,6 +75,7 @@ EAL_REGISTER_TAILQ(rte_hash_tailq)
 struct __rte_hash_rcu_dq_entry {
 	uint32_t key_idx;
 	uint32_t ext_bkt_idx;
+	void *old_data;
 };
 
 RTE_EXPORT_SYMBOL(rte_hash_find_existing)
@@ -761,6 +762,28 @@ enqueue_slot_back(const struct rte_hash *h,
 						sizeof(uint32_t));
 }
 
+/*
+ * When RCU is configured with a free function, auto-free the overwritten
+ * data pointer via RCU.
+ */
+static inline void
+__rte_hash_rcu_auto_free_old_data(const struct rte_hash *h, void *d)
+{
+	struct __rte_hash_rcu_dq_entry rcu_dq_entry = {
+		.key_idx = EMPTY_SLOT, /* sentinel value for __hash_rcu_qsbr_free_resource */
+		.old_data = d,
+	};
+
+	if (d == NULL || h->hash_rcu_cfg == NULL || h->hash_rcu_cfg->free_key_data_func == NULL)
+		return;
+
+	if (h->dq == NULL || rte_rcu_qsbr_dq_enqueue(h->dq, &rcu_dq_entry) != 0) {
+		/* SYNC mode or enqueue failed in DQ mode */
+		rte_rcu_qsbr_synchronize(h->hash_rcu_cfg->v, RTE_QSBR_THRID_INVALID);
+		h->hash_rcu_cfg->free_key_data_func(h->hash_rcu_cfg->key_data_ptr, d);
+	}
+}
+
 /* Search a key from bucket and update its data.
  * Writer holds the lock before calling this.
  */
@@ -770,6 +793,7 @@ search_and_update(const struct rte_hash *h, void *data, const void *key,
 {
 	int i;
 	struct rte_hash_key *k, *keys = h->key_store;
+	void *old_data;
 
 	for (i = 0; i < RTE_HASH_BUCKET_ENTRIES; i++) {
 		if (bkt->sig_current[i] == sig) {
@@ -782,9 +806,12 @@ search_and_update(const struct rte_hash *h, void *data, const void *key,
 				 * variable. Release the application data
 				 * to the readers.
 				 */
-				rte_atomic_store_explicit(&k->pdata,
+				old_data = rte_atomic_exchange_explicit(&k->pdata,
 					data,
 					rte_memory_order_release);
+
+				__rte_hash_rcu_auto_free_old_data(h, old_data);
+
 				/*
 				 * Return index where key is stored,
 				 * subtracting the first dummy index
@@ -1566,6 +1593,15 @@ __hash_rcu_qsbr_free_resource(void *p, void *e, unsigned int n)
 			*((struct __rte_hash_rcu_dq_entry *)e);
 
 	RTE_SET_USED(n);
+
+	if (rcu_dq_entry.key_idx == EMPTY_SLOT) {
+		/* Overwrite case: free old data only, do not recycle slot */
+		RTE_ASSERT(h->hash_rcu_cfg->free_key_data_func != NULL);
+		h->hash_rcu_cfg->free_key_data_func(h->hash_rcu_cfg->key_data_ptr,
+						    rcu_dq_entry.old_data);
+		return;
+	}
+
 	keys = h->key_store;
 
 	k = (struct rte_hash_key *) ((char *)keys +
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

