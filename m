Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8066CCA5FE3
	for <dpdk-dev@archiver.kernel.org>; Sat,  3 Oct 2026 08:23:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69116402DA;
	Sat,  3 Oct 2026 10:23:40 +0200 (CEST)
Received: from mail-qv2-f41.google.com (mail-qv2-f41.google.com
 [74.125.230.169])
 by mails.dpdk.org (Postfix) with ESMTP id 1427F4003C
 for <dev@dpdk.org>; Fri,  2 Oct 2026 22:09:30 +0200 (CEST)
Received: by mail-qv2-f41.google.com with SMTP id
 6a1803df08f44-91786d375bbso2388546d6.0
 for <dev@dpdk.org>; Fri, 02 Oct 2026 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790971769; x=1791576569; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l+e7+wtA8MFfCm2+cDHVNEZ+o3fc2+qQ7El4UTpa6Ss=;
 b=kmBzwPYT5ZWH6bPVx286htwYKRPjPfKTeukj5lDbuw9cvTDcNp+rA+UCNpj75FXRxj
 K5bfQCl4F8p2/A9/Ezlwr5YAIYn3in7L5YbaljPTR3dbdAJxCVAAaaGdgimvdo78M+vf
 E+tDhmsVq3x2Um13rnqgBQeK8uJ09u/9iTzq2ZAo9VSUcv7NZkOKRbga4SKVaewW9cKf
 6A+PF8xX21zZG17dffSlhS3slDldtHFZ9XFNDDaBv9t78YKI+ipDPXVhzBh4U+JbGNfA
 VHnmdbwKt4K9jjXfxffyTw/BDPnEjKp1O3Y93C8t5B+lyEI1/W+jwGuSwx4TcfT1hQiB
 6M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790971769; x=1791576569;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l+e7+wtA8MFfCm2+cDHVNEZ+o3fc2+qQ7El4UTpa6Ss=;
 b=rPO5Sa8AjgBsoL1JdbM8oVla4wv5FSH7IGGaXw/Xy95XaeoKAXpB+b7EFyX5+lb14i
 jCeaCuPYMvk9eKHhEbfMbPVvVJcjdTO4i7mW6G9394U8zSn30gha/zRdQNRUXl6Y8K+D
 zhnCdRAziaHeosAghIbF469J3RrvagfBjaAb+/x9ak45Hz1Y0uoY9SQESEId1nK4pKA5
 1UyCRaptYRUirIWT8FC8//sV2s33mB1faYhPcG/hHRaQFU+U3obIVgDPjkRGvaAKjon+
 kPUK+rFeFguQ6U1j9I1Alb5neynZkMML367sXERn9VVxp+s1wb6UjtXdVOT29lddI6Na
 na3g==
X-Gm-Message-State: AFuF++mdxxoCVpcxjt0ULI0FcHjRT6B313n5LPjtq6HwaZ9DYc2sMlGb
 ddxYlKe/+I+hv4j8Lc0T056SDj+qtkXlxrlG0KSZ9I+/xyD9q0zxXRVgULmswhCe
X-Gm-Gg: AYBFou0zuCe69CquOUBGiSOYq0vGV9r+beU966BhIk893Ep+w/xgi1/VUa9nXQRKtRN
 fjQsGP7qMSey8Xr9MM4fj+P9J/IZzJt0U8bmU2IrBFqmD92xZMzK+LbDwg8WO6dVbURymiucdw+
 ekM9oPqWFMokLbBBEslBctvJUuHMCdB9W4Drn/9UjVNj4EHNvJeyPerpQxGcOYpKrNSMw3qjh7N
 Y/ULkkN+BNRMnLuwGhUgPO1N4EPzGJzS1mXTZ9kGbDieT0XlC3dTpOFZ50iQTD3blBVtnr+zhZl
 HIyyfT9Qc+rxqMull6MQMdPMFcGW6Bi/RgsB4h1Zj2UbAS2B2TutZ1bUCv6RaEVqv8kd00f3NpN
 hGW4/Rhir75nsrmEQ4J2j9qqP17llPESbqbmRNdFtb0zIr4KS9v17wh5w3MC3kpI3K2OEXRj0Ms
 jqlXfK8A7JEyytGC2WbxHQ4vY+Ep0NqASleYc6g9yI6490UqA7DUcJCtgrQfzObPwTwVotOOYmT
 g==
