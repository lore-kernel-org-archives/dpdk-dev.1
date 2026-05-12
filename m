Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A20CD4F21
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 May 2026 11:37:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B105840611;
	Tue, 12 May 2026 13:37:15 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id B0B70402C1
 for <dev@dpdk.org>; Tue, 12 May 2026 13:37:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowADXfmriEANq57oBEA--.19582S9;
 Tue, 12 May 2026 19:37:08 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v13 07/10] common/sxe2: add ioctl interface for DMA map and
 unmap
Date: Tue, 12 May 2026 19:36:56 +0800
Message-ID: <20260512113700.837744-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512113700.837744-1-liujie5@linkdatatechnology.com>
References: <20260512080616.454171-11-liujie5@linkdatatechnology.com>
 <20260512113700.837744-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADXfmriEANq57oBEA--.19582S9
X-Coremail-Antispam: 1UD129KBjvJXoW3ArWrWw45CFy8Xw45CrWruFg_yoWxCFWrpF
 4vgFyYqFy8ta1ag3W5Ja12qFy5Kw4Fv3y7CFyxGwn3KF1qvrykZw4FgFy3Jw15CrZxJF93
 AFsIkF45Cr18GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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
 drivers/common/sxe2/sxe2_common.c          |  50 +++++++++-
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 106 ++++++++++++++++++++-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   9 ++
 3 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index 62bdc93b5c..63873afe4a 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -443,7 +443,7 @@ static s32 sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
 	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
 	if (cdev == NULL) {
 		ret = -ENODEV;
-		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		PMD_LOG_ERR(COM, "Fail to get device when remove.");
 		goto l_end;
 	}
 
@@ -467,12 +467,60 @@ static s32 sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
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
+		ret = -ENODEV;
+		PMD_LOG_ERR(COM, "Fail to get device when dma map.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_dma_map(cdev, (u64)(uintptr_t)addr, iova, len);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to map dma map, ret=%d", ret);
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
+		ret = -ENODEV;
+		PMD_LOG_ERR(COM, "Fail to get device when dma unmap.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_dma_unmap(cdev, iova);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to unmap dma map, ret=%d", ret);
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
index 80fccc6a11..4dfc4fd0fa 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -202,7 +202,7 @@ sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len)
 
 	if (cdev->config.kernel_reset) {
 		ret = -EPERM;
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_end;
 	}
 
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
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	iova_mode = rte_eal_iova_mode();
+	if (iova_mode == RTE_IOVA_PA) {
+		if (cdev->config.support_iommu) {
+			PMD_LOG_ERR(COM, "iommu not support pa mode");
+			ret = -EIO;
+		}
+		goto l_end;
+	} else if (iova_mode == RTE_IOVA_VA) {
+		if (!cdev->config.support_iommu) {
+			PMD_LOG_ERR(COM, "no iommu not support va mode, please use pa mode.");
+			ret = -EIO;
+			goto l_end;
+		}
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
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
+		ret = -EIO;
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
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	if (!cdev->config.support_iommu)
+		goto l_end;
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
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
+		ret = -EIO;
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

