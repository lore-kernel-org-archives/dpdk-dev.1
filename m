Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC32CD343B
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 11:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07B1940B9B;
	Wed,  6 May 2026 13:36:23 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 946B840661
 for <dev@dpdk.org>; Wed,  6 May 2026 13:36:18 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowABHs26oJ_tpEyFuDw--.16283S11;
 Wed, 06 May 2026 19:36:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 09/10] drivers: add data path for Rx and Tx
Date: Wed,  6 May 2026 19:35:55 +0800
Message-ID: <20260506113557.1151250-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506113557.1151250-1-liujie5@linkdatatechnology.com>
References: <20260506095704.1056840-11-liujie5@linkdatatechnology.com>
 <20260506113557.1151250-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABHs26oJ_tpEyFuDw--.16283S11
X-Coremail-Antispam: 1UD129KBjvAXoWDWFW3Kr4Uuw4UWr1UtFykGrg_yoWrZFWDZo
 WIga1aqr1fXrnrC3yDX3WxZFW7t3yFq3yUCayF9Fs09F4rC3Z8GasrK347Aw1UJF1rtF10
 g3WxZFZ2vr4xJrW7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYE7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
 Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
 84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_
 Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
 IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
 Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0w
 CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
 6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64
 vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42
 IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU=
 =
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

Implement receive and transmit burst functions for sxe2 PMD.
Add sxe2_recv_pkts and sxe2_xmit_pkts as the primary data path
interfaces.

The implementation includes:
- Efficient descriptor fetching and mbuf allocation for Rx.
- Descriptor setup and checksum offload handling for Tx.
- Buffer recycling and hardware tail pointer updates.
- Performance-oriented loop unrolling and prefetching where applicable.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c     |  13 +-
 drivers/common/sxe2/sxe2_common_log.h | 105 ----
 drivers/common/sxe2/sxe2_errno.h      |   3 -
 drivers/common/sxe2/sxe2_ioctl_chnl.c |  20 +-
 drivers/common/sxe2/sxe2_osal.h       |   4 +-
 drivers/common/sxe2/sxe2_type.h       |   1 -
 drivers/net/sxe2/meson.build          |   2 +
 drivers/net/sxe2/sxe2_ethdev.c        |  15 +-
 drivers/net/sxe2/sxe2_txrx.c          | 249 ++++++++
 drivers/net/sxe2/sxe2_txrx.h          |  21 +
 drivers/net/sxe2/sxe2_txrx_poll.c     | 782 ++++++++++++++++++++++++++
 11 files changed, 1082 insertions(+), 133 deletions(-)
 create mode 100644 drivers/net/sxe2/sxe2_txrx.c
 create mode 100644 drivers/net/sxe2/sxe2_txrx.h
 create mode 100644 drivers/net/sxe2/sxe2_txrx_poll.c

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index 537d4e9f6a..d2ed1460a3 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -28,7 +28,7 @@ static TAILQ_HEAD(sxe2_class_drivers, sxe2_class_driver) sxe2_class_drivers_list
 static TAILQ_HEAD(sxe2_common_devices, sxe2_common_device) sxe2_common_devices_list =
 				TAILQ_HEAD_INITIALIZER(sxe2_common_devices_list);
 
-static pthread_mutex_t sxe2_common_devices_list_lock;
+static rte_spinlock_t sxe2_common_devices_list_lock;
 
 static struct rte_pci_id *sxe2_common_pci_id_table;
 
