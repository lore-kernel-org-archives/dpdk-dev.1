Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E9FC369C2
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 10:09:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0064640DD5;
	Wed, 16 Apr 2025 12:09:54 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 5762040DD5
 for <dev@dpdk.org>; Wed, 16 Apr 2025 12:09:53 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8jD95019586;
 Wed, 16 Apr 2025 03:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=O
 OkIjE2xQSDgJ/tFeSDaBWCYPNr2dQl1CQGl2rYAzxM=; b=eEW3m18uGT62VfDLu
 csWzcbn+B7obHL6VJPG2MbGWNL8j428ZeNUKajs7FTvbVBebzJkK7DgYXOC0dYFN
 13djl4Df5DqtwXaDfoPq5/IBeuFnUuRxpGAjMyNOpGfYRlDdEREpsGVcop/MQ3Y3
 SgXewmQ6w+VUBPQeZDzNyFxMdHlAt9CR+j6yCO9xLWjZ48uMEJ9w0dhW46gjBz0/
 8lyMQNW5ht5/WjxUmQlqiC9+Jc800rdElKV6pX2xi+88RIzj8h279Txt4WLm/vQe
 V6zZFJpHCYCCe7GSZB2x8Pe23U9qHkzEedAF1MsIp8sTFtgC1mvv8M0mAjWZ3qp5
 Bd1GA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4629a6052k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Apr 2025 03:09:52 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Apr 2025 03:09:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Apr 2025 03:09:47 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 0236D5B6943;
 Wed, 16 Apr 2025 03:09:41 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
CC: <vattunuru@marvell.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: [25.11 PATCH 1/3] dmadev: add enqueue dequeue operations
Date: Wed, 16 Apr 2025 15:39:29 +0530
Message-ID: <20250416100931.6544-2-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416100931.6544-1-pbhagavatula@marvell.com>
References: <20250416100931.6544-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0iwoqP_SACjuB0locczTneCh9QkWxVGG
X-Proofpoint-ORIG-GUID: 0iwoqP_SACjuB0locczTneCh9QkWxVGG
X-Authority-Analysis: v=2.4 cv=ZobtK87G c=1 sm=1 tr=0 ts=67ff81f0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=8dZIOiBELwY4_KxZuB8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Add enqueue/dequeue operations that use struct rte_dma_op
to communicate with the dma device.
These operations need to be enabled at dma device configuration
time by setting the flag rte_dma_conf::enable_enq_deq if the
device supports RTE_DMA_CAPA_OPS_ENQ_DEQ capability.
The enqueue dequeue operations are not compatible with
rte_dma_copy, rte_dma_copy_sg, rte_dma_fill, rte_dma_submit,
rte_dma_completed, rte_dma_completed_status range of APIs.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/test_dmadev.c               | 160 +++++++++++++++++++++++++++
 app/test/test_dmadev_api.c           |  78 +++++++++++--
 doc/guides/prog_guide/dmadev.rst     |  34 ++++++
 drivers/dma/dpaa/dpaa_qdma.c         |   2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c       |   2 +-
 lib/dmadev/rte_dmadev.c              |  30 ++++-
 lib/dmadev/rte_dmadev.h              | 155 ++++++++++++++++++++++++--
 lib/dmadev/rte_dmadev_core.h         |  10 ++
 lib/dmadev/rte_dmadev_trace.h        |   2 +-
 lib/dmadev/rte_dmadev_trace_fp.h     |  20 ++++
 lib/dmadev/rte_dmadev_trace_points.c |   6 +
 11 files changed, 477 insertions(+), 22 deletions(-)

diff --git a/app/test/test_dmadev.c b/app/test/test_dmadev.c
index 9cbb9a6552..e9a62a0ddf 100644
--- a/app/test/test_dmadev.c
+++ b/app/test/test_dmadev.c
@@ -1052,6 +1052,147 @@ prepare_m2d_auto_free(int16_t dev_id, uint16_t vchan)
 	return 0;
 }
 
