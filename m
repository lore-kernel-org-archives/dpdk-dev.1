Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BC4FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 18:39:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 479004067C;
	Tue,  5 May 2026 20:39:25 +0200 (CEST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id E6F5140664
 for <dev@dpdk.org>; Tue,  5 May 2026 20:39:23 +0200 (CEST)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso48957505e9.1
 for <dev@dpdk.org>; Tue, 05 May 2026 11:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1778006363; x=1778611163; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6CWA3hXK3YtCexl1xvE2T6Z5JmXrZjkGa8bJs3F41g=;
 b=i6arHdajgcRtQnn5nURxI5q/C/T22SJAcT/f953b2qG7SeIRS3OOpYHKGnjSxVXFHc
 enAqvCpUSTa0jPRTdl5hkyg85zKSQEuK9X6anjCWsXis+BUfC3gQNyqQHXnMDkQloNU6
 XHtiXil6bNu79/UAB9csJZLv0WDa0F8AWdmgUZoUiMb2isJC5ekCW0LVwUscKg5ZtLWe
 8Cdy3Wb6B9Kh7RusDpfABH2E9HcC6BtIiPYncDuCRXqpjiBmG+bZzIBCR02EXFt3mIAe
 o7BosHIWoF+Wv5VAtTjhsxi0TsH4vEGAO1oCKyVvuw7oTh+rNVIjJaJ8VfKKJQPjJVSk
 EjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006363; x=1778611163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z6CWA3hXK3YtCexl1xvE2T6Z5JmXrZjkGa8bJs3F41g=;
 b=KKQfbsgfqJPuMYpFoGDaTI69sSNzYp3xKYcvRmCxEiIbCXWRqs1ZLxcNWQBOGi0HsH
 FLHDVymDIWBErFuNKwxkCy71SAIQMzgnhbLvfrxr3vmKTnSNoAOa7/Z9EYD7ddz9RxyX
 mZSnJS0rhI/HWEMNI016bgoY0HjSHwEMR8Pgvh1IBM8pnFB23k+V9bFlB8WrtqB6I4pr
 Q9OZNq0sqGGleEAWZkaLyXze5anUvCm0FXpKqSsucnmhhq2F2f162LdUXLWF7zQpqYzQ
 OPoVs3RvlARw9TqNLF9WZ6H03DPUdB7vQXyM68gHY1Uos+/V+tLiFiN5cm47I5PIyKS7
 BkUA==
X-Gm-Message-State: AOJu0YwpcoBYtaBKkG+TCxh6WVxUL6apTE9F55N2c8PKE3b0VrLBIAF3
 r7DyMg55FcuwZmTaKvdxHK5JOOTeBprMeaYBPfQhcQvTaXC2Xq+TzE/HyffZse+ElZ98yxAsIC+
 PeX/r
X-Gm-Gg: AeBDiesPfBiOazmxZCMj5MQU09IDTcvpWpgZ3omdoJi2ZuNf2HoLMU/muPs0IM1P77m
 KCIeLoOPJSn9uhXmRpBYv4XQmXZ1CcuK9xjrfFAcjYw9veSQv3ZRcaF9+cCfOIUgQCnSh527ID+
 oKumDuibeVvwcJLiaXVn1/HAJzddDom9A24NkFuHTJSiInV94Qjji8xOZ9pxC0KTluR3G+7/1GF
 cQOY7QBQIIUOWX+gwm5+eJmNvgX6eksksfDlDYbSVX+BEVDjLXYP2GxDlV+5HbHwJ2xtNZQESqw
 dB1BO0Y+wJCw+bxCU7VhEZ6iPESEcFcAcIJS573ZBaADm6DEDRIfPTkm8IPm39ZxKRxuvttB4SL
 aLZ5VIpZ/JlZnO76La1kwQtO/nHeezssHDRyDqjykWJgQI2atyM7zK8Q7z9u3hDnOJwBej20Sgl
 Gpj/D8lWPLPzRA88i04nUUgmA9VbEXDx0sxMQ931xdFICXcO8rzM93t4waCjnzt4AiAw+Pw3qhe
 Q==
X-Received: by 2002:a05:600d:6:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-48e51f21e2amr5753525e9.4.1778006362850; 
 Tue, 05 May 2026 11:39:22 -0700 (PDT)
Received: from dpdk-test3.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02abbsm6197067f8f.18.2026.05.05.11.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 11:39:22 -0700 (PDT)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: orika@nvidia.com, stephen@networkplumber.org, thomas@monjalon.net,
 Lukas Sismis <sismis@dyna-nic.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Tue,  5 May 2026 20:39:08 +0200
Message-ID: <20260505183917.370281-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260505183917.370281-1-sismis@dyna-nic.com>
References: <20260505183917.370281-1-sismis@dyna-nic.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

