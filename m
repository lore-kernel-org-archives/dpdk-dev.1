Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631BEC021B2
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Feb 2025 06:04:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D0A3402CF;
	Sun, 23 Feb 2025 07:04:29 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7FA24402CF
 for <dev@dpdk.org>; Sun, 23 Feb 2025 07:04:28 +0100 (CET)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51N608Gr010590;
 Sat, 22 Feb 2025 22:04:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 adl4idP6HQ+8zOwtOAJQ77+crssbPas5ySIE8qgTVM=; b=Rqo9nVcZLyHsgPhBv
 i6f9EjUpQgr+Rww3nck2l1F8Jv2oJtoZ+yztgswkRxz1VJlkZ0F233kHCxK4Wy0e
 Y7eczuCsg59WDdGAeBSYk4tP8a3eqM8maRZbZtTlgLuT4vf+VQ9b3xDajMvdEXbm
 lvio7X3uDACPJYTsS/wF0BmtH9J7Eq528HooyJTwn0YYlrRNomB/Q+NedKnEaRyn
 L2AZIwQlkgoso1gVyueNHrUQwCWyQA/yo2I0us0VZCP9GCLQwFKKp2qayg8elvhW
 vnK048ufqJYCqsooWCXkZ5GVaPXfNwriA7ead8sKjhMub50c9vqMpj8/Hpkr0R19
 c0eDQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeyks24m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 22 Feb 2025 22:04:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 22 Feb 2025 22:04:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 22 Feb 2025 22:04:25 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id CCE1A5B693E;
 Sat, 22 Feb 2025 22:04:22 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Kai Ji <kai.ji@intel.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [v2 2/2] test/crypto: add negative test for RSA verify op
Date: Sun, 23 Feb 2025 11:34:05 +0530
Message-ID: <4a0cca961025d297d97f6ad14ab10bd99ea65ac6.1740290302.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1c35f6536b049d2dde122f29e444d462b3d3f948.1740290302.git.gmuthukrishn@marvell.com>
References: <1c35f6536b049d2dde122f29e444d462b3d3f948.1740290302.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 2n3YSY5jIUIMma1B8EamqKvVLxywMDlr
X-Proofpoint-GUID: 2n3YSY5jIUIMma1B8EamqKvVLxywMDlr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-23_02,2025-02-20_02,2024-11-22_01
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

Add negative test for RSA verify operation to check if incorrect
signature is validated.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v2:
 - no changes, but added openssl pmd patch for CI.
---
 app/test/test_cryptodev_asym.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 8977d9d3a5..9b5f3c545e 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -62,7 +62,7 @@ queue_ops_rsa_sign_verify(void *sess)
 	struct rte_crypto_op *op, *result_op;
 	struct rte_crypto_asym_op *asym_op;
 	uint8_t output_buf[TEST_DATA_SIZE];
-	int status = TEST_SUCCESS;
+	int status;
 
 	/* Set up crypto op data structure */
 	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
@@ -129,12 +129,35 @@ queue_ops_rsa_sign_verify(void *sess)
 		goto error_exit;
 	}
 
-	status = TEST_SUCCESS;
 	if (result_op->status != RTE_CRYPTO_OP_STATUS_SUCCESS) {
 		RTE_LOG(ERR, USER1, "Failed to process sign-verify op\n");
 		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	/* Negative test */
+	result_op->asym->rsa.sign.data[0] ^= 0xff;
+	if (rte_cryptodev_enqueue_burst(dev_id, 0, &result_op, 1) != 1) {
+		RTE_LOG(ERR, USER1, "Error sending packet for verify\n");
+		status = TEST_FAILED;
+		goto error_exit;
 	}
 
+	while (rte_cryptodev_dequeue_burst(dev_id, 0, &result_op, 1) == 0)
+		rte_pause();
+
+	if (result_op == NULL) {
+		RTE_LOG(ERR, USER1, "Failed to process verify op\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
+	if (result_op->status != RTE_CRYPTO_OP_STATUS_ERROR) {
+		RTE_LOG(ERR, USER1, "Failed to process sign-verify op\n");
+		status = TEST_FAILED;
+	}
+
+	status = TEST_SUCCESS;
 error_exit:
 
 	rte_crypto_op_free(op);
-- 
2.25.1

