Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EFECA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:20:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7885040DDA;
	Tue, 29 Sep 2026 02:20:22 +0200 (CEST)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id 4B14040DDA
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:20:21 +0200 (CEST)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-884062f32fdso517535b3a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641220; x=1791246020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LfkSXZQbEZ5kac7NAUrhioaQ1/aO9rS186IdaXT1fmk=;
 b=WoVxEv52SLxxwGCPT7ljZfBVy+ADhGdEARvpshqyWCfrlgFGqiTkFau1rRrTxh2W/1
 XX4n74wUDhjx6H5qhxd9nPeI9ERnK2r+aHv8Onnxmw+X8W7LY2t04NhqtIm6dc4yci//
 2id2pyb6XhvGDgVCpsJLv+ds0QJNwMBovvgafCfl2Wf8gBpeSxxEyXYuHGgoRxdRRMc8
 kgfXU8MKtTB375yr84bMbrgBT1T3hBr0jnSybLQgc2jB12DBf4fNUxbp2zwdWS52w1T5
 2NIgCxNHnXPYc6/epBUSnlkPI8SVGswNxZxm/OjbdkOvsVrWyF6ye8RrBgw4zp3EA4Pe
 9qyQ==
X-Gm-Message-State: AFuF++kztKIN1Hla3NPnEU2aWAsJPRYpIIdblBqWyl2jTpdsQ60Ck4nZ
 s7GfULEaRhLQOfHfswEliLeRVf/Ki5LS9ynvu7+c+ffwfwtJ8QL3R5rLCIgH2UoC+A1MAQFFRRP
 BuPV+OTo8VIFcinukF+jfwyOQxkDuJf+ZUVqMx4kiJO9dviyD6eGkEB0/gSIWBKIQGwdSuxrOeo
 3AzRgi1zF+a/90SE3HNKstbKhQYrh/r/Q/MC4+xFEeSF8Z7zyaR8tJioSPNzNZOVq5sS2jvYyzh
 HuDioHOc4Zl
X-Gm-Gg: AYBFou0WMNzkJX/84YcIxgTKt1Uw3O2BktOTbEccb7F0uIelsJ4Q7UhIIY1iTSkZY0y
 amBKwKC16T+TOlbdyZUH3AT6PqCc0xSb2L1S+FWd8wl4PUZsdvcO2zRUdmCD/f6F3oDhteLzj+g
 M+KAgbtYY1tSZqWPrD6ygXETzM46ZRJJMOSgzPmbhcnEYhI2fkDJ9PAuLoxsSFYESQDYLDRHkUF
 Yt3zO2xpaQBIjXelS1AJMLDelhIPq5XaOTyu8EpaCNSy1FQPA29NSDgsmMxjcGRGnqkISVbzJFj
 zG/fSt9IX/nNo9EvsFMcUVR4mmWdqrk404wBvwqPw+9CE8wUZXPRL5VNLt4WcbeqtKT0eJFm7zM
 T5BBj2oYjq7VhFAA6SBhpJtM4uAU/Ffp5Pknlyb1mv5RyueW/c7TpqFYD7qBMTo01LK0DwDniGF
 8zheHVGyBjEKJK+/vfzspr9fBu+3ldzIhGqJlR2gn7EtN5gnyHPoj/
X-Received: by 2002:a05:6a20:d527:b0:3de:4275:69ff with SMTP id
 adf61e73a8af0-3de427570e1mr7092729637.7.1790641220000; 
 Mon, 28 Sep 2026 17:20:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-cc7877ddf15sm7167647a12.11.2026.09.28.17.20.19
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:20:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5328dae1305so51111471cf.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641219; x=1791246019; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LfkSXZQbEZ5kac7NAUrhioaQ1/aO9rS186IdaXT1fmk=;
 b=ISB7zKgGf6jRhDIWFVuyU3YEfosfe3dBHH6xeZjY3lh3oWxJawsahuA2/1k8dgbVT8
 nM78x4pxbkUa8Rdahb7z+7YQly5leglMxw9tpN/+/Q87W6YwInyLLEcZoysxANLI/K/L
 IGhxYOFbvi1gAGYlFUwHc3/ivw71F1FiPnOfY=
X-Received: by 2002:ac8:5756:0:b0:531:218f:f340 with SMTP id
 d75a77b69052e-5330b5b98d9mr256929371cf.19.1790641218646; 
 Mon, 28 Sep 2026 17:20:18 -0700 (PDT)
