Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB324C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:15:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E167A40BA6;
	Fri, 25 Sep 2026 10:15:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 97BD740695
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:15:25 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4aCVR2352537; Fri, 25 Sep 2026 01:15:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
 dEwmfOzqiVHyh/jsZCkZyOdmWg+gNc5IEsz55deNsc=; b=iU0PlGCXQPngE+vct
 CVWJYx5h69AjXc8DZPR+h0+d36HP9rDK7VEqthTw+xxor7ctIF1vz5Cx00IRSEhZ
 rrIEd+1k4NiuYN8039HZiSAXjU5sqqInFKm/kIb7iXqAII286ON3ReSz8oo4XQWj
 zaikC3tFV8w+lVcVJ+yS2V48YjAvNFqkFB7uxqD9Po7xusxZdx4ZJPwpTb0hbARB
 kj1MzxXFoxPOVzLOt4mwrDT3rO3NvkweVj7rCNyFsQp2zGThx81F+uYDUIFA4NRL
 uQ/Iq8Mltxl3cnF/v60oblk6iJBSTzx3EJv6q8b6YouYHIQC51c3NsJnespaxL1M
 HVqjw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gw75buswr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 01:15:24 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 25 Sep 2026 01:15:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 25 Sep 2026 01:15:23 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id 639EC5B6954;
 Fri, 25 Sep 2026 01:15:20 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <adwivedi@marvell.com>,
 <anoobj@marvell.com>, <ktejasree@marvell.com>, <kai.ji@intel.com>,
 <jianjay.zhou@huawei.com>, <radu.nicolau@intel.com>,
 <gmuthukrishn@marvell.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [PATCH v3 1/8] crypto: add RSA-specific capability parameters
Date: Fri, 25 Sep 2026 08:14:53 +0000
Message-ID: <20260925081500.3848187-2-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925081500.3848187-1-ssarananaga@marvell.com>
References: <20260903082648.3610676-1-ssarananaga@marvell.com>
 <20260925081500.3848187-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=M5jYuCws c=1 sm=1 tr=0 ts=6ab62d9c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=VMsi7YCxyk3BJ-RhiD0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX8obCRA97+f7K
 FN6z+SxjRBJLM3nPGT29LQ47s75uMaZONNpKEqaDFjTUEJCfLscjA9OmQSi71SsB6I4o2LmGw+m
 U+BbsDZoTTdH/2PaRYdxIz2CFRbu+yE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMiBTYWx0ZWRfX00RxVx+rS1Bp
 DJN8HFdzrtRGKXPYdJJwIFkyb2SqpKzgHRiGrkBbjfOUnt1tNi6uMhk5ob1rXIirvuQKPNyD2Z2
 2lRFHUgnl5IdkzPADI796jeCBmRw9caiFyEUBZtmHRVkRQtuyZ2P2zCxRatgHRT/RvdX9uhFoLC
 jFpzCjhF20QM4erlgkSTLsfprGwUB4jysNZAMP3ASz70GWgGfBXkNbRgCBAV7eParsi9Vv4k1mn
 6fF/hGybwVppeFRw99OXJ6/zbQxd9rTkwSD3uhb+tozfOrjlZZI57g9GtuMIqGMfBKrsvi8xzs2
 vPULxLkKXQ9WgjEgrabrfGj0Jfjvt8kEcPz2kP06XvQDRPPfQ6kcNW1nDZ6bNyXLQajdTC+p50d
 11HcbZKkiBvuIYRMOwsU12qIAY+x+NUflbMFO2dgj33b1j4CFUK/7MkY1Qv8ffL4e0F/fItGvr1
 nJndsGv7H2is9yb/kAw==
X-Proofpoint-GUID: vZdrypoyNK5X2GnN8j8ftg4rLdoexXDc
X-Proofpoint-ORIG-GUID: vZdrypoyNK5X2GnN8j8ftg4rLdoexXDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
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
today's internally-generated-salt behavior unchanged.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 doc/guides/rel_notes/release_26_11.rst | 16 +++++++++
 lib/cryptodev/rte_crypto_asym.h        | 18 ++++++++++
 lib/cryptodev/rte_cryptodev.h          | 50 ++++++++++++++++++++++++--
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 938617ca75..48f7722686 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -24,6 +24,15 @@ DPDK Release 26.11
 New Features
 ------------
 
+* **Added RSA-specific capability parameters in cryptodev.**
+
+  Added ``rte_crypto_rsa_capa`` to report RSA modulus length, supported
+  padding schemes, and MGF1 hash algorithms. Also added
+  ``pss_explicit_salt`` so a PMD can advertise support for an
+  application-supplied RSA-PSS salt, along with the corresponding
+  ``pss_salt`` field in ``rte_crypto_rsa_op_param`` to carry it per
+  sign operation.
+
 .. This section should contain new features added in this release.
    Sample format:
 
@@ -88,6 +97,13 @@ API Changes
 ABI Changes
 -----------
 
+* cryptodev: The struct ``rte_cryptodev_asymmetric_xform_capability`` is
+  updated to include ``rsa_capa``, a new ``rte_crypto_rsa_capa`` field for
+  reporting RSA modulus length, padding schemes, and MGF1 hash algorithms.
+
+* cryptodev: The struct ``rte_crypto_rsa_op_param`` is updated to include
+  ``pss_salt``, allowing an application to supply an explicit RSA-PSS salt.
+
 .. This section should contain ABI changes. Sample format:
 
    * sample: Add a short 1-2 sentence description of the ABI change
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

