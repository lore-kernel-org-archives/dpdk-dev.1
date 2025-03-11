Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F4C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 10:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A454402CE;
	Wed, 12 Mar 2025 11:52:21 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 00C744014F
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:58:55 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCCjuM028580;
 Tue, 11 Mar 2025 08:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=ws+k8scuvSUDLUG5koeGr+z
 uR8/w4NSNhbNjohCr6dI=; b=OuBGJWe6DMhZ9tiDOC7dIgtOpLgaQdo72kLHG0A
 9Ga/PJc04fWM0nIxagUmvt/qSoKUeZlzlhLIIZiXMO4K8JNF1uRLYXyv9J3hSLVc
 IOp04cTj7skBXilLefSa7StnMWUHPJBdvT/OV05peDsO36QF3iPmArK4kj21E4m/
 qBlk57tuj/XgktYpGrdkHEWnoFeV26azMeRR51HdK/W5XLwrT+0VpD+5YntyC8yG
 w6ObqOvOWiTeAB9enZZc5k7MGm1IJ1UBhRLITXa8QOx+BA0O7nwDomZnNvvXRih2
 QR4s83/ETRyivdn67lBPV/s8sOfFZ2zSEjdg4fMgFIcpz2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45aj57rv2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 11 Mar 2025 08:58:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 11 Mar 2025 08:58:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 11 Mar 2025 08:58:54 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id B5ED53F706B;
 Tue, 11 Mar 2025 08:58:52 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Brian Dooley <brian.dooley@intel.com>
CC: <dev@dpdk.org>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: [PATCH] app/crypto-perf: avoid infinite loop
Date: Tue, 11 Mar 2025 21:28:50 +0530
Message-ID: <20250311155850.1043336-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zjF1jjKmGl1BofDl0_VAIq0FgIIjfjD4
X-Proofpoint-ORIG-GUID: zjF1jjKmGl1BofDl0_VAIq0FgIIjfjD4
X-Authority-Analysis: v=2.4 cv=FdvNxI+6 c=1 sm=1 tr=0 ts=67d05dbe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Vs1iUdzkB0EA:10 a=M5GUcnROAAAA:8 a=RPQ6iex-LfstfHzdtwYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Mailman-Approved-At: Wed, 12 Mar 2025 11:52:20 +0100
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

The enqueue/dequeue loop's exit condition is
(ops_enqd_total >= total_ops). If the PMD driver cannot process the
ops (returns zero), ops_enqd_total won't increase, resulting in an
infinite loop. A check is added to process one op to determine
whether PMD can process the packet.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 app/test-crypto-perf/cperf_test_latency.c    | 54 +++++++++++++++++++
 app/test-crypto-perf/cperf_test_throughput.c | 55 ++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/app/test-crypto-perf/cperf_test_latency.c b/app/test-crypto-perf/cperf_test_latency.c
index 2dd504b434..b501618d46 100644
--- a/app/test-crypto-perf/cperf_test_latency.c
+++ b/app/test-crypto-perf/cperf_test_latency.c
@@ -140,6 +140,56 @@ store_timestamp(struct rte_crypto_op *op, uint64_t timestamp)
 	priv_data->result->tsc_end = timestamp;
 }
 
