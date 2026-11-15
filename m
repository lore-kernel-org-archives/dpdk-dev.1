Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FF606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZqJ/kHrV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67CC8402C9;
	Tue, 17 Nov 2026 08:58:22 +0100 (CET)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mails.dpdk.org (Postfix) with ESMTPS id EE6164025A
 for <dev@dpdk.org>; Sun, 15 Nov 2026 15:00:18 +0100 (CET)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-946038e22f5so226804985a.0
 for <dev@dpdk.org>; Sun, 15 Nov 2026 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794751218; x=1795356018; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+tsdmPr9zdxUlnyJZbTXwJxc6lS/D4sb3Fho4B0iaFw=;
 b=ZqJ/kHrV1pe9SZinGm3WmJi8VogHOanlrJwHbj/JEC58ueq5Z7O21b1fRDfbklb00c
 JOyYCJx3y3Yd57B80Z8qxIdjK1XNTN/qUB5FdNNCzjoWoLfx/Prw1MRTTpXQKPLKXQK9
 Q7wpAhNqa9/+zTBGNtSvPGInfD8ZMZDYQxfUkllLar0JM+iCc6iLP1sh4x8vcUybcDbg
 IZHavy0RvZts9RP3w6aOrPEUWcNvmUT74gmahcYu+phtGAYEX2yPtX6Ll3EhL0ZKQ+vT
 T8az84jr3JNIfdLQDYA1C9KVjdG76WxMcocusIGJQ7KUvVfz/QPAFDABpAk4bF7pM25/
 Da9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794751218; x=1795356018;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+tsdmPr9zdxUlnyJZbTXwJxc6lS/D4sb3Fho4B0iaFw=;
 b=WQ7rQ7uni9aj5WIKzGmpUjYFMNfvrf0iH91xkRphz8CI7fzMEDFXnOoXSMpkK0dDol
 zur31ag/MXGMIZ5fApt5W+Ja7KuCFjEeFDSBOQ3d5l13KQuA/DaPU3V1oVTZtY9Yl5nv
 U3WlH5XbZEUi0sXpYLfL5VjVEKNBXd3o/Z3SpteO/rD3YfQ2Zypd+drVZLxSsI0q9HZW
 b8Qo5GTWJIsdJzX7xj4Un/AMjs2i0RujNvYG8Lw6s9oHze1Jdol1LlsgVb3VXfKjGDzJ
 y1sLvGCEazQxQSU8CN2/IROUKeNszVzjfR8H2g4mVMaDlEbyOTT2NgzIzw1/ReIlu6ic
 H5MQ==
X-Gm-Message-State: APuU4Z+G7nWIrUw8tLEIZWQosQk7uwUWMxJisfXMiTBymt4B/JoZUlfs
 kaax8rS05Uy/lRQsBNIt/SrDwOvV0i/MLrsebnaD1EuFKLhdhr5cdRX2njpHc1W8ZdsDiitN4J8
 bVCH06uarwPQMgJFXXRle5ofaI2YFPq4Ww69htrLKYQZtyOP0/ghyXdDxr9FT7n1L4Tgz7Nxhqo
 GZX8aMHt8N91yIquSP2hvZjA479czU
X-Received: from qkao9.prod.google.com ([2002:a05:620a:a809:b0:93f:c1b:9052])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a114:b0:949:5e26:e927
 with SMTP id af79cd13be357-9495e26ee0bmr766960085a.73.1794751217240; Sun, 15
 Nov 2026 06:00:17 -0800 (PST)
Date: Sun, 15 Nov 2026 09:00:16 -0500
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261115140016.3830109-1-rnwolfe@google.com>
Subject: [PATCH] net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, 
 Joshua Washington <joshwash@google.com>
Cc: stable@dpdk.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
 Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:58:20 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In GQI Queue Page List (GQI_QPL) mode each Tx queue copies outgoing
frames into a fixed QPL bounce FIFO (512 pages = 2 MiB on GCE, ~236
8,832-byte cacheline-aligned jumbo frames) even when nb_tx_desc is
configured to 2048. Under sustained jumbo bursts three bugs cause
unnecessary packet drops and mbuf tracking hazards:

1. Entry cleanup in gve_tx_burst_qpl() only ran when nb_free < free_thresh
   (32) or fifo_avail == 0. With 2048 descriptors, 236 jumbo frames leave
   nb_free = 1811 and non-zero remainder bytes in fifo_avail, so entry
   cleanup never ran and every QPL wrap stalled mid-burst. Reclaim when
   fifo_avail drops below half of fifo_size, and do not count normal
   FIFO/ring-full backpressure as hardware stats.errors.
2. When is_fifo_avail() failed mid-burst after queuing packets, the driver
   polled gve_tx_clean() once before writing qtx_tail, so the device had
   not yet started draining the newly queued frames, and a single
   GVE_TX_MAX_FREE_SZ batch after many small frames could stop short of
   freeing a jumbo slot. Flush qtx_tail first and loop gve_tx_clean()
   while next_to_clean advances.
