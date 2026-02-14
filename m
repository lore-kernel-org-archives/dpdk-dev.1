Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB53EF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:47:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 717F140612;
	Sun, 15 Feb 2026 00:47:38 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 23673402ED
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:36 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4837f27cf2dso4170655e9.2
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112855;
 x=1771717655; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPRm3hpNQSwVafH7wrzyM8IK9XgL7XBbuGruXzOyVG8=;
 b=XRJrpKY0l+q2TsUnRUzSnAgHjYzw9PxzFzYQmT95hXdoPPpQAudFthsOx63R02ghYB
 9RV2JQZgFlOe/GIHaE2QFOKqqlPkzKqjUUGcd3qJStP1sBBXz4LSY/tir4yduz8Pi0hX
 OdS+ur/q9Bb7s2U1ipkE5B11sDfQiHdjQiIzyQIfHQ/WQ6M24baBldylvk4xVhhMF7vx
 2D2BSn9DVafHypzNytrk1ql/dASLKvFB5iuHcCluqRE61mBisuiSFvW62iwpQppqc2dv
 ELmAL+mDgR8wfZtzWN5Yv+hofAp2Q4AMc3b/P4aXh223c8OcNAY4ZR4nwrJpDUgCrorC
 fN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112855; x=1771717655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPRm3hpNQSwVafH7wrzyM8IK9XgL7XBbuGruXzOyVG8=;
 b=Z0xRpGT+14Ia+38cRXtOD/zmX21EUl2nUvR06zUl3+tfOO2TcPH6u/bBKAS42nm1to
 +bo51vwT3gwJddWT5ci3kfaA7Soj8ksKwrl9yUaKL49O8H6bMKeHpL34iwJeSv0mMxiY
 XNg8CFunWIujKLBOJ5ELLxCYPACXCsBnnrpaT1EjQeHG4Kzw6vanQ19JhGFbfJt1aCns
 H9DmuJ4sJ0Bv/zLmDADOj2024t6cubAnXWwnFddY9r9lc7rLPqPhJOGHz0UyQoyfmPVN
 e3QZTlXsOj8bTN8V4gtgJOepXU6zTxIV3x9DuDHZjPX5ELeJyORIWqUqhZuawhLNzMh1
 Rn9A==
X-Gm-Message-State: AOJu0YyseDL44TBi3cWhGosz6Dq2X29UXdfA98uvpt15f6uik1zU/PMe
 lC11ZL7HGLqTWZZBKin2Ajqpi12skJO0V8Yc+KIBljOmnghesuhBmzf8b0YK3WCKGtyN4t7pM6F
 w2Bzd
X-Gm-Gg: AZuq6aLHakdijU4+sxRn4WGBHRpvB1mI7WlXK+13gY7jhnVv56nD3zSR/QK2/Mmstw/
 1CmuY1iPV+L4h/i+C1kS1n0yCVnGVKH99yP7RyTny1KZyqN5Rp9XHc2C4F29SOa1c9sQ4eILnIp
 1wCca/Q90eqZoqOPWz4RPX4VCDNJl5e6q95WMm1IqCEn6In34vnrOW5rEgafgsUzA2ytSkSovmj
 ENHCxRS/+q8u6EYXP/Nr/HOwKvyDYrs27JwoYn1yoAkpyRgB+kTxqrdQKMHoA+TM05CsOwRFHd5
 oYx6FG/JYhMMAaq10K4qc0se7zlk8lNKyjZZOOFOzWHQx6JRq9WBAbZYGo2dMETD4TI0jdMAWMe
 G+eAJqtK/pX9nj/7mb/7R/9Gd39Lxda4/fIjuy4lbht1exkcFhMoXTiwud0F+8OkZmMlsve4yFx
 5FEkb6lG12TtDNlc2TJ4o+OYOlYYsR5Brotw3i0+PvFelrfKLH1nBHRpFTAnlyKJdr
X-Received: by 2002:a05:600c:1547:b0:477:afc5:fb02 with SMTP id
 5b1f17b1804b1-483710858c8mr130125895e9.21.1771112855461; 
 Sat, 14 Feb 2026 15:47:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 02/11] net/rtap: add TAP device creation and queue
 management
