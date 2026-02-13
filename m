Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126C4EDF17D
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:04:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D356340695;
	Fri, 13 Feb 2026 18:03:56 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 9DF734067B
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:55 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so13079985e9.1
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002235;
 x=1771607035; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BisIjD0XY/JDDP2wiZhuTcpWfQmN1R06zoQ0UioKNEQ=;
 b=bkyB3u8nVt6qQUWHLgKsuP9M3ytrb740kbLKRjfc2aYwwDo0RnZF5hErkrIHcyo1KS
 R8ZevMZ0yNqJ7k95Ib1gLy5RHWYECT+zeuPoSbN2P4Low30dDYuin6sMIOXYN06EN5Tt
 NFLC9uqT1A29JlxWPDqNYDSTSphnszCUghXZwW+o+F02LakXl0z5f6mog00UwNRT2SfZ
 jwgffXWf73o/fAUFBQMV8cGiB9m4zR1MsifRhSuK/Cb9DJNFd+qdvnPLP4XonA8JSD8P
 DDMkX+vQuI+EfxVapm1/EuMGg2KMaQwFilES/620ucNLcverz7ifngiNe5KTYPvXJDwj
 yI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002235; x=1771607035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BisIjD0XY/JDDP2wiZhuTcpWfQmN1R06zoQ0UioKNEQ=;
 b=i0NqlE9kQIHDfiZxUtTg9HiDXR53osJsg/yTVPq8mpxuaS32fVtDAg+C3iXUcZUk4D
 CuaJO8SNaLZUe6l+q38iewI4HQ/uVeeH//JDcesgWGd2NByCTdPScxcfHceWRN78/1U7
 RdHKb+Ylo1WtYm74qe6/S9X00QwA9y8pC2GNiljQIuPdKzrbbYMFMYvqFbet01F/myZQ
 KehduGYcClkuxiP+/49wem8P1cttgbROGvYGXpLBRFe/pk9UuuXO/EWF69Fl422PlCie
 CXONwCwjljS0C+ta5la2k2gqVL5NPeFSGEKZxwf4n0tynSgFhrbwiBdQk5dAk8ry6bRV
 VEdg==
X-Gm-Message-State: AOJu0YxhQyd/+woUi/Dc48mU1GLDUi+IMdCvlMchJnqTA7MMPaGuz3vw
 AGF8CodD8m1N+ILuIWD16yS3yUb3a6cqoj1EkoN+6ezdxkp5mXeXjH0uk7tQnszf6irw+IlrLsm
 O07kh
X-Gm-Gg: AZuq6aLz5fsWhz/PPe8Swv52ep4x5fTqCPrGfrIOBJJiSvxgr3P8L3NONxbvM6pR8IC
 9VctaErAPtHDnef2/ctX6qPWNIoqJVUJj/Wii7Nf1z8ZTFlMgkeZN+AwoVAwjJrssXWron6k+K0
 AcfguQonPjwaTSrA24dDOxQlDlM9WToTSVurV820LhH9uZJz3+MO8U4rXS/bQyWlS0eTI70hmR5
 zsPyasqUeACm8/cQPbkcKB0DAoIu2Dqdbw/hLV0MzpBk31QOLN2o12zHt8U41vEDkhBUJNvQ5EN
 PAVHhcd+zBgAJCCEQHzzFRgFNHAOb9U+OGK+mkiSaHn1/5nVb5cJN6RX5ZctAlr+5T0uCJZSAgi
 iYg7VeFvgK9TMj/iknLdxrwxb+zwGPdJS2nQY9ov3W/EiddVfW6b6TyVBYScBeIqEPvqRXEvSCQ
 ivOR8SStyGNPFKqZ5RkZD3CBovOo46nruhNCRK86DMNwv5rzASjCknt3aoPqJGRA==
X-Received: by 2002:a05:600c:3151:b0:480:1d0b:2d32 with SMTP id
 5b1f17b1804b1-48373a0aed5mr42742615e9.12.1771002234957; 
 Fri, 13 Feb 2026 09:03:54 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:54 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 09/18] net/pcap: add link state and speed for interface
 mode
