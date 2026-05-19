Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DFFCD4F54
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 03:02:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 811D940669;
	Tue, 19 May 2026 05:01:48 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id D521B4065B
 for <dev@dpdk.org>; Tue, 19 May 2026 05:01:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABH2w6R0gtq2P+2EA--.12035S13;
 Tue, 19 May 2026 11:01:40 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v17 11/11] net/sxe2: implement Tx done cleanup
Date: Tue, 19 May 2026 11:01:32 +0800
Message-ID: <20260519030132.3780057-12-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519030132.3780057-1-liujie5@linkdatatechnology.com>
References: <20260518091405.3295896-12-liujie5@linkdatatechnology.com>
 <20260519030132.3780057-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABH2w6R0gtq2P+2EA--.12035S13
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWDAw1rWw45KF1UXw4DXFb_yoW7Aw17pF
 4kWrW3AF4DX3Z7uw48GayrZr4Fkw4rKr1UKrW3Ka4Sqr9IyF1jyr1ktF13Zw10krZ7Ar1S
 kF47tr4kWF1UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUBv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCF04
 k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
 MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr4
 1lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
 IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB89_UUUUU=
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

This patch implements the 'tx_done_cleanup' ethdev ops in the sxe2
PMD. This interface allows applications to explicitly request the
driver to release mbufs that have been transmitted and are no longer
needed by the hardware.

