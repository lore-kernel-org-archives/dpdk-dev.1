Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F88DCCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:16:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F112402E2;
	Mon, 27 Oct 2025 04:16:00 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id DFF73402A6;
 Mon, 27 Oct 2025 04:15:56 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534953tc9ba87f6
X-QQ-Originating-IP: /upRmX+R31TN+Ts2NsAu4aYv9AJsExyWlwyuAbylkG4=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:15:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11634615086105714048
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 02/19] net/ngbe: fix hardware statistic rx_l3_l4_xsum_error
Date: Mon, 27 Oct 2025 11:15:25 +0800
Message-Id: <20251027031542.10512-3-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSSdk1DMx7al3Ql/GWj1/8VWnoNc00fmC350bqO4FpcLgsQRMA8L+k4g
 qOsyZn1AKPKuoot/zDvBb9wwNHllQd5ZM6gY9lE+V56dbN+bRuDt/ze2U8fDCSFbJQQsy3V
 C50BXWQRnGmZ0v8WRg9Tp+EULUjRMs2grc1dQ5IOLDTWe36oqAOm6fQpspgU309gL6Vn1aP
 22Z4A5VyRPGY2c9TEOiM4gpV89E+1dSEXahfJgDMDmvetiatig6MsF3UzTbgoyDroRIUESp
 GqHSFtTGGPQzV0s5yfiFn8mNNn9KzaDLGSyGTm8zUsrAug6nNBum7X0juXSoBFkc8mREa1G
 tgCpL/xKscXKogS6sUU0ucXXWeUR+WuEiQEgGFOp2GjtCX/vJz517M0Y6bVqzxa8/kPS8Yy
 7DO9LuwWgDeaR7UlTAliu1zvAASSOQP3szFUMOtDFD5yliF1ROpGAE3tUHJZ3AU64JypIUT
 7nzo/c1Lj2/X+Hos2evhFwoooexvc5GAMXs5BqfunXvsfQjeKnM4f1FbrE4fhO5CHF9ClZo
 KO2V5ugLgBzfrgp2c0qOZk0WQJbkNIw1dksXGOyd5WbWiq4h3hbrPACiDMeFksx5ny1nkGB
 HRCTRQTCWTspblUkCmuHR2SLtPugsYnrCA3LCyAp141xXKq44bndTeAYGqSsCWNjTEY8vM/
 BvzI8F+67ZbMrfUd6il64X8PQ07gvCSEzJqJ5BAW/XHZGnGaw/NupDJwFaiJwwDRuyzx1s4
 +sOrozq4eJR6upaAwrw2uCb9K8QM9yuq2Ul18V4jThsR//mtGXn9fecCQYeBC2+HUcGR1fk
 M9nMm6CpqbBlAdThpuky7ltoF974U1vBhrxAovnmZBdRWPDMcIcaAXwULv4352+A4U0cuL/
 /EzC1lSFM5CtJab7+Br7F1hFe3z+gJW+PUd7odynW24pw1RLEdJnOMigEXx7Ch4iM0A1Fe9
 dDRn3V457TYIkNAGw/iIB6Kf10gx8FilLMBkRm4NXk6mCaPM8LzKxdUuKSbvePe+PvusUIw
 QdmHzM4KWp5aaZXqh0Yt9okio8At31yQN5KfQI9QM/GZTKyxxT
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

Fixes: 8b433d04adc9 ("net/ngbe: support device xstats")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ngbe/ngbe_ethdev.c        | 17 +++++++++++++++++
 drivers/net/ngbe/ngbe_rxtx.c          | 21 ++++++++++++++-------
 drivers/net/ngbe/ngbe_rxtx.h          |  1 +
 drivers/net/ngbe/ngbe_rxtx_vec_neon.c |  9 ++++++++-
 drivers/net/ngbe/ngbe_rxtx_vec_sse.c  |  9 ++++++++-
 5 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index adb7785498..8b9d6371fb 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -1704,6 +1704,8 @@ ngbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_hw_stats *hw_stats = NGBE_DEV_STATS(dev);
+	struct ngbe_rx_queue *rxq;
+	uint64_t rx_csum_err = 0;
 	unsigned int i, count;
 
 	ngbe_read_stats_registers(hw, hw_stats);
@@ -1717,6 +1719,13 @@ ngbe_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 
 	limit = min(limit, ngbe_xstats_calc_num(dev));
 
