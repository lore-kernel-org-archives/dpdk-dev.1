Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8468BCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 10:37:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC18340653;
	Mon, 25 May 2026 12:37:15 +0200 (CEST)
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by mails.dpdk.org (Postfix) with ESMTP id F276E4065B
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705434;
 bh=kQiHUOhxUePeG7kdiV6j+k4upiNgo0deQNFCYjk6kn4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dm6sxi0PNbdt9CcFzUSb88MrNK96iOzwlxkuT9cWUcmGP83uY+8wvEw5W5SEUooDy
 +VK2cmgtA4+HnYktujBY4rlxB8Yxnt7eWZGOmcAubPWw/5s7uecA4tmHmSQtLwVE/I
 2kTcsb7f6JeuQ4bWfUo5zKnNudiURm/8f2gWPAnJsxWx8+z/zszSSjqG8rBa9DIzWx
 RZDikHznFETJ+yaFuy3DgfPKImxqNOyu2nH1oidH650PcHma3ZEQV1JGrUlh4LG4jL
 C5H85TkinDl3r704p1i8V8jGQCyUXa5WDDTOUh6TnbjuAqqnDJUJMiDh0nvH+oQf1F
 m7aWLE1ZGfsJg==
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
 by mail.lysator.liu.se (Postfix) with ESMTP id 9A1FA190CD
 for <dev@dpdk.org>; Mon, 25 May 2026 12:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705434;
 bh=kQiHUOhxUePeG7kdiV6j+k4upiNgo0deQNFCYjk6kn4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dm6sxi0PNbdt9CcFzUSb88MrNK96iOzwlxkuT9cWUcmGP83uY+8wvEw5W5SEUooDy
 +VK2cmgtA4+HnYktujBY4rlxB8Yxnt7eWZGOmcAubPWw/5s7uecA4tmHmSQtLwVE/I
 2kTcsb7f6JeuQ4bWfUo5zKnNudiURm/8f2gWPAnJsxWx8+z/zszSSjqG8rBa9DIzWx
 RZDikHznFETJ+yaFuy3DgfPKImxqNOyu2nH1oidH650PcHma3ZEQV1JGrUlh4LG4jL
 C5H85TkinDl3r704p1i8V8jGQCyUXa5WDDTOUh6TnbjuAqqnDJUJMiDh0nvH+oQf1F
 m7aWLE1ZGfsJg==
Received: by mail.lysator.liu.se (Postfix, from userid 1004)
 id 751911912E; Mon, 25 May 2026 12:37:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lysator.liu.se;
 s=2026; t=1779705415;
 bh=kQiHUOhxUePeG7kdiV6j+k4upiNgo0deQNFCYjk6kn4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JtKxjfo+qVHis6PAE/jgB67OVHyH6K8P0zDQNDyMp8nVu2yRT3qK0gftOd3533OrZ
 7LqM1KYhOoraSAbWBmc7YUeuo/kbvrfZ3d5uUHF35IXc0XRAe3ZRVbEQbWN24NUE7j
 in2wOq2eEtrWC0EvCJQEahmQMUHa6q9BTt4gceOqcsrHH+6lBVn5fM86gLzNaa8z2P
 dT4EMBGo0bFfwtwa1wdCWOM8zEU6J4XXvCOIOw65a9N0gu+aWGvdLruqBPMQQkrCwv
 qyGCcppM8YyItxMWHjduuG5caxZDV0Fx8SyvALm1huKQaICB6Y8zxvn41/bk8XJeY/
 HKBEa2o75JPCw==
