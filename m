Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08623CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:05:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B602040E4A;
	Wed, 15 Oct 2025 14:05:30 +0200 (CEST)
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [44.245.243.92]) by mails.dpdk.org (Postfix) with ESMTP id EAA0E4065E
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760529926; x=1792065926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=lAbjUTx30HL/1X/J588/9kTpQRom701ekFRIdG9ZhaI=;
 b=NvfND2ixBGhEMtUOQHg0/52I1YlqcwH98SoR3znQtLAYDOtETXB+pCfU
 sr4oPRUFRxKzO7orJTZ/XA9j5TfMAEgjlLVMU8697MwH4qrAquejhTVsu
 ABpdwf4T2uV2pw1HQLMDkw9mBVzCTepW6rZbp1DNEKHOQpGJh6yVlzFTC
 xL1pLxDt3tis8LfgycDreuLGpLkJdYoRk1Wvjre/hZtW1ecUsTU8aTO9P
 8VaRZNSRcYiAvFWkmSJmQv7FS1qCZcLTPGrtDR6e0ke92fX9Sk99LyD9b
 dWkUH+xblRUh2i1nYIYFXcfQnuQbtsV3Fn18PXr7GDHMqpYuODp0H0qxX w==;
X-CSE-ConnectionGUID: lPb4cpBMR0CamiGu2VYIhw==
X-CSE-MsgGUID: fyXjN+0CS4eC3U48DsJXmA==
X-IronPort-AV: E=Sophos;i="6.18,281,1751241600"; 
   d="scan'208";a="4929989"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:05:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:7590]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.42:2525]
 with esmtp (Farcaster)
 id 8ec88202-c62b-4a0e-9a8e-92c234f447a1; Wed, 15 Oct 2025 12:05:23 +0000 (UTC)
X-Farcaster-Flow-ID: 8ec88202-c62b-4a0e-9a8e-92c234f447a1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:22 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:21 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 02/20] net/ena/base: add extended Tx cdesc support
Date: Wed, 15 Oct 2025 15:03:57 +0300
Message-ID: <20251015120415.2204-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251015120415.2204-1-shaibran@amazon.com>
References: <20251015120415.2204-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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

RX path supports both base and extended completion
descriptors (cdesc), while TX path only supports the
base `ena_eth_io_tx_cdesc`.

This patch introduces `ena_eth_io_tx_cdesc_ext`, which
includes the base descriptor fields along with additional
metadata for TX completions.

It also adds configuration support to select between base
and extended cdesc during completion queue (CQ) creation,
enabling flexible descriptor usage based on device
capabilities or application needs.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c                | 15 ++-
 drivers/net/ena/base/ena_com.h                |  3 +
 .../net/ena/base/ena_defs/ena_eth_io_defs.h   |  8 ++
 drivers/net/ena/base/ena_eth_com.c            | 98 ++++++++++---------
 drivers/net/ena/base/ena_eth_com.h            | 32 +++---
 drivers/net/ena/ena_ethdev.c                  |  3 +-
 6 files changed, 95 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 1a93d22b71..2d4dfe583d 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -421,11 +421,16 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 
 	memset(&io_cq->cdesc_addr, 0x0, sizeof(io_cq->cdesc_addr));
 
