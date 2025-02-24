Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5DC021A4
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 16:25:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BACC427C0;
	Mon, 24 Feb 2025 17:25:10 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 17C0C4278C
 for <dev@dpdk.org>; Mon, 24 Feb 2025 17:24:51 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id CED64203CDE5; Mon, 24 Feb 2025 08:24:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CED64203CDE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740414289;
 bh=wYYTud1Twy+N5bGPeAob6hgg7/vUDnk7IhEhautTOFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=llcswE9V+ax+R+DfkeOo9ENkNNArM7LdjhwPmT3Oh1zHXpt94rEZwj0Fuw0XRObvc
 kW9tizAXZns2BbUo5hsnjWAE5Nj66ArflQoXi2n9UTd/GaOpA4zGuosUraxk8nv9GS
 ewsPW4Cm/U0bZ0sF27GGf9p2xBREXIL0B+gqAf+8=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v6 09/10] test: add workaround for __builtin_constant_p in
 test_memcpy_perf
Date: Mon, 24 Feb 2025 08:24:24 -0800
Message-Id: <1740414265-12217-10-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1740414265-12217-1-git-send-email-andremue@linux.microsoft.com>
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
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
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

