Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AB7D2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:21:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 247E040ED9;
	Tue, 27 Jan 2026 18:21:49 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 1587A40E6E
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:44 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806d23e9f1so130725e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534504;
 x=1770139304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=y0r8i4ChALfMsAyAtpRx94e0vm0uyFmn4YM5UR6i/KHH/gkxtRvSHwmmfM5Low+Hg7
 HJXBvj1Ixs2QZiPDKHJmBj5MoRBSHjSfhscK1gEhNZI84hNz2W/MrX9mEpu05kKWhycB
 Q08hQHz4zA46Ao9n5iJ+GFS6kUcftRwmhwNqv6MXTTCvVoPbSXgbqB0wzVSu6+uLl7hu
 FlmCXJF7QVU3qFU+3eUUNcpv2/nLVSG+UARGSrFpRhWV54/7lwhkH546WKqcKE4xlG6B
 BiLLMnLeE2Hi/JkE0iTifeOY5uD9jRVZk8T6pKgk+O8JwNEAV7aNfP+N8d2KAgBu7WAq
 yIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534504; x=1770139304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vh9lHLIbW5TviFRG1a+14E8V5ttWYOO9kSmaL7spFa4=;
 b=FtXV7qeuU00spIIMdhHVZuv6EXH53cf7TdhKBz+UTkK0K+GlzI3W2PutuTwWBXll0w
 AMLaU1DKWUolLx7c16nPMEYAqO16V8I19ThcIjzXf2hnPlJTBwc6H2TpFW1tIrDrWPUw
 klYMYZ3RJyu3pVPMEpG2cDgL0pVrluEbibsrxGK5mH2nOn8TqAmzYepqyUkL6NBx9CYz
 q4T2Um2hrbKDwLRJdKoYyb01Dk21TiRN/eP5Jn4TNeg/seHJ30+aagAt+qDX78v3fUpz
 RSAYwqk0a+lTa46weVEYqks4KKrnVRp40mNS2TusMZMv8h1WfziP75XfKBTgYyyoTMke
 IGTw==
X-Gm-Message-State: AOJu0Yx48sd9sFAtFyZl65NhNP4Acu0waHLss7z6u+DHNxvOcNIPatWQ
 YwQInci48/sqFBi31OXhdQ4uF1MQ1iUTRmP65yiPnWIHqJ1w4LAT55rKUhPNJK4kNdGRBwR5JSA
 L3djR
X-Gm-Gg: AZuq6aI6H8CXI2v0n5dAoo8mpBu2yowIq5miqbtS9m6bUwv5Ab1kxEEQ/oQUmssLEqq
 U3WMiZIAbqFKpIea4w5CHbdIaGSz+OR1eWYcurfBTHKx+vIjtAPWk7MpXO7bySiD2ub0IwYPUid
 7Bed67CS0hV+/nEvpt09O7fQu41V8msuQqHsGhuKRXcK0T7ted4hhhjYifnCHgmVqLMrw/5y82s
 Rju3uOuyiTIKlpAoUmjR0eoGZ7BSGmCngNxqHD5haF1vlIhg+xgnkl0VXsL2IWBNOSXysdm1Put
 p6582sFR3fleWeZub8FH/WxNEpzXPdKr3Mg++juVT0LFMkPiUBC1dSzHqqpTbjAqNQETHa2x3e5
 u89DSiP0dJk7+ExXNo83iTWvbeGpoXt9ll9+8+rBBJZOyQ55diH/evE/IhvOamafnqseyAvepGa
 PyVjDf7TkJpXwxkm78dEKLnTfFh9s+ZvTNwZSWMeltqiGLDIO6lw==
X-Received: by 2002:a05:600c:608e:b0:477:a246:8398 with SMTP id
 5b1f17b1804b1-48069c163e3mr34420615e9.2.1769534503642; 
 Tue, 27 Jan 2026 09:21:43 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 03/14] net/pcap: include used headers
Date: Tue, 27 Jan 2026 09:18:44 -0800
Message-ID: <20260127172128.124473-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c | 8 ++++++++
 drivers/net/pcap/pcap_osdep.h  | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f323c0b0df..d09ba5abe9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -4,16 +4,24 @@
  * All rights reserved.
  */
 
+#include <stdio.h>
 #include <stdlib.h>
 #include <time.h>
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

