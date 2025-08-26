Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB8C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 00:04:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2CD8402DA;
	Tue, 26 Aug 2025 02:03:47 +0200 (CEST)
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com
 [209.85.210.201])
 by mails.dpdk.org (Postfix) with ESMTP id CA7EF402D4
 for <dev@dpdk.org>; Tue, 26 Aug 2025 02:03:45 +0200 (CEST)
Received: by mail-pf1-f201.google.com with SMTP id
 d2e1a72fcca58-770d7a5f812so1382828b3a.1
 for <dev@dpdk.org>; Mon, 25 Aug 2025 17:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756166625; x=1756771425; darn=dpdk.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ymkgRYLVgWj4og8kDqD694TVTZjWyCVom5BXi/KFluI=;
 b=gJvlmtmu68L1H3W3gkmqeVa21QkRNQU+1FzxVa4TuGo8EBe9wWmHaBRmujkvMcQAMU
 2QXyv1As6XQnbpSMMdZ1mFmRe+KzHQsxmBUap+ZcNWWBVePKybtGPeG/vGyQpsDowW6A
 +ogNzSDP3WGUl5hBlGlJUkCbPDGWutitzgdxDyXiO8gz6oVn7eTUT6srxlURKSC7pc0p
 J9RaI2BF4UgQ87vydCOBegZBQKQH7kqvgJuLkCADfDsESxm42NvlLlsCnAPSSrl4+rZ7
 QYFDkWC8pph1+/hpmkFXnssPXBWYknp4gonvEbKUzijdVkT62nhDj2B/euX/e/vjVVdU
 Fz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756166625; x=1756771425;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ymkgRYLVgWj4og8kDqD694TVTZjWyCVom5BXi/KFluI=;
 b=nCCwrkWtZ3nmknBfh9YpeTr4+OePbX4lQaqsa9TyI0oO10A4sttFdxLyyixXXxSo43
 PNkGH4Z49QsMU909jGtH6SP6XZIXRSdP00Z13OkDLca7E3Kockr1EJLTr+4I6oyXn343
 6AvtWh2fH0LA9Ow2pIGz1Blp9Vc666N6+iWNKlGifBU4+9oXRwwR6O1fg4Jlh6mncZYS
 Ci7vWKtjnyTt24ph/kbL3p7/Fea8xBWgapm4m6pyOYpCeuMUZNzgZeQpk43OvqYhZZrJ
 OHgQz+7P2+SuN14cUyAUajIFr79t7Gs00LeiOq377tuI3zQINzj2YtIuOU/PORiB3Jyg
 I/2Q==
X-Gm-Message-State: AOJu0YzQbgVY91UFul+suI+peJ/mT/PBZmYh9zEo9sIDeD+jNsX/wdGw
 GviXmz2ACk3+HWKW2b+UABRS7vXu3Rno73wzAODz9r+ft1bW9mTCZVsny6Zjqgtjmo1G+lTgzoI
 tzod6Rnh+Osr4+Q==
