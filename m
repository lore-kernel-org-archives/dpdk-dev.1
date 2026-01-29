Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC38D46C16
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 01:45:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79C96402D8;
	Thu, 29 Jan 2026 02:44:04 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id A6FDB40BA0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 02:43:54 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso3395785e9.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769651034;
 x=1770255834; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=C7ZjM3oSqwPBuTNKGC7Qn+GYm3KV3btac5M1UsNLALa/Fi/puOy0t+wjJHVmL12Soy
 YdszkfXJp7gqmo7EziPzkiUhBPaf23GAlCtRQu53VAjtt+oG0ZWDNZWXTa+PJHMuSM1T
 MvLOFNimoVWGQ7ftzNJ88nYJLVbKmMaY6xFEEWy2l8sOKBbK5BpTdrgDgMD/tp/Q+NU0
 GuDB1G/ckR9zW22b0d8PlLR0fig2ufTLwi1+3ptqGa8Ime33nHvFLWtrtwNxkrISJ7Qx
 z+RLBP3RZBtNJwb2LlBg2GANXYSt+Ui0/4PXPKO8WJ7OD2DhuyiA72gqt+hD/TKYJP5L
 4uHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769651034; x=1770255834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=wKnV4Cl08T48JY3p/yorbz6ztt8ZkLb3+VqyRx8nf1uMrEF8Kmv9R/cOfAtBNgx/Ig
 hqi1l5Yja7YvJifuvl4IANZogmV0SpepYciDtXVUVBlxvfBnVEoHHxNj63D/wL+XE/yj
 0PgNy1HEx69U8O3QBAmCkpKCj2IoTK2su3bq9JDCxORZ4w0xTch7XR92zIficrQp/UXG
 DdqW9/9i1eyadA/9T4D+/3wbHhR6Y39DpaqSv9KSRJFq53FG9n+BDYV6X+03FpvOUgnr
 /cbY/X0HEbgGuvNfl11N8cZuByquQ2UE1+xFTecZl8XnqJTffCJIYiyBdOvhzXVVEzcp
 yu4w==
X-Gm-Message-State: AOJu0YwBY2dHXFQVpeXrLvl31TBkFpIG+urv0ydEsjdSdQk0PEb4InmN
 zKrP6Cz4ZTXu4j84odtUfaDN/5BE3Fz9pqbN0SbsyVmTtqSZAichR04yR+1okgtop6NgR0A5DYk
 xNPIO
X-Gm-Gg: AZuq6aL6RvxhjpqFJQf5xjH/1hWJjyxsUZvIly301dEuiu0Jz+2bo8u5AxUAfAoUitI
 B/Wj/HLx9YTTvyZJ1vtpsoK54rgIeufihKESR9Yl3CsnzMduuelYf/xUSEB7UzGafSZGVocW0dv
 aXosJwqmRebOf46vzSNBgySebyBhO7zF30NundXCi2+RoPZGnsyOQ3UdTlVTFtypX05JYKeh7Hv
 ezfQfSfUr3vfzspYan8IGNAF/us8kIvlYr2YTURhF0uReRvqIAKmbTsYhEWxsU7oKyIrBH8eggp
 SIR12xiWF0PGDrJdeszBcUmdMPACtZed3azelZv0xMmUy+3UYE4aa18QNuztB0B0rbcmfZQIRXB
 WOjTVcA/odxbR3/fEHHzRL0+OTWieS5768xICM0TMcaWQeCwxriZWsWDLdUJsdIj3H43mwrQaFZ
 AtMraufAQzP0fPK2y04thbxdwhoU/V7PdqMx3huZTtrXVvxBJlpw==
X-Received: by 2002:a05:600c:3b1d:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-48069c87009mr61886135e9.28.1769651034329; 
 Wed, 28 Jan 2026 17:43:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e18427sm3217985e9.16.2026.01.28.17.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 17:43:53 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 17/17] lib: enable format overflow warnings
Date: Wed, 28 Jan 2026 17:41:20 -0800
Message-ID: <20260129014313.939831-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260129014313.939831-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260129014313.939831-1-stephen@networkplumber.org>
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

Enable compiler checking of format overflow

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/meson.build | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/meson.build b/lib/meson.build
index c8f4270868..8f5cfd28a5 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -113,10 +113,6 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
-
 foreach l:libraries
     build = true
     reason = '<unknown reason>' # set if build == false to explain why
-- 
2.51.0

