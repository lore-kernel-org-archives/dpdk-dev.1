Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DE3C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:29:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 253ED40E24;
	Mon, 10 Feb 2025 08:27:56 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 0086B40E25
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:27:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id DD0D8A3A43; Mon, 10 Feb 2025 15:27:23 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v8 24/28] net/rnp: add support Tx TSO offload
Date: Mon, 10 Feb 2025 15:26:51 +0800
Message-Id: <1739172415-48507-25-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
References: <1739172415-48507-1-git-send-email-caowenbo@mucse.com>
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

Add support tx tso and tunnel tso.
for tunnel just support vxlan/nvgre

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 drivers/net/rnp/base/rnp_bdq_if.h |   1 +
 drivers/net/rnp/rnp.h             |   2 +-
 drivers/net/rnp/rnp_ethdev.c      |  16 ++
 drivers/net/rnp/rnp_rxtx.c        | 457 +++++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.h        |   1 +
 5 files changed, 471 insertions(+), 6 deletions(-)

diff --git a/drivers/net/rnp/base/rnp_bdq_if.h b/drivers/net/rnp/base/rnp_bdq_if.h
index a7d27bdebb..7a6d0b21ec 100644
--- a/drivers/net/rnp/base/rnp_bdq_if.h
+++ b/drivers/net/rnp/base/rnp_bdq_if.h
@@ -111,6 +111,7 @@ struct rnp_tx_desc {
 #define RNP_TX_VLAN_VALID	RTE_BIT32(15)
 /* tx data mac_ip len */
 #define RNP_TX_MAC_LEN_S	(9)
+#define RNP_TX_MAC_LEN_MASK	RTE_GENMASK32(15, 9)
 /* tx ctrl cmd */
 #define RNP_TX_LEN_PAD_S	(8)
 #define RNP_TX_OFF_MAC_PAD	(0x01UL << RNP_TX_LEN_PAD_S)
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 9cfc17b93c..5eb0676f11 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -17,7 +17,7 @@
 #define RNP_ETH_OVERHEAD \
 	(RTE_ETHER_HDR_LEN + RTE_VLAN_HLEN * 2)
 #define RNP_MAC_MAXFRM_SIZE	(9590)
-
+#define RNP_MAX_TSO_PKT		(16 * 1024)
 #define RNP_RX_MAX_MTU_SEG	(64)
 #define RNP_TX_MAX_MTU_SEG	(32)
 #define RNP_RX_MAX_SEG		(150)
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index b5d749e7a5..c43ffbe0c3 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -651,6 +651,17 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
 	/* rx support offload cap */
 	dev_info->rx_offload_capa = RNP_RX_CHECKSUM_SUPPORT;
+	/* tx support offload cap */
+	dev_info->tx_offload_capa = 0 |
+				     RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
+				     RTE_ETH_TX_OFFLOAD_UDP_CKSUM |
+				     RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
+				     RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
+				     RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+				     RTE_ETH_TX_OFFLOAD_TCP_TSO |
+				     RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
+				     RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
+				     RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	dev_info->default_rxconf = (struct rte_eth_rxconf) {
 		.rx_drop_en = 0,
 		.rx_thresh = {
@@ -1084,13 +1095,18 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 					(data->tx_queues))[i]->stats.opackets;
 			stats->q_obytes[i] = ((struct rnp_tx_queue **)
 					(data->tx_queues))[i]->stats.obytes;
+			stats->oerrors += ((struct rnp_tx_queue **)
+					(data->tx_queues))[i]->stats.errors;
 			stats->opackets += stats->q_opackets[i];
 			stats->obytes += stats->q_obytes[i];
+
 		} else {
 			stats->opackets += ((struct rnp_tx_queue **)
 					(data->tx_queues))[i]->stats.opackets;
 			stats->obytes += ((struct rnp_tx_queue **)
 					(data->tx_queues))[i]->stats.obytes;
+			stats->oerrors += ((struct rnp_tx_queue **)
+					(data->tx_queues))[i]->stats.errors;
 		}
 	}
 	stats->imissed = eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index e0b2cc7a26..209bd3690d 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -1130,6 +1130,198 @@ rnp_multiseg_clean_txq(struct rnp_tx_queue *txq)
 
 	return txq->nb_tx_free;
 }
