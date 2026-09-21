Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCC4C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:21:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9821040E4C;
	Mon, 21 Sep 2026 04:21:25 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 486C440E17
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:21:22 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-39b35105ba4so2486709a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957281; x=1790562081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5KAjOjfR1+3MRv5MOj2NCQQURLJjrL5o96iSeMtXRaY=;
 b=Tx2+s90pZq9b0hOWH7M+5ExRkDcx/vjU4WZIV5kFq86wNE+GvUJ1iGIHzwYUw6rZCx
 SbrhwDqWs/Rh79hYJN1f+1fLD56lVrsOUDOZQ9Dd677ui6JpTV+GJrhY7fPx8XOA8Xdh
 o90C0ks/sIjy5Lunt49+phHlBvHD4JqO9Uk8+zkEyQaGVXKUEJ1LlR0/KeiYlb5wS6o2
 +eaXKojpglzxOUGwUGKpJqKICZ+ZRWhE7gjVwBfzbkXf5Rwvr3yW4HIqOGlThS8lPlBy
 008CDNfiVPyhQ5Vm3xCoe66htPcqAeCZDjkpObIp5LTfP6zvPgu+oQyETaRcXqXf1yLH
 jhZA==
X-Gm-Message-State: AFuF++m7DTbHYTj5wlp6hKTbuYqjsAlB5Lz962FLWCi+ISIwo9afxkmF
 4ioxAgWS5OaU+f1bRB2LVqnnBp0f8I67lAHU+rRu8CwTE2F9kGfV9Xz4IHwm+YKTaaaAAiZ/xVO
 /9dGHJZDwhyvKe/AdqtDQm5LOdajQ1fst5VPC3S7OjS3OSOL0zz53QIaMd5UY3ilZOCGp1ahzX8
 MdZuDegpq3lRJnrMkIEHgh9lCN0cqiRPkCai65pCf5IkPHuAy3mp47d1mO8IHMN9fzcMzJ/TCjP
 GhrQeqQGlWm
X-Gm-Gg: AYBFou0l6dOZMwXjE29SGbPC7uYDxZnOC7HDOdoF9tzPuSVA6QW0N1L1KwX4qs2SdAK
 OXS3XPQlXWGfmdf2ckKsoIrPoH2jnTPTqVnnae2jhig3rYQKrMPv655azpMl0pcb7996rvW0XoL
 ucNpwZ6FrTGzPz6D8llfEvkv5A5EjHgKi/S9QZ/UH0gv/uHtIOInY+8MOM5NmmuYXfsWbJ2pteW
 2dQ/2Zcm4dhrpLqcJRnAiQjlI+EgGrWXXU/Svu4bXQ6to0bRacAMoCihkkRsQKvHRHfS6SlB0Yv
 MISgk5jswUEFqPjxDGAj4JfFAVSGkF9k/HxtwC0QzrKfrqRGiPmU/CagK58Pbaw6SyiBCC4Q+wr
 4a7XD8qLRFNTgwI7bsaD/LFd2oVJ0h8yus76BgYMZFn//rqPjuD3NvOWMLUSBT4mtCzD6HR288F
 uLVfpP6pDIKe346/tYhsw6tr5b9T0Hmbm/R8gONn88DAsqASeRKw==
X-Received: by 2002:a17:90b:3b8d:b0:39e:4c7e:f03d with SMTP id
 98e67ed59e1d1-39e54f0e5e7mr13546229a91.26.1789957281298; 
 Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a031a512fasm2888719a91.8.2026.09.20.19.21.20
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:21:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso4665271a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957280; x=1790562080; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5KAjOjfR1+3MRv5MOj2NCQQURLJjrL5o96iSeMtXRaY=;
 b=hHyCBuO1R0e/64y86IbLGxovK9jc+g0FCpwmjGiuITAAOdTT/xEHqzW58CFprpiKNd
 PF6yxaKFuWsFCZVqJ5W+EvBj8JTDJQu0BXAazx2/AZRHbU/W/oYPW1BT7j9xzEGFlIVN
 t6IccwuXfFyRUU+JrfZ6VgpvOU/qk8e5+jggs=
X-Received: by 2002:a17:90b:2743:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39e54cadd7amr14740198a91.2.1789957279686; 
 Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2743:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39e54cadd7amr14740161a91.2.1789957279051; 
 Sun, 20 Sep 2026 19:21:19 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d53968afsm16587294c88.0.2026.09.20.19.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:21:18 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v2 2/5] net/bnxt: fix bounds on TPA aggregation ID from
 completions
Date: Sun, 20 Sep 2026 20:24:17 -0600
Message-ID: <20260921022420.1034071-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022420.1034071-1-Mohammad-Shuab.Siddique@broadcom.com>
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

TPA start/end and TPA v2 abuf paths indexed rxr->tpa_info[] using
the aggregation ID from the completion without checking
BNXT_TPA_MAX_AGGS. Add bounds checks and schedule a ring reset on
failure. Also fix abuf aggregation ID decode to use
rte_le_to_cpu_16() when reading the device field.

