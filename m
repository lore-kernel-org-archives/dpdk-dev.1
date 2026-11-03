Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2758606A33D
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wwI6cAB9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8227042F76;
	Tue,  3 Nov 2026 16:20:54 +0100 (CET)
Received: from mta1.migadu.com (out-202.mta1.migadu.com [95.215.58.202])
 by mails.dpdk.org (Postfix) with ESMTPS id 7933B42F9F
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:20:52 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=jbgIVGTdILqakgxTe7XQ15XuCmlb+LJtv7kW+1C5bwo=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793719252; v=1; x=1794324052;
 b=wwI6cAB9ygUdCNtgKDk1Wtdywx8hi1jP4y5bgX/OVbSZRaN1JYe6SEctAQ1jdg8Vgalj3qoC
 b2OREFY7YCN5ul/aHMH/wBXw3GwD7KqpYHV2WUm8xjhfFZdvoaERl5mFf4cErtdunYkYhRMu3fo
 SQqfsdCH2DF29CXKuNsnhHeM=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id b84c4361e3e80b6c;
 Tue, 03 Nov 2026 15:20:52 +0000
X-Mizu-Trace-ID: b84c4361e3e80b6c
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 176/227] app/test-mldev: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:52:14 +0800
Message-ID: <20261103145306.487255-177-chengwen.feng@linux.dev>
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
 app/test-mldev/ml_options.c            | 14 +++++++-------
 app/test-mldev/ml_options.h            |  4 ++--
 app/test-mldev/test_common.c           | 10 +++++-----
 app/test-mldev/test_device_ops.c       | 10 +++++-----
 app/test-mldev/test_inference_common.c | 26 +++++++++++++-------------
 app/test-mldev/test_model_ops.c        |  4 ++--
 6 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/app/test-mldev/ml_options.c b/app/test-mldev/ml_options.c
index 320f6325ae..b3c2c868c6 100644
--- a/app/test-mldev/ml_options.c
+++ b/app/test-mldev/ml_options.c
@@ -22,7 +22,7 @@ ml_options_default(struct ml_options *opt)
 	memset(opt, 0, sizeof(*opt));
 	strlcpy(opt->test_name, "device_ops", ML_TEST_NAME_MAX_LEN);
 	opt->dev_id = 0;
-	opt->socket_id = SOCKET_ID_ANY;
+	opt->numa_id = RTE_NUMA_ID_ANY;
 	opt->nb_filelist = 0;
 	opt->quantized_io = false;
 	opt->repetitions = 1;
@@ -64,9 +64,9 @@ ml_parse_socket_id(struct ml_options *opt, const char *arg)
 {
 	int ret;
 
-	ret = parser_read_int32(&opt->socket_id, arg);
+	ret = parser_read_int32(&opt->numa_id, arg);
 	if (ret < 0)
-		ml_err("Invalid option: socket_id = %s\n", arg);
+		ml_err("Invalid option: numa_id = %s\n", arg);
 
 	return ret;
 }
@@ -257,7 +257,7 @@ print_usage(char *program)
 	printf("application options:\n");
 	printf("\t--test             : name of the test application to run\n"
 	       "\t--dev_id           : device id of the ML device\n"
-	       "\t--socket_id        : socket_id of application resources\n"
+	       "\t--numa_id        : numa_id of application resources\n"
 	       "\t--debug            : enable debug mode\n"
 	       "\t--help             : print help\n");
 	printf("\n");
@@ -362,10 +362,10 @@ ml_options_dump(struct ml_options *opt)
 	ml_dump("test", "%s", opt->test_name);
 	ml_dump("dev_id", "%d", opt->dev_id);
 
-	if (opt->socket_id == SOCKET_ID_ANY)
-		ml_dump("socket_id", "%d (SOCKET_ID_ANY)", opt->socket_id);
+	if (opt->numa_id == RTE_NUMA_ID_ANY)
+		ml_dump("numa_id", "%d (RTE_NUMA_ID_ANY)", opt->numa_id);
 	else
