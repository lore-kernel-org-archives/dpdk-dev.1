Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896BCD8CAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 07:57:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA16C402AD;
	Tue,  9 Jun 2026 09:57:19 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 50E29402AD
 for <dev@dpdk.org>; Tue,  9 Jun 2026 09:57:18 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36ba3ea5c46so3030373a91.1
 for <dev@dpdk.org>; Tue, 09 Jun 2026 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780991837; x=1781596637; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3HMUe6Wxn4SMispiC0XY2fTVogFhnA8/7k1la35789s=;
 b=nkgZ6MzpH3KU7KFpmZOiF3m6Bh9KP4du8aCRfO0BS4SC6ZzSBsu/HeSIZ1AGxbesWI
 jh6viLqPNcPz8N64xrTPmsWrDl0YSKFPmaS0bW9ZNHm7ExsZizjl6zruekk5o66EAvLC
 pGtow+6hyOoNGcnM7U9vApmQRq8fIAG2fWB+prqf0261sKF18Z2xIZuyS0sxolVi2GNf
 MHgpyFPvXtCFyWg3SjQZ7rtQZm4PErmYdt7QfiZ63Sn+6rhFgrnHapX6J5o24k/bOI0q
 oAAhYvXTG18GaKIeEr3h7n360HXl1KJAvYNTjBdhH1MnzhPnLkl747NPZZDjpwS7GZns
 7E7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780991837; x=1781596637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HMUe6Wxn4SMispiC0XY2fTVogFhnA8/7k1la35789s=;
 b=Ywlhu4KcyXlbzEIRXuFka8LNACkNs5hJHktpUdvTKvK6qt2GLfkT6c76w/Ia0M+gKT
 8tXX6OY2n9Dofb1cIOXk8zQAhVqz2vUPeS6XqT706xdCrgGLaxe8ZA9POdwSV2Y7aIEp
 FUEO7xMJj6SdOssGPjNcG/tch8iKdCVWqY0M7Lr0k6pEcB9sbQFUIT2pSfx7MLwQUMUr
 Gy2NAXK8oK5+us/k8e9ArkTf1Qv1r8HQoSbm3rhzi5p31jBZpX0nY0BGfsIquvbM2zsb
 ciYia4hKJ8BArMR/o9ueO4z39gUlWCiu6F14viDbwBsPvAI75ld1+WNxYrspafmhXrPH
 6gxg==
X-Gm-Message-State: AOJu0YzYuCup4MkNTHcRgYh42dEomg1jZ3R6L9idCOLxiQ2ZZyu4Kxdk
 UPa/XB/eRU3hyDinF8wUkVlw2Tzf2NRhPM0pe+uVQPSCc6F4Y4pYQj7a
X-Gm-Gg: Acq92OFOvcloRpG6jHfUw7YwBvur56fxJDizCcQoOSEqtz9+F9l9VjJWeAV9GvjFoLv
 yVh+sIj4/7Qf3BNKhYygACSWsL4T5Ot5s0WAklXcVdime6jiBAhzs1nwo/UBwG+nASAjKo5ZLNa
 aAdjpYvsdMQrx/JJQNKTiDEY/7JMMONRW9rASMq0jqWXX/fBpaaJyCklOVS0oBkqCmGe2uFw1X1
 vzmFD1dwPniL6XPscVapG/qhHf7NxOsChie8EnYRW9jcOX2rcgcZh2HaNPF558NuzHGbHAYALqb
 m1GWPU1VBa+i1ih7sN9O29VEXV89PDDSk1WRN6+jv6kMJDy04aZ+cpTpY0VwArNxXrubiG9AxrG
 V2uXzTFuIIN7BPku9pK3Skepmow7R+LzmvFXo/mDxcI2CcLu3WfbkWgr2KBQObHnVHZgtievF/k
 AXerKAYvnU4b5qvPp3Nb3Vv3TtYqEuiVk02DTvgA==
X-Received: by 2002:a17:90b:5111:b0:36a:aa9:eea0 with SMTP id
 98e67ed59e1d1-370ee6437b0mr19552765a91.4.1780991837376; 
 Tue, 09 Jun 2026 00:57:17 -0700 (PDT)
