Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B2CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:00:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EE7242DE3;
	Tue, 29 Sep 2026 15:58:36 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EC7674026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:20:58 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAk34U1022901; Tue, 29 Sep 2026 05:20:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
 UoDm8BGSu3EO2MvTf5wr/Ow4cAUi+yDbF7UF5CHzLo=; b=YuGcFshSK/ryA86tR
 HwYkAp+KXv4ZX26xIXQ66Qa2RtjdofIw0Bp1hEHaKjsHPp9e8/Xfvv5bi29sqJjy
 IfijFgLidV+c7A86QjnxP5S/Wvh7fWriX8Q9bEARlAfQeUzkx9TNizoLmauAIoX5
 hL1cnvyRys6T9de8YzU6y7f7+tbfiFzZc1eQOcKKO5TRAcTDtlpCQ7XflvTpuBVq
 pdhFkLWlCPjr3aPVlQX/bLJoYNHavKAerCPb53GmYTn4jm/qwc68hsWR6CF2D2hi
 1e05KXC/8lTREL5QX1j6Cd7uMfLYL3c8+LxSvyCFjTjiwOTbE+e+WD/iR+0eHIk7
 BRMcQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h04c3a9gp-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 05:20:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 29 Sep 2026 05:20:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 29 Sep 2026 05:20:56 -0700
Received: from cavium-PowerEdge-T110-II.. (unknown [10.28.38.34])
 by maili.marvell.com (Postfix) with ESMTP id DC6EF3F7088;
 Tue, 29 Sep 2026 05:20:54 -0700 (PDT)
From: Pratik Senapati <psenapati@marvell.com>
To: <dev@dpdk.org>
CC: <radu.nicolau@intel.com>, <gakhil@marvell.com>, <gmuthukrishn@marvell.com>,
 <kai.ji@intel.com>
Subject: [PATCH v4 4/4] app/crypto-perf: add ML-DSA sign support
Date: Tue, 29 Sep 2026 17:50:44 +0530
Message-ID: <20260929122044.1344518-4-psenapati@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929122044.1344518-1-psenapati@marvell.com>
References: <20260929105851.1305127-1-psenapati@marvell.com>
 <20260929122044.1344518-1-psenapati@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzf2DuPEOdhXK
 dWrdghNp5L5xzHrrGDaPLCgVa07+sKuJXv0stLsFkDVfZpAcj/lptKuA4ouFmr0zfCtlqFO+AJB
 3lrLk0whCp/3iyc5cqfIlI5VKGmsPr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfXzek9IHSesmB9
 fLssonMfHf/zmNhiPBmkcwW1fjJFeVXgkpAlPr8AvyANEvCiuSZwjMcoOBo16LGSxKZrjBjOqrd
 KlOpsQSoI1Jbm1NT18d0QrIhBiyWwWIOfvhkEHGH+QAIxYZBkYtZ28ZmFInMaf7adHxm4j+4h8I
 zHfMOkWBy+vP142iFck4Ids04R+1N5EY6PXK7/Y+ka3iyvLA7VwcbROFyytBd9s0A+1BwXVaORE
 1JKes2dOBOg40v0R//Af9MZtSOfvYMU0HlU48IlE8bU+O7UTt6TT2rmKltzVQlX3k90DSWukz70
 BOyh4w/0xt3rmXhmENICYgmRq7kY0haDmKH7AzC9Xwptwon+lK5AoCcZSZFog9xZyxtrcVTXf/i
 nSaOnmjma5I/pZW7Lka1s6bM+WXh/VaTZCRpHRT4O9O1GdGnP2WtF/WMpwnRqln3dKHOvAqDAs0
 YUrLkpGgXc1iz+mUi/g==
X-Proofpoint-ORIG-GUID: xYj5xrFXOvQ52Ij6-qAD9OtA5xpebncK
X-Authority-Analysis: v=2.4 cv=R/WWitRX c=1 sm=1 tr=0 ts=6abbad29 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=CT-Ar0YZkQRCyopDqAQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: xYj5xrFXOvQ52Ij6-qAD9OtA5xpebncK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Mailman-Approved-At: Tue, 29 Sep 2026 15:58:23 +0200
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
 app/test-crypto-perf/cperf_ops.c             | 101 ++++++++---
 app/test-crypto-perf/cperf_options_parsing.c |   3 +-
 app/test-crypto-perf/cperf_test_vectors.c    | 174 ++++++++++++++++++-
 app/test-crypto-perf/cperf_test_vectors.h    |  24 +--
 app/test-crypto-perf/main.c                  |  28 ++-
 doc/guides/tools/cryptoperf.rst              |   5 +-
 6 files changed, 280 insertions(+), 55 deletions(-)

