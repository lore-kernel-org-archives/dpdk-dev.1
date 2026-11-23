Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F2606A321
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KCcbR/uH
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30C3E4064C;
	Mon, 23 Nov 2026 22:15:27 +0100 (CET)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98])
 by mails.dpdk.org (Postfix) with ESMTPS id 7284E4027E
 for <dev@dpdk.org>; Mon, 23 Nov 2026 22:15:24 +0100 (CET)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-98fea7e52b7so2361356241.0
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795468523; x=1796073323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0TaVL3vxm0McNMZQbhbBKxyeEZGtrfbt3ctNBI4QlU=;
 b=m83eeWpUAzHZnzd4yoZn6ZWEPVAzOBHZhpiNuAsianLlWmJLUQbREM2l4Q2B8WPK2P
 DdFYuWBv1bbDGOVN5tUpdMPzCRwsSkYgnpxFV6ew3CQnTGYE9GzqvFx2R7xlIAwMl4kz
 akmdOLKH08vqdPNktB/hK035qMzugPcLoXOHgQShM1whmdPhptlkoTesynqZd929p/uO
 L1iVqLxPMg5glEyYFNu/lGm5I0Ruitta0IA0jS4vqSa9B77J6KttmOsypWEIx6as3k9g
 WXVewrlqRyiqhaZS67vYK9HfRkJuoztPUwKXSQzyvXTbnMjmL2CB18qalbaecyY0T34S
 IHOg==
X-Gm-Message-State: APuU4Z//Tl2Flq6uSPrNDlMOVssICUzzvd/KTmMc2VzVyuDEl/rLY93v
 G2XFgG2CqSyqjgLF1Yv2YmVAzzIys4VyUZfU1feP8J1LNRFPpcMgUhxF8tVBAhcMky2NkkIEnX8
 AlrkiynDYHfWj5DV4HRpEyLeCM8UA84yhyw7UbhAIqNlZIfTBR1w0r0LzHPwD8f4SIdd36553pU
 ZShjcD3fVu4chIYkEuc2eQvl9FzV+76re18AWNluEdzuAoOnHkDCoqFvyNGjEa8ztSZZ/s90jjE
 UaPjCm/FDUL
X-Gm-Gg: AZFdTZdAbrzWM11hE9o7D+HMxTuRPFVeM0svZQw9zgN8nIqLLxydoVZJmILXv3pDhiA
 by9+8I9o8Cbopf6SrcrG8PXJFLQUj1K02S6CT3L66KEGuGydYZlXTzTTtc8zSOQ51oxNs1HLAst
 W4TJ3bLzbp+2/9n3DVvc9xQvdS4kzWylgBnh9bY/7S+fxM9svBIGKPdi4Q9naEDo3tQB0YbTOrk
 pWaVbsWlUO2bKXWVg5dBiU8aNGCY1H68iKz0lDfV5whY2du2mZccDhjz3AIDbLTcjgGO1cg75o3
 n8AuqEO7DV5+4IlqHPsscIXYLOUFHjrZGSNyG/bDmgCwYNL5a4KdianttS9FUdpqA9HDGyOdkwy
 5FqePsLnc6B6juNEzCFHv0LzTGXWtqnfXskX3C4UFTLmeRdIMEwZeeFXPf3kjCnqtQpz9VS8UN0
 QC31St5YOPS8K/JmiRZteaxbNYvfBacGkh5TdpUCvYm99NbqzFp050
X-Received: by 2002:a05:6102:32d0:b0:7cc:2712:caf2 with SMTP id
 ada2fe7eead31-7d73944716bmr7306725137.23.1795468522947; 
 Mon, 23 Nov 2026 13:15:22 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-99e6e0fa957sm1341952241.3.2026.11.23.13.15.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Nov 2026 13:15:22 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3854627c1c8so5589018eec.1
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795468522; x=1796073322; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0TaVL3vxm0McNMZQbhbBKxyeEZGtrfbt3ctNBI4QlU=;
 b=KCcbR/uHphRfucPp2zCri7ztcoA89QBi62dWoSbAcdk4ttK0/4P5U5gM1FOoPAYoyb
 AiykgRj7+vRIqsEVPKIOMozKvZO57t2pe7iV+FKRGKaQ1rroFSuWjMcESD+177vwausk
 XldUWY+iJszbgo/mo4nMHyV9dqD0BVPizWFMs=
X-Received: by 2002:a05:701b:4555:20b0:1b5:2988:eba7 with SMTP id
 a92af1059eb24-1b556947286mr13269131c88.41.1795468520901; 
 Mon, 23 Nov 2026 13:15:20 -0800 (PST)
X-Received: by 2002:a05:701b:4555:20b0:1b5:2988:eba7 with SMTP id
 a92af1059eb24-1b556947286mr13269087c88.41.1795468519636; 
 Mon, 23 Nov 2026 13:15:19 -0800 (PST)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5566c1142sm29495218c88.2.2026.11.23.13.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 13:15:19 -0800 (PST)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Keegan Freyhof <keegan.freyhof@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH 1/2] net/bnxt: harden ring stats against flipped bits
Date: Mon, 23 Nov 2026 14:19:26 -0700
Message-ID: <20261123211927.261389-2-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123211927.261389-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261123211927.261389-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keegan Freyhof <keegan.freyhof@broadcom.com>

When ring statistics are polled at a high rate with heavy Rx or Tx
traffic, the firmware occasionally returns a STAT_CTX_QUERY value
with a flipped bit, which showed up as a spurious jump in the
reported counters.

Make the reported counters resistant to this:

- Query the per-counter widths from firmware (the COUNTER_MASK flag
  of STAT_CTX_QUERY) when a ring's stat context is allocated, falling
  back to 48 bits on P5/P7 and 64 bits on older chips if firmware
  does not report them, and apply them to every sample.
- Have firmware DMA the counters into the stat context periodically
  (every 250 ms), instead of leaving the buffer unused with update
  period 0.
- On each read, take the bitwise majority of three samples: the DMA
  copy and two back-to-back queries. An increase is accepted, a drop
  larger than half the counter width is treated as a rollover, and a
  smaller drop is only accepted after three consecutive low readings,
  so one over-reported value cannot latch the counter high.
- Clear the cached previous values whenever they are (re)allocated,
  since the hardware stat context restarts from zero on every start.

This costs one extra STAT_CTX_QUERY per ring per stats read. Move
struct bnxt_ring_stats and struct bnxt_ring_stats_ext to
bnxt_stats.h together with the offset tables used to fill them.

Fixes: 219842b9990c ("net/bnxt: workaround spurious zero stats in Thor")
Cc: stable@dpdk.org

Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h        |  90 ---------
 drivers/net/bnxt/bnxt_cpr.h    |   7 +-
 drivers/net/bnxt/bnxt_ethdev.c |  20 ++
 drivers/net/bnxt/bnxt_hwrm.c   | 337 +++++++--------------------------
 drivers/net/bnxt/bnxt_hwrm.h   |  10 +-
 drivers/net/bnxt/bnxt_ring.c   |   9 +
 drivers/net/bnxt/bnxt_rxq.c    |   1 +
 drivers/net/bnxt/bnxt_stats.c  | 329 ++++++++++++++++++++++++++++++--
 drivers/net/bnxt/bnxt_stats.h  | 168 ++++++++++++++++
 drivers/net/bnxt/bnxt_txr.c    |   1 +
 10 files changed, 595 insertions(+), 377 deletions(-)

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 2433a39a65..aba5b4b924 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -700,96 +700,6 @@ struct bnxt_flow_stat_info {
 	struct bnxt_ctx_mem_buf_info tx_fc_out_tbl;
 };
 
