Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303EECEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2AB1E40E3E;
	Tue,  6 Jan 2026 19:33:36 +0100 (CET)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51]) by mails.dpdk.org (Postfix) with ESMTP id 2AC2040E48
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:34 +0100 (CET)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so1789597a12.2
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724414;
 x=1768329214; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dHBwfM/yA1uNqJKjEOOt2JFYZzd2s3vZ24ZhhWuxDcE=;
 b=hEYxk+IjQQSF+AH05VTo4biQ/5a5COn9QGOJrSAJXZCDmOSHktZGIP1aEXu+JNsVMu
 TwzPQpPYmX1n4HpJ7KgluQDudfFdkt20mMkqHDlg/Tcy8o+SdZ8HOG9jq4ZXGF+Hyr2e
 Moq9nN3B/4bn+s5wSnAPP9Q1ivUGR8UFqN6XBig5VCaTK5ft4YydAtyqu1Xdi8iZ2S5n
 YeSVJyi8ZsoAzCtDdZvVOfqjlXaxD9RSOqbm2R2UDvmiBJiNxmk59Rr9R4RIab0Rt0EJ
 0V46ADHwLumM6axphtLQv8k3tbkt2VrzCoQQ2OVYfP+yv5lPxIKcij8Ahxn2qGe8P/um
 rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724414; x=1768329214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dHBwfM/yA1uNqJKjEOOt2JFYZzd2s3vZ24ZhhWuxDcE=;
 b=DWJMyvocwLfgGVdwdo12aRRbnvcMjrHD7j7ytMiTl8uEf4SD9EHRkZLSLQokBcpCAW
 D4FUo6ubK4DosQxjSzoBWu9BLL0GyzatYI2l7feES8D3KRjVzK+JtvWV9pFWdAXzGwAJ
 +cgJLpSkcaaEmbLgJzALee61cVzgBKf3rDLIzeuNyb3BqCZH3n7VvgCu/mRG3aeih1aw
 qM9TXZV7t67A4WzOxmccxpM2qLg9OPvnvnVM4A4PZ+H/IWEpSA0Y9MX1bRB4dyzrWLDT
 1mtY1hmx81rFeitvsDZmWbNW7xIVbOBnzRuzklsooRoMxeQOHBGdrFnQ1GcIqKUfwnbY
 eHHg==
X-Gm-Message-State: AOJu0Yw63IXtyjnR7KBDbioI62xiot1MrlxoM5GPRsNVTNIWYdOJoOE7
 y34Ee6IaOuAsjoNPT9h/gD3dLOa5i9lLzxWzD5BskjEHg1u9aSxOfeYOOx4j+kFrxX71A75foqi
 48RkIseI=
X-Gm-Gg: AY/fxX5yBhXxak1epUane393Ey9Dwa5gvLXgiw2m3yNGkLCxgKouRrsyiNmJ+aXvtSy
 rYoEnmKJj/THEpzgTjtfKzEEXgXuCVufGl2WNBeibJsZJsoVmewoE2p6qUMiPFyRD5QVf3xN/21
 wwvO50b/gKRcs2wBhmPin5HDBmA5A81B3u/7zzYTyqQPsvPn5VFzZ3sKPW1VUMA3d9qMpeepl7b
 lU8z4LVsY0JpaeWMNZjlaZD7YqGrjNEu1inDUdQOjSxRVm80Zf2VLqnhOiuN35sfCm0mg62VV5s
 y4+6a5JEwOkokS6EEk9/JCp+UHx6qf+9nREZZFWb/6ByQ+TnJF/TKJUHdsVRtK7DNdsWE08rGS1
 HawGJ4wz+aIlK1sOFoKNBhIonTsqkg5CvHdwRCwYmLqe9/XEimBrCFZQJ+uQ+jGbL78J1Odcjud
 mmeV/hgDpESXvqhvhWF9fckoqP5epVGsqhxeKZBQotXL+w720VXtyNKrsPilH7
