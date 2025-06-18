Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41359C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 12:54:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4504942DCE;
	Wed, 18 Jun 2025 14:54:21 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 4CD5142DA3;
 Wed, 18 Jun 2025 14:54:19 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ICMVCU003914;
 Wed, 18 Jun 2025 05:54:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 DABuyBlPP8plPBMjbZm8FAahbQjgTzRkJ+rUjdyivI=; b=XfnYXAjlDvncgd3rh
 SuYk/efXTw6U1NB1U65CyGCZrNk0RMJN7kgJePQF5IbnkO9EShtRRXBDK4oxVJdj
 vB5p56OnxS+Z1RE1JICNytmpuY6Ntqgy1/q9mWMwa1WJz+CsgnJoGH16smkY2yi/
 /nF4GdBuEkgYNJlXMqFn9E0CM0+vCGiMimTmlL8F6QANIkLzVUnyExZkJJugdA/z
 vSr1TSWVBwF1aYiUwpcLhVQB+QESFjtYuurMhS+8GHxnKPriALqHDlEOADnZw1dt
 mGWObHZqWi14IaVBhr4mJIRWr6kfU/yPwY/cCiheSehAqqAMinXDmg7DMn1Myd8e
 8g/0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bwdg01ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 05:54:18 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Jun 2025 05:54:17 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Jun 2025 05:54:17 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id DE0933F704A;
 Wed, 18 Jun 2025 05:54:14 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>, <stable@dpdk.org>
CC: <adwivedi@marvell.com>, <anoobj@marvell.com>, <ktejasree@marvell.com>,
 <gakhil@marvell.com>, <fanzhang.oss@gmail.com>
Subject: [PATCH 1/3] test/crypto: add ctr test cases and vectors
Date: Wed, 18 Jun 2025 12:54:07 +0000
Message-ID: <20250618125410.767919-2-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250618125410.767919-1-nkaithakadan@marvell.com>
References: <20250618125410.767919-1-nkaithakadan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Ga0XnRXL c=1 sm=1 tr=0 ts=6852b6fa cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=VChOnggKA0r09zR2SFAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: rsT8sNrY16sjwDeES_nxV0Glo2LFYTpT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEwOSBTYWx0ZWRfX1er39zCSSmWd
 vG/oCQUCwvNejpCCp2uZucTd76k6LBxxShOzzoixVyDcH2JSzDGPuaYGg1422bl2v3UHFOjs82M
 /lcPaFPd230mrb63tQfuPbNMcYlA1IVDdbPokDYQYcEn/MHwx7jksfPHJ6e90ZImAEYoOGgv+4c
 M8IxHPGjDYt/1wsof1g7f50soG0ok+FTCsmNrjJH7dzzCvyMCtS31rkOU0POqq8TfH66kiCe/Pq
 VKiKg7xbR21icRccgB2Fo4AIzBMNyVkgeNsxqIJB2h33/dCTBggTyAUcRu0vzXgMGwfxVinYBdm
 eL5lsicOmGHRkUwIURdtGqJnavMx2rDfK07lF/Y3s2kHVTz+Unj0GyLHtcpZvVkYYoV+9WcgxMa
 RYv9VFrPOoq2oojGEw4yCpKZz0Ht331Omd3VL9tSy27BFrRLIiLGYk28zBu14KpaSgi6rdW0
X-Proofpoint-ORIG-GUID: rsT8sNrY16sjwDeES_nxV0Glo2LFYTpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_02,2025-03-28_01
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

Add test cases for AES-CTR along with the
corresponding vectors.

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev.c                     |  33 +-
 ...st_cryptodev_security_ipsec_test_vectors.h | 316 ++++++++++++++++++
 2 files changed, 348 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index bee1dfcdba..7535ef6974 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -10572,7 +10572,8 @@ test_ipsec_proto_process(const struct ipsec_test_data td[],
 		.protocol = RTE_SECURITY_PROTOCOL_IPSEC,
 	};
 
