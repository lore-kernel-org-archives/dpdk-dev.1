Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE5E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:13:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28EC940676;
	Tue,  3 Feb 2026 00:13:03 +0100 (CET)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 43BE34066A
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:01 +0100 (CET)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-432d2c7dd52so5266939f8f.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073981;
 x=1770678781; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=Wo8KWWGSHir9fSLFGaItXWAcdvG9pKevnN7jkhcywKCk6i5NXcTJSPc+z2QmKQtDms
 +QBMi+T34HbcikI/QSftzW+Vknb6kNCvdOJA8vpxsDFQgAY+elcHJruDsx30eO5ALNre
 KZS6YUrZ4SyqPT0wPujnYo+ImRECxV6j806iBxlvXH3Ofub6PzJDyXGS2T0PrjVPnR9e
 xxtHBdUuNl/kq4NDnXDGF0frVdJoXv4IrKMg+ghR5XHwEqDjtGGa+KW7UahBDPcE1NMh
 Gytp1cVquhLa1IC7je1jupGEALq4NqdRseI/ihCZ9atsig77W/bkFHjzS1hfoF/IwRXA
 JeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073981; x=1770678781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=I+I1uwsTKJMPTQ6O5uOqo9NrZfyv90eg2IBgktATgIUVZ3V5aZmVIixG2lR+w3knha
 9SPmb8BUi/xEmngtkPmSSOAGCTShEV8ZYKogdSb4UoqF4vT0P76vRhDzH9ZFfaZgTvL8
 /PTjyqqAbe0dI0fmJFfHpkn26icz7qYrSb2Ap39sGaTrm+2AT5tebuIEQpm98Xkwkv4j
 ak61+HtMz/PPEVUtG+eOVuM51Guc/0e7GoYNpLB3P7LoaSP6vRqWNB4pcYwZIR8EefnH
 WjFvqQNS2ZpccB7nwKt4jo7ZdasgFzyotNbnU47OkRPe7mE9US71AFFlqjku4l15yy8g
 mdLA==
X-Gm-Message-State: AOJu0YyDxZdYWxCLSgHMpmGAARkDWbuTkk23/yD4IQHJFgP8rKQ4l4pj
 UG8Bam80R9OGAH8SHm8rDA0L5OHtvvRnPozAJruNSWW2Bb9hb8XsN4sD2YzBqaxQWaC+RlqwHBT
 ayslu
X-Gm-Gg: AZuq6aIeFZ5p6Hf4gqSKtOLQMxUmILSF5Rrw4HelLr5qGSoIq4Fi7YEjVPCAh5ILuMV
 GF/VD+p/5peaYRY9pMjXw6uf4/j4eLS5J+VqYbI5W/qunhiiVFhZdNq7JGoBhCJyU+XYnYTLbBg
 Ju3m9QNJkdGcjKtzAyg2lgiAOP/+pqewWSi8LwbiUdFl1KHzQvq/z4M2ZW8snZ+dasGBvapc7LQ
 Sbc7mhp3msjNQEjapdC5byUvWjrLximRFXg+jzBTtJF5xAMCzOuHBxa3nvmCuPdvELh3U/5reEA
 Su9pPte8elaWF3lVcf50MXVmoP9izQCYrqbBb9/2QJInlMaQl7c1TKtV5O41tMvK6gaj9pGVbmT
 Y0D9iPWCdh//3nP+8dQG4hIM9ukJwTC+wZXbSvDlou02bYfplWiNX67TgzEBoRluyb1M1TnEUjg
 GMWNbK7hij0ALoqseGxEJwXKE6iRe1eOAY9rbEmb4VdQcjAjZgaw==
X-Received: by 2002:a05:6000:2388:b0:435:a52e:7758 with SMTP id
 ffacd0b85a97d-435f3ad8627mr21569802f8f.57.1770073980864; 
 Mon, 02 Feb 2026 15:13:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:00 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 05/19] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Mon,  2 Feb 2026 15:09:08 -0800
Message-ID: <20260202231245.216433-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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

