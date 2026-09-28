Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4157CC9833F
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:50:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 196A340DCA;
	Mon, 28 Sep 2026 12:50:26 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by mails.dpdk.org (Postfix) with ESMTP id 2E50340DDA
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:50:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCJlwJGM6oIKD/Kn9lFwcj5YA1Zso0lVI7C5IqMhC59aUFu70ultoXg5sacbf56SeeXw48sLm71W7rd7oqeCWYZc6TjXuurQGIcXI+NwfzVCx9S+ACFY/l1/IAQYm0tKHu9ESKnqGlbtcsqvzNzVaXEf2bWVDHn5YtSE3XFMnfWHfgeEvrT6zKy8wHrKSHKQ1aLsZPd2/x6uJyro4gsgIk6QrFReaGoN6SR6MwY3nYFWrEPawpUqFRwqjK6yzdDVoYaSPm6U3bVgoWHDkbndTXh2+1g7ELRguBLro22ZaYcDlxkORuwas72sG8BbgRVuYJOSvkbLGeZ2gvIRKhoPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBiI3/yHeB8TmJk4uAkgZhh+TU6EVcjIdRjDm6JeiFU=;
 b=sT//1fFb6Tw6GyAnJ9bEJsxm391aflLvFboLgVlfSb0Lb+GByKVxAWQE+57SweHgApolejkKPicZRSxTa8si0J7Wj98cW5p8F3WZDBwB1SkgyEYyPXhr4yuOi4Ikjj/X/0em/Bpm8MOsZEG2PoE7NvVvNch0A2SovYi6DNYjuDCvhKmqUyvEVNnT7pb2fhJe4wQW4Xy351/kCbYiXPIsMvpX1byht+ajq1k54yaGPRqdXrendqkdzdQCLUiv5RweCoCFSUjLAayibv9pMFgJDcVC/2LBHGq/nVoY7ct0iwIJzk9uilfGoAbQ6iUn/UIRun8S0RVtVa4YLkPHcDy//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBiI3/yHeB8TmJk4uAkgZhh+TU6EVcjIdRjDm6JeiFU=;
 b=B1uZaTK/nCM1EM1ZHuaGx9V/9FOt043Pfj74DCkoY9pvhlVnkPriwegrewHXC8gr3m1PUDe99xVXiO/a4APUqjb3Ygd1TFSRdWT7pjn0qjjDpSsfS6PFvXOPyaQ5lkSfZAYlCYiHNzeyZCSXrEyHdN30vmATsEUpdl4QOpGNwRM=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 10:50:18 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::59) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 10:50:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:50:17 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:50:13 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 2/2] raw/ntb: add AMD NTB support
Date: Mon, 28 Sep 2026 16:19:29 +0530
Message-ID: <20260928104929.2373409-3-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
References: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 765d43a2-e3ca-457c-bdc7-08df1d4e491b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|11063799006|260925022911599003|260925021911599003|260925021311599003|3023799007|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: z1zHOXVSnO3JcNPEyp9jVInqc0AdOFAGSMhYG1T2ubg7ZuUJxwhajzyynK/C6Y2PWrAfZ+38nsc7WMwswuW6jtYXE7F00XGY9/w3H8Ppc8BkLSfgqSyJ0vNAmb7wTL+YFiCaA6oALsYI5o82FL1gqJbNsGdtvVQ8eqFnQVKmRcNxW1f4L4/dkuI7Sy4lxOQyOz2OupO7zFYtnxycXFEHUNMLzOSXWPFFZz5WeK0sr7anPpCnhfeQDNE68oI4iaeTkFliveoYctS8vX1ysw2B4HI17IjfvJQOI8wJVicVSX4QmUS8MTXrfDfIxueDq4yD0GALI4bkgIOx1IvOlacg/DRLCzlUpcYLtYxuTCqb+A6/ol1f+GRLMIED/M0tnp5HAnxfqextB9PXOkYAlfHidyZpA5xZH+N5f7zHA96k3bYlDDZ8LgeB+U37Ju3nQmVIwBcwYstU5CGL6INjKDRugI24fckq7dUgyhG3H0ynaedEi2BHrIpoNY1Lf6MJ4C2b9pdGHVo60jBaBhva5/dpN2AwNPsa90SgcbcqMHwrYCglOS20SazhxntYO6QG3lZDdDi2jy6t8XIrTzrvrGi6m5OGUVyv+JZ37ZxpbrQYpYNI1G/tikK3ERZtTVoSjjlQ98TgPDtYu7MLhgjmJhwHY766a721T2mp1+/LwkvPBilalqOhxFNgMXcSpVEntKEmCMcGzPqoiDUezSqXPoQ0mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(11063799006)(260925022911599003)(260925021911599003)(260925021311599003)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +3abBPpiUdxaLndqHYsQm1iuWRAFSnmqRO/t5ESuytY1FEKC4oCXplM+hvD3JViObdxtOi8yx111EjYSg3K/YdFLpNCjGK560RD/gPYmqGYbLJmhGQMYilIflrS3pHj1wzzIrb2U5Gnj01t1BxdZaZbRqR4euImlgeDjGAizapREFiESOxbzRycI2AbnojS9NzTu5PAqFnr9PY44K/kuO1fLcwJZ3/iXeyeFklfFaWy3vb1z9KGablIMhl9DcpLn0pM0D2g2bz/fYcX62rh5PXoUJQB9WE+I5S2rjTgFxZ+VjgwlIUjU6DXKGldS+m2GQF95m63JG/7jRTH3o/BAO/PA7FF2xtWOx4Okf8hBU3oC2qKLvHW67JY/lEKFXuR2AL/9rGpRCkhBaU5tf8u4KCPqQqUn1O7kO8hhtrCOxK1X55r0DXUUMj36Nu4ZLFeR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:50:17.9760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 765d43a2-e3ca-457c-bdc7-08df1d4e491b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
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

