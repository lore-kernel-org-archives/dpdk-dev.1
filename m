Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F931CD5BC6
	for <dpdk-dev@archiver.kernel.org>; Sun, 24 May 2026 09:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC5BE40664;
	Sun, 24 May 2026 11:33:15 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id A7E55402CC
 for <dev@dpdk.org>; Sun, 24 May 2026 11:33:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABXd97QxRJq+04kEg--.9115S11;
 Sun, 24 May 2026 17:33:07 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 09/23] drivers: interrupt handling
Date: Sun, 24 May 2026 17:32:45 +0800
Message-ID: <20260524093259.397506-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
References: <20260524093259.397506-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXd97QxRJq+04kEg--.9115S11
X-Coremail-Antispam: 1UD129KBjvAXoWDAr4Duw17Jw47Zr15KFW5GFg_yoW7JFyxKo
 WxWrnxX3WrW34Ik3yxJr4kGFy7Zw48uw45ta1SgFs8uwnxG34Yga43Xr1DX3WqgFs5tr9F
 grn2vrZ7KFsxJrWrn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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

This patch includes:
- MSI-X vector allocation and mapping logic.
- Support for rx_queue_intr_enable and rx_queue_intr_disable ops.
- Interrupt handler to process admin and queue events.
- Integration with EAL interrupt framework.

RX queue interrupts allow applications to use rte_eth_dev_rx_intr_wait()
for power-efficient packet processing.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_ioctl_chnl.c      | 177 +++-
 drivers/common/sxe2/sxe2_ioctl_chnl_func.h |  18 +
 drivers/net/sxe2/meson.build               |   1 +
 drivers/net/sxe2/sxe2_cmd_chnl.c           |  42 +
 drivers/net/sxe2/sxe2_cmd_chnl.h           |   4 +
 drivers/net/sxe2/sxe2_drv_cmd.h            |   8 +
 drivers/net/sxe2/sxe2_ethdev.c             |  93 +-
 drivers/net/sxe2/sxe2_ethdev.h             |   6 +
 drivers/net/sxe2/sxe2_irq.c                | 941 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_irq.h                |  21 +
 drivers/net/sxe2/sxe2vf_regs.h             |  82 ++
 11 files changed, 1389 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_irq.c
 create mode 100644 drivers/net/sxe2/sxe2vf_regs.h

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 2ffbeb9217..173d8d57ae 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -67,6 +67,7 @@ sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
 	return ret;
 }
 
+
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_open)
 int32_t
 sxe2_drv_dev_open(struct sxe2_common_device *cdev, struct rte_pci_device *pci_dev)
@@ -87,7 +88,7 @@ sxe2_drv_dev_open(struct sxe2_common_device *cdev, struct rte_pci_device *pci_de
 	if (fd < 0) {
 		ret = -EBADF;
 		PMD_LOG_ERR(COM, "Fail to open device:%s, ret=%d, err:%s",
-				drv_name, ret, strerror(errno));
+			    drv_name, ret, strerror(errno));
 		goto l_end;
 	}
 
@@ -159,6 +160,177 @@ sxe2_drv_dev_handshake(struct sxe2_common_device *cdev)
 	return ret;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_rxq_irq_set)
+int32_t
+sxe2_drv_dev_rxq_irq_set(struct sxe2_common_device *cdev,
+		       uint16_t base_irq, int32_t *efd, uint16_t nb_irq)
+{
+	struct sxe2_ioctl_irq_set cmd_params;
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Open fd=%d to set rxq irq, base_queue=%d, efds=%p, nb_irq=%d",
+		cmd_fd, base_irq, efd, nb_irq);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_irq_set));
+	cmd_params.base_irq_in_com = base_irq;
+	cmd_params.cnt = nb_irq;
+	cmd_params.event_fd = efd;
+
+	pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_IO_IRQS_REQ, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to set io irqs, fd=%d, ret=%d, err:%s",
+			    cmd_fd, ret, strerror(errno));
+		pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_other_irq_set)
+int32_t
+sxe2_drv_dev_other_irq_set(struct sxe2_common_device *cdev,
+			int32_t efd, uint64_t event)
+{
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
+	struct sxe2_ioctl_other_evt_set cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Open fd=%d to set other irq, efd=%d, event=%"PRIu64"",
+		cmd_fd, efd, event);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_other_evt_set));
+	cmd_params.eventfd = efd;
+	cmd_params.filter_table = event;
+
+	pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_EVT_IRQ_REQ, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to set others evt, fd=%d, ret=%d, err:%s",
+			   cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_other_irq_get)
+int32_t
+sxe2_drv_dev_other_irq_get(struct sxe2_common_device *cdev, uint64_t *event)
+{
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
+	struct sxe2_ioctl_other_evt_get cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Open fd=%d to get other irq", cmd_fd);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_other_evt_get));
+
+	pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_EVT_CAUSE_GET, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to set others evt, fd=%d, ret=%d, err:%s",
+			   cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	pthread_mutex_unlock(&cdev->config.lock);
+	*event = cmd_params.evt_cause;
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_reset_irq_set)
+int32_t
+sxe2_drv_dev_reset_irq_set(struct sxe2_common_device *cdev, int32_t efd)
+{
+	int32_t ret = 0;
+	int32_t cmd_fd = 0;
+	struct sxe2_ioctl_reset_sub_set cmd_params;
+
+	if (cdev->config.kernel_reset) {
+		ret = -EPERM;
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
+		goto l_end;
+	}
+
+	cmd_fd = SXE2_CDEV_TO_CMD_FD(cdev);
+	if (cmd_fd < 0) {
+		ret = -EBADF;
+		PMD_LOG_ERR(COM, "Failed to exec cmd, fd=%d", cmd_fd);
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(COM, "Open fd=%d to set reset irq, efd=%d",
+		cmd_fd, efd);
+
+	memset(&cmd_params, 0, sizeof(struct sxe2_ioctl_reset_sub_set));
+	cmd_params.eventfd = efd;
+
+	pthread_mutex_lock(&cdev->config.lock);
+	ret = ioctl(cmd_fd, SXE2_COM_CMD_RST_IRQ_REQ, &cmd_params);
+	if (ret < 0) {
+		PMD_LOG_ERR(COM, "Failed to set reset irqs, fd=%d, ret=%d, err:%s",
+			   cmd_fd, ret, strerror(errno));
+		ret = -EIO;
+		pthread_mutex_unlock(&cdev->config.lock);
+		goto l_end;
+	}
+	pthread_mutex_unlock(&cdev->config.lock);
+
+l_end:
+	return ret;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_mmap)
 void
 *sxe2_drv_dev_mmap(struct sxe2_common_device *cdev, uint8_t bar_idx, uint64_t len, uint64_t offset)
@@ -223,7 +395,7 @@ sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len)
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_dma_map)
 int32_t
 sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, uint64_t vaddr,
-			uint64_t iova, uint64_t size)
+		     uint64_t iova, uint64_t size)
 {
 	struct sxe2_ioctl_iommu_dma_map cmd_params;
 	enum rte_iova_mode iova_mode;
@@ -322,4 +494,3 @@ sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova)
 l_end:
 	return ret;
 }
