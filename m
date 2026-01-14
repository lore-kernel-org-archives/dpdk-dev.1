Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D0D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5E7540B92;
	Wed, 14 Jan 2026 16:45:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5E0A340A77;
 Wed, 14 Jan 2026 16:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405513; x=1799941513;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WEChDA3kj/OwOxFgfMjWl7LjOLlCh+ufBwj7OsWE72M=;
 b=jFlRxcWu9+gK1D6ROt14AepdxPDT6qOA0fIK5yjTygCyWn3i78OXFlfJ
 vrW/4Ka3aBZMvkLZLtgEfiXrN3xYfqNbZE3ATthr4XXGn2hZ86Xc6MBRN
 tkX2kiW8kSws8hpOdm58aDv5k6y1A32V/gKqBHrRx6N8ITBKIb3yTELGE
 N+xgVg18rLdG8ltMk7fcO+hqhyGa0UOhFQy5tGvkg759Qy5OMsjWVVZsR
 focaZ51j8ZGhm0XBEbRZ9qp9aXQhwUrmlRFdRwn5bcG1G+vlzsrqdmT7R
 Z70lznDsOtULPmVwHJuq+Xu4eNc8IpPLfjr/0gc75B7lNSahs1A1zTjt7 g==;
X-CSE-ConnectionGUID: 8w8d5mDHTZOhsq7R7Suy+w==
X-CSE-MsgGUID: t1Z+LIONRPWoaS7SUn+T1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870821"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870821"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:13 -0800
X-CSE-ConnectionGUID: KwBILe9zQJmxboUtARP5Qg==
X-CSE-MsgGUID: LaA0T9NkRSugu5aK88gNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924981"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:10 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Ashwin Sekhar T K <asekhar@marvell.com>,
 Pablo de Lara <pablo.de.lara.guarch@intel.com>
Subject: [PATCH v4 07/31] table: fix issues with variable shadowing
Date: Wed, 14 Jan 2026 15:44:21 +0000
Message-ID: <20260114154450.2969716-8-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

Building table library with -Wshadow reveals many warnings from shadowed
variables. Fix these by removing definitions, or renaming variables as
appropriate.

Fixes: 0c06fa3bfa8c ("table: support learner tables")
Fixes: d0a00966618b ("table: add exact match SWX table")
Fixes: 1e29a162482c ("table: separate out x86-specific from LRU header")
Fixes: 8aa327214ceb ("table: hash")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/table/rte_lru.h               | 38 +++++++++++++++----------------
 lib/table/rte_lru_arm64.h         | 14 ++++++------
 lib/table/rte_lru_x86.h           |  4 ++--
 lib/table/rte_swx_table_em.c      |  2 --
 lib/table/rte_swx_table_learner.c |  4 ++--
 lib/table/rte_table_hash_key16.c  |  4 +---
 lib/table/rte_table_hash_key32.c  |  4 +---
 lib/table/rte_table_hash_key8.c   |  4 +---
 8 files changed, 33 insertions(+), 41 deletions(-)