diff --git a/app/test-crypto-perf/cperf_ops.c b/app/test-crypto-perf/cperf_ops.c
index af0e6da8c8..e025dc5a61 100644
--- a/app/test-crypto-perf/cperf_ops.c
+++ b/app/test-crypto-perf/cperf_ops.c
@@ -219,8 +219,27 @@ cperf_set_ops_asym_mlkem(struct rte_crypto_op **ops,
 		uint32_t *imix_idx __rte_unused,
 		uint64_t *tsc_start __rte_unused)
 {
+	/* Intermediate writable buffers for static const test vectors */
+	static uint8_t ek_buf[1568];     /* ML-KEM-1024 ek max */
+	static uint8_t dk_buf[3168];     /* ML-KEM-1024 dk max */
+	static uint8_t msg_buf[32];      /* ML-KEM message (32 bytes) */
+	static uint8_t cipher_buf[1568]; /* ML-KEM-1024 cipher max */
+	static uint8_t sk_buf[32];       /* shared key (32 bytes) */
 	uint16_t i;
 
+	if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
+		memcpy(ek_buf, options->mlkem_data->ek.data,
+		       options->mlkem_data->ek.length);
+		if (options->mlkem_data->message.length)
+			memcpy(msg_buf, options->mlkem_data->message.data,
+			       options->mlkem_data->message.length);
+	} else {
+		memcpy(dk_buf, options->mlkem_data->dk.data,
+		       options->mlkem_data->dk.length);
+		memcpy(cipher_buf, options->mlkem_data->cipher.data,
+		       options->mlkem_data->cipher.length);
+	}
+
 	for (i = 0; i < nb_ops; i++) {
 		struct rte_crypto_asym_op *asym_op = ops[i]->asym;
 
@@ -229,24 +248,25 @@ cperf_set_ops_asym_mlkem(struct rte_crypto_op **ops,
 
 		if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_ENCRYPT) {
 			asym_op->mlkem.op = RTE_CRYPTO_ML_KEM_OP_ENCAP;
-			asym_op->mlkem.encap.ek.data = options->mlkem_data->ek.data;
+			asym_op->mlkem.encap.ek.data = ek_buf;
 			asym_op->mlkem.encap.ek.length = options->mlkem_data->ek.length;
-			asym_op->mlkem.encap.cipher.data = options->mlkem_data->cipher.data;
+			asym_op->mlkem.encap.cipher.data = cipher_buf;
 			asym_op->mlkem.encap.cipher.length = options->mlkem_data->cipher.length;
-			asym_op->mlkem.encap.sk.data = options->mlkem_data->sk.data;
+			asym_op->mlkem.encap.sk.data = sk_buf;
 			asym_op->mlkem.encap.sk.length = options->mlkem_data->sk.length;
-			asym_op->mlkem.encap.message.data = options->mlkem_data->message.data;
+			asym_op->mlkem.encap.message.data = msg_buf;
 			asym_op->mlkem.encap.message.length = options->mlkem_data->message.length;
 		} else if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_DECRYPT) {
 			asym_op->mlkem.op = RTE_CRYPTO_ML_KEM_OP_DECAP;
-			asym_op->mlkem.decap.dk.data = options->mlkem_data->dk.data;
+			asym_op->mlkem.decap.dk.data = dk_buf;
 			asym_op->mlkem.decap.dk.length = options->mlkem_data->dk.length;
-			asym_op->mlkem.decap.cipher.data = options->mlkem_data->cipher.data;
+			asym_op->mlkem.decap.cipher.data = cipher_buf;
 			asym_op->mlkem.decap.cipher.length = options->mlkem_data->cipher.length;
-			asym_op->mlkem.decap.sk.data = options->mlkem_data->sk.data;
+			asym_op->mlkem.decap.sk.data = sk_buf;
 			asym_op->mlkem.decap.sk.length = options->mlkem_data->sk.length;
 		} else {
-			rte_panic("Unsupported ML-KEM operation type %d\n", options->asym_op_type);
+			rte_panic("Unsupported ML-KEM operation type %d\n",
+				  options->asym_op_type);
 		}
 	}
 }
