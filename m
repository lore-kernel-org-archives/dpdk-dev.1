Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8493DCCD187
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Oct 2025 03:04:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19F964066B;
	Mon, 13 Oct 2025 05:03:32 +0200 (CEST)
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com
 [113.46.200.227])
 by mails.dpdk.org (Postfix) with ESMTP id 299944013F
 for <dev@dpdk.org>; Mon, 13 Oct 2025 05:02:51 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ApxL6EMwYHDj1WqnhGqUjWRFiVoQ1Bv8NQzOhzFqabs=;
 b=qUkFUU4P21WcRIqzxRHNqf9CaVmNgyWEMal5n3eH1k9biiAsaW8lwtfWX2lnT+DdYf4gmYT8q
 S7lZG3wqWzc87nDWYnQ/RhE/+V+RCUltXUbItoz5rk4FoxYpvkNzU0rQj6XzTgWyjBaurS6ypub
 Kjg263g3hQhvOU2rZhFkx7U=
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4clMZg2ZXDznTW3;
 Mon, 13 Oct 2025 11:02:03 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B23C21A016C;
 Mon, 13 Oct 2025 11:02:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 11:02:49 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v3 13/13] app/dma-perf: fix wrong stage to stop dmadev
Date: Mon, 13 Oct 2025 11:02:36 +0800
Message-ID: <20251013030236.3861-14-fengchengwen@huawei.com>
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

The benchmark do stop-dmadev at last, it has two problem:
1. it still invoke stop-dmadev when something wrong before
   config-dmadev.
2. the dmadev may working but the memory are freed.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c | 36 +++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 8e755c2afa..4bdd3ca598 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -763,6 +763,25 @@ verify_data(struct test_configure *cfg, struct rte_mbuf **srcs, struct rte_mbuf
 	return 0;
 }
 
+static void
+stop_dev(struct test_configure *cfg, bool *stopped)
+{
+	struct lcore_dma_map_t *lcore_dma_map;
+	uint32_t i;
+
+	if (*stopped)
+		return;
+
+	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
+		for (i = 0; i < cfg->num_worker; i++) {
+			lcore_dma_map = &cfg->dma_config[i].lcore_dma_map;
+			printf("Stopping dmadev %d\n", lcore_dma_map->dma_id);
+			rte_dma_stop(lcore_dma_map->dma_id);
+		}
+	}
+	*stopped = true;
+}
+
 int
 mem_copy_benchmark(struct test_configure *cfg)
 {
@@ -778,6 +797,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 	float bandwidth, bandwidth_total;
 	unsigned int lcore_id = 0;
 	uint32_t avg_cycles_total;
+	bool dev_stopped = false;
 	uint32_t avg_cycles = 0;
 	float mops, mops_total;
 	float memory = 0;
@@ -840,7 +860,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 		    vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_DEV) {
 			if (attach_ext_buffer(vchan_dev, lcores[i], cfg->is_sg,
 					      (nr_sgsrc/nb_workers), (nr_sgdst/nb_workers)) < 0)
-				goto out;
+				goto stop_dev;
 		}
 
 		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
@@ -875,6 +895,8 @@ mem_copy_benchmark(struct test_configure *cfg)
 
 	rte_eal_mp_wait_lcore();
 
+	stop_dev(cfg, &dev_stopped);
+
 	ret = verify_data(cfg, srcs, dsts, nr_buf);
 	if (ret != 0)
 		goto out;
@@ -900,8 +922,10 @@ mem_copy_benchmark(struct test_configure *cfg)
 	output_csv(CSV_TOTAL_LINE_FMT, cfg->scenario_id, nr_buf, memory * nb_workers,
 			(avg_cycles_total * (float) 1.0) / nb_workers, bandwidth_total, mops_total);
 
-out:
+stop_dev:
+	stop_dev(cfg, &dev_stopped);
 
+out:
 	for (k = 0; k < nb_workers; k++) {
 		struct rte_mbuf **sbuf = NULL, **dbuf = NULL;
 		vchan_dev = &cfg->dma_config[k].vchan_dev;
@@ -955,13 +979,5 @@ mem_copy_benchmark(struct test_configure *cfg)
 		lcores[i] = NULL;
 	}
 
-	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
-		for (i = 0; i < nb_workers; i++) {
-			lcore_dma_map = &cfg->dma_config[i].lcore_dma_map;
-			printf("Stopping dmadev %d\n", lcore_dma_map->dma_id);
-			rte_dma_stop(lcore_dma_map->dma_id);
-		}
-	}
-
 	return ret;
 }
-- 
2.17.1

