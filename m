Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82425C71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 15:24:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48127427C6;
	Thu, 12 Jun 2025 17:24:48 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 6566C42796
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:24:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id A29FA201C749; Thu, 12 Jun 2025 08:24:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A29FA201C749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749741886;
 bh=fDpuuLcmiF2TZOnw3r94OHlmRa/r0NbIQiy4L2sCJSE=;
 h=From:To:Cc:Subject:Date:From;
 b=X1QiSyqbfX8bSDOiGIdUqy/jSPw273gktyApg8xvT+mAcO49BpmvL6JBy+Kmp2oTa
 Q8dJvXPawd2Ul3mLwrqxZ4LVtMrpI+Cd5Js5gScpcNVGTXZDSFjyF8hBR4UPl6e2U6
 D6a48Cdfz1X6TFbJd7ntJh0N3AfCzWoXYuO7UtsA=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Nicolas Chautru <nicolas.chautru@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] test_bbdev: enable to be compiled on Windows
Date: Thu, 12 Jun 2025 08:24:43 -0700
Message-Id: <1749741884-13081-1-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
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

This patch fixes a few issues which were preventing this test from
getting compiled on Windows:

1) VLAs were removed: Variable Length Arrays are not supported by MSVC.
Where possible constant C arrays were used. Where that approach was not
possible alloca() was called instead.

2) rte_os_shim is included because this test relies on getline()
function, which is not provided by Windows APIs.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 app/test-bbdev/main.c                 |   1 +
 app/test-bbdev/meson.build            |   6 --
 app/test-bbdev/test_bbdev.c           |   8 +-
 app/test-bbdev/test_bbdev_perf.c      | 126 ++++++++++++++------------
 app/test-bbdev/test_bbdev_vector.c    |   1 +
 lib/eal/windows/include/rte_os_shim.h |   1 +
 6 files changed, 76 insertions(+), 67 deletions(-)

diff --git a/app/test-bbdev/main.c b/app/test-bbdev/main.c
index 8f6852e2ef..aee8dbb0fa 100644
--- a/app/test-bbdev/main.c
+++ b/app/test-bbdev/main.c
@@ -14,6 +14,7 @@
 #include <rte_string_fns.h>
 #include <rte_cycles.h>
 #include <rte_lcore.h>
+#include <rte_os_shim.h>
 
 #include "main.h"
 
