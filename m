Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C7C5DF81
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 14:25:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE69740A8B;
	Thu, 20 Aug 2026 16:25:24 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id AAD0F40685;
 Thu, 20 Aug 2026 16:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787235924; x=1818771924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IA/H0lNq0gj0Ns+kq5yMXVyM77t5cDnsi4zCwS9y1NE=;
 b=jRS14In8csemwZpT8XglsHJBPKksTeF+eqx3uSwbIXwjbLdrECL2Y/kJ
 PItZ/NsTV9imUUuu5gqgW5sEI8+7pTtOPudqCt5KCpB3sGChXmh2r3F5I
 bR+kAWNlXdPtjUaKh+P/TEKwsvjCwDVUv3esfSwHofllaB2jkj9Td28dd
 1oDs+vCyJUaDMpQD76uVAC2dtwP6+WRsT6NTDRDCDqeLUdxgM1FzkC1lW
 usXDV4/TSXoM8hkKdiomnczd1X4Hza+BSt1FozYzk57cxa3CRKdnC8dRA
 t7iyxCq60rHAHD4RUvrM+m9ZS6BFTb0ZJyj+BGV55f48DlKSp/bV3Q5o0 w==;
X-CSE-ConnectionGUID: bR1JRjcvT3CiPOf/3kCrgA==
X-CSE-MsgGUID: EIuovgZVRu+bKI2Cj3Uryw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113311563"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="113311563"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:25:23 -0700
X-CSE-ConnectionGUID: S/s80dNrQxGQRGcEq8Qcjw==
X-CSE-MsgGUID: PEm+plT9R+uvnpBbofPbFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="269878741"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 20 Aug 2026 07:25:22 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: techboard@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 3/3] app/test-mempool-perf: add testing in pipeline model
Date: Thu, 20 Aug 2026 15:24:39 +0100
Message-ID: <20260820142439.3684311-4-bruce.richardson@intel.com>
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

The characteristics of apps written as a pipelines differ significantly
from apps written using a run-to-completion model, so add a mode to test
those out too. If "--pipeline"/"-p" is specified, workers are divided
into paired producers and consumers with rings between them and alloc
and frees from mempool take place on different cores.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-mempool-perf/main.c      | 252 ++++++++++++++++++++++++++++--
 app/test-mempool-perf/meson.build |   2 +-
 doc/guides/tools/mempoolperf.rst  |  55 ++++++-
 3 files changed, 297 insertions(+), 12 deletions(-)

diff --git a/app/test-mempool-perf/main.c b/app/test-mempool-perf/main.c
index 471631f3db..9f026dfb15 100644
--- a/app/test-mempool-perf/main.c
+++ b/app/test-mempool-perf/main.c
@@ -17,6 +17,7 @@
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
 #include <rte_random.h>
+#include <rte_ring.h>
 #include <rte_string_fns.h>

 #define DEFAULT_CACHE_SIZE          512
@@ -28,6 +29,7 @@
 #define ELEM_SIZE           (sizeof(struct rte_mbuf) + RTE_MBUF_DEFAULT_BUF_SIZE)
 #define TEST_DURATION_SEC   5
 #define RESHUFFLE_INTERVAL  100