X-Received: by 2002:a05:620a:650a:b0:93e:5247:f61e with SMTP id
 af79cd13be357-93e5247fe8cmr35230885a.25.1790971769227; 
 Fri, 02 Oct 2026 13:09:29 -0700 (PDT)
Received: from ubuntu-desktop.. ([137.99.252.104])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0bc98fbsm27933156d6.29.2026.10.02.13.09.28
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:09:28 -0700 (PDT)
From: Md Rayhanul Islam <r97yhan@gmail.com>
To: dev@dpdk.org
Subject: [RFC PATCH 1/2] eal/pci: add per-device DMA translation and
 synchronization
Date: Fri,  2 Oct 2026 16:09:26 -0400
Message-Id: <20261002200927.6235-2-r97yhan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002200927.6235-1-r97yhan@gmail.com>
References: <20260918225045.177125-1-r97yhan@gmail.com>
 <20261002200927.6235-1-r97yhan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 03 Oct 2026 10:23:38 +0200
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

Some PCIe platforms, such as BCM2711, translate DMA addresses and are not
cache coherent.  Both belong to the bridge above a device, so one offset
applied to the whole process is wrong on a board with two controllers.

Read them per device.  The PCI bus walks the device's sysfs ancestry to
its bridge, and a driver copies the result with rte_pci_get_dma_info().
Addresses are translated where they are programmed into the hardware,
with rte_pci_dma_iova(), so EAL IOVAs are untouched.  Properties this
parser cannot express mark that one device unusable rather than failing
the scan.

A driver must set RTE_PCI_DRV_DMA_NONCOHERENT before the bus hands it
such a device.  Only bridges in the compatible table are read, so other
platforms keep the behavior they have today.

Add rte_mem_sync_for_device() and rte_mem_sync_for_cpu(), named after
dma_sync_single_for_{device,cpu}(), with explicit transfer directions,
and rte_mem_dcache_line_size().  On arm64 they are DC CVAC and DC CIVAC
loops closed with DSB SY, since the DPDK barriers are DMB and do not
order cache maintenance.  EL0 cannot execute DC IVAC, so the CPU-side
helper cleans as well as invalidates.

Signed-off-by: Md Rayhanul Islam <r97yhan@gmail.com>
---
 .mailmap                               |   1 +
 doc/guides/rel_notes/release_26_11.rst |  15 +++
 drivers/bus/pci/bus_pci_driver.h       |   2 +
 drivers/bus/pci/linux/pci.c            |   6 +
 drivers/bus/pci/linux/pci_dma_ranges.c | 168 +++++++++++++++++++++++++
 drivers/bus/pci/linux/pci_init.h       |   2 +
 drivers/bus/pci/meson.build            |   1 +
 drivers/bus/pci/pci_common.c           |  17 +++
 drivers/bus/pci/private.h              |   2 +
 drivers/bus/pci/rte_bus_pci.h          |  52 ++++++++
 lib/eal/include/meson.build            |   1 +
 lib/eal/include/rte_mem_sync.h         | 133 ++++++++++++++++++++
 12 files changed, 400 insertions(+)
 create mode 100644 drivers/bus/pci/linux/pci_dma_ranges.c
 create mode 100644 lib/eal/include/rte_mem_sync.h

