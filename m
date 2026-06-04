Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A712CD6E55
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 03:17:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 06A7440615;
	Thu,  4 Jun 2026 05:17:09 +0200 (CEST)
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com
 [209.85.222.99]) by mails.dpdk.org (Postfix) with ESMTP id C96DC402E1
 for <dev@dpdk.org>; Thu,  4 Jun 2026 05:17:07 +0200 (CEST)
Received: by mail-ua1-f99.google.com with SMTP id
 a1e0cc1a2514c-963a722ed59so71167241.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780543027; x=1781147827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/zk/9oEaLJk5jjmYTt2ZCO5Ky16QoKJ6H55sjvYEMo=;
 b=bbN3yz8/Zps36ejT2YukYCOY3GHEuz3fAQTjo64akAL5Q2LqtpwDBAJ7CAd56uhiBz
 +CewZCZ6U5TNNKZ9Zt6njzBD1B8K2+ucsS8Lm7RlofpwogKDdXmATG2mFUgMDCnVGP9G
 vuCeK45LLuv4D3RRZVTPIb1JOOzGpXV4mta64cZ+S9Dws/fUJVXRWvN2pHI9UHfPg9Tu
 DEi8MSNRcd6E2w6TsplDZZw4DA8V6j1xjcUH8YUfIi/VMoa9E+vHBH56HYEO/3kk0Rlh
 7x2bxamNiSjjkBJ+Z6wGRfnKwZ5BZG6u9YpoXVkLP6FEYUEZ1ibOMND1MMqQsgDKBWDy
 hTbQ==
X-Gm-Message-State: AOJu0YwBXVlkM112T6woEYkG5l0QRUarRYs5Ux8eOU5ls6R8yNu+cpv/
 6sZSIkEryX2S6RU2Iyk/CVw4+bIZKFHZ0Mt2doQ3St304LdHBze/u1HU2cZfXqho8fcybQwFz38
 ag0CVnQSuZhA0Lln0jZhx7t6rpRCTN7otSP+6iy+vxLjJoloEFY2HQjtrf5QkX3JKOJuupykqfq
 HkbFrQHzrueElt7pVBMo+jMFPScuYdEMY4nxrsEP+VT9fK3jy5LKD8JpvnQ0Nd6DejY/rpuPX9r
 Avn1BuS+1UJ
X-Gm-Gg: Acq92OHIKomyE1NozXIeXczzvBU5eSIt3JsohvYAk98KgPDa4qBFXLBwRspVKILbtdt
 SQV+7UCpHww+5CIy0o3OopS1ySFqEAlvCHfAEEbVIAXEy2IO1p47NRKa4p1KTb1odlTc6Xmp3uk
 6qX8kFx8UtQpB8Op1gPMXRIcnzZFOQRLIXwTxfKE2rUOk03sl/RJ5Bt/iFNrXhs4I/CBcyYE05c
 UtA/dMmqKe9B8HiLacILEW46ZmT7H0JNVzR9qXV8w9suD+FkuTTilqFVAQ/QUW6wK3IMVOYF1pK
 SZfouCSz2tvNKBsRwPuAMEqWsN55IQQD3oDCH8z7Fj+Rih5XRNvg+XLG6lHp+VxWuY0QVV8vv/u
 2DCN7/Tb+Y3/tHoZjOMw9jKz4onRFZ5gBzo08P3p4eGL7ud1VaB+0y+HZbYj0oWCJdreZ11aM5Y
 CWtve+WI+kKq7/46bT0Vl4iVaR7ttKrQ==
X-Received: by 2002:a05:6102:f0f:b0:6d3:9409:d1bb with SMTP id
 ada2fe7eead31-6ec4590799cmr3596054137.19.1780543027018; 
 Wed, 03 Jun 2026 20:17:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-6eb64300dc4sm326339137.17.2026.06.03.20.17.06
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jun 2026 20:17:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91577337648so23461585a.1
 for <dev@dpdk.org>; Wed, 03 Jun 2026 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780543026; x=1781147826; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/zk/9oEaLJk5jjmYTt2ZCO5Ky16QoKJ6H55sjvYEMo=;
 b=YS59iSgFDlV5d5JKv1s/MAIsEHGMKOFdLe9wryiwDh3FtFKJluurHSki0/BOfrRCgx
 M+C3MkEFjB4T8A+vdwJaNYYjGIjZnPGxo99PAx6KbIANzWstiKzDNi5hKP6Kd3kYPcrz
 jGHFqsMxqZHTdvmt8jcBFXFK11KgEDYElsoCI=