The implementation iterates through the Tx ring, checking the status
of the descriptors starting from the last cleaned tail. It releases
the corresponding mbufs back to the mempool until either the requested
number of packets are freed or no more completed descriptors are
found.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c    |   1 +
 drivers/net/sxe2/sxe2_txrx.h      |   1 +
 drivers/net/sxe2/sxe2_txrx_poll.c | 102 ++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index d1bdc22bd0..8d66e5d8c5 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -290,6 +290,7 @@ static const struct eth_dev_ops sxe2_eth_dev_ops = {
 	.txq_info_get               = sxe2_tx_queue_info_get,
 	.rx_burst_mode_get          = sxe2_rx_burst_mode_get,
 	.tx_burst_mode_get          = sxe2_tx_burst_mode_get,
+	.tx_done_cleanup            = sxe2_tx_done_cleanup,
 };
 
 struct sxe2_pci_map_bar_info *sxe2_dev_get_bar_info(struct sxe2_adapter *adapter,
diff --git a/drivers/net/sxe2/sxe2_txrx.h b/drivers/net/sxe2/sxe2_txrx.h
index 61c6641e49..6d3d7455c2 100644
--- a/drivers/net/sxe2/sxe2_txrx.h
+++ b/drivers/net/sxe2/sxe2_txrx.h
@@ -12,6 +12,7 @@ int32_t __rte_cold sxe2_tx_simple_batch_support_check(struct rte_eth_dev *dev,
 	uint32_t *batch_flags);
 uint16_t sxe2_tx_pkts_prepare(void *tx_queue,
 		struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
+int32_t sxe2_tx_done_cleanup(void *txq, uint32_t free_cnt);
 void sxe2_tx_mode_func_set(struct rte_eth_dev *dev);
 void __rte_cold sxe2_rx_queue_reset(struct sxe2_rx_queue *rxq);
 void sxe2_rx_mode_func_set(struct rte_eth_dev *dev);
diff --git a/drivers/net/sxe2/sxe2_txrx_poll.c b/drivers/net/sxe2/sxe2_txrx_poll.c
index 2931f52445..0455e9483b 100644
--- a/drivers/net/sxe2/sxe2_txrx_poll.c
+++ b/drivers/net/sxe2/sxe2_txrx_poll.c
@@ -10,8 +10,10 @@
 #include <ethdev_driver.h>
 #include "sxe2_osal.h"
 #include "sxe2_txrx_common.h"
+#include "sxe2_txrx_vec_common.h"
 #include "sxe2_txrx_poll.h"
 #include "sxe2_txrx.h"
+#include "sxe2_txrx_vec.h"
 #include "sxe2_queue.h"
 #include "sxe2_ethdev.h"
 #include "sxe2_common_log.h"
@@ -116,6 +118,106 @@ static inline int32_t sxe2_tx_cleanup(struct sxe2_tx_queue *txq)
 	return ret;
 }
 
+static int32_t sxe2_tx_done_cleanup_simple(struct sxe2_tx_queue *txq, uint32_t free_cnt)
+{
+	uint32_t free_cnt_align;
+	uint32_t free_cnt_once;
+	uint32_t i;
+
+	if (free_cnt == 0 || free_cnt > txq->ring_depth)
+		free_cnt = txq->ring_depth;
+
+	free_cnt_align = free_cnt - (free_cnt % txq->rs_thresh);
+	for (i = 0; i < free_cnt_align; i += free_cnt_once) {
+		if ((txq->ring_depth - txq->desc_free_num) < txq->rs_thresh)
+			break;
+
+		free_cnt_once = sxe2_tx_bufs_free(txq);
+		if (free_cnt_once == 0)
+			break;
+	}
+
+	return i;
+}
+
+static int32_t sxe2_tx_done_cleanup_normal(struct sxe2_tx_queue *txq, uint32_t free_cnt)
+{
+	struct sxe2_tx_buffer *buffer_ring = txq->buffer_ring;
+	int32_t ret;
+	uint16_t clean_last_idx, clean_idx;
+	uint16_t clean_last, clean_once;
+	uint16_t pkt_cnt, i;
+
+	if (txq->desc_free_num == 0 && sxe2_tx_cleanup(txq) != 0) {
+		ret = 0;
+		goto l_end;
+	}
+
+	if (free_cnt == 0)
+		free_cnt = txq->ring_depth;
+
+	clean_last_idx = txq->next_use;
+	clean_idx = buffer_ring[clean_last_idx].next_id;
+	clean_once = txq->desc_free_num;
+	clean_last = txq->desc_free_num;
+
+	for (pkt_cnt = 0; pkt_cnt < free_cnt;) {
+		for (i = 0; ((i < clean_once) &&
+			     (pkt_cnt < free_cnt) &&
+			     clean_idx != clean_last_idx); ++i) {
+			if (buffer_ring[clean_idx].mbuf != NULL) {
+				rte_pktmbuf_free_seg(buffer_ring[clean_idx].mbuf);
+				buffer_ring[clean_idx].mbuf = NULL;
+				if (buffer_ring[clean_idx].last_id == clean_idx)
+					pkt_cnt++;
+			}
+			clean_idx = buffer_ring[clean_idx].next_id;
+		}
+
+		if ((txq->rs_thresh > (txq->ring_depth - txq->desc_free_num)) ||
+		    clean_idx == clean_last_idx)
+			break;
+
+		if (pkt_cnt < free_cnt) {
+			if (sxe2_tx_cleanup(txq) != 0)
+				break;
+
+			clean_once = txq->desc_free_num - clean_last;
+			clean_last = txq->desc_free_num;
+		}
+	}
+
+	ret = pkt_cnt;
+l_end:
+	return ret;
+}
+
+int32_t sxe2_tx_done_cleanup(void *tx_queue, uint32_t free_cnt)
+{
+	struct sxe2_tx_queue *txq = (struct sxe2_tx_queue *)tx_queue;
+	struct sxe2_adapter *adapter;
+	int32_t ret;
+
+	if (txq == NULL) {
+		ret = 0;
+		goto l_end;
+	}
+
+	adapter = txq->vsi->adapter;
+	if (adapter->q_ctxt.tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)
+		ret = -ENOTSUP;
+	else if (adapter->q_ctxt.tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH)
+		ret = sxe2_tx_done_cleanup_simple(txq, free_cnt);
+	else
+		ret = sxe2_tx_done_cleanup_normal(txq, free_cnt);
+
+	PMD_LOG_DEBUG(TX, "TX cleanup done desc queue_id=%u free_cnt=%d.",
+				txq->queue_id, ret);
+
+l_end:
+	return ret;
+}
+
 static __rte_always_inline uint16_t
 sxe2_tx_pkt_data_desc_count(struct rte_mbuf *tx_pkt)
 {
-- 
2.47.3

