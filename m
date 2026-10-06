Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A051CA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:19:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1299C427B2;
	Tue,  6 Oct 2026 17:18:42 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id 03A5441153
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:18:40 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-88aea027391so1531837b3a.0
 for <dev@dpdk.org>; Tue, 06 Oct 2026 08:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791299919; x=1791904719; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XA/scDrnQfi3nkPp4ou+4MLoUz95J5xCAlIIDuAIJ70=;
 b=AwIZH95aNo8P60Z3dAQHqJJ76QJGqZsJB+rGG64mAwjsaGzuvZyw4HVKQ6D2Pr64Ew
 OalBTwecCSOE3YjT9cmtXW4UBg9Qu8nSO9nll0xSAe4GSvx0ivMlDC2w0BCys8lROmcS
 jjyQzBGhJXM3BRyPkSlJUggaRkYtuMFmEwMKFmtBJPlOBiDED14TNMhwbpMX6TnjxPPg
 EvswSl5yLQ6D7whjhTaROH5gBZ+PfQ6/YRhRPbVHIYC/+m9aYF+0MvfVnNrSCx7qLCMY
 pOc8bRr+//ZaHg8nW7Y1w5qESIgWfhWBFtqAok41baBzxl48KGIQ+9hGz5rSWuHFz0d9
 29rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791299919; x=1791904719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XA/scDrnQfi3nkPp4ou+4MLoUz95J5xCAlIIDuAIJ70=;
 b=FN6XR4ARjXvaJMF7+Ce96tqro5G2G1YC8gKoYP66cb+A1Te/PjmMEQR30zHSeb5uhF
 aNLhBTNAW68XpWc6GR8NQkdho2bqL9X3pIQ7KEmU64hVKfWALrwm749k2MzFA9QEtOgH
 At4t0hdEQzNed79sYyQcd3yTdKpydT6wwnjtwOMFlYi+r6nS+H5dhIYdbMWjE4C+7T71
 6FoNo/jUr6DeaxOF4yrAa9nu4DRLPgYZ0ZH463ClL+GMBh/6WgXn2gDR3JD39ewbzLSV
 i18cjx8OBUqctI7AyGIjnXUYSiW31YaliEE0lwKDAP8NOa9/nkxyxzWe4HD4bC0Ot/5p
 G3HQ==
X-Gm-Message-State: AFuF++lvxK2QvMbw18wuSYszqfe9e1dq07Qfw/MqO0a1Fx3DrC53KB6M
 Ia6mBr0hDxF3Yw+/RY67XzOeFw9E7dweNQxzIgp9r000Poj3oCGg8bG6T9RbiBlh
X-Gm-Gg: AYBFou11pYsPT7JgZ7auluDsFyRO5uBbe4GNJQP1Q67qHnUt6buEcZcVmqGEDAMrRRX
 Bfyt0unZnbeVwR9AkBiKdmZruCvf2VhT2wX3LhqEZo+E5JH/C+oziTvI/fDPhkXUISpdjkUTMgm
 MYKcZ97W+qSFqrKydWJrYMfvYqkus/hN0ys5DgkEPesXfyCReq/jb+hdR20z2Qql0+sP1IQ9TJP
 nhxv9053TfG5d9W39h2+M/Le08m/LCafmkv4Oef/5CwuZlfSCPVE8w1N64Qk/u0xyIhn50CgfJW
 u3maPR0eeO3siUYeG7xbKBoR+f5DGXJCzGSUH/qRH/LT/appR2pyRY2nUjFctz0MrtOXGdxJkFP
 BRitNCkqusx1N7tfMlh65YKJsbFAfxDeERrI3B41k3jcXkVlR0PvvX7kedWHl68Y+XGFGiEeCnE
 GIQ7zkHA/lJe0ZdNmp0IMtiIdqVuyUyE4pcNA4kw2GXYbDrQxzonLbSC2vrXR2rrarQ9tyGmf9L
 a1yJhTg0HKk
