Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D633CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 17:57:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99E6540DCF;
	Wed,  1 Oct 2025 19:57:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EB588400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 19:57:12 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591CfbBu010322;
 Wed, 1 Oct 2025 10:57:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
 z0Czguk1d1i/bfI7EwF18pOEvvrBg1a34N9VoyUsV4=; b=E51amFwudtQEaQf/a
 /h4/USJy6B3dmALkDc8A5tTBf00PVRRwq9bmX+qzJ4n9Sa8sVE44Zh/GPv06JR3n
 TcP9TVOKOQpjcSYrgFrsMd9OZROdw2CNraPA2+4kwWr7+VogxliW60IocojAJseq
 d8OtcN9QGjZv+WJ0JUchDKoM978jJw7ICX4PJu2rHz9Zacpdx4HLbR7anxfQZ63f
 mlgLBIKURiegE5yYNoZO2n5devLQGp2z+7dHTnA6aUqJcmudV80BhJeXvKB31VvQ
 wWRZPeEiPJE8bfTodRKCZNSw+0e1uq03sm1rGRX2sNOG6qazTam43Sxzt+7wXHdY
 9A23A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49grx0thfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Oct 2025 10:57:11 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Oct 2025 10:57:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Oct 2025 10:57:19 -0700
Received: from IN-lckQE5Rwctls.marvell.com (unknown [10.193.79.12])
 by maili.marvell.com (Postfix) with ESMTP id A8BA15B693B;
 Wed,  1 Oct 2025 10:57:08 -0700 (PDT)
From: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
To: <dev@dpdk.org>, Akhil Goyal <gakhil@marvell.com>, Fan Zhang
 <fanzhang.oss@gmail.com>, Kai Ji <kai.ji@intel.com>
CC: <anoobj@marvell.com>, Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>
Subject: [PATCH v3 1/3] cryptodev: support PQC ML algorithms
Date: Wed, 1 Oct 2025 23:26:51 +0530
Message-ID: <20251001175658.2303-2-gmuthukrishn@marvell.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251001175658.2303-1-gmuthukrishn@marvell.com>
References: <20251001073758.1295-1-gmuthukrishn@marvell.com>
 <20251001175658.2303-1-gmuthukrishn@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDIxMyBTYWx0ZWRfX5dMEu9JH2f0V
 CKRhyPYyjOM6WgYH0/i/OersiK1zG2W1j+cg28N8pog3iJvVMD2ERhympMNEpacHCxE0JfaiPoF
 S3G2Y5AMRpPxXvtqdu2nJKwZ8aOP/wvH+oqwEatNuyhYO+Ux+Ex4YF6IywTkGgVeFwZODHBGNm3
 JH9dBaoqpPYtlsOKmJuynKntQ1e4iJyhqV0977N6gCA2eNhv2b8RiG5tnOg8ZOUDFUfalBQ4JC3
 rRh9s/YLG/wxT96PZwBT//bish9GrklN3o7fNMJL4mrjSwZGXjrnkV+UZmo41zUzTXqoO9HPRzp
 2/wAsTJtC6OA/pmp+Mpz+crvvHKKf4NjisIpgozkRTvK5Ih5ov3CSCgdoKq9E9CMOdRK06rsVdK
 bO3El4clD0kI+wHbl3FvpqoWm83Z5w==
X-Proofpoint-GUID: NmYSpScgxlefLLzqPdIbYmYBswO7O6yL
X-Proofpoint-ORIG-GUID: NmYSpScgxlefLLzqPdIbYmYBswO7O6yL
X-Authority-Analysis: v=2.4 cv=QtZTHFyd c=1 sm=1 tr=0 ts=68dd6b77 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=ycAqupunDWhcI6OXPpcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
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
 doc/guides/cryptodevs/features/default.ini |   2 +
 doc/guides/prog_guide/cryptodev_lib.rst    |   3 +-
 doc/guides/rel_notes/release_25_11.rst     |  11 +
 lib/cryptodev/rte_crypto_asym.h            | 306 +++++++++++++++++++++
 lib/cryptodev/rte_cryptodev.c              |  60 ++++
 lib/cryptodev/rte_cryptodev.h              |  15 +-
 6 files changed, 394 insertions(+), 3 deletions(-)

diff --git a/doc/guides/cryptodevs/features/default.ini b/doc/guides/cryptodevs/features/default.ini
index 116ffce249..64198f013a 100644
--- a/doc/guides/cryptodevs/features/default.ini
+++ b/doc/guides/cryptodevs/features/default.ini
@@ -134,6 +134,8 @@ ECPM                    =
 ECDH                    =
 SM2                     =
 EdDSA                   =
