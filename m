Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B7AF43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E62340666;
	Wed, 15 Apr 2026 16:48:15 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by mails.dpdk.org (Postfix) with ESMTP id 812E640650
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:13 +0200 (CEST)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-464ba2bb3aeso3956737b6e.1
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264493;
 x=1776869293; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=PosX8bJ/NmDzrVI6J9IWr7310p95S3bdeKnWBJg1UsM8Jyqhsz2sIjYvjhUz2y5cwQ
 2TtGMLw2MTAImRCJnwzMZtcXBlFcU53fWsUWpkffLj73+pdrROdX3x16kN5cPa4q2tTP
 /QDZPBcXLs4Vn9di0M/OMsP1ve7rPOx8wAEMPYOBU2JJvnUP6rbJwzf1w+24OgFNBc7M
 Ep2rBAFNv5o31yqPq9aANyWuaD2QH/od75qFx+rzA7gYU7sBX4xaJxT6IBOinTIhBjiy
 i8t7G8DUzpJsgs8BSu+fhuKkI0vd2Yyk1cIrgwGPdSAHhVdC6THfnJAAr4bA1H/U+hRd
 nvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264493; x=1776869293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=O5gd5lD5nKZTrAjopMxZh8iEmaBhY7BLU1qEy9URLJuKBlb8XyI97yKFpz+iCUKxR9
 PCxnk3x78sbInPca1sdQlqUlk6jcA0O6sQ5vA3Iod1NcDBAOFP7SLULaImk7d4oR/15h
 o8m5qQtvFjmsFFJbbjvRb2igSdn8fn2XXMhgLIc+zBLveaF2gywWaMKr+6zUtmZc7+Y/
 utLbld4mHgus1HqyAUtPdg7LCiGUGeQfBQoFHRI1ZohGcpPoMuIa2jqK21MLQoFMXowx
 Xq1HS5bkL6jDDuRco2HYNNzPJ2w7OkqclJHgJ6e5rfvYS/H/PD/bEZ1xNRU07ekw7sVl
 kw2A==
X-Gm-Message-State: AOJu0YxDJq8PqlNGdOluMiVdzLg55FNhEbBMY9PKMygeTp1Ms+0/JAHD
 SmMAOqa8do9RLl1aD8yk6Y8/QVPq4iC7Ps/w+d7uP9WsjDPLWYTf3JoR5B+8gBUlT+Rs9BtNsWV
 dP0NI
X-Gm-Gg: AeBDiesusf/IfNHZeKyKgGzmRAFVBA72x3L1sWF1eg8QDGvRA0j0eyvIi3KeHCD2elc
 w8DFFn+OgdG318yz4LySop7mZVu+J4jluLYMREWl1yvin4tZ6jzhf+Rkkjd2MRcSKtcGSGTvO5s
 GGznPj7LdunYHY1aWg2a5wzgc0IWOd5jRrurtB77bqzHjR4R3GQzIUCKzVhu8p31G/mYlNG0HG6
 qWB8ZSKUS/j07fdaI3COk+mHjf/1o+NQk/NSJLyS8RzRpAfF6XAEQeeN7S2e1ipfijDd2eU5QUG
 2fP5QEyW5w93Hox9St4CI5pBGIXYfAxxnpiargglxzcmZD5+Fw+JnmApusl2JfZ2gsbv5gD3D9R
 s5AyG1yx0Q0FG+xuaZFFAvp72wETXJ4AISC4b8hMjHraHiPbyESCHN1Ub9Jckhoej4AKfqMHlNz
 hMTnXNiIfa+PY3oiOgd5+/KGAe/+OSwYSbuAe3ZunGPzw=
X-Received: by 2002:a05:6808:10cb:b0:475:58e:445f with SMTP id
 5614622812f47-4772a8641b7mr12117791b6e.8.1776264492775; 
 Wed, 15 Apr 2026 07:48:12 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:12 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 04/24] net/pcap: include used headers
Date: Wed, 15 Apr 2026 07:45:53 -0700
Message-ID: <20260415144717.226161-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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
2.53.0

