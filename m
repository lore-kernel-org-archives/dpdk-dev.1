Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA0CAC5B0
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Oct 2025 03:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 196824064C;
	Sat,  4 Oct 2025 05:23:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8A3B440670
 for <dev@dpdk.org>; Sat,  4 Oct 2025 05:23:21 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59435F6F013760;
 Fri, 3 Oct 2025 20:23:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 JZcQZe0weH2X09tZBx4/Es5brbZGzQElbPPWIZBAZ0=; b=hSjM4K+IY9c8Uiru5
 px+BfEak6Le+CuPu97BB5IAdONUKTPoTNe7JSvOfzclyYgRpc3/17gcvpDo7RkOr
 VzDBhpWbkMX7dJfBb0fHoj2ipSNulCIY2fR70SiFJnhtuARdK2ETh10JXt2BBbMr
 FVyrIwY05jccKvLe98i+sYMYA0Z9fVpiZBMkjd5cvwXVmhMJ4BO1kEuA5KQyL0bL
 QBj1Q65CATIEVSXp4M5j9lwMQ7oOKe/ovrzeqVLStEPgmhQ2EFBvWU+M9L9RDmgA
 J7/A+m1oADl+hTM1S73G447I/DGarUmwycgvWrK54lWxpXF2jdGh0YADest7WFAS
 bgPSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49juby80ws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Oct 2025 20:23:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 3 Oct 2025 20:23:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 3 Oct 2025 20:23:27 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.28.163.101])
 by maili.marvell.com (Postfix) with ESMTP id 287375B695B;
 Fri,  3 Oct 2025 20:23:16 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v4 2/3] crypto/openssl: add ML crypto support
Date: Sat, 4 Oct 2025 08:52:54 +0530
Message-ID: <20251004032259.2707-3-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251004032259.2707-1-gmuthukrishn@marvell.com>
References: <20251001175658.2303-1-gmuthukrishn@marvell.com>
 <20251004032259.2707-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nLJVMkr52MFuNssu9OVzczL1YAan8X0X
X-Proofpoint-ORIG-GUID: nLJVMkr52MFuNssu9OVzczL1YAan8X0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNCBTYWx0ZWRfXxoZktmBJ12XK
 CsWJVz6bJXC4+BxnLd8auM0TTPMSqFULmBsUIh6MiZtj2tiCcvvMR73OKVPCmyUtVXdkJzBmmos
 lIevaAYpUpLRBZr0COu1bQhrTDgtNZBjmHmAv1U8A6Qs8b+w7EmX9N3nfAhbIQhdaj2CVn27RFX
 sA5wWbx1QTpUofJ66sVEGIspUOlV4fksLA1JM7BU1yMLBi7r6GZGbNwpXnKGRJP/MRSlYsGl4qG
 Wdli/L9Qbk+wGmHizYY7cG0YL5t8HfzMSIAo8JSL2hkIN9Psk8f2SddoatXS7GtVLfFLB245UIv
 EtCNf5dqiIaNGnNPtfgaZwuMWKyQyew+Mzykdmw9MmN2H3t93Og2eYmBn6tOl83xioTA/4zBaLA
 focxSoIDLDbV1QSj5aXxkYr3Ymr5ag==
X-Authority-Analysis: v=2.4 cv=d874CBjE c=1 sm=1 tr=0 ts=68e09328 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=9jXCqyPffeu5ep-VVs0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
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

Add ML-KEM and ML-DSA support.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
v4:
 - var name changes
---
 doc/guides/cryptodevs/features/openssl.ini   |   2 +
 doc/guides/rel_notes/release_25_11.rst       |   4 +
 drivers/crypto/openssl/openssl_pmd_private.h |  17 +
 drivers/crypto/openssl/rte_openssl_pmd.c     | 870 +++++++++++++++++++
 drivers/crypto/openssl/rte_openssl_pmd_ops.c | 133 +++
 5 files changed, 1026 insertions(+)

