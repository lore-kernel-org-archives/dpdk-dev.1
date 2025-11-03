Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B7FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 13:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0138C40285;
	Mon,  3 Nov 2025 14:24:36 +0100 (CET)
Received: from wh10.alp1.flow.ch (wh10.alp1.flow.ch [185.119.84.194])
 by mails.dpdk.org (Postfix) with ESMTP id B10A340281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 14:24:34 +0100 (CET)
Received: from i6897661c.versanet.de ([104.151.102.28]:51391 helo=localhost)
 by wh10.alp1.flow.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <alex@bisonrouter.com>)
 id 1vFuXy-0000000By0T-48lg; Mon, 03 Nov 2025 14:24:34 +0100
From: Alex Kiselev <alex@bisonrouter.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	vladimir.medvedkin@intel.com
Subject: [PATCH] lpm: add new LPM v6 implementation (lpm6c)
Date: Mon,  3 Nov 2025 14:24:33 +0100
Message-Id: <20251103132433.38627-1-alex@bisonrouter.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - wh10.alp1.flow.ch
X-AntiAbuse: Original Domain - dpdk.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bisonrouter.com
X-Get-Message-Sender-Via: wh10.alp1.flow.ch: authenticated_id:
 alex@bisonrouter.com
X-Authenticated-Sender: wh10.alp1.flow.ch: alex@bisonrouter.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

lpm6c is a new implementation of the IPv6 LPM algorithm, based on
the existing lpm module. It utilizes a trie path compression technique to
optimize lookup operations.

The implementation offers a performance improvement over the lpm
module starting from /64 and longer prefixes. This makes it beneficial
for use cases like BNG routers, whose FIB tables contain numerous /64
prefixes and primarily handle traffic targeting them.

Performance comparison results against the original LPM6 for lookups
at AMD Ryzen 9 5900XT CPU:

prefix /48 tests:
Speedup vs LPM6: LPM6c 0.991x, LPM6c VEC 0.921x, FIB 1.000x, FIB VEC 1.048x

prefix /64 tests:
Speedup vs LPM6: LPM6c 1.399x, LPM6c VEC 1.302x, FIB 1.145x, FIB VEC 1.292x

prefix /80 tests:
Speedup vs LPM6: LPM6c 1.620x, LPM6c VEC 1.558x, FIB 1.096x, FIB VEC 1.226x

prefix /128 tests:
Speedup vs LPM6: LPM6c 2.497x, LPM6c VEC 2.369x, FIB 1.255x, FIB VEC 1.349x

Signed-off-by: Alex Kiselev <alex@bisonrouter.com>
---
 app/test/meson.build           |    3 +
 app/test/test_lpm6c.c          | 1776 ++++++++++++++++++++++++++++++++
 app/test/test_lpm6c_perf.c     |  161 +++
 app/test/test_lpm6c_perf_cmp.c |  409 ++++++++
 lib/lpm/meson.build            |    4 +-
 lib/lpm/rte_lpm6c.c            | 1320 ++++++++++++++++++++++++
 lib/lpm/rte_lpm6c.h            |  560 ++++++++++
 7 files changed, 4231 insertions(+), 2 deletions(-)
 create mode 100644 app/test/test_lpm6c.c
 create mode 100644 app/test/test_lpm6c_perf.c
 create mode 100644 app/test/test_lpm6c_perf_cmp.c
 create mode 100644 lib/lpm/rte_lpm6c.c
 create mode 100644 lib/lpm/rte_lpm6c.h

