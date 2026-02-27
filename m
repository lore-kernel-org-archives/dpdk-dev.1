Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C234FEFB47
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 13:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44C0A402C5;
	Fri, 27 Feb 2026 14:02:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 64A0C4027F;
 Fri, 27 Feb 2026 14:02:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772197372; x=1803733372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fMUYHttHMbsc9rEf9KBimCHrJKRdeICURnF3InO+YqU=;
 b=PObjeY42nN8aGjHDLUaLkSun0rsYGywtlMsg/5bXbL32EYligowV/V1q
 NwobwfVHyyhXXsQW6ISbjk6GBcQUXKOIcQbnrCHr25aX8IQk0IX4qIyQp
 9kOKJ3I2uK5dV+Ze1l4W103qB+iJDOo7uTtVyvQ7umls2KuqG/bAEMqw3
 t+DO4di6CTo4q7DnVPCjIEhDbR5MkkkLHVvB2brycsVyT/GE5GXSJke8j
 HrYY81/ajG6YZW809xFbC0XYVTrNhc+DAhm5RdcB9740hL/Z4lr3ITUBK
 /5tlqVM8nndw9hUi0NHS+F8P+BCC8DZDV+1PBU6KDJ1Am9lzxbK0joM8/ g==;
X-CSE-ConnectionGUID: s53o63s4T02i66BVmyWPJg==
X-CSE-MsgGUID: TImBaQgHSOSOHfDbgsw0mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="77142987"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="77142987"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 05:02:51 -0800
X-CSE-ConnectionGUID: 0vBXtzgpSi6NSxQdFfl2/A==
X-CSE-MsgGUID: RtPulqJ3QL63n02IyzBHyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="214318542"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 27 Feb 2026 05:02:50 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3] hash: fix overflow of 32-bit offsets
Date: Fri, 27 Feb 2026 13:01:27 +0000
Message-ID: <20260227130245.194400-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220143933.2553112-1-bruce.richardson@intel.com>
References: <20260220143933.2553112-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When computing the offset inside the overall hash structure by adding an
offset to a base pointer, the offset was generally calculated by
multiplying two 32-bit values, which could then overflow. Prevent
overflow by using (size_t) casts on the elements being multiplied to
ensure they are 64-bit on 64-bit systems.

Fixes: b26473ff8f4a ("hash: add reset function")
Fixes: 406da3dfb3b5 ("hash: move duplicated code into functions")
Fixes: 9eca8bd7a61c ("hash: separate lock-free and r/w lock lookup")
Fixes: 4d9ca3ed2133 ("hash: use ordered loads only if signature matches")
Fixes: 769b2de7fb52 ("hash: implement RCU resources reclamation")
Fixes: e605a1d36ca7 ("hash: add lock-free r/w concurrency")
Fixes: 6dc34e0afe7a ("hash: retrieve a key given its position")
Fixes: f9edbc9bb6bc ("hash: add iterate function")
Fixes: 75706568a7eb ("hash: add extendable bucket feature")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
V3:
* rebase on latest main and resubmit now that some CI issues have
   been(independently) fixed

V2:
* use size_t rather than uintptr_t
* consistently apply size_t cast to the key_entry_size value rather
  than the position one.
---
 lib/hash/rte_cuckoo_hash.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index da12825c6e..3f382dd117 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -705,7 +705,7 @@ rte_hash_reset(struct rte_hash *h)
 	}
 
 	memset(h->buckets, 0, h->num_buckets * sizeof(struct rte_hash_bucket));
-	memset(h->key_store, 0, h->key_entry_size * (h->entries + 1));
+	memset(h->key_store, 0, (size_t)h->key_entry_size * (h->entries + 1));
 	*h->tbl_chng_cnt = 0;
 
 	/* reset the free ring */
