Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6A3CA0EED
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 03:44:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5316140A81;
	Mon, 25 Aug 2025 05:42:47 +0200 (CEST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id D199040676
 for <dev@dpdk.org>; Mon, 25 Aug 2025 05:42:36 +0200 (CEST)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-3c98b309804so340555f8f.1
 for <dev@dpdk.org>; Sun, 24 Aug 2025 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756093356;
 x=1756698156; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7xBrH9GnuDwKhrQ4JuANFmAB+Bir1ir5hSrVXIcrLc=;
 b=cF8AetdymXKgxuyCYimQWEQwDy5y9IiMQ4QK3xHNTG0RboXuH6XM7oysvwfmeBruPS
 UghtoiFRee8jCs/n1LGdJTtt4/yP/ofeafh9uHAUlcZzrZm5TTtZs5fEXwqagbg8VGTV
 ZVrF6Zwi/xQxqkzblyeLaRm2MbaBm9fykKwWdKzagBjJ7Z99QVbIwz/iMk8BXVNjWCC1
 e8/qbZB97pFicRQNookI1ZU2irNd335ITWafJ8gO77ojGpkmjw95nUHYoSlU7Ahwe+Vj
 WUX5VYPA+lOftqJth4xwNbeHqXe1uY+jnMK0dNd8LsPm1WaCm4qyDUIxTz8EWftXhMkU
 sEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756093356; x=1756698156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7xBrH9GnuDwKhrQ4JuANFmAB+Bir1ir5hSrVXIcrLc=;
 b=Qxbalc5wHB+W2NVEnzVvku5jjc2eQRLjN0FOFe5G7wFH/B6qx3lXdAaQiS7BWdXqXC
 TZ1JggGCHM1uu9Tbfs67+Lr5joVmEIhiXMWyv/0e9gMDCPgn2FT3oiwD+IHWlb9Bcm1p
 1/jketFFS9FD8NGh6Px4vb1kAkF0w2f7WNQQPScSwQMK1HBe4dc3bi8LC+G0btwyHXju
 rMXNhfPR7VjQFi+0MpQr7euso7BzbPHRfayOZga2kKUyA/+efpPrjPfx29TeKORdB542
 eO3SG5qBarKXyx1YluK/kFDCwbCu+onVdsa1zB4x89ohR/sdHod5dBsnWbz6O8WDr2Fd
 t9kw==
X-Gm-Message-State: AOJu0Ywb5CG92QwdzXhImmJqYljUtxIExFFu5TaFslYCUnPyM6Mg/+Jo
 sMnP3xY4XPOEvNbZHMzQ8AGKSonzQXeBT/AUTqHvCOJPCWrGrjKHQgyy8XCbWFSPpwQiSOEkMPZ
 CJ1zA
X-Gm-Gg: ASbGncsZw41Osdq1vMo1D4xPpdMVj3XSQCwZeaQYR400RurEWJi2K32CiKFO6IshlV+
 BfTcioCA0l3rLbUhE11fTnjhobcOmatsY8WD1/EwKJeVmfJUQi2Hqh4E7RILkWfcQhNkj1OONVW
 mdyxtTHY1udasYnvB0eraEhyd5vMYnX4mnDsFNsfD1Hcak5/Zeymkbhfh7phzrqzolMzTqVhnFl
 Ws7DToX8lzwbiFo6oqIeXzyccaIrLOISF9KUidQ+DChpIasIIOjW88zrInlkDlnPGl5ZPhi2JlK
 Vbz4t6p92Exf5Dq6tTky2NFO8QxFSNn6S3ogMjjWlssnTFm4jrF2D+K7X+n5SN7qxY96UuwDniY
 ESgdA1b7RQJhHG1XSgAGdt5paMFAzGWhAN3R8VnoKsrGLyOqAs7K3w/fCMx6RQX/4al3WhIZzvd
 lUj1Zmswk=
X-Google-Smtp-Source: AGHT+IHMwlC/qwmTMdRU/4gADVX3j9+PtVyzaBXKbTVGuG+yj5Q6JibWsDLaB4fK1rqpAUS0Fu4zYA==
X-Received: by 2002:a05:6000:2888:b0:3b8:d4c5:686f with SMTP id
 ffacd0b85a97d-3c5dc540a3fmr8397255f8f.39.1756093356473; 
 Sun, 24 Aug 2025 20:42:36 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c711f8a0d6sm9609939f8f.66.2025.08.24.20.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 20:42:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH v2 23/43] net/cxgbe: replace use of sys/queue.h
Date: Sun, 24 Aug 2025 20:38:36 -0700
Message-ID: <20250825034126.12046-24-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825034126.12046-1-stephen@networkplumber.org>
References: <20250818233102.180207-1-stephen@networkplumber.org>
 <20250825034126.12046-1-stephen@networkplumber.org>
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

Replace use of system sys/queue.h with DPDK rte_bsd_queue.h

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/cxgbe/cxgbe_ethdev.c | 2 +-
 drivers/net/cxgbe/cxgbe_main.c   | 1 -
 drivers/net/cxgbe/sge.c          | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 9b6a3651f9..a91da8d267 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -3,7 +3,7 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
+#include <rte_bsd_queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
diff --git a/drivers/net/cxgbe/cxgbe_main.c b/drivers/net/cxgbe/cxgbe_main.c
index 2ed21f2d66..b3d7e1c012 100644
--- a/drivers/net/cxgbe/cxgbe_main.c
+++ b/drivers/net/cxgbe/cxgbe_main.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 #include <sys/stat.h>
 #include <stdio.h>
 #include <errno.h>
diff --git a/drivers/net/cxgbe/sge.c b/drivers/net/cxgbe/sge.c
index e9d45f24c4..3fa296b1bd 100644
--- a/drivers/net/cxgbe/sge.c
+++ b/drivers/net/cxgbe/sge.c
@@ -3,7 +3,6 @@
  * All rights reserved.
  */
 
-#include <sys/queue.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-- 
2.47.2

