Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C16C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:41:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6675D40E38;
	Fri, 28 Aug 2026 09:41:00 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 2415F40DDE
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:40:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABHUD6IO5Fq69hzBg--.10853S2;
 Fri, 28 Aug 2026 15:40:56 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 45/45] net/sxe2: remove ineffective queue counts in
 representor info
Date: Fri, 28 Aug 2026 15:40:56 +0800
Message-ID: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABHUD6IO5Fq69hzBg--.10853S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15GFyUWry8uw4ruF4rZrb_yoW8WFW5pF
 sYqFyrAay5JF1jgwn8Can7ua4YgF4xG3yxGr9xt34fu34UZ34UZFWUJ34ay3ZFyrW8XF40
 van7WrsruFn09F7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
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

rte_eth_dev_info_get() overwrites dev_info->nb_rx_queues and
dev_info->nb_tx_queues from dev->data after the PMD dev_infos_get
callback returns, so assigning them in sxe2_repr_dev_infos_get() has
no effect. Remove the ineffective assignments.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev_repr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index b7096f5927..ec45187dc9 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -127,7 +127,7 @@ static int32_t sxe2_repr_dev_close(struct rte_eth_dev *dev)
 	return 0;
 }
 
-static int32_t sxe2_repr_dev_infos_get(struct rte_eth_dev *dev,
+static int32_t sxe2_repr_dev_infos_get(__rte_unused struct rte_eth_dev *dev,
 			struct rte_eth_dev_info *dev_info)
 {
 	dev_info->max_rx_queues = 1;
@@ -195,8 +195,6 @@ static int32_t sxe2_repr_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
 			 RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
 
-	dev_info->nb_rx_queues = dev->data->nb_rx_queues;
-	dev_info->nb_tx_queues = dev->data->nb_tx_queues;
 
 	dev_info->default_rxportconf.burst_size = SXE2_RX_MAX_BURST;
 	dev_info->default_txportconf.burst_size = SXE2_TX_MAX_BURST;
-- 
2.52.0

