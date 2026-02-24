Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA2CE9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 13:33:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDE8740270;
	Tue, 24 Feb 2026 14:33:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 62F0D400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 14:33:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771940035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hU39DdegRN7tZJ1dIkHhQs0SxsCfORtZufW5LhGM+8M=;
 b=ZI8fgDw5FXG1N+93juZPoxQSyTJqjUViRz7YFDjJlkgSnHCGm7/6g9lyhF+RGhwO85P8n9
 2t4dZIjIoWG/KQVihA9WfTccToVmN7zUaCCEBdmiJXLHa6fKXCt3jHTdl5/0KJGM326RpK
 /calA/8FMuV/qgqACBhFcL1idSMa9zA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-a03T2oJVPxaSCSjYGtITHg-1; Tue,
 24 Feb 2026 08:33:54 -0500
X-MC-Unique: a03T2oJVPxaSCSjYGtITHg-1
X-Mimecast-MFC-AGG-ID: a03T2oJVPxaSCSjYGtITHg_1771940033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E53F19560AE; Tue, 24 Feb 2026 13:33:53 +0000 (UTC)
Received: from ringo.redhat.com (unknown [10.44.34.148])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B95C31800361; Tue, 24 Feb 2026 13:33:51 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH dpdk] fib: expose tbl8 usage statistics
Date: Tue, 24 Feb 2026 14:33:41 +0100
Message-ID: <20260224133340.1638295-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w5l9ODjbPwJqeYwPtJ02MuN_wrbLV8qH7o5t_gm_O6c_1771940033
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

Both dir24_8 (IPv4) and trie (IPv6) algorithms already track tbl8 group
allocation internally but there is no way for applications to query this
information. Monitoring tbl8 usage is important to detect exhaustion
before route insertions start failing.

Add rte_fib_tbl8_get_stats() and rte_fib6_tbl8_get_stats() to let
applications retrieve the number of tbl8 groups currently in use and the
total capacity. For dir24_8, the used count comes from cur_tbl8s. For
trie, it comes from tbl8_pool_pos which reflects the actual number of
allocated entries since the pool is a stack.

Add unit tests for both functions covering invalid arguments, unsupported
FIB types and verifying that the used count changes correctly after route
insertions and deletions.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 app/test/test_fib.c  | 71 +++++++++++++++++++++++++++++++++++++++++++
 app/test/test_fib6.c | 72 ++++++++++++++++++++++++++++++++++++++++++++
 lib/fib/rte_fib.c    | 22 ++++++++++++++
 lib/fib/rte_fib.h    | 18 +++++++++++
 lib/fib/rte_fib6.c   | 22 ++++++++++++++
 lib/fib/rte_fib6.h   | 18 +++++++++++
 6 files changed, 223 insertions(+)

diff --git a/app/test/test_fib.c b/app/test/test_fib.c
index bd73399d565c..29ba4bc43e04 100644
--- a/app/test/test_fib.c
+++ b/app/test/test_fib.c
@@ -22,6 +22,7 @@ static int32_t test_free_null(void);
 static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