+ML-DSA                  =
+ML-KEM                  =
 
 ;
 ; Supported Operating systems of a default crypto driver.
diff --git a/doc/guides/prog_guide/cryptodev_lib.rst b/doc/guides/prog_guide/cryptodev_lib.rst
index b54efcb74e..f0ee44eb54 100644
--- a/doc/guides/prog_guide/cryptodev_lib.rst
+++ b/doc/guides/prog_guide/cryptodev_lib.rst
@@ -928,7 +928,8 @@ Asymmetric Cryptography
 The cryptodev library currently provides support for the following asymmetric
 Crypto operations; RSA, Modular exponentiation and inversion, Diffie-Hellman and
 Elliptic Curve Diffie-Hellman public and/or private key generation and shared
-secret compute, DSA and EdDSA signature generation and verification.
+secret compute, DSA and EdDSA signature generation and verification,
+PQC ML-KEM and ML-DSA algorithms.
 
 Session and Session Management
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index c3b94e1896..9d47f762d7 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -76,6 +76,14 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Added PQC ML-KEM and ML-DSA support.**
+
+  * Added PQC ML-KEM support with reference to FIPS203.
+  * Added PQC ML-DSA support with reference to FIPS204.
+
+* **Updated openssl crypto driver.**
+
+  * Added support for PQC ML-KEM and ML-DSA algorithms.
 
 Removed Items
 -------------
@@ -138,6 +146,9 @@ ABI Changes
 * stack: The structure ``rte_stack_lf_head`` alignment has been updated to 16 bytes
   to avoid unaligned accesses.
 
+* cryptodev: The enum ``rte_crypto_asym_xform_type``, struct ``rte_crypto_asym_xform``
+  and struct ``rte_crypto_asym_op`` are updated to include new values to support
+  ML-KEM and ML-DSA.
 
 Known Issues
 ------------
diff --git a/lib/cryptodev/rte_crypto_asym.h b/lib/cryptodev/rte_crypto_asym.h
index 9787b710e7..14a0e57467 100644
--- a/lib/cryptodev/rte_crypto_asym.h
+++ b/lib/cryptodev/rte_crypto_asym.h
@@ -37,6 +37,20 @@ rte_crypto_asym_ke_strings[];
 extern const char *
 rte_crypto_asym_op_strings[];
 
+/** PQC ML crypto op parameters size */
+extern const uint16_t
+rte_crypto_ml_kem_pubkey_size[];
+extern const uint16_t
+rte_crypto_ml_kem_privkey_size[];
+extern const uint16_t
+rte_crypto_ml_kem_cipher_size[];
+extern const uint16_t
+rte_crypto_ml_dsa_pubkey_size[];
+extern const uint16_t
+rte_crypto_ml_dsa_privkey_size[];
+extern const uint16_t
+rte_crypto_ml_dsa_sign_size[];
+
 #ifdef __cplusplus
 }
 #endif
@@ -144,6 +158,14 @@ enum rte_crypto_asym_xform_type {
 	/**< Edwards Curve Digital Signature Algorithm
 	 * Perform Signature Generation and Verification.
 	 */
+	RTE_CRYPTO_ASYM_XFORM_ML_KEM,
+	/**< Module Lattice based Key Encapsulation Mechanism
+	 * Performs Key Pair Generation, Encapsulation and Decapsulation.
+	 */
+	RTE_CRYPTO_ASYM_XFORM_ML_DSA
+	/**< Module Lattice based Digital Signature Algorithm
+	 * Performs Key Pair Generation, Signature Generation and Verification.
+	 */
 };
 
 /**
@@ -720,6 +742,282 @@ struct rte_crypto_sm2_op_param {
 	 */
 };
 