@@ -262,8 +282,48 @@ cperf_set_ops_asym_mldsa(struct rte_crypto_op **ops,
 		uint32_t *imix_idx __rte_unused,
 		uint64_t *tsc_start __rte_unused)
 {
+	/* Intermediate writable buffers for static const test vectors */
+	static uint8_t privkey_buf[4896]; /* ML-DSA-87 privkey max */
+	static uint8_t pubkey_buf[2592];  /* ML-DSA-87 pubkey max */
+	static uint8_t msg_buf[256];      /* message */
+	static uint8_t sign_buf[4627];    /* ML-DSA-87 sign max */
+	static uint8_t ctx_buf[256];      /* context */
+	static uint8_t seed_buf[32];      /* seed */
+	static uint8_t mu_buf[64];        /* mu */
 	uint16_t i;
 
+	if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
+		memcpy(privkey_buf, options->mldsa_data->privkey.data,
+		       options->mldsa_data->privkey.length);
+		if (options->mldsa_data->message.length)
+			memcpy(msg_buf, options->mldsa_data->message.data,
+			       options->mldsa_data->message.length);
+		if (options->mldsa_data->ctx.length)
+			memcpy(ctx_buf, options->mldsa_data->ctx.data,
+			       options->mldsa_data->ctx.length);
+		if (options->mldsa_data->seed.length)
+			memcpy(seed_buf, options->mldsa_data->seed.data,
+			       options->mldsa_data->seed.length);
+		if (options->mldsa_data->mu.length)
+			memcpy(mu_buf, options->mldsa_data->mu.data,
+			       options->mldsa_data->mu.length);
+	} else {
+		memcpy(pubkey_buf, options->mldsa_data->pubkey.data,
+		       options->mldsa_data->pubkey.length);
+		if (options->mldsa_data->message.length)
+			memcpy(msg_buf, options->mldsa_data->message.data,
+			       options->mldsa_data->message.length);
+		if (options->mldsa_data->sign.length)
+			memcpy(sign_buf, options->mldsa_data->sign.data,
+			       options->mldsa_data->sign.length);
+		if (options->mldsa_data->ctx.length)
+			memcpy(ctx_buf, options->mldsa_data->ctx.data,
+			       options->mldsa_data->ctx.length);
+		if (options->mldsa_data->mu.length)
+			memcpy(mu_buf, options->mldsa_data->mu.data,
+			       options->mldsa_data->mu.length);
+	}
+
 	for (i = 0; i < nb_ops; i++) {
 		struct rte_crypto_asym_op *asym_op = ops[i]->asym;
 
@@ -272,34 +332,35 @@ cperf_set_ops_asym_mldsa(struct rte_crypto_op **ops,
 
 		if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_SIGN) {
 			asym_op->mldsa.op = RTE_CRYPTO_ML_DSA_OP_SIGN;
-			asym_op->mldsa.siggen.privkey.data = options->mldsa_data->privkey.data;
+			asym_op->mldsa.siggen.privkey.data = privkey_buf;
 			asym_op->mldsa.siggen.privkey.length = options->mldsa_data->privkey.length;
-			asym_op->mldsa.siggen.message.data = options->mldsa_data->message.data;
+			asym_op->mldsa.siggen.message.data = msg_buf;
 			asym_op->mldsa.siggen.message.length = options->mldsa_data->message.length;
-			asym_op->mldsa.siggen.sign.data = options->mldsa_data->sign.data;
+			asym_op->mldsa.siggen.sign.data = sign_buf;
 			asym_op->mldsa.siggen.sign.length = options->mldsa_data->sign.length;
-			asym_op->mldsa.siggen.ctx.data = options->mldsa_data->ctx.data;
+			asym_op->mldsa.siggen.ctx.data = ctx_buf;
 			asym_op->mldsa.siggen.ctx.length = options->mldsa_data->ctx.length;
-			asym_op->mldsa.siggen.seed.data = options->mldsa_data->seed.data;
+			asym_op->mldsa.siggen.seed.data = seed_buf;
 			asym_op->mldsa.siggen.seed.length = options->mldsa_data->seed.length;
-			asym_op->mldsa.siggen.mu.data = options->mldsa_data->mu.data;
+			asym_op->mldsa.siggen.mu.data = mu_buf;
 			asym_op->mldsa.siggen.mu.length = options->mldsa_data->mu.length;
 			asym_op->mldsa.siggen.hash = options->mldsa_data->hash;
 		} else if (options->asym_op_type == RTE_CRYPTO_ASYM_OP_VERIFY) {
 			asym_op->mldsa.op = RTE_CRYPTO_ML_DSA_OP_VERIFY;
-			asym_op->mldsa.sigver.pubkey.data = options->mldsa_data->pubkey.data;
+			asym_op->mldsa.sigver.pubkey.data = pubkey_buf;
 			asym_op->mldsa.sigver.pubkey.length = options->mldsa_data->pubkey.length;
-			asym_op->mldsa.sigver.message.data = options->mldsa_data->message.data;
+			asym_op->mldsa.sigver.message.data = msg_buf;
 			asym_op->mldsa.sigver.message.length = options->mldsa_data->message.length;
-			asym_op->mldsa.sigver.sign.data = options->mldsa_data->sign.data;
+			asym_op->mldsa.sigver.sign.data = sign_buf;
 			asym_op->mldsa.sigver.sign.length = options->mldsa_data->sign.length;
-			asym_op->mldsa.sigver.ctx.data = options->mldsa_data->ctx.data;
+			asym_op->mldsa.sigver.ctx.data = ctx_buf;
 			asym_op->mldsa.sigver.ctx.length = options->mldsa_data->ctx.length;
-			asym_op->mldsa.sigver.mu.data = options->mldsa_data->mu.data;
+			asym_op->mldsa.sigver.mu.data = mu_buf;
 			asym_op->mldsa.sigver.mu.length = options->mldsa_data->mu.length;
 			asym_op->mldsa.sigver.hash = options->mldsa_data->hash;
 		} else {
-			rte_panic("Unsupported ML-DSA operation type %d\n", options->asym_op_type);
+			rte_panic("Unsupported ML-DSA operation type %d\n",
+				  options->asym_op_type);
 		}
 	}
 }
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
index c88a6a1f12..09e65476ea 100644
--- a/app/test-crypto-perf/cperf_test_vectors.c
+++ b/app/test-crypto-perf/cperf_test_vectors.c
@@ -7922,7 +7922,7 @@ static const uint8_t mlkem_1024_sk[] = {
 	0xDD, 0x06, 0xD9, 0x38, 0x10, 0x34, 0xC6, 0xB4,
 };
 
