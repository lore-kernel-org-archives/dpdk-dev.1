Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F1606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TH2v0B8s
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12AEC40264;
	Sun,  8 Nov 2026 13:04:07 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by mails.dpdk.org (Postfix) with ESMTPS id 8A4A04003C
 for <dev@dpdk.org>; Sun,  8 Nov 2026 13:04:05 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-37071c0f42aso145108eec.0
 for <dev@dpdk.org>; Sun, 08 Nov 2026 04:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794139444; x=1794744244; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hkshgI/H8ETj/f3YF5TduXKGPSCxQ3x2IMj9Sm1lXhc=;
 b=TH2v0B8sYi5dFE50JnGvKD205hI6ykrou3kf12dnhGvQ4jX8iCmJKXLil1VwEHE5XV
 9ruOi+6X47XCJf7udFa0ADdSK4maue7j6LdgirFYeLLbHL6xAgdKPyHMBgmk5VTVSlq9
 CYLo7rA2mtaV7ozVIwzogiJKkI59d3ZsmosBSjgpbhHbsr9MXr7Qoexw5LHMn9HQwc2c
 U6s6skBGBwBiuH/5ndxjkn/aIdobZFb+HMVseKGwC5LaNioY6Sdp2jUqepc19HhsQpe+
 hv963HGpj9FttqUwqOAYhhYKGOoQEQuPUE22agwrdQkBXwn9+ZZFShonNwC9QhUBM49c
 V3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794139444; x=1794744244;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hkshgI/H8ETj/f3YF5TduXKGPSCxQ3x2IMj9Sm1lXhc=;
 b=s0S36Xtm92RAmrq4RdG0ptgoeQB5IF5+ONewhG9sCtiAqfRW4nasRObYnEoFa7JEVD
 Ayzq7YboeQRR4YPOA4Mm4GUiA2bAFH7FbOsDDZ83v+X2YcrVUDzenicXrtczZiLxhRGd
 FDBN3SuzvRQ3mhTstE9q+to1a6qXvJdZ/bIS92pG6xS9siL4jf5MRaUiBUdr207UFKxr
 poqKMyiDECGoKSjpUEc1zxPs10cU8xGzQJ22GN2sPnFGcBngF6VmjSkCYsL+gimd/+an
 qObuku7/LfCVyS06QVmqbNv62uuqfARmAtENmvxuQZPoTweieFWAQlysyQ8MWKAz0G0l
 8cNQ==
X-Gm-Message-State: APuU4Z+XJqpsQgrv0xQaZW8BNutVALo0gP+E0NUQ49VfOO3R31DUcAB+
 DjhaKHDV5UJ5LztXcsuMtNgIwWEMstM6Epvh3kHm8VzG6Wz9XGzB7SOH
X-Gm-Gg: AYBFou3QIbTbcFQsKW2teUOcqqgjlrxB8QnufYrZcXaLev/AiN0pbd9KJMBPWjjoLLi
 f1DDWc5s3VlQ/giaaRwN6JwHXXby/VkRAeQEBpJYfljoJy7KyiGLws/FpinmS4S7ywSDp3W+EhQ
 trRreD5XDZalTIm4oQ8Dc5xGGbkyZ+69oKPg/nONdpNPtEBRlWQyhYkJnDrhZxQ33v0IYE98c8L
 7fzSNbcwuiS+zWT60zDdHeuGf2qbCoOHxteBADA9bUZUHGj5Br1h5Q1PyK5cllSLMoMz0YA1Wz5
 oN/nWDZJxs3oB6O0s6gJgKFPt7RNuBAbWTrx2NOWvkWJAq4y2bO6ImkI9E5vcDtSyv3BInisI/E
 cSRgIn2J1uW7txx2cldPAyDanntp+C3kEE7YUK1T/IlbdOLSQF5E4TSLXqL2LQICW8H9xA1nF0F
 M5BnbU6VDPRa/fwo3r2pH0SEEqrcXwp/Qem8VvDpUUVdOPfQAJeec8OYiCMs8T1+gkTSkVAPxWG
 5ONq2FL1F/p7P5q1Zo9kRtdebCr1xfP5uLqkLZXMWIM59XIowfxIZpJ0qs5+PS9PIGEreue3Xbf
 a8FZCtqsuhLTrvMF+ClHItj3FaBQN2WxFRNojzWRcFQJb30b0p0=
X-Received: by 2002:a05:693c:41c7:10b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-37336acea27mr336592eec.10.1794139443576; 
 Sun, 08 Nov 2026 04:04:03 -0800 (PST)
