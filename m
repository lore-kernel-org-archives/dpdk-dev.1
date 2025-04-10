Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A7CC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 18:01:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80C7A40A77;
	Thu, 10 Apr 2025 20:01:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 530D540A80
 for <dev@dpdk.org>; Thu, 10 Apr 2025 20:01:25 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8BKNH030927;
 Thu, 10 Apr 2025 11:01:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 IbwGiGkztlOxrSODOlNFUxcwRxrv+dvoDx+A8Bjo8I=; b=Np1lNtFRual3ColUh
 5hwda57ufMaPnaGoVuPN82kJCBZlmEuZ5dSGuUXQ9YJdvjBoZwTAmMCHCcFUDqrb
 okaea6GkN0Rb9HXGfNcMlsowZn5yzu9xYdktSYZTUthZt8+djsgZvqRwNDyTwU4X
 F8KgAYM3UpMP2zPGv3EMmng2QJvSTsPvpB4ZFbMF8aEBMQK+k8fnx/KBKUmjOyhh
 H7cXJyfJVmHEZdFA1fVIhyWaYQz+5jLBrSS4GUqtoFPYFW2b2W+yDokPza4fDfRS
 Z0Ml9G878ygbM2D81LWxqJK/7qNa2BB8mAD2TTwMzy4ReQTAllzLmMaLNtt87Kai
 cnp9Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45unnb3eg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 11:01:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Apr 2025 11:01:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Apr 2025 11:01:22 -0700
Received: from MININT-80QBFE8.corp.innovium.com (unknown [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id D7C213F708A;
 Thu, 10 Apr 2025 11:01:17 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, <pravin.pathak@intel.com>, <hemant.agrawal@nxp.com>, 
 <sachin.saxena@nxp.com>, <mattias.ronnblom@ericsson.com>,
 <liangma@liangbit.com>, <peter.mccarthy@intel.com>,
 <harry.van.haaren@intel.com>, <erik.g.carrillo@intel.com>,
 <abhinandan.gujjar@intel.com>, <amitprakashs@marvell.com>,
 <s.v.naga.harish.k@intel.com>, <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 3/3] app/eventdev: add vector adapter performance test
Date: Thu, 10 Apr 2025 23:30:41 +0530
Message-ID: <20250410180056.10368-4-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410180056.10368-1-pbhagavatula@marvell.com>
References: <20250326131441.5965-2-pbhagavatula@marvell.com>
 <20250410180056.10368-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QiE3MsFrfS1j3K36sbhcwdFtinTup_pP
X-Authority-Analysis: v=2.4 cv=E57Npbdl c=1 sm=1 tr=0 ts=67f80774 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=Z-f73vtj0jMIOVENMMQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: QiE3MsFrfS1j3K36sbhcwdFtinTup_pP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Add performance test for event vector adapter.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test-eventdev/evt_common.h         |   9 +-
 app/test-eventdev/evt_options.c        |  14 ++
 app/test-eventdev/evt_options.h        |   1 +
 app/test-eventdev/test_perf_atq.c      |  61 +++++-
 app/test-eventdev/test_perf_common.c   | 281 ++++++++++++++++++-------
 app/test-eventdev/test_perf_common.h   |  13 +-
 app/test-eventdev/test_perf_queue.c    |  66 +++++-
 doc/guides/rel_notes/release_25_07.rst |   5 +
 doc/guides/tools/testeventdev.rst      |   6 +
 9 files changed, 362 insertions(+), 94 deletions(-)

diff --git a/app/test-eventdev/evt_common.h b/app/test-eventdev/evt_common.h
index 74f9d187f3..ec824f2454 100644
--- a/app/test-eventdev/evt_common.h
+++ b/app/test-eventdev/evt_common.h
@@ -39,11 +39,12 @@
 
 enum evt_prod_type {
 	EVT_PROD_TYPE_NONE,
-	EVT_PROD_TYPE_SYNT,          /* Producer type Synthetic i.e. CPU. */
-	EVT_PROD_TYPE_ETH_RX_ADPTR,  /* Producer type Eth Rx Adapter. */
+	EVT_PROD_TYPE_SYNT,		  /* Producer type Synthetic i.e. CPU. */
+	EVT_PROD_TYPE_ETH_RX_ADPTR,	  /* Producer type Eth Rx Adapter. */
 	EVT_PROD_TYPE_EVENT_TIMER_ADPTR,  /* Producer type Timer Adapter. */
-	EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR,  /* Producer type Crypto Adapter. */
-	EVT_PROD_TYPE_EVENT_DMA_ADPTR,  /* Producer type DMA Adapter. */
+	EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR, /* Producer type Crypto Adapter. */
+	EVT_PROD_TYPE_EVENT_DMA_ADPTR,	  /* Producer type DMA Adapter. */
+	EVT_PROD_TYPE_EVENT_VECTOR_ADPTR, /* Producer type Vector adapter. */
 	EVT_PROD_TYPE_MAX,
 };
 
diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 323d1e724d..0e70c971eb 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -186,6 +186,13 @@ evt_parse_dma_adptr_mode(struct evt_options *opt, const char *arg)
 	return ret;
 }
 
