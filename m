Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA822CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 09:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B121406BB;
	Fri, 22 Aug 2025 11:04:17 +0200 (CEST)
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com
 [115.124.28.221])
 by mails.dpdk.org (Postfix) with ESMTP id 7BA0540670
 for <dev@dpdk.org>; Fri, 22 Aug 2025 11:04:11 +0200 (CEST)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.eN-JeeT_1755853448 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 22 Aug 2025 17:04:09 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v6 04/17] net/nbl: add Channel layer definitions and
 implementation
Date: Fri, 22 Aug 2025 02:03:46 -0700
Message-Id: <20250822090359.614551-5-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

add Channel layer related definitions and nbl_thread
for mbx interact

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/meson.build                   |   2 +
 drivers/net/nbl/nbl_common/nbl_common.c       |  47 ++
 drivers/net/nbl/nbl_common/nbl_common.h       |  10 +
 drivers/net/nbl/nbl_core.c                    |  11 +-
 drivers/net/nbl/nbl_core.h                    |   6 +
 drivers/net/nbl/nbl_hw/nbl_channel.c          | 798 ++++++++++++++++++
 drivers/net/nbl/nbl_hw/nbl_channel.h          | 120 +++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c | 123 +++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h |  43 +
 drivers/net/nbl/nbl_include/nbl_def_channel.h | 339 ++++++++
 drivers/net/nbl/nbl_include/nbl_def_common.h  |  31 +
 drivers/net/nbl/nbl_include/nbl_include.h     |   9 +
 12 files changed, 1537 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.c
 create mode 100644 drivers/net/nbl/nbl_hw/nbl_channel.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/nbl/nbl_include/nbl_def_common.h

diff --git a/drivers/net/nbl/meson.build b/drivers/net/nbl/meson.build
index dca81f9586..af13a42924 100644
--- a/drivers/net/nbl/meson.build
+++ b/drivers/net/nbl/meson.build
@@ -12,5 +12,7 @@ includes += include_directories('nbl_hw')
 sources = files(
         'nbl_ethdev.c',
         'nbl_core.c',
+        'nbl_common/nbl_common.c',
+        'nbl_hw/nbl_channel.c',
         'nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c',
 )
diff --git a/drivers/net/nbl/nbl_common/nbl_common.c b/drivers/net/nbl/nbl_common/nbl_common.c
new file mode 100644
index 0000000000..bded42c358
--- /dev/null
+++ b/drivers/net/nbl/nbl_common/nbl_common.c
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_common.h"
+
+static uint32_t nbl_dma_memzone_id;
+
+/**
+ * @brief: used to alloc continuous dma memory region for cmd buffer
+ * @mem: output, the memory object containing va, pa and size of memory
+ * @size: input, memory size in bytes
+ * @return: memory virtual address for cpu usage
+ */
+void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size)
+{
+	const struct rte_memzone *mz = NULL;
+	char z_name[RTE_MEMZONE_NAMESIZE];
+
+	if (!mem)
+		return NULL;
+
+	snprintf(z_name, sizeof(z_name), "nbl_dma_%u", nbl_dma_memzone_id++);
+	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
+					 0, RTE_PGSIZE_2M);
+	if (!mz)
+		return NULL;
+
+	mem->size = size;
+	mem->va = mz->addr;
+	mem->pa = mz->iova;
+	mem->mz = mz;
+
+	return mem->va;
+}
+
+/**
+ * @brief: used to free dma memory region
+ * @mem: input, the memory object
+ */
+void nbl_free_dma_mem(struct nbl_dma_mem *mem)
+{
+	rte_memzone_free(mem->mz);
+	mem->mz = NULL;
+	mem->va = NULL;
+	mem->pa = (uint64_t)0;
+}
diff --git a/drivers/net/nbl/nbl_common/nbl_common.h b/drivers/net/nbl/nbl_common/nbl_common.h
new file mode 100644
index 0000000000..7ff028f5a9
--- /dev/null
+++ b/drivers/net/nbl/nbl_common/nbl_common.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_COMMON_H_
+#define _NBL_COMMON_H_
+
+#include "nbl_ethdev.h"
+
+#endif
diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index decab211d3..d2bc0d1bfa 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -10,8 +10,8 @@ const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 		.hw_remove	= nbl_hw_remove_leonis_snic,
 		.res_init	= NULL,
 		.res_remove	= NULL,
-		.chan_init	= NULL,
-		.chan_remove	= NULL,
+		.chan_init	= nbl_chan_init_leonis,
+		.chan_remove	= nbl_chan_remove_leonis,
 	},
 };
 
@@ -45,8 +45,14 @@ int nbl_core_init(struct nbl_adapter *adapter, const struct rte_eth_dev *eth_dev
 	if (ret)
 		goto hw_init_fail;
 
+	ret = product_base_ops->chan_init(adapter);
+	if (ret)
+		goto chan_init_fail;
+
 	return 0;
 
+chan_init_fail:
+	product_base_ops->hw_remove(adapter);
 hw_init_fail:
 	return -EINVAL;
 }
@@ -57,6 +63,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	product_base_ops = nbl_core_get_product_ops(adapter->caps.product_type);
 
+	product_base_ops->chan_remove(adapter);
 	product_base_ops->hw_remove(adapter);
 }
 
diff --git a/drivers/net/nbl/nbl_core.h b/drivers/net/nbl/nbl_core.h
index 036f04b395..80d286ab97 100644
--- a/drivers/net/nbl/nbl_core.h
+++ b/drivers/net/nbl/nbl_core.h
@@ -6,7 +6,9 @@
 #define _NBL_CORE_H_
 
 #include "nbl_product_base.h"
+#include "nbl_def_common.h"
 #include "nbl_def_hw.h"
+#include "nbl_def_channel.h"
 
 #define NBL_VENDOR_ID				(0x1F0F)
 #define NBL_DEVICE_ID_M18110			(0x3403)
@@ -30,7 +32,10 @@
 #define NBL_MAX_INSTANCE_CNT 516
 
 #define NBL_ADAPTER_TO_HW_MGT(adapter)		((adapter)->core.hw_mgt)
+#define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
+
 #define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
