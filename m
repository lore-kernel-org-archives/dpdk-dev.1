Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD53E83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E00864065D;
	Mon, 16 Feb 2026 19:14:21 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 4D58640668
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:19 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4362507f0bcso2953786f8f.0
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265659;
 x=1771870459; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=EB+eCeASLP/wimsV5v5RqYA3A9yfg1P3/CDBq7hQ9xJMu/LOT/RIEQfOAmXj+DyJb2
 AtdQwIIuRU90JmZbPtRNK1MlV5X9VRIu7bB5G+lteQ42hrS96rNquRSI214GEM6AnoKm
 eX5HdMpDX8ItWuhZZT8AdwnVnxKTAWdFLDJ53rPYmgshH8RKOXsjQlXIsaA+HeeYQqU6
 x3pI+79RzB5MIfl+a37rqSPfigdJNguG2alviioGoJlaHS6i8bVscdBl7jt50nv/MUtf
 9e1bExoMa7n7BANFIvFKkmIRtdT+R+i9f3/5K+Fa6vxy2Up/ju1/AofUqdITLTUfQ0PW
 Zc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265659; x=1771870459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=W8zSBfScKYSZ0+3OFB9bgLlkoVdRC7FOJ7f7fJCliF39EYOLTi8E5E582ji3M9w0gx
 ly3Sj388blklTKW8DiMA9Bex10ipXahB75/dyU20Bq2URlTTOlMYdsGIjbKJRZnAbFcj
 xTYd/FJUf/dN7v2Sr0XO9M08fe6mRtmAFQ6SJIbb8LX3SSrr1dKqf3RbYbBBhs7EKY1L
 zH9ObU/9GC9eGhexZ8vgzq7GkWTIigR2Ht26JmNFSSiyZ8/DBSC955ogAkzUPdKze4I0
 OWMkEoD8uPJF/d20U38xcY2HBhmrZoByp6mn8JaEpCNEzT729LpqGUx2zrB2/DT8j6z0
 XPHA==
X-Gm-Message-State: AOJu0YyMO9qKcXLcjVnWwrfWEwd5z1PjeeIk2hN1VqP4dsFtTyMWzmfr
 WJ7m0o+UVS/5uQiqS+SY/d/SLPpxtiMCcGIgSlkv3xmoLbkrWKJhAjgFygVTC+V2Lu/YEQik36M
 eZif1J6U=
X-Gm-Gg: AZuq6aJBnuUDfOIEsRf7BHGYztnUnnnBdoBHuAou6r4JdxLsqZlBK4XOXJZsRKkgT2C
 fthe5UN0og5lZP64ug/AZsPv9oY8W7uEvWsODkXCFrqQfppicbDgdSprrXcUz0RbwDGSiAPx0q4
 9A5nOhmkxfQvBbsMtVIeBP6JsEU1+mReHX9lU8GyflK3PI2KYJ3Knq9Y4CgaJOtdRbmt0Blgqj6
 dWRnzaimzwCr6bcwIsNQAJzEqlRY5bHqwLWjQfmRjgTc0DLPMginiRVNB6JH3qJvACdrOyAKCFG
 WA5WNYdqEx6OxAFcajs2ekVlhy9z2SiXSgeULXX4dFOTjs/U4vzOhMNqz1oWHYWQtyASCJXJ3oF
 bGHK6mqzMPcA2x+QpVK3IWDoMQYMiKF3jIOWoVhZk4ZOIJ89WWaw652/bCuVR96AkJN+sZyF/ni
 6toHrdfdQnuyCEbkChY8DlDVh/5A00S+XQsqRt6tqNoLyOp+r7wSveyLORSjBuwg==
X-Received: by 2002:a05:6000:2503:b0:437:6963:a10e with SMTP id
 ffacd0b85a97d-4379d6155abmr18079715f8f.23.1771265658805; 
 Mon, 16 Feb 2026 10:14:18 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:18 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 05/21] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Mon, 16 Feb 2026 10:12:00 -0800
Message-ID: <20260216181407.428877-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260216181407.428877-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260216181407.428877-1-stephen@networkplumber.org>
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

