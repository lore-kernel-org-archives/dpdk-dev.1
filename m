Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43858C982D2
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Sep 2026 03:25:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AE9942FFB;
	Fri, 18 Sep 2026 05:25:10 +0200 (CEST)
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com
 [209.85.221.228])
 by mails.dpdk.org (Postfix) with ESMTP id 1DD1A42FD9
 for <dev@dpdk.org>; Fri, 18 Sep 2026 05:25:09 +0200 (CEST)
Received: by mail-vk1-f228.google.com with SMTP id
 71dfb90a1353d-5c9801823fbso93008e0c.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789701908; x=1790306708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/NWz71xEgff649Y1N103E6KAWdnbV6D8GwPEywBVBlU=;
 b=D5682jAKQRgxp/UAkokrGvscD3e94KB7p/P+K/cdUffC4OEnBV4P2+zBhwHX/Owmzu
 1BM1bp8z0MGgWECo1TjKZtX6Sb4ozYU6/xOvifr1ycE1CjayFUXwTLV8onGCNUcj+P5A
 sIicBKMKZMFI6WPDW/dLjcQhvX+w5K/lHLxT5ZD6xWYvtSR2irpsJKDg19Vw2pFuXoPx
 YV615rAe5hTr+izWDoPKxRjpqULSDqrJFFo7+1fu6rrV/VvzUv0C5sCF8y1G8O7CPVF1
 HD4LISuEtV/m2MxMTR8hjB6V3Vrb4NJ/OhER6vLgPDk+mljUnlxDPcWNVUWTD3xBp7Nz
 zzLg==
X-Gm-Message-State: AFuF++lDD2qNG1C/W451dlT11sT/62EPp7ur9P1auUTKpU3uuZPeTFRY
 rWjdwPiGpO0hcE/34OOcaWdOC7qPTowIq5oVBz8t6gBn1b90CZmLnq80/XYLwxiSxYfxOfmlmYg
 OzNDfkO7ywIs/UvQJ+MSb73pbWIqM2ndauSQw9lz2543VowscPMRBp9ZLoUxYYm4saFibZEfhpj
 lsmeSfqvpuVvoxMWKqg4MwdW8Tr/P1xCj1NscvTO4J8Q/Tl7crEch4PKDh+wnpppSFVeyczfk+f
 o1ny4wK0pur
X-Gm-Gg: AYBFou0xe8KypzOFEkjr4Hj5BLnqxEdnwOZMY7weqkHB8GB2X7gaY0qLYJxGuV8RIYQ
 f2YJPFzGhDMGj6+bnYrncJagrQyhM1JiAH209pownwsBO2jVkDcm9DREz79jaCRS21osDfUD08j
 Fw1I1AvEWeBXih7aCtf0/LBWatgIG8ghYXehkz0OftctgPwOG7i5TQ5jIUWXgNJQW63E5ixp/7l
 me4h04Gni8PW1n7S5DTMlCoRjj29jwj7s62zrhC9lQEGlQ0wGBhpTEYLs96XgqGHOeHBhDMgXDN
 QZS3CjobODynKFjSdo9dyaq7U0wcUAAq+kF7xCIWkYaoET6y7ErrwblEE1KI6HkwP7QEix6w2Jd
 h745V6hrvZVVmUdozQu1ku6x43RrwpqzC4gB9vxRnzvDlg0V9cpfzZ27k1HVAv0LgnEmVNCq80n
 R6rh208hqiswiiasykjffI+oENCQCBNeUUgXq0vgC1YViTqWtg5g==
X-Received: by 2002:a05:6102:3f8c:b0:798:8ca:3452 with SMTP id
 ada2fe7eead31-7a55af2f95bmr390850137.1.1789701908255; 
 Thu, 17 Sep 2026 20:25:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-98337dfeb9fsm154585241.6.2026.09.17.20.25.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 17 Sep 2026 20:25:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so716868a91.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 20:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789701907; x=1790306707; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/NWz71xEgff649Y1N103E6KAWdnbV6D8GwPEywBVBlU=;
 b=HRMjGLUS7j5aeXM3jr7SeIP+P/t8fapBSaJscMMLJtpajS3+9og8TnSw/Azh/NMILO
 HtS0ioaeyuDNBEx8dOF9nMvbSptTCNfNptn8HRkQHFLr2MAne5wb241heiSrIgFpeRYT
 RkZ/Cq8u5GOfZsIHGzPszPvqrUFibRVzIHnsc=
X-Received: by 2002:a17:90b:2243:b0:39d:f770:774 with SMTP id
 98e67ed59e1d1-39e54c9c1bamr2461739a91.20.1789701907011; 
 Thu, 17 Sep 2026 20:25:07 -0700 (PDT)
X-Received: by 2002:a17:90b:2243:b0:39d:f770:774 with SMTP id
 98e67ed59e1d1-39e54c9c1bamr2461697a91.20.1789701906443; 
 Thu, 17 Sep 2026 20:25:06 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c287b0293sm550500eec.24.2026.09.17.20.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:25:05 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: add Tx DMA error stat counter
Date: Thu, 17 Sep 2026 21:28:12 -0600
Message-ID: <20260918032812.763436-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
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
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c |  6 ++++++
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c  |  6 ++++++
 drivers/net/bnxt/bnxt_stats.c         | 20 ++++++++++++++++++++
 drivers/net/bnxt/bnxt_stats.h         |  3 +++
 drivers/net/bnxt/bnxt_txq.h           |  1 +
 drivers/net/bnxt/bnxt_txr.c           |  6 ++++++
 6 files changed, 42 insertions(+)

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

