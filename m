Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68945CD98F0
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 06:00:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E41104065B;
	Tue, 23 Jun 2026 08:00:13 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 53F194014F;
 Tue, 23 Jun 2026 08:00:10 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 389891A03CB;
 Tue, 23 Jun 2026 08:00:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 00A6A1A03D5;
 Tue, 23 Jun 2026 08:00:10 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 47100180004C;
 Tue, 23 Jun 2026 14:00:09 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 2/9] net/enetc: fix queue initialization
Date: Tue, 23 Jun 2026 11:29:57 +0530
Message-Id: <20260623060004.2187716-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260623060004.2187716-1-g.singh@nxp.com>
References: <20260622113517.1616028-1-g.singh@nxp.com>
 <20260623060004.2187716-1-g.singh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Hardware can misbehave if the user tries to reset the consumer and
producer indexes without resetting the ring.

This patch adds the ring reset step before resetting the indexes.

Fixes: 6c9c5aadc0e0 ("net/enetc: support ENETC4 queue API")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/enetc4_ethdev.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 78eba70..154fc09 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2024 NXP
+ * Copyright 2024-2026 NXP
  */
 
 #include <stdbool.h>
@@ -279,6 +279,7 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 		     const struct rte_eth_txconf *tx_conf)
 {
 	int err;
+	uint32_t tx_data;
 	struct enetc_bdr *tx_ring;
 	struct rte_eth_dev_data *data = dev->data;
 	struct enetc_eth_adapter *priv =
@@ -301,6 +302,10 @@ enetc4_tx_queue_setup(struct rte_eth_dev *dev,
 		goto fail;
 
 	tx_ring->ndev = dev;
+	/* reset queue */
+	tx_data = enetc4_txbdr_rd(&priv->hw.hw, tx_ring->index, ENETC_TBMR);
+	tx_data &= ~ENETC_TBMR_EN;
+	enetc4_txbdr_wr(&priv->hw.hw, tx_ring->index, ENETC_TBMR, tx_data);
 	enetc4_setup_txbdr(&priv->hw.hw, tx_ring);
 	data->tx_queues[queue_idx] = tx_ring;
 	tx_ring->tx_deferred_start = tx_conf->tx_deferred_start;
@@ -427,6 +432,7 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 		     struct rte_mempool *mb_pool)
 {
 	int err = 0;
+	uint32_t rx_enable;
 	struct enetc_bdr *rx_ring;
 	struct rte_eth_dev_data *data =  dev->data;
 	struct enetc_eth_adapter *adapter =
@@ -450,6 +456,10 @@ enetc4_rx_queue_setup(struct rte_eth_dev *dev,
 		goto fail;
 
 	rx_ring->ndev = dev;
+	/* reset queue */
+	rx_enable = enetc4_rxbdr_rd(&adapter->hw.hw, rx_ring->index, ENETC_RBMR);
+	rx_enable &= ~ENETC_RBMR_EN;
+	enetc4_rxbdr_wr(&adapter->hw.hw, rx_ring->index, ENETC_RBMR, rx_enable);
 	enetc4_setup_rxbdr(&adapter->hw.hw, rx_ring, mb_pool);
 	data->rx_queues[rx_queue_id] = rx_ring;
 	rx_ring->rx_deferred_start = rx_conf->rx_deferred_start;
-- 
2.25.1

