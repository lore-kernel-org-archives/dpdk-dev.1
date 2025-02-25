Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C48C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 08:44:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56A6F42E6A;
	Tue, 25 Feb 2025 09:42:08 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 94A9042E52
 for <dev@dpdk.org>; Tue, 25 Feb 2025 09:41:59 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 3C6CDAE82B; Tue, 25 Feb 2025 16:41:58 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v15 22/29] net/rnp: add supported packet types
Date: Tue, 25 Feb 2025 16:41:19 +0800
Message-Id: <1740472886-30411-23-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
References: <1740472886-30411-1-git-send-email-caowenbo@mucse.com>
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

add support parse hw packet types result.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini  |  1 +
 doc/guides/nics/rnp.rst           |  2 ++
 drivers/net/rnp/base/rnp_bdq_if.h |  4 +++
 drivers/net/rnp/rnp_ethdev.c      | 31 +++++++++++++++++++++
 drivers/net/rnp/rnp_rxtx.c        | 45 +++++++++++++++++++++++++++++++
 5 files changed, 83 insertions(+)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 00b23b0fa2..eb1c27a3d3 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -7,6 +7,7 @@
 Speed capabilities   = Y
 Link status          = Y
 Link status event    = Y
+Packet type parsing  = Y
 Basic stats          = Y
 Stats per queue      = Y
 Extended stats       = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 24e90136e7..89bf97c2fb 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -55,6 +55,7 @@ Features
 - Jumbo frames
 - Scatter-Gather IO support
 - Port hardware statistic
+- Packet type parsing
 
 Prerequisites and Pre-conditions
 --------------------------------
@@ -95,6 +96,7 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_default_mac_addr_set``
 * ``rte_eth_dev_mac_addr_add``
 * ``rte_eth_dev_mac_addr_remove``
+* ``rte_eth_dev_get_supported_ptypes``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_bdq_if.h b/drivers/net/rnp/base/rnp_bdq_if.h
index 61a38323e5..a7d27bdebb 100644
--- a/drivers/net/rnp/base/rnp_bdq_if.h
+++ b/drivers/net/rnp/base/rnp_bdq_if.h
@@ -73,6 +73,7 @@ struct rnp_tx_desc {
 #define RNP_RX_L3TYPE_IPV4	(0x00UL << RNP_RX_L3TYPE_S)
 #define RNP_RX_L3TYPE_IPV6	(0x01UL << RNP_RX_L3TYPE_S)
 #define RNP_RX_L4TYPE_S		(6)
+#define RNP_RX_L4TYPE_MASK	RTE_GENMASK32(7, 6)
 #define RNP_RX_L4TYPE_TCP	(0x01UL << RNP_RX_L4TYPE_S)
 #define RNP_RX_L4TYPE_SCTP	(0x02UL << RNP_RX_L4TYPE_S)
 #define RNP_RX_L4TYPE_UDP	(0x03UL << RNP_RX_L4TYPE_S)
@@ -83,9 +84,12 @@ struct rnp_tx_desc {
 #define RNP_RX_IN_L3_ERR	RTE_BIT32(11)
 #define RNP_RX_IN_L4_ERR	RTE_BIT32(12)
 #define RNP_RX_TUNNEL_TYPE_S	(13)
+#define RNP_RX_TUNNEL_MASK	RTE_GENMASK32(14, 13)
 #define RNP_RX_PTYPE_VXLAN	(0x01UL << RNP_RX_TUNNEL_TYPE_S)
 #define RNP_RX_PTYPE_NVGRE	(0x02UL << RNP_RX_TUNNEL_TYPE_S)
 #define RNP_RX_PTYPE_VLAN	RTE_BIT32(15)
+/* mark_data */
+#define RNP_RX_L3TYPE_VALID	RTE_BIT32(31)
 /* tx data cmd */
 #define RNP_TX_TSO_EN		RTE_BIT32(4)
 #define RNP_TX_L3TYPE_S		(5)
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 1db1ab7ce4..9b5ad90e85 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1186,6 +1186,36 @@ rnp_dev_mac_addr_remove(struct rte_eth_dev *dev,
 	rnp_clear_macaddr(port, index);
 }
 
+static uint32_t *rnp_support_ptypes_get(void)
+{
+	static uint32_t ptypes[] = {
+		RTE_PTYPE_L2_ETHER,
+		RTE_PTYPE_L2_ETHER_TIMESYNC,
+		RTE_PTYPE_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_L3_IPV6_EXT_UNKNOWN,
+		RTE_PTYPE_L4_TCP,
+		RTE_PTYPE_L4_UDP,
+		RTE_PTYPE_L4_SCTP,
+		RTE_PTYPE_TUNNEL_VXLAN,
+		RTE_PTYPE_TUNNEL_GRE,
+		RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN,
+		RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN,
+		RTE_PTYPE_INNER_L4_TCP,
+		RTE_PTYPE_INNER_L4_UDP,
+		RTE_PTYPE_INNER_L4_SCTP,
+		RTE_PTYPE_UNKNOWN,
+	};
+
+	return ptypes;
+}
+
+static const uint32_t *
+rnp_dev_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused,
+			     size_t *no_of_elements __rte_unused)
+{
+	return rnp_support_ptypes_get();
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -1223,6 +1253,7 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.mac_addr_set                 = rnp_dev_mac_addr_set,
 	.mac_addr_add                 = rnp_dev_mac_addr_add,
 	.mac_addr_remove              = rnp_dev_mac_addr_remove,
+	.dev_supported_ptypes_get     = rnp_dev_supported_ptypes_get,
 };
 
 static void
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 63c0723f70..d5790ca16e 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -639,6 +639,49 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 	return 0;
 }
 