+static inline uint32_t
+rnp_cal_tso_seg(struct rte_mbuf *mbuf)
+{
+	uint32_t hdr_len;
+
+	hdr_len = mbuf->l2_len + mbuf->l3_len + mbuf->l4_len;
+
+	hdr_len += (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) ?
+		mbuf->outer_l2_len + mbuf->outer_l3_len : 0;
+
+	return (mbuf->tso_segsz) ? mbuf->tso_segsz : hdr_len;
+}
+
+static inline bool
+rnp_need_ctrl_desc(uint64_t flags)
+{
+	static uint64_t mask = RTE_MBUF_F_TX_OUTER_IP_CKSUM |
+			       RTE_MBUF_F_TX_TCP_SEG |
+			       RTE_MBUF_F_TX_TUNNEL_VXLAN |
+			       RTE_MBUF_F_TX_TUNNEL_GRE;
+	return (flags & mask) ? 1 : 0;
+}
+
+static void
+rnp_build_tx_control_desc(struct rnp_tx_queue *txq,
+			  volatile struct rnp_tx_desc *txbd,
+			  struct rte_mbuf *mbuf)
+{
+	struct rte_gre_hdr *gre_hdr;
+	uint16_t tunnel_len = 0;
+	uint64_t flags;
+
+	*txbd = txq->zero_desc;
+	/* For outer checksum offload l2_len is
+	 * l2 (MAC) Header Length for non-tunneling pkt.
+	 * For Inner checksum offload l2_len is
+	 * Outer_L4_len + ... + Inner_L2_len(Inner L2 Header Len)
+	 * for tunneling pkt.
+	 */
+	if (!mbuf)
+		return;
+	flags = mbuf->ol_flags;
+	if (flags & RTE_MBUF_F_TX_TCP_SEG) {
+		txbd->c.qword0.mss = rnp_cal_tso_seg(mbuf);
+		txbd->c.qword0.l4_len = mbuf->l4_len;
+	}
+#define GRE_TUNNEL_KEY (4)
+#define GRE_TUNNEL_SEQ (4)
+	switch (flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+	case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+		tunnel_len = mbuf->outer_l2_len + mbuf->outer_l3_len +
+			sizeof(struct rte_udp_hdr) +
+			sizeof(struct rte_vxlan_hdr);
+		break;
+	case RTE_MBUF_F_TX_TUNNEL_GRE:
+		gre_hdr = rte_pktmbuf_mtod_offset(mbuf, struct rte_gre_hdr *,
+				mbuf->outer_l2_len + mbuf->outer_l3_len);
+		tunnel_len = mbuf->outer_l2_len + mbuf->outer_l3_len +
+				  sizeof(struct rte_gre_hdr);
+		if (gre_hdr->k)
+			tunnel_len += GRE_TUNNEL_KEY;
+		if (gre_hdr->s)
+			tunnel_len += GRE_TUNNEL_SEQ;
+		break;
+	}
+	txbd->c.qword0.tunnel_len = tunnel_len;
+	txbd->c.qword1.cmd |= RNP_CTRL_DESC;
+}
+
+static void
+rnp_padding_hdr_len(volatile struct rnp_tx_desc *txbd,
+		    struct rte_mbuf *m)
+{
+	struct rte_ether_hdr *eth_hdr = NULL;
+	struct rte_vlan_hdr *vlan_hdr = NULL;
+	int ethertype, l2_len;
+	uint16_t l3_len = 0;
+
+	if (m->l2_len == 0) {
+		eth_hdr = rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
+		l2_len = RTE_ETHER_HDR_LEN;
+		ethertype = rte_le_to_cpu_32(eth_hdr->ether_type);
+		if (ethertype == RTE_ETHER_TYPE_VLAN) {
+			vlan_hdr = (struct rte_vlan_hdr *)(eth_hdr + 1);
+			l2_len += RTE_VLAN_HLEN;
+			ethertype = vlan_hdr->eth_proto;
+		}
+		switch (ethertype) {
+		case RTE_ETHER_TYPE_IPV4:
+			l3_len = sizeof(struct rte_ipv4_hdr);
+			break;
+		case RTE_ETHER_TYPE_IPV6:
+			l3_len = sizeof(struct rte_ipv6_hdr);
+			break;
+		}
+	} else {
+		l2_len = m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK ?
+				  m->outer_l2_len : m->l2_len;
+		l3_len = m->l3_len;
+	}
+	txbd->d.mac_ip_len = l2_len << RNP_TX_MAC_LEN_S;
+	txbd->d.mac_ip_len |= l3_len;
+}
+
+static void
+rnp_check_inner_eth_hdr(struct rte_mbuf *mbuf,
+			volatile struct rnp_tx_desc *txbd)
+{
+	struct rte_ether_hdr *eth_hdr;
+	uint16_t inner_l2_offset = 0;
+	struct rte_vlan_hdr *vlan_hdr;
+	uint16_t ext_l2_len = 0;
+	uint16_t l2_offset = 0;
+	uint16_t l2_type;
+
+	inner_l2_offset = mbuf->outer_l2_len + mbuf->outer_l3_len +
+		sizeof(struct rte_udp_hdr) +
+		sizeof(struct rte_vxlan_hdr);
+	eth_hdr = rte_pktmbuf_mtod_offset(mbuf,
+			struct rte_ether_hdr *, inner_l2_offset);
+	l2_type = eth_hdr->ether_type;
+	l2_offset = txbd->d.mac_ip_len >> RNP_TX_MAC_LEN_S;
+	while (l2_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) ||
+			l2_type == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
+		vlan_hdr = (struct rte_vlan_hdr *)
+			((char *)eth_hdr + l2_offset);
+		l2_offset += RTE_VLAN_HLEN;
+		ext_l2_len += RTE_VLAN_HLEN;
+		l2_type = vlan_hdr->eth_proto;
+	}
+	txbd->d.mac_ip_len += (ext_l2_len << RNP_TX_MAC_LEN_S);
+}
+
+#define RNP_TX_L4_OFFLOAD_ALL   (RTE_MBUF_F_TX_SCTP_CKSUM | \
+				 RTE_MBUF_F_TX_TCP_CKSUM | \
+				 RTE_MBUF_F_TX_UDP_CKSUM)
+static inline void
+rnp_setup_csum_offload(struct rte_mbuf *mbuf,
+		       volatile struct rnp_tx_desc *tx_desc)
+{
+	tx_desc->d.cmd |= (mbuf->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) ?
+		RNP_TX_IP_CKSUM_EN : 0;
+	tx_desc->d.cmd |= (mbuf->ol_flags & RTE_MBUF_F_TX_IPV6) ?
+		RNP_TX_L3TYPE_IPV6 : 0;
+	tx_desc->d.cmd |= (mbuf->ol_flags & RNP_TX_L4_OFFLOAD_ALL) ?
+		RNP_TX_L4CKSUM_EN : 0;
+	switch ((mbuf->ol_flags & RTE_MBUF_F_TX_L4_MASK)) {
+	case RTE_MBUF_F_TX_TCP_CKSUM:
+		tx_desc->d.cmd |= RNP_TX_L4TYPE_TCP;
+		break;
+	case RTE_MBUF_F_TX_UDP_CKSUM:
+		tx_desc->d.cmd |= RNP_TX_L4TYPE_UDP;
+		break;
+	case RTE_MBUF_F_TX_SCTP_CKSUM:
+		tx_desc->d.cmd |= RNP_TX_L4TYPE_SCTP;
+		break;
+	}
+	tx_desc->d.mac_ip_len = mbuf->l2_len << RNP_TX_MAC_LEN_S;
+	tx_desc->d.mac_ip_len |= mbuf->l3_len;
+	if (mbuf->ol_flags & RTE_MBUF_F_TX_TCP_SEG) {
+		tx_desc->d.cmd |= RNP_TX_IP_CKSUM_EN;
+		tx_desc->d.cmd |= RNP_TX_L4CKSUM_EN;
+		tx_desc->d.cmd |= RNP_TX_L4TYPE_TCP;
+		tx_desc->d.cmd |= RNP_TX_TSO_EN;
+	}
+	if (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		/* need inner l2 l3 lens for inner checksum offload */
+		tx_desc->d.mac_ip_len &= ~RNP_TX_MAC_LEN_MASK;
+		tx_desc->d.mac_ip_len |= RTE_ETHER_HDR_LEN << RNP_TX_MAC_LEN_S;
+		rnp_check_inner_eth_hdr(mbuf, tx_desc);
+		switch (mbuf->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
+		case RTE_MBUF_F_TX_TUNNEL_VXLAN:
+			tx_desc->d.cmd |= RNP_TX_VXLAN_TUNNEL;
+			break;
+		case RTE_MBUF_F_TX_TUNNEL_GRE:
+			tx_desc->d.cmd |= RNP_TX_NVGRE_TUNNEL;
+			break;
+		}
+	}
+}
+
+static void
+rnp_setup_tx_offload(struct rnp_tx_queue *txq,
+		     volatile struct rnp_tx_desc *txbd,
+		     uint64_t flags, struct rte_mbuf *tx_pkt)
+{
+	*txbd = txq->zero_desc;
+	if (flags & RTE_MBUF_F_TX_L4_MASK ||
+	    flags & RTE_MBUF_F_TX_TCP_SEG ||
+	    flags & RTE_MBUF_F_TX_IP_CKSUM)
+		rnp_setup_csum_offload(tx_pkt, txbd);
+}
 
 static __rte_always_inline uint16_t
 rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
