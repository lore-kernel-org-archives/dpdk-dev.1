Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0941D6CFBB
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 03:17:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71E3240609;
	Fri, 23 Jan 2026 04:16:56 +0100 (CET)
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com
 [115.124.28.193])
 by mails.dpdk.org (Postfix) with ESMTP id 3DFCA4021F;
 Fri, 23 Jan 2026 04:16:49 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gDV2mtG_1769138206 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 23 Jan 2026 11:16:46 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 4/4] net/nbl: improve exception handling for the mailbox
Date: Thu, 22 Jan 2026 19:16:27 -0800
Message-Id: <20260123031627.151341-5-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
References: <20260123031627.151341-1-dimon.zhao@nebula-matrix.com>
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

Key changes:
1. Replace simple 'acked' flag with a state machine to improve mailbox
   reliability. New states: IDLE, WAITING, ACKING, ACKED, TIMEOUT.
2. Validate message ID and type before processing acknowledgments to
   prevent incorrect ACK matching.
3. Handle timeout scenarios: discard ACKs received after timeout to
   prevent use of already released buffers.
4. Check mailbox status before sending: if the send mailbox descriptor
   is found to be in use or waiting for an ACK during transmission,
   the message will not be sent.

Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 94 ++++++++++++++++++++++------
 drivers/net/nbl/nbl_hw/nbl_channel.h | 11 +++-
 2 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index f81c4c8591..75e4354e18 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -22,6 +22,7 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 {
 	struct nbl_chan_ring *txq = &chan_info->mailbox.txq;
 	size_t size = chan_info->mailbox.num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+	int i;
 
 	txq->desc = nbl_alloc_dma_mem(&txq->desc_mem, size);
 	if (!txq->desc) {
@@ -36,6 +37,10 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 		goto req_wait_queue_failed;
 	}
 
+	for (i = 0; i < chan_info->mailbox.num_txq_entries; i++)
+		rte_atomic_store_explicit(&chan_info->mailbox.wait[i].status, NBL_MBX_STATUS_IDLE,
+					  rte_memory_order_relaxed);
+
 	size = (u64)chan_info->mailbox.num_txq_entries * (u64)chan_info->mailbox.txq_buf_size;
 	txq->buf = nbl_alloc_dma_mem(&txq->buf_mem, size);
 	if (!txq->buf) {
@@ -253,24 +258,55 @@ static void nbl_chan_recv_ack_msg(void *priv, uint16_t srcid, uint16_t msgid,
 	uint32_t ack_msgid;
 	uint32_t ack_msgtype;
 	uint32_t copy_len;
+	int status = NBL_MBX_STATUS_WAITING;
 
 	chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
 	ack_msgtype = *payload;
 	ack_msgid = *(payload + 1);
+
+	if (ack_msgid >= chan_mgt->chan_info->mailbox.num_txq_entries) {
+		NBL_LOG(ERR, "Invalid msg id %u, msg type %u", ack_msgid, ack_msgtype);
+		return;
+	}
+
 	wait_head = &chan_info->mailbox.wait[ack_msgid];
+	if (wait_head->msg_type != ack_msgtype) {
+		NBL_LOG(ERR, "Invalid msg id %u, msg type %u, wait msg type %u",
+			ack_msgid, ack_msgtype, wait_head->msg_type);
+		return;
+	}
+
+	if (!rte_atomic_compare_exchange_strong_explicit(&wait_head->status, &status,
+							 NBL_MBX_STATUS_ACKING,
+							 rte_memory_order_acq_rel,
+							 rte_memory_order_relaxed)) {
+		NBL_LOG(ERR, "Invalid wait status %d msg id %u, msg type %u",
+			wait_head->status, ack_msgid, ack_msgtype);
+		return;
+	}
+
 	wait_head->ack_err = *(payload + 2);
 
 	NBL_LOG(DEBUG, "recv ack, srcid:%u, msgtype:%u, msgid:%u, ack_msgid:%u,"
-		" data_len:%u, ack_data_len:%u",
-		srcid, ack_msgtype, msgid, ack_msgid, data_len, wait_head->ack_data_len);
+		" data_len:%u, ack_data_len:%u, ack_err:%d",
+		srcid, ack_msgtype, msgid, ack_msgid, data_len,
+		wait_head->ack_data_len, wait_head->ack_err);
 
 	if (wait_head->ack_err >= 0 && (data_len > 3 * sizeof(uint32_t))) {
 		/* the mailbox msg parameter structure may change */
+		if (data_len - 3 * sizeof(uint32_t) != wait_head->ack_data_len)
+			NBL_LOG(INFO, "payload_len do not match ack_len!,"
+				" srcid:%u, msgtype:%u, msgid:%u, ack_msgid %u,"
+				" data_len:%u, ack_data_len:%u",
+				srcid, ack_msgtype, msgid,
+				ack_msgid, data_len, wait_head->ack_data_len);
 		copy_len = RTE_MIN(wait_head->ack_data_len, data_len - 3 * sizeof(uint32_t));
-		memcpy(wait_head->ack_data, payload + 3, copy_len);
+		if (copy_len)
+			memcpy(wait_head->ack_data, payload + 3, copy_len);
 	}
 
-	rte_atomic_store_explicit(&wait_head->acked, 1, rte_memory_order_release);
+	rte_atomic_store_explicit(&wait_head->status, NBL_MBX_STATUS_ACKED,
+				  rte_memory_order_release);
 }
 
 static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
@@ -371,12 +407,27 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 {
 	struct nbl_chan_ring *txq;
 	struct nbl_chan_tx_desc *tx_desc;
+	struct nbl_chan_waitqueue_head *wait_head;
 	uint64_t pa;
 	void *va;
 	uint16_t next_to_use;
+	int status;
+
+	if (arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc)) {
+		NBL_LOG(ERR, "arg_len: %zu, too long!", arg_len);
+		return 0xFFFF;
+	}
 
 	txq = &chan_info->mailbox.txq;
 	next_to_use = txq->next_to_use;
+
+	wait_head = &chan_info->mailbox.wait[next_to_use];
+	status = rte_atomic_load_explicit(&wait_head->status, rte_memory_order_acquire);
+	if (status != NBL_MBX_STATUS_IDLE && status != NBL_MBX_STATUS_TIMEOUT) {
+		NBL_LOG(ERR, "too much inflight mailbox msg, msg id %u", next_to_use);
+		return 0xFFFF;
+	}
+
 	va = (u8 *)txq->buf + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
@@ -384,10 +435,6 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 	tx_desc->dstid = dstid;
 	tx_desc->msg_type = msg_type;
 	tx_desc->msgid = next_to_use;
-	if (arg_len > NBL_CHAN_BUF_LEN - sizeof(*tx_desc)) {
-		NBL_LOG(ERR, "arg_len: %zu, too long!", arg_len);
-		return -1;
-	}
 
 	if (arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
 		memcpy(va, arg, arg_len);
@@ -418,6 +465,7 @@ static int nbl_chan_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
 	uint16_t msgid;
 	int ret;
 	int retry_time = 0;
+	int status = NBL_MBX_STATUS_WAITING;
 
 	if (chan_mgt->state)
 		return -EIO;
@@ -431,8 +479,7 @@ static int nbl_chan_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
 
 	if (msgid == 0xFFFF) {
 		rte_spinlock_unlock(&chan_info->mailbox.txq_lock);
-		NBL_LOG(ERR, "chan tx queue full, send msgtype:%u"
-			" to dstid:%u failed",
+		NBL_LOG(ERR, "chan tx queue full, send msgtype:%u to dstid:%u failed",
 			chan_send->msg_type, chan_send->dstid);
 		return -ECOMM;
 	}
@@ -446,23 +493,34 @@ static int nbl_chan_send_msg(void *priv, struct nbl_chan_send_info *chan_send)
 	wait_head = &chan_info->mailbox.wait[msgid];
 	wait_head->ack_data = chan_send->resp;
 	wait_head->ack_data_len = chan_send->resp_len;
-	rte_atomic_store_explicit(&wait_head->acked, 0, rte_memory_order_relaxed);
 	wait_head->msg_type = chan_send->msg_type;
-	rte_wmb();
+	rte_atomic_store_explicit(&wait_head->status, NBL_MBX_STATUS_WAITING,
+				  rte_memory_order_release);
 	nbl_chan_kick_tx_ring(chan_mgt, chan_info);
 	rte_spinlock_unlock(&chan_info->mailbox.txq_lock);
 
 	while (1) {
-		if (rte_atomic_load_explicit(&wait_head->acked, rte_memory_order_acquire))
-			return wait_head->ack_err;
+		if (rte_atomic_load_explicit(&wait_head->status, rte_memory_order_acquire) ==
+		    NBL_MBX_STATUS_ACKED) {
+			ret = wait_head->ack_err;
+			rte_atomic_store_explicit(&wait_head->status, NBL_MBX_STATUS_IDLE,
+						  rte_memory_order_release);
+			return ret;
+		}
 
 		rte_delay_us(50);
 		retry_time++;
-		if (retry_time > NBL_CHAN_RETRY_TIMES)
-			return -EIO;
+		if (retry_time > NBL_CHAN_RETRY_TIMES &&
+		    rte_atomic_compare_exchange_strong_explicit(&wait_head->status,
+								&status, NBL_MBX_STATUS_TIMEOUT,
+								rte_memory_order_acq_rel,
+								rte_memory_order_relaxed)) {
+			NBL_LOG(ERR, "send msgtype:%u msgid %u to dstid:%u timeout",
+				chan_send->msg_type, msgid, chan_send->dstid);
+			break;
+		}
 	}
-
-	return 0;
+	return -EIO;
 }
 
 static int nbl_chan_send_ack(void *priv, struct nbl_chan_ack_info *chan_ack)
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.h b/drivers/net/nbl/nbl_hw/nbl_channel.h
index f8fa89af51..21fce7478d 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.h
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.h
@@ -41,6 +41,14 @@ enum {
 	NBL_MB_TX_QID = 1,
 };
 
+enum {
+	NBL_MBX_STATUS_IDLE = 0,
+	NBL_MBX_STATUS_WAITING,
+	NBL_MBX_STATUS_ACKING,
+	NBL_MBX_STATUS_ACKED,
+	NBL_MBX_STATUS_TIMEOUT,
+};
+
 struct __rte_packed_begin nbl_chan_tx_desc {
 	uint16_t flags;
 	uint16_t srcid;
@@ -74,8 +82,7 @@ struct nbl_chan_ring {
 
 struct nbl_chan_waitqueue_head {
 	char *ack_data;
-	RTE_ATOMIC(int)
-		acked;
+	RTE_ATOMIC(int) status;
 	int ack_err;
 	uint16_t ack_data_len;
 	uint16_t msg_type;
-- 
2.34.1

