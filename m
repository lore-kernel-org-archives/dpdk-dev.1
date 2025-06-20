Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C8C71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 08:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C9EB42EAA;
	Fri, 20 Jun 2025 10:20:01 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B3B8742EA8;
 Fri, 20 Jun 2025 10:19:59 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4haIh027292;
 Fri, 20 Jun 2025 01:19:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
 tLudzc/7nNFQq6t4fb6f7Qq3cCkrUr+KpOQOSQQj2c=; b=SQmQUcuWrStRxME2h
 1QlYx7Cfm5HZbC3wqKUuw6K2kIF7h06+WNmY/4JG7t4rARIAmsUw2lMVaMGmvJ47
 xVe8H90so/42sAj+zKEUyAZv+A4NXjJcTpKJpnfYgnLojYWv1mxlCf8bwVnw4EX8
 5aj4LChrZuSz3ATA2trLGekVS1U1ef2VeOooFkIM2r7OD+sMpBYDJrWbH5TH0au/
 ROUWvSvbe8gQwUcuD8qADe1Xdtm8E5RPSwWwTi0+kxlJ5CSfY/nNYQX55LkRd1Ho
 Gqq+YqtHKZaT3nt/JCZRmYlXfixtI6el9X5VG7vAWvH7DNU2fwHYRAKjpkEp1rKF
 gUjMw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47d0vb0bva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 01:19:58 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 01:19:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 01:19:36 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.22.173])
 by maili.marvell.com (Postfix) with ESMTP id E5B365B692D;
 Fri, 20 Jun 2025 01:19:32 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Shally Verma <shallyv@marvell.com>, Ayuj Verma
 <ayverma@marvell.com>, Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Kanaka Durga Kotamarthy <kkotamarthy@marvell.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan
 <gmuthukrishn@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 2/3] test/crypto: fix RSA test vector as per RFC 8017
Date: Fri, 20 Jun 2025 13:49:17 +0530
Message-ID: <20250620081921.2145-2-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250620081921.2145-1-gmuthukrishn@marvell.com>
References: <20250620081921.2145-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xz-o8GGJLoR8jq32ThU4et83HddI8deJ
X-Authority-Analysis: v=2.4 cv=O+s5vA9W c=1 sm=1 tr=0 ts=685519ae cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8 a=v7WbcW5KKyrAac62HV8A:9
 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: xz-o8GGJLoR8jq32ThU4et83HddI8deJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA2MSBTYWx0ZWRfX29dHwXowP3ae
 psTYvFJVpDMjpMIMNJQhk+hNYmCVORkdo2PMa1b7kPYwlUth5UCQo2g4epURldGxjL4Zitvoj87
 Sjks4h2FQOO73onVPUVmMLWC1IbAHb1tP5CbbTsND5bKlNIREw3UtUmk9q3kNKComlbLM5J2Peu
 O6FHHpYoNHjM+1uF3fpbO9tLE+R6eevh/QOw6PZ9fzDJpbXqAQeVGqOxno1rdSF9mxe8zHGCBxz
 JcZbSA5cLSi49gLXdhrLD/aKF3lPDOfWKzkZPCwzAKBfskCWC5R1Jdf4ahzqFZ9roug+KQ/xVTo
 2chtgSsPP54H437UDS+Sv6kPLQIJt+nVbMyEdzj2iKJ0yz81M/xckILZQ3qZvbBk3BfTGcMFbQa
 1oqDzUip36vj5vaHumYDGEjgb6y5GfOPAIzPy1okNj9vWj80URcN5MAe4ZEPzbZ5Q7YTIrRX
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

As per RFC 8017 (A.1.2), RSA private key should be represented
with both exponent and CRT forms of data for inter operability.

Fixes: a379799cbaaf ("test/crypto: add RSA key type CRT")
Cc: stable@dpdk.org

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 app/test/test_cryptodev_asym.c             | 16 ++++++++---
 app/test/test_cryptodev_rsa_test_vectors.h | 32 +++++-----------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/app/test/test_cryptodev_asym.c b/app/test/test_cryptodev_asym.c
index fcaf73aa1a..a5f3eae41d 100644
--- a/app/test/test_cryptodev_asym.c
+++ b/app/test/test_cryptodev_asym.c
@@ -260,6 +260,7 @@ test_rsa_sign_verify(void)
 	struct rte_mempool *sess_mpool = ts_params->session_mpool;
 	struct rte_cryptodev_asym_capability_idx idx;
 	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_xform xform;
 	void *sess = NULL;
 	struct rte_cryptodev_info dev_info;
 	int ret, status = TEST_SUCCESS;