+	/* Rx Checksum Errors */
+	for (i = 0; i < dev->data->nb_rx_queues; i++) {
+		rxq = dev->data->rx_queues[i];
+		rx_csum_err += rxq->csum_err;
+	}
+	hw_stats->rx_l3_l4_xsum_error = rx_csum_err;
+
 	/* Extended stats from ngbe_hw_stats */
 	for (i = 0; i < limit; i++) {
 		uint32_t offset = 0;
@@ -1793,6 +1802,8 @@ ngbe_dev_xstats_reset(struct rte_eth_dev *dev)
 {
 	struct ngbe_hw *hw = ngbe_dev_hw(dev);
 	struct ngbe_hw_stats *hw_stats = NGBE_DEV_STATS(dev);
+	struct ngbe_rx_queue *rxq;
+	int i = 0;
 
 	/* HW registers are cleared on read */
 	hw->offset_loaded = 0;
@@ -1802,6 +1813,12 @@ ngbe_dev_xstats_reset(struct rte_eth_dev *dev)
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
 
diff --git a/drivers/net/ngbe/ngbe_rxtx.c b/drivers/net/ngbe/ngbe_rxtx.c
index 95e2172ee4..a60421293b 100644
--- a/drivers/net/ngbe/ngbe_rxtx.c
+++ b/drivers/net/ngbe/ngbe_rxtx.c
@@ -972,22 +972,28 @@ rx_desc_status_to_pkt_flags(uint32_t rx_status, uint64_t vlan_flags)
 }
 
 static inline uint64_t
-rx_desc_error_to_pkt_flags(uint32_t rx_status)
+rx_desc_error_to_pkt_flags(uint32_t rx_status, struct ngbe_rx_queue *rxq)
 {
 	uint64_t pkt_flags = 0;
 
 	/* checksum offload can't be disabled */
-	if (rx_status & NGBE_RXD_STAT_IPCS)
+	if (rx_status & NGBE_RXD_STAT_IPCS) {
 		pkt_flags |= (rx_status & NGBE_RXD_ERR_IPCS
 				? RTE_MBUF_F_RX_IP_CKSUM_BAD : RTE_MBUF_F_RX_IP_CKSUM_GOOD);
+		rxq->csum_err += !!(rx_status & NGBE_RXD_ERR_IPCS);
+	}
 
-	if (rx_status & NGBE_RXD_STAT_L4CS)
+	if (rx_status & NGBE_RXD_STAT_L4CS) {
 		pkt_flags |= (rx_status & NGBE_RXD_ERR_L4CS
 				? RTE_MBUF_F_RX_L4_CKSUM_BAD : RTE_MBUF_F_RX_L4_CKSUM_GOOD);
+		rxq->csum_err += !!(rx_status & NGBE_RXD_ERR_L4CS);
+	}
 
 	if (rx_status & NGBE_RXD_STAT_EIPCS &&
-	    rx_status & NGBE_RXD_ERR_EIPCS)
+	    rx_status & NGBE_RXD_ERR_EIPCS) {
 		pkt_flags |= RTE_MBUF_F_RX_OUTER_IP_CKSUM_BAD;
+		rxq->csum_err += !!(rx_status & NGBE_RXD_ERR_EIPCS);
+	}
 
 	return pkt_flags;
 }
@@ -1060,7 +1066,7 @@ ngbe_rx_scan_hw_ring(struct ngbe_rx_queue *rxq)
 			/* convert descriptor fields to rte mbuf flags */
 			pkt_flags = rx_desc_status_to_pkt_flags(s[j],
 					rxq->vlan_flags);
-			pkt_flags |= rx_desc_error_to_pkt_flags(s[j]);
+			pkt_flags |= rx_desc_error_to_pkt_flags(s[j], rxq);
 			pkt_flags |=
 				ngbe_rxd_pkt_info_to_pkt_flags(pkt_info[j]);
 			mb->ol_flags = pkt_flags;
@@ -1393,7 +1399,7 @@ ngbe_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 
 		pkt_flags = rx_desc_status_to_pkt_flags(staterr,
 					rxq->vlan_flags);
