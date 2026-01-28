Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02648D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:42:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5229440A72;
	Wed, 28 Jan 2026 19:41:58 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 2082B40A6C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:50 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so955055e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625710;
 x=1770230510; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4/gq2uODMoprCj+Rs5xP+mGP3vzANfXpx8oy3nau2o=;
 b=nvw5dlBBnUeNV6y6scIO+VphY321YXijajm6iEckGgbd9OOdYM16NJpm09w1ZdiAsM
 IrM3UOd4vtgRnpuKKx+g8RD/PTXrVqPGrxEEBH5UdLdU4buZU4W/z5AstXa+EVjLq4J4
 E73pvGY+KprePazwmtflb6Mi31qglOf1veP2k4aoOXxvUbbe3+A3+iaYIqFF8cEa3iqG
 DrAax+w3YCXOhZwbgluBp7jgEB1UgK7bLyINF9zMahlO5JoM3kqrUFNPaE5MEQNeGvrW
 7aTWGxTBtZpRHc7R0m1NYW7ZL8dIpPSASgNjp/1I91WXibWsD16zTxCTJvB3ZN8U8kIx
 5zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625710; x=1770230510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C4/gq2uODMoprCj+Rs5xP+mGP3vzANfXpx8oy3nau2o=;
 b=RMEvk/ZHoY9H4t+Iy0dClJyN8XJc8qzwzdjxvb4FpsStYtiOiehN6BgjaYTtnpiCyn
 /+w0zHvNG3UdKWk2x8Ets83st0vFRiMMRpLPLvQdn2o83mdj7VIUD4+G0xet4Ooi6Ysq
 A0Bsci0xbL9LHd8K5fWsTXdVirkO4zxdfT8VDA591el7CUC1tP2cDAWNRrCGDkufHHfb
 y950YEtTFDH5FUSPMZAhf/AXqOpYHNcE3uKI6HxfniO9dA0/dcXhYkT7iDShATmWmaSp
 PBdtudKZaAmdN0ivj32s1/8tl4EcdMB7ElFqlp4pcuf48FbsO1bgSqdxVu0cBVMVCyKj
 iTtA==
X-Gm-Message-State: AOJu0Yy8hyDZnS3CJmb5VIWtvohhKGfV782ZRWkUc3hBNQTw+N+PHdi1
 I7Tbc/uC5ktOL9Lex212JtQpu3VjipW1nxU6kdWwKGA8lBdS1NSXDVjrMApQWDHedLt7jEa0aOO
 IFshc
X-Gm-Gg: AZuq6aLNTOzpLbvyD1I4N0uGZkbO9pAP/UVbXEFMRwJp8j5rerHY8Ep7l7HrIimyyzH
 HHbAjStNeaUjRnQpuWkPe443CgptWLkV11l8iHW12lWVWr3N8NuGSW/UN23OCveJyvhiZbh0Pv6
 mDrRxu0GMaG1/hXZEblI1mMPah3JoDWtviRd+ySFTuGLSDJcinBNyc7xNyUYdSJaFnict3wJCJw
 IuJBrk1/xszvwGRpqwtFP2G8//MuezzTaiciGoG87rjT/YrGkommMeUKrSpNQ/glOiks5wItE05
 wSwQNB70oqhUaAeJb6ZK3BWdv1MtTfphs8Wjqmf3sdRgLZvSORJANakQ7dz44oJDGNPNvuU6INT
 BfxGWjvldi31UczFyuEXNhaPoVpq5ukvMLmkeGA2boB4i1FLzKpomEZZ82EwB23ucO/UhAn8uU8
 C+vK7br0O4L3CBP32uvAPhSUFLDRXn8PFDKI5PijKGwD6qUPmLOKq8HjVv+sS8
X-Received: by 2002:a05:600c:530c:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-48069c9c22amr66864485e9.34.1769625709522; 
 Wed, 28 Jan 2026 10:41:49 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:49 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 09/15] net/pcap: add link state and speed for interface mode
