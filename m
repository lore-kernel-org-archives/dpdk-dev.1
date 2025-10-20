Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65CACCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:12:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3553E42E7A;
	Mon, 20 Oct 2025 06:11:31 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id B293A42D7D
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:16 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dt5T47chKUpMyY7TD9EuL6BpaKWAOqTosby/5qeaUqU=;
 b=4BdjR9MMeBIpCUuZNLSqGU5zcWwhWXZFCoG8m9gtePg2iL8o4SaSvYNRDEMdFezyyQJvzpihK
 n6+ysPHDpV4uSXFxLOxFn5lQyqhh0/E4JFdFU3OWUVkJLmexjS+ciokDILNo2PTLU5dPuOmaCv1
 DhV7iPTZ8BF3Ssfp0RIZI5Y=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmJ4Lnhz1T4FV;
 Mon, 20 Oct 2025 12:10:24 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B227E140156;
 Mon, 20 Oct 2025 12:11:15 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:15 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 14/14] app/dma-perf: refactor benchmark function
Date: Mon, 20 Oct 2025 12:11:05 +0800
Message-ID: <20251020041105.1590-15-fengchengwen@huawei.com>
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

Refactor benchmark function by splitting the resource alloc/free to
different subfunctions.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c | 217 ++++++++++++++++++++--------------
 1 file changed, 130 insertions(+), 87 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 7512018e38..b6125d86f9 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -240,6 +240,9 @@ config_dmadevs(struct test_configure *cfg)
 	uint8_t nb_sges = 0;
 	char *dma_name;
 
+	if (cfg->test_type != TEST_TYPE_DMA_MEM_COPY)
+		return 0;
+
 	if (cfg->is_sg)
 		nb_sges = RTE_MAX(cfg->nb_src_sges, cfg->nb_dst_sges);
 
@@ -540,7 +543,7 @@ dummy_free_ext_buf(void *addr, void *opaque)
 
 static int
 setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
-			 struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
+		 struct rte_mbuf ***srcs, struct rte_mbuf ***dsts,
 		 struct rte_dma_sge **src_sges, struct rte_dma_sge **dst_sges,
 		 struct rte_dma_op ***dma_ops)
 {
@@ -681,6 +684,39 @@ setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
 	return 0;
 }
 
