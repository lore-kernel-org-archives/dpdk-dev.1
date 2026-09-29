Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B491CA5FA1
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 00:19:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A02840E2B;
	Tue, 29 Sep 2026 02:19:18 +0200 (CEST)
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com
 [209.85.222.98]) by mails.dpdk.org (Postfix) with ESMTP id 8800E40276
 for <dev@dpdk.org>; Tue, 29 Sep 2026 02:19:16 +0200 (CEST)
Received: by mail-ua1-f98.google.com with SMTP id
 a1e0cc1a2514c-97ea365dd5cso448304241.2
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790641156; x=1791245956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q8qyYW/8kpax8oTjxPBDTE8X32GLYKm5i7FrYPuBlP4=;
 b=k8BSepNIyFM9F8zd1hTQbwnwWyEoRyTVQBw+ssFSFR2BeEyLkDRShVrz+PBgxiDVoB
 LEmOFA2VO91M4oehyi9rFZlrgdX+bCvHWJTseyVYhzdqCx3irscSdq0L3dQTc9YFFwRb
 EWeMvsB6WjfR0H3CCkB3pk1poNHexZhpVfnR7cdtJiD334oxwViGg39DRKWIDbQh2Suw
 w/vCflowhKUAC7e9KdmWkq9v2S/4+nU5/XfZzMXxBSc5iih2RYTPaIps2mi6qQkvFTYs
 k8Ltfd1PgZVrTgaTeWWeuWRKI2g7Og85lWL+UkoQR0lkA5uSFF5iDSe8r9PHo3tdH6QL
 Nshg==
X-Gm-Message-State: AFq9FYIRM8czPc8psDvzkntcB7+B5GaKF3K5w9HlFWfB7GtYxF9iIFwx
 thkfhivIHxfvQU2LWUrLmOW3XKT0d4Gg8MtnlTsvA4zp0u72PLYGiqTvAjpbLaNUoNUU54UMv3n
 tIiOiKDTIkQam/koRs7J39EmW+c1W6fZAZA5xowaS8B3aStqs8UNk1aIAJhsTKGvEf0W2sY6Pbh
 EcTm/Fj6Yl13Imr3IMRz8ulF95Cf0x/roIcv43HqTkzBjyt/k1921XE5KJ0yFBJAw4EKPPdzqmt
 n9br5hXv3z1
X-Gm-Gg: AYBFou3Fzy0yL3G2TygcCW5supA+cZYe5EPQaiP4lCY/xfUY5YORBTmvTCFUt+9nbPx
 5aDnvn58TeVwrbjnsL+7P1+Lbc6dqHAwghglOiYB6cnbgougRoQiM4z4y+bOfNIRBvs7cvB0syR
 EMzWlQDv+JGWi/I2y/aZ1i6J4KV3zHnQZX08frmLaR75sqelgUgVK4btYMqEzzM/qYC36tuExS2
 dpRkXIenWo1FIm5m7cBQDR+m7Z7loZhMK7vv4eeBymZCnmUlvDBHBUx/aAGCX0DJsfV3nljq1z/
 hdgfmoPpwG6u2zPQek9RIxEA2YcaOLYs3RnkQ84eX4rr9ergPo/1Sw/hMxSo4mPMVACVK57W+o4
 ivx2HP4Aq5RxEyUJzlJIv10sfp//eihCOlJwbjqUAoD9/o4BRWDBJSLoLDSdFMs58eraCd15/8+
 pvFP9zzSnpMHCOy+Rph6g9UwKOCiaXLMGX2gNwxgthgMDbDqgcKQ==
X-Received: by 2002:a05:6102:a4b:b0:7b4:b196:f641 with SMTP id
 ada2fe7eead31-7b4b196ffa7mr1722863137.37.1790641155487; 
 Mon, 28 Sep 2026 17:19:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 71dfb90a1353d-5cde6e39962sm1775830e0c.7.2026.09.28.17.19.15
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2026 17:19:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91786abb5abso4264936d6.3
 for <dev@dpdk.org>; Mon, 28 Sep 2026 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1790641155; x=1791245955; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q8qyYW/8kpax8oTjxPBDTE8X32GLYKm5i7FrYPuBlP4=;
 b=VRqXW3gdUsLdKow+YvoULfkOfDZZnlIcD9Kt4sZ5lO+af1OpDX4t5/ZdmnFyCMV9WG
 RuAZO3Mi4bIXehdivcCzhMgyAS5RyI7ggLAyTl6VET6F8egDuK0MBnKVG9fl4ZTpHUpd
 aKXIHaJfl0BpJTYvkWqTeU3tkdPJ0QCqs7A8E=
X-Received: by 2002:a05:6214:5b82:b0:914:3ef6:ec19 with SMTP id
 6a1803df08f44-9143ef6fda4mr206714426d6.6.1790641154543; 
 Mon, 28 Sep 2026 17:19:14 -0700 (PDT)
