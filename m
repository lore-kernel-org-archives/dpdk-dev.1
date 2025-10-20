Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A029CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 182DC42E63;
	Mon, 20 Oct 2025 06:11:27 +0200 (CEST)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by mails.dpdk.org (Postfix) with ESMTP id D1C77402E5
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4JExELJIYfCJWdCAL455gPW2X3KbHewrEiiFPrpXrdI=;
 b=nS7YfTt9rAcaJzG/hvZAckjOhPAiOfDwDP8IZCSzfC/Yy1e2RkOu4oP/vRLFa/4ONAHFvBSZh
 Q56tAtRibEv2PYbH1dIVUJ1QS09kZd8moD7P82M3QJJAx6kX9mvRwM/0RWCTAKfQ9YOqGzTmTRk
 vNoXdhIVYMJ+GWXYn35uKlU=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4cqhm33m97zpStM;
 Mon, 20 Oct 2025 12:10:11 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B3E4140156;
 Mon, 20 Oct 2025 12:11:14 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:13 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 09/14] app/dma-perf: refactor benchmark function
Date: Mon, 20 Oct 2025 12:11:00 +0800
Message-ID: <20251020041105.1590-10-fengchengwen@huawei.com>
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

This commit refactor mem_copy_benchmark() function by splitting the
data verification part into an independent function.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/benchmark.c | 156 +++++++++++++++++++---------------
 1 file changed, 86 insertions(+), 70 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index c0a6e3d4d7..694ad25cbe 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -769,12 +769,82 @@ attach_ext_buffer(struct vchan_dev_config *vchan_dev, struct lcore_params *lcore
 	return 0;
 }
 
