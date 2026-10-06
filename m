Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCC9CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F2C241157;
	Tue,  6 Oct 2026 17:18:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 9839A40270
 for <dev@dpdk.org>; Tue,  6 Oct 2026 11:05:51 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6968hk7H2928808; Tue, 6 Oct 2026 02:05:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
 jRpO7KQLCtI2MKKUMSiPM+OGfGRolh1+atcnIi45Og=; b=akFeMHAwEZOCFaDot
 dkn3EtqV5RarIkO/WO2hoLgrnPARZPiamg6lxin5OK41PPrjCD88HIFIJi6uEUEK
 gnzqqywEbaaL2VRFRY6dOMKUUvBy+S7SyctBfMdfLS05oszvOH8qBnl4wyTmOtJh
 KF1gMH3v/kzYmll83p2gV/55OUMxmIvuDNk6r+WOI3iCCr5vwEvzxJ3BjBfq6/c1
 zRLYO3ItLUfaetGkaa3PE0dp+jEYUPBW+4jm+YUZSaop/cK5vifoNPbXclef3tnS
 BtkTVf7YOP4Dm6FOi7CfBdZGZetPZqY0hZ0KDI0nYnLphpAAghakNYbTk0zvLi5p
 YYcRw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h49scp51x-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 02:05:50 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Oct 2026 02:05:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Oct 2026 02:05:49 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id BF0333F7053;
 Tue,  6 Oct 2026 02:05:47 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <gmuthukrishn@marvell.com>, <kai.ji@intel.com>
Subject: [PATCH 4/4] app/crypto-perf: add ML-DSA sign support
Date: Tue, 6 Oct 2026 14:35:38 +0530
Message-ID: <20261006090538.1571812-4-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006090538.1571812-1-psenapati@marvell.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20261006090538.1571812-1-psenapati@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX9DyHIkQfNgYi
 fkFZI8VTOEwrlCNsRLl9VgJZ80H5N2TAd5BseHTnAhzJcos5F4QaaIoqR4xyH6n7bPNgQc0+Wmg
 hUtQ6Sn1ehtPg8/hKus/SOLd07rjCn0iBYKPec9g4Z9aA1EZzJt+Et7gCJjkovdWbba8SDcVSkC
 6Y8nfiNSo6/pONcu17GVCRHGDwsF0PAi93iHU/iSopHoWMUzvaQw/ipnP6o3/lnISHPGmoM6mt2
 nuNwDFOpvL00qmRienzmmhQWaSIUtNnFZt7BPP6+qJ8T3dn8BH72I3lthlg9ecNuQSywxk8UbjP
 teZ5Dwgi5c73JxE/Hel5B1iA0ApryLoercTYsh3eAH4p+ejGIMvDqqUj3L64KHijTuoXERJ72OS
 ZsOB/YAuDen9wItqYSZxZsAs9DHV+ojk08PkkSOn9WuIyk/qfxq6t9K/75CKQ+GqtjcISHIFNV3
 9j/O/FGngESsxRaZB1A==
X-Proofpoint-ORIG-GUID: pg8pg6bTgUsHXv1d4qS26L6KnMEu2hkj
X-Authority-Analysis: v=2.4 cv=XZEcX455 c=1 sm=1 tr=0 ts=6ac4b9ee cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=I0XV8kyQNLjoSpTcVfAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzNSBTYWx0ZWRfX21EnIrmGOuLk
 Ok9mi8TpdQHhwAK9vyQmsAKzFhcWid1Moqo8g+CWOS9XgcfmjKlKo9Ai8hqxwjTsE20T7hplugJ
 VnO42q4b28MU1kTOUt2b21v/LxLXrFg=
X-Proofpoint-GUID: pg8pg6bTgUsHXv1d4qS26L6KnMEu2hkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01
X-Mailman-Approved-At: Tue, 06 Oct 2026 17:18:35 +0200
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

Extend ML-DSA sign iteration support to include
ML-DSA65 and ML-DSA87 for 1, 5 and 10 sign iterations.

Signed-off-by: Pratik Senapati <psenapati@marvell.com>
---
 app/test-crypto-perf/cperf_options_parsing.c |   3 +-
 app/test-crypto-perf/cperf_test_vectors.c    | 170 ++++++++++++++++++-
 app/test-crypto-perf/main.c                  |  28 ++-
 doc/guides/tools/cryptoperf.rst              |   5 +-
 4 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 332e8746b2..bc7ccdcc9e 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -1820,8 +1820,7 @@ cperf_options_dump(struct cperf_options *opts)
 		case CPERF_ASYM_MLDSA65:
 		case CPERF_ASYM_MLDSA87:
 			printf("# mldsa algorithm: %s\n", cperf_op_type_strs[opts->op_type]);
-			if (opts->op_type == CPERF_ASYM_MLDSA44 &&
-				opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN)
+			if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN)
 				printf("# mldsa sign iterations: %u\n", opts->mldsa_sign_iter);
 			break;
 		case CPERF_ASYM_MLKEM512:
