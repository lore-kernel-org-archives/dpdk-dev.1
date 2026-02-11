Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA7ECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3FA40668;
	Wed, 11 Feb 2026 23:21:51 +0100 (CET)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49]) by mails.dpdk.org (Postfix) with ESMTP id E566C40663
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:49 +0100 (CET)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43638a3330dso3687889f8f.0
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848509;
 x=1771453309; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=H+fUMR99ZYdk1HYPvYZdkAEyJG3MH/Mm9aGObx08FyoNZ5c5W6/IshuLX6LVcLxZx7
 sOh7m9h0NQLz9Prxi1hrSDwtrNdQM3goPUBA4Jvj8I51knZpObzGICT0yCXkrO6Sxwtl
 jhfdJU6ybKOjVKOM8wS5NqRphTUUgKvkgpjHiU0ZFJjqOtBLaSQylLfqpM5TVYpRYk5S
 sjnViLMsfcqZA2whlp2JQYyQY0zcvgqEsbBod5E9ZEmXvDvVTj0UqbZHilTj3NLA2NmI
 NbmX6asyRP6Li51qAH2+6ukknRgnfnD/DbC07qNAR6jQd0RZuTTP6brndZ+iWNwDc41G
 pVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848509; x=1771453309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=CDjOpKvPRinMy+F3igQFqs66jHUJ0IxZXPRJuVdW+ptU/Yr0lWHUrWhcD41bSjm937
 T/gZNOvHK/wzvU4OKTMotKU4gfacqIoWMjrN5y3F2EOBI6NLNsNZV2f0WaMFkxFt600B
 w4S4apCPWHmvPDpxVDFJC2qI6WGNH8Yfax0z58M/hWTED1nlTmKVr36SKcX+91dXnOYk
 IZmW3EwbDxHOV6XFnAME0iUvH6OHZy0R+ftAyn0uJlI7ZG9+JPFkA2Aofg4yIJa3+WjA
 pDS7JS2e1b853h/HBpRET1ca8EqTBVCF5ivBksl86dE9JdAGZvvqFxs6zJ36FIB+RRzH
 foCQ==
X-Gm-Message-State: AOJu0YwTUIZ0bZytGYWk8dEL48MXjbCDcUe/75H1PHmykP+eTcfAGP9g
 dHWHtAmcO5R5BYzk3+WzrDH3xYrQv0pkOZT3OT7XgVwK21BzYD4E8vrWt6nnDMMAmuGyKx4owvD
 mu1kU
X-Gm-Gg: AZuq6aJkZXeIi0qdrji5akS2d9rxl1id+xSgzd2UJtHTEo+YGneBTcx1H41ONJnJRqP
 jwzzFx78cmzZZtNRk2r3HzgPUlapyVwVSo9R/61z7+1Fl9vqxGYNC8Hgnh+CSwT7YJpcx+/tbmX
 2lUO5MGzzEKVYhMF7Ce5kihVfK6Mex0eE/1y2umip5+Osbmjbp4VqyQ9sWSKaH56xeGiUrHNL1U
 SDUQReA8N3osa32OJnuZE5kEXo7UaNMCIRNqk+qD2CLGrYasSVJnw747VcziLcZdtXzEu0JpSt3
 8Uz880W7DqFpVLnufiudMpUlhDjCBtpEchztdUIxh/QXOqK8Hcf040DdUQCO/aXCxGL7nnYRnyi
 P+CfzreVVtanFQM2b7WvKmu5AaWgUEX7ZVofPt9u03pWEPgXoD+kZJxpcoixHdQKaR8W2XopCAf
 uVblZqcq2OPi/rzPA55I7wvAeN9tSPdys+plwq9Tj6mW9o6gTDhibPXz2joFru8g==
X-Received: by 2002:a05:6000:2c05:b0:435:e440:f518 with SMTP id
 ffacd0b85a97d-4378acb17dcmr1679585f8f.54.1770848509448; 
 Wed, 11 Feb 2026 14:21:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v14 05/18] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Wed, 11 Feb 2026 13:09:38 -0800
Message-ID: <20260211222130.338797-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

