Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4CC5B572
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Aug 2026 20:20:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B8684014F;
	Fri, 14 Aug 2026 22:20:18 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 5378C40613
 for <dev@dpdk.org>; Fri, 14 Aug 2026 22:20:17 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1314879a91.3
 for <dev@dpdk.org>; Fri, 14 Aug 2026 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786738816;
 x=1787343616; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5JRDgVgmEoip7AE50iv30W4es2wC/+V7IqzULgL2wtk=;
 b=wROBxOU9QVtyi/VJYaGVtH78IJ61WNTNPXCtStM9+408eR1XcVuZ9E+Oyvj6PbahPM
 D3VvfBsRoXZWu2L0A3bw9vwCl0CXhg6SNoYuyg58qx6znSjrXP3ClE8eqtQ3d3QQvwIG
 uGfGTabX7aJlQZs4CfQsvL5fDuFFcCQ2xyRNIWQdS8KOrTHv6KTtxRfpVLbXLUn7HtV7
 LPLfJr0xSIM8Z0aG1ynpgw77H0xnQc90DPlSv+aJ7mOZvv8vei1u3qmv6W0Sru+IusyZ
 87f2jkG5gvXe7WYMAet537YEZkFMj/JDQEhSWxsNHyj3vEt5ZQFr3H6vwqPXOE1MB5Rn
 EC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786738816; x=1787343616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5JRDgVgmEoip7AE50iv30W4es2wC/+V7IqzULgL2wtk=;
 b=gFBJ1zPbI2+bczoiYL19SP6GM3On6sbCACiFD1R6bVF15V7sZGNQoxyGzO8M11wVJe
 bEPi7MaePMkvI8vrvEtx/+c9x37HOoiDyFaOlXRTFdyWfsoDrEPFXbGHa7deFTM+Cgp9
 qRZcNByQ6KTnpWZDu81AScRJOzvDyqsWOlihW8iEoA1OtQB2TnQD/YI1DRZEbXFn/F0B
 tmR1Tkq37HHcQy+uEvr0X72u8PrlGEfE5j2DU+EtOTw82yLNYC/Oid83p1DVMgP6sfJ2
 zGZ0pZk6b3Epuwo794ss+ZjTpzKiL6A22TI5uP4A7XftG+lRt5vBfvFNHl2dbqetOS9e
 iSZA==
X-Gm-Message-State: AOJu0YwS2o3ECkVU9u55uHBLnzO1fXvDeGKclAXnkdpFpzy/ErXi/Mn3
 dlfsOPdOILR5ZZmYaSLVB2WYssK14KBC9tBRHX2azXaFh1ZNZCUNrOl7ebFDAXPgSfp4hXPZZCa
 e8Kee
X-Gm-Gg: AR+sD13fCjY6gmo+musGZILJl5DjfHQL8cuDjaUiPKqRIIOP4Q9nwdM+lZn2FXyVuNB
 oNlYlY7W4oGzRqxaucKXaIodk/LONY52hhDEIEX5RtEdrS6FHkCn/fluw/QlQVrBmoMHVi8dBzh
 aBmt6kC4c0BoD5zcIKsX8+Zs6kqeuHMowC8YDQ+ZMLC+8ZP7zi1+kpiGwLXHfoR6mtJ6OpB65Zl
 ukvxBGz4YoV6CsAibMkrHN8aSZNQ+rN2yq1FzEw5D3mBa8pHUzWerRzqR7sNF1XgRstvTDVzlVV
 xEH8hoXlCbFzyLTAUZAH7TSfZd2HKZKq9/vUnHZDyonsLuUUTJJYY6g5N8wmMixKPllHNGmnrke
 PtDebFjED3JCQ1LUgPrU/yGK/H0DqVqU58tyPlgKjCOi+R1xJSf9Wjs26SRah+KINJZwmGj5D8Y
 qWX6t2WH14MKuvI/TGvQ6yxXeTB/fURrCM4KOpK/g5sk3higBL1T8jguj8vuktCCr9yTA5IfBep
 oY03NXt/HhwnljsX1tIbzfvrLc=
X-Received: by 2002:a17:90b:2888:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-3933b95dbb3mr10050924a91.19.1786738816415; 
 Fri, 14 Aug 2026 13:20:16 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141388bd5a7sm15553695c88.15.2026.08.14.13.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 13:20:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 06/16] net/e1000: remove queue stats mapping
Date: Fri, 14 Aug 2026 12:46:02 -0700
Message-ID: <20260814194757.329424-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814194757.329424-1-stephen@networkplumber.org>
References: <20260530161151.873199-1-stephen@networkplumber.org>
 <20260814194757.329424-1-stephen@networkplumber.org>
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

