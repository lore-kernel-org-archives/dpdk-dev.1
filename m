Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B60EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6F104065E;
	Fri, 13 Feb 2026 18:03:49 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id E230E4065E
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:47 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48336a6e932so7170105e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002227;
 x=1771607027; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=RfM57vIWXf1vRBbSDnEo8Wb4SDTqzGVFiW5LcL3Tot8y1MbXLNprFZOKtaO9QeyBH/
 QR3qYMZYu7junXe+lqOR+RQ7nAdDf6g/S2ySnYI4g8/0KUWCzChcCT6NIgtdy5BZxTyy
 VndVMK39ecyB/JL1bv5zGa824+RjLGP22linkQ9JM0JjGgj9x89Ct4jFJDZjX9fXun2X
 j1ft2JOZxdGV0z0GmIRT6j878ZrzHMNEiKZ/vEQiAUmjpG/8eJI/YOrrBki/lJIPO7gm
 bgNHNi+BMPDAanmtwLsmhmvbGXkZ3LUb+amyDxm6Aj4dSIU98IcRLMmP7jCzJAjc6n9A
 yw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002227; x=1771607027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=UPlRdcaK9PGzWo+ITjK9gT+ADdJNt8SjTljVxir1jS8TB2ON+uMYJOxcD7gR+p+2A3
 xWpgyM9xG1mDRtzlF8WJX7s3OuGeZGfd8iQynHXueBisTvN440t+/NPQlM2CRry0Zx/Z
 fole15ha2XRiWA0Vf1hgBumMFPKqE7FUz0gwLvXD5tVt84B1bAgy3GH0I27Z5KpOSkcG
 ILZ3Za5UXDlXx2KkHaXt4uHvSDl0MHM12+98rJFh1IXCfF41Pl1VlwFkqu70eEG0BkpA
 yKbQL/l53RA4MORcblum/EON/AdMgBIu6lrWKP+3uC4G5Glc3BczbBh3mq2ETII9lY1I
 YUaQ==
X-Gm-Message-State: AOJu0YyrOkq/L/5gP9W/Wnv7nG3KVsZv7eUt//ih+/vn8Xr78KBGSnO2
 JKzdzmChMng+dTAap4EbjkVPNZponaiJ2fzF2k0AwgfwSvRqqr8BkWXIK9NJR76tzqodYDoHuMO
 93Zi4
X-Gm-Gg: AZuq6aIGDPKb61U+GXY6eD9Stku+YlMM6IE0kcAqZ9JT/7S1KgKIY7PDuJT5YZN9lC5
 gJ42OFf3GHKOlkGgKjLcMT+G120e9ka06jkePI9sMfD6Ck71ytnSnbAqGKKfAWvyLVR7WB0nSoX
 LLHvCNLrv3d11oNaQW6M9CcuhzAXMf2j9ATdqWr9jSaZINCe+xSdUmesbejZot5ZBtyRNN4KdBQ
 /0esYSRYQfBQ2tJpf1m+XypW8gEvlui6oo8zdf43oFDAmVJdwPO1GaWvrZG2NpxLSnxuyM/Pg9A
 ILcz/XyvgBEJjl+cw9p9QO20uIaffIBPBSIwVoB2riXiP7Rf7OaMQiXxr5yvKVvLI/jCtYxXfuc
 2DCE63je9ZuxDUSoSsmm+QOONHiDUCPIbK9PeAFDljVnZm4zQpkLjq3wxMPJQtpXf4lYYP19GUW
 +rwD9mCsGH7oIn50DYhvFQOrQAr5e9Fv1zy6u7LfgyWteFD97+lPhtWuXu3f4SbJ5MW5llGDce
X-Received: by 2002:a05:600c:314f:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-48373a7199emr34470875e9.27.1771002227217; 
 Fri, 13 Feb 2026 09:03:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 05/18] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Fri, 13 Feb 2026 09:01:28 -0800
Message-ID: <20260213170333.40089-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260213170333.40089-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260213170333.40089-1-stephen@networkplumber.org>
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

