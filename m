Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A3CCA476
	for <dpdk-dev@archiver.kernel.org>; Sat, 11 Oct 2025 11:32:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5C004021F;
	Sat, 11 Oct 2025 13:32:16 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 17966400EF
 for <dev@dpdk.org>; Sat, 11 Oct 2025 13:32:16 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2680cf68265so22013775ad.2
 for <dev@dpdk.org>; Sat, 11 Oct 2025 04:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760182335; x=1760787135; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RPfDxC1KxipnSDW7d5GKHNQO6+NyDq+TGjeHJL6I6Xs=;
 b=X0jTukbLVWUjly+jTLE5EK66akG0ocLNdabN9VClIJMjZeacBM+orHuCoMIHiBhWc9
 VY1pTZjrhGzi37n9WtG6htlu7CPLUKl0U9C70G5kgyU10YEn+Cjt955ui8z66kkV5YYP
 GhhS+7kjc0nJrkJG6D2EtFPbBHShaCw6idNzlZGGs6o2tuDsui5IoGejwEKXzBzi5Zcm
 5WZJLCw4Z0qBLg0TTvsQil0nj7YQ15XhiURPNcrquyzzpcn54urff32P+MRAUDcLPtGZ
 Foh3z99Dsh5UivQ/pG9Y89kytF6nS6XdckhBuGsqwQdekCp8OiHbYLJZCYiM8aW/rwPv
 U+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760182335; x=1760787135;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPfDxC1KxipnSDW7d5GKHNQO6+NyDq+TGjeHJL6I6Xs=;
 b=awjnZ+/DIKFrQHoDQw5FKv5aYC0ICErSO6mXWKepjQxIzZuooaweLedPzaWFUWCZlM
 UPns5Wy3INsmr716hKlu6kxwPpWrQ9BRH27ZPFSZpUYveDHYqrUE8g3tAP1foktmt9mS
 kzkeUIdpIITjKsD7M0IHg1/UblwsYuSrrE4emkNW2fMmTxjL2WhPC+/WPVwKGzamSUHR
 8ZScV3yXMhnIZHFkEl08Emhw6TgyXpRhZuydSfO665CGC2Z/nrCgzZ1Ff805u40uaWt/
 P4Am+zyWG6OoQa76xpS6UQgaEIDUZDtl+8PQOF05pdyytjGPONYDsCMR6++Ee+aXNH7L
 eT8Q==
X-Gm-Message-State: AOJu0YwRP9akbFO4HwVgmT8OOGMWPqhdFsuC4L6gAckV40UEcvupSpNM
 xhr/pMuX6UqSec4jwN69tEG1KnKbT1CeFciS7WWrddzR+OEuhIIx8v4W
X-Gm-Gg: ASbGncta7H69UIRq6b0mOyQ4vC4oyyf5pCfF+1ABfV15HNyyVsRB5FsZ0ZOLks0JktG
 Den8ofbGC95xdLgziLRiHo2HqMHwo5N587ixap75CU6Ep5RnJg3IGzJdsrBpzJAPNREjmvYLG38
 q+xmMtsuZuWebBaJwsDakaew+TMACyH4K4RNlzv3lpLPRBtfzm5tT/mKp51iq1sefRYN40IvUpl
 iXy0SK1NATVmqTRyrZCA9X4a0yXPAHxCpjU4i3HBnCFv5h6KOsP0/xf1jn+E0rkRHFXCdBBBXv0
 c5BKvauQZLHeDvSObg3OAnQv4i1HxUIu7H6+jlwCmeGX11uiCEmAbxcsDDMWFV4CjuKgCrjFFfh
 luWM2So+YCPj5NXD9ioT5WQG6tf3GMwBBWS0xgnd4btKFw67KCj2it81mCh1qqVFgiAFEYnRHr9
 Y=
X-Google-Smtp-Source: AGHT+IES8UhBhHnT9HUNO1r68o7KM/8VK8qg5HFIO8fKWEvrRG9DSLc2fw+0jfApqBJRk0KeSSPSbg==
X-Received: by 2002:a17:903:3847:b0:24a:fab6:d15a with SMTP id
 d9443c01a7336-29027240d1bmr206479485ad.20.1760182334993; 
 Sat, 11 Oct 2025 04:32:14 -0700 (PDT)
Received: from localhost.localdomain ([49.204.145.40])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f08de5sm82413305ad.83.2025.10.11.04.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 04:32:14 -0700 (PDT)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Sat, 11 Oct 2025 16:59:34 +0530
Message-ID: <20251011113202.937991-1-16567adigashreesh@gmail.com>
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
Remove the clearing of upper 64 bits of tmp1 as it is redundant.
tmp1 after clearing upper bits was being xor with tmp2 before the
bits 96:65 from tmp2 were returned. The xor operation of bits 96:65
remains unchanged due to tmp1 having bits 96:64 cleared to 0.
After removing the xor operation, the clearing of upper 64 bits of tmp1
becomes redundant and hence can be removed.
Clang is able to optimize away the AND + memory operand with the
above sequence, however GCC is still emitting the code for AND with
memory operands which is being explicitly eliminated here.

Additionally replace the 48 byte crc_xmm_shift_tab with the contents of
shf_table which is 32 bytes, achieving the same functionality.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
Changes since v1:
Reversed the operands in the blend operation for readability.
Removed tmp1 operations that are not affecting the result and hence
avoid clearing the upper 64 bits for tmp1.

 lib/net/net_crc_sse.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index 112dc94ac1..e590aeb5ac 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -96,35 +96,24 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
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
+	tmp0 = _mm_blend_epi16(data64, _mm_setzero_si128(), 0x3);

 	tmp1 = _mm_clmulepi64_si128(tmp0, precomp, 0x00);
 	tmp1 = _mm_xor_si128(tmp1, tmp0);
-	tmp1 = _mm_and_si128(tmp1, _mm_load_si128((const __m128i *)mask1));

 	tmp2 = _mm_clmulepi64_si128(tmp1, precomp, 0x10);
-	tmp2 = _mm_xor_si128(tmp2, tmp1);
 	tmp2 = _mm_xor_si128(tmp2, tmp0);

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
@@ -216,19 +205,12 @@ crc32_eth_calc_pclmulqdq(
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