-	if (td[0].aead || td[0].aes_gmac) {
+	if (td[0].aead || td[0].aes_gmac ||
+		       (td[0].xform.chain.cipher.cipher.algo == RTE_CRYPTO_CIPHER_AES_CTR)) {
 		salt_len = RTE_MIN(sizeof(ipsec_xform.salt), td[0].salt.len);
 		memcpy(&ipsec_xform.salt, td[0].salt.data, salt_len);
 	}
@@ -17946,6 +17947,36 @@ static struct unit_test_suite ipsec_proto_testsuite  = {
 			ut_setup_security, ut_teardown,
 			test_ipsec_proto_known_vec,
 			&pkt_aes_128_cbc_md5),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Outbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA256 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec,
+			&pkt_aes_128_ctr_hmac_sha256),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Outbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA384 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec,
+			&pkt_aes_128_ctr_hmac_sha384),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Outbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA512 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec,
+			&pkt_aes_128_ctr_hmac_sha512),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Inbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA256 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec_inb,
+			&pkt_aes_128_ctr_hmac_sha256),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Inbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA384 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec_inb,
+			&pkt_aes_128_ctr_hmac_sha384),
+		TEST_CASE_NAMED_WITH_DATA(
+			"Inbound known vector (ESP tunnel mode IPv4 AES-CTR 128 HMAC-SHA512 [16B ICV])",
+			ut_setup_security, ut_teardown,
+			test_ipsec_proto_known_vec_inb,
+			&pkt_aes_128_ctr_hmac_sha512),
 		TEST_CASE_NAMED_WITH_DATA(
 			"Outbound known vector (ESP tunnel mode IPv4 AES-CBC 128 HMAC-SHA256 [16B ICV])",
 			ut_setup_security, ut_teardown,
diff --git a/app/test/test_cryptodev_security_ipsec_test_vectors.h b/app/test/test_cryptodev_security_ipsec_test_vectors.h
index 6e60e32b9d..17353a2201 100644
--- a/app/test/test_cryptodev_security_ipsec_test_vectors.h
+++ b/app/test/test_cryptodev_security_ipsec_test_vectors.h
@@ -1718,6 +1718,322 @@ struct ipsec_test_data pkt_des_cbc_hmac_sha512 = {
 	},
 };
 
