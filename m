Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5673CFB5190
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 03:54:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E84CB40A71;
	Tue,  7 Apr 2026 05:52:36 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 108EB406B4
 for <dev@dpdk.org>; Tue,  7 Apr 2026 05:52:32 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so4784259c88.1
 for <dev@dpdk.org>; Mon, 06 Apr 2026 20:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775533951;
 x=1776138751; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENJNvScxwch/qToD0MRboz+gTRis0V9IOxYM7Q97FpI=;
 b=w61qP+7TEtLD8mPa6nZUbW1Qgf79SXyT/dz/74jg3VEKlV7TAC0D6XZmg6dDkzU4JY
 xwfWP/13NBnxMCbkffzHhQ4IdFHv5AMCKNdEqjF17fLr7GKNVUfWUIS6OSPbGJBOFbOL
 dmj8Qn1yiGe0vuEAt+4PAeIZz+D/pm15RZCMmrmViuOrjhKMAysOSxek8Ko6c3wfj9Lk
 ybyHtMT+Ij5dr7jxx0zoHHAfTIGJ/hq2+IFSW06r6jvup/4unIRZsSmKKlDus88rlo9R
 9MLQfmtX4y1smaxeg29ZSGDQAsh3tW5tFkdZqGArTr8j8UDNf9kGGgbCthZuWqXH+yOg
 q2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775533951; x=1776138751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ENJNvScxwch/qToD0MRboz+gTRis0V9IOxYM7Q97FpI=;
 b=oMVNjiPEUioahNF/yWhCPLlDEreDDVrugfBoTFCwSftvsqtIR7p43Qu6pctGAPcdAl
 qXCvc8+/gABvy3AjU5qIfi01+5Q7JdwM8WzUVSX5zkc+l/FO8DhOH+1Vio+Y9aJM7+6G
 8RD9deRtNcl4R15SCiiEQHZUHQhYfN3njvk5rqejzpEPvzR/YTbM6i8mA3WJRMlxVkvL
 uJo1dFc7YdbRNHkpJqTirQO0TYprfLJwSzetCc4BxTibsf7xbD7pUJEtqhqZPmzKTZFX
 h31G4xqrof8+8EWN28mhccfbObcTM+B0sJ9usUQHCHV3EnrfxmRgEibsctY7DyMWodj/
 SmOA==
X-Gm-Message-State: AOJu0YytOlQ9X2JS3QzkRVj8xhNSeow22fqS66pBnSTkQi+fbqVTAQ/u
 1HEZ09nA29EV63F2qBMLxyGBrY0qsIlizUITQSjS6nJePDjH8vhulqKT2lhbr1NVKuh9i54gPWK
 faumJ
X-Gm-Gg: AeBDieuX+EgZwTfRIjpD1ZF+mLYH9aUPi8Pw6Q/1rI00xKyIFAzItaT5hWz9G7KGH33
 cZCSPq44e+yCVI228CceY1vJjIBBpfPCE/cUaNLKkHmUdNS6qmrCHLCo21Dc9W7suATdX2HJ9Uf
 gsNcZlhxF1WWYsF/lUpMV2xAf418ab/XjRTGUSGsa6GM784ZLDZniQpSSlDz7yR9NBc5syX3p1U
 VhwkDjqhJ5Kon72Y/MrKl48l1Q0H3ypXSjxZVqsHEFHswWVUH+mIHDs0m6ZXCbdJYREGryfMQKH
 m8rwgIi15pNf0IiHnY1PaT9xhxlpd1qXQl+iWnyFRod5niO+xd19erxyYH4W8Z0jrhmEnydl1cZ
 2QLXm/ZEaDwhQgfiWlFTiVQnq69IhYvBf394dKgACIh0wVwwvEidQHsneoKs1hvZA19hUDiEaZh
 czMfrQ6/PVmm34N/WY1LIZWstIoh49F3oQ
X-Received: by 2002:a05:7022:6097:b0:12b:f8d6:d4bc with SMTP id
 a92af1059eb24-12bfb76773bmr7106032c88.34.1775533951022; 
 Mon, 06 Apr 2026 20:52:31 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12bede545e8sm12716093c88.11.2026.04.06.20.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 20:52:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 20/23] examples/l2fwd-keepalive: fix shadow variable warning
Date: Mon,  6 Apr 2026 20:49:46 -0700
Message-ID: <20260407035209.650419-21-stephen@networkplumber.org>
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

The qconf parameter can reused, fixing a shadow warning.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 examples/l2fwd-keepalive/main.c      | 2 +-
 examples/l2fwd-keepalive/meson.build | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/examples/l2fwd-keepalive/main.c b/examples/l2fwd-keepalive/main.c
index 993e0bf9da..12ca60c3e4 100644
--- a/examples/l2fwd-keepalive/main.c
+++ b/examples/l2fwd-keepalive/main.c
@@ -780,7 +780,7 @@ main(int argc, char **argv)
 	}
 	/* launch per-lcore init on every worker lcore */
 	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		struct lcore_queue_conf *qconf = &lcore_queue_conf[lcore_id];
+		qconf = &lcore_queue_conf[lcore_id];
 
 		if (qconf->n_rx_port == 0)
 			RTE_LOG(INFO, L2FWD,
diff --git a/examples/l2fwd-keepalive/meson.build b/examples/l2fwd-keepalive/meson.build
index 258f3baf08..e3f72aedb8 100644
--- a/examples/l2fwd-keepalive/meson.build
+++ b/examples/l2fwd-keepalive/meson.build
@@ -19,4 +19,3 @@ sources = files(
         'main.c',
         'shm.c',
 )
-cflags += no_shadow_cflag
-- 
2.53.0

