Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2FCFCC9AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3901D40A6C;
	Tue, 10 Mar 2026 03:49:36 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id CBC3A4068E
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:33 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d748ca8708so1081974a34.0
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110973;
 x=1773715773; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=NeG7SDuGpc2cPMeQwGUbFWY0WLEjBWF5tdfRFKjpm4ssIfY5FbtoU/d3qpcjwq+WRG
 f3AvPqrp6omg8ET5ukwaMO0r+NRYUbDbvfvzUV0V/SUp1UBgJbE2xcFbkzZlfoSU44d5
 Tfubfqk1NQQRAdBEcLGrrN2vQ9DNUHF1lHcRc5e7y7DNwcZwn4iVJtL1MIB+R4y3X7Bb
 txSqK839VluEvk0TEwglD52alcpp4drs3gvbcHth9s86rF3jgQQ5tSw1PAI+9ec44zhN
 I9bFkZ978Uarpe9keqRLm4zupKGjPLOr/sSdGsTFA2l+8+0w3Slbml6V3aN9aj2bhgZA
 Oc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110973; x=1773715773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=qOrwmNatKofEjp/GhKsw2y7sVk+VqxnTcaE2I9o9zB0Bw1I/W0bh/GEdKH/WbF4tX+
 jE+8nqnTeUObrhtSy0ibXNJ1OZdFlz9IywdFFl5qhJxKuqCmCNGbiX1JRWi5o9KyY9lN
 Rvuv/2jW1MtFWX5pNT2t8ajBHtU/pPYhyKICx0xczsneIm9icpD3rHCJJGl4L9yDVJCx
 NchVRFWAceTK+ONC8fd4ALtAmd2wZmHf7KJk1zKp52jrC7nlbAZuNSNj5pwOVpN3+4GG
 LDq+PqOd686IZvALxCoT4P4Zi2pTzgxcluK1oBD135L5/IJxbZneyc22dJvsOBg21nFB
 CRXQ==
X-Gm-Message-State: AOJu0Yxkj5zTESwOXdNl3xhNdVCS3hTv5OqYAKBw5m1v7KdkVWZnes7H
 9wZSjC3f5Gx7sC4eYD6uf8MmmNGUi9Pr5Yj4om9xS6qZvPSIX5gvvMGonoTQwcFaHDjA4igLQ5S
 YISEFER8=
X-Gm-Gg: ATEYQzzulpDRfgqWkxT8j+E0cYu9Ln3z7q4pUk5dwKLhQU5QCgzAats1J8x6I/i42BY
 8LXwH4utIgQyk2Qe4m4tPuJAUa0LTLLGUzEwF/XcwcacQnq8SXVEb+oZsYqIb764CY72si/Qi+8
 BzKTB7cVQcw/qezfSoObluGU4dGKLWAwpNKsOIvMMu0f1jV9uVaaqg+YcAn7txNhRpdkRa/vXSK
 hjWB7oxRczMuE7nyfGILG7qxTjGayWHXIcptAc/fzbg/q9U2Uf4kjDvZpMtDQs0piG/Aply54xJ
 gNEGN0HPkC+TgOnM+OwC8nRCswbvyBPGcq/JMv7GKfVz7dd6bNZsqUy7GJsZgl1bAxQogKRKdIX
 W953sfArJjwx0B/Bmh+du7/z0+FHgmzxOoAnSbsuoV1yER4YZ5GQiYmM9DlAAXfP9Xe/xZAMPS2
 rzjf73U9nsxibwV1+cN+gzG9oeIKCNu8B0
X-Received: by 2002:a05:6830:3812:b0:7d7:5dbd:d532 with SMTP id
 46e09a7af769-7d75dbddb47mr377757a34.13.1773110973164; 
 Mon, 09 Mar 2026 19:49:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 04/25] net/pcap: include used headers
Date: Mon,  9 Mar 2026 19:47:39 -0700
Message-ID: <20260310024925.476543-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

Include the used headers instead of relying on getting
the headers indirectly through other headers.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 9 ++++++++-
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..4513d46d61 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,23 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
-
+#include <inttypes.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <sys/types.h>
 #include <pcap.h>
 
 #include <rte_cycles.h>
+#include <rte_ring.h>
+#include <rte_ethdev.h>
 #include <ethdev_driver.h>
 #include <ethdev_vdev.h>
 #include <rte_kvargs.h>
 #include <rte_malloc.h>
+#include <rte_memcpy.h>
 #include <rte_mbuf.h>
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 2aa13f3629..a0e2b5ace9 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -6,6 +6,7 @@
 #define _RTE_PCAP_OSDEP_
 
 #include <rte_ether.h>
+#include <rte_log.h>
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
-- 
2.51.0

