Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEADCF45DF
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 15:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D038040430;
	Tue, 13 Jan 2026 16:00:13 +0100 (CET)
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com
 [209.85.222.226])
 by mails.dpdk.org (Postfix) with ESMTP id 9D81040276
 for <dev@dpdk.org>; Tue, 13 Jan 2026 16:00:11 +0100 (CET)
Received: by mail-qk1-f226.google.com with SMTP id
 af79cd13be357-8b220ddc189so1034375085a.0
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768316411; x=1768921211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AUh0Q0eOyqGFuanUcXQD5xXW7dIj6YLoV26DItZq1Oc=;
 b=tyb29wonRn551AsbU6QOT0srqW1U7zCCvQBk8tGYP0+9I+AzSTpuVff2g0nPn50/Zk
 Fl1IHD/iZtSUUIYSKY63zlKzjF34EF8ze7bkT+09WtEV2ayG08hW6ouxs+odFVCbS07p
 ULDUF15RHmCKWVHyCJBaDIpApINWhAVoj83LVtaaLnLUSL+VW74bdg98x5babBkjANPq
 ZzN+I9rV/9296I7GN9IEIHZJKJNnNPEWWXsLWBHgzljGpZ1O8e4AWs5sp/QGzMO3jbZJ
 hHiTc4AUgns9CanTeRRPMolC+HBw8G91UQUB53+nbOZYrjZrlE91XrCZ3smJ7LHRS8iI
 CIrw==
X-Gm-Message-State: AOJu0Yy4RK/UMW00FhV8pPBsoa/OFC+bsC7+JgXYUjSPeTz8aMLGASjE
 WHSwMVZ3gRBdVoK1KZRsbYuAj6KlBKqR+bCTcZxaTwydZGRKgCbbu3WSVfV099j5L8cRDklkVC+
 a6YI6rFaobi6f4Jg+p1Lf1KnsCvaXLz2Vc+W6k7tgmbqOIdrNmRCNnSYA7BNFtI8ao1WIgNwm8/
 pJSDx6SaSKZBbo40MdTR+9WTHbg8foHVYXytTrwsKjKa7dxcjnu0Ac4okAAukqs7qxCKCTEcE3P
 UnkBQ==
X-Gm-Gg: AY/fxX6Os4F5HOEZOmrC+ZBLhhmKTWud2ZBJe4JiUTRtcr/VjNN+w/I7NePw/Jd0SnY
 go7+Ql8o3AOHmkIJtTqR9jpqEq5jwXOAaJTxywlm9tWUFepHUnOwSi8WHRdiZegHv1KrxhDPHTa
 r6CkYpRJGQi92gHZ8xscMsCfLy/uVZK9/oL7mI56Stu2uod5MQPPtzcpjc348jdwjBgAJL03F9v
 P54p5n6uF8fZ3aUZw4Mz3CfP6h2aP/QBPDsGWY3RU3IVDdqNM4gcUlE/xK9Yny0OOHxdfdbD8xG
 d+H0PkoZy4dAuFZb9aH8UQcg+iCEfGlHyOfS9TS6RLIBSNquGapYLszCtzOjFHqw/xb8wE3WHn5
 fflZadOhMKx9mK1A0PS5wvExeh2kcLrNGM9BXkezMuzWWbuqWpUo0C6zkE7xP1odkHBQzZeWRSC
 UB
X-Google-Smtp-Source: AGHT+IERUxJl+w+X+2IqgXBUzI3ASVTRxu+yeiMiQBhbeN4521gU+bZtJarMG4GdjpmkrpyQkzivl3y5T8H7
X-Received: by 2002:a05:620a:4808:b0:8b2:edc8:13d0 with SMTP id
 af79cd13be357-8c389369caemr3262057985a.17.1768316409861; 
 Tue, 13 Jan 2026 07:00:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 6a1803df08f44-89077154339sm25786536d6.26.2026.01.13.07.00.09
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Jan 2026 07:00:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-890805821c0so270535346d6.3
 for <dev@dpdk.org>; Tue, 13 Jan 2026 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1768316409; x=1768921209; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUh0Q0eOyqGFuanUcXQD5xXW7dIj6YLoV26DItZq1Oc=;
 b=Qu1GhZ8lZ3bBkbW9Axz7Rk2FvGHv8WZ4K731pS9zdLG4vm3MMRg9Xmtu1wa6GN904I
 nTQeP1E8r1SfLmwEv/dIWHpbQYdG40DefS2v7YawsqsZ3IQZXfnikTU3kNyLSR4ve0Oa
 uDV2gKardGa9QT1cLpataWL9UPnhXVOA4On9o=
X-Received: by 2002:a05:6214:485:b0:890:5770:7f7f with SMTP id
 6a1803df08f44-890841a4b0amr318572196d6.21.1768316406917; 
 Tue, 13 Jan 2026 07:00:06 -0800 (PST)
X-Received: by 2002:a05:6214:485:b0:890:5770:7f7f with SMTP id
 6a1803df08f44-890841a4b0amr318571406d6.21.1768316406230; 
 Tue, 13 Jan 2026 07:00:06 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89077235411sm166688236d6.29.2026.01.13.07.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:00:05 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	stable@dpdk.org
Subject: [PATCH v2] net/bnxt: fix the stat collection
Date: Tue, 13 Jan 2026 09:59:34 -0500
Message-ID: <20260113150002.3585120-1-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260112192354.3096196-1-kishore.padmanabha@broadcom.com>
References: <20260112192354.3096196-1-kishore.padmanabha@broadcom.com>
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

Stats collection was not aggregating stats for rings greater than
RTE_ETHDEV_QUEUE_STAT_CNTRS  when the application did not increase
the stats counters but supports more queues than the limit. Add
checks to increment aggregated stats from queues greater than
the limit. The fill functions already handle NULL qstats for
aggregate-only collection.

Bugzilla ID: 1836
Fixes: 57d5e5bc86e4 ("net/bnxt: add statistics")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

v2:
* udpate the git commit message
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

