Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8196CA5FAE
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 112A9410E6;
	Tue, 29 Sep 2026 02:21:49 +0200 (CEST)
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98]) by mails.dpdk.org (Postfix) with ESMTP id 42F8E41060
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:21:47 +0200 (CEST)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-6753c665bdeso292637d50.0
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641306; x=1791246106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mZHf7ZhxnGsF7h0VTbDczfYRKTV0GMe8XOXWn6VHdOs=;
 b=Ix+cQy9H8z1cYCzysoW8E20E5SHRAa4ceRNpoyg67yNW6IWqMlVHPRXacYEEu4Nqw3
 UebnSNFUXKvkNO+VyYhMqwGf3vk552wAvADBunjaXYsn403YsqRTFF2yFR3L+dj2Xwl3
 Vb0PhLXkWWSh2ei4pA937zMC1C0lFCNDBTrYOmgA0v/4PjepKyN+wB80N2y/nWAOLZig
 Nez4zyG8xczn0juu4UsMCyOMMvxyKZ9AyG1+qgHKEQo7ckeVwhDNy0NdoKQyfmlp5FED
 srd3eXltpJlrueTakgZfvz3AY6oOZPKK2I7JetAnyA73loWW0Qg5juyTDlRE9GTkAG0M
 U33w==
X-Gm-Message-State: AFq9FYIurJQfvTO3vGC5QxocxVRLEqKVN/R+MlbV2sP0OCxccMI753/1
 8g1JpEFmHvmApn91lgHicqpuL9m30lijRR/Z5eXojnaJCWsvmGLDyNZ/i5bwDLu6AA6bw0Lv6OP
 BP3USA+SAYUGfwWuwgCeQiXZy0iWSfdy3hQ/bKdBM0xhexfclWd3Q9wdazJmmJkhrdKtOvybAFZ
 5i3BJ1BjQ4NWBuYh82d9HJ+RpU5D9JH4IQ0vr5/gwczfjtyvxs9z1EioPA6oJ33iNRuCdLalv1n
 qte1d1fkJRL
X-Gm-Gg: AYBFou1sxBT37YvJtGXNSHNihB/r97rLfr9z65MQ9UxIiZoye4GfmM2QfHKrhBblxo/
 z4mKpdYmR+9AHXg8VVcL+t7Uw8ZTfal+sh96Bl3hbSBaBi31TjWAUmjzFoQe9AbIm9Rr1HHNPtg
 go/xxFH+DEGn90ziVqRTeqr8rtxf0bNkRvEb+XaOnAHnsojQvcRGgca34nbg2XYgU9w7xoTMbcY
 JWGcxv+L1FGvDeVE7QqkDPkSp3plntfC4cEkiRSuN13KSu9YwH+i01Vf2/ive4cjLt0qY7t1aGk
 QWrbJ8zcX0uarmuyMcSgiEcuI08M39GgaBbAjrYUOfKoIbGZd0csh0kHRrggbWCUBgVi/1jKzYK
 tPQvVsh/QBLASqHGY13Kdhmfbm6B7AZ0JFYZ88JY+yArf3Q2jesgoy1zeulbGro2seBRilUbK2X
 vkAPHrtctesOeQcOxO6Exfd9i1EbjYvh9N6TkzeLSuOyowvsjSGw==
X-Received: by 2002:a05:690e:b87:b0:674:1248:2b88 with SMTP id
 956f58d0204a3-674124834e0mr4403329d50.6.1790641306460; 
 Mon, 28 Sep 2026 17:21:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-6740eea8343sm1669381d50.7.2026.09.28.17.21.45
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:21:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5c205127so416591785a.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641305; x=1791246105; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mZHf7ZhxnGsF7h0VTbDczfYRKTV0GMe8XOXWn6VHdOs=;
 b=CPi8OdDdN1r2QJWcYQd5TaDpOG66pUfhl3pHP5ZnraayUo+GA+D9euFZDN1U1OmSB6
 J6DY4CgsGih9jcV6o4iEvOM+1O04I1U+FI7JmEjDrUbgeNdusC91x7A21kRH7pI3rlD+
 mue+jqSE15g0lJk+GXN2fQE5bwldeTb1Dh7FY=
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id
 af79cd13be357-93c43cd656emr2383488385a.41.1790641304909; 
 Mon, 28 Sep 2026 17:21:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2686:b0:93c:208:3d9b with SMTP id
 af79cd13be357-93c43cd656emr2383484185a.41.1790641304388; 
 Mon, 28 Sep 2026 17:21:44 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e0f78csm91234246d6.32.2026.09.28.17.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:21:43 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>,
 stable@dpdk.org
Subject: [PATCH v3 2/5] net/bnxt: validate TPA aggregation ID from completions
Date: Mon, 28 Sep 2026 18:24:39 -0600
Message-ID: <20260929002442.1208481-3-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032752.763408-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260929002442.1208481-1-Mohammad-Shuab.Siddique@broadcom.com>
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
rte_le_to_cpu_16() when reading the device field. On the legacy
(non-Thor) TPA end path, also discard the pending agg bufs before
returning on an invalid agg_id, matching the existing in_reset early
return a few lines above; otherwise those agg buf completions are
left unconsumed and the CQ raw_cons goes out of sync with the ring
even after the scheduled reset.

Fixes: 0958d8b6435d ("net/bnxt: support LRO")
Fixes: b150a7e7ee66 ("net/bnxt: support LRO on Thor adapters")
Cc: stable@dpdk.org

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_rxr.c | 48 ++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_rxr.c b/drivers/net/bnxt/bnxt_rxr.c
index 98bdbc136a..1790ce839f 100644
--- a/drivers/net/bnxt/bnxt_rxr.c
+++ b/drivers/net/bnxt/bnxt_rxr.c
@@ -227,12 +227,19 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
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
@@ -259,7 +266,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 	mbuf->port = rxq->port_id;
 	mbuf->ol_flags = RTE_MBUF_F_RX_LRO;
 
-	bnxt_tpa_get_metadata(rxq->bp, tpa_info, tpa_start, tpa_start1);
+	bnxt_tpa_get_metadata(bp, tpa_info, tpa_start, tpa_start1);
 
 	if (likely(tpa_info->hash_valid)) {
 		mbuf->hash.rss = tpa_info->rss_hash;
@@ -269,7 +276,7 @@ static void bnxt_tpa_start(struct bnxt_rx_queue *rxq,
 		mbuf->ol_flags |= RTE_MBUF_F_RX_FDIR | RTE_MBUF_F_RX_FDIR_ID;
 	}
 
-	if (tpa_info->vlan_valid && BNXT_RX_VLAN_STRIP_EN(rxq->bp)) {
+	if (tpa_info->vlan_valid && BNXT_RX_VLAN_STRIP_EN(bp)) {
 		mbuf->vlan_tci = tpa_info->vlan;
 		mbuf->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 	}
@@ -412,20 +419,21 @@ static inline struct rte_mbuf *bnxt_tpa_end(
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
 
@@ -442,6 +450,15 @@ static inline struct rte_mbuf *bnxt_tpa_end(
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
@@ -1126,9 +1143,18 @@ static int bnxt_rx_pkt(struct rte_mbuf **rx_pkt,
 
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

