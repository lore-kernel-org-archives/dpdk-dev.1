Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24600CA0FF2
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 07:07:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 411394067D;
	Thu, 28 Aug 2025 09:07:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E431D4027D
 for <dev@dpdk.org>; Thu, 28 Aug 2025 09:07:04 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNW9fU012358;
 Thu, 28 Aug 2025 00:07:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=a5FQiH3M1Zh0V8MM7v3nCcN
 jX90qIX1/vtdK22xZ3DE=; b=jPiTqfhX1VAKquGY0zaHpCDR06g2PDCowFEDudN
 7vVRm2V/8rbn3zBw30ue7A8GxJ1tgM/1iHKOq/uPzZBiXxgmYMqTWPw3M7CztdGc
 Lo8/44oUImKHUOCGQBv4yW96m+I2KTYDnIWKe0eQ6kRLFgGrl73HshjS4AzD1eMD
 R/tIgLI3ufd3VZXyxBdU1xMYXXsgEicohOvyjXZRcotCyQe0rf/+BUNtEH6ZYDDF
 gz9a3iJ9eoh3TERuJ1geLxOW5jCV2L6TrRADOvQOWAavsZUMATVb4qGh4ysqP2Cu
 AzMF6WXgvQnY419S2lBZD7wrBTKziCYai1dNz5UTyK1ThLA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48tbs08x34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 00:07:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 28 Aug 2025 00:07:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 28 Aug 2025 00:07:01 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.79.82])
 by maili.marvell.com (Postfix) with ESMTP id 673075B6935;
 Thu, 28 Aug 2025 00:06:59 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [RFC] cryptodev: support PQC ML algorithms
Date: Thu, 28 Aug 2025 12:36:48 +0530
Message-ID: <20250828070657.8968-1-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDIwMCBTYWx0ZWRfX3akBzHkRB80D
 TLrhQfiJZ3T4HN0F82rygca3pCDl4fwwRsTVc1zdQx//j5P9st/ncRXWBEAL/rF+KN15knoEhi0
 ItzpLBVnWcf/2UamoTYJOyZi6LWoOUspQc7qWhxLBIKdpO/p8799xZhHWNXpBfSNpVVXFTkHIs6
 JEis6oK1g3TLPWBSyYqL0zZOVb4UVB+F17y7VGI/UQ41rR9Ob+g34+pUz/t0Df7OIXuuofzKYwp
 lYDbHjnfwlsdOuAPek2hp2Z3jsrKa7DF9dv2sVn+VAdpSSA3yn8m6L8mUMkJlFn7jNEyiK3yxG8
 MHeKJfZJNRe24U6Wi070wgXBEeSuoguLPrFQj4p07tzo1OvDXd/4XD+fES67ly8GDGGArytZRJz
 R/u0YMB/
X-Proofpoint-ORIG-GUID: rSfDnnLRD7gJ6ptzvlq3ZoBt4ZWms00q
X-Proofpoint-GUID: rSfDnnLRD7gJ6ptzvlq3ZoBt4ZWms00q
X-Authority-Analysis: v=2.4 cv=WPR/XmsR c=1 sm=1 tr=0 ts=68b00017 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=0j4SeiQUf95jvdEV658A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
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

Add support for PQC ML-KEM and ML-DSA algorithms.

Signed-off-by: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
---
 lib/cryptodev/rte_crypto_asym.h | 262 ++++++++++++++++++++++++++++++++
 lib/cryptodev/rte_cryptodev.c   |  39 +++++
 2 files changed, 301 insertions(+)

diff --git a/lib/cryptodev/rte_crypto_asym.h b/lib/cryptodev/rte_crypto_asym.h
index 9787b710e7..102dd4dc09 100644
--- a/lib/cryptodev/rte_crypto_asym.h
+++ b/lib/cryptodev/rte_crypto_asym.h
@@ -37,6 +37,14 @@ rte_crypto_asym_ke_strings[];
 extern const char *
 rte_crypto_asym_op_strings[];
 
+/** PQC ML crypto op parameters size */
+extern const uint16_t
+rte_crypto_ml_pubkey_size[];
+extern const uint16_t
+rte_crypto_ml_privkey_size[];
+extern const uint16_t
+rte_crypto_ml_output_size[];
+
 #ifdef __cplusplus
 }
 #endif
@@ -720,6 +728,252 @@ struct rte_crypto_sm2_op_param {
 	 */
 };
 
