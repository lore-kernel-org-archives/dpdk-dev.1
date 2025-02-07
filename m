Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F4C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 14:31:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 299C142E62;
	Fri,  7 Feb 2025 15:31:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BDCC6410E3;
 Fri,  7 Feb 2025 15:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738938683; x=1770474683;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L5j5LvKJ7F1665oV/aKLDcZGyxr15Ca1j7Lqwpti6cs=;
 b=bKC/ZrlQTLLsl944LtewzM8TsIQda8STRjHAngOkPE5Z5s6gTgTQNzS/
 KHOVp6jQXRjUnQBMewIP++qIgl1oT147kbT2zarsMjHKpeQMacokg7BZ4
 XHKDENQa8jfyXLSr8hq/yEFfsYPKE+3yfOs9fcWgJOv7AZsj3POe3JrvT
 6hTcqGdhGet5Hk/hNSXrPq+JA3SkeIXwa9LZrIlvEkdfBOONoimnthECw
 iarvnEKLGu8XXFFVMC+lxdwU6hVmpuNgN59UkaNF+KroimxWqoKF+dFwS
 a9lIwQ64bMXM5bRBWAYkPelHNFRbURzJi6jS0YQQmsqyZj3jYtUkobRx/ w==;
X-CSE-ConnectionGUID: +z4e4hNRTNGdJjM/2KTqag==
X-CSE-MsgGUID: xto4j9C9QoyXkQEF+H+kLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="64936452"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="64936452"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 06:31:22 -0800
X-CSE-ConnectionGUID: wMakghNjSaygx/rjzlZ+uQ==
X-CSE-MsgGUID: yHNTwGOXSnSDfS3TKNwDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="111322404"
Received: from silpixa00401385.ir.intel.com ([10.237.214.141])
 by orviesa009.jf.intel.com with ESMTP; 07 Feb 2025 06:31:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] test: improve resiliency of malloc autotest
Date: Fri,  7 Feb 2025 14:31:11 +0000
Message-ID: <20250207143111.850421-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117125912.985475-1-bruce.richardson@intel.com>
References: <20250117125912.985475-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The test case "test_multi_alloc_statistics" was brittle in that it did
some allocations and frees and then checked statistics without
considering the initial state of the malloc heaps. This meant that,
depending on what allocations/frees were done beforehand, the test can
sometimes fail.

We can improve resiliency by running the test using a new malloc heap,
which means it is unaffected by any previous allocations.

Bugzilla ID: 1579
Fixes: a40a1f8231b4 ("app: various tests update")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
v4:
* added cleanup support in case of failure, to allow multiple runs of
  the test in a single session.

v3:
* switched allocation from mmap to malloc allowing it work on windows
* use explicit alignment of the malloc return value to ensure memory
  added to heap is page-aligned.

v2:
* removed unnecessary extra include
* only added new code for non-windows, since using mmap for allocation.
---
 app/test/test_malloc.c | 77 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/app/test/test_malloc.c b/app/test/test_malloc.c
index 02a7d8ef20..d6f8da3b24 100644
--- a/app/test/test_malloc.c
+++ b/app/test/test_malloc.c
@@ -25,6 +25,7 @@
 #include <rte_malloc.h>
 #include <rte_cycles.h>
 #include <rte_random.h>
+#include <rte_eal_paging.h>
 #include <rte_string_fns.h>
 
 #define N 10000
