Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98C7C44529
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:11:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D68B406B8;
	Tue, 21 Jul 2026 14:11:42 +0200 (CEST)
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by mails.dpdk.org (Postfix) with ESMTP id 83E7E40687
 for <dev@dpdk.org>; Tue, 21 Jul 2026 14:11:40 +0200 (CEST)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-668432d533dso3568200d50.3
 for <dev@dpdk.org>; Tue, 21 Jul 2026 05:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1784635900; x=1785240700; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Tl6VkR5xW0JbYefHIS1riAmGWgbfSkT9ymO7y9eDIts=;
 b=IQ1v2FbUr1dxEmEDwe+0YUx/MI9YTM3YOV26E+jJdNxJS8/QOHy9dlqwlLum9S1mmZ
 x5t+o6v7TM2qTAq6EauQt0nbO2B3YtjvSGXCqbeRbhdoOHj9aPpM1Dl2h5oABRRtFLSn
 Em+ce9nZ3B8ZMVODQQN+AR2r6P2eYhGRvMwsEmxtUiVDly9wcloKAcUWeZUECSz9qbIq
 hm+5EKxGLkxMyn9Lt6uwfSOOHkZ2x4X4A/no1VId0M5ZcZ88f+IwWqeRwn+p2/wk0DJO
 vGwhva/qre8Y1Goz1zqHzYibe1szzdRxZS3xLMQA9ha3vZA2kvI9jO/1wHYDgStTfIAA
 xoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784635900; x=1785240700;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tl6VkR5xW0JbYefHIS1riAmGWgbfSkT9ymO7y9eDIts=;
 b=JEKBGD9on0q2Do1C2WGXLcGxzNnt6r8C+bPW/U2dgkSkgpnedkVe5Qp9l+MveS3FOf
 lpQvXwacX+/9l/dUMC1OJ/YPIrlSFscqdsD5N4ECa/dQG1pClloLz5s7Efz3qTmFKAU6
 Ul6JtTvtmZIAgiNnvq6+YPf8V09pUGqy3WSkC6idsXzqjWWT81PGHBPgsfuSgXJvREae
 kUP/iZXK7hY4XortbNFhMNDqW4lvKMgQt2WZO6rxsTEzHBf6QMwsP3M/0ROTbn3aOv6X
 1hPYBwc/oK2W5QVaLbB6vJ0C+G1DQ+rgIH3LYZ+U+5rKo4Hn/auMgtsNbPiR6KS+iTe2
 7rtg==
X-Gm-Message-State: AOJu0YzbMvdPwEf+15i3Pw4Oyapmrur1MdwN7oKLj3nEF5BryzUR73eP
 E61bZJltuKQLpWAgnTXZif3jrCCZ75qtL1ifHIFVAjVePmTfQXlqpz1cyV/z8d4sM0gDfJZ3yRp
 W2gvt2Yd2Qr6OuKQ8LpQZN6oEKNwcqVeFOq6C33BK2rQ8Kcb5LKWZAyM82gjAT7m+bj6YDCbCnm
 /SaPiwzZp6rdeWEwCN3Exy4pU=
