Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75970E94625
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC2654067A;
	Tue, 10 Feb 2026 01:02:17 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 3158F40667
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:16 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4834826e555so10751545e9.2
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681736;
 x=1771286536; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=ara97iqf2XRZvq8lh8C8T66wmygF6t7odQjLCGjK0Ui6R5sPmV7FNn5dkpHQ7Za1Lx
 lekYGCt/8kqVqXiXXoYNApZlPqMF+TvUP+5t26jaJmANbHZ5BVffCrXr+NvEihgWHi1G
 u9tNeij5wiQiQ02iy0aPNi1qWgewErQFi2pXH20Pjp2T7nU+mqRt35ptHa8YTD1h95rH
 DRbyJZ2StMEomsXvDCb4r2NIUpvacQO0tW6qHH66hungBmWwPBx2exonB383/TfmmTGf
 PpphappAVvo3Mm/sT00j80o1QubzO2aPYyGufEUtJA2kebzO2ajv+YPtArT+PvE74cAl
 w8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681736; x=1771286536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SouYZ6tU1paU16EOu15PvoChOiKXSP39Pj0QBhi2WFQ=;
 b=e2kwtynrLgnKlaOSBYLTWCWA+rs97BcdJTDfR98jVRljbmFAVjpj5v3s+e3Cw3FWog
 LyqlPqC3GZqheCNmTxmDhGrWIwe+sR8t/wzcfNfOEq1y/Fjd/EcHJWc6Ndbdo/zvVSEP
 OR3Mz0KTNje0FuZJFrMt00qcJ4MT2qzGMrvdhxY091+kBF28lvmiCRE0jadXi7UgLMm6
 f2NH1TORYC5XeQOe0YmAEmCGteFqH9cRFiJXF/hrFmuqNheq7K6LoedCFR2OsXOL9H87
 6u4TMcoY43V3ta8iyboTYffnfe6HFVE3IApm0y0UymEY8a0oV+AlEA+vPXvclHISGHHM
 Lj7g==
X-Gm-Message-State: AOJu0YyRh+2FSJrv9aRWlv/3VaShO17vxmTi36pL55z1ibUdjh3F4dzV
 hljtS7++ZTtxl0r0Pkp8eZQZtHGrOIrHQhxMlnWHlGL5qfH1Nr0IZIirEimAwxJmCAdQ+VBa2Ou
 L+FDe
X-Gm-Gg: AZuq6aKl4NTgz3tHDnVbOA7lIUOAHMz9oOw59rozz8kMPEFYOr/CKTTYDdezT/ZTnsn
 QHkPi8pAaHUUyfkyUipD/5Wmq44rWmv2tVgrhE6HTDTO0M+n+VK+ZVFDTrbcn7RZAKsQEZYnILI
 vrI1XrJe+ShDBvEIrHA1DQ7mksQ5MbpaZIL7YM6gXGxx5xvFiOoImaxeI6XhL/QmTSBRKG3ayrb
 qUGxGdU5tf5Yv3UVPNJiCoFZo8CaxqaoEUcO1sOnn2Gs0AqHVBKmCVR6jf6cGzDyBtZH5CBad2r
 gTr6j5W8lKPwwN6U/rTgw23u2/I4BptFF3rIXYtTctk4NkBFeC42NMkjm3fT/PJpKeCXeV0V0ot
 7mUHPMAYExlfkOxEVsRI2DbhOCiCEkgA6XoiNNEgI9NmQGR5djOWal36Izzy2yw+M5JOnIdVRVr
 YxkCaTy9Ssz8qLp94EnyWeFRADRW6jW8ymGnihKaF3MJ3r2Gjl6hHxtpInjngU
X-Received: by 2002:a05:6000:4027:b0:435:a136:b8a2 with SMTP id
 ffacd0b85a97d-436293472bemr18321451f8f.28.1770681735788; 
 Mon, 09 Feb 2026 16:02:15 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 05/16] net/pcap: avoid using rte_malloc and rte_memcpy
Date: Mon,  9 Feb 2026 16:00:36 -0800
Message-ID: <20260210000201.295839-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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

