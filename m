Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1AFCD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 11:21:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 676E040A7A;
	Tue, 16 Jun 2026 13:21:22 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 40614406BB
 for <dev@dpdk.org>; Tue, 16 Jun 2026 13:21:21 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GAAH7o2509963; Tue, 16 Jun 2026 04:21:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 5AVIwwnprl991NllRCmHzj7nxpfFE4RpFMQI1tJznE=; b=HPJ+WtJtbbFJ9jubp
 aHhYccFzu0V2dstfAWIdwkCm5RFJDxOKCNK8m6RJ2aHGBrR/y0jguhzP0OY4amsa
 yx6aKe+mHj4T3ip/U9PP/ux5VnnqLMLEPH5OrlLVV7UQQfBcBDiJf7/DU2Ub1i5v
 p2YO6BHXUhqXIn60ii3wdF4QTzCouOelgrmEzOmqY/A3WyE+pARWL/7nJQIDNy24
 Uau+1Ioa+3zHojBbv8+MdsUxOmpL3q+eOQjgHP5ws0E+Ivb4kkZTvxbAFohqO5Aq
 91OS23KagBwSK7SdzyCNHysYCKJsbciYplEerJK8IjFKCAX9hAhVXcL+xHTuNxZx
 3kDOQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf90rgu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jun 2026 04:21:20 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 04:21:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 04:21:19 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 304FA3F70A1;
 Tue, 16 Jun 2026 04:21:16 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
CC: Vidya Sagar Velumuri <vvelumuri@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 1/4] test/crypto: add asymmetric sessionless test case
Date: Tue, 16 Jun 2026 16:51:10 +0530
Message-ID: <20260616112113.73680-2-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616112113.73680-1-ktejasree@marvell.com>
References: <20260616112113.73680-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX98MmIG6KF0uB
 ljpEZFUCGgUOXRXLUV16oad9B0/gt+hDx1JEL/rESNDfZan/Or656/so3Z+fdCo2PdzmTwTrUcF
 eQ3YPZKRzU114isy/sDbHkeO6mW78Yxqn2ljIrT+3Pg44VTmF7I9KHFuc2W+fjggHmAnyWa255g
 YfvyN99xJz82UFFwo8V99jhSvok7dSKoFcmZkPQTy7CmYM+Re1cZZ/w1rrmm95UOBuI0vl2XJHS
 w9tWbmVEpPNVyJoqqE9IAArGy2A6Lwp2lPfDLO8Yph+uePLAWEK1Igsul4Mr9v0DC3Fytx2VnV1
 qYVO5B8lxPcRsUaOLDCg2Vo8n8Exjf2jCs/PDWWXRecD4cyjazMo1konz68zGzepmENPFqsRy0c
 /alKxJJfjrlkKOEG1SQ+lP3rpj9HBLlB13BR8bBWrXk7NQMARXnvj+KPqD81E0GOg/Kk0fG1KVI
 hVd8M/MRpF0i++aP26g==
X-Proofpoint-ORIG-GUID: v1ZWGisl_MxFGr4DVBNgSKZXfML-Qelt
X-Proofpoint-GUID: v1ZWGisl_MxFGr4DVBNgSKZXfML-Qelt
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a3131b0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=vZxYJkewfLacmdCLkWUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDExNSBTYWx0ZWRfX3CxIzVtb34a9
 PhslFLZ0CdK5bApbhvt5rddB6ornvlOk5+CArJ8AUXvc2HFZVsEQNZW6HWkGW3k/URVWUpf1r1X
 OtLJwZFEi4Tmoik3bALsPfc6QIkLuRk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
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

From: Vidya Sagar Velumuri <vvelumuri@marvell.com>

Add test for sessionless asymmetric operation

Signed-off-by: Vidya Sagar Velumuri <vvelumuri@marvell.com>
---
 app/test/test_cryptodev_asym.c | 106 +++++++++++++++++++++++++++++++--
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index bf1a1fc417..e7cc5a79e2 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -558,6 +558,13 @@ testsuite_setup(void)
 			"Failed to configure cryptodev %u with %u qps",
 			dev_id, ts_params->conf.nb_queue_pairs);
 
+	ts_params->session_mpool = rte_cryptodev_asym_session_pool_create(
+			"test_asym_sess_mp", TEST_NUM_SESSIONS, 0, 0,
+			SOCKET_ID_ANY);
+
+	TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
+			"session mempool allocation failed");
+
 	/* configure qp */
 	ts_params->qp_conf.nb_descriptors = DEFAULT_NUM_OPS_INFLIGHT;
 	ts_params->qp_conf.mp_session = ts_params->session_mpool;
