Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8159C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2210427B4;
	Thu, 10 Sep 2026 12:36:27 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id E6DB842789
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C4959205D0;
 Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:21 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 4/6] mempool: various cleanups
Date: Thu, 10 Sep 2026 10:36:11 +0000
Message-ID: <20260910103613.808038-5-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:21.0505 (UTC)
 FILETIME=[388D4F10:01DD4110]
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

Removed audit call from dump function, where it doesn't belong.

Added malloc/dealloc attribute to private cache alloc/free functions.

Improved checks in mempool ops registration function.

Improved cache audit checks.

Added detailed description to definition of mempool name length.

Updated some comments, and moved around some misplaced comments.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 app/test/test_mempool.c       | 12 +++++-----
 lib/mempool/rte_mempool.c     | 20 ++++++++---------
 lib/mempool/rte_mempool.h     | 42 ++++++++++++++++++++++++-----------
 lib/mempool/rte_mempool_ops.c | 30 +++++++++++++++++++------
 4 files changed, 67 insertions(+), 37 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index e54249ce61..0bb051cb31 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -191,7 +191,7 @@ static int test_mempool_creation_with_exceeded_cache_size(void)
 {
 	struct rte_mempool *mp_cov;
 
-	mp_cov = rte_mempool_create("test_mempool_cache_too_big",
+	mp_cov = rte_mempool_create("test_cache_too_big",
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
 		RTE_MEMPOOL_CACHE_MAX_SIZE + 32, 0,
@@ -211,7 +211,7 @@ static int test_mempool_creation_with_invalid_flags(void)
 {
 	struct rte_mempool *mp_cov;
 
-	mp_cov = rte_mempool_create("test_mempool_invalid_flags", MEMPOOL_SIZE,
+	mp_cov = rte_mempool_create("test_invalid_flags", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
@@ -333,7 +333,7 @@ test_mempool_sp_sc(void)
 
 	/* create a mempool with single producer/consumer ring */
 	if (mp_spsc == NULL) {
-		mp_spsc = rte_mempool_create("test_mempool_sp_sc", MEMPOOL_SIZE,
+		mp_spsc = rte_mempool_create("test_sp_sc", MEMPOOL_SIZE,
 			MEMPOOL_ELT_SIZE, 0, 0,
 			my_mp_init, NULL,
 			my_obj_init, NULL,
@@ -343,7 +343,7 @@ test_mempool_sp_sc(void)
 		if (mp_spsc == NULL)
 			RET_ERR();
 	}
-	if (rte_mempool_lookup("test_mempool_sp_sc") != mp_spsc) {
+	if (rte_mempool_lookup("test_sp_sc") != mp_spsc) {
 		printf("Cannot lookup mempool from its name\n");
 		ret = -1;
 		goto err;
@@ -440,7 +440,7 @@ test_mempool_same_name_twice_creation(void)
 {
 	struct rte_mempool *mp_tc, *mp_tc2;
 
-	mp_tc = rte_mempool_create("test_mempool_same_name", MEMPOOL_SIZE,
+	mp_tc = rte_mempool_create("test_same_name", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
@@ -449,7 +449,7 @@ test_mempool_same_name_twice_creation(void)
 	if (mp_tc == NULL)
 		RET_ERR();
 
-	mp_tc2 = rte_mempool_create("test_mempool_same_name", MEMPOOL_SIZE,
+	mp_tc2 = rte_mempool_create("test_same_name", MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE, 0, 0,
 		NULL, NULL,
 		NULL, NULL,
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 03ecd01560..04766f55d6 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1193,6 +1193,7 @@ mempool_obj_audit(struct rte_mempool *mp, __rte_unused void *opaque,
 	RTE_MEMPOOL_CHECK_COOKIES(mp, &obj, 1, 2);
 }
 
+/* check cookies before and after objects */
 static void
 mempool_audit_cookies(struct rte_mempool *mp)
 {
@@ -1209,11 +1210,10 @@ mempool_audit_cookies(struct rte_mempool *mp)
 #define mempool_audit_cookies(mp) do {} while(0)
 #endif
 
-/* check cookies before and after objects */
+/* check cache size consistency */
 static void
 mempool_audit_cache(const struct rte_mempool *mp)
 {
-	/* check cache size consistency */
 	unsigned lcore_id;
 
 	if (mp->cache_size == 0)
@@ -1222,10 +1222,13 @@ mempool_audit_cache(const struct rte_mempool *mp)
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		const struct rte_mempool_cache *cache;
 		cache = &mp->local_cache[lcore_id];
-		if (cache->len > RTE_DIM(cache->objs)) {
-			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u]",
-				lcore_id);
-			rte_panic("MEMPOOL: invalid cache len\n");
+		if (cache->size > RTE_DIM(cache->objs)) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] size", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] size\n", lcore_id);
+		}
+		if (cache->len > cache->size) {
+			RTE_MEMPOOL_LOG(CRIT, "badness on cache[%u] len", lcore_id);
+			rte_panic("MEMPOOL: invalid cache[%u] len\n", lcore_id);
 		}
 	}
 }
@@ -1237,9 +1240,6 @@ rte_mempool_audit(struct rte_mempool *mp)
 {
 	mempool_audit_cache(mp);
 	mempool_audit_cookies(mp);
-
-	/* For case where mempool DEBUG is not set, and cache size is 0 */
-	RTE_SET_USED(mp);
 }
 
 /* dump the status of the mempool on the console */
@@ -1367,8 +1367,6 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 #else
 	fprintf(f, "  no statistics available\n");
 #endif
-
-	rte_mempool_audit(mp);
 }
 
 /* dump the status of all mempools on the console */
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 2fa70812d5..4cdbb3f778 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -120,7 +120,21 @@ struct rte_mempool_objsz {
 	/**< Total size of an object (header + elt + trailer). */
 };
 
-/**< Maximum length of a memory pool's name. */
+/**
+ * Maximum length of a memory pool's name.
+ *
+ * Note:
+ * Needs room for memzone prefix indicating "mempool" type:
+ * "MP_<name>"
+ * Furthermore, the mempool driver needs additional room for its own memzone prefix, e.g.:
+ * "RG_MP_<name>" (ring driver) or "STK_MP_<name>" (stack driver).
+ * In order to fail early on too long names, the length of the memzone name reserved
+ * by the default mempool driver (ring) is considered when creating the mempool.
+ * The length of the memzone name reserved by various other mempool drivers is
+ * not considered when creating the mempool.
+ * If the name eventually turns out to be too long for the chosen mempool driver,
+ * populating the mempool will fail.
+ */
 #define RTE_MEMPOOL_NAMESIZE (RTE_RING_NAMESIZE - \
 			      sizeof(RTE_MEMPOOL_MZ_PREFIX) + 1)
 #define RTE_MEMPOOL_MZ_PREFIX "MP_"
@@ -234,8 +248,7 @@ struct __rte_cache_aligned rte_mempool {
 	unsigned int flags;              /**< Flags of the mempool. */
 	int socket_id;                   /**< Socket id passed at create. */
 	uint32_t size;                   /**< Max size of the mempool. */
-	uint32_t cache_size;
-	/**< Size of per-lcore default local cache. */
+	uint32_t cache_size;             /**< Size of per-lcore default local cache. */
 
 	uint32_t elt_size;               /**< Size of an element. */
 	uint32_t header_size;            /**< Size of header (before elt). */
@@ -973,6 +986,8 @@ rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
  *   - >=0: Success; return the index of the ops struct in the table.
  *   - -EINVAL - some missing callbacks while registering ops struct.
  *   - -ENOSPC - the maximum number of ops structs has been reached.
+ *   - -ENAMETOOLONG - the name of the ops is too long.
+ *   - -EEXIST - the name of the ops is already registered.
  */
 int rte_mempool_register_ops(const struct rte_mempool_ops *ops);
 
@@ -1322,6 +1337,15 @@ void rte_mempool_stats_reset(struct rte_mempool *mp);
  */
 void rte_mempool_dump(FILE *f, struct rte_mempool *mp);
 
+/**
+ * Free a user-owned mempool cache.
+ *
+ * @param cache
+ *   A pointer to the mempool cache.
+ */
+void
+rte_mempool_cache_free(struct rte_mempool_cache *cache);
+
 /**
  * Create a user-owned mempool cache.
  *
@@ -1337,16 +1361,8 @@ void rte_mempool_dump(FILE *f, struct rte_mempool *mp);
  *   SOCKET_ID_ANY if there is no NUMA constraint for the reserved zone.
  */
 struct rte_mempool_cache *
-rte_mempool_cache_create(uint32_t size, int socket_id);
-
-/**
- * Free a user-owned mempool cache.
- *
- * @param cache
- *   A pointer to the mempool cache.
- */
-void
-rte_mempool_cache_free(struct rte_mempool_cache *cache);
+rte_mempool_cache_create(uint32_t size, int socket_id)
+	__rte_malloc __rte_dealloc(rte_mempool_cache_free, 1);
 
 /**
  * Get a pointer to the per-lcore default mempool cache.
diff --git a/lib/mempool/rte_mempool_ops.c b/lib/mempool/rte_mempool_ops.c
index 066bec36fc..6d99c7a25c 100644
--- a/lib/mempool/rte_mempool_ops.c
+++ b/lib/mempool/rte_mempool_ops.c
@@ -27,7 +27,7 @@ int
 rte_mempool_register_ops(const struct rte_mempool_ops *h)
 {
 	struct rte_mempool_ops *ops;
-	int16_t ops_index;
+	unsigned int ops_index;
 
 	rte_spinlock_lock(&rte_mempool_ops_table.sl);
 
@@ -47,12 +47,22 @@ rte_mempool_register_ops(const struct rte_mempool_ops *h)
 		return -EINVAL;
 	}
 
-	if (strlen(h->name) >= sizeof(ops->name) - 1) {
+	if (strnlen(h->name, sizeof(h->name)) > sizeof(ops->name) - 1) {
 		rte_spinlock_unlock(&rte_mempool_ops_table.sl);
-		RTE_MEMPOOL_LOG(DEBUG, "%s(): mempool_ops <%s>: name too long",
-				__func__, h->name);
-		rte_errno = EEXIST;
-		return -EEXIST;
+		char name[sizeof(h->name) + 1];
+		strlcpy(name, h->name, sizeof(name));
+		RTE_MEMPOOL_LOG(ERR, "%s(): mempool_ops <%s>: name too long",
+				__func__, name);
+		return -ENAMETOOLONG;
+	}
+
+	for (ops_index = 0; ops_index < rte_mempool_ops_table.num_ops; ops_index++) {
+		if (!strcmp(h->name, rte_mempool_ops_table.ops[ops_index].name)) {
+			rte_spinlock_unlock(&rte_mempool_ops_table.sl);
+			RTE_MEMPOOL_LOG(ERR, "%s(): mempool_ops <%s>: name exists",
+					__func__, h->name);
+			return -EEXIST;
+		}
 	}
 
 	ops_index = rte_mempool_ops_table.num_ops++;
@@ -70,6 +80,8 @@ rte_mempool_register_ops(const struct rte_mempool_ops *h)
 
 	rte_spinlock_unlock(&rte_mempool_ops_table.sl);
 
+	RTE_MEMPOOL_LOG(DEBUG, "Registered mempool ops <%s> at index %u", ops->name, ops_index);
+
 	return ops_index;
 }
 
@@ -185,8 +197,12 @@ rte_mempool_set_ops_byname(struct rte_mempool *mp, const char *name,
 		}
 	}
 
-	if (ops == NULL)
+	if (ops == NULL) {
+		RTE_MEMPOOL_LOG(DEBUG,
+				"Cannot set unknown mempool ops <%s>, of %u ops registered",
+				name, i);
 		return -EINVAL;
+	}
 
 	mp->ops_index = i;
 	mp->pool_config = pool_config;
-- 
2.43.0

