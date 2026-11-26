Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE84606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 07:35:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 61CBE40658;
	Thu, 26 Nov 2026 08:34:46 +0100 (CET)
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com
 [115.124.28.169])
 by mails.dpdk.org (Postfix) with ESMTPS id 6577C40284
 for <dev@dpdk.org>; Thu, 26 Nov 2026 08:34:41 +0100 (CET)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06712908|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00358368-0.000600558-0.995816;
 FP=15147714637909726735|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033040092104; MF=dimon.zhao@nebula-matrix.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.kAe1Ys9_1795678478; 
Received: from
 dimonzhao-1.NEBULA-MATRIX.COM(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.kAe1Ys9_1795678478 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 26 Nov 2026 15:34:38 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	dev@dpdk.org
Cc: Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 03/11] net/nbl: add draco channel layer
Date: Thu, 26 Nov 2026 15:34:20 +0800
Message-ID: <20261126073430.3168813-4-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
References: <20261126073430.3168813-1-dimon.zhao@nebula-matrix.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use common channel initialization and removal callbacks for Leonis
and draco, and remove the Leonis-specific management wrapper.

Add draco mailbox descriptor layouts and select descriptor field
access according to the product type stored in the mailbox context.
Preserve the Leonis descriptor layout and existing ACK synchronization.

Move the temporary -ENOTSUP return to draco resource initialization
until the resource layer is implemented.

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_core.c                    |  21 +--
 drivers/net/nbl/nbl_hw/nbl_channel.c          | 135 +++++++++---------
 drivers/net/nbl/nbl_hw/nbl_channel.h          |  91 ++++++++----
 drivers/net/nbl/nbl_include/nbl_def_channel.h |   4 +-
 4 files changed, 140 insertions(+), 111 deletions(-)

diff --git a/drivers/net/nbl/nbl_core.c b/drivers/net/nbl/nbl_core.c
index ecc681a..263a61b 100644
--- a/drivers/net/nbl/nbl_core.c
+++ b/drivers/net/nbl/nbl_core.c
@@ -7,20 +7,11 @@
 static int nbl_res_init_draco(void *adapter __rte_unused,
 			      struct rte_eth_dev *eth_dev __rte_unused)
 {
-	return 0;
-}
-
-static void nbl_res_remove_draco(void *adapter __rte_unused)
-{
-}
-
-static int nbl_chan_init_draco(void *adapter __rte_unused)
-{
-	/* Keep probing disabled until the Draco channel layer is implemented. */
+	/* Keep probing disabled until the Draco resource layer is implemented. */
 	return -ENOTSUP;
 }
 
-static void nbl_chan_remove_draco(void *adapter __rte_unused)
+static void nbl_res_remove_draco(void *adapter __rte_unused)
 {
 }
 