Date: Wed, 28 Jan 2026 10:40:38 -0800
Message-ID: <20260128184130.445567-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

When the PCAP PMD is used in pass-through mode with a physical
interface (iface=X), the link status was always reported with
hardcoded values regardless of the actual interface state.

Add OS-dependent functions to query the real link state, speed,
duplex, and autonegotiation settings from the underlying interface.
The eth_link_update() callback now returns accurate information
when operating in pass-through mode.

Linux uses ETHTOOL_GLINKSETTINGS which supports all speeds up to
800 Gbps. FreeBSD uses SIOCGIFMEDIA, and Windows uses
GetAdaptersAddresses().

For pcap file mode or separate rx/tx interface configurations,
default values continue to be used since there is no single
underlying interface to query.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c        | 105 +++++++++-
 drivers/net/pcap/pcap_osdep.h         |  22 ++
 drivers/net/pcap/pcap_osdep_freebsd.c | 277 ++++++++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c   | 109 ++++++++++
 drivers/net/pcap/pcap_osdep_windows.c |  95 +++++++--
 5 files changed, 585 insertions(+), 23 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 47211807a7..f8ccc03d6f 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -146,13 +146,6 @@ static const char *valid_arguments[] = {
 	NULL
 };
 
-static struct rte_eth_link pmd_link = {
-		.link_speed = RTE_ETH_SPEED_NUM_10G,
-		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
-		.link_status = RTE_ETH_LINK_DOWN,
-		.link_autoneg = RTE_ETH_LINK_FIXED,
-};
-
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
 static struct queue_missed_stat*
@@ -899,11 +892,96 @@ eth_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/*
+ * Convert osdep speed (Mbps) to rte_eth_link speed constant.
+ */
+static uint32_t
+speed_mbps_to_rte(uint32_t speed_mbps)
+{
+	switch (speed_mbps) {
+	case 10:
+		return RTE_ETH_SPEED_NUM_10M;
+	case 100:
+		return RTE_ETH_SPEED_NUM_100M;
+	case 1000:
+		return RTE_ETH_SPEED_NUM_1G;
+	case 2500:
+		return RTE_ETH_SPEED_NUM_2_5G;
+	case 5000:
+		return RTE_ETH_SPEED_NUM_5G;
+	case 10000:
+		return RTE_ETH_SPEED_NUM_10G;
+	case 20000:
+		return RTE_ETH_SPEED_NUM_20G;
+	case 25000:
+		return RTE_ETH_SPEED_NUM_25G;
+	case 40000:
+		return RTE_ETH_SPEED_NUM_40G;
+	case 50000:
+		return RTE_ETH_SPEED_NUM_50G;
+	case 56000:
+		return RTE_ETH_SPEED_NUM_56G;
+	case 100000:
+		return RTE_ETH_SPEED_NUM_100G;
+	case 200000:
+		return RTE_ETH_SPEED_NUM_200G;
+	case 400000:
+		return RTE_ETH_SPEED_NUM_400G;
+	case 800000:
+		return RTE_ETH_SPEED_NUM_800G;
+	default:
+		/* For unknown speeds, return the raw value */
+		if (speed_mbps > 0)
+			return speed_mbps;
+		return RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+}
+
 static int
-eth_link_update(struct rte_eth_dev *dev __rte_unused,
-		int wait_to_complete __rte_unused)
+eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
-	return 0;
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_link link;
+	struct osdep_iface_link osdep_link;
+	const char *iface_name;
+
+	memset(&link, 0, sizeof(link));
+
+	/*
+	 * For pass-through mode (single_iface), query the actual interface.
+	 * Otherwise, use the default static link values.
+	 */
+	if (internals->single_iface) {
+		iface_name = internals->rx_queue[0].name;
+
+		if (osdep_iface_link_get(iface_name, &osdep_link) == 0) {
+			link.link_speed = speed_mbps_to_rte(osdep_link.link_speed);
+			link.link_status = osdep_link.link_status ?
+				RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+			link.link_duplex = osdep_link.link_duplex ?
+				RTE_ETH_LINK_FULL_DUPLEX : RTE_ETH_LINK_HALF_DUPLEX;
+			link.link_autoneg = osdep_link.link_autoneg ?
+				RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
+		} else {
+			/* Query failed, use defaults */
+			link.link_speed = RTE_ETH_SPEED_NUM_10G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			link.link_status = RTE_ETH_LINK_DOWN;
+			link.link_autoneg = RTE_ETH_LINK_FIXED;
+		}
+	} else {
+		/*
+		 * Not in pass-through mode (using pcap files or separate
+		 * interfaces for rx/tx). Use default values.
+		 */
+		link.link_speed = RTE_ETH_SPEED_NUM_10G;
+		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+		link.link_status = dev->data->dev_started ?
+			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+		link.link_autoneg = RTE_ETH_LINK_FIXED;
+	}
+
+	return rte_eth_linkstatus_set(dev, &link);
 }
 
 static int
