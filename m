Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17840CD4F50
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 May 2026 18:19:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A789402D9;
	Mon, 18 May 2026 20:19:23 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
 by mails.dpdk.org (Postfix) with ESMTP id 8DA2840041
 for <dev@dpdk.org>; Mon, 18 May 2026 20:19:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kW63XNYgwb7x8jCbsBm3rsk+5SqPe661UWosIVJVmXx6XC7qWdyDjM5BcyvWb70zvhk2feRAgW/e5ciN5CDSdyM7eGS/9b4Yxlf0XHIGI1wf4Tce+LGQuVrug8qlt3ZqDM2AdO0br7Y3Lp+8qyHEtu44Rm9HMW9dTZkCChrU+SOSO+1qwwUjt9zOoiW80VGIG46PtFDpcPj2GatMaExZvJZBK1ahkOt4ViKcSEeEkrxrj+NYlAlV++SvbiWLg1lLOqgjK6wVb7X6PwxX8svhplHViYbmu7EEgsZqBkSXnwOr7I5bpu7/y620BrKX/RPtmtEAneOX1vbYwsUoQhKzoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSCO4iGj8uO3BYY+sCDriYmFF9DMliQjlQnM/uohNpY=;
 b=cEvyEZBrMgfWaywnuGxIjGN4AHEknYvoxmIdxTW5PyHdcCsWApGHlr2+LrMSa1g+8LobK4Nx9llinClhYQQv9yGX78E6ZBjvIy+vVBMrML8LXjv5slk6DchWpN3YsRNNIiikRqrEouygtT7Ri1nbuv/22AcVjwRySz9aQnYRO4vf49Xx5u3ABGA2Azh0QtXoct9dQUMJuwz7uHI2dQOnGQ93oDLBDE6QqhPUiRBkkxeCOWzos5SJ0WPg9kGMouafsn3cjGxUBxRwkGIRA51S8YeDrqLTxYXqZp8GlKUo2l8BGHE+V7jL5tNZ/PfP9S4Qau6erEBlOrMNMIF0RUqhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSCO4iGj8uO3BYY+sCDriYmFF9DMliQjlQnM/uohNpY=;
 b=iTt/8BacN4FQcblei1izTWhJ94KfSdNoesLMWiXxB0ddy2+4jw9KbskV8XJXuNR9lgALIY+HxUnWIfp2Lj8DLxr1o5VxYQWDgj0R/cUY0bSyV+Q97ojwaeTvg2fnW/vR6bL933GOhvubJrAY7/7DSSuvoItpzBOMAroy54TlQug=
Received: from BN9PR03CA0799.namprd03.prod.outlook.com (2603:10b6:408:13f::24)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 18:19:16 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::8f) by BN9PR03CA0799.outlook.office365.com
 (2603:10b6:408:13f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 18:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Mon, 18 May 2026 18:19:15 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 13:19:13 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <rjarry@redhat.com>, <Bhagyada.Modali@amd.com>,
 <Selwin.Sebastian@amd.com>, Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH] dma/ae4dma: add AMD AE4DMA DMA PMD
