Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC33C021AA
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 02:02:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 53B2C4064F;
	Thu, 20 Feb 2025 03:02:02 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2D7F6402C4
 for <dev@dpdk.org>; Thu, 20 Feb 2025 03:01:49 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 9EDE6204E5B9; Wed, 19 Feb 2025 18:01:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EDE6204E5B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740016907;
 bh=2DGNjrpD188vdjHVy3SHJJFbQqq6ey+wlGBV+5HJMnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O/e1vNapWzUTijPeSa2XxF+gg03/4zQ2T1p8/yooo5jHt1S3NEoJD+6IQFEk1ocKm
 CJcgAsxFuom+qDMKOoquhIGnlEX6yv+ETBlBT3q2tPF3PVoaYQlr5VxQL8ZQygRvVU
 GgSoZJk/ZPZuICgny+Xn0Syp1FNkm/4lNsrsXgbk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 09/10] test: add workaround for __builtin_constant_p in
 test_memcpy_perf
Date: Wed, 19 Feb 2025 18:01:38 -0800
Message-Id: <1740016899-2817-10-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740016899-2817-1-git-send-email-andremue@linux.microsoft.com>
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

There's no MSVC equivalent for compiler extension __builtin_constant_p,
so a workaround is needed.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test/test_memcpy_perf.c | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/app/test/test_memcpy_perf.c b/app/test/test_memcpy_perf.c
index 5c05a84619..32c589c4ba 100644
--- a/app/test/test_memcpy_perf.c
+++ b/app/test/test_memcpy_perf.c
@@ -196,37 +196,37 @@ do {                                                                        \
 } while (0)
 
 /* Run aligned memcpy tests for each cached/uncached permutation */
-#define ALL_PERF_TESTS_FOR_SIZE(n)                                       \
-do {                                                                     \
-    if (__builtin_constant_p(n))                                         \
-        printf("\nC%6u", (unsigned)n);                                   \
-    else                                                                 \
-        printf("\n%7u", (unsigned)n);                                    \
-    SINGLE_PERF_TEST(small_buf_write, 1, 0, small_buf_read, 1, 0, n);    \
-    SINGLE_PERF_TEST(large_buf_write, 0, 0, small_buf_read, 1, 0, n);    \
-    SINGLE_PERF_TEST(small_buf_write, 1, 0, large_buf_read, 0, 0, n);    \
-    SINGLE_PERF_TEST(large_buf_write, 0, 0, large_buf_read, 0, 0, n);    \
+#define ALL_PERF_TESTS_FOR_SIZE(n)                                           \
+do {                                                                         \
+	if (__rte_constant(n))                                               \
+		printf("\nC%6u", (unsigned int)n);                           \
+	else                                                                 \
+		printf("\n%7u", (unsigned int)n);                            \
+	SINGLE_PERF_TEST(small_buf_write, 1, 0, small_buf_read, 1, 0, n);    \
+	SINGLE_PERF_TEST(large_buf_write, 0, 0, small_buf_read, 1, 0, n);    \
+	SINGLE_PERF_TEST(small_buf_write, 1, 0, large_buf_read, 0, 0, n);    \
+	SINGLE_PERF_TEST(large_buf_write, 0, 0, large_buf_read, 0, 0, n);    \
 } while (0)
 
 /* Run unaligned memcpy tests for each cached/uncached permutation */
-#define ALL_PERF_TESTS_FOR_SIZE_UNALIGNED(n)                             \
-do {                                                                     \
-    if (__builtin_constant_p(n))                                         \
-        printf("\nC%6u", (unsigned)n);                                   \
-    else                                                                 \
-        printf("\n%7u", (unsigned)n);                                    \
-    SINGLE_PERF_TEST(small_buf_write, 1, 1, small_buf_read, 1, 5, n);    \
-    SINGLE_PERF_TEST(large_buf_write, 0, 1, small_buf_read, 1, 5, n);    \
-    SINGLE_PERF_TEST(small_buf_write, 1, 1, large_buf_read, 0, 5, n);    \
-    SINGLE_PERF_TEST(large_buf_write, 0, 1, large_buf_read, 0, 5, n);    \
+#define ALL_PERF_TESTS_FOR_SIZE_UNALIGNED(n)                                 \
+do {                                                                         \
+	if (__rte_constant(n))                                               \
+		printf("\nC%6u", (unsigned int)n);                           \
+	else                                                                 \
+		printf("\n%7u", (unsigned int)n);                            \
+	SINGLE_PERF_TEST(small_buf_write, 1, 1, small_buf_read, 1, 5, n);    \
+	SINGLE_PERF_TEST(large_buf_write, 0, 1, small_buf_read, 1, 5, n);    \
+	SINGLE_PERF_TEST(small_buf_write, 1, 1, large_buf_read, 0, 5, n);    \
+	SINGLE_PERF_TEST(large_buf_write, 0, 1, large_buf_read, 0, 5, n);    \
 } while (0)
 
 /* Run memcpy tests for constant length */
-#define ALL_PERF_TEST_FOR_CONSTANT                                      \
-do {                                                                    \
-    TEST_CONSTANT(6U); TEST_CONSTANT(64U); TEST_CONSTANT(128U);         \
-    TEST_CONSTANT(192U); TEST_CONSTANT(256U); TEST_CONSTANT(512U);      \
-    TEST_CONSTANT(768U); TEST_CONSTANT(1024U); TEST_CONSTANT(1536U);    \
+#define ALL_PERF_TEST_FOR_CONSTANT                                          \
+do {                                                                        \
+	TEST_CONSTANT(6U); TEST_CONSTANT(64U); TEST_CONSTANT(128U);         \
+	TEST_CONSTANT(192U); TEST_CONSTANT(256U); TEST_CONSTANT(512U);      \
+	TEST_CONSTANT(768U); TEST_CONSTANT(1024U); TEST_CONSTANT(1536U);    \
 } while (0)
 
 /* Run all memcpy tests for aligned constant cases */
@@ -253,7 +253,7 @@ perf_test_variable_aligned(void)
 {
 	unsigned i;
 	for (i = 0; i < RTE_DIM(buf_sizes); i++) {
-		ALL_PERF_TESTS_FOR_SIZE((size_t)buf_sizes[i]);
+		ALL_PERF_TESTS_FOR_SIZE(buf_sizes[i]);
 	}
 }
 
@@ -263,7 +263,7 @@ perf_test_variable_unaligned(void)
 {
 	unsigned i;
 	for (i = 0; i < RTE_DIM(buf_sizes); i++) {
-		ALL_PERF_TESTS_FOR_SIZE_UNALIGNED((size_t)buf_sizes[i]);
+		ALL_PERF_TESTS_FOR_SIZE_UNALIGNED(buf_sizes[i]);
 	}
 }
 
-- 
2.48.1.vfs.0.0

