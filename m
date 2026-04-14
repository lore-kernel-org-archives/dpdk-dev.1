Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D693F9D0E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B61D4066E;
	Tue, 14 Apr 2026 18:10:21 +0200 (CEST)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com
 [209.85.161.45]) by mails.dpdk.org (Postfix) with ESMTP id D249540663
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:19 +0200 (CEST)
Received: by mail-oo1-f45.google.com with SMTP id
 006d021491bc7-68207984e66so3200116eaf.2
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183019;
 x=1776787819; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=rZ2GcQt7JIICCP86cc/9Su/4kx4glGQNijNhexzeCnuiPDbPYmd0nnR9m3+Il/Xeyg
 JHvl7K3UscLjddv0wViJ1vONxss3XNwwyp2lM/nY4Ld9/A0A5MsiQwLWoSq51D18Bzcj
 Wf95XgZ2kPohLEI6NMiJnCvuUnv7IucAEgQldBkw3RvtOxOAl92vENrozndLyYnIrsfT
 HAQFVxqEPcIEwqfu8E3Ax52HTwqk9Bg7dukJb7FX5tsWuIaZ9h2xSUb5n3JXVGkrDL1w
 pB44cyfeL/QV/Wno1kyzZIQ//vMcXUAzJY3WJM4tBq6k7mat9CrSAX7hJMbPrdAxVrFz
 9YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183019; x=1776787819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b7C0ZcECixXWMpCf4mh9SH0qXwyD5WcXR3QqxA2vcXc=;
 b=ZEspWZlE1miOMOychFo4T+X/h35O3CihImCUXIizvr9sdoSe03pi9JcXWNg53lL+c2
 RdtRZkyBAUs4Aa69rZ83o1sCLX8N0q/ZelLU6+NiyyIwoyDEkTxB57ygfp9GafgHKgWf
 BRAI1g9s1G3t2GjuUP4OpYv5aGuC18wRcrRXYb0bVi5hW2gaChka+OfKRmLQjta9qwUR
 ZtnmBAPriTH0lT2Px98aFPeCZhGs6AZWdGxjJibOSk36/bNMDimmLnqJLnyklhcc1mPl
 WXhbFt0lYygEbAox4dnk1iDLIOQXaHXqehCLz61RLqlyQ6jQOfaSYh8g47KrclaaVVl9
 Q77w==
X-Gm-Message-State: AOJu0Yz45BJoHyL34uVxBJ9Yn5xAkN2kGSrKYNbGDmmmVV6XeEWymCuI
 lNd4GVQTvV3hr12e5y5Y9fEI7DLXkwQQxBqcYJRH+cvXq79Ersk0YRLfk9NCZatyVYx5rGWrpFf
 NSCRG
X-Gm-Gg: AeBDieup9pO84ria7bm9nWk2wrzTqKS04XBjepyYNWtj1XO0Q96nQxu7pNX5fHUCLwK
 MxMAPFL0w+BCKuLAK61peahWWz2js0c2qNRuGJxLS8laHQRbagL3pFDNXSjkjTQbQ+SQLt86kwy
 VHrnAZOaYCh/2uimqLMx+qSXOYju/37zpvDpWgc91MGn3WTwQbuYNxOFyDzj400wLe/XjguMAQ3
 UK6I2YWPof1IyF7DEt/DDfT4wyih1kUFuyUvRnkNyv3XQuhKwxK5pAxAUMpZwuWRV9jLBU8ODtn
 l5Dwpm3zahv/p2yhkrAIGm2jgMQdAZNy03IV+VRPYzkMD87k53hTLMRxv4eebutDZvIKcN2NcCb
 GiZ/aX2EwtC1meBmI0iYJ1p00nXjELTzs+yJE4u7A2PgtHKBl4Bs96Jgiyv/zznil+Rsr9gBQ/r
 lC6ChT+mhyxMLEPuTT03FDgWRXuKYqaSHquHmOkBKoMDU=
X-Received: by 2002:a4a:e90e:0:b0:68e:4781:2193 with SMTP id
 006d021491bc7-68e478123cfmr6408917eaf.32.1776183019174; 
 Tue, 14 Apr 2026 09:10:19 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v22 04/24] net/pcap: include used headers
Date: Tue, 14 Apr 2026 09:07:55 -0700
Message-ID: <20260414161011.756101-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

