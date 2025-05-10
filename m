Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EAEC3ABC3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 May 2025 10:45:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB30D402DD;
	Sat, 10 May 2025 12:45:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id C9D604025A;
 Sat, 10 May 2025 12:45:07 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AAaaul020642;
 Sat, 10 May 2025 03:45:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=7wjI5lORZyyvhQ/Z9Ll6sg8
 e8FPQIvG9f7QHOVDEAJM=; b=GB4L2Pqz0Q+oGfB+iyj71qjBTzadBOAXUM82ZrZ
 qLI3VLGPih9cpZGDw36tBBHUA2fvpUM7bnwdVhCrY3VNuT8ZWuWMfB7C7CIlYlcW
 huzz/nV55MckQrES7bmMTdqeA3qBroguKalXZiHMHjwLA3s2Z7oOZtbfR8zMriRh
 o5uQpE0xbA16QmgxL3uGuBRSeWY3z90Xcl2zc5SwsPlg38YMzb7ZGx1oh9MC4St6
 YqVofdINKwEkzCVu3G5VHAPoX6xnUJmOIORaP0PNxb+bPGzrl/EfufwGaORh9HHu
 27St2KiuwRO5o1IrMBSrwVq535knyT9H32amrFKAef5bIEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46hufp8n0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 May 2025 03:45:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 03:45:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 03:45:05 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 028653F7045;
 Sat, 10 May 2025 03:44:59 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Shally Verma <shallyv@marvell.com>, "Kanaka Durga
 Kotamarthy" <kkotamarthy@marvell.com>, Ayuj Verma <ayverma@marvell.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH] test/crypto: fix RSA decrypt op validation
Date: Sat, 10 May 2025 16:14:47 +0530
Message-ID: <20250510104452.2186-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=681f2e32 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=O2_w7A0bV2vXX9OdRGQA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: u830ubACwl-erWCQuLVuSiH2XnAS2pO_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDEwOCBTYWx0ZWRfXyfDdL/Ks5u1I
 Ie+dtlQSxZrFVPXFYkWAu/ZUDWY2V7iFel60BBfDnSj+/bnMcrZ4oxVqf3p3XoppfRc5doEdDvj
 2osYyBaPViaR5XlilhQ3Hh4FSMlQ2iKOtPIy+Tkned7vzZuF1cfrY98hdrjTylpz4hY7DFiwjsC
 0wH5HLpmlHzR58VGIRG2Kft9uokSwmbBjYzja+MGUmkXSDYfDZxMmfg+6nkQe/B83Xw8DcwDIBP
 E/DASFHxhZzwn7ecILhr6vg7ZgUm5dxWhxYgyeQxQywxYhnhpMLsh9vZ73pMUnI2OrFm7E3g1b8
 9vjTZA0QJopNDC87mw1vWyFrqbPnUeORkl56tgt/c5djRKkEWOE1PEN0wfeTdI2CI0QX13Dfjsq
 2Ocemc/QZY1DyG+U/beReQtXavCbDefD3OVUyYxpD23cNybe7RoWubma7QXor1brm/cCVqpp
X-Proofpoint-ORIG-GUID: u830ubACwl-erWCQuLVuSiH2XnAS2pO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-10_03,2025-05-09_01,2025-02-21_01
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

Following RSA encrypt op, same plaintext buffer is used as output
buffer for decrypt op, hence comparing plaintext buffer against
same buffer pointer in crypto op always succeed irrespective of
whether decrypt op succeeds or not. This patch fixes this issue
with a local buffer for crypto op.

Fixes: 5ae36995f10 ("test/crypto: move RSA enqueue/dequeue into functions")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 226270556d..cd4fe7e14e 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -174,7 +174,10 @@ queue_ops_rsa_enc_dec(void *sess)
 	struct rte_crypto_op *op, *result_op;
 	struct rte_crypto_asym_op *asym_op;
 	uint8_t cipher_buf[TEST_DATA_SIZE] = {0};
-	int ret, status = TEST_SUCCESS;
+	uint8_t msg_buf[TEST_DATA_SIZE] = {0};
+	int ret, status;
+
+	memcpy(msg_buf, rsaplaintext.data, rsaplaintext.len);
 
 	/* Set up crypto op data structure */
 	op = rte_crypto_op_alloc(op_mpool, RTE_CRYPTO_OP_TYPE_ASYMMETRIC);
@@ -189,7 +192,7 @@ queue_ops_rsa_enc_dec(void *sess)
 	/* Compute encryption on the test vector */
 	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
 
-	asym_op->rsa.message.data = rsaplaintext.data;
+	asym_op->rsa.message.data = msg_buf;
 	asym_op->rsa.cipher.data = cipher_buf;
 	asym_op->rsa.cipher.length = RTE_DIM(rsa_n);
 	asym_op->rsa.message.length = rsaplaintext.len;
@@ -224,6 +227,7 @@ queue_ops_rsa_enc_dec(void *sess)
 	asym_op = result_op->asym;
 	asym_op->rsa.message.length = RTE_DIM(rsa_n);
 	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_DECRYPT;
+	memset(asym_op->rsa.message.data, 0, asym_op->rsa.message.length);
 
 	/* Process crypto operation */
 	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
@@ -240,11 +244,20 @@ queue_ops_rsa_enc_dec(void *sess)
 		status = TEST_FAILED;
 		goto error_exit;
 	}
-	status = TEST_SUCCESS;
+
+	if (result_op->status != RTE_CRYPTO_OP_STATUS_SUCCESS) {
+		RTE_LOG(ERR, USER1, "Expected crypto op to succeed\n");
+		status = TEST_FAILED;
+		goto error_exit;
+	}
+
 	ret = rsa_verify(&rsaplaintext, result_op);
-	if (ret)
+	if (ret) {
 		status = TEST_FAILED;
+		goto error_exit;
+	}
 
+	status = TEST_SUCCESS;
 error_exit:
 
 	rte_crypto_op_free(op);
-- 
2.25.1

