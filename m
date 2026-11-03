Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B3B606A33D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=goytAU6B
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8042142FB1;
	Tue,  3 Nov 2026 16:21:04 +0100 (CET)
Received: from mta0.migadu.com (out-1.mta0.migadu.com [91.218.175.1])
 by mails.dpdk.org (Postfix) with ESMTPS id 8954B42FA7
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:21:02 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=vl+8DpjN39D7UPI2xDDt7rdGXjy3jDQGAK2B8Ruue+8=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719262; v=1; x=1794324062;
 b=goytAU6B9ZnSkQBljZwRwOUvdrwCB0ClORDuHCUyeU5ZgnbAFprGexsWOts9rhYPthzzKEvp
 7el86FP0mW8iaCYc4f85XTRVXC4JP+V0HsCXs7ZrG65fCLJSlc0PfPf4w5yrKVtUKhPJseCseyk
 FmxUJd+UZyI0l2MeT/SPTXuU=
X-Envelope-To: dev@dpdk.org
Received: by mta12.migadu.com with ESMTPS id 01111dd21f98b4bf;
 Tue, 03 Nov 2026 15:21:02 +0000
X-Mizu-Trace-ID: 01111dd21f98b4bf
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 178/227] app/test-compress-perf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:16 +0800
Message-ID: <20261103145306.487255-179-chengwen.feng@linux.dev>
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
 .../comp_perf_test_common.c                   | 44 +++++++++----------
 .../comp_perf_test_cyclecount.c               |  6 +--
 .../comp_perf_test_throughput.c               |  6 +--
 .../comp_perf_test_verify.c                   |  4 +-
 app/test-compress-perf/main.c                 | 22 +++++-----
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/app/test-compress-perf/comp_perf_test_common.c b/app/test-compress-perf/comp_perf_test_common.c
index 53685cd57d..a15c26fab3 100644
--- a/app/test-compress-perf/comp_perf_test_common.c
+++ b/app/test-compress-perf/comp_perf_test_common.c
@@ -121,19 +121,19 @@ static const struct rte_memzone *
 comp_perf_make_memzone(const char *name, struct cperf_mem_resources *mem,
 		       unsigned int number, size_t size)
 {
-	unsigned int socket_id = rte_socket_id();
+	unsigned int numa_id = rte_numa_id();
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	const struct rte_memzone *memzone;
 
 	snprintf(mz_name, RTE_MEMZONE_NAMESIZE, "%s_s%u_d%u_q%u_%d", name,
-		 socket_id, mem->dev_id, mem->qp_id, number);
+		 numa_id, mem->dev_id, mem->qp_id, number);
 	memzone = rte_memzone_lookup(mz_name);
 	if (memzone != NULL && memzone->len != size) {
 		rte_memzone_free(memzone);
 		memzone = NULL;
 	}
 	if (memzone == NULL) {
-		memzone = rte_memzone_reserve_aligned(mz_name, size, socket_id,
+		memzone = rte_memzone_reserve_aligned(mz_name, size, numa_id,
 				RTE_MEMZONE_IOVA_CONTIG, RTE_CACHE_LINE_SIZE);
 		if (memzone == NULL)
 			RTE_LOG(ERR, USER1, "Can't allocate memory zone %s\n",
@@ -148,9 +148,9 @@ comp_perf_allocate_external_mbufs(struct comp_test_data *test_data,
 {
 	uint32_t i;
 
-	mem->comp_memzones = rte_zmalloc_socket(NULL,
+	mem->comp_memzones = rte_zmalloc_numa(NULL,
 		test_data->total_segs * sizeof(struct rte_memzone *),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (mem->comp_memzones == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -158,9 +158,9 @@ comp_perf_allocate_external_mbufs(struct comp_test_data *test_data,
 		return -1;
 	}
 
-	mem->decomp_memzones = rte_zmalloc_socket(NULL,
+	mem->decomp_memzones = rte_zmalloc_numa(NULL,
 		test_data->total_segs * sizeof(struct rte_memzone *),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (mem->decomp_memzones == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -168,9 +168,9 @@ comp_perf_allocate_external_mbufs(struct comp_test_data *test_data,
 		return -1;
 	}
 
-	mem->comp_buf_infos = rte_zmalloc_socket(NULL,
+	mem->comp_buf_infos = rte_zmalloc_numa(NULL,
 		test_data->total_segs * sizeof(struct rte_mbuf_ext_shared_info),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (mem->comp_buf_infos == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -178,9 +178,9 @@ comp_perf_allocate_external_mbufs(struct comp_test_data *test_data,
 		return -1;
 	}
 
-	mem->decomp_buf_infos = rte_zmalloc_socket(NULL,
+	mem->decomp_buf_infos = rte_zmalloc_numa(NULL,
 		test_data->total_segs * sizeof(struct rte_mbuf_ext_shared_info),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (mem->decomp_buf_infos == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -272,7 +272,7 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 				test_data->total_segs,
 				0, 0,
 				comp_mbuf_size,
-				rte_socket_id());
+				rte_numa_id());
 	if (mem->comp_buf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Mbuf mempool could not be created\n");
 		return -1;
@@ -284,7 +284,7 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 				test_data->total_segs,
 				0, 0,
 				decomp_mbuf_size,
-				rte_socket_id());
+				rte_numa_id());
 	if (mem->decomp_buf_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Mbuf mempool could not be created\n");
 		return -1;
@@ -299,7 +299,7 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 	/* one mempool for both src and dst mbufs */
 	mem->op_pool = rte_comp_op_pool_create(pool_name,
 				mem->total_bufs * 2,
-				0, 0, rte_socket_id());
+				0, 0, rte_numa_id());
 	if (mem->op_pool == NULL) {
 		RTE_LOG(ERR, USER1, "Comp op mempool could not be created\n");
 		return -1;
@@ -317,34 +317,34 @@ comp_perf_allocate_memory(struct comp_test_data *test_data,
 		decomp_data_size = output_data_sz;
 	}
 
-	mem->compressed_data = rte_zmalloc_socket(NULL, comp_data_size, 0,
-						  rte_socket_id());
+	mem->compressed_data = rte_zmalloc_numa(NULL, comp_data_size, 0,
+						  rte_numa_id());
 	if (mem->compressed_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the input "
 				"file could not be allocated\n");
 		return -1;
 	}
 
-	mem->decompressed_data = rte_zmalloc_socket(NULL, decomp_data_size, 0,
-						    rte_socket_id());
+	mem->decompressed_data = rte_zmalloc_numa(NULL, decomp_data_size, 0,
+						    rte_numa_id());
 	if (mem->decompressed_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the input "
 				"file could not be allocated\n");
 		return -1;
 	}
 
-	mem->comp_bufs = rte_zmalloc_socket(NULL,
+	mem->comp_bufs = rte_zmalloc_numa(NULL,
 			mem->total_bufs * sizeof(struct rte_mbuf *),
-			0, rte_socket_id());
+			0, rte_numa_id());
 	if (mem->comp_bufs == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the compression mbufs"
 				" could not be allocated\n");
 		return -1;
 	}
 
-	mem->decomp_bufs = rte_zmalloc_socket(NULL,
+	mem->decomp_bufs = rte_zmalloc_numa(NULL,
 			mem->total_bufs * sizeof(struct rte_mbuf *),
-			0, rte_socket_id());
+			0, rte_numa_id());
 	if (mem->decomp_bufs == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the decompression mbufs"
 				" could not be allocated\n");
diff --git a/app/test-compress-perf/comp_perf_test_cyclecount.c b/app/test-compress-perf/comp_perf_test_cyclecount.c
index 64e8faa55a..cd4de6c0ff 100644
--- a/app/test-compress-perf/comp_perf_test_cyclecount.c
+++ b/app/test-compress-perf/comp_perf_test_cyclecount.c
@@ -176,10 +176,10 @@ main_loop(struct cperf_cyclecount_ctx *ctx, enum rte_comp_xform_type type)
 	ctx->ops_deq_retries = 0;
 
 	/* one array for both enqueue and dequeue */
-	ops = rte_zmalloc_socket(NULL,
+	ops = rte_zmalloc_numa(NULL,
 		(test_data->burst_sz + mem->total_bufs) *
 		sizeof(struct rte_comp_op *),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (ops == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -510,7 +510,7 @@ cperf_cyclecount_test_runner(void *test_ctx)
 			ctx->ver.options->driver_name,
 			rte_compressdev_name_get(ctx->ver.mem.dev_id),
 			ctx->ver.mem.dev_id,
-			rte_compressdev_socket_id(ctx->ver.mem.dev_id),
+			rte_compressdev_numa_id(ctx->ver.mem.dev_id),
 			ctx->ver.mem.qp_id);
 
 	/*
diff --git a/app/test-compress-perf/comp_perf_test_throughput.c b/app/test-compress-perf/comp_perf_test_throughput.c
index 089d19c4d4..057e3574bb 100644
--- a/app/test-compress-perf/comp_perf_test_throughput.c
+++ b/app/test-compress-perf/comp_perf_test_throughput.c
@@ -68,9 +68,9 @@ main_loop(struct cperf_benchmark_ctx *ctx, enum rte_comp_xform_type type)
 		return -1;
 	}
 
-	ops = rte_zmalloc_socket(NULL,
+	ops = rte_zmalloc_numa(NULL,
 		2 * mem->total_bufs * sizeof(struct rte_comp_op *),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (ops == NULL) {
 		RTE_LOG(ERR, USER1,
@@ -357,7 +357,7 @@ cperf_throughput_test_runner(void *test_ctx)
 			ctx->ver.options->driver_name,
 			rte_compressdev_name_get(ctx->ver.mem.dev_id),
 			ctx->ver.mem.dev_id,
-			rte_compressdev_socket_id(ctx->ver.mem.dev_id),
+			rte_compressdev_numa_id(ctx->ver.mem.dev_id),
 			ctx->ver.mem.qp_id);
 
 	/*
diff --git a/app/test-compress-perf/comp_perf_test_verify.c b/app/test-compress-perf/comp_perf_test_verify.c
index 66425d7e3c..d7e9fd143c 100644
--- a/app/test-compress-perf/comp_perf_test_verify.c
+++ b/app/test-compress-perf/comp_perf_test_verify.c
@@ -88,9 +88,9 @@ main_loop(struct cperf_verify_ctx *ctx, enum rte_comp_xform_type type)
 	}
 
 
-	ops = rte_zmalloc_socket(NULL,
+	ops = rte_zmalloc_numa(NULL,
 		2 * mem->total_bufs * sizeof(struct rte_comp_op *),
-		0, rte_socket_id());
+		0, rte_numa_id());
 
 	if (ops == NULL) {
 		RTE_LOG(ERR, USER1,
diff --git a/app/test-compress-perf/main.c b/app/test-compress-perf/main.c
index bc2b185da4..eb104d9f04 100644
--- a/app/test-compress-perf/main.c
+++ b/app/test-compress-perf/main.c
@@ -196,7 +196,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *td,
 		cdev_id = enabled_cdevs[i];
 
 		struct rte_compressdev_info cdev_info;
-		int socket_id = rte_compressdev_socket_id(cdev_id);
+		int numa_id = rte_compressdev_numa_id(cdev_id);
 
 		rte_compressdev_info_get(cdev_id, &cdev_info);
 		if (cdev_info.max_nb_queue_pairs &&
@@ -216,7 +216,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *td,
 
 		/* Configure compressdev */
 		struct rte_compressdev_config config = {
-			.socket_id = socket_id,
+			.numa_id = numa_id,
 			.nb_queue_pairs = nb_lcores > td->nb_qps
 					? td->nb_qps : nb_lcores,
 			.max_nb_priv_xforms = NUM_MAX_XFORMS,
@@ -231,7 +231,7 @@ comp_perf_initialize_compressdev(struct comp_test_data *td,
 
 		for (j = 0; j < td->nb_qps; j++) {
 			ret = rte_compressdev_queue_pair_setup(cdev_id, j,
-					NUM_MAX_INFLIGHT_OPS, socket_id);
+					NUM_MAX_INFLIGHT_OPS, numa_id);
 			if (ret < 0) {
 				RTE_LOG(ERR, USER1,
 			      "Failed to setup queue pair %u on compressdev %u",
@@ -291,8 +291,8 @@ comp_perf_dump_input_data(struct comp_test_data *td)
 		goto end;
 	}
 
-	td->input_data = rte_zmalloc_socket(NULL,
-				td->input_data_sz, 0, rte_socket_id());
+	td->input_data = rte_zmalloc_numa(NULL,
+				td->input_data_sz, 0, rte_numa_id());
 
 	if (td->input_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the input "
@@ -375,8 +375,8 @@ comp_perf_dump_dictionary_data(struct comp_test_data *td)
 		goto end;
 	}
 
-	td->dictionary_data = rte_zmalloc_socket(NULL,
-				td->dictionary_data_sz, 0, rte_socket_id());
+	td->dictionary_data = rte_zmalloc_numa(NULL,
+				td->dictionary_data_sz, 0, rte_numa_id());
 
 	if (td->dictionary_data == NULL) {
 		RTE_LOG(ERR, USER1, "Memory to hold the data from the dictionary "
@@ -457,12 +457,12 @@ main(int argc, char **argv)
 	argc -= ret;
 	argv += ret;
 
-	test_data = rte_zmalloc_socket(NULL, sizeof(struct comp_test_data),
-					0, rte_socket_id());
+	test_data = rte_zmalloc_numa(NULL, sizeof(struct comp_test_data),
+					0, rte_numa_id());
 
 	if (test_data == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot reserve memory in socket %d\n",
-				rte_socket_id());
+				rte_numa_id());
 
 	comp_perf_register_cleanup_on_signal();
 
@@ -510,7 +510,7 @@ main(int argc, char **argv)
 	else
 		test_data->level = test_data->level_lst.list[0];
 
-	printf("\nApp uses socket: %u\n", rte_socket_id());
+	printf("\nApp uses socket: %u\n", rte_numa_id());
 	printf("Burst size = %u\n", test_data->burst_sz);
 	printf("Input data size = %zu\n", test_data->input_data_sz);
 	if (test_data->test == CPERF_TEST_TYPE_PMDCC)
-- 
2.55.0