X-Received: by 2002:ac8:5756:0:b0:531:218f:f340 with SMTP id
 d75a77b69052e-5330b5b98d9mr256928941cf.19.1790641217910; 
 Mon, 28 Sep 2026 17:20:17 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e281a8sm91754846d6.33.2026.09.28.17.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:20:16 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Keegan Freyhof <keegan.freyhof@broadcom.com>
Subject: [PATCH v3] net/bnxt: add support for queue size of 16384
Date: Mon, 28 Sep 2026 18:22:42 -0600
Message-ID: <20260929002242.1208372-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032825.763449-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032825.763449-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

The driver only supported queue sizes up to 4096 for Tx and 8192 for
Rx. Raise both to 16384. The completion ring for a Rx ring is sized
at 2x the Rx ring size, further multiplied by 4 when the aggregation
ring is in use (8x total), so at 16384 it can reach 131072, above
uint16_t range - widen the ring index/counter variables touched by
that path to uint32_t.

bnxt_init_one_rx_ring()'s widened size local (now uint32_t) is
compared against BNXT_MAX_PKT_LEN via RTE_MIN(); cast the macro's
value to uint32_t at that one call site rather than widening
BNXT_MAX_MTU/BNXT_NUM_VLANS themselves, since those macros are used
elsewhere too and are unrelated to this change.

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Dropped the BNXT_MAX_MTU/BNXT_NUM_VLANS UL-suffix change -- Stephen
  Hemminger asked to drop the unrelated MTU/VLAN type changes. Fixed
  the real -Wsign-compare warning that motivated it with a local
  (uint32_t) cast at the one RTE_MIN() call site touched by this
  patch instead of widening the two shared macros.
* Deleted MAX_CP_DESC_CNT outright rather than leaving it with an
  explanatory comment -- confirmed via grep it has no reference
  anywhere in the driver; the actual completion-ring size is computed
  dynamically from the Rx ring size and AGG_RING_SIZE_FACTOR.
v2:
* Corrected the commit message's description of the completion-ring
  aggregation multiplier: it's 2x the Rx ring size, further
  multiplied by 4 when the aggregation ring is in use (8x total), not
  "4x with aggregation" as originally worded -- the 131072 figure was
  already right, just the arithmetic explanation wasn't.
* Added a release notes entry for the increased queue size limits.

 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/bnxt/bnxt.h                |  4 +--
 drivers/net/bnxt/bnxt_ring.h           |  5 ++-
 drivers/net/bnxt/bnxt_rxq.c            |  4 +--
 drivers/net/bnxt/bnxt_rxr.c            | 42 +++++++++++++-------------
 drivers/net/bnxt/bnxt_rxr.h            | 10 +++---
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c  | 14 ++++-----
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c  |  4 +--
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c   | 10 +++---
 9 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 7ab289adf1..87941f57dd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -79,6 +79,8 @@ New Features
   * Added a ``tx_dma_err_cmpl`` xstat to report Tx completions that the
     device flagged with a DMA error. This is a port-level counter, and
     is also folded into the standard ``oerrors`` counter.
+  * Raised the maximum Tx and Rx ring descriptor counts from 4096/8192 to
+    16384 each.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..f1eaa9c6a8 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -105,8 +105,8 @@
 #define BNXT_VF_RSV_NUM_VNIC	1
 #define BNXT_MAX_LED		4
 #define BNXT_MIN_RING_DESC	16
-#define BNXT_MAX_TX_RING_DESC	4096
-#define BNXT_MAX_RX_RING_DESC	8192
+#define BNXT_MAX_TX_RING_DESC	16384
+#define BNXT_MAX_RX_RING_DESC	16384
 #define BNXT_DB_SIZE		0x80
 
 #define TPA_MAX_AGGS		64
diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index 496c3e111f..d710d85371 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -32,9 +32,8 @@
 #define AGG_RING_MULTIPLIER	2
 
 /* These assume 4k pages */
