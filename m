Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C4DC282EC
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Mar 2025 23:54:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48497402E3;
	Wed, 12 Mar 2025 00:54:43 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 0BD574025A
 for <dev@dpdk.org>; Wed, 12 Mar 2025 00:54:40 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-219f8263ae0so116106585ad.0
 for <dev@dpdk.org>; Tue, 11 Mar 2025 16:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741737280;
 x=1742342080; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyFzbCa5swxlQf/XF1pqin+Jvo7E3T9FMCJUwv4/BR4=;
 b=h7loiIN2W/S6eBVAB80Obn9GuTA/jR51cHbQFB4U8QSycL1hoaK4E43dD3S+d0y/aS
 HWcnuEwBsW+r3ZFYVxrCOzsr2ksPNTKnHLceDvTHf4iQgnKcPQmtqRJ56xKUS8qaPoHp
 hv4C3XNrmdf7F7+2ELeiAWnlxul8Okpehb/kmQsYh0xQXGxeK/KxfEa7JPH6B9fNO626
 iEqEsCdirKIvJbgxb5zefkzKsI+9TRAFWNwawKLJRyi85wInfyXWeLDxmxxkQc0OEdvA
 MJw4DGZEBy3H2I88BD0kTaWD6pyXS70j/Jo5KRJH/xhD7zuso2Mz/nR3bHn0fElLbr/8
 mwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741737280; x=1742342080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyFzbCa5swxlQf/XF1pqin+Jvo7E3T9FMCJUwv4/BR4=;
 b=LEQtT2scwYuCPxNLwycRanVUb3E7D2zteZ95eYaYhO1t5sp2QwgnHkTGzXLLYEh2P8
 lmoOjRskZHg9HVyrDvJW2eZ4GLznEi7OzBDEINJ41dGwBV8FzemiWwH/F0XcDIE0lzBz
 vzakQMJun5l8zdkW7oMMEEMPL7nw2/hofIqo8h3tEK7bAIuV+Tlxv0aOQOtQ3DSsNTDw
 2NXhRPiSYImD2BQ0CvVp/+Jgk03AssPgCSAW4WZGltsK0mi3jKuO09PntzqC1WRKz/pF
 Ug4so/7ag5ii6Z/m8bbUgnBNORFLoHphodf7+K9/I6r+sRU6IvX5xUs8T019gjZOxFlN
 GHzA==
X-Gm-Message-State: AOJu0Yy+p0GYb7+n7DjPv4h3mkxVMQEaw6BjP/U0PNpla83g6Jfn17mF
 APzxGiplpdRUCa1yxrNzxtskk2i1op11vHKmOKkDVKo+F0oEHjgCOM+M2BsSVvLZmPrKYAKG2wO
 K
X-Gm-Gg: ASbGncuu7qVKyTGJzk6PcnePuDqjv5DViWg15b4p0XgJcAtkFo+ZJc9f1cEdp3TafOQ
 u3WAwiIGyoe2b+V8jSMmyKs3CtVMHvyh3CKNgRF/sJt1Y/SZR75HeCHSAdxEc8EU2QmXVeL7/WN
 CxnGSp+ftdJyT3ir0ao6kGsi2TI34an/nSusqFiilC4tFA5phvoQOBBKMUY72bHE/hpYiOwd9Xm
 rIQUsyQB9rc5JwLROAXMooQeQFrtnISL1ygjzUnPUdJNl1dA0o4UumBy4PPSTxWf/pxe2EqUORl
 ZLQsYLhSJFF+StmgEcOwQ2LF/FkxCrGgPHpVgWbMPXwEjjbOplXUq7zC8AEbNeg1jiIXo+BGeQx
 sVBxL2PjgoiTZ0pRikHlwhoA0fqg3kzR2
X-Google-Smtp-Source: AGHT+IEpVIzXHwXQdzB63s4BCxOAgADEEq3nqozcHn5agoFpUbxF6A38ZEdScoSvH3COxJ2REyBVIg==
X-Received: by 2002:a17:902:d592:b0:224:376:7a07 with SMTP id
 d9443c01a7336-22592e2ca6emr68086105ad.13.1741737279983; 
 Tue, 11 Mar 2025 16:54:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cf4sm103734145ad.200.2025.03.11.16.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 16:54:39 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 1/9] net/ioring: introduce new driver
