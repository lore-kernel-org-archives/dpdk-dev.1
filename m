Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30790D2FED9
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 21:05:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9A68427C0;
	Tue, 27 Jan 2026 22:05:39 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id 31B00427B9
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:05:39 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4359a302794so3879562f8f.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 13:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769547938; x=1770152738; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=qsb/Ka5WhK/Hor9QJw1a/+mx4GXMOPmK905oVQ+Vw6uqX64tWWLUEz53U/96P1MZ5z
 0ysV/85tGDJ0vB50NkjiULzwYRK1qXxwfXE9w6yu0F9x2eVcMOQVC/Bss+FTtcTGISHn
 oQ8PhhgwxKjidFhQzsp//+jmmUPNUO8e/LxCLScMLpkoCJm9HPwdWqN/yxNWxQ3ZvbyD
 VIpWqciVvErj65yadZDE9eHYf+mG1OB/vyng8UUZVzIH/H7iT8uov59sd0at1w0tgh1x
 z7pJLPLN4BYu+iGh5fzaCUrPmXjdaia9YnmwUqOrAjv+3TJCiyBlC9jqhfzvCuvXJKUU
 LNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769547938; x=1770152738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=J6CNvHl/1j0x0kLCXNHSHnFkroJXKgvjIECt7c+Or4aWTZyAauGSBHNa2PxTWAFOPS
 jF+fcXwVaQhrwBTW/E8yCsxS3egHRCmJLwc+2pzYP7yh0VKPOdDQpXEIKufyuC2IEjR4
 d6un0YvTJZt+PTfjMXfCR8QA/mSnOBXutz++0yq8Hx6hAbtjHZnmQZRzVZncEFcmiZ1x
 D1kJWIlRUM8IU9GchyJaybJVhtsFDHUlJYbhQ+uf8SBh7OaL5ROxOkANMUGJNe/ftQq5
 AxgNs4XtCRY66JKkPWWp33nN0JHtrpsAGTjT0Enhk/UOVZMa3F9Ng+GfKa1ewjsWEO4E
 kYFQ==
X-Gm-Message-State: AOJu0Yy6GqJrt4kYgkIIQu11Zia8jk+yjwHxS0IIZX3GxtYa2QsjYaPv
 3HU5Oqpd2zVq5tyPOUnU27hsl964AWsPDZ1oiRVk9hpVQOreVb4BVFlJh8oBCINQrt+RYuFTRWN
 KwWAn
X-Gm-Gg: AZuq6aLpmaLrNelxteYP0fLY0BuiXu1Y+fvn8Izyyt/uY4arc+4vn4SzBaVHqJ9e4vL
 dfxZRUDzhStUVsoMZCmL+eza5YV7fSh7+IpNavlWQeNiMgb49r9YNv4FWz9MucQT1h+m0mtLASy
 QgJwWtPNCqlKFDqM3sqsKPEJdvWHInhhTVNVx1J/06T41r7xtOFa7koHJKKfdXmqEC7CA9wmR7h
 Hbaa9OGGVFJ4L+J7j7yq9T4JeSLNk83Z+G+f75apYLJ6D5C841r17D0bF3fcjS2A6gZX5OH5vDc
 XPJbmDcjw75Y4JLu6pQT6Xngi81u3+DDDVh0O++7vDKcBDH4Yjr1udgFD8iwrYqM5fb5LXiq/UW
 5owNmXMyFeGOwCheguxmra5UonIgDQ2nVwySUpH5X0CWhROCqveEHlGnlUj5j2qirBTSevNOBCd
 /+AIsOy7qOK7zVQVh8cXzV3nY5xrsCcGflB+Cs+irYFFa+JQ==
X-Received: by 2002:a05:6000:2203:b0:432:8504:a383 with SMTP id
 ffacd0b85a97d-435dd1c1995mr4320983f8f.45.1769547938548; 
 Tue, 27 Jan 2026 13:05:38 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee057sm2021762f8f.15.2026.01.27.13.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 13:05:38 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v6 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Tue, 27 Jan 2026 22:05:26 +0100
Message-ID: <20260127210532.301464-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260127210532.301464-1-sismis@dyna-nic.com>
References: <20260127210532.301464-1-sismis@dyna-nic.com>
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

