Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16BCCD8C8E
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 05:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B127E40676;
	Mon,  8 Jun 2026 07:42:40 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id BBCAA40657
 for <dev@dpdk.org>; Mon,  8 Jun 2026 07:42:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowACnHvJBViZq3m2tEg--.175S16;
 Mon, 08 Jun 2026 13:42:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v12 14/20] net/sxe2: implement get monitor address
Date: Mon,  8 Jun 2026 13:42:13 +0800
Message-ID: <20260608054219.3000719-15-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260608054219.3000719-1-liujie5@linkdatatechnology.com>
References: <20260607013342.2579271-21-liujie5@linkdatatechnology.com>
 <20260608054219.3000719-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnHvJBViZq3m2tEg--.175S16
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8AF1fWF1kZFW3Ww15urg_yoW5Xw4kpF
 4kX34fZF1rJa17Ww1fGa1fuF1Y9a1xtFyjkrWI934fuF1kJF1jyFZ8tFyYy3WjyryUGF1S
 vFsrArsrGayrur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBm14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
 8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYGYpUUUUU
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

This patch implements the 'get_monitor_addr' ethdev ops in the sxe2
PMD. This interface allows the Ethernet device to provide the
address of the next expected Rx descriptor to the power management
library.

The implementation calculates the address of the next Rx descriptor
based on the receive queue's current hardware ring position and
descriptor size. Applications can then use this address with
rte_power_monitor() to put the CPU into a low-power state until
new packets are written to the descriptor by the hardware.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c |  2 ++
 drivers/net/sxe2/sxe2_rx.c     | 21 +++++++++++++++++++++
 drivers/net/sxe2/sxe2_rx.h     |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index 4842a8cdac..d1bc5b1500 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -184,6 +184,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
 
 	.fw_version_get             = sxe2_fw_version_string_get,
+
+	.get_monitor_addr           = sxe2_get_monitor_addr,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 007192c7d8..79e65cfbf1 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -557,3 +557,24 @@ void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev)
 		}
 	}
 }
+
+static int32_t sxe2_monitor_callback(const uint64_t value,
+				 const uint64_t arg[RTE_POWER_MONITOR_OPAQUE_SZ] __rte_unused)
+{
+	const uint64_t dd_state = rte_cpu_to_le_64(SXE2_RX_DESC_STATUS_DD_MASK);
+	return (value & dd_state) == dd_state ? -1 : 0;
+}
+
+int32_t sxe2_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc)
+{
+	volatile union sxe2_rx_desc *rxdp;
+	struct sxe2_rx_queue *rxq = (struct sxe2_rx_queue *)rx_queue;
+
+	rxdp = &rxq->desc_ring[rxq->processing_idx];
+
+	pmc->addr = &rxdp->wb.status_err_ptype_len;
+	pmc->fn   = sxe2_monitor_callback;
+	pmc->size = sizeof(uint16_t);
+
+	return 0;
+}
diff --git a/drivers/net/sxe2/sxe2_rx.h b/drivers/net/sxe2/sxe2_rx.h
index 295d9005e0..c2582bc571 100644
--- a/drivers/net/sxe2/sxe2_rx.h
+++ b/drivers/net/sxe2/sxe2_rx.h
@@ -29,4 +29,6 @@ int32_t __rte_cold sxe2_rxqs_all_start(struct rte_eth_dev *dev);
 
 void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev);
 
+int32_t sxe2_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
+
 #endif /* SXE2_RX_H */
-- 
2.52.0

