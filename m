Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980EDC44507
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Jul 2026 05:20:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D4A94028B;
	Fri, 17 Jul 2026 07:20:20 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 576114028A
 for <dev@dpdk.org>; Fri, 17 Jul 2026 07:20:19 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so5913607a91.0
 for <dev@dpdk.org>; Thu, 16 Jul 2026 22:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784265618; x=1784870418; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hjUc6mu+UJ9SOesQce5F9ELjsYlxcF/vwdcj8DgxX8c=;
 b=dFW90s/AsvIj6elnczV+XK2PpsO9PqyzJkglr81TF6nU3FxFEhnQb8UdtN/jXtz+Cs
 Uhyy0CFsbScy4DAQLUPOVzVaV8Xi/eaZLgSnM4U1AsVa/mzQN802bwds/WqV1ZnV6aJ+
 RC85fheOzeNnJvCQumjeXT+iummlzC7STcijFev4UkDdY97xFwiWzN5zy92rUHeM/wL+
 26D7h5nhkmtP259HRuQKucaMju5fjhhqxWxoyA44aAr/ezvb7TJJYJ7dGZMsU8YVLgBn
 E61nLQhPc+Wc6fm4m3NhupT5vPc1SiuXCUzw6sWMUS3yBJMlw+gU9t9U//0g7HwIBl/N
 xbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784265618; x=1784870418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hjUc6mu+UJ9SOesQce5F9ELjsYlxcF/vwdcj8DgxX8c=;
 b=m8J0qyxcpzF7zYukuVu5yvmyfeqioXxLcb5pTRmsxmUFdmovgyA4D3A41uAnaCNlto
 fgsT6qDq+NdOHLxICSJIV0gcw+BgCoVrd9jNwAPdcE9Ucxi7fmmt5GWjz6gGbT/2Da5q
 4yL46qaZmcw6GoKJX2bc9wTnzxHo09siwpitpM7+caotPZNccwDB2teIdsmxSje7nYuj
 MaLE5RWT/0jV7mCNShW5JspbJP8XiXUdFdVRCodUrhVlAy3r734mGXYUgkkU7cAVvhj1
 HhBnRvXtL4ZsGFoAO/0e+97AmlkOLTnBR+fYfVIwqQHAoZ4kWxkHteAoNdCooKQf2nl3
 NsjQ==
X-Gm-Message-State: AOJu0Yzk9TgQlupKuJMIs3GIbr/L4edndUrbuNh9cCiq0pZwxgqoA43k
 O5lUXlUH9q6K55HhWTYZajYYKD0Ky/6dYXZu4bzsLUK6oMrhZ0/CL9qF
X-Gm-Gg: AfdE7cll0rnPDWCjBZDhmhNRzjJdEeThh7Ro0U3GJ8z/IqPjzvr19gqY5hkz7ugCQDi
 zzMD5oZflIG3r8prsrWbVvsHoM2CBOb3R1ayQG9KP2v0pTpvGqDv11k7hveAWZJFN7pMJjJYnmM
 qDK9XACuT+aiOxaL3ORpqXnK/8I9xXjrHRTtWKJTzrUqAODJRd3A3tBSqvRfjUmd0bzWi+gp8mC
 f7l3YHYNBGc8RRFj/yhfAi+QyZ8sRX2xX/SiHId2/WWe/h+SrUuYYRnMkler0BT+XWQ9djJGbiB
 EvwCEaI5MkX9caoWOZH7oTM24jbtZWQiULl5BayhCKL9dZrUFwqIbX+qiPleecUXaYPSAaJ+rW0
 9uGssbptYqHvfqCQJMYVsEIRdUqb25q3rOfEdGU9ehUcPZz3Fb9L7+1O7acwxsP0jXcVgD7RBaq
 021xfYHw==
X-Received: by 2002:a17:90b:4a08:b0:380:9157:d6c with SMTP id
 98e67ed59e1d1-38e4b41043cmr1158616a91.10.1784265618092; 
 Thu, 16 Jul 2026 22:20:18 -0700 (PDT)
