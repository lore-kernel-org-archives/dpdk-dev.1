Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A63AC61DD3
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 10:23:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C816402EE;
	Mon, 31 Aug 2026 12:23:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B7BAA402EE
 for <dev@dpdk.org>; Mon, 31 Aug 2026 12:23:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V860F6335102; Mon, 31 Aug 2026 03:23:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 S8lb02pfphLVf1om197Y2vESpzqjdPaywHzXkxpbhU=; b=QYQbtNULXwd+zr1B/
 FNHE9S02zFAaFaBoNFGinsgCEUUwYkO/ewwMNTDQsmR3POzCX7Db4xevikqaKGCZ
 558jI3HyDfSW/mLvVLv0xr5c0n3MhdyvJQrreNcMUCEjXDFrhEUgCvHM3fRxWooi
 lU5p65ZXBU97bdPdTbvBj/OC4h7upL7ifb9pTgkitq/S2oK/LrXoel26Sz0qWOp5
 AI9Q88ny1GjVlmZbRwqSp3wvHUD8e87HVxsXIly66Ae0mbyTcfwb5iVWiKYDvO7G
 +vIDJC+n5xlczCt8SkW3jAC6s6gm6NLiYTzl+xz9xkJx9xaC68pnR87A7qmCcdQ6
 atWkg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68j902-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 03:23:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 03:23:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 03:23:46 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 1A0B93F704C;
 Mon, 31 Aug 2026 03:23:42 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH 01/10] crypto: add RSA-specific capability parameters
Date: Mon, 31 Aug 2026 10:23:19 +0000
Message-ID: <20260831102328.2813604-2-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831102328.2813604-1-ssarananaga@marvell.com>
References: <20260831102328.2813604-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JTlY2mDTKX8dVCQy6OXQlvTluwkpypAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfX9TbzED36Oizp
 Yif96WCUhQhhk6nMOB6Wjt7sbAw8MFOlv8qb1NNOte1LlflXFgQ4acdxcTEgSb3gx3A8uqc6cT6
 D8Bw9KkqUiaosuRLUYI+hq36jC56NVWlV7K+RTrRlVNQ1DeEDtD7aXVI98iLpytFgd9OrjjTpJs
 +AJeJjf0AHwaY2VM3IyUooMz/fFZ84AJEBy6VABS3ZAmknF88gpoQUXZA6fpqbPdpyhT9y6SFJg
 v0YC4WNo2jYkL+KqK6svPEs60aQXtpIzD/ZcNb6D50DVPixW4BLsYz8qc3M2qp73Mv1+oArmeF5
 voz0KqkdHzGMLuPQmxwi+Env/vxcZ/f3pNjWFJF9fX/bDpJgLgxb33JD3QRQKMi722Css19TH1B
 A+FoP7lIOGsx5x8xemeQIiumHw9c65I8JyhVGk9qEltgId2MNklN99xbqOxlFthe4plouGDuYN6
 e+i+UHO9UGsw2ihAU/w==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a955633 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=rZqUvv7twwb5fXSi2VIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: JTlY2mDTKX8dVCQy6OXQlvTluwkpypAh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4OSBTYWx0ZWRfXysrqUHxrEHsE
 +So1gL7MQYIDGZf2OUbARz/PTElnk/9u7DjD3KN0OQ186ihu6w1Hdm2jm9HCobAUQuS4+GhuUsU
 Gu1AKHLnigxsXk88GkLX743H+0t89h4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
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

The existing asymmetric capability structure reports generic
modulus length and hash algorithm support, but it cannot
describe RSA-specific parameters required by OAEP and PSS.

RSA operations may support different padding schemes and MGF1
hash algorithms independent of the primary hash algorithm.
Applications currently have no standard way to discover these
capabilities from a PMD.

Add rsa_capa to report RSA modulus length, supported padding
schemes, and MGF1 hash algorithms. Keep hash_algos for reporting
primary digest support.

Also clarify that the generic modlen field applies to other
modulus-based transforms such as MODEXP, MODINV, DH, and DSA.

RSA-PSS signing also normally generates its salt internally, so
the same message never produces the same signature twice, making
it impossible to validate against fixed test vectors (e.g.
ACVP/CAVP SigGen).

