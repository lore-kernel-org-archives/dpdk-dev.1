Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE65606A794
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MjDMXRNB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A047442708;
	Tue,  3 Nov 2026 15:55:50 +0100 (CET)
Received: from mta0.migadu.com (out-230.mta0.migadu.com [91.218.175.230])
 by mails.dpdk.org (Postfix) with ESMTPS id B57F74270A
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:48 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=yZNxyFcmRY2EIB9lIjsMO1xdFHVqA6wTZeEzBi8ojcQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717748; v=1; x=1794322548;
 b=MjDMXRNBcc3YRp0kNo5E8uqWBkHTLdHVEEYXp+XbZKCKQZp0EUqUBVEU6awIt3JFK28O2+X7
 XkLgemr1kd4h2SwNQZ4wa1p3XHUovhQ+EF+Zy28iAXzor7cbjwPoTpcIMIDGfZGfJjMJ0dgZDBk
 K5pdJeN4lrhVU3Iv9Fx0zrio=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id f307d7298c38dd0e;
 Tue, 03 Nov 2026 14:55:48 +0000
X-Mizu-Trace-ID: f307d7298c38dd0e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 017/227] fib: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:35 +0800
Message-ID: <20261103145306.487255-18-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test/test_fib6.c | 10 +++++-----
 lib/fib/dir24_8.c    | 14 +++++++-------
 lib/fib/dir24_8.h    |  2 +-
 lib/fib/rte_fib.c    | 14 +++++++-------
 lib/fib/rte_fib.h    |  6 +++---
 lib/fib/rte_fib6.c   | 14 +++++++-------
 lib/fib/rte_fib6.h   |  6 +++---
 lib/fib/trie.c       | 14 +++++++-------
 lib/fib/trie.h       |  2 +-
 9 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index cc120a01f7..d33226d016 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -955,7 +955,7 @@ test_tbl8_install_peak(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 1;
 
-	fib = rte_fib6_create("peak", SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("peak", RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	ret = rte_fib6_add(fib, &aligned, 33, 1);
@@ -1029,11 +1029,11 @@ test_tbl8_install_peak_dq(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 2;
 
-	fib = rte_fib6_create("peak_dq", SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create("peak_dq", RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	sz = rte_rcu_qsbr_get_memsize(1);
-	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(v != NULL, "Can not allocate RCU\n");
 	ret = rte_rcu_qsbr_init(v, 1);
 	RTE_TEST_ASSERT(ret == 0, "Can not init RCU\n");
@@ -1102,11 +1102,11 @@ test_tbl8_dq_modify(void)
 	config.trie.nh_sz = RTE_FIB6_TRIE_2B;
 	config.trie.num_tbl8 = 3;
 
-	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	fib = rte_fib6_create(__func__, RTE_NUMA_ID_ANY, &config);
 	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
 
 	sz = rte_rcu_qsbr_get_memsize(1);
-	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);
+	v = rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE, RTE_NUMA_ID_ANY);
 	RTE_TEST_ASSERT(v != NULL, "Can not allocate RCU\n");
 	ret = rte_rcu_qsbr_init(v, 1);
 	RTE_TEST_ASSERT(ret == 0, "Can not init RCU\n");
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index c135285a65..dfca06b3aa 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -556,7 +556,7 @@ dir24_8_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 }
 
 void *
-dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
+dir24_8_create(const char *name, int numa_id, struct rte_fib_conf *fib_conf)
 {
 	char mem_name[DIR24_8_NAMESIZE];
 	struct dir24_8_tbl *dp;
@@ -582,9 +582,9 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 			BITMAP_SLAB_BIT_SIZE);
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
-	dp = rte_zmalloc_socket(name, sizeof(struct dir24_8_tbl) +
+	dp = rte_zmalloc_numa(name, sizeof(struct dir24_8_tbl) +
 		DIR24_8_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
-		RTE_CACHE_LINE_SIZE, socket_id);
+		RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp == NULL) {
 		rte_errno = ENOMEM;
 		return NULL;
@@ -596,8 +596,8 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
 	uint64_t tbl8_sz = DIR24_8_TBL8_GRP_NUM_ENT * (1ULL << nh_sz) *
 			(num_tbl8 + 1);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, tbl8_sz,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	dp->tbl8 = rte_zmalloc_numa(mem_name, tbl8_sz,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp->tbl8 == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp);
@@ -608,9 +608,9 @@ dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *fib_conf)
 	dp->number_tbl8s = num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
-	dp->tbl8_idxes = rte_zmalloc_socket(mem_name,
+	dp->tbl8_idxes = rte_zmalloc_numa(mem_name,
 			RTE_ALIGN_CEIL(dp->number_tbl8s, 64) >> 3,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp->tbl8_idxes == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp->tbl8);
diff --git a/lib/fib/dir24_8.h b/lib/fib/dir24_8.h
index b343b5d686..ac2de1694d 100644
--- a/lib/fib/dir24_8.h
+++ b/lib/fib/dir24_8.h
@@ -287,7 +287,7 @@ DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_3)
 DECLARE_BE_LOOKUP_FN(dir24_8_lookup_bulk_uni)
 
 void *
-dir24_8_create(const char *name, int socket_id, struct rte_fib_conf *conf);
+dir24_8_create(const char *name, int numa_id, struct rte_fib_conf *conf);
 
 void
 dir24_8_free(void *p);
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..c6d6e28564 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -92,7 +92,7 @@ dummy_modify(struct rte_fib *fib, uint32_t ip, uint8_t depth,
 }
 
 static int
-init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
+init_dataplane(struct rte_fib *fib, __rte_unused int numa_id,
 	struct rte_fib_conf *conf)
 {
 	char dp_name[sizeof(void *)];
@@ -105,7 +105,7 @@ init_dataplane(struct rte_fib *fib, __rte_unused int socket_id,
 		fib->modify = dummy_modify;
 		return 0;
 	case RTE_FIB_DIR24_8:
-		fib->dp = dir24_8_create(dp_name, socket_id, conf);
+		fib->dp = dir24_8_create(dp_name, numa_id, conf);
 		if (fib->dp == NULL)
 			return -rte_errno;
 		fib->lookup = dir24_8_get_lookup_fn(fib->dp,
@@ -152,7 +152,7 @@ rte_fib_lookup_bulk(struct rte_fib *fib, uint32_t *ips,
 
 RTE_EXPORT_SYMBOL(rte_fib_create)
 struct rte_fib *
-rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
+rte_fib_create(const char *name, int numa_id, struct rte_fib_conf *conf)
 {
 	char mem_name[RTE_FIB_NAMESIZE];
 	int ret;
@@ -173,7 +173,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib_create(name, socket_id, &rib_conf);
+	rib = rte_rib_create(name, numa_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
 			"Can not allocate RIB %s", name);
@@ -207,8 +207,8 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	}
 
 	/* Allocate memory to store the FIB data structures. */
-	fib = rte_zmalloc_socket(mem_name,
-		sizeof(struct rte_fib),	RTE_CACHE_LINE_SIZE, socket_id);
+	fib = rte_zmalloc_numa(mem_name,
+		sizeof(struct rte_fib),	RTE_CACHE_LINE_SIZE, numa_id);
 	if (fib == NULL) {
 		FIB_LOG(ERR, "FIB %s memory allocation failed", name);
 		rte_errno = ENOMEM;
@@ -220,7 +220,7 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	fib->type = conf->type;
 	fib->flags = conf->flags;
 	fib->def_nh = conf->default_nh;
-	ret = init_dataplane(fib, socket_id, conf);
+	ret = init_dataplane(fib, numa_id, conf);
 	if (ret < 0) {
 		FIB_LOG(ERR,
 			"FIB dataplane struct %s memory allocation failed "
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535..35ce1f3c09 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -147,8 +147,8 @@ rte_fib_free(struct rte_fib *fib);
  *
  * @param name
  *  FIB name
- * @param socket_id
- *  NUMA socket ID for FIB table memory allocation
+ * @param numa_id
+ *  NUMA node ID for FIB table memory allocation
  * @param conf
  *  Structure containing the configuration
  * @return
@@ -156,7 +156,7 @@ rte_fib_free(struct rte_fib *fib);
  *  NULL otherwise with rte_errno set to an appropriate values.
  */
 struct rte_fib *
-rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
+rte_fib_create(const char *name, int numa_id, struct rte_fib_conf *conf)
 	__rte_malloc __rte_dealloc(rte_fib_free, 1);
 
 /**
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb61..5ba84d142c 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -91,7 +91,7 @@ dummy_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 }
 
 static int
-init_dataplane(struct rte_fib6 *fib, __rte_unused int socket_id,
+init_dataplane(struct rte_fib6 *fib, __rte_unused int numa_id,
 	struct rte_fib6_conf *conf)
 {
 	char dp_name[sizeof(void *)];
@@ -104,7 +104,7 @@ init_dataplane(struct rte_fib6 *fib, __rte_unused int socket_id,
 		fib->modify = dummy_modify;
 		return 0;
 	case RTE_FIB6_TRIE:
-		fib->dp = trie_create(dp_name, socket_id, conf);
+		fib->dp = trie_create(dp_name, numa_id, conf);
 		if (fib->dp == NULL)
 			return -rte_errno;
 		fib->lookup = trie_get_lookup_fn(fib->dp, RTE_FIB6_LOOKUP_DEFAULT);
@@ -152,7 +152,7 @@ rte_fib6_lookup_bulk(struct rte_fib6 *fib,
 
 RTE_EXPORT_SYMBOL(rte_fib6_create)
 struct rte_fib6 *
-rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
+rte_fib6_create(const char *name, int numa_id, struct rte_fib6_conf *conf)
 {
 	char mem_name[RTE_FIB6_NAMESIZE];
 	int ret;
@@ -172,7 +172,7 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib6_create(name, socket_id, &rib_conf);
+	rib = rte_rib6_create(name, numa_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
 			"Can not allocate RIB %s", name);
@@ -206,8 +206,8 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	}
 
 	/* Allocate memory to store the FIB data structures. */
-	fib = rte_zmalloc_socket(mem_name,
-		sizeof(struct rte_fib6), RTE_CACHE_LINE_SIZE, socket_id);
+	fib = rte_zmalloc_numa(mem_name,
+		sizeof(struct rte_fib6), RTE_CACHE_LINE_SIZE, numa_id);
 	if (fib == NULL) {
 		FIB_LOG(ERR, "FIB %s memory allocation failed", name);
 		rte_errno = ENOMEM;
@@ -218,7 +218,7 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	fib->rib = rib;
 	fib->type = conf->type;
 	fib->def_nh = conf->default_nh;
-	ret = init_dataplane(fib, socket_id, conf);
+	ret = init_dataplane(fib, numa_id, conf);
 	if (ret < 0) {
 		FIB_LOG(ERR,
 			"FIB dataplane struct %s memory allocation failed",
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index fcbd10de15..f8fb9b6597 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -129,8 +129,8 @@ rte_fib6_free(struct rte_fib6 *fib);
  *
  * @param name
  *  FIB name
- * @param socket_id
- *  NUMA socket ID for FIB table memory allocation
+ * @param numa_id
+ *  NUMA node ID for FIB table memory allocation
  * @param conf
  *  Structure containing the configuration
  * @return
@@ -138,7 +138,7 @@ rte_fib6_free(struct rte_fib6 *fib);
  *  NULL otherwise with rte_errno set to an appropriate values.
  */
 struct rte_fib6 *
-rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
+rte_fib6_create(const char *name, int numa_id, struct rte_fib6_conf *conf)
 	__rte_malloc __rte_dealloc(rte_fib6_free, 1);
 
 /**
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 9ede1a5bf7..58b0d5d472 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -683,7 +683,7 @@ trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 }
 
 void *
-trie_create(const char *name, int socket_id,
+trie_create(const char *name, int numa_id,
 	struct rte_fib6_conf *conf)
 {
 	char mem_name[TRIE_NAMESIZE];
@@ -710,9 +710,9 @@ trie_create(const char *name, int socket_id,
 	num_tbl8 = conf->trie.num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "DP_%s", name);
-	dp = rte_zmalloc_socket(name, sizeof(struct rte_trie_tbl) +
+	dp = rte_zmalloc_numa(name, sizeof(struct rte_trie_tbl) +
 		TRIE_TBL24_NUM_ENT * (1 << nh_sz) + sizeof(uint32_t),
-		RTE_CACHE_LINE_SIZE, socket_id);
+		RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp == NULL) {
 		rte_errno = ENOMEM;
 		return dp;
@@ -721,9 +721,9 @@ trie_create(const char *name, int socket_id,
 	write_to_dp(&dp->tbl24, (def_nh << 1), nh_sz, 1 << 24);
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_%p", dp);
-	dp->tbl8 = rte_zmalloc_socket(mem_name, TRIE_TBL8_GRP_NUM_ENT *
+	dp->tbl8 = rte_zmalloc_numa(mem_name, TRIE_TBL8_GRP_NUM_ENT *
 			(1ll << nh_sz) * (num_tbl8 + 1),
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp->tbl8 == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp);
@@ -734,9 +734,9 @@ trie_create(const char *name, int socket_id,
 	dp->number_tbl8s = num_tbl8;
 
 	snprintf(mem_name, sizeof(mem_name), "TBL8_idxes_%p", dp);
-	dp->tbl8_pool = rte_zmalloc_socket(mem_name,
+	dp->tbl8_pool = rte_zmalloc_numa(mem_name,
 			sizeof(uint32_t) * dp->number_tbl8s,
-			RTE_CACHE_LINE_SIZE, socket_id);
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (dp->tbl8_pool == NULL) {
 		rte_errno = ENOMEM;
 		rte_free(dp->tbl8);
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index c34cc2c057..e4a2677865 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -137,7 +137,7 @@ void
 trie_free(void *p);
 
 void *
-trie_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
+trie_create(const char *name, int numa_id, struct rte_fib6_conf *conf)
 	__rte_malloc __rte_dealloc(trie_free, 1);
 
 rte_fib6_lookup_fn_t
-- 
2.55.0

