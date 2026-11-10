Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C0606A339
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rb4i/Oht
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B6FA40285;
	Tue, 10 Nov 2026 13:11:05 +0100 (CET)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by mails.dpdk.org (Postfix) with ESMTPS id 318C640281
 for <dev@dpdk.org>; Tue, 10 Nov 2026 13:11:04 +0100 (CET)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-36f6295304dso2555668eec.1
 for <dev@dpdk.org>; Tue, 10 Nov 2026 04:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794312662; x=1794917462; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8a1R+6rnNMt1SBj4X5ItudtrdbUnf/NsSUd2D45HxUs=;
 b=Rb4i/OhtqQVd/aqE9oi9eH5vcro3rDXXXPSlyUQGicEbTJTbtyRhH45eczvfroqLfE
 yM6vMyre3Cf7yHueDkjduiDHaQVc51MHUK2jOTQ3vMDG/bpRKMn4hJ5ZPySW19rDVvpF
 DT19LiMASdBz+7BxI0YtnTgIndo1KAHff43O4ERleQ2M4/7TPJqAzKJOUQSiuHu03P2w
 PPC4HMTuQRIX5ejVW2111R2sfaOhThCT5yTbZ26rTsOdk9BUjGQCVZw7aA3oE5AwqZUZ
 NGRiinPoJopmJxzU4oavvCZhuWgzMjQJmgFahQ0oYRrbGl0LWwQu68S0tvlTTxAetU6Z
 K7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794312662; x=1794917462;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8a1R+6rnNMt1SBj4X5ItudtrdbUnf/NsSUd2D45HxUs=;
 b=pCI1cAW6T/3UO8RQ5QTRHqnNWisq6NS7BsMnKL7SsuAmQpVv0pgbTURe69xhFcNt09
 o574utWnWgCy0Tii+5qBHbMrHoIvzdaIAHuOrmSW2l4ArzXxLJMv5eIfk7DavMPW1Eow
 XQNatRu++GudMLRn3wiHCEm0pwKnOM5gXWBmTo4SUjromhBPguM24bxXE4RigNZ5I+y2
 vdJAAzvcc7HJFz4nA4QeoDtlGYVaLTztw4mkOiyYIWldP2A4BFYYuKhJeL+MDcRHWdQ7
 XzTvFizzl1xYoiRXPCBCrA5logx4uficCb6WAJDFTsJ+llZ/+hlID66DTLrR0iqWvAfF
 UtIg==
X-Gm-Message-State: APuU4Z/pbrMjKnDauDL2vMYgKstNJjqqRBwfmWSm9uDXraZZI2iEWx7A
 bpqLyMlHGkJc8mpzwnVJW2DP+jRqLUGtLmTd58ldxTvJaBS7pAZ7XKnHsQJn/6Go
X-Gm-Gg: AYBFou1USsbgrP09Ei7zPeOEyLQi9w1q2uSiMYVISqLI/YrMJQKRSgyqN8G1RSRen/0
 +ZH3eWR4ezB0nrS6WfKrjr1NGDhrfIRTqPDQfBmI2PD8K5tXKe+Lr2keWh1RbobcKhawNP5WFM9
 6SYsoUjQ/J6l3RoHxDGwbDymbRSC/ycC1khfetZbPoojovo5SmwL6PrTgW2TQNJaffKXMXWTvWt
 1zP/O/92LrAmHd5LLAzx+0vurSqes9Wfk4P4pxOgoCuk98zI0wCEWOZKkY2gPncODId1/43PL5q
 5yvcpELGuQCcUhJ6w7hz73wkXSn3Gfug1LhTIin7N6Dp/L0DXkIwPSLVImAEOG/3cS2XBTU1fbb
 HBv/4dVC5n9oAGfeEWPY913FjlX7CmaP4o5Fn5OE1giGfBULMqQasYR4YZGuHkGtEE96EE2qcse
 13QiM8euplUCEDqvDY6YaypTvU9P1nbRmk6/g9MS1N9SVMD1A4wBfDGjZCcPMcQNqw55E98D9Jg
 nJf5/3rPZnoOvS2jFbVquHbmb6oMW3q6Z/JcYzS31d+XnI9fTDc5kfLq+IZAtO56150In8zNJaY
 vPuZir1jHoESJUOo432qOMzIGe/1wg==
