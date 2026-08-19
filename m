Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE816C5DF85
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Aug 2026 07:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFF5A402DD;
	Wed, 19 Aug 2026 09:16:51 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BD11F40041
 for <dev@dpdk.org>; Wed, 19 Aug 2026 09:16:49 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67J6WqcW2725515; Wed, 19 Aug 2026 00:16:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 Of6dP0/KdOtTPQWI+UpJx3iYDp5K8YetCRCZyHvq2o=; b=ed3OH9PlejUlo+HBV
 QaScyzM+Ayhk132yRy6Pg8LDjo/zEKBzIHuAGd7AzZnYItRXJ1c2rcihZObbByu1
 SWanYNiqRXZvm8VIToYIj4zCDmQf3tf4s7PkPzCoAjJyEEoulcBx56xh2smtYj3h
 aXTthDxfT/lQUY169/oZdZwuENQEu7IvzjvSNCJtireAohcS7chRUjzieEAO2LZd
 LRDiVI253tRNsd8QpGUcGgfqv5TqjkBbxIiJw494ZFDUHj80/MRv5HT7eaop/Dud
 v14ra2BI6Ix90yklQYKsZ0SRVBTySqwhU2jdykX6UOB8jYdfy4aCJvQ+9tdMcOQx
 1lvWA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yew9pnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 00:16:48 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 19 Aug 2026 00:16:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 19 Aug 2026 00:16:47 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id D2F163F705E;
 Wed, 19 Aug 2026 00:16:44 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <gakhil@marvell.com>, <fanzhang.oss@gmail.com>, <radu.nicolau@intel.com>, 
 <gmuthukrishn@marvell.com>, <anoobj@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>
Subject: [PATCH v2] crypto: add RSA-specific capability parameters
Date: Wed, 19 Aug 2026 07:16:35 +0000
Message-ID: <20260819071635.4104361-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731091146.602320-1-ssarananaga@marvell.com>
References: <20260731091146.602320-1-ssarananaga@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UyvF1OGFQzRRnoxBU-Tb9WJvpZRdbc79
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA1MyBTYWx0ZWRfX12vQf6HiC2Bq
 keoqOxSvVuIsROhMurhuksz93QpDDoup3GnV0VQHFutH1GRcKsrIlUSkqP7S40H8EwG5i4H1TEm
 Q6eIDE79JMNk08vvuACvXjvGi1i2qjE=
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a855860 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=tIxvoA3mxl7b6XSbyz0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA1MyBTYWx0ZWRfX87b2+jIjbgAe
 iNGrFAUstcA+nfg6OdAo20228aK89IlbFzoZEYJhQ1b7gnxA6mtm0T6CfMuTL83hRycfAV/DrLa
 ySubv9BtjWKiCjVUAeBXYdKnau1+jkd2uifncsZnHzv1jFaBYBdAcHTYuwfH6JmPTMvi7saQQae
 CZQCHlcL2oc4Zm3jTrf9jBQA4p7UHEXQcQNKkhBChgWa1GsXnwUuBZpTOVrMGCOmegLLp4EhQoT
 JCc7dF3xICwQbR5QPiWFNHiqQuuqiD3r3uLCMx63F5Uq2gZ0+8IRUYWTkHwBYi7n/X0jZQZiEHX
 TDOrmVC2kpBruOi874b2WRFZUjkLV8eh9AfO5y7EjwxIulCvNEGuNWYjy4moMN2B/FcuzD/a8IJ
 wigrcAM77y7HZqZe/MPhM7ZyEYfc8F4c1oq2xOSktKZV0DpFXnhcVfgWMjqbnfrcTX/44bSc19G
 wUK6zooabcggS3auiPA==
X-Proofpoint-GUID: UyvF1OGFQzRRnoxBU-Tb9WJvpZRdbc79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_02,2026-08-18_01,2025-10-01_01
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

v2:
* Document zero-value semantics for pad_types and mgf1_hash_algos.
* Clarify that a zero capability value indicates the PMD does not
  report the capability and PMD defaults may apply.

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 lib/cryptodev/rte_cryptodev.h | 43 +++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index 37a6a5e49b..98f54c1184 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -157,6 +157,41 @@ struct rte_cryptodev_symmetric_capability {
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
+	/**< Supported RSA modulus length range, in bits.
+	 * A min, max, or increment value of 0 means no limit is
+	 * imposed for that field and the PMD default applies.
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
@@ -179,8 +214,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
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
@@ -197,6 +233,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
 
 		uint32_t mldsa_capa[RTE_CRYPTO_ML_DSA_OP_END];
 		/**< Bitmask of supported ML-DSA parameter sets. */
+
+		struct rte_crypto_rsa_capa rsa_capa;
+		/**< RSA modulus length, MGF1 hash, and padding capabilities. */
 	};
 
 	uint64_t hash_algos;
-- 
2.54.0