X-Received: by 2002:a05:620a:4409:b0:915:776d:5307 with SMTP id
 af79cd13be357-9158a860a74mr1007087185a.62.1780543025764; 
 Wed, 03 Jun 2026 20:17:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:915:776d:5307 with SMTP id
 af79cd13be357-9158a860a74mr1007082485a.62.1780543025072; 
 Wed, 03 Jun 2026 20:17:05 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a009fe7sm446421685a.8.2026.06.03.20.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 20:17:04 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Keegan Freyhof <keegan.freyhof@broadcom.com>,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 02/10] net/bnxt: stale values in nr_bds are cleared
Date: Wed,  3 Jun 2026 21:18:43 -0600
Message-ID: <20260604031851.2267548-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260604031851.2267548-1-Mohammad-Shuab.Siddique@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

Fixed an issue where the stale value held in txr->nr_bds[0]
would get read when the ring loops back around and cause
the tx producer to get behind the tx consumer position.
This then causes the driver to think that there were no
available buffers.

Fixes: 925cd0705836 ("net/bnxt: update PTP support on Thor")
Cc: stable@dpdk.org
Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_txr.c | 136 ++++++++++++++++++++++++++++++++++--
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index d37a38735c..45d1a93fdc 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -511,11 +511,48 @@ static int bnxt_start_xmit(struct rte_mbuf *tx_pkt,
 	return rc;
 }
 
+static void bnxt_tx_coal_cmp_fast(struct bnxt_tx_queue *txq, int nr_cons)
+{
+	struct bnxt_tx_ring_info *txr = txq->tx_ring;
+	struct bnxt_ring *ring = txr->tx_ring_struct;
+	struct rte_mbuf **free = txq->free;
+	uint16_t raw_cons = txr->tx_raw_cons;
+	unsigned int blk = 0;
+	int cons, bds;
+
+	for (cons = 0; cons < nr_cons; cons++) {
+		struct rte_mbuf **tx_buf;
+		unsigned short nr_bds;
+
+		tx_buf = &txr->tx_buf_ring[RING_IDX(ring, raw_cons)];
+		nr_bds = (*tx_buf)->nb_segs +
+			 bnxt_xmit_need_long_bd(*tx_buf, txq);
+		for (bds = 0; bds < nr_bds; bds++) {
+			if (*tx_buf) {
+				free[blk++] = *tx_buf;
+				/*
+				 * Each BD also tracks a consumer index.
+				 * Update cons, otherwise it will fall behind.
+				 */
+				cons++;
+				*tx_buf = NULL;
+			}
+			raw_cons = RING_NEXT(raw_cons);
+			tx_buf = &txr->tx_buf_ring[RING_IDX(ring, raw_cons)];
+		}
+	}
+	if (blk)
+		rte_mempool_put_bulk(free[0]->pool, (void *)free, blk);
+
+	txr->tx_raw_cons = raw_cons;
+}
+
 /*
  * Transmit completion function for use when RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE
  * is enabled.
  */