X-Received: from yxoo12.prod.google.com ([2002:a05:690e:24cc:b0:667:f73c:509b])
 (user=blasko job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:d14d:0:b0:667:af05:2e89
 with SMTP id 956f58d0204a3-6683bdcf691mr3495027d50.74.1784635899461; Tue, 21
 Jul 2026 05:11:39 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:11:28 +0000
In-Reply-To: <20260721121129.2911774-1-blasko@google.com>
Mime-Version: 1.0
References: <20260623215325.814776-1-blasko@google.com>
 <20260721121129.2911774-1-blasko@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721121129.2911774-3-blasko@google.com>
Subject: [PATCH v3 2/2] net/af_xdp: add read_clock support to AF_XDP PMD
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
v3:
  - Add feature description and PTP hardware clock prerequisites in
    doc/guides/nics/af_xdp.rst.
  - Add release notes entry in doc/guides/rel_notes/release_26_07.rst.
  - Add PTP file descriptor cleanup in eth_dev_start(), eth_dev_stop(),
    and eth_dev_close().
  - Return -errno on clock_gettime() failure.
  - Add strerror(errno) error logging on PTP device open failure.
v2:
  - New patch introduced in v2 to support read_clock ethdev operation.
---

 doc/guides/nics/af_xdp.rst             | 12 ++++
 doc/guides/rel_notes/release_26_07.rst |  1 +
 drivers/net/af_xdp/rte_eth_af_xdp.c    | 87 ++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/doc/guides/nics/af_xdp.rst b/doc/guides/nics/af_xdp.rst
index 367a1b0507..3ef02f90a2 100644
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
@@ -242,6 +245,15 @@ to verify timestamp validity at ``xdp_meta_valid_hint_offset``.
 
     --vdev net_af_xdp,iface=ens786f1,xdp_meta_rx_ts_offset=8,xdp_meta_valid_hint_offset=4,xdp_meta_rx_ts_valid_mask=0x1
 
+read_clock
+~~~~~~~~~~
+
+The PMD supports querying the underlying PTP hardware clock time via
+``rte_eth_read_clock()``. When the timestamp offload
+``RTE_ETH_RX_OFFLOAD_TIMESTAMP`` is enabled, the PMD automatically discovers
+the hardware PHC index via ethtool and opens the PTP character device
+(``/dev/ptpX``).
+
 Limitations
 -----------
 
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8af0b8d615..326c35243b 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -140,6 +140,7 @@ New Features
   * Added support for RX metadata hardware timestamping via vdev devargs
     ``xdp_meta_rx_ts_offset``, ``xdp_meta_valid_hint_offset``, and
     ``xdp_meta_rx_ts_valid_mask``.
+  * Added ``read_clock`` operation to query the PTP hardware clock.
 
 * **Updated Google gve driver.**
 
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index e047870530..b9a5bfe74f 100644
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
@@ -194,6 +197,7 @@ struct pmd_internals {
 	int rx_timestamp_offset;
 	int rx_timestamp_valid_offset;
 	uint8_t rx_timestamp_valid_mask;
+	int ptp_fd;
 };
 
 struct pmd_process_private {
@@ -837,6 +841,30 @@ eth_af_xdp_enable_hw_timestamping(const char *if_name)
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
@@ -871,6 +899,26 @@ eth_dev_start(struct rte_eth_dev *dev)
 				internals->if_name, strerror(-rc));
 			return rc;
 		}
+
+		int phc_index = eth_af_xdp_get_ptp_index(internals->if_name);
+		if (phc_index >= 0) {
+			char ptp_dev[32];
+			snprintf(ptp_dev, sizeof(ptp_dev), "/dev/ptp%d", phc_index);
+			if (internals->ptp_fd >= 0) {
+				close(internals->ptp_fd);
+				internals->ptp_fd = -1;
+			}
+			internals->ptp_fd = open(ptp_dev, O_RDONLY);
+			if (internals->ptp_fd >= 0) {
+				AF_XDP_LOG_LINE(INFO,
+					"Opened PTP device %s for read_clock",
+					ptp_dev);
+			} else {
+				AF_XDP_LOG_LINE(WARNING,
+					"Failed to open PTP device %s for read_clock: %s",
+					ptp_dev, strerror(errno));
+			}
+		}
 	}
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
@@ -886,6 +934,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 static int
 eth_dev_stop(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
 	uint16_t i;
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
@@ -894,6 +943,11 @@ eth_dev_stop(struct rte_eth_dev *dev)
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
 	}
 
+	if (internals->ptp_fd >= 0) {
+		close(internals->ptp_fd);
+		internals->ptp_fd = -1;
+	}
+
 	return 0;
 }
 
@@ -1227,6 +1281,11 @@ eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
+	if (internals->ptp_fd >= 0) {
+		close(internals->ptp_fd);
+		internals->ptp_fd = -1;
+	}
+
 out:
 	rte_free(dev->process_private);
 
@@ -2096,6 +2155,31 @@ eth_dev_promiscuous_disable(struct rte_eth_dev *dev)
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
+		return -errno;
+
+	*timestamp = rte_timespec_to_ns(&ts);
+	return 0;
+}
+
 static const struct eth_dev_ops ops = {
 	.dev_start = eth_dev_start,
 	.dev_stop = eth_dev_stop,
@@ -2111,6 +2195,7 @@ static const struct eth_dev_ops ops = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /* AF_XDP Device Plugin option works in unprivileged
@@ -2132,6 +2217,7 @@ static const struct eth_dev_ops ops_afxdp_dp = {
 	.stats_get = eth_stats_get,
 	.stats_reset = eth_stats_reset,
 	.get_monitor_addr = eth_get_monitor_addr,
+	.read_clock = eth_af_xdp_read_clock,
 };
 
 /** parse busy_budget argument */
@@ -2440,6 +2526,7 @@ init_internals(struct rte_vdev_device *dev, const char *if_name,
 	internals->rx_timestamp_offset = rx_timestamp_offset;
 	internals->rx_timestamp_valid_offset = rx_timestamp_valid_offset;
 	internals->rx_timestamp_valid_mask = (uint8_t)rx_timestamp_valid_mask;
+	internals->ptp_fd = -1;
 
 	if (xdp_get_channels_info(if_name, &internals->max_queue_cnt,
 				  &internals->configured_queue_cnt)) {
-- 
2.55.0.229.g6434b31f56-goog

