Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D4C531CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 20:30:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22AB340B8D;
	Thu, 23 Jul 2026 22:29:49 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 273C440280
 for <dev@dpdk.org>; Thu, 23 Jul 2026 22:29:46 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso1445366a91.1
 for <dev@dpdk.org>; Thu, 23 Jul 2026 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784838585;
 x=1785443385; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tHcTfK3henNm7qitboSMcTFPFWTVwwxC16J0UsLhk4M=;
 b=lyiwQO03eTszlu4o5MmT9HkM6THjLEm/lTlIIUc52I1o/zLE1KMvmsnp3/Re8KdAE1
 4v/iurYgtEUAAF9TRr0pNZ9lwZiOBxABh9ofwPYiQB6ymSfm27r5Fl2S3ZETdqq0Z+Ub
 ARA9F1/4d1h2uxLi09Hs+HjhGRRYOm39B901B0tUB/E/19SyxjSDa+dNmz/c84ovCLL/
 XDNcEHU02xWvNKgBHV2DeivERhwkkweIdzNkXq5DqieRQZ00zxlpMgK6SgYBTk1xC4h6
 iwILryd9tr6u+LkG5yvTmi0sy0Xf+66JPFzLfWldqlQJqXkUWy4qAEdaB+lTrYoMd3lD
 rgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784838585; x=1785443385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tHcTfK3henNm7qitboSMcTFPFWTVwwxC16J0UsLhk4M=;
 b=me+BJiQQn7HNS0zkk4ET4wG6StMrMtWODtF6YFJ8yl21KavB7MnVH+ZNRNfAmbovqd
 Y1kf6NprZxBGFIkw3hbBumSB2VJPmUX5qj6j2YwstNw2Y+YfCb84a2liASw3YXZmornX
 oiXzyMTFSF4bWoJM/UVo3oRXJdV2Lf96nkMXVivWyALJG5W+8Hj/h7sFXtea3RNFvJno
 EIqAF5kfS+jqxSO8CtdSdMHbHLJ/ijjFQeeBJnJRkkEVsrBopKa77/q3WHpAv82k0pOZ
 rZil0cqrSo2ucGJk+H0+tXjat41GrLedW64aX13+F5VeR8fg4uiccMTW9JReUq2W7iiV
 f/Tg==
X-Gm-Message-State: AOJu0YxYX1ueNuax8DVSBLLYv+ad8aL0mwom2izH9x07In5E2peASeDW
 lmJ3veK/0fz9X+gFQL/1xFP1l0iDYuGfqekJSlVnTdvRBuGOLwbWUHKGdjPcghEkNTSKnWZHOKJ
 1U9zW
X-Gm-Gg: AR+sD134Zo4a04AU5yt+HSGOtpHhYOMFSKhnTBlC4YWeNkCpZNo/mW21i5l7Gts9e9p
 Fx4y0h7gVyAxGG9f+zh3HYcpqrxiM3sKlQGJxQbvGitdjGOyvE343KN7nRvdrh6+iv3NWogbo80
 +EHmxIG0RiK+VWJ8OJt6j9RHXs8iylwVsJEO9WRgbpmw6Upp7oSpd4976JJsTD5t/uRT5gxGUnP
 bL4+zXwigwHeydjnzLE1WhkvIid5r6ksGANoKXtiWPs2aqDVogciLL/Dt6Y592FbsOE6sQ8ekY3
 DfSZOYpaU/rOnWVDx7fevR0xDXL04dbLbi+hNUjHFbQ0lh5moonXPweQcd784EWzpceYs7ZTdCW
 WupFgo2mj28cym7dosRSOI2eiLMmrY15325unUUqRn5Mtqe+yzhElDaCPSJr3W50kmI+QVoX7kx
 xXB8jo++rqV29/rTgA5xvUSxYncPrMqToyJLpeeBPD
X-Received: by 2002:a17:90b:4c10:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-38ec653c390mr4471370a91.5.1784838585269; 
 Thu, 23 Jul 2026 13:29:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d12f267fdsm18864877c88.0.2026.07.23.13.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:29:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 5/9] net/e1000: remove queue stats mapping
Date: Thu, 23 Jul 2026 13:28:10 -0700
Message-ID: <20260723202936.378793-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723202936.378793-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260723202936.378793-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Support for queue stats mapping has been deprecated since 25.11.
Remove support for this operation in the e1000 driver.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/e1000/igc_ethdev.c | 54 ++++------------------------
 drivers/net/intel/e1000/igc_ethdev.h |  2 --
 2 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index de35da2c36..e5feea10d4 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -239,9 +239,7 @@ static int eth_igc_xstats_get_names_by_id(struct rte_eth_dev *dev,
 		const uint64_t *ids, struct rte_eth_xstat_name *xstats_names,
 		unsigned int limit);
 static int eth_igc_xstats_reset(struct rte_eth_dev *dev);
