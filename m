Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6ACA0EE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 04:15:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08E6F40430;
	Tue, 19 Aug 2025 06:15:26 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 68CB3402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 06:15:24 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57INWJCF004111;
 Mon, 18 Aug 2025 21:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=VJbLTCf7xuvZLDitIRzZnQE
 a/wATMEGjo6MBhfHUlU0=; b=EQz/G9v4reFalkndiV2X6N1hfO6RYVO+ZfGG77M
 0cfHwGoGWwebg9GrpH5eAhy1wQ0g+W7bkbtasf3LxX1zIblWFiPHx5GPaR/N27n8
 cQZIHMB/DIk/ar3rjimqDaJfXxvbw4SqRBQJ6VvydQzM4x7dc7M/HOD2cBcMhy5a
 BrXD44h2nYi6q5vkvdVdQUAMqC45K7nnt/l1jAS67LGh6jeLV2SyWcMzQ2VMZ33j
 zvmbqE+9p4WIUvYd0nSUc/nF4a4/hOJRZgJk8L5v/Ip2makAyXuL2RsSdDJCoVSJ
 w41PAt0wPAZlNjKnXbpWTk9RLoHxDDxADsm8Qvs6aJMZH0w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 48mdx0gesj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 21:15:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 18 Aug 2025 21:15:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 18 Aug 2025 21:15:26 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 57B673F707F;
 Mon, 18 Aug 2025 21:15:19 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: Kai Ji <kai.ji@intel.com>
CC: <dev@dpdk.org>, <gakhil@marvell.com>, <anoobj@marvell.com>,
 <ktejasree@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>
Subject: [PATCH] app/crypto-perf: add ECDSA P384 support
Date: Tue, 19 Aug 2025 09:45:17 +0530
Message-ID: <20250819041517.1638717-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YzukXpwC4aWs6r5q-uxBJO6jNQYLuISF
X-Proofpoint-ORIG-GUID: YzukXpwC4aWs6r5q-uxBJO6jNQYLuISF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDAzNyBTYWx0ZWRfX1y0UDNMakIJU
 dbtp4ay04IFwWZ69WkQs92y7OdMg52dybc01fWooQP1sKNJFQ+QF3wESlWxsPEJt1XrilHP7XYe
 KNM485zIVuoPHplDVEFBBtc8Cb/xTexaKME489MtYjrpod22BCLmD26VoS8by0mzIqPw+nIoqBO
 EVdcppXb1+MM5BJmYFs0NpsUR+60hmIfkEs7wGlAlSRnKCuR86vgvcSUTftFPSJjFZdVFcUtHko
 jWzULB1eyfFuB2dcgCE83kG8iw8n0b2ohRK8GJGECMDvpWgi6NvIAAH8/ySr0GPEJFL0MY+sULr
 2ZeHMtyWFX56TRviqJQCe5CLYlg5rQn08wf/41T5fH6owjCjrpYUUqB7sQZdJa2fDvEoPGccL7J
 4hiZuVZ+blDwTqsoVPZPjliIwRdFOI5ThCR0RcapE0DqerloZc4+xEZ0LreSPsGjHA7s3eLU
X-Authority-Analysis: v=2.4 cv=D4hHKuRj c=1 sm=1 tr=0 ts=68a3fa5b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=UsacpLM7tMdhLN4-fR8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
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

