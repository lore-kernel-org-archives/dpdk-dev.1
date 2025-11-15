Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DBCEB2CA
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 10:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC96040B90;
	Sat, 15 Nov 2025 11:11:48 +0100 (CET)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 0ADE140A89
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:11:48 +0100 (CET)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-343806688c5so2683416a91.0
 for <dev@dpdk.org>; Sat, 15 Nov 2025 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763201507; x=1763806307; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uESUd1ES6cjn8xpvK7qG9/H6wg6JfOGQrzPE3peob0Q=;
 b=MQ1ig9pWVg9K9nJKkoDGfSJXKg9+Tq8fso068zoPkomVGt9TMsVkVWdgaYFmeyHgqn
 af4Y/XR5i0dmERqBtHmQXjxXs41n59g4NIWDGkhHnmVRIoJUjS+7bIcyow8uMZCG2Nz0
 ivsxomdekfNEegIS+kHRx9Bq02/CwR0YgkGCXUQkZrpzAMavGs/ZAMxgIY+fSWmePNGS
 WO8/V+xGJiC6qn1/5ogEO433kJ2igPtcOqdbyKJNoVkRjPo1ASU3K8PfGDmPM6PvYWuF
 /t7McZQSmNJQp2+OLeQ1oIZmHtSHz6+X163DRz5FZ20PoxpxzX+/6sdEMW+koELZn5X2
 WoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763201507; x=1763806307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uESUd1ES6cjn8xpvK7qG9/H6wg6JfOGQrzPE3peob0Q=;
 b=VUMf//hkN+lFa1wsdvzzl3b0UTz6L5PH/mfjc6PdICku/tr2c+fFbQU7Z/95hgVAwY
 ggngg6xt50jZxqqQOa89XAVJJzdBBr3ApnWgac9VTHRLVJtThGL7f2iG7934xk1yYA3s
 HEd4IDjR0KJD3Bejc4KZ/bFnYsl2a9LIFvae8avbd0FYDPun0WeMELUMT9y1880C6Kdr
 i5WDbHCf8Rx7IldxywnqA26/pSqsiI27KJPng9hiHQ+FcMiv35VSem2o9vBKfrvSCdFP
 QArp/zgGeTd1gA7cXVtX8vl82NDOpbswp3bLdIeLQEtyiRnnUIL7kCo1jJ95OVQyTM38
 ra+w==
X-Gm-Message-State: AOJu0YwhJFbKLnOSsR96vLKutTUn0naz6vOuuZIZiQCfXjir0Qu+VBZX
 PFeuYzQfYQwG/WF8A37TPAda1N51hX4x5ZXw3r7lAM7vJu+4pg26MzWE
X-Gm-Gg: ASbGncshXAVjzQGg1KG28quSYE+x2+VVjuycosJt5hp31VrLIskqLFlR5I00fu+t6e2
 7O5hTnse5qIEebCLsFM3tOMSFzXQuV8hOUW2TqhI4/nRuVQZqmKqDBHJHNhfl6FICYHFq+JH7Zn
 UtwXRlXIHxnQsWHZi4ShtuKGWaREE3JxSoji/J1DsBl61ANPy6dpVKlLduGZwnV2t8Asnq8ZdNL
 92l/mU6jaQXfwfbzMAsqEKUzeMZrbf22IdKjoTG69z899H3puEGbA3YKbK/AxwvwDS09ClpXDOp
 Pi7YQASfdsSGJhYpIJdsgiJUW9s6p4P3irbvCNKx2W+o+IdBQeCVuCvQXi3LLMibKwAiHmBfwa9
 dgE9W5q0ZPzEoHQkVLT+1dTgx4THQOFYZ7aoUzcF70MkR9s317tQq3EAVEgAXornGjw5lxU8cpP
 2hgBjB
X-Google-Smtp-Source: AGHT+IH8suc9MuaqZvWmPufWp51OiVBXqvprQG9snHFx7hAgRq/dpquMm46OYyjjyWfyHQurMLwylw==
X-Received: by 2002:a17:90b:1d0a:b0:32e:3552:8c79 with SMTP id
 98e67ed59e1d1-343fa73faebmr7067647a91.29.1763201507095; 
 Sat, 15 Nov 2025 02:11:47 -0800 (PST)
