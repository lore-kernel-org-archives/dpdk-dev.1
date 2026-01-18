Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD13C9830C
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 19:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEA5842E4D;
	Sun, 18 Jan 2026 20:14:40 +0100 (CET)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52]) by mails.dpdk.org (Postfix) with ESMTP id 587B142E44
 for <dev@dpdk.org>; Sun, 18 Jan 2026 20:14:38 +0100 (CET)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-b8708930695so565289866b.3
 for <dev@dpdk.org>; Sun, 18 Jan 2026 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768763678;
 x=1769368478; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gLL+g0BSz5ip+HJ8eXq6fZ4tluIfjnYrbeIdmlSplI=;
 b=dNw8TnqyV5uZ5+I3X99P2EqA3BPq0pg2iPszyDDphPvmDmm5i85ooIZnCSkPaI2U7d
 7Q7oiQJO5iTM/l8631Sdbo38iUA3b6maPjNtqlJxLR4frRuAwetIlGiTsUfz5GZli/Ti
 tllad0C9+cBbrTG8DZDOh1JAm1orvrww6rMOLF1rXcliw5od2B1ATyREO/MnEskK2MBO
 pKIRzuqBXMUPLpOU4JB6uEvIC/gmq28xqMCAKxi2odMuYwiSUt5Xan09uCTdOfhjH1I9
 MViPw2CUFjKoX9OIHHObOuNu0ZKt/V8aIoV+PCOg2RcxdgwARXAb2gxgsiznpS5J3ejP
 9w+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768763678; x=1769368478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2gLL+g0BSz5ip+HJ8eXq6fZ4tluIfjnYrbeIdmlSplI=;
 b=VnuHso2x1AbrXAzR3gbB/AjOw6A2gRE63voum2jP3AoMzviKNbH1iRHkcISq6Ks6B2
 YPXHr2hCRCJPX7qGgSFmXnRswBQQlC0VroED7v5BtFF7TIxj+jYXXRgNkoTzx5LzVaz7
 rc2rMtTP7OpGfE++eOZl7OeyJQCsoccXOSX3oP5vKxB6G88N7oQ20/PWQ0Rf7QgKSdsk
 5te3ixt15TZtxAzJ2R9rWayY9Ej5Xl0XpHiiPtL1SHhauMs5V6z0gS9RCPts9UTBay2w
 QwEdWSmh/YyHlmTAVUe1bgSvzIewlRpYRTdlAEq5MnQpHLSX6Ay+q1VAUz6EY5jqCh2/
 bwww==
X-Gm-Message-State: AOJu0YyBFLKXMoH8MA8uI9idDa2ZEn35YyD/J8YTc6un/BEPIXEKEiK0
 34CTX84Oid4d73PDnIsNwX0FC2IvqUs7b5LHE9lh0yU/ZRNQKD9fA9YvSl6yQGBeCNepMd5BGO9
 ENA5h
X-Gm-Gg: AY/fxX4G7YEH6wek7fSzslX1SF/netRFuGV3OLBxr6LECzmsSCmK7Nnd75PD0zLamuv
 qH2GFMcKb/W/a/WRfPpDQXvmqovAwSGMkdE9xXX37tiMTJn9MXTXkd6ScbrS960g8ZDAvgJF2+B
 awJySHUx83yFej3CFL1YM9ZPMHvWMQKW6E4VlkuYURSwuqYNtn0cDj0j03o+1SIJAEBxIO02X29
 HPLdbCKmr78jvc72uiXoTYsFA0XUzYfLcBofTF+cJyP60f4mxLb+m/FMB0SKE4JUWlVzA6wF716
 16ef12rA5W2EB7YcD3qL98krPzFlTb0CuHkk2tILFRIFjHpS7IDsaWs1gRggovONRIGW+8X4ntm
 D94/nEweJLp/7zWdEvEaVunpcoG3nFr8jLz2j652JsqXxvbOXKVUUKp/8QFoE1Tvhf/G7kTPzMB
 lIqFyVdA7caH5qr7ZZ1qJTRvv3Seimb9ovhOW/84UzIhKaoLckXw==
X-Received: by 2002:a17:907:2d9e:b0:b87:908:9aca with SMTP id
 a640c23a62f3a-b87968a9870mr726816266b.9.1768763677884; 
 Sun, 18 Jan 2026 11:14:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959c9f8dsm886287166b.36.2026.01.18.11.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 11:14:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 45/54] doc: correct grammar in profiling guide
Date: Sun, 18 Jan 2026 11:10:48 -0800
Message-ID: <20260118191323.241013-46-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118191323.241013-1-stephen@networkplumber.org>
References: <20240513155911.31872-1-nandinipersad361@gmail.com>
 <20260118191323.241013-1-stephen@networkplumber.org>
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

Correct subject-verb agreement: "architecture provides" not "provide".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/prog_guide/profile_app.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/guides/prog_guide/profile_app.rst b/doc/guides/prog_guide/profile_app.rst
index 2f47680d5d..b2950c2a61 100644
--- a/doc/guides/prog_guide/profile_app.rst
+++ b/doc/guides/prog_guide/profile_app.rst
@@ -88,7 +88,7 @@ Profiling on ARM64
 Using Linux perf
 ~~~~~~~~~~~~~~~~
 
-The ARM64 architecture provide performance counters to monitor events.  The
+The ARM64 architecture provides performance counters to monitor events.  The
 Linux ``perf`` tool can be used to profile and benchmark an application.  In
 addition to the standard events, ``perf`` can be used to profile arm64
 specific PMU (Performance Monitor Unit) events through raw events (``-e``
-- 
2.51.0

