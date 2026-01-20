Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD042D2629C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 19:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91A39410FB;
	Tue, 20 Jan 2026 20:54:35 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 93ED84026C
 for <dev@dpdk.org>; Tue, 20 Jan 2026 20:54:28 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so5056373f8f.0
 for <dev@dpdk.org>; Tue, 20 Jan 2026 11:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768938868;
 x=1769543668; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=Un40Ov1l7NJrJaXPpizwVUbUrOUynTRFr/rjYXoZK1yeDC7399TuZuCjZ3to4NoEQe
 n5xrq3SPoX7v6tdlxajTPHpzAf8U9Zr6WJKPftASKUkCCCIxU0jbH0ufmlximFWeP9qM
 CgUoQZXYhOQ9z+XrRyoetYbMPjbOMJoiUck4nWEJ/3kEG/r9p8fHqMkckJLKazzvkUi2
 q32my/uBjo1rhQig6945tdTeFIlNcKqhk0vrSSG+AWwJOVmvnqLxS/qkBp1ZBWJOoqH6
 NW8GkwOKC35krAQNRQyhYRNuZ3XPHLZgoLJqkNF+88MUAVNEyqxGzhHyjLlkuJFDfsxR
 7aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768938868; x=1769543668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=eG28W5yAz6vsvDy8eBa7/xC8yN+TMgo/V8xGYDDYIFv79oRjbA4fgfF8kHHHvRSjJV
 ry3uSf7w+U2L7NBVj8/kIZJTPDHNm98psWd3ym3NEHi8AWXG5g5b0n++yDIFijb0qKuX
 pnqfEaM0MmmB4waSLL03TJwJl2OZFdKt0k2bgj72aR5rHClNPdLIf19yEX6BEZrAK3d0
 sXeMShka0eolfMQqabcH1gej7Voi6I2WvS/qz6AgsLGqNDgP3rNvVrNtL5Pu63cPI3+3
 kxqCG0e4g3zJhIqie49r95zXMAQD0rZSKMFHd6tOBGel0zaXzdPH0UcJrwy5vPYr5hYQ
 3duw==
X-Gm-Message-State: AOJu0YzvZ5KDchNPdZTGLFMkvOrrvZ1BWz7J0NEICkylAHLEfOd4ZvAT
 ScJbBipA+lEJ/MafLa4oO5IBerJPZPd3ET6XD5hGb/ft793pS5WRJSctI2BZCLloVpiwB1V+vmv
 Q6/iC
X-Gm-Gg: AZuq6aJbGie12u9L79C6Fde3/9TdFBOFAbTuPwMEntM+5/7C1Hyuy1IJNE2GMfWVvfv
 4juMplp47WtLsB85uBYtqaGhnipEHyedwwoOVCFdUY6S/uabMU9ACU9Fm3wP4jPXEZh4vE0un0v
 BxSNpn0xQN/V+hORbEO6bG+EpW2vE3tqO+zjsg7hsgroGYlakUIeAqs2V3dxVR9NVdTWa0mG90o
 zgrHCcifPS3c70iSdSnmp5oYiq68sPitVdxwlANtw7hDMzjhyYQxBSQdOwv1GsD/N45i6VA3ag8
 JXFgyZNpMMD2zo4VFfXNuNuCeWW/5Q3Zdn2RLNrBg6/kuGg2sWjtjTGwBBGT0rsI2q1RtdaJ8wC
 q7q5vXAZtCW2sGt7zVcKYS5ulYUvVvVf600XbBZp88rKYe6aGFhe27sqtHFI5m0u9lpsqHjl13F
 etiK9S3Hl6DDmYhBYi6AhBZzMwnWC+z0DQXpWwd73LPPXKdKJytPRiAbaVvFCh
X-Received: by 2002:a5d:5f94:0:b0:430:f879:a0ee with SMTP id
 ffacd0b85a97d-4356997f1c7mr23420921f8f.5.1768938868038; 
 Tue, 20 Jan 2026 11:54:28 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1354644f8f.28.2026.01.20.11.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 11:54:27 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, skoteshwar@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v5 2/6] common/cnxk: replace variable length array
Date: Tue, 20 Jan 2026 11:52:07 -0800
Message-ID: <20260120195418.466318-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120195418.466318-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260120195418.466318-1-stephen@networkplumber.org>
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

