Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E93606A338
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=G8/1y2Wy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6413F42F9B;
	Tue,  3 Nov 2026 16:21:49 +0100 (CET)
Received: from mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
 by mails.dpdk.org (Postfix) with ESMTPS id 225CE42F6B
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:21:48 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=DPuGOgG8ncHhMB4fNDa6nnxaaGEFTH7UpGfcNzgEwxg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719307; v=1; x=1794324107;
 b=G8/1y2Wyv/k9FhFLbaH/pkQeoXwQpA3XCXkygWhILs7V18PBP5TYe4FX2XoHqIAp0U2OEiE3
 tyyt8vOMzVnV3Fklomre+4zSlidW9vws/A3Avpx4oLsedQGhYNSy3aDBAuHXdw+rs8Kcd0c+3OL
 LDIKtOQwPW3jhRm0lsFv6t3c=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 00b2cdbbe479154e;
 Tue, 03 Nov 2026 15:21:47 +0000
X-Mizu-Trace-ID: 00b2cdbbe479154e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 180/227] app/test-bbdev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:18 +0800
Message-ID: <20261103145306.487255-181-chengwen.feng@linux.dev>
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
 app/test-bbdev/test_bbdev.c      | 26 ++++-----
 app/test-bbdev/test_bbdev_perf.c | 90 ++++++++++++++++----------------
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/app/test-bbdev/test_bbdev.c b/app/test-bbdev/test_bbdev.c
index 1f4246a6fa..71e93436a5 100644
--- a/app/test-bbdev/test_bbdev.c
+++ b/app/test-bbdev/test_bbdev.c
@@ -71,7 +71,7 @@ ut_setup(void)
 
 	num_queues = 1;
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(null_dev_id, num_queues,
-			SOCKET_ID_ANY), "Failed to setup queues for bbdev %u",
+			RTE_NUMA_ID_ANY), "Failed to setup queues for bbdev %u",
 			0);
 
 	/* Start the device */
@@ -97,7 +97,7 @@ test_bbdev_configure_invalid_dev_id(void)
 	for (dev_id = 0; dev_id < RTE_BBDEV_MAX_DEVS; dev_id++) {
 		if (!rte_bbdev_is_valid(dev_id)) {
 			TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id,
-					num_queues, SOCKET_ID_ANY),
+					num_queues, RTE_NUMA_ID_ANY),
 					"Failed test for rte_bbdev_setup_queues: "
 					"invalid dev_num %u", dev_id);
 			TEST_ASSERT(rte_bbdev_intr_enable(dev_id) == -ENODEV,
@@ -130,12 +130,12 @@ test_bbdev_configure_invalid_num_queues(void)
 	/* Stop the device in case it's started so it can be configured */
 	rte_bbdev_stop(dev_id);
 
-	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 0, SOCKET_ID_ANY),
+	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 0, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"invalid num_queues %d", 0);
 
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id, num_queues,
-			SOCKET_ID_ANY),
+			RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"invalid dev_num %u", dev_id);
 
@@ -153,13 +153,13 @@ test_bbdev_configure_invalid_num_queues(void)
 
 	num_queues = info.drv.max_num_queues;
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id, num_queues,
-			SOCKET_ID_ANY),
+			RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"invalid num_queues: %u", num_queues);
 
 	num_queues++;
 	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, num_queues,
-			SOCKET_ID_ANY),
+			RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"invalid num_queues: %u", num_queues);
 
@@ -188,7 +188,7 @@ test_bbdev_configure_stop_device(void)
 			"started value: %u", info.started);
 
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id,
-			info.drv.max_num_queues, SOCKET_ID_ANY),
+			info.drv.max_num_queues, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"device should be stopped, dev_id: %u", dev_id);
 
@@ -213,7 +213,7 @@ test_bbdev_configure_stop_device(void)
 			"started value: %u", info.started);
 
 	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id,