-	/* Use the basic completion descriptor for Rx */
-	io_cq->cdesc_entry_size_in_bytes =
-		(io_cq->direction == ENA_COM_IO_QUEUE_DIRECTION_TX) ?
-		sizeof(struct ena_eth_io_tx_cdesc) :
-		sizeof(struct ena_eth_io_rx_cdesc_base);
+	if (ctx->use_extended_cdesc)
+		io_cq->cdesc_entry_size_in_bytes =
+			(io_cq->direction == ENA_COM_IO_QUEUE_DIRECTION_TX) ?
+			sizeof(struct ena_eth_io_tx_cdesc_ext) :
+			sizeof(struct ena_eth_io_rx_cdesc_ext);
+	else
+		io_cq->cdesc_entry_size_in_bytes =
+			(io_cq->direction == ENA_COM_IO_QUEUE_DIRECTION_TX) ?
+			sizeof(struct ena_eth_io_tx_cdesc) :
+			sizeof(struct ena_eth_io_rx_cdesc_base);
 
 	size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 	io_cq->bus = ena_dev->bus;
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 1c752327dc..180fa8966e 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -402,6 +402,8 @@ struct ena_com_dev {
 	struct ena_com_llq_info llq_info;
 
 	struct ena_customer_metrics customer_metrics;
+	bool use_extended_tx_cdesc;
+	bool use_extended_rx_cdesc;
 };
 
 struct ena_com_dev_get_features_ctx {
@@ -421,6 +423,7 @@ struct ena_com_create_io_ctx {
 	u32 msix_vector;
 	u16 queue_size;
 	u16 qid;
+	bool use_extended_cdesc;
 };
 
 typedef void (*ena_aenq_handler)(void *data,
diff --git a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
index 4bbd1d0d9d..f35bba3202 100644
--- a/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
+++ b/drivers/net/ena/base/ena_defs/ena_eth_io_defs.h
@@ -163,6 +163,14 @@ struct ena_eth_io_tx_cdesc {
 	uint16_t sq_head_idx;
 };
 
+struct ena_eth_io_tx_cdesc_ext {
+	struct ena_eth_io_tx_cdesc base;
+
+	uint32_t reserved_w2;
+
+	uint32_t reserved_w3;
+};
+
 struct ena_eth_io_rx_desc {
 	/* In bytes. 0 means 64KB */
 	uint16_t length;
diff --git a/drivers/net/ena/base/ena_eth_com.c b/drivers/net/ena/base/ena_eth_com.c
index c4fee7bb3c..b68be49ef9 100644
--- a/drivers/net/ena/base/ena_eth_com.c
+++ b/drivers/net/ena/base/ena_eth_com.c
@@ -5,19 +5,19 @@
 
 #include "ena_eth_com.h"
 
-struct ena_eth_io_rx_cdesc_base *ena_com_get_next_rx_cdesc(struct ena_com_io_cq *io_cq)
+struct ena_eth_io_rx_cdesc_ext *ena_com_get_next_rx_cdesc(struct ena_com_io_cq *io_cq)
 {
-	struct ena_eth_io_rx_cdesc_base *cdesc;
+	struct ena_eth_io_rx_cdesc_ext *cdesc;
 	u16 expected_phase, head_masked;
 	u16 desc_phase;
 
 	head_masked = io_cq->head & (io_cq->q_depth - 1);
 	expected_phase = io_cq->phase;
 
-	cdesc = (struct ena_eth_io_rx_cdesc_base *)(io_cq->cdesc_addr.virt_addr
+	cdesc = (struct ena_eth_io_rx_cdesc_ext *)(io_cq->cdesc_addr.virt_addr
 			+ (head_masked * io_cq->cdesc_entry_size_in_bytes));
 
-	desc_phase = ENA_FIELD_GET(READ_ONCE32(cdesc->status),
+	desc_phase = ENA_FIELD_GET(READ_ONCE32(cdesc->base.status),
 				   ENA_ETH_IO_RX_CDESC_BASE_PHASE_MASK,
 				   ENA_ETH_IO_RX_CDESC_BASE_PHASE_SHIFT);
 
@@ -33,31 +33,34 @@ struct ena_eth_io_rx_cdesc_base *ena_com_get_next_rx_cdesc(struct ena_com_io_cq
 }
 
 void ena_com_dump_single_rx_cdesc(struct ena_com_io_cq *io_cq,
-				  struct ena_eth_io_rx_cdesc_base *desc)
+				  struct ena_eth_io_rx_cdesc_ext *desc)
 {
 	if (desc) {
 		uint32_t *desc_arr = (uint32_t *)desc;
 
 		ena_trc_err(ena_com_io_cq_to_ena_dev(io_cq),
-			    "RX descriptor value[0x%08x 0x%08x 0x%08x 0x%08x] phase[%u] first[%u] last[%u] MBZ7[%u] MZB17[%u]\n",
-			    desc_arr[0], desc_arr[1], desc_arr[2], desc_arr[3],
-			    ENA_FIELD_GET(desc->status, (uint32_t)ENA_ETH_IO_RX_DESC_PHASE_MASK,
-					  0),
-			    ENA_FIELD_GET(desc->status, (uint32_t)ENA_ETH_IO_RX_DESC_FIRST_MASK,
-					  ENA_ETH_IO_RX_DESC_FIRST_SHIFT),
-			    ENA_FIELD_GET(desc->status, (uint32_t)ENA_ETH_IO_RX_DESC_LAST_MASK,
-					  ENA_ETH_IO_RX_DESC_LAST_SHIFT),
-			    ENA_FIELD_GET(desc->status,
-					  (uint32_t)ENA_ETH_IO_RX_CDESC_BASE_MBZ7_MASK,
-					  ENA_ETH_IO_RX_CDESC_BASE_MBZ7_SHIFT),
-			    ENA_FIELD_GET(desc->status,
-					  (uint32_t)ENA_ETH_IO_RX_CDESC_BASE_MBZ17_MASK,
-					  ENA_ETH_IO_RX_CDESC_BASE_MBZ17_SHIFT));
+				"RX descriptor value[0x%08x 0x%08x 0x%08x 0x%08x] phase[%u] first[%u] last[%u] MBZ7[%u] MBZ17[%u]\n",
+				desc_arr[0], desc_arr[1], desc_arr[2], desc_arr[3],
+				ENA_FIELD_GET(desc->base.status,
+					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_PHASE_MASK,
+					ENA_ETH_IO_RX_CDESC_BASE_PHASE_SHIFT),
+				ENA_FIELD_GET(desc->base.status,
+					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK,
+					ENA_ETH_IO_RX_CDESC_BASE_FIRST_SHIFT),
+				ENA_FIELD_GET(desc->base.status,
+					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK,
+					ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT),
+				ENA_FIELD_GET(desc->base.status,
+					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_MBZ7_MASK,
+					ENA_ETH_IO_RX_CDESC_BASE_MBZ7_SHIFT),
+				ENA_FIELD_GET(desc->base.status,
+					(uint32_t)ENA_ETH_IO_RX_CDESC_BASE_MBZ17_MASK,
+					ENA_ETH_IO_RX_CDESC_BASE_MBZ17_SHIFT));
 	}
 }
 
 void ena_com_dump_single_tx_cdesc(struct ena_com_io_cq *io_cq,
-				  struct ena_eth_io_tx_cdesc *desc)
+				  struct ena_eth_io_tx_cdesc_ext *desc)
 {
 	if (desc) {
 		uint32_t *desc_arr = (uint32_t *)desc;
@@ -65,18 +68,20 @@ void ena_com_dump_single_tx_cdesc(struct ena_com_io_cq *io_cq,
 		ena_trc_err(ena_com_io_cq_to_ena_dev(io_cq),
 			    "TX descriptor value[0x%08x 0x%08x] phase[%u] MBZ6[%u]\n",
 			    desc_arr[0], desc_arr[1],
-			    ENA_FIELD_GET(desc->flags, (uint32_t)ENA_ETH_IO_TX_CDESC_PHASE_MASK,
-					  0),
-			    ENA_FIELD_GET(desc->flags, (uint32_t)ENA_ETH_IO_TX_CDESC_MBZ6_MASK,
-					  ENA_ETH_IO_TX_CDESC_MBZ6_SHIFT));
+			    ENA_FIELD_GET(desc->base.flags,
+				(uint32_t)ENA_ETH_IO_TX_CDESC_PHASE_MASK,
+				0),
+			    ENA_FIELD_GET(desc->base.flags,
+				(uint32_t)ENA_ETH_IO_TX_CDESC_MBZ6_MASK,
+				ENA_ETH_IO_TX_CDESC_MBZ6_SHIFT));
 	}
 }
 
-struct ena_eth_io_tx_cdesc *ena_com_tx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx)
+struct ena_eth_io_tx_cdesc_ext *ena_com_tx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx)
 {
 	idx &= (io_cq->q_depth - 1);
 
-	return (struct ena_eth_io_tx_cdesc *)
+	return (struct ena_eth_io_tx_cdesc_ext *)
 		((uintptr_t)io_cq->cdesc_addr.virt_addr +
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
@@ -97,7 +102,6 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 						     u8 *bounce_buffer)
 {
 	struct ena_com_llq_info *llq_info = &io_sq->llq_info;
-
 	u16 dst_tail_mask;
 	u32 dst_offset;
 
@@ -273,11 +277,11 @@ static int ena_com_sq_update_tail(struct ena_com_io_sq *io_sq)
 	return ena_com_sq_update_reqular_queue_tail(io_sq);
 }
 
-struct ena_eth_io_rx_cdesc_base *
+struct ena_eth_io_rx_cdesc_ext *
 	ena_com_rx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx)
 {
 	idx &= (io_cq->q_depth - 1);
-	return (struct ena_eth_io_rx_cdesc_base *)
+	return (struct ena_eth_io_rx_cdesc_ext *)
 		((uintptr_t)io_cq->cdesc_addr.virt_addr +
 		idx * io_cq->cdesc_entry_size_in_bytes);
 }
@@ -288,7 +292,7 @@ static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 {
 	struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
 	u16 count = io_cq->cur_rx_pkt_cdesc_count, head_masked;
-	struct ena_eth_io_rx_cdesc_base *cdesc;
+	struct ena_eth_io_rx_cdesc_ext *cdesc;
 	u32 last = 0;
 
 	do {
@@ -297,7 +301,7 @@ static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 		cdesc = ena_com_get_next_rx_cdesc(io_cq);
 		if (!cdesc)
 			break;
-		status = READ_ONCE32(cdesc->status);
+		status = READ_ONCE32(cdesc->base.status);
 
 		if (unlikely(ENA_FIELD_GET(status,
 					   ENA_ETH_IO_RX_CDESC_BASE_FIRST_MASK,
@@ -305,7 +309,7 @@ static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			     count != 0)) {
 			ena_trc_err(dev,
 				    "First bit is on in descriptor #%u on q_id: %u, req_id: %u\n",
-				    count, io_cq->qid, cdesc->req_id);
+				    count, io_cq->qid, cdesc->base.req_id);
 			return ENA_COM_FAULT;
 		}
 
@@ -314,7 +318,7 @@ static int ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 			      ena_com_get_cap(dev, ENA_ADMIN_CDESC_MBZ))) {
 			ena_trc_err(dev,
 				    "Corrupted RX descriptor #%u on q_id: %u, req_id: %u\n",
-				    count, io_cq->qid, cdesc->req_id);
+				    count, io_cq->qid, cdesc->base.req_id);
 			return ENA_COM_FAULT;
 		}
 
