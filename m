Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09381CCF2DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 08:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D583740613;
	Mon, 19 Oct 2026 10:58:12 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id AFB0640269
 for <dev@dpdk.org>; Mon, 19 Oct 2026 10:58:08 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=gRaKoq4AZGgcQyy2ehbB40ry4y53ihQk4Vy4yiMcElc=;
 b=nvVbCL14r9rz0GaxvJ6ExbaLwBrRMM8kn+P9wIY+2ODAx0VsbFBIijheBJUNiQr7M9fLSTKg2
 CSYYhXnFJAWoDNUChXPkSDEhaj/j9hcjEcHV5gZMNZDlj1PqNohBiAoy+denswE0RgOr3al8mH2
 C2f/o+Q16C6rSC7EOc0XTIw=
Received: from mail.maildlp.com (unknown [172.19.162.144])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j7Tw63Y8Rz1prRJ;
 Mon, 19 Oct 2026 16:57:58 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
 by mail.maildlp.com (Postfix) with ESMTPS id 378F34056E;
 Mon, 19 Oct 2026 16:58:01 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 16:57:54 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <bruce.richardson@intel.com>
Subject: [PATCH v2] argparse: support range step for corelist parsing
Date: Mon, 19 Oct 2026 16:57:48 +0800
Message-ID: <20261019085748.34787-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261016093001.9067-1-fengchengwen@huawei.com>
References: <20261016093001.9067-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)
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

Introduce a stride/step syntax ('-l start-end:step') to the EAL
corelist parser implemented within the argparse library.

On modern multi-core platforms, especially ARM architectures (such
as Kunpeng) logical sibling cores are frequently laid out contiguously
(e.g., physical core 0 maps to logical cores 0 and 1). When deploying
high-performance DPDK data planes, pinning worker threads to adjacent
sibling cores introduces Heavy L1/L2 cache contention and drastically
degrades overall throughput.

Previously, users had to explicitly expand core lists via commas
(e.g., "-l 0,2,4,6...126") in orchestration scripts to skip
hyperthreads, which is error-prone and hurts maintainability.

This patch introduces the range step, so we could use "-l 0-126:2" in
the same case.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
v2: add release note and more testcases
---
 app/test/test_argparse.c               | 123 +++++++++++++++++++++++++
 doc/guides/prog_guide/argparse_lib.rst |   2 +
 doc/guides/rel_notes/release_26_11.rst |   6 ++
 lib/argparse/rte_argparse.c            |  53 ++++++++---
 4 files changed, 172 insertions(+), 12 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index fdc6dd113c..c63380197f 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -822,8 +822,12 @@ test_argparse_parse_type_corelist(void)
 	char *corelist_valid_single = test_strdup("5");
 	char *corelist_valid_multiple = test_strdup("0,1,5");
 	char *corelist_valid_range = test_strdup("1-5");
+	char *corelist_valid_range_step = test_strdup("1-5:2");
+	char *corelist_valid_range_step_big = test_strdup("1-5:10");
 	char *corelist_valid_mixed = test_strdup("0,1,5-10,12-16,18,20");
+	char *corelist_valid_mixed_step = test_strdup("0,1,5-10:2,12-16:3,18,20");
 	char *corelist_valid_reverse_range = test_strdup("10-5");
+	char *corelist_valid_reverse_range_step = test_strdup("10-5:2");
 	char *corelist_valid_initial_spaces = test_strdup("   1,2,5-7");
 	char *corelist_valid_empty = test_strdup("");
 	char *corelist_invalid_spaces = test_strdup(" 1 , 2 , 5-7 ");
@@ -831,6 +835,14 @@ test_argparse_parse_type_corelist(void)
 	char *corelist_invalid_range_incomplete = test_strdup("1-");
 	char *corelist_invalid_range_double_dash = test_strdup("1--5");
 	char *corelist_invalid_range_double_range = test_strdup("1-3-5");