X-Received: by 2002:a05:6214:5b82:b0:914:3ef6:ec19 with SMTP id
 6a1803df08f44-9143ef6fda4mr206714076d6.6.1790641153985; 
 Mon, 28 Sep 2026 17:19:13 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430e9f7b0sm91315306d6.43.2026.09.28.17.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:19:12 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v3] net/bnxt: add Tx DMA error stat counter
Date: Mon, 28 Sep 2026 18:22:13 -0600
Message-ID: <20260929002213.1208351-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918032812.763436-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032812.763436-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Hardware already reports an invalid/bad DMA address on a Tx BD via
the TX_CMPL_ERRORS_DMA_ERROR bit in the Tx completion record, but the
driver never inspected it, so a bad mbuf->buf_iova on Tx completed
silently with no visibility.

Check the bit in bnxt_handle_tx_cp() and in the AVX2/SSE/NEON vector
Tx-completion handlers, and count occurrences in a new per-queue
tx_dma_err counter. The counter is folded into the standard oerrors
stat and also exposed as a named xstat (tx_dma_err_cmpl) for
finer-grained visibility. The xstat name reflects what is actually
counted: one increment per Tx completion record that carries the
error bit, not one per packet -- a coalesced Tx completion can cover
several packets. The xstat itself is also a port-level sum across
queues, not a per-queue value, even though the underlying counter
field is per-queue.

tx_dma_err has a single writer (the lcore polling that Tx queue's
completions) and is read from other threads via xstats, so the
increment stores the new value with rte_atomic_store_explicit()
after a relaxed load, rather than rte_atomic_fetch_add_explicit():
with only one writer there is nothing to race against for the
read-modify-write itself, so the stronger fetch_add (a locked RMW on
most architectures) is unneeded on this per-packet path; the atomic
store still ensures other threads never observe a torn value.

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v3:
* Renamed the xstat from tx_dma_err_pkts to tx_dma_err_cmpl, and
  reworded the release note from "per-queue" to "port-level" to match
  what bnxt_dev_xstats_get_op() actually returns. Stephen Hemminger
  pointed out both: the xstat counts completions, not packets (a
  coalesced completion covers several packets, so "_pkts" overstates
  granularity), and the value summed across queues is exposed as one
  port-wide xstat, not one per queue.
* Added the DMA-error check to the NEON vector Tx-completion handler
  (bnxt_handle_tx_cp_vec() in bnxt_rxtx_vec_neon.c), matching the
  AVX2/SSE handlers already covered -- also per Stephen Hemminger.
* Switched the increment from rte_atomic_fetch_add_explicit() to a
  relaxed load + rte_atomic_store_explicit(): tx_dma_err has a single
  writer (the lcore polling that queue's completions), so the
  stronger fetch_add (a locked read-modify-write on most
  architectures) was unneeded on this per-packet path.
* Changed bnxt_stats_reset_op()'s tx_dma_err reset from a direct `= 0`
  assignment (v2) to rte_atomic_store_explicit(..., 0, ...), matching
  the atomic store now used for the increment and for the other reset
  site (bnxt_dev_xstats_reset_op()).
v2:
* Added a release notes entry documenting the new xstat, per
  reviewer request.
* NOTE: apply this patch before "net/bnxt: add support for queue size
  of 16384" -- both add a bullet under the same "Updated bnxt driver"
  release-notes heading, and the latter's context assumes this one's
  bullet is already present.

 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c  |  8 ++++++++
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c  |  8 ++++++++
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c   |  8 ++++++++
 drivers/net/bnxt/bnxt_stats.c          | 26 ++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_stats.h          |  3 +++
 drivers/net/bnxt/bnxt_txq.h            |  1 +
 drivers/net/bnxt/bnxt_txr.c            |  8 ++++++++
 8 files changed, 68 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dec96ccbc7..7ab289adf1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -74,6 +74,12 @@ New Features
     ``xdp_meta_rx_ts_valid_mask``.
   * Added ``read_clock`` operation to query the PTP hardware clock.
 
+* **Updated bnxt driver.**
+
+  * Added a ``tx_dma_err_cmpl`` xstat to report Tx completions that the
+    device flagged with a DMA error. This is a port-level counter, and
+    is also folded into the standard ``oerrors`` counter.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 50b3602839..b22bb16fa0 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -743,6 +743,14 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_store_explicit(&txq->tx_dma_err,
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed) + 1,
+				rte_memory_order_relaxed);
+
 		nb_tx_pkts += txcmp->opaque;
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
index 03f39280e5..086ba43363 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -355,6 +355,14 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_store_explicit(&txq->tx_dma_err,
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed) + 1,
+				rte_memory_order_relaxed);
+
 		if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2))
 			nb_tx_pkts += txcmp->opaque;
 		else
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 7d455b6f56..4024a80b51 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -577,6 +577,14 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_store_explicit(&txq->tx_dma_err,
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed) + 1,
+				rte_memory_order_relaxed);
+
 		if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2))
 			nb_tx_pkts += txcmp->opaque;
 		else
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 37b33f0505..8f7c867ff5 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -685,6 +685,8 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 
 		bnxt_stats->oerrors += rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							     rte_memory_order_relaxed);