+static int32_t test_tbl8_stats(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 
@@ -379,6 +380,75 @@ test_lookup(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Check tbl8 statistics for DIR24_8 FIB type.
+ *  - NULL fib returns -EINVAL
+ *  - DUMMY type returns -ENOTSUP
+ *  - Empty DIR24_8 reports 0 used
+ *  - After adding a route with depth > 24, used count increases
+ *  - After deleting the route, used count decreases
+ */
+int32_t
+test_tbl8_stats(void)
+{
+	struct rte_fib *fib = NULL;
+	struct rte_fib_conf config = { 0 };
+	uint32_t used, total;
+	int ret;
+
+	/* NULL fib */
+	ret = rte_fib_tbl8_get_stats(NULL, &used, &total);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Call succeeded with NULL fib\n");
+
+	/* DUMMY type */
+	config.max_routes = MAX_ROUTES;
+	config.default_nh = 0;
+	config.type = RTE_FIB_DUMMY;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+	ret = rte_fib_tbl8_get_stats(fib, &used, &total);
+	RTE_TEST_ASSERT(ret == -ENOTSUP,
+		"Call succeeded with DUMMY type FIB\n");
+	rte_fib_free(fib);
+
+	/* DIR24_8 type */
+	config.type = RTE_FIB_DIR24_8;
+	config.dir24_8.nh_sz = RTE_FIB_DIR24_8_4B;
+	config.dir24_8.num_tbl8 = MAX_TBL8;
+	fib = rte_fib_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* empty FIB: 0 used */
+	ret = rte_fib_tbl8_get_stats(fib, &used, &total);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used == 0, "Used count is not 0 for empty FIB\n");
+	RTE_TEST_ASSERT(total > 0, "Total count is 0\n");
+
+	/* NULL output pointers should not crash */
+	ret = rte_fib_tbl8_get_stats(fib, NULL, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed with NULL output pointers\n");
+
+	/* add a route with depth > 24 to allocate a tbl8 group */
+	ret = rte_fib_add(fib, RTE_IPV4(10, 0, 0, 0), 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add a route\n");
+	ret = rte_fib_tbl8_get_stats(fib, &used, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used > 0, "Used count did not increase after add\n");
+
+	/* delete the route */
+	ret = rte_fib_delete(fib, RTE_IPV4(10, 0, 0, 0), 28);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete a route\n");
+	ret = rte_fib_tbl8_get_stats(fib, &used, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used == 0,
+		"Used count did not decrease after delete\n");
+
+	rte_fib_free(fib);
+
+	return TEST_SUCCESS;
+}
+
 /*
  * rte_fib_rcu_qsbr_add positive and negative tests.
  *  - Add RCU QSBR variable to FIB
@@ -598,6 +668,7 @@ static struct unit_test_suite fib_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_tbl8_stats),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
diff --git a/app/test/test_fib6.c b/app/test/test_fib6.c
index fffb590dbfe1..1c90bc63c449 100644
--- a/app/test/test_fib6.c
+++ b/app/test/test_fib6.c
@@ -23,6 +23,7 @@ static int32_t test_free_null(void);
 static int32_t test_add_del_invalid(void);
 static int32_t test_get_invalid(void);
 static int32_t test_lookup(void);
+static int32_t test_tbl8_stats(void);
 static int32_t test_invalid_rcu(void);
 static int32_t test_fib_rcu_sync_rw(void);
 
@@ -390,6 +391,76 @@ test_lookup(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Check tbl8 statistics for TRIE FIB6 type.
+ *  - NULL fib returns -EINVAL
+ *  - DUMMY type returns -ENOTSUP
+ *  - Empty TRIE reports 0 used
+ *  - After adding a route with depth > 24, used count increases
+ *  - After deleting the route, used count decreases
+ */
+int32_t
+test_tbl8_stats(void)
+{
+	struct rte_fib6 *fib = NULL;
+	struct rte_fib6_conf config = { 0 };
+	struct rte_ipv6_addr ip = RTE_IPV6(0x2001, 0xdb8, 0, 0, 0, 0, 0, 0);
+	uint32_t used, total;
+	int ret;
+
+	/* NULL fib */
+	ret = rte_fib6_tbl8_get_stats(NULL, &used, &total);
+	RTE_TEST_ASSERT(ret == -EINVAL,
+		"Call succeeded with NULL fib\n");
+
+	/* DUMMY type */
+	config.max_routes = MAX_ROUTES;
+	config.default_nh = 0;
+	config.type = RTE_FIB6_DUMMY;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+	ret = rte_fib6_tbl8_get_stats(fib, &used, &total);
+	RTE_TEST_ASSERT(ret == -ENOTSUP,
+		"Call succeeded with DUMMY type FIB\n");
+	rte_fib6_free(fib);
+
+	/* TRIE type */
+	config.type = RTE_FIB6_TRIE;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = MAX_TBL8;
+	fib = rte_fib6_create(__func__, SOCKET_ID_ANY, &config);
+	RTE_TEST_ASSERT(fib != NULL, "Failed to create FIB\n");
+
+	/* empty FIB: 0 used */
+	ret = rte_fib6_tbl8_get_stats(fib, &used, &total);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used == 0, "Used count is not 0 for empty FIB\n");
+	RTE_TEST_ASSERT(total > 0, "Total count is 0\n");
+
+	/* NULL output pointers should not crash */
+	ret = rte_fib6_tbl8_get_stats(fib, NULL, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed with NULL output pointers\n");
+
+	/* add a route with depth > 24 to allocate tbl8 groups */
+	ret = rte_fib6_add(fib, &ip, 28, 1);
+	RTE_TEST_ASSERT(ret == 0, "Failed to add a route\n");
+	ret = rte_fib6_tbl8_get_stats(fib, &used, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used > 0, "Used count did not increase after add\n");
+
+	/* delete the route */
+	ret = rte_fib6_delete(fib, &ip, 28);
+	RTE_TEST_ASSERT(ret == 0, "Failed to delete a route\n");
+	ret = rte_fib6_tbl8_get_stats(fib, &used, NULL);
+	RTE_TEST_ASSERT(ret == 0, "Failed to get stats\n");
+	RTE_TEST_ASSERT(used == 0,
+		"Used count did not decrease after delete\n");
+
+	rte_fib6_free(fib);
+
+	return TEST_SUCCESS;
+}
+
 /*
  * rte_fib6_rcu_qsbr_add positive and negative tests.
  *  - Add RCU QSBR variable to FIB
@@ -609,6 +680,7 @@ static struct unit_test_suite fib6_fast_tests = {
 	TEST_CASE(test_add_del_invalid),
 	TEST_CASE(test_get_invalid),
 	TEST_CASE(test_lookup),
+	TEST_CASE(test_tbl8_stats),
 	TEST_CASE(test_invalid_rcu),
 	TEST_CASE(test_fib_rcu_sync_rw),
 	TEST_CASES_END()
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f38070..a7e8615f052f 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -364,3 +364,25 @@ rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg)
 		return -ENOTSUP;
 	}
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_get_stats, 26.07)
+int
+rte_fib_tbl8_get_stats(struct rte_fib *fib, uint32_t *used, uint32_t *total)
+{
+	struct dir24_8_tbl *dp;
+
+	if (fib == NULL)
+		return -EINVAL;
+
+	switch (fib->type) {
+	case RTE_FIB_DIR24_8:
+		dp = fib->dp;
+		if (used != NULL)
+			*used = dp->cur_tbl8s;
+		if (total != NULL)
+			*total = dp->number_tbl8s;
+		return 0;
+	default:
+		return -ENOTSUP;
+	}
+}
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index b16a653535cf..a79389cd4087 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -283,6 +283,24 @@ __rte_experimental
 int
 rte_fib_rcu_qsbr_add(struct rte_fib *fib, struct rte_fib_rcu_config *cfg);
 
+/**
+ * Retrieve tbl8 allocation statistics from the FIB.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param used
+ *   Number of tbl8 groups currently in use (can be NULL)
+ * @param total
+ *   Total number of tbl8 groups allocated at creation (can be NULL)
+ * @return
+ *   0 on success
+ *   -EINVAL if fib is NULL
+ *   -ENOTSUP if the FIB type does not support tbl8 statistics
+ */
+__rte_experimental
+int
+rte_fib_tbl8_get_stats(struct rte_fib *fib, uint32_t *used, uint32_t *total);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb611e..8a586710f429 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -361,3 +361,25 @@ rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg)
 		return -ENOTSUP;
 	}
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib6_tbl8_get_stats, 26.07)
+int
+rte_fib6_tbl8_get_stats(struct rte_fib6 *fib, uint32_t *used, uint32_t *total)
+{
+	struct rte_trie_tbl *dp;
+
+	if (fib == NULL)
+		return -EINVAL;
+
+	switch (fib->type) {
+	case RTE_FIB6_TRIE:
+		dp = fib->dp;
+		if (used != NULL)
+			*used = dp->tbl8_pool_pos;
+		if (total != NULL)
+			*total = dp->number_tbl8s;
+		return 0;
+	default:
+		return -ENOTSUP;
+	}
+}
diff --git a/lib/fib/rte_fib6.h b/lib/fib/rte_fib6.h
index 4527328bf00d..17fea82e8aee 100644
--- a/lib/fib/rte_fib6.h
+++ b/lib/fib/rte_fib6.h
@@ -272,6 +272,24 @@ __rte_experimental
 int
 rte_fib6_rcu_qsbr_add(struct rte_fib6 *fib, struct rte_fib6_rcu_config *cfg);
 
+/**
+ * Retrieve tbl8 allocation statistics from the FIB.
+ *
+ * @param fib
+ *   FIB object handle
+ * @param used
+ *   Number of tbl8 groups currently in use (can be NULL)
+ * @param total
+ *   Total number of tbl8 groups allocated at creation (can be NULL)
+ * @return
+ *   0 on success
+ *   -EINVAL if fib is NULL
+ *   -ENOTSUP if the FIB type does not support tbl8 statistics
+ */
+__rte_experimental
+int
+rte_fib6_tbl8_get_stats(struct rte_fib6 *fib, uint32_t *used, uint32_t *total);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

