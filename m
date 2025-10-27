Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6178CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:15:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECBCF402D2;
	Mon, 27 Oct 2025 04:15:56 +0100 (CET)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by mails.dpdk.org (Postfix) with ESMTP id 8A3444003C;
 Mon, 27 Oct 2025 04:15:54 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534951t815f250f
X-QQ-Originating-IP: s3Wlbpb5r4WLqml6iNhDiKEBUJwlYNy0wS2Q4oLepX4=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14258764966893980710
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 01/19] net/txgbe: fix hardware statistic rx_l3_l4_xsum_error
Date: Mon, 27 Oct 2025 11:15:24 +0800
Message-Id: <20251027031542.10512-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OWGNuuDQspzCUvyd8qNCf3YNaX93j6WqqUuWv8p2qVLVo1iKXSYyy9Mh
 g4fZ9vPvUgtIa4n/Cl1m75rmwgSuyCzkc+ER+wnE7zsvTKP8Pxn6AbZg8muEPJn07AmupRn
 jHmAXK5W8R7qKRJG+jUuuUQMMbyzf6f484OMUgjDnuEjb9Or0MtfeAMSaI7k8qaIORcmG6k
 fE78aZMFRrN7ZUZ+4fmwLUkbMuqfRk4Gh5nwcLVXKHQBmNv2YvXgluGtTklhs4UUCvkBrke
 9fyezYKDukQOr1cbQO5pWJbZogKcFrEd3jEfuKjFYhcwsNrqEr0JOK3KTm9rWp7bzhHyXNM
 u2Qu7mLjU7OwJjPkEuLpx9Ia2U+3/or8T7nC+ZrV1if55pm4JVfkjNjQhW8wZiw1Ryv56Ml
 xR9C83rLUukpymSGWmRz6rkOPSgB6NRbtWHzUiT1ZQZmpV7gtgU+roXggWVSy81thd6n2rg
 ObzEOJ+Tjo33nwXMrT0xdX/XD8LCUuTXvyQR5phM2ukw5SZPxgFmnq+kacmXCvJEa0DquZO
 D6muUfG5WYEwScn5ltKEvGLKbj2NOub9ZP+WdbOc0mQ4gehrQCzEaQlNVXDgPK9q8oC3Cph
 bctQYfPiImhLtHEGGeuxYNZtzlniXCbsgHIl5l0bYWLiP31g5doeMfRUHV7JfNe3ZXtYi44
 uh5HK1epxrV1VCNZCroOf1jAx4kaXY3itenknqZD8AwNYXTrdsO9oP8S333Dm3m9c+Pf7Ow
 P5ghP8xTCzEVkRDDAgf3I9YFvLsIwpYMfRmzL0PwAVJyzULFY4nSpqaQB6Bc7DtWxvq0WII
 oY6bcDDrtNk2MUAgt4wV2pLb2xPKSNMzFbbWWnLxFos5VUGRFgx2ODi8cvgeVIFc6lhE7J4
 zkm3noLaMnJezbSZxNjlBB9Fzee04PaE5emin4ptVbR+C1WgyR8HYxLezvD/kUmANhqHQ5M
 L5OOhGyAmmxRXKWzCk7Ej5mmqtQjPFqQ42mQZtyScIBFayWUOGSMnIaLuRLUh9YlyjtAzsx
 Q/iPufcQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
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

Count the rx_l3_l4_xsum_error statistic in Rx path. Since this hardware
register counter is missing, resulted in the count always showing as 0
in error.

Fixes: 91fe49c87d76 ("net/txgbe: support device xstats")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/txgbe_ethdev.c        | 17 +++++++++++++++++
 drivers/net/txgbe/txgbe_rxtx.c          | 12 ++++++++----
 drivers/net/txgbe/txgbe_rxtx.h          |  1 +
 drivers/net/txgbe/txgbe_rxtx_vec_neon.c |  9 ++++++++-
 drivers/net/txgbe/txgbe_rxtx_vec_sse.c  |  9 ++++++++-
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 7b040b08c5..cbb2ea815f 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -2666,6 +2666,8 @@ txgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
+	struct txgbe_rx_queue *rxq;
+	uint64_t rx_csum_err = 0;
 	unsigned int i, count;
 
 	txgbe_read_stats_registers(hw, hw_stats);
@@ -2679,6 +2681,13 @@ txgbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 
 	limit = min(limit, txgbe_xstats_calc_num(dev));
 
