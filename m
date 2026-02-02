Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57AEE7315A
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 11:37:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DF6040B99;
	Mon,  2 Feb 2026 12:37:05 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 50E35402D8
 for <dev@dpdk.org>; Mon,  2 Feb 2026 12:37:04 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so46090265e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 03:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1770032224; x=1770637024; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=FKxLfJBZYn0BZBvDRB6uoUtx8KpVPvqlJbVQfUfWBXusuG9JX10m84bHsiTi5iz+wM
 Zgi2Qzuaum+QQDDRz1xAOuqKkbLyVArnGLBSTqs8lOjKxmOlwz52PIwTtuKpn9XywGmS
 EYHeBoL4UNLi9VMv0KQvMdLhqLbXo+X9heu8MpEaJGbR+T4/OFg42Lp4sBDquMIJSVd7
 rKosSSYyYYmjgZTsP+bZMtq1PqgBeLH7XJj60ZaVkUmHKPF87NaDsUMPWdL4gbA0kpg0
 bfpAkZan8kMHFzcC93CSAVqL6R3DIDU3Ibm/wwuzGq/63MWCBa+6axOslvQXQ/oSQjo4
 B8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770032224; x=1770637024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=DilnLcdpUyr0KK3ziyEnS1+rkuPREgXWTASa3IC6Sgt2rTleZvG1v3x7YH6Kceiysj
 PKhqr9Ey46I3PWMBxwYLKcA2no67QPo87Y3idacy3RK6rqPutZfn4T8OyHo6U0ZWxr58
 TRqq5ft2/s5ONXiVgeWMo1rsxhnMOz58YjaeXZtoUY34zp54uJmnqwbTtMa6NnDNfbzQ
 SOgZfCaE128BYd2jNsAR1ZPYD8WW6IQ605Z7I/z0/H266bVztPwb5cHa5pY/wED7ZnWv
 yITmmVXl7Uq4z36EluLyWA4poU96fidJ9HylXTsVQMtxlW9nTh9WHFYefga7XBRqImZu
 HZcw==
X-Gm-Message-State: AOJu0Yx/f2b1YntLfxYTp0AguJgLeXPXTKqPwHSu8GqNOxnSJOZXVYK/
 1pOgLl7H6RCgndou6JtLK53j4pnE5Yy+ZhnlyLM/hiSR7xUDbaj5L7tmh83PKCVz21uXKN6vrQ+
 K3dvJ
X-Gm-Gg: AZuq6aJ86PO+8tpd9rbf9zxd3zYDj6VVUy+hcZBEyBRYqDFZaoHJz4tBdTsT9hFqulb
 a8v9tJAsJrqlzG4gTfAE0yp8fxH3vYFIlCb/yywwQEMLg0JU4YxlJoUuTu1uE/iljDnegC5/Tag
 2oLP+iX+NrxBSWu4L7tbAnJsj7c4+bcqkokRYkpiyGK+D1y4Dw7wbwE+f/qGVHCNHy8Zx2lU1Lp
 4sDzHkuRwLxnZQmoInxQ8r9ilQBgXtwxk7HY17vqNY5xvCAZasI3LU6vIpzI7cES3JTd/HpXkCf
 0O1E5CXJ76ITb0kAJYBWmEJ5Cma2JTbUAOXDG2MRA6oNEU4zZyIgkyvKFoXMhBvKptgzZls+BKN
 /iiDKNE2o/GPZRRc7iZK4WjpfiPBXPO2cusnfUykuQmdFYwCltUi0stZ3dLc53gOJmpB+vIQ9kO
 IDu1btwSO/muyRuY81XZHR1nv8PHtnjeHSbH4sdHG81HU3aA==
X-Received: by 2002:a05:600c:8b12:b0:480:6873:b2f6 with SMTP id
 5b1f17b1804b1-482db481c7amr140140485e9.20.1770032223267; 
 Mon, 02 Feb 2026 03:37:03 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bee687sm696090615e9.5.2026.02.02.03.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:37:02 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v10 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Mon,  2 Feb 2026 12:36:53 +0100
Message-ID: <20260202113659.24052-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260202113659.24052-1-sismis@dyna-nic.com>
References: <20260202113659.24052-1-sismis@dyna-nic.com>
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

