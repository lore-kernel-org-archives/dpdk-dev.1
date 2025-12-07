Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3C9D2CE17
	for <dpdk-dev@archiver.kernel.org>; Sun,  7 Dec 2025 19:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A4B4066B;
	Sun,  7 Dec 2025 20:13:07 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id D5B3C40649
 for <dev@dpdk.org>; Sun,  7 Dec 2025 20:13:05 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-477a1c28778so49708625e9.3
 for <dev@dpdk.org>; Sun, 07 Dec 2025 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1765134785;
 x=1765739585; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=z3ly2Nc8wByWjUErSnMAnl/ZqPPPUYhDeGOzYQup1llEkha23PqTcFEeD963FIqsll
 zLo5++D6X/QI3VZgV+GtM4a3qvjabMwWDwf6eGjfTPcn1KvF20sbNHoyOhEeFxT8x9ZZ
 gWbp5Wz0yS/6AtNTmvB0oyFJlzc0vvpxDuzFmEIFssiVT//KW1xTuU2HGamC9IYo9tfm
 jli0acUL+wXsM3gGCD39+8+GSscaKBpXCUN8eWcsM5cHprK/aMf2sam5NRZassYNJrDS
 W4j4iJWs7jWZnQ3l0WA2fX3Yk7euwdlEuzWIdvV6v+13bb7rX/bfogjDGa3mkdsauTAU
 k1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765134785; x=1765739585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=sSUL9zO1iPAnWsAg3Rs+y/JJFu/duo5paFACJ0lrmB8+w62pHopYyjzKYdf6FOPnI4
 BIa33mlFXiSCcRm7+2sqjLbbILF5yN5yJyyrpE1wIwhZg9Xvm/7WLP3IFRGsgV797UxE
 8EyyvDxQkna29B7GapcDLt11H0Rh8dCXYjVZThaWp1C//K8jUZVqbofzWECo3WMFAgkn
 siaMejraC+CXW+Gq3n34ahhv8zcZ0e2XcurX/NFSph4gVGCbCy6dg58WgqzXb7iBxOD4
 DeW4EyEwWJ+mKoZrdZJrfq3qURfaLm3tpjrb3LX/pRBUEq1m6jKOZWyw6XHKCCrOMDNT
 FgWw==
X-Gm-Message-State: AOJu0YxBDvT8BtBUbKXPSmHl0IKty6Z6Y7iZUm8rhbHke3hRoffRwlKk
 BQAvok6ESyS8SpaBKlJtfkOXfTMffWY7788ZX9yaz/tK38Cmje3qOemAzgSnWDq6R+jVZQuCNDo
 0SQnP
X-Gm-Gg: ASbGncviWSG5WuXnKZAGmFznZsyLzMzQOs45DiYstoS77BAwABEoLdjS1ux7MNBYpDy
 yONyfSSha7j6X7Oa+z/T9rh+ph9MHHG3HE9yrIDgHyVOf2UWWGSCkseeCVXwlYBzgCs+qdI6jFW
 3RZ9pyt9QpoqEe/xTfxJCOeykKs+07afAYdfWSNgHX07jeW7YB0Lcx8k+bA1tjlDWqXGQhKrLpU
 KsKHTzXPA5pq2rRyv3NRKSO3ZRcUGdolsCYXLKA1JSt7kFzNxValmfWSOQGDRNFV6WyhvVLWj3b
 2iX7Ln41UGwsP8Oh+8MaCfbrSvyZutGrLf0W2ADudcmuzI3I/3tGm2N07ZXE17fUuDmP6A9bdyR
 eUk3J2gLlbRmKTJA/4v5u9sHCIE3xF7ij2e7oJCWItCn1rTmWN5cpI6hmmMtR3szs1He4Rql+Cx
 z468IfUd8D8GCTMN+dqWzdB8lxL3a9XyLmNBAWPwi21jRQqdB3Sw==
X-Google-Smtp-Source: AGHT+IHZLlrGoaCo7zaVOukzZJybtiLzq4zYpxAYzzADM3hBiGp9vhdQfVTS2SBaXVmkNZQ0wT3uDg==
X-Received: by 2002:a05:600c:4743:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-47939e200cbmr56031285e9.22.1765134785427; 
 Sun, 07 Dec 2025 11:13:05 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310b8e70sm205124205e9.5.2025.12.07.11.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 11:13:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 09/17] eal: avoid format overflow when handling addresses
Date: Sun,  7 Dec 2025 11:12:00 -0800
Message-ID: <20251207191242.165619-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251207191242.165619-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251207191242.165619-1-stephen@networkplumber.org>
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

The largest possible string in this code 0xFFFFFFFFFFFFFFFF
which will overflow with only 15 character buffer.
Increase to 20.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/eal/common/eal_common_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_memory.c b/lib/eal/common/eal_common_memory.c
index c62edf5e55..2633857db5 100644
--- a/lib/eal/common/eal_common_memory.c
+++ b/lib/eal/common/eal_common_memory.c
@@ -1153,7 +1153,7 @@ rte_eal_memory_init(void)
 #define EAL_MEMSEG_INFO_REQ		"/eal/memseg_info"
 #define EAL_ELEMENT_LIST_REQ		"/eal/mem_element_list"
 #define EAL_ELEMENT_INFO_REQ		"/eal/mem_element_info"
-#define ADDR_STR			15
+#define ADDR_STR			20	/* 16 bytes 64 bit + 0x */
 
 
 /* Telemetry callback handler to return heap stats for requested heap id. */
-- 
2.51.0