@@ -280,7 +281,10 @@ test_rsa_sign_verify(void)
 		return TEST_SKIPPED;
 	}
 
-	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform, sess_mpool, &sess);
+	memcpy(&xform, &rsa_xform, sizeof(rsa_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
 
 	if (ret < 0) {
 		RTE_LOG(ERR, USER1, "Session creation failed for "
@@ -306,6 +310,7 @@ test_rsa_enc_dec(void)
 	struct rte_mempool *sess_mpool = ts_params->session_mpool;
 	struct rte_cryptodev_asym_capability_idx idx;
 	uint8_t dev_id = ts_params->valid_devs[0];
+	struct rte_crypto_asym_xform xform;
 	void *sess = NULL;
 	struct rte_cryptodev_info dev_info;
 	int ret, status = TEST_SUCCESS;
@@ -326,7 +331,10 @@ test_rsa_enc_dec(void)
 		return TEST_SKIPPED;
 	}
 
-	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform, sess_mpool, &sess);
+	memcpy(&xform, &rsa_xform, sizeof(rsa_xform));
+	xform.rsa.key_type = RTE_RSA_KEY_TYPE_EXP;
+
+	ret = rte_cryptodev_asym_session_create(dev_id, &xform, sess_mpool, &sess);
 
 	if (ret < 0) {
 		RTE_LOG(ERR, USER1, "Session creation failed for enc_dec\n");
@@ -371,7 +379,7 @@ test_rsa_sign_verify_crt(void)
 		return TEST_SKIPPED;
 	}
 
-	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform_crt, sess_mpool, &sess);
+	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform, sess_mpool, &sess);
 
 	if (ret < 0) {
 		RTE_LOG(ERR, USER1, "Session creation failed for "
@@ -417,7 +425,7 @@ test_rsa_enc_dec_crt(void)
 		return TEST_SKIPPED;
 	}
 
-	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform_crt, sess_mpool, &sess);
+	ret = rte_cryptodev_asym_session_create(dev_id, &rsa_xform, sess_mpool, &sess);
 
 	if (ret < 0) {
 		RTE_LOG(ERR, USER1, "Session creation failed for "
diff --git a/app/test/test_cryptodev_rsa_test_vectors.h b/app/test/test_cryptodev_rsa_test_vectors.h
index 1b7b451387..9652b0d43a 100644
--- a/app/test/test_cryptodev_rsa_test_vectors.h
+++ b/app/test/test_cryptodev_rsa_test_vectors.h
@@ -340,7 +340,7 @@ uint8_t rsa_qInv[] = {
 	0x71, 0x94, 0xdd, 0xa0, 0xf5, 0x1e, 0x6d, 0xcc
 };
 
-/** rsa xform using exponent key */
+/** rsa xform (of QT private key type by default) */
 struct rte_crypto_asym_xform rsa_xform = {
 	.next = NULL,
 	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
@@ -354,29 +354,6 @@ struct rte_crypto_asym_xform rsa_xform = {
 			.data = rsa_e,
 			.length = sizeof(rsa_e)
 		},
-		.key_type = RTE_RSA_KEY_TYPE_EXP,
-		.d = {
-			.data = rsa_d,
-			.length = sizeof(rsa_d)
-		}
-	}
-};
-
-/** rsa xform using quintuple key */
-struct rte_crypto_asym_xform rsa_xform_crt = {
-	.next = NULL,
-	.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA,
-	.rsa = {
-		.padding.type = RTE_CRYPTO_RSA_PADDING_PKCS1_5,
-		.n = {
-			.data = rsa_n,
-			.length = sizeof(rsa_n)
-		},
-		.e = {
-			.data = rsa_e,
-			.length = sizeof(rsa_e)
-		},
-		.key_type = RTE_RSA_KEY_TYPE_QT,
 		.qt = {
 			.p = {
 				.data = rsa_p,
@@ -398,7 +375,12 @@ struct rte_crypto_asym_xform rsa_xform_crt = {
 				.data = rsa_qInv,
 				.length = sizeof(rsa_qInv)
 			},
-		}
+		},
+		.d = {
+			.data = rsa_d,
+			.length = sizeof(rsa_d)
+		},
+		.key_type = RTE_RSA_KEY_TYPE_QT
 	}
 };
 
-- 
2.25.1

