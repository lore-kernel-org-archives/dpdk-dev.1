Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B2FD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192B240E1F;
	Tue, 10 Mar 2026 17:14:08 +0100 (CET)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49]) by mails.dpdk.org (Postfix) with ESMTP id 02A7140E0A
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:06 +0100 (CET)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7d75ed779bfso689685a34.2
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159245;
 x=1773764045; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=iKlP3Lz9B8FmbDU/pZGm0uUvsgdpK3d7+sCAfEtcEB7EUhIxRTU1E7YXgGYPhLgGaS
 fhaNgS3490dLvZpBu+WdW+mpA5GMosxIwjM5HNfhvT/eBZsAsTRFfU3On9EpjGMsLI7w
 cNPqVNs3mct25cN4O9YZRnXklyEjjvJem2fT1B41Ns1V1swBH+mzSlA0KPJpZGn72sa6
 7BHJ1ozAYt58dOQUKAGhVxaJfwAMZudAmqpWDlaY+Nfqu9grwq1c3qqyl9eu07t5rLhU
 6sBjLHXf0tsE72yMyzUm2w3pHVgqW7jDIBG3PuvVuduGWgqyauKa54t1ahn9RhZfSZal
 VfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159245; x=1773764045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lftoMFquX5nMuetOGndTweQEe6ZOGwEyfPpEQwi+Wuw=;
 b=TM+qFYDSBvc7ASThzy3mXXWMNd6MJcDe5ne9g52CN0fKrleL3v5meGrHqCNwFobmsM
 aqk9aQ07U49URuEY/P2IJydpwI8x5SggzHvOlYvH9IKX7l3RwrQTj4GchW4GxztdGRbo
 KviQvlO7kAgjwxVbEHgOTLA3WtuNzxdR8pPAzcQggMIH3s754u7PvzYyF8HB8u7psUAy
 hX575u1ZatzxsLXwmtD2e3tc9G821E9MyNTo2bawHnkn469pnpaLmjBoKPzCLIB9Qtsf
 0wMdNrV8t+kNhzpNBCABuITwPT4BB6Vz+D89RZjZpagxrjDqGOhbH9ZrUHhn2e2YSykB
 xPfg==
X-Gm-Message-State: AOJu0Yw3qficLZIhAlKbKz1z7tE+O3t7woNIdBK/QuthVrHkS8OsmcEN
 59Y2XOJYeKJtEfJtViGAEcIv2tLIc1+q05PdC0HWfBTu72tRTGIC5uk9mAbu9iBBBCnS7ef0Xej
 bqHYKG2c=
X-Gm-Gg: ATEYQzyTBJCvu/i2HyPWgE3ZPQwVMlowqmki+SNkikpGcGudX9+ELKpWSXjFtguqJ67
 hQGTtXe4a8t5xfo045QhNIk/CP1vTzHNgpkAKcf9KBgBHJHLUi84yw5FlRtyAYCHkYfUHN+SDLB
 WGKOSXYzxy6yxlA9MWO9HNiKoMyjqff0P0D5otQY2h12QAfyPm1JAPqSVexirYIn3K8JwngE3No
 iMa6cGNg6XAaSfQpbsY0yg6DsKrOs1ZNzdx6U3R6zu3FMm61El3n8DA+cSRvkqEK6KdHiIFNxUg
 trCu5xx/gOn/Jb/vX0ZnRAjsZrxgo9ZTVvudl6ASSZEvhWcIHJXW0oIMrkHn4QcllOo3FID/mVE
 bXJy1piM1RMs6i57XWD23Ucs24ou2DMe5sYbY5UoeIqV9YMneKMYztyId8jbdVUeeKTGzeoLMSM
 9y58688nyQbztPKkqxAJiVPQmdzacSyyzZ
X-Received: by 2002:a05:6830:6503:b0:7d7:52c3:89bd with SMTP id
 46e09a7af769-7d752c3ead2mr3230800a34.16.1773159245303; 
 Tue, 10 Mar 2026 09:14:05 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 04/25] net/pcap: include used headers
Date: Tue, 10 Mar 2026 09:09:42 -0700
Message-ID: <20260310161356.194553-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

