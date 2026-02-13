Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F601EDF151
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:35:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 183D340674;
	Fri, 13 Feb 2026 11:35:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CFE4740655
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770978903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rv5XIrQV83vRdgDdYkHkL9RtzQK6OeugiM6877isjDY=;
 b=Qtc9+ZTAYrq6gaPqFIL2LnAV/5qw0nOKlAqvsAd9hasJ33cOfH7TJmSM/vKxdMC2cZoTJ/
 hs1FAH6vR2rQw/AAu5oKr+pTz8sN28X4yGTvk8dp0MQRZNmJtGPHEAdU9RFJwjy5MO1I44
 LjIjTHjMcLLmeGGjlZ23g78xOwOpg2o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-1oF3xGW_OZqjMZGHcS-37A-1; Fri,
 13 Feb 2026 05:35:02 -0500
X-MC-Unique: 1oF3xGW_OZqjMZGHcS-37A-1
X-Mimecast-MFC-AGG-ID: 1oF3xGW_OZqjMZGHcS-37A_1770978900
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAF121956052; Fri, 13 Feb 2026 10:35:00 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A3C4319560B9; Fri, 13 Feb 2026 10:34:58 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org, Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk v2 3/3] hash: add replace API returning old data on
 overwrite
Date: Fri, 13 Feb 2026 11:34:41 +0100
Message-ID: <20260213103441.1505659-4-rjarry@redhat.com>
In-Reply-To: <20260213103441.1505659-1-rjarry@redhat.com>
References: <20260212213313.1376294-5-rjarry@redhat.com>
 <20260213103441.1505659-1-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZAr9Sxv7k4tJhGz5Tqk-2Efi8C-Ae3pkZYZ3aP28Y6s_1770978900
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

Add rte_hash_replace_key_data() and rte_hash_replace_key_with_hash_data()
which behave like their add_key_data counterparts but return the previous
data pointer via an output parameter. On fresh insert, *old_data is set
to NULL.

When the caller provides old_data, no automatic RCU deferred free is
performed: the caller takes ownership of the old pointer and is
responsible for freeing it.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_hash.c                   | 80 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |  6 ++
 lib/hash/rte_cuckoo_hash.c             | 42 ++++++++++++--
 lib/hash/rte_hash.h                    | 67 +++++++++++++++++++++
 4 files changed, 189 insertions(+), 6 deletions(-)

diff --git a/app/test/test_hash.c b/app/test/test_hash.c
index 56a7779e09b9..fcc02ea31205 100644
--- a/app/test/test_hash.c
+++ b/app/test/test_hash.c
@@ -2473,6 +2473,83 @@ test_hash_rcu_qsbr_replace_auto_free(void)
 	return ret;
 }
 
+/*
+ * Test rte_hash_replace_key_data (explicit replace, no RCU).
+ *  - Add key with data pointer (void *)1.
+ *  - Replace same key with data (void *)2, verify old_data == (void *)1.
+ *  - Lookup and verify data == (void *)2.
+ *  - Replace with a new key (not yet inserted), verify old_data == NULL.
+ */
+static int
+test_hash_replace_key_data(void)
+{
+	struct rte_hash_parameters params = {
+		.name = "test_replace_key_data",
+		.entries = 64,
+		.key_len = sizeof(uint32_t),
+		.hash_func = NULL,
+		.hash_func_init_val = 0,
+		.socket_id = SOCKET_ID_ANY,
+	};
+	struct rte_hash *hash;
+	void *old_data = NULL;
+	void *data = NULL;
+	uint32_t key1 = 42;
+	uint32_t key2 = 99;
+	int ret = -1;
+
+	printf("\n# Running replace key data test\n");
+
+	hash = rte_hash_create(&params);
+	if (hash == NULL) {
+		printf("hash creation failed\n");
+		goto end;
+	}
+
+	/* Add key with data = (void *)1 */
+	ret = rte_hash_add_key_data(hash, &key1, (void *)(uintptr_t)1);
+	if (ret != 0) {
+		printf("failed to add key (ret=%d)\n", ret);
+		goto end;
+	}
+
+	/* Replace same key with data = (void *)2 */
+	ret = rte_hash_replace_key_data(hash, &key1, (void *)(uintptr_t)2, &old_data);
+	if (ret != 0) {
+		printf("failed to replace key (ret=%d)\n", ret);
+		goto end;
+	}
+	if (old_data != (void *)(uintptr_t)1) {
+		printf("old_data should be 0x1 but is %p\n", old_data);
+		goto end;
+	}
+
+	/* Lookup and verify data == (void *)2 */
+	ret = rte_hash_lookup_data(hash, &key1, &data);
+	if (ret < 0 || data != (void *)(uintptr_t)2) {
+		printf("lookup returned wrong data %p (ret=%d)\n", data, ret);
+		goto end;
+	}
+
+	/* Replace with a new key (not yet inserted) */
+	old_data = (void *)(uintptr_t)0xdeadbeef;
+	ret = rte_hash_replace_key_data(hash, &key2, (void *)(uintptr_t)3, &old_data);
+	if (ret != 0) {
+		printf("failed to insert new key via replace (ret=%d)\n", ret);
+		goto end;
+	}
+	if (old_data != NULL) {
+		printf("old_data should be NULL on fresh insert but is %p\n",
+		       old_data);
+		goto end;
+	}
+
+end:
+	rte_hash_free(hash);
+
+	return ret;
+}
+
 /*
  * Do all unit and performance tests.
  */