Received: from gentoo ([49.204.145.131]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1dd90fsm2403422eec.22.2026.07.16.22.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 22:20:17 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: cleanup code in net_crc_avx512.c implementation
Date: Fri, 17 Jul 2026 10:50:12 +0530
Message-ID: <20260717052012.460196-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Applies the changes done in SSE implementation to AVX512 implementation.
Specifically includes the following:
1) Consolidate the <16 len cases and removes len 31 to 16 special handling.
2) Replace byte_len_to_mask_table lookup with equivalent C expression.
3) Replace mask, mask2, mask3 arrays with equivalent SIMD expression.
4) Use SSE barrett_reduction logic with same fold constants.
5) Use SSE logic for partial bytes handling in last_two_xmm function.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_avx512.c | 86 ++++++++++------------------------------
 1 file changed, 22 insertions(+), 64 deletions(-)

diff --git a/lib/net/net_crc_avx512.c b/lib/net/net_crc_avx512.c
index 7cd681b1cd..b1a00324e8 100644
--- a/lib/net/net_crc_avx512.c
+++ b/lib/net/net_crc_avx512.c
@@ -23,27 +23,20 @@ struct crc_vpclmulqdq_ctx {
 static alignas(64) struct crc_vpclmulqdq_ctx crc32_eth;
 static alignas(64) struct crc_vpclmulqdq_ctx crc16_ccitt;
 
-static uint16_t byte_len_to_mask_table[] = {
-	0x0000, 0x0001, 0x0003, 0x0007,
-	0x000f, 0x001f, 0x003f, 0x007f,
-	0x00ff, 0x01ff, 0x03ff, 0x07ff,
-	0x0fff, 0x1fff, 0x3fff, 0x7fff,
-	0xffff};
-
 static const alignas(16) uint8_t shf_table[32] = {
-	0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
+	0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
+	0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
 };
 
-static const alignas(16) uint32_t mask[4] = {
-	0xffffffff, 0xffffffff, 0x00000000, 0x00000000
-};
+static __rte_always_inline __m128i
+xmm_shift_left(__m128i reg, const unsigned int num)
+{
+	const __m128i *p = (const __m128i *)(shf_table + 16 - num);
 
-static const alignas(16) uint32_t mask2[4] = {
-	0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
-};
+	return _mm_shuffle_epi8(reg, _mm_loadu_si128(p));
+}
 
 static __rte_always_inline __m512i
 crcr32_folding_round(__m512i data_block, __m512i precomp, __m512i fold)
@@ -93,10 +86,6 @@ last_two_xmm(const uint8_t *data, uint32_t data_len, uint32_t n, __m128i res,
 	uint32_t offset;
 	__m128i res2, res3, res4, pshufb_shf;
 
-	const alignas(16) uint32_t mask3[4] = {
-		   0x80808080, 0x80808080, 0x80808080, 0x80808080
-	};
-
 	res2 = res;
 	offset = data_len - n;
 	res3 = _mm_loadu_si128((const __m128i *)&data[n+offset-16]);
@@ -105,8 +94,7 @@ last_two_xmm(const uint8_t *data, uint32_t data_len, uint32_t n, __m128i res,
 			(shf_table + (data_len-n)));
 
 	res = _mm_shuffle_epi8(res, pshufb_shf);
-	pshufb_shf = _mm_xor_si128(pshufb_shf,
-			_mm_load_si128((const __m128i *) mask3));
+	pshufb_shf = _mm_xor_si128(pshufb_shf, _mm_set1_epi8(0xff));
 	res2 = _mm_shuffle_epi8(res2, pshufb_shf);
 
 	res2 = _mm_blendv_epi8(res2, res3, pshufb_shf);
@@ -140,19 +128,16 @@ done_128(__m128i res, const struct crc_vpclmulqdq_ctx *params)
 static __rte_always_inline uint32_t
 barrett_reduction(__m128i data64, const struct crc_vpclmulqdq_ctx *params)
 {
-	__m128i tmp0, tmp1;
+	__m128i tmp0;
 
-	data64 =  _mm_and_si128(data64, *(const __m128i *)mask2);
+	data64 = _mm_blend_epi16(data64, _mm_setzero_si128(), 0x3);
 	tmp0 = data64;
-	tmp1 = data64;
 
-	data64 = _mm_clmulepi64_si128(tmp0, params->rk7_rk8, 0x0);
-	data64 = _mm_ternarylogic_epi64(data64, tmp1, *(const __m128i *)mask,
-			0x28);
+	data64 = _mm_clmulepi64_si128(data64, params->rk7_rk8, 0x0);
+	data64 = _mm_xor_si128(data64, tmp0);
 
-	tmp1 = data64;
 	data64 = _mm_clmulepi64_si128(data64, params->rk7_rk8, 0x10);
-	data64 = _mm_ternarylogic_epi64(data64, tmp1, tmp0, 0x96);
+	data64 = _mm_xor_si128(data64, tmp0);
 
 	return _mm_extract_epi32(data64, 2);
 }
@@ -165,9 +150,8 @@ reduction_loop(__m128i *fold, int *len, const uint8_t *data, uint32_t *n,
 
 	tmp = _mm_clmulepi64_si128(*fold, params->fold_1x128b, 0x1);
 	*fold = _mm_clmulepi64_si128(*fold, params->fold_1x128b, 0x10);
-	*fold = _mm_xor_si128(*fold, tmp);
 	tmp1 = _mm_loadu_si128((const __m128i *)&data[*n]);
-	*fold = _mm_xor_si128(*fold, tmp1);
+	*fold = _mm_ternarylogic_epi64(*fold, tmp, tmp1, 0x96);
 	*n += 16;
 	*len -= 16;
 }
@@ -229,7 +213,7 @@ crc32_eth_calc_vpclmulqdq(const uint8_t *data, uint32_t data_len, uint32_t crc,
 			res = last_two_xmm(data, data_len, n, res,
 					params);
 	} else {
-		if (data_len > 31) {
+		if (data_len >= 16) {
 			res = _mm_cvtsi32_si128(crc);
 			d = _mm_loadu_si128((const __m128i *)data);
 			res = _mm_xor_si128(res, d);
@@ -244,41 +228,15 @@ crc32_eth_calc_vpclmulqdq(const uint8_t *data, uint32_t data_len, uint32_t crc,
 			if (n != data_len)
 				res = last_two_xmm(data, data_len, n, res,
 						params);
-		} else if (data_len > 16) {
-			res = _mm_cvtsi32_si128(crc);
-			d = _mm_loadu_si128((const __m128i *)data);
-			res = _mm_xor_si128(res, d);
-			n += 16;
-
-			if (n != data_len)
-				res = last_two_xmm(data, data_len, n, res,
-						params);
-		} else if (data_len == 16) {
-			res = _mm_cvtsi32_si128(crc);
-			d = _mm_loadu_si128((const __m128i *)data);
-			res = _mm_xor_si128(res, d);
 		} else {
 			res = _mm_cvtsi32_si128(crc);
-			d = _mm_maskz_loadu_epi8(byte_len_to_mask_table[data_len], data);
+			d = _mm_maskz_loadu_epi8((1 << data_len) - 1, data);
 			res = _mm_xor_si128(res, d);
-
-			if (data_len > 3) {
-				d = _mm_loadu_si128((const __m128i *)
-						&shf_table[data_len]);
-				res = _mm_shuffle_epi8(res, d);
-			} else if (data_len > 2) {
-				res = _mm_slli_si128(res, 5);
-				goto do_barrett_reduction;
-			} else if (data_len > 1) {
-				res = _mm_slli_si128(res, 6);
-				goto do_barrett_reduction;
-			} else if (data_len > 0) {
-				res = _mm_slli_si128(res, 7);
+			if (data_len < 4) {
+				res = xmm_shift_left(res, 8 - data_len);
 				goto do_barrett_reduction;
-			} else {
-				/* zero length case */
-				return crc;
 			}
+			res = xmm_shift_left(res, 16 - data_len);
 		}
 	}
 
@@ -316,7 +274,7 @@ crc32_load_init_constants(void)
 	uint64_t c18 = 0x00000000ccaa009e;
 	uint64_t c19 = 0x00000000b8bc6765;
 	uint64_t c20 = 0x00000001f7011640;
-	uint64_t c21 = 0x00000001db710640;
+	uint64_t c21 = 0x00000001db710641;
 
 	a = _mm_set_epi64x(c1, c0);
 	crc32_eth.rk1_rk2 = _mm512_broadcast_i32x4(a);
@@ -360,7 +318,7 @@ crc16_load_init_constants(void)
 	uint64_t c18 = 0x00000000000081bf;
 	uint64_t c19 = 0x0000000000001cbb;
 	uint64_t c20 = 0x000000011c581910;
-	uint64_t c21 = 0x0000000000010810;
+	uint64_t c21 = 0x0000000000010811;
 
 	a = _mm_set_epi64x(c1, c0);
 	crc16_ccitt.rk1_rk2 = _mm512_broadcast_i32x4(a);
-- 
2.54.0