Received: from isengard.friendlyfire.se (h-62-63-215-114.A163.priv.bahnhof.se
 [62.63.215.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by mail.lysator.liu.se (Postfix) with ESMTPSA id 309E8190BB;
 Mon, 25 May 2026 12:36:55 +0200 (CEST)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 Yogaraj Baskaravel <yogaraj.baskaravel@ericsson.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>
Subject: [RFC 3/3] app/test: add fastmem test suite
Date: Mon, 25 May 2026 12:36:42 +0200
Message-ID: <20260525103642.55255-4-hofors@lysator.liu.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525103642.55255-1-hofors@lysator.liu.se>
References: <20260525103642.55255-1-hofors@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Mattias Rönnblom <mattias.ronnblom@ericsson.com>

Add functional, performance, and profiling test suites for the
fastmem library.

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
---
 app/test/meson.build            |    3 +
 app/test/test_fastmem.c         | 1682 +++++++++++++++++++++++++++++++
 app/test/test_fastmem_perf.c    |  997 ++++++++++++++++++
 app/test/test_fastmem_profile.c |  157 +++
 4 files changed, 2839 insertions(+)
 create mode 100644 app/test/test_fastmem.c
 create mode 100644 app/test/test_fastmem_perf.c
 create mode 100644 app/test/test_fastmem_profile.c

diff --git a/app/test/meson.build b/app/test/meson.build
index 7d458f9c07..d11c63be6f 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -82,6 +82,9 @@ source_file_deps = {
     'test_event_vector_adapter.c': ['eventdev', 'bus_vdev'],
     'test_eventdev.c': ['eventdev', 'bus_vdev'],
     'test_external_mem.c': [],
+    'test_fastmem.c': ['fastmem'],
+    'test_fastmem_perf.c': ['fastmem', 'mempool'],
+    'test_fastmem_profile.c': ['fastmem'],
     'test_fbarray.c': [],
     'test_fib.c': ['net', 'fib'],
     'test_fib6.c': ['rib', 'fib'],
diff --git a/app/test/test_fastmem.c b/app/test/test_fastmem.c
new file mode 100644
index 0000000000..c79ea95481
--- /dev/null
+++ b/app/test/test_fastmem.c
@@ -0,0 +1,1682 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdalign.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_errno.h>
+#include <rte_lcore.h>
+#include <rte_memory.h>
+#include <rte_memzone.h>
+#include <rte_thread.h>
+
+#include <rte_fastmem.h>
+
+#include "test.h"
+
+#define FASTMEM_MEMZONE_SIZE (128U << 20)
+
+/*
+ * Count memzones whose names begin with the fastmem prefix.
+ * Used to verify that rte_fastmem_reserve() really did reserve
+ * backing memzones.
+ */
+static int fastmem_memzone_count;
+
+static void
+count_fastmem_memzones_walk(const struct rte_memzone *mz, void *arg)
+{
+	RTE_SET_USED(arg);
+
+	if (strncmp(mz->name, "fastmem_", strlen("fastmem_")) == 0)
+		fastmem_memzone_count++;
+}
+
+static unsigned int
+count_fastmem_memzones(void)
+{
+	fastmem_memzone_count = 0;
+	rte_memzone_walk(count_fastmem_memzones_walk, NULL);
+	return fastmem_memzone_count;
+}
+
+static int
+test_init_deinit(void)
+{
+	int rc;
+
+	rc = rte_fastmem_init();
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_init() failed: %d", rc);
+
+	rte_fastmem_deinit();
+
+	/* A subsequent init/deinit cycle must succeed. */
+	rc = rte_fastmem_init();
+	TEST_ASSERT_EQUAL(rc, 0, "second rte_fastmem_init() failed: %d", rc);
+
+	rte_fastmem_deinit();
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_init_is_not_idempotent(void)
+{
+	int rc;
+
+	rc = rte_fastmem_init();
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_init() failed: %d", rc);
+
+	rc = rte_fastmem_init();
+	TEST_ASSERT_EQUAL(rc, -EBUSY,
+		"expected -EBUSY on re-init, got %d", rc);
+
+	rte_fastmem_deinit();
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_deinit_without_init(void)
+{
+	/* Must be a no-op, not a crash. */
+	rte_fastmem_deinit();
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_max_size(void)
+{
+	size_t max;
+
+	max = rte_fastmem_max_size();
+	TEST_ASSERT(max >= (1U << 20),
+		"max_size=%zu below required 1 MiB minimum", max);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_small(void)
+{
+	int socket_id;
+	unsigned int before, after;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no available sockets");
+
+	before = count_fastmem_memzones();
+
+	/*
+	 * A small reserve request (1 byte) must result in exactly
+	 * one memzone reservation: the internal rounding is to
+	 * memzone granularity.
+	 */
+	rc = rte_fastmem_reserve(1, socket_id);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_reserve() failed: %d", rc);
+
+	after = count_fastmem_memzones();
+	TEST_ASSERT_EQUAL(after - before, 1,
+		"expected 1 new memzone, got %u", after - before);
+
+	rte_fastmem_deinit();
+
+	/* After deinit the memzones must be released. */
+	TEST_ASSERT_EQUAL(count_fastmem_memzones(), 0,
+		"%u fastmem memzones leaked after deinit",
+		count_fastmem_memzones());
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_multiple_memzones(void)
+{
+	int socket_id;
+	unsigned int before, after;
+	size_t reserve_size;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no available sockets");
+
+	before = count_fastmem_memzones();
+
+	/*
+	 * Request just over one memzone's worth; this must force
+	 * a second memzone to be reserved.
+	 */
+	reserve_size = FASTMEM_MEMZONE_SIZE + 1;
+	rc = rte_fastmem_reserve(reserve_size, socket_id);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_reserve(%zu) failed: %d",
+		reserve_size, rc);
+
+	after = count_fastmem_memzones();
+	TEST_ASSERT_EQUAL(after - before, 2,
+		"expected 2 new memzones for %zu-byte reserve, got %u",
+		reserve_size, after - before);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_cumulative(void)
+{
+	int socket_id;
+	unsigned int after_first, after_second;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no available sockets");
+
+	rc = rte_fastmem_reserve(FASTMEM_MEMZONE_SIZE, socket_id);
+	TEST_ASSERT_EQUAL(rc, 0, "first reserve failed: %d", rc);
+
+	after_first = count_fastmem_memzones();
+
+	/*
+	 * A second call requesting the same amount that's already
+	 * reserved must not trigger any new memzone reservation.
+	 */
+	rc = rte_fastmem_reserve(FASTMEM_MEMZONE_SIZE, socket_id);
+	TEST_ASSERT_EQUAL(rc, 0, "second reserve failed: %d", rc);
+
+	after_second = count_fastmem_memzones();
+	TEST_ASSERT_EQUAL(after_first, after_second,
+		"reserve of already-reserved amount added memzones (%u -> %u)",
+		after_first, after_second);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_invalid_socket(void)
+{
+	int rc;
+
+	rc = rte_fastmem_reserve(1, RTE_MAX_NUMA_NODES);
+	TEST_ASSERT_EQUAL(rc, -EINVAL,
+		"expected -EINVAL for out-of-range socket, got %d", rc);
+
+	rc = rte_fastmem_reserve(1, -2);
+	TEST_ASSERT_EQUAL(rc, -EINVAL,
+		"expected -EINVAL for negative socket, got %d", rc);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_without_init(void)
+{
+	int rc;
+
+	rc = rte_fastmem_reserve(1, SOCKET_ID_ANY);
+	TEST_ASSERT(rc < 0,
+		"expected failure without init, got %d", rc);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_reserve_any_socket(void)
+{
+	unsigned int before, after;
+	int rc;
+
+	before = count_fastmem_memzones();
+
+	/*
+	 * SOCKET_ID_ANY should succeed on any system with at least
+	 * one configured socket. The allocator picks the caller's
+	 * socket first and falls back to other sockets if needed.
+	 */
+	rc = rte_fastmem_reserve(1, SOCKET_ID_ANY);
+	TEST_ASSERT_EQUAL(rc, 0,
+		"rte_fastmem_reserve(SOCKET_ID_ANY) failed: %d", rc);
+
+	after = count_fastmem_memzones();
+	TEST_ASSERT_EQUAL(after - before, 1,
+		"expected 1 new memzone, got %u", after - before);
+
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Stage 2 tests: allocation and free.
+ */
+
+static int
+test_alloc_too_big(void)
+{
+	void *p;
+	int rc;
+
+	rte_errno = 0;
+	p = rte_fastmem_alloc(rte_fastmem_max_size() + 1, 0, 0);
+	TEST_ASSERT_NULL(p, "alloc above max_size returned non-NULL");
+	TEST_ASSERT_EQUAL(rte_errno, E2BIG,
+		"expected rte_errno=E2BIG, got %d", rte_errno);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_invalid_align(void)
+{
+	void *p;
+	int rc;
+
+	rte_errno = 0;
+	p = rte_fastmem_alloc(16, 3, 0); /* 3 is not a power of 2 */
+	TEST_ASSERT_NULL(p, "alloc with align=3 returned non-NULL");
+	TEST_ASSERT_EQUAL(rte_errno, EINVAL,
+		"expected rte_errno=EINVAL, got %d", rte_errno);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_free_small(void)
+{
+	void *p;
+	int rc;
+
+	p = rte_fastmem_alloc(8, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "alloc(8) failed: rte_errno=%d", rte_errno);
+
+	/* Writing into the object must not crash. */
+	memset(p, 0xa5, 8);
+
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_free_various_sizes(void)
+{
+	static const size_t sizes[] = {
+		1, 8, 16, 17, 63, 64, 128, 1024, 4096,
+		64 * 1024, 256 * 1024, 1024 * 1024,
+	};
+	void *ptrs[RTE_DIM(sizes)];
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < RTE_DIM(sizes); i++) {
+		ptrs[i] = rte_fastmem_alloc(sizes[i], 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i],
+			"alloc(%zu) failed: rte_errno=%d",
+			sizes[i], rte_errno);
+		memset(ptrs[i], 0x5a, sizes[i]);
+	}
+
+	for (i = 0; i < RTE_DIM(sizes); i++)
+		rte_fastmem_free(ptrs[i]);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_alignment(void)
+{
+	static const size_t aligns[] = {
+		8, 16, 64, 256, 4096, 65536,
+	};
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < RTE_DIM(aligns); i++) {
+		void *p = rte_fastmem_alloc(1, aligns[i], 0);
+
+		TEST_ASSERT_NOT_NULL(p,
+			"alloc(1, align=%zu) failed: rte_errno=%d",
+			aligns[i], rte_errno);
+		TEST_ASSERT((uintptr_t)p % aligns[i] == 0,
+			"pointer %p not aligned on %zu",
+			p, aligns[i]);
+		rte_fastmem_free(p);
+	}
+
+	/* Default (align=0) gives at least RTE_CACHE_LINE_SIZE. */
+	{
+		void *p = rte_fastmem_alloc(1, 0, 0);
+
+		TEST_ASSERT_NOT_NULL(p,
+			"alloc(1, align=0) failed: rte_errno=%d", rte_errno);
+		TEST_ASSERT((uintptr_t)p % RTE_CACHE_LINE_SIZE == 0,
+			"default-align pointer %p not cache-line aligned",
+			p);
+		rte_fastmem_free(p);
+	}
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_zero_flag(void)
+{
+	uint8_t *p;
+	unsigned int i;
+	int rc;
+	bool all_zero = true;
+
+	/*
+	 * Dirty a slab first by allocating without F_ZERO, writing
+	 * a non-zero pattern, and freeing. A subsequent F_ZERO
+	 * allocation on the same slab must return zeroed memory.
+	 */
+	p = rte_fastmem_alloc(128, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "priming alloc failed");
+	memset(p, 0xff, 128);
+	rte_fastmem_free(p);
+
+	p = rte_fastmem_alloc(128, 0, RTE_FASTMEM_F_ZERO);
+	TEST_ASSERT_NOT_NULL(p, "F_ZERO alloc failed");
+	for (i = 0; i < 128; i++) {
+		if (p[i] != 0) {
+			all_zero = false;
+			break;
+		}
+	}
+	TEST_ASSERT(all_zero, "F_ZERO returned non-zero byte at offset %u", i);
+
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_reuse(void)
+{
+	void *first, *second;
+	int rc;
+
+	first = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(first, "first alloc failed");
+	rte_fastmem_free(first);
+
+	second = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(second, "second alloc failed");
+
+	/*
+	 * The slab's free list is LIFO, so the most recently freed
+	 * object is at the head of the list. A subsequent alloc in
+	 * the same class returns it.
+	 */
+	TEST_ASSERT_EQUAL(first, second,
+		"free + alloc did not reuse: first=%p second=%p",
+		first, second);
+
+	rte_fastmem_free(second);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_many_in_class(void)
+{
+	/*
+	 * Allocate more objects in one class than fit in a single
+	 * slab, forcing the bin to pull a second block. This
+	 * exercises the partial->full transition and the cross-slab
+	 * allocation path.
+	 */
+	enum { CLASS_SIZE = 8, COUNT = 300000 };
+	void **ptrs;
+	unsigned int i;
+	int rc;
+
+	ptrs = calloc(COUNT, sizeof(*ptrs));
+	TEST_ASSERT_NOT_NULL(ptrs, "calloc for test ptrs failed");
+
+	for (i = 0; i < COUNT; i++) {
+		ptrs[i] = rte_fastmem_alloc(CLASS_SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i],
+			"alloc[%u] failed: rte_errno=%d",
+			i, rte_errno);
+	}
+
+	for (i = 0; i < COUNT; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	free(ptrs);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_socket(void)
+{
+	void *p;
+	int socket_id;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no available sockets");
+
+	p = rte_fastmem_alloc_socket(64, 0, 0, socket_id);
+	TEST_ASSERT_NOT_NULL(p,
+		"alloc_socket(%d) failed: rte_errno=%d",
+		socket_id, rte_errno);
+
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_block_repurposing(void)
+{
+	void *small, *large;
+	int rc;
+
+	/*
+	 * Allocate and free a small object, forcing a block to be
+	 * assigned to the small class and then returned to the
+	 * free-block pool. A subsequent allocation in a different
+	 * class must be able to reuse that block.
+	 */
+	small = rte_fastmem_alloc(8, 0, 0);
+	TEST_ASSERT_NOT_NULL(small, "small alloc failed");
+	rte_fastmem_free(small);
+
+	large = rte_fastmem_alloc(256 * 1024, 0, 0);
+	TEST_ASSERT_NOT_NULL(large, "large alloc failed");
+	rte_fastmem_free(large);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_block_repurposing_no_growth(void)
+{
+	struct rte_fastmem_stats stats;
+	void *small, *large;
+	uint64_t after_small;
+	int rc;
+
+	/*
+	 * Stronger version of test_alloc_block_repurposing: assert
+	 * that the cross-class allocation does not grow the
+	 * backing memory (bytes_backing stays flat). Because the
+	 * free-block pool is shared across size classes — not
+	 * partitioned per class — the block freed from the small
+	 * class must serve the large allocation without triggering
+	 * a new memzone reservation.
+	 */
+	rc = rte_fastmem_stats(&stats);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_stats() failed: %d", rc);
+	TEST_ASSERT_EQUAL(stats.bytes_backing, (uint64_t)0,
+		"unexpected pre-alloc bytes_backing: %" PRIu64,
+		stats.bytes_backing);
+
+	small = rte_fastmem_alloc(8, 0, 0);
+	TEST_ASSERT_NOT_NULL(small, "small alloc failed");
+
+	rc = rte_fastmem_stats(&stats);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_stats() failed: %d", rc);
+	TEST_ASSERT(stats.bytes_backing > 0,
+		"bytes_backing did not grow on first alloc");
+	after_small = stats.bytes_backing;
+
+	rte_fastmem_free(small);
+	rte_fastmem_cache_flush();
+
+	large = rte_fastmem_alloc(256 * 1024, 0, 0);
+	TEST_ASSERT_NOT_NULL(large,
+		"large alloc failed: rte_errno=%d", rte_errno);
+
+	rc = rte_fastmem_stats(&stats);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_fastmem_stats() failed: %d", rc);
+	TEST_ASSERT_EQUAL(stats.bytes_backing, after_small,
+		"cross-class alloc grew backing memory from %" PRIu64
+		" to %" PRIu64,
+		after_small, stats.bytes_backing);
+
+	rte_fastmem_free(large);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_free_null(void)
+{
+	/* Must be a no-op, not a crash. */
+	rte_fastmem_free(NULL);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_content_integrity(void)
+{
+	/*
+	 * Allocate a batch of objects, fill each with a distinct
+	 * byte pattern, then verify none of the patterns overlap.
+	 * This catches header overwrites (slab header corrupted by
+	 * object access) and slot-overlap bugs (two pointers pointing
+	 * at overlapping slots).
+	 */
+	enum { N = 256, SIZE = 128 };
+	uint8_t *ptrs[N];
+	unsigned int i, j;
+	int rc;
+
+	for (i = 0; i < N; i++) {
+		ptrs[i] = rte_fastmem_alloc(SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "alloc[%u] failed", i);
+		memset(ptrs[i], (int)i, SIZE);
+	}
+
+	for (i = 0; i < N; i++)
+		for (j = 0; j < SIZE; j++)
+			TEST_ASSERT_EQUAL(ptrs[i][j], (uint8_t)i,
+				"corruption at ptrs[%u][%u]: got 0x%x, want 0x%x",
+				i, j, ptrs[i][j], (uint8_t)i);
+
+	for (i = 0; i < N; i++)
+		rte_fastmem_free(ptrs[i]);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_align_too_big(void)
+{
+	void *p;
+	int rc;
+
+	/*
+	 * A small size with an alignment larger than the maximum
+	 * size class cannot be served. The class selected must be
+	 * large enough for the alignment, but no such class exists.
+	 */
+	rte_errno = 0;
+	p = rte_fastmem_alloc(1, rte_fastmem_max_size() * 2, 0);
+	TEST_ASSERT_NULL(p,
+		"alloc with align>max_size returned non-NULL");
+	TEST_ASSERT_EQUAL(rte_errno, E2BIG,
+		"expected rte_errno=E2BIG, got %d", rte_errno);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_align_one(void)
+{
+	void *p;
+	int rc;
+
+	/* align=1 is a valid power of 2 and must be accepted. */
+	p = rte_fastmem_alloc(8, 1, 0);
+	TEST_ASSERT_NOT_NULL(p, "alloc(8, 1) failed: rte_errno=%d",
+		rte_errno);
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_socket_numa_placement(void)
+{
+	void *p;
+	int socket_id;
+	struct rte_memseg *ms;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no available sockets");
+
+	p = rte_fastmem_alloc_socket(64, 0, 0, socket_id);
+	TEST_ASSERT_NOT_NULL(p,
+		"alloc_socket(%d) failed: rte_errno=%d",
+		socket_id, rte_errno);
+
+	/*
+	 * Walk the memory to find the memseg for this pointer and
+	 * verify its socket. Skip the check if lookup fails (e.g.,
+	 * --no-huge mode may not populate memsegs for fastmem's
+	 * allocations in a way that rte_mem_virt2memseg can find).
+	 */
+	ms = rte_mem_virt2memseg(p, NULL);
+	if (ms != NULL) {
+		TEST_ASSERT_EQUAL(ms->socket_id, socket_id,
+			"alloc on socket %d landed on socket %d",
+			socket_id, ms->socket_id);
+	}
+
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Stage 3 tests: per-lcore caches.
+ */
+
+static int
+test_cache_flush(void)
+{
+	void *p;
+	int rc;
+
+	/*
+	 * Alloc and free one object, leaving it in the cache. Then
+	 * flush and verify that a subsequent alloc may or may not
+	 * return the same pointer (not asserting same/different —
+	 * just checking that flush does not crash and a follow-up
+	 * alloc still works).
+	 */
+	p = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "first alloc failed");
+	rte_fastmem_free(p);
+
+	rte_fastmem_cache_flush();
+
+	/* Flush again — must be idempotent. */
+	rte_fastmem_cache_flush();
+
+	p = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "post-flush alloc failed");
+	rte_fastmem_free(p);
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_cache_flush_without_init(void)
+{
+	/* Must be a no-op, not a crash. */
+	rte_fastmem_cache_flush();
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_cache_exceeds_capacity(void)
+{
+	/*
+	 * Free more objects at a single size class than the cache
+	 * capacity (64 for classes <= 4 KiB). This forces the
+	 * cache-drain slow path and verifies no corruption.
+	 */
+	enum { COUNT = 200, SIZE = 64 };
+	void *ptrs[COUNT];
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < COUNT; i++) {
+		ptrs[i] = rte_fastmem_alloc(SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i],
+			"alloc[%u] failed: rte_errno=%d", i, rte_errno);
+	}
+
+	for (i = 0; i < COUNT; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	/* Re-alloc the same count should still work. */
+	for (i = 0; i < COUNT; i++) {
+		ptrs[i] = rte_fastmem_alloc(SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i],
+			"re-alloc[%u] failed: rte_errno=%d", i, rte_errno);
+	}
+
+	for (i = 0; i < COUNT; i++)
+		rte_fastmem_free(ptrs[i]);
+
+
+	return TEST_SUCCESS;
+}
+
+struct non_eal_args {
+	int ok;
+	char pad[64];
+};
+
+static uint32_t
+non_eal_thread_main(void *arg)
+{
+	struct non_eal_args *args = arg;
+	uint8_t *p;
+
+	p = rte_fastmem_alloc(128, 0, 0);
+	if (p == NULL)
+		return 1;
+
+	memset(p, 0x7e, 128);
+
+	rte_fastmem_free(p);
+
+	args->ok = 1;
+	return 0;
+}
+
+static int
+test_non_eal_thread(void)
+{
+	rte_thread_t thread_id;
+	struct non_eal_args args = { 0 };
+	int rc;
+
+	rc = rte_thread_create(&thread_id, NULL, non_eal_thread_main, &args);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_thread_create() failed: %d", rc);
+
+	rc = rte_thread_join(thread_id, NULL);
+	TEST_ASSERT_EQUAL(rc, 0, "rte_thread_join() failed: %d", rc);
+
+	TEST_ASSERT_EQUAL(args.ok, 1,
+		"non-EAL thread did not complete alloc/free successfully");
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_cache_flush_returns_memory(void)
+{
+	/*
+	 * When an entire slab's worth of objects is freed, the
+	 * slab's block is returned to the free-block pool and can
+	 * be reassigned to another size class. Verify the cache
+	 * does not permanently hold objects that prevent this.
+	 *
+	 * Allocate enough objects in one class to force multiple
+	 * slabs, free them all, then flush the cache. After the
+	 * flush, all cached objects are drained to their bins and
+	 * empty slabs are returned to the block pool.
+	 */
+	enum { N = 200, SIZE = 64 };
+	void *ptrs[N];
+	unsigned int i;
+	int rc;
+
+	for (i = 0; i < N; i++) {
+		ptrs[i] = rte_fastmem_alloc(SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "alloc[%u] failed", i);
+	}
+	for (i = 0; i < N; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	rte_fastmem_cache_flush();
+
+	/*
+	 * An allocation in a completely different class should
+	 * succeed now, having access to any blocks freed by the
+	 * flush.
+	 */
+	{
+		void *other = rte_fastmem_alloc(65536, 0, 0);
+
+		TEST_ASSERT_NOT_NULL(other,
+			"post-flush cross-class alloc failed");
+		rte_fastmem_free(other);
+	}
+
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_bulk_basic(void)
+{
+	enum { N = 32 };
+	void *ptrs[N];
+	int rc;
+
+	rc = rte_fastmem_alloc_bulk(ptrs, N, 64, 0, 0);
+	TEST_ASSERT_EQUAL(rc, 0, "alloc_bulk failed: %d", rc);
+
+	/* Verify all pointers are non-NULL and distinct. */
+	for (unsigned int i = 0; i < N; i++) {
+		TEST_ASSERT_NOT_NULL(ptrs[i], "ptrs[%u] is NULL", i);
+		for (unsigned int j = 0; j < i; j++)
+			TEST_ASSERT(ptrs[i] != ptrs[j],
+				"ptrs[%u] == ptrs[%u]", i, j);
+	}
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_bulk_zero_flag(void)
+{
+	enum { N = 8, SIZE = 128 };
+	void *ptrs[N];
+	int rc;
+
+	rc = rte_fastmem_alloc_bulk(ptrs, N, SIZE, 0, RTE_FASTMEM_F_ZERO);
+	TEST_ASSERT_EQUAL(rc, 0, "alloc_bulk failed: %d", rc);
+
+	for (unsigned int i = 0; i < N; i++) {
+		uint8_t *p = ptrs[i];
+
+		for (unsigned int b = 0; b < SIZE; b++)
+			TEST_ASSERT_EQUAL(p[b], 0,
+				"ptrs[%u][%u] != 0", i, b);
+	}
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_bulk_exceeds_cache(void)
+{
+	/* Allocate more than cache capacity (64) in one bulk call. */
+	enum { N = 128 };
+	void *ptrs[N];
+	int rc;
+
+	rc = rte_fastmem_alloc_bulk(ptrs, N, 64, 0, 0);
+	TEST_ASSERT_EQUAL(rc, 0, "alloc_bulk(%u) failed: %d", N, rc);
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_alloc_bulk_socket(void)
+{
+	enum { N = 16 };
+	void *ptrs[N];
+	int socket_id;
+	int rc;
+
+	socket_id = rte_socket_id_by_idx(0);
+	TEST_ASSERT(socket_id >= 0, "no sockets");
+
+	rc = rte_fastmem_alloc_bulk_socket(ptrs, N, 64, 0, 0, socket_id);
+	TEST_ASSERT_EQUAL(rc, 0, "alloc_bulk_socket failed: %d", rc);
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	/* SOCKET_ID_ANY */
+	rc = rte_fastmem_alloc_bulk_socket(ptrs, N, 64, 0, 0, SOCKET_ID_ANY);
+	TEST_ASSERT_EQUAL(rc, 0, "alloc_bulk_socket(ANY) failed: %d", rc);
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_free_bulk(void)
+{
+	enum { N = 64 };
+	void *ptrs[N];
+	int rc;
+
+	/* Allocate individually, free in bulk. */
+	for (unsigned int i = 0; i < N; i++) {
+		ptrs[i] = rte_fastmem_alloc(64, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "alloc[%u] failed", i);
+	}
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	/* Verify memory is reusable. */
+	for (unsigned int i = 0; i < N; i++) {
+		ptrs[i] = rte_fastmem_alloc(64, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "re-alloc[%u] failed", i);
+	}
+
+	rte_fastmem_free_bulk(ptrs, N);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_classes(void)
+{
+	size_t sizes[32];
+	unsigned int n;
+
+	n = rte_fastmem_classes(NULL);
+	TEST_ASSERT_EQUAL(n, 18u, "expected 18 classes, got %u", n);
+
+	n = rte_fastmem_classes(sizes);
+	TEST_ASSERT_EQUAL(n, 18u, "expected 18 classes, got %u", n);
+	TEST_ASSERT_EQUAL(sizes[0], (size_t)8, "class 0 != 8");
+	TEST_ASSERT_EQUAL(sizes[n - 1], (size_t)(1 << 20),
+		"last class != 1 MiB");
+
+	for (unsigned int i = 0; i < n; i++) {
+		TEST_ASSERT(sizes[i] != 0 && (sizes[i] & (sizes[i] - 1)) == 0,
+			"class %u size %zu not power of 2", i, sizes[i]);
+		if (i > 0)
+			TEST_ASSERT(sizes[i] > sizes[i - 1],
+				"classes not ascending at %u", i);
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_stats_class(void)
+{
+	enum { N = 10 };
+	struct rte_fastmem_class_stats cs;
+	void *ptrs[N];
+	int rc;
+
+	for (unsigned int i = 0; i < N; i++) {
+		ptrs[i] = rte_fastmem_alloc(64, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "alloc[%u] failed", i);
+	}
+
+	rc = rte_fastmem_stats_class(64, &cs);
+	TEST_ASSERT_EQUAL(rc, 0, "stats_class failed: %d", rc);
+	TEST_ASSERT_EQUAL(cs.class_size, (size_t)64, "wrong class_size");
+	TEST_ASSERT(cs.alloc_cache_hits + cs.alloc_cache_misses == N,
+		"alloc count != N: hits=%" PRIu64 " misses=%" PRIu64,
+		cs.alloc_cache_hits, cs.alloc_cache_misses);
+	TEST_ASSERT_EQUAL(cs.in_use, (uint64_t)N, "in_use != N");
+
+	for (unsigned int i = 0; i < N; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	rc = rte_fastmem_stats_class(64, &cs);
+	TEST_ASSERT_EQUAL(rc, 0, "stats_class after free failed: %d", rc);
+	TEST_ASSERT_EQUAL(cs.in_use, (uint64_t)0, "in_use != 0 after free");
+
+	/* Invalid class size. */
+	rc = rte_fastmem_stats_class(13, &cs);
+	TEST_ASSERT_EQUAL(rc, -EINVAL, "expected -EINVAL for bad size");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_stats_lcore(void)
+{
+	struct rte_fastmem_lcore_stats ls;
+	void *ptr;
+	int rc;
+
+	ptr = rte_fastmem_alloc(128, 0, 0);
+	TEST_ASSERT_NOT_NULL(ptr, "alloc failed");
+
+	rc = rte_fastmem_stats_lcore(rte_lcore_id(), &ls);
+	TEST_ASSERT_EQUAL(rc, 0, "stats_lcore failed: %d", rc);
+	TEST_ASSERT(ls.alloc_cache_hits + ls.alloc_cache_misses > 0,
+		"no alloc activity on this lcore");
+
+	rte_fastmem_free(ptr);
+
+	rc = rte_fastmem_stats_lcore(rte_lcore_id(), &ls);
+	TEST_ASSERT_EQUAL(rc, 0, "stats_lcore after free failed: %d", rc);
+	TEST_ASSERT(ls.free_cache_hits + ls.free_cache_misses > 0,
+		"no free activity on this lcore");
+
+	/* Invalid lcore. */
+	rc = rte_fastmem_stats_lcore(RTE_MAX_LCORE, &ls);
+	TEST_ASSERT_EQUAL(rc, -EINVAL, "expected -EINVAL for bad lcore");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_stats_lcore_class(void)
+{
+	struct rte_fastmem_lcore_class_stats lcs;
+	void *ptr;
+	int rc;
+
+	ptr = rte_fastmem_alloc(256, 0, 0);
+	TEST_ASSERT_NOT_NULL(ptr, "alloc failed");
+
+	rc = rte_fastmem_stats_lcore_class(rte_lcore_id(), 256, &lcs);
+	TEST_ASSERT_EQUAL(rc, 0, "stats_lcore_class failed: %d", rc);
+	TEST_ASSERT_EQUAL(lcs.class_size, (size_t)256, "wrong class_size");
+	TEST_ASSERT(lcs.alloc_cache_hits + lcs.alloc_cache_misses > 0,
+		"no alloc activity");
+
+	rte_fastmem_free(ptr);
+	return TEST_SUCCESS;
+}
+
+static int
+test_stats_reset(void)
+{
+	struct rte_fastmem_stats gs;
+	void *ptr;
+	int rc;
+
+	ptr = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(ptr, "alloc failed");
+	rte_fastmem_free(ptr);
+
+	rte_fastmem_stats_reset();
+
+	rc = rte_fastmem_stats(&gs);
+	TEST_ASSERT_EQUAL(rc, 0, "stats failed: %d", rc);
+	TEST_ASSERT_EQUAL(gs.alloc_total, (uint64_t)0,
+		"alloc_total not zero after reset");
+	TEST_ASSERT_EQUAL(gs.free_total, (uint64_t)0,
+		"free_total not zero after reset");
+
+	return TEST_SUCCESS;
+}
+
+
+#define MIXED_LONG_LIVED_COUNT 25
+#define MIXED_SHORT_LIVED_ITERS 1000
+#define MIXED_MIN_LCORES 3
+
+static const size_t mixed_long_sizes[] = { 64, 256, 4096 };
+static const size_t mixed_short_sizes[] = { 8, 16, 32, 64, 128, 256, 512, 1024 };
+
+struct mixed_worker_args {
+	uint32_t seed;
+	int result;
+};
+
+static uint32_t
+xorshift32(uint32_t *state)
+{
+	uint32_t x = *state;
+
+	x ^= x << 13;
+	x ^= x >> 17;
+	x ^= x << 5;
+	*state = x;
+	return x;
+}
+
+static int
+mixed_worker(void *arg)
+{
+	struct mixed_worker_args *args = arg;
+	uint32_t seed = args->seed;
+	void *long_lived[MIXED_LONG_LIVED_COUNT];
+	size_t long_sizes[MIXED_LONG_LIVED_COUNT];
+	unsigned int i;
+
+	/* Allocate long-lived objects of mixed sizes. */
+	for (i = 0; i < MIXED_LONG_LIVED_COUNT; i++) {
+		long_sizes[i] = mixed_long_sizes[i % RTE_DIM(mixed_long_sizes)];
+		long_lived[i] = rte_fastmem_alloc(long_sizes[i], 0, 0);
+		if (long_lived[i] == NULL) {
+			args->result = TEST_FAILED;
+			return -1;
+		}
+		memset(long_lived[i], (int)(i + 1), long_sizes[i]);
+	}
+
+	/* Rapidly cycle short-lived objects. */
+	for (i = 0; i < MIXED_SHORT_LIVED_ITERS; i++) {
+		size_t sz = mixed_short_sizes[xorshift32(&seed) %
+					      RTE_DIM(mixed_short_sizes)];
+		uint8_t pattern = (uint8_t)(i & 0xff);
+		uint8_t *p;
+
+		p = rte_fastmem_alloc(sz, 0, 0);
+		if (p == NULL) {
+			args->result = TEST_FAILED;
+			return -1;
+		}
+		memset(p, pattern, sz);
+
+		/* Verify before freeing. */
+		for (size_t j = 0; j < sz; j++) {
+			if (p[j] != pattern) {
+				args->result = TEST_FAILED;
+				return -1;
+			}
+		}
+		rte_fastmem_free(p);
+	}
+
+	/* Verify long-lived objects are still intact. */
+	for (i = 0; i < MIXED_LONG_LIVED_COUNT; i++) {
+		uint8_t *bytes = long_lived[i];
+		uint8_t expected = (uint8_t)(i + 1);
+
+		for (size_t j = 0; j < long_sizes[i]; j++) {
+			if (bytes[j] != expected) {
+				args->result = TEST_FAILED;
+				return -1;
+			}
+		}
+		rte_fastmem_free(long_lived[i]);
+	}
+
+	args->result = TEST_SUCCESS;
+	return 0;
+}
+
+static int
+test_mixed_lifetimes_multi_lcore(void)
+{
+	struct mixed_worker_args args[RTE_MAX_LCORE];
+	unsigned int lcore_id;
+	unsigned int count = 0;
+	struct rte_fastmem_stats stats;
+	int rc;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id)
+		count++;
+
+	if (count < MIXED_MIN_LCORES) {
+		printf("Not enough worker lcores (%u < %u), skipping\n",
+		       count, MIXED_MIN_LCORES);
+		return TEST_SKIPPED;
+	}
+
+	/* Launch workers with distinct seeds. */
+	uint32_t seed = 0xdeadbeef;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		args[lcore_id].seed = seed;
+		args[lcore_id].result = TEST_FAILED;
+		seed += 0x12345678;
+		rte_eal_remote_launch(mixed_worker, &args[lcore_id], lcore_id);
+	}
+
+	rte_eal_mp_wait_lcore();
+
+	/* Check all workers succeeded. */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		TEST_ASSERT_EQUAL(args[lcore_id].result, TEST_SUCCESS,
+			"worker on lcore %u failed", lcore_id);
+	}
+
+	/* Verify no memory leak. */
+	rc = rte_fastmem_stats(&stats);
+	TEST_ASSERT_EQUAL(rc, 0, "stats failed: %d", rc);
+	TEST_ASSERT_EQUAL(stats.bytes_in_use, (uint64_t)0,
+		"bytes_in_use not zero after test: %" PRIu64,
+		stats.bytes_in_use);
+
+
+	return TEST_SUCCESS;
+}
+
+
+/*
+ * Memory limit tests.
+ *
+ * FASTMEM_MEMZONE_SIZE is 128 MiB. We use a limit of 128 MiB
+ * (one memzone) for most tests, and large objects (256 KiB) to
+ * exhaust slabs quickly.
+ */
+
+#define LIMIT_ONE_MZ ((size_t)128 << 20)
+#define LIMIT_OBJ_SIZE ((size_t)256 * 1024)
+
+static int
+test_memory_limit_basic(void)
+{
+	int rc;
+
+	rc = rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+	TEST_ASSERT_EQUAL(rc, 0, "set_memory_limit failed: %d", rc);
+
+	const size_t got = rte_fastmem_get_limit(0);
+	TEST_ASSERT_EQUAL(got, LIMIT_ONE_MZ,
+		"get_memory_limit mismatch: %zu", got);
+
+	rc = rte_fastmem_reserve(LIMIT_ONE_MZ, SOCKET_ID_ANY);
+	TEST_ASSERT_EQUAL(rc, 0, "first reserve failed: %d", rc);
+
+	rc = rte_fastmem_reserve(LIMIT_ONE_MZ + 1, SOCKET_ID_ANY);
+	TEST_ASSERT(rc < 0, "second reserve should have failed");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_alloc_exhaustion(void)
+{
+	const unsigned int max_ptrs = 1024;
+	void *ptrs[max_ptrs];
+	unsigned int count = 0;
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+
+	for (count = 0; count < max_ptrs; count++) {
+		ptrs[count] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		if (ptrs[count] == NULL)
+			break;
+	}
+
+	TEST_ASSERT(count > 0, "should have allocated at least one");
+	TEST_ASSERT(count < max_ptrs, "should have hit the limit");
+	TEST_ASSERT_EQUAL(rte_errno, ENOMEM, "expected ENOMEM, got %d", rte_errno);
+
+	rte_fastmem_free(ptrs[count - 1]);
+	void *p = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "alloc after free should succeed");
+	rte_fastmem_free(p);
+
+	for (unsigned int i = 0; i < count - 1; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_zero_blocks_growth(void)
+{
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, 0);
+
+	rc = rte_fastmem_reserve(1, SOCKET_ID_ANY);
+	TEST_ASSERT(rc < 0, "reserve with limit=0 should fail");
+
+	void *p = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NULL(p, "alloc with limit=0 should fail");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_below_current(void)
+{
+	int rc;
+
+	rc = rte_fastmem_reserve(LIMIT_ONE_MZ, SOCKET_ID_ANY);
+	TEST_ASSERT_EQUAL(rc, 0, "reserve failed: %d", rc);
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, 1);
+
+	void *p = rte_fastmem_alloc(64, 0, 0);
+	TEST_ASSERT_NOT_NULL(p, "alloc from existing backing should work");
+	rte_fastmem_free(p);
+
+	rc = rte_fastmem_reserve(LIMIT_ONE_MZ * 2, SOCKET_ID_ANY);
+	TEST_ASSERT(rc < 0, "growth beyond limit should fail");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_socket_id_any(void)
+{
+	rte_fastmem_set_limit(SOCKET_ID_ANY, 42);
+
+	for (unsigned int i = 0; i < rte_socket_count(); i++) {
+		const int sid = rte_socket_id_by_idx(i);
+		const size_t lim = rte_fastmem_get_limit(sid);
+
+		TEST_ASSERT_EQUAL(lim, (size_t)42,
+			"socket %d limit mismatch: %zu", sid, lim);
+	}
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_unlimited(void)
+{
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, 0);
+	rte_fastmem_set_limit(SOCKET_ID_ANY, SIZE_MAX);
+
+	rc = rte_fastmem_reserve(LIMIT_ONE_MZ, SOCKET_ID_ANY);
+	TEST_ASSERT_EQUAL(rc, 0, "reserve after reset failed: %d", rc);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_alloc_integrity_under_oom(void)
+{
+	const unsigned int n = 128;
+	const size_t obj_size = 1024;
+	uint8_t *ptrs[n];
+	const unsigned int extra_max = 1024;
+	void *extra[extra_max];
+	unsigned int n_extra = 0;
+	unsigned int i;
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+
+	for (i = 0; i < n; i++) {
+		ptrs[i] = rte_fastmem_alloc(obj_size, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "alloc[%u] failed", i);
+		memset(ptrs[i], (int)(i & 0xff), obj_size);
+	}
+
+	/* Exhaust remaining backing with large objects. */
+	for (n_extra = 0; n_extra < extra_max; n_extra++) {
+		extra[n_extra] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		if (extra[n_extra] == NULL)
+			break;
+	}
+
+	/* Verify original objects are intact. */
+	for (i = 0; i < n; i++) {
+		const uint8_t expected = (uint8_t)(i & 0xff);
+		for (unsigned int j = 0; j < obj_size; j++)
+			TEST_ASSERT_EQUAL(ptrs[i][j], expected,
+				"corruption at [%u][%u]", i, j);
+	}
+
+	for (i = 0; i < n; i++)
+		rte_fastmem_free(ptrs[i]);
+	for (i = 0; i < n_extra; i++)
+		rte_fastmem_free(extra[i]);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_bulk_alloc_oom(void)
+{
+	const unsigned int bulk_n = 64;
+	const unsigned int drain_max = 512;
+	void *ptrs[bulk_n];
+	void *drain[drain_max];
+	unsigned int drained = 0;
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+
+	for (drained = 0; drained < drain_max; drained++) {
+		drain[drained] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		if (drain[drained] == NULL)
+			break;
+	}
+
+	/* Free a few — enough for some but not bulk_n objects. */
+	const unsigned int freed = RTE_MIN(drained, 4u);
+	for (unsigned int i = 0; i < freed; i++)
+		rte_fastmem_free(drain[--drained]);
+
+	rc = rte_fastmem_alloc_bulk(ptrs, bulk_n, LIMIT_OBJ_SIZE, 0, 0);
+	TEST_ASSERT(rc < 0, "bulk alloc should fail");
+
+	for (unsigned int i = 0; i < drained; i++)
+		rte_fastmem_free(drain[i]);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_memory_limit_recovery_after_free(void)
+{
+	const unsigned int max_ptrs = 512;
+	void *ptrs[max_ptrs];
+	unsigned int count = 0;
+	int rc;
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+
+	for (count = 0; count < max_ptrs; count++) {
+		ptrs[count] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		if (ptrs[count] == NULL)
+			break;
+	}
+	TEST_ASSERT(count > 0 && count < max_ptrs,
+		"expected partial fill, got %u", count);
+
+	const unsigned int half = count / 2;
+	for (unsigned int i = 0; i < half; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	for (unsigned int i = 0; i < half; i++) {
+		ptrs[i] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		TEST_ASSERT_NOT_NULL(ptrs[i], "recovery alloc[%u] failed", i);
+	}
+
+	for (unsigned int i = 0; i < count; i++)
+		rte_fastmem_free(ptrs[i]);
+
+	return TEST_SUCCESS;
+}
+
+struct limit_worker_args {
+	unsigned int alloc_count;
+	int result;
+};
+
+static int
+limit_worker(void *arg)
+{
+	struct limit_worker_args *args = arg;
+	const unsigned int max_ptrs = 128;
+	void *ptrs[max_ptrs];
+	unsigned int i;
+
+	args->alloc_count = 0;
+
+	for (i = 0; i < max_ptrs; i++) {
+		ptrs[i] = rte_fastmem_alloc(LIMIT_OBJ_SIZE, 0, 0);
+		if (ptrs[i] == NULL)
+			break;
+		memset(ptrs[i], 0xab, LIMIT_OBJ_SIZE);
+		args->alloc_count++;
+	}
+
+	for (unsigned int j = 0; j < args->alloc_count; j++) {
+		uint8_t *bytes = ptrs[j];
+		for (size_t k = 0; k < LIMIT_OBJ_SIZE; k++) {
+			if (bytes[k] != 0xab) {
+				args->result = TEST_FAILED;
+				return -1;
+			}
+		}
+		rte_fastmem_free(ptrs[j]);
+	}
+
+	args->result = TEST_SUCCESS;
+	return 0;
+}
+
+static int
+test_memory_limit_multi_lcore_oom(void)
+{
+	struct limit_worker_args args[RTE_MAX_LCORE];
+	unsigned int lcore_id;
+	unsigned int worker_count = 0;
+	int rc;
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id)
+		worker_count++;
+
+	if (worker_count < 2) {
+		printf("Not enough workers (%u < 2), skipping\n", worker_count);
+		return TEST_SKIPPED;
+	}
+
+	rte_fastmem_set_limit(SOCKET_ID_ANY, LIMIT_ONE_MZ);
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		args[lcore_id].result = TEST_FAILED;
+		rte_eal_remote_launch(limit_worker, &args[lcore_id], lcore_id);
+	}
+
+	rte_eal_mp_wait_lcore();
+
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		TEST_ASSERT_EQUAL(args[lcore_id].result, TEST_SUCCESS,
+			"worker on lcore %u failed", lcore_id);
+	}
+
+	struct rte_fastmem_stats stats;
+	rte_fastmem_stats(&stats);
+	TEST_ASSERT_EQUAL(stats.bytes_in_use, (uint64_t)0,
+		"bytes_in_use not zero: %" PRIu64, stats.bytes_in_use);
+
+	return TEST_SUCCESS;
+}
+
+static int
+fastmem_setup(void)
+{
+	return rte_fastmem_init();
+}
+
+static void
+fastmem_teardown(void)
+{
+	rte_fastmem_deinit();
+}
+
+static struct unit_test_suite fastmem_lifecycle_testsuite = {
+	.suite_name = "fastmem lifecycle tests",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE(test_init_deinit),
+		TEST_CASE(test_init_is_not_idempotent),
+		TEST_CASE(test_deinit_without_init),
+		TEST_CASE(test_max_size),
+		TEST_CASE(test_reserve_without_init),
+		TEST_CASE(test_cache_flush_without_init),
+		TEST_CASE(test_classes),
+		TEST_CASES_END()
+	}
+};
+
+static struct unit_test_suite fastmem_functional_testsuite = {
+	.suite_name = "fastmem functional tests",
+	.setup = NULL,
+	.teardown = NULL,
+	.unit_test_cases = {
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_reserve_small),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_reserve_multiple_memzones),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_reserve_cumulative),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_reserve_invalid_socket),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_reserve_any_socket),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_too_big),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_invalid_align),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_free_small),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_free_various_sizes),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_alignment),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_zero_flag),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_reuse),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_many_in_class),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_socket),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_block_repurposing),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_block_repurposing_no_growth),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_free_null),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_content_integrity),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_align_too_big),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_align_one),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_socket_numa_placement),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_cache_flush),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_cache_exceeds_capacity),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_non_eal_thread),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_cache_flush_returns_memory),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_bulk_basic),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_bulk_zero_flag),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_bulk_exceeds_cache),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_alloc_bulk_socket),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_free_bulk),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_stats_class),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_stats_lcore),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_stats_lcore_class),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_stats_reset),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_mixed_lifetimes_multi_lcore),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_basic),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_alloc_exhaustion),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_zero_blocks_growth),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_below_current),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_socket_id_any),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_unlimited),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_alloc_integrity_under_oom),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_bulk_alloc_oom),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_recovery_after_free),
+		TEST_CASE_ST(fastmem_setup, fastmem_teardown,
+			test_memory_limit_multi_lcore_oom),
+		TEST_CASES_END()
+	}
+};
+
+static int
+test_fastmem(void)
+{
+	int rc;
+
+	rc = unit_test_suite_runner(&fastmem_lifecycle_testsuite);
+	if (rc != 0)
+		return rc;
+
+	return unit_test_suite_runner(&fastmem_functional_testsuite);
+}
+
+REGISTER_FAST_TEST(fastmem_autotest, NOHUGE_OK, ASAN_OK, test_fastmem);
diff --git a/app/test/test_fastmem_perf.c b/app/test/test_fastmem_perf.c
new file mode 100644
index 0000000000..9200847847
--- /dev/null
+++ b/app/test/test_fastmem_perf.c
@@ -0,0 +1,997 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_launch.h>
+#include <rte_lcore.h>
+#include <rte_malloc.h>
+#include <rte_mempool.h>
+#include <rte_stdatomic.h>
+
+#include <rte_fastmem.h>
+
+#include "test.h"
+
+#define TEST_LOG(...) printf(__VA_ARGS__)
+
+static const size_t SIZES[] = { 8, 64, 256, 1024, 4096 };
+#define N_SIZES RTE_DIM(SIZES)
+
+/* Number of ops for warmup and measurement. */
+#define WARMUP_OPS 20000u
+#define MEASURE_OPS 2000000u
+
+/* Buffer for scenarios that allocate N then free N. */
+#define BATCH_N 256
+
+/*
+ * Allocator vtable: a thin adapter exposing alloc / free /
+ * per-allocator setup/teardown. Each scenario calls these
+ * indirectly so the same timing loop serves all allocators.
+ */
+struct allocator {
+	const char *name;
+	int (*setup)(size_t size, unsigned int n_max);
+	void (*teardown)(void);
+	void *(*alloc)(void);
+	void (*free_obj)(void *ptr);
+	int (*alloc_bulk)(void **ptrs, unsigned int n);
+	void (*free_bulk)(void **ptrs, unsigned int n);
+};
+
+/* Fastmem adapter -------------------------------------------------- */
+
+static size_t fastmem_size;
+
+static int
+fastmem_setup(size_t size, unsigned int n_max __rte_unused)
+{
+	fastmem_size = size;
+	return 0;
+}
+
+static void
+fastmem_teardown(void)
+{
+	rte_fastmem_cache_flush();
+}
+
+static void * __rte_noinline
+fastmem_alloc(void)
+{
+	return rte_fastmem_alloc(fastmem_size, 0, 0);
+}
+
+static void __rte_noinline
+fastmem_free(void *ptr)
+{
+	rte_fastmem_free(ptr);
+}
+
+/* Mempool adapter -------------------------------------------------- */
+
+static struct rte_mempool *mempool_pool;
+
+static int
+mempool_setup(size_t size, unsigned int n_max)
+{
+	char name[RTE_MEMPOOL_NAMESIZE];
+	unsigned int cache_size;
+
+	/*
+	 * Pool size must accommodate the full batch burst plus
+	 * per-lcore cache capacity. Use mempool's default cache
+	 * size so we're measuring its standard hot path.
+	 */
+	cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
+
+	snprintf(name, sizeof(name), "fmperf_mp_%zu", size);
+	mempool_pool = rte_mempool_create(name, n_max + cache_size * 2,
+			size, cache_size, 0, NULL, NULL, NULL, NULL,
+			SOCKET_ID_ANY, 0);
+	if (mempool_pool == NULL) {
+		TEST_LOG("mempool_create(%zu) failed\n", size);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void
+mempool_teardown(void)
+{
+	rte_mempool_free(mempool_pool);
+	mempool_pool = NULL;
+}
+
+static void * __rte_noinline
+mempool_alloc_one(void)
+{
+	void *obj = NULL;
+
+	if (rte_mempool_get(mempool_pool, &obj) < 0)
+		return NULL;
+	return obj;
+}
+
+static void __rte_noinline
+mempool_free_one(void *ptr)
+{
+	rte_mempool_put(mempool_pool, ptr);
+}
+
+/* rte_malloc adapter ----------------------------------------------- */
+
+static size_t malloc_size;
+
+static int
+malloc_setup(size_t size, unsigned int n_max __rte_unused)
+{
+	malloc_size = size;
+	return 0;
+}
+
+static void
+malloc_teardown(void)
+{
+}
+
+static void * __rte_noinline
+malloc_alloc(void)
+{
+	return rte_malloc(NULL, malloc_size, 0);
+}
+
+static void __rte_noinline
+malloc_free(void *ptr)
+{
+	rte_free(ptr);
+}
+
+/* libc (glibc) malloc adapter -------------------------------------- */
+
+static size_t libc_size;
+
+static int
+libc_setup(size_t size, unsigned int n_max __rte_unused)
+{
+	/*
+	 * Round up to cache-line alignment to match the other
+	 * allocators' default alignment guarantees and keep the
+	 * comparison honest. aligned_alloc() requires size to be
+	 * a multiple of the alignment.
+	 */
+	libc_size = RTE_ALIGN_CEIL(size, RTE_CACHE_LINE_SIZE);
+	return 0;
+}
+
+static void
+libc_teardown(void)
+{
+}
+
+static void * __rte_noinline
+libc_alloc(void)
+{
+	return aligned_alloc(RTE_CACHE_LINE_SIZE, libc_size);
+}
+
+static void __rte_noinline
+libc_free(void *ptr)
+{
+	free(ptr);
+}
+
+/* Bulk adapters ---------------------------------------------------- */
+
+static int __rte_noinline
+fastmem_alloc_bulk(void **ptrs, unsigned int n)
+{
+	return rte_fastmem_alloc_bulk(ptrs, n, fastmem_size, 0, 0);
+}
+
+static void __rte_noinline
+fastmem_free_bulk(void **ptrs, unsigned int n)
+{
+	rte_fastmem_free_bulk(ptrs, n);
+}
+
+static int __rte_noinline
+mempool_alloc_bulk(void **ptrs, unsigned int n)
+{
+	return rte_mempool_get_bulk(mempool_pool, ptrs, n);
+}
+
+static void __rte_noinline
+mempool_free_bulk(void **ptrs, unsigned int n)
+{
+	rte_mempool_put_bulk(mempool_pool, ptrs, n);
+}
+
+static int __rte_noinline
+generic_alloc_bulk(void **ptrs, unsigned int n, void *(*alloc_fn)(void))
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++) {
+		ptrs[i] = alloc_fn();
+		if (ptrs[i] == NULL)
+			return -1;
+	}
+	return 0;
+}
+
+static int __rte_noinline
+malloc_alloc_bulk(void **ptrs, unsigned int n)
+{
+	return generic_alloc_bulk(ptrs, n, malloc_alloc);
+}
+
+static void __rte_noinline
+malloc_free_bulk(void **ptrs, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		malloc_free(ptrs[i]);
+}
+
+static int __rte_noinline
+libc_alloc_bulk(void **ptrs, unsigned int n)
+{
+	return generic_alloc_bulk(ptrs, n, libc_alloc);
+}
+
+static void __rte_noinline
+libc_free_bulk(void **ptrs, unsigned int n)
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		libc_free(ptrs[i]);
+}
+
+/* Adapter table ---------------------------------------------------- */
+
+static const struct allocator allocators[] = {
+	{ "fastmem",    fastmem_setup, fastmem_teardown, fastmem_alloc,     fastmem_free,     fastmem_alloc_bulk, fastmem_free_bulk },
+	{ "mempool",    mempool_setup, mempool_teardown, mempool_alloc_one, mempool_free_one, mempool_alloc_bulk, mempool_free_bulk },
+	{ "rte_malloc", malloc_setup,  malloc_teardown,  malloc_alloc,      malloc_free,      malloc_alloc_bulk,  malloc_free_bulk },
+	{ "libc",       libc_setup,    libc_teardown,    libc_alloc,        libc_free,        libc_alloc_bulk,    libc_free_bulk },
+};
+#define N_ALLOCATORS RTE_DIM(allocators)
+
+/*
+ * Scenario 1: tight alloc+free loop. A single object is cycled
+ * repeatedly. The LIFO path keeps the same pointer hot, giving
+ * a best-case measurement.
+ */
+static double
+run_tight(const struct allocator *alloc, size_t size)
+{
+	void *p;
+	uint64_t tsc;
+	unsigned int i;
+
+	if (alloc->setup(size, 1) < 0)
+		return -1.0;
+
+	/* Warmup. */
+	for (i = 0; i < WARMUP_OPS; i++) {
+		p = alloc->alloc();
+		if (p == NULL)
+			goto err;
+		alloc->free_obj(p);
+	}
+
+	tsc = rte_rdtsc_precise();
+	for (i = 0; i < MEASURE_OPS; i++) {
+		p = alloc->alloc();
+		if (p == NULL)
+			goto err;
+		alloc->free_obj(p);
+	}
+	tsc = rte_rdtsc_precise() - tsc;
+
+	alloc->teardown();
+
+	return (double)tsc / MEASURE_OPS;
+err:
+	alloc->teardown();
+	return -1.0;
+}
+
+/*
+ * Scenario 2: allocate N, free N (FIFO free order). Exercises
+ * cache refill and drain paths when N exceeds cache capacity.
+ */
+static void
+run_batch(const struct allocator *alloc, size_t size,
+		double *cycles_alloc, double *cycles_free)
+{
+	void *ptrs[BATCH_N];
+	uint64_t tsc_alloc = 0, tsc_free = 0;
+	unsigned int iter, i;
+	unsigned int iters;
+
+	*cycles_alloc = -1.0;
+	*cycles_free = -1.0;
+
+	if (alloc->setup(size, BATCH_N) < 0)
+		return;
+
+	/* Pick iteration count so total ops ~= MEASURE_OPS. */
+	iters = MEASURE_OPS / BATCH_N;
+
+	/* Warmup. */
+	for (iter = 0; iter < WARMUP_OPS / BATCH_N; iter++) {
+		for (i = 0; i < BATCH_N; i++) {
+			ptrs[i] = alloc->alloc();
+			if (ptrs[i] == NULL)
+				goto err;
+		}
+		for (i = 0; i < BATCH_N; i++)
+			alloc->free_obj(ptrs[i]);
+	}
+
+	for (iter = 0; iter < iters; iter++) {
+		uint64_t t0;
+
+		t0 = rte_rdtsc_precise();
+		for (i = 0; i < BATCH_N; i++) {
+			ptrs[i] = alloc->alloc();
+			if (ptrs[i] == NULL)
+				goto err;
+		}
+		tsc_alloc += rte_rdtsc_precise() - t0;
+
+		t0 = rte_rdtsc_precise();
+		for (i = 0; i < BATCH_N; i++)
+			alloc->free_obj(ptrs[i]);
+		tsc_free += rte_rdtsc_precise() - t0;
+	}
+
+	alloc->teardown();
+
+	*cycles_alloc = (double)tsc_alloc / (iters * BATCH_N);
+	*cycles_free = (double)tsc_free / (iters * BATCH_N);
+	return;
+err:
+	alloc->teardown();
+}
+
+/*
+ * Scenario 3: allocate N, free N in reverse order.
+ */
+static void
+run_batch_reverse(const struct allocator *alloc, size_t size,
+		double *cycles_alloc, double *cycles_free)
+{
+	void *ptrs[BATCH_N];
+	uint64_t tsc_alloc = 0, tsc_free = 0;
+	unsigned int iter, i;
+	unsigned int iters;
+
+	*cycles_alloc = -1.0;
+	*cycles_free = -1.0;
+
+	if (alloc->setup(size, BATCH_N) < 0)
+		return;
+
+	iters = MEASURE_OPS / BATCH_N;
+
+	for (iter = 0; iter < WARMUP_OPS / BATCH_N; iter++) {
+		for (i = 0; i < BATCH_N; i++) {
+			ptrs[i] = alloc->alloc();
+			if (ptrs[i] == NULL)
+				goto err;
+		}
+		for (i = BATCH_N; i > 0; i--)
+			alloc->free_obj(ptrs[i - 1]);
+	}
+
+	for (iter = 0; iter < iters; iter++) {
+		uint64_t t0;
+
+		t0 = rte_rdtsc_precise();
+		for (i = 0; i < BATCH_N; i++) {
+			ptrs[i] = alloc->alloc();
+			if (ptrs[i] == NULL)
+				goto err;
+		}
+		tsc_alloc += rte_rdtsc_precise() - t0;
+
+		t0 = rte_rdtsc_precise();
+		for (i = BATCH_N; i > 0; i--)
+			alloc->free_obj(ptrs[i - 1]);
+		tsc_free += rte_rdtsc_precise() - t0;
+	}
+
+	alloc->teardown();
+
+	*cycles_alloc = (double)tsc_alloc / (iters * BATCH_N);
+	*cycles_free = (double)tsc_free / (iters * BATCH_N);
+	return;
+err:
+	alloc->teardown();
+}
+
+/*
+ * Scenario 4: multi-lcore alloc/work/free with a dummy-work
+ * baseline. Each worker runs a tight alloc → touch → free loop
+ * on its own lcore. A second run with the same dummy work but
+ * no allocator traffic establishes a baseline; the per-op
+ * allocator cost is reported as (alloc_run - baseline_run).
+ *
+ * Fixed size class and a fixed amount of dummy work per op —
+ * this scenario sweeps lcore count rather than size.
+ */
+#define MULTI_SIZE 256u
+#define MULTI_WORK_BYTES 64u
+#define MULTI_WORK_PASSES 8u   /* RMW passes over the work region. */
+#define MULTI_OPS 200000u
+#define MULTI_WARMUP 2000u
+#define MAX_MULTI_LCORES 32u
+
+/*
+ * Per-worker volatile sink. Each worker writes to its own
+ * slot, preventing dead-code elimination of touch_buffer() and
+ * avoiding cross-lcore cache-line sharing on the hot path.
+ * Padded to cache-line stride to prevent false sharing between
+ * neighboring workers' slots.
+ */
+struct worker_sink {
+	volatile uint64_t value;
+} __rte_cache_aligned;
+
+static struct worker_sink worker_sinks[RTE_MAX_LCORE];
+
+/*
+ * Out-of-line dummy workload: run MULTI_WORK_PASSES
+ * read-modify-write passes over the first 'bytes' of the
+ * buffer. Each pass reads what the previous pass wrote, so the
+ * compiler cannot unroll or parallelize across passes — the
+ * work scales linearly with MULTI_WORK_PASSES. Returns an
+ * accumulator so the caller can feed it into a volatile sink;
+ * without that, the compiler could elide the whole function.
+ *
+ * __rte_noinline so it looks identical to the compiler in both
+ * the baseline (pre-allocated scratch buffer) and alloc-path
+ * runs, making the cycle-delta subtraction valid.
+ *
+ * The purpose of this being tunably expensive is to keep
+ * worker-per-iteration cost high relative to the allocator's
+ * critical section, so that even serialized allocators like
+ * rte_malloc spend most of their time outside the lock and the
+ * measured per-op allocator cost reflects its own work rather
+ * than its contention queue.
+ */
+static uint64_t __rte_noinline
+touch_buffer(void *buf, size_t bytes)
+{
+	uint64_t *p = buf;
+	size_t n = bytes / sizeof(uint64_t);
+	uint64_t acc = 0;
+	unsigned int pass;
+	size_t i;
+
+	/* Prime the buffer with a known pattern. */
+	for (i = 0; i < n; i++)
+		p[i] = i * 0x9E3779B97F4A7C15ULL;
+
+	/*
+	 * Dependent RMW passes: each pass reads p[i] written by
+	 * the previous pass, mixes the pass index in, and writes
+	 * back. The XOR into acc keeps the chain live.
+	 */
+	for (pass = 0; pass < MULTI_WORK_PASSES; pass++) {
+		for (i = 0; i < n; i++) {
+			uint64_t v = p[i];
+
+			v = v * 0xC2B2AE3D27D4EB4FULL + pass;
+			v ^= v >> 33;
+			p[i] = v;
+			acc ^= v;
+		}
+	}
+
+	return acc;
+}
+
+struct worker_args {
+	const struct allocator *alloc;
+	void *scratch;            /* baseline only; NULL => alloc path */
+	unsigned int iters;
+	unsigned int warmup;
+	unsigned int bulk_n;      /* 0 = single-object, >0 = bulk */
+	RTE_ATOMIC(bool) start_flag; /* barrier at worker entry */
+	uint64_t cycles;          /* out */
+	unsigned int ops;         /* out */
+	int err;                  /* out */
+};
+
+static int
+worker_run(void *arg)
+{
+	struct worker_args *wa = arg;
+	unsigned int lcore = rte_lcore_id();
+	uint64_t acc = 0;
+	uint64_t t0;
+	unsigned int i;
+
+	wa->err = 0;
+	wa->ops = 0;
+	wa->cycles = 0;
+
+	/* Wait for start flag (spin-barrier set by main). */
+	while (!rte_atomic_load_explicit(&wa->start_flag,
+			rte_memory_order_acquire))
+		rte_pause();
+
+	/* Warmup. */
+	for (i = 0; i < wa->warmup; i++) {
+		void *p;
+
+		if (wa->scratch != NULL)
+			p = wa->scratch;
+		else {
+			p = wa->alloc->alloc();
+			if (p == NULL) {
+				wa->err = -1;
+				return -1;
+			}
+		}
+		acc ^= touch_buffer(p, MULTI_WORK_BYTES);
+		if (wa->scratch == NULL)
+			wa->alloc->free_obj(p);
+	}
+
+	/* Measured loop. */
+	t0 = rte_rdtsc_precise();
+	for (i = 0; i < wa->iters; i++) {
+		void *p;
+
+		if (wa->scratch != NULL)
+			p = wa->scratch;
+		else {
+			p = wa->alloc->alloc();
+			if (p == NULL) {
+				wa->err = -1;
+				break;
+			}
+		}
+		acc ^= touch_buffer(p, MULTI_WORK_BYTES);
+		if (wa->scratch == NULL)
+			wa->alloc->free_obj(p);
+	}
+	wa->cycles = rte_rdtsc_precise() - t0;
+	wa->ops = i;
+
+	/* Publish accumulator to defeat dead-code elimination. */
+	worker_sinks[lcore].value ^= acc;
+
+	return 0;
+}
+
+static int
+worker_run_bulk(void *arg)
+{
+	struct worker_args *wa = arg;
+	unsigned int lcore = rte_lcore_id();
+	void *ptrs[BATCH_N];
+	uint64_t acc = 0;
+	uint64_t t0;
+	unsigned int i, j;
+	unsigned int bulk_n = wa->bulk_n;
+
+	wa->err = 0;
+	wa->ops = 0;
+	wa->cycles = 0;
+
+	while (!rte_atomic_load_explicit(&wa->start_flag,
+			rte_memory_order_acquire))
+		rte_pause();
+
+	/* Warmup. */
+	for (i = 0; i < wa->warmup; i++) {
+		if (wa->alloc->alloc_bulk(ptrs, bulk_n) < 0) {
+			wa->err = -1;
+			return -1;
+		}
+		for (j = 0; j < bulk_n; j++)
+			acc ^= touch_buffer(ptrs[j], MULTI_WORK_BYTES);
+		wa->alloc->free_bulk(ptrs, bulk_n);
+	}
+
+	t0 = rte_rdtsc_precise();
+	for (i = 0; i < wa->iters; i++) {
+		if (wa->alloc->alloc_bulk(ptrs, bulk_n) < 0) {
+			wa->err = -1;
+			break;
+		}
+		for (j = 0; j < bulk_n; j++)
+			acc ^= touch_buffer(ptrs[j], MULTI_WORK_BYTES);
+		wa->alloc->free_bulk(ptrs, bulk_n);
+	}
+	wa->cycles = rte_rdtsc_precise() - t0;
+	wa->ops = i * bulk_n;
+
+	worker_sinks[lcore].value ^= acc;
+
+	return 0;
+}
+
+/*
+ * Launch workers on the first 'n_workers' worker lcores, run
+ * either the baseline (scratch != NULL) or the alloc path
+ * (scratch == NULL), and return the mean per-op cycle cost
+ * averaged across participating workers.
+ *
+ * On any worker error, returns -1.0.
+ */
+static double
+run_multi_workers(const struct allocator *alloc, unsigned int n_workers,
+		void *const *scratches, unsigned int bulk_n)
+{
+	struct worker_args wargs[RTE_MAX_LCORE];
+	unsigned int worker_lcores[MAX_MULTI_LCORES];
+	unsigned int n = 0;
+	unsigned int lcore_id;
+	unsigned int i;
+	lcore_function_t *fn = bulk_n > 0 ? worker_run_bulk : worker_run;
+
+	/* Collect the first n_workers worker lcores. */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		if (n >= n_workers)
+			break;
+		worker_lcores[n++] = lcore_id;
+	}
+	if (n < n_workers)
+		return -1.0;
+
+	/* Prepare per-worker args. */
+	for (i = 0; i < n_workers; i++) {
+		struct worker_args *wa = &wargs[worker_lcores[i]];
+
+		wa->alloc = alloc;
+		wa->scratch = scratches != NULL ? scratches[i] : NULL;
+		wa->iters = MULTI_OPS;
+		wa->warmup = MULTI_WARMUP;
+		wa->bulk_n = bulk_n;
+		rte_atomic_store_explicit(&wa->start_flag, false,
+				rte_memory_order_relaxed);
+	}
+
+	/* Launch workers. They spin on start_flag until released. */
+	for (i = 0; i < n_workers; i++)
+		rte_eal_remote_launch(fn, &wargs[worker_lcores[i]],
+				worker_lcores[i]);
+
+	/* Release all workers roughly simultaneously. */
+	for (i = 0; i < n_workers; i++)
+		rte_atomic_store_explicit(
+			&wargs[worker_lcores[i]].start_flag, true,
+			rte_memory_order_release);
+
+	/* Wait for completion. */
+	for (i = 0; i < n_workers; i++)
+		rte_eal_wait_lcore(worker_lcores[i]);
+
+	/* Aggregate: mean cycles per op across workers. */
+	{
+		double sum_cycles_per_op = 0.0;
+		unsigned int n_ok = 0;
+
+		for (i = 0; i < n_workers; i++) {
+			struct worker_args *wa = &wargs[worker_lcores[i]];
+
+			if (wa->err != 0 || wa->ops == 0)
+				return -1.0;
+			sum_cycles_per_op +=
+				(double)wa->cycles / (double)wa->ops;
+			n_ok++;
+		}
+		return sum_cycles_per_op / n_ok;
+	}
+}
+
+/*
+ * One sub-run of Scenario 4: given an allocator and a worker
+ * count, return (baseline, alloc_path) mean cycles per op.
+ */
+static void
+run_multi_lcore(const struct allocator *alloc, unsigned int n_workers,
+		unsigned int bulk_n, double *baseline, double *alloc_path)
+{
+	void *scratches[MAX_MULTI_LCORES] = {0};
+	unsigned int n_alloced = 0;
+	unsigned int i;
+
+	*baseline = -1.0;
+	*alloc_path = -1.0;
+
+	if (alloc->setup(MULTI_SIZE, n_workers * 64) < 0)
+		return;
+
+	/* Baseline: pre-allocate one scratch per worker. */
+	for (i = 0; i < n_workers; i++) {
+		scratches[i] = alloc->alloc();
+		if (scratches[i] == NULL)
+			goto err;
+		n_alloced++;
+	}
+
+	*baseline = run_multi_workers(alloc, n_workers, scratches, 0);
+
+	for (i = 0; i < n_alloced; i++)
+		alloc->free_obj(scratches[i]);
+	n_alloced = 0;
+
+	/* Alloc path: workers alloc+free each iter. */
+	*alloc_path = run_multi_workers(alloc, n_workers, NULL, bulk_n);
+
+	alloc->teardown();
+	return;
+err:
+	for (i = 0; i < n_alloced; i++)
+		alloc->free_obj(scratches[i]);
+	alloc->teardown();
+}
+
+/* Reporting -------------------------------------------------------- */
+
+static void
+print_header(const char *title)
+{
+	size_t i;
+
+	TEST_LOG("\n=== %s ===\n", title);
+	TEST_LOG("%-12s", "allocator");
+	for (i = 0; i < N_SIZES; i++)
+		TEST_LOG(" %10zu B", SIZES[i]);
+	TEST_LOG("\n");
+}
+
+static void
+print_row(const char *name, const double *values)
+{
+	size_t i;
+
+	TEST_LOG("%-12s", name);
+	for (i = 0; i < N_SIZES; i++) {
+		if (values[i] < 0)
+			TEST_LOG(" %12s", "--");
+		else
+			TEST_LOG(" %12.1f", values[i]);
+	}
+	TEST_LOG("\n");
+}
+
+static void
+print_multi_header(const char *title, const unsigned int *lcore_counts,
+		unsigned int n_counts)
+{
+	unsigned int i;
+
+	TEST_LOG("\n=== %s ===\n", title);
+	TEST_LOG("%-12s", "allocator");
+	for (i = 0; i < n_counts; i++)
+		TEST_LOG(" %8u lcore%c", lcore_counts[i],
+				lcore_counts[i] == 1 ? ' ' : 's');
+	TEST_LOG("\n");
+}
+
+static void
+print_multi_row(const char *name, const double *values, unsigned int n_counts)
+{
+	unsigned int i;
+
+	TEST_LOG("%-12s", name);
+	for (i = 0; i < n_counts; i++) {
+		if (values[i] < 0)
+			TEST_LOG(" %14s", "--");
+		else
+			TEST_LOG(" %14.1f", values[i]);
+	}
+	TEST_LOG("\n");
+}
+
+/* Driver ----------------------------------------------------------- */
+
+static int
+test_fastmem_perf(void)
+{
+	size_t i;
+	size_t a;
+	int rc;
+
+	rc = rte_fastmem_init();
+	if (rc < 0) {
+		TEST_LOG("rte_fastmem_init() failed: %d\n", rc);
+		return -1;
+	}
+
+	rc = rte_fastmem_reserve(128 * 1024 * 1024, SOCKET_ID_ANY);
+	if (rc < 0) {
+		TEST_LOG("rte_fastmem_reserve() failed: %d\n", rc);
+		rte_fastmem_deinit();
+		return -1;
+	}
+
+	TEST_LOG("\nfastmem performance — single-lcore, fixed-size\n");
+	TEST_LOG("All numbers are TSC cycles.\n");
+
+	/* Scenario 1: tight alloc+free. */
+	print_header("Scenario 1: Single-object hot path — cycles per (alloc + free)");
+	for (a = 0; a < N_ALLOCATORS; a++) {
+		double vals[N_SIZES];
+
+		for (i = 0; i < N_SIZES; i++)
+			vals[i] = run_tight(&allocators[a], SIZES[i]);
+		print_row(allocators[a].name, vals);
+	}
+
+	/* Scenario 2: batched, FIFO free. */
+	print_header("Scenario 2: Batch alloc, FIFO free — cycles per alloc");
+	for (a = 0; a < N_ALLOCATORS; a++) {
+		double vals_alloc[N_SIZES], vals_free[N_SIZES];
+
+		for (i = 0; i < N_SIZES; i++)
+			run_batch(&allocators[a], SIZES[i],
+				&vals_alloc[i], &vals_free[i]);
+		print_row(allocators[a].name, vals_alloc);
+	}
+	print_header("Scenario 2: Batch alloc, FIFO free — cycles per free");
+	for (a = 0; a < N_ALLOCATORS; a++) {
+		double vals_alloc[N_SIZES], vals_free[N_SIZES];
+
+		for (i = 0; i < N_SIZES; i++)
+			run_batch(&allocators[a], SIZES[i],
+				&vals_alloc[i], &vals_free[i]);
+		print_row(allocators[a].name, vals_free);
+	}
+
+	/* Scenario 3: batched, reverse free. */
+	print_header("Scenario 3: Batch alloc, LIFO free — cycles per alloc");
+	for (a = 0; a < N_ALLOCATORS; a++) {
+		double vals_alloc[N_SIZES], vals_free[N_SIZES];
+
+		for (i = 0; i < N_SIZES; i++)
+			run_batch_reverse(&allocators[a], SIZES[i],
+				&vals_alloc[i], &vals_free[i]);
+		print_row(allocators[a].name, vals_alloc);
+	}
+	print_header("Scenario 3: Batch alloc, LIFO free — cycles per free");
+	for (a = 0; a < N_ALLOCATORS; a++) {
+		double vals_alloc[N_SIZES], vals_free[N_SIZES];
+
+		for (i = 0; i < N_SIZES; i++)
+			run_batch_reverse(&allocators[a], SIZES[i],
+				&vals_alloc[i], &vals_free[i]);
+		print_row(allocators[a].name, vals_free);
+	}
+
+	/* Scenario 4: multi-lcore alloc/work/free with baseline. */
+	{
+		unsigned int max_workers = rte_lcore_count() - 1;
+		unsigned int lcore_counts[8];
+		unsigned int n_counts = 0;
+		unsigned int w;
+		double base_vals[N_ALLOCATORS][8];
+		double alloc_vals[N_ALLOCATORS][8];
+		double delta_vals[N_ALLOCATORS][8];
+
+		if (max_workers > MAX_MULTI_LCORES)
+			max_workers = MAX_MULTI_LCORES;
+
+		/* Sweep lcore counts: 1, 2, 4, 8, ... up to max_workers. */
+		for (w = 1; w <= max_workers && n_counts < RTE_DIM(lcore_counts); w *= 2)
+			lcore_counts[n_counts++] = w;
+		/* Ensure max_workers is the final column if not power of two. */
+		if (n_counts > 0 && lcore_counts[n_counts - 1] != max_workers &&
+				n_counts < RTE_DIM(lcore_counts) && max_workers >= 1)
+			lcore_counts[n_counts++] = max_workers;
+
+		if (n_counts == 0) {
+			TEST_LOG("\nScenario 4 (Multi-lcore contention) skipped: no worker lcores available.\n");
+		} else {
+			TEST_LOG("\nScenario 4 parameters: size=%u B\n",
+				MULTI_SIZE);
+
+			for (a = 0; a < N_ALLOCATORS; a++) {
+				unsigned int c;
+
+				for (c = 0; c < n_counts; c++)
+					run_multi_lcore(&allocators[a], lcore_counts[c],
+							0, &base_vals[a][c],
+							&alloc_vals[a][c]);
+				for (c = 0; c < n_counts; c++) {
+					if (base_vals[a][c] < 0 || alloc_vals[a][c] < 0)
+						delta_vals[a][c] = -1.0;
+					else
+						delta_vals[a][c] = alloc_vals[a][c] -
+							base_vals[a][c];
+				}
+			}
+
+			TEST_LOG("Baseline (domain logic only): %.1f cycles/op\n",
+					base_vals[0][0]);
+
+			print_multi_header("Scenario 4: Multi-lcore contention — allocator overhead (cycles/op)",
+					lcore_counts, n_counts);
+			for (a = 0; a < N_ALLOCATORS; a++)
+				print_multi_row(allocators[a].name,
+						delta_vals[a], n_counts);
+		}
+	}
+
+	/* Scenario 5: multi-lcore bulk alloc/work/free. */
+	{
+		unsigned int max_workers = rte_lcore_count() - 1;
+		unsigned int lcore_counts[8];
+		unsigned int n_counts = 0;
+		unsigned int w;
+		double base_vals[N_ALLOCATORS][8];
+		double alloc_vals[N_ALLOCATORS][8];
+		double delta_vals[N_ALLOCATORS][8];
+		unsigned int bulk_n = 8;
+
+		if (max_workers > MAX_MULTI_LCORES)
+			max_workers = MAX_MULTI_LCORES;
+
+		for (w = 1; w <= max_workers && n_counts < RTE_DIM(lcore_counts); w *= 2)
+			lcore_counts[n_counts++] = w;
+		if (n_counts > 0 && lcore_counts[n_counts - 1] != max_workers &&
+				n_counts < RTE_DIM(lcore_counts) && max_workers >= 1)
+			lcore_counts[n_counts++] = max_workers;
+
+		if (n_counts == 0) {
+			TEST_LOG("\nScenario 5 (Multi-lcore bulk contention) skipped: no worker lcores available.\n");
+		} else {
+			TEST_LOG("\nScenario 5 parameters: size=%u B, "
+				"bulk=%u\n",
+				MULTI_SIZE, bulk_n);
+
+			for (size_t a = 0; a < N_ALLOCATORS; a++) {
+				unsigned int c;
+
+				for (c = 0; c < n_counts; c++)
+					run_multi_lcore(&allocators[a],
+							lcore_counts[c], bulk_n,
+							&base_vals[a][c],
+							&alloc_vals[a][c]);
+				for (c = 0; c < n_counts; c++) {
+					if (base_vals[a][c] < 0 || alloc_vals[a][c] < 0)
+						delta_vals[a][c] = -1.0;
+					else
+						delta_vals[a][c] = alloc_vals[a][c] -
+							base_vals[a][c];
+				}
+			}
+
+			TEST_LOG("Baseline (domain logic only): %.1f cycles/op\n",
+					base_vals[0][0]);
+
+			print_multi_header("Scenario 5: Multi-lcore bulk contention — allocator overhead (cycles/op)",
+					lcore_counts, n_counts);
+			for (size_t a = 0; a < N_ALLOCATORS; a++)
+				print_multi_row(allocators[a].name,
+						delta_vals[a], n_counts);
+		}
+	}
+
+	TEST_LOG("\n");
+	rte_fastmem_deinit();
+	return 0;
+}
+
+REGISTER_PERF_TEST(fastmem_perf_autotest, test_fastmem_perf);
diff --git a/app/test/test_fastmem_profile.c b/app/test/test_fastmem_profile.c
new file mode 100644
index 0000000000..9a5dc94018
--- /dev/null
+++ b/app/test/test_fastmem_profile.c
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Ericsson AB
+ */
+
+/*
+ * A minimal fastmem workload intended for use with perf record /
+ * perf report. Runs a tight alloc/free loop for a fixed duration
+ * so that sampling profilers can attribute cycles to individual
+ * functions and instructions within the fastmem hot path.
+ *
+ * Usage:
+ *   perf record -g -- dpdk-test --no-huge --no-pci -m 8192 \
+ *       -l 0 <<< fastmem_profile_autotest
+ *   perf report
+ */
+
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_lcore.h>
+#include <rte_memory.h>
+
+#include <rte_fastmem.h>
+
+#include "test.h"
+
+/* Duration of each sub-test in TSC cycles (~3 seconds at 3 GHz). */
+#define PROFILE_DURATION_CYCLES (3ULL * rte_get_tsc_hz())
+
+/* Allocation size for the profiling workload. */
+#define PROFILE_SIZE 256u
+
+/*
+ * Sub-test 1: tight alloc+free, exercises only the per-lcore
+ * cache (no bin interaction after warmup).
+ */
+static int
+profile_cache_hit(void)
+{
+	uint64_t deadline;
+	uint64_t ops = 0;
+
+	deadline = rte_rdtsc() + PROFILE_DURATION_CYCLES;
+
+	while (rte_rdtsc() < deadline) {
+		void *p = rte_fastmem_alloc(PROFILE_SIZE, 0, 0);
+
+		if (p == NULL)
+			return -1;
+		rte_fastmem_free(p);
+		ops++;
+	}
+
+	printf("  cache_hit: %" PRIu64 " ops\n", ops);
+	return 0;
+}
+
+/*
+ * Sub-test 2: alloc N then free N, where N exceeds the cache
+ * capacity. This forces repeated cache refills and drains,
+ * exercising the bin lock and slab free-list traversal.
+ */
+#define PROFILE_BATCH 256u
+
+static int
+profile_cache_miss(void)
+{
+	void *ptrs[PROFILE_BATCH];
+	uint64_t deadline;
+	uint64_t ops = 0;
+	unsigned int i;
+
+	deadline = rte_rdtsc() + PROFILE_DURATION_CYCLES;
+
+	while (rte_rdtsc() < deadline) {
+		for (i = 0; i < PROFILE_BATCH; i++) {
+			ptrs[i] = rte_fastmem_alloc(PROFILE_SIZE, 0, 0);
+			if (ptrs[i] == NULL)
+				return -1;
+		}
+		for (i = 0; i < PROFILE_BATCH; i++)
+			rte_fastmem_free(ptrs[i]);
+		ops += PROFILE_BATCH;
+	}
+
+	printf("  cache_miss: %" PRIu64 " ops\n", ops);
+	return 0;
+}
+
+static int
+test_fastmem_profile_cache_hit(void)
+{
+	int rc;
+
+	rc = rte_fastmem_init();
+	if (rc < 0) {
+		printf("rte_fastmem_init() failed: %d\n", rc);
+		return -1;
+	}
+
+	rc = rte_fastmem_reserve(128 * 1024 * 1024, SOCKET_ID_ANY);
+	if (rc < 0) {
+		printf("rte_fastmem_reserve() failed: %d\n", rc);
+		rte_fastmem_deinit();
+		return -1;
+	}
+
+	printf("fastmem profile: cache-hit workload (size=%u, ~%u s)\n",
+		PROFILE_SIZE, 3);
+
+	if (profile_cache_hit() < 0) {
+		rte_fastmem_deinit();
+		return -1;
+	}
+
+	rte_fastmem_deinit();
+	return 0;
+}
+
+static int
+test_fastmem_profile_cache_miss(void)
+{
+	int rc;
+
+	rc = rte_fastmem_init();
+	if (rc < 0) {
+		printf("rte_fastmem_init() failed: %d\n", rc);
+		return -1;
+	}
+
+	rc = rte_fastmem_reserve(128 * 1024 * 1024, SOCKET_ID_ANY);
+	if (rc < 0) {
+		printf("rte_fastmem_reserve() failed: %d\n", rc);
+		rte_fastmem_deinit();
+		return -1;
+	}
+
+	printf("fastmem profile: cache-miss workload (size=%u, ~%u s)\n",
+		PROFILE_SIZE, 3);
+
+	if (profile_cache_miss() < 0) {
+		rte_fastmem_deinit();
+		return -1;
+	}
+
+	rte_fastmem_deinit();
+	return 0;
+}
+
+REGISTER_PERF_TEST(fastmem_profile_cache_hit_autotest,
+		test_fastmem_profile_cache_hit);
+REGISTER_PERF_TEST(fastmem_profile_cache_miss_autotest,
+		test_fastmem_profile_cache_miss);
-- 
2.43.0

