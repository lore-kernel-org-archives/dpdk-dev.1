Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4C5CCFA03
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 16:50:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9C514066C;
	Mon,  3 Nov 2025 17:49:38 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 4FDC64069F
 for <dev@dpdk.org>; Mon,  3 Nov 2025 17:49:34 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-340c1c05feeso1868915a91.1
 for <dev@dpdk.org>; Mon, 03 Nov 2025 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762188573;
 x=1762793373; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR325zXejzbIU2v+DpwTD9kpPnZwoqBExuABC+Xvb+I=;
 b=3NQ2s5TAkyLMY4iDl4VVfI7iyr642rh+SgaCTEJ/Mt7n8da1c2SvGoEqYEN8Jb/HY+
 KW2QKynva/qfwWWiOjMgU4rXMqgH+2DGsly9FAg/s2+/kRR6keL8bUPOwNBBHgo3eKZa
 tSKpKx943cp7fltoeUbIg5TMYVHmJtLgtKXCqyyoNfXeatYBlxEBgI3abz+KHY8A3zhp
 ngifpn1Jp3+WGbtpfXBMCvH9fMW8Fk0cUL7kx+wmHn18yAv3ltPTUE0V3T++iFZAftG8
 2Qro1Ll9PusF8b6gmvTebIy6nk2PudDxWEei5PhSz7LQRjTUmtUIvUJ0F98Q6dYR/Xbd
 f3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762188573; x=1762793373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR325zXejzbIU2v+DpwTD9kpPnZwoqBExuABC+Xvb+I=;
 b=jb96MMajyPaf5USU7lqgQKtRFVCillnLTENU/dT5cRttlUWfNbhaFJsZ4jncH9Nv1T
 rSBdOni+tsK32DBEDbVm4Vo8iNEIdpQ/MbBkk8xqa/0j5mk/qumMknopaFbd0llD/L+M
 UOMh1ChDh4lKmvynjbq79dW+EyyHWvy3eJn7IhaQ0mN0hdnXME1RwKDI/nLeP0xbNpwz
 tyX9MQFUYKGmd8LBURPWAYk3BbCijR4otzMrCsLCrx/e0CqRybiJPY2jHzOhqUVyhBJA
 pOn0i85SrCvvT0BlEWZ5zXegUH1zW0Y3XAuxuiC11vpxKBaNiH61z1U9TmysjIDGRMUh
 nPzg==
X-Gm-Message-State: AOJu0Yy+eJaTABCASD/NlarsOje4EnC0Wlno63It8v/IOZkUv7F77HsQ
 VB/M0RPE0EacFZli3m+q2t9Nf9vQgNe5UrzNbvWU5aD+2zR8SFl4HcUeieg6WPcOLXmsr21jtWN
 gLbE/
X-Gm-Gg: ASbGncv9X63Q6TsY3L1hsXXgn95ZuJreQOMehlJ3yKvY+tBWpfYWQ2qMw9HUKGe5SP4
 0cSk9+m14ka7mRc/8NWEKHLAgWL0/hoGqUohn8AiYtIRuIa5ATM2707Io2zVJESMHIV99UjUqL2
 11TRT+jXn0nJA5aZ2XfJZXdSD7R9js6PWEwGaXz87o6SkvBVApeuR4JNu4rUvxu2X/D+AstUhu2
 i+Nt4p23j29dsd/uCv/MTvBPIF2BQYDWNU2RcE0Vv+3spzu0fjExphw0ZJfqpLFY2EYPHixU909
 1d6UnH+Oa1qU+MNnwKiyzN3GZMlx0g6rsVvgXSwOP++VLgSh7ZnRJe68tUpQ7TVGLqR/8jPQz+2
 WK7PMgFmYYSqzyhBObwSfnyTKpGBWhtf1uZt3e6T4FrWAKav5tZ8192Ge4Ta8tb+hByzdWygF4X
 gfjCV44t98e9ALYzkQ3wUZ1ijxlSlbfu5nwVkl6F6ol0RmagxgOA==
X-Google-Smtp-Source: AGHT+IEQhkfYNdxGnmg6OLeW8IEUVczqIq87XERrOJMdG5S3F6J5w0fBvKu3hJyO1+tRNMnhu8S9hA==
X-Received: by 2002:a17:90b:2cc6:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-34083088f88mr17234307a91.34.1762188573289; 
 Mon, 03 Nov 2025 08:49:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3407f26e0a6sm6779040a91.5.2025.11.03.08.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 08:49:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Subject: [PATCH v3 10/44] ethdev: replace use of sys/queue.h
Date: Mon,  3 Nov 2025 08:47:15 -0800
Message-ID: <20251103164915.101713-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103164915.101713-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20251103164915.101713-1-stephen@networkplumber.org>
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

Use rte_bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/ethdev/ethdev_private.h | 3 +--
 lib/ethdev/rte_ethdev.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/ethdev/ethdev_private.h b/lib/ethdev/ethdev_private.h
index 41a0ebe268..54b4b44052 100644
--- a/lib/ethdev/ethdev_private.h
+++ b/lib/ethdev/ethdev_private.h
@@ -5,8 +5,7 @@
 #ifndef _ETH_PRIVATE_H_
 #define _ETH_PRIVATE_H_
 
-#include <sys/queue.h>
-
+#include <rte_bsd_queue.h>
 #include <rte_eal_memconfig.h>
 #include <rte_malloc.h>
 #include <rte_os_shim.h>
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index c6fe0d5165..e624882dcb 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -9,8 +9,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/queue.h>
 
+#include <rte_bsd_queue.h>
 #include <bus_driver.h>
 #include <eal_export.h>
 #include <rte_log.h>
-- 
2.51.0

