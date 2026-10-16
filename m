Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BB4CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D417840689;
	Fri, 16 Oct 2026 17:39:59 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id BEE2C40609
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:39:56 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2e9995ce866so4499255ad.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792165196;
 x=1792769996; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2cq6YLaFF5lndzMMl2gUQHuUZFvEtmaGAYKtPtNcO/I=;
 b=PqH9LTM4jW5H1S363S2ywMK8+8J8uA3kwnRIo8p2/NIZf041R/xXjCPq2jM+VFHt5J
 HaOfNuz9zfTROs4t+4J/k6c7vdF02i96HMUH+hlTiUtFItS6L2SfEAfuzartLbqzZNHt
 eCdIRkTzgoCtDHILDmOuneQpsxc2Kvl84YSQdjZwavYGGPZKqqvjADSw6zkhLZ9jpi5Q
 CrpRGLmZWnvYv52T893zP59jUtXs+/ye6E4udgSYsMh8wuJjiFy34+MHGB3zGX9BJqu6
 GMRr/SW6Z6EGQktZoy3bbcm8VBsIbsiZNxNuvCmypVafbVnavJB4wz+MxZmBN+QEJ0ZD
 2bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792165196; x=1792769996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2cq6YLaFF5lndzMMl2gUQHuUZFvEtmaGAYKtPtNcO/I=;
 b=yS17CPcA03+trirc4ygQgfKAvtI8evgEyxkWoH90gq6OVmnQfSUIy/jzbENcGNK7hI
 B9CnOa8hA2b/x6YXtWUoLYKAUseSdIy5NqvdEid2FwAGcG/bOnMKBJfZtP7CEBfcYfmX
 95XVlUM9Mxnv8l1tMmsmR6V4hObEFUcvcyhTgHvPdspo4zeHzPwEMqcOcyQMj3635eFW
 wcbcuccvTdHqOzhOEnNEebePUa8gR8Fbg3/NphSNLPW2RIDfJ0Yg+Evvzm/3QFZxRm7Q
 4HBNE1Jr+Tl4xBXplfYY66Egqi5ILa3BKzjokytJgujzxujQLIvax79QRwN5vGPZJnCv
 qHcg==
X-Gm-Message-State: AFq9FYJS45OSrrCdqFS+tek1umjJ5vW9N8ZOQg7QFJ3tVURmLfbPtuFl
 oQx7LBNeIHZgjea+TtxTQdDuUYQVJyt3ka1Y53viY496u83M/TW8IVhrGhPKg5pf/yspe7ZFwXH
 korcUYRQ=
X-Gm-Gg: AYBFou0h5aSq7KZMrShqE4DbubOdQwIUaRfIKOZllN+61rz3lFMuNmNyuTC7CxtwNTw
 /Uu37BBXwJT7a6QuMt/+Q/QpoivC8HKKxGxD5C3o6iQgI5jH1X3PAnm4BlwE/tdoMvHMdiNhpjA
 glnOCpdE5SFMIXqPMBGvyKZHZ7b8ni3EL6hydjz6VCy5YYz7u2BUXUpEB9xPGGzEL/L/22yQTKa
 e2cHX3vkklex0bWB3HhkyyZFYzGWFiKWGsndKSU+e50JOmq0awdnvnoTQdINb8dSQ/GJO/x2TIj
 nSZyUOQ2RCdiS1luVBsm/MGsblJTqrwnEiHC6jxy206V4i2Yvi2L3qtejjN5yZL6zg837C22AlM
 G5cdKv2SaqBps9Id0o8+7mfpueyYnVOEkNQIA/i2jmG8zvKld2vd0of8/A64WBEkh3de8Ue/w92
 /xHlHAZeNMbGAjRe5nJlgY+lUwQnAAkRCCoTNnocJhwHPQLXeoWq7Hj/uruxzKAMjK0sU3SsjDW
 mEIX9MwkhQC1BULknrgqmX7udxXYIvjU9Xc5A==
X-Received: by 2002:a17:902:d2cf:b0:2e9:66f6:7894 with SMTP id
 d9443c01a7336-2e9a6c0467emr3277755ad.40.1792165195782; 
 Fri, 16 Oct 2026 08:39:55 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804cf3sm12214445ad.25.2026.10.16.08.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:39:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 2/3] eal: increase memzone name size to 64
Date: Fri, 16 Oct 2026 08:38:44 -0700
Message-ID: <20261016153949.2965592-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016153949.2965592-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
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

Memzone names are limited to 31 characters, and ring, mempool and
stack names lose the length of their prefixes on top of that.
A mempool name is limited to 25 characters, which leaves little room
for libraries such as rib and fib that derive names from the name
given by the application.

Increase RTE_MEMZONE_NAMESIZE to 64. The derived ring, mempool,
stack and RCU defer queue sizes follow.

Reorder struct rte_ring and struct rte_mempool so the larger name
does not push datapath fields into another cache line.

For rte_ring, flags and the size fields come first, followed by the
memzone pointer and the name. The cache alignment moves from the
first field to the structure itself. struct rte_ring grows by one
cache line.

For rte_mempool the fields used in the datapath are gathered at the
start: pool_data/pool_id, local_cache, ops_index and cache_size.
The remaining fields, along with pool_config, mz and name, follow.
Previously local_cache and ops_index were in the second cache line.
struct rte_mempool stays 192 bytes.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 21 ++++++++++++++++++
 lib/eal/include/rte_memzone.h          |  2 +-
 lib/mempool/rte_mempool.h              | 30 ++++++++++++++------------
 lib/ring/rte_ring_core.h               |  9 ++++----
 4 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..0d9465c9e2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -567,6 +567,27 @@ ABI Changes
 * cryptodev: The struct ``rte_crypto_rsa_op_param``
   was updated to include ``pss_salt``.
 