X-Google-Smtp-Source: AGHT+IHZAChI03CbBc6g8bSQBl0ri79TBBRuzUA1xQab5PjhwhXA5/rtvU6mnlOY1bFZzG1OtRdYrNGTnEOFbQ==
X-Received: from pfbim16.prod.google.com ([2002:a05:6a00:8d90:b0:771:eb1f:a2e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:8cc:b0:76e:7ae9:e86a with SMTP id
 d2e1a72fcca58-7702fb0044bmr14495284b3a.26.1756166624977; 
 Mon, 25 Aug 2025 17:03:44 -0700 (PDT)
Date: Mon, 25 Aug 2025 17:03:36 -0700
In-Reply-To: <20250826000337.3922883-1-joshwash@google.com>
Mime-Version: 1.0
References: <20250826000337.3922883-1-joshwash@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826000337.3922883-4-joshwash@google.com>
Subject: [PATCH 3/4] net/gve: support for out of order completions on DQ Tx
From: Joshua Washington <joshwash@google.com>
To: Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>
Cc: dev@dpdk.org, Ankit Garg <nktgrg@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Prior to this patch, the DQ format made use of two separate arrays which
dictate the TX submission queue, named tx_ring and sw_ring. The tx_ring
represented the actual hardware descriptor ring, while the sw_ring
represented a ring of DMA'd buffers to be used in transmission.

Given that the DQ format makes use of out-of-order completions, the use
of a queue for keeping track of buffers DMA'd to the hardware is
sub-optimal at best, and error-prone in the worst case. Because
completions can come out of order, it was possible to hit a case where
the next buffer to be posted in the submission ring to have not yet
gotten a completion. If this is the case, the driver would have to
pause transmission until the completion is received or risk leaving a
pointer unfreed. In this sense, to prevent memory leaks, the driver must
act as if the completions come in-order, sometimes pausing traffic even
though there are buffers ready to be used, which can lead to degraded
performance.

To combat this, the GVE driver made a 4x multiplier for the sw_ring
size, relative to the size of the hardware ring. However, this
mitigation had no true guarantee against memory leaks, and should not
have been relied on for a correctly behaving driver.

DQ completions happen at a packet granularity, not a buffer granularity.
As such, this patch introduces a new pkt_ring_dqo struct, allowing
multidescriptor packets not to take up as many entries in the "sw_ring".
Additionally, new free list stack is introduced to obtain available
completion tags, allowing for packet completions to be properly processed
out of order. Where the sw_ring would have at once been overrun, there
is a new limitation on the number of available completion tags, which
aligns with the number of possible outstanding packets.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Ankit Garg <nktgrg@google.com>
---
 drivers/net/gve/base/gve_adminq.c |   2 +-
 drivers/net/gve/gve_ethdev.h      |  16 +-
 drivers/net/gve/gve_tx_dqo.c      | 243 ++++++++++++++++++------------
 3 files changed, 160 insertions(+), 101 deletions(-)

diff --git a/drivers/net/gve/base/gve_adminq.c b/drivers/net/gve/base/gve_adminq.c
index b1fe33080a..5d3270106c 100644
--- a/drivers/net/gve/base/gve_adminq.c
+++ b/drivers/net/gve/base/gve_adminq.c
@@ -582,7 +582,7 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 		cmd.create_tx_queue.tx_comp_ring_addr =
 			cpu_to_be64(txq->compl_ring_phys_addr);
 		cmd.create_tx_queue.tx_comp_ring_size =
-			cpu_to_be16(txq->sw_size);
+			cpu_to_be16(txq->nb_complq_desc);
 	}
 
 	return gve_adminq_issue_cmd(priv, &cmd);
diff --git a/drivers/net/gve/gve_ethdev.h b/drivers/net/gve/gve_ethdev.h
index 195dadc4d4..b36f0ff746 100644
--- a/drivers/net/gve/gve_ethdev.h
+++ b/drivers/net/gve/gve_ethdev.h
@@ -119,16 +119,25 @@ struct gve_xstats_name_offset {
 	unsigned int offset;
 };
 
+struct gve_tx_pkt {
+	struct rte_mbuf *mbuf;
+	int16_t next_avail_pkt; /* Entry in software ring for next free packet slot */
+};
+
 struct gve_tx_queue {
 	volatile union gve_tx_desc *tx_desc_ring;
 	const struct rte_memzone *mz;
 	uint64_t tx_ring_phys_addr;
-	struct rte_mbuf **sw_ring;
+	union {
+		struct rte_mbuf **sw_ring;
+		struct gve_tx_pkt *pkt_ring_dqo;
+	};
 	volatile rte_be32_t *qtx_tail;
 	volatile rte_be32_t *qtx_head;
 
 	uint32_t tx_tail;
 	uint16_t nb_tx_desc;
+	uint16_t nb_complq_desc;
 	uint16_t nb_free;
 	uint16_t nb_used;
 	uint32_t next_to_clean;
@@ -162,6 +171,11 @@ struct gve_tx_queue {
 	/* newly added for DQO */
 	volatile union gve_tx_desc_dqo *tx_ring;
 	struct gve_tx_compl_desc *compl_ring;
+
+	/* List of free completion tags that map into sw_ring. */
+	int16_t free_compl_tags_head;
+	uint16_t num_free_compl_tags;
+
 	const struct rte_memzone *compl_ring_mz;
 	uint64_t compl_ring_phys_addr;
 	uint32_t complq_tail;
diff --git a/drivers/net/gve/gve_tx_dqo.c b/drivers/net/gve/gve_tx_dqo.c
index 10ef645802..4948502725 100644
--- a/drivers/net/gve/gve_tx_dqo.c
+++ b/drivers/net/gve/gve_tx_dqo.c
@@ -5,6 +5,50 @@
 
 #include "gve_ethdev.h"
 #include "base/gve_adminq.h"
+#include "rte_malloc.h"
+
+static inline void
+gve_free_compl_tags_init(struct gve_tx_queue *txq)
+{
+	uint16_t sw_mask = txq->sw_size - 1;
+	int i;
+
+	for (i = 0; i < sw_mask; i++)
+		txq->pkt_ring_dqo[i].next_avail_pkt = (i + 1) & sw_mask;
+
+	txq->pkt_ring_dqo[sw_mask].next_avail_pkt = -1;
+	txq->free_compl_tags_head = 0;
+	txq->num_free_compl_tags = txq->sw_size;
+}
+
+/* Removes first item from the buffer free list, and return its array index. */
+static inline bool
+gve_free_compl_tags_pop(struct gve_tx_queue *txq, uint16_t *compl_tag)
+{
+	int16_t head = txq->free_compl_tags_head;
+	if (likely(head != -1)) {
+		struct gve_tx_pkt *head_pkt = &txq->pkt_ring_dqo[head];
+
+		txq->free_compl_tags_head = head_pkt->next_avail_pkt;
+		txq->num_free_compl_tags--;
+		*compl_tag = head;
+		return true;
+	}
+
+	PMD_DRV_DP_LOG(ERR, "Completion tags list is empty!");
+	return false;
+}
+
+/* Adds gve_tx_pkt in pkt_ring to free list. Assumes that
+ * buf_id < txq->sw_size.
+ */
+static inline void
+gve_free_compl_tags_push(struct gve_tx_queue *txq, uint16_t compl_tag)
+{
+	txq->pkt_ring_dqo[compl_tag].next_avail_pkt = txq->free_compl_tags_head;
+	txq->free_compl_tags_head = compl_tag;
+	txq->num_free_compl_tags++;
+}
 
 static inline void
 gve_tx_clean_dqo(struct gve_tx_queue *txq)
@@ -12,8 +56,8 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 	struct gve_tx_compl_desc *compl_ring;
 	struct gve_tx_compl_desc *compl_desc;
 	struct gve_tx_queue *aim_txq;
-	uint16_t nb_desc_clean;
-	struct rte_mbuf *txe, *txe_next;
+	struct gve_tx_pkt *pkt;
+	uint16_t new_tx_head;
 	uint16_t compl_tag;
 	uint16_t next;
 
@@ -26,35 +70,38 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 
 	rte_io_rmb();
 
-	compl_tag = rte_le_to_cpu_16(compl_desc->completion_tag);
-
 	aim_txq = txq->txqs[compl_desc->id];
 
 	switch (compl_desc->type) {
 	case GVE_COMPL_TYPE_DQO_DESC:
-		/* need to clean Descs from last_cleaned to compl_tag */
-		if (aim_txq->last_desc_cleaned > compl_tag)
-			nb_desc_clean = aim_txq->nb_tx_desc - aim_txq->last_desc_cleaned +
-					compl_tag;
-		else
-			nb_desc_clean = compl_tag - aim_txq->last_desc_cleaned;
-		aim_txq->nb_free += nb_desc_clean;
-		aim_txq->last_desc_cleaned = compl_tag;
+		new_tx_head = rte_le_to_cpu_16(compl_desc->tx_head);
+		aim_txq->nb_free +=
+			(new_tx_head - aim_txq->last_desc_cleaned)
+				& (aim_txq->nb_tx_desc - 1);
+		aim_txq->last_desc_cleaned = new_tx_head;
 		break;
 	case GVE_COMPL_TYPE_DQO_REINJECTION:
 		PMD_DRV_DP_LOG(DEBUG, "GVE_COMPL_TYPE_DQO_REINJECTION !!!");
 		/* FALLTHROUGH */
 	case GVE_COMPL_TYPE_DQO_PKT:
-		/* free all segments. */
-		txe = aim_txq->sw_ring[compl_tag];
-		while (txe != NULL) {
-			txe_next = txe->next;
-			rte_pktmbuf_free_seg(txe);
-			if (aim_txq->sw_ring[compl_tag] == txe)
-				aim_txq->sw_ring[compl_tag] = NULL;
-			txe = txe_next;
-			compl_tag = (compl_tag + 1) & (aim_txq->sw_size - 1);
+		/* The first segment has buf_id == completion_tag. */
+		compl_tag = rte_le_to_cpu_16(compl_desc->completion_tag);
+		if (unlikely(compl_tag >= txq->sw_size)) {
+			PMD_DRV_DP_LOG(ERR, "Invalid completion tag %d",
+				       compl_tag);
+			break;
+		}
+
+		/* Free packet.*/
+		pkt = &aim_txq->pkt_ring_dqo[compl_tag];
+		if (unlikely(!pkt->mbuf)) {
+			PMD_DRV_DP_LOG(ERR, "No outstanding packet for completion tag %d",
+				       compl_tag);
+			break;
 		}
+		rte_pktmbuf_free(pkt->mbuf);
+		pkt->mbuf = NULL;
+		gve_free_compl_tags_push(txq, compl_tag);
 		break;
 	case GVE_COMPL_TYPE_DQO_MISS:
 		rte_delay_us_sleep(1);
@@ -66,11 +113,10 @@ gve_tx_clean_dqo(struct gve_tx_queue *txq)
 	}
 
 	next++;
-	if (next == txq->nb_tx_desc * DQO_TX_MULTIPLIER) {
+	if (next == txq->nb_complq_desc) {
 		next = 0;
 		txq->cur_gen_bit ^= 1;
 	}
-
 	txq->complq_tail = next;
 }
 
@@ -155,6 +201,12 @@ gve_tx_pkt_nb_data_descs(struct rte_mbuf *tx_pkt)
 	return nb_descs;
 }
 
+static inline bool
+gve_can_tx(struct gve_tx_queue *txq, uint16_t nb_desc, uint16_t nb_pkts)
+{
+	return txq->nb_free >= nb_desc && txq->num_free_compl_tags >= nb_pkts;
+}
+
 static inline void
 gve_tx_fill_seg_desc_dqo(volatile union gve_tx_desc_dqo *desc, struct rte_mbuf *tx_pkt)
 {
@@ -168,39 +220,60 @@ gve_tx_fill_seg_desc_dqo(volatile union gve_tx_desc_dqo *desc, struct rte_mbuf *
 	desc->tso_ctx.header_len = (uint8_t)hlen;
 }
 
+static void
+gve_fill_tx_pkt_desc(struct gve_tx_queue *txq, uint16_t *tx_id,
+		     struct rte_mbuf *tx_pkt, uint16_t compl_tag,
+		     bool checksum_offload_enable)
+{
+	volatile union gve_tx_desc_dqo *desc;
+	uint16_t mask = txq->nb_tx_desc - 1;
+	int mbuf_offset = 0;
+
+	while (mbuf_offset < tx_pkt->data_len) {
+		uint64_t buf_addr = rte_mbuf_data_iova(tx_pkt) + mbuf_offset;
+
+		desc = &txq->tx_ring[*tx_id];
+		desc->pkt = (struct gve_tx_pkt_desc_dqo) {};
+		desc->pkt.buf_addr = rte_cpu_to_le_64(buf_addr);
+		desc->pkt.compl_tag = rte_cpu_to_le_16(compl_tag);
+		desc->pkt.dtype = GVE_TX_PKT_DESC_DTYPE_DQO;
+		desc->pkt.buf_size = RTE_MIN(tx_pkt->data_len - mbuf_offset,
+					     GVE_TX_MAX_BUF_SIZE_DQO);
+		desc->pkt.end_of_packet = 0;
+		desc->pkt.checksum_offload_enable = checksum_offload_enable;
+
+		mbuf_offset += desc->pkt.buf_size;
+		*tx_id = (*tx_id + 1) & mask;
+	}
+}
+
 uint16_t
 gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 {
 	struct gve_tx_queue *txq = tx_queue;
 	volatile union gve_tx_desc_dqo *txr;
 	volatile union gve_tx_desc_dqo *txd;
-	struct rte_mbuf **sw_ring;
+	uint16_t mask = txq->nb_tx_desc - 1;
+	struct gve_tx_pkt *pkts;
 	struct rte_mbuf *tx_pkt;
-	uint16_t mask, sw_mask;
-	uint16_t first_sw_id;
+	uint16_t compl_tag;
 	const char *reason;
 	uint16_t nb_tx = 0;
+	uint64_t bytes = 0;
 	uint64_t ol_flags;
 	uint16_t nb_descs;
+	bool csum, tso;
 	uint16_t tx_id;
-	uint16_t sw_id;
-	uint64_t bytes;
-	uint8_t tso;
-	uint8_t csum;
 
-	sw_ring = txq->sw_ring;
+	pkts = txq->pkt_ring_dqo;
 	txr = txq->tx_ring;
 
-	bytes = 0;
-	mask = txq->nb_tx_desc - 1;
-	sw_mask = txq->sw_size - 1;
 	tx_id = txq->tx_tail;
-	sw_id = txq->sw_tail;
 
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
 
-		if (txq->nb_free <= txq->free_thresh)
+		if (!gve_can_tx(txq, txq->free_thresh, nb_pkts - nb_tx))
 			gve_tx_clean_descs_dqo(txq, DQO_TX_MULTIPLIER *
 					       txq->rs_thresh);
 
@@ -211,8 +284,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		}
 
 		ol_flags = tx_pkt->ol_flags;
-		first_sw_id = sw_id;
-
 		tso = !!(ol_flags & RTE_MBUF_F_TX_TCP_SEG);
 		csum = !!(ol_flags & GVE_TX_CKSUM_OFFLOAD_MASK_DQO);
 
@@ -220,12 +291,12 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		nb_descs += tso;
 
 		/* Clean if there aren't enough descriptors to send the packet. */
-		if (unlikely(txq->nb_free < nb_descs)) {
+		if (unlikely(!gve_can_tx(txq, nb_descs, 1))) {
 			int nb_to_clean = RTE_MAX(DQO_TX_MULTIPLIER * txq->rs_thresh,
 						  nb_descs);
 
 			gve_tx_clean_descs_dqo(txq, nb_to_clean);
-			if (txq->nb_free < nb_descs)
+			if (!gve_can_tx(txq, nb_descs, 1))
 				break;
 		}
 
@@ -241,44 +312,21 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			tx_id = (tx_id + 1) & mask;
 		}
 
-		do {
-			if (sw_ring[sw_id] != NULL)
-				PMD_DRV_DP_LOG(DEBUG,
-					       "Overwriting an entry in sw_ring");
-
-			/* Skip writing descriptor if mbuf has no data. */
-			if (!tx_pkt->data_len)
-				goto finish_mbuf;
+		if (!gve_free_compl_tags_pop(txq, &compl_tag))
+			break;
 
-			txd = &txr[tx_id];
-			sw_ring[sw_id] = tx_pkt;
-
-			/* fill Tx descriptors */
-			int mbuf_offset = 0;
-			while (mbuf_offset < tx_pkt->data_len) {
-				uint64_t buf_addr = rte_mbuf_data_iova(tx_pkt) +
-					mbuf_offset;
-
-				txd = &txr[tx_id];
-				txd->pkt = (struct gve_tx_pkt_desc_dqo) {};
-				txd->pkt.buf_addr = rte_cpu_to_le_64(buf_addr);
-				txd->pkt.compl_tag = rte_cpu_to_le_16(first_sw_id);
-				txd->pkt.dtype = GVE_TX_PKT_DESC_DTYPE_DQO;
-				txd->pkt.buf_size = RTE_MIN(tx_pkt->data_len - mbuf_offset,
-							    GVE_TX_MAX_BUF_SIZE_DQO);
-				txd->pkt.end_of_packet = 0;
-				txd->pkt.checksum_offload_enable = csum;
-
-				mbuf_offset += txd->pkt.buf_size;
-				tx_id = (tx_id + 1) & mask;
+		pkts[compl_tag].mbuf = tx_pkt;
+		while (tx_pkt) {
+			/* Skip writing descriptors if mbuf has no data. */
+			if (!tx_pkt->data_len) {
+				tx_pkt = tx_pkt->next;
+				continue;
 			}
-
-finish_mbuf:
-			sw_id = (sw_id + 1) & sw_mask;
+			gve_fill_tx_pkt_desc(txq, &tx_id, tx_pkt, compl_tag,
+					     csum);
 			bytes += tx_pkt->data_len;
 			tx_pkt = tx_pkt->next;
-		} while (tx_pkt);
-
+		}
 		/* fill the last written descriptor with End of Packet (EOP) bit */
 		txd = &txr[(tx_id - 1) & mask];
 		txd->pkt.end_of_packet = 1;
@@ -299,7 +347,6 @@ gve_tx_burst_dqo(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		rte_write32(tx_id, txq->qtx_tail);
 		txq->tx_tail = tx_id;
-		txq->sw_tail = sw_id;
 
 		txq->stats.packets += nb_tx;
 		txq->stats.bytes += bytes;
@@ -314,12 +361,8 @@ gve_release_txq_mbufs_dqo(struct gve_tx_queue *txq)
 {
 	uint16_t i;
 
-	for (i = 0; i < txq->sw_size; i++) {
-		if (txq->sw_ring[i]) {
-			rte_pktmbuf_free_seg(txq->sw_ring[i]);
-			txq->sw_ring[i] = NULL;
-		}
-	}
+	for (i = 0; i < txq->sw_size; i++)
+		rte_pktmbuf_free(txq->pkt_ring_dqo[i].mbuf);
 }
 
 void
@@ -331,7 +374,7 @@ gve_tx_queue_release_dqo(struct rte_eth_dev *dev, uint16_t qid)
 		return;
 
 	gve_release_txq_mbufs_dqo(q);
-	rte_free(q->sw_ring);
+	rte_free(q->pkt_ring_dqo);
 	rte_memzone_free(q->mz);
 	rte_memzone_free(q->compl_ring_mz);
 	rte_memzone_free(q->qres_mz);
@@ -372,13 +415,13 @@ check_tx_thresh_dqo(uint16_t nb_desc, uint16_t tx_rs_thresh,
 }
 
 static void
-gve_reset_txq_dqo(struct gve_tx_queue *txq)
+gve_reset_tx_ring_state_dqo(struct gve_tx_queue *txq)
 {
-	struct rte_mbuf **sw_ring;
+	struct gve_tx_pkt *pkt_ring_dqo;
 	uint32_t size, i;
 
 	if (txq == NULL) {
-		PMD_DRV_LOG(DEBUG, "Pointer to txq is NULL");
+		PMD_DRV_LOG(ERR, "Pointer to txq is NULL");
 		return;
 	}
 
@@ -386,19 +429,20 @@ gve_reset_txq_dqo(struct gve_tx_queue *txq)
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->tx_ring)[i] = 0;
 
-	size = txq->sw_size * sizeof(struct gve_tx_compl_desc);
+	size = txq->nb_complq_desc * sizeof(struct gve_tx_compl_desc);
 	for (i = 0; i < size; i++)
 		((volatile char *)txq->compl_ring)[i] = 0;
 
-	sw_ring = txq->sw_ring;
+	pkt_ring_dqo = txq->pkt_ring_dqo;
 	for (i = 0; i < txq->sw_size; i++)
-		sw_ring[i] = NULL;
+		pkt_ring_dqo[i].mbuf = NULL;
+
+	gve_free_compl_tags_init(txq);
 
 	txq->tx_tail = 0;
 	txq->nb_used = 0;
 
 	txq->last_desc_cleaned = 0;
-	txq->sw_tail = 0;
 	txq->nb_free = txq->nb_tx_desc - 1;
 
 	txq->complq_tail = 0;
@@ -442,6 +486,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 		return -EINVAL;
 
 	txq->nb_tx_desc = nb_desc;
+	txq->nb_complq_desc = nb_desc * DQO_TX_MULTIPLIER;
 	txq->free_thresh = free_thresh;
 	txq->rs_thresh = rs_thresh;
 	txq->queue_id = queue_id;
@@ -451,11 +496,11 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->ntfy_addr = &hw->db_bar2[rte_be_to_cpu_32(hw->irq_dbs[txq->ntfy_id].id)];
 
 	/* Allocate software ring */
-	sw_size = nb_desc * DQO_TX_MULTIPLIER;
-	txq->sw_ring = rte_zmalloc_socket("gve tx sw ring",
-					  sw_size * sizeof(struct rte_mbuf *),
+	sw_size = nb_desc;
+	txq->pkt_ring_dqo = rte_zmalloc_socket("gve tx sw ring",
+					  sw_size * sizeof(struct gve_tx_pkt),
 					  RTE_CACHE_LINE_SIZE, socket_id);
-	if (txq->sw_ring == NULL) {
+	if (txq->pkt_ring_dqo == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory for SW TX ring");
 		err = -ENOMEM;
 		goto free_txq;
@@ -469,7 +514,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX");
 		err = -ENOMEM;
-		goto free_txq_sw_ring;
+		goto free_txq_pkt_ring;
 	}
 	txq->tx_ring = (union gve_tx_desc_dqo *)mz->addr;
 	txq->tx_ring_phys_addr = mz->iova;
@@ -477,7 +522,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 
 	/* Allocate TX completion ring descriptors. */
 	mz = rte_eth_dma_zone_reserve(dev, "tx_compl_ring", queue_id,
-				      sw_size * sizeof(struct gve_tx_compl_desc),
+				       txq->nb_complq_desc * sizeof(struct gve_tx_compl_desc),
 				      PAGE_SIZE, socket_id);
 	if (mz == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to reserve DMA memory for TX completion queue");
@@ -500,7 +545,7 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	txq->qres = (struct gve_queue_resources *)mz->addr;
 	txq->qres_mz = mz;
 
-	gve_reset_txq_dqo(txq);
+	gve_reset_tx_ring_state_dqo(txq);
 
 	dev->data->tx_queues[queue_id] = txq;
 
@@ -510,8 +555,8 @@ gve_tx_queue_setup_dqo(struct rte_eth_dev *dev, uint16_t queue_id,
 	rte_memzone_free(txq->compl_ring_mz);
 free_txq_mz:
 	rte_memzone_free(txq->mz);
-free_txq_sw_ring:
-	rte_free(txq->sw_ring);
+free_txq_pkt_ring:
+	rte_free(txq->pkt_ring_dqo);
 free_txq:
 	rte_free(txq);
 	return err;
@@ -551,7 +596,7 @@ gve_tx_queue_stop_dqo(struct rte_eth_dev *dev, uint16_t tx_queue_id)
 
 	txq = dev->data->tx_queues[tx_queue_id];
 	gve_release_txq_mbufs_dqo(txq);
-	gve_reset_txq_dqo(txq);
+	gve_reset_tx_ring_state_dqo(txq);
 
 	dev->data->tx_queue_state[tx_queue_id] = RTE_ETH_QUEUE_STATE_STOPPED;
 
-- 
2.51.0.rc1.167.g924127e9c0-goog