Add pss_explicit_salt to rsa_capa so a PMD can
advertise support for an application-supplied PSS salt, and add
the corresponding pss_salt field to rte_crypto_rsa_op_param to
carry those bytes per sign operation. Leaving pss_salt unset keeps
today's internally-generated-salt behavior unchanged

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 lib/cryptodev/rte_crypto_asym.h | 18 ++++++++++++
 lib/cryptodev/rte_cryptodev.h   | 50 +++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/lib/cryptodev/rte_crypto_asym.h b/lib/cryptodev/rte_crypto_asym.h
index b1546d2b7c..808c5f323e 100644
--- a/lib/cryptodev/rte_crypto_asym.h
+++ b/lib/cryptodev/rte_crypto_asym.h
@@ -494,6 +494,24 @@ struct rte_crypto_rsa_op_param {
 	 * This could be validated and overwritten by the PMD
 	 * with the signature length.
 	 */
+
+	rte_crypto_param pss_salt;
+	/**<
+	 * Explicit RSA-PSS salt bytes, used only for
+	 * RTE_CRYPTO_ASYM_OP_SIGN with RTE_CRYPTO_RSA_PADDING_PSS.
+	 * Only valid if the PMD advertises
+	 * rte_crypto_rsa_capa::pss_explicit_salt == true.
+	 *
+	 * - pss_salt.data == NULL (default): PMD generates the salt
+	 *   internally.
+	 * - pss_salt.data != NULL: PMD uses these exact bytes as the
+	 *   salt. pss_salt.length must equal the session's
+	 *   pss_saltlen, otherwise the op completes with status
+	 *   RTE_CRYPTO_OP_STATUS_INVALID_ARGS.
+	 *
+	 * Ignored for RTE_CRYPTO_ASYM_OP_VERIFY (salt is recovered from
+	 * the signature itself) and for non-PSS padding.
+	 */
 };
 
 /**
diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index 37a6a5e49b..bdbd11ace5 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -157,6 +157,48 @@ struct rte_cryptodev_symmetric_capability {
 	};
 };
 
+/**
+ * RSA transform capability parameters.
+ *
+ * Used when rte_cryptodev_asymmetric_xform_capability::xform_type is
+ * RTE_CRYPTO_ASYM_XFORM_RSA. Advertises supported modulus lengths,
+ * MGF1 hash algorithms, and padding schemes.
+ *
+ * Primary hash algorithms for RSA operations (e.g. OAEP, PSS) are
+ * reported separately via hash_algos in
+ * rte_cryptodev_asymmetric_xform_capability.
+ */
+struct rte_crypto_rsa_capa {
+	struct rte_crypto_param_range modlen;
+	/**< Supported RSA modulus length range, in bytes.
+	 * A min, max, or increment value of 0 means no limit is
+	 * imposed for that field and the PMD default applies.
+	 */
+
+	bool pss_explicit_salt;
+	/**< Support for application-supplied RSA-PSS salt
+	 * (rte_crypto_rsa_op_param::pss_salt).
+	 * false (default): PMD always generates the salt internally.
+	 * true: PMD accepts an application-supplied salt.
+	 */
+
+	uint8_t pad_types;
+	/**< Bitmask of supported RSA padding schemes.
+	 * Each bit corresponds to enum rte_crypto_rsa_padding_type.
+	 * A value of 0 means padding capability is not reported and the PMD
+	 * default may apply.
+	 */
+
+	uint64_t mgf1_hash_algos;
+	/**< Bitmask of hash algorithms supported for MGF1 mask generation.
+	 * Each bit corresponds to enum rte_crypto_auth_algorithm.
+	 * Used for RSA-OAEP and RSA-PSS when MGF1 may use a digest
+	 * different from the primary hash.
+	 * A value of 0 means MGF1 capability is not reported and the PMD
+	 * default may apply.
+	 */
+};
+
 /**
  * Asymmetric Xform Crypto Capability
  */
@@ -179,8 +221,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
 	__extension__
 	union {
 		struct rte_crypto_param_range modlen;
-		/**< Range of modulus length supported by modulus based xform.
-		 * Value 0 mean implementation default
+		/**< Range of modulus length supported by modulus based xform
+		 * such as MODEXP, MODINV, DH, and DSA.
+		 * Value 0 means implementation default.
 		 */
 
 		uint8_t internal_rng;
@@ -197,6 +240,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
 
 		uint32_t mldsa_capa[RTE_CRYPTO_ML_DSA_OP_END];
 		/**< Bitmask of supported ML-DSA parameter sets. */
+
+		struct rte_crypto_rsa_capa rsa_capa;
+		/**< RSA modulus length, MGF1 hash, and padding capabilities. */
 	};
 
 	uint64_t hash_algos;
-- 
2.54.0

