Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA00C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 577F840A6F;
	Thu, 20 Aug 2026 16:25:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 76AC2406BB;
 Thu, 20 Aug 2026 16:25:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787235921; x=1818771921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1o+q6IlU9OmdgBB9uSH3TTBh67NT3O49JqZBadZd/S4=;
 b=KP4kygT3Y7kvYFgoi0fCaglydeZI5FLv0TrCiOk+ZHGSUfC2aVErnxc/
 +pTQ+9dMo6WcaJk81gYXrECAIAgEYldo6p9UaYfwQ2tMEnW3GsXv2M5yU
 WZobJyOP+dQAiEcLA0i36vYrSXJT698zog/2uXStuGwIkoFViK8Y7ILFX
 YrpI4voMGcOMdGiBVbAE6yKLfc5/+s9YzBRIQKn3mAzJwYN2O1ManT17t
 3PcyC12cAw9RXfcom6jReY2W2hRSNYntzGxmAaefOEImiDbC+ZGoU4Z9n
 YWrlRJ2ukL4PESvLGDAZOFTQsNSKj1imxYg/HaqF7NFTOw04J/xqRb1+3 w==;
X-CSE-ConnectionGUID: I7oaW8w1RtughXWlDl08vg==
X-CSE-MsgGUID: tGAbcgAiToiIZ8kcpJiekQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113311562"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="113311562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:25:21 -0700
X-CSE-ConnectionGUID: HWHNE5rMSo2A4MBC3jj45g==
X-CSE-MsgGUID: L6nzpIbIRz6f5CKGQSWdWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269878723"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 07:25:20 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 2/3] app/test-mempool-perf: add perf test logic
Date: Thu, 20 Aug 2026 15:24:38 +0100
Message-ID: <20260820142439.3684311-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820142439.3684311-1-bruce.richardson@intel.com>
References: <20260820142439.3684311-1-bruce.richardson@intel.com>
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

Add the performance test logic to do performance measurements for the
mempool settings specified. Run-to-completion mode is assumed, and each
thread does allocs and frees in a randomized pattern.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-mempool-perf/main.c      | 248 +++++++++++++++++++++++++++++-
 app/test-mempool-perf/meson.build |   2 +-
 doc/guides/tools/mempoolperf.rst  |  34 ++++
 3 files changed, 282 insertions(+), 2 deletions(-)

diff --git a/app/test-mempool-perf/main.c b/app/test-mempool-perf/main.c
index 877abc2170..471631f3db 100644
--- a/app/test-mempool-perf/main.c
+++ b/app/test-mempool-perf/main.c
@@ -9,9 +9,14 @@
 #include <inttypes.h>

 #include <rte_argparse.h>
+#include <rte_cycles.h>
 #include <rte_eal.h>
+#include <rte_errno.h>
+#include <rte_launch.h>
 #include <rte_lcore.h>
+#include <rte_mbuf.h>
 #include <rte_mempool.h>
+#include <rte_random.h>
 #include <rte_string_fns.h>

 #define DEFAULT_CACHE_SIZE          512
@@ -19,6 +24,11 @@
 #define DEFAULT_BURST_SIZE          32
 #define DEFAULT_NB_BUFS_PER_LCORE   1024

+/* match the element size used by rte_pktmbuf_pool_create with default dataroom */
+#define ELEM_SIZE           (sizeof(struct rte_mbuf) + RTE_MBUF_DEFAULT_BUF_SIZE)
+#define TEST_DURATION_SEC   5
+#define RESHUFFLE_INTERVAL  100
+
 struct test_config {
 	char     mempool_type[RTE_MEMPOOL_NAMESIZE];
 	uint32_t nb_bufs;
@@ -210,9 +220,238 @@ run_interactive_mode(void)
 	return 0;
 }

+struct worker_stats {
+	uint64_t get_success;
+	uint64_t get_fail;
+	uint64_t put_count;
+} __rte_cache_aligned;
+
+static struct worker_stats lcore_stats[RTE_MAX_LCORE];
 static bool summary_only;
