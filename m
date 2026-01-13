Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5A8D30CC2
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 20:25:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A517F40C35;
	Tue, 13 Jan 2026 21:24:09 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46]) by mails.dpdk.org (Postfix) with ESMTP id E1CAE40B9D
 for <dev@dpdk.org>; Tue, 13 Jan 2026 21:24:07 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b874c00a3b3so134222666b.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 12:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768335847;
 x=1768940647; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=vecLVKAKgdi4AOTVKyt25ZEO8C6dd3JZjAeK0C1QkitG31MVj8B7CzmvDrFqJ99jnt
 jJW107cb5UyRAnjmzGMUDqc93otvICtiPiCKm2MwchmXIlBiA2UtHRSnBg+H7O4z8JWS
 YRmwawvijTgzhffdNInLWOu4e6XqMJZyVHjMNXf5klu6wIMph7cMGqminqIv2GRFWl++
 TbVxoiYirQFKu99ZNszCVKsMaOUAfmLFgk2G0j1bHdjfZ1AI4PlxZSBlRpMJa3PvxR0a
 Ijl/+QQhTKUTavthRwwHNQIu8lccLiXLd3vO9sEhYYiMFAp3j3XrkF7ax11cX09MSFYf
 h32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768335847; x=1768940647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NAHPuQvE2165rpGxsJHW1wsr08rO3/PzDs3KR/V/FX8=;
 b=JCKb9/Uhlr7wOveG2q0ojZC/SXg8ZyRcg7wjtKBmQdBZ4aE0sedx8SHaowKrgXNpku
 Z0IrGS0K1efNLY66xCLQcvsbfkq3iQBsM64cuE40NIYgDwwQfOFNy4eCSCl0XpQ0C8E0
 NkWBhMXzWjmCdT9DtzGTKvikpkyUPbimG4HO80a3skGUZtnnKc1MGSr447bEcOs0wr/k
 i2aAVcMzZjrOlmYjNUAGGcO2X/uWyb7cNgFcFBHGYzUQEMmBSHRk2bev7Jnc9iKoyMaW
 SHHo00HmQwiBZmRJylCDOTozj5oUB5yykk1UR3ydmboI1m8+s6Bt3B4iNQiopat06NjY
 EraA==
X-Gm-Message-State: AOJu0Yyt6YiRDjXhJtMz/hITRmKUi7ulYUtQq1aluOo9OmAMMtkrx/fp
 b9wDDKt9i8COovKQcG9p2oDn1RXYXb2Fij0iqRSI60F70UzQURJ4ExAciIWNdl6jGhRHvE91JD9
 jKK/H
X-Gm-Gg: AY/fxX5VdbqKa0NINwHXuoC00AShrBdUDdxB/j5CGgUJhV0aCp8KNJZSU9hdxgrKADI
 b7nJ1rc29eRVbuZ/aj5xzn5SrNX6RE9zgwfwXAkrEW8CjtbbZ9wLXBUhkyP+DqkNWeJtqAEUJdI
 vg08NA9C0PV3Rya7SQXIMxx/bjMjweO27h3CgjAtoZ7JxBtZtmKRrcFyrDQue2btmHUsGSUDWrQ
 heiBV5pNkJ/EQy/uvabBX2dEV5G0NIFknvPUklA5olfYOB+soPvCsISF6ZxrZBF5OvIJiiRJC9v
 h/A50/JzruS1sC3BQg5KPh92kchrIM2+JPeCVn2FqRM4ndhpA9mFbyYAkgs6yGtYVFidLjrTGNx
 ChV1hSblCuw+tXXUn0HdoLibhmokiBcV1WSlyVAK/34Hbit03rqzYKeSUVSlfTyRyb5ovojQZv3
 /YbxjAtk6fM/3UgpyaLt7YL4KrK9F7ZwtXeL3bDlofc5mXxqBdfUVQURjFRJIL
X-Received: by 2002:a17:907:94cd:b0:b84:1fef:329f with SMTP id
 a640c23a62f3a-b876108d565mr29482166b.26.1768335847511; 
 Tue, 13 Jan 2026 12:24:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a23433asm2314992166b.3.2026.01.13.12.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 12:24:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 18/18] lib: enable format overflow warnings
Date: Tue, 13 Jan 2026 12:21:57 -0800
Message-ID: <20260113202329.35190-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113202329.35190-1-stephen@networkplumber.org>
References: <20251202172626.283094-1-stephen@networkplumber.org>
 <20260113202329.35190-1-stephen@networkplumber.org>
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

