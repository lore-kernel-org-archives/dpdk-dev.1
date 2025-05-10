Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58763C3ABC3
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 May 2025 10:41:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12A3F4025D;
	Sat, 10 May 2025 12:41:12 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 93F154025A
 for <dev@dpdk.org>; Sat, 10 May 2025 12:41:10 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54AA0Jxk002637;
 Sat, 10 May 2025 03:41:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=C0q+98kSHOINGahXLBZYana
 xCpT5BlPX1d2JatcIfZI=; b=HDAdEbFixWVEkJkooQvZZg+HSY2TA/Lqb5+xuuL
 dP/hzB9EzB8jjQU99sXx/s7qA4PZSkd4LC67iPqvymc84M9TT06L6C6rVsXQAQgH
 kkonAveUf4mA0usdbw3RuXgpCZYW3uJW7z9pz27QKSvEbGepcJSztSVaFXEAu1oW
 cbWfqvQEGHu4I3HCfzMfI8UsypjfcA3HPkBFAlmsQSPs7wL6+EK8qAlx02dU1eI+
 p8e+uPU54ZUp4yeMqloS0Q3Dm+ZeIhnSrcwfgBjoW5MQ3WXYrQYfAy2HIbb81Sgm
 tMJQsqFpLUkqi07AtwhQ0X4ZNmxaF87vhZnVIRul4dxKOqQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46ht1m8sa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 10 May 2025 03:41:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 10 May 2025 03:41:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 10 May 2025 03:41:08 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 958A43F7045;
 Sat, 10 May 2025 03:41:06 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Jay Zhou <jianjay.zhou@huawei.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Gowrishankar
 Muthukrishnan" <gmuthukrishn@marvell.com>
Subject: [PATCH] crypto/virtio: fix DER encoding of RSA public key
Date: Sat, 10 May 2025 16:10:58 +0530
Message-ID: <20250510104103.2081-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3KF6PbqigWDWWRkks3lqPa11Zu6vNz91
X-Authority-Analysis: v=2.4 cv=PoqTbxM3 c=1 sm=1 tr=0 ts=681f2d45 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=S373mvdeQRUWIwdqbswA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEwMDEwNyBTYWx0ZWRfXzMaJWbGfG8EQ
 AetwslURyd89YCWuMqR/DC9YbJp+XmueeZAZyjuUCVcGuAuP+ql4vOUKTWGtPkndm+Z6X4rG5vG
 U01bh/2rWifzIsm/ILWNqTS+0KgCFIOfZLTnZ5hddlGEz23ewSHXShDj0ySdlIBsbiVUoDF2ixl
 1I1QbRc3cZQWDYH1Gb6tsuJUPT0fcZplC5IiBvxbw8J+6Y0d3Sv7w9isx2IVf9TGH5dOOZFjKqz
 d4xIBJmPRmTfK43d/tt70UeNbPPXErjF10q+Ln7513OqBuSmKiYDD3HBQqkoVJ1PiPneadDIba3
 7bvkgyAjiRr2+LTxBPHlGyGKw4FfnMABDhsQ2C0kWHO4MYsr1g5O5ndWvGcmfQCsI+Ir2OgJ1Jb
 IuwhRIZVyD6sEtOkAVBkwyzNyQWLj8jmEufklmSLXBEUOJxjQN8Dd+o0TSAihX1XjKPdlex+
X-Proofpoint-GUID: 3KF6PbqigWDWWRkks3lqPa11Zu6vNz91
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

As per RFC 8017, RSA public key in ASN.1 should have only
modulus and exponent values. Add a separate encoding function
to follow this standard.

Fixes: 6fe6a7f7bcf ("crypto/virtio: add asymmetric RSA support")

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 drivers/crypto/virtio/virtio_cryptodev.c | 31 +++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index bc737f1e68..b01e97c988 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -1524,6 +1524,29 @@ virtio_crypto_asym_rsa_xform_to_der(
 	return len;
 }
 
+static int
+virtio_crypto_asym_rsa_xform_to_public_der(
+		struct rte_crypto_asym_xform *xform,
+		uint8_t *der)
+{
+	uint8_t data[VIRTIO_CRYPTO_MAX_CTRL_DATA];
+	size_t tlen = 0, len;
+	uint8_t *tlv;
+
+	if (xform->xform_type != RTE_CRYPTO_ASYM_XFORM_RSA)
+		return -EINVAL;
+
+	tlv = data;
+	len = tlv_encode(tlv, 0x02, xform->rsa.n.data, xform->rsa.n.length);
+	tlen += len;
+	len = tlv_encode(tlv + tlen, 0x02, xform->rsa.e.data, xform->rsa.e.length);
+	tlen += len;
+
+	RTE_ASSERT(tlen < VIRTIO_CRYPTO_MAX_CTRL_DATA);
+	len = tlv_encode(der, 0x30, data, tlen);
+	return len;
+}
+
 static int
 virtio_crypto_asym_rsa_configure_session(
 		struct rte_crypto_rsa_xform *rsa,
@@ -1607,7 +1630,13 @@ virtio_crypto_asym_configure_session(
 			return ret;
 		}
 
-		ret = virtio_crypto_asym_rsa_xform_to_der(xform, ctrl->data);
+		if (xform->rsa.key_type == RTE_RSA_KEY_TYPE_EXP) {
+			ret = virtio_crypto_asym_rsa_xform_to_public_der(
+					xform, ctrl->data);
+		} else {
+			ret = virtio_crypto_asym_rsa_xform_to_der(xform,
+					ctrl->data);
+		}
 		if (ret <= 0) {
 			VIRTIO_CRYPTO_SESSION_LOG_ERR("Invalid RSA primitives");
 			return ret;
-- 
2.25.1

