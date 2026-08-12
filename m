Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17A1C5CFEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Aug 2026 09:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9871C4068A;
	Wed, 12 Aug 2026 11:29:38 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id AE7E340279
 for <dev@dpdk.org>; Wed, 12 Aug 2026 11:29:34 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 939BF200306;
 Wed, 12 Aug 2026 11:29:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E4F2200302;
 Wed, 12 Aug 2026 11:29:34 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5619418000B5;
 Wed, 12 Aug 2026 17:29:33 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, Gagandeep Singh <g.singh@nxp.com>,
 Prashant Gupta <prashant.gupta_3@nxp.com>
Subject: [PATCH v4 2/5] dma/imx_edma5: introduce eDMA5 dmadev skeleton
Date: Wed, 12 Aug 2026 14:59:26 +0530
Message-Id: <20260812092929.563973-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260812092929.563973-1-g.singh@nxp.com>
References: <20260811104933.3843522-1-g.singh@nxp.com>
 <20260812092929.563973-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add the skeleton of a dmadev PMD for the NXP i.MX95 eDMA5 (Enhanced
Direct Memory Access Type 5) controller. The eDMA5 exposes 64 channels
with a 64-bit TCD (TCD64) layout.

The controller is probed on the platform bus via the generic
vfio-platform kernel driver and claimed by its device-tree compatible
string fsl,imx95-edma5. This patch adds the register definitions, the
private data structures, probe and remove handling, device-tree
dma-channel-mask parsing to skip channels reserved for other bus
masters, global clock and arbitration setup, and the device information
query. Subsequent patches add configuration, the data path, and
statistics.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>
---
 MAINTAINERS                              |   5 +
 doc/guides/dmadevs/imx_edma5.rst         |  60 +++++++
 doc/guides/dmadevs/index.rst             |   1 +
 doc/guides/rel_notes/release_26_11.rst   |   6 +
 drivers/dma/imx_edma5/imx_edma5_dmadev.c | 219 ++++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_dmadev.h | 220 +++++++++++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_hw.h     | 143 +++++++++++++++
 drivers/dma/imx_edma5/imx_edma5_logs.h   |  16 ++
 drivers/dma/imx_edma5/meson.build        |  10 ++
 drivers/dma/meson.build                  |   1 +
 10 files changed, 681 insertions(+)
 create mode 100644 doc/guides/dmadevs/imx_edma5.rst
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.c
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_dmadev.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_hw.h
 create mode 100644 drivers/dma/imx_edma5/imx_edma5_logs.h
 create mode 100644 drivers/dma/imx_edma5/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..b2645ebe2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1422,6 +1422,11 @@ M: Hemant Agrawal <hemant.agrawal@nxp.com>
 F: drivers/dma/dpaa2/
 F: doc/guides/dmadevs/dpaa2.rst
 
+NXP i.MX95 eDMA5
+M: Gagandeep Singh <g.singh@nxp.com>
+M: Prashant Gupta <prashant.gupta_3@nxp.com>
+F: drivers/dma/imx_edma5/
+F: doc/guides/dmadevs/imx_edma5.rst
 
 RegEx Drivers
 -------------