@@ -2557,6 +2634,9 @@ test_hash(void)
 	if (test_hash_rcu_qsbr_replace_auto_free() < 0)
 		return -1;
 
+	if (test_hash_replace_key_data() < 0)
+		return -1;
+
 	return 0;
 }
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 693034bcb0d2..73418523809c 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -93,6 +93,12 @@ New Features
   ``rte_hash_add_key_data`` now automatically defers freeing the old data
   pointer on key overwrite via the RCU defer queue.
 
+* **Added hash replace API.**
+
+  Added ``rte_hash_replace_key_data`` and ``rte_hash_replace_key_with_hash_data``
+  functions that return the previous data pointer on key overwrite, letting the
+  caller manage its lifecycle.
+
 
 Removed Items
 -------------
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index f487b3b725dd..cf957de55288 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -1106,7 +1106,7 @@ __hash_rcu_auto_free_old_data(const struct rte_hash *h, void *old_data_val)
 
 static inline int32_t
 __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
-						hash_sig_t sig, void *data)
+			     hash_sig_t sig, void *data, void **old_data)
 {
 	uint16_t short_sig;
 	uint32_t prim_bucket_idx, sec_bucket_idx;
@@ -1305,7 +1305,9 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 	return slot_id - 1;
 
 overwrite:
-	if (saved_old_data != NULL)
+	if (old_data != NULL)
+		*old_data = saved_old_data;
+	else if (saved_old_data != NULL)
 		__hash_rcu_auto_free_old_data(h, saved_old_data);
 	return ret;
 
@@ -1321,7 +1323,7 @@ rte_hash_add_key_with_hash(const struct rte_hash *h,
 			const void *key, hash_sig_t sig)
 {
 	RETURN_IF_TRUE(((h == NULL) || (key == NULL)), -EINVAL);
-	return __rte_hash_add_key_with_hash(h, key, sig, 0);
+	return __rte_hash_add_key_with_hash(h, key, sig, 0, NULL);
 }
 
 RTE_EXPORT_SYMBOL(rte_hash_add_key)
@@ -1329,7 +1331,7 @@ int32_t
 rte_hash_add_key(const struct rte_hash *h, const void *key)
 {
 	RETURN_IF_TRUE(((h == NULL) || (key == NULL)), -EINVAL);
-	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0);
+	return __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), 0, NULL);
 }
 
 RTE_EXPORT_SYMBOL(rte_hash_add_key_with_hash_data)
@@ -1340,7 +1342,7 @@ rte_hash_add_key_with_hash_data(const struct rte_hash *h,
 	int ret;
 
 	RETURN_IF_TRUE(((h == NULL) || (key == NULL)), -EINVAL);
-	ret = __rte_hash_add_key_with_hash(h, key, sig, data);
+	ret = __rte_hash_add_key_with_hash(h, key, sig, data, NULL);
 	if (ret >= 0)
 		return 0;
 	else
@@ -1355,13 +1357,41 @@ rte_hash_add_key_data(const struct rte_hash *h, const void *key, void *data)
 
 	RETURN_IF_TRUE(((h == NULL) || (key == NULL)), -EINVAL);
 
-	ret = __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), data);
+	ret = __rte_hash_add_key_with_hash(h, key, rte_hash_hash(h, key), data, NULL);
 	if (ret >= 0)
 		return 0;
 	else
 		return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_replace_key_with_hash_data, 26.03)
