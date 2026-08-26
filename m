Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A657C61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:58:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47DB740E13;
	Wed, 26 Aug 2026 10:58:08 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1A1E540B9D
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:58:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAAXGzmZqo5qXehMBg--.37482S2;
 Wed, 26 Aug 2026 16:58:02 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 45/51] common/sxe2: fix ioctl channel log and close handling
Date: Wed, 26 Aug 2026 16:58:01 +0800
Message-ID: <20260826085801.992895-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXGzmZqo5qXehMBg--.37482S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Xry8JFyDJrW7Wr18AFb_yoW8uw45pF
 4Sgry3tFWrtayagFn8GanrZFy5Kasak3yDurWxK3yaka4kXFy7uFyDWry5J3W8Cr1rJF95
 ZFnxJr45Wwn3CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
 xK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
 64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r
 4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
 cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUn0D77UUUUU==
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

Compare sxe2_ioctl_chnl.c against the reference implementation and
fix the following discrepancies:

- sxe2_drv_dev_close: only log the closed fd when it is valid, move
  PMD_LOG_INFO inside the fd >= 0 check
- sxe2_drv_dev_mmap: fix swapped format arguments in the debug log
  (cmd_fd and bar_idx were passed in the wrong order)
- sxe2_drv_dev_dma_unmap: use PMD_LOG_ERR instead of PMD_LOG_INFO
  for the ioctl failure message

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_ioctl_chnl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 3e2fbf572f..e62ca42a8f 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -107,9 +107,11 @@ sxe2_drv_dev_close(struct sxe2_common_device *cdev)
 {
 	int32_t fd = SXE2_CDEV_TO_CMD_FD(cdev);
 
-	if (fd >= 0)
+	if (fd >= 0) {
 		close(fd);
-	PMD_LOG_INFO(COM, "closed device fd=%d", fd);
+		PMD_LOG_INFO(COM, "closed device fd=%d", fd);
+	}
+
 	SXE2_CDEV_TO_CMD_FD(cdev) = SXE2_CMD_FD_INVALID;
 }
 
@@ -350,7 +352,7 @@ void
 	}
 
 	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=%"PRIu64", src=0x%"PRIx64", offset=0x%"PRIx64"",
-		bar_idx, cmd_fd, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
+		cmd_fd, bar_idx, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
 
 	virt = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		MAP_SHARED, cmd_fd, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
@@ -477,7 +479,7 @@ sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova)
 	pthread_mutex_lock(&cdev->config.lock);
 	ret = ioctl(cmd_fd, SXE2_COM_CMD_DMA_UNMAP, &cmd_params);
 	if (ret < 0) {
-		PMD_LOG_INFO(COM, "Failed to dma unmap, fd=%d, ret=%d, err:%s",
+		PMD_LOG_ERR(COM, "Failed to dma unmap, fd=%d, ret=%d, err:%s",
 				cmd_fd, ret, strerror(errno));
 		ret = -EIO;
 		pthread_mutex_unlock(&cdev->config.lock);
-- 
2.52.0

