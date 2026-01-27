Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616BFD2FEC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 573F3410DF;
	Tue, 27 Jan 2026 18:21:55 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 21A4140E7C
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:47 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so44941395e9.1
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534507;
 x=1770139307; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=vFSHL1SHdyacdHrL74SEJz6T+DqKrxLVlhs7m/g9Jfy3FnCtofGhOy9vQo51wU7N4x
 JVUWGanxYqAtAvoTFDSlaNQP71dnMKzhXOGXCgxemFEblbixyZ0EsrWFiPMTiuu1EAng
 ZKBffCbM5M4i3TIprbM7NeuT1+T5KoqZB2NMl1/xdYEioYjG2dWB8Hjryk8UwhHp+5Qb
 AhCZDASDf5IarrkdZ7CosPuHheYV6NlSzEdo1BbcXGnJnfhqUPHdgvh1c2EVXWAlrb9I
 grDi5BwBwDozIBxhrKiu3PMpzkoP51VOwwxusxc9eK0+yecZAxqUcatBYoCwSk2dQj2O
 Km7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534507; x=1770139307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=M7aOoWEXrTdcKEqzYff0sf8ljQuZuQz6wbXEixrgcODaRyw6EKfwSIo/HVn/6/Rlgc
 5wPDUQgj1uw8y3p+6opunglsiUFDoW5bvdSLRy2Qtr1wcdo4bgnketOGr4t+pC22fOP2
 /62erT69vtRO/VDCHL+S+OnIu1fhzxW+5FYo8AvacW6QbcBRd/e+89BYl2Q7U9Hmdv4S
 RDpybHyj7zqRLaixXBpbVNRt4izYkRn7Uo4MJJ2p/HVGzeBgMziWSTt4Cogc3U4ElGUq
 lHJOaZeHULyC4Ny8Aj2DlXiCPRgMe9bopx8lhbqtV7HxpKnY4rKiZAwq95tVUmrzJhyW
 bokg==
X-Gm-Message-State: AOJu0YzyF383FFL7RHENg75hqNH6RWoLgBMn2OL28dV3v7ApJH3x8hbY
 chsP/Xz1gri8wyxxfQKVG/Rvv9j2U/Pq+h6AbniqHzt5QMs1IPOI1+eLZ2nqwg2nuNVpsrqMeKy
 2pLfr
X-Gm-Gg: AZuq6aKmY3deyPE0/gEm9h0nyTKZjoJVdvy3Jpmcy3OrriYyEdlWs7O6RGBhovsbLyz
 Y6/PDB3fSB5WWUrfiAe0KeUAO6Qmec+lYhRXUCqa0f1N0KCdqkbO02TPtriPfHXXKFhjyz/2FMS
 2nqFRIdn5AvIo9j1zmAC6QJfZY5IyvI9vIxEprHIj4ND7hKLtu8ey20EIOl1PK1QCH9GHXKsZQ/
 M4lrgwik0yXBu+W3eWuSotLo4rLynC0wnB42dU00j0avoWFqTtRSz4f7ndvhSlCb/QNEEAzvsQ8
 sZ9QUmPUF4ANf0wqgg1tzT+r39DQy61Mc6yj/WATpDWo7tYRXDwJpHMdgsvUfpDIztE4XgNcoth
 3T7aHyZbn0o2Rowo4J1ZXcnyx/tQ1A9olmQ7ORcLNA4jPoMRFYxKJD1KDYe8mGpX0/UlohdDPqy
 sJUVJZ1v4KYVkZPk2gtr9hcQJhRvKPWFvQzVpH6hjtptWdsMdk7g==
X-Received: by 2002:a05:600c:4e54:b0:46e:6d5f:f68 with SMTP id
 5b1f17b1804b1-4806c7cfb14mr13437275e9.12.1769534506685; 
 Tue, 27 Jan 2026 09:21:46 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 05/14] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue, 27 Jan 2026 09:18:46 -0800
Message-ID: <20260127172128.124473-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127172128.124473-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260127172128.124473-1-stephen@networkplumber.org>
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

