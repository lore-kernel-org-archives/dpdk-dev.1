Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F9BE7E0D5
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 18:40:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCADD4066E;
	Mon,  9 Feb 2026 19:40:53 +0100 (CET)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65]) by mails.dpdk.org (Postfix) with ESMTP id 98A4940665
 for <dev@dpdk.org>; Mon,  9 Feb 2026 19:40:52 +0100 (CET)
Received: by mail-wr1-f65.google.com with SMTP id
 ffacd0b85a97d-436234ef0f0so2623380f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 10:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770662452;
 x=1771267252; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFIvnsFZOU3BxJxyPeY7M22nYkAeexF0G9Cc9pxBNw4=;
 b=zAmAfvYgmEHPxZT+ShuGmcgkWfxiFsunJKFTQvVXxfE53dDQa6IqMqJ3Hr4/HBjX6W
 K4Ig3u1nwcLK029kT5PzWcc/0wwPmLHqbzc+v6Afm78WS10AITyZnlpk2vc80z//MqOn
 yp3wblq+iPmutRAjqjp0+SJdXwddB8h30kZzAvfGhrzsxM4o/HweDG7LfthMlJAd3I8q
 AxzADkqMyQvT1RGjFjOrlJQWG1yFwnvtMYaf599DBcOmxrGFocyxC7WWbOqAYv/gifJd
 wKSbvai8z5ZmT928hWF2wT5ywWHWkbDlrvBKIhnp4Ay9OvbIAe8DoZWKurONl2X+7831
 Y8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770662452; x=1771267252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rFIvnsFZOU3BxJxyPeY7M22nYkAeexF0G9Cc9pxBNw4=;
 b=QBO/ufBuPwk9KfKHKBCtphrQTbpjxQ4DMqbV4vipZ/RLLrQnR8W1ZMYvFwkUxVj06g
 QlOX4yU4JClfjxo8o+L3TVKBahhq8Z+WuWTO/ymoTY/QWSd4bfLJmnYZGH6qdAFWLt6W
 OgfsZo0snRf14GCFNqVmrkf8f2Is/XYH2sAxaVSrVtvvrZziLPsQTWav7N5bPxHgT4JM
 9oboj2x9vt2Q6ot6S6ApWGOBBYqwBZd6Fv1Sz45xSUXy0iYtVDFzI/CQHzwkOA/MnUJZ
 6Yzpxki1ox765VpVNkTHMz433Bhtz9nJRqnz/LdCBDGhIuR3x+GTWjgP2e2bAhwRNu/O
 JpAw==
X-Gm-Message-State: AOJu0Yx9T8oTIgUlSu+zqO5FtsIot3dWl4CEag5YdR7EDbVivONWDLJq
 qKra/REFRMnDVgUqODind6QfFyBS5rlfFWshu0F4XH8iiohUKHhIm01M2i3kg+es8BWhfy+0MK9
 UdRk50G8=
X-Gm-Gg: AZuq6aLPYcepGI+vnaVfDyPkblCTcyryb6Qoz9ot1tSPeCwUKhKpJXKyTjkkCBjRddz
 k9/5TnUmooxPHVuqy0N133sR3YUB466TmGjn5KGAMxrQmkx8irQ139mBlrP3NEhmpHLMuwsqGNB
 ReQZeREbZKxSyazd4HHKQKCnTzBnov20zPJCU0+Vryi2UkI1WnFK7VjC0Erq15vSJPfYoiBgMwb
 Ydi8EvHZXgbn4CshLp0royAFNdPV5xmXb1WA9F5ebksRWBLZXGYkHYM7MLhPCYNkOJkfmuTsTx5
 WWa9snahAC+hFzu7A3Ij8pXP93WQLBn5i0FGrILMwtNfCK/dAZ/UwpbREdVz8IAnVh0inbAz411
 e/pbns4xXT5qHV9B3AZhQiLnZegY9zvpg2kEXcBTtaN9Woz9ndLex/FshtK9Cv2XEFxsVQx3wKd
 jRe6qkwlbrkDcaUJZOmaRNn04PiLSsfaVzljnNaBIIuY3yXqnoKw==