diff --git a/.mailmap b/.mailmap
index 9e45cdce8f..9fd78db7e2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1032,6 +1032,7 @@ Marek Mical <marekx.mical@intel.com>
 Marek Zalfresso-jundzillo <marekx.zalfresso-jundzillo@intel.com>
 Maria Lingemark <maria.lingemark@ericsson.com>
 Mario Carrillo <mario.alfredo.c.arevalo@intel.com>
+Md Rayhanul Islam <r97yhan@gmail.com>
 Mário Kuka <kuka@cesnet.cz>
 Mariusz Drost <mariuszx.drost@intel.com>
 Mark Asselstine <mark.asselstine@windriver.com>
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 4b3e5d995c..a752c94bbf 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,21 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added per-device DMA properties to the PCI bus.**
+
+  The Linux PCI bus reads the address translation and the cache coherency
+  of the host bridge above a device from the device tree, and exposes them
+  through ``rte_pci_get_dma_info()`` and ``rte_pci_dma_iova()``.  A driver
+  must set ``RTE_PCI_DRV_DMA_NONCOHERENT`` before the bus gives it a device
+  that needs either.  Devices behind a translating, non-coherent bridge,
+  such as those on the Broadcom BCM2711, can now be used.
+
+* **Added cache maintenance helpers for non-coherent DMA.**
+
+  ``rte_mem_sync_for_device()`` and ``rte_mem_sync_for_cpu()`` hand a buffer
+  between the CPU and a device whose DMA is not coherent with the caches,
+  with an explicit transfer direction.
+
 
 Removed Items
 -------------
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index c04ebddf59..216e4beb20 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -140,6 +140,8 @@ struct rte_pci_driver {
 #define RTE_PCI_DRV_KEEP_MAPPED_RES 0x0020
 /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
 #define RTE_PCI_DRV_NEED_IOVA_AS_VA 0x0040
+/** Driver translates DMA addresses and maintains caches itself. */
+#define RTE_PCI_DRV_DMA_NONCOHERENT 0x0080
 
 /**
  * Register a PCI driver.
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..55c989c55d 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -220,6 +220,8 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 	dev = &pdev->device;
 	dev->addr = *addr;
 
+	pci_dt_read_dma_info(dev, dirname);
+
 	/* get vendor id */
 	snprintf(filename, sizeof(filename), "%s/vendor", dirname);
 	if (eal_parse_sysfs_value(filename, &tmp) < 0) {
@@ -335,6 +337,7 @@ pci_scan_one(const char *dirname, const struct rte_pci_addr *addr)
 				rte_bus_insert_device(&rte_pci_bus, &dev2->device, &dev->device);
 			} else { /* already registered */
 				if (!rte_dev_is_probed(&dev2->device)) {
+					RTE_PCI_DEVICE_INTERNAL(dev2)->dma = pdev->dma;
 					dev2->kdrv = dev->kdrv;
 					dev2->max_vfs = dev->max_vfs;
 					dev2->id = dev->id;
@@ -591,6 +594,9 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 {
 	enum rte_iova_mode iova_mode = RTE_IOVA_DC;
 
+	if (RTE_PCI_DEVICE_INTERNAL_CONST(pdev)->dma.size != 0)
+		return RTE_IOVA_PA;
+
 	switch (pdev->kdrv) {
 	case RTE_PCI_KDRV_VFIO: {
 		static int is_vfio_noiommu_enabled = -1;
diff --git a/drivers/bus/pci/linux/pci_dma_ranges.c b/drivers/bus/pci/linux/pci_dma_ranges.c
new file mode 100644
index 0000000000..da5edbd5cc
--- /dev/null
+++ b/drivers/bus/pci/linux/pci_dma_ranges.c
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Md Rayhanul Islam
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_string_fns.h>
+
+#include "pci_init.h"
+#include "private.h"
+
+static int
+dt_read(const char *node, const char *name, void *buf, size_t size)
+{
+	char path[PATH_MAX];
+	size_t len;
+	int ret;
+	FILE *f;
+
+	if (snprintf(path, sizeof(path), "%s/%s", node, name) >= (int)sizeof(path))
+		return -ENAMETOOLONG;
+	f = fopen(path, "rb");
+	if (f == NULL)
+		return -errno;
+	len = fread(buf, 1, size, f);
+	ret = ferror(f) ? -EIO : (int)len;
+	if (ret >= 0 && fgetc(f) != EOF)
+		ret = -E2BIG;
+	fclose(f);
+	return ret;
+}
+
+static bool
+dt_is_known_bridge(const char *node)
+{
+	static const char * const compatible[] = { "brcm,bcm2711-pcie" };
+	char buf[256];
+	size_t pos, n, i;
+	int len;
+
+	len = dt_read(node, "compatible", buf, sizeof(buf));
+	if (len <= 0 || buf[len - 1] != '\0')
+		return false;
+	for (pos = 0; pos < (size_t)len; pos += n + 1) {
+		n = strlen(buf + pos);
+		for (i = 0; i < RTE_DIM(compatible); i++)
+			if (strcmp(buf + pos, compatible[i]) == 0)
+				return true;
+	}
+	return false;
+}
+
+static int
+dt_cells(const char *node, const char *name)
+{
+	rte_be32_t value;
+
+	if (dt_read(node, name, &value, sizeof(value)) != sizeof(value))
+		return -EINVAL;
+	return rte_be_to_cpu_32(value);
+}
+
+static uint64_t
+dt_address(const rte_be32_t *cells, int n)
+{
+	uint64_t value = 0;
+
+	while (n-- > 0)
+		value = (value << 32) | rte_be_to_cpu_32(*cells++);
+	return value;
+}
+
+/* One <pci-address> <parent-address> <size> entry in "dma-ranges". */
+static int
+dt_dma_window(const char *node, struct rte_pci_dma_info *info)
+{
+	char parent[PATH_MAX], *slash;
+	rte_be32_t cells[7];
+	int ac, len;
+
+	strlcpy(parent, node, sizeof(parent));
+	slash = strrchr(parent, '/');
+	if (slash == NULL || slash == parent)
+		return -EINVAL;
+	*slash = '\0';
+
+	ac = dt_cells(parent, "#address-cells");
+	if ((ac != 1 && ac != 2) || dt_cells(node, "#address-cells") != 3 ||
+			dt_cells(node, "#size-cells") != 2)
+		return -ENOTSUP;
+
+	len = dt_read(node, "dma-ranges", cells, sizeof(cells));
+	if (len < 0)
+		return len;
+	if (len != (3 + ac + 2) * (int)sizeof(cells[0]) ||
+			(rte_be_to_cpu_32(cells[0]) & 0x03000000) != 0x02000000)
+		return -ENOTSUP;
+
+	info->bus_base = dt_address(cells + 1, 2);
+	info->cpu_base = dt_address(cells + 3, ac);
+	info->size = dt_address(cells + 3 + ac, 2);
+	if (info->size == 0 || info->size > UINT64_MAX - info->cpu_base ||
+			info->size > UINT64_MAX - info->bus_base)
+		return -EINVAL;
+	return 0;
+}
+
+/* The nearest ancestor that declares coherency decides it. */
+static bool
+dt_is_coherent(const char *node)
+{
+	char path[PATH_MAX], value;
+	char *slash;
+
+	strlcpy(path, node, sizeof(path));
+	for (;;) {
+		if (dt_read(path, "dma-coherent", &value, sizeof(value)) >= 0)
+			return true;
+		if (dt_read(path, "dma-noncoherent", &value, sizeof(value)) >= 0)
+			return false;
+		slash = strrchr(path, '/');
+		if (slash == NULL || slash == path)
+			return false;
+		*slash = '\0';
+	}
+}
+
+/*
+ * Unparseable properties mark only this device unusable, so the scan of the
+ * other devices is not affected.
+ */
+void
+pci_dt_read_dma_info(struct rte_pci_device *dev, const char *dirname)
+{
+	struct rte_pci_dma_info *info = &RTE_PCI_DEVICE_INTERNAL(dev)->dma;
+	char node[PATH_MAX], path[PATH_MAX], of_node[PATH_MAX];
+	char *slash;
+	int ret;
+
+	memset(info, 0, sizeof(*info));
+	if (realpath(dirname, node) == NULL)
+		return;
+
+	while ((slash = strrchr(node, '/')) != NULL && slash != node) {
+		if (snprintf(path, sizeof(path), "%s/of_node", node) <
+				(int)sizeof(path) &&
+				realpath(path, of_node) != NULL &&
+				dt_is_known_bridge(of_node)) {
+			ret = dt_dma_window(of_node, info);
+			if (ret < 0) {
+				PCI_LOG(ERR, "%s: cannot use the DMA properties of %s",
+					dev->name, of_node);
+				info->unusable = true;
+				return;
+			}
+			info->noncoherent = !dt_is_coherent(of_node);
+			return;
+		}
+		*slash = '\0';
+	}
+}
diff --git a/drivers/bus/pci/linux/pci_init.h b/drivers/bus/pci/linux/pci_init.h
index 6949dd57d9..fcbf5cdfa2 100644
--- a/drivers/bus/pci/linux/pci_init.h
+++ b/drivers/bus/pci/linux/pci_init.h
@@ -73,4 +73,6 @@ int pci_vfio_unmap_resource(struct rte_pci_device *dev);
 
 int pci_vfio_is_enabled(void);
 
+void pci_dt_read_dma_info(struct rte_pci_device *dev, const char *dirname);
+
 #endif /* EAL_PCI_INIT_H_ */
diff --git a/drivers/bus/pci/meson.build b/drivers/bus/pci/meson.build
index fede114dc7..9e9b27ef4d 100644
--- a/drivers/bus/pci/meson.build
+++ b/drivers/bus/pci/meson.build
@@ -10,6 +10,7 @@ if is_linux
     sources += files(
             'pci_common_uio.c',
             'linux/pci.c',
+            'linux/pci_dma_ranges.c',
             'linux/pci_uio.c',
             'linux/pci_vfio.c',
     )
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b..14efb46d23 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -142,6 +142,14 @@ pci_unmap_resource(void *requested_addr, size_t size)
 		PCI_LOG(DEBUG, "  PCI memory unmapped at %p", requested_addr);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_get_dma_info)
+void
+rte_pci_get_dma_info(const struct rte_pci_device *dev,
+		struct rte_pci_dma_info *info)
+{
+	*info = RTE_PCI_DEVICE_INTERNAL_CONST(dev)->dma;
+}
+
 static bool
 pci_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 {
@@ -186,6 +194,7 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	struct rte_pci_driver *pci_drv = RTE_BUS_DRIVER(drv, *pci_drv);
 	struct rte_pci_addr *loc = &pci_dev->addr;
+	const struct rte_pci_dma_info *dma;
 	bool already_probed;
 	int ret;
 
@@ -196,6 +205,14 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (pci_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		PCI_LOG(INFO, "Device %s is not NUMA-aware", pci_dev->name);
 
+	dma = &RTE_PCI_DEVICE_INTERNAL(pci_dev)->dma;
+	if (dma->unusable || ((dma->noncoherent || dma->size != 0) &&
+			!(pci_drv->drv_flags & RTE_PCI_DRV_DMA_NONCOHERENT))) {
+		PCI_LOG(ERR, "%s: %s does not handle this device's DMA properties",
+			pci_dev->name, pci_drv->driver.name);
+		return -ENOTSUP;
+	}
+
 	already_probed = (pci_dev->intr_handle != NULL);
 	if (already_probed && !(pci_drv->drv_flags & RTE_PCI_DRV_PROBE_AGAIN)) {
 		PCI_LOG(DEBUG, "Device %s is already probed", pci_dev->device.name);
diff --git a/drivers/bus/pci/private.h b/drivers/bus/pci/private.h
index 8103c32881..5a0286dbc0 100644
--- a/drivers/bus/pci/private.h
+++ b/drivers/bus/pci/private.h
@@ -13,6 +13,7 @@
 #include <rte_log.h>
 #include <rte_os_shim.h>
 #include <rte_pci.h>
+#include <rte_bus_pci.h>
 
 extern int pci_bus_logtype;
 #define RTE_LOGTYPE_PCI_BUS pci_bus_logtype
@@ -41,6 +42,7 @@ struct rte_pci_region {
 
 struct rte_pci_device_internal {
 	struct rte_pci_device device;
+	struct rte_pci_dma_info dma;
 	/* PCI regions provided by e.g. VFIO. */
 	struct rte_pci_region region[RTE_MAX_PCI_REGIONS];
 };
diff --git a/drivers/bus/pci/rte_bus_pci.h b/drivers/bus/pci/rte_bus_pci.h
index 19a7b15b99..1db4fdbdd8 100644
--- a/drivers/bus/pci/rte_bus_pci.h
+++ b/drivers/bus/pci/rte_bus_pci.h
@@ -172,6 +172,58 @@ __rte_internal
 int rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 		off_t offset, bool enable);
 
+/**
+ * @internal
+ * DMA properties of the host bridge above a device.  A zero size means
+ * addresses are not translated.
+ */
+struct rte_pci_dma_info {
+	uint64_t cpu_base;
+	uint64_t bus_base;
+	uint64_t size;
+	bool noncoherent;
+	bool unusable;		/**< properties the bus could not parse. */
+};
+
+/**
+ * @internal
+ * Copy a device's DMA properties.  Drivers supporting secondary processes
+ * keep the copy in shared data.
+ *
+ * @param dev
+ *   The PCI device.
+ * @param info
+ *   Filled in with the bridge's DMA properties.
+ */
+__rte_internal
+void rte_pci_get_dma_info(const struct rte_pci_device *dev,
+		struct rte_pci_dma_info *info);
+
+/**
+ * @internal
+ * Translate an IOVA range into a device address.
+ *
+ * @return
+ *   The device address, or RTE_BAD_IOVA if the range is outside the window.
+ */
+static inline rte_iova_t
+rte_pci_dma_iova(const struct rte_pci_dma_info *info, rte_iova_t iova,
+		size_t len)
+{
+	uint64_t offset;
+
+	if (iova == RTE_BAD_IOVA || len == 0)
+		return RTE_BAD_IOVA;
+	if (info->size == 0)
+		return iova;
+	if (iova < info->cpu_base)
+		return RTE_BAD_IOVA;
+	offset = iova - info->cpu_base;
+	if (offset >= info->size || len > info->size - offset)
+		return RTE_BAD_IOVA;
+	return info->bus_base + offset;
+}
+
 /**
  * Read PCI config space.
  *
diff --git a/lib/eal/include/meson.build b/lib/eal/include/meson.build
index aef5824e5f..9eabd91773 100644
--- a/lib/eal/include/meson.build
+++ b/lib/eal/include/meson.build
@@ -32,6 +32,7 @@ headers += files(
         'rte_lock_annotations.h',
         'rte_malloc.h',
         'rte_mcslock.h',
+        'rte_mem_sync.h',
         'rte_memory.h',
         'rte_memzone.h',
         'rte_pci_dev_feature_defs.h',
diff --git a/lib/eal/include/rte_mem_sync.h b/lib/eal/include/rte_mem_sync.h
new file mode 100644
index 0000000000..6ac517f243
--- /dev/null
+++ b/lib/eal/include/rte_mem_sync.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Md Rayhanul Islam
+ */
+
+#ifndef RTE_MEM_SYNC_H
+#define RTE_MEM_SYNC_H
+
+/**
+ * @file
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Cache maintenance for devices whose DMA is not coherent with the CPU
+ * caches, after dma_sync_single_for_{device,cpu}().  Ownership is per cache
+ * line, and a sync does not wait for the transfer to complete.  Empty on
+ * coherent platforms.
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include <rte_common.h>
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/** Transfer direction, as the device sees it. */
+enum rte_mem_sync_direction {
+	RTE_MEM_SYNC_TO_DEVICE,
+	RTE_MEM_SYNC_FROM_DEVICE,
+	RTE_MEM_SYNC_BIDIRECTIONAL,
+};
+
+/** Size of a data cache line on this CPU. */
+__rte_experimental
+static inline size_t
+rte_mem_dcache_line_size(void)
+{
+#ifdef RTE_ARCH_ARM64
+	uint64_t ctr;
+
+	/* CTR_EL0.DminLine is log2 of the line size in words. */
+	asm volatile("mrs %0, ctr_el0" : "=r" (ctr));
+	return 4U << ((ctr >> 16) & 0xf);
+#else
+	return RTE_CACHE_LINE_SIZE;
+#endif
+}
+
+/** Whether this build implements the maintenance below. */
+__rte_experimental
+static inline bool
+rte_mem_sync_supported(void)
+{
+#if defined(RTE_ARCH_ARM64) && defined(RTE_EXEC_ENV_LINUX)
+	return true;
+#else
+	return false;
+#endif
+}
+
+#if defined(RTE_ARCH_ARM64) && defined(RTE_EXEC_ENV_LINUX)
+
+/**
+ * Hand [addr, addr + len) to the device.  EL0 cannot execute DC IVAC, so a
+ * buffer the device writes is cleaned as well as invalidated.
+ */
+__rte_experimental
+static inline void
+rte_mem_sync_for_device(const void *addr, size_t len,
+		enum rte_mem_sync_direction direction)
+{
+	uintptr_t p = (uintptr_t)addr & ~(uintptr_t)(RTE_CACHE_LINE_MIN_SIZE - 1);
+	uintptr_t last = ((uintptr_t)addr + len - 1) &
+			~(uintptr_t)(RTE_CACHE_LINE_MIN_SIZE - 1);
+
+	if (len == 0)
+		return;
+	for (;;) {
+		if (direction == RTE_MEM_SYNC_TO_DEVICE)
+			asm volatile("dc cvac, %0" : : "r" (p) : "memory");
+		else
+			asm volatile("dc civac, %0" : : "r" (p) : "memory");
+		if (p == last)
+			break;
+		p += RTE_CACHE_LINE_MIN_SIZE;
+	}
+	/* DMB does not order cache maintenance. */
+	asm volatile("dsb sy" : : : "memory");
+}
+
+/** Take [addr, addr + len) back from the device once the transfer is done. */
+__rte_experimental
+static inline void
+rte_mem_sync_for_cpu(const void *addr, size_t len,
+		enum rte_mem_sync_direction direction)
+{
+	if (direction != RTE_MEM_SYNC_TO_DEVICE)
+		rte_mem_sync_for_device(addr, len, RTE_MEM_SYNC_FROM_DEVICE);
+}
+
+#else
+
+__rte_experimental
+static inline void
+rte_mem_sync_for_device(const void *addr, size_t len,
+		enum rte_mem_sync_direction direction)
+{
+	RTE_SET_USED(addr);
+	RTE_SET_USED(len);
+	RTE_SET_USED(direction);
+}
+
+__rte_experimental
+static inline void
+rte_mem_sync_for_cpu(const void *addr, size_t len,
+		enum rte_mem_sync_direction direction)
+{
+	RTE_SET_USED(addr);
+	RTE_SET_USED(len);
+	RTE_SET_USED(direction);
+}
+
+#endif /* RTE_ARCH_ARM64 && RTE_EXEC_ENV_LINUX */
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* RTE_MEM_SYNC_H */
-- 
2.34.1