+static int
+evt_parse_vector_prod_type(struct evt_options *opt,
+			   const char *arg __rte_unused)
+{
+	opt->prod_type = EVT_PROD_TYPE_EVENT_VECTOR_ADPTR;
+	return 0;
+}
 
 static int
 evt_parse_crypto_prod_type(struct evt_options *opt,
@@ -494,6 +501,7 @@ usage(char *program)
 		"\t                     in ns.\n"
 		"\t--prod_type_timerdev_burst : use timer device as producer\n"
 		"\t                             burst mode.\n"
+		"\t--prod_type_vector : use vector adapter as producer.\n"
 		"\t--nb_timers        : number of timers to arm.\n"
 		"\t--nb_timer_adptrs  : number of timer adapters to use.\n"
 		"\t--timer_tick_nsec  : timer tick interval in ns.\n"
@@ -591,6 +599,7 @@ static struct option lgopts[] = {
 	{ EVT_PROD_CRYPTODEV,      0, 0, 0 },
 	{ EVT_PROD_TIMERDEV,       0, 0, 0 },
 	{ EVT_PROD_TIMERDEV_BURST, 0, 0, 0 },
+	{ EVT_PROD_VECTOR,         0, 0, 0 },
 	{ EVT_DMA_ADPTR_MODE,      1, 0, 0 },
 	{ EVT_CRYPTO_ADPTR_MODE,   1, 0, 0 },
 	{ EVT_CRYPTO_OP_TYPE,	   1, 0, 0 },
@@ -642,6 +651,7 @@ evt_opts_parse_long(int opt_idx, struct evt_options *opt)
 		{ EVT_PROD_DMADEV, evt_parse_dma_prod_type},
 		{ EVT_PROD_TIMERDEV, evt_parse_timer_prod_type},
 		{ EVT_PROD_TIMERDEV_BURST, evt_parse_timer_prod_type_burst},
+		{ EVT_PROD_VECTOR, evt_parse_vector_prod_type },
 		{ EVT_DMA_ADPTR_MODE, evt_parse_dma_adptr_mode},
 		{ EVT_CRYPTO_ADPTR_MODE, evt_parse_crypto_adptr_mode},
 		{ EVT_CRYPTO_OP_TYPE, evt_parse_crypto_op_type},
@@ -721,4 +731,8 @@ evt_options_dump(struct evt_options *opt)
 	evt_dump_end;
 	evt_dump_nb_flows(opt);
 	evt_dump_worker_dequeue_depth(opt);
+	if (opt->ena_vector || opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
+		evt_dump("vector_sz", "%d", opt->vector_size);
+		evt_dump("vector_tmo_ns", "%"PRIu64, opt->vector_tmo_nsec);
+	}
 }
diff --git a/app/test-eventdev/evt_options.h b/app/test-eventdev/evt_options.h
index 18a893b704..4bf712bd19 100644
--- a/app/test-eventdev/evt_options.h
+++ b/app/test-eventdev/evt_options.h
@@ -38,6 +38,7 @@
 #define EVT_PROD_DMADEV          ("prod_type_dmadev")
 #define EVT_PROD_TIMERDEV        ("prod_type_timerdev")
 #define EVT_PROD_TIMERDEV_BURST  ("prod_type_timerdev_burst")
+#define EVT_PROD_VECTOR          ("prod_type_vector")
 #define EVT_DMA_ADPTR_MODE       ("dma_adptr_mode")
 #define EVT_CRYPTO_ADPTR_MODE	 ("crypto_adptr_mode")
 #define EVT_CRYPTO_OP_TYPE	 ("crypto_op_type")
diff --git a/app/test-eventdev/test_perf_atq.c b/app/test-eventdev/test_perf_atq.c
index 30c34edabd..b07b010af1 100644
--- a/app/test-eventdev/test_perf_atq.c
+++ b/app/test-eventdev/test_perf_atq.c
@@ -145,7 +145,7 @@ perf_atq_worker_burst(void *arg, const int enable_fwd_latency)
 }
 
 static int
-perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
+perf_atq_worker_crypto_vector(void *arg, const int enable_fwd_latency)
 {
 	uint16_t enq = 0, deq = 0;
 	struct rte_event ev;
@@ -161,10 +161,8 @@ perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
 		if (!deq)
 			continue;
 
-		if (ev.event_type == RTE_EVENT_TYPE_CRYPTODEV_VECTOR) {
-			if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_latency))
-				continue;
-		}
+		if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_latency))
+			continue;
 
 		stage = ev.sub_event_type % nb_stages;
 		/* First q in pipeline, mark timestamp to compute fwd latency */
@@ -173,8 +171,8 @@ perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
 
 		/* Last stage in pipeline */
 		if (unlikely(stage == laststage)) {
-			perf_process_vector_last_stage(pool, t->ca_op_pool, &ev, w,
-							enable_fwd_latency);
+			perf_process_crypto_vector_last_stage(pool, t->ca_op_pool, &ev, w,
+							      enable_fwd_latency);
 		} else {
 			atq_fwd_event_vector(&ev, sched_type_list, nb_stages);
 			do {
@@ -188,6 +186,53 @@ perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
 	return 0;
 }
 
+static int
+perf_atq_worker_vector(void *arg, const int enable_fwd_latency)
+{
+	uint16_t enq = 0, deq = 0;
+	struct rte_event ev;
+	PERF_WORKER_INIT;
+
+	RTE_SET_USED(sz);
+	RTE_SET_USED(pe);
+	RTE_SET_USED(cnt);
+	RTE_SET_USED(prod_type);
+	RTE_SET_USED(prod_timer_type);
+
+	while (t->done == false) {
+		deq = rte_event_dequeue_burst(dev, port, &ev, 1, 0);
+		if (!deq)
+			continue;
+
+		if (ev.event_type != RTE_EVENT_TYPE_CPU_VECTOR) {
+			w->processed_pkts++;
+			continue;
+		}
+
+		stage = ev.sub_event_type % nb_stages;
+		if (enable_fwd_latency && stage == 0)
+			/* first stage in pipeline, mark ts to compute fwd latency */
+			ev.vec->u64s[0] = rte_get_timer_cycles();
+
+		/* Last stage in pipeline */
+		if (unlikely(stage == laststage)) {
+			w->processed_vecs++;
+			if (enable_fwd_latency)
+				w->latency += rte_get_timer_cycles() - ev.vec->u64s[0];
+
+			rte_mempool_put(pool, ev.event_ptr);
+		} else {
+			atq_fwd_event_vector(&ev, sched_type_list, nb_stages);
+			do {
+				enq = rte_event_enqueue_burst(dev, port, &ev, 1);
+			} while (!enq && !t->done);
+		}
+	}
+	perf_worker_cleanup(pool, dev, port, &ev, enq, deq);
+
+	return 0;
+}
+
 static int
 worker_wrapper(void *arg)
 {
@@ -199,6 +244,8 @@ worker_wrapper(void *arg)
 
 	/* allow compiler to optimize */
 	if (opt->ena_vector && opt->prod_type == EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR)
+		return perf_atq_worker_crypto_vector(arg, fwd_latency);
+	else if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR)
 		return perf_atq_worker_vector(arg, fwd_latency);
 	else if (!burst && !fwd_latency)
 		return perf_atq_worker(arg, 0);
diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index 627f07caa1..4709de8b07 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -102,16 +102,20 @@ perf_test_result(struct evt_test *test, struct evt_options *opt)
 	int i;
 	uint64_t total = 0;
 	struct test_perf *t = evt_test_priv(test);
+	uint8_t is_vec;
 
 	printf("Packet distribution across worker cores :\n");
+	is_vec = (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR);
 	for (i = 0; i < t->nb_workers; i++)
-		total += t->worker[i].processed_pkts;
+		total += is_vec ? t->worker[i].processed_vecs : t->worker[i].processed_pkts;
 	for (i = 0; i < t->nb_workers; i++)
-		printf("Worker %d packets: "CLGRN"%"PRIx64" "CLNRM"percentage:"
-				CLGRN" %3.2f"CLNRM"\n", i,
-				t->worker[i].processed_pkts,
-				(((double)t->worker[i].processed_pkts)/total)
-				* 100);
+		printf("Worker %d packets: " CLGRN "%" PRIx64 " " CLNRM "percentage:" CLGRN
+		       " %3.2f" CLNRM "\n",
+		       i, is_vec ? t->worker[i].processed_vecs : t->worker[i].processed_pkts,
+		       (((double)(is_vec ? t->worker[i].processed_vecs :
+					   t->worker[i].processed_pkts)) /
+			total) *
+			       100);
 
 	return t->result;
 }
