Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF9DC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:45:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E90B440E31;
	Mon, 31 Aug 2026 04:45:29 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 0528140C35;
 Mon, 31 Aug 2026 04:45:26 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnrjzB6pRqotujBg--.50506S2;
 Mon, 31 Aug 2026 10:45:24 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 44/47] common/sxe2: fix ioctl channel log and close handling
Date: Mon, 31 Aug 2026 10:45:21 +0800
Message-ID: <20260831024521.3231684-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnrjzB6pRqotujBg--.50506S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15Xry8JFyDJrW7Wr18AFb_yoW8KFy8pF
 sagry5tFyrtayagFn8AanrZFy5t3Zak3yUurWIk3y3t34DXryUZFyDGry5G3W8Cr15JF93
 ZFnxJr13Ww1kArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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
correct the following discrepancies:

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
 drivers/common/sxe2/sxe2_ioctl_chnl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index 3e2fbf572f..9f455bd8d5 100644
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
 
@@ -349,8 +351,9 @@ void
 		goto l_err;
 	}
 
-	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=%"PRIu64", src=0x%"PRIx64", offset=0x%"PRIx64"",
-		bar_idx, cmd_fd, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
+	PMD_LOG_DEBUG(COM, "fd=%d, bar idx=%d, len=%"PRIu64", "
+		"offset=0x%"PRIx64", pci_offset=0x%"PRIx64"",
+		cmd_fd, bar_idx, len, offset, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
 
 	virt = mmap(NULL, len, PROT_READ | PROT_WRITE,
 		MAP_SHARED, cmd_fd, SXE2_COM_PCI_OFFSET_GEN(bar_idx, offset));
@@ -477,7 +480,7 @@ sxe2_drv_dev_dma_unmap(struct sxe2_common_device *cdev, uint64_t iova)
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