-
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
index aed5a5b50d..f29194fc9e 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl_func.h
@@ -29,6 +29,7 @@ int32_t
 sxe2_drv_dev_open(struct sxe2_common_device *cdev,
 		struct rte_pci_device *pci_dev);
 
+
 __rte_internal
 void
 sxe2_drv_dev_close(struct sxe2_common_device *cdev);
@@ -37,6 +38,23 @@ __rte_internal
 int32_t
 sxe2_drv_dev_handshake(struct sxe2_common_device *cdev);
 
+__rte_internal
+int32_t
+sxe2_drv_dev_rxq_irq_set(struct sxe2_common_device *cdev, uint16_t base_irq,
+			 int32_t *efd, uint16_t nb_irq);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_other_irq_set(struct sxe2_common_device *cdev, int32_t efd, uint64_t event);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_other_irq_get(struct sxe2_common_device *cdev, uint64_t *event);
+
+__rte_internal
+int32_t
+sxe2_drv_dev_reset_irq_set(struct sxe2_common_device *cdev, int32_t fd);
+
 __rte_internal
 void
 *sxe2_drv_dev_mmap(struct sxe2_common_device *cdev, uint8_t bar_idx,
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index d860629def..c73e13bbad 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -68,6 +68,7 @@ sources += files(
         'sxe2_security.c',
         'sxe2_mp.c',
         'sxe2_stats.c',
+        'sxe2_irq.c',
 )
 
 allow_internal_get_api = true
\ No newline at end of file
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index a1fc8a50e3..d1f15084ed 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -348,6 +348,48 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+int32_t sxe2_drv_rxq_bind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx, uint16_t msix_idx)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_queue_irq_bind_req req = {0};
+	int32_t ret = 0;
+
+	req.msix_idx = msix_idx;
+	req.q_idx = rxq_idx;
+	req.itr_idx = 0;
+	req.bind = true;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_EVT_IRQ_BAND_RXQ,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq bind irq failed, ret=%d", ret);
+
+	return ret;
+}
+
+int32_t sxe2_drv_rxq_unbind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx)
+{
+	struct sxe2_common_device *cdev = adapter->cdev;
+	struct sxe2_drv_cmd_params param = {0};
+	struct sxe2_drv_queue_irq_bind_req req = {0};
+	int32_t ret = 0;
+
+	req.bind = false;
+	req.q_idx = rxq_idx;
+
+	sxe2_drv_cmd_params_fill(adapter, &param, SXE2_DRV_CMD_EVT_IRQ_BAND_RXQ,
+				 &req, sizeof(req),
+				 NULL, 0);
+	ret = sxe2_drv_cmd_exec(cdev, &param);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq unbind irq failed, ret=%d", ret);
+
+	return ret;
+}
+
 int32_t sxe2_drv_get_mac_stats(struct sxe2_adapter *adapter)
 {
 	int32_t ret = 0;
diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.h b/drivers/net/sxe2/sxe2_cmd_chnl.h
index ff73d2f901..c13653e8af 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.h
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.h
@@ -118,4 +118,8 @@ int32_t sxe2_drv_rss_hf_clear(struct sxe2_adapter *adapter);
 
 int32_t sxe2_drv_ptp_gettime(struct sxe2_adapter *adapter, struct sxe2_rx_queue *rxq);
 
+int32_t sxe2_drv_rxq_bind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx, uint16_t msix_idx);
+
+int32_t sxe2_drv_rxq_unbind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx);
+
 #endif /* __SXE2_CMD_CHNL_H__ */
diff --git a/drivers/net/sxe2/sxe2_drv_cmd.h b/drivers/net/sxe2/sxe2_drv_cmd.h
index a88e2b24bf..0b2a715000 100644
--- a/drivers/net/sxe2/sxe2_drv_cmd.h
+++ b/drivers/net/sxe2/sxe2_drv_cmd.h
@@ -215,6 +215,14 @@ struct sxe2_drv_q_switch_req {
 	uint8_t rsv[2];
 };
 
+struct sxe2_drv_queue_irq_bind_req {
+	__le16 q_idx;
+	__le16 msix_idx;
+	uint8_t itr_idx;
+	uint8_t bind;
+	uint8_t rsv[2];
+};
+
 struct sxe2_drv_vsi_create_req_resp {
 	uint16_t vsi_id;
 	uint16_t vsi_type;
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index dbe1a2bce1..f3fee74ddf 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -22,6 +22,7 @@
 #include <rte_eal_paging.h>
 
 #include "sxe2_ethdev.h"
+#include "sxe2_irq.h"
 #include "sxe2_drv_cmd.h"
 #include "sxe2_cmd_chnl.h"
 #include "sxe2_tx.h"
@@ -107,6 +108,9 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.rx_queue_release           = sxe2_rx_queue_release,
 	.tx_queue_setup             = sxe2_tx_queue_setup,
 	.tx_queue_release           = sxe2_tx_queue_release,
+	.rx_queue_intr_enable       = sxe2_rx_queue_intr_enable,
+	.rx_queue_intr_disable      = sxe2_rx_queue_intr_disable,
+
 	.rxq_info_get               = sxe2_rx_queue_info_get,
 	.txq_info_get               = sxe2_tx_queue_info_get,
 	.rx_burst_mode_get          = sxe2_rx_burst_mode_get,
@@ -177,6 +181,8 @@ static int32_t sxe2_dev_stop(struct rte_eth_dev *dev)
 	if (adapter->started == 0)
 		goto l_end;
 
+	sxe2_rxq_intr_disable(dev);
+
 	sxe2_txqs_all_stop(dev);
 	sxe2_rxqs_all_stop(dev);
 
@@ -215,6 +221,12 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 		goto l_end;
 	}
 
+	ret = sxe2_rxq_intr_enable(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to enable rx queue intr");
+		goto l_rxq_intr_err;
+	}
+
 	ret = sxe2_queues_start(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "enable queues failed");
@@ -224,7 +236,10 @@ static int32_t sxe2_dev_start(struct rte_eth_dev *dev)
 	dev->data->dev_started = 1;
 	adapter->started = 1;
 	goto l_end;
+
 l_start_queues_err:
+	(void)sxe2_rxq_intr_disable(dev);
+l_rxq_intr_err:
 	(void)sxe2_filter_rule_stop(dev);
 l_end:
 	return ret;
@@ -615,6 +630,8 @@ static int32_t sxe2_func_caps_get(struct sxe2_adapter *adapter)
 
 	sxe2_sw_queue_ctx_hw_cap_set(adapter, &dev_caps.queue_caps);
 
+	sxe2_sw_irq_ctx_hw_cap_set(adapter, &dev_caps.msix_caps);
+
 	sxe2_sw_rss_ctx_hw_cap_set(adapter, &dev_caps.rss_hash_caps);
 
 	sxe2_sw_vsi_ctx_hw_cap_set(adapter, &dev_caps.vsi_caps);
