Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE82606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I3wd6fHO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CCAA402DD;
	Mon, 26 Oct 2026 09:56:06 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by mails.dpdk.org (Postfix) with ESMTPS id C985E40150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:56:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GX7WCesHO3GbAVIhhTYR9KVRFuPIVARX6zajRmyVU3NZ/toKkh4fQeMpiKHurV0DvnLyRt/igkXmY1oYfSf11vENOgcOiF2VQayCgNzrlRvTUOwesINO7OY6VbPJP/7unKf8MEk1YsQ4rmARVLtuAGh4gbe08mj5ZIBIJR+GPts3L+73S89aiSscYDTFwXXKLLf+jnVbaEuahctlwzSmpOzomDdHKYji8y1ZlA9q0QnuZJ7raba1HDziqsrimtieyaSb2jSXgyv3xMj9qokI2UCndJZAcj3eX1wJMaV4y5SQ2Xi3ZHGO+63FSQqosBw72X+hoxcjCQtze+x6LCgAqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PBUHNasbyESGAQ6eguIPf1qof6dQplBHhRaAgq2MeA=;
 b=vFuj32SJzoCANwS6r9ClF0RoljaVKFWLkAEnUMQ2unaKDMDAtrft7mgG790duuri+eSM+v1vr9DNFKPM1Q7INE2DCwi+EnXfJXTbuJsz+7LM+SA+ws6J7DDDVJ5lvf3ZpExsYyYfD6romGcWl4UJbirjqA/C6WLJeLFKdQE0Z+WstzBTHB+I3rlk7KO0e1e4bKBVndIJZTLvbOkJ+zBh+A1qsOQmPKmpbQS/ZyMr1zleFT61bWPZIFhaJUe7pLcMbWYjL/exkoouaPaUVu2jT9kQXkp5cOy4WY7uG8gk0vKbCkuDFnCGApqVxICm93CkULPDodP6Ok3jsmhw6VZL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PBUHNasbyESGAQ6eguIPf1qof6dQplBHhRaAgq2MeA=;
 b=I3wd6fHOhG+2TUCbgmKbW2Ak95AKmvBVrQ1/+34pJIXTR3Y9TemG+Nq0JATo0+gEfSRU+ushCoWOUzX8zUrf5mjQUfgKcSDLkWk38cCy4zjst55/6U8pSAHobWKOVKP16vu6SazHppidN1EPJtKIK1InCrd6wFwenZjy6FcGABo=