-struct bnxt_ring_stats {
-	/* Number of transmitted unicast packets */
-	uint64_t	tx_ucast_pkts;
-	/* Number of transmitted multicast packets */
-	uint64_t	tx_mcast_pkts;
-	/* Number of transmitted broadcast packets */
-	uint64_t	tx_bcast_pkts;
-	/* Number of packets discarded in transmit path */
-	uint64_t	tx_discard_pkts;
-	/* Number of packets in transmit path with error */
-	uint64_t	tx_error_pkts;
-	/* Number of transmitted bytes for unicast traffic */
-	uint64_t	tx_ucast_bytes;
-	/* Number of transmitted bytes for multicast traffic */
-	uint64_t	tx_mcast_bytes;
-	/* Number of transmitted bytes for broadcast traffic */
-	uint64_t	tx_bcast_bytes;
-	/* Number of received unicast packets */
-	uint64_t	rx_ucast_pkts;
-	/* Number of received multicast packets */
-	uint64_t	rx_mcast_pkts;
-	/* Number of received broadcast packets */
-	uint64_t	rx_bcast_pkts;
-	/* Number of packets discarded in receive path */
-	uint64_t	rx_discard_pkts;
-	/* Number of packets in receive path with errors */
-	uint64_t	rx_error_pkts;
-	/* Number of received bytes for unicast traffic */
-	uint64_t	rx_ucast_bytes;
-	/* Number of received bytes for multicast traffic */
-	uint64_t	rx_mcast_bytes;
-	/* Number of received bytes for broadcast traffic */
-	uint64_t	rx_bcast_bytes;
-	/* Number of aggregated unicast packets */
-	uint64_t	rx_agg_pkts;
-	/* Number of aggregated unicast bytes */
-	uint64_t	rx_agg_bytes;
-	/* Number of aggregation events */
-	uint64_t	rx_agg_events;
-	/* Number of aborted aggregations */
-	uint64_t	rx_agg_aborts;
-};
-
-struct bnxt_ring_stats_ext {
-	/* Number of received unicast packets */
-	uint64_t        rx_ucast_pkts;
-	/* Number of received multicast packets */
-	uint64_t        rx_mcast_pkts;
-	/* Number of received broadcast packets */
-	uint64_t        rx_bcast_pkts;
-	/* Number of discarded packets on receive path */
-	uint64_t        rx_discard_pkts;
-	/* Number of packets on receive path with error */
-	uint64_t        rx_error_pkts;
-	/* Number of received bytes for unicast traffic */
-	uint64_t        rx_ucast_bytes;
-	/* Number of received bytes for multicast traffic */
-	uint64_t        rx_mcast_bytes;
-	/* Number of received bytes for broadcast traffic */
-	uint64_t        rx_bcast_bytes;
-	/* Number of transmitted unicast packets */
-	uint64_t        tx_ucast_pkts;
-	/* Number of transmitted multicast packets */
-	uint64_t        tx_mcast_pkts;
-	/* Number of transmitted broadcast packets */
-	uint64_t        tx_bcast_pkts;
-	/* Number of packets on transmit path with error */
-	uint64_t        tx_error_pkts;
-	/* Number of discarded packets on transmit path */
-	uint64_t        tx_discard_pkts;
-	/* Number of transmitted bytes for unicast traffic */
-	uint64_t        tx_ucast_bytes;
-	/* Number of transmitted bytes for multicast traffic */
-	uint64_t        tx_mcast_bytes;
-	/* Number of transmitted bytes for broadcast traffic */
-	uint64_t        tx_bcast_bytes;
-	/* Number of TPA eligible packets */
-	uint64_t        rx_tpa_eligible_pkt;
-	/* Number of TPA eligible bytes */
-	uint64_t        rx_tpa_eligible_bytes;
-	/* Number of TPA packets */
-	uint64_t        rx_tpa_pkt;
-	/* Number of TPA bytes */
-	uint64_t        rx_tpa_bytes;
-	/* Number of TPA errors */
-	uint64_t        rx_tpa_errors;
-	/* Number of TPA events */
-	uint64_t        rx_tpa_events;
-};
-
 enum bnxt_session_type {
 	BNXT_SESSION_TYPE_REGULAR = 0,
 	BNXT_SESSION_TYPE_SHARED_COMMON,
diff --git a/drivers/net/bnxt/bnxt_cpr.h b/drivers/net/bnxt/bnxt_cpr.h
index de157ec4ab..1681bc0b81 100644
--- a/drivers/net/bnxt/bnxt_cpr.h
+++ b/drivers/net/bnxt/bnxt_cpr.h
@@ -97,6 +97,8 @@ struct nqe_cn {
 };
 
 struct bnxt_ring;
+struct bnxt_ring_stats;
+struct bnxt_ring_stats_ext;
 struct bnxt_cp_ring_info {
 	uint32_t		cp_raw_cons;
 
@@ -114,7 +116,10 @@ struct bnxt_cp_ring_info {
 	uint32_t                epoch;
 	uint32_t		toggle;
 	uint8_t			dpi;  /* Doorbell page index for multi-doorbell support */
-
+	struct bnxt_ring_stats		*stats_mask;
+	struct bnxt_ring_stats_ext	*ext_stats_mask;
+	struct bnxt_ring_stats		*consec_low;
+	struct bnxt_ring_stats_ext	*consec_low_ext;
 };
 
 #define RX_CMP_L2_ERRORS						\
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 4ecd2effdf..a456131c5c 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -827,6 +827,16 @@ static int bnxt_alloc_prev_ring_ext_stats(struct bnxt *bp)
 	if (bp->tx_cp_nr_rings > 0 && bp->prev_tx_ring_stats_ext == NULL)
 		goto error;
 
+	/* The hardware stat context is reset on every start.
+	 * Clearing software stats to match even when memory
+	 * isn't re-allocated.
+	 */
+	memset(bp->prev_rx_ring_stats_ext, 0,
+	       sizeof(struct bnxt_ring_stats_ext) * bp->rx_cp_nr_rings);
+	if (bp->prev_tx_ring_stats_ext != NULL)
+		memset(bp->prev_tx_ring_stats_ext, 0,
+		       sizeof(struct bnxt_ring_stats_ext) * bp->tx_cp_nr_rings);
+
 	return 0;
 
 error:
@@ -855,6 +865,16 @@ static int bnxt_alloc_prev_ring_stats(struct bnxt *bp)
 	if (bp->tx_cp_nr_rings > 0 && bp->prev_tx_ring_stats == NULL)
 		goto error;
 
+	/* The hardware stat context is reset on every start.
+	 * Clearing software stats to match even when memory
+	 * isn't re-allocated.
+	 */
+	memset(bp->prev_rx_ring_stats, 0,
+	       sizeof(struct bnxt_ring_stats) * bp->rx_cp_nr_rings);
+	if (bp->prev_tx_ring_stats != NULL)
+		memset(bp->prev_tx_ring_stats, 0,
+		       sizeof(struct bnxt_ring_stats) * bp->tx_cp_nr_rings);
+
 	return 0;
 
 error:
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 0226bca697..bda2c75ce5 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -20,6 +20,7 @@
 #include "bnxt_rxq.h"
 #include "bnxt_rxr.h"
 #include "bnxt_ring.h"
+#include "bnxt_stats.h"
 #include "bnxt_txq.h"
 #include "bnxt_txr.h"
 #include "bnxt_vnic.h"
@@ -2591,7 +2592,7 @@ int bnxt_hwrm_stat_ctx_alloc(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 
 	req.stats_dma_length = rte_cpu_to_le_16(BNXT_HWRM_CTX_GET_SIZE(bp));
 
-	req.update_period_ms = rte_cpu_to_le_32(0);
+	req.update_period_ms = rte_cpu_to_le_32(BNXT_DMA_STATS_UPDATE_PERIOD);
 
 	req.stats_dma_addr = rte_cpu_to_le_64(cpr->hw_stats_map);
 
@@ -3563,6 +3564,7 @@ void bnxt_free_hwrm_rx_ring(struct bnxt *bp, int queue_index)
 	if (cpr != NULL) {
 		bnxt_hwrm_stat_ctx_free(bp, cpr);
 		bnxt_free_cp_ring(bp, cpr);
+		bnxt_clear_ring_stats_masks(cpr);
 	}
 
 	if (BNXT_HAS_RING_GRPS(bp))
@@ -5700,311 +5702,112 @@ int bnxt_hwrm_fwd_resp(struct bnxt *bp, uint16_t target_id,
 	return rc;
 }
 
-static void bnxt_update_prev_stat(uint64_t *cntr, uint64_t *prev_cntr)
+int bnxt_hwrm_stats_query(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			  struct bnxt_ring_stats *ring_stats)
 {
-	/* One of the HW stat values that make up this counter was zero as
-	 * returned by HW in this iteration, so use the previous
-	 * iteration's counter value
-	 */
-	if (!cntr || !prev_cntr)
-		return;
-	if (*prev_cntr && *cntr == 0)
-		*cntr = *prev_cntr;
-	else
-		*prev_cntr = *cntr;
-}
-
-static void bnxt_get_prev_tx_stats(struct bnxt_ring_stats *ring_stats,
-				   struct bnxt_ring_stats *prev_stats)
-{
-	ring_stats->tx_ucast_pkts = prev_stats->tx_ucast_pkts;
-	ring_stats->tx_mcast_pkts = prev_stats->tx_mcast_pkts;
-	ring_stats->tx_bcast_pkts = prev_stats->tx_bcast_pkts;
-	ring_stats->tx_ucast_bytes = prev_stats->tx_ucast_bytes;
-	ring_stats->tx_mcast_bytes = prev_stats->tx_mcast_bytes;
-	ring_stats->tx_bcast_bytes = prev_stats->tx_bcast_bytes;
-	ring_stats->tx_discard_pkts = prev_stats->tx_discard_pkts;
-}
-
-static void bnxt_get_prev_rx_stats(struct bnxt_ring_stats *ring_stats,
-				   struct bnxt_ring_stats *prev_stats)
-{
-	ring_stats->rx_ucast_pkts = prev_stats->rx_ucast_pkts;
-	ring_stats->rx_mcast_pkts = prev_stats->rx_mcast_pkts;
-	ring_stats->rx_bcast_pkts = prev_stats->rx_bcast_pkts;
-	ring_stats->rx_ucast_bytes = prev_stats->rx_ucast_bytes;
-	ring_stats->rx_mcast_bytes = prev_stats->rx_mcast_bytes;
-	ring_stats->rx_bcast_bytes = prev_stats->rx_bcast_bytes;
-	ring_stats->rx_discard_pkts = prev_stats->rx_discard_pkts;
-	ring_stats->rx_error_pkts = prev_stats->rx_error_pkts;
-	ring_stats->rx_agg_pkts = prev_stats->rx_agg_pkts;
-	ring_stats->rx_agg_bytes = prev_stats->rx_agg_bytes;
-	ring_stats->rx_agg_events = prev_stats->rx_agg_events;
-	ring_stats->rx_agg_aborts = prev_stats->rx_agg_aborts;
-}
-
-int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
-			 struct bnxt_ring_stats *ring_stats, bool rx)
-{
-	int rc = 0;
 	struct hwrm_stat_ctx_query_input req = {.req_type = 0};
 	struct hwrm_stat_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
-	struct bnxt_ring_stats *prev_stats = &bp->prev_rx_ring_stats[idx];
-
-	if (!rx)
-		prev_stats = &bp->prev_tx_ring_stats[idx];
-
-	if (!bp->eth_dev->data->dev_started) {
-		if (rx)
-			bnxt_get_prev_rx_stats(ring_stats, prev_stats);
-		else
-			bnxt_get_prev_tx_stats(ring_stats, prev_stats);
+	uint64_t *ring_stats_u64, *hw_stats, *masks;
+	int rc;
 
+	if (!bp->eth_dev->data->dev_started)
 		return 0;
-	}
-	HWRM_PREP(&req, HWRM_STAT_CTX_QUERY, BNXT_USE_CHIMP_MB);
 
-	req.stat_ctx_id = rte_cpu_to_le_32(cid);
+	HWRM_PREP(&req, HWRM_STAT_CTX_QUERY, BNXT_USE_CHIMP_MB);
 
+	req.stat_ctx_id = rte_cpu_to_le_32(cpr->hw_stats_ctx_id);
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 
 	HWRM_CHECK_RESULT();
 
-	if (rx) {
-		ring_stats->rx_ucast_pkts = rte_le_to_cpu_64(resp->rx_ucast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_ucast_pkts,
-				      &prev_stats->rx_ucast_pkts);
-
-		ring_stats->rx_mcast_pkts = rte_le_to_cpu_64(resp->rx_mcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_mcast_pkts,
-				      &prev_stats->rx_mcast_pkts);
-
-		ring_stats->rx_bcast_pkts = rte_le_to_cpu_64(resp->rx_bcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_bcast_pkts,
-				      &prev_stats->rx_bcast_pkts);
+	masks = (uint64_t *)cpr->stats_mask;
+	hw_stats = (uint64_t *)&resp->tx_ucast_pkts;
+	ring_stats_u64 = (uint64_t *)ring_stats;
 
-		ring_stats->rx_ucast_bytes = rte_le_to_cpu_64(resp->rx_ucast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_ucast_bytes,
-				      &prev_stats->rx_ucast_bytes);
+	rc = bnxt_apply_stats_masks(ring_stats_u64, hw_stats, masks,
+				    BNXT_RING_STATS_CNT);
 
-		ring_stats->rx_mcast_bytes = rte_le_to_cpu_64(resp->rx_mcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_mcast_bytes,
-				      &prev_stats->rx_mcast_bytes);
-
-		ring_stats->rx_bcast_bytes = rte_le_to_cpu_64(resp->rx_bcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_bcast_bytes,
-				      &prev_stats->rx_bcast_bytes);
-
-		ring_stats->rx_discard_pkts = rte_le_to_cpu_64(resp->rx_discard_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_discard_pkts,
-				      &prev_stats->rx_discard_pkts);
-
-		ring_stats->rx_error_pkts = rte_le_to_cpu_64(resp->rx_error_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_error_pkts,
-				      &prev_stats->rx_error_pkts);
-
-		ring_stats->rx_agg_pkts = rte_le_to_cpu_64(resp->rx_agg_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_agg_pkts,
-				      &prev_stats->rx_agg_pkts);
-
-		ring_stats->rx_agg_bytes = rte_le_to_cpu_64(resp->rx_agg_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_agg_bytes,
-				      &prev_stats->rx_agg_bytes);
+	HWRM_UNLOCK();
 
-		ring_stats->rx_agg_events = rte_le_to_cpu_64(resp->rx_agg_events);
-		bnxt_update_prev_stat(&ring_stats->rx_agg_events,
-				      &prev_stats->rx_agg_events);
+	return rc;
+}
 
-		ring_stats->rx_agg_aborts = rte_le_to_cpu_64(resp->rx_agg_aborts);
-		bnxt_update_prev_stat(&ring_stats->rx_agg_aborts,
-				      &prev_stats->rx_agg_aborts);
-	} else {
-		ring_stats->tx_ucast_pkts = rte_le_to_cpu_64(resp->tx_ucast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_ucast_pkts,
-				      &prev_stats->tx_ucast_pkts);
+int bnxt_hwrm_stats_ext_query(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			    struct bnxt_ring_stats_ext *ring_stats)
+{
+	struct hwrm_stat_ext_ctx_query_input req = {.req_type = 0};
+	struct hwrm_stat_ext_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
+	uint64_t *ring_stats_u64, *hw_stats, *masks;
+	int rc;
 
-		ring_stats->tx_mcast_pkts = rte_le_to_cpu_64(resp->tx_mcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_mcast_pkts,
-				      &prev_stats->tx_mcast_pkts);
+	if (!bp->eth_dev->data->dev_started)
+		return 0;
 
-		ring_stats->tx_bcast_pkts = rte_le_to_cpu_64(resp->tx_bcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_bcast_pkts,
-				      &prev_stats->tx_bcast_pkts);
+	HWRM_PREP(&req, HWRM_STAT_EXT_CTX_QUERY, BNXT_USE_CHIMP_MB);
 
-		ring_stats->tx_ucast_bytes = rte_le_to_cpu_64(resp->tx_ucast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_ucast_bytes,
-				      &prev_stats->tx_ucast_bytes);
+	req.stat_ctx_id = rte_cpu_to_le_32(cpr->hw_stats_ctx_id);
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
 
-		ring_stats->tx_mcast_bytes = rte_le_to_cpu_64(resp->tx_mcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_mcast_bytes,
-				      &prev_stats->tx_mcast_bytes);
+	HWRM_CHECK_RESULT();
 
-		ring_stats->tx_bcast_bytes = rte_le_to_cpu_64(resp->tx_bcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_bcast_bytes,
-				      &prev_stats->tx_bcast_bytes);
+	masks = (uint64_t *)cpr->ext_stats_mask;
+	hw_stats = (uint64_t *)&resp->rx_ucast_pkts;
+	ring_stats_u64 = (uint64_t *)ring_stats;
 
-		ring_stats->tx_discard_pkts = rte_le_to_cpu_64(resp->tx_discard_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_discard_pkts,
-				      &prev_stats->tx_discard_pkts);
-	}
+	rc = bnxt_apply_stats_masks(ring_stats_u64, hw_stats, masks,
+				    BNXT_RING_STATS_EXT_CNT);
 
 	HWRM_UNLOCK();
 
 	return rc;
 }
 
-static void bnxt_get_prev_rx_stats_ext(struct bnxt_ring_stats_ext *ring_stats,
-				       struct bnxt_ring_stats_ext *prev_stats)
+int bnxt_hwrm_ring_stats_masks(struct bnxt *bp,
+			       struct bnxt_cp_ring_info *cpr)
 {
-	ring_stats->rx_ucast_pkts = prev_stats->rx_ucast_pkts;
-	ring_stats->rx_mcast_pkts = prev_stats->rx_mcast_pkts;
-	ring_stats->rx_bcast_pkts = prev_stats->rx_bcast_pkts;
-	ring_stats->rx_ucast_bytes = prev_stats->rx_ucast_bytes;
-	ring_stats->rx_mcast_bytes = prev_stats->rx_mcast_bytes;
-	ring_stats->rx_bcast_bytes = prev_stats->rx_bcast_bytes;
-	ring_stats->rx_discard_pkts = prev_stats->rx_discard_pkts;
-	ring_stats->rx_error_pkts = prev_stats->rx_error_pkts;
-	ring_stats->rx_tpa_eligible_pkt = prev_stats->rx_tpa_eligible_pkt;
-	ring_stats->rx_tpa_eligible_bytes = prev_stats->rx_tpa_eligible_bytes;
-	ring_stats->rx_tpa_pkt = prev_stats->rx_tpa_pkt;
-	ring_stats->rx_tpa_bytes = prev_stats->rx_tpa_bytes;
-	ring_stats->rx_tpa_errors = prev_stats->rx_tpa_errors;
-	ring_stats->rx_tpa_events = prev_stats->rx_tpa_events;
-}
+	struct hwrm_stat_ctx_query_input req = {.req_type = 0};
+	struct hwrm_stat_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
+	uint64_t *cpr_masks, *hw_masks;
+	int rc;
 
-static void bnxt_get_prev_tx_stats_ext(struct bnxt_ring_stats_ext *ring_stats,
-				       struct bnxt_ring_stats_ext *prev_stats)
-{
-	ring_stats->tx_ucast_pkts = prev_stats->tx_ucast_pkts;
-	ring_stats->tx_mcast_pkts = prev_stats->tx_mcast_pkts;
-	ring_stats->tx_bcast_pkts = prev_stats->tx_bcast_pkts;
-	ring_stats->tx_ucast_bytes = prev_stats->tx_ucast_bytes;
-	ring_stats->tx_mcast_bytes = prev_stats->tx_mcast_bytes;
-	ring_stats->tx_bcast_bytes = prev_stats->tx_bcast_bytes;
-	ring_stats->tx_discard_pkts = prev_stats->tx_discard_pkts;
-	ring_stats->tx_error_pkts = prev_stats->tx_error_pkts;
+	HWRM_PREP(&req, HWRM_STAT_CTX_QUERY, BNXT_USE_CHIMP_MB);
+	req.stat_ctx_id = rte_cpu_to_le_32(cpr->hw_stats_ctx_id);
+	req.flags = HWRM_STAT_CTX_QUERY_INPUT_FLAGS_COUNTER_MASK;
+	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
+	if (rc == 0 && resp->error_code == 0) {
+		cpr_masks = (uint64_t *)cpr->stats_mask;
+		hw_masks = (uint64_t *)&resp->tx_ucast_pkts;
+		bnxt_masks_fill(bp, cpr_masks, hw_masks, BNXT_RING_STATS_CNT);
+	} else {
+		cpr_masks = (uint64_t *)cpr->stats_mask;
+		bnxt_masks_fill(bp, cpr_masks, NULL, BNXT_RING_STATS_CNT);
+	}
+	HWRM_UNLOCK();
+	return 0;
 }
 
-int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
-			     struct bnxt_ring_stats_ext *ring_stats, bool rx)
+int bnxt_hwrm_ring_stats_ext_masks(struct bnxt *bp,
+					  struct bnxt_cp_ring_info *cpr)
 {
-	int rc = 0;
 	struct hwrm_stat_ext_ctx_query_input req = {.req_type = 0};
 	struct hwrm_stat_ext_ctx_query_output *resp = bp->hwrm_cmd_resp_addr;
+	uint64_t *cpr_masks, *hw_masks;
+	int rc;
 
-	struct bnxt_ring_stats_ext *prev_stats = &bp->prev_rx_ring_stats_ext[idx];
-
-	if (!rx)
-		prev_stats = &bp->prev_tx_ring_stats_ext[idx];
-
-	if (!bp->eth_dev->data->dev_started) {
-		if (rx)
-			bnxt_get_prev_rx_stats_ext(ring_stats, prev_stats);
-		else
-			bnxt_get_prev_tx_stats_ext(ring_stats, prev_stats);
-
-		return 0;
-	}
 	HWRM_PREP(&req, HWRM_STAT_EXT_CTX_QUERY, BNXT_USE_CHIMP_MB);
-
-	req.stat_ctx_id = rte_cpu_to_le_32(cid);
+	req.stat_ctx_id = rte_cpu_to_le_32(cpr->hw_stats_ctx_id);
+	req.flags = HWRM_STAT_EXT_CTX_QUERY_INPUT_FLAGS_COUNTER_MASK;
 	rc = bnxt_hwrm_send_message(bp, &req, sizeof(req), BNXT_USE_CHIMP_MB);
-
-	HWRM_CHECK_RESULT();
-
-	if (rx) {
-		ring_stats->rx_ucast_pkts = rte_le_to_cpu_64(resp->rx_ucast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_ucast_pkts,
-				      &prev_stats->rx_ucast_pkts);
-
-		ring_stats->rx_mcast_pkts = rte_le_to_cpu_64(resp->rx_mcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_mcast_pkts,
-				      &prev_stats->rx_mcast_pkts);
-
-		ring_stats->rx_bcast_pkts = rte_le_to_cpu_64(resp->rx_bcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_bcast_pkts,
-				      &prev_stats->rx_bcast_pkts);
-
-		ring_stats->rx_ucast_bytes = rte_le_to_cpu_64(resp->rx_ucast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_ucast_bytes,
-				      &prev_stats->rx_ucast_bytes);
-
-		ring_stats->rx_mcast_bytes = rte_le_to_cpu_64(resp->rx_mcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_mcast_bytes,
-				      &prev_stats->rx_mcast_bytes);
-
-		ring_stats->rx_bcast_bytes = rte_le_to_cpu_64(resp->rx_bcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_bcast_bytes,
-				      &prev_stats->rx_bcast_bytes);
-
-		ring_stats->rx_discard_pkts = rte_le_to_cpu_64(resp->rx_discard_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_discard_pkts,
-				      &prev_stats->rx_discard_pkts);
-
-		ring_stats->rx_error_pkts = rte_le_to_cpu_64(resp->rx_error_pkts);
-		bnxt_update_prev_stat(&ring_stats->rx_error_pkts,
-				      &prev_stats->rx_error_pkts);
-
-		ring_stats->rx_tpa_eligible_pkt = rte_le_to_cpu_64(resp->rx_tpa_eligible_pkt);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_eligible_pkt,
-				      &prev_stats->rx_tpa_eligible_pkt);
-
-		ring_stats->rx_tpa_eligible_bytes = rte_le_to_cpu_64(resp->rx_tpa_eligible_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_eligible_bytes,
-				      &prev_stats->rx_tpa_eligible_bytes);
-
-		ring_stats->rx_tpa_pkt = rte_le_to_cpu_64(resp->rx_tpa_pkt);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_pkt,
-				      &prev_stats->rx_tpa_pkt);
-
-		ring_stats->rx_tpa_bytes = rte_le_to_cpu_64(resp->rx_tpa_bytes);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_bytes,
-				      &prev_stats->rx_tpa_bytes);
-
-		ring_stats->rx_tpa_errors = rte_le_to_cpu_64(resp->rx_tpa_errors);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_errors,
-				      &prev_stats->rx_tpa_errors);
-
-		ring_stats->rx_tpa_events = rte_le_to_cpu_64(resp->rx_tpa_events);
-		bnxt_update_prev_stat(&ring_stats->rx_tpa_events,
-				      &prev_stats->rx_tpa_events);
+	if (rc == 0 && resp->error_code == 0) {
+		cpr_masks = (uint64_t *)cpr->ext_stats_mask;
+		hw_masks = (uint64_t *)&resp->rx_ucast_pkts;
+		bnxt_masks_fill(bp, cpr_masks, hw_masks, BNXT_RING_STATS_EXT_CNT);
 	} else {
-		ring_stats->tx_ucast_pkts = rte_le_to_cpu_64(resp->tx_ucast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_ucast_pkts,
-				      &prev_stats->tx_ucast_pkts);
-
-		ring_stats->tx_mcast_pkts = rte_le_to_cpu_64(resp->tx_mcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_mcast_pkts,
-				      &prev_stats->tx_mcast_pkts);
-
-		ring_stats->tx_bcast_pkts = rte_le_to_cpu_64(resp->tx_bcast_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_bcast_pkts,
-				      &prev_stats->tx_bcast_pkts);
-
-		ring_stats->tx_ucast_bytes = rte_le_to_cpu_64(resp->tx_ucast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_ucast_bytes,
-				      &prev_stats->tx_ucast_bytes);
-
-		ring_stats->tx_mcast_bytes = rte_le_to_cpu_64(resp->tx_mcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_mcast_bytes,
-				      &prev_stats->tx_mcast_bytes);
-
-		ring_stats->tx_bcast_bytes = rte_le_to_cpu_64(resp->tx_bcast_bytes);
-		bnxt_update_prev_stat(&ring_stats->tx_bcast_bytes,
-				      &prev_stats->tx_bcast_bytes);
-
-		ring_stats->tx_discard_pkts = rte_le_to_cpu_64(resp->tx_discard_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_discard_pkts,
-				      &prev_stats->tx_discard_pkts);
-
-		ring_stats->tx_error_pkts = rte_le_to_cpu_64(resp->tx_error_pkts);
-		bnxt_update_prev_stat(&ring_stats->tx_error_pkts,
-				      &prev_stats->tx_error_pkts);
+		cpr_masks = (uint64_t *)cpr->ext_stats_mask;
+		bnxt_masks_fill(bp, cpr_masks, NULL, BNXT_RING_STATS_EXT_CNT);
 	}
