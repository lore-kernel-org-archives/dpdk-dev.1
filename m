Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B94ACCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2458D42E6C;
	Mon, 20 Oct 2025 06:11:28 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id ABC6C402A7
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=l19cgzWYUlBJE0nPuuC+jFc7XSwGB3u76W/mUQI24LE=;
 b=k860d1a3bwtaEi00d6zCRlPFQnPv+Rh56HdfYtMbEgA2bJyQZ1Ph7fral3+B7aW92zbKkqrO3
 1TK9xx/HvyeVwrJVmu9Sy/HaY6K5fn4LN0oXvUygQz0/W8bbh51beCjg/Cqj3+Vi8ozfbqoeCYu
 GJHp/PetVCPYhsoM8QKiH4E=
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmG6k7Fz1T4FV;
 Mon, 20 Oct 2025 12:10:22 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 1060A140257;
 Mon, 20 Oct 2025 12:11:14 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:13 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 08/14] app/dma-perf: refactor load config function
Date: Mon, 20 Oct 2025 12:10:59 +0800
Message-ID: <20251020041105.1590-9-fengchengwen@huawei.com>
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

The load_configs() function has 198 lines, and hard to understand.
This commit split it to three functions.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/main.c | 224 +++++++++++++++++++--------------------
 1 file changed, 112 insertions(+), 112 deletions(-)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 9816b3ae06..06ab99e0e4 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -191,6 +191,20 @@ parse_lcore(struct test_configure *test_case, const char *value)
 	return 0;
 }
 
