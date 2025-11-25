Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA24CFD379
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 09:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6571540A67;
	Tue, 25 Nov 2025 10:41:25 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 5A857402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 10:41:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764063681;
 bh=NFzc8vSvdWegLOQjlvqHJNBUPEyo1m5iGvDZYRgVKSc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=ZKtGlpus9JDBIsEy7zsjCwli+FlUUUsuINTexkwnsgW5oFXgOCNYY1ejtfZnHzN/I
 Is4e31XRDUbYux1i2RHqQT0La+22SmXujtf2ZzOEHn3ET39YhU4aL/sLdP917atrUg
 6yEiFVR9bPmbo93BKQ7j3A8GVfgI0nQ/SFnQf3EA=
X-QQ-mid: zesmtpsz2t1764063678t51978eda
X-QQ-Originating-IP: objqSSLvT2rCxTiGdm6SxmAdSrorxA0GAadFeHwQkHI=
Received: from wyfs.. ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 25 Nov 2025 17:41:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 437109620073178040
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	YongFeng Wang <mannywang@tencent.com>
Subject: [PATCH] acl: support custom memory allocator
Date: Tue, 25 Nov 2025 09:40:43 +0000
Message-ID: <A4D81139F2372B04+20251125094044.39320-1-mannywang@tencent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NU60Kbs86PFjDNdK5BklbE85u450OM9NvV30pu23qCYOzlYdIj/PFFYo
 /9XbR6RH2r9m1bC5rz0mOVvHOpKRkZuhLpVtIfElZ9zwt+p4soG3nPToqAHEuTYIpg0Nuav
 DNPWP2l8YDXCcp/vObrfJGh+5EZcWeVSoYMT70IWATlmon0OgQCS0j9N+/dfiNZq46VCFBu
 EhAcLO6pgyfIJeQC7RKLawoS+z4VaZcxQu2FrBn7g8TlHQBez7KkUtC621Ztha2qtmVicWd
 rYESgrWTpI4BdS0LdePLCI9/MRZqlO7PoxqtM2nXAfRxKw4HJ/Nj+uD9S/11Z8lHzlbMelb
 T8uBiPpUmFcYTydiWRiu4vcBTKv5MH3txnh0ef76M+TaFviDaiPUgG1kV9PFMVcCRPg0c1B
 dRLAxb/dBjLH0dNky4DoBtzW60IpK6HajGiC/Ucnj5cO5aHaFL06XzysEO9bftded1EB65p
 f0B5YTYIfHgHEWYmpw2yC0sQMDhK875RMKehSgDO7KVqOWzq2lrAFq831a9WoFlFGYZvSis
 SZTE8DsWdoeo+CBwsuFRZvasNBcY4q6zQFhE6PwXm5X3uzEqVG4BZ0jAJC9B9cNhZPrtaO+
 EEarm1nB3F6XP9P5tw+5TwlN/tewWBkcgIRll634Qm9DGwuL6XrkOt0zq+heq55h9PnbSsB
 I/qQ/Dfmd5BKX9rbgVbxrGz05b0cq8fRYBsR0j13vb4LpMIdzKszEPsFSD4dtF8DYD8kXES
 Smcq+WyjcTaRx+jmE+3adGJM45R+M4fAsy2K1z+D5JMJWBLoXGFoagtpAZJyXhwRTtwJG3D
 LSAKbtWtzi3gaxZvTFVnpP6tBVQA5hDt0yhzsCK98znpBn5w8Y5mFkIyoPAvjtHQGzt/wc0
 72SsIBVnBUXCIQau/fpi8opFqR29BXXq6CAm4+vXZr5hwu1Th0FvcEo6yRTwSVIK0kXlb1G
 tuDkArGeV6BegTtj8ittc0meJsO7e05NWp5Z0/NSR8iznu+D89R7ibYMy2H1uUoy1iGo1E/
 3dv6TlLw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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

Reduce memory fragmentation caused by dynamic memory allocations
by allowing users to provide custom memory allocator.