-static const uint8_t mldsa_65_seed[] = {
+const uint8_t mldsa_65_seed[] = {
 	0xAF, 0xB4, 0x7E, 0x7A, 0x2B, 0x5C, 0x6B, 0xF9,
 	0xE7, 0x3E, 0xFE, 0xD6, 0x4B, 0x27, 0x90, 0x48,
 	0xD3, 0xA2, 0x35, 0x42, 0x11, 0xD2, 0xCA, 0x31,
@@ -8684,7 +8684,7 @@ static const uint8_t mldsa_65_pubkey_noseed[] = {
 };
 
 static const uint8_t mldsa_65_message[] = {
-	0x60, 0xD4, 0x8C, 0xF2, 0x61, 0x6D, 0xB0, 0xB6,
+	0x1C, 0x00, 0x00, 0x00, 0x61, 0x6D, 0xB0, 0xB6,
 	0x0F, 0x54, 0x96, 0x5F, 0xDB, 0x21, 0x40, 0xB5,
 	0x33, 0xA3, 0x85, 0xFE, 0xA3, 0xCC, 0x76, 0x5C,
 	0x8C, 0xB0, 0xC0, 0x71, 0xE5, 0x6D, 0xFB, 0xDD,
@@ -9107,7 +9107,7 @@ static const uint8_t mldsa_65_sign_dtrm[] = {
 	0x10, 0x14, 0x1C, 0x24, 0x2F,
 };
 
-static const uint8_t mldsa_87_seed[] = {
+const uint8_t mldsa_87_seed[] = {
 	0x2F, 0xA5, 0xF2, 0x15, 0xFE, 0x26, 0x93, 0x2F,
 	0xF4, 0x7C, 0xF3, 0x03, 0x6F, 0xC4, 0x0F, 0x4A,
 	0x4B, 0x43, 0xA2, 0x70, 0xB3, 0x2A, 0xAD, 0xB0,
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
diff --git a/app/test-crypto-perf/cperf_test_vectors.h b/app/test-crypto-perf/cperf_test_vectors.h
index 77adcea720..c6ad7fdcb3 100644
--- a/app/test-crypto-perf/cperf_test_vectors.h
+++ b/app/test-crypto-perf/cperf_test_vectors.h
@@ -111,23 +111,23 @@ struct cperf_mlkem_test_data {
 	const char *name;
 	enum rte_crypto_ml_kem_type type;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} dk;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} ek;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} message;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} cipher;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} sk;
 };
@@ -192,31 +192,31 @@ struct cperf_mldsa_test_data {
 	const char *name;
 	enum rte_crypto_ml_dsa_type type;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} privkey;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} pubkey;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} message;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} sign;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} ctx;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} seed;
 	struct {
-		uint8_t *data;
+		const uint8_t *data;
 		uint32_t length;
 	} mu;
 	enum rte_crypto_auth_algorithm hash;
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

