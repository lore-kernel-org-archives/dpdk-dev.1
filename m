Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78DDD73EAF
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 01:14:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69B0E4065B;
	Fri, 30 Jan 2026 02:14:05 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id 15D664060F
 for <dev@dpdk.org>; Fri, 30 Jan 2026 02:13:58 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4805ef35864so12710805e9.0
 for <dev@dpdk.org>; Thu, 29 Jan 2026 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769735638;
 x=1770340438; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=bJ3XN0ze1kh4L4k4NFeXF7EZew4L0SmIycBep/3D63GdimYHroIXZzn1EcmPatFNmZ
 9Pa0i5gAQkH3OQTCDP/0uUffXD+CZEQC3TU2lU/yKe4GJ24yOzJAQZy/yA/zgxWI/MEE
 W+ZvDKmxoVukDBgsa/pgDYY9+5O7GEkL3QYoowPtRUwqPQCPUhO1bWurXWaNOm+45web
 vaQDaAZOQdxd+CrfJk3sJDlgZLh35yfe/NuUX0j9UdMm8Uy4DRHBl2wX/LvvS/eUgIB5
 DQBfhHykbYRiG4ZKwWwv9sJqQWMghvRJljq1Ik8lm7j/WAtETpNsNAELqLZT+YZUvpsb
 zyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769735638; x=1770340438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=rlFQIP8rLSJOn6IgyHC8uE6S7rLv7U9YVgRJ0GPe+Lf7GrAX/7WnqKqAzfMxS8iNno
 VwwmLXlVkApHn9ETjh5NZELVRJHEJNHJs3fYcwQ+w/nl/1lC5smhS2WAYt8iXH3lK5UA
 oV78vtCvstcv78yb0gxep6omXmFiT1vTXbN6uVBEOOuKIMpwK5oqJT5eaHZSkT1gBpmr
 9Pu915eOcPhMgSXS2+I42U7gAqN5Z3EN+UZHmbEUmm8Nroz123wF1hieMiFkFIpaIz8p
 D4CX1+jKcadnmTycBjCa19aRyRyuAPcAIyHf2R3bg+hWYqAN2SldrF4SGGqoIOIzubph
 TfHg==
X-Gm-Message-State: AOJu0Ywwj/2XhvyJbUBgAIZbXYyuKoQZTJFJnU9N5Z9n/xw5udjgVuzI
 ILT2D596pDnQL72cn7i01K3LvBzBiCpRhcY+dyTaR9MOaLO8sYNmEFdH5SGjtqCu+CJ0Cm3aClP
 nZkbI
X-Gm-Gg: AZuq6aKgOCM4EycvLxf/Ou8m3+PZAyuatRMN+I6aeZXruKxa3iS/AsEP7FeRtIr9lP8
 3REa1qiKqg89jOxMqgwPOsQc7gg0M5ksm+woZvmbFJ6/GktY/9aRR8lx4yO1Vru2YtuQaIE/wBx
 cruXuIg9zDWmyTOJLzfpoFdlx3X3r1DTHe+m097wDYlsO5M3yOc7azvHqfZWkOFSHg+B4TwJ/NH
 zCYg18lNykcMDCn8ZTIuVhGEgj9j8zdB78pKtINAfO+oiaw1nSVE9VQ/adeAH8UoEg/Lm4j3DIo
 qzKt4+tOYIbGeH99q2auCQrkA3CVKf6o9ohlniMlFSpo0mo5uqIoazOcC5nZb5jHizdMLFeq0+r
 3ei47rHIhe4JTzUdBjIfns97SODAZjiL9wqCHyYXzKI4MZkvP3LlAmHgCbA/Q17/Zxlfx6sbPyc
 Bkq7c65t+xjEwBiye8tsbEdNwcklL8M8eqgjMBa4NGrxiefzie4A==
X-Received: by 2002:a05:600c:34c4:b0:480:52fd:d2e4 with SMTP id
 5b1f17b1804b1-482db012dd7mr12772075e9.0.1769735637678; 
 Thu, 29 Jan 2026 17:13:57 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5e1d0f9sm2934825e9.18.2026.01.29.17.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 17:13:57 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v10 05/19] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Thu, 29 Jan 2026 17:12:21 -0800
Message-ID: <20260130011344.204233-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130011344.204233-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130011344.204233-1-stephen@networkplumber.org>
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
index fbd1021c39..806451dc99 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -6,6 +6,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <time.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -1288,7 +1289,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
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
2.51.0