@@ -1268,7 +1346,12 @@ pmd_init_internals(struct rte_vdev_device *vdev,
 	data = (*eth_dev)->data;
 	data->nb_rx_queues = (uint16_t)nb_rx_queues;
 	data->nb_tx_queues = (uint16_t)nb_tx_queues;
-	data->dev_link = pmd_link;
+	data->dev_link = (struct rte_eth_link) {
+		.link_speed = RTE_ETH_SPEED_NUM_NONE,
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_status = RTE_ETH_LINK_DOWN,
+		.link_autoneg = RTE_ETH_LINK_FIXED,
+	};
 	data->mac_addrs = &(*internals)->eth_addr;
 	data->promiscuous = 1;
 	data->all_multicast = 1;
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index a0e2b5ace9..732813c028 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -13,7 +13,29 @@
 extern int eth_pcap_logtype;
 #define RTE_LOGTYPE_ETH_PCAP eth_pcap_logtype
 
+/**
+ * Link information returned by osdep_iface_link_get().
+ */
+struct osdep_iface_link {
+	uint32_t link_speed;    /**< Speed in Mbps, 0 if unknown */
+	uint8_t link_status;    /**< 1 = up, 0 = down */
+	uint8_t link_duplex;    /**< 1 = full, 0 = half */
+	uint8_t link_autoneg;   /**< 1 = autoneg enabled, 0 = fixed */
+};
+
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
 
+/**
+ * Get link state and speed for a network interface.
+ *
+ * @param name
+ *   Interface name (e.g., "eth0" on Linux, "{GUID}" on Windows).
+ * @param link
+ *   Pointer to structure to fill with link information.
+ * @return
+ *   0 on success, -1 on failure.
+ */
+int osdep_iface_link_get(const char *name, struct osdep_iface_link *link);
+
 #endif
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 0185665f0b..1405f1f85d 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -5,8 +5,13 @@
  */
 
 #include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
 #include <net/if.h>
 #include <net/if_dl.h>
+#include <net/if_media.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
 #include <sys/sysctl.h>
 
 #include "pcap_osdep.h"
@@ -55,3 +60,275 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	free(buf);
 	return 0;
 }