@@ -636,6 +653,41 @@ static int32_t sxe2_dev_caps_get(struct sxe2_adapter *adapter)
 	return ret;
 }
 
+uint32_t sxe2_pci_map_read_reg(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, uint16_t idx_in_func)
+{
+	void *reg_addr;
+	uint32_t value;
+
+	reg_addr = sxe2_pci_map_addr_get(adapter, res_type, idx_in_func);
+	if (unlikely(reg_addr == NULL)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "reg addr:0x%p is error.", reg_addr);
+		value = SXE2_PCI_MAP_INVALID_VAL;
+		goto l_ret;
+	}
+
+	value = SXE2_PCI_REG_READ(reg_addr);
+
+l_ret:
+	return value;
+}
+
+void sxe2_pci_map_write_reg(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, uint16_t idx_in_func, uint32_t value)
+{
+	void *reg_addr;
+
+	reg_addr = sxe2_pci_map_addr_get(adapter, res_type, idx_in_func);
+	if (unlikely(reg_addr == NULL)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "reg addr:0x%p is error.", reg_addr);
+		goto l_ret;
+	}
+
+	SXE2_PCI_REG_WRITE_WC(reg_addr, value);
+l_ret:
+	return;
+}
+
 int32_t sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
 			     enum sxe2_pci_map_resource res_type,
 			     uint64_t org_len,