X-Received: by 2002:a5d:408e:0:b0:436:30b0:759e with SMTP id
 ffacd0b85a97d-43630b076e8mr11697217f8f.26.1770662451877; 
 Mon, 09 Feb 2026 10:40:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fc26sm26448426f8f.22.2026.02.09.10.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:40:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 01/10] net/rtap: add driver skeleton and documentation
Date: Mon,  9 Feb 2026 10:39:00 -0800
Message-ID: <20260209184045.132774-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209184045.132774-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260209184045.132774-1-stephen@networkplumber.org>
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
It requires the liburing library version 2.0 or later.
Earlier versions have known security and build issues.
The library is available in all currently supported distributions
(Debian 12+, Ubuntu 22.04+, RHEL 9+, Fedora 35+)

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 MAINTAINERS                            |   7 +
 doc/guides/nics/features/rtap.ini      |  13 ++
 doc/guides/nics/index.rst              |   1 +
 doc/guides/nics/rtap.rst               | 101 +++++++++++++++
 doc/guides/rel_notes/release_26_03.rst |   6 +
 drivers/net/meson.build                |   1 +
 drivers/net/rtap/meson.build           |  26 ++++
 drivers/net/rtap/rtap.h                |  69 ++++++++++
 drivers/net/rtap/rtap_ethdev.c         | 172 +++++++++++++++++++++++++
 9 files changed, 396 insertions(+)
 create mode 100644 doc/guides/nics/features/rtap.ini
 create mode 100644 doc/guides/nics/rtap.rst
 create mode 100644 drivers/net/rtap/meson.build
 create mode 100644 drivers/net/rtap/rtap.h
 create mode 100644 drivers/net/rtap/rtap_ethdev.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5683b87e4a..3d0877fdc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1135,6 +1135,13 @@ F: doc/guides/nics/pcap_ring.rst
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
index b00ed998c5..274575fe70 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -65,6 +65,7 @@ Network Interface Controller Drivers
     qede
     r8169
     rnp
+    rtap
     sfc_efx
     softnic
     tap
diff --git a/doc/guides/nics/rtap.rst b/doc/guides/nics/rtap.rst
new file mode 100644
index 0000000000..1c1cb8dd58
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
+- Ubuntu 24.04 (Noble) or later (22.04 with HWE kernel)
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
index 031eaa657e..db5c61a15c 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -63,6 +63,12 @@ New Features
 
   * Added support for pre and post VF reset callbacks.
 
+* **Added rtap virtual ethernet driver.**
+
+  Added a new experimental virtual device driver that uses Linux io_uring
+  for packet injection into the kernel network stack.
+  It requires Linux kernel 5.1 or later and the liburing library.
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
index 0000000000..507ab000f3
--- /dev/null
+++ b/drivers/net/rtap/rtap.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#ifndef _RTAP_H_
+#define _RTAP_H_
+
+#include <assert.h>
+#include <unistd.h>
+#include <net/if.h>
+#include <liburing.h>
+#include <linux/virtio_net.h>
+
+#include <ethdev_driver.h>
+#include <rte_ether.h>
+#include <rte_log.h>
+
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
+	char ifname[IFNAMSIZ];		/* name assigned by kernel */
+	struct rte_ether_addr eth_addr; /* address assigned by kernel */
+};
+
+#endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
new file mode 100644
index 0000000000..ee5b5bad1b
--- /dev/null
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2026 Stephen Hemminger
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if.h>
+#include <linux/if_arp.h>
+#include <linux/if_tun.h>
+#include <linux/virtio_net.h>
+
+#include <bus_vdev_driver.h>
+#include <ethdev_driver.h>
+#include <ethdev_vdev.h>
+#include <rte_common.h>
+#include <rte_dev.h>
+#include <rte_eal.h>
+#include <rte_ethdev.h>
+#include <rte_ether.h>
+#include <rte_kvargs.h>
+#include <rte_log.h>
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
+	PMD_LOG(INFO, "Closing %s", pmd->ifname);
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

