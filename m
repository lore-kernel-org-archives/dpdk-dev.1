Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28669CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:11:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B21F242E51;
	Mon, 20 Oct 2025 06:11:22 +0200 (CEST)
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by mails.dpdk.org (Postfix) with ESMTP id 6E02F400D5
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=V4ZCPjpUkuQa7KjeCstacNSXfMdzR2P7H1QB+76Armw=;
 b=FjjXQ+WNqPfJB2nCSoLkouDZ4XacToihTSMxVW+xG7DOR/uGxaVwdpCkTVUiPieb8GFYdC2CN
 70CyYkRpiNTZe3A7MCdI1g79Y2MOJkay/Azvhxd7uio8xJADxHjhd/O+jH4sB6eB3s24eifgRG9
 PGWX+ay78O/0Cw/OiFkZyg0=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmR2c8sz12LFQ;
 Mon, 20 Oct 2025 12:10:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id C4E8C1402CA;
 Mon, 20 Oct 2025 12:11:13 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:13 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 07/14] app/dma-perf: remove invalid or redundant field
Date: Mon, 20 Oct 2025 12:10:58 +0800
Message-ID: <20251020041105.1590-8-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251020041105.1590-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251020041105.1590-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Remove invalid or redundant fields to make code more clean.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/benchmark.c | 19 +++++++++----------
 app/test-dma-perf/main.c      | 21 +++++----------------
 app/test-dma-perf/main.h      | 12 ++++++------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index a3e530a665..c0a6e3d4d7 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -104,7 +104,7 @@ output_result(struct test_configure *cfg, struct lcore_params *para,
 	uint32_t lcore_id = para->lcore_id;
 	char *dma_name = para->dma_name;
 
-	if (cfg->is_dma) {
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
 		printf("lcore %u, DMA %s, DMA Ring Size: %u, Kick Batch Size: %u", lcore_id,
 		       dma_name, ring_size, kick_batch);
 		if (cfg->is_sg)
@@ -119,7 +119,7 @@ output_result(struct test_configure *cfg, struct lcore_params *para,
 			ave_cycle, buf_size, nr_buf, memory, rte_get_timer_hz()/1000000000.0);
 	printf("Average Bandwidth: %.3lf Gbps, MOps: %.3lf\n", bandwidth, mops);
 
-	if (cfg->is_dma)
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY)
 		output_csv(CSV_LINE_DMA_FMT,
 			scenario_id, lcore_id, dma_name, ring_size, kick_batch, buf_size,
 			nr_buf, memory, ave_cycle, bandwidth, mops);
@@ -502,14 +502,14 @@ dummy_free_ext_buf(void *addr, void *opaque)
 }
 
 static int
