Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A425CAC598
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 03:34:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11B1D4069D;
	Wed, 17 Sep 2025 05:34:10 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id B040B4027A
 for <dev@dpdk.org>; Wed, 17 Sep 2025 05:34:01 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cRPRy6t1Tz1R9Jd;
 Wed, 17 Sep 2025 11:30:54 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B30C1400E8;
 Wed, 17 Sep 2025 11:34:00 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Sep 2025 11:34:00 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v2 10/10] app/dma-perf: support specific error info
Date: Wed, 17 Sep 2025 11:33:56 +0800
Message-ID: <20250917033356.13358-11-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250917033356.13358-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20250917033356.13358-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

If some entry was not provided in section, it will be segment fault
in original impl. For example:
	dpdk-test-dma-perf --config ./config.ini
	config file parsing...
	Segmentation fault (core dumped)

This commit support specific error information, the new output (e.g.):
	dpdk-test-dma-perf --config ./config.ini
	config file parsing...
	Error: can't get entry 'dst_numa_node' in section 'case1'

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/main.c | 67 +++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 97718ad9ee..bc4f0449ec 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -158,6 +158,18 @@ run_test(uint32_t case_id, struct test_configure *case_cfg)
 	}
 }
 
+/* Exit process if the entry couldn't find in the section. */
+static const char *
+get_cfgfile_entry(struct rte_cfgfile *cfgfile, const char *section_name, const char *entry_name)
+{
+	const char *entry = rte_cfgfile_get_entry(cfgfile, section_name, entry_name);
+	if (entry == NULL) {
+		printf("Error: can't get entry '%s' in section '%s'\n", entry_name, section_name);
+		exit(1);
+	}
+	return entry;
+}
+
 static int
 parse_lcore(struct test_configure *test_case, const char *value)
 {
@@ -165,9 +177,6 @@ parse_lcore(struct test_configure *test_case, const char *value)
 	char *input;
 	struct lcore_dma_map_t *lcore_dma_map;
 
-	if (test_case == NULL || value == NULL)
-		return -1;
-
 	len = strlen(value);
 	input = (char *)malloc((len + 1) * sizeof(char));
 	strlcpy(input, value, len + 1);
@@ -195,9 +204,7 @@ static void
 parse_cpu_config(struct test_configure *test_case, int case_id,
 		     struct rte_cfgfile *cfgfile, char *section_name)
 {
-	const char *lcore;
-
-	lcore = rte_cfgfile_get_entry(cfgfile, section_name, "lcore");
+	const char *lcore = get_cfgfile_entry(cfgfile, section_name, "lcore");
 	int lcore_ret = parse_lcore(test_case, lcore);
 	if (lcore_ret < 0) {
 		printf("parse lcore error in case %d.\n", case_id);
@@ -213,9 +220,6 @@ parse_entry(const char *value, struct test_configure_entry *entry)
 	int args_nr = -1;
 	int ret;
 
-	if (value == NULL || entry == NULL)
-		goto out;
-
 	strncpy(input, value, 254);
 	if (*input == '\0')
 		goto out;
@@ -294,7 +298,7 @@ parse_dma_config(struct test_configure *test_case, int case_id,
 	int args_nr;
 	int i;
 
-	ring_size_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_ring_size");
+	ring_size_str = get_cfgfile_entry(cfgfile, section_name, "dma_ring_size");
 	args_nr = parse_entry(ring_size_str, &test_case->ring_size);
 	if (args_nr < 0) {
 		printf("parse error in case %d.\n", case_id);
@@ -305,13 +309,11 @@ parse_dma_config(struct test_configure *test_case, int case_id,
 
 	src_sges_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_src_sge");
 	if (src_sges_str != NULL)
-		test_case->nb_src_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
-						section_name, "dma_src_sge"));
+		test_case->nb_src_sges = (int)atoi(src_sges_str);
 
 	dst_sges_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_dst_sge");
 	if (dst_sges_str != NULL)
-		test_case->nb_dst_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
-						section_name, "dma_dst_sge"));
+		test_case->nb_dst_sges = (int)atoi(dst_sges_str);
 
 	if ((src_sges_str != NULL && dst_sges_str == NULL) ||
 	    (src_sges_str == NULL && dst_sges_str != NULL)) {
@@ -327,7 +329,7 @@ parse_dma_config(struct test_configure *test_case, int case_id,
 		test_case->is_sg = true;
 	}
 
-	kick_batch_str = rte_cfgfile_get_entry(cfgfile, section_name, "kick_batch");
+	kick_batch_str = get_cfgfile_entry(cfgfile, section_name, "kick_batch");
 	args_nr = parse_entry(kick_batch_str, &test_case->kick_batch);
 	if (args_nr < 0) {
 		printf("parse error in case %d.\n", case_id);
@@ -385,11 +387,7 @@ parse_global_config(struct rte_cfgfile *cfgfile)
 		return -1;
 	}
 
-	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "eal_args");
-	if (entry == NULL) {
-		printf("Error: GLOBAL section must have 'eal_args' entry!\n");
-		return -1;
-	}
+	entry = get_cfgfile_entry(cfgfile, GLOBAL_SECTION_NAME, "eal_args");
 	args = strdup(entry);
 	if (args == NULL) {
 		printf("Error: dup GLOBAL 'eal_args' failed!\n");
@@ -401,18 +399,10 @@ parse_global_config(struct rte_cfgfile *cfgfile)
 		global_cfg.eal_argv[i + 1] = tokens[i];
 	global_cfg.eal_argc = i + 1;
 
-	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "cache_flush");
-	if (entry == NULL) {
-		printf("Error: GLOBAL section don't has 'cache_flush' entry!\n");
-		return -1;
-	}
+	entry = get_cfgfile_entry(cfgfile, GLOBAL_SECTION_NAME, "cache_flush");
 	global_cfg.cache_flush = (uint8_t)atoi(entry);
 
-	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "test_seconds");
-	if (entry == NULL) {
-		printf("Error: GLOBAL section don't has 'test_seconds' entry!\n");
-		return -1;
-	}
+	entry = get_cfgfile_entry(cfgfile, GLOBAL_SECTION_NAME, "test_seconds");
 	global_cfg.test_secs = (uint16_t)atoi(entry);
 
 	return 0;
@@ -457,14 +447,7 @@ load_configs(const char *path)
 		}
 
 		test_case->is_valid = true;
