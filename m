Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4DBD19502
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE23C40276;
	Mon, 26 Jan 2026 19:08:30 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 3A87B400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:20 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-480142406b3so32539735e9.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450900;
 x=1770055700; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=DqepkjIYI5coL8hWYxEI6ZmSEWyuQV3s+dt1IdOsiNaVdcaqE/3s3U9mF4lmSeUT06
 QqsrT4DaM+ayMWJhT2QkjwM/Wa6XpaTIklpLQzRmphStaIGxLgZYNNAlqgHucxZtX+vK
 QGIux4wsjP3RCNzUlilDrdTTEiaL3XYeqoA+Q9cupGm9icprfEKSlvgX6SJ++FBTIu+g
 d5T6DKxVerg9gdxLeF993IvrykCAgd/E+NNzi1edgnGzsAWLeBhsuLiw2prQQPyJ2KKl
 XLinRUj1C70KbNOSLo2uWtq7BR1s3HasJC6y2FEoDY08T/enN/FObl564BRRyae6gVi1
 dyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450900; x=1770055700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d+2pdC8OZBlT6IhfGePhTO+ED2DvkYpouAYL3N69Bog=;
 b=FM3C/2CC59CuI7b7I/+CKJRjd6wO/vhiaQwIfXKTznpK3FId4MID69wv2PMWKOAhxE
 76UhO9aAYMi4UQ8M1Tkgd+4UU1mSlBd0iT6jAm+InW4XpNsPSzNBkwuIB2J4EQh86bPX
 N3jcM+A+v3EuWOss5ClvTWoCcbG5Fcszr6bd/byFGXoNOsamcCYC+MQRIGrRzshHlh6K
 +/1RfqSny69L8xN0ut6T+ZC2+tuTy//Xjk247f2oFclHPtMQs1S/bLlogEJzlAkHhPYP
 MJU5B/Ef1rLlLYWTnBFOTp2Bq3Sxy8a1nhRcgfd4Y0ydXdz6A4BHBgfzoFfisudJvHBf
 8E4g==
X-Gm-Message-State: AOJu0Yxvaj84gRziCllLxpmNFhJVkQqc7L3U+5nXlF1e9dlHQEe6EWVj
 gf7e4HTxhox88yGOk3fkvU+AsbKd330GxdEb2jhqMrEd1tdbwlDm39FlllhM3cTt3r8nld72tIX
 N1+ri
X-Gm-Gg: AZuq6aKL4BzX/dAfvVFDYzT014rGjnwnPDkQNoo5M6tfDa3Fpx5t0sH9Rsi4egJdm17
 76GL+aFrkrFi9yNxpDeVu1XJ05UKTJIeQkR681DRGR2U9RF23SCUs8ZOC0kHpFBJuvYGmctq1SB
 +sHv44zcFw5zfcti8oTDva+itD56BK8kD1mMSE4uKxGb0AW0Wd34OjwEWMmci7AF2NPWbP6ciwS
 pU02biBDoanjuxzJxVRRbRnUMrL3Z9dgQ+6+VYDQxSX2ypoGIKLpPm24YZHyQkMXcdvxAPW01GP
 lnYiAxmT4K4ohNGPP4bGCSVWQl+Y4Ef+Ndy4HDjQBiTaEQCdFCrJnrp+o3KHVmLz9rSIpykHgzY
 egRvf9p8O5vttkU7z5ijlaBRDgwyVVEjxyEYJHawnjfEVJxx0NFbUz5t5djKsj70GjKDjS5hGpR
 oQ3TNwBP36taauTox6Xm+wENGD7TAtR8QcxDaHRFHzMCtoTneH3w==
X-Received: by 2002:a05:600c:8b0c:b0:477:7af8:c88b with SMTP id
 5b1f17b1804b1-4805ce3fa9emr72589735e9.11.1769450899796; 
 Mon, 26 Jan 2026 10:08:19 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:19 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 05/13] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Mon, 26 Jan 2026 10:06:42 -0800
Message-ID: <20260126180807.100891-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

