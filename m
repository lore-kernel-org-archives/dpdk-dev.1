Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13445CF45CD
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 19:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1252F402E1;
	Mon, 12 Jan 2026 20:24:04 +0100 (CET)
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com
 [209.85.214.225])
 by mails.dpdk.org (Postfix) with ESMTP id 8F17F40041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 20:24:02 +0100 (CET)
Received: by mail-pl1-f225.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so43384975ad.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 11:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768245842; x=1768850642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MM4xLALI/KfSKnk6q/QSgGXu0mrrvS1ALJu+cXyRaw0=;
 b=Vij3xSx4NE8nLW0ofHLQ6fAbF02LZp1zYyZnOs/lCX8vHONHTnYQzKevIt5MAknLnm
 gSlDNJVQR3603N1PFR1edZ6MHZuI//RByF7UgEJqo44szlW6SFBbAUlnXEasC82eFKXr
 nu25VXNCqXSr/nfiSE5PEuogkuLW0G4MXIJoDVLUNXfAgS80nSYJEfcoBnfs+cHRe47C
 1tfNn5aFleWC2o36Abdnk2dM0FnKl1wdODdo9HCxbcCA73COFy5odIpQy9Jh2kG8ddYA
 CZKhBF6c+0Sl+5B3oqJdMMCuzHujocSlTr9Cv1BzOwVWDn1uqVpSpH9tdsADYY9JQrgk
 4f0Q==
X-Gm-Message-State: AOJu0Yw07HrVNH5DdY8zNkotoZm2rGylB54snHxRs4GWhclP67dwiEd3
 3TTbzTSNXxx5ueQkE/LbUtzYbYrPK6U/F8XXk7JXZiTIV8wmRkotu7rTNGQpl91LZJTU1CjmoMx
 NBSbZWbFOM17YZHVK25p0kj2erAoz6RqhkEhdIp2pILd38MBufFkXVAdyqA2UlOzmIkxYHSUuZS
 5Ir0sX357Uo3gDuXSlWWbLHb45JnNcQn0gTPSdyd8KU4myxBCg3ilRA5GCzKkXZX6/oGlUk1U1Q
 tRYfA==
X-Gm-Gg: AY/fxX6uF7NQBwu2xOzPcLQffKjoUhyPR2tntHC2ixvZ4KNamubVvNAzNBx8NP7AeGz
 mp01s+DicKo3RIwFCeqWIPghMbwQI9+Mvo3luOXyJljo43f7/3aXqxEqMni0Uju8KrDLV/o7D8s
 s95maHZ/wWLxqxQgSCZ67WKyJjAnHCBDJJqDJY/tMdaO/X/MfvfsgVsBYVJiYUHgda4WXicxt9i
 RgpQV6HpkUHQOptjSGRjhYFECnt3cIfeJpEqyt5MNiVrbzE1AUGwgh4Yg94dZ44v8g6+43vQzju
 OKW+GqMad22wtchnXnfq405//vUMAPDqNSGHxNEYND05818D8WcmfGaoH01E1DikatwQIhGzkTc
 mhntkWbk52rZcTvJVJZLFA/ORTN/OpnAgCyCb7DJX4kIZe/fbdpxcF/XhBKvEGRQnAysRv3Gbl5
 Bl
X-Google-Smtp-Source: AGHT+IEMU6qgiVD0asf8Ruoy54034u71eD0ZOxkZ6U97DYe1RwgBbs4/0ZVmPvIrzl5yLCAvxceeUTIonxq7
X-Received: by 2002:a17:902:cecd:b0:29f:e787:2b9b with SMTP id
 d9443c01a7336-2a3ee4da376mr173048055ad.41.1768245841615; 
 Mon, 12 Jan 2026 11:24:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2a3e3c4a15bsm21527215ad.25.2026.01.12.11.24.01
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Jan 2026 11:24:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b048fc1656so19141251eec.1
 for <dev@dpdk.org>; Mon, 12 Jan 2026 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1768245839; x=1768850639; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MM4xLALI/KfSKnk6q/QSgGXu0mrrvS1ALJu+cXyRaw0=;
 b=FT6hdAEer7kFLCxzE7imDSMcG8O5lS5YrJ47qiA5pFM69cI+zaDTWDgkouHgVfCg7m
 ecXy6KmgNJOHn8f2RXnjTWr32U3ONNkhZXLbxqVCkfrROUOQ5HqCAY58SNufZFgxQo3p
 VbzSo28geP95NSUBTWQsj0J3tEO4gV+iOqdms=
