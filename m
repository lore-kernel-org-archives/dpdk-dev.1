Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFEBFD4F03
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DEDBD40E26;
	Tue, 10 Mar 2026 17:14:09 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id D82A540E16
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:07 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d75371d873so2177461a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159247;
 x=1773764047; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=p/wwtHEUibuV3ZRfIXIfUTtkdNWxe3TgnKKDIOznqskt0F5YGWl9N5inX4fNJd4ThU
 p0R7F/8JTA+Q15vUdFEhx165TKW4usC07O1mapFnspHFeHRt+UgxzHfX+Lt/qud2M4pM
 UQI3IOe0CAxP5G+JInRY2jR5shQD49cBJK/n02hrJcbjj30PnF4KIvfEInFliSvo9ref
 JBKm0cRGnxDqVBonDlEXc9g+5mjuLZF080ETuh7E2+z5yLdP2+K153QFJE//6kREE3Zc
 ooILkDZHcJ0/ZAsQ6+nTcrqESakdJviY8rUdMJHwrjlB2Jtdwrj7fJrlSpJoiYMsyd5x
 HFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159247; x=1773764047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=YQEskTfnsE8Vhc+MglhLNVa9g6RUKdtxp+LP/AFR/peWeWDzc23If2lAVF8kYAlUpX
 eN4BUO7RGdqFhIaqcHeYwJWOv84Z/EdPUn1EBSitmC5PIJNAjn9ZcLzhWP5VUFKjbBW0
 h64OA6dB9FwYzhi84cYwJrAElsgtUFcbBHF6xZcsp5OfH2V5EW5+msYBoEcEj6whUgdu
 bf7VURtsXS0EReOAKnzoeO3xwTktEZKmOnTvEflUhcqSluutlj5SNrORopmI1WL5c8dT
 pBFAk1uD7xnwVVOg9RV1OQtbQdmvpaQ5qPwH18X3FDdVkh6eYIVAoRhAfNtufTN45cO4
 eVvw==
X-Gm-Message-State: AOJu0Yw4vd3a7W7KNhHbYZwUoFFWmVNmfl6mrwV89GY/JMForC3/VIDe
 2PwXF/3fzK6a4OwU2bM2nJQOfoPG4xiK0M03e7435VAdqLYGfj38XOzvLsyM13r9q1kmy9t/3K5
 xmtigulY=
X-Gm-Gg: ATEYQzxB+a7dZNd1PXy9dMcK9Y6rqjgg+c3tNcJQBuA1FB76bXKGigdemfMi18Vn/LN
 JojaO1Hb5x0gZ0ZboGbI7IZ3UotabHhk39KLujABOP5GYYVOg01RMyYdTwtJomnqY/OQVJ0kjx1
 k8J9KRvCs6pR44KxLCMoFwBS69BVRQiTIv+4EdNA5uCse/XYpMPf/30/uohKq5myheFiBTwDmIA
 U7fcXJBoCI2IAr0IQJkqJkJQZFfVI97hItc/miiJvu7B/Z/jQ3Nxxhm9i3zgSwqtV/i8NhzRWkG
 zeQ5BGUFoFyv/1uCNEgPeXpS6tvZhlR99dR8dfOGCzuFQVzCXmRRXnhMK9lugYK6aV6x0N0wnrm
 +2Mwv4OT7SWiDz0P4CHdGjzYj2bJSaY/7wSrGfaIDlTzilWxGP7dEQJ/EkXA9B4GLNgnpXpdJO/
 E7TiT7BC9gh8GktPZsL0t9iLc69n/gmTZa
X-Received: by 2002:a05:6830:82e7:b0:7d7:4fc9:5204 with SMTP id
 46e09a7af769-7d74fc95a17mr3892566a34.2.1773159247186; 
 Tue, 10 Mar 2026 09:14:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 06/25] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue, 10 Mar 2026 09:09:44 -0700
Message-ID: <20260310161356.194553-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