+		bnxt_stats->oerrors += rte_atomic_load_explicit(&txq->tx_dma_err,
+							     rte_memory_order_relaxed);
 
 		if (!txq->tx_started)
 			continue;
@@ -758,6 +760,9 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		bnxt_stats->oerrors +=
 				rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							 rte_memory_order_relaxed);
+		bnxt_stats->oerrors +=
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed);
 	}
 
 	return rc;
@@ -808,6 +813,8 @@ int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev)
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 
 		txq->tx_mbuf_drop = 0;
+		rte_atomic_store_explicit(&txq->tx_dma_err, 0,
+					  rte_memory_order_relaxed);
 	}
 
 	bnxt_clear_prev_stat(bp);
@@ -911,6 +918,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		RTE_DIM(bnxt_tx_stats_strings) + sz +
 		RTE_DIM(bnxt_rx_ext_stats_strings) +
 		RTE_DIM(bnxt_tx_ext_stats_strings) +
+		BNXT_NUM_SW_XSTATS +
 		bnxt_flow_stats_cnt(bp);
 
 	if (n < stat_count || xstats == NULL)
@@ -1033,6 +1041,14 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		count++;
 	}
 
+	xstats[count].id = count;
+	xstats[count].value = 0;
+	for (i = 0; i < bp->tx_cp_nr_rings; i++)
+		xstats[count].value +=
+			rte_atomic_load_explicit(&bp->tx_queues[i]->tx_dma_err,
+						 rte_memory_order_relaxed);
+	count++;
+
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
@@ -1112,6 +1128,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 				sz +
 				RTE_DIM(bnxt_rx_ext_stats_strings) +
 				RTE_DIM(bnxt_tx_ext_stats_strings) +
+				BNXT_NUM_SW_XSTATS +
 				bnxt_flow_stats_cnt(bp);
 
 	if (xstats_names == NULL || size < stat_cnt)
@@ -1165,6 +1182,10 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 		count++;
 	}
 
+	strlcpy(xstats_names[count].name, "tx_dma_err_cmpl",
+		sizeof(xstats_names[count].name));
+	count++;
+
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
@@ -1190,6 +1211,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 int bnxt_dev_xstats_reset_op(struct rte_eth_dev *eth_dev)
 {
 	struct bnxt *bp = eth_dev->data->dev_private;
+	unsigned int i;
 	int ret;
 
 	ret = is_bnxt_in_error(bp);
@@ -1202,6 +1224,10 @@ int bnxt_dev_xstats_reset_op(struct rte_eth_dev *eth_dev)
 		return -ENOTSUP;
 	}
 
+	for (i = 0; i < bp->tx_cp_nr_rings; i++)
+		rte_atomic_store_explicit(&bp->tx_queues[i]->tx_dma_err, 0,
+					  rte_memory_order_relaxed);
+
 	ret = bnxt_hwrm_port_clr_stats(bp);
 	if (ret != 0)
 		PMD_DRV_LOG_LINE(ERR, "Failed to reset xstats: %s",
diff --git a/drivers/net/bnxt/bnxt_stats.h b/drivers/net/bnxt/bnxt_stats.h
index c0508e773a..534b9af5e8 100644
--- a/drivers/net/bnxt/bnxt_stats.h
+++ b/drivers/net/bnxt/bnxt_stats.h
@@ -8,6 +8,9 @@
 
 #include <ethdev_driver.h>
 
+/* Number of software (non-HWRM) xstats appended after the FW-reported ones. */
+#define BNXT_NUM_SW_XSTATS		1
+
 void bnxt_free_stats(struct bnxt *bp);
 int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 			   struct rte_eth_stats *bnxt_stats, struct eth_queue_stats *qstats);
diff --git a/drivers/net/bnxt/bnxt_txq.h b/drivers/net/bnxt/bnxt_txq.h
index ac8af91c57..525f841789 100644
--- a/drivers/net/bnxt/bnxt_txq.h
+++ b/drivers/net/bnxt/bnxt_txq.h
@@ -36,6 +36,7 @@ struct bnxt_tx_queue {
 	struct rte_mbuf **free;
 	uint64_t offloads;
 	RTE_ATOMIC(uint64_t)	tx_mbuf_drop;
+	RTE_ATOMIC(uint64_t)	tx_dma_err;
 };
 
 void bnxt_free_txq_stats(struct bnxt_tx_queue *txq);
diff --git a/drivers/net/bnxt/bnxt_txr.c b/drivers/net/bnxt/bnxt_txr.c
index 36188346f1..64ff42b38e 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -782,6 +782,14 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_store_explicit(&txq->tx_dma_err,
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed) + 1,
+				rte_memory_order_relaxed);
+
 		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
 			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
 
-- 
2.47.3