X-Received: by 2002:a05:7300:ec8e:b0:36e:ff7e:e57f with SMTP id
 5a478bee46e88-3751ef77817mr3238288eec.19.1794312662083; 
 Tue, 10 Nov 2026 04:11:02 -0800 (PST)
Received: from gentoo ([49.204.145.8]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37520cfdfc6sm7682700eec.17.2026.11.10.04.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:10:54 -0800 (PST)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: improved barrett reduction in x86 SSE42
Date: Tue, 10 Nov 2026 17:40:48 +0530
Message-ID: <20261110121048.831330-1-16567adigashreesh@gmail.com>
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

Use 64-bit polynomial structure and perform barrett reduction
from 128-bit to 64-bit which involves lesser instructions than
performing the 128 to 64 followed by 64 to 32 sequence.

This also requires one less fold register as we can reuse the x^127 from
single fold loop required for initial 128-bit reduction sequence.

Move CRC16-CCITT and CRC32-ETH folding constants into static const context
structures in their respective handlers, removing the runtime
initialization previously performed by rte_net_crc_sse42_init and avoids
the extra data segment static variables which were being populated.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc.h     |   3 -
 lib/net/net_crc_sse.c | 134 +++++++++++++++++-------------------------
 lib/net/rte_net_crc.c |  10 ----
 3 files changed, 53 insertions(+), 94 deletions(-)

diff --git a/lib/net/net_crc.h b/lib/net/net_crc.h
index 320b0edca8..0d61ccafd6 100644
--- a/lib/net/net_crc.h
+++ b/lib/net/net_crc.h
@@ -13,9 +13,6 @@
 
 /* SSE4.2 */
 
-void
-rte_net_crc_sse42_init(void);
-
 uint32_t
 rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len);
 
diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index e30f8544fc..d5d5fdba3d 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -12,15 +12,23 @@
 #include "net_crc.h"
 
 /** PCLMULQDQ CRC computation context structure */
