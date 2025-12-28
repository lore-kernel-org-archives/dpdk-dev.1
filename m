Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D1E784BE
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 20:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABC3A40B99;
	Sun, 28 Dec 2025 21:20:09 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id E0AD940B98
 for <dev@dpdk.org>; Sun, 28 Dec 2025 21:20:07 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso34583405e9.2
 for <dev@dpdk.org>; Sun, 28 Dec 2025 12:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766953207;
 x=1767558007; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=L6wcVfja+3tqN2zcNw9atZkHdBEHYdhApwIpSC72bswUU8ev0lS1CJeW4eUpIa0H9R
 qJmyNu/AhVCTk4xiARxCZB3SelZW2YDV2wo79CEfV6YQBDkv+YKWuMkafTEX/y0hIyLh
 s0yGf7ZWm0nBawHcba5loHhdRc2vozvWuhPN5OgSPFV4EuncU2J2WML5jSvgS49n6xVI
 qcOpAocdFrqBO+fU4L0mFRa448j+agL/JNoVBYhwuctd4ebMfPuoG/vGaFNfYx2Gwfgd
 RGrzdDV1zsoCcV1m+YoDn6eqN5kPqJI6o943EvfTPfQGHrlprXV9wvo6dcrENF4uwZhH
 RMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766953207; x=1767558007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=pRBY34k9dA4rISjNPo58zJej8Oj7wUIxLq1eDZfwcz51h9hJmiiqjOiBtTgMviH2mp
 sRx4xfxxzG42ynjIA/T5/LBYsVEN23osuVBS4G4MiRv+yM5yUFzTj0lizwCrV6Mdli1/
 4eFFOHsYSnMeH5du5h+B45izUMFnkl26+59LgQkxF5OLcejt4mBNzGOFLr0rHTVbgTiO
 nlUh7HsL1ol1wVFiI2taOqPSn4N5DlmCvIzM+J2wUa1FztMQa/6/H1mg7sTVd/lQzigc
 c0S6SgOFivzEz8TkdkgDf3PUBIcr8DWFE7yq3iyFT2ecKA4SkJi8NudIPpa4miZfpmqp
 Sv9g==
X-Gm-Message-State: AOJu0YwTP/GFB0TIuO+q3B9L0eCp1REfWlZ+M9SzrQmLIdCtPRqBAslR
 fUC6TdclHZ+r/OCFUiCDWNd9g9+TDppmm4I5LvcRwN4zt7FOExvwXBO4a7Cz3bIWxurik8jbKmz
 uz3aioVk=
X-Gm-Gg: AY/fxX7TVXCgzqSFS27k8M1L/hE5BZaHYYyibp9burWDa3i7qy4unB3JhAcxq+/lSMg
 14jsa8NtfGtRVGaE4a8U2Un0fWwm6FhNri3Ws9sq60+0+5SukMKMYf3Fxe76xM6uc0Yb7KSVvrB
 Xh4qlaNE3Xj7feesrMpz41lzhX1ZaJBnMAfs6bQ68ymvYOkRu5TXX11uFckil94YPtqSgkRvdJn
 KL+QPW9dTTy3n1TRPEANpqdXU3fo6XQ22F8TMyvztyj7iek7GIukKrZoTzsF8Ac9AtdlV9Xdew5
 Kq6D/QgL4ImWZsaaikTOCmW2NpyUZ7i+OqLXiRzwtx2uyJBY9TyREmaV7lEra24P5Jo9eHNV5nA
 PS7CtONAJzekp5vUIZU3dTf+Z03YyYP7r2eyhjB3z0xus74PZdz/X5gKqJPw8sDrIH3b6ZBJ7/K
 ffn5pl9rpzYNF63IjYltA/X2QCJfC4F8A2JQSrl5q2MHXNxzbOaw==
X-Google-Smtp-Source: AGHT+IH3GcjMFlh/mWMg8lJ1HNHmztzNM8VhqO7Oo/rEVLgBQBykAm0/VOjoRcIgsf+qRWyFxx3WJg==
X-Received: by 2002:a05:600c:3b1f:b0:477:bb0:751b with SMTP id
 5b1f17b1804b1-47d20423ca4mr307483625e9.27.1766953207552; 
 Sun, 28 Dec 2025 12:20:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3964226sm240319655e9.0.2025.12.28.12.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 12:20:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 18/18] lib: enable format overflow warnings
Date: Sun, 28 Dec 2025 10:56:21 -0800
Message-ID: <20251228201236.547268-19-stephen@networkplumber.org>
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

