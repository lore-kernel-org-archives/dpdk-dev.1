Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81BCCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E412427AD;
	Mon, 20 Oct 2025 06:11:18 +0200 (CEST)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 by mails.dpdk.org (Postfix) with ESMTP id A4128400D5
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:14 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=7iBhmSQvQ7WSP41Dcm0jKgkNbmtAzx0Zqs9C7+7U/IY=;
 b=6cyX1lgJjUDIVsvJtLHUPZfjRTDcERk8NseN3U6PckYVutuWwIYdKhZ9uSSoyYMgg65C+QYUB
 TMcuelW7okrxpCX3oYK+azS/teuOji/oyK42hxv4uddH+uvfFHGH8T65/WWBu3wLeE3FoTbHRY5
 J1xeyZv7dz6YEzYP0rwgeHc=
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmn1Fl0zLlVc;
 Mon, 20 Oct 2025 12:10:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 658F5140338;
 Mon, 20 Oct 2025 12:11:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 02/14] app/dma-perf: add global section for config file
Date: Mon, 20 Oct 2025 12:10:53 +0800
Message-ID: <20251020041105.1590-3-fengchengwen@huawei.com>
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

This commit add global section which contains 'eal_args' entry
which specifies the EAL arguments for all testcases currently.

With this commit, users no longer need to enter EAL arguments on the
command line.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/config.ini | 18 ++++---
 app/test-dma-perf/main.c     | 95 +++++++++++++++++-------------------
 app/test-dma-perf/main.h     |  8 ++-
 doc/guides/tools/dmaperf.rst | 28 ++++++-----
 4 files changed, 81 insertions(+), 68 deletions(-)

diff --git a/app/test-dma-perf/config.ini b/app/test-dma-perf/config.ini
index fa59f6b140..0ccd0f2464 100644
--- a/app/test-dma-perf/config.ini
+++ b/app/test-dma-perf/config.ini
@@ -4,7 +4,13 @@
 
 ; Supported test types are DMA_MEM_COPY and CPU_MEM_COPY.
 
-; Parameters:
+; There are two types of configuration sections: global configuration section and testcase
+; configuration sections.
+
+; The global configuration section contains the "eal_args" entry which specifies the EAL arguments
+; for all testcases.
+
+; The testcase configuration sections contain the following parameters:
 ; "mem_size" denotes the size of the memory footprint in megabytes (MB) for source and destination.
 ; "buf_size" denotes the memory size of a single operation in bytes (B).
 ; "dma_ring_size" denotes the dma ring buffer size. It should be must be a power of two, and between
@@ -61,6 +67,9 @@
 ; If you do not specify a result file, one will be generated with the same name as the configuration
 ; file, with the addition of "_result.csv" at the end.
 
+[GLOBAL]
+eal_args=--in-memory --file-prefix=test -l 9-12
+
 [case1]
 type=DMA_MEM_COPY
 mem_size=10
@@ -73,7 +82,6 @@ cache_flush=0
 test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
-eal_args=--in-memory --file-prefix=test
 
 [case2]
 type=DMA_MEM_COPY
@@ -89,8 +97,6 @@ cache_flush=0
 test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
-eal_args=--in-memory --file-prefix=test
-use_enq_deq_ops=0
 
 [case3]
 skip=1
@@ -106,7 +112,6 @@ test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
 lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x300000000,coreid=3,pfid=2,vfid=1
-eal_args=--in-memory --file-prefix=test
 
 [case4]
 type=CPU_MEM_COPY
@@ -116,5 +121,4 @@ src_numa_node=0
 dst_numa_node=1
 cache_flush=0
 test_seconds=2
-lcore = 3, 4
-eal_args=--in-memory --no-pci
+lcore = 10, 11
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 64057788c3..4a884567a0 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -23,9 +23,6 @@
 
 #define CSV_HDR_FMT "Case %u : %s,lcore,DMA,DMA ring size,kick batch size,buffer size(B),number of buffers,memory(MB),average cycle,bandwidth(Gbps),MOps\n"
 
-#define MAX_EAL_PARAM_NB 100
-#define MAX_EAL_PARAM_LEN 1024
-
 #define DMA_MEM_COPY "DMA_MEM_COPY"
 #define CPU_MEM_COPY "CPU_MEM_COPY"
 