Add support for the NTB endpoints integrated in AMD EPYC Embedded
"Turin", "Genoa" and "Siena" processors to the raw/ntb driver.

The AMD NTB uses a primary/secondary topology: one endpoint enumerates
as the primary (device ID 0x14c0) and the other as the secondary
(device ID 0x14c3). The hardware exposes two memory windows (BAR23 and
BAR45), 16 doorbells and a single shared 16-register scratchpad bank.
The scratchpad bank is split into two disjoint 8-register sets, one per
side, so the driver uses a packed handshake layout that fits in 8
registers, plugged in through the framework's dev_handshake and
read_peer_config ops. An MSI-X interrupt handler and a memory-window
alignment helper are provided through the interrupt_handler and
mem_align ops.

The AMD NTB uses an outbound translation window: a write to a BARxx
memory window offset is forwarded to (xlat_base | offset) in the peer's
memory rather than (xlat_base + offset). For that to be correct the
translation base must be aligned to a power of two >= the window length
so that no offset bit collides with a set bit in the base; the XLAT
register also requires at least 4K alignment. The mem_align op reports
this requirement through rte_pmd_ntb_get_mem_align(), and
amd_ntb_mw_set_trans() rejects a misaligned base.

On the secondary side the device's own PCIe link status does not
reflect the true inter-host link, so the link speed and width are read
from the upstream switch port via sysfs.

Update the documentation, release notes and MAINTAINERS accordingly.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 MAINTAINERS                            |   1 +
 doc/guides/rawdevs/ntb.rst             |  28 +-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/raw/ntb/meson.build            |   7 +-
 drivers/raw/ntb/ntb.c                  |   7 +
 drivers/raw/ntb/ntb_hw_amd.c           | 711 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 114 ++++
 usertools/dpdk-devbind.py              |   4 +-
 8 files changed, 876 insertions(+), 4 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..13306345fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1613,6 +1613,7 @@ F: doc/guides/rawdevs/cnxk_rvu_lf.rst
 
 NTB
 M: Jingjing Wu <jingjing.wu@intel.com>
+M: Bhagyada Modali <bhagyada.modali@amd.com>
 F: drivers/raw/ntb/
 F: doc/guides/rawdevs/ntb.rst
 F: examples/ntb/
diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index 3721b4880e..c7f94bbb1a 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -37,10 +37,36 @@ then reboot.
 - Set ``PCIe PLL SSC (Spread Spectrum Clocking)`` as ``Disabled``, on both hosts.
   This is a hardware requirement when using Re-timer Cards.
 
+AMD EPYC Embedded NTB
+---------------------
+
+The driver also supports the NTB endpoints integrated in AMD EPYC Embedded
+"Turin", "Genoa" and "Siena" processors. These use a primary/secondary
+topology rather than the Intel back-to-back topology: one endpoint is
+enumerated as the primary (device ID ``0x14c0``) and the other as the
+secondary (device ID ``0x14c3``). The BIOS on both systems performs NTB link
+training; no additional NTB-specific BIOS options are required beyond enabling
+the NTB endpoints.
+
+The AMD NTB hardware exposes two memory windows (BAR23 and BAR45), 16
+doorbells and a single shared 16-register scratchpad bank. The scratchpad
+bank is split into two disjoint 8-register sets, one owned by each side, so
+the driver uses a packed handshake layout that fits within 8 registers.
+
+The AMD NTB uses an outbound translation window: a write to a memory window
+offset is forwarded to ``(base | offset)`` in the peer's memory rather than
+``(base + offset)``. The translation base must therefore be aligned to a
+power of two greater than or equal to the window length so that no offset
+bit collides with a set bit in the base. Different NTB hardware imposes
+different alignment constraints, so applications should not assume any
+particular value: reserve each memory window memzone with the alignment
+returned by ``rte_pmd_ntb_get_mem_align()`` for that window and length. The
+``ntb_fwd`` example shows this usage.
+
 Device Setup
 ------------
 
-The Intel NTB devices need to be bound to a DPDK-supported kernel driver
+The NTB devices need to be bound to a DPDK-supported kernel driver
 to use, i.e. igb_uio, vfio. The ``dpdk-devbind.py`` script can be used to
 show devices status and to bind them to a suitable kernel driver. They will
 appear under the category of "Misc (rawdev) devices".
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..0b364ccbd4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,14 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added AMD NTB support to the NTB rawdev driver.**
+
+  Added support for the NTB endpoints integrated in AMD EPYC Embedded
+  "Turin", "Genoa" and "Siena" processors to the ``raw/ntb`` driver.
+  The NTB rawdev framework was generalized to support multiple vendors,
+  with AMD-specific hardware access, a primary/secondary topology and a
+  packed scratchpad handshake.
+
 
 Removed Items
 -------------
diff --git a/drivers/raw/ntb/meson.build b/drivers/raw/ntb/meson.build
index 9096f2b25a..9e7e852010 100644
--- a/drivers/raw/ntb/meson.build
+++ b/drivers/raw/ntb/meson.build
@@ -2,6 +2,9 @@
 # Copyright(c) 2019 Intel Corporation.
 
 deps += ['rawdev', 'mbuf', 'mempool', 'pci', 'bus_pci']
-sources = files('ntb.c',
-                'ntb_hw_intel.c')
+sources = files(
+        'ntb.c',
+        'ntb_hw_intel.c',
+        'ntb_hw_amd.c',
+)
 headers = files('rte_pmd_ntb.h')
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 497c86b58c..af4c0928d0 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -21,12 +21,15 @@
 #include <eal_export.h>
 
 #include "ntb_hw_intel.h"
