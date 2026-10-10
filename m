Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C44CA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:25:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40808402D5;
	Sat, 10 Oct 2026 11:25:44 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 652E94026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:25:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHTz2MBMpq+6ZDCg--.21650S3;
 Sat, 10 Oct 2026 17:25:40 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org, liufeng1 <liufeng1@sugon.com>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 1/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Date: Sat, 10 Oct 2026 17:25:25 +0800
Message-ID: <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261010092525.2025485-1-liujie5@linkdatatechnology.com>
References: <20261010092525.2025485-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTz2MBMpq+6ZDCg--.21650S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1rur1UXr1rtw15ZF45GFg_yoW5Kr1rpF
 W093yUAry8tayxJw1kZw1UZFyrJ3Z7Aa4jkF1ru3sIgrsFkry09Fy3KF9xGw4YkFWUXF9F
 v3Z8JryDKFW8Gw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBa14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1Y6r1xM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84
 ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
 IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
 Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42xK82
 IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
 0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
 IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
 0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
 Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUPcTPUUUUU=
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

This is a generic mechanism: any PCI driver whose underlying kernel
driver uses an identity IOMMU domain can set the flag.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/bus/pci/bus_pci_driver.h | 2 ++
 drivers/bus/pci/linux/pci.c      | 4 ++++
 drivers/bus/pci/pci_common.c     | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index bcf0a409da..bf7125e214 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -609,6 +609,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 			iova_mode = RTE_IOVA_PA;
 		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_VA) != 0)
 			iova_mode = RTE_IOVA_VA;
+		else if ((pdrv->drv_flags & RTE_PCI_DRV_NEED_IOVA_AS_PA) != 0)
+			iova_mode = RTE_IOVA_PA;
 		break;
 	}
 
@@ -620,6 +622,8 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
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