-		pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
+		pkt_flags |= rx_desc_error_to_pkt_flags(staterr, rxq);
 		pkt_flags |= ngbe_rxd_pkt_info_to_pkt_flags(pkt_info);
 		rxm->ol_flags = pkt_flags;
 		rxm->packet_type = ngbe_rxd_pkt_info_to_pkt_type(pkt_info,
@@ -1464,7 +1470,7 @@ ngbe_fill_cluster_head_buf(struct rte_mbuf *head, struct ngbe_rx_desc *desc,
 	head->vlan_tci = rte_le_to_cpu_16(desc->qw1.hi.tag);
 	pkt_info = rte_le_to_cpu_32(desc->qw0.dw0);
 	pkt_flags = rx_desc_status_to_pkt_flags(staterr, rxq->vlan_flags);
-	pkt_flags |= rx_desc_error_to_pkt_flags(staterr);
+	pkt_flags |= rx_desc_error_to_pkt_flags(staterr, rxq);
 	pkt_flags |= ngbe_rxd_pkt_info_to_pkt_flags(pkt_info);
 	head->ol_flags = pkt_flags;
 	head->packet_type = ngbe_rxd_pkt_info_to_pkt_type(pkt_info,
@@ -2266,6 +2272,7 @@ ngbe_reset_rx_queue(struct ngbe_adapter *adapter, struct ngbe_rx_queue *rxq)
 	rxq->rx_free_trigger = (uint16_t)(rxq->rx_free_thresh - 1);
 	rxq->rx_tail = 0;
 	rxq->nb_rx_hold = 0;
+	rxq->csum_err = 0;
 	rte_pktmbuf_free(rxq->pkt_first_seg);
 	rxq->pkt_first_seg = NULL;
 	rxq->pkt_last_seg = NULL;
diff --git a/drivers/net/ngbe/ngbe_rxtx.h b/drivers/net/ngbe/ngbe_rxtx.h
index 8534ec123a..7b96b837ca 100644
--- a/drivers/net/ngbe/ngbe_rxtx.h
+++ b/drivers/net/ngbe/ngbe_rxtx.h
@@ -292,6 +292,7 @@ struct ngbe_rx_queue {
 	/** hold packets to return to application */
 	struct rte_mbuf *rx_stage[RTE_PMD_NGBE_RX_MAX_BURST * 2];
 	const struct rte_memzone *mz;
+	uint64_t        csum_err;
 };
 
 /**
diff --git a/drivers/net/ngbe/ngbe_rxtx_vec_neon.c b/drivers/net/ngbe/ngbe_rxtx_vec_neon.c
index 46391c9400..79685de181 100644
--- a/drivers/net/ngbe/ngbe_rxtx_vec_neon.c
+++ b/drivers/net/ngbe/ngbe_rxtx_vec_neon.c
@@ -222,7 +222,7 @@ _recv_raw_pkts_vec(struct ngbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	volatile struct ngbe_rx_desc *rxdp;
 	struct ngbe_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
-	int pos;
+	int pos, i;
 	uint8x16_t shuf_msk = {
 		0xFF, 0xFF,
 		0xFF, 0xFF,  /* skip 32 bits pkt_type */
@@ -331,6 +331,13 @@ _recv_raw_pkts_vec(struct ngbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		desc_to_olflags_v(sterr_tmp1, sterr_tmp2, staterr, vlan_flags,
 				  &rx_pkts[pos]);
 
+		for (i = 0; i < RTE_NGBE_DESCS_PER_LOOP; i++) {
+			if (rx_pkts[pos + i]->ol_flags &
+			    (RTE_MBUF_F_RX_IP_CKSUM_BAD |
+			     RTE_MBUF_F_RX_L4_CKSUM_BAD))
+				rxq->csum_err++;
+		}
+
 		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
 		tmp = vsubq_u16(vreinterpretq_u16_u8(pkt_mb4), crc_adjust);
 		pkt_mb4 = vreinterpretq_u8_u16(tmp);
diff --git a/drivers/net/ngbe/ngbe_rxtx_vec_sse.c b/drivers/net/ngbe/ngbe_rxtx_vec_sse.c
index 19c69cdfa6..474101c600 100644
--- a/drivers/net/ngbe/ngbe_rxtx_vec_sse.c
+++ b/drivers/net/ngbe/ngbe_rxtx_vec_sse.c
@@ -244,7 +244,7 @@ _recv_raw_pkts_vec(struct ngbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 	volatile struct ngbe_rx_desc *rxdp;
 	struct ngbe_rx_entry *sw_ring;
 	uint16_t nb_pkts_recd;
-	int pos;
+	int pos, i;
 	uint64_t var;
 	__m128i shuf_msk;
 	__m128i crc_adjust = _mm_set_epi16(0, 0, 0, /* ignore non-length fields */
@@ -412,6 +412,13 @@ _recv_raw_pkts_vec(struct ngbe_rx_queue *rxq, struct rte_mbuf **rx_pkts,
 		/* set ol_flags with vlan packet type */
 		desc_to_olflags_v(descs, mbuf_init, vlan_flags, &rx_pkts[pos]);
 
+		for (i = 0; i < RTE_NGBE_DESCS_PER_LOOP; i++) {
+			if (rx_pkts[pos + i]->ol_flags &
+			    (RTE_MBUF_F_RX_IP_CKSUM_BAD |
+			     RTE_MBUF_F_RX_L4_CKSUM_BAD))
+				rxq->csum_err++;
+		}
+
 		/* D.2 pkt 3,4 set in_port/nb_seg and remove crc */
 		pkt_mb4 = _mm_add_epi16(pkt_mb4, crc_adjust);
 		pkt_mb3 = _mm_add_epi16(pkt_mb3, crc_adjust);
-- 
2.48.1