Date: Mon, 18 May 2026 23:48:56 +0530
Message-ID: <20260518181856.1228373-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|CYYPR12MB8891:EE_
X-MS-Office365-Filtering-Correlation-Id: b357ce44-c287-41d3-0497-08deb509f854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|3023799003|11063799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: uPUB5bpNq0bxONB4piyQ4MxMyDe7m9D4cmwXexxv46d56RFi/7hsP9z/eSb5bv11xhJenHLON1+U9XwyOhHbMowhPNvaabdp/EP31PEhX97yhvjE7u2PBLCDW+t/+B9+NnvGOjOr/g1+m4AZCVYXIVs1jxjK1Ss0ew0CFy6bhq72mD/UFUjvFiVUsCMzp8vvJde3HQ83R8bEUgkpLaTKnnDEswGuPaWVu42dlKsB+lExwY18Aehpqvhyixba4jwnOlduPZApNJiDW/OZLqS4HS0IoSxjDLREa78eEjoMPZd02aW6aNInRVTWlg+2I2wnJ0O2BmPmvAMhy8rVXWQo/1Yv9PFH8bRk7ildRy6L7l9lKrBNBzyDiwVxMlwC10eksSElTPnqnZKama/LF6ax5901w2evjxjmvB5wVEswH72R6+fiov/UCs+oNhoU+zbBjpbYfGu3OwavUzLjqfxkMp6dHB60+clY70xa6pvwGEVPkBbWfnQ1CpACczdqGJhU7W6pjKIl0P+onS5HZxbrMnshA+tjk9Gn0aUI1w8CYmungD+SVL6O/kp9ik6UDV+KnS16+hOsMldY83b9hyJf0MJBC4j8xhh4MsNw9KEr5hTdM1UJq7Mj8peW+nUvDKkF9re0XFTjBQMd1ZvdjuuMfIiCwb+tTm66POb5uMaJwz7UJzWhwDgRNQkd81t2hqtQro956dMnoE5vUXfkg4yQ65NTdA3RSFEaYLOS77EDiz0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(3023799003)(11063799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7Px0DoOjMv1WGV4I7A5aQUBIrDIqr8iKov4b1ZvpB/q+Z2uAGlHzLNLvZjiUI/+I1WA40UlE2mPzKHmBsFe5tBVAOWxlL3eaTmeulDiLAU8mIX7KfG3mr24KK3o2/DEYR4ItW7lIRil2UzQpyM/pb8yXFv4nxhggHSmHwaIU61POKWUYUQG5gYxVCqrHyVabQ8ZlDlRw9i6nM92OEfDOn2wHqGWey0JbkX8vfTJypSVJYgxHbW/LpKobwi7G7BdOO7VmViP92bh0140+QSl+yhsFADgjMQNQoWun+q7Gv7GUAjcoLd5LwiA4yW0nMVolrCfBNgVKuRmoEH/XUfk2VcErIetFWRfWT0XkRA0wHWZE6FfMA6cCUXpkrK2xUbyh+bEfBC0UStvM/vanDrnXXIuQL8sF7rpJ0niaE4NWkqtQjAmiBapVF6aGJJDaS4MS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:19:15.8359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b357ce44-c287-41d3-0497-08deb509f854
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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

Add a new dmadev poll-mode driver for the AMD AE4DMA hardware DMA
engine.  An AE4DMA engine exposes 16 hardware command queues, each
with a 32-entry descriptor ring; the PMD maps each hardware channel
to its own dmadev with a single virtual channel, so a PCI function
appears as 16 dmadevs named "<pci-bdf>-ch0" .. "<pci-bdf>-ch15".

Driver characteristics:

 - Memory-to-memory copy operations only (RTE_DMA_CAPA_MEM_TO_MEM).
 - Completion is detected via the hardware's per-queue read_idx
   register, which the engine advances as it processes descriptors.
   The descriptor status / err_code bytes are read only to classify
   each drained slot as success or failure.
 - vchan_status reports IDLE/ACTIVE based on HW read_idx vs write_idx
   and HALTED_ERROR when the queue is not enabled.
 - depends on bus_pci and dmadev.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/ae4dma.rst          |  75 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 742 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 164 ++++++
 drivers/dma/ae4dma/ae4dma_internal.h   | 117 ++++
 drivers/dma/ae4dma/meson.build         |   7 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 10 files changed, 1123 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index 9143d028bc..0b5a6e08d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1361,6 +1361,11 @@ F: doc/guides/compressdevs/features/zsda.ini
 DMAdev Drivers
 --------------
 
+AMD AE4DMA
+M: Bhagyada Modali <Bhagyada.Modali@amd.com>
+F: drivers/dma/ae4dma/
+F: doc/guides/dmadevs/ae4dma.rst
+
 Intel IDXD - EXPERIMENTAL
 M: Bruce Richardson <bruce.richardson@intel.com>
 M: Kevin Laatz <kevin.laatz@intel.com>
diff --git a/doc/guides/dmadevs/ae4dma.rst b/doc/guides/dmadevs/ae4dma.rst
new file mode 100644
index 0000000000..37a2096ccf
--- /dev/null
+++ b/doc/guides/dmadevs/ae4dma.rst
@@ -0,0 +1,75 @@
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
+
+Usage
+-----
+
+Once a dmadev has been started, copies are submitted with
+``rte_dma_copy()`` and completions are reaped with ``rte_dma_completed()``
+or ``rte_dma_completed_status()``. See the
+:ref:`Enqueue / Dequeue API <dmadev_enqueue_dequeue>` section of the
+dmadev library documentation for details.
+
+Limitations
+-----------
+
+* Only memory-to-memory copies are supported. Fill, scatter-gather and
+  any other operation types are not advertised in
+  ``rte_dma_info::dev_capa``.
+* The maximum number of descriptors per virtual channel is fixed by
+  hardware at 32. The PMD rounds the requested ring size up to a
+  power of two and clamps it to 32.
+* Only a single virtual channel per dmadev is supported; use the 16
+  per-PCI-function dmadevs to obtain channel-level parallelism.
+* Interrupt-driven completion is not supported.
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
index 0000000000..eb6ea88f55
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_dmadev.c
@@ -0,0 +1,742 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2021-2025 Advanced Micro Devices, Inc. All rights reserved.
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
+#define AE4DMA_PMD_NAME_STR RTE_STR(AE4DMA_PMD_NAME)
+
+static const struct rte_memzone *
+ae4dma_queue_dma_zone_reserve(const char *queue_name,
+		uint32_t queue_size, int socket_id)
+{
+	const struct rte_memzone *mz;
+
+	mz = rte_memzone_lookup(queue_name);
+	if (mz != 0) {
+		if (((size_t)queue_size <= mz->len) &&
+				((socket_id == SOCKET_ID_ANY) ||
+				 (socket_id == mz->socket_id))) {
+			AE4DMA_PMD_INFO("re-use memzone already "
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
+/* Configure a device. */
+static int
+ae4dma_dev_configure(struct rte_dma_dev *dev __rte_unused,
+		const struct rte_dma_conf *dev_conf,
+		uint32_t conf_sz)
+{
+	if (sizeof(struct rte_dma_conf) != conf_sz)
+		return -EINVAL;
+
+	if (dev_conf->nb_vchans != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+/* Setup a virtual channel for AE4DMA, only 1 vchan is supported per dmadev. */
+static int
+ae4dma_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		const struct rte_dma_vchan_conf *qconf, uint32_t qconf_sz)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t max_desc = qconf->nb_desc;
+
+	if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
+		return -EINVAL;
+
+	if (max_desc < 2)
+		return -EINVAL;
+
+	if (!rte_is_power_of_2(max_desc))
+		max_desc = rte_align32pow2(max_desc);
+
+	if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
+		AE4DMA_PMD_DEBUG("DMA dev %u nb_desc clamped to %u",
+				dev->data->dev_id, AE4DMA_DESCRIPTORS_PER_CMDQ);
+		max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	}
+
+	cmd_q->qcfg = *qconf;
+	cmd_q->qcfg.nb_desc = max_desc;
+
+	/* Ensure all counters are reset, if reconfiguring/restarting device. */
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+/* Start a configured device. */
+static int
+ae4dma_dev_start(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	if (nb == 0)
+		return -EBUSY;
+
+	/* Program ring depth expected by hardware. */
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->max_idx, nb);
+	return 0;
+}
+
+/* Stop a configured device. */
+static int
+ae4dma_dev_stop(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	if (cmd_q->hwq_regs != NULL)
+		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+				AE4DMA_CMD_QUEUE_DISABLE);
+	return 0;
+}
+
+/* Get device information of a device. */
+static int
+ae4dma_dev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *info,
+		uint32_t size)
+{
+	if (size < sizeof(*info))
+		return -EINVAL;
+	info->dev_name = dev->device->name;
+	info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
+	info->max_vchans = 1;
+	info->min_desc = 2;
+	info->max_desc = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	info->nb_vchans = 1;
+	return 0;
+}
+
+/* Close a configured device. */
+static int
+ae4dma_dev_close(struct rte_dma_dev *dev)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	if (cmd_q->hwq_regs != NULL)
+		AE4DMA_WRITE_REG(&cmd_q->hwq_regs->control_reg.control_raw,
+				AE4DMA_CMD_QUEUE_DISABLE);
+
+	if (cmd_q->memz_name[0] != '\0') {
+		const struct rte_memzone *mz = rte_memzone_lookup(cmd_q->memz_name);
+
+		if (mz != NULL)
+			rte_memzone_free(mz);
+	}
+	cmd_q->qbase_desc = NULL;
+	cmd_q->qbase_addr = NULL;
+	cmd_q->qbase_phys_addr = 0;
+	return 0;
+}
+
+/* trigger h/w to process enqued desc:doorbell - by next_write */
+static inline void
+__submit(struct ae4dma_dmadev *ae4dma)
+{
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t write_idx = cmd_q->next_write;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	AE4DMA_WRITE_REG(&cmd_q->hwq_regs->write_idx, write_idx);
+	if (nb != 0)
+		cmd_q->stats.submitted += (uint16_t)((cmd_q->next_write - cmd_q->last_write +
+				nb) % nb);
+	cmd_q->last_write = cmd_q->next_write;
+}
+
+static int
+ae4dma_submit(void *dev_private, uint16_t vchan __rte_unused)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+
+	__submit(ae4dma);
+	return 0;
+}
+
+/* Write descriptor for enqueue (copy only). */
+static inline int
+__write_desc_copy(void *dev_private, rte_iova_t src, phys_addr_t dst,
+		uint32_t len, uint64_t flags)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	struct ae4dma_desc *dma_desc;
+	uint16_t ret;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t write = cmd_q->next_write;
+
+	if (nb == 0)
+		return -EINVAL;
+
+	/* Reserve one slot to distinguish full from empty (power-of-two ring). */
+	if ((uint32_t)cmd_q->ring_buff_count >= (uint32_t)(nb - 1))
+		return -ENOSPC;
+
+	dma_desc = &cmd_q->qbase_desc[write];
+	memset(dma_desc, 0, sizeof(*dma_desc));
+	dma_desc->length = len;
+	dma_desc->src_hi = upper_32_bits(src);
+	dma_desc->src_lo = lower_32_bits(src);
+	dma_desc->dst_hi = upper_32_bits(dst);
+	dma_desc->dst_lo = lower_32_bits(dst);
+	cmd_q->ring_buff_count++;
+	cmd_q->next_write = (uint16_t)((write + 1) % nb);
+	ret = write;
+	if (flags & RTE_DMA_OP_FLAG_SUBMIT)
+		__submit(ae4dma);
+	return ret;
+}
+
+/* Enqueue a copy operation onto the ae4dma device. */
+static int
+ae4dma_enqueue_copy(void *dev_private, uint16_t vchan __rte_unused,
+		rte_iova_t src, rte_iova_t dst, uint32_t length, uint64_t flags)
+{
+	return __write_desc_copy(dev_private, src, dst, length, flags);
+}
+
+/* Dump DMA device info. */
+static int
+ae4dma_dev_dump(const struct rte_dma_dev *dev, FILE *f)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q;
+	void *ae4dma_mmio_base_addr = (uint8_t *)ae4dma->io_regs;
+
+	cmd_q = &ae4dma->cmd_q;
+	fprintf(f, "cmd_q->id              = %" PRIx64 "\n", cmd_q->id);
+	fprintf(f, "cmd_q->qidx            = %" PRIx64 "\n", cmd_q->qidx);
+	fprintf(f, "cmd_q->qsize           = %" PRIx64 "\n", cmd_q->qsize);
+	fprintf(f, "mmio_base_addr	= %p\n", ae4dma_mmio_base_addr);
+	fprintf(f, "queues per ae4dma engine     = %d\n", AE4DMA_READ_REG_OFFSET(
+				ae4dma_mmio_base_addr, AE4DMA_COMMON_CONFIG_OFFSET));
+	fprintf(f, "== Private Data ==\n");
+	fprintf(f, "  Config: { ring_size: %u }\n", cmd_q->qcfg.nb_desc);
+	fprintf(f, "  Ring virt: %p\tphys: %#" PRIx64 "\n",
+			(void *)cmd_q->qbase_desc,
+			(uint64_t)cmd_q->qbase_phys_addr);
+	fprintf(f, "  Next write: %u\n", cmd_q->next_write);
+	fprintf(f, "  Next read: %u\n", cmd_q->next_read);
+	fprintf(f, "  current queue depth: %u\n", cmd_q->ring_buff_count);
+	fprintf(f, "  }\n");
+	fprintf(f, "  Key Stats { submitted: %" PRIu64 ", comp: %" PRIu64 ", failed: %" PRIu64 " }\n",
+		cmd_q->stats.submitted,
+		cmd_q->stats.completed,
+		cmd_q->stats.errors);
+	return 0;
+}
+
+/* Translates AE4DMA ChanERRs to DMA error codes. */
+static inline enum rte_dma_status_code
+__translate_status_ae4dma_to_dma(enum ae4dma_dma_err status)
+{
+	AE4DMA_PMD_DEBUG("ae4dma desc status = %d", status);
+
+	switch (status) {
+	case AE4DMA_DMA_ERR_NO_ERR:
+		return RTE_DMA_STATUS_SUCCESSFUL;
+	case AE4DMA_DMA_ERR_INV_LEN:
+		return RTE_DMA_STATUS_INVALID_LENGTH;
+	case AE4DMA_DMA_ERR_INV_SRC:
+		return RTE_DMA_STATUS_INVALID_SRC_ADDR;
+	case AE4DMA_DMA_ERR_INV_DST:
+		return RTE_DMA_STATUS_INVALID_DST_ADDR;
+	case AE4DMA_DMA_ERR_INV_ALIGN:
+		/* Name matches DPDK public enum spelling. */
+		return RTE_DMA_STATUS_DATA_POISION;
+	case AE4DMA_DMA_ERR_INV_HEADER:
+	case AE4DMA_DMA_ERR_INV_STATUS:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	default:
+		return RTE_DMA_STATUS_ERROR_UNKNOWN;
+	}
+}
+
+/*
+ * Scan HW queue for completed descriptors (non-blocking).
+ *
+ * The AE4DMA engine signals completion by advancing the per-queue
+ * `read_idx` register; it does not (reliably) write a status value
+ * back into the descriptor. We therefore use the HW `read_idx`
+ * register as the source of truth and only inspect the descriptor's
+ * `dw1.err_code` byte to classify each completion as success or
+ * failure.
+ *
+ * @param cmd_q
+ *   The AE4DMA command queue.
+ * @param max_ops
+ *   Maximum descriptors to process this call.
+ * @param[out] failed_count
+ *   Number of completed descriptors that did not report success.
+ * @return
+ *   Number of descriptors completed (success + failure), <= max_ops.
+ */
+static inline uint16_t
+ae4dma_scan_hwq(struct ae4dma_cmd_queue *cmd_q, uint16_t max_ops,
+		uint16_t *failed_count)
+{
+	volatile struct ae4dma_desc *hw_desc;
+	uint16_t events_count = 0, fails = 0;
+	uint16_t tail;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t mask;
+	uint16_t hw_read_idx;
+	uint16_t in_flight;
+	uint16_t scan_cap;
+
+	if (nb == 0 || cmd_q->ring_buff_count == 0) {
+		*failed_count = 0;
+		return 0;
+	}
+	mask = nb - 1;
+
+	hw_read_idx = (uint16_t)(AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx) & mask);
+	tail = cmd_q->next_read;
+
+	/*
+	 * Descriptors completed since our last visit live in the
+	 * half-open ring range [tail, hw_read_idx). If HW hasn't
+	 * moved we have nothing to do.
+	 */
+	in_flight = (uint16_t)((hw_read_idx - tail) & mask);
+	if (in_flight == 0) {
+		*failed_count = 0;
+		return 0;
+	}
+
+	scan_cap = max_ops;
+	if (scan_cap > AE4DMA_DESCRIPTORS_PER_CMDQ)
+		scan_cap = AE4DMA_DESCRIPTORS_PER_CMDQ;
+	if (scan_cap > in_flight)
+		scan_cap = in_flight;
+	if (scan_cap > cmd_q->ring_buff_count)
+		scan_cap = (uint16_t)cmd_q->ring_buff_count;
+
+	while (events_count < scan_cap) {
+		uint8_t hw_status;
+		uint8_t hw_err;
+
+		hw_desc = &cmd_q->qbase_desc[tail];
+		hw_status = hw_desc->dw1.status;
+		hw_err = hw_desc->dw1.err_code;
+
+		/*
+		 * read_idx advancing is the definitive completion
+		 * signal. The per-descriptor status byte is informational
+		 * and may not yet be written when we observe it:
+		 *
+		 *   AE4DMA_DMA_DESC_ERROR (4)
+		 *     Hard failure - err_code names the precise cause.
+		 *   AE4DMA_DMA_DESC_COMPLETED (3) or 0
+		 *     Success.
+		 *   AE4DMA_DMA_DESC_VALIDATED (1) / _PROCESSED (2)
+		 *     Benign race: HW had not finished updating the
+		 *     status byte at the instant we read it. Since
+		 *     read_idx has moved past this slot, treat it as
+		 *     success unless err_code says otherwise.
+		 *
+		 * A non-zero err_code is treated as a failure regardless
+		 * of the observed status value.
+		 */
+		if (hw_status == AE4DMA_DMA_DESC_ERROR ||
+				hw_err != AE4DMA_DMA_ERR_NO_ERR) {
+			fails++;
+			AE4DMA_PMD_WARN("Desc failed: status=%u err=%u",
+					hw_status, hw_err);
+		}
+		cmd_q->status[events_count] = (enum ae4dma_dma_err)hw_err;
+		cmd_q->ring_buff_count--;
+		events_count++;
+		tail = (tail + 1) & mask;
+	}
+
+	cmd_q->stats.completed += events_count;
+	cmd_q->stats.errors += fails;
+	cmd_q->next_read = tail;
+	*failed_count = fails;
+	return events_count;
+}
+
+/* Returns successful operations count and sets error flag if any errors. */
+static uint16_t
+ae4dma_completed(void *dev_private, uint16_t vchan __rte_unused,
+		const uint16_t max_ops, uint16_t *last_idx, bool *has_error)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t cpl_count, sl_count;
+	uint16_t err_count = 0;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	*has_error = false;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+
+	if (cpl_count > 0 && last_idx != NULL)
+		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
+
+	sl_count = cpl_count - err_count;
+	if (err_count)
+		*has_error = true;
+
+	return sl_count;
+}
+
+static uint16_t
+ae4dma_completed_status(void *dev_private, uint16_t vchan __rte_unused,
+		uint16_t max_ops, uint16_t *last_idx,
+		enum rte_dma_status_code *status)
+{
+	struct ae4dma_dmadev *ae4dma = dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t cpl_count;
+	uint16_t i;
+	uint16_t err_count = 0;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+
+	cpl_count = ae4dma_scan_hwq(cmd_q, max_ops, &err_count);
+
+	if (cpl_count > max_ops)
+		cpl_count = max_ops;
+
+	if (cpl_count > 0 && last_idx != NULL)
+		*last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
+
+	if (likely(err_count == 0)) {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = RTE_DMA_STATUS_SUCCESSFUL;
+	} else {
+		for (i = 0; i < cpl_count; i++)
+			status[i] = __translate_status_ae4dma_to_dma(cmd_q->status[i]);
+	}
+
+	return cpl_count;
+}
+
+/* Get the remaining capacity of the ring. */
+static uint16_t
+ae4dma_burst_capacity(const void *dev_private, uint16_t vchan __rte_unused)
+{
+	const struct ae4dma_dmadev *ae4dma = dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint16_t nb = cmd_q->qcfg.nb_desc;
+	uint16_t mask;
+	uint16_t read_idx = cmd_q->next_read;
+	uint16_t write_idx = cmd_q->next_write;
+	uint16_t used;
+
+	if (nb < 2 || !rte_is_power_of_2(nb))
+		return 0;
+
+	mask = nb - 1;
+	used = (uint16_t)((write_idx - read_idx) & mask);
+	/* One slot reserved (same rule as enqueue). */
+	if (used >= nb - 1)
+		return 0;
+	return (uint16_t)(nb - 1 - used);
+}
+
+/* Retrieve the generic stats of a DMA device. */
+static int
+ae4dma_stats_get(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		struct rte_dma_stats *rte_stats, uint32_t size)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	const struct rte_dma_stats *stats = &cmd_q->stats;
+
+	if (size < sizeof(*rte_stats))
+		return -EINVAL;
+	if (rte_stats == NULL)
+		return -EINVAL;
+
+	*rte_stats = *stats;
+	return 0;
+}
+
+/* Reset the generic stat counters for the DMA device. */
+static int
+ae4dma_stats_reset(struct rte_dma_dev *dev, uint16_t vchan __rte_unused)
+{
+	struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+
+	memset(&cmd_q->stats, 0, sizeof(cmd_q->stats));
+	return 0;
+}
+
+/*
+ * Report channel state to the dmadev framework.
+ *
+ *   RTE_DMA_VCHAN_HALTED_ERROR - HW queue is disabled (never started, or
+ *                                stopped via dev_stop()).
+ *   RTE_DMA_VCHAN_IDLE         - HW has caught up: read_idx == write_idx,
+ *                                no descriptors in flight.
+ *   RTE_DMA_VCHAN_ACTIVE       - HW still has descriptors to process.
+ */
+static int
+ae4dma_vchan_status(const struct rte_dma_dev *dev, uint16_t vchan __rte_unused,
+		enum rte_dma_vchan_status *status)
+{
+	const struct ae4dma_dmadev *ae4dma = dev->fp_obj->dev_private;
+	const struct ae4dma_cmd_queue *cmd_q = &ae4dma->cmd_q;
+	uint32_t ctrl, hw_read, hw_write;
+
+	if (cmd_q->hwq_regs == NULL) {
+		*status = RTE_DMA_VCHAN_HALTED_ERROR;
+		return 0;
+	}
+
+	ctrl = AE4DMA_READ_REG(&cmd_q->hwq_regs->control_reg.control_raw);
+	if ((ctrl & AE4DMA_CMD_QUEUE_ENABLE) == 0) {
+		*status = RTE_DMA_VCHAN_HALTED_ERROR;
+		return 0;
+	}
+
+	hw_read  = AE4DMA_READ_REG(&cmd_q->hwq_regs->read_idx);
+	hw_write = AE4DMA_READ_REG(&cmd_q->hwq_regs->write_idx);
+
+	*status = (hw_read == hw_write) ? RTE_DMA_VCHAN_IDLE
+					: RTE_DMA_VCHAN_ACTIVE;
+	return 0;
+}
+
+static int
+ae4dma_add_queue(struct ae4dma_dmadev *dev, uint8_t qn, const char *pci_name)
+{
+	uint32_t dma_addr_lo, dma_addr_hi;
+	struct ae4dma_cmd_queue *cmd_q;
+	const struct rte_memzone *q_mz;
+
+	if (dev == NULL)
+		return -EINVAL;
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
+	static const struct rte_dma_dev_ops ae4dma_dmadev_ops = {
+		.dev_close = ae4dma_dev_close,
+		.dev_configure = ae4dma_dev_configure,
+		.dev_dump = ae4dma_dev_dump,
+		.dev_info_get = ae4dma_dev_info_get,
+		.dev_start = ae4dma_dev_start,
+		.dev_stop = ae4dma_dev_stop,
+		.stats_get = ae4dma_stats_get,
+		.stats_reset = ae4dma_stats_reset,
+		.vchan_status = ae4dma_vchan_status,
+		.vchan_setup = ae4dma_vchan_setup,
+	};
+
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
+	dmadev->dev_ops = &ae4dma_dmadev_ops;
+
+	dmadev->fp_obj->burst_capacity = ae4dma_burst_capacity;
+	dmadev->fp_obj->completed = ae4dma_completed;
+	dmadev->fp_obj->completed_status = ae4dma_completed_status;
+	dmadev->fp_obj->copy = ae4dma_enqueue_copy;
+	dmadev->fp_obj->submit = ae4dma_submit;
+	/* fill capability not advertised: leave fp_obj->fill as zero-initialised. */
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
+	return -EFAULT;
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
index 0000000000..235819778e
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_hw_defs.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
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
+#define AE4DMA_BITS_PER_LONG	(__SIZEOF_LONG__ * 8)
+#define AE4DMA_GENMASK(h, l) \
+	(((~0UL) << (l)) & (~0UL >> (AE4DMA_BITS_PER_LONG - 1 - (h))))
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
+#define AE4DMA_DWORD0_DESTINATION_MEMORY_TYPE	AE4DMA_GENMASK(5, 4)
+#define AE4DMA_DWORD0_SOURCE_MEMEORY_TYPE	AE4DMA_GENMASK(7, 6)
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
index 0000000000..d55cfbe3b8
--- /dev/null
+++ b/drivers/dma/ae4dma/ae4dma_internal.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Advanced Micro Devices, Inc. All rights reserved.
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
+struct ae4dma_cmd_queue {
+	char memz_name[RTE_MEMZONE_NAMESIZE];
+	volatile struct ae4dma_hwq_regs *hwq_regs;
+
+	struct rte_dma_vchan_conf qcfg;
+	struct rte_dma_stats stats;
+	/* Queue address */
+	struct ae4dma_desc *qbase_desc;
+	void *qbase_addr;
+	phys_addr_t qbase_phys_addr;
+	enum ae4dma_dma_err status[AE4DMA_DESCRIPTORS_PER_CMDQ];
+	/* Queue identifier */
+	uint64_t id;    /**< queue id */
+	uint64_t qidx;  /**< queue index */
+	uint64_t qsize; /**< queue size */
+	uint32_t ring_buff_count;
+	unsigned short next_read;
+	unsigned short next_write;
+	unsigned short last_write; /* Used to compute submitted count. */
+} __rte_cache_aligned;
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
+
+#define AE4DMA_PMD_LOG(level, fmt, args...) rte_log(RTE_LOG_ ## level, \
+		ae4dma_pmd_logtype, "AE4DMA: %s(): " fmt "\n", __func__, ##args)
+
+#define AE4DMA_PMD_DEBUG(fmt, args...)  AE4DMA_PMD_LOG(DEBUG, fmt, ## args)
+#define AE4DMA_PMD_INFO(fmt, args...)   AE4DMA_PMD_LOG(INFO, fmt, ## args)
+#define AE4DMA_PMD_ERR(fmt, args...)    AE4DMA_PMD_LOG(ERR, fmt, ## args)
+#define AE4DMA_PMD_WARN(fmt, args...)   AE4DMA_PMD_LOG(WARNING, fmt, ## args)
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
index 93f2383dff..ec6d6713b4 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -86,6 +86,9 @@
 cn9k_ree = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f4',
             'SVendor': None, 'SDevice': None}
 
+amd_ae4dma = {'Class': '08', 'Vendor': '1022', 'Device': '149b',
+                 'SVendor': None, 'SDevice': None}
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

