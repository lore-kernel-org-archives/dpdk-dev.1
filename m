Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35872C5DF97
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Aug 2026 08:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BB3340BA0;
	Wed, 26 Aug 2026 10:57:18 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 6DBFD4067B
 for <dev@dpdk.org>; Wed, 26 Aug 2026 10:57:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowAAXIkBlqo5qRuVMBg--.31310S2;
 Wed, 26 Aug 2026 16:57:10 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v3 36/51] net/sxe2: restore link update call in status query
Date: Wed, 26 Aug 2026 16:57:09 +0800
Message-ID: <20260826085709.992053-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
References: <20260818021518.2922515-14-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXIkBlqo5qRuVMBg--.31310S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rJFy5XF4xJrykZF1fWFg_yoW8Kr48pr
 WDu3WavFyaqa1rXw15Aa1xuF1YgF48Gryjk398Ka1fZa4DZr4kAFWrWr1ay3WFk3s8Jrn3
 Aa12qwsrG3WrAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3NB_UUUUU
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

sxe2_drv_mac_link_status_get() no longer calls sxe2_link_update()
after refreshing the link context, so the ethdev link state is only
refreshed during device init (sxe2_link_update_init) and never
updated when link status is queried at runtime, including on LSC
interrupt events.

Move the sxe2_link_update() call back into
sxe2_drv_mac_link_status_get() and simplify sxe2_link_update_init()
accordingly, matching the V3 implementation.

Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 2 ++
 drivers/net/sxe2/sxe2_mac.c      | 9 +--------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 16a2c3fea4..705d259412 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -412,6 +412,7 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 {
 	int32_t ret = 0;
 	struct sxe2_common_device *cdev = adapter->cdev;
+	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
 	struct sxe2_drv_cmd_params param = {0};
 	struct sxe2_drv_link_info_resp resp = {0};
 
@@ -425,6 +426,7 @@ int32_t sxe2_drv_mac_link_status_get(struct sxe2_adapter *adapter)
 	}
 	adapter->link_ctxt.speed = resp.speed;
 	adapter->link_ctxt.link_up = resp.status;
+	(void)sxe2_link_update(dev, 0);
 
 l_end:
 	return ret;
diff --git a/drivers/net/sxe2/sxe2_mac.c b/drivers/net/sxe2/sxe2_mac.c
index 729c804ac3..7dbea92670 100644
--- a/drivers/net/sxe2/sxe2_mac.c
+++ b/drivers/net/sxe2/sxe2_mac.c
@@ -448,18 +448,11 @@ int32_t sxe2_link_update_init(struct rte_eth_dev *dev)
 	int32_t ret;
 
 	PMD_INIT_FUNC_TRACE();
-
 	rte_spinlock_init(&adapter->link_ctxt.link_lock);
-
 	ret = sxe2_drv_mac_link_status_get(adapter);
-	if (ret) {
+	if (ret)
 		PMD_DEV_LOG_ERR(adapter, DRV, "Failed to get link status, ret=%d", ret);
-		goto l_end;
-	}
 
-	(void)sxe2_link_update(dev, 0);
-
-l_end:
 	return ret;
 }
 int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete)
-- 
2.52.0

