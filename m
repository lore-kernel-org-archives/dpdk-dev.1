Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C5CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 12:33:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC8A4402CA;
	Mon, 20 Oct 2025 14:33:32 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8CC4A400D6;
 Mon, 20 Oct 2025 14:33:31 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 62EEE202CC;
 Mon, 20 Oct 2025 14:33:31 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 20 Oct 2025 14:33:28 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: techboard@dpdk.org,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] ethdev: revert reject conflicting TX offloads configuration
Date: Mon, 20 Oct 2025 12:33:26 +0000
Message-ID: <20251020123326.80591-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2025 12:33:28.0699 (UTC)
 FILETIME=[BCD544B0:01DC41BD]
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

This reverts commit fdb840367cf0d6abeb17b05623679b8d1ea4c902

The Tech Board has decided that the co-existence of fast mbuf release and
multi segments is unclear, and new restrictions should not be imposed
until this has been clarified.

Fixes: fdb840367cf0 ("ethdev: reject conflicting Tx offload configurations")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ethdev/rte_ethdev.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index f22139cb38..32686d99a9 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1534,18 +1534,6 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
-	/* MBUF_FAST_FREE preconditions conflict with MULTI_SEGS support. */
-	if ((dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
-	    (dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
-		RTE_ETHDEV_LOG_LINE(ERR,
-			"id=%d offload clash, %s vs %s",
-			port_id,
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
-		ret = -EINVAL;
-		goto rollback;
-	}
-
 	dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf =
 		rte_eth_rss_hf_refine(dev_conf->rx_adv_conf.rss_conf.rss_hf);
 
@@ -2724,31 +2712,6 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
-	/*
-	 * If the driver uses a Tx function with MBUF_FAST_FREE preconditions,
-	 * per-queue MULTI_SEGS support is not possible.
-	 */
-	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
-			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
-		RTE_ETHDEV_LOG_LINE(ERR,
-			"id=%d txq=%d offload clash, per-queue %s vs per-port %s",
-			port_id, tx_queue_id,
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
-		return -EINVAL;
-	}
-	/*
-	 * If the driver uses a Tx function with MULTI_SEGS support,
-	 * runtime support for per-queue MBUF_FAST_FREE optimization depends on the driver.
-	 */
-	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) &&
-			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE))
-		RTE_ETHDEV_LOG_LINE(DEBUG,
-			"id=%d txq=%d potential offload clash, per-queue %s vs per-port %s: PMD to decide",
-			port_id, tx_queue_id,
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE),
-			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS));
-
 	rte_ethdev_trace_txq_setup(port_id, tx_queue_id, nb_tx_desc, tx_conf);
 	return eth_err(port_id, dev->dev_ops->tx_queue_setup(dev,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
-- 
2.43.0

