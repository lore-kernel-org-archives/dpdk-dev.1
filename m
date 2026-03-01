Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F580FD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:09:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5F4140E42;
	Sun,  1 Mar 2026 03:07:53 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 997D440E3A
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:49 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb38e6d164so436258985a.3
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330869;
 x=1772935669; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3BSEcyAE4hAH0DHyYFANof64fCIUYZ7CWr6++MfuSk=;
 b=2Jpg4iM1vk85Z9y6crjnonx0P+vxMD96vOgft1mWYbITL6SIzYwXdUyQT50W0rkmPl
 zzZbx2UXgMUMRpfduQSBj6kQ7lSeur+3OOgGtfAZcOPl9ogNYnvBY9nGb7VcviX9458Y
 0mKbDwo2FMBtQqY2KEynvMHGWkfyeaWLBspW8ZUhnCiVrT2FxBfWlGX4F4q3O/kBLzoB
 bL5RMN80YzoTdfoqsCEbwgsRZOaIiX9qRgNnlMH0Uf8OcKU4xx7simbrg2hWA4ehdHoh
 E0pXqYHK/sGucmWMAi2+2K7xjGiRnj8UN/9dxYkFlW32qoQgjOCQ7oRlGiyjRP3znIyH
 IEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330869; x=1772935669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3BSEcyAE4hAH0DHyYFANof64fCIUYZ7CWr6++MfuSk=;
 b=Y16homP7/HtmGbrCKt81HiovoFtX1zHnvDjDo2ZnW6C6QZwPgYwBJVXJ3adVI30OCV
 BfUHZEvXh1g/qXYj4Sh4L8QaZ2eZAe/0JYI0zThmF/ebRwUorPdcyA0G4TCcfLsRRYyd
 mZft2JBsRWl5XMtAxi6S3Q59MwDxDX32QOQFZPdfIf5pitRyVtok+LddBWpPbNvPOVnN
 rUcZzyY/63l1w6lwKOAXFrw8UXczns4V4OtIEI/bXmpjF5UEpSMkPQ5AZ9w41MF261wR
 noHu8yljHnFMQY3qZ2pZiuUyGrc4HFak6Y/uSJmjIEksUDeSoYl3TsPjMb3uQHd/WmMU
 1OtQ==
X-Gm-Message-State: AOJu0YxG2hYxB3LB4qiUp82/xErRCAEr+WWssHXbwtWDqBBX5sNPEZkw
 SUaWVUOdlvb+3a5puFUtnw5G7m4YJmC4qcj6TtwywvdvTYHddvuhRl4ihyEifbIvUHEu5xBL+Y1
 nHi8i
X-Gm-Gg: ATEYQzx8OGgen4sjShnaqG/bvDKkwmwWuelWUvi80PaDYpRrlk1g4ZNLryY2mnQAGlb
 vYPjDpKMljtEf0OKcI8TUolKFf5UjpZVWjZeRgs96qEXZxMo06mZz8YQlO/uJPlv3ICKeI7TL5h
 sQP8r1B17pVN/ExmHqjH5Xm6Ya3DasoQaCCvGMp4yv0aBXe9W2HJ+blnNNi9e28zGf6H47JdZBD
 G56G+1y9zy9OSEjGI42CJD6yK01qvvqXLT0s4jL6IFqKiDhAxiPKngzghl5H1TLLj8+/K56rPIn
 GYAnKC+R81MIiGIXV0oD3tHbCsjsLrLGBnDZxoXpl0WGmNJq81Dn4fb9Cj/ZqGz+M0nL3eMR8wV
 33X8bSQYggDJWDfFxYZQyq2OSrd+Qm921k65B6qYdvIuYnb3JIGMApT2D9OAYegxWb7uMemtfQ2
 gdr8oSX51Yh6tR2zXkOsiKJL85fxlNW4OL5rwdtEMFYMTxfUUm5m5rxsW3u1Oj1Q==
X-Received: by 2002:a05:620a:171e:b0:8ca:1107:1215 with SMTP id
 af79cd13be357-8cbc8dc499bmr862435485a.9.1772330868724; 
 Sat, 28 Feb 2026 18:07:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:48 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 13/23] net/pcap: add link status for interface mode
Date: Sat, 28 Feb 2026 18:05:46 -0800
Message-ID: <20260301020726.852401-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260301020726.852401-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260301020726.852401-1-stephen@networkplumber.org>
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

Add OS-dependent function to query the real link state from
the underlying interface.

Linux and FreeBSD use SIOCGIFFLAGS to check IFF_UP and
IFF_RUNNING. Windows uses GetAdaptersAddresses() to check
OperStatus.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 38 +++++++++-----
 drivers/net/pcap/pcap_osdep.h          | 12 +++++
 drivers/net/pcap/pcap_osdep_freebsd.c  | 31 ++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c    | 27 ++++++++++
 drivers/net/pcap/pcap_osdep_windows.c  | 68 +++++++++++++++++++++-----
 6 files changed, 154 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 63f554878d..f117c4975e 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -109,6 +109,7 @@ New Features
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
+  * Added support for reporting link state in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index f1f148ce3a..86e0380536 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -150,13 +150,6 @@ static const char *valid_arguments[] = {
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
@@ -952,10 +945,28 @@ eth_dev_close(struct rte_eth_dev *dev)
 }
 
 static int