diff --git a/app/test-bbdev/meson.build b/app/test-bbdev/meson.build
index 85b060edec..f85a20c5b0 100644
--- a/app/test-bbdev/meson.build
+++ b/app/test-bbdev/meson.build
@@ -1,12 +1,6 @@
 # SPDX-License-Identifier: BSD-3-Clause
 # Copyright(c) 2018 Intel Corporation
 
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
 sources = files(
         'main.c',
         'test_bbdev.c',
diff --git a/app/test-bbdev/test_bbdev.c b/app/test-bbdev/test_bbdev.c
index 0bbce6ca92..2422312f6b 100644
--- a/app/test-bbdev/test_bbdev.c
+++ b/app/test-bbdev/test_bbdev.c
@@ -548,9 +548,9 @@ test_bbdev_op_pool(void)
 static int
 test_bbdev_op_type(void)
 {
+#define OPS_COUNT 32
 	struct rte_mempool *mp_dec;
 
-	const unsigned int OPS_COUNT = 32;
 	struct rte_bbdev_dec_op *dec_ops_arr[OPS_COUNT];
 	struct rte_bbdev_enc_op *enc_ops_arr[OPS_COUNT];
 
@@ -576,14 +576,15 @@ test_bbdev_op_type(void)
 	rte_mempool_free(mp_dec);
 
 	return TEST_SUCCESS;
+#undef OPS_COUNT
 }
 
 static int
 test_bbdev_op_pool_size(void)
 {
+#define OPS_COUNT 128
 	struct rte_mempool *mp_none;
 
-	const unsigned int OPS_COUNT = 128;
 	struct rte_bbdev_enc_op *ops_enc_arr[OPS_COUNT];
 	struct rte_bbdev_enc_op *ops_ext_arr[OPS_COUNT];
 	struct rte_bbdev_enc_op *ops_ext2_arr[OPS_COUNT];
@@ -627,6 +628,7 @@ test_bbdev_op_pool_size(void)
 	rte_mempool_free(mp_none);
 
 	return TEST_SUCCESS;
+#undef OPS_COUNT
 }
 
 static int
@@ -815,7 +817,7 @@ test_bbdev_driver_init(void)
 
 	TEST_ASSERT(dev1->data->dev_id < RTE_BBDEV_MAX_DEVS,
 			"Failed test rte_bbdev_allocate: "
-			"invalid dev_id %" PRIu8 ", max number of devices %d ",
+			"invalid dev_id %" PRIu16 ", max number of devices %d ",
 			dev1->data->dev_id, RTE_BBDEV_MAX_DEVS);
 
 	TEST_ASSERT(dev1->state == RTE_BBDEV_INITIALIZED,
diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index 6ee1ca34b2..27b0a6f523 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -1570,12 +1570,13 @@ maxstar(double A, double B)
 static void
 gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 {
-	int qm = 8;
-	int qam = 256;
+#define QM 8
+#define QAM 256
+
 	int m, k;
-	double I, Q, p0, p1, llr_, b[qm], log_syml_prob[qam];
+	double I, Q, p0, p1, llr_, b[QM], log_syml_prob[QAM];
 	/* 5.1.4 of TS38.211 */
-	const double symbols_I[256] = {
+	const double symbols_I[QAM] = {
 			5, 5, 7, 7, 5, 5, 7, 7, 3, 3, 1, 1, 3, 3, 1, 1, 5,
 			5, 7, 7, 5, 5, 7, 7, 3, 3, 1, 1, 3, 3, 1, 1, 11,
 			11, 9, 9, 11, 11, 9, 9, 13, 13, 15, 15, 13, 13,
@@ -1596,7 +1597,7 @@ gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			-9, -9, -11, -11, -9, -9, -13, -13, -15, -15, -13,
 			-13, -15, -15, -11, -11, -9, -9, -11, -11, -9, -9,
 			-13, -13, -15, -15, -13, -13, -15, -15};
-	const double symbols_Q[256] = {
+	const double symbols_Q[QAM] = {
 			5, 7, 5, 7, 3, 1, 3, 1, 5, 7, 5, 7, 3, 1, 3, 1, 11,
 			9, 11, 9, 13, 15, 13, 15, 11, 9, 11, 9, 13, 15, 13,
 			15, 5, 7, 5, 7, 3, 1, 3, 1, 5, 7, 5, 7, 3, 1, 3, 1,
@@ -1619,8 +1620,8 @@ gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			-13, -15, -11, -9, -11, -9, -13, -15, -13, -15};
 	/* Average constellation point energy */
 	N0 *= 170.0;
-	for (k = 0; k < qm; k++)
-		b[k] = llrs[qm * i + k] < 0 ? 1.0 : 0.0;
+	for (k = 0; k < QM; k++)
+		b[k] = llrs[QM * i + k] < 0 ? 1.0 : 0.0;
 	/* 5.1.4 of TS38.211 */
 	I = (1 - 2 * b[0]) * (8 - (1 - 2 * b[2]) *
 			(4 - (1 - 2 * b[4]) * (2 - (1 - 2 * b[6]))));
@@ -1633,16 +1634,16 @@ gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 	 * Calculate the log of the probability that each of
 	 * the constellation points was transmitted
 	 */
-	for (m = 0; m < qam; m++)
+	for (m = 0; m < QAM; m++)
 		log_syml_prob[m] = -(pow(I - symbols_I[m], 2.0)
 				+ pow(Q - symbols_Q[m], 2.0)) / N0;
 	/* Calculate an LLR for each of the k_64QAM bits in the set */
-	for (k = 0; k < qm; k++) {
+	for (k = 0; k < QM; k++) {
 		p0 = -999999;
 		p1 = -999999;
 		/* For each constellation point */
-		for (m = 0; m < qam; m++) {
-			if ((m >> (qm - k - 1)) & 1)
+		for (m = 0; m < QAM; m++) {
+			if ((m >> (QM - k - 1)) & 1)
 				p1 = maxstar(p1, log_syml_prob[m]);
 			else
 				p0 = maxstar(p0, log_syml_prob[m]);
@@ -1655,8 +1656,10 @@ gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			llr_ = llr_max;
 		if (llr_ < -llr_max)
 			llr_ = -llr_max;
-		llrs[qm * i + k] = (int8_t) llr_;
+		llrs[QM * i + k] = (int8_t) llr_;
 	}
+#undef QM
+#undef QAM
 }
 
 
@@ -1667,18 +1670,19 @@ gen_qm8_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 static void
 gen_qm6_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 {
-	int qm = 6;
-	int qam = 64;
+#define QM 6
+#define QAM 64
+
 	int m, k;
-	double I, Q, p0, p1, llr_, b[qm], log_syml_prob[qam];
+	double I, Q, p0, p1, llr_, b[QM], log_syml_prob[QAM];
 	/* 5.1.4 of TS38.211 */
-	const double symbols_I[64] = {
+	const double symbols_I[QAM] = {
 			3, 3, 1, 1, 3, 3, 1, 1, 5, 5, 7, 7, 5, 5, 7, 7,
 			3, 3, 1, 1, 3, 3, 1, 1, 5, 5, 7, 7, 5, 5, 7, 7,
 			-3, -3, -1, -1, -3, -3, -1, -1, -5, -5, -7, -7,
 			-5, -5, -7, -7, -3, -3, -1, -1, -3, -3, -1, -1,
 			-5, -5, -7, -7, -5, -5, -7, -7};
-	const double symbols_Q[64] = {
+	const double symbols_Q[QAM] = {
 			3, 1, 3, 1, 5, 7, 5, 7, 3, 1, 3, 1, 5, 7, 5, 7,
 			-3, -1, -3, -1, -5, -7, -5, -7, -3, -1, -3, -1,
 			-5, -7, -5, -7, 3, 1, 3, 1, 5, 7, 5, 7, 3, 1, 3, 1,
@@ -1686,8 +1690,8 @@ gen_qm6_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			-3, -1, -3, -1, -5, -7, -5, -7};
 	/* Average constellation point energy */
 	N0 *= 42.0;
-	for (k = 0; k < qm; k++)
-		b[k] = llrs[qm * i + k] < 0 ? 1.0 : 0.0;
+	for (k = 0; k < QM; k++)
+		b[k] = llrs[QM * i + k] < 0 ? 1.0 : 0.0;
 	/* 5.1.4 of TS38.211 */
 	I = (1 - 2 * b[0])*(4 - (1 - 2 * b[2]) * (2 - (1 - 2 * b[4])));
 	Q = (1 - 2 * b[1])*(4 - (1 - 2 * b[3]) * (2 - (1 - 2 * b[5])));
@@ -1698,16 +1702,16 @@ gen_qm6_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 	 * Calculate the log of the probability that each of
 	 * the constellation points was transmitted
 	 */
-	for (m = 0; m < qam; m++)
+	for (m = 0; m < QAM; m++)
 		log_syml_prob[m] = -(pow(I - symbols_I[m], 2.0)
 				+ pow(Q - symbols_Q[m], 2.0)) / N0;
 	/* Calculate an LLR for each of the k_64QAM bits in the set */
-	for (k = 0; k < qm; k++) {
+	for (k = 0; k < QM; k++) {
 		p0 = -999999;
 		p1 = -999999;
 		/* For each constellation point */
-		for (m = 0; m < qam; m++) {
-			if ((m >> (qm - k - 1)) & 1)
+		for (m = 0; m < QAM; m++) {
+			if ((m >> (QM - k - 1)) & 1)
 				p1 = maxstar(p1, log_syml_prob[m]);
 			else
 				p0 = maxstar(p0, log_syml_prob[m]);
@@ -1720,8 +1724,10 @@ gen_qm6_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			llr_ = llr_max;
 		if (llr_ < -llr_max)
 			llr_ = -llr_max;
-		llrs[qm * i + k] = (int8_t) llr_;
+		llrs[QM * i + k] = (int8_t) llr_;
 	}
+#undef QM
+#undef QAM
 }
 
 /*
@@ -1731,19 +1737,20 @@ gen_qm6_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 static void
 gen_qm4_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 {
-	int qm = 4;
-	int qam = 16;
+#define QM 4
+#define QAM 16
+
 	int m, k;
-	double I, Q, p0, p1, llr_, b[qm], log_syml_prob[qam];
+	double I, Q, p0, p1, llr_, b[QM], log_syml_prob[QAM];
 	/* 5.1.4 of TS38.211 */
-	const double symbols_I[16] = {1, 1, 3, 3, 1, 1, 3, 3,
+	const double symbols_I[QAM] = {1, 1, 3, 3, 1, 1, 3, 3,
 			-1, -1, -3, -3, -1, -1, -3, -3};
-	const double symbols_Q[16] = {1, 3, 1, 3, -1, -3, -1, -3,
+	const double symbols_Q[QAM] = {1, 3, 1, 3, -1, -3, -1, -3,
 			1, 3, 1, 3, -1, -3, -1, -3};
 	/* Average constellation point energy */
 	N0 *= 10.0;
-	for (k = 0; k < qm; k++)
-		b[k] = llrs[qm * i + k] < 0 ? 1.0 : 0.0;
+	for (k = 0; k < QM; k++)
+		b[k] = llrs[QM * i + k] < 0 ? 1.0 : 0.0;
 	/* 5.1.4 of TS38.211 */
 	I = (1 - 2 * b[0]) * (2 - (1 - 2 * b[2]));
 	Q = (1 - 2 * b[1]) * (2 - (1 - 2 * b[3]));
@@ -1754,16 +1761,16 @@ gen_qm4_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 	 * Calculate the log of the probability that each of
 	 * the constellation points was transmitted
 	 */
-	for (m = 0; m < qam; m++)
+	for (m = 0; m < QAM; m++)
 		log_syml_prob[m] = -(pow(I - symbols_I[m], 2.0)
 				+ pow(Q - symbols_Q[m], 2.0)) / N0;
 	/* Calculate an LLR for each of the k_64QAM bits in the set */
-	for (k = 0; k < qm; k++) {
+	for (k = 0; k < QM; k++) {
 		p0 = -999999;
 		p1 = -999999;
 		/* For each constellation point */
-		for (m = 0; m < qam; m++) {
-			if ((m >> (qm - k - 1)) & 1)
+		for (m = 0; m < QAM; m++) {
+			if ((m >> (QM - k - 1)) & 1)
 				p1 = maxstar(p1, log_syml_prob[m]);
 			else
 				p0 = maxstar(p0, log_syml_prob[m]);
@@ -1776,8 +1783,10 @@ gen_qm4_llr(int8_t *llrs, uint32_t i, double N0, double llr_max)
 			llr_ = llr_max;
 		if (llr_ < -llr_max)
 			llr_ = -llr_max;
-		llrs[qm * i + k] = (int8_t) llr_;
+		llrs[QM * i + k] = (int8_t) llr_;
 	}
+#undef QM
+#undef QAM
 }
 
 static void
@@ -3441,7 +3450,7 @@ throughput_intr_lcore_ldpc_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops[num_to_process];
+	struct rte_bbdev_dec_op **ops = alloca(sizeof(struct rte_bbdev_dec_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	int ret, i, j;
@@ -3550,7 +3559,7 @@ throughput_intr_lcore_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops[num_to_process];
+	struct rte_bbdev_dec_op **ops = alloca(sizeof(struct rte_bbdev_dec_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	struct rte_bbdev_dec_op *ref_op = tp->op_params->ref_dec_op;
@@ -3648,7 +3657,7 @@ throughput_intr_lcore_enc(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_enc_op *ops[num_to_process];
+	struct rte_bbdev_enc_op **ops = alloca(sizeof(struct rte_bbdev_enc_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	int ret, i, j;
@@ -3742,7 +3751,7 @@ throughput_intr_lcore_ldpc_enc(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_enc_op *ops[num_to_process];
+	struct rte_bbdev_enc_op **ops = alloca(sizeof(struct rte_bbdev_enc_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	int ret, i, j;
@@ -3838,7 +3847,7 @@ throughput_intr_lcore_fft(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_fft_op *ops[num_to_process];
+	struct rte_bbdev_fft_op **ops = alloca(sizeof(struct rte_bbdev_fft_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	int ret, i, j;
@@ -3932,7 +3941,8 @@ throughput_intr_lcore_mldts(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_to_process = tp->op_params->num_to_process;
-	struct rte_bbdev_mldts_op *ops[num_to_process];
+	struct rte_bbdev_mldts_op **ops =
+			alloca(sizeof(struct rte_bbdev_mldts_op *) * num_to_process);
 	struct test_buffers *bufs = NULL;
 	struct rte_bbdev_info info;
 	int ret, i, j;
@@ -4022,8 +4032,8 @@ throughput_pmd_lcore_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops_enq[num_ops];
-	struct rte_bbdev_dec_op *ops_deq[num_ops];
+	struct rte_bbdev_dec_op **ops_enq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
+	struct rte_bbdev_dec_op **ops_deq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
 	struct rte_bbdev_dec_op *ref_op = tp->op_params->ref_dec_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4135,8 +4145,8 @@ bler_pmd_lcore_ldpc_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops_enq[num_ops];
-	struct rte_bbdev_dec_op *ops_deq[num_ops];
+	struct rte_bbdev_dec_op **ops_enq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
+	struct rte_bbdev_dec_op **ops_deq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
 	struct rte_bbdev_dec_op *ref_op = tp->op_params->ref_dec_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4278,8 +4288,8 @@ bler_pmd_lcore_turbo_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops_enq[num_ops];
-	struct rte_bbdev_dec_op *ops_deq[num_ops];
+	struct rte_bbdev_dec_op **ops_enq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
+	struct rte_bbdev_dec_op **ops_deq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
 	struct rte_bbdev_dec_op *ref_op = tp->op_params->ref_dec_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4397,8 +4407,8 @@ throughput_pmd_lcore_ldpc_dec(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_dec_op *ops_enq[num_ops];
-	struct rte_bbdev_dec_op *ops_deq[num_ops];
+	struct rte_bbdev_dec_op **ops_enq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
+	struct rte_bbdev_dec_op **ops_deq = alloca(sizeof(struct rte_bbdev_dec_op *) * num_ops);
 	struct rte_bbdev_dec_op *ref_op = tp->op_params->ref_dec_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4535,8 +4545,8 @@ throughput_pmd_lcore_enc(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_enc_op *ops_enq[num_ops];
-	struct rte_bbdev_enc_op *ops_deq[num_ops];
+	struct rte_bbdev_enc_op **ops_enq = alloca(sizeof(struct rte_bbdev_enc_op *) * num_ops);
+	struct rte_bbdev_enc_op **ops_deq = alloca(sizeof(struct rte_bbdev_enc_op *) * num_ops);
 	struct rte_bbdev_enc_op *ref_op = tp->op_params->ref_enc_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4637,8 +4647,8 @@ throughput_pmd_lcore_ldpc_enc(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_enc_op *ops_enq[num_ops];
-	struct rte_bbdev_enc_op *ops_deq[num_ops];
+	struct rte_bbdev_enc_op **ops_enq = alloca(sizeof(struct rte_bbdev_enc_op *) * num_ops);
+	struct rte_bbdev_enc_op **ops_deq = alloca(sizeof(struct rte_bbdev_enc_op *) * num_ops);
 	struct rte_bbdev_enc_op *ref_op = tp->op_params->ref_enc_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4739,8 +4749,8 @@ throughput_pmd_lcore_fft(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_fft_op *ops_enq[num_ops];
-	struct rte_bbdev_fft_op *ops_deq[num_ops];
+	struct rte_bbdev_fft_op **ops_enq = alloca(sizeof(struct rte_bbdev_fft_op *) * num_ops);
+	struct rte_bbdev_fft_op **ops_deq = alloca(sizeof(struct rte_bbdev_fft_op *) * num_ops);
 	struct rte_bbdev_fft_op *ref_op = tp->op_params->ref_fft_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
@@ -4839,8 +4849,8 @@ throughput_pmd_lcore_mldts(void *arg)
 	const uint16_t queue_id = tp->queue_id;
 	const uint16_t burst_sz = tp->op_params->burst_sz;
 	const uint16_t num_ops = tp->op_params->num_to_process;
-	struct rte_bbdev_mldts_op *ops_enq[num_ops];
-	struct rte_bbdev_mldts_op *ops_deq[num_ops];
+	struct rte_bbdev_mldts_op **ops_enq = alloca(sizeof(struct rte_bbdev_mldts_op *) * num_ops);
+	struct rte_bbdev_mldts_op **ops_deq = alloca(sizeof(struct rte_bbdev_mldts_op *) * num_ops);
 	struct rte_bbdev_mldts_op *ref_op = tp->op_params->ref_mldts_op;
 	struct test_buffers *bufs = NULL;
 	int i, j, ret;
diff --git a/app/test-bbdev/test_bbdev_vector.c b/app/test-bbdev/test_bbdev_vector.c
index 8b32850982..f3def6aaaf 100644
--- a/app/test-bbdev/test_bbdev_vector.c
+++ b/app/test-bbdev/test_bbdev_vector.c
@@ -10,6 +10,7 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <rte_malloc.h>
+#include <rte_os_shim.h>
 
 #include "test_bbdev_vector.h"
 
diff --git a/lib/eal/windows/include/rte_os_shim.h b/lib/eal/windows/include/rte_os_shim.h
index 0e74eb19c7..f16b2230c8 100644
--- a/lib/eal/windows/include/rte_os_shim.h
+++ b/lib/eal/windows/include/rte_os_shim.h
@@ -7,6 +7,7 @@
 
 #include <rte_os.h>
 #include <rte_windows.h>
+#include <getline.h>
 
 /**
  * @file
-- 
2.49.0.vfs.0.3