-struct crc_pclmulqdq_ctx {
-	__m128i rk1_rk2;
-	__m128i rk3_rk4;
-	__m128i rk5_rk6;
-	__m128i rk7_rk8;
+struct __rte_aligned(XMM_SIZE) crc_pclmulqdq_ctx {
+	/**
+	 * The constants are derived as below:
+	 * P is assumed to be degree 64 polynomial. If the degree is less,
+	 * then P = (poly << (64 - deg)) to have a 64-bit polynomial.
+	 * rk1 = bitreverse64(x^575 MOD P)
+	 * rk2 = bitreverse64(x^511 MOD P)
+	 * rk3 = bitreverse64(x^191 MOD P)
+	 * rk4 = bitreverse64(x^127 MOD P)
+	 * rk5 = (bitreverse64(floor(x^128 / P) - x^64) << 1) | 1
+	 * rk6 = (bitreverse64(P - x^64) << 1)
+	 */
+	rte_xmm_t rk1_rk2;
+	rte_xmm_t rk3_rk4;
+	rte_xmm_t rk5_rk6;
 };
 
-static alignas(16) struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq;
-static alignas(16) struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq;
 /**
  * @brief Performs one folding round
  *
@@ -47,65 +55,56 @@ crcr32_folding_round(__m128i data_block,
 		__m128i precomp,
 		__m128i fold)
 {
-	__m128i tmp0 = _mm_clmulepi64_si128(fold, precomp, 0x01);
-	__m128i tmp1 = _mm_clmulepi64_si128(fold, precomp, 0x10);
+	__m128i tmp0 = _mm_clmulepi64_si128(fold, precomp, 0x00);
+	__m128i tmp1 = _mm_clmulepi64_si128(fold, precomp, 0x11);
 
 	return _mm_xor_si128(tmp1, _mm_xor_si128(data_block, tmp0));
 }
 
 /**
- * Performs reduction from 128 bits to 64 bits
+ * Fold the low qword (upper 64 coefficients) with rk4 = x^127 mod P
+ * and XOR into the high qword.
  *
  * @param data128
  *   128 bits data to be reduced
  * @param precomp
- *   precomputed constants rk5, rk6
+ *   precomputed constants rk3, rk4
  *
  * @return
- *  64 bits reduced data
+ *  128 bits reduced data
  */
 
 static __rte_always_inline __m128i
-crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
+crcr32_reduce_to_128(__m128i data128, __m128i precomp)
 {
-	__m128i tmp0, tmp1, tmp2;
+	__m128i tmp0, tmp1;
 
-	/* 64b fold */
-	tmp0 = _mm_clmulepi64_si128(data128, precomp, 0x00);
+	tmp0 = _mm_clmulepi64_si128(data128, precomp, 0x10);
 	tmp1 = _mm_srli_si128(data128, 8);
-	tmp0 = _mm_xor_si128(tmp0, tmp1);
-
-	/* 32b fold */
-	tmp2 = _mm_slli_si128(tmp0, 4);
-	tmp1 = _mm_clmulepi64_si128(tmp2, precomp, 0x10);
-
 	return _mm_xor_si128(tmp1, tmp0);
 }
 
 /**
- * Performs Barret's reduction from 64 bits to 32 bits
+ * Performs Barret's reduction from 128 bits to 32 bits.
  *
- * @param data64
- *   64 bits data to be reduced
+ * @param data128
+ *   128 bits data to be reduced
  * @param precomp
- *   rk7 precomputed constant
+ *   rk5, rk6 precomputed constant
  *
  * @return
  *   reduced 32 bits data
  */
 
 static __rte_always_inline uint32_t
-crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
+crcr32_reduce_128_to_32(__m128i data128, __m128i precomp)
 {
 	__m128i tmp0, tmp1, tmp2;
 
-	tmp0 = _mm_blend_epi16(data64, _mm_setzero_si128(), 0x3);
-
-	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x00);
-	tmp1 = _mm_xor_si128(tmp1, tmp0);
+	tmp0 = _mm_clmulepi64_si128(data128, precomp, 0x00);
+	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x10);
 
-	tmp2 = _mm_clmulepi64_si128(tmp1, precomp, 0x10);
-	tmp2 = _mm_xor_si128(tmp2, tmp0);
+	tmp2 = _mm_xor_si128(tmp1, data128);
 
 	return _mm_extract_epi32(tmp2, 2);
 }
