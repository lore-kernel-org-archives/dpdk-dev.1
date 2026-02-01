Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966A0E6526B
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Feb 2026 20:46:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C03904065E;
	Sun,  1 Feb 2026 21:46:54 +0100 (CET)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47]) by mails.dpdk.org (Postfix) with ESMTP id 4DF3940150
 for <dev@dpdk.org>; Sun,  1 Feb 2026 21:46:53 +0100 (CET)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso3054061f8f.1
 for <dev@dpdk.org>; Sun, 01 Feb 2026 12:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769978813; x=1770583613; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=gsXhBcGyLPhe1gZ+pX14fXm5OPuKTxfdl5Lqe72BYxueNnEzWQEM+0GUioc0eZNZSu
 HztMesayQ7oG6cckNJAomjgd3B2YuZEzKsz3gYtQSsT/bMReG0QEebBUyYOVBukNHrOn
 XdHugZwnTlyvMAEW/E73yjEsFfQ2sUBtgQzx/JXkxkv/G20i7Gx+5F6zNlyv2JsWjj8R
 jXpLHX25oAEBkWgMk9+I3k6Smz7AvZKaVXUdokxbIONMBpNQ4RZgLVIPO55K+rLGT2xT
 dM0Do4kYnCEje2wxq5IjIFjRKY911gyYBAv9o1zXtQjpffAHOlaS6HfJmlyVz+QZlWXc
 sVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769978813; x=1770583613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=QbPKKLYNXfK0ml3umJmegWVebJNaANr3MCpZ7JBB2QoK2F5SmWb+krVoL1b8aKnAtG
 6eb99WpPYAfYDXbBUFmt7dfu7D6T6mG674+d0X5c1JV6beIhSHBwpUOtCQYn7TMAcsqc
 9CFyHhBH9bZ7ck7AQgUSB1LJaKWyUUwGAhA1Xt6DZJO0pGAJfzAW6hYJ88ibUflYGnEw
 ZX5gmVQ2Wr8an6LbnO9NgDWowyiE4YYaOAfLSixQwj9+iXXpW5YhdSe2KnCvFdWm96JP
 vUmQU+/32ORQmwaa7JmPa8vvn1IRLipzUXbh5yYu1YY4KUB+s6AQpscM5opgB4CLqqda
 ju5A==
X-Gm-Message-State: AOJu0YwDjqBMvj6ZOkqxuNE1K0vb/0/AdhRkj+vyu/ZDUY9yMnVErsLv
 cVktwiKA+0nYgGt5AhNcyC59bJsfhAZmDINihVvY+GHdIS7Q5DJ0hpRGVwoqDL8YrrRBIfZldlc
 ZsiaW
X-Gm-Gg: AZuq6aKhCAiTb8bqa50u9X4T4sNBnDf/e+PEF2ESKFZPMW6iO7Glwrv2JqBk2zI+6Tv
 8R1JmHWVf1rqtMRbHp+8L9w0PDwSsx3rjC32TVFvkE5w4Cix5/YbjpBVZuB2W+xFk8mkivDWIvH
 A/XQv6BGIr+Jd8VAVQfcPzZZPqzdggjt/E3Bg48l/QqYpPYgKN8NZuDyX60Ag5dMz0q9azbuKk5
 35P8tsqiOCQVOrf5nb2iiyfEt36ydr+HpeZJkC4211QiydASD/GbZfdRO1f+O1XoGQYjAyrjT2p
 sspEH91zndBt7zxsTWbl9kULWJg3ZxCllsHd1SmgegANU5GBIx3ptmAIcEYBCfVxZlBQSaY9yTR
 7SIUxYxy7XQvTN/k/gGMBQXXTQ7v0wvIkju+g1FjsJe+5dXl4s6ZckqbBGnLBt3YpYq5RV/ht3O
 0g+zeIB05cPQLkOo60N8+LJWfkYKz5gJAS9gDZdc+XvZ4FDA==
X-Received: by 2002:a05:6000:2c0a:b0:432:84f9:8bf9 with SMTP id
 ffacd0b85a97d-435f3ad73c2mr14972216f8f.57.1769978812707; 
 Sun, 01 Feb 2026 12:46:52 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm37721491f8f.8.2026.02.01.12.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Feb 2026 12:46:52 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v9 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Sun,  1 Feb 2026 21:46:38 +0100
Message-ID: <20260201204643.9951-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260201204643.9951-1-sismis@dyna-nic.com>
References: <20260201204643.9951-1-sismis@dyna-nic.com>
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

Include <stddef.h> at the top of cmdline_parse.h before the
fallback offsetof macro definition. This improves MSVC build
compatibility by ensuring the standard offsetof is available
before the fallback definition, avoiding macro redefinition
warnings when building with /WX (warnings as errors).

The standard header provides offsetof on all platforms, and
including it first ensures the fallback is only used when truly
needed.

Signed-off-by: Lukas Sismis <sismis@dyna-nic.com>
---
 lib/cmdline/cmdline_parse.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/cmdline/cmdline_parse.h b/lib/cmdline/cmdline_parse.h
index d9a7d86256..c4131e4af5 100644
--- a/lib/cmdline/cmdline_parse.h
+++ b/lib/cmdline/cmdline_parse.h
@@ -7,6 +7,8 @@
 #ifndef _CMDLINE_PARSE_H_
 #define _CMDLINE_PARSE_H_
 
+#include <stddef.h>
+
 #ifdef __cplusplus
 extern "C" {
 #endif
-- 
2.43.7

