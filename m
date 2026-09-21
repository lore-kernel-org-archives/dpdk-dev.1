Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0300AC982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 02:24:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F72240E35;
	Mon, 21 Sep 2026 04:24:04 +0200 (CEST)
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com
 [209.85.210.97]) by mails.dpdk.org (Postfix) with ESMTP id C4D2740E1D
 for <dev@dpdk.org>; Mon, 21 Sep 2026 04:24:02 +0200 (CEST)
Received: by mail-ot1-f97.google.com with SMTP id
 46e09a7af769-806a2a27a4bso1293949a34.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789957442; x=1790562242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MtDO03nsQsaIMwXtcPcpuIV7d+tCGeOXogwmLr5mOoY=;
 b=1RRr0IjWI5HDtZTO2pxJsZy2+ff2WCm3PZwdbWOcwOiZFriTNShFIqjHqBsZUIhBmR
 MByax9nD8Zg5MYQ4c/ckqpYWOsIy1krxButwxA/q1s6BgH1Gyu257W1n8MlSzYx1aCL1
 6OyZ59dEaCdAXkqTZGY5OvoVAoDXiuV60eTZ8bjvYfawUJ50QWfHxqb9d4f7sVEj94+Z
 V5uTMeE/WiX2f8fodMMv/tsqyTY90+IM6uZ3Daf6aIhfaUBIogBBgVKN/iobQxN+h7ng
 wf7NN2+R1EVIlTunMVoWIZf3EzEq0L87DrwVeGvbypJBavud8MvzOiMmT8V89xLgqXFa
 oiVQ==
X-Gm-Message-State: AFuF++mOErYZLiEUJ1dlC8ZLma+RyT9xp1IQmdkQDN4nfaBBQn+ODd/h
 bzcQkQpYnSoZkqEqNfL1eAZNxoFFEKbtH8dbPQR6xjgxzM/nvkK699ZOIfN+MkFh5q+E0B8a8nY
 OsHJ4eE2M0OyfGUe2yeVEuPf6ppIjwXggxaBekSlQO8+nlJe3EiUn01Ni8Sy9k9MrleMSvs4nLI
 h3ziidNxoPAVRXvHRmAJrswsxgdWSuO0SMwleuAxOJ97EK7ECyRg/qwuHz33TT8TtwENOtqh+/8
 ioRiTCHckst
X-Gm-Gg: AYBFou2QeSqhhhSZDTk5Ey+22E/0mpzudr5KIbWLEizy9MCHEdodOkCC2W3HHcBFleC
 IBAk5gQyAe03qTpDP7mPfuPi/hdo3GAs0LvcpTFIz2540hATrc7Uq89f2N2FTM1OGd4ksvRwg0g
 s55zla+W1MGQEjZ93pe22luhno6FanmnWXkzy+O6iBin/RVsRfB0jh8M8GC/wNaw9d19LEtYJak
 W2LC8z2q9eQF3Jki7i6PDaFzYi7NnReCaNweF1UruuLh8N9SaDbQUbtzlb5c18pKJnbxPYCXhGJ
 CTq0uw/D++P35uCkAvi0P1rX1OiTM6GeBbU70jE/5GreKxEZZpcG99ZEmBJak/C93pPz6bmbeS8
 SAGizwYs48nRsJEDtJNhMHxsBx9j/RSzsKR49o00gfP2BUoF8eJCcbiWJtej2El4TdkWRG1qOPy
 nYTaJjg1ghxsBWtnDnV+OpljTGRx5AqCS2X0lSHzeIRJW6Fc87HQ==
X-Received: by 2002:a05:6830:4110:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-80ddf56d87emr10702528a34.1.1789957441842; 
 Sun, 20 Sep 2026 19:24:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 46e09a7af769-8107b12c278sm3599670a34.1.2026.09.20.19.24.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 19:24:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d6df0a1e18so49009555ad.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 19:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789957440; x=1790562240; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MtDO03nsQsaIMwXtcPcpuIV7d+tCGeOXogwmLr5mOoY=;
 b=gJ0Jt4EYSKfIZANQ/Nt/K6FmJW9TMT9GJ19y+vha3XZK+R3Mm8zXr1470XhLXnGwcR
 nr3lMi7nP75QN4OI5ec8dxl4/s1LQ9VhieuqRqszTXamAlr59G+Nt+tDnAuJkwzN2VEG
 Nm90pb3+cgnWsHbv1q4gwuxjV0o1xdMK6jez0=
X-Received: by 2002:a17:903:1b4e:b0:2d8:d4cc:be68 with SMTP id
 d9443c01a7336-2ddb1c15709mr127038345ad.21.1789957439953; 
 Sun, 20 Sep 2026 19:23:59 -0700 (PDT)
X-Received: by 2002:a17:903:1b4e:b0:2d8:d4cc:be68 with SMTP id
 d9443c01a7336-2ddb1c15709mr127038145ad.21.1789957439289; 
 Sun, 20 Sep 2026 19:23:59 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311ad4esm14998517eec.5.2026.09.20.19.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 19:23:58 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2] net/bnxt: add Tx DMA error stat counter
Date: Sun, 20 Sep 2026 20:27:03 -0600
Message-ID: <20260921022703.1034465-1-Mohammad-Shuab.Siddique@broadcom.com>
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

Check the bit in bnxt_handle_tx_cp() and in the AVX2/SSE vector
Tx-completion handlers, and count occurrences in a new per-queue
tx_dma_err counter. The counter is folded into the standard oerrors
stat and also exposed as a named xstat (tx_dma_err_pkts) for
finer-grained visibility.

Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
v2:
* Added a release notes entry documenting the new tx_dma_err_pkts
  xstat, per reviewer request.
