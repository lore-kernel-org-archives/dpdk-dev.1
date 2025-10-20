Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2646CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EECD42E69;
	Mon, 20 Oct 2025 06:11:29 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id 647C4427AD
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:16 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=0+Re4Rkz4vlBiMW4bNFUv64l9husHAtWSy+bjA+uTPc=;
 b=uSP40kxxe5eUneD1n8CE9gEQ9LK0eVEr/aLvW1vBb7HB+gDtZFBNg+y2r58IBoR4AAnh0vR/h
 gsHed3u2LPGC3bAmK1lu4CZAmev54seuI6HVLTkjGThXG10beASjDOxZeVgrXga6WaU40DcX6+i
 htIKM17fJFkuPwU/yA5biVc=
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cqhm42hkbzpStM;
 Mon, 20 Oct 2025 12:10:12 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 2936B180493;
 Mon, 20 Oct 2025 12:11:15 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:14 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 12/14] app/dma-perf: fix on-flight DMA when verify data
Date: Mon, 20 Oct 2025 12:11:03 +0800
Message-ID: <20251020041105.1590-13-fengchengwen@huawei.com>
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

There maybe on-flight DMA when verify_data() because the DMA device
may still working when worker exit.

This commit add wait DMA complete stage before worker exit.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c | 71 ++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 6643ccc95f..4ce95d0f7b 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -19,7 +19,6 @@
 #define MAX_DMA_CPL_NB 255
 
 #define TEST_WAIT_U_SECOND 10000
-#define POLL_MAX 1000
 
 #define CSV_LINE_DMA_FMT "Scenario %u,%u,%s,%u,%u,%u,%u,%.2lf,%" PRIu64 ",%.3lf,%.3lf\n"
 #define CSV_LINE_CPU_FMT "Scenario %u,%u,NA,NA,NA,%u,%u,%.2lf,%" PRIu64 ",%.3lf,%.3lf\n"
@@ -293,6 +292,45 @@ do_dma_submit_and_poll(uint16_t dev_id, uint64_t *async_cnt,
 	worker_info->total_cpl += nr_cpl;
 }
 
+static int
+do_dma_submit_and_wait_cpl(uint16_t dev_id, uint64_t async_cnt, bool use_ops)
+{
+#define MAX_WAIT_MSEC	1000
+#define MAX_POLL	1000
+#define DEQ_SZ		64
+	struct rte_dma_op *op[DEQ_SZ];
+	enum rte_dma_vchan_status st;
+	uint32_t poll_cnt = 0;
+	uint32_t wait_ms = 0;
+	uint16_t nr_cpl;
+
+	if (!use_ops)
+		rte_dma_submit(dev_id, 0);
+
+	if (rte_dma_vchan_status(dev_id, 0, &st) < 0) {
+		rte_delay_ms(MAX_WAIT_MSEC);
+		goto wait_cpl;
+	}
+
+	while (st == RTE_DMA_VCHAN_ACTIVE && wait_ms++ < MAX_WAIT_MSEC) {
+		rte_delay_ms(1);
+		rte_dma_vchan_status(dev_id, 0, &st);
+	}
+
+wait_cpl:
+	while ((async_cnt > 0) && (poll_cnt++ < MAX_POLL)) {
+		if (use_ops)
+			nr_cpl = rte_dma_dequeue_ops(dev_id, 0, op, DEQ_SZ);
+		else
+			nr_cpl = rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
+		async_cnt -= nr_cpl;
+	}
+	if (async_cnt > 0)
+		PRINT_ERR("Error: wait DMA %u failed!\n", dev_id);
+
+	return async_cnt == 0 ? 0 : -1;
+}
+
 static inline int
 do_dma_plain_mem_copy(void *p)
 {
@@ -304,10 +342,8 @@ do_dma_plain_mem_copy(void *p)
 	const uint32_t buf_size = para->buf_size;
 	struct rte_mbuf **srcs = para->srcs;
 	struct rte_mbuf **dsts = para->dsts;
-	uint16_t nr_cpl;
 	uint64_t async_cnt = 0;
 	uint32_t i;
-	uint32_t poll_cnt = 0;
 	int ret;
 
 	worker_info->stop_flag = false;
@@ -338,13 +374,7 @@ do_dma_plain_mem_copy(void *p)
 			break;
 	}
 
-	rte_dma_submit(dev_id, 0);
-	while ((async_cnt > 0) && (poll_cnt++ < POLL_MAX)) {
-		nr_cpl = rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
-		async_cnt -= nr_cpl;
-	}
-
-	return 0;
+	return do_dma_submit_and_wait_cpl(dev_id, async_cnt, false);
 }
 
 static inline int
@@ -360,8 +390,6 @@ do_dma_sg_mem_copy(void *p)
 	const uint16_t dev_id = para->dev_id;
 	uint32_t nr_buf = para->nr_buf;
 	uint64_t async_cnt = 0;
-	uint32_t poll_cnt = 0;
-	uint16_t nr_cpl;
 	uint32_t i, j;
 	int ret;
 
@@ -397,13 +425,7 @@ do_dma_sg_mem_copy(void *p)
 			break;
 	}
 
-	rte_dma_submit(dev_id, 0);
-	while ((async_cnt > 0) && (poll_cnt++ < POLL_MAX)) {
-		nr_cpl = rte_dma_completed(dev_id, 0, MAX_DMA_CPL_NB, NULL, NULL);
-		async_cnt -= nr_cpl;
-	}
-
-	return 0;
+	return do_dma_submit_and_wait_cpl(dev_id, async_cnt, false);
 }
 
 static inline int
@@ -414,11 +436,11 @@ do_dma_enq_deq_mem_copy(void *p)
 	volatile struct worker_info *worker_info = &(para->worker_info);
 	struct rte_dma_op **dma_ops = para->dma_ops;
 	uint16_t kick_batch = para->kick_batch, sz;
-	uint16_t enq, deq, poll_cnt;
-	uint64_t tenq, tdeq;
 	const uint16_t dev_id = para->dev_id;
 	uint32_t nr_buf = para->nr_buf;
 	struct rte_dma_op *op[DEQ_SZ];
+	uint64_t tenq, tdeq;
+	uint16_t enq, deq;
 	uint32_t i;
 
 	worker_info->stop_flag = false;
@@ -454,11 +476,7 @@ do_dma_enq_deq_mem_copy(void *p)
 			break;
 	}
 
-	poll_cnt = 0;
-	while ((tenq != tdeq) && (poll_cnt++ < POLL_MAX))
-		tdeq += rte_dma_dequeue_ops(dev_id, 0, op, DEQ_SZ);
-
-	return 0;
+	return do_dma_submit_and_wait_cpl(dev_id, tenq - tdeq, true);
 }
 
 static inline int
@@ -614,7 +632,6 @@ setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
 		}
 
 		if (cfg->use_ops) {
-
 			nr_buf /= RTE_MAX(nb_src_sges, nb_dst_sges);
 			*dma_ops = rte_zmalloc(NULL, nr_buf * (sizeof(struct rte_dma_op *)),
 					       RTE_CACHE_LINE_SIZE);
-- 
2.17.1