@@ -569,12 +576,6 @@ testsuite_setup(void)
 			qp_id, dev_id);
 	}
 
-	ts_params->session_mpool = rte_cryptodev_asym_session_pool_create(
-			"test_asym_sess_mp", TEST_NUM_SESSIONS, 0, 0,
-			SOCKET_ID_ANY);
-
-	TEST_ASSERT_NOT_NULL(ts_params->session_mpool,
-			"session mempool allocation failed");
 	/* >8 End of device, op pool and session configuration for asymmetric crypto section. */
 	return TEST_SUCCESS;
 }
@@ -1181,6 +1182,98 @@ test_mod_inv(void)
 	return status;
 }
 
+static int
+test_mod_exp_sessionless(void)
+{
+	struct crypto_testsuite_params_asym *ts_params = &testsuite_params;
+	const struct rte_cryptodev_asymmetric_xform_capability *capability;
+	struct rte_mempool *op_mpool = ts_params->op_mpool;
+	struct rte_crypto_op *op = NULL, *result_op = NULL;
+	struct rte_cryptodev_asym_capability_idx cap_idx;
+	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_op *asym_op = NULL;
+	uint8_t result[sizeof(mod_p)] = { 0 };
+	uint8_t input[TEST_DATA_SIZE] = {0};
+	struct rte_cryptodev_info info;
+	int status = TEST_SUCCESS;
+	int ret = 0;
+
+	rte_cryptodev_info_get(dev_id, &info);
+	if (!(info.feature_flags & RTE_CRYPTODEV_FF_ASYM_SESSIONLESS))
+		return TEST_SKIPPED;
+
+	if (rte_cryptodev_asym_get_xform_enum(&modex_xform.xform_type, "modexp") < 0) {
+		RTE_LOG(ERR, USER1, "Invalid ASYM algorithm specified\n");
+		return -1;
+	}
+
+	/* check for modlen capability */
+	cap_idx.type = modex_xform.xform_type;
+	capability = rte_cryptodev_asym_capability_get(dev_id, &cap_idx);
+
+	if (capability == NULL) {
+		RTE_LOG(INFO, USER1, "Device doesn't support MOD EXP. Test Skipped\n");
+		return TEST_SKIPPED;
+	}
+
+	if (rte_cryptodev_asym_xform_capability_check_modlen(capability,
+							     modex_xform.modex.modulus.length)) {
+		RTE_LOG(ERR, USER1, "Unsupported MODULUS length specified\n");
+		return TEST_SKIPPED;
+	}
+
+	/* Create op and process packets. */
+	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
+	if (!op) {
+		RTE_LOG(ERR, USER1, "line %u FAILED: %s", __LINE__,
+			"Failed to allocate asymmetric crypto operation struct");
+		return TEST_FAILED;
+	}
+
+	asym_op = op->asym;
+	memcpy(input, base, sizeof(base));
+	asym_op->modex.base.data = input;
+	asym_op->modex.base.length = sizeof(base);
+	asym_op->modex.result.data = result;
+	asym_op->modex.result.length = sizeof(result);
+	asym_op->xform = &modex_xform;
+	op->sess_type = RTE_CRYPTO_OP_SESSIONLESS;
+
+	RTE_LOG(DEBUG, USER1, "Process ASYM operation");
+	/* Process crypto operation */
+	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
+		RTE_LOG(ERR, USER1,
+				"line %u FAILED: %s",
+				__LINE__, "Error sending packet for operation");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) == 0)
+		rte_pause();
+
+	if (result_op == NULL) {
+		RTE_LOG(ERR, USER1,
+				"line %u FAILED: %s",
+				__LINE__, "Failed to process asym crypto op");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	ret = verify_modexp(mod_exp, result_op);
+	if (ret) {
+		RTE_LOG(ERR, USER1,  "operation verification failed\n");
+		status = TEST_FAILED;
+	}
+
+error_exit:
+	rte_crypto_op_free(op);
+
+	TEST_ASSERT_EQUAL(status, 0, "Test failed");
+
+	return status;
+}
+
 static int
 test_mod_exp(void)
 {
@@ -5309,6 +5402,7 @@ static struct unit_test_suite cryptodev_asym_mod_ex_testsuite = {
 			"Modular Exponentiation (mod=128, base=20, exp=3, res=128)",
 			ut_setup_asym, ut_teardown_asym,
 			modular_exponentiation, &modex_test_case_m128_b20_e3),
+		TEST_CASE_ST(ut_setup_asym, ut_teardown_asym, test_mod_exp_sessionless),
 		TEST_CASES_END()
 	}
 };
-- 
2.34.1