+static int
+test_enq_deq_ops(int16_t dev_id, uint16_t vchan)
+{
+#define BURST_SIZE 16
+#define ROUNDS	   2E7
+#define CPY_LEN	   64
+	struct rte_mempool *ops_pool, *pkt_pool;
+	struct rte_mbuf *mbufs[BURST_SIZE * 2];
+	struct rte_dma_op *ops[BURST_SIZE];
+	uint64_t enq_lat, deq_lat, start;
+	int ret, i, j, enq, deq, n, max;
+	struct rte_dma_sge ssg, dsg;
+	struct rte_dma_info info;
+	uint64_t tenq, tdeq;
+
+	memset(&info, 0, sizeof(info));
+	ret = rte_dma_info_get(dev_id, &info);
+	if (ret != 0)
+		ERR_RETURN("Error with rte_dma_info_get()\n");
+
+	pkt_pool = rte_pktmbuf_pool_create("pkt_pool", info.max_desc * 2, 0, 0,
+					   CPY_LEN + RTE_PKTMBUF_HEADROOM, rte_socket_id());
+	if (pkt_pool == NULL)
+		ERR_RETURN("Error creating pkt pool\n");
+
+	ops_pool = rte_mempool_create("ops_pool", info.max_desc,
+				      sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2),
+				      0, 0, NULL, NULL, NULL, NULL, rte_socket_id(), 0);
+	if (ops_pool == NULL)
+		ERR_RETURN("Error creating ops pool\n");
+
+	max = info.max_desc - BURST_SIZE;
+	tenq = 0;
+	tdeq = 0;
+	enq_lat = 0;
+	deq_lat = 0;
+
+	for (i = 0; i < ROUNDS / max; i++) {
+		n = 0;
+		while (n != max) {
+			if (rte_mempool_get_bulk(ops_pool, (void **)ops, BURST_SIZE) != 0)
+				continue;
+
+			if (rte_pktmbuf_alloc_bulk(pkt_pool, mbufs, BURST_SIZE * 2) != 0)
+				ERR_RETURN("Error allocating mbufs %d\n", n);
+
+			for (j = 0; j < BURST_SIZE; j++) {
+				ops[j]->src_dst_seg[0].addr = rte_pktmbuf_iova(mbufs[j]);
+				ops[j]->src_dst_seg[1].addr =
+					rte_pktmbuf_iova(mbufs[j + BURST_SIZE]);
+				ops[j]->src_dst_seg[0].length = CPY_LEN;
+				ops[j]->src_dst_seg[1].length = CPY_LEN;
+
+				ops[j]->nb_src = 1;
+				ops[j]->nb_dst = 1;
+				ops[j]->user_meta = (uint64_t)mbufs[j];
+				ops[j]->event_meta = (uint64_t)mbufs[j + BURST_SIZE];
+
+				memset((void *)(uintptr_t)ops[j]->src_dst_seg[0].addr,
+				       rte_rand() & 0xFF, CPY_LEN);
+				memset((void *)(uintptr_t)ops[j]->src_dst_seg[1].addr, 0, CPY_LEN);
+			}
+
+			start = rte_rdtsc_precise();
+			enq = rte_dma_enqueue_ops(dev_id, vchan, ops, BURST_SIZE);
+			while (enq != BURST_SIZE) {
+				enq += rte_dma_enqueue_ops(dev_id, vchan, ops + enq,
+							   BURST_SIZE - enq);
+			}
+
+			enq_lat += rte_rdtsc_precise() - start;
+			n += enq;
+		}
+		tenq += n;
+
+		memset(ops, 0, sizeof(ops));
+		n = 0;
+		while (n != max) {
+			start = rte_rdtsc_precise();
+			deq = rte_dma_dequeue_ops(dev_id, vchan, ops, BURST_SIZE);
+			while (deq != BURST_SIZE) {
+				deq += rte_dma_dequeue_ops(dev_id, vchan, ops + deq,
+							   BURST_SIZE - deq);
+			}
+			n += deq;
+			deq_lat += rte_rdtsc_precise() - start;
+
+			for (j = 0; j < deq; j++) {
+				/* check the data is correct */
+				ssg = ops[j]->src_dst_seg[0];
+				dsg = ops[j]->src_dst_seg[1];
+				if (memcmp((void *)(uintptr_t)ssg.addr, (void *)(uintptr_t)dsg.addr,
+					   ssg.length) != 0)
+					ERR_RETURN("Error with copy operation\n");
+				rte_pktmbuf_free((struct rte_mbuf *)(uintptr_t)ops[j]->user_meta);
+				rte_pktmbuf_free((struct rte_mbuf *)(uintptr_t)ops[j]->event_meta);
+			}
+			rte_mempool_put_bulk(ops_pool, (void **)ops, BURST_SIZE);
+		}
+		tdeq += n;
+
+		printf("\rEnqueued %" PRIu64 " Latency %.3f Dequeued %" PRIu64 " Latency %.3f",
+		       tenq, (double)enq_lat / tenq, tdeq, (double)deq_lat / tdeq);
+	}
+	printf("\n");
+
+	rte_mempool_free(pkt_pool);
+	rte_mempool_free(ops_pool);
+
+	return 0;
+}
+
+static int
+prepare_enq_deq_ops(int16_t dev_id, uint16_t vchan)
+{
+	const struct rte_dma_conf conf = {.nb_vchans = 1, .flags = RTE_DMA_CFG_FLAG_ENQ_DEQ};
+	struct rte_dma_vchan_conf qconf;
+	struct rte_dma_info info;
+
+	memset(&qconf, 0, sizeof(qconf));
+	memset(&info, 0, sizeof(info));
+
+	int ret = rte_dma_info_get(dev_id, &info);
+	if (ret != 0)
+		ERR_RETURN("Error with rte_dma_info_get()\n");
+
+	qconf.direction = RTE_DMA_DIR_MEM_TO_MEM;
+	qconf.nb_desc = info.max_desc;
+
+	if (rte_dma_stop(dev_id) < 0)
+		ERR_RETURN("Error stopping device %u\n", dev_id);
+	if (rte_dma_configure(dev_id, &conf) != 0)
+		ERR_RETURN("Error with rte_dma_configure()\n");
+	if (rte_dma_vchan_setup(dev_id, vchan, &qconf) < 0)
+		ERR_RETURN("Error with queue configuration\n");
+	if (rte_dma_start(dev_id) != 0)
+		ERR_RETURN("Error with rte_dma_start()\n");
+
+	return 0;
+}
+
 static int
 test_dmadev_sg_copy_setup(void)
 {
@@ -1129,6 +1270,20 @@ test_dmadev_autofree_setup(void)
 	return ret;
 }
 