@@ -45,6 +42,9 @@ enum {
 #define MAX_TEST_CASES 16
 static struct test_configure test_cases[MAX_TEST_CASES];
 
+#define GLOBAL_SECTION_NAME	"GLOBAL"
+static struct global_configure global_cfg;
+
 char output_str[MAX_WORKER_NB + 1][MAX_OUTPUT_STR_LEN];
 
 static FILE *fd;
@@ -288,6 +288,42 @@ static int populate_dma_dev_config(const char *key, const char *value, void *tes
 	return ret;
 }
 
+static int
+parse_global_config(struct rte_cfgfile *cfgfile)
+{
+	static char prog_name[] = "test-dma-perf";
+	char *tokens[MAX_EAL_ARGV_NB];
+	const char *entry;
+	int token_nb;
+	char *args;
+	int ret;
+	int i;
+
+	ret = rte_cfgfile_num_sections(cfgfile, GLOBAL_SECTION_NAME, strlen(GLOBAL_SECTION_NAME));
+	if (ret != 1) {
+		printf("Error: GLOBAL section not exist or has multiple!\n");
+		return -1;
+	}
+
+	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "eal_args");
+	if (entry == NULL) {
+		printf("Error: GLOBAL section must have 'eal_args' entry!\n");
+		return -1;
+	}
+	args = strdup(entry);
+	if (args == NULL) {
+		printf("Error: dup GLOBAL 'eal_args' failed!\n");
+		return -1;
+	}
+	token_nb = rte_strsplit(args, strlen(args), tokens, MAX_EAL_ARGV_NB, ' ');
+	global_cfg.eal_argv[0] = prog_name;
+	for (i = 0; i < token_nb; i++)
+		global_cfg.eal_argv[i + 1] = tokens[i];
+	global_cfg.eal_argc = i + 1;
+
+	return 0;
+}
+
 static uint16_t
 load_configs(const char *path)
 {
@@ -297,8 +333,8 @@ load_configs(const char *path)
 	char section_name[CFG_NAME_LEN];
 	const char *case_type;
 	const char *lcore_dma;
-	const char *mem_size_str, *buf_size_str, *ring_size_str, *kick_batch_str, *src_sges_str,
-		*dst_sges_str, *use_dma_ops;
+	const char *mem_size_str, *buf_size_str, *ring_size_str, *kick_batch_str,
+		*src_sges_str, *dst_sges_str, *use_dma_ops;
 	const char *skip;
 	struct rte_kvargs *kvlist;
 	int args_nr, nb_vp;
@@ -311,7 +347,10 @@ load_configs(const char *path)
 		exit(1);
 	}
 
-	nb_sections = rte_cfgfile_num_sections(cfgfile, NULL, 0);
+	if (parse_global_config(cfgfile) != 0)
+		exit(1);
+
+	nb_sections = rte_cfgfile_num_sections(cfgfile, NULL, 0) - 1;
 	if (nb_sections > MAX_TEST_CASES) {
 		printf("Error: The maximum number of cases is %d.\n", MAX_TEST_CASES);
 		exit(1);
@@ -488,9 +527,6 @@ load_configs(const char *path)
 		test_case->test_secs = (uint16_t)atoi(rte_cfgfile_get_entry(cfgfile,
 					section_name, "test_seconds"));
 
-		test_case->eal_args = rte_cfgfile_get_entry(cfgfile, section_name, "eal_args");
-		if (test_case->eal_args != NULL)
-			test_case->eal_args = strdup(test_case->eal_args);
 		test_case->is_valid = true;
 	}
 
@@ -499,36 +535,6 @@ load_configs(const char *path)
 	return i;
 }
 