Received: from SJ0PR13CA0100.namprd13.prod.outlook.com (2603:10b6:a03:2c5::15)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:56:00 +0000
Received: from CO1PEPF0001885C.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::23) by SJ0PR13CA0100.outlook.office365.com
 (2603:10b6:a03:2c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 08:55:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885C.mail.protection.outlook.com (10.167.249.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:55:59 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:55:56 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 3/3] raw/ntb: add AMD NTB support
Date: Mon, 26 Oct 2026 14:25:15 +0530
Message-ID: <20261026085515.3238805-4-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
References: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885C:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 551d7bd5-8691-42f7-5a12-08df333ef4c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|22082099003|18002099003|3023799007|56012099006|11063799006|5023799004|261021123027099003|10067099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003|261022113327099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: gymoCagtFYPdji29XkV3jW88J7tBZj4iasqW8ZPIvOBSK2ZybBuEFAiuevxtbA644RJXS+IA7hkOtxx9BM0FEkem7E1uqEqtnmLlqBSY//kRPqUseJOppT4zXBsyGXT4YV+hOsuY9wrd/H0qmByDXZXqsoQ9ty12R6NXOGYNgF8OMietBFzYSWqaZzPlKZ7zbrwkGD9/DiWMpngmwXXcaI/kLFZitPqDgReCx50URKM/0W/N1MMO/pqOmgQAoqqM7Rklt1AlAGppKXZOM0tmxeO+fVFq3DXn2H7Sm7RQdD18AmpO4LMALa8CRxYfTIpf6CV4+zr9ByME/EroUWz1RPmjCLdq4XYSe13v//dsKCAVgFpfio9GLePjE4KHzTaUDlgqSvydb0NCju3nLtgwK//lPS52yAogJ9u5JAuEUnh7nhHs9SwBXGizNqRSz0kCYta9n1k9L9vvzfIFNOxFJmtDsIpWBokDhR0JcsnsbcRcX4rPjHS6v1zWt919w+gwzWqOKng0LGHDQa2LKPOstsoKA6gGPLtJdp5jsh3cv36nY1Dn2+IZ2A6FhznOXS3RmrL3eHPY6GILWXWSN11S8DFpeao6ps96MH/mkVRWOE25R8ai2bYUsDO+znkBLuVwmYrOrHZiaHCxOPfe5GN7KQ6R4o6vuukM1d8qqeGEMoANgjhjLdDDjUh9WRYzEIyom8WRsfouf3/IJbNS8xt+pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(5023799004)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003)(261022113327099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1EBNPbuSD2gX2fRZtDWtq+MwP1PE6I05ztp6djX0YdYZ2VLyJQSWgxjVWpmc2zcywsl1WGaQvZ+S1kfvS2yjpD2R4Hxtn8HBFEldFkRuNvyUcwWwhWT6vZZnqjvFhVJavJN3iVb8ug/9ngGp7lwlW6N16WxOVXzt+v/QULzts7gxAsUiEtAF+LImmxswJGNjPEMkoNw5EHenJb1qtlMjA9wFhI6uGKsWTJ1OdQ609okHXyOLSxTbq1H+F61N6npO2d38WkS9aW9zFL+oxPAHfFDTPpyEsgXtttmiBySHQ0WCRoS2V40qNiAjZACdWfX94+4tSK4woEj8DAi858ckkddlwpjQY3ecX/nsoXv+59l0PsF5Voya/mYRZ3lW4duqZDR2STC6CmCB0jk6zSpDD0lR5z0LfUwtMv0GcShaFuuetxC5qvpxu7PyICpAejMg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:55:59.6040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551d7bd5-8691-42f7-5a12-08df333ef4c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the NTB endpoints integrated in AMD EPYC Embedded
"Turin", "Genoa" and "Siena" processors to the raw/ntb driver.

The AMD NTB uses a primary/secondary topology: one endpoint enumerates
as the primary (device ID 0x14c0) and the other as the secondary
(device ID 0x14c3). The hardware exposes two memory windows (BAR23 and
BAR45), 16 doorbells and a single shared 16-register scratchpad bank.
The scratchpad bank is split into two disjoint 8-register sets, one per
side, so the driver uses a packed handshake layout that fits in 8
registers, plugged in through the framework's dev_handshake,
peer_mw_validate, read_peer_config and link_cleanup ops. Vendor-specific
hardware (SMU) events are handled through the optional handle_hw_event
op, and a memory-window alignment helper through the mem_align op.

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
 MAINTAINERS                            |   2 +
 doc/guides/rawdevs/ntb.rst             |  31 +-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/raw/ntb/meson.build            |   7 +-
 drivers/raw/ntb/ntb.c                  |   7 +
 drivers/raw/ntb/ntb.h                  |   3 +
 drivers/raw/ntb/ntb_hw_amd.c           | 658 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 111 +++++
 usertools/dpdk-devbind.py              |   1 +
 9 files changed, 824 insertions(+), 4 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1720cff62e..cc86b35b29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1616,6 +1616,8 @@ F: doc/guides/rawdevs/cnxk_rvu_lf.rst
 
 NTB
 M: Jingjing Wu <jingjing.wu@intel.com>
+M: Bhagyada Modali <bhagyada.modali@amd.com>
+M: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
 F: drivers/raw/ntb/
 F: doc/guides/rawdevs/ntb.rst
 F: examples/ntb/
diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index 3721b4880e..db371f5728 100644
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
@@ -151,8 +177,9 @@ like the following:
 Limitation
 ----------
 
-This PMD is only supported on Intel Xeon Platforms:
+This PMD is supported on:
 
+- AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors.
 - 4th Generation Intel® Xeon® Scalable Processors.
 - 3rd Generation Intel® Xeon® Scalable Processors.
 - 2nd Generation Intel® Xeon® Scalable Processors.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 30f2f3009f..8a6977db33 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -264,6 +264,14 @@ New Features
   Added ``dpdk-validate-bpf`` tool to pre-validate eBPF programs
   for compatibility with the ``lib/bpf`` execution context.
 
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
index 9096f2b25a..24a46836aa 100644
--- a/drivers/raw/ntb/meson.build
+++ b/drivers/raw/ntb/meson.build
@@ -2,6 +2,9 @@
 # Copyright(c) 2019 Intel Corporation.
 
 deps += ['rawdev', 'mbuf', 'mempool', 'pci', 'bus_pci']
-sources = files('ntb.c',
-                'ntb_hw_intel.c')
+sources = files(
+        'ntb.c',
+        'ntb_hw_amd.c',
+        'ntb_hw_intel.c',
+)
 headers = files('rte_pmd_ntb.h')
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0e0cdf38e3..ac6abf566b 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -20,11 +20,14 @@
 #include <rte_rawdev_pmd.h>
 #include <eal_export.h>
 
+#include "ntb_hw_amd.h"
 #include "ntb_hw_intel.h"
 #include "rte_pmd_ntb.h"
 #include "ntb.h"
 
 static const struct rte_pci_id pci_id_ntb_map[] = {
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_PRI) },
+	{ RTE_PCI_DEVICE(NTB_AMD_VENDOR_ID, NTB_AMD_DEV_ID_SEC) },
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_SKX) },
 	{ RTE_PCI_DEVICE(NTB_INTEL_VENDOR_ID, NTB_INTEL_DEV_ID_B2B_ICX) },
 	{ .vendor_id = 0, /* sentinel */ },
