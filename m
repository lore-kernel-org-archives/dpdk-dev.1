Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D0C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 341DB4329A;
	Fri, 18 Sep 2026 05:24:53 +0200 (CEST)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTP id B240840262
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:24:51 +0200 (CEST)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so116552a91.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701891; x=1790306691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+MrwHhQPWSIwTikMJ2vNaZctcuGJlqikaj5kMZgErrI=;
 b=GoYrrgu7gXQAnw8M9/6YRnzTiQd+H5Hu8QST5IfpHwPLADuPtHywC0lnu+AJ1iswPr
 yxCmgP4jYsiLWcgK8/lMgJDHiGDpnOfs0aWAbVJXDRYSAD9+bDC5ZCizHTfNO3CMADjo
 lujgZJPWmamiw7GhN3dBgC3zBeiNlTk5fZW/N6r2PpCmhSyQ8lJ3xBYJVk8YRtd0lP3y
 jCwfvwAN2yKoTQavUt/ezamrX4zJBHqItqxtBI/fNTsmLguSTDcPFEwJg/PMLv7ASZ8I
 PP9txb4+7Lh3spoPh++mW9HjFjy8G1SkWJIvyxcri0Vxfp0m9/EwrpHP9uUUOMWCGhqG
 6nEQ==
X-Gm-Message-State: AFuF++nd2UvlPixggLcA3NdrOPHix5n+Wr8XUPG5JzTvbLIA9lCNtCHu
 UKfPHus06/s204DYJagNCcooQK13T8WEYtLMl6ERs7f2DN3dxRFtIjwmOnerQHmwQ4fg+bePnkC
 Ie6vzejvBU4gVoxWAjsOL3whaeCxSWpc9jxoyc8OBTUe85wKNh4j3WWs4xsppSVxse0hFoa7sMR
 +wTUYcu1rMNV55ov90j8zLZrsKW9Sh15uMUxD9SGqAA2SKBeyWlwOxCxIvUjww1WARRWARK8VNb
 0ynRqIFTTnQ
X-Gm-Gg: AYBFou0fZhHpHBkWVexgQNQ4FhT9PMH/VuNupGZMsiv1j+6eUd85TxDOLRvxoOg2WMa
 XU8NHzHhnKajRhaxGGZL+JlS16toK9Y1SeuT5hs6htqPCn1jXtqkv1heyq24NONXw9vqJhfUUXK
 5NvYbOBl4cd2wmj6Qt2n2VvjPCMaepi2x4lWMds7pGLF4SQE8Kbw2SA3+043XOK0B+HeKNoya/W
 qbi30zhCQYkX+rKlJ38fsxdUpw5sI6mvZRqKlaZ+iebZBp+OSASDyMDLa/4TkejOxUcnPDe7tEi
 mPw7aBj9tYeSMHKRxaUz4zSszrQbhC9eneoGDKelOnC6Gs5lBRPaeUbzcw6AP3S7hNCjgZ5GhWw
 6DUqLPky2ampwONgIXrmLK5Pr5iA1M3Wp6oj8zNnhxR2XcNjKTb+XxDinzoWcZYM465YYBNeAaE
 ZYTi9ikPb9EoS1PsO7EhV+U/owcv9FnIJygTA7vhuSV56U6g0NiQ==
X-Received: by 2002:a17:90b:2d50:b0:39e:288:80c9 with SMTP id
 98e67ed59e1d1-39e54f9d274mr2522162a91.19.1789701890687; 
 Thu, 17 Sep 2026 20:24:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-98.dlp.protect.broadcom.com. [144.49.247.98])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-39e5a546553sm279093a91.7.2026.09.17.20.24.49
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:24:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso234294a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701889; x=1790306689; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+MrwHhQPWSIwTikMJ2vNaZctcuGJlqikaj5kMZgErrI=;
 b=W5u1Q5oSKAFQ/4YIEB/IAYpuYa0I4Sr2wDWb5I+suFG9FjCkOjBeL1077TD6SVeXiY
 FXo+WalUJ8FD5RKc7hG+CCbQPp7I2Ez6PwLy0Zalx0WYHhgZUqf7U6NLjYl5iSnxpd8a
 3UWeokKKiUdhysRQI5ZRyzK3uI4saUlAJKgNQ=
X-Received: by 2002:a05:6a20:7349:b0:3dd:85a9:55a3 with SMTP id
 adf61e73a8af0-3dd8c5d3b64mr2384427637.37.1789701888670; 
 Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
X-Received: by 2002:a05:6a20:7349:b0:3dd:85a9:55a3 with SMTP id
 adf61e73a8af0-3dd8c5d3b64mr2384383637.37.1789701888137; 
 Thu, 17 Sep 2026 20:24:48 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286d98c6sm537742eec.5.2026.09.17.20.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:24:47 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH 2/5] net/bnxt: fix bounds on TPA aggregation ID from
 completions
Date: Thu, 17 Sep 2026 21:27:49 -0600
Message-ID: <20260918032752.763408-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Fixes: 0958d8b6435 ("net/bnxt: support LRO")
Fixes: b150a7e7ee6 ("net/bnxt: support LRO on Thor adapters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 47 ++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 11 deletions(-)

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
 
@@ -451,6 +459,14 @@ static inline struct rte_mbuf *bnxt_tpa_end(
 		payload_offset = tpa_end->payload_offset;
 	}
 
+	if (unlikely(agg_id >= BNXT_TPA_MAX_AGGS(bp))) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "TPA end: invalid agg_id %u (max %u)",
+				 agg_id, BNXT_TPA_MAX_AGGS(bp));
+		bnxt_sched_ring_reset(rxq);
+		return NULL;
+	}
+
 	tpa_info = &rxr->tpa_info[agg_id];
 	mbuf = tpa_info->mbuf;
 	RTE_ASSERT(mbuf != NULL);
@@ -1135,9 +1151,18 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 
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