diff --git a/app/test/meson.build b/app/test/meson.build
index 8df8d3edd1..1f0a09c889 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -116,7 +116,10 @@ source_file_deps = {
     'test_logs.c': [],
     'test_lpm.c': ['net', 'lpm'],
     'test_lpm6.c': ['lpm'],
+    'test_lpm6c.c': ['lpm'],
     'test_lpm6_perf.c': ['lpm'],
+    'test_lpm6c_perf.c': ['lpm'],
+    'test_lpm6c_perf_cmp.c': ['lpm'],
     'test_lpm_perf.c': ['net', 'lpm'],
     'test_malloc.c': [],
     'test_malloc_perf.c': [],
diff --git a/app/test/test_lpm6c.c b/app/test/test_lpm6c.c
new file mode 100644
index 0000000000..fc7d70d8e8
--- /dev/null
+++ b/app/test/test_lpm6c.c
@@ -0,0 +1,1776 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2014 Intel Corporation
+ */
+
+#include "test.h"
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_memory.h>
+#include <rte_lpm6c.h>
+
+#include "test_lpm6_data.h"
+
+#define TEST_LPM_ASSERT(cond) do { \
+	if (!(cond)) { \
+		printf("Error at line %d:\n", __LINE__); \
+		return -1; \
+	} \
+} while (0)
+
+typedef int32_t (*rte_lpm6c_test)(void);
+
+static int32_t test0(void);
+static int32_t test1(void);
+static int32_t test2(void);
+static int32_t test3(void);
+static int32_t test4(void);
+static int32_t test5(void);
+static int32_t test6(void);
+static int32_t test7(void);
+static int32_t test8(void);
+static int32_t test9(void);
+static int32_t test10(void);
+static int32_t test11(void);
+static int32_t test12(void);
+static int32_t test13(void);
+static int32_t test14(void);
+static int32_t test15(void);
+static int32_t test16(void);
+static int32_t test17(void);
+static int32_t test18(void);
+static int32_t test19(void);
+static int32_t test20(void);
+static int32_t test21(void);
+static int32_t test22(void);
+static int32_t test23(void);
+static int32_t test24(void);
+static int32_t test25(void);
+static int32_t test26(void);
+static int32_t test27(void);
+static int32_t test28(void);
+
+rte_lpm6c_test tests6c[] = {
+/* Test Cases */
+	test0,
+	test1,
+	test2,
+	test3,
+	test4,
+	test5,
+	test6,
+	test7,
+	test8,
+	test9,
+	test10,
+	test11,
+	test12,
+	test13,
+	test14,
+	test15,
+	test16,
+	test17,
+	test18,
+	test19,
+	test20,
+	test21,
+	test22,
+	test23,
+	test24,
+	test25,
+	test26,
+	test27,
+	test28,
+};
+
+#define MAX_DEPTH                                                    128
+#define MAX_RULES                                                1000000
+#define NUMBER_TBL8S                                           (1 << 16)
+#define MAX_NUM_TBL8S                                          (1 << 21)
+#define PASS 0
+
+/*
+ * Check that rte_lpm6c_create fails gracefully for incorrect user input
+ * arguments
+ */
+int32_t
+test0(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_create: lpm name == NULL */
+	lpm = rte_lpm6c_create(NULL, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm == NULL);
+
+	/* rte_lpm6c_create: max_rules = 0 */
+	/* Note: __func__ inserts the function name, in this case "test0". */
+	config.max_rules = 0;
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm == NULL);
+
+	/* socket_id < -1 is invalid */
+	config.max_rules = MAX_RULES;
+	lpm = rte_lpm6c_create(__func__, -2, &config);
+	TEST_LPM_ASSERT(lpm == NULL);
+
+	/* rte_lpm6c_create: number_tbl8s is bigger than the maximum */
+	config.number_tbl8s = MAX_NUM_TBL8S + 1;
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm == NULL);
+
+	/* rte_lpm6c_create: config = NULL */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, NULL);
+	TEST_LPM_ASSERT(lpm == NULL);
+
+	return PASS;
+}
+
+/*
+ * Creates two different LPM tables. Tries to create a third one with the same
+ * name as the first one and expects the create function to return the same
+ * pointer.
+ */
+int32_t
+test1(void)
+{
+	struct rte_lpm6c *lpm1 = NULL, *lpm2 = NULL, *lpm3 = NULL;
+	struct rte_lpm6c_config config;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_create: lpm name == LPM1 */
+	lpm1 = rte_lpm6c_create("LPM1", SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm1 != NULL);
+
+	/* rte_lpm6c_create: lpm name == LPM2 */
+	lpm2 = rte_lpm6c_create("LPM2", SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm2 != NULL);
+
+	/* rte_lpm6c_create: lpm name == LPM2 */
+	lpm3 = rte_lpm6c_create("LPM1", SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm3 == NULL);
+
+	rte_lpm6c_free(lpm1);
+	rte_lpm6c_free(lpm2);
+
+	return PASS;
+}
+
+/*
+ * Create lpm table then delete lpm table 20 times
+ * Use a slightly different rules size each time
+ */
+int32_t
+test2(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	int32_t i;
+
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_free: Free NULL */
+	for (i = 0; i < 20; i++) {
+		config.max_rules = MAX_RULES - i;
+		lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+		TEST_LPM_ASSERT(lpm != NULL);
+
+		rte_lpm6c_free(lpm);
+	}
+
+	/* Can not test free so return success */
+	return PASS;
+}
+
+/*
+ * Call rte_lpm6c_free for NULL pointer user input. Note: free has no return and
+ * therefore it is impossible to check for failure but this test is added to
+ * increase function coverage metrics and to validate that freeing null does
+ * not crash.
+ */
+int32_t
+test3(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	rte_lpm6c_free(lpm);
+	rte_lpm6c_free(NULL);
+	return PASS;
+}
+
+/*
+ * Check that rte_lpm6c_add fails gracefully for incorrect user input arguments
+ */
+int32_t
+test4(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth = 24, next_hop = 100;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_add: lpm == NULL */
+	status = rte_lpm6c_add(NULL, &ip, depth, next_hop);
+	TEST_LPM_ASSERT(status < 0);
+
+	/*Create valid lpm to use in rest of test. */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* rte_lpm6c_add: depth < 1 */
+	status = rte_lpm6c_add(lpm, &ip, 0, next_hop);
+	TEST_LPM_ASSERT(status < 0);
+
+	/* rte_lpm6c_add: depth > MAX_DEPTH */
+	status = rte_lpm6c_add(lpm, &ip, (MAX_DEPTH + 1), next_hop);
+	TEST_LPM_ASSERT(status < 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Check that rte_lpm6c_delete fails gracefully for incorrect user input
+ * arguments
+ */
+int32_t
+test5(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth = 24;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm_delete: lpm == NULL */
+	status = rte_lpm6c_delete(NULL, &ip, depth);
+	TEST_LPM_ASSERT(status < 0);
+
+	/*Create valid lpm to use in rest of test. */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* rte_lpm_delete: depth < 1 */
+	status = rte_lpm6c_delete(lpm, &ip, 0);
+	TEST_LPM_ASSERT(status < 0);
+
+	/* rte_lpm_delete: depth > MAX_DEPTH */
+	status = rte_lpm6c_delete(lpm, &ip, (MAX_DEPTH + 1));
+	TEST_LPM_ASSERT(status < 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Check that rte_lpm6c_lookup fails gracefully for incorrect user input
+ * arguments
+ */
+int32_t
+test6(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint32_t next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_lookup: lpm == NULL */
+	status = rte_lpm6c_lookup(NULL, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status < 0);
+
+	/*Create valid lpm to use in rest of test. */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* rte_lpm6c_lookup: ip = NULL */
+	status = rte_lpm6c_lookup(lpm, NULL, &next_hop_return);
+	TEST_LPM_ASSERT(status < 0);
+
+	/* rte_lpm6c_lookup: next_hop = NULL */
+	status = rte_lpm6c_lookup(lpm, &ip, NULL);
+	TEST_LPM_ASSERT(status < 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Checks that rte_lpm6c_lookup_bulk fails gracefully for incorrect user
+ * input arguments
+ */
+int32_t
+test7(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ips[10];
+	int32_t next_hop_return[10];
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_lookup: lpm == NULL */
+	status = rte_lpm6c_lookup_bulk(NULL, ips, next_hop_return, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	/*Create valid lpm to use in rest of test. */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* rte_lpm6c_lookup: ip = NULL */
+	status = rte_lpm6c_lookup_bulk(lpm, NULL, next_hop_return, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	/* rte_lpm6c_lookup: next_hop = NULL */
+	status = rte_lpm6c_lookup_bulk(lpm, ips, NULL, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Checks that rte_lpm6c_delete_bulk_func fails gracefully for incorrect user
+ * input arguments
+ */
+int32_t
+test8(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ips[10];
+	uint8_t depth[10];
+	int32_t status = 0;
+
+	memset(ips, 0, sizeof(ips));
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* rte_lpm6c_delete: lpm == NULL */
+	status = rte_lpm6c_delete_bulk_func(NULL, ips, depth, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	/*Create valid lpm to use in rest of test. */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* rte_lpm6c_delete: ip = NULL */
+	status = rte_lpm6c_delete_bulk_func(lpm, NULL, depth, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	/* rte_lpm6c_delete: next_hop = NULL */
+	status = rte_lpm6c_delete_bulk_func(lpm, ips, NULL, RTE_DIM(ips));
+	TEST_LPM_ASSERT(status < 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Call add, lookup and delete for a single rule with depth < 24.
+ * Check all the combinations for the first three bytes that result in a hit.
+ * Delete the rule and check that the same test returns a miss.
+ */
+int32_t
+test9(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth = 16;
+	uint32_t next_hop_add = 100, next_hop_return = 0;
+	int32_t status = 0;
+	uint8_t i;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	for (i = 0; i < UINT8_MAX; i++) {
+		ip.a[2] = i;
+		status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+		TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+	}
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	for (i = 0; i < UINT8_MAX; i++) {
+		ip.a[2] = i;
+		status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+		TEST_LPM_ASSERT(status == -ENOENT);
+	}
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Adds max_rules + 1 and expects a failure. Deletes a rule, then adds
+ * another one and expects success.
+ */
+int32_t
+test10(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth;
+	uint32_t next_hop_add = 100;
+	int32_t status = 0;
+	int i;
+
+	config.max_rules = 127;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	for (i = 1; i < 128; i++) {
+		depth = (uint8_t)i;
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+	}
+
+	depth = 128;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == -ENOSPC);
+
+	depth = 127;
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 128;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Creates an LPM table with a small number of tbl8s and exhaust them in the
+ * middle of the process of creating a rule.
+ */
+int32_t
+test11(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth;
+	uint32_t next_hop_add = 100;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = 16;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	depth = 128;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip.a[0] = 1;
+	depth = 25;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 33;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 41;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 49;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 64;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 80;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == -ENOSPC);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Creates an LPM table with a small number of tbl8s and exhaust them in the
+ * middle of the process of adding a rule when there is already an existing rule
+ * in that position and needs to be extended.
+ */
+int32_t
+test12(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth;
+	uint32_t next_hop_add = 100;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = 15;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	depth = 128;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip.a[0] = 1;
+	depth = 41;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 49;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == -ENOSPC);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Creates an LPM table with max_rules = 2 and tries to add 3 rules.
+ * Delete one of the rules and tries to add the third one again.
+ */
+int32_t
+test13(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth;
+	uint32_t next_hop_add = 100;
+	int32_t status = 0;
+
+	config.max_rules = 2;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	depth = 1;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 2;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 3;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == -ENOSPC);
+
+	depth = 2;
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 3;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Add 2^12 routes with different first 12 bits and depth 25.
+ * Add one more route with the same depth and check that results in a failure.
+ * After that delete the last rule and create the one that was attempted to be
+ * created. This checks tbl8 exhaustion.
+ */
+int32_t
+test14(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth = 25;
+	uint32_t next_hop_add = 100;
+	int32_t status = 0;
+	int i;
+
+	config.max_rules = MAX_RULES;
+	/* To add a rule LPM must have at least MIN_TBL8_REQ_FOR_ADD == 14 tables */
+	config.number_tbl8s = 256 + 13;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	for (i = 0; i < 256; i++) {
+		ip.a[0] = (uint8_t)i;
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+	}
+
+	ip.a[0] = 255;
+	ip.a[1] = 1;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == -ENOSPC);
+
+	ip.a[0] = 255;
+	ip.a[1] = 0;
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip.a[0] = 255;
+	ip.a[1] = 1;
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Call add, lookup and delete for a single rule with depth = 24
+ */
+int32_t
+test15(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6_ADDR_UNSPEC;
+	uint8_t depth = 24;
+	uint32_t next_hop_add = 100, next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Call add, lookup and delete for a single rule with depth > 24
+ */
+int32_t
+test16(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6(0x0c0c, 0x0100, 0, 0, 0, 0, 0, 0);
+	uint8_t depth = 128;
+	uint32_t next_hop_add = 100, next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Use rte_lpm6c_add to add rules which effect only the second half of the lpm
+ * table. Use all possible depths ranging from 1..32. Set the next hop = to the
+ * depth. Check lookup hit for on every add and check for lookup miss on the
+ * first half of the lpm table after each add. Finally delete all rules going
+ * backwards (i.e. from depth = 32 ..1) and carry out a lookup after each
+ * delete. The lookup should return the next_hop_add value related to the
+ * previous depth value (i.e. depth -1).
+ */
+int32_t
+test17(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip1 =
+		RTE_IPV6(0x7fff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff, 0xffff);
+	struct rte_ipv6_addr ip2 = RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	uint8_t depth;
+	uint32_t next_hop_add, next_hop_return;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* Loop with rte_lpm6c_add. */
+	for (depth = 1; depth <= 16; depth++) {
+		/* Let the next_hop_add value = depth. Just for change. */
+		next_hop_add = depth;
+
+		status = rte_lpm6c_add(lpm, &ip2, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+
+		/* Check IP in first half of tbl24 which should be empty. */
+		status = rte_lpm6c_lookup(lpm, &ip1, &next_hop_return);
+		TEST_LPM_ASSERT(status == -ENOENT);
+
+		status = rte_lpm6c_lookup(lpm, &ip2, &next_hop_return);
+		TEST_LPM_ASSERT((status == 0) &&
+			(next_hop_return == next_hop_add));
+	}
+
+	/* Loop with rte_lpm6c_delete. */
+	for (depth = 16; depth >= 1; depth--) {
+		next_hop_add = (depth - 1);
+
+		status = rte_lpm6c_delete(lpm, &ip2, depth);
+		TEST_LPM_ASSERT(status == 0);
+
+		status = rte_lpm6c_lookup(lpm, &ip2, &next_hop_return);
+
+		if (depth != 1) {
+			TEST_LPM_ASSERT((status == 0) &&
+				(next_hop_return == next_hop_add));
+		} else {
+			TEST_LPM_ASSERT(status == -ENOENT);
+		}
+
+		status = rte_lpm6c_lookup(lpm, &ip1, &next_hop_return);
+		TEST_LPM_ASSERT(status == -ENOENT);
+	}
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * - Add & lookup to hit invalid TBL24 entry
+ * - Add & lookup to hit valid TBL24 entry not extended
+ * - Add & lookup to hit valid extended TBL24 entry with invalid TBL8 entry
+ * - Add & lookup to hit valid extended TBL24 entry with valid TBL8 entry
+ */
+int32_t
+test18(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip, ip_1, ip_2;
+	uint8_t depth, depth_1, depth_2;
+	uint32_t next_hop_add, next_hop_add_1,
+			next_hop_add_2, next_hop_return;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* Add & lookup to hit invalid TBL24 entry */
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+	next_hop_add = 100;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/* Add & lookup to hit valid TBL24 entry not extended */
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 23;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	depth = 24;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	depth = 24;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	depth = 23;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/* Add & lookup to hit valid extended TBL24 entry with invalid TBL8
+	 * entry.
+	 */
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0x0005, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/* Add & lookup to hit valid extended TBL24 entry with valid TBL8
+	 * entry
+	 */
+	ip_1 = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth_1 = 25;
+	next_hop_add_1 = 101;
+
+	ip_2 = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0x0005, 0, 0, 0, 0, 0, 0);
+	depth_2 = 32;
+	next_hop_add_2 = 102;
+
+	next_hop_return = 0;
+
+	status = rte_lpm6c_add(lpm, &ip_1, depth_1, next_hop_add_1);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_1, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add_1));
+
+	status = rte_lpm6c_add(lpm, &ip_2, depth_2, next_hop_add_2);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_2, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add_2));
+
+	status = rte_lpm6c_delete(lpm, &ip_2, depth_2);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_2, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add_1));
+
+	status = rte_lpm6c_delete(lpm, &ip_1, depth_1);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_1, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * - Add rule that covers a TBL24 range previously invalid & lookup (& delete &
+ *   lookup)
+ * - Add rule that extends a TBL24 invalid entry & lookup (& delete & lookup)
+ * - Add rule that extends a TBL24 valid entry & lookup for both rules (&
+ *   delete & lookup)
+ * - Add rule that updates the next hop in TBL24 & lookup (& delete & lookup)
+ * - Add rule that updates the next hop in TBL8 & lookup (& delete & lookup)
+ * - Delete a rule that is not present in the TBL24 & lookup
+ * - Delete a rule that is not present in the TBL8 & lookup
+ */
+int32_t
+test19(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip;
+	uint8_t depth;
+	uint32_t next_hop_add, next_hop_return;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* Add rule that covers a TBL24 range previously invalid & lookup
+	 * (& delete & lookup)
+	 */
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 16;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 25;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/*
+	 * Add rule that extends a TBL24 valid entry & lookup for both rules
+	 * (& delete & lookup)
+	 */
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0x000a, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	next_hop_add = 100;
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0x000a, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/*
+	 * Add rule that updates the next hop in TBL24 & lookup
+	 * (& delete & lookup)
+	 */
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/*
+	 * Add rule that updates the next hop in TBL8 & lookup
+	 * (& delete & lookup)
+	 */
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/* Delete a rule that is not present in the TBL24 & lookup */
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status < 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_delete_all(lpm);
+
+	/* Delete a rule that is not present in the TBL8 & lookup */
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 32;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status < 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Add two rules, lookup to hit the more specific one, lookup to hit the less
+ * specific one delete the less specific rule and lookup previous values again;
+ * add a more specific rule than the existing rule, lookup again
+ */
+int32_t
+test20(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip;
+	uint8_t depth;
+	uint32_t next_hop_add, next_hop_return;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0x000a);
+	depth = 128;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	next_hop_add = 100;
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 24;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0x000a);
+	depth = 128;
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT(status == -ENOENT);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Adds 3 rules and look them up through the lookup_bulk function.
+ * Includes in the lookup a fourth IP address that won't match
+ * and checks that the result is as expected.
+ */
+int32_t
+test21(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip_batch[4];
+	uint8_t depth;
+	uint32_t next_hop_add;
+	int32_t next_hop_return[4];
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	ip_batch[0] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0001, 0, 0, 0, 0, 0);
+	depth = 48;
+	next_hop_add = 100;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[0], depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[1] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0002, 0, 0, 0, 0, 0);
+	depth = 48;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[1], depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[2] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0003, 0, 0, 0, 0, 0);
+	depth = 48;
+	next_hop_add = 102;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[2], depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[3] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0004, 0, 0, 0, 0, 0);
+
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 4);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == 100
+			&& next_hop_return[1] == 101 && next_hop_return[2] == 102
+			&& next_hop_return[3] == -1);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Adds 5 rules and look them up.
+ * Use the delete_bulk function to delete two of them. Lookup again.
+ * Use the delete_bulk function to delete one more. Lookup again.
+ * Use the delete_bulk function to delete two more, one invalid. Lookup again.
+ * Use the delete_bulk function to delete the remaining one. Lookup again.
+ */
+int32_t
+test22(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip_batch[5];
+	uint8_t depth[5];
+	uint32_t next_hop_add;
+	int32_t next_hop_return[5];
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* Adds 5 rules and look them up */
+
+	ip_batch[0] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0001, 0, 0, 0, 0, 0);
+	depth[0] = 48;
+	next_hop_add = 101;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[0], depth[0], next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[1] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0002, 0, 0, 0, 0, 0);
+	depth[1] = 48;
+	next_hop_add = 102;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[1], depth[1], next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[2] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0003, 0, 0, 0, 0, 0);
+	depth[2] = 48;
+	next_hop_add = 103;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[2], depth[2], next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[3] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0004, 0, 0, 0, 0, 0);
+	depth[3] = 48;
+	next_hop_add = 104;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[3], depth[3], next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[4] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0005, 0, 0, 0, 0, 0);
+	depth[4] = 48;
+	next_hop_add = 105;
+
+	status = rte_lpm6c_add(lpm, &ip_batch[4], depth[4], next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 5);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == 101
+			&& next_hop_return[1] == 102 && next_hop_return[2] == 103
+			&& next_hop_return[3] == 104 && next_hop_return[4] == 105);
+
+	/* Use the delete_bulk function to delete two of them. Lookup again */
+
+	status = rte_lpm6c_delete_bulk_func(lpm, &ip_batch[0], depth, 2);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 5);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == -1
+			&& next_hop_return[1] == -1 && next_hop_return[2] == 103
+			&& next_hop_return[3] == 104 && next_hop_return[4] == 105);
+
+	/* Use the delete_bulk function to delete one more. Lookup again */
+
+	status = rte_lpm6c_delete_bulk_func(lpm, &ip_batch[2], depth, 1);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 5);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == -1
+			&& next_hop_return[1] == -1 && next_hop_return[2] == -1
+			&& next_hop_return[3] == 104 && next_hop_return[4] == 105);
+
+	/* Use the delete_bulk function to delete two, one invalid. Lookup again */
+
+	ip_batch[4] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0006, 0, 0, 0, 0, 0);
+	status = rte_lpm6c_delete_bulk_func(lpm, &ip_batch[3], depth, 2);
+	TEST_LPM_ASSERT(status == 0);
+
+	ip_batch[4] = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0x0005, 0, 0, 0, 0, 0);
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 5);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == -1
+			&& next_hop_return[1] == -1 && next_hop_return[2] == -1
+			&& next_hop_return[3] == -1 && next_hop_return[4] == 105);
+
+	/* Use the delete_bulk function to delete the remaining one. Lookup again */
+
+	status = rte_lpm6c_delete_bulk_func(lpm, &ip_batch[4], depth, 1);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup_bulk(lpm, ip_batch,
+			next_hop_return, 5);
+	TEST_LPM_ASSERT(status == 0 && next_hop_return[0] == -1
+			&& next_hop_return[1] == -1 && next_hop_return[2] == -1
+			&& next_hop_return[3] == -1 && next_hop_return[4] == -1);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Add an extended rule (i.e. depth greater than 24, lookup (hit), delete,
+ * lookup (miss) in a for loop of 30 times. This will check tbl8 extension
+ * and contraction.
+ */
+int32_t
+test23(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	uint32_t i;
+	struct rte_ipv6_addr ip;
+	uint8_t depth;
+	uint32_t next_hop_add, next_hop_return;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	ip = (struct rte_ipv6_addr)RTE_IPV6(0x8000, 0, 0, 0, 0, 0, 0, 0);
+	depth = 128;
+	next_hop_add = 100;
+
+	for (i = 0; i < 30; i++) {
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+
+		status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+		TEST_LPM_ASSERT((status == 0) &&
+				(next_hop_return == next_hop_add));
+
+		status = rte_lpm6c_delete(lpm, &ip, depth);
+		TEST_LPM_ASSERT(status == 0);
+
+		status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+		TEST_LPM_ASSERT(status == -ENOENT);
+	}
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Sequence of operations for find existing lpm table
+ *
+ *  - create table
+ *  - find existing table: hit
+ *  - find non-existing table: miss
+ */
+int32_t
+test24(void)
+{
+	struct rte_lpm6c *lpm = NULL, *result = NULL;
+	struct rte_lpm6c_config config;
+
+	config.max_rules = 256 * 32;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	/* Create lpm  */
+	lpm = rte_lpm6c_create("lpm_find_existing", SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* Try to find existing lpm */
+	result = rte_lpm6c_find_existing("lpm_find_existing");
+	TEST_LPM_ASSERT(result == lpm);
+
+	/* Try to find non-existing lpm */
+	result = rte_lpm6c_find_existing("lpm_find_non_existing");
+	TEST_LPM_ASSERT(result == NULL);
+
+	/* Cleanup. */
+	rte_lpm6c_delete_all(lpm);
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Add a set of random routes with random depths.
+ * Lookup different IP addresses that match the routes previously added.
+ * Checks that the next hop is the expected one.
+ * The routes, IP addresses and expected result for every case have been
+ * precalculated by using a python script and stored in a .h file.
+ */
+int32_t
+test25(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip;
+	uint32_t i;
+	uint8_t depth;
+	uint32_t next_hop_add, next_hop_return, next_hop_expected;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	for (i = 0; i < 1000; i++) {
+		ip = large_route_table[i].ip;
+		depth = large_route_table[i].depth;
+		next_hop_add = large_route_table[i].next_hop;
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+	}
+
+	/* generate large IPS table and expected next_hops */
+	generate_large_ips_table(1);
+
+	for (i = 0; i < 100000; i++) {
+		ip = large_ips_table[i].ip;
+		next_hop_expected = large_ips_table[i].next_hop;
+
+		status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+		TEST_LPM_ASSERT((status == 0) &&
+				(next_hop_return == next_hop_expected));
+	}
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Test for overwriting of tbl8:
+ *  - add rule /32 and lookup
+ *  - add new rule /24 and lookup
+ *	- add third rule /25 and lookup
+ *	- lookup /32 and /24 rule to ensure the table has not been overwritten.
+ */
+int32_t
+test26(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip_10_32 = RTE_IPV6(0x0a0a, 0x0a02, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr ip_10_24 = RTE_IPV6(0x0a0a, 0x0a00, 0, 0, 0, 0, 0, 0);
+	struct rte_ipv6_addr ip_20_25 = RTE_IPV6(0x0a0a, 0x1402, 0, 0, 0, 0, 0, 0);
+	uint8_t d_ip_10_32 = 32;
+	uint8_t	d_ip_10_24 = 24;
+	uint8_t	d_ip_20_25 = 25;
+	uint32_t next_hop_ip_10_32 = 100;
+	uint32_t next_hop_ip_10_24 = 105;
+	uint32_t next_hop_ip_20_25 = 111;
+	uint32_t next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip_10_32, d_ip_10_32, next_hop_ip_10_32);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_10_32, &next_hop_return);
+	uint32_t test_hop_10_32 = next_hop_return;
+	TEST_LPM_ASSERT(status == 0);
+	TEST_LPM_ASSERT(next_hop_return == next_hop_ip_10_32);
+
+	status = rte_lpm6c_add(lpm, &ip_10_24, d_ip_10_24, next_hop_ip_10_24);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_10_24, &next_hop_return);
+	uint32_t test_hop_10_24 = next_hop_return;
+	TEST_LPM_ASSERT(status == 0);
+	TEST_LPM_ASSERT(next_hop_return == next_hop_ip_10_24);
+
+	status = rte_lpm6c_add(lpm, &ip_20_25, d_ip_20_25, next_hop_ip_20_25);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip_20_25, &next_hop_return);
+	uint32_t test_hop_20_25 = next_hop_return;
+	TEST_LPM_ASSERT(status == 0);
+	TEST_LPM_ASSERT(next_hop_return == next_hop_ip_20_25);
+
+	if (test_hop_10_32 == test_hop_10_24) {
+		printf("Next hop return equal\n");
+		return -1;
+	}
+
+	if (test_hop_10_24 == test_hop_20_25) {
+		printf("Next hop return equal\n");
+		return -1;
+	}
+
+	status = rte_lpm6c_lookup(lpm, &ip_10_32, &next_hop_return);
+	TEST_LPM_ASSERT(status == 0);
+	TEST_LPM_ASSERT(next_hop_return == next_hop_ip_10_32);
+
+	status = rte_lpm6c_lookup(lpm, &ip_10_24, &next_hop_return);
+	TEST_LPM_ASSERT(status == 0);
+	TEST_LPM_ASSERT(next_hop_return == next_hop_ip_10_24);
+
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Add a rule that reaches the end of the tree.
+ * Add a rule that is more generic than the first one.
+ * Check every possible combination that produces a match for the second rule.
+ * This tests tbl expansion.
+ */
+int32_t
+test27(void)
+{
+		struct rte_lpm6c *lpm = NULL;
+		struct rte_lpm6c_config config;
+		struct rte_ipv6_addr ip =
+			RTE_IPV6(0x8080, 0x8080, 0x8080, 0x8080, 0x8080, 0x8080, 0x8080, 0);
+		uint8_t depth = 128;
+		uint32_t next_hop_add = 100, next_hop_return;
+		int32_t status = 0;
+		int i, j;
+
+		config.max_rules = MAX_RULES;
+		config.number_tbl8s = NUMBER_TBL8S;
+		config.flags = 0;
+
+		lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+		TEST_LPM_ASSERT(lpm != NULL);
+
+		depth = 128;
+		next_hop_add = 128;
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+
+		depth = 112;
+		next_hop_add = 112;
+		status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+		TEST_LPM_ASSERT(status == 0);
+
+		for (i = 0; i < 256; i++) {
+			ip.a[14] = i;
+			for (j = 0; j < 256; j++) {
+				ip.a[15] = j;
+				status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+				if (i == 0 && j == 0)
+					TEST_LPM_ASSERT(status == 0 && next_hop_return == 128);
+				else
+					TEST_LPM_ASSERT(status == 0 && next_hop_return == 112);
+				}
+		}
+
+		rte_lpm6c_free(lpm);
+
+		return PASS;
+}
+
+/*
+ * Call add, lookup and delete for a single rule with maximum 21bit next_hop
+ * size.
+ * Check that next_hop returned from lookup is equal to provisioned value.
+ * Delete the rule and check that the same test returns a miss.
+ */
+int32_t
+test28(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	struct rte_ipv6_addr ip = RTE_IPV6(0, 0, 0, 0, 0, 0, 0, 0);
+	uint8_t depth = 16;
+	uint32_t next_hop_add = 0x001FFFFF, next_hop_return = 0;
+	int32_t status = 0;
+
+	config.max_rules = MAX_RULES;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	status = rte_lpm6c_add(lpm, &ip, depth, next_hop_add);
+	TEST_LPM_ASSERT(status == 0);
+
+	status = rte_lpm6c_lookup(lpm, &ip, &next_hop_return);
+	TEST_LPM_ASSERT((status == 0) && (next_hop_return == next_hop_add));
+
+	status = rte_lpm6c_delete(lpm, &ip, depth);
+	TEST_LPM_ASSERT(status == 0);
+	rte_lpm6c_free(lpm);
+
+	return PASS;
+}
+
+/*
+ * Do all unit tests.
+ */
+static int
+test_lpm6c(void)
+{
+	unsigned int i;
+	int status = -1, global_status = 0;
+
+	for (i = 0; i < RTE_DIM(tests6c); i++) {
+		printf("# test %02d\n", i);
+		status = tests6c[i]();
+
+		if (status < 0) {
+			printf("ERROR: LPM Test %s: FAIL\n", RTE_STR(tests6c[i]));
+			global_status = status;
+		}
+	}
+
+	return global_status;
+}
+
+REGISTER_FAST_TEST(lpm6c_autotest, true, true, test_lpm6c);
diff --git a/app/test/test_lpm6c_perf.c b/app/test/test_lpm6c_perf.c
new file mode 100644
index 0000000000..a81aaa8836
--- /dev/null
+++ b/app/test/test_lpm6c_perf.c
@@ -0,0 +1,161 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2010-2014 Intel Corporation
+ */
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_cycles.h>
+#include <rte_random.h>
+#include <rte_memory.h>
+#include <rte_lpm6c.h>
+
+#include "test.h"
+#include "test_lpm6_data.h"
+
+#define TEST_LPM_ASSERT(cond) do { \
+	if (!(cond)) { \
+		printf("Error at line %d:\n", __LINE__); \
+		return -1; \
+	} \
+} while (0)
+
+#define ITERATIONS (1 << 10)
+#define BATCH_SIZE 100000
+#define NUMBER_TBL8S (1 << 16)
+
+static void
+print_route_distribution(const struct rules_tbl_entry *table, uint32_t n)
+{
+	unsigned int i, j;
+
+	printf("Route distribution per prefix width:\n");
+	printf("DEPTH    QUANTITY (PERCENT)\n");
+	printf("---------------------------\n");
+
+	/* Count depths. */
+	for (i = 1; i <= 128; i++) {
+		unsigned int depth_counter = 0;
+		double percent_hits;
+
+		for (j = 0; j < n; j++)
+			if (table[j].depth == (uint8_t) i)
+				depth_counter++;
+
+		percent_hits = ((double)depth_counter)/((double)n) * 100;
+		printf("%.2u%15u (%.2f)\n", i, depth_counter, percent_hits);
+	}
+	printf("\n");
+}
+
+static int
+test_lpm6c_perf(void)
+{
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_lpm6c_config config;
+	uint64_t begin, total_time;
+	unsigned int i, j;
+	uint32_t next_hop_add = 0xAA, next_hop_return = 0;
+	int status = 0;
+	int64_t count = 0;
+
+	config.max_rules = 1000000;
+	config.number_tbl8s = NUMBER_TBL8S;
+	config.flags = 0;
+
+	printf("No. routes = %u\n", (unsigned int) NUM_ROUTE_ENTRIES);
+
+	print_route_distribution(large_route_table, (uint32_t) NUM_ROUTE_ENTRIES);
+
+	/* Only generate IPv6 address of each item in large IPS table,
+	 * here next_hop is not needed.
+	 */
+	generate_large_ips_table(0);
+
+	lpm = rte_lpm6c_create(__func__, SOCKET_ID_ANY, &config);
+	TEST_LPM_ASSERT(lpm != NULL);
+
+	/* Measure add. */
+	begin = rte_rdtsc();
+
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++) {
+		if (rte_lpm6c_add(lpm, &large_route_table[i].ip,
+				large_route_table[i].depth, next_hop_add) == 0)
+			status++;
+	}
+	/* End Timer. */
+	total_time = rte_rdtsc() - begin;
+
+	printf("Unique added entries = %d\n", status);
+	printf("Average LPM Add: %g cycles\n",
+			(double)total_time / NUM_ROUTE_ENTRIES);
+
+	/* Measure single Lookup */
+	total_time = 0;
+	count = 0;
+
+	for (i = 0; i < ITERATIONS; i++) {
+		begin = rte_rdtsc();
+
+		for (j = 0; j < NUM_IPS_ENTRIES; j++) {
+			if (rte_lpm6c_lookup(lpm, &large_ips_table[j].ip,
+					&next_hop_return) != 0)
+				count++;
+		}
+
+		total_time += rte_rdtsc() - begin;
+
+	}
+	printf("Average LPM Lookup: %.1f cycles (fails = %.1f%%)\n",
+			(double)total_time / ((double)ITERATIONS * BATCH_SIZE),
+			(count * 100.0) / (double)(ITERATIONS * BATCH_SIZE));
+
+	/* Measure bulk Lookup */
+	total_time = 0;
+	count = 0;
+
+	struct rte_ipv6_addr ip_batch[NUM_IPS_ENTRIES];
+	int32_t next_hops[NUM_IPS_ENTRIES];
+
+	for (i = 0; i < NUM_IPS_ENTRIES; i++)
+		ip_batch[i] = large_ips_table[i].ip;
+
+	for (i = 0; i < ITERATIONS; i++) {
+
+		/* Lookup per batch */
+		begin = rte_rdtsc();
+		rte_lpm6c_lookup_bulk(lpm, ip_batch, next_hops, NUM_IPS_ENTRIES);
+		total_time += rte_rdtsc() - begin;
+
+		for (j = 0; j < NUM_IPS_ENTRIES; j++)
+			if (next_hops[j] < 0)
+				count++;
+	}
+	printf("BULK LPM Lookup: %.1f cycles (fails = %.1f%%)\n",
+			(double)total_time / ((double)ITERATIONS * BATCH_SIZE),
+			(count * 100.0) / (double)(ITERATIONS * BATCH_SIZE));
+
+	/* Delete */
+	status = 0;
+	begin = rte_rdtsc();
+
+	for (i = 0; i < NUM_ROUTE_ENTRIES; i++) {
+		/* rte_lpm_delete(lpm, ip, depth) */
+		status += rte_lpm6c_delete(lpm, &large_route_table[i].ip,
+				large_route_table[i].depth);
+	}
+
+	total_time += rte_rdtsc() - begin;
+
+	printf("Average LPM Delete: %g cycles\n",
+			(double)total_time / NUM_ROUTE_ENTRIES);
+
+	rte_lpm6c_delete_all(lpm);
+	rte_lpm6c_free(lpm);
+
+	return 0;
+}
+
+REGISTER_PERF_TEST(lpm6c_perf_autotest, test_lpm6c_perf);
diff --git a/app/test/test_lpm6c_perf_cmp.c b/app/test/test_lpm6c_perf_cmp.c
new file mode 100644
index 0000000000..0268cb6420
--- /dev/null
+++ b/app/test/test_lpm6c_perf_cmp.c
@@ -0,0 +1,409 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2016-2025 Alex Kiselev BisonRouter.com
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <assert.h>
+#include <arpa/inet.h>
+
+#include <rte_cycles.h>
+#include <rte_random.h>
+#include <rte_memory.h>
+#include <rte_lpm6.h>
+#include <rte_lpm6c.h>
+#include <rte_fib6.h>
+#include <rte_hash.h>
+#include <rte_jhash.h>
+#include <rte_prefetch.h>
+
+#include "test.h"
+
+#define TEST_LPM_ASSERT(cond) do { \
+	if (!(cond)) { \
+		printf("Error at line %d:\n", __LINE__); \
+		return -1; \
+	} \
+} while (0)
+
+static inline void
+lpm6_test_addr_gen(uint64_t rnd, struct rte_ipv6_addr *ip, unsigned int offs)
+{
+	ip->a[offs] = (uint8_t)(rnd & 0xFF);
+	ip->a[offs + 1] = (uint8_t)((rnd & 0xFF00) >> 8);
+}
+
+static void
+lpm6_test_prefetch_test_data(unsigned int prefix_cnt, uint64_t *rand_ints)
+{
+	volatile uint64_t sum = 0;
+
+	for (unsigned int i = 0; i < prefix_cnt; i++) {
+		rte_prefetch0(&rand_ints[i]);
+		sum += rand_ints[i];
+	}
+}
+
+/*
+ * Convert a string to an ipv6 address
+ */
+static inline bool
+ipv6_str_to_addr(const char *ip6str, uint8_t *ip6)
+{
+	return inet_pton(AF_INET6, ip6str, ip6) == 1;
+}
+
+static __rte_noinline int
+rte_lpm6c_lookup_bulk_noinline_(const struct rte_lpm6c *lpm,
+		  const struct rte_ipv6_addr *ips,
+		  int32_t *next_hops, const unsigned int n)
+{
+	return rte_lpm6c_lookup_bulk(lpm, ips, next_hops, n);
+}
+
+static __rte_noinline int
+rte_lpm6c_lookup_noinline_(const struct rte_lpm6c *lpm,
+		  const struct rte_ipv6_addr *ip,
+		  uint32_t *next_hop)
+{
+	return rte_lpm6c_lookup(lpm, ip, next_hop);
+}
+
+static void
+lpm6_prefix_test(unsigned int prefix_size)
+{
+	uint32_t max_rules = 524288;
+	struct rte_lpm6_config lpm_config;
+	struct rte_lpm6c_config lpmc_config;
+	struct rte_lpm6 *lpm;
+	struct rte_lpm6c *lpm_c;
+	uint8_t depth;
+	struct rte_ipv6_addr ip;
+
+	#define LPM_LOOKUP_TEST_BULK_SIZE 32
+	const unsigned int test_rounds = 10000;
+	const unsigned int prefix_cnt = LPM_LOOKUP_TEST_BULK_SIZE * 2000;
+
+	struct rte_ipv6_addr ip_vec[LPM_LOOKUP_TEST_BULK_SIZE];
+	uint32_t next_hop_r, next_hop_cr;
+	int32_t next_hop_arr[LPM_LOOKUP_TEST_BULK_SIZE];
+	uint64_t rand_ints[prefix_cnt];
+
+	uint64_t next_hop_fr;
+	uint64_t next_hop_fr_arr[LPM_LOOKUP_TEST_BULK_SIZE];
+	int ret, ret1, ret2, ret3;
+	volatile uint64_t cnt1, cnt2, cnt3, cnt4, cnt5;
+	uint64_t t1, t2, tsum1, tsum2, tsum3, tsum4, tsum5;
+	struct rte_fib6 *fib6 = NULL;
+	struct rte_fib6_conf config;
+	unsigned int socket_id;
+	unsigned int ip_offs;
+	bool warmup_run = true;
+	struct rte_hash *uniq_addr_ht;
+
+	printf("LMP6 prefix /%u tests\n", prefix_size);
+
+	ip_offs = prefix_size / 8 - 2;
+
+	/*
+	 * Initialize LPM structures
+	 */
+	config.type = RTE_FIB6_TRIE;
+	config.max_routes = (1 << 16) - 1;
+	config.rib_ext_sz = 0;
+	config.default_nh = 0;
+	config.trie.nh_sz = RTE_FIB6_TRIE_4B;
+	config.trie.num_tbl8 = (1 << 22);
+
+	socket_id = SOCKET_ID_ANY;
+	fib6 = rte_fib6_create("fib6", socket_id, &config);
+	assert(fib6 != NULL);
+
+	lpm_config.flags = 0;
+	lpm_config.max_rules = max_rules;
+	lpm_config.number_tbl8s = 800000;
+
+	lpmc_config.flags = 0;
+	lpmc_config.max_rules = max_rules;
+	lpmc_config.number_tbl8s = 800000;
+
+	lpm = rte_lpm6_create("test", socket_id, &lpm_config);
+	assert(lpm != NULL);
+
+	lpm_c = rte_lpm6c_create("test_c", socket_id, &lpmc_config);
+	assert(lpm_c != NULL);
+
+	assert(prefix_cnt < UINT16_MAX);
+
+	/*
+	 * Init prefixes
+	 */
+	ipv6_str_to_addr("2001::", ip.a);
+	for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++)
+		ipv6_str_to_addr("2001::", ip_vec[i].a);
+	depth = prefix_size;
+
+	const struct rte_hash_parameters hash_params = {
+		.entries = prefix_cnt * 1.3,
+		.key_len = sizeof(struct rte_ipv6_addr),
+		.hash_func = rte_jhash,
+		.hash_func_init_val = 0,
+		.name = "lpm6_test_uniq_add_tb",
+		.reserved = 0,
+		.socket_id = socket_id,
+		.extra_flag = 0,
+	};
+
+	uniq_addr_ht = rte_hash_create(&hash_params);
+	assert(uniq_addr_ht != NULL);
+
+	/*
+	 * Populate LPMs
+	 */
+	for (unsigned int i = 0; i < prefix_cnt; i++) {
+		/* generate unique IPv6 addresses */
+		do {
+			rand_ints[i] = (uint64_t)rte_rand();
+			lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+		} while (rte_hash_lookup(uniq_addr_ht, (const void *)ip.a) != -ENOENT);
+		rte_hash_add_key(uniq_addr_ht, (const void *)ip.a);
+
+		ret = rte_lpm6c_add(lpm_c, &ip, depth, i + 1);
+		assert(ret == 0);
+		ret = rte_lpm6_add(lpm, &ip, depth, i + 1);
+		assert(ret == 0);
+		ret = rte_fib6_add(fib6, &ip, depth, i + 1);
+		assert(ret == 0);
+	}
+
+	/* Test correctness */
+	for (unsigned int i = 0; i < prefix_cnt; i++) {
+		lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+
+		ret1 = rte_lpm6_lookup(lpm, &ip, &next_hop_r);
+		ret2 = rte_lpm6c_lookup_noinline_(lpm_c, &ip, &next_hop_cr);
+		ret3 = rte_fib6_lookup_bulk(fib6, &ip, &next_hop_fr, 1);
+
+		assert(ret1 == ret2);
+		if (ret1 == 0) {
+			assert(next_hop_r == next_hop_cr);
+			assert(next_hop_r == next_hop_fr);
+		}
+	}
+
+	/*
+	 * Lookup performance tests
+	 */
+	tsum1 = 0;
+	tsum2 = 0;
+	tsum3 = 0;
+	tsum4 = 0;
+	tsum5 = 0;
+
+	for (unsigned int j = 0; j < test_rounds; j++) {
+		/*
+		 * LPM6
+		 */
+		lpm6_test_prefetch_test_data(prefix_cnt, rand_ints);
+		cnt1 = 0;
+
+		if (warmup_run) {
+			for (unsigned int i = 0; i < prefix_cnt; i++) {
+				lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+				next_hop_r = 0;
+				rte_lpm6_lookup(lpm, &ip, &next_hop_r);
+				cnt1 += next_hop_r;
+			}
+		}
+
+		t1 = rte_rdtsc();
+		for (unsigned int i = 0; i < prefix_cnt; i++) {
+			lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+			next_hop_r = 0;
+			rte_lpm6_lookup(lpm, &ip, &next_hop_r);
+			cnt1 += next_hop_r;
+		}
+		t2 = rte_rdtsc();
+		tsum1 += t2 - t1;
+
+		/*
+		 * LPM6 compressed
+		 */
+		lpm6_test_prefetch_test_data(prefix_cnt, rand_ints);
+		cnt2 = 0;
+
+		if (warmup_run) {
+			for (unsigned int i = 0; i < prefix_cnt; i++) {
+				lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+				next_hop_r = 0;
+				rte_lpm6c_lookup_noinline_(lpm_c, &ip, &next_hop_r);
+				cnt2 += next_hop_r;
+			}
+		}
+
+		t1 = rte_rdtsc();
+		for (unsigned int i = 0; i < prefix_cnt; i++) {
+			lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+			next_hop_r = 0;
+			rte_lpm6c_lookup_noinline_(lpm_c, &ip, &next_hop_r);
+			cnt2 += next_hop_r;
+		}
+		t2 = rte_rdtsc();
+		tsum2 += t2 - t1;
+
+		/*
+		 * LPM6 compressed bulk
+		 */
+		lpm6_test_prefetch_test_data(prefix_cnt, rand_ints);
+		cnt5 = 0;
+
+		if (warmup_run) {
+			for (unsigned int k = 0; k < prefix_cnt / LPM_LOOKUP_TEST_BULK_SIZE;
+					k++) {
+				for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++) {
+					unsigned int ind = k * LPM_LOOKUP_TEST_BULK_SIZE + i;
+					lpm6_test_addr_gen(rand_ints[ind], &ip_vec[i], ip_offs);
+				}
+
+				rte_lpm6c_lookup_bulk_noinline_(lpm_c, ip_vec, next_hop_arr,
+						  LPM_LOOKUP_TEST_BULK_SIZE);
+				for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++)
+					cnt5 += next_hop_arr[i];
+			}
+		}
+
+		t1 = rte_rdtsc();
+		for (unsigned int k = 0; k < prefix_cnt / LPM_LOOKUP_TEST_BULK_SIZE;
+				k++) {
+			for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++) {
+				unsigned int ind = k * LPM_LOOKUP_TEST_BULK_SIZE + i;
+				lpm6_test_addr_gen(rand_ints[ind], &ip_vec[i], ip_offs);
+			}
+
+			rte_lpm6c_lookup_bulk_noinline_(lpm_c, ip_vec, next_hop_arr,
+					  LPM_LOOKUP_TEST_BULK_SIZE);
+			for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++)
+				cnt5 += next_hop_arr[i];
+		}
+		t2 = rte_rdtsc();
+		tsum5 += t2 - t1;
+
+		/*
+		 * FIB
+		 */
+		lpm6_test_prefetch_test_data(prefix_cnt, rand_ints);
+		cnt3 = 0;
+
+		if (warmup_run) {
+			for (unsigned int i = 0; i < prefix_cnt; i++) {
+				lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+				next_hop_r = 0;
+				rte_fib6_lookup_bulk(fib6, &ip, &next_hop_fr, 1);
+				cnt3 += next_hop_fr;
+			}
+		}
+
+		t1 = rte_rdtsc();
+		for (unsigned int i = 0; i < prefix_cnt; i++) {
+			lpm6_test_addr_gen(rand_ints[i], &ip, ip_offs);
+			next_hop_r = 0;
+			rte_fib6_lookup_bulk(fib6, &ip, &next_hop_fr, 1);
+			cnt3 += next_hop_fr;
+		}
+		t2 = rte_rdtsc();
+		tsum3 += t2 - t1;
+
+		/*
+		 * FIB bulk
+		 */
+		lpm6_test_prefetch_test_data(prefix_cnt, rand_ints);
+		cnt4 = 0;
+
+		if (warmup_run) {
+			for (unsigned int k = 0; k < prefix_cnt / LPM_LOOKUP_TEST_BULK_SIZE;
+					k++) {
+				for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++) {
+					unsigned int ind = k * LPM_LOOKUP_TEST_BULK_SIZE + i;
+					lpm6_test_addr_gen(rand_ints[ind], &ip_vec[i], ip_offs);
+				}
+
+				ret3 = rte_fib6_lookup_bulk(fib6, ip_vec, next_hop_fr_arr,
+						  LPM_LOOKUP_TEST_BULK_SIZE);
+				for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++)
+					cnt4 += next_hop_fr_arr[i];
+				assert(ret3 == 0);
+			}
+		}
+
+		t1 = rte_rdtsc();
+		for (unsigned int k = 0; k < prefix_cnt / LPM_LOOKUP_TEST_BULK_SIZE;
+				k++) {
+			for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++) {
+				unsigned int ind = k * LPM_LOOKUP_TEST_BULK_SIZE + i;
+				lpm6_test_addr_gen(rand_ints[ind], &ip_vec[i], ip_offs);
+			}
+
+			ret3 = rte_fib6_lookup_bulk(fib6, ip_vec, next_hop_fr_arr,
+					  LPM_LOOKUP_TEST_BULK_SIZE);
+			for (unsigned int i = 0; i < LPM_LOOKUP_TEST_BULK_SIZE; i++)
+				cnt4 += next_hop_fr_arr[i];
+			assert(ret3 == 0);
+		}
+		t2 = rte_rdtsc();
+		tsum4 += t2 - t1;
+	}
+
+	assert(cnt1 == cnt2);
+	assert(cnt1 == cnt3);
+	assert(cnt1 == cnt4);
+	assert(cnt1 == cnt5);
+
+	printf("Speedup vs LPM6: LPM6c %.3fx, LPM6c VEC %.3fx, FIB %.3fx, "
+			  "FIB VEC %.3fx\n",
+			  (double)tsum1 / tsum2,
+			  (double)tsum1 / tsum5,
+			  (double)tsum1 / tsum3,
+			  (double)tsum1 / tsum4);
+
+	rte_lpm6_free(lpm);
+	rte_lpm6c_free(lpm_c);
+	rte_fib6_free(fib6);
+	rte_hash_free(uniq_addr_ht);
+}
+
+static int
+test_lpm6c_perf_cmp(void)
+{
+	unsigned int cnt = 1;
+
+	printf("Starting LPM6 performance comparison tests\n");
+
+	for (unsigned int i = 1; i <= cnt; i++) {
+		printf("=== run %u/32 ===\n", i);
+		lpm6_prefix_test(32);
+	}
+	for (unsigned int i = 1; i <= cnt; i++) {
+		printf("=== run %u/48 ===\n", i);
+		lpm6_prefix_test(48);
+	}
+	for (unsigned int i = 1; i <= cnt; i++) {
+		printf("=== run %u/64 ===\n", i);
+		lpm6_prefix_test(64);
+	}
+	for (unsigned int i = 1; i <= cnt; i++) {
+		printf("=== run %u/80 ===\n", i);
+		lpm6_prefix_test(80);
+	}
+	for (unsigned int i = 1; i <= cnt; i++) {
+		printf("=== run %u/128 ===\n", i);
+		lpm6_prefix_test(128);
+	}
+
+	return 0;
+}
+
+REGISTER_PERF_TEST(lpm6c_perf_cmp_autotest, test_lpm6c_perf_cmp);
diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index c4522eaf0c..4fdf408898 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2017 Intel Corporation
 