@@ -1250,6 +1253,10 @@ ntb_init_hw(struct rte_rawdev *dev, struct rte_pci_device *pci_dev)
 	hw->link_width = NTB_WIDTH_NONE;
 
 	switch (pci_dev->id.device_id) {
+	case NTB_AMD_DEV_ID_PRI:
+	case NTB_AMD_DEV_ID_SEC:
+		hw->ntb_ops = &amd_ntb_ops;
+		break;
 	case NTB_INTEL_DEV_ID_B2B_SKX:
 	case NTB_INTEL_DEV_ID_B2B_ICX:
 		hw->ntb_ops = &intel_ntb_ops;
diff --git a/drivers/raw/ntb/ntb.h b/drivers/raw/ntb/ntb.h
index 546677a694..f6bfc6515e 100644
--- a/drivers/raw/ntb/ntb.h
+++ b/drivers/raw/ntb/ntb.h
@@ -42,6 +42,9 @@ enum ntb_topo {
 	NTB_TOPO_NONE = 0,
 	NTB_TOPO_B2B_USD,
 	NTB_TOPO_B2B_DSD,
+	/* Primary/secondary topology (e.g. AMD NTB). */
+	NTB_TOPO_PRI,
+	NTB_TOPO_SEC,
 };
 
 enum ntb_link {
diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
new file mode 100644
index 0000000000..3f83f2e15c
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -0,0 +1,658 @@
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
+	uint32_t sideinfo;
+	int i, bar;
+
+	if (ntb == NULL) {
+		NTB_LOG(ERR, "Invalid device.");
+		return -EINVAL;
+	}
+
+	ntb->hw_addr = (char *)ntb->pci_dev->mem_resource[0].addr;
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
+		return -ENOMEM;
+	}
+	for (i = 0; i < ntb->mw_cnt; i++) {
+		bar = amd_ntb_bar[i];
+		ntb->mw_size[i] = ntb->pci_dev->mem_resource[bar].len;
+		NTB_LOG(INFO, "mw[%d] bar%d size 0x%" PRIx64, i, bar,
+			ntb->mw_size[i]);
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
+	void *peer_mmio = AMD_PEER_MMIO(ntb);
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
+	rte_write64(addr, (char *)peer_mmio + xlat_off);
+	reg_val = rte_read64((char *)peer_mmio + xlat_off);
+	if (reg_val != addr) {
+		NTB_LOG(ERR, "Failed to set mw%d translation.", mw_idx);
+		rte_write64(0, (char *)peer_mmio + xlat_off);
+		return -EIO;
+	}
+
+	rte_write64(size, (char *)peer_mmio + limit_off);
+	reg_val = rte_read64((char *)peer_mmio + limit_off);
+	if (reg_val != size) {
+		NTB_LOG(ERR, "Failed to set mw%d limit.", mw_idx);
+		rte_write64(0, (char *)peer_mmio + xlat_off);
+		rte_write64(0, (char *)peer_mmio + limit_off);
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
+	uint16_t link_status = 0;
+	uint32_t sideinfo;
+	int ret;
+
+	/* The link is usable once the peer has set its SIDE_READY bit. */
+	sideinfo = rte_read32((char *)AMD_PEER_MMIO(ntb) + AMD_SIDEINFO_OFFSET);
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
+	void *mmio = ntb->hw_addr;
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
+	uint32_t offset;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad index.");
+		return 0;
+	}
+
+	offset = AMD_SPAD_BASE(ntb, peer);
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
+	uint32_t offset;
+
+	if (spad < 0 || spad >= ntb->spad_cnt) {
+		NTB_LOG(ERR, "Invalid scratchpad index.");
+		return -EINVAL;
+	}
+
+	offset = AMD_SPAD_BASE(ntb, peer);
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
+
+	return (uint64_t)rte_read16((char *)ntb->hw_addr +
+				    AMD_DBSTAT_OFFSET);
+}
+
+static int
+amd_ntb_db_clear(const struct rte_rawdev *dev, uint64_t db_bits)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+
+	rte_write16((uint16_t)db_bits, (char *)ntb->hw_addr +
+		    AMD_DBSTAT_OFFSET);
+
+	return 0;
+}
+
+static int
+amd_ntb_db_set_mask(const struct rte_rawdev *dev, uint64_t db_mask)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+
+	if (db_mask & ~ntb->db_valid_mask)
+		return -EINVAL;
+
+	ntb->db_mask |= db_mask;
+	rte_write16((uint16_t)ntb->db_mask, (char *)ntb->hw_addr +
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
+/* Check that the peer advertises the same number of memory windows. */
+static int
+amd_peer_mw_validate(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	uint32_t info, peer_mw_cnt;
+
+	info = amd_ntb_spad_read(dev, AMD_SPAD_CNT_INFO, 0);
+	peer_mw_cnt = info & 0xff;
+	if (peer_mw_cnt != ntb->mw_cnt) {
+		NTB_LOG(ERR, "Peer mw cnt %u != local mw cnt %u.",
+			peer_mw_cnt, ntb->mw_cnt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Tear down the local scratchpad and translations so the peer can no
+ * longer reach local memory.
+ */
+static void
+amd_link_cleanup(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	int i;
+
+	for (i = 0; i < ntb->spad_cnt; i++)
+		amd_ntb_spad_write(dev, i, 0, 0);
+
+	for (i = 0; i < ntb->used_mw_num; i++)
+		amd_ntb_mw_set_trans(dev, i, 0, 0);
+}
+
+/* Handle link/power-management events and acknowledge the SMU. Invoked from
+ * the common interrupt handler when no inter-device doorbell is pending.
+ */
+static void
+amd_handle_hw_event(const struct rte_rawdev *dev)
+{
+	struct ntb_hw *ntb = dev->dev_private;
+	uint32_t event, ack;
+
+	event = rte_read32((char *)ntb->hw_addr + AMD_INTSTAT_OFFSET);
+	event &= AMD_EVENT_INTMASK;
+	if (event == 0)
+		return;
+
+	switch (event) {
+	case AMD_PEER_FLUSH_EVENT:
+		NTB_LOG(INFO, "Peer flush event.");
+		break;
+	case AMD_PEER_D0_EVENT:
+		ack = rte_read32((char *)ntb->hw_addr + AMD_PMESTAT_OFFSET);
+		if (ack & 0x1)
+			NTB_LOG(INFO, "D0 wakeup completed for NTB.");
+		/* fall through to ack the SMU */
+		/* Falls through. */
+	case AMD_PEER_RESET_EVENT:
+	case AMD_LINK_DOWN_EVENT:
+	case AMD_PEER_D3_EVENT:
+	case AMD_PEER_PMETO_EVENT:
+	case AMD_LINK_UP_EVENT:
+		ack = rte_read32((char *)ntb->hw_addr + AMD_SMUACK_OFFSET);
+		ack |= event;
+		rte_write32(ack, (char *)ntb->hw_addr + AMD_SMUACK_OFFSET);
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
+	.dev_handshake		= amd_dev_handshake,
+	.peer_mw_validate	= amd_peer_mw_validate,
+	.read_peer_config	= amd_read_peer_config,
+	.link_cleanup		= amd_link_cleanup,
+	.mem_align		= amd_ntb_get_mem_align,
+	.handle_hw_event	= amd_handle_hw_event,
+};
diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
new file mode 100644
index 0000000000..48f0db1ad4
--- /dev/null
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -0,0 +1,111 @@
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
+/* Peer register window base, derived from the local BAR0 mapping. */
+#define AMD_PEER_MMIO(ntb)		RTE_PTR_ADD((ntb)->hw_addr, AMD_PEER_OFFSET)
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
+/* Byte offset of the scratchpad set owned by the local side (@p peer false)
+ * or the peer side (@p peer true). The primary owns offset 0, the secondary
+ * owns offset AMD_SPAD_SET_OFFSET.
+ */
+#define AMD_SPAD_BASE(ntb, peer) \
+	((((ntb)->topo == NTB_TOPO_PRI) == !!(peer)) ? AMD_SPAD_SET_OFFSET : 0)
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
+extern const struct ntb_dev_ops amd_ntb_ops;
+
+#endif /* _NTB_HW_AMD_H_ */
diff --git a/usertools/dpdk-devbind.py b/usertools/dpdk-devbind.py
index 78d841474f..15b19acb27 100755
--- a/usertools/dpdk-devbind.py
+++ b/usertools/dpdk-devbind.py
@@ -87,6 +87,7 @@
         'name': 'Misc (rawdev)',
         'match': [
             {'Class': '01', 'Vendor': '1af4', 'Device': '1001,1042'},  # VirtIO block
+            {'Class': '06', 'Vendor': '1022', 'Device': '14c0,14c3'},  # AMD NTB
             {'Class': '06', 'Vendor': '8086', 'Device': '201c'},  # Intel NTB Skylake
             {'Class': '06', 'Vendor': '8086', 'Device': '347e'},  # Intel NTB Ice Lake
             {'Class': '08', 'Vendor': '177d', 'Device': 'a059,a060'},  # Marvell CNXK BPHY CGX
-- 
2.34.1