+* **Increased memzone maximum name size.**
+
+  ``RTE_MEMZONE_NAMESIZE`` was increased from 32 to 64,
+  and the derived ``RTE_RING_NAMESIZE``, ``RTE_MEMPOOL_NAMESIZE``,
+  ``RTE_STACK_NAMESIZE`` and ``RTE_RCU_QSBR_DQ_NAMESIZE`` grew accordingly.
+  This impacts the following structures:
+
+  * ``struct rte_memzone`` grew by 32 bytes.
+
+  * ``struct rte_ring`` grew by one cache line,
+    and ``memzone`` and ``name`` were moved after the size fields
+    to keep the datapath fields in the first cache line.
+
+  * ``struct rte_mempool`` is unchanged in size,
+    but the fields were reordered so the datapath fields
+    (``pool_data``/``pool_id``, ``local_cache``, ``ops_index``
+    and ``cache_size``) come first,
+    and ``name``, ``pool_config`` and ``mz`` were moved after them.
+
+  * ``struct rte_stack`` grew by one cache line.
+
 
 Known Issues
 ------------
diff --git a/lib/eal/include/rte_memzone.h b/lib/eal/include/rte_memzone.h
index 5a0e1b8a15..d5c92fe0ec 100644
--- a/lib/eal/include/rte_memzone.h
+++ b/lib/eal/include/rte_memzone.h
@@ -47,7 +47,7 @@ extern "C" {
  */
 struct __rte_packed_begin rte_memzone {
 
-#define RTE_MEMZONE_NAMESIZE 32       /**< Maximum length of memory zone name.*/
+#define RTE_MEMZONE_NAMESIZE 64       /**< Maximum length of memory zone name.*/
 	char name[RTE_MEMZONE_NAMESIZE];  /**< Name of the memory zone. */
 
 	rte_iova_t iova;                  /**< Start IO address. */
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index b34cd893b1..1df8dbebf4 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -237,34 +237,36 @@ struct __rte_cache_aligned rte_mempool_info {
  * The RTE mempool structure.
  */
 struct __rte_cache_aligned rte_mempool {
-	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
 	union {
 		void *pool_data;         /**< Ring or pool to store objects. */
 		uint64_t pool_id;        /**< External mempool identifier. */
 	};
-	void *pool_config;               /**< optional args for ops alloc. */
-	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
+	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
+	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing into the local cache. */
+	/**
+	 * Index into rte_mempool_ops_table array of mempool ops
+	 * structs, which contain callback function pointers.
+	 * We're using an index here rather than pointers to the callbacks
+	 * to facilitate any secondary processes that may want to use
+	 * this mempool.
+	 */
+	int32_t ops_index;
+	uint32_t cache_size;
+	/**< Size of per-lcore default local cache. */
+
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
-	uint32_t cache_size;             /**< Size of per-lcore default local cache. */
 
 	uint32_t elt_size;               /**< Size of an element. */
 	uint32_t header_size;            /**< Size of header (before elt). */
 	uint32_t trailer_size;           /**< Size of trailer (after elt). */
 
 	unsigned private_data_size;      /**< Size of private data. */
-	/**
-	 * Index into rte_mempool_ops_table array of mempool ops
-	 * structs, which contain callback function pointers.
-	 * We're using an index here rather than pointers to the callbacks
-	 * to facilitate any secondary processes that may want to use
-	 * this mempool.
-	 */
-	int32_t ops_index;
 
-	struct rte_mempool_cache *local_cache; /**< Per-lcore local cache */
-	uint32_t sizeof_cache_per_lcore; /**< Multiplier for indexing into the local cache. */
+	void *pool_config;               /**< optional args for ops alloc. */
+	const struct rte_memzone *mz;    /**< Memzone where pool is alloc'd. */
+	char name[RTE_MEMPOOL_NAMESIZE]; /**< Name of mempool. */
 
 	uint32_t populated_size;         /**< Number of populated objects. */
 	struct rte_mempool_objhdr_list elt_list; /**< List of objects in pool */
diff --git a/lib/ring/rte_ring_core.h b/lib/ring/rte_ring_core.h
index 6cd6ce9884..5425cdcef2 100644
--- a/lib/ring/rte_ring_core.h
+++ b/lib/ring/rte_ring_core.h
@@ -113,15 +113,14 @@ struct rte_ring_hts_headtail {
  * values in a modulo-32bit base: that's why the overflow of the indexes is not
  * a problem.
  */
-struct rte_ring {
-	alignas(RTE_CACHE_LINE_SIZE) char name[RTE_RING_NAMESIZE];
-	/**< Name of the ring. */
+struct __rte_cache_aligned rte_ring {
 	int flags;               /**< Flags supplied at creation. */
-	const struct rte_memzone *memzone;
-			/**< Memzone, if any, containing the rte_ring */
 	uint32_t size;           /**< Size of ring. */
 	uint32_t mask;           /**< Mask (size-1) of ring. */
 	uint32_t capacity;       /**< Usable size of ring */
+	const struct rte_memzone *memzone;
+			/**< Memzone, if any, containing the rte_ring */
+	char name[RTE_RING_NAMESIZE]; /**< Name of the ring. */
 
 	RTE_CACHE_GUARD;
 
-- 
2.53.0