+
+/*
+ * Map media subtype to speed in Mbps.
+ * This handles common Ethernet media types.
+ */
+static uint32_t
+media_subtype_to_speed(int subtype)
+{
+	switch (subtype) {
+	case IFM_10_T:
+	case IFM_10_2:
+	case IFM_10_5:
+	case IFM_10_STP:
+	case IFM_10_FL:
+		return 10;
+	case IFM_100_TX:
+	case IFM_100_FX:
+	case IFM_100_T4:
+	case IFM_100_VG:
+	case IFM_100_T2:
+		return 100;
+	case IFM_1000_SX:
+	case IFM_1000_LX:
+	case IFM_1000_CX:
+	case IFM_1000_T:
+#ifdef IFM_1000_KX
+	case IFM_1000_KX:
+#endif
+#ifdef IFM_1000_SGMII
+	case IFM_1000_SGMII:
+#endif
+		return 1000;
+#ifdef IFM_2500_T
+	case IFM_2500_T:
+#endif
+#ifdef IFM_2500_X
+	case IFM_2500_X:
+#endif
+#ifdef IFM_2500_KX
+	case IFM_2500_KX:
+#endif
+		return 2500;
+#ifdef IFM_5000_T
+	case IFM_5000_T:
+#endif
+#ifdef IFM_5000_KR
+	case IFM_5000_KR:
+#endif
+		return 5000;
+	case IFM_10G_LR:
+	case IFM_10G_SR:
+	case IFM_10G_CX4:
+	case IFM_10G_T:
+	case IFM_10G_TWINAX:
+	case IFM_10G_TWINAX_LONG:
+	case IFM_10G_LRM:
+	case IFM_10G_KX4:
+	case IFM_10G_KR:
+	case IFM_10G_CR1:
+	case IFM_10G_ER:
+	case IFM_10G_SFI:
+		return 10000;
+#ifdef IFM_20G_KR2
+	case IFM_20G_KR2:
+#endif
+		return 20000;
+	case IFM_25G_CR:
+	case IFM_25G_KR:
+	case IFM_25G_SR:
+	case IFM_25G_LR:
+#ifdef IFM_25G_ACC
+	case IFM_25G_ACC:
+#endif
+#ifdef IFM_25G_AOC
+	case IFM_25G_AOC:
+#endif
+#ifdef IFM_25G_ER
+	case IFM_25G_ER:
+#endif
+#ifdef IFM_25G_T
+	case IFM_25G_T:
+#endif
+		return 25000;
+	case IFM_40G_CR4:
+	case IFM_40G_SR4:
+	case IFM_40G_LR4:
+	case IFM_40G_KR4:
+#ifdef IFM_40G_ER4
+	case IFM_40G_ER4:
+#endif
+		return 40000;
+	case IFM_50G_CR2:
+	case IFM_50G_KR2:
+#ifdef IFM_50G_SR2
+	case IFM_50G_SR2:
+#endif
+#ifdef IFM_50G_LR2
+	case IFM_50G_LR2:
+#endif
+#ifdef IFM_50G_KR
+	case IFM_50G_KR:
+#endif
+#ifdef IFM_50G_SR
+	case IFM_50G_SR:
+#endif
+#ifdef IFM_50G_CR
+	case IFM_50G_CR:
+#endif
+#ifdef IFM_50G_LR
+	case IFM_50G_LR:
+#endif
+#ifdef IFM_50G_FR
+	case IFM_50G_FR:
+#endif
+		return 50000;
+	case IFM_100G_CR4:
+	case IFM_100G_SR4:
+	case IFM_100G_KR4:
+	case IFM_100G_LR4:
+#ifdef IFM_100G_CR2
+	case IFM_100G_CR2:
+#endif
+#ifdef IFM_100G_SR2
+	case IFM_100G_SR2:
+#endif
+#ifdef IFM_100G_KR2
+	case IFM_100G_KR2:
+#endif
+#ifdef IFM_100G_DR
+	case IFM_100G_DR:
+#endif
+#ifdef IFM_100G_FR
+	case IFM_100G_FR:
+#endif
+#ifdef IFM_100G_LR
+	case IFM_100G_LR:
+#endif
+		return 100000;
+#ifdef IFM_200G_CR4
+	case IFM_200G_CR4:
+#endif
+#ifdef IFM_200G_SR4
+	case IFM_200G_SR4:
+#endif
+#ifdef IFM_200G_KR4
+	case IFM_200G_KR4:
+#endif
+#ifdef IFM_200G_LR4
+	case IFM_200G_LR4:
+#endif
+#ifdef IFM_200G_FR4
+	case IFM_200G_FR4:
+#endif
+#ifdef IFM_200G_DR4
+	case IFM_200G_DR4:
+#endif
+		return 200000;
+#ifdef IFM_400G_CR8
+	case IFM_400G_CR8:
+#endif
+#ifdef IFM_400G_SR8
+	case IFM_400G_SR8:
+#endif
+#ifdef IFM_400G_KR8
+	case IFM_400G_KR8:
+#endif
+#ifdef IFM_400G_LR8
+	case IFM_400G_LR8:
+#endif
+#ifdef IFM_400G_FR8
+	case IFM_400G_FR8:
+#endif
+#ifdef IFM_400G_DR8
+	case IFM_400G_DR8:
+#endif
+#ifdef IFM_400G_CR4
+	case IFM_400G_CR4:
+#endif
+#ifdef IFM_400G_SR4
+	case IFM_400G_SR4:
+#endif
+#ifdef IFM_400G_DR4
+	case IFM_400G_DR4:
+#endif
+#ifdef IFM_400G_FR4
+	case IFM_400G_FR4:
+#endif
+#ifdef IFM_400G_LR4
+	case IFM_400G_LR4:
+#endif
+		return 400000;
+#ifdef IFM_800G_CR8
+	case IFM_800G_CR8:
+#endif
+#ifdef IFM_800G_SR8
+	case IFM_800G_SR8:
+#endif
+#ifdef IFM_800G_DR8
+	case IFM_800G_DR8:
+#endif
+#ifdef IFM_800G_FR8
+	case IFM_800G_FR8:
+#endif
+#ifdef IFM_800G_LR8
+	case IFM_800G_LR8:
+#endif
+		return 800000;
+	default:
+		return 0;
+	}
+}
+
+int
+osdep_iface_link_get(const char *if_name, struct osdep_iface_link *link)
+{
+	struct ifmediareq ifmr;
+	struct ifreq ifr;
+	int if_fd;
+	int subtype;
+
+	memset(link, 0, sizeof(*link));
+
+	if_fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (if_fd == -1)
+		return -1;
+
+	/* Get interface flags to determine administrative status */
+	memset(&ifr, 0, sizeof(ifr));
+	strlcpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+	if (ioctl(if_fd, SIOCGIFFLAGS, &ifr) == 0) {
+		if (ifr.ifr_flags & IFF_UP)
+			link->link_status = 1;
+	}
+
+	/* Get media status for speed, duplex, and link state */
+	memset(&ifmr, 0, sizeof(ifmr));
+	strlcpy(ifmr.ifm_name, if_name, sizeof(ifmr.ifm_name));
+
+	if (ioctl(if_fd, SIOCGIFMEDIA, &ifmr) == 0) {
+		/* Check if link is actually active */
+		if (!(ifmr.ifm_status & IFM_ACTIVE))
+			link->link_status = 0;
+
+		/* Only parse media if we have a valid current media type */
+		if (ifmr.ifm_current != 0 && IFM_TYPE(ifmr.ifm_current) == IFM_ETHER) {
+			subtype = IFM_SUBTYPE(ifmr.ifm_current);
+			link->link_speed = media_subtype_to_speed(subtype);
+
+			/* Check duplex - FDX option means full duplex */
+			if (IFM_OPTIONS(ifmr.ifm_current) & IFM_FDX)
+				link->link_duplex = 1;
+			else
+				link->link_duplex = 0;
+		} else {
+			/* Default to full duplex if we can't determine */
+			link->link_duplex = 1;
+		}
+
+		/* Check autonegotiation status */
+		link->link_autoneg = (ifmr.ifm_current & IFM_AUTO) ? 1 : 0;
+	} else {
+		/*
+		 * SIOCGIFMEDIA failed - interface may not support it.
+		 * Default to reasonable values.
+		 */
+		link->link_duplex = 1;  /* Assume full duplex */
+		link->link_autoneg = 0;
+	}
+
+	close(if_fd);
+	return 0;
+}
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index df976417cb..036c685b50 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -9,6 +9,8 @@
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
 
 #include <rte_string_fns.h>
 
