Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09C3CCD187
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 03:03:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE8DD4060B;
	Mon, 13 Oct 2025 05:03:15 +0200 (CEST)
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com
 [113.46.200.226])
 by mails.dpdk.org (Postfix) with ESMTP id 5B817402A8
 for <dev@dpdk.org>; Mon, 13 Oct 2025 05:02:48 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=xdDbvC2zQRZbO3hvgbNMVD0+cOSiS8rCgDC1YIbLxV0=;
 b=hUBcmCr5pNPwqZR91Gfv4PTfIujKxVmSKkDAc6KYkdCJkd+YTbTEkgJJp49a7+fUEchM4PzPi
 hHS/3h9N9iiGsf1pyX57GoyL3j0sy7wm5COCfOf72wgJuKBU2i/FcBPVoQpyx8dZxlpbjjs8fvi
 ow2ptR57F7lpCDpZ3ZGQ8Rc=
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clMb83WX7zKm54;
 Mon, 13 Oct 2025 11:02:28 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 483A6180044;
 Mon, 13 Oct 2025 11:02:47 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 11:02:46 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v3 06/13] app/dma-perf: add more global config
Date: Mon, 13 Oct 2025 11:02:29 +0800
Message-ID: <20251013030236.3861-7-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251013030236.3861-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251013030236.3861-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
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

This commit add 'cache_flush' and 'test_seconds' to the global
configuration.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/benchmark.c |  4 ++--
 app/test-dma-perf/config.ini  | 22 +++++++---------------
 app/test-dma-perf/main.c      | 21 +++++++++++++++------
 app/test-dma-perf/main.h      |  6 ++++--
 doc/guides/tools/dmaperf.rst  | 22 +++++++++-------------
 5 files changed, 37 insertions(+), 38 deletions(-)

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
index 63a30dc56b..f74d9b6617 100644
--- a/app/test-dma-perf/config.ini
+++ b/app/test-dma-perf/config.ini
@@ -7,8 +7,11 @@
 ; There are two types of configuration sections: global configuration section and testcase
 ; configuration sections.
 
-; The global configuration section contains the "eal_args" entry which specifies the EAL arguments
-; for all testcases.
+; The global configuration section contains the following parameters:
+; "eal_args" entry which specifies the EAL arguments for all testcases.
+; "cache_flush" is used to determine whether or not the cache should be flushed, with 1 indicating
+; to flush and 0 indicating to not flush.
+; "test_seconds" controls the test time of each case.
 
 ; The testcase configuration sections contain the following parameters:
 ; "mem_size" denotes the size of the memory footprint in megabytes (MB) for source and destination.
@@ -22,11 +25,6 @@
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
@@ -67,6 +65,8 @@
 
 [GLOBAL]
 eal_args=--in-memory --file-prefix=test -l 9-12
+cache_flush=0
+test_seconds=2
 
 [case1]
 type=DMA_MEM_COPY
@@ -76,8 +76,6 @@ dma_ring_size=1024
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
 
@@ -91,8 +89,6 @@ dma_dst_sge=1
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=mem2mem
 
@@ -105,8 +101,6 @@ dma_ring_size=1024
 kick_batch=32
 src_numa_node=0
 dst_numa_node=0
-cache_flush=0
-test_seconds=2
 lcore_dma0=lcore=10,dev=0000:00:04.1,dir=mem2mem
 lcore_dma1=lcore=11,dev=0000:00:04.2,dir=dev2mem,raddr=0x200000000,coreid=1,pfid=2,vfid=3
 lcore_dma2=lcore=12,dev=0000:00:04.3,dir=mem2dev,raddr=0x300000000,coreid=3,pfid=2,vfid=1
@@ -117,6 +111,4 @@ mem_size=10
 buf_size=64,8192,2,MUL
 src_numa_node=0
 dst_numa_node=1
-cache_flush=0
-test_seconds=2
 lcore = 10, 11
diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index eb51bc7afa..acbd7fc2c4 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -39,7 +39,7 @@ enum {
 static struct test_configure test_cases[MAX_TEST_CASES];
 
 #define GLOBAL_SECTION_NAME	"GLOBAL"
-static struct global_configure global_cfg;
+struct global_configure global_cfg;
 
 static char *config_path;
 static char *result_path;
@@ -307,6 +307,20 @@ parse_global_config(struct rte_cfgfile *cfgfile)
 		global_cfg.eal_argv[i + 1] = tokens[i];
 	global_cfg.eal_argc = i + 1;
 
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
 
@@ -499,11 +513,6 @@ load_configs(const char *path)
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
index f0f68c0150..5d9077c62d 100644
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
 	char *eal_argv[MAX_EAL_ARGV_NB + 1];
 	int   eal_argc;
+	uint8_t cache_flush;
+	uint16_t test_secs;
 };
 
+extern struct global_configure global_cfg;
+
 void output_csv(const char *fmt, ...);
 int mem_copy_benchmark(struct test_configure *cfg);
 
diff --git a/doc/guides/tools/dmaperf.rst b/doc/guides/tools/dmaperf.rst
index fc37eb6b98..7c6906a494 100644
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
@@ -96,6 +92,13 @@ Global Configuration Parameters
 ``eal_args``
   Specifies the EAL arguments for all testcases.
 
+``cache_flush``
+  Determines whether the cache should be flushed.
+  ``1`` indicates to flush and ``0`` to not flush.
+
+``test_seconds``
+  Controls the test time for each scenario.
+
 
 Testcase Configuration Parameters
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -131,13 +134,6 @@ Testcase Configuration Parameters
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

