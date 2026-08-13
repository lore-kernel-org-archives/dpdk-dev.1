Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679FFC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 18:04:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A682842E59;
	Thu, 13 Aug 2026 20:04:37 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id A7DD042E69
 for <dev@dpdk.org>; Thu, 13 Aug 2026 20:04:35 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2ce98cb8165so782915ad.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 11:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786644275;
 x=1787249075; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JRDgVgmEoip7AE50iv30W4es2wC/+V7IqzULgL2wtk=;
 b=XSup6n9A+mupslrO08lWYC/qX3htE/dwF03VY+hnQLQwVU7IujHqZsbGSC7RelN0o0
 ppW0vGAJxizIU9OI9uhX0QnuI3NYFPs72OYTsOv2xDbzgUiahPBQMnUuX+FKTlr4V2wH
 rYFWqPZBCEZtgi+kOft+S9Zl4BKHaDhMT2uARzAgZ6NcRd8izQCEBrj6nutG97UueGxw
 OvoNS/0S8iibOlk8Xzke93p0t9RtTcseCdTK5KwwGPIBss1riXFm0kVKODSxjGkBXDAF
 a+rQ8kImNZqZLSq6T2rk2awLiia7FnUgX8I/C7hph2QSYt+zLUEGFn3rCn2oWSi9n2DE
 vuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786644275; x=1787249075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JRDgVgmEoip7AE50iv30W4es2wC/+V7IqzULgL2wtk=;
 b=K4H9Da16Ax1jZ8D5TfhaE6NHsNnj0P3c5Fxd9uNnOne3thuMNeOhLIgC4kRWGQt4dQ
 AMl/ThNqtlSBBve96b0YMJWPr5xiFSlDZF+bd7h5BippJx0rrPY43Dp7cld75bmniA58
 nKtligMy4X2tOWlsSF6H1ieIcS+495cD913yQOMo5L7uzjSUPXM7olrrS7VbRwVJNEG4
 2KdQgVzD0lUEOLtLKQB912Zccq7yIT1yNlqIx7IiSOha44wsotHh6o1+uGRw+Ql17URL
 VSZE162MRBg+CaRsAk3R/e7ySjeygoIeZlIGwwoo44rrDzWnL/Wc8NXQ0VZODSm6K0ZJ
 uxyA==
X-Gm-Message-State: AOJu0YyB8WayyF5AXTqbXAPjQlCXJDhYkymOyO1zfy2IxLp3p5lxTyIh
 mHNLKfKnGpjD/8/LYTOjbPDr2JHt9L1YIwmO2+XdgSBcGxCXkUlsiqPtqltbd2AIw4JUQw8hdLd
 Cx+qV
X-Gm-Gg: AR+sD13kZGVdRTQTJfhun3v6P3hQGyy3a+Vrzs7S4VWLUpVZWbLCPWvMFv8wIn1v4E3
 JVNUnJ6XNOv8aAV+yt9dGSzkASUm71oE2yN1BrDZPOxy9wEwDSIeioaHp1LRsuSL7o45Ng+65IZ
 gpfMBJEgWsQLAqDkVAhRt2mFVE9oB9H2J5sF90AqHLdK6axp56hhmV8sfMo0muYyS4zIdM9edo1
 HCGABxH7zOf2t9pDeYvR7tu1mqCXXYRXd1EpVKMlVali7nF064eyhpHThONCLTZOGomXPrvPjDT
 cmfbU5nHJAXJBcL1cDzu+mEU7Dc5rIJ0gXdaRv20tELteqm68STWjlfbCYAIwOFn7NzSkssCpF8
 kgSbCn1bE/a/uBnhVpMQlsgmC48Mu1niX/vL5WlPyljhpdc32edp6w2umSrHCe3SkBNit7TsEDh
 u+Xh/wTkyUejd75sxRxXj1AqAPlgMHji+RlU9M70H275wBBmJgt7jrSBiMyGHqcYX4EKdywADoh
 mztOJVjwttNY/q41TI4wj9aYiW+5xiYZZuidQ==
X-Received: by 2002:a17:902:f551:b0:2ce:a6a4:451b with SMTP id
 d9443c01a7336-2d37f7647a3mr76720305ad.11.1786644274788; 
 Thu, 13 Aug 2026 11:04:34 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31f7c8018cdsm3658930eec.13.2026.08.13.11.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:04:34 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 06/16] net/e1000: remove queue stats mapping
Date: Thu, 13 Aug 2026 10:55:05 -0700
Message-ID: <20260813180402.622784-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813180402.622784-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260813180402.622784-1-stephen@networkplumber.org>
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
 drivers/net/intel/e1000/igc_ethdev.c | 56 ++++------------------------
 drivers/net/intel/e1000/igc_ethdev.h |  2 -
 2 files changed, 8 insertions(+), 50 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index de35da2c36..943a479f9a 100644
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
@@ -2069,20 +2059,12 @@ eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats,
 
 	/* Get per-queue statuses */
 	if (qstats) {
-		for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
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
+		for (i = 0; i < RTE_MIN(IGC_QUEUE_PAIRS_NUM, RTE_ETHDEV_QUEUE_STAT_CNTRS); i++) {
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

