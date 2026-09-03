Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F409C624D6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:54:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD7F940E50;
	Thu,  3 Sep 2026 03:54:04 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E5CC640E50;
 Thu,  3 Sep 2026 03:54:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAHcDo205hqjQ5ABw--.24757S2;
 Thu, 03 Sep 2026 09:53:59 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 01/48] common/sxe2: fix null pointer in class driver remove
Date: Thu,  3 Sep 2026 09:53:58 +0800
Message-ID: <20260903015358.161772-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAHcDo205hqjQ5ABw--.24757S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15KFyDAF43Ar4DXw43Wrg_yoW8GF1xpF
 48JryfuFy8tF47WwsrJ3W5ZFyfKa13XFyUC39rGas3Zrs8ZFW8Za4UKa4ay3s5CrWrJFsa
 yFWayF1rCF17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUka14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUmksgUUUUU=
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

