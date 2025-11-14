Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FDFCE8D4F
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:20:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD8E941060;
	Fri, 14 Nov 2025 17:20:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D5BAC40F35
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763137245; x=1794673245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PyLwc4grfqm9eVSzv4CaJAeTXvqORTw3fTaYdWL0OS0=;
 b=CzLgbiWW5fTrk2xXaIW/gEmj34ZFAwj0XlXGxfHkcacVZ0J19V0/zkwO
 Q6Tn8tQKbM5viIHNNqPVhA+CYOAAQh+rbda8/3n0EUZPUOtC5x2RRGssA
 W3Ds7rhP0p8nNXXD0TeHGYHxS+38ffbjbU6CJp6Gz2bEKZm7OQAHcULcV
 3yHyutr3hPNY8iqh+/tfXKfFSMwNTWl+XZ1CiQKY29LBVFhM1CxBmGLPd
 Kbqbpl0bY/lwHW/zE8hnUC0n9B9OYHYYGgvHLXLqXuUieIy+aEKBryuxx
 kNLV9ujFZuoBNw1FMnMRcn7crX53rTaHe7iAViE3SLq5LQQkwBCOd7lvt Q==;
X-CSE-ConnectionGUID: MUMzFUFzRteo6OfCm2DLTA==
X-CSE-MsgGUID: eo92Vhc1Tz6MtNg2ZNwBNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="64942181"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="64942181"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 08:20:44 -0800
X-CSE-ConnectionGUID: koBmxySYQ9Gj0hg28v1BKg==
X-CSE-MsgGUID: OsD32Vu6QQO+73z9yl2vTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189458926"
Received: from silpixa00401454.ir.intel.com ([10.20.224.230])
 by fmviesa007.fm.intel.com with ESMTP; 14 Nov 2025 08:20:43 -0800
From: Emma Finn <emma.finn@intel.com>
To: Akhil Goyal <gakhil@marvell.com>,
	Fan Zhang <fanzhang.oss@gmail.com>
Cc: dev@dpdk.org,
	Emma Finn <emma.finn@intel.com>
Subject: [v4] test/crypto: add AES-CCM test case with 32-byte AAD
Date: Fri, 14 Nov 2025 16:20:35 +0000
Message-ID: <20251114162036.170466-1-emma.finn@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112101911.2377840-2-emma.finn@intel.com>
References: <20251112101911.2377840-2-emma.finn@intel.com>
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

Add new test case that validates AES-CCM operations with
a 32-byte AAD. This test case specifically verifies the
handling of larger AAD length with smaller authentication
tags.

Signed-off-by: Emma Finn <emma.finn@intel.com>
---
 app/test/test_cryptodev.c                   | 16 +++++++
 app/test/test_cryptodev_aead_test_vectors.h | 53 +++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 6e5f308e55..9bdd357727 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -14271,6 +14271,12 @@ test_AES_CCM_authenticated_encryption_test_case_128_3(void)
 	return test_authenticated_encryption(&ccm_test_case_128_3);
 }
 
