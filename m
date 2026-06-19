Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7DCD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 08:12:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1899440280;
	Fri, 19 Jun 2026 10:12:16 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id C1F6D40279
 for <dev@dpdk.org>; Fri, 19 Jun 2026 10:12:13 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABn8QTb+TRqwsI2FA--.28732S2;
 Fri, 19 Jun 2026 16:12:11 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v4 21/23] common/sxe2: add callback for memory event handling
Date: Fri, 19 Jun 2026 16:12:10 +0800
Message-ID: <20260619081210.1546520-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
References: <20260618082723.571054-21-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABn8QTb+TRqwsI2FA--.28732S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFWxZF45Cr1fGw45JF4ruFg_yoW7ZFWrpF
 48uFyYqFy5Ja17Ww13t3WDZ34rKwsYg3yDCFWxKasak3Wqqry8Zw4kKa43tr1rCrW3JF1v
 yFsIyFy5Gw48JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
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

During memory hotplug events, the SXE2 driver needs to track memory
segment layout changes to maintain internal DMA mappings. However,
existing memseg walk functions (rte_memseg_walk) acquire memory locks
and cannot be called from within memory event callbacks, leading to
potential deadlocks.

The implementation follows the standard rte_memseg_walk_t prototype,
processing each memseg to update driver-specific data structures.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c     | 110 ++++++++++++++++++++++++++
 drivers/common/sxe2/sxe2_common.h     |   2 +
 drivers/common/sxe2/sxe2_ioctl_chnl.c |   2 +-
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index c000a55cd0..5c5db85f29 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -196,6 +196,102 @@ static int32_t sxe2_parse_representor(const char *key, const char *value, void *
 
 	PMD_LOG_INFO(COM, "representor arg %s: \"%s\".", key, value);
 
+l_end:
+	return ret;
+}
+static int32_t sxe2_dma_mem_map(struct sxe2_common_device *cdev,
+				const void *addr, size_t len, bool do_map)
+{
+	struct rte_memseg_list *msl;
+	struct rte_memseg *ms;
+	size_t cur_len = 0;
+	int32_t ret = 0;
+
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl == NULL) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(COM, "Invalid virt addr=%p.", addr);
+		goto l_end;
+	}
+
+	if ((uintptr_t)addr != RTE_ALIGN((uintptr_t)addr, msl->page_sz) ||
+		(len != RTE_ALIGN(len, msl->page_sz))) {
+		ret = -EINVAL;
+		PMD_LOG_ERR(COM, "Addr=%p and len=%zu not align page size=%" PRIu64 ".",
+			    addr, len, msl->page_sz);
+		goto l_end;
+	}
+
+	/* memsegs are contiguous in memory */
+	ms = rte_mem_virt2memseg(addr, msl);
+	while (cur_len < len) {
+		/* some memory segments may have invalid IOVA */
+		if (ms->iova == RTE_BAD_IOVA) {
+			PMD_LOG_WARN(COM, "Memory segment at %p has bad IOVA, skipping.",
+					ms->addr);
+			goto next;
+		}
+		if (do_map)
+			sxe2_drv_dev_dma_map(cdev, ms->addr_64,
+					ms->iova, ms->len);
+		else
+			sxe2_drv_dev_dma_unmap(cdev, ms->iova);
+
+next:
+		cur_len += ms->len;
+		++ms;
+	}
+
+l_end:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(sxe2_common_mem_event_cb)
+void
+sxe2_common_mem_event_cb(enum rte_mem_event type,
+		const void *addr, size_t size, void *arg __rte_unused)
+{
+	struct sxe2_common_device *cdev = NULL;
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		goto l_end;
+
+	pthread_mutex_lock(&sxe2_common_devices_list_lock);
+	switch (type) {
+	case RTE_MEM_EVENT_FREE:
+		TAILQ_FOREACH(cdev, &sxe2_common_devices_list, next)
+			(void)sxe2_dma_mem_map(cdev, addr, size, 0);
+		break;
+	case RTE_MEM_EVENT_ALLOC:
+		TAILQ_FOREACH(cdev, &sxe2_common_devices_list, next)
+			(void)sxe2_dma_mem_map(cdev, addr, size, 1);
+		break;
+	default:
+		break;
+	}
+	pthread_mutex_unlock(&sxe2_common_devices_list_lock);
+l_end:
+	return;
+}
+
+static int32_t sxe2_memseg_walk_cb(const struct rte_memseg_list *msl,
+				   const struct rte_memseg *ms, void *arg)
+{
+	struct sxe2_common_device *cdev = arg;
+	int32_t ret = 0;
+
+	if (msl->external && !msl->heap)
+		goto l_end;
+
+	if (ms->iova == RTE_BAD_IOVA)
+		goto l_end;
+
+	ret = sxe2_drv_dev_dma_map(cdev, ms->addr_64, ms->iova, ms->len);
+	if (ret != 0) {
+		PMD_LOG_ERR(COM, "Fail to memseg dma map.");
+		goto l_end;
+	}
+
 l_end:
 	return ret;
 }
