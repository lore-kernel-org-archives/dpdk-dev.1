Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A3FEE20B6
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Feb 2026 17:05:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADFBA40663;
	Fri,  6 Feb 2026 18:04:46 +0100 (CET)
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
 by mails.dpdk.org (Postfix) with ESMTP id BA21F40276
 for <dev@dpdk.org>; Fri,  6 Feb 2026 18:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
 s=office2-2020; t=1770397479;
 bh=KXDdLdaPClJN6dP631IqdbzYQ1jEjYfvesVt/HxjmrY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cvDatToURzPJJvFfFsaVMhzOWQANxiqTTB4AezDJs8+g1XHhHEI8Y0kWibep+bcM9
 l+86uP9yrIEoPMlRc/66kw0j6RJ02nNehimq0jjPRdJXmeQwZgTQAPLrD4eY+Lw3P2
 4RoJNVoDWZXteXxJQbCVFPFR8qgwuPAZ0iFrba4h2wWcxfdInfC1g42OYOJJrgyQzT
 4sVKiplKiUCtHjMn1oUMM7uuVmjeWsYa1Jwu4NslIdhe7R6AsW69TsSbIcsDvH9hoL
 MJQ4rlFBUeW2S6/9k3A1aHBEB4IiAMYES4PUjm70ZfcXEBHanWKfB39Eu9vJmmMfdE
 m3thOX4PFAtAA==
Received: from emil.cesnet.cz (gtx107.cesnet.cz [IPv6:2001:718:812:27::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by office2.cesnet.cz (Postfix) with ESMTPSA id 918F51180072;
 Fri,  6 Feb 2026 18:04:39 +0100 (CET)
From: spinler@cesnet.cz
To: dev@dpdk.org
Cc: Martin Spinler <spinler@cesnet.cz>
Subject: [PATCH 6/7] net/nfb: read total stats from macs
Date: Fri,  6 Feb 2026 18:04:34 +0100
Message-ID: <20260206170435.302184-7-spinler@cesnet.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260206170435.302184-1-spinler@cesnet.cz>
References: <20260206170435.302184-1-spinler@cesnet.cz>
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

Both the Rx and Tx MAC components in firmware provide basic statistics.
Use these statistics instead of the sum of the per-queue counters.

Signed-off-by: Martin Spinler <spinler@cesnet.cz>
---
 drivers/net/nfb/nfb_stats.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/nfb/nfb_stats.c b/drivers/net/nfb/nfb_stats.c
index 27a01c3160..4bdec17219 100644
--- a/drivers/net/nfb/nfb_stats.c
+++ b/drivers/net/nfb/nfb_stats.c
@@ -14,11 +14,11 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	uint16_t i;
 	uint16_t nb_rx = dev->data->nb_rx_queues;
 	uint16_t nb_tx = dev->data->nb_tx_queues;
-	uint64_t rx_total = 0;
-	uint64_t tx_total = 0;
-	uint64_t tx_err_total = 0;
-	uint64_t rx_total_bytes = 0;
-	uint64_t tx_total_bytes = 0;
+
+	int ret;
+	struct pmd_internals *internals = dev->process_private;
+	struct nc_rxmac_counters rx_cntrs;
+	struct nc_txmac_counters tx_cntrs;
 
 	struct ndp_rx_queue *rx_queue;
 	struct ndp_tx_queue *tx_queue;
@@ -29,8 +29,6 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			qstats->q_ipackets[i] = rx_queue->rx_pkts;
 			qstats->q_ibytes[i] = rx_queue->rx_bytes;
 		}
-		rx_total += rx_queue->rx_pkts;
-		rx_total_bytes += rx_queue->rx_bytes;
 	}
 
 	for (i = 0; i < nb_tx; i++) {
@@ -39,16 +37,28 @@ nfb_eth_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 			qstats->q_opackets[i] = tx_queue->tx_pkts;
 			qstats->q_obytes[i] = tx_queue->tx_bytes;
 		}
-		tx_total += tx_queue->tx_pkts;
-		tx_total_bytes += tx_queue->tx_bytes;
-		tx_err_total += tx_queue->err_pkts;
 	}
 
-	stats->ipackets = rx_total;
-	stats->opackets = tx_total;
-	stats->ibytes = rx_total_bytes;
-	stats->obytes = tx_total_bytes;
-	stats->oerrors = tx_err_total;
+	for (i = 0; i < internals->max_rxmac; i++) {
+		ret = nc_rxmac_read_counters(internals->rxmac[i], &rx_cntrs, NULL);
+		if (ret)
+			return -EIO;
+
+		stats->ipackets += rx_cntrs.cnt_received;
+		stats->ibytes += rx_cntrs.cnt_octets;
+		stats->ierrors += rx_cntrs.cnt_drop - rx_cntrs.cnt_overflowed;
+		stats->imissed += rx_cntrs.cnt_overflowed;
+	}
+
+	for (i = 0; i < internals->max_txmac; i++) {
+		ret = nc_txmac_read_counters(internals->txmac[i], &tx_cntrs);
+		if (ret)
+			return -EIO;
+
+		stats->opackets += tx_cntrs.cnt_sent;
+		stats->obytes += tx_cntrs.cnt_octets;
+		stats->oerrors += tx_cntrs.cnt_drop;
+	}
 	return 0;
 }
 
-- 
2.53.0