-
 	HWRM_UNLOCK();
-
-	return rc;
+	return 0;
 }
 
 int bnxt_hwrm_port_qstats(struct bnxt *bp)
@@ -8070,6 +7873,8 @@ void bnxt_free_hwrm_tx_ring(struct bnxt *bp, int queue_index)
 	bnxt_hwrm_stat_ctx_free(bp, cpr);
 
 	bnxt_free_cp_ring(bp, cpr);
+
+	bnxt_clear_ring_stats_masks(cpr);
 }
 
 int bnxt_hwrm_config_host_mtu(struct bnxt *bp)
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index 9fe0202174..546107b08d 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -368,10 +368,12 @@ int bnxt_hwrm_fw_echo_reply(struct bnxt *bp, uint32_t echo_req_data1,
 			    uint32_t echo_req_data2);
 int bnxt_hwrm_poll_ver_get(struct bnxt *bp);
 int bnxt_hwrm_rx_ring_reset(struct bnxt *bp, int queue_index);
-int bnxt_hwrm_ring_stats(struct bnxt *bp, uint32_t cid, int idx,
-			 struct bnxt_ring_stats *stats, bool rx);
-int bnxt_hwrm_ring_stats_ext(struct bnxt *bp, uint32_t cid, int idx,
-			     struct bnxt_ring_stats_ext *ring_stats, bool rx);
+int bnxt_hwrm_stats_query(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			  struct bnxt_ring_stats *ring_stats);
+int bnxt_hwrm_stats_ext_query(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			      struct bnxt_ring_stats_ext *ring_stats);
+int bnxt_hwrm_ring_stats_masks(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+int bnxt_hwrm_ring_stats_ext_masks(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_hwrm_read_sfp_module_eeprom_info(struct bnxt *bp, uint16_t i2c_addr,
 					  uint16_t page_number, uint16_t start_addr,
 					  uint16_t data_length, uint8_t *buf);
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index d478c60a1e..bc068fc8fd 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -15,6 +15,7 @@
 #include "bnxt_rxr.h"
 #include "bnxt_txq.h"
 #include "bnxt_txr.h"
+#include "bnxt_stats.h"
 
 #include "hsi_struct_def_dpdk.h"
 
@@ -649,6 +650,10 @@ int bnxt_alloc_hwrm_rx_ring(struct bnxt *bp, int queue_index)
 	if (rc)
 		goto err_out;
 
+	rc = bnxt_get_ring_stats_masks(bp, cpr);
+	if (rc)
+		goto err_out;
+
 	if (BNXT_HAS_RING_GRPS(bp)) {
 		bp->grp_info[queue_index].fw_stats_ctx = cpr->hw_stats_ctx_id;
 		bp->grp_info[queue_index].cp_fw_ring_id = cp_ring->fw_ring_id;
@@ -933,6 +938,10 @@ int bnxt_alloc_hwrm_tx_ring(struct bnxt *bp, int queue_index)
 	if (rc)
 		goto err_out;
 
+	rc = bnxt_get_ring_stats_masks(bp, cpr);
+	if (rc)
+		goto err_out;
+
 	if (bp->vnic_cap_flags & BNXT_VNIC_CAP_COS_CLASSIFY)
 		tx_cosq_id = bp->tx_cosq_id[queue_index < bp->max_lltc ? queue_index : 0];
 	else
diff --git a/drivers/net/bnxt/bnxt_rxq.c b/drivers/net/bnxt/bnxt_rxq.c
index 11115db1fd..62530d261d 100644
--- a/drivers/net/bnxt/bnxt_rxq.c
+++ b/drivers/net/bnxt/bnxt_rxq.c
@@ -8,6 +8,7 @@
 #include <rte_malloc.h>
 
 #include "bnxt.h"
+#include "bnxt_stats.h"
 #include "bnxt_filter.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ring.h"
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 867483a514..7c7c7c04cf 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -544,6 +544,299 @@ static const struct bnxt_xstats_name_off bnxt_tx_ext_stats_strings[] = {
  * Statistics functions
  */
 
+void bnxt_masks_fill(struct bnxt *bp, uint64_t *dst,
+		     const uint64_t *src, uint32_t count)
+{
+	uint64_t def_mask;
+	uint32_t i;
+
+	def_mask = (BNXT_CHIP_P5(bp) || BNXT_CHIP_P7(bp)) ?
+		   (1ULL << 48) - 1 : UINT64_MAX;
+
+	for (i = 0; i < count; i++)
+		dst[i] = src ? rte_le_to_cpu_64(src[i]) : def_mask;
+}
+
+/*
+ * Apply the per-counter HW masks to the raw DMA stat values. The mask array is
+ * populated by bnxt_get_ring_stats_masks() (from firmware, or the chip-width
+ * default when firmware does not report masks). Any caller that reaches here
+ * with a NULL mask is misconfigured, so fail loudly rather than silently
+ * defaulting to an all-ones mask.
+ */
+int bnxt_apply_stats_masks(uint64_t *dst, const uint64_t *src,
+		const uint64_t *masks, uint32_t count)
+{
+	uint32_t i;
+
+	if (masks == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "ring stats mask not initialized");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < count; i++)
+		dst[i] = rte_le_to_cpu_64(src[i]) & masks[i];
+
+	return 0;
+}
+
+int bnxt_get_ring_stats_masks(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	uint64_t *cpr_masks;
+
+	if (cpr->stats_mask == NULL) {
+		cpr->stats_mask = rte_zmalloc("bnxt_stats_mask",
+					      sizeof(*cpr->stats_mask), 0);
+		if (cpr->stats_mask == NULL)
+			goto enomem;
+	}
+	if (cpr->ext_stats_mask == NULL) {
+		cpr->ext_stats_mask = rte_zmalloc("bnxt_ext_stats_mask",
+						  sizeof(*cpr->ext_stats_mask), 0);
+		if (cpr->ext_stats_mask == NULL)
+			goto enomem;
+	}
+	if (cpr->consec_low == NULL) {
+		cpr->consec_low = rte_zmalloc("bnxt_consec_low",
+					      sizeof(*cpr->consec_low), 0);
+		if (cpr->consec_low == NULL)
+			goto enomem;
+	}
+	if (cpr->consec_low_ext == NULL) {
+		cpr->consec_low_ext = rte_zmalloc("bnxt_consec_low_ext",
+						  sizeof(*cpr->consec_low_ext), 0);
+		if (cpr->consec_low_ext == NULL)
+			goto enomem;
+	}
+
+	cpr_masks = (uint64_t *)cpr->stats_mask;
+	bnxt_masks_fill(bp, cpr_masks, NULL, BNXT_RING_STATS_CNT);
+	cpr_masks = (uint64_t *)cpr->ext_stats_mask;
+	bnxt_masks_fill(bp, cpr_masks, NULL, BNXT_RING_STATS_EXT_CNT);
+
+	if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
+		return 0;
+
+	if (BNXT_TPA_V2_P7(bp))
+		bnxt_hwrm_ring_stats_ext_masks(bp, cpr);
+	else
+		bnxt_hwrm_ring_stats_masks(bp, cpr);
+
+	return 0;
+
+enomem:
+	bnxt_clear_ring_stats_masks(cpr);
+	return -ENOMEM;
+}
+
+void bnxt_clear_ring_stats_masks(struct bnxt_cp_ring_info *cpr)
+{
+	rte_free(cpr->stats_mask);
+	cpr->stats_mask = NULL;
+	rte_free(cpr->ext_stats_mask);
+	cpr->ext_stats_mask = NULL;
+	rte_free(cpr->consec_low);
+	cpr->consec_low = NULL;
+	rte_free(cpr->consec_low_ext);
+	cpr->consec_low_ext = NULL;
+}
+
+static inline uint64_t *bnxt_stat_ptr(void *base, uint16_t off)
+{
+	return (uint64_t *)((char *)base + off);
+}
+
+static uint64_t bnxt_pick_ring_stat(uint64_t prev, uint64_t pdma, uint64_t p1,
+				    uint64_t p2, uint64_t mask,
+				    uint64_t *consec_low)
+{
+	uint64_t low = 0, prev_low, drop, bit;
+
+	pdma &= mask;
+	p1 &= mask;
+	p2 &= mask;
+
+	/* One of the HW stat values that make up this counter was zero as
+	 * returned by HW in this iteration, so use the previous
+	 * iteration's counter value
+	 */
+	if ((pdma == 0 || p1 == 0 || p2 == 0) && prev != 0)
+		return prev;
+
+	/* Consensus vote to correct for bit flips */
+	for (bit = 0; bit < 64ULL; bit++) {
+		int ones = 0;
+		if (pdma & (1ULL << bit))
+			ones++;
+		if (p1 & (1ULL << bit))
+			ones++;
+		if (p2 & (1ULL << bit))
+			ones++;
+		if (ones > 1)
+			low |= (1ULL << bit);
+	}
+
+	prev_low = prev & mask;
+
+	/* Automatically accept an increase in stats.
+	 * Reset the low counter to 0 to break an under-
+	 * report streak.
+	 */
+	if (low >= prev_low) {
+		*consec_low = 0;
+		return (prev & ~mask) | low;
+	}
+
+	/* Rollover detected by assuming a drop can't be
+	 * over half the mask magnitude. Updates the software
+	 * counter to acknowledge that a rollover has happened
+	 * by incrementing the first bit beyond the masked region.
+	 */
+	drop = prev_low - low;
+	if (drop > (mask >> 1)) {
+		*consec_low = 0;
+		return ((prev & ~mask) | low) + mask + 1;
+	}
+
+	/* Code to accept a lower stat value in case a stat
+	 * was over-reported on a previous iteration. At 3
+	 * consistently low stats, the probability of 3 flukes
+	 * is low enough to accept that an incorrect previous
+	 * stat may have been locked in.
+	 */
+	if (++(*consec_low) > BNXT_STAT_CONSEC_LOW_MAX) {
+		*consec_low = 0;
+		return (prev & ~mask) | low;
+	}
+
+	return prev;
+}
+
+int bnxt_get_ring_stats(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, int idx,
+			 struct bnxt_ring_stats *ring_stats, bool rx)
+{
+	struct bnxt_ring_stats *prev_stats = &bp->prev_rx_ring_stats[idx];
+	struct ctx_hw_stats *curr_stats = (struct ctx_hw_stats *)cpr->hw_stats;
+	struct bnxt_ring_stats p1 = {0}, p2 = {0};
+	uint32_t i;
+	int rc = 0;
+
+	if (!rx)
+		prev_stats = &bp->prev_tx_ring_stats[idx];
+
+	if (!bp->eth_dev->data->dev_started) {
+		if (rx)
+			memcpy(&ring_stats->rx_ucast_pkts,
+			       &prev_stats->rx_ucast_pkts,
+			       sizeof(*ring_stats) -
+			       offsetof(struct bnxt_ring_stats, rx_ucast_pkts));
+		else
+			memcpy(ring_stats, prev_stats,
+			       offsetof(struct bnxt_ring_stats, rx_ucast_pkts));
+
+		return 0;
+	}
+
+	if (cpr->stats_mask == NULL || cpr->consec_low == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "ring stats masks not initialized");
+		return -EINVAL;
+	}
+
+	rc = bnxt_hwrm_stats_query(bp, cpr, &p1);
+	if (rc)
+		return rc;
+	rc = bnxt_hwrm_stats_query(bp, cpr, &p2);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < RTE_DIM(bnxt_ring_stat_offsets); i++) {
+		const struct bnxt_stat_offset_table *stat_offsets = &bnxt_ring_stat_offsets[i];
+		uint64_t *out  = bnxt_stat_ptr(ring_stats, stat_offsets->dst_off);
+		uint64_t *prev = bnxt_stat_ptr(prev_stats, stat_offsets->dst_off);
+
+		if (stat_offsets->is_rx != rx)
+			continue;
+
+		*out = bnxt_pick_ring_stat(*prev,
+				rte_le_to_cpu_64(*bnxt_stat_ptr(curr_stats, stat_offsets->src_off)),
+				*bnxt_stat_ptr(&p1, stat_offsets->dst_off),
+				*bnxt_stat_ptr(&p2, stat_offsets->dst_off),
+				*bnxt_stat_ptr(cpr->stats_mask, stat_offsets->dst_off),
+				bnxt_stat_ptr(cpr->consec_low, stat_offsets->dst_off));
+		*prev = *out;
+	}
+
+	return rc;
+}
+
+int bnxt_get_ring_stats_ext(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, int idx,
+			     struct bnxt_ring_stats_ext *ring_stats, bool rx)
+{
+	struct bnxt_ring_stats_ext *prev_stats = &bp->prev_rx_ring_stats_ext[idx];
+	struct bnxt_ring_stats_ext *curr_stats =
+		(struct bnxt_ring_stats_ext *)cpr->hw_stats;
+	struct bnxt_ring_stats_ext p1 = {0}, p2 = {0};
+	uint32_t i;
+	int rc = 0;
+
+	if (!rx)
+		prev_stats = &bp->prev_tx_ring_stats_ext[idx];
+
+	if (!bp->eth_dev->data->dev_started) {
+		if (rx) {
+			/* rx fields straddle the tx block: copy the rx base
+			 * fields and the trailing tpa fields separately.
+			 */
+			memcpy(ring_stats, prev_stats,
+			       offsetof(struct bnxt_ring_stats_ext, tx_ucast_pkts));
+			memcpy(&ring_stats->rx_tpa_eligible_pkt,
+			       &prev_stats->rx_tpa_eligible_pkt,
+			       sizeof(*ring_stats) -
+			       offsetof(struct bnxt_ring_stats_ext, rx_tpa_eligible_pkt));
+		} else {
+			memcpy(&ring_stats->tx_ucast_pkts,
+			       &prev_stats->tx_ucast_pkts,
+			       offsetof(struct bnxt_ring_stats_ext, rx_tpa_eligible_pkt) -
+			       offsetof(struct bnxt_ring_stats_ext, tx_ucast_pkts));
+		}
+
+		return 0;
+	}
+
+	if (cpr->ext_stats_mask == NULL || cpr->consec_low_ext == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "ring ext stats masks not initialized");
+		return -EINVAL;
+	}
+
+	rc = bnxt_hwrm_stats_ext_query(bp, cpr, &p1);
+	if (rc)
+		return rc;
+	rc = bnxt_hwrm_stats_ext_query(bp, cpr, &p2);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < RTE_DIM(bnxt_ring_stat_ext_offsets); i++) {
+		const struct bnxt_stat_offset_table *stat_ext_offsets =
+			&bnxt_ring_stat_ext_offsets[i];
+		uint64_t *out  = bnxt_stat_ptr(ring_stats, stat_ext_offsets->dst_off);
+		uint64_t *prev = bnxt_stat_ptr(prev_stats, stat_ext_offsets->dst_off);
+
+		if (stat_ext_offsets->is_rx != rx)
+			continue;
+
+		*out = bnxt_pick_ring_stat(*prev,
+				rte_le_to_cpu_64(*bnxt_stat_ptr(curr_stats,
+								stat_ext_offsets->src_off)),
+				*bnxt_stat_ptr(&p1, stat_ext_offsets->dst_off),
+				*bnxt_stat_ptr(&p2, stat_ext_offsets->dst_off),
+				*bnxt_stat_ptr(cpr->ext_stats_mask, stat_ext_offsets->dst_off),
+				bnxt_stat_ptr(cpr->consec_low_ext, stat_ext_offsets->dst_off));
+		*prev = *out;
+	}
+
+	return rc;
+}
+
 void bnxt_free_stats(struct bnxt *bp)
 {
 	int i;
@@ -669,8 +962,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
 			continue;
 
-		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
-					      &ring_stats, true);
+		rc = bnxt_get_ring_stats_ext(bp, cpr, i,
+					     &ring_stats, true);
+
 		if (unlikely(rc))
 			return rc;
 
