Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A026C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:57:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF3D5427DD;
	Thu,  3 Sep 2026 03:57:24 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id A7668427CC;
 Thu,  3 Sep 2026 03:57:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABHsDr905hqLBtABw--.23988S2;
 Thu, 03 Sep 2026 09:57:17 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 35/48] net/sxe2: refresh link state on link change events
Date: Thu,  3 Sep 2026 09:57:17 +0800
Message-ID: <20260903015717.162282-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHsDr905hqLBtABw--.23988S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kZr45GF17Jry5ZF1UZFb_yoW5GFWkpr
 WY9F13ZFyjqanYvwn5Aa18uFyj93W8KryjkrZ0k3WfX3WDZr48AFZ0q343t3W0y39xXFn2
 y39xXrsrJa18Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
 MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRKLvNUU
 UUU
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

sxe2_link_update() was only called during device init, so the ethdev
link state was not refreshed when link status changed at runtime.

Call sxe2_link_update() in the link-change IRQ handler for both the
PF and its representors, so the link state is updated on LSC events.
Keep the sxe2_link_update() call in sxe2_link_update_init(), now
conditional on a successful link status read, so the initial link
state is still populated at init.

Fixes: 1d7fd921beef ("net/sxe2: support link update")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_irq.c |  2 ++
 drivers/net/sxe2/sxe2_mac.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index ba764dd5e4..4c3a29900d 100644
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