+static __rte_always_inline void
+rnp_dev_rx_parse(struct rnp_rx_queue *rxq __rte_unused,
+		 struct rte_mbuf *m,
+		 volatile struct rnp_rx_desc rxbd)
+{
+	uint32_t mark_data = rxbd.wb.qword0.mark_data;
+	uint16_t vlan_tci = rxbd.wb.qword1.vlan_tci;
+	uint32_t cmd = rxbd.wb.qword1.cmd;
+
+	/* clear mbuf packet_type and ol_flags */
+	m->packet_type = 0;
+	m->ol_flags = 0;
+	if (mark_data & RNP_RX_L3TYPE_VALID) {
+		if (cmd & RNP_RX_L3TYPE_IPV6)
+			m->packet_type |= RTE_PTYPE_L3_IPV6;
+		else
+			m->packet_type |= RTE_PTYPE_L3_IPV4;
+	}
+	if (vlan_tci)
+		m->packet_type |= RTE_PTYPE_L2_ETHER_VLAN;
+	switch (cmd & RNP_RX_L4TYPE_MASK) {
+	case RNP_RX_L4TYPE_UDP:
+		m->packet_type |= RTE_PTYPE_L4_UDP;
+		break;
+	case RNP_RX_L4TYPE_TCP:
+		m->packet_type |= RTE_PTYPE_L4_TCP;
+		break;
+	case RNP_RX_L4TYPE_SCTP:
+		m->packet_type |= RTE_PTYPE_L4_SCTP;
+		break;
+	}
+	switch (cmd & RNP_RX_TUNNEL_MASK) {
+	case RNP_RX_PTYPE_VXLAN:
+		m->packet_type |= RTE_PTYPE_TUNNEL_VXLAN;
+		break;
+	case RNP_RX_PTYPE_NVGRE:
+		m->packet_type |= RTE_PTYPE_TUNNEL_NVGRE;
+		break;
+	}
+	if (!(m->packet_type & RTE_PTYPE_L2_MASK))
+		m->packet_type |= RTE_PTYPE_L2_ETHER;
+}
+
 #define RNP_CACHE_FETCH_RX (4)
 static __rte_always_inline int
 rnp_refill_rx_ring(struct rnp_rx_queue *rxq)
@@ -738,6 +781,7 @@ rnp_recv_pkts(void *_rxq, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			nmb->ol_flags = 0;
 			nmb->nb_segs = 1;
 
+			rnp_dev_rx_parse(rxq, nmb, rxbd[j]);
 			rxq->stats.ibytes += nmb->data_len;
 		}
 		for (j = 0; j < nb_dd; ++j) {
@@ -938,6 +982,7 @@ rnp_scattered_rx(void *rx_queue, struct rte_mbuf **rx_pkts,
 		}
 		rxm->next = NULL;
 		first_seg->port = rxq->attr.port_id;
+		rnp_dev_rx_parse(rxq, first_seg, rxd);
 		rxq->stats.ibytes += first_seg->pkt_len;
 		/* this the end of packet the large pkt has been recv finish */
 		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr,
-- 
2.25.1

