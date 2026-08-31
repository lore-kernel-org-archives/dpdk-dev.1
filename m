Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFBFC61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:35:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F6F640679;
	Mon, 31 Aug 2026 04:35:16 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 636DC40395
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:35:08 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S11;
 Mon, 31 Aug 2026 10:35:06 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>,
	stephen@networkplumber.org
Subject: [PATCH v7 09/47] net/sxe2: propagate LSC event to VF representors
Date: Mon, 31 Aug 2026 10:34:22 +0800
Message-ID: <20260831023500.3229289-10-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S11
X-Coremail-Antispam: 1UD129KBjvJXoW7tF45Kw4xWF4rJw4ftrW5KFg_yoW8uF1fpF
 Z0gF1rJFy8X3Z2qanxCa18uryYga1rta48Kr9Iyw1a9a4kJryUA343JrnxtF1jy34DX3Z2
 yanxWwnrGrn7GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
 0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
 W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
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

When the PF link state changes in switchdev mode, refresh the link
status of every VF representor and trigger the RTE_ETH_EVENT_INTR_LSC
callback on each, so applications receive link events on representor
ports. Also log OICR in hexadecimal for better readability.

Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_irq.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 3306504761..ba764dd5e4 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -77,14 +77,32 @@ static int32_t sxe2_fc_state_callback(struct rte_eth_dev *dev)
 static void sxe2_event_irq_common_handler(struct sxe2_adapter *adapter, uint64_t oicr)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[adapter->dev_info.dev_data->port_id];
+	struct rte_eth_dev *repr_eth_dev;
+	struct sxe2_adapter *repr_adapter;
+	uint16_t vf_id;
 
 	if (oicr & RTE_BIT32(SXE2_COM_EC_LINK_CHG)) {
-		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=%" PRIu64, oicr);
+		PMD_DEV_LOG_INFO(adapter, DRV, "OICR=0x%" PRIx64, oicr);
 		(void)sxe2_drv_mac_link_status_get(adapter);
-		if (rte_eal_process_type() == RTE_PROC_PRIMARY)
+		if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 			rte_eth_dev_callback_process(dev,
 						     RTE_ETH_EVENT_INTR_LSC,
 						     NULL);
+		}
+		if (adapter->switchdev_info.is_switchdev) {
+			for (vf_id = 0; vf_id < adapter->repr_ctxt.nb_repr_vf; vf_id++) {
+				repr_eth_dev = adapter->repr_ctxt.vf_rep_eth_dev[vf_id];
+				if (!repr_eth_dev)
+					continue;
+				repr_adapter = SXE2_DEV_PRIVATE_TO_ADAPTER(repr_eth_dev);
+				(void)sxe2_drv_mac_link_status_get(repr_adapter);
+				if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
+					rte_eth_dev_callback_process(repr_eth_dev,
+								     RTE_ETH_EVENT_INTR_LSC,
+								     NULL);
+				}
+			}
+		}
 	}
 	if (oicr & RTE_BIT32(SXE2_COM_SW_MODE_SWITCHDEV)) {
 		PMD_DEV_LOG_INFO(adapter, DRV, "event notify switchdev");
-- 
2.52.0