@@ -695,8 +989,9 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (!txq->tx_started)
 			continue;
 
-		rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
-					      &ring_stats, false);
+		rc = bnxt_get_ring_stats_ext(bp, cpr, i,
+					     &ring_stats, false);
+
 		if (unlikely(rc))
 			return rc;
 
@@ -736,8 +1031,9 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (cpr->hw_stats_ctx_id == HWRM_NA_SIGNATURE)
 			continue;
 
-		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
-					  &ring_stats, true);
+		rc = bnxt_get_ring_stats(bp, cpr, i,
+					 &ring_stats, true);
+
 		if (unlikely(rc))
 			return rc;
 
@@ -757,8 +1053,9 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (!txq->tx_started)
 			continue;
 
-		rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
-					  &ring_stats, false);
+		rc = bnxt_get_ring_stats(bp, cpr, i,
+					 &ring_stats, false);
+
 		if (unlikely(rc))
 			return rc;
 
@@ -946,11 +1243,11 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 			continue;
 
 		if (BNXT_TPA_V2_P7(bp))
-			rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
-						      &ring_stats_ext, true);
+			rc = bnxt_get_ring_stats_ext(bp, cpr, i,
+						     &ring_stats_ext, true);
 		else
-			rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
-						  &ring_stats, true);
+			rc = bnxt_get_ring_stats(bp, cpr, i,
+						 &ring_stats, true);
 
 		if (unlikely(rc))
 			return rc;
