Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA00F9D0E2
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2F4B4067D;
	Tue, 14 Apr 2026 18:10:24 +0200 (CEST)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42]) by mails.dpdk.org (Postfix) with ESMTP id 168A240672
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:22 +0200 (CEST)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-66ee7b9af94so2027628eaf.0
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183021;
 x=1776787821; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=C9VLFigG1LgMmHvBymNmGIGlP2n6UDzSpRZlJ+KMBmlnC2347HPJk0rXf/eLBpyTpl
 nc1SvsbdmWNAf3OTGOPytZnNfmRlb+Me/+RZm/j9IxrvRPXLOWv+zl+OOnAZ+rZYLFCQ
 KPH92VpY4Q+o3rQhxAB3LylOzljyV/RI4cpBlx2t08diKHp6Of6YS1ccZbViznjOclX8
 dxvGaFBJd0plebRdK44rT99aTmMYiSSUwP6J3eE5wfhZhQPPI8VrnYq1XCc2nKw1R4+Y
 c5ipw3tANJpod8nZx2lMBrBqb5PKSak2mPTZ7LWaItaAJWMzHDPOt4W+QfXJavtDMlOB
 9lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183021; x=1776787821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9kW4eQB60+d/vcWwDbCixqAra9SSywiv2rUWCPdWES0=;
 b=eBm0p+J+3QC2/l2ozQZU1+ppAMRE4LA2Iiv6Z1BsoVIqVBzcdMUiaCTi9j4dt8VQwB
 LhF7DSV5Ge3L+2sWPM1/1CR5vgkeyTHqW/bWanwDB2cAe9Vw8XXAz/Bo5PPlojNgN2Lj
 A65/dISw+zuHk1gwdZhncwJlM95jPBOd88Pd3lP7TrIhlOrcNPmLy76Dqp6TffWgT4mE
 lTzT64bWeOD3AD0JML384unvKo+PSqdNUAkoVmeVzXcDOWSv8CgBDLLvWJgebIlVICvr
 PN847J186AllhbX/vo26E/t3lDahKwUxlEa32TMVX6W9Vb/zr3B3AWqVYr37vYyoXzSH
 3dlg==
X-Gm-Message-State: AOJu0YywgGNwdR4B6uKp6ti6n01vpS7A1DeEcMpC+7g+sh/BOrOBpGAx
 PicEwNrlcOLDpNkF/YQYGYYAbHzCECyzZ/Iq725OCAkkN3Ye8weT8HMEH3VpWdPucRssuzFJuvm
 SakyV
X-Gm-Gg: AeBDievh0DGSe5+RVFDbB1zsZAaMimVqK6seybnIRFCUTQV9Y9eekhJvyQsovyryUjb
 906sdPtACFCarDqYDvZz7egSWoAJuytmgPgPNXZjKn1VAjqCPIzezLF7ygOCKdVlzaW74BTV6mM
 cBiSlV6RK9QNE0i0VFdXhH4oiprEpT/x0iGi8/5OjyNtUbQD1t9BZgGzsjLIVKUWcBdF1p88jhL
 j0t3vUd/x8FC+GSHpNQLgRRngzBUDJUsr+J58HEcr9g/YslSI47jP9t/nr0Igf5kaHZAU9WLULk
 wVvycIiScxPxedAxBXLMHQRYLDPQg/Ua3+Zjc+a38RDEv0/xWvm6tzRIrZJvrXGUIjWoUYqaXa3
 iQwQqwZ1ZRdcPEXkbbN7OuEIijizemj9bXDMyrAuJ5bhnJO5a+0ll0zUU2sAcdo71s9oq6f2rZA
 WWWV0/xaIl9USDwWNcDBb2YltqRJnKPf0W3RWcYtwzmcE=
X-Received: by 2002:a05:6820:200b:b0:68d:c575:def2 with SMTP id
 006d021491bc7-68dc575ed65mr6851733eaf.51.1776183021263; 
 Tue, 14 Apr 2026 09:10:21 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 06/24] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Tue, 14 Apr 2026 09:07:57 -0700
Message-ID: <20260414161011.756101-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414161011.756101-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260414161011.756101-1-stephen@networkplumber.org>
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

