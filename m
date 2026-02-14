Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC56EF584D
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:47:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6A83402EA;
	Sun, 15 Feb 2026 00:47:35 +0100 (CET)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66]) by mails.dpdk.org (Postfix) with ESMTP id 4889B402E7
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:34 +0100 (CET)
Received: by mail-wm1-f66.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso15608745e9.2
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112854;
 x=1771717654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOdRVJ51XoAPI23WoWcXlhElandy4W/U59MCXkIEUEw=;
 b=GlUhn1Muj6w2Mz+Wen1Gknvr6pkcmCddZJzKiJ/eAozeFUbrCjrvQYF7Db29LbKE0z
 XgZNA5cGS/zfUCceuEoLyYQVyGa2fsauKzNdnA4J0CY+ApdJXSpIJFYhPu2Nxh9Y/ROk
 O9OUCHKQBUOWrSBEGrP8b8E38MPbpy9A8cGqk+0nJBRO/z2OS1exbyaTTfmG6n/wPRd8
 9wqfvlsS0KnG7wh5gaAokoKESEVBI+QGyhDw5koeRyw0F7SS69vxykmwwGtgVM6PCERV
 lX4l8PvjsuC6d/ctVxS8TDwgp8KOSHgtPaqcfZnJcNKWqsSl8pt4UyAxuS6xPC2MOHcB
 L/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112854; x=1771717654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nOdRVJ51XoAPI23WoWcXlhElandy4W/U59MCXkIEUEw=;
 b=Fc0gE3/A/yDIMv6H4Qa3okw017E5LCw8zaTmyU10uRPdtgP3BDyY+YApTzSJ8ptgIc
 k4bKAxNAtDosp+Gyt9sQuNc6QURcrQXTDtaFzJoU0p7F6U/+cKHzMBywC10VZS7rxY9X
 zbxPqvfV6SQMkgTU3PauRLj77M6SY1kPkEF2vnQBjuxOPLTNOPhjEsEWyC8/y5fGEjAI
 mMA8OwdD7cFlJ0CvWtOldVbExEAW7RqmTqNvPKg/+u1vOjs6ABvcio1LjJYQR7WI5VWD
 WK313UgRG8eGwDbPz7q8q5Dr2NCGcxqokUY8XI39fVugvOeprMwW9QxujH580VHWN3R4
 0k1w==
X-Gm-Message-State: AOJu0YzTga0qrLvlCpfoHtgKSB31J92A1DM4GgHWRwq/5ITgfTBPZyg6
 xziRl9eQc+FNgapSY9EdB3YTgB+ENQZKTbPgREcetRrzWWrQVgn456davPcbHPCdmXdUveUqJk2
 wPqpEu6g=
X-Gm-Gg: AZuq6aIFJfxL7qLiTdY8m1A2riDJKSKlgeUEvcKCFMM3lYSmbx+4qyApgYn2ILq8Nt+
 Xs3UJmGHsPsI9+hfpd6RSWPm90qdqkUc6xxv6TUjBKF9W5GJemNobCIPCavae3gGV5CZRJ9ZWUY
 FVZU3gUwOuKR0qNN1rNo5Y4ujeQ67r/e9K6lnWW1BgZ6uIWE4xOt38GGqXnnmL9gp/DkPy7rdC3
 lycFYwhVPXOaeTxBqQfHEWjqr/SnO2J+Bwari39bSf7qmKD3hJdjjfemtDH2eMTbyRT/agB3qgq
 sDeq3XH9PKfb5Jjvscf43vQeOO1OxbegeQd860QAN50pZpdMjTXMkHMkon9sharbNmjjIqnrVT2
 aV1QB4zTlkr8RxhiZghNyzHR6Jtkb7zFzJc7hI64WgobD5Xi178RW6ygLaSyyNUL1hbaR0XA6Ea
 lC44B72IWQeojOv5WAt/Zc8hxfSHa1os/V9vq4m/tBmVpgEqBcs048lyavVSsa8ab1
X-Received: by 2002:a05:600c:548c:b0:483:2c98:435e with SMTP id
 5b1f17b1804b1-48373a782c2mr100003975e9.34.1771112853637; 
 Sat, 14 Feb 2026 15:47:33 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 01/11] net/rtap: add driver skeleton and documentation
