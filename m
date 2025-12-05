Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10F8D37497
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 20:17:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 495124066F;
	Fri,  5 Dec 2025 21:16:15 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 1360040665
 for <dev@dpdk.org>; Fri,  5 Dec 2025 21:16:14 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-477632d9326so17835025e9.1
 for <dev@dpdk.org>; Fri, 05 Dec 2025 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764965774;
 x=1765570574; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=flLAPFYoQHKBsR7o3EaU3s2QjTZRVexE4ZJRcZLA8uFfxPQCJPbBc2cp5k4GkcVIQQ
 Eqxss/HV6bsnLBnBxS+no2iAb1hvrUcXnv5Di/Kf4QEgihZJJw3mDm0sPts9kxzLvWZP
 IEXN/ThmMZd72nM0+z62iQg4owy+4ZmxwFDQ0LsrHUzVwGTYyh9AF9F0BKt9YPBQ5dQP
 tbjbTxtK3sGv0yN3Iw8PRmd7sToWEqr2Ez8ZLgBOqUPA/kWCX7YKtZqXpweV3JA3Dfo/
 pWAETR1QbKKehokkBZ0J78FeU4K1gvoI+5znELlb3QKU1TWhBX28VD6QO0UWcYnc3/9C
 qqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764965774; x=1765570574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=K9r8cY4Up+SiHUQYMvIRwxL+ay5T/73glLhBrkq4JoZ6jbAdqc/eelO5sP2JbcSxfQ
 bF1uC+aY/4nMzFNaMtkM7nkOnOOHVe8Pjn3kWzy7ROQnYDHETLvtNvu+hRlcwlbT1yjd
 E0pGt+AD/FpswlknFoRUFnrjWYoo/8Z4URznAvAGA/uxTIpJwfNpy7Jf1b/oTwDyFHd4
 osYHQUXtkDhM1/InojPfeBzfFjsXdYiFhi+WfRccsxepu5e7bt7obxB4aGOEmki7Fy7x
 plAeLIjqQXnVcpQK/NtHo3tgx1wAGE+yzoM2y93VylSZ4/dg8SlMaQ1/7IORz+R/xEfm
 Gtzg==
X-Gm-Message-State: AOJu0YyuROO4rYqBA/PaaTl/GWjQk6rWaGk0VLrd+olRjBpSNd7thaxm
 13jW6mtJBlhID/99IE8t+ZaFxXXOuXeWxOUuEgX2MWrgbvEjoSceaQ7oH6VVCq495ktfSSjYGXh
 ECxwA
X-Gm-Gg: ASbGnctL3cAS7HHiefjjLLbtLDlnDaKYNPvbI23D9F6jWtPMB8Xk8gFqOqcktwxOeUE
 f/WzhZxpm2Gtkz19u90XY5SkpbvFmPNgST4d4wSOXfLY2UhvrEFBd9HVxtO2pa7uBKIv44MtU1d
 jXaiziF2c5ds3rNtPj+wy51yEgo+K/E4rFAhuT0UqVfJtOPNph7RqQP0T4L34C9zQwcv/++NIJU
 9EdW3Bu2h56IdYAoY1GZDa8uhMvwoWRcTrUA5xf9homtchZfQCQHgPuqstpGAgumTteohQJjosG
 TXlFI2ckCYutTtJz9Cu/s972p+1z2D8UVvLMQDUTgDoWOtw6+KQvfv7CPtj6DZkvhF3mVVcjlC8
 4vY8axUV8w7mBPcWKyG9EdiCFVIcloQn6LCGWkSM4x0NnMAfRJNzzSM1KChVL130HS/HCGSRY5Q
 tOz13pp7MWLYLUY5SKpYFqIU9NBJ7q5fxVQVZ4l/gEsgGtHTnZCQ==
X-Google-Smtp-Source: AGHT+IHucD35QMop773GwWfApch2gEsoLCNhTTjdELdnDfwNPQrpbYDJY2E73gBZkmD9pE2lYD4DmQ==
X-Received: by 2002:a05:600c:4e4c:b0:471:21:554a with SMTP id
 5b1f17b1804b1-47939dfa51amr4757465e9.13.1764965773667; 
 Fri, 05 Dec 2025 12:16:13 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47935fce542sm45344875e9.0.2025.12.05.12.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 12:16:13 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 16/16] lib: enable format overflow warnings
Date: Fri,  5 Dec 2025 12:11:45 -0800
Message-ID: <20251205201537.251131-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201537.251131-1-stephen@networkplumber.org>
References: <20251205022948.327743-1-stephen@networkplumber.org>
 <20251205201537.251131-1-stephen@networkplumber.org>
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

