Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75919CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF28740651;
	Tue, 19 Aug 2025 01:33:21 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 66A8040651
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:20 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso23945675e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560000;
 x=1756164800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbEmlwa1VWm131qHjTi3fEAUkENTM70f4NR0VEkZVm0=;
 b=n9nNvJY2zW4D9q0t14HiPKtzNLfeYCfBiYPLBWKSiqa7eSTbdV9yxvIxNXZoe354L1
 qGTSUTu2BSoQsV3BmTcSb6GcGCiQfXlEi2AVLn35OsI1m1g0+lk7/3vc8V7bb8qL8Tkh
 66gRnny6Qr0VJmM2kmCrHhLrzDQYYusFnEc6HNPWR1qLF1On67JQI/NoWxlCPYme8Q4G
 GZjBaZjcF8GTIFtcdHDRALiJN+gWKIuEw5yOXISzxAta1OZufSy3S1inXKia7ni6Mr4A
 JQPj6PB/r53uAlcdlUQ0ZoFkj1Lklkf1tDFHEmWq8CvajH4U7bWau4GQ1h4ZTwKydj8U
 DV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560000; x=1756164800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbEmlwa1VWm131qHjTi3fEAUkENTM70f4NR0VEkZVm0=;
 b=d+NMA53aeOut3O/vwOrdesGCIwK1A3TqRFX80B4+1zcN3xY13adw3ajexvBERV7LWc
 JejdM5S3XCW9SOeEkp+2l5t/vBSvcfQDcqbKvJKHv/62dleDNb7H/HfktNJ1e/xfcOfK
 CIot5clHPgj3Yw10XohZ0UinmyPtUWsgUy2cwIc5vpENxrUogqbS7q9z+PzaxS8FLkwQ
 caneNb4kTW77XGDOYiqkaJtY4Jiybm9amxLZM9i1szVlciHVWz3Sp2iRDSCB7QU5wdH/
 YrgfcMezCtV5x2yXOf6dFxQD3U9B4rFB9xBZ2I+wY90epoBTWc9mQOUCEPamEVV5Pxo4
 NSVw==
X-Gm-Message-State: AOJu0YxvIWOOXg+nOaGDvGoP8ymlF1kqdBrXY4PlP6kwVRDcyOGP1TbY
 I0TQieeMWrDeMT7K2q/kOUZkB4xT/+wztFY2yYhoAf2VSkPeOWsh7lk8kM5QI8zhu91fLRo56Q3
 XISwD
X-Gm-Gg: ASbGncuOQzSRXQy8biRWeu8kXVbv3Bc6Yh2OWNLQChbQNjvUp6iqPNZVedcbDIzuyyv
 VI7F70aCT5QXk5ysGlHPS/gGDGg4irEHibc9mDaRpZzbV3qMU6e9xzD1QczSzfEOEYW1kbM3ocV
 Koo5ThaB9QbO6kUj66vc4vdEU67RGk1HygJWymitmvJP+HGZi4uSu3hpRM3czUpdLiN+SKs030t
 zrhSxmeOP9/1v3mhf8NtsSEOW3C3+J9b261LHybarTYh79S+JvS5hz38QQwc2iqTkLW8gVtTL7x
 eoZBtCe0pWl5eijG4UzWb/wPBjpnCjvFvnr3qthQty3eytQG1FQaywQUgdR+buVdr7qUMhTZdyP
 T654LrlY6rDmoVZNuzS3AtnDeogSCezv4sd2crJzOyFeLL0z5PWFrTLWGAcCuPEGB1RFiQLls
X-Google-Smtp-Source: AGHT+IHvYVPWeBrTO6c80uprRRL+j9Z94zaPMGQNHf2sYZLgbxWFFsZl6oX8ZZM0Fg96YDd7VhMhzw==
X-Received: by 2002:a05:600c:1c26:b0:456:eab:6344 with SMTP id
 5b1f17b1804b1-45b43dc63d2mr2609985e9.15.1755560000064; 
 Mon, 18 Aug 2025 16:33:20 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:19 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC 17/47] bpf: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:28 -0700
Message-ID: <20250818233102.180207-18-stephen@networkplumber.org>
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

Use new bsd_queue.h instead.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_load_elf.c | 1 -
 lib/bpf/bpf_pkt.c      | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 1d30ba17e2..4e911c5083 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -12,7 +12,6 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/queue.h>
 #include <fcntl.h>
 
 #include <libelf.h>
diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index 01f813c56b..fca082ac53 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -7,8 +7,7 @@
 #include <errno.h>
 #include <stdint.h>
 
-#include <sys/queue.h>
-
+#include <bsd_queue.h>
 #include <eal_export.h>
 #include <rte_common.h>
 #include <rte_malloc.h>
-- 
2.47.2

