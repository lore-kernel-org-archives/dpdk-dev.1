Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA432CEBF80
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Nov 2025 19:38:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5D114275A;
	Sat, 15 Nov 2025 20:38:02 +0100 (CET)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id CE37341132
 for <dev@dpdk.org>; Sat, 15 Nov 2025 20:37:57 +0100 (CET)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-bc17d39ccd2so1662151a12.3
 for <dev@dpdk.org>; Sat, 15 Nov 2025 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763235477;
 x=1763840277; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUEql0CZZcFWo+XSFT3zB1JbeSKgzOFqtwj3oEjP22Y=;
 b=E55MrXO7tCIOZfJPMZqQFmOq3kXKwIfDy8smkKjI5QMlTXFxeVH/FIi26fll3IV2xV
 HedKjX8GFOAjV0Fzd2zD1Glp/9aLvNw0jFt0Kt6qGu5AZXlqlOM8oWfGd6NfIXdYRsvv
 /tmrQD0B4cyj2yAL5yC+Zk4zqzpBm4zBkGfLXFLFEU9Dm2u3xJQet1s3OYJWoyWikHdN
 DNCX1dTSxASR7n+Nbk8BBhJzdY+xXf6iXQYOBX5WGtwTPjIBVLQ/H3gjOVx0M6OO8m/E
 ABi5Rbe1H1r2XXjlIJlocJ8GtTg99TxPogva1QTJzhyCgZzVcUTiyLAb9PRpaE1xlqkr
 Qo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763235477; x=1763840277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUEql0CZZcFWo+XSFT3zB1JbeSKgzOFqtwj3oEjP22Y=;
 b=uko5GQ2Xy9uISf83+jEd/cd4LEN9B5Wy5zrcBbEoE8G6kwsdzHIdUiHgoTeQoqjasL
 oIZBJ3TbiGw2A4nARyVRwip08A5TjRCO/zpBzlumV0xDKzIarosJoy5R3mzYhMBkzvKC
 /udHrOkyeMZlEsJ1vDfqcdcgUbdNWB8SJ31jQRif6nlljh/LoZREx5OjAp29eHAu2mrB
 mSKqyBCJZr/6bq01D5DxaoE51HTR3uKzdzzeDtmEk7XEsSkCVfOjzO6wMVMaWf1/BvpF
 tuieV8xg5MsChh1Ii+qc+FlkuhEZ7oXeikzoJi6wbOWwz6Bdj4tnVHnwCusmpmfmKb/i
 ynNw==
X-Gm-Message-State: AOJu0YwuJTkHzMt2S4OUXPrT80mR+iNKC9/PDbwIfcTeLkrs5OFJY86d
 c0fWkWp7DKSNIWqIvXjHSYsXFOQiJ5WW6ScdOaaOdrpyFJMY0m/q4zed/6QllD6B8KvFr53tYbx
 j7bcg
X-Gm-Gg: ASbGncvRza4gcFnC+UIsIBNqwKvTP4jYZvknDKg5WGhcIMEDU18Tz4b89PVn8mDfu7O
 2mlOhF5YtgvKo3ye6Be2FnnPDbpkRdeJnpCNV0KzzlWG9IMvSXRn4RbNjkbT45TRTTRZq/e4y/6
 KhwA2h9IZJydtvV81vOQF7133I+sZS0M9aDiqAjVQ0YDT6Bscngq3Y7S2PDOpd0qSZM0zOnsleh
 qmntIT0U4kmRvFidsqXJMBWcrk//Ph9/2ToP0YYpTuI+rSac47jG2pP0N4gXAbgOsFJQGB5Akf9
 AREdWNvQPbZwU6FZURox0XKIJasYIZAdWBQ3lhTIoerLDCay+8gLwUGYSwViUs0xPpse7E99mS1
 b63o5fpGTu4y2gmMyjtgLiwAOXgXMB39twFvq1NOn6gTfa3igxr5VsYedOuoOdHRnM8UpF3TwV8
 AgTCUqvM8J4oUruTwmYDcsb2hoqTDHT4JelWjbejpkRhiCcBdpj8wHz8QANGFd
X-Google-Smtp-Source: AGHT+IHUyKMRSzCyG+IHGfcf9zPHU45Xgw8EgaR8ELp36z8ae0laH0aGZUpuj/Y8da2yI5EZUlDp7w==
X-Received: by 2002:a05:7301:150e:b0:2a4:5a7a:3a5c with SMTP id
 5a478bee46e88-2a4abdd0b97mr2437294eec.26.1763235476900; 
 Sat, 15 Nov 2025 11:37:56 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm28753833eec.0.2025.11.15.11.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Nov 2025 11:37:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 4/4] examples: enable format truncation warning
Date: Sat, 15 Nov 2025 11:36:39 -0800
Message-ID: <20251115193749.101355-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251115193749.101355-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251115193749.101355-1-stephen@networkplumber.org>
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

There were several hidden bugs in examples because format
truncation warning was disabled.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/examples/meson.build b/examples/meson.build
index 8e8968a1fa..25d9c88457 100644
--- a/examples/meson.build
+++ b/examples/meson.build
@@ -78,10 +78,9 @@ else
     examples = get_option('examples').split(',')
     allow_skips = false # error out if we can't build a requested app
 endif
+
 default_cflags = machine_args
-if cc.has_argument('-Wno-format-truncation')
-    default_cflags += '-Wno-format-truncation'
-endif
+
 default_ldflags = dpdk_extra_ldflags
 if get_option('default_library') == 'static' and not is_windows
     default_ldflags += ['-Wl,--export-dynamic']
-- 
2.51.0

