Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78428CD3427
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:31:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B0874066C;
	Wed,  6 May 2026 05:31:36 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id ED28C402A7
 for <dev@dpdk.org>; Wed,  6 May 2026 05:31:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADnkW0RtvppJvJlDw--.46692S8;
 Wed, 06 May 2026 11:31:31 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 06/10] common/sxe2: add ioctl interface for DMA map and
 unmap
Date: Wed,  6 May 2026 11:31:18 +0800
Message-ID: <20260506033123.726997-7-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506033123.726997-1-liujie5@linkdatatechnology.com>
References: <20260506021233.661892-11-liujie5@linkdatatechnology.com>
 <20260506033123.726997-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADnkW0RtvppJvJlDw--.46692S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKFWrGF4xJFW5ZFWxtF1UJrb_yoWxGF1UpF
 40gFyYqFy8ta1agF1UJw42q345Kw4Fg39rCFWxGwn3KF1qvrykZa1FgFy3Jw15CrW3JF93
 AFsIkF45Cr18WrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUwqXdUUUUU=
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

From: Jie Liu <liujie5@linkdatatechnology.com>

Implement DMA mapping and unmapping functionality using ioctl
calls. This allows the driver to configure the hardware's IOMMU/DMA
tables, ensuring the device can safely access memory buffers
allocated by the userspace.

The mapping is established during device initialization or queue
setup and is revoked during device closure to prevent memory
leaks and ensure hardware security.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c          |  48 ++++++++++
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 104 +++++++++++++++++++++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   9 ++
 3 files changed, 161 insertions(+)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index dfdefb8b78..537d4e9f6a 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -466,12 +466,60 @@ static s32 sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
 	return ret;
 }
 
+static s32 sxe2_common_pci_dma_map(struct rte_pci_device *pci_dev,
+		void *addr,	u64 iova, size_t len)
+{
+	struct sxe2_common_device *cdev;
+	s32 ret = SXE2_ERROR;
+
+	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
+	if (cdev == NULL) {
+		ret = SXE2_ERR_NODEV;
+		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_dma_map(cdev, (u64)(uintptr_t)addr, iova, len);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to dma map, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static s32 sxe2_common_pci_dma_unmap(struct rte_pci_device *pci_dev,
+		void *addr __rte_unused, u64 iova, size_t len __rte_unused)
+{
+	struct sxe2_common_device *cdev;
+	s32 ret = SXE2_ERROR;
+
+	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
+	if (cdev == NULL) {
+		ret = SXE2_ERR_NODEV;
+		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_dma_unmap(cdev, iova);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to dma map, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
 static struct rte_pci_driver sxe2_common_pci_driver = {
 	.driver = {
 		   .name = SXE2_COMMON_PCI_DRIVER_NAME,
 	},
 	.probe = sxe2_common_pci_probe,
 	.remove = sxe2_common_pci_remove,
+	.dma_map = sxe2_common_pci_dma_map,
+	.dma_unmap = sxe2_common_pci_dma_unmap,
 };
 
 static u32 sxe2_common_pci_id_table_size_get(const struct rte_pci_id *id_table)
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 2bd7c2b2eb..1a14d401e7 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -220,3 +220,107 @@ sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len)
 l_end:
 	return ret;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_map)
+s32
+sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, u64 vaddr,
+			u64 iova, u64 size)
+{
+	struct sxe2_ioctl_iommu_dma_map cmd_params;
+	enum rte_iova_mode iova_mode;
+	s32 ret = SXE2_SUCCESS;
+	s32 cmd_fd = 0;
+
+	if (cdev->config.kernel_reset) {
+		ret = SXE2_ERR_PERM;
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_end;
+	}
+
+	iova_mode = rte_eal_iova_mode();
+	if (iova_mode == RTE_IOVA_PA) {
+		if (cdev->config.support_iommu) {
+			PMD_LOG_ERR(COM, "iommu not support pa mode");
+			ret = SXE2_ERR_IO;
+		}
+		goto l_end;
+	} else if (iova_mode == RTE_IOVA_VA) {
+		if (!cdev->config.support_iommu) {
+			PMD_LOG_ERR(COM, "no iommu not support va mode, plese use pa mode.");
+			ret = SXE2_ERR_IO;
+			goto l_end;
+		}
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = SXE2_ERR_BADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_iommu_dma_map));
+	cmd_params.vaddr = vaddr;
+	cmd_params.iova = iova;
+	cmd_params.size = size;
+
+	rte_ticketlock_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_MAP, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to dma map, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = SXE2_ERR_IO;
+		rte_ticketlock_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	rte_ticketlock_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_unmap)
+s32
+sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, u64 iova)
+{
+	s32 ret = SXE2_SUCCESS;
+	s32 cmd_fd = 0;
+	struct sxe2_ioctl_iommu_dma_unmap cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = SXE2_ERR_PERM;
+		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		goto l_end;
+	}
+
+	if (!cdev->config.support_iommu)
+		return SXE2_SUCCESS;
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = SXE2_ERR_BADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "fd %d dma unmap iova=0x%"PRIX64"",
+		cmd_fd, iova);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_iommu_dma_unmap));
+	cmd_params.iova = iova;
+
+	rte_ticketlock_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_UNMAP, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_INFO(COM, "Failed to dma unmap, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = SXE2_ERR_IO;
+		rte_ticketlock_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	rte_ticketlock_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
index 376c5e3ac7..e8f983e40e 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -47,6 +47,15 @@ __rte_internal
 s32
 sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len);
 
+__rte_internal
+s32
+sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, u64 vaddr,
+		u64 iova, u64 size);
+
+__rte_internal
+s32
+sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, u64 iova);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.3

