Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED93CA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 14:44:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 618AB40285;
	Sun,  4 Oct 2026 16:44:23 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [37.230.175.128])
 by mails.dpdk.org (Postfix) with ESMTP id AF9194027F;
 Sun,  4 Oct 2026 16:44:22 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:1199:0:640:2d84:0])
 by forward500b.mail.yandex.net (postfix) with ESMTPS id 22301C0D22;
 Sun, 04 Oct 2026 17:44:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id IiLE12ug4qM0-53XGA2Em; 
 Sun, 04 Oct 2026 17:44:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1791125060; bh=oyCeatylpZ7JISKElV61oAkHRxuQrHT9lF3reVm9OLQ=;
 h=From:Subject:In-Reply-To:Cc:Date:References:To:Message-ID;
 b=NazjJ29ckAc2PM3hPE4ZtgSnlNtqn/Sg/FLaYCki2xsZ1fkBokQZ5I8DPgvk1aM7Y
 6KTXuSncXMDMO8fBWS972NUuipAv68rEgcw/TiKYp9K6kFWiHfng9UCLp5TfrgTtTT
 j3a3KQTBlds+A2JSwUgZcv3+2oIi0XraumbwIUik=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <f38815f1-c637-44bb-86bb-98085021b41a@yandex.ru>
