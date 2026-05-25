Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8286DCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 18:43:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2CA940650;
	Mon, 25 May 2026 20:43:21 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by mails.dpdk.org (Postfix) with ESMTP id 095D640652
 for <dev@dpdk.org>; Mon, 25 May 2026 20:43:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EICJVjjjYE/Ziug29eDtmNang3ZaviM84CMFLQg+T8s+w/ttkFWMi5tItNe5Z6kC+WnYd4iZt+2QpJKr7VzIavZbwfjtPL1OCE1/sB56iTMsRHorxX3p7niSSvH1LNXFYd21jKB0tBSJfw4aLq4vVWPvWbfQCbIRjmFe5DA0fj10PpqaTH9pv6M6SoGyP2FKbwF/vsXUCXY+ERl3P479GZOm8+G0SVunxkN37dz8tkIaeLrAmTF1FJdlNd2p5qO90/1LpdhvtmaIa/Si/e+2+RH+N0NVD/2aPG7zTHRIZmNCGqWXWaVRt/FGVxg1/HWDqT+F7u9IPM9i31swXvSJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciFrHgYBXUnzJG94msHlHBl1c5BPEUQuw16bLFAiDuI=;
 b=dhufZpogX2QuaER/C4PchpJOwF2J/G2iNa828kf8mO+nVArBjhQTFXgy8jFrwz+wi4fJctjR9UfPg9H96RmvSJNm+3z4XtptortMToVGLtmpVhmx1A+NVKP44CcZRCiw/3oYpDS5wsBw/ghsBgvUCbi07HIadheNZ07FR3RcNyf/WqxPR/q0yjVnMamjFw1EOGlwmp9SVGf3jYHZk7uAAefqRitP+PoPbo4olEr9CBySmkxE/VXHE8HY9JDnrYpnTGWaKr4aBUZWzDhFyiaIp2y85r2+IGECPHbB/zXHccOevUv77mnSg5oFTZrNUcsBrVXox+4TlIB19hXowpFHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciFrHgYBXUnzJG94msHlHBl1c5BPEUQuw16bLFAiDuI=;
 b=0cyJz0UmQ9XjFlxqgK1QyCHnc7VuTzhs/sCIeOe/UQmEbdEUsMxNo6JI+mwy6al3ajvN2p1WzLZXx/8tj+wwXMgCtS2PVAYzVrthaqANoCb5YoCiScmpMsRyvesx8GMntTHstFzMHFdgVsMIFqNl48scRj25vnL/Yogt/prmsVY=
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 18:43:13 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::43) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 18:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 18:43:12 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 25 May
 2026 13:43:09 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, <david.marchand@redhat.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Date: Tue, 26 May 2026 00:12:42 +0530
