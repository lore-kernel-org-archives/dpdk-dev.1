Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F0C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:35:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D51B40613;
	Mon, 31 Aug 2026 04:35:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id E05824025A;
 Mon, 31 Aug 2026 04:35:07 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S3;
 Mon, 31 Aug 2026 10:35:05 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>, stable@dpdk.org,
 stephen@networkplumber.org
Subject: [PATCH v7 01/47] common/sxe2: fix null pointer in class driver remove
Date: Mon, 31 Aug 2026 10:34:14 +0800
Message-ID: <20260831023500.3229289-2-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWrGFy5uF4kKF1DCr4rXwb_yoW8Gr15pF
 48Jry3uFy8tF47WwnrJ3W5Za4Ska13XryUC39rGas3Zrs8ZFy8Za4UKa4ay3s5CrWrJFs2
 yFW3tF1rCF17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE
 2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjc
 xK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAI
 cxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14
 v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY
 c2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
 Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8Jb
 IYCTnIWIevJa73UjIFyTuYvjfUOL05UUUUU
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

sxe2_classes_driver_remove() calls cdrv->remove(cdev) without
checking whether cdrv or cdrv->remove is NULL. If the class driver
was never probed, cdev->cdrv remains NULL, and the unconditional
call dereferences a NULL pointer, crashing during device removal.

Add NULL checks for cdrv and cdrv->remove, returning 0 when either
is NULL.

Fixes: 83866f8d7638 ("common/sxe2: add base driver skeleton")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/common/sxe2/sxe2_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/common/sxe2/sxe2_common.c b/drivers/common/sxe2/sxe2_common.c
index 5c5db85f29..6e387a8a73 100644
--- a/drivers/common/sxe2/sxe2_common.c
+++ b/drivers/common/sxe2/sxe2_common.c
@@ -465,8 +465,12 @@ static int32_t sxe2_classes_driver_probe(struct sxe2_common_device *cdev,
 static int32_t sxe2_classes_driver_remove(struct sxe2_common_device *cdev)
 {
 	struct sxe2_class_driver *cdrv = cdev->cdrv;
+	int32_t ret = 0;
+
+	if (cdrv != NULL && cdrv->remove != NULL)
+		ret = cdrv->remove(cdev);
 
-	return cdrv->remove(cdev);
+	return ret;
 }
 
 static int32_t sxe2_kvargs_validate(struct sxe2_dev_kvargs_info *kv_info)
-- 
2.52.0