+	/* Rx Checksum Errors */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		rx_csum_err += rxq->csum_err;
+	}
+	hw_stats->rx_l3_l4_xsum_error = rx_csum_err;
+
 	/* Extended stats from txgbe_hw_stats */
 	for (i = 0; i < limit; i++) {
 		uint32_t offset = 0;
@@ -2755,6 +2764,8 @@ txgbe_dev_xstats_reset(struct rte_eth_dev *dev)
 {
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	struct txgbe_hw_stats *hw_stats = TXGBE_DEV_STATS(dev);
+	struct txgbe_rx_queue *rxq;
+	int i = 0;
 
 	/* HW registers are cleared on read */
 	hw->offset_loaded = 0;
@@ -2764,6 +2775,12 @@ txgbe_dev_xstats_reset(struct rte_eth_dev *dev)
 	/* Reset software totals */
 	memset(hw_stats, 0, sizeof(*hw_stats));
 
+	/* Reset rxq checksum errors */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		rxq->csum_err = 0;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/txgbe/txgbe_rxtx.c b/drivers/net/txgbe/txgbe_rxtx.c
index 167bda8019..c606180741 100644
--- a/drivers/net/txgbe/txgbe_rxtx.c
+++ b/drivers/net/txgbe/txgbe_rxtx.c
@@ -1290,7 +1290,7 @@ rx_desc_status_to_pkt_flags(uint32_t rx_status, uint64_t vlan_flags)
 }
 
 static inline uint64_t
-rx_desc_error_to_pkt_flags(uint32_t rx_status)
+rx_desc_error_to_pkt_flags(uint32_t rx_status, struct txgbe_rx_queue *rxq)
 {
 	uint64_t pkt_flags = 0;
 
@@ -1298,16 +1298,19 @@ rx_desc_error_to_pkt_flags(uint32_t rx_status)
 	if (rx_status & TXGBE_RXD_STAT_IPCS) {
 		pkt_flags |= (rx_status & TXGBE_RXD_ERR_IPCS
 				? RTE_MBUF_F_RX_IP_CKSUM_BAD : RTE_MBUF_F_RX_IP_CKSUM_GOOD);
+		rxq->csum_err += !!(rx_status & TXGBE_RXD_ERR_IPCS);
 	}
 
 	if (rx_status & TXGBE_RXD_STAT_L4CS) {
 		pkt_flags |= (rx_status & TXGBE_RXD_ERR_L4CS
 				? RTE_MBUF_F_RX_L4_CKSUM_BAD : RTE_MBUF_F_RX_L4_CKSUM_GOOD);
+		rxq->csum_err += !!(rx_status & TXGBE_RXD_ERR_L4CS);
 	}
 
 	if (rx_status & TXGBE_RXD_STAT_EIPCS &&
 	    rx_status & TXGBE_RXD_ERR_EIPCS) {
 		pkt_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
+		rxq->csum_err += !!(rx_status & TXGBE_RXD_ERR_EIPCS);
 	}
 
 #ifdef RTE_LIB_SECURITY
@@ -1389,7 +1392,7 @@ txgbe_rx_scan_hw_ring(struct txgbe_rx_queue *rxq)
 			/* convert descriptor fields to rte mbuf flags */
 			pkt_flags = rx_desc_status_to_pkt_flags(s[j],
 					rxq->vlan_flags);
-			pkt_flags |= rx_desc_error_to_pkt_flags(s[j]);
+			pkt_flags |= rx_desc_error_to_pkt_flags(s[j], rxq);
 			pkt_flags |=
 				txgbe_rxd_pkt_info_to_pkt_flags(pkt_info[j]);
 			mb->ol_flags = pkt_flags;
@@ -1728,7 +1731,7 @@ txgbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		pkt_flags = rx_desc_status_to_pkt_flags(staterr,
 					rxq->vlan_flags);
-		pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
+		pkt_flags |= rx_desc_error_to_pkt_flags(staterr, rxq);
 		pkt_flags |= txgbe_rxd_pkt_info_to_pkt_flags(pkt_info);
 		rxm->ol_flags = pkt_flags;
 		rxm->packet_type = txgbe_rxd_pkt_info_to_pkt_type(pkt_info,
@@ -1804,7 +1807,7 @@ txgbe_fill_cluster_head_buf(struct rte_mbuf *head, struct txgbe_rx_desc *desc,
 	head->vlan_tci = rte_le_to_cpu_16(desc->qw1.hi.tag);
 	pkt_info = rte_le_to_cpu_32(desc->qw0.dw0);
 	pkt_flags = rx_desc_status_to_pkt_flags(staterr, rxq->vlan_flags);
-	pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
+	pkt_flags |= rx_desc_error_to_pkt_flags(staterr, rxq);
 	pkt_flags |= txgbe_rxd_pkt_info_to_pkt_flags(pkt_info);
 	if (TXGBE_RXD_RSCCNT(desc->qw0.dw0))
 		pkt_flags |= RTE_MBUF_F_RX_LRO;
@@ -2753,6 +2756,7 @@ txgbe_reset_rx_queue(struct txgbe_adapter *adapter, struct txgbe_rx_queue *rxq)
 	rxq->rx_free_trigger = (uint16_t)(rxq->rx_free_thresh - 1);
 	rxq->rx_tail = 0;
 	rxq->nb_rx_hold = 0;
+	rxq->csum_err = 0;
 	rte_pktmbuf_free(rxq->pkt_first_seg);
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
diff --git a/drivers/net/txgbe/txgbe_rxtx.h b/drivers/net/txgbe/txgbe_rxtx.h
index b1ac03576f..02e2617cce 100644
--- a/drivers/net/txgbe/txgbe_rxtx.h
+++ b/drivers/net/txgbe/txgbe_rxtx.h
@@ -323,6 +323,7 @@ struct txgbe_rx_queue {
 	/** hold packets to return to application */
 	struct rte_mbuf *rx_stage[RTE_PMD_TXGBE_RX_MAX_BURST * 2];
 	const struct rte_memzone *mz;
+	uint64_t            csum_err;
 };
 
 /**
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_neon.c b/drivers/net/txgbe/txgbe_rxtx_vec_neon.c
index a56e2f4164..c408a65036 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_neon.c
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_neon.c
@@ -222,7 +222,7 @@ _recv_raw_pkts_vec(struct txgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	volatile struct txgbe_rx_desc *rxdp;
 	struct txgbe_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
-	int pos;
+	int pos, i;
 	uint8x16_t shuf_msk = {
 		0xFF, 0xFF,
 		0xFF, 0xFF,  /* skip 32 bits pkt_type */
@@ -331,6 +331,13 @@ _recv_raw_pkts_vec(struct txgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		desc_to_olflags_v(sterr_tmp1, sterr_tmp2, staterr, vlan_flags,
 				  &rx_pkts[pos]);
 
+		for (i = 0; i < RTE_TXGBE_DESCS_PER_LOOP; i++) {
+			if (rx_pkts[pos + i]->ol_flags &
+			    (RTE_MBUF_F_RX_IP_CKSUM_BAD |
+			     RTE_MBUF_F_RX_L4_CKSUM_BAD))
+				rxq->csum_err++;
+		}
+
 		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
 		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb4), crc_adjust);
 		pkt_mb4 = vreinterpretq_u8_u16(tmp);
diff --git a/drivers/net/txgbe/txgbe_rxtx_vec_sse.c b/drivers/net/txgbe/txgbe_rxtx_vec_sse.c
index 8ecce33471..03c2af43d5 100644
--- a/drivers/net/txgbe/txgbe_rxtx_vec_sse.c
+++ b/drivers/net/txgbe/txgbe_rxtx_vec_sse.c
@@ -283,7 +283,7 @@ _recv_raw_pkts_vec(struct txgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 #ifdef RTE_LIB_SECURITY
 	uint8_t use_ipsec = rxq->using_ipsec;
 #endif
-	int pos;
+	int pos, i;
 	uint64_t var;
 	__m128i shuf_msk;
 	__m128i crc_adjust = _mm_set_epi16(0, 0, 0, /* ignore non-length fields */
@@ -451,6 +451,13 @@ _recv_raw_pkts_vec(struct txgbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		/* set ol_flags with vlan packet type */
 		desc_to_olflags_v(descs, mbuf_init, vlan_flags, &rx_pkts[pos]);
 
+		for (i = 0; i < RTE_TXGBE_DESCS_PER_LOOP; i++) {
+			if (rx_pkts[pos + i]->ol_flags &
+			    (RTE_MBUF_F_RX_IP_CKSUM_BAD |
+			     RTE_MBUF_F_RX_L4_CKSUM_BAD))
+				rxq->csum_err++;
+		}
+
 #ifdef RTE_LIB_SECURITY
 		if (unlikely(use_ipsec))
 			desc_to_olflags_v_ipsec(descs, &rx_pkts[pos]);
-- 
2.48.1