+#define PIPELINE_RING_SIZE  1024

 struct test_config {
 	char     mempool_type[RTE_MEMPOOL_NAMESIZE];
@@ -37,6 +39,7 @@ struct test_config {
 	uint32_t rand_factor;
 	uint32_t burst_size;
 	bool     access_on_alloc;
+	bool     pipeline_mode;
 };

 static struct test_config cfg = {
@@ -47,6 +50,7 @@ static struct test_config cfg = {
 	.rand_factor    = DEFAULT_RAND_FACTOR,
 	.burst_size     = DEFAULT_BURST_SIZE,
 	.access_on_alloc = true,
+	.pipeline_mode  = false,
 };

 static void
@@ -94,16 +98,23 @@ print_config(void)
 	printf("  Randomness factor: %" PRIu32 "\n", cfg.rand_factor);
 	printf("  Burst size       : %" PRIu32 "\n", cfg.burst_size);
 	printf("  Access on alloc  : %s\n", cfg.access_on_alloc ? "yes" : "no");
+	printf("  Pipeline mode    : %s\n", cfg.pipeline_mode ? "yes" : "no");
 	printf("========================================\n\n");
 }

 static void
 print_reproduce_cmd(void)
 {
-	printf("Reproduce using parameters:"
-		" -M %s -n %" PRIu32 " -c %" PRIu32 " -t %" PRIu32 " -r %" PRIu32 " -b %" PRIu32 " %s\n\n",
-			cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads, cfg.rand_factor,
-			cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N");
+	if (cfg.pipeline_mode)
+		printf("Reproduce using parameters:"
+			" -M %s -n %" PRIu32 " -c %" PRIu32 " -t %" PRIu32 " -b %" PRIu32 " %s -p\n\n",
+				cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads,
+				cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N");
+	else
+		printf("Reproduce using parameters:"
+			" -M %s -n %" PRIu32 " -c %" PRIu32 " -t %" PRIu32 " -r %" PRIu32 " -b %" PRIu32 " %s\n\n",
+				cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads,
+				cfg.rand_factor, cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N");
 }

 static void
@@ -189,11 +200,30 @@ run_interactive_mode(void)
 	if (prompt_uint32(prompt, &cfg.nb_threads) < 0)
 		return -1;

-	/* Randomness factor */
-	snprintf(prompt, sizeof(prompt),
-		 "Randomness factor [%" PRIu32 "]: ", cfg.rand_factor);
-	if (prompt_uint32(prompt, &cfg.rand_factor) < 0)
-		return -1;
+	/* Pipeline mode */
+	printf("Pipeline mode (producer/consumer pairs) [%s]: ",
+	       cfg.pipeline_mode ? "yes" : "no");
+	fflush(stdout);
+	{
+		char yn[16];
+
+		if (fgets(yn, sizeof(yn), stdin) == NULL)
+			return -1;
+		trim_newline(yn);
+		if (yn[0] == 'y' || yn[0] == 'Y')
+			cfg.pipeline_mode = true;
+		else if (yn[0] == 'n' || yn[0] == 'N')
+			cfg.pipeline_mode = false;
+		/* else keep default */
+	}
+
+	/* Randomness factor (not used in pipeline mode) */
+	if (!cfg.pipeline_mode) {
+		snprintf(prompt, sizeof(prompt),
+			 "Randomness factor [%" PRIu32 "]: ", cfg.rand_factor);
+		if (prompt_uint32(prompt, &cfg.rand_factor) < 0)
+			return -1;
+	}

 	/* Burst size */
 	snprintf(prompt, sizeof(prompt),
@@ -228,8 +258,14 @@ struct worker_stats {

 static struct worker_stats lcore_stats[RTE_MAX_LCORE];
 static bool summary_only;
+static bool pipeline_producer[RTE_MAX_LCORE];
 static RTE_ATOMIC(uint32_t) test_running;

+struct pipeline_arg {
+	struct rte_mempool *mp;
+	struct rte_ring    *ring;
+};
+
 /*
  * Shuffle delta[] (half +1, half -1) then rotate it so the running sum
  * of held batches never goes negative.  Works by finding the last index
@@ -355,6 +391,75 @@ worker_main(void *arg)
 	return 0;
 }

+static int
+producer_main(void *arg)
+{
+	struct pipeline_arg *parg = arg;
+	struct rte_mempool *mp = parg->mp;
+	struct rte_ring *ring = parg->ring;
+	unsigned int id = rte_lcore_id();
+	struct worker_stats *stats = &lcore_stats[id];
+	uint32_t bs = cfg.burst_size;
+	uint32_t i;
+	void **objs;
+
+	objs = malloc(bs * sizeof(*objs));
+	if (objs == NULL)
+		return -ENOMEM;
+
+	while (rte_atomic_load_explicit(&test_running, rte_memory_order_relaxed)) {
+		if (rte_mempool_get_bulk(mp, objs, bs) != 0) {
+			stats->get_fail++;
+			continue;
+		}
+		for (i = 0; i < bs; i++)
+			access_object(objs[i]);
+		/* spin until ring has space, or bail out if test ends */
+		while (rte_ring_enqueue_bulk(ring, objs, bs, NULL) == 0) {
+			rte_pause();
+			if (!rte_atomic_load_explicit(&test_running, rte_memory_order_relaxed)) {
+				rte_mempool_put_bulk(mp, objs, bs);
+				goto done;
+			}
+		}
+		stats->get_success += bs;
+	}
+done:
+	free(objs);
+	return 0;
+}
+
+static int
+consumer_main(void *arg)
+{
+	struct pipeline_arg *parg = arg;
+	struct rte_mempool *mp = parg->mp;
+	struct rte_ring *ring = parg->ring;
+	unsigned int id = rte_lcore_id();
+	struct worker_stats *stats = &lcore_stats[id];
+	uint32_t bs = cfg.burst_size;
+	uint32_t i;
+	void **objs;
+
+	objs = malloc(bs * sizeof(*objs));
+	if (objs == NULL)
+		return -ENOMEM;
+
+	while (rte_atomic_load_explicit(&test_running, rte_memory_order_relaxed)) {
+		if (rte_ring_dequeue_bulk(ring, objs, bs, NULL) == 0) {
+			rte_pause();
+			continue;
+		}
+		for (i = 0; i < bs; i++)
+			access_object(objs[i]);
+		rte_mempool_put_bulk(mp, objs, bs);
+		stats->get_success += bs;
+		stats->put_count   += bs;
+	}
+	free(objs);
+	return 0;
+}
+
 static struct rte_mempool *
 create_mempool(void)
 {
@@ -420,6 +525,46 @@ print_results(double elapsed_secs)
 	       total_fail);
 }

+static void
+print_pipeline_results(double elapsed_secs)
+{
+	uint64_t total_cons = 0, total_fail = 0;
+	unsigned int id;
+
+	printf("\n%-8s %-10s %12s %12s\n",
+	       "lcore", "role", "Mops/s", "fail/burst");
+	printf("%-8s %-10s %12s %12s\n",
+	       "------", "----------", "------------", "----------");
+
+	RTE_LCORE_FOREACH_WORKER(id) {
+		if (lcore_stats[id].get_success == 0 &&
+		    lcore_stats[id].put_count   == 0 &&
+		    lcore_stats[id].get_fail    == 0)
+			continue;
+		if (pipeline_producer[id]) {
+			if (!summary_only)
+				printf("%-8u %-10s %12.3f %12" PRIu64 "\n",
+				       id, "producer",
+				       lcore_stats[id].get_success / elapsed_secs / 1e6,
+				       lcore_stats[id].get_fail);
+			total_fail += lcore_stats[id].get_fail;
+		} else {
+			if (!summary_only)
+				printf("%-8u %-10s %12.3f %12" PRIu64 "\n",
+				       id, "consumer",
+				       lcore_stats[id].put_count / elapsed_secs / 1e6,
+				       lcore_stats[id].get_fail);
+			total_cons += lcore_stats[id].put_count;
+		}
+	}
+
+	/* pipeline throughput = consumer completion rate (the end-to-end bottleneck) */
+	printf("%-8s %-10s %12.3f %12" PRIu64 "\n\n",
+	       "Total", "",
+	       total_cons / elapsed_secs / 1e6,
+	       total_fail);
+}
+
 static void
 run_test(struct rte_mempool *mp)
 {
@@ -451,6 +596,85 @@ run_test(struct rte_mempool *mp)
 	print_results(elapsed_s);
 }

+static void
+run_pipeline_test(struct rte_mempool *mp)
+{
+	unsigned int worker_lcores[RTE_MAX_LCORE];
+	char ring_name[RTE_RING_NAMESIZE];
+	struct pipeline_arg *pargs;
+	struct rte_ring **rings;
+	void *drain[64];
+	uint64_t start, end;
+	uint32_t nb_workers = 0;
+	uint32_t nb_pairs;
+	uint32_t n, i;
+	unsigned int id;
+
+	RTE_LCORE_FOREACH_WORKER(id) {
+		if (nb_workers >= cfg.nb_threads)
+			break;
+		worker_lcores[nb_workers++] = id;
+	}
+
+	nb_pairs = nb_workers / 2;
+	if (nb_pairs == 0)
+		rte_exit(EXIT_FAILURE,
+			 "Pipeline mode needs at least 2 worker lcores\n");
+
+	pargs = malloc(nb_pairs * sizeof(*pargs));
+	rings = malloc(nb_pairs * sizeof(*rings));
+	if (pargs == NULL || rings == NULL)
+		rte_exit(EXIT_FAILURE, "Failed to allocate pipeline resources\n");
+
+	for (i = 0; i < nb_pairs; i++) {
+		snprintf(ring_name, sizeof(ring_name), "pipe_ring_%u", i);
+		rings[i] = rte_ring_create(ring_name, PIPELINE_RING_SIZE,
+					   rte_socket_id(),
+					   RING_F_SP_ENQ | RING_F_SC_DEQ);
+		if (rings[i] == NULL)
+			rte_exit(EXIT_FAILURE,
+				 "Failed to create pipeline ring %u: %s\n",
+				 i, rte_strerror(rte_errno));
+		pargs[i].mp   = mp;
+		pargs[i].ring = rings[i];
+	}
+
+	memset(lcore_stats, 0, sizeof(lcore_stats));
+	memset(pipeline_producer, 0, sizeof(pipeline_producer));
+	rte_atomic_store_explicit(&test_running, 1, rte_memory_order_release);
+
+	for (i = 0; i < nb_pairs; i++) {
+		id = worker_lcores[i];
+		pipeline_producer[id] = true;
+		rte_eal_remote_launch(producer_main, &pargs[i], id);
+	}
+	for (i = 0; i < nb_pairs; i++) {
+		id = worker_lcores[nb_pairs + i];
+		rte_eal_remote_launch(consumer_main, &pargs[i], id);
+	}
+
+	printf("Pipeline test: %" PRIu32 " producer/consumer pair(s), "
+	       "%d seconds...\n", nb_pairs, TEST_DURATION_SEC);
+
+	start = rte_get_timer_cycles();
+	rte_delay_ms((uint32_t)(TEST_DURATION_SEC * 1000));
+	rte_atomic_store_explicit(&test_running, 0, rte_memory_order_release);
+	end = rte_get_timer_cycles();
+	rte_eal_mp_wait_lcore();
+
+	/* drain objects left in rings after workers exit, then release rings */
+	for (i = 0; i < nb_pairs; i++) {
+		while ((n = rte_ring_dequeue_burst(rings[i], drain, RTE_DIM(drain), NULL)) > 0)
+			rte_mempool_put_bulk(mp, drain, n);
+		rte_ring_free(rings[i]);
+	}
+
+	print_pipeline_results((double)(end - start) / rte_get_timer_hz());
+
+	free(pargs);
+	free(rings);
+}
+
 /* receives the --mempool-type string from argparse */
 static const char *mempool_type_arg;

@@ -508,6 +732,11 @@ parse_args(int argc, char **argv)
 			  (void *)&summary_only, (void *)true,
 			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
 			},
+			{ "--pipeline", "-p",
+			  "Pipeline mode: pair threads as producers and consumers connected by rings",
+			  (void *)&cfg.pipeline_mode, (void *)true,
+			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
+			},
 			ARGPARSE_ARG_END(),
 		},
 	};