@@ -887,6 +891,31 @@ perf_event_crypto_producer_burst(void *arg)
 	return 0;
 }
 
+static int
+perf_event_vector_producer(struct prod_data *p)
+{
+	struct rte_event_vector_adapter *adptr = p->va.vector_adptr;
+	struct evt_options *opt = p->t->opt;
+	const struct test_perf *t = p->t;
+	uint64_t objs[BURST_SIZE];
+	uint16_t enq;
+
+	if (opt->verbose_level > 1)
+		printf("%s(): lcore %d vector adapter %p\n", __func__, rte_lcore_id(), adptr);
+
+	while (t->done == false) {
+		enq = rte_event_vector_adapter_enqueue(adptr, objs, BURST_SIZE, 0);
+		while (enq < BURST_SIZE) {
+			enq += rte_event_vector_adapter_enqueue(adptr, objs + enq, BURST_SIZE - enq,
+								0);
+			if (t->done)
+				break;
+			rte_pause();
+		}
+	}
+	return 0;
+}
+
 static int
 perf_producer_wrapper(void *arg)
 {
@@ -930,6 +959,8 @@ perf_producer_wrapper(void *arg)
 			return perf_event_crypto_producer(arg);
 	} else if (t->opt->prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR)
 		return perf_event_dma_producer(arg);
+	else if (t->opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR)
+		return perf_event_vector_producer(p);
 
 	return 0;
 }
@@ -947,115 +978,103 @@ processed_pkts(struct test_perf *t)
 }
 
 static inline uint64_t
-total_latency(struct test_perf *t)
+processed_vecs(struct test_perf *t)
 {
 	uint8_t i;
 	uint64_t total = 0;
 
 	for (i = 0; i < t->nb_workers; i++)
-		total += t->worker[i].latency;
+		total += t->worker[i].processed_vecs;
 
 	return total;
 }
 
-
-int
-perf_launch_lcores(struct evt_test *test, struct evt_options *opt,
-		int (*worker)(void *))
+static inline uint64_t
+total_latency(struct test_perf *t)
 {
-	int ret, lcore_id;
-	struct test_perf *t = evt_test_priv(test);
-
-	int port_idx = 0;
-	/* launch workers */
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (!(opt->wlcores[lcore_id]))
-			continue;
-
-		ret = rte_eal_remote_launch(worker,
-				 &t->worker[port_idx], lcore_id);
-		if (ret) {
-			evt_err("failed to launch worker %d", lcore_id);
-			return ret;
-		}
-		port_idx++;
-	}
-
-	/* launch producers */
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (!(opt->plcores[lcore_id]))
-			continue;
+	uint8_t i;
+	uint64_t total = 0;
 
-		ret = rte_eal_remote_launch(perf_producer_wrapper,
-				&t->prod[port_idx], lcore_id);
-		if (ret) {
-			evt_err("failed to launch perf_producer %d", lcore_id);
-			return ret;
-		}
-		port_idx++;
-	}
+	for (i = 0; i < t->nb_workers; i++)
+		total += t->worker[i].latency;
 
-	const uint64_t total_pkts = t->outstand_pkts;
+	return total;
+}
 
