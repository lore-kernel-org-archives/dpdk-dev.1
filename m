Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53959CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:54:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E6DC40669;
	Wed, 15 Oct 2025 11:54:00 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id ABEB640276
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760522038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KOMuxsUfOpqKaxQzizLxndty2UImfrkHm79f+0r4KnM=;
 b=QbjU5mLJps+rnih/MU9Kvh0nDOCmL2e3+mkOrvpuksqB1OeRS4Lg29tJj/Tk6NPX65bvbM
 g54ecF1onhnwSeZ9pTeo5vlqjtD/YV6UncVl1cR1hs2ABg3sBIeYv8zjoXYdZUO0Vovcun
 MCqgFGFnziE8yvixiOTBVxhDCXeh1IA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-XQ-GvMvVPRypmZPVTaiLEQ-1; Wed,
 15 Oct 2025 05:53:56 -0400
X-MC-Unique: XQ-GvMvVPRypmZPVTaiLEQ-1
X-Mimecast-MFC-AGG-ID: XQ-GvMvVPRypmZPVTaiLEQ_1760522036
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9761C1954208; Wed, 15 Oct 2025 09:53:55 +0000 (UTC)
Received: from ringo.home (unknown [10.45.224.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6957C19560AD; Wed, 15 Oct 2025 09:53:54 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk v2] fib6: implement RCU rule reclamation
Date: Wed, 15 Oct 2025 11:53:48 +0200
Message-ID: <20251015095347.333685-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 32MDdnINxRsFev8u4O1WQeBE-6G6h2rWW2SfX9cL8Jw_1760522036
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

Currently, for the TRIE algorithm, the tbl8 group is freed even though
the readers might be using the tbl8 group entries. The freed tbl8 group
can be reallocated quickly. As a result, lookup may be performed
incorrectly.

To address that, RCU QSBR is integrated for safe tbl8 group reclamation.

Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Signed-off-by: Robin Jarry <rjarry@redhat.com>
---

Notes:
    v2:
    
    - Fixed typos in docstrings.
    - Tests depend on: http://patches.dpdk.org/project/dpdk/list/?series=36356

 app/test/test_fib6.c | 214 +++++++++++++++++++++++++++++++++++++++++++
 lib/fib/rte_fib6.c   |  15 +++
 lib/fib/rte_fib6.h   |  52 +++++++++++
 lib/fib/trie.c       |  89 ++++++++++++++++--
 lib/fib/trie.h       |   8 ++
 5 files changed, 371 insertions(+), 7 deletions(-)

diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index 79220a88b112..843a4086c1cf 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -11,6 +11,7 @@
 #include <rte_log.h>
 #include <rte_rib6.h>
 #include <rte_fib6.h>
+#include <rte_malloc.h>
 
 #include "test.h"
 
@@ -22,6 +23,8 @@ static int32_t test_free_null(void);
 static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
+static int32_t test_invalid_rcu(void);
+static int32_t test_fib_rcu_sync_rw(void);
 
 #define MAX_ROUTES	(1 << 16)
 /** Maximum number of tbl8 for 2-byte entries */
@@ -387,6 +390,215 @@ test_lookup(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * rte_fib6_rcu_qsbr_add positive and negative tests.
+ *  - Add RCU QSBR variable to FIB
+ *  - Add another RCU QSBR variable to FIB
+ *  - Check returns
+ */
+int32_t
+test_invalid_rcu(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	size_t sz;
+	struct rte_rcu_qsbr *qsv;
+	struct rte_rcu_qsbr *qsv2;
+	int32_t status;
+	struct rte_fib6_rcu_config rcu_cfg = {0};
+	uint64_t def_nh = 100;
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Create RCU QSBR variable */
+	sz = rte_rcu_qsbr_get_memsize(RTE_MAX_LCORE);
+	qsv = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv != NULL, "Can not allocate memory for RCU\n");
+
+	status = rte_rcu_qsbr_init(qsv, RTE_MAX_LCORE);
+	RTE_TEST_ASSERT(status == 0, "Can not initialize RCU\n");
+
+	rcu_cfg.v = qsv;
+
+	/* adding rcu to RTE_FIB6_DUMMY FIB type */
+	config.type = RTE_FIB6_DUMMY;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_SYNC;
+	status = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == -ENOTSUP,
+		"rte_fib6_rcu_qsbr_add returned wrong error status when called with DUMMY type FIB\n");
+	rte_fib6_free(fib);
+
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* Call rte_fib6_rcu_qsbr_add without fib or config */
+	status = rte_fib6_rcu_qsbr_add(NULL, &rcu_cfg);
+	RTE_TEST_ASSERT(status == -EINVAL, "RCU added without fib\n");
+	status = rte_fib6_rcu_qsbr_add(fib, NULL);
+	RTE_TEST_ASSERT(status == -EINVAL, "RCU added without config\n");
+
+	/* Invalid QSBR mode */
+	rcu_cfg.mode = 2;
+	status = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == -EINVAL, "RCU added with incorrect mode\n");
+
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_DQ;
+
+	/* Attach RCU QSBR to FIB to check for double attach */
+	status = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to FIB\n");
+
+	/* Create and attach another RCU QSBR to FIB table */
+	qsv2 = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(qsv2 != NULL, "Can not allocate memory for RCU\n");
+
+	rcu_cfg.v = qsv2;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_SYNC;
+	status = rte_fib6_rcu_qsbr_add(fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == -EEXIST, "Secondary RCU was mistakenly attached\n");
+
+	rte_fib6_free(fib);
+	rte_free(qsv);
+	rte_free(qsv2);
+
+	return TEST_SUCCESS;
+}
+
+static struct rte_fib6 *g_fib;
+static struct rte_rcu_qsbr *g_v;
+static struct rte_ipv6_addr g_ip = RTE_IPV6(0x2001, 0xabcd, 0, 0, 0, 0, 0, 1);
+static volatile uint8_t writer_done;
+/* Report quiescent state interval every 1024 lookups. Larger critical
+ * sections in reader will result in writer polling multiple times.
+ */
+#define QSBR_REPORTING_INTERVAL 1024
+#define WRITER_ITERATIONS	512
+
+/*
+ * Reader thread using rte_fib6 data structure with RCU.
+ */
+static int
+test_fib_rcu_qsbr_reader(void *arg)
+{
+	int i;
+	uint64_t next_hop_return = 0;
+
+	RTE_SET_USED(arg);
+	/* Register this thread to report quiescent state */
+	rte_rcu_qsbr_thread_register(g_v, 0);
+	rte_rcu_qsbr_thread_online(g_v, 0);
+
+	do {
+		for (i = 0; i < QSBR_REPORTING_INTERVAL; i++)
+			rte_fib6_lookup_bulk(g_fib, &g_ip, &next_hop_return, 1);
+
+		/* Update quiescent state */
+		rte_rcu_qsbr_quiescent(g_v, 0);
+	} while (!writer_done);
+
+	rte_rcu_qsbr_thread_offline(g_v, 0);
+	rte_rcu_qsbr_thread_unregister(g_v, 0);
+
+	return 0;
+}
+
+/*
+ * rte_fib6_rcu_qsbr_add sync mode functional test.
+ * 1 Reader and 1 writer. They cannot be in the same thread in this test.
+ *  - Create FIB which supports 1 tbl8 group at max
+ *  - Add RCU QSBR variable with sync mode to FIB
+ *  - Register a reader thread. Reader keeps looking up a specific rule.
+ *  - Writer keeps adding and deleting a specific rule with depth=28 (> 24)
+ */
+int32_t
+test_fib_rcu_sync_rw(void)
+{
+	struct rte_fib6_conf config = { 0 };
+	size_t sz;
+	int32_t status;
+	uint32_t i, next_hop;
+	uint8_t depth;
+	struct rte_fib6_rcu_config rcu_cfg = {0};
+	uint64_t def_nh = 100;
+
+	if (rte_lcore_count() < 2) {
+		printf("Not enough cores for %s, expecting at least 2\n", __func__);
+		return TEST_SKIPPED;
+	}
+
+	config.max_routes = MAX_ROUTES;
+	config.rib_ext_sz = 0;
+	config.default_nh = def_nh;
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = 1;
+
+	g_fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(g_fib != NULL, "Failed to create FIB\n");
+
+	/* Create RCU QSBR variable */
+	sz = rte_rcu_qsbr_get_memsize(1);
+	g_v = (struct rte_rcu_qsbr *)rte_zmalloc_socket(NULL, sz, RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	RTE_TEST_ASSERT(g_v != NULL, "Can not allocate memory for RCU\n");
+
+	status = rte_rcu_qsbr_init(g_v, 1);
+	RTE_TEST_ASSERT(status == 0, "Can not initialize RCU\n");
+
+	rcu_cfg.v = g_v;
+	rcu_cfg.mode = RTE_FIB6_QSBR_MODE_SYNC;
+	/* Attach RCU QSBR to FIB table */
+	status = rte_fib6_rcu_qsbr_add(g_fib, &rcu_cfg);
+	RTE_TEST_ASSERT(status == 0, "Can not attach RCU to FIB\n");
+
+	writer_done = 0;
+	/* Launch reader thread */
+	rte_eal_remote_launch(test_fib_rcu_qsbr_reader, NULL, rte_get_next_lcore(-1, 1, 0));
+
+	depth = 28;
+	next_hop = 1;
+	status = rte_fib6_add(g_fib, &g_ip, depth, next_hop);
+	if (status != 0) {
+		printf("%s: Failed to add rule\n", __func__);
+		goto error;
+	}
+
+	/* Writer update */
+	for (i = 0; i < WRITER_ITERATIONS; i++) {
+		status = rte_fib6_delete(g_fib, &g_ip, depth);
+		if (status != 0) {
+			printf("%s: Failed to delete rule at iteration %d\n", __func__, i);
+			goto error;
+		}
+
+		status = rte_fib6_add(g_fib, &g_ip, depth, next_hop);
+		if (status != 0) {
+			printf("%s: Failed to add rule at iteration %d\n", __func__, i);
+			goto error;
+		}
+	}
+
+error:
+	writer_done = 1;
+	/* Wait until reader exited. */
+	rte_eal_mp_wait_lcore();
+
+	rte_fib6_free(g_fib);
+	rte_free(g_v);
+
+	return status == 0 ? TEST_SUCCESS : TEST_FAILED;
+}
+
 static struct unit_test_suite fib6_fast_tests = {
 	.suite_name = "fib6 autotest",
 	.setup = NULL,
@@ -397,6 +609,8 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_invalid_rcu),
+	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
 	}
 };
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 93a1c7197b26..dffcbdf657e8 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -346,3 +346,18 @@ rte_fib6_select_lookup(struct rte_fib6 *fib,
 		return -EINVAL;
 	}
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_rcu_qsbr_add, 25.07)
+int
+rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg)
+{
+	if (fib == NULL || cfg == NULL)
+		return -EINVAL;
+
+	switch (fib->type) {
+	case RTE_FIB6_TRIE:
+		return trie_rcu_qsbr_add(fib->dp, cfg, fib->name);
+	default:
+		return -ENOTSUP;
+	}
+}
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 625df1fa6b7b..4527328bf00d 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -19,6 +19,7 @@
 
 #include <rte_common.h>
 #include <rte_ip6.h>
