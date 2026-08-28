Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96177C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECA3540C35;
	Fri, 28 Aug 2026 09:40:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 48F36402B6
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:39:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnsT9JO5FqgtRzBg--.56799S2;
 Fri, 28 Aug 2026 15:39:53 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 34/45] net/sxe2: restore link update call in status query
Date: Fri, 28 Aug 2026 15:39:52 +0800
Message-ID: <20260828073953.2249559-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnsT9JO5FqgtRzBg--.56799S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW7KrWfZr4xCr4UWw47twb_yoW5Gw47pr
 WUuF13XFyjqanYqwn8Aa1fuFyjga48GryUKrZ0k3Z3Xa4UAr48AFZ0q34ay3W0v398XFna
 yw47XrsrJw18Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUsrgAUUUUU
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

Fixes: 1d7fd921beef ("net/sxe2: support link update")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_irq.c |  2 ++
 drivers/net/sxe2/sxe2_mac.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 4e5339e24b..b0e1552d5f 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -84,6 +84,7 @@ static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t
 	if (oicr & RTE_BIT32(SXE2_COM_EC_LINK_CHG)) {
 		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=0x%" PRIx64, oicr);
 		(void)sxe2_drv_mac_link_status_get(adapter);
+		(void)sxe2_link_update(dev, 0);
 		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			rte_eth_dev_callback_process(dev,
 						     RTE_ETH_EVENT_INTR_LSC,
@@ -96,6 +97,7 @@ static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t
 					continue;
 				repr_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(repr_eth_dev);
 				(void)sxe2_drv_mac_link_status_get(repr_adapter);
+				(void)sxe2_link_update(repr_eth_dev, 0);
 				if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 					rte_eth_dev_callback_process(repr_eth_dev,
 								     RTE_ETH_EVENT_INTR_LSC,
diff --git a/drivers/net/sxe2/sxe2_mac.c b/drivers/net/sxe2/sxe2_mac.c
index 729c804ac3..ab9bd5355b 100644
--- a/drivers/net/sxe2/sxe2_mac.c
+++ b/drivers/net/sxe2/sxe2_mac.c
@@ -448,18 +448,13 @@ int32_t sxe2_link_update_init(struct rte_eth_dev *dev)
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
-
-	(void)sxe2_link_update(dev, 0);
+	else
+		(void)sxe2_link_update(dev, 0);
 
-l_end:
 	return ret;
 }
 int32_t sxe2_link_update(struct rte_eth_dev *dev, __rte_unused int32_t wait_to_complete)
-- 
2.52.0

