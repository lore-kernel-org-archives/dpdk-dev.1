Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FBCC87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 21:42:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 522DA402D1;
	Wed,  6 Aug 2025 23:42:21 +0200 (CEST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id 50419402D0
 for <dev@dpdk.org>; Wed,  6 Aug 2025 23:42:20 +0200 (CEST)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3b792b0b829so205957f8f.3
 for <dev@dpdk.org>; Wed, 06 Aug 2025 14:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754516540;
 x=1755121340; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=AmBElssW7p46FANNlyDf1z0fD6Rm0zrEzAaUxdH3kDmnzQrMHJLQH6rW8XIXK+wwoe
 akwK6i1EG9CPFimpF+tkSEvhu8nS/iCAUTnhzSnCKnW+zWnpIdSLJjspsKPRJyDQWnDo
 aogAWT+eX58DixgYPLuq1JMUtRMEYe5vVSrQK0fEXSMULK/cGePr2SagbD41s/tmQP3s
 QdZNvOq19/u5pd4lPATBtkQb8Vm9T4j9Do7iA/cfNfZA6ZU0nJeWYui3hGTiYhgAORDa
 6Un05mEXiE/yHJuwx9EfAnMte9YjBQYj0ILWbRGsZ8QVWECmuztbjojNv/E2Lo4ssjlG
 eEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754516540; x=1755121340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=freQ1vV/Ap7o3wDX7a4OB1FQwnxqJ85pQqEFE98S/0MxeJGfG7evIoFeTHd/2aBMyX
 /3lYOLGvz6uvLvhVR2jjCwcrpTlfqE0epjb4/McnF7TrliaBxj+c0ISlbkgbBvrJUJUL
 e6UW0Oq6RCcuB2OMpyHO4M7cF40rm/citqPCVSUMsydBzHq/og1MW1PBblCqNgB8nfYS
 BrabZoozLRg21FZ7eXYB+dw95CH7Cgttr7Iv/Tsf0D8Ikvmdr4tAiZPtpgpGgdRQQhn1
 rmF9ZLnvZHGr/ax7SdQtYP3/9nv5e7/3e4ykgZF2qomT/Wg3H4xKlePMOYOBJi5LXY27
 VbSw==
X-Gm-Message-State: AOJu0YytNUqzws36d5C1nrvFmqF/UKu+K+V4ZeNgvXL3DTZkqXjlg8no
 WX2bevScwvfGuXyX6lyJuo+bcLf60sDpfMMEYsi8JmYrQoCFMUELQWKIXmgmUzzXiJYGGfwA+Ti
 ppWle
X-Gm-Gg: ASbGncsubeLtFX8e7mj0yQ4RH0G39ZHjpsUot4+PiufqIQcvhfFiG+w/zkroohN3/YF
 fABxyIkb8+iK1xwCmVwJsCG9i1KIgqX/0Ufi4mMWK5/eJWNieyQGgb5PPIrORz9PmNaZgnGdcXn
 IZkke830c4scOHE1ViOmv5Tg6t0Wsz2I/8Zwa3hgnVtK7e9DrFxL5uVbQOhFLO4xXd9p2Z4bAqY
 w2YQcRHw8axZFWxlUb2CuG8dZAm2gv3yNQCBIRCRwmo9CItgSxpqFqMKaStal3NW+TWAIbX9pCn
 H144cBCrlnmR3/pl/RaFsi7a+JXjBCuPU2qZ30/a1s3yEq6Ul37JcyTDQdB9KbbhaQwOx1msnTe
 yug+SifYt4qnenVMO3TJ0XvmS7cne7eZ78XGRvMt1cZ3gjS4BAovrfWD+BGCkqc7pvK7j4Gt/BP
 cgNm+jiQc=
X-Google-Smtp-Source: AGHT+IHv/ablZY9sa7GFNYScqkPghtLv0wvayn4Jb7HS5snvQu5UJOkPIAU8+DGz1/b709tuV3nCAg==
X-Received: by 2002:a05:6000:1a86:b0:3a6:f2d7:e22b with SMTP id
 ffacd0b85a97d-3b8f48de41dmr3001162f8f.18.1754516539461; 
 Wed, 06 Aug 2025 14:42:19 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm24436913f8f.21.2025.08.06.14.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 14:42:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v9 02/13] ethdev: make sure all necessary headers included
Date: Wed,  6 Aug 2025 14:40:31 -0700
Message-ID: <20250806214200.193029-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250806214200.193029-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250806214200.193029-1-stephen@networkplumber.org>
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

Best not to depend on other EAL headers to include stuff.
Some of the later changes had build failures on some platforms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/ethdev/ethdev_private.c b/lib/ethdev/ethdev_private.c
index 1d423290f1..000b8372d8 100644
--- a/lib/ethdev/ethdev_private.c
+++ b/lib/ethdev/ethdev_private.c
@@ -3,9 +3,18 @@
  */
 
 #include <assert.h>
+#include <errno.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
 
 #include <eal_export.h>
 #include <rte_debug.h>
+#include <rte_eal.h>
+#include <rte_lcore.h>
+#include <rte_stdatomic.h>
 
 #include "rte_ethdev.h"
 #include "rte_ethdev_trace_fp.h"
-- 
2.47.2