+#include <rte_rcu_qsbr.h>
 
 #ifdef __cplusplus
 extern "C" {
@@ -34,6 +35,19 @@ extern "C" {
 struct rte_fib6;
 struct rte_rib6;
 
+/** @internal Default RCU defer queue entries to reclaim in one go. */
+#define RTE_FIB6_RCU_DQ_RECLAIM_MAX     16
+/** @internal Default RCU defer queue size. */
+#define RTE_FIB6_RCU_DQ_RECLAIM_SZ      128
+
+/** RCU reclamation modes */
+enum rte_fib6_qsbr_mode {
+	/** Create defer queue for reclaim. */
+	RTE_FIB6_QSBR_MODE_DQ = 0,
+	/** Use blocking mode reclaim. No defer queue created. */
+	RTE_FIB6_QSBR_MODE_SYNC
+};
+
 /** Type of FIB struct */
 enum rte_fib6_type {
 	RTE_FIB6_DUMMY,		/**< RIB6 tree based FIB */
@@ -85,6 +99,26 @@ struct rte_fib6_conf {
 	};
 };
 
+/** FIB RCU QSBR configuration structure. */
+struct rte_fib6_rcu_config {
+	/** RCU QSBR variable. */
+	struct rte_rcu_qsbr *v;
+	/** Mode of RCU QSBR. See RTE_FIB6_QSBR_MODE_*.
+	 * Default: RTE_FIB6_QSBR_MODE_DQ, create defer queue for reclaim.
+	 */
+	enum rte_fib6_qsbr_mode mode;
+	/** RCU defer queue size.
+	 * Default: RTE_FIB6_RCU_DQ_RECLAIM_SZ.
+	 */
+	uint32_t dq_size;
+	/** Threshold to trigger auto reclaim. */
+	uint32_t reclaim_thd;
+	/** Max entries to reclaim in one go.
+	 * Default: RTE_FIB6_RCU_DQ_RECLAIM_MAX.
+	 */
+	uint32_t reclaim_max;
+};
+
 /**
  * Free an FIB object.
  *
@@ -220,6 +254,24 @@ rte_fib6_get_rib(struct rte_fib6 *fib);
 int
 rte_fib6_select_lookup(struct rte_fib6 *fib, enum rte_fib6_lookup_type type);
 
+/**
+ * Associate RCU QSBR variable with a FIB object.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param cfg
+ *   RCU QSBR configuration
+ * @return
+ *   0 on success
+ *   -EINVAL - invalid pointer
+ *   -EEXIST - already added QSBR
+ *   -ENOMEM - memory allocation failure
+ *   -ENOTSUP - not supported by configured dataplane algorithm
+ */
+__rte_experimental
+int
+rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fib/trie.c b/lib/fib/trie.c
index 6427920c5833..7a5cfe66b495 100644
--- a/lib/fib/trie.c
+++ b/lib/fib/trie.c
@@ -13,6 +13,7 @@
 
 #include <rte_rib6.h>
 #include <rte_fib6.h>
+#include "fib_log.h"
 #include "trie.h"
 
 #ifdef CC_AVX512_SUPPORT
@@ -160,6 +161,12 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	uint8_t		*tbl8_ptr;
 
 	tbl8_idx = tbl8_get(dp);
+
+	/* If there are no tbl8 groups try to reclaim one. */
+	if (unlikely(tbl8_idx == -ENOSPC && dp->dq &&
+			!rte_rcu_qsbr_dq_reclaim(dp->dq, 1, NULL, NULL, NULL)))
+		tbl8_idx = tbl8_get(dp);
+
 	if (tbl8_idx < 0)
 		return tbl8_idx;
 	tbl8_ptr = get_tbl_p_by_idx(dp->tbl8,
@@ -170,6 +177,23 @@ tbl8_alloc(struct rte_trie_tbl *dp, uint64_t nh)
 	return tbl8_idx;
 }
 
+static void
+tbl8_cleanup_and_free(struct rte_trie_tbl *dp, uint64_t tbl8_idx)
+{
+	uint8_t *ptr = (uint8_t *)dp->tbl8 + (tbl8_idx * TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+
+	memset(ptr, 0, TRIE_TBL8_GRP_NUM_ENT << dp->nh_sz);
+	tbl8_put(dp, tbl8_idx);
+}
+
+static void
+__rcu_qsbr_free_resource(void *p, void *data, unsigned int n __rte_unused)
+{
+	struct rte_trie_tbl *dp = p;
+	uint64_t tbl8_idx = *(uint64_t *)data;
+	tbl8_cleanup_and_free(dp, tbl8_idx);
+}
+
 static void
 tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 {
@@ -191,8 +215,6 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 				return;
 		}
 		write_to_dp(par, nh, dp->nh_sz, 1);
-		for (i = 0; i < TRIE_TBL8_GRP_NUM_ENT; i++)
-			ptr16[i] = 0;
 		break;
 	case RTE_FIB6_TRIE_4B:
 		ptr32 = &((uint32_t *)dp->tbl8)[tbl8_idx *
@@ -205,8 +227,6 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 				return;
 		}
 		write_to_dp(par, nh, dp->nh_sz, 1);
-		for (i = 0; i < TRIE_TBL8_GRP_NUM_ENT; i++)
-			ptr32[i] = 0;
 		break;
 	case RTE_FIB6_TRIE_8B:
 		ptr64 = &((uint64_t *)dp->tbl8)[tbl8_idx *
@@ -219,11 +239,18 @@ tbl8_recycle(struct rte_trie_tbl *dp, void *par, uint64_t tbl8_idx)
 				return;
 		}
 		write_to_dp(par, nh, dp->nh_sz, 1);
-		for (i = 0; i < TRIE_TBL8_GRP_NUM_ENT; i++)
-			ptr64[i] = 0;
 		break;
 	}
-	tbl8_put(dp, tbl8_idx);
+
+	if (dp->v == NULL) {
+		tbl8_cleanup_and_free(dp, tbl8_idx);
+	} else if (dp->rcu_mode == RTE_FIB6_QSBR_MODE_SYNC) {
+		rte_rcu_qsbr_synchronize(dp->v, RTE_QSBR_THRID_INVALID);
+		tbl8_cleanup_and_free(dp, tbl8_idx);
+	} else { /* RTE_FIB6_QSBR_MODE_DQ */
+		if (rte_rcu_qsbr_dq_enqueue(dp->dq, &tbl8_idx))
+			FIB_LOG(ERR, "Failed to push QSBR FIFO");
+	}
 }
 
 #define BYTE_SIZE	8
@@ -695,7 +722,55 @@ trie_free(void *p)
 {
 	struct rte_trie_tbl *dp = (struct rte_trie_tbl *)p;
 
+	rte_rcu_qsbr_dq_delete(dp->dq);
 	rte_free(dp->tbl8_pool);
 	rte_free(dp->tbl8);
 	rte_free(dp);
 }
+
+int
+trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
+	const char *name)
+{
+	struct rte_rcu_qsbr_dq_parameters params = {0};
+	char rcu_dq_name[RTE_RCU_QSBR_DQ_NAMESIZE];
+
+	if (dp == NULL || cfg == NULL)
+		return -EINVAL;
+
+	if (dp->v != NULL)
+		return -EEXIST;
+
+	switch (cfg->mode) {
+	case RTE_FIB6_QSBR_MODE_DQ:
+		/* Init QSBR defer queue. */
+		snprintf(rcu_dq_name, sizeof(rcu_dq_name),
+			"FIB_RCU_%s", name);
+		params.name = rcu_dq_name;
+		params.size = cfg->dq_size;
+		if (params.size == 0)
+			params.size = RTE_FIB6_RCU_DQ_RECLAIM_SZ;
+		params.trigger_reclaim_limit = cfg->reclaim_thd;
+		params.max_reclaim_size = cfg->reclaim_max;
+		if (params.max_reclaim_size == 0)
+			params.max_reclaim_size = RTE_FIB6_RCU_DQ_RECLAIM_MAX;
+		params.esize = sizeof(uint64_t);
+		params.free_fn = __rcu_qsbr_free_resource;
+		params.p = dp;
+		params.v = cfg->v;
+		dp->dq = rte_rcu_qsbr_dq_create(&params);
+		if (dp->dq == NULL) {
+			FIB_LOG(ERR, "FIB6 defer queue creation failed");
+			return -ENOMEM;
+		}
+	case RTE_FIB6_QSBR_MODE_SYNC:
+		/* No other things to do. */
+		break;
+	default:
+		return -EINVAL;
+	}
+	dp->rcu_mode = cfg->mode;
+	dp->v = cfg->v;
+
+	return 0;
+}
diff --git a/lib/fib/trie.h b/lib/fib/trie.h
index bcb161702b49..c34cc2c05731 100644
--- a/lib/fib/trie.h
+++ b/lib/fib/trie.h
@@ -38,6 +38,10 @@ struct rte_trie_tbl {
 	uint64_t	*tbl8;		/**< tbl8 table. */
 	uint32_t	*tbl8_pool;	/**< bitmap containing free tbl8 idxes*/
 	uint32_t	tbl8_pool_pos;
+	/* RCU config. */
+	enum rte_fib6_qsbr_mode rcu_mode; /**< Blocking, defer queue. */
+	struct rte_rcu_qsbr *v; /**< RCU QSBR variable. */
+	struct rte_rcu_qsbr_dq *dq; /**< RCU QSBR defer queue. */
 	/* tbl24 table. */
 	alignas(RTE_CACHE_LINE_SIZE) uint64_t	tbl24[];
 };
@@ -143,4 +147,8 @@ int
 trie_modify(struct rte_fib6 *fib, const struct rte_ipv6_addr *ip,
 	uint8_t depth, uint64_t next_hop, int op);
 
+int
+trie_rcu_qsbr_add(struct rte_trie_tbl *dp, struct rte_fib6_rcu_config *cfg,
+	const char *name);
+
 #endif /* _TRIE_H_ */
-- 
2.51.0

