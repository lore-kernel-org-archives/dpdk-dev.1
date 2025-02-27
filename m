Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EBCC19F32
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 18:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 555B840B95;
	Thu, 27 Feb 2025 19:20:52 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 63CCF40654
 for <dev@dpdk.org>; Thu, 27 Feb 2025 19:20:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RFeBUs016575;
 Thu, 27 Feb 2025 10:20:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 yOmM7l95MkkdIkAT78m+tp8b5pvgy6IaO0jaENcaMQ=; b=IPxzW/9gKPmLTs8Sn
 Cavhq5FBmoGnsehx5MyarBsMCly9/yp2o8E6t1Yy3Nr2xsmjYrCnhUla5aswdtiA
 038N8kAY7t4RqwZu6cTwps7TFYqLAJ0zm6Yd3pwP89TxgGedvqPT6une32Tap5jJ
 gyHk18OSFpus1cLf154alqiYr9qdWvOKvJvjgCoEVaml2o+/b0g/hTaio18lfix5
 oFO6nLVrZ3HAc22xBrQDt59UWzW10XnCW6b+IDFLrFvMfzg4ydN1hVkIR9dYmoZ1
 3EYTj+9bA53mvharS86eFSPHKaiW1Z1r1l4lhHXh3x/EqsxxldmWtFu0bjq4aIIp
 KwClg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 452tvrrcv4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:20:50 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Feb 2025 10:20:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Feb 2025 10:20:49 -0800
Received: from IN-lckQE5Rwctls.marvell.com (IN-lckQE5Rwctls.marvell.com
 [10.28.163.68])
 by maili.marvell.com (Postfix) with ESMTP id 77DE35B6927;
 Thu, 27 Feb 2025 10:20:47 -0800 (PST)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Brian Dooley <brian.dooley@intel.com>
CC: <anoobj@marvell.com>, Akhil Goyal <gakhil@marvell.com>
Subject: [v2] app/crypto-perf: add RSA support
Date: Thu, 27 Feb 2025 23:50:30 +0530
Message-ID: <e19c3994186ce5e0d4693425ef700290008a2239.1740680261.git.gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <72eb6cf47e9f475913d4e0c50c0983008efaec2a.1740159804.git.gmuthukrishn@marvell.com>
References: <72eb6cf47e9f475913d4e0c50c0983008efaec2a.1740159804.git.gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -1mbXfsu_bzTURR-uFM6aFXdGO5xCCWu
X-Authority-Analysis: v=2.4 cv=COHQXQrD c=1 sm=1 tr=0 ts=67c0ad02 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=T2h4t0Lz3GQA:10 a=M5GUcnROAAAA:8 a=2UipWiX7fkFwnneD3Q0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -1mbXfsu_bzTURR-uFM6aFXdGO5xCCWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
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

From: Akhil Goyal <gakhil@marvell.com>

Add RSA support in crypto-perf application.

Signed-off-by: Akhil Goyal <gakhil@marvell.com>
---
v2:
 - fixed RSA padding type.
---
 app/test-crypto-perf/cperf_ops.c             |  69 ++++++++
 app/test-crypto-perf/cperf_options.h         |   4 +
 app/test-crypto-perf/cperf_options_parsing.c |  38 +++-
 app/test-crypto-perf/cperf_test_common.c     |   1 +
 app/test-crypto-perf/cperf_test_vectors.c    | 175 +++++++++++++++++++
 app/test-crypto-perf/cperf_test_vectors.h    |  23 +++
 app/test-crypto-perf/main.c                  |  19 ++
 7 files changed, 328 insertions(+), 1 deletion(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index 6d5f510220..37d06f1dea 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -34,6 +34,40 @@ cperf_set_ops_asym_modex(struct rte_crypto_op **ops,
 	}
 }
 