+static int
+test_dmadev_enq_deq_setup(void)
+{
+	int ret = TEST_SKIPPED;
+
+	if ((info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
+		if (prepare_enq_deq_ops(test_dev_id, vchan) != 0)
+			return ret;
+		ret = TEST_SUCCESS;
+	}
+
+	return ret;
+}
+
 static int
 test_dmadev_setup(void)
 {
@@ -1210,6 +1365,7 @@ test_dmadev_instance(int16_t dev_id)
 		  TEST_ERR,
 		  TEST_FILL,
 		  TEST_M2D,
+		  TEST_ENQ_DEQ,
 		  TEST_END
 	};
 
@@ -1221,6 +1377,7 @@ test_dmadev_instance(int16_t dev_id)
 		{"error_handling", test_completion_handling, 1},
 		{"fill", test_enqueue_fill, 1},
 		{"m2d_auto_free", test_m2d_auto_free, 128},
+		{"dma_enq_deq", test_enq_deq_ops, 1},
 	};
 
 	static struct unit_test_suite ts = {
@@ -1249,6 +1406,9 @@ test_dmadev_instance(int16_t dev_id)
 			TEST_CASE_NAMED_WITH_DATA("m2d_autofree",
 				test_dmadev_autofree_setup, NULL,
 				runtest, &param[TEST_M2D]),
+			TEST_CASE_NAMED_WITH_DATA("dma_enq_deq",
+				test_dmadev_enq_deq_setup, NULL,
+				runtest, &param[TEST_ENQ_DEQ]),
 			TEST_CASES_END()
 		}
 	};
diff --git a/app/test/test_dmadev_api.c b/app/test/test_dmadev_api.c
index fb49fcb56b..1ba053696b 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
@@ -159,7 +159,7 @@ test_dma_configure(void)
 	/* Check enable silent mode */
 	memset(&conf, 0, sizeof(conf));
 	conf.nb_vchans = info.max_vchans;
-	conf.enable_silent = true;
+	conf.flags = RTE_DMA_CFG_FLAG_SILENT;
 	ret = rte_dma_configure(test_dev_id, &conf);
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
@@ -289,7 +289,7 @@ test_dma_vchan_setup(void)
 }
 
 static int