Date: Sat, 14 Feb 2026 15:44:11 -0800
Message-ID: <20260214234726.188947-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
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

Add TAP device creation using /dev/net/tun with IFF_MULTI_QUEUE,
IFF_NO_PI, IFF_VNET_HDR, and optional IFF_NAPI flags.

The driver maintains a keep-alive fd and opens additional per-queue
fds for I/O. Each queue pair (rx+tx) shares a single TAP fd.

Key operations:
- rtap_create(): Opens TAP, gets stable ifindex, opens netlink
  socket, retrieves MAC via netlink, detaches keep-alive queue
- rtap_queue_open/close(): Per-queue fd management (converts
  ifindex to name for TUNSETIFF ioctl)
- rtap_dev_configure(): Validates paired queues, clears offloads
- rtap_dev_start/stop(): Manages link status and queue states

The driver uses netlink (RTM_GETLINK/RTM_NEWLINK) and ifindex
for interface control rather than ioctl() and interface names.
This avoids issues with interface renames and namespace moves.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rtap/meson.build    |   1 +
 drivers/net/rtap/rtap.h         |   4 +
 drivers/net/rtap/rtap_ethdev.c  | 241 ++++++++++++++++-
 drivers/net/rtap/rtap_netlink.c | 445 ++++++++++++++++++++++++++++++++
 4 files changed, 689 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/rtap/rtap_netlink.c

diff --git a/drivers/net/rtap/meson.build b/drivers/net/rtap/meson.build
index 7bd7806ef3..1a24ea0555 100644
--- a/drivers/net/rtap/meson.build
+++ b/drivers/net/rtap/meson.build
@@ -19,6 +19,7 @@ endif
 
 sources = files(
         'rtap_ethdev.c',
+        'rtap_netlink.c',
 )
 
 ext_deps += liburing
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 9004953e04..a2d1149cac 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -64,6 +64,10 @@ struct rtap_pmd {
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 };
 
+/* rtap_ethdev.c */
+int rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id);
+void rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id);
+
 /* rtap_netlink.c */
 int rtap_nl_open(unsigned int groups);
 struct rte_eth_dev;
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 95e0b47988..0eab0a48fa 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -9,7 +9,6 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
-#include <sys/socket.h>
 #include <net/if.h>
 #include <linux/if_tun.h>
 #include <linux/virtio_net.h>
@@ -39,13 +38,145 @@ static const char * const valid_arguments[] = {
 	NULL
 };
 