diff --git a/doc/guides/cryptodevs/features/openssl.ini b/doc/guides/cryptodevs/features/openssl.ini
index f0074a46f8..df6e7de316 100644
--- a/doc/guides/cryptodevs/features/openssl.ini
+++ b/doc/guides/cryptodevs/features/openssl.ini
@@ -67,6 +67,8 @@ Modular Inversion = Y
 Diffie-hellman = Y
 SM2 = Y
 EdDSA = Y
+ML-KEM = Y
+ML-DSA = Y
 
 ;
 ; Supported Operating systems of the 'openssl' crypto driver.
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 62b8767631..9d47f762d7 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -81,6 +81,10 @@ New Features
   * Added PQC ML-KEM support with reference to FIPS203.
   * Added PQC ML-DSA support with reference to FIPS204.
 
+* **Updated openssl crypto driver.**
+
+  * Added support for PQC ML-KEM and ML-DSA algorithms.
+
 Removed Items
 -------------
 
diff --git a/drivers/crypto/openssl/openssl_pmd_private.h b/drivers/crypto/openssl/openssl_pmd_private.h
index 4a6a088870..fe89e522e1 100644
--- a/drivers/crypto/openssl/openssl_pmd_private.h
+++ b/drivers/crypto/openssl/openssl_pmd_private.h
@@ -249,6 +249,20 @@ struct __rte_cache_aligned openssl_asym_session {
 			OSSL_PARAM * params;
 #endif
 		} eddsa;
+		struct {
+			uint8_t type;
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+			EVP_PKEY_CTX * pctx;
+#endif
+		} ml_kem;
+		struct {
+			uint8_t type;
+			bool sign_prehash;
+			bool sign_deterministic;
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+			EVP_PKEY_CTX * pctx;
+#endif
+		} ml_dsa;
 	} u;
 };
 /** Set and validate OPENSSL crypto session parameters */
@@ -264,4 +278,7 @@ openssl_reset_session(struct openssl_session *sess);
 /** device specific operations function pointer structure */
 extern struct rte_cryptodev_ops *rte_openssl_pmd_ops;
 
+/** ML parameter type names */
+extern const char *ml_kem_type_names[];
+extern const char *ml_dsa_type_names[];
 #endif /* _OPENSSL_PMD_PRIVATE_H_ */
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 5bfad92b7c..4f171f48cc 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -3255,6 +3255,7 @@ process_openssl_eddsa_op_evp(struct rte_crypto_op *cop,
 
 	return ret;
 }
