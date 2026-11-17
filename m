Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FC9606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pkkOYm9d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F16ED40430;
	Wed, 18 Nov 2026 10:20:05 +0100 (CET)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mails.dpdk.org (Postfix) with ESMTPS id 6ECBC402C4
 for <dev@dpdk.org>; Tue, 17 Nov 2026 15:11:49 +0100 (CET)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ebb902eebso46016196d6.3
 for <dev@dpdk.org>; Tue, 17 Nov 2026 06:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794924708; x=1795529508; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nVXxEyuwKrkaBxvEIDSadT9MWnLoT+BV4840HLVJyLE=;
 b=pkkOYm9dLQ1y3pIqzuTh+ZNKMWkxsmNf8R0dtr8kA4Wra1cvpNMhmNmPD4TshbMTuP
 lZeEfDxzdJ+oJqwPmFQ52rietsnP+gebBCky83XM4scUq2UCWKV9ErCakLEoXqPit1td
 mCjiQhiPlAnxnm3wR6GCppXTPfxuym5VwA+ofYy+el0pjkTAULf7k7ElIWOIegnz+HeB
 qfhd81XFELUDUR70JfuOup4GlMk0f1sCwtxdu0G0yH3FXrg8tyLTPhbbcuNZSDQzF7am
 93BZv1am7W04gXfVscXUfzXfidICtmlicV5/IDplTnTRQ0850X2ij7s/MlzIOAU1Ez4R
 3WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924708; x=1795529508;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nVXxEyuwKrkaBxvEIDSadT9MWnLoT+BV4840HLVJyLE=;
 b=Gn0EwynrWEfsjYyt4GtuMzRbeIEEthsrU8CZg+rza8L1yPBk8wPCkKFghNoZ/M1AGj
 Z6Q0XYkku89J+QX9ATLzNNiVa8Q0/R30mmA4xaNHZBmxw5r2+6eeWEq29RzyadbXh+T/
 HESDe8LVJg/6J8ht08YG7fYzS5kkOqrGlR4wbo9Z7n72Sp7eRqSXEAX/tCJn93MOUMuq
 4KOhdj5FlUN5Ez9smpl2BFN9y9JnckyXB/WnPhdI45zlkZ8CjYM4eBJPgnvBYTzj5LmN
 wE2D8VM6+82IYoqY+hyQ9aqkftqRg8O84YQXpMDswL09C7R2Dn4cxOHeti+8aORNjDP6
 nJGw==
X-Gm-Message-State: APuU4Z8Ot1P/6kUDPet2ttXOXj/nRjsM5HTmcPETSgPj0KPXYylwtmno
 8w7sC14USSdqEhFLhsWI2UGqoahFY3ncMyTdikU5gFob7HcwQ8UWMfaB7PZ24wjR4gjF5r4m8BU
 OGog3We2qD6v2GaUAHvgQ58M8TbaWXVCtFkBAPoa0bxZt8xr/5PRPl9duDn6d/T52P2W1nQgXCv
 dJvZX8nE3heK4zrXSuXegLkhfHiQ8g
