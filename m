Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C32C54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:49:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A48840670;
	Fri, 20 Feb 2026 06:48:47 +0100 (CET)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52]) by mails.dpdk.org (Postfix) with ESMTP id E4E2840658
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:48:44 +0100 (CET)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-896f95e07f5so13693286d6.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566524;
 x=1772171324; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=rwWzO5N2ilOr7Patxo5a7POI4WWySHrK6/0gP1bXDh2nOEGxGX6sIcvdy7dMQEUcpb
 1o03ndfFeMYvzrtNQ8E3m2S5nWV7DjxsYmhl3v/s5unyKxb1+LYM8Vx3CUCYWrY9K41E
 sacvf0Iy9xOPLG8mbagzl10X2GtPvlWyJ95Ya4t/DSigtTNhCOnK6u6yTj41OtNMtf79
 Mj7Z6AiQ++rdXqixiSAzUpF07tIjNTF/MXs+vXCTyasJDGxeJogiPgJ8HmCUadSZBOZA
 Px0hu6pbHCVocbPoqkPua12gGFCykZde6i97mhtLUn5VDxQeOVrHEVlAynidhrp5DE3U
 b3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566524; x=1772171324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=B5NJdtvO3hLjw0Agkamqr0f8K5XIjmDMgMcGGt46fPc6MeH2C7L5d9t36oIsXRbAPw
 Iv0yMsN/TtrDGQTHl//mi+JcQht1fW8UXK1BnWVlzZtRB6n/eZ1/0QpsWXh9IyEiYLF/
 cKaqpvTs1bIDvp2RcU2m34AL3bTePidZMnxF6MF8RnpDUb9Ohw/Nqv7k4VejdUUXXQA6
 0NZvNOwxexsvwELSyk4BOzPT6fbgs6f8drR8iXqhPQCYxNd/CnGQH7eXdr27SJeDfgVK
 GguYT5/VWvZhJIE9wS7d5tHhyAN61C10P6gksKmmXX73pwuJoAgPv2UuE4os0zBFo+If
 sP3Q==
X-Gm-Message-State: AOJu0YzXaDhJbzX4uthFkKu7odtVI4xWdcgbxcZIIFRqCuxhc00vcw8h
 nK9EEbOhwCWUASdBiDwL0YOdNmXgQMnkGrB4xtnK+9LuaRe+3x8xr7PGvNk137oVH5G2KLGoi5n
 Ih6rm
X-Gm-Gg: AZuq6aLD/pmArHR3DqanUzrCdeqsXpFN5YOIsoGcc6vNM1lvJeu1s7aKIW0gaqdOr7A
 t/2I18ieXTq6i4gmzkUxspSBN1xHNAdZqNTIJVB+HkLkOFzytyaoiON34Ic1JHtOvGhVW556jk4
 eggwpI/drc0KGbx9946rBZGGglDgWqLeafs4hnPdhc9I977nHyfRyVaMwtfe/p76BSbXOhqVhnL
 MOrJhj3IfzANUARtzmecQcPo+NAsw47rRQT+zLeBeCXd8XjUPO0H1bhUe+lbm2Qi31LJUS2Ndzm
 Pt/1St7XCJehm1xONMGRnNi3FnF3k0JcYvJND5uQg16ytzQ7kB1Yp63EIQBXsL4ac4mMko8B+Jy
 Fw7vMOc3Qc0Dy4vHmCdsSOxYrnciX+MT8d7mtPya2JJv4lOZKRrdhM8VQiF0ccJ5sUVkAkA0nA8
 9/qDeJOxFJrutpyS4+/4Bq23SlEWpbKMs3rd+IDDfxt0QS6w0BcQzUKNBh1KKELfJ+B0VOwzRJ
X-Received: by 2002:a05:6214:400e:b0:894:707d:d1e9 with SMTP id
 6a1803df08f44-89971a2c8demr7565376d6.44.1771566524205; 
 Thu, 19 Feb 2026 21:48:44 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:43 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 06/23] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Thu, 19 Feb 2026 21:45:41 -0800
Message-ID: <20260220054834.1632201-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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

