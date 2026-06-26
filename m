Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67541CD4F26
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 06:46:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A208E40684;
	Fri, 26 Jun 2026 08:46:27 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 9653640264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:46:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXjbQ7ID5qAAvnFQ--.16786S2;
 Fri, 26 Jun 2026 14:46:19 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v9 16/23] net/sxe2: implement get monitor address
Date: Fri, 26 Jun 2026 14:46:19 +0800
Message-ID: <20260626064619.361256-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
References: <220260625133139.207632-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXjbQ7ID5qAAvnFQ--.16786S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8AF1fWF1kZFW3Ww15urg_yoW5Xw4kpF
 4kX34fZF1rJa17Ww1fGa1fuF1YgF4xtFyjkryIk34fuF1kJF1UAFZ8tFyYy3WYyryUGF1S
 vFsrArsrGay5ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F
 4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwID7UUUU
 U==
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
index 02ff6be322..d6efab239c 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -183,6 +183,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.queue_stats_mapping_set    = sxe2_queue_stats_mapping_set,
 
 	.fw_version_get             = sxe2_fw_version_string_get,
+
+	.get_monitor_addr           = sxe2_get_monitor_addr,
 };
 
 static int32_t sxe2_dev_configure(struct rte_eth_dev *dev)
diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index 2495ab3ab7..820d4f0620 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -534,3 +534,24 @@ void __rte_cold sxe2_rxqs_all_stop(struct rte_eth_dev *dev)
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