@@ -40,3 +42,110 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	close(if_fd);
 	return 0;
 }
+
+/*
+ * Get link speed, duplex, and autoneg using ETHTOOL_GLINKSETTINGS.
+ *
+ * ETHTOOL_GLINKSETTINGS was introduced in kernel 4.7 and supports
+ * speeds beyond 65535 Mbps (up to 800 Gbps and beyond).
+ * DPDK requires kernel 4.19 or later, so this interface is always available.
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int
+get_link_settings(int fd, struct ifreq *ifr, struct osdep_iface_link *link)
+{
+	struct ethtool_link_settings *req;
+	int nwords;
+
+	/* First call with nwords = 0 to get the required size */
+	req = alloca(sizeof(*req));
+	memset(req, 0, sizeof(*req));
+	req->cmd = ETHTOOL_GLINKSETTINGS;
+	ifr->ifr_data = (void *)req;
+
+	if (ioctl(fd, SIOCETHTOOL, ifr) < 0)
+		return -1;
+
+	/* Kernel returns negative nwords on first call */
+	if (req->link_mode_masks_nwords >= 0)
+		return -1;
+
+	nwords = -req->link_mode_masks_nwords;
+
+	/* Bounds check */
+	if (nwords == 0 || nwords > 127)
+		return -1;
+
+	/* Second call with correct nwords - need space for 3 link mode masks */
+	req = alloca(sizeof(*req) + 3 * nwords * sizeof(uint32_t));
+	memset(req, 0, sizeof(*req));
+	req->cmd = ETHTOOL_GLINKSETTINGS;
+	req->link_mode_masks_nwords = nwords;
+	ifr->ifr_data = (void *)req;
+
+	if (ioctl(fd, SIOCETHTOOL, ifr) < 0)
+		return -1;
+
+	/* Speed is in Mbps, directly usable */
+	link->link_speed = req->speed;
+
+	/* Handle special values */
+	if (link->link_speed == (uint32_t)SPEED_UNKNOWN ||
+	    link->link_speed == (uint32_t)-1)
+		link->link_speed = 0;
+
+	switch (req->duplex) {
+	case DUPLEX_FULL:
+		link->link_duplex = 1;
+		break;
+	case DUPLEX_HALF:
+		link->link_duplex = 0;
+		break;
+	default:
+		link->link_duplex = 1;  /* Default to full duplex */
+		break;
+	}
+
+	link->link_autoneg = (req->autoneg == AUTONEG_ENABLE) ? 1 : 0;
+	return 0;
+}
+
+int
+osdep_iface_link_get(const char *if_name, struct osdep_iface_link *link)
+{
+	struct ifreq ifr;
+	int if_fd;
+
+	memset(link, 0, sizeof(*link));
+
+	if_fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (if_fd == -1)
+		return -1;
+
+	/* Get interface flags to determine link status */
+	rte_strscpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+	if (ioctl(if_fd, SIOCGIFFLAGS, &ifr) == 0) {
+		/*
+		 * IFF_UP means administratively up
+		 * IFF_RUNNING means operationally up (carrier detected)
+		 */
+		if ((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING))
+			link->link_status = 1;
+	}
+
+	rte_strscpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+	if (get_link_settings(if_fd, &ifr, link) < 0) {
+		/*
+		 * ethtool failed - interface may not support it
+		 * (e.g., virtual interfaces like veth, lo).
+		 * Use reasonable defaults.
+		 */
+		link->link_speed = 0;
+		link->link_duplex = 1;  /* Assume full duplex */
+		link->link_autoneg = 0;
+	}
+
+	close(if_fd);
+	return 0;
+}
diff --git a/drivers/net/pcap/pcap_osdep_windows.c b/drivers/net/pcap/pcap_osdep_windows.c
index 1d398dc7ed..1b76ae3185 100644
--- a/drivers/net/pcap/pcap_osdep_windows.c
+++ b/drivers/net/pcap/pcap_osdep_windows.c
@@ -61,38 +61,56 @@ osdep_iface_index_get(const char *device_name)
 }
 
 /*
- * libpcap takes device names like "\Device\NPF_{GUID}",
- * GetAdaptersAddresses() returns names in "{GUID}" form.
- * Try to extract GUID from device name, fall back to original device name.
+ * Helper function to get adapter information by name.
+ * Returns adapter info on success, NULL on failure.
+ * Caller must free the returned buffer.
  */