@@ -568,7 +797,10 @@ main(int argc, char **argv)
 	if (mp == NULL)
 		rte_exit(EXIT_FAILURE, "Failed to create mempool\n");

-	run_test(mp);
+	if (cfg.pipeline_mode)
+		run_pipeline_test(mp);
+	else
+		run_test(mp);

 	rte_mempool_free(mp);
 	rte_eal_cleanup();
diff --git a/app/test-mempool-perf/meson.build b/app/test-mempool-perf/meson.build
index 37c6c14d56..2410f497a9 100644
--- a/app/test-mempool-perf/meson.build
+++ b/app/test-mempool-perf/meson.build
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2024 Intel Corporation

-deps += ['mbuf', 'mempool', 'argparse']
+deps += ['mbuf', 'mempool', 'argparse', 'ring']

 sources = files(
         'main.c',
diff --git a/doc/guides/tools/mempoolperf.rst b/doc/guides/tools/mempoolperf.rst
index 31bd6e660e..d5e8def7db 100644
--- a/doc/guides/tools/mempoolperf.rst
+++ b/doc/guides/tools/mempoolperf.rst
@@ -5,8 +5,11 @@ dpdk-test-mempool-perf Application
 ====================================

 The ``dpdk-test-mempool-perf`` tool measures the alloc/free throughput of DPDK mempool implementations.
-Worker threads repeatedly allocate and free objects in configurable burst sizes following a randomised pattern,
+In the default run-to-completion mode,
+worker threads repeatedly allocate and free objects in configurable burst sizes following a randomised pattern,
 exercising the pool under varying levels of occupancy.
+An optional pipeline mode pairs threads as producers and consumers connected by rings,
+modelling multi-stage packet processing pipelines.
 Any mempool driver registered with the DPDK mempool ops table can be tested.
 Pool elements are sized to match ``rte_pktmbuf_pool_create()`` with default data room.

@@ -67,6 +70,7 @@ Application Options
    A larger value means workers hold more in-flight objects on average
    and vary their occupancy over a wider range,
    exercising the pool under a more realistic mix of pressure levels.
+   Not used in pipeline mode (``--pipeline``).

 ``--burst-size <n>`` / ``-b <n>``
    Number of objects per alloc or free call.
@@ -87,6 +91,17 @@ Application Options
    Print only the aggregate total in the results, suppressing the per-worker-lcore breakdown.
    Useful when scripting comparisons across pool types or configurations.

+``--pipeline`` / ``-p``
+   Enable pipeline mode.
+   Worker lcores are paired as producers and consumers.
+   Each producer allocates a burst of objects, writes to them,
+   and enqueues it to a ring shared with its paired consumer.
+   The consumer dequeues the burst, reads and writes the objects, then frees them to the pool.
+   This models a pipeline application where objects traverse processing stages on different cores,
+   in contrast to run-to-completion mode where each core handles the full object lifecycle.
+   ``--rand-factor`` is not applicable in this mode.
+   The thread count must be at least 2; if ``--nb-threads`` is odd, the last lcore is unused.
+

 Interactive Mode
 ----------------
@@ -98,6 +113,8 @@ Running the tool with only EAL options enters interactive mode::
 The application lists all available mempool drivers then prompts for each parameter.
 Pressing Enter at any prompt keeps the displayed default value.
 ``--mempool-type`` is the only mandatory entry.
+The pipeline mode prompt appears before the rand-factor prompt;
+if pipeline mode is selected, the rand-factor prompt is skipped.

 After configuration the tool prints an equivalent non-interactive command::

@@ -139,6 +156,36 @@ it does not include a put rate.
 With ``--summary``, only the ``Total`` row is printed.


+Pipeline Mode Output
+~~~~~~~~~~~~~~~~~~~~
+
+In pipeline mode the results table adds a ``role`` column:
+
+.. code-block:: console
+
+   lcore    role             Mops/s  fail/burst
+   ------   ----------  ----------  ----------
+   1        producer        23.871           0
+   3        producer        23.652           0
+   2        consumer        23.871           0
+   4        consumer        23.652           0
+   Total                    47.523           0
+
+role
+   ``producer`` or ``consumer``.
+
+Mops/s
+   For producers: objects successfully allocated and sent through the ring per second (Mops/s).
+   For consumers: objects dequeued, processed, and freed per second (Mops/s).
+
+fail/burst
+   For producers: number of allocation calls that failed because the pool was exhausted.
+   For consumers: always zero.
+
+The ``Total`` Mops/s is the consumer completion rate,
+representing the end-to-end pipeline throughput.
+
+
 Examples
 --------

@@ -171,3 +218,9 @@ Print only the aggregate total, suitable for scripted comparisons:
 .. code-block:: console

    dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -s
+
+Run in pipeline mode with 4 workers (2 producer/consumer pairs):
+
+.. code-block:: console
+
+   dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -p
--
2.53.0

