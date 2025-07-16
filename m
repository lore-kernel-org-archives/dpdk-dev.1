Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0568FC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:34:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3BBDA4021E;
	Wed, 16 Jul 2025 12:34:54 +0200 (CEST)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 419C54013F
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:34:52 +0200 (CEST)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-234c5b57557so65119275ad.3
 for <dev@dpdk.org>; Wed, 16 Jul 2025 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752662091; x=1753266891; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0W6yaHw7uFNa6tOsiJuU/qYA7LiRugvvuabO7K3nZyg=;
 b=lqGyWBXhsB+Ilh+FLWdWGJ6vLp1O43FSH59IXkx/dL2I2dSIHo1oBcfutHTN1+uUs7
 1/ejINX1AMDvRkw72Qja3sQeMrzeVGOinZSQyaVFABWV9VErwoSx/Q5v3j8y57JyTxhV
 2joW7pQBovit2JhmCOyyu5bgbQrERlTuxIZwnOP/CcExno0dLIMT+hDGiTZo8WysWORe
 6ZKX/vMSnfay2nuZgVmRq+yhNUITSygQ5a06KB8dOkYEaIrwP1twVG2VQCwXSPHIab1A
 kDE/bJ2wb6Jl5XEvC21ZUzP5W1qauGtwXLYGjT+So5vS5v1H7QU2ww62Xm/ULsV/06B6
 pGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662091; x=1753266891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0W6yaHw7uFNa6tOsiJuU/qYA7LiRugvvuabO7K3nZyg=;
 b=UtlYzhFD8VjMETmnETaCgLjx2pQiISQX7ROLLKG0bi55B+fLFq2CFrmDTc+NhlNr3+
 cPIeXv8KcGNGkUSXhgXTPcci9V8NnHiV/IQpknUK8JdoQjZyutTgWK5Iiofw/RRXt0lL
 QtUGRpc3kY2g5MSMuTG7qyZPNe6bFEqok07D1HUQDeA2gY46xKzsKNzfO3XmGsrz6PGT
 O54clq3W+rHpXV2dOsGU+YjlKXnBoEQTNZTKaXzQKvREIYG5aE/r46JCAsQfWYvIrPPc
 GtJEhtHbl5IGQJQX2gfvynISyKDbDtuODdjOoKXl75RCFtnS/msN0WJ5AMnzWK12QIEn
 CJTQ==
X-Gm-Message-State: AOJu0YwtvpcFxJprFTdXo1ePxJI+YdJYJBW+Q5Q/p3FnBe5uJDdKkqHl
 PLKpGF5EQRCu3M3mUWUHD83Tf6ltgDcJZe7dJTzBvro1L9Hb9rXS/nJeBfebopEA
X-Gm-Gg: ASbGncvXo9tc2aFtHhCyumhhRtv+r21b4ATvd1K3foK7USLhLkFFbxuYtn/FBYEdW3y
 h8jf9YKssj4r6uwRSRvpCFDTeZqCCW3xmWaRzgj2/EsDofB3624LRxvPLmRNB/fFDfL5ZPK7ZiJ
 pAQG+ajcmqPrCSDAv65zRO2tuU3tgHLRjqlqLsfHb4df0YWf9j+ORLDnN4nRMsONgM+ILLnwCft
 stmp8XyqXPmxqaI7Ephll3xR0SuMp26HOs+sxHZBoeolqvtBKzjFjz+BjBxmR6ZEDgWtdE3uNnh
 rS9pYThOTYyz9vatWdmP8DB9vUCsFEjnh901ZjJDJXjG5/oB9Beph+0CV7ewQ8dzbHxxCBXQyh+
 nlSeyD9nZwx/4QCxzFlhU1VnUNGSEavykSQQ6EP5SW+EM
X-Google-Smtp-Source: AGHT+IGk1OCrBENLss/GAAh0HRx6x+tLS8LZnctFZZ38jh+f6Qk3/KExYZJu+2tdlZOIwt2GfCKc+g==
X-Received: by 2002:a17:902:f601:b0:23d:da5b:f819 with SMTP id
 d9443c01a7336-23e256ade01mr35864515ad.12.1752662091163; 
 Wed, 16 Jul 2025 03:34:51 -0700 (PDT)
Received: from localhost.localdomain ([106.51.30.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4286d8csm128944855ad.33.2025.07.16.03.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:34:50 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Wed, 16 Jul 2025 16:04:39 +0530
Message-ID: <20250716103439.831760-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.49.1
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

Replace the clearing of lower 32 bits of XMM register with blend of
zero register.
Replace the clearing of upper 64 bits of XMM register with _mm_move_epi64.
Clang is able to optimize away the AND + memory operand with the
above sequence, however GCC is still emitting the code for AND with
memory operands which is being explicitly eliminated here.

Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
shf_table which is 32 bytes, achieving the same functionality.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_sse.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index 112dc94ac1..eec854e587 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -96,20 +96,13 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
 static __rte_always_inline uint32_t
 crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
 {
-	static const alignas(16) uint32_t mask1[4] = {
-		0xffffffff, 0xffffffff, 0x00000000, 0x00000000
-	};
-
-	static const alignas(16) uint32_t mask2[4] = {
-		0x00000000, 0xffffffff, 0xffffffff, 0xffffffff
-	};
 	__m128i tmp0, tmp1, tmp2;
 
-	tmp0 = _mm_and_si128(data64, _mm_load_si128((const __m128i *)mask2));
+	tmp0 = _mm_blend_epi16(_mm_setzero_si128(), data64, 252);
 
 	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x00);
 	tmp1 = _mm_xor_si128(tmp1, tmp0);
-	tmp1 = _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask1));
+	tmp1 = _mm_move_epi64(tmp1);
 
 	tmp2 = _mm_clmulepi64_si128(tmp1, precomp, 0x10);
 	tmp2 = _mm_xor_si128(tmp2, tmp1);
@@ -118,13 +111,11 @@ crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
 	return _mm_extract_epi32(tmp2, 2);
 }
 
-static const alignas(16) uint8_t crc_xmm_shift_tab[48] = {
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+static const alignas(16) uint8_t crc_xmm_shift_tab[32] = {
+	0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
+	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
 };
 
 /**
@@ -216,19 +207,12 @@ crc32_eth_calc_pclmulqdq(
 			0x80808080, 0x80808080, 0x80808080, 0x80808080
 		};
 
-		const alignas(16) uint8_t shf_table[32] = {
-			0x00, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-			0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
-			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-			0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
-		};
-
 		__m128i last16, a, b;
 
 		last16 = _mm_loadu_si128((const __m128i *)&data[data_len - 16]);
 
 		temp = _mm_loadu_si128((const __m128i *)
-			&shf_table[data_len & 15]);
+			&crc_xmm_shift_tab[data_len & 15]);
 		a = _mm_shuffle_epi8(fold, temp);
 
 		temp = _mm_xor_si128(temp,
-- 
2.49.1