-int
-osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
+static IP_ADAPTER_ADDRESSES *
+get_adapter_addresses(void)
 {
-	IP_ADAPTER_ADDRESSES *info = NULL, *cur = NULL;
-	ULONG size, sys_ret;
-	const char *adapter_name;
-	int ret = -1;
+	IP_ADAPTER_ADDRESSES *info = NULL;
+	ULONG size;
+	DWORD sys_ret;
 
 	sys_ret = GetAdaptersAddresses(AF_UNSPEC, 0, NULL, NULL, &size);
 	if (sys_ret != ERROR_BUFFER_OVERFLOW) {
 		PMD_LOG(ERR, "GetAdapterAddresses() = %lu, expected %lu\n",
 			sys_ret, ERROR_BUFFER_OVERFLOW);
-		return -1;
+		return NULL;
 	}
 
 	info = (IP_ADAPTER_ADDRESSES *)malloc(size);
 	if (info == NULL) {
 		PMD_LOG(ERR, "Cannot allocate adapter address info\n");
-		return -1;
+		return NULL;
 	}
 
 	sys_ret = GetAdaptersAddresses(AF_UNSPEC, 0, NULL, info, &size);
 	if (sys_ret != ERROR_SUCCESS) {
 		PMD_LOG(ERR, "GetAdapterAddresses() = %lu\n", sys_ret);
 		free(info);
-		return -1;
+		return NULL;
 	}
 
+	return info;
+}
+
+/*
+ * libpcap takes device names like "\Device\NPF_{GUID}",
+ * GetAdaptersAddresses() returns names in "{GUID}" form.
+ * Try to extract GUID from device name, fall back to original device name.
+ */
+int
+osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
+{
+	IP_ADAPTER_ADDRESSES *info = NULL, *cur = NULL;
+	const char *adapter_name;
+	int ret = -1;
+
+	info = get_adapter_addresses();
+	if (info == NULL)
+		return -1;
+
 	adapter_name = iface_guid(device_name);
 	if (adapter_name == NULL)
 		adapter_name = device_name;
@@ -116,3 +134,56 @@ osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
 	free(info);
 	return ret;
 }
