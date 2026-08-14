Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824DBC5CFDB
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 12:23:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30B5D406BA;
	Fri, 14 Aug 2026 14:22:24 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id A5EAC4028F
 for <dev@dpdk.org>; Fri, 14 Aug 2026 14:22:15 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACHjjxyCH9qF1pdBQ--.37690S12;
 Fri, 14 Aug 2026 20:22:14 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v1 10/13] common/sxe2: allow munmap during kernel reset
Date: Fri, 14 Aug 2026 20:22:01 +0800
Message-ID: <20260814122204.2666045-11-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
References: <20260814122204.2666045-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACHjjxyCH9qF1pdBQ--.37690S12
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rGFWxJF4DurW3trWfGrg_yoW8tr4UpF
 48XFy3uFWUtF4UWr4DJa47ua4FgwsIq34UCrZrK3savryDZry8ua48W3Way345CryrJFsY
 yFW2yF1UG3WrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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

This patch improves error handling and resource management:

- Add NULL pointer protection in driver remove path:
  * Check cdrv and cdrv->remove before calling remove function
  * Prevent NULL pointer dereference in sxe2_classes_driver_remove
  * Return SXE2_SUCCESS if no driver or remove handler exists

- Allow memory unmap during kernel reset:
  * Remove kernel_reset restriction in sxe2_drv_dev_munmap
  * Enable cleanup operations even when kernel has been reset

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c     | 5 ++++-
 drivers/common/sxe2/sxe2_ioctl_chnl.c | 8 +-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index 5c5db85f29..3f60b2be11 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -465,8 +465,11 @@ static int32_t sxe2_classes_driver_probe(struct sxe2_common_device *cdev,
 static int32_t sxe2_classes_driver_remove(struct sxe2_common_device *cdev)
 {
 	struct sxe2_class_driver *cdrv = cdev->cdrv;
+	int32_t ret = 0;
 
-	return cdrv->remove(cdev);
+	if (cdrv != NULL && cdrv->remove != NULL)
+		ret = cdrv->remove(cdev);
+	return ret;
 }
 
 static int32_t sxe2_kvargs_validate(struct sxe2_dev_kvargs_info *kv_info)
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