-	uint64_t dead_lock_cycles = rte_get_timer_cycles();
-	int64_t dead_lock_remaining  =  total_pkts;
+static void
+check_work_status(struct test_perf *t, struct evt_options *opt)
+{
 	const uint64_t dead_lock_sample = rte_get_timer_hz() * 5;
-
+	const uint64_t freq_mhz = rte_get_timer_hz() / 1000000;
+	uint64_t dead_lock_cycles = rte_get_timer_cycles();
+	const uint64_t perf_sample = rte_get_timer_hz();
 	uint64_t perf_cycles = rte_get_timer_cycles();
+	const uint64_t total_pkts = t->outstand_pkts;
+	int64_t dead_lock_remaining = total_pkts;
 	int64_t perf_remaining  = total_pkts;
-	const uint64_t perf_sample = rte_get_timer_hz();
-
-	static float total_mpps;
 	static uint64_t samples;
+	static float total_mpps;
+	int64_t remaining;
+	uint8_t is_vec;
 
-	const uint64_t freq_mhz = rte_get_timer_hz() / 1000000;
-	int64_t remaining = t->outstand_pkts - processed_pkts(t);
+	is_vec = (t->opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR);
+	remaining = t->outstand_pkts - (is_vec ? processed_vecs(t) : processed_pkts(t));
 
 	while (t->done == false) {
 		const uint64_t new_cycles = rte_get_timer_cycles();
 
 		if ((new_cycles - perf_cycles) > perf_sample) {
 			const uint64_t latency = total_latency(t);
-			const uint64_t pkts = processed_pkts(t);
+			const uint64_t pkts = is_vec ? processed_vecs(t) : processed_pkts(t);
+			uint64_t fallback_pkts = processed_pkts(t);
 
 			remaining = t->outstand_pkts - pkts;
-			float mpps = (float)(perf_remaining-remaining)/1000000;
+			float mpps = (float)(perf_remaining - remaining) / 1E6;
 
 			perf_remaining = remaining;
 			perf_cycles = new_cycles;
 			total_mpps += mpps;
 			++samples;
+
 			if (opt->fwd_latency && pkts > 0) {
-				printf(CLGRN"\r%.3f mpps avg %.3f mpps [avg fwd latency %.3f us] "CLNRM,
-					mpps, total_mpps/samples,
-					(float)(latency/pkts)/freq_mhz);
+				if (is_vec) {
+					printf(CLGRN
+					       "\r%.3f mvps avg %.3f mvps [avg fwd latency %.3f us] "
+					       "fallback mpps %.3f" CLNRM,
+					       mpps, total_mpps / samples,
+					       (float)(latency / pkts) / freq_mhz,
+					       fallback_pkts / 1E6);
+				} else {
+					printf(CLGRN
+					       "\r%.3f mpps avg %.3f mpps [avg fwd latency %.3f us] "
+					       CLNRM,
+					       mpps, total_mpps / samples,
+					       (float)(latency / pkts) / freq_mhz);
+				}
 			} else {
-				printf(CLGRN"\r%.3f mpps avg %.3f mpps"CLNRM,
-					mpps, total_mpps/samples);
+				if (is_vec) {
+					printf(CLGRN
+					       "\r%.3f mvps avg %.3f mvps fallback mpps %.3f" CLNRM,
+					       mpps, total_mpps / samples, fallback_pkts / 1E6);
+				} else {
+					printf(CLGRN "\r%.3f mpps avg %.3f mpps" CLNRM, mpps,
+					       total_mpps / samples);
+				}
 			}
 			fflush(stdout);
 
 			if (remaining <= 0) {
 				t->result = EVT_TEST_SUCCESS;
-				if (opt->prod_type == EVT_PROD_TYPE_SYNT ||
-				    opt->prod_type ==
-					    EVT_PROD_TYPE_EVENT_TIMER_ADPTR ||
-				    opt->prod_type ==
-					    EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR ||
-				    opt->prod_type ==
-					    EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
+				if (opt->prod_type != EVT_PROD_TYPE_ETH_RX_ADPTR) {
 					t->done = true;
 					break;
 				}
 			}
 		}
-
 		if (new_cycles - dead_lock_cycles > dead_lock_sample &&
-		    (opt->prod_type == EVT_PROD_TYPE_SYNT ||
-		     opt->prod_type == EVT_PROD_TYPE_EVENT_TIMER_ADPTR ||
-		     opt->prod_type == EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR ||
-		     opt->prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR)) {
-			remaining = t->outstand_pkts - processed_pkts(t);
+		    (opt->prod_type != EVT_PROD_TYPE_ETH_RX_ADPTR)) {
+			remaining =
+				t->outstand_pkts - (is_vec ? processed_vecs(t) : processed_pkts(t));
 			if (dead_lock_remaining == remaining) {
 				rte_event_dev_dump(opt->dev_id, stdout);
 				evt_err("No schedules for seconds, deadlock");
@@ -1067,6 +1086,45 @@ perf_launch_lcores(struct evt_test *test, struct evt_options *opt,
 		}
 	}
 	printf("\n");
+}
+
+int
+perf_launch_lcores(struct evt_test *test, struct evt_options *opt, int (*worker)(void *))
+{
+	int ret, lcore_id;
+	struct test_perf *t = evt_test_priv(test);
+
+	int port_idx = 0;
+	/* launch workers */
+	RTE_LCORE_FOREACH_WORKER(lcore_id)
+	{
+		if (!(opt->wlcores[lcore_id]))
+			continue;
+
+		ret = rte_eal_remote_launch(worker, &t->worker[port_idx], lcore_id);
+		if (ret) {
+			evt_err("failed to launch worker %d", lcore_id);
+			return ret;
+		}
+		port_idx++;
+	}
+
+	/* launch producers */
+	RTE_LCORE_FOREACH_WORKER(lcore_id)
+	{
+		if (!(opt->plcores[lcore_id]))
+			continue;
+
+		ret = rte_eal_remote_launch(perf_producer_wrapper, &t->prod[port_idx], lcore_id);
+		if (ret) {
+			evt_err("failed to launch perf_producer %d", lcore_id);
+			return ret;
+		}
+		port_idx++;
+	}
+
+	check_work_status(t, opt);
+
 	return 0;
 }
 
@@ -1564,6 +1622,70 @@ perf_event_dev_port_setup(struct evt_test *test, struct evt_options *opt,
 
 			prod++;
 		}
+	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
+		struct rte_event_vector_adapter_conf conf;
+		struct rte_event_vector_adapter_info info;
+
+		ret = rte_event_vector_adapter_info_get(opt->dev_id, &info);
+
+		if (opt->vector_size < info.min_vector_sz ||
+		    opt->vector_size > info.max_vector_sz) {
+			evt_err("Vector size [%d] not within limits max[%d] min[%d]",
+				opt->vector_size, info.max_vector_sz, info.min_vector_sz);
+			return -EINVAL;
+		}
+
+		if (opt->vector_tmo_nsec > info.max_vector_timeout_ns ||
+		    opt->vector_tmo_nsec < info.min_vector_timeout_ns) {
+			evt_err("Vector timeout [%" PRIu64 "] not within limits "
+				"max[%" PRIu64 "] min[%" PRIu64 "]",
+				opt->vector_tmo_nsec, info.max_vector_timeout_ns,
+				info.min_vector_timeout_ns);
+			return -EINVAL;
+		}
+
+		memset(&conf, 0, sizeof(struct rte_event_vector_adapter_conf));
+		conf.event_dev_id = opt->dev_id;
+		conf.vector_sz = opt->vector_size;
+		conf.vector_timeout_ns = opt->vector_tmo_nsec;
+		conf.socket_id = opt->socket_id;
+		conf.vector_mp = t->pool;
+
+		conf.ev.sched_type = opt->sched_type_list[0];
+		conf.ev.event_type = RTE_EVENT_TYPE_VECTOR | RTE_EVENT_TYPE_CPU;
+
+		conf.ev_fallback.event_type = RTE_EVENT_TYPE_CPU;
+
+		prod = 0;
+		for (; port < perf_nb_event_ports(opt); port++) {
+			struct rte_event_vector_adapter *vector_adptr;
+			struct prod_data *p = &t->prod[port];
+			uint32_t service_id;
+
+			p->queue_id = prod * stride;
+			p->t = t;
+
+			conf.ev.queue_id = p->queue_id;
+
+			vector_adptr = rte_event_vector_adapter_create(&conf);
+			if (vector_adptr == NULL) {
+				evt_err("Failed to create vector adapter for port %d", port);
+				return -ENOMEM;
+			}
+			p->va.vector_adptr = vector_adptr;
+			prod++;
+
+			if (rte_event_vector_adapter_service_id_get(vector_adptr, &service_id) ==
+			    0) {
+				ret = evt_service_setup(service_id);
+				if (ret) {
+					evt_err("Failed to setup service core"
+						" for vector adapter\n");
+					return ret;
+				}
+				rte_service_runstate_set(service_id, 1);
+			}
+		}
 	} else {
 		prod = 0;
 		for ( ; port < perf_nb_event_ports(opt); port++) {
@@ -1728,6 +1850,20 @@ perf_eventdev_destroy(struct evt_test *test, struct evt_options *opt)
 		for (i = 0; i < opt->nb_timer_adptrs; i++)
 			rte_event_timer_adapter_stop(t->timer_adptr[i]);
 	}
+
+	if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
+		for (i = 0; i < evt_nr_active_lcores(opt->plcores); i++) {
+			struct prod_data *p = &t->prod[i];
+			uint32_t service_id;
+
+			if (p->va.vector_adptr) {
+				if (rte_event_vector_adapter_service_id_get(p->va.vector_adptr,
+									    &service_id) == 0)
+					rte_service_runstate_set(service_id, 0);
+				rte_event_vector_adapter_destroy(p->va.vector_adptr);
+			}
+		}
+	}
 	rte_event_dev_stop(opt->dev_id);
 	rte_event_dev_close(opt->dev_id);
 }
@@ -2119,6 +2255,9 @@ perf_mempool_setup(struct evt_test *test, struct evt_options *opt)
 					     cache_sz,		       /* cache size*/
 					     0, NULL, NULL, NULL,      /* obj constructor */
 					     NULL, opt->socket_id, 0); /* flags */
