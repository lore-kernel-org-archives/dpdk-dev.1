Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205FBC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:43:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 776CE40678;
	Mon, 31 Aug 2026 04:43:50 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 08CF34025A
 for <dev@dpdk.org>; Mon, 31 Aug 2026 04:43:47 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowACXmzli6pRqjdejBg--.23044S2;
 Mon, 31 Aug 2026 10:43:46 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v7 28/47] net/sxe2: refactor Tx queue reset operations
Date: Mon, 31 Aug 2026 10:43:46 +0800
Message-ID: <20260831024346.3230958-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowACXmzli6pRqjdejBg--.23044S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4DXrWrAw43Aryxtw18Zrb_yoW7AFWrpF
 4vgr43AF1rXa17W345KF4xZ3WS9FnYqr12kFWxK34SyFyagF1qvF1UtF15Wwn5Cr95Cw4r
 ZF47XFs7W3WUJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjwID7
 UUUUU==
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

Extract the descriptor ring reset loop into a sxe2_tx_queue_desc_ring_reset
helper and reuse it from both the scalar and vectorized queue reset paths.
Add a sxe2_tx_queue_reset_vec entry point for vectorized queues, export
sxe2_tx_buffer_ring_free for reuse outside the module (clearing the buffer
ring pointer after freeing it), and add sxe2_tx_vec_ops_get to build the
vectorized Tx queue operations table used by the vector path setup.

Cc: stephen@networkplumber.org

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_tx.c       | 42 +++++++++++++++++++++++---------
 drivers/net/sxe2/sxe2_tx.h       |  4 +++
 drivers/net/sxe2/sxe2_txrx_vec.c | 17 ++++++++++---
 3 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_tx.c b/drivers/net/sxe2/sxe2_tx.c
index f49238ceef..94a6e9afc7 100644
--- a/drivers/net/sxe2/sxe2_tx.c
+++ b/drivers/net/sxe2/sxe2_tx.c
@@ -19,6 +19,17 @@ static void *sxe2_tx_doorbell_addr_get(struct sxe2_adapter *adapter, uint16_t qu
 				     queue_id);
 }
 
+static void sxe2_tx_queue_desc_ring_reset(struct sxe2_tx_queue *txq)
+{
+	uint16_t i;
+	static const union sxe2_tx_data_desc zeroed_desc = {{0}};
+
+	for (i = 0; i < txq->ring_depth; i++) {
+		txq->desc_ring[i] = zeroed_desc;
+		txq->desc_ring[i].wb.dd = rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE);
+	}
+}
+
 static void sxe2_tx_tail_init(struct sxe2_adapter *adapter, struct sxe2_tx_queue *txq)
 {
 	txq->tdt_reg_addr = sxe2_tx_doorbell_addr_get(adapter, txq->queue_id);
@@ -28,20 +39,12 @@ static void sxe2_tx_tail_init(struct sxe2_adapter *adapter, struct sxe2_tx_queue
 void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq)
 {
 	uint16_t prev, i;
-	volatile union sxe2_tx_data_desc *txd;
-	static const union sxe2_tx_data_desc zeroed_desc = {{0}};
 	struct sxe2_tx_buffer *tx_buffer = txq->buffer_ring;
 
-	for (i = 0; i < txq->ring_depth; i++)
-		txq->desc_ring[i] = zeroed_desc;
+	sxe2_tx_queue_desc_ring_reset(txq);
 
 	prev = txq->ring_depth - 1;
 	for (i = 0; i < txq->ring_depth; i++) {
-		txd = &txq->desc_ring[i];
-		if (txd == NULL)
-			continue;
-
-		txd->wb.dd = rte_cpu_to_le_64(SXE2_TX_DESC_DTYPE_DESC_DONE);
 		tx_buffer[i].mbuf       = NULL;
 		tx_buffer[i].last_id    = i;
 		tx_buffer[prev].next_id = i;
@@ -56,6 +59,21 @@ void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq)
 	txq->next_rs       = txq->rs_thresh  - 1;
 }
 
+void __rte_cold sxe2_tx_queue_reset_vec(struct sxe2_tx_queue *txq)
+{
+	sxe2_tx_queue_desc_ring_reset(txq);
+
+	memset(txq->buffer_ring, 0,
+		sizeof(struct sxe2_tx_buffer) * txq->ring_depth);
+
+	txq->desc_used_num = 0;
+	txq->desc_free_num = txq->ring_depth - 1;
+	txq->next_use      = 0;
+	txq->next_clean    = txq->ring_depth - 1;
+	txq->next_dd       = txq->rs_thresh  - 1;
+	txq->next_rs       = txq->rs_thresh  - 1;
+}
+
 void __rte_cold sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq)
 {
 	uint32_t i;
@@ -70,10 +88,12 @@ void __rte_cold sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq)
 	}
 }
 
-static void sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq)
+void __rte_cold sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq)
 {
-	if (txq != NULL && txq->buffer_ring != NULL)
+	if (txq != NULL && txq->buffer_ring != NULL) {
 		rte_free(txq->buffer_ring);
+		txq->buffer_ring = NULL;
+	}
 }
 
 const struct sxe2_txq_ops sxe2_default_txq_ops = {
diff --git a/drivers/net/sxe2/sxe2_tx.h b/drivers/net/sxe2/sxe2_tx.h
index f4823126b3..bc5ff1c2bc 100644
--- a/drivers/net/sxe2/sxe2_tx.h
+++ b/drivers/net/sxe2/sxe2_tx.h
@@ -9,6 +9,10 @@
 
 void __rte_cold sxe2_tx_queue_reset(struct sxe2_tx_queue *txq);
 
+void __rte_cold sxe2_tx_queue_reset_vec(struct sxe2_tx_queue *txq);
+
+void __rte_cold sxe2_tx_buffer_ring_free(struct sxe2_tx_queue *txq);
+
 int32_t __rte_cold sxe2_tx_queue_start(struct rte_eth_dev *dev, uint16_t queue_id);
 
 void sxe2_tx_queue_mbufs_release(struct sxe2_tx_queue *txq);
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.c b/drivers/net/sxe2/sxe2_txrx_vec.c
index cf004f5eb2..1442d5d119 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -8,6 +8,14 @@
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
 
+static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq);
+
+static const struct sxe2_txq_ops sxe2_tx_vec_ops = {
+	.queue_reset      = sxe2_tx_queue_reset_vec,
+	.mbufs_release    = sxe2_tx_queue_mbufs_release_vec,
+	.buffer_ring_free = sxe2_tx_buffer_ring_free,
+};
+
 int32_t __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags)
 {
 	struct sxe2_rx_queue *rxq;
@@ -230,10 +238,13 @@ int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; ++i) {
 		txq = dev->data->tx_queues[i];
 		if (txq == NULL) {
-			PMD_LOG_INFO(TX, "Failed to prepare tx queue, txq[%d] is NULL", i);
-			continue;
+			PMD_LOG_ERR(TX, "Failed to prepare tx queue, txq[%d] is NULL", i);
+			ret = -EINVAL;
+			goto l_end;
 		}
-		txq->ops.mbufs_release = sxe2_tx_queue_mbufs_release_vec;
+		txq->ops = sxe2_tx_vec_ops;
+		txq->ops.queue_reset(txq);
 	}
+l_end:
 	return ret;
 }
-- 
2.52.0

