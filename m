Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E87C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:31:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCFD540E31;
	Fri, 21 Aug 2026 21:30:21 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 4383D40BA4
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:30:21 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1240273a12.0
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787340620;
 x=1787945420; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gBXHErV8JSFvcdWaymN5xPsDfWQMtEc1RGCRMED+2JA=;
 b=OAoycVlUqW4v30DVDpJEMnaZqOW+S/9rBelWE1jmQaMOtospIykScoZmNwq57ifZC4
 LtENTgVDkrmvhYbBG7YOIpFX86EXF1ejACVfToU1GbgBbYy5ZkUp8vQj2WXfYcEEkZsD
 D5l0WM9S4aZEzR/mE1RnHCKsfR0o1cseQi6t4k0iPwfrqtX66lEeK2zR46nw9h/oRqx3
 5S8yfaeunZ33X8Emzg3qns61l5dVKEgS8UFLNZJKS3oeExH35KCSTRGB87ndFv0NRNpe
 a5FrpWnHmSWi7AxINQnXAnshpm14LOV7WFk1GZgCky3Ial5/OcA2/yG9u0WCbXS47W/4
 1szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787340620; x=1787945420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gBXHErV8JSFvcdWaymN5xPsDfWQMtEc1RGCRMED+2JA=;
 b=D97Ccikf90dPHAXr5p4OynPV0+7NfEog7SLMFmTM/tq283L5s/8voAdEHMAKHpJ4sx
 BJ5q05XerG8ghCpPYgxmQCrSoJ3GMh+Ev5JzPB+hx4K6VuX8JsWYueXfsZvRxEgqszwG
 n0GBxNDknZ0nNcuLQWP/jiZU+CdDLtrwQbzL6yT1kyCGU2IE5Ye40VTii6n+KUYzc8Lk
 reRJLR3FMjMLqPywcsVc5zVjgZJUbFdNlR3R2JzqjPwksoNkkemODUGS8vcN/ePhvKBf
 E0UDyoBXZulsp12PLFKVwp1LMcFbIXM82A+bFEWS6vMESQ9MPms97M5JRqr4D7U0igBx
 ybZg==
X-Gm-Message-State: AFuF++ksh90VohOWJ93lJs79cmTw7fpXvJ1qCLNlArBq6OhyM3GpCZRm
 G39b8bMicQRtZ3vuSs5+rzSU4OpedOeIRflZ4fURAZeSEbcDPkQu+Xool0hb2NHAh3XOcEMjBVQ
 sY4fkFjI=
X-Gm-Gg: AR+sD122uCvo/RFEH9URH30Iw2nP5K6yXJ6MsS3N8cdCHvBJtnNdVhusen6VkJHbwEy
 3XycmHV1DzQSTIV04ZIUqsnDRrW644fToN/nQWOLfeptVCJJsn7LgVFJv6JpLwRmTehUhh/ib1B
 sClVclvt6Zg7HsyP8vC9HHp1J9abwLbMoc3bpy332gEGlNygo3/PtVQ74XcjUgv0XRJca8qBXX5
 1wUpu3Psv7C5JCkrZFMEuDcRDwR4pfYguINE5Bmj7zyQbYt7Hm0iBSNReGjax+p9nGTfIMbTwCg
 d0bnL+tFH/+7ahR+wfDGLUR77gJIsLXmsNnpgXABRfezvfqEqJVtWhihZHi7vdWeGynaBkJ6008
 EhB1uJiRVkz1FgjCpnSoCA4ovhtKvdrMpzPlNqHU1eE4lmeinLEo5oeslmeoJ0ZInMqEmG/I61L
 Im/reAX4Bf0AJQIaarHUa76YyuRAMdavf3QI78eCcZ6Qsbq2RvKWlA/YIMkjDyFncROK4nbaoTN
 lGHxZimIweMx6X8zj33HA9ZSvFsKzx98VHzoQ==
X-Received: by 2002:a05:6a20:c705:b0:3bf:a7d5:df38 with SMTP id
 adf61e73a8af0-3cd300613dbmr18481651637.9.1787340620416; 
 Fri, 21 Aug 2026 12:30:20 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc16c6dd2f4sm1860304a12.17.2026.08.21.12.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:30:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 40/68] net/netvsc: replace use of rte_memcpy
Date: Fri, 21 Aug 2026 12:24:35 -0700
Message-ID: <20260821192646.146382-41-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821192646.146382-1-stephen@networkplumber.org>
References: <20260820052251.1453273-1-stephen@networkplumber.org>
 <20260821192646.146382-1-stephen@networkplumber.org>
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

Don't need rte_memcpy for fixed size value.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/netvsc/hn_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 9a193e4a7a..c1bd55e6b5 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -16,7 +16,6 @@
 #include <sys/ioctl.h>
 
 #include <rte_ethdev.h>
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 #include <rte_memzone.h>
 #include <rte_devargs.h>
-- 
2.53.0