-#define MAX_RX_DESC_CNT (8 * 1024)
-#define MAX_TX_DESC_CNT (4 * 1024)
-#define MAX_CP_DESC_CNT (16 * 1024)
+#define MAX_RX_DESC_CNT (16 * 1024)
+#define MAX_TX_DESC_CNT (16 * 1024)
 
 #define INVALID_HW_RING_ID      ((uint16_t)-1)
 #define INVALID_STATS_CTX_ID	((uint16_t)-1)
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index ea3cdffbc0..7fee3c26c6 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -205,7 +205,7 @@ void bnxt_rx_queue_release_mbufs(struct bnxt_rx_queue *rxq)
 {
 	struct rte_mbuf **sw_ring;
 	struct bnxt_tpa_info *tpa_info;
-	uint16_t i;
+	uint32_t i;
 
 	if (!rxq || !rxq->rx_ring)
 		return;
@@ -254,7 +254,7 @@ void bnxt_rx_queue_release_mbufs(struct bnxt_rx_queue *rxq)
 	/* Free up mbufs in TPA */
 	tpa_info = rxq->rx_ring->tpa_info;
 	if (tpa_info) {
-		int max_aggs = BNXT_TPA_MAX_AGGS(rxq->bp);
+		uint32_t max_aggs = BNXT_TPA_MAX_AGGS(rxq->bp);
 
 		for (i = 0; i < max_aggs; i++) {
 			if (tpa_info[i].mbuf) {
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 98bdbc136a..66b5db761b 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -37,9 +37,9 @@ static inline struct rte_mbuf *__bnxt_alloc_rx_data(struct rte_mempool *mb)
 
 static inline int bnxt_alloc_rx_data(struct bnxt_rx_queue *rxq,
 				     struct bnxt_rx_ring_info *rxr,
-				     uint16_t raw_prod)
+				     uint32_t raw_prod)
 {
-	uint16_t prod = RING_IDX(rxr->rx_ring_struct, raw_prod);
+	uint32_t prod = RING_IDX(rxr->rx_ring_struct, raw_prod);
 	struct rx_prod_pkt_bd *rxbd;
 	struct rte_mbuf **rx_buf;
 	struct rte_mbuf *mbuf;
@@ -65,9 +65,9 @@ static inline int bnxt_alloc_rx_data(struct bnxt_rx_queue *rxq,
 
 static inline int bnxt_alloc_ag_data(struct bnxt_rx_queue *rxq,
 				     struct bnxt_rx_ring_info *rxr,
-				     uint16_t raw_prod)
+				     uint32_t raw_prod)
 {
-	uint16_t prod = RING_IDX(rxr->ag_ring_struct, raw_prod);
+	uint32_t prod = RING_IDX(rxr->ag_ring_struct, raw_prod);
 	struct rx_prod_pkt_bd *rxbd;
 	struct rte_mbuf **rx_buf;
 	struct rte_mbuf *mbuf;
@@ -95,7 +95,7 @@ static inline int bnxt_alloc_ag_data(struct bnxt_rx_queue *rxq,
 static inline void bnxt_reuse_rx_mbuf(struct bnxt_rx_ring_info *rxr,
 			       struct rte_mbuf *mbuf)
 {
-	uint16_t prod, raw_prod = RING_NEXT(rxr->rx_raw_prod);
+	uint32_t prod, raw_prod = RING_NEXT(rxr->rx_raw_prod);
 	struct rte_mbuf **prod_rx_buf;
 	struct rx_prod_pkt_bd *prod_bd;
 
@@ -116,7 +116,7 @@ static inline void bnxt_reuse_rx_mbuf(struct bnxt_rx_ring_info *rxr,
 
 static inline
 struct rte_mbuf *bnxt_consume_rx_buf(struct bnxt_rx_ring_info *rxr,
-				     uint16_t cons)
+				     uint32_t cons)
 {
 	struct rte_mbuf **cons_rx_buf;
 	struct rte_mbuf *mbuf;
@@ -288,7 +288,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 static int bnxt_agg_bufs_valid(struct bnxt_cp_ring_info *cpr,
 		uint8_t agg_bufs, uint32_t raw_cp_cons)
 {
-	uint16_t last_cp_cons;
+	uint32_t last_cp_cons;
 	struct rx_pkt_cmpl *agg_cmpl;
 
 	raw_cp_cons = ADV_RAW_CMP(raw_cp_cons, agg_bufs);
@@ -302,8 +302,8 @@ static int bnxt_agg_bufs_valid(struct bnxt_cp_ring_info *cpr,
 static int bnxt_prod_ag_mbuf(struct bnxt_rx_queue *rxq)
 {
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t raw_next = RING_NEXT(rxr->ag_raw_prod);
-	uint16_t bmap_next = RING_IDX(rxr->ag_ring_struct, raw_next);
+	uint32_t raw_next = RING_NEXT(rxr->ag_raw_prod);
+	uint32_t bmap_next = RING_IDX(rxr->ag_ring_struct, raw_next);
 
 	/* TODO batch allocation for better performance */
 	while (rte_bitmap_get(rxr->ag_bitmap, bmap_next)) {
@@ -325,7 +325,7 @@ static int bnxt_rx_pages(struct bnxt_rx_queue *rxq,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	int i;
-	uint16_t cp_cons, ag_cons;
+	uint32_t cp_cons, ag_cons;
 	struct rx_pkt_cmpl *rxcmp;
 	struct rte_mbuf *last = mbuf;
 	bool is_p5_tpa = tpa_info && BNXT_CHIP_P5_P7(rxq->bp);
@@ -994,7 +994,7 @@ static int bnxt_rx_pages_crx(struct bnxt_rx_queue *rxq, struct rte_mbuf *mbuf,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	int i;
-	uint16_t cp_cons, ag_cons;
+	uint32_t cp_cons, ag_cons;
 	struct rx_pkt_compress_cmpl *rxcmp;
 	struct rte_mbuf *last = mbuf;
 
@@ -1049,7 +1049,7 @@ static int bnxt_crx_pkt(struct rte_mbuf **rx_pkt,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	uint32_t tmp_raw_cons = *raw_cons;
-	uint16_t cons, raw_prod;
+	uint32_t cons, raw_prod;
 	struct rte_mbuf *mbuf;
 	int rc = 0;
 	uint8_t agg_buf = 0;
@@ -1110,12 +1110,12 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 	struct rx_pkt_cmpl *rxcmp;
 	struct rx_pkt_cmpl_hi *rxcmp1;
 	uint32_t tmp_raw_cons = *raw_cons;
-	uint16_t cons, raw_prod, cp_cons =
+	uint32_t cons, raw_prod, cp_cons =
 	    RING_CMP(cpr->cp_ring_struct, tmp_raw_cons);
 	struct rte_mbuf *mbuf;
 	int rc = 0;
 	uint8_t agg_buf = 0;
-	uint16_t cmp_type;
+	uint32_t cmp_type;
 	uint32_t vfr_flag = 0, mark_id = 0;
 	struct bnxt *bp = rxq->bp;
 
@@ -1334,7 +1334,7 @@ static void bnxt_reattempt_buffer_alloc(struct bnxt_rx_queue *rxq)
 {
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	struct bnxt_ring *ring;
-	uint16_t raw_prod;
+	uint32_t raw_prod;
 	uint32_t cnt;
 
 	/* Assume alloc passes. On failure,
@@ -1354,7 +1354,7 @@ static void bnxt_reattempt_buffer_alloc(struct bnxt_rx_queue *rxq)
 	ring = rxr->rx_ring_struct;
 	for (cnt = 0; cnt < ring->ring_size; cnt++) {
 		struct rte_mbuf **rx_buf;
-		uint16_t ndx;
+		uint32_t ndx;
 
 		ndx = RING_IDX(ring, raw_prod + cnt);
 		rx_buf = &rxr->rx_buf_ring[ndx];
@@ -1378,8 +1378,8 @@ uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	struct bnxt_rx_queue *rxq = rx_queue;
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t rx_raw_prod = rxr->rx_raw_prod;
-	uint16_t ag_raw_prod = rxr->ag_raw_prod;
+	uint32_t rx_raw_prod = rxr->rx_raw_prod;
+	uint32_t ag_raw_prod = rxr->ag_raw_prod;
 	uint32_t raw_cons = cpr->cp_raw_cons;
 	uint32_t cons;
 	int nb_rx_pkts = 0;
@@ -1618,7 +1618,7 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 }
 
 static void bnxt_init_rxbds(struct bnxt_ring *ring, uint32_t type,
-			    uint16_t len)
+			    uint32_t len)
 {
 	uint32_t j;
 	struct rx_prod_pkt_bd *rx_bd_ring = (struct rx_prod_pkt_bd *)ring->bd;
@@ -1638,13 +1638,13 @@ int bnxt_init_one_rx_ring(struct bnxt_rx_queue *rxq)
 	struct bnxt_ring *ring;
 	uint32_t raw_prod, type;
 	unsigned int i;
-	uint16_t size;
+	uint32_t size;
 
 	/* Initialize packet type table. */
 	bnxt_init_ptype_table();
 
 	size = rte_pktmbuf_data_room_size(rxq->mb_pool) - RTE_PKTMBUF_HEADROOM;
-	size = RTE_MIN(BNXT_MAX_PKT_LEN, size);
+	size = RTE_MIN((uint32_t)BNXT_MAX_PKT_LEN, size);
 
 	type = RX_PROD_PKT_BD_TYPE_RX_PROD_PKT;
 
diff --git a/drivers/net/bnxt/bnxt_rxr.h b/drivers/net/bnxt/bnxt_rxr.h
index c971233dc3..c82f44f041 100644
--- a/drivers/net/bnxt/bnxt_rxr.h
+++ b/drivers/net/bnxt/bnxt_rxr.h
@@ -114,11 +114,11 @@ struct bnxt_tpa_info {
 };
 
 struct bnxt_rx_ring_info {
-	uint16_t		rx_raw_prod;
-	uint16_t		ag_raw_prod;
-	uint16_t		ag_cons; /* Needed with compressed CQE */
-	uint16_t                rx_cons; /* Needed for representor */
-	uint16_t                rx_next_cons;
+	uint32_t		rx_raw_prod;
+	uint32_t		ag_raw_prod;
+	uint32_t		ag_cons; /* Needed with compressed CQE */
+	uint32_t                rx_cons; /* Needed for representor */
+	uint32_t                rx_next_cons;
 	struct bnxt_db_info     rx_db;
 	struct bnxt_db_info     ag_db;
 
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index b22bb16fa0..80074a56c4 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -27,8 +27,8 @@ recv_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
 	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
@@ -393,8 +393,8 @@ crx_burst_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
 	const __m256i info3_v_mask = _mm256_set1_epi32(CMPL_BASE_V);
@@ -899,7 +899,7 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	int nb_sent = 0;
 	struct bnxt_tx_queue *txq = tx_queue;
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
-	uint16_t ring_size = txr->tx_ring_struct->ring_size;
+	uint32_t ring_size = txr->tx_ring_struct->ring_size;
 
 	/* Tx queue was stopped; wait for it to be restarted */
 	if (unlikely(!txq->tx_started)) {
@@ -950,8 +950,8 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 		_mm256_set_epi64x(0, 0, 0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
 	uint32_t raw_cons = cpr->cp_raw_cons;
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
index 086ba43363..aa2c5e26e6 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -164,8 +164,8 @@ recv_burst_vec_neon(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	struct bnxt_rx_queue *rxq = rx_queue;
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0UL;
 	const uint32x4_t info3_v_mask = vdupq_n_u32(CMPL_BASE_V);
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 4024a80b51..5ac1809ad7 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -253,8 +253,8 @@ recv_burst_vec_sse(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
 	const __m128i info3_v_mask = _mm_set1_epi32(CMPL_BASE_V);
@@ -393,8 +393,8 @@ crx_burst_vec_sse(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 	const __m128i mbuf_init = _mm_set_epi64x(0, rxq->mbuf_initializer);
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t cp_ring_size = cpr->cp_ring_struct->ring_size;
-	uint16_t rx_ring_size = rxr->rx_ring_struct->ring_size;
+	uint32_t cp_ring_size = cpr->cp_ring_struct->ring_size;
+	uint32_t rx_ring_size = rxr->rx_ring_struct->ring_size;
 	struct cmpl_base *cp_desc_ring = cpr->cp_desc_ring;
 	uint64_t valid, desc_valid_mask = ~0ULL;
 	const __m128i info3_v_mask = _mm_set1_epi32(CMPL_BASE_V);
@@ -685,7 +685,7 @@ bnxt_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	int nb_sent = 0;
 	struct bnxt_tx_queue *txq = tx_queue;
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
-	uint16_t ring_size = txr->tx_ring_struct->ring_size;
+	uint32_t ring_size = txr->tx_ring_struct->ring_size;
 
 	/* Tx queue was stopped; wait for it to be restarted */
 	if (unlikely(!txq->tx_started)) {
-- 
2.47.3