@@ -715,6 +767,27 @@ static int32_t sxe2_hw_init(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static int32_t sxe2_sw_init(struct rte_eth_dev *dev)
+{
+	int32_t ret = -1;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe2_sw_irq_ctxt_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to sw irq ctxt init, ret=[%d]", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe2_sw_uninit(struct rte_eth_dev *dev)
+{
+	sxe2_sw_irq_ctxt_uninit(dev);
+}
+
 int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter,
 				 uint32_t res_type,
 				 uint32_t item_cnt,
@@ -1065,6 +1138,18 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 		goto init_dev_info_err;
 	}
 
+	ret = sxe2_sw_init(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize sw parameters, ret=[%d]", ret);
+		goto init_sw_err;
+	}
+
+	ret = sxe2_intr_init(dev);
+	if (ret != 0) {
+		PMD_LOG_ERR(INIT, "Failed to initialize interrupt, ret:%d", ret);
+		goto init_irq_err;
+	}
+
 	ret = sxe2_eth_init(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "Failed to initialize eth parameters, ret=%d", ret);
@@ -1109,6 +1194,10 @@ static int32_t sxe2_dev_init(struct rte_eth_dev *dev,
 init_rss_err:
 	sxe2_security_uinit(dev);
 init_security_err:
+	sxe2_intr_uninit(dev);
+init_irq_err:
+	sxe2_sw_uninit(dev);
+init_sw_err:
 	sxe2_eth_uinit(dev);
 init_eth_err:
 init_dev_info_err:
@@ -1132,8 +1221,10 @@ static int32_t sxe2_dev_close(struct rte_eth_dev *dev)
 	(void)sxe2_sched_uinit(dev);
 	sxe2_vsi_uninit(dev);
 	sxe2_security_uinit(dev);
-	sxe2_dev_pci_map_uinit(dev);
+	sxe2_intr_uninit(dev);
+	sxe2_sw_uninit(dev);
 	sxe2_eth_uinit(dev);
+	sxe2_dev_pci_map_uinit(dev);
 
 l_end:
 	return 0;
diff --git a/drivers/net/sxe2/sxe2_ethdev.h b/drivers/net/sxe2/sxe2_ethdev.h
index 32a67ed344..65ada44c12 100644
--- a/drivers/net/sxe2/sxe2_ethdev.h
+++ b/drivers/net/sxe2/sxe2_ethdev.h
@@ -354,6 +354,12 @@ int32_t sxe2_dev_pci_res_seg_map(struct sxe2_adapter *adapter,
 				 uint32_t item_cnt,
 				 uint32_t item_base);
 
+void sxe2_pci_map_write_reg(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, uint16_t idx_in_func, uint32_t value);
+
+uint32_t sxe2_pci_map_read_reg(struct sxe2_adapter *adapter,
+		enum sxe2_pci_map_resource res_type, uint16_t idx_in_func);
+
 void sxe2_dev_pci_seg_unmap(struct sxe2_adapter *adapter, uint32_t res_type);
 
 int32_t sxe2_dev_pci_map_init(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
new file mode 100644
index 0000000000..13619500ea
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -0,0 +1,941 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <stdint.h>
+#include <sys/eventfd.h>
+#include <unistd.h>
+#include <ethdev_pci.h>
+#include <ethdev_driver.h>
+#include <rte_alarm.h>
+#include <fcntl.h>
+#include <rte_stdatomic.h>
+
+#include "sxe2_ethdev.h"
+#include "sxe2_irq.h"
+#include "sxe2_common_log.h"
+#include "sxe2_queue.h"
+#include "sxe2_drv_cmd.h"
+#include "sxe2_ioctl_chnl_func.h"
+#include "sxe2vf_regs.h"
+#include "sxe2_host_regs.h"
+#include "sxe2_cmd_chnl.h"
+
+#define SXE2_INT_EVENT_OICR_ALL (SXE2_PF_INT_OICR_SWINT | \
+					SXE2_PF_INT_OICR_LAN_TX_ERR | \
+					SXE2_PF_INT_OICR_LAN_RX_ERR | \
+					SXE2_PF_INT_OICR_FW)
+
+#define MAX_EVENT_PENDING (16)
+
+struct sxe2_event_element {
+	TAILQ_ENTRY(sxe2_event_element) next;
+	struct rte_eth_dev *dev;
+};
+
+struct sxe2_event_handler {
+	RTE_ATOMIC(uint16_t)ndev;
+	rte_thread_t tid;
+	int32_t fd[2];
+	rte_spinlock_t  lock;
+	TAILQ_HEAD(event_list, sxe2_event_element) pending;
+};
+static struct sxe2_event_handler event_handler = {
+	.fd = {-1, -1},
+};
+static volatile int32_t event_thread_run;
+
+
+static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t oicr)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
+
+	if (oicr & RTE_BIT32(SXE2_COM_EC_LINK_CHG)) {
+		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=%" PRIu64, oicr);
+		(void)sxe2_drv_mac_link_status_get(adapter);
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+			rte_eth_dev_callback_process(dev,
+						     RTE_ETH_EVENT_INTR_LSC,
+						     NULL);
+	}
+}
+
+static uint32_t sxe2_event_intr_handle(void *param __rte_unused)
+{
+	struct sxe2_event_handler *handler = &event_handler;
+	struct sxe2_adapter *adapter;
+	struct sxe2_event_element *pos;
+	struct sxe2_event_element *tmp;
+	int32_t ret = 0;
+	uint64_t oicr = 0;
+	TAILQ_HEAD(event_list, sxe2_event_element) pending;
+	int8_t unused[MAX_EVENT_PENDING];
+	ssize_t nr;
+
+	while (event_thread_run) {
+		nr = read(handler->fd[0], &unused, sizeof(unused));
+		if (nr <= 0)
+			break;
+
+		rte_spinlock_lock(&handler->lock);
+		TAILQ_INIT(&pending);
+		TAILQ_CONCAT(&pending, &handler->pending, next);
+		rte_spinlock_unlock(&handler->lock);
+
+		TAILQ_FOREACH_SAFE(pos, &pending, next, tmp) {
+			TAILQ_REMOVE(&pending, pos, next);
+			adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(pos->dev);
+
+			ret = sxe2_drv_dev_other_irq_get(adapter->cdev, &oicr);
+			sxe2_event_irq_common_handler(adapter, oicr);
+
+			rte_free(pos);
+		}
+	}
+
+	return ret;
+}
+
+static int32_t sxe2_event_intr_handler_init(void)
+{
+	struct sxe2_event_handler *handler = &event_handler;
+	int32_t ret = 0;
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_atomic_fetch_add_explicit(&handler->ndev, 1, rte_memory_order_acq_rel) >= 1) {
+		ret = 0;
+		PMD_LOG_DEBUG(INIT, "%s: ndev > 1", __func__);
+		goto l_end;
+	}
+
+#if defined(RTE_EXEC_ENV_IS_WINDOWS) && RTE_EXEC_ENV_IS_WINDOWS != 0
+	err = _pipe(handler->fd, MAX_EVENT_PENDING, O_BINARY);
+#else
+	err = pipe(handler->fd);
+#endif
+	if (err != 0) {
+		ret = -ECHILD;
+		rte_atomic_fetch_sub_explicit(&handler->ndev, 1, rte_memory_order_release);
+		PMD_LOG_ERR(INIT, "%s: pipe failed", __func__);
+		goto l_end;
+	}
+
+	event_thread_run = 1;
+
+	TAILQ_INIT(&handler->pending);
+	rte_spinlock_init(&handler->lock);
+
+	if (rte_thread_create_internal_control(&handler->tid, "sxe2-event",
+				sxe2_event_intr_handle, NULL)) {
+		PMD_LOG_ERR(INIT, "%s: thread create failed", __func__);
+		rte_atomic_fetch_sub_explicit(&handler->ndev, 1, rte_memory_order_release);
+		ret = -ECHILD;
+		goto l_end;
+	}
+	ret = 0;
+l_end:
+	return ret;
+}
+
+static void sxe2_event_intr_handler_uinit(void)
+{
+	struct sxe2_event_handler *handler = &event_handler;
+	struct sxe2_event_element *pos;
+	struct sxe2_event_element *tmp;
+	ssize_t nw = 0;
+	int8_t notify_byte = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_atomic_fetch_sub_explicit(&handler->ndev, 1, rte_memory_order_acq_rel) > 1) {
+		PMD_LOG_DEBUG(INIT, "event handler uinit, ndev > 0");
+		return;
+	}
+
+	event_thread_run = 0;
+	nw = write(handler->fd[1], &notify_byte, 1);
+	RTE_SET_USED(nw);
+
+	(void)rte_thread_join(handler->tid, NULL);
+
+	if (handler->fd[0] != -1) {
+		close(handler->fd[0]);
+		handler->fd[0] = -1;
+	}
+	if (handler->fd[1] != -1) {
+		close(handler->fd[1]);
+		handler->fd[1] = -1;
+	}
+
+	rte_spinlock_lock(&handler->lock);
+	TAILQ_FOREACH_SAFE(pos, &handler->pending, next, tmp) {
+		TAILQ_REMOVE(&handler->pending, pos, next);
+		rte_free(pos);
+	}
+	rte_spinlock_unlock(&handler->lock);
+}
+
+static void sxe2_event_intr_post(struct rte_eth_dev *dev)
+{
+	struct sxe2_event_handler *handler = &event_handler;
+	struct sxe2_event_element *elem = rte_malloc(NULL, sizeof(struct sxe2_event_element), 0);
+	int8_t notify_byte = 0;
+	ssize_t nw = 0;
+
+	if (!elem)
+		goto l_end;
+
+	elem->dev = dev;
+
+	rte_spinlock_lock(&handler->lock);
+	TAILQ_INSERT_TAIL(&handler->pending, elem, next);
+	rte_spinlock_unlock(&handler->lock);
+
+	nw = write(handler->fd[1], &notify_byte, 1);
+	RTE_SET_USED(nw);
+
+l_end:
+	return;
+}
+
+static void sxe2_interrupt_handler_other(void *arg)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)arg;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t eventfd = adapter->irq_ctxt.other_event_fd;
+	int32_t ret = 0;
+	uint64_t buf = 0;
+
+	ret = read(eventfd, &buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "read eventfd[%d] failed, ret:%d, errno:%d.",
+				eventfd, ret, errno);
+	}
+
+	sxe2_event_intr_post(dev);
+}
+
+static void sxe2_interrupt_handler_reset(void *arg)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)arg;
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t resetfd = adapter->irq_ctxt.reset_event_fd;
+	int32_t ret = 0;
+	uint64_t buf = 0;
+
+	ret = read(resetfd, &buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		PMD_DEV_LOG_ERR(adapter, DRV, "read resetfd[%d] failed, ret:%d, errno:%d.",
+				resetfd, ret, errno);
+	}
+
+	sxe2_drv_cmd_close(adapter->cdev);
+
+	rte_eth_dev_callback_process(dev, RTE_ETH_EVENT_INTR_RMV, NULL);
+}
+
+int32_t sxe2_sw_irq_ctxt_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	int32_t ret = 0;
+
+	irq_ctxt->rxq_avail_cnt = irq_ctxt->max_cnt_hw;
+	irq_ctxt->rxq_base_idx_in_pf = irq_ctxt->base_idx_in_func;
+	irq_ctxt->reset_event_fd = -1;
+	irq_ctxt->other_event_fd = -1;
+
+	return ret;
+}
+
+void sxe2_sw_irq_ctxt_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+
+	memset(&adapter->irq_ctxt, 0, sizeof(adapter->irq_ctxt));
+	adapter->irq_ctxt.reset_event_fd = -1;
+	adapter->irq_ctxt.other_event_fd = -1;
+}
+
+void sxe2_sw_irq_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+				struct sxe2_drv_msix_caps *msix_caps)
+{
+	adapter->irq_ctxt.max_cnt_hw = msix_caps->msix_vectors_cnt;
+	adapter->irq_ctxt.base_idx_in_func = msix_caps->base_idx_in_func;
+}
+
+static int32_t sxe2_intr_handler_cfg(struct rte_intr_handle *handle,
+		int32_t fd, rte_intr_callback_fn cb, void *cb_arg)
+{
+	int32_t ret = 0;
+
+	ret = rte_intr_fd_set(handle, fd);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to set intr_handle->fd, error %i (%s)",
+			errno, strerror(errno));
+		goto err;
+	}
+
+	ret = rte_intr_type_set(handle, RTE_INTR_HANDLE_EXT);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to set intr_handle->type, error %i (%s)",
+			errno, strerror(errno));
+		goto err;
+	}
+
+	ret = rte_intr_callback_register(handle, cb, cb_arg);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize register intr callback, ret=%d", ret);
+		goto err;
+	}
+err:
+	return ret;
+}
+
+static struct rte_intr_handle *
+sxe2_intr_handler_create(int32_t fd, rte_intr_callback_fn cb, void *cb_arg)
+{
+	struct rte_intr_handle *tmp_intr_handle = NULL;
+	int32_t ret = 0;
+
+	tmp_intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (!tmp_intr_handle) {
+		PMD_LOG_ERR(INIT, "Failed to alloc memory for intr_handler, error %i (%s)",
+			errno, strerror(errno));
+		goto err;
+	}
+
+	ret = rte_intr_fd_set(tmp_intr_handle, fd);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to set intr_handle->fd, error %i (%s)",
+				errno, strerror(errno));
+		goto err;
+	}
+
+	ret = rte_intr_type_set(tmp_intr_handle, RTE_INTR_HANDLE_EXT);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to set intr_handle->type, error %i (%s)",
+				errno, strerror(errno));
+		goto err;
+	}
+
+	ret = rte_intr_callback_register(tmp_intr_handle, cb, cb_arg);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "Failed to initialize register intr callback, ret=%d", ret);
+		goto err;
+	}
+
+	return tmp_intr_handle;
+err:
+	rte_intr_instance_free(tmp_intr_handle);
+	return NULL;
+}
+
+static void sxe2_intr_handler_destroy(struct rte_intr_handle *intr_handle,
+				  rte_intr_callback_fn cb, void *cb_arg)
+{
+	if (!intr_handle)
+		return;
+
+	if (rte_intr_fd_get(intr_handle) >= 0)
+		(void)rte_intr_callback_unregister(intr_handle, cb, cb_arg);
+	rte_intr_instance_free(intr_handle);
+}
+
+static int32_t sxe2_event_intr_fd_create(void)
+{
+	int32_t fd = 0;
+
+	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (fd < 0) {
+		PMD_LOG_ERR(INIT, "Can't setup eventfd, error %i (%s)",
+			errno, strerror(errno));
+		goto err;
+	}
+
+	return fd;
+err:
+	return -EBADF;
+}
+
+static void sxe2_event_intr_fd_destroy(int32_t fd)
+{
+	if (fd >= 0)
+		close(fd);
+}
+
+static int32_t sxe2_other_intr_register(struct rte_eth_dev *dev, int32_t fd)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	uint64_t event = RTE_BIT32(SXE2_COM_EC_LINK_CHG) |
+				RTE_BIT32(SXE2_COM_SW_MODE_LEGACY) |
+				RTE_BIT32(SXE2_COM_SW_MODE_SWITCHDEV) |
+				RTE_BIT32(SXE2_COM_FC_ST_CHANGE);
+
+	ret = sxe2_drv_dev_other_irq_set(adapter->cdev, fd, event);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set other irq, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe2_other_intr_unregister(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_drv_dev_other_irq_set(adapter->cdev, -1, 0);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set other irq, ret=%d", ret);
+}
+
+static int32_t sxe2_reset_intr_register(struct rte_eth_dev *dev, int32_t fd)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_drv_dev_reset_irq_set(adapter->cdev, fd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set reset irq, ret=%d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe2_reset_intr_unregister(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+
+	ret = sxe2_drv_dev_reset_irq_set(adapter->cdev, -1);
+	if (ret)
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set reset irq, ret=%d", ret);
+}
+
+int32_t sxe2_intr_init(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_pci_device *pci_dev = SXE2_DEV_TO_PCI(dev);
+	struct rte_intr_handle *reset_handle = NULL;
+	int32_t ofd = -1;
+	int32_t rfd = -1;
+	int32_t ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ofd = sxe2_event_intr_fd_create();
+	if (ofd < 0) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to create event intr fd");
+		ret = -EBADF;
+		goto l_end;
+	}
+
+	ret = sxe2_intr_handler_cfg(pci_dev->intr_handle,
+			ofd, sxe2_interrupt_handler_other, dev);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to create intr handler");
+		goto l_err_create_other_handler;
+	}
+
+	ret = sxe2_event_intr_handler_init();
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Event handler init failed, ret=%d", ret);
+		goto l_err_event_intr_handler_init;
+	}
+
+	ret = sxe2_other_intr_register(dev, ofd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to register other intr, ret=%d", ret);
+		goto l_err_register_other_intr;
+	}
+	adapter->irq_ctxt.other_event_fd = ofd;
+
+	rfd = sxe2_event_intr_fd_create();
+	if (rfd < 0) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to create event intr fd");
+		ret = -EBADF;
+		goto l_err_create_reset_fd;
+	}
+
+	reset_handle = sxe2_intr_handler_create(rfd, sxe2_interrupt_handler_reset, dev);
+	if (!reset_handle) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to create intr handler");
+		ret = -ENOMEM;
+		goto l_err_create_reset_handler;
+	}
+	adapter->irq_ctxt.reset_handle = reset_handle;
+
+	ret = sxe2_reset_intr_register(dev, rfd);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to register reset intr, ret=%d", ret);
+		goto l_err_register_reset_intr;
+	}
+	adapter->irq_ctxt.reset_event_fd = rfd;
+
+	goto l_end;
+l_err_register_reset_intr:
+	sxe2_intr_handler_destroy(reset_handle, sxe2_interrupt_handler_reset, dev);
+	adapter->irq_ctxt.reset_handle = NULL;
+l_err_create_reset_handler:
+	sxe2_event_intr_fd_destroy(rfd);
+l_err_create_reset_fd:
+	sxe2_other_intr_unregister(dev);
+	adapter->irq_ctxt.other_event_fd = -1;
+l_err_register_other_intr:
+	sxe2_event_intr_handler_uinit();
+l_err_event_intr_handler_init:
+	sxe2_intr_handler_destroy(pci_dev->intr_handle,
+			sxe2_interrupt_handler_other, dev);
+	pci_dev->intr_handle = NULL;
+l_err_create_other_handler:
+	sxe2_event_intr_fd_destroy(ofd);
+l_end:
+	return ret;
+}
+
+void sxe2_intr_uninit(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct rte_pci_device *pci_dev = SXE2_DEV_TO_PCI(dev);
+
+	sxe2_reset_intr_unregister(dev);
+	sxe2_intr_handler_destroy(adapter->irq_ctxt.reset_handle,
+				sxe2_interrupt_handler_reset, dev);
+	sxe2_event_intr_fd_destroy(adapter->irq_ctxt.reset_event_fd);
+	sxe2_other_intr_unregister(dev);
+	sxe2_event_intr_handler_uinit();
+	sxe2_intr_handler_destroy(pci_dev->intr_handle,
+				sxe2_interrupt_handler_other, dev);
+	sxe2_event_intr_fd_destroy(adapter->irq_ctxt.other_event_fd);
+
+	adapter->irq_ctxt.other_event_fd = -1;
+	adapter->irq_ctxt.reset_event_fd = -1;
+	pci_dev->intr_handle = NULL;
+	adapter->irq_ctxt.reset_handle = NULL;
+}
+
+static int32_t sxe2_rxq_intr_efd_alloc(struct rte_eth_dev *dev, int32_t *efd)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	int32_t ret = 0;
+	int32_t fd = 0;
+
+	fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (fd < 0) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Can't setup eventfd, error %i (%s)",
+			errno, strerror(errno));
+		ret = -EBADF;
+		goto l_end;
+	}
+
+	*efd = fd;
+
+l_end:
+	return ret;
+}
+
+static void sxe2_rxq_intr_efd_free(int32_t efd)
+{
+	close(efd);
+}
+
+static void sxe2_pci_hw_int_itr_set(struct sxe2_adapter *adapter, uint16_t msix_idx, uint16_t itr)
+{
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_ITR, msix_idx, itr);
+}
+
+static void sxe2_pci_hw_irq_disable(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	uint32_t value = (SXE2_ITR_IDX_NONE << SXE2_VF_DYN_CTL_ITR_IDX_S);
+
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_DYN, irq_idx, value);
+}
+
+static void sxe2_pci_hw_irq_enable(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	uint32_t value = SXE2_VF_DYN_CTL_INTENABLE |
+		SXE2_VF_DYN_CTL_CLEARPBA |
+			(SXE2_ITR_IDX_NONE << SXE2_VF_DYN_CTL_ITR_IDX_S);
+
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_DYN, irq_idx, value);
+}
+
+static uint32_t sxe2_pci_hw_irq_dyn_ctl_read(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	return sxe2_pci_map_read_reg(adapter, SXE2_PCI_MAP_RES_IRQ_DYN, irq_idx);
+}
+
+static void sxe2_pci_hw_msix_disable(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX,
+			irq_idx, SXE2VF_BAR4_MSIX_DISABLE);
+}
+
+static void sxe2_pci_hw_msix_enable(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_MSIX,
+			irq_idx, SXE2VF_BAR4_MSIX_ENABLE);
+}
+
+static void sxe2_pci_hw_irq_trigger(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_DYN, irq_idx,
+			(SXE2VF_ITR_IDX_NONE << SXE2VF_DYN_CTL_ITR_IDX_SHIFT) |
+			SXE2VF_DYN_CTL_SWINT_TRIG | SXE2VF_DYN_CTL_INTENABLE_MSK);
+}
+
+static void sxe2_pci_hw_irq_clear_pba(struct sxe2_adapter *adapter, uint16_t irq_idx)
+{
+	sxe2_pci_map_write_reg(adapter, SXE2_PCI_MAP_RES_IRQ_DYN, irq_idx,
+		(SXE2VF_ITR_IDX_NONE << SXE2VF_DYN_CTL_ITR_IDX_SHIFT) |
+		SXE2VF_DYN_CTL_CLEARPBA | SXE2VF_DYN_CTL_INTENABLE_MSK);
+}
+
+static void sxe2_rxq_msix_cfg_unmap(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	uint16_t rxq_cnt = adapter->q_ctxt.qp_cnt_assign;
+	uint16_t i = 0;
+
+	for (i = 0; i < irq_ctxt->rxq_irq_cnt; i++)
+		sxe2_pci_hw_irq_disable(adapter, irq_ctxt->rxq_msix_idx[i]);
+
+	for (i = 0; i < rxq_cnt; i++)
+		(void)sxe2_drv_rxq_unbind_irq(adapter, i);
+}
+
+static int32_t sxe2_rxq_msix_cfg_map(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	int32_t ret = 0;
+	uint32_t val;
+	uint16_t rxq_cnt = dev->data->nb_rx_queues;
+	uint16_t i = 0;
+	uint8_t rx_low_latency = adapter->devargs.rx_low_latency;
+
+	for (i = 0; i < irq_ctxt->rxq_irq_cnt; i++) {
+		sxe2_pci_hw_irq_disable(adapter, irq_ctxt->rxq_msix_idx[i]);
+		if (rx_low_latency) {
+			sxe2_pci_hw_int_itr_set(adapter, irq_ctxt->rxq_msix_idx[i],
+					SXE2_ITR_INTERVAL_LOW);
+		} else {
+			sxe2_pci_hw_int_itr_set(adapter, irq_ctxt->rxq_msix_idx[i],
+					SXE2_ITR_INTERVAL_NORMAL);
+		}
+	}
+
+	for (i = 0; i < rxq_cnt; i++) {
+		ret = sxe2_drv_rxq_bind_irq(adapter, i, irq_ctxt->rxq_msix_idx[i]);
+		if (ret != 0) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "RXQ[%u] bind IRQ[%u] failed.",
+				i, irq_ctxt->rxq_msix_idx[i]);
+			goto l_end;
+		}
+	}
+
+	for (i = 0; i < irq_ctxt->rxq_irq_cnt; i++)
+		sxe2_pci_hw_irq_enable(adapter, irq_ctxt->rxq_msix_idx[i]);
+
+	for (i = 0; i < irq_ctxt->rxq_irq_cnt; i++) {
+		val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, i);
+		if ((val & SXE2VF_DYN_CTL_INTENABLE) == 0)
+			continue;
+
+		sxe2_pci_hw_msix_disable(adapter, i);
+		sxe2_pci_hw_irq_trigger(adapter, i);
+		val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, i);
+		sxe2_pci_hw_irq_clear_pba(adapter, i);
+		val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, i);
+		sxe2_pci_hw_msix_enable(adapter, i);
+	}
+
+l_end:
+	if (ret != 0)
+		sxe2_rxq_msix_cfg_unmap(dev);
+	return ret;
+}
+
+static int32_t sxe2_rxq_map_msix_intr(struct rte_eth_dev *dev,
+		uint16_t msix_base __rte_unused, uint16_t nb_msix,
+		uint16_t base_queue, uint16_t nb_queue)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	uint32_t *msix_tbl = NULL;
+	int32_t ret = 0;
+	uint16_t i;
+
+	if (!nb_queue || !nb_msix || nb_queue < nb_msix) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Queue num[%u] or msix num[%u] is invalid.",
+				nb_queue, nb_msix);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	msix_tbl = rte_zmalloc(NULL, sizeof(uint32_t) * nb_queue, 0);
+	if (!msix_tbl) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to alloc msix_tbl memory.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+	for (i = 0; i < nb_queue; i++) {
+		msix_tbl[i] = i % nb_msix;
+		PMD_DEV_LOG_INFO(adapter, INIT, "Queue %u is binding to vect %u",
+				base_queue + i, msix_tbl[i]);
+	}
+
+	irq_ctxt->rxq_irq_cnt = nb_msix;
+	irq_ctxt->rxq_msix_idx = msix_tbl;
+
+l_end:
+	return ret;
+}
+
+static void sxe2_rxq_unmap_msix_intr(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+
+	rte_free(irq_ctxt->rxq_msix_idx);
+	irq_ctxt->rxq_msix_idx = NULL;
+	irq_ctxt->rxq_irq_cnt = 0;
+}
+
+static int32_t sxe2_rxq_intr_register(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	struct rte_intr_handle *intr_handle = dev->intr_handle;
+	int32_t *efd_tbl = NULL;
+	uint16_t rxq_cnt = dev->data->nb_rx_queues;
+	uint16_t nb_msix = irq_ctxt->rxq_irq_cnt;
+	uint16_t i;
+	int32_t ret = 0;
+
+	if (rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_EXT)) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set intr_handle->type, error %i (%s)",
+				errno, strerror(errno));
+		ret = -EPERM;
+		goto l_end;
+	}
+
+	efd_tbl = rte_zmalloc(NULL, sizeof(int32_t) * nb_msix, 0);
+	if (!efd_tbl) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to alloc efd_tbl memory.");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	for (i = 0; i < nb_msix; i++) {
+		ret = sxe2_rxq_intr_efd_alloc(dev, &efd_tbl[i]);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to alloc efd_tbl, ret=%d", ret);
+			goto l_free_efd_tbl;
+		}
+	}
+
+	if (rte_intr_vec_list_alloc(intr_handle, "sxe2 rxq int", rxq_cnt)) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to allocate %d rx_queues intr_vec",
+				rxq_cnt);
+		ret = -ENOMEM;
+		goto l_free_efd_tbl;
+	}
+
+	for	(i = 0; i < rxq_cnt; i++) {
+		ret = rte_intr_vec_list_index_set(intr_handle, i,
+				irq_ctxt->rxq_msix_idx[i] + RTE_INTR_VEC_RXTX_OFFSET);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set msix_tbl, ret=%d", ret);
+			goto l_free_efd_tbl;
+		}
+	}
+
+	for (i = 0; i < irq_ctxt->rxq_irq_cnt; i++) {
+		ret = rte_intr_efds_index_set(intr_handle, i, efd_tbl[i]);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set efd_tbl, ret=%d", ret);
+			goto l_free_efd_tbl;
+		}
+	}
+
+	if (rte_intr_nb_efd_set(intr_handle, rxq_cnt)) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Set intr nb efd failed, error %i (%s)",
+			errno, strerror(errno));
+		ret = -EPERM;
+		goto l_free_efd_tbl;
+	}
+
+	ret = sxe2_drv_dev_rxq_irq_set(adapter->cdev, 0, efd_tbl, nb_msix);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to set rxq irq, ret=%d", ret);
+		goto l_free_efd_tbl;
+	}
+	irq_ctxt->rxq_event_fd = efd_tbl;
+
+	goto l_end;
+
+l_free_efd_tbl:
+	if (efd_tbl) {
+		for (i = 0; i < nb_msix; i++)
+			if (efd_tbl[i] >= 0)
+				sxe2_rxq_intr_efd_free(efd_tbl[i]);
+		rte_free(efd_tbl);
+	}
+	irq_ctxt->rxq_event_fd = NULL;
+
+	rte_intr_vec_list_free(intr_handle);
+l_end:
+	return ret;
+}
+
+static void sxe2_rxq_intr_unregister(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	struct rte_intr_handle *intr_handle = dev->intr_handle;
+	int32_t efd = -1;
+	uint16_t msix_cnt = irq_ctxt->rxq_irq_cnt;
+	uint16_t i;
+
+	if (irq_ctxt->rxq_event_fd) {
+		for (i = 0; i < msix_cnt; i++) {
+			(void)sxe2_drv_dev_rxq_irq_set(adapter->cdev, i, &efd, 1);
+			sxe2_rxq_intr_efd_free(irq_ctxt->rxq_event_fd[i]);
+		}
+	}
+	rte_free(irq_ctxt->rxq_event_fd);
+	irq_ctxt->rxq_event_fd = NULL;
+
+	rte_intr_vec_list_free(intr_handle);
+
+	rte_intr_nb_efd_set(intr_handle, 0);
+	rte_intr_max_intr_set(intr_handle, 0);
+}
+
+int32_t sxe2_rxq_intr_enable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	uint16_t msix_vect = adapter->irq_ctxt.rxq_base_idx_in_pf;
+	uint16_t msix_cnt = adapter->irq_ctxt.rxq_avail_cnt;
+	uint16_t rxq_cnt = dev->data->nb_rx_queues;
+	uint16_t rxq_base = adapter->q_ctxt.base_idx_in_pf;
+	int32_t ret = 0;
+
+	if (!rxq_cnt)
+		goto l_end;
+
+	msix_cnt = RTE_MIN(msix_cnt, rxq_cnt);
+
+	ret = sxe2_rxq_map_msix_intr(dev, msix_vect, msix_cnt, rxq_base, rxq_cnt);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to rxq[%d] map msix[%d] intr, cnt=%d, ret=%d",
+					rxq_base, msix_vect, rxq_cnt, ret);
+		goto l_end;
+	}
+
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		ret = sxe2_rxq_intr_register(dev);
+		if (ret) {
+			PMD_DEV_LOG_ERR(adapter, INIT, "Failed to register rxq[%d] intr, ret=%d",
+					rxq_base, ret);
+			goto l_err_unmap;
+		}
+	}
+
+	ret = sxe2_rxq_msix_cfg_map(dev);
+	if (ret) {
+		PMD_DEV_LOG_ERR(adapter, INIT, "Failed to rxq[%d] map msix[%d] intr, ret=%d",
+					rxq_base, msix_vect, ret);
+		goto l_err_unregister;
+	}
+
+	goto l_end;
+l_err_unregister:
+	if (dev->data->dev_conf.intr_conf.rxq)
+		sxe2_rxq_intr_unregister(dev);
+l_err_unmap:
+	sxe2_rxq_unmap_msix_intr(dev);
+l_end:
+	return ret;
+}
+
+void sxe2_rxq_intr_disable(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+
+	if (!irq_ctxt->rxq_irq_cnt)
+		goto l_end;
+
+	sxe2_rxq_msix_cfg_unmap(dev);
+
+	if (dev->data->dev_conf.intr_conf.rxq)
+		sxe2_rxq_intr_unregister(dev);
+
+	sxe2_rxq_unmap_msix_intr(dev);
+
+l_end:
+	return;
+}
+
+int32_t sxe2_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	struct sxe2_irq_context *irq_ctxt = &adapter->irq_ctxt;
+	uint64_t buf;
+	uint16_t irq_idx = irq_ctxt->rxq_msix_idx[queue_id];
+	size_t read_ret;
+
+	read_ret = read(irq_ctxt->rxq_event_fd[irq_idx], &buf, sizeof(buf));
+	(void)read_ret;
+	sxe2_pci_hw_irq_enable(adapter, irq_idx);
+	return 0;
+}
+
+int32_t sxe2_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct sxe2_adapter *adapter =
+		SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	uint32_t val;
+	int32_t ret = 0;
+	uint16_t irq_idx = adapter->irq_ctxt.rxq_msix_idx[queue_id];
+
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, irq_idx);
+	if ((val & SXE2VF_DYN_CTL_INTENABLE) == 0) {
+		PMD_DEV_LOG_DEBUG(adapter, INIT, "rxq [%d] interrupt is disabled.", queue_id);
+		goto l_end;
+	}
+
+	sxe2_pci_hw_msix_disable(adapter, irq_idx);
+	sxe2_pci_hw_irq_trigger(adapter, irq_idx);
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, irq_idx);
+	sxe2_pci_hw_irq_clear_pba(adapter, irq_idx);
+	val = sxe2_pci_hw_irq_dyn_ctl_read(adapter, irq_idx);
+	sxe2_pci_hw_msix_enable(adapter, irq_idx);
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe2/sxe2_irq.h b/drivers/net/sxe2/sxe2_irq.h
index bb96c6d842..c898c16f84 100644
--- a/drivers/net/sxe2/sxe2_irq.h
+++ b/drivers/net/sxe2/sxe2_irq.h
@@ -45,4 +45,25 @@ struct sxe2_irq_context {
 	int32_t *rxq_event_fd;
 };
 
