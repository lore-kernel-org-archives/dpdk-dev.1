Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9EAC83F26
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Jul 2025 22:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1178340A75;
	Tue, 29 Jul 2025 00:10:05 +0200 (CEST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTP id 0ACF640A67
 for <dev@dpdk.org>; Tue, 29 Jul 2025 00:10:03 +0200 (CEST)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-7e62a1cbf82so308001685a.2
 for <dev@dpdk.org>; Mon, 28 Jul 2025 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753740602;
 x=1754345402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=DaVQspYp5+WTWIzuTrI/UW8uQBfglO+y6zOcV6yE6CidHmXPZg5VzDmAKncCyIBxwN
 sUCMb5dsPXQC82nlX4yrqCvyhIMkC8TAbusqnMNUGfUiysRBkJ+2ebk1l4uTWO4PMriT
 cJCVPuymgjRE3ta9szAA/27qhfEhkK4kquFk6X1IeJuKuLwdrPkGQ9Qy3EfGOeKl1IgD
 VA3EHqzytdEspRM1QcXsTNqaLcIQR6r+0ZpqcISTsRakUNeCW08JGOAGAb2FzK5eip7M
 3onNJMlcJmrYd+zDpl3Lx+iIRRvy8AL9qBV2Rd4HMqdVselZqxJjq7Flrug4lichl5a9
 6Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753740602; x=1754345402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/IPN8hRQcknxMpQpJM0w+uTrNAI03DONoHxk+zWX6Q=;
 b=D9yshJDcTuw/23jyAMERBze2uD4xHKRR2JQW9tAdSkSpTNlR96mTNyprQ/sK3lA3xP
 OFo2PHO4Jzb7t+wEltP+l8LuXWc31Yg/cy2yuFUVKCjBO3spKaM3BiQvYwjYhSc75sXy
 iCvgSOcpojtlgjlP8zv7CyUgYUvXwcCTISsnko4OGKuL6J9VLUwfkyORXLYrpGVXO0ub
 9i/dKzGWRxscMcRYMLoxgIm+aMkRatS4aobHT/qmpsAgpDTC47kOhN4EVfK0zTC9qoyC
 4qE1rLhR2CWrY9kKDv7f+96ikrEb3NiiC9tcUVZxglVX2S5BUVsXUznh9DLyNF5TrZu/
 NHhw==
X-Gm-Message-State: AOJu0YykZPOrlZSEIBoNOss/f5n3iYt7n9mITQAODFwV9W94kO0OVvQK
 cbkSh8mQRWdSaYNITj+3FzpwpRAk5T05P2DInXEXLFcwI5C5tBb8+y4QtUQaD546y1smK/RSndl
 BBHT8
X-Gm-Gg: ASbGncv7COpyHuyq81b5gZUxcSikNyDqkiiIsqbWZemetRgRiNKN4GRX+seFyqWO8Bn
 mfn30ZVyuaUSyCNZhygv6Adg3ncIlWsibYhtOxt2pkPXK7wmZKWtDefzSZWelSuj1p+0aG8vn7r
 I8KBVT8q8zkpmiIfO0HrZ5s4pyfY5oIC1hfE1lVnJErepynXOrqtxb8M4kib6FsWF16qqdQ1fUD
 sD8WkeAvZ/r+Mgr0o+k0HALBKxkraL0io+DOD4IwbgwvIoOJ+S9e50lvnZwobcxATVOmzTQ4lnF
 E5iVUDzrTKOBqrc/WUi9dRkBgV9+GxwRxBPUyReprnyJwFrgig3+TPskW/zEjjFUJ5Ldx+C0eor
 IPrHjn71qjAm3za7V/PM/1CUjsRsxliV8nI9h+I3twGR5sGIfx4+wJ4QG9Qk6EPKxD2YWr5ge
X-Google-Smtp-Source: AGHT+IGr2636d6PxKcgukJG7ZoDKup7/EutGIixBrdWagQfSPsGiOhLnN3Jh4XBEp80yLouWSnY9Pg==
X-Received: by 2002:a05:620a:2705:b0:7e3:623b:30a8 with SMTP id
 af79cd13be357-7e63bf7a4c7mr1856047885a.26.1753740602214; 
 Mon, 28 Jul 2025 15:10:02 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e64327d41esm344024785a.15.2025.07.28.15.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 15:10:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v7 02/12] ethdev: make sure all necessary headers included
Date: Mon, 28 Jul 2025 15:08:10 -0700
Message-ID: <20250728220955.332924-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250728220955.332924-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250728220955.332924-1-stephen@networkplumber.org>
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

