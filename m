Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09BDFF5105
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:19:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 656F64060A;
	Tue,  7 Apr 2026 17:18:47 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5A95A4067D
 for <dev@dpdk.org>; Tue,  7 Apr 2026 17:18:46 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1830122a12.3
 for <dev@dpdk.org>; Tue, 07 Apr 2026 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775575125;
 x=1776179925; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab5x31bjvXsjTp3Ct0O4VBqTWx2UEEGFD3pTLuzvjc4=;
 b=ULT+eax4HfCU734VS/ttGr3dhidBiKj9Nyby39oCaaF1n5FbfewptYonwBdNn/TU2t
 iASc6YbjdNn7phdqOVPN8fRlyv+nxYfCTw8sHL69uTnnp2WjsN924/IE6XQlB9Zayrww
 elxIT9uqU8vHGrLfwyn2dKoYTZcybsgnJc8bz78EC/feHwSxB/xOdPT3iEBpSOu/bxQj
 4vW7tTsVR+MX9MxV8TMtsFKZVpIIZDcjD32dsnJhW8lGwVc3Kutg0WZz1Mrx08wcfRdR
 Nwz8j+1JNh0kgf8bp7ybMFuoHV1bOTrCX/yNsLFXDmMzL7w9Gwkl8qV3oAiHH8mDzVV5
 Y6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775575125; x=1776179925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ab5x31bjvXsjTp3Ct0O4VBqTWx2UEEGFD3pTLuzvjc4=;
 b=bH4nzfbJKKaie70fRlVr+WoxNkDrHvE865W7Q3sysfrLu1T9foKb3PtnsWaKIWPDA/
 37/l9s3OwOJQy1B74cE2atSTREyB6Z+7bjxVvzVqpij9GTN1B0drR2nHyKs7jS8jnefx
 HiSMAQ6OK36OY9iNAs/hiI5+35mgySeggyaIZdXN+qbvo+pfR+3T1ItOX8Lj0WlzgJar
 aN4l87/H4VaL2BMM27Ban8GmTI5xe+tTx6jt1zp32IevXc8arD1p6jqrV5Y0YaY3VlIs
 7PW3RY2V3LiN5zQoXdyq2zo80/WSzZdTruVKYO6YPQmgSwYU4oWzbKOfFOUJQb/Lyk8C
 9VsQ==
X-Gm-Message-State: AOJu0YwLtCbYI+xaZ+UxTuNgNBeh25RNqVnad5DEhKMjFLoBL13ZWl9S
 m7fhzNUDX6Qsm2mtwt6UZJjrKrwuJjD+tlVE7NTSmBcw0CTS8vepg2PWmjciOgCj+joNPDre68s
 fx9/g
X-Gm-Gg: AeBDiesq8ED/iDsijxnmc3TCmAEb98fAw41tunzAfOXRVhyIJOIpVBb47VuJg/wFk89
 YIH7pvKJZC03B1Y8RYByYS3Xnh2H6ARZMbi8CfR43wniJykfPnxvii3DeSusgh1V2AwyrU0lkhp
 D9EuqHu8jUKhapwl+QGF2RJS7OEjZI+kgrz9zMbsydfbbLTlcAueNGTnBxpv9h2/sHCOD5w7xDv
 2trIt0OnKtljZ8JB6SqjJj7ue+zyVyQscEm3MJHmvzl5lvSeQEN9Uvu981EB4HZ499TPE6swmtw
 I63DRizZlhAIFaTX+ZlFgZTYYkObRhVFNlAyK/fd3Xcac5AMQTXCa61b5v++9PE6UAVnXwpbGhG
 mr3U0IuAe9mT4TuVcE4sX3hHyEuxleZtEAEB7icIkcN2FvUgOLztzAvjQfUSpgDZe2tcgRJHlmf
 +94I4sALxUIciXcqvZ2CJ7U7LndPyTh8ba
X-Received: by 2002:a05:6a20:2450:b0:39b:8905:4e13 with SMTP id
 adf61e73a8af0-39f2ef75d49mr17571729637.6.1775575125475; 
 Tue, 07 Apr 2026 08:18:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6477bbcsm15842933a12.3.2026.04.07.08.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:18:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Sunil Kumar Kori <skori@marvell.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v2 19/23] examples/l2fwd-event: resolve shadowed variable
Date: Tue,  7 Apr 2026 08:16:15 -0700
Message-ID: <20260407151732.272195-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407151732.272195-1-stephen@networkplumber.org>
References: <20260407035209.650419-1-stephen@networkplumber.org>
 <20260407151732.272195-1-stephen@networkplumber.org>
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

Replace shadowed global optarg with parameter named arg.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 examples/l2fwd-event/main.c      | 15 +++++++--------
 examples/l2fwd-event/meson.build |  1 -
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/examples/l2fwd-event/main.c b/examples/l2fwd-event/main.c
index 7600b9e9cf..2d31d4c6ad 100644
--- a/examples/l2fwd-event/main.c
+++ b/examples/l2fwd-event/main.c
@@ -82,24 +82,23 @@ l2fwd_event_parse_timer_period(const char *q_arg)
 }
 
 static void
-l2fwd_event_parse_mode(const char *optarg,
-		       struct l2fwd_resources *rsrc)
+l2fwd_event_parse_mode(const char *arg, struct l2fwd_resources *rsrc)
 {
-	if (!strncmp(optarg, "poll", 4))
+	if (!strncmp(arg, "poll", 4))
 		rsrc->event_mode = false;
-	else if (!strncmp(optarg, "eventdev", 8))
+	else if (!strncmp(arg, "eventdev", 8))
 		rsrc->event_mode = true;
 }
 
 static void
-l2fwd_event_parse_eventq_sched(const char *optarg,
+l2fwd_event_parse_eventq_sched(const char *arg,
 			       struct l2fwd_resources *rsrc)
 {
-	if (!strncmp(optarg, "ordered", 7))
+	if (!strncmp(arg, "ordered", 7))
 		rsrc->sched_type = RTE_SCHED_TYPE_ORDERED;
-	else if (!strncmp(optarg, "atomic", 6))
+	else if (!strncmp(arg, "atomic", 6))
 		rsrc->sched_type = RTE_SCHED_TYPE_ATOMIC;
-	else if (!strncmp(optarg, "parallel", 8))
+	else if (!strncmp(arg, "parallel", 8))
 		rsrc->sched_type = RTE_SCHED_TYPE_PARALLEL;
 }
 
diff --git a/examples/l2fwd-event/meson.build b/examples/l2fwd-event/meson.build
index ff171189ba..5bc8188086 100644
--- a/examples/l2fwd-event/meson.build
+++ b/examples/l2fwd-event/meson.build
@@ -17,4 +17,3 @@ sources = files(
         'l2fwd_event_internal_port.c',
         'l2fwd_poll.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