X-Google-Smtp-Source: AGHT+IE+KrQcjzUnqa2eSUuhN4h+Vub1AvFW1EdJocrWTxWkrwYR8WsRkyJ2Kii2dkbEOsoX79e7tQ==
X-Received: by 2002:a05:6402:27c8:b0:649:a63f:bea9 with SMTP id
 4fb4d7f45d1cf-6507967c29cmr3479279a12.16.1767724413730; 
 Tue, 06 Jan 2026 10:33:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 11/12] net/pcap: support MAC address set
Date: Tue,  6 Jan 2026 10:26:50 -0800
Message-ID: <20260106182823.192350-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

When using pcap on a single interface, it is possible for
driver to proxy the mac address set operation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c        | 13 ++++++++++++
 drivers/net/pcap/pcap_osdep.h         |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c | 23 ++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 30 ++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index bf863e8708..79f2e28fbc 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1103,6 +1103,18 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 	return 0;
 }
 
+static int
+eth_dev_macaddr_set(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	if (internals->single_iface)
+		return osdep_iface_mac_set(internals->if_index, addr);
+	else
+		return -ENOTSUP;
+}
+
+
 /* Timestamp values in receive packets from libpcap are in UTC */
 static int
 eth_rx_clock(struct rte_eth_dev *dev __rte_unused, uint64_t *timestamp)
@@ -1127,6 +1139,7 @@ static const struct eth_dev_ops ops = {
 	.rx_queue_stop = eth_rx_queue_stop,
 	.tx_queue_stop = eth_tx_queue_stop,
 	.link_update = eth_link_update,
+	.mac_addr_set = eth_dev_macaddr_set,
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index 3c8b7ff27b..00944e0843 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -14,6 +14,7 @@ extern int eth_pcap_logtype;
 
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
+int osdep_iface_mac_set(int ifindex, const struct rte_ether_addr *mac);
 int osdep_iface_mtu_set(int index, uint16_t mtu);
 
 #endif
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 0279dbf00b..39227da63a 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -58,6 +58,29 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	return 0;
 }
 
+int
+osdep_iface_mac_set(int ifindex, const struct rte_ether_addr *mac)
+{
+	char ifname[IFNAMSIZ];
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	int s = socket(AF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	struct ifreq ifr = { 0 };
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_addr.sa_family = AF_LINK;
+	memcpy(ifr.ifr_addr.sa_data, mac, sizeof(*mac));
+
+	int ret = ioctl(s, SIOCSIFLLADDR, &ifr);
+	close(s);
+
+	return (ret < 0) ? -errno : 0;
+}
+
 int osdep_iface_mtu_set(int ifindex, uint16_t mtu)
 {
 	char ifname[IFNAMSIZ];
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index d180e9b4b4..d5a3855a0a 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -4,13 +4,18 @@
  * All rights reserved.
  */
 
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <errno.h>
 #include <net/if.h>
+#include <net/if_arp.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-#include <unistd.h>
 
 #include <rte_memcpy.h>
 #include <rte_string_fns.h>
+#include <rte_ether.h>
 
 #include "pcap_osdep.h"
 
@@ -41,6 +46,29 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	return 0;
 }
 
+int
+osdep_iface_mac_set(int ifindex, const struct rte_ether_addr *mac)
+{
+	char ifname[IFNAMSIZ];
+
+	if (if_indextoname(ifindex, ifname) == NULL)
+		return -errno;
+
+	int s = socket(AF_INET, SOCK_DGRAM, 0);
+	if (s < 0)
+		return -errno;
+
+	struct ifreq ifr = { 0 };
+	strlcpy(ifr.ifr_name, ifname, IFNAMSIZ);
+	ifr.ifr_hwaddr.sa_family = ARPHRD_ETHER;
+	memcpy(ifr.ifr_hwaddr.sa_data, mac, sizeof(*mac));
+
+	int ret = ioctl(s, SIOCSIFHWADDR, &ifr);
+	close(s);
+
+	return (ret < 0) ? -errno : 0;
+}
+
 int
 osdep_iface_mtu_set(int ifindex, uint16_t mtu)
 {
-- 
2.51.0

