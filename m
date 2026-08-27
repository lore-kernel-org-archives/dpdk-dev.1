Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F785C61DBE
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AFD640E40;
	Thu, 27 Aug 2026 04:40:41 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4A4C240E25
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:40:33 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAAX7O+do49qxJajBg--.27022S2;
 Thu, 27 Aug 2026 10:40:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 43/44] common/sxe2: fix ioctl channel log and close handling
Date: Thu, 27 Aug 2026 10:40:29 +0800
Message-ID: <20260827024029.1432198-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAX7O+do49qxJajBg--.27022S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Xry8JFyDJrW7Wr18AFb_yoW8tF1fpF
 4Sgry5tFWrtayagFn8GanFvFy5Kasak3yUurW8K39Iya4kXFy7ZFyDWry5J3W8Cr15JF97
 ZFnxJr45Ww1kArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3sjjUUUUU
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

Fixes: 83866f8d7638 ("common/sxe2: add base driver skeleton")
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

