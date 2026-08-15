Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12804C5CFC1
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Aug 2026 00:46:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46538402EF;
	Sat, 15 Aug 2026 02:46:08 +0200 (CEST)
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by mails.dpdk.org (Postfix) with ESMTP id AEBB94028B
 for <dev@dpdk.org>; Sat, 15 Aug 2026 02:46:05 +0200 (CEST)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ab1cf1cceso4015760d50.2
 for <dev@dpdk.org>; Fri, 14 Aug 2026 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786754765; x=1787359565; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D1lLCHEe3sscwqk26mJjMuLkSUiCo55eqn5/j/aSJI4=;
 b=tk0lvLmE/WCPLAM5JKhjCg0EAAXKRo2SHp9yuXtisQm5la9zMhKBc++rD6L0o/b2P4
 P19ZvPATd37gC+fb8QFrshCWvAPUs04WjvMn3bJjJtWFgCUSQPnHRqMViQj/HqPJankH
 m4C56Nxq6TZevz+AjADc5IDmkMMVoN02fWhO8Njxx6MaBWeJ7TdRaRRlI2/SeVh/5Mk4
 ug9GdSsOmR3no91cMuXGEvWes7ou/TM9RbHDulI2XpfqiDfZczQm4aYT7d5WnQICZHWQ
 9kt6+d31GCxRevCHIgKr8QxqiL88z4dCYVEsjfW3IINaUXv1+Vhi6l+VNXRFXXi1BqL1
 D9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786754765; x=1787359565;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D1lLCHEe3sscwqk26mJjMuLkSUiCo55eqn5/j/aSJI4=;
 b=XUSp5OZiYepupBgTHwg1EWe2AUjSYcS8vEnL2/preIIosGV5LDqBoJmKea+9MUG3QW
 2iIipab3rLoa4m/IS21JOMbNYZrnGYfqa3mB+ccciYme1hbUG719SQlB75wXBMmd2n0F
 B7pF0UdDKe1q/C3hV1xOPkXmIncgmlIvlh1nz/BWOnZTDP7cliHVO+5K3+yQFtDVUbg+
 auvg6D/Xvmu1G5J6NCOyeJnrkgYvM1tAV08U2hyKvSFcXUj1Um1FFEGWVu3UNizyJOg/
 0shDOGkKZH1V209+U+SZi/Qor5FP4Ncz+Ng2Br/MS9yxaSTm9TaDeFJtcUDgw3FPsVZJ
 GbaA==
X-Gm-Message-State: AOJu0Yyw0ebxiQJgW50afSqRVWpHaXHN3b8A3jfE76CFEjfOsyK/wdx6
 fAwpjbTLR5OFPYOiUXs2EPOyK+coCf+lG63v4whFSX+6OR5Yofqe4DC+x6PBe1b5oe8wtwKxDje
 dG8/N7g64C2t4BhYbP9bMd/tnW4M461/rPYtLFMPDynFi6HyFiWp2KL2f5+wflr9TRSf09lKKCp
 paHiz9d6vF7LS/DUkYP2Jn4uo=
X-Received: from yxsz9.prod.google.com ([2002:a53:c9c9:0:b0:663:6110:dcf4])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4846:b0:668:9a36:b22a
 with SMTP id 956f58d0204a3-66c72d3b344mr2801407d50.47.1786754764789; Fri, 14
 Aug 2026 17:46:04 -0700 (PDT)
Date: Sat, 15 Aug 2026 00:45:52 +0000
In-Reply-To: <20260815004553.3479994-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260815004553.3479994-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815004553.3479994-3-blasko@google.com>
Subject: [PATCH v6 2/2] net/af_xdp: add read_clock support to AF_XDP PMD
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
v6:
- Move ptp_fd cleanup in eth_dev_close() below out: label.
- Change PTP open failure log level from WARNING to INFO in eth_dev_start().
v5:
- Update release notes for 26.11.
v4:
- Move ptp_fd into pmd_process_private for multi-process safety.
- Decouple /dev/ptpX opening from RTE_ETH_RX_OFFLOAD_TIMESTAMP.
- Move read_clock documentation out of "Options" into its own section
  in af_xdp.rst.
- Add #ifndef guards around CLOCKFD and FD_TO_CLOCKID macro definitions.
- Replace (caddr_t) cast with (void *).
v3:
- Add documentation and release notes entry.
- Add PTP file descriptor cleanup on device start, stop, and close.
- Return -errno on clock_gettime() failure and fix PTP open error logging.
 doc/guides/nics/af_xdp.rst             | 11 +++
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 99 ++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index 94e47a2ab9..d6b3cea533 100644
--- a/doc/guides/nics/af_xdp.rst
+++ b/doc/guides/nics/af_xdp.rst
@@ -37,6 +37,9 @@ Prerequisites
    header is used to determine the kernel version at compile time.
 *  A kernel with version 5.4 or later is required for 32-bit OS.
 *  The busy polling feature requires kernel version >= v5.11.
+*  The ``read_clock`` feature requires a network interface with PTP
+   Hardware Clock support (capable of exposing a ``/dev/ptpX`` device via
+   ethtool ``ETHTOOL_GET_TS_INFO``).
 
 
 Options
@@ -252,6 +255,14 @@ to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
     hardware filter setting persists on the netdev interface after the DPDK application
     exits.
 
+read_clock
+----------
+
+The PMD supports querying the underlying PTP hardware clock time via
+``rte_eth_read_clock()``. During device start, the PMD automatically discovers
+the hardware PHC index via ethtool and opens the PTP character device
+(``/dev/ptpX``).
+
 Limitations
 -----------
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 1de3db22e9..337a717a89 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,7 @@ New Features
   * Added support for Rx metadata hardware timestamping via vdev devargs
     ``xdp_meta_rx_ts_offset``, ``xdp_meta_valid_hint_offset``, and
     ``xdp_meta_rx_ts_valid_mask``.