Add support for ECDSA SECP384R1 curve SIGN and VERIFY operations

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
Change-Id: I0bde24ad5f93a9f2d37dfe156ba3325d3d151f8f
---
 app/test-crypto-perf/cperf_ops.c             | 58 +++++++++---
 app/test-crypto-perf/cperf_options.h         |  2 +
 app/test-crypto-perf/cperf_options_parsing.c |  7 +-
 app/test-crypto-perf/cperf_test_common.c     |  1 +
 app/test-crypto-perf/cperf_test_vectors.c    | 95 ++++++++++++++++++++
 app/test-crypto-perf/cperf_test_vectors.h    |  1 +
 app/test-crypto-perf/main.c                  | 14 ++-
 doc/guides/tools/cryptoperf.rst              |  1 +
 8 files changed, 165 insertions(+), 14 deletions(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index ca4ef2b343..cedf18d628 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -101,16 +101,30 @@ cperf_set_ops_asym_ecdsa(struct rte_crypto_op **ops,
 		rte_crypto_op_attach_asym_session(ops[i], sess);
 
 		asym_op->ecdsa.op_type = options->asym_op_type;
-		asym_op->ecdsa.message.data = options->secp256r1_data->message.data;
-		asym_op->ecdsa.message.length = options->secp256r1_data->message.length;
-
-		asym_op->ecdsa.k.data = options->secp256r1_data->k.data;
-		asym_op->ecdsa.k.length = options->secp256r1_data->k.length;
+		if (options->op_type == CPERF_ASYM_SECP256R1) {
+			asym_op->ecdsa.message.data = options->secp256r1_data->message.data;
+			asym_op->ecdsa.message.length = options->secp256r1_data->message.length;
+
+			asym_op->ecdsa.k.data = options->secp256r1_data->k.data;
+			asym_op->ecdsa.k.length = options->secp256r1_data->k.length;
+
+			asym_op->ecdsa.r.data = options->secp256r1_data->sign_r.data;
+			asym_op->ecdsa.r.length = options->secp256r1_data->sign_r.length;
+			asym_op->ecdsa.s.data = options->secp256r1_data->sign_s.data;
+			asym_op->ecdsa.s.length = options->secp256r1_data->sign_s.length;
+		} else if (options->op_type == CPERF_ASYM_SECP384R1) {
+			asym_op->ecdsa.message.data = options->secp384r1_data->message.data;
+			asym_op->ecdsa.message.length = options->secp384r1_data->message.length;
+
+			asym_op->ecdsa.k.data = options->secp384r1_data->k.data;
+			asym_op->ecdsa.k.length = options->secp384r1_data->k.length;
+
+			asym_op->ecdsa.r.data = options->secp384r1_data->sign_r.data;
+			asym_op->ecdsa.r.length = options->secp384r1_data->sign_r.length;
+			asym_op->ecdsa.s.data = options->secp384r1_data->sign_s.data;
+			asym_op->ecdsa.s.length = options->secp384r1_data->sign_s.length;
+		}
 
-		asym_op->ecdsa.r.data = options->secp256r1_data->sign_r.data;
-		asym_op->ecdsa.r.length = options->secp256r1_data->sign_r.length;
-		asym_op->ecdsa.s.data = options->secp256r1_data->sign_s.data;
-		asym_op->ecdsa.s.length = options->secp256r1_data->sign_s.length;
 	}
 }
 