+static void
+cperf_set_ops_asym_rsa(struct rte_crypto_op **ops,
+		   uint32_t src_buf_offset __rte_unused,
+		   uint32_t dst_buf_offset __rte_unused, uint16_t nb_ops,
+		   void *sess,
+		   const struct cperf_options *options,
+		   const struct cperf_test_vector *test_vector __rte_unused,
+		   uint16_t iv_offset __rte_unused,
+		   uint32_t *imix_idx __rte_unused,
+		   uint64_t *tsc_start __rte_unused)
+{
+	uint8_t cipher_buf[4096] = {0};
+	uint16_t i;
+
+	for (i = 0; i < nb_ops; i++) {
+		struct rte_crypto_asym_op *asym_op = ops[i]->asym;
+
+		ops[i]->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
+		asym_op->rsa.op_type = options->asym_op_type;
+		asym_op->rsa.message.data = rsa_plaintext.data;
+		asym_op->rsa.message.length = rsa_plaintext.len;
+		if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
+			asym_op->rsa.sign.data = cipher_buf;
+			asym_op->rsa.sign.length = options->rsa_data->n.length;
+		} else if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+			asym_op->rsa.cipher.data = cipher_buf;
+			asym_op->rsa.cipher.length = options->rsa_data->n.length;
+		} else {
+			printf("RSA DECRYPT/VERIFY not supported");
+		}
+		rte_crypto_op_attach_asym_session(ops[i], sess);
+	}
+}
+
 static void
 cperf_set_ops_asym_ecdsa(struct rte_crypto_op **ops,
 		   uint32_t src_buf_offset __rte_unused,
@@ -1040,6 +1074,38 @@ cperf_create_session(struct rte_mempool *sess_mp,
 		return asym_sess;
 	}
 
+	if (options->op_type == CPERF_ASYM_RSA) {
+		xform.next = NULL;
+		xform.xform_type = RTE_CRYPTO_ASYM_XFORM_RSA;
+		xform.rsa.padding.type = options->rsa_data->padding;
+		xform.rsa.n.data = options->rsa_data->n.data;
+		xform.rsa.n.length = options->rsa_data->n.length;
+		xform.rsa.e.data = options->rsa_data->e.data;
+		xform.rsa.e.length = options->rsa_data->e.length;
+		xform.rsa.d.data = options->rsa_data->d.data;
+		xform.rsa.d.length = options->rsa_data->d.length;
+		xform.rsa.key_type = options->rsa_data->key_type;
+		if (xform.rsa.key_type == RTE_RSA_KEY_TYPE_QT) {
+			xform.rsa.qt.p.data = options->rsa_data->p.data;
+			xform.rsa.qt.p.length = options->rsa_data->p.length;
+			xform.rsa.qt.q.data = options->rsa_data->q.data;
+			xform.rsa.qt.q.length = options->rsa_data->q.length;
+			xform.rsa.qt.dP.data = options->rsa_data->dp.data;
+			xform.rsa.qt.dP.length = options->rsa_data->dp.length;
+			xform.rsa.qt.dQ.data = options->rsa_data->dq.data;
+			xform.rsa.qt.dQ.length = options->rsa_data->dq.length;
+			xform.rsa.qt.qInv.data = options->rsa_data->qinv.data;
+			xform.rsa.qt.qInv.length = options->rsa_data->qinv.length;
+		}
+		ret = rte_cryptodev_asym_session_create(dev_id, &xform,
+				sess_mp, &asym_sess);
+		if (ret < 0) {
+			RTE_LOG(ERR, USER1, "Asym session create failed\n");
+			return NULL;
+		}
+		return asym_sess;
+	}
+
 	if (options->op_type == CPERF_ASYM_SECP256R1) {
 		xform.next = NULL;
 		xform.xform_type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
@@ -1400,6 +1466,9 @@ cperf_get_op_functions(const struct cperf_options *options,
 	case CPERF_ASYM_MODEX:
 		op_fns->populate_ops = cperf_set_ops_asym_modex;
 		break;
+	case CPERF_ASYM_RSA:
+		op_fns->populate_ops = cperf_set_ops_asym_rsa;
+		break;
 	case CPERF_ASYM_SECP256R1:
 		op_fns->populate_ops = cperf_set_ops_asym_ecdsa;
 		break;
diff --git a/app/test-crypto-perf/cperf_options.h b/app/test-crypto-perf/cperf_options.h
index bc3fd54479..6237d836b2 100644
--- a/app/test-crypto-perf/cperf_options.h
+++ b/app/test-crypto-perf/cperf_options.h
@@ -13,6 +13,7 @@
 
 #define CPERF_PTEST_TYPE	("ptest")
 #define CPERF_MODEX_LEN		("modex-len")
+#define CPERF_RSA_PRIV_KEYTYPE	("rsa-priv-keytype")
 #define CPERF_SILENT		("silent")
 #define CPERF_ENABLE_SDAP	("enable-sdap")
 
@@ -79,6 +80,7 @@ enum cperf_perf_test_type {
 
 
 extern const char *cperf_test_type_strs[];
+extern const char *cperf_rsa_priv_keytype_strs[];
 
 enum cperf_op_type {
 	CPERF_CIPHER_ONLY = 1,
@@ -90,6 +92,7 @@ enum cperf_op_type {
 	CPERF_DOCSIS,
 	CPERF_IPSEC,
 	CPERF_ASYM_MODEX,
+	CPERF_ASYM_RSA,
 	CPERF_ASYM_SECP256R1,
 	CPERF_ASYM_ED25519,
 	CPERF_ASYM_SM2,
@@ -177,6 +180,7 @@ struct cperf_options {
 	struct cperf_sm2_test_data *sm2_data;
 	enum rte_crypto_asym_op_type asym_op_type;
 	enum rte_crypto_auth_algorithm asym_hash_alg;
+	struct cperf_rsa_test_data *rsa_data;
 };
 
 void
diff --git a/app/test-crypto-perf/cperf_options_parsing.c b/app/test-crypto-perf/cperf_options_parsing.c
index 8abee2d688..af1a2497f0 100644
--- a/app/test-crypto-perf/cperf_options_parsing.c
+++ b/app/test-crypto-perf/cperf_options_parsing.c
@@ -39,7 +39,7 @@ usage(char *progname)
 		" --devtype TYPE: set crypto device type to use\n"
 		" --low-prio-qp-mask mask: set low priority for queues set in mask(hex)\n"
 		" --optype cipher-only / auth-only / cipher-then-auth / auth-then-cipher /\n"
-		"        aead / pdcp / docsis / ipsec / modex / secp256r1 / eddsa / sm2 / tls-record : set operation type\n"
+		"        aead / pdcp / docsis / ipsec / modex / rsa / secp256r1 / eddsa / sm2 / tls-record : set operation type\n"
 		" --sessionless: enable session-less crypto operations\n"
 		" --shared-session: share 1 session across all queue pairs on crypto device\n"
 		" --out-of-place: enable out-of-place crypto operations\n"
@@ -333,6 +333,35 @@ parse_modex_len(struct cperf_options *opts, const char *arg)
 	return ret;
 }
 
+static int
+parse_rsa_priv_keytype(struct cperf_options *opts, const char *arg)
+{
+	struct name_id_map rsa_keytype_namemap[] = {
+		{
+			cperf_rsa_priv_keytype_strs[RTE_RSA_KEY_TYPE_EXP],
+			RTE_RSA_KEY_TYPE_EXP
+		},
+		{
+			cperf_rsa_priv_keytype_strs[RTE_RSA_KEY_TYPE_QT],
+			RTE_RSA_KEY_TYPE_QT
+		},
+	};
+
+	int id = get_str_key_id_mapping(rsa_keytype_namemap,
+			RTE_DIM(rsa_keytype_namemap), arg);
+
+	if (id == RTE_RSA_KEY_TYPE_EXP)
+		opts->rsa_data = &rsa_exp_perf_data;
+	else if (id == RTE_RSA_KEY_TYPE_QT)
+		opts->rsa_data = &rsa_qt_perf_data;
+	else {
+		RTE_LOG(ERR, USER1, "invalid RSA key type specified\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 parse_burst_sz(struct cperf_options *opts, const char *arg)
 {
@@ -486,6 +515,10 @@ parse_op_type(struct cperf_options *opts, const char *arg)
 			cperf_op_type_strs[CPERF_ASYM_MODEX],
 			CPERF_ASYM_MODEX
 		},
+		{
+			cperf_op_type_strs[CPERF_ASYM_RSA],
+			CPERF_ASYM_RSA
+		},
 		{
 			cperf_op_type_strs[CPERF_ASYM_SECP256R1],
 			CPERF_ASYM_SECP256R1
@@ -975,6 +1008,7 @@ static struct option lgopts[] = {
 
 	{ CPERF_PTEST_TYPE, required_argument, 0, 0 },
 	{ CPERF_MODEX_LEN, required_argument, 0, 0 },
+	{ CPERF_RSA_PRIV_KEYTYPE, required_argument, 0, 0 },
 
 	{ CPERF_POOL_SIZE, required_argument, 0, 0 },
 	{ CPERF_TOTAL_OPS, required_argument, 0, 0 },
@@ -1101,6 +1135,7 @@ cperf_options_default(struct cperf_options *opts)
 	opts->docsis_hdr_sz = 17;
 #endif
 	opts->modex_data = (struct cperf_modex_test_data *)&modex_perf_data[0];
+	opts->rsa_data = &rsa_pub_perf_data;
 
 	opts->secp256r1_data = &secp256r1_perf_data;
 	opts->eddsa_data = &ed25519_perf_data;
@@ -1114,6 +1149,7 @@ cperf_opts_parse_long(int opt_idx, struct cperf_options *opts)
 	struct long_opt_parser parsermap[] = {
 		{ CPERF_PTEST_TYPE,	parse_cperf_test_type },
 		{ CPERF_MODEX_LEN,	parse_modex_len },
+		{ CPERF_RSA_PRIV_KEYTYPE,	parse_rsa_priv_keytype },
 		{ CPERF_SILENT,		parse_silent },
 		{ CPERF_POOL_SIZE,	parse_pool_sz },
 		{ CPERF_TOTAL_OPS,	parse_total_ops },
diff --git a/app/test-crypto-perf/cperf_test_common.c b/app/test-crypto-perf/cperf_test_common.c
index 9c287665a4..0eea4d133d 100644
--- a/app/test-crypto-perf/cperf_test_common.c
+++ b/app/test-crypto-perf/cperf_test_common.c
@@ -306,6 +306,7 @@ bool
 cperf_is_asym_test(const struct cperf_options *options)
 {
 	if (options->op_type == CPERF_ASYM_MODEX ||
+	    options->op_type == CPERF_ASYM_RSA ||
 	    options->op_type == CPERF_ASYM_SECP256R1 ||
 	    options->op_type == CPERF_ASYM_ED25519 ||
 	    options->op_type == CPERF_ASYM_SM2)
diff --git a/app/test-crypto-perf/cperf_test_vectors.c b/app/test-crypto-perf/cperf_test_vectors.c
index 71f6c35e3e..74d2ee3b03 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -1463,6 +1463,181 @@ cperf_sm2_test_data sm2_perf_data = {
 	.curve = RTE_CRYPTO_EC_GROUP_SM2
 };
 
+/** RSA test params */
+struct cperf_rsa_plaintext rsa_plaintext = {
+	.data = {
+		0xf8, 0xba, 0x1a, 0x55, 0xd0, 0x2f, 0x85, 0xae,
+		0x96, 0x7b, 0xb6, 0x2f, 0xb6, 0xcd, 0xa8, 0xeb,
+		0x7e, 0x78, 0xa0, 0x50
+	},
+	.len = 20
+};
+
+uint8_t rsa_n[] = {
+	0xb3, 0xa1, 0xaf, 0xb7, 0x13, 0x08, 0x00,
+	0x0a, 0x35, 0xdc, 0x2b, 0x20, 0x8d, 0xa1, 0xb5,
+	0xce, 0x47, 0x8a, 0xc3, 0x80, 0xf4, 0x7d, 0x4a,
+	0xa2, 0x62, 0xfd, 0x61, 0x7f, 0xb5, 0xa8, 0xde,
+	0x0a, 0x17, 0x97, 0xa0, 0xbf, 0xdf, 0x56, 0x5a,
+	0x3d, 0x51, 0x56, 0x4f, 0x70, 0x70, 0x3f, 0x63,
+	0x6a, 0x44, 0x5b, 0xad, 0x84, 0x0d, 0x3f, 0x27,
+	0x6e, 0x3b, 0x34, 0x91, 0x60, 0x14, 0xb9, 0xaa,
+	0x72, 0xfd, 0xa3, 0x64, 0xd2, 0x03, 0xa7, 0x53,
+	0x87, 0x9e, 0x88, 0x0b, 0xc1, 0x14, 0x93, 0x1a,
+	0x62, 0xff, 0xb1, 0x5d, 0x74, 0xcd, 0x59, 0x63,
+	0x18, 0x11, 0x3d, 0x4f, 0xba, 0x75, 0xd4, 0x33,
+	0x4e, 0x23, 0x6b, 0x7b, 0x57, 0x44, 0xe1, 0xd3,
+	0x03, 0x13, 0xa6, 0xf0, 0x8b, 0x60, 0xb0, 0x9e,
+	0xee, 0x75, 0x08, 0x9d, 0x71, 0x63, 0x13, 0xcb,
+	0xa6, 0x81, 0x92, 0x14, 0x03, 0x22, 0x2d, 0xde,
+	0x55
+};
+
+uint8_t rsa_d[] = {
+	0x24, 0xd7, 0xea, 0xf4, 0x7f, 0xe0, 0xca, 0x31,
+	0x4d, 0xee, 0xc4, 0xa1, 0xbe, 0xab, 0x06, 0x61,
+	0x32, 0xe7, 0x51, 0x46, 0x27, 0xdf, 0x72, 0xe9,
+	0x6f, 0xa8, 0x4c, 0xd1, 0x26, 0xef, 0x65, 0xeb,
+	0x67, 0xff, 0x5f, 0xa7, 0x3b, 0x25, 0xb9, 0x08,
+	0x8e, 0xa0, 0x47, 0x56, 0xe6, 0x8e, 0xf9, 0xd3,
+	0x18, 0x06, 0x3d, 0xc6, 0xb1, 0xf8, 0xdc, 0x1b,
+	0x8d, 0xe5, 0x30, 0x54, 0x26, 0xac, 0x16, 0x3b,
+	0x7b, 0xad, 0x46, 0x9e, 0x21, 0x6a, 0x57, 0xe6,
+	0x81, 0x56, 0x1d, 0x2a, 0xc4, 0x39, 0x63, 0x67,
+	0x81, 0x2c, 0xca, 0xcc, 0xf8, 0x42, 0x04, 0xbe,
+	0xcf, 0x8f, 0x6c, 0x5b, 0x81, 0x46, 0xb9, 0xc7,
+	0x62, 0x90, 0x87, 0x35, 0x03, 0x9b, 0x89, 0xcb,
+	0x37, 0xbd, 0xf1, 0x1b, 0x99, 0xa1, 0x9a, 0x78,
+	0xd5, 0x4c, 0xdd, 0x3f, 0x41, 0x0c, 0xb7, 0x1a,
+	0xd9, 0x7b, 0x87, 0x5f, 0xbe, 0xb1, 0x83, 0x41
+};
+
+uint8_t rsa_e[] = {0x01, 0x00, 0x01};
+
+uint8_t rsa_p[] = {
+	0xdc, 0xba, 0x00, 0x01, 0x57, 0x93, 0xe3, 0x05,
+	0xed, 0x61, 0x9a, 0xa3, 0xaf, 0x6a, 0xd3, 0x47,
+	0x8f, 0x2d, 0x1e, 0x7f, 0x4d, 0x60, 0xc8, 0x8d,
+	0x34, 0xb8, 0x17, 0x84, 0xbc, 0xd4, 0xe9, 0x79,
+	0x95, 0x75, 0x19, 0x37, 0xe0, 0xcc, 0xfe, 0x4c,
+	0x5d, 0x49, 0x53, 0x61, 0x29, 0xf1, 0xdc, 0x82,
+	0x03, 0x96, 0x7d, 0x95, 0x4f, 0xdd, 0x3c, 0x0a,
+	0x64, 0x8a, 0x43, 0x2f, 0x95, 0x4a, 0xed, 0xdd
+};
+
+uint8_t rsa_q[] = {
+	0xd0, 0x56, 0x7a, 0x0a, 0xd5, 0x95, 0xa4, 0x85,
+	0x53, 0x35, 0xa1, 0x48, 0x07, 0x6a, 0x7c, 0x08,
+	0xe0, 0xfd, 0x4b, 0x88, 0x77, 0xa6, 0x15, 0x23,
+	0x0f, 0xbf, 0x14, 0x46, 0x11, 0xee, 0x95, 0xc7,
+	0x5e, 0x77, 0x65, 0xa2, 0xb5, 0x50, 0xdf, 0x19,
+	0x07, 0xc7, 0x72, 0xdb, 0x29, 0xf6, 0x54, 0x86,
+	0xe1, 0xb3, 0x97, 0x0a, 0x28, 0x64, 0x3a, 0x38,
+	0xa6, 0x7d, 0x13, 0xc3, 0x79, 0xaa, 0x56, 0xd9
+};
+
+uint8_t rsa_dp[] = {
+	0xc5, 0x43, 0x0d, 0x82, 0x25, 0x8c, 0xab, 0x55,
+	0xbe, 0xc2, 0x7d, 0xfb, 0x4f, 0x68, 0x3f, 0x0e,
+	0x32, 0xec, 0xf5, 0xd6, 0x7b, 0x86, 0xc5, 0x75,
+	0x3c, 0xea, 0x51, 0x4a, 0x75, 0xa0, 0x2a, 0x50,
+	0x58, 0xbb, 0xe0, 0x1f, 0xca, 0x2e, 0x2a, 0x0e,
+	0x81, 0x48, 0x68, 0xd5, 0xeb, 0x30, 0x96, 0x0b,
+	0x33, 0xbd, 0xa8, 0xda, 0x6a, 0x17, 0xa3, 0xf2,
+	0xfd, 0xcb, 0x7b, 0x23, 0xe9, 0x5e, 0x9f, 0x99
+};
+uint8_t rsa_dq[] = {
+	0xbe, 0xff, 0xf9, 0x05, 0x43, 0xc8, 0xdc, 0x3b,
+	0x0b, 0x0d, 0x28, 0xde, 0x73, 0x46, 0x11, 0x8e,
+	0xc6, 0x4e, 0x11, 0xd8, 0x7b, 0xf0, 0xfc, 0x81,
+	0xd7, 0x66, 0xd3, 0xbc, 0x65, 0xa6, 0x39, 0x14,
+	0xbd, 0xab, 0x72, 0xb7, 0x57, 0xc9, 0x5b, 0xaf,
+	0x83, 0xed, 0x3b, 0x84, 0x68, 0x15, 0x18, 0x6b,
+	0x4c, 0x32, 0xac, 0x6f, 0x38, 0x96, 0xa2, 0xb5,
+	0xdb, 0x14, 0xe2, 0x70, 0x9c, 0x73, 0x29, 0x09
+};
+
+uint8_t rsa_qinv[] = {
+	0x59, 0xbd, 0xb1, 0x37, 0xeb, 0x4e, 0xcf, 0x68,
+	0xe7, 0x85, 0x91, 0xbb, 0xc0, 0xdb, 0x8e, 0x41,
+	0x91, 0x4a, 0xc0, 0xb1, 0xc5, 0xe8, 0x91, 0xf6,
+	0xc7, 0x5a, 0x98, 0x1a, 0x8a, 0x0f, 0x45, 0xb2,
+	0x5b, 0xff, 0x7a, 0x2d, 0x98, 0x89, 0x55, 0xd9,
+	0xbf, 0x6e, 0xdd, 0x2d, 0xd4, 0xe8, 0x0a, 0xaa,
+	0xae, 0x2a, 0xc4, 0x16, 0xb5, 0xba, 0xe1, 0x69,
+	0x71, 0x94, 0xdd, 0xa0, 0xf5, 0x1e, 0x6d, 0xcc
+};
+
+struct
+cperf_rsa_test_data rsa_qt_perf_data = {
+	.n = {
+		.data = rsa_n,
+		.length = sizeof(rsa_n),
+	},
+	.e = {
+		.data = rsa_e,
+		.length = sizeof(rsa_e),
+	},
+	.d = {
+		.data = NULL,
+		.length = 0,
+	},
+	.p = {
+		.data = rsa_p,
+		.length = sizeof(rsa_p),
+	},
+	.q = {
+		.data = rsa_q,
+		.length = sizeof(rsa_q),
+	},
+	.dp = {
+		.data = rsa_dp,
+		.length = sizeof(rsa_dp),
+	},
+	.dq = {
+		.data = rsa_dq,
+		.length = sizeof(rsa_dq),
+	},
+	.qinv = {
+		.data = rsa_qinv,
+		.length = sizeof(rsa_qinv),
+	},
+	.key_type = RTE_RSA_KEY_TYPE_QT,
+	.padding = RTE_CRYPTO_RSA_PADDING_PKCS1_5,
+};
+
+struct
+cperf_rsa_test_data rsa_exp_perf_data = {
+	.n = {
+		.data = rsa_n,
+		.length = sizeof(rsa_n),
+	},
+	.e = {
+		.data = rsa_e,
+		.length = sizeof(rsa_e),
+	},
+	.d = {
+		.data = rsa_d,
+		.length = sizeof(rsa_d),
+	},
+	.key_type = RTE_RSA_KEY_TYPE_EXP,
+	.padding = RTE_CRYPTO_RSA_PADDING_PKCS1_5,
+};
+
+struct
+cperf_rsa_test_data rsa_pub_perf_data = {
+	.n = {
+		.data = rsa_n,
+		.length = sizeof(rsa_n),
+	},
+	.e = {
+		.data = rsa_e,
+		.length = sizeof(rsa_e),
+	},
+	.key_type = RTE_RSA_KEY_TYPE_EXP,
+	.padding = RTE_CRYPTO_RSA_PADDING_PKCS1_5,
+};
+
 struct cperf_test_vector*
 cperf_test_vector_get_dummy(struct cperf_options *options)
 {
diff --git a/app/test-crypto-perf/cperf_test_vectors.h b/app/test-crypto-perf/cperf_test_vectors.h
index f83a17c176..6319652db0 100644
--- a/app/test-crypto-perf/cperf_test_vectors.h
+++ b/app/test-crypto-perf/cperf_test_vectors.h
@@ -107,6 +107,25 @@ struct cperf_modex_test_data {
 	} result;
 };
 
+#define TEST_DATA_SIZE 4096
+struct cperf_rsa_plaintext {
+	uint8_t data[TEST_DATA_SIZE];
+	unsigned int len;
+};
+
+struct cperf_rsa_test_data {
+	enum rte_crypto_rsa_priv_key_type key_type;
+	rte_crypto_param n;
+	rte_crypto_param e;
+	rte_crypto_param d;
+	rte_crypto_param p;
+	rte_crypto_param q;
+	rte_crypto_param dp;
+	rte_crypto_param dq;
+	rte_crypto_param qinv;
+	enum rte_crypto_rsa_padding_type padding;
+};
+
 struct cperf_ecdsa_test_data {
 	rte_crypto_param pubkey_qx;
 	rte_crypto_param pubkey_qy;
@@ -158,5 +177,9 @@ extern struct cperf_modex_test_data modex_perf_data[10];
 extern struct cperf_ecdsa_test_data secp256r1_perf_data;
 extern struct cperf_eddsa_test_data ed25519_perf_data;
 extern struct cperf_sm2_test_data sm2_perf_data;
+extern struct cperf_rsa_test_data rsa_pub_perf_data;
+extern struct cperf_rsa_test_data rsa_exp_perf_data;
+extern struct cperf_rsa_test_data rsa_qt_perf_data;
+extern struct cperf_rsa_plaintext rsa_plaintext;
 
 #endif
diff --git a/app/test-crypto-perf/main.c b/app/test-crypto-perf/main.c
index 3d04d253ed..2e38c0011d 100644
--- a/app/test-crypto-perf/main.c
+++ b/app/test-crypto-perf/main.c
@@ -45,12 +45,18 @@ const char *cperf_op_type_strs[] = {
 	[CPERF_DOCSIS] = "docsis",
 	[CPERF_IPSEC] = "ipsec",
 	[CPERF_ASYM_MODEX] = "modex",
+	[CPERF_ASYM_RSA] = "rsa",
 	[CPERF_ASYM_SECP256R1] = "ecdsa_p256r1",
 	[CPERF_ASYM_ED25519] = "eddsa_25519",
 	[CPERF_ASYM_SM2] = "sm2",
 	[CPERF_TLS] = "tls-record"
 };
 
+const char *cperf_rsa_priv_keytype_strs[] = {
+	[RTE_RSA_KEY_TYPE_EXP] = "exp",
+	[RTE_RSA_KEY_TYPE_QT] = "qt",
+};
+
 const struct cperf_test cperf_testmap[] = {
 		[CPERF_TEST_TYPE_THROUGHPUT] = {
 				cperf_throughput_test_constructor,
@@ -230,6 +236,7 @@ cperf_initialize_cryptodev(struct cperf_options *opts, uint8_t *enabled_cdevs)
 		case CPERF_ASYM_SECP256R1:
 		case CPERF_ASYM_ED25519:
 		case CPERF_ASYM_SM2:
+		case CPERF_ASYM_RSA:
 		case CPERF_ASYM_MODEX:
 			conf.ff_disable |= (RTE_CRYPTODEV_FF_SECURITY |
 					    RTE_CRYPTODEV_FF_SYMMETRIC_CRYPTO);
@@ -372,6 +379,18 @@ cperf_verify_devices_capabilities(struct cperf_options *opts,
 
 		}
 
+		if (opts->op_type == CPERF_ASYM_RSA) {
+			asym_cap_idx.type = RTE_CRYPTO_ASYM_XFORM_RSA;
+			asym_capability = rte_cryptodev_asym_capability_get(cdev_id, &asym_cap_idx);
+			if (asym_capability == NULL)
+				return -1;
+
+			if (!rte_cryptodev_asym_xform_capability_check_optype(asym_capability,
+						opts->asym_op_type))
+				return -1;
+
+		}
+
 		if (opts->op_type == CPERF_ASYM_SECP256R1) {
 			asym_cap_idx.type = RTE_CRYPTO_ASYM_XFORM_ECDSA;
 			asym_capability = rte_cryptodev_asym_capability_get(cdev_id, &asym_cap_idx);
-- 
2.25.1