-		ml_dump("socket_id", "%d", opt->socket_id);
+		ml_dump("numa_id", "%d", opt->numa_id);
 
 	ml_dump("debug", "%s", (opt->debug ? "true" : "false"));
 	ml_dump("quantized_io", "%s", (opt->quantized_io ? "true" : "false"));
diff --git a/app/test-mldev/ml_options.h b/app/test-mldev/ml_options.h
index edb9dba8f7..5dde5e69cd 100644
--- a/app/test-mldev/ml_options.h
+++ b/app/test-mldev/ml_options.h
@@ -14,7 +14,7 @@
 /* Options names */
 #define ML_TEST		("test")
 #define ML_DEVICE_ID	("dev_id")
-#define ML_SOCKET_ID	("socket_id")
+#define ML_SOCKET_ID	("numa_id")
 #define ML_MODELS	("models")
 #define ML_FILELIST	("filelist")
 #define ML_QUANTIZED_IO ("quantized_io")
@@ -37,7 +37,7 @@ struct ml_filelist {
 struct ml_options {
 	char test_name[ML_TEST_NAME_MAX_LEN];
 	int16_t dev_id;
-	int socket_id;
+	int numa_id;
 	struct ml_filelist filelist[ML_TEST_MAX_MODELS];
 	uint8_t nb_filelist;
 	uint64_t repetitions;
diff --git a/app/test-mldev/test_common.c b/app/test-mldev/test_common.c
index 2f5e6156cf..024fc31ba9 100644
--- a/app/test-mldev/test_common.c
+++ b/app/test-mldev/test_common.c
@@ -86,7 +86,7 @@ int
 ml_test_opt_check(struct ml_options *opt)
 {
 	uint16_t dev_count;
-	int socket_id;
+	int numa_id;
 
 	RTE_SET_USED(opt);
 
@@ -101,9 +101,9 @@ ml_test_opt_check(struct ml_options *opt)
 		return -EINVAL;
 	}
 
-	socket_id = rte_ml_dev_numa_id(opt->dev_id);
-	if ((opt->socket_id != SOCKET_ID_ANY) && (opt->socket_id != socket_id)) {
-		ml_err("Invalid option, socket_id = %d\n", opt->socket_id);
+	numa_id = rte_ml_dev_numa_id(opt->dev_id);
+	if ((opt->numa_id != RTE_NUMA_ID_ANY) && (opt->numa_id != numa_id)) {
+		ml_err("Invalid option, numa_id = %d\n", opt->numa_id);
 		return -EINVAL;
 	}
 
@@ -140,7 +140,7 @@ ml_test_device_configure(struct ml_test *test, struct ml_options *opt)
 	}
 
 	/* configure device */
-	dev_config.numa_id = opt->socket_id;
+	dev_config.numa_id = opt->numa_id;
 	dev_config.nb_models = t->dev_info.max_models;
 	dev_config.nb_queue_pairs = opt->queue_pairs;
 	ret = rte_ml_dev_configure(opt->dev_id, &dev_config);
diff --git a/app/test-mldev/test_device_ops.c b/app/test-mldev/test_device_ops.c
index 6111bb106b..18f4e154aa 100644
--- a/app/test-mldev/test_device_ops.c
+++ b/app/test-mldev/test_device_ops.c
@@ -47,8 +47,8 @@ test_device_setup(struct ml_test *test, struct ml_options *opt)
 	int ret = 0;
 
 	/* allocate for test structure */
-	test_device = rte_zmalloc_socket(test->name, sizeof(struct test_device),
-					 RTE_CACHE_LINE_SIZE, opt->socket_id);
+	test_device = rte_zmalloc_numa(test->name, sizeof(struct test_device),
+					 RTE_CACHE_LINE_SIZE, opt->numa_id);
 	if (test_device == NULL) {
 		ml_err("failed to allocate memory for test_model");
 		ret = -ENOMEM;
@@ -107,7 +107,7 @@ test_device_reconfigure(struct ml_test *test, struct ml_options *opt)
 		qp_conf.nb_desc = opt->queue_size;
 		qp_conf.cb = NULL;
 
-		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->socket_id);
+		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->numa_id);
 		if (ret != 0) {
 			ml_err("Failed to setup ML device queue-pair, dev_id = %d, qp_id = %u\n",
 			       opt->dev_id, qp_id);
@@ -128,7 +128,7 @@ test_device_reconfigure(struct ml_test *test, struct ml_options *opt)
 	}
 
 	/* reconfigure device based on dev_info */
-	dev_config.numa_id = opt->socket_id;
+	dev_config.numa_id = opt->numa_id;
 	dev_config.nb_models = t->cmn.dev_info.max_models;
 	dev_config.nb_queue_pairs = t->cmn.dev_info.max_queue_pairs;
 	ret = rte_ml_dev_configure(opt->dev_id, &dev_config);
@@ -142,7 +142,7 @@ test_device_reconfigure(struct ml_test *test, struct ml_options *opt)
 		qp_conf.nb_desc = t->cmn.dev_info.max_desc;
 		qp_conf.cb = NULL;
 
-		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->socket_id);
+		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->numa_id);
 		if (ret != 0) {
 			ml_err("Failed to setup ML device queue-pair, dev_id = %d, qp_id = %u\n",
 			       opt->dev_id, qp_id);
diff --git a/app/test-mldev/test_inference_common.c b/app/test-mldev/test_inference_common.c
index 3b77f37010..a1826a0853 100644
--- a/app/test-mldev/test_inference_common.c
+++ b/app/test-mldev/test_inference_common.c
@@ -531,8 +531,8 @@ test_inference_setup(struct ml_test *test, struct ml_options *opt)
 	int ret = 0;
 	uint32_t i;
 
-	test_inference = rte_zmalloc_socket(test->name, sizeof(struct test_inference),
-					    RTE_CACHE_LINE_SIZE, opt->socket_id);
+	test_inference = rte_zmalloc_numa(test->name, sizeof(struct test_inference),
+					    RTE_CACHE_LINE_SIZE, opt->numa_id);
 	if (test_inference == NULL) {
 		ml_err("failed to allocate memory for test_model");
 		ret = -ENOMEM;
@@ -567,15 +567,15 @@ test_inference_setup(struct ml_test *test, struct ml_options *opt)
 		t->model[i].state = MODEL_INITIAL;
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		t->args[lcore_id].enq_ops = rte_zmalloc_socket(
+		t->args[lcore_id].enq_ops = rte_zmalloc_numa(
 			"ml_test_enq_ops", opt->burst_size * sizeof(struct rte_ml_op *),
-			RTE_CACHE_LINE_SIZE, opt->socket_id);
-		t->args[lcore_id].deq_ops = rte_zmalloc_socket(
+			RTE_CACHE_LINE_SIZE, opt->numa_id);
+		t->args[lcore_id].deq_ops = rte_zmalloc_numa(
 			"ml_test_deq_ops", opt->burst_size * sizeof(struct rte_ml_op *),
-			RTE_CACHE_LINE_SIZE, opt->socket_id);
-		t->args[lcore_id].reqs = rte_zmalloc_socket(
+			RTE_CACHE_LINE_SIZE, opt->numa_id);
+		t->args[lcore_id].reqs = rte_zmalloc_numa(
 			"ml_test_requests", opt->burst_size * sizeof(struct ml_request *),
-			RTE_CACHE_LINE_SIZE, opt->socket_id);
+			RTE_CACHE_LINE_SIZE, opt->numa_id);
 	}
 
 	for (i = 0; i < RTE_MAX_LCORE; i++) {
@@ -634,7 +634,7 @@ ml_inference_mldev_setup(struct ml_test *test, struct ml_options *opt)
 		qp_conf.nb_desc = opt->queue_size;
 		qp_conf.cb = NULL;
 
-		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->socket_id);
+		ret = rte_ml_dev_queue_pair_setup(opt->dev_id, qp_id, &qp_conf, opt->numa_id);
 		if (ret != 0) {
 			ml_err("Failed to setup ml device queue-pair, dev_id = %d, qp_id = %u\n",
 			       opt->dev_id, qp_id);
@@ -800,7 +800,7 @@ ml_inference_iomem_setup(struct ml_test *test, struct ml_options *opt, uint16_t
 		mz_size += t->model[fid].out_dsize;
 
 	sprintf(mz_name, "ml_user_data_%d", fid);
-	mz = rte_memzone_reserve(mz_name, mz_size, opt->socket_id, 0);
+	mz = rte_memzone_reserve(mz_name, mz_size, opt->numa_id, 0);
 	if (mz == NULL) {
 		ml_err("Memzone allocation failed for ml_user_data\n");
 		ret = -ENOMEM;
@@ -860,7 +860,7 @@ ml_inference_iomem_setup(struct ml_test *test, struct ml_options *opt, uint16_t
 	t->fid = fid;
 	sprintf(mp_name, "ml_io_pool_%d", fid);
 	t->model[fid].io_pool = rte_mempool_create(mp_name, nb_buffers, buff_size, 0, 0, NULL, NULL,
-						   ml_request_initialize, test, opt->socket_id, 0);
+						   ml_request_initialize, test, opt->numa_id, 0);
 	if (t->model[fid].io_pool == NULL) {
 		ml_err("Failed to create io pool : %s\n", "ml_io_pool");
 		ret = -ENOMEM;
@@ -909,7 +909,7 @@ ml_inference_mem_setup(struct ml_test *test, struct ml_options *opt)
 
 	/* create op pool */
 	t->op_pool = rte_ml_op_pool_create("ml_test_op_pool", ML_TEST_MAX_POOL_SIZE, 0, 0,
-					   opt->socket_id);
+					   opt->numa_id);
 	if (t->op_pool == NULL) {
 		ml_err("Failed to create op pool : %s\n", "ml_op_pool");
 		return -ENOMEM;
@@ -920,7 +920,7 @@ ml_inference_mem_setup(struct ml_test *test, struct ml_options *opt)
 	 */
 	t->buf_seg_pool = rte_mempool_create("ml_test_mbuf_pool", ML_TEST_MAX_POOL_SIZE * 2,
 					     sizeof(struct rte_ml_buff_seg), 0, 0, NULL, NULL, NULL,
-					     NULL, opt->socket_id, 0);
+					     NULL, opt->numa_id, 0);
 	if (t->buf_seg_pool == NULL) {
 		ml_err("Failed to create buf_segs pool : %s\n", "ml_test_mbuf_pool");
 		rte_ml_op_pool_free(t->op_pool);
diff --git a/app/test-mldev/test_model_ops.c b/app/test-mldev/test_model_ops.c
index b2e875907a..3119ae6733 100644
--- a/app/test-mldev/test_model_ops.c
+++ b/app/test-mldev/test_model_ops.c
@@ -73,8 +73,8 @@ test_model_ops_setup(struct ml_test *test, struct ml_options *opt)
 	uint32_t i;
 
 	/* allocate model ops test structure */
-	test_model_ops = rte_zmalloc_socket(test->name, sizeof(struct test_model_ops),
-					    RTE_CACHE_LINE_SIZE, opt->socket_id);
+	test_model_ops = rte_zmalloc_numa(test->name, sizeof(struct test_model_ops),
+					    RTE_CACHE_LINE_SIZE, opt->numa_id);
 	if (test_model_ops == NULL) {
 		ml_err("Failed to allocate memory for test_model");
 		ret = -ENOMEM;
-- 
2.55.0

