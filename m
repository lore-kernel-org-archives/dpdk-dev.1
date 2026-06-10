Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289BDCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 09:12:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6231340652;
	Wed, 10 Jun 2026 11:12:11 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 1A76E40655
 for <dev@dpdk.org>; Wed, 10 Jun 2026 11:12:10 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gb0QY08JzzJ46CH
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:11:49 +0800 (CST)
Received: from frapema500004.china.huawei.com (unknown [7.182.19.21])
 by mail.maildlp.com (Postfix) with ESMTPS id 42F1B40575
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:12:02 +0800 (CST)
Received: from localhost (10.220.239.45) by frapema500004.china.huawei.com
 (7.182.19.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 10 Jun
 2026 11:12:01 +0200
From: Eimear Morrissey <eimear.morrissey@huawei.com>
To: <dev@dpdk.org>
Subject: [PATCH 2/2] app/test: add stress tests for rwlock and pflock
Date: Wed, 10 Jun 2026 10:11:47 +0100
Message-ID: <20260610091147.88412-3-eimear.morrissey@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260610091147.88412-1-eimear.morrissey@huawei.com>
References: <20260610091147.88412-1-eimear.morrissey@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100007.china.huawei.com (7.182.19.38) To
 frapema500004.china.huawei.com (7.182.19.21)
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

Stress tests for pflock. Since the logic is generic enough for
rwlock run them against rwlock too.

Signed-off-by: Eimear Morrissey <eimear.morrissey@huawei.com>
---
 app/test/meson.build               |   2 +
 app/test/test_pflock_stress.c      |  76 ++++++
 app/test/test_rwlock_stress.c      |  59 +++++
 app/test/test_rwlock_stress_impl.h | 393 +++++++++++++++++++++++++++++
 4 files changed, 530 insertions(+)
 create mode 100644 app/test/test_pflock_stress.c
 create mode 100644 app/test/test_rwlock_stress.c
 create mode 100644 app/test/test_rwlock_stress_impl.h

diff --git a/app/test/meson.build b/app/test/meson.build
index 61024125a7..f85ad617ce 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -140,6 +140,7 @@ source_file_deps = {
     'test_pdump.c': ['pdump'] + sample_packet_forward_deps,
     'test_per_lcore.c': [],
     'test_pflock.c': [],
+    'test_pflock_stress.c': [],
     'test_pie.c': ['sched'],
     'test_pmd_af_packet.c': ['net_af_packet', 'ethdev', 'bus_vdev'],
     'test_pmd_pcap.c': ['net_pcap', 'ethdev', 'bus_vdev']  + packet_burst_generator_deps,
@@ -178,6 +179,7 @@ source_file_deps = {
     'test_ring_st_peek_stress_zc.c': ['ptr_compress'],
     'test_ring_stress.c': ['ptr_compress'],
     'test_rwlock.c': [],
+    'test_rwlock_stress.c': [],
     'test_sched.c': ['net', 'sched'],
     'test_security.c': ['net', 'security'],
     'test_security_inline_macsec.c': ['ethdev', 'security'],
diff --git a/app/test/test_pflock_stress.c b/app/test/test_pflock_stress.c
new file mode 100644
index 0000000000..cafc5defba
--- /dev/null
+++ b/app/test/test_pflock_stress.c
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include "test_rwlock_stress_impl.h"
+
+/* Pflock operation implementations */
+static void
+pflock_init_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_init(&lock->lock.pflock);
+}
+
+static void
+pflock_read_lock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_read_lock(&lock->lock.pflock);
+}
+
+static void
+pflock_read_unlock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_read_unlock(&lock->lock.pflock);
+}
+
+static void
+pflock_write_lock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_write_lock(&lock->lock.pflock);
+}
+
+static void
+pflock_write_unlock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_write_unlock(&lock->lock.pflock);
+}
+
+static void
+pflock_write_downgrade_fn(struct rwlock_stress_lock *lock)
+{
+	rte_pflock_write_downgrade(&lock->lock.pflock);
+}
+
+/* Pflock operations table */
+static const struct rwlock_ops pflock_ops = {
+	.name = "pflock",
+	.init = pflock_init_fn,
+	.read_lock = pflock_read_lock_fn,
+	.read_unlock = pflock_read_unlock_fn,
+	.write_lock = pflock_write_lock_fn,
+	.write_unlock = pflock_write_unlock_fn,
+	.write_downgrade = pflock_write_downgrade_fn,
+};
+
+static const struct test_descriptor pflock_specific_tests[] = {
+{
+		.name = "write_downgrade",
+		.num_readers_pct = 50,
+		.reader_delay_us = 0,
+		.writer_delay_us = 0,
+		.flags = DOWNGRADE_TEST,
+	},
+};
+
+static int
+run_pflock_tests(void)
+{
+	int ret = 0;
+	ret |= run_test_suite("PFLOCK Common Stress Tests", &pflock_ops,
+			tests, RTE_DIM(tests));
+	ret |= run_test_suite("PFLOCK Specific Stress Tests", &pflock_ops,
+			pflock_specific_tests, RTE_DIM(pflock_specific_tests));
+	return ret ? -1 : 0;
+}
+
+REGISTER_STRESS_TEST(pflock_stress_autotest, run_pflock_tests);
diff --git a/app/test/test_rwlock_stress.c b/app/test/test_rwlock_stress.c
new file mode 100644
index 0000000000..5d151f3f8f
--- /dev/null
+++ b/app/test/test_rwlock_stress.c
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#include "test_rwlock_stress_impl.h"
+
+/* RWLock operation implementations */
+static void
+rwlock_init_fn(struct rwlock_stress_lock *lock)
+{
+	rte_rwlock_init(&lock->lock.rwlock);
+}
+
+static void
+rwlock_read_lock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_rwlock_read_lock(&lock->lock.rwlock);
+}
+
+static void
+rwlock_read_unlock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_rwlock_read_unlock(&lock->lock.rwlock);
+}
+
+static void
+rwlock_write_lock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_rwlock_write_lock(&lock->lock.rwlock);
+}
+
+static void
+rwlock_write_unlock_fn(struct rwlock_stress_lock *lock)
+{
+	rte_rwlock_write_unlock(&lock->lock.rwlock);
+}
+
+/* RWLock operations table */
+static const struct rwlock_ops rwlock_ops = {
+	.name = "rwlock",
+	.init = rwlock_init_fn,
+	.read_lock = rwlock_read_lock_fn,
+	.read_unlock = rwlock_read_unlock_fn,
+	.write_lock = rwlock_write_lock_fn,
+	.write_unlock = rwlock_write_unlock_fn,
+};
+
+static int
+run_rwlock_tests(void)
+{
+	int ret = 0;
+
+	ret |= run_test_suite("RWLOCK Stress Tests", &rwlock_ops, tests,
+			RTE_DIM(tests));
+
+	return ret ? -1 : 0;
+}
+
+REGISTER_STRESS_TEST(rwlock_stress_autotest, run_rwlock_tests);
diff --git a/app/test/test_rwlock_stress_impl.h b/app/test/test_rwlock_stress_impl.h
new file mode 100644
index 0000000000..d28ccd76e0
--- /dev/null
+++ b/app/test/test_rwlock_stress_impl.h
@@ -0,0 +1,393 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _TEST_RWLOCK_STRESS_H_
+#define _TEST_RWLOCK_STRESS_H_
+
+/**
+ * Generic reader-writer lock stress test.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <stdbool.h>
+
+#include <rte_lcore.h>
+#include <rte_cycles.h>
+#include <rte_atomic.h>
+#include <rte_launch.h>
+#include <rte_per_lcore.h>
+#include <rte_malloc.h>
+#include <rte_pflock.h>
+#include <rte_random.h>
+#include <rte_rwlock.h>
+
+#include "test.h"
+
+#define TEST_DURATION_SEC 5
+#define COUNTER_ARRAY_SIZE 1024
+#define DOWNGRADE_TEST 0x1   /* Will attempt to downgrade from write to read lock */
+#define DYNAMIC_ROLES  0x2  /* Threads can switch between reader/writer roles */
+
+struct rwlock_stress_lock;
+
+/**
+ * Lock operations interface.
+ */
+struct rwlock_ops {
+	const char *name;
+
+	void (*init)(struct rwlock_stress_lock *lock);
+	void (*read_lock)(struct rwlock_stress_lock *lock);
+	void (*read_unlock)(struct rwlock_stress_lock *lock);
+	void (*write_lock)(struct rwlock_stress_lock *lock);
+	void (*write_unlock)(struct rwlock_stress_lock *lock);
+	void (*write_downgrade)(struct rwlock_stress_lock *lock);
+};
+
+/**
+ * Generic lock structure.
+ */
+struct rwlock_stress_lock {
+	const struct rwlock_ops *ops;
+
+	union {
+		struct rte_pflock pflock;
+		rte_rwlock_t rwlock;
+	} lock;
+};
+
+/**
+ * Per-lcore statistics
+ */
+struct lcore_stats {
+	uint64_t reader_ops;
+	uint64_t writer_ops;
+	uint64_t local_counter;
+	uint64_t reader_errors;
+	uint64_t writer_errors;
+	uint64_t acquire_time;
+} __rte_cache_aligned;
+
+/**
+ * Test controls
+ */
+struct test_descriptor {
+	const char *name;
+	uint32_t num_readers_pct;  /* Percentage of workers as readers (0-100) */
+	uint32_t reader_delay_us;  /* Microseconds to delay in reader */
+	uint32_t writer_delay_us;  /* Microseconds to delay in writer */
+	uint32_t flags;           /* Specialist test behaviour */
+};
+
+/**
+ * Shared test state.
+ */
+struct rwlock_test_shared {
+	struct rwlock_stress_lock lock;
+	volatile uint64_t counter;
+	volatile uint64_t counter_array[COUNTER_ARRAY_SIZE];
+	volatile bool stop;
+	uint32_t num_readers;
+	uint32_t num_writers;
+	const struct test_descriptor *test;
+	struct lcore_stats stats[RTE_MAX_LCORE];
+} __rte_cache_aligned;
+
+/* Test descriptors array */
+static const struct test_descriptor tests[] = {
+	{
+		.name = "basic_reader_writer",
+		.num_readers_pct = 75,
+		.reader_delay_us = 0,
+		.writer_delay_us = 0,
+	},
+	{
+		.name = "long_hold",
+		.num_readers_pct = 67,
+		.reader_delay_us = 100,
+		.writer_delay_us = 100,
+	},
+	{
+		.name = "rapid_acquire_release",
+		.num_readers_pct = 67,
+		.reader_delay_us = 0,
+		.writer_delay_us = 0,
+	},
+	{
+		.name = "dynamic_roles",
+		.num_readers_pct = 75,
+		.reader_delay_us = 0,
+		.writer_delay_us = 0,
+		.flags = DYNAMIC_ROLES,
+	},
+};
+
+static inline bool
+should_be_writer(uint32_t num_readers, uint32_t flags)
+{
+	uint32_t total_lcores = rte_lcore_count();
+	if (total_lcores <= 1)
+		return true;
+
+	if (flags & DYNAMIC_ROLES) {
+		uint32_t readers_pct = (num_readers * 100) / (total_lcores - 1);
+		return (rte_rand_max(100) >= readers_pct);
+	}
+
+	unsigned int idx = rte_lcore_index(rte_lcore_id()) - 1;
+	return idx >= num_readers;
+}
+
+static void
+handle_error(struct rwlock_test_shared *s, unsigned int lcore_id,
+		bool write_lock, const char *func, int line)
+{
+	s->stop = true;
+	if (write_lock) {
+		s->stats[lcore_id].writer_errors++;
+		s->lock.ops->write_unlock(&s->lock);
+	} else {
+		s->stats[lcore_id].reader_errors++;
+		/* Don't unlock here as it's already unlocked by the calling function */
+	}
+	printf("ERROR: lcore:%u: %s:%d early termination\n", lcore_id, func, line);
+}
+
+static int
+handle_writer_work(struct rwlock_test_shared *s, unsigned int lcore_id,
+		const struct test_descriptor *test, uint64_t delta)
+{
+	s->lock.ops->write_lock(&s->lock);
+	uint64_t old_val = s->counter;
+	s->counter += delta;
+	s->stats[lcore_id].local_counter += delta;
+
+	/* Verify increment was atomic */
+	if (s->counter != old_val + delta) {
+		handle_error(s, lcore_id, true, __func__, __LINE__);
+		return -1;
+	}
+
+	/* Update all array elements */
+	for (uint32_t i = 0; i < COUNTER_ARRAY_SIZE; i++) {
+		s->counter_array[i] += delta;
+		if (s->counter_array[i] != s->counter) {
+			handle_error(s, lcore_id, true, __func__, __LINE__);
+			return -1;
+		}
+	}
+
+	if (test->flags & DOWNGRADE_TEST) {
+		/* Downgrade to read lock */
+		if (s->lock.ops->write_downgrade) {
+			s->lock.ops->write_downgrade(&s->lock);
+			/* Verify array consistency under read lock */
+			for (uint32_t i = 0; i < COUNTER_ARRAY_SIZE; i++) {
+				if (s->counter_array[i] != s->counter) {
+					handle_error(s, lcore_id, false, __func__, __LINE__);
+					return -1;
+				}
+			}
+			s->lock.ops->read_unlock(&s->lock);
+		}
+	} else {
+		if (test->writer_delay_us > 0)
+			rte_delay_us_sleep(test->writer_delay_us);
+		s->lock.ops->write_unlock(&s->lock);
+	}
+	s->stats[lcore_id].writer_ops++;
+	return 0;
+}
+
+static int
+handle_reader_work(struct rwlock_test_shared *s, unsigned int lcore_id,
+		const struct test_descriptor *test)
+{
+	uint64_t local_counter;
+
+	s->lock.ops->read_lock(&s->lock);
+	local_counter = s->counter;
+
+	/* Verify array consistency */
+	for (uint32_t i = 0; i < COUNTER_ARRAY_SIZE; i++) {
+		if (s->counter_array[i] != local_counter) {
+			handle_error(s, lcore_id, false, __func__, __LINE__);
+			return -1;
+		}
+	}
+
+	if (test->reader_delay_us > 0)
+		rte_delay_us_sleep(test->reader_delay_us);
+
+	/* Verify counter didn't change during read */
+	if (s->counter != local_counter) {
+		handle_error(s, lcore_id, false, __func__, __LINE__);
+		return -1;
+	}
+
+	s->lock.ops->read_unlock(&s->lock);
+	s->stats[lcore_id].reader_ops++;
+	return 0;
+}
+
+static int
+lcore_function(void *arg)
+{
+	struct rwlock_test_shared *s = arg;
+	unsigned int lcore_id = rte_lcore_id();
+	bool is_writer = should_be_writer(s->num_readers, s->test->flags);
+	const struct test_descriptor *test = s->test;
+
+	while (!s->stop) {
+		uint64_t start = rte_get_timer_cycles();
+		uint64_t delta = (rte_rand() % 64) + 1;
+		int ret;
+
+		if (is_writer)
+			ret = handle_writer_work(s, lcore_id, test, delta);
+		else
+			ret = handle_reader_work(s, lcore_id, test);
+
+		if (ret < 0)
+			continue;
+
+		/* Record max acquire time */
+		uint64_t wait_time = rte_get_timer_cycles() - start;
+		if (wait_time > s->stats[lcore_id].acquire_time)
+			s->stats[lcore_id].acquire_time = wait_time;
+	}
+
+	return 0;
+}
+
+static int
+verify(struct rwlock_test_shared *s)
+{
+	int ret = 0;
+	unsigned int lcore_id;
+	uint64_t total_reader_errors = 0;
+	uint64_t total_writer_errors = 0;
+	uint64_t sum_local_counters = 0;
+
+	/* Calculate errors and counters */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		total_reader_errors += s->stats[lcore_id].reader_errors;
+		total_writer_errors += s->stats[lcore_id].writer_errors;
+		sum_local_counters += s->stats[lcore_id].local_counter;
+	}
+
+	/* Verify sum of per-lcore counters matches the shared counter */
+	if (s->counter != sum_local_counters) {
+		printf("  FAILED: shared counter=%" PRIu64
+		       " sum of local counters=%" PRIu64 "\n",
+		       s->counter, sum_local_counters);
+		ret = -1;
+	}
+
+	if (total_reader_errors) {
+		printf("  FAILED: reader errors=%" PRIu64 "\n",
+		       total_reader_errors);
+		ret = -1;
+	}
+
+	if (total_writer_errors) {
+		printf("  FAILED: writer errors =%" PRIu64 "\n",
+		       total_writer_errors);
+		ret = -1;
+	}
+
+	/* Verify array consistency */
+	for (uint32_t i = 0; i < COUNTER_ARRAY_SIZE; i++) {
+		if (s->counter_array[i] != s->counter) {
+			printf("  FAILED: counter_array[%u]=%" PRIu64 " counter=%" PRIu64 "\n",
+			       i, s->counter_array[i], s->counter);
+			ret = -1;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int
+test_rwlock_stress_impl(const struct rwlock_ops *ops,
+		const struct test_descriptor *ind_test)
+{
+	struct rwlock_test_shared shared = {0};
+	uint64_t start_time, end_time;
+	uint64_t total_reader_ops = 0;
+	uint64_t total_writer_ops = 0;
+	uint64_t max_acquire_time = 0;
+	unsigned int lcore_id;
+	int ret = 0;
+
+	shared.lock.ops = ops;
+	shared.lock.ops->init(&shared.lock);
+	shared.test = ind_test;
+	shared.num_readers = (ind_test->num_readers_pct * (rte_lcore_count() - 1)) / 100;
+	shared.num_writers = (rte_lcore_count() - 1) - shared.num_readers;
+
+	printf("  %u readers, %u writers\n", shared.num_readers, shared.num_writers);
+
+	/* Launch workers */
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_remote_launch(lcore_function, &shared, lcore_id);
+	}
+
+	/* Run test for duration */
+	start_time = rte_get_timer_cycles();
+	rte_delay_ms(TEST_DURATION_SEC * 1000);
+
+	/* Stop workers and collect stats */
+	shared.stop = true;
+	RTE_LCORE_FOREACH_WORKER(lcore_id) {
+		rte_eal_wait_lcore(lcore_id);
+		if (shared.stats[lcore_id].acquire_time > max_acquire_time)
+			max_acquire_time = shared.stats[lcore_id].acquire_time;
+		total_reader_ops += shared.stats[lcore_id].reader_ops;
+		total_writer_ops += shared.stats[lcore_id].writer_ops;
+	}
+	end_time = rte_get_timer_cycles();
+
+	printf("  %"PRIu64" reader ops, %"PRIu64" writer ops,"
+	      "total time: %.2f seconds\n",
+	       total_reader_ops, total_writer_ops,
+	       (double)(end_time - start_time) / rte_get_timer_hz());
+
+	ret = verify(&shared);
+	if (ret == 0) {
+		uint64_t hz = rte_get_timer_hz();
+		printf("  PASSED: All checks passed (max wait: %.2f us)\n",
+		       (double)max_acquire_time * 1000000 / hz);
+	}
+	return ret;
+}
+
+/**
+ * Run a test suite with the given title and tests
+ */
+static int
+run_test_suite(const char *title, const struct rwlock_ops *ops,
+		const struct test_descriptor suite[], uint32_t count)
+{
+	uint32_t failed = 0;
+
+	printf("%s\n===================\n\n", title);
+	for (uint32_t i = 0; i < count; i++) {
+		printf("Test %u/%u: %s\n", i + 1, count, suite[i].name);
+		if (test_rwlock_stress_impl(ops, &suite[i]) < 0)
+			failed++;
+		printf("\n");
+	}
+	printf("===================\n");
+	printf("Results: %u/%u passed, %u failed\n", count - failed, count, failed);
+
+	return failed ? -1 : 0;
+}
+
+#endif /* _TEST_RWLOCK_STRESS_H_ */
-- 
2.51.0