-			info.drv.max_num_queues, SOCKET_ID_ANY),
+			info.drv.max_num_queues, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"device should be started, dev_id: %u", dev_id);
 
@@ -238,7 +238,7 @@ test_bbdev_configure_stop_device(void)
 			"started value: %u", info.started);
 
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id,
-			info.drv.max_num_queues, SOCKET_ID_ANY),
+			info.drv.max_num_queues, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"device should be stopped, dev_id: %u", dev_id);
 
@@ -1104,7 +1104,7 @@ test_bbdev_invalid_driver(void)
 
 	/* Tests for rte_bbdev_setup_queues */
 	dev2->dev_ops = NULL;
-	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, SOCKET_ID_ANY),
+	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"NULL dev_ops structure ");
 	dev2->dev_ops = dev1.dev_ops;
@@ -1112,7 +1112,7 @@ test_bbdev_invalid_driver(void)
 	dev_ops_tmp = *dev2->dev_ops;
 	dev_ops_tmp.info_get = NULL;
 	dev2->dev_ops = &dev_ops_tmp;
-	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, SOCKET_ID_ANY),
+	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"NULL info_get ");
 	dev2->dev_ops = dev1.dev_ops;
@@ -1120,14 +1120,14 @@ test_bbdev_invalid_driver(void)
 	dev_ops_tmp = *dev2->dev_ops;
 	dev_ops_tmp.queue_release = NULL;
 	dev2->dev_ops = &dev_ops_tmp;
-	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, SOCKET_ID_ANY),
+	TEST_ASSERT_FAIL(rte_bbdev_setup_queues(dev_id, 1, RTE_NUMA_ID_ANY),
 			"Failed test for rte_bbdev_setup_queues: "
 			"NULL queue_release ");
 	dev2->dev_ops = dev1.dev_ops;
 
 	dev2->data->numa_id = RTE_NUMA_ID_ANY;
 	TEST_ASSERT_SUCCESS(rte_bbdev_setup_queues(dev_id, 1,
-			SOCKET_ID_ANY), "Failed to configure bbdev %u", dev_id);
+			RTE_NUMA_ID_ANY), "Failed to configure bbdev %u", dev_id);
 
 	/* Test for rte_bbdev_queue_configure */
 	dev2->dev_ops = NULL;
diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index 8e2a26905d..35e3394495 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -22,7 +22,7 @@
 #include "main.h"
 #include "test_bbdev_vector.h"
 
-#define GET_SOCKET(socket_id) (((socket_id) == SOCKET_ID_ANY) ? 0 : (socket_id))
+#define GET_SOCKET(numa_id) (((numa_id) == RTE_NUMA_ID_ANY) ? 0 : (numa_id))
 
 #define MAX_QUEUES RTE_MAX_LCORE
 #define TEST_REPETITIONS 100
@@ -511,7 +511,7 @@ optimal_mempool_size(unsigned int val)
 /* allocates mbuf mempool for inputs and outputs */
 static struct rte_mempool *
 create_mbuf_pool(struct op_data_entries *entries, uint8_t dev_id,
-		int socket_id, unsigned int mbuf_pool_size,
+		int numa_id, unsigned int mbuf_pool_size,
 		const char *op_type_str)
 {
 	unsigned int i;
@@ -528,11 +528,11 @@ create_mbuf_pool(struct op_data_entries *entries, uint8_t dev_id,
 	return rte_pktmbuf_pool_create(pool_name, mbuf_pool_size, 0, 0,
 			RTE_MAX(max_seg_sz + RTE_PKTMBUF_HEADROOM
 					+ FILLER_HEADROOM,
-			(unsigned int)RTE_MBUF_DEFAULT_BUF_SIZE), socket_id);
+			(unsigned int)RTE_MBUF_DEFAULT_BUF_SIZE), numa_id);
 }
 
 static int