+  * Added ``read_clock`` operation to query the PTP hardware clock.
 
 
 Removed Items
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 3368b56a3b..7d335ac70b 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -5,6 +5,8 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <string.h>
+#include <fcntl.h>
+#include <time.h>
 #include <netinet/in.h>
 #include <net/if.h>
 #include <sys/un.h>
@@ -29,6 +31,7 @@
 #include <dev_driver.h>
 #include <rte_eal.h>
 #include <rte_ether.h>
+#include <rte_time.h>
 #include <rte_lcore.h>
 #include <rte_log.h>
 #include <rte_memory.h>
@@ -198,6 +201,7 @@ struct pmd_internals {
 
 struct pmd_process_private {
 	int rxq_xsk_fds[RTE_MAX_QUEUES_PER_PORT];
+	int ptp_fd;
 };
 
 #define ETH_AF_XDP_IFACE_ARG			"iface"
@@ -818,10 +822,35 @@ eth_af_xdp_enable_hw_timestamping(const char *if_name)
 	return 0;
 }
 
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
+	ifr.ifr_data = (void *)&info;
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
 	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_process_private *process_private = dev->process_private;
 	bool rx_timestamp_enabled = false;
 	uint16_t i;
 
@@ -862,6 +891,28 @@ eth_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (process_private != NULL) {
+		int phc_index = eth_af_xdp_get_ptp_index(internals->if_name);
+		if (phc_index >= 0) {
+			char ptp_dev[32];
+			snprintf(ptp_dev, sizeof(ptp_dev), "/dev/ptp%d", phc_index);
+			if (process_private->ptp_fd >= 0) {
+				close(process_private->ptp_fd);
+				process_private->ptp_fd = -1;
+			}
+			process_private->ptp_fd = open(ptp_dev, O_RDONLY);
+			if (process_private->ptp_fd >= 0) {
+				AF_XDP_LOG_LINE(INFO,
+					"Opened PTP device %s for read_clock",
+					ptp_dev);
+			} else {
+				AF_XDP_LOG_LINE(INFO,
+					"Failed to open PTP device %s for read_clock: %s",
+					ptp_dev, strerror(errno));
+			}
+		}
+	}
+
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
@@ -875,6 +926,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 static int
 eth_dev_stop(struct rte_eth_dev *dev)
 {
+	struct pmd_process_private *process_private = dev->process_private;
 	uint16_t i;
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
@@ -883,6 +935,11 @@ eth_dev_stop(struct rte_eth_dev *dev)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
 
+	if (process_private != NULL && process_private->ptp_fd >= 0) {
+		close(process_private->ptp_fd);
+		process_private->ptp_fd = -1;
+	}
+
 	return 0;
 }
 
@@ -1220,6 +1277,14 @@ eth_dev_close(struct rte_eth_dev *dev)
 	}
 
 out:
+	if (dev->process_private != NULL) {
+		struct pmd_process_private *process_private = dev->process_private;
+		if (process_private->ptp_fd >= 0) {
+			close(process_private->ptp_fd);
+			process_private->ptp_fd = -1;
+		}
+	}
+
 	rte_free(dev->process_private);
 
 	return 0;
@@ -2089,6 +2154,35 @@ eth_dev_promiscuous_disable(struct rte_eth_dev *dev)
 	return eth_dev_change_flags(internals->if_name, 0, ~IFF_PROMISC);
 }
 
+/*
+ * In Linux, dynamic POSIX clock IDs from file descriptors (such as /dev/ptpX)
+ * are encoded with CLOCKFD (3) in the lower 3 bits and ~fd in the upper bits.
+ * As this is not defined in user-space UAPI headers, define the macro here.
+ */
+#ifndef CLOCKFD
+#define CLOCKFD 3
+#endif
+#ifndef FD_TO_CLOCKID
+#define FD_TO_CLOCKID(fd)	((clockid_t)(~(unsigned int)(fd) << 3 | CLOCKFD))
+#endif
+
+static int
+eth_af_xdp_read_clock(struct rte_eth_dev *dev, uint64_t *timestamp)
+{
+	struct pmd_process_private *process_private = dev->process_private;
+	struct timespec ts;
+
+	if (process_private == NULL || process_private->ptp_fd < 0)
+		return -ENOTSUP;
+
+	clockid_t clkid = FD_TO_CLOCKID(process_private->ptp_fd);
+	if (clock_gettime(clkid, &ts) < 0)
+		return -errno;
+
+	*timestamp = rte_timespec_to_ns(&ts);
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -2104,6 +2198,7 @@ static const struct eth_dev_ops ops = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /* AF_XDP Device Plugin option works in unprivileged
@@ -2125,6 +2220,7 @@ static const struct eth_dev_ops ops_afxdp_dp = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /** parse busy_budget argument */
@@ -2529,6 +2625,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	eth_dev->tx_pkt_burst = eth_af_xdp_tx;
 	eth_dev->process_private = process_private;
 
+	process_private->ptp_fd = -1;
 	for (i = 0; i < queue_cnt; i++)
 		process_private->rxq_xsk_fds[i] = -1;
 
@@ -2684,6 +2781,8 @@ rte_pmd_af_xdp_probe(struct rte_vdev_device *dev)
 			return -ENOMEM;
 		}
 
+		((struct pmd_process_private *)eth_dev->process_private)->ptp_fd = -1;
+
 		/* Obtain the xsk fds from the primary process. */
 		if (afxdp_mp_request_fds(name, eth_dev))
 			return -1;
-- 
2.55.0.691.gc56d675ccc-goog

