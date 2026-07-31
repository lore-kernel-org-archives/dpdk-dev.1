Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB2C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 09:12:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDEC040288;
	Fri, 31 Jul 2026 11:11:59 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5DC6D40280
 for <dev@dpdk.org>; Fri, 31 Jul 2026 11:11:58 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V7uZs13162565; Fri, 31 Jul 2026 02:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=PqEa0AVdMzugVM0MUAWNLy1
 H3llcaZMrbsJbSNyGNto=; b=FGiGKVDn/rYjdl6b+rSx+DpiBltJdSsmTF048e6
 mk4lj1sKeLoOtDOLzBwMd36saJFqJqEo4EdcnNDWVB6d0CtRlEP39Glxa/DEn90J
 IWNwplaWzkPp1IZvy3k2qcYTHVEl15R3v+qGrVLSKpD/MuV9fj7jm2BGUzzdlQ7q
 nR+Mq9HmkgoPZ4FOxBwQzC8iVmUKpUG/VfBZMe3VezSt1ngltP24JmdVst0N+EA9
 QEVe+kpwBmJux+wBjYM9QTznMrtzkp7ThqMmPsN3lgVQSJbFVnuyp7YuJfj81SaF
 jr5Q5KkOvBf7mqnx9YV8Dhq1r0vE26VC5WT6pYONInUIitg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4frcw59x7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jul 2026 02:11:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 31 Jul 2026 02:11:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 31 Jul 2026 02:11:55 -0700
Received: from ssarananaga.marvell.com (unknown [10.29.57.26])
 by maili.marvell.com (Postfix) with ESMTP id CAAA63F704F;
 Fri, 31 Jul 2026 02:11:53 -0700 (PDT)
From: Sucharitha Sarananaga <ssarananaga@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <gakhil@marvell.com>, <gmuthukrishn@marvell.com>,
 <fanzhang.oss@gmail.com>, Sucharitha Sarananaga <ssarananaga@marvell.com>
Subject: [RFC PATCH] crypto: add RSA-specific capability parameters
Date: Fri, 31 Jul 2026 09:11:46 +0000
Message-ID: <20260731091146.602320-1-ssarananaga@marvell.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2NyBTYWx0ZWRfX0WB/sNqslTX6
 sH9o8WgMdPJYP9lR9XkeLHEoDOW7Ty7riMz8y/6SLpp04zH1Z+W9AIztFqgwSkzjrlxO0qLi5ri
 v6FrBlvxg0nwTKmWzb+p3cHJxxtaJsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2NyBTYWx0ZWRfX/lvak1Fv30zV
 8MegD6IIPkxIU8UWlU+k459OADllXxloUITdu6Rmr16TXdJkRPQbOqbyPvgYfIZhH844GpfsRLS
 8DRzQmTehVi8fy1cxA3X6ArNIygiww5jrwS7c64sYxCYtonU7LB7R9wXYaNO5VLGiYFT2px0+W/
 e864tUToyxnQPlQdS0/hMpNhlD/D48QfwNe/w1zurlmrLG5WhOBPwYrk3KkFvWCqhJ669PlJ+Vr
 lJcMApAqivSyATN0y1igJk0jjlrss1SPPNPkH5YdCcxRwuTo03rxsmuQKthX3EKQ4xl0QStthYm
 lSGSeOyj2GdSjYQuljgR+eIqQTCDB2KyUsQopIXfnfYYICqhUH9B3P1v5zLXOvNRYG4BzsHIODz
 5juSTCjZSmAMTl6gntqtLqnMiPFz0qmKHmHlwEw7BlxRqUX3gR2WSAN0r2M2ADrpjYOHvBZXUal
 kUXiSDq1cyaCptKwn6g==
X-Proofpoint-ORIG-GUID: gtWsrIO1yNsuWb2eF6s4oh2xhlQRJ1fq
X-Authority-Analysis: v=2.4 cv=C5bZDwP+ c=1 sm=1 tr=0 ts=6a6c66dd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=1bKD8B96pFte2-3mT60A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: gtWsrIO1yNsuWb2eF6s4oh2xhlQRJ1fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
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

Signed-off-by: Sucharitha Sarananaga <ssarananaga@marvell.com>
---
 lib/cryptodev/rte_cryptodev.h | 42 +++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/lib/cryptodev/rte_cryptodev.h b/lib/cryptodev/rte_cryptodev.h
index 37a6a5e49b..e577dd8553 100644
--- a/lib/cryptodev/rte_cryptodev.h
+++ b/lib/cryptodev/rte_cryptodev.h
@@ -157,6 +157,40 @@ struct rte_cryptodev_symmetric_capability {
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
+	 * A value of 0 means padding capability is not reported.
+	 */
+
+	uint64_t mgf1_hash_algos;
+	/**< Bitmask of hash algorithms supported for MGF1 mask generation.
+	 * Each bit corresponds to enum rte_crypto_auth_algorithm.
+	 * Used for RSA-OAEP and RSA-PSS when MGF1 may use a digest
+	 * different from the primary hash.
+	 * A value of 0 means MGF1 capability is not reported.
+	 */
+};
+
+
 /**
  * Asymmetric Xform Crypto Capability
  */
@@ -179,8 +213,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
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
@@ -197,6 +232,9 @@ struct rte_cryptodev_asymmetric_xform_capability {
 
 		uint32_t mldsa_capa[RTE_CRYPTO_ML_DSA_OP_END];
 		/**< Bitmask of supported ML-DSA parameter sets. */
+
+		struct rte_crypto_rsa_capa rsa_capa;
+		/**< RSA modulus length, MGF1 hash, and padding capabilities. */
 	};
 
 	uint64_t hash_algos;
-- 
2.54.0