@@ -1140,6 +1332,8 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct rte_mbuf *tx_pkt, *m_seg;
 	uint16_t send_pkts = 0;
 	uint16_t nb_used_bd;
+	uint8_t ctx_desc_use;
+	uint8_t first_seg;
 	uint16_t tx_last;
 	uint16_t nb_tx;
 	uint16_t tx_id;
@@ -1155,17 +1349,39 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	txe = &txq->sw_ring[tx_id];
 	for (nb_tx = 0; nb_tx < nb_pkts; nb_tx++) {
 		tx_pkt = tx_pkts[nb_tx];
-		nb_used_bd = tx_pkt->nb_segs;
+		ctx_desc_use = rnp_need_ctrl_desc(tx_pkt->ol_flags);
+		nb_used_bd = tx_pkt->nb_segs + ctx_desc_use;
 		tx_last = (uint16_t)(tx_id + nb_used_bd - 1);
 		if (tx_last >= txq->attr.nb_desc)
 			tx_last = (uint16_t)(tx_last - txq->attr.nb_desc);
 		if (nb_used_bd > txq->nb_tx_free)
 			if (nb_used_bd > rnp_multiseg_clean_txq(txq))
 				break;
+		if (ctx_desc_use) {
+			txbd = &txq->tx_bdr[tx_id];
+			txn = &txq->sw_ring[txe->next_id];
+			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
+			if (txe->mbuf) {
+				rte_pktmbuf_free_seg(txe->mbuf);
+				txe->mbuf = NULL;
+			}
+			rnp_build_tx_control_desc(txq, txbd, tx_pkt);
+			txe->last_id = tx_last;
+			tx_id = txe->next_id;
+			txe = txn;
+		}
 		m_seg = tx_pkt;
+		first_seg = 1;
 		do {
 			txbd = &txq->tx_bdr[tx_id];
 			txn = &txq->sw_ring[txe->next_id];
+			if ((first_seg && m_seg->ol_flags)) {
+				rnp_setup_tx_offload(txq, txbd,
+						m_seg->ol_flags, m_seg);
+				if (!txbd->d.mac_ip_len)
+					rnp_padding_hdr_len(txbd, m_seg);
+				first_seg = 0;
+			}
 			if (txe->mbuf) {
 				rte_pktmbuf_free_seg(txe->mbuf);
 				txe->mbuf = NULL;
@@ -1201,6 +1417,231 @@ rnp_multiseg_xmit_pkts(void *_txq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	return send_pkts;
 }
 
+#define RNP_TX_TUNNEL_NOSUP_TSO_MASK (RTE_MBUF_F_TX_TUNNEL_MASK ^ \
+				     (RTE_MBUF_F_TX_TUNNEL_VXLAN | \
+				      RTE_MBUF_F_TX_TUNNEL_GRE))
+static inline bool
+rnp_check_tx_tso_valid(struct rte_mbuf *m)
+{
+	uint16_t max_seg = m->nb_segs;
+	uint32_t remain_len = 0;
+	struct rte_mbuf *m_seg;
+	uint32_t total_len = 0;
+	uint32_t limit_len = 0;
+	uint32_t tso = 0;
+
+	if (likely(!(m->ol_flags & RTE_MBUF_F_TX_TCP_SEG))) {
+		/* non tso mode */
+		if (unlikely(m->pkt_len > RNP_MAC_MAXFRM_SIZE)) {
+			return false;
+		} else if (max_seg <= RNP_TX_MAX_MTU_SEG) {
+			m_seg = m;
+			do {
+				total_len += m_seg->data_len;
+				m_seg = m_seg->next;
+			} while (m_seg != NULL);
+			if (total_len > RNP_MAC_MAXFRM_SIZE)
+				return false;
+			return true;
+		}
+	} else {
+		if (unlikely(m->ol_flags & RNP_TX_TUNNEL_NOSUP_TSO_MASK))
+			return false;
+		if (max_seg > RNP_TX_MAX_MTU_SEG)
+			return false;
+		tso = rnp_cal_tso_seg(m);
+		m_seg = m;
+		do {
+			remain_len = RTE_MAX(remain_len, m_seg->data_len % tso);
+			m_seg = m_seg->next;
+		} while (m_seg != NULL);
+		/* TSO will remain bytes because of tso
+		 * in this situation must refer the worst condition
+		 */
+		limit_len = remain_len * max_seg + tso;
+
+		if (limit_len > RNP_MAX_TSO_PKT)
+			return false;
+	}
+
+	return true;
+}
+
+static inline int
+rnp_net_cksum_flags_prepare(struct rte_mbuf *m, uint64_t ol_flags)
+{
+	struct rte_ipv4_hdr *ipv4_hdr = NULL;
+	uint64_t inner_l3_offset = m->l2_len;
+	struct rte_ipv6_hdr *ipv6_hdr;
+	struct rte_sctp_hdr *sctp_hdr;
+	struct rte_tcp_hdr *tcp_hdr;
+	struct rte_udp_hdr *udp_hdr;
+
+	if (!(ol_flags & (RTE_MBUF_F_TX_IP_CKSUM |
+			  RTE_MBUF_F_TX_L4_MASK |
+			  RTE_MBUF_F_TX_TCP_SEG)))
+		return 0;
+	if (ol_flags & (RTE_MBUF_F_TX_OUTER_IPV4 | RTE_MBUF_F_TX_OUTER_IPV6)) {
+		if ((ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
+				RTE_MBUF_F_TX_TCP_CKSUM ||
+				(ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
+			/* hardware must require out-ip cksum is zero
+			 * when vxlan-tso enable
+			 */
+			ipv4_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv4_hdr *, m->outer_l2_len);
+			ipv4_hdr->hdr_checksum = 0;
+		}
+		inner_l3_offset += m->outer_l2_len + m->outer_l3_len;
+	}
+	if (unlikely(rte_pktmbuf_data_len(m) <
+				inner_l3_offset + m->l3_len + m->l4_len))
+		return -ENOTSUP;
+	if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+		ipv4_hdr = rte_pktmbuf_mtod_offset(m, struct rte_ipv4_hdr *,
+				inner_l3_offset);
+		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
+			ipv4_hdr->hdr_checksum = 0;
+	}
+	if ((ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM) {
+		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+			udp_hdr = (struct rte_udp_hdr *)((char *)ipv4_hdr +
+					m->l3_len);
+			udp_hdr->dgram_cksum = rte_ipv4_phdr_cksum(ipv4_hdr,
+					ol_flags);
+		} else {
+			ipv6_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv6_hdr *, inner_l3_offset);
+			/* non-TSO udp */
+			udp_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_udp_hdr *,
+					inner_l3_offset + m->l3_len);
+			udp_hdr->dgram_cksum = rte_ipv6_phdr_cksum(ipv6_hdr,
+					ol_flags);
+		}
+	} else if ((ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_TCP_CKSUM ||
+			(ol_flags & RTE_MBUF_F_TX_TCP_SEG)) {
+		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+			/* non-TSO tcp or TSO */
+			tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv4_hdr + m->l3_len);
+			tcp_hdr->cksum = rte_ipv4_phdr_cksum(ipv4_hdr,
+					ol_flags);
+		} else {
+			ipv6_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv6_hdr *, inner_l3_offset);
+			/* non-TSO tcp or TSO */
+			tcp_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_tcp_hdr *,
+					inner_l3_offset + m->l3_len);
+			tcp_hdr->cksum = rte_ipv6_phdr_cksum(ipv6_hdr,
+					ol_flags);
+		}
+	} else if ((ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_SCTP_CKSUM) {
+		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+			sctp_hdr = (struct rte_sctp_hdr *)((char *)ipv4_hdr +
+					m->l3_len);
+			/* SCTP-cksm implement CRC32 */
+			sctp_hdr->cksum = 0;
+		} else {
+			ipv6_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv6_hdr *, inner_l3_offset);
+			/* NON-TSO SCTP */
+			sctp_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_sctp_hdr *,
+					inner_l3_offset + m->l3_len);
+			sctp_hdr->cksum = 0;
+		}
+	}
+	if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM && !(ol_flags &
+				(RTE_MBUF_F_TX_L4_MASK || RTE_MBUF_F_TX_TCP_SEG))) {
+		/* the hardware L4 is follow on l3 checksum.
+		 * when ol_flags set hw L3, sw l4 checksum offload,
+		 * we must prepare pseudo header to avoid
+		 * the l4 Checksum error
+		 */
+		if (ol_flags & RTE_MBUF_F_TX_IPV4) {
+			ipv4_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv4_hdr *, inner_l3_offset);
+			switch (ipv4_hdr->next_proto_id) {
+			case IPPROTO_UDP:
+				udp_hdr = (struct rte_udp_hdr *)((char *)ipv4_hdr +
+						m->l3_len);
+				udp_hdr->dgram_cksum =
+					rte_ipv4_phdr_cksum(ipv4_hdr, ol_flags);
+				break;
+			case IPPROTO_TCP:
+				tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv4_hdr +
+						m->l3_len);
+				tcp_hdr->cksum = rte_ipv4_phdr_cksum(ipv4_hdr,
+						ol_flags);
+				break;
+			default:
+				break;
+			}
+		} else {
+			ipv6_hdr = rte_pktmbuf_mtod_offset(m,
+					struct rte_ipv6_hdr *, inner_l3_offset);
+			switch (ipv6_hdr->proto) {
+			case IPPROTO_UDP:
+				udp_hdr = (struct rte_udp_hdr *)((char *)ipv6_hdr +
+						m->l3_len);
+				udp_hdr->dgram_cksum =
+					rte_ipv6_phdr_cksum(ipv6_hdr, ol_flags);
+				break;
+			case IPPROTO_TCP:
+				tcp_hdr = (struct rte_tcp_hdr *)((char *)ipv6_hdr +
+						m->l3_len);
+				tcp_hdr->cksum = rte_ipv6_phdr_cksum(ipv6_hdr,
+						ol_flags);
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static uint16_t
+rnp_tx_pkt_prepare(void *tx_queue,
+		   struct rte_mbuf **tx_pkts,
+		   uint16_t nb_pkts)
+{
+	struct rnp_tx_queue *txq = (struct rnp_tx_queue *)tx_queue;
+	struct rte_mbuf *m;
+	int i, ret;
+
+	PMD_INIT_FUNC_TRACE();
+	for (i = 0; i < nb_pkts; i++) {
+		m = tx_pkts[i];
+		if (unlikely(!rnp_check_tx_tso_valid(m))) {
+			txq->stats.errors++;
+			rte_errno = EINVAL;
+			return i;
+		}
+		if (m->nb_segs > 10) {
+			txq->stats.errors++;
+			rte_errno = EINVAL;
+			return i;
+		}
+#ifdef RTE_ETHDEV_DEBUG_TX
+		ret = rte_validate_tx_offload(m);
+		if (ret != 0) {
+			rte_errno = -ret;
+			return i;
+		}
+#endif
+		ret = rnp_net_cksum_flags_prepare(m, m->ol_flags);
+		if (ret != 0) {
+			rte_errno = -ret;
+			return i;
+		}
+	}
+
+	return i;
+}
+
 static int
 rnp_check_rx_simple_valid(struct rte_eth_dev *dev)
 {
@@ -1227,9 +1668,14 @@ int rnp_rx_func_select(struct rte_eth_dev *dev)
 static int
 rnp_check_tx_simple_valid(struct rte_eth_dev *dev, struct rnp_tx_queue *txq)
 {
-	RTE_SET_USED(txq);
+	uint64_t tx_offloads = dev->data->dev_conf.txmode.offloads;
+
+	tx_offloads |= txq->tx_offloads;
+	if (tx_offloads != RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+		return -ENOTSUP;
 	if (dev->data->scattered_rx)
 		return -ENOTSUP;
+
 	return 0;
 }
 
@@ -1243,11 +1689,12 @@ int rnp_tx_func_select(struct rte_eth_dev *dev)
 		txq = dev->data->tx_queues[idx];
 		simple_allowed = rnp_check_tx_simple_valid(dev, txq) == 0;
 	}
-	if (simple_allowed)
+	if (simple_allowed) {
 		dev->tx_pkt_burst = rnp_xmit_simple;
-	else
+	} else {
 		dev->tx_pkt_burst = rnp_multiseg_xmit_pkts;
-	dev->tx_pkt_prepare = rte_eth_pkt_burst_dummy;
+		dev->tx_pkt_prepare = rnp_tx_pkt_prepare;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/rnp/rnp_rxtx.h b/drivers/net/rnp/rnp_rxtx.h
index d26497a263..51e5d4b600 100644
--- a/drivers/net/rnp/rnp_rxtx.h
+++ b/drivers/net/rnp/rnp_rxtx.h
@@ -53,6 +53,7 @@ struct rnp_queue_stats {
 
 	uint64_t ibytes;
 	uint64_t ipackets;
+	uint64_t errors;
 };
 
 struct rnp_rx_queue {
-- 
2.34.1