Date: Sat, 14 Feb 2026 15:44:10 -0800
Message-ID: <20260214234726.188947-2-stephen@networkplumber.org>
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

Add the initial skeleton for the rtap poll mode driver, a virtual
ethernet device that uses Linux io_uring for packet I/O with kernel
TAP devices.

This patch includes:
  - MAINTAINERS entry
  - Driver documentation (doc/guides/nics/rtap.rst)
  - Feature matrix (doc/guides/nics/features/rtap.ini)
  - Release notes update
  - Meson build integration with liburing dependency
  - Header file with shared data structures and declarations
  - Stub probe/remove handlers that register the vdev driver
  - Empty dev_ops with only dev_close implemented

The driver registers as net_rtap and is Linux-only.

Requires the liburing library version 2.0 or later.
Earlier versions have known security and build issues.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |   7 +
 doc/guides/nics/features/rtap.ini      |  13 ++
 doc/guides/nics/index.rst              |   1 +
 doc/guides/nics/rtap.rst               | 101 ++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   7 +
 drivers/net/meson.build                |   1 +
 drivers/net/rtap/meson.build           |  26 ++++
 drivers/net/rtap/rtap.h                |  81 +++++++++++
 drivers/net/rtap/rtap_ethdev.c         | 177 +++++++++++++++++++++++++
 9 files changed, 414 insertions(+)
 create mode 100644 doc/guides/nics/features/rtap.ini
 create mode 100644 doc/guides/nics/rtap.rst
 create mode 100644 drivers/net/rtap/meson.build
 create mode 100644 drivers/net/rtap/rtap.h
 create mode 100644 drivers/net/rtap/rtap_ethdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 25fb109ef4..45721c9d03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1135,6 +1135,13 @@ F: doc/guides/nics/ring.rst
 F: app/test/test_pmd_ring.c
 F: app/test/test_pmd_ring_perf.c
 
+Rtap PMD - EXPERIMENTAL
+M: Stephen Hemminger <stephen@networkplumber.org>
+F: drivers/net/rtap/
+F: app/test/test_pmd_rtap.c
+F: doc/guides/nics/rtap.rst
+F: doc/guides/nics/features/rtap.ini
+
 Null Networking PMD
 M: Tetsuya Mukawa <mtetsuyah@gmail.com>
 F: drivers/net/null/
diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
new file mode 100644
index 0000000000..ed7c638029
--- /dev/null
+++ b/doc/guides/nics/features/rtap.ini
@@ -0,0 +1,13 @@
+;
+; Supported features of the 'rtap' driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+ARMv7                = Y
+ARMv8                = Y
+Power8               = Y
+x86-32               = Y
+x86-64               = Y
+Usage doc            = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index cb818284fe..24746596b7 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -66,6 +66,7 @@ Network Interface Controller Drivers
     r8169
     ring
     rnp
+    rtap
     sfc_efx
     softnic
     tap
