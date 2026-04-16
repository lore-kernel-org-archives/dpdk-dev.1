Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1127F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:52:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF85240A81;
	Thu, 16 Apr 2026 20:51:57 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 47B7C40671
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:51:54 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2de831d2b20so4433070eec.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365513;
 x=1776970313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=h9d3llFXKaL8G0u215Rqhad7boEpDSUpaCP61xhqqXr/qR68QAg6VTXN1NL5h2TJK3
 dirLJRZU/dKh8x+T2E0cjYFrBlvCGmR4lrgK59ObJv6nGWv4F/lOAL4F/pcE2nv02g9n
 Whm0NgoVbfcYd/bFwRW7H+w4yeikzElGogukUbEV3q3hcX7K+m4IQ+DlNJScl0waC+Mm
 6v7Uw01QqbR8DmxovHWMQCR2T7Vk3HuYe4Au2IISwKu4J+PEATZKXgMEuuIAN91jNbCn
 f0yY/pSuk4gteDspVM/TEtw0rKcpYyxJb+VpU1foHfj+68HJiddmw5sisAPhf8pwADig
 pntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365513; x=1776970313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=VUMjnOakOZLkcGw1e3FLvII/sBlYjC0qi7utw3hGqAteWdEeCFMLgFuaPQ0uHWrUCL
 m0tupW9rjSXzGst0bxGXKprfk3+6sUh3Tz2rG+Uc1tu1c8FC0yMyXsUI72nbbL+AxVJt
 K3EnM+yoMHNzwM7dHxFabzTuOw48xfHkRplUEgZiQp8QLXvq1LJZG8MOqt33GpE56wn0
 A9npLX4L2VDabseg8eKeiF4IIgmvtbY2b3DAaK2l6THAoHz0UQhDouPQlAbcygzWBOT2
 q8EUsWoPlquAbkz+xojjtc0pinI93/jkOUvK2LkABrT+oU6T83JoC2chvp1gdnGKPext
 WyIg==
X-Gm-Message-State: AOJu0Yx3cZFDvjrLDfSRaKJwWIykK6LOK5v4QeXjQkNpHSymVRpyEy3S
 G5oFdVypp+4x73H2itampz1m/NMe8gas8L8AgCOXkKMn8s3cSNUU5WjpoAiPK4pnNxfre6eQ3Pr
 8PCcw
X-Gm-Gg: AeBDietpIEQxI/C26WX62RPF0avHzCgglsmKjNnnShdpEfAVMJVG/ADiaFiPVaEMC71
 qQEdL9ht0S/gJpMxlyx/CLctsuYwUm7vSZFua7Euz4y0lQSL2m3R5SMocnGmiXsXELYczUSTb0E
 wBzBPu4Kg/FJLo5HAuL8h2Gg+VjSGeY5C0XHmRnp5D0JCibechQ5WvQdeyqpdJBK0fXa4fYM9qf
 ggn9x5s1B93VUHgBWXDflwAsfn5ygYwmklTJJrlyCdFPd7Vzfcobx06clks6kZX0yczD3uO5e6W
 hZMaUe6PjMD98Bvt95DSud7WCmYREjuKOTYA54UCfX2W0z2iq3OZFktME8bEr22Ueioi44UAUKO
 +EWvH49WffyP1GI04GvvBnn6wHhYRk2a5j0DzGzI5XELQPB/57VNnDjIFCvAv/Y4WIuQXSLM3Kw
 a9Zr0G91rSKbLtxGlqR5+iZ6brG11d+jgyPdr9ysDkpMQ=
X-Received: by 2002:a05:7300:641b:b0:2df:7fe3:96a with SMTP id
 5a478bee46e88-2e2e0525862mr345769eec.0.1776365513323; 
 Thu, 16 Apr 2026 11:51:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:51:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 06/24] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Thu, 16 Apr 2026 11:48:23 -0700
Message-ID: <20260416185144.1359260-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

