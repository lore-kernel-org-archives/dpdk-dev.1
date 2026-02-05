Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308AECD993
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 17:58:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF991427A8;
	Thu,  5 Feb 2026 18:58:01 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id B628C427A3
 for <dev@dpdk.org>; Thu,  5 Feb 2026 18:58:00 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4362507f396so749960f8f.0
 for <dev@dpdk.org>; Thu, 05 Feb 2026 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770314280;
 x=1770919080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=R0PA8rDkXsPNmn6S/ExSKpmZk7u6ZBqFT336hH3yfUoGvlgf32iRizBzxGu1qCkl+H
 mThUIwAj9HBHcoRY+kRgIKdBpWE26jKXjXNINvApUtFJtQ0io5a0OAaDePK9SulgFZp2
 wqjYgOLFtxjqcu0M4IjKmHBKbJnMfCTORf3O7NZBeLlCon3TttAVJvx1EaQg4TW0j52d
 2I45JXJ/QDAptOWYxZjLAUDy6xDBIboZj14qQMCDWE8VbB4xsusaweDx6ZblOh19/CKj
 hqUzs8EZkrTjjJmm8FfXugEm5i5bjFl/yGt1YqhM9YtXiAXDzfL5p0FW+Umobmt6zSuj
 6uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770314280; x=1770919080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=trj1T1RQxkZbbCFkILRp9Sl7TvMRn1IOphyl1kAFJucqOa9WXzLWijbGXavZRSIQX+
 1Q/qJgnoQlaYYcjSqUEM4XLZEDJ0bdHVWeXXk5xpBZMM+gg1GNaqmJ9eFNlPzQOFQZab
 6rkPHnBkoSYh8ATYHVafhv+vxF3DNlnfThpyNx+t9XAl00NKUaax+h73cbOe0S65JQsk
 FAdvW1XaAYQHWVQOkCk0CIlt53yuf+L/e+Q93jWNu3MOhNu7ZoBV1kLrxacsVAMqDMzX
 xYXBsSgacKL7vf4krkDZ5o+k/4gfOsc+uZkJRA1hgsMoGMsKYu9leuskTRaKMeY1xnJY
 wTuA==
X-Gm-Message-State: AOJu0Yw8W/wI3F69g5+Ip1gsJ+Jb8OWd37YJmeeWZpfZd93K87TGGnIw
 uy4p8ee/6Pm2+KpU1FO0GDs8Jq83dYaxEsuvvRQeyWVLJ/aWwccqSOu/BRLSyZcN08a+KyYLmxD
 481Ji
X-Gm-Gg: AZuq6aKip+JmurYyKzjL6LFf734qE1g234p54nGo17ThTAxtB/qJVdodnkxjBqVaYLM
 +5U+oADiSUNwfLx4nc5+R/8CkII2bfoEKxhscpGRzLCs2/yqfUrYQmtEsc+gXoQWh6tWCsYe5Bm
 gJ3uecSEBUlrCZRqeOCvP58iZ9pQh1/eR40VUo0jdld8zdL0U3GYy3vpi9fUkGUxWgPh6SZcE01
 p2JXwk492YZlcpjwMY5ssyAmfabxR1RhdQo70eOQSnqCgSCiRBGG8SrON+iG3FWWOlZm9+W7BRx
 i9vCF/K3Vd4ooaxy2dIaaFlR9txcSNrEBGI38oSzYRh5FDBmtfcV4MS7VzGoZKkiGfRGMGRk945
 +rKarpTOei+FxwGhsh/r1RqebRMQtGzLmDmJ7Irc/gsegras++kCCyfbfqXfX6wsvshN4SHRArp
 VUa73AgVAuBYilpUbkaE0GNbSIP3Pg8esrzUbCISInmVcxU4GNn5y+pda/Q5VI
X-Received: by 2002:a5d:584c:0:b0:436:db8:c4a7 with SMTP id
 ffacd0b85a97d-4362933aad4mr147287f8f.6.1770314280314; 
 Thu, 05 Feb 2026 09:58:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f7csm15465594f8f.23.2026.02.05.09.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:57:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, skoteshwar@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v6 2/6] common/cnxk: replace variable length array
Date: Thu,  5 Feb 2026 09:55:54 -0800
Message-ID: <20260205175750.653353-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205175750.653353-1-stephen@networkplumber.org>
References: <20260120195418.466318-1-stephen@networkplumber.org>
 <20260205175750.653353-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This fixes errors when compiled with LTO about large VLA.
../drivers/common/cnxk/roc_platform.c: In function ‘irq_init’:
../drivers/common/cnxk/roc_platform.c:92:14: warning: argument to variable-length array is too large [-Wvla-larger-than=]
   92 |         char irq_set_buf[MSIX_IRQ_SET_BUF_LEN];
      |              ^

Since the number of IRQ is limited by EAL max interrupt vectors
use that define that already exists rather than a function call
hidden in a macro.

Bugzilla ID: 1863
Fixes: 375cb1601882 ("common/cnxk: move interrupt handling to platform-specific")
Cc: skoteshwar@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/common/cnxk/roc_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index e13cb42285..1fdbf8f051 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -17,8 +17,8 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
-#define MSIX_IRQ_SET_BUF_LEN                                                                       \
-	(sizeof(struct vfio_irq_set) + sizeof(int) * (plt_intr_max_intr_get(intr_handle)))
+#define MSIX_IRQ_SET_BUF_LEN							\
+	(sizeof(struct vfio_irq_set) + sizeof(int) * PLT_MAX_RXTX_INTR_VEC_ID)
 
 static int
 irq_get_info(struct plt_intr_handle *intr_handle)
-- 
2.51.0

