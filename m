Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF8BE7AD41
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Dec 2025 09:23:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDA74406B7;
	Thu, 25 Dec 2025 10:22:42 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id C4C6040647
 for <dev@dpdk.org>; Thu, 25 Dec 2025 10:22:34 +0100 (CET)
Received: from mail.cstnet.cn (unknown [221.238.36.162])
 by APP-01 (Coremail) with SMTP id qwCowABXAW1WAk1p0VvIAQ--.29619S4;
 Thu, 25 Dec 2025 17:22:32 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v14 03/13] net/sxe: add tx rx setup and data path
Date: Thu, 25 Dec 2025 17:22:14 +0800
Message-Id: <20251225092224.227202-3-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20251225092224.227202-1-liujie5@linkdatatechnology.com>
References: <20251225081201.177111-13-liujie5@linkdatatechnology.com>
 <20251225092224.227202-1-liujie5@linkdatatechnology.com>
X-CM-TRANSID: qwCowABXAW1WAk1p0VvIAQ--.29619S4
X-Coremail-Antispam: 1UD129KBjvAXoWDtr48XFW3Kr1rAF1xKFW5Awb_yoWDCr1DWo
 WftF43G3Wrur1xArZxWw4xXFW7ZrW09FWUJrWY9rZ3uF1DAw1UGryUJrW8Zr90gFyFgF1r
 JwnrKr9rGa4j9Fs5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYw7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
 kI8VCY1x0267AKxVWUCVW8JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM2
 8EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCFx2IqxVCFs4IE7xkEbVWUJV
 W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
 1VAFwI0_Jrv_JF1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
 AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
 6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUIFA
 LUUUUU=
X-Originating-IP: [221.238.36.162]
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

Add setup, initialization, and logic for tx and rx queues.

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/meson.build                   |    1 +
 drivers/net/sxe/base/sxe_offload_common.c |   49 +
 drivers/net/sxe/base/sxe_offload_common.h |   14 +
 drivers/net/sxe/base/sxe_queue_common.c   |  396 ++++++
 drivers/net/sxe/base/sxe_queue_common.h   |  240 ++++
 drivers/net/sxe/base/sxe_rx_common.c      |  238 ++++
 drivers/net/sxe/base/sxe_rx_common.h      |   17 +
 drivers/net/sxe/base/sxe_tx_common.c      |   40 +
 drivers/net/sxe/base/sxe_tx_common.h      |   12 +
 drivers/net/sxe/include/sxe_type.h        |  795 +++++++++++
 drivers/net/sxe/meson.build               |    8 +
 drivers/net/sxe/pf/sxe.h                  |    3 +
 drivers/net/sxe/pf/sxe_ethdev.c           |    2 +-
 drivers/net/sxe/pf/sxe_irq.c              |  257 ++++
 drivers/net/sxe/pf/sxe_irq.h              |   11 +
 drivers/net/sxe/pf/sxe_main.c             |    7 +
 drivers/net/sxe/pf/sxe_offload.c          |   37 +
 drivers/net/sxe/pf/sxe_offload.h          |   18 +
 drivers/net/sxe/pf/sxe_queue.c            |  774 +++++++++++
 drivers/net/sxe/pf/sxe_queue.h            |  132 ++
 drivers/net/sxe/pf/sxe_rx.c               | 1459 +++++++++++++++++++++
 drivers/net/sxe/pf/sxe_rx.h               |  188 +++
 drivers/net/sxe/pf/sxe_tx.c               | 1051 +++++++++++++++
 drivers/net/sxe/pf/sxe_tx.h               |   50 +
 24 files changed, 5798 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/sxe/base/sxe_offload_common.c
 create mode 100644 drivers/net/sxe/base/sxe_offload_common.h
 create mode 100644 drivers/net/sxe/base/sxe_queue_common.c
 create mode 100644 drivers/net/sxe/base/sxe_queue_common.h
 create mode 100644 drivers/net/sxe/base/sxe_rx_common.c
 create mode 100644 drivers/net/sxe/base/sxe_rx_common.h
 create mode 100644 drivers/net/sxe/base/sxe_tx_common.c
 create mode 100644 drivers/net/sxe/base/sxe_tx_common.h
 create mode 100644 drivers/net/sxe/include/sxe_type.h
 create mode 100644 drivers/net/sxe/pf/sxe_offload.c
 create mode 100644 drivers/net/sxe/pf/sxe_offload.h
 create mode 100644 drivers/net/sxe/pf/sxe_queue.c
 create mode 100644 drivers/net/sxe/pf/sxe_queue.h
 create mode 100644 drivers/net/sxe/pf/sxe_rx.c
 create mode 100644 drivers/net/sxe/pf/sxe_rx.h
 create mode 100644 drivers/net/sxe/pf/sxe_tx.c
 create mode 100644 drivers/net/sxe/pf/sxe_tx.h

diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index c7dae4ad27..a1d9949a9d 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -58,6 +58,7 @@ drivers = [
         'rnp',
         'sfc',
         'softnic',
+        'sxe',
         'tap',
         'thunderx',
         'txgbe',
diff --git a/drivers/net/sxe/base/sxe_offload_common.c b/drivers/net/sxe/base/sxe_offload_common.c
new file mode 100644
index 0000000000..f07d2b9572
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_offload_common.c
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include "sxe_types.h"
+#include "sxe_offload_common.h"
+#include "sxe_compat_version.h"
+
+u64 __sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
+{
+	RTE_SET_USED(dev);
+
+	u64 offloads = 0;
+
+	return offloads;
+}
+
+u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
+{
+	u64 rx_offload_capa;
+
+	rx_offload_capa = RTE_ETH_RX_OFFLOAD_IPV4_CKSUM  |
+			RTE_ETH_RX_OFFLOAD_UDP_CKSUM   |
+			RTE_ETH_RX_OFFLOAD_TCP_CKSUM   |
+			RTE_ETH_RX_OFFLOAD_KEEP_CRC	|
+			RTE_ETH_RX_OFFLOAD_SCATTER;
+
+	if (!RTE_ETH_DEV_SRIOV(dev).active)
+		rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TCP_LRO;
+
+	return rx_offload_capa;
+}
+
+u64 __sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
+{
+	u64 tx_offload_capa;
+	RTE_SET_USED(dev);
+
+	tx_offload_capa =
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM  |
+		RTE_ETH_TX_OFFLOAD_UDP_CKSUM   |
+		RTE_ETH_TX_OFFLOAD_TCP_CKSUM   |
+		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM  |
+		RTE_ETH_TX_OFFLOAD_TCP_TSO	 |
+		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+
+	return tx_offload_capa;
+}
diff --git a/drivers/net/sxe/base/sxe_offload_common.h b/drivers/net/sxe/base/sxe_offload_common.h
new file mode 100644
index 0000000000..cbfb7fd93f
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_offload_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_OFFLOAD_COMMON_H__
+#define __SXE_OFFLOAD_COMMON_H__
+
+u64 __sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev);
+
+u64 __sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev);
+
+u64 __sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_queue_common.c b/drivers/net/sxe/base/sxe_queue_common.c
new file mode 100644
index 0000000000..da44270019
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_queue_common.c
@@ -0,0 +1,396 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include <rte_ethdev.h>
+#include <rte_malloc.h>
+#include "sxe_compat_version.h"
+#include <ethdev_driver.h>
+#include <bus_pci_driver.h>
+
+#include "sxe_rx.h"
+#include "sxe_tx.h"
+#include "sxe_logs.h"
+#include "sxe_regs.h"
+#include "sxe.h"
+#include "sxe_queue_common.h"
+#include "sxe_queue.h"
+
+static void sxe_tx_queues_clear(struct rte_eth_dev *dev)
+{
+	u16 i;
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		struct sxe_tx_queue *txq = dev->data->tx_queues[i];
+
+		if (txq != NULL && txq->ops != NULL) {
+			txq->ops->mbufs_release(txq);
+			txq->ops->init(txq);
+		}
+	}
+}
+
+static void sxe_rx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed)
+{
+	u16 i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		struct sxe_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq != NULL) {
+			sxe_rx_queue_mbufs_free(rxq);
+			sxe_rx_queue_init(rx_batch_alloc_allowed, rxq);
+		}
+	}
+}
+
+s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf)
+{
+	struct rte_eth_dev *dev = rx_setup->dev;
+	const struct rte_eth_rxconf *rx_conf = rx_setup->rx_conf;
+	u16 queue_idx = rx_setup->queue_idx;
+	u32 socket_id = rx_setup->socket_id;
+	u16 desc_num = rx_setup->desc_num;
+	struct rte_mempool *mp = rx_setup->mp;
+	const struct rte_memzone *rx_mz;
+	struct sxe_rx_queue *rxq;
+	u16 len;
+	u64 offloads;
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	offloads = rx_conf->offloads | dev->data->dev_conf.rxmode.offloads;
+
+	if (desc_num % SXE_RX_DESC_RING_ALIGN != 0 ||
+			desc_num > SXE_MAX_RING_DESC ||
+			desc_num < SXE_MIN_RING_DESC) {
+		PMD_LOG_ERR(INIT, "desc_num %u error", desc_num);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (dev->data->rx_queues[queue_idx] != NULL) {
+		sxe_rx_queue_free(dev->data->rx_queues[queue_idx]);
+		dev->data->rx_queues[queue_idx] = NULL;
+	}
+
+	rxq = rte_zmalloc_socket("ethdev RX queue", sizeof(struct sxe_rx_queue),
+				 RTE_CACHE_LINE_SIZE, socket_id);
+	if (rxq == NULL) {
+		PMD_LOG_ERR(INIT, "rxq malloc mem failed");
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	rxq->mb_pool = mp;
+	rxq->ring_depth = desc_num;
+	rxq->batch_alloc_size = rx_conf->rx_free_thresh;
+	rxq->queue_id = queue_idx;
+	rxq->reg_idx = (u16)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
+		queue_idx : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + queue_idx);
+	rxq->port_id = dev->data->port_id;
+	if (dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+		rxq->crc_len = RTE_ETHER_CRC_LEN;
+	else
+		rxq->crc_len = 0;
+
+	rxq->drop_en = rx_conf->rx_drop_en;
+	rxq->deferred_start = rx_conf->rx_deferred_start;
+	rxq->offloads = offloads;
+
+	rxq->pkt_type_mask = SXE_PACKET_TYPE_MASK;
+
+	rx_mz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx,
+					SXE_RX_RING_SIZE, SXE_ALIGN, socket_id);
+	if (rx_mz == NULL) {
+		PMD_LOG_ERR(INIT, "rxq malloc desc mem failed");
+		sxe_rx_queue_free(rxq);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	rxq->mz = rx_mz;
+
+	memset(rx_mz->addr, 0, SXE_RX_RING_SIZE);
+
+	if (is_vf)
+		rxq->rdt_reg_addr = (volatile u32 *)(rx_setup->reg_base_addr +
+			SXE_VFRDT(rxq->reg_idx));
+	else
+		rxq->rdt_reg_addr = (volatile u32 *)(rx_setup->reg_base_addr +
+			SXE_RDT(rxq->reg_idx));
+
+	rxq->base_addr = rx_mz->iova;
+
+	rxq->desc_ring = (union sxe_rx_data_desc *)rx_mz->addr;
+
+	if (!sxe_check_is_rx_batch_alloc_support(rxq)) {
+		PMD_LOG_DEBUG(INIT, "queue[%d] doesn't support rx batch alloc "
+				"- canceling the feature for the whole port[%d]",
+				rxq->queue_id, rxq->port_id);
+		*rx_setup->rx_batch_alloc_allowed = false;
+	}
+
+	len = desc_num;
+	if (*rx_setup->rx_batch_alloc_allowed)
+		len += RTE_PMD_SXE_MAX_RX_BURST;
+
+	rxq->buffer_ring = rte_zmalloc_socket("rxq->sw_ring",
+					  sizeof(struct sxe_rx_buffer) * len,
+					  RTE_CACHE_LINE_SIZE, socket_id);
+	if (!rxq->buffer_ring) {
+		PMD_LOG_ERR(INIT, "rxq malloc buffer mem failed");
+		sxe_rx_queue_free(rxq);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	rxq->sc_buffer_ring =
+		rte_zmalloc_socket("rxq->sw_sc_ring",
+				   sizeof(struct sxe_rx_buffer) * len,
+				   RTE_CACHE_LINE_SIZE, socket_id);
+	if (!rxq->sc_buffer_ring) {
+		PMD_LOG_ERR(INIT, "rxq malloc sc buffer mem failed");
+		sxe_rx_queue_free(rxq);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	PMD_LOG_DEBUG(INIT, "buffer_ring=%p sc_buffer_ring=%p desc_ring=%p "
+				"dma_addr=0x%" SXE_PRIX64,
+			 rxq->buffer_ring, rxq->sc_buffer_ring, rxq->desc_ring,
+			 rxq->base_addr);
+	dev->data->rx_queues[queue_idx] = rxq;
+
+	sxe_rx_queue_init(*rx_setup->rx_batch_alloc_allowed, rxq);
+
+l_end:
+	return ret;
+}
+
+int __rte_cold __sxe_tx_queue_setup(struct tx_setup *tx_setup, bool is_vf)
+{
+	s32 ret;
+	struct rte_eth_dev *dev = tx_setup->dev;
+	const struct rte_eth_txconf *tx_conf = tx_setup->tx_conf;
+	u16 tx_queue_id = tx_setup->queue_idx;
+	u32 socket_id = tx_setup->socket_id;
+	u16 ring_depth = tx_setup->desc_num;
+	struct sxe_tx_queue *txq;
+	u16 rs_thresh, free_thresh;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = sxe_txq_arg_validate(dev, ring_depth, &rs_thresh,
+					&free_thresh, tx_conf);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "tx queue[%d] arg validate failed", tx_queue_id);
+		goto l_end;
+	} else {
+		PMD_LOG_INFO(INIT, "tx queue[%d] ring_depth=%d, "
+				"rs_thresh=%d, free_thresh=%d", tx_queue_id,
+				ring_depth, rs_thresh, free_thresh);
+	}
+
+	txq = sxe_tx_queue_alloc(dev, tx_queue_id, ring_depth, socket_id);
+	if (!txq) {
+		PMD_LOG_ERR(INIT, "tx queue[%d] resource alloc failed", tx_queue_id);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	txq->ops		= sxe_tx_default_ops_get();
+	txq->ring_depth		= ring_depth;
+	txq->queue_idx		= tx_queue_id;
+	txq->port_id		= dev->data->port_id;
+	txq->pthresh		= tx_conf->tx_thresh.pthresh;
+	txq->hthresh		= tx_conf->tx_thresh.hthresh;
+	txq->wthresh		= tx_conf->tx_thresh.wthresh;
+	txq->rs_thresh		= rs_thresh;
+	txq->free_thresh	= free_thresh;
+	txq->tx_deferred_start	= tx_conf->tx_deferred_start;
+	txq->reg_idx		= (u16)((RTE_ETH_DEV_SRIOV(dev).active == 0) ?
+		tx_queue_id : RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx + tx_queue_id);
+	txq->offloads		= tx_conf->offloads | dev->data->dev_conf.txmode.offloads;
+
+	if (is_vf)
+		txq->tdt_reg_addr = (volatile u32 *)(tx_setup->reg_base_addr +
+						     SXE_VFTDT(txq->reg_idx));
+	else
+		txq->tdt_reg_addr = (u32 *)(tx_setup->reg_base_addr +
+					    SXE_TDT(txq->reg_idx));
+
+	PMD_LOG_INFO(INIT, "buffer_ring=%p desc_ring=%p dma_addr=0x%" SXE_PRIX64,
+			 txq->buffer_ring, txq->desc_ring, (u64)txq->base_addr);
+	sxe_tx_function_set(dev, txq);
+
+	txq->ops->init(txq);
+
+	dev->data->tx_queues[tx_queue_id] = txq;
+
+l_end:
+	return ret;
+}
+
+void __sxe_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+					struct rte_eth_rxq_info *qinfo)
+{
+	struct sxe_rx_queue *rxq;
+
+	rxq = dev->data->rx_queues[queue_id];
+
+	qinfo->mp = rxq->mb_pool;
+	qinfo->scattered_rx = dev->data->scattered_rx;
+	qinfo->nb_desc = rxq->ring_depth;
+
+	qinfo->conf.rx_free_thresh = rxq->batch_alloc_size;
+	qinfo->conf.rx_drop_en = rxq->drop_en;
+	qinfo->conf.rx_deferred_start = rxq->deferred_start;
+	qinfo->conf.offloads = rxq->offloads;
+}
+
+void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_recycle_rxq_info *q_info)
+{
+	struct sxe_rx_queue *rxq;
+
+	rxq = dev->data->rx_queues[queue_id];
+
+	q_info->mbuf_ring = (void *)rxq->buffer_ring;
+	q_info->mp = rxq->mb_pool;
+	q_info->mbuf_ring_size = rxq->ring_depth;
+	q_info->receive_tail = &rxq->processing_idx;
+
+	q_info->refill_requirement = rxq->batch_alloc_size;
+	q_info->refill_head = &rxq->batch_alloc_trigger;
+}
+
+void __sxe_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_txq_info *q_info)
+{
+	struct sxe_tx_queue *txq;
+
+	txq = dev->data->tx_queues[queue_id];
+
+	q_info->nb_desc = txq->ring_depth;
+	q_info->conf.tx_thresh.pthresh = txq->pthresh;
+	q_info->conf.tx_thresh.hthresh = txq->hthresh;
+	q_info->conf.tx_thresh.wthresh = txq->wthresh;
+	q_info->conf.tx_free_thresh = txq->free_thresh;
+	q_info->conf.tx_rs_thresh = txq->rs_thresh;
+	q_info->conf.offloads = txq->offloads;
+	q_info->conf.tx_deferred_start = txq->tx_deferred_start;
+}
+
+s32 __sxe_tx_done_cleanup(void *tx_queue, u32 free_cnt)
+{
+	int ret;
+	struct sxe_tx_queue *txq = (struct sxe_tx_queue *)tx_queue;
+	if (txq->offloads == 0 &&
+		txq->rs_thresh >= RTE_PMD_SXE_MAX_TX_BURST) {
+		ret = sxe_tx_done_cleanup_simple(txq, free_cnt);
+
+	} else {
+		ret = sxe_tx_done_cleanup_full(txq, free_cnt);
+	}
+
+	return ret;
+}
+
+s32 __rte_cold __sxe_rx_queue_mbufs_alloc(struct sxe_rx_queue *rxq)
+{
+	struct sxe_rx_buffer *buf_ring = rxq->buffer_ring;
+	s32 ret = 0;
+	u64 dma_addr;
+	u16 i;
+
+	for (i = 0; i < rxq->ring_depth; i++) {
+		volatile union sxe_rx_data_desc *desc;
+		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+
+		if (mbuf == NULL) {
+			PMD_LOG_ERR(DRV, "rx mbuf alloc failed queue_id=%u",
+					(u16)rxq->queue_id);
+			ret = -ENOMEM;
+			goto l_end;
+		}
+
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+		mbuf->port = rxq->port_id;
+
+		dma_addr =
+			rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		desc = &rxq->desc_ring[i];
+		desc->read.hdr_addr = 0;
+		desc->read.pkt_addr = dma_addr;
+		buf_ring[i].mbuf = mbuf;
+	}
+
+l_end:
+	return ret;
+}
+
+void __rte_cold __sxe_rx_queue_free(struct sxe_rx_queue *rxq)
+{
+	if (rxq != NULL) {
+		sxe_rx_queue_mbufs_free(rxq);
+		rte_free(rxq->buffer_ring);
+		rte_free(rxq->sc_buffer_ring);
+		rte_memzone_free(rxq->mz);
+		rte_free(rxq);
+	}
+}
+
+void __rte_cold __sxe_tx_queue_free(struct sxe_tx_queue *txq)
+{
+	if (txq != NULL && txq->ops != NULL) {
+		txq->ops->mbufs_release(txq);
+		txq->ops->buffer_ring_free(txq);
+		rte_memzone_free(txq->mz);
+		rte_free(txq);
+	}
+}
+
+void __rte_cold __sxe_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_tx_queues_clear(dev);
+
+	sxe_rx_queues_clear(dev, rx_batch_alloc_allowed);
+}
+
+void __sxe_queues_free(struct rte_eth_dev *dev)
+{
+	unsigned int i;
+
+	PMD_INIT_FUNC_TRACE();
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		__sxe_rx_queue_free(dev->data->rx_queues[i]);
+		dev->data->rx_queues[i] = NULL;
+	}
+	dev->data->nb_rx_queues = 0;
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		__sxe_tx_queue_free(dev->data->tx_queues[i]);
+		dev->data->tx_queues[i] = NULL;
+	}
+	dev->data->nb_tx_queues = 0;
+}
+
+void __sxe_secondary_proc_init(struct rte_eth_dev *eth_dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed)
+{
+	struct sxe_tx_queue *txq;
+	if (eth_dev->data->tx_queues) {
+		txq = eth_dev->data->tx_queues[eth_dev->data->nb_tx_queues - 1];
+		sxe_tx_function_set(eth_dev, txq);
+	} else {
+		PMD_LOG_NOTICE(INIT, "No TX queues configured yet. "
+				 "Using default TX function.");
+	}
+
+	sxe_rx_function_set(eth_dev, rx_batch_alloc_allowed, rx_vec_allowed);
+}
diff --git a/drivers/net/sxe/base/sxe_queue_common.h b/drivers/net/sxe/base/sxe_queue_common.h
new file mode 100644
index 0000000000..95be599216
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_queue_common.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_QUEUE_COMMON_H__
+#define __SXE_QUEUE_COMMON_H__
+
+#include "sxe_types.h"
+#include "sxe_compat_platform.h"
+#include "sxe_compat_version.h"
+#ifdef SXE_HOST_DRIVER
+#include "sxe_drv_type.h"
+#endif
+
+#define RTE_PMD_SXE_MAX_RX_BURST 32
+
+enum sxe_ctxt_num {
+	SXE_CTXT_DESC_0	= 0,
+	SXE_CTXT_DESC_1	= 1,
+	SXE_CTXT_DESC_NUM  = 2,
+};
+
+struct rx_setup {
+	struct rte_eth_dev *dev;
+	u16 queue_idx;
+	u16 desc_num;
+	u32 socket_id;
+	const struct rte_eth_rxconf *rx_conf;
+	struct rte_mempool *mp;
+	u8 __iomem *reg_base_addr;
+	bool *rx_batch_alloc_allowed;
+};
+
+struct tx_setup {
+	struct rte_eth_dev *dev;
+	u16 queue_idx;
+	u16 desc_num;
+	u32 socket_id;
+	const struct rte_eth_txconf *tx_conf;
+	u8 __iomem *reg_base_addr;
+};
+
+union sxe_tx_data_desc {
+	struct {
+		__le64 buffer_addr;
+		__le32 cmd_type_len;
+		__le32 olinfo_status;
+	} read;
+	struct {
+		__le64 rsvd;
+		__le32 nxtseq_seed;
+		__le32 status;
+	} wb;
+};
+
+struct sxe_rx_buffer {
+	struct rte_mbuf *mbuf;
+};
+
+struct sxe_rx_queue_stats {
+	u64 csum_err;
+};
+
+union sxe_rx_data_desc {
+	struct {
+		__le64 pkt_addr;
+		__le64 hdr_addr;
+	} read;
+	struct {
+		struct {
+			union {
+				__le32 data;
+				struct {
+					__le16 pkt_info;
+					__le16 hdr_info;
+				} hs_rss;
+			} lo_dword;
+			union {
+				__le32 rss;
+				struct {
+					__le16 ip_id;
+					__le16 csum;
+				} csum_ip;
+			} hi_dword;
+		} lower;
+		struct {
+			__le32 status_error;
+			__le16 length;
+			__le16 vlan;
+		} upper;
+	} wb;
+};
+
+struct sxe_tx_buffer {
+	struct rte_mbuf *mbuf;
+	u16 next_id;
+	u16 last_id;
+};
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+struct sxe_tx_buffer_vec {
+	struct rte_mbuf *mbuf;
+};
+#endif
+
+union sxe_tx_offload {
+	u64 data[2];
+	struct {
+		u64 l2_len:7;
+		u64 l3_len:9;
+		u64 l4_len:8;
+		u64 tso_segsz:16;
+		u64 vlan_tci:16;
+
+		u64 outer_l3_len:8;
+		u64 outer_l2_len:8;
+	};
+};
+
+struct sxe_ctxt_info {
+	u64 flags;
+	union sxe_tx_offload tx_offload;
+	union sxe_tx_offload tx_offload_mask;
+};
+
+struct sxe_tx_queue {
+	volatile union sxe_tx_data_desc *desc_ring;
+	u64			 base_addr;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	union {
+		struct sxe_tx_buffer *buffer_ring;
+		struct sxe_tx_buffer_vec *buffer_ring_vec;
+	};
+#else
+	struct sxe_tx_buffer *buffer_ring;
+#endif
+	volatile u32   *tdt_reg_addr;
+	u16			ring_depth;
+	u16			next_to_use;
+	u16			free_thresh;
+
+	u16			rs_thresh;
+
+	u16			desc_used_num;
+	u16			next_to_clean;
+	u16			desc_free_num;
+	u16			next_dd;
+	u16			next_rs;
+	u16			queue_idx;
+	u16			reg_idx;
+	u16			port_id;
+	u8			 pthresh;
+	u8			 hthresh;
+
+	u8			 wthresh;
+	u64			offloads;
+	u32			ctx_curr;
+	struct sxe_ctxt_info ctx_cache[SXE_CTXT_DESC_NUM];
+	const struct sxe_txq_ops *ops;
+	u8	 tx_deferred_start;
+	const struct rte_memzone *mz;
+};
+
+struct sxe_rx_queue {
+	struct rte_mempool  *mb_pool;
+	volatile union sxe_rx_data_desc *desc_ring;
+	u64  base_addr;
+	volatile u32   *rdt_reg_addr;
+	struct sxe_rx_buffer *buffer_ring;
+	struct sxe_rx_buffer *sc_buffer_ring;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	struct rte_mbuf *pkt_first_seg;
+	struct rte_mbuf *pkt_last_seg;
+	u64	mbuf_init_value;
+	u8	 is_using_sse;
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+	u16	realloc_num;
+	u16	realloc_start;
+#endif
+#endif
+	u16	ring_depth;
+	u16	processing_idx;
+	u16	hold_num;
+	u16	completed_pkts_num;
+	u16	next_ret_pkg;
+	u16	batch_alloc_trigger;
+
+	u16	batch_alloc_size;
+	u16	queue_id;
+	u16	reg_idx;
+	u16	pkt_type_mask;
+	u16	port_id;
+	u8	 crc_len;
+	u8	 drop_en;
+	u8	 deferred_start;
+	u64	vlan_flags;
+	u64	offloads;
+	struct rte_mbuf fake_mbuf;
+	struct rte_mbuf *completed_ring[RTE_PMD_SXE_MAX_RX_BURST * 2];
+	const struct rte_memzone *mz;
+	struct sxe_rx_queue_stats rx_stats;
+};
+
+struct sxe_txq_ops {
+	void (*init)(struct sxe_tx_queue *txq);
+	void (*mbufs_release)(struct sxe_tx_queue *txq);
+	void (*buffer_ring_free)(struct sxe_tx_queue *txq);
+};
+
+s32 __rte_cold __sxe_rx_queue_setup(struct rx_setup *rx_setup, bool is_vf);
+
+int __rte_cold __sxe_tx_queue_setup(struct tx_setup *tx_setup, bool is_vf);
+
+void __sxe_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+					struct rte_eth_rxq_info *qinfo);
+
+void __sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_recycle_rxq_info *q_info);
+
+void __sxe_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_txq_info *q_info);
+
+s32 __sxe_tx_done_cleanup(void *tx_queue, u32 free_cnt);
+
+s32 __rte_cold __sxe_rx_queue_mbufs_alloc(struct sxe_rx_queue *rxq);
+
+void __rte_cold __sxe_tx_queue_free(struct sxe_tx_queue *txq);
+
+void sxe_rx_queue_free(struct sxe_rx_queue *rxq);
+
+void __rte_cold __sxe_rx_queue_free(struct sxe_rx_queue *rxq);
+
+void __rte_cold __sxe_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed);
+
+void __sxe_queues_free(struct rte_eth_dev *dev);
+
+void __sxe_secondary_proc_init(struct rte_eth_dev *eth_dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed);
+
+#endif
diff --git a/drivers/net/sxe/base/sxe_rx_common.c b/drivers/net/sxe/base/sxe_rx_common.c
new file mode 100644
index 0000000000..ae97b719e7
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_rx_common.c
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include <rte_memory.h>
+#include <rte_memzone.h>
+#include <rte_mbuf.h>
+#include <ethdev_driver.h>
+#include <rte_prefetch.h>
+#include <rte_malloc.h>
+
+#include "sxe.h"
+#include "sxe_rx.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe_queue_common.h"
+#include "sxe_vf.h"
+#include "sxe_errno.h"
+#include "sxe_irq.h"
+#include "sxe_rx_common.h"
+
+static inline void sxe_rx_resource_prefetch(u16 next_idx,
+				struct sxe_rx_buffer *buf_ring,
+				volatile union sxe_rx_data_desc *desc_ring)
+{
+	rte_sxe_prefetch(buf_ring[next_idx].mbuf);
+
+	if ((next_idx & 0x3) == 0) {
+		rte_sxe_prefetch(&desc_ring[next_idx]);
+		rte_sxe_prefetch(&buf_ring[next_idx]);
+	}
+}
+
+void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed)
+{
+	UNUSED(rx_vec_allowed);
+
+	if (dev->data->lro) {
+		if (rx_batch_alloc_allowed) {
+			PMD_LOG_DEBUG(INIT, "LRO is requested. Using a bulk "
+					   "allocation version");
+			dev->rx_pkt_burst = sxe_batch_alloc_lro_pkts_recv;
+		} else {
+			PMD_LOG_DEBUG(INIT, "LRO is requested. Using a single "
+					   "allocation version");
+			dev->rx_pkt_burst = sxe_single_alloc_lro_pkts_recv;
+		}
+	} else if (dev->data->scattered_rx) {
+		if (rx_batch_alloc_allowed) {
+			PMD_LOG_DEBUG(INIT, "Using a Scattered with bulk "
+					   "allocation callback (port=%d).",
+					 dev->data->port_id);
+
+			dev->rx_pkt_burst = sxe_batch_alloc_lro_pkts_recv;
+		} else {
+			PMD_LOG_DEBUG(INIT, "Using Regular (non-vector, "
+						"single allocation) "
+						"Scattered Rx callback "
+						"(port=%d).",
+					 dev->data->port_id);
+
+			dev->rx_pkt_burst = sxe_single_alloc_lro_pkts_recv;
+		}
+	} else if (rx_batch_alloc_allowed) {
+		PMD_LOG_DEBUG(INIT, "Rx Burst Bulk Alloc Preconditions are "
+					"satisfied. Rx Burst Bulk Alloc function "
+					"will be used on port=%d.",
+				dev->data->port_id);
+
+		dev->rx_pkt_burst = sxe_batch_alloc_pkts_recv;
+	} else {
+		PMD_LOG_DEBUG(INIT, "Rx Burst Bulk Alloc Preconditions are not "
+				"satisfied, or Scattered Rx is requested "
+				"(port=%d).",
+				dev->data->port_id);
+
+		dev->rx_pkt_burst = sxe_pkts_recv;
+	}
+}
+
+s32 __sxe_rx_descriptor_status(void *rx_queue, u16 offset)
+{
+	int ret = RTE_ETH_RX_DESC_AVAIL;
+	struct sxe_rx_queue *rxq = rx_queue;
+	volatile u32 *status;
+	u32 hold_num, desc;
+
+	if (unlikely(offset >= rxq->ring_depth)) {
+		LOG_DEBUG("rx queue[%u] get desc status err,"
+			"offset=%u >= ring_depth=%u",
+			rxq->queue_id, offset, rxq->ring_depth);
+		ret = -EINVAL;
+		goto l_end;
+	}
+	hold_num = rxq->hold_num;
+	if (offset >= rxq->ring_depth - hold_num) {
+		ret = RTE_ETH_RX_DESC_UNAVAIL;
+		goto l_end;
+	}
+
+	desc = rxq->processing_idx + offset;
+	if (desc >= rxq->ring_depth)
+		desc -= rxq->ring_depth;
+
+	status = &rxq->desc_ring[desc].wb.upper.status_error;
+	if (*status & rte_cpu_to_le_32(SXE_RXDADV_STAT_DD))
+		ret =  RTE_ETH_RX_DESC_DONE;
+
+l_end:
+	LOG_DEBUG("rx queue[%u] get desc status=%d", rxq->queue_id, ret);
+	return ret;
+}
+
+u16 __sxe_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+		u16 pkts_num)
+{
+	struct sxe_rx_queue *rxq = (struct sxe_rx_queue *)rx_queue;
+	volatile union sxe_rx_data_desc *desc_ring = rxq->desc_ring;
+	volatile union sxe_rx_data_desc *cur_desc;
+	struct sxe_rx_buffer *buff_ring = rxq->buffer_ring;
+	struct sxe_rx_buffer *cur_buf;
+	struct rte_mbuf *cur_mb;
+	struct rte_mbuf *new_mb;
+	union sxe_rx_data_desc rxd;
+	u16 processing_idx = rxq->processing_idx;
+	u64 dma_addr;
+	u32 staterr;
+	u32 pkt_info;
+	u16 done_num = 0;
+	u16 hold_num = 0;
+	u16 pkt_len;
+
+	while (done_num < pkts_num) {
+		cur_desc = &desc_ring[processing_idx];
+		staterr = cur_desc->wb.upper.status_error;
+		if (!(staterr & rte_cpu_to_le_32(SXE_RXDADV_STAT_DD)))
+			break;
+
+		rxd = *cur_desc;
+
+		LOG_DEBUG("port_id=%u queue_id=%u processing_idx=%u "
+			   "staterr=0x%08x pkt_len=%u",
+			   (unsigned int)rxq->port_id, (unsigned int)rxq->queue_id,
+			   (unsigned int)processing_idx, (unsigned int)staterr,
+			   (unsigned int)rte_le_to_cpu_16(rxd.wb.upper.length));
+
+		new_mb = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (new_mb == NULL) {
+			LOG_ERROR("RX mbuf alloc failed port_id=%u "
+				   "queue_id=%u", (unsigned int)rxq->port_id,
+				   (unsigned int)rxq->queue_id);
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+			break;
+		}
+
+		hold_num++;
+		cur_buf = &buff_ring[processing_idx];
+		processing_idx++;
+		if (processing_idx == rxq->ring_depth)
+			processing_idx = 0;
+
+		sxe_rx_resource_prefetch(processing_idx, buff_ring, desc_ring);
+
+		cur_mb = cur_buf->mbuf;
+		cur_buf->mbuf = new_mb;
+		dma_addr =
+			rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
+		cur_desc->read.hdr_addr = 0;
+		cur_desc->read.pkt_addr = dma_addr;
+
+		cur_mb->data_off = RTE_PKTMBUF_HEADROOM;
+		rte_packet_prefetch((char *)cur_mb->buf_addr + cur_mb->data_off);
+		cur_mb->nb_segs = 1;
+		cur_mb->next = NULL;
+		pkt_len = (u16)(rte_le_to_cpu_16(rxd.wb.upper.length) -
+						rxq->crc_len);
+		cur_mb->pkt_len = pkt_len;
+		cur_mb->data_len = pkt_len;
+
+		pkt_info = rte_le_to_cpu_32(rxd.wb.lower.lo_dword.data);
+
+		sxe_rx_mbuf_common_header_fill(rxq, cur_mb, rxd, pkt_info, staterr);
+
+		rx_pkts[done_num++] = cur_mb;
+	}
+
+	rxq->processing_idx = processing_idx;
+
+	hold_num = (u16)(hold_num + rxq->hold_num);
+	if (hold_num > rxq->batch_alloc_size) {
+		LOG_DEBUG("port_id=%u queue_id=%u rx_tail=%u "
+			   "num_hold=%u num_done=%u",
+			   (unsigned int)rxq->port_id, (unsigned int)rxq->queue_id,
+			   (unsigned int)processing_idx, (unsigned int)hold_num,
+			   (unsigned int)done_num);
+		processing_idx = (u16)((processing_idx == 0) ?
+				(rxq->ring_depth - 1) : (processing_idx - 1));
+		SXE_PCI_REG_WC_WRITE(rxq->rdt_reg_addr, processing_idx);
+		hold_num = 0;
+	}
+
+	rxq->hold_num = hold_num;
+	return done_num;
+}
+
+const u32 *__sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
+{
+	const u32 *ptypes = NULL;
+	static const u32 ptypes_arr[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L3_IPV4,
+		RTE_PTYPE_L3_IPV4_EXT,
+		RTE_PTYPE_L3_IPV6,
+		RTE_PTYPE_L3_IPV6_EXT,
+		RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_TUNNEL_IP,
+		RTE_PTYPE_INNER_L3_IPV6,
+		RTE_PTYPE_INNER_L3_IPV6_EXT,
+		RTE_PTYPE_INNER_L4_TCP,
+		RTE_PTYPE_INNER_L4_UDP,
+		RTE_PTYPE_UNKNOWN
+	};
+
+	if (dev->rx_pkt_burst == sxe_pkts_recv ||
+		dev->rx_pkt_burst == sxe_batch_alloc_pkts_recv ||
+		dev->rx_pkt_burst == sxe_single_alloc_lro_pkts_recv ||
+		dev->rx_pkt_burst == sxe_batch_alloc_lro_pkts_recv) {
+		*no_of_elements = RTE_DIM(ptypes_arr);
+		ptypes = ptypes_arr;
+		goto l_end;
+	}
+
+l_end:
+	return ptypes;
+}
diff --git a/drivers/net/sxe/base/sxe_rx_common.h b/drivers/net/sxe/base/sxe_rx_common.h
new file mode 100644
index 0000000000..d1bf172c89
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_rx_common.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_RX_COMMON_H__
+#define __SXE_RX_COMMON_H__
+
+void __rte_cold __sxe_rx_function_set(struct rte_eth_dev *dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed);
+
+s32 __sxe_rx_descriptor_status(void *rx_queue, u16 offset);
+
+u16 __sxe_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+		u16 pkts_num);
+
+const u32 *__sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements);
+#endif
diff --git a/drivers/net/sxe/base/sxe_tx_common.c b/drivers/net/sxe/base/sxe_tx_common.c
new file mode 100644
index 0000000000..5f8a951bbd
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_tx_common.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include <ethdev_pci.h>
+#include <rte_net.h>
+
+#include "sxe_hw.h"
+#include "sxe_logs.h"
+#include "sxe_queue_common.h"
+#include "sxe_tx_common.h"
+
+int __sxe_tx_descriptor_status(void *tx_queue, u16 offset)
+{
+	int ret = RTE_ETH_TX_DESC_FULL;
+	u32 desc_idx;
+	struct sxe_tx_queue *txq = tx_queue;
+	volatile u32 *status;
+
+	if (unlikely(offset >= txq->ring_depth)) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	desc_idx = txq->next_to_use + offset;
+
+	desc_idx = ((desc_idx + txq->rs_thresh - 1) / txq->rs_thresh) * txq->rs_thresh;
+	if (desc_idx >= txq->ring_depth) {
+		desc_idx -= txq->ring_depth;
+		if (desc_idx >= txq->ring_depth)
+			desc_idx -= txq->ring_depth;
+	}
+
+	status = &txq->desc_ring[desc_idx].wb.status;
+	if (*status & rte_cpu_to_le_32(SXE_TX_DESC_STAT_DD))
+		ret = RTE_ETH_TX_DESC_DONE;
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe/base/sxe_tx_common.h b/drivers/net/sxe/base/sxe_tx_common.h
new file mode 100644
index 0000000000..2759ef5a7a
--- /dev/null
+++ b/drivers/net/sxe/base/sxe_tx_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_TX_COMMON_H__
+#define __SXE_TX_COMMON_H__
+
+int __sxe_tx_descriptor_status(void *tx_queue, u16 offset);
+
+u16 __sxe_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num);
+
+#endif
diff --git a/drivers/net/sxe/include/sxe_type.h b/drivers/net/sxe/include/sxe_type.h
new file mode 100644
index 0000000000..dafd31465d
--- /dev/null
+++ b/drivers/net/sxe/include/sxe_type.h
@@ -0,0 +1,795 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_TYPE_H__
+#define __SXE_TYPE_H__
+
+#define SXE_TXD_CMD_EOP   0x01000000
+#define SXE_TXD_CMD_RS	0x08000000
+#define SXE_TXD_STAT_DD   0x00000001
+
+#define SXE_TXD_CMD	   (SXE_TXD_CMD_EOP | SXE_TXD_CMD_RS)
+
+
+typedef union sxe_adv_tx_desc {
+	struct {
+		U64 buffer_addr;
+		U32 cmd_type_len;
+		U32 olinfo_status;
+	} read;
+	struct {
+		U64 rsvd;
+		U32 nxtseq_seed;
+		U32 status;
+	} wb;
+} sxe_adv_tx_desc_u;
+
+typedef union sxe_adv_rx_desc {
+	struct {
+		U64 pkt_addr;
+		U64 hdr_addr;
+	} read;
+	struct {
+		struct {
+			union {
+				U32 data;
+				struct {
+					U16 pkt_info;
+					U16 hdr_info;
+				} hs_rss;
+			} lo_dword;
+			union {
+				U32 rss;
+				struct {
+					U16 ip_id;
+					U16 csum;
+				} csum_ip;
+			} hi_dword;
+		} lower;
+		struct {
+			U32 status_error;
+			U16 length;
+			U16 vlan;
+		} upper;
+	} wb;
+} sxe_adv_rx_desc_u;
+
+#define SXE_RXD_STAT_DD	0x01
+#define SXE_RXD_STAT_EOP   0x02
+
+
+#define PCI_VENDOR_ID_STARS		 0x1FF2
+#define SXE_DEV_ID_FPGA			 0x1160
+
+
+#define SXE_CTRL	  0x00000
+#define SXE_STATUS	0x00008
+#define SXE_CTRL_EXT  0x00018
+#define SXE_ESDP	  0x00020
+#define SXE_EODSDP	0x00028
+
+#define SXE_I2CCTL_8259X	0x00028
+#define SXE_I2CCTL_X540	SXE_I2CCTL_8259X
+#define SXE_I2CCTL_X550	0x15F5C
+#define SXE_I2CCTL_X550EM_x	SXE_I2CCTL_X550
+#define SXE_I2CCTL_X550EM_a	SXE_I2CCTL_X550
+#define SXE_I2CCTL(_hw)	SXE_BY_MAC((_hw), I2CCTL)
+
+#define SXE_LEDCTL	0x00200
+#define SXE_FRTIMER   0x00048
+#define SXE_TCPTIMER  0x0004C
+#define SXE_CORESPARE 0x00600
+#define SXE_EXVET	 0x05078
+
+
+#define SXE_EICR	  0x00800
+#define SXE_EICS	  0x00808
+#define SXE_EIMS	  0x00880
+#define SXE_EIMC	  0x00888
+#define SXE_EIAC	  0x00810
+#define SXE_EIAM	  0x00890
+#define SXE_EICR_EX(_i)   (0x00A80 + (_i) * 4)
+#define SXE_EICS_EX(_i)   (0x00A90 + (_i) * 4)
+#define SXE_EIMS_EX(_i)   (0x00AA0 + (_i) * 4)
+#define SXE_EIMC_EX(_i)   (0x00AB0 + (_i) * 4)
+#define SXE_EIAM_EX(_i)   (0x00AD0 + (_i) * 4)
+
+
+#define SXE_RDBAL(_i) (((_i) < 64) ? (0x01000 + ((_i) * 0x40)) : \
+			 (0x0D000 + (((_i) - 64) * 0x40)))
+#define SXE_RDBAH(_i) (((_i) < 64) ? (0x01004 + ((_i) * 0x40)) : \
+			 (0x0D004 + (((_i) - 64) * 0x40)))
+#define SXE_RDLEN(_i) (((_i) < 64) ? (0x01008 + ((_i) * 0x40)) : \
+			 (0x0D008 + (((_i) - 64) * 0x40)))
+#define SXE_RDH(_i)   (((_i) < 64) ? (0x01010 + ((_i) * 0x40)) : \
+			 (0x0D010 + (((_i) - 64) * 0x40)))
+#define SXE_RDT(_i)   (((_i) < 64) ? (0x01018 + ((_i) * 0x40)) : \
+			 (0x0D018 + (((_i) - 64) * 0x40)))
+#define SXE_RXDCTL(_i) (((_i) < 64) ? (0x01028 + ((_i) * 0x40)) : \
+			 (0x0D028 + (((_i) - 64) * 0x40)))
+#define SXE_RSCCTL(_i) (((_i) < 64) ? (0x0102C + ((_i) * 0x40)) : \
+			 (0x0D02C + (((_i) - 64) * 0x40)))
+#define SXE_RSCDBU	 0x03028
+#define SXE_RDDCC	  0x02F20
+#define SXE_RXMEMWRAP  0x03190
+#define SXE_STARCTRL   0x03024
+
+#define SXE_SRRCTL(_i) (((_i) < 64) ? (0x01014 + ((_i) * 0x40)) : (0x0D014 + (((_i) - 64) * 0x40)))
+
+#define SXE_DCA_RXCTRL(_i)	(((_i) < 64) ? \
+		(0x0100C + ((_i) * 0x40)) : \
+		(0x0D00C + (((_i) - 64) * 0x40)))
+#define SXE_RDRXCTL		   0x02F00
+#define SXE_RXPBSIZE(_i)	  (0x03C00 + ((_i) * 4))
+#define SXE_DRXCFG	0x03C20
+#define SXE_RXCTRL	0x03000
+#define SXE_DROPEN	0x03D04
+#define SXE_RXPBSIZE_SHIFT 10
+#define SXE_DRXCFG_GSP_ZERO	0x00000002
+#define SXE_DRXCFG_DBURX_START 0x00000001
+
+
+#define SXE_RXCSUM	0x05000
+#define SXE_RFCTL	 0x05008
+#define SXE_DRECCCTL  0x02F08
+#define SXE_DRECCCTL_DISABLE 0
+
+
+#define SXE_MTA(_i)   (0x05200 + ((_i) * 4))
+#define SXE_RAL(_i)   (0x0A200 + ((_i) * 8))
+#define SXE_RAH(_i)   (0x0A204 + ((_i) * 8))
+#define SXE_MPSAR_LO(_i) (0x0A600 + ((_i) * 8))
+#define SXE_MPSAR_HI(_i) (0x0A604 + ((_i) * 8))
+
+
+#define SXE_PSRTYPE(_i)	(0x0EA00 + ((_i) * 4))
+
+
+#define SXE_VFTA(_i)  (0x0A000 + ((_i) * 4))
+
+
+#define SXE_VFTAVIND(_j, _i)  (0x0A200 + ((_j) * 0x200) + ((_i) * 4))
+#define SXE_FCTRL	 0x05080
+#define SXE_VLNCTRL   0x05088
+#define SXE_MCSTCTRL  0x05090
+#define SXE_MRQC	  0x0EC80
+#define SXE_SAQF(_i)  (0x0E000 + ((_i) * 4))
+#define SXE_DAQF(_i)  (0x0E200 + ((_i) * 4))
+#define SXE_SDPQF(_i) (0x0E400 + ((_i) * 4))
+#define SXE_FTQF(_i)  (0x0E600 + ((_i) * 4))
+#define SXE_ETQF(_i)  (0x05128 + ((_i) * 4))
+#define SXE_ETQS(_i)  (0x0EC00 + ((_i) * 4))
+#define SXE_SYNQF	 0x0EC30
+#define SXE_RQTC	  0x0EC70
+#define SXE_MTQC	  0x08120
+#define SXE_VLVF(_i)  (0x0F100 + ((_i) * 4))
+#define SXE_VLVFB(_i) (0x0F200 + ((_i) * 4))
+#define SXE_VMVIR(_i) (0x08000 + ((_i) * 4))
+#define SXE_PFFLPL	 0x050B0
+#define SXE_PFFLPH	 0x050B4
+#define SXE_VT_CTL		 0x051B0
+#define SXE_PFMAILBOX(_i)  (0x04B00 + (4 * (_i)))
+#define SXE_PFMBMEM(_i)	(0x13000 + (64 * (_i)))
+#define SXE_PFMBICR(_i)	(0x00710 + (4 * (_i)))
+#define SXE_PFMBIMR(_i)	(0x00720 + (4 * (_i)))
+#define SXE_VFRE(_i)	   (0x051E0 + ((_i) * 4))
+#define SXE_VFTE(_i)	   (0x08110 + ((_i) * 4))
+#define SXE_VMECM(_i)	  (0x08790 + ((_i) * 4))
+#define SXE_QDE			0x2F04
+#define SXE_VMTXSW(_i)	 (0x05180 + ((_i) * 4))
+#define SXE_VMOLR(_i)	  (0x0F000 + ((_i) * 4))
+#define SXE_UTA(_i)		(0x0F400 + ((_i) * 4))
+#define SXE_MRCTL(_i)	  (0x0F600 + ((_i) * 4))
+#define SXE_VMRVLAN(_i)	(0x0F610 + ((_i) * 4))
+#define SXE_VMRVM(_i)	  (0x0F630 + ((_i) * 4))
+#define SXE_WQBR_RX(_i)	(0x2FB0 + ((_i) * 4))
+#define SXE_WQBR_TX(_i)	(0x8130 + ((_i) * 4))
+#define SXE_L34T_IMIR(_i)  (0x0E800 + ((_i) * 4))
+#define SXE_RXFECCERR0		 0x051B8
+#define SXE_LLITHRESH 0x0EC90
+#define SXE_IMIR(_i)  (0x05A80 + ((_i) * 4))
+#define SXE_IMIREXT(_i)	   (0x05AA0 + ((_i) * 4))
+#define SXE_IMIRVP	0x0EC60
+#define SXE_VMD_CTL   0x0581C
+#define SXE_RETA(_i)  (0x0EB00 + ((_i) * 4))
+#define SXE_ERETA(_i)	(0x0EE80 + ((_i) * 4))
+#define SXE_RSSRK(_i) (0x0EB80 + ((_i) * 4))
+
+
+#define SXE_TDBAL(_i) (0x06000 + ((_i) * 0x40))
+#define SXE_TDBAH(_i) (0x06004 + ((_i) * 0x40))
+#define SXE_TDLEN(_i) (0x06008 + ((_i) * 0x40))
+#define SXE_TDH(_i)   (0x06010 + ((_i) * 0x40))
+#define SXE_TDT(_i)   (0x06018 + ((_i) * 0x40))
+#define SXE_TXDCTL(_i) (0x06028 + ((_i) * 0x40))
+#define SXE_TDWBAL(_i) (0x06038 + ((_i) * 0x40))
+#define SXE_TDWBAH(_i) (0x0603C + ((_i) * 0x40))
+#define SXE_DTXCTL	0x07E00
+
+#define SXE_DMATXCTL	  0x04A80
+#define SXE_PFVFSPOOF(_i) (0x08200 + ((_i) * 4))
+#define SXE_PFDTXGSWC	 0x08220
+#define SXE_DTXMXSZRQ	 0x08100
+#define SXE_DTXTCPFLGL	0x04A88
+#define SXE_DTXTCPFLGH	0x04A8C
+#define SXE_LBDRPEN	   0x0CA00
+#define SXE_TXPBTHRESH(_i) (0x04950 + ((_i) * 4))
+
+#define SXE_DMATXCTL_TE	   0x1
+#define SXE_DMATXCTL_NS	   0x2
+#define SXE_DMATXCTL_GDV	  0x8
+#define SXE_DMATXCTL_MDP_EN   0x20
+#define SXE_DMATXCTL_MBINTEN  0x40
+#define SXE_DMATXCTL_VT_SHIFT 16
+
+#define SXE_PFDTXGSWC_VT_LBEN 0x1
+
+
+#define SXE_DCA_TXCTRL_82599(_i)  (0x0600C + ((_i) * 0x40))
+#define SXE_TIPG	  0x0CB00
+#define SXE_TXPBSIZE(_i)	  (0x0CC00 + ((_i) * 4))
+#define SXE_DTXCFG	0x0CE08
+#define SXE_MNGTXMAP  0x0CD10
+#define SXE_TIPG_FIBER_DEFAULT 3
+#define SXE_TXPBSIZE_SHIFT	10
+#define SXE_DTXCFG_DBUTX_START  0x00000001
+
+
+#define SXE_RTRPCS	  0x02430
+#define SXE_RTTDCS	  0x04900
+#define SXE_RTTDCS_ARBDIS	 0x00000040
+#define SXE_RTTPCS	  0x0CD00
+#define SXE_RTRUP2TC	0x03020
+#define SXE_RTTUP2TC	0x0C800
+#define SXE_RTRPT4C(_i) (0x02140 + ((_i) * 4))
+#define SXE_TXLLQ(_i)   (0x082E0 + ((_i) * 4))
+#define SXE_RTRPT4S(_i) (0x02160 + ((_i) * 4))
+#define SXE_RTTDT2C(_i) (0x04910 + ((_i) * 4))
+#define SXE_RTTDT2S(_i) (0x04930 + ((_i) * 4))
+#define SXE_RTTPT2C(_i) (0x0CD20 + ((_i) * 4))
+#define SXE_RTTPT2S(_i) (0x0CD40 + ((_i) * 4))
+#define SXE_RTTDQSEL	0x04904
+#define SXE_RTTDT1C	 0x04908
+#define SXE_RTTDT1S	 0x0490C
+
+
+#define SXE_RTTQCNCR				0x08B00
+#define SXE_RTTQCNTG				0x04A90
+#define SXE_RTTBCNRD				0x0498C
+#define SXE_RTTQCNRR				0x0498C
+#define SXE_RTTDTECC				0x04990
+#define SXE_RTTDTECC_NO_BCN		 0x00000100
+#define SXE_RTTBCNRC				0x04984
+#define SXE_RTTBCNRC_RS_ENA		 0x80000000
+#define SXE_RTTBCNRC_RF_DEC_MASK	0x00003FFF
+#define SXE_RTTBCNRC_RF_INT_SHIFT   14
+#define SXE_RTTBCNRC_RF_INT_MASK	(SXE_RTTBCNRC_RF_DEC_MASK << SXE_RTTBCNRC_RF_INT_SHIFT)
+#define SXE_RTTBCNRM				0x04980
+#define SXE_RTTQCNRM				0x04980
+
+
+#define SXE_MACCFG	  0x0CE04
+
+
+#define SXE_GCR_EXT		   0x11050
+#define SXE_GSCL_5_82599	  0x11030
+#define SXE_GSCL_6_82599	  0x11034
+#define SXE_GSCL_7_82599	  0x11038
+#define SXE_GSCL_8_82599	  0x1103C
+#define SXE_PHYADR_82599	  0x11040
+#define SXE_PHYDAT_82599	  0x11044
+#define SXE_PHYCTL_82599	  0x11048
+#define SXE_PBACLR_82599	  0x11068
+
+#define SXE_CIAA_8259X	0x11088
+
+
+#define SXE_CIAD_8259X	0x1108C
+
+
+#define SXE_PICAUSE		   0x110B0
+#define SXE_PIENA			 0x110B8
+#define SXE_CDQ_MBR_82599	 0x110B4
+#define SXE_PCIESPARE		 0x110BC
+#define SXE_MISC_REG_82599	0x110F0
+#define SXE_ECC_CTRL_0_82599  0x11100
+#define SXE_ECC_CTRL_1_82599  0x11104
+#define SXE_ECC_STATUS_82599  0x110E0
+#define SXE_BAR_CTRL_82599	0x110F4
+
+
+#define SXE_GCR_CMPL_TMOUT_MASK	   0x0000F000
+#define SXE_GCR_CMPL_TMOUT_10ms	   0x00001000
+#define SXE_GCR_CMPL_TMOUT_RESEND	 0x00010000
+#define SXE_GCR_CAP_VER2			  0x00040000
+
+#define SXE_GCR_EXT_MSIX_EN		   0x80000000
+#define SXE_GCR_EXT_BUFFERS_CLEAR	 0x40000000
+#define SXE_GCR_EXT_VT_MODE_16		0x00000001
+#define SXE_GCR_EXT_VT_MODE_32		0x00000002
+#define SXE_GCR_EXT_VT_MODE_64		0x00000003
+#define SXE_GCR_EXT_SRIOV			 (SXE_GCR_EXT_MSIX_EN | \
+					 SXE_GCR_EXT_VT_MODE_64)
+
+
+#define SXE_PCS1GCFIG 0x04200
+#define SXE_PCS1GLCTL 0x04208
+#define SXE_PCS1GLSTA 0x0420C
+#define SXE_PCS1GDBG0 0x04210
+#define SXE_PCS1GDBG1 0x04214
+#define SXE_PCS1GANA  0x04218
+#define SXE_PCS1GANLP 0x0421C
+#define SXE_PCS1GANNP 0x04220
+#define SXE_PCS1GANLPNP 0x04224
+#define SXE_HLREG0	0x04240
+#define SXE_HLREG1	0x04244
+#define SXE_PAP	   0x04248
+#define SXE_MACA	  0x0424C
+#define SXE_APAE	  0x04250
+#define SXE_ARD	   0x04254
+#define SXE_AIS	   0x04258
+#define SXE_MSCA	  0x0425C
+#define SXE_MSRWD	 0x04260
+#define SXE_MLADD	 0x04264
+#define SXE_MHADD	 0x04268
+#define SXE_MAXFRS	0x04268
+#define SXE_TREG	  0x0426C
+#define SXE_PCSS1	 0x04288
+#define SXE_PCSS2	 0x0428C
+#define SXE_XPCSS	 0x04290
+#define SXE_MFLCN	 0x04294
+#define SXE_SERDESC   0x04298
+#define SXE_MAC_SGMII_BUSY 0x04298
+#define SXE_MACS	  0x0429C
+#define SXE_AUTOC	 0x042A0
+#define SXE_LINKS	 0x042A4
+#define SXE_LINKS2	0x04324
+#define SXE_AUTOC2	0x042A8
+#define SXE_AUTOC3	0x042AC
+#define SXE_ANLP1	 0x042B0
+#define SXE_ANLP2	 0x042B4
+#define SXE_MACC	  0x04330
+#define SXE_ATLASCTL  0x04800
+#define SXE_MMNGC	 0x042D0
+#define SXE_ANLPNP1   0x042D4
+#define SXE_ANLPNP2   0x042D8
+#define SXE_KRPCSFC   0x042E0
+#define SXE_KRPCSS	0x042E4
+#define SXE_FECS1	 0x042E8
+#define SXE_FECS2	 0x042EC
+#define SXE_SMADARCTL 0x14F10
+#define SXE_MPVC	  0x04318
+#define SXE_SGMIIC	0x04314
+
+
+#define SXE_COMCTRL			 0x14400
+#define SXE_PCCTRL			  0x14404
+#define SXE_LPBKCTRL			0x1440C
+#define SXE_MAXFS			   0x14410
+#define SXE_SACONH			  0x14420
+#define SXE_VLANCTRL			0x14430
+#define SXE_VLANID			  0x14434
+#define SXE_VLANCTRL			0x14430
+#define SXE_FPAG_SDS_CON		0x14700
+
+
+#define SXE_COMCTRL_TXEN		0x0001
+#define SXE_COMCTRL_RXEN		0x0002
+#define SXE_COMCTRL_EDSEL	   0x0004
+#define SXE_COMCTRL_SPEED_1G	0x0200
+#define SXE_COMCTRL_SPEED_10G   0x0300
+
+
+#define SXE_PCCTRL_TXCE		 0x0001
+#define SXE_PCCTRL_RXCE		 0x0002
+#define SXE_PCCTRL_PEN		  0x0100
+#define SXE_PCCTRL_PCSC_ALL	 0x30000
+
+
+#define SXE_MAXFS_TFSEL		 0x0001
+#define SXE_MAXFS_RFSEL		 0x0002
+#define SXE_MAXFS_MFS_MASK	  0xFFFF0000
+#define SXE_MAXFS_MFS		   0x40000000
+#define SXE_MAXFS_MFS_SHIFT	 16
+
+
+#define SXE_FPGA_SDS_CON_FULL_DUPLEX_MODE	0x00200000
+#define SXE_FPGA_SDS_CON_ANRESTART		   0x00008000
+#define SXE_FPGA_SDS_CON_AN_ENABLE		   0x00001000
+
+
+#define SXE_RSCDBU_RSCSMALDIS_MASK	0x0000007F
+#define SXE_RSCDBU_RSCACKDIS		  0x00000080
+
+
+#define SXE_RDRXCTL_RDMTS_1_2	 0x00000000
+#define SXE_RDRXCTL_CRCSTRIP	  0x00000002
+#define SXE_RDRXCTL_PSP		   0x00000004
+#define SXE_RDRXCTL_MVMEN		 0x00000020
+#define SXE_RDRXCTL_DMAIDONE	  0x00000008
+#define SXE_RDRXCTL_AGGDIS		0x00010000
+#define SXE_RDRXCTL_RSCFRSTSIZE   0x003E0000
+#define SXE_RDRXCTL_RSCLLIDIS	 0x00800000
+#define SXE_RDRXCTL_RSCACKC	   0x02000000
+#define SXE_RDRXCTL_FCOE_WRFIX	0x04000000
+#define SXE_RDRXCTL_MBINTEN	   0x10000000
+#define SXE_RDRXCTL_MDP_EN		0x20000000
+
+
+#define SXE_CTRL_GIO_DIS	  0x00000004
+#define SXE_CTRL_LNK_RST	  0x00000008
+#define SXE_CTRL_RST		  0x04000000
+#define SXE_CTRL_RST_MASK	 (SXE_CTRL_LNK_RST | SXE_CTRL_RST)
+
+
+#define SXE_MHADD_MFS_MASK	0xFFFF0000
+#define SXE_MHADD_MFS_SHIFT   16
+
+
+#define SXE_CTRL_EXT_PFRSTD   0x00004000
+#define SXE_CTRL_EXT_NS_DIS   0x00010000
+#define SXE_CTRL_EXT_RO_DIS   0x00020000
+#define SXE_CTRL_EXT_DRV_LOAD 0x10000000
+
+
+#define SXE_TXPBSIZE_20KB	 0x00005000
+#define SXE_TXPBSIZE_40KB	 0x0000A000
+#define SXE_RXPBSIZE_48KB	 0x0000C000
+#define SXE_RXPBSIZE_64KB	 0x00010000
+#define SXE_RXPBSIZE_80KB	 0x00014000
+#define SXE_RXPBSIZE_128KB	0x00020000
+#define SXE_RXPBSIZE_MAX	  0x00080000
+#define SXE_TXPBSIZE_MAX	  0x00028000
+
+#define SXE_TXPKT_SIZE_MAX	0xA
+#define SXE_MAX_PB		8
+
+
+#define SXE_HLREG0_TXCRCEN	  0x00000001
+#define SXE_HLREG0_RXCRCSTRP	0x00000002
+#define SXE_HLREG0_JUMBOEN	  0x00000004
+#define SXE_HLREG0_TXPADEN	  0x00000400
+#define SXE_HLREG0_TXPAUSEEN	0x00001000
+#define SXE_HLREG0_RXPAUSEEN	0x00004000
+#define SXE_HLREG0_LPBK		 0x00008000
+#define SXE_HLREG0_MDCSPD	   0x00010000
+#define SXE_HLREG0_CONTMDC	  0x00020000
+#define SXE_HLREG0_CTRLFLTR	 0x00040000
+#define SXE_HLREG0_PREPEND	  0x00F00000
+#define SXE_HLREG0_PRIPAUSEEN   0x01000000
+#define SXE_HLREG0_RXPAUSERECDA 0x06000000
+#define SXE_HLREG0_RXLNGTHERREN 0x08000000
+#define SXE_HLREG0_RXPADSTRIPEN 0x10000000
+
+
+#define SXE_VMOLR_UPE		  0x00400000
+#define SXE_VMOLR_VPE		  0x00800000
+#define SXE_VMOLR_AUPE		0x01000000
+#define SXE_VMOLR_ROMPE	   0x02000000
+#define SXE_VMOLR_ROPE		0x04000000
+#define SXE_VMOLR_BAM		 0x08000000
+#define SXE_VMOLR_MPE		 0x10000000
+
+
+#define SXE_RXCSUM_IPPCSE	 0x00001000
+#define SXE_RXCSUM_PCSD	   0x00002000
+
+
+#define SXE_VMD_CTL_VMDQ_EN	 0x00000001
+#define SXE_VMD_CTL_VMDQ_FILTER 0x00000002
+
+
+#define	SXE_MACCFG_PAD_EN	   0x00000001
+
+
+#define SXE_IRQ_CLEAR_MASK	0xFFFFFFFF
+
+
+#define SXE_STATUS_LAN_ID		 0x0000000C
+#define SXE_STATUS_LAN_ID_SHIFT   2
+#define SXE_STATUS_GIO			0x00080000
+
+
+#define SXE_LINKS_KX_AN_COMP  0x80000000
+#define SXE_LINKS_UP		  0x40000000
+#define SXE_LINKS_SPEED	   0x20000000
+#define SXE_LINKS_MODE		0x18000000
+#define SXE_LINKS_RX_MODE	 0x06000000
+#define SXE_LINKS_TX_MODE	 0x01800000
+#define SXE_LINKS_XGXS_EN	 0x00400000
+#define SXE_LINKS_SGMII_EN	0x02000000
+#define SXE_LINKS_PCS_1G_EN   0x00200000
+#define SXE_LINKS_1G_AN_EN	0x00100000
+#define SXE_LINKS_KX_AN_IDLE  0x00080000
+#define SXE_LINKS_1G_SYNC	 0x00040000
+#define SXE_LINKS_10G_ALIGN   0x00020000
+#define SXE_LINKS_10G_LANE_SYNC 0x00017000
+#define SXE_LINKS_TL_FAULT	0x00001000
+#define SXE_LINKS_SIGNAL	  0x00000F00
+
+
+#define SXE_PCI_DEVICE_STATUS   0x7A
+#define SXE_PCI_DEVICE_STATUS_TRANSACTION_PENDING   0x0020
+#define SXE_PCI_LINK_STATUS	 0x82
+#define SXE_PCI_DEVICE_CONTROL2 0x98
+#define SXE_PCI_LINK_WIDTH	  0x3F0
+#define SXE_PCI_LINK_WIDTH_1	0x10
+#define SXE_PCI_LINK_WIDTH_2	0x20
+#define SXE_PCI_LINK_WIDTH_4	0x40
+#define SXE_PCI_LINK_WIDTH_8	0x80
+#define SXE_PCI_LINK_SPEED	  0xF
+#define SXE_PCI_LINK_SPEED_2500 0x1
+#define SXE_PCI_LINK_SPEED_5000 0x2
+#define SXE_PCI_LINK_SPEED_8000 0x3
+#define SXE_PCI_HEADER_TYPE_REGISTER  0x0E
+#define SXE_PCI_HEADER_TYPE_MULTIFUNC 0x80
+#define SXE_PCI_DEVICE_CONTROL2_16ms  0x0005
+
+#define SXE_PCIDEVCTRL2_TIMEO_MASK	0xf
+#define SXE_PCIDEVCTRL2_16_32ms_def	0x0
+#define SXE_PCIDEVCTRL2_50_100us	0x1
+#define SXE_PCIDEVCTRL2_1_2ms		0x2
+#define SXE_PCIDEVCTRL2_16_32ms	0x5
+#define SXE_PCIDEVCTRL2_65_130ms	0x6
+#define SXE_PCIDEVCTRL2_260_520ms	0x9
+#define SXE_PCIDEVCTRL2_1_2s		0xa
+#define SXE_PCIDEVCTRL2_4_8s		0xd
+#define SXE_PCIDEVCTRL2_17_34s	0xe
+
+
+#define SXE_PCI_MASTER_DISABLE_TIMEOUT	800
+
+
+#define SXE_RAH_VIND_MASK	 0x003C0000
+#define SXE_RAH_VIND_SHIFT	18
+#define SXE_RAH_AV			0x80000000
+#define SXE_CLEAR_VMDQ_ALL	0xFFFFFFFF
+
+
+#define SXE_RFCTL_ISCSI_DIS	   0x00000001
+#define SXE_RFCTL_ISCSI_DWC_MASK  0x0000003E
+#define SXE_RFCTL_ISCSI_DWC_SHIFT 1
+#define SXE_RFCTL_RSC_DIS		0x00000020
+#define SXE_RFCTL_NFSW_DIS		0x00000040
+#define SXE_RFCTL_NFSR_DIS		0x00000080
+#define SXE_RFCTL_NFS_VER_MASK	0x00000300
+#define SXE_RFCTL_NFS_VER_SHIFT   8
+#define SXE_RFCTL_NFS_VER_2	   0
+#define SXE_RFCTL_NFS_VER_3	   1
+#define SXE_RFCTL_NFS_VER_4	   2
+#define SXE_RFCTL_IPV6_DIS		0x00000400
+#define SXE_RFCTL_IPV6_XSUM_DIS   0x00000800
+#define SXE_RFCTL_IPFRSP_DIS	  0x00004000
+#define SXE_RFCTL_IPV6_EX_DIS	 0x00010000
+#define SXE_RFCTL_NEW_IPV6_EXT_DIS 0x00020000
+
+
+#define SXE_TXDCTL_ENABLE	 0x02000000
+#define SXE_TXDCTL_SWFLSH	 0x04000000
+#define SXE_TXDCTL_WTHRESH_SHIFT	  16
+
+
+#define SXE_RXCTRL_RXEN	   0x00000001
+#define SXE_RXCTRL_DMBYPS	 0x00000002
+#define SXE_RXDCTL_ENABLE	 0x02000000
+#define SXE_RXDCTL_SWFLSH	 0x04000000
+
+
+#define SXE_RXDCTL_DESC_FIFO_AFUL_TH_MASK 0x0000001F
+#define SXE_RXDCTL_AFUL_CFG_ERR		  0x00000020
+#define SXE_RXDCTL_DESC_FIFO_AE_TH_MASK   0x00001F00
+#define SXE_RXDCTL_DESC_FIFO_AE_TH_SHIFT  8
+#define SXE_RXDCTL_PREFETCH_NUM_CFG_MASK  0x001F0000
+#define SXE_RXDCTL_PREFETCH_NUM_CFG_SHIFT 16
+
+
+#define SXE_PCI_MASTER_DISABLE_TIMEOUT	800
+
+
+#define SXE_FCTRL_SBP 0x00000002
+#define SXE_FCTRL_MPE 0x00000100
+#define SXE_FCTRL_UPE 0x00000200
+#define SXE_FCTRL_BAM 0x00000400
+#define SXE_FCTRL_PMCF 0x00001000
+#define SXE_FCTRL_DPF 0x00002000
+
+
+#define SXE_QDE_ENABLE	0x00000001
+#define SXE_QDE_HIDE_VLAN	0x00000002
+#define SXE_QDE_IDX_MASK	0x00007F00
+#define SXE_QDE_IDX_SHIFT	8
+#define SXE_QDE_WRITE		0x00010000
+
+#define SXE_TXD_POPTS_IXSM 0x01
+#define SXE_TXD_POPTS_TXSM 0x02
+#define SXE_TXD_CMD_EOP	0x01000000
+#define SXE_TXD_CMD_IFCS   0x02000000
+#define SXE_TXD_CMD_IC	 0x04000000
+#define SXE_TXD_CMD_RS	 0x08000000
+#define SXE_TXD_CMD_DEXT   0x20000000
+#define SXE_TXD_CMD_VLE	0x40000000
+#define SXE_TXD_STAT_DD	0x00000001
+
+
+#define SXE_SRRCTL_BSIZEPKT_SHIFT	 10
+#define SXE_SRRCTL_RDMTS_SHIFT		22
+#define SXE_SRRCTL_RDMTS_MASK		 0x01C00000
+#define SXE_SRRCTL_DROP_EN			0x10000000
+#define SXE_SRRCTL_BSIZEPKT_MASK	  0x0000007F
+#define SXE_SRRCTL_BSIZEHDR_MASK	  0x00003F00
+#define SXE_SRRCTL_DESCTYPE_LEGACY	0x00000000
+#define SXE_SRRCTL_DESCTYPE_ADV_ONEBUF 0x02000000
+#define SXE_SRRCTL_DESCTYPE_HDR_SPLIT  0x04000000
+#define SXE_SRRCTL_DESCTYPE_HDR_REPLICATION_LARGE_PKT 0x08000000
+#define SXE_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS 0x0A000000
+#define SXE_SRRCTL_DESCTYPE_MASK	  0x0E000000
+
+#define SXE_RXDPS_HDRSTAT_HDRSP	   0x00008000
+#define SXE_RXDPS_HDRSTAT_HDRLEN_MASK 0x000003FF
+
+#define SXE_RXDADV_RSSTYPE_MASK	   0x0000000F
+#define SXE_RXDADV_PKTTYPE_MASK	   0x0000FFF0
+#define SXE_RXDADV_PKTTYPE_MASK_EX	0x0001FFF0
+#define SXE_RXDADV_HDRBUFLEN_MASK	 0x00007FE0
+#define SXE_RXDADV_RSCCNT_MASK		0x001E0000
+#define SXE_RXDADV_RSCCNT_SHIFT	   17
+#define SXE_RXDADV_HDRBUFLEN_SHIFT	5
+#define SXE_RXDADV_SPLITHEADER_EN	 0x00001000
+#define SXE_RXDADV_SPH				0x8000
+
+
+#define SXE_ADVTXD_DTYP_DATA  0x00300000
+#define SXE_ADVTXD_DCMD_IFCS  SXE_TXD_CMD_IFCS
+#define SXE_ADVTXD_DCMD_DEXT  SXE_TXD_CMD_DEXT
+#define SXE_ADVTXD_PAYLEN_SHIFT	14
+
+
+#define SXE_FLAGS_DOUBLE_RESET_REQUIRED	0x01
+
+
+#define SXE_ERR_EEPROM						-1
+#define SXE_ERR_EEPROM_CHECKSUM			   -2
+#define SXE_ERR_PHY						   -3
+#define SXE_ERR_CONFIG						-4
+#define SXE_ERR_PARAM						 -5
+#define SXE_ERR_MAC_TYPE					  -6
+#define SXE_ERR_UNKNOWN_PHY				   -7
+#define SXE_ERR_LINK_SETUP					-8
+#define SXE_ERR_ADAPTER_STOPPED			   -9
+#define SXE_ERR_INVALID_MAC_ADDR			  -10
+#define SXE_ERR_DEVICE_NOT_SUPPORTED		  -11
+#define SXE_ERR_MASTER_REQUESTS_PENDING	   -12
+#define SXE_ERR_INVALID_LINK_SETTINGS		 -13
+#define SXE_ERR_AUTONEG_NOT_COMPLETE		  -14
+#define SXE_ERR_RESET_FAILED				  -15
+#define SXE_ERR_SWFW_SYNC					 -16
+#define SXE_ERR_PHY_ADDR_INVALID			  -17
+#define SXE_ERR_I2C						   -18
+#define SXE_ERR_SFP_NOT_SUPPORTED			 -19
+#define SXE_ERR_SFP_NOT_PRESENT			   -20
+#define SXE_ERR_SFP_NO_INIT_SEQ_PRESENT	   -21
+#define SXE_ERR_NO_SAN_ADDR_PTR			   -22
+#define SXE_ERR_FDIR_REINIT_FAILED			-23
+#define SXE_ERR_EEPROM_VERSION				-24
+#define SXE_ERR_NO_SPACE					  -25
+#define SXE_ERR_OVERTEMP					  -26
+#define SXE_ERR_FC_NOT_NEGOTIATED			 -27
+#define SXE_ERR_FC_NOT_SUPPORTED			  -28
+#define SXE_ERR_SFP_SETUP_NOT_COMPLETE		-30
+#define SXE_ERR_PBA_SECTION				   -31
+#define SXE_ERR_INVALID_ARGUMENT			  -32
+#define SXE_ERR_HOST_INTERFACE_COMMAND		-33
+#define SXE_ERR_FDIR_CMD_INCOMPLETE		-38
+#define SXE_ERR_FW_RESP_INVALID		-39
+#define SXE_ERR_TOKEN_RETRY			-40
+#define SXE_NOT_IMPLEMENTED				   0x7FFFFFFF
+
+#define SXE_FUSES0_GROUP(_i)		(0x11158 + ((_i) * 4))
+#define SXE_FUSES0_300MHZ		BIT(5)
+#define SXE_FUSES0_REV_MASK		(3u << 6)
+
+#define SXE_KRM_PORT_CAR_GEN_CTRL(P)	((P) ? 0x8010 : 0x4010)
+#define SXE_KRM_LINK_S1(P)		((P) ? 0x8200 : 0x4200)
+#define SXE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
+#define SXE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
+#define SXE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
+#define SXE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
+#define SXE_KRM_LP_BASE_PAGE_HIGH(P)	((P) ? 0x836C : 0x436C)
+#define SXE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
+#define SXE_KRM_DSP_TXFFE_STATE_5(P)	((P) ? 0x8638 : 0x4638)
+#define SXE_KRM_RX_TRN_LINKUP_CTRL(P)	((P) ? 0x8B00 : 0x4B00)
+#define SXE_KRM_PMD_DFX_BURNIN(P)	((P) ? 0x8E00 : 0x4E00)
+#define SXE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
+#define SXE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
+#define SXE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
+
+#define SXE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SFI_10G_LR		(0x2 << 20)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SGMII_EN		BIT(25)
+#define SXE_KRM_PMD_FLX_MASK_ST20_AN37_EN		BIT(26)
+#define SXE_KRM_PMD_FLX_MASK_ST20_AN_EN		BIT(27)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_10M		~(0x7 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_100M		BIT(28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_1G		(0x2 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_10G		(0x3 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_AN		(0x4 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_2_5G		(0x7 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_SPEED_MASK		(0x7 << 28)
+#define SXE_KRM_PMD_FLX_MASK_ST20_FW_AN_RESTART	BIT(31)
+
+#define SXE_KRM_PORT_CAR_GEN_CTRL_NELB_32B		BIT(9)
+#define SXE_KRM_PORT_CAR_GEN_CTRL_NELB_KRPCS		BIT(11)
+
+#define SXE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_MASK	(7u << 8)
+#define SXE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_1G	(2u << 8)
+#define SXE_KRM_LINK_CTRL_1_TETH_FORCE_SPEED_10G	(4u << 8)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_SGMII_EN		BIT(12)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_CLAUSE_37_EN	BIT(13)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_FEC_REQ		BIT(14)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_CAP_FEC		BIT(15)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_CAP_KX		BIT(16)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_CAP_KR		BIT(18)
+#define SXE_KRM_LINK_CTRL_1_TETH_EEE_CAP_KX		BIT(24)
+#define SXE_KRM_LINK_CTRL_1_TETH_EEE_CAP_KR		BIT(26)
+#define SXE_KRM_LINK_S1_MAC_AN_COMPLETE		BIT(28)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_ENABLE		BIT(29)
+#define SXE_KRM_LINK_CTRL_1_TETH_AN_RESTART		BIT(31)
+
+#define SXE_KRM_AN_CNTL_1_SYM_PAUSE			BIT(28)
+#define SXE_KRM_AN_CNTL_1_ASM_PAUSE			BIT(29)
+
+#define SXE_KRM_AN_CNTL_8_LINEAR			BIT(0)
+#define SXE_KRM_AN_CNTL_8_LIMITING			BIT(1)
+
+#define SXE_KRM_LP_BASE_PAGE_HIGH_SYM_PAUSE		BIT(10)
+#define SXE_KRM_LP_BASE_PAGE_HIGH_ASM_PAUSE		BIT(11)
+#define SXE_KRM_SGMII_CTRL_MAC_TAR_FORCE_100_D	BIT(12)
+#define SXE_KRM_SGMII_CTRL_MAC_TAR_FORCE_10_D		BIT(19)
+
+#define SXE_KRM_DSP_TXFFE_STATE_C0_EN			BIT(6)
+#define SXE_KRM_DSP_TXFFE_STATE_CP1_CN1_EN		BIT(15)
+#define SXE_KRM_DSP_TXFFE_STATE_CO_ADAPT_EN		BIT(16)
+
+#define SXE_KRM_RX_TRN_LINKUP_CTRL_CONV_WO_PROTOCOL	BIT(4)
+#define SXE_KRM_RX_TRN_LINKUP_CTRL_PROTOCOL_BYPASS	BIT(2)
+
+#define SXE_KRM_PMD_DFX_BURNIN_TX_RX_KR_LB_MASK	(3u << 16)
+
+#define SXE_KRM_TX_COEFF_CTRL_1_CMINUS1_OVRRD_EN	BIT(1)
+#define SXE_KRM_TX_COEFF_CTRL_1_CPLUS1_OVRRD_EN	BIT(2)
+#define SXE_KRM_TX_COEFF_CTRL_1_CZERO_EN		BIT(3)
+#define SXE_KRM_TX_COEFF_CTRL_1_OVRRD_EN		BIT(31)
+
+#define SXE_SB_IOSF_INDIRECT_CTRL		0x00011144
+#define SXE_SB_IOSF_INDIRECT_DATA		0x00011148
+
+#define SXE_SB_IOSF_CTRL_ADDR_SHIFT		0
+#define SXE_SB_IOSF_CTRL_ADDR_MASK		0xFF
+#define SXE_SB_IOSF_CTRL_RESP_STAT_SHIFT	18
+#define SXE_SB_IOSF_CTRL_RESP_STAT_MASK \
+				(0x3 << SXE_SB_IOSF_CTRL_RESP_STAT_SHIFT)
+#define SXE_SB_IOSF_CTRL_CMPL_ERR_SHIFT	20
+#define SXE_SB_IOSF_CTRL_CMPL_ERR_MASK \
+				(0xFF << SXE_SB_IOSF_CTRL_CMPL_ERR_SHIFT)
+#define SXE_SB_IOSF_CTRL_TARGET_SELECT_SHIFT	28
+#define SXE_SB_IOSF_CTRL_TARGET_SELECT_MASK	0x7
+#define SXE_SB_IOSF_CTRL_BUSY_SHIFT		31
+#define SXE_SB_IOSF_CTRL_BUSY		BIT(SXE_SB_IOSF_CTRL_BUSY_SHIFT)
+#define SXE_SB_IOSF_TARGET_KR_PHY	0
+
+#define SXE_NW_MNG_IF_SEL		0x00011178
+#define SXE_NW_MNG_IF_SEL_MDIO_ACT		BIT(1)
+#define SXE_NW_MNG_IF_SEL_PHY_SPEED_10M	BIT(17)
+#define SXE_NW_MNG_IF_SEL_PHY_SPEED_100M	BIT(18)
+#define SXE_NW_MNG_IF_SEL_PHY_SPEED_1G	BIT(19)
+#define SXE_NW_MNG_IF_SEL_PHY_SPEED_2_5G	BIT(20)
+#define SXE_NW_MNG_IF_SEL_PHY_SPEED_10G	BIT(21)
+#define SXE_NW_MNG_IF_SEL_SGMII_ENABLE	BIT(25)
+#define SXE_NW_MNG_IF_SEL_INT_PHY_MODE	BIT(24)
+#define SXE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT	3
+#define SXE_NW_MNG_IF_SEL_MDIO_PHY_ADD	\
+				(0x1F << SXE_NW_MNG_IF_SEL_MDIO_PHY_ADD_SHIFT)
+
+#endif
diff --git a/drivers/net/sxe/meson.build b/drivers/net/sxe/meson.build
index 598fce480d..23d9f206e4 100644
--- a/drivers/net/sxe/meson.build
+++ b/drivers/net/sxe/meson.build
@@ -16,7 +16,15 @@ sources = files(
         'pf/sxe_main.c',
         'pf/sxe_irq.c',
         'pf/sxe_ethdev.c',
+        'pf/sxe_offload.c',
+        'pf/sxe_queue.c',
+        'pf/sxe_rx.c',
+        'pf/sxe_tx.c',
         'pf/sxe_pmd_hdc.c',
+        'base/sxe_queue_common.c',
+        'base/sxe_rx_common.c',
+        'base/sxe_tx_common.c',
+        'base/sxe_offload_common.c',
         'base/sxe_common.c',
         'base/sxe_hw.c',
 )