Message-ID: <20260525184244.1758825-2-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
References: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
 <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c87e5e9-0cff-4a1a-1ff2-08deba8d798f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003|6133799003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: DEYsrJ3trwkgk6cOWV2KxsSO2ovRISfa0WTaj4dw8u2vrpzK0Sv0uF93mhaVgtgEvJ8y5N3tiTYdMUq1qUFsfSTbANbb2BPQhLJ+RXWuelXlSPZZeZosICuZ5mta0kKZ4tiYGZcRLSQe1CEzX+hvmLh1xP9QWDMUUIK/MPxH4vxWPe/ng9EfvlxNFeHTKqkAWv9u1qh+T1/3jJth+kgpOPFTm8uhNmQUyETx8ZvwmMTHFiKPydvuTy/1IFEGe+6tPMlAvC29LBT39h0yp6/e48UsjmjChaq7sijw7aPzek6FyXQhtXS8vTCi9Lu3wc26j8OnAA3kd4jy85SBloafnnl840JKJl0+DufapbHwhQfKWDzMIWSxLiyl2YXkJRU/4JeCHDmCPKk54k40NFXW3/CV/dmtsxqgEcY4gGTd7Pc+DhMLBsBfX4wsTVdmjducoDjNr/+DF4tYNbEXbD59P64kPyje54YU2vfrQYnEyEjoVjSkRIMeJT76SmRGpUhWvobtJgpM+tND1zrqtsgXhUXQLWDl+uaE684W76wxd7+oZnlvJpOVNURSOAi/JtWgovypmRSfWOZdFu6KmDJe8QNew9Nc92EogwRAlJjg+preY7bg98uGQtFW2S5u+3x/uRukkdNJG6jp0LW/w8VetpYoszPHV60Bsy3K+d2cvxAlpsPkF/8FVg+Vi83Wa53+t0c8jz6LQzwYlZzQ9qetuMv5SAsEkOSCUtDRRp6opPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003)(6133799003)(3023799007)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M1y9Xg0tchPucvviGR4CslG9A6KkuSOwkrprVMUeJ/lUKKlbRqMjr4lRbEtlYkelMZekGi7Vm0hGjW6X8Y94ysSXKg2w+hi7Ym9jfI3BZhYpisnzjX5YpjWLd083mrwe24DrgY2DRP/jexkRMw6Rh/kYISr0eOsSlJr59WXH2+Zgw9Erw0CuMKZ+vBIfY0oy5f/kCVmwbpXmjbCRnxckdalxQLcPjZE7mzh3kHUfGquTCc+AoeczfHomvowEc5QVFPcrHTKyHr40H2/TCvealwmaMokZwSyooOt6Fpp086g358hhKHBDgOynLFL8YNsim7RIS+gCX9lCjrelTAbY3ZfQ149W4KRBIis4E8dKXPhCvzQLByw7bp9RXoduGziTyMon3nHqNJNWDRFoqYTzoBfZNI1mAWQ2vtC5+JfxvGoxafH05X+lL/NsbE+qPqD1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 18:43:12.5022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c87e5e9-0cff-4a1a-1ff2-08deba8d798f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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

Add the skeleton of a new dmadev poll-mode driver for the AMD AE4DMA
hardware DMA engine, providing only PCI probe/remove and per-queue
hardware initialisation. An AE4DMA engine exposes 16 hardware command
queues, each with a 32-entry descriptor ring; the PMD maps each
hardware channel to its own dmadev with a single virtual channel,
so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
"<pci-bdf>-ch15".

This patch only registers the PCI driver, allocates the dmadev
objects, reserves the per-queue descriptor rings and programs the
hardware queue base addresses. Control and data path operations are
added in subsequent patches.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 .mailmap                               |   1 +
 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/ae4dma.rst          |  53 ++++++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 227 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 160 +++++++++++++++++
 drivers/dma/ae4dma/ae4dma_internal.h   | 118 +++++++++++++
 drivers/dma/ae4dma/meson.build         |   7 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 11 files changed, 584 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build

diff --git a/.mailmap b/.mailmap
index 89ba6ffccc..60180818f9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -203,6 +203,7 @@ Benoît Ganne <bganne@cisco.com>
 Bernard Iremonger <bernard.iremonger@intel.com>
 Bert van Leeuwen <bert.vanleeuwen@netronome.com>
 Bhagyada Modali <bhagyada.modali@amd.com>
+Raghavendra Ningoji <raghavendra.ningoji@amd.com>
 Bharat Mota <bharat.mota@broadcom.com> <bmota@vmware.com>
 Bhuvan Mital <bhuvan.mital@amd.com>
 Bibo Mao <maobibo@loongson.cn>
diff --git a/MAINTAINERS b/MAINTAINERS
index 9143d028bc..2e27af49f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1361,6 +1361,11 @@ F: doc/guides/compressdevs/features/zsda.ini
 DMAdev Drivers
 --------------
 
+AMD AE4DMA
+M: Bhagyada Modali <bhagyada.modali@amd.com>
+F: drivers/dma/ae4dma/
+F: doc/guides/dmadevs/ae4dma.rst
+
 Intel IDXD - EXPERIMENTAL
 M: Bruce Richardson <bruce.richardson@intel.com>
 M: Kevin Laatz <kevin.laatz@intel.com>
diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
new file mode 100644
index 0000000000..a85c1d92ca
--- /dev/null
+++ b/doc/guides/dmadevs/ae4dma.rst
@@ -0,0 +1,53 @@
+..  SPDX-License-Identifier: BSD-3-Clause
+    Copyright(c) 2025 Advanced Micro Devices, Inc.
+
+.. include:: <isonum.txt>
+
+AMD AE4DMA DMA Device Driver
+============================
+
+The ``ae4dma`` dmadev driver is a poll-mode driver (PMD) for the
+AMD AE4DMA hardware DMA engine. The engine exposes 16 independent
+hardware command queues, each with a ring of 32 descriptors. The PMD
+maps each hardware command queue to a separate DPDK dmadev with a
+single virtual channel, so a single PCI function appears as 16 dmadevs
+named ``<pci-bdf>-ch0`` through ``<pci-bdf>-ch15``.
+
+The driver supports memory-to-memory copy operations only.
+
+Hardware Requirements
+---------------------
+
+The ``dpdk-devbind.py`` script can be used to list AE4DMA devices on
+the system::
+
+   dpdk-devbind.py --status-dev dma
+
+AE4DMA devices appear with vendor ID ``0x1022`` and device ID
+``0x149b``.
+
+Compilation
+-----------
+
+The driver is built as part of the standard DPDK build on x86 platforms
+using ``meson`` and ``ninja``; no extra configuration is required.
+
+Device Setup
+------------
+
+The AE4DMA device must be bound to a DPDK-compatible kernel module such
+as ``vfio-pci`` before it can be used::
+
+   dpdk-devbind.py -b vfio-pci <pci-bdf>
+
+Initialization
+~~~~~~~~~~~~~~
+
+On probe the PMD performs the following steps for each PCI function:
+
+* Reads BAR0 and programs the common configuration register with the
+  number of hardware queues to enable (16).
+* For each hardware queue it allocates a 32-entry descriptor ring in
+  IOVA-contiguous memory, programs the queue base address and ring
+  depth into the per-queue registers, and enables the queue.
+* Interrupts are masked; completion is polled by the application.
diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
index 56beb1733f..97399590f6 100644
--- a/doc/guides/dmadevs/index.rst
+++ b/doc/guides/dmadevs/index.rst
@@ -11,6 +11,7 @@ an application through DMA API.
    :maxdepth: 1
    :numbered:
 
+   ae4dma
    cnxk
    dpaa
    dpaa2
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index f012d47a4b..9a78a7ef62 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -63,6 +63,13 @@ New Features
     ``rte_eal_init`` and the application is responsible for probing each device,
   * ``--auto-probing`` enables the initial bus probing, which is the current default behavior.
 
+* **Added AMD AE4DMA DMA PMD.**
+
+  Added a new ``dma/ae4dma`` driver for the AMD AE4DMA hardware DMA engine.
+  Each PCI function exposes 16 hardware command queues; the PMD registers one
+  dmadev per channel with a single virtual channel and supports
+  memory-to-memory copy operations.
+
 
 Removed Items
 -------------
