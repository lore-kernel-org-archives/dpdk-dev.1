Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F4DC43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 22:10:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC59940B94;
	Sat, 11 Jul 2026 00:10:22 +0200 (CEST)
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com
 [209.85.219.73]) by mails.dpdk.org (Postfix) with ESMTP id 5B4614065A
 for <dev@dpdk.org>; Sat, 11 Jul 2026 00:10:21 +0200 (CEST)
Received: by mail-qv1-f73.google.com with SMTP id
 6a1803df08f44-8f45dde7595so17871316d6.3
 for <dev@dpdk.org>; Fri, 10 Jul 2026 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783721421; x=1784326221; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=yR+cSJ8xFXNmlPSMOucLv2pwk+KcK1SbHqxAdPaALPo=;
 b=pRSWtDsH2zXw2DoAG1H8TiwpkoDMOducv/w4bI6TD4OJ9hz3ahsGN/nopqPS9XfFoe
 JieZlHi/8yFkvqBZiUFpIon5KbMyFkGFL1OZvu+sjjw6gu5Tuh3P91dL2fuYt5RkNuTn
 fWqDS3xVcCYT+orqhybSEOpcIQBp0jNbGlaHsaAvhkH7GTOeLW3CMnPuPe3iPuG2tjx/
 F9OXX0HhQVzeqQcjqekwf4+fCzSFLwAL3rfaxfRlzwIzp3RKeUB/8xuqqTgujvVYSjjX
 6ssIf4gOo0GVkWg4nq/nO9g+E5aA38OYRsILpZQHXfO0CUvC7/YyupDseQftRujfR5Dr
 /nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783721421; x=1784326221;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yR+cSJ8xFXNmlPSMOucLv2pwk+KcK1SbHqxAdPaALPo=;
 b=m7NnbpRyArQ96yV6SWH/ztNnbLRFetagpLF0Q8cnr2EQ9mv+Z88sjKH6q1lOX97ETV
 ri4ON7JC4B0kPlUi8/MAvKapHptdRrfonr/BfsHjR3ym6/S2u4O1A1wvzCMhDZD2Ku3H
 l19ZUPe5NnINuWunJDWtVF0ScQc++dvGJ5PN6p2Y18kwZC4f2xqhTwiBuck9FDAM71yI
 jGLT2ZxKF3TUsjp4XP8Vwz3R9sGz5IzNv/UyR3am2J9luSgdVYAGJ6iOSXZWiHYzSLNN
 rGfDy5UG++hJSWKz+Dsb10KsgGae9eJmYA84TUgfJDqbMbssHCjnHcXMOE+tq+BaoDGq
 8ifA==
X-Gm-Message-State: AOJu0Yzs7WqIc+ANbD1/tSDKRkwfm1DbJRltNN77G40vZL9F+UXAgwFb
 cEv1+YGymUkLCYv0AENR16V57zMktLdm+/wqQDFPDJigsO8ucX2o6tNlLzIXG1NXrJRlDSqWncC
 i5yWofp1+bD0jtZxs6jVkDLHJ2MpWy5SZaAnKRbrVwOkmy+0kjD4FCtlWzPW/MWHhPCPxbqyT39
 tSWm6krBATzEB4oruedRWLXm4=
X-Received: from qvbj4.prod.google.com ([2002:a0c:f004:0:b0:8ff:97d7:249a])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3b86:b0:8e9:f62b:8f9c
 with SMTP id 6a1803df08f44-9040197e2d5mr10225666d6.49.1783721420301; Fri, 10
 Jul 2026 15:10:20 -0700 (PDT)
Date: Fri, 10 Jul 2026 22:10:12 +0000
In-Reply-To: <20260710221013.3913447-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260710221013.3913447-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260710221013.3913447-3-blasko@google.com>
Subject: [PATCH v2 2/2] net/af_xdp: add read_clock support to AF_XDP PMD
From: Mark Blasko <blasko@google.com>
To: dev@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>
Cc: joshwash@google.com, jtranoleary@google.com, blasko@google.com
Content-Type: text/plain; charset="UTF-8"
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

Implement the ethdev read_clock operation in the AF_XDP Poll Mode
Driver. This allows DPDK applications to query the current time of the
NIC hardware clock.

At device start, the PMD queries ethtool for the interface's PTP
Hardware Clock index and opens the corresponding PTP device node. The
read_clock operation queries the current time via clock_gettime.

Signed-off-by: Mark Blasko <blasko@google.com>
Reviewed-by: Joshua Washington <joshwash@google.com>
---
v2:
  - New patch introduced in v2 to support read_clock ethdev operation.
---
 drivers/net/af_xdp/rte_eth_af_xdp.c | 127 ++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 2f9ad7d180..410be570a0 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -15,6 +15,7 @@
 #include <linux/if_link.h>
 #include <linux/ethtool.h>
 #include <linux/sockios.h>
+#include <linux/net_tstamp.h>
 #include "af_xdp_deps.h"
 
 #include <rte_ethdev.h>
@@ -28,6 +29,7 @@
 #include <dev_driver.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
+#include <rte_time.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -62,6 +64,9 @@
 #define PF_XDP AF_XDP
 #endif
 
+#include <fcntl.h>
+#include <time.h>
+
 
 static int timestamp_dynfield_offset = -1;
 static uint64_t timestamp_dynflag;