X-Received: from qvbiu1.prod.google.com ([2002:ad4:5cc1:0:b0:91e:a5c6:343])
 (user=rnwolfe job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:623:b0:91e:9a4e:8d8
 with SMTP id 6a1803df08f44-91f241c2d36mr201857106d6.26.1794924707855; Tue, 17
 Nov 2026 06:11:47 -0800 (PST)
Date: Tue, 17 Nov 2026 09:11:44 -0500
In-Reply-To: <cover.1794908231.git.rnwolfe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261115140016.3830109-1-rnwolfe@google.com>
 <cover.1794908231.git.rnwolfe@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <1690b58aa2e15b2235c49c5d3fc15bbbdb108054.1794908231.git.rnwolfe@google.com>
Subject: [PATCH v2 3/3] net/gve: fix GQI QPL jumbo Tx FIFO reclaim and doorbell
From: Ryan Wolfe <rnwolfe@google.com>
To: dev@dpdk.org, Junfeng Guo <junfeng.guo@intel.com>, 
 Joshua Washington <joshwash@google.com>
Cc: stable@dpdk.org, Harshitha Ramamurthy <hramamurthy@google.com>, 
 Rushil Gupta <rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 18 Nov 2026 10:20:02 +0100
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
frames into a fixed QPL bounce FIFO (for example 512 pages = 2 MiB, or
~236 8,832-byte cacheline-aligned jumbo frames) even when nb_tx_desc is
configured to 2048. Under sustained jumbo bursts three bugs cause
stalls, packet drops, and corrupted FIFO accounting:

1. Entry cleanup in gve_tx_burst_qpl() only ran when nb_free <
   free_thresh (32) or fifo_avail == 0. With 2048 descriptors, 236 jumbo
   frames leave nb_free = 1811 and non-zero remainder bytes in
   fifo_avail, so entry cleanup never ran. Reclaim when fifo_avail drops
   below half of fifo_size, and stop counting normal FIFO-full
   backpressure as stats.errors.
2. When is_fifo_avail() failed mid-burst after queuing frames, the
   driver polled gve_tx_clean() once before writing qtx_tail, so the
   device had not begun draining the queued frames, and one
   GVE_TX_MAX_FREE_SZ batch after small frames could stop short of a
   jumbo slot. Flush qtx_tail first and loop gve_tx_clean() while
   next_to_clean advances.
3. For TSO packets, the header FIFO slice was allocated before checking
   payload FIFO space (leaking header FIFO space on mid-packet abort),
   and a malformed TSO mbuf with pkt_len <= hlen jumped to end_of_tx
   without consuming the mbuf, stalling the queue indefinitely. Verify
   combined aligned header + payload space up front with a 32-bit length
   check, and free and count malformed TSO mbufs while tracking nb_sent
   separately from nb_tx.

Fixes: a46583cf43c8 ("net/gve: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Ryan Wolfe <rnwolfe@google.com>
---
 drivers/net/gve/gve_tx.c | 67 ++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/net/gve/gve_tx.c b/drivers/net/gve/gve_tx.c
index 14495e3851..bf778a86e6 100644
--- a/drivers/net/gve/gve_tx.c
+++ b/drivers/net/gve/gve_tx.c
@@ -201,7 +201,7 @@ gve_tx_fill_seg_desc(volatile union gve_tx_desc *desc, uint64_t ol_flags,
 }
 
 static inline bool
-is_fifo_avail(struct gve_tx_queue *txq, uint16_t len)
+is_fifo_avail(struct gve_tx_queue *txq, uint32_t len)
 {
 	if (txq->fifo_avail < len)
 		return false;
@@ -211,6 +211,27 @@ is_fifo_avail(struct gve_tx_queue *txq, uint16_t len)
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
+	for (;;) {
+		uint32_t prev_ntc = txq->next_to_clean;
+
+		gve_tx_clean(txq);
+		if (is_fifo_avail(txq, need))
+			return true;
+		if (txq->next_to_clean == prev_ntc)
+			return false;
+	}
+}
+
 static inline uint64_t
 gve_tx_alloc_from_fifo(struct gve_tx_queue *txq, uint16_t tx_id, uint16_t len)
 {
@@ -261,13 +282,15 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	uint16_t sw_id = txq->sw_tail;
 	uint64_t ol_flags, fifo_addr;
 	uint16_t nb_used, i;
+	uint16_t nb_sent = 0;
 	uint64_t bytes = 0;
 	uint16_t nb_tx = 0;
 	uint32_t hlen;
 
 	txr = txq->tx_desc_ring;
 
-	if (txq->nb_free < txq->free_thresh || txq->fifo_avail == 0)
+	if (txq->nb_free < txq->free_thresh ||
+	    txq->fifo_avail < (txq->fifo_size >> 1))
 		gve_tx_clean(txq);
 
 	if (txq->sw_nb_free < txq->free_thresh)
@@ -305,21 +328,25 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			(uint32_t)(tx_offload.l2_len + tx_offload.l3_len + tx_offload.l4_len) :
 			tx_pkt->pkt_len;
 
-		if (!is_fifo_avail(txq, hlen)) {
-			gve_tx_clean(txq);
-			if (!is_fifo_avail(txq, hlen))
-				goto end_of_tx;
-		}
-		fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id, hlen);
-
-		/* For TSO, check if there's enough fifo space for data first */
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
-			if (!is_fifo_avail(txq, tx_pkt->pkt_len - hlen)) {
-				gve_tx_clean(txq);
-				if (!is_fifo_avail(txq, tx_pkt->pkt_len - hlen))
-					goto end_of_tx;
+			uint32_t data_len, need;
+
+			if (unlikely(tx_pkt->pkt_len <= hlen)) {
+				rte_pktmbuf_free(tx_pkt);
+				txq->stats.errors++;
+				continue;
 			}
+			data_len = tx_pkt->pkt_len - hlen;
+			need = RTE_ALIGN(hlen, RTE_CACHE_LINE_SIZE) +
+			       RTE_ALIGN(data_len, RTE_CACHE_LINE_SIZE);
+			if (!is_fifo_avail(txq, need) &&
+			    !gve_tx_reclaim_fifo_qpl(txq, tx_tail, need))
+				goto end_of_tx;
+		} else if (!is_fifo_avail(txq, hlen) &&
+			   !gve_tx_reclaim_fifo_qpl(txq, tx_tail, hlen)) {
+			goto end_of_tx;
 		}
+		fifo_addr = gve_tx_alloc_from_fifo(txq, tx_id, hlen);
 
 		qpl_write_addr = (void *)(size_t)(fifo_addr + txq->fifo_base);
 		mbuf_header_addr = rte_pktmbuf_read(tx_pkt, 0, hlen, qpl_write_addr);
@@ -367,17 +394,19 @@ gve_tx_burst_qpl(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		tx_tail += nb_used;
 
 		bytes += first->pkt_len;
+		nb_sent++;
 	}
 
 end_of_tx:
-	if (nb_tx) {
-		rte_write32(rte_cpu_to_be_32(tx_tail), txq->qtx_tail);
-		txq->tx_tail = tx_tail;
+	if (nb_sent) {
+		if (txq->tx_tail != tx_tail) {
+			rte_write32(rte_cpu_to_be_32(tx_tail), txq->qtx_tail);
+			txq->tx_tail = tx_tail;
+		}
 		txq->sw_tail = sw_id;
 
-		txq->stats.packets += nb_tx;
+		txq->stats.packets += nb_sent;
 		txq->stats.bytes += bytes;
-		txq->stats.errors += nb_pkts - nb_tx;
 	}
 
 	return nb_tx;
