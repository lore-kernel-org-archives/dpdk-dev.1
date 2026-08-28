Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5FEC61DC4
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 03:27:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 659F040E4B;
	Fri, 28 Aug 2026 05:27:11 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1C52C40E16
 for <dev@dpdk.org>; Fri, 28 Aug 2026 05:27:09 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACnc0EMAJFqpC1wBg--.60867S2;
 Fri, 28 Aug 2026 11:27:08 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v5 41/45] net/sxe2: fix command channel log messages
Date: Fri, 28 Aug 2026 11:27:08 +0800
Message-ID: <20260828032708.2109193-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
References: <20260827024035.1432256-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACnc0EMAJFqpC1wBg--.60867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7KrW3JFy5tw1ktFWrKrg_yoWrGF45pr
 sFgF1ayryFqF4a9r45Jw4fX3W2gr1rKayDuw1fC3WFk3ZY9F1qqrZ0qry5tFs8Cw1DXws5
 tan7WFs5Kr18KrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkab7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4xxMxAI
 w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jyQ6JUUUUU=
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

Several error/warning messages in sxe2_cmd_chnl.c are inaccurate or
lost context:

- vsi_info_get: message lost the vsi id; restore it
- rxq_bind_irq/rxq_unbind_irq: message lost the rxq index; restore it
- promisc_config: fix "promic" typo in the message
- queue_info_get_update/rxq_mapping_set: incorrect "get queue info
  map"/"get dev caps" wording; use "rx queue mapping failed"
- txq_mapping_set: "Rx queue" should read "Tx queue"; incorrect
  "get dev caps" wording should read "tx queue mapping failed"

Fixes: a2b79a93515e ("net/sxe2: support L2 filtering and MAC config")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 89829f29be..0d81da542e 100644
--- a/drivers/net/sxe2/sxe2_cmd_chnl.c
+++ b/drivers/net/sxe2/sxe2_cmd_chnl.c
@@ -481,7 +481,7 @@ int32_t sxe2_drv_vsi_info_get(struct sxe2_adapter *adapter, struct sxe2_vsi *vsi
 			&vsi_info_get_resp, sizeof(vsi_info_get_resp));
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
-		PMD_DEV_LOG_ERR(adapter, DRV, "switchdev cpvsi info get failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "vsi %u info get failed, ret=%d", vsi->vsi_id, ret);
 		goto l_end;
 	}
 
@@ -537,7 +537,7 @@ int32_t sxe2_drv_rxq_bind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx, ui
 				 NULL, 0);
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_ERR(adapter, DRV, "rxq bind irq failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq %u bind irq failed, ret=%d", rxq_idx, ret);
 
 	return ret;
 }
@@ -557,7 +557,7 @@ int32_t sxe2_drv_rxq_unbind_irq(struct sxe2_adapter *adapter, uint16_t rxq_idx)
 				 NULL, 0);
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_ERR(adapter, DRV, "rxq unbind irq failed, ret=%d", ret);
+		PMD_DEV_LOG_ERR(adapter, DRV, "rxq %u unbind irq failed, ret=%d", rxq_idx, ret);
 
 	return ret;
 }
@@ -758,7 +758,7 @@ int32_t sxe2_drv_promisc_config(struct sxe2_adapter *adapter, bool set)
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_DEV_LOG_WARN(adapter, DRV, "promic config failed, ret=%d", ret);
+		PMD_DEV_LOG_WARN(adapter, DRV, "promisc config failed, ret=%d", ret);
 
 	return ret;
 }
@@ -1683,7 +1683,7 @@ int32_t sxe2_drv_queue_info_get_update(struct sxe2_adapter *adapter, struct eth_
 				 &resp, sizeof(resp));
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret) {
-		PMD_LOG_ERR(DRV, "get queue info map failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "rx queue mapping failed, ret=%d", ret);
 		goto l_end;
 	}
 
@@ -1727,7 +1727,7 @@ int32_t sxe2_drv_rxq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "rx queue mapping failed, ret=%d", ret);
 
 l_end:
 	return ret;
@@ -1744,7 +1744,7 @@ int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	txq = eth_dev->data->tx_queues[queue_id];
 	if (txq == NULL) {
-		PMD_LOG_ERR(DRV, "Rx queue %u is not available or setup", queue_id);
+		PMD_LOG_ERR(DRV, "Tx queue %u is not available or setup", queue_id);
 		ret = -EINVAL;
 		goto l_end;
 	}
@@ -1758,7 +1758,7 @@ int32_t sxe2_drv_txq_mapping_set(struct rte_eth_dev *eth_dev, uint16_t queue_id,
 
 	ret = sxe2_drv_cmd_exec(cdev, &param);
 	if (ret)
-		PMD_LOG_ERR(DRV, "get dev caps failed, ret=%d", ret);
+		PMD_LOG_ERR(DRV, "tx queue mapping failed, ret=%d", ret);
 
 l_end:
 	return ret;
-- 
2.52.0