+/**
+ * PQC ML algorithms
+ *
+ * List of ML algorithms used in PQC
+ */
+enum rte_crypto_ml_param_set {
+	RTE_CRYPTO_ML_PARAM_NONE,
+	RTE_CRYPTO_ML_KEM_PARAM_512,
+	RTE_CRYPTO_ML_KEM_PARAM_768,
+	RTE_CRYPTO_ML_KEM_PARAM_1024,
+	RTE_CRYPTO_ML_DSA_PARAM_44,
+	RTE_CRYPTO_ML_DSA_PARAM_65,
+	RTE_CRYPTO_ML_DSA_PARAM_87,
+};
+
+/**
+ * PQC ML op types
+ *
+ * List of ML op types in PQC
+ */
+enum rte_crypto_ml_op {
+	RTE_CRYPTO_ML_OP_NONE,
+	RTE_CRYPTO_ML_KEM_OP_KEYGEN,
+	RTE_CRYPTO_ML_KEM_OP_KEYVER,
+	RTE_CRYPTO_ML_KEM_OP_ENCAP,
+	RTE_CRYPTO_ML_KEM_OP_DECAP,
+	RTE_CRYPTO_ML_DSA_OP_KEYGEN,
+	RTE_CRYPTO_ML_DSA_OP_SIGN,
+	RTE_CRYPTO_ML_DSA_OP_VERIFY,
+};
+
+/**
+ * PQC ML-KEM transform data
+ *
+ * Structure describing ML-KEM xform params
+ */
+struct rte_crypto_ml_kem_xform {
+	enum rte_crypto_ml_param_set param;
+};
+
+/**
+ * PQC ML-KEM KEYGEN op
+ *
+ * Parameters for PQC ML-KEM key generation operation
+ */
+struct rte_crypto_ml_kem_keygen_op {
+	rte_crypto_param d;
+	/**< The seed d value (of 32 bytes in length) to generate key pair.*/
+
+	rte_crypto_param z;
+	/**< The seed z value (of 32 bytes in length) to generate key pair.*/
+
+	rte_crypto_param ek;
+	/**<
+	 * Pointer to output data
+	 * - The computed encapsulation key.
+	 * - Refer `rte_crypto_ml_pubkey_size` for size of buffer.
+	 */
+
+	rte_crypto_param dk;
+	/**<
+	 * Pointer to output data
+	 * - The computed decapsulation key.
+	 * - Refer `rte_crypto_ml_privkey_size` for size of buffer.
+	 */
+};
+
+/**
+ * PQC ML-KEM KEYVER op
+ *
+ * Parameters for PQC ML-KEM key verification operation
+ */
+struct rte_crypto_ml_kem_keyver_op {
+	enum rte_crypto_ml_op op;
+	/**<
+	 * Op associated with key to be verified is one of below:
+	 * - Encapsulation op
+	 * - Decapsulation op
+	 */
+
+	rte_crypto_param key;
+	/**<
+	 * KEM key to check.
+	 * - ek in case of encapsulation op.
+	 * - dk in case of decapsulation op.
+	 */
+};
+
+/**
+ * PQC ML-KEM ENCAP op
+ *
+ * Parameters for PQC ML-KEM encapsulation operation
+ */
+struct rte_crypto_ml_kem_encap_op {
+	rte_crypto_param message;
+	/**< The message to be encapsulated.*/
+
+	rte_crypto_param ek;
+	/**< The encapsulation key.*/
+
+	rte_crypto_param cipher;
+	/**<
+	 * Pointer to output data
+	 * - The computed cipher.
+	 * - Refer `rte_crypto_ml_output_size` for size of buffer.
+	 */
+
+	rte_crypto_param sk;
+	/**<
+	 * Pointer to output data
+	 * - The computed shared secret key.
+	 * - Refer `rte_crypto_ml_pubkey_size` for size of buffer.
+	 */
+};
+
+/**
+ * PQC ML-KEM DECAP op
+ *
+ * Parameters for PQC ML-KEM decapsulation operation
+ */
+struct rte_crypto_ml_kem_decap_op {
+	rte_crypto_param cipher;
+	/**< The cipher to be decapsulated.*/
+
+	rte_crypto_param dk;
+	/**< The decapsulation key.*/
+
+	rte_crypto_param sk;
+	/**<
+	 * Pointer to output data
+	 * - The computed shared secret key.
+	 * - Refer `rte_crypto_ml_pubkey_size` for size of buffer.
+	 */
+};
+
+/**
+ * PQC ML-KEM op
+ *
+ * Parameters for PQC ML-KEM operation
+ */
+struct rte_crypto_ml_kem_op {
+	enum rte_crypto_ml_op op;
+	union {
+		struct rte_crypto_ml_kem_keygen_op keygen;
+		struct rte_crypto_ml_kem_keyver_op keyver;
+		struct rte_crypto_ml_kem_encap_op encap;
+		struct rte_crypto_ml_kem_decap_op decap;
+	};
+};
+
+/**
+ * PQC ML-DSA transform data
+ *
+ * Structure describing ML-DSA xform params
+ */
+struct rte_crypto_ml_dsa_xform {
+	enum rte_crypto_ml_param_set param;
+
+	bool random_seed;
+	/**< The signature generated using random seed (of 32 bytes in length). */
+
+	bool sign_prehash;
+	/**< The signature genearated using prehash or pure routine. */
+};
+
+/**
+ * PQC ML-DSA KEYGEN op
+ *
+ * Parameters for PQC ML-DSA key generation operation
+ */
+struct rte_crypto_ml_dsa_keygen_op {
+	rte_crypto_param seed;
+	/**< The random seed (of 32 bytes in length) to generate key pair.*/
+};
+
+/**
+ * PQC ML-DSA SIGGEN op
+ *
+ * Parameters for PQC ML-DSA sign operation
+ */
+struct rte_crypto_ml_dsa_siggen_op {
+	rte_crypto_param message;
+	/**< The message to generate signature.*/
+
+	rte_crypto_param mu;
+	/**< The mu to generate signature.*/
+
+	rte_crypto_param sk;
+	/**< The secret key to generate signature.*/
+
+	rte_crypto_param seed;
+	/**< The seed to generate signature.*/
+
+	rte_crypto_param ctx;
+	/**< The context key to generate signature.*/
+
+	enum rte_crypto_auth_algorithm hash;
+	/**< Hash function to generate signature. */
+
+	rte_crypto_param sign;
+	/**<
+	 * Pointer to output data
+	 * - The computed signature.
+	 * - Refer `rte_crypto_ml_output_size` for size of buffer.
+	 */
+};
+
+/**
+ * PQC ML-DSA SIGVER op
+ *
+ * Parameters for PQC ML-DSA verify operation
+ */
+struct rte_crypto_ml_dsa_sigver_op {
+	rte_crypto_param pubkey;
+	/**< The public key to verify signature.*/
+
+	rte_crypto_param message;
+	/**< The message used to verify signature.*/
+
+	rte_crypto_param sign;
+	/**< The signature to verify.*/
+
+	rte_crypto_param mu;
+	/**< The mu used to generate signature.*/
+
+	rte_crypto_param ctx;
+	/**< The context key to generate signature.*/
+
+	enum rte_crypto_auth_algorithm hash;
+	/**< Hash function to generate signature. */
+};
+
+/**
+ * PQC ML-DSA op
+ *
+ * Parameters for PQC ML-DSA operation
+ */
+struct rte_crypto_ml_dsa_op {
+	enum rte_crypto_ml_op op;
+	union {
+		struct rte_crypto_ml_dsa_keygen_op keygen;
+		struct rte_crypto_ml_dsa_siggen_op siggen;
+		struct rte_crypto_ml_dsa_sigver_op sigver;
+	};
+};
+
 /**
  * Asymmetric crypto transform data
  *
@@ -751,6 +1005,12 @@ struct rte_crypto_asym_xform {
 		/**< EC xform parameters, used by elliptic curve based
 		 * operations.
 		 */
