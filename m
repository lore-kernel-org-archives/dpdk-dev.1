Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9797CCD4F5B
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:19:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 186404068A;
	Wed, 20 May 2026 04:18:30 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id E3711402DA
 for <dev@dpdk.org>; Wed, 20 May 2026 04:18:21 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowAA3zRDnGQ1qhsnVEA--.10188S13;
 Wed, 20 May 2026 10:18:19 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v19 11/11] net/sxe2: implement Tx done cleanup
Date: Wed, 20 May 2026 10:18:09 +0800
Message-ID: <20260520021809.4019054-12-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
References: <20260519144810.3951202-12-liujie5@linkdatatechnology.com>
 <20260520021809.4019054-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3zRDnGQ1qhsnVEA--.10188S13
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWDAw1rWw45KF1UXw4DXFb_yoW7Aw17pF
 4kWrW3AF4DX3Z7uw48GFWrZr4F9w4rKr1UKrW3Ka4Sqr9IyF1jyr1ktF13Zw10krZ7Ar1S
 kF47tr4kWF1UWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
index 7ec70d952e..b9d34afb31 100644
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
 static __rte_always_inline uint32_t
 sxe2_tx_pkt_data_desc_count(struct rte_mbuf *tx_pkt)
 {
-- 
2.47.3

