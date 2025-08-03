Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F092C87FCB
	for <dpdk-dev@archiver.kernel.org>; Sun,  3 Aug 2025 19:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6897140430;
	Sun,  3 Aug 2025 21:42:41 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D83CD4028F
 for <dev@dpdk.org>; Sun,  3 Aug 2025 21:42:27 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D514920CA1;
 Sun,  3 Aug 2025 21:42:26 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sun, 3 Aug 2025 21:42:26 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Aman Singh <aman.deep.singh@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/3] ethdev: Improve descriptions of RX and TX offloads
Date: Sun,  3 Aug 2025 19:42:17 +0000
Message-ID: <20250803194218.683318-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250803194218.683318-1-mb@smartsharesystems.com>
References: <20250731090731.671589-1-mb@smartsharesystems.com>
 <20250803194218.683318-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Aug 2025 19:42:26.0559 (UTC)
 FILETIME=[BD9288F0:01DC04AE]
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

The descriptions of the RX and TX offloads have been improved, to
reflect that they are not only for device capability reporting, but
also for device and queue configuration purposes.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
v3:
* Add notes about conflicts between fast mbuf release and
  multi segment send. (Stephen Hemminger)
---
 lib/ethdev/rte_ethdev.h | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..724b2b149c 100644
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
@@ -1611,39 +1611,53 @@ struct rte_eth_conf {
  * Tx queue without SW lock.
  */
 #define RTE_ETH_TX_OFFLOAD_MT_LOCKFREE      RTE_BIT64(14)
-/** Device supports multi segment send. */
+/**
+ * Multi segment send.
+ *
+ * Note: If a port is configured for fast release of mbufs, the driver is expected to use an
+ * optimized Tx burst function relying on the preconditions for fast release of mbufs, which
+ * prohibits segmented packets, and thus multi segment send is unavailable.
+ * Note: If configuring a port for multi segment send, support for configuring a Tx queue for
+ * fast release of mbufs depends on the driver.
+ */
 #define RTE_ETH_TX_OFFLOAD_MULTI_SEGS       RTE_BIT64(15)
 /**
- * Device supports optimization for fast release of mbufs.
+ * Optimization for fast release of mbufs.
  * When set application must guarantee that per-queue all mbufs come from the same mempool,
  * are direct, have refcnt=1, next=NULL and nb_segs=1, as done by rte_pktmbuf_prefree_seg().
  *
+ * Note: If configuring a port for fast release of mbufs, the driver is expected to use an
+ * optimized Tx burst function relying on the preconditions for fast release of mbufs, which
+ * prohibits segmented packets, and thus multi segment send becomes unavailable.
+ * Note: If a port is configured for multi segment send, support for configuring a Tx queue
+ * for fast release of mbufs depends on the driver.
+ *
  * @see rte_mbuf_raw_free_bulk()
  */
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

