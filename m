Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53870CD98C7
	for <dpdk-dev@archiver.kernel.org>; Fri, 12 Jun 2026 02:51:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B2254326C;
	Fri, 12 Jun 2026 04:51:42 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 950794027F
 for <dev@dpdk.org>; Fri, 12 Jun 2026 04:51:41 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2bf125989f2so3942095ad.3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781232701; x=1781837501; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KbyppwhQo7BPCWBl+8ZBYyyBdrZot/LgzGV+TX/6FSQ=;
 b=cL2wJFkCK58Cjynj/39YcO+ux6gkd3e532/O2oWMhdf4Ws3X3mRBdDNGGLz6VPCUkL
 +Rb4qYInb0vcgak0QdSqVMTeZYrOh/epEKe1NH46rv0b44N6dOomjN24qFNgRALoAZ9B
 EQn7SnQ1eiAoB4apvnKnspnYo2D+e4l2lRQ4SNN0gWZ2I6I+hN8Kncmq1EhBTBvWtGLW
 Qs1il3tIpezoRUWpdgcmPtr3vFUFqzshlCDQJtewnkd8mFwExhY7/YNk0CEy1Qd0/XGG
 xU7B9VBv4P3ldPOJ6l3tYijh5FBVLd7mckBzoMlv/JPriQZTulGfPXqBSZB78+EYIs3Y
 U3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781232701; x=1781837501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbyppwhQo7BPCWBl+8ZBYyyBdrZot/LgzGV+TX/6FSQ=;
 b=ZhNQ1LnJp/SQj/chy6qoTekoroFn/ZFMkL1IgzvrWNeKNyxMI+ZBHPsUwhDBgCJtrB
 GQtQXQxx7TA9dcOpW5I2DBKvZEbNKcH60B5quP3eHoQubQcHsu1OB3oXtvXY1XGcK7+x
 9zjyXHJJRJOoKT1RFcEp8B0vNC0N5GlzH08oj45dyXEx4J90HcqEhWmoZTB7SlRDBL2n
 TEK5NYY6xwrr3CLq/37d81uuGb6fRDWJb2JryWUw0Mx7vgxgFfU4GfsI1TlaNTy8TtKu
 8Gd0Q14CE/hMT01MZFbb++nDL4ujWhsAMKy8Z9K/DFKz1JXRhev+RU1qdZw3dPKbQNH3
 5dlQ==
X-Gm-Message-State: AOJu0Yx3nfHhweMrY4U9VQ/tZ6DYjspMX1FlMmEz5VTeTYbUBy1AICSn
 KKwDL2t7LXPAzds3ukVyDAH3tC1SLH6J+HRdFKWwFMYjIk5rHCv6JLW8
X-Gm-Gg: Acq92OHf9o0A9EtIP09DRay1oCC6TQ/EOPTChZ55pVnRxRzjcAkXrp481wOL2ZD3TBG
 0jMziNca1MeWGYTjVQlSI708rcKbKezGXVqexAirZ9nvGQEUvXJUR1S37tkrwwfxIVXAo9r4T9S
 1JQR8ABYMD9jtPObx0ey4opettFDl0AsBUuaGNMvp7rOrtN8WDmtNXG2ubmGLnLlTPUmykJF8yW
 IrB3xuSG4dPZZndJB1ZygZt06s0hnuqeVwyDQuHxkoHGjbsKEV6N5XiMU8BcAft8DmLW+DzJkba
 8YQ4SIhMhH0E2CwybBgN4XU61N4de0tz04w95JhsWfoTp/ZXAtRuBieHUAV8Z2N+1zvjXMzOMi9
 eUMZJZHlBLIlDN6uOOLhQzUEo7ehxC9z4RyHxIr/nSWdj594nJdH49M6qBtTwrYbPupsr27Ayj+
 OmGjkWIbcZp5mhQ34Z/vBH+QWWYi4=
X-Received: by 2002:a17:902:e746:b0:2c2:2a8a:af74 with SMTP id
 d9443c01a7336-2c411f6edfbmr11441775ad.15.1781232700667; 
 Thu, 11 Jun 2026 19:51:40 -0700 (PDT)