+	char *corelist_invalid_range_step_incomplete1 = test_strdup("1:");
+	char *corelist_invalid_range_step_incomplete2 = test_strdup("1:2");
+	char *corelist_invalid_range_step_incomplete3 = test_strdup("1-5:");
+	char *corelist_invalid_range_step_double = test_strdup("1-5::");
+	char *corelist_invalid_range_step_zero = test_strdup("1-5:0");
+	char *corelist_invalid_range_step_big = test_strdup("1-5:65536");
+	char *corelist_invalid_range_step_negative = test_strdup("1-5:-2");
+	char *corelist_invalid_range_step_more = test_strdup("1-5:2:");
 	char *corelist_invalid_special_chars = test_strdup("1,2@3");
 	char *corelist_invalid_comma_only = test_strdup(",");
 	char *corelist_invalid_out_of_range = test_strdup("70000");
@@ -867,6 +879,30 @@ test_argparse_parse_type_corelist(void)
 	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in range 1-5!");
 	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in range 1-5!");
 
+	/* test valid range step */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_range_step,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (range step) failed!");
+	for (int i = 1; i <= 5; i += 2)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 1-5:2!", i);
+	for (int i = 2; i <= 5; i += 2)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset), "Core %d should not be set in range 1-5:2!", i);
+	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in range 1-5:2!");
+	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in range 1-5:2!");
+
+	/* test valid range step big */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_range_step_big,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (range step big) failed!");
+	for (int i = 1; i <= 5; i += 10)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 1-5:10!", i);
+	for (int i = 2; i <= 5; i++)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset), "Core %d should not be set in range 1-5:10!", i);
+	TEST_ASSERT(!CPU_ISSET(0, &val_cpuset), "Core 0 should not be set in range 1-5:10!");
+	TEST_ASSERT(!CPU_ISSET(6, &val_cpuset), "Core 6 should not be set in range 1-5:10!");
+
 	/* test valid mixed corelist */
 	CPU_ZERO(&val_cpuset);
 	ret = rte_argparse_parse_type(corelist_valid_mixed,
@@ -886,6 +922,31 @@ test_argparse_parse_type_corelist(void)
 	TEST_ASSERT(!CPU_ISSET(17, &val_cpuset), "Core 17 should not be set in mixed corelist!");
 	TEST_ASSERT(!CPU_ISSET(19, &val_cpuset), "Core 19 should not be set in mixed corelist!");
 
+	/* test valid mixed step corelist */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_mixed_step,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (mixed step) failed!");
+	TEST_ASSERT(CPU_ISSET(0, &val_cpuset), "Core 0 should be set in mixed step corelist!");
+	TEST_ASSERT(CPU_ISSET(1, &val_cpuset), "Core 1 should be set in mixed step corelist!");
+	for (int i = 5; i <= 10; i += 2)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 5-10:2!", i);
+	for (int i = 6; i <= 10; i += 2)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset), "Core %d should not be set in range 5-10:2!", i);
+	for (int i = 12; i <= 16; i += 3)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset), "Core %d should be set in range 12-16:3!", i);
+	for (int i = 13; i <= 16; i += 3)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset), "Core %d should not be set in range 12-16:3!", i);
+	for (int i = 14; i <= 16; i += 3)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset), "Core %d should not be set in range 12-16:3!", i);
+	TEST_ASSERT(CPU_ISSET(18, &val_cpuset), "Core 18 should be set in mixed step corelist!");
+	TEST_ASSERT(CPU_ISSET(20, &val_cpuset), "Core 20 should be set in mixed step corelist!");
+	TEST_ASSERT(!CPU_ISSET(2, &val_cpuset), "Core 2 should not be set in mixed step corelist!");
+	TEST_ASSERT(!CPU_ISSET(11, &val_cpuset), "Core 11 should not be set in mixed step corelist!");
+	TEST_ASSERT(!CPU_ISSET(17, &val_cpuset), "Core 17 should not be set in mixed step corelist!");
+	TEST_ASSERT(!CPU_ISSET(19, &val_cpuset), "Core 19 should not be set in mixed step corelist!");
+
+
 	/* test valid reverse range (10-5 should be interpreted as 5-10) */
 	CPU_ZERO(&val_cpuset);
 	ret = rte_argparse_parse_type(corelist_valid_reverse_range,
@@ -897,6 +958,20 @@ test_argparse_parse_type_corelist(void)
 	TEST_ASSERT(!CPU_ISSET(4, &val_cpuset), "Core 4 should not be set in reverse range 10-5!");
 	TEST_ASSERT(!CPU_ISSET(11, &val_cpuset), "Core 11 should not be set in reverse range 10-5!");
 
+	/* test valid reverse range step (10-5:2 should be interpreted as 5-10:2) */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_valid_reverse_range_step,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret == 0, "Argparse parse type for corelist (reverse range) failed!");
+	for (int i = 5; i <= 10; i += 2)
+		TEST_ASSERT(CPU_ISSET(i, &val_cpuset),
+				"Core %d should be set in reverse range 10-5:2!", i);
+	for (int i = 6; i <= 10; i += 2)
+		TEST_ASSERT(!CPU_ISSET(i, &val_cpuset),
+				"Core %d should not be set in reverse range 10-5:2!", i);
+	TEST_ASSERT(!CPU_ISSET(4, &val_cpuset), "Core 4 should not be set in reverse range 10-5!");
+	TEST_ASSERT(!CPU_ISSET(11, &val_cpuset), "Core 11 should not be set in reverse range 10-5!");
+
 	/* test valid corelist with initial spaces only */
 	CPU_ZERO(&val_cpuset);
 	ret = rte_argparse_parse_type(corelist_valid_initial_spaces,
@@ -948,6 +1023,54 @@ test_argparse_parse_type_corelist(void)
 			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
 	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (double range) should have failed!");
 
+	/* test invalid corelist with step complete1 */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_incomplete1,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step incomplete1) should have failed!");
+
+	/* test invalid corelist with step incomplete2 */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_incomplete2,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step incomplete2) should have failed!");
+
+	/* test invalid corelist with step incomplete3 */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_incomplete3,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step incomplete3) should have failed!");
+
+	/* test invalid corelist with step double */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_double,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step double) should have failed!");
+
+	/* test invalid corelist with step zero */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_zero,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step zero) should have failed!");
+
+	/* test invalid corelist with step big */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_big,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step big) should have failed!");
+
+	/* test invalid corelist with step negative */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_negative,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step negative) should have failed!");
+
+	/* test invalid corelist with step more */
+	CPU_ZERO(&val_cpuset);
+	ret = rte_argparse_parse_type(corelist_invalid_range_step_more,
+			RTE_ARGPARSE_VALUE_TYPE_CORELIST, &val_cpuset);
+	TEST_ASSERT(ret != 0, "Argparse parse type for corelist (step more) should have failed!");
+
 	/* test invalid corelist with special characters */
 	CPU_ZERO(&val_cpuset);
 	ret = rte_argparse_parse_type(corelist_invalid_special_chars,
diff --git a/doc/guides/prog_guide/argparse_lib.rst b/doc/guides/prog_guide/argparse_lib.rst
index b0907cfc07..3d01406599 100644
--- a/doc/guides/prog_guide/argparse_lib.rst
+++ b/doc/guides/prog_guide/argparse_lib.rst
@@ -271,8 +271,10 @@ The corelist parsing supports the following input formats:
 - **Single core**: ``--cores 5`` (sets core 5)
 - **Multiple cores**: ``--cores 1,2,5`` (sets cores 1, 2, and 5)
 - **Core ranges**: ``--cores 1-5`` (sets cores 1, 2, 3, 4, and 5)
+- **Core ranges with step**: ``--cores 1-5:2`` (sets cores 1, 3, and 5)
 - **Mixed format**: ``--cores 0,2-4,7`` (sets cores 0, 2, 3, 4, and 7)
 - **Reverse ranges**: ``--cores 5-1`` (equivalent to 1-5, sets cores 1, 2, 3, 4, and 5)
+- **Reverse ranges with step**: ``--cores 5-1:2`` (equivalent to 1-5:2, sets cores 1, 3, and 5)
 - **Empty corelist**: ``--cores ""`` (sets no cores)
 
 The parsed result is stored in an ``rte_cpuset_t`` structure that can be used
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index be758a0c02..1712007398 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -123,6 +123,12 @@ New Features
   Added internal ``flow_graph`` API in ethdev
   for PMD drivers to build graph-based flow pattern parsers.
 
+* **Added step syntax for corelist ranges parsing.**
+
+  The corelist parser now supports step syntax for core ranges.
+  For example, ``-l 0-126:2`` selects cores 0, 2, 4, ..., 126.
+  This is useful for skipping sibling cores on systems with SMT/hyperthreading.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/lib/argparse/rte_argparse.c b/lib/argparse/rte_argparse.c
index 88c3e7740c..f1e1fb9d20 100644
--- a/lib/argparse/rte_argparse.c
+++ b/lib/argparse/rte_argparse.c
@@ -573,6 +573,9 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 {
 	rte_cpuset_t *cpuset = arg->val_saver;
 	const char *last = value;
+	bool is_step = false;
+	int32_t step = 1;
+	int32_t max = -1;
 	int min = -1;
 
 	if (value == NULL) {
@@ -584,7 +587,6 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 	while (*last != '\0') {
 		char *end;
 		int64_t idx;
-		int32_t max;
 
 		while (isblank(*value))
 			value++;
@@ -603,6 +605,14 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 				arg->name_long);
 			return -EINVAL;
 		}
+		if (is_step) {
+			if (idx == 0) {
+				ARGPARSE_LOG(ERR, "argument %s step value must be positive!",
+					arg->name_long);
+				return -EINVAL;
+			}
+			step = idx;
+		}
 
 		if (*end == '-') {
 			if (min != -1) { /* can't have '-' within a range */
@@ -612,22 +622,41 @@ parse_arg_corelist(const struct rte_argparse_arg *arg, const char *value)
 			}
 			min = idx; /* start of range, move to next loop stage */
 		} else if (*end == ',' || *end == '\0') {
-			/* single value followed by comma or end (min is set only by '-') */
-			if (min == -1) {
-				min = max = idx;
-			} else if (min > idx) {
-				/* we have range from high to low */
+			if (!is_step) {
+				/* single value followed by comma or end (min is set only by '-') */
+				if (min == -1) {
+					min = max = idx;
+				} else if (min > idx) {
+					/* we have range from high to low */
+					max = min;
+					min = idx;
+				} else {
+					/* range from low to high */
+					max = idx;
+				}
+			}
+
+			for (; min <= max; min += step)
+				CPU_SET(min, cpuset);
+
+			/* no longer in a range */
+			min = -1;
+			max = -1;
+			step = 1;
+			is_step = false;
+		} else if (*end == ':') {
+			if (min == -1 || is_step) {
+				ARGPARSE_LOG(ERR, "argument %s step can only be used after a range (start-end:step)!",
+					arg->name_long);
+				return -EINVAL;
+			}
+			if (min > idx) {
 				max = min;
 				min = idx;
 			} else {
-				/* range from low to high */
 				max = idx;
 			}
-
-			for (; min <= max; min++)
-				CPU_SET(min, cpuset);
-
-			min = -1; /* no longer in a range */
+			is_step = true;
 		} else {
 			/* end is an unexpected character, return error */
 			ARGPARSE_LOG(ERR, "argument %s has an unexpected character!",
-- 
2.17.1

