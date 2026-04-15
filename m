Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9372F43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D9B54068E;
	Wed, 15 Apr 2026 16:48:19 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id F37B54066B
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:15 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-46fb6d65c28so2385227b6e.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264495;
 x=1776869295; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=Fhqo2FaP86367f92Tm7b5v+kvC1M6ZI5ULKLjtzLy1JFQo8EYWIETdZPVc4GaXvhg7
 10DfsqpUxGpUAGmYm1Ytj9HEIchqBlmEfk+k05p5XMvtssMf6Z6Lw/IV1B13cW/JGkpe
 udD5903gUxYkLdsLqppwxGLojSLK/7ZuXt0OWe7tRJIL6d2fsUZPZQ68QORlX2EtsMKa
 bM4onkIpmMk2yxXPPKIemPLUwJFTr/dXjmCmCSUxcq2UjL+CnRm4oFsiO6TTZ5CNmFlM
 8RD+3R/LGpnliJH55MKPv/MvYzzNYAUxGPvlWIRAFeEcvRGaQ/1d9sS2hjIoUUcQKSeU
 brFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264495; x=1776869295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=ZKS5I52PhKjOkIg3cezUYbBux4ZA9fJpVcucC9JURJ6WD6w/y4o8RqJNxnaSMiBFsR
 0SBogG8AJpx71wv6/B6Rry+wRVb81rj5SqWNBd3OnGusccvHkmddBihiRV13PY3m+7W6
 VCQcxUbqcNQxePm0HcOTyjnQnhXUq8w7e6rc2kR4utXn3qzh9fSZlyS9Akt2Dy8oWoh9
 UGNyd5w5p9p2LEsVrdm8oZKp2PiQg8JWEDWjgDCiqaPn1IN+0Bo4f3cIrEgV8k5iLwm7
 YGyN0F8PaWFAK9YLAv1j9iSSOb1mS970YT36Ah8NKDGiV5GcJV/YRJ3SCEVqTnPI5N3V
 ybQA==
X-Gm-Message-State: AOJu0Yz9fMypCa0sDTiRGfNdcgtXQaEubLUcWKv8bScvyP0IwPAcicCL
 jYi1f57/kt6eAYhdlDILfDZkKJ21CMWXtheIjBMwtJMZnvztl6XJD7O3LX4v6S9FSj05FXALSxa
 nOoO2
X-Gm-Gg: AeBDieukDUUvXkJY5lQ5RrKh3AE72OoTVbGTMKJatgwHZY5uYT1kiyiF+zviFIwPyqo
 /dRMGEoSeUyuxrVixdVG1j0Oe0xeMfLmkOOhqfsKgUct3XnfrW/NG66zz5YkQz+PM7OEfoX99Wi
 6RyvrylSojhnbsqkoF6WfrNmVbmFArvX3q+wfWjoR7E/u1K72lwdpgfFvDx3WdJqBhOcUrV5h3r
 HIbNu3YW34zpCqhQuQAFBq0MrGy2SjUxlGdVdLhPz1zUCqne62U3z5GjqaTtom9umbBAwW1qISI
 +XDF0+jGkL2ayJa5X6zbEQJzQi6IS5UrascRPZU6O/CLsp7vtZuPuoKwY/8BfPRyECo/NuNyLUN
 JcJ9AsRfFcQ5skLhDt2VT4ZvecnxAe8BdzlPCRW6AbryWUNeIsoE+aY+VNpV69weBaGMMrUcbWa
 Eyhj94JkHz+9sipQHXdaaj4mgOhhzIAWzOzuA/KRVaIyg=
X-Received: by 2002:a05:6808:2205:b0:466:f57b:2aca with SMTP id
 5614622812f47-478a101cd8cmr11204867b6e.50.1776264495205; 
 Wed, 15 Apr 2026 07:48:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v23 06/24] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Wed, 15 Apr 2026 07:45:55 -0700
Message-ID: <20260415144717.226161-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

