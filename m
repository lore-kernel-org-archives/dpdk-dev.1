Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B70EC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015F440EE6;
	Tue, 11 Feb 2025 23:02:55 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2ED1A402EF
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:02:42 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 88B84210D0EA; Tue, 11 Feb 2025 14:02:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88B84210D0EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739311361;
 bh=UFXiy9HReA64AGf5nJ/Jy5sr+JmCIFUNRf+KfkVM/gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cr1tz0DwBXf4OZT6sq+sojP6ShpxrIqdUCGf10RopkLqXPddQjR2K5VXIX8LwCzer
 aP/UnC36iEKqjxc12gAqP5Ax4vmuqhqY7+ubyGOZNZWQ/roFybo3OhndqBY3QDeuea
 9DZU1bDO8IxkKuhBT/GkwViRMPu/8VMxvr9ef+GQ=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH 09/10] test: add workaround for __builtin_constant_p in
 test_memcpy_perf
Date: Tue, 11 Feb 2025 14:02:05 -0800
Message-Id: <1739311325-14425-10-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
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
 app/test/test_memcpy_perf.c | 106 ++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/app/test/test_memcpy_perf.c b/app/test/test_memcpy_perf.c
index 5c05a84619..6091b6f9dd 100644
--- a/app/test/test_memcpy_perf.c
+++ b/app/test/test_memcpy_perf.c
@@ -167,66 +167,66 @@ do_uncached_write(uint8_t *dst, int is_dst_cached,
  * Run a single memcpy performance test. This is a macro to ensure that if
  * the "size" parameter is a constant it won't be converted to a variable.
  */
-#define SINGLE_PERF_TEST(dst, is_dst_cached, dst_uoffset,                   \
-                         src, is_src_cached, src_uoffset, size)             \
-do {                                                                        \
-    unsigned int iter, t;                                                   \
-    size_t dst_addrs[TEST_BATCH_SIZE], src_addrs[TEST_BATCH_SIZE];          \
-    uint64_t start_time, total_time = 0;                                    \
-    uint64_t total_time2 = 0;                                               \
-    for (iter = 0; iter < (TEST_ITERATIONS / TEST_BATCH_SIZE); iter++) {    \
-        fill_addr_arrays(dst_addrs, is_dst_cached, dst_uoffset,             \
-                         src_addrs, is_src_cached, src_uoffset);            \
-        start_time = rte_rdtsc();                                           \
-        for (t = 0; t < TEST_BATCH_SIZE; t++)                               \
-            rte_memcpy(dst+dst_addrs[t], src+src_addrs[t], size);           \
-        total_time += rte_rdtsc() - start_time;                             \
-    }                                                                       \
-    for (iter = 0; iter < (TEST_ITERATIONS / TEST_BATCH_SIZE); iter++) {    \
-        fill_addr_arrays(dst_addrs, is_dst_cached, dst_uoffset,             \
-                         src_addrs, is_src_cached, src_uoffset);            \
-        start_time = rte_rdtsc();                                           \
-        for (t = 0; t < TEST_BATCH_SIZE; t++)                               \
-            memcpy(dst+dst_addrs[t], src+src_addrs[t], size);               \
-        total_time2 += rte_rdtsc() - start_time;                            \
-    }                                                                       \
-    printf("%3.0f -", (double)total_time  / TEST_ITERATIONS);                 \
-    printf("%3.0f",   (double)total_time2 / TEST_ITERATIONS);                 \
-    printf("(%6.2f%%) ", ((double)total_time - total_time2)*100/total_time2); \
+#define SINGLE_PERF_TEST(dst, is_dst_cached, dst_uoffset,                         \
+			 src, is_src_cached, src_uoffset, size)                   \
+do {                                                                              \
+	unsigned int iter, t;                                                     \
+	size_t dst_addrs[TEST_BATCH_SIZE], src_addrs[TEST_BATCH_SIZE];            \
+	uint64_t start_time, total_time = 0;                                      \
+	uint64_t total_time2 = 0;                                                 \
+	for (iter = 0; iter < (TEST_ITERATIONS / TEST_BATCH_SIZE); iter++) {      \
+		fill_addr_arrays(dst_addrs, is_dst_cached, dst_uoffset,           \
+				 src_addrs, is_src_cached, src_uoffset);          \
+		start_time = rte_rdtsc();                                         \
+		for (t = 0; t < TEST_BATCH_SIZE; t++)                             \
+			rte_memcpy(dst+dst_addrs[t], src+src_addrs[t], size);     \
+		total_time += rte_rdtsc() - start_time;                           \
+	}                                                                         \
+	for (iter = 0; iter < (TEST_ITERATIONS / TEST_BATCH_SIZE); iter++) {      \
+		fill_addr_arrays(dst_addrs, is_dst_cached, dst_uoffset,           \
+				 src_addrs, is_src_cached, src_uoffset);          \
+		start_time = rte_rdtsc();                                         \
+		for (t = 0; t < TEST_BATCH_SIZE; t++)                             \
+			memcpy(dst+dst_addrs[t], src+src_addrs[t], size);         \
+		total_time2 += rte_rdtsc() - start_time;                          \
+	}                                                                         \
+	printf("%3.0f -", (double)total_time  / TEST_ITERATIONS);                 \
+	printf("%3.0f",   (double)total_time2 / TEST_ITERATIONS);                 \
+	printf("(%6.2f%%) ", ((double)total_time - total_time2)*100/total_time2); \
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
+#define ALL_PERF_TESTS_FOR_SIZE(n, def)                                      \
+do {                                                                         \
+	if (__rte_constant_with_default(n, def))                             \
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
+#define ALL_PERF_TESTS_FOR_SIZE_UNALIGNED(n, def)                            \
+do {                                                                         \
+	if (__rte_constant_with_default(n, def))                             \
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
+#define ALL_PERF_TEST_FOR_CONSTANT                                                \
+do {                                                                              \
+	TEST_CONSTANT(6U, 1); TEST_CONSTANT(64U, 1); TEST_CONSTANT(128U, 1);      \
+	TEST_CONSTANT(192U, 1); TEST_CONSTANT(256U, 1); TEST_CONSTANT(512U, 1);   \
+	TEST_CONSTANT(768U, 1); TEST_CONSTANT(1024U, 1); TEST_CONSTANT(1536U, 1); \
 } while (0)
 
 /* Run all memcpy tests for aligned constant cases */
@@ -253,7 +253,7 @@ perf_test_variable_aligned(void)
 {
 	unsigned i;
 	for (i = 0; i < RTE_DIM(buf_sizes); i++) {
-		ALL_PERF_TESTS_FOR_SIZE((size_t)buf_sizes[i]);
+		ALL_PERF_TESTS_FOR_SIZE(buf_sizes[i], 0);
 	}
 }
 
@@ -263,7 +263,7 @@ perf_test_variable_unaligned(void)
 {
 	unsigned i;
 	for (i = 0; i < RTE_DIM(buf_sizes); i++) {
-		ALL_PERF_TESTS_FOR_SIZE_UNALIGNED((size_t)buf_sizes[i]);
+		ALL_PERF_TESTS_FOR_SIZE_UNALIGNED(buf_sizes[i], 0);
 	}
 }
 
-- 
2.47.2.vfs.0.1