Add new members to struct rte_acl_config to allow passing custom
allocator callbacks to rte_acl_build:

- running_alloc: allocator callback for run-time internal memory
- running_free: free callback for run-time internal memory
- running_ctx: user-defined context passed to running_alloc/free

- temp_alloc: allocator callback for temporary memory during ACL build
- temp_reset: reset callback for temporary allocator
- temp_ctx: user-defined context passed to temp_alloc/reset

These callbacks allow users to provide their own memory pools or
allocators for both persistent runtime structures and temporary
build-time data.

A typical approach is to pre-allocate a static memory region
for rte_acl_ctx, and to provide a global temporary memory manager
that supports multipleallocations and a single reset during ACL build.

Since tb_mem_pool handles allocation failures using siglongjmp,
temp_alloc follows the same approach for failure handling.

Signed-off-by: YongFeng Wang <mannywang@tencent.com>
---
 app/test/test_acl.c | 181 +++++++++++++++++++++++++++++++++++++++++++-
 lib/acl/acl.h       |   3 +-
 lib/acl/acl_bld.c   |  14 +++-
 lib/acl/acl_gen.c   |   8 +-
 lib/acl/rte_acl.c   |   5 +-
 lib/acl/rte_acl.h   |  20 +++++
 lib/acl/tb_mem.c    |   8 ++
 lib/acl/tb_mem.h    |   6 ++
 8 files changed, 236 insertions(+), 9 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..0f20967df2 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1721,6 +1721,184 @@ test_u32_range(void)
 	return rc;
 }
 
