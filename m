Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B01039882
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 02:12:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0069940A87;
	Sat, 28 Feb 2026 03:12:29 +0100 (CET)
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com
 [115.124.28.173])
 by mails.dpdk.org (Postfix) with ESMTP id 247A54025F;
 Sat, 28 Feb 2026 03:12:26 +0100 (CET)
Received: from ubuntu.localdomain(mailfrom:dimon.zhao@nebula-matrix.com
 fp:SMTPD_---.gguIgOc_1772244744 cluster:ay29) by smtp.aliyun-inc.com;
 Sat, 28 Feb 2026 10:12:24 +0800
From: Dimon Zhao <dimon.zhao@nebula-matrix.com>
To: dev@dpdk.org
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, stable@dpdk.org,
 Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>,
 Sam Chen <sam.chen@nebula-matrix.com>
Subject: [PATCH v1 1/1] net/nbl: fix queue count issue on port restart
Date: Fri, 27 Feb 2026 18:12:11 -0800
Message-Id: <20260228021211.71166-2-dimon.zhao@nebula-matrix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228021211.71166-1-dimon.zhao@nebula-matrix.com>
References: <20260228021211.71166-1-dimon.zhao@nebula-matrix.com>
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

Remove tx_ring_num and rx_ring_num from struct nbl_txrx_mgt to fix
an issue where these counts keep increasing during port stop/start cycles.

The counts were incremented in tx_queue_setup/rx_queue_setup, but never
decremented. This causes incorrect queue counts after multiple port
restarts. Since the actual queue counts are already available via
eth_dev->data->nb_tx_queues and nb_rx_queues, use those instead.

Update nbl_res_txrx_get_xstats() to use eth_dev->data->nb_rx_queues.

Fixes: 661c0ccf2512 ("net/nbl: support statistics")
Cc: stable@dpdk.org

Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
---
 drivers/net/nbl/nbl_hw/nbl_resource.h | 2 --
 drivers/net/nbl/nbl_hw/nbl_txrx.c     | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/nbl/nbl_hw/nbl_resource.h b/drivers/net/nbl/nbl_hw/nbl_resource.h
index 469c3f5827..bf5a9461f5 100644
--- a/drivers/net/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/nbl/nbl_hw/nbl_resource.h
@@ -219,8 +219,6 @@ struct nbl_txrx_mgt {
 	struct nbl_res_tx_ring **tx_rings;
 	struct nbl_res_rx_ring **rx_rings;
 	u16 queue_offset;
-	u8 tx_ring_num;
-	u8 rx_ring_num;
 };
 
 struct nbl_res_info {
diff --git a/drivers/net/nbl/nbl_hw/nbl_txrx.c b/drivers/net/nbl/nbl_hw/nbl_txrx.c
index 48f20e4f4c..f29f0a6d5b 100644
--- a/drivers/net/nbl/nbl_hw/nbl_txrx.c
+++ b/drivers/net/nbl/nbl_hw/nbl_txrx.c
@@ -212,7 +212,6 @@ static int nbl_res_txrx_start_tx_ring(void *priv,
 	eth_dev->data->tx_queues[param->queue_idx] = tx_ring;
 
 	txrx_mgt->tx_rings[param->queue_idx] = tx_ring;
-	txrx_mgt->tx_ring_num++;
 
 	*dma_addr = tx_ring->ring_phys_addr;
 
@@ -366,7 +365,6 @@ static int nbl_res_txrx_start_rx_ring(void *priv,
 	eth_dev->data->rx_queues[param->queue_idx] = rx_ring;
 
 	txrx_mgt->rx_rings[param->queue_idx] = rx_ring;
-	txrx_mgt->rx_ring_num++;
 
 	*dma_addr = rx_ring->ring_phys_addr;
 
@@ -879,7 +877,7 @@ static int nbl_res_txrx_get_xstats(void *priv, struct rte_eth_xstat *xstats,
 				   u16 need_xstats_cnt, u16 *xstats_cnt)
 {
 	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
-	struct nbl_txrx_mgt *txrx_mgt = NBL_RES_MGT_TO_TXRX_MGT(res_mgt);
+	struct rte_eth_dev *eth_dev = res_mgt->eth_dev;
 	struct nbl_res_rx_ring *rxq;
 	uint64_t rx_multi_descs = 0, rx_drop_noport = 0, rx_drop_proto = 0;
 	u64 txrx_xstats[3];
@@ -887,7 +885,7 @@ static int nbl_res_txrx_get_xstats(void *priv, struct rte_eth_xstat *xstats,
 	u16 count = *xstats_cnt;
 
 	/* todo: get eth stats from emp */
-	for (i = 0; i < txrx_mgt->rx_ring_num; i++) {
+	for (i = 0; i < eth_dev->data->nb_rx_queues; i++) {
 		rxq = NBL_RES_MGT_TO_RX_RING(res_mgt, i);
 
 		if (unlikely(rxq == NULL))
-- 
2.34.1