Received: from gentoo ([49.204.144.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432d8a039sm3062835ad.62.2026.06.11.19.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 19:51:40 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: cleanup code in net_crc_sse.c implementation
Date: Fri, 12 Jun 2026 08:21:35 +0530
Message-ID: <20260612025135.298226-1-16567adigashreesh@gmail.com>
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

Special handling for len between 16 and 31 is not required as the
implementation correctly handles them in the main path. Given that these
cases were annotated with unlikely branch hint, it should be simpler to
have these handled in the main path itself.

We can remove the partial_bytes label as there is no jump target to it,
and replace folding code in that block with already existing inline
function to simplify and have better code reuse.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_sse.c | 53 ++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index dfef8ecc59..e30f8544fc 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -182,39 +182,24 @@ crc32_eth_calc_pclmulqdq(
 		goto single_fold_loop;
 	}
 
-	if (unlikely(data_len < 32)) {
-		if (unlikely(data_len == 16)) {
-			/* 16 bytes */
-			fold = _mm_loadu_si128((const __m128i *)data);
-			fold = _mm_xor_si128(fold, temp);
-			goto reduction_128_64;
-		}
+	if (unlikely(data_len < 16)) {
+		/* 0 to 15 bytes */
+		alignas(16) uint8_t buffer[16];
 
-		if (unlikely(data_len < 16)) {
-			/* 0 to 15 bytes */
-			alignas(16) uint8_t buffer[16];
-
-			memset(buffer, 0, sizeof(buffer));
-			memcpy(buffer, data, data_len);
-
-			fold = _mm_load_si128((const __m128i *)buffer);
-			fold = _mm_xor_si128(fold, temp);
-			if (unlikely(data_len < 4)) {
-				fold = xmm_shift_left(fold, 8 - data_len);
-				goto barret_reduction;
-			}
-			fold = xmm_shift_left(fold, 16 - data_len);
-			goto reduction_128_64;
-		}
-		/* 17 to 31 bytes */
-		fold = _mm_loadu_si128((const __m128i *)data);
+		memset(buffer, 0, sizeof(buffer));
+		memcpy(buffer, data, data_len);
+
+		fold = _mm_load_si128((const __m128i *)buffer);
 		fold = _mm_xor_si128(fold, temp);
-		n = 16;
-		k = params->rk3_rk4;
-		goto partial_bytes;
+		if (unlikely(data_len < 4)) {
+			fold = xmm_shift_left(fold, 8 - data_len);
+			goto barret_reduction;
+		}
+		fold = xmm_shift_left(fold, 16 - data_len);
+		goto reduction_128_64;
 	}
 
-	/** At least 32 bytes in the buffer */
+	/** At least 16 bytes in the buffer */
 	/** Apply CRC initial value */
 	fold = _mm_loadu_si128((const __m128i *)data);
 	fold = _mm_xor_si128(fold, temp);
@@ -229,7 +214,7 @@ crc32_eth_calc_pclmulqdq(
 		fold = crcr32_folding_round(temp, k, fold);
 	}
 
-partial_bytes:
+	/** Partial bytes - process last <16 bytes */
 	if (likely(n < data_len)) {
 
 		__m128i last16, a, b;
@@ -244,12 +229,8 @@ crc32_eth_calc_pclmulqdq(
 		b = _mm_shuffle_epi8(fold, temp);
 		b = _mm_blendv_epi8(b, last16, temp);
 
-		/* k = rk1 & rk2 */
-		temp = _mm_clmulepi64_si128(a, k, 0x01);
-		fold = _mm_clmulepi64_si128(a, k, 0x10);
-
-		fold = _mm_xor_si128(fold, temp);
-		fold = _mm_xor_si128(fold, b);
+		/* k = rk3 & rk4 */
+		fold = crcr32_folding_round(b, k, a);
 	}
 
 	/** Reduction 128 -> 32 Assumes: fold holds 128bit folded data */
-- 
2.53.0