@@ -423,29 +427,29 @@ static int ena_com_create_and_store_tx_meta_desc(struct ena_com_io_sq *io_sq,
 }
 
 static void ena_com_rx_set_flags(struct ena_com_rx_ctx *ena_rx_ctx,
-				 struct ena_eth_io_rx_cdesc_base *cdesc)
+				 struct ena_eth_io_rx_cdesc_ext *cdesc)
 {
-	ena_rx_ctx->l3_proto = cdesc->status &
+	ena_rx_ctx->l3_proto = cdesc->base.status &
 		ENA_ETH_IO_RX_CDESC_BASE_L3_PROTO_IDX_MASK;
 	ena_rx_ctx->l4_proto =
-		ENA_FIELD_GET(cdesc->status,
+		ENA_FIELD_GET(cdesc->base.status,
 			      ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_MASK,
 			      ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_SHIFT);
 	ena_rx_ctx->l3_csum_err =
-		!!(ENA_FIELD_GET(cdesc->status,
+		!!(ENA_FIELD_GET(cdesc->base.status,
 				 ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_MASK,
 				 ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_SHIFT));
 	ena_rx_ctx->l4_csum_err =
-		!!(ENA_FIELD_GET(cdesc->status,
+		!!(ENA_FIELD_GET(cdesc->base.status,
 				 ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_MASK,
 				 ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_SHIFT));
 	ena_rx_ctx->l4_csum_checked =
-		!!(ENA_FIELD_GET(cdesc->status,
+		!!(ENA_FIELD_GET(cdesc->base.status,
 				 ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_MASK,
 				 ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_SHIFT));
-	ena_rx_ctx->hash = cdesc->hash;
+	ena_rx_ctx->hash = cdesc->base.hash;
 	ena_rx_ctx->frag =
-		ENA_FIELD_GET(cdesc->status,
+		ENA_FIELD_GET(cdesc->base.status,
 			      ENA_ETH_IO_RX_CDESC_BASE_IPV4_FRAG_MASK,
 			      ENA_ETH_IO_RX_CDESC_BASE_IPV4_FRAG_SHIFT);
 }
@@ -619,7 +623,7 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 		   struct ena_com_rx_ctx *ena_rx_ctx)
 {
 	struct ena_com_rx_buf_info *ena_buf = &ena_rx_ctx->ena_bufs[0];
-	struct ena_eth_io_rx_cdesc_base *cdesc = NULL;
+	struct ena_eth_io_rx_cdesc_ext *cdesc = NULL;
 	u16 q_depth = io_cq->q_depth;
 	u16 cdesc_idx = 0;
 	u16 nb_hw_desc;
@@ -650,11 +654,11 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	}
 
 	cdesc = ena_com_rx_cdesc_idx_to_ptr(io_cq, cdesc_idx);
-	ena_rx_ctx->pkt_offset = cdesc->offset;
+	ena_rx_ctx->pkt_offset = cdesc->base.offset;
 
 	do {
-		ena_buf[i].len = cdesc->length;
-		ena_buf[i].req_id = cdesc->req_id;
+		ena_buf[i].len = cdesc->base.length;
+		ena_buf[i].req_id = cdesc->base.req_id;
 		if (unlikely(ena_buf[i].req_id >= q_depth))
 			return ENA_COM_EIO;
 
@@ -683,7 +687,7 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 		    ena_rx_ctx->l4_csum_err,
 		    ena_rx_ctx->hash,
 		    ena_rx_ctx->frag,
-		    cdesc->status);
+		    cdesc->base.status);
 
 	ena_rx_ctx->descs = nb_hw_desc;
 
@@ -731,7 +735,7 @@ int ena_com_add_single_rx_desc(struct ena_com_io_sq *io_sq,
 
 bool ena_com_cq_empty(struct ena_com_io_cq *io_cq)
 {
-	struct ena_eth_io_rx_cdesc_base *cdesc;
+	struct ena_eth_io_rx_cdesc_ext *cdesc;
 
 	cdesc = ena_com_get_next_rx_cdesc(io_cq);
 	if (cdesc)
diff --git a/drivers/net/ena/base/ena_eth_com.h b/drivers/net/ena/base/ena_eth_com.h
index 9e0a7af325..e8f6f09359 100644
--- a/drivers/net/ena/base/ena_eth_com.h
+++ b/drivers/net/ena/base/ena_eth_com.h
@@ -17,12 +17,12 @@ extern "C" {
 #define ENA_LLQ_LARGE_HEADER	(256UL - ENA_LLQ_ENTRY_DESC_CHUNK_SIZE)
 
 void ena_com_dump_single_rx_cdesc(struct ena_com_io_cq *io_cq,
-				  struct ena_eth_io_rx_cdesc_base *desc);
+				  struct ena_eth_io_rx_cdesc_ext *desc);
 void ena_com_dump_single_tx_cdesc(struct ena_com_io_cq *io_cq,
-				  struct ena_eth_io_tx_cdesc *desc);
-struct ena_eth_io_rx_cdesc_base *ena_com_get_next_rx_cdesc(struct ena_com_io_cq *io_cq);
-struct ena_eth_io_rx_cdesc_base *ena_com_rx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx);
-struct ena_eth_io_tx_cdesc *ena_com_tx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx);
+				  struct ena_eth_io_tx_cdesc_ext *desc);
+struct ena_eth_io_rx_cdesc_ext *ena_com_get_next_rx_cdesc(struct ena_com_io_cq *io_cq);
+struct ena_eth_io_rx_cdesc_ext *ena_com_rx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx);
+struct ena_eth_io_tx_cdesc_ext *ena_com_tx_cdesc_idx_to_ptr(struct ena_com_io_cq *io_cq, u16 idx);
 
 struct ena_com_tx_ctx {
 	struct ena_com_tx_meta ena_meta;
@@ -76,6 +76,16 @@ int ena_com_add_single_rx_desc(struct ena_com_io_sq *io_sq,
 
 bool ena_com_cq_empty(struct ena_com_io_cq *io_cq);
 
+static inline bool ena_com_is_extended_tx_cdesc(struct ena_com_io_cq *io_cq)
+{
+	return io_cq->cdesc_entry_size_in_bytes == sizeof(struct ena_eth_io_tx_cdesc_ext);
+}
+
+static inline bool ena_com_is_extended_rx_cdesc(struct ena_com_io_cq *io_cq)
+{
+	return io_cq->cdesc_entry_size_in_bytes == sizeof(struct ena_eth_io_rx_cdesc_ext);
+}
+
 static inline void ena_com_unmask_intr(struct ena_com_io_cq *io_cq,
 				       struct ena_eth_io_intr_reg *intr_reg)
 {
@@ -227,19 +237,19 @@ static inline int ena_com_tx_comp_req_id_get(struct ena_com_io_cq *io_cq,
 					     u16 *req_id)
 {
 	struct ena_com_dev *dev = ena_com_io_cq_to_ena_dev(io_cq);
+	struct ena_eth_io_tx_cdesc_ext *cdesc;
 	u8 expected_phase, cdesc_phase;
-	struct ena_eth_io_tx_cdesc *cdesc;
 	u16 masked_head;
 	u8 flags;
 
 	masked_head = io_cq->head & (io_cq->q_depth - 1);
 	expected_phase = io_cq->phase;
 
-	cdesc = (struct ena_eth_io_tx_cdesc *)
+	cdesc = (struct ena_eth_io_tx_cdesc_ext *)
 		((uintptr_t)io_cq->cdesc_addr.virt_addr +
 		(masked_head * io_cq->cdesc_entry_size_in_bytes));
 
-	flags = READ_ONCE8(cdesc->flags);
+	flags = READ_ONCE8(cdesc->base.flags);
 
 	/* When the current completion descriptor phase isn't the same as the
 	 * expected, it mean that the device still didn't update
@@ -255,16 +265,16 @@ static inline int ena_com_tx_comp_req_id_get(struct ena_com_io_cq *io_cq,
 		      ena_com_get_cap(dev, ENA_ADMIN_CDESC_MBZ))) {
 		ena_trc_err(dev,
 			    "Corrupted TX descriptor on q_id: %d, req_id: %u\n",
-			    io_cq->qid, cdesc->req_id);
+			    io_cq->qid, cdesc->base.req_id);
 		return ENA_COM_FAULT;
 	}
 
 	dma_rmb();
 
-	*req_id = READ_ONCE16(cdesc->req_id);
+	*req_id = READ_ONCE16(cdesc->base.req_id);
 	if (unlikely(*req_id >= io_cq->q_depth)) {
 		ena_trc_err(ena_com_io_cq_to_ena_dev(io_cq),
-			    "Invalid req id %d\n", cdesc->req_id);
+			    "Invalid req id %d\n", cdesc->base.req_id);
 		return ENA_COM_INVAL;
 	}
 
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index f5cf5c3811..b2d61c881b 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -1438,8 +1438,9 @@ static int ena_create_io_queue(struct rte_eth_dev *dev, struct ena_ring *ring)
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ena_com_create_io_ctx ctx =
+		/* policy set to _HOST just to satisfy icc compiler */
 		{ ENA_ADMIN_PLACEMENT_POLICY_HOST,
-		  0, 0, 0, 0, 0 };
+		  0, 0, 0, 0, 0, 0 };
 	uint16_t ena_qid;
 	unsigned int i;
 	int rc;
-- 
2.17.1