-setup_memory_env(struct test_configure *cfg, struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
+setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
+			 struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
 		 struct rte_dma_sge **src_sges, struct rte_dma_sge **dst_sges,
 		 struct rte_dma_op ***dma_ops)
 {
 	unsigned int cur_buf_size = cfg->buf_size.cur;
 	unsigned int buf_size = cur_buf_size + RTE_PKTMBUF_HEADROOM;
 	bool is_src_numa_incorrect, is_dst_numa_incorrect;
-	uint32_t nr_buf = cfg->nr_buf;
 	unsigned int nr_sockets;
 	uintptr_t ops;
 	uint32_t i;
@@ -674,7 +674,7 @@ get_work_function(struct test_configure *cfg)
 {
 	lcore_function_t *fn;
 
-	if (cfg->is_dma) {
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
 		if (!cfg->is_sg)
 			fn = do_dma_plain_mem_copy;
 		else {
@@ -794,12 +794,11 @@ mem_copy_benchmark(struct test_configure *cfg)
 	int ret = 0;
 
 	nr_buf = align_buffer_count(cfg, &nr_sgsrc, &nr_sgdst);
-	cfg->nr_buf = nr_buf;
 
-	if (setup_memory_env(cfg, &srcs, &dsts, &src_sges, &dst_sges, &dma_ops) < 0)
+	if (setup_memory_env(cfg, nr_buf, &srcs, &dsts, &src_sges, &dst_sges, &dma_ops) < 0)
 		goto out;
 
-	if (cfg->is_dma)
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY)
 		if (config_dmadevs(cfg) < 0)
 			goto out;
 
@@ -822,7 +821,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 			printf("lcore parameters malloc failure for lcore %d\n", lcore_id);
 			break;
 		}
-		if (cfg->is_dma) {
+		if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
 			lcores[i]->dma_name = lcore_dma_map->dma_names;
 			lcores[i]->dev_id = lcore_dma_map->dma_id;
 			lcores[i]->kick_batch = kick_batch;
@@ -1040,7 +1039,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 		lcores[i] = NULL;
 	}
 
-	if (cfg->is_dma) {
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
 		for (i = 0; i < nb_workers; i++) {
 			lcore_dma_map = &cfg->dma_config[i].lcore_dma_map;
 			printf("Stopping dmadev %d\n", lcore_dma_map->dma_id);
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 7615c62951..9816b3ae06 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -29,12 +29,6 @@
 
 #define MAX_PARAMS_PER_ENTRY 4
 
-enum {
-	TEST_TYPE_NONE = 0,
-	TEST_TYPE_DMA_MEM_COPY,
-	TEST_TYPE_CPU_MEM_COPY
-};
-
 #define MAX_TEST_CASES 16
 static struct test_configure test_cases[MAX_TEST_CASES];
 
@@ -90,7 +84,8 @@ output_env_info(void)
 static void
 output_header(uint32_t case_id, struct test_configure *case_cfg)
 {
-	output_csv(CSV_HDR_FMT, case_id, case_cfg->test_type_str);
+	static const char * const type_str[] = { "NONE", DMA_MEM_COPY, CPU_MEM_COPY };
+	output_csv(CSV_HDR_FMT, case_id, type_str[case_cfg->test_type]);
 }
 
 static int
@@ -104,7 +99,7 @@ run_test_case(struct test_configure *case_cfg)
 		ret = mem_copy_benchmark(case_cfg);
 		break;
 	default:
-		printf("Unknown test type. %s\n", case_cfg->test_type_str);
+		printf("Unknown test type\n");
 		break;
 	}
 
@@ -338,7 +333,6 @@ load_configs(const char *path)
 	const char *skip;
 	struct rte_kvargs *kvlist;
 	int args_nr, nb_vp;
-	bool is_dma;
 
 	printf("config file parsing...\n");
 	cfgfile = rte_cfgfile_load(path, 0);
@@ -376,19 +370,15 @@ load_configs(const char *path)
 
 		if (strcmp(case_type, DMA_MEM_COPY) == 0) {
 			test_case->test_type = TEST_TYPE_DMA_MEM_COPY;
-			test_case->test_type_str = DMA_MEM_COPY;
-			is_dma = true;
 		} else if (strcmp(case_type, CPU_MEM_COPY) == 0) {
 			test_case->test_type = TEST_TYPE_CPU_MEM_COPY;
-			test_case->test_type_str = CPU_MEM_COPY;
-			is_dma = false;
 		} else {
 			printf("Error: Wrong test case type %s in case%d.\n", case_type, i + 1);
 			test_case->is_valid = false;
 			continue;
 		}
 
-		if (is_dma) {
+		if (test_case->test_type == TEST_TYPE_DMA_MEM_COPY) {
 			use_dma_ops =
 				rte_cfgfile_get_entry(cfgfile, section_name, "use_enq_deq_ops");
 			if (use_dma_ops != NULL && (atoi(use_dma_ops) == 1))
@@ -397,7 +387,6 @@ load_configs(const char *path)
 				test_case->use_ops = false;
 		}
 
-		test_case->is_dma = is_dma;
 		test_case->src_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
 								section_name, "src_numa_node"));
 		test_case->dst_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
@@ -421,7 +410,7 @@ load_configs(const char *path)
 		} else if (args_nr == 4)
 			nb_vp++;
 
-		if (is_dma) {
+		if (test_case->test_type == TEST_TYPE_DMA_MEM_COPY) {
 			ring_size_str = rte_cfgfile_get_entry(cfgfile, section_name,
 								"dma_ring_size");
 			args_nr = parse_entry(ring_size_str, &test_case->ring_size);
diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index 11a07e57e7..25f32b72f7 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -12,7 +12,11 @@
 
 #define MAX_WORKER_NB 128
 
-#define MAX_DMA_NB 128
+enum {
+	TEST_TYPE_NONE = 0,
+	TEST_TYPE_DMA_MEM_COPY,
+	TEST_TYPE_CPU_MEM_COPY
+};
 
 typedef enum {
 	OP_NONE = 0,
@@ -49,12 +53,8 @@ struct test_configure {
 	bool is_valid;
 	bool is_skip;
 	uint8_t test_type;
-	const char *test_type_str;
 	uint16_t src_numa_node;
 	uint16_t dst_numa_node;
-	uint16_t opcode;
-	bool is_dma;
-	bool is_sg;
 	bool use_ops;
 	struct lcore_dma_config dma_config[MAX_WORKER_NB];
 	struct test_configure_entry mem_size;
@@ -64,7 +64,7 @@ struct test_configure {
 	uint16_t num_worker;
 	uint8_t nb_src_sges;
 	uint8_t nb_dst_sges;
-	uint32_t nr_buf;
+	bool is_sg;
 	uint8_t scenario_id;
 };
 
-- 
2.17.1

