Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937B8E73165
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 19:33:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA5B540647;
	Mon,  2 Feb 2026 20:33:38 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id 1A9D3402AA;
 Mon,  2 Feb 2026 20:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770060815;
 bh=X2SlewtWkMDpwjd6at9DeLq15VdcP4ZDaoigxuZlV3c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F5OTYc+thGP4nM/Y+RtD2uwz90KakCoo4vj22ATnfc9rahihPqZVBbi0MeYgx7/ST
 3ZkuMQqG4cm8urMB/nJydk1at26hs9lUSDGoeOl/u/gL78yzvrqymvMKx6jx+m9Okm
 yKc4kwpBtb+Vocdf7pJ7dQCbKC2C09IylY0nFYQaf2huGt4q7lc332qLEnyBXq6S+2
 jqkqlpxybpDybH4hwlRGAUKLea0ZxKlnqbJYWhGPNzzrRTpQnnmba7O1Z4yHperpL5
 grl3RAM3UyFxpfM7TT8mKfYRl21O7NC+DHrpjAgjtsbu/19hv0EYNU+Ovl47hqkzbI
 xq5ReSXEn1/2Q==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id D0875118007E;
 Mon,  2 Feb 2026 20:33:35 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>,
	stable@dpdk.org
Subject: [PATCH v5 2/6] net/nfb: fix bad pointer access in queue stats
Date: Mon,  2 Feb 2026 20:33:26 +0100
Message-ID: <20260202193330.3324681-3-spinler@cesnet.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202193330.3324681-1-spinler@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260202193330.3324681-1-spinler@cesnet.cz>
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

From: Martin Spinler <spinler@cesnet.cz>

The driver code has dereferenced the dev->data->rx_queues pointer
without checking for its validity.
Pointer invalidation can occur when the eth_dev_rx_queue_config
is called with set to 0, for example.

Moreover, an array of pointers (to a structure) was used like array
of structures (which worked with early dereference just for one queue).

Fixes: 6435f9a0ac22 ("net/nfb: add new netcope driver")
Cc: stable@dpdk.org

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_stats.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/nfb/nfb_stats.c b/drivers/net/nfb/nfb_stats.c
index 4ea6b7be21..27a01c3160 100644
--- a/drivers/net/nfb/nfb_stats.c
+++ b/drivers/net/nfb/nfb_stats.c
@@ -20,28 +20,28 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	uint64_t rx_total_bytes = 0;
 	uint64_t tx_total_bytes = 0;
 
-	struct ndp_rx_queue *rx_queue = *((struct ndp_rx_queue **)
-		dev->data->rx_queues);
-	struct ndp_tx_queue *tx_queue = *((struct ndp_tx_queue **)
-		dev->data->tx_queues);
+	struct ndp_rx_queue *rx_queue;
+	struct ndp_tx_queue *tx_queue;
 
 	for (i = 0; i < nb_rx; i++) {
+		rx_queue = dev->data->rx_queues[i];
 		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_ipackets[i] = rx_queue[i].rx_pkts;
-			qstats->q_ibytes[i] = rx_queue[i].rx_bytes;
+			qstats->q_ipackets[i] = rx_queue->rx_pkts;
+			qstats->q_ibytes[i] = rx_queue->rx_bytes;
 		}
-		rx_total += rx_queue[i].rx_pkts;
-		rx_total_bytes += rx_queue[i].rx_bytes;
+		rx_total += rx_queue->rx_pkts;
+		rx_total_bytes += rx_queue->rx_bytes;
 	}
 
 	for (i = 0; i < nb_tx; i++) {
+		tx_queue = dev->data->tx_queues[i];
 		if (qstats && i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			qstats->q_opackets[i] = tx_queue[i].tx_pkts;
-			qstats->q_obytes[i] = tx_queue[i].tx_bytes;
+			qstats->q_opackets[i] = tx_queue->tx_pkts;
+			qstats->q_obytes[i] = tx_queue->tx_bytes;
 		}
-		tx_total += tx_queue[i].tx_pkts;
-		tx_total_bytes += tx_queue[i].tx_bytes;
-		tx_err_total += tx_queue[i].err_pkts;
+		tx_total += tx_queue->tx_pkts;
+		tx_total_bytes += tx_queue->tx_bytes;
+		tx_err_total += tx_queue->err_pkts;
 	}
 
 	stats->ipackets = rx_total;
@@ -59,20 +59,20 @@ nfb_eth_stats_reset(struct rte_eth_dev *dev)
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
 
-	struct ndp_rx_queue *rx_queue = *((struct ndp_rx_queue **)
-		dev->data->rx_queues);
-	struct ndp_tx_queue *tx_queue = *((struct ndp_tx_queue **)
-		dev->data->tx_queues);
+	struct ndp_rx_queue *rx_queue;
+	struct ndp_tx_queue *tx_queue;
 
 	for (i = 0; i < nb_rx; i++) {
-		rx_queue[i].rx_pkts = 0;
-		rx_queue[i].rx_bytes = 0;
-		rx_queue[i].err_pkts = 0;
+		rx_queue = dev->data->rx_queues[i];
+		rx_queue->rx_pkts = 0;
+		rx_queue->rx_bytes = 0;
+		rx_queue->err_pkts = 0;
 	}
 	for (i = 0; i < nb_tx; i++) {
-		tx_queue[i].tx_pkts = 0;
-		tx_queue[i].tx_bytes = 0;
-		tx_queue[i].err_pkts = 0;
+		tx_queue = dev->data->tx_queues[i];
+		tx_queue->tx_pkts = 0;
+		tx_queue->tx_bytes = 0;
+		tx_queue->err_pkts = 0;
 	}
 
 	return 0;
-- 
2.52.0

