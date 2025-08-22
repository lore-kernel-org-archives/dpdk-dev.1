Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CD9CA0FE1
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 11:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CC9A4029A;
	Fri, 22 Aug 2025 13:13:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B3AB94028C
 for <dev@dpdk.org>; Fri, 22 Aug 2025 13:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755861197; x=1787397197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/w0j3lwfw9tYk9QtyN2vtr5BJwDS2i1lbztjgO5yfyU=;
 b=VkEbUPJgJLKcj258N86i3jKERMO68CdrjUyZiolz86od2/5y28IZJxOH
 MCxfCNl0rRGtoIQr/1n9qt/adsNGB8D/bKk1f5UhPcvrqkZ52TDeQIfFu
 F7OCG+wG4YfAPoB6GLKYfUauzUCeeMSbKT4TUdq40i+oGPwOF8Q+lpQ3k
 JWUcEaq4kkJGVOSNoJThRmlr3forQEUfJ5tuXkb3n3hRrIuEANSKzM0Za
 +5hPPXiZsK0Lt6/OiSswHSbbSR5sG2pT36tkOTA6dzticle9JGTNazkmZ
 +iTVdxLVy+OzQ0raMQamVz1R/BMhnC1j6gVzHgXbrT/Jykpd6DKIn0nXd Q==;
X-CSE-ConnectionGUID: IXrk0E2KS3SKi6VT1XnCMg==
X-CSE-MsgGUID: 6L8OrtFwQcWRy+rzoWg8fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69267767"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="69267767"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2025 04:13:16 -0700
X-CSE-ConnectionGUID: ZnM6Y6a3RHSZ0QKZlpNA1w==
X-CSE-MsgGUID: H8zv4b0DTISMTaAuZVS9dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168884137"
Received: from silpixa00400465.ir.intel.com (HELO
 silpixa00400465.ger.corp.intel.com) ([10.237.223.221])
 by orviesa008.jf.intel.com with ESMTP; 22 Aug 2025 04:13:14 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [dpdk-dev v9 1/3] cryptodev: add ec points to sm2 op
Date: Fri, 22 Aug 2025 11:13:06 +0000
Message-ID: <20250822111309.2506329-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104093610.20426-2-arkadiuszx.kusztal@intel.com>
References: <20241104093610.20426-2-arkadiuszx.kusztal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In the case when PMD cannot support the full process of the SM2,
but elliptic curve computation only, additional fields
are needed to handle such a case.

Points C1, kP therefore were added to the SM2 crypto operation struct.

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst |  2 +
 lib/cryptodev/rte_crypto_asym.h        | 56 +++++++++++++++++++-------
 2 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index ccad6d89ff..b15d2e0e8f 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -100,6 +100,8 @@ ABI Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* cryptodev: The ``rte_crypto_sm2_op_param`` struct member to hold ciphertext
+  is changed to union data type. This change is to support partial SM2 calculation.
 
 Known Issues
 ------------
diff --git a/lib/cryptodev/rte_crypto_asym.h b/lib/cryptodev/rte_crypto_asym.h
index 9787b710e7..039dcb85a7 100644
--- a/lib/cryptodev/rte_crypto_asym.h
+++ b/lib/cryptodev/rte_crypto_asym.h
@@ -654,6 +654,8 @@ enum rte_crypto_sm2_op_capa {
 	/**< Random number generator supported in SM2 ops. */
 	RTE_CRYPTO_SM2_PH,
 	/**< Prehash message before crypto op. */
+	RTE_CRYPTO_SM2_PARTIAL,
+	/**< Calculate elliptic curve points only. */
 };
 
 /**
@@ -681,20 +683,46 @@ struct rte_crypto_sm2_op_param {
 	 * will be overwritten by the PMD with the decrypted length.
 	 */
 
-	rte_crypto_param cipher;
-	/**<
-	 * Pointer to input data
-	 * - to be decrypted for SM2 private decrypt.
-	 *
-	 * Pointer to output data
-	 * - for SM2 public encrypt.
-	 * In this case the underlying array should have been allocated
-	 * with enough memory to hold ciphertext output (at least X bytes
-	 * for prime field curve of N bytes and for message M bytes,
-	 * where X = (C1 || C2 || C3) and computed based on SM2 RFC as
-	 * C1 (1 + N + N), C2 = M, C3 = N. The cipher.length field will
-	 * be overwritten by the PMD with the encrypted length.
-	 */
+	union {
+		rte_crypto_param cipher;
+		/**<
+		 * Pointer to input data
+		 * - to be decrypted for SM2 private decrypt.
+		 *
+		 * Pointer to output data
+		 * - for SM2 public encrypt.
+		 * In this case the underlying array should have been allocated
+		 * with enough memory to hold ciphertext output (at least X bytes
+		 * for prime field curve of N bytes and for message M bytes,
+		 * where X = (C1 || C2 || C3) and computed based on SM2 RFC as
+		 * C1 (1 + N + N), C2 = M, C3 = N. The cipher.length field will
+		 * be overwritten by the PMD with the encrypted length.
+		 */
+		struct {
+			struct rte_crypto_ec_point c1;
+			/**<
+			 * This field is used only when PMD does not support the full
+			 * process of the SM2 encryption/decryption, but the elliptic
+			 * curve part only.
+			 *
+			 * In the case of encryption, it is an output - point C1 = (x1,y1).
+			 * In the case of decryption, if is an input - point C1 = (x1,y1).
+			 *
+			 * Must be used along with the RTE_CRYPTO_SM2_PARTIAL flag.
+			 */
+			struct rte_crypto_ec_point kp;
+			/**<
+			 * This field is used only when PMD does not support the full
+			 * process of the SM2 encryption/decryption, but the elliptic
+			 * curve part only.
+			 *
+			 * It is an output in the encryption case, it is a point
+			 * [k]P = (x2,y2).
+			 *
+			 * Must be used along with the RTE_CRYPTO_SM2_PARTIAL flag.
+			 */
+		};
+	};
 
 	rte_crypto_uint id;
 	/**< The SM2 id used by signer and verifier. */
-- 
2.43.0