+uint32_t sxe2_drv_dev_other_cause_get(struct sxe2_adapter *adapter);
+
+int32_t sxe2_intr_init(struct rte_eth_dev *dev);
+
+void sxe2_intr_uninit(struct rte_eth_dev *dev);
+
+int32_t sxe2_sw_irq_ctxt_init(struct rte_eth_dev *dev);
+
+void sxe2_sw_irq_ctxt_uninit(struct rte_eth_dev *dev);
+
+void sxe2_sw_irq_ctx_hw_cap_set(struct sxe2_adapter *adapter,
+		struct sxe2_drv_msix_caps *msix_caps);
+
+int32_t sxe2_rxq_intr_enable(struct rte_eth_dev *dev);
+
+void sxe2_rxq_intr_disable(struct rte_eth_dev *dev);
+
+int32_t sxe2_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+
+int32_t sxe2_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
+
 #endif /* __SXE2_IRQ_H__ */
diff --git a/drivers/net/sxe2/sxe2vf_regs.h b/drivers/net/sxe2/sxe2vf_regs.h
new file mode 100644
index 0000000000..503c7ce04f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2vf_regs.h
@@ -0,0 +1,82 @@
+
+#ifndef __SXE2VF_REGS_H__
+#define __SXE2VF_REGS_H__
+
+#define SXE2VF_MBX_Q_LEN_M      0x3FF
+#define SXE2VF_MBX_Q_LEN_VFE_M  RTE_BIT32(28)
+
+#define SXE2VF_MBX_Q_LEN_OVFL_M RTE_BIT32(29)
+#define SXE2VF_MBX_Q_LEN_CRIT_M RTE_BIT32(30)
+#define SXE2VF_MBX_Q_LEN_ENA_M  RTE_BIT32(31)
+
+#define SXE2VF_MBX_RQ_HEAD      (0x00008000)
+#define SXE2VF_MBX_RQ_TAIL      (0x00008400)
+#define SXE2VF_MBX_RQ_LEN       (0x00007C00)
+#define SXE2VF_MBX_RQ_BAH       (0x00007800)
+#define SXE2VF_MBX_RQ_BAL       (0x00007400)
+
+#define SXE2VF_MBX_TQ_HEAD      (0x00006C00)
+#define SXE2VF_MBX_TQ_TAIL      (0x00007000)
+#define SXE2VF_MBX_TQ_LEN       (0x00006800)
+#define SXE2VF_MBX_TQ_BAH       (0x00006400)
+#define SXE2VF_MBX_TQ_BAL       (0x00006000)
+
+#define SXE2VF_RXQ_TAIL(_QRX)                 (0x2000 + ((_QRX) * 4))
+#define SXE2VF_TXQ_TAIL(_QRX)                 (0x1000 + ((_QRX) * 4))
+
+#define SXE2VF_INT_BASE 0x00002800
+
+#define SXE2VF_DYN_CTL0 (SXE2VF_INT_BASE + 0x0)
+
+#define SXE2VF_DYN_CTL(_idx) (SXE2VF_INT_BASE + 0x4 + ((_idx) * 4))
+#define SXE2VF_VF_DYN_CTL(_idx) (SXE2VF_INT_BASE + ((_idx) * 4))
+
+#define SXE2VF_BAR4_MSIX_BASE 0
+#define SXE2VF_BAR4_MSIX_CTL(_idx) (SXE2VF_BAR4_MSIX_BASE + 0xC + ((_idx) * 0x10))
+#define SXE2VF_BAR4_MSIX_ENABLE 0
+#define SXE2VF_BAR4_MSIX_DISABLE 1
+
+#define SXE2VF_DYN_CTL_INTENABLE RTE_BIT32(0)
+#define SXE2VF_DYN_CTL_CLEARPBA   RTE_BIT32(1)
+#define SXE2VF_DYN_CTL_SWINT_TRIG RTE_BIT32(2)
+#define SXE2VF_DYN_CTL_SW_ITR_IDX_ENABLE RTE_BIT32(24)
+
+#define SXE2VF_DYN_CTL_INTENABLE_MSK \
+	RTE_BIT32(31)
+
+#define SXE2VF_DYN_CTL_ITR_IDX_SHIFT 3
+
+enum sxe2vf_itr_idx {
+	SXE2VF_ITR_IDX_0 = 0,
+	SXE2VF_ITR_IDX_1,
+	SXE2VF_ITR_IDX_2,
+	SXE2VF_ITR_IDX_NONE,
+};
+
+#define SXE2VF_INT_ITR0   (0x00002800 + 65 * 0x4)
+#define SXE2VF_INT_ITR(_i, _irq_idx) (SXE2VF_INT_ITR0 + \
+			0x4 + (_i) * 0x104 + ((_irq_idx) * 4))
+#define SXE2VF_VF_INT_ITR(_itr_idx, _irq_idx) (0x00002800 + \
+			(0x104 * (_itr_idx)) + ((_irq_idx) * 4))
+#define SXE2VF_PFG_INT_CTL_ITR_GRAN_0    (2)
+
+#define SXE2VF_PCIE_SYS_READY              0x38c
+#define SXE2VF_PCIE_SYS_READY_CORER_ASSERT RTE_BIT32(0)
+#define SXE2VF_PCIE_SYS_READY_STOP_DROP_DONE RTE_BIT32(2)
+#define SXE2VF_PCIE_SYS_READY_R5        RTE_BIT32(3)
+#define SXE2VF_PCIE_SYS_READY_STOP_DROP RTE_BIT32(16)
+
+#define SXE2VF_PCIE_DEV_CTRL_DEV_STATUS               0x78
+#define SXE2VF_PCIE_DEV_CTRL_DEV_STATUS_TRANS_PENDING RTE_BIT32(21)
+
+#define SXE2VF_VF_VRC_VFGEN_RSTAT             (0x5800)
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT           GENMASK(1, 0)
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT_VFR       (0)
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT_COMPLETE  (RTE_BIT32(0))
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT_VF_ACTIVE (RTE_BIT32(1))
+
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT_FORVF_VFR (1)
+#define SXE2VF_VF_VRC_VFGEN_VFRSTAT_FORVF_MASK \
+	(RTE_BIT32(10))
+
+#endif /* SXE2VF_VF_INT_ITR */
-- 
2.47.3