-setup_vchan(int nb_vchans)
+setup_vchan(int nb_vchans, bool ena_enq_deq)
 {
 	struct rte_dma_vchan_conf vchan_conf = { 0 };
 	struct rte_dma_info dev_info = { 0 };
@@ -299,6 +299,7 @@ setup_vchan(int nb_vchans)
 	ret = rte_dma_info_get(test_dev_id, &dev_info);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to obtain device info, %d", ret);
 	dev_conf.nb_vchans = nb_vchans;
+	dev_conf.flags = ena_enq_deq ? RTE_DMA_CFG_FLAG_ENQ_DEQ : 0;
 	ret = rte_dma_configure(test_dev_id, &dev_conf);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to configure, %d", ret);
 	vchan_conf.direction = RTE_DMA_DIR_MEM_TO_MEM;
@@ -325,7 +326,7 @@ test_dma_start_stop(void)
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
 	/* Setup one vchan for later test */
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -359,7 +360,7 @@ test_dma_reconfigure(void)
 		return TEST_SKIPPED;
 
 	/* Setup one vchan for later test */
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -371,7 +372,7 @@ test_dma_reconfigure(void)
 	/* Check reconfigure and vchan setup after device stopped */
 	cfg_vchans = dev_conf.nb_vchans = (dev_info.max_vchans - 1);
 
-	ret = setup_vchan(cfg_vchans);
+	ret = setup_vchan(cfg_vchans, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -403,7 +404,7 @@ test_dma_stats(void)
 	RTE_TEST_ASSERT(ret == -EINVAL, "Expected -EINVAL, %d", ret);
 
 	/* Setup one vchan for later test */
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	/* Check for invalid vchan */
@@ -506,7 +507,7 @@ test_dma_completed(void)
 	int ret;
 
 	/* Setup one vchan for later test */
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -569,7 +570,7 @@ test_dma_completed_status(void)
 	int ret;
 
 	/* Setup one vchan for later test */
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -637,7 +638,7 @@ test_dma_sg(void)
 
 	n_sge = RTE_MIN(dev_info.max_sges, TEST_SG_MAX);
 
-	ret = setup_vchan(1);
+	ret = setup_vchan(1, 0);
 	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
 
 	ret = rte_dma_start(test_dev_id);
@@ -699,6 +700,64 @@ test_dma_sg(void)
 	return TEST_SUCCESS;
 }
 
+static int
+test_dma_ops_enq_deq(void)
+{
+	struct rte_dma_info dev_info = {0};
+	struct rte_dma_op *ops;
+	int n_sge, i, ret;
+
+	ret = rte_dma_info_get(test_dev_id, &dev_info);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to obtain device info, %d", ret);
+	if ((dev_info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ) == 0)
+		return TEST_SKIPPED;
+
+	n_sge = RTE_MIN(dev_info.max_sges, TEST_SG_MAX);
+
+	ret = setup_vchan(1, 1);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to setup one vchan, %d", ret);
+
+	ret = rte_dma_start(test_dev_id);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to start, %d", ret);
+
+	ops = rte_zmalloc(
+		"ops", sizeof(struct rte_dma_op) + ((2 * n_sge) * sizeof(struct rte_dma_sge)), 0);
+
+	for (i = 0; i < n_sge; i++) {
+		ops->src_dst_seg[i].addr = rte_malloc_virt2iova(src_sg[i]);
+		ops->src_dst_seg[i].length = TEST_MEMCPY_SIZE;
+		ops->src_dst_seg[n_sge + i].addr = rte_malloc_virt2iova(dst_sg[i]);
+		ops->src_dst_seg[n_sge + i].length = TEST_MEMCPY_SIZE;
+	}
+
+	ops->nb_src = n_sge;
+	ops->nb_dst = n_sge;
+	sg_memory_setup(n_sge);
+
+	/* Enqueue operations */
+	ret = rte_dma_enqueue_ops(test_dev_id, 0, &ops, 1);
+	RTE_TEST_ASSERT(ret == 1, "Failed to enqueue DMA operations, %d", ret);
+
+	rte_delay_us_sleep(TEST_WAIT_US_VAL);
+
+	ops = NULL;
+	/* Dequeue operations */
+	ret = rte_dma_dequeue_ops(test_dev_id, 0, &ops, 1);
+	RTE_TEST_ASSERT(ret == 1, "Failed to dequeue DMA operations, %d", ret);
+	RTE_TEST_ASSERT(ops != NULL, "Failed to dequeue DMA operations %p", ops);
+	/* Free allocated memory for ops */
+	rte_free(ops);
+
+	ret = sg_memory_verify(n_sge);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to verify memory");
+
+	/* Stop dmadev to make sure dmadev to a known state */
+	ret = rte_dma_stop(test_dev_id);
+	RTE_TEST_ASSERT_SUCCESS(ret, "Failed to stop, %d", ret);
+
+	return TEST_SUCCESS;
+}
+
 static struct unit_test_suite dma_api_testsuite = {
 	.suite_name = "DMA API Test Suite",
 	.setup = testsuite_setup,
@@ -717,6 +776,7 @@ static struct unit_test_suite dma_api_testsuite = {
 		TEST_CASE(test_dma_completed),
 		TEST_CASE(test_dma_completed_status),
 		TEST_CASE(test_dma_sg),
+		TEST_CASE(test_dma_ops_enq_deq),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/prog_guide/dmadev.rst b/doc/guides/prog_guide/dmadev.rst
index 67a62ff420..11b20cc3d6 100644
--- a/doc/guides/prog_guide/dmadev.rst
+++ b/doc/guides/prog_guide/dmadev.rst
@@ -108,6 +108,40 @@ completed operations along with the status of each operation (filled into the
 completed operation's ``ring_idx`` which could help user track operations within
 their own application-defined rings.
 
+Alternatively, if the DMA device supports enqueue and dequeue operations, as
+indicated by ``RTE_DMA_CAPA_OPS_ENQ_DEQ`` capability in ``rte_dma_info::dev_capa``,
+the application can utilize the ``rte_dma_enqueue_ops`` and ``rte_dma_dequeue_ops``
+APIs.
+To enable this, the DMA device must be configured in operations mode by setting
+``RTE_DMA_CFG_FLAG_ENQ_DEQ`` flag in ``rte_dma_config::flags``.
+
+The following example demonstrates the usage of enqueue and dequeue operations:
+
+.. code-block:: C
+
+   struct rte_dma_op *op;
+
+   op = rte_zmalloc(sizeof(struct rte_dma_op) + (sizeof(struct rte_dma_sge) * 2), 0);
+
+   op->src_dst_seg[0].addr = src_addr;
+   op->src_dst_seg[0].length = src_len;
+   op->src_dst_seg[1].addr = dst_addr;
+   op->src_dst_seg[1].length = dst_len;
+
+
+   ret = rte_dma_enqueue_ops(dev_id, &op, 1);
+   if (ret < 0) {
+       PRINT_ERR("Failed to enqueue DMA op\n");
+       return -1;
+   }
+
+   op = NULL;
+   ret = rte_dma_dequeue_ops(dev_id, &op, 1);
+   if (ret < 0) {
+       PRINT_ERR("Failed to dequeue DMA op\n");
+       return -1;
+   }
+
 
 Querying Device Statistics
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index a541398e48..74e23d2ee5 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -954,7 +954,7 @@ dpaa_qdma_configure(struct rte_dma_dev *dmadev,
 {
 	struct fsl_qdma_engine *fsl_qdma = dmadev->data->dev_private;
 
-	fsl_qdma->is_silent = dev_conf->enable_silent;
+	fsl_qdma->is_silent = dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT;
 	return 0;
 }
 
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3c9a7b5485..ca18fe89c5 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1277,7 +1277,7 @@ dpaa2_qdma_configure(struct rte_dma_dev *dev,
 	}
 
 	qdma_dev->num_vqs = dev_conf->nb_vchans;
-	qdma_dev->is_silent = dev_conf->enable_silent;
+	qdma_dev->is_silent = dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT;
 
 	return 0;
 
diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 17ee0808a9..73d24f8ff3 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -509,7 +509,7 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 			"Device %d configure too many vchans", dev_id);
 		return -EINVAL;
 	}
-	if (dev_conf->enable_silent &&
+	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_SILENT) &&
 	    !(dev_info.dev_capa & RTE_DMA_CAPA_SILENT)) {
 		RTE_DMA_LOG(ERR, "Device %d don't support silent", dev_id);
 		return -EINVAL;
@@ -521,6 +521,12 @@ rte_dma_configure(int16_t dev_id, const struct rte_dma_conf *dev_conf)
 		return -EINVAL;
 	}
 
+	if ((dev_conf->flags & RTE_DMA_CFG_FLAG_ENQ_DEQ) &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_OPS_ENQ_DEQ)) {
+		RTE_DMA_LOG(ERR, "Device %d don't support enqueue/dequeue", dev_id);
+		return -EINVAL;
+	}
+
 	if (dev->dev_ops->dev_configure == NULL)
 		return -ENOTSUP;
 	ret = dev->dev_ops->dev_configure(dev, dev_conf, sizeof(struct rte_dma_conf));
@@ -863,7 +869,9 @@ rte_dma_dump(int16_t dev_id, FILE *f)
 	(void)fprintf(f, "  max_vchans_supported: %u\n", dev_info.max_vchans);
 	(void)fprintf(f, "  nb_vchans_configured: %u\n", dev_info.nb_vchans);
 	(void)fprintf(f, "  silent_mode: %s\n",
-		dev->data->dev_conf.enable_silent ? "on" : "off");
+		      dev->data->dev_conf.flags & RTE_DMA_CFG_FLAG_SILENT ? "on" : "off");
+	(void)fprintf(f, "  ops_mode: %s\n",
+		      dev->data->dev_conf.flags & RTE_DMA_CFG_FLAG_ENQ_DEQ ? "on" : "off");
 
 	if (dev->dev_ops->dev_dump != NULL)
 		ret = dev->dev_ops->dev_dump(dev, f);
