Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EEFC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 09:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB99D40E15;
	Thu, 12 Jun 2025 10:59:32 +0200 (CEST)
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com
 [115.124.28.148])
 by mails.dpdk.org (Postfix) with ESMTP id 619B540DDA
 for <dev@dpdk.org>; Thu, 12 Jun 2025 10:59:22 +0200 (CEST)
Received: from localhost.localdomain(mailfrom:kyo.liu@nebula-matrix.com
 fp:SMTPD_---.dJxInHr_1749718760 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 12 Jun 2025 16:59:20 +0800
From: Kyo Liu <kyo.liu@nebula-matrix.com>
To: kyo.liu@nebula-matrix.com,
	dev@dpdk.org
Cc: Chenbo Xia <chenbox@nvidia.com>,
	Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v1 10/17] =?UTF-8?q?net/nbl:=20=C2=A0bus/pci:=20introduce?=
 =?UTF-8?q?=20get=5Fiova=5Fmode=20for=20pci=20dev?=
Date: Thu, 12 Jun 2025 08:58:31 +0000
Message-ID: <20250612085840.729830-11-kyo.liu@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
References: <20250612085840.729830-1-kyo.liu@nebula-matrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I propose this patch for DPDK to enable coexistence between
DPDK and kernel drivers for regular NICs.This solution requires
adding a new pci_ops in rte_pci_driver, through which DPDK will
retrieve the required IOVA mode from the vendor driver.
This mechanism is necessary to handle different IOMMU
configurations and operating modes. Below is a detailed
analysis of various scenarios:

1. When IOMMU is enabled:
1.1 With PT (Pass-Through) enabled:
In this case, the domain type is IOMMU_DOMAIN_IDENTITY,
which prevents vendor drivers from setting IOVA->PA mapping tables.
Therefore, DPDK must use PA mode. To achieve this:
The vendor kernel driver will register a character device (cdev) to
communicate with DPDK. This cdev handles device operations
(open, mmap, etc.) and ultimately
programs the hardware registers.

1.2 With PT disabled:
Here, the vendor driver doesn't enforce specific IOVA mode requirements.
Our implementation will:
Integrate a mediated device (mdev) in the vendor driver.
This mdev interacts with DPDK and manages IOVA->PA mapping configurations.

2. When IOMMU is disabled:
The vendor driver mandates PA mode (consistent with DPDK's PA mode
requirement in this scenario).
A character device (cdev) will similarly be registered for DPDK
communication.

Summary:
The solution leverages multiple technologies:
mdev for IOVA management when IOMMU is partially enabled.
VFIO for device passthrough operations.
cdev for register programming coordination.
A new pci_ops interface in DPDK to dynamically determine IOVA modes.
This architecture enables clean coexistence by establishing standardized
communication channels between DPDK and vendor drivers across different
IOMMU configurations.

Motivation for the Patch:
This patch is introduced to prepare for the upcoming open-source
contribution of our NebulaMatrix SNIC driver to DPDK. We aim to
ensure that our SNIC can seamlessly coexist with kernel drivers
using this mechanism. By adopting the proposed
architecture—leveraging dynamic IOVA mode negotiation via pci_ops,
mediated devices (mdev), and character device (cdev)
interactions—we enable our SNIC to operate in hybrid environments
here both DPDK and kernel drivers may manage the same hardware.
This design aligns with DPDK’s scalability goals and ensures
compatibility across diverse IOMMU configurations, which is critical
for real-world deployment scenarios.

Signed-off-by: Kyo Liu <kyo.liu@nebula-matrix.com>
---
 doc/guides/rel_notes/release_25_07.rst |  5 +++++
 drivers/bus/pci/bus_pci_driver.h       | 11 +++++++++++
 drivers/bus/pci/linux/pci.c            |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 9afc4520a6..a282b3e5a9 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,11 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added get_iova_mode for rte_pci_driver.**
+
+  Introduce `pci_get_iova_mode` rte_pci_ops for `pci_get_iova_mode`
+  to PCI bus so that PCI drivers could get their wanted iova_mode
+
 * **Added PMU library.**
 
   Added a Performance Monitoring Unit (PMU) library which allows Linux applications
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 2cc1119072..e5e36b0a5c 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -125,6 +125,16 @@ typedef int (pci_dma_map_t)(struct rte_pci_device *dev, void *addr,
 typedef int (pci_dma_unmap_t)(struct rte_pci_device *dev, void *addr,
 			      uint64_t iova, size_t len);
 
+/**
+ * retrieve the required IOVA mode from the vendor driver
+ *
+ * @param dev
+ *   Pointer to the PCI device.
+ * @return
+ *   - rte_iova_mode
+ */
+typedef int (pci_get_iova_mode)(const struct rte_pci_device *pdev);
+
 /**
  * A structure describing a PCI driver.
  */
@@ -136,6 +146,7 @@ struct rte_pci_driver {
 	pci_dma_map_t *dma_map;		   /**< device dma map function. */
 	pci_dma_unmap_t *dma_unmap;	   /**< device dma unmap function. */
 	const struct rte_pci_id *id_table; /**< ID table, NULL terminated. */
+	pci_get_iova_mode *get_iova_mode;  /**< Device get iova_mode function */
 	uint32_t drv_flags;                /**< Flags RTE_PCI_DRV_*. */
 };
 
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index c20d159218..fd69a02989 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -624,6 +624,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 	default:
 		if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
 			iova_mode = RTE_IOVA_VA;
+		else if (pdrv->get_iova_mode)
+			iova_mode = pdrv->get_iova_mode(pdev);
 		break;
 	}
 	return iova_mode;
-- 
2.43.0