@@ -223,9 +223,9 @@ static struct sxe2_common_device *sxe2_common_device_alloc(
 	cdev->config.kernel_reset = false;
 	rte_ticketlock_init(&cdev->config.lock);
 
-	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	rte_spinlock_lock(&sxe2_common_devices_list_lock);
 	TAILQ_INSERT_TAIL(&sxe2_common_devices_list, cdev, next);
-	(void)pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+	rte_spinlock_unlock(&sxe2_common_devices_list_lock);
 
 l_end:
 	return cdev;
@@ -233,10 +233,9 @@ static struct sxe2_common_device *sxe2_common_device_alloc(
 
 static void sxe2_common_device_free(struct sxe2_common_device *cdev)
 {
-
-	(void)pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	rte_spinlock_lock(&sxe2_common_devices_list_lock);
 	TAILQ_REMOVE(&sxe2_common_devices_list, cdev, next);
-	(void)pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+	rte_spinlock_unlock(&sxe2_common_devices_list_lock);
 
 	rte_free(cdev);
 }
@@ -662,7 +661,7 @@ sxe2_common_init(void)
 	if (sxe2_commoin_inited)
 		goto l_end;
 
-	pthread_mutex_init(&sxe2_common_devices_list_lock, NULL);
+	rte_spinlock_init(&sxe2_common_devices_list_lock);
 #ifdef SXE2_DPDK_DEBUG
 	sxe2_common_log_stream_init();
 #endif
diff --git a/drivers/common/sxe2/sxe2_common_log.h b/drivers/common/sxe2/sxe2_common_log.h
index 8ade49d020..14074fcc4f 100644
--- a/drivers/common/sxe2/sxe2_common_log.h
+++ b/drivers/common/sxe2/sxe2_common_log.h
@@ -260,109 +260,4 @@ sxe2_common_log_stream_init(void);
 
 #define PMD_INIT_FUNC_TRACE() PMD_LOG_DEBUG(INIT, " >>")
 
-#ifdef SXE2_DPDK_DEBUG
-
-#define LOG_DEBUG(fmt, ...) \
-		PMD_LOG_DEBUG(DRV, fmt, ##__VA_ARGS__)
-
-#define LOG_INFO(fmt, ...) \
-		PMD_LOG_INFO(DRV, fmt, ##__VA_ARGS__)
-
-#define LOG_WARN(fmt, ...) \
-		PMD_LOG_WARN(DRV, fmt, ##__VA_ARGS__)
-
-#define LOG_ERROR(fmt, ...) \
-		PMD_LOG_ERR(DRV, fmt, ##__VA_ARGS__)
-
-#define LOG_DEBUG_BDF(dev_name, fmt, ...) \
-		PMD_LOG_DEBUG(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_INFO_BDF(dev_name, fmt, ...) \
-		PMD_LOG_INFO(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_WARN_BDF(dev_name, fmt, ...) \
-		PMD_LOG_WARN(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_ERROR_BDF(dev_name, fmt, ...) \
-		PMD_LOG_ERR(HW, fmt, ##__VA_ARGS__)
-
-#else
-#define LOG_DEBUG(fmt, ...)
-#define LOG_INFO(fmt, ...)
-#define LOG_WARN(fmt, ...)
-#define LOG_ERROR(fmt, ...)
-#define LOG_DEBUG_BDF(dev_name, fmt, ...) \
-		PMD_LOG_DEBUG(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_INFO_BDF(dev_name, fmt, ...) \
-		PMD_LOG_INFO(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_WARN_BDF(dev_name, fmt, ...) \
-		PMD_LOG_WARN(HW, fmt, ##__VA_ARGS__)
-
-#define LOG_ERROR_BDF(dev_name, fmt, ...) \
-		PMD_LOG_ERR(HW, fmt, ##__VA_ARGS__)
-#endif
-
-#ifdef SXE2_DPDK_DEBUG
-#define LOG_DEV_DEBUG(fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-			LOG_DEBUG_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_DEV_INFO(fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-		LOG_INFO_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_DEV_WARN(fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-		LOG_WARN_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_DEV_ERR(fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-			LOG_ERROR_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_MSG_DEBUG(msglvl, fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-			LOG_DEBUG_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_MSG_INFO(msglvl, fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-		LOG_INFO_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_MSG_WARN(msglvl, fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-		LOG_WARN_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#define LOG_MSG_ERR(msglvl, fmt, ...) \
-	do { \
-		RTE_SET_USED(adapter); \
-			LOG_ERROR_BDF(fmt, ##__VA_ARGS__); \
-	} while (0)
-
-#else
-
-#define LOG_DEV_DEBUG(fmt, ...)         RTE_SET_USED(adapter)
-#define LOG_DEV_INFO(fmt, ...)          RTE_SET_USED(adapter)
-#define LOG_DEV_WARN(fmt, ...)          RTE_SET_USED(adapter)
-#define LOG_DEV_ERR(fmt, ...)           RTE_SET_USED(adapter)
-#define LOG_MSG_DEBUG(msglvl, fmt, ...) RTE_SET_USED(adapter)
-#define LOG_MSG_INFO(msglvl, fmt, ...)  RTE_SET_USED(adapter)
-#define LOG_MSG_WARN(msglvl, fmt, ...)  RTE_SET_USED(adapter)
-#define LOG_MSG_ERR(msglvl, fmt, ...)   RTE_SET_USED(adapter)
-#endif
-
 #endif /* SXE2_COMMON_LOG_H__ */
diff --git a/drivers/common/sxe2/sxe2_errno.h b/drivers/common/sxe2/sxe2_errno.h
index 89a715eaef..1257319edf 100644
--- a/drivers/common/sxe2/sxe2_errno.h
+++ b/drivers/common/sxe2/sxe2_errno.h
@@ -50,9 +50,6 @@ enum sxe2_status {
 	SXE2_ERR_NOLCK              = -ENOLCK,
 	SXE2_ERR_NOSYS              = -ENOSYS,
 	SXE2_ERR_NOTEMPTY           = -ENOTEMPTY,
-	SXE2_ERR_ILSEQ              = -EILSEQ,
-	SXE2_ERR_NODATA             = -ENODATA,
-	SXE2_ERR_CANCELED           = -ECANCELED,
 	SXE2_ERR_TIMEDOUT           = -ETIMEDOUT,
 
 	SXE2_ERROR                  = -150,
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 1a14d401e7..cb83fb837d 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -37,7 +37,7 @@ sxe2_drv_cmd_exec(struct sxe2_common_device *cdev,
 
 	if (cdev->config.kernel_reset) {
 		ret = SXE2_ERR_PERM;
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_end;
 	}
 
@@ -123,7 +123,7 @@ sxe2_drv_dev_handshark(struct sxe2_common_device *cdev)
 
 	if (cdev->config.kernel_reset) {
 		ret = SXE2_ERR_PERM;
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_end;
 	}
 
@@ -168,7 +168,7 @@ void
 	void *virt = NULL;
 
 	if (cdev->config.kernel_reset) {
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_err;
 	}
 
@@ -178,13 +178,13 @@ void
 		goto l_err;
 	}
 
-	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=0x%zx, src=0x%"PRIx64", offset=0x%"PRIx64"",
+	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=%"PRIu64", src=0x%"PRIx64", offset=0x%"PRIx64"",
 		bar_idx, cmd_fd, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
 
 	virt = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		MAP_SHARED, cmd_fd, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
 	if (virt == MAP_FAILED) {
-		PMD_LOG_ERR(COM, "Failed mmap, cmd_fd=%d, len=0x%zx, offset=0x%"PRIx64", err:%s",
+		PMD_LOG_ERR(COM, "Failed mmap, cmd_fd=%d, len=%"PRIu64", offset=0x%"PRIx64", err:%s",
 			cmd_fd, len, offset, strerror(errno));
 		goto l_err;
 	}
@@ -206,12 +206,12 @@ sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, u64 len)
 		goto l_end;
 	}
 
-	PMD_LOG_DEBUG(COM, "Munmap virt=%p, len=0x%zx",
+	PMD_LOG_DEBUG(COM, "Munmap virt=%p, len=0x%"PRIx64"",
 		virt, len);
 
 	ret = munmap(virt, len);
 	if (ret < 0) {
-		PMD_LOG_ERR(COM, "Failed to munmap, virt=%p, len=0x%zx, err:%s",
+		PMD_LOG_ERR(COM, "Failed to munmap, virt=%p, len=%"PRIu64", err:%s",
 			virt, len, strerror(errno));
 		ret = SXE2_ERR_IO;
 		goto l_end;
@@ -233,7 +233,7 @@ sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, u64 vaddr,
 
 	if (cdev->config.kernel_reset) {
 		ret = SXE2_ERR_PERM;
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_end;
 	}
 
@@ -246,7 +246,7 @@ sxe2_drv_dev_dma_map(struct sxe2_common_device *cdev, u64 vaddr,
 		goto l_end;
 	} else if (iova_mode == RTE_IOVA_VA) {
 		if (!cdev->config.support_iommu) {
-			PMD_LOG_ERR(COM, "no iommu not support va mode, plese use pa mode.");
+			PMD_LOG_ERR(COM, "no iommu not support va mode, please use pa mode.");
 			ret = SXE2_ERR_IO;
 			goto l_end;
 		}
@@ -289,7 +289,7 @@ sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, u64 iova)
 
 	if (cdev->config.kernel_reset) {
 		ret = SXE2_ERR_PERM;
-		PMD_LOG_WARN(COM, "kernel reseted, need restart app.");
+		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
 		goto l_end;
 	}
 
diff --git a/drivers/common/sxe2/sxe2_osal.h b/drivers/common/sxe2/sxe2_osal.h
index fd6823fe98..23882f3f52 100644
--- a/drivers/common/sxe2/sxe2_osal.h
+++ b/drivers/common/sxe2/sxe2_osal.h
@@ -29,8 +29,6 @@
 #define BIT_ULL(a) (1ULL << (a))
 #endif
 
-#define MIN(a, b) ((a) < (b) ? (a) : (b))
-
 #define BITS_PER_BYTE 8
 
 #define IS_UNICAST_ETHER_ADDR(addr)			\
@@ -88,7 +86,7 @@
 			(((n) + (typeof(n))(d) - (typeof(n))1) / (typeof(n))(d))
 #endif
 
-#define usleep_range(min, max) msleep(DIV_ROUND_UP(min, 1000))
+#define usleep_range(min) msleep(DIV_ROUND_UP(min, 1000))
 
 #define __bf_shf(x) ((uint32_t)rte_bsf64(x))
 
diff --git a/drivers/common/sxe2/sxe2_type.h b/drivers/common/sxe2/sxe2_type.h
index 56d0a11f48..fbf4a6674f 100644
--- a/drivers/common/sxe2/sxe2_type.h
+++ b/drivers/common/sxe2/sxe2_type.h
@@ -8,7 +8,6 @@
 #include <sys/time.h>
 
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <stdarg.h>
 #include <unistd.h>
diff --git a/drivers/net/sxe2/meson.build b/drivers/net/sxe2/meson.build
index 61467a4e31..b331451160 100644
--- a/drivers/net/sxe2/meson.build
+++ b/drivers/net/sxe2/meson.build
@@ -25,6 +25,8 @@ sources += files(
         'sxe2_queue.c',
         'sxe2_tx.c',
         'sxe2_rx.c',
+        'sxe2_txrx_poll.c',
+        'sxe2_txrx.c',
 )
 
 allow_internal_get_api = true
diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index c1a65f25ce..68d7e36cf1 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -26,6 +26,7 @@
 #include "sxe2_cmd_chnl.h"
 #include "sxe2_tx.h"
 #include "sxe2_rx.h"
+#include "sxe2_txrx.h"
 #include "sxe2_common.h"
 #include "sxe2_common_log.h"
 #include "sxe2_host_regs.h"
@@ -131,6 +132,9 @@ static s32 sxe2_dev_start(struct rte_eth_dev *dev)
 		goto l_end;
 	}
 
+	sxe2_rx_mode_func_set(dev);
+	sxe2_tx_mode_func_set(dev);
+
 	ret = sxe2_queues_start(dev);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "enable queues failed");
@@ -363,8 +367,8 @@ void __iomem *sxe2_pci_map_addr_get(struct sxe2_adapter *adapter,
 	for (i = 0; i < bar_info->map_cnt; i++) {
 		seg_info = &bar_info->seg_info[i];
 		if (res_type == seg_info->type) {
-			addr = (void __iomem *)((uintptr_t)seg_info->addr +
-					seg_info->page_inner_offset + reg_width	* idx_in_func);
+			addr = (uint8_t __iomem *)seg_info->addr +
+					seg_info->page_inner_offset + reg_width * idx_in_func;
 			goto l_end;
 		}
 	}
@@ -475,8 +479,9 @@ s32 sxe2_dev_pci_seg_map(struct sxe2_adapter *adapter,
 
 	map_addr = sxe2_drv_dev_mmap(adapter->cdev, bar_info->bar_idx, aligned_len, aligned_offset);
 	if (!map_addr) {
-		PMD_LOG_ERR(INIT, "Failed to mmap BAR space, type=%d, len=%zu, page_size=%zu",
-					res_type, org_len, page_size);
+		PMD_LOG_ERR(INIT, "Failed to mmap BAR space, type=%d, len=%" PRIu64
+			", offset=%" PRIu64 ", page_size=%zu",
+					res_type, org_len, org_offset, page_size);
 		ret = SXE2_ERR_FAULT;
 		goto l_end;
 	}
@@ -760,6 +765,8 @@ static s32 sxe2_dev_init(struct rte_eth_dev *dev, struct sxe2_dev_kvargs_info *k
 
 	PMD_INIT_FUNC_TRACE();
 
+	sxe2_set_common_function(dev);
+
 	dev->dev_ops = &sxe2_eth_dev_ops;
 
 	ret = sxe2_hw_init(dev);
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
new file mode 100644
index 0000000000..3e88ab5241
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_common.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <ethdev_driver.h>
+#include <unistd.h>
+
+#include "sxe2_txrx.h"
+#include "sxe2_txrx_common.h"
+#include "sxe2_txrx_poll.h"
+#include "sxe2_ethdev.h"
+
+#include "sxe2_common_log.h"
+#include "sxe2_errno.h"
+#include "sxe2_osal.h"
+#include "sxe2_cmd_chnl.h"
+#if defined(RTE_ARCH_ARM64)
+#include <rte_cpuflags.h>
+#endif
+
+static s32 sxe2_tx_desciptor_status(void *tx_queue, u16 offset)
+{
+	struct sxe2_tx_queue *txq = (struct sxe2_tx_queue *)tx_queue;
+	s32 ret;
+	u16 desc_idx;
+
+	if (unlikely(offset >= txq->ring_depth)) {
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	desc_idx = txq->next_use + offset;
+	desc_idx = DIV_ROUND_UP(desc_idx, txq->rs_thresh) * (txq->rs_thresh);
+	if (desc_idx >= txq->ring_depth) {
+		desc_idx -= txq->ring_depth;
+		if (desc_idx >= txq->ring_depth)
+			desc_idx -= txq->ring_depth;
+	}
+
+	if (desc_idx == 0)
+		desc_idx = txq->rs_thresh - 1;
+	else
+		desc_idx -= 1;
+
+	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) ==
+		(txq->desc_ring[desc_idx].wb.dd &
+		rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_MASK)))
+		ret = RTE_ETH_TX_DESC_DONE;
+	else
+		ret = RTE_ETH_TX_DESC_FULL;
+
+l_end:
+	return ret;
+}
+
+static inline s32 sxe2_tx_mbuf_empty_check(struct rte_mbuf *mbuf)
+{
+	struct rte_mbuf *m_seg = mbuf;
+
+	while (m_seg != NULL) {
+		if (m_seg->data_len == 0)
+			return SXE2_ERR_INVAL;
+		m_seg = m_seg->next;
+	}
+
+	return SXE2_SUCCESS;
+}
+
+u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
+		struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	struct sxe2_tx_queue *txq = tx_queue;
+	struct rte_mbuf *mbuf;
+	u64 ol_flags = 0;
+	s32 ret = SXE2_SUCCESS;
+	s32 i = 0;
+
+	for (i = 0; i < nb_pkts; i++) {
+		mbuf = tx_pkts[i];
+		if (!mbuf)
+			continue;
+		ol_flags = mbuf->ol_flags;
+		if (!(ol_flags & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))) {
+			if (mbuf->nb_segs > SXE2_TX_MTU_SEG_MAX ||
+					mbuf->pkt_len > SXE2_FRAME_SIZE_MAX) {
+				rte_errno = -SXE2_ERR_INVAL;
+				goto l_end;
+			}
+		} else if ((mbuf->tso_segsz < SXE2_MIN_TSO_MSS) ||
+			(mbuf->tso_segsz > SXE2_MAX_TSO_MSS) ||
+			(mbuf->nb_segs   > txq->ring_depth) ||
+			(mbuf->pkt_len > SXE2_TX_TSO_PKTLEN_MAX)) {
+			rte_errno = -SXE2_ERR_INVAL;
+			goto l_end;
+		}
+
+		if (mbuf->pkt_len < SXE2_TX_MIN_PKT_LEN) {
+			rte_errno = -SXE2_ERR_INVAL;
+			goto l_end;
+		}
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+		ret = rte_validate_tx_offload(mbuf);
+		if (ret != SXE2_SUCCESS) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+#endif
+		ret = rte_net_intel_cksum_prepare(mbuf);
+		if (ret != SXE2_SUCCESS) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+
+		ret = sxe2_tx_mbuf_empty_check(mbuf);
+		if (ret != SXE2_SUCCESS) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return i;
+}
+
+void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	u32 tx_mode_flags = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+	dev->tx_pkt_burst = sxe2_tx_pkts;
+	adapter->q_ctxt.tx_mode_flags = tx_mode_flags;
+	PMD_LOG_DEBUG(TX, "Tx mode flags:0x%016x port_id:%u.",
+				tx_mode_flags, dev->data->port_id);
+}
+
+static s32 sxe2_rx_desciptor_status(void *rx_queue, u16 offset)
+{
+	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
+	volatile union sxe2_rx_desc *desc;
+	s32 ret;
+
+	if (unlikely(offset >= rxq->ring_depth)) {
+		ret = SXE2_ERR_INVAL;
+		goto l_end;
+	}
+
+	if (offset >= rxq->ring_depth - rxq->hold_num) {
+		ret = RTE_ETH_RX_DESC_UNAVAIL;
+		goto l_end;
+	}
+
+	if (rxq->processing_idx + offset >= rxq->ring_depth)
+		desc = &rxq->desc_ring[rxq->processing_idx + offset - rxq->ring_depth];
+	else
+		desc = &rxq->desc_ring[rxq->processing_idx + offset];
+
+	if (rte_le_to_cpu_64(desc->wb.status_err_ptype_len) & SXE2_RX_DESC_STATUS_DD_MASK)
+		ret = RTE_ETH_RX_DESC_DONE;
+	else
+		ret = RTE_ETH_RX_DESC_AVAIL;
+
+l_end:
+	PMD_LOG_DEBUG(RX, "Rx queue desc[%u] status:%d queue_id:%u port_id:%u",
+				offset, ret, rxq->queue_id, rxq->port_id);
+	return ret;
+}
+
+static s32 sxe2_rx_queue_count(void *rx_queue)
+{
+	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
+	volatile union sxe2_rx_desc *desc;
+	u16 done_num = 0;
+
+	desc = &rxq->desc_ring[rxq->processing_idx];
+	while ((done_num < rxq->ring_depth) &&
+		(rte_le_to_cpu_64(desc->wb.status_err_ptype_len) &
+		SXE2_RX_DESC_STATUS_DD_MASK)) {
+		done_num += SXE2_RX_QUEUE_CHECK_INTERVAL_NUM;
+		if (rxq->processing_idx + done_num >= rxq->ring_depth)
+			desc = &rxq->desc_ring[rxq->processing_idx + done_num - rxq->ring_depth];
+		else
+			desc += SXE2_RX_QUEUE_CHECK_INTERVAL_NUM;
+	}
+
+	PMD_LOG_DEBUG(RX, "Rx queue done desc count:%u queue_id:%u port_id:%u",
+				done_num, rxq->queue_id, rxq->port_id);
+
+	return done_num;
+}
+
+static bool __rte_cold sxe2_rx_offload_en_check(struct rte_eth_dev *dev, u64 offload)
+{
+	struct sxe2_rx_queue *rxq;
+	bool en = false;
+	u16 i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; ++i) {
+		rxq = (struct sxe2_rx_queue *)dev->data->rx_queues[i];
+		if (rxq == NULL)
+			continue;
+
+		if (0 != (rxq->offloads & offload)) {
+			en = true;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return en;
+}
+
+void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
+{
+	struct sxe2_adapter *adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(dev);
+	u32 rx_mode_flags = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (sxe2_rx_offload_en_check(dev, RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT))
+		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_split;
+	else
+		dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
+
+	PMD_LOG_DEBUG(RX, "Rx mode flags:0x%016x port_id:%u.",
+				rx_mode_flags, dev->data->port_id);
+	adapter->q_ctxt.rx_mode_flags = rx_mode_flags;
+}
+
+void sxe2_set_common_function(struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	dev->rx_queue_count = sxe2_rx_queue_count;
+	dev->rx_descriptor_status = sxe2_rx_desciptor_status;
+	dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
+
+	dev->tx_descriptor_status = sxe2_tx_desciptor_status;
+	dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+	dev->tx_pkt_burst = sxe2_tx_pkts;
+}
diff --git a/drivers/net/sxe2/sxe2_txrx.h b/drivers/net/sxe2/sxe2_txrx.h
new file mode 100644
index 0000000000..cd9ebfa32f
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#ifndef SXE2_TXRX_H
+#define SXE2_TXRX_H
+#include <ethdev_driver.h>
+#include "sxe2_queue.h"
+
+void sxe2_set_common_function(struct rte_eth_dev *dev);
+
+u16 sxe2_tx_pkts_prepare(__rte_unused void *tx_queue,
+		struct rte_mbuf **tx_pkts, u16 nb_pkts);
+
+void sxe2_tx_mode_func_set(struct rte_eth_dev *dev);
+
+void __rte_cold sxe2_rx_queue_reset(struct sxe2_rx_queue *rxq);
+
+void sxe2_rx_mode_func_set(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
new file mode 100644
index 0000000000..55bea8b74c
--- /dev/null
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -0,0 +1,782 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2025, Wuxi Stars Micro System Technologies Co., Ltd.
+ */
+
+#include <rte_common.h>
+#include <rte_net.h>
+#include <rte_vect.h>
+#include <rte_malloc.h>
+#include <rte_memzone.h>
+#include <ethdev_driver.h>
+#include <unistd.h>
+
+#include "sxe2_osal.h"
+#include "sxe2_txrx_common.h"
+#include "sxe2_txrx_poll.h"
+#include "sxe2_txrx.h"
+#include "sxe2_queue.h"
+#include "sxe2_ethdev.h"
+#include "sxe2_common_log.h"
+#include "sxe2_errno.h"
+
+static inline s32 sxe2_tx_cleanup(struct sxe2_tx_queue *txq)
+{
+	s32 ret = SXE2_SUCCESS;
+	volatile union sxe2_tx_data_desc *desc_ring = txq->desc_ring;
+	struct sxe2_tx_buffer *buffer_ring = txq->buffer_ring;
+	u16 ring_depth = txq->ring_depth;
+	u16 next_clean = txq->next_clean;
+	u16 clean_last;
+	u16 clean_num;
+
+	clean_last = next_clean + txq->rs_thresh;
+	if (clean_last >= ring_depth)
+		clean_last = clean_last - ring_depth;
+
+	clean_last = buffer_ring[clean_last].last_id;
+	if (rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE) !=
+		(txq->desc_ring[clean_last].wb.dd & rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_MASK))) {
+		PMD_LOG_TX_DEBUG("desc[%u] is not done.port_id=%u queue_id=%u val=0x%" PRIx64,
+						 clean_last, txq->port_id,
+			txq->queue_id, txq->desc_ring[clean_last].wb.dd);
+		SXE2_TX_STATS_CNT(txq, tx_desc_not_done, 1);
+		ret = SXE2_ERR_DESC_NO_DONE;
+		goto l_end;
+	}
+
+	if (clean_last > next_clean)
+		clean_num = clean_last - next_clean;
+	else
+		clean_num = ring_depth - next_clean + clean_last;
+
+	desc_ring[clean_last].wb.dd = 0;
+
+	txq->next_clean = clean_last;
+	txq->desc_free_num += clean_num;
+
+	ret = SXE2_SUCCESS;
+
+l_end:
+	return ret;
+}
+
+static __rte_always_inline u16
+sxe2_tx_pkt_data_desc_count(struct rte_mbuf *tx_pkt)
+{
+	struct rte_mbuf *m_seg = tx_pkt;
+	u16 count = 0;
+
+	while (m_seg != NULL) {
+		count += DIV_ROUND_UP(m_seg->data_len,
+				SXE2_TX_MAX_DATA_NUM_PER_DESC);
+		m_seg = m_seg->next;
+	}
+
+	return count;
+}
+
+static __rte_always_inline void
+sxe2_tx_desc_checksum_fill(u64 offloads, u32 *desc_cmd, u32 *desc_offset,
+		union sxe2_tx_offload_info ol_info)
+{
+	if (offloads & RTE_MBUF_F_TX_IP_CKSUM) {
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV4_CSUM;
+		*desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(ol_info.l3_len);
+	} else if (offloads & RTE_MBUF_F_TX_IPV4) {
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV4;
+		*desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(ol_info.l3_len);
+	} else if (offloads & RTE_MBUF_F_TX_IPV6) {
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_IIPT_IPV6;
+		*desc_offset |= SXE2_TX_DATA_DESC_IPLEN_VAL(ol_info.l3_len);
+	}
+
+	if (offloads & RTE_MBUF_F_TX_TCP_SEG) {
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_TCP;
+		*desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(ol_info.l4_len);
+		goto l_end;
+	}
+
+	if (offloads & RTE_MBUF_F_TX_UDP_SEG) {
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_UDP;
+		*desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(ol_info.l4_len);
+		goto l_end;
+	}
+
+	switch (offloads & RTE_MBUF_F_TX_L4_MASK) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_TCP;
+		*desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(ol_info.l4_len);
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_SCTP;
+		*desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(ol_info.l4_len);
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		*desc_cmd    |= SXE2_TX_DATA_DESC_CMD_L4T_EOFT_UDP;
+		*desc_offset |= SXE2_TX_DATA_DESC_L4LEN_VAL(ol_info.l4_len);
+		break;
+	default:
+
+		break;
+	}
+
+l_end:
+	return;
+}
+
+static __rte_always_inline u64
+sxe2_tx_data_desc_build_cobt(u32 cmd, u32 offset, u16 buf_size, u16 l2tag)
+{
+	return rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DATA |
+			(((u64)cmd)      << SXE2_TX_DATA_DESC_CMD_SHIFT) |
+			(((u64)offset)   << SXE2_TX_DATA_DESC_OFFSET_SHIFT) |
+			(((u64)buf_size) << SXE2_TX_DATA_DESC_BUF_SZ_SHIFT) |
+			(((u64)l2tag)    << SXE2_TX_DATA_DESC_L2TAG1_SHIFT));
+}
+
+u16 sxe2_tx_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 nb_pkts)
+{
+	struct sxe2_tx_queue *txq = tx_queue;
+	struct sxe2_tx_buffer *buffer_ring;
+	struct sxe2_tx_buffer *buffer;
+	struct sxe2_tx_buffer *next_buffer;
+	struct rte_mbuf *tx_pkt;
+	struct rte_mbuf *m_seg;
+	volatile union sxe2_tx_data_desc *desc_ring;
+	volatile union sxe2_tx_data_desc *desc;
+	volatile struct sxe2_tx_context_desc *ctxt_desc;
+	union sxe2_tx_offload_info ol_info;
+	struct sxe2_vsi *vsi = txq->vsi;
+	rte_iova_t buf_dma_addr;
+	u64 offloads;
+	u64 desc_type_cmd_tso_mss;
+	u32 desc_cmd;
+	u32 desc_offset;
+	u32 desc_tag;
+	u32 desc_tunneling_params;
+	u16 ipsec_offset;
+	u16 ctxt_desc_num;
+	u16 desc_sum_num;
+	u16 tx_num;
+	u16 seg_len;
+	u16 next_use;
+	u16 last_use;
+	u16 desc_l2tag2;
+
+	buffer_ring = txq->buffer_ring;
+	desc_ring   = txq->desc_ring;
+	next_use    = txq->next_use;
+	buffer      = &buffer_ring[next_use];
+
+	if (txq->desc_free_num < txq->free_thresh)
+		(void)sxe2_tx_cleanup(txq);
+
+	for (tx_num = 0; tx_num < nb_pkts; tx_num++) {
+		tx_pkt = *tx_pkts++;
+		desc_cmd              = 0;
+		desc_offset           = 0;
+		desc_tag              = 0;
+		desc_tunneling_params = 0;
+		ipsec_offset          = 0;
+		offloads              = tx_pkt->ol_flags;
+		ol_info.l2_len        = tx_pkt->l2_len;
+		ol_info.l3_len        = tx_pkt->l3_len;
+		ol_info.l4_len        = tx_pkt->l4_len;
+		ol_info.tso_segsz     = tx_pkt->tso_segsz;
+		ol_info.outer_l2_len  = tx_pkt->outer_l2_len;
+		ol_info.outer_l3_len  = tx_pkt->outer_l3_len;
+
+		ctxt_desc_num = (offloads &
+				SXE2_TX_OFFLOAD_CTXT_NEEDCK_MASK) ? 1 : 0;
+		if (unlikely(vsi->vsi_type == SXE2_VSI_T_DPDK_ESW))
+			ctxt_desc_num = 1;
+
+		if (offloads & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG))
+			desc_sum_num = sxe2_tx_pkt_data_desc_count(tx_pkt) + ctxt_desc_num;
+		else
+			desc_sum_num = tx_pkt->nb_segs + ctxt_desc_num;
+
+		last_use = next_use + desc_sum_num - 1;
+		if (last_use >= txq->ring_depth)
+			last_use = last_use - txq->ring_depth;
+
+		if (desc_sum_num > txq->desc_free_num) {
+			if (unlikely(sxe2_tx_cleanup(txq) != 0))
+				goto l_exit_logic;
+
+			if (unlikely(desc_sum_num > txq->rs_thresh)) {
+				while (desc_sum_num > txq->desc_free_num)
+					if (unlikely(sxe2_tx_cleanup(txq) != 0))
+						goto l_exit_logic;
+			}
+		}
+
+		desc_offset |= SXE2_TX_DATA_DESC_MACLEN_VAL(ol_info.l2_len);
+
+		if (offloads & SXE2_TX_OFFLOAD_CKSUM_MASK) {
+			sxe2_tx_desc_checksum_fill(offloads, &desc_cmd,
+					&desc_offset, ol_info);
+		}
+
+		if (offloads & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ)) {
+			desc_cmd |= SXE2_TX_DATA_DESC_CMD_IL2TAG1;
+			desc_tag = tx_pkt->vlan_tci;
+		}
+
+		if (ctxt_desc_num) {
+			ctxt_desc = (volatile struct sxe2_tx_context_desc *)
+							&desc_ring[next_use];
+			desc_l2tag2 = 0;
+			desc_type_cmd_tso_mss = SXE2_TX_DESC_DTYPE_CTXT;
+
+			next_buffer = &buffer_ring[buffer->next_id];
+			RTE_MBUF_PREFETCH_TO_FREE(next_buffer->mbuf);
+
+			if (buffer->mbuf) {
+				rte_pktmbuf_free_seg(buffer->mbuf);
+				buffer->mbuf = NULL;
+			}
+
+			if (offloads & RTE_MBUF_F_TX_QINQ) {
+				desc_l2tag2 = tx_pkt->vlan_tci_outer;
+				desc_type_cmd_tso_mss |= SXE2_TX_CTXT_DESC_CMD_IL2TAG2_MASK;
+			}
+
+			ctxt_desc->tunneling_params =
+				rte_cpu_to_le_32(desc_tunneling_params);
+			ctxt_desc->l2tag2 = rte_cpu_to_le_16(desc_l2tag2);
+			ctxt_desc->type_cmd_tso_mss = rte_cpu_to_le_64(desc_type_cmd_tso_mss);
+			ctxt_desc->ipsec_offset = rte_cpu_to_le_64(ipsec_offset);
+
+			buffer->last_id = last_use;
+			next_use        = buffer->next_id;
+			buffer          = next_buffer;
+		}
+
+		m_seg = tx_pkt;
+
+		do {
+			desc = &desc_ring[next_use];
+			next_buffer = &buffer_ring[buffer->next_id];
+			RTE_MBUF_PREFETCH_TO_FREE(next_buffer->mbuf);
+			if (buffer->mbuf) {
+				rte_pktmbuf_free_seg(buffer->mbuf);
+				buffer->mbuf = NULL;
+			}
+
+			buffer->mbuf = m_seg;
+			seg_len = m_seg->data_len;
+			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			while ((offloads & (RTE_MBUF_F_TX_TCP_SEG | RTE_MBUF_F_TX_UDP_SEG)) &&
+					unlikely(seg_len > SXE2_TX_MAX_DATA_NUM_PER_DESC)) {
+				desc->read.buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+				desc->read.type_cmd_off_bsz_l2t =
+					sxe2_tx_data_desc_build_cobt(desc_cmd, desc_offset,
+						SXE2_TX_MAX_DATA_NUM_PER_DESC,
+						desc_tag);
+				buf_dma_addr += SXE2_TX_MAX_DATA_NUM_PER_DESC;
+				seg_len      -= SXE2_TX_MAX_DATA_NUM_PER_DESC;
+				buffer->last_id = last_use;
+				next_use        = buffer->next_id;
+				buffer          = next_buffer;
+				desc            = &desc_ring[next_use];
+				next_buffer     = &buffer_ring[buffer->next_id];
+				RTE_MBUF_PREFETCH_TO_FREE(next_buffer->mbuf);
+			}
+
+			desc->read.buf_addr = rte_cpu_to_le_64(buf_dma_addr);
+			desc->read.type_cmd_off_bsz_l2t =
+				sxe2_tx_data_desc_build_cobt(desc_cmd,
+					desc_offset, seg_len, desc_tag);
+
+			buffer->last_id = last_use;
+			next_use        = buffer->next_id;
+			buffer          = next_buffer;
+
+			m_seg = m_seg->next;
+		} while (m_seg);
+
+		desc_cmd |= SXE2_TX_DATA_DESC_CMD_EOP;
+		txq->desc_used_num += desc_sum_num;
+		txq->desc_free_num -= desc_sum_num;
+
+		if (txq->desc_used_num >= txq->rs_thresh) {
+			PMD_LOG_TX_DEBUG("Tx pkts set RS bit."
+					"last_use=%u port_id=%u, queue_id=%u",
+					last_use, txq->port_id, txq->queue_id);
+			desc_cmd |= SXE2_TX_DATA_DESC_CMD_RS;
+
+			txq->desc_used_num = 0;
+		}
+
+		desc->read.type_cmd_off_bsz_l2t |=
+			rte_cpu_to_le_64(((u64)desc_cmd) << SXE2_TX_DATA_DESC_CMD_SHIFT);
+	}
+
+l_exit_logic:
+	if (tx_num == 0)
+		goto l_end;
+	goto l_end_of_tx;
+
+l_end_of_tx:
+	SXE2_PCI_REG_WRITE_WC(txq->tdt_reg_addr, next_use);
+	PMD_LOG_TX_DEBUG("port_id=%u queue_id=%u next_use=%u send_pkts=%u",
+			txq->port_id, txq->queue_id, next_use, tx_num);
+	SXE2_TX_STATS_CNT(txq, tx_pkts_num, tx_num);
+
+	txq->next_use = next_use;
+
+l_end:
+	return tx_num;
+}
+
+static inline void
+sxe2_update_rx_tail(struct sxe2_rx_queue *rxq, u16 hold_num, u16 rx_id)
+{
+	hold_num += rxq->hold_num;
+
+	if (hold_num > rxq->rx_free_thresh) {
+		rx_id = (u16)((rx_id == 0) ? (rxq->ring_depth - 1) : (rx_id - 1));
+		SXE2_PCI_REG_WRITE_WC(rxq->rdt_reg_addr, rx_id);
+		hold_num = 0;
+	}
+	rxq->hold_num = hold_num;
+}
+
+static inline u64
+sxe2_rx_desc_error_para(__rte_unused struct sxe2_rx_queue *rxq,
+		union sxe2_rx_desc *desc)
+{
+	u64 flags = 0;
+	u64 desc_qw1 = rte_le_to_cpu_64(desc->wb.status_err_ptype_len);
+
+	if (unlikely(0 == (desc_qw1 & SXE2_RX_DESC_STATUS_L3L4_P_MASK)))
+		goto l_end;
+
+	if (likely(0 == (desc->wb.rxdid_src & SXE2_RX_DESC_EUDPE_MASK))) {
+		flags = RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD;
+	} else {
+		flags = RTE_MBUF_F_RX_OUTER_L4_CKSUM_BAD;
+		SXE2_RX_STATS_CNT(rxq, outer_l4_csum_err, 1);
+	}
+
+	if (likely(0 == (desc_qw1 & SXE2_RX_DESC_QW1_ERRORS_MASK))) {
+		flags |= (RTE_MBUF_F_RX_IP_CKSUM_GOOD |
+				RTE_MBUF_F_RX_L4_CKSUM_GOOD |
+				RTE_MBUF_F_RX_OUTER_L4_CKSUM_GOOD);
+		goto l_end;
+	}
+
+	if (likely(0 == (desc_qw1 & SXE2_RX_DESC_ERROR_CSUM_IPE_MASK))) {
+		flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
+	} else {
+		flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
+		SXE2_RX_STATS_CNT(rxq, ip_csum_err, 1);
+	}
+
+	if (likely(0 == (desc_qw1 & SXE2_RX_DESC_ERROR_CSUM_L4_MASK))) {
+		flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
+	} else {
+		flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+		SXE2_RX_STATS_CNT(rxq, l4_csum_err, 1);
+	}
+
+	if (unlikely(0 != (desc_qw1 & SXE2_RX_DESC_ERROR_CSUM_EIP_MASK))) {
+		flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
+		SXE2_RX_STATS_CNT(rxq, outer_ip_csum_err, 1);
+	}
+
+l_end:
+	return flags;
+}
+
+static __rte_always_inline void
+sxe2_rx_mbuf_common_fields_fill(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf,
+		union sxe2_rx_desc *rxd)
+{
+	u32 *ptype_tbl = rxq->vsi->adapter->ptype_tbl;
+	u64 qword1;
+	u64 pkt_flags;
+	qword1 = rte_le_to_cpu_64(rxd->wb.status_err_ptype_len);
+
+	mbuf->ol_flags = 0;
+	mbuf->packet_type = ptype_tbl[SXE2_RX_DESC_PTYPE_VAL_GET(qword1)];
+
+	pkt_flags = sxe2_rx_desc_error_para(rxq, rxd);
+
+	SXE2_RX_STATS_CNT(rxq, ptype_pkts[SXE2_RX_DESC_PTYPE_VAL_GET(qword1)], 1);
+	SXE2_RX_STATS_CNT(rxq, rx_pkts_num, 1);
+	mbuf->ol_flags |= pkt_flags;
+}
+
+static __rte_always_inline void
+sxe2_rx_sw_stats_update(struct sxe2_rx_queue *rxq, struct rte_mbuf *mbuf,
+		union sxe2_rx_desc *rxd)
+{
+	u64 qword1 = rte_le_to_cpu_64(rxd->wb.status_err_ptype_len);
+	rte_atomic_fetch_add_explicit(&rxq->sw_stats.pkts, 1,
+		rte_memory_order_relaxed);
+	rte_atomic_fetch_add_explicit(&rxq->sw_stats.bytes,
+			mbuf->pkt_len + RTE_ETHER_CRC_LEN,
+			rte_memory_order_relaxed);
+	switch (SXE2_RX_DESC_STATUS_UMBCAST_VAL_GET(qword1)) {
+	case SXE2_RX_DESC_STATUS_UNICAST:
+		rte_atomic_fetch_add_explicit(&rxq->sw_stats.unicast_pkts, 1,
+			rte_memory_order_relaxed);
+		break;
+	case SXE2_RX_DESC_STATUS_MUTICAST:
+		rte_atomic_fetch_add_explicit(&rxq->sw_stats.multicast_pkts, 1,
+			rte_memory_order_relaxed);
+		break;
+	case SXE2_RX_DESC_STATUS_BOARDCAST:
+		rte_atomic_fetch_add_explicit(&rxq->sw_stats.broadcast_pkts, 1,
+			rte_memory_order_relaxed);
+		break;
+	default:
+		break;
+	}
+}
+
+u16 sxe2_rx_pkts_scattered(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
+	volatile union sxe2_rx_desc *desc_ring;
+	volatile union sxe2_rx_desc *desc;
+	union sxe2_rx_desc desc_tmp;
+	struct rte_mbuf **buffer_ring;
+	struct rte_mbuf **cur_buffer;
+	struct rte_mbuf *cur_mbuf;
+	struct rte_mbuf *new_mbuf;
+	struct rte_mbuf *first_seg;
+	struct rte_mbuf *last_seg;
+	u64 qword1;
+	u16 done_num;
+	u16 hold_num;
+	u16 cur_idx;
+	u16 pkt_len;
+
+	desc_ring   = rxq->desc_ring;
+	buffer_ring = rxq->buffer_ring;
+	cur_idx     = rxq->processing_idx;
+	first_seg   = rxq->pkt_first_seg;
+	last_seg    = rxq->pkt_last_seg;
+	done_num    = 0;
+	hold_num    = 0;
+	while (done_num < nb_pkts) {
+		desc = &desc_ring[cur_idx];
+		qword1 = rte_le_to_cpu_64(desc->wb.status_err_ptype_len);
+		if (0 == (SXE2_RX_DESC_STATUS_DD_MASK & qword1))
+			break;
+
+		new_mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (unlikely(new_mbuf == NULL)) {
+			rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed++;
+			PMD_LOG_INFO(RX, "Rx new_mbuf alloc failed port_id:%u "
+					"queue_id:%u", rxq->port_id, rxq->queue_id);
+			break;
+		}
+
+		hold_num++;
+		desc_tmp = *desc;
+		cur_buffer = &buffer_ring[cur_idx];
+		cur_idx++;
+		if (unlikely(cur_idx == rxq->ring_depth))
+			cur_idx = 0;
+
+		rte_prefetch0(buffer_ring[cur_idx]);
+
+		if (0 == (cur_idx & 0x3)) {
+			rte_prefetch0(&desc_ring[cur_idx]);
+			rte_prefetch0(&buffer_ring[cur_idx]);
+		}
+
+		cur_mbuf = *cur_buffer;
+
+		*cur_buffer = new_mbuf;
+
+		desc->read.hdr_addr = 0;
+		desc->read.pkt_addr =
+			rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf));
+
+		pkt_len = SXE2_RX_DESC_PKT_LEN_VAL_GET(qword1);
+		cur_mbuf->data_len = pkt_len;
+		cur_mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+
+		if (first_seg == NULL) {
+			first_seg = cur_mbuf;
+			first_seg->nb_segs = 1;
+			first_seg->pkt_len = pkt_len;
+		} else {
+			first_seg->pkt_len += pkt_len;
+			first_seg->nb_segs++;
+			last_seg->next = cur_mbuf;
+		}
+
+		if (0 == (qword1 & SXE2_RX_DESC_STATUS_EOP_MASK)) {
+			last_seg = cur_mbuf;
+			continue;
+		}
+
+		if (unlikely(qword1 & SXE2_RX_DESC_ERROR_RXE_MASK) ||
+			unlikely(qword1 & SXE2_RX_DESC_ERROR_OVERSIZE_MASK)) {
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
+				rte_memory_order_relaxed);
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
+				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
+				rte_memory_order_relaxed);
+			rte_pktmbuf_free(first_seg);
+			first_seg = NULL;
+			continue;
+		}
+
+		cur_mbuf->next = NULL;
+		if (unlikely(rxq->crc_len > 0)) {
+			first_seg->pkt_len -= RTE_ETHER_CRC_LEN;
+
+			if (pkt_len <= RTE_ETHER_CRC_LEN) {
+				rte_pktmbuf_free_seg(cur_mbuf);
+				first_seg->nb_segs--;
+				last_seg->data_len = last_seg->data_len + pkt_len -
+					RTE_ETHER_CRC_LEN;
+				last_seg->next = NULL;
+			} else {
+				cur_mbuf->data_len = pkt_len - RTE_ETHER_CRC_LEN;
+			}
+
+		} else if (pkt_len == 0) {
+			rte_pktmbuf_free_seg(cur_mbuf);
+			first_seg->nb_segs--;
+			last_seg->next = NULL;
+		}
+
+		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr, first_seg->data_off));
+		first_seg->port     = rxq->port_id;
+
+		sxe2_rx_mbuf_common_fields_fill(rxq, first_seg, &desc_tmp);
+
+		if (rxq->vsi->adapter->devargs.sw_stats_en)
+			sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
+
+		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr, first_seg->data_off));
+
+		rx_pkts[done_num] = first_seg;
+		done_num++;
+
+		first_seg = NULL;
+	}
+
+	rxq->processing_idx = cur_idx;
+	rxq->pkt_first_seg  = first_seg;
+	rxq->pkt_last_seg   = last_seg;
+
+	sxe2_update_rx_tail(rxq, hold_num, cur_idx);
+
+	return done_num;
+}
+
+u16 sxe2_rx_pkts_scattered_split(void *rx_queue, struct rte_mbuf **rx_pkts, u16 nb_pkts)
+{
+	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
+	volatile union sxe2_rx_desc *desc_ring;
+	volatile union sxe2_rx_desc *desc;
+	union sxe2_rx_desc desc_tmp;
+	struct rte_mbuf **buffer_ring;
+	struct rte_mbuf **cur_buffer;
+	struct rte_mbuf *cur_mbuf;
+	struct rte_mbuf *cur_mbuf_pay;
+	struct rte_mbuf *new_mbuf;
+	struct rte_mbuf *new_mbuf_pay;
+	struct rte_mbuf *first_seg;
+	struct rte_mbuf *last_seg;
+	u64 qword1;
+	u16 done_num;
+	u16 hold_num;
+	u16 cur_idx;
+	u16 pkt_len;
+	u16 hdr_len;
+
+	desc_ring = rxq->desc_ring;
+	buffer_ring = rxq->buffer_ring;
+	cur_idx = rxq->processing_idx;
+	first_seg = rxq->pkt_first_seg;
+	last_seg = rxq->pkt_last_seg;
+	done_num = 0;
+	hold_num = 0;
+	new_mbuf = NULL;
+
+	while (done_num < nb_pkts) {
+		desc = &desc_ring[cur_idx];
+		qword1 = rte_le_to_cpu_64(desc->wb.status_err_ptype_len);
+
+		if (0 == (SXE2_RX_DESC_STATUS_DD_MASK & qword1))
+			break;
+
+		if ((rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) == 0 ||
+			first_seg == NULL) {
+			new_mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+			if (unlikely(new_mbuf == NULL)) {
+				rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed++;
+				PMD_LOG_RX_INFO("Rx new_mbuf alloc failed port_id=%u "
+						"queue_id=%u", rxq->port_id,
+						rxq->idx_in_pf);
+				break;
+			}
+		}
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT) {
+			new_mbuf_pay = rte_mbuf_raw_alloc(rxq->rx_seg[1].mp);
+			if (unlikely(new_mbuf_pay == NULL)) {
+				rxq->vsi->adapter->dev_info.dev_data->rx_mbuf_alloc_failed++;
+				PMD_LOG_RX_INFO("Rx new_mbuf_pay alloc failed port_id=%u "
+						"queue_id=%u", rxq->port_id,
+						rxq->idx_in_pf);
+				if (new_mbuf != NULL)
+					rte_pktmbuf_free(new_mbuf);
+				new_mbuf = NULL;
+				break;
+			}
+		}
+
+		hold_num++;
+		desc_tmp = *desc;
+		cur_buffer = &buffer_ring[cur_idx];
+		cur_idx++;
+		if (unlikely(cur_idx == rxq->ring_depth))
+			cur_idx = 0;
+		rte_prefetch0(buffer_ring[cur_idx]);
+		if (0 == (cur_idx & 0x3)) {
+			rte_prefetch0(&desc_ring[cur_idx]);
+			rte_prefetch0(&buffer_ring[cur_idx]);
+		}
+		cur_mbuf = *cur_buffer;
+		if (0 == (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+			*cur_buffer = new_mbuf;
+			desc->read.hdr_addr = 0;
+			desc->read.pkt_addr =
+				rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf));
+		} else {
+			if (first_seg == NULL) {
+				*cur_buffer = new_mbuf;
+				new_mbuf->next = new_mbuf_pay;
+				new_mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+				new_mbuf_pay->next = NULL;
+				new_mbuf_pay->data_off = RTE_PKTMBUF_HEADROOM;
+				desc->read.hdr_addr =
+					rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf));
+				desc->read.pkt_addr =
+					rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf_pay));
+			} else {
+				cur_mbuf_pay = cur_mbuf->next;
+				cur_mbuf->next = new_mbuf_pay;
+				new_mbuf_pay->next = NULL;
+				new_mbuf_pay->data_off = RTE_PKTMBUF_HEADROOM;
+				desc->read.hdr_addr =
+					rte_cpu_to_le_64(rte_mbuf_data_iova_default(cur_mbuf));
+				desc->read.pkt_addr =
+					rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf_pay));
+				cur_mbuf = cur_mbuf_pay;
+			}
+		}
+
+		if (0 == (rxq->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+			pkt_len = SXE2_RX_DESC_PKT_LEN_VAL_GET(qword1);
+			cur_mbuf->data_len = pkt_len;
+			cur_mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+			if (first_seg == NULL) {
+				first_seg = cur_mbuf;
+				first_seg->nb_segs = 1;
+				first_seg->pkt_len = pkt_len;
+			} else {
+				first_seg->pkt_len += pkt_len;
+				first_seg->nb_segs++;
+				last_seg->next = cur_mbuf;
+			}
+		} else {
+			if (first_seg == NULL) {
+				cur_mbuf->nb_segs = 2;
+				cur_mbuf->next->next = NULL;
+				pkt_len = SXE2_RX_DESC_PKT_LEN_VAL_GET(qword1);
+				hdr_len = SXE2_RX_DESC_HDR_LEN_VAL_GET(qword1);
+				cur_mbuf->data_len = hdr_len;
+				cur_mbuf->pkt_len = hdr_len + pkt_len;
+				cur_mbuf->next->data_len = pkt_len;
+				first_seg = cur_mbuf;
+				cur_mbuf = cur_mbuf->next;
+				last_seg = cur_mbuf;
+			} else {
+				cur_mbuf->nb_segs = 1;
+				cur_mbuf->next = NULL;
+				pkt_len = SXE2_RX_DESC_PKT_LEN_VAL_GET(qword1);
+				cur_mbuf->data_len = pkt_len;
+
+				first_seg->pkt_len += pkt_len;
+				first_seg->nb_segs++;
+				last_seg->next = cur_mbuf;
+			}
+		}
+
+#ifdef RTE_ETHDEV_DEBUG_RX
+
+		rte_pktmbuf_dump(stdout, first_seg, rte_pktmbuf_pkt_len(first_seg));
+#endif
+
+		if (0 == (rte_le_to_cpu_64(desc_tmp.wb.status_err_ptype_len) &
+					SXE2_RX_DESC_STATUS_EOP_MASK)) {
+			last_seg = cur_mbuf;
+			continue;
+		}
+
+		if (unlikely(qword1 & SXE2_RX_DESC_ERROR_RXE_MASK) ||
+			unlikely(qword1 & SXE2_RX_DESC_ERROR_OVERSIZE_MASK)) {
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_pkts, 1,
+				rte_memory_order_relaxed);
+			rte_atomic_fetch_add_explicit(&rxq->sw_stats.drop_bytes,
+				first_seg->pkt_len - rxq->crc_len + RTE_ETHER_CRC_LEN,
+				rte_memory_order_relaxed);
+			rte_pktmbuf_free(first_seg);
+			first_seg = NULL;
+			continue;
+		}
+
+		cur_mbuf->next = NULL;
+		if (unlikely(rxq->crc_len > 0)) {
+			first_seg->pkt_len -= RTE_ETHER_CRC_LEN;
+			if (pkt_len <= RTE_ETHER_CRC_LEN) {
+				rte_pktmbuf_free_seg(cur_mbuf);
+				cur_mbuf = NULL;
+				first_seg->nb_segs--;
+				last_seg->data_len = last_seg->data_len +
+					pkt_len - RTE_ETHER_CRC_LEN;
+				last_seg->next = NULL;
+			} else {
+				cur_mbuf->data_len = pkt_len - RTE_ETHER_CRC_LEN;
+			}
+		} else if (pkt_len == 0) {
+			rte_pktmbuf_free_seg(cur_mbuf);
+			cur_mbuf = NULL;
+			first_seg->nb_segs--;
+			last_seg->next = NULL;
+		}
+
+		first_seg->port = rxq->port_id;
+		sxe2_rx_mbuf_common_fields_fill(rxq, first_seg, &desc_tmp);
+
+		if (rxq->vsi->adapter->devargs.sw_stats_en)
+			sxe2_rx_sw_stats_update(rxq, first_seg, &desc_tmp);
+
+		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr, first_seg->data_off));
+
+		rx_pkts[done_num] = first_seg;
+		done_num++;
+
+		first_seg = NULL;
+	}
+
+	rxq->processing_idx = cur_idx;
+	rxq->pkt_first_seg = first_seg;
+	rxq->pkt_last_seg = last_seg;
+
+	sxe2_update_rx_tail(rxq, hold_num, cur_idx);
+
+	return done_num;
+}
-- 
2.47.3

