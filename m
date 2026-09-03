Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72872C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:54:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B66AA410E6;
	Thu,  3 Sep 2026 03:54:09 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id AD1CB410CF;
 Thu,  3 Sep 2026 03:54:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACX_zk805hqEQ9ABw--.23775S2;
 Thu, 03 Sep 2026 09:54:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 02/48] common/sxe2: allow munmap during kernel reset
Date: Thu,  3 Sep 2026 09:54:04 +0800
Message-ID: <20260903015404.161785-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACX_zk805hqEQ9ABw--.23775S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15ZFW3tF4xJr1Dtw1UZFb_yoW8Xw17pF
 1xXFyYqFWrtF1UWw4DX3WI9FyF93Z8tw4UCFyUKwnavFyDZryku34FgF15tw1UGr95JF1r
 ZrnFvF4ag3WrurDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5Q6pDUUUU
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

Fixes: 66a10eb60ebe ("net/sxe2: add PCI BAR mapping")
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

