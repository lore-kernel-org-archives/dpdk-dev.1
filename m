Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716CEC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:41:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83E2940696;
	Mon, 31 Aug 2026 04:41:21 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8ADEF40659;
 Mon, 31 Aug 2026 04:41:17 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADHyjjF6ZRqhtCjBg--.24072S2;
 Mon, 31 Aug 2026 10:41:09 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 01/47] common/sxe2: fix null pointer in class driver remove
Date: Mon, 31 Aug 2026 10:41:09 +0800
Message-ID: <20260831024109.3230443-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHyjjF6ZRqhtCjBg--.24072S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15KFyDAF43Ar4DXw43Wrg_yoW8GF1xpF
 48JryfuFy8tF47WwsrJ3W5ZFyfKa13XFyUC39rGas3Zrs8ZFW8Za4UKa4ay3s5CrWrJFsa
 yFWayF1rCF17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgmiiUUUUU=
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

