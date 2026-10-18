Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE6ECCA490
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Oct 2026 09:50:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02FB040659;
	Sun, 18 Oct 2026 11:50:42 +0200 (CEST)
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [52.34.181.151]) by mails.dpdk.org (Postfix) with ESMTP id C069E40276
 for <dev@dpdk.org>; Sun, 18 Oct 2026 11:50:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1792317041; x=1823853041;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=uiLgT4dbPClG1ZbU7UB4qq8j1lBgB0xsB1SX5cBE1rM=;
 b=VpG0mYuqOOuR1YZgdh2uP7pJ6qdQt1zXBp4WsINNOcOE3mX9khf3IaWr
 BrMS7fWle3X1QcG9O/NHg1QMUPByjeYaI8vvwCXhK73YSYcA2V2pxBlg0
 yekkCJdsAg02MppXIpk4fECWVCEUF6rkpzP2SFZ6uDx37sn97ab9cumwP
 XHyt566WodhG0C2k3ODBGixTQvEiv9F0i9BwUKunPVqdwKt8i58X5goWB
 o6+Id4iru6HWGAtynwEV5SSj0t6UnE45xzLg1zUX9xbTmeWHPb+OFLxSg
 nqMfpFxK7X+NWSW8dIiDymd/JDY3Xgte8U7h0PblmdwuzYAnXOWNa+TCy g==;
X-CSE-ConnectionGUID: JH5/0HluRT6Rg2mXEKMnqg==
X-CSE-MsgGUID: HRnCB6KcTneW+Is014AF1g==
X-IronPort-AV: E=Sophos;i="6.27,165,1787011200"; d="scan'208";a="31558138"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 09:50:37 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:13060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.38:2525]
 with esmtp (Farcaster)
 id 33bf1de9-37d7-4293-88bb-324b8639a2b0; Sun, 18 Oct 2026 09:50:37 +0000 (UTC)
X-Farcaster-Flow-ID: 33bf1de9-37d7-4293-88bb-324b8639a2b0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Sun, 18 Oct 2026 09:50:37 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.212.8) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Sun, 18 Oct 2026 09:50:35 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v3 05/13] net/ena/base: add LLQ policy inline helper
Date: Sun, 18 Oct 2026 12:50:25 +0300
Message-ID: <3fee2a0f8044a8b4e36139c0f96679e13c243d3d.1792312030.git.shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1792312029.git.shaibran@amazon.com>
References: <20261018063606.973-1-shaibran@amazon.com>
 <cover.1792312029.git.shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.212.8]
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Introduce a helper to abstract the LLQ placement policy check,
replacing direct mem_queue_type comparisons across ena-com.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
---
 drivers/net/ena/base/ena_com.h     |  5 +++
 drivers/net/ena/base/ena_eth_com.c | 55 +++++++++++++++---------------
 drivers/net/ena/base/ena_eth_com.h |  6 ++--
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index bd395fd90c..c62fecdef2 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -1139,6 +1139,11 @@ static inline struct ena_com_dev *ena_com_io_cq_to_ena_dev(struct ena_com_io_cq
 	return container_of(io_cq, struct ena_com_dev, io_cq_queues[io_cq->qid]);
 }
 
+static inline bool ena_com_sq_is_llq(struct ena_com_io_sq *io_sq)
+{
+	return io_sq->mem_queue_type != ENA_ADMIN_PLACEMENT_POLICY_HOST;
+}
+
 static inline bool ena_com_get_adaptive_moderation_enabled(struct ena_com_dev *ena_dev)
 {
 	return ena_dev->adaptive_coalescing;
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index 8a019b3451..e3b2a753c4 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -151,16 +151,16 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 	return ENA_COM_OK;
 }
 
-static int ena_com_write_header_to_bounce(struct ena_com_io_sq *io_sq,
-						 u8 *header_src,
-						 u16 header_len)
+static int ena_com_write_header_to_llq_entry(struct ena_com_io_sq *io_sq,
+					  u8 *header_src,
+					  u16 header_len)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
 	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
-	u8 *bounce_buffer = pkt_ctrl->curr_bounce_buf;
+	u8 *curr_llq_entry = pkt_ctrl->curr_llq_entry;
 	u16 header_offset;
 
-	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST))
+	if (unlikely(!ena_com_sq_is_llq(io_sq)))
 		return 0;
 
 	header_offset =
@@ -172,13 +172,13 @@ static int ena_com_write_header_to_bounce(struct ena_com_io_sq *io_sq,
 		return ENA_COM_FAULT;
 	}
 
-	if (unlikely(!bounce_buffer)) {
+	if (unlikely(!curr_llq_entry)) {
 		ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
-			    "Bounce buffer is NULL\n");
+			    "LLQ entry is NULL\n");
 		return ENA_COM_FAULT;
 	}
 
-	memcpy(bounce_buffer + header_offset, header_src, header_len);
+	memcpy(curr_llq_entry + header_offset, header_src, header_len);
 
 	return 0;
 }
@@ -186,46 +186,46 @@ static int ena_com_write_header_to_bounce(struct ena_com_io_sq *io_sq,
 static void *get_sq_desc_llq(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
-	u8 *bounce_buffer;
+	u8 *curr_llq_entry;
 	void *sq_desc;
 
-	bounce_buffer = pkt_ctrl->curr_bounce_buf;
+	curr_llq_entry = pkt_ctrl->curr_llq_entry;
 
-	if (unlikely(!bounce_buffer)) {
+	if (unlikely(!curr_llq_entry)) {
 		ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
-			    "Bounce buffer is NULL\n");
+			    "LLQ entry is NULL\n");
 		return NULL;
 	}
 
-	sq_desc = bounce_buffer + pkt_ctrl->idx * io_sq->desc_entry_size;
+	sq_desc = curr_llq_entry + pkt_ctrl->idx * io_sq->desc_entry_size;
 	pkt_ctrl->idx++;
 	pkt_ctrl->descs_left_in_line--;
 
 	return sq_desc;
 }
 