+#include "ntb_hw_amd.h"
 #include "rte_pmd_ntb.h"
 #include "ntb.h"
 
 static const struct rte_pci_id pci_id_ntb_map[] = {
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_SKX) },
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_ICX) },
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_PRI) },
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_SEC) },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -1427,6 +1430,10 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	case NTB_INTEL_DEV_ID_B2B_ICX:
 		hw->ntb_ops = &intel_ntb_ops;
 		break;
+	case NTB_AMD_DEV_ID_PRI:
+	case NTB_AMD_DEV_ID_SEC:
+		hw->ntb_ops = &amd_ntb_ops;
+		break;
 	default:
 		NTB_LOG(ERR, "Not supported device.");
 		return -EINVAL;
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
new file mode 100644
index 0000000000..a0788234e5
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -0,0 +1,711 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <limits.h>
+
+#include <rte_common.h>
+#include <rte_io.h>
+#include <rte_eal.h>
+#include <rte_pci.h>
+#include <bus_pci_driver.h>
+#include <rte_rawdev.h>
+#include <rte_rawdev_pmd.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+
+#include "ntb.h"
+#include "ntb_hw_amd.h"
+
+static enum amd_ntb_bar amd_ntb_bar[] = {
+	AMD_NTB_BAR23,
+	AMD_NTB_BAR45,
+};
+
+static int
+amd_ntb_dev_init(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw;
+	uint32_t sideinfo;
+	int i, bar;
+
+	if (ntb == NULL) {
+		NTB_LOG(ERR, "Invalid device.");
+		return -EINVAL;
+	}
+
+	amd_hw = rte_zmalloc("amd_ntb_hw", sizeof(struct amd_ntb_hw), 0);
+	if (amd_hw == NULL) {
+		NTB_LOG(ERR, "Failed to allocate memory for amd_ntb_hw.");
+		return -ENOMEM;
+	}
+	ntb->pmd_private = amd_hw;
+
+	ntb->hw_addr = (char *)ntb->pci_dev->mem_resource[0].addr;
+	amd_hw->self_mmio = ntb->hw_addr;
+	amd_hw->peer_mmio = (char *)amd_hw->self_mmio + AMD_PEER_OFFSET;
+	amd_hw->int_mask = AMD_EVENT_INTMASK;
+
+	/* Bit 0 of the link status register carries the topology. */
+	sideinfo = rte_read32((char *)ntb->hw_addr + AMD_SIDEINFO_OFFSET);
+	if (sideinfo & AMD_SIDE_MASK)
+		ntb->topo = NTB_TOPO_SEC;
+	else
+		ntb->topo = NTB_TOPO_PRI;
+
+	NTB_LOG(INFO, "Device topology: %s (sideinfo 0x%" PRIx32 ")",
+		ntb->topo == NTB_TOPO_SEC ? "secondary" : "primary", sideinfo);
+
+	ntb->mw_cnt = AMD_MW_COUNT;
+	ntb->db_cnt = AMD_DB_COUNT;
+	/* The 16-register scratchpad bank is split into two halves, so only
+	 * AMD_SPAD_PER_SIDE registers are usable per side.
+	 */
+	ntb->spad_cnt = AMD_SPAD_PER_SIDE;
+
+	ntb->mw_size = rte_zmalloc("ntb_mw_size",
+				   ntb->mw_cnt * sizeof(uint64_t), 0);
+	if (ntb->mw_size == NULL) {
+		NTB_LOG(ERR, "Cannot allocate memory for mw size.");
+		rte_free(amd_hw);
+		ntb->pmd_private = NULL;
+		return -ENOMEM;
+	}
+	for (i = 0; i < ntb->mw_cnt; i++) {
+		bar = amd_ntb_bar[i];
+		ntb->mw_size[i] = ntb->pci_dev->mem_resource[bar].len;
+		NTB_LOG(INFO, "mw[%d] bar%d size 0x%" PRIx64, i, bar,
+			ntb->mw_size[i]);
+	}
+
+	/* The 16-register scratchpad bank is shared between both sides, so
+	 * split it into two disjoint sets to avoid clobbering: one side owns
+	 * offset 0, the other offset AMD_SPAD_SET_OFFSET.
+	 */
+	if (ntb->topo == NTB_TOPO_PRI) {
+		amd_hw->self_spad = 0;
+		amd_hw->peer_spad = AMD_SPAD_SET_OFFSET;
+	} else {
+		amd_hw->self_spad = AMD_SPAD_SET_OFFSET;
+		amd_hw->peer_spad = 0;
+	}
+
+	/* Reserve the last 2 scratchpad registers for application use. */
+	for (i = 0; i < NTB_SPAD_USER_MAX_NUM; i++)
+		ntb->spad_user_list[i] = ntb->spad_cnt;
+	ntb->spad_user_list[0] = ntb->spad_cnt - 2;
+	ntb->spad_user_list[1] = ntb->spad_cnt - 1;
+
+	return 0;
+}
+
+static void *
+amd_ntb_get_peer_mw_addr(const struct rte_rawdev *dev, int mw_idx)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+
+	if (mw_idx < 0 || mw_idx >= ntb->mw_cnt) {
+		NTB_LOG(ERR, "Invalid memory window index (0 - %u).",
+			ntb->mw_cnt - 1);
+		return NULL;
+	}
+
+	return ntb->pci_dev->mem_resource[amd_ntb_bar[mw_idx]].addr;
+}
+
+static int
+amd_ntb_mw_set_trans(const struct rte_rawdev *dev, int mw_idx,
+		     uint64_t addr, uint64_t size)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t xlat_off, limit_off;
+	uint64_t mw_size, reg_val;
+	uint8_t bar;
+
+	if (mw_idx < 0 || mw_idx >= ntb->mw_cnt) {
+		NTB_LOG(ERR, "Invalid memory window index (0 - %u).",
+			ntb->mw_cnt - 1);
+		return -EINVAL;
+	}
+
+	bar = amd_ntb_bar[mw_idx];
+	mw_size = ntb->pci_dev->mem_resource[bar].len;
+	if (size > mw_size) {
+		NTB_LOG(ERR, "Set translation size 0x%" PRIx64 " exceeds mw "
+			"size 0x%" PRIx64, size, mw_size);
+		return -EINVAL;
+	}
+
+	/* Outbound translation forms the target as (base | offset), so a
+	 * misaligned base aliases writes (see mem_align op). Reject it early.
+	 */
+	if (addr & (rte_align64pow2(size) - 1)) {
+		NTB_LOG(ERR, "mw%d translation base 0x%" PRIx64 " is not "
+			"aligned to a power of two >= size 0x%" PRIx64
+			"; window writes would alias.", mw_idx, addr, size);
+		return -EINVAL;
+	}
+
+	/* Program the peer's outbound translation window (S* registers) so
+	 * that peer writes into its BAR land in our local memory at 'addr'.
+	 */
+	if (mw_idx == 0) {
+		xlat_off = AMD_BAR23_XLAT_OFFSET;
+		limit_off = AMD_BAR23_LIMIT_OFFSET;
+	} else {
+		xlat_off = AMD_BAR45_XLAT_OFFSET;
+		limit_off = AMD_BAR45_LIMIT_OFFSET;
+	}
+
+	rte_write64(addr, (char *)amd_hw->peer_mmio + xlat_off);
+	reg_val = rte_read64((char *)amd_hw->peer_mmio + xlat_off);
+	if (reg_val != addr) {
+		NTB_LOG(ERR, "Failed to set mw%d translation.", mw_idx);
+		rte_write64(0, (char *)amd_hw->peer_mmio + xlat_off);
+		return -EIO;
+	}
+
+	rte_write64(size, (char *)amd_hw->peer_mmio + limit_off);
+	reg_val = rte_read64((char *)amd_hw->peer_mmio + limit_off);
+	if (reg_val != size) {
+		NTB_LOG(ERR, "Failed to set mw%d limit.", mw_idx);
+		rte_write64(0, (char *)amd_hw->peer_mmio + xlat_off);
+		rte_write64(0, (char *)amd_hw->peer_mmio + limit_off);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void *
+amd_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	void *mapped = NULL;
+	void *base;
+	int i;
+
+	for (i = 0; i < ntb->peer_used_mws; i++) {
+		if (addr >= ntb->peer_mw_base[i] &&
+		    addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]) {
+			base = amd_ntb_get_peer_mw_addr(dev, i);
+			mapped = (void *)(size_t)(addr - ntb->peer_mw_base[i] +
+						  (size_t)base);
+			break;
+		}
+	}
+
+	return mapped;
+}
+
+/* Read link speed/width from the device's PCIe capability link status. */
+static int
+amd_ntb_read_pcie_link_status(struct ntb_hw *ntb, uint16_t *link_status)
+{
+	struct rte_pci_device *pci_dev = ntb->pci_dev;
+	uint8_t pos, cap_id, next;
+	uint16_t status;
+	int ret;
+
+	ret = rte_pci_read_config(pci_dev, &status, sizeof(status),
+				  RTE_PCI_STATUS);
+	if (ret != sizeof(status))
+		return -EIO;
+	if (!(status & RTE_PCI_STATUS_CAP_LIST))
+		return -ENOTSUP;
+
+	ret = rte_pci_read_config(pci_dev, &pos, sizeof(pos),
+				  RTE_PCI_CAPABILITY_LIST);
+	if (ret != sizeof(pos))
+		return -EIO;
+
+	while (pos) {
+		ret = rte_pci_read_config(pci_dev, &cap_id, sizeof(cap_id),
+					  pos);
+		if (ret != sizeof(cap_id))
+			return -EIO;
+		ret = rte_pci_read_config(pci_dev, &next, sizeof(next),
+					  pos + 1);
+		if (ret != sizeof(next))
+			return -EIO;
+		if (cap_id == RTE_PCI_CAP_ID_EXP) {
+			ret = rte_pci_read_config(pci_dev, link_status,
+						  sizeof(*link_status),
+						  pos + RTE_PCI_EXP_LNKSTA);
+			if (ret != sizeof(*link_status))
+				return -EIO;
+			return 0;
+		}
+		pos = next;
+	}
+
+	return -ENOTSUP;
+}
+
+/* Read the PCIe link status (LNKSTA) from an arbitrary device's config space
+ * exposed via sysfs. Used to query bridges that are not bound to this driver
+ * (e.g. the upstream switch above a secondary-side NTB), which rte_pci_*
+ * cannot access directly.
+ */
+static int
+amd_ntb_read_lnksta_sysfs(const char *config_path, uint16_t *link_status)
+{
+	uint8_t pos, cap_id, next;
+	uint16_t status;
+	int fd, ret = -EIO;
+
+	fd = open(config_path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	if (pread(fd, &status, sizeof(status), RTE_PCI_STATUS) !=
+	    sizeof(status))
+		goto out;
+	if (!(status & RTE_PCI_STATUS_CAP_LIST))
+		goto out;
+
+	if (pread(fd, &pos, sizeof(pos), RTE_PCI_CAPABILITY_LIST) !=
+	    sizeof(pos))
+		goto out;
+
+	while (pos) {
+		if (pread(fd, &cap_id, sizeof(cap_id), pos) != sizeof(cap_id))
+			goto out;
+		if (pread(fd, &next, sizeof(next), pos + 1) != sizeof(next))
+			goto out;
+		if (cap_id == RTE_PCI_CAP_ID_EXP) {
+			if (pread(fd, link_status, sizeof(*link_status),
+				  pos + RTE_PCI_EXP_LNKSTA) ==
+			    sizeof(*link_status))
+				ret = 0;
+			goto out;
+		}
+		pos = next;
+	}
+out:
+	close(fd);
+	return ret;
+}
+
+/* On the secondary side the NTB device's own PCIe link status does not reflect
+ * the inter-host link. Mirror the Linux amd_ntb behaviour by walking up two
+ * bridge levels (device -> downstream switch -> upstream switch) and reading
+ * the upstream switch port's link status instead.
+ */
+static int
+amd_ntb_read_upstream_link_status(struct ntb_hw *ntb, uint16_t *link_status)
+{
+	char path[PATH_MAX];
+	char real[PATH_MAX];
+	char *p;
+	int i;
+
+	snprintf(path, sizeof(path),
+		 "/sys/bus/pci/devices/%04x:%02x:%02x.%x",
+		 ntb->pci_dev->addr.domain, ntb->pci_dev->addr.bus,
+		 ntb->pci_dev->addr.devid, ntb->pci_dev->addr.function);
+
+	if (realpath(path, real) == NULL)
+		return -errno;
+
+	/* Strip two trailing path components to reach the upstream switch. */
+	for (i = 0; i < 2; i++) {
+		p = strrchr(real, '/');
+		if (p == NULL || p == real)
+			return -ENOENT;
+		*p = '\0';
+	}
+
+	snprintf(path, sizeof(path), "%s/config", real);
+	return amd_ntb_read_lnksta_sysfs(path, link_status);
+}
+
+static int
+amd_ntb_get_link_status(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint16_t link_status = 0;
+	uint32_t sideinfo;
+	int ret;
+
+	/* The link is usable once the peer has set its SIDE_READY bit. */
+	sideinfo = rte_read32((char *)amd_hw->peer_mmio + AMD_SIDEINFO_OFFSET);
+	ntb->link_status = !!(sideinfo & AMD_SIDE_READY);
+
+	if (!ntb->link_status) {
+		ntb->link_speed = NTB_SPEED_NONE;
+		ntb->link_width = NTB_WIDTH_NONE;
+		return 0;
+	}
+
+	/* The primary reads its own PCIe link status; the secondary must read
+	 * the upstream switch port above it. If the upstream read fails, fall
+	 * back to the local device so speed/width is still best-effort.
+	 */
+	if (ntb->topo == NTB_TOPO_SEC) {
+		ret = amd_ntb_read_upstream_link_status(ntb, &link_status);
+		if (ret != 0)
+			ret = amd_ntb_read_pcie_link_status(ntb, &link_status);
+	} else {
+		ret = amd_ntb_read_pcie_link_status(ntb, &link_status);
+	}
+
+	if (ret == 0) {
+		ntb->link_speed = AMD_LNK_STA_SPEED(link_status);
+		ntb->link_width = AMD_LNK_STA_WIDTH(link_status);
+	} else {
+		NTB_LOG(WARNING, "Failed to read PCIe link status (%d).", ret);
+		ntb->link_speed = NTB_SPEED_NONE;
+		ntb->link_width = NTB_WIDTH_NONE;
+	}
+
+	return 0;
+}
+
+static int
+amd_ntb_set_link(const struct rte_rawdev *dev, bool up)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	void *mmio = amd_hw->self_mmio;
+	uint32_t reg;
+
+	reg = rte_read32((char *)mmio + AMD_SIDEINFO_OFFSET);
+	if (up) {
+		if (!(reg & AMD_SIDE_READY)) {
+			reg |= AMD_SIDE_READY;
+			rte_write32(reg, (char *)mmio + AMD_SIDEINFO_OFFSET);
+		}
+		reg = rte_read32((char *)mmio + AMD_CNTL_OFFSET);
+		reg |= (AMD_PMM_REG_CTL | AMD_SMM_REG_CTL);
+		rte_write32(reg, (char *)mmio + AMD_CNTL_OFFSET);
+	} else {
+		if (reg & AMD_SIDE_READY) {
+			reg &= ~AMD_SIDE_READY;
+			rte_write32(reg, (char *)mmio + AMD_SIDEINFO_OFFSET);
+		}
+		reg = rte_read32((char *)mmio + AMD_CNTL_OFFSET);
+		reg &= ~(AMD_PMM_REG_CTL | AMD_SMM_REG_CTL);
+		rte_write32(reg, (char *)mmio + AMD_CNTL_OFFSET);
+	}
+
+	return 0;
+}
+
+static uint32_t
+amd_ntb_spad_read(const struct rte_rawdev *dev, int spad, bool peer)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t offset;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad index.");
+		return 0;
+	}
+
+	offset = peer ? amd_hw->peer_spad : amd_hw->self_spad;
+
+	return rte_read32((char *)ntb->hw_addr + AMD_SPAD_OFFSET + offset +
+			  (spad << 2));
+}
+
+static int
+amd_ntb_spad_write(const struct rte_rawdev *dev, int spad,
+		   bool peer, uint32_t spad_v)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t offset;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad index.");
+		return -EINVAL;
+	}
+
+	offset = peer ? amd_hw->peer_spad : amd_hw->self_spad;
+
+	rte_write32(spad_v, (char *)ntb->hw_addr + AMD_SPAD_OFFSET + offset +
+		    (spad << 2));
+
+	return 0;
+}
+
+static uint64_t
+amd_ntb_db_read(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	return (uint64_t)rte_read16((char *)amd_hw->self_mmio +
+				    AMD_DBSTAT_OFFSET);
+}
+
+static int
+amd_ntb_db_clear(const struct rte_rawdev *dev, uint64_t db_bits)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	rte_write16((uint16_t)db_bits, (char *)amd_hw->self_mmio +
+		    AMD_DBSTAT_OFFSET);
+
+	return 0;
+}
+
+static int
+amd_ntb_db_set_mask(const struct rte_rawdev *dev, uint64_t db_mask)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+
+	if (db_mask & ~ntb->db_valid_mask)
+		return -EINVAL;
+
+	ntb->db_mask |= db_mask;
+	rte_write16((uint16_t)ntb->db_mask, (char *)amd_hw->self_mmio +
+		    AMD_DBMASK_OFFSET);
+
+	return 0;
+}
+
+static int
+amd_ntb_peer_db_set(const struct rte_rawdev *dev, uint8_t db_idx)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+
+	if (((uint64_t)1 << db_idx) & ~ntb->db_valid_mask) {
+		NTB_LOG(ERR, "Invalid doorbell.");
+		return -EINVAL;
+	}
+
+	rte_write16((uint16_t)1 << db_idx, (char *)ntb->hw_addr +
+		    AMD_DBREQ_OFFSET);
+
+	return 0;
+}
+
+static int
+amd_ntb_vector_bind(const struct rte_rawdev *dev __rte_unused,
+		    uint8_t intr __rte_unused, uint8_t msix __rte_unused)
+{
+	/* Each doorbell/event maps to its MSI-X vector by default. */
+	return 0;
+}
+
+/* Handshake: advertises the local configuration to the peer using the
+ * packed 8-register scratchpad layout, programs the peer's outbound
+ * translation windows and rings doorbell 0 to signal readiness.
+ */
+static int
+amd_dev_handshake(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	uint32_t info;
+	uint64_t base;
+	int i, ret;
+
+	info = (ntb->mw_cnt & 0xff) |
+	       ((uint32_t)(ntb->queue_pairs & 0xff) << 8) |
+	       ((uint32_t)(ntb->used_mw_num & 0xff) << 16);
+	ret = amd_ntb_spad_write(dev, AMD_SPAD_CNT_INFO, 1, info);
+	if (ret < 0)
+		return ret;
+
+	ret = amd_ntb_spad_write(dev, AMD_SPAD_QUEUE_SZ, 1, ntb->queue_size);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ntb->used_mw_num; i++) {
+		/* Advertise the memzone virtual base (used by ioremap on the
+		 * peer) and program the translation with the IOVA.
+		 */
+		base = (uint64_t)(size_t)ntb->mz[i]->addr;
+		ret = amd_ntb_spad_write(dev, AMD_SPAD_MW0_BA_L + 2 * i, 1,
+					 (uint32_t)base);
+		if (ret < 0)
+			return ret;
+		ret = amd_ntb_spad_write(dev, AMD_SPAD_MW0_BA_H + 2 * i, 1,
+					 (uint32_t)(base >> 32));
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < ntb->used_mw_num; i++) {
+		ret = amd_ntb_mw_set_trans(dev, i, ntb->mz[i]->iova,
+					   ntb->mz[i]->len);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Ring doorbell 0 to tell the peer the device is ready. */
+	return amd_ntb_peer_db_set(dev, 0);
+}
+
+/* Peer-config read at device start. Validates the peer's queue
+ * configuration and records the peer memory-window base addresses.
+ */
+static int
+amd_read_peer_config(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	uint32_t info, peer_qps, peer_qsz, lo, hi;
+	int i;
+
+	info = amd_ntb_spad_read(dev, AMD_SPAD_CNT_INFO, 0);
+	peer_qps = (info >> 8) & 0xff;
+	if (peer_qps != ntb->queue_pairs) {
+		NTB_LOG(ERR, "Inconsistent number of queues! (local: %u peer: %u)",
+			ntb->queue_pairs, peer_qps);
+		return -EINVAL;
+	}
+
+	peer_qsz = amd_ntb_spad_read(dev, AMD_SPAD_QUEUE_SZ, 0);
+	if (peer_qsz != ntb->queue_size) {
+		NTB_LOG(ERR, "Inconsistent queue size! (local: %u peer: %u)",
+			ntb->queue_size, peer_qsz);
+		return -EINVAL;
+	}
+
+	ntb->peer_used_mws = (info >> 16) & 0xff;
+	for (i = 0; i < ntb->peer_used_mws; i++) {
+		lo = amd_ntb_spad_read(dev, AMD_SPAD_MW0_BA_L + 2 * i, 0);
+		hi = amd_ntb_spad_read(dev, AMD_SPAD_MW0_BA_H + 2 * i, 0);
+		ntb->peer_mw_base[i] = ((uint64_t)hi << 32) | lo;
+	}
+
+	return 0;
+}
+
+static void
+amd_ntb_dev_interrupt_handler(void *param)
+{
+	struct rte_rawdev *dev = (struct rte_rawdev *)param;
+	struct ntb_hw *ntb = dev->dev_private;
+	struct amd_ntb_hw *amd_hw = ntb->pmd_private;
+	uint32_t event, ack, info;
+	uint64_t db_bits;
+	uint32_t peer_mw_cnt;
+
+	db_bits = amd_ntb_db_read(dev);
+
+	/* Doorbell 0: peer device is ready. */
+	if (db_bits & 1) {
+		amd_ntb_db_clear(dev, 1);
+		if (ntb->peer_dev_up)
+			return;
+
+		info = amd_ntb_spad_read(dev, AMD_SPAD_CNT_INFO, 0);
+		peer_mw_cnt = info & 0xff;
+		if (peer_mw_cnt != ntb->mw_cnt) {
+			NTB_LOG(ERR, "Peer mw cnt %u != local mw cnt %u.",
+				peer_mw_cnt, ntb->mw_cnt);
+			return;
+		}
+
+		ntb->peer_dev_up = 1;
+
+		/* Re-run the handshake so the device that came up second does
+		 * not miss the first doorbell (scratchpad/mw programming only
+		 * takes effect once both sides are up).
+		 */
+		if (amd_dev_handshake(dev) < 0) {
+			NTB_LOG(ERR, "Handshake work failed.");
+			return;
+		}
+
+		(*ntb->ntb_ops->get_link_status)(dev);
+		NTB_LOG(INFO, "Peer device up. Link speed %u width %u.",
+			ntb->link_speed, ntb->link_width);
+		return;
+	}
+
+	/* Doorbell 1: peer device is going down. */
+	if (db_bits & (1 << 1)) {
+		NTB_LOG(INFO, "DB1: Peer device is down.");
+		amd_ntb_db_clear(dev, (1 << 1));
+		ntb->peer_dev_up = 0;
+		(*ntb->ntb_ops->peer_db_set)(dev, 2);
+		return;
+	}
+
+	/* Doorbell 2: peer acknowledged our device-down request. */
+	if (db_bits & (1 << 2)) {
+		NTB_LOG(INFO, "DB2: Peer agrees device to be down.");
+		amd_ntb_db_clear(dev, (1 << 2));
+		ntb->peer_dev_up = 0;
+		return;
+	}
+
+	/* Any remaining doorbells. */
+	if (db_bits)
+		amd_ntb_db_clear(dev, db_bits);
+
+	/* Handle link/power-management events and acknowledge the SMU. */
+	event = rte_read32((char *)amd_hw->self_mmio + AMD_INTSTAT_OFFSET);
+	event &= AMD_EVENT_INTMASK;
+	if (event == 0)
+		return;
+
+	switch (event) {
+	case AMD_PEER_FLUSH_EVENT:
+		NTB_LOG(INFO, "Peer flush event.");
+		break;
+	case AMD_PEER_D0_EVENT:
+		ack = rte_read32((char *)amd_hw->self_mmio + AMD_PMESTAT_OFFSET);
+		if (ack & 0x1)
+			NTB_LOG(INFO, "D0 wakeup completed for NTB.");
+		/* fall through to ack the SMU */
+		/* Falls through. */
+	case AMD_PEER_RESET_EVENT:
+	case AMD_LINK_DOWN_EVENT:
+	case AMD_PEER_D3_EVENT:
+	case AMD_PEER_PMETO_EVENT:
+	case AMD_LINK_UP_EVENT:
+		ack = rte_read32((char *)amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+		ack |= event;
+		rte_write32(ack, (char *)amd_hw->self_mmio + AMD_SMUACK_OFFSET);
+		break;
+	default:
+		NTB_LOG(ERR, "Unknown interrupt event 0x%" PRIx32, event);
+		break;
+	}
+}
+
+static uint64_t
+amd_ntb_get_mem_align(const struct rte_rawdev *dev __rte_unused,
+		      uint32_t mw_id __rte_unused, uint64_t mw_len)
+{
+	/* Base must be a power of two >= the window length, and >= 4K. */
+	return RTE_MAX((uint64_t)RTE_PGSIZE_4K, rte_align64pow2(mw_len));
+}
+
+const struct ntb_dev_ops amd_ntb_ops = {
+	.ntb_dev_init		= amd_ntb_dev_init,
+	.get_peer_mw_addr	= amd_ntb_get_peer_mw_addr,
+	.mw_set_trans		= amd_ntb_mw_set_trans,
+	.ioremap		= amd_ntb_ioremap,
+	.get_link_status	= amd_ntb_get_link_status,
+	.set_link		= amd_ntb_set_link,
+	.spad_read		= amd_ntb_spad_read,
+	.spad_write		= amd_ntb_spad_write,
+	.db_read		= amd_ntb_db_read,
+	.db_clear		= amd_ntb_db_clear,
+	.db_set_mask		= amd_ntb_db_set_mask,
+	.peer_db_set		= amd_ntb_peer_db_set,
+	.vector_bind		= amd_ntb_vector_bind,
+	.interrupt_handler	= amd_ntb_dev_interrupt_handler,
+	.dev_handshake		= amd_dev_handshake,
+	.read_peer_config	= amd_read_peer_config,
+	.mem_align		= amd_ntb_get_mem_align,
+};
diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
new file mode 100644
index 0000000000..dafd62e30b
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _NTB_HW_AMD_H_
+#define _NTB_HW_AMD_H_
+
+#include <stdint.h>
+
+/* NTB vendor and device IDs (EPYC Embedded Turin/Genoa/Siena). */
+#define NTB_AMD_VENDOR_ID		0x1022
+#define NTB_AMD_DEV_ID_PRI		0x14c0	/* Primary NTB endpoint. */
+#define NTB_AMD_DEV_ID_SEC		0x14c3	/* Secondary NTB endpoint. */
+
+/* Device data (spec Table 12). */
+#define AMD_MW_COUNT			2
+#define AMD_DB_COUNT			16
+#define AMD_SPAD_COUNT			16
+#define AMD_MSIX_VECTOR_COUNT		24
+
+/* Peer register window: peer register = primary offset + 0x400. */
+#define AMD_PEER_OFFSET			0x400
+
+/* Primary-side MMIO register offsets (BAR0), spec Table 1. */
+#define AMD_CNTL_OFFSET			0x200	/* Link Control. */
+#define AMD_SPADMUTEX_OFFSET		0x20C	/* Scratchpad mutex. */
+#define AMD_SPAD_OFFSET			0x210	/* Scratchpad registers. */
+#define AMD_SIDEINFO_OFFSET		0x408	/* Link Status (PSIDE_INFO). */
+#define AMD_BAR23_LIMIT_OFFSET		0x418	/* MW BAR23 size. */
+#define AMD_BAR45_LIMIT_OFFSET		0x420	/* MW BAR45 size. */
+#define AMD_BAR23_XLAT_OFFSET		0x438	/* MW BAR23 translation. */
+#define AMD_BAR45_XLAT_OFFSET		0x440	/* MW BAR45 translation. */
+#define AMD_DBFM_OFFSET			0x450	/* Doorbell flush mode. */
+#define AMD_DBREQ_OFFSET		0x454	/* Doorbell request. */
+#define AMD_DBMASK_OFFSET		0x45C	/* Doorbell mask. */
+#define AMD_DBSTAT_OFFSET		0x460	/* Doorbell status. */
+#define AMD_INTMASK_OFFSET		0x470	/* Interrupt mask. */
+#define AMD_INTSTAT_OFFSET		0x474	/* Interrupt status. */
+#define AMD_PMESTAT_OFFSET		0x480	/* PME status. */
+#define AMD_SMUACK_OFFSET		0x4A0	/* SMU control (PSMU_ACK). */
+
+/* Link Status Register (0x408) bits, spec Table 5. */
+#define AMD_SIDE_MASK			(1 << 0) /* 0: primary, 1: secondary. */
+#define AMD_SIDE_READY			(1 << 1) /* Side link ready. */
+
+/* Link Control Register (0x200) bits, spec Table 2. */
+#define AMD_SMM_REG_CTL			(1 << 20)
+#define AMD_PMM_REG_CTL			(1 << 21)
+
+/* Interrupt Status/Mask event bits, spec Table 7. */
+#define AMD_PEER_FLUSH_EVENT		(1 << 0)
+#define AMD_PEER_RESET_EVENT		(1 << 1)
+#define AMD_PEER_D3_EVENT		(1 << 2)
+#define AMD_PEER_PMETO_EVENT		(1 << 3)
+#define AMD_PEER_D0_EVENT		(1 << 4)
+#define AMD_LINK_UP_EVENT		(1 << 5)
+#define AMD_LINK_DOWN_EVENT		(1 << 6)
+#define AMD_EVENT_INTMASK		(AMD_PEER_FLUSH_EVENT | \
+					 AMD_PEER_RESET_EVENT | \
+					 AMD_PEER_D3_EVENT | \
+					 AMD_PEER_PMETO_EVENT | \
+					 AMD_PEER_D0_EVENT | \
+					 AMD_LINK_UP_EVENT | \
+					 AMD_LINK_DOWN_EVENT)
+
+/* PCIe link status decoding (link speed/width). */
+#define AMD_LNK_STA_SPEED_MASK		0x000f
+#define AMD_LNK_STA_WIDTH_MASK		0x03f0
+#define AMD_LNK_STA_SPEED(x)		((x) & AMD_LNK_STA_SPEED_MASK)
+#define AMD_LNK_STA_WIDTH(x)		(((x) & AMD_LNK_STA_WIDTH_MASK) >> 4)
+
+/* The 16-register scratchpad bank is shared between both sides (there is no
+ * separate peer-scratchpad window). It is split into two disjoint 8-register
+ * sets so each side owns one half (offset 0 for one side, 0x20 for the other)
+ * and no mutex is required. Because only 8 registers are available per side,
+ * the driver uses its own packed handshake layout instead of the built-in
+ * protocol.
+ */
+#define AMD_SPAD_SET_OFFSET		0x20
+#define AMD_SPAD_PER_SIDE		(AMD_SPAD_COUNT >> 1)
+
+/* Packed scratchpad handshake layout (indices within an 8-register set).
+ * Indices 6 and 7 are reserved for application user scratchpads.
+ */
+enum amd_spad_idx {
+	AMD_SPAD_CNT_INFO = 0,	/* num_mws | num_qps<<8 | used_mws<<16 */
+	AMD_SPAD_QUEUE_SZ,	/* queue_size */
+	AMD_SPAD_MW0_BA_L,	/* mw0 base address, low 32 bits */
+	AMD_SPAD_MW0_BA_H,	/* mw0 base address, high 32 bits */
+	AMD_SPAD_MW1_BA_L,	/* mw1 base address, low 32 bits */
+	AMD_SPAD_MW1_BA_H,	/* mw1 base address, high 32 bits */
+};
+
+enum amd_ntb_bar {
+	AMD_NTB_BAR23 = 2,
+	AMD_NTB_BAR45 = 4,
+};
+
+/* Hardware private data. */
+struct amd_ntb_hw {
+	void *self_mmio;	/* BAR0 primary register window. */
+	void *peer_mmio;	/* self_mmio + AMD_PEER_OFFSET. */
+
+	uint32_t self_spad;	/* Byte offset of local scratchpad set. */
+	uint32_t peer_spad;	/* Byte offset of peer scratchpad set. */
+
+	uint32_t int_mask;
+	uint32_t peer_status;
+	uint32_t ctl_status;
+};
+
+extern const struct ntb_dev_ops amd_ntb_ops;
+
+#endif /* _NTB_HW_AMD_H_ */
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index e72f238aba..cf5747b003 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -78,6 +78,8 @@
                  'SVendor': None, 'SDevice': None}
 intel_ntb_icx = {'Class': '06', 'Vendor': '8086', 'Device': '347e',
                  'SVendor': None, 'SDevice': None}
+amd_ntb = {'Class': '06', 'Vendor': '1022', 'Device': '14c0,14c3',
+           'SVendor': None, 'SDevice': None}
 
 cnxk_sso = {'Class': '08', 'Vendor': '177d', 'Device': 'a0f9,a0fa',
             'SVendor': None, 'SDevice': None}
@@ -105,7 +107,7 @@
 regex_devices = [cn9k_ree]
 ml_devices = [cnxk_ml]
 misc_devices = [cnxk_bphy, cnxk_bphy_cgx, cnxk_inl_dev,
-                intel_ntb_skx, intel_ntb_icx,
+                intel_ntb_skx, intel_ntb_icx, amd_ntb,
                 virtio_blk]
 
 # global dict ethernet devices present. Dictionary indexed by PCI address.
-- 
2.34.1

