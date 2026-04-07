Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E246FB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BB1F40698;
	Tue,  7 Apr 2026 05:52:34 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id 2085E40687
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:29 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-1273349c56bso5687627c88.0
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533948;
 x=1776138748; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nFfZL8vGx9ZVd4z8iyNlSTxal5c9tWmwJUPNjO/IOqQ=;
 b=TgiOPyc7vyWZB2KO1Ow9UM/L7adEQ7MIM9vYjk+YeMNBS1YRv0P/mbKCiBBenx4uxH
 TtwTwSoTl9/hupgI19hWcnl7PkB5N+6eVRK7DPGqfT/7Cn5DxFIP6WGCMsZeqMA5z3O+
 V/Ob+PJeYMHlZIAdVE3Y9Lg2KE1SGVoV/JGeYWQU1nO53d35zKCJzhN8xBn49vXY86T6
 /YOyvKx9PxAlvTI+DoHMDfRF06Hlcmb2wm65B72b14LjvyEmw6nIa+gVpAj0IhMgGwRN
 5i6U3qhQqN0+GJcofdYUJLo0cyqJyOkjZ4EbdCyo1EkTYoWgKK3ySw8cQBdS50gKpvIA
 J+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533948; x=1776138748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nFfZL8vGx9ZVd4z8iyNlSTxal5c9tWmwJUPNjO/IOqQ=;
 b=URZP01YxOk4Eon6CirulTDiAUREWviLd9v2lZXZvOJ16nFBP/FMbrl52+sLPdqalJ9
 rjZ8LQir9dJWFBqSzeaQVDdD6mqtvtOlNpuWHocKIojjCFTq8Iyo/yYWMFVu+MDT0dFQ
 CzAN0ejdAN146Ocui3/pmasSgH4lx3NtGikFqehS5c8KOGLl9W+PyVIRl/CVxo/Ae8nm
 LZBoK7c5jamjZOJuptk/xun/XkR9vWZnVWHa2DDzU4lc25ufoy4DhbzvMEkaGtRWQSgt
 a2blz1DsWnvwdl+2br/ssd43HQKnTCMBQ0JM1pD6YGBTWhGzRArFTiHmct/+Br9P//Pq
 VkfQ==
X-Gm-Message-State: AOJu0Yw4qXwyuqBALcmcFLoBjiEHvawmzLwmNSoQ9bPiR5rtG8Y301Vh
 af/TwtxFrtK6LfYhM1YGGXBtv/6IoemKhKCOnirlSuNPZbztqkdW7lJowGQefx/PCoamhqzGnRP
 EZ8qu
X-Gm-Gg: AeBDiesSx2eKMeaDCATeFW5VcQs1C3+jBNQuF0yzGnS7GzN9RNg/SDLrVeTgss19mr2
 KkkP+Ygy6wTwGYp7jOlbPr2/Lf0TkpUH3ZRhEM4wPZJl5m49G8FMkXbBgRfpEotlPCAwUPCz00Q
 zZroVg5nmkWilnh/PHayiJyESeIxK0FfyFC2nDcuSXP4IMFvHvtb3TMyLah6sRzH4Fhkpllh1Un
 74adbSYHW+5ZsIlMNgOHGKvtfID6ugC8gskuhAjOHcuf3b59ipKtl2tzoiuZhjrni2gCXG4Qv5w
 oqHw2Y+7sPWH4JrUeTbtuejwwXRVcCHUCNu5fsvdkSOODRstTtmIFxAE2uOIIbwUKbAYfpt+csF
 OkOu3RB/VPyy01lqpSJloZE3keFrrUKr1URkW65WLMJrPIWPDPDvXhe4xVLm4yEtm2577ttLLg7
 Vsg7oKDd3QTrkVi3b7qprwEtx7LQkiI0/6
X-Received: by 2002:a05:7022:fd05:b0:128:d51a:5157 with SMTP id
 a92af1059eb24-12bfb7790a4mr7759738c88.33.1775533948156; 
 Mon, 06 Apr 2026 20:52:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 17/23] examples/l2fwd-jobstats: fix shadowed variable
Date: Mon,  6 Apr 2026 20:49:43 -0700
Message-ID: <20260407035209.650419-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407035209.650419-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
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

The inner loop across ports was shadowing other definition
of variable i.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-jobstats/main.c      | 6 +++---
 examples/l2fwd-jobstats/meson.build | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/examples/l2fwd-jobstats/main.c b/examples/l2fwd-jobstats/main.c
index 036bd4f951..f2c284cebb 100644
--- a/examples/l2fwd-jobstats/main.c
+++ b/examples/l2fwd-jobstats/main.c
@@ -515,7 +515,6 @@ l2fwd_main_loop(void)
 			uint64_t repeats = 0;
 
 			do {
-				uint8_t i;
 				uint64_t now = rte_get_timer_cycles();
 
 				repeats++;
@@ -526,8 +525,9 @@ l2fwd_main_loop(void)
 					rte_memory_order_relaxed);
 				need_manage |= stats_read_pending;
 
-				for (i = 0; i < qconf->n_rx_port && !need_manage; i++)
-					need_manage = qconf->rx_timers[i].expire < now;
+				for (uint16_t port_id = 0;
+				     port_id < qconf->n_rx_port && !need_manage; port_id++)
+					need_manage = qconf->rx_timers[port_id].expire < now;
 
 			} while (!need_manage);
 
diff --git a/examples/l2fwd-jobstats/meson.build b/examples/l2fwd-jobstats/meson.build
index 51da6e277e..d59d3d6555 100644
--- a/examples/l2fwd-jobstats/meson.build
+++ b/examples/l2fwd-jobstats/meson.build
@@ -12,4 +12,3 @@ sources = files(
         'main.c',
 )
 cflags += no_wvla_cflag
-cflags += no_shadow_cflag
-- 
2.53.0

