Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FEC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 10:55:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C2C640DD0;
	Mon, 11 Aug 2025 12:54:42 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 79EB34013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 12:54:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c0rxB6YkQz14MQG;
 Mon, 11 Aug 2025 18:49:34 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 6D519140159;
 Mon, 11 Aug 2025 18:54:33 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 Aug 2025 18:54:32 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>
Subject: [PATCH 6/9] app/dma-perf: add more global config
Date: Mon, 11 Aug 2025 18:54:27 +0800
Message-ID: <20250811105430.55791-7-fengchengwen@huawei.com>
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

This commit add 'cache_flush' and 'test_seconds' to the global
configuration.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c |  4 ++--
 app/test-dma-perf/config.ini  | 22 +++++++---------------
 app/test-dma-perf/main.c      | 21 +++++++++++++++------
 app/test-dma-perf/main.h      |  6 ++++--
 doc/guides/tools/dmaperf.rst  | 21 ++++++++-------------
 5 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index b798199dc1..d7c8d4c1b0 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -683,7 +683,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 	unsigned int buf_size = cfg->buf_size.cur;
 	uint16_t kick_batch = cfg->kick_batch.cur;
 	uint16_t nb_workers = cfg->num_worker;
-	uint16_t test_secs = cfg->test_secs;
+	uint16_t test_secs = global_cfg.test_secs;
 	float memory = 0;
 	uint32_t avg_cycles = 0;
 	uint32_t avg_cycles_total;
@@ -703,7 +703,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 		if (config_dmadevs(cfg) < 0)
 			goto out;
 
-	if (cfg->cache_flush == 1) {
+	if (global_cfg.cache_flush > 0) {
 		cache_flush_buf(srcs, buf_size, nr_buf);
 		cache_flush_buf(dsts, buf_size, nr_buf);
 		rte_mb();
diff --git a/app/test-dma-perf/config.ini b/app/test-dma-perf/config.ini
index 80cbcbb762..f1debcdc11 100644
--- a/app/test-dma-perf/config.ini
+++ b/app/test-dma-perf/config.ini
@@ -5,8 +5,11 @@
 ; Supported test types are DMA_MEM_COPY and CPU_MEM_COPY.
 
 ; There are two types of configuration sections: global configuration and testcase configuration.
-; The global section contains the "eal_args" entry which specifies the EAL arguments for all
-; testcases.
+; The global section contains following parameters:
+; "eal_args" entry which specifies the EAL arguments for all testcases.
+; "cache_flush" is used to determine whether or not the cache should be flushed, with 1 indicating
+; to flush and 0 indicating to not flush.
+; "test_seconds" controls the test time of each case.
 
 ; The testcase configuration contains following parameters:
 ; "mem_size" denotes the size of the memory footprint in megabytes (MB) for source and destination.
@@ -20,11 +23,6 @@
 ; src_numa_node is used to control the numa node where the source memory is allocated.
 ; dst_numa_node is used to control the numa node where the destination memory is allocated.
 
-; cache_flush is used to determine whether or not the cache should be flushed, with 1 indicating to
-; flush and 0 indicating to not flush.
-
-; test_seconds controls the test time of the whole case.
-
 ; To use DMA for a test, please specify the "lcore_dma" parameter.
 ; If you have already set the "-l" and "-a" parameters using EAL,
 ; make sure that the value of "lcore_dma" falls within their range of the values.
@@ -65,6 +63,8 @@
 
 [GLOBAL]
 eal_args=--in-memory --file-prefix=test -l 9-12
+cache_flush=0
+test_seconds=2
 
 [case1]
 type=DMA_MEM_COPY
@@ -74,8 +74,6 @@ dma_ring_size=1024
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
 
@@ -89,8 +87,6 @@ dma_dst_sge=1
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
 
@@ -103,8 +99,6 @@ dma_ring_size=1024
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
 lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x300000000,coreid=3,pfid=2,vfid=1
@@ -115,6 +109,4 @@ mem_size=10
 buf_size=64,8192,2,MUL
 src_numa_node=0
 dst_numa_node=1
-cache_flush=0
-test_seconds=2
 lcore = 10, 11
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 7525ab3622..fc92f6191a 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -44,7 +44,7 @@ enum {
 static struct test_configure test_cases[MAX_TEST_CASES];
 
 #define GLOBAL_SECTION_NAME	"GLOBAL"
-static struct global_configure global_cfg;
+struct global_configure global_cfg;
 
 static char *config_path;
 static char *result_path;
@@ -309,6 +309,20 @@ parse_global_config(struct rte_cfgfile *cfgfile)
 		global_cfg.eal_argv[i] = tokens[i];
 	global_cfg.eal_argc = i;
 
+	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "cache_flush");
+	if (entry == NULL) {
+		printf("Error: GLOBAL section don't has 'cache_flush' entry!\n");
+		return -1;
+	}
+	global_cfg.cache_flush = (uint8_t)atoi(entry);
+
+	entry = rte_cfgfile_get_entry(cfgfile, GLOBAL_SECTION_NAME, "test_seconds");
+	if (entry == NULL) {
+		printf("Error: GLOBAL section don't has 'test_seconds' entry!\n");
+		return -1;
+	}
+	global_cfg.test_secs = (uint16_t)atoi(entry);
+
 	return 0;
 }
 
@@ -501,11 +515,6 @@ load_configs(const char *path)
 			continue;
 		}
 