+static void
+teardown_memory_env(uint32_t nr_buf, struct rte_mbuf **srcs, struct rte_mbuf **dsts,
+		    struct rte_dma_sge *src_sges, struct rte_dma_sge *dst_sges,
+		    struct rte_dma_op **dma_ops)
+{
+	/* free mbufs used in the test */
+	if (srcs != NULL)
+		rte_pktmbuf_free_bulk(srcs, nr_buf);
+	if (dsts != NULL)
+		rte_pktmbuf_free_bulk(dsts, nr_buf);
+
+	/* free the points for the mbufs */
+	rte_free(srcs);
+	srcs = NULL;
+	rte_free(dsts);
+	dsts = NULL;
+
+	rte_mempool_free(src_pool);
+	src_pool = NULL;
+
+	rte_mempool_free(dst_pool);
+	dst_pool = NULL;
+
+	/* free sges for mbufs */
+	rte_free(src_sges);
+	src_sges = NULL;
+
+	rte_free(dst_sges);
+	dst_sges = NULL;
+
+	rte_free(dma_ops);
+}
+
 static uint32_t
 align_buffer_count(struct test_configure *cfg, uint32_t *nr_sgsrc, uint32_t *nr_sgdst)
 {
@@ -883,48 +919,23 @@ verify_data(struct test_configure *cfg, struct rte_mbuf **srcs, struct rte_mbuf
 	return 0;
 }
 
-int
-mem_copy_benchmark(struct test_configure *cfg)
+static int
+setup_worker(struct test_configure *cfg, uint32_t nr_buf,
+	     struct rte_mbuf **srcs, struct rte_mbuf **dsts,
+	     struct rte_dma_sge *src_sges, struct rte_dma_sge *dst_sges,
+	     struct rte_dma_op **dma_ops,
+	     uint32_t nr_sgsrc, uint32_t nr_sgdst)
 {
-	struct rte_mbuf **srcs = NULL, **dsts = NULL, **m = NULL;
-	struct rte_dma_sge *src_sges = NULL, *dst_sges = NULL;
-	struct vchan_dev_config *vchan_dev = NULL;
 	struct lcore_dma_map_t *lcore_dma_map = NULL;
-	struct rte_dma_op **dma_ops = NULL;
+	struct vchan_dev_config *vchan_dev = NULL;
 	unsigned int buf_size = cfg->buf_size.cur;
 	uint16_t kick_batch = cfg->kick_batch.cur;
 	uint16_t test_secs = global_cfg.test_secs;
 	uint16_t nb_workers = cfg->num_worker;
-	uint32_t nr_sgsrc = 0, nr_sgdst = 0;
-	float bandwidth, bandwidth_total;
 	unsigned int lcore_id = 0;
-	uint32_t avg_cycles_total;
-	bool dev_stopped = false;
-	uint32_t avg_cycles = 0;
-	float mops, mops_total;
-	float memory = 0;
 	uint32_t i, j, k;
-	uint32_t nr_buf;
 	uint32_t nr_ops;
 	uint32_t offset;
-	int ret = 0;
-
-	nr_buf = align_buffer_count(cfg, &nr_sgsrc, &nr_sgdst);
-
-	if (setup_memory_env(cfg, nr_buf, &srcs, &dsts, &src_sges, &dst_sges, &dma_ops) < 0)
-		goto out;
-
-	if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY)
-		if (config_dmadevs(cfg) < 0)
-			goto out;
-
-	if (global_cfg.cache_flush > 0) {
-		cache_flush_buf(srcs, buf_size, nr_buf);
-		cache_flush_buf(dsts, buf_size, nr_buf);
-		rte_mb();
-	}
-
-	printf("Start testing....\n");
 
 	for (i = 0; i < nb_workers; i++) {
 		lcore_dma_map = &cfg->dma_config[i].lcore_dma_map;
@@ -935,7 +946,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 		lcores[i] = rte_malloc(NULL, sizeof(struct lcore_params), 0);
 		if (lcores[i] == NULL) {
 			printf("lcore parameters malloc failure for lcore %d\n", lcore_id);
-			break;
+			return -1;
 		}
 		if (cfg->test_type == TEST_TYPE_DMA_MEM_COPY) {
 			lcores[i]->dma_name = lcore_dma_map->dma_names;
@@ -963,7 +974,7 @@ mem_copy_benchmark(struct test_configure *cfg)
 		    vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_DEV) {
 			if (attach_ext_buffer(vchan_dev, lcores[i], cfg->is_sg,
 					      (nr_sgsrc/nb_workers), (nr_sgdst/nb_workers)) < 0)
-				goto stop_dmadev;
+				return -1;
 		}
 
 		if (cfg->is_sg && cfg->use_ops) {
@@ -988,6 +999,88 @@ mem_copy_benchmark(struct test_configure *cfg)
 		rte_eal_remote_launch(get_work_function(cfg), (void *)(lcores[i]), lcore_id);
 	}
 
+	return 0;
+}
+
+static void
+teardown_worker_res(struct test_configure *cfg, uint32_t nr_buf,
+		    struct rte_mbuf **srcs, struct rte_mbuf **dsts)
+{
+	uint16_t nb_workers = cfg->num_worker;
+	struct vchan_dev_config *vchan_dev;
+	struct rte_mbuf **m;
+	uint32_t offset;
+	uint32_t i, j;
+
+	for (i = 0; i < nb_workers; i++) {
+		struct rte_mbuf **sbuf = NULL, **dbuf = NULL;
+		vchan_dev = &cfg->dma_config[i].vchan_dev;
+		offset = nr_buf / nb_workers * i;
+		m = NULL;
+		if (vchan_dev->tdir == RTE_DMA_DIR_DEV_TO_MEM) {
+			sbuf = srcs + offset;
+			m = sbuf;
+		} else if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_DEV) {
+			dbuf = dsts + offset;
+			m = dbuf;
+		}
+
+		if (m) {
+			for (j = 0; j < (nr_buf / nb_workers); j++)
+				rte_pktmbuf_detach_extbuf(m[j]);
+
+			if (m[0]->shinfo && rte_mbuf_ext_refcnt_read(m[0]->shinfo) == 0)
+				rte_free(m[0]->shinfo);
+		}
+
+		rte_free(lcores[i]);
+		lcores[i] = NULL;
+	}
+}
+
+int
+mem_copy_benchmark(struct test_configure *cfg)
+{
+	struct rte_mbuf **srcs = NULL, **dsts = NULL;
+	struct rte_dma_sge *src_sges = NULL, *dst_sges = NULL;
+	struct vchan_dev_config *vchan_dev = NULL;
+	unsigned int buf_size = cfg->buf_size.cur;
+	uint16_t kick_batch = cfg->kick_batch.cur;
+	uint16_t test_secs = global_cfg.test_secs;
+	uint16_t nb_workers = cfg->num_worker;
+	uint32_t nr_sgsrc = 0, nr_sgdst = 0;
+	struct rte_dma_op **dma_ops = NULL;
+	float bandwidth, bandwidth_total;
+	uint32_t avg_cycles_total;
+	bool dev_stopped = false;
+	uint32_t avg_cycles = 0;
+	float mops, mops_total;
+	float memory = 0;
+	uint32_t nr_buf;
+	int ret = -1;
+	uint32_t i;
+
+	nr_buf = align_buffer_count(cfg, &nr_sgsrc, &nr_sgdst);
+
+	if (setup_memory_env(cfg, nr_buf, &srcs, &dsts, &src_sges, &dst_sges, &dma_ops) < 0)
+		goto out;
+
+	if (config_dmadevs(cfg) < 0)
+		goto out;
+
+	if (global_cfg.cache_flush > 0) {
+		cache_flush_buf(srcs, buf_size, nr_buf);
+		cache_flush_buf(dsts, buf_size, nr_buf);
+		rte_mb();
+	}
+
+	printf("Start testing....\n");
+
+	ret = setup_worker(cfg, nr_buf, srcs, dsts, src_sges, dst_sges, dma_ops,
+			   nr_sgsrc, nr_sgdst);
+	if (ret != 0)
+		goto stop_dmadev;
+
 	while (1) {
 		bool ready = true;
 		for (i = 0; i < nb_workers; i++) {
@@ -1048,58 +1141,8 @@ mem_copy_benchmark(struct test_configure *cfg)
 	stop_dmadev(cfg, &dev_stopped);
 
 out:
-	for (k = 0; k < nb_workers; k++) {
-		struct rte_mbuf **sbuf = NULL, **dbuf = NULL;
-		vchan_dev = &cfg->dma_config[k].vchan_dev;
-		offset = nr_buf / nb_workers * k;
-		m = NULL;
-		if (vchan_dev->tdir == RTE_DMA_DIR_DEV_TO_MEM) {
-			sbuf = srcs + offset;
-			m = sbuf;
-		} else if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_DEV) {
-			dbuf = dsts + offset;
-			m = dbuf;
-		}
-
-		if (m) {
-			for (i = 0; i < (nr_buf / nb_workers); i++)
-				rte_pktmbuf_detach_extbuf(m[i]);
-
-			if (m[0]->shinfo && rte_mbuf_ext_refcnt_read(m[0]->shinfo) == 0)
-				rte_free(m[0]->shinfo);
-		}
-	}
-
-	/* free mbufs used in the test */
-	if (srcs != NULL)
-		rte_pktmbuf_free_bulk(srcs, nr_buf);
-	if (dsts != NULL)
-		rte_pktmbuf_free_bulk(dsts, nr_buf);
-
-	/* free the points for the mbufs */
-	rte_free(srcs);
-	srcs = NULL;
-	rte_free(dsts);
-	dsts = NULL;
-
-	rte_mempool_free(src_pool);
-	src_pool = NULL;
-
-	rte_mempool_free(dst_pool);
-	dst_pool = NULL;
-
-	/* free sges for mbufs */
-	rte_free(src_sges);
-	src_sges = NULL;
-
-	rte_free(dst_sges);
-	dst_sges = NULL;
-
-	/* free the worker parameters */
-	for (i = 0; i < nb_workers; i++) {
-		rte_free(lcores[i]);
-		lcores[i] = NULL;
-	}
+	teardown_worker_res(cfg, nr_buf, srcs, dsts);
+	teardown_memory_env(nr_buf, srcs, dsts, src_sges, dst_sges, dma_ops);
 
 	return ret;
 }
-- 
2.17.1