@@ -937,6 +945,22 @@ dummy_burst_capacity(__rte_unused const void *dev_private,
 	return 0;
 }
 
+static uint16_t
+dummy_enqueue(__rte_unused void *dev_private, __rte_unused uint16_t vchan,
+	      __rte_unused struct rte_dma_op **ops, __rte_unused uint16_t nb_ops)
+{
+	RTE_DMA_LOG(ERR, "Enqueue not configured or not supported.");
+	return 0;
+}
+
+static uint16_t
+dummy_dequeue(__rte_unused void *dev_private, __rte_unused uint16_t vchan,
+	      __rte_unused struct rte_dma_op **ops, __rte_unused uint16_t nb_ops)
+{
+	RTE_DMA_LOG(ERR, "Enqueue not configured or not supported.");
+	return 0;
+}
+
 static void
 dma_fp_object_dummy(struct rte_dma_fp_object *obj)
 {
@@ -948,6 +972,8 @@ dma_fp_object_dummy(struct rte_dma_fp_object *obj)
 	obj->completed        = dummy_completed;
 	obj->completed_status = dummy_completed_status;
 	obj->burst_capacity   = dummy_burst_capacity;
+	obj->enqueue          = dummy_enqueue;
+	obj->dequeue          = dummy_dequeue;
 }
 
 static int
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 550dbfbf75..d88424d699 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -275,8 +275,22 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
 #define RTE_DMA_CAPA_OPS_COPY_SG	RTE_BIT64(33)
 /** Support fill operation. */
 #define RTE_DMA_CAPA_OPS_FILL		RTE_BIT64(34)
