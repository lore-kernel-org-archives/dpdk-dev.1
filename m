Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8EE63CA4
	for <dpdk-dev@archiver.kernel.org>; Sun, 25 Jan 2026 19:23:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C02BF402E9;
	Sun, 25 Jan 2026 20:23:29 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 4AEE5402BD
 for <dev@dpdk.org>; Sun, 25 Jan 2026 20:23:20 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so2561798f8f.0
 for <dev@dpdk.org>; Sun, 25 Jan 2026 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769369000;
 x=1769973800; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=JhVsAeDmoQ2B/WM6QRrFwFJlPhhnyLNiQO7Mwr47fcVU9brW8c+DbKfemvsYnHKr2P
 xLFUtu7tcCRCDzURQH2J7Shh/bQl9ZaxIaXOUmYvc/eY1QI5C37/AJ8zi+jzdez/0XyO
 LkJEZY8+C2M6UP80JWWU1ZKzbENcIo0UqKMvc9AnOhf3wkwNVtMjYRXujjVARaKEblaK
 lrIanRe8awKsbqkgyep3niu4kmJF0UTGK6kRSxc7xv8mTmfZ9F3wD6aIPM/17pwDRWXY
 rbt6H4oOOUhsl+o1NfIbHEoX2oAgQCHtAWAZzz5DzOjGhzEyPy19DBuDag+wyrW1hEN0
 hJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769369000; x=1769973800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=NLdaYFFsoPiCLwW85N1HzAyHgUr9ajOxwKGAw1huAQkc77mkHPFxxiL6IOmZFlyMe7
 Fwvpx+UbRwzgFEHG+B9rVt7xniNW4TnmvMuszHoAOVlU1A1dgpnuYAhCNFfJhN2EHvxV
 FrOhlaCMey5iflMav4zOdRMzyPohMH4CCA8WJtaGQPANhvpPPtL6B9Kbq0dJZZrjw263
 fBqgyUx5lpD8SZ+fwreKE045AvXr7DiVBxOUyOTdrHXksBPomFo/Nxz/K/3PlewM3DLI
 yz+7jFkL9xt/WY5VBpbLbkwv54zws86NWTOAgsWKcsw04iCLgXMVbNS5ycld4Y76VSsK
 ALQA==
X-Gm-Message-State: AOJu0YyJ9EtsQM3EZycZCaH9xf4bNAqaHn1VZWll3xa8rRD4ROsuhslI
 PXKjMUZ+oxSWuXTRKb0VwoBvbRmF0Pvqr1PrJmimIwOC1jokL4mF3RjrdpqfoXZzLeeRVxEHUiL
 pVKqy
X-Gm-Gg: AZuq6aKl8fMqO0hmgHzGpOorPnUz9Hw/oLOQYEKmtPTGT7yGBTvPlnMRtBk46MI9r9p
 Dz0xd0mlhLnnM/r/CLtjgZ22gt5CWWZR/0hd7t14LaJgrkbd5MTbEzysRQJphWQ9qr7turCZKR2
 e1UOGhucvFp/PciK1v3FnAYizuHzKR+bIB4Cj+SztpQusNhX9mHF3X6o12reyopPa6aQ09AL5Xn
 I0iIKtXkA4TGicDwURm5Gz6qPUNWahHl29QnZHtobBXms60w/WKkSK9QLVhcOwbsP4nYcfyVPLf
 L+r5Pj2hgKa4fpOh1EyfdUD7BUqVtgP3b7yHABcWL95QX5r7ksMsq4uQDEDmhQME1tNjQozc0CO
 WlbiZ3qqh/T3EoHm8TUdN+4GVbrEb7mo0ZGMLDQBeScdh1P36uilRvZ07OOUmaMk0582pu9rZSJ
 mumBUgCWJYkOgxOljPNg+vP7m6U99IAk7jMWfTT8Z4tRO+Ogw5LA==
X-Received: by 2002:a05:6000:40cc:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-435ca125b9amr4199464f8f.23.1769368999844; 
 Sun, 25 Jan 2026 11:23:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7b4d8sm22854362f8f.38.2026.01.25.11.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:23:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 05/13] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Sun, 25 Jan 2026 11:20:03 -0800
Message-ID: <20260125192248.497563-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260125192248.497563-2-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260125192248.497563-2-stephen@networkplumber.org>
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
 drivers/net/pcap/pcap_ethdev.c        |  2 +-
 drivers/net/pcap/pcap_osdep_freebsd.c | 12 +++++-------
 drivers/net/pcap/pcap_osdep_linux.c   |  6 +++---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 0177cbc7df..2e41ad35ed 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1289,7 +1289,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
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