@@ -194,6 +199,7 @@ struct pmd_internals {
 	int rx_timestamp_offset;
 	int rx_timestamp_valid_offset;
 	uint8_t rx_timestamp_valid_mask;
+	int ptp_fd;
 };
 
 struct pmd_process_private {
@@ -795,9 +801,72 @@ eth_af_xdp_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 #endif
 }
 
+static int
+eth_af_xdp_enable_hw_timestamping(const char *if_name)
+{
+	struct hwtstamp_config config = {0};
+	struct ifreq ifr = {0};
+	int fd, ret;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	ifr.ifr_data = (caddr_t)&config;
+	strlcpy(ifr.ifr_name, if_name, IFNAMSIZ);
+
+	ret = ioctl(fd, SIOCGHWTSTAMP, &ifr);
+	if (ret == 0) {
+		if (config.rx_filter != HWTSTAMP_FILTER_NONE) {
+			close(fd);
+			return 0;
+		}
+	}
+
+	config.flags = 0;
+	config.tx_type = HWTSTAMP_TX_OFF;
+	config.rx_filter = HWTSTAMP_FILTER_ALL;
+
+	ret = ioctl(fd, SIOCSHWTSTAMP, &ifr);
+	close(fd);
+
+	if (ret < 0)
+		return -errno;
+
+	if (config.rx_filter == HWTSTAMP_FILTER_NONE)
+		return -ENOTSUP;
+
+	return 0;
+}
+
+static int
+eth_af_xdp_get_ptp_index(const char *if_name)
+{
+	struct ethtool_ts_info info = {0};
+	struct ifreq ifr = {0};
+	int fd, ret;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return -1;
+
+	ifr.ifr_data = (caddr_t)&info;
+	info.cmd = ETHTOOL_GET_TS_INFO;
+	strlcpy(ifr.ifr_name, if_name, IFNAMSIZ);
+
+	ret = ioctl(fd, SIOCETHTOOL, &ifr);
+	close(fd);
+
+	if (ret < 0)
+		return -1;
+
+	return info.phc_index;
+}
+
 static int
 eth_dev_start(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
 	uint16_t i;
 
 	if (dev->data->dev_conf.rxmode.offloads &
@@ -814,6 +883,25 @@ eth_dev_start(struct rte_eth_dev *dev)
 		AF_XDP_LOG_LINE(INFO,
 			"Registered mbuf timestamp field, offset: %d",
 			timestamp_dynfield_offset);
+
+		rc = eth_af_xdp_enable_hw_timestamping(internals->if_name);
+		if (rc < 0) {
+			AF_XDP_LOG_LINE(WARNING,
+				"Could not enable HW timestamping on %s: %s",
+				internals->if_name, strerror(-rc));
+		}
+
+		int phc_index = eth_af_xdp_get_ptp_index(internals->if_name);
+		if (phc_index >= 0) {
+			char ptp_dev[32];
+			snprintf(ptp_dev, sizeof(ptp_dev), "/dev/ptp%d", phc_index);
+			internals->ptp_fd = open(ptp_dev, O_RDONLY);
+			if (internals->ptp_fd >= 0) {
+				AF_XDP_LOG_LINE(INFO,
+					"Opened PTP device %s for read_clock",
+					ptp_dev);
+			}
+		}
 	}
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
@@ -829,6 +917,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 static int
 eth_dev_stop(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
 	uint16_t i;
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
@@ -837,6 +926,11 @@ eth_dev_stop(struct rte_eth_dev *dev)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
 
+	if (internals->ptp_fd >= 0) {
+		close(internals->ptp_fd);
+		internals->ptp_fd = -1;
+	}
+
 	return 0;
 }
 
@@ -1170,6 +1264,11 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (internals->ptp_fd >= 0) {
+		close(internals->ptp_fd);
+		internals->ptp_fd = -1;
+	}
+
 out:
 	rte_free(dev->process_private);
 
@@ -2039,6 +2138,31 @@ eth_dev_promiscuous_disable(struct rte_eth_dev *dev)
 	return eth_dev_change_flags(internals->if_name, 0, ~IFF_PROMISC);
 }
 
+/*
+ * In Linux, dynamic POSIX clock IDs from file descriptors (such as /dev/ptpX)
+ * are encoded with CLOCKFD (3) in the lower 3 bits and ~fd in the upper bits.
+ * As this is not defined in user-space UAPI headers, define the macro here.
+ */
+#define CLOCKFD 3
+#define FD_TO_CLOCKID(fd)	((clockid_t)(~(unsigned int)(fd) << 3 | CLOCKFD))
+
+static int
+eth_af_xdp_read_clock(struct rte_eth_dev *dev, uint64_t *timestamp)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct timespec ts;
+
+	if (internals->ptp_fd < 0)
+		return -ENOTSUP;
+
+	clockid_t clkid = FD_TO_CLOCKID(internals->ptp_fd);
+	if (clock_gettime(clkid, &ts) < 0)
+		return -1;
+
+	*timestamp = rte_timespec_to_ns(&ts);
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -2054,6 +2178,7 @@ static const struct eth_dev_ops ops = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /* AF_XDP Device Plugin option works in unprivileged
@@ -2075,6 +2200,7 @@ static const struct eth_dev_ops ops_afxdp_dp = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /** parse busy_budget argument */
@@ -2399,6 +2525,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->rx_timestamp_offset = rx_timestamp_offset;
 	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
 	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
+	internals->ptp_fd = -1;
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
-- 
2.55.0.141.g00534a21ce-goog

