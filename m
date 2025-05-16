Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5840BC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 13:22:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7AC04060B;
	Fri, 16 May 2025 15:22:22 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 88A21402ED
 for <dev@dpdk.org>; Fri, 16 May 2025 15:22:20 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D745C201DB26; Fri, 16 May 2025 06:22:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D745C201DB26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747401739;
 bh=J0lPR4tp0bPMAq+HoWO5msnUv4voz1LicTvpiDHs83I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F8U+IFPOJujYd780ZbnvEMXfHEsDa+I8BP4gJU+B1BZ7avqO+QA0arJs3SwmgR2aB
 42Fi3J2wv/kwioABB+ZP6R4AqiPMffF6UEf71j5l1cTap6sR/rmvZokPS1UhOklEBT
 NxPkZlM0/AlIwnmUzWYsNutOhPNhni/jGfoQl5sg=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: 
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 2/2] test/strsep: add tests for function strsep()
Date: Fri, 16 May 2025 06:22:14 -0700
Message-Id: <1747401734-6303-2-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
References: <1747401734-6303-1-git-send-email-andremue@linux.microsoft.com>
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

This patch adds tests for the strsep() function.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/meson.build   |   1 +
 app/test/test_strsep.c | 108 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 app/test/test_strsep.c

diff --git a/app/test/meson.build b/app/test/meson.build
index b6285a6b45..ec5a1fbae3 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -184,6 +184,7 @@ source_file_deps = {
     'test_stack.c': ['stack'],
     'test_stack_perf.c': ['stack'],
     'test_string_fns.c': [],
+    'test_strsep.c': [],
     'test_table.c': ['table', 'pipeline', 'port'],
     'test_table_acl.c': ['net', 'table', 'pipeline', 'port'],
     'test_table_combined.c': ['table', 'pipeline', 'port'],
diff --git a/app/test/test_strsep.c b/app/test/test_strsep.c
new file mode 100644
index 0000000000..19df8f31ee
--- /dev/null
+++ b/app/test/test_strsep.c
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C) 2025 Microsoft Corporation
+ */
+
+#include <string.h>
+#include <rte_os_shim.h>
+
+#include "test.h"
+
+static int
+test_strsep_helper(const char *str, const char *delim,
+		   const char * const expected_tokens[], size_t expected_tokens_count)
+{
+	char *s = str != NULL ? strdup(str) : NULL;
+	const char *token;
+	for (size_t i = 0; i < expected_tokens_count; i++) {
+		token = strsep(&s, delim);
+		if (token == NULL) {
+			printf("Expected token '%s', got NULL\n", expected_tokens[i]);
+			free(s);
+			return TEST_FAILED;
+		}
+		if (strcmp(expected_tokens[i], token) != 0) {
+			printf("Expected '%s', got '%s'\n", expected_tokens[i], token);
+			free(s);
+			return TEST_FAILED;
+		}
+	}
+	/* Check that there are no more tokens left */
+	token = strsep(&s, delim);
+	if (token != NULL) {
+		printf("Expected NULL, got '%s'\n", token);
+		free(s);
+		return TEST_FAILED;
+	}
+	free(s);
+	return TEST_SUCCESS;
+}
+
+static int
+test_strsep_single_delimiter(void)
+{
+	const char *str = "hello,world";
+	const char *delim = ",";
+	static const char * const expected_tokens[] = { "hello", "world" };
+	const size_t expected_tokens_count = RTE_DIM(expected_tokens);
+	return test_strsep_helper(str, delim, expected_tokens, expected_tokens_count);
+}
+
+static int
+test_strsep_multiple_delimiters(void)
+{
+	const char *str = "hello,world;this:is;a:test";
+	const char *delim = ",;:";
+	static const char * const expected_tokens[] = {"hello", "world", "this", "is", "a", "test"};
+	const size_t expected_tokens_count = RTE_DIM(expected_tokens);
+	return test_strsep_helper(str, delim, expected_tokens, expected_tokens_count);
+}
+
+static int
+test_strsep_string_with_no_delimiters(void)
+{
+	const char *str = "helloworld";
+	const char *delim = ",";
+	static const char * const expected_tokens[] = {"helloworld"};
+	const size_t expected_tokens_count = RTE_DIM(expected_tokens);
+	return test_strsep_helper(str, delim, expected_tokens, expected_tokens_count);
+}
+
+static int
+test_strsep_empty_string(void)
+{
+	const char *str = "";
+	const char *delim = ",";
+	static const char * const expected_tokens[] = {""};
+	const size_t expected_tokens_count = RTE_DIM(expected_tokens);
+	return test_strsep_helper(str, delim, expected_tokens, expected_tokens_count);
+}
+
+static int
+test_strsep_null(void)
+{
+	const char *str = NULL;
+	const char *delim = ",";
+	static const char * const expected_tokens[] = {""};
+	const size_t expected_tokens_count = 0;
+	return test_strsep_helper(str, delim, expected_tokens, expected_tokens_count);
+}
+
+static struct unit_test_suite test_suite = {
+	.suite_name = "Strsep test suite",
+	.unit_test_cases = {
+		TEST_CASE(test_strsep_single_delimiter),
+		TEST_CASE(test_strsep_multiple_delimiters),
+		TEST_CASE(test_strsep_string_with_no_delimiters),
+		TEST_CASE(test_strsep_empty_string),
+		TEST_CASE(test_strsep_null),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_strsep(void)
+{
+	return unit_test_suite_runner(&test_suite);
+}
+
+REGISTER_FAST_TEST(strsep_autotest, true, true, test_strsep);
-- 
2.49.0.vfs.0.3

