Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECB2CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67157402ED;
	Thu, 14 Aug 2025 23:29:28 +0200 (CEST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 1393B402E0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:26 +0200 (CEST)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-45a1b05fe23so7531295e9.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206966;
 x=1755811766; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14bptYLHaXAMzHKAibVTezAuJ+7ZdjpVXrMrrCxiL+o=;
 b=V2jtCkRBnL43UpGXvWwGaGr8y4/6Ll5Bc374tZuWNwCLL5rORzQyferjbZeR8lhB9j
 EPuvs3OP7kOfnrEIIDnAzK214cFZLjsP+lwUIWmwLnfTRwm8LAJqfZnXTVfuid/EpsKN
 rSFfrN95J7XxULAO7jcQsIlDWwMdXGF9DpLikqbq60ekH1HF+jxINX6NSN4Mel1CbSQC
 zlaxbWbeIzZvWCRiOkCRteFoaoIsuCTvc5Nqpokt3ShnQPw9I2OXlZU+2ylLXww2+wla
 Og8ptwrj1yjmUdRNm+2ke5hBBp01PT6ejGQjHehZZU3l0AkX915+g3Auq1XrPzShuc9o
 Uuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206966; x=1755811766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14bptYLHaXAMzHKAibVTezAuJ+7ZdjpVXrMrrCxiL+o=;
 b=Kg3mEJ6p5FPTxALdTdr7ZPzntsxjwTFC/XzXqe2m7SgLQk01vt0V/CrVukW8i6on7k
 oqJukRxvoV+EW3H+uMxaUArmtf5h8rWs0bF6emOO3L8mwDGZfep2K+nWodBBkqi4rlx9
 XHI3C0oBuOpgPVmgSesSj2Sm8o7vQdc7NREhT3QUHqbqaqucoUG5+jy1z22JUlJs5Bm0
 pBlG8OBjYgceeRMCFBUlKbVF653Dd5ezDmaS7TmGfAThwskAMlONUG5uDIGjjhBOhwZr
 LZiFlkRoPAESRcNFVOJUFn/CJ5+ItFq8U7j7Nd7VTKsv/yetfDVgqPl7BreR1mwsptxG
 GtYw==
X-Gm-Message-State: AOJu0YwOXBxBcFRP70vgncmH7by9h9c3v2Du8nshJ0VvsFhneGX+VCLJ
 dTywDSg2yHNkTWIifD7mc6SvVGTpTBgJ1mixvLqLf44JVQBR84fgZLwqBCOrPLfTmnE+xXwgO5z
 TVKIp
X-Gm-Gg: ASbGncvLWzrT5aNTUWcOE6b+MkuDtuUOd4r3suumeT6KN7yga9Lx6wwKh996ODLDCck
 ElMXAGRgkeS/JUEiyP382etyfNBNed1vr2/zCS0HUcqINBkD9O9vm+ibhk59G+x7cLOxKMFT4rx
 TPIq9o/hn90NC91dwODVGF8nRWJl6RVIVRgMoM3WQ84EnbokxGwWCo5yyNIzQti9P2WH3sF4Gr3
 aulOauwKQ8xysdxIrmVDKpMRVIVZJUOrbvjVvbHfeheUy6TMpkmxLE8PkEM0OAKNbvdDfgJqAvK
 DjTtLE7th/lx3Le20Qq7vR5SYLCNJ216gbhgLQS1ve4kOyXUO3MErRBPlMI+Ed611jZCY8tMraU
 m7o9eTHT9fSuq/+WxtYAwcp19jdW7m9IWXAAxwWHygvazH7dDBKpvmCzpLebO4y4Rilp8x4Npju
 QPaj+mILk=
X-Google-Smtp-Source: AGHT+IG2MC56Dn0PN/T31M2p1zTZiXEdkcpm/2j6fqpBKfHVmcvG6g4HCgE+4aVxVtopwZYLuyBPZg==
X-Received: by 2002:a05:600c:1390:b0:456:1b93:76b with SMTP id
 5b1f17b1804b1-45a1b605abfmr41407275e9.4.1755206965646; 
 Thu, 14 Aug 2025 14:29:25 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:25 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 6/6] config: enable comma warnings
Date: Thu, 14 Aug 2025 14:28:52 -0700
Message-ID: <20250814212901.88863-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
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

Clang (3.9 or later) has a -Wcomma that emits warnings for questionable
uses of the comma operator.

Don't enable it for drivers since many drivers still use
comma operator unnecessarily.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 config/meson.build  | 1 +
 drivers/meson.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config/meson.build b/config/meson.build
index f31fef216c..d9ff0e31c0 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -313,6 +313,7 @@ endif
 global_cflags = [
         # additional warnings in alphabetical order
         '-Wcast-qual',
+        '-Wcomma',
         '-Wdeprecated',
         '-Wformat',
         '-Wformat-nonliteral',
diff --git a/drivers/meson.build b/drivers/meson.build
index b62880db02..4c08a1dd9d 100644
--- a/drivers/meson.build
+++ b/drivers/meson.build
@@ -59,7 +59,7 @@ default_cflags = machine_args
 default_cflags += ['-DALLOW_EXPERIMENTAL_API']
 default_cflags += ['-DALLOW_INTERNAL_API']
 
-warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member']
+warning_disable_cflags = ['-Wno-format-truncation', '-Wno-address-of-packed-member', '-Wno-comma']
 foreach cflag:warning_disable_cflags
     if cc.has_argument(cflag)
         default_cflags += cflag
-- 
2.47.2

