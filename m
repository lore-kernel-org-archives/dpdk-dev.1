Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C720CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 05:25:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 747BF40658;
	Thu, 21 Aug 2025 07:25:08 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 693EB40659
 for <dev@dpdk.org>; Thu, 21 Aug 2025 07:25:06 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L5B7BZ025488;
 Wed, 20 Aug 2025 22:25:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 IG52dVJwxMOR4Cpc/cv/NFuWBsxQOnM+jN7zJ4ULr8=; b=K+f9xU4pEwQQjV06k
 2XxrDC1sDWrzGKLxVefMw6+ynEh0LyUgyKlsf/KlzHK1QhqYpKW3oVqulHujHyss
 nQmePkNZ7G4GayBxpstKADJyY4IbpuVcsl1+rIXp2sZmyDW1HlFoA8OJCjezu+ei
 UsLeZLYq8lLWwJGPDpUabgeGnvaRH8w40jwedRase2jIv925zEelgpgKNtouxcPQ
 SrCdzkIgTqq3ldzioNLkO39OeD4uUVMsLMCH3vrskgTxBFmYbOqVldC/JQnGD1u5
 egEC/o2SljaeHka+jg1Yrs/iwGxr66cI9SZ6TUPPOvJ4PwcedC+ioiuJzWNjqOnI
 V8m+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48nw39r0rr-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Aug 2025 22:25:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 20 Aug 2025 22:25:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 20 Aug 2025 22:25:09 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 390843F70DD;
 Wed, 20 Aug 2025 22:25:01 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <kai.ji@intel.com>,
 "Sucharitha Sarananaga" <ssarananaga@marvell.com>
Subject: [PATCH 2/2] app/test-crypto-perf: fix other asym ops execution failure
Date: Thu, 21 Aug 2025 05:24:40 +0000
Message-ID: <20250821052440.3213146-3-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821052440.3213146-1-ssarananaga@marvell.com>
References: <20250821052440.3213146-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PLFWOfqC c=1 sm=1 tr=0 ts=68a6adb1 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=mxMb9WXqZ-r43YcflRAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIxMDA0MCBTYWx0ZWRfX411YJZ369miw
 JucOkte2yoMfjhudlLKNkxWyMjXmI74eGe42JyxVSHswTYfYkGLr5aVPuXp0AXCwaETt+79LrYi
 lz8XXPj1sSKC+98Yy8L1I8MJ2HbXKSggW3fqI0aCQwWku6lgKMz8eu9g2c2s0j+aixtzjxk6d/A
 OKijYoVU9Nl1QYTlV0wnB0L9vnczMxtqNCkIzLuUcOWW1V9xn3GLTu7cqrPAa8v0y45e0IGp8Q5
 52blEya2UunGL1nvVIpfAkCDolsosuXXJUOthOgD9qbxHgtaDUdLSDKzG9PcBdPo5JDFGZ2jf7F
 +SEP4srj96HaRd5MVYZhhWroEDz925URcFJmDn94M723ORxWHF5LkZ4PUw5fLAa5SeNRMFYW2A7
 NlAnOkipQqQaXmRuNpLj7GQ+obSaWeUfYubJFWe+LVJ2YYvE93qYkYSS1c44/J179ZO3Vihk
X-Proofpoint-GUID: OyS0jYX9yueMGzynaAHhvDfV21B9xHQE
X-Proofpoint-ORIG-GUID: OyS0jYX9yueMGzynaAHhvDfV21B9xHQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
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

This patch addresses an issue where execution operations were failing
despite the optype parameter being correctly configured. The failure
occurring because it is executing rsa optype params check instead of
configured optype and removed copying of sign data into temporary buffer.

Fixes: e131b8e643fd ("app/crypto-perf: add RSA test vectors")

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 app/test-crypto-perf/cperf_ops.c             |   4 +-
 app/test-crypto-perf/cperf_options_parsing.c | 156 ++++++++++---------
 2 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index 20fba60426..49ee1ae49c 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -69,9 +69,7 @@ cperf_set_ops_asym_rsa(struct rte_crypto_op **ops,
 			asym_op->rsa.message.data = crypto_buf;
 			asym_op->rsa.message.length = options->rsa_data->n.length;
 		} else if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