diff --git a/drivers/net/sxe/pf/sxe.h b/drivers/net/sxe/pf/sxe.h
index 009d2db173..187c7341e1 100644
--- a/drivers/net/sxe/pf/sxe.h
+++ b/drivers/net/sxe/pf/sxe.h
@@ -9,7 +9,9 @@
 
 #include <stdbool.h>
 #include "sxe_types.h"
+#include "sxe_filter.h"
 #include "sxe_irq.h"
+#include "sxe_stats.h"
 #include "sxe_phy.h"
 #include "sxe_hw.h"
 
@@ -44,6 +46,7 @@ struct sxe_adapter {
 
 	struct sxe_irq_context irq_ctxt;
 
+	bool rx_batch_alloc_allowed;
 	s8 name[PCI_PRI_STR_SIZE + 1];
 };
 
diff --git a/drivers/net/sxe/pf/sxe_ethdev.c b/drivers/net/sxe/pf/sxe_ethdev.c
index eef032eca0..b611922cf8 100644
--- a/drivers/net/sxe/pf/sxe_ethdev.c
+++ b/drivers/net/sxe/pf/sxe_ethdev.c
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (C), 2022, Linkdata Technology Co., Ltd.
  */
-
 #include <bus_pci_driver.h>
 #include <ethdev_driver.h>
 #include <dev_driver.h>
 #include <ethdev_pci.h>
 #include <rte_ethdev.h>
 #include <rte_alarm.h>
+#include <eal_export.h>
 #include "sxe_types.h"
 #include "sxe_logs.h"
 #include "sxe_compat_platform.h"
diff --git a/drivers/net/sxe/pf/sxe_irq.c b/drivers/net/sxe/pf/sxe_irq.c
index b00e9888e2..de7fc210f6 100644
--- a/drivers/net/sxe/pf/sxe_irq.c
+++ b/drivers/net/sxe/pf/sxe_irq.c
@@ -17,6 +17,7 @@
 #include "sxe_hw.h"
 #include "sxe.h"
 #include "sxe_phy.h"
+#include "sxe_queue.h"
 #include "sxe_errno.h"
 #include "sxe_compat_version.h"
 
@@ -95,6 +96,188 @@ void sxe_irq_init(struct rte_eth_dev *eth_dev)
 	rte_spinlock_init(&adapter->irq_ctxt.event_irq_lock);
 }
 
