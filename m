Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0998FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:50:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A6F40A72;
	Tue, 10 Mar 2026 03:49:39 +0100 (CET)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52]) by mails.dpdk.org (Postfix) with ESMTP id D6E82406BC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:35 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d74c1157a4so1546469a34.1
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110975;
 x=1773715775; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=R0dR2Wyu2oquU9sI6f2PSH4HPF8AJNrDgHGZizJESEwaHwxrZrDWnvOz/wx45KFxLW
 EjT9EMlbkl8N2J9ppFheVg2bjlOdYbjsqTwzt85ZT//Ak8NOAlH/GYKblI3c9UKF9SY2
 MY0egD2FwG++7TMVAibB+VgCo4FKRlqhStHzRvD6KqSuqDysnQNs2uGYhuReO7gw13xb
 esE7PnQyXpkVt7zEQj4+5H1zXtJx7/1KOThycUlYF5RCPwyE7bbzPZt5gP+44LiVBqod
 6nlWXyPeQFuqmnNNG0xs1TiCpU36Ntbrxn1AamXWI2mEnHPVp185muUFkSxcrBH3m7ov
 kG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110975; x=1773715775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=mBzAmH++u9CwGvigGiUa18sLYPu0Kg5RGSzXMm01gWooXtrSeGkXvsWJYHaBuLB1Pv
 lQqeKJ6KKzAcShCnduDD+0nnk3Cw9RDVKWLe2yma8M8Oae7UHMnYleTREHtdqcMaYeso
 2XxQKWJ3nhi4VodxR5hvvrPzQ++wgUoT97tjvpW0ChdqvOmlmvQGZJuiAh+3z/xvjt5F
 63uE3G+jSYMixmdP7DGKB8tbVtkzTC47Gq3GseNuyKjN3CtaTsoHcoKVS8jGW0tw8Xcc
 nowJX7eDmg7KQh4wr7XbMKRVMzuyl6dBd89Q5d/ckJJnG/9FAZFSbqF4dNpvO+OJud2S
 bIVg==
X-Gm-Message-State: AOJu0YxGf7PSiqPDg7qqnOr6Sd++L5FcPP3qeXGr40Mol5pxEwJFvEuQ
 tQ6/ujPQp5EzSbsQaHDI8B4I4PueFrY3x1XG4GQVm6roioQ/k/mX6rvCKKSEIg1gZ/AzHAutqE0
 ZpsKFa8c=
X-Gm-Gg: ATEYQzxPd9oQ3KluQsjFVivp2nbRqh24+mpfpE0srb+WToRlpBvWGej8Mm0/tyycdPc
 lx85UUirdcwrd/umIA0oenP4YwxArTYJPq79L45ZQlNqbuH4TvFnww7xqKuLFgM2yHECT2hU6Uc
 +31pTeOOll9kpGogp+t8itTesyVvu2ze798VpU9w8hrKEL0o7f/wFtGBiU8ebFLPXazwUlGk72i
 RHnt3ul+/S6Ai5liawFZLwHWyPSVow7vs/4Y36nPJw/jCs1ikfJBppzOf3K0qD5LoCeAV9DNR9b
 9g+oWWLik63RBD51cldNSaFqdYI5bchSCTc43TyTzJBl6zXUM7m0DxIbIKqRQtbdTKg5fypjJ/P
 UeflmG0M45/PBrKOtMwJjBqf+KpFfb2llWwnhWjkNYlMDQtimY7GKlNLYC2A6H2W31zcnM5vFZg
 vkYLmkjCzGH4Td4OCh8X5aTfD3fXAt+/dZ
X-Received: by 2002:a05:6830:370c:b0:7d7:5d66:4700 with SMTP id
 46e09a7af769-7d75d664d5cmr356546a34.3.1773110975213; 
 Mon, 09 Mar 2026 19:49:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 06/25] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Mon,  9 Mar 2026 19:47:41 -0700
Message-ID: <20260310024925.476543-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