X-Received: by 2002:a05:7301:606:b0:2b0:50b1:d963 with SMTP id
 5a478bee46e88-2b17d200d38mr20768496eec.3.1768245839431; 
 Mon, 12 Jan 2026 11:23:59 -0800 (PST)
X-Received: by 2002:a05:7301:606:b0:2b0:50b1:d963 with SMTP id
 5a478bee46e88-2b17d200d38mr20768453eec.3.1768245838666; 
 Mon, 12 Jan 2026 11:23:58 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1775fe27dsm14240962eec.29.2026.01.12.11.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 11:23:58 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH] net/bnxt: fix the stat collection
Date: Mon, 12 Jan 2026 14:23:51 -0500
Message-ID: <20260112192354.3096196-1-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.45.4
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

The stats collection was not aggregrating the stats for rings greater
than RTE_ETHDEV_QUEUE_STAT_CNTRS  if the application did not increase
the stats counters but supports more than the limit.
Added checks to increment the aggregated stats from queues
greater than the limit.

Bugzilla ID: 1836
Cc: stable@dpdk.org
Fixes: 57d5e5bc86e4 ("net/bnxt: add statistics")

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 drivers/net/bnxt/bnxt_stats.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_stats.c b/drivers/net/bnxt/bnxt_stats.c
index 3ed1dc8101db..88cfbaf9ff4b 100644
--- a/drivers/net/bnxt/bnxt_stats.c
+++ b/drivers/net/bnxt/bnxt_stats.c
@@ -659,7 +659,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings,
 			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
 
-	for (i = 0; i < num_q_stats; i++) {
+	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
 		struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 		struct bnxt_ring_stats_ext ring_stats = {0};
@@ -675,7 +675,8 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats, i, true);
+		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats,
+					    i < num_q_stats ? qstats : NULL, i, true);
 		bnxt_stats->rx_nombuf +=
 				rte_atomic_load_explicit(&rxq->rx_mbuf_alloc_fail,
 							 rte_memory_order_relaxed);
@@ -684,7 +685,7 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings,
 			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
 
-	for (i = 0; i < num_q_stats; i++) {
+	for (i = 0; i < bp->tx_cp_nr_rings; i++) {
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 		struct bnxt_cp_ring_info *cpr = txq->cp_ring;
 		struct bnxt_ring_stats_ext ring_stats = {0};
@@ -697,7 +698,8 @@ static int bnxt_stats_get_ext(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats, qstats, i, false);
+		bnxt_fill_rte_eth_stats_ext(bnxt_stats, &ring_stats,
+					    i < num_q_stats ? qstats : NULL, i, false);
 	}
 
 	return rc;
@@ -724,7 +726,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	num_q_stats = RTE_MIN(bp->rx_cp_nr_rings,
 			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
 
-	for (i = 0; i < num_q_stats; i++) {
+	for (i = 0; i < bp->rx_cp_nr_rings; i++) {
 		struct bnxt_rx_queue *rxq = bp->rx_queues[i];
 		struct bnxt_cp_ring_info *cpr = rxq->cp_ring;
 		struct bnxt_ring_stats ring_stats = {0};
@@ -739,7 +741,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i, true);
+		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats,
+					i < num_q_stats ? qstats : NULL, i, true);
 		bnxt_stats->rx_nombuf +=
 				rte_atomic_load_explicit(&rxq->rx_mbuf_alloc_fail,
 							 rte_memory_order_relaxed);
@@ -748,7 +751,7 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 	num_q_stats = RTE_MIN(bp->tx_cp_nr_rings,
 			      (unsigned int)RTE_ETHDEV_QUEUE_STAT_CNTRS);
 
-	for (i = 0; i < num_q_stats; i++) {
+	for (i = 0; i < bp->tx_cp_nr_rings; i++) {
 		struct bnxt_tx_queue *txq = bp->tx_queues[i];
 		struct bnxt_cp_ring_info *cpr = txq->cp_ring;
 		struct bnxt_ring_stats ring_stats = {0};
@@ -761,7 +764,8 @@ int bnxt_stats_get_op(struct rte_eth_dev *eth_dev,
 		if (unlikely(rc))
 			return rc;
 
-		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats, qstats, i, false);
+		bnxt_fill_rte_eth_stats(bnxt_stats, &ring_stats,
+					i < num_q_stats ? qstats : NULL, i, false);
 		bnxt_stats->oerrors +=
 				rte_atomic_load_explicit(&txq->tx_mbuf_drop,
 							 rte_memory_order_relaxed);
-- 
2.45.4