+static int
+verify_data(struct test_configure *cfg, struct rte_mbuf **srcs, struct rte_mbuf **dsts,
+	    uint32_t nr_buf)
+{
+	struct rte_mbuf **src_buf = NULL, **dst_buf = NULL;
+	uint32_t nr_buf_pt = nr_buf / cfg->num_worker;
+	struct vchan_dev_config *vchan_dev = NULL;
+	unsigned int buf_size = cfg->buf_size.cur;
+	uint32_t offset, work_idx, i, j;
+
+	for (work_idx = 0; work_idx < cfg->num_worker; work_idx++)  {
+		vchan_dev = &cfg->dma_config[work_idx].vchan_dev;
+		offset = nr_buf / cfg->num_worker * work_idx;
+		src_buf = srcs + offset;
+		dst_buf = dsts + offset;
+
+		if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_MEM && !cfg->is_sg) {
+			for (i = 0; i < nr_buf_pt; i++) {
+				if (memcmp(rte_pktmbuf_mtod(src_buf[i], void *),
+							    rte_pktmbuf_mtod(dst_buf[i], void *),
+							    cfg->buf_size.cur) != 0) {
+					printf("Copy validation fails for buffer number %d\n", i);
+					return -1;
+				}
+			}
+			continue;
+		}
+
+		if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_MEM && cfg->is_sg) {
+			size_t src_remsz = buf_size % cfg->nb_src_sges;
+			size_t dst_remsz = buf_size % cfg->nb_dst_sges;
+			size_t src_sz = buf_size / cfg->nb_src_sges;
+			size_t dst_sz = buf_size / cfg->nb_dst_sges;
+			uint8_t src[buf_size], dst[buf_size];
+			uint8_t *sbuf, *dbuf, *ptr;
+
+			for (i = 0; i < (nr_buf_pt / RTE_MAX(cfg->nb_src_sges, cfg->nb_dst_sges));
+				i++) {
+				sbuf = src;
+				dbuf = dst;
+				ptr = NULL;
+
+				for (j = 0; j < cfg->nb_src_sges; j++) {
+					ptr = rte_pktmbuf_mtod(src_buf[i * cfg->nb_src_sges + j],
+						uint8_t *);
+					memcpy(sbuf, ptr, src_sz);
+					sbuf += src_sz;
+				}
+				if (src_remsz)
+					memcpy(sbuf, ptr + src_sz, src_remsz);
+
+				for (j = 0; j < cfg->nb_dst_sges; j++) {
+					ptr = rte_pktmbuf_mtod(dst_buf[i * cfg->nb_dst_sges + j],
+						uint8_t *);
+					memcpy(dbuf, ptr, dst_sz);
+					dbuf += dst_sz;
+				}
+				if (dst_remsz)
+					memcpy(dbuf, ptr + dst_sz, dst_remsz);
+
+				if (memcmp(src, dst, buf_size) != 0) {
+					printf("SG Copy validation fails for buffer number %d\n",
+						i * cfg->nb_src_sges);
+					return -1;
+				}
+			}
+			continue;
+		}
+	}
+
+	return 0;
+}
+
 int
 mem_copy_benchmark(struct test_configure *cfg)
 {
-	uint32_t i, j, k;
-	uint32_t offset;
-	unsigned int lcore_id = 0;
 	struct rte_mbuf **srcs = NULL, **dsts = NULL, **m = NULL;
 	struct rte_dma_sge *src_sges = NULL, *dst_sges = NULL;
 	struct vchan_dev_config *vchan_dev = NULL;
@@ -782,15 +852,19 @@ mem_copy_benchmark(struct test_configure *cfg)
 	struct rte_dma_op **dma_ops = NULL;
 	unsigned int buf_size = cfg->buf_size.cur;
 	uint16_t kick_batch = cfg->kick_batch.cur;
-	uint16_t nb_workers = cfg->num_worker;
 	uint16_t test_secs = global_cfg.test_secs;
-	float memory = 0;
-	uint32_t avg_cycles = 0;
+	uint16_t nb_workers = cfg->num_worker;
+	uint32_t nr_sgsrc = 0, nr_sgdst = 0;
+	float bandwidth, bandwidth_total;
+	unsigned int lcore_id = 0;
 	uint32_t avg_cycles_total;
+	uint32_t avg_cycles = 0;
 	float mops, mops_total;
-	float bandwidth, bandwidth_total;
-	uint32_t nr_sgsrc = 0, nr_sgdst = 0;
-	uint32_t nr_buf, nr_ops;
+	float memory = 0;
+	uint32_t i, j, k;
+	uint32_t nr_buf;
+	uint32_t nr_ops;
+	uint32_t offset;
 	int ret = 0;
 
 	nr_buf = align_buffer_count(cfg, &nr_sgsrc, &nr_sgdst);
@@ -901,67 +975,9 @@ mem_copy_benchmark(struct test_configure *cfg)
 
 	rte_eal_mp_wait_lcore();
 
-	for (k = 0; k < nb_workers; k++) {
-		struct rte_mbuf **src_buf = NULL, **dst_buf = NULL;
-		uint32_t nr_buf_pt = nr_buf / nb_workers;
-		vchan_dev = &cfg->dma_config[k].vchan_dev;
-		offset = nr_buf / nb_workers * k;
-		src_buf = srcs + offset;
-		dst_buf = dsts + offset;
-
-		if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_MEM && !cfg->is_sg) {
-			for (i = 0; i < nr_buf_pt; i++) {
-				if (memcmp(rte_pktmbuf_mtod(src_buf[i], void *),
-							    rte_pktmbuf_mtod(dst_buf[i], void *),
-							    cfg->buf_size.cur) != 0) {
-					printf("Copy validation fails for buffer number %d\n", i);
-					ret = -1;
-					goto out;
-				}
-			}
-		} else if (vchan_dev->tdir == RTE_DMA_DIR_MEM_TO_MEM && cfg->is_sg) {
-			size_t src_remsz = buf_size % cfg->nb_src_sges;
-			size_t dst_remsz = buf_size % cfg->nb_dst_sges;
-			size_t src_sz = buf_size / cfg->nb_src_sges;
-			size_t dst_sz = buf_size / cfg->nb_dst_sges;
-			uint8_t src[buf_size], dst[buf_size];
-			uint8_t *sbuf, *dbuf, *ptr;
-
-			for (i = 0; i < (nr_buf_pt / RTE_MAX(cfg->nb_src_sges, cfg->nb_dst_sges));
-			     i++) {
-				sbuf = src;
-				dbuf = dst;
-				ptr = NULL;
-
-				for (j = 0; j < cfg->nb_src_sges; j++) {
-					ptr = rte_pktmbuf_mtod(src_buf[i * cfg->nb_src_sges + j],
-							       uint8_t *);
-					memcpy(sbuf, ptr, src_sz);
-					sbuf += src_sz;
-				}
-
-				if (src_remsz)
-					memcpy(sbuf, ptr + src_sz, src_remsz);
-
-				for (j = 0; j < cfg->nb_dst_sges; j++) {
-					ptr = rte_pktmbuf_mtod(dst_buf[i * cfg->nb_dst_sges + j],
-							       uint8_t *);
-					memcpy(dbuf, ptr, dst_sz);
-					dbuf += dst_sz;
-				}
-
-				if (dst_remsz)
-					memcpy(dbuf, ptr + dst_sz, dst_remsz);
-
-				if (memcmp(src, dst, buf_size) != 0) {
-					printf("SG Copy validation fails for buffer number %d\n",
-							i * cfg->nb_src_sges);
-					ret = -1;
-					goto out;
-				}
-			}
-		}
-	}
+	ret = verify_data(cfg, srcs, dsts, nr_buf);
+	if (ret != 0)
+		goto out;
 
 	mops_total = 0;
 	bandwidth_total = 0;
-- 
2.17.1

