Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9999CA0EE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:34:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D8B0406BA;
	Tue, 19 Aug 2025 01:33:14 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id EDC3A4069D
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:33:12 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b097037so25716975e9.2
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755559992;
 x=1756164792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jenZRfzW0Y5iRZhO0hagUz3NkqOGk0F6JskcR7bp+fU=;
 b=BediWGLO7DD3MwNE9/Dpp4s1mFg7ogVWqcMlIUYpZs52uUCD5Nl5SzvKhkjno2GPlk
 ySYk2UbiQ0nZsovx3bAhjB8oVzKma99AxeGd78dLLGbwvcrAFv+Ro2/3lG95iEaXBlhR
 cei+16V0FI2gWwgC4soQRId+QjSTv3cgNcB1x72Ajncx6sXtV7UZjzBL9bRmMjI7rLw3
 y9uopFxDIAPwJW2Kxyb0gOFQEl1AGmmTvNZZqC5q+MmgbfFbYjXC+Ig0cgeXreENR7g9
 ojMhwhv9sr+NHSimjNIv5zE52TadcaH6L0Ah3JgU2zYm5yVqYfWn+NF/8Rl+oAMj9Gfy
 SeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755559992; x=1756164792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jenZRfzW0Y5iRZhO0hagUz3NkqOGk0F6JskcR7bp+fU=;
 b=SuPcUBF8dpDUC98GlDBzxMxfu+C2JKEUOyAAWPxM1Sb7LYjKEdWRrF20RpKjMFsLYx
 eWduJkZRZDeB+tYK/vvHZwelXGyH5xPmowSWrSKWlVN3k48Oa3rOJmChtzFmGkEx2i4M
 5Ez8FG2SkuOb+EYe1/fcd8mGeRHtBOKOYr68mqDLcdhcutZlOJ0XcUXJm2dh09t+ipcf
 LiKMsWNKcLuZq6gxSQG7OKjvwQZgTaWrisaUtSCyaGAHMvZG6BW5P4/TNpjWvwpG3ise
 UUn9bVTbJurvZdh0lZORUf6tAlZ9lVxxdyRT3ZzNvccEm0dSr6e/HT9AIOiOdHMCvHoK
 iK+w==
X-Gm-Message-State: AOJu0Ywl2r9dJLsGnRy50e9eHQd95z+zX+XPfaa89tyI6C+iouIIptct
 nL1fSSTcy8UA/VcO77fEGsXRqmMJiY642RD87GWlFW1vKje/8a2o56VkvaZOJN67Lcg3hSs1C39
 01Jlh
X-Gm-Gg: ASbGncvOOrPKOgaAGa22NEKm7H/5/mrZW24rllJOY2ZPtJI+CvDeRJ8y8ggG9+T9ef1
 VNrCTq4hR8LNToZbLGa7Gb6QRZfNY2vpHVpSOG6FpHGBgMKm9wN05XSzCTaqpjrlnsal/XoqHl9
 pTfw0+NgjdLJEnT/S8WMcsDjpa7Ilu7+ewlYG0DhV9YP6fyjEIl2ZJH9SWE22+7mfJ9H3x+Tpah
 MQlRkzPSUyErfJ+psZmp9oJ3/+mS4k7tooCaXXQ4uWQssTdpBzGJ6JQICXHYRX8kEsrvHnCKBy9
 SmFz5HVnVrxV5uL2lG8eei9J4Wi04yiTffTF+ugXPodASqywOXvew4MovfQC0o1My0bydLfqof9
 vrTBCdx8Nxf9eeJJkeQdyqOttqVK+rjtt96F5g8a5lp6ZG0T9hQ6UDWlDBb9pbkBf611X9cuc
X-Google-Smtp-Source: AGHT+IHFLmRgGit45YqppuGra54BGAbOtA5NFrEZfhzvMfHjyPWaNvJvtO9IDh7tRdU5pKZR/s/7+w==
X-Received: by 2002:a05:6000:4008:b0:3b7:9d87:97c6 with SMTP id
 ffacd0b85a97d-3c0ecc3212emr288743f8f.44.1755559992559; 
 Mon, 18 Aug 2025 16:33:12 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:33:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 14/47] lpm: do not include sys/queue.h
Date: Mon, 18 Aug 2025 16:27:25 -0700
Message-ID: <20250818233102.180207-15-stephen@networkplumber.org>
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

The necessary macros are in rte_tailq.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/lpm/rte_lpm.c  | 1 -
 lib/lpm/rte_lpm6.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 6dab86a05e..09d1e08263 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -7,7 +7,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index e23c886766..781ec8de0b 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -6,7 +6,6 @@
 #include <stdint.h>
 #include <errno.h>
 #include <stdio.h>
-#include <sys/queue.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
-- 
2.47.2

