Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E22EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:11:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F75A40665;
	Sun, 19 Apr 2026 18:11:14 +0200 (CEST)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44]) by mails.dpdk.org (Postfix) with ESMTP id B5B1E40671
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:12 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso2239464a34.0
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615072;
 x=1777219872; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=UXn9Ixu64z5WWEIrPbfc90PPp4YJNaZfHbBipFn28ZL63t9nOLYl1o9qUKUgg56VmO
 rlS4YtNell3Qa6VXBqWI07UbKaXEyv5kl0r8IZ5KmNGr1ozOMzvJ9y+agFA7wg0jFM5E
 xMsWp51euVD272CvEx8ZMnDrb6GMgsMRYStlQMZxS9KsSNlJbgJZ4CGnDRsFxqMv2h/t
 lnYNgUir073Hm5yHVtg8ICBWnzBh8X8kJkRv2osy3/ODCDy8EpcBcftvWS61pkWmlzmf
 xo4ALi6d0pT9cDfjiyn9yu+Qyz7xUbBInbQEYtxGitYqPZ208obxp1/6S4OFTB9Mv9Sy
 RynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615072; x=1777219872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=LfjnXsC9q9rN31fBpnVrg5WalIhpfxthQfPi9DIcNj7RXMcNsaaR+jAM5BXACe+zKB
 bK3vpC09bnCNlnxZK+E4VHudxAz7+uHKPz3I8PabRsLaG0ToL4TKmrkE8zFBHtQ9cGsj
 CNAU3wIA4hUInG0uj/8IwJS29Ee4TY/Edqby3XhK44hypjLv7xU9PSY21yiG+4lr/zxv
 WiFcK1eZXNIWPfkbM0fqGETj+nbHi7tQLzW/nlNlsSpRp1iKOAhV2XAdBZLmDam/Utkv
 exzm+eNjyF+G0/tvCFwXhVEMv/IkO5iTxTIIC+nOZUDNm+Z16PQr1f4RtZZlSDnIrU15
 cQsQ==
X-Gm-Message-State: AOJu0Yyjml3cqF5WOIlqUbpLNxI2WZhm+FePQXd3jcBcHPUYdWCREkip
 8WqOhp1n+73z8lsVj2U4NrURjjRAVnmrxK+pcBaryWAPInNwTi0xTwykvgpBZo5+awF0kXTg+XM
 Ir6Ds
X-Gm-Gg: AeBDietpLgpOQFtmrHBrVb4QENC0+C6uT7nDDekO1c6TIHyVxXUMY+OJWeicPg+278o
 F2K1sv2bZD9ZS4Cf+0aWNQBav2MCZ189jaTMqN31Eoyzh4VNKpY6VFqdMcLRxyjHEH8vheUFRvE
 aML1Zm2S/GNuVwMn9g76y0+iFufZirFLvwIJLngmSCptv39Uom6LKLp9Cw/cin0L8TkACWQWwOS
 AYe07y4B/qar5k9CElZEtPFefMPWYQIHM9L5eShaBja/3Dl+hYwmYH9uQ7K2B0UJaPoFWb+8+yA
 6MOubqckJSVvDya8/8QQIqy53XqFiuI29k2ymkUqc7fD29n2A2GDH2sv37UDxUpeS6FAYGeXDqz
 HSwjNLfak9Vg/B6UuXAvhMYzIo1LFfk2IlWJsNn9vlMtvt9bho3Sw01uVJuFv9KjzQumXgoMcPT
 brkSVcvSoPaDOmabtmNk1ccSSh/kRQaoZdb6RPnRd6POQ=
X-Received: by 2002:a05:6820:1519:b0:68c:3af3:6e71 with SMTP id
 006d021491bc7-69462e51d1amr5862645eaf.13.1776615071922; 
 Sun, 19 Apr 2026 09:11:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v25 06/24] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Sun, 19 Apr 2026 09:09:39 -0700
Message-ID: <20260419161059.205954-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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