diff --git a/app/test-crypto-perf/cperf_test_vectors.c b/app/test-crypto-perf/cperf_test_vectors.c
index b2ea9b203c..09e65476ea 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -8684,7 +8684,7 @@ static const uint8_t mldsa_65_pubkey_noseed[] = {
 };
 
 static const uint8_t mldsa_65_message[] = {
-	0x60, 0xD4, 0x8C, 0xF2, 0x61, 0x6D, 0xB0, 0xB6,
+	0x1C, 0x00, 0x00, 0x00, 0x61, 0x6D, 0xB0, 0xB6,
 	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
 	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
 	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
@@ -10645,6 +10645,48 @@ static const uint8_t mldsa_87_sign_dtrm[] = {
 	0x28, 0x30, 0x3C,
 };
 
+static const uint8_t mldsa_65_message_1_iter[] = {
+	0x13, 0xCD, 0x8C, 0x83, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static const uint8_t mldsa_65_message_5_iter[] = {
+	0xE3, 0xB3, 0xF1, 0x9F, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static const uint8_t mldsa_65_message_10_iter[] = {
+	0x83, 0x81, 0xBB, 0xD8, 0x61, 0x6D, 0xB0, 0xB6,
+	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
+	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
+	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
+};
+
+static const uint8_t mldsa_87_message_1_iter[] = {
+	0x80, 0x1B, 0x53, 0xC5, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
+static const uint8_t mldsa_87_message_5_iter[] = {
+	0x50, 0x02, 0xB8, 0xE1, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
+static const uint8_t mldsa_87_message_10_iter[] = {
+	0xD2, 0xAD, 0x0A, 0xE5, 0xF4, 0xB3, 0xD4, 0x7F,
+	0xD2, 0x7E, 0x02, 0xA5, 0x93, 0x80, 0x26, 0x90,
+	0xB6, 0xE9, 0xC3, 0xBC, 0xB0, 0xB9, 0x03, 0xC1,
+	0x36, 0xB4, 0x5B, 0xEF, 0xA5, 0x80, 0x50, 0xDD,
+};
+
 struct
 cperf_rsa_test_data rsa_qt_perf_data[4] = {
 	{
@@ -11222,6 +11264,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_1_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_1_iteration (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_1_iter,
+			.length = sizeof(mldsa_65_message_1_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_1_iteration (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_1_iter,
+			.length = sizeof(mldsa_87_message_1_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_mldsa_test_data mldsa_sign_perf_data_5_iter[] = {
@@ -11246,6 +11330,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_5_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_5_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_5_iter,
+			.length = sizeof(mldsa_65_message_5_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_5_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_5_iter,
+			.length = sizeof(mldsa_87_message_5_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_mldsa_test_data mldsa_sign_perf_data_10_iter[] = {
@@ -11270,6 +11396,48 @@ struct cperf_mldsa_test_data mldsa_sign_perf_data_10_iter[] = {
 		},
 		.sign_deterministic = true,
 	},
+	{
+		.name = "mldsa_65_sign_10_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_65,
+		.privkey = {
+			.data = mldsa_65_privkey_noseed,
+			.length = sizeof(mldsa_65_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_65_pubkey_noseed,
+			.length = sizeof(mldsa_65_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_65_message_10_iter,
+			.length = sizeof(mldsa_65_message_10_iter),
+		},
+		.sign = {
+			.data = mldsa_65_sign_dtrm,
+			.length = sizeof(mldsa_65_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
+	{
+		.name = "mldsa_87_sign_10_iterations (deterministic)",
+		.type = RTE_CRYPTO_ML_DSA_87,
+		.privkey = {
+			.data = mldsa_87_privkey_noseed,
+			.length = sizeof(mldsa_87_privkey_noseed),
+		},
+		.pubkey = {
+			.data = mldsa_87_pubkey_noseed,
+			.length = sizeof(mldsa_87_pubkey_noseed),
+		},
+		.message = {
+			.data = mldsa_87_message_10_iter,
+			.length = sizeof(mldsa_87_message_10_iter),
+		},
+		.sign = {
+			.data = mldsa_87_sign_dtrm,
+			.length = sizeof(mldsa_87_sign_dtrm),
+		},
+		.sign_deterministic = true,
+	},
 };
 
 struct cperf_test_vector*
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 85e145165f..dc781bb9cc 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -544,23 +544,19 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 				mldsa_idx = 2;
 
 			if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
-				if (opts->op_type == CPERF_ASYM_MLDSA44) {
-					switch (opts->mldsa_sign_iter) {
-					case 1:
-						opts->mldsa_data = &mldsa_sign_perf_data_1_iter[0];
-						break;
-					case 5:
-						opts->mldsa_data = &mldsa_sign_perf_data_5_iter[0];
-						break;
-					case 10:
-						opts->mldsa_data = &mldsa_sign_perf_data_10_iter[0];
-						break;
-					default:
-						opts->mldsa_data = &mldsa_sign_perf_data[0];
-						break;
-					}
-				} else {
+				switch (opts->mldsa_sign_iter) {
+				case 1:
+					opts->mldsa_data = &mldsa_sign_perf_data_1_iter[mldsa_idx];
+					break;
+				case 5:
+					opts->mldsa_data = &mldsa_sign_perf_data_5_iter[mldsa_idx];
+					break;
+				case 10:
+					opts->mldsa_data = &mldsa_sign_perf_data_10_iter[mldsa_idx];
+					break;
+				default:
 					opts->mldsa_data = &mldsa_sign_perf_data[mldsa_idx];
+					break;
 				}
 			} else if (opts->asym_op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
 				opts->mldsa_data = &mldsa_verify_perf_data[mldsa_idx];
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index efd56a25fb..2536476617 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -366,10 +366,11 @@ The following are the application command-line options:
 
 * ``--mldsa-sign-iter <1/5/10>``
 
-        Set ML-DSA sign iteration count for mldsa_44 sign operation.
+        Set ML-DSA sign iteration count for mldsa sign operation.
         Default is ``1``.
         Only applicable when:
-        ``--optype mldsa_44`` and ``--asym-op sign``.
+        ``--optype mldsa_44``, ``--optype mldsa_65``, ``--optype mldsa_87``
+        and ``--asym-op sign``.
 
 * ``--rsa-priv-keytype <exp/qt>``
 
-- 
2.43.0

