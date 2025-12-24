Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71238E78498
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Dec 2025 22:14:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CC67406FF;
	Wed, 24 Dec 2025 23:14:01 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id BD4134065A
 for <dev@dpdk.org>; Wed, 24 Dec 2025 23:13:59 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so41301995e9.2
 for <dev@dpdk.org>; Wed, 24 Dec 2025 14:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766614439;
 x=1767219239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=1xgnYu39TSsvsUwnenGQvK++zQkNwOdf9piKrQtGjgXw5XY2nCIynoAmkldu+00aNn
 PEAgcPi0E8U6UlIisswi4zs2L/OqX7PYuRbSrF8LfOx8qeDyX4cR4kngFCDL6XNlHm9D
 8EJfRfYcxnWx5CTYQzG4b1Reb0QPrnw5RKwv5Yyon0XeHFBm+mfegg5fECzUC02dap8r
 SOhKOVe/bF2dH0wq+tvBg594C8Xd6nQuV11qAFHrG8fjmR7VOkLC7ulTqH4iE4/3u/KE
 P2AnObwmA6XRIFiLynp6drTSpg4egDbfjql8vYAgHle8ElHVsiJqrYMOfV31+Ftl/KSp
 8JDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766614439; x=1767219239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=cyNUd+mGHKOHW2UJeu00KjomimNiQX4aIluADW45A1UaNnoNJ80KAHXo+Iv+PCSRbx
 4UQYpGJQCazPfZNEvKet9yAJkwpSrGr208aeY732KwM2QENSG2wPIzWbp+VSXbycQO06
 fufcrPQZ6/yw/bn75W4w2oIHXzALWamk+EK7pEWhZfbl29JUOldo80tBZio/MbV8CnSY
 A7DsfZyl8NBOqU2clx5+3a5N5+fPhOwBqYhKrIb33EdWGZTCXnEZvXKa0xDyLs60LWEC
 1rniQrU3O/fPEpyQFYLpXCy+2VTHv7+khFrI9G2/6dWZ++rsMrj/PV2TdCG6hD9qQIP7
 fEcQ==
X-Gm-Message-State: AOJu0YwAKeobbDklyITc7F8k7l4yMPALMQIGpLI7JliSS3cDqsoZbtOu
 TMwUt8lToWXYwK4LCK/nMR1cLA4U2sEX+n+f3H4PHwUV16B3cwcA6n4b1wk1muedVUAbNmLKfeP
 wLuLQ7iU=
X-Gm-Gg: AY/fxX469MaSmY4x98fd9Od61iFpNsZE9OHnPNv/6hvPr5otFNs1GZy0B0I3xd1db4/
 rRp6vad+k+S4vv60Ci6Qw9on61QbACIgblYpVCi7ToLWPGBZpJLHie99L1V7iE09UJAxJwoZJcr
 zQaZ5xFKBP0/JiZygToBESYW+PDvtXj743I/yrAYgRvpn9hnaEmAybYzEELEZh3PZ0IvnDzYmPJ
 /i8w8/5gemioqUjqcN7VHoWV5YUc0OMw9argMfs4RKrykqrDEJoFFp6OnRgM0f4pMLhjl2/O4za
 laxbPusNI6fP+dEG39otjtvxMhj2gUhfyTBIA81/R2ipGj3GbXv3Lqjj56P3FIeOYUO/vFuh3rg
 yIv5iYj3NIRoU+5n7RfRufRPpPdQ/JN2QhT1Uh0OcReRJt3Bnslp/EbucWjcnqr1rfo1m07NDGy
 7N+o26EjWc1RjcijHUbxDj8q5QG1x/X/Pa7nExpec8exTa74UE+g==
X-Google-Smtp-Source: AGHT+IEOAlaODvbfKwZ04vPWV3RlEnpiv0LGM3DduGS/jKo17zdLuSlm4lQa047rhn3NEqNEBGjiFw==
X-Received: by 2002:a05:600c:37c6:b0:47a:7fd0:9eea with SMTP id
 5b1f17b1804b1-47d1953c178mr199059885e9.3.1766614439323; 
 Wed, 24 Dec 2025 14:13:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830fesm36796622f8f.20.2025.12.24.14.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 14:13:58 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 18/18] lib: enable format overflow warnings
Date: Wed, 24 Dec 2025 14:11:59 -0800
Message-ID: <20251224221301.52714-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224221301.52714-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20251224221301.52714-1-stephen@networkplumber.org>
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