+static int
+test_AES_CCM_authenticated_encryption_test_case_128_4(void)
+{
+	return test_authenticated_encryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_decryption_test_case_128_1(void)
 {
@@ -14289,6 +14295,12 @@ test_AES_CCM_authenticated_decryption_test_case_128_3(void)
 	return test_authenticated_decryption(&ccm_test_case_128_3);
 }
 
+static int
+test_AES_CCM_authenticated_decryption_test_case_128_4(void)
+{
+	return test_authenticated_decryption(&ccm_test_case_128_4);
+}
+
 static int
 test_AES_CCM_authenticated_encryption_test_case_192_1(void)
 {
@@ -18975,6 +18987,8 @@ static struct unit_test_suite cryptodev_aes_ccm_auth_testsuite  = {
 			test_AES_CCM_authenticated_encryption_test_case_128_2),
 		TEST_CASE_ST(ut_setup, ut_teardown,
 			test_AES_CCM_authenticated_encryption_test_case_128_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_AES_CCM_authenticated_encryption_test_case_128_4),
 
 		/** AES CCM Authenticated Decryption 128 bits key*/
 		TEST_CASE_ST(ut_setup, ut_teardown,
@@ -18983,6 +18997,8 @@ static struct unit_test_suite cryptodev_aes_ccm_auth_testsuite  = {
 			test_AES_CCM_authenticated_decryption_test_case_128_2),
 		TEST_CASE_ST(ut_setup, ut_teardown,
 			test_AES_CCM_authenticated_decryption_test_case_128_3),
+		TEST_CASE_ST(ut_setup, ut_teardown,
+			test_AES_CCM_authenticated_decryption_test_case_128_4),
 
 		/** AES CCM Authenticated Encryption 192 bits key */
 		TEST_CASE_ST(ut_setup, ut_teardown,
diff --git a/app/test/test_cryptodev_aead_test_vectors.h b/app/test/test_cryptodev_aead_test_vectors.h
index 73bedaf557..6b9642e339 100644
--- a/app/test/test_cryptodev_aead_test_vectors.h
+++ b/app/test/test_cryptodev_aead_test_vectors.h
@@ -50,6 +50,13 @@ static uint8_t ccm_aad_test_2[22] = {
 		0xA5, 0xB8, 0xFC, 0xBA, 0x00, 0x00
 };
 
+static uint8_t ccm_aad_test_4[32] = {
+		0xD2, 0x3D, 0xBD, 0xF2, 0x13, 0xAA, 0xD5, 0x03,
+		0xDB, 0xA5, 0x3E, 0x44, 0xBB, 0x1E, 0xD7, 0x19,
+		0x65, 0x2F, 0x37, 0xA0, 0x97, 0xD6, 0x5F, 0x59,
+		0x0B, 0xD1, 0xE6, 0xA4, 0xCC, 0x50, 0xEB, 0x62
+};
+
 static uint8_t sm4_gcm_aad_test_2[] = {
 		0x3f, 0x89, 0x42, 0x20
 };
@@ -3714,6 +3721,52 @@ static const struct aead_test_data ccm_test_case_128_3 = {
 	}
 };
 
+static const struct aead_test_data ccm_test_case_128_4 = {
+	.algo = RTE_CRYPTO_AEAD_AES_CCM,
+	.key = {
+		.data = {
+			0x2F, 0x55, 0xF2, 0xF8, 0x4E, 0x66, 0x5E, 0x4B,
+			0x1D, 0x56, 0x91, 0x62, 0x6C, 0xE7, 0xD4, 0xB8
+		},
+		.len = 16
+	},
+	.iv = {
+		.data = {
+			0x2C, 0x39, 0xBE, 0x24, 0xAF, 0xF4, 0xC1, 0x0E,
+			0x20, 0x26, 0x11, 0x49, 0x49
+		},
+		.len = 13
+	},
+	.aad = {
+		.data = ccm_aad_test_4,
+		.len = 32
+	},
+	.plaintext = {
+		.data = {
+			0xF5, 0x2A, 0xEC, 0xEF, 0x88, 0x73, 0x10, 0x11,
+			0xD0, 0x68, 0xCB, 0x8E, 0x82, 0xBE, 0xED, 0x68,
+			0xC1, 0xC6, 0xF2, 0xA5, 0x9E, 0x99, 0xF6, 0x3D,
+			0xDA, 0xEA, 0xA0, 0x49, 0xD0, 0xF4, 0x18, 0xC0
+		},
+		.len = 32
+	},
+	.ciphertext = {
+		.data = {
+			0x0F, 0x7B, 0x8A, 0x0D, 0x79, 0xB6, 0x1C, 0x93,
+			0x00, 0x26, 0x57, 0x52, 0xC8, 0x68, 0x30, 0xF6,
+			0x92, 0xA4, 0x9C, 0x86, 0x5E, 0x77, 0x51, 0x9C,
+			0x79, 0x15, 0x7C, 0xF3, 0x87, 0x27, 0x2A, 0x77
+		},
+		.len = 32
+	},
+	.auth_tag = {
+		.data = {
+			0x64, 0x2F, 0x58, 0x61
+		},
+		.len = 4
+	}
+};
+
 /** AES-CCM-192 Test Vectors */
 static const struct aead_test_data ccm_test_case_192_1 = {
 	.algo = RTE_CRYPTO_AEAD_AES_CCM,
-- 
2.43.0

