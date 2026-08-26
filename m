Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DCDC61DC2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61EDA402EA;
	Wed, 26 Aug 2026 10:53:57 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4CDEB400EF
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:53:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHUD6eqY5qKtpMBg--.50557S2;
 Wed, 26 Aug 2026 16:53:50 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 02/51] common/sxe2: allow munmap during kernel reset
Date: Wed, 26 Aug 2026 16:53:50 +0800
Message-ID: <20260826085350.990102-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUD6eqY5qKtpMBg--.50557S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ZFW3tF4xJr1Dtw1UZFb_yoW8Xw15pF
 4xXFyYgFWrt3WUWw4DX3WI9FyF93Z0q3yUuFyUK3ZavFyDZryku34FgF15tw1UGr95JF1r
 ZrsFva1ag3WrurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcj2MUUUUU
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

sxe2_drv_dev_munmap() refuses to unmap the BAR region when
cdev->config.kernel_reset is set, returning -EPERM. After a kernel
reset the application still needs to release the previously mapped
regions during cleanup; blocking munmap leaves stale mappings and
prevents a clean teardown.

Remove the kernel_reset check from sxe2_drv_dev_munmap() so the
mapping is always released. The cdev parameter is no longer used,
so mark it __rte_unused.

Fixes: 66a10eb60e ("net/sxe2: add PCI BAR mapping")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_ioctl_chnl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_ioctl_chnl.c b/drivers/common/sxe2/sxe2_ioctl_chnl.c
index a233a78136..3e2fbf572f 100644
--- a/drivers/common/sxe2/sxe2_ioctl_chnl.c
+++ b/drivers/common/sxe2/sxe2_ioctl_chnl.c
@@ -367,16 +367,10 @@ void
 
 RTE_EXPORT_INTERNAL_SYMBOL(sxe2_drv_dev_munmap)
 int32_t
-sxe2_drv_dev_munmap(struct sxe2_common_device *cdev, void *virt, uint64_t len)
+sxe2_drv_dev_munmap(struct sxe2_common_device *cdev __rte_unused, void *virt, uint64_t len)
 {
 	int32_t ret = 0;
 
-	if (cdev->config.kernel_reset) {
-		ret = -EPERM;
-		PMD_LOG_WARN(COM, "kernel reset, need restart app.");
-		goto l_end;
-	}
-
 	PMD_LOG_DEBUG(COM, "Munmap virt=%p, len=0x%"PRIx64"",
 		virt, len);
 
-- 
2.52.0

