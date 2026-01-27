Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65768D2FED7
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 18:47:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D0B542708;
	Tue, 27 Jan 2026 19:47:45 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id C875B40F1A
 for <dev@dpdk.org>; Tue, 27 Jan 2026 19:47:43 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso61713635e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1769539663; x=1770144463; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=TakXzT1MbKxcgp848KRxeoN6dgzbz1kER4pxlZpssefnWIwzHcbODygS5kuoAf1987
 BdVaFBRn5T8C/OmwmgeiMaqfzXfcw+3ZrYX09ESjRycXs6drmvmP7kmO1nqSrL7UB600
 LqAbR4lshdRntUKRJHCt6EpE4uZL2lMSmpmm2h3aLQm2ekWbrNyf9BmgEOWKoT3lPaO7
 pNWSwhjmnQJ71d3bqNv3QV2nmJSVK06BFbIAZ/NjYQRw26mM6FqaEn31DpeIPaMRj4wq
 yyZeQpYOjbKczGmPF8mn00qhHrif/JNZyquJWxNFeAo+Kl21vCParHF04F211ANM2UGe
 dANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539663; x=1770144463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ze9ageluBUa5LL0gOdxGYjPxZevTRcErGk/hvG4DLbw=;
 b=BELmOgc/LZeY6OJJPJwcJfuhj4bHSEtvy1qU10QSdliJK7fNyHDC0rx2NLFoJOa6/2
 EC+J5j5D4YKa0ev4V1DTlfAJMZkvvj1hc1aJf0cF+YKADlegpo8TwaPPnmkBVenjMjev
 mBMHNW3rVmBajEVTspcL0k3PXlDMsnSyNuiwWw3d3zNrqmKKm7bAhwNXTkfEb19gYWJp
 lUkgLkeboLjPKBv/+yr9sNnWjhifws35FdPxdmfyq+J+PlgAw6nzj/TyZAhNq8dEh8MA
 0zxMkwgEd6zZscLW2+7pTHdxPT1gPFBBD1o8DZzAhH1v3QIgBJqM6Wje+Fjw2lBoI1lJ
 ji0A==
X-Gm-Message-State: AOJu0YwfwTH4XKvRGQ69wRq0LaMX4O96qzy7JY9ppdwTXIfW20Mk1Ep5
 PUZrZWHLdpw4bSs4cz6e2WYbPRazi4Kd5XbbZFbjLfh5lUo01DyCm6mpPTwG3BOsIHH+pd7ChZM
 RpcWI
X-Gm-Gg: AZuq6aKKl6TZW9lPJry3kwjKsc5uCmQJbtdHQMz+NNBdodCMGnG03YSM+Cv6+uHXWBW
 S1GXIAbna/FurGGFWTCs8/ZZjfyk77LT/jkQKa8ccSK5QLVxfUkMlfcZJ+GW766aoc7BZ0uRsIn
 /UoV+8orlj68FpDacOOjcGMo9Frv1EYvPqLHwCKb8L9yZSFiiwEPjfJENUD36DeersN9xU/dt1e
 WpjklS4o9km2HC8eDL/a8HsMQS8/tkY9gkAMeAl5GBbrUvmvr2xBxFOpCrZ2fi1uf3cAEDDjluX
 sW3e78R5rSXPUJ1gc51mOObjx/WMV2aPtZml5YZri3aJt45ISYlawYVDRcrcjJ8ZSg26oGiCrOi
 wU0TaEAd69IceVMsboDZkynT4FVTXxX/27Dm1k14MgZwHAVBd7BUrAf0LO9MnoDtG8U2JSchXL8
 UkY2xboU1AxdntaVE+74gpSDXfc3asjebYrEKmYvwM1PGRrguwEePtzw0q
X-Received: by 2002:a5d:5f43:0:b0:42f:bb4a:9989 with SMTP id
 ffacd0b85a97d-435dd05f9c0mr4273315f8f.28.1769539663167; 
 Tue, 27 Jan 2026 10:47:43 -0800 (PST)
Received: from claret.liberouter.org (rt-tmc-kou.liberouter.org.
 [195.113.172.126]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce70sm716958f8f.27.2026.01.27.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:47:42 -0800 (PST)
From: Lukas Sismis <sismis@dyna-nic.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org,
	Lukas Sismis <sismis@dyna-nic.com>
Subject: [PATCH v5 1/6] cmdline: include stddef.h for offsetof
Date: Tue, 27 Jan 2026 19:47:32 +0100
Message-ID: <20260127184738.200476-2-sismis@dyna-nic.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260127184738.200476-1-sismis@dyna-nic.com>
References: <20260127184738.200476-1-sismis@dyna-nic.com>
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
fallback offsetof macro definition. This prevents macro
redefinition warnings when building with MSVC which uses /WX
(warnings as errors).

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

