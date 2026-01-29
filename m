Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBF8D6100B
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 Jan 2026 11:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F00AB402D7;
	Thu, 29 Jan 2026 12:42:09 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id E6A1F402AF
 for <dev@dpdk.org>; Thu, 29 Jan 2026 12:42:07 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48069a48629so9217275e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769686927; x=1770291727; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=E2HfJyzUgRGO+O5gRuCiTfl45DidCd1h6ZnEmgnCVRGauCX/WLnWc65OmdBRIvBwkr
 b/X+sOhwniaodhY18TGkhGUJh2AlAw/nyjKlMznw+bWBqht6iqi7FwQbaxOmWcz5Esd4
 r2TcEvNKsXzIymrv/Grni4fs+LVtfGQmmtGrvzsEQ51APkI3XF+SN5Zi91JfUeDlXEI2
 hqL2EOYxl1V9sZ41PgrCHihnfS2A0nBSZsQggWvTjkoSc+EOx0LsO6whlgIAtU2aljOf
 azVTcluUoVOlEVheodGedRg0cHaqeQrQuNckNbZ0MyAtrLwwH9rlDI3UMcqsKbvur2Ii
 fQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686927; x=1770291727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IjuaRo7mlZhpuSJ87Y5zvyYU9rG1siQVkSAiNrWoGBI=;
 b=F+09dvAreHd15vaN4K/xZdwemLQH9ajcdAChOKKajt0lWBnP8NFDgnt7JvMye8DVWE
 0d01Hx0iKLUm8/FeE2PAATrl9c1bxKKSnkMcPUqzqQ+LHqq0sYI/iRubxuQIXcycw9GT
 iiugrhdA0bjQVwHOZ2fDIl9Vx9THaDmvOnZZAI6aOsFSHXocIZ703Qe1YSlzjU/M74fm
 pNuhYoth+GI5fnP6sj/udUH8hgioav9gfHfrFQvHAEmIMGDBE2UW1ppr7on1SfsifVPG
 mqPaEbQdBElydjvdnnkSd6pvE/bxkdaEVF13HC+/6J9fiW1R6xoq+fSWzVde3BIYAokH
 M0sQ==
X-Gm-Message-State: AOJu0Yz0lmuUcqiStfZuetD/Dpy+p2poWpTb5La+IzFqEb30ZqJTPKqt
 JIxRkn54dYqxw3B1YpjW1X/4Jy8UTcyrbSfnFT1RkQYCaBt4cflen8IKPWXJe1Ue32NVbN6hgXg
 a3wuG
X-Gm-Gg: AZuq6aIKL4emSE8OA8UH4g8yCBRvOrrJDYBr/6byCsKN9RIx1N5Pniyos43X8oHy6R+
 ptwIJ+5OkOMHoADccllB3r6KOKNpYVvBxUlxvtbnx6vdslI7tYbz3pXVuqVqLQj0NRrOFJumCqE
 pRNZfkI4GFk20qBWrgJ5Rz39/yPM5KFfSv6IP9gQ4Y1h9CniIMgNOax9CHwEFD8M6qzYE4X4UtY
 YrWevYpdMHEqCLhhjsztWERmHRXcB3y5ciPD/EXiIoBftbLGSLqyrJZGwtK9Ra46tfRRHIEcuPs
 yzJN0KGFb1biA9T4+qeGFgQHuTgckbo/Yih7o2RMHzb5c6RTzTz3Mn0+OFgw1JXFTxlepJiYrS1
 KdtyocQyN9Tne+jCyFso+i6IHW1r5Jv2Dka+tFuKCa+ru+x5chFKoYzC2xMkHg9GqG3E62OJmzJ
 b3ilxxsxTvmBGL7gSyU2o6Gegn1ZExrA0erLELEAP3cnpLTA==
X-Received: by 2002:a05:600c:6094:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-48069c1dd79mr97594885e9.15.1769686927353; 
 Thu, 29 Jan 2026 03:42:07 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce4c515sm123071315e9.11.2026.01.29.03.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:42:06 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v8 1/6] cmdline: include stddef.h for MSVC compatibility
Date: Thu, 29 Jan 2026 12:41:57 +0100
Message-ID: <20260129114202.61185-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260129114202.61185-1-sismis@dyna-nic.com>
References: <20260129114202.61185-1-sismis@dyna-nic.com>
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