+
+int
+osdep_iface_link_get(const char *device_name, struct osdep_iface_link *link)
+{
+	IP_ADAPTER_ADDRESSES *info = NULL, *cur = NULL;
+	const char *adapter_name;
+	int ret = -1;
+
+	memset(link, 0, sizeof(*link));
+
+	info = get_adapter_addresses();
+	if (info == NULL)
+		return -1;
+
+	adapter_name = iface_guid(device_name);
+	if (adapter_name == NULL)
+		adapter_name = device_name;
+
+	for (cur = info; cur != NULL; cur = cur->Next) {
+		if (strcmp(cur->AdapterName, adapter_name) == 0) {
+			/* Check operational status */
+			if (cur->OperStatus == IfOperStatusUp)
+				link->link_status = 1;
+			else
+				link->link_status = 0;
+
+			/*
+			 * TransmitLinkSpeed and ReceiveLinkSpeed are in bits/sec.
+			 * Convert to Mbps. Use transmit speed as the link speed.
+			 * For asymmetric links, this is a reasonable approximation.
+			 */
+			if (cur->TransmitLinkSpeed != 0 &&
+			    cur->TransmitLinkSpeed != (ULONG64)-1) {
+				link->link_speed =
+					(uint32_t)(cur->TransmitLinkSpeed / 1000000ULL);
+			}
+
+			/*
+			 * Windows doesn't directly expose duplex/autoneg via
+			 * GetAdaptersAddresses(). Default to full duplex.
+			 * For more detailed info, WMI or OID queries would be needed.
+			 */
+			link->link_duplex = 1;  /* Assume full duplex */
+			link->link_autoneg = 0; /* Cannot determine */
+
+			ret = 0;
+			break;
+		}
+	}
+
+	free(info);
+	return ret;
+}
-- 
2.51.0