@@ -972,11 +1269,11 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 			continue;
 
 		if (BNXT_TPA_V2_P7(bp))
-			rc = bnxt_hwrm_ring_stats_ext(bp, cpr->hw_stats_ctx_id, i,
-						      &ring_stats_ext, false);
+			rc = bnxt_get_ring_stats_ext(bp, cpr, i,
+						     &ring_stats_ext, false);
 		else
-			rc = bnxt_hwrm_ring_stats(bp, cpr->hw_stats_ctx_id, i,
-						  &ring_stats, false);
+			rc = bnxt_get_ring_stats(bp, cpr, i,
+						 &ring_stats, false);
 		if (unlikely(rc))
 			return rc;
 
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h
index f3df6d988d..ce2e70bec8 100644
--- a/drivers/net/bnxt/bnxt_stats.h
+++ b/drivers/net/bnxt/bnxt_stats.h
@@ -11,6 +11,164 @@
 /* Number of software (non-HWRM) xstats appended after the FW-reported ones. */
 #define BNXT_NUM_SW_XSTATS		2
 
+#define BNXT_RING_STATS_CNT		20ULL
+#define BNXT_RING_STATS_EXT_CNT		22ULL
+#define BNXT_STAT_CONSEC_LOW_MAX	2
+#define BNXT_DMA_STATS_UPDATE_PERIOD	250
+
+struct bnxt_ring_stats {
+	/* Number of transmitted unicast packets */
+	uint64_t	tx_ucast_pkts;
+	/* Number of transmitted multicast packets */
+	uint64_t	tx_mcast_pkts;
+	/* Number of transmitted broadcast packets */
+	uint64_t	tx_bcast_pkts;
+	/* Number of packets discarded in transmit path */
+	uint64_t	tx_discard_pkts;
+	/* Number of packets in transmit path with error */
+	uint64_t	tx_error_pkts;
+	/* Number of transmitted bytes for unicast traffic */
+	uint64_t	tx_ucast_bytes;
+	/* Number of transmitted bytes for multicast traffic */
+	uint64_t	tx_mcast_bytes;
+	/* Number of transmitted bytes for broadcast traffic */
+	uint64_t	tx_bcast_bytes;
+	/* Number of received unicast packets */
+	uint64_t	rx_ucast_pkts;
+	/* Number of received multicast packets */
+	uint64_t	rx_mcast_pkts;
+	/* Number of received broadcast packets */
+	uint64_t	rx_bcast_pkts;
+	/* Number of packets discarded in receive path */
+	uint64_t	rx_discard_pkts;
+	/* Number of packets in receive path with errors */
+	uint64_t	rx_error_pkts;
+	/* Number of received bytes for unicast traffic */
+	uint64_t	rx_ucast_bytes;
+	/* Number of received bytes for multicast traffic */
+	uint64_t	rx_mcast_bytes;
+	/* Number of received bytes for broadcast traffic */
+	uint64_t	rx_bcast_bytes;
+	/* Number of aggregated unicast packets */
+	uint64_t	rx_agg_pkts;
+	/* Number of aggregated unicast bytes */
+	uint64_t	rx_agg_bytes;
+	/* Number of aggregation events */
+	uint64_t	rx_agg_events;
+	/* Number of aborted aggregations */
+	uint64_t	rx_agg_aborts;
+};
+
+struct bnxt_ring_stats_ext {
+	/* Number of received unicast packets */
+	uint64_t	rx_ucast_pkts;
+	/* Number of received multicast packets */
+	uint64_t	rx_mcast_pkts;
+	/* Number of received broadcast packets */
+	uint64_t	rx_bcast_pkts;
+	/* Number of discarded packets on receive path */
+	uint64_t	rx_discard_pkts;
+	/* Number of packets on receive path with error */
+	uint64_t	rx_error_pkts;
+	/* Number of received bytes for unicast traffic */
+	uint64_t	rx_ucast_bytes;
+	/* Number of received bytes for multicast traffic */
+	uint64_t	rx_mcast_bytes;
+	/* Number of received bytes for broadcast traffic */
+	uint64_t	rx_bcast_bytes;
+	/* Number of transmitted unicast packets */
+	uint64_t	tx_ucast_pkts;
+	/* Number of transmitted multicast packets */
+	uint64_t	tx_mcast_pkts;
+	/* Number of transmitted broadcast packets */
+	uint64_t	tx_bcast_pkts;
+	/* Number of packets on transmit path with error */
+	uint64_t	tx_error_pkts;
+	/* Number of discarded packets on transmit path */
+	uint64_t	tx_discard_pkts;
+	/* Number of transmitted bytes for unicast traffic */
+	uint64_t	tx_ucast_bytes;
+	/* Number of transmitted bytes for multicast traffic */
+	uint64_t	tx_mcast_bytes;
+	/* Number of transmitted bytes for broadcast traffic */
+	uint64_t	tx_bcast_bytes;
+	/* Number of TPA eligible packets */
+	uint64_t	rx_tpa_eligible_pkt;
+	/* Number of TPA eligible bytes */
+	uint64_t	rx_tpa_eligible_bytes;
+	/* Number of TPA packets */
+	uint64_t	rx_tpa_pkt;
+	/* Number of TPA bytes */
+	uint64_t	rx_tpa_bytes;
+	/* Number of TPA errors */
+	uint64_t	rx_tpa_errors;
+	/* Number of TPA events. Not used for P5*/
+	uint64_t	rx_tpa_events;
+};
+
+
+struct bnxt_stat_offset_table {
+	uint16_t dst_off;
+	uint16_t src_off;
+	bool     is_rx;
+};
+
+#define BNXT_STAT_OFFSET(dst_field, src_field, rxf)			\
+	{ offsetof(struct bnxt_ring_stats, dst_field),			\
+	  offsetof(struct ctx_hw_stats, src_field), rxf }
+
+#define BNXT_EXT_OFFSET(dst_field, src_field, rxf)			\
+	{ offsetof(struct bnxt_ring_stats_ext, dst_field),		\
+	  offsetof(struct bnxt_ring_stats_ext, src_field), rxf }
+
+static const struct bnxt_stat_offset_table bnxt_ring_stat_offsets[] = {
+	BNXT_STAT_OFFSET(rx_ucast_pkts,		rx_ucast_pkts,		true),
+	BNXT_STAT_OFFSET(rx_mcast_pkts,		rx_mcast_pkts,		true),
+	BNXT_STAT_OFFSET(rx_bcast_pkts,		rx_bcast_pkts,		true),
+	BNXT_STAT_OFFSET(rx_ucast_bytes,	rx_ucast_bytes,		true),
+	BNXT_STAT_OFFSET(rx_mcast_bytes,	rx_mcast_bytes,		true),
+	BNXT_STAT_OFFSET(rx_bcast_bytes,	rx_bcast_bytes,		true),
+	BNXT_STAT_OFFSET(rx_discard_pkts,	rx_discard_pkts,	true),
+	BNXT_STAT_OFFSET(rx_error_pkts,		rx_error_pkts,		true),
+	BNXT_STAT_OFFSET(rx_agg_pkts,		tpa_pkts,		true),
+	BNXT_STAT_OFFSET(rx_agg_bytes,		tpa_bytes,		true),
+	BNXT_STAT_OFFSET(rx_agg_events,		tpa_events,		true),
+	BNXT_STAT_OFFSET(rx_agg_aborts,		tpa_aborts,		true),
+	BNXT_STAT_OFFSET(tx_ucast_pkts,		tx_ucast_pkts,		false),
+	BNXT_STAT_OFFSET(tx_mcast_pkts,		tx_mcast_pkts,		false),
+	BNXT_STAT_OFFSET(tx_bcast_pkts,		tx_bcast_pkts,		false),
+	BNXT_STAT_OFFSET(tx_ucast_bytes,	tx_ucast_bytes,		false),
+	BNXT_STAT_OFFSET(tx_mcast_bytes,	tx_mcast_bytes,		false),
+	BNXT_STAT_OFFSET(tx_bcast_bytes,	tx_bcast_bytes,		false),
+	BNXT_STAT_OFFSET(tx_discard_pkts,	tx_discard_pkts,	false),
+	BNXT_STAT_OFFSET(tx_error_pkts,		tx_error_pkts,		false),
+};
+
+static const struct bnxt_stat_offset_table bnxt_ring_stat_ext_offsets[] = {
+	BNXT_EXT_OFFSET(rx_ucast_pkts,		rx_ucast_pkts,		true),
+	BNXT_EXT_OFFSET(rx_mcast_pkts,		rx_mcast_pkts,		true),
+	BNXT_EXT_OFFSET(rx_bcast_pkts,		rx_bcast_pkts,		true),
+	BNXT_EXT_OFFSET(rx_ucast_bytes,		rx_ucast_bytes,		true),
+	BNXT_EXT_OFFSET(rx_mcast_bytes,		rx_mcast_bytes,		true),
+	BNXT_EXT_OFFSET(rx_bcast_bytes,		rx_bcast_bytes,		true),
+	BNXT_EXT_OFFSET(rx_discard_pkts,	rx_discard_pkts,	true),
+	BNXT_EXT_OFFSET(rx_error_pkts,		rx_error_pkts,		true),
+	BNXT_EXT_OFFSET(rx_tpa_eligible_pkt,	rx_tpa_eligible_pkt,	true),
+	BNXT_EXT_OFFSET(rx_tpa_eligible_bytes,	rx_tpa_eligible_bytes,	true),
+	BNXT_EXT_OFFSET(rx_tpa_pkt,		rx_tpa_pkt,		true),
+	BNXT_EXT_OFFSET(rx_tpa_bytes,		rx_tpa_bytes,		true),
+	BNXT_EXT_OFFSET(rx_tpa_errors,		rx_tpa_errors,		true),
+	BNXT_EXT_OFFSET(rx_tpa_events,		rx_tpa_events,		true),
+	BNXT_EXT_OFFSET(tx_ucast_pkts,		tx_ucast_pkts,		false),
+	BNXT_EXT_OFFSET(tx_mcast_pkts,		tx_mcast_pkts,		false),
+	BNXT_EXT_OFFSET(tx_bcast_pkts,		tx_bcast_pkts,		false),
+	BNXT_EXT_OFFSET(tx_ucast_bytes,		tx_ucast_bytes,		false),
+	BNXT_EXT_OFFSET(tx_mcast_bytes,		tx_mcast_bytes,		false),
+	BNXT_EXT_OFFSET(tx_bcast_bytes,		tx_bcast_bytes,		false),
+	BNXT_EXT_OFFSET(tx_discard_pkts,	tx_discard_pkts,	false),
+	BNXT_EXT_OFFSET(tx_error_pkts,		tx_error_pkts,		false),
+};
+
 void bnxt_free_stats(struct bnxt *bp);
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 			   struct rte_eth_stats *bnxt_stats, struct eth_queue_stats *qstats);
@@ -21,6 +179,16 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 			   struct rte_eth_xstat *xstats, unsigned int n);
 int bnxt_dev_xstats_reset_op(struct rte_eth_dev *eth_dev);
+void bnxt_masks_fill(struct bnxt *bp, uint64_t *dst,
+		     const uint64_t *src, uint32_t count);
+int bnxt_apply_stats_masks(uint64_t *dst, const uint64_t *src,
+			   const uint64_t *masks, uint32_t count);
+int bnxt_get_ring_stats_masks(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+void bnxt_clear_ring_stats_masks(struct bnxt_cp_ring_info *cpr);
+int bnxt_get_ring_stats(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, int idx,
+			struct bnxt_ring_stats *stats, bool rx);
+int bnxt_get_ring_stats_ext(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, int idx,
+			    struct bnxt_ring_stats_ext *ring_stats, bool rx);
 
 struct bnxt_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index e765cc3e6f..e81a0a1860 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -11,6 +11,7 @@
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ring.h"
+#include "bnxt_stats.h"
 #include "bnxt_txq.h"
 #include "bnxt_txr.h"
 #include "hsi_struct_def_dpdk.h"
-- 
2.47.3