@@ -1133,7 +1147,28 @@ cperf_create_session(struct rte_mempool *sess_mp,
 		ret = rte_cryptodev_asym_session_create(dev_id, &xform,
 				sess_mp, &asym_sess);
 		if (ret < 0) {
-			RTE_LOG(ERR, USER1, "ECDSA Asym session create failed\n");
+			RTE_LOG(ERR, USER1, "ECDSA P256 Asym session create failed\n");
+			return NULL;
+		}
+
+		return asym_sess;
+	}
+
+	if (options->op_type == CPERF_ASYM_SECP384R1) {
+		xform.next = NULL;
+		xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
+		xform.ec.curve_id = options->secp384r1_data->curve;
+		xform.ec.pkey.data = options->secp384r1_data->pkey.data;
+		xform.ec.pkey.length = options->secp384r1_data->pkey.length;
+		xform.ec.q.x.data = options->secp384r1_data->pubkey_qx.data;
+		xform.ec.q.x.length = options->secp384r1_data->pubkey_qx.length;
+		xform.ec.q.y.data = options->secp384r1_data->pubkey_qy.data;
+		xform.ec.q.y.length = options->secp384r1_data->pubkey_qy.length;
+
+		ret = rte_cryptodev_asym_session_create(dev_id, &xform,
+				sess_mp, &asym_sess);
+		if (ret < 0) {
+			RTE_LOG(ERR, USER1, "ECDSA P384 Asym session create failed\n");
 			return NULL;
 		}
 
@@ -1485,6 +1520,9 @@ cperf_get_op_functions(const struct cperf_options *options,
 	case CPERF_ASYM_SECP256R1:
 		op_fns->populate_ops = cperf_set_ops_asym_ecdsa;
 		break;
+	case CPERF_ASYM_SECP384R1:
+		op_fns->populate_ops = cperf_set_ops_asym_ecdsa;
+		break;
 	case CPERF_ASYM_ED25519:
 		op_fns->populate_ops = cperf_set_ops_asym_eddsa;
 		break;
diff --git a/app/test-crypto-perf/cperf_options.h b/app/test-crypto-perf/cperf_options.h
index 028dd2d797..38621e28a0 100644
--- a/app/test-crypto-perf/cperf_options.h
+++ b/app/test-crypto-perf/cperf_options.h
@@ -95,6 +95,7 @@ enum cperf_op_type {
 	CPERF_ASYM_MODEX,
 	CPERF_ASYM_RSA,
 	CPERF_ASYM_SECP256R1,
+	CPERF_ASYM_SECP384R1,
 	CPERF_ASYM_ED25519,
 	CPERF_ASYM_SM2,
 	CPERF_TLS,
@@ -177,6 +178,7 @@ struct cperf_options {
 	struct cperf_modex_test_data *modex_data;
 	uint16_t modex_len;
 	struct cperf_ecdsa_test_data *secp256r1_data;
+	struct cperf_ecdsa_test_data *secp384r1_data;
 	struct cperf_eddsa_test_data *eddsa_data;
 	struct cperf_sm2_test_data *sm2_data;
 	enum rte_crypto_asym_op_type asym_op_type;
diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index dc36dc0f2d..d1d9c969e7 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -39,7 +39,7 @@ usage(char *progname)
 		" --devtype TYPE: set crypto device type to use\n"
 		" --low-prio-qp-mask mask: set low priority for queues set in mask(hex)\n"
 		" --optype cipher-only / auth-only / cipher-then-auth / auth-then-cipher /\n"
-		"        aead / pdcp / docsis / ipsec / modex / rsa / secp256r1 / eddsa / sm2 / tls-record : set operation type\n"
+		"        aead / pdcp / docsis / ipsec / modex / rsa / secp256r1 / secp384r1 / eddsa / sm2 / tls-record : set operation type\n"
 		" --sessionless: enable session-less crypto operations\n"
 		" --shared-session: share 1 session across all queue pairs on crypto device\n"
 		" --out-of-place: enable out-of-place crypto operations\n"
@@ -533,6 +533,10 @@ parse_op_type(struct cperf_options *opts, const char *arg)
 			cperf_op_type_strs[CPERF_ASYM_SECP256R1],
 			CPERF_ASYM_SECP256R1
 		},
+		{
+			cperf_op_type_strs[CPERF_ASYM_SECP384R1],
+			CPERF_ASYM_SECP384R1
+		},
 		{
 			cperf_op_type_strs[CPERF_ASYM_ED25519],
 			CPERF_ASYM_ED25519
@@ -1150,6 +1154,7 @@ cperf_options_default(struct cperf_options *opts)
 	opts->rsa_keytype = UINT8_MAX;
 
 	opts->secp256r1_data = &secp256r1_perf_data;
+	opts->secp384r1_data = &secp384r1_perf_data;
 	opts->eddsa_data = &ed25519_perf_data;
 	opts->sm2_data = &sm2_perf_data;
 	opts->asym_op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 0eea4d133d..da0202a870 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -308,6 +308,7 @@ cperf_is_asym_test(const struct cperf_options *options)
 	if (options->op_type == CPERF_ASYM_MODEX ||
 	    options->op_type == CPERF_ASYM_RSA ||
 	    options->op_type == CPERF_ASYM_SECP256R1 ||
+	    options->op_type == CPERF_ASYM_SECP384R1 ||
 	    options->op_type == CPERF_ASYM_ED25519 ||
 	    options->op_type == CPERF_ASYM_SM2)
 		return true;
diff --git a/app/test-crypto-perf/cperf_test_vectors.c b/app/test-crypto-perf/cperf_test_vectors.c
index 682988ccff..f1dedcd119 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -853,6 +853,67 @@ static uint8_t secp256r1_message[] = {
 	0xdb, 0xc4, 0xe7, 0xa6, 0xa1, 0x33, 0xec, 0x56
 };
 
+static uint8_t secp384r1_pkey[] = {
+	0xc6, 0x02, 0xbc, 0x74, 0xa3, 0x45, 0x92, 0xc3,
+	0x11, 0xa6, 0x56, 0x96, 0x61, 0xe0, 0x83, 0x2c,
+	0x84, 0xf7, 0x20, 0x72, 0x74, 0x67, 0x6c, 0xc4,
+	0x2a, 0x89, 0xf0, 0x58, 0x16, 0x26, 0x30, 0x18,
+	0x4b, 0x52, 0xf0, 0xd9, 0x9b, 0x85, 0x5a, 0x77,
+	0x83, 0xc9, 0x87, 0x47, 0x6d, 0x7f, 0x9e, 0x6b
+};
+
+static uint8_t secp384r1_qx[] = {
+	0x04, 0x00, 0x19, 0x3b, 0x21, 0xf0, 0x7c, 0xd0,
+	0x59, 0x82, 0x6e, 0x94, 0x53, 0xd3, 0xe9, 0x6d,
+	0xd1, 0x45, 0x04, 0x1c, 0x97, 0xd4, 0x9f, 0xf6,
+	0xb7, 0x04, 0x7f, 0x86, 0xbb, 0x0b, 0x04, 0x39,
+	0xe9, 0x09, 0x27, 0x4c, 0xb9, 0xc2, 0x82, 0xbf,
+	0xab, 0x88, 0x67, 0x4c, 0x07, 0x65, 0xbc, 0x75
+};
+
+static uint8_t secp384r1_qy[] = {
+	0xf7, 0x0d, 0x89, 0xc5, 0x2a, 0xcb, 0xc7, 0x04,
+	0x68, 0xd2, 0xc5, 0xae, 0x75, 0xc7, 0x6d, 0x7f,
+	0x69, 0xb7, 0x6a, 0xf6, 0x2d, 0xcf, 0x95, 0xe9,
+	0x9e, 0xba, 0x5d, 0xd1, 0x1a, 0xdf, 0x8f, 0x42,
+	0xec, 0x9a, 0x42, 0x5b, 0x0c, 0x5e, 0xc9, 0x8e,
+	0x2f, 0x23, 0x4a, 0x92, 0x6b, 0x82, 0xa1, 0x47
+};
+
+static uint8_t secp384r1_k[] = {
+	0xc1, 0x0b, 0x5c, 0x25, 0xc4, 0x68, 0x3d, 0x0b,
+	0x78, 0x27, 0xd0, 0xd8, 0x86, 0x97, 0xcd, 0xc0,
+	0x93, 0x24, 0x96, 0xb5, 0x29, 0x9b, 0x79, 0x8c,
+	0x0d, 0xd1, 0xe7, 0xaf, 0x6c, 0xc7, 0x57, 0xcc,
+	0xb3, 0x0f, 0xcd, 0x3d, 0x36, 0xea, 0xd4, 0xa8,
+	0x04, 0x87, 0x7e, 0x24, 0xf3, 0xa3, 0x24, 0x43
+};
+
+static uint8_t secp384r1_sign_r[] = {
+	0xb1, 0x1d, 0xb0, 0x0c, 0xda, 0xf5, 0x32, 0x86,
+	0xd4, 0x48, 0x3f, 0x38, 0xcd, 0x02, 0x78, 0x59,
+	0x48, 0x47, 0x7e, 0xd7, 0xeb, 0xc2, 0xad, 0x60,
+	0x90, 0x54, 0x55, 0x1d, 0xa0, 0xab, 0x03, 0x59,
+	0x97, 0x8c, 0x61, 0x85, 0x17, 0x88, 0xaa, 0x2e,
+	0xc3, 0x26, 0x79, 0x46, 0xd4, 0x40, 0xe8, 0x78
+};
+
+static uint8_t secp384r1_sign_s[] = {
+	0x16, 0x00, 0x78, 0x73, 0xc5, 0xb0, 0x60, 0x4c,
+	0xe6, 0x81, 0x12, 0xa8, 0xfe, 0xe9, 0x73, 0xe8,
+	0xe2, 0xb6, 0xe3, 0x31, 0x9c, 0x68, 0x3a, 0x76,
+	0x2f, 0xf5, 0x06, 0x5a, 0x07, 0x65, 0x12, 0xd7,
+	0xc9, 0x8b, 0x27, 0xe7, 0x4b, 0x78, 0x87, 0x67,
+	0x10, 0x48, 0xac, 0x02, 0x7d, 0xf8, 0xcb, 0xf2
+};
+
+static uint8_t secp384r1_message[] = {
+	0xbb, 0xbd, 0x0a, 0x5f, 0x64, 0x5d, 0x3f, 0xda,
+	0x10, 0xe2, 0x88, 0xd1, 0x72, 0xb2, 0x99, 0x45,
+	0x5f, 0x9d, 0xff, 0x00, 0xe0, 0xfb, 0xc2, 0x83,
+	0x3e, 0x18, 0xcd, 0x01, 0x7d, 0x7f, 0x3e, 0xd1
+};
+
 static uint8_t ed25519_pkey[] = {
 	0x4c, 0xcd, 0x08, 0x9b, 0x28, 0xff, 0x96, 0xda,
 	0x9d, 0xb6, 0xc3, 0x46, 0xec, 0x11, 0x4e, 0x0f,
@@ -1394,6 +1455,40 @@ cperf_ecdsa_test_data secp256r1_perf_data = {
 	.curve = RTE_CRYPTO_EC_GROUP_SECP256R1
 };
 
+/** ECDSA secp384r1 elliptic curve test params */
+struct
+cperf_ecdsa_test_data secp384r1_perf_data = {
+	.pubkey_qx = {
+		.data = secp384r1_qx,
+		.length = sizeof(secp384r1_qx),
+	},
+	.pubkey_qy = {
+		.data = secp384r1_qy,
+		.length = sizeof(secp384r1_qy),
+	},
+	.k = {
+		.data = secp384r1_k,
+		.length = sizeof(secp384r1_k),
+	},
+	.sign_r = {
+		.data = secp384r1_sign_r,
+		.length = sizeof(secp384r1_sign_r),
+	},
+	.sign_s = {
+		.data = secp384r1_sign_s,
+		.length = sizeof(secp384r1_sign_s),
+	},
+	.pkey = {
+		.data = secp384r1_pkey,
+		.length = sizeof(secp384r1_pkey),
+	},
+	.message = {
+		.data = secp384r1_message,
+		.length = sizeof(secp384r1_message),
+	},
+	.curve = RTE_CRYPTO_EC_GROUP_SECP384R1
+};
+
 /* EdDSA 25519 elliptic curve test params */
 struct
 cperf_eddsa_test_data ed25519_perf_data = {
diff --git a/app/test-crypto-perf/cperf_test_vectors.h b/app/test-crypto-perf/cperf_test_vectors.h
index b5e300dc1b..5f2f6ab8af 100644
--- a/app/test-crypto-perf/cperf_test_vectors.h
+++ b/app/test-crypto-perf/cperf_test_vectors.h
@@ -178,6 +178,7 @@ extern uint8_t digest[2048];
 
 extern struct cperf_modex_test_data modex_perf_data[10];
 extern struct cperf_ecdsa_test_data secp256r1_perf_data;
+extern struct cperf_ecdsa_test_data secp384r1_perf_data;
 extern struct cperf_eddsa_test_data ed25519_perf_data;
 extern struct cperf_sm2_test_data sm2_perf_data;
 extern struct cperf_rsa_test_data rsa_pub_perf_data[4];
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 2e38c0011d..4f98e0172a 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -47,6 +47,7 @@ const char *cperf_op_type_strs[] = {
 	[CPERF_ASYM_MODEX] = "modex",
 	[CPERF_ASYM_RSA] = "rsa",
 	[CPERF_ASYM_SECP256R1] = "ecdsa_p256r1",
+	[CPERF_ASYM_SECP384R1] = "ecdsa_p384r1",
 	[CPERF_ASYM_ED25519] = "eddsa_25519",
 	[CPERF_ASYM_SM2] = "sm2",
 	[CPERF_TLS] = "tls-record"
@@ -234,6 +235,7 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 
 		switch (opts->op_type) {
 		case CPERF_ASYM_SECP256R1:
+		case CPERF_ASYM_SECP384R1:
 		case CPERF_ASYM_ED25519:
 		case CPERF_ASYM_SM2:
 		case CPERF_ASYM_RSA:
@@ -391,7 +393,8 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 
 		}
 
-		if (opts->op_type == CPERF_ASYM_SECP256R1) {
+		if ((opts->op_type == CPERF_ASYM_SECP256R1) ||
+			(opts->op_type == CPERF_ASYM_SECP384R1)) {
 			asym_cap_idx.type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
 			asym_capability = rte_cryptodev_asym_capability_get(cdev_id, &asym_cap_idx);
 			if (asym_capability == NULL)
@@ -402,8 +405,13 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 				return -1;
 
 			if (asym_capability->internal_rng != 0) {
-				opts->secp256r1_data->k.data = NULL;
-				opts->secp256r1_data->k.length = 0;
+				if (opts->op_type == CPERF_ASYM_SECP256R1) {
+					opts->secp256r1_data->k.data = NULL;
+					opts->secp256r1_data->k.length = 0;
+				} else {
+					opts->secp384r1_data->k.data = NULL;
+					opts->secp384r1_data->k.length = 0;
+				}
 			}
 		}
 
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index 4bb607645b..5b1c19619e 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -176,6 +176,7 @@ The following are the application command-line options:
            docsis
            modex
            ecdsa_p256r1
+           ecdsa_p384r1
            eddsa_25519
            rsa
            sm2
-- 
2.48.1