@@ -267,11 +268,48 @@ test_str_to_size(void)
 static int
 test_multi_alloc_statistics(void)
 {
+	int ret = -1;  /* default return is error, cleared at end on success */
 	int socket = 0;
 	struct rte_malloc_socket_stats pre_stats, post_stats ,first_stats, second_stats;
 	size_t size = 2048;
 	int align = 1024;
 	int overhead = 0;
+	const size_t pgsz = rte_mem_page_size();
+	const size_t heap_size = (1 << 22);
+
+	if (pgsz > heap_size) {
+		printf("Page size (%zu) is bigger than heap size, skipping alloc stats test\n",
+				pgsz);
+		return TEST_SKIPPED;
+	}
+	if (heap_size % pgsz != 0) {
+		printf("Heap size (%zu) is not a multiple of page size (%zu), skipping alloc stats test\n",
+				heap_size, pgsz);
+		return TEST_SKIPPED;
+	}
+
+	if (rte_malloc_heap_create(__func__) != 0) {
+		printf("Failed to create test malloc heap\n");
+		goto end;
+	}
+
+	/* Allocate some memory using malloc and add it to our test heap. */
+	void *unaligned_memory = malloc(heap_size + pgsz);
+	if (unaligned_memory == NULL) {
+		printf("Failed to allocate memory\n");
+		goto cleanup_empty_heap;
+	}
+	void *memory = RTE_PTR_ALIGN(unaligned_memory, pgsz);
+	if (rte_malloc_heap_memory_add(__func__, memory, heap_size, NULL,
+			heap_size / pgsz, pgsz) != 0) {
+		printf("Failed to add memory to heap\n");
+		goto cleanup_allocated_memory;
+	}
+	socket = rte_malloc_heap_get_socket(__func__);
+	if (socket < 0) {
+		printf("Failed to get socket for test malloc heap.\n");
+		goto cleanup_all;
+	}
 
 	/* Dynamically calculate the overhead by allocating one cacheline and
 	 * then comparing what was allocated from the heap.
@@ -280,7 +318,7 @@ test_multi_alloc_statistics(void)
 
 	void *dummy = rte_malloc_socket(NULL, RTE_CACHE_LINE_SIZE, 0, socket);
 	if (dummy == NULL)
-		return -1;
+		goto cleanup_all;
 
 	rte_malloc_get_socket_stats(socket, &post_stats);
 
@@ -295,7 +333,8 @@ test_multi_alloc_statistics(void)
 
 	void *p1 = rte_malloc_socket("stats", size , align, socket);
 	if (!p1)
-		return -1;
+		goto cleanup_all;
+
 	rte_free(p1);
 	rte_malloc_dump_stats(stdout, "stats");
 
@@ -308,7 +347,7 @@ test_multi_alloc_statistics(void)
 			(post_stats.alloc_count != pre_stats.alloc_count) ||
 			(post_stats.free_count != pre_stats.free_count)) {
 		printf("Malloc statistics are incorrect - freed alloc\n");
-		return -1;
+		goto cleanup_all;
 	}
 	/* Check two consecutive allocations */
 	size = 1024;
@@ -316,12 +355,12 @@ test_multi_alloc_statistics(void)
 	rte_malloc_get_socket_stats(socket,&pre_stats);
 	void *p2 = rte_malloc_socket("add", size ,align, socket);
 	if (!p2)
-		return -1;
+		goto cleanup_all;
 	rte_malloc_get_socket_stats(socket,&first_stats);
 
 	void *p3 = rte_malloc_socket("add2", size,align, socket);
 	if (!p3)
-		return -1;
+		goto cleanup_all;
 
 	rte_malloc_get_socket_stats(socket,&second_stats);
 
@@ -333,34 +372,34 @@ test_multi_alloc_statistics(void)
 
 	if(second_stats.heap_totalsz_bytes != first_stats.heap_totalsz_bytes) {
 		printf("Incorrect heap statistics: Total size \n");
-		return -1;
+		goto cleanup_all;
 	}
 	/* Check allocated size is equal to two additions plus overhead */
 	if(second_stats.heap_allocsz_bytes !=
 			size + overhead + first_stats.heap_allocsz_bytes) {
 		printf("Incorrect heap statistics: Allocated size \n");
-		return -1;
+		goto cleanup_all;
 	}
 	/* Check that allocation count increments correctly i.e. +1 */
 	if (second_stats.alloc_count != first_stats.alloc_count + 1) {
 		printf("Incorrect heap statistics: Allocated count \n");
-		return -1;
+		goto cleanup_all;
 	}
 
 	if (second_stats.free_count != first_stats.free_count){
 		printf("Incorrect heap statistics: Free count \n");
-		return -1;
+		goto cleanup_all;
 	}
 
 	/* Make sure that we didn't touch our greatest chunk: 2 * 11M)  */
 	if (post_stats.greatest_free_size != pre_stats.greatest_free_size) {
 		printf("Incorrect heap statistics: Greatest free size \n");
-		return -1;
+		goto cleanup_all;
 	}
 	/* Free size must equal the original free size minus the new allocation*/
 	if (first_stats.heap_freesz_bytes <= second_stats.heap_freesz_bytes) {
 		printf("Incorrect heap statistics: Free size \n");
-		return -1;
+		goto cleanup_all;
 	}
 
 	if ((post_stats.heap_totalsz_bytes != pre_stats.heap_totalsz_bytes) ||
@@ -369,9 +408,21 @@ test_multi_alloc_statistics(void)
 			(post_stats.alloc_count != pre_stats.alloc_count) ||
 			(post_stats.free_count != pre_stats.free_count)) {
 		printf("Malloc statistics are incorrect - freed alloc\n");
-		return -1;
+		goto cleanup_all;
 	}
-	return 0;
+
+	/* set return value as success before cleanup */
+	ret = 0;
+
+	/* cleanup */
+cleanup_all:
+	rte_malloc_heap_memory_remove(__func__, memory, heap_size);
+cleanup_allocated_memory:
+	free(unaligned_memory);
+cleanup_empty_heap:
+	rte_malloc_heap_destroy(__func__);
+end:
+	return ret;
 }
 
 #ifdef RTE_EXEC_ENV_WINDOWS
-- 
2.43.0