-		test_case->cache_flush =
-			(uint8_t)atoi(rte_cfgfile_get_entry(cfgfile, section_name, "cache_flush"));
-		test_case->test_secs = (uint16_t)atoi(rte_cfgfile_get_entry(cfgfile,
-					section_name, "test_seconds"));
-
 		test_case->is_valid = true;
 	}
 
diff --git a/app/test-dma-perf/main.h b/app/test-dma-perf/main.h
index 54dc1c4c2a..97c81eb2eb 100644
--- a/app/test-dma-perf/main.h
+++ b/app/test-dma-perf/main.h
@@ -63,9 +63,7 @@ struct test_configure {
 	uint16_t num_worker;
 	uint8_t nb_src_sges;
 	uint8_t nb_dst_sges;
-	uint8_t cache_flush;
 	uint32_t nr_buf;
-	uint16_t test_secs;
 	uint8_t scenario_id;
 };
 
@@ -74,8 +72,12 @@ struct test_configure {
 struct global_configure {
 	char *eal_argv[MAX_EAL_ARGV_NB];
 	int   eal_argc;
+	uint8_t cache_flush;
+	uint16_t test_secs;
 };
 
+extern struct global_configure global_cfg;
+
 void output_csv(const char *fmt, ...);
 int mem_copy_benchmark(struct test_configure *cfg);
 
diff --git a/doc/guides/tools/dmaperf.rst b/doc/guides/tools/dmaperf.rst
index 51a9cc8df8..265d719913 100644
--- a/doc/guides/tools/dmaperf.rst
+++ b/doc/guides/tools/dmaperf.rst
@@ -29,6 +29,8 @@ along with the application to demonstrate all the parameters.
 
    [GLOBAL]
    eal_args=--in-memory --file-prefix=test -l 9-12
+   cache_flush=0
+   test_seconds=2
 
    [case1]
    type=DMA_MEM_COPY
@@ -38,8 +40,6 @@ along with the application to demonstrate all the parameters.
    kick_batch=32
    src_numa_node=0
    dst_numa_node=0
-   cache_flush=0
-   test_seconds=2
    lcore_dma0=lcore=10,dev=0000:00:04.2,dir=mem2mem
    lcore_dma0=lcore=11,dev=0000:00:04.3,dir=mem2mem
 
@@ -49,8 +49,6 @@ along with the application to demonstrate all the parameters.
    buf_size=64,8192,2,MUL
    src_numa_node=0
    dst_numa_node=1
-   cache_flush=0
-   test_seconds=2
    lcore = 10, 11
 
    [case3]
@@ -64,8 +62,6 @@ along with the application to demonstrate all the parameters.
    kick_batch=32
    src_numa_node=0
    dst_numa_node=0
-   cache_flush=0
-   test_seconds=2
    lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
    lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
    lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x200000000,coreid=1,pfid=2,vfid=3
@@ -96,6 +92,12 @@ Global Configuration Parameters
 ``eal_args``
   Specifies the EAL arguments for all testcases.
 
+``cache_flush``
+  Determines whether the cache should be flushed.
+  ``1`` indicates to flush and ``0`` to not flush.
+
+``test_seconds``
+  Controls the test time for each scenario.
 
 Testcase Configuration Parameters
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -131,13 +133,6 @@ Testcase Configuration Parameters
 ``dst_numa_node``
   Controls the NUMA node where the destination memory is allocated.
 
-``cache_flush``
-  Determines whether the cache should be flushed.
-  ``1`` indicates to flush and ``0`` to not flush.
-
-``test_seconds``
-  Controls the test time for each scenario.
-
 ``lcore_dma``
   Specifies the lcore/DMA mapping and per device specific config.
 
-- 
2.17.1