Date: Tue, 11 Mar 2025 16:51:19 -0700
Message-ID: <20250311235424.172440-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250311235424.172440-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20250311235424.172440-1-stephen@networkplumber.org>
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

Add basic driver initialization, documentation, and device creation
and basic documentation.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/ioring.ini |   9 +
 doc/guides/nics/index.rst           |   1 +
 doc/guides/nics/ioring.rst          |  66 +++++++
 drivers/net/ioring/meson.build      |  15 ++
 drivers/net/ioring/rte_eth_ioring.c | 262 ++++++++++++++++++++++++++++
 drivers/net/meson.build             |   1 +
 6 files changed, 354 insertions(+)
 create mode 100644 doc/guides/nics/features/ioring.ini
 create mode 100644 doc/guides/nics/ioring.rst
 create mode 100644 drivers/net/ioring/meson.build
 create mode 100644 drivers/net/ioring/rte_eth_ioring.c

diff --git a/doc/guides/nics/features/ioring.ini b/doc/guides/nics/features/ioring.ini
new file mode 100644
index 0000000000..c4c57caaa4
--- /dev/null
+++ b/doc/guides/nics/features/ioring.ini
@@ -0,0 +1,9 @@
+;
+; Supported features of the 'ioring' driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux		     = Y
+x86-64               = Y
+Usage doc            = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 10a2eca3b0..afb6bf289b 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -41,6 +41,7 @@ Network Interface Controller Drivers
     igc
     intel_vf
     ionic
+    ioring
     ipn3ke
     ixgbe
     mana
