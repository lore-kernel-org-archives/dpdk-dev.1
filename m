Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61375F8D766
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E94E340DF6;
	Thu, 16 Apr 2026 20:52:06 +0200 (CEST)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by mails.dpdk.org (Postfix) with ESMTP id AD7D940B8C
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:02 +0200 (CEST)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c565476d7so260558c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365522;
 x=1776970322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8OQnNu5UIv1XR2kFaYgcEaN4sWmmoR2sOSwHfrUSIQ=;
 b=n3dTO/xw0ag+gy1MRK4VWlL2BNR5yl8Uf7aERWeHlwAFifjLBuVzOfZkLne6ixYbV7
 NDdhSrWJ63jdNjpPbW18E9uGDRhaEe2PbRXu9/11ZqsSqsMsu0Xq8e9T4VcRv7z6UzTm
 6C0i8qxae/4l2GHiVIMCHwdKc1RWslBK6h1U0iVPXAtdf2Vz7dEtN83iDLS3u+jdww/9
 C1oCr69IK/y+qJ9kCnMq+UVpaYVDb5oM7cKcUQLAcZ5Qvesh+ff84hIa7atnJ3+sufK3
 HnVAqyaK9ILTL5PTtToQQpJfYKXu2o7coXK06YJGG656yLMR/dx3FsGcKYJSkCMhb5Na
 kQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365522; x=1776970322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n8OQnNu5UIv1XR2kFaYgcEaN4sWmmoR2sOSwHfrUSIQ=;
 b=R//iyPna1BzJY9mLng1jbCmCpd0oFE5WAeje6kZ/phgCU23FntJs2I0JlARzBzJ52I
 XeWCg+BiIKAvDLrZkttKnqiQsP54TG6Mj2CM6mZGmoBJlqDSzdQPsJ5p2qDQOTorKTLs
 paNSyMqBoyGQ26j32XFF1GTboHQIxn79RGmmt7DP58wABiRNirTSxaOsZGdT4qMIDRqn
 euHiesc6sOaD4tKNhEvsExSskdiRbteegydi5bm7wbQMyXnOL0SrlKY7DrsF4h0OYCFi
 soTDygvVOe9Fp/rK/N2JC8p/OSqV1UfosNL2zF7GU/XoVJjwXVssHK46+21zT53d7q0b
 7CBw==
X-Gm-Message-State: AOJu0YxdQnWtKxwOuVoFKwoZCHlezC8s0WSOPDf18pbYZTJ9a28epo+g
 JPr0maL4mG6HDjzR3OVTp4IplF5OqURGgXtF/mFQHiSdg8lxjBP3JCLdGGmzh472NT2R/0xeAw0
 LmHVI
X-Gm-Gg: AeBDiev8de7aPBT6+OlinuMTz9Ox5d90Rq2GJ0wXAy6+jxjCmYjsD/U1DfBWGJXM/Fn
 RRWM47V0WYuPBh0VrnTpX/jf3u/d+Rtf/95VrfjECB/6nipmjDU3rkq7CONUP/nQb2N895Lj3i3
 jE89jZnait8crhqP3Vhs4Yg9R4XDTroJuUD3quwSC20V/HHtmPTInYeseTU06nX6xTOa5MeH8FP
 nnu35oLDuhjADjBfpStIyC1YgKdxMxA/uIeBwDBJDNwI7U1F+Ql+qegif7x+K9XtzlSGIsYs8Nv
 Re0oc8nsKP2Iax0F60KYE+uM4Lt504JIQn0snYT3C2iwytPkVemOT8dWIAFlIqV4Ub+NO6yD3nO
 wdG4p8v/iG7qWyJoDRqycV4jY1AUW6qwtUIIDjTcSxTdwZjWiUfQsjmtr7eg3uNRkhm+rgKnjyW
 ecxUBWv3TZhINpGrUgU8IxmYW9jB0Kv3fqnvwYkn7Jdfc=
X-Received: by 2002:a05:7300:b58b:b0:2d9:fa9c:87a9 with SMTP id
 5a478bee46e88-2e2e348a4eamr275992eec.5.1776365521676; 
 Thu, 16 Apr 2026 11:52:01 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 14/24] net/pcap: add link status for interface mode
Date: Thu, 16 Apr 2026 11:48:31 -0700
Message-ID: <20260416185144.1359260-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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
 doc/guides/rel_notes/release_26_07.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 38 +++++++++-----
 drivers/net/pcap/pcap_osdep.h          | 12 +++++
 drivers/net/pcap/pcap_osdep_freebsd.c  | 31 ++++++++++++
 drivers/net/pcap/pcap_osdep_linux.c    | 27 ++++++++++
 drivers/net/pcap/pcap_osdep_windows.c  | 68 +++++++++++++++++++++-----
 6 files changed, 154 insertions(+), 23 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f6af296684..b377716cd0 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -66,6 +66,7 @@ New Features
 * **Updated PCAP ethernet driver.**
 
   * Added support for VLAN insertion and stripping.
+  * Added support for reporting link state in ``iface`` mode.
 
 
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 0bd95d6f01..daee7f1d97 100644
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
@@ -967,10 +960,28 @@ eth_dev_close(struct rte_eth_dev *dev)
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
@@ -1384,7 +1395,12 @@ pmd_init_internals(struct rte_vdev_device *vdev,
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