X-Received: by 2002:a05:6a20:9c15:b0:3dd:a009:3186 with SMTP id
 adf61e73a8af0-3e0d6cddee7mr9998334637.46.1791299918826; 
 Tue, 06 Oct 2026 08:18:38 -0700 (PDT)
Received: from gentoo ([49.204.144.166]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cce6d9f86aesm2799142a12.18.2026.10.06.08.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 08:18:37 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: make NEON CRC folding logic similar to x86 SSE
Date: Tue,  6 Oct 2026 20:48:33 +0530
Message-ID: <20261006151833.347561-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This patch includes the following minor changes:
1) Use TBL based shift left for variable len shift instead of using
   vshift_bytes_left which adds a switch case for 16 len cases.
2) Align the fold constants to use PMULL and PMULL2 instructions
   instead of using cross lane operands which requires additional shift.
3) Remove unnecessary static arrays used in crc32_reduce_64_to_32 by
   adapting x86 SSE logic.
4) Use x86 SSE logic for processing partial bytes sequence to avoid
   using multiple variable len shifts which inserts switch case.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_neon.c | 71 +++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 25 deletions(-)

diff --git a/lib/net/net_crc_neon.c b/lib/net/net_crc_neon.c
index d924aed25d..3833fcba6e 100644
--- a/lib/net/net_crc_neon.c
+++ b/lib/net/net_crc_neon.c
@@ -24,6 +24,31 @@ struct crc_pmull_ctx {
 alignas(16) struct crc_pmull_ctx crc32_eth_pmull;
 alignas(16) struct crc_pmull_ctx crc16_ccitt_pmull;
 
+static const alignas(16) uint8_t crc_neon_shift_tab[32] = {
+	0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
+	0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
+	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
+};
+
+/**
+ * Shifts left 128 bit register by specified number of bytes
+ *
+ * @param reg
+ *   128 bit value
+ * @param num
+ *   number of bytes to shift left reg by (0-16)
+ *
+ * @return
+ *   reg << (num * 8)
+ */
+static inline uint64x2_t
+neon_shift_left(uint64x2_t reg, const unsigned int num)
+{
+	uint8x16_t tbl = vld1q_u8(crc_neon_shift_tab + 16 - num);
+	return vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(reg), tbl));
+}
+
 /**
  * @brief Performs one folding round
  *
@@ -46,12 +71,12 @@ crcr32_folding_round(uint64x2_t data_block, uint64x2_t precomp,
 	uint64x2_t fold)
 {
 	uint64x2_t tmp0 = vreinterpretq_u64_p128(vmull_p64(
-			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 1),
+			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
 			vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));
 
-	uint64x2_t tmp1 = vreinterpretq_u64_p128(vmull_p64(
-			vgetq_lane_p64(vreinterpretq_p64_u64(fold), 0),
-			vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));
+	uint64x2_t tmp1 = vreinterpretq_u64_p128(vmull_high_p64(
+			vreinterpretq_p64_u64(fold),
+			vreinterpretq_p64_u64(precomp)));
 
 	return veorq_u64(tmp1, veorq_u64(data_block, tmp0));
 }
@@ -98,26 +123,19 @@ static inline uint32_t
 crcr32_reduce_64_to_32(uint64x2_t data64,
 	uint64x2_t precomp)
 {
-	static alignas(16) uint32_t mask1[4] = {
-		0xffffffff, 0xffffffff, 0x00000000, 0x00000000
-	};
-	static alignas(16) uint32_t mask2[4] = {
-		0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
-	};
 	uint64x2_t tmp0, tmp1, tmp2;
 
-	tmp0 = vandq_u64(data64, vld1q_u64((uint64_t *)mask2));
+	tmp0 = vreinterpretq_u64_u32(
+		vsetq_lane_u32(0, vreinterpretq_u32_u64(data64), 0));
 
 	tmp1 = vreinterpretq_u64_p128(vmull_p64(
 		vgetq_lane_p64(vreinterpretq_p64_u64(tmp0), 0),
 		vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 0)));
 	tmp1 = veorq_u64(tmp1, tmp0);
-	tmp1 = vandq_u64(tmp1, vld1q_u64((uint64_t *)mask1));
 
 	tmp2 = vreinterpretq_u64_p128(vmull_p64(
 		vgetq_lane_p64(vreinterpretq_p64_u64(tmp1), 0),
 		vgetq_lane_p64(vreinterpretq_p64_u64(precomp), 1)));
-	tmp2 = veorq_u64(tmp2, tmp1);
 	tmp2 = veorq_u64(tmp2, tmp0);
 
 	return vgetq_lane_u32(vreinterpretq_u32_u64(tmp2), 2);
@@ -177,10 +195,10 @@ crc32_eth_calc_pmull(
 		fold = vld1q_u64((uint64_t *)buffer);
 		fold = veorq_u64(fold, temp);
 		if (unlikely(data_len < 4)) {
-			fold = vshift_bytes_left(fold, 8 - data_len);
+			fold = neon_shift_left(fold, 8 - data_len);
 			goto barret_reduction;
 		}
-		fold = vshift_bytes_left(fold, 16 - data_len);
+		fold = neon_shift_left(fold, 16 - data_len);
 		goto reduction_128_64;
 	}
 
@@ -201,14 +219,17 @@ crc32_eth_calc_pmull(
 
 	/** Partial bytes - process last <16 bytes */
 	if (likely(n < data_len)) {
-		uint64x2_t last16, a, b, mask;
+		uint8x16_t last16, t1, t2;
+		uint64x2_t a, b;
 		uint32_t rem = data_len & 15;
 
-		last16 = vld1q_u64((const uint64_t *)&data[data_len - 16]);
-		a = vshift_bytes_left(fold, 16 - rem);
-		b = vshift_bytes_right(fold, rem);
-		mask = vshift_bytes_left(vdupq_n_u64(-1), 16 - rem);
-		b = vorrq_u64(b, vandq_u64(mask, last16));
+		last16 = vld1q_u8((const uint8_t *)&data[data_len - 16]);
+		t1 = vld1q_u8(crc_neon_shift_tab + rem);
+		a  = vreinterpretq_u64_u8(vqtbl1q_u8(vreinterpretq_u8_u64(fold), t1));
+		t2 = vmvnq_u8(t1);
+		t2 = vqtbl1q_u8(vreinterpretq_u8_u64(fold), t2);
+		t1 = vcgezq_s8(vreinterpretq_s8_u8(t1));
+		b  = vreinterpretq_u64_u8(vbslq_u8(t1, last16, t2));
 
 		/* k = rk3 & rk4 */
 		fold = crcr32_folding_round(b, k, a);
@@ -230,14 +251,14 @@ void
 rte_net_crc_neon_init(void)
 {
 	/* Initialize CRC16 data */
-	uint64_t ccitt_k1_k2[2] = {0x14ff2LLU, 0x19a3cLLU};
-	uint64_t ccitt_k3_k4[2] = {0x189aeLLU, 0x8e10LLU};
+	uint64_t ccitt_k1_k2[2] = {0x19a3cLLU, 0x14ff2LLU};
+	uint64_t ccitt_k3_k4[2] = {0x8e10LLU, 0x189aeLLU};
 	uint64_t ccitt_k5_k6[2] = {0x189aeLLU, 0x114aaLLU};
 	uint64_t ccitt_k7_k8[2] = {0x11c581910LLU, 0x10811LLU};
 
 	/* Initialize CRC32 data */
-	uint64_t eth_k1_k2[2] = {0x1c6e41596LLU, 0x154442bd4LLU};
-	uint64_t eth_k3_k4[2] = {0xccaa009eLLU, 0x1751997d0LLU};
+	uint64_t eth_k1_k2[2] = {0x154442bd4LLU, 0x1c6e41596LLU};
+	uint64_t eth_k3_k4[2] = {0x1751997d0LLU, 0xccaa009eLLU};
 	uint64_t eth_k5_k6[2] = {0xccaa009eLLU, 0x163cd6124LLU};
 	uint64_t eth_k7_k8[2] = {0x1f7011640LLU, 0x1db710641LLU};
 
-- 
2.55.0

