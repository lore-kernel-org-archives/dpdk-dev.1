Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C46D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8820140687;
	Wed, 28 Jan 2026 19:41:48 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 63B2440662
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:43 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso165441f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625703;
 x=1770230503; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=RxMN2ZzU7RPLm7HY5yxrAG+s0nGxN5/YaBtJGTbtqW90wV+zxDxvU0b/sy9X9mjquz
 oobFzJhRi9NurhpSwDmGE2ZE9YSXX917p15ymH5Oii8HTG92UyDqE47bW/mpmepFR7iJ
 qZXbJGVClVNraitnF9zWJ564OzZ1eRxSZy/WJwxdNDIqJKz8qY5/kYcAWC7Unh9G3COw
 ZgjjqfJ13dv/mCMhBegAawh2P2rqoS6RtrrqKrd3pBAGOi/NmnoAdIcnorVcsoP2L14u
 3IkdXqrdEsz7tnYwlurrqernUZxrj85IG4KFHvA2T/UxceygOFwrcCoF6rDeqR6Z5LNo
 PDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625703; x=1770230503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=OggA9lH5gu1w6Zuzppf9Qx9VmTeSr1el14vQELkSDAirStoE6jiGeTb0iOGnXZLWPy
 acsEjmrfxXgAk7n7wDUy+AdkWTzQoCBd7VhxZ5QZzotJwjlApadSEH0SPHilYcCXVmh0
 gUh6KAes2na5fut5h/tOVJaHFngJf784MA9rXQC1AhifGju2kydGED5DVyv+h9asPTYb
 AZEhkGG4SCb1yXQsbaQCCQONUR6gIYL0a19SPmPB9KOEaN20gSoNqog1tHeWYvtojvYb
 wE8IFUP7rUoaHAGn+6cWkwagaOyVnj5iH6jgAWeL/esthIU5Qfv9CH3mFYv/3ofuuth3
 IEOw==
X-Gm-Message-State: AOJu0YzWdeCl87Z2w+g8h4lDZKgIn/ono0p74P6oc+WYxpNmQzud9rlM
 7ZON5ttNkQma9nEQaYqNuxKM+yS7PFGlWH820diigRPXq3zwbvU2azZDPwCsCBbbXW1sDut/MYq
 lbcQW
X-Gm-Gg: AZuq6aJUhn46lO8R0A9ORPhrbD+c9K4ZCIKe7gplG8h2sb7d1zE0G3Sx5mxNbYd6bJk
 dQA1TGbVD6fM26z57b4tUI7sLr2O8a06GrDp/QMQ/BapLpzmbYDn1gkrMbuFRaEaXk3QCgiFaaH
 xDtDh7FNTrRML3dEC4JurZw4Wvdc2QrTrrHhIzzEQUXLOoD/TLT5esRgm+PEZSmHtiYfXrFUWhV
 K3hRIeoc7zTIXt3YnVnkMkPl4iQdltkmHkZTd9LD8FnmmIjwAr/QnhYhQ6e70MzUZ3pye9Sx/gW
 WqM33yFg8jTVEzGAEkmB7m1x/J9yipdVSwjkcDi0K9Bl2x2uANqPWLsIT8JOHsZKVb8HTNIL8SF
 2/I9ve6GRQZoSnG2Fw92f/ogrNTJOru4Xhlx8JMxzqzGF3DP5k5eoRXXgo/O+AWto/7Yiiq4PY4
 NGICnFBEpe4ulsd7gcxhWnSt72vrFcagNuCZvR+lPHDKltE+RKKQ==
X-Received: by 2002:a05:6000:186e:b0:432:c37c:d83b with SMTP id
 ffacd0b85a97d-435dd0302f1mr9364844f8f.20.1769625702923; 
 Wed, 28 Jan 2026 10:41:42 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:42 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 05/15] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Wed, 28 Jan 2026 10:40:34 -0800
Message-ID: <20260128184130.445567-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

