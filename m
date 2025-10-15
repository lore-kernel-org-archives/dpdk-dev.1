Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A9CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 06:28:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E156402CC;
	Wed, 15 Oct 2025 08:28:25 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 248E2402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 08:28:24 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EMmF5c003698
 for <dev@dpdk.org>; Tue, 14 Oct 2025 23:28:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=b
 8TMG6+LLUfurPga2scKevxEcuuorlCwtUJSZddWqRY=; b=b7I5whN7zJV4SqotI
 IouiAusutY0bDgvjvc5GcDyDNrnMWDbiqHKl3dEo44Y4GYeWZIOiyW0QjicYbnl+
 NaK1h3gEZmIh3MEo9Ho8NC50UV6kGkaWGcASnI9wepzqk4HLxO44Khxv6bj3V/HS
 mXRcgcjK6no34RBjmOSYN2wD4yO+GZ0Ioyrv/jnKWVp4PhatWmucoClLXhch9jZ/
 7p8kBNSU8SCglsN3jx4ZAcWJ7yfEQUvho+f8ZWhIdYZiiOX+I49zvLvWlHvF+ezA
 A9aWou5V79tNq/JLMPsH3u+06bvmCptUHjZ4OJmE5oph+tLMEoNVCyK5cdy0kEZf
 hbevg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49ry22ne5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 14 Oct 2025 23:28:23 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Oct 2025 23:28:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Oct 2025 23:28:32 -0700
Received: from hyd11149.caveonetworks.com (unknown [10.29.44.105])
 by maili.marvell.com (Postfix) with ESMTP id 8BC4D5B6949;
 Tue, 14 Oct 2025 23:28:20 -0700 (PDT)
From: Rupesh Chiluka <rchiluka@marvell.com>
To: <dev@dpdk.org>
CC: Rupesh Chiluka <rchiluka@marvell.com>
Subject: [PATCH] app/crypto-perf: add ECDSA P192/P224/P521 support
Date: Wed, 15 Oct 2025 11:57:58 +0530
Message-ID: <20251015062758.1096015-1-rchiluka@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008054059.3934959-1-rchiluka@marvell.com>
References: <20251008054059.3934959-1-rchiluka@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA0NiBTYWx0ZWRfX+Yoh/h99L9pm
 WdkHr3XBIFqVu80j/snwozUMPjnhGYB7dbCaetNR+Mvap6WS5SlrJ2JEaCIkTH6z9adSYiPQoUc
 K7tnpg9jVyA1RDok2zm+y3ihe4PxhzVGUS9CyfOf4U3UbedDlmp8lgUg+zh9T/tDYzrPLrKYIYT
 N9DXp+vKckY0Qj7Bc3YC0rhunTyfYzAgXQJyBNsX1ne/ylAFh2Od/crDbNlFJm69jZuADSMgvp9
 idQbrBEFbVBNaOx5qaft80Lc1boz5xKGkSYD6qUlJtNy+saCYUNe9VOGgws1Hgs1y5z+4dpTGNi
 OId3WNxkB+KohqHiL0H8yeOl4BgXHFyQWK9If1YW0ck+3Ns+NIzgjWMDqo/hgXpKd4dddv+Nc+T
 dvsUAZ+bxB6cUI0qHbNwoG7SodoIhA==
X-Proofpoint-GUID: tbrYpXBgW_1y_LxPlKFVkeLYSglzhBVx
X-Proofpoint-ORIG-GUID: tbrYpXBgW_1y_LxPlKFVkeLYSglzhBVx
X-Authority-Analysis: v=2.4 cv=NLHYOk6g c=1 sm=1 tr=0 ts=68ef3f07 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=2GoupwNzwNddJfAKPi8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_02,2025-10-13_01,2025-03-28_01
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