+#define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
 
 struct nbl_core {
 	void *hw_mgt;
@@ -42,6 +47,7 @@ struct nbl_core {
 
 struct nbl_interface {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
 struct nbl_adapter {
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
new file mode 100644
index 0000000000..15efbeba3c
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -0,0 +1,798 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#include "nbl_channel.h"
+
+static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack);
+
+static void nbl_chan_init_queue_param(union nbl_chan_info *chan_info,
+				      u16 num_txq_entries, u16 num_rxq_entries,
+				      u16 txq_buf_size, u16 rxq_buf_size)
+{
+	rte_spinlock_init(&chan_info->mailbox.txq_lock);
+	chan_info->mailbox.num_txq_entries = num_txq_entries;
+	chan_info->mailbox.num_rxq_entries = num_rxq_entries;
+	chan_info->mailbox.txq_buf_size = txq_buf_size;
+	chan_info->mailbox.rxq_buf_size = rxq_buf_size;
+}
+
+static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->mailbox.txq;
+	size_t size = chan_info->mailbox.num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+
+	txq->desc = nbl_alloc_dma_mem(&txq->desc_mem, size);
+	if (!txq->desc) {
+		NBL_LOG(ERR, "Allocate DMA for chan tx descriptor ring failed");
+		return -ENOMEM;
+	}
+
+	chan_info->mailbox.wait = rte_calloc("nbl_chan_wait", chan_info->mailbox.num_txq_entries,
+					     sizeof(struct nbl_chan_waitqueue_head), 0);
+	if (!chan_info->mailbox.wait) {
+		NBL_LOG(ERR, "Allocate Txq wait_queue_head array failed");
+		goto req_wait_queue_failed;
+	}
+
+	size = chan_info->mailbox.num_txq_entries * chan_info->mailbox.txq_buf_size;
+	txq->buf = nbl_alloc_dma_mem(&txq->buf_mem, size);
+	if (!txq->buf) {
+		NBL_LOG(ERR, "Allocate memory for chan tx buffer arrays failed");
+		goto req_num_txq_entries;
+	}
+
+	return 0;
+
+req_num_txq_entries:
+	rte_free(chan_info->mailbox.wait);
+req_wait_queue_failed:
+	nbl_free_dma_mem(&txq->desc_mem);
+	txq->desc = NULL;
+	chan_info->mailbox.wait = NULL;
+
+	return -ENOMEM;
+}
+
+static int nbl_chan_init_rx_queue(union nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
+	size_t size = chan_info->mailbox.num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+
+	rxq->desc = nbl_alloc_dma_mem(&rxq->desc_mem, size);
+	if (!rxq->desc) {
+		NBL_LOG(ERR, "Allocate DMA for chan rx descriptor ring failed");
+		return -ENOMEM;
+	}
+
+	size = chan_info->mailbox.num_rxq_entries * chan_info->mailbox.rxq_buf_size;
+	rxq->buf = nbl_alloc_dma_mem(&rxq->buf_mem, size);
+	if (!rxq->buf) {
+		NBL_LOG(ERR, "Allocate memory for chan rx buffer arrays failed");
+		nbl_free_dma_mem(&rxq->desc_mem);
+		rxq->desc = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void nbl_chan_remove_tx_queue(union nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *txq = &chan_info->mailbox.txq;
+
+	nbl_free_dma_mem(&txq->buf_mem);
+	txq->buf = NULL;
+
+	rte_free(chan_info->mailbox.wait);
+	chan_info->mailbox.wait = NULL;
+
+	nbl_free_dma_mem(&txq->desc_mem);
+	txq->desc = NULL;
+}
+
+static void nbl_chan_remove_rx_queue(union nbl_chan_info *chan_info)
+{
+	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
+
+	nbl_free_dma_mem(&rxq->buf_mem);
+	rxq->buf = NULL;
+
+	nbl_free_dma_mem(&rxq->desc_mem);
+	rxq->desc = NULL;
+}
+
+static int nbl_chan_init_queue(union nbl_chan_info *chan_info)
+{
+	int err;
+
+	err = nbl_chan_init_tx_queue(chan_info);
+	if (err)
+		return err;
+
+	err = nbl_chan_init_rx_queue(chan_info);
+	if (err)
+		goto setup_rx_queue_err;
+
+	return 0;
+
+setup_rx_queue_err:
+	nbl_chan_remove_tx_queue(chan_info);
+	return err;
+}
+
+static void nbl_chan_config_queue(struct nbl_channel_mgt *chan_mgt,
+				  union nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
+	struct nbl_chan_ring *txq = &chan_info->mailbox.txq;
+	int size_bwid = rte_log2_u32(chan_info->mailbox.num_rxq_entries);
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	hw_ops->config_mailbox_rxq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt),
+				    rxq->desc_mem.pa, size_bwid);
+	hw_ops->config_mailbox_txq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt),
+				    txq->desc_mem.pa, size_bwid);
+}
+
+#define NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, tail_ptr, qid)			\
+do {											\
+	typeof(hw_ops) _hw_ops = (hw_ops);						\
+	typeof(chan_mgt) _chan_mgt = (chan_mgt);					\
+	typeof(tail_ptr) _tail_ptr = (tail_ptr);					\
+	typeof(qid) _qid = (qid);							\
+	(_hw_ops)->update_mailbox_queue_tail_ptr(NBL_CHAN_MGT_TO_HW_PRIV(_chan_mgt),	\
+							_tail_ptr, _qid);		\
+} while (0)
+
+static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
+				    union nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
+	struct nbl_chan_rx_desc *desc;
+	void *hw_priv;
+	u16 rx_tail_ptr;
+	u32 retry_times = 0;
+	u16 i;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+	desc = rxq->desc;
+	for (i = 0; i < chan_info->mailbox.num_rxq_entries - 1; i++) {
+		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
+		desc[i].buf_addr = rxq->buf_mem.pa + i * chan_info->mailbox.rxq_buf_size;
+		desc[i].buf_len = chan_info->mailbox.rxq_buf_size;
+	}
+
+	rxq->next_to_clean = 0;
+	rxq->next_to_use = chan_info->mailbox.num_rxq_entries - 1;
+	rxq->tail_ptr = chan_info->mailbox.num_rxq_entries - 1;
+	rte_mb();
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, rxq->tail_ptr, NBL_MB_RX_QID);
+
+	while (retry_times < 100) {
+		hw_priv = NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt);
+
+		rx_tail_ptr = hw_ops->get_mailbox_rx_tail_ptr(hw_priv);
+
+		if (rx_tail_ptr != rxq->tail_ptr)
+			NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, rxq->tail_ptr, NBL_MB_RX_QID);
+		else
+			break;
+
+		rte_delay_us(NBL_CHAN_TX_WAIT_US * 50);
+		retry_times++;
+	}
+
+	return 0;
+}
+
+static void nbl_chan_stop_queue(struct nbl_channel_mgt *chan_mgt)
+{
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	hw_ops->stop_mailbox_rxq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+	hw_ops->stop_mailbox_txq(NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt));
+}
+
+static void nbl_chan_remove_queue(union nbl_chan_info *chan_info)
+{
+	nbl_chan_remove_tx_queue(chan_info);
+	nbl_chan_remove_rx_queue(chan_info);
+}
+
+static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
+				 union nbl_chan_info *chan_info)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_ring *txq;
+	struct nbl_chan_tx_desc *tx_desc;
+	int i;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	txq = &chan_info->mailbox.txq;
+	rte_mb();
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, txq->tail_ptr, NBL_MB_TX_QID);
+
+	tx_desc = NBL_CHAN_TX_DESC(txq, txq->next_to_clean);
+
+	i = 0;
+	while (!(tx_desc->flags & NBL_CHAN_TX_DESC_USED)) {
+		rte_delay_us(NBL_CHAN_TX_WAIT_US);
+		i++;
+
+		if (!(i % NBL_CHAN_TX_REKICK_WAIT_TIMES))
+			NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, txq->tail_ptr, NBL_MB_TX_QID);
+
+		if (i == NBL_CHAN_TX_WAIT_TIMES) {
+			NBL_LOG(ERR, "chan send message type: %d timeout",
+				tx_desc->msg_type);
+			return -1;
+		}
+	}
+
+	txq->next_to_clean = txq->next_to_use;
+	return 0;
+}
+
+static void nbl_chan_recv_ack_msg(void *priv, uint16_t srcid, uint16_t msgid,
+				  void *data, uint32_t data_len)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NULL;
+	struct nbl_chan_waitqueue_head *wait_head;
+	uint32_t *payload = (uint32_t *)data;
+	uint32_t ack_msgid;
+	uint32_t ack_msgtype;
+	uint32_t copy_len;
+
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	ack_msgtype = *payload;
+	ack_msgid = *(payload + 1);
+	wait_head = &chan_info->mailbox.wait[ack_msgid];
+	wait_head->ack_err = *(payload + 2);
+
+	if (wait_head->ack_err >= 0 && (data_len > 3 * sizeof(uint32_t))) {
+		if (data_len - 3 * sizeof(uint32_t) != wait_head->ack_data_len)
+			NBL_LOG(ERR, "payload_len do not match ack_len!,"
+				" srcid:%u, msgtype:%u, msgid:%u, ack_msgid %u,"
+				" data_len:%u, ack_data_len:%u",
+				srcid, ack_msgtype, msgid,
+				ack_msgid, data_len, wait_head->ack_data_len);
+		copy_len = RTE_MIN((u32)wait_head->ack_data_len,
+				   (u32)data_len - 3 * sizeof(uint32_t));
+		rte_memcpy(wait_head->ack_data, payload + 3, copy_len);
+	}
+
+	/* wmb */
+	rte_wmb();
+	wait_head->acked = 1;
+}
+
+static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
+{
+	struct nbl_chan_ack_info chan_ack;
+	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_msg_handler *msg_handler;
+	u16 msg_type, payload_len, srcid, msgid;
+	void *payload;
+
+	tx_desc = data;
+	msg_type = tx_desc->msg_type;
+
+	srcid = tx_desc->srcid;
+	msgid = tx_desc->msgid;
+	if (msg_type >= NBL_CHAN_MSG_MAX) {
+		NBL_LOG(ERR, "Invalid chan message type %hu", msg_type);
+		return;
+	}
+
+	if (tx_desc->data_len) {
+		payload = (void *)tx_desc->data;
+		payload_len = tx_desc->data_len;
+	} else {
+		payload = (void *)(tx_desc + 1);
+		payload_len = tx_desc->buf_len;
+	}
+
+	msg_handler = &chan_mgt->msg_handler[msg_type];
+	if (!msg_handler->func) {
+		NBL_CHAN_ACK(chan_ack, srcid, msg_type, msgid, -EPERM, NULL, 0);
+		nbl_chan_send_ack(chan_mgt, &chan_ack);
+		NBL_LOG(ERR, "msg:%u no func, check af-driver is ok", msg_type);
+		return;
+	}
+
+	msg_handler->func(msg_handler->priv, srcid, msgid, payload, payload_len);
+}
+
+static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
+				     union nbl_chan_info *chan_info,
+				     struct nbl_chan_ring *rxq)
+{
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_chan_rx_desc *rx_desc;
+	u16 next_to_use;
+
+	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
+
+	next_to_use = rxq->next_to_use;
+	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_use);
+
+	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
+	rx_desc->buf_addr = rxq->buf_mem.pa + chan_info->mailbox.rxq_buf_size * next_to_use;
+	rx_desc->buf_len = chan_info->mailbox.rxq_buf_size;
+
+	/* wmb */
+	rte_wmb();
+	rxq->next_to_use++;
+	if (rxq->next_to_use == chan_info->mailbox.num_rxq_entries)
+		rxq->next_to_use = 0;
+	rxq->tail_ptr++;
+
+	NBL_UPDATE_QUEUE_TAIL_PTR(hw_ops, chan_mgt, rxq->tail_ptr, NBL_MB_RX_QID);
+}
+
+static void nbl_chan_clean_queue(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
+	struct nbl_chan_rx_desc *rx_desc;
+	u8 *data;
+	u16 next_to_clean;
+
+	next_to_clean = rxq->next_to_clean;
+	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_clean);
+	data = (u8 *)rxq->buf + next_to_clean * chan_info->mailbox.rxq_buf_size;
+	while (rx_desc->flags & NBL_CHAN_RX_DESC_USED) {
+		rte_rmb();
+		nbl_chan_recv_msg(chan_mgt, data);
+
+		nbl_chan_advance_rx_ring(chan_mgt, chan_info, rxq);
+
+		next_to_clean++;
+		if (next_to_clean == chan_info->mailbox.num_rxq_entries)
+			next_to_clean = 0;
+		rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_clean);
+		data = (u8 *)rxq->buf + next_to_clean * chan_info->mailbox.rxq_buf_size;
+	}
+	rxq->next_to_clean = next_to_clean;
+}
+
+static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
+					uint16_t dstid,
+					enum nbl_chan_msg_type msg_type,
+					void *arg, size_t arg_len)
+{
+	struct nbl_chan_ring *txq;
+	struct nbl_chan_tx_desc *tx_desc;
+	uint64_t pa;
+	void *va;
+	uint16_t next_to_use;
+
+	txq = &chan_info->mailbox.txq;
+	next_to_use = txq->next_to_use;
+	va = (u8 *)txq->buf + next_to_use * chan_info->mailbox.txq_buf_size;
+	pa = txq->buf_mem.pa + next_to_use * chan_info->mailbox.txq_buf_size;
+	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
+
+	tx_desc->dstid = dstid;
+	tx_desc->msg_type = msg_type;
+	tx_desc->msgid = next_to_use;
+	if (arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc)) {
+		NBL_LOG(ERR, "arg_len: %zu, too long!", arg_len);
+		return -1;
+	}
+
+	if (arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
+		memcpy(va, arg, arg_len);
+		tx_desc->buf_addr = pa;
+		tx_desc->buf_len = arg_len;
+		tx_desc->data_len = 0;
+	} else {
+		memcpy(tx_desc->data, arg, arg_len);
+		tx_desc->buf_len = 0;
+		tx_desc->data_len = arg_len;
+	}
+	tx_desc->flags = NBL_CHAN_TX_DESC_AVAIL;
+
+	/* wmb */
+	rte_wmb();
+	txq->next_to_use++;
+	if (txq->next_to_use == chan_info->mailbox.num_txq_entries)
+		txq->next_to_use = 0;
+	txq->tail_ptr++;
+
+	return next_to_use;
+}
+
+static int nbl_chan_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NULL;
+	struct nbl_chan_waitqueue_head *wait_head;
+	uint16_t msgid;
+	int ret;
+	int retry_time = 0;
+
+	if (chan_mgt->state)
+		return -EIO;
+
+	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	rte_spinlock_lock(&chan_info->mailbox.txq_lock);
+	msgid = nbl_chan_update_txqueue(chan_info, chan_send->dstid,
+					chan_send->msg_type,
+					chan_send->arg, chan_send->arg_len);
+
+	if (msgid == 0xFFFF) {
+		rte_spinlock_unlock(&chan_info->mailbox.txq_lock);
+		NBL_LOG(ERR, "chan tx queue full, send msgtype:%u"
+			" to dstid:%u failed",
+			chan_send->msg_type, chan_send->dstid);
+		return -ECOMM;
+	}
+
+	if (!chan_send->ack) {
+		ret = nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+		rte_spinlock_unlock(&chan_info->mailbox.txq_lock);
+		return ret;
+	}
+
+	wait_head = &chan_info->mailbox.wait[msgid];
+	wait_head->ack_data = chan_send->resp;
+	wait_head->ack_data_len = chan_send->resp_len;
+	wait_head->acked = 0;
+	wait_head->msg_type = chan_send->msg_type;
+	rte_wmb();
+	nbl_chan_kick_tx_ring(chan_mgt, chan_info);
+	rte_spinlock_unlock(&chan_info->mailbox.txq_lock);
+
+	while (1) {
+		if (wait_head->acked) {
+			rte_rmb();
+			return wait_head->ack_err;
+		}
+
+		rte_delay_us(50);
+		retry_time++;
+		if (retry_time > NBL_CHAN_RETRY_TIMES)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	struct nbl_chan_send_info chan_send;
+	u32 *tmp;
+	u32 len = 3 * sizeof(u32) + chan_ack->data_len;
+
+	tmp = rte_zmalloc("nbl_chan_send_tmp", len, 0);
+	if (!tmp) {
+		NBL_LOG(ERR, "Chan send ack data malloc failed");
+		return -ENOMEM;
+	}
+
+	tmp[0] = chan_ack->msg_type;
+	tmp[1] = chan_ack->msgid;
+	tmp[2] = (u32)chan_ack->err;
+	if (chan_ack->data && chan_ack->data_len)
+		memcpy(&tmp[3], chan_ack->data, chan_ack->data_len);
+
+	NBL_CHAN_SEND(chan_send, chan_ack->dstid, NBL_CHAN_MSG_ACK, tmp, len, NULL, 0, 0);
+	nbl_chan_send_msg(chan_mgt, &chan_send);
+	rte_free(tmp);
+
+	return 0;
+}
+
+static int nbl_chan_register_msg(void *priv, uint16_t msg_type, nbl_chan_resp func,
+				 void *callback_priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	chan_mgt->msg_handler[msg_type].priv = callback_priv;
+	chan_mgt->msg_handler[msg_type].func = func;
+
+	return 0;
+}
+
+static uint32_t nbl_chan_thread_polling_task(void *param)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)param;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	struct timespec time;
+	char unused[16];
+	ssize_t nr = 0;
+
+	time.tv_sec = 0;
+	time.tv_nsec = 100000;
+
+	while (true) {
+		if (rte_bitmap_get(chan_info->mailbox.state_bmp, NBL_CHAN_INTERRUPT_READY)) {
+			nr = read(chan_info->mailbox.fd[0], &unused, sizeof(unused));
+			if (nr < 0)
+				break;
+		}
+		nbl_chan_clean_queue(chan_mgt);
+		nanosleep(&time, 0);
+	}
+
+	return 0;
+}
+
+static int nbl_chan_task_init(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	int ret = 0;
+
+	ret = pipe(chan_info->mailbox.fd);
+	if (ret) {
+		NBL_LOG(ERR, "pipe failed, ret %d", ret);
+		return ret;
+	}
+
+	ret = rte_thread_create_internal_control(&chan_info->mailbox.tid, "nbl_mailbox_thread",
+						 nbl_chan_thread_polling_task, chan_mgt);
+	if (ret) {
+		NBL_LOG(ERR, "create mailbox thread failed, ret %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int nbl_chan_task_finish(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
+	close(chan_info->mailbox.fd[0]);
+	close(chan_info->mailbox.fd[1]);
+	chan_info->mailbox.fd[0] = -1;
+	chan_info->mailbox.fd[1] = -1;
+	rte_thread_join(chan_info->mailbox.tid, NULL);
+	return 0;
+}
+
+static int nbl_chan_notify_interrupt(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	char notify_byte = 0;
+	ssize_t nw = 0;
+
+	nw = write(chan_info->mailbox.fd[1], &notify_byte, 1);
+	RTE_SET_USED(nw);
+	return 0;
+}
+
+static int nbl_chan_teardown_queue(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	nbl_chan_task_finish(chan_mgt);
+	nbl_chan_stop_queue(chan_mgt);
+	nbl_chan_remove_queue(chan_info);
+
+	return 0;
+}
+
+static int nbl_chan_setup_queue(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	int err;
+
+	nbl_chan_init_queue_param(chan_info, NBL_CHAN_QUEUE_LEN,
+				  NBL_CHAN_QUEUE_LEN,  NBL_CHAN_BUF_LEN,
+				  NBL_CHAN_BUF_LEN);
+
+	err = nbl_chan_init_queue(chan_info);
+	if (err)
+		return err;
+
+	err = nbl_chan_task_init(chan_mgt);
+	if (err)
+		goto tear_down;
+
+	nbl_chan_config_queue(chan_mgt, chan_info);
+
+	err = nbl_chan_prepare_rx_bufs(chan_mgt, chan_info);
+	if (err)
+		goto tear_down;
+
+	return 0;
+
+tear_down:
+	nbl_chan_teardown_queue(chan_mgt);
+	return err;
+}
+
+static void nbl_chan_set_state(void *priv, enum nbl_chan_state state)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	chan_mgt->state = state;
+}
+
+static void nbl_chan_set_queue_state(void *priv, enum nbl_chan_queue_state state, u8 set)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	if (set)
+		rte_bitmap_set(chan_info->mailbox.state_bmp, state);
+	else
+		rte_bitmap_clear(chan_info->mailbox.state_bmp, state);
+}
+
+static struct nbl_channel_ops chan_ops = {
+	.send_msg			= nbl_chan_send_msg,
+	.send_ack			= nbl_chan_send_ack,
+	.register_msg			= nbl_chan_register_msg,
+	.setup_queue			= nbl_chan_setup_queue,
+	.teardown_queue			= nbl_chan_teardown_queue,
+	.set_state			= nbl_chan_set_state,
+	.set_queue_state		= nbl_chan_set_queue_state,
+	.notify_interrupt		= nbl_chan_notify_interrupt,
+};
+
+static int nbl_chan_init_state_bitmap(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	int n_bits = NBL_CHAN_STATE_NBITS;
+	uint32_t cnt_bmp_size;
+	void *state_bmp_mem;
+	struct rte_bitmap *state_bmp;
+
+	cnt_bmp_size = rte_bitmap_get_memory_footprint(n_bits);
+	state_bmp_mem = rte_zmalloc("nbl_state_bitmap", cnt_bmp_size, 0);
+	if (!state_bmp_mem) {
+		NBL_LOG(ERR, "alloc nbl_state_bitmap mem failed");
+		return -ENOMEM;
+	}
+	state_bmp = rte_bitmap_init(n_bits, state_bmp_mem, cnt_bmp_size);
+	if (!state_bmp) {
+		NBL_LOG(ERR, "state bitmap init failed");
+		rte_free(state_bmp_mem);
+		state_bmp_mem = NULL;
+		return -ENOMEM;
+	}
+	chan_info->mailbox.state_bmp_mem = state_bmp_mem;
+	chan_info->mailbox.state_bmp = state_bmp;
+	return 0;
+}
+
+static void nbl_chan_remove_state_bitmap(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+
+	if (chan_info->mailbox.state_bmp) {
+		rte_bitmap_free(chan_info->mailbox.state_bmp);
+		chan_info->mailbox.state_bmp = NULL;
+	}
+	if (chan_info->mailbox.state_bmp_mem) {
+		rte_free(chan_info->mailbox.state_bmp_mem);
+		chan_info->mailbox.state_bmp_mem = NULL;
+	}
+}
+
+static int nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
+				   struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	union nbl_chan_info *mailbox;
+	int ret = 0;
+
+	hw_ops_tbl = NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
+
+	*chan_mgt_leonis = rte_zmalloc("nbl_chan_mgt", sizeof(struct nbl_channel_mgt_leonis), 0);
+	if (!*chan_mgt_leonis)
+		goto alloc_channel_mgt_leonis_fail;
+
+	(*chan_mgt_leonis)->chan_mgt.hw_ops_tbl = hw_ops_tbl;
+
+	mailbox = rte_zmalloc("nbl_mailbox", sizeof(union nbl_chan_info), 0);
+	if (!mailbox)
+		goto alloc_mailbox_fail;
+
+	NBL_CHAN_MGT_TO_CHAN_INFO(&(*chan_mgt_leonis)->chan_mgt) = mailbox;
+
+	ret = nbl_chan_init_state_bitmap(*chan_mgt_leonis);
+	if (ret)
+		goto state_bitmap_init_fail;
+
+	return 0;
+
+state_bitmap_init_fail:
+alloc_mailbox_fail:
+	rte_free(*chan_mgt_leonis);
+alloc_channel_mgt_leonis_fail:
+	return -ENOMEM;
+}
+
+static void nbl_chan_remove_chan_mgt(struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+{
+	nbl_chan_remove_state_bitmap(*chan_mgt_leonis);
+	rte_free(NBL_CHAN_MGT_TO_CHAN_INFO(&(*chan_mgt_leonis)->chan_mgt));
+	rte_free(*chan_mgt_leonis);
+	*chan_mgt_leonis = NULL;
+}
+
+static void nbl_chan_remove_ops(struct nbl_channel_ops_tbl **chan_ops_tbl)
+{
+	free(*chan_ops_tbl);
+	*chan_ops_tbl = NULL;
+}
+
+static int nbl_chan_setup_ops(struct nbl_channel_ops_tbl **chan_ops_tbl,
+			      struct nbl_channel_mgt_leonis *chan_mgt_leonis)
+{
+	*chan_ops_tbl = calloc(1, sizeof(struct nbl_channel_ops_tbl));
+	if (!*chan_ops_tbl)
+		return -ENOMEM;
+
+	NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
+	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt_leonis;
+
+	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].func = nbl_chan_recv_ack_msg;
+	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].priv = chan_mgt_leonis;
+
+	return 0;
+}
+
+int nbl_chan_init_leonis(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+	int ret = 0;
+
+	chan_mgt_leonis = (struct nbl_channel_mgt_leonis **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
+	chan_ops_tbl = &NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+
+	ret = nbl_chan_setup_chan_mgt(adapter, chan_mgt_leonis);
+	if (ret)
+		goto setup_mgt_fail;
+
+	ret = nbl_chan_setup_ops(chan_ops_tbl, *chan_mgt_leonis);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_chan_remove_chan_mgt(chan_mgt_leonis);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_chan_remove_leonis(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_ops_tbl **chan_ops_tbl;
+
+	chan_mgt_leonis = (struct nbl_channel_mgt_leonis **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
+	chan_ops_tbl = &NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+
+	nbl_chan_remove_chan_mgt(chan_mgt_leonis);
+	nbl_chan_remove_ops(chan_ops_tbl);
+}
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.h b/drivers/net/nbl/nbl_hw/nbl_channel.h
new file mode 100644
index 0000000000..ec46412a29
--- /dev/null
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_CHANNEL_H_
+#define _NBL_CHANNEL_H_
+
+#include "nbl_ethdev.h"
+
+#define NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)	((chan_mgt)->hw_ops_tbl)
+#define NBL_CHAN_MGT_TO_HW_OPS(chan_mgt)	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->ops)
+#define NBL_CHAN_MGT_TO_HW_PRIV(chan_mgt)	(NBL_CHAN_MGT_TO_HW_OPS_TBL(chan_mgt)->priv)
+#define NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt)	((chan_mgt)->chan_info)
+
+#define NBL_CHAN_TX_DESC(tx_ring, i) \
+	(&(((struct nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
+#define NBL_CHAN_RX_DESC(rx_ring, i) \
+	(&(((struct nbl_chan_rx_desc *)((rx_ring)->desc))[i]))
+
+#define NBL_CHAN_QUEUE_LEN			64
+#define NBL_CHAN_BUF_LEN			4096
+
+#define NBL_CHAN_TX_WAIT_US			100
+#define NBL_CHAN_TX_REKICK_WAIT_TIMES		2000
+#define NBL_CHAN_TX_WAIT_TIMES			10000
+#define NBL_CHAN_RETRY_TIMES			20000
+#define NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN	16
+
+#define NBL_CHAN_TX_DESC_AVAIL			BIT(0)
+#define NBL_CHAN_TX_DESC_USED			BIT(1)
+#define NBL_CHAN_RX_DESC_WRITE			BIT(1)
+#define NBL_CHAN_RX_DESC_AVAIL			BIT(3)
+#define NBL_CHAN_RX_DESC_USED			BIT(4)
+
+enum {
+	NBL_MB_RX_QID = 0,
+	NBL_MB_TX_QID = 1,
+};
+
+struct __rte_packed_begin nbl_chan_tx_desc {
+	uint16_t flags;
+	uint16_t srcid;
+	uint16_t dstid;
+	uint16_t data_len;
+	uint16_t buf_len;
+	uint64_t buf_addr;
+	uint16_t msg_type;
+	uint8_t data[16];
+	uint16_t msgid;
+	uint8_t rsv[26];
+} __rte_packed_end;
+
+struct __rte_packed_begin nbl_chan_rx_desc {
+	uint16_t flags;
+	uint32_t buf_len;
+	uint16_t buf_id;
+	uint64_t buf_addr;
+} __rte_packed_end;
+
+struct nbl_chan_ring {
+	struct nbl_dma_mem desc_mem;
+	struct nbl_dma_mem buf_mem;
+	void *desc;
+	void *buf;
+
+	uint16_t next_to_use;
+	uint16_t tail_ptr;
+	uint16_t next_to_clean;
+};
+
+struct nbl_chan_waitqueue_head {
+	char *ack_data;
+	int acked;
+	int ack_err;
+	uint16_t ack_data_len;
+	uint16_t msg_type;
+};
+
+union nbl_chan_info {
+	struct {
+		struct nbl_chan_ring txq;
+		struct nbl_chan_ring rxq;
+		struct nbl_chan_waitqueue_head *wait;
+
+		rte_spinlock_t txq_lock;
+		uint16_t num_txq_entries;
+		uint16_t num_rxq_entries;
+		uint16_t txq_buf_size;
+		uint16_t rxq_buf_size;
+
+		struct nbl_work work;
+		void *state_bmp_mem;
+		struct rte_bitmap *state_bmp;
+		rte_thread_t tid;
+		int fd[2];
+	} mailbox;
+};
+
+struct nbl_chan_msg_handler {
+	void (*func)(void *priv, uint16_t srcid, uint16_t msgid, void *data, uint32_t len);
+	void *priv;
+};
+
+struct nbl_channel_mgt {
+	uint32_t mode;
+	struct nbl_hw_ops_tbl *hw_ops_tbl;
+	union nbl_chan_info *chan_info;
+	struct nbl_chan_msg_handler msg_handler[NBL_CHAN_MSG_MAX];
+	enum nbl_chan_state state;
+};
+
+/* Mgt structure for each product.
+ * Every individual mgt must have the common mgt as its first member, and contains its unique
+ * data structure in the reset of it.
+ */
+struct nbl_channel_mgt_leonis {
+	struct nbl_channel_mgt chan_mgt;
+};
+
+#endif
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
index 3bcf68a46d..52eabaf307 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.c
@@ -11,6 +11,43 @@ static inline void nbl_wr32(void *priv, u64 reg, u32 value)
 	rte_write32(rte_cpu_to_le_32(value), ((hw_mgt)->hw_addr + (reg)));
 }
 
+static inline u32 nbl_mbx_rd32(struct nbl_hw_mgt *hw_mgt, u64 reg)
+{
+	return rte_le_to_cpu_32(rte_read32(hw_mgt->mailbox_bar_hw_addr + reg));
+}
+
+static inline void nbl_mbx_wr32(void *priv, u64 reg, u32 value)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	rte_write32(rte_cpu_to_le_32(value), ((hw_mgt)->mailbox_bar_hw_addr + (reg)));
+	rte_delay_us(NBL_DELAY_MIN_TIME_FOR_REGS);
+}
+
+static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				 u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		*(u32 *)(data + i * sizeof(u32)) = nbl_mbx_rd32(hw_mgt, reg + i * sizeof(u32));
+}
+
+static void nbl_hw_write_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
+				  u8 *data, u32 len)
+{
+	u32 i = 0;
+
+	if (len % 4)
+		return;
+
+	for (i = 0; i < len / 4; i++)
+		nbl_mbx_wr32(hw_mgt, reg + i * sizeof(u32), *(u32 *)(data + i * sizeof(u32)));
+}
+
 static void nbl_hw_update_tail_ptr(void *priv, u16 notify_qid, u16 tail_ptr)
 {
 	nbl_wr32(priv, NBL_NOTIFY_ADDR, ((u32)tail_ptr << NBL_TAIL_PTR_OFT | (u32)notify_qid));
@@ -23,9 +60,95 @@ static u8 *nbl_hw_get_tail_ptr(void *priv)
 	return hw_mgt->hw_addr;
 }
 
+static void nbl_hw_config_mailbox_rxq(void *priv, u64 dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_rx_table qinfo_cfg_rx_table = { 0 };
+
+	qinfo_cfg_rx_table.rx_queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+
+	qinfo_cfg_rx_table.rx_queue_base_addr_l = NBL_LO_DWORD(dma_addr);
+	qinfo_cfg_rx_table.rx_queue_base_addr_h = NBL_HI_DWORD(dma_addr);
+	qinfo_cfg_rx_table.rx_queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_rx_table.rx_queue_rst = 0;
+	qinfo_cfg_rx_table.rx_queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_config_mailbox_txq(void *priv, u64 dma_addr, int size_bwid)
+{
+	struct nbl_mailbox_qinfo_cfg_tx_table qinfo_cfg_tx_table = { 0 };
+
+	qinfo_cfg_tx_table.tx_queue_rst = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+
+	qinfo_cfg_tx_table.tx_queue_base_addr_l = NBL_LO_DWORD(dma_addr);
+	qinfo_cfg_tx_table.tx_queue_base_addr_h = NBL_HI_DWORD(dma_addr);
+	qinfo_cfg_tx_table.tx_queue_size_bwind = (u32)size_bwid;
+	qinfo_cfg_tx_table.tx_queue_rst = 0;
+	qinfo_cfg_tx_table.tx_queue_en = 1;
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static void nbl_hw_stop_mailbox_rxq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_rx_table qinfo_cfg_rx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_rx_table,
+			      sizeof(qinfo_cfg_rx_table));
+}
+
+static void nbl_hw_stop_mailbox_txq(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_tx_table qinfo_cfg_tx_table = { 0 };
+
+	nbl_hw_write_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR,
+			      (u8 *)&qinfo_cfg_tx_table,
+			      sizeof(qinfo_cfg_tx_table));
+}
+
+static u16 nbl_hw_get_mailbox_rx_tail_ptr(void *priv)
+{
+	struct nbl_mailbox_qinfo_cfg_dbg_tbl cfg_dbg_tbl = { 0 };
+
+	nbl_hw_read_mbx_regs(priv, NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR,
+			     (u8 *)&cfg_dbg_tbl, sizeof(cfg_dbg_tbl));
+	return cfg_dbg_tbl.rx_tail_ptr;
+}
+
+static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr, u8 txrx)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	/* local_qid 0 and 1 denote rx and tx queue respectively */
+	u32 local_qid = txrx;
+	u32 value = ((u32)tail_ptr << NBL_TAIL_PTR_OFT) | local_qid;
+
+	rte_wmb();
+	nbl_mbx_wr32(hw_mgt, NBL_MAILBOX_NOTIFY_ADDR, value);
+	rte_delay_us(NBL_NOTIFY_DELAY_MIN_TIME_FOR_REGS);
+}
+
 static struct nbl_hw_ops hw_ops = {
 	.update_tail_ptr		= nbl_hw_update_tail_ptr,
 	.get_tail_ptr			= nbl_hw_get_tail_ptr,
+
+	/* mailbox */
+	.config_mailbox_rxq		= nbl_hw_config_mailbox_rxq,
+	.config_mailbox_txq		= nbl_hw_config_mailbox_txq,
+	.stop_mailbox_rxq		= nbl_hw_stop_mailbox_rxq,
+	.stop_mailbox_txq		= nbl_hw_stop_mailbox_txq,
+	.get_mailbox_rx_tail_ptr	= nbl_hw_get_mailbox_rx_tail_ptr,
+	.update_mailbox_queue_tail_ptr	= nbl_hw_update_mailbox_queue_tail_ptr,
 };
 
 static int nbl_hw_setup_ops(struct nbl_hw_ops_tbl **hw_ops_tbl,
diff --git a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
index 94f5062cf0..fc276e83d6 100644
--- a/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
+++ b/drivers/net/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_snic.h
@@ -7,4 +7,47 @@
 
 #include "../nbl_hw.h"
 
+/* MAILBOX BAR2 */
+#define NBL_MAILBOX_NOTIFY_ADDR			(0x00000000)
+#define NBL_MAILBOX_QINFO_CFG_RX_TABLE_ADDR	(0x10)
+#define NBL_MAILBOX_QINFO_CFG_TX_TABLE_ADDR	(0x20)
+#define NBL_MAILBOX_QINFO_CFG_DBG_TABLE_ADDR	(0x30)
+
+#define NBL_DELAY_MIN_TIME_FOR_REGS		400
+#define NBL_NOTIFY_DELAY_MIN_TIME_FOR_REGS	200
+
+/* mailbox BAR qinfo_cfg_rx_table */
+struct nbl_mailbox_qinfo_cfg_rx_table {
+	u32 rx_queue_base_addr_l;
+	u32 rx_queue_base_addr_h;
+	u32 rx_queue_size_bwind:4;
+	u32 rsv1:28;
+	u32 rx_queue_rst:1;
+	u32 rx_queue_en:1;
+	u32 rsv2:30;
+};
+
+/* mailbox BAR qinfo_cfg_tx_table */
+struct nbl_mailbox_qinfo_cfg_tx_table {
+	u32 tx_queue_base_addr_l;
+	u32 tx_queue_base_addr_h;
+	u32 tx_queue_size_bwind:4;
+	u32 rsv1:28;
+	u32 tx_queue_rst:1;
+	u32 tx_queue_en:1;
+	u32 rsv2:30;
+};
+
+/* mailbox BAR qinfo_cfg_dbg_table */
+struct nbl_mailbox_qinfo_cfg_dbg_tbl {
+	u16 rx_drop;
+	u16 rx_get;
+	u16 tx_drop;
+	u16 tx_out;
+	u16 rx_hd_ptr;
+	u16 tx_hd_ptr;
+	u16 rx_tail_ptr;
+	u16 tx_tail_ptr;
+};
+
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
new file mode 100644
index 0000000000..98ed4b2b2b
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -0,0 +1,339 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_CHANNEL_H_
+#define _NBL_DEF_CHANNEL_H_
+
+#include "nbl_include.h"
+
+#define NBL_CHAN_OPS_TBL_TO_OPS(chan_ops_tbl)	((chan_ops_tbl)->ops)
+#define NBL_CHAN_OPS_TBL_TO_PRIV(chan_ops_tbl)	((chan_ops_tbl)->priv)
+
+#define NBL_CHAN_SEND(chan_send, dst_id, mesg_type,						\
+		      argument, arg_length, response, resp_length, need_ack)			\
+do {												\
+	typeof(chan_send)	*__chan_send = &(chan_send);					\
+	__chan_send->dstid	= (dst_id);							\
+	__chan_send->msg_type	= (mesg_type);							\
+	__chan_send->arg	= (argument);							\
+	__chan_send->arg_len	= (arg_length);							\
+	__chan_send->resp	= (response);							\
+	__chan_send->resp_len	= (resp_length);						\
+	__chan_send->ack	= (need_ack);							\
+} while (0)
+
+#define NBL_CHAN_ACK(chan_ack, dst_id, mesg_type, msg_id, err_code, ack_data, data_length)	\
+do {												\
+	typeof(chan_ack)	*__chan_ack = &(chan_ack);					\
+	__chan_ack->dstid	= (dst_id);							\
+	__chan_ack->msg_type	= (mesg_type);							\
+	__chan_ack->msgid	= (msg_id);							\
+	__chan_ack->err		= (err_code);							\
+	__chan_ack->data	= (ack_data);							\
+	__chan_ack->data_len	= (data_length);						\
+} while (0)
+
+typedef void (*nbl_chan_resp)(void *, uint16_t, uint16_t, void *, uint32_t);
+
+enum {
+	NBL_CHAN_RESP_OK,
+	NBL_CHAN_RESP_ERR,
+};
+
+enum nbl_chan_msg_type {
+	NBL_CHAN_MSG_ACK,
+	NBL_CHAN_MSG_ADD_MACVLAN,
+	NBL_CHAN_MSG_DEL_MACVLAN,
+	NBL_CHAN_MSG_ADD_MULTI_RULE,
+	NBL_CHAN_MSG_DEL_MULTI_RULE,
+	NBL_CHAN_MSG_SETUP_MULTI_GROUP,
+	NBL_CHAN_MSG_REMOVE_MULTI_GROUP,
+	NBL_CHAN_MSG_REGISTER_NET,
+	NBL_CHAN_MSG_UNREGISTER_NET,
+	NBL_CHAN_MSG_ALLOC_TXRX_QUEUES,
+	NBL_CHAN_MSG_FREE_TXRX_QUEUES,
+	NBL_CHAN_MSG_SETUP_QUEUE,
+	NBL_CHAN_MSG_REMOVE_ALL_QUEUES,
+	NBL_CHAN_MSG_CFG_DSCH,
+	NBL_CHAN_MSG_SETUP_CQS,
+	NBL_CHAN_MSG_REMOVE_CQS,
+	NBL_CHAN_MSG_CFG_QDISC_MQPRIO,
+	NBL_CHAN_MSG_CONFIGURE_MSIX_MAP,
+	NBL_CHAN_MSG_DESTROY_MSIX_MAP,
+	NBL_CHAN_MSG_MAILBOX_ENABLE_IRQ,
+	NBL_CHAN_MSG_GET_GLOBAL_VECTOR,
+	NBL_CHAN_MSG_GET_VSI_ID,
+	NBL_CHAN_MSG_SET_PROSISC_MODE,
+	NBL_CHAN_MSG_GET_FIRMWARE_VERSION,
+	NBL_CHAN_MSG_GET_QUEUE_ERR_STATS,
+	NBL_CHAN_MSG_GET_COALESCE,
+	NBL_CHAN_MSG_SET_COALESCE,
+	NBL_CHAN_MSG_SET_SPOOF_CHECK_ADDR,
+	NBL_CHAN_MSG_SET_VF_SPOOF_CHECK,
+	NBL_CHAN_MSG_GET_RXFH_INDIR_SIZE,
+	NBL_CHAN_MSG_GET_RXFH_INDIR,
+	NBL_CHAN_MSG_GET_RXFH_RSS_KEY,
+	NBL_CHAN_MSG_GET_RXFH_RSS_ALG_SEL,
+	NBL_CHAN_MSG_GET_PHY_CAPS,
+	NBL_CHAN_MSG_GET_PHY_STATE,
+	NBL_CHAN_MSG_REGISTER_RDMA,
+	NBL_CHAN_MSG_UNREGISTER_RDMA,
+	NBL_CHAN_MSG_GET_REAL_HW_ADDR,
+	NBL_CHAN_MSG_GET_REAL_BDF,
+	NBL_CHAN_MSG_GRC_PROCESS,
+	NBL_CHAN_MSG_SET_SFP_STATE,
+	NBL_CHAN_MSG_SET_ETH_LOOPBACK,
+	NBL_CHAN_MSG_CHECK_ACTIVE_VF,
+	NBL_CHAN_MSG_GET_PRODUCT_FLEX_CAP,
+	NBL_CHAN_MSG_ALLOC_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_TX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_TX_KEYMAT,
+	NBL_CHAN_MSG_ALLOC_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_FREE_KTLS_RX_INDEX,
+	NBL_CHAN_MSG_CFG_KTLS_RX_KEYMAT,
+	NBL_CHAN_MSG_CFG_KTLS_RX_RECORD,
+	NBL_CHAN_MSG_ADD_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_DEL_KTLS_RX_FLOW,
+	NBL_CHAN_MSG_ALLOC_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_TX_INDEX,
+	NBL_CHAN_MSG_ALLOC_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_FREE_IPSEC_RX_INDEX,
+	NBL_CHAN_MSG_CFG_IPSEC_TX_SAD,
+	NBL_CHAN_MSG_CFG_IPSEC_RX_SAD,
+	NBL_CHAN_MSG_ADD_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_TX_FLOW,
+	NBL_CHAN_MSG_ADD_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_DEL_IPSEC_RX_FLOW,
+	NBL_CHAN_MSG_NOTIFY_IPSEC_HARD_EXPIRE,
+	NBL_CHAN_MSG_GET_MBX_IRQ_NUM,
+	NBL_CHAN_MSG_CLEAR_FLOW,
+	NBL_CHAN_MSG_CLEAR_QUEUE,
+	NBL_CHAN_MSG_GET_ETH_ID,
+	NBL_CHAN_MSG_SET_OFFLOAD_STATUS,
+	NBL_CHAN_MSG_INIT_OFLD,
+	NBL_CHAN_MSG_INIT_CMDQ,
+	NBL_CHAN_MSG_DESTROY_CMDQ,
+	NBL_CHAN_MSG_RESET_CMDQ,
+	NBL_CHAN_MSG_INIT_FLOW,
+	NBL_CHAN_MSG_DEINIT_FLOW,
+	NBL_CHAN_MSG_OFFLOAD_FLOW_RULE,
+	NBL_CHAN_MSG_GET_ACL_SWITCH,
+	NBL_CHAN_MSG_GET_VSI_GLOBAL_QUEUE_ID,
+	NBL_CHAN_MSG_INIT_REP,
+	NBL_CHAN_MSG_GET_LINE_RATE_INFO,
+	NBL_CHAN_MSG_REGISTER_NET_REP,
+	NBL_CHAN_MSG_UNREGISTER_NET_REP,
+	NBL_CHAN_MSG_REGISTER_ETH_REP,
+	NBL_CHAN_MSG_UNREGISTER_ETH_REP,
+	NBL_CHAN_MSG_REGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_UNREGISTER_UPCALL_PORT,
+	NBL_CHAN_MSG_GET_PORT_STATE,
+	NBL_CHAN_MSG_SET_PORT_ADVERTISING,
+	NBL_CHAN_MSG_GET_MODULE_INFO,
+	NBL_CHAN_MSG_GET_MODULE_EEPROM,
+	NBL_CHAN_MSG_GET_LINK_STATE,
+	NBL_CHAN_MSG_NOTIFY_LINK_STATE,
+	NBL_CHAN_MSG_GET_QUEUE_CXT,
+	NBL_CHAN_MSG_CFG_LOG,
+	NBL_CHAN_MSG_INIT_VDPAQ,
+	NBL_CHAN_MSG_DESTROY_VDPAQ,
+	NBL_CHAN_GET_UPCALL_PORT,
+	NBL_CHAN_MSG_NOTIFY_ETH_REP_LINK_STATE,
+	NBL_CHAN_MSG_SET_ETH_MAC_ADDR,
+	NBL_CHAN_MSG_GET_FUNCTION_ID,
+	NBL_CHAN_MSG_GET_CHIP_TEMPERATURE,
+	NBL_CHAN_MSG_DISABLE_PHY_FLOW,
+	NBL_CHAN_MSG_ENABLE_PHY_FLOW,
+	NBL_CHAN_MSG_SET_UPCALL_RULE,
+	NBL_CHAN_MSG_UNSET_UPCALL_RULE,
+	NBL_CHAN_MSG_GET_REG_DUMP,
+	NBL_CHAN_MSG_GET_REG_DUMP_LEN,
+	NBL_CHAN_MSG_CFG_LAG_HASH_ALGORITHM,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_FWD,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_LIST,
+	NBL_CHAN_MSG_CFG_LAG_MEMBER_UP_ATTR,
+	NBL_CHAN_MSG_ADD_LAG_FLOW,
+	NBL_CHAN_MSG_DEL_LAG_FLOW,
+	NBL_CHAN_MSG_SWITCHDEV_INIT_CMDQ,
+	NBL_CHAN_MSG_SWITCHDEV_DEINIT_CMDQ,
+	NBL_CHAN_MSG_SET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_UNSET_TC_FLOW_INFO,
+	NBL_CHAN_MSG_INIT_ACL,
+	NBL_CHAN_MSG_UNINIT_ACL,
+	NBL_CHAN_MSG_CFG_LAG_MCC,
+	NBL_CHAN_MSG_REGISTER_VSI2Q,
+	NBL_CHAN_MSG_SETUP_Q2VSI,
+	NBL_CHAN_MSG_REMOVE_Q2VSI,
+	NBL_CHAN_MSG_SETUP_RSS,
+	NBL_CHAN_MSG_REMOVE_RSS,
+	NBL_CHAN_MSG_GET_REP_QUEUE_INFO,
+	NBL_CHAN_MSG_CTRL_PORT_LED,
+	NBL_CHAN_MSG_NWAY_RESET,
+	NBL_CHAN_MSG_SET_INTL_SUPPRESS_LEVEL,
+	NBL_CHAN_MSG_GET_ETH_STATS,
+	NBL_CHAN_MSG_GET_MODULE_TEMPERATURE,
+	NBL_CHAN_MSG_GET_BOARD_INFO,
+	NBL_CHAN_MSG_GET_P4_USED,
+	NBL_CHAN_MSG_GET_VF_BASE_VSI_ID,
+	NBL_CHAN_MSG_ADD_LLDP_FLOW,
+	NBL_CHAN_MSG_DEL_LLDP_FLOW,
+	NBL_CHAN_MSG_CFG_ETH_BOND_INFO,
+	NBL_CHAN_MSG_CFG_DUPPKT_MCC,
+	NBL_CHAN_MSG_ADD_ND_UPCALL_FLOW,
+	NBL_CHAN_MSG_DEL_ND_UPCALL_FLOW,
+	NBL_CHAN_MSG_GET_BOARD_ID,
+	NBL_CHAN_MSG_SET_SHAPING_DPORT_VLD,
+	NBL_CHAN_MSG_SET_DPORT_FC_TH_VLD,
+	NBL_CHAN_MSG_REGISTER_RDMA_BOND,
+	NBL_CHAN_MSG_UNREGISTER_RDMA_BOND,
+	NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+	NBL_CHAN_MSG_RESTORE_HW_QUEUE,
+	NBL_CHAN_MSG_KEEP_ALIVE,
+	NBL_CHAN_MSG_GET_BASE_MAC_ADDR,
+	NBL_CHAN_MSG_CFG_BOND_SHAPING,
+	NBL_CHAN_MSG_CFG_BGID_BACK_PRESSURE,
+	NBL_CHAN_MSG_ALLOC_KT_BLOCK,
+	NBL_CHAN_MSG_FREE_KT_BLOCK,
+	NBL_CHAN_MSG_GET_DAEMON_QUEUE_INFO,
+	NBL_CHAN_MSG_GET_ETH_BOND_INFO,
+	NBL_CHAN_MSG_CLEAR_ACCEL_FLOW,
+	NBL_CHAN_MSG_SET_BRIDGE_MODE,
+	NBL_CHAN_MSG_GET_VF_FUNCTION_ID,
+	NBL_CHAN_MSG_NOTIFY_LINK_FORCED,
+	NBL_CHAN_MSG_SET_PMD_DEBUG,
+	NBL_CHAN_MSG_REGISTER_FUNC_MAC,
+	NBL_CHAN_MSG_SET_TX_RATE,
+	NBL_CHAN_MSG_REGISTER_FUNC_LINK_FORCED,
+	NBL_CHAN_MSG_GET_LINK_FORCED,
+	NBL_CHAN_MSG_REGISTER_FUNC_VLAN,
+	NBL_CHAN_MSG_GET_FD_FLOW,
+	NBL_CHAN_MSG_GET_FD_FLOW_CNT,
+	NBL_CHAN_MSG_GET_FD_FLOW_ALL,
+	NBL_CHAN_MSG_GET_FD_FLOW_MAX,
+	NBL_CHAN_MSG_REPLACE_FD_FLOW,
+	NBL_CHAN_MSG_REMOVE_FD_FLOW,
+	NBL_CHAN_MSG_CFG_FD_FLOW_STATE,
+	NBL_CHAN_MSG_REGISTER_FUNC_RATE,
+	NBL_CHAN_MSG_NOTIFY_VLAN,
+	NBL_CHAN_MSG_GET_XDP_QUEUE_INFO,
+	NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+	NBL_CHAN_MSG_STOP_ABNORMAL_HW_QUEUE,
+	NBL_CHAN_MSG_NOTIFY_RESET_EVENT,
+	NBL_CHAN_MSG_ACK_RESET_EVENT,
+	NBL_CHAN_MSG_GET_VF_VSI_ID,
+	NBL_CHAN_MSG_CONFIGURE_QOS,
+	NBL_CHAN_MSG_GET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_SET_PFC_BUFFER_SIZE,
+	NBL_CHAN_MSG_GET_VF_STATS,
+	NBL_CHAN_MSG_REGISTER_FUNC_TRUST,
+	NBL_CHAN_MSG_NOTIFY_TRUST,
+	NBL_CHAN_CHECK_VF_IS_ACTIVE,
+	NBL_CHAN_MSG_GET_ETH_ABNORMAL_STATS,
+	NBL_CHAN_MSG_GET_ETH_CTRL_STATS,
+	NBL_CHAN_MSG_GET_PAUSE_STATS,
+	NBL_CHAN_MSG_GET_ETH_MAC_STATS,
+	NBL_CHAN_MSG_GET_FEC_STATS,
+	NBL_CHAN_MSG_CFG_MULTI_MCAST_RULE,
+	NBL_CHAN_MSG_GET_LINK_DOWN_COUNT,
+	NBL_CHAN_MSG_GET_LINK_STATUS_OPCODE,
+	NBL_CHAN_MSG_GET_RMON_STATS,
+	NBL_CHAN_MSG_REGISTER_PF_NAME,
+	NBL_CHAN_MSG_GET_PF_NAME,
+	NBL_CHAN_MSG_CONFIGURE_RDMA_BW,
+	NBL_CHAN_MSG_SET_RATE_LIMIT,
+	NBL_CHAN_MSG_SET_TC_WGT,
+	NBL_CHAN_MSG_REMOVE_QUEUE,
+	NBL_CHAN_MSG_GET_MIRROR_TABLE_ID,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR,
+	NBL_CHAN_MSG_CONFIGURE_MIRROR_TABLE,
+	NBL_CHAN_MSG_CLEAR_MIRROR_CFG,
+	NBL_CHAN_MSG_MIRROR_OUTPUTPORT_NOTIFY,
+	NBL_CHAN_MSG_CHECK_FLOWTABLE_SPEC,
+	NBL_CHAN_CHECK_VF_IS_VDPA,
+	NBL_CHAN_MSG_GET_VDPA_VF_STATS,
+	NBL_CHAN_MSG_SET_RX_RATE,
+	NBL_CHAN_GET_UVN_PKT_DROP_STATS,
+	NBL_CHAN_GET_USTORE_PKT_DROP_STATS,
+	NBL_CHAN_GET_USTORE_TOTAL_PKT_DROP_STATS,
+
+	NBL_CHAN_MSG_MTU_SET = 501,
+	NBL_CHAN_MSG_SET_RXFH_INDIR = 506,
+
+	/* mailbox msg end */
+	NBL_CHAN_MSG_MAILBOX_MAX,
+
+	/* adminq msg */
+	NBL_CHAN_MSG_ADMINQ_GET_EMP_VERSION = 0x8101,	/* Deprecated, should not be used */
+	NBL_CHAN_MSG_ADMINQ_GET_NVM_VERSION = 0x8102,
+	NBL_CHAN_MSG_ADMINQ_REBOOT = 0x8104,
+	NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY = 0x8105,
+	NBL_CHAN_MSG_ADMINQ_FLASH_ERASE = 0x8201,
+	NBL_CHAN_MSG_ADMINQ_FLASH_READ = 0x8202,
+	NBL_CHAN_MSG_ADMINQ_FLASH_WRITE = 0x8203,
+	NBL_CHAN_MSG_ADMINQ_FLASH_ACTIVATE = 0x8204,
+	NBL_CHAN_MSG_ADMINQ_LOAD_P4 = 0x8107,
+	NBL_CHAN_MSG_ADMINQ_LOAD_P4_DEFAULT = 0x8108,
+	NBL_CHAN_MSG_ADMINQ_MANAGE_PORT_ATTRIBUTES = 0x8300,
+	NBL_CHAN_MSG_ADMINQ_PORT_NOTIFY = 0x8301,
+	NBL_CHAN_MSG_ADMINQ_GET_MODULE_EEPROM = 0x8302,
+	NBL_CHAN_MSG_ADMINQ_GET_ETH_STATS = 0x8303,
+	NBL_CHAN_MSG_ADMINQ_GET_FEC_STATS = 0x408,
+	NBL_CHAN_MSG_ADMINQ_EMP_CONSOLE_WRITE = 0x8F01,
+	NBL_CHAN_MSG_ADMINQ_EMP_CONSOLE_READ = 0x8F02,
+	NBL_CHAN_MSG_MAX,
+};
+
+struct nbl_chan_send_info {
+	uint16_t dstid;
+	uint16_t msg_type;
+	void *arg;
+	size_t arg_len;
+	void *resp;
+	size_t resp_len;
+	uint16_t ack;
+};
+
+struct nbl_chan_ack_info {
+	uint16_t dstid;
+	uint16_t msg_type;
+	uint16_t msgid;
+	int err;
+	void *data;
+	uint32_t data_len;
+};
+
+enum nbl_chan_state {
+	NBL_CHAN_INLINE,
+	NBL_CHAN_OFFLINE,
+	NBL_CHAN_STATE_MAX
+};
+
+enum nbl_chan_queue_state {
+	NBL_CHAN_INTERRUPT_READY,
+	NBL_CHAN_RESETTING,
+	NBL_CHAN_ABNORMAL,
+	NBL_CHAN_STATE_NBITS
+};
+
+struct nbl_channel_ops {
+	int (*send_msg)(void *priv, struct nbl_chan_send_info *chan_send);
+	int (*send_ack)(void *priv, struct nbl_chan_ack_info *chan_ack);
+	int (*register_msg)(void *priv, u16 msg_type, nbl_chan_resp func, void *callback_priv);
+	int (*setup_queue)(void *priv);
+	int (*teardown_queue)(void *priv);
+	void (*set_state)(void *priv, enum nbl_chan_state state);
+	void (*set_queue_state)(void *priv, enum nbl_chan_queue_state state, u8 set);
+	int (*notify_interrupt)(void *priv);
+};
+
+struct nbl_channel_ops_tbl {
+	struct nbl_channel_ops *ops;
+	void *priv;
+};
+
+int nbl_chan_init_leonis(void *p);
+void nbl_chan_remove_leonis(void *p);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_common.h b/drivers/net/nbl/nbl_include/nbl_def_common.h
new file mode 100644
index 0000000000..5170cc053b
--- /dev/null
+++ b/drivers/net/nbl/nbl_include/nbl_def_common.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 Nebulamatrix Technology Co., Ltd.
+ */
+
+#ifndef _NBL_DEF_COMMON_H_
+#define _NBL_DEF_COMMON_H_
+
+#include "nbl_include.h"
+
+struct nbl_dma_mem {
+	void *va;
+	uint64_t pa;
+	uint32_t size;
+	const struct rte_memzone *mz;
+};
+
+struct nbl_work {
+	TAILQ_ENTRY(nbl_work) next;
+	void *params;
+	void (*handler)(void *priv);
+	uint32_t tick;
+	uint32_t random;
+	bool run_once;
+	bool no_run;
+	uint8_t resv[2];
+};
+
+void *nbl_alloc_dma_mem(struct nbl_dma_mem *mem, uint32_t size);
+void nbl_free_dma_mem(struct nbl_dma_mem *mem);
+
+#endif
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index d116d22f51..7fddd7be2c 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -29,6 +29,13 @@
 #include <ethdev_pci.h>
 #include <bus_pci_driver.h>
 #include <rte_io.h>
+#include <rte_tailq.h>
+#include <rte_lcore.h>
+#include <rte_common.h>
+#include <rte_thread.h>
+#include <rte_spinlock.h>
+#include <rte_stdatomic.h>
+#include <rte_bitmap.h>
 
 #include "nbl_logs.h"
 
@@ -52,4 +59,6 @@ struct nbl_func_caps {
 	u32 rsv:31;
 };
 
+#define BIT(a)			(1 << (a))
+
 #endif
-- 
2.34.1