@@ -774,7 +774,7 @@ search_and_update(const struct rte_hash *h, void *data, const void *key,
 	for (i = 0; i < RTE_HASH_BUCKET_ENTRIES; i++) {
 		if (bkt->sig_current[i] == sig) {
 			k = (struct rte_hash_key *) ((char *)keys +
-					bkt->key_idx[i] * h->key_entry_size);
+					bkt->key_idx[i] * (size_t)h->key_entry_size);
 			if (rte_hash_cmp_eq(key, k->key, h) == 0) {
 				/* The store to application data at *data
 				 * should not leak after the store to pdata
@@ -1140,7 +1140,7 @@ __rte_hash_add_key_with_hash(const struct rte_hash *h, const void *key,
 			return -ENOSPC;
 	}
 
-	new_k = RTE_PTR_ADD(keys, slot_id * h->key_entry_size);
+	new_k = RTE_PTR_ADD(keys, slot_id * (size_t)h->key_entry_size);
 	/* The store to application data (by the application) at *data should
 	 * not leak after the store of pdata in the key store. i.e. pdata is
 	 * the guard variable. Release the application data to the readers.
@@ -1329,7 +1329,7 @@ search_one_bucket_l(const struct rte_hash *h, const void *key,
 		if (bkt->sig_current[i] == sig &&
 				bkt->key_idx[i] != EMPTY_SLOT) {
 			k = (struct rte_hash_key *) ((char *)keys +
-					bkt->key_idx[i] * h->key_entry_size);
+					bkt->key_idx[i] * (size_t)h->key_entry_size);
 
 			if (rte_hash_cmp_eq(key, k->key, h) == 0) {
 				if (data != NULL)
@@ -1367,7 +1367,7 @@ search_one_bucket_lf(const struct rte_hash *h, const void *key, uint16_t sig,
 					  rte_memory_order_acquire);
 			if (key_idx != EMPTY_SLOT) {
 				k = (struct rte_hash_key *) ((char *)keys +
-						key_idx * h->key_entry_size);
+						key_idx * (size_t)h->key_entry_size);
 
 				if (rte_hash_cmp_eq(key, k->key, h) == 0) {
 					if (data != NULL) {
@@ -1569,7 +1569,7 @@ __hash_rcu_qsbr_free_resource(void *p, void *e, unsigned int n)
 	keys = h->key_store;
 
 	k = (struct rte_hash_key *) ((char *)keys +
-				rcu_dq_entry.key_idx * h->key_entry_size);
+				rcu_dq_entry.key_idx * (size_t)h->key_entry_size);
 	key_data = k->pdata;
 	if (h->hash_rcu_cfg->free_key_data_func)
 		h->hash_rcu_cfg->free_key_data_func(h->hash_rcu_cfg->key_data_ptr,
@@ -1757,7 +1757,7 @@ search_and_remove(const struct rte_hash *h, const void *key,
 					  rte_memory_order_acquire);
 		if (bkt->sig_current[i] == sig && key_idx != EMPTY_SLOT) {
 			k = (struct rte_hash_key *) ((char *)keys +
-					key_idx * h->key_entry_size);
+					key_idx * (size_t)h->key_entry_size);
 			if (rte_hash_cmp_eq(key, k->key, h) == 0) {
 				bkt->sig_current[i] = NULL_SIGNATURE;
 				/* Free the key store index if
@@ -1912,8 +1912,7 @@ rte_hash_get_key_with_position(const struct rte_hash *h, const int32_t position,
 	RETURN_IF_TRUE(((h == NULL) || (key == NULL)), -EINVAL);
 
 	struct rte_hash_key *k, *keys = h->key_store;
-	k = (struct rte_hash_key *) ((char *) keys + (position + 1) *
-				     h->key_entry_size);
+	k = (struct rte_hash_key *) ((char *) keys + (position + 1) * (size_t)h->key_entry_size);
 	*key = k->key;
 
 	if (position !=
@@ -2007,7 +2006,7 @@ __bulk_lookup_l(const struct rte_hash *h, const void **keys,
 			const struct rte_hash_key *key_slot =
 				(const struct rte_hash_key *)(
 				(const char *)h->key_store +
-				key_idx * h->key_entry_size);
+				key_idx * (size_t)h->key_entry_size);
 			rte_prefetch0(key_slot);
 			continue;
 		}
@@ -2021,7 +2020,7 @@ __bulk_lookup_l(const struct rte_hash *h, const void **keys,
 			const struct rte_hash_key *key_slot =
 				(const struct rte_hash_key *)(
 				(const char *)h->key_store +
-				key_idx * h->key_entry_size);
+				key_idx * (size_t)h->key_entry_size);
 			rte_prefetch0(key_slot);
 		}
 	}
@@ -2046,7 +2045,7 @@ __bulk_lookup_l(const struct rte_hash *h, const void **keys,
 			const struct rte_hash_key *key_slot =
 				(const struct rte_hash_key *)(
 				(const char *)h->key_store +
-				key_idx * h->key_entry_size);
+				key_idx * (size_t)h->key_entry_size);
 
 			/*
 			 * If key index is 0, do not compare key,
@@ -2074,7 +2073,7 @@ __bulk_lookup_l(const struct rte_hash *h, const void **keys,
 			const struct rte_hash_key *key_slot =
 				(const struct rte_hash_key *)(
 				(const char *)h->key_store +
-				key_idx * h->key_entry_size);
+				key_idx * (size_t)h->key_entry_size);
 
 			/*
 			 * If key index is 0, do not compare key,
@@ -2193,7 +2192,7 @@ __bulk_lookup_lf(const struct rte_hash *h, const void **keys,
 				const struct rte_hash_key *key_slot =
 					(const struct rte_hash_key *)(
 					(const char *)h->key_store +
-					key_idx * h->key_entry_size);
+					key_idx * (size_t)h->key_entry_size);
 				rte_prefetch0(key_slot);
 				continue;
 			}
@@ -2207,7 +2206,7 @@ __bulk_lookup_lf(const struct rte_hash *h, const void **keys,
 				const struct rte_hash_key *key_slot =
 					(const struct rte_hash_key *)(
 					(const char *)h->key_store +
-					key_idx * h->key_entry_size);
+					key_idx * (size_t)h->key_entry_size);
 				rte_prefetch0(key_slot);
 			}
 		}
@@ -2233,7 +2232,7 @@ __bulk_lookup_lf(const struct rte_hash *h, const void **keys,
 				const struct rte_hash_key *key_slot =
 					(const struct rte_hash_key *)(
 					(const char *)h->key_store +
-					key_idx * h->key_entry_size);
+					key_idx * (size_t)h->key_entry_size);
 
 				/*
 				 * If key index is 0, do not compare key,
@@ -2265,7 +2264,7 @@ __bulk_lookup_lf(const struct rte_hash *h, const void **keys,
 				const struct rte_hash_key *key_slot =
 					(const struct rte_hash_key *)(
 					(const char *)h->key_store +
-					key_idx * h->key_entry_size);
+					key_idx * (size_t)h->key_entry_size);
 
 				/*
 				 * If key index is 0, do not compare key,
@@ -2621,7 +2620,7 @@ rte_hash_iterate(const struct rte_hash *h, const void **key, void **data, uint32
 
 	__hash_rw_reader_lock(h);
 	next_key = (struct rte_hash_key *) ((char *)h->key_store +
-				position * h->key_entry_size);
+				position * (size_t)h->key_entry_size);
 	/* Return key and data */
 	*key = next_key->key;
 	*data = next_key->pdata;
@@ -2652,7 +2651,7 @@ rte_hash_iterate(const struct rte_hash *h, const void **key, void **data, uint32
 	}
 	__hash_rw_reader_lock(h);
 	next_key = (struct rte_hash_key *) ((char *)h->key_store +
-				position * h->key_entry_size);
+				position * (size_t)h->key_entry_size);
 	/* Return key and data */
 	*key = next_key->key;
 	*data = next_key->pdata;
-- 
2.51.0

