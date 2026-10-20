Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3E606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:03:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47CB740283;
	Tue, 20 Oct 2026 14:03:27 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9BFD940144
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:03:25 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACHWOyFWNdqITRPCw--.19230S3;
 Tue, 20 Oct 2026 20:03:20 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org, liufeng1 <liufeng1@sugon.com>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 1/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Date: Tue, 20 Oct 2026 20:03:10 +0800
Message-Id: <20261020120310.2835867-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020120310.2835867-1-liujie5@linkdatatechnology.com>
References: <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
 <20261020120310.2835867-1-liujie5@linkdatatechnology.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHWOyFWNdqITRPCw--.19230S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rur1UXr1rtw15ZF45GFg_yoWrCFWrpF
 Wj93yDAr18tayxJwn7Zr4DAa4rJ3Z7Aa4jkF15Z3sIgr4qkry0gF97KF9xGw4YyFWUXF9F
 v3Z8Jrn0gF45Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXjjgUUUUU=
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: liufeng1 <liufeng1@sugon.com>

Add a new PCI driver flag, RTE_PCI_DRV_NEED_IOVA_AS_PA, that allows a
driver to tell the PCI bus layer it cannot work with IOVA as VA and
must use IOVA as PA.

The existing RTE_PCI_DRV_NEED_IOVA_AS_VA flag already provides the
opposite requirement. Some PCI devices, however, are managed by a
kernel driver that uses an identity-mapped IOMMU domain (e.g. when the
		kernel is booted with iommu=pt). The user-space PMD for such devices
must use IOVA as PA, because the DMA addresses programmed by DPDK must
match the identity mapping programmed by the kernel driver.

Without this flag, a PCI driver bound to a non-VFIO/UIO kernel driver
has no way to force IOVA as PA. pci_device_iova_mode() returns
RTE_IOVA_DC for those devices, and rte_eal_init() then sees an enabled
IOMMU and selects RTE_IOVA_VA, which breaks identity-domain PMDs and
forces users to pass --iova-mode=pa on the command line.

When RTE_PCI_DRV_NEED_IOVA_AS_PA is set, pci_device_iova_mode()
returns RTE_IOVA_PA for the device. The requirement is propagated
through rte_pci_get_iommu_class() to rte_bus_get_iommu_class(), so
rte_eal_init() selects IOVA as PA automatically.

If a driver sets both RTE_PCI_DRV_NEED_IOVA_AS_VA and
RTE_PCI_DRV_NEED_IOVA_AS_PA at the same time, a warning is emitted
and the conflicting requirement is ignored (RTE_IOVA_DC), because
the two flags are mutually exclusive.

This is a generic mechanism: any PCI driver whose underlying kernel
driver uses an identity IOMMU domain can set the flag.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/bus/pci/bus_pci_driver.h |  2 ++
 drivers/bus/pci/linux/pci.c      | 13 +++++++++++++
 drivers/bus/pci/pci_common.c     |  3 +--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index c04ebddf59..5d5efbbb3e 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -140,6 +140,8 @@ struct rte_pci_driver {
 #define RTE_PCI_DRV_KEEP_MAPPED_RES 0x0020
 /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
 #define RTE_PCI_DRV_NEED_IOVA_AS_VA 0x0040
+/** Device driver needs IOVA as PA and cannot work with IOVA as VA */
+#define RTE_PCI_DRV_NEED_IOVA_AS_PA 0x0080
 
 /**
  * Register a PCI driver.
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index bcf0a409da..4e03d81ed2 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -595,6 +595,15 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 {
 	enum rte_iova_mode iova_mode = RTE_IOVA_DC;
 
+	if ((pdrv->drv_flags &
+		(RTE_PCI_DRV_NEED_IOVA_AS_VA | RTE_PCI_DRV_NEED_IOVA_AS_PA)) ==
+		(RTE_PCI_DRV_NEED_IOVA_AS_VA | RTE_PCI_DRV_NEED_IOVA_AS_PA)) {
+		RTE_LOG(WARNING, EAL,
+				"PCI driver '%s' sets both NEED_IOVA_AS_VA and NEED_IOVA_AS_PA flags, ignoring\n",
+				pdrv->driver.name);
+		return iova_mode;
+	}
+
 	switch (pdev->kdrv) {
 	case RTE_PCI_KDRV_VFIO: {
 		static int is_vfio_noiommu_enabled = -1;
@@ -609,6 +618,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 			iova_mode = RTE_IOVA_PA;
 		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
 			iova_mode = RTE_IOVA_VA;
+		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_PA) != 0)
+			iova_mode = RTE_IOVA_PA;
 		break;
 	}
 
@@ -620,6 +631,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 	default:
 		if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
 			iova_mode = RTE_IOVA_VA;
+		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_PA) != 0)
+			iova_mode = RTE_IOVA_PA;
 		break;
 	}
 	return iova_mode;
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index dc8db80d3b..9893306c8e 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -533,8 +533,7 @@ rte_pci_get_iommu_class(void)
 			iommu_no_va = pci_device_iommu_support_va(dev)
 					? 0 : 1;
 
-		if (dev->kdrv == RTE_PCI_KDRV_UNKNOWN ||
-		    dev->kdrv == RTE_PCI_KDRV_NONE)
+		if (dev->kdrv == RTE_PCI_KDRV_NONE)
 			continue;
 		RTE_BUS_FOREACH_DRV(drv, &rte_pci_bus) {
 			enum rte_iova_mode dev_iova_mode;
-- 
2.52.0

