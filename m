Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C13CA0EF1
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 23:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32F0B40DDB;
	Tue, 19 Aug 2025 01:34:05 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 1BF1640E09
 for <dev@dpdk.org>; Tue, 19 Aug 2025 01:34:02 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso23947155e9.1
 for <dev@dpdk.org>; Mon, 18 Aug 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755560042;
 x=1756164842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yL6kAGpLuVR5SdKNxDUtJdtgCbgtaKHamFJCLJP2PIo=;
 b=IOlrZ8GnOXQxJP7iyI8Sf9l7Yk4eI6zlOKLD7gzLkJOepeyscJL4sTZd75MeqQX5uG
 5JXPga0d7nrYB2gaWIhwdy8DQOd9qnaZcqcho39kazkTyQGVJKpLVU+2NCD0tXrOk41R
 Jrrq1PorzVS30kM9pHr/WtHGeDANifhe4PBmfb39+Io8yFtKLJDNgftPlqmKTSi8E2zX
 X2qgvxkl9QuFsFVSSiU5zHxId479afOQRAqJrnyjBAGz1mh1Fq3uIkYX/H1Ebo4SYgEc
 ki3cjJQdyz5ubJ6vhMcAUrlwkueIHeL3YeXKkvVS5/JnPGO9fm3qmL1zBFehC4eYklR6
 6hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755560042; x=1756164842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yL6kAGpLuVR5SdKNxDUtJdtgCbgtaKHamFJCLJP2PIo=;
 b=pwDmrpGIiYb1ZZVoS/B9w+oS+7puJbkYIrtJ5F/j+C9qSgPwjU+nWWYed9pe+uainT
 qkbJ7nqKQIp/fR3RxA30ahTO2cWBGf1n2oqut7jojCbROz163e+pnmi5xP1KNbTAs8UA
 eiJolTWZ5XtUryCpEslH9fFCr1EIGOkElUTvEoXo5SL5+sWGf24ZksUi5r4ACWdZBNm7
 1JuOLuCzew8JXCVHuZoHVGKhCkC+MLy6ZzGRtyVbpnaE6IZxP0RGFqJ5GsvhIg7F2kCA
 4A4lJXf2oBZootu8N1/I3k+x031ooZFUHbfUnfysLSX80usJaFwAGo+2KBdpUXjUf5/m
 jFKw==
X-Gm-Message-State: AOJu0YwHuV2WtLtOa5pTa/q2ecCFegpqrSD99Lh3DUgv4vKyPcIf1MXD
 tppWagidf14EkIRbSks2qAMwq5I88AzF2kcbkCq20PbiZge4hl1FBS7HunoiCUdNpqAg9kaXn/G
 ZWaGR
X-Gm-Gg: ASbGncu89XkNzWXnPBvhEqYyQrs3g9114Vu/epEqPCQiMrtoG0t72CCKL0qVjZVf0E5
 FFgZo3vhE/Bab7FyvgQ9oixdl3uskWiX9yowGgbmWoWeN3aOGPpa3+vhsgP1IBde1ujDcbucG7J
 x91KujwFW/qICkQaMrinJVY83EDhds+kBvrbuyqBhEqDgwt85PbXEvr2+TJs913i3wa+M3simP8
 eb+Wa0zRedpHg13iSzr0bK6cecNy5Ac5316pNSZRZVVGDd4UfFzKv1k0QKE1gw87zZIK/SRwpTz
 bE9aEXPi80hJy7wgkXY2HVJTbtfUxdlftnDwJWShLvHoKwxewricT/+xX01P1PahI45QKwCdC8Y
 EaElp2HZXxTEqFoVlDB8rJxvK49aOOpX2KU6fsfBWv9sFeGelfqLc3C8gXmhkaK8hKXAso05hkD
 SchIYQztA=
X-Google-Smtp-Source: AGHT+IHvrwLCrt9ALcvkAEXi0yBNQDqEK0zuIyazvOpzg4XBjHGOSGmqc3KlocSRD+JPk0PpCyO9xQ==
X-Received: by 2002:a05:600c:470f:b0:458:bf7c:f744 with SMTP id
 5b1f17b1804b1-45b43e0d57emr2343735e9.32.1755560041725; 
 Mon, 18 Aug 2025 16:34:01 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fe5sm1233063f8f.2.2025.08.18.16.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 16:34:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Subject: [RFC 34/47] net/mlx4: replace use of sys/queue.h
Date: Mon, 18 Aug 2025 16:27:45 -0700
Message-ID: <20250818233102.180207-35-stephen@networkplumber.org>
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
 drivers/net/mlx4/mlx4.h      | 1 -
 drivers/net/mlx4/mlx4_flow.c | 2 +-
 drivers/net/mlx4/mlx4_flow.h | 1 -
 drivers/net/mlx4/mlx4_mr.h   | 1 -
 drivers/net/mlx4/mlx4_rxtx.h | 1 -
 5 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/mlx4/mlx4.h b/drivers/net/mlx4/mlx4.h
index c992a1c5ea..67768f3e56 100644
--- a/drivers/net/mlx4/mlx4.h
+++ b/drivers/net/mlx4/mlx4.h
@@ -8,7 +8,6 @@
 
 #include <net/if.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.c b/drivers/net/mlx4/mlx4_flow.c
index b520664d95..8a696e9fff 100644
--- a/drivers/net/mlx4/mlx4_flow.c
+++ b/drivers/net/mlx4/mlx4_flow.c
@@ -14,7 +14,7 @@
 #include <stddef.h>
 #include <stdint.h>
 #include <string.h>
-#include <sys/queue.h>
+#include <bsd_queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_flow.h b/drivers/net/mlx4/mlx4_flow.h
index 5e82df6bd6..a27317432d 100644
--- a/drivers/net/mlx4/mlx4_flow.h
+++ b/drivers/net/mlx4/mlx4_flow.h
@@ -7,7 +7,6 @@
 #define RTE_PMD_MLX4_FLOW_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_mr.h b/drivers/net/mlx4/mlx4_mr.h
index 56dd73ff19..7fef07d6f9 100644
--- a/drivers/net/mlx4/mlx4_mr.h
+++ b/drivers/net/mlx4/mlx4_mr.h
@@ -8,7 +8,6 @@
 
 #include <stddef.h>
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
diff --git a/drivers/net/mlx4/mlx4_rxtx.h b/drivers/net/mlx4/mlx4_rxtx.h
index 70f3cd8680..c68375b088 100644
--- a/drivers/net/mlx4/mlx4_rxtx.h
+++ b/drivers/net/mlx4/mlx4_rxtx.h
@@ -7,7 +7,6 @@
 #define MLX4_RXTX_H_
 
 #include <stdint.h>
-#include <sys/queue.h>
 
 /* Verbs headers do not support -pedantic. */
 #ifdef PEDANTIC
-- 
2.47.2