Date: Fri, 13 Feb 2026 09:01:32 -0800
Message-ID: <20260213170333.40089-10-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/pcap/pcap_ethdev.c         |  93 ++++++++++++++++---
 drivers/net/pcap/pcap_osdep.h          |  24 +++++
 drivers/net/pcap/pcap_osdep_freebsd.c  |  86 ++++++++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c    | 118 +++++++++++++++++++++++++
 drivers/net/pcap/pcap_osdep_windows.c  |  95 +++++++++++++++++---
 6 files changed, 394 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index fa998f1620..c1d8c3e10c 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -90,6 +90,7 @@ New Features
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
+  * Added support for reporting link state and speed in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 421a72a0cb..2209b78ff3 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -151,13 +151,6 @@ static const char *valid_arguments[] = {
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
@@ -972,11 +965,84 @@ eth_dev_close(struct rte_eth_dev *dev)
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
+	const char *iface_name = internals->rx_queue[0].name;
+	struct rte_eth_link link;
+	struct osdep_iface_link osdep_link;
+
+	memset(&link, 0, sizeof(link));
+
+	/*
+	 * For pass-through mode (single_iface), query the actual interface.
+	 * Otherwise, use the default static link values.
+	 */
+	if (internals->single_iface &&
+	    osdep_iface_link_get(iface_name, &osdep_link) == 0) {
+		link.link_speed = speed_mbps_to_rte(osdep_link.link_speed);
+		link.link_status = osdep_link.link_status ?
+			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+		link.link_duplex = osdep_link.link_duplex ?
+			RTE_ETH_LINK_FULL_DUPLEX : RTE_ETH_LINK_HALF_DUPLEX;
+		link.link_autoneg = osdep_link.link_autoneg ?
+			RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
+	} else {
+		/*
+		 * Not in pass-through mode (using pcap files or separate
+		 * interfaces for rx/tx). Or query failed. Use default values.
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
@@ -1391,7 +1457,12 @@ pmd_init_internals(struct rte_vdev_device *vdev,
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
index fe7399ff9f..b72dd0d74c 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -10,6 +10,7 @@
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
+
 extern int eth_pcap_logtype;
 #define RTE_LOGTYPE_ETH_PCAP eth_pcap_logtype
 
@@ -27,7 +28,30 @@ extern int eth_pcap_logtype;
 #define PMD_TX_LOG(...) do { } while (0)
 #endif
 
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
index 0185665f0b..5963b67087 100644
--- a/drivers/net/pcap/pcap_osdep_freebsd.c
+++ b/drivers/net/pcap/pcap_osdep_freebsd.c
@@ -5,12 +5,36 @@
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
 
+/*
+ * Userspace implementation of ifmedia_baudrate().
+ * The kernel function is not exported to userspace, so we implement
+ * our own using the IFM_BAUDRATE_DESCRIPTIONS table from if_media.h.
+ */
+static uint64_t
+ifmedia_baudrate_user(int mword)
+{
+	static const struct ifmedia_baudrate descs[] =
+		IFM_BAUDRATE_DESCRIPTIONS;
+	const struct ifmedia_baudrate *desc;
+
+	for (desc = descs; desc->ifmb_word != 0; desc++) {
+		if (IFM_TYPE_MATCH(desc->ifmb_word, mword))
+			return desc->ifmb_baudrate;
+	}
+	return 0;
+}
+
 int
 osdep_iface_index_get(const char *name)
 {
@@ -55,3 +79,65 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	free(buf);
 	return 0;
 }
+
+int
+osdep_iface_link_get(const char *if_name, struct osdep_iface_link *link)
+{
+	struct ifmediareq ifmr;
+	struct ifreq ifr;
+	uint64_t baudrate;
+	int if_fd;
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
+			/* Use userspace baudrate lookup */
+			baudrate = ifmedia_baudrate_user(ifmr.ifm_current);
+			link->link_speed = baudrate / 1000000;
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
index df976417cb..3b56a833a9 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -4,11 +4,14 @@
  * All rights reserved.
  */
 
+#include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <linux/ethtool.h>
+#include <linux/sockios.h>
 
 #include <rte_string_fns.h>
 
@@ -40,3 +43,118 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
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
+	struct ethtool_link_settings probe = { };
+	struct ethtool_link_settings *req;
+	size_t req_size;
+	int nwords;
+	int ret = -1;
+
+	/* First call with nwords = 0 to get the required size */
+	probe.cmd = ETHTOOL_GLINKSETTINGS;
+	ifr->ifr_data = (void *)&probe;
+
+	if (ioctl(fd, SIOCETHTOOL, ifr) < 0)
+		return -1;
+
+	/* Kernel returns negative nwords on first call */
+	if (probe.link_mode_masks_nwords >= 0)
+		return -1;
+
+	nwords = -probe.link_mode_masks_nwords;
+
+	/* Bounds check */
+	if (nwords == 0 || nwords > 127)
+		return -1;
+
+	/* Second call with correct nwords - need space for 3 link mode masks */
+	req_size = sizeof(*req) + 3 * nwords * sizeof(uint32_t);
+	req = malloc(req_size);
+	if (req == NULL)
+		return -1;
+
+	memset(req, 0, req_size);
+	req->cmd = ETHTOOL_GLINKSETTINGS;
+	req->link_mode_masks_nwords = nwords;
+	ifr->ifr_data = (void *)req;
+
+	if (ioctl(fd, SIOCETHTOOL, ifr) < 0)
+		goto out;
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
+	ret = 0;
+out:
+	free(req);
+	return ret;
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