-eth_link_update(struct rte_eth_dev *dev __rte_unused,
-		int wait_to_complete __rte_unused)
+eth_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 {
-	return 0;
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_link link = {
+		.link_speed = RTE_ETH_SPEED_NUM_10G,
+		.link_duplex = RTE_ETH_LINK_FULL_DUPLEX,
+		.link_autoneg = RTE_ETH_LINK_FIXED,
+	};
+
+	/*
+	 * For pass-through mode (single_iface), query whether the
+	 * underlying interface is up. Otherwise use default values.
+	 */
+	if (internals->single_iface) {
+		link.link_status = (osdep_iface_link_status(internals->rx_queue[0].name) > 0) ?
+			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	} else {
+		link.link_status = dev->data->dev_started ?
+			RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	}
+
+	return rte_eth_linkstatus_set(dev, &link);
 }
 
 static int
@@ -1370,7 +1381,12 @@ pmd_init_internals(struct rte_vdev_device *vdev,
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
index fe7399ff9f..18e63c6f2b 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -10,6 +10,7 @@
 
 #define PMD_LOG(level, ...) \
 	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s(): ", __func__, __VA_ARGS__)
+
 extern int eth_pcap_logtype;
 #define RTE_LOGTYPE_ETH_PCAP eth_pcap_logtype
 
@@ -30,4 +31,15 @@ extern int eth_pcap_logtype;
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
 
+/**
+ * Get link status for a network interface.
+ *
+ * @param name
+ *   Interface name (e.g., "eth0" on Linux, "{GUID}" on Windows).
+ * @return
+ *   1 if link is up, 0 if link is down, -1 on error.
+ */
+int osdep_iface_link_status(const char *name);
+
+
 #endif
diff --git a/drivers/net/pcap/pcap_osdep_freebsd.c b/drivers/net/pcap/pcap_osdep_freebsd.c
index 0185665f0b..9c4186aadc 100644
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
@@ -55,3 +60,29 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	free(buf);
 	return 0;
 }
+
+int
+osdep_iface_link_status(const char *if_name)
+{
+	struct ifmediareq ifmr;
+	int fd, status = 0;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd == -1)
+		return -1;
+
+	memset(&ifmr, 0, sizeof(ifmr));
+	strlcpy(ifmr.ifm_name, if_name, sizeof(ifmr.ifm_name));
+
+	if (ioctl(fd, SIOCGIFMEDIA, &ifmr) == 0) {
+		/* IFM_AVALID means status is valid, IFM_ACTIVE means link up */
+		if ((ifmr.ifm_status & IFM_AVALID) &&
+		    (ifmr.ifm_status & IFM_ACTIVE))
+			status = 1;
+	} else {
+		status = -1;
+	}
+
+	close(fd);
+	return status;
+}
diff --git a/drivers/net/pcap/pcap_osdep_linux.c b/drivers/net/pcap/pcap_osdep_linux.c
index df976417cb..f61b7bd146 100644
--- a/drivers/net/pcap/pcap_osdep_linux.c
+++ b/drivers/net/pcap/pcap_osdep_linux.c
@@ -40,3 +40,30 @@ osdep_iface_mac_get(const char *if_name, struct rte_ether_addr *mac)
 	close(if_fd);
 	return 0;
 }
+
+int
+osdep_iface_link_status(const char *if_name)
+{
+	struct ifreq ifr;
+	int fd, status = 0;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd == -1)
+		return -1;
+
+	rte_strscpy(ifr.ifr_name, if_name, sizeof(ifr.ifr_name));
+	if (ioctl(fd, SIOCGIFFLAGS, &ifr) == 0) {
+		/*
+		 * IFF_UP means administratively up.
+		 * IFF_RUNNING means operationally up (carrier detected).
+		 * Both must be set for link to be considered up.
+		 */
+		if ((ifr.ifr_flags & IFF_UP) && (ifr.ifr_flags & IFF_RUNNING))
+			status = 1;
+	} else {
+		status = -1;
+	}
+
+	close(fd);
+	return status;
+}
diff --git a/drivers/net/pcap/pcap_osdep_windows.c b/drivers/net/pcap/pcap_osdep_windows.c
index 0965c2f5c9..e7a49c47e0 100644
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
 		PMD_LOG(ERR, "GetAdapterAddresses() = %lu, expected %lu",
 			sys_ret, ERROR_BUFFER_OVERFLOW);
-		return -1;
+		return NULL;
 	}
 
 	info = (IP_ADAPTER_ADDRESSES *)malloc(size);
 	if (info == NULL) {
 		PMD_LOG(ERR, "Cannot allocate adapter address info");
-		return -1;
+		return NULL;
 	}
 
 	sys_ret = GetAdaptersAddresses(AF_UNSPEC, 0, NULL, info, &size);
 	if (sys_ret != ERROR_SUCCESS) {
 		PMD_LOG(ERR, "GetAdapterAddresses() = %lu", sys_ret);
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
@@ -116,3 +134,29 @@ osdep_iface_mac_get(const char *device_name, struct rte_ether_addr *mac)
 	free(info);
 	return ret;
 }
+
+int
+osdep_iface_link_status(const char *device_name)
+{
+	IP_ADAPTER_ADDRESSES *info, *cur;
+	const char *adapter_name;
+	int ret = -1;
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
+			ret = (cur->OperStatus == IfOperStatusUp) ? 1 : 0;
+			break;
+		}
+	}
+
+	free(info);
+	return ret;
+}
-- 
2.51.0