+	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
+		t->pool = rte_event_vector_pool_create(test->name, opt->pool_sz, cache_sz,
+						       opt->vector_size, opt->socket_id);
 	} else {
 		t->pool = rte_pktmbuf_pool_create(test->name, /* mempool name */
 				opt->pool_sz, /* number of elements*/
diff --git a/app/test-eventdev/test_perf_common.h b/app/test-eventdev/test_perf_common.h
index d7333ad390..99df008cc7 100644
--- a/app/test-eventdev/test_perf_common.h
+++ b/app/test-eventdev/test_perf_common.h
@@ -16,6 +16,7 @@
 #include <rte_event_eth_rx_adapter.h>
 #include <rte_event_eth_tx_adapter.h>
 #include <rte_event_timer_adapter.h>
+#include <rte_event_vector_adapter.h>
 #include <rte_eventdev.h>
 #include <rte_lcore.h>
 #include <rte_malloc.h>
@@ -33,6 +34,7 @@ struct test_perf;
 
 struct __rte_cache_aligned worker_data {
 	uint64_t processed_pkts;
+	uint64_t processed_vecs;
 	uint64_t latency;
 	uint8_t dev_id;
 	uint8_t port_id;
@@ -50,12 +52,17 @@ struct dma_adptr_data {
 	uint16_t vchan_id;
 };
 
+struct vector_adptr_data {
+	struct rte_event_vector_adapter *vector_adptr;
+};
+
 struct __rte_cache_aligned prod_data {
 	uint8_t dev_id;
 	uint8_t port_id;
 	uint8_t queue_id;
 	struct crypto_adptr_data ca;
 	struct dma_adptr_data da;
+	struct vector_adptr_data va;
 	struct test_perf *t;
 };
 
@@ -320,9 +327,9 @@ perf_process_last_stage_latency(struct rte_mempool *const pool, enum evt_prod_ty
 }
 
 static __rte_always_inline void
-perf_process_vector_last_stage(struct rte_mempool *const pool,
-		struct rte_mempool *const ca_pool, struct rte_event *const ev,
-		struct worker_data *const w, const bool enable_fwd_latency)
+perf_process_crypto_vector_last_stage(struct rte_mempool *const pool,
+				      struct rte_mempool *const ca_pool, struct rte_event *const ev,
+				      struct worker_data *const w, const bool enable_fwd_latency)
 {
 	struct rte_event_vector *vec = ev->vec;
 	struct rte_crypto_op *cop;
diff --git a/app/test-eventdev/test_perf_queue.c b/app/test-eventdev/test_perf_queue.c
index 58715a2537..36fe94e190 100644
--- a/app/test-eventdev/test_perf_queue.c
+++ b/app/test-eventdev/test_perf_queue.c
@@ -147,7 +147,7 @@ perf_queue_worker_burst(void *arg, const int enable_fwd_latency)
 }
 
 static int
-perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
+perf_queue_worker_crypto_vector(void *arg, const int enable_fwd_latency)
 {
 	uint16_t enq = 0, deq = 0;
 	struct rte_event ev;
@@ -163,10 +163,8 @@ perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
 		if (!deq)
 			continue;
 
-		if (ev.event_type == RTE_EVENT_TYPE_CRYPTODEV_VECTOR) {
-			if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_latency))
-				continue;
-		}
+		if (perf_handle_crypto_vector_ev(&ev, &pe, enable_fwd_latency))
+			continue;
 
 		stage = ev.queue_id % nb_stages;
 		/* First q in pipeline, mark timestamp to compute fwd latency */
@@ -175,8 +173,8 @@ perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
 
 		/* Last stage in pipeline */
 		if (unlikely(stage == laststage)) {
-			perf_process_vector_last_stage(pool, t->ca_op_pool, &ev, w,
-						       enable_fwd_latency);
+			perf_process_crypto_vector_last_stage(pool, t->ca_op_pool, &ev, w,
+							      enable_fwd_latency);
 		} else {
 			fwd_event_vector(&ev, sched_type_list, nb_stages);
 			do {
@@ -190,6 +188,52 @@ perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
 	return 0;
 }
 
+static int
+perf_queue_worker_vector(void *arg, const int enable_fwd_latency)
+{
+	uint16_t enq = 0, deq = 0;
+	struct rte_event ev;
+	PERF_WORKER_INIT;
+
+	RTE_SET_USED(pe);
+	RTE_SET_USED(sz);
+	RTE_SET_USED(cnt);
+	RTE_SET_USED(prod_type);
+	RTE_SET_USED(prod_timer_type);
+
+	while (t->done == false) {
+		deq = rte_event_dequeue_burst(dev, port, &ev, 1, 0);
+		if (!deq)
+			continue;
+
+		if (ev.event_type != RTE_EVENT_TYPE_CPU_VECTOR) {
+			w->processed_pkts++;
+			continue;
+		}
+
+		stage = ev.sub_event_type % nb_stages;
+		if (enable_fwd_latency && stage == 0)
+			/* first stage in pipeline, mark ts to compute fwd latency */
+			ev.vec->u64s[0] = rte_get_timer_cycles();
+
+		/* Last stage in pipeline */
+		if (unlikely(stage == laststage)) {
+			w->processed_vecs++;
+			if (enable_fwd_latency)
+				w->latency += rte_get_timer_cycles() - ev.vec->u64s[0];
+			rte_mempool_put(pool, ev.event_ptr);
+		} else {
+			fwd_event_vector(&ev, sched_type_list, nb_stages);
+			do {
+				enq = rte_event_enqueue_burst(dev, port, &ev, 1);
+			} while (!enq && !t->done);
+		}
+	}
+	perf_worker_cleanup(pool, dev, port, &ev, enq, deq);
+
+	return 0;
+}
+
 static int
 worker_wrapper(void *arg)
 {
@@ -201,6 +245,8 @@ worker_wrapper(void *arg)
 
 	/* allow compiler to optimize */
 	if (opt->ena_vector && opt->prod_type == EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR)
+		return perf_queue_worker_crypto_vector(arg, fwd_latency);
+	else if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR)
 		return perf_queue_worker_vector(arg, fwd_latency);
 	else if (!burst && !fwd_latency)
 		return perf_queue_worker(arg, 0);
@@ -234,8 +280,10 @@ perf_queue_eventdev_setup(struct evt_test *test, struct evt_options *opt)
 
 	nb_ports = evt_nr_active_lcores(opt->wlcores);
 	nb_ports += opt->prod_type == EVT_PROD_TYPE_ETH_RX_ADPTR ||
-		opt->prod_type == EVT_PROD_TYPE_EVENT_TIMER_ADPTR ? 0 :
-		evt_nr_active_lcores(opt->plcores);
+				    opt->prod_type == EVT_PROD_TYPE_EVENT_TIMER_ADPTR ||
+				    opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR ?
+			    0 :
+			    evt_nr_active_lcores(opt->plcores);
 
 	nb_queues = perf_queue_nb_event_queues(opt);
 
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index e6e84eeec6..a17ab13a00 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -61,6 +61,11 @@ New Features
     model by introducing APIs that allow applications to offload creation of
     event vectors.
 
+* **Added vector adapter producer mode in eventdev test.**
+
+  Added vector adapter producer mode to measure performance of event vector
+  adapter.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/tools/testeventdev.rst b/doc/guides/tools/testeventdev.rst
index 58f373b867..c4e1047fbb 100644
--- a/doc/guides/tools/testeventdev.rst
+++ b/doc/guides/tools/testeventdev.rst
@@ -130,6 +130,10 @@ The following are the application command-line options:
 
         Use DMA device as producer.
 
+* ``--prod_type_vector``
+
+        Use event vector adapter as producer.
+
 * ``--timer_tick_nsec``
 
        Used to dictate number of nano seconds between bucket traversal of the
@@ -635,6 +639,7 @@ Supported application command line options are following::
         --prod_type_timerdev
         --prod_type_cryptodev
         --prod_type_dmadev
+        --prod_type_vector
         --prod_enq_burst_sz
         --timer_tick_nsec
         --max_tmo_nsec
@@ -756,6 +761,7 @@ Supported application command line options are following::
         --prod_type_timerdev
         --prod_type_cryptodev
         --prod_type_dmadev
+        --prod_type_vector
         --timer_tick_nsec
         --max_tmo_nsec
         --expiry_nsec
-- 
2.43.0