diff --git a/drivers/dma/ae4dma/ae4dma_dmadev.c b/drivers/dma/ae4dma/ae4dma_dmadev.c
new file mode 100644
index 0000000000..76de2cde45
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -0,0 +1,227 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <errno.h>
+#include <inttypes.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_bus_pci.h>
+#include <bus_pci_driver.h>
+#include <rte_dmadev_pmd.h>
+#include <rte_malloc.h>
+
+#include "ae4dma_internal.h"
+
+/*
+ * One dmadev per AE4DMA hardware channel; each dmadev has exactly one
+ * virtual channel. The HW's per-queue register block must be densely
+ * packed right after the engine-common config register at BAR0+0; the
+ * build-time check below catches an accidental layout change.
+ */
+static_assert(sizeof(struct ae4dma_hwq_regs) == 32,
+		"ae4dma_hwq_regs stride changed; per-queue offset math will break");
+
+RTE_LOG_REGISTER_DEFAULT(ae4dma_pmd_logtype, INFO);
+
+#define AE4DMA_PMD_NAME dmadev_ae4dma
+
+static const struct rte_memzone *
+ae4dma_queue_dma_zone_reserve(const char *queue_name,
+		uint32_t queue_size, int socket_id)
+{
+	const struct rte_memzone *mz;
+
+	mz = rte_memzone_lookup(queue_name);
+	if (mz != NULL) {
+		if (((size_t)queue_size <= mz->len) &&
+				((socket_id == SOCKET_ID_ANY) ||
+				 (socket_id == mz->socket_id))) {
+			AE4DMA_PMD_INFO("reuse memzone already "
+					"allocated for %s", queue_name);
+			return mz;
+		}
+		AE4DMA_PMD_ERR("Incompatible memzone already "
+				"allocated %s, size %u, socket %d. "
+				"Requested size %u, socket %u",
+				queue_name, (uint32_t)mz->len,
+				mz->socket_id, queue_size, socket_id);
+		return NULL;
+	}
+	return rte_memzone_reserve_aligned(queue_name, queue_size,
+			socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
+}
+
+static int
+ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn, const char *pci_name)
+{
+	uint32_t dma_addr_lo, dma_addr_hi;
+	struct ae4dma_cmd_queue *cmd_q;
+	const struct rte_memzone *q_mz;
+
+	dev->io_regs = dev->pci->mem_resource[AE4DMA_PCIE_BAR].addr;
+
+	cmd_q = &dev->cmd_q;
+	cmd_q->id = qn;
+	cmd_q->qidx = 0;
+	cmd_q->qsize = AE4DMA_QUEUE_SIZE(AE4DMA_QUEUE_DESC_SIZE);
+	cmd_q->hwq_regs = (volatile struct ae4dma_hwq_regs *)dev->io_regs + (qn + 1);
+
+	/*
+	 * Memzone name must be globally unique. Embed PCI BDF so multiple
+	 * PCI functions probed concurrently don't collide.
+	 */
+	snprintf(cmd_q->memz_name, sizeof(cmd_q->memz_name),
+			"ae4dma_%s_q%u", pci_name, (unsigned int)qn);
+
+	q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
+			cmd_q->qsize, rte_socket_id());
+	if (q_mz == NULL) {
+		AE4DMA_PMD_ERR("memzone reserve failed for %s", cmd_q->memz_name);
+		return -ENOMEM;
+	}
+
+	cmd_q->qbase_addr = (void *)q_mz->addr;
+	cmd_q->qbase_desc = (struct ae4dma_desc *)q_mz->addr;
+	cmd_q->qbase_phys_addr = q_mz->iova;
+
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, AE4DMA_DESCRIPTORS_PER_CMDQ);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+			AE4DMA_CMD_QUEUE_ENABLE);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->intr_status_reg.intr_status_raw,
+			AE4DMA_DISABLE_INTR);
+	cmd_q->next_write = (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
+	cmd_q->next_read = (uint16_t)AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
+	cmd_q->ring_buff_count = 0;
+
+	dma_addr_lo = low32_value(cmd_q->qbase_phys_addr);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_lo, dma_addr_lo);
+	dma_addr_hi = high32_value(cmd_q->qbase_phys_addr);
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->qbase_hi, dma_addr_hi);
+
+	return 0;
+}
+
+static void
+ae4dma_channel_dev_name(char *out, size_t outlen, const char *pci_name,
+		unsigned int ch)
+{
+	snprintf(out, outlen, "%s-ch%u", pci_name, ch);
+}
+
+/* Create a dmadev(dpdk DMA device) */
+static int
+ae4dma_dmadev_create(const char *name, struct rte_pci_device *dev, uint8_t qn)
+{
+	struct rte_dma_dev *dmadev = NULL;
+	struct ae4dma_dmadev *ae4dma = NULL;
+	char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
+
+	if (!name) {
+		AE4DMA_PMD_ERR("Invalid name of the device!");
+		return -EINVAL;
+	}
+	memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
+	ae4dma_channel_dev_name(hwq_dev_name, sizeof(hwq_dev_name), name, qn);
+
+	dmadev = rte_dma_pmd_allocate(hwq_dev_name, dev->device.numa_node,
+			sizeof(struct ae4dma_dmadev));
+	if (dmadev == NULL) {
+		AE4DMA_PMD_ERR("Unable to allocate dma device");
+		return -ENOMEM;
+	}
+	dmadev->device = &dev->device;
+	dmadev->fp_obj->dev_private = dmadev->data->dev_private;
+
+	ae4dma = dmadev->data->dev_private;
+	ae4dma->dmadev = dmadev;
+	ae4dma->pci = dev;
+
+	if (ae4dma_add_queue(ae4dma, qn, name) != 0)
+		goto init_error;
+	return 0;
+
+init_error:
+	AE4DMA_PMD_ERR("driver %s(): failed", __func__);
+	rte_dma_pmd_release(hwq_dev_name);
+	return -ENOMEM;
+}
+
+/* Probe DMA device. */
+static int
+ae4dma_dmadev_probe(struct rte_pci_driver *drv, struct rte_pci_device *dev)
+{
+	char name[32];
+	char chname[RTE_DEV_NAME_MAX_LEN];
+	void *mmio_base;
+	uint32_t q_per_eng;
+	int ret = 0;
+	uint8_t i;
+
+	rte_pci_device_name(&dev->addr, name, sizeof(name));
+	AE4DMA_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
+	dev->device.driver = &drv->driver;
+
+	mmio_base = dev->mem_resource[AE4DMA_PCIE_BAR].addr;
+	if (mmio_base == NULL) {
+		AE4DMA_PMD_ERR("%s: BAR%d not mapped", name, AE4DMA_PCIE_BAR);
+		return -ENODEV;
+	}
+
+	/* Program the per-engine HW queue count once. */
+	AE4DMA_WRITE_REG_OFFSET(mmio_base, AE4DMA_COMMON_CONFIG_OFFSET,
+			AE4DMA_MAX_HW_QUEUES);
+	q_per_eng = AE4DMA_READ_REG_OFFSET(mmio_base, AE4DMA_COMMON_CONFIG_OFFSET);
+	AE4DMA_PMD_INFO("%s: AE4DMA queues per engine = %u", name, q_per_eng);
+
+	for (i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
+		ret = ae4dma_dmadev_create(name, dev, i);
+		if (ret != 0) {
+			AE4DMA_PMD_ERR("%s create dmadev %u failed!", name, i);
+			while (i > 0) {
+				i--;
+				ae4dma_channel_dev_name(chname, sizeof(chname), name, i);
+				rte_dma_pmd_release(chname);
+			}
+			break;
+		}
+	}
+	return ret;
+}
+
+/* Remove DMA device. */
+static int
+ae4dma_dmadev_remove(struct rte_pci_device *dev)
+{
+	char name[32];
+	char chname[RTE_DEV_NAME_MAX_LEN];
+	unsigned int i;
+
+	rte_pci_device_name(&dev->addr, name, sizeof(name));
+
+	AE4DMA_PMD_INFO("Closing %s on NUMA node %d",
+			name, dev->device.numa_node);
+
+	for (i = 0; i < AE4DMA_MAX_HW_QUEUES; i++) {
+		ae4dma_channel_dev_name(chname, sizeof(chname), name, i);
+		rte_dma_pmd_release(chname);
+	}
+	return 0;
+}
+
+static const struct rte_pci_id pci_id_ae4dma_map[] = {
+	{ RTE_PCI_DEVICE(AMD_VENDOR_ID, AE4DMA_DEVICE_ID) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+static struct rte_pci_driver ae4dma_pmd_drv = {
+	.id_table = pci_id_ae4dma_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = ae4dma_dmadev_probe,
+	.remove = ae4dma_dmadev_remove,
+};
+
+RTE_PMD_REGISTER_PCI(AE4DMA_PMD_NAME, ae4dma_pmd_drv);
+RTE_PMD_REGISTER_PCI_TABLE(AE4DMA_PMD_NAME, pci_id_ae4dma_map);
+RTE_PMD_REGISTER_KMOD_DEP(AE4DMA_PMD_NAME, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/dma/ae4dma/ae4dma_hw_defs.h b/drivers/dma/ae4dma/ae4dma_hw_defs.h
new file mode 100644
index 0000000000..62b6a1b30b
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __AE4DMA_HW_DEFS_H__
+#define __AE4DMA_HW_DEFS_H__
+
+#include <rte_bus_pci.h>
+#include <rte_byteorder.h>
+#include <rte_io.h>
+#include <rte_pci.h>
+#include <rte_memzone.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define AE4DMA_BIT(nr)			(1UL << (nr))
+
+/* ae4dma device details */
+#define AMD_VENDOR_ID	0x1022
+#define AE4DMA_DEVICE_ID	0x149b
+#define AE4DMA_PCIE_BAR 0
+
+/*
+ * An AE4DMA engine has 16 DMA queues. Each queue supports 32 descriptors.
+ */
+#define AE4DMA_MAX_HW_QUEUES        16
+#define AE4DMA_QUEUE_START_INDEX    0
+#define AE4DMA_CMD_QUEUE_ENABLE		0x1
+#define AE4DMA_CMD_QUEUE_DISABLE	0x0
+
+/* Common to all queues */
+#define AE4DMA_COMMON_CONFIG_OFFSET 0x00
+
+#define AE4DMA_DISABLE_INTR 0x01
+
+/* Descriptor status */
+enum ae4dma_dma_status {
+	AE4DMA_DMA_DESC_SUBMITTED = 0,
+	AE4DMA_DMA_DESC_VALIDATED = 1,
+	AE4DMA_DMA_DESC_PROCESSED = 2,
+	AE4DMA_DMA_DESC_COMPLETED = 3,
+	AE4DMA_DMA_DESC_ERROR = 4,
+};
+
+/* Descriptor error-code */
+enum ae4dma_dma_err {
+	AE4DMA_DMA_ERR_NO_ERR = 0,
+	AE4DMA_DMA_ERR_INV_HEADER = 1,
+	AE4DMA_DMA_ERR_INV_STATUS = 2,
+	AE4DMA_DMA_ERR_INV_LEN = 3,
+	AE4DMA_DMA_ERR_INV_SRC = 4,
+	AE4DMA_DMA_ERR_INV_DST = 5,
+	AE4DMA_DMA_ERR_INV_ALIGN = 6,
+	AE4DMA_DMA_ERR_UNKNOWN = 7,
+};
+
+/* HW Queue status */
+enum ae4dma_hwqueue_status {
+	AE4DMA_HWQUEUE_EMPTY = 0,
+	AE4DMA_HWQUEUE_FULL = 1,
+	AE4DMA_HWQUEUE_NOT_EMPTY = 4
+};
+/*
+ * descriptor for AE4DMA commands
+ * 8 32-bit words:
+ * word 0: source memory type; destination memory type ; control bits
+ * word 1: desc_id; error code; status
+ * word 2: length
+ * word 3: reserved
+ * word 4: upper 32 bits of source pointer
+ * word 5: low 32 bits of source pointer
+ * word 6: upper 32 bits of destination pointer
+ * word 7: low 32 bits of destination pointer
+ */
+
+/* AE4DMA Descriptor - DWORD0 - Controls bits: Reserved for future use */
+#define AE4DMA_DWORD0_STOP_ON_COMPLETION	AE4DMA_BIT(0)
+#define AE4DMA_DWORD0_INTERRUPT_ON_COMPLETION	AE4DMA_BIT(1)
+#define AE4DMA_DWORD0_START_OF_MESSAGE		AE4DMA_BIT(3)
+#define AE4DMA_DWORD0_END_OF_MESSAGE		AE4DMA_BIT(4)
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE	RTE_GENMASK64(5, 4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE	RTE_GENMASK64(7, 6)
+
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_MEMORY    (0x0)
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE_IOMEMORY  (1<<4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_MEMORY    (0x0)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE_IOMEMORY  (1<<6)
+
+struct ae4dma_desc_dword0 {
+	uint8_t byte0;
+	uint8_t byte1;
+	uint16_t timestamp;
+};
+
+struct ae4dma_desc_dword1 {
+	uint8_t status;
+	uint8_t err_code;
+	uint16_t desc_id;
+};
+
+struct ae4dma_desc {
+	struct ae4dma_desc_dword0 dw0;
+	struct ae4dma_desc_dword1 dw1;
+	uint32_t length;
+	uint32_t reserved;
+	uint32_t src_lo;
+	uint32_t src_hi;
+	uint32_t dst_lo;
+	uint32_t dst_hi;
+};
+
+/*
+ * Registers for each queue :4 bytes length
+ * Effective address : offset + reg
+ */
+struct ae4dma_hwq_regs {
+	union {
+		uint32_t control_raw;
+		struct {
+			uint32_t queue_enable: 1;
+			uint32_t reserved_internal: 31;
+		} control;
+	} control_reg;
+
+	union {
+		uint32_t status_raw;
+		struct {
+			uint32_t reserved0: 1;
+			/* 0–empty, 1–full, 2–stopped, 3–error , 4–Not Empty */
+			uint32_t queue_status: 2;
+			uint32_t reserved1: 21;
+			uint32_t interrupt_type: 4;
+			uint32_t reserved2: 4;
+		} status;
+	} status_reg;
+
+	uint32_t max_idx;
+	uint32_t read_idx;
+	uint32_t write_idx;
+
+	union {
+		uint32_t intr_status_raw;
+		struct {
+			uint32_t intr_status: 1;
+			uint32_t reserved: 31;
+		} intr_status;
+	} intr_status_reg;
+
+	uint32_t qbase_lo;
+	uint32_t qbase_hi;
+
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* AE4DMA_HW_DEFS_H */
diff --git a/drivers/dma/ae4dma/ae4dma_internal.h b/drivers/dma/ae4dma/ae4dma_internal.h
new file mode 100644
index 0000000000..9892d6697f
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_internal.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef _AE4DMA_INTERNAL_H_
+#define _AE4DMA_INTERNAL_H_
+
+#include <stdint.h>
+
+#include "ae4dma_hw_defs.h"
+
+/**
+ * upper_32_bits - return bits 32-63 of a number
+ * @n: the number we're accessing
+ */
+#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
+
+/**
+ * lower_32_bits - return bits 0-31 of a number
+ * @n: the number we're accessing
+ */
+#define lower_32_bits(n) ((uint32_t)((n) & 0xffffffff))
+
+/** Hardware ring depth (slots per queue); must be power of two. */
+#define AE4DMA_DESCRIPTORS_PER_CMDQ	32
+#define AE4DMA_QUEUE_DESC_SIZE		sizeof(struct ae4dma_desc)
+#define AE4DMA_QUEUE_SIZE(n)		(AE4DMA_DESCRIPTORS_PER_CMDQ * (n))
+
+
+/** AE4DMA registers Write/Read */
+static inline void ae4dma_pci_reg_write(void *base, int offset,
+		uint32_t value)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
+
+	rte_write32((rte_cpu_to_le_32(value)), reg_addr);
+}
+
+static inline uint32_t ae4dma_pci_reg_read(void *base, int offset)
+{
+	volatile void *reg_addr = ((uint8_t *)base + offset);
+
+	return rte_le_to_cpu_32(rte_read32(reg_addr));
+}
+
+#define AE4DMA_READ_REG_OFFSET(hw_addr, reg_offset) \
+	ae4dma_pci_reg_read(hw_addr, reg_offset)
+
+#define AE4DMA_WRITE_REG_OFFSET(hw_addr, reg_offset, value) \
+	ae4dma_pci_reg_write(hw_addr, reg_offset, value)
+
+
+#define AE4DMA_READ_REG(hw_addr) \
+	ae4dma_pci_reg_read((void *)(uintptr_t)(hw_addr), 0)
+
+#define AE4DMA_WRITE_REG(hw_addr, value) \
+	ae4dma_pci_reg_write((void *)(uintptr_t)(hw_addr), 0, value)
+
+static inline uint32_t
+low32_value(unsigned long addr)
+{
+	return ((uint64_t)addr) & 0xffffffffUL;
+}
+
+static inline uint32_t
+high32_value(unsigned long addr)
+{
+	return (uint32_t)(((uint64_t)addr) >> 32);
+}
+
+/**
+ * A structure describing a AE4DMA command queue.
+ */
+struct __rte_cache_aligned ae4dma_cmd_queue {
+	char memz_name[RTE_MEMZONE_NAMESIZE];
+	volatile struct ae4dma_hwq_regs *hwq_regs;
+
+	struct rte_dma_vchan_conf qcfg;
+	struct rte_dma_stats stats;
+	/* Queue address */
+	struct ae4dma_desc *qbase_desc;
+	void *qbase_addr;
+	rte_iova_t qbase_phys_addr;
+	enum ae4dma_dma_err status[AE4DMA_DESCRIPTORS_PER_CMDQ];
+	/* Queue identifier */
+	uint64_t id;    /**< queue id */
+	uint64_t qidx;  /**< queue index */
+	uint64_t qsize; /**< queue size */
+	uint32_t ring_buff_count;
+	unsigned short next_read;
+	unsigned short next_write;
+	unsigned short last_write; /* Used to compute submitted count. */
+};
+
+/*
+ * One dmadev per AE4DMA hardware channel: probe creates AE4DMA_MAX_HW_QUEUES
+ * dmadevs per PCI function, each owning a single HW command queue.
+ */
+struct ae4dma_dmadev {
+	struct rte_dma_dev *dmadev;
+	void *io_regs;
+	struct ae4dma_cmd_queue cmd_q; /**< single HW queue owned by this dmadev */
+	struct rte_pci_device *pci;    /**< owning PCI device (not owned) */
+};
+
+
+extern int ae4dma_pmd_logtype;
+#define RTE_LOGTYPE_AE4DMA_PMD ae4dma_pmd_logtype
+
+#define AE4DMA_PMD_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, AE4DMA_PMD, "%s(): ", __func__, __VA_ARGS__)
+
+#define AE4DMA_PMD_DEBUG(...)  AE4DMA_PMD_LOG(DEBUG, __VA_ARGS__)
+#define AE4DMA_PMD_INFO(...)   AE4DMA_PMD_LOG(INFO, __VA_ARGS__)
+#define AE4DMA_PMD_ERR(...)    AE4DMA_PMD_LOG(ERR, __VA_ARGS__)
+#define AE4DMA_PMD_WARN(...)   AE4DMA_PMD_LOG(WARNING, __VA_ARGS__)
+
+#endif /* _AE4DMA_INTERNAL_H_ */
diff --git a/drivers/dma/ae4dma/meson.build b/drivers/dma/ae4dma/meson.build
new file mode 100644
index 0000000000..e48ab0d561
--- /dev/null
+++ b/drivers/dma/ae4dma/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
+
+build = dpdk_conf.has('RTE_ARCH_X86')
+reason = 'only supported on x86'
+sources = files('ae4dma_dmadev.c')
+deps += ['bus_pci', 'dmadev']
diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
index e0d94db967..c230ac5a06 100644
--- a/drivers/dma/meson.build
+++ b/drivers/dma/meson.build
@@ -2,6 +2,7 @@
 # Copyright 2021 HiSilicon Limited
 
 drivers = [
+        'ae4dma',
         'cnxk',
         'dpaa',
         'dpaa2',
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 93f2383dff..7d09f155de 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -86,6 +86,9 @@
 cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
             'SVendor': None, 'SDevice': None}
 
+amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
+              'SVendor': None, 'SDevice': None}
+
 virtio_blk = {'Class': '01', 'Vendor': "1af4", 'Device': '1001,1042',
               'SVendor': None, 'SDevice': None}
 
@@ -95,7 +98,7 @@
 network_devices = [network_class, cavium_pkx, avp_vnic, ifpga_class]
 baseband_devices = [acceleration_class]
 crypto_devices = [encryption_class, intel_processor_class]
-dma_devices = [cnxk_dma, hisilicon_dma,
+dma_devices = [amd_ae4dma, cnxk_dma, hisilicon_dma,
                intel_idxd_gnrd, intel_idxd_dmr, intel_idxd_spr,
                intel_ioat_bdw, intel_ioat_icx, intel_ioat_skx,
                odm_dma]
-- 
2.34.1