+struct acl_ctx_wrapper_t {
+	struct rte_acl_ctx *ctx;
+	void *running_buf;
+	bool running_buf_using;
+};
+
+struct acl_temp_mem_mgr_t {
+	void *buf;
+	uint32_t buf_used;
+	sigjmp_buf fail;
+};
+
+struct acl_ctx_wrapper_t g_acl_ctx_wrapper;
+struct acl_temp_mem_mgr_t g_temp_mem_mgr;
+
+#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
+#define ACL_TEMP_BUF_SIZE (10 * 1024 * 1024)
+
+static void *running_alloc(size_t size, unsigned int align, void *cb_data)
+{
+	(void)align;
+	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)cb_data;
+	if (gwlb_acl_ctx->running_buf_using)
+		return NULL;
+	printf("running memory alloc for acl context, size=%" PRId64 ", pointer=%p\n",
+		size,
+		gwlb_acl_ctx->running_buf);
+	gwlb_acl_ctx->running_buf_using = true;
+	return gwlb_acl_ctx->running_buf;
+}
+
+static void running_free(void *buf, void *cb_data)
+{
+	if (!buf)
+		return;
+	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)cb_data;
+	printf("running memory free pointer=%p\n", buf);
+	gwlb_acl_ctx->running_buf_using = false;
+}
+
+static void *temp_alloc(size_t size, sigjmp_buf fail, void *cb_data)
+{
+	struct acl_temp_mem_mgr_t *gwlb_acl_build = (struct acl_temp_mem_mgr_t *)cb_data;
+	if (ACL_TEMP_BUF_SIZE - gwlb_acl_build->buf_used < size) {
+		printf("Line %i: alloc temp memory fail, size=%" PRId64 ", used=%d\n",
+			__LINE__,
+			size,
+			gwlb_acl_build->buf_used);
+		siglongjmp(fail, -ENOMEM);
+		return NULL;
+	}
+	void *ret = (char *)gwlb_acl_build->buf + gwlb_acl_build->buf_used;
+	gwlb_acl_build->buf_used += size;
+	return ret;
+}
+
+static void temp_reset(void *cb_data)
+{
+	struct acl_temp_mem_mgr_t *gwlb_acl_build = (struct acl_temp_mem_mgr_t *)cb_data;
+	memset(gwlb_acl_build->buf, 0, ACL_TEMP_BUF_SIZE);
+	printf("temp memory reset, used total=%d\n", gwlb_acl_build->buf_used);
+	gwlb_acl_build->buf_used = 0;
+}
+
+static int
+rte_acl_ipv4vlan_build_wich_mem_cb(struct rte_acl_ctx *ctx,
+	const uint32_t layout[RTE_ACL_IPV4VLAN_NUM],
+	uint32_t num_categories)
+{
+	struct rte_acl_config cfg;
+
+	if (ctx == NULL || layout == NULL)
+		return -EINVAL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	acl_ipv4vlan_config(&cfg, layout, num_categories);
+	cfg.running_alloc = running_alloc;
+	cfg.running_free = running_free;
+	cfg.running_cb_ctx = &g_acl_ctx_wrapper;
+	cfg.temp_alloc = temp_alloc;
+	cfg.temp_reset = temp_reset;
+	cfg.temp_cb_ctx = &g_temp_mem_mgr;
+	return rte_acl_build(ctx, &cfg);
+}
+
+static int
+test_classify_buid_wich_mem_cb(struct rte_acl_ctx *acx,
+	const struct rte_acl_ipv4vlan_rule *rules, uint32_t num)
+{
+	int ret;
+
+	/* add rules to the context */
+	ret = rte_acl_ipv4vlan_add_rules(acx, rules, num);
+	if (ret != 0) {
+		printf("Line %i: Adding rules to ACL context failed!\n",
+			__LINE__);
+		return ret;
+	}
+
+	/* try building the context */
+	ret = rte_acl_ipv4vlan_build_wich_mem_cb(acx, ipv4_7tuple_layout,
+		RTE_ACL_MAX_CATEGORIES);
+	if (ret != 0) {
+		printf("Line %i: Building ACL context failed!\n", __LINE__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+test_mem_cb(void)
+{
+	int i, ret;
+	g_acl_ctx_wrapper.ctx = rte_acl_create(&acl_param);
+	if (g_acl_ctx_wrapper.ctx == NULL) {
+		printf("Line %i: Error creating ACL context!\n", __LINE__);
+		return -1;
+	}
+	g_acl_ctx_wrapper.running_buf = rte_zmalloc_socket(
+		"test_acl",
+		ACL_RUNNING_BUF_SIZE,
+		RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	if (!g_acl_ctx_wrapper.running_buf) {
+		printf("Line %i: Error allocing running buf for acl context!\n", __LINE__);
+		return 1;
+	}
+	g_acl_ctx_wrapper.running_buf_using = false;
+
+	g_temp_mem_mgr.buf = malloc(ACL_TEMP_BUF_SIZE);
+	if (!g_temp_mem_mgr.buf)
+		printf("Line %i: Error allocing teem buf for acl build!\n", __LINE__);
+	memset(g_temp_mem_mgr.buf, 0, ACL_TEMP_BUF_SIZE);
+	g_temp_mem_mgr.buf_used = 0;
+
+	ret = 0;
+	for (i = 0; i != TEST_CLASSIFY_ITER; i++) {
+
+		if ((i & 1) == 0)
+			rte_acl_reset(g_acl_ctx_wrapper.ctx);
+		else
+			rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
+
+		ret = test_classify_buid_wich_mem_cb(g_acl_ctx_wrapper.ctx, acl_test_rules,
+			RTE_DIM(acl_test_rules));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: "
+				"Adding rules to ACL context failed!\n",
+				__LINE__, i);
+			break;
+		}
+
+		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+
+		/* reset rules and make sure that classify still works ok. */
+		rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
+		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+	}
+
+	rte_acl_free(g_acl_ctx_wrapper.ctx);
+	free(g_temp_mem_mgr.buf);
+	rte_free(g_acl_ctx_wrapper.running_buf);
+	return ret;
+}
+
 static int
 test_acl(void)
 {
@@ -1742,7 +1920,8 @@ test_acl(void)
 		return -1;
 	if (test_u32_range() < 0)
 		return -1;
-
+	if (test_mem_cb() < 0)
+		return -1;
 	return 0;
 }
 
diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index c8e4e72fab..7080fff64d 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -189,7 +189,8 @@ struct rte_acl_ctx {
 
 int rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 	struct rte_acl_bld_trie *node_bld_trie, uint32_t num_tries,
-	uint32_t num_categories, uint32_t data_index_sz, size_t max_size);
+	uint32_t num_categories, uint32_t data_index_sz, size_t max_size,
+	const struct rte_acl_config *cfg);
 
 typedef int (*rte_acl_classify_t)
 (const struct rte_acl_ctx *, const uint8_t **, uint32_t *, uint32_t, uint32_t);
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 7056b1c117..1fd0ee3aa5 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -777,9 +777,12 @@ acl_merge_trie(struct acl_build_context *context,
  *  - reset all RT related fields to zero.
  */
 static void
-acl_build_reset(struct rte_acl_ctx *ctx)
+acl_build_reset(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 {
-	rte_free(ctx->mem);
+	if (cfg->running_free)
+		cfg->running_free(ctx->mem, cfg->running_cb_ctx);
+	else
+		rte_free(ctx->mem);
 	memset(&ctx->num_categories, 0,
 		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
 }
@@ -1518,6 +1521,9 @@ acl_bld(struct acl_build_context *bcx, struct rte_acl_ctx *ctx,
 	bcx->acx = ctx;
 	bcx->pool.alignment = ACL_POOL_ALIGN;
 	bcx->pool.min_alloc = ACL_POOL_ALLOC_MIN;
+	bcx->pool.alloc_cb = cfg->temp_alloc;
+	bcx->pool.reset_cb = cfg->temp_reset;
+	bcx->pool.cb_ctx = cfg->temp_cb_ctx;
 	bcx->cfg = *cfg;
 	bcx->category_mask = RTE_LEN2MASK(bcx->cfg.num_categories,
 		typeof(bcx->category_mask));
@@ -1635,7 +1641,7 @@ rte_acl_build(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 	if (rc != 0)
 		return rc;
 
-	acl_build_reset(ctx);
+	acl_build_reset(ctx, cfg);
 
 	if (cfg->max_size == 0) {
 		n = NODE_MIN;
@@ -1655,7 +1661,7 @@ rte_acl_build(struct rte_acl_ctx *ctx, const struct rte_acl_config *cfg)
 			rc = rte_acl_gen(ctx, bcx.tries, bcx.bld_tries,
 				bcx.num_tries, bcx.cfg.num_categories,
 				ACL_MAX_INDEXES * RTE_DIM(bcx.tries) *
-				sizeof(ctx->data_indexes[0]), max_size);
+				sizeof(ctx->data_indexes[0]), max_size, cfg);
 			if (rc == 0) {
 				/* set data indexes. */
 				acl_set_data_indexes(ctx);
diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
index 3c53d24056..6aa7d74635 100644
--- a/lib/acl/acl_gen.c
+++ b/lib/acl/acl_gen.c
@@ -448,7 +448,8 @@ acl_calc_counts_indices(struct acl_node_counters *counts,
 int
 rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 	struct rte_acl_bld_trie *node_bld_trie, uint32_t num_tries,
-	uint32_t num_categories, uint32_t data_index_sz, size_t max_size)
+	uint32_t num_categories, uint32_t data_index_sz, size_t max_size,
+	const struct rte_acl_config *cfg)
 {
 	void *mem;
 	size_t total_size;
@@ -478,7 +479,10 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 		return -ERANGE;
 	}
 
-	mem = rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
+	if (cfg->running_alloc)
+		mem = cfg->running_alloc(total_size, RTE_CACHE_LINE_SIZE, cfg->running_cb_ctx);
+	else
+		mem = rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
 			ctx->socket_id);
 	if (mem == NULL) {
 		ACL_LOG(ERR,
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 8c0ca29618..e765c40f4f 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -362,7 +362,10 @@ rte_acl_free(struct rte_acl_ctx *ctx)
 
 	rte_mcfg_tailq_write_unlock();
 
-	rte_free(ctx->mem);
+	if (ctx->config.running_free)
+		ctx->config.running_free(ctx->mem, ctx->config.running_cb_ctx);
+	else
+		rte_free(ctx->mem);
 	rte_free(ctx);
 	rte_free(te);
 }
diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
index 95354cabb8..c675c9ff81 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -13,6 +13,7 @@
 
 #include <rte_common.h>
 #include <rte_acl_osdep.h>
+#include <setjmp.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -61,6 +62,11 @@ struct rte_acl_field_def {
  * ACL build configuration.
  * Defines the fields of an ACL trie and number of categories to build with.
  */
+typedef void *(*rte_acl_running_alloc_t)(size_t, unsigned int, void *);
+typedef void  (*rte_acl_running_free_t)(void *, void *);
+typedef void *(*rte_acl_temp_alloc_t)(size_t, sigjmp_buf, void *);
+typedef void  (*rte_acl_temp_reset_t)(void *);
+
 struct rte_acl_config {
 	uint32_t num_categories; /**< Number of categories to build with. */
 	uint32_t num_fields;     /**< Number of field definitions. */
@@ -68,6 +74,20 @@ struct rte_acl_config {
 	/**< array of field definitions. */
 	size_t max_size;
 	/**< max memory limit for internal run-time structures. */
+
+	/**< Allocator callback for run-time internal memory. */
+	rte_acl_running_alloc_t  running_alloc;
+	/**< Free callback for run-time internal memory. */
+	rte_acl_running_free_t   running_free;
+	/**< User context passed to running_alloc/free. */
+	void                     *running_cb_ctx;
+
+	/**< Allocator callback for temporary memory used during build. */
+	rte_acl_temp_alloc_t     temp_alloc;
+	/**< Reset callback for temporary allocator. */
+	rte_acl_temp_reset_t     temp_reset;
+	/**< User context passed to temp_alloc/reset. */
+	void                     *temp_cb_ctx;
 };
 
 /**
diff --git a/lib/acl/tb_mem.c b/lib/acl/tb_mem.c
index 9264433422..b9c69b563e 100644
--- a/lib/acl/tb_mem.c
+++ b/lib/acl/tb_mem.c
@@ -55,6 +55,9 @@ tb_alloc(struct tb_mem_pool *pool, size_t size)
 
 	size = RTE_ALIGN_CEIL(size, pool->alignment);
 
+	if (pool->alloc_cb)
+		return pool->alloc_cb(size, pool->fail, pool->cb_ctx);
+
 	block = pool->block;
 	if (block == NULL || block->size < size) {
 		new_sz = (size > pool->min_alloc) ? size : pool->min_alloc;
@@ -71,6 +74,11 @@ tb_free_pool(struct tb_mem_pool *pool)
 {
 	struct tb_mem_block *next, *block;
 
+	if (pool->reset_cb) {
+		pool->reset_cb(pool->cb_ctx);
+		return;
+	}
+
 	for (block = pool->block; block != NULL; block = next) {
 		next = block->next;
 		free(block);
diff --git a/lib/acl/tb_mem.h b/lib/acl/tb_mem.h
index 2093744a6d..2fdebefc31 100644
--- a/lib/acl/tb_mem.h
+++ b/lib/acl/tb_mem.h
@@ -24,11 +24,17 @@ struct tb_mem_block {
 	uint8_t             *mem;
 };
 
+typedef void *(*rte_tb_alloc_t)(size_t, sigjmp_buf, void *);
+typedef void (*rte_tb_reset_t)(void *);
+
 struct tb_mem_pool {
 	struct tb_mem_block *block;
 	size_t               alignment;
 	size_t               min_alloc;
 	size_t               alloc;
+	rte_tb_alloc_t       alloc_cb;
+	rte_tb_reset_t       reset_cb;
+	void                 *cb_ctx;
 	/* jump target in case of memory allocation failure. */
 	sigjmp_buf           fail;
 };
-- 
2.43.0

