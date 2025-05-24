Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED63C54F2E
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 May 2025 09:13:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 839C140E1B;
	Sat, 24 May 2025 11:13:45 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7136440E17
 for <dev@dpdk.org>; Sat, 24 May 2025 11:13:44 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O8HXOW027281;
 Sat, 24 May 2025 02:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 PN4r7qqusAmP2TC0ibBHZeXthWEdXrV/yhKVsiVprg=; b=IMiz6hvn3rqpwcjfJ
 73csnMJ/FVdikoR+x9q2lPthB2i0u8i2V03kZj+Uib9yftV0h5ixGjejzW79xKgf
 7PBzsfhp70APNoSK3BrLWg4TSjLcV8DPiYDK4zByku2gbsh8F3gU9dIHfTKqsc5Z
 3NwCTetTXeXmmjMCS3ZkoB596onckOJJRyMdK4Qp5GfdkHLRVjsulZbds4vUr+Fh
 1n0BHdZPpRrGFs1EJmGLwpKzcEBaIz90ncVgrUfHWjX3jGs9nBJmesnFsPzKOZ8S
 ZIP7jzoR7sqLb543YckLH0Zz5pyB5G57/P9uxGeRF6ODSGwwRWB5+TCNO2lFVU7q
 dBmfA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46u5dk0bfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 May 2025 02:13:43 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 24 May 2025 02:13:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 24 May 2025 02:13:42 -0700
Received: from MININT-80QBFE8.corp.innovium.com (MININT-80QBFE8.marvell.com
 [10.28.164.118])
 by maili.marvell.com (Postfix) with ESMTP id 1C4EC3F7079;
 Sat, 24 May 2025 02:13:37 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Chengwen Feng <fengchengwen@huawei.com>, Kevin Laatz
 <kevin.laatz@intel.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <vattunuru@marvell.com>, <g.singh@nxp.com>, <sachin.saxena@nxp.com>,
 <hemant.agrawal@nxp.com>, <conor.walsh@intel.com>,
 <gmuthukrishn@marvell.com>, <vvelumuri@marvell.com>,
 <anatoly.burakov@intel.com>, <dev@dpdk.org>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>
Subject: [25.11 PATCH v3 2/5] test/dma: add enqueue dequeue operations
Date: Sat, 24 May 2025 14:43:12 +0530
Message-ID: <20250524091316.10056-3-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524091316.10056-1-pbhagavatula@marvell.com>
References: <20250519185604.5584-1-pbhagavatula@marvell.com>
 <20250524091316.10056-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDA4MyBTYWx0ZWRfX+zNGtjJ7bACa
 Egqq0rtP88x/livxhCIXTtOAhkzFS9crwVd1uumxSCm6de/GmwrFx++6oVLlJ1ComPZLrO/NbzR
 u09f4d+F3mQUBSP2oHbFwQ64QbdT4TkTg9A/zI1XrumyDZb/oP7fjx3I9GN2EfNeqesMb44eWMb
 LnI4sFz/jrt0TZsSI/2S5iyjtPOQi2fEZDMOVZphZuan65eM/recdDN76g6sCrnOPjSqI8kQzBp
 C5iz05LWmfvXA8Omv4KzLMgMpISngDwi/erZKx/Vbio0cEWo80jmRgO1gcIzqPxpTdWSct9VnOK
 bo6/jNrNl0SZNI0cIqUEPkYk733yFpVn0t6T4q1yfebWRjJddwInEQdrSzY1dek1Bw9U2cKK4Xh
 3NFTTqdAdyVcg9X77xweXCcUKflQi5B9kESAowt8oxcfV88Ev6Fo5bSHx0cxJf3kobT2ttqZ
X-Authority-Analysis: v=2.4 cv=HpV2G1TS c=1 sm=1 tr=0 ts=68318dc7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=K0hZK82awePDIfUgRKoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: iG3rmMPLXM28uYMjx51fyYSX9UCW0wfK
X-Proofpoint-GUID: iG3rmMPLXM28uYMjx51fyYSX9UCW0wfK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_04,2025-05-22_01,2025-03-28_01
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

Add enqueue dequeue operations tests.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/test_dmadev.c     | 160 +++++++++++++++++++++++++++++++++++++
 app/test/test_dmadev_api.c |  76 ++++++++++++++++--
 2 files changed, 228 insertions(+), 8 deletions(-)

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
index 1ae85a9a29..1ba053696b 100644
--- a/app/test/test_dmadev_api.c
+++ b/app/test/test_dmadev_api.c
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
-- 
2.43.0

