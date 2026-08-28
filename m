Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B64C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:39:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F144940DD2;
	Fri, 28 Aug 2026 09:39:41 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 4104140A6E
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:39:34 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn6jgsO5FqWdJzBg--.60951S2;
 Fri, 28 Aug 2026 15:39:24 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 29/45] net/sxe2: refactor Tx queue reset operations
Date: Fri, 28 Aug 2026 15:39:24 +0800
Message-ID: <20260828073924.2249259-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn6jgsO5FqWdJzBg--.60951S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4DXrWrAw43Aryxtw18Zrb_yoWxGry3pF
 sYgr43AF1rXF47Ww15GF4fZF1F9F10qr1jkFWxK34Syry2gF1qvF1UtF15uw1rCr95Cw4S
 va17JFsrWa1UGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcoqcUUUUU
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
 drivers/net/sxe2/sxe2_txrx_vec.c | 16 +++++++++++-
 drivers/net/sxe2/sxe2_txrx_vec.h |  1 +
 4 files changed, 51 insertions(+), 12 deletions(-)

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
index cf004f5eb2..9cfa565548 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec.c
@@ -8,6 +8,19 @@
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
 
+static void sxe2_tx_queue_mbufs_release_vec(struct sxe2_tx_queue *txq);
+
+struct sxe2_txq_ops sxe2_tx_vec_ops_get(void)
+{
+	static const struct sxe2_txq_ops ops = {
+		.queue_reset      = sxe2_tx_queue_reset_vec,
+		.mbufs_release    = sxe2_tx_queue_mbufs_release_vec,
+		.buffer_ring_free = sxe2_tx_buffer_ring_free,
+	};
+
+	return ops;
+}
+
 int32_t __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags)
 {
 	struct sxe2_rx_queue *rxq;
@@ -233,7 +246,8 @@ int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev)
 			PMD_LOG_INFO(TX, "Failed to prepare tx queue, txq[%d] is NULL", i);
 			continue;
 		}
-		txq->ops.mbufs_release = sxe2_tx_queue_mbufs_release_vec;
+		txq->ops = sxe2_tx_vec_ops_get();
+		txq->ops.queue_reset(txq);
 	}
 	return ret;
 }
diff --git a/drivers/net/sxe2/sxe2_txrx_vec.h b/drivers/net/sxe2/sxe2_txrx_vec.h
index c139aed776..b9bc4f9c27 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec.h
+++ b/drivers/net/sxe2/sxe2_txrx_vec.h
@@ -89,6 +89,7 @@ uint16_t sxe2_rx_pkts_scattered_vec_neon_offload(void *rx_queue, struct rte_mbuf
 uint16_t sxe2_tx_pkts_vec_neon_simple(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 uint16_t sxe2_tx_pkts_vec_neon(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 #endif
+struct sxe2_txq_ops sxe2_tx_vec_ops_get(void);
 int32_t __rte_cold sxe2_tx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
 int32_t __rte_cold sxe2_tx_queues_vec_prepare(struct rte_eth_dev *dev);
 int32_t __rte_cold sxe2_rx_vec_support_check(struct rte_eth_dev *dev, uint32_t *vec_flags);
-- 
2.52.0

