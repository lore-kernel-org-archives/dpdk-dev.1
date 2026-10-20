Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D6E606A319
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 11:50:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB7874068A;
	Tue, 20 Oct 2026 13:50:50 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 813FF4067A
 for <dev@dpdk.org>; Tue, 20 Oct 2026 13:50:44 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACnfvKQVddqOvROCw--.22022S2;
 Tue, 20 Oct 2026 19:50:41 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	liufeng1 <liufeng1@sugon.com>
Subject: [PATCH v1 0/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Date: Tue, 20 Oct 2026 19:50:37 +0800
Message-Id: <20261020115038.2832246-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
References: <20260626064954.361771-1-liujie5@linkdatatechnology.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACnfvKQVddqOvROCw--.22022S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1xKF18Aw17Kr4xGF43Awb_yoW8WrWrpF
 y3W3yYy3ykt3yIy3ZxZw18uFyrJan7Aa4UKF15Gw15uws09ry0qry7KasIgw4YkayxWF9F
 9rs8Xr1DKF18AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgJDGDUUUU
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

