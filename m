Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE81C87FD2
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0679640B9D;
	Mon, 11 Aug 2025 12:54:39 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id D4F504042E
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:54:33 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c0rzv2W1pz23jnQ;
 Mon, 11 Aug 2025 18:51:55 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C5A31402CC;
 Mon, 11 Aug 2025 18:54:32 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 18:54:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH 3/9] app/dma-perf: use argparse lib to parse argument
Date: Mon, 11 Aug 2025 18:54:24 +0800
Message-ID: <20250811105430.55791-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250811105430.55791-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

This commit uses argparse API to parse arguments.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/main.c      | 91 ++++++++++++++++++++++++-----------
 app/test-dma-perf/meson.build |  2 +-
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 54a5e573fc..ed582b609f 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -12,6 +12,7 @@
 #include <inttypes.h>
 #include <libgen.h>
 
+#include <rte_argparse.h>
 #include <rte_eal.h>
 #include <rte_cfgfile.h>
 #include <rte_string_fns.h>
@@ -45,6 +46,9 @@ static struct test_configure test_cases[MAX_TEST_CASES];
 #define GLOBAL_SECTION_NAME	"GLOBAL"
 static struct global_configure global_cfg;
 
+static char *config_path;
+static char *result_path;
+
 char output_str[MAX_WORKER_NB + 1][MAX_OUTPUT_STR_LEN];
 
 static FILE *fd;
@@ -524,54 +528,83 @@ load_configs(const char *path)
 	return i;
 }
 
-int
-main(int argc, char *argv[])
+static int
+parse_args(int argc, char **argv)
 {
+	static struct rte_argparse obj = {
+		.prog_name = "test-dma-perf",
+		.usage = "[optional parameters]",
+		.descriptor = NULL,
+		.epilog = NULL,
+		.exit_on_error = true,
+		.args = {
+			{ "--config", NULL, "Specify a configuration file",
+			  (void *)&config_path, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR,
+			},
+			{ "--result", NULL, "Optional, specify a result file name",
+			  (void *)&result_path, NULL,
+			  RTE_ARGPARSE_VALUE_REQUIRED, RTE_ARGPARSE_VALUE_TYPE_STR,
+			},
+			ARGPARSE_ARG_END(),
+		},
+	};
+	char rst_path[PATH_MAX + 16] = {0};
 	int ret;
-	uint16_t case_nb;
-	uint32_t i, nb_lcores;
-	pid_t cpid, wpid;
-	int wstatus;
-	char *cfg_path_ptr = NULL;
-	char *rst_path_ptr = NULL;
-	char rst_path[PATH_MAX];
-
-	for (i = 0; i < (uint32_t)argc; i++) {
-		if (strncmp(argv[i], CMDLINE_CONFIG_ARG, MAX_LONG_OPT_SZ) == 0)
-			cfg_path_ptr = argv[i + 1];
-		if (strncmp(argv[i], CMDLINE_RESULT_ARG, MAX_LONG_OPT_SZ) == 0)
-			rst_path_ptr = argv[i + 1];
-	}
-	if (cfg_path_ptr == NULL) {
+
+	ret = rte_argparse_parse(&obj, argc, argv);
+	if (ret < 0)
+		exit(1);
+
+	if (config_path == NULL) {
 		printf("Config file not assigned.\n");
-		return -1;
+		exit(1);
 	}
-	if (rst_path_ptr == NULL) {
-		strlcpy(rst_path, cfg_path_ptr, PATH_MAX);
+
+	if (result_path == NULL) {
+		strlcpy(rst_path, config_path, PATH_MAX);
 		char *token = strtok(basename(rst_path), ".");
 		if (token == NULL) {
 			printf("Config file error.\n");
-			return -1;
+			exit(1);
 		}
 		strcat(token, "_result.csv");
-		rst_path_ptr = rst_path;
+		result_path = strdup(rst_path);
+		if (result_path == NULL) {
+			printf("Generate result file path error.\n");
+			exit(1);
+		}
 	}
-
-	case_nb = load_configs(cfg_path_ptr);
-	fd = fopen(rst_path_ptr, "w");
+	fd = fopen(result_path, "w");
 	if (fd == NULL) {
 		printf("Open output CSV file error.\n");
-		return -1;
+		exit(1);
 	}
 	fclose(fd);
 
+	return 0;
+}
+
+int
+main(int argc, char *argv[])
+{
+	uint32_t i, nb_lcores;
+	pid_t cpid, wpid;
+	uint16_t case_nb;
+	int wstatus;
+	int ret;
+
+	parse_args(argc, argv);
+
+	case_nb = load_configs(config_path);
+
 	printf("Running cases...\n");
 	for (i = 0; i < case_nb; i++) {
 		if (test_cases[i].is_skip) {
 			printf("Test case %d configured to be skipped.\n\n", i + 1);
 			snprintf(output_str[0], MAX_OUTPUT_STR_LEN, "Skip the test-case %d\n",
 				 i + 1);
-			if (open_output_csv(rst_path_ptr))
+			if (open_output_csv(result_path))
 				return 0;
 			continue;
 		}
@@ -579,7 +612,7 @@ main(int argc, char *argv[])
 		if (!test_cases[i].is_valid) {
 			printf("Invalid test case %d.\n\n", i + 1);
 			snprintf(output_str[0], MAX_OUTPUT_STR_LEN, "Invalid case %d\n", i + 1);
-			if (open_output_csv(rst_path_ptr))
+			if (open_output_csv(result_path))
 				return 0;
 			continue;
 		}
@@ -601,7 +634,7 @@ main(int argc, char *argv[])
 				rte_exit(EXIT_FAILURE,
 					"There should be at least 2 worker lcores.\n");
 
-			fd = fopen(rst_path_ptr, "a");
+			fd = fopen(result_path, "a");
 			if (!fd) {
 				printf("Open output CSV file error.\n");
 				return 0;
diff --git a/app/test-dma-perf/meson.build b/app/test-dma-perf/meson.build
index 40d6b7f8e4..02af3128d8 100644
--- a/app/test-dma-perf/meson.build
+++ b/app/test-dma-perf/meson.build
@@ -7,7 +7,7 @@ if is_windows
     subdir_done()
 endif
 
-deps += ['dmadev', 'mbuf', 'cfgfile']
+deps += ['dmadev', 'mbuf', 'cfgfile', 'argparse']
 
 sources = files(
         'main.c',
-- 
2.17.1