-		case_type = rte_cfgfile_get_entry(cfgfile, section_name, "type");
-		if (case_type == NULL) {
-			printf("Error: No case type in case %d, the test will be finished here.\n",
-				i + 1);
-			test_case->is_valid = false;
-			continue;
-		}
-
+		case_type = get_cfgfile_entry(cfgfile, section_name, "type");
 		if (strcmp(case_type, DMA_MEM_COPY) == 0) {
 			test_case->test_type = TEST_TYPE_DMA_MEM_COPY;
 		} else if (strcmp(case_type, CPU_MEM_COPY) == 0) {
@@ -475,12 +458,12 @@ load_configs(const char *path)
 			continue;
 		}
 
-		test_case->src_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
+		test_case->src_numa_node = (int)atoi(get_cfgfile_entry(cfgfile,
 								section_name, "src_numa_node"));
-		test_case->dst_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
+		test_case->dst_numa_node = (int)atoi(get_cfgfile_entry(cfgfile,
 								section_name, "dst_numa_node"));
 		nb_vp = 0;
-		mem_size_str = rte_cfgfile_get_entry(cfgfile, section_name, "mem_size");
+		mem_size_str = get_cfgfile_entry(cfgfile, section_name, "mem_size");
 		args_nr = parse_entry(mem_size_str, &test_case->mem_size);
 		if (args_nr < 0) {
 			printf("parse error in case %d.\n", i + 1);
@@ -489,7 +472,7 @@ load_configs(const char *path)
 		} else if (args_nr == 4)
 			nb_vp++;
 
-		buf_size_str = rte_cfgfile_get_entry(cfgfile, section_name, "buf_size");
+		buf_size_str = get_cfgfile_entry(cfgfile, section_name, "buf_size");
 		args_nr = parse_entry(buf_size_str, &test_case->buf_size);
 		if (args_nr < 0) {
 			printf("parse error in case %d.\n", i + 1);
-- 
2.17.1