diff --git a/doc/guides/nics/ioring.rst b/doc/guides/nics/ioring.rst
new file mode 100644
index 0000000000..7d37a6bb37
--- /dev/null
+++ b/doc/guides/nics/ioring.rst
@@ -0,0 +1,66 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+
+IORING Poll Mode Driver
+=======================
+
+The IORING Poll Mode Driver (PMD) is a simplified and improved version of the TAP PMD. It is a
+virtual device that uses Linux ioring to inject packets into the Linux kernel.
+It is useful when writing DPDK applications, that need to support interaction
+with the Linux TCP/IP stack for control plane or tunneling.
+
+The IORING PMD creates a kernel network device that can be
+managed by standard tools such as ``ip`` and ``ethtool`` commands.
+
+From a DPDK application, the IORING device looks like a DPDK ethdev.
+It supports the standard DPDK API's to query for information, statistics,
+and send/receive packets.
+
+Requirements
+------------
+
+The IORING requires the io_uring library (liburing) which provides the helper
+functions to manage io_uring with the kernel.
+
+For more info on io_uring, please see:
+
+https://kernel.dk/io_uring.pdf
+
+
+Arguments
+---------
+
+IORING devices are created with the command line ``--vdev=net_ioring0`` option.
+This option may be specified more than once by repeating with a different ``net_ioringX`` device.
+
+By default, the Linux interfaces are named ``enio0``, ``enio1``, etc.
+The interface name can be specified by adding the ``iface=foo0``, for example::
+
+   --vdev=net_ioring0,iface=io0 --vdev=net_ioring1,iface=io1, ...
+
+The PMD inherits the MAC address assigned by the kernel which will be
+a locally assigned random Ethernet address.
+
+Normally, when the DPDK application exits, the IORING device is removed.
+But this behavior can be overridden by the use of the persist flag, example::
+
+  --vdev=net_ioring0,iface=io0,persist ...
+
+
+Multi-process sharing
+---------------------
+
+The IORING device does not support secondary process (yet).
+
+
+Limitations
+-----------
+
+- IO uring requires io_uring support. This was add in Linux kernl version 5.1
+  Also, IO uring maybe disabled in some environments or by security policies.
+
+- Since IORING device uses a file descriptor to talk to the kernel,
+  the same number of queues must be specified for receive and transmit.
+
+- No flow support. Receive queue selection for incoming packets is determined
+  by the Linux kernel. See kernel documentation for more info:
+  https://www.kernel.org/doc/html/latest/networking/scaling.html
diff --git a/drivers/net/ioring/meson.build b/drivers/net/ioring/meson.build
new file mode 100644
index 0000000000..264554d069
--- /dev/null
+++ b/drivers/net/ioring/meson.build
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2024 Stephen Hemminger
+
+if not is_linux
+    build = false
+    reason = 'only supported on Linux'
+endif
+
+dep = dependency('liburing', required:false)
+reason = 'missing dependency, "liburing"'
+build = dep.found()
+ext_deps += dep
+
+sources = files('rte_eth_ioring.c')
+require_iova_in_mbuf = false
diff --git a/drivers/net/ioring/rte_eth_ioring.c b/drivers/net/ioring/rte_eth_ioring.c
new file mode 100644
index 0000000000..4d5a5174db
--- /dev/null
+++ b/drivers/net/ioring/rte_eth_ioring.c
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) Stephen Hemminger
+ */
+
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
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
+#define IORING_DEFAULT_IFNAME	"itap%d"
+
+RTE_LOG_REGISTER_DEFAULT(ioring_logtype, NOTICE);
+#define RTE_LOGTYPE_IORING ioring_logtype
+#define PMD_LOG(level, ...) RTE_LOG_LINE_PREFIX(level, IORING, "%s(): ", __func__, __VA_ARGS__)
+
+#define IORING_IFACE_ARG	"iface"
+#define IORING_PERSIST_ARG	"persist"
+
+static const char * const valid_arguments[] = {
+	IORING_IFACE_ARG,
+	IORING_PERSIST_ARG,
+	NULL
+};
+
+struct pmd_internals {
+	int keep_fd;			/* keep alive file descriptor */
+	char ifname[IFNAMSIZ];		/* name assigned by kernel */
+	struct rte_ether_addr eth_addr; /* address assigned by kernel */
+};
+
+/* Creates a new tap device, name returned in ifr */
+static int
+tap_open(const char *name, struct ifreq *ifr, uint8_t persist)
+{
+	static const char tun_dev[] = "/dev/net/tun";
+	int tap_fd;
+
+	tap_fd = open(tun_dev, O_RDWR | O_CLOEXEC | O_NONBLOCK);
+	if (tap_fd < 0) {
+		PMD_LOG(ERR, "Open %s failed: %s", tun_dev, strerror(errno));
+		return -1;
+	}
+
+	int features = 0;
+	if (ioctl(tap_fd, TUNGETFEATURES, &features) < 0) {
+		PMD_LOG(ERR, "ioctl(TUNGETFEATURES) %s", strerror(errno));
+		goto error;
+	}
+
+	int flags = IFF_TAP | IFF_MULTI_QUEUE | IFF_NO_PI;
+	if ((features & flags) != flags) {
+		PMD_LOG(ERR, "TUN features %#x missing support for %#x",
+			features, features & flags);
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
+		PMD_LOG(ERR, "ioctl(TUNSETIFF) %s: %s",
+			ifr->ifr_name, strerror(errno));
+		goto error;
+	}
+
+	/* (Optional) keep the device after application exit */
+	if (persist && ioctl(tap_fd, TUNSETPERSIST, 1) < 0) {
+		PMD_LOG(ERR, "ioctl(TUNSETPERIST) %s: %s",
+			ifr->ifr_name, strerror(errno));
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
+eth_dev_close(struct rte_eth_dev *dev)
+{
+	struct pmd_internals *pmd = dev->data->dev_private;
+
+	PMD_LOG(INFO, "Closing %s", pmd->ifname);
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	/* mac_addrs must not be freed alone because part of dev_private */
+	dev->data->mac_addrs = NULL;
+
+	if (pmd->keep_fd != -1) {
+		close(pmd->keep_fd);
+		pmd->keep_fd = -1;
+	}
+
+	return 0;
+}
+
+static const struct eth_dev_ops ops = {
+	.dev_close		= eth_dev_close,
+};
+
+static int
+ioring_create(struct rte_eth_dev *dev, const char *tap_name, uint8_t persist)
+{
+	struct rte_eth_dev_data *data = dev->data;
+	struct pmd_internals *pmd = data->dev_private;
+
+	pmd->keep_fd = -1;
+
+	data->dev_flags = RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
+	dev->dev_ops = &ops;
+
+	/* Get the initial fd used to keep the tap device around */
+	struct ifreq ifr = { };
+	pmd->keep_fd = tap_open(tap_name, &ifr, persist);
+	if (pmd->keep_fd < 0)
+		goto error;
+
+	strlcpy(pmd->ifname, ifr.ifr_name, IFNAMSIZ);
+
+	/* Read the MAC address assigned by the kernel */
+	if (ioctl(pmd->keep_fd, SIOCGIFHWADDR, &ifr) < 0) {
+		PMD_LOG(ERR, "Unable to get MAC address for %s: %s",
+			ifr.ifr_name, strerror(errno));
+		goto error;
+	}
+	memcpy(&pmd->eth_addr, &ifr.ifr_hwaddr.sa_data, RTE_ETHER_ADDR_LEN);
+	data->mac_addrs = &pmd->eth_addr;
+
+	/* Detach this instance, not used for traffic */
+	ifr.ifr_flags = IFF_DETACH_QUEUE;
+	if (ioctl(pmd->keep_fd, TUNSETQUEUE, &ifr) < 0) {
+		PMD_LOG(ERR, "Unable to detach keep-alive queue for %s: %s",
+			ifr.ifr_name, strerror(errno));
+		goto error;
+	}
+
+	PMD_LOG(DEBUG, "%s setup", ifr.ifr_name);
+	return 0;
+
+error:
+	if (pmd->keep_fd != -1)
+		close(pmd->keep_fd);
+	return -1;
+}
+
+static int
+parse_iface_arg(const char *key __rte_unused, const char *value, void *extra_args)
+{
+	char *name = extra_args;
+
+	/* must not be null string */
+	if (name == NULL || name[0] == '\0' ||
+	    strnlen(name, IFNAMSIZ) == IFNAMSIZ)
+		return -EINVAL;
+
+	strlcpy(name, value, IFNAMSIZ);
+	return 0;
+}
+
+static int
+ioring_probe(struct rte_vdev_device *vdev)
+{
+	const char *name = rte_vdev_device_name(vdev);
+	const char *params = rte_vdev_device_args(vdev);
+	struct rte_kvargs *kvlist = NULL;
+	struct rte_eth_dev *eth_dev = NULL;
+	char tap_name[IFNAMSIZ] = IORING_DEFAULT_IFNAME;
+	uint8_t persist = 0;
+	int ret;
+
+	PMD_LOG(INFO, "Initializing %s", name);
+
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		return -1; /* TODO */
+
+	if (params != NULL) {
+		kvlist = rte_kvargs_parse(params, valid_arguments);
+		if (kvlist == NULL)
+			return -1;
+
+		if (rte_kvargs_count(kvlist, IORING_IFACE_ARG) == 1) {
+			ret = rte_kvargs_process_opt(kvlist, IORING_IFACE_ARG,
+						     &parse_iface_arg, tap_name);
+			if (ret < 0)
+				goto error;
+		}
+
+		if (rte_kvargs_count(kvlist, IORING_PERSIST_ARG) == 1)
+			persist = 1;
+	}
+
+	eth_dev = rte_eth_vdev_allocate(vdev, sizeof(struct pmd_internals));
+	if (eth_dev == NULL) {
+		PMD_LOG(ERR, "%s Unable to allocate device struct", tap_name);
+		goto error;
+	}
+
+	if (ioring_create(eth_dev, tap_name, persist) < 0)
+		goto error;
+
+	rte_eth_dev_probing_finish(eth_dev);
+	return 0;
+
+error:
+	if (eth_dev != NULL)
+		rte_eth_dev_release_port(eth_dev);
+	rte_kvargs_free(kvlist);
+	return -1;
+}
+
+static int
+ioring_remove(struct rte_vdev_device *dev)
+{
+	struct rte_eth_dev *eth_dev;
+
+	eth_dev = rte_eth_dev_allocated(rte_vdev_device_name(dev));
+	if (eth_dev == NULL)
+		return 0;
+
+	eth_dev_close(eth_dev);
+	rte_eth_dev_release_port(eth_dev);
+	return 0;
+}
+
+static struct rte_vdev_driver pmd_ioring_drv = {
+	.probe = ioring_probe,
+	.remove = ioring_remove,
+};
+
+RTE_PMD_REGISTER_VDEV(net_ioring, pmd_ioring_drv);
+RTE_PMD_REGISTER_ALIAS(net_ioring, eth_ioring);
+RTE_PMD_REGISTER_PARAM_STRING(net_ioring, IORING_IFACE_ARG "=<string> ");
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 460eb69e5b..2e39136a5b 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -34,6 +34,7 @@ drivers = [
         'intel/ixgbe',
         'intel/cpfl',  # depends on idpf, so must come after it
         'ionic',
+        'ioring',
         'mana',
         'memif',
         'mlx4',
-- 
2.47.2