+struct ipsec_test_data pkt_aes_128_ctr_hmac_sha256 = {
+	.key = {
+		.data = {
+			0x43, 0x39, 0x31, 0x4B, 0x55, 0x52, 0x39, 0x47,
+			0x59, 0x4D, 0x6D, 0x35, 0x47, 0x66, 0x6B, 0x45,
+		},
+	},
+	.auth_key = {
+		.data = {
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+			0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
+			0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C,
+		},
+	},
+	.input_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x40, 0x00, 0x00, 0x00, 0x00,
+			0x3E, 0x11, 0x6D, 0xAA, 0x0D, 0x00, 0x00, 0x02,
+			0x02, 0x00, 0x00, 0x02, 0x10, 0xE1, 0x04, 0xD2,
+			0x00, 0x48, 0xA7, 0x62, 0x00, 0x01, 0x02, 0x03,
+			0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B,
+			0x0C, 0x0D, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13,
+			0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B,
+			0x1C, 0x1D, 0x1E, 0x1F, 0x20, 0x21, 0x22, 0x23,
+		},
+		.len = 64,
+	},
+	.output_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x78, 0x00, 0x00, 0x00, 0x00,
+			0xFE, 0x32, 0x39, 0x00, 0xC0, 0xA8, 0x01, 0x01,
+			0xC0, 0xA8, 0x01, 0x02, 0x00, 0x00, 0x00, 0x64,
+			0x00, 0x00, 0x00, 0x01, 0x6C, 0x02, 0x5C, 0x41,
+			0xD5, 0x18, 0xE5, 0xF9, 0x87, 0xF0, 0x07, 0x54,
+			0xA2, 0x66, 0x28, 0x6E, 0x2C, 0xB4, 0xF9, 0x9A,
+			0x2D, 0xC7, 0x42, 0x36, 0x11, 0xE7, 0x63, 0x38,
+			0xD9, 0xD2, 0x6E, 0x45, 0x9C, 0x7C, 0xB5, 0x4B,
+			0xC7, 0x78, 0x81, 0x49, 0x73, 0xC7, 0x13, 0x44,
+			0xA7, 0x77, 0xB4, 0x56, 0xC6, 0xC7, 0xBD, 0x77,
+			0x7B, 0xFD, 0x3C, 0x67, 0x38, 0xCA, 0xB5, 0x2B,
+			0x67, 0xDB, 0xDF, 0xCB, 0x24, 0x5D, 0xA2, 0xAE,
+			0xD2, 0x15, 0x99, 0x39, 0x20, 0x70, 0xCF, 0x7B,
+			0xEE, 0x17, 0x05, 0xCF, 0x4A, 0xC5, 0xD0, 0x44,
+			0xC9, 0x81, 0xDC, 0xCB, 0xDD, 0xBC, 0x7C, 0x2F,
+		},
+		.len = 120,
+	},
+
+	.iv = {
+		.data = {
+			0x6C, 0x02, 0x5C, 0x41, 0xD5, 0x18, 0xE5, 0xF9,
+		},
+	},
+	.salt = {
+		.data = {
+			0xde, 0xad, 0xbe, 0xef,
+		},
+		.len = 4,
+	},
+
+	.ipsec_xform = {
+		.spi = 100,
+		.options.esn = 0,
+		.options.udp_encap = 0,
+		.options.copy_dscp = 0,
+		.options.copy_flabel = 0,
+		.options.copy_df = 0,
+		.options.dec_ttl = 0,
+		.options.ecn = 0,
+		.options.stats = 0,
+		.options.tunnel_hdr_verify = 0,
+		.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS,
+		.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP,
+		.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL,
+		.tunnel.type = RTE_SECURITY_IPSEC_TUNNEL_IPV4,
+		.replay_win_sz = 0,
+	},
+
+	.aead = false,
+
+	.xform = {
+		.chain.cipher = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			.cipher = {
+				.op = RTE_CRYPTO_CIPHER_OP_ENCRYPT,
+				.algo = RTE_CRYPTO_CIPHER_AES_CTR,
+				.key.length = 16,
+				.iv.length = 12,
+			},
+		},
+		.chain.auth = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			.auth = {
+				.op = RTE_CRYPTO_AUTH_OP_GENERATE,
+				.algo = RTE_CRYPTO_AUTH_SHA256_HMAC,
+				.key.length = 32,
+				.digest_length = 16,
+			},
+		},
+	},
+};
+
+struct ipsec_test_data pkt_aes_128_ctr_hmac_sha384 = {
+	.key = {
+		.data = {
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+		},
+	},
+	.auth_key = {
+		.data = {
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+			0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
+			0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C,
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+		},
+	},
+	.input_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x00,
+			0x3F, 0x11, 0x1C, 0x8A, 0xAC, 0x10, 0x03, 0x0A,
+			0xAC, 0x10, 0x04, 0x0A, 0xC0, 0x00, 0xC0, 0x00,
+			0x00, 0x1A, 0x1A, 0x84, 0x00, 0x00, 0x00, 0x00,
+			0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		},
+		.len = 46,
+	},
+	.output_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x6C, 0x00, 0x00, 0x00, 0x00,
+			0xFF, 0x32, 0x38, 0x0C, 0xC0, 0xA8, 0x01, 0x01,
+			0xC0, 0xA8, 0x01, 0x02, 0x00, 0x00, 0x00, 0x64,
+			0x00, 0x00, 0x00, 0x01, 0xD2, 0xC4, 0xD3, 0xFE,
+			0x1D, 0x7D, 0xEA, 0xBB, 0x92, 0x26, 0xDC, 0x11,
+			0x3D, 0x7B, 0x17, 0x0E, 0x9C, 0x8B, 0x09, 0xA9,
+			0x73, 0xDC, 0xBF, 0xC5, 0x0E, 0x02, 0x31, 0xAA,
+			0xAF, 0x9C, 0x21, 0x81, 0x15, 0x83, 0x22, 0x87,
+			0xB3, 0x93, 0x94, 0x35, 0xAB, 0xB9, 0x43, 0x77,
+			0x4D, 0x18, 0x95, 0xA9, 0x55, 0x0B, 0xD6, 0x8E,
+			0xBA, 0x86, 0x0C, 0x93, 0x67, 0x65, 0x85, 0x7D,
+			0x5E, 0x74, 0x2F, 0xE5, 0x8C, 0x72, 0x60, 0xE3,
+			0x91, 0xB2, 0x83, 0x74, 0x84, 0xAD, 0x19, 0x26,
+			0x26, 0x5D, 0x30, 0x89,
+		},
+		.len = 108,
+	},
+
+	.iv = {
+		.data = {
+			0xD2, 0xC4, 0xD3, 0xFE, 0x1D, 0x7D, 0xEA, 0xBB,
+		},
+	},
+	.salt = {
+		.data = {
+			0xde, 0xad, 0xbe, 0xef,
+		},
+		.len = 4,
+	},
+
+	.ipsec_xform = {
+		.spi = 100,
+		.options.esn = 0,
+		.options.udp_encap = 0,
+		.options.copy_dscp = 0,
+		.options.copy_flabel = 0,
+		.options.copy_df = 0,
+		.options.dec_ttl = 0,
+		.options.ecn = 0,
+		.options.stats = 0,
+		.options.tunnel_hdr_verify = 0,
+		.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS,
+		.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP,
+		.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL,
+		.tunnel.type = RTE_SECURITY_IPSEC_TUNNEL_IPV4,
+		.replay_win_sz = 0,
+	},
+
+	.aead = false,
+
+	.xform = {
+		.chain.cipher = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			.cipher = {
+				.op = RTE_CRYPTO_CIPHER_OP_ENCRYPT,
+				.algo = RTE_CRYPTO_CIPHER_AES_CTR,
+				.key.length = 16,
+				.iv.length = 12,
+			},
+		},
+		.chain.auth = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			.auth = {
+				.op = RTE_CRYPTO_AUTH_OP_GENERATE,
+				.algo = RTE_CRYPTO_AUTH_SHA384_HMAC,
+				.key.length = 48,
+				.digest_length = 24,
+			},
+		},
+	},
+};
+
+struct ipsec_test_data pkt_aes_128_ctr_hmac_sha512 = {
+	.key = {
+		.data = {
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+		},
+	},
+	.auth_key = {
+		.data = {
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+			0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
+			0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C,
+			0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68,
+			0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x70,
+			0x61, 0x62, 0x63, 0x64, 0x61, 0x62, 0x63, 0x64,
+			0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C,
+		},
+	},
+	.input_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x2E, 0x00, 0x01, 0x00, 0x00,
+			0x3F, 0x11, 0x1C, 0x8A, 0xAC, 0x10, 0x03, 0x0A,
+			0xAC, 0x10, 0x04, 0x0A, 0xC0, 0x00, 0xC0, 0x00,
+			0x00, 0x1A, 0x1A, 0x84, 0x00, 0x00, 0x00, 0x00,
+			0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
+			0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		},
+		.len = 46,
+	},
+	.output_text = {
+		.data = {
+			0x45, 0x00, 0x00, 0x74, 0x00, 0x00, 0x00, 0x00,
+			0xFF, 0x32, 0x38, 0x04, 0xC0, 0xA8, 0x01, 0x01,
+			0xC0, 0xA8, 0x01, 0x02, 0x00, 0x00, 0x00, 0x64,
+			0x00, 0x00, 0x00, 0x01, 0x65, 0xEB, 0x54, 0xB1,
+			0x76, 0x20, 0xF1, 0x31, 0xC2, 0x78, 0xF5, 0xB2,
+			0x63, 0x8D, 0x6F, 0xA4, 0x28, 0xB4, 0xF6, 0xAA,
+			0x21, 0x94, 0xD9, 0x6D, 0x44, 0x71, 0x94, 0xBD,
+			0xBA, 0xE7, 0xEC, 0xEF, 0xB5, 0x8B, 0xA9, 0xCC,
+			0xA7, 0x9D, 0xB7, 0x70, 0x4F, 0x39, 0xD0, 0x3E,
+			0x77, 0x5C, 0xEE, 0x8F, 0xC1, 0x46, 0x38, 0x27,
+			0x10, 0x11, 0x09, 0x2C, 0x32, 0xA3, 0xBE, 0xB2,
+			0x3F, 0xB9, 0x01, 0x9B, 0x1C, 0x74, 0x6F, 0xF8,
+			0xBE, 0x9C, 0xE7, 0xBA, 0x02, 0x0C, 0xC5, 0xD3,
+			0x05, 0x4A, 0xF3, 0x9B, 0x34, 0x8A, 0xF2, 0xE4,
+			0x1B, 0x72, 0x47, 0xBB,
+		},
+		.len = 116,
+	},
+
+	.iv = {
+		.data = {
+			0x65, 0xEB, 0x54, 0xB1, 0x76, 0x20, 0xF1, 0x31
+		},
+	},
+	.salt = {
+		.data = {
+			0xde, 0xad, 0xbe, 0xef,
+		},
+		.len = 4,
+	},
+
+	.ipsec_xform = {
+		.spi = 100,
+		.options.esn = 0,
+		.options.udp_encap = 0,
+		.options.copy_dscp = 0,
+		.options.copy_flabel = 0,
+		.options.copy_df = 0,
+		.options.dec_ttl = 0,
+		.options.ecn = 0,
+		.options.stats = 0,
+		.options.tunnel_hdr_verify = 0,
+		.direction = RTE_SECURITY_IPSEC_SA_DIR_EGRESS,
+		.proto = RTE_SECURITY_IPSEC_SA_PROTO_ESP,
+		.mode = RTE_SECURITY_IPSEC_SA_MODE_TUNNEL,
+		.tunnel.type = RTE_SECURITY_IPSEC_TUNNEL_IPV4,
+		.replay_win_sz = 0,
+	},
+
+	.aead = false,
+
+	.xform = {
+		.chain.cipher = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_CIPHER,
+			.cipher = {
+				.op = RTE_CRYPTO_CIPHER_OP_ENCRYPT,
+				.algo = RTE_CRYPTO_CIPHER_AES_CTR,
+				.key.length = 16,
+				.iv.length = 12,
+			},
+		},
+		.chain.auth = {
+			.next = NULL,
+			.type = RTE_CRYPTO_SYM_XFORM_AUTH,
+			.auth = {
+				.op = RTE_CRYPTO_AUTH_OP_GENERATE,
+				.algo = RTE_CRYPTO_AUTH_SHA512_HMAC,
+				.key.length = 64,
+				.digest_length = 32,
+			},
+		},
+	},
+};
+
 struct ipsec_test_data pkt_aes_128_cbc_hmac_sha256_v6 = {
 	.key = {
 		.data = {
-- 
2.48.1