@@ -220,6 +316,18 @@ static int32_t sxe2_common_device_setup(struct sxe2_common_device *cdev)
 		goto l_close_dev;
 	}
 
+	rte_mcfg_mem_read_lock();
+	ret = rte_memseg_walk_thread_unsafe(sxe2_memseg_walk_cb, cdev);
+	if (ret) {
+		PMD_LOG_ERR(COM, "Fail to walk memseg, ret=%d", ret);
+		rte_mcfg_mem_read_unlock();
+		goto l_close_dev;
+	}
+	rte_mcfg_mem_read_unlock();
+
+	(void)rte_mem_event_callback_register("SXE2_MEM_EVENT_CB",
+			sxe2_common_mem_event_cb, NULL);
+
 	goto l_end;
 
 l_close_dev:
@@ -251,6 +359,7 @@ static struct sxe2_common_device *sxe2_common_device_alloc(
 	}
 	cdev->dev = rte_dev;
 	cdev->class_type = class_type;
+	cdev->config.cmd_fd = SXE2_CMD_FD_INVALID;
 	cdev->config.kernel_reset = false;
 	pthread_mutex_init(&cdev->config.lock, NULL);
 
@@ -631,6 +740,7 @@ static int32_t sxe2_common_pci_id_table_update(const struct rte_pci_id *id_table
 
 	updated_table = calloc(num_ids, sizeof(*updated_table));
 	if (!updated_table) {
+		ret = -ENOMEM;
 		PMD_LOG_ERR(COM, "Failed to allocate memory for PCI ID table");
 		goto l_end;
 	}
diff --git a/drivers/common/sxe2/sxe2_common.h b/drivers/common/sxe2/sxe2_common.h
index b02b6317da..efc8d3585a 100644
--- a/drivers/common/sxe2/sxe2_common.h
+++ b/drivers/common/sxe2/sxe2_common.h
@@ -14,6 +14,8 @@
 
 #define SXE2_COMMON_PCI_DRIVER_NAME "sxe2_pci"
 
+#define SXE2_CMD_FD_INVALID (-1)
+
 #define SXE2_CDEV_TO_CMD_FD(cdev) \
 	((cdev)->config.cmd_fd)
 
diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 173d8d57ae..a233a78136 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -110,7 +110,7 @@ sxe2_drv_dev_close(struct sxe2_common_device *cdev)
 	if (fd >= 0)
 		close(fd);
 	PMD_LOG_INFO(COM, "closed device fd=%d", fd);
-	SXE2_CDEV_TO_CMD_FD(cdev) = -1;
+	SXE2_CDEV_TO_CMD_FD(cdev) = SXE2_CMD_FD_INVALID;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_handshake)
-- 
2.52.0