+/** Support enqueue and dequeue operations. */
+#define RTE_DMA_CAPA_OPS_ENQ_DEQ	RTE_BIT64(35)
 /**@}*/
 
+/** DMA device configuration flags.
+ * @see struct rte_dma_conf::flags
+ */
+/** Operate in silent mode
+ * @see RTE_DMA_CAPA_SILENT
+ */
+#define RTE_DMA_CFG_FLAG_SILENT RTE_BIT64(0)
+/** Enable enqueue and dequeue operations
+ * @see RTE_DMA_CAPA_OPS_ENQ_DEQ
+ */
+#define RTE_DMA_CFG_FLAG_ENQ_DEQ RTE_BIT64(1)
+
 /**
  * A structure used to retrieve the information of a DMA device.
  *
@@ -335,14 +349,6 @@ struct rte_dma_conf {
 	 * rte_dma_info which get from rte_dma_info_get().
 	 */
 	uint16_t nb_vchans;
-	/** Indicates whether to enable silent mode.
-	 * false-default mode, true-silent mode.
-	 * This value can be set to true only when the SILENT capability is
-	 * supported.
-	 *
-	 * @see RTE_DMA_CAPA_SILENT
-	 */
-	bool enable_silent;
 	/* The priority of the DMA device.
 	 * This value should be lower than the field 'nb_priorities' of struct
 	 * rte_dma_info which get from rte_dma_info_get(). If the DMA device
@@ -351,6 +357,8 @@ struct rte_dma_conf {
 	 * Lowest value indicates higher priority and vice-versa.
 	 */
 	uint16_t priority;
+	/** DMA device configuration flags defined as RTE_DMA_CFG_FLAG_*. */
+	uint64_t flags;
 };
 
 /**
@@ -794,6 +802,63 @@ struct rte_dma_sge {
 	uint32_t length; /**< The DMA operation length. */
 };
 