diff --git a/doc/guides/nics/rtap.rst b/doc/guides/nics/rtap.rst
new file mode 100644
index 0000000000..4bb964128b
--- /dev/null
+++ b/doc/guides/nics/rtap.rst
@@ -0,0 +1,101 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+
+RTAP Poll Mode Driver
+=======================
+
+The RTAP Poll Mode Driver (PMD) is similar to the TAP PMD. It is a
+virtual device that uses Linux io_uring for efficient packet I/O with
+the Linux kernel.
+It is useful when writing DPDK applications that need to support interaction
+with the Linux TCP/IP stack for control plane or tunneling.
+
+The RTAP PMD creates a kernel network device that can be
+managed by standard tools such as ``ip`` and ``ethtool`` commands.
+
+From a DPDK application, the RTAP device looks like a DPDK ethdev.
+It supports the standard DPDK APIs to query for information, statistics,
+and send/receive packets.
+
+Features
+--------
+
+- Uses io_uring for asynchronous packet I/O via read/write and readv/writev
+- TX offloads: multi-segment, UDP checksum, TCP checksum, TCP segmentation (TSO)
+- RX offloads: UDP checksum, TCP checksum, TCP LRO, scatter
+- Virtio net header support for offload negotiation with the kernel
+- Multi-queue support (up to 128 queues)
+- Multi-process support (secondary processes receive queue fds from primary)
+- Link state change notification via netlink
+- Rx interrupt support for power-aware applications (eventfd per queue)
+- Promiscuous and allmulticast mode
+- MAC address configuration
+- MTU update
+- Link up/down control
+- Basic and per-queue statistics
+
+Requirements
+------------
+
+- **liburing >= 2.0**.  Earlier versions have known security and build issues.
+
+- The kernel must support ``IORING_ASYNC_CANCEL_ALL`` (upstream since 5.19).
+  The meson build checks for this symbol and will not build the driver
+  if the installed kernel headers do not provide it.  Because enterprise
+  distributions backport features independently of version numbers,
+  the driver avoids hard-coding a kernel version check.
+
+Known working distributions:
+
+- Debian 12 (Bookworm) or later
+- Ubuntu 24.04 (Noble) or later
+- Fedora 37 or later
+- SUSE Linux Enterprise 15 SP6 or later / openSUSE Tumbleweed
+
+RHEL 9 ships io_uring only as a Technology Preview (disabled by default)
+and is not supported.
+
+For more info on io_uring, please see:
+
+- `io_uring on Wikipedia <https://en.wikipedia.org/wiki/Io_uring>`_
+- `liburing on GitHub <https://github.com/axboe/liburing>`_
+
+
+Arguments
+---------
+
+RTAP devices are created with the ``--vdev=net_rtap0`` command line option.
+Multiple devices can be created by repeating the option with different device names
+(``net_rtap1``, ``net_rtap2``, etc.).
+
+By default, the Linux interfaces are named ``rtap0``, ``rtap1``, etc.
+The interface name can be specified by adding the ``iface=foo0``, for example::
+
+   --vdev=net_rtap0,iface=io0 --vdev=net_rtap1,iface=io1 ...
+
+The PMD inherits the MAC address assigned by the kernel which will be
+a locally assigned random Ethernet address.
+
+Normally, when the DPDK application exits, the RTAP device is removed.
+But this behavior can be overridden by the use of the persist flag, which
+causes the kernel network interface to survive application exit. Example::
+
+  --vdev=net_rtap0,iface=io0,persist ...
+
+
+Limitations
+-----------
+
+- The kernel must have io_uring support with ``IORING_ASYNC_CANCEL_ALL``
+  (upstream since 5.19, but may be backported by distributions).
+  io_uring support may also be disabled in some environments or by security policies
+  (for example, Docker disables io_uring in its default seccomp profile,
+  and RHEL 9 disables it via ``kernel.io_uring_disabled`` sysctl).
+
+- Since RTAP device uses a file descriptor to talk to the kernel,
+  the same number of queues must be specified for receive and transmit.
+
+- The maximum number of queues is 128.
+
+- No flow support. Receive queue selection for incoming packets is determined
+  by the Linux kernel. See kernel documentation for more info:
+  https://www.kernel.org/doc/html/latest/networking/scaling.html
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index afdf1af06c..40320b0101 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -87,6 +87,13 @@ New Features
   * Added support for AES-XTS cipher algorithm.
   * Added support for SHAKE-128 and SHAKE-256 authentication algorithms.
 
