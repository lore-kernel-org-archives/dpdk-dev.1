Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDBBC982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C7F840E4C;
	Mon, 21 Sep 2026 04:56:03 +0200 (CEST)
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com
 [209.85.221.225])
 by mails.dpdk.org (Postfix) with ESMTP id 14BBC40E25
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:56:02 +0200 (CEST)
Received: by mail-vk1-f225.google.com with SMTP id
 71dfb90a1353d-5c83fbd23a5so2989892e0c.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959361; x=1790564161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dykp/xw4KqyFK+3ev0whsN1YXebgHdqIOkMt9dfyMyo=;
 b=zwZL9X6LuQO24V1BWNsxgbddp62minatdBcSDCq8IwBrFDN17CzI3TVDy+621p1WhG
 hzZjCa+IbJYk5PW7y1oZDsEZ+uuIZywmT238FgKF61QtCeIkWXVsyqFwUYDySQ6PZjG7
 EVze9Ffx88rYDAxEEimKfCQCG5JRiC/L2phorB0r5vUD+df0j8UlKbslizyeq4rKwIi0
 eNJk6tNlWcaxc0CyUpTkD5Aoe8ma6ycs9R59JKhNp4qtLG9a6ZACQ/zPot152Stk8zkr
 coFmUTe/8zvWbV9JI5t7tzYKNNgIG2b2Pd87aEeeCuIJDF4XyxjAQ0JRIiRENJhXSkzM
 lQJA==
X-Gm-Message-State: AFuF++kfhQJNfRPFWtE8Lzq+ZYVwhPAqRn1O96rZd7+EQks9YEAuLBkh
 6HgE4EQO3rze63MqG1txy2RzjfCdqZ/rgKQuyC21a/uy/7u7P5ndD87pAnXP4Y4vGsxCOb81Bni
 CJRDH8bArXjHonlFQme7j7DvTrYaz7OtEC+21bilq588JHlt9fLG40WaP8IHil2K1kQpsCtEXgf
 C8Ol/WNwcV3WKfVoD5F+OM8YRE5XZGl04pJvQLonaYF4zfIhcOBRLXhVPX815eelNN6yMVSv/LP
 oh3Tx4hUcBO
X-Gm-Gg: AYBFou3hMDs+qtNpP1TidRybeWsFIenxaU4uCP5YaYuvVQqUg1v1Tk8GWa8lcftf7tE
 I1P90yc18wnwpogBxMU7UH63SbXw3ojdAfqOcr8OfJCgHVZTRTi4enriNIhZfxIH56xKUSJoSN0
 OrGsme3RP/0kRbSiG9FGtNCb1/s2O8yyOMcJEPaD2P1ioIct9PU65cjXv6dxsbiEU2KFh7F4v7K
 LC3lnrOvpQ0PLCT34nniBJceluiN6N18XxHltyIU+GjmsBLJxnKaCGWFxznX4vtpbc4vTAiMBca
 8NvFQxIne8G8RZQmUkfoUtGp7aHmKL/oPLrKhvYCwwvJ8KvdHxBXhEbNhGEpCZhTaG7Dvph2a+T
 lTZcUPbstUxRARE0pVP9MEa2QJVjbY/yMR9M5faL34Sq0HeJBXmZWiek0jSnuIPqB1OjREE3PSc
 OTcjChIMZhWBVhhzYwDqxULMVpL3PmohLNUW6tmaNoXwvJ2AYwU+rF
X-Received: by 2002:a05:6122:88c:b0:5c8:38b8:44a0 with SMTP id
 71dfb90a1353d-5c9a57312dfmr4130484e0c.8.1789959361208; 
 Sun, 20 Sep 2026 19:56:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5c9c18fc744sm2104258e0c.8.2026.09.20.19.56.00
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:56:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1cade6b71so2440331a12.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959359; x=1790564159; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dykp/xw4KqyFK+3ev0whsN1YXebgHdqIOkMt9dfyMyo=;
 b=Motl1uLumeWz3fjA0ALr3fn6Jh1lknyWxeeEWTMGHE0XfGP3ilFpS/duVSkvG9E2kd
 QAat+U5pII+i7tY0nj3DwzqZhQN5IgEHPli7qaPD+QckFRmlrqvfB/rA0y0NruvxI6JZ
 rnQf119++zV5L3F3wOge8e0iyjDw+QixBljqU=