-/* Parse the argument given in the command line of the application */
-static int
-append_eal_args(int argc, char **argv, const char *eal_args, char **new_argv)
-{
-	int i;
-	char *tokens[MAX_EAL_PARAM_NB];
-	char args[MAX_EAL_PARAM_LEN] = {0};
-	int token_nb, new_argc = 0;
-
-	for (i = 0; i < argc; i++) {
-		if ((strcmp(argv[i], CMDLINE_CONFIG_ARG) == 0) ||
-				(strcmp(argv[i], CMDLINE_RESULT_ARG) == 0)) {
-			i++;
-			continue;
-		}
-		strlcpy(new_argv[new_argc], argv[i], MAX_EAL_PARAM_LEN);
-		new_argc++;
-	}
-
-	if (eal_args) {
-		strlcpy(args, eal_args, MAX_EAL_PARAM_LEN);
-		token_nb = rte_strsplit(args, strlen(args),
-					tokens, MAX_EAL_PARAM_NB, ' ');
-		for (i = 0; i < token_nb; i++)
-			strlcpy(new_argv[new_argc++], tokens[i], MAX_EAL_PARAM_LEN);
-	}
-
-	return new_argc;
-}
-
 int
 main(int argc, char *argv[])
 {
@@ -537,17 +543,9 @@ main(int argc, char *argv[])
 	uint32_t i, nb_lcores;
 	pid_t cpid, wpid;
 	int wstatus;
-	char args[MAX_EAL_PARAM_NB][MAX_EAL_PARAM_LEN];
-	char *pargs[MAX_EAL_PARAM_NB];
 	char *cfg_path_ptr = NULL;
 	char *rst_path_ptr = NULL;
 	char rst_path[PATH_MAX];
-	int new_argc;
-
-	memset(args, 0, sizeof(args));
-
-	for (i = 0; i < RTE_DIM(pargs); i++)
-		pargs[i] = args[i];
 
 	for (i = 0; i < (uint32_t)argc; i++) {
 		if (strncmp(argv[i], CMDLINE_CONFIG_ARG, MAX_LONG_OPT_SZ) == 0)
@@ -604,8 +602,7 @@ main(int argc, char *argv[])
 		} else if (cpid == 0) {
 			printf("\nRunning case %u\n\n", i + 1);
 
-			new_argc = append_eal_args(argc, argv, test_cases[i].eal_args, pargs);
-			ret = rte_eal_init(new_argc, pargs);
+			ret = rte_eal_init(global_cfg.eal_argc, global_cfg.eal_argv);
 			if (ret < 0)
 				rte_exit(EXIT_FAILURE, "Invalid EAL arguments\n");
 
diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index d6cc613250..61e7253ce6 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -70,10 +70,16 @@ struct test_configure {
 	uint8_t cache_flush;
 	uint32_t nr_buf;
 	uint16_t test_secs;
-	const char *eal_args;
 	uint8_t scenario_id;
 };
 
+#define MAX_EAL_ARGV_NB 100
+
+struct global_configure {
+	char *eal_argv[MAX_EAL_ARGV_NB + 1];
+	int   eal_argc;
+};
+
 int mem_copy_benchmark(struct test_configure *cfg);
 
 #endif /* MAIN_H */
diff --git a/doc/guides/tools/dmaperf.rst b/doc/guides/tools/dmaperf.rst
index ba18dadd4b..47013e6d64 100644
--- a/doc/guides/tools/dmaperf.rst
+++ b/doc/guides/tools/dmaperf.rst
@@ -27,6 +27,9 @@ along with the application to demonstrate all the parameters.
 
 .. code-block:: ini
 
+   [GLOBAL]
+   eal_args=--in-memory --file-prefix=test -l 9-12
+
    [case1]
    type=DMA_MEM_COPY
    mem_size=10
@@ -39,7 +42,6 @@ along with the application to demonstrate all the parameters.
    test_seconds=2
    lcore_dma0=lcore=10,dev=0000:00:04.2,dir=mem2mem
    lcore_dma0=lcore=11,dev=0000:00:04.3,dir=mem2mem
-   eal_args=--in-memory --file-prefix=test
 
    [case2]
    type=CPU_MEM_COPY
@@ -49,8 +51,7 @@ along with the application to demonstrate all the parameters.
    dst_numa_node=1
    cache_flush=0
    test_seconds=2
-   lcore = 3, 4
-   eal_args=--in-memory --no-pci
+   lcore = 10, 11
 
    [case3]
    skip=1
@@ -68,12 +69,13 @@ along with the application to demonstrate all the parameters.
    lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
    lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
    lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x200000000,coreid=1,pfid=2,vfid=3
-   eal_args=--in-memory --file-prefix=test
    use_enq_deq_ops=0
 
-The configuration file is divided into multiple sections, each section represents a test case.
+The configuration file is divided into two type sections, the first is global configuration
+section; the second is testcase configuration sections which contain multiple sections, each
+section represents a testcase.
 The four mandatory variables ``mem_size``, ``buf_size``, ``dma_ring_size``, and ``kick_batch``
-can vary in each test case.
+can vary in each testcase.
 The format for this is ``variable=first,last,increment,ADD|MUL``.
 This means that the first value of the variable is ``first``,
 the last value is ``last``, ``increment`` is the step size,
@@ -91,8 +93,15 @@ Each case can only have one variable change,
 and each change will generate a scenario, so each case can have multiple scenarios.
 
 
-Configuration Parameters
-~~~~~~~~~~~~~~~~~~~~~~~~
+Global Configuration Parameters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``eal_args``
+  Specifies the EAL arguments for all testcases.
+
+
+Testcase Configuration Parameters
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 ``skip``
   To skip a test-case, must be configured as ``1``
@@ -170,9 +179,6 @@ Configuration Parameters
 ``lcore``
   Specifies the lcore for CPU testing.
 
-``eal_args``
-  Specifies the EAL arguments.
-
 ``use_enq_deq_ops``
   Specifies whether to use enqueue/dequeue operations.
   ``0`` indicates to not use and ``1`` to use.
-- 
2.17.1

