Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE8103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:41:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4261240E4F;
	Wed, 25 Mar 2026 03:40:43 +0100 (CET)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id 1486140E4D
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:40 +0100 (CET)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-2c160cb021cso295707eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406439;
 x=1775011239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SGbNzKK4JK4LW7irZrqNsG/jynFzX63bbcRIehdDlMc=;
 b=rL2IkoD6hwqgV9HO2pzqw0zXCSYEwBl9ZVjnqkc4T+4lkeTIZccu9LxegSix0Iv3ga
 ME6Kt/X5Ow3jqU43a24WEq9G/xCX2YIjJ6c8yNe3QgMvp+6j0JoOsrhMrUuoAfOFYIx0
 1DlLI0VqOm7iHnj2lcUPYqRgqPplNaR926+115lyRtYkUuED8qAmT+ro1eaZOJYltuSH
 odp+yMbNd7FVH+Vk/kdJzyjlNlRrkgMyvZO4UKPtOL979qZpwXYL1wylBQgUoM+jaaxz
 suaHWdOauedSby5KNOdD0P77vJ+9QBZpS/DHuskcf2+8vvVdI6mqrBXjEQ23Qu6JfnMV
 q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406439; x=1775011239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SGbNzKK4JK4LW7irZrqNsG/jynFzX63bbcRIehdDlMc=;
 b=THKcTAsKwuqcWIjx59QZ583zXZLnMV4qP54aEouT5LHhWcte+co2bqTx6HDqvk2nsB
 QNs59L5085BuBimyPZrAZX66e6gc3qXWlFvH+vB8AuvXCXHCbafD2JaY7D2hERzFhJuh
 tjUM6UulpnrQl0OTSAcHS3MNPwA+30Hmx9THs8CoWwk0iqa2l3gIEWpcvNnKtMSV1do/
 n7YIiOOMsFVlFuTMBed2Gk5aJlyBHpqA3d83OLy89ZugrN7pIRgYUy9GO56r7+q/DPY/
 yso3c3uQuqUk3BlXvxCJ/ZZBrFCwm2qLHEFfKruiGfTeh3SXBh1cGnUJSxvZkIHVNkpE
 zYdw==
X-Gm-Message-State: AOJu0YwRl1L4vMTsp8cw4iShSRvWts8r009xeZepDwcm8yKZ/Z5s8dHn
 oorkNxzkvg4TuSl8qcjdsiM8EHpTCgIqcX5ROfD85tAiFIRmIDJcPEtLKODRp8aaQ1BEPb8fIM6
 vEYRn
X-Gm-Gg: ATEYQzzfAnxOk6qzU9HMkNTd89k6W4sgr6ID6H3msGe0cODWv1A+1vdplFcuRy20Pbq
 s9bpKWiB/3AGOoB9NWoKk9+oj0JYt4P34m7gKqjLZhASStyYp0JBXFgAfHViELO09cCdq3vxSG1
 r3tvXq8YXATA7j0IrRCvqHSBc69lKNobK8n4DoEnlT6sqj5DLrtZmaJtmaUnFu9ZFAWr1iSJLao
 xOChrXLwKR/tDhzVp7Nqj1S3wau/IK+nPloH0KdXI24ce/9QwlrDnHdPJswWrgXkKEMCl1vX0Mo
 7yPXTgPXvrTbt0JJkdp7Eu4MjU3+LH3ldymAfP20vyCfM4THk/+oPRNwP7Mde844+f+BUQzF2il
 bZ/GRGS0I2pFwxKjFlE/AHMyQP9+xHaPUqESjrkoEnDOLjp9Zm2YKV9ssQeMFQzBL1LSvWWaWAE
 9J4uGfGE+Pi5AS4llxzk6E9VFSaps44rMr
X-Received: by 2002:a05:7301:4084:b0:2ae:5e93:b69 with SMTP id
 5a478bee46e88-2c15d49e286mr1121164eec.29.1774406439072; 
 Tue, 24 Mar 2026 19:40:39 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 15/25] net/pcap: add link status for interface mode
Date: Tue, 24 Mar 2026 19:37:46 -0700
Message-ID: <20260325024018.1275209-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
index 7a74f732d3..a9ddd872cf 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -139,6 +139,7 @@ New Features
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
+  * Added support for reporting link state in ``iface`` mode.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index c16bff9198..4894e04e8a 100644
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
@@ -941,10 +934,28 @@ eth_dev_close(struct rte_eth_dev *dev)
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
@@ -1358,7 +1369,12 @@ pmd_init_internals(struct rte_vdev_device *vdev,
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
2.53.0