+static void
+parse_cpu_config(struct test_configure *test_case, int case_id,
+		     struct rte_cfgfile *cfgfile, char *section_name)
+{
+	const char *lcore;
+
+	lcore = rte_cfgfile_get_entry(cfgfile, section_name, "lcore");
+	int lcore_ret = parse_lcore(test_case, lcore);
+	if (lcore_ret < 0) {
+		printf("parse lcore error in case %d.\n", case_id);
+		test_case->is_valid = false;
+	}
+}
+
 static int
 parse_entry(const char *value, struct test_configure_entry *entry)
 {
@@ -269,6 +283,94 @@ static int populate_dma_dev_config(const char *key, const char *value, void *tes
 	return ret;
 }
 
+static void
+parse_dma_config(struct test_configure *test_case, int case_id,
+		     struct rte_cfgfile *cfgfile, char *section_name, int *nb_vp)
+{
+	const char *ring_size_str, *kick_batch_str, *src_sges_str, *dst_sges_str, *use_dma_ops;
+	char lc_dma[RTE_DEV_NAME_MAX_LEN];
+	struct rte_kvargs *kvlist;
+	const char *lcore_dma;
+	int args_nr;
+	int i;
+
+	use_dma_ops = rte_cfgfile_get_entry(cfgfile, section_name, "use_enq_deq_ops");
+	test_case->use_ops = (use_dma_ops != NULL && (atoi(use_dma_ops) == 1));
+
+	ring_size_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_ring_size");
+	args_nr = parse_entry(ring_size_str, &test_case->ring_size);
+	if (args_nr < 0) {
+		printf("parse error in case %d.\n", case_id);
+		test_case->is_valid = false;
+		return;
+	} else if (args_nr == 4)
+		*nb_vp += 1;
+
+	src_sges_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_src_sge");
+	if (src_sges_str != NULL)
+		test_case->nb_src_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
+						section_name, "dma_src_sge"));
+
+	dst_sges_str = rte_cfgfile_get_entry(cfgfile, section_name, "dma_dst_sge");
+	if (dst_sges_str != NULL)
+		test_case->nb_dst_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
+						section_name, "dma_dst_sge"));
+
+	if ((src_sges_str != NULL && dst_sges_str == NULL) ||
+	    (src_sges_str == NULL && dst_sges_str != NULL)) {
+		printf("parse dma_src_sge, dma_dst_sge error in case %d.\n", case_id);
+		test_case->is_valid = false;
+		return;
+	} else if (src_sges_str != NULL && dst_sges_str != NULL) {
+		if (test_case->nb_src_sges == 0 || test_case->nb_dst_sges == 0) {
+			printf("dma_src_sge and dma_dst_sge can not be 0 in case %d.\n", case_id);
+			test_case->is_valid = false;
+			return;
+		}
+		test_case->is_sg = true;
+	}
+
+	kick_batch_str = rte_cfgfile_get_entry(cfgfile, section_name, "kick_batch");
+	args_nr = parse_entry(kick_batch_str, &test_case->kick_batch);
+	if (args_nr < 0) {
+		printf("parse error in case %d.\n", case_id);
+		test_case->is_valid = false;
+		return;
+	} else if (args_nr == 4)
+		*nb_vp += 1;
+
+	i = 0;
+	while (1) {
+		snprintf(lc_dma, RTE_DEV_NAME_MAX_LEN, "lcore_dma%d", i);
+		lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, lc_dma);
+		if (lcore_dma == NULL)
+			break;
+
+		kvlist = rte_kvargs_parse(lcore_dma, NULL);
+		if (kvlist == NULL) {
+			printf("rte_kvargs_parse() error");
+			test_case->is_valid = false;
+			break;
+		}
+
+		if (rte_kvargs_process(kvlist, NULL, populate_dma_dev_config,
+				       (void *)&test_case->dma_config[i]) < 0) {
+			printf("rte_kvargs_process() error\n");
+			rte_kvargs_free(kvlist);
+			test_case->is_valid = false;
+			break;
+		}
+		i++;
+		test_case->num_worker++;
+		rte_kvargs_free(kvlist);
+	}
+
+	if (test_case->num_worker == 0) {
+		printf("Error: Parsing %s Failed\n", lc_dma);
+		test_case->is_valid = false;
+	}
+}
+
 static int
 parse_global_config(struct rte_cfgfile *cfgfile)
 {
@@ -322,17 +424,14 @@ parse_global_config(struct rte_cfgfile *cfgfile)
 static uint16_t
 load_configs(const char *path)
 {
-	struct rte_cfgfile *cfgfile;
-	int nb_sections, i;
+	const char *mem_size_str, *buf_size_str;
 	struct test_configure *test_case;
 	char section_name[CFG_NAME_LEN];
+	struct rte_cfgfile *cfgfile;
 	const char *case_type;
-	const char *lcore_dma;
-	const char *mem_size_str, *buf_size_str, *ring_size_str, *kick_batch_str,
-		*src_sges_str, *dst_sges_str, *use_dma_ops;
-	const char *skip;
-	struct rte_kvargs *kvlist;
+	int nb_sections, i;
 	int args_nr, nb_vp;
+	const char *skip;
 
 	printf("config file parsing...\n");
 	cfgfile = rte_cfgfile_load(path, 0);
@@ -360,6 +459,7 @@ load_configs(const char *path)
 			continue;
 		}
 
+		test_case->is_valid = true;
 		case_type = rte_cfgfile_get_entry(cfgfile, section_name, "type");
 		if (case_type == NULL) {
 			printf("Error: No case type in case %d, the test will be finished here.\n",
@@ -378,15 +478,6 @@ load_configs(const char *path)
 			continue;
 		}
 
-		if (test_case->test_type == TEST_TYPE_DMA_MEM_COPY) {
-			use_dma_ops =
-				rte_cfgfile_get_entry(cfgfile, section_name, "use_enq_deq_ops");
-			if (use_dma_ops != NULL && (atoi(use_dma_ops) == 1))
-				test_case->use_ops = true;
-			else
-				test_case->use_ops = false;
-		}
-
 		test_case->src_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
 								section_name, "src_numa_node"));
 		test_case->dst_numa_node = (int)atoi(rte_cfgfile_get_entry(cfgfile,
@@ -410,108 +501,17 @@ load_configs(const char *path)
 		} else if (args_nr == 4)
 			nb_vp++;
 
-		if (test_case->test_type == TEST_TYPE_DMA_MEM_COPY) {
-			ring_size_str = rte_cfgfile_get_entry(cfgfile, section_name,
-								"dma_ring_size");
-			args_nr = parse_entry(ring_size_str, &test_case->ring_size);
-			if (args_nr < 0) {
-				printf("parse error in case %d.\n", i + 1);
-				test_case->is_valid = false;
-				continue;
-			} else if (args_nr == 4)
-				nb_vp++;
-
-			src_sges_str = rte_cfgfile_get_entry(cfgfile, section_name,
-								"dma_src_sge");
-			if (src_sges_str != NULL) {
-				test_case->nb_src_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
-								section_name, "dma_src_sge"));
-			}
-
-			dst_sges_str = rte_cfgfile_get_entry(cfgfile, section_name,
-								"dma_dst_sge");
-			if (dst_sges_str != NULL) {
-				test_case->nb_dst_sges = (int)atoi(rte_cfgfile_get_entry(cfgfile,
-								section_name, "dma_dst_sge"));
-			}
-
-			if ((src_sges_str != NULL && dst_sges_str == NULL) ||
-			    (src_sges_str == NULL && dst_sges_str != NULL)) {
-				printf("parse dma_src_sge, dma_dst_sge error in case %d.\n",
-					i + 1);
-				test_case->is_valid = false;
-				continue;
-			} else if (src_sges_str != NULL && dst_sges_str != NULL) {
-				test_case->is_sg = true;
-
-				if (test_case->nb_src_sges == 0 || test_case->nb_dst_sges == 0) {
-					printf("dma_src_sge and dma_dst_sge can not be 0 in case %d.\n",
-						i + 1);
-					test_case->is_valid = false;
-					continue;
-				}
-			} else {
-				test_case->is_sg = false;
-			}
-
-			kick_batch_str = rte_cfgfile_get_entry(cfgfile, section_name, "kick_batch");
-			args_nr = parse_entry(kick_batch_str, &test_case->kick_batch);
-			if (args_nr < 0) {
-				printf("parse error in case %d.\n", i + 1);
-				test_case->is_valid = false;
-				continue;
-			} else if (args_nr == 4)
-				nb_vp++;
-
-			char lc_dma[RTE_DEV_NAME_MAX_LEN];
-			int i = 0;
-			while (1) {
-				snprintf(lc_dma, RTE_DEV_NAME_MAX_LEN, "lcore_dma%d", i);
-				lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, lc_dma);
-				if (lcore_dma == NULL)
-					break;
-
-				kvlist = rte_kvargs_parse(lcore_dma, NULL);
-				if (kvlist == NULL) {
-					printf("rte_kvargs_parse() error");
-					test_case->is_valid = false;
-					break;
-				}
-
-				if (rte_kvargs_process(kvlist, NULL, populate_dma_dev_config,
-						       (void *)&test_case->dma_config[i]) < 0) {
-					printf("rte_kvargs_process() error\n");
-					rte_kvargs_free(kvlist);
-					test_case->is_valid = false;
-					break;
-				}
-				i++;
-				test_case->num_worker++;
-				rte_kvargs_free(kvlist);
-			}
+		if (test_case->test_type == TEST_TYPE_DMA_MEM_COPY)
+			parse_dma_config(test_case, i + 1, cfgfile, section_name, &nb_vp);
+		else
+			parse_cpu_config(test_case, i + 1, cfgfile, section_name);
 
-			if (test_case->num_worker == 0) {
-				printf("Error: Parsing %s Failed\n", lc_dma);
-				continue;
-			}
-		} else {
-			lcore_dma = rte_cfgfile_get_entry(cfgfile, section_name, "lcore");
-			int lcore_ret = parse_lcore(test_case, lcore_dma);
-			if (lcore_ret < 0) {
-				printf("parse lcore error in case %d.\n", i + 1);
-				test_case->is_valid = false;
-				continue;
-			}
-		}
-
-		if (nb_vp > 1) {
+		if (test_case->is_valid && nb_vp > 1) {
 			printf("Case %d error, each section can only have a single variable parameter.\n",
 					i + 1);
 			test_case->is_valid = false;
 			continue;
 		}
-
-		test_case->is_valid = true;
 	}
 
 	rte_cfgfile_close(cfgfile);
-- 
2.17.1

