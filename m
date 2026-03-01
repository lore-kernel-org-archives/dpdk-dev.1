Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333CDFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:08:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00FE940E0B;
	Sun,  1 Mar 2026 03:07:44 +0100 (CET)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by mails.dpdk.org (Postfix) with ESMTP id 80DE340B8C
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:41 +0100 (CET)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-8cbb6d5f780so350025085a.1
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330861;
 x=1772935661; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=mveMDAO7Y7+sYgx+27K+7FgDQRaqvXPJcTg8D9lhJvVnC2XRXtFlEecpDp21PrqrSu
 DEv4O+6feYQgFl7dt0qVMkUe5xl/QkUPpVi6wwUmQOD+UdWqpJ2wEF/17uh60VEUqt1K
 FA6cWdAInQDDVeIdsWOG0EQOixmCXP1NAiXmUQZdoT8omL7UvgQW+hUUBjN6i8w9PWJ3
 diDIAQTkk3h+71p4JK9CbnjcSNEt9BoWp8dxlHIdZt+5gtdNZNJnMhF9Dc3dulkVSGzc
 maafYQOAlFaN08fRKdULXqMb9/4CRnAl/KY6BtdW6IcWHRbFhMGu5WRMPj7I6bdxTcSF
 Freg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330861; x=1772935661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=rG+vt7DR9Oyfe4q+6JlByIlny20FD2nkxvsZsX4gzURuWO1IocDxVoM+rjJV0olTbM
 BwZgYzX4HgGyV1u70TzifNXlO1oeMWNAJsZ85FFdPHFLKGCVrsW558zy5paM1MmJ4Iu9
 XGBjup6NU56ChOCTj6ZoBcLJR22LZtum2W4EcFsfD8KuOSJ3LQmRHeYhJx6GWAfWnnZb
 kj8r2I/G6zqMBKkw+pLXWg30EGK8GLQTJhLhzzHdcj4YfK/chlhW0ANsTJhER0EULU9Y
 ljFNx/FXcKPUZdi50XxD2NQ4ECtPeInXZYS/dvo1KQZ8ZNUV8gRTXQ90zXFP3/W6v6vl
 p6qQ==
X-Gm-Message-State: AOJu0YwZ7aWlZ3zXitNotJqOkoY6BZQEmeGs1lHRUuHn1+dU2mWbIF2/
 2Ek332F4rVBm/BQk+RrGHH1wjICL6hU4HGLWGLXVLf0ah5gbjpWFoihmCSFQxuRZ+rVtfljmt8p
 G8npE
X-Gm-Gg: ATEYQzzB4eCn+VZsMFeAycD3EhPaMdCPaAtVDSxe1G8ITOyV6bLuof5B9oP98cZr5oG
 bvX+C9lcGiru8z6xKvyAfruqtUOM37IIWRos/yK4BNeEBNyTRRtkkJcv+b1MsPpqk5SInALN6eP
 rd+neu51c3Ypz7FBaWfijy0KbVCQb6RPpxzvP1x8px5NX5Ce2aXaXIvuzL9sp0fbv0TAbZ95fg0
 CNz0yutEqoxSRVmhREuToWVu5lUcUhZeMzItLJHwRaePWnuU1NwI2ukCKbnwiBfi375R05p5D/M
 zYYMqmf1CnODWAfYOPKq7EFn1dU5P9HE8BHVlzvMD4MnmF5MqQNqBnGrBHqt0sYkKkCkVgXyVhV
 gG8VigCQaxVQvuR5IbQqv3U+BEncAi3UjXGCzjbAlK1mc++10Qkcn3ZJUU295tgI/EhsI151JqQ
 iDORgKllKXR8ySwL7zZyTGy/UWxhKHD3zSuvXihZrAWu+V8oeHxq5GEBZnNCEQyA==
X-Received: by 2002:a05:620a:3707:b0:8b1:adfd:f850 with SMTP id
 af79cd13be357-8cbc8d864f1mr1142537885a.18.1772330860850; 
 Sat, 28 Feb 2026 18:07:40 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 06/23] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Sat, 28 Feb 2026 18:05:39 -0800
Message-ID: <20260301020726.852401-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