-			memcpy(crypto_buf, options->rsa_data->sign.data,
-				options->rsa_data->sign.length);
-			asym_op->rsa.sign.data = crypto_buf;
+			asym_op->rsa.sign.data = options->rsa_data->sign.data;
 			asym_op->rsa.sign.length = options->rsa_data->sign.length;
 			asym_op->rsa.message.data = rsa_plaintext.data;
 			asym_op->rsa.message.length = rsa_plaintext.len;
diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 0c7c57ce42..dc36dc0f2d 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1358,6 +1358,40 @@ is_valid_chained_op(struct cperf_options *options)
 	return false;
 }
 
+static int
+cperf_rsa_options_check(struct cperf_options *options)
+{
+	if (options->rsa_keytype != UINT8_MAX) {
+		switch (options->rsa_keytype) {
+		case RTE_RSA_KEY_TYPE_QT:
+			if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_SIGN &&
+				options->asym_op_type != RTE_CRYPTO_ASYM_OP_DECRYPT) {
+				RTE_LOG(ERR, USER1, "QT private key to be used in sign and decrypt op\n");
+				return -EINVAL;
+			}
+			options->rsa_data = &rsa_qt_perf_data[0];
+			break;
+		case RTE_RSA_KEY_TYPE_EXP:
+			if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_ENCRYPT &&
+				options->asym_op_type != RTE_CRYPTO_ASYM_OP_VERIFY) {
+				RTE_LOG(ERR, USER1, "Exponent private key to be used in encrypt and verify op\n");
+				return -EINVAL;
+			}
+			options->rsa_data = &rsa_exp_perf_data[0];
+			break;
+		default:
+			RTE_LOG(ERR, USER1, "Invalid RSA key type specified\n");
+			return -EINVAL;
+		}
+	} else {
+		if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+			RTE_LOG(ERR, USER1, "Public key to be used in encrypt op\n");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 int
 cperf_options_check(struct cperf_options *options)
 {
@@ -1522,95 +1556,65 @@ cperf_options_check(struct cperf_options *options)
 		}
 	}
 
-	if (options->rsa_keytype != UINT8_MAX) {
-		if (options->op_type != CPERF_ASYM_RSA) {
-			RTE_LOG(ERR, USER1, "Option rsa-priv-keytype should be used only with "
-					" optype: rsa.\n");
-			return -EINVAL;
-		}
-
-		switch (options->rsa_keytype) {
-		case RTE_RSA_KEY_TYPE_QT:
-			if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_SIGN &&
-			    options->asym_op_type != RTE_CRYPTO_ASYM_OP_DECRYPT) {
-				RTE_LOG(ERR, USER1, "QT private key to be used in sign and decrypt op\n");
-				return -EINVAL;
-			}
-			options->rsa_data = &rsa_qt_perf_data[0];
-			break;
-		case RTE_RSA_KEY_TYPE_EXP:
-			if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_ENCRYPT &&
-			    options->asym_op_type != RTE_CRYPTO_ASYM_OP_VERIFY) {
-				RTE_LOG(ERR, USER1, "Exponent private key to be used in encrypt and verify op\n");
-				return -EINVAL;
-			}
-			options->rsa_data = &rsa_exp_perf_data[0];
-			break;
-		default:
-			RTE_LOG(ERR, USER1, "Invalid RSA key type specified\n");
-			return -EINVAL;
-		}
-	} else {
-		if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_ENCRYPT) {
-			RTE_LOG(ERR, USER1, "Public key to be used in encrypt op\n");
-			return -EINVAL;
-		}
-	}
 
