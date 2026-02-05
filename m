Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711B6EC1E80
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:29:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD41740E2B;
	Thu,  5 Feb 2026 10:29:01 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1ADD940264;
 Thu,  5 Feb 2026 10:29:00 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id ED5AC22F1B;
 Thu,  5 Feb 2026 10:28:59 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 5 Feb 2026 10:28:56 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, techboard@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] ethdev: fix mbuf fast release requirements description
Date: Thu,  5 Feb 2026 09:28:48 +0000
Message-ID: <20260205092848.36435-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Feb 2026 09:28:56.0579 (UTC)
 FILETIME=[D9F2D530:01DC9681]
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

It was unclear if mbuf fast release could support segmented packets, or if
mbuf fast release required non-segmented packets.
This has now been investigated in detail, and it was concluded that
segmented packets can be supported with mbuf fast release still achieving
the enhanced performance.
So the description of the mbuf fast release Tx offload flag was fixed.

Furthermore, the general descriptions of the Rx and Tx offloads were
improved, to reflect that they are not only for device capability
reporting, but also for device and queue configuration purposes.

NB: If a driver does not support segmented packets with mbuf fast release,
it can check the multi segment send flag when selecting transmit function.

Fixes: 55624173bacb ("mbuf: add raw free and alloc bulk functions")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
The other description improvements were taken from patch-155635 ("[v3,2/3]
ethdev: Improve descriptions of RX and TX offloads").
---
 lib/ethdev/rte_ethdev.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index a66c2abbdb..0d8e2d0236 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -1578,7 +1578,7 @@ struct rte_eth_conf {
 };
 
 /**
- * Rx offload capabilities of a device.
+ * Rx offload capabilities/configuration of a device or queue.
  */
 #define RTE_ETH_RX_OFFLOAD_VLAN_STRIP       RTE_BIT64(0)
 #define RTE_ETH_RX_OFFLOAD_IPV4_CKSUM       RTE_BIT64(1)
@@ -1613,12 +1613,12 @@ struct rte_eth_conf {
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
@@ -1639,39 +1639,39 @@ struct rte_eth_conf {
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
- * are direct, have refcnt=1, next=NULL and nb_segs=1, as done by rte_pktmbuf_prefree_seg().
+ * have refcnt=1, and are direct.
  *
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