+/**
+ * A structure used to hold event based DMA operation entry. All the information
+ * required for a DMA transfer shall be populated in "struct rte_dma_op"
+ * instance.
+ */
+struct rte_dma_op {
+	uint64_t flags;
+	/**< Flags related to the operation.
+	 * @see RTE_DMA_OP_FLAG_*
+	 */
+	struct rte_mempool *op_mp;
+	/**< Mempool from which op is allocated. */
+	enum rte_dma_status_code status;
+	/**< Status code for this operation. */
+	uint32_t rsvd;
+	/**< Reserved for future use. */
+	uint64_t impl_opaque[2];
+	/**< Implementation-specific opaque data.
+	 * An dma device implementation use this field to hold
+	 * implementation specific values to share between dequeue and enqueue
+	 * operations.
+	 * The application should not modify this field.
+	 */
+	uint64_t user_meta;
+	/**<  Memory to store user specific metadata.
+	 * The dma device implementation should not modify this area.
+	 */
+	uint64_t event_meta;
+	/**< Event metadata of DMA completion event.
+	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND is not
+	 * supported in OP_NEW mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_NEW
+	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_VCHAN_EV_BIND
+	 *
+	 * Used when RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD is not
+	 * supported in OP_FWD mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 * @see RTE_EVENT_DMA_ADAPTER_CAP_INTERNAL_PORT_OP_FWD
+	 *
+	 * @see struct rte_event::event
+	 */
+	int16_t dma_dev_id;
+	/**< DMA device ID to be used with OP_FORWARD mode.
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 */
+	uint16_t vchan;
+	/**< DMA vchan ID to be used with OP_FORWARD mode
+	 * @see rte_event_dma_adapter_mode::RTE_EVENT_DMA_ADAPTER_OP_FORWARD
+	 */
+	uint16_t nb_src;
+	/**< Number of source segments. */
+	uint16_t nb_dst;
+	/**< Number of destination segments. */
+	struct rte_dma_sge src_dst_seg[0];
+	/**< Source and destination segments. */
+};
+
 #ifdef __cplusplus
 }
 #endif
@@ -1153,6 +1218,80 @@ rte_dma_burst_capacity(int16_t dev_id, uint16_t vchan)
 	return ret;
 }
 
