Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3AE606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 12:03:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3CA040659;
	Tue, 20 Oct 2026 14:03:29 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB6F40658
 for <dev@dpdk.org>; Tue, 20 Oct 2026 14:03:28 +0200 (CEST)
Received: from mail.cstnet.cn (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowACHWOyFWNdqITRPCw--.19230S2;
 Tue, 20 Oct 2026 20:03:19 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v2 0/1] bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag
Date: Tue, 20 Oct 2026 20:03:09 +0800
Message-Id: <20261020120310.2835867-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
References: <20261010092525.2025485-2-liujie5@linkdatatechnology.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHWOyFWNdqITRPCw--.19230S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGry8KFyfCFyDKw1xZrb_yoW8CrWrpF
 yjg3yYk3ykt3yxA3W3Zw18Ca4rAan7Aa4UGF15G3sxuws8ury0qry7KasIgw4jkay7WF9F
 9w4DXw1qgF15XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOa0PDUUUU
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

From: Jie Liu <liujie5@linkdatatechnology.com>

V2:
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

liufeng1 (1):
  bus/pci: add RTE_PCI_DRV_NEED_IOVA_AS_PA flag

 drivers/bus/pci/bus_pci_driver.h |  2 ++
 drivers/bus/pci/linux/pci.c      | 13 +++++++++++++
 drivers/bus/pci/pci_common.c     |  3 +--
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.52.0