Fixes: 0958d8b6435d ("net/bnxt: support LRO")
Fixes: b150a7e7ee66 ("net/bnxt: support LRO on Thor adapters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Real bug found during v2 review: on the legacy (non-Thor) TPA end
  path, the new agg_id bounds-check-failure branch returned without
  draining the pending aggregation-buffer completions, unlike the
  sibling in_reset early return a few lines above it -- this would
  leave the CQ raw_cons out of sync with the ring even after the
  scheduled reset. Added the same bnxt_discard_rx() call the sibling
  path already uses.

 drivers/net/bnxt/bnxt_rxr.c | 48 ++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 0fab4ddf78..87640eaa79 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -236,12 +236,19 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 			   struct rx_tpa_start_cmpl_hi *tpa_start1)
 {
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t agg_id;
-	uint16_t data_cons;
 	struct bnxt_tpa_info *tpa_info;
+	uint32_t data_cons, agg_id;
+	struct bnxt *bp = rxq->bp;
 	struct rte_mbuf *mbuf;
 
-	agg_id = bnxt_tpa_start_agg_id(rxq->bp, tpa_start);
+	agg_id = bnxt_tpa_start_agg_id(bp, tpa_start);
+	if (unlikely(agg_id >= BNXT_TPA_MAX_AGGS(bp))) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "TPA start: invalid agg_id %u (max %u)",
+				 agg_id, BNXT_TPA_MAX_AGGS(bp));
+		bnxt_sched_ring_reset(rxq);
+		return;
+	}
 
 	data_cons = tpa_start->opaque;
 	tpa_info = &rxr->tpa_info[agg_id];
@@ -268,7 +275,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 	mbuf->port = rxq->port_id;
 	mbuf->ol_flags = RTE_MBUF_F_RX_LRO;
 
-	bnxt_tpa_get_metadata(rxq->bp, tpa_info, tpa_start, tpa_start1);
+	bnxt_tpa_get_metadata(bp, tpa_info, tpa_start, tpa_start1);
 
 	if (likely(tpa_info->hash_valid)) {
 		mbuf->hash.rss = tpa_info->rss_hash;
@@ -278,7 +285,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 		mbuf->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 	}
 
-	if (tpa_info->vlan_valid && BNXT_RX_VLAN_STRIP_EN(rxq->bp)) {
+	if (tpa_info->vlan_valid && BNXT_RX_VLAN_STRIP_EN(bp)) {
 		mbuf->vlan_tci = tpa_info->vlan;
 		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
@@ -421,20 +428,21 @@ static inline struct rte_mbuf *bnxt_tpa_end(
 {
 	struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 	struct bnxt_rx_ring_info *rxr = rxq->rx_ring;
-	uint16_t agg_id;
+	struct bnxt_tpa_info *tpa_info;
+	struct bnxt *bp = rxq->bp;
+	uint8_t payload_offset;
 	struct rte_mbuf *mbuf;
 	uint8_t agg_bufs;
-	uint8_t payload_offset;
-	struct bnxt_tpa_info *tpa_info;
+	uint32_t agg_id;
 
 	if (unlikely(rxq->in_reset)) {
 		PMD_DRV_LOG_LINE(ERR, "rxq->in_reset: raw_cp_cons:%d",
 			    *raw_cp_cons);
-		bnxt_discard_rx(rxq->bp, cpr, raw_cp_cons, tpa_end);
+		bnxt_discard_rx(bp, cpr, raw_cp_cons, tpa_end);
 		return NULL;
 	}
 
-	if (BNXT_CHIP_P5_P7(rxq->bp)) {
+	if (BNXT_CHIP_P5_P7(bp)) {
 		struct rx_tpa_v2_end_cmpl *th_tpa_end;
 		struct rx_tpa_v2_end_cmpl_hi *th_tpa_end1;
 
@@ -451,6 +459,15 @@ static inline struct rte_mbuf *bnxt_tpa_end(
 		payload_offset = tpa_end->payload_offset;
 	}

+	if (unlikely(agg_id >= BNXT_TPA_MAX_AGGS(bp))) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "TPA end: invalid agg_id %u (max %u)",
+				 agg_id, BNXT_TPA_MAX_AGGS(bp));
+		bnxt_discard_rx(bp, cpr, raw_cp_cons, tpa_end);
+		bnxt_sched_ring_reset(rxq);
+		return NULL;
+	}
+
 	tpa_info = &rxr->tpa_info[agg_id];
 	mbuf = tpa_info->mbuf;
 	RTE_ASSERT(mbuf != NULL);
@@ -1135,9 +1152,18 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 
 	if (cmp_type == RX_TPA_V2_ABUF_CMPL_TYPE_RX_TPA_AGG) {
 		struct rx_tpa_v2_abuf_cmpl *rx_agg = (void *)rxcmp;
-		uint16_t agg_id = rte_cpu_to_le_16(rx_agg->agg_id);
+		uint32_t agg_id = rte_le_to_cpu_16(rx_agg->agg_id);
 		struct bnxt_tpa_info *tpa_info;
 
+		if (unlikely(agg_id >= BNXT_TPA_MAX_AGGS(bp))) {
+			PMD_DRV_LOG_LINE(ERR,
+					 "TPA abuf: invalid agg_id %u (max %u)",
+					 agg_id, BNXT_TPA_MAX_AGGS(bp));
+			bnxt_sched_ring_reset(rxq);
+			rc = -EINVAL;
+			goto next_rx;
+		}
+
 		tpa_info = &rxr->tpa_info[agg_id];
 		RTE_ASSERT(tpa_info->agg_count < 16);
 		tpa_info->agg_arr[tpa_info->agg_count++] = *rx_agg;
-- 
2.47.3