+static s32 sxe_irq_general_config(struct rte_eth_dev *dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	u32 gpie;
+	s32 ret = 0;
+
+	gpie = sxe_hw_irq_general_reg_get(hw);
+	if (!rte_intr_dp_is_en(handle) &&
+		!(gpie & (SXE_GPIE_MSIX_MODE | SXE_GPIE_PBA_SUPPORT))) {
+		ret = -SXE_ERR_CONFIG;
+		gpie |= SXE_GPIE_MSIX_MODE;
+		PMD_LOG_INFO(DRV, "rx queue irq num:%d gpie:0x%x.",
+				  handle->nb_efd, gpie);
+	} else {
+		gpie |= SXE_GPIE_MSIX_MODE | SXE_GPIE_PBA_SUPPORT |
+			SXE_GPIE_OCD | SXE_GPIE_EIAME |
+			SXE_GPIE_SPP1_EN | SXE_GPIE_SPP2_EN;
+	}
+
+	sxe_hw_irq_general_reg_set(hw, gpie);
+
+	return ret;
+}
+
+static void sxe_msix_configure(struct rte_eth_dev *dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_rx_queue *rx_queue;
+	s32 ret;
+	u16 queue_id;
+	u16 vector = SXE_MISC_VEC_ID;
+	u16 base = SXE_MISC_VEC_ID;
+	u32 irq_interval;
+	u32 value;
+
+	ret = sxe_irq_general_config(dev);
+	if (ret) {
+		PMD_LOG_INFO(DRV, "unsupport msi-x, no need config irq");
+		return;
+	}
+
+	irq_interval = SXE_EITR_INTERVAL_US(SXE_QUEUE_ITR_INTERVAL_DEFAULT);
+	if (rte_intr_allow_others(handle)) {
+		vector = SXE_RX_VEC_BASE;
+		base = SXE_RX_VEC_BASE;
+	}
+
+
+	if (rte_intr_dp_is_en(handle)) {
+		irq_interval = SXE_EITR_INTERVAL_US(SXE_QUEUE_ITR_INTERVAL);
+		for (queue_id = 0; queue_id < dev->data->nb_rx_queues;
+			queue_id++) {
+			rx_queue = dev->data->rx_queues[queue_id];
+			if (dev->data->lro == 1) {
+				sxe_hw_ring_irq_interval_set(hw, vector,
+										irq_interval);
+			}
+
+			sxe_hw_ring_irq_map(hw, false,
+						rx_queue->reg_idx,
+						vector);
+			handle->intr_vec[queue_id] = vector;
+			PMD_LOG_INFO(DRV,
+					"queue id:%u reg_idx:%u vector:%u ",
+					queue_id,
+					rx_queue->reg_idx,
+					vector);
+			if (vector < base + handle->nb_efd - 1)
+				vector++;
+		}
+		sxe_hw_event_irq_map(hw, 1, SXE_MISC_VEC_ID);
+	}
+
+	sxe_hw_ring_irq_interval_set(hw, 0, irq_interval);
+
+	sxe_hw_ring_irq_auto_disable(hw, true);
+
+	value = SXE_EIMS_ENABLE_MASK;
+	value &= ~(SXE_EIMS_OTHER | SXE_EIMS_MAILBOX | SXE_EIMS_LSC);
+	sxe_hw_event_irq_auto_clear_set(hw, value);
+}
+
+s32 sxe_irq_configure(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	u16 irq_num;
+	s32 ret = 0;
+
+	if ((rte_intr_cap_multiple(handle) ||
+		 !RTE_ETH_DEV_SRIOV(eth_dev).active) &&
+		eth_dev->data->dev_conf.intr_conf.rxq != 0) {
+		irq_num = eth_dev->data->nb_rx_queues;
+		if (irq_num > SXE_QUEUE_IRQ_NUM_MAX) {
+			PMD_LOG_ERR(DRV, "irq_num:%u exceed limit:%u ",
+					  irq_num, SXE_QUEUE_IRQ_NUM_MAX);
+			ret = -ENOTSUP;
+			goto l_out;
+		}
+
+		if (rte_intr_efd_enable(handle, irq_num)) {
+			ret = -SXE_ERR_CONFIG;
+			PMD_LOG_ERR(DRV,
+					  "intr_handle type:%d irq num:%d invalid",
+					  handle->type, irq_num);
+			goto l_out;
+		}
+	}
+
+	if (rte_intr_dp_is_en(handle) && !handle->intr_vec) {
+		handle->intr_vec = rte_zmalloc("intr_vec",
+					eth_dev->data->nb_rx_queues * sizeof(u32), 0);
+		if (handle->intr_vec == NULL) {
+			PMD_LOG_ERR(DRV, "rx queue irq vector "
+					 "allocate %zuB memory fail.",
+					 eth_dev->data->nb_rx_queues * sizeof(u32));
+			ret = -ENOMEM;
+			goto l_out;
+		}
+	}
+
+	sxe_msix_configure(eth_dev);
+
+	sxe_irq_enable(eth_dev);
+
+	PMD_LOG_INFO(DRV,
+			  "intr_conf rxq:%u intr_handle type:%d rx queue num:%d "
+			  "queue irq num:%u total irq num:%u "
+			  "config done",
+			  eth_dev->data->dev_conf.intr_conf.rxq,
+			  handle->type,
+			  eth_dev->data->nb_rx_queues,
+			  handle->nb_efd,
+			  handle->max_intr);
+
+l_out:
+	return ret;
+}
+
+void sxe_irq_enable(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	struct sxe_hw *hw = &adapter->hw;
+
+	if (rte_intr_allow_others(handle)) {
+		sxe_link_info_output(eth_dev);
+
+		if (eth_dev->data->dev_conf.intr_conf.lsc != 0)
+			irq->enable_mask |= SXE_EIMS_LSC;
+		else
+			irq->enable_mask &= ~SXE_EIMS_LSC;
+
+	} else {
+		rte_intr_callback_unregister(handle,
+						 sxe_event_irq_handler, eth_dev);
+		if (eth_dev->data->dev_conf.intr_conf.lsc != 0)
+			PMD_LOG_ERR(DRV, "event irq not support.");
+	}
+
+	/* check if rxq interrupt is enabled */
+	if (eth_dev->data->dev_conf.intr_conf.rxq != 0 &&
+		rte_intr_dp_is_en(handle))
+		irq->enable_mask |= SXE_EIMS_RTX_QUEUE;
+
+	rte_intr_enable(handle);
+
+	sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+
+	PMD_LOG_INFO(DRV,
+			  "intr_handle type:%d enable irq mask:0x%x",
+			  handle->type,
+			  irq->enable_mask);
+}
 void sxe_irq_vec_free(struct rte_intr_handle *handle)
 {
 	if (handle->intr_vec != NULL) {
@@ -102,6 +285,20 @@ void sxe_irq_vec_free(struct rte_intr_handle *handle)
 		handle->intr_vec = NULL;
 	}
 }
+void sxe_irq_disable(struct rte_eth_dev *eth_dev)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *handle = SXE_PCI_INTR_HANDLE(pci_dev);
+
+	if (!rte_intr_allow_others(handle)) {
+		rte_intr_callback_register(handle,
+					   sxe_event_irq_handler,
+					   (void *)eth_dev);
+	}
+
+	rte_intr_efd_disable(handle);
+	sxe_irq_vec_free(handle);
+}
 void sxe_irq_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
@@ -122,4 +319,64 @@ void sxe_irq_uninit(struct rte_eth_dev *eth_dev)
 		}
 		rte_delay_ms(100);
 	} while (retry++ < (10 + SXE_LINK_UP_TIME));
+
+	rte_eal_alarm_cancel(sxe_event_irq_delayed_handler, eth_dev);
+}
+
+s32 sxe_rx_queue_intr_enable(struct rte_eth_dev *eth_dev, u16 queue_id)
+{
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *intr_handle = SXE_PCI_INTR_HANDLE(pci_dev);
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u32 mask;
+
+	if (queue_id < 16) {
+		sxe_hw_all_irq_disable(hw);
+		irq->enable_mask |= (1 << queue_id);
+		sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+	} else if (queue_id < 32) {
+		mask = sxe_hw_ring_irq_switch_get(hw, 0);
+		mask &= (1 << queue_id);
+		sxe_hw_ring_irq_switch_set(hw, 0, mask);
+	} else if (queue_id < 64) {
+		mask = sxe_hw_ring_irq_switch_get(hw, 1);
+		mask &= (1 << (queue_id - 32));
+		sxe_hw_ring_irq_switch_set(hw, 1, mask);
+	}
+
+	rte_intr_ack(intr_handle);
+
+	PMD_LOG_INFO(DRV, "queue_id:%u irq enabled enable_mask:0x%x.",
+			queue_id, irq->enable_mask);
+
+	return 0;
+}
+
+s32 sxe_rx_queue_intr_disable(struct rte_eth_dev *eth_dev, u16 queue_id)
+{
+	struct sxe_adapter *adapter = eth_dev->data->dev_private;
+	struct sxe_hw *hw = &adapter->hw;
+	struct sxe_irq_context *irq = &adapter->irq_ctxt;
+	u32 mask;
+
+	if (queue_id < 16) {
+		sxe_hw_all_irq_disable(hw);
+		irq->enable_mask &= ~(1 << queue_id);
+		sxe_hw_specific_irq_enable(hw, irq->enable_mask);
+	} else if (queue_id < 32) {
+		mask = sxe_hw_ring_irq_switch_get(hw, 0);
+		mask &= ~(1 << queue_id);
+		sxe_hw_ring_irq_switch_set(hw, 0, mask);
+	} else if (queue_id < 64) {
+		mask = sxe_hw_ring_irq_switch_get(hw, 1);
+		mask &= ~(1 << (queue_id - 32));
+		sxe_hw_ring_irq_switch_set(hw, 1, mask);
+	}
+
+	PMD_LOG_INFO(DRV, "queue_id:%u irq disabled enable_mask:0x%x.",
+			queue_id, irq->enable_mask);
+
+	return 0;
 }
diff --git a/drivers/net/sxe/pf/sxe_irq.h b/drivers/net/sxe/pf/sxe_irq.h
index e3a7da6ae8..b35b2277f9 100644
--- a/drivers/net/sxe/pf/sxe_irq.h
+++ b/drivers/net/sxe/pf/sxe_irq.h
@@ -33,7 +33,18 @@ void sxe_event_irq_delayed_handler(void *param);
 
 void sxe_irq_init(struct rte_eth_dev *eth_dev);
 
+s32 sxe_irq_configure(struct rte_eth_dev *dev);
+
+void sxe_irq_enable(struct rte_eth_dev *eth_dev);
+
+void sxe_irq_disable(struct rte_eth_dev *eth_dev);
+
 void sxe_irq_uninit(struct rte_eth_dev *eth_dev);
 
+s32 sxe_rx_queue_intr_enable(struct rte_eth_dev *eth_dev, u16 queue_id);
+
+s32 sxe_rx_queue_intr_disable(struct rte_eth_dev *eth_dev, u16 queue_id);
+
+void sxe_irq_vec_free(struct rte_intr_handle *handle);
 
 #endif
diff --git a/drivers/net/sxe/pf/sxe_main.c b/drivers/net/sxe/pf/sxe_main.c
index 652c432268..2df467b9cd 100644
--- a/drivers/net/sxe/pf/sxe_main.c
+++ b/drivers/net/sxe/pf/sxe_main.c
@@ -19,9 +19,11 @@
 #include "sxe_ethdev.h"
 #include "sxe.h"
 #include "drv_msg.h"
+#include "sxe_queue.h"
 #include "sxe_errno.h"
 #include "sxe_compat_platform.h"
 #include "sxe_pmd_hdc.h"
+#include "sxe_queue.h"
 
 static const struct rte_pci_id sxe_pci_tbl[] = {
 	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_STARS, SXE_DEV_ID_ASIC) },
