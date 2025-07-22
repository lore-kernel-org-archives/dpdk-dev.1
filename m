Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA59C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C21A94066F;
	Tue, 22 Jul 2025 19:36:02 +0200 (CEST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id DC3284003C
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:35:59 +0200 (CEST)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-7e050bd078cso530373785a.3
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205759;
 x=1753810559; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=p5wnkEQmHU8nBGFfUrbe8nTLfO07glRi6gudha8LMy4KEtWsVt3x3/kcMbHvq49KNb
 vx8QwYpZgWEBXC5+uuGR8+zXJJLq1TpHM6cV0/XgfJvJk6ZND8Ab0PrtodZ/rVfQi5qO
 paLaXZhDzF3ttQwXTTUl5qnvI7JMc51Ks4JK4xTYMwCMWGjNRHjTFuhwKJJmxsQ+dHcJ
 zrzh11O/ONJR684rK6ZFVi7YZ295DdUgZ/ghHn8s5Stx+3SCzuVWffn8BbLXSsVF9HXj
 LxLrLHoGZNEwh0X9AaJdxu/KRJM4j3eJ/ASuUSkDcaTJHROjCP4GKjjSf5toaECKY2Wz
 j3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205759; x=1753810559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nd5IbD1gfu3uxsi19HXLY82ZUVsISET2Jssfh5uVVjo=;
 b=esFIIZ7//L5sguiZIqa2jyhyk72q7JluL/mqX73owAT/cOVuHr43qkn+Jrn1BvC6lz
 UuLy+Rz2XQRZj45dTGJEdaNrNc7BHGUOw3SKAjw9Z8qu3QzfaMXazyJrLB8tangcDQjU
 6nahRwUO9S1cAVIE/co9l4/jW9qKjmrjdr+uAYr9H0a0ooqKB6zchFkfYviD6oJDf9NY
 ojRHGDjB3HfWRqO2L4ngjV67kwuDNEEDW05v6HZWGTSQO/NBOPTJ0PUNL3YeifL2ODBJ
 Rw6l61VG60Vr4IwDhB5ZkEnJa1HNfwRjDB4JBKRzkOkm3e2OnIJ54CMBZBAng7pc/rBH
 RmdA==
X-Gm-Message-State: AOJu0YwmYFOx9MNFLU9Pd1BjFD5aPKYgtFWEBLN9z/OLoAX5wIp/xyaF
 4mudwLROdc3dBkgv1FGwgVwT/FvkGFOb30xcDkeDXCHYmaPIy7isOeKRvtinNjeciVNb9f3Iwj/
 df9ta
X-Gm-Gg: ASbGnctPH+FkZ8T1CmZHdsTtPIIBLonlxxmyuej9bVOlef5s/ZZEWeXs81VkPE1bx98
 eCsiQUOR1HEaKN41LJevbq+8VerVbbQ7zKE5RjqwGe5eFwr30gkNqaP06qIqiJb1QDhX1wHwJ6z
 kF8GmTi5r9BrocE/4/aCPpG1luWseYeOiLVXai9A8ehPXqGTp/EN/Y960aOSDglFy/ZA6NV2Qnf
 kys+j2IgOOXqUFexVjkx9B7qgahHM0sLkFxGcWmNQTcCze4Wu1e5FoVbYElcC5KArxpLmuoR9f2
 g9ti0IThkb+Cxmi2xgmz7tPKd0kC6/2frUEqAKLlGaZu9vem+NCqLFGD+A20ny4KhIFXfxYpQXS
 LTdHuYnQYQAJTwNvpd8n3qRRtQDgXvTIc0iCRJvjQaDpP1GcMXuj2brgv7x9yl47eINLjb+Fv
X-Google-Smtp-Source: AGHT+IH+7VByqyEtmHKlchbgDHda+WS6qxB8Ke3XnkD5KWZumkcSSCVcSfXH1kwf8YXsEHj4fv5aIQ==
X-Received: by 2002:a05:620a:7182:b0:7e3:6c1a:653b with SMTP id
 af79cd13be357-7e62a0c7036mr21341485a.10.1753205759144; 
 Tue, 22 Jul 2025 10:35:59 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:35:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v6 02/13] ethdev: make sure all necessary headers included
Date: Tue, 22 Jul 2025 10:34:33 -0700
Message-ID: <20250722173552.184141-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722173552.184141-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
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
index 184cf33f99..fffffe2625 100644
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