Add support for ECDSA SECP192R1, SECP224R1, SECP521R1 curve SIGN and
VERIFY operations

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 app/test-crypto-perf/cperf_ops.c             | 115 ++++----
 app/test-crypto-perf/cperf_options.h         |   6 +
 app/test-crypto-perf/cperf_options_parsing.c |  32 ++-
 app/test-crypto-perf/cperf_test_common.c     |   3 +
 app/test-crypto-perf/cperf_test_vectors.c    | 273 +++++++++++++++++++
 app/test-crypto-perf/cperf_test_vectors.h    |   3 +
 app/test-crypto-perf/main.c                  |  46 +++-
 doc/guides/tools/cryptoperf.rst              |   3 +
 8 files changed, 420 insertions(+), 61 deletions(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index b04c523542..9297b4a3d3 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -95,36 +95,46 @@ cperf_set_ops_asym_ecdsa(struct rte_crypto_op **ops,
 	uint16_t i;
 
 	for (i = 0; i < nb_ops; i++) {
+		const struct cperf_ecdsa_test_data *ecdsa_curve_data = NULL;
 		struct rte_crypto_asym_op *asym_op = ops[i]->asym;
 
 		ops[i]->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
 		rte_crypto_op_attach_asym_session(ops[i], sess);
 
 		asym_op->ecdsa.op_type = options->asym_op_type;
-		if (options->op_type == CPERF_ASYM_SECP256R1) {
-			asym_op->ecdsa.message.data = options->secp256r1_data->message.data;
-			asym_op->ecdsa.message.length = options->secp256r1_data->message.length;
-
-			asym_op->ecdsa.k.data = options->secp256r1_data->k.data;
-			asym_op->ecdsa.k.length = options->secp256r1_data->k.length;
-
-			asym_op->ecdsa.r.data = options->secp256r1_data->sign_r.data;
-			asym_op->ecdsa.r.length = options->secp256r1_data->sign_r.length;
-			asym_op->ecdsa.s.data = options->secp256r1_data->sign_s.data;
-			asym_op->ecdsa.s.length = options->secp256r1_data->sign_s.length;
-		} else if (options->op_type == CPERF_ASYM_SECP384R1) {
-			asym_op->ecdsa.message.data = options->secp384r1_data->message.data;
-			asym_op->ecdsa.message.length = options->secp384r1_data->message.length;
-
-			asym_op->ecdsa.k.data = options->secp384r1_data->k.data;
-			asym_op->ecdsa.k.length = options->secp384r1_data->k.length;
-
-			asym_op->ecdsa.r.data = options->secp384r1_data->sign_r.data;
-			asym_op->ecdsa.r.length = options->secp384r1_data->sign_r.length;
-			asym_op->ecdsa.s.data = options->secp384r1_data->sign_s.data;
-			asym_op->ecdsa.s.length = options->secp384r1_data->sign_s.length;
+
+		switch (options->op_type) {
+		case CPERF_ASYM_SECP192R1:
+			ecdsa_curve_data = options->secp192r1_data;
+			break;
+		case CPERF_ASYM_SECP224R1:
+			ecdsa_curve_data = options->secp224r1_data;
+			break;
+		case CPERF_ASYM_SECP256R1:
+			ecdsa_curve_data = options->secp256r1_data;
+			break;
+		case CPERF_ASYM_SECP384R1:
+			ecdsa_curve_data = options->secp384r1_data;
+			break;
+		case CPERF_ASYM_SECP521R1:
+			ecdsa_curve_data = options->secp521r1_data;
+			break;
+		default:
+			rte_panic("Unsupported ECDSA operation type %d\n",
+				  options->op_type);
+			break;
 		}
 
+		asym_op->ecdsa.message.data = ecdsa_curve_data->message.data;
+		asym_op->ecdsa.message.length = ecdsa_curve_data->message.length;
+
+		asym_op->ecdsa.k.data = ecdsa_curve_data->k.data;
+		asym_op->ecdsa.k.length = ecdsa_curve_data->k.length;
+
+		asym_op->ecdsa.r.data = ecdsa_curve_data->sign_r.data;
+		asym_op->ecdsa.r.length = ecdsa_curve_data->sign_r.length;
+		asym_op->ecdsa.s.data = ecdsa_curve_data->sign_s.data;
+		asym_op->ecdsa.s.length = ecdsa_curve_data->sign_s.length;
 	}
 }
 
@@ -1078,6 +1088,7 @@ cperf_create_session(struct rte_mempool *sess_mp,
 	const struct cperf_test_vector *test_vector,
 	uint16_t iv_offset)
 {
+	const struct cperf_ecdsa_test_data *ecdsa_curve_data = NULL;
 	struct rte_crypto_sym_xform cipher_xform;
 	struct rte_crypto_sym_xform auth_xform;
 	struct rte_crypto_sym_xform aead_xform;
@@ -1135,42 +1146,41 @@ cperf_create_session(struct rte_mempool *sess_mp,
 		return asym_sess;
 	}
 
-	if (options->op_type == CPERF_ASYM_SECP256R1) {
-		xform.next = NULL;
-		xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
-		xform.ec.curve_id = options->secp256r1_data->curve;
-		xform.ec.pkey.data = options->secp256r1_data->pkey.data;
-		xform.ec.pkey.length = options->secp256r1_data->pkey.length;
-		xform.ec.q.x.data = options->secp256r1_data->pubkey_qx.data;
-		xform.ec.q.x.length = options->secp256r1_data->pubkey_qx.length;
-		xform.ec.q.y.data = options->secp256r1_data->pubkey_qy.data;
-		xform.ec.q.y.length = options->secp256r1_data->pubkey_qy.length;
-
-		ret = rte_cryptodev_asym_session_create(dev_id, &xform,
-				sess_mp, &asym_sess);
-		if (ret < 0) {
-			RTE_LOG(ERR, USER1, "ECDSA P256 Asym session create failed\n");
-			return NULL;
-		}
-
-		return asym_sess;
+	switch (options->op_type) {
+	case CPERF_ASYM_SECP192R1:
+		ecdsa_curve_data = options->secp192r1_data;
+		break;
+	case CPERF_ASYM_SECP224R1:
+		ecdsa_curve_data = options->secp224r1_data;
+		break;
+	case CPERF_ASYM_SECP256R1:
+		ecdsa_curve_data = options->secp256r1_data;
+		break;
+	case CPERF_ASYM_SECP384R1:
+		ecdsa_curve_data = options->secp384r1_data;
+		break;
+	case CPERF_ASYM_SECP521R1:
+		ecdsa_curve_data = options->secp521r1_data;
+		break;
+	default:
+		break;
 	}
 
-	if (options->op_type == CPERF_ASYM_SECP384R1) {
+	if (ecdsa_curve_data) {
 		xform.next = NULL;
 		xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
-		xform.ec.curve_id = options->secp384r1_data->curve;
-		xform.ec.pkey.data = options->secp384r1_data->pkey.data;
-		xform.ec.pkey.length = options->secp384r1_data->pkey.length;
-		xform.ec.q.x.data = options->secp384r1_data->pubkey_qx.data;
-		xform.ec.q.x.length = options->secp384r1_data->pubkey_qx.length;
-		xform.ec.q.y.data = options->secp384r1_data->pubkey_qy.data;
-		xform.ec.q.y.length = options->secp384r1_data->pubkey_qy.length;
+		xform.ec.curve_id = ecdsa_curve_data->curve;
+		xform.ec.pkey.data = ecdsa_curve_data->pkey.data;
+		xform.ec.pkey.length = ecdsa_curve_data->pkey.length;
+		xform.ec.q.x.data = ecdsa_curve_data->pubkey_qx.data;
+		xform.ec.q.x.length = ecdsa_curve_data->pubkey_qx.length;
+		xform.ec.q.y.data = ecdsa_curve_data->pubkey_qy.data;
+		xform.ec.q.y.length = ecdsa_curve_data->pubkey_qy.length;
 
 		ret = rte_cryptodev_asym_session_create(dev_id, &xform,
 				sess_mp, &asym_sess);
 		if (ret < 0) {
-			RTE_LOG(ERR, USER1, "ECDSA P384 Asym session create failed\n");
+			RTE_LOG(ERR, USER1, "ECDSA Asym session create failed\n");
 			return NULL;
 		}
 
@@ -1519,10 +1529,11 @@ cperf_get_op_functions(const struct cperf_options *options,
 	case CPERF_ASYM_RSA:
 		op_fns->populate_ops = cperf_set_ops_asym_rsa;
 		break;
+	case CPERF_ASYM_SECP192R1:
+	case CPERF_ASYM_SECP224R1:
 	case CPERF_ASYM_SECP256R1:
-		op_fns->populate_ops = cperf_set_ops_asym_ecdsa;
-		break;
 	case CPERF_ASYM_SECP384R1:
+	case CPERF_ASYM_SECP521R1:
 		op_fns->populate_ops = cperf_set_ops_asym_ecdsa;
 		break;
 	case CPERF_ASYM_ED25519:
diff --git a/app/test-crypto-perf/cperf_options.h b/app/test-crypto-perf/cperf_options.h
index 38621e28a0..428e8cb4f1 100644
--- a/app/test-crypto-perf/cperf_options.h
+++ b/app/test-crypto-perf/cperf_options.h
@@ -94,8 +94,11 @@ enum cperf_op_type {
 	CPERF_IPSEC,
 	CPERF_ASYM_MODEX,
 	CPERF_ASYM_RSA,
+	CPERF_ASYM_SECP192R1,
+	CPERF_ASYM_SECP224R1,
 	CPERF_ASYM_SECP256R1,
 	CPERF_ASYM_SECP384R1,
+	CPERF_ASYM_SECP521R1,
 	CPERF_ASYM_ED25519,
 	CPERF_ASYM_SM2,
 	CPERF_TLS,
@@ -177,8 +180,11 @@ struct cperf_options {
 	uint8_t imix_distribution_count;
 	struct cperf_modex_test_data *modex_data;
 	uint16_t modex_len;
+	struct cperf_ecdsa_test_data *secp192r1_data;
+	struct cperf_ecdsa_test_data *secp224r1_data;
 	struct cperf_ecdsa_test_data *secp256r1_data;
 	struct cperf_ecdsa_test_data *secp384r1_data;
+	struct cperf_ecdsa_test_data *secp521r1_data;
 	struct cperf_eddsa_test_data *eddsa_data;
 	struct cperf_sm2_test_data *sm2_data;
 	enum rte_crypto_asym_op_type asym_op_type;
diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index d13a7ab297..14e731586b 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -39,7 +39,9 @@ usage(char *progname)
 		" --devtype TYPE: set crypto device type to use\n"
 		" --low-prio-qp-mask mask: set low priority for queues set in mask(hex)\n"
 		" --optype cipher-only / auth-only / cipher-then-auth / auth-then-cipher /\n"
-		"        aead / pdcp / docsis / ipsec / modex / rsa / secp256r1 / secp384r1 / eddsa / sm2 / tls-record : set operation type\n"
+		"        aead / pdcp / docsis / ipsec / modex / rsa / secp192r1 /\n"
+		"        secp224r1 / secp256r1 / secp384r1 / secp521r1 / eddsa / sm2 /\n"
+		"        tls-record : set operation type\n"
 		" --sessionless: enable session-less crypto operations\n"
 		" --shared-session: share 1 session across all queue pairs on crypto device\n"
 		" --out-of-place: enable out-of-place crypto operations\n"
@@ -529,6 +531,14 @@ parse_op_type(struct cperf_options *opts, const char *arg)
 			cperf_op_type_strs[CPERF_ASYM_RSA],
 			CPERF_ASYM_RSA
 		},
+		{
+			cperf_op_type_strs[CPERF_ASYM_SECP192R1],
+			CPERF_ASYM_SECP192R1
+		},
+		{
+			cperf_op_type_strs[CPERF_ASYM_SECP224R1],
+			CPERF_ASYM_SECP224R1
+		},
 		{
 			cperf_op_type_strs[CPERF_ASYM_SECP256R1],
 			CPERF_ASYM_SECP256R1
@@ -537,6 +547,10 @@ parse_op_type(struct cperf_options *opts, const char *arg)
 			cperf_op_type_strs[CPERF_ASYM_SECP384R1],
 			CPERF_ASYM_SECP384R1
 		},
+		{
+			cperf_op_type_strs[CPERF_ASYM_SECP521R1],
+			CPERF_ASYM_SECP521R1
+		},
 		{
 			cperf_op_type_strs[CPERF_ASYM_ED25519],
 			CPERF_ASYM_ED25519
@@ -1153,8 +1167,11 @@ cperf_options_default(struct cperf_options *opts)
 	opts->rsa_data = &rsa_pub_perf_data[0];
 	opts->rsa_keytype = UINT8_MAX;
 
+	opts->secp192r1_data = &secp192r1_perf_data;
+	opts->secp224r1_data = &secp224r1_perf_data;
 	opts->secp256r1_data = &secp256r1_perf_data;
 	opts->secp384r1_data = &secp384r1_perf_data;
+	opts->secp521r1_data = &secp521r1_perf_data;
 	opts->eddsa_data = &ed25519_perf_data;
 	opts->sm2_data = &sm2_perf_data;
 	opts->asym_op_type = RTE_CRYPTO_ASYM_OP_ENCRYPT;
@@ -1639,6 +1656,19 @@ cperf_options_check(struct cperf_options *options)
 		}
 	}
 
+	if (options->op_type == CPERF_ASYM_SECP192R1 ||
+		options->op_type == CPERF_ASYM_SECP224R1 ||
+		options->op_type == CPERF_ASYM_SECP256R1 ||
+		options->op_type == CPERF_ASYM_SECP384R1 ||
+		options->op_type == CPERF_ASYM_SECP521R1) {
+
+		if (options->asym_op_type != RTE_CRYPTO_ASYM_OP_SIGN &&
+			options->asym_op_type != RTE_CRYPTO_ASYM_OP_VERIFY) {
+			RTE_LOG(ERR, USER1, "ECDSA operations only support sign and verify\n");
+			return -EINVAL;
+		}
+	}
+
 #ifdef RTE_LIB_SECURITY
 	if (options->op_type == CPERF_DOCSIS) {
 		if (check_docsis_buffer_length(options) < 0)
diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index da0202a870..caf429b4d9 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -307,8 +307,11 @@ cperf_is_asym_test(const struct cperf_options *options)
 {
 	if (options->op_type == CPERF_ASYM_MODEX ||
 	    options->op_type == CPERF_ASYM_RSA ||
+	    options->op_type == CPERF_ASYM_SECP192R1 ||
+	    options->op_type == CPERF_ASYM_SECP224R1 ||
 	    options->op_type == CPERF_ASYM_SECP256R1 ||
 	    options->op_type == CPERF_ASYM_SECP384R1 ||
+	    options->op_type == CPERF_ASYM_SECP521R1 ||
 	    options->op_type == CPERF_ASYM_ED25519 ||
 	    options->op_type == CPERF_ASYM_SM2)
 		return true;
diff --git a/app/test-crypto-perf/cperf_test_vectors.c b/app/test-crypto-perf/cperf_test_vectors.c
index f1dedcd119..f4f856ff69 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -804,6 +804,98 @@ cperf_modex_test_data modex_perf_data[10] = {
 	}
 };
 
+static uint8_t secp192r1_pkey[] = {
+	0x24, 0xed, 0xd2, 0x2f, 0x7d, 0xdd, 0x6f, 0xa5,
+	0xbc, 0x61, 0xfc, 0x06, 0x53, 0x47, 0x9a, 0xa4,
+	0x08, 0x09, 0xef, 0x86, 0x5c, 0xf2, 0x7a, 0x47
+};
+
+static uint8_t secp192r1_qx[] = {
+	0x9b, 0xf1, 0x2d, 0x71, 0x74, 0xb7, 0x70, 0x8a,
+	0x07, 0x6a, 0x38, 0xbc, 0x80, 0xaa, 0x28, 0x66,
+	0x2f, 0x25, 0x1e, 0x2e, 0xd8, 0xd4, 0x14, 0xdc
+};
+
+static uint8_t secp192r1_qy[] = {
+	0x48, 0x54, 0xc8, 0xd0, 0x7d, 0xfc, 0x08, 0x82,
+	0x4e, 0x9e, 0x47, 0x1c, 0xa2, 0xfe, 0xdc, 0xfc,
+	0xff, 0x3d, 0xdc, 0xb0, 0x11, 0x57, 0x34, 0x98
+};
+
+static uint8_t secp192r1_k[] = {
+	0xa5, 0xc8, 0x17, 0xa2, 0x36, 0xa5, 0xf7, 0xfa,
+	0xa3, 0x29, 0xb8, 0xec, 0xc3, 0xc5, 0x96, 0x68,
+	0x7c, 0x71, 0xaa, 0xaf, 0x86, 0xc7, 0x70, 0x3e
+};
+
+static uint8_t secp192r1_sign_r[] = {
+	0x35, 0x4a, 0xba, 0xec, 0xf4, 0x36, 0x1f, 0xea,
+	0x90, 0xc2, 0x9b, 0x91, 0x99, 0x88, 0x2e, 0xdf,
+	0x85, 0x73, 0xe6, 0x86, 0xa8, 0x13, 0xef, 0xf8
+};
+
+static uint8_t secp192r1_sign_s[] = {
+	0x80, 0xf5, 0x00, 0x00, 0xac, 0x86, 0x11, 0x1c,
+	0x9b, 0x30, 0x47, 0x38, 0x5a, 0x15, 0xd7, 0x8e,
+	0x63, 0x2c, 0x58, 0xb7, 0x94, 0x9e, 0x82, 0xc1
+};
+
+static uint8_t secp192r1_message[] = {
+	0x5a, 0xe8, 0x31, 0x7d, 0x34, 0xd1, 0xe5, 0x95,
+	0xe3, 0xfa, 0x72, 0x47, 0xdb, 0x80, 0xc0, 0xaf,
+	0x43, 0x20, 0xcc, 0xe1, 0x11, 0x6d, 0xe1, 0x87,
+	0xf8, 0xf7, 0xe2, 0xe0, 0x99, 0xc0, 0xd8, 0xd0
+};
+
+static uint8_t secp224r1_pkey[] = {
+	0x88, 0x8f, 0xc9, 0x92, 0x89, 0x3b, 0xdd, 0x8a,
+	0xa0, 0x2c, 0x80, 0x76, 0x88, 0x32, 0x60, 0x5d,
+	0x02, 0x0b, 0x81, 0xae, 0x0b, 0x25, 0x47, 0x41,
+	0x54, 0xec, 0x89, 0xaa
+};
+
+static uint8_t secp224r1_qx[] = {
+	0x4c, 0x74, 0x1e, 0x4d, 0x20, 0x10, 0x36, 0x70,
+	0xb7, 0x16, 0x1a, 0xe7, 0x22, 0x71, 0x08, 0x21,
+	0x55, 0x83, 0x84, 0x18, 0x08, 0x43, 0x35, 0x33,
+	0x8a, 0xc3, 0x8f, 0xa4
+};
+
+static uint8_t secp224r1_qy[] = {
+	0xdb, 0x79, 0x19, 0x15, 0x1a, 0xc2, 0x85, 0x87,
+	0xb7, 0x2b, 0xad, 0x7a, 0xb1, 0x80, 0xec, 0x8e,
+	0x95, 0xab, 0x9e, 0x2c, 0x8d, 0x81, 0xd9, 0xb9,
+	0xd7, 0xe2, 0xe3, 0x83
+};
+
+static uint8_t secp224r1_k[] = {
+	0x06, 0xf7, 0xa5, 0x60, 0x07, 0x82, 0x54, 0x33,
+	0xc4, 0xc6, 0x11, 0x53, 0xdf, 0x1a, 0x13, 0x5e,
+	0xee, 0x2f, 0x38, 0xec, 0x68, 0x7b, 0x49, 0x2e,
+	0xd4, 0x0d, 0x9c, 0x90
+};
+
+static uint8_t secp224r1_sign_r[] = {
+	0x09, 0x09, 0xc9, 0xb9, 0xca, 0xe8, 0xd2, 0x79,
+	0x0e, 0x29, 0xdb, 0x6a, 0xfd, 0xb4, 0x5c, 0x04,
+	0xf5, 0xb0, 0x72, 0xc4, 0xc2, 0x04, 0x10, 0xc7,
+	0xdc, 0x9b, 0x67, 0x72
+};
+
+static uint8_t secp224r1_sign_s[] = {
+	0x29, 0x8f, 0x4f, 0xca, 0xe1, 0xfe, 0x27, 0x1d,
+	0xa1, 0xe0, 0x34, 0x5d, 0x11, 0xd0, 0x7a, 0x1f,
+	0xca, 0x43, 0xf5, 0x8a, 0xf4, 0xc1, 0x13, 0xb9,
+	0x09, 0xee, 0xde, 0xa0
+};
+
+static uint8_t secp224r1_message[] = {
+	0x00, 0xc6, 0xfc, 0x53, 0xc1, 0x98, 0x6d, 0x19,
+	0xa8, 0xa8, 0xb5, 0x80, 0xee, 0x55, 0x3d, 0xc1,
+	0x24, 0x07, 0x45, 0xd7, 0x60, 0x64, 0x7d, 0x1c,
+	0x0a, 0xdf, 0x44, 0x2c, 0x13, 0x3c, 0x7f, 0x56
+};
+
 static uint8_t secp256r1_pkey[] = {
 	0x51, 0x9b, 0x42, 0x3d, 0x71, 0x5f, 0x8b, 0x58,
 	0x1f, 0x4f, 0xa8, 0xee, 0x59, 0xf4, 0x77, 0x1a,
@@ -914,6 +1006,85 @@ static uint8_t secp384r1_message[] = {
 	0x3e, 0x18, 0xcd, 0x01, 0x7d, 0x7f, 0x3e, 0xd1
 };
 
+static uint8_t secp521r1_pkey[] = {
+	0x01, 0xe8, 0xc0, 0x59, 0x96, 0xb8, 0x5e, 0x6f,
+	0x3f, 0x87, 0x57, 0x12, 0xa0, 0x9c, 0x1b, 0x40,
+	0x67, 0x2b, 0x5e, 0x7a, 0x78, 0xd5, 0x85, 0x2d,
+	0xe0, 0x15, 0x85, 0xc5, 0xfb, 0x99, 0x0b, 0xf3,
+	0x81, 0x2c, 0x32, 0x45, 0x53, 0x4a, 0x71, 0x43,
+	0x89, 0xae, 0x90, 0x14, 0xd6, 0x77, 0xa4, 0x49,
+	0xef, 0xd6, 0x58, 0x25, 0x4e, 0x61, 0x0d, 0xa8,
+	0xe6, 0xca, 0xd3, 0x34, 0x14, 0xb9, 0xd3, 0x3e,
+	0x0d, 0x7a
+};
+
+static uint8_t secp521r1_qx[] = {
+	0x00, 0x7d, 0x04, 0x2c, 0xa1, 0x94, 0x08, 0x52,
+	0x4e, 0x68, 0xb9, 0x81, 0xf1, 0x41, 0x93, 0x51,
+	0xe3, 0xb8, 0x47, 0x36, 0xc7, 0x7f, 0xe5, 0x8f,
+	0xee, 0x7d, 0x11, 0x31, 0x7d, 0xf2, 0xe8, 0x50,
+	0xd9, 0x60, 0xc7, 0xdd, 0x10, 0xd1, 0x0b, 0xa7,
+	0x14, 0xc8, 0xa6, 0x09, 0xd1, 0x63, 0x50, 0x2b,
+	0x79, 0xd6, 0x82, 0xe8, 0xbb, 0xec, 0xd4, 0xf5,
+	0x25, 0x91, 0xd2, 0x74, 0x85, 0x33, 0xe4, 0x5a,
+	0x86, 0x7a
+};
+
+static uint8_t secp521r1_qy[] = {
+	0x01, 0x97, 0xac, 0x64, 0x16, 0x11, 0x1c, 0xcf,
+	0x98, 0x7d, 0x29, 0x04, 0x59, 0xeb, 0xc8, 0xad,
+	0x9e, 0xc5, 0x6e, 0x49, 0x05, 0x9c, 0x99, 0x21,
+	0x55, 0x53, 0x9a, 0x36, 0xa6, 0x26, 0x63, 0x1f,
+	0x4a, 0x2d, 0x89, 0x16, 0x4b, 0x98, 0x51, 0x54,
+	0xf2, 0xdd, 0xdc, 0x02, 0x81, 0xee, 0x5b, 0x51,
+	0x78, 0x27, 0x1f, 0x3a, 0x76, 0xa0, 0x91, 0x4c,
+	0x3f, 0xcd, 0x1f, 0x97, 0xbe, 0x8e, 0x83, 0x76,
+	0xef, 0xb3
+};
+
+static uint8_t secp521r1_k[] = {
+	0x00, 0xdc, 0x8d, 0xaa, 0xac, 0xdd, 0xb8, 0xfd,
+	0x2f, 0xf5, 0xc3, 0x4a, 0x5c, 0xe1, 0x83, 0xa4,
+	0x22, 0x61, 0xad, 0x3c, 0x64, 0xdb, 0xfc, 0x09,
+	0x5e, 0x58, 0x92, 0x43, 0x64, 0xdc, 0x47, 0xea,
+	0x1c, 0x05, 0xe2, 0x59, 0x9a, 0xae, 0x91, 0x7c,
+	0x2c, 0x95, 0xf4, 0x7d, 0x6b, 0xb3, 0x7d, 0xa0,
+	0x08, 0xaf, 0x9f, 0x55, 0x73, 0x0d, 0xdb, 0xe4,
+	0xd8, 0xde, 0xd2, 0x4f, 0x9e, 0x8d, 0xaa, 0x46,
+	0xdb, 0x6a
+};
+
+static uint8_t secp521r1_sign_r[] = {
+	0x00, 0x9d, 0xd1, 0xf2, 0xa7, 0x16, 0x84, 0x3e,
+	0xed, 0xec, 0x7a, 0x66, 0x45, 0xac, 0x83, 0x4d,
+	0x43, 0x36, 0xe7, 0xb1, 0x8e, 0x35, 0x70, 0x1f,
+	0x06, 0xca, 0xe9, 0xd6, 0xb2, 0x90, 0xd4, 0x14,
+	0x91, 0x42, 0x47, 0x35, 0xf3, 0xb5, 0x7e, 0x82,
+	0x9a, 0xd5, 0xde, 0x05, 0x5e, 0xae, 0xef, 0x17,
+	0x78, 0xf0, 0x51, 0xc1, 0xee, 0x15, 0x2b, 0xf2,
+	0x13, 0x1a, 0x08, 0x1e, 0x53, 0xdf, 0x2a, 0x56,
+	0x7a, 0x8a
+};
+
+static uint8_t secp521r1_sign_s[] = {
+	0x00, 0x21, 0x48, 0xe8, 0x42, 0x8d, 0x70, 0xa7,
+	0x2b, 0xc9, 0xfa, 0x98, 0x6c, 0x38, 0xc2, 0xc9,
+	0x7d, 0xed, 0xa0, 0x42, 0x0f, 0x22, 0x2f, 0x9d,
+	0xc9, 0x9d, 0x32, 0xc0, 0xac, 0xba, 0x69, 0x9d,
+	0xc7, 0xba, 0x0a, 0x2b, 0x79, 0xce, 0x59, 0x99,
+	0xff, 0x61, 0xbd, 0x0b, 0x23, 0x3c, 0x74, 0x4a,
+	0x89, 0x3b, 0xc1, 0x05, 0xbc, 0xa5, 0xc2, 0x35,
+	0x42, 0x3e, 0x53, 0x16, 0x12, 0xda, 0x65, 0xd7,
+	0x2e, 0x62
+};
+
+static uint8_t secp521r1_message[] = {
+	0x53, 0xe6, 0x53, 0x7c, 0xb6, 0xea, 0x68, 0xae,
+	0x47, 0xa8, 0x16, 0x11, 0xc2, 0x27, 0x56, 0xd7,
+	0x70, 0xd7, 0xa3, 0x7e, 0x33, 0x6c, 0x3a, 0xf0,
+	0xb0, 0x81, 0x4b, 0x04, 0xfa, 0x39, 0x43, 0x4b
+};
+
 static uint8_t ed25519_pkey[] = {
 	0x4c, 0xcd, 0x08, 0x9b, 0x28, 0xff, 0x96, 0xda,
 	0x9d, 0xb6, 0xc3, 0x46, 0xec, 0x11, 0x4e, 0x0f,
@@ -1421,6 +1592,74 @@ uint8_t ipsec_plaintext[2048] = {
 		0x75, 0x67, 0x00, 0x01
 };
 
+/** ECDSA secp192r1 elliptic curve test params */
+struct
+cperf_ecdsa_test_data secp192r1_perf_data = {
+	.pubkey_qx = {
+		.data = secp192r1_qx,
+		.length = sizeof(secp192r1_qx),
+	},
+	.pubkey_qy = {
+		.data = secp192r1_qy,
+		.length = sizeof(secp192r1_qy),
+	},
+	.k = {
+		.data = secp192r1_k,
+		.length = sizeof(secp192r1_k),
+	},
+	.sign_r = {
+		.data = secp192r1_sign_r,
+		.length = sizeof(secp192r1_sign_r),
+	},
+	.sign_s = {
+		.data = secp192r1_sign_s,
+		.length = sizeof(secp192r1_sign_s),
+	},
+	.pkey = {
+		.data = secp192r1_pkey,
+		.length = sizeof(secp192r1_pkey),
+	},
+	.message = {
+		.data = secp192r1_message,
+		.length = sizeof(secp192r1_message),
+	},
+	.curve = RTE_CRYPTO_EC_GROUP_SECP192R1
+};
+
+/** ECDSA secp224r1 elliptic curve test params */
+struct
+cperf_ecdsa_test_data secp224r1_perf_data = {
+	.pubkey_qx = {
+		.data = secp224r1_qx,
+		.length = sizeof(secp224r1_qx),
+	},
+	.pubkey_qy = {
+		.data = secp224r1_qy,
+		.length = sizeof(secp224r1_qy),
+	},
+	.k = {
+		.data = secp224r1_k,
+		.length = sizeof(secp224r1_k),
+	},
+	.sign_r = {
+		.data = secp224r1_sign_r,
+		.length = sizeof(secp224r1_sign_r),
+	},
+	.sign_s = {
+		.data = secp224r1_sign_s,
+		.length = sizeof(secp224r1_sign_s),
+	},
+	.pkey = {
+		.data = secp224r1_pkey,
+		.length = sizeof(secp224r1_pkey),
+	},
+	.message = {
+		.data = secp224r1_message,
+		.length = sizeof(secp224r1_message),
+	},
+	.curve = RTE_CRYPTO_EC_GROUP_SECP224R1
+};
+
 /** ECDSA secp256r1 elliptic curve test params */
 struct
 cperf_ecdsa_test_data secp256r1_perf_data = {
@@ -1489,6 +1728,40 @@ cperf_ecdsa_test_data secp384r1_perf_data = {
 	.curve = RTE_CRYPTO_EC_GROUP_SECP384R1
 };
 
+/** ECDSA secp521r1 elliptic curve test params */
+struct
+cperf_ecdsa_test_data secp521r1_perf_data = {
+	.pubkey_qx = {
+		.data = secp521r1_qx,
+		.length = sizeof(secp521r1_qx),
+	},
+	.pubkey_qy = {
+		.data = secp521r1_qy,
+		.length = sizeof(secp521r1_qy),
+	},
+	.k = {
+		.data = secp521r1_k,
+		.length = sizeof(secp521r1_k),
+	},
+	.sign_r = {
+		.data = secp521r1_sign_r,
+		.length = sizeof(secp521r1_sign_r),
+	},
+	.sign_s = {
+		.data = secp521r1_sign_s,
+		.length = sizeof(secp521r1_sign_s),
+	},
+	.pkey = {
+		.data = secp521r1_pkey,
+		.length = sizeof(secp521r1_pkey),
+	},
+	.message = {
+		.data = secp521r1_message,
+		.length = sizeof(secp521r1_message),
+	},
+	.curve = RTE_CRYPTO_EC_GROUP_SECP521R1
+};
+
 /* EdDSA 25519 elliptic curve test params */
 struct
 cperf_eddsa_test_data ed25519_perf_data = {
diff --git a/app/test-crypto-perf/cperf_test_vectors.h b/app/test-crypto-perf/cperf_test_vectors.h
index 5f2f6ab8af..d6f18268c4 100644
--- a/app/test-crypto-perf/cperf_test_vectors.h
+++ b/app/test-crypto-perf/cperf_test_vectors.h
@@ -177,8 +177,11 @@ extern uint8_t aad[];
 extern uint8_t digest[2048];
 
 extern struct cperf_modex_test_data modex_perf_data[10];
+extern struct cperf_ecdsa_test_data secp192r1_perf_data;
+extern struct cperf_ecdsa_test_data secp224r1_perf_data;
 extern struct cperf_ecdsa_test_data secp256r1_perf_data;
 extern struct cperf_ecdsa_test_data secp384r1_perf_data;
+extern struct cperf_ecdsa_test_data secp521r1_perf_data;
 extern struct cperf_eddsa_test_data ed25519_perf_data;
 extern struct cperf_sm2_test_data sm2_perf_data;
 extern struct cperf_rsa_test_data rsa_pub_perf_data[4];
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 4f98e0172a..f63e892413 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -46,8 +46,11 @@ const char *cperf_op_type_strs[] = {
 	[CPERF_IPSEC] = "ipsec",
 	[CPERF_ASYM_MODEX] = "modex",
 	[CPERF_ASYM_RSA] = "rsa",
+	[CPERF_ASYM_SECP192R1] = "ecdsa_p192r1",
+	[CPERF_ASYM_SECP224R1] = "ecdsa_p224r1",
 	[CPERF_ASYM_SECP256R1] = "ecdsa_p256r1",
 	[CPERF_ASYM_SECP384R1] = "ecdsa_p384r1",
+	[CPERF_ASYM_SECP521R1] = "ecdsa_p521r1",
 	[CPERF_ASYM_ED25519] = "eddsa_25519",
 	[CPERF_ASYM_SM2] = "sm2",
 	[CPERF_TLS] = "tls-record"
@@ -234,8 +237,11 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 		};
 
 		switch (opts->op_type) {
+		case CPERF_ASYM_SECP192R1:
+		case CPERF_ASYM_SECP224R1:
 		case CPERF_ASYM_SECP256R1:
 		case CPERF_ASYM_SECP384R1:
+		case CPERF_ASYM_SECP521R1:
 		case CPERF_ASYM_ED25519:
 		case CPERF_ASYM_SM2:
 		case CPERF_ASYM_RSA:
@@ -350,6 +356,15 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 	return enabled_cdev_count;
 }
 
+static void
+set_ecdsa_key_null(struct cperf_ecdsa_test_data *curve_data)
+{
+	if (curve_data != NULL) {
+		curve_data->k.data = NULL;
+		curve_data->k.length = 0;
+	}
+}
+
 static int
 cperf_verify_devices_capabilities(struct cperf_options *opts,
 		uint8_t *enabled_cdevs, uint8_t nb_cryptodevs)
@@ -393,8 +408,11 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 
 		}
 
-		if ((opts->op_type == CPERF_ASYM_SECP256R1) ||
-			(opts->op_type == CPERF_ASYM_SECP384R1)) {
+		if ((opts->op_type == CPERF_ASYM_SECP192R1) ||
+			(opts->op_type == CPERF_ASYM_SECP224R1) ||
+			(opts->op_type == CPERF_ASYM_SECP256R1) ||
+			(opts->op_type == CPERF_ASYM_SECP384R1) ||
+			(opts->op_type == CPERF_ASYM_SECP521R1)) {
 			asym_cap_idx.type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
 			asym_capability = rte_cryptodev_asym_capability_get(cdev_id, &asym_cap_idx);
 			if (asym_capability == NULL)
@@ -405,12 +423,24 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 				return -1;
 
 			if (asym_capability->internal_rng != 0) {
-				if (opts->op_type == CPERF_ASYM_SECP256R1) {
-					opts->secp256r1_data->k.data = NULL;
-					opts->secp256r1_data->k.length = 0;
-				} else {
-					opts->secp384r1_data->k.data = NULL;
-					opts->secp384r1_data->k.length = 0;
+				switch (opts->op_type) {
+				case CPERF_ASYM_SECP192R1:
+					set_ecdsa_key_null(opts->secp192r1_data);
+					break;
+				case CPERF_ASYM_SECP224R1:
+					set_ecdsa_key_null(opts->secp224r1_data);
+					break;
+				case CPERF_ASYM_SECP256R1:
+					set_ecdsa_key_null(opts->secp256r1_data);
+					break;
+				case CPERF_ASYM_SECP384R1:
+					set_ecdsa_key_null(opts->secp384r1_data);
+					break;
+				case CPERF_ASYM_SECP521R1:
+					set_ecdsa_key_null(opts->secp521r1_data);
+					break;
+				default:
+					break;
 				}
 			}
 		}
diff --git a/doc/guides/tools/cryptoperf.rst b/doc/guides/tools/cryptoperf.rst
index c35f39d948..d7ee468e17 100644
--- a/doc/guides/tools/cryptoperf.rst
+++ b/doc/guides/tools/cryptoperf.rst
@@ -175,8 +175,11 @@ The following are the application command-line options:
            pdcp
            docsis
            modex
+           ecdsa_p192r1
+           ecdsa_p224r1
            ecdsa_p256r1
            ecdsa_p384r1
+           ecdsa_p521r1
            eddsa_25519
            rsa
            sm2
-- 
2.48.1