+* **Added rtap virtual ethernet driver.**
+
+  Added a new experimental virtual device driver that uses Linux io_uring
+  for packet injection into the kernel network stack.
+  It requires Linux kernel 5.19 or later for IORING_ASYNC_CANCEL
+  and liburing 2.0 or later.
+
 
 Removed Items
 -------------
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index c7dae4ad27..ef1ee68385 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -56,6 +56,7 @@ drivers = [
         'r8169',
         'ring',
         'rnp',
+        'rtap',
         'sfc',
         'softnic',
         'tap',
diff --git a/drivers/net/rtap/meson.build b/drivers/net/rtap/meson.build
new file mode 100644
index 0000000000..7bd7806ef3
--- /dev/null
+++ b/drivers/net/rtap/meson.build
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2026 Stephen Hemminger
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+endif
+
+liburing = dependency('liburing', version: '>= 2.0', required: false)
+if not liburing.found()
+    build = false
+    reason = 'missing dependency, "liburing"'
+endif
+
+if build and not cc.has_header_symbol('linux/io_uring.h', 'IORING_ASYNC_CANCEL_ALL')
+    build = false
+    reason = 'kernel headers missing IORING_ASYNC_CANCEL_ALL (need kernel >= 5.19 headers)'
+endif
+
+sources = files(
+        'rtap_ethdev.c',
+)
+
+ext_deps += liburing
+
+require_iova_in_mbuf = false
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
new file mode 100644
index 0000000000..9004953e04
--- /dev/null
+++ b/drivers/net/rtap/rtap.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#ifndef _RTAP_H_
+#define _RTAP_H_
+
+#include <errno.h>
+#include <stdint.h>
+#include <liburing.h>
+
+#include <rte_common.h>
+#include <rte_log.h>
+#include <rte_ether.h>
+
+extern int rtap_logtype;
+#define RTE_LOGTYPE_RTAP rtap_logtype
+#define PMD_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RTAP, "%s(): ", __func__, __VA_ARGS__)
+
+#define PMD_LOG_ERRNO(level, fmt, ...) \
+	RTE_LOG_LINE(level, RTAP, "%s(): " fmt ": %s", __func__, ## __VA_ARGS__, strerror(errno))
+
+#ifdef RTE_ETHDEV_DEBUG_RX
+#define PMD_RX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RTAP, "%s() rx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_RX_LOG(...) do { } while (0)
+#endif
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+#define PMD_TX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, RTAP, "%s() tx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_TX_LOG(...) do { } while (0)
+#endif
+
+struct rtap_rx_queue {
+	struct rte_mempool *mb_pool;	/* rx buffer pool */
+	struct io_uring io_ring;	/* queue of posted read's */
+	uint16_t port_id;
+	uint16_t queue_id;
+
+	uint64_t rx_packets;
+	uint64_t rx_bytes;
+	uint64_t rx_errors;
+} __rte_cache_aligned;
+
+struct rtap_tx_queue {
+	struct io_uring io_ring;
+	uint16_t port_id;
+	uint16_t queue_id;
+	uint16_t free_thresh;
+
+	uint64_t tx_packets;
+	uint64_t tx_bytes;
+	uint64_t tx_errors;
+} __rte_cache_aligned;
+
+struct rtap_pmd {
+	int keep_fd;			/* keep alive file descriptor */
+	int if_index;			/* interface index */
+	int nlsk_fd;			/* netlink control socket */
+	struct rte_ether_addr eth_addr; /* address assigned by kernel */
+};
+
+/* rtap_netlink.c */
+int rtap_nl_open(unsigned int groups);
+struct rte_eth_dev;
+void rtap_nl_recv(int fd, struct rte_eth_dev *dev);
+int rtap_nl_get_flags(int nlsk_fd, int if_index, unsigned int *flags);
+int rtap_nl_change_flags(int nlsk_fd, int if_index,
+			 unsigned int flags, unsigned int mask);
+int rtap_nl_set_mtu(int nlsk_fd, int if_index, uint16_t mtu);
+int rtap_nl_set_mac(int nlsk_fd, int if_index,
+		    const struct rte_ether_addr *addr);
+int rtap_nl_get_mac(int nlsk_fd, int if_index, struct rte_ether_addr *addr);
+struct rtnl_link_stats64;
+int rtap_nl_get_stats(int if_index, struct rtnl_link_stats64 *stats);
+
+#endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
new file mode 100644
index 0000000000..95e0b47988
--- /dev/null
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if_tun.h>
+#include <linux/virtio_net.h>
+
+#include <rte_config.h>
+#include <rte_common.h>
+#include <rte_dev.h>
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_kvargs.h>
+#include <rte_log.h>
+#include <bus_vdev_driver.h>
+#include <ethdev_driver.h>
+#include <ethdev_vdev.h>
+
+#include "rtap.h"
+
+#define RTAP_DEFAULT_IFNAME	"rtap%d"
+
+#define RTAP_IFACE_ARG		"iface"
+#define RTAP_PERSIST_ARG	"persist"
+
+static const char * const valid_arguments[] = {
+	RTAP_IFACE_ARG,
+	RTAP_PERSIST_ARG,
+	NULL
+};
+
+static int
+rtap_dev_close(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	PMD_LOG(INFO, "Closing ifindex %d", pmd->if_index);
+
+	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+		/* mac_addrs must not be freed alone because part of dev_private */
+		dev->data->mac_addrs = NULL;
+
+		if (pmd->keep_fd != -1) {
+			PMD_LOG(DEBUG, "Closing keep_fd %d", pmd->keep_fd);
+			close(pmd->keep_fd);
+			pmd->keep_fd = -1;
+		}
+
+		if (pmd->nlsk_fd != -1) {
+			close(pmd->nlsk_fd);
+			pmd->nlsk_fd = -1;
+		}
+	}
+
+	free(dev->process_private);
+	dev->process_private = NULL;
+
+	return 0;
+}
+
+static const struct eth_dev_ops rtap_ops = {
+	.dev_close		= rtap_dev_close,
+};
+
+static int
+rtap_parse_iface(const char *key __rte_unused, const char *value, void *extra_args)
+{
+	char *name = extra_args;
+
+	/* must not be null string */
+	if (value == NULL || value[0] == '\0' || strnlen(value, IFNAMSIZ) == IFNAMSIZ)
+		return -EINVAL;
+
+	strlcpy(name, value, IFNAMSIZ);
+	return 0;
+}
+
+static int
+rtap_probe(struct rte_vdev_device *vdev)
+{
+	const char *name = rte_vdev_device_name(vdev);
+	const char *params = rte_vdev_device_args(vdev);
+	struct rte_kvargs *kvlist = NULL;
+	struct rte_eth_dev *eth_dev = NULL;
+	int *fds = NULL;
+	char tap_name[IFNAMSIZ] = RTAP_DEFAULT_IFNAME;
+	uint8_t persist = 0;
+	int ret;
+
+	PMD_LOG(INFO, "Initializing %s", name);
+
+	if (params != NULL) {
+		kvlist = rte_kvargs_parse(params, valid_arguments);
+		if (kvlist == NULL)
+			return -1;
+
+		if (rte_kvargs_count(kvlist, RTAP_IFACE_ARG) == 1) {
+			ret = rte_kvargs_process_opt(kvlist, RTAP_IFACE_ARG,
+						     &rtap_parse_iface, tap_name);
+			if (ret < 0)
+				goto error;
+		}
+
+		if (rte_kvargs_count(kvlist, RTAP_PERSIST_ARG) == 1)
+			persist = 1;
+	}
+
+	/* Per-queue tap fd's (for primary process) */
+	fds = calloc(RTE_MAX_QUEUES_PER_PORT, sizeof(int));
+	if (fds == NULL) {
+		PMD_LOG(ERR, "Unable to allocate fd array");
+		goto error;
+	}
+	for (unsigned int i = 0; i < RTE_MAX_QUEUES_PER_PORT; i++)
+		fds[i] = -1;
+
+	eth_dev = rte_eth_vdev_allocate(vdev, sizeof(struct rtap_pmd));
+	if (eth_dev == NULL) {
+		PMD_LOG(ERR, "%s Unable to allocate device struct", tap_name);
+		goto error;
+	}
+
+	eth_dev->dev_ops = &rtap_ops;
+	eth_dev->process_private = fds;
+	eth_dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+
+	RTE_SET_USED(persist); /* used in later patches */
+
+	rte_eth_dev_probing_finish(eth_dev);
+	rte_kvargs_free(kvlist);
+	return 0;
+
+error:
+	if (eth_dev != NULL) {
+		eth_dev->process_private = NULL;
+		rte_eth_dev_release_port(eth_dev);
+	}
+	free(fds);
+	rte_kvargs_free(kvlist);
+	return -1;
+}
+
+static int
+rtap_remove(struct rte_vdev_device *dev)
+{
+	struct rte_eth_dev *eth_dev;
+
+	eth_dev = rte_eth_dev_allocated(rte_vdev_device_name(dev));
+	if (eth_dev == NULL)
+		return 0;
+
+	rtap_dev_close(eth_dev);
+	rte_eth_dev_release_port(eth_dev);
+	return 0;
+}
+
+static struct rte_vdev_driver pmd_rtap_drv = {
+	.probe = rtap_probe,
+	.remove = rtap_remove,
+};
+
+RTE_PMD_REGISTER_VDEV(net_rtap, pmd_rtap_drv);
+RTE_PMD_REGISTER_ALIAS(net_rtap, eth_rtap);
+RTE_PMD_REGISTER_PARAM_STRING(net_rtap,
+	RTAP_IFACE_ARG "=<string> "
+	RTAP_PERSIST_ARG);
+RTE_LOG_REGISTER_DEFAULT(rtap_logtype, NOTICE);
-- 
2.51.0