+static RTE_ATOMIC(uint32_t) test_running;
+
+/*
+ * Shuffle delta[] (half +1, half -1) then rotate it so the running sum
+ * of held batches never goes negative.  Works by finding the last index
+ * where the prefix sum reaches its minimum and rotating to start just
+ * after that point, which is guaranteed to keep all prefix sums >= 0.
+ */
+static void
+shuffle_and_validate(int8_t *delta, int8_t *tmp, uint32_t rf)
+{
+	uint32_t i, j, rot;
+	int32_t running, min_val;
+	uint32_t min_idx;
+
+	/* Fisher-Yates shuffle */
+	for (i = rf - 1; i > 0; i--) {
+		j = (uint32_t)rte_rand_max(i + 1);
+		int8_t t = delta[i];
+		delta[i] = delta[j];
+		delta[j] = t;
+	}
+
+	/* find last position where prefix sum reaches its minimum */
+	running = 0;
+	min_val = 0;
+	min_idx = 0;
+	for (i = 0; i < rf; i++) {
+		running += delta[i];
+		if (running <= min_val) { /* <= keeps the last occurrence */
+			min_val = running;
+			min_idx = i;
+		}
+	}
+
+	if (min_val >= 0)
+		return; /* already valid, no rotation needed */
+
+	rot = (min_idx + 1) % rf;
+	if (rot == 0)
+		return;
+
+	/* apply rotation via tmp buffer */
+	memcpy(tmp,           delta + rot, (rf - rot) * sizeof(*tmp));
+	memcpy(tmp + rf - rot, delta,       rot        * sizeof(*tmp));
+	memcpy(delta, tmp, rf * sizeof(*tmp));
+}
+
+static void
+access_object(void *obj)
+{
+	volatile uint64_t *p = (volatile uint64_t *)obj;
+	uint64_t acc = 0;
+	uint32_t i;
+
+	for (i = 0; i < ELEM_SIZE / sizeof(uint64_t); i++)
+		acc += p[i];
+	for (i = 0; i < RTE_CACHE_LINE_SIZE / sizeof(uint64_t); i++)
+		p[i] = acc;
+}
+
+static int
+worker_main(void *arg)
+{
+	struct rte_mempool *mp = arg;
+	unsigned int id = rte_lcore_id();
+	struct worker_stats *stats = &lcore_stats[id];
+	/* rf must be even so alloc count == free count; minimum 2 */
+	uint32_t rf = RTE_MAX(2u, (cfg.rand_factor / 2) * 2);
+	uint32_t bs = cfg.burst_size;
+	uint32_t hold_count = 0;
+	uint32_t run = RESHUFFLE_INTERVAL; /* trigger shuffle on first entry */
+	void **hold_objs;
+	int8_t *delta, *tmp;
+	uint32_t i, k;
+
+	hold_objs = malloc(bs * (rf / 2) * sizeof(*hold_objs));
+	delta     = malloc(rf * sizeof(*delta));
+	tmp       = malloc(rf * sizeof(*tmp));
+	if (hold_objs == NULL || delta == NULL || tmp == NULL) {
+		free(hold_objs);
+		free(delta);
+		free(tmp);
+		return -ENOMEM;
+	}
+
+	/* +1 = alloc a burst, -1 = free a burst */
+	for (i = 0; i < rf / 2; i++) delta[i] = +1;
+	for (i = rf / 2; i < rf; i++) delta[i] = -1;
+
+	while (rte_atomic_load_explicit(&test_running, rte_memory_order_relaxed)) {
+		if (run >= RESHUFFLE_INTERVAL) {
+			shuffle_and_validate(delta, tmp, rf);
+			run = 0;
+		}
+
+		for (i = 0; i < rf; i++) {
+			if (delta[i] > 0) {
+				if (rte_mempool_get_bulk(mp,
+						hold_objs + hold_count, bs) != 0) {
+					stats->get_fail++;
+					continue;
+				}
+				if (cfg.access_on_alloc) {
+					for (k = 0; k < bs; k++)
+						access_object(hold_objs[hold_count + k]);
+				}
+				hold_count += bs;
+				stats->get_success += bs;
+			} else {
+				hold_count -= bs;
+				rte_mempool_put_bulk(mp, hold_objs + hold_count, bs);
+				stats->put_count += bs;
+			}
+		}
+		run++;
+	}
+
+	if (hold_count > 0)
+		rte_mempool_put_bulk(mp, hold_objs, hold_count);
+
+	free(tmp);
+	free(delta);
+	free(hold_objs);
+	return 0;
+}

