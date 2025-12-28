Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E57E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 864AA40697;
	Sun, 28 Dec 2025 21:19:52 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 93C9140670
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:19:48 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so64574885e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953188;
 x=1767557988; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=zyGTz8COpC8nCA4YBG5mKCY1wCcVl7/pXRz/Z9copOMjbYxN+Ny7sodzWqECW7YHBb
 VU0k3OutCwyfdM2LrKv3B6JJPpR/a4hm3R0Rzv1yUvZWHKsYAgFryV++VfhkPMk7Zoji
 d5smyylqke8aJaBKPfqi8xg1ghzg+mXwXOB584B7DPyaTMgtdjDdSDw713XPHysUNF9m
 WLFt7O74yjVqJFdyXo89RVtjMs22c1gy/S3xDee1gQvEA3DJPODXi1gHBBX2+IDClVq8
 Sp4zWijlIwY7DZmGsa1Mnpk9Wkh0RpLgTSHANaZ7kG97LUTmT1MyT/J9JY96xvxkD3sy
 X3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953188; x=1767557988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QvcvgW+x+uSnz55S9mirEMzeh8CER0lSkM316qqFM6A=;
 b=djdF/PLM884D7cVbsAqLHQcie8N5NHQZMorn/nD8tS/dwTojDABjHCUIZWi1pzf9bS
 Zv0uUT3UI12CgEgqu5k78j3/adeRRHm1OluQAEDUpDHA8siQ8XvJzuaciz3oLXmKFeHy
 i9LuDUo0B4tYezbp1qYxFzgotbrCr6wsTSVJ6/L1FWyPPpJh98ds5ajUI4gCU4RBqnsH
 Ee5g0H3/UO60g4a2588YHGBJ576M91mdlNlNm9GP9RCimembCr+OR9gLAdkSdiCEVVeb
 DsDHLnWCabyE4QjId1uc/LXFiL5u6QbbyaogU8igK/iFRVAGLEhBMmjQlyvRVfMAF4SO
 sc7Q==
X-Gm-Message-State: AOJu0Yxx2c8g6op+7kO4MR9jfgfYRoxQypfWDmL1nPnkpc69c7ZQDSRF
 5m6Ck4/aEL0xqUILKVrWepFp8ngwVsaBW8umjBuxOGiNtw4zy7w7YvElaOBrjy0DLprY0PaWl3n
 hTnbPTaQ=
X-Gm-Gg: AY/fxX5YOvU/ZZ/slFguN/gGNEJt5ayLEVovaztXXs6Ss9rJBixysy1MH4u1lZ9/hzd
 6+mmLy/0Z4sSpfbYjp/6KKXiOof9N4Z8sj29FfR/Fzl91PCc6ZcUu8uR8kzdEVgv+w4omufHdhl
 hnIIyXPd4mRo5kEB21X61lHqtyrpDSfAF5AEj0lJoc3AMDtZoFbJJx3VV29gQclyx5LArykgRsm
 0wTNOhSLgphk+TxaKcz+ys2ekIpk+AUrRB3ImQaUe9PqLTJ+y322JN+dCgy5duc4u8fbdeoNPxj
 6Iu9JSbSBqjrZrIiC2mmMi2jkU22Y8/RHj9jlWPWD7sUczOjkgNSsqPjmDsIN2kELLPViPmUJG2
 NY9lgqDLmSmrVDhohW/lTwGdWiT7KEkRs4ReDY19a2W8EC0pjuYloAnQ0eifXA12OmO4gSVl2nb
 jvACm7sXkNCHsdl1Vbt24tJbW0LibPdhIab9UPMYxHcaZH63Gx8A==
X-Google-Smtp-Source: AGHT+IELEhq2mK0xHeosoEv3VIZ+nZ5uGhl6bhJYoOw16SUctxMX+CnYxVhADLP7A1vYJlkJ7VKPQg==
X-Received: by 2002:a05:600c:198b:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47d1df12f84mr316299185e9.0.1766953188176; 
 Sun, 28 Dec 2025 12:19:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:19:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v8 09/18] eal: avoid format overflow when handling addresses
Date: Sun, 28 Dec 2025 10:56:12 -0800
Message-ID: <20251228201236.547268-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228201236.547268-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251228201236.547268-1-stephen@networkplumber.org>
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

