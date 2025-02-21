Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38977C021B6
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 17:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BAB1402CC;
	Fri, 21 Feb 2025 18:09:50 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7E474402BB
 for <dev@dpdk.org>; Fri, 21 Feb 2025 18:09:48 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L7h5ng005925;
 Fri, 21 Feb 2025 09:09:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=EEVxReLxoakTFly9cD2lfL3
 Led/VgIfhkZSl36H7Cno=; b=lJ4xDrg6fH8e4U2IdTBQMFSKlxOmeYApZcPOg3/
 +imjBVMNFhT+wu4DgUsOaoD9NeCCjvJ/+4506QF2e1dGUh4R1XUjHG69dSywrPAQ
 aKIPhe3PLk+qWESjVCNgcHQeN8NbXEVvyA2wvuZZ1fSy3rrDWJt2BOfwEME80Qf1
 HdmpZIJm4d8IIhmX54vwcpPjFZ83beXkUf8Myg1GmvdUzyeHCuLEAgffQIbf4qd6
 Ia2eLXLDNBMa7RE8xPrHO9WItMYRbmECgOL/bsNJD5fVKFCYnu9zz8xXoVbryNsK
 5gsaG+HL65rvM6VNL7M00I7A6mahYxoHmOvT8thUcaM1GgA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44xnbgh3a3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Feb 2025 09:09:47 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 21 Feb 2025 09:09:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 21 Feb 2025 09:09:14 -0800
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.66.72])
 by maili.marvell.com (Postfix) with ESMTP id A08555B6938;
 Fri, 21 Feb 2025 09:09:12 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH] test/crypto: add negative test for RSA verify op
Date: Fri, 21 Feb 2025 22:39:05 +0530
Message-ID: <20250221170908.1613-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: z_RSK-ovqTrNwAoymG_4lxCn82cleiG1
X-Proofpoint-ORIG-GUID: z_RSK-ovqTrNwAoymG_4lxCn82cleiG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
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

