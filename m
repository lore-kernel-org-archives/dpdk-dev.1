Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231C0D4A605
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:47:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCFCA42DB1;
	Fri, 16 Jan 2026 07:46:57 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id 698B742DB1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:46:56 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b7ffbf4284dso221377766b.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546016;
 x=1769150816; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGLGalZNdkwhkVUgPXNRi9cK6k6be9bFKc0+vinlPuI=;
 b=LVkJa1pBKFoA6BLLopBQhRJEzrCkwiRdEHwYDCPCoNMGj6XF7uWCXTQ0UGVhXrx4YT
 5KMTY12Sw43PjverY04+5ByZAg0dwO2e5CMjUPesUT1fa3AFSrbaxbLGXiIDBkmOr2MO
 +xek05Hwvxmqwuuqug9T7F/eSBjpfS4GMTUrWxrpLQNTHB/62iplHw8OoL1YN4H8rHuD
 JvNICwy/0IiRENKnU8znddpCZ3IS+lGBYk0hZSEpA3ktPCWhVempABBoVpyfelOSw2Q5
 iZnNnxGmZTx6ogE76IPHxSUIqOlCYvDMTXSbKsRU/+IcRzrxzSc2diBDMA1Mj6VZqPZ3
 xwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546016; x=1769150816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fGLGalZNdkwhkVUgPXNRi9cK6k6be9bFKc0+vinlPuI=;
 b=GgO09a6J2g57b9MMBgnf+vq8bynreozBRKTlEat58aC9bsdBLFTtqL2fCQQCYxkf2u
 mctnqkB4NQi24n/hS2VwgiNIKvG6bY4vX3ntsUl9dmgxZkA97QHOV68iVHtoT7pez0yR
 zrK4etA0JzXu1AyatBPfRgdMZ7j9wmMj4j4CS6vjMysNvrwz9NJdNdj3LpXY7dIKRXLs
 Bn9Yr9Ri2eLE6/49foXYCKHm4VlHWIp+3xT6u5nnTPVy0E08DMDGK86qT/z4ImP3Xnlt
 +l5n2dql4OFm0KOl5sqMcr0leHNXpf7ENNJ/EDaQhHIfFN7Hq/MMiV5C1OgiN1InW/Ml
 4c1g==
X-Gm-Message-State: AOJu0YyYKkGA8tNB2sF1lwDC3LxMeMEF4dJ9MsOM4bYlXtLpsCbf85DL
 XnidD86RLJ8ZfgY5lBerD1SUPgZOyELWjBEqJbZDsvZOy0Fic9xtCu48CRh2YY1FifIbMhzIKP9
 ARVTR
X-Gm-Gg: AY/fxX60H7jVraEuIYkY6oF4/tiCQCeNHY+BPjd0vcT+63Zw91+OxhBySX8MwgV9fmJ
 dd+dJKB6wzn+c/MKgZ0E5Zbjk7LYOqm9cfGKPmVXlTBjr5F+n0XVEfIBnljL3UQcRGC4rsVf3VR
 veerRBrPr94bQE/UkD7iAvu6PEMb2d4+osu3QwMwj9EZZ6vxjx+Ad+jOg4etuW1PSf3MqxtyGSz
 NMKutC6HxHVxgpzbCzYsz6xirhHVIMapZ0A//uLmVe7itzoTncTgZYD/InK2/TET2kJ5VSbcQvZ
 YTdUX8bEJUK/7cUz+BT4+Tpfd/E1S7J9GCnf8IjsxZtgX/SzXPeJ8UiKgCfMluUSyzbbumw7dQa
 BxjgS/oZD+MOVxnwrrXbpB70P1S++geBN1d6oeP6OGun5h4P5cSDZVuPnnLqyY7yYEKSvZtIeBJ
 gW9ufkkN2e4yzpw1dydKk59tZZtpY/AlEFEhy5SK8yPhFG7ro9QA==
X-Received: by 2002:a17:907:743:b0:b86:f988:a0c4 with SMTP id
 a640c23a62f3a-b879300d79dmr148873066b.38.1768546015973; 
 Thu, 15 Jan 2026 22:46:55 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879ae74639sm97172866b.9.2026.01.15.22.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:46:55 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v3 2/6] common/cnxk: replace variable length state array
Date: Thu, 15 Jan 2026 22:46:23 -0800
Message-ID: <20260116064646.224254-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116064646.224254-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260116064646.224254-1-stephen@networkplumber.org>
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

The cipher function is always called with in_len = 16
and there is an existing define for that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_aes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/roc_aes.c b/drivers/common/cnxk/roc_aes.c
index d84feb546a..b42c785249 100644
--- a/drivers/common/cnxk/roc_aes.c
+++ b/drivers/common/cnxk/roc_aes.c
@@ -157,9 +157,10 @@ static void
 cipher(uint8_t *in, uint8_t *out, uint32_t *ks, uint32_t key_rounds, uint8_t in_len)
 {
 	uint8_t data_word_len = in_len / sizeof(uint32_t);
-	uint32_t state[data_word_len];
+	uint32_t state[AES_HASH_KEY_LEN / sizeof(uint32_t)];
 	unsigned int i, round;
 
+	RTE_ASSERT(in_len <= AES_HASH_KEY_LEN);
 	memcpy(state, in, sizeof(state));
 
 	/* AddRoundKey(state, w[0, Nb-1]) // See Sec. 5.1.4 */
-- 
2.51.0

