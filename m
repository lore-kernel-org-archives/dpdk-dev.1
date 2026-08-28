Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC0C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:37:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DB5F40664;
	Fri, 28 Aug 2026 09:37:43 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4BB834003C
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:37:32 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXmzm5OpFqf8lzBg--.54319S2;
 Fri, 28 Aug 2026 15:37:29 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 09/45] net/sxe2: propagate LSC event to VF representors
Date: Fri, 28 Aug 2026 15:37:29 +0800
Message-ID: <20260828073729.2248020-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmzm5OpFqf8lzBg--.54319S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr15CF1ftF4kJryfKr4kWFg_yoW8uw4UpF
 Z0gF1rJFy8X3Z2qanxCa18uryYga1rJa48KF9Iyw1a9a4kJryUC343Jr9xtF4jy34DX3Z2
 yanxWwnrGrn7GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJV
 W8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
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

