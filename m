Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B03CCD193
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 02:37:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B22764067C;
	Thu, 16 Oct 2025 04:37:58 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 45E2A40269
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:37:56 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=C1cJIjbWhS2zWvEX5kNaN6sWk7Zkd2gOlLtWFIh6k4I=;
 b=FShKOlfdTvMIighD2OFqV6monDr72Ruw/H/GibujFOXcJ/X9H+SSlljhDJaQXjnfBlH9KHy0+
 5prFVAnlMF4IpNGcvUhKpewBckPopcdsbTR4pScc/tUPBDGLxOR7p7d4j8++5aMPz9ikeaO3cok
 2snwQSjON3q6fe9YPPOzs+s=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cnBv05vtKzRhsB;
 Thu, 16 Oct 2025 10:37:32 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id B8C971400CD;
 Thu, 16 Oct 2025 10:37:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Oct 2025 10:37:53 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] dma/hisi_pciep: rename hisilicon driver
Date: Thu, 16 Oct 2025 10:37:47 +0800
Message-ID: <20251016023747.18871-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

The original hisilicon DMA driver correspond to the internal DMA unit of
Kunpeng SoC PCIe subsystem. This commit renames it to hisi_pciep (PCIe
internal endpoint) to reflect hardware IP.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 MAINTAINERS                                        |  6 +++---
 .../dmadevs/{hisilicon.rst => hisi_pciep.rst}      | 14 +++++++-------
 doc/guides/dmadevs/index.rst                       |  2 +-
 doc/guides/rel_notes/release_25_11.rst             |  4 ++++
 .../hisi_pciep_dmadev.c}                           |  8 ++++----
 .../hisi_pciep_dmadev.h}                           |  0
 drivers/dma/{hisilicon => hisi_pciep}/meson.build  |  2 +-
 drivers/dma/meson.build                            |  2 +-
 8 files changed, 21 insertions(+), 17 deletions(-)
 rename doc/guides/dmadevs/{hisilicon.rst => hisi_pciep.rst} (72%)
 rename drivers/dma/{hisilicon/hisi_dmadev.c => hisi_pciep/hisi_pciep_dmadev.c} (99%)
 rename drivers/dma/{hisilicon/hisi_dmadev.h => hisi_pciep/hisi_pciep_dmadev.h} (100%)
 rename drivers/dma/{hisilicon => hisi_pciep}/meson.build (93%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..92be9a5d1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1361,10 +1361,10 @@ M: Conor Walsh <conor.walsh@intel.com>
 F: drivers/dma/ioat/
 F: doc/guides/dmadevs/ioat.rst
 
-HiSilicon DMA
+HiSilicon PCIEP DMA
 M: Chengwen Feng <fengchengwen@huawei.com>
-F: drivers/dma/hisilicon/
-F: doc/guides/dmadevs/hisilicon.rst
+F: drivers/dma/hisi_pciep/
+F: doc/guides/dmadevs/hisi_pciep.rst
 
 Marvell CNXK DPI DMA
 M: Vamsi Attunuru <vattunuru@marvell.com>
diff --git a/doc/guides/dmadevs/hisilicon.rst b/doc/guides/dmadevs/hisi_pciep.rst
similarity index 72%
rename from doc/guides/dmadevs/hisilicon.rst
rename to doc/guides/dmadevs/hisi_pciep.rst
index 974bc49376..9e9166648e 100644
--- a/doc/guides/dmadevs/hisilicon.rst
+++ b/doc/guides/dmadevs/hisi_pciep.rst
@@ -1,11 +1,11 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
     Copyright(c) 2021 HiSilicon Limited.
 
-HISILICON Kunpeng DMA Driver
-============================
+HISILICON PCIEP DMA Driver
+==========================
 
-Kunpeng SoC has an internal DMA unit which can be used by application
-to accelerate data copies.
+Kunpeng SoC PCIE subsystem has an internal DMA unit which can be used by
+application to accelerate data copies.
 The DMA PF function supports multiple DMA channels.
 
 
@@ -18,8 +18,8 @@ Supported Kunpeng SoCs
 Device Setup
 -------------
 
-Kunpeng DMA devices will need to be bound to a suitable DPDK-supported
-user-space IO driver such as ``vfio-pci`` in order to be used by DPDK.
+This device needs to be bound to a suitable DPDK-supported user-space IO
+driver such as ``vfio-pci`` in order to be used by DPDK.
 
 Device Probing and Initialization
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -35,7 +35,7 @@ and the 2nd ``dmadev`` name is "0000:7b:00.0-ch1".
 Device Configuration
 ~~~~~~~~~~~~~~~~~~~~~
 
-Kunpeng DMA configuration requirements:
+Configuration requirements:
 
 * ``ring_size`` must be a power of two, between 32 and 8192.
 * Only one ``vchan`` is supported per ``dmadev``.
diff --git a/doc/guides/dmadevs/index.rst b/doc/guides/dmadevs/index.rst
index 15ddaf5192..2ddcced09c 100644
--- a/doc/guides/dmadevs/index.rst
+++ b/doc/guides/dmadevs/index.rst
@@ -14,7 +14,7 @@ an application through DMA API.
    cnxk
    dpaa
    dpaa2
-   hisilicon
+   hisi_pciep
    idxd
    ioat
    odm
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 3c32b26e3b..eb5c048d5b 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -87,6 +87,10 @@ New Features
   * Added multi-process per port.
   * Optimized code.
 
+* **Rename hisilicon DMA driver to hisi_pciep DMA driver.**
+
+  * Rename to hisi_pciep (PCIe internal endpoint) to reflect hardware IP.
+
 * **Allow overriding the automatic usage/help generation in argparse library.**
 
   The argparse library now supports overriding the automatic help text generation,
diff --git a/drivers/dma/hisilicon/hisi_dmadev.c b/drivers/dma/hisi_pciep/hisi_pciep_dmadev.c
similarity index 99%
rename from drivers/dma/hisilicon/hisi_dmadev.c
rename to drivers/dma/hisi_pciep/hisi_pciep_dmadev.c
index 7575fb12d9..13c14833be 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.c
+++ b/drivers/dma/hisi_pciep/hisi_pciep_dmadev.c
@@ -15,7 +15,7 @@
 #include <rte_pci.h>
 #include <rte_dmadev_pmd.h>
 
-#include "hisi_dmadev.h"
+#include "hisi_pciep_dmadev.h"
 
 RTE_LOG_REGISTER_DEFAULT(hisi_dma_logtype, INFO);
 #define RTE_LOGTYPE_HISI_DMA hisi_dma_logtype
@@ -992,6 +992,6 @@ static struct rte_pci_driver hisi_dma_pmd_drv = {
 	.remove    = hisi_dma_remove,
 };
 
-RTE_PMD_REGISTER_PCI(dma_hisilicon, hisi_dma_pmd_drv);
-RTE_PMD_REGISTER_PCI_TABLE(dma_hisilicon, pci_id_hisi_dma_map);
-RTE_PMD_REGISTER_KMOD_DEP(dma_hisilicon, "vfio-pci");
+RTE_PMD_REGISTER_PCI(dma_hisi_pciep, hisi_dma_pmd_drv);
+RTE_PMD_REGISTER_PCI_TABLE(dma_hisi_pciep, pci_id_hisi_dma_map);
+RTE_PMD_REGISTER_KMOD_DEP(dma_hisi_pciep, "vfio-pci");
diff --git a/drivers/dma/hisilicon/hisi_dmadev.h b/drivers/dma/hisi_pciep/hisi_pciep_dmadev.h
similarity index 100%
rename from drivers/dma/hisilicon/hisi_dmadev.h
rename to drivers/dma/hisi_pciep/hisi_pciep_dmadev.h
diff --git a/drivers/dma/hisilicon/meson.build b/drivers/dma/hisi_pciep/meson.build
similarity index 93%
rename from drivers/dma/hisilicon/meson.build
rename to drivers/dma/hisi_pciep/meson.build
index 1098539e20..35944464c6 100644
--- a/drivers/dma/hisilicon/meson.build
+++ b/drivers/dma/hisi_pciep/meson.build
@@ -15,7 +15,7 @@ endif
 
 deps += ['bus_pci', 'dmadev']
 sources = files(
-        'hisi_dmadev.c',
+        'hisi_pciep_dmadev.c',
 )
 
 require_iova_in_mbuf = false
diff --git a/drivers/dma/meson.build b/drivers/dma/meson.build
index 358132759a..4f82a306bf 100644
--- a/drivers/dma/meson.build
+++ b/drivers/dma/meson.build
@@ -5,7 +5,7 @@ drivers = [
         'cnxk',
         'dpaa',
         'dpaa2',
-        'hisilicon',
+        'hisi_pciep',
         'idxd',
         'ioat',
         'odm',
-- 
2.17.1

