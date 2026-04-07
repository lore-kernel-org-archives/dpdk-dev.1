Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BCFFB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 054DE406BB;
	Tue,  7 Apr 2026 05:52:35 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 133C640687
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:30 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12732165d1eso6303446c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533949;
 x=1776138749; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yfrLsBBN1jW86JBNYne58xRG8aWjfnvb4pLmyzmMvHg=;
 b=H2slWDYg8IEUDaEpGbqhja6Il2rV/1768r2MgnkdCJYpuwGYPqxa/T0b5uu60evt7T
 E0dKkP/2XQPMty+cgE51BgImx4acYpSbBZ1kJntONjugmA2u97F3lf8W9JZOD2iDvupy
 K6z1NcfyeVAT9g8Rp2jDICSbsQfbaDaYl2cYA6ci6xTOemW4CV0ln9x2Yi77C2n+Jkv3
 6ShEGYciKt26IrPSEqRLTQ3bbBjoduF1cDp7iIYJkSwY9Y9oKhnrUpCID2+hJcOgYNlr
 Wi/GLzsRbPx0eXv0ZijVSj7A/eoGl26rpfWaTDDFQ7enCapBke6ILaqslsReyKpLQ0eP
 u3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533949; x=1776138749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yfrLsBBN1jW86JBNYne58xRG8aWjfnvb4pLmyzmMvHg=;
 b=UCGXry3aOYsnRRNLmFByY4FqM+mIk1rJvVIcZ01pSAPNX9Z1bFemivQfSTA9Hv+YA1
 j1ijiRicJqFsGDk14lgjlpl1p2qXl58jZCO/4znlaWI2hMug7yD7qxTp2xg9GmseHG1Z
 7QeHOZeJeDybfXrR+LGY7CWsaYdN1ybwMe/Uk8mMUnk4Y4GXzR2k1JG9MVy31EWMAqOO
 3svnMwS9eV3cMt3Z8WolxG9eGc1BLwOuBE9RWB0JPCh7ASoDGYT1/2cJluyfgJZHocwR
 aRof8g/rrfwurcNtr+FtgYLPuY1wDKeq6BtJQ+kxwoWu9xWqZ+d1bVl9pmUA1SG4naD0
 l80w==
X-Gm-Message-State: AOJu0Ywg4fz7j0kfg5p3IZpo5JaG/Lhl3mNqVuCZxF0aawugVagV2mu9
 5Stuh5R8oTl1CsYzJqCEu5ytgxd9sZPeDx6e0m7ILskwxVgzljF8tri4zRhvniVm/FM3CsMkf3J
 ixmED
X-Gm-Gg: AeBDietE6Fm5S3AvTf24c7RhPJX5/rCJvd0nT+fS7wAPyx1p7vDNLp+udqEy0+cYhTF
 HhJHJh2v3SwK1fHPBvQvG9yJD25IO8Mphu8TZo7bEBUvqjqObGmcfSbe2PwwgPsDEz3PgairT0L
 TlKWZJd+2BohfLgl/a3o9yBzgDOZHgUf8BfdKc/9xD4L8KDfWHUsw7nqv7xouMnnqZJr8bqLMVd
 T7rmwN98ERnwSz1DRNv8652lKq4acXBVzibzs83OpM/QlCqB1U87zi5/UV2Y+K8Y3/N+Tt9l43x
 1SIpSmDcwLN0fHKRC7p38UQig5WWAEQrOgdhSjVK971AQDkPlfj6RT2c9cUxuLV9QtB7cwa4r5i
 Aa+svhfLx391ThzPyBaw64t3OU8T7nolZDmxaQfU86n40WXuKEk1dS7W1DR1o2s8sbhNDb53AP8
 yWz3QUFlRtF3G2Q0h83UCWIHwJDXJBIcAf
X-Received: by 2002:a05:7022:62aa:b0:12a:72af:83d2 with SMTP id
 a92af1059eb24-12bfb7109c0mr7180790c88.14.1775533949139; 
 Mon, 06 Apr 2026 20:52:29 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH 18/23] examples/l2fwd-crypto: remove no shadow flag
Date: Mon,  6 Apr 2026 20:49:44 -0700
Message-ID: <20260407035209.650419-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

There are no instances of shadow variables in this example.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-crypto/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/examples/l2fwd-crypto/meson.build b/examples/l2fwd-crypto/meson.build
index 8c5432cb7f..c21722b85c 100644
--- a/examples/l2fwd-crypto/meson.build
+++ b/examples/l2fwd-crypto/meson.build
@@ -15,4 +15,3 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