3. sw_ring[sw_id] and the first TSO header slice were allocated/written
   before verifying total FIFO space, gve_free_bulk_mbuf() did not clear
   the first freed slot, and gve_tx_burst_ra() skipped mid-burst ring
   cleanup and wrote pkt_len instead of data_len into the first segment
   descriptor of multi-segment non-TSO packets.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 drivers/net/gve/gve_tx.c | 68 +++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 279669165f..2cf091f5be 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -19,6 +19,7 @@ gve_free_bulk_mbuf(struct rte_mbuf **txep, int num)
 	for (s = 0; s < num; s++) {
 		if (txep[s] != NULL) {
 			m = rte_pktmbuf_prefree_seg(txep[s]);
+			txep[s] = NULL;
 			if (m != NULL)
 				break;
 		}
@@ -200,7 +201,7 @@ gve_tx_fill_seg_desc(volatile union gve_tx_desc *desc, uint64_t ol_flags,
 }
 
 static inline bool
-is_fifo_avail(struct gve_tx_queue *txq, uint16_t len)
+is_fifo_avail(struct gve_tx_queue *txq, uint32_t len)
 {
 	if (txq->fifo_avail < len)
 		return false;
@@ -210,6 +211,26 @@ is_fifo_avail(struct gve_tx_queue *txq, uint16_t len)
 		return false;
 	return true;
 }
+
+static inline bool
+gve_tx_reclaim_fifo_qpl(struct gve_tx_queue *txq, uint32_t tx_tail,
+			uint32_t need)
+{
+	if (txq->tx_tail != tx_tail) {
+		rte_write32(rte_cpu_to_be_32(tx_tail), txq->qtx_tail);
+		txq->tx_tail = tx_tail;
+	}
+
+	do {
+		uint32_t prev_ntc = txq->next_to_clean;
+
+		gve_tx_clean(txq);
+		if (is_fifo_avail(txq, need))
+			return true;
+		if (txq->next_to_clean == prev_ntc)
+			return false;
+	} while (true);
+}
 static inline uint64_t
 gve_tx_alloc_from_fifo(struct gve_tx_queue *txq, uint16_t tx_id, uint16_t len)
 {
@@ -266,7 +287,8 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 	txr = txq->tx_desc_ring;
 
-	if (txq->nb_free < txq->free_thresh || txq->fifo_avail == 0)
+	if (txq->nb_free < txq->free_thresh ||
+	    txq->fifo_avail < (txq->fifo_size >> 1))
 		gve_tx_clean(txq);
 
 	if (txq->sw_nb_free < txq->free_thresh)
@@ -304,22 +326,23 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
 			tx_pkt->pkt_len;
 
-		if (!is_fifo_avail(txq, hlen)) {
-			gve_tx_clean(txq);
-			if (!is_fifo_avail(txq, hlen))
+		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+			uint32_t data_len, need;
+
+			if (unlikely(tx_pkt->pkt_len <= hlen))
+				goto end_of_tx;
+			data_len = tx_pkt->pkt_len - hlen;
+			need = RTE_ALIGN(hlen, RTE_CACHE_LINE_SIZE) +
+			       RTE_ALIGN(data_len, RTE_CACHE_LINE_SIZE);
+			if (!is_fifo_avail(txq, need) &&
+			    !gve_tx_reclaim_fifo_qpl(txq, tx_tail, need))
 				goto end_of_tx;
+		} else if (!is_fifo_avail(txq, hlen) &&
+			   !gve_tx_reclaim_fifo_qpl(txq, tx_tail, hlen)) {
+			goto end_of_tx;
 		}
 		fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id, hlen);
 
-		/* For TSO, check if there's enough fifo space for data first */
-		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-			if (!is_fifo_avail(txq, tx_pkt->pkt_len - hlen)) {
-				gve_tx_clean(txq);
-				if (!is_fifo_avail(txq, tx_pkt->pkt_len - hlen))
-					goto end_of_tx;
-			}
-		}
-
 		qpl_write_addr = (void *)(size_t)(fifo_addr + txq->fifo_base);
 		mbuf_header_addr = rte_pktmbuf_read(tx_pkt, 0, hlen, qpl_write_addr);
 
@@ -370,13 +393,14 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 end_of_tx:
 	if (nb_tx) {
-		rte_write32(rte_cpu_to_be_32(tx_tail), txq->qtx_tail);
-		txq->tx_tail = tx_tail;
+		if (txq->tx_tail != tx_tail) {
+			rte_write32(rte_cpu_to_be_32(tx_tail), txq->qtx_tail);
+			txq->tx_tail = tx_tail;
+		}
 		txq->sw_tail = sw_id;
 
 		txq->stats.packets += nb_tx;
 		txq->stats.bytes += bytes;
-		txq->stats.errors += nb_pkts - nb_tx;
 	}
 
 	return nb_tx;
@@ -411,8 +435,11 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
 			nb_used++;
 
-		if (txq->nb_free < nb_used)
-			goto end_of_tx;
+		if (txq->nb_free < nb_used) {
+			gve_tx_clean(txq);
+			if (txq->nb_free < nb_used)
+				goto end_of_tx;
+		}
 
 		tx_offload.l2_len = tx_pkt->l2_len;
 		tx_offload.l3_len = tx_pkt->l3_len;
@@ -424,7 +451,7 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		hlen = ol_flags & RTE_MBUF_F_TX_TCP_SEG ?
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
-			tx_pkt->pkt_len;
+			tx_pkt->data_len;
 		/*
 		 * if tso, the driver needs to fill 2 descs for 1 mbuf
 		 * so only put this mbuf into the 1st tx entry in sw ring
@@ -465,7 +492,6 @@ gve_tx_burst_ra(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 		txq->stats.packets += nb_tx;
 		txq->stats.bytes += bytes;
-		txq->stats.errors += nb_pkts - nb_tx;
 	}
 
 	return nb_tx;
-- 
2.56.0.679.gc527c65306-goog