+int
+rte_hash_replace_key_with_hash_data(const struct rte_hash *h,
+				    const void *key, hash_sig_t sig,
+				    void *data, void **old_data)
+{
+	int ret;
+
+	RETURN_IF_TRUE(((h == NULL) || (key == NULL) ||
+			(old_data == NULL)), -EINVAL);
+
+	*old_data = NULL;
+	ret = __rte_hash_add_key_with_hash(h, key, sig, data, old_data);
+	if (ret >= 0)
+		return 0;
+	else
+		return ret;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_hash_replace_key_data, 26.03)
+int
+rte_hash_replace_key_data(const struct rte_hash *h, const void *key,
+			  void *data, void **old_data)
+{
+	return rte_hash_replace_key_with_hash_data(h, key,
+			rte_hash_hash(h, key), data, old_data);
+}
+
 /* Search one bucket to find the match key - uses rw lock */
 static inline int32_t
 search_one_bucket_l(const struct rte_hash *h, const void *key,
diff --git a/lib/hash/rte_hash.h b/lib/hash/rte_hash.h
index e33f0aea0f5e..4a328c51501c 100644
--- a/lib/hash/rte_hash.h
+++ b/lib/hash/rte_hash.h
@@ -279,6 +279,73 @@ int32_t
 rte_hash_add_key_with_hash_data(const struct rte_hash *h, const void *key,
 						hash_sig_t sig, void *data);
 
+/**
+ * Replace a key-value pair in an existing hash table, returning the previous
+ * data pointer associated with the key. If the key does not exist, it is
+ * inserted and *old_data is set to NULL.
+ *
+ * This operation is not multi-thread safe and should only be called from one
+ * thread by default. Thread safety can be enabled by setting flag during table
+ * creation.
+ *
+ * When old_data is provided, no automatic RCU deferred free is performed on
+ * overwrite; the caller takes ownership of the old pointer and is responsible
+ * for freeing it (e.g. via RCU).
+ *
+ * @param h
+ *   Hash table to add the key to.
+ * @param key
+ *   Key to add to the hash table.
+ * @param data
+ *   Data to add to the hash table.
+ * @param old_data
+ *   Output: on overwrite, set to the previous data pointer.
+ *   On fresh insert, set to NULL.
+ * @return
+ *   - 0 if added/replaced successfully
+ *   - -EINVAL if the parameters are invalid.
+ *   - -ENOSPC if there is no space in the hash for this key.
+ */
+__rte_experimental
+int
+rte_hash_replace_key_data(const struct rte_hash *h, const void *key,
+			  void *data, void **old_data);
+
+/**
+ * Replace a key-value pair with a pre-computed hash value in an existing hash
+ * table, returning the previous data pointer associated with the key. If the
+ * key does not exist, it is inserted and *old_data is set to NULL.
+ *
+ * This operation is not multi-thread safe and should only be called from one
+ * thread by default. Thread safety can be enabled by setting flag during table
+ * creation.
+ *
+ * When old_data is provided, no automatic RCU deferred free is performed on
+ * overwrite; the caller takes ownership of the old pointer and is responsible
+ * for freeing it (e.g. via RCU).
+ *
+ * @param h
+ *   Hash table to add the key to.
+ * @param key
+ *   Key to add to the hash table.
+ * @param sig
+ *   Precomputed hash value for 'key'
+ * @param data
+ *   Data to add to the hash table.
+ * @param old_data
+ *   Output: on overwrite, set to the previous data pointer.
+ *   On fresh insert, set to NULL.
+ * @return
+ *   - 0 if added/replaced successfully
+ *   - -EINVAL if the parameters are invalid.
+ *   - -ENOSPC if there is no space in the hash for this key.
+ */
+__rte_experimental
+int
+rte_hash_replace_key_with_hash_data(const struct rte_hash *h,
+				    const void *key, hash_sig_t sig,
+				    void *data, void **old_data);
+
 /**
  * Add a key to an existing hash table. This operation is not multi-thread safe
  * and should only be called from one thread by default.
-- 
2.53.0

