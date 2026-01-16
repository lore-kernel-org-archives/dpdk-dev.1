Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD5AC982C0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 21:17:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DBE142EAD;
	Fri, 16 Jan 2026 22:17:10 +0100 (CET)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45]) by mails.dpdk.org (Postfix) with ESMTP id B3A8F42EB9
 for <dev@dpdk.org>; Fri, 16 Jan 2026 22:17:08 +0100 (CET)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-b8714a52072so374189766b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 13:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768598228;
 x=1769203028; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pe6JnpROnnEbkLK1aMQKyF4WRRlrs0/gveclxEIPcxE=;
 b=ixzQqcDnSatF/nlj3H8GiZma2OqJU9YwSoVQ0/dB9zKkFF66+2WmQzDJXl55m+tygk
 BYeC+pPspMvROaI5IHzm0aBn6tPeaC6Cw81maNKkK1eJ+u6sCouJu5TUDgSjx+Kf6LPl
 bzBTkxWRb3no1dmCQGPWqzeqrGwngQxOSJWxErJwKjfbcgQ+cpQU+3+iS0Zs/zg+HQcU
 5JWYndldPnDHVWC4Bhf2j8dEPV86TnQTRiY0+vDQdSOtZTbivd/bc9WyUXV3vOAQeFGY
 5/Tuerdb+jXRFWcoh742QbE4K6ww5jsix//nScOQZPTGR8/KajM3b1NGvPRTMizqXFmu
 zyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768598228; x=1769203028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pe6JnpROnnEbkLK1aMQKyF4WRRlrs0/gveclxEIPcxE=;
 b=oCxtPDt8cXndTcNlE0GHrhhaadLrKJxjLDAf1dtmSwLdStGanArq1hitL4IGW984wM
 cHXZ0QiiSQoxYcnNLd2Jn3ome0HOqFDbGRlc3cLbcp9IZpJQwUohrrSmfAq61wM9dUWA
 8xaEL39a4rUuIiOdjb/mUz4kdyiDxMIssNZ7ta9u5Nh80KfisKYbq8lG9fqsbTee/+nY
 /YF8DosJYcE8QUM9MjJo3qRGjEZB9F1HQG3Y3VxqhWVkPqg+Ko9QSEVveLziniTiKdVU
 iA44xt2KVk15fdSDsqv+aJ0K3fUnorTRPaEcaB2pUguQ8Kl0gVhNQhT5+3f7MnuT0Adq
 3cCg==
X-Gm-Message-State: AOJu0YxicbB9DAVnQKauGEAGCHDSI8EzP8xrnuNg84TVFJOwfEN8Bhmj
 RQ4V/tbf9pZ0/Yz8j7Fdgs4uu/uLAfDsQ6ZNRBH8nJEAtDCkMfOg4wKTvuVnkjB/n/LAgM3cnla
 Rbz6N
X-Gm-Gg: AY/fxX7DdCcWkesqigBOihv20so4c5v3hI+nWoO032mfXiBEkgdXZzMFAOfm60o/X3R
 WJMKqyazqCaHp9fB0vXbv5G2zzlww8krNIqlH/BGQWfK5zduMEq4r9yW7WTi5uF0Vta4oMk6L2+
 EQTM4RU/9vOmti1m4rDHRaZ+DLyx1VMmYAWtLCuw6Wcc6gaqCYgircrT6r92JTDbfVBrko5QSjj
 MNYFSQlb/VDKF8g2ecPErjJyeSm5QxMJbHYw1SGELoywpx8VmLN7rre0FCAUySTwtzazPSpJ+B/
 l3XRFakwcxeVeIeUVjy3r2AhljrbOA15wgWfIoaurq9s+ctW1gQhCBlDfCBOpeO7bgujpd2D3xe
 Jt4QvunvtNIdh6C2v4KR6Hmk0kZcw6eJSPOuzUWXB9Pu+ihpaY8iFxEL8/ELER+uel3JD5Y4vYc
 04Kv/hQS9eJz8rfzrD8r5HVQOfzkhWWYVWo5ldRdIFD1bXTKOgvw==
X-Received: by 2002:a17:906:730e:b0:b87:115c:4a30 with SMTP id
 a640c23a62f3a-b879690c497mr309796566b.16.1768598228172; 
 Fri, 16 Jan 2026 13:17:08 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168ca9sm336649066b.15.2026.01.16.13.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 13:17:07 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/11] doc: correct word choice and redundant text in intro
Date: Fri, 16 Jan 2026 13:06:22 -0800
Message-ID: <20260116211649.104776-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260116211649.104776-1-stephen@networkplumber.org>
References: <20260116211649.104776-1-stephen@networkplumber.org>
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

Replace "customers" with "users" as DPDK is an open source project.
Remove redundant "(linux)" parenthetical after "Linux application".

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/linux_gsg/intro.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/linux_gsg/intro.rst b/doc/guides/linux_gsg/intro.rst
index f5fd016a60..03df4f9a33 100644
--- a/doc/guides/linux_gsg/intro.rst
+++ b/doc/guides/linux_gsg/intro.rst
@@ -5,8 +5,8 @@ Introduction
 ============
 
 This document contains instructions for installing and configuring the Data Plane Development Kit (DPDK) software.
-It is designed to get customers up and running quickly.
-The document describes how to compile and run a DPDK application in a Linux application (linux) environment,
+It is designed to get users up and running quickly.
+The document describes how to compile and run a DPDK application in a Linux application environment,
 without going deeply into detail.
 
 Documentation Roadmap
-- 
2.51.0