-/* Used only in non-interactive mode to receive the --mempool-type string */
+static struct rte_mempool *
+create_mempool(void)
+{
+	struct rte_mempool *mp;
+	int ret;
+
+	mp = rte_mempool_create_empty("perf_pool", cfg.nb_bufs, ELEM_SIZE,
+				      cfg.cache_size, 0,
+				      rte_socket_id(), 0);
+	if (mp == NULL) {
+		fprintf(stderr, "Failed to create empty mempool: %s\n",
+			rte_strerror(rte_errno));
+		return NULL;
+	}
+
+	ret = rte_mempool_set_ops_byname(mp, cfg.mempool_type, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to set ops '%s': %s\n",
+			cfg.mempool_type, rte_strerror(-ret));
+		rte_mempool_free(mp);
+		return NULL;
+	}
+
+	ret = rte_mempool_populate_default(mp);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to populate mempool: %s\n",
+			rte_strerror(-ret));
+		rte_mempool_free(mp);
+		return NULL;
+	}
+
+	return mp;
+}
+
+static void
+print_results(double elapsed_secs)
+{
+	uint64_t total_get = 0, total_fail = 0;
+	unsigned int id;
+
+	printf("\n%-8s %12s %12s %12s\n",
+	       "lcore", "get (Mops/s)", "fail/burst", "put (Mops/s)");
+	printf("%-8s %12s %12s %12s\n",
+	       "------", "------------", "----------", "------------");
+
+	RTE_LCORE_FOREACH_WORKER(id) {
+		if (lcore_stats[id].get_success == 0 &&
+		    lcore_stats[id].get_fail == 0)
+			continue;
+		if (!summary_only)
+			printf("%-8u %12.3f %12" PRIu64 " %12.3f\n",
+			       id,
+			       lcore_stats[id].get_success / elapsed_secs / 1e6,
+			       lcore_stats[id].get_fail,
+			       lcore_stats[id].put_count / elapsed_secs / 1e6);
+		total_get  += lcore_stats[id].get_success;
+		total_fail += lcore_stats[id].get_fail;
+	}
+
+	printf("%-8s %12.3f %12" PRIu64 "\n\n",
+	       "Total",
+	       total_get / elapsed_secs / 1e6,
+	       total_fail);
+}
+
+static void
+run_test(struct rte_mempool *mp)
+{
+	uint64_t start, end;
+	unsigned int id;
+	uint32_t launched = 0;
+
+	memset(lcore_stats, 0, sizeof(lcore_stats));
+	rte_atomic_store_explicit(&test_running, 1, rte_memory_order_release);
+
+	RTE_LCORE_FOREACH_WORKER(id) {
+		if (launched >= cfg.nb_threads)
+			break;
+		rte_eal_remote_launch(worker_main, mp, id);
+		launched++;
+	}
+
+	printf("Running test for %d seconds with %" PRIu32 " worker(s)...\n",
+	       TEST_DURATION_SEC, launched);
+
+	start = rte_get_timer_cycles();
+	rte_delay_ms((uint32_t)(TEST_DURATION_SEC * 1000));
+
+	rte_atomic_store_explicit(&test_running, 0, rte_memory_order_release);
+	end = rte_get_timer_cycles();
+	rte_eal_mp_wait_lcore();
+
+	double elapsed_s = (double)(end - start) / rte_get_timer_hz();
+	print_results(elapsed_s);
+}
+
+/* receives the --mempool-type string from argparse */
 static const char *mempool_type_arg;

 static int
@@ -325,6 +564,13 @@ main(int argc, char **argv)

 	print_config();

+	struct rte_mempool *mp = create_mempool();
+	if (mp == NULL)
+		rte_exit(EXIT_FAILURE, "Failed to create mempool\n");
+
+	run_test(mp);
+
+	rte_mempool_free(mp);
 	rte_eal_cleanup();
 	return 0;
 }
diff --git a/app/test-mempool-perf/meson.build b/app/test-mempool-perf/meson.build
index 2d61ac62e9..37c6c14d56 100644
--- a/app/test-mempool-perf/meson.build
+++ b/app/test-mempool-perf/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 Intel Corporation

-deps += ['mempool', 'argparse']
+deps += ['mbuf', 'mempool', 'argparse']

 sources = files(
         'main.c',
diff --git a/doc/guides/tools/mempoolperf.rst b/doc/guides/tools/mempoolperf.rst
index e0ad859a29..31bd6e660e 100644
--- a/doc/guides/tools/mempoolperf.rst
+++ b/doc/guides/tools/mempoolperf.rst
@@ -8,6 +8,7 @@ The ``dpdk-test-mempool-perf`` tool measures the alloc/free throughput of DPDK m
 Worker threads repeatedly allocate and free objects in configurable burst sizes following a randomised pattern,
 exercising the pool under varying levels of occupancy.
 Any mempool driver registered with the DPDK mempool ops table can be tested.
+Pool elements are sized to match ``rte_pktmbuf_pool_create()`` with default data room.


 Running the Application
@@ -105,6 +106,39 @@ After configuration the tool prints an equivalent non-interactive command::
 Append this output after the EAL options on subsequent runs to reproduce the exact same configuration without prompting.


+Test Output
+-----------
+
+Each run lasts a fixed 5 seconds.
+On completion, a results table is printed showing per-worker throughput and an aggregate total:
+
+.. code-block:: console
+
+   lcore    get (Mops/s)  fail/burst  put (Mops/s)
+   ------   ------------  ----------  ------------
+   1              23.871           0       23.871
+   2              24.012           0       24.012
+   Total          47.883           0
+
+lcore
+   Worker lcore ID.
+
+get (Mops/s)
+   Successful allocation throughput in millions of operations per second.
+
+fail/burst
+   Number of allocation calls that failed because the pool had insufficient free objects.
+   A non-zero value indicates ``--nb-bufs`` is too small for the configured workload.
+
+put (Mops/s)
+   Free throughput in millions of operations per second.
+   Under a balanced workload this matches the get rate.
+
+The ``Total`` row shows aggregate get throughput and failure count across all workers;
+it does not include a put rate.
+With ``--summary``, only the ``Total`` row is printed.
+
+
 Examples
 --------

--
2.53.0