-static int
-eth_igc_queue_stats_mapping_set(struct rte_eth_dev *dev,
-	uint16_t queue_id, uint8_t stat_idx, uint8_t is_rx);
+
 static int
 eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 static int
@@ -317,7 +315,6 @@ static const struct eth_dev_ops eth_igc_ops = {
 	.xstats_get_names	= eth_igc_xstats_get_names,
 	.stats_reset		= eth_igc_xstats_reset,
 	.xstats_reset		= eth_igc_xstats_reset,
-	.queue_stats_mapping_set = eth_igc_queue_stats_mapping_set,
 	.rx_queue_intr_enable	= eth_igc_rx_queue_intr_enable,
 	.rx_queue_intr_disable	= eth_igc_rx_queue_intr_disable,
 	.flow_ctrl_get		= eth_igc_flow_ctrl_get,
@@ -1362,7 +1359,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	int i, error = 0;
+	int error = 0;
 
 	PMD_INIT_FUNC_TRACE();
 	dev->dev_ops = &eth_igc_ops;
@@ -1493,12 +1490,6 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	/* enable support intr */
 	igc_intr_other_enable(dev);
 
-	/* initiate queue status */
-	for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-		igc->txq_stats_map[i] = -1;
-		igc->rxq_stats_map[i] = -1;
-	}
-
 	igc_flow_init(dev);
 	igc_clear_all_filter(dev);
 	return 0;
@@ -2031,7 +2022,6 @@ static int
 eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
 		struct eth_queue_stats *qstats)
 {
-	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct e1000_hw_stats *stats = IGC_DEV_PRIVATE_STATS(dev);
 	struct igc_hw_queue_stats *queue_stats =
@@ -2070,19 +2060,11 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
 	/* Get per-queue statuses */
 	if (qstats) {
 		for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-			/* GET TX queue statuses */
-			int map_id = igc->txq_stats_map[i];
-			if (map_id >= 0) {
-				qstats->q_opackets[map_id] += queue_stats->pqgptc[i];
-				qstats->q_obytes[map_id] += queue_stats->pqgotc[i];
-			}
-			/* Get RX queue statuses */
-			map_id = igc->rxq_stats_map[i];
-			if (map_id >= 0) {
-				qstats->q_ipackets[map_id] += queue_stats->pqgprc[i];
-				qstats->q_ibytes[map_id] += queue_stats->pqgorc[i];
-				qstats->q_errors[map_id] += queue_stats->rqdpc[i];
-			}
+			qstats->q_opackets[i] += queue_stats->pqgptc[i];
+			qstats->q_obytes[i] += queue_stats->pqgotc[i];
+			qstats->q_ipackets[i] += queue_stats->pqgprc[i];
+			qstats->q_ibytes[i] += queue_stats->pqgorc[i];
+			qstats->q_errors[i] += queue_stats->rqdpc[i];
 		}
 	}
 
@@ -2231,28 +2213,6 @@ eth_igc_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 	}
 }
 
-static int
-eth_igc_queue_stats_mapping_set(struct rte_eth_dev *dev,
-		uint16_t queue_id, uint8_t stat_idx, uint8_t is_rx)
-{
-	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
-
-	/* check queue id is valid */
-	if (queue_id >= IGC_QUEUE_PAIRS_NUM) {
-		PMD_DRV_LOG(ERR, "queue id(%u) error, max is %u",
-			queue_id, IGC_QUEUE_PAIRS_NUM - 1);
-		return -EINVAL;
-	}
-
-	/* store the mapping status id */
-	if (is_rx)
-		igc->rxq_stats_map[queue_id] = stat_idx;
-	else
-		igc->txq_stats_map[queue_id] = stat_idx;
-
-	return 0;
-}
-
 static int
 eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
diff --git a/drivers/net/intel/e1000/igc_ethdev.h b/drivers/net/intel/e1000/igc_ethdev.h
index 7fa7877adf..96ff520da7 100644
--- a/drivers/net/intel/e1000/igc_ethdev.h
+++ b/drivers/net/intel/e1000/igc_ethdev.h
@@ -227,8 +227,6 @@ struct igc_adapter {
 	struct e1000_hw		hw;
 	struct e1000_hw_stats	stats;
 	struct igc_hw_queue_stats queue_stats;
-	int16_t txq_stats_map[IGC_QUEUE_PAIRS_NUM];
-	int16_t rxq_stats_map[IGC_QUEUE_PAIRS_NUM];
 
 	struct igc_interrupt	intr;
 	struct igc_vfta	shadow_vfta;
-- 
2.53.0

