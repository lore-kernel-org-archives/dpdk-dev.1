Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C4E8B393
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 642D740652;
	Wed,  4 Feb 2026 04:07:47 +0100 (CET)
Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com
 [47.90.198.14]) by mails.dpdk.org (Postfix) with ESMTP id 4F9FF4027F;
 Wed,  4 Feb 2026 04:07:44 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gOD5rPm_1770174450 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 04 Feb 2026 11:07:31 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v4 1/3] net/nbl: fix integer handling issues
Date: Tue,  3 Feb 2026 19:07:20 -0800
Message-Id: <20260204030722.11716-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204030722.11716-1-dimon.zhao@nebula-matrix.com>
References: <20260115032744.62449-1-dimon.zhao@nebula-matrix.com>
 <20260204030722.11716-1-dimon.zhao@nebula-matrix.com>
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

Cast u16 operands to u64 before multiplication when calculating
buffer sizes and offsets to prevent potential integer overflow.
The num_txq_entries, num_rxq_entries, txq_buf_size, and rxq_buf_size
fields are all u16 types, and their product could overflow before
assignment to size_t or u64 destination variables.

Coverity issue: 490942
Coverity issue: 490943
Coverity issue: 490946
Coverity issue: 490949
Coverity issue: 490952
Coverity issue: 490953
Coverity issue: 490954
Coverity issue: 490955
Coverity issue: 490957
Coverity issue: 490959
Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_channel.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index 7cc214df01..f81c4c8591 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -36,7 +36,7 @@ static int nbl_chan_init_tx_queue(union nbl_chan_info *chan_info)
 		goto req_wait_queue_failed;
 	}
 
-	size = chan_info->mailbox.num_txq_entries * chan_info->mailbox.txq_buf_size;
+	size = (u64)chan_info->mailbox.num_txq_entries * (u64)chan_info->mailbox.txq_buf_size;
 	txq->buf = nbl_alloc_dma_mem(&txq->buf_mem, size);
 	if (!txq->buf) {
 		NBL_LOG(ERR, "Allocate memory for chan tx buffer arrays failed");
@@ -66,7 +66,7 @@ static int nbl_chan_init_rx_queue(union nbl_chan_info *chan_info)
 		return -ENOMEM;
 	}
 
-	size = chan_info->mailbox.num_rxq_entries * chan_info->mailbox.rxq_buf_size;
+	size = (u64)chan_info->mailbox.num_rxq_entries * (u64)chan_info->mailbox.rxq_buf_size;
 	rxq->buf = nbl_alloc_dma_mem(&rxq->buf_mem, size);
 	if (!rxq->buf) {
 		NBL_LOG(ERR, "Allocate memory for chan rx buffer arrays failed");
@@ -163,7 +163,7 @@ static int nbl_chan_prepare_rx_bufs(struct nbl_channel_mgt *chan_mgt,
 	desc = rxq->desc;
 	for (i = 0; i < chan_info->mailbox.num_rxq_entries - 1; i++) {
 		desc[i].flags = NBL_CHAN_RX_DESC_AVAIL;
-		desc[i].buf_addr = rxq->buf_mem.pa + i * chan_info->mailbox.rxq_buf_size;
+		desc[i].buf_addr = rxq->buf_mem.pa + (u64)i * (u64)chan_info->mailbox.rxq_buf_size;
 		desc[i].buf_len = chan_info->mailbox.rxq_buf_size;
 	}
 
@@ -324,7 +324,8 @@ static void nbl_chan_advance_rx_ring(struct nbl_channel_mgt *chan_mgt,
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_use);
 
 	rx_desc->flags = NBL_CHAN_RX_DESC_AVAIL;
-	rx_desc->buf_addr = rxq->buf_mem.pa + chan_info->mailbox.rxq_buf_size * next_to_use;
+	rx_desc->buf_addr = rxq->buf_mem.pa +
+				(u64)chan_info->mailbox.rxq_buf_size * (u64)next_to_use;
 	rx_desc->buf_len = chan_info->mailbox.rxq_buf_size;
 
 	rte_wmb();
@@ -347,7 +348,7 @@ static void nbl_chan_clean_queue(void *priv)
 
 	next_to_clean = rxq->next_to_clean;
 	rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_clean);
-	data = (u8 *)rxq->buf + next_to_clean * chan_info->mailbox.rxq_buf_size;
+	data = (u8 *)rxq->buf + (u64)next_to_clean * (u64)chan_info->mailbox.rxq_buf_size;
 	while (rx_desc->flags & NBL_CHAN_RX_DESC_USED) {
 		rte_rmb();
 		nbl_chan_recv_msg(chan_mgt, data);
@@ -358,7 +359,7 @@ static void nbl_chan_clean_queue(void *priv)
 		if (next_to_clean == chan_info->mailbox.num_rxq_entries)
 			next_to_clean = 0;
 		rx_desc = NBL_CHAN_RX_DESC(rxq, next_to_clean);
-		data = (u8 *)rxq->buf + next_to_clean * chan_info->mailbox.rxq_buf_size;
+		data = (u8 *)rxq->buf + (u64)next_to_clean * (u64)chan_info->mailbox.rxq_buf_size;
 	}
 	rxq->next_to_clean = next_to_clean;
 }
@@ -376,8 +377,8 @@ static uint16_t nbl_chan_update_txqueue(union nbl_chan_info *chan_info,
 
 	txq = &chan_info->mailbox.txq;
 	next_to_use = txq->next_to_use;
-	va = (u8 *)txq->buf + next_to_use * chan_info->mailbox.txq_buf_size;
-	pa = txq->buf_mem.pa + next_to_use * chan_info->mailbox.txq_buf_size;
+	va = (u8 *)txq->buf + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
+	pa = txq->buf_mem.pa + (u64)next_to_use * (u64)chan_info->mailbox.txq_buf_size;
 	tx_desc = NBL_CHAN_TX_DESC(txq, next_to_use);
 
 	tx_desc->dstid = dstid;
-- 
2.34.1

