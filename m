Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C6D2629C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFC3641132;
	Tue, 20 Jan 2026 20:54:36 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D76A54026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:30 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5275743f8f.2
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938870;
 x=1769543670; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tG3Xqs7sJ99JZUo3PX/5mVr2yzPLwBSuqCbr16ww8N0=;
 b=ZVGbeoL8ciA6IgxNC9cams+tv/DkUctrFW0gHlHWIShKR5xlJloXOqXyEz0eN6DQe/
 kElPhTzG1vTafghR9lVTQNpVz9XH4xC3+6hl2Stk62ZXWB8zruHTEfoGzw/Xc7LlBUZ9
 SPeTIRZPIllWLRBYOIAWqBSzRFtMGc/XF7FzhWrVxsqqbrbstrFyIzS8aF+RO9EdNknR
 PHX337fAI1U6ogcF38LnGLkOrfgD/DxNWaxUa1GS/jz7FMtPQnlK5nrG1EJlCD/oSPH8
 kqEZv6o2WS89AtLcq2fUF2AGJDi6JVKqQ4pcLBQGzYdkNFfGZs81nEjxcjQo2Kt6k8s0
 Ui/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938870; x=1769543670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tG3Xqs7sJ99JZUo3PX/5mVr2yzPLwBSuqCbr16ww8N0=;
 b=HB9BM+O/vSFKZI++Wo5tgZcfMew2MBzu9iEpOoRsASw8dC+GCYPqWQsLYrSQjyFBRq
 CeSmUX68hHY9t8kDc3A3/U2wa0gH9v200tJ0RWajGNs6mouH+W7CWvdE4k9YyVlJuOSQ
 +LMwwyLMQ6RlOxkMHF9NYuEQCB4IV1H1LrwpYilTAXzZ+4H/C1rxgesMBUvlJyDMSL81
 7fA7L77o+XK0vNgKWfvKoqQw5ZOzLRyVaUEUP9nY+vNzff7ZAdGTTJjIB5vKwf1dzm2b
 6pa6JeTQPwPLaM1FeEByxTUC+YUL5DgJeJ2muWVZCN6kCjlEDa0jGYN8DNhYUxD1QBji
 /g6A==
X-Gm-Message-State: AOJu0Yy4DajOtcmrcgWxDkSe5B0SRui3m+2OM+O9gzhFi/5CoyXrbgjX
 Adaal0JQ/cr305q2KRnPVt3DeKkMkVaNas9I8Zz3Jug/hHifQdz+SPxsjjt7/68RtIW3ZDukaU8
 FPufw
X-Gm-Gg: AZuq6aIn9httwQYOHozJpCZrc2ZWOm75iC6cx2VjE6n1hFeMaEt1Mt3Sn33RUBYx7PT
 0Mn0J05sBI45Gu5+ZyHU30rATCgUQDTZWTkFdvSTTE496QegX8VkwsRaTjpmqkfaomxQ2RdR/Wv
 nONMtPK7hRABI9RCskQ6nQy/Owf+onAxwMrTKvJx0nqwIgQ3W8la4mBr4RmAX3pQixH7P0CnHjP
 VZ8eiqV1kgki1bs6OxwlIDFLkNHaYdFr2lIRpFG65cW8SEhfAHrXxJK54iRk0FH/rcu+tRZC6AQ
 HqdTdO7UC0mHz8g79N13Dit9FNqGzMFWQNpoM02d1prGHtbsHko4NfH3NzmkLeI6u0d2ZhEe/Md
 Uu6D6ubXg/ckOq4S1Mokf3RrUniv2O4Ls0LiEkGJpjwU1K1H8GwMd+19+cFCpqvZV/dJhOA9hKM
 qBh2RCHZHU2E1054S0FjhfJ5rkudbnfhJ+8aVinN9a3lvMljt3IlYIlhW7llzb
X-Received: by 2002:a05:6000:2dc5:b0:432:c0b8:ee58 with SMTP id
 ffacd0b85a97d-4358fe6f0f0mr4233381f8f.0.1768938870473; 
 Tue, 20 Jan 2026 11:54:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v5 3/6] common/cnxk: re-enable vla warnings
Date: Tue, 20 Jan 2026 11:52:08 -0800
Message-ID: <20260120195418.466318-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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
 drivers/common/cnxk/meson.build | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/common/cnxk/meson.build b/drivers/common/cnxk/meson.build
index 2b33022eb7..9db77a9702 100644
--- a/drivers/common/cnxk/meson.build
+++ b/drivers/common/cnxk/meson.build
@@ -94,7 +94,6 @@ sources += files('cnxk_telemetry_bphy.c',
                  'cnxk_telemetry_sso.c',
 )
 
-cflags += no_wvla_cflag
 cflags += no_shadow_cflag
 
 if meson.is_cross_build()
-- 
2.51.0

