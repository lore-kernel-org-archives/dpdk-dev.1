Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C79C021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 08:16:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E0FF402D8;
	Wed, 26 Feb 2025 09:16:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 475FA4027C;
 Wed, 26 Feb 2025 09:16:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740557811; x=1772093811;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bM+pSUVm/pbqhDaoPk5M9ziNLzsol6H/EnPNvp2zJ3Y=;
 b=iFpOaZztt/6vyMz3X+CTOdeOZZmicnzoTs8I4Xzqss2LcCluqfaLaSCD
 sQ9kdJpyzt37achipWmX0c1r9trSYDLt6deYvDxf+hASOt8wiPOfwGmuG
 JRC3PVrWpUZTzeOlw8LUmxRARZyXCVRyBaCZy8ReiPlOuTa88IvIQjAmz
 RpoaKYzkRO0Buwa29CDWSWjxNtDUENEMapMfrmo/31aT0oAK1gsWancQi
 uNlVI6BFw74aSzIBXGJcOYN0BowoR2Y+586Tt+b5zR1K8z1CtMMHKlisL
 Fu0R9X92sszhSzoLJXDqEZ8D2C1fRJs0uF9L3Cp0c4oQP3Bm+MGz1ae85 w==;
X-CSE-ConnectionGUID: O0WkEJXaSIGzYIivcyK/mA==
X-CSE-MsgGUID: knsoHPb9StO8hsRnKvOsLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28984127"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="28984127"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 00:16:49 -0800
X-CSE-ConnectionGUID: VW6mK+30RP6/4I159qD2LA==
X-CSE-MsgGUID: Gxl2xcfzQEyprsviHHTtcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; d="scan'208";a="116829021"
Received: from silpixa00400465.ir.intel.com ([10.55.129.27])
 by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2025 00:16:47 -0800
From: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, brian.dooley@intel.com,
 Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>, stable@dpdk.org
Subject: [PATCH] app/test: fix the check of the oop header data
Date: Wed, 26 Feb 2025 08:16:45 +0000
Message-ID: <20250226081645.1415920-1-arkadiuszx.kusztal@intel.com>
X-Mailer: git-send-email 2.43.0
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

The data of the out-of-place header is never checked. Therefore,
the faulty PMD, which overwrites this data, will not be able to
verify that with tests. New checks to support that were added to
the GCM OOP functions.

Fixes: 51e202f0596f ("test/crypto: rename GCM test code")
Cc: stable@dpdk.org

Signed-off-by: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
---
 app/test/test_cryptodev.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 441ecc6ad5..6ef43a784d 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -13769,8 +13769,9 @@ test_authenticated_encryption_oop(const struct aead_test_data *tdata)
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
 
+	uint32_t i;
 	int retval;
-	uint8_t *ciphertext, *auth_tag;
+	uint8_t *ciphertext, *auth_tag, *buffer_oop;
 	uint16_t plaintext_pad_len;
 	struct rte_cryptodev_info dev_info;
 
@@ -13846,6 +13847,18 @@ test_authenticated_encryption_oop(const struct aead_test_data *tdata)
 			ut_params->op->sym->cipher.data.offset);
 	auth_tag = ciphertext + plaintext_pad_len;
 
+	/* Check if the data within the offset range is not overwritten in the OOP */
+	buffer_oop = rte_pktmbuf_mtod(ut_params->obuf, uint8_t *);
+	for (i = 0; i < ut_params->op->sym->cipher.data.offset; i++) {
+		if (buffer_oop[i]) {
+			RTE_LOG(ERR, USER1,
+				"Incorrect value of the output buffer header\n");
+			debug_hexdump(stdout, "Incorrect value:", buffer_oop,
+				ut_params->op->sym->cipher.data.offset);
+			return TEST_FAILED;
+		}
+	}
+
 	debug_hexdump(stdout, "ciphertext:", ciphertext, tdata->ciphertext.len);
 	debug_hexdump(stdout, "auth tag:", auth_tag, tdata->auth_tag.len);
 
@@ -13878,8 +13891,9 @@ test_authenticated_decryption_oop(const struct aead_test_data *tdata)
 	struct crypto_testsuite_params *ts_params = &testsuite_params;
 	struct crypto_unittest_params *ut_params = &unittest_params;
 
+	uint32_t i;
 	int retval;
-	uint8_t *plaintext;
+	uint8_t *plaintext, *buffer_oop;
 	struct rte_cryptodev_info dev_info;
 
 	rte_cryptodev_info_get(ts_params->valid_devs[0], &dev_info);
@@ -13957,6 +13971,17 @@ test_authenticated_decryption_oop(const struct aead_test_data *tdata)
 
 	debug_hexdump(stdout, "plaintext:", plaintext, tdata->ciphertext.len);
 
+	/* Check if the data within the offset range is not overwritten in the OOP */
+	buffer_oop = rte_pktmbuf_mtod(ut_params->obuf, uint8_t *);
+	for (i = 0; i < ut_params->op->sym->cipher.data.offset; i++) {
+		if (buffer_oop[i]) {
+			RTE_LOG(ERR, USER1,
+				"Incorrect value of the output buffer header\n");
+			debug_hexdump(stdout, "Incorrect value:", buffer_oop,
+				ut_params->op->sym->cipher.data.offset);
+			return TEST_FAILED;
+		}
+	}
 	/* Validate obuf */
 	TEST_ASSERT_BUFFERS_ARE_EQUAL(
 			plaintext,
-- 
2.43.0

