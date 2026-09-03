Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FA6C61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:58:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04D3A42831;
	Thu,  3 Sep 2026 03:58:03 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 385CD427BC
 for <dev@dpdk.org>; Thu,  3 Sep 2026 03:58:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowADH9kAl1JhqlB1ABw--.24622S2;
 Thu, 03 Sep 2026 09:57:58 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v10 42/48] net/sxe2: correct command channel log messages
Date: Thu,  3 Sep 2026 09:57:57 +0800
Message-ID: <20260903015757.162392-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADH9kAl1JhqlB1ABw--.24622S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7KF15Ww47XF1UCFyUZFb_yoWrJFyrpr
 sFgF1ay3y0qF429r45Jw4fX3W2gr1rKayDuw1fC3WFkasYgF1qqFZ0qr1YvFs8C3WDXwsY
 yanrWFWkKr18KrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
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

Several error/warning messages in sxe2_cmd_chnl.c are inaccurate or
lost context:

- vsi_info_get: message lost the vsi id; restore it
- rxq_bind_irq/rxq_unbind_irq: message lost the rxq index; restore it
- promisc_config: fix "promic" typo in the message
- queue_info_get_update: use "tx/rx queue map get failed" wording
- rxq_mapping_set: incorrect "get dev caps" wording; use
  "rx queue mapping failed"
- txq_mapping_set: "Rx queue" should read "Tx queue"; incorrect
  "get dev caps" wording should read "tx queue mapping failed"

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_cmd_chnl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_cmd_chnl.c b/drivers/net/sxe2/sxe2_cmd_chnl.c
index 6a5c1907c2..65e3a4ca21 100644
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
+		PMD_LOG_ERR(DRV, "tx/rx queue map get failed, ret=%d", ret);
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