X-Received: by 2002:a05:6a20:b786:b0:3dd:a9a9:396d with SMTP id
 adf61e73a8af0-3dda9a93b82mr5025926637.49.1789959359181; 
 Sun, 20 Sep 2026 19:55:59 -0700 (PDT)
X-Received: by 2002:a05:6a20:b786:b0:3dd:a9a9:396d with SMTP id
 adf61e73a8af0-3dda9a93b82mr5025898637.49.1789959358388; 
 Sun, 20 Sep 2026 19:55:58 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3314313esm15687999eec.14.2026.09.20.19.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:55:57 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 Keegan Freyhof <keegan.freyhof@broadcom.com>
Subject: [PATCH v2] net/bnxt: add support for queue size of 16384
Date: Sun, 20 Sep 2026 20:59:03 -0600
Message-ID: <20260921025903.1034720-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Corrected the commit message's description of the completion-ring
  aggregation multiplier: it's 2x the Rx ring size, further multiplied
  by 4 when the aggregation ring is in use (8x total), not "4x with
  aggregation" as originally worded -- the 131072 figure was already
  right, just the arithmetic explanation wasn't.
* Added a comment on MAX_CP_DESC_CNT (bnxt_ring.h) noting it isn't
  used as an allocation bound anywhere in the driver -- the actual
  completion-ring size is computed dynamically from the Rx ring size
  and AGG_RING_SIZE_FACTOR in bnxt_init_rx_ring_struct(). A reviewer
  flagged the constant as potentially too small for the 131072-entry
  worst case; verified via grep that MAX_CP_DESC_CNT has no other
  reference in the driver, so it can't be gating anything.
* Added a release notes entry for the increased queue size limits.
* NOTE: apply this patch after "net/bnxt: add Tx DMA error stat
  counter" (v2) -- see that patch's v2 note; both touch the same
  release-notes bullet list.

 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/net/bnxt/bnxt.h                |  8 +++---
 drivers/net/bnxt/bnxt_ring.h           | 11 +++++---
 drivers/net/bnxt/bnxt_rxq.c           |  4 +--
 drivers/net/bnxt/bnxt_rxr.c           | 40 +++++++++++++--------------
 drivers/net/bnxt/bnxt_rxr.h           | 10 +++----
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c | 14 +++++-----
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c |  4 +--
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c  | 10 +++----
 9 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index abda472f379..7f9e517e401 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -60,6 +60,8 @@ New Features
   * Added a per-queue ``tx_dma_err_pkts`` xstat to report Tx completions
     that the device flagged with a DMA error. These are also folded into
     the standard ``oerrors`` counter.
+  * Raised the maximum Tx and Rx ring descriptor counts from 4096/8192 to
+    16384 each.
 
 
 Removed Items
diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..d2c3e0ffac 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -91,8 +91,8 @@
 /* Minimum spec version that supports AUTONEG_PAUSE bit in auto_pause field */
 #define HWRM_SPEC_CODE_AUTONEG_PAUSE	0x10201
 
-#define BNXT_MAX_MTU		9574
-#define BNXT_NUM_VLANS		2
+#define BNXT_MAX_MTU		9574UL
+#define BNXT_NUM_VLANS		2UL
 #define BNXT_MAX_PKT_LEN	(BNXT_MAX_MTU + RTE_ETHER_HDR_LEN +\
 				 RTE_ETHER_CRC_LEN +\
 				 (BNXT_NUM_VLANS * RTE_VLAN_HLEN))
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
index 496c3e111f..eaa4ec66c1 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -32,9 +32,14 @@
 #define AGG_RING_MULTIPLIER	2
 
 /* These assume 4k pages */
