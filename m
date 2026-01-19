Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984E4D2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E3DC4065F;
	Mon, 19 Jan 2026 23:46:09 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 0D86C4066D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:07 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso33081785e9.0
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862767;
 x=1769467567; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=m8E0pGgGfuVN4MnS895fT+YKIG7iGt/bWENEkqkyCCJBU9tU7FbNGxWPafVUVh81tL
 E1qScg7m09jNRKL+3m7cVTqKMaTI4GxJyudsa9mIox3E3cPF51G5X/WO6/u0vxSv66iV
 QAiUtyTUMcSsGohCIp0zRduRzCdIKnu2L0oF0k1wRxi+40KZSVjvwaJhcOuDaM0qlrGo
 NCLi0DXCTQl3Gt2WgKRrxS7QVb3U/2IANY135hy9YcD4GfaC16oZFDibEWHALt7kUKwu
 jtAt1nZrdvoUOIZ3aLTUBM/9lQfHOvCzn0S1Zy0mrm1aSu8TCKWFbTGHgnOcIYcJ4v3a
 W2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862767; x=1769467567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIHMVO05Eyg+kXqXE37cfnS/YFGirk6J7ZDMSNPxkN8=;
 b=fKP3A3et8M4TjoheGMu+OnV5/0a1H/O/ym2/iuZT8pLeqxoyedYundXAbVwZWL/XiK
 WVTJaCL2axmg/7Srhz7qsNeYl8oge4Nlq4WXYPOvktDcts1ZsDMjgK3oFkcbN1sdtK3R
 9IEdCkTuDLIF5mriEHu5/rphAYFM9j+AYGJ6LLUrH9fHFpNHCpexhrwE12EssBgy1LYZ
 EUT4NX0eJ2jjguo0QkVNuDb7x71YhGfR7fBuXj/OYcuZEWvYe7z7mIg7hWHDpBr8OIId
 3tNh5d4XpSqqVJui4E+PTP73mJMwyvG6IFo3Dt6zJEGCDfbJ2rZ8rWFZyQEStSEIxWsp
 8+5w==
X-Gm-Message-State: AOJu0YyJd7E3TM6DzDs7kXA9aRWUzUyvOhEvvllyP8N/ozyHUYEtxMq8
 I2p85OhvqxZa5+zBnVxLNo7FzEBrGYHo0hCIiaJ876c5W956iA1GILs7Jz2tR6IJH5EMu8YgxKH
 K3Q4+
X-Gm-Gg: AY/fxX6Th0fsISzWzlc8mS4mU3jBySWCcCgdX9DZ2F65HK6a8ZNprKKol4yqs06zuIb
 H2L+JaRWry9jpb5KnSLvWzYTIsd0fpcr36DV/c7pQpbjT/xFieEyFqTq6cgDeCeJ6x4WyU0JKgo
 r0WKCduJVVD1MDIu+Cea1JN4UXg5piP4kNtCVmQp1qJxNNa/0Q9BgSaw0lEku6moCQLfPzJdVAx
 p6yEGwqpy866KsSd0CbaKmXmYxqpedJIfCaramygl457tGo0GDRQlBUU9WEyJhskKihfBPf+FBn
 nV7mnzZUP7fiHdlWVg1bISuUjf+Z9EJ/p6BWS+z+RGHm83KQsNt/i7D5Kw9nKzOoG7f6e9GlBBj
 uEAS+WTvmpWbzUVC1Ton/gVnN4PlkBPr94+uDOe3qsVIEvoPzJxyPDDLk10sgreRQWIgeT3bfSP
 c+SEwovnIYBj4DxSIzzZAnklAFsEflm5QyrCr4gWuQ+ORtKFneTcK86zs3KYnF
X-Received: by 2002:a05:600c:4586:b0:477:76cb:4812 with SMTP id
 5b1f17b1804b1-4801e2a50e4mr166126765e9.0.1768862766611; 
 Mon, 19 Jan 2026 14:46:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 3/6] common/cnxk: re-enable vla warnings
Date: Mon, 19 Jan 2026 14:44:10 -0800
Message-ID: <20260119224553.226243-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

The code in common/cnxk no longer uses VLAs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index daffc15afd..58ebf4c99f 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -94,8 +94,6 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
-cflags += no_wvla_cflag
-
 if meson.is_cross_build()
     soc_type = meson.get_external_property('platform', '')
 else
-- 
2.51.0

