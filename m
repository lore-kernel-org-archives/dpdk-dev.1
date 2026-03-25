Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58D2103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1527840E17;
	Wed, 25 Mar 2026 03:40:32 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 6E3A040DDD
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:28 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2c1092cc08cso2271772eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406427;
 x=1775011227; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=w9itN9PWSaAvhe8lfV7XV52vdWqOQm5gkUXZNVKnmxjILDW55833L0ONTGZ0QpAvX9
 pUDusmLkoCG/w6MGs9ruibomJ5e+ldAt8srbayngzRcTRF0xsgGRERBOOj5IcSwMDI13
 ZsMlAAawAQlwB2hQ0W4Qt35O+bDktFRuvad1pM8Z0/YlZy2XB4OvuTrdZo/M8LvXpvg/
 oWd8oCIF3QNgiIL3Zlz9RVZHuuwu1vbfrOB2b4tThOuuzeQ9AsYAJ7BnN+m17FlsMdw2
 /VMkRaYhUeZD4yK9AxUP5YpkPOGHZiIuuXsDaPHFSG5qgkV3gyKlPKz/gEvhbxTGGAtN
 0YnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406427; x=1775011227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=SDFYI5BIIbkI/qijV0i5DtqC/2RN3HqYbpIrs34enbIpV0LFKKWT78BOxswYSYCMPe
 MA1/B2fqtXDju7HsH1Jw0/tVzao12MyMSPXVVYeapus2cDGeuFfGhbEJziBRgDCWgFPE
 DQ2/ILiHVvLBIDAlFLV6EuuUrO61RmxQDbcC4Y4AIDGIrPNUt8pkS+A+GjkNBiLDnSLM
 0ykd5WJFh7OXya9CzaEjS3BkyT/rGzjfcRT+//XMJGifHIq+1WpWT5O/P+J1SVlH9fB2
 zzMTbF/JmOmQPnYC3QYoVbiGEbA/NfGWKsPj47OaL5SAQ/4EaDWfkaOYcihW5nlfFMsp
 BptQ==
X-Gm-Message-State: AOJu0Yy08XMJkF7LB+DgCLp3TIeECIvm6jxxEkahCyVbvypuNNFTC36+
 uzscEopS836LhHGF3NcGesc8iPzyuarWdgKgK6tVdMGWQzOr0Mt9IwHm7dGbyuYl0lNd/uyZD3o
 +UceU
X-Gm-Gg: ATEYQzxmhhkUTgad6w2jmBd63CBTN2FndApW/r5kyBaQQQDcJdpT9ETRmQmRvaQcFy0
 cmqfoBNPjYt9QQoHNfad+ebtpllO+jYZMlg8tW4XOxso1yxNsWw7gIOaBky6dQzABJPnI65u+eG
 YnTNp/2SKOtha02G6H7iP4cfgjkQsnd4BD6opIpVAYSSVxKbBagD6dFYsiSI+4xMC4MN/DqnuGG
 ULXk2gynUiS7gNOTwTx+OvqupmzA4iJdc2fHqxue0vx+gHg5hq0l3+itBpHiPjF7IKbQy0X6H8M
 lp45xw1oNJOffTXTk4r2hVQNCfpuRARc+6VIm4pdFy72ItDWvNrL+Dvzc7RA3NgGqRN8OgYBW52
 Uv9f/LRFXp/nGS3oR5KuyA+l8twrUItKfnboG29DA241FLFEQBGf5mJJf3m4M+yUt4fHCuq09a7
 I5+FjyrUPnm0MaIeMWbXiCE3XLUog5Qmvk
X-Received: by 2002:a05:7300:7ba0:b0:2be:e4b:60a8 with SMTP id
 5a478bee46e88-2c15d31dbfamr1083914eec.7.1774406427449; 
 Tue, 24 Mar 2026 19:40:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 06/25] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue, 24 Mar 2026 19:37:37 -0700
Message-ID: <20260325024018.1275209-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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