diff --git a/lib/table/rte_lru.h b/lib/table/rte_lru.h
index 28aab12923..1436425e16 100644
--- a/lib/table/rte_lru.h
+++ b/lib/table/rte_lru.h
@@ -41,33 +41,33 @@ while (0)
 
 #define lru_update(bucket, mru_val)					\
 do {									\
-	uint64_t x, pos, x0, x1, x2, mask;				\
+	uint64_t _x, _pos, _x0, _x1, _x2, _mask;			\
 									\
-	x = bucket->lru_list;						\
+	_x = bucket->lru_list;						\
 									\
-	pos = 4;							\
-	if ((x >> 48) == ((uint64_t) mru_val))				\
-		pos = 3;						\
+	_pos = 4;							\
+	if ((_x >> 48) == ((uint64_t) mru_val))			\
+		_pos = 3;						\
 									\
-	if (((x >> 32) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
-		pos = 2;						\
+	if (((_x >> 32) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
+		_pos = 2;						\
 									\
-	if (((x >> 16) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
-		pos = 1;						\
+	if (((_x >> 16) & 0xFFFFLLU) == ((uint64_t) mru_val))		\
+		_pos = 1;						\
 									\
-	if ((x & 0xFFFFLLU) == ((uint64_t) mru_val))			\
-		pos = 0;						\
+	if ((_x & 0xFFFFLLU) == ((uint64_t) mru_val))			\
+		_pos = 0;						\
 									\
 									\
-	pos <<= 4;							\
-	mask = (~0LLU) << pos;						\
-	x0 = x & (~mask);						\
-	x1 = (x >> 16) & mask;						\
-	x2 = (x << (48 - pos)) & (0xFFFFLLU << 48);			\
-	x = x0 | x1 | x2;						\
+	_pos <<= 4;							\
+	_mask = (~0LLU) << _pos;					\
+	_x0 = _x & (~_mask);						\
+	_x1 = (_x >> 16) & _mask;					\
+	_x2 = (_x << (48 - _pos)) & (0xFFFFLLU << 48);			\
+	_x = _x0 | _x1 | _x2;						\
 									\
-	if (pos != 64)							\
-		bucket->lru_list = x;					\
+	if (_pos != 64)							\
+		bucket->lru_list = _x;					\
 } while (0)
 
 #elif (RTE_TABLE_HASH_LRU_STRATEGY == 2) || (RTE_TABLE_HASH_LRU_STRATEGY == 3)
diff --git a/lib/table/rte_lru_arm64.h b/lib/table/rte_lru_arm64.h
index f9a4678ee0..817b791b6e 100644
--- a/lib/table/rte_lru_arm64.h
+++ b/lib/table/rte_lru_arm64.h
@@ -40,16 +40,16 @@ f_lru_pos(uint64_t lru_list)
 
 #define lru_update(bucket, mru_val)					\
 do {									\
-	const uint64_t orvals[] = {0xFFFFLLU, 0xFFFFLLU << 16,		\
+	const uint64_t _orvals[] = {0xFFFFLLU, 0xFFFFLLU << 16,		\
 		0xFFFFLLU << 32, 0xFFFFLLU << 48, 0LLU};		\
-	const uint64_t decs[] = {0x1000100010001LLU, 0};		\
-	uint64x1_t lru = vdup_n_u64(bucket->lru_list);			\
-	uint64x1_t vdec = vdup_n_u64(decs[mru_val>>2]);			\
+	const uint64_t _decs[] = {0x1000100010001LLU, 0};		\
+	uint64x1_t _lru = vdup_n_u64(bucket->lru_list);			\
+	uint64x1_t _vdec = vdup_n_u64(_decs[mru_val>>2]);			\
 	bucket->lru_list = vget_lane_u64(vreinterpret_u64_u16(		\
-				vsub_u16(vreinterpret_u16_u64(lru),	\
-					vreinterpret_u16_u64(vdec))),	\
+				vsub_u16(vreinterpret_u16_u64(_lru),	\
+					vreinterpret_u16_u64(_vdec))),	\
 				0);					\
-	bucket->lru_list |= orvals[mru_val];				\
+	bucket->lru_list |= _orvals[mru_val];				\
 } while (0)
 
 #endif
diff --git a/lib/table/rte_lru_x86.h b/lib/table/rte_lru_x86.h
index 93f4a136a8..de74513653 100644
--- a/lib/table/rte_lru_x86.h
+++ b/lib/table/rte_lru_x86.h
@@ -50,9 +50,9 @@ do {									\
 	/* Find the minimum value (first zero word, if it's in there) */\
 	__m128i d = _mm_minpos_epu16(c);				\
 	/* Second word is the index to found word (first word is the value) */\
-	unsigned int pos = _mm_extract_epi16(d, 1);			\
+	unsigned int _pos = _mm_extract_epi16(d, 1);			\
 	/* move the recently used location to top of list */		\
-	__m128i k = _mm_shuffle_epi8(b, *((__m128i *) &masks[2 * pos]));\
+	__m128i k = _mm_shuffle_epi8(b, *((__m128i *) &masks[2 * _pos]));\
 	/* Finally, update the original list with the reordered data */	\
 	bucket->lru_list = _mm_extract_epi64(k, 0);			\
 	/* Phwew! */							\
diff --git a/lib/table/rte_swx_table_em.c b/lib/table/rte_swx_table_em.c
index 4ec54cb635..c408ea6fc3 100644
--- a/lib/table/rte_swx_table_em.c
+++ b/lib/table/rte_swx_table_em.c
@@ -621,8 +621,6 @@ table_create(struct rte_swx_table_params *params,
 		return t;
 
 	TAILQ_FOREACH(entry, entries, node) {
-		int status;
-
 		status = table_add(t, entry);
 		if (status) {
 			table_free(t);
diff --git a/lib/table/rte_swx_table_learner.c b/lib/table/rte_swx_table_learner.c
index 2d61bceeaf..3680bf26c1 100644
--- a/lib/table/rte_swx_table_learner.c
+++ b/lib/table/rte_swx_table_learner.c
@@ -411,13 +411,13 @@ rte_swx_table_learner_lookup(void *table,
 		for (i = 0; i < TABLE_KEYS_PER_BUCKET; i++) {
 			uint64_t time = b->time[i];
 			uint32_t sig = b->sig[i];
-			uint8_t *key = table_bucket_key_get(t, b, i);
+			uint8_t *k = table_bucket_key_get(t, b, i);
 
 			time <<= 32;
 
 			if ((time > input_time) &&
 			    (sig == m->input_sig) &&
-			    t->params.keycmp_func(key, m->input_key, t->params.key_size)) {
+			    t->params.keycmp_func(k, m->input_key, t->params.key_size)) {
 				uint64_t *data = table_bucket_data_get(t, b, i);
 
 				/* Hit. */
diff --git a/lib/table/rte_table_hash_key16.c b/lib/table/rte_table_hash_key16.c
index da24a7985d..5b69106dd7 100644
--- a/lib/table/rte_table_hash_key16.c
+++ b/lib/table/rte_table_hash_key16.c
@@ -1133,12 +1133,10 @@ rte_table_hash_lookup_key16_ext(
 		uint64_t buckets_mask_next = 0;
 
 		for ( ; buckets_mask; ) {
-			uint64_t pkt_mask;
 			uint32_t pkt_index;
 
 			pkt_index = rte_ctz64(buckets_mask);
-			pkt_mask = 1LLU << pkt_index;
-			buckets_mask &= ~pkt_mask;
+			buckets_mask &= ~(1LLU << pkt_index);
 
 			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
 				entries, buckets_mask_next, f);
diff --git a/lib/table/rte_table_hash_key32.c b/lib/table/rte_table_hash_key32.c
index 297931a2a5..0963f57828 100644
--- a/lib/table/rte_table_hash_key32.c
+++ b/lib/table/rte_table_hash_key32.c
@@ -1167,12 +1167,10 @@ rte_table_hash_lookup_key32_ext(
 		uint64_t buckets_mask_next = 0;
 
 		for ( ; buckets_mask; ) {
-			uint64_t pkt_mask;
 			uint32_t pkt_index;
 
 			pkt_index = rte_ctz64(buckets_mask);
-			pkt_mask = 1LLU << pkt_index;
-			buckets_mask &= ~pkt_mask;
+			buckets_mask &= ~(1LLU << pkt_index);
 
 			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
 				entries, buckets_mask_next, f);
diff --git a/lib/table/rte_table_hash_key8.c b/lib/table/rte_table_hash_key8.c
index 746863082f..5e9dcf10ee 100644
--- a/lib/table/rte_table_hash_key8.c
+++ b/lib/table/rte_table_hash_key8.c
@@ -1101,12 +1101,10 @@ rte_table_hash_lookup_key8_ext(
 		uint64_t buckets_mask_next = 0;
 
 		for ( ; buckets_mask; ) {
-			uint64_t pkt_mask;
 			uint32_t pkt_index;
 
 			pkt_index = rte_ctz64(buckets_mask);
-			pkt_mask = 1LLU << pkt_index;
-			buckets_mask &= ~pkt_mask;
+			buckets_mask &= ~(1LLU << pkt_index);
 
 			lookup_grinder(pkt_index, buckets, keys, pkts_mask_out,
 				entries, buckets_mask_next, f);
-- 
2.51.0