* Left the bnxt_stats_reset_op() reset of tx_dma_err as a direct
  assignment rather than an atomic store, matching the existing
  tx_mbuf_drop reset immediately above it (same file, same pattern);
  changing only the new field would be inconsistent, and the reset
  path isn't concurrent with the fast-path increments.
* NOTE: apply this patch before "net/bnxt: add support for queue size
  of 16384" (v2) -- both add a bullet under the same "Updated bnxt
  driver" release-notes heading, and the latter's context assumes
  this one's bullet is already present. Send/apply order below
  reflects this.

 doc/guides/rel_notes/release_26_11.rst |  6 ++++++
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c  |  6 ++++++
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c   |  6 ++++++
 drivers/net/bnxt/bnxt_stats.c          | 20 ++++++++++++++++++++
 drivers/net/bnxt/bnxt_stats.h          |  3 +++
 drivers/net/bnxt/bnxt_txq.h            |  1 +
 drivers/net/bnxt/bnxt_txr.c            |  6 ++++++
 7 files changed, 48 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 87c7e81bdeb..abda472f379 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,12 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================

+* **Updated bnxt driver.**
+
+  * Added a per-queue ``tx_dma_err_pkts`` xstat to report Tx completions
+    that the device flagged with a DMA error. These are also folded into
+    the standard ``oerrors`` counter.
+

 Removed Items
 -------------
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 50b3602839..7f07b0a3e1 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -743,6 +743,12 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_fetch_add_explicit(&txq->tx_dma_err, 1,
+						      rte_memory_order_relaxed);
+
 		nb_tx_pkts += txcmp->opaque;
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	} while (nb_tx_pkts < ring_mask);
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 7d455b6f56..a97ff6f5fe 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -577,6 +577,12 @@ bnxt_handle_tx_cp_vec(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_fetch_add_explicit(&txq->tx_dma_err, 1,
+						      rte_memory_order_relaxed);
+
 		if (likely(CMP_TYPE(txcmp) == TX_CMPL_TYPE_TX_L2))
 			nb_tx_pkts += txcmp->opaque;
 		else
diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index ba858710a5..52d2456b66 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -697,6 +697,8 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 
 		bnxt_stats->oerrors += rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							     rte_memory_order_relaxed);
+		bnxt_stats->oerrors += rte_atomic_load_explicit(&txq->tx_dma_err,
+							     rte_memory_order_relaxed);
 
 		if (!txq->tx_started)
 			continue;
@@ -774,6 +776,9 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		bnxt_stats->oerrors +=
 				rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							 rte_memory_order_relaxed);
+		bnxt_stats->oerrors +=
+				rte_atomic_load_explicit(&txq->tx_dma_err,
+							 rte_memory_order_relaxed);
 	}
 
 	return rc;
@@ -824,6 +829,7 @@ int bnxt_stats_reset_op(struct rte_eth_dev *eth_dev)
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 
 		txq->tx_mbuf_drop = 0;
+		txq->tx_dma_err = 0;
 	}
 
 	bnxt_clear_prev_stat(bp);
@@ -927,6 +933,7 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
 		RTE_DIM(bnxt_tx_stats_strings) + sz +
 		RTE_DIM(bnxt_rx_ext_stats_strings) +
 		RTE_DIM(bnxt_tx_ext_stats_strings) +
+		BNXT_NUM_SW_XSTATS +
 		bnxt_flow_stats_cnt(bp);
 
 	if (n < stat_count || xstats == NULL)
@@ -1049,6 +1056,14 @@ int bnxt_dev_xstats_get_op(struct rte_eth_dev *eth_dev,
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
@@ -1128,6 +1143,7 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 				sz +
 				RTE_DIM(bnxt_rx_ext_stats_strings) +
 				RTE_DIM(bnxt_tx_ext_stats_strings) +
+				BNXT_NUM_SW_XSTATS +
 				bnxt_flow_stats_cnt(bp);
 
 	if (xstats_names == NULL || size < stat_cnt)
@@ -1181,6 +1197,10 @@ int bnxt_dev_xstats_get_names_op(struct rte_eth_dev *eth_dev,
 		count++;
 	}
 
+	strlcpy(xstats_names[count].name, "tx_dma_err_pkts",
+		sizeof(xstats_names[count].name));
+	count++;
+
 	if (bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_COUNTERS &&
 	    bp->fw_cap & BNXT_FW_CAP_ADV_FLOW_MGMT &&
 	    BNXT_FLOW_XSTATS_EN(bp)) {
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
index 3fae0824d1..edd99dc84a 100644
--- a/drivers/net/bnxt/bnxt_txr.c
+++ b/drivers/net/bnxt/bnxt_txr.c
@@ -782,6 +782,12 @@ static int bnxt_handle_tx_cp(struct bnxt_tx_queue *txq)
 		if (!bnxt_cpr_cmp_valid(txcmp, raw_cons, ring_mask + 1))
 			break;
 
+		uint16_t errors_v = rte_le_to_cpu_16(txcmp->errors_v);
+
+		if (unlikely(errors_v & TX_CMPL_ERRORS_DMA_ERROR))
+			rte_atomic_fetch_add_explicit(&txq->tx_dma_err, 1,
+						      rte_memory_order_relaxed);
+
 		if (CMP_TYPE(txcmp) == CMPL_BASE_TYPE_TX_L2_COAL) {
 			struct tx_cmpl_coal *txcmp_c = (struct tx_cmpl_coal *)txcmp;
 
-- 
2.47.3