-sources = files('rte_lpm.c', 'rte_lpm6.c')
-headers = files('rte_lpm.h', 'rte_lpm6.h')
+sources = files('rte_lpm.c', 'rte_lpm6.c', 'rte_lpm6c.c')
+headers = files('rte_lpm.h', 'rte_lpm6.h', 'rte_lpm6c.h')
 # since header files have different names, we can install all vector headers
 # without worrying about which architecture we actually need
 indirect_headers += files(
diff --git a/lib/lpm/rte_lpm6c.c b/lib/lpm/rte_lpm6c.c
new file mode 100644
index 0000000000..1c28e3cd54
--- /dev/null
+++ b/lib/lpm/rte_lpm6c.c
@@ -0,0 +1,1320 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
+ */
+#include <string.h>
+#include <stdint.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <sys/queue.h>
+
+#include <rte_log.h>
+#include <rte_branch_prediction.h>
+#include <rte_common.h>
+#include <rte_memory.h>
+#include <rte_malloc.h>
+#include <rte_memcpy.h>
+#include <rte_eal.h>
+#include <rte_eal_memconfig.h>
+#include <rte_per_lcore.h>
+#include <rte_string_fns.h>
+#include <rte_errno.h>
+#include <rte_rwlock.h>
+#include <rte_spinlock.h>
+#include <rte_hash.h>
+#include <assert.h>
+#include <rte_jhash.h>
+#include <rte_tailq.h>
+#include <rte_ip6.h>
+#include "lpm_log.h"
+#include "rte_lpm6c.h"
+
+#define RULE_HASH_TABLE_EXTRA_SPACE              64
+#define TBL24_IND                        UINT32_MAX
+
+TAILQ_HEAD(rte_lpm6c_list, rte_tailq_entry);
+
+static struct rte_tailq_elem rte_lpm6c_tailq = {
+	.name = "RTR_LPM6C",
+};
+EAL_REGISTER_TAILQ(rte_lpm6c_tailq)
+
+/*
+ * Convert a depth to a one byte long mask
+ *   Example: 4 will be converted to 0xF0
+ */
+static uint8_t __rte_pure
+depth_to_mask_1b(uint8_t depth)
+{
+	/* To calculate a mask start with a 1 on the left hand side and right
+	 * shift while populating the left hand side with 1's
+	 */
+	return (signed char)0x80 >> (depth - 1);
+}
+
+/*
+ * LPM6 rule hash function
+ *
+ * It's used as a hash function for the rte_hash
+ *	containing rules
+ */
+static inline uint32_t
+rule_hash(const void *data, __rte_unused uint32_t data_len,
+		  uint32_t init_val)
+{
+	return rte_jhash(data, sizeof(struct rte_lpm6c_rule_key), init_val);
+}
+
+/*
+ * Init pool of free tbl8 indexes
+ */
+static void
+tbl8_pool_init(struct rte_lpm6c *lpm)
+{
+	uint32_t i;
+
+	/* put entire range of indexes to the tbl8 pool */
+	for (i = 0; i < lpm->number_tbl8s; i++)
+		lpm->tbl8_pool[i] = i;
+
+	lpm->tbl8_pool_pos = 0;
+}
+
+/*
+ * Get an index of a free tbl8 from the pool
+ */
+static inline uint32_t
+tbl8_get(struct rte_lpm6c *lpm, uint32_t *tbl8_ind)
+{
+	if (lpm->tbl8_pool_pos == lpm->number_tbl8s)
+		/* no more free tbl8 */
+		return -ENOSPC;
+
+	/* next index */
+	*tbl8_ind = lpm->tbl8_pool[lpm->tbl8_pool_pos++];
+	return 0;
+}
+
+/*
+ * Put an index of a free tbl8 back to the pool
+ */
+static inline uint32_t
+tbl8_put(struct rte_lpm6c *lpm, uint32_t tbl8_ind)
+{
+	if (lpm->tbl8_pool_pos == 0)
+		/* pool is full */
+		return -ENOSPC;
+
+	lpm->tbl8_pool[--lpm->tbl8_pool_pos] = tbl8_ind;
+	return 0;
+}
+
+/*
+ * Init a rule key.
+ *	  note that ip must be already masked
+ */
+static inline void
+rule_key_init(struct rte_lpm6c_rule_key *key, const struct rte_ipv6_addr *ip,
+		  uint8_t depth)
+{
+	key->ip = *ip;
+	key->depth = depth;
+}
+
+/*
+ * Allocates memory for LPM object
+ */
+struct rte_lpm6c *
+rte_lpm6c_create(const char *name, int socket_id,
+		const struct rte_lpm6c_config *config)
+{
+	char mem_name[RTE_LPM6C_NAMESIZE];
+	struct rte_lpm6c *lpm = NULL;
+	struct rte_tailq_entry *te;
+	uint64_t mem_size;
+	struct rte_lpm6c_list *lpm_list;
+	struct rte_hash *rules_tbl = NULL;
+	uint32_t *tbl8_pool = NULL;
+	struct rte_lpm6c_tbl8_hdr *tbl8_hdrs = NULL;
+
+	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
+
+	RTE_BUILD_BUG_ON(sizeof(struct rte_lpm6c_tbl_entry) != sizeof(uint32_t));
+
+	/* Check user arguments. */
+	if ((name == NULL) || (socket_id < -1) || (config == NULL) ||
+			(config->max_rules == 0) ||
+			config->number_tbl8s > RTE_LPM6C_TBL8_MAX_NUM_GROUPS) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	/* create rules hash table */
+	snprintf(mem_name, sizeof(mem_name), "LRH_%s", name);
+	struct rte_hash_parameters rule_hash_tbl_params = {
+		.entries = config->max_rules * 1.2 +
+			RULE_HASH_TABLE_EXTRA_SPACE,
+		.key_len = sizeof(struct rte_lpm6c_rule_key),
+		.hash_func = rule_hash,
+		.hash_func_init_val = 0,
+		.name = mem_name,
+		.reserved = 0,
+		.socket_id = socket_id,
+		.extra_flag = 0
+	};
+
+	rules_tbl = rte_hash_create(&rule_hash_tbl_params);
+	if (rules_tbl == NULL) {
+		LPM_LOG(ERR, "LPM rules hash table allocation failed: %s (%d)",
+				  rte_strerror(rte_errno), rte_errno);
+		goto fail_wo_unlock;
+	}
+
+	/* allocate tbl8 indexes pool */
+	tbl8_pool = rte_malloc(NULL,
+			sizeof(uint32_t) * config->number_tbl8s,
+			RTE_CACHE_LINE_SIZE);
+	if (tbl8_pool == NULL) {
+		LPM_LOG(ERR, "LPM tbl8 pool allocation failed: %s (%d)",
+				  rte_strerror(rte_errno), rte_errno);
+		rte_errno = ENOMEM;
+		goto fail_wo_unlock;
+	}
+
+	/* allocate tbl8 headers */
+	tbl8_hdrs = rte_malloc(NULL,
+			sizeof(struct rte_lpm6c_tbl8_hdr) * config->number_tbl8s,
+			RTE_CACHE_LINE_SIZE);
+	if (tbl8_hdrs == NULL) {
+		LPM_LOG(ERR, "LPM tbl8 headers allocation failed: %s (%d)",
+				  rte_strerror(rte_errno), rte_errno);
+		rte_errno = ENOMEM;
+		goto fail_wo_unlock;
+	}
+
+	snprintf(mem_name, sizeof(mem_name), "LPM_%s", name);
+
+	/* Determine the amount of memory to allocate. */
+	mem_size = sizeof(*lpm) + (sizeof(lpm->tbl8[0]) * config->number_tbl8s);
+
+	rte_mcfg_tailq_write_lock();
+
+	/* Guarantee there's no existing */
+	TAILQ_FOREACH(te, lpm_list, next) {
+		lpm = (struct rte_lpm6c *) te->data;
+		if (strncmp(name, lpm->name, RTE_LPM6C_NAMESIZE) == 0)
+			break;
+	}
+	lpm = NULL;
+	if (te != NULL) {
+		rte_errno = EEXIST;
+		goto fail;
+	}
+
+	/* allocate tailq entry */
+	te = rte_zmalloc("LPM6_TAILQ_ENTRY", sizeof(*te), 0);
+	if (te == NULL) {
+		LPM_LOG(ERR, "Failed to allocate tailq entry!");
+		rte_errno = ENOMEM;
+		goto fail;
+	}
+
+	/* Allocate memory to store the LPM data structures. */
+	lpm = rte_zmalloc_socket(mem_name, (size_t)mem_size,
+			RTE_CACHE_LINE_SIZE, socket_id);
+
+	if (lpm == NULL) {
+		LPM_LOG(ERR, "LPM memory allocation failed");
+		rte_free(te);
+		rte_errno = ENOMEM;
+		goto fail;
+	}
+
+	/* Save user arguments. */
+	lpm->max_rules = config->max_rules;
+	lpm->number_tbl8s = config->number_tbl8s;
+	snprintf(lpm->name, sizeof(lpm->name), "%s", name);
+	lpm->rules_tbl = rules_tbl;
+	lpm->tbl8_pool = tbl8_pool;
+	lpm->tbl8_hdrs = tbl8_hdrs;
+
+	/* init the stack */
+	tbl8_pool_init(lpm);
+
+	te->data = (void *) lpm;
+
+	TAILQ_INSERT_TAIL(lpm_list, te, next);
+	rte_mcfg_tailq_write_unlock();
+	return lpm;
+
+fail:
+	rte_mcfg_tailq_write_unlock();
+
+fail_wo_unlock:
+	rte_free(tbl8_hdrs);
+	rte_free(tbl8_pool);
+	rte_hash_free(rules_tbl);
+
+	return NULL;
+}
+
+/*
+ * Find an existing lpm table and return a pointer to it.
+ */
+struct rte_lpm6c *
+rte_lpm6c_find_existing(const char *name)
+{
+	struct rte_lpm6c *l = NULL;
+	struct rte_tailq_entry *te;
+	struct rte_lpm6c_list *lpm_list;
+
+	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
+
+	rte_mcfg_tailq_read_lock();
+	TAILQ_FOREACH(te, lpm_list, next) {
+		l = (struct rte_lpm6c *) te->data;
+		if (strncmp(name, l->name, RTE_LPM6C_NAMESIZE) == 0)
+			break;
+	}
+	rte_mcfg_tailq_read_unlock();
+
+	if (te == NULL) {
+		rte_errno = ENOENT;
+		return NULL;
+	}
+
+	return l;
+}
+
+/*
+ * De-allocates memory for given LPM table.
+ */
+void
+rte_lpm6c_free(struct rte_lpm6c *lpm)
+{
+	struct rte_lpm6c_list *lpm_list;
+	struct rte_tailq_entry *te;
+
+	/* Check user arguments. */
+	if (lpm == NULL)
+		return;
+
+	lpm_list = RTE_TAILQ_CAST(rte_lpm6c_tailq.head, rte_lpm6c_list);
+
+	rte_mcfg_tailq_write_lock();
+
+	/* find our tailq entry */
+	TAILQ_FOREACH(te, lpm_list, next) {
+		if (te->data == (void *) lpm)
+			break;
+	}
+
+	if (te != NULL)
+		TAILQ_REMOVE(lpm_list, te, next);
+
+	rte_mcfg_tailq_write_unlock();
+
+	rte_free(lpm->tbl8_hdrs);
+	rte_free(lpm->tbl8_pool);
+	rte_hash_free(lpm->rules_tbl);
+	rte_free(lpm);
+	rte_free(te);
+}
+
+/* Find a rule */
+static inline int
+rule_find_with_key(struct rte_lpm6c *lpm,
+		  const struct rte_lpm6c_rule_key *rule_key,
+		  uint32_t *next_hop)
+{
+	uint64_t hash_val;
+	int ret;
+
+	/* lookup for a rule */
+	ret = rte_hash_lookup_data(lpm->rules_tbl, (const void *)rule_key,
+		(void **)&hash_val);
+	if (ret >= 0) {
+		*next_hop = (uint32_t) hash_val;
+		return 1;
+	}
+
+	return 0;
+}
+
+/* Find a rule */
+static int
+rule_find(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
+		  uint32_t *next_hop)
+{
+	struct rte_lpm6c_rule_key rule_key;
+
+	/* init a rule key */
+	rule_key_init(&rule_key, ip, depth);
+
+	return rule_find_with_key(lpm, &rule_key, next_hop);
+}
+
+/*
+ * Checks if a rule already exists in the rules table and updates
+ * the nexthop if so. Otherwise it adds a new rule if enough space is available.
+ *
+ * Returns:
+ *    0 - next hop of existed rule is updated
+ *    1 - new rule successfully added
+ *   <0 - error
+ */
+static inline int
+rule_add(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip, uint8_t depth,
+		  uint32_t next_hop)
+{
+	int ret, rule_exist;
+	struct rte_lpm6c_rule_key rule_key;
+	uint32_t unused;
+
+	/* init a rule key */
+	rule_key_init(&rule_key, ip, depth);
+
+	/* Scan through rule list to see if rule already exists. */
+	rule_exist = rule_find_with_key(lpm, &rule_key, &unused);
+
+	/*
+	 * If rule does not exist check if there is space to add a new rule to
+	 * this rule group. If there is no space return error.
+	 */
+	if (!rule_exist && lpm->used_rules == lpm->max_rules)
+		return -ENOSPC;
+
+	/* add the rule or update rules next hop */
+	ret = rte_hash_add_key_data(lpm->rules_tbl, &rule_key,
+		(void *)(uintptr_t) next_hop);
+	if (ret < 0)
+		return ret;
+
+	/* Increment the used rules counter for this rule group. */
+	if (!rule_exist) {
+		lpm->used_rules++;
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Find a less specific rule
+ */
+static int
+rule_find_less_specific(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, struct rte_lpm6c_rule *rule)
+{
+	int ret;
+	uint32_t next_hop;
+	uint8_t mask;
+	struct rte_lpm6c_rule_key rule_key;
+
+	if (depth == 1)
+		return 0;
+
+	rule_key_init(&rule_key, ip, depth);
+
+	while (depth > 1) {
+		depth--;
+
+		/* each iteration zero one more bit of the key */
+		mask = depth & 7; /* depth % RTE_LPM6C_BYTE_SIZE */
+		if (mask > 0)
+			mask = depth_to_mask_1b(mask);
+
+		rule_key.depth = depth;
+		rule_key.ip.a[depth >> 3] &= mask;
+
+		ret = rule_find_with_key(lpm, &rule_key, &next_hop);
+		if (ret) {
+			rule->depth = depth;
+			rule->ip = rule_key.ip;
+			rule->next_hop = next_hop;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Function that expands a rule across the data structure when a less-generic
+ * one has been added before. It assures that every possible combination of bits
+ * in the IP address returns a match.
+ */
+static void
+expand_rule(struct rte_lpm6c *lpm, uint32_t tbl8_ind, uint8_t old_depth,
+		uint8_t new_depth, uint32_t next_hop, uint8_t valid)
+{
+	uint32_t j;
+	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
+	struct rte_lpm6c_tbl8 *tbl;
+	struct rte_lpm6c_tbl_entry *entries;
+
+	tbl_hdr = &lpm->tbl8_hdrs[tbl8_ind];
+	tbl = &lpm->tbl8[tbl8_ind];
+
+	if (tbl_hdr->lsp_depth <= old_depth ||
+			  tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP) {
+		if (valid) {
+			tbl->lsp_next_hop = next_hop;
+			tbl_hdr->lsp_depth = new_depth;
+		} else
+			tbl->lsp_next_hop = RTE_LPM6C_UNDEF_NEXT_HOP;
+	}
+
+	entries = lpm->tbl8[tbl8_ind].entries;
+
+	struct rte_lpm6c_tbl_entry new_tbl8_entry = {
+		.valid = valid,
+		.valid_group = valid,
+		.depth = new_depth,
+		.next_hop = next_hop,
+		.ext_entry = 0,
+	};
+
+	for (j = 0; j < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; j++)
+		if (!entries[j].valid || (entries[j].ext_entry == 0
+				&& entries[j].depth <= old_depth)) {
+
+			entries[j] = new_tbl8_entry;
+
+		} else if (entries[j].ext_entry == 1) {
+
+			expand_rule(lpm, entries[j].lpm6_tbl8_ind,
+					  old_depth, new_depth, next_hop, valid);
+		}
+}
+
+/*
+ * Init a tbl8 header
+ */
+static inline void
+init_tbl8_header(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t tbl_ind, uint32_t owner_tbl_ind,
+		  uint32_t owner_entry_ind, uint32_t lsp_next_hop, uint8_t lsp_depth)
+{
+	struct rte_lpm6c_tbl8_hdr *tbl_hdr = &lpm->tbl8_hdrs[tbl_ind];
+	struct rte_lpm6c_tbl8 *tbl = &lpm->tbl8[tbl_ind];
+
+	tbl_hdr->owner_tbl_ind = owner_tbl_ind;
+	tbl_hdr->owner_entry_ind = owner_entry_ind;
+
+	tbl_hdr->nb_ext  = 0;
+	tbl_hdr->nb_rule  = 0;
+
+	tbl->ip = *ip;
+	rte_ipv6_addr_mask(&tbl->ip, depth);
+	tbl_hdr->depth = depth;
+
+	tbl_hdr->lsp_depth = lsp_depth;
+	tbl->lsp_next_hop = lsp_next_hop;
+}
+
+/*
+ * Calculate index to the table based on the number and position
+ * of the bytes being inspected in this step.
+ */
+static uint32_t
+get_bitshift(const struct rte_ipv6_addr *ip, uint8_t first_byte, uint8_t bytes)
+{
+	uint32_t entry_ind, i;
+	int8_t bitshift;
+
+	entry_ind = 0;
+	for (i = first_byte; i < (uint32_t)(first_byte + bytes); i++) {
+		bitshift = (int8_t)((bytes - i) * RTE_LPM6C_BYTE_SIZE);
+
+		if (bitshift < 0)
+			bitshift = 0;
+		entry_ind = entry_ind | ip->a[i - 1] << bitshift;
+	}
+
+	return entry_ind;
+}
+
+/*
+ * Returns number of free tbl8s
+ */
+uint32_t
+rte_lpm6c_tbl8_available(struct rte_lpm6c *lpm)
+{
+	return lpm->number_tbl8s - lpm->tbl8_pool_pos;
+}
+
+/*
+ * Returns number of tbl8s in use
+ */
+uint32_t
+rte_lpm6c_tbl8_in_use(struct rte_lpm6c *lpm)
+{
+	return lpm->tbl8_pool_pos;
+}
+
+int
+rte_lpm6c_is_rule_present(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t *next_hop)
+{
+	struct rte_ipv6_addr masked_ip;
+
+	/* Check user arguments. */
+	if ((lpm == NULL) || next_hop == NULL || ip == NULL ||
+			(depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
+		return -EINVAL;
+
+	/* Copy the IP and mask it to avoid modifying user's input data. */
+	masked_ip = *ip;
+	rte_ipv6_addr_mask(&masked_ip, depth);
+
+	return rule_find(lpm, &masked_ip, depth, next_hop);
+}
+
+static uint8_t
+depth_to_level(uint8_t depth)
+{
+	if (depth <= RTE_LPM6C_ROOT_LEV_BYTES * RTE_LPM6C_BYTE_SIZE)
+		return 0;
+	return 1 + (depth - 1 - RTE_LPM6C_ROOT_LEV_BYTES * RTE_LPM6C_BYTE_SIZE) /
+			  RTE_LPM6C_BYTE_SIZE;
+}
+
+static uint8_t
+level_to_depth(uint8_t level)
+{
+	if (level == 0)
+		return 0;
+	return (RTE_LPM6C_ROOT_LEV_BYTES + level - 1) * RTE_LPM6C_BYTE_SIZE;
+}
+
+#define LPM6_TBL_NOT_FOUND 0
+#define LPM6_DEST_TBL_FOUND 1
+#define LPM6_INTRM_TBL_FOUND 2
+
+static int
+find_table(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip, uint8_t depth,
+		  uint8_t *p_level, struct rte_lpm6c_tbl_entry **p_tbl,
+		  uint32_t *p_tbl_ind, uint32_t *p_entry_ind)
+{
+	uint8_t bits, first_byte, bytes, level;
+	struct rte_ipv6_addr masked_ip;
+	uint32_t entry_ind, tbl_ind, ext_tbl_ind;
+	int ret;
+	struct rte_lpm6c_tbl_entry *entries;
+	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
+	struct rte_lpm6c_tbl8 *tbl8;
+
+	entries = *p_tbl;
+	tbl_ind = *p_tbl_ind;
+	level = *p_level;
+
+	while (1) {
+		if (level == 0) {
+			first_byte = 1;
+			bytes = RTE_LPM6C_ROOT_LEV_BYTES;
+		} else {
+			first_byte = RTE_LPM6C_ROOT_LEV_BYTES + level;
+			bytes = 1;
+		}
+
+		/*
+		 * Calculate index to the table based on the number and position
+		 * of the bytes being inspected in this step.
+		 */
+		entry_ind = get_bitshift(ip, first_byte, bytes);
+		/* Number of bits covered in this step */
+		bits = (uint8_t)((bytes + first_byte - 1) * RTE_LPM6C_BYTE_SIZE);
+
+		/*
+		 * If depth if smaller than this number,
+		 * then the destination (last level) table is found.
+		 */
+		if (depth <= bits) {
+			ret = LPM6_DEST_TBL_FOUND;
+			break;
+		}
+		if (!entries[entry_ind].valid || entries[entry_ind].ext_entry == 0) {
+			ret = LPM6_INTRM_TBL_FOUND;
+			break;
+		}
+
+		/* follow the reference to the next level */
+		assert(entries[entry_ind].ext_entry == 1);
+		level = entries[entry_ind].depth;
+
+		/* check that the next level is still on the prefix path */
+		if (depth < level_to_depth(level) + 1) {
+			ret = LPM6_TBL_NOT_FOUND;
+			break;
+		}
+
+		/* Check that the next level table is still on the prefix path */
+		ext_tbl_ind = entries[entry_ind].lpm6_tbl8_ind;
+		tbl_hdr = &lpm->tbl8_hdrs[ext_tbl_ind];
+		tbl8 = &lpm->tbl8[ext_tbl_ind];
+		masked_ip = *ip;
+		rte_ipv6_addr_mask(&masked_ip, tbl_hdr->depth);
+		if (!rte_ipv6_addr_eq(&tbl8->ip, &masked_ip)) {
+			ret = LPM6_TBL_NOT_FOUND;
+			break;
+		}
+
+		tbl_ind = ext_tbl_ind;
+		entries = lpm->tbl8[tbl_ind].entries;
+		*p_level = level;
+	}
+
+	*p_tbl = entries;
+	*p_tbl_ind = tbl_ind;
+	*p_entry_ind = entry_ind;
+	return ret;
+}
+
+static void
+fill_dst_tbl(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, struct rte_lpm6c_tbl_entry *tbl, uint8_t level,
+		  uint32_t tbl_ind, int is_new_rule, uint32_t next_hop)
+{
+	uint32_t entry_ind, tbl_range, i;
+	uint8_t bits_covered, first_byte, bytes;
+
+	if (level == 0) {
+		first_byte = 1;
+		bytes = RTE_LPM6C_ROOT_LEV_BYTES;
+	} else {
+		first_byte = RTE_LPM6C_ROOT_LEV_BYTES + level;
+		bytes = 1;
+	}
+
+	/*
+	 * Calculate index to the table based on the number and position
+	 * of the bytes being inspected in this step.
+	 */
+	entry_ind = get_bitshift(ip, first_byte, bytes);
+	/* Number of bits covered in this step */
+	bits_covered = (uint8_t)((bytes + first_byte - 1) * RTE_LPM6C_BYTE_SIZE);
+
+	/*
+	 * If depth if smaller than this number (i.e. this is the last step)
+	 * expand the rule across the relevant positions in the table.
+	 */
+	assert(depth <= bits_covered);
+	tbl_range = 1 << (bits_covered - depth);
+
+	for (i = entry_ind; i < (entry_ind + tbl_range); i++) {
+		if (!tbl[i].valid || (tbl[i].ext_entry == 0 &&
+				tbl[i].depth <= depth)) {
+
+			struct rte_lpm6c_tbl_entry new_tbl_entry = {
+				.next_hop = next_hop,
+				.depth = depth,
+				.valid = VALID,
+				.valid_group = VALID,
+				.ext_entry = 0,
+			};
+
+			tbl[i] = new_tbl_entry;
+
+		} else if (tbl[i].ext_entry == 1) {
+			/*
+			 * If tbl entry is valid and extended calculate the index
+			 * into next tbl8 and expand the rule across the data structure.
+			 */
+			expand_rule(lpm, tbl[i].lpm6_tbl8_ind, depth, depth,
+					  next_hop, VALID);
+		}
+	}
+
+	/* increase the number of rules saved in the table */
+	if (tbl_ind != TBL24_IND && is_new_rule)
+		lpm->tbl8_hdrs[tbl_ind].nb_rule++;
+}
+
+static int
+add_new_tbl(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, struct rte_lpm6c_tbl_entry *parent_tbl,
+		  uint32_t entry_ind, uint32_t parent_tbl_ind, uint8_t level,
+		  struct rte_lpm6c_tbl_entry **p_new_tbl,
+		  uint32_t *p_new_tbl_ind)
+{
+	bool lsp;
+	uint8_t lsp_depth;
+	int ret;
+	uint32_t tbl8_gindex;
+	uint32_t lsp_next_hop;
+	struct rte_lpm6c_tbl_entry *new_tbl;
+
+	/* get a new tbl8 index */
+	ret = tbl8_get(lpm, &tbl8_gindex);
+	if (ret != 0)
+		return -ENOSPC;
+	new_tbl = lpm->tbl8[tbl8_gindex].entries;
+
+	lsp = false;
+	lsp_next_hop = RTE_LPM6C_UNDEF_NEXT_HOP;
+	lsp_depth = 0;
+
+	if (parent_tbl[entry_ind].valid) {
+		if (parent_tbl[entry_ind].ext_entry) {
+			struct rte_lpm6c_rule lsp_rule;
+
+			ret = rule_find_less_specific(lpm, ip, depth, &lsp_rule);
+			if (ret) {
+				lsp = true;
+				lsp_next_hop = lsp_rule.next_hop;
+				lsp_depth = lsp_rule.depth;
+			}
+		} else {
+			lsp = true;
+			lsp_next_hop = parent_tbl[entry_ind].next_hop;
+			lsp_depth = parent_tbl[entry_ind].depth;
+		}
+	}
+
+	/* If it's invalid a new tbl8 is needed */
+	if (lsp) {
+		/*
+		 * If it's valid but not extended the rule that was stored
+		 * here needs to be moved to the next table.
+		 */
+		int i;
+
+		struct rte_lpm6c_tbl_entry tbl_entry = {
+			.next_hop = lsp_next_hop,
+			.depth = lsp_depth,
+			.valid = VALID,
+			.valid_group = VALID,
+			.ext_entry = 0
+		};
+
+		/* Populate new tbl8 with tbl value. */
+		for (i = 0; i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; i++)
+			new_tbl[i] = tbl_entry;
+	} else
+		/* invalidate all new tbl8 entries */
+		memset(new_tbl, 0,
+				  RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES *
+				  sizeof(struct rte_lpm6c_tbl_entry));
+
+	/*
+	 * Init the new table's header:
+	 *   save the reference to the owner table
+	 */
+	init_tbl8_header(lpm, ip, level_to_depth(level),
+			  tbl8_gindex, parent_tbl_ind, entry_ind,
+			  lsp_next_hop, lsp_depth);
+
+	/* reference to a new tbl8 */
+	struct rte_lpm6c_tbl_entry new_tbl_entry = {
+		.lpm6_tbl8_ind = tbl8_gindex,
+		.depth = level,
+		.valid = VALID,
+		.valid_group = VALID,
+		.ext_entry = 1,
+	};
+
+	parent_tbl[entry_ind] = new_tbl_entry;
+
+	/* increase the number of external entries saved in the parent table */
+	if (parent_tbl_ind != TBL24_IND)
+		lpm->tbl8_hdrs[parent_tbl_ind].nb_ext++;
+
+	*p_new_tbl = new_tbl;
+	*p_new_tbl_ind = tbl8_gindex;
+	return 0;
+}
+
+static int
+add_intermediate_tbl(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip,
+		  uint8_t depth, struct rte_lpm6c_tbl_entry *tbl, uint32_t tbl_ind,
+		  uint32_t entry_ind)
+{
+	int ret, i, cnt;
+	uint8_t level;
+	uint32_t ext_tbl_ind, interm_tbl_ind;
+	struct rte_lpm6c_tbl_entry ext_entry;
+	struct rte_lpm6c_tbl8_hdr *ext_tbl_hdr;
+	struct rte_lpm6c_tbl8 *tbl8;
+	struct rte_lpm6c_tbl_entry *interm_tbl;
+
+	/*
+	 * determine the level at which a new intermediate table
+	 * should be added
+	 */
+	ext_entry = tbl[entry_ind];
+	assert(ext_entry.ext_entry == 1);
+	ext_tbl_ind = ext_entry.lpm6_tbl8_ind;
+	ext_tbl_hdr = &lpm->tbl8_hdrs[ext_tbl_ind];
+	tbl8 = &lpm->tbl8[ext_tbl_ind];
+
+	/*
+	 * ext table's prefix and the given prefix should be
+	 * equal at the root level
+	 */
+	assert(memcmp(ip->a, tbl8->ip.a, RTE_LPM6C_ROOT_LEV_BYTES) == 0);
+
+	cnt = RTE_MIN(depth_to_level(depth), depth_to_level(ext_tbl_hdr->depth));
+	for (i = 1; i <= cnt; i++)
+		if (ip->a[RTE_LPM6C_ROOT_LEV_BYTES + i - 1] !=
+				  tbl8->ip.a[RTE_LPM6C_ROOT_LEV_BYTES + i - 1])
+			break;
+	level = i > cnt ? cnt : i;
+
+	/* add a new intermediate table */
+	ret = add_new_tbl(lpm, ip, depth, tbl, entry_ind, tbl_ind, level,
+			  &interm_tbl, &interm_tbl_ind);
+	if (ret != 0)
+		return ret;
+
+	/* move the initial reference to the intermediate table */
+	entry_ind = tbl8->ip.a[RTE_LPM6C_ROOT_LEV_BYTES + level - 1];
+	interm_tbl[entry_ind] = ext_entry;
+	/* update the header of ext table */
+	ext_tbl_hdr->owner_tbl_ind = interm_tbl_ind;
+	ext_tbl_hdr->owner_entry_ind = entry_ind;
+
+	if (tbl_ind != TBL24_IND) {
+		assert(lpm->tbl8_hdrs[tbl_ind].nb_ext > 0);
+		lpm->tbl8_hdrs[tbl_ind].nb_ext--;
+	}
+	lpm->tbl8_hdrs[interm_tbl_ind].nb_ext++;
+
+	return 0;
+}
+
+int
+rte_lpm6c_add(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t next_hop)
+{
+	struct rte_lpm6c_tbl_entry *tbl, *new_tbl;
+	int ret, is_new_rule;
+	uint32_t tbl_ind, entry_ind;
+	uint8_t level;
+	struct rte_ipv6_addr masked_ip;
+
+	/* Check user arguments. */
+	if ((lpm == NULL) || (depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
+		return -EINVAL;
+
+	/* Copy the IP and mask it to avoid modifying user's input data. */
+	masked_ip = *ip;
+	rte_ipv6_addr_mask(&masked_ip, depth);
+
+	/*
+	 * Check that tbl8 pool contains enough entries to create the longest
+	 * path in the tree
+	 */
+	if (rte_lpm6c_tbl8_available(lpm) < MIN_TBL8_REQ_FOR_ADD)
+		return -ENOSPC;
+
+	/* Add the rule to the rule table. */
+	is_new_rule = rule_add(lpm, &masked_ip, depth, next_hop);
+	/* If there is no space available for new rule return error. */
+	if (is_new_rule < 0)
+		return is_new_rule;
+
+	level = 0;
+	tbl = lpm->tbl24;
+	tbl_ind = TBL24_IND;
+
+start:
+	ret = find_table(lpm, &masked_ip, depth,
+			  &level, &tbl, &tbl_ind, &entry_ind);
+
+	switch (ret) {
+	case LPM6_TBL_NOT_FOUND:
+		ret = add_intermediate_tbl(lpm, &masked_ip, depth, tbl, tbl_ind,
+				  entry_ind);
+		if (ret < 0)
+			return ret;
+		goto start;
+
+	case LPM6_DEST_TBL_FOUND:
+		/* fill existing table and expand some cells if necessary */
+		fill_dst_tbl(lpm, &masked_ip, depth, tbl, level, tbl_ind,
+				  is_new_rule, next_hop);
+		ret = 0;
+		break;
+
+	case LPM6_INTRM_TBL_FOUND:
+		/* link a new table and fill it */
+		level = depth_to_level(depth);
+		ret = add_new_tbl(lpm, &masked_ip, depth, tbl, entry_ind, tbl_ind, level,
+				  &new_tbl, &tbl_ind);
+		if (ret < 0)
+			break;
+		fill_dst_tbl(lpm, &masked_ip, depth, new_tbl, level, tbl_ind,
+				  is_new_rule, next_hop);
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Delete a rule from the rule table.
+ * NOTE: Valid range for depth parameter is 1 .. 128 inclusive.
+ * return
+ *	  0 on success
+ *   <0 on failure
+ */
+static inline int
+rule_delete(struct rte_lpm6c *lpm, struct rte_ipv6_addr *ip, uint8_t depth)
+{
+	int ret;
+	struct rte_lpm6c_rule_key rule_key;
+
+	/* init rule key */
+	rule_key_init(&rule_key, ip, depth);
+
+	/* delete the rule */
+	ret = rte_hash_del_key(lpm->rules_tbl, (void *)&rule_key);
+	if (ret >= 0)
+		lpm->used_rules--;
+
+	return ret;
+}
+
+/*
+ * Deletes a group of rules
+ */
+int
+rte_lpm6c_delete_bulk_func(struct rte_lpm6c *lpm,
+		const struct rte_ipv6_addr *ips, uint8_t *depths, unsigned int n)
+{
+	unsigned int i;
+
+	/* Check input arguments. */
+	if ((lpm == NULL) || (ips == NULL) || (depths == NULL))
+		return -EINVAL;
+
+	for (i = 0; i < n; i++)
+		rte_lpm6c_delete(lpm, &ips[i], depths[i]);
+
+	return 0;
+}
+
+/*
+ * Delete all rules from the LPM table.
+ */
+void
+rte_lpm6c_delete_all(struct rte_lpm6c *lpm)
+{
+	/* Zero used rules counter. */
+	lpm->used_rules = 0;
+
+	/* Zero tbl24. */
+	memset(lpm->tbl24, 0, sizeof(lpm->tbl24));
+
+	/* Zero tbl8. */
+	memset(lpm->tbl8, 0, sizeof(lpm->tbl8[0]) * lpm->number_tbl8s);
+
+	/* init pool of free tbl8 indexes */
+	tbl8_pool_init(lpm);
+
+	/* Delete all rules form the rules table. */
+	rte_hash_reset(lpm->rules_tbl);
+}
+
+/*
+ *	Iterate rules
+ */
+void
+rte_lpm6c_rules_iterate_cb(const struct rte_lpm6c *lpm, lpm6_iter_cb cb,
+		  void *cb_param)
+{
+	struct rte_lpm6c_rule_key *rule_key;
+	uint64_t next_hop;
+	uint32_t iter = 0;
+
+	while (rte_hash_iterate(lpm->rules_tbl, (void *)&rule_key,
+			(void **)&next_hop, &iter) >= 0)
+		cb(cb_param, &rule_key->ip, rule_key->depth, (uint32_t) next_hop);
+}
+
+int32_t
+rte_lpm6c_rules_iterate(const struct rte_lpm6c *lpm, uint32_t *iter,
+		  const struct rte_ipv6_addr **ip, uint8_t *depth, uint32_t *next_hop)
+{
+	uint64_t hash_val;
+	const struct rte_lpm6c_rule_key *rule_key;
+
+	int32_t ret = rte_hash_iterate(lpm->rules_tbl, (void *)&rule_key,
+			(void **)&hash_val, iter);
+	if (ret >= 0) {
+		*ip = &rule_key->ip;
+		*depth = rule_key->depth;
+		*next_hop = (uint32_t)hash_val;
+	}
+
+	return ret;
+}
+
+/*
+ * Remove an intermediate table
+ */
+static void
+del_intermediate_tbl(struct rte_lpm6c *lpm, uint32_t tbl_ind,
+		  struct rte_lpm6c_tbl8_hdr *tbl_hdr)
+{
+	unsigned int i;
+	struct rte_lpm6c_tbl_entry *entry, *owner_entry;
+	struct rte_lpm6c_tbl8_hdr *ext_tbl_hdr;
+
+	assert(tbl_hdr->nb_ext == 1);
+	entry = lpm->tbl8[tbl_ind].entries;
+	for (i = 0; i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES; i++, entry++)
+		if (entry->ext_entry == 1)
+			break;
+	assert(i < RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES);
+
+	/*
+	 * move found external entry from the intermediate
+	 * table to the intermediate's parent table
+	 */
+	if (tbl_hdr->owner_tbl_ind == TBL24_IND)
+		owner_entry = &lpm->tbl24[tbl_hdr->owner_entry_ind];
+	else
+		owner_entry = &lpm->tbl8[tbl_hdr->owner_tbl_ind].entries[
+			tbl_hdr->owner_entry_ind];
+	*owner_entry = *entry;
+
+	/* update the header of ext table */
+	ext_tbl_hdr = &lpm->tbl8_hdrs[entry->next_hop];
+	ext_tbl_hdr->owner_tbl_ind = tbl_hdr->owner_tbl_ind;
+	ext_tbl_hdr->owner_entry_ind = tbl_hdr->owner_entry_ind;
+
+	tbl8_put(lpm, tbl_ind);
+}
+
+/*
+ * Remove a table from the LPM tree
+ */
+static void
+remove_tbl(struct rte_lpm6c *lpm, struct rte_lpm6c_tbl8_hdr *tbl_hdr,
+		  uint32_t tbl_ind, struct rte_lpm6c_rule *lsp_rule)
+{
+	struct rte_lpm6c_tbl_entry *owner_entry;
+
+	if (tbl_hdr->owner_tbl_ind == TBL24_IND) {
+		owner_entry = &lpm->tbl24[tbl_hdr->owner_entry_ind];
+		assert(owner_entry->ext_entry == 1);
+	} else {
+		uint32_t owner_tbl_ind;
+		struct rte_lpm6c_tbl8_hdr *owner_tbl_hdr;
+
+		owner_tbl_ind = tbl_hdr->owner_tbl_ind;
+		owner_entry = &lpm->tbl8[owner_tbl_ind].entries[
+			tbl_hdr->owner_entry_ind];
+		assert(owner_entry->ext_entry == 1);
+
+		owner_tbl_hdr = &lpm->tbl8_hdrs[owner_tbl_ind];
+		owner_tbl_hdr->nb_ext--;
+		if (owner_tbl_hdr->nb_ext == 1 && owner_tbl_hdr->nb_rule == 0) {
+			/*
+			 * down external flag in order to del_intermediate_tbl()
+			 * find the right (last one) external entry
+			 */
+			owner_entry->ext_entry = 0;
+			del_intermediate_tbl(lpm, owner_tbl_ind, owner_tbl_hdr);
+			tbl8_put(lpm, tbl_ind);
+			return;
+		}
+	}
+
+	/* unlink the table */
+	if (lsp_rule != NULL) {
+		struct rte_lpm6c_tbl_entry new_tbl_entry = {
+			.next_hop = lsp_rule->next_hop,
+			.depth = lsp_rule->depth,
+			.valid = VALID,
+			.valid_group = VALID,
+			.ext_entry = 0
+		};
+
+		*owner_entry = new_tbl_entry;
+	} else {
+		struct rte_lpm6c_tbl_entry new_tbl_entry = {
+			.next_hop = 0,
+			.depth = 0,
+			.valid = INVALID,
+			.valid_group = INVALID,
+			.ext_entry = 0
+		};
+
+		*owner_entry = new_tbl_entry;
+	}
+
+	/* return the table to the pool */
+	tbl8_put(lpm, tbl_ind);
+}
+
+/*
+ * Find range of tbl8 cells occupied by a rule
+ */
+static void
+rule_find_range(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, struct rte_lpm6c_tbl_entry **from,
+		  struct rte_lpm6c_tbl_entry **to,
+		  uint32_t *out_tbl_ind)
+{
+	uint32_t ind = 0;
+	uint32_t first_3bytes = RTE_LPM6C_ROOT_TBL_IND(ip);
+
+	if (depth <= RTE_LPM6C_ROOT_LEVEL_BITS) {
+		/* rule is within the top level */
+		ind = first_3bytes;
+		*from = &lpm->tbl24[ind];
+		ind += (1 << (24 - depth)) - 1;
+		*to = &lpm->tbl24[ind];
+		*out_tbl_ind = TBL24_IND;
+	} else {
+		int i;
+		uint32_t level = 0;
+		uint32_t tbl_ind = 0;
+		struct rte_lpm6c_tbl_entry *entry;
+		struct rte_lpm6c_tbl_entry *entries = NULL;
+
+		/* top level entry */
+		entry = &lpm->tbl24[first_3bytes];
+		assert(entry->ext_entry == 1);
+		/* iterate through levels until we reach the last one */
+		do {
+			if (level_to_depth(entry->depth) >= depth)
+				break;
+			level = entry->depth;
+			tbl_ind = entry->lpm6_tbl8_ind;
+			entries = lpm->tbl8[tbl_ind].entries;
+			ind = ip->a[RTE_LPM6C_ROOT_LEV_BYTES + level - 1];
+			entry = &entries[ind];
+		} while (entry->ext_entry == 1);
+
+		/* last level */
+		*from = entry;
+		assert(depth > level_to_depth(level));
+		i = depth - level_to_depth(level);
+		assert(i <= RTE_LPM6C_BYTE_SIZE);
+		ind += (1 << (RTE_LPM6C_BYTE_SIZE - i)) - 1;
+		assert(entries != NULL);
+		*to = &entries[ind];
+		*out_tbl_ind = tbl_ind;
+	}
+}
+
+/*
+ * Deletes a rule
+ */
+int
+rte_lpm6c_delete(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth)
+{
+	struct rte_ipv6_addr masked_ip;
+	struct rte_lpm6c_rule lsp_rule_obj;
+	struct rte_lpm6c_rule *lsp_rule;
+	int ret;
+	uint32_t tbl_ind;
+	struct rte_lpm6c_tbl_entry *from, *to;
+	struct rte_lpm6c_tbl8_hdr *tbl_hdr;
+
+	/* Check input arguments. */
+	if ((lpm == NULL) || (depth < 1) || (depth > RTE_IPV6_MAX_DEPTH))
+		return -EINVAL;
+
+	/* Copy the IP and mask it to avoid modifying user's input data. */
+	masked_ip = *ip;
+	rte_ipv6_addr_mask(&masked_ip, depth);
+
+	/* Delete the rule from the rule table. */
+	ret = rule_delete(lpm, &masked_ip, depth);
+	if (ret < 0)
+		return -ENOENT;
+
+	/* find rule cells */
+	rule_find_range(lpm, &masked_ip, depth, &from, &to, &tbl_ind);
+
+	/* find a less specific rule (a rule with smaller depth)
+	 * note: masked_ip will be modified, don't use it anymore
+	 */
+	ret = rule_find_less_specific(lpm, &masked_ip, depth,
+			&lsp_rule_obj);
+	lsp_rule = ret ? &lsp_rule_obj : NULL;
+
+	/* decrement the number of rules in the table
+	 * note that tbl24 doesn't have a header
+	 */
+	if (tbl_ind != TBL24_IND) {
+		tbl_hdr = &lpm->tbl8_hdrs[tbl_ind];
+		tbl_hdr->nb_rule--;
+		if (tbl_hdr->nb_rule == 0 && tbl_hdr->nb_ext == 0) {
+			/* remove the table */
+			remove_tbl(lpm, tbl_hdr, tbl_ind, lsp_rule);
+			return 0;
+		}
+	}
+
+	/* iterate rule cells */
+	for (; from <= to; from++)
+		if (from->ext_entry == 1) {
+			/* reference to a more specific space
+			 * of the prefix/rule. Entries in a more
+			 * specific space that are not used by
+			 * a more specific prefix must be occupied
+			 * by the prefix
+			 */
+			if (lsp_rule != NULL)
+				expand_rule(lpm,
+					from->lpm6_tbl8_ind,
+					depth, lsp_rule->depth,
+					lsp_rule->next_hop, VALID);
+			else
+				/* since the prefix has no less specific prefix,
+				 * its more specific space must be invalidated
+				 */
+				expand_rule(lpm,
+					from->lpm6_tbl8_ind,
+					depth, 0, 0, INVALID);
+		} else if (from->depth == depth) {
+			/* entry is not a reference and belongs to the prefix */
+			if (lsp_rule != NULL) {
+				struct rte_lpm6c_tbl_entry new_tbl_entry = {
+					.next_hop = lsp_rule->next_hop,
+					.depth = lsp_rule->depth,
+					.valid = VALID,
+					.valid_group = VALID,
+					.ext_entry = 0
+				};
+
+				*from = new_tbl_entry;
+			} else {
+				struct rte_lpm6c_tbl_entry new_tbl_entry = {
+					.next_hop = 0,
+					.depth = 0,
+					.valid = INVALID,
+					.valid_group = INVALID,
+					.ext_entry = 0
+				};
+
+				*from = new_tbl_entry;
+			}
+		}
+
+	if (tbl_ind != TBL24_IND && tbl_hdr->nb_rule == 0 && tbl_hdr->nb_ext == 1)
+		del_intermediate_tbl(lpm, tbl_ind, tbl_hdr);
+
+	return 0;
+}
+
+uint32_t
+rte_lpm6c_pool_pos(struct rte_lpm6c *lpm)
+{
+	return lpm->tbl8_pool_pos;
+}
+
+uint32_t
+rte_lpm6c_used_rules(struct rte_lpm6c *lpm)
+{
+	return lpm->used_rules;
+}
diff --git a/lib/lpm/rte_lpm6c.h b/lib/lpm/rte_lpm6c.h
new file mode 100644
index 0000000000..79286d5ccc
--- /dev/null
+++ b/lib/lpm/rte_lpm6c.h
@@ -0,0 +1,560 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2016-2025 Alex Kiselev, alex at BisonRouter.com
+ */
+#ifndef _RTE_LPM6C_H_
+#define _RTE_LPM6C_H_
+
+/**
+ * @file
+ * Longest Prefix Match for IPv6 (LPM6)
+ * Path Compressed DIR24-8(n) trie.
+ */
+
+#include <sys/cdefs.h>
+
+__BEGIN_DECLS
+
+#include <stdint.h>
+#include <rte_compat.h>
+#include <rte_branch_prediction.h>
+#include <rte_memory.h>
+#include <rte_ip6.h>
+
+/** Max number of characters in LPM name. */
+#define RTE_LPM6C_NAMESIZE                 32
+
+#define RTE_LPM6C_ROOT_LEVEL_BITS                24
+#define RTE_LPM6C_TBL24_NUM_ENTRIES        (1 << RTE_LPM6C_ROOT_LEVEL_BITS)
+#define RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES         256
+#define RTE_LPM6C_TBL8_MAX_NUM_GROUPS      (1 << 21)
+
+#define RTE_LPM6C_VALID_EXT_ENTRY_BITMASK 0xA0000000
+#define RTE_LPM6C_LOOKUP_SUCCESS          0x20000000
+#define RTE_LPM6C_TBL8_BITMASK            0x001FFFFF
+
+#define RTE_LPM6C_DEPTH(x)      (((x) >> 21) & 0xFF)
+
+#define RTE_LPM6C_ROOT_LEV_BYTES                  3
+#define RTE_LPM6C_BYTE_SIZE                       8
+#define RTE_LPM6C_BYTES2_SIZE                    16
+
+#define RTE_LPM6C_ROOT_TBL_IND(ip) (\
+			  (uint32_t)ip->a[0] << RTE_LPM6C_BYTES2_SIZE | \
+			  (uint32_t)ip->a[1] << RTE_LPM6C_BYTE_SIZE | ip->a[2])
+
+#define lpm6_tbl8_ind next_hop
+
+#define MIN_TBL8_REQ_FOR_ADD 14
+
+#define RTE_LPM6C_UNDEF_NEXT_HOP         UINT32_MAX
+
+/** Flags for setting an entry as valid/invalid. */
+enum valid_flag {
+	INVALID = 0,
+	VALID
+};
+
+/** Tbl entry structure. It is the same for both tbl24 and tbl8 */
+struct rte_lpm6c_tbl_entry {
+	uint32_t next_hop:	21;  /**< Next hop / next table to be checked. */
+	uint32_t depth	:8; /**< Either a rule depth or a tree next level if
+	                     * it's an external entry
+	                     */
+	/* Flags. */
+	uint32_t valid     :1;   /**< Validation flag. */
+	uint32_t valid_group :1; /**< Group validation flag. */
+	uint32_t ext_entry :1;   /**< External entry. */
+};
+
+/**
+ * tbl8
+ */
+#define SIZEOF_TBL8_UNPADDED \
+	(RTE_IPV6_ADDR_SIZE + \
+	sizeof(uint32_t) + \
+	sizeof(struct rte_lpm6c_tbl_entry[RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES]))
+
+#define PADDING_TBL8 ((RTE_CACHE_LINE_SIZE - \
+	(SIZEOF_TBL8_UNPADDED % RTE_CACHE_LINE_SIZE)) % RTE_CACHE_LINE_SIZE)
+
+struct rte_lpm6c_tbl8 {
+	struct rte_ipv6_addr ip;
+	uint32_t lsp_next_hop;
+	struct rte_lpm6c_tbl_entry entries[RTE_LPM6C_TBL8_GROUP_NUM_ENTRIES];
+	uint8_t padding[PADDING_TBL8];
+}
+__rte_cache_aligned;
+
+/** Rules tbl entry structure. */
+struct rte_lpm6c_rule {
+	struct rte_ipv6_addr ip; /**< Rule IP address. */
+	uint32_t next_hop; /**< Rule next hop. */
+	uint8_t depth; /**< Rule depth. */
+};
+
+/** Rules tbl entry key. */
+struct rte_lpm6c_rule_key {
+	struct rte_ipv6_addr ip; /**< Rule IP address. */
+	uint32_t depth; /**< Rule depth. */
+};
+
+/* Header of tbl8 */
+struct rte_lpm6c_tbl8_hdr {
+	uint32_t owner_tbl_ind; /**< owner table: TBL24_IND if owner is tbl24,
+	                          * otherwise index of tbl8
+	                          */
+	uint32_t owner_entry_ind; /**< index of the owner table entry where
+	                            * pointer to the tbl8 is stored
+	                            */
+
+	uint32_t nb_rule; /**< number of rules  */
+	uint32_t nb_ext; /**< number of external entries */
+
+	uint8_t depth;
+	uint8_t lsp_depth;
+}
+__rte_cache_aligned;
+
+/** LPM6 structure. */
+struct rte_lpm6c {
+	uint32_t max_rules;              /**< Max number of rules. */
+	uint32_t used_rules;             /**< Used rules so far. */
+	uint32_t number_tbl8s;           /**< Number of tbl8s to allocate. */
+
+	uint32_t tbl8_pool_pos; /**< current position in the tbl8 pool */
+
+	/* next hop index */
+	uint32_t default_next_hop_ind;
+
+	/* LPM Tables. */
+	struct rte_hash *rules_tbl; /**< LPM rules. */
+	struct rte_lpm6c_tbl8_hdr *tbl8_hdrs; /* array of tbl8 headers */
+	uint32_t *tbl8_pool; /**< pool of indexes of free tbl8s */
+
+	/* LPM metadata. */
+	char name[RTE_LPM6C_NAMESIZE];    /**< Name of the lpm. */
+
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_lpm6c_tbl_entry
+			  tbl24[RTE_LPM6C_TBL24_NUM_ENTRIES]; /**< LPM tbl24 table. */
+
+	alignas(RTE_CACHE_LINE_SIZE) struct rte_lpm6c_tbl8 tbl8[0];
+			  /**< LPM tbl8 table. */
+};
+
+/** LPM configuration structure. */
+struct rte_lpm6c_config {
+	uint32_t max_rules;      /**< Max number of rules. */
+	uint32_t number_tbl8s;   /**< Number of tbl8s to allocate. */
+	int flags;               /**< This field is currently unused. */
+};
+
+/**
+ * Create an LPM object.
+ *
+ * @param name
+ *   LPM object name
+ * @param socket_id
+ *   NUMA socket ID for LPM table memory allocation
+ * @param config
+ *   Structure containing the configuration
+ * @return
+ *   Handle to LPM object on success, NULL otherwise with rte_errno set
+ *   to an appropriate values. Possible rte_errno values include:
+ *    - EINVAL - invalid parameter passed to function
+ *    - EEXIST - a memzone with the same name already exists
+ *    - ENOMEM - no appropriate memory area found in which to create memzone
+ */
+struct rte_lpm6c *
+rte_lpm6c_create(const char *name, int socket_id,
+		const struct rte_lpm6c_config *config);
+
+/**
+ * Find an existing LPM object and return a pointer to it.
+ *
+ * @param name
+ *   Name of the lpm object as passed to rte_lpm6c_create()
+ * @return
+ *   Pointer to lpm object or NULL if object not found with rte_errno
+ *   set appropriately. Possible rte_errno values include:
+ *    - ENOENT - required entry not available to return.
+ */
+struct rte_lpm6c *
+rte_lpm6c_find_existing(const char *name);
+
+/**
+ * Free an LPM object.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @return
+ *   None
+ */
+void
+rte_lpm6c_free(struct rte_lpm6c *lpm);
+
+/**
+ * Add a rule to the LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ip
+ *   IP of the rule to be added to the LPM table
+ * @param depth
+ *   Depth of the rule to be added to the LPM table
+ * @param next_hop
+ *   Next hop of the rule to be added to the LPM table
+ * @return
+ *   0 on success, negative value otherwise
+ */
+int
+rte_lpm6c_add(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t next_hop);
+
+/**
+ * Check if a rule is present in the LPM table,
+ * and provide its next hop if it is.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ip
+ *   IP of the rule to be searched
+ * @param depth
+ *   Depth of the rule to searched
+ * @param next_hop
+ *   Next hop of the rule (valid only if it is found)
+ * @return
+ *   1 if the rule exists, 0 if it does not, a negative value on failure
+ */
+int
+rte_lpm6c_is_rule_present(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t *next_hop);
+
+/**
+ * Delete a rule from the LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ip
+ *   IP of the rule to be deleted from the LPM table
+ * @param depth
+ *   Depth of the rule to be deleted from the LPM table
+ * @return
+ *   0 on success, negative value otherwise
+ */
+int
+rte_lpm6c_delete(struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		  uint8_t depth);
+
+/**
+ * Delete a rule from the LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ips
+ *   Array of IPs to be deleted from the LPM table
+ * @param depths
+ *   Array of depths of the rules to be deleted from the LPM table
+ * @param n
+ *   Number of rules to be deleted from the LPM table
+ * @return
+ *   0 on success, negative value otherwise.
+ */
+int
+rte_lpm6c_delete_bulk_func(struct rte_lpm6c *lpm,
+		const struct rte_ipv6_addr *ips, uint8_t *depths, unsigned int n);
+
+/**
+ * Delete all rules from the LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ */
+void
+rte_lpm6c_delete_all(struct rte_lpm6c *lpm);
+
+/**
+ * Returns number of free tbl8s
+ *
+ * @param lpm
+ *   LPM object
+ *  @return
+ *   number of free tbl8
+ */
+uint32_t
+rte_lpm6c_tbl8_available(struct rte_lpm6c *lpm);
+
+/**
+ * Returns number of tbl8s in use
+ *
+ * @param lpm
+ *   LPM object
+ *  @return
+ *   number of tbl8 in use
+ */
+uint32_t
+rte_lpm6c_tbl8_in_use(struct rte_lpm6c *lpm);
+
+typedef void (*lpm6_iter_cb) (void *cb_param, struct rte_ipv6_addr *ip,
+		  uint8_t depth, uint32_t next_hop);
+
+int32_t
+rte_lpm6c_rules_iterate(const struct rte_lpm6c *lpm, uint32_t *iter,
+		  const struct rte_ipv6_addr **ip, uint8_t *depth, uint32_t *next_hop);
+
+void
+rte_lpm6c_rules_iterate_cb(const struct rte_lpm6c *lpm, lpm6_iter_cb cb,
+		  void *cb_param);
+
+/**
+ * Lookup an IP into the LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ip
+ *   IP to be looked up in the LPM table
+ * @param next_hop
+ *   Next hop of the most specific rule found for IP (valid on lookup hit only)
+ * @return
+ *   -EINVAL for incorrect arguments, -ENOENT on lookup miss, 0 on lookup hit
+ */
+static inline int
+rte_lpm6c_lookup(const struct rte_lpm6c *lpm, const struct rte_ipv6_addr *ip,
+		uint32_t *next_hop)
+{
+	uint32_t entry_val, tbl_ind, i, byte_ind, level;
+	const struct rte_lpm6c_tbl8 *tbl;
+	const struct rte_lpm6c_tbl_entry *entry;
+
+	/* DEBUG: Check user input arguments. */
+	if (unlikely(lpm == NULL) || (ip == NULL) || (next_hop == NULL))
+		return -EINVAL;
+
+	byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
+	tbl_ind = RTE_LPM6C_ROOT_TBL_IND(ip);
+	/* Calculate pointer to the first entry to be inspected */
+	entry = &lpm->tbl24[tbl_ind];
+
+	do {
+		/* Take the integer value from the pointer. */
+		entry_val = *(const uint32_t *)entry;
+		tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
+
+		if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
+				RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
+			*next_hop = tbl_ind;
+			return (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ? 0 : -ENOENT;
+		}
+
+		/* If it is valid and extended we calculate the new pointer to return. */
+		level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
+		tbl = &lpm->tbl8[tbl_ind];
+
+		/*
+		 * if some levels were skipped then make sure that
+		 * the ip matches the ip address of a table we've jumped to,
+		 * i.e. check the ip's bytes corresponding the skipped levels.
+		 */
+		for (i = byte_ind; i < level; i++)
+			if (tbl->ip.a[i] != ip->a[i]) {
+				if (tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP)
+					return -ENOENT;
+				*next_hop = tbl->lsp_next_hop;
+				return 0;
+			}
+
+		/* move ip byte index one byte further */
+		byte_ind = level + 1;
+		/* go to next level */
+		entry = &tbl->entries[ip->a[level]];
+	} while (true);
+}
+
+/**
+ * Lookup multiple IP addresses in an LPM table.
+ *
+ * @param lpm
+ *   LPM object handle
+ * @param ips
+ *   Array of IPs to be looked up in the LPM table
+ * @param next_hops
+ *   Next hop of the most specific rule found for IP (valid on lookup hit only).
+ *   This is an array of two byte values. The next hop will be stored on
+ *   each position on success; otherwise the position will be set to -1.
+ * @param n
+ *   Number of elements in ips (and next_hops) array to lookup.
+ *  @return
+ *   -EINVAL for incorrect arguments, otherwise 0
+ */
+static inline int
+rte_lpm6c_lookup_bulk(const struct rte_lpm6c *lpm,
+		  const struct rte_ipv6_addr *ips,
+		  int32_t *next_hops, const unsigned int n)
+{
+	uint32_t entry_val, tbl_ind, i, byte_ind, level;
+	unsigned int j;
+	const unsigned int n_unrolled = n & ~1U; /* Process pairs of IPs */
+	const struct rte_lpm6c_tbl8 *tbl;
+
+	/* DEBUG: Check user input arguments. */
+	if (unlikely(lpm == NULL) || (ips == NULL) || (next_hops == NULL))
+		return -EINVAL;
+
+	/* Unrolled loop processing two lookups at a time */
+	for (j = 0; j < n_unrolled; j += 2) {
+		const struct rte_lpm6c_tbl_entry *entry0, *entry1;
+		const struct rte_ipv6_addr *ip0, *ip1;
+
+		/* Start processing two independent lookups */
+		ip0 = &ips[j];
+		ip1 = &ips[j + 1];
+
+		entry0 = &lpm->tbl24[RTE_LPM6C_ROOT_TBL_IND(ip0)];
+		entry1 = &lpm->tbl24[RTE_LPM6C_ROOT_TBL_IND(ip1)];
+
+		/* Lookup for IP #0 */
+		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
+		do {
+			/* Take the integer value from the pointer. */
+			entry_val = *(const uint32_t *)entry0;
+			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
+
+			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
+					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
+				next_hops[j] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
+						  (int32_t)tbl_ind : -1;
+				break;
+			}
+
+			/*
+			 * If it is valid and extended we calculate the new pointer
+			 * to return.
+			 */
+			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
+			tbl = &lpm->tbl8[tbl_ind];
+
+			/*
+			 * if some levels were skipped then make sure that
+			 * the ip matches the ip address of a table we've jumped to,
+			 * i.e. check the ip's bytes corresponding the skipped levels.
+			 */
+			for (i = byte_ind; i < level; i++)
+				if (tbl->ip.a[i] != ip0->a[i]) {
+					next_hops[j] = tbl->lsp_next_hop ==
+							  RTE_LPM6C_UNDEF_NEXT_HOP ?
+						-1 : (int32_t)tbl->lsp_next_hop;
+					goto next_ip0;
+				}
+
+			/* move ip byte index one byte further */
+			byte_ind = level + 1;
+			/* go to next level */
+			entry0 = &tbl->entries[ip0->a[level]];
+		} while (true);
+
+next_ip0:
+		/* Lookup for IP #1 */
+		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
+		do {
+			/* Take the integer value from the pointer. */
+			entry_val = *(const uint32_t *)entry1;
+			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
+
+			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
+					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
+				next_hops[j + 1] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
+						  (int32_t)tbl_ind : -1;
+				break;
+			}
+
+			/*
+			 * If it is valid and extended we calculate the new pointer
+			 * to return.
+			 */
+			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
+			tbl = &lpm->tbl8[tbl_ind];
+
+			/*
+			 * if some levels were skipped then make sure that
+			 * the ip matches the ip address of a table we've jumped to,
+			 * i.e. check the ip's bytes corresponding the skipped levels.
+			 */
+			for (i = byte_ind; i < level; i++)
+				if (tbl->ip.a[i] != ip1->a[i]) {
+					next_hops[j + 1] =
+						tbl->lsp_next_hop == RTE_LPM6C_UNDEF_NEXT_HOP ?
+							-1 : (int32_t)tbl->lsp_next_hop;
+					goto next_ip1;
+				}
+
+			/* move ip byte index one byte further */
+			byte_ind = level + 1;
+			/* go to next level */
+			entry1 = &tbl->entries[ip1->a[level]];
+		} while (true);
+
+next_ip1:;
+	}
+
+	for (; j < n; j++) {
+		const struct rte_lpm6c_tbl_entry *entry;
+		const struct rte_ipv6_addr *ip0 = &ips[j];
+
+		byte_ind = RTE_LPM6C_ROOT_LEV_BYTES;
+		tbl_ind = RTE_LPM6C_ROOT_TBL_IND(ip0);
+		/* Calculate pointer to the first entry to be inspected */
+		entry = &lpm->tbl24[tbl_ind];
+
+		do {
+			/* Take the integer value from the pointer. */
+			entry_val = *(const uint32_t *)entry;
+			tbl_ind = entry_val & RTE_LPM6C_TBL8_BITMASK;
+
+			if ((entry_val & RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) !=
+					RTE_LPM6C_VALID_EXT_ENTRY_BITMASK) {
+				next_hops[j] = (entry_val & RTE_LPM6C_LOOKUP_SUCCESS) ?
+						  (int32_t)tbl_ind : -1;
+				break;
+			}
+
+			/*
+			 * If it is valid and extended we calculate the new pointer
+			 * to return.
+			 */
+			level = RTE_LPM6C_DEPTH(entry_val) + RTE_LPM6C_ROOT_LEV_BYTES - 1;
+			tbl = &lpm->tbl8[tbl_ind];
+
+			/*
+			 * if some levels were skipped then make sure that
+			 * the ip matches the ip address of a table we've jumped to,
+			 * i.e. check the ip's bytes corresponding the skipped levels.
+			 */
+			for (i = byte_ind; i < level; i++)
+				if (tbl->ip.a[i] != ip0->a[i]) {
+					next_hops[j] = tbl->lsp_next_hop ==
+							  RTE_LPM6C_UNDEF_NEXT_HOP ?
+						-1 : (int32_t)tbl->lsp_next_hop;
+					goto next_ip;
+				}
+
+			/* move ip byte index one byte further */
+			byte_ind = level + 1;
+			/* go to next level */
+			entry = &tbl->entries[ip0->a[level]];
+		} while (true);
+
+next_ip:;
+	}
+
+	return 0;
+}
+
+uint32_t
+rte_lpm6c_pool_pos(struct rte_lpm6c *lpm);
+
+uint32_t
+rte_lpm6c_used_rules(struct rte_lpm6c *lpm);
+
+__END_DECLS
+
+#endif
-- 
2.39.5 (Apple Git-154)

