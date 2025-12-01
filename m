Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E6ED116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11FA140668;
	Mon,  1 Dec 2025 23:04:41 +0100 (CET)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id 601E64068E
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:39 +0100 (CET)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-8b2d32b9777so577113085a.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626679;
 x=1765231479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=mReYkacszqkm2hIB8xNSo0POQZMxQJTdxUZqh0HjuJAtr0eG0UdjRhrvxd6FsnuEI7
 F+jgKMyGOIplyEP9+kzok7WpZvnxa6EEZu+BKZ9yYeSQLJC3l4UfnkMOWtqKTmgUFxey
 PkSw4zWv643CGqNdj8bRpgS9kvs65E99R5JSc/mWkEmK85GSpfqmUxklMNjLG/7zKhfX
 u4v4Mtr1r6G9vYLcsRay5FLOicHTKhLN+E9JR4rhDfhHX2YUE3ttkIajw7DfY2pUkyU7
 qqS2NMG76Lzv7yyvYtaWJ86GJtunsp05UborucEsPtPNIx5yV9CyhPVn1ktLLovQEdib
 aA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626679; x=1765231479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xmjp3xcgUIPRU8OqmcqdqjraCRL1/JtuKv+rrHQRLzs=;
 b=QLXNFsC4W9U3ktGdmHyN7m65dMDu9e9IhMzS4hySLgs3hkxSDaC8TZTkK07y8M6ZOM
 w1SbATksztlVLTouZ9ErgoeowD01a0NusnCBiAbJxA/CUQqW0rcRjJcFbVHLOTss4UfC
 Y+Pfa8tFJbCTbS6eQPFWrfS7NmSVoZbhYu+031oUSZ2Os7UsvXdVO4OEOOFTJ5iWY/sv
 aFidepZ9n9Tt+XfC8r0jo80v2ZfJdR+5Y8nUKUr03qIHYLxNFljEzkKG1xKJH6aeXJcX
 511TvshhJz/Vx+0HElJwdvvwC43WKybDW7oQ14Oibh4o5AiA2ep++KxwjFECANX5xT0q
 WmBg==
X-Gm-Message-State: AOJu0Yx7v5bmMPYm0Jk5ercIfyXzSE8TsxBPM4W6HpDiz4tHQ4jv/304
 dOGOCytyiSpl60Qn8PMExaptPogyUoeD1qAr08MJ5fY6moPOZv3COaLLVtkKSBBYZOc1zd2CGfr
 BZ0pQ
X-Gm-Gg: ASbGncvnEnQn8pgPBU3jTHIPvuH8ThFzRJNpZSR6DsaJhr0EEfm/9+0LbWe6tBFW2Ov
 c1PLcWxsZ0girDvz3OMxufg/ZJUnFwOUPAR5VdffysZ8SIx3DdBFkzssSxfiHXSuZxrNBHUheEO
 iIikj59BzBr3ix/7BRbR4uG8ynQVb7Z5oOHMyfadiC7XDEJL1TvdVghGrXf9D/iBOtWlddBzO0y
 MrdSloYwjr769dZtq8gsSZ0aNBGpG4Ra2K9DQBn8HP40JWAOZTvBv1vvwL/2uFVznp9FfstcUR7
 s6jqOEQGsM0fLfsyTU3xxto2jOgyHLr484poR1PTlXOyj7Zq1IDnNicCS8PBiAkZYKQUw8EtsPI
 unkTW02sNt6RAtdMpyiS0nokiQUzicCaWFb7CtQQRtynIX9yEOofLRdefP+x2cOzbPUreTobKeq
 ZxRCU8iMXmdXmDZoDbtgugfLH3vwNv8Le5LgmsV3fUMbm2ohldDg==
X-Google-Smtp-Source: AGHT+IHmznMy3s9lT1kGAuVHJXKg1Bk8IX07dg8bwUfEcvPos2GqJRwmpCh2Q0+E/07o2eW6HCIsMQ==
X-Received: by 2002:a05:620a:4694:b0:8b2:efb6:5cf9 with SMTP id
 af79cd13be357-8b33d5dd9b8mr5406927385a.82.1764626678541; 
 Mon, 01 Dec 2025 14:04:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 9/9] test: re-enable format-truncation warnings
Date: Mon,  1 Dec 2025 14:02:07 -0800
Message-ID: <20251201220421.207285-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

Tests should be built with warnings.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/meson.build b/app/test/meson.build
index efec42a6bf..b00260c0e9 100644
--- a/app/test/meson.build
+++ b/app/test/meson.build
@@ -260,7 +260,6 @@ cflags += no_wvla_cflag
 extra_flags = [
         # Strict-aliasing rules are violated by uint8_t[] to context size casts.
         '-fno-strict-aliasing',
-        '-Wno-format-truncation',
 ]
 
 foreach arg: extra_flags
-- 
2.51.0

