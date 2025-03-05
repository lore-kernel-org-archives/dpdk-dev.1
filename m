Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA7AC19F32
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Mar 2025 16:38:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D8F40662;
	Wed,  5 Mar 2025 17:38:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 181C84025F
 for <dev@dpdk.org>; Wed,  5 Mar 2025 17:38:19 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CF81F210EAE9; Wed,  5 Mar 2025 08:38:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF81F210EAE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741192697;
 bh=6BoPOHT8OZfYayOWidZYKnTeWbG4ajjL1s0iOxGbB4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jeTJaO8UASai7oPjhUBOdEwXVU9vLUZ9Y1R2/P1P5vPFmNCTkMbb8/E/vLJ6hjQ/1
 I4n5S4an7yJSHMRfdAITHvkeBnYmr9N6bzVhNzhHdR6lYO+pJxy6Q0ZL0XUuzqg3jk
 XOkbFFlQcWaYnjy9AAkAxLqTp+q2ToBldlaA4rNk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org,
	mb@smartsharesystems.com
Subject: [PATCH v3 5/5] app/test: add tests for portable version of
 __builtin_add_overflow
Date: Wed,  5 Mar 2025 08:38:10 -0800
Message-Id: <1741192690-26243-6-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
References: <1735857169-19131-1-git-send-email-andremue@linux.microsoft.com>
 <1741192690-26243-1-git-send-email-andremue@linux.microsoft.com>
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

__builtin_add_overflow is gcc specific. There's a need for a portable
version that can also be used with other compilers.

This patch adds tests for these new portable functions, to confirm
they behave the same way across different compilers.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/meson.build |   1 +
 app/test/test_math.c | 170 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)
 create mode 100644 app/test/test_math.c