+/* Creates a new tap device, name returned in ifr */
+static int
+rtap_tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
+{
+	static const char tun_dev[] = "/dev/net/tun";
+	int tap_fd;
+
+	tap_fd = open(tun_dev, O_RDWR | O_CLOEXEC | O_NONBLOCK);
+	if (tap_fd < 0) {
+		PMD_LOG_ERRNO(ERR, "Open %s failed", tun_dev);
+		return -1;
+	}
+
+	int features = 0;
+	if (ioctl(tap_fd, TUNGETFEATURES, &features) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNGETFEATURES): %s", tun_dev);
+		goto error;
+	}
+
+	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI | IFF_VNET_HDR;
+	if ((features & flags) != flags) {
+		PMD_LOG(ERR, "TUN features %#x missing support for %#x",
+			features, flags & ~features);
+		goto error;
+	}
+
+#ifdef IFF_NAPI
+	/* If kernel supports using NAPI enable it */
+	if (features & IFF_NAPI)
+		flags |= IFF_NAPI;
+#endif
+	/*
+	 * Sets the device name and packet format.
+	 * Do not want the protocol information (PI)
+	 */
+	strlcpy(ifr->ifr_name, name, IFNAMSIZ);
+	ifr->ifr_flags = flags;
+	if (ioctl(tap_fd, TUNSETIFF, ifr) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNSETIFF) %s", ifr->ifr_name);
+		goto error;
+	}
+
+	/* (Optional) keep the device after application exit */
+	if (persist && ioctl(tap_fd, TUNSETPERSIST, 1) < 0) {
+		PMD_LOG_ERRNO(ERR, "ioctl(TUNSETPERSIST) %s", ifr->ifr_name);
+		goto error;
+	}
+
+	int hdr_size = sizeof(struct virtio_net_hdr);
+	if (ioctl(tap_fd, TUNSETVNETHDRSZ, &hdr_size) < 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETVNETHDRSZ) %s", strerror(errno));
+		goto error;
+	}
+
+	return tap_fd;
+error:
+	close(tap_fd);
+	return -1;
+}
+
+static int
+rtap_dev_start(struct rte_eth_dev *dev)
+{
+	dev->data->dev_link.link_status = RTE_ETH_LINK_UP;
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
+	}
+
+	return 0;
+}
+
+static int
+rtap_dev_stop(struct rte_eth_dev *dev)
+{
+	int *fds = dev->process_private;
+
+	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+
+	for (uint16_t i = 0; i < dev->data->nb_rx_queues; i++) {
+		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STOPPED;
+	}
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		for (uint16_t i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++) {
+			if (fds[i] == -1)
+				continue;
+
+			close(fds[i]);
+			fds[i] = -1;
+		}
+	}
+
+	return 0;
+}
+
+static int
+rtap_dev_configure(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	/* rx/tx must be paired */
+	if (dev->data->nb_rx_queues != dev->data->nb_tx_queues) {
+		PMD_LOG(ERR, "number of rx %u and tx %u queues must match",
+			dev->data->nb_rx_queues, dev->data->nb_tx_queues);
+		return -EINVAL;
+	}
+
+	if (ioctl(pmd->keep_fd, TUNSETOFFLOAD, 0) != 0) {
+		int ret = -errno;
+
+		PMD_LOG(ERR, "ioctl(TUNSETOFFLOAD) failed: %s", strerror(errno));
+		return ret;
+	}
+
+	return 0;
+}
+
 static int
 rtap_dev_close(struct rte_eth_dev *dev)
 {
 	struct rtap_pmd *pmd = dev->data->dev_private;
+	int *fds = dev->process_private;
 
 	PMD_LOG(INFO, "Closing ifindex %d", pmd->if_index);
 
+	/* Release all io_uring queues (calls rx/tx_queue_release for each) */
+	rte_eth_dev_internal_reset(dev);
+
+	/* Close any remaining queue fds (each process owns its own set) */
+	for (uint16_t i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++) {
+		if (fds[i] == -1)
+			continue;
+		PMD_LOG(DEBUG, "Closed queue %u fd %d", i, fds[i]);
+		close(fds[i]);
+		fds[i] = -1;
+	}
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		/* mac_addrs must not be freed alone because part of dev_private */
 		dev->data->mac_addrs = NULL;
@@ -68,10 +199,115 @@ rtap_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* Setup another fd to TAP device for the queue */
+int
+rtap_queue_open(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	int *fds = dev->process_private;
+	char ifname[IFNAMSIZ];
+
+	if (fds[queue_id] != -1) {
+		PMD_LOG(DEBUG, "queue %u already has fd %d", queue_id, fds[queue_id]);
+		return 0;	/* already setup */
+	}
+
+	/* Convert ifindex to name for TUNSETIFF */
+	if (if_indextoname(pmd->if_index, ifname) == NULL) {
+		PMD_LOG(ERR, "Could not find interface for ifindex %d", pmd->if_index);
+		return -1;
+	}
+
+	struct ifreq ifr = { 0 };
+	int tap_fd = rtap_tap_open(ifname, &ifr, 0);
+	if (tap_fd < 0) {
+		PMD_LOG(ERR, "tap_open failed");
+		return -1;
+	}
+
+	PMD_LOG(DEBUG, "Opened %d for queue %u", tap_fd, queue_id);
+	fds[queue_id] = tap_fd;
+	return 0;
+}
+
+void
+rtap_queue_close(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	int *fds = dev->process_private;
+	int tap_fd = fds[queue_id];
+
+	if (tap_fd == -1)
+		return; /* already closed */
+	PMD_LOG(DEBUG, "Closed queue %u fd %d", queue_id, tap_fd);
+	close(tap_fd);
+	fds[queue_id] = -1;
+}
+
 static const struct eth_dev_ops rtap_ops = {
+	.dev_start		= rtap_dev_start,
+	.dev_stop		= rtap_dev_stop,
+	.dev_configure		= rtap_dev_configure,
 	.dev_close		= rtap_dev_close,
 };
 
+static int
+rtap_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct rtap_pmd *pmd = data->dev_private;
+
+	pmd->keep_fd = -1;
+	pmd->nlsk_fd = -1;
+
+	dev->dev_ops = &rtap_ops;
+
+	/* Get the initial fd used to keep the tap device around */
+	struct ifreq ifr = { 0 };
+	pmd->keep_fd = rtap_tap_open(tap_name, &ifr, persist);
+	if (pmd->keep_fd < 0)
+		goto error;
+
+	PMD_LOG(DEBUG, "Created %s keep_fd %d", ifr.ifr_name, pmd->keep_fd);
+
+	/* Use if_index which is stable even if interface is renamed */
+	pmd->if_index = if_nametoindex(ifr.ifr_name);
+	if (pmd->if_index == 0) {
+		PMD_LOG(ERR, "Could not find ifindex for '%s'", ifr.ifr_name);
+		goto error;
+	}
+
+	/* Open persistent netlink socket for control operations */
+	pmd->nlsk_fd = rtap_nl_open(0);
+	if (pmd->nlsk_fd < 0)
+		goto error;
+
+	/* Read the MAC address assigned by the kernel via netlink */
+	if (rtap_nl_get_mac(pmd->nlsk_fd, pmd->if_index, &pmd->eth_addr) < 0) {
+		PMD_LOG(ERR, "Unable to get MAC address for ifindex %d", pmd->if_index);
+		goto error;
+	}
+	data->mac_addrs = &pmd->eth_addr;
+
+	/* Detach this instance, not used for traffic */
+	ifr.ifr_flags = IFF_DETACH_QUEUE;
+	if (ioctl(pmd->keep_fd, TUNSETQUEUE, &ifr) < 0) {
+		PMD_LOG_ERRNO(ERR, "Unable to detach keep-alive queue for ifindex %d",
+			      pmd->if_index);
+		goto error;
+	}
+
+	PMD_LOG(DEBUG, "ifindex %d setup", pmd->if_index);
+
+	return 0;
+
+error:
+	if (pmd->nlsk_fd != -1)
+		close(pmd->nlsk_fd);
+	if (pmd->keep_fd != -1)
+		close(pmd->keep_fd);
+	return -1;
+}
+
 static int
 rtap_parse_iface(const char *key __rte_unused, const char *value, void *extra_args)
 {
@@ -134,7 +370,8 @@ rtap_probe(struct rte_vdev_device *vdev)
 	eth_dev->process_private = fds;
 	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
 
-	RTE_SET_USED(persist); /* used in later patches */
+	if (rtap_create(eth_dev, tap_name, persist) < 0)
+		goto error;
 
 	rte_eth_dev_probing_finish(eth_dev);
 	rte_kvargs_free(kvlist);
diff --git a/drivers/net/rtap/rtap_netlink.c b/drivers/net/rtap/rtap_netlink.c
new file mode 100644
index 0000000000..060b89c625
--- /dev/null
+++ b/drivers/net/rtap/rtap_netlink.c
@@ -0,0 +1,445 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+/*
+ * Netlink-based control operations for the rtap PMD.
+ *
+ * Uses RTM_GETLINK / RTM_NEWLINK to replace ioctl() for interface
+ * flag changes, MTU, MAC address, and statistics retrieval.
+ *
+ * Socket model:
+ *   - Control socket (pmd->nlsk_fd): persistent per-device, opened
+ *     at create time.  Used for flag changes, MTU, MAC operations.
+ *   - LSC socket: persistent while enabled, subscribed to RTMGRP_LINK.
+ *     Managed by rtap_intr.c via rtap_nl_open().
+ *   - Stats queries (rtap_nl_get_stats): use an ephemeral socket
+ *     opened on demand so they cannot block behind control operations.
+ */
+
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if_link.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <ethdev_driver.h>
+#include <rte_stdatomic.h>
+
+#include "rtap.h"
+
+/* Sequence number for netlink requests */
+static RTE_ATOMIC(uint32_t) rtap_nl_seq;
+
+/*
+ * Open a netlink route socket.
+ *
+ * If groups is non-zero, the socket subscribes to those multicast
+ * groups and is set non-blocking (for LSC notification).
+ * If groups is zero, the socket is blocking (for control/query).
+ *
+ * Returns socket fd or -1 on failure.
+ */
+int
+rtap_nl_open(unsigned int groups)
+{
+	int flags = SOCK_RAW | SOCK_CLOEXEC;
+	int fd;
+	struct sockaddr_nl sa = {
+		.nl_family = AF_NETLINK,
+		.nl_groups = groups,
+	};
+
+	if (groups != 0)
+		flags |= SOCK_NONBLOCK;
+
+	fd = socket(AF_NETLINK, flags, NETLINK_ROUTE);
+	if (fd < 0) {
+		PMD_LOG_ERRNO(ERR, "netlink socket");
+		return -1;
+	}
+
+	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		PMD_LOG_ERRNO(ERR, "netlink bind");
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
+/*
+ * Send a netlink request and wait for acknowledgment.
+ * Returns 0 on success, negative errno on failure.
+ */
+static int
+rtap_nl_request(int fd, struct nlmsghdr *nlh)
+{
+	char buf[4096];
+	ssize_t len;
+
+	nlh->nlmsg_seq = rte_atomic_fetch_add_explicit(&rtap_nl_seq, 1,
+						       rte_memory_order_relaxed);
+	nlh->nlmsg_flags |= NLM_F_ACK;
+
+	if (send(fd, nlh, nlh->nlmsg_len, 0) < 0)
+		return -errno;
+
+	len = recv(fd, buf, sizeof(buf), 0);
+	if (len < 0)
+		return -errno;
+
+	struct nlmsghdr *nh = (struct nlmsghdr *)buf;
+	if (!NLMSG_OK(nh, (unsigned int)len))
+		return -EBADMSG;
+
+	if (nh->nlmsg_type == NLMSG_ERROR) {
+		struct nlmsgerr *err = NLMSG_DATA(nh);
+
+		return err->error;  /* 0 = success, negative = errno */
+	}
+
+	return -EBADMSG;
+}
+
+/*
+ * Send a netlink request and receive a data response.
+ * Returns length of response on success, negative errno on failure.
+ */
+static int
+rtap_nl_query(int fd, struct nlmsghdr *nlh, char *buf, size_t buflen)
+{
+	ssize_t len;
+
+	nlh->nlmsg_seq = rte_atomic_fetch_add_explicit(&rtap_nl_seq, 1,
+						       rte_memory_order_relaxed);
+
+	if (send(fd, nlh, nlh->nlmsg_len, 0) < 0)
+		return -errno;
+
+	len = recv(fd, buf, buflen, 0);
+	if (len < 0)
+		return -errno;
+
+	struct nlmsghdr *nh = (struct nlmsghdr *)buf;
+	if (!NLMSG_OK(nh, (unsigned int)len))
+		return -EBADMSG;
+
+	if (nh->nlmsg_type == NLMSG_ERROR) {
+		struct nlmsgerr *err = NLMSG_DATA(nh);
+
+		return err->error;
+	}
+
+	/* Detect truncated response */
+	if (nh->nlmsg_len > (unsigned int)len)
+		return -EBADMSG;
+
+	return len;
+}
+
+/* Append a netlink attribute to a message. */
+static void
+rtap_nl_addattr(struct nlmsghdr *nlh, unsigned int maxlen,
+		int type, const void *data, unsigned int datalen)
+{
+	unsigned int len = RTA_LENGTH(datalen);
+	struct rtattr *rta;
+
+	RTE_VERIFY(NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len) <= maxlen);
+
+	rta = (struct rtattr *)((char *)nlh + NLMSG_ALIGN(nlh->nlmsg_len));
+	rta->rta_type = type;
+	rta->rta_len = len;
+	if (datalen > 0)
+		memcpy(RTA_DATA(rta), data, datalen);
+	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + RTA_ALIGN(len);
+}
+
+/*
+ * Get interface flags via RTM_GETLINK.
+ * Returns 0 on success and sets *flags.
+ */
+int
+rtap_nl_get_flags(int nlsk_fd, int if_index, unsigned int *flags)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+		},
+	};
+	char resp[4096];
+	int ret;
+
+	ret = rtap_nl_query(nlsk_fd, &req.nlh, resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	struct nlmsghdr *nh = (struct nlmsghdr *)resp;
+	if (nh->nlmsg_type != RTM_NEWLINK)
+		return -EBADMSG;
+
+	struct ifinfomsg *ifi = NLMSG_DATA(nh);
+	*flags = ifi->ifi_flags;
+	return 0;
+}
+
+/*
+ * Change interface flags via RTM_NEWLINK.
+ * 'flags' are set, 'mask' are cleared.
+ */
+int
+rtap_nl_change_flags(int nlsk_fd, int if_index,
+		     unsigned int flags, unsigned int mask)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_NEWLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+			.ifi_flags = flags,
+			.ifi_change = mask,
+		},
+	};
+
+	return rtap_nl_request(nlsk_fd, &req.nlh);
+}
+
+/*
+ * Set MTU via RTM_NEWLINK.
+ */
+int
+rtap_nl_set_mtu(int nlsk_fd, int if_index, uint16_t mtu)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+		char attrs[64];
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_NEWLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+		},
+	};
+	unsigned int mtu32 = mtu;
+
+	rtap_nl_addattr(&req.nlh, sizeof(req), IFLA_MTU, &mtu32, sizeof(mtu32));
+	return rtap_nl_request(nlsk_fd, &req.nlh);
+}
+
+/*
+ * Set MAC address via RTM_NEWLINK.
+ */
+int
+rtap_nl_set_mac(int nlsk_fd, int if_index, const struct rte_ether_addr *addr)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+		char attrs[64];
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_NEWLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+		},
+	};
+
+	rtap_nl_addattr(&req.nlh, sizeof(req), IFLA_ADDRESS,
+			addr->addr_bytes, RTE_ETHER_ADDR_LEN);
+	return rtap_nl_request(nlsk_fd, &req.nlh);
+}
+
+/*
+ * Get MAC address via RTM_GETLINK.
+ */
+int
+rtap_nl_get_mac(int nlsk_fd, int if_index, struct rte_ether_addr *addr)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+		},
+	};
+	char resp[4096];
+	int ret;
+
+	ret = rtap_nl_query(nlsk_fd, &req.nlh, resp, sizeof(resp));
+	if (ret < 0)
+		return ret;
+
+	struct nlmsghdr *nh = (struct nlmsghdr *)resp;
+	if (nh->nlmsg_type != RTM_NEWLINK)
+		return -EBADMSG;
+
+	struct ifinfomsg *ifi = NLMSG_DATA(nh);
+	struct rtattr *rta = (struct rtattr *)((char *)ifi + NLMSG_ALIGN(sizeof(*ifi)));
+	int rtalen = nh->nlmsg_len - NLMSG_LENGTH(sizeof(*ifi));
+
+	while (RTA_OK(rta, rtalen)) {
+		if (rta->rta_type == IFLA_ADDRESS) {
+			if (RTA_PAYLOAD(rta) == RTE_ETHER_ADDR_LEN) {
+				memcpy(addr->addr_bytes, RTA_DATA(rta), RTE_ETHER_ADDR_LEN);
+				return 0;
+			}
+		}
+		rta = RTA_NEXT(rta, rtalen);
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Get link statistics via RTM_GETLINK with IFLA_STATS64 attribute.
+ * Opens an ephemeral socket to avoid blocking behind control operations.
+ */
+int
+rtap_nl_get_stats(int if_index, struct rtnl_link_stats64 *stats)
+{
+	struct {
+		struct nlmsghdr nlh;
+		struct ifinfomsg ifi;
+	} req = {
+		.nlh = {
+			.nlmsg_len = NLMSG_LENGTH(sizeof(struct ifinfomsg)),
+			.nlmsg_type = RTM_GETLINK,
+			.nlmsg_flags = NLM_F_REQUEST,
+		},
+		.ifi = {
+			.ifi_family = AF_UNSPEC,
+			.ifi_index = if_index,
+		},
+	};
+	char resp[4096];
+	int fd, ret;
+
+	memset(stats, 0, sizeof(*stats));
+
+	/* Use ephemeral socket so stats queries don't block */
+	fd = rtap_nl_open(0);
+	if (fd < 0)
+		return fd;
+
+	ret = rtap_nl_query(fd, &req.nlh, resp, sizeof(resp));
+	close(fd);
+
+	if (ret < 0)
+		return ret;
+
+	struct nlmsghdr *nh = (struct nlmsghdr *)resp;
+	if (nh->nlmsg_type != RTM_NEWLINK)
+		return -EBADMSG;
+
+	struct ifinfomsg *ifi = NLMSG_DATA(nh);
+	struct rtattr *rta = (struct rtattr *)((char *)ifi + NLMSG_ALIGN(sizeof(*ifi)));
+	int rtalen = nh->nlmsg_len - NLMSG_LENGTH(sizeof(*ifi));
+
+	/* Parse attributes looking for IFLA_STATS64 */
+	while (RTA_OK(rta, rtalen)) {
+		if (rta->rta_type == IFLA_STATS64) {
+			if (RTA_PAYLOAD(rta) >= sizeof(*stats)) {
+				memcpy(stats, RTA_DATA(rta), sizeof(*stats));
+				return 0;
+			}
+		}
+		rta = RTA_NEXT(rta, rtalen);
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Process incoming netlink messages for link state changes.
+ * Called by rtap_intr.c when the LSC socket has data.
+ */
+void
+rtap_nl_recv(int fd, struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	char buf[4096];
+	ssize_t len;
+
+	while ((len = recv(fd, buf, sizeof(buf), MSG_DONTWAIT)) > 0) {
+		struct nlmsghdr *nh;
+
+		for (nh = (struct nlmsghdr *)buf;
+		     NLMSG_OK(nh, (unsigned int)len);
+		     nh = NLMSG_NEXT(nh, len)) {
+			if (nh->nlmsg_type == NLMSG_DONE)
+				break;
+			if (nh->nlmsg_type == NLMSG_ERROR)
+				continue;
+			if (nh->nlmsg_type != RTM_NEWLINK &&
+			    nh->nlmsg_type != RTM_DELLINK)
+				continue;
+
+			struct ifinfomsg *ifi = NLMSG_DATA(nh);
+
+			/* Only process messages for our interface */
+			if (ifi->ifi_index != pmd->if_index)
+				continue;
+
+			if (nh->nlmsg_type == RTM_DELLINK) {
+				PMD_LOG(INFO, "ifindex %d deleted", pmd->if_index);
+				dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
+				rte_eth_dev_callback_process(dev,
+					RTE_ETH_EVENT_INTR_LSC, NULL);
+			} else {
+				bool was_up = dev->data->dev_link.link_status == RTE_ETH_LINK_UP;
+				bool is_up = (ifi->ifi_flags & IFF_UP) &&
+					     (ifi->ifi_flags & IFF_RUNNING);
+
+				if (was_up != is_up) {
+					PMD_LOG(DEBUG, "ifindex %d link %s",
+						pmd->if_index, is_up ? "up" : "down");
+					dev->data->dev_link.link_status =
+						is_up ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+					rte_eth_dev_callback_process(dev,
+						RTE_ETH_EVENT_INTR_LSC, NULL);
+				}
+			}
+		}
+	}
+}
-- 
2.51.0

