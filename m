Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A4ECEB2CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 10:11:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D17AD402DB;
	Sat, 15 Nov 2025 11:11:46 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id D8F5D40288
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:11:45 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-340bcc92c7dso3445141a91.0
 for <dev@dpdk.org>; Sat, 15 Nov 2025 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763201505; x=1763806305; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndGEueWmyJrO9ZfOKgf6CO6BUoI40L0/iTjrKgTLoZc=;
 b=DG1CRYYCbsBAyEm1ckgZ6kYzwhDoswp8fbbxekwvXnnBzrN762mHIWbQchcYp6jYpz
 8lmocRwQm2jtWXfwSXgdc7nwvqwqAKW3LXOMOdES1f4fmGWs0NQRkJsTYMgvPLnW7Zva
 NFHY2ve9GzA3Wg3nfazin+MTeW8eeW4wcGQgIVJj14IMKPmnOie43Ild1OBoEO8UGgcH
 pQN866Dmf40+oAk1qRGmVBXXDMURDGSwmrL3am0SzU6MKLhUMqTCoovmcuqAKYQDWMy0
 8+VFqR0NVIuio4CeB7zUzrrAyoWKQQIsPXN+CDkLZl66SjsxTqDywAFQ2JBAE3lOrNbt
 VnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763201505; x=1763806305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ndGEueWmyJrO9ZfOKgf6CO6BUoI40L0/iTjrKgTLoZc=;
 b=cTksz7La9R5k8Q4RpWqwI+v2/8iUEgJ7jM6hyrc+nLbMCMb8SU2j02cy+OTv3Huun4
 UgTsLXFohxuHz9S95AUGG8jW0tuh7lTi9DoDqF3zvT5O/QoJBdPjaf5dBc15wR+6Tn2q
 suO6Zv3LBMVSCoHyVJDFFLkjtQHdhA3FKxHphbBMk32ci8hVvUYmxZaEoW6T0y/ajzVT
 py2gWiaAJwwhsqU6uEcxo9dmqXuJZmw1KzJJXCMo1mMxfC1GHAp9aeMja9olnxt3bTzt
 KxVOTU1Q9QkDzPrcG8RSjBYuRtyH3vKwdYa+I/0QKAHWHMpGopjNFjO7EFk+HczM/F/0
 zg6A==
X-Gm-Message-State: AOJu0Yzn/hniYGLX3piNJhkPn4feDZKMHf2o47hRyVF/JIkWH5OTNR1S
 x4oRJEBNFZ9v9wFluGfOuuR/1NwRb4r586Y7/0G7sByqUkdoRvbkzrTw
X-Gm-Gg: ASbGncvxIVFIu1IASdq9niWmQzkQ2vls1saY/yrutR46kL8yuiEFDgjiR5ZEcWiRFCJ
 TEvDY8/qBaBVYZyujcEF6+2niPZ4C0hcltttCGAdcMI4NfpyBvSb9rHCN39pOzkbwfucsxzjPe7
 vXvivInLRUp44WFs3W9b3mUY/G3253cOFkswyMNRaEAeWJ9rALFqJs13G35fBcolKutQw8vmdDE
 KN8RNsLuIzsBxAAsCaN8C1IhqpMWFJywrOBpVUgOudw1egyaOwL6W++GwjeJQzWYyG+pWnRsnqc
 1AqrBw2ZiiUzyFufSbjSpHGMZXtBRZDdag4i1MwLtvyAs1IrDkKt/yhPsQ2Rs5uay11YoRIFCR9
 WhFpYISfZTVSpcL/2V0qULzm8WHSYnOiw8aFAvzVdoi1q/4ITsmPk/g1lGOtj7o8WetmVc9H8cf
 Ua1KmPI9ZyEgSzaRk=
X-Google-Smtp-Source: AGHT+IGKQm90bzQoyaW9FDlbAqrlhT9LzobVRqgCvsT1JS0tojhYO4FXkVx0CPflgRBmE3LgnuZnUw==
X-Received: by 2002:a17:90b:4fcc:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-343f8a2ad97mr7508251a91.1.1763201504824; 
 Sat, 15 Nov 2025 02:11:44 -0800 (PST)
Received: from gentoo ([49.204.145.245]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b927826d51sm7737594b3a.49.2025.11.15.02.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 02:11:44 -0800 (PST)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Jasvinder Singh <jasvinder.singh@intel.com>
Cc: dev@dpdk.org
Subject: [PATCH 1/2] net/crc: remove redundant operations in
 crcr32_reduce_64_to_32
Date: Sat, 15 Nov 2025 15:39:58 +0530
Message-ID: <20251115101140.1295642-1-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CA+-x59aamcto-nwQooHFGTN_K_ahE+u7eb_aJG2kk6muo+MnGw@mail.gmail.com>
References: <CA+-x59aamcto-nwQooHFGTN_K_ahE+u7eb_aJG2kk6muo+MnGw@mail.gmail.com>
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

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
 lib/net/net_crc_sse.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index 112dc94ac1..94d847b301 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -96,23 +96,14 @@ crcr32_reduce_128_to_64(__m128i data128, __m128i precomp)
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
--
2.51.0

