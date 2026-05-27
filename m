Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EEC8CD5BDE
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 08:53:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DE8140698;
	Wed, 27 May 2026 10:53:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B619F40285;
 Wed, 27 May 2026 10:53:29 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QNSQZX1192051; Wed, 27 May 2026 01:53:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 s5ghT0266ls4/pDgC3KiU3hjg72Qq2Cx5uJTAJvBwM=; b=LK+XokmWwR7k9ECkq
 CXmuj2qFD1y7qkWoiuIQCuEH5K+AleGhcR99Q6AEqihBn2+Wi2s2Oohqh64eX4hn
 zwmyGigGctPxelWS39M3C2oOVP89OyCxHQRnPiU02NKVdVaFnE3mdkAj3zTMYkl3
 ISq0A6L57zHucQS9YIKncTs206+XpPBWJ+bdZOqSxYXc3T05bak5Pq5F+Ezc55kB
 00ckj42XsMMEiBoXugk2+/A/0Bjzk1sdn8/glNJCYkmDwt40p2Ajj3eHtA7g7I3w
 PcM0cST4aj0z0xXNaGkhjP3bSHyvzwzuGb6c9oUa7NfLcxDb2Egj1HoDyiT2u93d
 BmNwg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4edd8njvu2-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 01:53:28 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 May 2026 01:53:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 May 2026 01:53:25 -0700
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.167.66])
 by maili.marvell.com (Postfix) with ESMTP id B7DC53F7065;
 Wed, 27 May 2026 01:53:23 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>
CC: <stable@dpdk.org>
Subject: [PATCH 2/2] test/crypto: fix prehash in MLDSA session
Date: Wed, 27 May 2026 14:22:53 +0530
Message-ID: <20260527085257.1933-2-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260527085257.1933-1-gmuthukrishn@marvell.com>
References: <20260527085257.1933-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Da_QCIF5VFZoyYg798ypbywQ_Aeg5AV7
X-Authority-Analysis: v=2.4 cv=VZrH+lp9 c=1 sm=1 tr=0 ts=6a16b108 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=IJ4IyveRiI2i2el8CssA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4NSBTYWx0ZWRfX46eO7vJNLrZG
 +5sd8kdY1QlIwtskog/mRWbH1NVHb8wXq7qimxC2d/PV/xkkhK9lHT5iQZBjsc/l6biSA1Rrowg
 VD9Zhex1SjSA2eIuB5vlDIUdnrPdJ0upwwExA6OJZHGvl02IZjoYARlyw30ZraVbSy4dXdQnsa+
 lERSrTMfUKw0IDClH1Rzs6bBpSq4/YEmbWZXWR1G/cL/a23fyHjoq10EltcPHqrpU41eKIvCzd/
 3Bl01D4zG3dlFVI5ikwaPucbegRpEojlATkufeDG2vMJWQmLGO3Cbc1jM0cWYpxNanQIGoC803d
 GA+V+XZw09iSW2TNEda02Kb25ryoQWKUSApB0/JSmPwV6paPgQ81TLEkpNYLAhtAngIHefgTSJb
 4TGROu5RAufHhcDZe+GvVM/ks20gg3vDgVDeeWiJ5D0U47BRSmeJrizyoiBpM6S0MLvHnbcZT7L
 ktCMGDackGWtcSXA7Wg==
X-Proofpoint-ORIG-GUID: Da_QCIF5VFZoyYg798ypbywQ_Aeg5AV7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
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

Set prehash flag in MLDSA session as per test parameter.

Fixes: 76a5877072c ("test/crypto: add ML-KEM and ML-DSA cases")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index 73a8198e53..90af49e485 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -4236,6 +4236,7 @@ mldsa_sign(const void *test_data)
 
 	xform.mldsa.type = vector->type;
 	xform.mldsa.sign_deterministic = vector->sign_deterministic;
+	xform.mldsa.sign_prehash = !!vector->hash;
 	xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA;
 
 	rte_cryptodev_info_get(dev_id, &dev_info);
@@ -4310,6 +4311,7 @@ mldsa_sign(const void *test_data)
 	self->op->asym->mldsa.sigver.pubkey.length = vector->pubkey.length;
 	self->op->asym->mldsa.sigver.sign.data = sign;
 	self->op->asym->mldsa.sigver.sign.length = sign_len;
+	self->op->asym->mldsa.sigver.hash = vector->hash;
 
 	TEST_ASSERT_SUCCESS(send_one(),
 		"Failed to process crypto op (ML-DSA Verify)");
@@ -4332,6 +4334,7 @@ mldsa_sign(const void *test_data)
 	self->op->asym->mldsa.sigver.pubkey.length = vector->pubkey.length;
 	self->op->asym->mldsa.sigver.sign.data = sign;
 	self->op->asym->mldsa.sigver.sign.length = sign_len;
+	self->op->asym->mldsa.sigver.hash = vector->hash;
 
 	TEST_ASSERT_SUCCESS(send_one_no_status_check(),
 		"Failed to process crypto op (ML-DSA Verify)");
@@ -4352,12 +4355,26 @@ mldsa_verify(const void *test_data)
 	const struct crypto_testsuite_mldsa_params *vector = test_data;
 	const uint8_t dev_id = params->valid_devs[0];
 	struct rte_crypto_asym_xform xform = {0};
+	struct rte_cryptodev_info dev_info;
 	uint8_t sign[TEST_DATA_SIZE] = {0};
 	size_t sign_len;
 
 	xform.mldsa.type = vector->type;
 	xform.mldsa.sign_deterministic = vector->sign_deterministic;
+	xform.mldsa.sign_prehash = !!vector->hash;
 	xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA;
+
+	rte_cryptodev_info_get(dev_id, &dev_info);
+
+	/* Check if prehash is supported */
+	if (vector->hash) {
+		if (!(dev_info.feature_flags & RTE_CRYPTODEV_FF_MLDSA_SIGN_PREHASH)) {
+			RTE_LOG(DEBUG, USER1,
+				"Device doesn't support prehash in ML-DSA verify. Test skipped\n");
+			return TEST_SKIPPED;
+		}
+	}
+
 	if (rte_cryptodev_asym_session_create(dev_id, &xform,
 			params->session_mpool, &self->sess) < 0) {
 		RTE_LOG(ERR, USER1, "line %u FAILED: Session creation failed",
@@ -4379,6 +4396,7 @@ mldsa_verify(const void *test_data)
 	self->op->asym->mldsa.sigver.pubkey.length = vector->pubkey.length;
 	self->op->asym->mldsa.sigver.sign.data = vector->sign.data;
 	self->op->asym->mldsa.sigver.sign.length = vector->sign.length;
+	self->op->asym->mldsa.sigver.hash = vector->hash;
 
 	TEST_ASSERT_SUCCESS(send_one(),
 		"Failed to process crypto op (ML-DSA Verify)");
@@ -4403,6 +4421,7 @@ mldsa_verify(const void *test_data)
 	self->op->asym->mldsa.sigver.pubkey.length = vector->pubkey.length;
 	self->op->asym->mldsa.sigver.sign.data = sign;
 	self->op->asym->mldsa.sigver.sign.length = sign_len;
+	self->op->asym->mldsa.sigver.hash = vector->hash;
 
 	TEST_ASSERT_SUCCESS(send_one_no_status_check(),
 		"Failed to process crypto op (ML-DSA Verify)");
-- 
2.37.1

