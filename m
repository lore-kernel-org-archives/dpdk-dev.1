Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CACA6017
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 09:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40E88402A4;
	Sat, 10 Oct 2026 11:25:38 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id D518B4026D
 for <dev@dpdk.org>; Sat, 10 Oct 2026 11:25:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHTz2MBMpq+6ZDCg--.21650S2;
 Sat, 10 Oct 2026 17:25:34 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	liufeng1 <liufeng1@sugon.com>
Subject: [PATCH v1 0/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Date: Sat, 10 Oct 2026 17:25:24 +0800
Message-ID: <20261010092525.2025485-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHTz2MBMpq+6ZDCg--.21650S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1xKF18Aw17Kr4xGF43Awb_yoW8WrWrpF
 y3W3yYy3ykt3yIy3ZxZw18uFyrJan7Aa4UKF15Gw15uws09ry0qry7KasIgw4YkayxWF9F
 9rs8Xr1DKF18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
 AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5d5r3UUUUU==
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

This series adds a new PCI driver flag, RTE_PCI_DRV_NEED_IOVA_AS_PA,
which allows a PCI driver to tell the PCI bus layer that it cannot work
with IOVA as VA and must use IOVA as PA.

The existing RTE_PCI_DRV_NEED_IOVA_AS_VA flag already provides the
opposite requirement. Some PCI devices, however, are managed by a kernel
driver that uses an identity-mapped IOMMU domain (e.g. when the kernel
is booted with iommu=pt). The user-space PMD for such devices must use
IOVA as PA, because the DMA addresses programmed by DPDK must match the
identity mapping programmed by the kernel driver.

Without this flag, a PCI driver bound to a non-VFIO/UIO kernel driver
has no way to force IOVA as PA. pci_device_iova_mode() returns
RTE_IOVA_DC for those devices, and rte_eal_init() then sees an enabled
IOMMU and selects RTE_IOVA_VA, which breaks identity-domain PMDs and
forces users to pass --iova-mode=pa on the command line.

When RTE_PCI_DRV_NEED_IOVA_AS_PA is set, pci_device_iova_mode() returns
RTE_IOVA_PA for the device. The requirement is propagated through
rte_pci_get_iommu_class() to rte_bus_get_iommu_class(), so
rte_eal_init() selects IOVA as PA automatically.

This is a generic mechanism: any PCI driver whose underlying kernel
driver uses an identity IOMMU domain can set the flag.

liufeng1 (1):
  bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag

 drivers/bus/pci/bus_pci_driver.h | 2 ++
 drivers/bus/pci/linux/pci.c      | 4 ++++
 drivers/bus/pci/pci_common.c     | 3 +--
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.52.0