diff --git a/doc/guides/dmadevs/imx_edma5.rst b/doc/guides/dmadevs/imx_edma5.rst
new file mode 100644
index 0000000000..f57881816e
--- /dev/null
+++ b/doc/guides/dmadevs/imx_edma5.rst
@@ -0,0 +1,60 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright 2026 NXP
+
+NXP i.MX95 eDMA5 DMA Driver
+===========================
+
+The ``imx_edma5`` DMA driver is a poll-mode driver (PMD) for the NXP i.MX95
+Enhanced Direct Memory Access controller version 5 (eDMA5). It exposes each
+eDMA5 controller instance as a DPDK dmadev device and can be used through the
+generic DMA device (dmadev) API.
+
+The i.MX95 SoC integrates multiple eDMA instances. The eDMA5 instances provide
+64 hardware channels, 64-bit addressing and a 64-byte Transfer Control
+Descriptor (TCD64). This driver targets the eDMA5 instances only (device tree
+compatible ``fsl,imx95-edma5``).
+
+Supported Features
+------------------
+
+- Memory-to-memory copy (``RTE_DMA_DIR_MEM_TO_MEM``).
+- Single-operation copy (``rte_dma_copy``).
+- Scatter-gather copy (``rte_dma_copy_sg``).
+- Per virtual channel statistics.
+
+Each configured virtual channel (vchan) is mapped one-to-one onto a hardware
+eDMA5 channel. Software-initiated (SWSTART) single-block transfers are
+programmed into the per-channel TCD and completion is detected by polling the
+TCD DONE status.
+
+Prerequisites
+-------------
+
+The eDMA5 register window is memory-mapped into the userspace process through
+the DPDK platform bus using the Linux ``vfio-platform`` mechanism. The device
+tree node targeted by this driver must be released from the kernel ``fsl-edma``
+driver (its status set to ``disabled`` or the node unbound) before it can be
+used by DPDK.
+
+Bind the platform device to ``vfio-platform``, for example::
+
+   echo vfio-platform > /sys/bus/platform/devices/<node>/driver_override
+   echo <node> > /sys/bus/platform/drivers/vfio-platform/bind
+
+where ``<node>`` is the platform device name of the eDMA5 instance (for
+example ``42000000.dma-controller``).
+
+Compilation
+-----------
+
+The driver is built as part of the standard DPDK meson build on Linux targets.
+No extra configuration option is required.
+
+Limitations
+-----------
+
+- Only the memory-to-memory transfer direction is supported.
+- The scatter-gather path iterates the source and destination segment lists
+  independently and programs one hardware transfer per consumed segment;
+  full TCD scatter-gather linking is not yet implemented.
+- The driver operates in poll mode only; completion interrupts are not used.
diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
index 56beb1733f..47c52a9220 100644
--- a/doc/guides/dmadevs/index.rst
+++ b/doc/guides/dmadevs/index.rst
@@ -17,5 +17,6 @@ an application through DMA API.
    hisi_acc
    hisi_pciep
    idxd
+   imx_edma5
    ioat
    odm
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index a2c0267818..638e92ad8d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,12 @@ New Features
   kernel driver is the generic ``vfio-platform``, which carries no
   device identity in its name.
 
+* **Added NXP i.MX95 eDMA5 DMA driver.**
+
+  Added the ``imx_edma5`` DMA driver for the NXP i.MX95 eDMA5 controller.
+  The driver exposes each eDMA5 instance as a DPDK dmadev device and
+  supports memory-to-memory copy and scatter-gather copy operations.
+
 
 Removed Items
 -------------
diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.c b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
new file mode 100644
index 0000000000..f1c65a474a
--- /dev/null
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.c
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+/*
+ * NXP i.MX95 eDMA5 dmadev driver.
+ *
+ * Exposes an eDMA5 controller instance as a DPDK dmadev. Each configured
+ * virtual channel maps 1:1 onto a hardware eDMA5 channel. Memory-to-memory
+ * copy and scatter-gather copy are supported using software-initiated
+ * single-block transfers programmed through the per-channel 64-bit TCD.
+ *
+ * The device is bound to userspace through the platform bus (vfio-platform);
+ * the device tree node must be released from the kernel fsl-edma driver before
+ * it can be used here.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <bus_platform_driver.h>
+#include <rte_bitops.h>
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_cycles.h>
+#include <rte_dmadev_pmd.h>
+#include <rte_malloc.h>
+
+#include "imx_edma5_dmadev.h"
+
+#include "imx_edma5_logs.h"
+
+RTE_LOG_REGISTER_DEFAULT(imx_edma5_logtype, INFO);
+
+/* Compatible string for i.MX95 eDMA5 device tree nodes. */
+#define IMX_EDMA5_COMPAT		"fsl,imx95-edma5"
+
+/* sysfs base path for platform devices' device-tree nodes. */
+#define IMX_EDMA5_SYSFS_DEVICES		"/sys/bus/platform/devices"
+
+/*
+ * Read the device-tree "dma-channel-mask" property and return the combined
+ * 64-bit mask of reserved hardware channels. The property is a raw binary file
+ * of big-endian 32-bit cells: cell[0] covers channels 0-31, cell[1] channels
+ * 32-63. A set bit marks a channel owned by another bus master (e.g. SCMI
+ * firmware) that must not be accessed. Returns 0 if the property is absent.
+ */
+static uint64_t
+imx_edma5_read_channel_mask(const char *dev_name)
+{
+	char path[PATH_MAX];
+	uint32_t cells[2] = { 0, 0 };
+	uint64_t mask = 0;
+	size_t n;
+	FILE *f;
+
+	snprintf(path, sizeof(path),
+		 IMX_EDMA5_SYSFS_DEVICES "/%s/of_node/dma-channel-mask",
+		 dev_name);
+
+	f = fopen(path, "rb");
+	if (f == NULL)
+		return 0;
+
+	n = fread(cells, 1, sizeof(cells), f);
+	fclose(f);
+
+	/* Device-tree cells are big-endian regardless of CPU endianness. */
+	if (n >= sizeof(uint32_t))
+		mask |= rte_be_to_cpu_32(cells[0]);
+	if (n >= 2 * sizeof(uint32_t))
+		mask |= (uint64_t)rte_be_to_cpu_32(cells[1]) << 32;
+
+	return mask;
+}
+
+static int
+imx_edma5_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info,
+		   uint32_t info_sz)
+{
+	const struct imx_edma5_dev *ed = dev->data->dev_private;
+
+	RTE_SET_USED(info_sz);
+
+	dev_info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM |
+			     RTE_DMA_CAPA_OPS_COPY |
+			     RTE_DMA_CAPA_OPS_COPY_SG;
+	dev_info->max_vchans = ed->max_vchans;
+	dev_info->max_desc = IMX_EDMA5_MAX_DESC;
+	dev_info->min_desc = IMX_EDMA5_MIN_DESC;
+	dev_info->max_sges = IMX_EDMA5_MAX_SGES;
+
+	return 0;
+}
+
+static const struct rte_dma_dev_ops imx_edma5_ops = {
+	.dev_info_get	= imx_edma5_info_get,
+};
+
+static int
+imx_edma5_probe(struct rte_platform_device *pdev)
+{
+	struct rte_platform_resource *res;
+	struct imx_edma5_dev *ed;
+	struct rte_dma_dev *dev;
+	const char *name;
+
+	name = pdev->name;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		IMX_EDMA5_LOG(ERR, "Secondary process not supported for %s",
+			      name);
+		return -ENOTSUP;
+	}
+
+	if (pdev->num_resource < 1 || pdev->resource == NULL) {
+		IMX_EDMA5_LOG(ERR, "No MMIO resource for %s", name);
+		return -EINVAL;
+	}
+	res = &pdev->resource[0];
+	if (res->mem.addr == NULL) {
+		IMX_EDMA5_LOG(ERR, "MMIO resource not mapped for %s", name);
+		return -EINVAL;
+	}
+
+	dev = rte_dma_pmd_allocate(name, rte_socket_id(),
+				   sizeof(struct imx_edma5_dev));
+	if (dev == NULL) {
+		IMX_EDMA5_LOG(ERR, "Failed to allocate dmadev for %s", name);
+		return -ENOMEM;
+	}
+
+	dev->device = &pdev->device;
+	dev->dev_ops = &imx_edma5_ops;
+
+	ed = dev->data->dev_private;
+	ed->reg_base = res->mem.addr;
+	ed->reg_size = res->mem.len;
+	ed->dev_id = dev->data->dev_id;
+
+	/*
+	 * Build a map from usable vchan index to hardware channel index,
+	 * skipping channels reserved for other bus masters by the device-tree
+	 * "dma-channel-mask" (accessing them external-aborts).
+	 */
+	ed->masked_channels = imx_edma5_read_channel_mask(name);
+	ed->nb_channels = 0;
+	{
+		uint16_t hw;
+
+		for (hw = 0; hw < IMX_EDMA5_MAX_CHANNELS; hw++) {
+			if (ed->masked_channels & (RTE_BIT64(hw)))
+				continue;
+			ed->chan_map[ed->nb_channels++] = hw;
+		}
+	}
+	ed->max_vchans = ed->nb_channels;
+
+	if (ed->nb_channels == 0) {
+		IMX_EDMA5_LOG(ERR,
+			      "No usable eDMA5 channels for %s (mask 0x%" PRIx64 ")",
+			      name, ed->masked_channels);
+		rte_dma_pmd_release(name);
+		return -ENODEV;
+	}
+
+	dev->state = RTE_DMA_DEV_READY;
+
+	/*
+	 * Set MP_CSR.GCLC (Global Clock Control) before any per-channel register
+	 * is touched: the per-channel windows are individually clock-gated and
+	 * external-abort when accessed with GCLC clear. Also enable round-robin
+	 * arbitration (ERCA). Use read-modify-write to preserve reset defaults.
+	 */
+	{
+		uint32_t mp_csr = imx_edma5_read32(ed->reg_base, IMX_EDMA5_MP_CSR);
+
+		mp_csr |= IMX_EDMA5_MP_CSR_GCLC | IMX_EDMA5_MP_CSR_ERCA;
+		imx_edma5_write32(ed->reg_base, IMX_EDMA5_MP_CSR, mp_csr);
+	}
+
+	IMX_EDMA5_LOG(INFO, "Probed i.MX95 eDMA5 dmadev %s (%u channels)",
+		      name, ed->nb_channels);
+
+	return 0;
+}
+
+static int
+imx_edma5_remove(struct rte_platform_device *pdev)
+{
+	const char *name = pdev->name;
+
+	return rte_dma_pmd_release(name);
+}
+
+static struct rte_platform_driver imx_edma5_pmd_drv = {
+	/*
+	 * Set the DT compatible string as the driver alias. The platform bus
+	 * match logic compares this against the device-tree "compatible" sysfs
+	 * strings of each platform device when the kernel driver name (always
+	 * "vfio-platform") does not uniquely identify the device.
+	 */
+	.driver = {
+		.alias = IMX_EDMA5_COMPAT,
+	},
+	.probe = imx_edma5_probe,
+	.remove = imx_edma5_remove,
+	/*
+	 * The eDMA5 is programmed with the IOVA of the buffers, so it works in
+	 * both IOVA=VA and IOVA=PA modes; no IOVA-as-VA requirement is forced.
+	 */
+	.drv_flags = 0,
+};
+
+RTE_PMD_REGISTER_PLATFORM(dma_imx_edma5, imx_edma5_pmd_drv);
diff --git a/drivers/dma/imx_edma5/imx_edma5_dmadev.h b/drivers/dma/imx_edma5/imx_edma5_dmadev.h
new file mode 100644
index 0000000000..3da7957457
--- /dev/null
+++ b/drivers/dma/imx_edma5/imx_edma5_dmadev.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+#ifndef IMX_EDMA5_DMADEV_H
+#define IMX_EDMA5_DMADEV_H
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+#include <rte_byteorder.h>
+#include <rte_common.h>
+#include <rte_dmadev.h>
+#include <rte_io.h>
+#include <rte_memory.h>
+
+#include "imx_edma5_hw.h"
+
+/*
+ * CPU data-cache maintenance for the non-coherent eDMA5 master: clean the
+ * source before the transfer and clean+invalidate the destination after it.
+ * DC IVAC (invalidate-only) is EL1-only and faults from userspace, so DC CIVAC
+ * is used. No-ops on non-arm64 builds.
+ */
+static inline void
+imx_edma5_dcbf(void *p)
+{
+#ifdef RTE_ARCH_ARM64
+	asm volatile("dc cvac, %0" : : "r"(p) : "memory");
+#else
+	RTE_SET_USED(p);
+#endif
+}
+
+static inline void
+imx_edma5_dccivac(void *p)
+{
+#ifdef RTE_ARCH_ARM64
+	asm volatile("dc civac, %0" : : "r"(p) : "memory");
+#else
+	RTE_SET_USED(p);
+#endif
+}
+
+/* Clean a VA range to the Point of Coherency. */
+static inline void
+imx_edma5_cache_clean(void *addr, size_t len)
+{
+	uintptr_t p = (uintptr_t)addr & ~(uintptr_t)(RTE_CACHE_LINE_SIZE - 1);
+	uintptr_t end = (uintptr_t)addr + len;
+
+	for (; p < end; p += RTE_CACHE_LINE_SIZE)
+		imx_edma5_dcbf((void *)p);
+	/*
+	 * DSB ensures all DC CVAC instructions have completed to the Point of
+	 * Coherency before the eDMA5 is allowed to read the source data.
+	 */
+#ifdef RTE_ARCH_ARM64
+	asm volatile("dsb sy" ::: "memory");
+#endif
+}
+
+/* Clean+invalidate a VA range to the Point of Coherency. */
+static inline void
+imx_edma5_cache_inval(void *addr, size_t len)
+{
+	uintptr_t p = (uintptr_t)addr & ~(uintptr_t)(RTE_CACHE_LINE_SIZE - 1);
+	uintptr_t end = (uintptr_t)addr + len;
+
+	for (; p < end; p += RTE_CACHE_LINE_SIZE)
+		imx_edma5_dccivac((void *)p);
+	/*
+	 * DSB ensures all DC CIVAC instructions have completed to the Point of
+	 * Coherency before the CPU reads the destination data written by eDMA5.
+	 */
+#ifdef RTE_ARCH_ARM64
+	asm volatile("dsb sy" ::: "memory");
+#endif
+}
+
+/*
+ * NBYTES field maximum: bits 31:30 of TCD_NBYTES are SMLOE/DMLOE control bits
+ * when the minor loop offset feature is enabled. To avoid accidentally setting
+ * those bits, cap every single-block transfer at the 30-bit maximum count.
+ */
+#define IMX_EDMA5_MAX_NBYTES		((uint32_t)((1u << 30) - 1))
+
+/* Maximum scatter-gather segments per copy_sg request. */
+#define IMX_EDMA5_MAX_SGES		16
+
+/*
+ * In-memory TCD64 descriptors reserved per job slot for scatter-gather.
+ * Splitting an asymmetric src/dst segment list at the union of both sets of
+ * boundaries yields at most n_src + n_dst - 1 sub-transfers, so with up to
+ * IMX_EDMA5_MAX_SGES segments per side the worst case fits in this bound.
+ */
+#define IMX_EDMA5_SG_TCD_PER_JOB	(2 * IMX_EDMA5_MAX_SGES)
+
+/* Software job ring size per virtual channel (power of two). */
+#define IMX_EDMA5_MAX_DESC		4096
+#define IMX_EDMA5_MIN_DESC		32
+
+/* Per in-flight job bookkeeping. */
+struct imx_edma5_job {
+	uint16_t ridx;			/* ring index returned to application */
+	uint8_t  submitted;		/* job has been started on hardware */
+	uint8_t  done;			/* job completed */
+	uint8_t  error;			/* job completed with error */
+	/*
+	 * Destination VA and byte count of the copy, used to invalidate the
+	 * destination cache lines on completion (non-coherent eDMA master).
+	 * NULL if the VA could not be resolved. Unused for SG jobs (nb_sg > 0).
+	 */
+	void    *dst_va;
+	uint32_t len;
+	/*
+	 * Source/destination IOVAs of a plain single-block copy, recorded at
+	 * enqueue time and used to program the TCD at submit time (the eDMA5 has
+	 * a single register TCD shared by all jobs). Unused for SG jobs.
+	 */
+	rte_iova_t src_iova;
+	rte_iova_t dst_iova;
+	/*
+	 * Scatter-gather state. nb_sg is the segment count (0 for a plain copy);
+	 * sg_tcd points at this job's slice of the vchan's in-memory TCD pool.
+	 */
+	uint16_t nb_sg;
+	struct imx_edma5_hw_tcd64 *sg_tcd;
+};
+
+/* A virtual channel maps 1:1 onto a single eDMA5 hardware channel. */
+struct imx_edma5_vchan {
+	uint8_t  *ch_regs;		/* channel register window base */
+	uint8_t  *tcd_regs;		/* channel TCD base (ch_regs + TCD_OFF) */
+	uint32_t  hw_chan;		/* hardware channel index */
+
+	struct imx_edma5_job *jobs;	/* software job ring */
+	uint16_t nb_desc;		/* size of job ring (power of two) */
+	uint16_t desc_mask;		/* nb_desc - 1 */
+
+	/*
+	 * Pool of in-memory TCD64 descriptors for scatter-gather, sized
+	 * nb_desc * IMX_EDMA5_SG_TCD_PER_JOB. Each job slot owns a contiguous
+	 * slice of IMX_EDMA5_SG_TCD_PER_JOB descriptors. sg_tcd_iova is the
+	 * pool base IOVA.
+	 */
+	struct imx_edma5_hw_tcd64 *sg_tcd_pool;
+	rte_iova_t sg_tcd_iova;
+
+	uint16_t head;			/* next slot to enqueue */
+	uint16_t tail;			/* next slot to reap */
+	uint16_t nb_enqueued;		/* outstanding jobs in ring (unreaped) */
+	uint16_t ridx;			/* running ring index counter */
+	uint16_t last_idx;		/* last completed ring index */
+
+	uint64_t submitted_count;
+	uint64_t completed_count;
+	uint64_t errors_count;
+
+	bool configured;
+};
+
+/* Per-device (per eDMA5 instance) private data. */
+struct imx_edma5_dev {
+	uint8_t *reg_base;		/* mapped register window base */
+	uint64_t reg_size;		/* mapped register window length */
+
+	uint16_t nb_channels;		/* channels available on this instance */
+	uint16_t max_vchans;		/* channels usable as dmadev vchans */
+
+	/*
+	 * Bitmask of hardware channels reserved for other bus masters (from the
+	 * device-tree "dma-channel-mask"). A set bit marks a channel this driver
+	 * must not touch; accessing it faults with a bus external abort.
+	 */
+	uint64_t masked_channels;
+	/* Map of usable dmadev vchan index -> hardware channel index. */
+	uint16_t chan_map[IMX_EDMA5_MAX_CHANNELS];
+
+	struct imx_edma5_vchan *vchans;	/* array of vchan states */
+	uint16_t nb_vchans;		/* number of configured vchans */
+
+	int16_t dev_id;			/* dmadev id */
+};
+
+/* MMIO helpers (little-endian device). */
+static inline uint32_t
+imx_edma5_read32(const uint8_t *base, uint32_t off)
+{
+	return rte_le_to_cpu_32(rte_read32(base + off));
+}
+
+static inline void
+imx_edma5_write32(uint8_t *base, uint32_t off, uint32_t val)
+{
+	rte_write32(rte_cpu_to_le_32(val), base + off);
+}
+
+static inline uint16_t
+imx_edma5_read16(const uint8_t *base, uint32_t off)
+{
+	return rte_le_to_cpu_16(rte_read16(base + off));
+}
+
+static inline void
+imx_edma5_write16(uint8_t *base, uint32_t off, uint16_t val)
+{
+	rte_write16(rte_cpu_to_le_16(val), base + off);
+}
+
+static inline void
+imx_edma5_write64(uint8_t *base, uint32_t off, uint64_t val)
+{
+	/* Write the 64-bit field as two 32-bit accesses (order not significant). */
+	imx_edma5_write32(base, off, (uint32_t)(val & 0xFFFFFFFFu));
+	imx_edma5_write32(base, off + 4, (uint32_t)(val >> 32));
+}
+
+#endif /* IMX_EDMA5_DMADEV_H */
diff --git a/drivers/dma/imx_edma5/imx_edma5_hw.h b/drivers/dma/imx_edma5/imx_edma5_hw.h
new file mode 100644
index 0000000000..07c941cd13
--- /dev/null
+++ b/drivers/dma/imx_edma5/imx_edma5_hw.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+/*
+ * Hardware register definitions for the NXP i.MX95 eDMA5 controller.
+ * The block has a Management Page (MP) region followed by per-channel register
+ * windows (base offset 0x10000, stride 0x8000, 64 channels, 64-bit TCD64).
+ * All register accesses are little-endian.
+ */
+
+#ifndef IMX_EDMA5_HW_H
+#define IMX_EDMA5_HW_H
+
+#include <stdint.h>
+
+/* Number of DMA channels implemented on i.MX95 eDMA5. */
+#define IMX_EDMA5_MAX_CHANNELS		64
+
+/* Per-channel register window geometry. */
+#define IMX_EDMA5_CHAN_BASE_OFF		0x10000u
+#define IMX_EDMA5_CHAN_STRIDE		0x8000u
+
+/*
+ * Management Page (MP) registers (offsets from register window base).
+ * Only the fields used by this driver are documented here.
+ */
+#define IMX_EDMA5_MP_CSR		0x0000u	/* Management control */
+#define IMX_EDMA5_MP_ES			0x0004u	/* Management error status */
+#define IMX_EDMA5_MP_INT_LOW		0x0008u	/* Interrupt request (chan 0-31) */
+#define IMX_EDMA5_MP_INT_HIGH		0x000Cu	/* Interrupt request (chan 32-63) */
+#define IMX_EDMA5_MP_HRS_LOW		0x0010u	/* Hardware request status low */
+#define IMX_EDMA5_MP_HRS_HIGH		0x0014u	/* Hardware request status high */
+
+/* MP_CSR bit fields. */
+#define IMX_EDMA5_MP_CSR_EDBG		(1u << 1)  /* Enable debug */
+#define IMX_EDMA5_MP_CSR_ERCA		(1u << 2)  /* Enable round-robin arb */
+#define IMX_EDMA5_MP_CSR_HAE		(1u << 4)  /* Halt after error */
+#define IMX_EDMA5_MP_CSR_GCLC		(1u << 6)  /* Global clock control */
+#define IMX_EDMA5_MP_CSR_GMRC		(1u << 7)  /* Global master ID replic */
+
+/* MP_ES: valid bit indicates a logged error is present. */
+#define IMX_EDMA5_MP_ES_VLD		(1u << 31)
+
+/*
+ * Per-channel control registers (offsets from a channel window base).
+ * Layout matches the eDMA4/eDMA5 fsl_edma3_ch_reg structure.
+ */
+#define IMX_EDMA5_CH_CSR		0x00u	/* Channel control/status */
+#define IMX_EDMA5_CH_ES			0x04u	/* Channel error status */
+#define IMX_EDMA5_CH_INT		0x08u	/* Channel interrupt status */
+#define IMX_EDMA5_CH_SBR		0x0Cu	/* System bus register */
+#define IMX_EDMA5_CH_PRI		0x10u	/* Channel priority */
+#define IMX_EDMA5_CH_MUX		0x14u	/* Channel multiplexor (source) */
+#define IMX_EDMA5_CH_MATTR		0x18u	/* Memory attributes */
+
+/* Channel window offset of the TCD (Transfer Control Descriptor). */
+#define IMX_EDMA5_CH_TCD_OFF		0x20u
+
+/* CH_CSR bit fields. */
+#define IMX_EDMA5_CH_CSR_ERQ		(1u << 0)  /* Enable hardware request */
+#define IMX_EDMA5_CH_CSR_EARQ		(1u << 1)  /* Enable async hw request */
+#define IMX_EDMA5_CH_CSR_EEI		(1u << 2)  /* Enable error interrupt */
+#define IMX_EDMA5_CH_CSR_DONE		(1u << 30) /* Channel done (w1c) */
+#define IMX_EDMA5_CH_CSR_ACTIVE		(1u << 31) /* Channel active */
+
+/* CH_ES: valid bit indicates a logged channel error. */
+#define IMX_EDMA5_CH_ES_ERR		(1u << 31)
+
+/* CH_INT: write 1 to clear the channel interrupt request. */
+#define IMX_EDMA5_CH_INT_INT		(1u << 0)
+
+/* CH_SBR: read/write privileged/secure attributes for bus mastering. */
+#define IMX_EDMA5_CH_SBR_RD		(1u << 22)
+#define IMX_EDMA5_CH_SBR_WR		(1u << 21)
+
+/*
+ * TCD64 field offsets, relative to the channel TCD base
+ * (channel window base + IMX_EDMA5_CH_TCD_OFF).
+ */
+#define IMX_EDMA5_TCD_SADDR		0x00u
+#define IMX_EDMA5_TCD_SOFF		0x08u
+#define IMX_EDMA5_TCD_ATTR		0x0Au
+#define IMX_EDMA5_TCD_NBYTES		0x0Cu
+#define IMX_EDMA5_TCD_SLAST		0x10u
+#define IMX_EDMA5_TCD_DADDR		0x18u
+#define IMX_EDMA5_TCD_DLAST_SGA		0x20u
+#define IMX_EDMA5_TCD_DOFF		0x28u
+#define IMX_EDMA5_TCD_CITER		0x2Au
+#define IMX_EDMA5_TCD_CSR		0x2Cu
+#define IMX_EDMA5_TCD_BITER		0x2Eu
+
+/* TCD ATTR sub-fields: transfer size is encoded as log2(bytes). GET_* extract. */
+#define IMX_EDMA5_TCD_ATTR_DSIZE(x)	(((x) & 0x7u))
+#define IMX_EDMA5_TCD_ATTR_SSIZE(x)	(((x) & 0x7u) << 8)
+#define IMX_EDMA5_TCD_ATTR_GET_DSIZE(x)	((x) & 0x7u)
+#define IMX_EDMA5_TCD_ATTR_GET_SSIZE(x)	(((x) >> 8) & 0x7u)
+
+/* Transfer size encodings for ATTR SSIZE/DSIZE (log2 of bytes). */
+#define IMX_EDMA5_TCD_SIZE_1B		0u
+#define IMX_EDMA5_TCD_SIZE_2B		1u
+#define IMX_EDMA5_TCD_SIZE_4B		2u
+#define IMX_EDMA5_TCD_SIZE_8B		3u
+#define IMX_EDMA5_TCD_SIZE_16B		4u
+#define IMX_EDMA5_TCD_SIZE_32B		5u
+#define IMX_EDMA5_TCD_SIZE_64B		6u
+
+/* Major iteration count field mask (15-bit CITER/BITER). */
+#define IMX_EDMA5_TCD_ITER_MASK		0x7FFFu
+
+/* TCD CSR bit fields. */
+#define IMX_EDMA5_TCD_CSR_START		(1u << 0)  /* Software start */
+#define IMX_EDMA5_TCD_CSR_INT_MAJOR	(1u << 1)  /* Interrupt on major done */
+#define IMX_EDMA5_TCD_CSR_INT_HALF	(1u << 2)  /* Interrupt on half done */
+#define IMX_EDMA5_TCD_CSR_D_REQ		(1u << 3)  /* Disable request on done */
+#define IMX_EDMA5_TCD_CSR_E_SG		(1u << 4)  /* Enable scatter-gather */
+#define IMX_EDMA5_TCD_CSR_E_LINK	(1u << 5)  /* Enable channel linking */
+#define IMX_EDMA5_TCD_CSR_ACTIVE	(1u << 6)  /* Channel active */
+#define IMX_EDMA5_TCD_CSR_DONE		(1u << 7)  /* Channel done */
+
+/*
+ * In-memory 64-bit Transfer Control Descriptor. The field order and offsets
+ * match the register TCD64 layout above; all fields are little-endian. The
+ * descriptor must be 32-byte aligned and, on this non-coherent SoC, cleaned
+ * from the CPU cache before the transfer is started.
+ */
+struct __rte_aligned(32) imx_edma5_hw_tcd64 {
+	uint64_t saddr;		/* 0x00 source address */
+	uint16_t soff;		/* 0x08 source offset */
+	uint16_t attr;		/* 0x0A transfer attributes */
+	uint32_t nbytes;	/* 0x0C minor loop byte count */
+	uint64_t slast;		/* 0x10 last source adjustment */
+	uint64_t daddr;		/* 0x18 destination address */
+	uint64_t dlast_sga;	/* 0x20 next TCD address (scatter-gather) */
+	uint16_t doff;		/* 0x28 destination offset */
+	uint16_t citer;		/* 0x2A current major iteration count */
+	uint16_t csr;		/* 0x2C control and status */
+	uint16_t biter;		/* 0x2E starting major iteration count */
+	/* Pad to 64 bytes total; the type is 32-byte aligned for TCD fetches. */
+	uint8_t  reserved[16];
+};
+
+#endif /* IMX_EDMA5_HW_H */
diff --git a/drivers/dma/imx_edma5/imx_edma5_logs.h b/drivers/dma/imx_edma5/imx_edma5_logs.h
new file mode 100644
index 0000000000..e73e496bb4
--- /dev/null
+++ b/drivers/dma/imx_edma5/imx_edma5_logs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+#ifndef IMX_EDMA5_LOGS_H
+#define IMX_EDMA5_LOGS_H
+
+#include <rte_log.h>
+
+extern int imx_edma5_logtype;
+#define RTE_LOGTYPE_IMX_EDMA5 imx_edma5_logtype
+
+#define IMX_EDMA5_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, IMX_EDMA5, "%s(): ", __func__, __VA_ARGS__)
+
+#endif /* IMX_EDMA5_LOGS_H */
diff --git a/drivers/dma/imx_edma5/meson.build b/drivers/dma/imx_edma5/meson.build
new file mode 100644
index 0000000000..e4f5d4e0bb
--- /dev/null
+++ b/drivers/dma/imx_edma5/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2026 NXP
+
+if not is_linux
+    build = false
+    reason = 'only supported on linux'
+endif
+
+deps += ['dmadev', 'bus_platform']
+sources = files('imx_edma5_dmadev.c')
diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
index e0d94db967..dd00b1dae9 100644
--- a/drivers/dma/meson.build
+++ b/drivers/dma/meson.build
@@ -8,6 +8,7 @@ drivers = [
         'hisi_acc',
         'hisi_pciep',
         'idxd',
+        'imx_edma5',
         'ioat',
         'odm',
         'skeleton',
-- 
2.25.1

