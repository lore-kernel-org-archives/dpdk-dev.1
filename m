Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA40CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 117B540E0F;
	Tue, 19 Aug 2025 01:34:06 +0200 (CEST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id A9E7640B9A
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:04 +0200 (CEST)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so36336325e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560044;
 x=1756164844; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euIJ23UmvR2gnuBXcALjdZ9+xHSo9z7xAw8xe7tcPUc=;
 b=VPdDNNekqHr7E2J60cfC0PDIwuBXNZDzbUx3lEuhlsZzu8rCWvFUcFq6ubckbR7BPB
 g9scqDc3/BujJ6mq8OvU4ootsK2P9gTpt5xo287tIu78mqfpjYGnLLWeEAxc2J6NGGPg
 dIYfLHjZ0VWBFJeH5SVhHXO5xr1KvXiTeHsqghggkWiwsiKfZlWMWqNdF4nQfawfOZHy
 MBu3vAfjfA0wT0GVQ9onMZcm1MovbsclBxpG0m/vmO8yhpmELKTRoxljqZjUdbvz+C8p
 8gdpxcNVl0ch7jj613EUCpt1aNtBRRgbrDcBamARbilaZqnHIfuvTIV5LfjCaS0m+txP
 aFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560044; x=1756164844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euIJ23UmvR2gnuBXcALjdZ9+xHSo9z7xAw8xe7tcPUc=;
 b=wcGW0Io6cM0oaPeMhOTGzvOhGvS2EpZy0GupaK+rBtfIApaGS0mXh+3aD+ecFwvF8p
 G4Db2BHFPOwwSlgxU1WxVg41qEtc/Y0fVFOZ7fU351SnzH/ppyIFX9zzcJG4IenrZAGe
 M3RljcBcOluH7IwUeOPf1LyLE0vG2JjcTAfVQbiShVyMirAt2uGfkYk9PmIazB5m8nZW
 EEK+KyGk7fD9DA4H/ZCo6G5ZbYydIvi0AgyooJJp+41ZyQOiZydOZS3Pl51FfH7p+ucF
 GOhi9veREbASTf2xbbVT4GPNtwz33GNCjpNZdzasW4/nWmp0QpSmopOGRNQVeoIPxQ2W
 tLPw==
X-Gm-Message-State: AOJu0YxSLeQjuVZxitQgz6ze/YWxAzbdCVgk/Ld3Xwkyb5qDWrR8+gdM
 IadgNi9IW08PawSsRDUE/yDg74e5pakWB7hNWWN+SsrFua+oEKX+sC8o5inFfAdqUXb0S3hhbeo
 5vIi5
X-Gm-Gg: ASbGncuNDTXtynYEqN34e2FAAVd/AYpxJ/RLi6MHbvUAq99a/MgO+zM/PPITj33UIWF
 4q8/JeOTRKflD06/XA0OH4NvPvyFiBOLtO76iAV+sQLdO6mRQjO6ftqs7JIYxJI5uyIjN4pS9jj
 0HWJ9/6RPy21AIX5fSv/Zrsr0ecWGPeLbjtzEtBTJPtMbL8zl280b4Oh3t6t/56ehqZHbOT6Dtf
 W1jpqSYE/miF5r1mr6VQmV6RbyiOF4q1w2LDDJuEld1vBwH5OJ9sZc07YXc3jNwsbD+4bW17MeY
 zHWUOE/tJi8yhTPY0P3njr+ObQaRugy5dqwIJfqkh8PGl1rwU21RdJTwyvveqCsTXszwTbV3NhN
 OLUUhIxpXRTzqBLJOIeqQP0AzTnv4vzBxKDp3/Xt+XLlLgAP8EyVdIk1EwuSQHW0hK2tX6NC/
X-Google-Smtp-Source: AGHT+IG5RmV7KqsMPbIMwo5Tq/eti0yZdIGYjk4BIC2B3Liiq52+SSVu8vZBDVXECiOaBH82Y+uQQw==
X-Received: by 2002:a05:600c:4f86:b0:453:6c45:ce14 with SMTP id
 5b1f17b1804b1-45b43f6b29cmr1942375e9.4.1755560044314; 
 Mon, 18 Aug 2025 16:34:04 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Jiawen Wu <jiawenwu@trustnetic.com>, Zaiyu Wang <zaiyuwang@trustnetic.com>
Subject: [RFC 35/47] net/ngbe: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:46 -0700
Message-ID: <20250818233102.180207-36-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818233102.180207-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/ngbe/ngbe_ethdev_vf.c | 1 -
 drivers/net/ngbe/ngbe_rxtx.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 846bc981f6..c25acede85 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 3dd268e5bc..049a9f587c 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2010-2017 Intel Corporation
  */
 
-#include <sys/queue.h>
 
 #include <stdint.h>
 #include <rte_ethdev.h>
-- 
2.47.2