diff --git a/app/test/meson.build b/app/test/meson.build
index b6285a6b45..05541c2d0f 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -118,6 +118,7 @@ source_file_deps = {
     'test_lpm_perf.c': ['net', 'lpm'],
     'test_malloc.c': [],
     'test_malloc_perf.c': [],
+    'test_math.c': [],
     'test_mbuf.c': ['net'],
     'test_mcslock.c': [],
     'test_member.c': ['member', 'net'],
diff --git a/app/test/test_math.c b/app/test/test_math.c
new file mode 100644
index 0000000000..5b53eba71d
--- /dev/null
+++ b/app/test/test_math.c
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C) 2025 Microsoft Corporation
+ */
+
+#include <rte_math.h>
+#include <rte_debug.h>
+
+#include "test.h"
+#include <inttypes.h>
+
+/* Check condition and return if true. */
+#define TEST_MATH_RETURN_IF_ERROR(X) \
+do { \
+	if (X) { \
+		return -1; \
+	} \
+} while (0)
+
+RTE_LOG_REGISTER(math_logtype_test, test.math, INFO);
+
+static int
+verify_add_overflow8(uint8_t a, uint8_t b,
+		uint8_t expected_res, uint8_t expected_overflow)
+{
+	uint8_t res;
+	uint8_t overflow = rte_add_overflow(a, b, &res);
+	RTE_TEST_ASSERT_EQUAL(res, expected_res,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned result 0x%x,"
+			" but 0x%x was expected.", a, b, res, expected_res);
+	RTE_TEST_ASSERT_EQUAL(overflow, expected_overflow,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned overflow 0x%x,"
+			" but 0x%x was expected.", a, b, overflow, expected_overflow);
+
+	return 0;
+}
+
+static int
+verify_add_overflow16(uint16_t a, uint16_t b,
+		uint16_t expected_res, uint8_t expected_overflow)
+{
+	uint16_t res;
+	uint8_t overflow = rte_add_overflow(a, b, &res);
+	RTE_TEST_ASSERT_EQUAL(res, expected_res,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned result 0x%x,"
+			" but 0x%x was expected.", a, b, res, expected_res);
+	RTE_TEST_ASSERT_EQUAL(overflow, expected_overflow,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned overflow 0x%x,"
+			" but 0x%x was expected.", a, b, overflow, expected_overflow);
+
+	return 0;
+}
+
+static int
+verify_add_overflow32(uint32_t a, uint32_t b,
+		uint32_t expected_res, uint8_t expected_overflow)
+{
+	uint32_t res;
+	uint8_t overflow = rte_add_overflow(a, b, &res);
+	RTE_TEST_ASSERT_EQUAL(res, expected_res,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned result 0x%x,"
+			" but 0x%x was expected.", a, b, res, expected_res);
+	RTE_TEST_ASSERT_EQUAL(overflow, expected_overflow,
+			"ERROR: rte_add_overflow(0x%x, 0x%x) returned overflow 0x%x,"
+			" but 0x%x was expected.", a, b, overflow, expected_overflow);
+
+	return 0;
+}
+
+static int
+verify_add_overflow64(uint64_t a, uint64_t b,
+		uint64_t expected_res, uint8_t expected_overflow)
+{
+	uint64_t res;
+	uint8_t overflow = rte_add_overflow(a, b, &res);
+	RTE_TEST_ASSERT_EQUAL(res, expected_res,
+			"ERROR: rte_add_overflow(0x%" PRIx64 ", 0x%" PRIx64 ") returned"
+			" result 0x%" PRIx64 ", but 0x%" PRIx64 " was expected.",
+			a, b, res, expected_res);
+	RTE_TEST_ASSERT_EQUAL(res, expected_res,
+			"ERROR: rte_add_overflow(0x%" PRIx64 ", 0x%" PRIx64 ") returned"
+			" overflow 0x%x, but 0x%x was expected.",
+			a, b, overflow, expected_overflow);
+
+	return 0;
+}
+
+static int
+test_add_overflow8(void)
+{
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(0, 0, 0, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(0, 1, 1, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(0, 0xFF, 0xFF, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(1, 0xFF, 0, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(2, 0xFF, 1, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(4, 0xFE, 2, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow8(0xFF, 0xFF, 0xFE, 1));
+
+	return 0;
+}
+
+static int
+test_add_overflow16(void)
+{
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(0, 0, 0, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(0, 1, 1, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(0, 0xFFFF, 0xFFFF, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(1, 0xFFFF, 0, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(2, 0xFFFF, 1, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(4, 0xFFFE, 2, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow16(
+			0xFFFF, 0xFFFF, 0xFFFE, 1));
+
+	return 0;
+}
+
+static int
+test_add_overflow32(void)
+{
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(0, 0, 0, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(0, 1, 1, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(
+			0, 0xFFFFFFFF, 0xFFFFFFFF, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(1, 0xFFFFFFFF, 0, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(2, 0xFFFFFFFF, 1, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(4, 0xFFFFFFFE, 2, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow32(
+			0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFE, 1));
+
+	return 0;
+}
+
+static int
+test_add_overflow64(void)
+{
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(0, 0, 0, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(0, 1, 1, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(
+			0, 0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF, 0));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(
+			1, 0xFFFFFFFFFFFFFFFF, 0, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(
+			2, 0xFFFFFFFFFFFFFFFF, 1, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(
+			4, 0xFFFFFFFFFFFFFFFE, 2, 1));
+	TEST_MATH_RETURN_IF_ERROR(verify_add_overflow64(
+			0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFE, 1));
+
+	return 0;
+}
+
+static struct unit_test_suite math_test_suite = {
+	.suite_name = "math autotest",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_add_overflow8),
+		TEST_CASE(test_add_overflow16),
+		TEST_CASE(test_add_overflow32),
+		TEST_CASE(test_add_overflow64),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_math(void)
+{
+	return unit_test_suite_runner(&math_test_suite);
+}
+
+REGISTER_FAST_TEST(math_autotest, true, true, test_math);
-- 
2.48.1.vfs.0.0