-static void bnxt_tx_cmp_fast(struct bnxt_tx_queue *txq, int nr_pkts)
+static void bnxt_tx_cmp_fast(struct bnxt_tx_queue *txq, int nb_tx,
+			      bool tx_coal_cmp)
 {
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
 	struct bnxt_ring *ring = txr->tx_ring_struct;
@@ -524,7 +561,10 @@ static void bnxt_tx_cmp_fast(struct bnxt_tx_queue *txq, int nr_pkts)
 	unsigned int blk = 0;
 	int i, j;
 
-	for (i = 0; i < nr_pkts; i++) {
+	if (tx_coal_cmp)
+		return bnxt_tx_coal_cmp_fast(txq, nb_tx);
+
+	for (i = 0; i < nb_tx; i++) {
 		struct rte_mbuf **tx_buf;
 		unsigned short nr_bds;
 
@@ -547,7 +587,72 @@ static void bnxt_tx_cmp_fast(struct bnxt_tx_queue *txq, int nr_pkts)
 	txr->tx_raw_cons = raw_cons;
 }
 
-static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nr_pkts)
+static void bnxt_tx_coal_cmp(struct bnxt_tx_queue *txq, int nr_cons)
+{
+	struct bnxt_tx_ring_info *txr = txq->tx_ring;
+	struct bnxt_ring *ring = txr->tx_ring_struct;
+	struct rte_mempool *pool = NULL;
+	struct rte_mbuf **free = txq->free;
+	uint16_t raw_cons = txr->tx_raw_cons;
+	unsigned int blk = 0;
+	int cons, bds;
+
+	for (cons = 0; cons < nr_cons; cons++) {
+		struct rte_mbuf *mbuf;
+		struct rte_mbuf **tx_buf;
+		unsigned short nr_bds;
+
+		tx_buf = &txr->tx_buf_ring[RING_IDX(ring, raw_cons)];
+		nr_bds = txr->nr_bds[RING_IDX(ring, raw_cons)];
+		/* Clear the now stale number of buffer descriptors */
+		txr->nr_bds[RING_IDX(ring, raw_cons)] = 0;
+
+		for (bds = 0; bds < nr_bds; bds++) {
+			mbuf = *tx_buf;
+			*tx_buf = NULL;
+			raw_cons = RING_NEXT(raw_cons);
+			/*
+			 * Each BD also tracks a consumer index. So update the cons.
+			 * Otherwise the cons will fall behind.
+			 */
+			cons++;
+			tx_buf = &txr->tx_buf_ring[RING_IDX(ring, raw_cons)];
+			if (!mbuf)	/* long_bd's tx_buf ? */
+				continue;
+
+			mbuf = rte_pktmbuf_prefree_seg(mbuf);
+			if (unlikely(!mbuf))
+				continue;
+
+			/* EW - no need to unmap DMA memory? */
+
+			if (likely(mbuf->pool == pool)) {
+				/* Add mbuf to the bulk free array */
+				free[blk++] = mbuf;
+			} else {
+				/* Found an mbuf from a different pool. Free
+				 * mbufs accumulated so far to the previous
+				 * pool
+				 */
+				if (likely(pool != NULL))
+					rte_mempool_put_bulk(pool,
+							     (void *)free,
+							     blk);
+
+				/* Start accumulating mbufs in a new pool */
+				free[0] = mbuf;
+				pool = mbuf->pool;
+				blk = 1;
+			}
+		}
+	}
+	if (blk)
+		rte_mempool_put_bulk(pool, (void *)free, blk);
+
+	txr->tx_raw_cons = raw_cons;
+}
+
+static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nb_tx, bool tx_coal_cmp)
 {
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
 	struct bnxt_ring *ring = txr->tx_ring_struct;
@@ -557,13 +662,19 @@ static void bnxt_tx_cmp(struct bnxt_tx_queue *txq, int nr_pkts)
 	unsigned int blk = 0;
 	int i, j;
 
-	for (i = 0; i < nr_pkts; i++) {
+	if (tx_coal_cmp)
+		return bnxt_tx_coal_cmp(txq, nb_tx);
+
+	for (i = 0; i < nb_tx; i++) {
 		struct rte_mbuf *mbuf;
 		struct rte_mbuf **tx_buf;
 		unsigned short nr_bds;
 
 		tx_buf = &txr->tx_buf_ring[RING_IDX(ring, raw_cons)];
 		nr_bds = txr->nr_bds[RING_IDX(ring, raw_cons)];
+		/* Clear the now stale number of buffer descriptors */
+		txr->nr_bds[RING_IDX(ring, raw_cons)] = 0;
+
 		for (j = 0; j < nr_bds; j++) {
 			mbuf = *tx_buf;
 			*tx_buf = NULL;
@@ -631,6 +742,8 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 	struct bnxt_cp_ring_info *cpr = txq->cp_ring;
 	uint32_t raw_cons = cpr->cp_raw_cons;
 	struct bnxt_ring *cp_ring_struct;
+	uint32_t tx_ring_mask;
+	bool tx_coal_cmp = false;
 	struct tx_cmpl *txcmp;
 
 	if (bnxt_tx_bds_in_hw(txq) < txq->tx_free_thresh)
@@ -638,6 +751,7 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 
 	cp_ring_struct = cpr->cp_ring_struct;
 	ring_mask = cp_ring_struct->ring_mask;
+	tx_ring_mask = txq->tx_ring->tx_ring_struct->ring_mask;
 
 	do {
 		cons = RING_CMPL(ring_mask, raw_cons);
@@ -646,6 +760,16 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
+			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
+
+			nb_tx_pkts = (rte_le_to_cpu_32(txcmp_c->sq_cons_idx) -
+				      (txq->tx_ring->tx_raw_cons & tx_ring_mask)) & tx_ring_mask;
+			raw_cons = NEXT_RAW_CMP(raw_cons);
+			tx_coal_cmp = true;
+			break;
+		}
+
 		opaque = rte_le_to_cpu_32(txcmp->opaque);
 
 		if (bnxt_is_tx_cmpl_type(CMP_TYPE(txcmp)))
@@ -661,9 +785,9 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 
 	if (nb_tx_pkts) {
 		if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
-			bnxt_tx_cmp_fast(txq, nb_tx_pkts);
+			bnxt_tx_cmp_fast(txq, nb_tx_pkts, tx_coal_cmp);
 		else
-			bnxt_tx_cmp(txq, nb_tx_pkts);
+			bnxt_tx_cmp(txq, nb_tx_pkts, tx_coal_cmp);
 		cpr->cp_raw_cons = raw_cons;
 		bnxt_db_cq(cpr);
 	}
-- 
2.47.3