-	if (options->rsa_modlen) {
-		if (options->op_type != CPERF_ASYM_RSA) {
-			RTE_LOG(ERR, USER1, "Option rsa-modlen should be used only with "
-					" optype: rsa.\n");
+	if (options->op_type == CPERF_ASYM_RSA) {
+		if (cperf_rsa_options_check(options) < 0) {
+			RTE_LOG(ERR, USER1, "Invalid RSA options\n");
 			return -EINVAL;
 		}
 
-		if (options->rsa_keytype == RTE_RSA_KEY_TYPE_QT) {
-			for (i = 0; i < (int)RTE_DIM(rsa_qt_perf_data); i++) {
-				modlen = rsa_qt_perf_data[i].n.length * 8;
-				if (options->rsa_modlen == modlen) {
-					options->rsa_data =
-						(struct cperf_rsa_test_data *)&rsa_qt_perf_data[i];
-					break;
+		if (options->rsa_modlen) {
+			if (options->rsa_keytype == RTE_RSA_KEY_TYPE_QT) {
+				for (i = 0; i < (int)RTE_DIM(rsa_qt_perf_data); i++) {
+					modlen = rsa_qt_perf_data[i].n.length * 8;
+					if (options->rsa_modlen == modlen) {
+						options->rsa_data =
+							(struct cperf_rsa_test_data *)
+							&rsa_qt_perf_data[i];
+						break;
+					}
 				}
-			}
 
-			if (i == (int)RTE_DIM(rsa_qt_perf_data)) {
-				RTE_LOG(ERR, USER1,
-					"Option rsa_modlen: %d is not supported for QT private key\n",
-					options->rsa_modlen);
+				if (i == (int)RTE_DIM(rsa_qt_perf_data)) {
+					RTE_LOG(ERR, USER1,
+						"Option rsa_modlen: %d is not supported for QT private key\n",
+						options->rsa_modlen);
 					return -EINVAL;
-			}
-		} else if (options->rsa_keytype == RTE_RSA_KEY_TYPE_EXP) {
-			for (i = 0; i < (int)RTE_DIM(rsa_exp_perf_data); i++) {
-				modlen = rsa_exp_perf_data[i].n.length * 8;
-				if (options->rsa_modlen == modlen) {
-					options->rsa_data =
-						(struct cperf_rsa_test_data *)&rsa_exp_perf_data[i];
-					break;
 				}
-			}
+			} else if (options->rsa_keytype == RTE_RSA_KEY_TYPE_EXP) {
+				for (i = 0; i < (int)RTE_DIM(rsa_exp_perf_data); i++) {
+					modlen = rsa_exp_perf_data[i].n.length * 8;
+					if (options->rsa_modlen == modlen) {
+						options->rsa_data =
+							(struct cperf_rsa_test_data *)
+							&rsa_exp_perf_data[i];
+						break;
+					}
+				}
 
-			if (i == (int)RTE_DIM(rsa_exp_perf_data)) {
-				RTE_LOG(ERR, USER1,
-					"Option rsa_modlen: %d is not supported for exponent private key\n",
-					options->rsa_modlen);
+				if (i == (int)RTE_DIM(rsa_exp_perf_data)) {
+					RTE_LOG(ERR, USER1,
+						"Option rsa_modlen: %d is not supported for exponent private key\n",
+						options->rsa_modlen);
 					return -EINVAL;
-			}
-		} else {
-			for (i = 0; i < (int)RTE_DIM(rsa_pub_perf_data); i++) {
-				modlen = rsa_pub_perf_data[i].n.length * 8;
-				if (options->rsa_modlen == modlen) {
-					options->rsa_data =
-						(struct cperf_rsa_test_data *)&rsa_pub_perf_data[i];
-					break;
 				}
-			}
+			} else {
+				for (i = 0; i < (int)RTE_DIM(rsa_pub_perf_data); i++) {
+					modlen = rsa_pub_perf_data[i].n.length * 8;
+					if (options->rsa_modlen == modlen) {
+						options->rsa_data =
+							(struct cperf_rsa_test_data *)
+							&rsa_pub_perf_data[i];
+						break;
+					}
+				}
 
-			if (i == (int)RTE_DIM(rsa_pub_perf_data)) {
-				RTE_LOG(ERR, USER1,
-					"Option rsa_modlen: %d is not supported for public key\n",
-					options->rsa_modlen);
+				if (i == (int)RTE_DIM(rsa_pub_perf_data)) {
+					RTE_LOG(ERR, USER1,
+						"Option rsa_modlen: %d is not supported for public key\n",
+						options->rsa_modlen);
 					return -EINVAL;
+				}
 			}
 		}
 	}
-- 
2.49.0

