Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873E8CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 14:48:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 085CF40659;
	Tue, 19 May 2026 16:48:27 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7E2F54065D
 for <dev@dpdk.org>; Tue, 19 May 2026 16:48:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowABH7GcweAxqad7HEA--.3481S9;
 Tue, 19 May 2026 22:48:19 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v18 07/11] common/sxe2: add ioctl interface for DMA map and
 unmap
Date: Tue, 19 May 2026 22:48:06 +0800
Message-ID: <20260519144810.3951202-8-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519144810.3951202-1-liujie5@linkdatatechnology.com>
References: <20260519030132.3780057-12-liujie5@linkdatatechnology.com>
 <20260519144810.3951202-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABH7GcweAxqad7HEA--.3481S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15Zw1rCr1DCFWkKr4kWFg_yoWxAF4kpF
 40gFyYqFy8ta1SgF15Jw4UXF15Kw4Fq3y7CFWxKas3KF1qvFykZ3y0gFy3Jw1rCrZxJFn3
 AanIkF45ur1xWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0x
 vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 104 +++++++++++++++++++++
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |   9 ++
 3 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index a79e7bae20..9a7eb30336 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -442,7 +442,7 @@ static int32_t sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
 	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
 	if (cdev == NULL) {
 		ret = -ENODEV;
-		PMD_LOG_ERR(COM, "Fail to get remove device.");
+		PMD_LOG_ERR(COM, "Fail to get device when remove.");
 		goto l_end;
 	}
 
@@ -466,12 +466,60 @@ static int32_t sxe2_common_pci_remove(struct rte_pci_device *pci_dev)
 	return ret;
 }
 
+static int32_t sxe2_common_pci_dma_map(struct rte_pci_device *pci_dev,
+		void *addr,	uint64_t iova, size_t len)
+{
+	struct sxe2_common_device *cdev;
+	int32_t ret = -1;
+
+	cdev = sxe2_rtedev_to_cdev(&pci_dev->device);
+	if (cdev == NULL) {
+		ret = -ENODEV;
+		PMD_LOG_ERR(COM, "Fail to get device when dma map.");
+		goto l_end;
+	}
+
+	ret = sxe2_drv_dev_dma_map(cdev, (uint64_t)(uintptr_t)addr, iova, len);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to map dma map, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static int32_t sxe2_common_pci_dma_unmap(struct rte_pci_device *pci_dev,
+		void *addr __rte_unused, uint64_t iova, size_t len __rte_unused)
+{
+	struct sxe2_common_device *cdev;
+	int32_t ret = -1;
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
 
 static uint32_t sxe2_common_pci_id_table_size_get(const struct rte_pci_id *id_table)
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index ae22f8e7b7..a40f9b8da2 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -219,3 +219,107 @@ sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len)
 l_end:
 	return ret;
 }
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_map)
+int32_t
+sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, uint64_t vaddr,
+			uint64_t iova, uint64_t size)
+{
+	struct sxe2_ioctl_iommu_dma_map cmd_params;
+	enum rte_iova_mode iova_mode;
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
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
+	(void)pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_MAP, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to dma map, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		(void)pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	(void)pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_unmap)
+int32_t
+sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova)
+{
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
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
+	(void)pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_UNMAP, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_INFO(COM, "Failed to dma unmap, fd=%d, ret=%d, err:%s",
+				cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		(void)pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	(void)pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
index 483b8f820c..aed5a5b50d 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -46,6 +46,15 @@ __rte_internal
 int32_t
 sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len);
 
+__rte_internal
+int32_t
+sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, uint64_t vaddr,
+		uint64_t iova, uint64_t size);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.3