+/**
+ * Enqueue rte_dma_ops to DMA device, can only be used underlying supports
+ * RTE_DMA_CAPA_OPS_ENQ_DEQ and rte_dma_conf::enable_enq_deq is enabled in
+ * rte_dma_configure()
+ * The ops enqueued will be immediately submitted to the DMA device.
+ * The enqueue should be coupled with dequeue to retrieve completed ops, calls
+ * to rte_dma_submit(), rte_dma_completed() and rte_dma_completed_status()
+ * are not valid.
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param vchan
+ *   The identifier of virtual DMA channel.
+ * @param ops
+ *   Pointer to rte_dma_op array.
+ * @param nb_ops
+ *   Number of rte_dma_op in the ops array
+ * @return uint16_t
+ *   - Number of successfully submitted ops.
+ */
+static inline uint16_t
+rte_dma_enqueue_ops(int16_t dev_id, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct rte_dma_fp_object *obj = &rte_dma_fp_objs[dev_id];
+	uint16_t ret;
+
+#ifdef RTE_DMADEV_DEBUG
+	if (!rte_dma_is_valid(dev_id))
+		return 0;
+	if (*obj->enqueue == NULL)
+		return 0;
+#endif
+
+	ret = (*obj->enqueue)(obj->dev_private, vchan, ops, nb_ops);
+	rte_dma_trace_enqueue_ops(dev_id, vchan, (void **)ops, nb_ops);
+
+	return ret;
+}
+
+/**
+ * Dequeue completed rte_dma_ops submitted to the DMA device, can only be used
+ * underlying supports RTE_DMA_CAPA_OPS_ENQ_DEQ and rte_dma_conf::enable_enq_deq
+ * is enabled in rte_dma_configure()
+ *
+ * @param dev_id
+ *   The identifier of the device.
+ * @param vchan
+ *   The identifier of virtual DMA channel.
+ * @param ops
+ *   Pointer to rte_dma_op array.
+ * @param nb_ops
+ *   Size of rte_dma_op array.
+ * @return
+ *   - Number of successfully completed ops. Should be less or equal to nb_ops.
+ */
+static inline uint16_t
+rte_dma_dequeue_ops(int16_t dev_id, uint16_t vchan, struct rte_dma_op **ops, uint16_t nb_ops)
+{
+	struct rte_dma_fp_object *obj = &rte_dma_fp_objs[dev_id];
+	uint16_t ret;
+
+#ifdef RTE_DMADEV_DEBUG
+	if (!rte_dma_is_valid(dev_id))
+		return 0;
+	if (*obj->dequeue == NULL)
+		return 0;
+#endif
+
+	ret = (*obj->dequeue)(obj->dev_private, vchan, ops, nb_ops);
+	rte_dma_trace_dequeue_ops(dev_id, vchan, (void **)ops, nb_ops);
+
+	return ret;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/dmadev/rte_dmadev_core.h b/lib/dmadev/rte_dmadev_core.h
index 29f52514d7..20a467178f 100644
--- a/lib/dmadev/rte_dmadev_core.h
+++ b/lib/dmadev/rte_dmadev_core.h
@@ -50,6 +50,14 @@ typedef uint16_t (*rte_dma_completed_status_t)(void *dev_private,
 /** @internal Used to check the remaining space in descriptor ring. */
 typedef uint16_t (*rte_dma_burst_capacity_t)(const void *dev_private, uint16_t vchan);
 
+/** @internal Used to enqueue a rte_dma_op to the dma engine. */
+typedef uint16_t (*rte_dma_enqueue_ops_t)(void *dev_private, uint16_t vchan,
+					  struct rte_dma_op **ops, uint16_t nb_ops);
+
+/** @internal Used to dequeue rte_dma_op from the dma engine. */
+typedef uint16_t (*rte_dma_dequeue_ops_t)(void *dev_private, uint16_t vchan,
+					  struct rte_dma_op **ops, uint16_t nb_ops);
+
 /**
  * @internal
  * Fast-path dmadev functions and related data are hold in a flat array.
@@ -73,6 +81,8 @@ struct __rte_cache_aligned rte_dma_fp_object {
 	rte_dma_completed_t        completed;
 	rte_dma_completed_status_t completed_status;
 	rte_dma_burst_capacity_t   burst_capacity;
+	rte_dma_enqueue_ops_t      enqueue;
+	rte_dma_dequeue_ops_t      dequeue;
 };
 
 extern struct rte_dma_fp_object *rte_dma_fp_objs;
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index 1de92655f2..04d9a2741b 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -41,7 +41,7 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_i16(dev_id);
 	rte_trace_point_emit_u16(dev_conf->nb_vchans);
 	rte_trace_point_emit_u16(dev_conf->priority);
-	rte_trace_point_emit_u8(dev_conf->enable_silent);
+	rte_trace_point_emit_u64(dev_conf->flags);
 	rte_trace_point_emit_int(ret);
 )
 
diff --git a/lib/dmadev/rte_dmadev_trace_fp.h b/lib/dmadev/rte_dmadev_trace_fp.h
index a1374e78b7..3db655fa65 100644
--- a/lib/dmadev/rte_dmadev_trace_fp.h
+++ b/lib/dmadev/rte_dmadev_trace_fp.h
@@ -125,6 +125,26 @@ RTE_TRACE_POINT_FP(
 	rte_trace_point_emit_u16(ret);
 )
 
+RTE_TRACE_POINT_FP(
+	rte_dma_trace_enqueue_ops,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan, void **ops,
+			     uint16_t nb_ops),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u16(vchan);
+	rte_trace_point_emit_ptr(ops);
+	rte_trace_point_emit_u16(nb_ops);
+)
+
+RTE_TRACE_POINT_FP(
+	rte_dma_trace_dequeue_ops,
+	RTE_TRACE_POINT_ARGS(int16_t dev_id, uint16_t vchan, void **ops,
+			     uint16_t nb_ops),
+	rte_trace_point_emit_i16(dev_id);
+	rte_trace_point_emit_u16(vchan);
+	rte_trace_point_emit_ptr(ops);
+	rte_trace_point_emit_u16(nb_ops);
+)
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/dmadev/rte_dmadev_trace_points.c b/lib/dmadev/rte_dmadev_trace_points.c
index 1c8998fb98..9a97a44a9c 100644
--- a/lib/dmadev/rte_dmadev_trace_points.c
+++ b/lib/dmadev/rte_dmadev_trace_points.c
@@ -64,3 +64,9 @@ RTE_TRACE_POINT_REGISTER(rte_dma_trace_completed_status,
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_dma_trace_burst_capacity, 24.03)
 RTE_TRACE_POINT_REGISTER(rte_dma_trace_burst_capacity,
 	lib.dmadev.burst_capacity)
+
+RTE_TRACE_POINT_REGISTER(rte_dma_trace_enqueue_ops,
+	lib.dmadev.enqueue_ops)
+
+RTE_TRACE_POINT_REGISTER(rte_dma_trace_dequeue_ops,
+	lib.dmadev.dequeue_ops)
-- 
2.43.0