Received: from gentoo ([49.204.145.245]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7b927826d51sm7737594b3a.49.2025.11.15.02.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 02:11:46 -0800 (PST)
From: Shreesh Adiga <16567adigashreesh@gmail.com>
To: Jasvinder Singh <jasvinder.singh@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
Cc: dev@dpdk.org
Subject: [PATCH 2/2] net/crc: reduce usage of static arrays in net_crc_sse.c
Date: Sat, 15 Nov 2025 15:39:59 +0530
Message-ID: <20251115101140.1295642-2-16567adigashreesh@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115101140.1295642-1-16567adigashreesh@gmail.com>
References: <CA+-x59aamcto-nwQooHFGTN_K_ahE+u7eb_aJG2kk6muo+MnGw@mail.gmail.com>
 <20251115101140.1295642-1-16567adigashreesh@gmail.com>
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

This patch aims to combine the crc_xmm_shift_tab and shf_table
into a single 32 byte array which offers similar functionality
for left shift as well as partial_bytes shuffling.
The first 16 bytes are now 0xff..0xf0 which behave identical to
0xff..0xff when used as input to PSHUFB which will replace element by 0.

Regarding the usage of shf_table in partial_bytes section,
instead of xor with 0x80 of each byte, now we xor with 0xff and the
table entries of crc_xmm_shift_tab is sufficient for this purpose.
This allows us remove usage of mask3 array of 0x80 and replace it with
_mm_set1_epi8(0xff) which compiles to single instruction "pcmpeqd XMM, XMM".

As an example assuming remainder len is 5, we would have
previously before this commit:
temp = {0x85, 0x86, 0x87, 0x88, 0x89, 0x8a, 0x8b, 0x8c,
        0x8d, 0x8e, 0x8f, 0x00, 0x01, 0x02, 0x03, 0x04}
After xor with 0x80:
temp = {0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c,
        0x0d, 0x0e, 0x0f, 0x80, 0x81, 0x82, 0x83, 0x84}

with the changes in this commit:
temp = {0xfa, 0xf9, 0xf8, 0xf7, 0xf6, 0xf5, 0xf4, 0xf3,
        0xf2, 0xf1, 0xf0, 0x00, 0x01, 0x02, 0x03, 0x04}
After xor with 0xff:
temp = {0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c,
        0x0d, 0x0e, 0x0f, 0xff, 0xfe, 0xfd, 0xfc, 0xfb}

Both the above pair of vectors behave same when used as input
to PSHUFB (with MSB set bytes differing), thus achieving the same
intented functionality.

Signed-off-by: Shreesh Adiga <16567adigashreesh@gmail.com>
---
Changes since v2:
Removed usage of mask3 array and changed the entries
of the table to be xor'ed with 0xff instead of 0x80

 lib/net/net_crc_sse.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/lib/net/net_crc_sse.c b/lib/net/net_crc_sse.c
index 94d847b301..3b6fbfecac 100644
--- a/lib/net/net_crc_sse.c
+++ b/lib/net/net_crc_sse.c
@@ -109,13 +109,11 @@ crcr32_reduce_64_to_32(__m128i data64, __m128i precomp)
 	return _mm_extract_epi32(tmp2, 2);
 }

-static const alignas(16) uint8_t crc_xmm_shift_tab[48] = {
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+static const alignas(16) uint8_t crc_xmm_shift_tab[32] = {
+	0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
+	0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0,
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
-	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff
+	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f
 };

 /**
@@ -203,27 +201,15 @@ crc32_eth_calc_pclmulqdq(
 partial_bytes:
 	if (likely(n < data_len)) {

-		const alignas(16) uint32_t mask3[4] = {
-			0x80808080, 0x80808080, 0x80808080, 0x80808080
-		};
-
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

-		temp = _mm_xor_si128(temp,
-			_mm_load_si128((const __m128i *)mask3));
+		temp = _mm_xor_si128(temp, _mm_set1_epi8(0xff));
 		b = _mm_shuffle_epi8(fold, temp);
 		b = _mm_blendv_epi8(b, last16, temp);

--
2.51.0