@@ -117,10 +119,15 @@ s32 sxe_hw_reset(struct sxe_hw *hw)
 {
 	s32 ret;
 
+	/* Rx DBU off */
+	sxe_hw_rx_cap_switch_off(hw);
+
 	sxe_hw_all_irq_disable(hw);
 
 	sxe_hw_pending_irq_read_clear(hw);
 
+	sxe_hw_all_ring_disable(hw, SXE_HW_TXRX_RING_NUM_MAX);
+
 	ret = sxe_mng_reset(hw, false);
 	if (ret) {
 		PMD_LOG_ERR(INIT, "mng reset disable failed, ret=%d", ret);
diff --git a/drivers/net/sxe/pf/sxe_offload.c b/drivers/net/sxe/pf/sxe_offload.c
new file mode 100644
index 0000000000..0fa3f4822a
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_offload.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include "sxe.h"
+#include "sxe_offload.h"
+#include "sxe_logs.h"
+#include "sxe_compat_version.h"
+#include "sxe_queue_common.h"
+#include "sxe_offload_common.h"
+
+#define SXE_4_BIT_WIDTH  (CHAR_BIT / 2)
+#define SXE_4_BIT_MASK   RTE_LEN2MASK(SXE_4_BIT_WIDTH, u8)
+#define SXE_8_BIT_WIDTH  CHAR_BIT
+#define SXE_8_BIT_MASK   UINT8_MAX
+
+u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev)
+{
+	return __sxe_rx_queue_offload_capa_get(dev);
+}
+
+u64 sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev)
+{
+	return __sxe_rx_port_offload_capa_get(dev);
+}
+
+u64 sxe_tx_queue_offload_capa_get(struct rte_eth_dev *dev)
+{
+	RTE_SET_USED(dev);
+
+	return 0;
+}
+
+u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev)
+{
+	return __sxe_tx_port_offload_capa_get(dev);
+}
diff --git a/drivers/net/sxe/pf/sxe_offload.h b/drivers/net/sxe/pf/sxe_offload.h
new file mode 100644
index 0000000000..a70d6bf94b
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_offload.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_OFFLOAD_H__
+#define __SXE_OFFLOAD_H__
+
+#include "sxe_hw.h"
+
+u64 sxe_rx_queue_offload_capa_get(struct rte_eth_dev *dev);
+
+u64 sxe_rx_port_offload_capa_get(struct rte_eth_dev *dev);
+
+u64 sxe_tx_queue_offload_capa_get(struct rte_eth_dev *dev);
+
+u64 sxe_tx_port_offload_capa_get(struct rte_eth_dev *dev);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_queue.c b/drivers/net/sxe/pf/sxe_queue.c
new file mode 100644
index 0000000000..2bfac6ede9
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_queue.c
@@ -0,0 +1,774 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include <dev_driver.h>
+#include "sxe_ethdev.h"
+#include "rte_malloc.h"
+#include "sxe.h"
+#include "sxe_hw.h"
+#include "sxe_logs.h"
+#include "sxe_queue.h"
+#include "sxe_offload.h"
+#include "sxe_queue_common.h"
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include "sxe_vec_common.h"
+#endif
+#include "sxe_compat_version.h"
+
+#define SXE_RXQ_SCAN_INTERVAL   4
+
+#ifndef DEFAULT_TX_RS_THRESH
+#define DEFAULT_TX_RS_THRESH   32
+#endif
+
+#ifndef DEFAULT_TX_FREE_THRESH
+#define DEFAULT_TX_FREE_THRESH 32
+#endif
+
+#define RTE_SXE_WAIT_100_US	100
+
+#define SXE_MMW_SIZE_DEFAULT		0x4
+#define SXE_MMW_SIZE_JUMBO_FRAME	0x14
+#define SXE_MAX_JUMBO_FRAME_SIZE	0x2600
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+static s32 sxe_vf_rss_rxq_num_validate(struct rte_eth_dev *dev, u16 rxq_num)
+{
+	s32 ret = 0;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+
+	switch (rxq_num) {
+	case SXE_1_RING_PER_POOL:
+	case SXE_2_RING_PER_POOL:
+		RTE_ETH_DEV_SRIOV(dev).active = RTE_ETH_64_POOLS;
+		break;
+	case SXE_4_RING_PER_POOL:
+		RTE_ETH_DEV_SRIOV(dev).active = RTE_ETH_32_POOLS;
+		break;
+	default:
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool =
+		SXE_HW_TXRX_RING_NUM_MAX / RTE_ETH_DEV_SRIOV(dev).active;
+	RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx =
+		pci_dev->max_vfs * RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool;
+
+	PMD_LOG_INFO(INIT, "enable sriov, vfs num:%u, %u pool mode, %u queue pre pool "
+				"vm total queue num are %u",
+				pci_dev->max_vfs,
+				RTE_ETH_DEV_SRIOV(dev).active,
+				RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool,
+				RTE_ETH_DEV_SRIOV(dev).def_pool_q_idx);
+l_end:
+	return ret;
+}
+
+s32 sxe_sriov_mq_mode_check(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	u16 rx_q_num = dev->data->nb_rx_queues;
+	u16 tx_q_num = dev->data->nb_tx_queues;
+
+	switch (dev_conf->rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_VMDQ_DCB:
+		PMD_LOG_INFO(INIT, "RTE_ETH_MQ_RX_VMDQ_DCB mode supported in sriov");
+		break;
+
+	case RTE_ETH_MQ_RX_VMDQ_DCB_RSS:
+		PMD_LOG_ERR(INIT, "RTE_ETH_MQ_RX_VMDQ_DCB_RSS mode unsupported in sriov");
+		ret = -EINVAL;
+		goto l_end;
+
+	case RTE_ETH_MQ_RX_RSS:
+	case RTE_ETH_MQ_RX_VMDQ_RSS:
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_VMDQ_RSS;
+		if ((rx_q_num <= RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool) &&
+				sxe_vf_rss_rxq_num_validate(dev, rx_q_num)) {
+			PMD_LOG_ERR(INIT, "sriov is active, invalid queue number[%d], "
+				" for vmdq rss, allowed value are 1, 2 or 4",
+					rx_q_num);
+			ret = -EINVAL;
+			goto l_end;
+		}
+		break;
+
+	case RTE_ETH_MQ_RX_VMDQ_ONLY:
+	case RTE_ETH_MQ_RX_NONE:
+		dev->data->dev_conf.rxmode.mq_mode = RTE_ETH_MQ_RX_VMDQ_ONLY;
+		break;
+
+	default:
+		PMD_LOG_ERR(INIT, "sriov is active, wrong mq_mode rx %d",
+				dev_conf->rxmode.mq_mode);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	switch (dev_conf->txmode.mq_mode) {
+	case RTE_ETH_MQ_TX_VMDQ_DCB:
+		PMD_LOG_INFO(INIT, "RTE_ETH_MQ_TX_VMDQ_DCB mode supported in sriov");
+		break;
+
+	case RTE_ETH_MQ_TX_DCB:
+		PMD_LOG_ERR(INIT, "RTE_ETH_MQ_TX_DCB mode unsupported in sriov");
+		ret = -EINVAL;
+		goto l_end;
+
+	default:
+		dev->data->dev_conf.txmode.mq_mode = RTE_ETH_MQ_TX_VMDQ_ONLY;
+		break;
+	}
+
+	if ((rx_q_num > RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool) ||
+		(tx_q_num > RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool)) {
+		PMD_LOG_ERR(INIT, "SRIOV is active,"
+				" rx_q_num=%d tx_q_num=%d queue number"
+				" must be less than or equal to %d.",
+				rx_q_num, tx_q_num,
+				RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	PMD_LOG_INFO(INIT, "sriov enable, rx_mq_mode=%d, tx_mq_mode=%d, "
+			"rx_q_mun=%d, tx_q_num=%d, q_pre_pool=%d",
+			dev_conf->rxmode.mq_mode, dev_conf->txmode.mq_mode,
+			rx_q_num, tx_q_num, RTE_ETH_DEV_SRIOV(dev).nb_q_per_pool);
+
+l_end:
+	return ret;
+}
+
+#endif
+
+static inline s32 sxe_non_sriov_mq_mode_check(struct rte_eth_dev *dev)
+{
+	s32 ret = -EINVAL;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	u16 rx_q_num = dev->data->nb_rx_queues;
+	u16 tx_q_num = dev->data->nb_tx_queues;
+
+	switch (dev_conf->rxmode.mq_mode) {
+	case RTE_ETH_MQ_RX_VMDQ_DCB_RSS:
+		PMD_LOG_ERR(INIT, "VMDQ+DCB+RSS mq_mode is not supported");
+		goto l_end;
+	case RTE_ETH_MQ_RX_VMDQ_DCB:
+		if (rx_q_num != SXE_HW_TXRX_RING_NUM_MAX) {
+			PMD_LOG_ERR(INIT, "VMDQ+DCB selected, nb_rx_q != %d",
+					SXE_HW_TXRX_RING_NUM_MAX);
+			goto l_end;
+		}
+
+		if (!(dev_conf->rx_adv_conf.vmdq_dcb_conf.nb_queue_pools ==
+			RTE_ETH_16_POOLS ||
+			dev_conf->rx_adv_conf.vmdq_dcb_conf.nb_queue_pools ==
+			RTE_ETH_32_POOLS)) {
+			PMD_LOG_ERR(INIT, "VMDQ+DCB selected,"
+					" nb_queue_pools must be %d or %d",
+					RTE_ETH_16_POOLS, RTE_ETH_32_POOLS);
+			goto l_end;
+		}
+		break;
+	case RTE_ETH_MQ_RX_DCB:
+		if (!(dev_conf->rx_adv_conf.dcb_rx_conf.nb_tcs == RTE_ETH_4_TCS ||
+			dev_conf->rx_adv_conf.dcb_rx_conf.nb_tcs == RTE_ETH_8_TCS)) {
+			PMD_LOG_ERR(INIT, "DCB selected, nb_tcs != %d"
+					" and nb_tcs != %d",
+					RTE_ETH_4_TCS, RTE_ETH_8_TCS);
+			goto l_end;
+		}
+		break;
+	default:
+		PMD_LOG_INFO(INIT, "%d rx mq_mode supported",
+					dev_conf->rxmode.mq_mode);
+		break;
+	}
+
+	switch (dev_conf->txmode.mq_mode) {
+	case RTE_ETH_MQ_TX_NONE:
+		if (tx_q_num > SXE_HW_TX_NONE_MODE_Q_NUM) {
+			PMD_LOG_ERR(INIT, "Neither VT nor DCB are enabled, "
+					"nb_tx_q > %d.",
+					SXE_HW_TX_NONE_MODE_Q_NUM);
+			goto l_end;
+		}
+		break;
+	case RTE_ETH_MQ_TX_VMDQ_DCB:
+		if (tx_q_num != SXE_HW_TXRX_RING_NUM_MAX) {
+			PMD_LOG_ERR(INIT, "VMDQ+DCB selected, nb_tx_q != %d",
+					SXE_HW_TXRX_RING_NUM_MAX);
+			goto l_end;
+		}
+
+		if (!(dev_conf->tx_adv_conf.vmdq_dcb_tx_conf.nb_queue_pools ==
+			RTE_ETH_16_POOLS ||
+			dev_conf->tx_adv_conf.vmdq_dcb_tx_conf.nb_queue_pools ==
+			RTE_ETH_32_POOLS)) {
+			PMD_LOG_ERR(INIT, "VMDQ+DCB selected,"
+					" nb_queue_pools must be %d or %d",
+					RTE_ETH_16_POOLS, RTE_ETH_32_POOLS);
+			goto l_end;
+		}
+		break;
+	case RTE_ETH_MQ_TX_DCB:
+		if (!(dev_conf->tx_adv_conf.dcb_tx_conf.nb_tcs == RTE_ETH_4_TCS ||
+			dev_conf->tx_adv_conf.dcb_tx_conf.nb_tcs == RTE_ETH_8_TCS)) {
+			PMD_LOG_ERR(INIT, "DCB selected, nb_tcs != %d"
+					" and nb_tcs != %d",
+					RTE_ETH_4_TCS, RTE_ETH_8_TCS);
+			goto l_end;
+		}
+		break;
+	default:
+		PMD_LOG_INFO(INIT, "%d tx mq_mode supported",
+					dev_conf->txmode.mq_mode);
+		break;
+	}
+
+	ret = 0;
+
+	PMD_LOG_INFO(INIT, "sriov disable, rx_mq_mode=%d, tx_mq_mode=%d, "
+		"rx_q_mun=%d, tx_q_num=%d",
+		dev_conf->rxmode.mq_mode, dev_conf->txmode.mq_mode,
+		rx_q_num, tx_q_num);
+
+l_end:
+	return ret;
+}
+
+s32 sxe_mq_mode_check(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+	if (RTE_ETH_DEV_SRIOV(dev).active) {
+		ret = sxe_sriov_mq_mode_check(dev);
+#else
+	if (RTE_ETH_DEV_SRIOV(dev).active) {
+		ret = -ENOTSUP;
+		PMD_LOG_ERR(INIT, "sriov not supported");
+#endif
+	} else {
+		ret = sxe_non_sriov_mq_mode_check(dev);
+	}
+
+	return ret;
+}
+
+void sxe_tx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_txq_info *q_info)
+{
+	__sxe_tx_queue_info_get(dev, queue_id, q_info);
+}
+
+void sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_recycle_rxq_info *q_info)
+{
+	__sxe_recycle_rxq_info_get(dev, queue_id, q_info);
+}
+
+s32 __rte_cold sxe_txq_arg_validate(struct rte_eth_dev *dev, u16 ring_depth,
+				u16 *rs_thresh, u16 *free_thresh,
+				const struct rte_eth_txconf *tx_conf)
+{
+	s32 ret = -EINVAL;
+
+	if (ring_depth % SXE_TX_DESC_RING_ALIGN != 0 ||
+		ring_depth > SXE_MAX_RING_DESC ||
+		ring_depth < SXE_MIN_RING_DESC) {
+		goto l_end;
+	}
+
+	*free_thresh = (u16)((tx_conf->tx_free_thresh) ?
+			tx_conf->tx_free_thresh : DEFAULT_TX_FREE_THRESH);
+	*rs_thresh = (DEFAULT_TX_RS_THRESH + *free_thresh > ring_depth) ?
+			ring_depth - *free_thresh : DEFAULT_TX_RS_THRESH;
+
+	if (tx_conf->tx_rs_thresh > 0)
+		*rs_thresh = tx_conf->tx_rs_thresh;
+
+	if (*rs_thresh + *free_thresh > ring_depth) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh + tx_free_thresh must not "
+				 "exceed nb_desc. (tx_rs_thresh=%u "
+				 "tx_free_thresh=%u nb_desc=%u port = %d)",
+				 *rs_thresh, *free_thresh,
+				 ring_depth, dev->data->port_id);
+		goto l_end;
+	}
+
+	if (*rs_thresh >= (ring_depth - 2)) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh must be less than the number "
+				"of TX descriptors minus 2. (tx_rs_thresh=%u "
+				"port=%d)",
+				*rs_thresh, dev->data->port_id);
+		goto l_end;
+	}
+
+	if (*rs_thresh > DEFAULT_TX_RS_THRESH) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh must be less or equal than %u. "
+			"(tx_rs_thresh=%u port=%d)",
+			DEFAULT_TX_RS_THRESH, *rs_thresh,
+			dev->data->port_id);
+		goto l_end;
+	}
+
+	if (*free_thresh >= (ring_depth - 3)) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh must be less than the "
+				 "tx_free_thresh must be less than the number of "
+				 "TX descriptors minus 3. (tx_free_thresh=%u "
+				 "port=%d)",
+				 *free_thresh, dev->data->port_id);
+		goto l_end;
+	}
+
+	if (*rs_thresh > *free_thresh) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh must be less than or equal to "
+				 "tx_free_thresh. (tx_free_thresh=%u "
+				 "tx_rs_thresh=%u port=%d)",
+				 *free_thresh, *rs_thresh, dev->data->port_id);
+		goto l_end;
+	}
+
+	if ((ring_depth % *rs_thresh) != 0) {
+		PMD_LOG_ERR(INIT, "tx_rs_thresh must be a divisor of the "
+				 "number of TX descriptors. (tx_rs_thresh=%u "
+				 "port=%d, ring_depth=%d)",
+				 *rs_thresh, dev->data->port_id, ring_depth);
+		goto l_end;
+	}
+
+	if ((*rs_thresh > 1) && tx_conf->tx_thresh.wthresh != 0) {
+		PMD_LOG_ERR(INIT, "TX WTHRESH must be set to 0 if "
+				 "tx_rs_thresh is greater than 1. "
+				 "(tx_rs_thresh=%u port=%d)",
+				 *rs_thresh, dev->data->port_id);
+		goto l_end;
+	}
+
+	ret = 0;
+
+l_end:
+	return ret;
+}
+
+static void __rte_cold sxe_tx_buffer_ring_free(sxe_tx_queue_s *txq)
+{
+	if (txq != NULL && txq->buffer_ring != NULL)
+		rte_free(txq->buffer_ring);
+}
+
+static void __rte_cold sxe_tx_queue_mbufs_release(sxe_tx_queue_s *txq)
+{
+	u32 i;
+
+	if (txq->buffer_ring != NULL) {
+		for (i = 0; i < txq->ring_depth; i++) {
+			if (txq->buffer_ring[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(txq->buffer_ring[i].mbuf);
+				txq->buffer_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+void __rte_cold sxe_tx_queue_free(sxe_tx_queue_s *txq)
+{
+	__sxe_tx_queue_free(txq);
+}
+
+void __rte_cold sxe_tx_queue_release(struct rte_eth_dev *dev,
+					u16 queue_idx)
+{
+	sxe_tx_queue_free(dev->data->tx_queues[queue_idx]);
+}
+
+static void __rte_cold sxe_tx_queue_init(sxe_tx_queue_s *txq)
+{
+	u16 prev, i;
+	volatile sxe_tx_data_desc_u *txd;
+	static const sxe_tx_data_desc_u zeroed_desc = { {0} };
+	struct sxe_tx_buffer *tx_buffer = txq->buffer_ring;
+
+	for (i = 0; i < txq->ring_depth; i++)
+		txq->desc_ring[i] = zeroed_desc;
+
+	prev = txq->ring_depth - 1;
+	for (i = 0; i < txq->ring_depth; i++) {
+		txd = &txq->desc_ring[i];
+		txd->wb.status = rte_cpu_to_le_32(SXE_TX_DESC_STAT_DD);
+		tx_buffer[i].mbuf	   = NULL;
+		tx_buffer[i].last_id	= i;
+		tx_buffer[prev].next_id = i;
+		prev = i;
+	}
+
+	txq->ctx_curr	  = 0;
+	txq->desc_used_num = 0;
+	txq->desc_free_num = txq->ring_depth - 1;
+	txq->next_to_use   = 0;
+	txq->next_to_clean = txq->ring_depth - 1;
+	txq->next_dd	   = txq->rs_thresh  - 1;
+	txq->next_rs	   = txq->rs_thresh  - 1;
+	memset((void *)&txq->ctx_cache, 0,
+			SXE_CTXT_DESC_NUM * sizeof(struct sxe_ctxt_info));
+}
+
+sxe_tx_queue_s * __rte_cold sxe_tx_queue_alloc(struct rte_eth_dev *dev,
+					u16 queue_idx,
+					u16 ring_depth,
+					u32 socket_id)
+{
+	sxe_tx_queue_s *txq;
+	const struct rte_memzone *tz;
+
+	if (dev->data->tx_queues[queue_idx] != NULL) {
+		sxe_tx_queue_free(dev->data->tx_queues[queue_idx]);
+		dev->data->tx_queues[queue_idx] = NULL;
+	}
+
+	txq = rte_zmalloc_socket("tx queue", sizeof(sxe_tx_queue_s),
+				 RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq == NULL) {
+		PMD_LOG_ERR(INIT, "tx queue[%d] alloc failed", queue_idx);
+		goto l_end;
+	}
+
+	tz = rte_eth_dma_zone_reserve(dev, "tx_desc_ring", queue_idx,
+			sizeof(sxe_tx_data_desc_u) * SXE_MAX_RING_DESC,
+			SXE_ALIGN, socket_id);
+	if (tz == NULL) {
+		PMD_LOG_ERR(INIT, "tx desc ring alloc failed, queue_id=%d", queue_idx);
+		rte_free(txq);
+		txq = NULL;
+		goto l_end;
+	}
+
+	txq->buffer_ring = rte_zmalloc_socket("tx_buffer_ring",
+				sizeof(struct sxe_tx_buffer) * ring_depth,
+				RTE_CACHE_LINE_SIZE, socket_id);
+	if (txq->buffer_ring == NULL) {
+		PMD_LOG_ERR(INIT, "tx buffer alloc failed, queue_id=%d", queue_idx);
+		rte_memzone_free(tz);
+		rte_free(txq);
+		txq = NULL;
+		goto l_end;
+	}
+
+	txq->mz = tz;
+	txq->base_addr = tz->iova;
+	txq->desc_ring = (sxe_tx_data_desc_u *)tz->addr;
+
+l_end:
+	return txq;
+}
+
+s32 __rte_cold sxe_tx_queue_start(struct rte_eth_dev *dev, u16 queue_id)
+{
+	sxe_tx_queue_s *txq = dev->data->tx_queues[queue_id];
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_tx_ring_head_init(hw, txq->reg_idx);
+	sxe_hw_tx_ring_tail_init(hw, txq->reg_idx);
+	sxe_hw_tx_ring_switch(hw, txq->reg_idx, true);
+
+	dev->data->tx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
+	return 0;
+}
+
+s32 __rte_cold sxe_tx_queue_stop(struct rte_eth_dev *dev, u16 queue_id)
+{
+	s32 poll_ms = RTE_SXE_REGISTER_POLL_WAIT_10_MS;
+	u32 head, tail;
+	sxe_tx_queue_s *txq = dev->data->tx_queues[queue_id];
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+
+	PMD_INIT_FUNC_TRACE();
+
+	do {
+		rte_delay_us(RTE_SXE_WAIT_100_US);
+		sxe_hw_tx_ring_info_get(hw, txq->reg_idx, &head, &tail);
+
+	} while (--poll_ms && (head != tail));
+
+	if (!poll_ms) {
+		PMD_LOG_ERR(INIT, "Tx Queue %d is not empty when stopping.",
+				queue_id);
+	}
+
+	sxe_hw_tx_ring_switch(hw, txq->reg_idx, false);
+
+	if (txq->ops != NULL) {
+		txq->ops->mbufs_release(txq);
+		txq->ops->init(txq);
+	}
+	dev->data->tx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+	return 0;
+}
+
+void sxe_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+	struct rte_eth_rxq_info *qinfo)
+{
+	__sxe_rx_queue_info_get(dev, queue_id, qinfo);
+}
+
+s32 __rte_cold sxe_rx_queue_mbufs_alloc(struct sxe_rx_queue *rxq)
+{
+	return __sxe_rx_queue_mbufs_alloc(rxq);
+}
+
+s32 __rte_cold sxe_rx_queue_start(struct rte_eth_dev *dev,
+						u16 queue_id)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	  *hw = &adapter->hw;
+	struct sxe_rx_queue *rxq;
+	u16 reg_idx;
+	s32 ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rxq = dev->data->rx_queues[queue_id];
+	reg_idx = rxq->reg_idx;
+
+	ret = sxe_rx_queue_mbufs_alloc(rxq);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "could not alloc mbuf for queue:%d",
+				 queue_id);
+		goto l_end;
+	}
+
+	sxe_hw_rx_ring_switch(hw, reg_idx, true);
+
+	sxe_hw_rx_queue_desc_reg_configure(hw, reg_idx, 0, rxq->ring_depth - 1);
+	dev->data->rx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STARTED;
+
+l_end:
+	return ret;
+}
+
+static void __rte_cold sxe_rx_queue_sc_mbufs_free(struct rte_mbuf *mbuf)
+{
+	u16 i;
+	u16 num_segs = mbuf->nb_segs;
+	struct rte_mbuf *next_seg;
+
+	for (i = 0; i < num_segs; i++) {
+		next_seg = mbuf->next;
+		rte_pktmbuf_free_seg(mbuf);
+		mbuf = next_seg;
+	}
+}
+
+void __rte_cold sxe_rx_queue_mbufs_free(struct sxe_rx_queue *rxq)
+{
+	u16 i;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	if (rxq->is_using_sse) {
+		sxe_rx_queue_vec_mbufs_release(rxq);
+		return;
+	}
+#endif
+
+	if (rxq->buffer_ring != NULL) {
+		for (i = 0; i < rxq->ring_depth; i++) {
+			if (rxq->buffer_ring[i].mbuf != NULL) {
+				rte_pktmbuf_free_seg(rxq->buffer_ring[i].mbuf);
+				rxq->buffer_ring[i].mbuf = NULL;
+			}
+		}
+		if (rxq->completed_pkts_num) {
+			for (i = 0; i < rxq->completed_pkts_num; ++i) {
+				struct rte_mbuf *mbuf;
+
+				mbuf = rxq->completed_ring[rxq->next_ret_pkg + i];
+				rte_pktmbuf_free_seg(mbuf);
+			}
+			rxq->completed_pkts_num = 0;
+		}
+	}
+
+	if (rxq->sc_buffer_ring) {
+		for (i = 0; i < rxq->ring_depth; i++) {
+			if (rxq->sc_buffer_ring[i].mbuf) {
+				sxe_rx_queue_sc_mbufs_free(rxq->sc_buffer_ring[i].mbuf);
+				rxq->sc_buffer_ring[i].mbuf = NULL;
+			}
+		}
+	}
+}
+
+void __rte_cold sxe_rx_queue_init(bool rx_batch_alloc_allowed,
+						struct sxe_rx_queue *rxq)
+{
+	static const sxe_rx_data_desc_u zeroed_desc = { {0} };
+	u16 i;
+	u16 len = rxq->ring_depth;
+
+	if (rx_batch_alloc_allowed)
+		len += RTE_PMD_SXE_MAX_RX_BURST;
+
+	for (i = 0; i < len; i++)
+		rxq->desc_ring[i] = zeroed_desc;
+
+	memset(&rxq->fake_mbuf, 0, sizeof(rxq->fake_mbuf));
+	for (i = rxq->ring_depth; i < len; ++i)
+		rxq->buffer_ring[i].mbuf = &rxq->fake_mbuf;
+
+	rxq->completed_pkts_num = 0;
+	rxq->next_ret_pkg = 0;
+	rxq->batch_alloc_trigger = rxq->batch_alloc_size - 1;
+	rxq->processing_idx = 0;
+	rxq->hold_num = 0;
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	if (rxq->pkt_first_seg != NULL)
+		rte_pktmbuf_free(rxq->pkt_first_seg);
+
+	rxq->pkt_first_seg = NULL;
+	rxq->pkt_last_seg = NULL;
+
+#if defined(RTE_ARCH_X86)
+	rxq->realloc_start = 0;
+	rxq->realloc_num = 0;
+#endif
+#endif
+}
+
+void __rte_cold sxe_rx_queue_free(struct sxe_rx_queue *rxq)
+{
+	__sxe_rx_queue_free(rxq);
+}
+
+void __rte_cold sxe_rx_queue_release(struct rte_eth_dev *dev,
+					u16 queue_idx)
+{
+	sxe_rx_queue_free(dev->data->rx_queues[queue_idx]);
+}
+
+s32 __rte_cold sxe_rx_queue_stop(struct rte_eth_dev *dev, u16 queue_id)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	struct sxe_rx_queue *rxq;
+	u16 reg_idx;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rxq = dev->data->rx_queues[queue_id];
+	reg_idx = rxq->reg_idx;
+
+	sxe_hw_rx_ring_switch(hw, reg_idx, false);
+
+	rte_delay_us(RTE_SXE_WAIT_100_US);
+
+	sxe_rx_queue_mbufs_free(rxq);
+	sxe_rx_queue_init(adapter->rx_batch_alloc_allowed, rxq);
+	dev->data->rx_queue_state[queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
+
+	return 0;
+}
+
+int sxe_rx_queue_count(void *rx_queue)
+{
+	volatile sxe_rx_data_desc_u *desc;
+	struct sxe_rx_queue *rxq;
+	u32 count = 0;
+
+	rxq = rx_queue;
+
+	desc = &rxq->desc_ring[rxq->processing_idx];
+
+	while ((count < rxq->ring_depth) &&
+		(desc->wb.upper.status_error &
+			rte_cpu_to_le_32(SXE_RXDADV_STAT_DD))) {
+		count += SXE_RXQ_SCAN_INTERVAL;
+		desc  += SXE_RXQ_SCAN_INTERVAL;
+		if (rxq->processing_idx + count >= rxq->ring_depth) {
+			desc = &(rxq->desc_ring[rxq->processing_idx +
+				count - rxq->ring_depth]);
+		}
+	}
+
+	return count;
+}
+
+void __rte_cold sxe_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed)
+{
+	__sxe_txrx_queues_clear(dev, rx_batch_alloc_allowed);
+}
+
+void sxe_queues_free(struct rte_eth_dev *dev)
+{
+	__sxe_queues_free(dev);
+}
+
+const struct sxe_txq_ops sxe_def_txq_ops = {
+	.init			 = sxe_tx_queue_init,
+	.mbufs_release	= sxe_tx_queue_mbufs_release,
+	.buffer_ring_free = sxe_tx_buffer_ring_free,
+};
+
+const struct sxe_txq_ops *sxe_tx_default_ops_get(void)
+{
+	return &sxe_def_txq_ops;
+}
+
+void sxe_multi_queue_tx_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+	u16 pools_num = RTE_ETH_DEV_SRIOV(dev).active;
+	bool sriov_active = !!pools_num;
+	bool vmdq_active = (dev->data->dev_conf.txmode.mq_mode ==
+				RTE_ETH_MQ_TX_VMDQ_ONLY);
+
+	sxe_hw_tx_multi_queue_configure(hw, vmdq_active, sriov_active, pools_num);
+}
+
+
+s32 sxe_queue_rate_limit_set(struct rte_eth_dev *dev,
+					u16 queue_idx, u32 tx_rate)
+{
+	int ret = 0;
+	u32 rf_dec, rf_int, bcnrc_val;
+	u16 link_speed = dev->data->dev_link.link_speed;
+	struct sxe_adapter *adapter = (struct sxe_adapter *)(dev->data->dev_private);
+	struct sxe_hw *hw = &adapter->hw;
+
+	if (queue_idx >= SXE_HW_TXRX_RING_NUM_MAX) {
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	if (tx_rate != 0) {
+		rf_int = (u32)link_speed / (u32)tx_rate;
+		rf_dec = (u32)link_speed % (u32)tx_rate;
+		rf_dec = (rf_dec << SXE_RTTBCNRC_RF_INT_SHIFT) / tx_rate;
+
+		bcnrc_val = SXE_RTTBCNRC_RS_ENA;
+		bcnrc_val |= ((rf_int << SXE_RTTBCNRC_RF_INT_SHIFT) &
+				SXE_RTTBCNRC_RF_INT_MASK);
+		bcnrc_val |= (rf_dec & SXE_RTTBCNRC_RF_DEC_MASK);
+	} else {
+		bcnrc_val = 0;
+	}
+
+	if (dev->data->mtu + SXE_ETH_OVERHEAD >= SXE_MAX_JUMBO_FRAME_SIZE) {
+		sxe_hw_dcb_max_mem_window_set(hw,
+						SXE_MMW_SIZE_JUMBO_FRAME);
+	} else {
+		sxe_hw_dcb_max_mem_window_set(hw, SXE_MMW_SIZE_DEFAULT);
+	}
+
+	sxe_hw_dcb_tx_ring_rate_factor_set(hw, queue_idx, bcnrc_val);
+
+l_end:
+	return ret;
+}
diff --git a/drivers/net/sxe/pf/sxe_queue.h b/drivers/net/sxe/pf/sxe_queue.h
new file mode 100644
index 0000000000..23060f08e8
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_queue.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_QUEUE_H__
+#define __SXE_QUEUE_H__
+
+#include "sxe_queue_common.h"
+
+#define SXE_TXRX_RING_NUM_MAX	 64
+
+#define SXE_TX_MAX_SEG		  40
+
+#define	SXE_MIN_RING_DESC	32
+#define	SXE_MAX_RING_DESC	4096
+
+#define SXE_MMW_SIZE_DEFAULT		0x4
+#define SXE_MMW_SIZE_JUMBO_FRAME	0x14
+#define SXE_MAX_JUMBO_FRAME_SIZE	0x2600
+
+#define SXE_DEFAULT_RX_FREE_THRESH  32
+#define SXE_DEFAULT_RX_PTHRESH	  8
+#define SXE_DEFAULT_RX_HTHRESH	  8
+#define SXE_DEFAULT_RX_WTHRESH	  0
+
+#define SXE_DEFAULT_TX_FREE_THRESH  32
+#define SXE_DEFAULT_TX_PTHRESH	  32
+#define SXE_DEFAULT_TX_HTHRESH	  0
+#define SXE_DEFAULT_TX_WTHRESH	  0
+#define SXE_DEFAULT_TX_RSBIT_THRESH 32
+
+#define SXE_ALIGN			   128
+#define SXE_RX_DESC_RING_ALIGN	(SXE_ALIGN / sizeof(sxe_rx_data_desc_u))
+#define SXE_TX_DESC_RING_ALIGN	(SXE_ALIGN / sizeof(sxe_tx_data_desc_u))
+
+#define SXE_TX_MAX_SEG		  40
+#define RTE_SXE_REGISTER_POLL_WAIT_10_MS  10
+
+typedef union sxe_tx_data_desc sxe_tx_data_desc_u;
+typedef struct sxe_rx_buffer   sxe_rx_buffer_s;
+typedef union sxe_rx_data_desc sxe_rx_data_desc_u;
+typedef struct sxe_tx_queue	sxe_tx_queue_s;
+typedef struct sxe_rx_queue	sxe_rx_queue_s;
+
+struct sxe_tx_context_desc {
+	__le32 vlan_macip_lens;
+	__le32 seqnum_seed;
+	__le32 type_tucmd_mlhl;
+	__le32 mss_l4len_idx;
+};
+
+s32 __rte_cold sxe_txq_arg_validate(struct rte_eth_dev *dev, u16 ring_depth,
+				u16 *rs_thresh, u16 *free_thresh,
+				const struct rte_eth_txconf *tx_conf);
+
+sxe_tx_queue_s * __rte_cold sxe_tx_queue_alloc(struct rte_eth_dev *dev,
+					u16 queue_idx,
+					u16 ring_depth,
+					u32 socket_id);
+
+s32 __rte_cold sxe_tx_queue_start(struct rte_eth_dev *dev, u16 queue_id);
+
+s32 __rte_cold sxe_tx_queue_stop(struct rte_eth_dev *dev, u16 queue_id);
+
+void sxe_rx_queue_info_get(struct rte_eth_dev *dev, u16 queue_id,
+	struct rte_eth_rxq_info *qinfo);
+
+void __rte_cold sxe_rx_queue_release(struct rte_eth_dev *dev,
+					u16 queue_idx);
+
+s32 sxe_rx_queue_start(struct rte_eth_dev *dev, u16 queue_id);
+
+s32 sxe_rx_queue_stop(struct rte_eth_dev *dev, u16 queue_id);
+
+void sxe_rx_queue_init(bool rx_batch_alloc_allowed,
+				sxe_rx_queue_s *rxq);
+
+void sxe_rx_queue_free(sxe_rx_queue_s *rxq);
+
+int sxe_rx_queue_count(void *rx_queue);
+
+s32 sxe_mq_mode_check(struct rte_eth_dev *dev);
+
+void sxe_txrx_queues_clear(struct rte_eth_dev *dev, bool rx_batch_alloc_allowed);
+
+void sxe_queues_free(struct rte_eth_dev *dev);
+
+void __rte_cold sxe_tx_queue_release(struct rte_eth_dev *dev,
+					u16 queue_idx);
+
+void sxe_multi_queue_tx_configure(struct rte_eth_dev *dev);
+
+void sxe_tx_queue_info_get(struct rte_eth_dev *dev, uint16_t queue_id,
+		struct rte_eth_txq_info *q_info);
+
+void sxe_recycle_rxq_info_get(struct rte_eth_dev *dev, u16 queue_id,
+		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
+
+u16 sxe_pkts_simple_xmit(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
+		struct rte_eth_recycle_rxq_info *recycle_rxq_info);
+#endif
+
+u16 sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
+			   u16 pkts_num);
+#endif
+
+u16 sxe_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num);
+
+u16 sxe_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num);
+
+int sxe_tx_descriptor_status(void *tx_queue, u16 offset);
+
+s32 sxe_queue_rate_limit_set(struct rte_eth_dev *dev,
+					u16 queue_idx, u32 tx_rate);
+
+const struct sxe_txq_ops *sxe_tx_default_ops_get(void);
+
+s32 __rte_cold sxe_rx_queue_mbufs_alloc(sxe_rx_queue_s *rxq);
+
+void __rte_cold sxe_tx_queue_free(sxe_tx_queue_s *txq);
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+s32 sxe_sriov_mq_mode_check(struct rte_eth_dev *dev);
+
+#endif
+
+void __rte_cold sxe_rx_queue_mbufs_free(sxe_rx_queue_s *rxq);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_rx.c b/drivers/net/sxe/pf/sxe_rx.c
new file mode 100644
index 0000000000..b11438d547
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_rx.c
@@ -0,0 +1,1459 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#include <rte_memory.h>
+#include <rte_memzone.h>
+#include <rte_mbuf.h>
+#include <rte_prefetch.h>
+#include <rte_malloc.h>
+#include <rte_atomic.h>
+#include <ethdev_driver.h>
+#include "sxe_ethdev.h"
+
+#include "sxe.h"
+#include "sxe_rx.h"
+#include "sxe_logs.h"
+#include "sxe_hw.h"
+#include "sxe_queue.h"
+#include "sxe_offload.h"
+#include "sxe_dcb.h"
+#include "sxe_queue_common.h"
+#include "sxe_vf.h"
+#include "sxe_errno.h"
+#include "sxe_irq.h"
+#include "sxe_ethdev.h"
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include "sxe_vec_common.h"
+#endif
+#include "sxe_rx_common.h"
+
+#define SXE_LRO_HDR_SIZE				128
+
+#define SXE_PACKET_TYPE_ETHER				0x00
+#define SXE_PACKET_TYPE_IPV4				0x01
+#define SXE_PACKET_TYPE_IPV4_TCP			0x11
+#define SXE_PACKET_TYPE_IPV4_UDP			0x21
+#define SXE_PACKET_TYPE_IPV4_SCTP			0x41
+#define SXE_PACKET_TYPE_IPV4_EXT			0x03
+#define SXE_PACKET_TYPE_IPV4_EXT_TCP			0x13
+#define SXE_PACKET_TYPE_IPV4_EXT_UDP			0x23
+#define SXE_PACKET_TYPE_IPV4_EXT_SCTP			0x43
+#define SXE_PACKET_TYPE_IPV6				0x04
+#define SXE_PACKET_TYPE_IPV6_TCP			0x14
+#define SXE_PACKET_TYPE_IPV6_UDP			0x24
+#define SXE_PACKET_TYPE_IPV6_SCTP			0x44
+#define SXE_PACKET_TYPE_IPV6_EXT			0x0C
+#define SXE_PACKET_TYPE_IPV6_EXT_TCP			0x1C
+#define SXE_PACKET_TYPE_IPV6_EXT_UDP			0x2C
+#define SXE_PACKET_TYPE_IPV6_EXT_SCTP			0x4C
+#define SXE_PACKET_TYPE_IPV4_IPV6			0x05
+#define SXE_PACKET_TYPE_IPV4_IPV6_TCP			0x15
+#define SXE_PACKET_TYPE_IPV4_IPV6_UDP			0x25
+#define SXE_PACKET_TYPE_IPV4_IPV6_SCTP			0x45
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6			0x07
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_TCP		0x17
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_UDP		0x27
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_SCTP		0x47
+#define SXE_PACKET_TYPE_IPV4_IPV6_EXT			0x0D
+#define SXE_PACKET_TYPE_IPV4_IPV6_EXT_TCP		0x1D
+#define SXE_PACKET_TYPE_IPV4_IPV6_EXT_UDP		0x2D
+#define SXE_PACKET_TYPE_IPV4_IPV6_EXT_SCTP		0x4D
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT		0x0F
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_TCP		0x1F
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_UDP		0x2F
+#define SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_SCTP		0x4F
+
+#define SXE_PACKET_TYPE_NVGRE				   0x00
+#define SXE_PACKET_TYPE_NVGRE_IPV4			  0x01
+#define SXE_PACKET_TYPE_NVGRE_IPV4_TCP		  0x11
+#define SXE_PACKET_TYPE_NVGRE_IPV4_UDP		  0x21
+#define SXE_PACKET_TYPE_NVGRE_IPV4_SCTP		 0x41
+#define SXE_PACKET_TYPE_NVGRE_IPV4_EXT		  0x03
+#define SXE_PACKET_TYPE_NVGRE_IPV4_EXT_TCP	  0x13
+#define SXE_PACKET_TYPE_NVGRE_IPV4_EXT_UDP	  0x23
+#define SXE_PACKET_TYPE_NVGRE_IPV4_EXT_SCTP	 0x43
+#define SXE_PACKET_TYPE_NVGRE_IPV6			  0x04
+#define SXE_PACKET_TYPE_NVGRE_IPV6_TCP		  0x14
+#define SXE_PACKET_TYPE_NVGRE_IPV6_UDP		  0x24
+#define SXE_PACKET_TYPE_NVGRE_IPV6_SCTP		 0x44
+#define SXE_PACKET_TYPE_NVGRE_IPV6_EXT		  0x0C
+#define SXE_PACKET_TYPE_NVGRE_IPV6_EXT_TCP	  0x1C
+#define SXE_PACKET_TYPE_NVGRE_IPV6_EXT_UDP	  0x2C
+#define SXE_PACKET_TYPE_NVGRE_IPV6_EXT_SCTP	 0x4C
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6		 0x05
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_TCP	 0x15
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_UDP	 0x25
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT	 0x0D
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT_TCP 0x1D
+#define SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT_UDP 0x2D
+
+#define SXE_PACKET_TYPE_VXLAN				   0x80
+#define SXE_PACKET_TYPE_VXLAN_IPV4			  0x81
+#define SXE_PACKET_TYPE_VXLAN_IPV4_TCP		  0x91
+#define SXE_PACKET_TYPE_VXLAN_IPV4_UDP		  0xA1
+#define SXE_PACKET_TYPE_VXLAN_IPV4_SCTP		 0xC1
+#define SXE_PACKET_TYPE_VXLAN_IPV4_EXT		  0x83
+#define SXE_PACKET_TYPE_VXLAN_IPV4_EXT_TCP	  0x93
+#define SXE_PACKET_TYPE_VXLAN_IPV4_EXT_UDP	  0xA3
+#define SXE_PACKET_TYPE_VXLAN_IPV4_EXT_SCTP	 0xC3
+#define SXE_PACKET_TYPE_VXLAN_IPV6			  0x84
+#define SXE_PACKET_TYPE_VXLAN_IPV6_TCP		  0x94
+#define SXE_PACKET_TYPE_VXLAN_IPV6_UDP		  0xA4
+#define SXE_PACKET_TYPE_VXLAN_IPV6_SCTP		 0xC4
+#define SXE_PACKET_TYPE_VXLAN_IPV6_EXT		  0x8C
+#define SXE_PACKET_TYPE_VXLAN_IPV6_EXT_TCP	  0x9C
+#define SXE_PACKET_TYPE_VXLAN_IPV6_EXT_UDP	  0xAC
+#define SXE_PACKET_TYPE_VXLAN_IPV6_EXT_SCTP	 0xCC
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6		 0x85
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_TCP	 0x95
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_UDP	 0xA5
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT	 0x8D
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT_TCP 0x9D
+#define SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT_UDP 0xAD
+
+
+const alignas(RTE_CACHE_LINE_SIZE) u32 sxe_ptype_table[SXE_PACKET_TYPE_MAX] = {
+	[SXE_PACKET_TYPE_ETHER] = RTE_PTYPE_L2_ETHER,
+	[SXE_PACKET_TYPE_IPV4] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4,
+	[SXE_PACKET_TYPE_IPV4_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV4_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT,
+	[SXE_PACKET_TYPE_IPV4_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6,
+	[SXE_PACKET_TYPE_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP,
+	[SXE_PACKET_TYPE_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP,
+	[SXE_PACKET_TYPE_IPV6_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6_EXT,
+	[SXE_PACKET_TYPE_IPV6_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_TCP,
+	[SXE_PACKET_TYPE_IPV6_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_UDP,
+	[SXE_PACKET_TYPE_IPV6_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV6_EXT | RTE_PTYPE_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV4_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6,
+	[SXE_PACKET_TYPE_IPV4_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+	RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_IPV6_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV4_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT,
+	[SXE_PACKET_TYPE_IPV4_IPV6_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_IPV6_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_IPV6_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_IPV4_EXT_IPV6_EXT_SCTP] =
+		RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_TUNNEL_IP |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_SCTP,
+};
+
+
+const alignas(RTE_CACHE_LINE_SIZE) u32 sxe_ptype_table_tn[SXE_PACKET_TYPE_TN_MAX] = {
+
+	[SXE_PACKET_TYPE_NVGRE] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER,
+	[SXE_PACKET_TYPE_NVGRE_IPV4] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4_EXT,
+	[SXE_PACKET_TYPE_NVGRE_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6_EXT,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4 |
+		RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6 |
+		RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6_EXT |
+		RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT_TCP] =
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		RTE_PTYPE_TUNNEL_GRE | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4 |
+		RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6 |
+		RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6 |
+		RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6_EXT |
+		RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_NVGRE_IPV6_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV6_EXT |
+		RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_IPV6_EXT_UDP] =
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		RTE_PTYPE_TUNNEL_GRE | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4 |
+		RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4_EXT |
+		RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4_EXT |
+		RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_NVGRE_IPV4_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_TUNNEL_GRE |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4_EXT |
+		RTE_PTYPE_INNER_L4_UDP,
+
+	[SXE_PACKET_TYPE_VXLAN] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER,
+	[SXE_PACKET_TYPE_VXLAN_IPV4] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4_EXT,
+	[SXE_PACKET_TYPE_VXLAN_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6_EXT,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4 | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT_TCP] =
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		RTE_PTYPE_L4_UDP | RTE_PTYPE_TUNNEL_VXLAN |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4 | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6 | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_UDP,
+	[SXE_PACKET_TYPE_VXLAN_IPV6_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV6_EXT | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_IPV6_EXT_UDP] =
+		RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4_EXT_UNKNOWN |
+		RTE_PTYPE_L4_UDP | RTE_PTYPE_TUNNEL_VXLAN |
+		RTE_PTYPE_INNER_L2_ETHER | RTE_PTYPE_INNER_L3_IPV4,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4 | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4_EXT | RTE_PTYPE_INNER_L4_SCTP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_EXT_TCP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4_EXT | RTE_PTYPE_INNER_L4_TCP,
+	[SXE_PACKET_TYPE_VXLAN_IPV4_EXT_UDP] = RTE_PTYPE_L2_ETHER |
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN | RTE_PTYPE_L4_UDP |
+		RTE_PTYPE_TUNNEL_VXLAN | RTE_PTYPE_INNER_L2_ETHER |
+		RTE_PTYPE_INNER_L3_IPV4_EXT | RTE_PTYPE_INNER_L4_UDP,
+};
+
+void sxe_rx_mbuf_common_header_fill(sxe_rx_queue_s *rxq,
+					struct rte_mbuf *mbuf,
+					volatile union sxe_rx_data_desc desc,
+					u32 pkt_info, u32 staterr)
+{
+	u64 pkt_flags;
+	u64 vlan_flags = rxq->vlan_flags;
+
+	LOG_DEBUG("port_id=%u, rxq=%u, desc.lower=0x%" SXE_PRIX64 ", upper=0x%" SXE_PRIX64 ","
+			"pkt_info=0x%x, staterr=0x%x",
+			rxq->port_id, rxq->queue_id,
+			rte_le_to_cpu_64(desc.read.pkt_addr),
+			rte_le_to_cpu_64(desc.read.hdr_addr),
+			pkt_info, staterr);
+
+	mbuf->port = rxq->port_id;
+
+	mbuf->vlan_tci = rte_le_to_cpu_16(desc.wb.upper.vlan);
+
+	pkt_flags = sxe_rx_desc_status_to_pkt_flags(staterr, vlan_flags);
+	pkt_flags |= sxe_rx_desc_error_to_pkt_flags(staterr);
+	pkt_flags |= sxe_rx_desc_pkt_info_to_pkt_flags((u16)pkt_info);
+
+	if (pkt_flags & (RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD)) {
+		rxq->rx_stats.csum_err++;
+		LOG_WARN("pkt_flags:0x%" SXE_PRIX64 " rx checksum error",
+				pkt_flags);
+	}
+
+	mbuf->ol_flags = pkt_flags;
+	mbuf->packet_type =
+		sxe_rxd_pkt_info_to_pkt_type(pkt_info,
+						rxq->pkt_type_mask);
+
+	if (likely(pkt_flags & RTE_MBUF_F_RX_RSS_HASH)) {
+		mbuf->hash.rss =
+				rte_le_to_cpu_32(desc.wb.lower.hi_dword.rss);
+	} else if (pkt_flags & RTE_MBUF_F_RX_FDIR) {
+		mbuf->hash.fdir.hash =
+				rte_le_to_cpu_16(desc.wb.lower.hi_dword.csum_ip.csum) &
+				SXE_SAMPLE_HASH_MASK;
+		mbuf->hash.fdir.id =
+				rte_le_to_cpu_16(desc.wb.lower.hi_dword.csum_ip.ip_id);
+	}
+}
+
+static inline void sxe_rx_resource_prefetch(u16 next_idx,
+				sxe_rx_buffer_s *buf_ring,
+				volatile union sxe_rx_data_desc *desc_ring)
+{
+	/* preftech next mbuf */
+	rte_sxe_prefetch(buf_ring[next_idx].mbuf);
+
+	if ((next_idx & 0x3) == 0) {
+		rte_sxe_prefetch(&desc_ring[next_idx]);
+		rte_sxe_prefetch(&buf_ring[next_idx]);
+	}
+}
+
+u16 sxe_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts,
+		u16 pkts_num)
+{
+	return __sxe_pkts_recv(rx_queue, rx_pkts, pkts_num);
+}
+
+static inline u16 sxe_ret_pkts_to_user(sxe_rx_queue_s *rxq,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num)
+{
+	struct rte_mbuf **completed_mbuf = &rxq->completed_ring[rxq->next_ret_pkg];
+	u16 i;
+
+	pkts_num = (u16)RTE_MIN(pkts_num, rxq->completed_pkts_num);
+
+	for (i = 0; i < pkts_num; ++i)
+		rx_pkts[i] = completed_mbuf[i];
+
+	/* Update completed packets num and next available position */
+	rxq->completed_pkts_num = (u16)(rxq->completed_pkts_num - pkts_num);
+	rxq->next_ret_pkg = (u16)(rxq->next_ret_pkg + pkts_num);
+
+	return pkts_num;
+}
+
+#define LOOK_AHEAD 8
+#if (LOOK_AHEAD != 8)
+#error "PMD SXE: LOOK_AHEAD must be 8"
+#endif
+
+static inline u16 sxe_rx_hw_ring_scan(sxe_rx_queue_s *rxq)
+{
+	volatile union sxe_rx_data_desc *rx_desc;
+	sxe_rx_buffer_s *rx_buf;
+	struct rte_mbuf *cur_mb;
+	u16 num_dd_set;
+	u32 status_arr[LOOK_AHEAD];
+	u32 pkt_info[LOOK_AHEAD];
+	u16 i, j;
+	u32 status;
+	u16 done_num = 0;
+	u16 pkt_len;
+
+	/* Obtain the desc and rx buff to be processed  */
+	rx_desc = &rxq->desc_ring[rxq->processing_idx];
+	rx_buf = &rxq->buffer_ring[rxq->processing_idx];
+
+	status = rx_desc->wb.upper.status_error;
+
+	if (!(status & rte_cpu_to_le_32(SXE_RXDADV_STAT_DD)))
+		goto l_end;
+
+	for (i = 0; i < RTE_PMD_SXE_MAX_RX_BURST;
+		i += LOOK_AHEAD, rx_desc += LOOK_AHEAD, rx_buf += LOOK_AHEAD) {
+		for (j = 0; j < LOOK_AHEAD; j++)
+			status_arr[j] = rte_le_to_cpu_32(rx_desc[j].wb.upper.status_error);
+
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+
+		for (num_dd_set = 0; num_dd_set < LOOK_AHEAD &&
+			(status_arr[num_dd_set] & SXE_RXDADV_STAT_DD);
+			num_dd_set++) {
+			;
+		}
+
+		for (j = 0; j < num_dd_set; j++)
+			pkt_info[j] = rte_le_to_cpu_32(rx_desc[j].wb.lower.lo_dword.data);
+
+		done_num += num_dd_set;
+
+		for (j = 0; j < num_dd_set; ++j) {
+			cur_mb = rx_buf[j].mbuf;
+
+			pkt_len = (u16)(rte_le_to_cpu_16(rx_desc[j].wb.upper.length) -
+							rxq->crc_len);
+			cur_mb->pkt_len = pkt_len;
+			cur_mb->data_len = pkt_len;
+			sxe_rx_mbuf_common_header_fill(rxq, cur_mb, rx_desc[j],
+						pkt_info[j], status_arr[j]);
+		}
+
+		for (j = 0; j < LOOK_AHEAD; ++j)
+			rxq->completed_ring[i + j] = rx_buf[j].mbuf;
+
+		if (num_dd_set != LOOK_AHEAD)
+			break;
+	}
+
+	for (i = 0; i < done_num; ++i)
+		rxq->buffer_ring[rxq->processing_idx + i].mbuf = NULL;
+
+l_end:
+	return done_num;
+}
+
+static inline s32 sxe_rx_bufs_batch_alloc(sxe_rx_queue_s *rxq,
+							bool reset_mbuf)
+{
+	volatile union sxe_rx_data_desc *desc_ring;
+	sxe_rx_buffer_s *buf_ring;
+	struct rte_mbuf *mbuf;
+	u16 alloc_idx;
+	__le64 dma_addr;
+	s32 diag, i;
+	s32 ret = 0;
+
+	alloc_idx = rxq->batch_alloc_trigger - (rxq->batch_alloc_size - 1);
+	buf_ring = &rxq->buffer_ring[alloc_idx];
+
+	LOG_DEBUG("port_id=%u, rxq=%u, alloc_idx=%u, "
+			"batch_alloc_trigger=%u, batch_alloc_size=%u",
+			rxq->port_id, rxq->queue_id, alloc_idx,
+			rxq->batch_alloc_trigger, rxq->batch_alloc_size);
+
+	diag = rte_mempool_get_bulk(rxq->mb_pool, (void *)buf_ring,
+					rxq->batch_alloc_size);
+	if (unlikely(diag != 0)) {
+		LOG_DEBUG("port_id=%u, rxq=%u buffer alloc failed",
+				rxq->port_id, rxq->queue_id);
+		ret = -ENOMEM;
+		goto l_end;
+	}
+
+	desc_ring = &rxq->desc_ring[alloc_idx];
+	for (i = 0; i < rxq->batch_alloc_size; ++i) {
+		mbuf = buf_ring[i].mbuf;
+		if (reset_mbuf)
+			mbuf->port = rxq->port_id;
+
+		rte_mbuf_refcnt_set(mbuf, 1);
+		mbuf->data_off = RTE_PKTMBUF_HEADROOM;
+
+		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		desc_ring[i].read.hdr_addr = 0;
+		desc_ring[i].read.pkt_addr = dma_addr;
+	}
+
+	rxq->batch_alloc_trigger = rxq->batch_alloc_trigger + rxq->batch_alloc_size;
+	if (rxq->batch_alloc_trigger >= rxq->ring_depth)
+		rxq->batch_alloc_trigger = rxq->batch_alloc_size - 1;
+
+l_end:
+	return ret;
+}
+
+static inline u16 sxe_burst_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num)
+{
+	sxe_rx_queue_s *rxq = (sxe_rx_queue_s *)rx_queue;
+	u16 done_num;
+
+	if (rxq->completed_pkts_num) {
+		done_num = sxe_ret_pkts_to_user(rxq, rx_pkts, pkts_num);
+		LOG_DEBUG("there are %u mbuf in completed ring "
+				"of queue[%u] return to user, done_num=%u",
+				rxq->completed_pkts_num,
+				rxq->queue_id, done_num);
+		goto l_end;
+	}
+
+	done_num = (u16)sxe_rx_hw_ring_scan(rxq);
+
+	rxq->next_ret_pkg = 0;
+	rxq->completed_pkts_num = done_num;
+	rxq->processing_idx = (u16)(rxq->processing_idx + done_num);
+
+	if (rxq->processing_idx > rxq->batch_alloc_trigger) {
+		u16 alloced_idx = rxq->batch_alloc_trigger;
+
+		if (sxe_rx_bufs_batch_alloc(rxq, true) != 0) {
+			u32 i, j;
+
+			LOG_ERROR("rx mbuf alloc failed port_id=%u "
+					"queue_id=%u", (unsigned int)rxq->port_id,
+					(u16)rxq->queue_id);
+
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed +=
+				rxq->batch_alloc_size;
+
+			rxq->completed_pkts_num = 0;
+			rxq->processing_idx = (u16)(rxq->processing_idx - done_num);
+			for (i = 0, j = rxq->processing_idx; i < done_num; ++i, ++j)
+				rxq->buffer_ring[j].mbuf = rxq->completed_ring[i];
+
+			done_num = 0;
+			goto l_end;
+		}
+
+		rte_wmb();
+		SXE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr, alloced_idx);
+	}
+
+	if (rxq->processing_idx >= rxq->ring_depth)
+		rxq->processing_idx = 0;
+
+	if (rxq->completed_pkts_num) {
+		done_num = sxe_ret_pkts_to_user(rxq, rx_pkts, pkts_num);
+		LOG_DEBUG("there are %u mbuf in completed ring "
+				"of queue[%u] return to user, done_num=%u",
+				rxq->completed_pkts_num,
+				rxq->queue_id, done_num);
+	}
+
+l_end:
+	return done_num;
+}
+
+u16 sxe_batch_alloc_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num)
+{
+	u16 done_num;
+
+	if (unlikely(pkts_num == 0)) {
+		LOG_DEBUG("user need pkts = 0");
+		done_num = 0;
+		goto l_end;
+	}
+
+	if (likely(pkts_num <= RTE_PMD_SXE_MAX_RX_BURST)) {
+		done_num = sxe_burst_pkts_recv(rx_queue, rx_pkts, pkts_num);
+		goto l_end;
+	}
+
+	done_num = 0;
+	while (pkts_num) {
+		u16 ret, n;
+
+		n = (u16)RTE_MIN(pkts_num, RTE_PMD_SXE_MAX_RX_BURST);
+		ret = sxe_burst_pkts_recv(rx_queue, &rx_pkts[done_num], n);
+		done_num = (u16)(done_num + ret);
+		pkts_num = (u16)(pkts_num - ret);
+		if (ret < n)
+			break;
+	}
+
+l_end:
+	return done_num;
+}
+
+static inline s32 sxe_lro_new_mbufs_alloc(sxe_rx_queue_s *rxq,
+					struct rte_mbuf **new_mbuf,
+					u16 *hold_num, bool batch_alloc)
+{
+	s32 ret = 0;
+
+	LOG_DEBUG("rxq[%u] %s alloc mem, current num_hold=%u",
+			rxq->queue_id, batch_alloc ? "batch" : "single", *hold_num);
+	if (!batch_alloc) {
+		*new_mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
+		if (*new_mbuf == NULL) {
+			LOG_DEBUG("RX mbuf alloc failed "
+				"port_id=%u queue_id=%u",
+				rxq->port_id, rxq->queue_id);
+
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+			ret = -ENOMEM;
+			goto l_end;
+		}
+
+		(*new_mbuf)->data_off = RTE_PKTMBUF_HEADROOM;
+	} else if (*hold_num > rxq->batch_alloc_size) {
+		u16 next_rdt = rxq->batch_alloc_trigger;
+
+		if (!sxe_rx_bufs_batch_alloc(rxq, false)) {
+			rte_wmb();
+			SXE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr,
+						next_rdt);
+
+			*hold_num -= rxq->batch_alloc_size;
+		} else {
+			LOG_DEBUG("RX bulk alloc failed "
+					"port_id=%u queue_id=%u",
+					rxq->port_id, rxq->queue_id);
+
+			rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
+			ret = -ENOMEM;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+static inline void sxe_rx_resource_update(sxe_rx_buffer_s *rx_buf,
+				volatile union sxe_rx_data_desc *cur_desc,
+				struct rte_mbuf *new_mbuf, bool batch_alloc)
+{
+	LOG_DEBUG("%s update resource, new_mbuf=%p",
+				batch_alloc ? "batch" : "single", cur_desc);
+
+	if (!batch_alloc) {
+		__le64 dma =
+		  rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mbuf));
+		rx_buf->mbuf = new_mbuf;
+		cur_desc->read.hdr_addr = 0;
+		cur_desc->read.pkt_addr = dma;
+	} else {
+		rx_buf->mbuf = NULL;
+	}
+}
+
+static inline u16 sxe_rx_next_idx_get(union sxe_rx_data_desc *desc,
+						u16 next_idx)
+{
+	u16 nextp_id;
+	u32 staterr = rte_le_to_cpu_32(desc->wb.upper.status_error);
+
+
+	if (sxe_lro_count(desc)) {
+		nextp_id =
+			(staterr & SXE_RXDADV_NEXTP_MASK) >>
+			SXE_RXDADV_NEXTP_SHIFT;
+	} else {
+		nextp_id = next_idx;
+	}
+	LOG_DEBUG("next idx = %u", nextp_id);
+	return nextp_id;
+}
+
+static inline void sxe_lro_first_seg_update(struct rte_mbuf **first_seg,
+						struct rte_mbuf *cur_mbuf,
+						u16 data_len)
+{
+	if (*first_seg == NULL) {
+		(*first_seg) = cur_mbuf;
+		(*first_seg)->pkt_len = data_len;
+		(*first_seg)->nb_segs = 1;
+	} else {
+		(*first_seg)->pkt_len += data_len;
+		(*first_seg)->nb_segs++;
+	}
+}
+
+static inline void sxe_mbuf_fields_process(struct rte_mbuf *first_seg,
+					sxe_rx_queue_s *rxq,
+					union sxe_rx_data_desc desc,
+					struct rte_mbuf *cur_mbuf,
+					u32 staterr)
+{
+	u32 pkt_info;
+
+	pkt_info = rte_le_to_cpu_32(desc.wb.lower.lo_dword.data);
+	sxe_rx_mbuf_common_header_fill(rxq, first_seg, desc,
+					pkt_info, staterr);
+
+	first_seg->pkt_len -= rxq->crc_len;
+	if (unlikely(cur_mbuf->data_len <= rxq->crc_len)) {
+		struct rte_mbuf *lp;
+
+		for (lp = first_seg; lp->next != cur_mbuf; lp = lp->next)
+			;
+
+		first_seg->nb_segs--;
+		lp->data_len -= rxq->crc_len - cur_mbuf->data_len;
+		lp->next = NULL;
+		rte_pktmbuf_free_seg(cur_mbuf);
+	} else {
+		cur_mbuf->data_len -= rxq->crc_len;
+	}
+
+	rte_packet_prefetch((u8 *)first_seg->buf_addr + first_seg->data_off);
+}
+
+static inline u16 sxe_lro_pkts_recv(void *rx_queue,
+			struct rte_mbuf **rx_pkts, u16 pkts_num,
+			bool batch_alloc)
+{
+	sxe_rx_queue_s *rxq = rx_queue;
+	volatile union sxe_rx_data_desc *desc_ring = rxq->desc_ring;
+	sxe_rx_buffer_s *buf_ring = rxq->buffer_ring;
+	sxe_rx_buffer_s *sc_buf_ring = rxq->sc_buffer_ring;
+	u16 cur_idx = rxq->processing_idx;
+	u16 done_num = 0;
+	u16 hold_num = rxq->hold_num;
+	u16 prev_idx = rxq->processing_idx;
+	s32 err;
+
+	while (done_num < pkts_num) {
+		bool is_eop;
+		sxe_rx_buffer_s *rx_buf;
+		sxe_rx_buffer_s *sc_rx_buf;
+		sxe_rx_buffer_s *next_sc_rx_buf = NULL;
+		sxe_rx_buffer_s *next_rx_buf = NULL;
+		struct rte_mbuf *first_seg;
+		struct rte_mbuf *cur_mbuf;
+		struct rte_mbuf *new_mbuf = NULL;
+		union sxe_rx_data_desc desc_copy;
+		u16 data_len;
+		u16 next_idx;
+		volatile union sxe_rx_data_desc *cur_desc;
+		u32 staterr;
+
+next_desc:
+		cur_desc = &desc_ring[cur_idx];
+		staterr = rte_le_to_cpu_32(cur_desc->wb.upper.status_error);
+
+		if (!(staterr & SXE_RXDADV_STAT_DD))
+			break;
+
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+
+
+		desc_copy = *cur_desc;
+
+		LOG_DEBUG("port_id=%u queue_id=%u cur_idx=%u "
+				"staterr=0x%x data_len=%u",
+				rxq->port_id, rxq->queue_id, cur_idx, staterr,
+				rte_le_to_cpu_16(desc_copy.wb.upper.length));
+
+		err = sxe_lro_new_mbufs_alloc(rxq, &new_mbuf, &hold_num, batch_alloc);
+		if (err) {
+			LOG_ERROR("mbuf %s alloc failed",
+					batch_alloc ? "batch" : "single");
+			break;
+		}
+
+		hold_num++;
+		rx_buf = &buf_ring[cur_idx];
+		is_eop = !!(staterr & SXE_RXDADV_STAT_EOP);
+
+		next_idx = cur_idx + 1;
+		if (next_idx == rxq->ring_depth)
+			next_idx = 0;
+
+		sxe_rx_resource_prefetch(next_idx, buf_ring, desc_ring);
+
+		cur_mbuf = rx_buf->mbuf;
+
+		sxe_rx_resource_update(rx_buf, cur_desc, new_mbuf, batch_alloc);
+
+		data_len = rte_le_to_cpu_16(desc_copy.wb.upper.length);
+		cur_mbuf->data_len = data_len;
+
+		if (!is_eop) {
+			u16 nextp_id = sxe_rx_next_idx_get(&desc_copy, next_idx);
+
+			next_sc_rx_buf = &sc_buf_ring[nextp_id];
+			next_rx_buf = &buf_ring[nextp_id];
+			rte_sxe_prefetch(next_rx_buf);
+		}
+
+		sc_rx_buf = &sc_buf_ring[cur_idx];
+		first_seg = sc_rx_buf->mbuf;
+		sc_rx_buf->mbuf = NULL;
+
+		sxe_lro_first_seg_update(&first_seg, cur_mbuf, data_len);
+
+		prev_idx = cur_idx;
+		cur_idx = next_idx;
+
+		if (!is_eop && next_rx_buf) {
+			cur_mbuf->next = next_rx_buf->mbuf;
+			next_sc_rx_buf->mbuf = first_seg;
+			goto next_desc;
+		}
+
+		sxe_mbuf_fields_process(first_seg, rxq, desc_copy, cur_mbuf, staterr);
+
+		rx_pkts[done_num++] = first_seg;
+	}
+
+	rxq->processing_idx = cur_idx;
+
+	if (!batch_alloc && hold_num > rxq->batch_alloc_size) {
+		LOG_DEBUG("port_id=%u queue_id=%u rx_tail=%u "
+			   "num_hold=%u done_num=%u",
+			   rxq->port_id, rxq->queue_id,
+			   cur_idx, hold_num, done_num);
+
+		rte_wmb();
+		SXE_PCI_REG_WC_WRITE_RELAXED(rxq->rdt_reg_addr, prev_idx);
+		hold_num = 0;
+	}
+
+	rxq->hold_num = hold_num;
+	return done_num;
+}
+
+u16 sxe_batch_alloc_lro_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num)
+{
+	return sxe_lro_pkts_recv(rx_queue, rx_pkts, pkts_num, true);
+}
+
+u16 sxe_single_alloc_lro_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num)
+{
+	return sxe_lro_pkts_recv(rx_queue, rx_pkts, pkts_num, false);
+}
+
+void __rte_cold sxe_rx_function_set(struct rte_eth_dev *dev,
+	bool rx_batch_alloc_allowed, bool *rx_vec_allowed)
+{
+	__sxe_rx_function_set(dev, rx_batch_alloc_allowed, rx_vec_allowed);
+}
+
+s32 sxe_rx_descriptor_status(void *rx_queue, u16 offset)
+{
+	int ret = RTE_ETH_RX_DESC_AVAIL;
+	sxe_rx_queue_s *rxq = rx_queue;
+	volatile u32 *status;
+	u32 hold_num, desc;
+
+	if (unlikely(offset >= rxq->ring_depth)) {
+		LOG_DEBUG("rx queue[%u] get desc status err,"
+			"offset=%u >= ring_depth=%u",
+			rxq->queue_id, offset, rxq->ring_depth);
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86)
+	if (rxq->is_using_sse)
+		hold_num = rxq->realloc_num;
+	else
+#endif
+#endif
+
+		hold_num = rxq->hold_num;
+	if (offset >= rxq->ring_depth - hold_num) {
+		ret = RTE_ETH_RX_DESC_UNAVAIL;
+		goto l_end;
+	}
+
+	desc = rxq->processing_idx + offset;
+	if (desc >= rxq->ring_depth)
+		desc -= rxq->ring_depth;
+
+	status = &rxq->desc_ring[desc].wb.upper.status_error;
+	if (*status & rte_cpu_to_le_32(SXE_RXDADV_STAT_DD))
+		ret =  RTE_ETH_RX_DESC_DONE;
+
+l_end:
+	LOG_DEBUG("rx queue[%u] get desc status=%d", rxq->queue_id, ret);
+	return ret;
+}
+
+s32 __rte_cold sxe_rx_queue_setup(struct rte_eth_dev *dev,
+			 u16 queue_idx, u16 desc_num,
+			 unsigned int socket_id,
+			 const struct rte_eth_rxconf *rx_conf,
+			 struct rte_mempool *mp)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	struct rx_setup rx_setup = { 0 };
+	s32 ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rx_setup.desc_num = desc_num;
+	rx_setup.queue_idx = queue_idx;
+	rx_setup.socket_id = socket_id;
+	rx_setup.mp = mp;
+	rx_setup.dev = dev;
+	rx_setup.reg_base_addr = hw->reg_base_addr;
+	rx_setup.rx_conf = rx_conf;
+	rx_setup.rx_batch_alloc_allowed = &adapter->rx_batch_alloc_allowed;
+
+	ret = __sxe_rx_queue_setup(&rx_setup, false);
+	if (ret)
+		LOG_ERROR_BDF("rx queue setup fail.(err:%d)", ret);
+
+	return ret;
+}
+
+static void sxe_rx_mode_configure(struct sxe_hw *hw)
+{
+	u32 flt_ctrl;
+
+	flt_ctrl = sxe_hw_rx_mode_get(hw);
+	LOG_DEBUG("read flt_ctrl=%u", flt_ctrl);
+	flt_ctrl |= SXE_FCTRL_BAM;
+	flt_ctrl |= SXE_FCTRL_DPF;
+	flt_ctrl |= SXE_FCTRL_PMCF;
+	LOG_DEBUG("write flt_ctrl=0x%x", flt_ctrl);
+	sxe_hw_rx_mode_set(hw, flt_ctrl);
+}
+
+static inline void
+	sxe_rx_queue_offload_configure(struct rte_eth_dev *dev)
+{
+	u16 i;
+	sxe_rx_queue_s *rxq;
+	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+
+		if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
+			rxq->crc_len = RTE_ETHER_CRC_LEN;
+		else
+			rxq->crc_len = 0;
+
+		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rx_conf->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	}
+}
+
+static inline void
+	sxe_rx_offload_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	bool ip_csum_offload;
+
+	sxe_hw_rx_dma_ctrl_init(hw);
+
+
+	if (dev->data->mtu > RTE_ETHER_MTU)
+		adapter->mtu = dev->data->mtu;
+
+	rx_conf->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+
+	if (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
+		dev->data->scattered_rx = 1;
+
+	sxe_hw_rx_udp_frag_checksum_disable(hw);
+
+	if (rx_conf->offloads & DEV_RX_OFFLOAD_CHECKSUM)
+		ip_csum_offload = true;
+	else
+		ip_csum_offload = false;
+
+	sxe_hw_rx_ip_checksum_offload_switch(hw, ip_csum_offload);
+
+	sxe_rx_queue_offload_configure(dev);
+}
+
+static inline void sxe_rx_queue_attr_configure(struct rte_eth_dev *dev,
+					sxe_rx_queue_s *queue)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	u32 srrctl_size;
+	u64 desc_dma_addr;
+	u32 desc_mem_len;
+	u8 reg_idx;
+	u16 buf_size;
+	u32 frame_size = SXE_GET_FRAME_SIZE(dev);
+	reg_idx = queue->reg_idx;
+
+	sxe_hw_rx_ring_switch(hw, reg_idx, false);
+
+	desc_mem_len = queue->ring_depth * sizeof(union sxe_rx_data_desc);
+	desc_dma_addr = queue->base_addr;
+	sxe_hw_rx_ring_desc_configure(hw, desc_mem_len,
+						desc_dma_addr, reg_idx);
+
+	buf_size = (u16)(rte_pktmbuf_data_room_size(queue->mb_pool) -
+		RTE_PKTMBUF_HEADROOM);
+
+	sxe_hw_rx_rcv_ctl_configure(hw, reg_idx,
+			SXE_LRO_HDR_SIZE, buf_size);
+
+	if (queue->drop_en)
+		sxe_hw_rx_drop_switch(hw, reg_idx, true);
+
+	sxe_hw_rx_desc_thresh_set(hw, reg_idx);
+
+	srrctl_size = ((buf_size >> SXE_SRRCTL_BSIZEPKT_SHIFT) &
+				SXE_SRRCTL_BSIZEPKT_MASK);
+
+	buf_size = (u16)((srrctl_size & SXE_SRRCTL_BSIZEPKT_MASK) <<
+				SXE_SRRCTL_BSIZEPKT_SHIFT);
+
+	if (frame_size + 2 * SXE_VLAN_TAG_SIZE > buf_size)
+		dev->data->scattered_rx = 1;
+
+	sxe_hw_rx_ring_switch(hw, reg_idx, true);
+}
+
+static inline void sxe_rx_queue_configure(struct rte_eth_dev *dev)
+{
+	u16 i;
+	sxe_rx_queue_s **queue = (sxe_rx_queue_s **)dev->data->rx_queues;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++)
+		sxe_rx_queue_attr_configure(dev, queue[i]);
+}
+
+static u32 sxe_lro_max_desc_get(struct rte_mempool *pool)
+{
+	u8 desc_num;
+	struct rte_pktmbuf_pool_private *mp_priv = rte_mempool_get_priv(pool);
+
+	u16 maxdesc = RTE_IPV4_MAX_PKT_LEN /
+			(mp_priv->mbuf_data_room_size - RTE_PKTMBUF_HEADROOM);
+
+	if (maxdesc >= 16)
+		desc_num = SXE_LROCTL_MAXDESC_16;
+	else if (maxdesc >= 8)
+		desc_num = SXE_LROCTL_MAXDESC_8;
+	else if (maxdesc >= 4)
+		desc_num = SXE_LROCTL_MAXDESC_4;
+	else
+		desc_num = SXE_LROCTL_MAXDESC_1;
+
+	return desc_num;
+}
+
+static s32 sxe_lro_sanity_check(struct rte_eth_dev *dev, bool *lro_capable)
+{
+	s32 ret = 0;
+	struct rte_eth_dev_info dev_info = { 0 };
+	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+
+
+	if ((rx_conf->offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC) &&
+		(rx_conf->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)) {
+		PMD_LOG_CRIT(INIT, "lro can't be enabled when HW CRC "
+				"is disabled");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+	dev->dev_ops->dev_infos_get(dev, &dev_info);
+	if (dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_TCP_LRO)
+		*lro_capable = true;
+
+	if (!(*lro_capable) && (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)) {
+		PMD_LOG_CRIT(INIT, "lro is requested on HW that doesn't "
+				   "support it");
+		ret = -EINVAL;
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+static void sxe_lro_hw_configure(struct sxe_hw *hw, bool lro_capable,
+					struct rte_eth_rxmode *rx_conf)
+{
+	bool is_enable;
+
+	sxe_hw_rx_lro_ack_switch(hw, false);
+
+	sxe_hw_rx_dma_lro_ctrl_set(hw);
+
+	if ((lro_capable) && (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO))
+		is_enable = true;
+	else
+		is_enable = false;
+
+	if (is_enable)
+		sxe_hw_rx_nfs_filter_disable(hw);
+
+	sxe_hw_rx_lro_enable(hw, is_enable);
+}
+
+static void sxe_lro_irq_configure(struct sxe_hw *hw, u16 reg_idx,
+						u16 irq_idx)
+{
+	u32 irq_interval;
+
+	irq_interval = SXE_EITR_INTERVAL_US(SXE_QUEUE_ITR_INTERVAL_DEFAULT);
+	sxe_hw_ring_irq_interval_set(hw, reg_idx, irq_interval);
+
+	sxe_hw_ring_irq_map(hw, false, reg_idx, irq_idx);
+}
+
+static void sxe_lro_hw_queue_configure(struct rte_eth_dev *dev,
+						struct sxe_hw *hw)
+{
+	u16 i;
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		sxe_rx_queue_s *rxq = dev->data->rx_queues[i];
+		u16 reg_idx = rxq->reg_idx;
+		u32 max_desc_num;
+
+		max_desc_num = sxe_lro_max_desc_get(rxq->mb_pool);
+		sxe_hw_rx_lro_ctl_configure(hw, reg_idx, max_desc_num);
+
+		sxe_lro_irq_configure(hw, reg_idx, i);
+	}
+}
+
+static s32 sxe_lro_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	struct rte_eth_rxmode *rx_conf = &dev->data->dev_conf.rxmode;
+	bool lro_capable = false;
+
+	s32 ret;
+
+	ret = sxe_lro_sanity_check(dev, &lro_capable);
+	if (ret) {
+		PMD_LOG_CRIT(INIT, "lro sanity check failed, err=%d", ret);
+		goto l_end;
+	}
+
+	sxe_lro_hw_configure(hw, lro_capable, rx_conf);
+
+	if (!(rx_conf->offloads & RTE_ETH_RX_OFFLOAD_TCP_LRO)) {
+		PMD_LOG_DEBUG(INIT, "user app do not turn lro on");
+		goto l_end;
+	}
+
+	sxe_lro_hw_queue_configure(dev, hw);
+
+	dev->data->lro = 1;
+
+	PMD_LOG_DEBUG(INIT, "enabling lro mode");
+
+l_end:
+	return ret;
+}
+
+static s32 __rte_cold sxe_rx_start(struct rte_eth_dev *dev)
+{
+	sxe_rx_queue_s *rxq;
+	u16 i;
+	s32 ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		if (!rxq->deferred_start) {
+			ret = sxe_rx_queue_start(dev, i);
+			if (ret < 0) {
+				PMD_LOG_ERR(INIT, "rx queue[%u] start failed", i);
+				goto l_end;
+			}
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+s32 __rte_cold sxe_rx_configure(struct rte_eth_dev *dev)
+{
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	s32 ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_rx_cap_switch_off(hw);
+
+	sxe_hw_rx_pkt_buf_size_set(hw, 0, SXE_RX_PKT_BUF_SIZE);
+
+	sxe_rx_mode_configure(hw);
+
+	sxe_rx_offload_configure(dev);
+
+	sxe_rx_queue_configure(dev);
+
+	sxe_rx_features_configure(dev);
+
+	ret = sxe_lro_configure(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "lro config failed, err = %d", ret);
+		goto l_end;
+	}
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+	sxe_rx_function_set(dev, adapter->rx_batch_alloc_allowed,
+			&adapter->rx_vec_allowed);
+#else
+	sxe_rx_function_set(dev, adapter->rx_batch_alloc_allowed, NULL);
+#endif
+
+	ret = sxe_rx_start(dev);
+	if (ret) {
+		PMD_LOG_ERR(INIT, "rx start failed, err = %d", ret);
+		goto l_end;
+	}
+
+l_end:
+	return ret;
+}
+
+void sxe_vmdq_rx_mode_get(u32 rx_mask, u32 *orig_val)
+{
+	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_UNTAG)
+		*orig_val |= SXE_VMOLR_AUPE;
+
+	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_HASH_MC)
+		*orig_val |= SXE_VMOLR_ROMPE;
+
+	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_HASH_UC)
+		*orig_val |= SXE_VMOLR_ROPE;
+
+	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_BROADCAST)
+		*orig_val |= SXE_VMOLR_BAM;
+
+	if (rx_mask & RTE_ETH_VMDQ_ACCEPT_MULTICAST)
+		*orig_val |= SXE_VMOLR_MPE;
+}
+
+static void sxe_vmdq_rx_hw_configure(struct rte_eth_dev *dev)
+{
+	struct rte_eth_vmdq_rx_conf *cfg;
+	struct sxe_adapter *adapter = dev->data->dev_private;
+	struct sxe_hw	 *hw = &adapter->hw;
+	enum rte_eth_nb_pools pools_num;
+	u32 rx_mode = 0;
+	u16 i;
+
+	PMD_INIT_FUNC_TRACE();
+	cfg = &dev->data->dev_conf.rx_adv_conf.vmdq_rx_conf;
+	pools_num = cfg->nb_queue_pools;
+
+	sxe_rss_disable(dev);
+
+	sxe_hw_vmdq_mq_configure(hw);
+
+	sxe_hw_vmdq_default_pool_configure(hw,
+						cfg->enable_default_pool,
+						cfg->default_pool);
+
+	sxe_vmdq_rx_mode_get(cfg->rx_mode, &rx_mode);
+	sxe_hw_vmdq_vlan_configure(hw, pools_num, rx_mode);
+
+	for (i = 0; i < cfg->nb_pool_maps; i++) {
+		sxe_hw_vmdq_pool_configure(hw, i,
+						cfg->pool_map[i].vlan_id,
+						cfg->pool_map[i].pools);
+	}
+
+	if (cfg->enable_loop_back)
+		sxe_hw_vmdq_loopback_configure(hw);
+}
+
+s32 sxe_rx_features_configure(struct rte_eth_dev *dev)
+{
+	s32 ret = 0;
+
+	if (RTE_ETH_DEV_SRIOV(dev).active == 0) {
+		switch (dev->data->dev_conf.rxmode.mq_mode) {
+		case RTE_ETH_MQ_RX_RSS:
+		case RTE_ETH_MQ_RX_DCB_RSS:
+		case RTE_ETH_MQ_RX_VMDQ_RSS:
+			sxe_rss_configure(dev);
+			break;
+		case RTE_ETH_MQ_RX_VMDQ_DCB:
+			sxe_dcb_vmdq_rx_hw_configure(dev);
+			break;
+		case RTE_ETH_MQ_RX_VMDQ_ONLY:
+			sxe_vmdq_rx_hw_configure(dev);
+			break;
+		case RTE_ETH_MQ_RX_NONE:
+		default:
+			sxe_rss_disable(dev);
+			break;
+		}
+	} else {
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SRIOV
+		switch (dev->data->dev_conf.rxmode.mq_mode) {
+		case RTE_ETH_MQ_RX_RSS:
+		case RTE_ETH_MQ_RX_VMDQ_RSS:
+			sxe_vf_rss_configure(dev);
+			break;
+		case RTE_ETH_MQ_RX_VMDQ_DCB:
+		case RTE_ETH_MQ_RX_DCB:
+			sxe_dcb_vmdq_rx_hw_configure(dev);
+			break;
+		case RTE_ETH_MQ_RX_VMDQ_DCB_RSS:
+		case RTE_ETH_MQ_RX_DCB_RSS:
+			ret = -SXE_ERR_CONFIG;
+			PMD_LOG_ERR(DRV,
+				"DCB and RSS with vmdq or sriov not "
+				"support.(err:%d)", ret);
+			break;
+		default:
+			sxe_vf_default_mode_configure(dev);
+			break;
+		}
+#else
+		PMD_LOG_ERR(INIT, "unsupport sriov");
+		ret = -EINVAL;
+#endif
+	}
+
+	LOG_INFO("pool num:%u rx mq_mode:0x%x configure result:%d.",
+			 RTE_ETH_DEV_SRIOV(dev).active,
+			 dev->data->dev_conf.rxmode.mq_mode, ret);
+
+	return ret;
+}
+
+const u32 *sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
+{
+	return __sxe_dev_supported_ptypes_get(dev, no_of_elements);
+}
+
+static s32
+sxe_monitor_callback(const u64 value,
+		const u64 arg[RTE_POWER_MONITOR_OPAQUE_SZ] __rte_unused)
+{
+	const u64 dd_state = rte_cpu_to_le_32(SXE_RXDADV_STAT_DD);
+	return (value & dd_state) == dd_state ? -1 : 0;
+}
+
+s32
+sxe_monitor_addr_get(void *rx_queue, struct rte_power_monitor_cond *pmc)
+{
+	volatile union sxe_rx_data_desc *rxdp;
+	struct sxe_rx_queue *rxq = rx_queue;
+
+	rxdp = &rxq->desc_ring[rxq->processing_idx];
+
+	pmc->addr = &rxdp->wb.upper.status_error;
+	pmc->fn = sxe_monitor_callback;
+	pmc->size = sizeof(u32);
+
+	return 0;
+}
diff --git a/drivers/net/sxe/pf/sxe_rx.h b/drivers/net/sxe/pf/sxe_rx.h
new file mode 100644
index 0000000000..ed998dc7fc
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_rx.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+
+#ifndef __SXE_DPDK_RX_H__
+#define __SXE_DPDK_RX_H__
+
+#include "sxe_types.h"
+#include "sxe_queue.h"
+#include "sxe_hw.h"
+#include "sxe_compat_version.h"
+#include "sxe_logs.h"
+
+#define SXE_RXDADV_ERR_CKSUM_BIT  30
+#define SXE_RXDADV_ERR_CKSUM_MSK  3
+
+#define SXE_PACKET_TYPE_MAX			   0X80
+#define SXE_PACKET_TYPE_TN_MAX			0X100
+#define SXE_PACKET_TYPE_MASK			  0X7F
+#define SXE_RXD_STAT_TMST				 0x10000
+
+#define SXE_DESCS_PER_LOOP 4
+
+#define SXE_PCI_REG_WC_WRITE(reg, value)			\
+	rte_write32_wc((rte_cpu_to_le_32(value)), reg)
+#define SXE_PCI_REG_WC_WRITE_RELAXED(reg, value)		\
+	rte_write32_wc_relaxed((rte_cpu_to_le_32(value)), reg)
+
+#define SXE_RX_RING_SIZE ((SXE_MAX_RING_DESC + RTE_PMD_SXE_MAX_RX_BURST) * \
+			sizeof(sxe_rx_data_desc_u))
+
+extern const u32 sxe_ptype_table[SXE_PACKET_TYPE_MAX];
+extern const u32 sxe_ptype_table_tn[SXE_PACKET_TYPE_TN_MAX];
+
+static inline u64 sxe_rx_desc_status_to_pkt_flags(u32 rx_status,
+							u64 vlan_flags)
+{
+	u64 pkt_flags;
+
+	pkt_flags = (rx_status & SXE_RXD_STAT_VP) ?  vlan_flags : 0;
+
+#ifdef RTE_LIBRTE_IEEE1588
+	if (rx_status & SXE_RXD_STAT_TMST)
+		pkt_flags = pkt_flags | RTE_MBUF_F_RX_IEEE1588_TMST;
+#endif
+	return pkt_flags;
+}
+
+static inline u64 sxe_rx_desc_error_to_pkt_flags(u32 rx_status)
+{
+	u64 pkt_flags;
+
+	static u64 error_to_pkt_flags_map[4] = {
+		RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+		RTE_MBUF_F_RX_IP_CKSUM_GOOD | RTE_MBUF_F_RX_L4_CKSUM_BAD,
+		RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_GOOD,
+		RTE_MBUF_F_RX_IP_CKSUM_BAD | RTE_MBUF_F_RX_L4_CKSUM_BAD
+	};
+
+	pkt_flags = error_to_pkt_flags_map[(rx_status >>
+		SXE_RXDADV_ERR_CKSUM_BIT) & SXE_RXDADV_ERR_CKSUM_MSK];
+
+	if ((rx_status & SXE_RXD_STAT_OUTERIPCS) &&
+		(rx_status & SXE_RXDADV_ERR_OUTERIPER)) {
+		pkt_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
+	}
+
+	return pkt_flags;
+}
+
+static inline u64 sxe_rx_desc_pkt_info_to_pkt_flags(u16 pkt_info)
+{
+	u64 flags = 0;
+
+	static alignas(RTE_CACHE_LINE_SIZE) u64 ip_rss_types_map[16] = {
+		0, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH, RTE_MBUF_F_RX_RSS_HASH,
+		0, RTE_MBUF_F_RX_RSS_HASH, 0, RTE_MBUF_F_RX_RSS_HASH,
+		RTE_MBUF_F_RX_RSS_HASH, 0, 0, 0,
+		0, 0, 0,  RTE_MBUF_F_RX_FDIR,
+	};
+
+#ifdef RTE_LIBRTE_IEEE1588
+		static u64 ip_pkt_etqf_map[8] = {
+			0, 0, 0, RTE_MBUF_F_RX_IEEE1588_PTP,
+			0, 0, 0, 0,
+		};
+
+		if (likely(pkt_info & SXE_RXDADV_PKTTYPE_ETQF)) {
+			flags = ip_pkt_etqf_map[(pkt_info >> 4) & 0X07] |
+				ip_rss_types_map[pkt_info & 0XF];
+		} else {
+			flags = ip_rss_types_map[pkt_info & 0XF];
+		}
+#else
+		flags = ip_rss_types_map[pkt_info & 0XF];
+#endif
+	return flags;
+}
+
+static inline u32 sxe_rxd_pkt_info_to_pkt_type(u32 pkt_info,
+							u16 ptype_mask)
+{
+	if (unlikely(pkt_info & SXE_RXDADV_PKTTYPE_ETQF))
+		return RTE_PTYPE_UNKNOWN;
+
+	pkt_info = (pkt_info >> SXE_RXDADV_PKTTYPE_ETQF_SHIFT) & ptype_mask;
+
+	pkt_info &= SXE_PACKET_TYPE_MASK;
+
+	return sxe_ptype_table[pkt_info];
+}
+
+static inline u32 sxe_lro_count(sxe_rx_data_desc_u *rx)
+{
+	return (rte_le_to_cpu_32(rx->wb.lower.lo_dword.data) &
+		SXE_RXDADV_LROCNT_MASK) >> SXE_RXDADV_LROCNT_SHIFT;
+}
+
+static inline bool __rte_cold
+	sxe_check_is_rx_batch_alloc_support(sxe_rx_queue_s *rxq)
+{
+	bool support = true;
+
+	if (!(rxq->batch_alloc_size >= RTE_PMD_SXE_MAX_RX_BURST)) {
+		PMD_LOG_DEBUG(INIT, "rx burst batch alloc check: "
+				 "rxq->batch_alloc_size=%d, "
+				 "RTE_PMD_SXE_MAX_RX_BURST=%d",
+				 rxq->batch_alloc_size, RTE_PMD_SXE_MAX_RX_BURST);
+		support = false;
+	} else if (!(rxq->batch_alloc_size < rxq->ring_depth)) {
+		PMD_LOG_DEBUG(INIT, "rx burst batch alloc check: "
+				 "rxq->batch_alloc_size=%d, "
+				 "rxq->ring_depth=%d",
+				 rxq->batch_alloc_size, rxq->ring_depth);
+		support = false;
+	} else if (!((rxq->ring_depth % rxq->batch_alloc_size) == 0)) {
+		PMD_LOG_DEBUG(INIT, "rx burst batch alloc preconditions: "
+				 "rxq->nb_rx_desc=%d, "
+				 "rxq->batch_alloc_size=%d",
+				 rxq->ring_depth, rxq->batch_alloc_size);
+		support = false;
+	}
+
+	return support;
+}
+
+s32 sxe_rx_configure(struct rte_eth_dev *dev);
+
+void sxe_rx_function_set(struct rte_eth_dev *dev,
+		bool rx_batch_alloc_allowed, bool *rx_vec_allowed);
+
+s32 sxe_rx_descriptor_status(void *rx_queue, u16 offset);
+
+u16 sxe_pkts_recv(void *rx_queue, struct rte_mbuf **rx_pkts, u16 num_pkts);
+
+s32 sxe_rx_queue_setup(struct rte_eth_dev *dev,
+			 u16 queue_idx, u16 num_desc,
+			 unsigned int socket_id,
+			 const struct rte_eth_rxconf *rx_conf,
+			 struct rte_mempool *mp);
+
+s32 sxe_rx_features_configure(struct rte_eth_dev *dev);
+
+const u32 *sxe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements);
+
+s32
+sxe_monitor_addr_get(void *rx_queue, struct rte_power_monitor_cond *pmc);
+
+void sxe_rx_mbuf_common_header_fill(sxe_rx_queue_s *rxq,
+					struct rte_mbuf *mbuf,
+					volatile sxe_rx_data_desc_u desc,
+					u32 pkt_info, u32 staterr);
+
+u16 sxe_batch_alloc_lro_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num);
+
+u16 sxe_single_alloc_lro_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num);
+
+u16 sxe_batch_alloc_pkts_recv(void *rx_queue,
+					struct rte_mbuf **rx_pkts,
+					u16 pkts_num);
+
+void sxe_vmdq_rx_mode_get(u32 rx_mask, u32 *orig_val);
+
+#endif
diff --git a/drivers/net/sxe/pf/sxe_tx.c b/drivers/net/sxe/pf/sxe_tx.c
new file mode 100644
index 0000000000..33d4468ebc
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_tx.c
@@ -0,0 +1,1051 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#include <ethdev_driver.h>
+#include <dev_driver.h>
+#include <rte_net.h>
+#include "sxe.h"
+#include "sxe_tx.h"
+#include "sxe_hw.h"
+#include "sxe_logs.h"
+#include "sxe_queue_common.h"
+#include "sxe_tx_common.h"
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#include "sxe_vec_common.h"
+#include <rte_vect.h>
+#endif
+#include "sxe_compat_version.h"
+
+#define SXE_TX_DESC_NO_WB 1
+
+#define SXE_TX_OFFLOAD_NOTSUP_MASK (RTE_MBUF_F_TX_OFFLOAD_MASK ^ SXE_TX_OFFLOAD_MASK)
+#define RTE_SXE_MAX_TX_FREE_BUF_SZ 64
+#define SXE_TXD_IDX_SHIFT	4
+#define SXE_TX_MIN_PKT_LEN	14
+
+void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
+					sxe_tx_queue_s *txq)
+{
+	/* Offload off and signle simple tx code path < 32 use simple tx code path */
+	if (txq->offloads == 0 &&
+		txq->rs_thresh >= RTE_PMD_SXE_MAX_TX_BURST) {
+		dev->tx_pkt_prepare = NULL;
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+		if (txq->rs_thresh <= RTE_SXE_MAX_TX_FREE_BUF_SZ &&
+			(rte_eal_process_type() != RTE_PROC_PRIMARY ||
+			sxe_txq_vec_setup(txq) == 0)) {
+
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+			dev->recycle_tx_mbufs_reuse = sxe_recycle_tx_mbufs_reuse_vec;
+#endif
+			dev->tx_pkt_burst   = sxe_pkts_vector_xmit;
+			PMD_LOG_INFO(INIT, "using vector tx code path");
+		} else {
+			dev->tx_pkt_burst   = sxe_pkts_simple_xmit;
+			PMD_LOG_INFO(INIT, "using simple tx code path");
+		}
+#else
+		dev->tx_pkt_burst	= sxe_pkts_simple_xmit;
+		PMD_LOG_INFO(INIT, "using simple tx code path");
+#endif
+
+	} else {
+		dev->tx_pkt_burst   = sxe_pkts_xmit_with_offload;
+		dev->tx_pkt_prepare = sxe_prep_pkts;
+
+		PMD_LOG_INFO(INIT, "using full-featured tx code path");
+		PMD_LOG_INFO(INIT, " - offloads = 0x%" SXE_PRIX64,
+					(unsigned long)txq->offloads);
+		PMD_LOG_INFO(INIT, " - tx_rs_thresh = %d "
+				   "[RTE_PMD_SXE_MAX_TX_BURST=%d]",
+				txq->rs_thresh,
+				RTE_PMD_SXE_MAX_TX_BURST);
+	}
+}
+
+int __rte_cold sxe_tx_queue_setup(struct rte_eth_dev *dev,
+				u16 tx_queue_id,
+				u16 ring_depth,
+				u32 socket_id,
+				const struct rte_eth_txconf *tx_conf)
+{
+	s32 ret;
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+	struct tx_setup tx_setup;
+
+	tx_setup.dev = dev;
+	tx_setup.desc_num = ring_depth;
+	tx_setup.queue_idx = tx_queue_id;
+	tx_setup.socket_id = socket_id;
+	tx_setup.reg_base_addr = hw->reg_base_addr;
+	tx_setup.tx_conf = tx_conf;
+
+	ret = __sxe_tx_queue_setup(&tx_setup, false);
+
+	return ret;
+}
+
+static void __rte_cold sxe_tx_start(struct rte_eth_dev *dev)
+{
+	u32 i;
+	sxe_tx_queue_s *txq;
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_hw_tx_enable(hw);
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		sxe_hw_tx_desc_thresh_set(hw, txq->reg_idx,
+				txq->wthresh, txq->hthresh, txq->pthresh);
+		if (!txq->tx_deferred_start)
+			sxe_tx_queue_start(dev, i);
+	}
+}
+
+static void sxe_tx_buf_configure(struct sxe_hw *hw)
+{
+	sxe_hw_tx_pkt_buf_switch(hw, false);
+
+	sxe_hw_tx_pkt_buf_size_configure(hw, 0);
+
+	sxe_hw_tx_pkt_buf_thresh_configure(hw, 0, false);
+
+	sxe_hw_tx_pkt_buf_switch(hw, true);
+
+	sxe_hw_mac_pad_enable(hw);
+}
+
+void __rte_cold sxe_tx_configure(struct rte_eth_dev *dev)
+{
+	u16 i;
+	u64 queue_dma_addr;
+	u32 ring_size;
+	sxe_tx_queue_s *txq;
+	struct sxe_hw *hw = (&((struct sxe_adapter *)(dev->data->dev_private))->hw);
+
+	PMD_INIT_FUNC_TRACE();
+
+	sxe_multi_queue_tx_configure(dev);
+
+	sxe_tx_buf_configure(hw);
+
+	for (i = 0; i < dev->data->nb_tx_queues; i++) {
+		txq = dev->data->tx_queues[i];
+		queue_dma_addr = txq->base_addr;
+		ring_size = txq->ring_depth * sizeof(sxe_tx_data_desc_u);
+
+		sxe_hw_tx_ring_desc_configure(hw, ring_size, queue_dma_addr,
+						txq->reg_idx);
+	}
+
+	sxe_tx_start(dev);
+}
+
+static inline void sxe_single_desc_fill(volatile sxe_tx_data_desc_u *desc,
+				struct rte_mbuf **pkts)
+{
+	u32 pkt_len;
+	u64 buf_dma_addr;
+
+	buf_dma_addr = rte_mbuf_data_iova(*pkts);
+	pkt_len = (*pkts)->data_len;
+
+	desc->read.buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
+	desc->read.cmd_type_len =
+			rte_cpu_to_le_32((u32)SXE_TX_DESC_FLAGS | pkt_len);
+	desc->read.olinfo_status =
+			rte_cpu_to_le_32(pkt_len << SXE_TX_DESC_PAYLEN_SHIFT);
+	rte_sxe_prefetch(&(*pkts)->pool);
+}
+
+#define TX4_PER_LOOP 4
+#define TX4_PER_LOOP_MASK (TX4_PER_LOOP - 1)
+
+static inline void sxe_four_desc_fill(volatile sxe_tx_data_desc_u *desc,
+			struct rte_mbuf **pkts)
+{
+	s32 i;
+	u64 buf_dma_addr;
+	u32 pkt_len;
+
+	for (i = 0; i < TX4_PER_LOOP; ++i, ++desc, ++pkts) {
+		buf_dma_addr = rte_mbuf_data_iova(*pkts);
+		pkt_len = (*pkts)->data_len;
+
+		desc->read.buffer_addr = rte_cpu_to_le_64(buf_dma_addr);
+
+		desc->read.cmd_type_len =
+			rte_cpu_to_le_32((u32)SXE_TX_DESC_FLAGS | pkt_len);
+
+		desc->read.olinfo_status =
+			rte_cpu_to_le_32(pkt_len << SXE_TX_DESC_PAYLEN_SHIFT);
+
+		rte_sxe_prefetch(&(*pkts)->pool);
+	}
+}
+
+static inline void sxe_tx_ring_fill(sxe_tx_queue_s *txq,
+				struct rte_mbuf **pkts, u16 pkts_num)
+{
+	u32 i, j, mainpart, leftover;
+	volatile sxe_tx_data_desc_u *desc =
+					&txq->desc_ring[txq->next_to_use];
+	struct sxe_tx_buffer *buffer = &txq->buffer_ring[txq->next_to_use];
+
+	mainpart = (pkts_num & ((u32)(~TX4_PER_LOOP_MASK)));
+	leftover = (pkts_num & ((u32)(TX4_PER_LOOP_MASK)));
+
+	for (i = 0; i < mainpart; i += TX4_PER_LOOP) {
+		for (j = 0; j < TX4_PER_LOOP; ++j)
+			(buffer + i + j)->mbuf = *(pkts + i + j);
+		sxe_four_desc_fill(desc + i, pkts + i);
+	}
+
+	if (unlikely(leftover > 0)) {
+		for (i = 0; i < leftover; ++i) {
+			(buffer + mainpart + i)->mbuf = *(pkts + mainpart + i);
+			sxe_single_desc_fill(desc + mainpart + i,
+						pkts + mainpart + i);
+		}
+	}
+}
+
+s32 sxe_tx_bufs_free(sxe_tx_queue_s *txq)
+{
+	s32 ret = 0;
+	u32 status;
+	s32 i, mbuf_free_num = 0;
+	struct sxe_tx_buffer *buffer;
+	struct rte_mbuf *mbuf, *free_mbuf[RTE_SXE_MAX_TX_FREE_BUF_SZ];
+
+	status = txq->desc_ring[txq->next_dd].wb.status;
+	if (!(status & rte_cpu_to_le_32(SXE_TX_DESC_STAT_DD))) {
+		ret = 0;
+		goto l_end;
+	}
+
+	buffer = &txq->buffer_ring[txq->next_dd - txq->rs_thresh - 1];
+
+	for (i = 0; i < txq->rs_thresh; ++i, ++buffer) {
+		mbuf = rte_pktmbuf_prefree_seg(buffer->mbuf);
+		buffer->mbuf = NULL;
+
+		if (unlikely(mbuf == NULL))
+			continue;
+
+		if (mbuf_free_num >= RTE_SXE_MAX_TX_FREE_BUF_SZ ||
+			(mbuf_free_num > 0 && mbuf->pool != free_mbuf[0]->pool)) {
+			rte_mempool_put_bulk(free_mbuf[0]->pool,
+						 (void **)free_mbuf, mbuf_free_num);
+			mbuf_free_num = 0;
+		}
+
+		free_mbuf[mbuf_free_num++] = mbuf;
+	}
+
+	if (mbuf_free_num > 0) {
+		rte_mempool_put_bulk(free_mbuf[0]->pool,
+					(void **)free_mbuf, mbuf_free_num);
+	}
+
+	txq->next_dd	   += txq->rs_thresh;
+	txq->desc_free_num += txq->rs_thresh;
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = txq->rs_thresh - 1;
+
+	ret = txq->rs_thresh;
+
+l_end:
+	return ret;
+}
+
+static inline u16 sxe_pkts_xmit(void *tx_queue,
+			struct rte_mbuf **tx_pkts, u16 xmit_pkts_num)
+{
+	u16 n = 0;
+	sxe_tx_queue_s *txq = (sxe_tx_queue_s *)tx_queue;
+	volatile sxe_tx_data_desc_u *desc_ring = txq->desc_ring;
+
+	if (txq->desc_free_num < txq->free_thresh)
+		sxe_tx_bufs_free(txq);
+
+	xmit_pkts_num = (u16)RTE_MIN(txq->desc_free_num, xmit_pkts_num);
+	if (unlikely(xmit_pkts_num == 0)) {
+		LOG_DEBUG("simple xmit: not enough free desc, "
+			"free_desc=%u, need_xmit_pkts=%u",
+			txq->desc_free_num, xmit_pkts_num);
+		goto l_end;
+	}
+
+	txq->desc_free_num -= xmit_pkts_num;
+
+	if ((txq->next_to_use + xmit_pkts_num) > txq->ring_depth) {
+		n = txq->ring_depth - txq->next_to_use;
+
+		sxe_tx_ring_fill(txq, tx_pkts, n);
+
+		desc_ring[txq->next_rs].read.cmd_type_len |=
+			rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+		txq->next_rs = (u16)(txq->rs_thresh - 1);
+
+		txq->next_to_use = 0;
+	}
+
+	sxe_tx_ring_fill(txq, tx_pkts + n, (u16)(xmit_pkts_num - n));
+	txq->next_to_use = (u16)(txq->next_to_use + (xmit_pkts_num - n));
+
+	if (txq->next_to_use > txq->next_rs) {
+		desc_ring[txq->next_rs].read.cmd_type_len |=
+			rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+		txq->next_rs = (u16)(txq->next_rs + txq->rs_thresh);
+		if (txq->next_rs >= txq->ring_depth)
+			txq->next_rs = (u16)(txq->rs_thresh - 1);
+	}
+
+	if (txq->next_to_use >= txq->ring_depth)
+		txq->next_to_use = 0;
+
+	rte_wmb();
+	rte_write32_wc_relaxed((rte_cpu_to_le_32(txq->next_to_use)),
+							txq->tdt_reg_addr);
+
+l_end:
+	return xmit_pkts_num;
+}
+
+u16 sxe_pkts_simple_xmit(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	sxe_tx_queue_s *queue = tx_queue;
+	u16 ret, xmit_pkts_num, need_xmit_pkts;
+	UNUSED(queue);
+
+	if (likely(pkts_num <= RTE_PMD_SXE_MAX_TX_BURST)) {
+		xmit_pkts_num = sxe_pkts_xmit(tx_queue, tx_pkts, pkts_num);
+		goto l_end;
+	}
+
+	/* When pkts_num > 32, it needs to besent in a loop */
+	xmit_pkts_num = 0;
+	while (pkts_num) {
+		need_xmit_pkts = (u16)RTE_MIN(pkts_num, RTE_PMD_SXE_MAX_TX_BURST);
+
+		/* Signle transmit */
+		ret = sxe_pkts_xmit(tx_queue, &tx_pkts[xmit_pkts_num],
+							need_xmit_pkts);
+
+		pkts_num	  -= ret;
+		xmit_pkts_num += ret;
+
+		/* Don't have enough desc */
+		if (ret < need_xmit_pkts)
+			break;
+	}
+
+	LOG_DEBUG("simple xmit:port_id=%u, queue_id=%u, "
+		"remain_pkts_num=%d, xmit_pkts_num=%d",
+		queue->port_id, queue->port_id,
+		pkts_num, xmit_pkts_num);
+
+l_end:
+	return xmit_pkts_num;
+}
+
+#if defined SXE_DPDK_L4_FEATURES && defined SXE_DPDK_SIMD
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM)
+u16 sxe_recycle_tx_mbufs_reuse_vec(void *tx_queue,
+	struct rte_eth_recycle_rxq_info *recycle_rxq_info)
+{
+	sxe_tx_queue_s *txq = tx_queue;
+	struct sxe_tx_buffer *txep;
+	struct rte_mbuf **rxep;
+	int i, n;
+	u32 status;
+	u16 nb_recycle_mbufs;
+	u16 avail = 0;
+	u16 mbuf_ring_size = recycle_rxq_info->mbuf_ring_size;
+	u16 mask = recycle_rxq_info->mbuf_ring_size - 1;
+	u16 refill_requirement = recycle_rxq_info->refill_requirement;
+	u16 refill_head = *recycle_rxq_info->refill_head;
+	u16 receive_tail = *recycle_rxq_info->receive_tail;
+
+	avail = (mbuf_ring_size - (refill_head - receive_tail)) & mask;
+
+	if (txq->desc_free_num > txq->free_thresh || avail <= txq->rs_thresh)
+		return 0;
+
+	status = txq->desc_ring[txq->next_dd].wb.status;
+	if (!(status & SXE_TX_DESC_STAT_DD))
+		return 0;
+
+	n = txq->rs_thresh;
+	nb_recycle_mbufs = n;
+
+	if ((refill_requirement && refill_requirement != n) ||
+		(!refill_requirement && (refill_head + n > mbuf_ring_size)))
+		return 0;
+
+	txep = &txq->buffer_ring[txq->next_dd - (n - 1)];
+	rxep = recycle_rxq_info->mbuf_ring;
+	rxep += refill_head;
+
+	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
+		if (unlikely(recycle_rxq_info->mp != txep[0].mbuf->pool))
+			return 0;
+
+		for (i = 0; i < n; i++)
+			rxep[i] = txep[i].mbuf;
+	} else {
+		for (i = 0; i < n; i++) {
+			rxep[i] = rte_pktmbuf_prefree_seg(txep[i].mbuf);
+
+			if (unlikely(rxep[i] == NULL || recycle_rxq_info->mp != txep[i].mbuf->pool))
+				nb_recycle_mbufs = 0;
+		}
+		if (nb_recycle_mbufs == 0) {
+			for (i = 0; i < n; i++) {
+				if (rxep[i] != NULL)
+					rte_mempool_put(rxep[i]->pool, rxep[i]);
+			}
+		}
+	}
+
+	txq->desc_free_num = (u16)(txq->desc_free_num + txq->rs_thresh);
+	txq->next_dd = (u16)(txq->next_dd + txq->rs_thresh);
+	if (txq->next_dd >= txq->ring_depth)
+		txq->next_dd = (u16)(txq->rs_thresh - 1);
+
+	return nb_recycle_mbufs;
+}
+#endif
+
+u16 sxe_pkts_vector_xmit(void *tx_queue, struct rte_mbuf **tx_pkts,
+			   u16 pkts_num)
+{
+	u16 xmit_pkts_num = 0;
+	sxe_tx_queue_s *queue = (sxe_tx_queue_s *)tx_queue;
+
+	while (pkts_num) {
+		u16 ret, need_xmit_pkts;
+
+		need_xmit_pkts = (u16)RTE_MIN(pkts_num, queue->rs_thresh);
+		ret = __sxe_pkts_vector_xmit(tx_queue, &tx_pkts[xmit_pkts_num],
+				need_xmit_pkts);
+
+		xmit_pkts_num += ret;
+		pkts_num -= ret;
+		if (ret < need_xmit_pkts)
+			break;
+	}
+
+	return xmit_pkts_num;
+}
+#endif
+
+u16 sxe_prep_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	s32 i, ret;
+	u64 ol_flags;
+	struct rte_mbuf *mbuf;
+	sxe_tx_queue_s *txq = (sxe_tx_queue_s *)tx_queue;
+
+	/* Check if the pkts is legal */
+	for (i = 0; i < pkts_num; i++) {
+		mbuf = tx_pkts[i];
+		ol_flags = mbuf->ol_flags;
+
+		if (mbuf->nb_segs > SXE_TX_MAX_SEG - txq->wthresh) {
+			rte_errno = EINVAL;
+			goto l_end;
+		}
+
+		/* Check offload */
+		if (ol_flags & SXE_TX_OFFLOAD_NOTSUP_MASK) {
+			rte_errno = ENOTSUP;
+			goto l_end;
+		}
+
+		if (mbuf->pkt_len < SXE_TX_MIN_PKT_LEN) {
+			rte_errno = EINVAL;
+			goto l_end;
+		}
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+		ret = rte_validate_tx_offload(mbuf);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+#endif
+		ret = rte_net_intel_cksum_prepare(mbuf);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto l_end;
+		}
+	}
+
+l_end:
+	return i;
+}
+
+static inline bool sxe_cache_ctxt_desc_match(sxe_tx_queue_s *txq,
+				struct rte_mbuf *pkt,
+				u64 flags,
+				union sxe_tx_offload *ol_info)
+{
+	bool ret;
+
+	ol_info->l2_len	   = pkt->l2_len;
+	ol_info->l3_len	   = pkt->l3_len;
+	ol_info->l4_len	   = pkt->l4_len;
+	ol_info->vlan_tci	 = pkt->vlan_tci;
+	ol_info->tso_segsz	= pkt->tso_segsz;
+	ol_info->outer_l2_len = pkt->outer_l2_len;
+	ol_info->outer_l3_len = pkt->outer_l3_len;
+
+	if (likely(txq->ctx_cache[txq->ctx_curr].flags == flags &&
+		   (txq->ctx_cache[txq->ctx_curr].tx_offload.data[0] ==
+			(txq->ctx_cache[txq->ctx_curr].tx_offload_mask.data[0]
+			 & ol_info->data[0])) &&
+		   (txq->ctx_cache[txq->ctx_curr].tx_offload.data[1] ==
+			(txq->ctx_cache[txq->ctx_curr].tx_offload_mask.data[1]
+			 & ol_info->data[1])))) {
+		ret = false;
+		goto l_end;
+	}
+
+	txq->ctx_curr ^= 1;
+
+	if (likely(txq->ctx_cache[txq->ctx_curr].flags == flags &&
+		   (txq->ctx_cache[txq->ctx_curr].tx_offload.data[0] ==
+			(txq->ctx_cache[txq->ctx_curr].tx_offload_mask.data[0]
+			 & ol_info->data[0])) &&
+		   (txq->ctx_cache[txq->ctx_curr].tx_offload.data[1] ==
+			(txq->ctx_cache[txq->ctx_curr].tx_offload_mask.data[1]
+			 & ol_info->data[1])))) {
+		ret = false;
+		goto l_end;
+	}
+
+	ret = true;
+
+l_end:
+	return ret;
+}
+
+static inline void sxe_ctxt_desc_fill(sxe_tx_queue_s *txq,
+			volatile struct sxe_tx_context_desc *ctx_txd,
+			u64 ol_flags,
+			union sxe_tx_offload tx_offload,
+			__rte_unused u64 *mdata)
+{
+	u32 type_tucmd_mlhl;
+	u32 mss_l4len_idx = 0;
+	u32 ctx_idx;
+	u32 vlan_macip_lens;
+	union sxe_tx_offload tx_offload_mask;
+	u32 seqnum_seed = 0;
+
+	ctx_idx = txq->ctx_curr;
+	tx_offload_mask.data[0] = 0;
+	tx_offload_mask.data[1] = 0;
+	type_tucmd_mlhl = 0;
+
+
+	mss_l4len_idx |= (ctx_idx << SXE_TXD_IDX_SHIFT);
+
+	if (ol_flags & RTE_MBUF_F_TX_VLAN)
+		tx_offload_mask.vlan_tci |= ~0;
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+			type_tucmd_mlhl = SXE_TX_CTXTD_TUCMD_IPV4 |
+				SXE_TX_CTXTD_TUCMD_L4T_TCP |
+				SXE_TX_CTXTD_DTYP_CTXT;
+		} else {
+			type_tucmd_mlhl = SXE_TX_CTXTD_TUCMD_IPV6 |
+				SXE_TX_CTXTD_TUCMD_L4T_TCP |
+				SXE_TX_CTXTD_DTYP_CTXT;
+		}
+		mss_l4len_idx |= tx_offload.tso_segsz << SXE_TX_CTXTD_MSS_SHIFT;
+		mss_l4len_idx |= tx_offload.l4_len << SXE_TX_CTXTD_L4LEN_SHIFT;
+
+		tx_offload_mask.l2_len |= ~0;
+		tx_offload_mask.l3_len |= ~0;
+		tx_offload_mask.l4_len |= ~0;
+		tx_offload_mask.tso_segsz |= ~0;
+
+	} else {
+		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM) {
+			type_tucmd_mlhl = SXE_TX_CTXTD_TUCMD_IPV4;
+			tx_offload_mask.l2_len |= ~0;
+			tx_offload_mask.l3_len |= ~0;
+		}
+
+		switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
+		case RTE_MBUF_F_TX_UDP_CKSUM:
+			type_tucmd_mlhl |= SXE_TX_CTXTD_TUCMD_L4T_UDP |
+				SXE_TX_CTXTD_DTYP_CTXT;
+			mss_l4len_idx |= sizeof(struct rte_udp_hdr)
+				<< SXE_TX_CTXTD_L4LEN_SHIFT;
+			tx_offload_mask.l2_len |= ~0;
+			tx_offload_mask.l3_len |= ~0;
+			break;
+		case RTE_MBUF_F_TX_TCP_CKSUM:
+			type_tucmd_mlhl |= SXE_TX_CTXTD_TUCMD_L4T_TCP |
+				SXE_TX_CTXTD_DTYP_CTXT;
+			mss_l4len_idx |= sizeof(struct rte_tcp_hdr)
+				<< SXE_TX_CTXTD_L4LEN_SHIFT;
+			tx_offload_mask.l2_len |= ~0;
+			tx_offload_mask.l3_len |= ~0;
+			break;
+		case RTE_MBUF_F_TX_SCTP_CKSUM:
+			type_tucmd_mlhl |= SXE_TX_CTXTD_TUCMD_L4T_SCTP |
+				SXE_TX_CTXTD_DTYP_CTXT;
+			mss_l4len_idx |= sizeof(struct rte_sctp_hdr)
+				<< SXE_TX_CTXTD_L4LEN_SHIFT;
+			tx_offload_mask.l2_len |= ~0;
+			tx_offload_mask.l3_len |= ~0;
+			break;
+		default:
+			type_tucmd_mlhl |= SXE_TX_CTXTD_TUCMD_L4T_RSV |
+				SXE_TX_CTXTD_DTYP_CTXT;
+			break;
+		}
+	}
+
+	vlan_macip_lens = tx_offload.l3_len;
+	vlan_macip_lens |= ((u32)tx_offload.vlan_tci << SXE_TX_CTXTD_VLAN_SHIFT);
+
+	if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM) {
+		tx_offload_mask.outer_l2_len |= ~0;
+		tx_offload_mask.outer_l3_len |= ~0;
+		tx_offload_mask.l2_len |= ~0;
+		seqnum_seed |= tx_offload.outer_l3_len
+				   << SXE_TX_CTXTD_OUTER_IPLEN_SHIFT;
+		seqnum_seed |= tx_offload.l2_len
+				   << SXE_TX_CTXTD_TUNNEL_LEN_SHIFT;
+		vlan_macip_lens |= (tx_offload.outer_l2_len <<
+					SXE_TX_CTXTD_MACLEN_SHIFT);
+	} else {
+		vlan_macip_lens |= (tx_offload.l2_len <<
+						SXE_TX_CTXTD_MACLEN_SHIFT);
+	}
+
+	txq->ctx_cache[ctx_idx].flags = ol_flags;
+	txq->ctx_cache[ctx_idx].tx_offload.data[0]  =
+		tx_offload_mask.data[0] & tx_offload.data[0];
+	txq->ctx_cache[ctx_idx].tx_offload.data[1]  =
+		tx_offload_mask.data[1] & tx_offload.data[1];
+	txq->ctx_cache[ctx_idx].tx_offload_mask	= tx_offload_mask;
+
+	ctx_txd->type_tucmd_mlhl = rte_cpu_to_le_32(type_tucmd_mlhl);
+	ctx_txd->vlan_macip_lens = rte_cpu_to_le_32(vlan_macip_lens);
+	ctx_txd->mss_l4len_idx   = rte_cpu_to_le_32(mss_l4len_idx);
+	ctx_txd->seqnum_seed	 = seqnum_seed;
+}
+
+static inline u32 sxe_tx_desc_csum_info_setup(u64 ol_flags)
+{
+	u32 desc_csum = 0;
+
+	if ((ol_flags & RTE_MBUF_F_TX_L4_MASK) != RTE_MBUF_F_TX_L4_NO_CKSUM)
+		desc_csum |= SXE_TXD_POPTS_TXSM;
+
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
+		desc_csum |= SXE_TXD_POPTS_IXSM;
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+		desc_csum |= SXE_TXD_POPTS_TXSM;
+
+	return desc_csum;
+}
+
+static inline u32 sxe_tx_desc_cmdtype_setup(u64 ol_flags)
+{
+	u32 cmdtype = 0;
+
+	if (ol_flags & RTE_MBUF_F_TX_VLAN)
+		cmdtype |= SXE_TX_DESC_VLE;
+
+	if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
+		cmdtype |= SXE_TXD_DCMD_TSE;
+
+	if (ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM)
+		cmdtype |= (1 << SXE_TX_OUTERIPCS_SHIFT);
+
+#ifdef SXE_DPDK_MACSEC
+	if (ol_flags & RTE_MBUF_F_TX_MACSEC)
+		cmdtype |= SXE_TXD_MAC_LINKSEC;
+#endif
+
+	return cmdtype;
+}
+
+static inline s32 sxe_xmit_cleanup(sxe_tx_queue_s *txq)
+{
+	s32 ret = 0;
+	u32 wb_status;
+	u16 ntc = txq->next_to_clean;
+	u16 ring_depth = txq->ring_depth;
+	u16 desc_to_clean_to, nb_tx_to_clean;
+	struct sxe_tx_buffer *buffer_ring = txq->buffer_ring;
+	volatile sxe_tx_data_desc_u *desc_ring = txq->desc_ring;
+
+	PMD_INIT_FUNC_TRACE();
+
+	desc_to_clean_to = (u16)(ntc + txq->rs_thresh);
+
+	if (desc_to_clean_to >= ring_depth)
+		desc_to_clean_to = (u16)(desc_to_clean_to - ring_depth);
+
+	desc_to_clean_to = buffer_ring[desc_to_clean_to].last_id;
+
+	wb_status = desc_ring[desc_to_clean_to].wb.status;
+	if (!(wb_status & rte_cpu_to_le_32(SXE_TX_DESC_STAT_DD))) {
+		LOG_DEBUG("TX descriptor %4u is not done"
+				"(port=%d queue=%d)",
+				desc_to_clean_to,
+				txq->port_id, txq->queue_idx);
+
+		ret = -SXE_TX_DESC_NO_WB;
+		goto l_end;
+	}
+
+	if (ntc > desc_to_clean_to) {
+		nb_tx_to_clean = (u16)((ring_depth - ntc) +
+						desc_to_clean_to);
+	} else {
+		nb_tx_to_clean = (u16)(desc_to_clean_to - ntc);
+	}
+
+	LOG_DEBUG("Cleaning %4u TX descriptors: %4u to %4u "
+			"(port=%d queue=%d)",
+			nb_tx_to_clean, ntc, desc_to_clean_to,
+			txq->port_id, txq->queue_idx);
+
+	desc_ring[desc_to_clean_to].wb.status = 0;
+
+	txq->next_to_clean = desc_to_clean_to;
+
+	txq->desc_free_num = (u16)(txq->desc_free_num + nb_tx_to_clean);
+
+l_end:
+	return ret;
+}
+
+static inline s32 sxe_tx_pkt_desc_clean(sxe_tx_queue_s *txq,
+			u32 need_desc_num)
+{
+	s32 ret = 0;
+
+	LOG_DEBUG("Not enough free TX descriptors "
+			"need_desc_num=%4u nb_free=%4u "
+			"(port=%d queue=%d)",
+			need_desc_num, txq->desc_free_num,
+			txq->port_id, txq->queue_idx);
+
+	ret = sxe_xmit_cleanup(txq);
+	if (ret)
+		goto l_end;
+
+	if (unlikely(need_desc_num > txq->rs_thresh)) {
+		LOG_DEBUG("The number of descriptors needed to "
+			"transmit the packet exceeds the "
+			"RS bit threshold. This will impact "
+			"performance."
+			"need_desc_num=%4u nb_free=%4u "
+			"rs_thresh=%4u. "
+			"(port=%d queue=%d)",
+			need_desc_num, txq->desc_free_num,
+			txq->rs_thresh,
+			txq->port_id, txq->queue_idx);
+
+		/* Clean up enought desc */
+		while (need_desc_num > txq->desc_free_num) {
+			ret = sxe_xmit_cleanup(txq);
+			if (ret)
+				goto l_end;
+		}
+	}
+
+l_end:
+	return ret;
+}
+
+u16 __sxe_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	s32 ret;
+	u64 ol_req;
+	bool new_ctx;
+	u64 buf_dma_addr;
+	struct rte_mbuf *pkt;
+	struct rte_mbuf *m_seg;
+	union sxe_tx_offload ol_info;
+	sxe_tx_queue_s  *txq = tx_queue;
+	u32 pkt_len, cmd_type_len, olinfo_status;
+	u16 need_desc_num, last_desc_idx, xmit_num, ntu, seg_len;
+	volatile sxe_tx_data_desc_u *tail_desc = NULL;
+	volatile sxe_tx_data_desc_u *desc_ring, *desc;
+	struct sxe_tx_buffer *buffer_ring, *buffer, *next_buffer;
+
+	ol_info.data[SXE_CTXT_DESC_0] = 0;
+	ol_info.data[SXE_CTXT_DESC_1] = 0;
+	ntu		 = txq->next_to_use;
+	desc_ring   = txq->desc_ring;
+	buffer_ring = txq->buffer_ring;
+	buffer	  = &buffer_ring[ntu];
+
+	if (txq->desc_free_num < txq->free_thresh)
+		sxe_xmit_cleanup(txq);
+
+	/* Refresh cache, pre fetch data to cache */
+	rte_sxe_prefetch(&buffer->mbuf->pool);
+
+	for (xmit_num = 0; xmit_num < pkts_num; xmit_num++) {
+		new_ctx = false;
+		pkt = *tx_pkts++;
+		pkt_len = pkt->pkt_len;
+
+		ol_req = pkt->ol_flags & SXE_TX_OFFLOAD_MASK;
+		if (ol_req)
+			new_ctx = sxe_cache_ctxt_desc_match(txq, pkt, ol_req, &ol_info);
+
+		need_desc_num = (u16)(pkt->nb_segs + new_ctx);
+
+		if (tail_desc != NULL &&
+			need_desc_num + txq->desc_used_num >= txq->rs_thresh) {
+			tail_desc->read.cmd_type_len |=
+				rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+		}
+
+		last_desc_idx = (u16)(ntu + need_desc_num - 1);
+
+		if (last_desc_idx >= txq->ring_depth)
+			last_desc_idx = (u16)(last_desc_idx - txq->ring_depth);
+
+		LOG_DEBUG("port_id=%u queue_id=%u pktlen=%u"
+			   " next_to_ues=%u last_desc_idx=%u",
+			   (unsigned int)txq->port_id,
+			   (unsigned int)txq->queue_idx,
+			   (unsigned int)pkt_len,
+			   (unsigned int)ntu,
+			   (unsigned int)last_desc_idx);
+
+		if (need_desc_num > txq->desc_free_num) {
+			ret = sxe_tx_pkt_desc_clean(txq, need_desc_num);
+			if (ret) {
+				if (xmit_num == 0)
+					goto l_end;
+
+				goto l_end_of_tx;
+			}
+		}
+
+		cmd_type_len = SXE_TX_DESC_TYPE_DATA | SXE_TX_DESC_IFCS;
+#ifdef RTE_LIBRTE_IEEE1588
+		if (pkt->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
+			cmd_type_len |= SXE_TXD_MAC_1588;
+#endif
+
+		olinfo_status = 0;
+		if (ol_req) {
+			if (pkt->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+				pkt_len -= (ol_info.l2_len +
+					ol_info.l3_len + ol_info.l4_len);
+			}
+
+			if (new_ctx) {
+				volatile struct sxe_tx_context_desc *ctx_desc;
+
+				ctx_desc = (volatile struct
+					sxe_tx_context_desc *) &desc_ring[ntu];
+
+				next_buffer = &buffer_ring[buffer->next_id];
+				rte_prefetch0(&next_buffer->mbuf->pool);
+
+				if (buffer->mbuf != NULL) {
+					rte_pktmbuf_free_seg(buffer->mbuf);
+					buffer->mbuf = NULL;
+				}
+
+				sxe_ctxt_desc_fill(txq, ctx_desc, ol_req,
+						ol_info, NULL);
+
+				buffer->last_id = last_desc_idx;
+				ntu = buffer->next_id;
+				buffer = next_buffer;
+			}
+
+			LOG_DEBUG("tx need offload, port_id=%u "
+			"queue_id=%u pktlen=%u, ctxt_id=%u",
+			   (unsigned int)txq->port_id,
+			   (unsigned int)txq->queue_idx,
+			   (unsigned int)pkt_len,
+			   (unsigned int)txq->ctx_curr);
+
+			cmd_type_len  |= sxe_tx_desc_cmdtype_setup(pkt->ol_flags);
+			olinfo_status |= sxe_tx_desc_csum_info_setup(pkt->ol_flags);
+			olinfo_status |= txq->ctx_curr << SXE_TXD_IDX_SHIFT;
+		}
+		olinfo_status |= (pkt_len << SXE_TX_DESC_PAYLEN_SHIFT);
+
+		m_seg = pkt;
+		do {
+			desc = &desc_ring[ntu];
+			next_buffer = &buffer_ring[buffer->next_id];
+
+			rte_prefetch0(&next_buffer->mbuf->pool);
+			if (buffer->mbuf != NULL)
+				rte_pktmbuf_free_seg(buffer->mbuf);
+
+			buffer->mbuf = m_seg;
+
+			seg_len = m_seg->data_len;
+
+			buf_dma_addr = rte_mbuf_data_iova(m_seg);
+			desc->read.buffer_addr =
+				rte_cpu_to_le_64(buf_dma_addr);
+			desc->read.cmd_type_len =
+				rte_cpu_to_le_32(cmd_type_len | seg_len);
+			desc->read.olinfo_status =
+				rte_cpu_to_le_32(olinfo_status);
+			buffer->last_id = last_desc_idx;
+			ntu = buffer->next_id;
+			buffer = next_buffer;
+			m_seg = m_seg->next;
+		} while (m_seg != NULL);
+
+		cmd_type_len |= SXE_TX_DESC_EOP_MASK;
+		txq->desc_used_num += need_desc_num;
+		txq->desc_free_num -= need_desc_num;
+
+		if (txq->desc_used_num >= txq->rs_thresh) {
+			LOG_DEBUG("Setting RS bit on TXD id="
+					"%4u (port=%d queue=%d)",
+					last_desc_idx, txq->port_id, txq->queue_idx);
+
+			cmd_type_len |= SXE_TX_DESC_RS_MASK;
+
+			txq->desc_used_num = 0;
+			tail_desc = NULL;
+		} else {
+			tail_desc = desc;
+		}
+
+		desc->read.cmd_type_len |= rte_cpu_to_le_32(cmd_type_len);
+	}
+
+l_end_of_tx:
+	if (tail_desc != NULL)
+		tail_desc->read.cmd_type_len |= rte_cpu_to_le_32(SXE_TX_DESC_RS_MASK);
+
+	rte_wmb();
+
+	LOG_DEBUG("port_id=%u queue_idx=%u next_to_use=%u xmit_num=%u",
+		   (unsigned int)txq->port_id, (unsigned int)txq->queue_idx,
+		   (unsigned int)ntu, (unsigned int)xmit_num);
+
+	rte_write32_wc_relaxed(ntu, txq->tdt_reg_addr);
+
+	txq->next_to_use = ntu;
+
+l_end:
+	return xmit_num;
+}
+
+u16 sxe_pkts_xmit_with_offload(void *tx_queue, struct rte_mbuf **tx_pkts, u16 pkts_num)
+{
+	return __sxe_pkts_xmit_with_offload(tx_queue, tx_pkts, pkts_num);
+}
+
+u32 sxe_tx_done_cleanup_full(sxe_tx_queue_s *txq, u32 free_cnt)
+{
+	u32 pkt_cnt;
+	u16 i, ntu, tx_id;
+	u16 nb_tx_free_last;
+	u16 nb_tx_to_clean;
+	struct sxe_tx_buffer *buffer_ring = txq->buffer_ring;
+
+	ntu	= txq->next_to_use;
+	tx_id  = buffer_ring[ntu].next_id;
+
+	if (txq->desc_free_num == 0 && sxe_xmit_cleanup(txq)) {
+		pkt_cnt = 0;
+		goto l_end;
+	}
+
+	nb_tx_to_clean  = txq->desc_free_num;
+	nb_tx_free_last = txq->desc_free_num;
+
+	if (!free_cnt)
+		free_cnt = txq->ring_depth;
+
+	for (pkt_cnt = 0; pkt_cnt < free_cnt; ) {
+		for (i = 0; i < (nb_tx_to_clean && pkt_cnt < free_cnt &&
+			tx_id != ntu); i++) {
+			if (buffer_ring[tx_id].mbuf != NULL) {
+				rte_pktmbuf_free_seg(buffer_ring[tx_id].mbuf);
+				buffer_ring[tx_id].mbuf = NULL;
+
+				pkt_cnt += (buffer_ring[tx_id].last_id == tx_id);
+			}
+
+			tx_id = buffer_ring[tx_id].next_id;
+		}
+
+		if (txq->rs_thresh > txq->ring_depth - txq->desc_free_num ||
+				tx_id == ntu) {
+			break;
+		}
+
+		if (pkt_cnt < free_cnt) {
+			if (sxe_xmit_cleanup(txq))
+				break;
+
+			nb_tx_to_clean = txq->desc_free_num - nb_tx_free_last;
+			nb_tx_free_last = txq->desc_free_num;
+		}
+	}
+
+l_end:
+	return pkt_cnt;
+}
+
+int sxe_tx_done_cleanup_simple(sxe_tx_queue_s *txq, u32 free_cnt)
+{
+	int i, n, cnt;
+
+	if (free_cnt == 0 || free_cnt > txq->ring_depth)
+		free_cnt = txq->ring_depth;
+
+	cnt = free_cnt - free_cnt % txq->rs_thresh;
+
+	for (i = 0; i < cnt; i += n) {
+		if (txq->ring_depth - txq->desc_free_num < txq->rs_thresh)
+			break;
+
+		n = sxe_tx_bufs_free(txq);
+		if (n == 0)
+			break;
+	}
+
+	return i;
+}
+
+int sxe_tx_done_cleanup(void *tx_queue, u32 free_cnt)
+{
+	s32 ret;
+
+	ret = __sxe_tx_done_cleanup(tx_queue, free_cnt);
+	if (ret)
+		PMD_LOG_ERR(INIT, "tx cleanup fail.(err:%d)", ret);
+
+	return ret;
+}
+
+int sxe_tx_descriptor_status(void *tx_queue, u16 offset)
+{
+	return __sxe_tx_descriptor_status(tx_queue, offset);
+}
diff --git a/drivers/net/sxe/pf/sxe_tx.h b/drivers/net/sxe/pf/sxe_tx.h
new file mode 100644
index 0000000000..730a9eaee2
--- /dev/null
+++ b/drivers/net/sxe/pf/sxe_tx.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (C), 2022, Linkdata Technology Co., Ltd.
+ */
+#ifndef __SXE_TX_H__
+#define __SXE_TX_H__
+
+#include <rte_mbuf_core.h>
+
+#include "sxe_queue.h"
+
+#define RTE_PMD_SXE_MAX_TX_BURST 32
+
+#ifdef RTE_LIBRTE_IEEE1588
+#define SXE_TX_IEEE1588_TMST RTE_MBUF_F_TX_IEEE1588_TMST
+#else
+#define SXE_TX_IEEE1588_TMST 0
+#endif
+
+#define SXE_TX_OFFLOAD_MASK (			 \
+		RTE_MBUF_F_TX_OUTER_IPV6 |		 \
+		RTE_MBUF_F_TX_OUTER_IPV4 |		 \
+		RTE_MBUF_F_TX_IPV6 |			 \
+		RTE_MBUF_F_TX_IPV4 |			 \
+		RTE_MBUF_F_TX_VLAN |		 \
+		RTE_MBUF_F_TX_IP_CKSUM |		 \
+		RTE_MBUF_F_TX_L4_MASK |		 \
+		RTE_MBUF_F_TX_TCP_SEG |		 \
+		RTE_MBUF_F_TX_MACSEC  |	  \
+		RTE_MBUF_F_TX_OUTER_IP_CKSUM |		 \
+		SXE_TX_IEEE1588_TMST)
+
+void __rte_cold sxe_tx_configure(struct rte_eth_dev *dev);
+
+int __rte_cold sxe_tx_queue_setup(struct rte_eth_dev *dev,
+				u16 tx_queue_id,
+				u16 ring_depth,
+				u32 socket_id,
+				const struct rte_eth_txconf *tx_conf);
+int sxe_tx_done_cleanup(void *tx_queue, u32 free_cnt);
+
+void __rte_cold sxe_tx_function_set(struct rte_eth_dev *dev,
+					sxe_tx_queue_s *txq);
+
+int sxe_tx_done_cleanup_simple(sxe_tx_queue_s *txq, u32 free_cnt);
+
+u32 sxe_tx_done_cleanup_full(sxe_tx_queue_s *txq, u32 free_cnt);
+
+s32 sxe_tx_bufs_free(sxe_tx_queue_s *txq);
+
+#endif
-- 
2.18.2

