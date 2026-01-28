Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1101D46C0A
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 21:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB82540652;
	Wed, 28 Jan 2026 22:59:00 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 70C3D40648
 for <dev@dpdk.org>; Wed, 28 Jan 2026 22:58:59 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so4358885e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 13:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769637539; x=1770242339; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=g/y2FyJigh+zi2KKVTBiE5mYdhBrWEskxbL/fnrM4vB+NtoJ1BxWATGAi/16NYYv/c
 ZQFq+8+9m7aoz0wHpkMFMLaKU+P/FpgCzyt+BjrqoLMz7BAytq+0ITpXLb7xOiaNsJHV
 0M7S+73+eNfj9fGgNz4CNqg91YKYvm9mNjQSMljyiguHzDTajaf9w0cX8cqac3L2buHF
 fBVtLGB9M7rq3MTv2hQcz9fTagaxQXe49XPIqi80xhh/ekHDcmn1bbSEV/hP0Ast9hXn
 p1ptYYojJ9WOzlezpZRRKqI+QH7EkbaSUYAnaNagsDg939gPMkEvnv0Kz5mgAluATEnC
 mRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769637539; x=1770242339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=kU0/2ikOf3SecddznxH3QS/hJ2T/eglAv3iY7Yo0bTKwc1sY1W9/0Xq40S0oJfKpLA
 TjDCXPzpX1FQbQSGUzTmFJKTrWg26FyFPJWXBdAKfV3dGsq7WfX0+NzS5pRpSuUv7Res
 T9jdERNbbR6wY0HEsWPwgklFIn3f+rShFLfcQSKbhB9YqtTQVIWpHahx5d81rC5pH5fg
 3xmSs0xo3URea8XGE/EWFDSagOT3+DKU4ZGZkn9LuKtZKFyk59vhtmh2919SsDrTEStp
 zaBIGnuRAusgXj1chupufZeAMW1PsV93v3ND/HzbxHAE23KNTnBMtgpa25sjop/YGPya
 yZpg==
X-Gm-Message-State: AOJu0YzRE3Z+W4pGgPh1OP/Eh1kbUY46u3+DeJb2w5YTKysNGDOxMZYC
 3jxZ9gEvg7POFDzq4quEi43TLa1fFkXbUIgmu1rI6iUxZGhAvya88ZJHpFu4iFevaxjIxZKL8BN
 O2G7j
X-Gm-Gg: AZuq6aIFW0K5vgIE+Cx3g3oeTCfQXcRZBG+JOfpqw2kiE/wjBhv51EQaINvnedvvMSH
 KSuIZBDcffOPawZXSMz0RvQZK1Vg4MPy6rN8dhp33rXi5tWKJhuyCN8nIqtk0f0tX1EGvemnEyi
 CpwMnNkgzUc22TGf50kwDtXsseph868ixt+dkl5n12JWqEHz3L4OXKUouAG1Sh18T4cYkJIm3Zc
 uWB0bmEjdpzYed8MdhFCZ2l98WfZXD5DG1XKBv+n0JVfgzxL5WM/ILL6DqnhbuAupjHhT7Gm+7N
 kcp73T4d9dfjoXRZ78HIbvsjM+otANnpePSa/VNyj/MlXRv9IDrkQ+3pXNdN+GloPFomc5YfnFO
 0LCon0iLMYzC9IPSiQeEzrht8HzLeoYXLbOVwdlr+CXC/tfgHdiXBgpQ/XQiA0kPmfbL0rPGh5q
 QJ6pMBi+YQSgO6t3hAyFMvao9+K3bfcqeIdNoiEkhyw4Op2Q==
X-Received: by 2002:a05:600c:e40b:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4806a5bef7bmr82244605e9.13.1769637538646; 
 Wed, 28 Jan 2026 13:58:58 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cde00e8sm91536885e9.6.2026.01.28.13.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 13:58:58 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v7 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Wed, 28 Jan 2026 22:58:33 +0100
Message-ID: <20260128215838.73502-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260128215838.73502-1-sismis@dyna-nic.com>
References: <20260128215838.73502-1-sismis@dyna-nic.com>
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