@@ -30,16 +21,16 @@ const struct nbl_product_core_ops nbl_product_core_ops[NBL_PRODUCT_MAX] = {
 		.hw_remove	= nbl_hw_remove_leonis_snic,
 		.res_init	= nbl_res_init_leonis,
 		.res_remove	= nbl_res_remove_leonis,
-		.chan_init	= nbl_chan_init_leonis,
-		.chan_remove	= nbl_chan_remove_leonis,
+		.chan_init	= nbl_chan_init,
+		.chan_remove	= nbl_chan_remove,
 	},
 	[NBL_DRACO_TYPE] = {
 		.hw_init	= nbl_hw_init_draco_snic,
 		.hw_remove	= nbl_hw_remove_draco_snic,
 		.res_init	= nbl_res_init_draco,
 		.res_remove	= nbl_res_remove_draco,
-		.chan_init	= nbl_chan_init_draco,
-		.chan_remove	= nbl_chan_remove_draco,
+		.chan_init	= nbl_chan_init,
+		.chan_remove	= nbl_chan_remove,
 	},
 };
 
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 52ad71c..3afae5b 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -21,7 +21,7 @@ static void nbl_chan_init_queue_param(union nbl_chan_info *chan_info,
 static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 {
 	struct nbl_chan_ring *txq = &chan_info->mailbox.txq;
-	size_t size = chan_info->mailbox.num_txq_entries * sizeof(struct nbl_chan_tx_desc);
+	size_t size = chan_info->mailbox.num_txq_entries * sizeof(union nbl_chan_tx_desc);
 	int i;
 
 	txq->desc = nbl_alloc_dma_mem(&txq->desc_mem, size);
@@ -63,7 +63,7 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 static int nbl_chan_init_rx_queue(union nbl_chan_info *chan_info)
 {
 	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
-	size_t size = chan_info->mailbox.num_rxq_entries * sizeof(struct nbl_chan_rx_desc);
+	size_t size = chan_info->mailbox.num_rxq_entries * sizeof(union nbl_chan_rx_desc);
 
 	rxq->desc = nbl_alloc_dma_mem(&rxq->desc_mem, size);
 	if (!rxq->desc) {
@@ -158,7 +158,7 @@ static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
 {
 	const struct nbl_hw_ops *hw_ops;
 	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
-	struct nbl_chan_rx_desc *desc;
+	union nbl_chan_rx_desc *desc;
 	void *hw_priv;
 	u16 rx_tail_ptr;
 	u32 retry_times = 0;
@@ -167,9 +167,10 @@ static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
 	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
 	desc = rxq->desc;
 	for (i = 0; i < chan_info->mailbox.num_rxq_entries - 1; i++) {
-		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
-		desc[i].buf_addr = rxq->buf_mem.pa + (u64)i * (u64)chan_info->mailbox.rxq_buf_size;
-		desc[i].buf_len = chan_info->mailbox.rxq_buf_size;
+		DESC_W(&desc[i], flags, NBL_CHAN_RX_DESC_AVAIL);
+		DESC_W(&desc[i], buf_addr, rxq->buf_mem.pa +
+		       (u64)i * (u64)chan_info->mailbox.rxq_buf_size);
+		DESC_W(&desc[i], buf_len, chan_info->mailbox.rxq_buf_size);
 	}
 
 	rxq->next_to_clean = 0;
@@ -217,7 +218,7 @@ static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
 {
 	const struct nbl_hw_ops *hw_ops;
 	struct nbl_chan_ring *txq;
-	struct nbl_chan_tx_desc *tx_desc;
+	union nbl_chan_tx_desc *tx_desc;
 	int i;
 
 	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
@@ -230,7 +231,7 @@ static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
 	tx_desc = NBL_CHAN_TX_DESC(txq, txq->next_to_clean);
 
 	i = 0;
-	while (!(tx_desc->flags & NBL_CHAN_TX_DESC_USED)) {
+	while (!(DESC_R(tx_desc, flags) & NBL_CHAN_TX_DESC_USED)) {
 		rte_delay_us(NBL_CHAN_TX_WAIT_US);
 		i++;
 
@@ -239,7 +240,7 @@ static int nbl_chan_kick_tx_ring(struct nbl_channel_mgt *chan_mgt,
 
 		if (i == NBL_CHAN_TX_WAIT_TIMES) {
 			NBL_LOG(ERR, "chan send message type: %d timeout",
-				tx_desc->msg_type);
+				DESC_R(tx_desc, msg_type));
 			return -1;
 		}
 	}
@@ -312,27 +313,28 @@ static void nbl_chan_recv_ack_msg(void *priv, uint16_t srcid, uint16_t msgid,
 static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data)
 {
 	struct nbl_chan_ack_info chan_ack;
-	struct nbl_chan_tx_desc *tx_desc;
+	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
+	union nbl_chan_tx_desc *tx_desc;
 	struct nbl_chan_msg_handler *msg_handler;
 	u16 msg_type, payload_len, srcid, msgid;
 	void *payload;
 
 	tx_desc = data;
-	msg_type = tx_desc->msg_type;
+	msg_type = DESC_R(tx_desc, msg_type);
 
-	srcid = tx_desc->srcid;
-	msgid = tx_desc->msgid;
+	srcid = DESC_R(tx_desc, srcid);
+	msgid = DESC_R(tx_desc, msgid);
 	if (msg_type >= NBL_CHAN_MSG_MAX) {
 		NBL_LOG(ERR, "Invalid chan message type %hu", msg_type);
 		return;
 	}
 
-	if (tx_desc->data_len) {
-		payload = (void *)tx_desc->data;
-		payload_len = tx_desc->data_len;
+	if (DESC_R(tx_desc, data_len)) {
+		payload = (void *)DESC_R(tx_desc, data);
+		payload_len = DESC_R(tx_desc, data_len);
 	} else {
 		payload = (void *)(tx_desc + 1);
-		payload_len = tx_desc->buf_len;
+		payload_len = DESC_R(tx_desc, buf_len);
 	}
 
 	msg_handler = &chan_mgt->msg_handler[msg_type];
@@ -351,7 +353,7 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 				     struct nbl_chan_ring *rxq)
 {
 	const struct nbl_hw_ops *hw_ops;
-	struct nbl_chan_rx_desc *rx_desc;
+	union nbl_chan_rx_desc *rx_desc;
 	u16 next_to_use;
 
 	hw_ops = NBL_CHAN_MGT_TO_HW_OPS(chan_mgt);
@@ -359,10 +361,10 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 	next_to_use = rxq->next_to_use;
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_use);
 
-	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
-	rx_desc->buf_addr = rxq->buf_mem.pa +
-				(u64)chan_info->mailbox.rxq_buf_size * (u64)next_to_use;
-	rx_desc->buf_len = chan_info->mailbox.rxq_buf_size;
+	DESC_W(rx_desc, flags, NBL_CHAN_RX_DESC_AVAIL);
+	DESC_W(rx_desc, buf_addr, rxq->buf_mem.pa +
+				(u64)chan_info->mailbox.rxq_buf_size * (u64)next_to_use);
+	DESC_W(rx_desc, buf_len, chan_info->mailbox.rxq_buf_size);
 
 	rte_wmb();
 	rxq->next_to_use++;
@@ -378,14 +380,14 @@ static void nbl_chan_clean_queue(void *priv)
 	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
 	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
 	struct nbl_chan_ring *rxq = &chan_info->mailbox.rxq;
-	struct nbl_chan_rx_desc *rx_desc;
+	union nbl_chan_rx_desc *rx_desc;
 	u8 *data;
 	u16 next_to_clean;
 
 	next_to_clean = rxq->next_to_clean;
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_clean);
 	data = (u8 *)rxq->buf + (u64)next_to_clean * (u64)chan_info->mailbox.rxq_buf_size;
-	while (rx_desc->flags & NBL_CHAN_RX_DESC_USED) {
+	while (DESC_R(rx_desc, flags) & NBL_CHAN_RX_DESC_USED) {
 		rte_rmb();
 		nbl_chan_recv_msg(chan_mgt, data);
 
@@ -406,7 +408,7 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 					void *arg, size_t arg_len)
 {
 	struct nbl_chan_ring *txq;
-	struct nbl_chan_tx_desc *tx_desc;
+	union nbl_chan_tx_desc *tx_desc;
 	struct nbl_chan_waitqueue_head *wait_head;
 	uint64_t pa;
 	void *va;
@@ -432,21 +434,21 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
 
-	tx_desc->dstid = dstid;
-	tx_desc->msg_type = msg_type;
-	tx_desc->msgid = next_to_use;
+	DESC_W(tx_desc, dstid, dstid);
+	DESC_W(tx_desc, msg_type, msg_type);
+	DESC_W(tx_desc, msgid, next_to_use);
 
 	if (arg_len > NBL_CHAN_TX_DESC_EMBEDDED_DATA_LEN) {
 		memcpy(va, arg, arg_len);
-		tx_desc->buf_addr = pa;
-		tx_desc->buf_len = arg_len;
-		tx_desc->data_len = 0;
+		DESC_W(tx_desc, buf_addr, pa);
+		DESC_W(tx_desc, buf_len, arg_len);
+		DESC_W(tx_desc, data_len, 0);
 	} else {
-		memcpy(tx_desc->data, arg, arg_len);
-		tx_desc->buf_len = 0;
-		tx_desc->data_len = arg_len;
+		memcpy(DESC_R(tx_desc, data), arg, arg_len);
+		DESC_W(tx_desc, buf_len, 0);
+		DESC_W(tx_desc, data_len, arg_len);
 	}
-	tx_desc->flags = NBL_CHAN_TX_DESC_AVAIL;
+	DESC_W(tx_desc, flags, NBL_CHAN_TX_DESC_AVAIL);
 
 	rte_wmb();
 	txq->next_to_use++;
@@ -926,7 +928,7 @@ static void nbl_chan_remove_state_bitmap(void *priv)
 }
 
 static int nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
-				   struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+				   struct nbl_channel_mgt **chan_mgt)
 {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	union nbl_chan_info *mailbox;
@@ -934,38 +936,41 @@ static int nbl_chan_setup_chan_mgt(struct nbl_adapter *adapter,
 
 	hw_ops_tbl = NBL_ADAPTER_TO_HW_OPS_TBL(adapter);
 
-	*chan_mgt_leonis = rte_zmalloc("nbl_chan_mgt", sizeof(struct nbl_channel_mgt_leonis), 0);
-	if (!*chan_mgt_leonis)
-		goto alloc_channel_mgt_leonis_fail;
+	*chan_mgt = rte_zmalloc("nbl_chan_mgt", sizeof(struct nbl_channel_mgt), 0);
+	if (!*chan_mgt)
+		goto alloc_channel_mgt_fail;
 
-	(*chan_mgt_leonis)->chan_mgt.hw_ops_tbl = hw_ops_tbl;
+	(*chan_mgt)->hw_ops_tbl = hw_ops_tbl;
 
 	mailbox = rte_zmalloc("nbl_mailbox", sizeof(union nbl_chan_info), 0);
 	if (!mailbox)
 		goto alloc_mailbox_fail;
 
-	NBL_CHAN_MGT_TO_CHAN_INFO(&(*chan_mgt_leonis)->chan_mgt) = mailbox;
-	NBL_CHAN_MGT_TO_COMMON(&(*chan_mgt_leonis)->chan_mgt) = &adapter->common;
+	NBL_CHAN_MGT_TO_CHAN_INFO(*chan_mgt) = mailbox;
+	NBL_CHAN_MGT_TO_COMMON(*chan_mgt) = &adapter->common;
+	mailbox->mailbox.product_type = adapter->caps.product_type;
 
-	ret = nbl_chan_init_state_bitmap(*chan_mgt_leonis);
+	ret = nbl_chan_init_state_bitmap(*chan_mgt);
 	if (ret)
 		goto state_bitmap_init_fail;
 
 	return 0;
 
 state_bitmap_init_fail:
+	rte_free(mailbox);
 alloc_mailbox_fail:
-	rte_free(*chan_mgt_leonis);
-alloc_channel_mgt_leonis_fail:
+	rte_free(*chan_mgt);
+	*chan_mgt = NULL;
+alloc_channel_mgt_fail:
 	return -ENOMEM;
 }
 
-static void nbl_chan_remove_chan_mgt(struct nbl_channel_mgt_leonis **chan_mgt_leonis)
+static void nbl_chan_remove_chan_mgt(struct nbl_channel_mgt **chan_mgt)
 {
-	nbl_chan_remove_state_bitmap(*chan_mgt_leonis);
-	rte_free(NBL_CHAN_MGT_TO_CHAN_INFO(&(*chan_mgt_leonis)->chan_mgt));
-	rte_free(*chan_mgt_leonis);
-	*chan_mgt_leonis = NULL;
+	nbl_chan_remove_state_bitmap(*chan_mgt);
+	rte_free(NBL_CHAN_MGT_TO_CHAN_INFO(*chan_mgt));
+	rte_free(*chan_mgt);
+	*chan_mgt = NULL;
 }
 
 static void nbl_chan_remove_ops(struct nbl_channel_ops_tbl **chan_ops_tbl)
@@ -975,7 +980,7 @@ static void nbl_chan_remove_ops(struct nbl_channel_ops_tbl **chan_ops_tbl)
 }
 
 static int nbl_chan_setup_ops(struct nbl_channel_ops_tbl **chan_ops_tbl,
-			      struct nbl_channel_mgt_leonis *chan_mgt_leonis)
+			      struct nbl_channel_mgt *chan_mgt)
 {
 	struct nbl_common_info *common;
 
@@ -983,54 +988,54 @@ static int nbl_chan_setup_ops(struct nbl_channel_ops_tbl **chan_ops_tbl,
 	if (!*chan_ops_tbl)
 		return -ENOMEM;
 
-	common = NBL_CHAN_MGT_TO_COMMON(&chan_mgt_leonis->chan_mgt);
+	common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
 	if (NBL_IS_NOT_COEXISTENCE(common))
 		NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &nbl_chan_ops;
 	else
 		NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &nbl_userdev_ops;
-	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt_leonis;
+	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt;
 
-	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].func = nbl_chan_recv_ack_msg;
-	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].priv = chan_mgt_leonis;
+	chan_mgt->msg_handler[NBL_CHAN_MSG_ACK].func = nbl_chan_recv_ack_msg;
+	chan_mgt->msg_handler[NBL_CHAN_MSG_ACK].priv = chan_mgt;
 
 	return 0;
 }
 
-int nbl_chan_init_leonis(void *p)
+int nbl_chan_init(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
-	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_mgt **chan_mgt;
 	struct nbl_channel_ops_tbl **chan_ops_tbl;
 	int ret = 0;
 
-	chan_mgt_leonis = (struct nbl_channel_mgt_leonis **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
+	chan_mgt = (struct nbl_channel_mgt **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
 	chan_ops_tbl = &NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
 
-	ret = nbl_chan_setup_chan_mgt(adapter, chan_mgt_leonis);
+	ret = nbl_chan_setup_chan_mgt(adapter, chan_mgt);
 	if (ret)
 		goto setup_mgt_fail;
 
-	ret = nbl_chan_setup_ops(chan_ops_tbl, *chan_mgt_leonis);
+	ret = nbl_chan_setup_ops(chan_ops_tbl, *chan_mgt);
 	if (ret)
 		goto setup_ops_fail;
 
 	return 0;
 
 setup_ops_fail:
-	nbl_chan_remove_chan_mgt(chan_mgt_leonis);
+	nbl_chan_remove_chan_mgt(chan_mgt);
 setup_mgt_fail:
 	return ret;
 }
 
-void nbl_chan_remove_leonis(void *p)
+void nbl_chan_remove(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
-	struct nbl_channel_mgt_leonis **chan_mgt_leonis;
+	struct nbl_channel_mgt **chan_mgt;
 	struct nbl_channel_ops_tbl **chan_ops_tbl;
 
-	chan_mgt_leonis = (struct nbl_channel_mgt_leonis **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
+	chan_mgt = (struct nbl_channel_mgt **)&NBL_ADAPTER_TO_CHAN_MGT(adapter);
 	chan_ops_tbl = &NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
 
-	nbl_chan_remove_chan_mgt(chan_mgt_leonis);
+	nbl_chan_remove_chan_mgt(chan_mgt);
 	nbl_chan_remove_ops(chan_ops_tbl);
 }
diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.h b/drivers/net/nbl/nbl_hw/nbl_channel.h
index 21fce74..7768cc7 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.h
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.h
@@ -17,9 +17,9 @@
 #define NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt)	((chan_mgt)->chan_info)
 
 #define NBL_CHAN_TX_DESC(tx_ring, i) \
-	(&(((struct nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
+	(&(((union nbl_chan_tx_desc *)((tx_ring)->desc))[i]))
 #define NBL_CHAN_RX_DESC(rx_ring, i) \
-	(&(((struct nbl_chan_rx_desc *)((rx_ring)->desc))[i]))
+	(&(((union nbl_chan_rx_desc *)((rx_ring)->desc))[i]))
 
 #define NBL_CHAN_QUEUE_LEN			64
 #define NBL_CHAN_BUF_LEN			4096
@@ -36,6 +36,24 @@
 #define NBL_CHAN_RX_DESC_AVAIL			BIT(3)
 #define NBL_CHAN_RX_DESC_USED			BIT(4)
 
+/* These macros require an existing chan_info variable. */
+#define DESC_R(desc, field)									\
+	({											\
+		typeof(desc) _desc = (desc);							\
+		chan_info->mailbox.product_type == NBL_LEONIS_TYPE ? _desc->NBL_NAME(field)	\
+							   : _desc->draco.NBL_NAME(field##_v2);	\
+	})
+
+#define DESC_W(desc, field, val)								\
+	({											\
+		typeof(val) _val = (val);							\
+		typeof(desc) _desc = (desc);							\
+		if (chan_info->mailbox.product_type == NBL_LEONIS_TYPE)				\
+			_desc->NBL_NAME(field) = _val;						\
+		else										\
+			_desc->draco.NBL_NAME(field##_v2) = _val;				\
+	})
+
 enum {
 	NBL_MB_RX_QID = 0,
 	NBL_MB_TX_QID = 1,
@@ -49,25 +67,47 @@ enum {
 	NBL_MBX_STATUS_TIMEOUT,
 };
 
-struct __rte_packed_begin nbl_chan_tx_desc {
-	uint16_t flags;
-	uint16_t srcid;
-	uint16_t dstid;
-	uint16_t data_len;
-	uint16_t buf_len;
-	uint64_t buf_addr;
-	uint16_t msg_type;
-	uint8_t data[16];
-	uint16_t msgid;
-	uint8_t rsv[26];
-} __rte_packed_end;
-
-struct __rte_packed_begin nbl_chan_rx_desc {
-	uint16_t flags;
-	uint32_t buf_len;
-	uint16_t buf_id;
-	uint64_t buf_addr;
-} __rte_packed_end;
+union nbl_chan_tx_desc {
+	struct __rte_packed_begin {
+		uint16_t flags;
+		uint16_t srcid;
+		uint16_t dstid;
+		uint16_t data_len;
+		uint16_t buf_len;
+		uint64_t buf_addr;
+		uint16_t msg_type;
+		uint8_t data[16];
+		uint16_t msgid;
+		uint8_t rsv[26];
+	} __rte_packed_end;
+	struct __rte_packed_begin draco_chan_tx_desc {
+		uint16_t flags_v2;
+		uint16_t srcid_v2;
+		uint16_t dstid_v2;
+		uint16_t data_len_v2;
+		uint64_t buf_addr_v2;
+		uint16_t buf_len_v2;
+		uint16_t msg_type_v2;
+		uint8_t data_v2[16];
+		uint16_t msgid_v2;
+		uint8_t rsv_v2[26];
+	} __rte_packed_end draco;
+};
+
+union nbl_chan_rx_desc {
+	struct __rte_packed_begin {
+		uint16_t flags;
+		uint32_t buf_len;
+		uint16_t buf_id;
+		uint64_t buf_addr;
+	} __rte_packed_end;
+	struct __rte_packed_begin draco_chan_rx_desc {
+		uint16_t flags_v2;
+		uint16_t buf_id_v2;
+		uint32_t buf_len_v2;
+		uint64_t buf_addr_v2;
+	} __rte_packed_end draco;
+};
 
 struct nbl_chan_ring {
 	struct nbl_dma_mem desc_mem;
@@ -105,6 +145,7 @@ union nbl_chan_info {
 		struct rte_bitmap *state_bmp;
 		rte_thread_t tid;
 		int fd[2];
+		enum nbl_product_type product_type;
 	} mailbox;
 
 	struct {
@@ -128,12 +169,4 @@ struct nbl_channel_mgt {
 	enum nbl_chan_state state;
 };
 
-/* Mgt structure for each product.
- * Every individual mgt must have the common mgt as its first member, and contains its unique
- * data structure in the reset of it.
- */
-struct nbl_channel_mgt_leonis {
-	struct nbl_channel_mgt chan_mgt;
-};
-
 #endif
diff --git a/drivers/net/nbl/nbl_include/nbl_def_channel.h b/drivers/net/nbl/nbl_include/nbl_def_channel.h
index 257c81e..9e36dfa 100644
--- a/drivers/net/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/nbl/nbl_include/nbl_def_channel.h
@@ -464,7 +464,7 @@ struct nbl_channel_ops_tbl {
 	void *priv;
 };
 
-int nbl_chan_init_leonis(void *p);
-void nbl_chan_remove_leonis(void *p);
+int nbl_chan_init(void *p);
+void nbl_chan_remove(void *p);
 
 #endif
-- 
2.53.0

