Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A47103E2F7
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 00:23:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3206440E4D;
	Thu, 12 Mar 2026 01:23:41 +0100 (CET)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43]) by mails.dpdk.org (Postfix) with ESMTP id A392440264
 for <dev@dpdk.org>; Thu, 12 Mar 2026 01:23:40 +0100 (CET)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d743ba241aso296967a34.1
 for <dev@dpdk.org>; Wed, 11 Mar 2026 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773275020;
 x=1773879820; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yey3bOlzzkaPoOQqLy2DLIwkzkLEpz6J0G7Ucpm2ifc=;
 b=KVFVMJi3kU1vyYInGnZZWdFxPcraMtDRl6LRnXOOTzirqrvIrW+F6AWKw/RFgOf80a
 8iOJSrnpqz9nq+I72im348pV3eFn2dOeCkMc8e6VkwhB2MR5Jszb49dxLmbRTRAAz+fM
 DwZDvND6fbpkNjX5E7BnGfla2jtXvgtHDCJZO48jnzP9owOxS4uhvn2fM/Z0iLxIrHQx
 pnsbDgcGu7MvFqfZPwQd6wwjw2To3Idi9F0fRzrn64Di0yL7g0taffj2YDtcxpuH0lUJ
 8Gg8XEYLkGmlnOJSaNniCsMIo2F5HUKI5bD2PIUSZn0G0u1sgCYho7IuHnnoAo5Tcu49
 6eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773275020; x=1773879820;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yey3bOlzzkaPoOQqLy2DLIwkzkLEpz6J0G7Ucpm2ifc=;
 b=RU5u4aTHJffCA35Y25YThWZCpjYFOjfPop9fOSeBizjzVNlV1eCqReo6KgdhMbhATZ
 gGFJrAQzQuXIbJOfCwdhiNynSSnZTFDP8ccxuHAgxdRi5TKneEjb+1uODmHDae4Voi9C
 KH1bl1Ox4c4rgmSXp8Lm/McpJsjY5eh//mSH1Oj+BD+mQ9swUvLGkdz2sw3vcoE0AOPk
 1l6K3rNdOQeaLJaxxVwg3S4cP/BkLQLsUHVL0JSj2HbvMp9wUpJ1iUI9GGTND4ssRnQz
 gMI9U6bPds5yMg7eEOstI2vR8OVqJ0ogO4lwiV+ja9ZmjexAmHRJeH2tGcZYt6e71n+I
 aeGw==
X-Gm-Message-State: AOJu0YyhWknVt40SJHayrvmMo3aTB9S2l5k+TYY7hoxNqrdqWh19wtOq
 0k6c478NRaj+cYBj5EHda1QiTeuP0BQzxuRXERi1dsjn1mTjEXnRwgTSQJ4aESROmzayEkcgkHd
 NGdFP
X-Gm-Gg: ATEYQzykWcDjdoCEvkDxPWXqIOjrUyGaP6DyEk55DLuLo1yh4q2QryqaLrgXhM3/icZ
 7n5tC6UyJLKPZ6bi4GbBD3POVmPY4hj+2wU6iWpYAk/jxvx/Sb3ou/yXzszl6RsSOrwh5De3GW0
 P2jVGqH9+AW9vsJlh52L9zgcK4C0I1XRaZFdVeljSqWNwz+mVAU0I4Bm8JwAMOF0eYJd8ELnHe1
 yz2V+N6L2zBt3xQyUYuR3yp42yXtLY9CGy6kdxojaJmGxM9zBalQvwuYhHEAvTbMZND8H5XbTRl
 YEkWQuVKNmOJ43VKWbNKFPMmuW9pXRBHtLra9YDCMW3JxJn4dygzNS9xiSWfEKOTf8+rtI1BP99
 IExy8SainQmwpKa9bm5SgXI/o8+YVLvyY3RkffX3WmblKwCQgoUL8MwFsB9ffbCxHYLMdrjoI0H
 ypguryicjxUbgKZxVZyyFZB4Ge8jeAU4He
X-Received: by 2002:a05:6820:1895:b0:67b:b718:1a44 with SMTP id
 006d021491bc7-67bc88d16fcmr2534498eaf.31.1773275019819; 
 Wed, 11 Mar 2026 17:23:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9354e59sm2260976eaf.16.2026.03.11.17.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 17:23:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Rosen Xu <rosen.xu@altera.com>
Subject: [PATCH] raw/ifpga: fix comma warnings
Date: Wed, 11 Mar 2026 17:23:36 -0700
Message-ID: <20260312002337.867771-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

The driver was open coding TAILQ_FOREACH_SAFE() in a manner
that triggered warnings. Replace it with the standard one
from bsd queue.h.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/raw/ifpga/base/ifpga_enumerate.c | 4 +---
 drivers/raw/ifpga/base/opae_hw_api.h     | 7 +++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ifpga/base/ifpga_enumerate.c b/drivers/raw/ifpga/base/ifpga_enumerate.c
index 61eb6601ea..085fb6db40 100644
--- a/drivers/raw/ifpga/base/ifpga_enumerate.c
+++ b/drivers/raw/ifpga/base/ifpga_enumerate.c
@@ -725,9 +725,7 @@ static void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
 		return;
 
 	/* remove all device feature lists in the list. */
-	for (dfl = TAILQ_FIRST(&info->dfls);
-		dfl && (tmp = TAILQ_NEXT(dfl, node), 1);
-		dfl = tmp) {
+	TAILQ_FOREACH_SAFE(dfl, &info->dfls, node, tmp) {
 		TAILQ_REMOVE(&info->dfls, dfl, node);
 		opae_free(dfl);
 	}
diff --git a/drivers/raw/ifpga/base/opae_hw_api.h b/drivers/raw/ifpga/base/opae_hw_api.h
index 57750022dd..63cb616731 100644
--- a/drivers/raw/ifpga/base/opae_hw_api.h
+++ b/drivers/raw/ifpga/base/opae_hw_api.h
@@ -10,6 +10,13 @@
 #include <stdio.h>
 #include <sys/queue.h>
 
+#ifndef TAILQ_FOREACH_SAFE
+#define	TAILQ_FOREACH_SAFE(var, head, field, tvar)			\
+	for ((var) = TAILQ_FIRST((head));				\
+	    (var) && ((tvar) = TAILQ_NEXT((var), field), 1);		\
+	    (var) = (tvar))
+#endif
+
 #include "opae_osdep.h"
 #include "opae_intel_max10.h"
 #include "opae_eth_group.h"
-- 
2.51.0

