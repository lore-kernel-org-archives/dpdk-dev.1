Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FBAD2ECEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Jan 2026 22:46:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0F6B40658;
	Mon, 19 Jan 2026 23:46:05 +0100 (CET)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47]) by mails.dpdk.org (Postfix) with ESMTP id 7ACDF4025D
 for <dev@dpdk.org>; Mon, 19 Jan 2026 23:46:04 +0100 (CET)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so38504385e9.2
 for <dev@dpdk.org>; Mon, 19 Jan 2026 14:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768862764;
 x=1769467564; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=2phmr8c97UvLubAnRDI3XWit5oR7HRBYEhF3utduwsRATWvWZozWP7zYdZmp295p60
 YqksCuLlG/1XhgMXk58+JGZE2/OoNveCyLngzhk0aNL0NHsUV5LoBPrLdsVTRizVM+i5
 LLHOaPO6xn9ULIhyyCv/w6MZO1m0QJhql+Zr3SlP9nB5xEZ547f/IK9P5sDi61prmmWQ
 5+BzlbwDQE8FI0sytLqsKKshV6jpux64CIW0sJ66THrXM7KYp4ivfiPkG57MavlhL95k
 ihghRdssHIQo9CrGJRz6cla2utTmqAOpwDW77mb5DumSKYJRJPe80MZKeNWlkBfmuqdR
 1TRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768862764; x=1769467564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTQS0DaWxTqjs3HNXqGBrSUvg4NWW1WqcH/yntND4/A=;
 b=JiydhDXlaBLGtwqbvWiAbm8mBeShcj4PAk3+nT3PKxz+9akEAKktLGalRHG6MEUP8g
 REYYZkyRBgbVXSNm6cpqhMn3zEoVZuZvQPPeMNNyP+fepa03Z7hJCYlhDim4M0uz5WaK
 A6gFS7IBPqGRCZzabB+KLmODMV+d+dFpKUcJ4CjoBePQGUvwMC+KK/CGpEusYNwzx2Tw
 xjdhXBvcc+zmjqukIRtcuYUv24Hel/BMjnxhe07iM8OT/iwIKGR02610D06G3/aRtZft
 7aggBECZP0N2gI6sOrGL8Mi+Tn7uN0PFRUzOji6bbfDFKqSXIJjMlulRam3lD66fyggp
 mvgg==
X-Gm-Message-State: AOJu0Ywxh1eojZ5ynTdU8bHkI0iym9NFE5flPHtQFFP1FCeEVlBNX3+4
 HzAuPSbZoWXgWqEHLvmSVibll7sl3+u7ImiZTTsZDuovRHNtZh8JgZ5nzqtCl3nM8XUwKXYOl+M
 CulMb
X-Gm-Gg: AY/fxX6k1WYSw6tKto3eHzg8pUOAQwkPjrJzJ9loHs+Qd/1UKLp/uKa65KAFxDGAPLc
 wtEdvfzbBVp2LwYz0tgjnSaoF/ctw4tiV+jhU70Ey52gQJmFXacf3vC50gTBdOECJQ3FXt/obH8
 p1ovPjFGf+pZgIQ1i/50D5ETR5/VqYvjpnre/jQ1y0waApmxiVW8MIbMoYnA9fdrWNhUO6SZxL2
 V5vE80qQ0HAex8k3oTUZ2nkihxMSGzok0IYeD/GwbVRd0nRhL0YUztn1m/7FfEUh2pkJApDn1M8
 Qpg//mdDcRwrLdTgOO2hhNARJHQKpHx6DLlGbNFAPv5tODTK3Bg5Dt1y4wUDE/wcbGg7azNPkS7
 SJbEFs8jWfQmoXBkHsYpXrWorVQqX51sqMi26vDj03uY8/anuvP9E1VnU4ZnOwkGBQ6pAZ4+XDh
 xF5vWuMfr7hw27PQm0PcZl0I381CIvWYgKqOaP+XE/jGOlNg2xwijA+b3pC4nh
X-Received: by 2002:a05:600c:5486:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-4801e349993mr152878885e9.30.1768862764113; 
 Mon, 19 Jan 2026 14:46:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2b936sm88180485e9.11.2026.01.19.14.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 14:46:03 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, skoteshwar@marvell.com,
 stable@dpdk.org, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Harman Kalra <hkalra@marvell.com>
Subject: [PATCH v4 2/6] common/cnxk: replace variable length array
Date: Mon, 19 Jan 2026 14:44:09 -0800
Message-ID: <20260119224553.226243-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119224553.226243-1-stephen@networkplumber.org>
References: <20251023194237.197681-1-stephen@networkplumber.org>
 <20260119224553.226243-1-stephen@networkplumber.org>
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

