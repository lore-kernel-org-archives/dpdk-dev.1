Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04624C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 12:56:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 756934042F;
	Thu, 31 Jul 2025 14:56:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 195A6402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 14:56:11 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E7B4F20BE1;
 Thu, 31 Jul 2025 14:56:10 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 31 Jul 2025 14:56:10 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] ethdev: Reject conflicting TX offloads configuration
Date: Thu, 31 Jul 2025 12:56:03 +0000
Message-ID: <20250731125603.672860-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731125603.672860-1-mb@smartsharesystems.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250731125603.672860-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Jul 2025 12:56:10.0606 (UTC)
 FILETIME=[7D2208E0:01DC021A]
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

When an ethdev port is configured for fast mbuf release, the driver can
use a TX burst function relying on the fast mbuf release preconditions.
Thus, also configuring this port or a queue on the port for transmitting
segmented packets is prohibited.
Checks for these conflicting configurations have been added to the ethdev
library, so the drivers don't have to implement them.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/ethdev/rte_ethdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..6570517711 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -1531,6 +1531,18 @@ rte_eth_dev_configure(uint16_t port_id, uint16_t nb_rx_q, uint16_t nb_tx_q,
 		goto rollback;
 	}
 
+	/* MBUF_FAST_FREE preconditions conflict with MULTI_SEGS support. */
+	if ((dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
+	    (dev_conf->txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Ethdev port_id=%d Tx offload %s conflicts with Tx offload %s",
+			port_id,
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
+		ret = -EINVAL;
+		goto rollback;
+	}
+
 	dev->data->dev_conf.rx_adv_conf.rss_conf.rss_hf =
 		rte_eth_rss_hf_refine(dev_conf->rx_adv_conf.rss_conf.rss_hf);
 
@@ -2709,6 +2721,32 @@ rte_eth_tx_queue_setup(uint16_t port_id, uint16_t tx_queue_id,
 		return -EINVAL;
 	}
 
+	/*
+	 * If the driver uses a Tx function with MBUF_FAST_FREE preconditions,
+	 * per-queue MULTI_SEGS support is not possible.
+	 */
+	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
+			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS)) {
+		RTE_ETHDEV_LOG_LINE(ERR,
+			"Ethdev port_id=%d tx_queue_id=%d, Tx offload %s conflicts with per-port Tx offload %s",
+			port_id, tx_queue_id,
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS),
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE));
+		return -EINVAL;
+	}
+	/*
+	 * If the driver uses a Tx function with MULTI_SEGS support,
+	 * runtime support for per-queue MBUF_FAST_FREE optimization depends on the driver.
+	 */
+	if ((dev->data->dev_conf.txmode.offloads & RTE_ETH_TX_OFFLOAD_MULTI_SEGS) &&
+			(local_conf.offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE))
+		RTE_ETHDEV_LOG_LINE(DEBUG,
+			"Ethdev port_id=%d tx_queue_id=%d, Tx offload %s potential conflict with per-port Tx offload %s, "
+			"runtime support depends on the driver",
+			port_id, tx_queue_id,
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE),
+			rte_eth_dev_tx_offload_name(RTE_ETH_TX_OFFLOAD_MULTI_SEGS));
+
 	rte_ethdev_trace_txq_setup(port_id, tx_queue_id, nb_tx_desc, tx_conf);
 	return eth_err(port_id, dev->dev_ops->tx_queue_setup(dev,
 		       tx_queue_id, nb_tx_desc, socket_id, &local_conf));
-- 
2.43.0