+/**
+ * PQC ML-KEM algorithms
+ *
+ * List of ML-KEM algorithms used in PQC
+ */
+enum rte_crypto_ml_kem_param_set {
+	RTE_CRYPTO_ML_KEM_PARAM_NONE,
+	RTE_CRYPTO_ML_KEM_PARAM_512,
+	RTE_CRYPTO_ML_KEM_PARAM_768,
+	RTE_CRYPTO_ML_KEM_PARAM_1024,
+};
+
+/**
+ * PQC ML-KEM op types
+ *
+ * List of ML-KEM op types in PQC
+ */
+enum rte_crypto_ml_kem_op_type {
+	RTE_CRYPTO_ML_KEM_OP_KEYGEN,
+	RTE_CRYPTO_ML_KEM_OP_KEYVER,
+	RTE_CRYPTO_ML_KEM_OP_ENCAP,
+	RTE_CRYPTO_ML_KEM_OP_DECAP,
+	RTE_CRYPTO_ML_KEM_OP_END
+};
+
+/**
+ * PQC ML-KEM transform data
+ *
+ * Structure describing ML-KEM xform params
+ */
+struct rte_crypto_ml_kem_xform {
+	enum rte_crypto_ml_kem_param_set param;
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
+	 * - Refer `rte_crypto_ml_kem_pubkey_size` for size of buffer.
+	 */
+
+	rte_crypto_param dk;
+	/**<
+	 * Pointer to output data
+	 * - The computed decapsulation key.
+	 * - Refer `rte_crypto_ml_kem_privkey_size` for size of buffer.
+	 */
+};
+
+/**
+ * PQC ML-KEM KEYVER op
+ *
+ * Parameters for PQC ML-KEM key verification operation
+ */
+struct rte_crypto_ml_kem_keyver_op {
+	enum rte_crypto_ml_kem_op_type op;
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
+	/**< The message (of 32 bytes in length) for randomness.*/
+
+	rte_crypto_param ek;
+	/**< The encapsulation key.*/
+
+	rte_crypto_param cipher;
+	/**<
+	 * Pointer to output data
+	 * - The computed cipher.
+	 * - Refer `rte_crypto_ml_kem_cipher_size` for size of buffer.
+	 */
+
+	rte_crypto_param sk;
+	/**<
+	 * Pointer to output data
+	 * - The computed shared secret key (32 bytes).
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
+	 * - The computed shared secret key (32 bytes).
+	 */
+};
+
+/**
+ * PQC ML-KEM op
+ *
+ * Parameters for PQC ML-KEM operation
+ */
+struct rte_crypto_ml_kem_op {
+	enum rte_crypto_ml_kem_op_type op;
+	union {
+		struct rte_crypto_ml_kem_keygen_op keygen;
+		struct rte_crypto_ml_kem_keyver_op keyver;
+		struct rte_crypto_ml_kem_encap_op encap;
+		struct rte_crypto_ml_kem_decap_op decap;
+	};
+};
+
+/**
+ * PQC ML-DSA algorithms
+ *
+ * List of ML-DSA algorithms used in PQC
+ */
+enum rte_crypto_ml_dsa_param_set {
+	RTE_CRYPTO_ML_DSA_PARAM_NONE,
+	RTE_CRYPTO_ML_DSA_PARAM_44,
+	RTE_CRYPTO_ML_DSA_PARAM_65,
+	RTE_CRYPTO_ML_DSA_PARAM_87,
+};
+
+/**
+ * PQC ML-DSA op types
+ *
+ * List of ML-DSA op types in PQC
+ */
+enum rte_crypto_ml_dsa_op_type {
+	RTE_CRYPTO_ML_DSA_OP_KEYGEN,
+	RTE_CRYPTO_ML_DSA_OP_SIGN,
+	RTE_CRYPTO_ML_DSA_OP_VERIFY,
+	RTE_CRYPTO_ML_DSA_OP_END
+};
+
+/**
+ * PQC ML-DSA transform data
+ *
+ * Structure describing ML-DSA xform params
+ */
+struct rte_crypto_ml_dsa_xform {
+	enum rte_crypto_ml_dsa_param_set param;
+
+	bool sign_deterministic;
+	/**< The signature generated using deterministic method. */
+
+	bool sign_prehash;
+	/**< The signature generated using prehash or pure routine. */
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
+
+	rte_crypto_param pubkey;
+	/**<
+	 * Pointer to output data
+	 * - The computed public key.
+	 * - Refer `rte_crypto_ml_dsa_pubkey_size` for size of buffer.
+	 */
+
+	rte_crypto_param privkey;
+	/**<
+	 * Pointer to output data
+	 * - The computed secret key.
+	 * - Refer `rte_crypto_ml_dsa_privkey_size` for size of buffer.
+	 */
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
+	rte_crypto_param privkey;
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
+	 * - Refer `rte_crypto_ml_dsa_sign_size` for size of buffer.
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
+	enum rte_crypto_ml_dsa_op_type op;
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
@@ -751,6 +1049,12 @@ struct rte_crypto_asym_xform {
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
 
@@ -778,6 +1082,8 @@ struct rte_crypto_asym_op {
 		struct rte_crypto_ecpm_op_param ecpm;
 		struct rte_crypto_sm2_op_param sm2;
 		struct rte_crypto_eddsa_op_param eddsa;
+		struct rte_crypto_ml_kem_op mlkem;
+		struct rte_crypto_ml_dsa_op mldsa;
 	};
 	uint16_t flags;
 	/**<
diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index bb7bab4dd5..fd40c8a64c 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -229,6 +229,66 @@ const char *rte_crypto_asym_ke_strings[] = {
 	[RTE_CRYPTO_ASYM_KE_PUB_KEY_VERIFY] = "pub_ec_key_verify"
 };
 
+/**
+ * Public key size used in PQC ML-KEM based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_pubkey_size)
+const uint16_t rte_crypto_ml_kem_pubkey_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 800,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 1184,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 1568,
+};
+
+/**
+ * Private key size used in PQC ML-KEM based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_privkey_size)
+const uint16_t rte_crypto_ml_kem_privkey_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 1632,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 2400,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 3168,
+};
+
+/**
+ * Cipher size used in PQC ML-KEM based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_kem_cipher_size)
+const uint16_t rte_crypto_ml_kem_cipher_size[] = {
+	[RTE_CRYPTO_ML_KEM_PARAM_512] = 768,
+	[RTE_CRYPTO_ML_KEM_PARAM_768] = 1088,
+	[RTE_CRYPTO_ML_KEM_PARAM_1024] = 1568,
+};
+
+/**
+ * Public key size used in PQC ML-DSA based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_pubkey_size)
+const uint16_t rte_crypto_ml_dsa_pubkey_size[] = {
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 1312,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 1952,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 2592,
+};
+
+/**
+ * Private key size used in PQC ML-DSA based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_privkey_size)
+const uint16_t rte_crypto_ml_dsa_privkey_size[] = {
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 2560,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 4032,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 4896,
+};
+
+/**
+ * Sign size used in PQC ML-KEM based crypto ops.
+ */
+RTE_EXPORT_SYMBOL(rte_crypto_ml_dsa_sign_size)
+const uint16_t rte_crypto_ml_dsa_sign_size[] = {
+	[RTE_CRYPTO_ML_DSA_PARAM_44] = 2420,
+	[RTE_CRYPTO_ML_DSA_PARAM_65] = 3309,
+	[RTE_CRYPTO_ML_DSA_PARAM_87] = 4627,
+};
+
 struct rte_cryptodev_sym_session_pool_private_data {
 	uint16_t sess_data_sz;
 	/**< driver session data size */
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index eaf0e50d37..37a6a5e49b 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -167,10 +167,13 @@ struct rte_cryptodev_asymmetric_xform_capability {
 	uint32_t op_types;
 	/**<
 	 * Bitmask for supported rte_crypto_asym_op_type or
+	 * rte_crypto_ml_kem_op_type or rte_crypto_ml_dsa_op_type or
 	 * rte_crypto_asym_ke_type. Which enum is used is determined
 	 * by the rte_crypto_asym_xform_type. For key exchange algorithms
-	 * like Diffie-Hellman it is rte_crypto_asym_ke_type, for others
-	 * it is rte_crypto_asym_op_type.
+	 * like Diffie-Hellman it is rte_crypto_asym_ke_type,
+	 * for ML-KEM algorithms it is rte_crypto_ml_kem_op_type,
+	 * for ML-DSA algorithms it is rte_crypto_ml_dsa_op_type,
+	 * or others it is rte_crypto_asym_op_type.
 	 */
 
 	__extension__
@@ -188,6 +191,12 @@ struct rte_cryptodev_asymmetric_xform_capability {
 
 		uint32_t op_capa[RTE_CRYPTO_ASYM_OP_LIST_END];
 		/**< Operation specific capabilities. */
+
+		uint32_t mlkem_capa[RTE_CRYPTO_ML_KEM_OP_END];
+		/**< Bitmask of supported ML-KEM parameter sets. */
+
+		uint32_t mldsa_capa[RTE_CRYPTO_ML_DSA_OP_END];
+		/**< Bitmask of supported ML-DSA parameter sets. */
 	};
 
 	uint64_t hash_algos;
@@ -577,6 +586,8 @@ rte_cryptodev_asym_get_xform_string(enum rte_crypto_asym_xform_type xform_enum);
 /**< Support inner checksum computation/verification */
 #define RTE_CRYPTODEV_FF_SECURITY_RX_INJECT		(1ULL << 28)
 /**< Support Rx injection after security processing */
+#define RTE_CRYPTODEV_FF_MLDSA_SIGN_PREHASH		(1ULL << 29)
+/**< Support Pre Hash ML-DSA Signature Generation */
 
 /**
  * Get the name of a crypto device feature flag
-- 
2.37.1