Received: from gentoo ([49.204.144.118]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f890b2sm205229675ad.26.2026.06.09.00.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:57:16 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: add 4x folding loop for x86 SSE implementation
Date: Tue,  9 Jun 2026 13:27:12 +0530
Message-ID: <20260609075712.247286-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Add a 64-byte loop that maintains 4 fold registers and processes
64 bytes at a time. The 4x fold registers is then reduced to 16 byte
single fold, similar to AVX512 implementation. This technique is
described in the paper by Intel:
"Fast CRC Computation for Generic Polynomials Using PCLMULQDQ Instruction"

This results in roughly 50% performance improvement due to better ILP
for large input sizes like 1024.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_sse.c | 59 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index 3b6fbfecac..dfef8ecc59 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -14,6 +14,7 @@
 /** PCLMULQDQ CRC computation context structure */
 struct crc_pclmulqdq_ctx {
 	__m128i rk1_rk2;
+	__m128i rk3_rk4;
 	__m128i rk5_rk6;
 	__m128i rk7_rk8;
 };
@@ -150,9 +151,36 @@ crc32_eth_calc_pclmulqdq(
 	temp = _mm_insert_epi32(_mm_setzero_si128(), crc, 0);
 
 	/**
-	 * Folding all data into single 16 byte data block
-	 * Assumes: fold holds first 16 bytes of data
+	 * Folding all data into 4 parallel 16 byte data block
+	 * Later folds 4 parallel blocks into single fold block
 	 */
+	if (likely(data_len >= 64)) {
+		__m128i fold1, fold2, fold3, fold4;
+		__m128i temp1, temp2, temp3, temp4;
+		fold1 = _mm_loadu_si128((const __m128i *)(data +  0));
+		fold2 = _mm_loadu_si128((const __m128i *)(data + 16));
+		fold3 = _mm_loadu_si128((const __m128i *)(data + 32));
+		fold4 = _mm_loadu_si128((const __m128i *)(data + 48));
+		fold1 = _mm_xor_si128(fold1, temp);
+		k = params->rk1_rk2;
+
+		for (n = 64; (n + 64) <= data_len; n += 64) {
+			temp1 = _mm_loadu_si128((const __m128i *)&data[n]);
+			temp2 = _mm_loadu_si128((const __m128i *)&data[n + 16]);
+			temp3 = _mm_loadu_si128((const __m128i *)&data[n + 32]);
+			temp4 = _mm_loadu_si128((const __m128i *)&data[n + 48]);
+			fold1 = crcr32_folding_round(temp1, k, fold1);
+			fold2 = crcr32_folding_round(temp2, k, fold2);
+			fold3 = crcr32_folding_round(temp3, k, fold3);
+			fold4 = crcr32_folding_round(temp4, k, fold4);
+		}
+
+		k = params->rk3_rk4;
+		fold1 = crcr32_folding_round(fold2, k, fold1);
+		fold1 = crcr32_folding_round(fold3, k, fold1);
+		fold = crcr32_folding_round(fold4, k, fold1);
+		goto single_fold_loop;
+	}
 
 	if (unlikely(data_len < 32)) {
 		if (unlikely(data_len == 16)) {
@@ -182,7 +210,7 @@ crc32_eth_calc_pclmulqdq(
 		fold = _mm_loadu_si128((const __m128i *)data);
 		fold = _mm_xor_si128(fold, temp);
 		n = 16;
-		k = params->rk1_rk2;
+		k = params->rk3_rk4;
 		goto partial_bytes;
 	}
 
@@ -191,9 +219,12 @@ crc32_eth_calc_pclmulqdq(
 	fold = _mm_loadu_si128((const __m128i *)data);
 	fold = _mm_xor_si128(fold, temp);
 
-	/** Main folding loop - the last 16 bytes is processed separately */
-	k = params->rk1_rk2;
-	for (n = 16; (n + 16) <= data_len; n += 16) {
+	/** Single folding loop - the last 16 bytes is processed separately */
+	k = params->rk3_rk4;
+	n = 16;
+
+single_fold_loop:
+	for (; (n + 16) <= data_len; n += 16) {
 		temp = _mm_loadu_si128((const __m128i *)&data[n]);
 		fold = crcr32_folding_round(temp, k, fold);
 	}
@@ -236,12 +267,14 @@ crc32_eth_calc_pclmulqdq(
 void
 rte_net_crc_sse42_init(void)
 {
-	uint64_t k1, k2, k5, k6;
+	uint64_t k1, k2, k3, k4, k5, k6;
 	uint64_t p = 0, q = 0;
 
 	/** Initialize CRC16 data */
-	k1 = 0x189aeLLU;
-	k2 = 0x8e10LLU;
+	k1 = 0x14ff2LLU;
+	k2 = 0x19a3cLLU;
+	k3 = 0x189aeLLU;
+	k4 = 0x8e10LLU;
 	k5 = 0x189aeLLU;
 	k6 = 0x114aaLLU;
 	q =  0x11c581910LLU;
@@ -249,12 +282,15 @@ rte_net_crc_sse42_init(void)
 
 	/** Save the params in context structure */
 	crc16_ccitt_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
+	crc16_ccitt_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
 	crc16_ccitt_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
 	crc16_ccitt_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
 
 	/** Initialize CRC32 data */
-	k1 = 0xccaa009eLLU;
-	k2 = 0x1751997d0LLU;
+	k1 = 0x1c6e41596LLU;
+	k2 = 0x154442bd4LLU;
+	k3 = 0xccaa009eLLU;
+	k4 = 0x1751997d0LLU;
 	k5 = 0xccaa009eLLU;
 	k6 = 0x163cd6124LLU;
 	q =  0x1f7011640LLU;
@@ -262,6 +298,7 @@ rte_net_crc_sse42_init(void)
 
 	/** Save the params in context structure */
 	crc32_eth_pclmulqdq.rk1_rk2 = _mm_set_epi64x(k2, k1);
+	crc32_eth_pclmulqdq.rk3_rk4 = _mm_set_epi64x(k4, k3);
 	crc32_eth_pclmulqdq.rk5_rk6 = _mm_set_epi64x(k6, k5);
 	crc32_eth_pclmulqdq.rk7_rk8 = _mm_set_epi64x(p, q);
 }
-- 
2.53.0