+static int
+cperf_check_single_op(struct cperf_latency_ctx *ctx, uint16_t iv_offset)
+{
+	struct rte_crypto_op *ops[1];
+	uint32_t imix_idx = 0;
+	uint64_t tsc_start = 0;
+	uint64_t ops_enqd = 0, ops_deqd = 0;
+
+	/* Allocate object containing crypto operations and mbufs */
+	if (rte_mempool_get(ctx->pool, (void **)&ops[0]) != 0) {
+		RTE_LOG(ERR, USER1,
+			"Failed to allocate crypto operation "
+			"from the crypto operation pool.\n"
+			"Consider increasing the pool size "
+			"with --pool-sz\n");
+		return -1;
+	}
+
+	/* Setup crypto op, attach mbuf etc */
+	(ctx->populate_ops)(ops, ctx->src_buf_offset,
+		ctx->dst_buf_offset,
+		1, ctx->sess, ctx->options,
+		ctx->test_vector, iv_offset,
+		&imix_idx, &tsc_start);
+
+	ops_enqd = rte_cryptodev_enqueue_burst(ctx->dev_id, ctx->qp_id, ops, 1);
+	if (ops_enqd != 1) {
+		RTE_LOG(ERR, USER1, "PMD cannot process the packet.\n");
+		return -1;
+	}
+
+	/* Dequeue processed burst of ops from crypto device */
+	tsc_start = rte_rdtsc_precise();
+	while (1) {
+		ops_deqd = rte_cryptodev_dequeue_burst(ctx->dev_id, ctx->qp_id,
+				ops, 1);
+
+		if (ops_deqd == 1) {
+			rte_mempool_put(ctx->pool, ops[0]);
+			return 1;
+		}
+
+		/* Check if 1 second timeout has been reached */
+		if ((rte_rdtsc_precise() - tsc_start) > rte_get_tsc_hz()) {
+			RTE_LOG(ERR, USER1, "Dequeue operation timed out.\n");
+			return -1;
+		}
+	}
+}
+
 int
 cperf_latency_test_runner(void *arg)
 {
@@ -190,6 +240,10 @@ cperf_latency_test_runner(void *arg)
 		sizeof(struct rte_crypto_sym_op) +
 		sizeof(struct cperf_op_result *);
 
+	/* Enqueue just one operation to check whether PMD returns error */
+	if (cperf_check_single_op(ctx, iv_offset) < 1)
+		return -1;
+
 	while (test_burst_size <= ctx->options->max_burst_size) {
 		uint64_t ops_enqd = 0, ops_deqd = 0;
 		uint64_t b_idx = 0;
diff --git a/app/test-crypto-perf/cperf_test_throughput.c b/app/test-crypto-perf/cperf_test_throughput.c
index c8960ab855..13b16d9670 100644
--- a/app/test-crypto-perf/cperf_test_throughput.c
+++ b/app/test-crypto-perf/cperf_test_throughput.c
@@ -128,6 +128,57 @@ cperf_verify_init_ops(struct rte_mempool *mp __rte_unused,
 	cperf_mbuf_set(op->sym->m_src, ctx->options, ctx->test_vector);
 }
 
+static int
+cperf_check_single_op(struct cperf_throughput_ctx *ctx, uint16_t iv_offset)
+{
+	struct rte_crypto_op *ops[1];
+	uint32_t imix_idx = 0;
+	uint64_t tsc_start = 0;
+	uint64_t ops_enqd = 0, ops_deqd = 0;
+
+	/* Allocate object containing crypto operations and mbufs */
+	if (rte_mempool_get(ctx->pool, (void **)&ops[0]) != 0) {
+		RTE_LOG(ERR, USER1,
+			"Failed to allocate crypto operation "
+			"from the crypto operation pool.\n"
+			"Consider increasing the pool size "
+			"with --pool-sz\n");
+		return -1;
+	}
+
+	/* Setup crypto op, attach mbuf etc */
+	if (!ctx->options->out_of_place)
+		(ctx->populate_ops)(ops, ctx->src_buf_offset,
+				ctx->dst_buf_offset,
+				1, ctx->sess,
+				ctx->options, ctx->test_vector,
+				iv_offset, &imix_idx, &tsc_start);
+
+	ops_enqd = rte_cryptodev_enqueue_burst(ctx->dev_id, ctx->qp_id, ops, 1);
+	if (ops_enqd != 1) {
+		RTE_LOG(ERR, USER1, "PMD cannot process the packet.\n");
+		return -1;
+	}
+
+	/* Dequeue processed burst of ops from crypto device */
+	tsc_start = rte_rdtsc_precise();
+	while (1) {
+		ops_deqd = rte_cryptodev_dequeue_burst(ctx->dev_id, ctx->qp_id,
+				ops, 1);
+
+		if (ops_deqd == 1) {
+			rte_mempool_put(ctx->pool, ops[0]);
+			return 1;
+		}
+
+		/* Check if 1 second timeout has been reached */
+		if ((rte_rdtsc_precise() - tsc_start) > rte_get_tsc_hz()) {
+			RTE_LOG(ERR, USER1, "Dequeue operation timed out.\n");
+			return -1;
+		}
+	}
+}
+
 int
 cperf_throughput_test_runner(void *test_ctx)
 {
@@ -176,6 +227,10 @@ cperf_throughput_test_runner(void *test_ctx)
 	if (ctx->options->out_of_place)
 		rte_mempool_obj_iter(ctx->pool, cperf_verify_init_ops, (void *)ctx);
 
+	/* Enqueue just one operation to check whether PMD returns error */
+	if (cperf_check_single_op(ctx, iv_offset) < 1)
+		return -1;
+
 	while (test_burst_size <= ctx->options->max_burst_size) {
 		uint64_t ops_enqd = 0, ops_enqd_total = 0, ops_enqd_failed = 0;
 		uint64_t ops_deqd = 0, ops_deqd_total = 0, ops_deqd_failed = 0;
-- 
2.48.1