+
 #else
 static int
 process_openssl_rsa_op(struct rte_crypto_op *cop,
@@ -3383,6 +3384,861 @@ process_openssl_eddsa_op(struct rte_crypto_op *cop,
 }
 #endif
 
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+static int
+mlkem_keygen_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_kem_op *op = &cop->asym->mlkem;
+	EVP_PKEY_CTX *pctx = sess->u.ml_kem.pctx;
+	OSSL_PARAM_BLD *param_bld;
+	uint8_t seed[64] = {0};
+	EVP_PKEY *pkey = NULL;
+	OSSL_PARAM *params;
+	const char *param;
+	size_t keylen = 0;
+	void *key = NULL;
+	OSSL_PARAM *p;
+
+	param = ml_kem_type_names[sess->u.ml_kem.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_kem type");
+		return -EINVAL;
+	}
+
+	memcpy(seed, op->keygen.d.data, op->keygen.d.length);
+	memcpy(seed + op->keygen.d.length,
+		op->keygen.z.data, op->keygen.z.length);
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_ML_KEM_SEED,
+			seed, sizeof(seed))) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_KEYPAIR, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	OSSL_PARAM_free(params);
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	/* extract public and private keys */
+	if (EVP_PKEY_todata(pkey, EVP_PKEY_KEYPAIR, &params) != 1) {
+		OPENSSL_LOG(ERR, "Failed to convert to key pairs");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	p = OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_PRIV_KEY);
+	if (p == NULL) {
+		OPENSSL_LOG(ERR, "Failed to locate private key");
+		OSSL_PARAM_free(params);
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	OSSL_PARAM_get_octet_string(p, &key,
+		rte_crypto_ml_kem_pubkey_size[sess->u.ml_kem.type], &keylen);
+	memcpy(op->keygen.dk.data, key, keylen);
+	op->keygen.dk.length = keylen;
+
+	p = OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_PUB_KEY);
+	if (p == NULL) {
+		OPENSSL_LOG(ERR, "Failed to locate public key");
+		OSSL_PARAM_free(params);
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	OSSL_PARAM_get_octet_string(p, &key,
+		rte_crypto_ml_kem_privkey_size[sess->u.ml_kem.type], &keylen);
+	memcpy(op->keygen.ek.data, key, keylen);
+	op->keygen.ek.length = keylen;
+
+	OSSL_PARAM_free(params);
+	EVP_PKEY_free(pkey);
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return 0;
+}
+
+static int
+mlkem_encap_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_kem_op *op = &cop->asym->mlkem;
+	EVP_PKEY_CTX *pctx = sess->u.ml_kem.pctx;
+	OSSL_PARAM_BLD *param_bld;
+	EVP_PKEY_CTX *cctx = NULL;
+	EVP_PKEY *pkey = NULL;
+	OSSL_PARAM *params;
+	const char *param;
+	size_t keylen = 0;
+	size_t outlen = 0;
+	int ret = -1;
+
+	param = ml_kem_type_names[sess->u.ml_kem.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_kem type");
+		return -EINVAL;
+	}
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_PUB_KEY,
+			op->encap.ek.data, op->encap.ek.length)) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PUBLIC_KEY, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	OSSL_PARAM_free(params);
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
+	if (cctx == NULL) {
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_encapsulate_init(cctx, NULL) != 1) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (op->encap.message.length) {
+		const OSSL_PARAM kem_params[] = {
+			OSSL_PARAM_octet_string(OSSL_KEM_PARAM_IKME,
+				(void *)op->encap.message.data, op->encap.message.length),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_encapsulate_init(cctx, kem_params) != 1) {
+			EVP_PKEY_free(pkey);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+	}
+
+	if (EVP_PKEY_encapsulate(cctx, NULL, &outlen, NULL, &keylen) != 1) {
+		OPENSSL_LOG(ERR, "Failed to determine output length");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (outlen > op->encap.cipher.length) {
+		OPENSSL_LOG(ERR, "Insufficient buffer for cipher text");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (keylen > op->encap.sk.length) {
+		OPENSSL_LOG(ERR, "Insufficient buffer for shared key");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_encapsulate(cctx, op->encap.cipher.data, &outlen,
+			op->encap.sk.data, &keylen) != 1) {
+		OPENSSL_LOG(ERR, "Failed to encapculate");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	op->encap.cipher.length = outlen;
+	op->encap.sk.length = keylen;
+
+	EVP_PKEY_CTX_free(cctx);
+	EVP_PKEY_free(pkey);
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return ret;
+}
+
+static int
+mlkem_decap_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_kem_op *op = &cop->asym->mlkem;
+	EVP_PKEY_CTX *pctx = sess->u.ml_kem.pctx;
+	OSSL_PARAM_BLD *param_bld;
+	EVP_PKEY_CTX *cctx = NULL;
+	EVP_PKEY *pkey = NULL;
+	OSSL_PARAM *params;
+	const char *param;
+	size_t keylen = 0;
+	int ret = -1;
+
+	param = ml_kem_type_names[sess->u.ml_kem.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_kem type");
+		return -EINVAL;
+	}
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_PRIV_KEY,
+			op->decap.dk.data, op->decap.dk.length)) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PRIVATE_KEY, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	OSSL_PARAM_free(params);
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
+	if (cctx == NULL) {
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_decapsulate_init(cctx, params) != 1) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_decapsulate(cctx, NULL, &keylen,
+		op->decap.cipher.data, op->decap.cipher.length) != 1) {
+		OPENSSL_LOG(ERR, "Failed to determine output length");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (keylen > op->decap.sk.length) {
+		OPENSSL_LOG(ERR, "Insufficient buffer for shared key");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_decapsulate(cctx, op->decap.sk.data, &keylen,
+			op->decap.cipher.data, op->decap.cipher.length) != 1) {
+		OPENSSL_LOG(ERR, "Failed to decapsulate");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	op->decap.sk.length = keylen;
+
+	EVP_PKEY_CTX_free(cctx);
+	EVP_PKEY_free(pkey);
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return ret;
+}
+
+static int
+process_openssl_mlkem_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_kem_op *op = &cop->asym->mlkem;
+	int ret = -1;
+
+	switch (op->op) {
+	case RTE_CRYPTO_ML_KEM_OP_KEYGEN:
+		ret = mlkem_keygen_op_evp(cop, sess);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_KEYVER:
+		cop->status = RTE_CRYPTO_OP_STATUS_NOT_PROCESSED;
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_ENCAP:
+		ret = mlkem_encap_op_evp(cop, sess);
+		break;
+	case RTE_CRYPTO_ML_KEM_OP_DECAP:
+		ret = mlkem_decap_op_evp(cop, sess);
+		break;
+	default:
+		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		break;
+	}
+
+	return ret;
+}
+
+static int
+mldsa_keygen_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_dsa_op *op = &cop->asym->mldsa;
+	EVP_PKEY_CTX *pctx = sess->u.ml_dsa.pctx;
+	OSSL_PARAM_BLD *param_bld;
+	EVP_PKEY *pkey = NULL;
+	OSSL_PARAM *params;
+	const char *param;
+	size_t keylen = 0;
+	void *key = NULL;
+	OSSL_PARAM *p;
+
+	param = ml_dsa_type_names[sess->u.ml_dsa.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_dsa type");
+		return -EINVAL;
+	}
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_ML_DSA_SEED,
+			op->keygen.seed.data, op->keygen.seed.length)) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_KEYPAIR, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+	OSSL_PARAM_free(params);
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	/* extract public and private keys */
+	if (EVP_PKEY_todata(pkey, EVP_PKEY_KEYPAIR, &params) != 1) {
+		OPENSSL_LOG(ERR, "Failed to convert to key pairs");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	p = OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_PRIV_KEY);
+	if (p == NULL) {
+		OPENSSL_LOG(ERR, "Failed to locate private key");
+		OSSL_PARAM_free(params);
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	OSSL_PARAM_get_octet_string(p, &key,
+		rte_crypto_ml_dsa_privkey_size[sess->u.ml_dsa.type], &keylen);
+	memcpy(op->keygen.privkey.data, key, keylen);
+	op->keygen.privkey.length = keylen;
+
+	p = OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_PUB_KEY);
+	if (p == NULL) {
+		OPENSSL_LOG(ERR, "Failed to locate public key");
+		OSSL_PARAM_free(params);
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	OSSL_PARAM_get_octet_string(p, &key,
+		rte_crypto_ml_dsa_pubkey_size[sess->u.ml_dsa.type], &keylen);
+	memcpy(op->keygen.pubkey.data, key, keylen);
+	op->keygen.pubkey.length = keylen;
+
+	OSSL_PARAM_free(params);
+	EVP_PKEY_free(pkey);
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return 0;
+}
+
+static int
+mldsa_sign_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_dsa_op *op = &cop->asym->mldsa;
+	EVP_PKEY_CTX *pctx = sess->u.ml_dsa.pctx;
+	const EVP_MD *check_md = NULL;
+	OSSL_PARAM_BLD *param_bld;
+	EVP_PKEY_CTX *cctx = NULL;
+	EVP_PKEY *pkey = NULL;
+	EVP_SIGNATURE *sigalg;
+	OSSL_PARAM *params;
+	const char *param;
+	unsigned char *md;
+	size_t siglen = 0;
+	size_t mdlen = 0;
+	int ret = -1;
+
+	param = ml_dsa_type_names[sess->u.ml_dsa.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_dsa type");
+		return -EINVAL;
+	}
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		(op->siggen.seed.length &&
+			!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_ML_DSA_SEED,
+			op->siggen.seed.data, op->siggen.seed.length)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_PRIV_KEY,
+			op->siggen.privkey.data, op->siggen.privkey.length)) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PRIVATE_KEY, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
+	if (cctx == NULL) {
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	sigalg = EVP_SIGNATURE_fetch(NULL, param, NULL);
+	if (sigalg == NULL) {
+		OPENSSL_LOG(ERR, "Failed to fetch signature algorithm");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_sign_message_init(cctx, sigalg, NULL) != 1) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (sess->u.ml_dsa.sign_deterministic) {
+		int deterministic = 1;
+		const OSSL_PARAM sign_params[] = {
+			OSSL_PARAM_int(OSSL_SIGNATURE_PARAM_DETERMINISTIC, &deterministic),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_sign_message_init(cctx, sigalg, sign_params) != 1) {
+			EVP_SIGNATURE_free(sigalg);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+	}
+
+	md = op->siggen.message.data;
+	mdlen = op->siggen.message.length;
+
+	if (op->siggen.mu.length) {
+		int has_mu = 1;
+		const OSSL_PARAM sign_params[] = {
+			OSSL_PARAM_int(OSSL_SIGNATURE_PARAM_MU, &has_mu),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_sign_message_init(cctx, sigalg, sign_params) != 1) {
+			EVP_SIGNATURE_free(sigalg);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+
+		md = op->siggen.mu.data;
+		mdlen = op->siggen.mu.length;
+	} else if (op->siggen.ctx.length) {
+		int has_ctx = 1;
+		const OSSL_PARAM sign_params[] = {
+			OSSL_PARAM_int(OSSL_SIGNATURE_PARAM_MESSAGE_ENCODING, &has_ctx),
+			OSSL_PARAM_octet_string(OSSL_SIGNATURE_PARAM_CONTEXT_STRING,
+				(void *)op->siggen.ctx.data, op->siggen.ctx.length),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_sign_message_init(cctx, sigalg, sign_params) != 1) {
+			EVP_SIGNATURE_free(sigalg);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+	}
+
+	EVP_SIGNATURE_free(sigalg);
+
+	switch (op->siggen.hash) {
+	case RTE_CRYPTO_AUTH_SHA3_224:
+		check_md = EVP_sha3_224();
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_256:
+		check_md = EVP_sha3_256();
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_384:
+		check_md = EVP_sha3_384();
+		break;
+	case RTE_CRYPTO_AUTH_SHA3_512:
+		check_md = EVP_sha3_512();
+		break;
+	case RTE_CRYPTO_AUTH_SHAKE_128:
+		check_md = EVP_shake128();
+		break;
+	case RTE_CRYPTO_AUTH_SHAKE_256:
+		check_md = EVP_shake256();
+		break;
+	default:
+		break;
+	}
+
+	if (op->siggen.hash != 0 && check_md == NULL) {
+		OPENSSL_LOG(ERR, "invalid hash type");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (check_md != NULL) {
+		if (EVP_PKEY_CTX_set_signature_md(cctx, check_md) != 1) {
+			OPENSSL_LOG(ERR, "Failed to set signature md");
+			EVP_PKEY_free(pkey);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+	}
+
+	if (EVP_PKEY_sign(cctx, NULL, &siglen, md, mdlen) != 1) {
+		OPENSSL_LOG(ERR, "Failed to determine output length");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (siglen > op->siggen.sign.length) {
+		OPENSSL_LOG(ERR, "Insufficient buffer for signature");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_sign(cctx, op->siggen.sign.data, &siglen, md, mdlen) != 1) {
+		OPENSSL_LOG(ERR, "Failed to sign");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	op->siggen.sign.length = siglen;
+
+	OSSL_PARAM_free(params);
+	EVP_PKEY_CTX_free(cctx);
+	EVP_PKEY_free(pkey);
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return ret;
+}
+
+static int
+mldsa_verify_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_dsa_op *op = &cop->asym->mldsa;
+	EVP_PKEY_CTX *pctx = sess->u.ml_dsa.pctx;
+	OSSL_PARAM_BLD *param_bld;
+	EVP_PKEY_CTX *cctx = NULL;
+	EVP_PKEY *pkey = NULL;
+	EVP_SIGNATURE *sigalg;
+	OSSL_PARAM *params;
+	const char *param;
+	unsigned char *md;
+	size_t mdlen = 0;
+	int ret = -1;
+
+	param = ml_dsa_type_names[sess->u.ml_dsa.type];
+	if (param == NULL) {
+		OPENSSL_LOG(ERR, "invalid ml_dsa type");
+		return -EINVAL;
+	}
+
+	param_bld = OSSL_PARAM_BLD_new();
+	if (param_bld == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (!OSSL_PARAM_BLD_push_utf8_string(param_bld,
+			OSSL_PKEY_PARAM_GROUP_NAME,
+			param, strlen(param)) ||
+		!OSSL_PARAM_BLD_push_octet_string(param_bld,
+			OSSL_PKEY_PARAM_PUB_KEY,
+			op->sigver.pubkey.data, op->sigver.pubkey.length)) {
+		OSSL_PARAM_BLD_free(param_bld);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	params = OSSL_PARAM_BLD_to_param(param_bld);
+	OSSL_PARAM_BLD_free(param_bld);
+	if (params == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata_init(pctx) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_fromdata(pctx, &pkey, EVP_PKEY_PUBLIC_KEY, params) != 1) {
+		OSSL_PARAM_free(params);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (pkey == NULL) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	cctx = EVP_PKEY_CTX_new_from_pkey(NULL, pkey, NULL);
+	if (cctx == NULL) {
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	sigalg = EVP_SIGNATURE_fetch(NULL, param, NULL);
+	if (sigalg == NULL) {
+		OPENSSL_LOG(ERR, "Failed to fetch signature algorithm");
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	if (EVP_PKEY_verify_message_init(cctx, sigalg, NULL) != 1) {
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return -1;
+	}
+
+	md = op->sigver.message.data;
+	mdlen = op->sigver.message.length;
+
+	if (op->sigver.mu.length) {
+		int has_mu = 1;
+		const OSSL_PARAM sign_params[] = {
+			OSSL_PARAM_int(OSSL_SIGNATURE_PARAM_MU, &has_mu),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_verify_message_init(cctx, sigalg, sign_params) != 1) {
+			EVP_SIGNATURE_free(sigalg);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+
+		md = op->sigver.mu.data;
+		mdlen = op->sigver.mu.length;
+	} else if (op->sigver.ctx.length) {
+		const OSSL_PARAM sign_params[] = {
+			OSSL_PARAM_octet_string(OSSL_SIGNATURE_PARAM_CONTEXT_STRING,
+				(void *)op->sigver.ctx.data, op->sigver.ctx.length),
+			OSSL_PARAM_END
+		};
+
+		if (EVP_PKEY_verify_message_init(cctx, sigalg, sign_params) != 1) {
+			EVP_SIGNATURE_free(sigalg);
+			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+			return -1;
+		}
+	}
+
+	if (EVP_PKEY_verify(cctx, op->sigver.sign.data, op->sigver.sign.length,
+		md, mdlen) != 1) {
+		EVP_PKEY_free(pkey);
+		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
+		return 0;
+	}
+
+	OSSL_PARAM_free(params);
+	EVP_PKEY_CTX_free(cctx);
+	EVP_PKEY_free(pkey);
+	ret = 0;
+	cop->status = RTE_CRYPTO_OP_STATUS_SUCCESS;
+	return ret;
+}
+
+static int
+process_openssl_mldsa_op_evp(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	struct rte_crypto_ml_dsa_op *op = &cop->asym->mldsa;
+	int ret = -1;
+
+	switch (op->op) {
+	case RTE_CRYPTO_ML_DSA_OP_KEYGEN:
+		ret = mldsa_keygen_op_evp(cop, sess);
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_SIGN:
+		ret = mldsa_sign_op_evp(cop, sess);
+		break;
+	case RTE_CRYPTO_ML_DSA_OP_VERIFY:
+		ret = mldsa_verify_op_evp(cop, sess);
+		break;
+	default:
+		cop->status = RTE_CRYPTO_OP_STATUS_INVALID_ARGS;
+		break;
+	}
+
+	return ret;
+}
+#else
+static int
+process_openssl_mlkem_op(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	RTE_SET_USED(cop);
+	RTE_SET_USED(sess);
+	return -ENOTSUP;
+}
+
+static int
+process_openssl_mldsa_op(struct rte_crypto_op *cop,
+		struct openssl_asym_session *sess)
+{
+	RTE_SET_USED(cop);
+	RTE_SET_USED(sess);
+	return -ENOTSUP;
+}
+#endif
+
 static int
 process_asym_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		struct openssl_asym_session *sess)
@@ -3450,6 +4306,20 @@ process_asym_op(struct openssl_qp *qp, struct rte_crypto_op *op,
 		retval = process_openssl_eddsa_op_evp(op, sess);
 #else
 		retval = process_openssl_eddsa_op(op, sess);
+#endif
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		retval = process_openssl_mlkem_op_evp(op, sess);
+#else
+		retval = process_openssl_mlkem_op(op, sess);
+#endif
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		retval = process_openssl_mldsa_op_evp(op, sess);
+#else
+		retval = process_openssl_mldsa_op(op, sess);
 #endif
 		break;
 	default:
diff --git a/drivers/crypto/openssl/rte_openssl_pmd_ops.c b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
index d3aa396c76..5095e6cbea 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd_ops.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd_ops.c
@@ -639,10 +639,81 @@ static const struct rte_cryptodev_capabilities openssl_pmd_capabilities[] = {
 		}
 		}
 	},
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+	{
+		/* ML-KEM */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_KEM,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_KEM_OP_KEYGEN) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_ENCAP) |
+				 (1 << RTE_CRYPTO_ML_KEM_OP_DECAP)),
+				.mlkem_capa = {
+					[RTE_CRYPTO_ML_KEM_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_ENCAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024),
+					[RTE_CRYPTO_ML_KEM_OP_DECAP] =
+						(1 << RTE_CRYPTO_ML_KEM_512) |
+						(1 << RTE_CRYPTO_ML_KEM_768) |
+						(1 << RTE_CRYPTO_ML_KEM_1024)
+				}
+			}
+		}
+	},
+	{
+		/* ML-DSA */
+		.op = RTE_CRYPTO_OP_TYPE_ASYMMETRIC,
+		.asym = {
+			.xform_capa = {
+				.xform_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA,
+				.op_types =
+				((1 << RTE_CRYPTO_ML_DSA_OP_SIGN) |
+#if (OPENSSL_VERSION_NUMBER >= 0x30500010)
+				 (1 << RTE_CRYPTO_ML_DSA_OP_KEYGEN) |
+#endif
+				 (1 << RTE_CRYPTO_ML_DSA_OP_VERIFY)),
+				.mldsa_capa = {
+					[RTE_CRYPTO_ML_DSA_OP_KEYGEN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_SIGN] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87),
+					[RTE_CRYPTO_ML_DSA_OP_VERIFY] =
+						(1 << RTE_CRYPTO_ML_DSA_44) |
+						(1 << RTE_CRYPTO_ML_DSA_65) |
+						(1 << RTE_CRYPTO_ML_DSA_87)
+				}
+			}
+		}
+	},
+#endif
 
 	RTE_CRYPTODEV_END_OF_CAPABILITIES_LIST()
 };
 
+const char *ml_kem_type_names[] = {
+	NULL,
+	"ML-KEM-512",
+	"ML-KEM-768",
+	"ML-KEM-1024",
+};
+
+const char *ml_dsa_type_names[] = {
+	NULL,
+	"ML-DSA-44",
+	"ML-DSA-65",
+	"ML-DSA-87",
+};
 
 /** Configure device */
 static int
@@ -1573,6 +1644,58 @@ static int openssl_set_asym_session_parameters(
 #else
 		OPENSSL_LOG(WARNING, "EdDSA unsupported for OpenSSL Version < 3.3");
 		return -ENOTSUP;
+#endif
+	}
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+	{
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		const char *param;
+
+		param = ml_kem_type_names[xform->mlkem.type];
+		if (param == NULL) {
+			OPENSSL_LOG(ERR, "invalid ml_kem type");
+			return -EINVAL;
+		}
+
+		asym_session->u.ml_kem.pctx = EVP_PKEY_CTX_new_from_name(NULL, param, NULL);
+		if (!asym_session->u.ml_kem.pctx) {
+			OPENSSL_LOG(ERR, "failed to allocate resources");
+			return -1;
+		}
+
+		asym_session->u.ml_kem.type = xform->mlkem.type;
+		asym_session->xfrm_type = RTE_CRYPTO_ASYM_XFORM_ML_KEM;
+		break;
+#else
+		OPENSSL_LOG(WARNING, "ML-KEM unsupported for OpenSSL Version < 3.5");
+		return -ENOTSUP;
+#endif
+	}
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+	{
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		const char *param;
+
+		param = ml_dsa_type_names[xform->mldsa.type];
+		if (param == NULL) {
+			OPENSSL_LOG(ERR, "invalid ml_dsa type");
+			return -EINVAL;
+		}
+
+		asym_session->u.ml_dsa.pctx = EVP_PKEY_CTX_new_from_name(NULL, param, NULL);
+		if (!asym_session->u.ml_dsa.pctx) {
+			OPENSSL_LOG(ERR, "failed to allocate resources");
+			return -1;
+		}
+
+		asym_session->u.ml_dsa.type = xform->mldsa.type;
+		asym_session->u.ml_dsa.sign_prehash = xform->mldsa.sign_prehash;
+		asym_session->u.ml_dsa.sign_deterministic = xform->mldsa.sign_deterministic;
+		asym_session->xfrm_type = RTE_CRYPTO_ASYM_XFORM_ML_DSA;
+		break;
+#else
+		OPENSSL_LOG(WARNING, "ML-DSA unsupported for OpenSSL Version < 3.5");
+		return -ENOTSUP;
 #endif
 	}
 	default:
@@ -1675,6 +1798,16 @@ static void openssl_reset_asym_session(struct openssl_asym_session *sess)
 	case RTE_CRYPTO_ASYM_XFORM_EDDSA:
 #if (OPENSSL_VERSION_NUMBER >= 0x30300000L)
 		OSSL_PARAM_free(sess->u.eddsa.params);
+#endif
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_KEM:
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		EVP_PKEY_CTX_free(sess->u.ml_kem.pctx);
+#endif
+		break;
+	case RTE_CRYPTO_ASYM_XFORM_ML_DSA:
+#if (OPENSSL_VERSION_NUMBER >= 0x30500000L)
+		EVP_PKEY_CTX_free(sess->u.ml_dsa.pctx);
 #endif
 		break;
 	default:
-- 
2.37.1

