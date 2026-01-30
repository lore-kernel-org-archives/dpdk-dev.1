Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55CE6BF31
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Jan 2026 17:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F69840668;
	Fri, 30 Jan 2026 18:35:14 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 64AE94064C
 for <dev@dpdk.org>; Fri, 30 Jan 2026 18:35:05 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so24910135e9.0
 for <dev@dpdk.org>; Fri, 30 Jan 2026 09:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769794505;
 x=1770399305; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=lIYDyz/VN7nPIVyKJQ4j+1hy8mI69kJUIt+EWtq5WoPOn9Fl+RfRPOvNQ5yw7fT4gF
 86yPTdFkBELi1xQcpPSellCjZiPylDU3hnZT0bKud5lSuP3jvy0zKuY0dvp7OF9M3fjS
 UhkaupTHUj/+7vTqEiOypgzFxPnPJt9tgJ7+wjaPvFtpwDm8tTe5B+z/y11ZniumxpeP
 vx/qFeDE15LXh6VMdBA+GQOEMIMKIbMZQkUufx07Wx9iSza4pQVlHE3m7iuoazx+Jhqy
 /kW9zXwabQEkehzk98EPFh02qaqw2AJO7QC1L/MDyQV72rjWhV4KTje6eCez4u3GJLhv
 cgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769794505; x=1770399305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=Ni8F5xssCgyBFiSjVEyIqULT5LNnMdzDXLJWYXYbEYGAI/rlCLLGpjdv6Xmp/Y7urA
 HC3cWUc7+3++ywAi0+MTlLgzbvGsenbQsrzoB9chyobXcNff9NPq1Ffm70Xbso4OiYl8
 DNwGFA/lhljk6sz5ujuxHxElcKLIsNqWpIa9oAI63fhPviZQyJQ3KXLOMzs+7vDrdF/0
 qeGDoC4i7IWenrWY/1ofKhM8VYXjXO1ULfXvdWNiFuIUxpEmGTASHkWlhJSC381BThnw
 zTDmCmZvjnYY8iMnvkSIE9jQysg1VgWVdpNs5iHU3YrH+PLSXHUbgqet0DPY6CExR2Y9
 wvAg==
X-Gm-Message-State: AOJu0YzEYE77xVc4hVd7uEvTItG1l5X09X2vbsd08s3UrVWCTmfsMxsX
 nzbfg102R5Fq36SIHiJAiE2k7/UoCE/FOUKfKu7zPlg5bR6CnnG9C6DIh4vME+XODUDguhIIs2A
 dsD+Y
X-Gm-Gg: AZuq6aLYhn+opjMt2Ga7BvWnEqHiNtSpOaG1sRIc1nV0uSNA4mRtaQ9a67AKWH+mGzY
 Ms9No2+SVTkIVlhBL08Eay5Le9gh4ZMCx6ZD7Gp2RGjFeAy8hCJ3AatZMqL4tmXAeeFU3doWoMP
 Mrp/nBgEGhYgGJOrkOrdhSgoatG43ivkGaBspJJzDRXuDRUh5q9FKSqNv1Uhrd14sRiSZpfPD+c
 1Sj9CgA1AkvMtxggOjImo2MmuscFPaQE0ryQKL80hF7OvOfE3Di3a1FLgu/O8FRYxbvMSds3Has
 Siabwcq1HYtTih/w17CVJRxwtTLygdtBU/onys0VcUAZU6CVfdxjQhUNpD+fznVFgcks9Vaio4X
 2Ip652YC8hJQQIdNoJPqd8ymNWLNk8pUV4fm8R3pBcywH0J/kswE06Jv9Nb4ChgQBz0fJrj0D+Y
 ozjN3a4rv8C2S18LLc2J0xBoCjEg7rzYQHb/Vv+EFw1VmCoGCH/Q==
X-Received: by 2002:a05:600c:820c:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-482daf1816emr40743855e9.0.1769794504862; 
 Fri, 30 Jan 2026 09:35:04 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm201085325e9.12.2026.01.30.09.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 09:35:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v11 05/19] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Fri, 30 Jan 2026 09:33:18 -0800
Message-ID: <20260130173447.14546-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130173447.14546-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260130173447.14546-1-stephen@networkplumber.org>
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