Date: Sun, 4 Oct 2026 15:44:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bruce.richardson@intel.com
Cc: dev@dpdk.org, techboard@dpdk.org
References: <20260820142439.3684311-4-bruce.richardson@intel.com>
Subject: Re: [RFC PATCH 3/3] app/test-mempool-perf: add testing in pipeline
 model
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <20260820142439.3684311-4-bruce.richardson@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> The characteristics of apps written as a pipelines differ significantly
> from apps written using a run-to-completion model, so add a mode to test
> those out too. If "--pipeline"/"-p" is specified, workers are divided
> into paired producers and consumers with rings between them and alloc
> and frees from mempool take place on different cores.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>   app/test-mempool-perf/main.c <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#Z31app:test-mempool-perf:main.c>      | 252 ++++++++++++++++++++++++++++--
>   app/test-mempool-perf/meson.build <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#Z31app:test-mempool-perf:meson.build> |   2 +-
>   doc/guides/tools/mempoolperf.rst <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#Z31doc:guides:tools:mempoolperf.rst>  |  55 ++++++-
>   3 files changed, 297 insertions(+), 12 deletions(-)
>
> diff 
> <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#iZ31app:test-mempool-perf:main.c> 
> --git a/app/test-mempool-perf/main.c b/app/test-mempool-perf/main.c 
> index 471631f3db..9f026dfb15 100644 --- a/app/test-mempool-perf/main.c 
> +++ b/app/test-mempool-perf/main.c @@ -17,6 +17,7 @@  #include <rte_mbuf.h>
>   #include <rte_mempool.h>
>   #include <rte_random.h>
> +#include <rte_ring.h>  #include <rte_string_fns.h>
>
>   #define DEFAULT_CACHE_SIZE          512
> @@ -28,6 +29,7 @@  #define ELEM_SIZE           (sizeof(struct rte_mbuf) + RTE_MBUF_DEFAULT_BUF_SIZE)
>   #define TEST_DURATION_SEC   5
>   #define RESHUFFLE_INTERVAL  100
> +#define PIPELINE_RING_SIZE 1024
>   struct test_config {
>   	char     mempool_type[RTE_MEMPOOL_NAMESIZE];
> @@ -37,6 +39,7 @@ struct test_config {  	uint32_t rand_factor;
>   	uint32_t burst_size;
>   	bool     access_on_alloc;
> + bool pipeline_mode;  };
>
>   static struct test_config cfg = {
> @@ -47,6 +50,7 @@ static struct test_config cfg = {  	.rand_factor    = DEFAULT_RAND_FACTOR,
>   	.burst_size     = DEFAULT_BURST_SIZE,
>   	.access_on_alloc = true,
> + .pipeline_mode = false,  };
>
>   static void
> @@ -94,16 +98,23 @@ print_config(void)  	printf("  Randomness factor: %" PRIu32 "\n", cfg.rand_factor);
>   	printf("  Burst size       : %" PRIu32 "\n", cfg.burst_size);
>   	printf("  Access on alloc  : %s\n", cfg.access_on_alloc ? "yes" : "no");
> + printf(" Pipeline mode : %s\n", cfg.pipeline_mode ? "yes" : "no");  	printf("========================================\n\n");
>   }
If it will be in UT, then pipleine/RTC modes from mutually exclusive 
might become
just two test-cases within the same test.
>   static void
>   print_reproduce_cmd(void)
>   {
> - printf("Reproduce using parameters:" - " -M %s -n %" PRIu32 " -c %" 
> PRIu32 " -t %" PRIu32 " -r %" PRIu32 " -b %" PRIu32 " %s\n\n", - 
> cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads, 
> cfg.rand_factor, - cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N"); 
> + if (cfg.pipeline_mode) + printf("Reproduce using parameters:" + " -M 
> %s -n %" PRIu32 " -c %" PRIu32 " -t %" PRIu32 " -b %" PRIu32 " %s 
> -p\n\n", + cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, 
> cfg.nb_threads, + cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N"); 
> + else + printf("Reproduce using parameters:" + " -M %s -n %" PRIu32 " 
> -c %" PRIu32 " -t %" PRIu32 " -r %" PRIu32 " -b %" PRIu32 " %s\n\n", + 
> cfg.mempool_type, cfg.nb_bufs, cfg.cache_size, cfg.nb_threads, + 
> cfg.rand_factor, cfg.burst_size, cfg.access_on_alloc ? "-A" : "-N");  }
>
>   static void
> @@ -189,11 +200,30 @@ run_interactive_mode(void)  	if (prompt_uint32(prompt, &cfg.nb_threads) < 0)
>   		return -1;
>
> - /* Randomness factor */ - snprintf(prompt, sizeof(prompt), - 
> "Randomness factor [%" PRIu32 "]: ", cfg.rand_factor); - if 
> (prompt_uint32(prompt, &cfg.rand_factor) < 0) - return -1; + /* 
> Pipeline mode */ + printf("Pipeline mode (producer/consumer pairs) 
> [%s]: ", + cfg.pipeline_mode ? "yes" : "no"); + fflush(stdout); + { + 
> char yn[16]; + + if (fgets(yn, sizeof(yn), stdin) == NULL) + return 
> -1; + trim_newline(yn); + if (yn[0] == 'y' || yn[0] == 'Y') + 
> cfg.pipeline_mode = true; + else if (yn[0] == 'n' || yn[0] == 'N') + 
> cfg.pipeline_mode = false; + /* else keep default */ + } + + /* 
> Randomness factor (not used in pipeline mode) */ + if 
> (!cfg.pipeline_mode) { + snprintf(prompt, sizeof(prompt), + 
> "Randomness factor [%" PRIu32 "]: ", cfg.rand_factor); + if 
> (prompt_uint32(prompt, &cfg.rand_factor) < 0) + return -1; + }
>   	/* Burst size */
>   	snprintf(prompt, sizeof(prompt),
> @@ -228,8 +258,14 @@ struct worker_stats {
>   static struct worker_stats lcore_stats[RTE_MAX_LCORE];
>   static bool summary_only;
> +static bool pipeline_producer[RTE_MAX_LCORE];  static RTE_ATOMIC(uint32_t) test_running;
>
> +struct pipeline_arg { + struct rte_mempool *mp; + struct rte_ring 
> *ring; +}; +  /*
>    * Shuffle delta[] (half +1, half -1) then rotate it so the running sum
>    * of held batches never goes negative.  Works by finding the last index
> @@ -355,6 +391,75 @@ worker_main(void *arg)  	return 0;
>   }
>
> +static int +producer_main(void *arg) +{ + struct pipeline_arg *parg = 
> arg; + struct rte_mempool *mp = parg->mp; + struct rte_ring *ring = 
> parg->ring; + unsigned int id = rte_lcore_id(); + struct worker_stats 
> *stats = &lcore_stats[id]; + uint32_t bs = cfg.burst_size; + uint32_t 
> i; + void **objs; + + objs = malloc(bs * sizeof(*objs)); + if (objs == 
> NULL) + return -ENOMEM; + + while 
> (rte_atomic_load_explicit(&test_running, rte_memory_order_relaxed)) { 
> + if (rte_mempool_get_bulk(mp, objs, bs) != 0) { + stats->get_fail++; 
> + continue; + } + for (i = 0; i < bs; i++) + access_object(objs[i]); + 
> /* spin until ring has space, or bail out if test ends */ + while 
> (rte_ring_enqueue_bulk(ring, objs, bs, NULL) == 0) { + rte_pause(); + 
> if (!rte_atomic_load_explicit(&test_running, 
> rte_memory_order_relaxed)) { + rte_mempool_put_bulk(mp, objs, bs); + 
> goto done; + } + } + stats->get_success += bs; + } +done: + 
> free(objs); + return 0; +} + +static int +consumer_main(void *arg) +{ 
> + struct pipeline_arg *parg = arg; + struct rte_mempool *mp = 
> parg->mp; + struct rte_ring *ring = parg->ring; + unsigned int id = 
> rte_lcore_id(); + struct worker_stats *stats = &lcore_stats[id]; + 
> uint32_t bs = cfg.burst_size; + uint32_t i; + void **objs; + + objs = 
> malloc(bs * sizeof(*objs)); + if (objs == NULL) + return -ENOMEM; + + 
> while (rte_atomic_load_explicit(&test_running, 
> rte_memory_order_relaxed)) { + if (rte_ring_dequeue_bulk(ring, objs, 
> bs, NULL) == 0) { + rte_pause(); + continue; + } + for (i = 0; i < bs; 
> i++) + access_object(objs[i]); + rte_mempool_put_bulk(mp, objs, bs); + 
> stats->get_success += bs; + stats->put_count += bs; + } + free(objs); 
> + return 0; +} +  static struct rte_mempool *
>   create_mempool(void)
>   {
> @@ -420,6 +525,46 @@ print_results(double elapsed_secs)  	       total_fail);
>   }
>
> +static void +print_pipeline_results(double elapsed_secs) +{ + 
> uint64_t total_cons = 0, total_fail = 0; + unsigned int id; + + 
> printf("\n%-8s %-10s %12s %12s\n", + "lcore", "role", "Mops/s", 
> "fail/burst"); + printf("%-8s %-10s %12s %12s\n", + "------", 
> "----------", "------------", "----------"); + + 
> RTE_LCORE_FOREACH_WORKER(id) { + if (lcore_stats[id].get_success == 0 
> && + lcore_stats[id].put_count == 0 && + lcore_stats[id].get_fail == 
> 0) + continue; + if (pipeline_producer[id]) { + if (!summary_only) + 
> printf("%-8u %-10s %12.3f %12" PRIu64 "\n", + id, "producer", + 
> lcore_stats[id].get_success / elapsed_secs / 1e6, + 
> lcore_stats[id].get_fail); + total_fail += lcore_stats[id].get_fail; + 
> } else { + if (!summary_only) + printf("%-8u %-10s %12.3f %12" PRIu64 
> "\n", + id, "consumer", + lcore_stats[id].put_count / elapsed_secs / 
> 1e6, + lcore_stats[id].get_fail); + total_cons += 
> lcore_stats[id].put_count; + } + } + + /* pipeline throughput = 
> consumer completion rate (the end-to-end bottleneck) */ + printf("%-8s 
> %-10s %12.3f %12" PRIu64 "\n\n", + "Total", "", + total_cons / 
> elapsed_secs / 1e6, + total_fail); +}
Personally, I think usual results format, will fit quite well for 
pipeline mode too.
As I understand, we would see something like that:

    lcore    get (Mops/s)  fail/burst  put (Mops/s)
    ------   ------------  ----------  ------------
    1              X           0           0
    2              0           0           X

...


> +  static void
>   run_test(struct rte_mempool *mp)
>   {
> @@ -451,6 +596,85 @@ run_test(struct rte_mempool *mp)  	print_results(elapsed_s);
>   }
>
> +static void +run_pipeline_test(struct rte_mempool *mp) +{ + unsigned 
> int worker_lcores[RTE_MAX_LCORE]; + char ring_name[RTE_RING_NAMESIZE]; 
> + struct pipeline_arg *pargs; + struct rte_ring **rings; + void 
> *drain[64]; + uint64_t start, end; + uint32_t nb_workers = 0; + 
> uint32_t nb_pairs; + uint32_t n, i; + unsigned int id; + + 
> RTE_LCORE_FOREACH_WORKER(id) { + if (nb_workers >= cfg.nb_threads) + 
> break; + worker_lcores[nb_workers++] = id; + } + + nb_pairs = 
> nb_workers / 2; + if (nb_pairs == 0) + rte_exit(EXIT_FAILURE, + 
> "Pipeline mode needs at least 2 worker lcores\n"); + + pargs = 
> malloc(nb_pairs * sizeof(*pargs)); + rings = malloc(nb_pairs * 
> sizeof(*rings)); + if (pargs == NULL || rings == NULL) + 
> rte_exit(EXIT_FAILURE, "Failed to allocate pipeline resources\n"); + + 
> for (i = 0; i < nb_pairs; i++) { + snprintf(ring_name, 
> sizeof(ring_name), "pipe_ring_%u", i); + rings[i] = 
> rte_ring_create(ring_name, PIPELINE_RING_SIZE, + rte_socket_id(), + 
> RING_F_SP_ENQ | RING_F_SC_DEQ); + if (rings[i] == NULL) + 
> rte_exit(EXIT_FAILURE, + "Failed to create pipeline ring %u: %s\n", + 
> i, rte_strerror(rte_errno)); + pargs[i].mp = mp; + pargs[i].ring = 
> rings[i]; + } + + memset(lcore_stats, 0, sizeof(lcore_stats)); + 
> memset(pipeline_producer, 0, sizeof(pipeline_producer)); + 
> rte_atomic_store_explicit(&test_running, 1, rte_memory_order_release); 
> + + for (i = 0; i < nb_pairs; i++) { + id = worker_lcores[i]; + 
> pipeline_producer[id] = true; + rte_eal_remote_launch(producer_main, 
> &pargs[i], id); + } + for (i = 0; i < nb_pairs; i++) { + id = 
> worker_lcores[nb_pairs + i]; + rte_eal_remote_launch(consumer_main, 
> &pargs[i], id); + } + + printf("Pipeline test: %" PRIu32 " 
> producer/consumer pair(s), " + "%d seconds...\n", nb_pairs, 
> TEST_DURATION_SEC); + + start = rte_get_timer_cycles(); + 
> rte_delay_ms((uint32_t)(TEST_DURATION_SEC * 1000)); + 
> rte_atomic_store_explicit(&test_running, 0, rte_memory_order_release); 
> + end = rte_get_timer_cycles(); + rte_eal_mp_wait_lcore(); + + /* 
> drain objects left in rings after workers exit, then release rings */ 
> + for (i = 0; i < nb_pairs; i++) { + while ((n = 
> rte_ring_dequeue_burst(rings[i], drain, RTE_DIM(drain), NULL)) > 0) + 
> rte_mempool_put_bulk(mp, drain, n); + rte_ring_free(rings[i]); + } + + 
> print_pipeline_results((double)(end - start) / rte_get_timer_hz()); + 
> + free(pargs); + free(rings); +} +  /* receives the --mempool-type string from argparse */
>   static const char *mempool_type_arg;
>
> @@ -508,6 +732,11 @@ parse_args(int argc, char **argv)  			  (void *)&summary_only, (void *)true,
>   			  RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL,
>   			},
> + { "--pipeline", "-p", + "Pipeline mode: pair threads as producers 
> and consumers connected by rings", + (void *)&cfg.pipeline_mode, (void 
> *)true, + RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_BOOL, + },  			ARGPARSE_ARG_END(),
>   		},
>   	};
> @@ -568,7 +797,10 @@ main(int argc, char **argv)  	if (mp == NULL)
>   		rte_exit(EXIT_FAILURE, "Failed to create mempool\n");
>
> - run_test(mp); + if (cfg.pipeline_mode) + run_pipeline_test(mp); + 
> else + run_test(mp);
>   	rte_mempool_free(mp);
>   	rte_eal_cleanup();
> diff 
> <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#iZ31app:test-mempool-perf:meson.build> 
> --git a/app/test-mempool-perf/meson.build 
> b/app/test-mempool-perf/meson.build index 37c6c14d56..2410f497a9 
> 100644 --- a/app/test-mempool-perf/meson.build +++ 
> b/app/test-mempool-perf/meson.build @@ -1,7 +1,7 @@  # SPDX-License-Identifier: BSD-3-Clause
>   # Copyright(c) 2024 Intel Corporation
>
> -deps += ['mbuf', 'mempool', 'argparse'] +deps += ['mbuf', 'mempool', 
> 'argparse', 'ring']
>   sources = files(
>           'main.c',
> diff 
> <https://inbox.dpdk.org/dev/20260820142439.3684311-4-bruce.richardson@intel.com/#iZ31doc:guides:tools:mempoolperf.rst> 
> --git a/doc/guides/tools/mempoolperf.rst 
> b/doc/guides/tools/mempoolperf.rst index 31bd6e660e..d5e8def7db 100644 
> --- a/doc/guides/tools/mempoolperf.rst +++ 
> b/doc/guides/tools/mempoolperf.rst @@ -5,8 +5,11 @@ 
> dpdk-test-mempool-perf Application  ====================================
>
>   The ``dpdk-test-mempool-perf`` tool measures the alloc/free throughput of DPDK mempool implementations.
> -Worker threads repeatedly allocate and free objects in configurable 
> burst sizes following a randomised pattern, +In the default 
> run-to-completion mode, +worker threads repeatedly allocate and free 
> objects in configurable burst sizes following a randomised pattern,  exercising the pool under varying levels of occupancy.
> +An optional pipeline mode pairs threads as producers and consumers 
> connected by rings, +modelling multi-stage packet processing pipelines.  Any mempool driver registered with the DPDK mempool ops table can be tested.
>   Pool elements are sized to match ``rte_pktmbuf_pool_create()`` with default data room.
>
> @@ -67,6 +70,7 @@ Application Options     A larger value means workers hold more in-flight objects on average
>      and vary their occupancy over a wider range,
>      exercising the pool under a more realistic mix of pressure levels.
> + Not used in pipeline mode (``--pipeline``).
>   ``--burst-size <n>`` / ``-b <n>``
>      Number of objects per alloc or free call.
> @@ -87,6 +91,17 @@ Application Options     Print only the aggregate total in the results, suppressing the per-worker-lcore breakdown.
>      Useful when scripting comparisons across pool types or configurations.
>
> +``--pipeline`` / ``-p`` + Enable pipeline mode. + Worker lcores are 
> paired as producers and consumers. + Each producer allocates a burst 
> of objects, writes to them, + and enqueues it to a ring shared with 
> its paired consumer. + The consumer dequeues the burst, reads and 
> writes the objects, then frees them to the pool. + This models a 
> pipeline application where objects traverse processing stages on 
> different cores, + in contrast to run-to-completion mode where each 
> core handles the full object lifecycle. + ``--rand-factor`` is not 
> applicable in this mode. + The thread count must be at least 2; if 
> ``--nb-threads`` is odd, the last lcore is unused. +
>   Interactive Mode
>   ----------------
> @@ -98,6 +113,8 @@ Running the tool with only EAL options enters 
> interactive mode::  The application lists all available mempool drivers then prompts for each parameter.
>   Pressing Enter at any prompt keeps the displayed default value.
>   ``--mempool-type`` is the only mandatory entry.
> +The pipeline mode prompt appears before the rand-factor prompt; +if 
> pipeline mode is selected, the rand-factor prompt is skipped.
>   After configuration the tool prints an equivalent non-interactive command::
>
> @@ -139,6 +156,36 @@ it does not include a put rate.  With ``--summary``, only the ``Total`` row is printed.
>
>
> +Pipeline Mode Output +~~~~~~~~~~~~~~~~~~~~ + +In pipeline mode the 
> results table adds a ``role`` column: + +.. code-block:: console + + 
> lcore role Mops/s fail/burst + ------ ---------- ---------- ---------- 
> + 1 producer 23.871 0 + 3 producer 23.652 0 + 2 consumer 23.871 0 + 4 
> consumer 23.652 0 + Total 47.523 0 + +role + ``producer`` or 
> ``consumer``. + +Mops/s + For producers: objects successfully 
> allocated and sent through the ring per second (Mops/s). + For 
> consumers: objects dequeued, processed, and freed per second (Mops/s). 
> + +fail/burst + For producers: number of allocation calls that failed 
> because the pool was exhausted. + For consumers: always zero. + +The 
> ``Total`` Mops/s is the consumer completion rate, +representing the 
> end-to-end pipeline throughput. + +  Examples
>   --------
>
> @@ -171,3 +218,9 @@ Print only the aggregate total, suitable for 
> scripted comparisons:  .. code-block:: console
>
>      dpdk-test-mempool-perf -l 0-4 -- -M ring_mp_mc -s
> + +Run in pipeline mode with 4 workers (2 producer/consumer pairs): + 
> +.. code-block:: console + + dpdk-test-mempool-perf -l 0-4 -- -M 
> ring_mp_mc -p -- 2.53.0
