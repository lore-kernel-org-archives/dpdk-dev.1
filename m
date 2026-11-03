Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D9606A33D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Cu2DKWxs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 655D342FA9;
	Tue,  3 Nov 2026 16:20:59 +0100 (CET)
Received: from mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
 by mails.dpdk.org (Postfix) with ESMTPS id 9347B42FAD
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:57 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=/ZoT93A+Mz6Bcdat5vgVz7Eoz+vaQ8AaZ7ZUpiT8U0A=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719257; v=1; x=1794324057;
 b=Cu2DKWxsY5foErTrIyHF1jlP0AygoY5zqFDBH7CuyCBx7A0GYStwbQgMa41LBkqgbA7SURfC
 Ne3rQ790mqKbaYyjp+cfG/Rm26v6CLsFznPnAvuYLiQVysMpqxJj2xLISs+H3QvWHFv4G4QjK24
 OMniKGaSQq5wx6ysBICHwKfU=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 843a23a5a2740382;
 Tue, 03 Nov 2026 15:20:56 +0000
X-Mizu-Trace-ID: 843a23a5a2740382
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 177/227] app/test-eventdev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:15 +0800
Message-ID: <20261103145306.487255-178-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename socket_id parameters, local variables and comments to the
NUMA node terminology, and switch calls to the NUMA-named APIs.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-eventdev/evt_common.h           |  2 +-
 app/test-eventdev/evt_options.c          |  8 +++---
 app/test-eventdev/evt_options.h          |  2 +-
 app/test-eventdev/test_order_common.c    | 14 +++++-----
 app/test-eventdev/test_perf_common.c     | 34 ++++++++++++------------
 app/test-eventdev/test_pipeline_common.c | 14 +++++-----
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/app/test-eventdev/evt_common.h b/app/test-eventdev/evt_common.h
index ec824f2454..c6503b736e 100644
--- a/app/test-eventdev/evt_common.h
+++ b/app/test-eventdev/evt_common.h
@@ -57,7 +57,7 @@ struct evt_options {
 	bool wlcores[RTE_MAX_LCORE];
 	bool crypto_cipher_bit_mode;
 	int pool_sz;
-	int socket_id;
+	int numa_id;
 	int nb_stages;
 	int verbose_level;
 	uint8_t dev_id;
diff --git a/app/test-eventdev/evt_options.c b/app/test-eventdev/evt_options.c
index 1da0aba386..1a7257cbad 100644
--- a/app/test-eventdev/evt_options.c
+++ b/app/test-eventdev/evt_options.c
@@ -25,7 +25,7 @@ evt_options_default(struct evt_options *opt)
 	opt->dev_id = 0;
 	strlcpy(opt->test_name, "order_queue", sizeof(opt->test_name));
 	opt->nb_flows = 1024;
-	opt->socket_id = SOCKET_ID_ANY;
+	opt->numa_id = RTE_NUMA_ID_ANY;
 	opt->pool_sz = 16 * 1024;
 	opt->prod_enq_burst_sz = 0;
 	opt->wkr_deq_dep = 16;
@@ -291,7 +291,7 @@ evt_parse_test_name(struct evt_options *opt, const char *arg)
 static int
 evt_parse_socket_id(struct evt_options *opt, const char *arg)
 {
-	opt->socket_id = atoi(arg);
+	opt->numa_id = atoi(arg);
 	return 0;
 }
 
@@ -482,7 +482,7 @@ usage(char *program)
 	printf("\t--verbose          : verbose level\n"
 		"\t--dev              : device id of the event device\n"
 		"\t--test             : name of the test application to run\n"
-		"\t--socket_id        : socket_id of application resources\n"
+		"\t--numa_id        : numa_id of application resources\n"
 		"\t--pool_sz          : pool size of the mempool\n"
 		"\t--plcores          : list of lcore ids for producers\n"
 		"\t--wlcores          : list of lcore ids for workers\n"
@@ -720,7 +720,7 @@ evt_options_dump(struct evt_options *opt)
 	evt_dump("test", "%s", opt->test_name);
 	evt_dump("dev", "%d", opt->dev_id);
 	evt_dump("verbose_level", "%d", opt->verbose_level);
-	evt_dump("socket_id", "%d", opt->socket_id);
+	evt_dump("numa_id", "%d", opt->numa_id);
 	evt_dump("pool_sz", "%d", opt->pool_sz);
 	evt_dump("main lcore", "%d", rte_get_main_lcore());
 	evt_dump("nb_pkts", "%"PRIu64, opt->nb_pkts);
diff --git a/app/test-eventdev/evt_options.h b/app/test-eventdev/evt_options.h
index 4bf712bd19..e4d2e31150 100644
--- a/app/test-eventdev/evt_options.h
+++ b/app/test-eventdev/evt_options.h
@@ -24,7 +24,7 @@
 #define EVT_PROD_LCORES          ("plcores")
 #define EVT_WORK_LCORES          ("wlcores")
 #define EVT_NB_FLOWS             ("nb_flows")
-#define EVT_SOCKET_ID            ("socket_id")
+#define EVT_SOCKET_ID            ("numa_id")
 #define EVT_POOL_SZ              ("pool_sz")
 #define EVT_WKR_DEQ_DEP          ("worker_deq_depth")
 #define EVT_NB_PKTS              ("nb_pkts")
diff --git a/app/test-eventdev/test_order_common.c b/app/test-eventdev/test_order_common.c
index c0b47fa1d7..1d1765cea4 100644
--- a/app/test-eventdev/test_order_common.c
+++ b/app/test-eventdev/test_order_common.c
@@ -149,8 +149,8 @@ order_test_setup(struct evt_test *test, struct evt_options *opt)
 		.align = alignof(seqn_t),
 	};
 
-	test_order = rte_zmalloc_socket(test->name, sizeof(struct test_order),
-				RTE_CACHE_LINE_SIZE, opt->socket_id);
+	test_order = rte_zmalloc_numa(test->name, sizeof(struct test_order),
+				RTE_CACHE_LINE_SIZE, opt->numa_id);
 	if (test_order  == NULL) {
 		evt_err("failed to allocate test_order memory");
 		goto nomem;
@@ -172,18 +172,18 @@ order_test_setup(struct evt_test *test, struct evt_options *opt)
 		return -rte_errno;
 	}
 
-	t->producer_flow_seq = rte_zmalloc_socket("test_producer_flow_seq",
+	t->producer_flow_seq = rte_zmalloc_numa("test_producer_flow_seq",
 				 sizeof(*t->producer_flow_seq) * opt->nb_flows,
-				RTE_CACHE_LINE_SIZE, opt->socket_id);
+				RTE_CACHE_LINE_SIZE, opt->numa_id);
 
 	if (t->producer_flow_seq  == NULL) {
 		evt_err("failed to allocate t->producer_flow_seq memory");
 		goto prod_nomem;
 	}
 
-	t->expected_flow_seq = rte_zmalloc_socket("test_expected_flow_seq",
+	t->expected_flow_seq = rte_zmalloc_numa("test_expected_flow_seq",
 				 sizeof(*t->expected_flow_seq) * opt->nb_flows,
-				RTE_CACHE_LINE_SIZE, opt->socket_id);
+				RTE_CACHE_LINE_SIZE, opt->numa_id);
 
 	if (t->expected_flow_seq  == NULL) {
 		evt_err("failed to allocate t->expected_flow_seq memory");
@@ -224,7 +224,7 @@ order_mempool_setup(struct evt_test *test, struct evt_options *opt)
 	t->pool  = rte_pktmbuf_pool_create(test->name, opt->pool_sz,
 					256 /* Cache */, 0,
 					512, /* Use very small mbufs */
-					opt->socket_id);
+					opt->numa_id);
 	if (t->pool == NULL) {
 		evt_err("failed to create mempool");
 		return -ENOMEM;
diff --git a/app/test-eventdev/test_perf_common.c b/app/test-eventdev/test_perf_common.c
index cb69ed7f1b..9556203824 100644
--- a/app/test-eventdev/test_perf_common.c
+++ b/app/test-eventdev/test_perf_common.c
@@ -1521,9 +1521,9 @@ perf_event_dev_port_setup(struct evt_test *test, struct evt_options *opt,
 			p->queue_id = prod * stride;
 			p->ca.cdev_id = cdev_id;
 			p->ca.cdev_qp_id = qp_id;
-			p->ca.crypto_sess = rte_zmalloc_socket(
+			p->ca.crypto_sess = rte_zmalloc_numa(
 				NULL, sizeof(void *) * t->nb_flows,
-				RTE_CACHE_LINE_SIZE, opt->socket_id);
+				RTE_CACHE_LINE_SIZE, opt->numa_id);
 			p->t = t;
 
 			ret = perf_event_crypto_adapter_setup(t, p);
@@ -1649,7 +1649,7 @@ perf_event_dev_port_setup(struct evt_test *test, struct evt_options *opt,
 		conf.event_dev_id = opt->dev_id;
 		conf.vector_sz = opt->vector_size;
 		conf.vector_timeout_ns = opt->vector_tmo_nsec;
-		conf.numa_id = opt->socket_id;
+		conf.numa_id = opt->numa_id;
 		conf.vector_mp = t->pool;
 
 		conf.ev.sched_type = opt->sched_type_list[0];
@@ -1934,14 +1934,14 @@ perf_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 		}
 
 		if (rte_eth_rx_queue_setup(i, 0, NB_RX_DESC,
-				rte_socket_id(), NULL, t->pool) < 0) {
+				rte_numa_id(), NULL, t->pool) < 0) {
 			evt_err("Failed to setup eth port [%d] rx_queue: %d.",
 					i, 0);
 			return -EINVAL;
 		}
 
 		if (rte_eth_tx_queue_setup(i, 0, NB_TX_DESC,
-					rte_socket_id(), NULL) < 0) {
+					rte_numa_id(), NULL) < 0) {
 			evt_err("Failed to setup eth port [%d] tx_queue: %d.",
 					i, 0);
 			return -EINVAL;
@@ -2010,7 +2010,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 	t->ca_op_pool = rte_crypto_op_pool_create(
 		"crypto_op_pool", opt->crypto_op_type, opt->pool_sz,
 		128, sizeof(union rte_event_crypto_metadata) + EVT_CRYPTO_MAX_IV_SIZE,
-		rte_socket_id());
+		rte_numa_id());
 	if (t->ca_op_pool == NULL) {
 		evt_err("Failed to create crypto op pool");
 		return -ENOMEM;
@@ -2019,7 +2019,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 	nb_sessions = evt_nr_active_lcores(opt->plcores) * t->nb_flows;
 	t->ca_asym_sess_pool = rte_cryptodev_asym_session_pool_create(
 		"ca_asym_sess_pool", nb_sessions, 0,
-		sizeof(union rte_event_crypto_metadata), SOCKET_ID_ANY);
+		sizeof(union rte_event_crypto_metadata), RTE_NUMA_ID_ANY);
 	if (t->ca_asym_sess_pool == NULL) {
 		evt_err("Failed to create sym session pool");
 		ret = -ENOMEM;
@@ -2038,7 +2038,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 
 	t->ca_sess_pool = rte_cryptodev_sym_session_pool_create(
 		"ca_sess_pool", nb_sessions, max_session_size, 0,
-		sizeof(union rte_event_crypto_metadata), SOCKET_ID_ANY);
+		sizeof(union rte_event_crypto_metadata), RTE_NUMA_ID_ANY);
 	if (t->ca_sess_pool == NULL) {
 		evt_err("Failed to create sym session pool");
 		ret = -ENOMEM;
@@ -2050,7 +2050,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 		nb_elem = RTE_MAX(512U, nb_elem);
 		nb_elem += evt_nr_active_lcores(opt->wlcores) * 32;
 		t->ca_vector_pool = rte_event_vector_pool_create("vector_pool", nb_elem, 32,
-				opt->vector_size, opt->socket_id);
+				opt->vector_size, opt->numa_id);
 		if (t->ca_vector_pool == NULL) {
 			evt_err("Failed to create event vector pool");
 			ret = -ENOMEM;
@@ -2097,7 +2097,7 @@ perf_cryptodev_setup(struct evt_test *test, struct evt_options *opt)
 		for (qp_id = 0; qp_id < conf.nb_queue_pairs; qp_id++) {
 			ret = rte_cryptodev_queue_pair_setup(
 				cdev_id, qp_id, &qp_conf,
-				rte_cryptodev_socket_id(cdev_id));
+				rte_cryptodev_numa_id(cdev_id));
 			if (ret) {
 				evt_err("Failed to setup queue pairs on cryptodev %u\n",
 					cdev_id);
@@ -2237,7 +2237,7 @@ perf_mempool_setup(struct evt_test *test, struct evt_options *opt)
 				cache_sz, /* cache size*/
 				0, NULL, NULL,
 				perf_elt_init, /* obj constructor */
-				NULL, opt->socket_id, 0); /* flags */
+				NULL, opt->numa_id, 0); /* flags */
 	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_CRYPTO_ADPTR &&
 		   opt->crypto_op_type == RTE_CRYPTO_OP_TYPE_ASYMMETRIC) {
 		t->pool = rte_mempool_create(test->name, /* mempool name */
@@ -2247,7 +2247,7 @@ perf_mempool_setup(struct evt_test *test, struct evt_options *opt)
 				cache_sz, /* cache size*/
 				0, NULL, NULL,
 				NULL, /* obj constructor */
-				NULL, opt->socket_id, 0); /* flags */
+				NULL, opt->numa_id, 0); /* flags */
 	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_DMA_ADPTR) {
 		t->pool = rte_mempool_create(test->name,   /* mempool name */
 					     opt->pool_sz, /* number of elements*/
@@ -2255,17 +2255,17 @@ perf_mempool_setup(struct evt_test *test, struct evt_options *opt)
 						     (sizeof(struct rte_dma_sge) * 2),
 					     cache_sz,		       /* cache size*/
 					     0, NULL, NULL, NULL,      /* obj constructor */
-					     NULL, opt->socket_id, 0); /* flags */
+					     NULL, opt->numa_id, 0); /* flags */
 	} else if (opt->prod_type == EVT_PROD_TYPE_EVENT_VECTOR_ADPTR) {
 		t->pool = rte_event_vector_pool_create(test->name, opt->pool_sz, cache_sz,
-						       opt->vector_size, opt->socket_id);
+						       opt->vector_size, opt->numa_id);
 	} else {
 		t->pool = rte_pktmbuf_pool_create(test->name, /* mempool name */
 				opt->pool_sz, /* number of elements*/
 				cache_sz, /* cache size*/
 				0,
 				RTE_MBUF_DEFAULT_BUF_SIZE,
-				opt->socket_id); /* flags */
+				opt->numa_id); /* flags */
 	}
 
 	if (t->pool == NULL) {
@@ -2290,8 +2290,8 @@ perf_test_setup(struct evt_test *test, struct evt_options *opt)
 {
 	void *test_perf;
 
-	test_perf = rte_zmalloc_socket(test->name, sizeof(struct test_perf),
-				RTE_CACHE_LINE_SIZE, opt->socket_id);
+	test_perf = rte_zmalloc_numa(test->name, sizeof(struct test_perf),
+				RTE_CACHE_LINE_SIZE, opt->numa_id);
 	if (test_perf  == NULL) {
 		evt_err("failed to allocate test_perf memory");
 		goto nomem;
diff --git a/app/test-eventdev/test_pipeline_common.c b/app/test-eventdev/test_pipeline_common.c
index b6af0ad987..56d648c4ea 100644
--- a/app/test-eventdev/test_pipeline_common.c
+++ b/app/test-eventdev/test_pipeline_common.c
@@ -398,7 +398,7 @@ pipeline_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 
 		for (j = 0; j < opt->eth_queues; j++) {
 			if (rte_eth_rx_queue_setup(
-				    i, j, NB_RX_DESC, rte_socket_id(), &rx_conf,
+				    i, j, NB_RX_DESC, rte_numa_id(), &rx_conf,
 				    opt->per_port_pool ? t->pool[i] :
 							      t->pool[0]) < 0) {
 				evt_err("Failed to setup eth port [%d] rx_queue: %d.",
@@ -408,7 +408,7 @@ pipeline_ethdev_setup(struct evt_test *test, struct evt_options *opt)
 		}
 
 		if (rte_eth_tx_queue_setup(i, 0, NB_TX_DESC,
-					rte_socket_id(), NULL) < 0) {
+					rte_numa_id(), NULL) < 0) {
 			evt_err("Failed to setup eth port [%d] tx_queue: %d.",
 					i, 0);
 			return -EINVAL;
@@ -481,7 +481,7 @@ pipeline_event_rx_adapter_setup(struct evt_options *opt, uint8_t stride,
 		nb_elem += evt_nr_active_lcores(opt->wlcores) * 32;
 		vector_pool = rte_event_vector_pool_create(
 			"vector_pool", nb_elem, 32, opt->vector_size,
-			opt->socket_id);
+			opt->numa_id);
 		if (vector_pool == NULL) {
 			evt_err("failed to create event vector pool");
 			return -ENOMEM;
@@ -776,7 +776,7 @@ pipeline_mempool_setup(struct evt_test *test, struct evt_options *opt)
 				name,	      /* mempool name */
 				opt->pool_sz, /* number of elements*/
 				0,	      /* cache size*/
-				0, opt->mbuf_sz, opt->socket_id); /* flags */
+				0, opt->mbuf_sz, opt->numa_id); /* flags */
 
 			if (t->pool[i] == NULL) {
 				evt_err("failed to create mempool %s", name);
@@ -790,7 +790,7 @@ pipeline_mempool_setup(struct evt_test *test, struct evt_options *opt)
 			test->name,   /* mempool name */
 			opt->pool_sz, /* number of elements*/
 			0,	      /* cache size*/
-			0, opt->mbuf_sz, opt->socket_id); /* flags */
+			0, opt->mbuf_sz, opt->numa_id); /* flags */
 
 		if (t->pool[0] == NULL) {
 			evt_err("failed to create mempool");
@@ -821,9 +821,9 @@ pipeline_test_setup(struct evt_test *test, struct evt_options *opt)
 {
 	void *test_pipeline;
 
-	test_pipeline = rte_zmalloc_socket(test->name,
+	test_pipeline = rte_zmalloc_numa(test->name,
 			sizeof(struct test_pipeline), RTE_CACHE_LINE_SIZE,
-			opt->socket_id);
+			opt->numa_id);
 	if (test_pipeline  == NULL) {
 		evt_err("failed to allocate test_pipeline memory");
 		goto nomem;
-- 
2.55.0