-static int ena_com_close_bounce_buffer(struct ena_com_io_sq *io_sq)
+static int ena_com_close_llq_entry(struct ena_com_io_sq *io_sq)
 {
 	struct ena_com_llq_pkt_ctrl *pkt_ctrl = &io_sq->llq_buf_ctrl;
 	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
 	int rc;
 
-	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST))
+	if (unlikely(!ena_com_sq_is_llq(io_sq)))
 		return ENA_COM_OK;
 
 	/* bounce buffer was used, so write it and get a new one */
 	if (likely(pkt_ctrl->idx)) {
 		rc = ena_com_write_bounce_buffer_to_dev(io_sq,
-							pkt_ctrl->curr_bounce_buf);
+							pkt_ctrl->curr_llq_entry);
 		if (unlikely(rc)) {
 			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
 				    "Failed to write bounce buffer to device\n");
 			return rc;
 		}
 
-		pkt_ctrl->curr_bounce_buf =
+		pkt_ctrl->curr_llq_entry =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
+		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
 		       0x0, llq_info->desc_list_entry_size);
 	}
 
@@ -241,7 +241,7 @@ static void *get_tx_sq_desc(struct ena_com_io_sq *io_sq)
 {
 	void *tx_desc;
 
-	if (likely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV))
+	if (likely(ena_com_sq_is_llq(io_sq)))
 		return get_sq_desc_llq(io_sq);
 
 	tx_desc = get_sq_desc_regular_queue(io_sq);
@@ -259,16 +259,16 @@ static int ena_com_sq_update_llq_tail(struct ena_com_io_sq *io_sq)
 
 	if (!pkt_ctrl->descs_left_in_line) {
 		rc = ena_com_write_bounce_buffer_to_dev(io_sq,
-							pkt_ctrl->curr_bounce_buf);
+							pkt_ctrl->curr_llq_entry);
 		if (unlikely(rc)) {
 			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
 				    "Failed to write bounce buffer to device\n");
 			return rc;
 		}
 
-		pkt_ctrl->curr_bounce_buf =
+		pkt_ctrl->curr_llq_entry =
 			ena_com_get_next_bounce_buffer(&io_sq->bounce_buf_ctrl);
-		memset(io_sq->llq_buf_ctrl.curr_bounce_buf,
+		memset(io_sq->llq_buf_ctrl.curr_llq_entry,
 		       0x0, llq_info->desc_list_entry_size);
 
 		pkt_ctrl->idx = 0;
@@ -291,7 +291,7 @@ static int ena_com_sq_update_reqular_queue_tail(struct ena_com_io_sq *io_sq)
 
 static int ena_com_sq_update_tail(struct ena_com_io_sq *io_sq)
 {
-	if (likely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV))
+	if (likely(ena_com_sq_is_llq(io_sq)))
 		return ena_com_sq_update_llq_tail(io_sq);
 
 	return ena_com_sq_update_reqular_queue_tail(io_sq);
@@ -514,14 +514,13 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 		return ENA_COM_INVAL;
 	}
 
-	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV
-		     && !buffer_to_push)) {
+	if (unlikely(ena_com_sq_is_llq(io_sq) && !buffer_to_push)) {
 		ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
 			    "Push header wasn't provided in LLQ mode\n");
 		return ENA_COM_INVAL;
 	}
 
-	rc = ena_com_write_header_to_bounce(io_sq, buffer_to_push, header_len);
+	rc = ena_com_write_header_to_llq_entry(io_sq, buffer_to_push, header_len);
 	if (unlikely(rc))
 		return rc;
 
@@ -534,7 +533,7 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 
 	/* If the caller doesn't want to send packets */
 	if (unlikely(!num_bufs && !header_len)) {
-		rc = ena_com_close_bounce_buffer(io_sq);
+		rc = ena_com_close_llq_entry(io_sq);
 		if (unlikely(rc))
 			ena_trc_err(ena_com_io_sq_to_ena_dev(io_sq),
 				    "Failed to write buffers to LLQ\n");
@@ -635,7 +634,7 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 		return rc;
 	}
 
-	rc = ena_com_close_bounce_buffer(io_sq);
+	rc = ena_com_close_llq_entry(io_sq);
 
 	*nb_hw_desc = io_sq->tail - start_tail;
 	return rc;
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index f773699467..503cf45cf7 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -110,7 +110,7 @@ static inline bool ena_com_sq_have_enough_space(struct ena_com_io_sq *io_sq,
 {
 	int temp;
 
-	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST))
+	if (unlikely(!ena_com_sq_is_llq(io_sq)))
 		return ena_com_free_q_entries(io_sq) >= required_buffers;
 
 	/* This calculation doesn't need to be 100% accurate. So to reduce
@@ -136,8 +136,8 @@ static inline bool ena_com_meta_desc_changed(struct ena_com_io_sq *io_sq,
 
 static inline bool is_llq_max_tx_burst_exists(struct ena_com_io_sq *io_sq)
 {
-	return (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) &&
-	       io_sq->llq_info.max_entries_in_tx_burst > 0;
+	return likely(ena_com_sq_is_llq(io_sq)) &&
+	       (io_sq->llq_info.max_entries_in_tx_burst > 0);
 }
 
 static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
-- 
2.17.1

