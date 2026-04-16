Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61522F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1984069D;
	Thu, 16 Apr 2026 20:47:48 +0200 (CEST)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175]) by mails.dpdk.org (Postfix) with ESMTP id C4D644067D
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:46 +0200 (CEST)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso6050608eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365266;
 x=1776970066; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=fOiooJ/xQn0090tDLz0w8GiFB4Qf+JnnVWZeQZo9I/N1b9v3cajPDYM5EGI9f4WwLT
 Iw7DAZMUpzgoJZ9UMVd60puBcId4BAIBQrupd7DWg5L0CJZE1YfnpXdWN8SkEFlPYA20
 J/JiYvxweRK9oIQXlBNmjlc4x0/Y2P0L8JpCdeGM5WnpDHHPmYPTqdvWAtueiU1kYLnV
 LQUyGYXOVuJndF1HPQeCfaOAfMXhOlKDhL9reREtgBTtYQq7BIE8UMpbR7mR5IuCxvrN
 7nyg5b+OTSOrMJ6Zpi3f0ny6LZp8UGcLxUQkW5i2fBrQYUGkMnoGyLroC58feJzr0rih
 xVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365266; x=1776970066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=O3PZ0Wqocsr7VcMGZFSfrtReerHrq/hwJ0peFVAXXYW4jtL3MZDH5TGgVO1xHgep/u
 p+a8T+I4aI2xmidcwQrZLd9SsHFZsHFg9eN8RolXv/ZACBWH7+tC5VgVjEfI+Ic/AHyy
 8Sq70jl7JxQoEdCiFmbCyEZ/JNVi5JrimXPwmc7ee7V2Oh8/zCUOjNGTuD8J5Dzo/Te1
 OEibtyrJCIKiZ7ARO7omNaVrNSpnh7KOzr3i53qkHnq5mdtLT9cc0xW/oIk5MZ4KeIzy
 arJCNCh6TK7BncKV8yWGNXtXhKAdEYF5Z9PTO4OJyh4dMncLslz66nR60peodORNtoQu
 YHwQ==
X-Gm-Message-State: AOJu0YzNUpUkvQCbo/lMvmv7f36MjHsdixaFQgRQRD7RLJesbfXQmGjt
 Dj4pSICS4SOSFNOQ0AksC+IyeQ8l5ePibny9W2vVE/n+UU1ntXOS7KjYLoc1wmcLSS3hvQhDBDb
 HAn4r
X-Gm-Gg: AeBDietbTa7P0tvjY4hGzDV+YfY/fkrr5/Vf6hHO5QMGcUgxy0fCdryUZYeEaQ/YKlS
 72d/ysW7zpzhd7NdU9hJ2bqJbFA+Jg34M02ns8cbfrqPGBFXTw8Q5VuRLIU06t7cGcS/efz6uD0
 evHOgBe72T1y3hdAGtWnr5I3Fxd1wuAevrFqhOxRYT4RL7V/QWKw4o2A3XL7Ho46ik/wVnrRiQ8
 Dv5PoStQ3rVoxJFSe755GoE2Qo7deOpKP6UeNrKI1JtzHcL1nV8cgiHws2ReHKQhQsN8fCJf324
 UjFLtPxhOOCQoBNvo5tIkrPmoaDMUHhJHo8kO0tavFCOiAMVbX/KZAXe/ucTF4JSZ/3yLh4P00y
 BzV7RpBwvSfq0+GnAAjxz25kFObP13olYmMtqdu2KWs2pdjcPvwV3j0mHabRacsCioDDvKagLCx
 SEt5aTN6KObCZzVJt7LEJqN4vObd/aECEhF7JU929hLic=
X-Received: by 2002:a05:7300:1495:b0:2d2:c60d:4fe5 with SMTP id
 5a478bee46e88-2e2e309c780mr239113eec.6.1776365265859; 
 Thu, 16 Apr 2026 11:47:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 06/24] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Thu, 16 Apr 2026 11:45:28 -0700
Message-ID: <20260416184731.1347342-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416184731.1347342-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416184731.1347342-1-stephen@networkplumber.org>
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

No need to use rte_malloc or rte_memcpy in the short
code to get MAC address.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c        |  3 ++-
 drivers/net/pcap/pcap_osdep_freebsd.c | 12 +++++-------
 drivers/net/pcap/pcap_osdep_linux.c   |  6 +++---
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index d6fe062b92..724b7a9038 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -1287,7 +1288,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 		return -1;
 
 	PMD_LOG(INFO, "Setting phy MAC for %s", if_name);
-	rte_memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
 	eth_dev->data->mac_addrs = mac_addrs;
 	return 0;
 }
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 20556b3e92..0185665f0b 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -4,13 +4,11 @@
  * All rights reserved.
  */
 
+#include <string.h>
 #include <net/if.h>
 #include <net/if_dl.h>
 #include <sys/sysctl.h>
 
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-
 #include "pcap_osdep.h"
 
 int
@@ -41,19 +39,19 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	if (len == 0)
 		return -1;
 
-	buf = rte_malloc(NULL, len, 0);
+	buf = malloc(len);
 	if (!buf)
 		return -1;
 
 	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
-		rte_free(buf);
+		free(buf);
 		return -1;
 	}
 	ifm = (struct if_msghdr *)buf;
 	sdl = (struct sockaddr_dl *)(ifm + 1);
 
-	rte_memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
+	memcpy(mac->addr_bytes, LLADDR(sdl), RTE_ETHER_ADDR_LEN);
 
-	rte_free(buf);
+	free(buf);
 	return 0;
 }
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index 97033f57c5..df976417cb 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -4,12 +4,12 @@
  * All rights reserved.
  */
 
+#include <string.h>
+#include <unistd.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <unistd.h>
 
-#include <rte_memcpy.h>
 #include <rte_string_fns.h>
 
 #include "pcap_osdep.h"
@@ -35,7 +35,7 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 		return -1;
 	}
 
-	rte_memcpy(mac->addr_bytes, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	memcpy(mac->addr_bytes, ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
 
 	close(if_fd);
 	return 0;
-- 
2.53.0

