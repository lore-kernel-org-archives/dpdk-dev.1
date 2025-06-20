Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67C6C7115B
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 08:19:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D685A42EA3;
	Fri, 20 Jun 2025 10:19:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D6D5242E9C;
 Fri, 20 Jun 2025 10:19:52 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3TiqI015650;
 Fri, 20 Jun 2025 01:19:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 qRIA/EfZtSdHD0PGEJymgjNgPPNEl7k/rslqAcE2oo=; b=gM4b6lm1NzIbkgQt6
 kxnTD4XxXRCkUzG0w0TTSdq9Ipse5rfmv9s+efYR38Odi68YaXnSusUY8ZbtlDAJ
 gR8P8M0bWeen90t/wD5sm6OdIhJrC+rkZPbjxxFdZd8/mr+nYwvdC5NUjcR5DsFF
 Gf3SyR0aFl9WQ9l3CbnTIY+HhswIoidjcvG4IUCbnKr6WbXcfbRc77TUo6aSNuLs
 ZLi79d3yMyNMYig6rHA4p2STzmCaCN5+pieGILgwZdL3eHKPTlWC1rsLPxjhYQoE
 xTdCe15T2qqam5Jv192WFStvkxe4swJKyqA450eDLiiv4slXl/JuB9cSdgI1bqqa
 6eSQw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgft0-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 01:19:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 01:19:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 01:19:42 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.22.173])
 by maili.marvell.com (Postfix) with ESMTP id 8A6765B692D;
 Fri, 20 Jun 2025 01:19:39 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Shally Verma <shallyv@marvell.com>, Ayuj Verma
 <ayverma@marvell.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 3/3] test/crypto: fix RSA decrypt op validation
Date: Fri, 20 Jun 2025 13:49:18 +0530
Message-ID: <20250620081921.2145-3-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250620081921.2145-1-gmuthukrishn@marvell.com>
References: <20250620081921.2145-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=685519a7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=O2_w7A0bV2vXX9OdRGQA:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MSBTYWx0ZWRfX4DurfxsmZRIa
 Vjs7tSeOJ4gnu7E8cRiXGzZHs7F9XbGa7OX1QFpELEAc/VH2UDNKaDY70k7l3NMgw4x6dhivODA
 dbJAUr36O1zkuz+06eOOz9vw4cs9yUFL0oTrWhccUJ0kKt6IKXQ1SP7Kb/XD5Dn+FwxMddbhsyP
 aXxs5FHFEH5gymzr1GwOwcjEsktk0jywz5YY4qZXnZ10bTedfS2RyNBVCJa+do4ZlLbg/HEpand
 H7wUp5xJEebZSBP+eaIASr+FGIcaQvDqg5YiH2r6jCjEKoGv9U7qQSEsYVfbO9WAZ9eP5j/vI9k
 F0zGVOSFMIz5xNbkmUDsol9j+PImltdLYdYHp3tU6Bx0XU7pSNkBoKB6XXqNHWmoaOfulkNixP5
 YXjpuLueFVGYkxJMlwG8YPZiItyMJuxzbOA4icBtcPd6h68P+KrAWykG6/8BtJbozzfbF6AR
X-Proofpoint-ORIG-GUID: o525dLTmCosa-9s92b7StjVPOm4t3woi
X-Proofpoint-GUID: o525dLTmCosa-9s92b7StjVPOm4t3woi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_03,2025-06-18_03,2025-03-28_01
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

Fixes: 5ae36995f10f ("test/crypto: move RSA enqueue/dequeue into functions")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index a5f3eae41d..557eaf2706 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -175,7 +175,10 @@ queue_ops_rsa_enc_dec(void *sess)
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
@@ -190,7 +193,7 @@ queue_ops_rsa_enc_dec(void *sess)
 	/* Compute encryption on the test vector */
 	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
 
-	asym_op->rsa.message.data = rsaplaintext.data;
+	asym_op->rsa.message.data = msg_buf;
 	asym_op->rsa.cipher.data = cipher_buf;
 	asym_op->rsa.cipher.length = RTE_DIM(rsa_n);
 	asym_op->rsa.message.length = rsaplaintext.len;
@@ -225,6 +228,7 @@ queue_ops_rsa_enc_dec(void *sess)
 	asym_op = result_op->asym;
 	asym_op->rsa.message.length = RTE_DIM(rsa_n);
 	asym_op->rsa.op_type = RTE_CRYPTO_ASYM_OP_DECRYPT;
+	memset(asym_op->rsa.message.data, 0, asym_op->rsa.message.length);
 
 	/* Process crypto operation */
 	if (rte_cryptodev_enqueue_burst(dev_id, 0, &op, 1) != 1) {
@@ -241,11 +245,20 @@ queue_ops_rsa_enc_dec(void *sess)
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

