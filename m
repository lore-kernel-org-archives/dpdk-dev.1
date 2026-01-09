Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00020D232C7
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 01:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6760C40A7F;
	Fri,  9 Jan 2026 02:18:14 +0100 (CET)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53]) by mails.dpdk.org (Postfix) with ESMTP id 3E4B040698
 for <dev@dpdk.org>; Fri,  9 Jan 2026 02:18:13 +0100 (CET)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b804646c718so552763066b.2
 for <dev@dpdk.org>; Thu, 08 Jan 2026 17:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767921493;
 x=1768526293; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QB+jiIUIybaEjJMfV3fn38upMzfMdNmqkpjjyeFs+Xk=;
 b=mAj0OaICkcI9exq7VXdwt0LAExDg/bU3voIvGyV+CRwwDoCgap5C+5FtzREX3k0/1r
 xFmEjfCMgnBX4cMRJPXGX61hiS1hR1Mb8RBoEuR0TTh4BHL56/XkGR4zoiZY0L63XgWz
 7uH9OQl9dDBeaNzLA1lIRB6+PEASCPpITa5Qv15dTrDKGpLFEAKsrS6HxF4hqjA5acB5
 tP/RyLqdlCS3yd3AX3I5n+QB/sL6R7uaY8eQu0fj4WDv9Siwh/CbJZo/vQ6fCHnGITtQ
 NUFMyys1BRO/OoSCfDkX2TI8NNodQLFdy6xGZZpFQaF+l7nnchdH/50tzXp6NZoLtNDF
 8h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767921493; x=1768526293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QB+jiIUIybaEjJMfV3fn38upMzfMdNmqkpjjyeFs+Xk=;
 b=APrYubUgSDzKnAz1zQr7AI4u+jOePnznOFa9zzWd9FI5CH6HsoEN+n8AUyRengLPNE
 RwcYjjJNjdo8ej963Tj2sC7pkGfx7L+wbxMYqxCzXX1CKXbv4fz7vFREmf/lPIbgTqcB
 YH61J8dJAHvtSUYirFvjBzj7ov0MhI+S74eF0lp14VELbxIIrqoXMn2Kl92Ehh6KVMRB
 9+kL6nyLFhfJVUKpaye7is4+kYggCZhK3o+oKKa9elNcxf28wEqbWHr59pXX/dNw6Jdf
 ZpEZcGbWTv7WmZBwAGROL9tHcDw2GJ2oAIPAAyB+qvemRXieD5KQ+r/M2fEgNeycC1BV
 3FUw==
X-Gm-Message-State: AOJu0YygeQjosMvJhQJhmI+Awr6iLCw4wEwCxj4CffyGK2t1/dUgVX1B
 qXvVLAqJqYwOuiRA8HqJm/bFcbuAeHHLLux3B/tNnTn6f/l6CsxxaueUQ2NGi+GUK2N0j+b0qe1
 f+y5t
X-Gm-Gg: AY/fxX7nLB7n+GTDlVOIXHxqIwxevaA/iubnnPYpGUc7JwumdHr8qgGnIN96zS5zQxh
 wXonhh+BJMKp52oilg6uVyy1NONbpHVAfoFgVEvjMvK98b7/UNXKN5LF9IGANX+bNuzgV6537mP
 NHJEgT4BfLQbGDiATb4bR66yWLpZHiKaKlOOr9CQ+CyNempu0pRlLLD/dvBa7+XJV+z8445QwiH
 SK+Gu37gjjTnG5a2VW/aLpyNIyX0uuvjo1lGH+MElwmKnW1cADR3HwOdscf8CqgoQ7TEBU2EowR
 aoDQJRJclpm/6Ekntcb7zmkwm6lzk2iUR10etyr0Ypm25SFFXTgN3TxWHyaXm1UWmA4Kq/UCl6J
 Avkra9XKkUXOQLfoOvPL+wIyTZnrDAwcmoPQG0bUIDN/VrI+odIov0K/4Ltnit4dX2aFJSZ75pp
 ob8wb2auZyEKcyVoPSw2V+m4IErUseiEShzLRfCjp7pOQmLodI0g==
X-Google-Smtp-Source: AGHT+IEeVMR67s61dKIEkMNcM14Ze0VwZhNnRLfFes67uo1ah4M2GUOiV+YUX7gdh9tGd8cMjbZUSA==
X-Received: by 2002:a17:907:7846:b0:b84:569b:5b6e with SMTP id
 a640c23a62f3a-b84569b61d5mr408120666b.41.1767921492747; 
 Thu, 08 Jan 2026 17:18:12 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cac3sm954886566b.20.2026.01.08.17.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 17:18:12 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 8/9] net/pcap: support MAC address set
Date: Thu,  8 Jan 2026 17:16:25 -0800
Message-ID: <20260109011755.362857-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109011755.362857-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260109011755.362857-1-stephen@networkplumber.org>
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

Use rte_ether_addr structure to avoid memcpy and void *.

When using pcap on a single interface, it is possible for
driver to proxy the mac address set operation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c        | 19 ++++++++++++++---
 drivers/net/pcap/pcap_osdep.h         |  1 +
 drivers/net/pcap/pcap_osdep_freebsd.c | 23 ++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 30 ++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index bf03f431dd..824cdabab6 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1086,6 +1086,18 @@ eth_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
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
@@ -1110,6 +1122,7 @@ static const struct eth_dev_ops ops = {
 	.rx_queue_stop = eth_rx_queue_stop,
 	.tx_queue_stop = eth_tx_queue_stop,
 	.link_update = eth_link_update,
+	.mac_addr_set = eth_dev_macaddr_set,
 	.mtu_set = eth_mtu_set,
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
@@ -1357,9 +1370,9 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 
 static int
 eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
-		const unsigned int numa_node)
+		    const unsigned int numa_node)
 {
-	void *mac_addrs;
+	struct rte_ether_addr *mac_addrs;
 	struct rte_ether_addr mac;
 
 	if (osdep_iface_mac_get(if_name, &mac) < 0)
@@ -1370,7 +1383,7 @@ eth_pcap_update_mac(const char *if_name, struct rte_eth_dev *eth_dev,
 		return -1;
 
 	PMD_LOG(INFO, "Setting phy MAC for %s", if_name);
-	rte_memcpy(mac_addrs, mac.addr_bytes, RTE_ETHER_ADDR_LEN);
+	rte_ether_addr_copy(&mac, mac_addrs);
 	eth_dev->data->mac_addrs = mac_addrs;
 	return 0;
 }
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