@@ -162,7 +161,7 @@ crc32_eth_calc_pclmulqdq(
 		fold3 = _mm_loadu_si128((const __m128i *)(data + 32));
 		fold4 = _mm_loadu_si128((const __m128i *)(data + 48));
 		fold1 = _mm_xor_si128(fold1, temp);
-		k = params->rk1_rk2;
+		k = params->rk1_rk2.x;
 
 		for (n = 64; (n + 64) <= data_len; n += 64) {
 			temp1 = _mm_loadu_si128((const __m128i *)&data[n]);
@@ -175,7 +174,7 @@ crc32_eth_calc_pclmulqdq(
 			fold4 = crcr32_folding_round(temp4, k, fold4);
 		}
 
-		k = params->rk3_rk4;
+		k = params->rk3_rk4.x;
 		fold1 = crcr32_folding_round(fold2, k, fold1);
 		fold1 = crcr32_folding_round(fold3, k, fold1);
 		fold = crcr32_folding_round(fold4, k, fold1);
@@ -196,7 +195,8 @@ crc32_eth_calc_pclmulqdq(
 			goto barret_reduction;
 		}
 		fold = xmm_shift_left(fold, 16 - data_len);
-		goto reduction_128_64;
+		k = params->rk3_rk4.x;
+		goto reduction_128;
 	}
 
 	/** At least 16 bytes in the buffer */
@@ -205,7 +205,7 @@ crc32_eth_calc_pclmulqdq(
 	fold = _mm_xor_si128(fold, temp);
 
 	/** Single folding loop - the last 16 bytes is processed separately */
-	k = params->rk3_rk4;
+	k = params->rk3_rk4.x;
 	n = 16;
 
 single_fold_loop:
@@ -234,59 +234,25 @@ crc32_eth_calc_pclmulqdq(
 	}
 
 	/** Reduction 128 -> 32 Assumes: fold holds 128bit folded data */
-reduction_128_64:
-	k = params->rk5_rk6;
-	fold = crcr32_reduce_128_to_64(fold, k);
+reduction_128:
+	fold = crcr32_reduce_to_128(fold, k);
 
 barret_reduction:
-	k = params->rk7_rk8;
-	n = crcr32_reduce_64_to_32(fold, k);
+	k = params->rk5_rk6.x;
+	n = crcr32_reduce_128_to_32(fold, k);
 
 	return n;
 }
 
-void
-rte_net_crc_sse42_init(void)
-{
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
-}
-
 uint32_t
 rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len)
 {
+	static const struct crc_pclmulqdq_ctx crc16_ccitt_pclmulqdq = {
+		.rk1_rk2 = { .u64 = { 0x922dULL, 0x47e3ULL } },
+		.rk3_rk4 = { .u64 = { 0x8e10ULL, 0x81bfULL } },
+		.rk5_rk6 = { .u64 = { 0x859b040b1c581911ULL, 0x10810ULL } },
+	};
+
 	/** return 16-bit CRC value */
 	return (uint16_t)~crc32_eth_calc_pclmulqdq(data,
 		data_len,
@@ -297,6 +263,12 @@ rte_crc16_ccitt_sse42_handler(const uint8_t *data, uint32_t data_len)
 uint32_t
 rte_crc32_eth_sse42_handler(const uint8_t *data, uint32_t data_len)
 {
+	static const struct crc_pclmulqdq_ctx crc32_eth_pclmulqdq = {
+		.rk1_rk2 = { .u64 = { 0x8f352d95ULL, 0x1d9513d7ULL } },
+		.rk3_rk4 = { .u64 = { 0xae689191ULL, 0xccaa009eULL } },
+		.rk5_rk6 = { .u64 = { 0xb4e5b025f7011641ULL, 0x1db710640ULL } },
+	};
+
 	return ~crc32_eth_calc_pclmulqdq(data,
 		data_len,
 		0xffffffffUL,
diff --git a/lib/net/rte_net_crc.c b/lib/net/rte_net_crc.c
index 3a589bdd6d..6becd3e336 100644
--- a/lib/net/rte_net_crc.c
+++ b/lib/net/rte_net_crc.c
@@ -151,15 +151,6 @@ avx512_vpclmulqdq_init(void)
 #define SSE42_PCLMULQDQ_CPU_SUPPORTED \
 	rte_cpu_get_flag_enabled(RTE_CPUFLAG_PCLMULQDQ)
 
-static void
-sse42_pclmulqdq_init(void)
-{
-#ifdef RTE_ARCH_X86_64
-	if (SSE42_PCLMULQDQ_CPU_SUPPORTED)
-		rte_net_crc_sse42_init();
-#endif
-}
-
 /* NEON/PMULL handling */
 
 #define NEON_PMULL_CPU_SUPPORTED \
@@ -272,7 +263,6 @@ uint32_t rte_net_crc_calc(const struct rte_net_crc *ctx, const void *data, const
 RTE_INIT(rte_net_crc_init)
 {
 	rte_net_crc_scalar_init();
-	sse42_pclmulqdq_init();
 	avx512_vpclmulqdq_init();
 	neon_pmull_init();
 	handlers_init(RTE_NET_CRC_SCALAR);
-- 
2.56.0

