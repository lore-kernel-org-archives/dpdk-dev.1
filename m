Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B4CC0219B
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Feb 2025 02:46:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16CE040A84;
	Sat,  8 Feb 2025 03:45:11 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 38C7740695
 for <dev@dpdk.org>; Sat,  8 Feb 2025 03:45:06 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 91EEEA324D; Sat,  8 Feb 2025 10:44:22 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v7 22/28] net/rnp: add supported packet types
Date: Sat,  8 Feb 2025 10:43:59 +0800
Message-Id: <1738982645-34550-23-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
References: <1738982645-34550-1-git-send-email-caowenbo@mucse.com>
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
 doc/guides/nics/rnp.rst           |  1 +
 drivers/net/rnp/base/rnp_bdq_if.h |  4 ++++
 drivers/net/rnp/rnp_rxtx.c        | 45 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index de7e72c..b81f11d 100644
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
index 3315ff7..39ea2d1 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -21,6 +21,7 @@ Features
 - Jumbo frames
 - Scatter-Gather IO support
 - Port hardware statistic
+- Packet type parsing
 
 Prerequisites
 -------------
diff --git a/drivers/net/rnp/base/rnp_bdq_if.h b/drivers/net/rnp/base/rnp_bdq_if.h
index 61a3832..a7d27bd 100644
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
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index c351fee..229c97f 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -644,6 +644,49 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
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
@@ -742,6 +785,7 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 			nmb->ol_flags = 0;
 			nmb->nb_segs = 1;
 
+			rnp_dev_rx_parse(rxq, nmb, rxbd[j]);
 			rxq->stats.ibytes += nmb->data_len;
 		}
 		for (j = 0; j < nb_dd; ++j) {
@@ -941,6 +985,7 @@ int rnp_rx_queue_start(struct rte_eth_dev *eth_dev, uint16_t qidx)
 		}
 		rxm->next = NULL;
 		first_seg->port = rxq->attr.port_id;
+		rnp_dev_rx_parse(rxq, first_seg, rxd);
 		rxq->stats.ibytes += first_seg->pkt_len;
 		/* this the end of packet the large pkt has been recv finish */
 		rte_prefetch0(RTE_PTR_ADD(first_seg->buf_addr,
-- 
1.8.3.1

