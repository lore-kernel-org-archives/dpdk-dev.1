Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6751DC61DC4
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:28:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F47F40EE2;
	Fri, 28 Aug 2026 05:27:37 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5308A40E3F
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:27:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADX2zkjAJFq+S5wBg--.211S2;
 Fri, 28 Aug 2026 11:27:31 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 45/45] net/sxe2: remove ineffective queue counts in
 representor info
Date: Fri, 28 Aug 2026 11:27:31 +0800
Message-ID: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADX2zkjAJFq+S5wBg--.211S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15GFyUWry8uw4ruF4rZrb_yoW8Jw1xpF
 4FqFy5CF4rXF15Kwn5Ca1xWa4YgF4UG3y7CrZrt34fu34UZ34UZFyDJFySvayvyr48XF40
 vws7XrsIgFnYvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr
 0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
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

rte_eth_dev_info_get() overwrites dev_info->nb_rx_queues and
dev_info->nb_tx_queues from dev->data after the PMD dev_infos_get
callback returns, so assigning them in sxe2_repr_dev_infos_get() has
no effect. Remove the ineffective assignments.

Fixes: 635084db5d57 ("net/sxe2: support VF representors")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev_repr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev_repr.c b/drivers/net/sxe2/sxe2_ethdev_repr.c
index b7096f5927..5490fea10b 100644
--- a/drivers/net/sxe2/sxe2_ethdev_repr.c
+++ b/drivers/net/sxe2/sxe2_ethdev_repr.c
@@ -195,8 +195,6 @@ static int32_t sxe2_repr_dev_infos_get(struct rte_eth_dev *dev,
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10G | RTE_ETH_LINK_SPEED_25G |
 			 RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
 
-	dev_info->nb_rx_queues = dev->data->nb_rx_queues;
-	dev_info->nb_tx_queues = dev->data->nb_tx_queues;
 
 	dev_info->default_rxportconf.burst_size = SXE2_RX_MAX_BURST;
 	dev_info->default_txportconf.burst_size = SXE2_TX_MAX_BURST;
-- 
2.52.0