+
+		struct rte_crypto_ml_kem_xform mlkem;
+		/**< PQC ML-KEM xform parameters */
+
+		struct rte_crypto_ml_dsa_xform mldsa;
+		/**< PQC ML-DSA xform parameters */
 	};
 };
 
@@ -778,6 +1038,8 @@ struct rte_crypto_asym_op {
 		struct rte_crypto_ecpm_op_param ecpm;
 		struct rte_crypto_sm2_op_param sm2;
 		struct rte_crypto_eddsa_op_param eddsa;
+		struct rte_crypto_ml_kem_op mlkem;
+		struct rte_crypto_ml_dsa_op mldsa;
 	};
 	uint16_t flags;
 	/**<
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..aeb6e1640d 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -229,6 +229,45 @@ const char *rte_crypto_asym_ke_strings[] = {
 	[RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY] = "pub_ec_key_verify"
 };
 
+/**
+ * Public key size used in PQC ML based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_pubkey_size)
+const uint16_t rte_crypto_ml_pubkey_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 800,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 1184,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 1568,
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 1312,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 1952,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 2592,
+};
+
+/**
+ * Private key size used in PQC ML based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_privkey_size)
+const uint16_t rte_crypto_ml_privkey_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 1632,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 2400,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 3168,
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 2560,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 4032,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 4896,
+};
+
+/**
+ * Output buffer size used in PQC ML based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_output_size)
+const uint16_t rte_crypto_ml_output_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 768,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 1088,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 1568,
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 2420,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 3309,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 4627,
+};
+
 struct rte_cryptodev_sym_session_pool_private_data {
 	uint16_t sess_data_sz;
 	/**< driver session data size */
-- 
2.37.1