Received: from gentoo ([49.204.145.8]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37265618d59sm4846176eec.6.2026.11.08.04.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 04:04:02 -0800 (PST)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: use static constants for SSE42 PCLMULQDQ parameters
Date: Sun,  8 Nov 2026 17:33:58 +0530
Message-ID: <20261108120358.1408920-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the __m128i members in the PCLMULQDQ CRC context with aligned
uint64_t arrays to allow portable compile-time initialization.

Move CRC16-CCITT and CRC32-ETH folding constants into static const context
structures in their respective handlers, removing the runtime
initialization previously performed by rte_net_crc_sse42_init and avoids
the extra data segment static variables which were being populated.

Load the constants into SIMD registers using aligned loads when performing
CRC calculations. This was done transparently previously when the
__m128i values were assigned, now there is explicit SIMD load done.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_sse.c | 68 ++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index e30f8544fc..4361e35e39 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -12,15 +12,13 @@
 #include "net_crc.h"
 
 /** PCLMULQDQ CRC computation context structure */
-struct crc_pclmulqdq_ctx {
-	__m128i rk1_rk2;
-	__m128i rk3_rk4;
-	__m128i rk5_rk6;
-	__m128i rk7_rk8;
+struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {
+	uint64_t rk1_rk2[2];
+	uint64_t rk3_rk4[2];
+	uint64_t rk5_rk6[2];
+	uint64_t rk7_rk8[2];
 };
 
-static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
-static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
 /**
  * @brief Performs one folding round
  *
@@ -162,7 +160,7 @@ crc32_eth_calc_pclmulqdq(
 		fold3 = _mm_loadu_si128((const __m128i *)(data + 32));
 		fold4 = _mm_loadu_si128((const __m128i *)(data + 48));
 		fold1 = _mm_xor_si128(fold1, temp);
-		k = params->rk1_rk2;
+		k = _mm_load_si128((const __m128i *)params->rk1_rk2);
 
 		for (n = 64; (n + 64) <= data_len; n += 64) {
 			temp1 = _mm_loadu_si128((const __m128i *)&data[n]);
@@ -175,7 +173,7 @@ crc32_eth_calc_pclmulqdq(
 			fold4 = crcr32_folding_round(temp4, k, fold4);
 		}
 
-		k = params->rk3_rk4;
+		k = _mm_load_si128((const __m128i *)params->rk3_rk4);
 		fold1 = crcr32_folding_round(fold2, k, fold1);
 		fold1 = crcr32_folding_round(fold3, k, fold1);
 		fold = crcr32_folding_round(fold4, k, fold1);
@@ -205,7 +203,7 @@ crc32_eth_calc_pclmulqdq(
 	fold = _mm_xor_si128(fold, temp);
 
 	/** Single folding loop - the last 16 bytes is processed separately */
-	k = params->rk3_rk4;
+	k = _mm_load_si128((const __m128i *)params->rk3_rk4);
 	n = 16;
 
 single_fold_loop:
@@ -235,11 +233,11 @@ crc32_eth_calc_pclmulqdq(
 
 	/** Reduction 128 -> 32 Assumes: fold holds 128bit folded data */
 reduction_128_64:
-	k = params->rk5_rk6;
+	k = _mm_load_si128((const __m128i *)params->rk5_rk6);
 	fold = crcr32_reduce_128_to_64(fold, k);
 
 barret_reduction:
-	k = params->rk7_rk8;
+	k = _mm_load_si128((const __m128i *)params->rk7_rk8);
 	n = crcr32_reduce_64_to_32(fold, k);
 
 	return n;
@@ -248,45 +246,17 @@ crc32_eth_calc_pclmulqdq(
 void
 rte_net_crc_sse42_init(void)
 {
-	uint64_t k1, k2, k3, k4, k5, k6;
-	uint64_t p = 0, q = 0;
-
-	/** Initialize CRC16 data */
-	k1 = 0x14ff2LLU;
-	k2 = 0x19a3cLLU;
-	k3 = 0x189aeLLU;
-	k4 = 0x8e10LLU;
-	k5 = 0x189aeLLU;
-	k6 = 0x114aaLLU;
-	q =  0x11c581910LLU;
-	p =  0x10811LLU;
-
-	/** Save the params in context structure */
-	crc16_ccitt_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
-	crc16_ccitt_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
-	crc16_ccitt_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
-	crc16_ccitt_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
-
-	/** Initialize CRC32 data */
-	k1 = 0x1c6e41596LLU;
-	k2 = 0x154442bd4LLU;
-	k3 = 0xccaa009eLLU;
-	k4 = 0x1751997d0LLU;
-	k5 = 0xccaa009eLLU;
-	k6 = 0x163cd6124LLU;
-	q =  0x1f7011640LLU;
-	p =  0x1db710641LLU;
-
-	/** Save the params in context structure */
-	crc32_eth_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
-	crc32_eth_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
-	crc32_eth_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
-	crc32_eth_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
 }
 
 uint32_t
 rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len)
 {
+	static const struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq = {
+		.rk1_rk2 = { 0x14ff2LLU, 0x19a3cLLU },
+		.rk3_rk4 = { 0x189aeLLU, 0x8e10LLU },
+		.rk5_rk6 = { 0x189aeLLU, 0x114aaLLU },
+		.rk7_rk8 = { 0x11c581910LLU, 0x10811LLU },
+	};
 	/** return 16-bit CRC value */
 	return (uint16_t)~crc32_eth_calc_pclmulqdq(data,
 		data_len,
@@ -297,6 +267,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len)
 uint32_t
 rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t data_len)
 {
+	static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq = {
+		.rk1_rk2 = { 0x1c6e41596LLU, 0x154442bd4LLU },
+		.rk3_rk4 = { 0xccaa009eLLU, 0x1751997d0LLU },
+		.rk5_rk6 = { 0xccaa009eLLU, 0x163cd6124LLU },
+		.rk7_rk8 = { 0x1f7011640LLU, 0x1db710641LLU },
+	};
 	return ~crc32_eth_calc_pclmulqdq(data,
 		data_len,
 		0xffffffffUL,
-- 
2.56.0