-create_mempools(struct active_device *ad, int socket_id,
+create_mempools(struct active_device *ad, int numa_id,
 		enum rte_bbdev_op_type org_op_type, uint16_t num_ops)
 {
 	struct rte_mempool *mp;
@@ -568,12 +568,12 @@ create_mempools(struct active_device *ad, int socket_id,
 	snprintf(pool_name, sizeof(pool_name), "%s_pool_%u", op_type_str,
 			ad->dev_id);
 	mp = rte_bbdev_op_pool_create(pool_name, op_type,
-			ops_pool_size, OPS_CACHE_SIZE, socket_id);
+			ops_pool_size, OPS_CACHE_SIZE, numa_id);
 	TEST_ASSERT_NOT_NULL(mp,
 			"ERROR Failed to create %u items ops pool for dev %u on socket %u.",
 			ops_pool_size,
 			ad->dev_id,
-			socket_id);
+			numa_id);
 	ad->ops_mempool = mp;
 
 	/* Do not create inputs and outputs mbufs for BaseBand Null Device */
@@ -584,13 +584,13 @@ create_mempools(struct active_device *ad, int socket_id,
 	if (in->nb_segments > 0) {
 		mbuf_pool_size = optimal_mempool_size(ops_pool_size *
 				in->nb_segments);
-		mp = create_mbuf_pool(in, ad->dev_id, socket_id,
+		mp = create_mbuf_pool(in, ad->dev_id, numa_id,
 				mbuf_pool_size, "in");
 		TEST_ASSERT_NOT_NULL(mp,
 				"ERROR Failed to create %u items input pktmbuf pool for dev %u on socket %u.",
 				mbuf_pool_size,
 				ad->dev_id,
-				socket_id);
+				numa_id);
 		ad->in_mbuf_pool = mp;
 	}
 
@@ -598,14 +598,14 @@ create_mempools(struct active_device *ad, int socket_id,
 	if (hard_out->nb_segments > 0) {
 		mbuf_pool_size = optimal_mempool_size(ops_pool_size *
 				hard_out->nb_segments);
-		mp = create_mbuf_pool(hard_out, ad->dev_id, socket_id,
+		mp = create_mbuf_pool(hard_out, ad->dev_id, numa_id,
 				mbuf_pool_size,
 				"hard_out");
 		TEST_ASSERT_NOT_NULL(mp,
 				"ERROR Failed to create %u items hard output pktmbuf pool for dev %u on socket %u.",
 				mbuf_pool_size,
 				ad->dev_id,
-				socket_id);
+				numa_id);
 		ad->hard_out_mbuf_pool = mp;
 	}
 
@@ -613,14 +613,14 @@ create_mempools(struct active_device *ad, int socket_id,
 	if (soft_out->nb_segments > 0) {
 		mbuf_pool_size = optimal_mempool_size(ops_pool_size *
 				soft_out->nb_segments);
-		mp = create_mbuf_pool(soft_out, ad->dev_id, socket_id,
+		mp = create_mbuf_pool(soft_out, ad->dev_id, numa_id,
 				mbuf_pool_size,
 				"soft_out");
 		TEST_ASSERT_NOT_NULL(mp,
 				"ERROR Failed to create %uB soft output pktmbuf pool for dev %u on socket %u.",
 				mbuf_pool_size,
 				ad->dev_id,
-				socket_id);
+				numa_id);
 		ad->soft_out_mbuf_pool = mp;
 	}
 
@@ -628,14 +628,14 @@ create_mempools(struct active_device *ad, int socket_id,
 	if (harq_in->nb_segments > 0) {
 		mbuf_pool_size = optimal_mempool_size(ops_pool_size *
 				harq_in->nb_segments);
-		mp = create_mbuf_pool(harq_in, ad->dev_id, socket_id,
+		mp = create_mbuf_pool(harq_in, ad->dev_id, numa_id,
 				mbuf_pool_size,
 				"harq_in");
 		TEST_ASSERT_NOT_NULL(mp,
 				"ERROR Failed to create %uB harq input pktmbuf pool for dev %u on socket %u.",
 				mbuf_pool_size,
 				ad->dev_id,
-				socket_id);
+				numa_id);
 		ad->harq_in_mbuf_pool = mp;
 	}
 
@@ -643,14 +643,14 @@ create_mempools(struct active_device *ad, int socket_id,
 	if (harq_out->nb_segments > 0) {
 		mbuf_pool_size = optimal_mempool_size(ops_pool_size *
 				harq_out->nb_segments);
-		mp = create_mbuf_pool(harq_out, ad->dev_id, socket_id,
+		mp = create_mbuf_pool(harq_out, ad->dev_id, numa_id,
 				mbuf_pool_size,
 				"harq_out");
 		TEST_ASSERT_NOT_NULL(mp,
 				"ERROR Failed to create %uB harq output pktmbuf pool for dev %u on socket %u.",
 				mbuf_pool_size,
 				ad->dev_id,
-				socket_id);
+				numa_id);
 		ad->harq_out_mbuf_pool = mp;
 	}
 
@@ -1222,13 +1222,13 @@ allocate_buffers_on_socket(struct rte_bbdev_op_data **buffers, const int len,
 {
 	int i;
 
-	*buffers = rte_zmalloc_socket(NULL, len, 0, socket);
+	*buffers = rte_zmalloc_numa(NULL, len, 0, socket);
 	if (*buffers == NULL) {
 		printf("WARNING: Failed to allocate op_data on socket %d\n",
 				socket);
 		/* try to allocate memory on other detected sockets */
 		for (i = 0; i < socket; i++) {
-			*buffers = rte_zmalloc_socket(NULL, len, 0, i);
+			*buffers = rte_zmalloc_numa(NULL, len, 0, i);
 			if (*buffers != NULL)
 				break;
 		}
@@ -1344,7 +1344,7 @@ fill_queue_buffers(struct test_op_params *op_params,
 		struct rte_mempool *harq_in_mp, struct rte_mempool *harq_out_mp,
 		uint16_t queue_id,
 		const struct rte_bbdev_op_cap *capabilities,
-		uint16_t min_alignment, const int socket_id)
+		uint16_t min_alignment, const int numa_id)
 {
 	int ret;
 	enum op_data_type type;
@@ -1359,11 +1359,11 @@ fill_queue_buffers(struct test_op_params *op_params,
 	};
 
 	struct rte_bbdev_op_data **queue_ops[DATA_NUM_TYPES] = {
-		&op_params->q_bufs[socket_id][queue_id].inputs,
-		&op_params->q_bufs[socket_id][queue_id].soft_outputs,
-		&op_params->q_bufs[socket_id][queue_id].hard_outputs,
-		&op_params->q_bufs[socket_id][queue_id].harq_inputs,
-		&op_params->q_bufs[socket_id][queue_id].harq_outputs,
+		&op_params->q_bufs[numa_id][queue_id].inputs,
+		&op_params->q_bufs[numa_id][queue_id].soft_outputs,
+		&op_params->q_bufs[numa_id][queue_id].hard_outputs,
+		&op_params->q_bufs[numa_id][queue_id].harq_inputs,
+		&op_params->q_bufs[numa_id][queue_id].harq_outputs,
 	};
 
 	for (type = DATA_INPUT; type < DATA_NUM_TYPES; ++type) {
@@ -1374,7 +1374,7 @@ fill_queue_buffers(struct test_op_params *op_params,
 
 		ret = allocate_buffers_on_socket(queue_ops[type],
 				n * sizeof(struct rte_bbdev_op_data),
-				socket_id);
+				numa_id);
 		TEST_ASSERT_SUCCESS(ret,
 				"Couldn't allocate memory for rte_bbdev_op_data structs");
 
@@ -3035,7 +3035,7 @@ static int
 run_test_case_on_device(test_case_function *test_case_func, uint8_t dev_id,
 		struct test_op_params *op_params)
 {
-	int t_ret, f_ret, socket_id = SOCKET_ID_ANY;
+	int t_ret, f_ret, numa_id = RTE_NUMA_ID_ANY;
 	unsigned int i;
 	struct active_device *ad;
 	unsigned int burst_sz = get_burst_sz();
@@ -3050,9 +3050,9 @@ run_test_case_on_device(test_case_function *test_case_func, uint8_t dev_id,
 
 	struct rte_bbdev_info info;
 	rte_bbdev_info_get(ad->dev_id, &info);
-	socket_id = GET_SOCKET(info.socket_id);
+	numa_id = GET_SOCKET(info.numa_id);
 
-	f_ret = create_mempools(ad, socket_id, op_type,
+	f_ret = create_mempools(ad, numa_id, op_type,
 			get_num_ops());
 	if (f_ret != TEST_SUCCESS) {
 		printf("Couldn't create mempools");
@@ -3109,7 +3109,7 @@ run_test_case_on_device(test_case_function *test_case_func, uint8_t dev_id,
 				ad->queue_ids[i],
 				capabilities,
 				info.drv.min_alignment,
-				socket_id);
+				numa_id);
 		if (f_ret != TEST_SUCCESS) {
 			printf("Couldn't init queue buffers");
 			goto fail;
@@ -3474,7 +3474,7 @@ throughput_intr_lcore_ldpc_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -3578,7 +3578,7 @@ throughput_intr_lcore_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -3675,7 +3675,7 @@ throughput_intr_lcore_enc(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -3769,7 +3769,7 @@ throughput_intr_lcore_ldpc_enc(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -3865,7 +3865,7 @@ throughput_intr_lcore_fft(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -3959,7 +3959,7 @@ throughput_intr_lcore_mldts(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_atomic_store_explicit(&tp->processing_status, 0, rte_memory_order_relaxed);
 	rte_atomic_store_explicit(&tp->nb_dequeued, 0, rte_memory_order_relaxed);
@@ -4049,7 +4049,7 @@ throughput_pmd_lcore_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4169,7 +4169,7 @@ bler_pmd_lcore_ldpc_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4305,7 +4305,7 @@ bler_pmd_lcore_turbo_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4429,7 +4429,7 @@ throughput_pmd_lcore_ldpc_dec(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4561,7 +4561,7 @@ throughput_pmd_lcore_enc(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4663,7 +4663,7 @@ throughput_pmd_lcore_ldpc_enc(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4765,7 +4765,7 @@ throughput_pmd_lcore_fft(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -4864,7 +4864,7 @@ throughput_pmd_lcore_mldts(void *arg)
 			"NUM_OPS cannot exceed %u for this device",
 			info.drv.queue_size_lim);
 
-	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &tp->op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	rte_wait_until_equal_16((uint16_t *)(uintptr_t)&tp->op_params->sync, SYNC_START,
 			rte_memory_order_relaxed);
@@ -5772,7 +5772,7 @@ validation_latency_test(struct active_device *ad,
 			"BURST_SIZE should be <= %u", MAX_BURST);
 
 	rte_bbdev_info_get(ad->dev_id, &info);
-	bufs = &op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	op_type_str = rte_bbdev_op_type_str(op_type);
 	TEST_ASSERT_NOT_NULL(op_type_str, "Invalid op type: %u", op_type);
@@ -6378,7 +6378,7 @@ offload_cost_test(struct active_device *ad,
 			"BURST_SIZE should be <= %u", MAX_BURST);
 
 	rte_bbdev_info_get(ad->dev_id, &info);
-	bufs = &op_params->q_bufs[GET_SOCKET(info.socket_id)][queue_id];
+	bufs = &op_params->q_bufs[GET_SOCKET(info.numa_id)][queue_id];
 
 	op_type_str = rte_bbdev_op_type_str(op_type);
 	TEST_ASSERT_NOT_NULL(op_type_str, "Invalid op type: %u", op_type);
-- 
2.55.0

