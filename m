Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5692CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 08:29:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2E3540A73;
	Thu, 18 Jun 2026 10:27:54 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 490AA40268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 10:27:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAAnlunwqzNqY8cLFA--.46372S16;
 Thu, 18 Jun 2026 16:27:34 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3 14/20] net/sxe2: implement get monitor address
Date: Thu, 18 Jun 2026 16:27:17 +0800
Message-ID: <20260618082723.571054-15-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260618082723.571054-1-liujie5@linkdatatechnology.com>
References: <20260614092328.201826-21-liujie5@linkdatatechnology.com>
 <20260618082723.571054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnlunwqzNqY8cLFA--.46372S16
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8AF1fWF1kZFW3Ww15urg_yoW5Xw4kpF
 4kX34fZF1rJa17Ww1fGa1fuF1YgF4xtFyjkryIk34fuF1kJF17AFZ8tFyYy3WjkryUGF1S
 vrsrArsrGay5ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWx
 Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
 x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xxMx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbfcTJUUUUU==
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
index 98f79c180c..493b720f0b 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -185,6 +185,8 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
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
2.31.1

