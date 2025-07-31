Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE63C83F17
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 09:07:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11F484026A;
	Thu, 31 Jul 2025 11:07:40 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 45C564025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 11:07:38 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id F2298209B9;
 Thu, 31 Jul 2025 11:07:37 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 31 Jul 2025 11:07:37 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: Ivan Malov <ivan.malov@arknetworks.am>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] ethdev: Reject conflicting TX offloads configuration
Date: Thu, 31 Jul 2025 09:07:31 +0000
Message-ID: <20250731090731.671589-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Jul 2025 09:07:37.0678 (UTC)
 FILETIME=[8F9746E0:01DC01FA]
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

Also, the descriptions of the RX and TX offloads have been improved, to
reflect that they are not only for device capability reporting, but also
for device and queue configuration purposes.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ethdev/rte_ethdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h | 20 ++++++++++----------
 2 files changed, 48 insertions(+), 10 deletions(-)

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
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..760a1d2675 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1550,7 +1550,7 @@ struct rte_eth_conf {
 };
 
 /**
- * Rx offload capabilities of a device.
+ * Rx offload capabilities/configuration of a device or queue.
  */
 #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
 #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
@@ -1585,12 +1585,12 @@ struct rte_eth_conf {
 			     RTE_ETH_RX_OFFLOAD_QINQ_STRIP)
 
 /*
- * If new Rx offload capabilities are defined, they also must be
+ * If new Rx offloads are defined, they also must be
  * mentioned in rte_rx_offload_names in rte_ethdev.c file.
  */
 
 /**
- * Tx offload capabilities of a device.
+ * Tx offload capabilities/configuration of a device or queue.
  */
 #define RTE_ETH_TX_OFFLOAD_VLAN_INSERT      RTE_BIT64(0)
 #define RTE_ETH_TX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
@@ -1611,10 +1611,10 @@ struct rte_eth_conf {
  * Tx queue without SW lock.
  */
 #define RTE_ETH_TX_OFFLOAD_MT_LOCKFREE      RTE_BIT64(14)
-/** Device supports multi segment send. */
+/** Multi segment send. */
 #define RTE_ETH_TX_OFFLOAD_MULTI_SEGS       RTE_BIT64(15)
 /**
- * Device supports optimization for fast release of mbufs.
+ * Optimization for fast release of mbufs.
  * When set application must guarantee that per-queue all mbufs come from the same mempool,
  * are direct, have refcnt=1, next=NULL and nb_segs=1, as done by rte_pktmbuf_prefree_seg().
  *
@@ -1623,27 +1623,27 @@ struct rte_eth_conf {
 #define RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE   RTE_BIT64(16)
 #define RTE_ETH_TX_OFFLOAD_SECURITY         RTE_BIT64(17)
 /**
- * Device supports generic UDP tunneled packet TSO.
+ * Generic UDP tunneled packet TSO.
  * Application must set RTE_MBUF_F_TX_TUNNEL_UDP and other mbuf fields required
  * for tunnel TSO.
  */
 #define RTE_ETH_TX_OFFLOAD_UDP_TNL_TSO      RTE_BIT64(18)
 /**
- * Device supports generic IP tunneled packet TSO.
+ * Generic IP tunneled packet TSO.
  * Application must set RTE_MBUF_F_TX_TUNNEL_IP and other mbuf fields required
  * for tunnel TSO.
  */
 #define RTE_ETH_TX_OFFLOAD_IP_TNL_TSO       RTE_BIT64(19)
-/** Device supports outer UDP checksum */
+/** Outer UDP checksum. Used for tunneling packet. */
 #define RTE_ETH_TX_OFFLOAD_OUTER_UDP_CKSUM  RTE_BIT64(20)
 /**
- * Device sends on time read from RTE_MBUF_DYNFIELD_TIMESTAMP_NAME
+ * Send on time read from RTE_MBUF_DYNFIELD_TIMESTAMP_NAME
  * if RTE_MBUF_DYNFLAG_TX_TIMESTAMP_NAME is set in ol_flags.
  * The mbuf field and flag are registered when the offload is configured.
  */
 #define RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP RTE_BIT64(21)
 /*
- * If new Tx offload capabilities are defined, they also must be
+ * If new Tx offloads are defined, they also must be
  * mentioned in rte_tx_offload_names in rte_ethdev.c file.
  */
 
-- 
2.43.0

