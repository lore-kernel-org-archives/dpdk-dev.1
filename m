Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D241CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 16:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEF8B402ED;
	Sat, 30 May 2026 18:12:02 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 3E5AA4060B
 for <dev@dpdk.org>; Sat, 30 May 2026 18:11:59 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so10258877c88.0
 for <dev@dpdk.org>; Sat, 30 May 2026 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780157518;
 x=1780762318; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQyFglbpsMrrhBDItRTSYBnXLX0CIe9Ae71S3qmlzuw=;
 b=jvKru4rrnlIsyHbsQ3KQIGfTHPPxYNfbxDKSO1TkL0KVXxBQY5/hFT9coXmlgTOLkW
 q3snqc3MZ9vStKaPnEuH7+yLJpzWivtfwhoSySy77dXtZWrpGGrhWmPdd7yZppexG4mv
 cF7wrR+YOfQyPj45OYlBvux21v2bOf2NCuOy1it2XIMjdcaZH7L9/jzFzcLVjFw0oV1g
 MtoWYKPcHxs0x2ot5cX8A6K7lvkW91up2LiPtchKVda1wGejEeKLtDmNqugp58aV/Blv
 jVs+vpf6ZggvG0Ow4eLpbw3IQQPSl8tq11BYjDFAOZCaCCiWpdG5rnDqt8sslOGAqfhC
 Fy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780157518; x=1780762318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQyFglbpsMrrhBDItRTSYBnXLX0CIe9Ae71S3qmlzuw=;
 b=WqgFh+yg0uKK0/brLc9U1VlwQcw47xJvI91alQX7Qe2rhl1NKZS+G1V7pRK05jEBdC
 +epxglIQ+QeMWs/6DaWvPuW8ro9VBcq86XYCgHF2bOOg6pf7mfDof+jcvZFiVUhl9qv9
 sSV/XvsXjnY6+xdYMzbji7GUEMY9+HDGqpLedO9ZAgFOwoQd/N5adDC5hdovQDI940Aq
 kRCkr2HxGbg7WJC1Pe+BwnahIPFghKURlGR/Z5OWIJP1hkS0HXtoxZkRIGYSyfeydv2m
 by7KO3jICZitV//y1XIm2/fZgPX1ypeim6l1kq6yNRciUh6SCbU63SAYGJF7p5EUkElx
 w7dw==
X-Gm-Message-State: AOJu0Yz0YGAoDzwRPfxgY2rW4CW/kAT1gcT1aUaMo30Z0skO1N5gALTd
 hwEofwGN1VZcDT0DRFu072vFZ3YTHpo+9IzuxpBKWS63HPZSoFd2PTWM3IPsMtk2hkPgP3i/TSG
 Vd85/
X-Gm-Gg: Acq92OFvpLTQjHTjl2M/fffMZxExZHCvQWc/VRoZjNhyPjTc+d8+Np7By87iqdusN0d
 giA3Nk/jkqnz2bRb0ZfVueH0ne8xD7FzZ6M63a/oRztma67I1SyN/FBrOSyEP4zrGl0TqfJcjso
 nnYy5i/g3BXNVRpiwRoRm5YHpkCrDDlCRbpp76bcOr32VF91upHn3miTfKUba28xLdnRVE7UUEB
 5StF7SvWIjCFKfoJEaZ7kk5BBQlqKD6AfNBZXdTONu73YhYtUIxPx5ydJXhkDuAd9V6JdrKj5Ek
 KQ3I0ZGGXvGtQqFNcM4SOwy2Zunb24fweWGdl9SzVnomVAcBdZNEfLPVBAMh/IkZ8QA+I1h99q1
 ZMSn9BOPlF8jcnQo5hqHjAvYtyzpf3BQVj2JtO1AU2eqzwNZLgxBQn/RGCNNVrM7eZadXiElxsJ
 LzNru5tvF5JAiIRYzunpVe4vl4E/hRtrR/tuudC6A56ObsIplcY4JghiWjN91CCf/s745t9stW
X-Received: by 2002:a05:7022:6981:b0:127:5cd6:fa45 with SMTP id
 a92af1059eb24-137d3e0aa98mr1924478c88.14.1780157518283; 
 Sat, 30 May 2026 09:11:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69bdfsm3305616c88.9.2026.05.30.09.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 09:11:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 4/7] net/e1000: remove queue stats mapping
Date: Sat, 30 May 2026 09:09:59 -0700
Message-ID: <20260530161151.873199-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530161151.873199-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
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
index 727ea36c2b..891c810132 100644
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
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
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

