Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D120CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:11:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6929B42E02;
	Mon, 20 Oct 2025 06:11:19 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id B804F4013F
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ag2b4SQUeYX69w7UAkBRdR0GzoX0o3UMS2Q9p8N+X8w=;
 b=32AveCBRz2HSJ41y5pPhnFHGzrhVUDfFNRyJiQy0qfcxgSWkMJpz1NbpYAA3jOWwW4uI/p+o0
 Dp1MlVh92D2+L2h6uSvFHIe15M+dLzoLBbLmiY5iSkeszGuyboIRYp5I4P4JeIKZD1rJGf+T8Iq
 uOwOGP/7cd+vCFSvFR3kzw4=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmn5WQrzLlVc;
 Mon, 20 Oct 2025 12:10:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 025FA1400CB;
 Mon, 20 Oct 2025 12:11:13 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:12 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 04/14] app/dma-perf: refactor output csv
Date: Mon, 20 Oct 2025 12:10:55 +0800
Message-ID: <20251020041105.1590-5-fengchengwen@huawei.com>
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

The original implement involved many functions and global variables,
This commit refactor it.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/benchmark.c |  7 ++-
 app/test-dma-perf/main.c      | 92 +++++++++++++----------------------
 app/test-dma-perf/main.h      |  4 +-
 3 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 4425fc97cf..effd2d9140 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -120,11 +120,11 @@ output_result(struct test_configure *cfg, struct lcore_params *para,
 	printf("Average Bandwidth: %.3lf Gbps, MOps: %.3lf\n", bandwidth, mops);
 
 	if (cfg->is_dma)
-		snprintf(output_str[lcore_id], MAX_OUTPUT_STR_LEN, CSV_LINE_DMA_FMT,
+		output_csv(CSV_LINE_DMA_FMT,
 			scenario_id, lcore_id, dma_name, ring_size, kick_batch, buf_size,
 			nr_buf, memory, ave_cycle, bandwidth, mops);
 	else
-		snprintf(output_str[lcore_id], MAX_OUTPUT_STR_LEN, CSV_LINE_CPU_FMT,
+		output_csv(CSV_LINE_CPU_FMT,
 			scenario_id, lcore_id, buf_size,
 			nr_buf, memory, ave_cycle, bandwidth, mops);
 }
@@ -982,8 +982,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 	}
 	printf("\nAverage Cycles/op per worker: %.1lf, Total Bandwidth: %.3lf Gbps, Total MOps: %.3lf\n",
 		(avg_cycles_total * (float) 1.0) / nb_workers, bandwidth_total, mops_total);
-	snprintf(output_str[MAX_WORKER_NB], MAX_OUTPUT_STR_LEN, CSV_TOTAL_LINE_FMT,
-			cfg->scenario_id, nr_buf, memory * nb_workers,
+	output_csv(CSV_TOTAL_LINE_FMT, cfg->scenario_id, nr_buf, memory * nb_workers,
 			(avg_cycles_total * (float) 1.0) / nb_workers, bandwidth_total, mops_total);
 
 out:
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index c2b8544471..4501e096be 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -44,60 +44,52 @@ static struct global_configure global_cfg;
 static char *config_path;
 static char *result_path;
 
-char output_str[MAX_WORKER_NB + 1][MAX_OUTPUT_STR_LEN];
-
-static FILE *fd;
-
-static void
-output_csv(bool need_blankline)
+__rte_format_printf(1, 2)
+void
+output_csv(const char *fmt, ...)
 {
-	uint32_t i;
+#define MAX_OUTPUT_STR_LEN 512
+	char str[MAX_OUTPUT_STR_LEN] = {0};
+	va_list ap;
+	FILE *fd;
 
-	if (need_blankline) {
-		fprintf(fd, ",,,,,,,,\n");
-		fprintf(fd, ",,,,,,,,\n");
+	fd = fopen(result_path, "a");
+	if (fd == NULL) {
+		printf("Open output CSV file error.\n");
+		return;
 	}
 
-	for (i = 0; i < RTE_DIM(output_str); i++) {
-		if (output_str[i][0]) {
-			fprintf(fd, "%s", output_str[i]);
-			output_str[i][0] = '\0';
-		}
-	}
+	va_start(ap, fmt);
+	vsnprintf(str, MAX_OUTPUT_STR_LEN, fmt, ap);
+	va_end(ap);
+
+	fprintf(fd, "%s", str);
 
 	fflush(fd);
+	fclose(fd);
 }
 
 static void
-output_env_info(void)
+output_blanklines(int lines)
 {
-	snprintf(output_str[0], MAX_OUTPUT_STR_LEN, "Test Environment:\n");
-	snprintf(output_str[1], MAX_OUTPUT_STR_LEN, "CPU frequency,%.3lf Ghz",
-			rte_get_timer_hz() / 1000000000.0);
-
-	output_csv(true);
+	int i;
+	for (i = 0; i < lines; i++)
+		output_csv("%s\n", ",,,,,,,,");
 }
 
 static void
-output_header(uint32_t case_id, struct test_configure *case_cfg)
+output_env_info(void)
 {
-	snprintf(output_str[0], MAX_OUTPUT_STR_LEN,
-			CSV_HDR_FMT, case_id, case_cfg->test_type_str);
-
-	output_csv(true);
+	output_blanklines(2);
+	output_csv("Test Environment:\n"
+		   "CPU frequency,%.3lf Ghz\n", rte_get_timer_hz() / 1000000000.0);
+	output_blanklines(1);
 }
 
-static int
-open_output_csv(const char *rst_path_ptr)
+static void
+output_header(uint32_t case_id, struct test_configure *case_cfg)
 {
-	fd = fopen(rst_path_ptr, "a");
-	if (!fd) {
-		printf("Open output CSV file error.\n");
-		return 1;
-	}
-	output_csv(true);
-	fclose(fd);
-	return 0;
+	output_csv(CSV_HDR_FMT, case_id, case_cfg->test_type_str);
 }
 
 static int
@@ -121,7 +113,6 @@ run_test_case(struct test_configure *case_cfg)
 static void
 run_test(uint32_t case_id, struct test_configure *case_cfg)
 {
-	uint32_t i;
 	uint32_t nb_lcores = rte_lcore_count();
 	struct test_configure_entry *mem_size = &case_cfg->mem_size;
 	struct test_configure_entry *buf_size = &case_cfg->buf_size;
@@ -130,9 +121,6 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
 	struct test_configure_entry dummy = { 0 };
 	struct test_configure_entry *var_entry = &dummy;
 
-	for (i = 0; i < RTE_DIM(output_str); i++)
-		memset(output_str[i], 0, MAX_OUTPUT_STR_LEN);
-
 	if (nb_lcores <= case_cfg->num_worker) {
 		printf("Case %u: Not enough lcores.\n", case_id);
 		return;
@@ -162,8 +150,6 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
 
 		if (run_test_case(case_cfg) < 0)
 			printf("\nTest fails! skipping this scenario.\n");
-		else
-			output_csv(false);
 
 		if (var_entry->op == OP_ADD)
 			var_entry->cur += var_entry->incr;
@@ -556,6 +542,7 @@ parse_args(int argc, char **argv)
 		},
 	};
 	char rst_path[PATH_MAX + 16] = {0};
+	FILE *fd;
 	int ret;
 
 	ret = rte_argparse_parse(&obj, argc, argv);
@@ -608,18 +595,15 @@ main(int argc, char *argv[])
 	for (i = 0; i < case_nb; i++) {
 		if (test_cases[i].is_skip) {
 			printf("Test case %d configured to be skipped.\n\n", i + 1);
-			snprintf(output_str[0], MAX_OUTPUT_STR_LEN, "Skip the test-case %d\n",
-				 i + 1);
-			if (open_output_csv(result_path))
-				return 0;
+			output_blanklines(2);
+			output_csv("Skip the test-case %d\n", i + 1);
 			continue;
 		}
 
 		if (!test_cases[i].is_valid) {
 			printf("Invalid test case %d.\n\n", i + 1);
-			snprintf(output_str[0], MAX_OUTPUT_STR_LEN, "Invalid case %d\n", i + 1);
-			if (open_output_csv(result_path))
-				return 0;
+			output_blanklines(2);
+			output_csv("Invalid case %d\n", i + 1);
 			continue;
 		}
 
@@ -640,12 +624,6 @@ main(int argc, char *argv[])
 				rte_exit(EXIT_FAILURE,
 					"There should be at least 2 worker lcores.\n");
 
-			fd = fopen(result_path, "a");
-			if (!fd) {
-				printf("Open output CSV file error.\n");
-				return 0;
-			}
-
 			output_env_info();
 
 			run_test(i + 1, &test_cases[i]);
@@ -653,8 +631,6 @@ main(int argc, char *argv[])
 			/* clean up the EAL */
 			rte_eal_cleanup();
 
-			fclose(fd);
-
 			printf("\nCase %u completed.\n\n", i + 1);
 
 			exit(EXIT_SUCCESS);
diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index 61e7253ce6..f0e00c3dab 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -11,12 +11,9 @@
 #include <rte_dev.h>
 
 #define MAX_WORKER_NB 128
-#define MAX_OUTPUT_STR_LEN 512
 
 #define MAX_DMA_NB 128
 
-extern char output_str[MAX_WORKER_NB + 1][MAX_OUTPUT_STR_LEN];
-
 typedef enum {
 	OP_NONE = 0,
 	OP_ADD,
@@ -80,6 +77,7 @@ struct global_configure {
 	int   eal_argc;
 };
 
+void output_csv(const char *fmt, ...);
 int mem_copy_benchmark(struct test_configure *cfg);
 
 #endif /* MAIN_H */
-- 
2.17.1