-#define MAX_RX_DESC_CNT (8 * 1024)
-#define MAX_TX_DESC_CNT (4 * 1024)
-#define MAX_CP_DESC_CNT (16 * 1024)
+#define MAX_RX_DESC_CNT (16 * 1024)
+#define MAX_TX_DESC_CNT (16 * 1024)
+/* Not used as a bound; actual CP ring size is computed dynamically in
+ * bnxt_init_rx_ring_struct()/bnxt_alloc_hwrm_rx_ring() from the Rx ring
+ * size and AGG_RING_SIZE_FACTOR, up to 131072 for a 16384-entry Rx ring
+ * with aggregation.
+ */
+#define MAX_CP_DESC_CNT (32 * 1024)
 
 #define INVALID_HW_RING_ID      ((uint16_t)-1)
 #define INVALID_STATS_CTX_ID	((uint16_t)-1)
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 023cb0e174..1dae97a695 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -210,7 +210,7 @@ void bnxt_rx_queue_release_mbufs(struct bnxt_rx_queue *rxq)
 {
 	struct rte_mbuf **sw_ring;
 	struct bnxt_tpa_info *tpa_info;
-	uint16_t i;
+	uint32_t i;
 
 	if (!rxq || !rxq->rx_ring)
 		return;
@@ -259,7 +259,7 @@ void bnxt_rx_queue_release_mbufs(struct bnxt_rx_queue *rxq)
 	/* Free up mbufs in TPA */
 	tpa_info = rxq->rx_ring->tpa_info;
 	if (tpa_info) {
-		int max_aggs = BNXT_TPA_MAX_AGGS(rxq->bp);
+		uint32_t max_aggs = BNXT_TPA_MAX_AGGS(rxq->bp);
 
 		for (i = 0; i < max_aggs; i++) {
 			if (tpa_info[i].mbuf) {
diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 0fab4ddf78..b260ba9bef 100644
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
@@ -104,7 +104,7 @@ static inline int bnxt_alloc_ag_data(struct bnxt_rx_queue *rxq,
 static inline void bnxt_reuse_rx_mbuf(struct bnxt_rx_ring_info *rxr,
 			       struct rte_mbuf *mbuf)
 {
-	uint16_t prod, raw_prod = RING_NEXT(rxr->rx_raw_prod);
+	uint32_t prod, raw_prod = RING_NEXT(rxr->rx_raw_prod);
 	struct rte_mbuf **prod_rx_buf;
 	struct rx_prod_pkt_bd *prod_bd;
 
@@ -125,7 +125,7 @@ static inline void bnxt_reuse_rx_mbuf(struct bnxt_rx_ring_info *rxr,
 
 static inline
 struct rte_mbuf *bnxt_consume_rx_buf(struct bnxt_rx_ring_info *rxr,
-				     uint16_t cons)
+				     uint32_t cons)
 {
 	struct rte_mbuf **cons_rx_buf;
 	struct rte_mbuf *mbuf;
@@ -297,7 +297,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 static int bnxt_agg_bufs_valid(struct bnxt_cp_ring_info *cpr,
 		uint8_t agg_bufs, uint32_t raw_cp_cons)
 {
-	uint16_t last_cp_cons;
+	uint32_t last_cp_cons;
 	struct rx_pkt_cmpl *agg_cmpl;
 
 	raw_cp_cons = ADV_RAW_CMP(raw_cp_cons, agg_bufs);
@@ -311,8 +311,8 @@ static int bnxt_agg_bufs_valid(struct bnxt_cp_ring_info *cpr,
 static int bnxt_prod_ag_mbuf(struct bnxt_rx_queue *rxq)
 {
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t raw_next = RING_NEXT(rxr->ag_raw_prod);
-	uint16_t bmap_next = RING_IDX(rxr->ag_ring_struct, raw_next);
+	uint32_t raw_next = RING_NEXT(rxr->ag_raw_prod);
+	uint32_t bmap_next = RING_IDX(rxr->ag_ring_struct, raw_next);
 
 	/* TODO batch allocation for better performance */
 	while (rte_bitmap_get(rxr->ag_bitmap, bmap_next)) {
@@ -334,7 +334,7 @@ static int bnxt_rx_pages(struct bnxt_rx_queue *rxq,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	int i;
-	uint16_t cp_cons, ag_cons;
+	uint32_t cp_cons, ag_cons;
 	struct rx_pkt_cmpl *rxcmp;
 	struct rte_mbuf *last = mbuf;
 	bool is_p5_tpa = tpa_info && BNXT_CHIP_P5_P7(rxq->bp);
@@ -1003,7 +1003,7 @@ static int bnxt_rx_pages_crx(struct bnxt_rx_queue *rxq, struct rte_mbuf *mbuf,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	int i;
-	uint16_t cp_cons, ag_cons;
+	uint32_t cp_cons, ag_cons;
 	struct rx_pkt_compress_cmpl *rxcmp;
 	struct rte_mbuf *last = mbuf;
 
@@ -1058,7 +1058,7 @@ static int bnxt_crx_pkt(struct rte_mbuf **rx_pkt,
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	uint32_t tmp_raw_cons = *raw_cons;
-	uint16_t cons, raw_prod;
+	uint32_t cons, raw_prod;
 	struct rte_mbuf *mbuf;
 	int rc = 0;
 	uint8_t agg_buf = 0;
@@ -1119,12 +1119,12 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
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
 
@@ -1343,7 +1343,7 @@ static void bnxt_reattempt_buffer_alloc(struct bnxt_rx_queue *rxq)
 {
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
 	struct bnxt_ring *ring;
-	uint16_t raw_prod;
+	uint32_t raw_prod;
 	uint32_t cnt;
 
 	/* Assume alloc passes. On failure,
@@ -1363,7 +1363,7 @@ static void bnxt_reattempt_buffer_alloc(struct bnxt_rx_queue *rxq)
 	ring = rxr->rx_ring_struct;
 	for (cnt = 0; cnt < ring->ring_size; cnt++) {
 		struct rte_mbuf **rx_buf;
-		uint16_t ndx;
+		uint32_t ndx;
 
 		ndx = RING_IDX(ring, raw_prod + cnt);
 		rx_buf = &rxr->rx_buf_ring[ndx];
@@ -1387,8 +1387,8 @@ uint16_t bnxt_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
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
@@ -1627,7 +1627,7 @@ int bnxt_init_rx_ring_struct(struct bnxt_rx_queue *rxq, unsigned int socket_id)
 }
 
 static void bnxt_init_rxbds(struct bnxt_ring *ring, uint32_t type,
-			    uint16_t len)
+			    uint32_t len)
 {
 	uint32_t j;
 	struct rx_prod_pkt_bd *rx_bd_ring = (struct rx_prod_pkt_bd *)ring->bd;
@@ -1647,7 +1647,7 @@ int bnxt_init_one_rx_ring(struct bnxt_rx_queue *rxq)
 	struct bnxt_ring *ring;
 	uint32_t raw_prod, type;
 	unsigned int i;
-	uint16_t size;
+	uint32_t size;
 
 	/* Initialize packet type table. */
 	bnxt_init_ptype_table();
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
index 50b3602839..9eca5a519f 100644
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
@@ -891,7 +891,7 @@ bnxt_xmit_pkts_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 	int nb_sent = 0;
 	struct bnxt_tx_queue *txq = tx_queue;
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
-	uint16_t ring_size = txr->tx_ring_struct->ring_size;
+	uint32_t ring_size = txr->tx_ring_struct->ring_size;
 
 	/* Tx queue was stopped; wait for it to be restarted */
 	if (unlikely(!txq->tx_started)) {
@@ -942,8 +942,8 @@ recv_burst_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
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
index 03f39280e5..f015caa018 100644
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
index 7d455b6f56..b03affb9ec 100644
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
@@ -677,7 +677,7 @@ bnxt_xmit_pkts_vec(void *tx_queue, struct rte_mbuf **tx_pkts,
 	int nb_sent = 0;
 	struct bnxt_tx_queue *txq = tx_queue;
 	struct bnxt_tx_ring_info *txr = txq->tx_ring;
-	uint16_t ring_size = txr->tx_ring_struct->ring_size;
+	uint32_t ring_size = txr->tx_ring_struct->ring_size;
 
 	/* Tx queue was stopped; wait for it to be restarted */
 	if (unlikely(!txq->tx_started)) {
-- 
2.47.3
 
