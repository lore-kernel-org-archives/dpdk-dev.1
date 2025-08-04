Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E81C87FCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 16:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2185540A6D;
	Mon,  4 Aug 2025 18:30:55 +0200 (CEST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 649D4406BA
 for <dev@dpdk.org>; Mon,  4 Aug 2025 18:30:52 +0200 (CEST)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-459ddb41539so4404665e9.2
 for <dev@dpdk.org>; Mon, 04 Aug 2025 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1754325052;
 x=1754929852; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=I04l3OnL2K1Gc7n57YY4pN2ARWvs84CvIChXKmF58b+fmt4VtqDAJxnN2EPCef/BBo
 2hrpbKzRrtvPxc25Q2+rQlCORBtILOz0fAX0MccIpHAZa/PpLQhtW+sQE+sLH9P9rUxT
 gkXTgpOaaJJRE4A/L/i8rw/gTWVjBfrfWoLFWbItcFdod17RGCz6zfpJCpdgqyeAIVJc
 18YrEXz2mm655Ig0tmPW/VJQuD9lEcggloM/WytklDVpKpETrjtjDIYINO5Fvby/cvRa
 4AJqLz/ty5y8RP+OwzvSpaEumr84ECYcKz12nF4Rxyg8dQ0+8GmsvXgBlNGxrI2Y3j+D
 LHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325052; x=1754929852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=UXhgpx/9Y85/p1O05BSmPs1NCvJ5U6U9Ca9JDk9J5yUqvufsql9nyv0DjvXCkx/NFT
 +BCOJGX2+0YZFigGhDv8YOJ7d4ciYEJvZ/+AlIbL4NYVX1yK4djsGy4Fr4BwvaOYQwkZ
 PHQ91QAIT2FmEjJnCaymLNipizgz0bexG9SIE9oXN/7gA7Z/1w3Trd9yyzmqP6a8BCkr
 /NlC9oufyS5HD4VOet7un1rtaL/5jgROTUipH0ncYavFZAm5jbkvJIPbAJ2ZERjwZHtK
 1bMyvBuktzVyrbgUkIOlvhAQ0IhHSl/9X66S5tUl2K0hUdle6ppx2o+lsCS/pu52uBhW
 oO2A==
X-Gm-Message-State: AOJu0YyogGokyu8Czabk0OUX78hC9YlzR/tocvHUFJCKGP+ftZMGoCGl
 szDr6KSW6mW6hwUWzmR9GYCVg/neV8/RK/CmtZruINd51ldBwpUoR8yOfzM1ERT5f587nqvo687
 8Jv4i
X-Gm-Gg: ASbGncvLUav7WhuEO4M7NH6ZFGEWZBATTeV1AARL1KuPqsPwRFk/tTm/OkG2cAWUSka
 AD9ET1ZQbvIL5pY5zFyf/Ldhzb7q2uF0KSi+sHHfsvIFEh14+Y5KKo1bd2IEUgoqEYOW7mjB0i7
 Rfw1rJ7b6ZUacyalajLzfQId0y9iyvmJq5FvscwEi4glXxTNCOGM58sF1AGnwJJYsrwAJmrXpnJ
 MTYF1FLJQK1DUt1OYFKT6H2IpwixTvJvyoRo4Y7rGFeatudj8zAuO8eWKCaAzgkGhs492U6c4s6
 FNpNHpTlfscK8DVRiyBi4EnRyZiyEJS+Qk0MWrzWnVqcbBRjWdB7yGWM7pcF6YBzXMJfot87t7m
 y7gdvH0dsOwJh8TwsWE5Z/jVTuAws87nUaPDYzxfjGkUqXSoocuph2tF6EkoYJkFnEJpo9lOK
X-Google-Smtp-Source: AGHT+IGBpkP2AUGaup2IJAJJ+y+a7XQbYjf3KAmF0LL7oxQGp2XD7GDngb8GBY+FC14dij9Gge7m0A==
X-Received: by 2002:a05:600c:8b41:b0:458:affe:a5c1 with SMTP id
 5b1f17b1804b1-458b69cbe0cmr83542295e9.5.1754325052042; 
 Mon, 04 Aug 2025 09:30:52 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b5fc556bsm105891405e9.31.2025.08.04.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:30:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v8 03/13] ethdev: make sure all necessary headers included
Date: Mon,  4 Aug 2025 09:27:34 -0700
Message-ID: <20250804163039.138959-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804163039.138959-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250804163039.138959-1-stephen@networkplumber.org>
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

