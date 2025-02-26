Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7303EC021B8
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:44:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 697F940B9D;
	Wed, 26 Feb 2025 08:42:53 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id E3AD640A7D
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:45 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 4D26554B9DF; Wed, 26 Feb 2025 15:42:45 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 20/29] net/rnp: add support xstats operation
Date: Wed, 26 Feb 2025 15:42:07 +0800
Message-Id: <1740555736-19894-21-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
References: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
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

add support mac eth rx tx hw xstats.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   1 +
 doc/guides/nics/rnp.rst             |   3 +
 drivers/net/rnp/base/rnp_eth_regs.h |   4 +
 drivers/net/rnp/base/rnp_mac_regs.h |  80 ++++++++++
 drivers/net/rnp/rnp.h               |  44 ++++++
 drivers/net/rnp/rnp_ethdev.c        | 226 +++++++++++++++++++++++++++-
 6 files changed, 353 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 07caedba7a..14ff88fec1 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -9,6 +9,7 @@ Link status          = Y
 Link status event    = Y
 Basic stats          = Y
 Stats per queue      = Y
+Extended stats       = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index e796932af0..ea732c0ce5 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -105,3 +105,6 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_link_get_nowait``
 * ``rte_eth_stats_get``
 * ``rte_eth_stats_reset``
+* ``rte_eth_xstats_get``
+* ``rte_eth_xstats_reset``
+* ``rte_eth_xstats_get_names``
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 391688bd80..adac817df2 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -25,6 +25,10 @@
 #define RNP_RING_FC_THRESH(n)	_ETH_(0x8a00 + ((0x4) * (n)))
 /* ETH Statistic */
 #define RNP_ETH_RXTRANS_DROP	_ETH_(0x8904)
+#define RNP_ETH_RXSLAN_DROP	_ETH_(0x8914)
+#define RNP_ETH_RXGLAN_DROP	_ETH_(0x8918)
+#define RNP_ETH_RXIPH_E_DROP	_ETH_(0x891c)
+#define RNP_ETH_RXCKSUM_E_DROP	_ETH_(0x8920)
 #define RNP_ETH_RXTRUNC_DROP	_ETH_(0x8928)
 /* Mac Host Filter  */
 #define RNP_MAC_FCTRL		_ETH_(0x9110)
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 1ae880143d..4fd907a601 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -78,4 +78,84 @@
 /* PHY Link Status */
 #define RNP_MAC_PLS		RTE_BIT32(17)
 
+/* Mac Manage Counts */
+#define RNP_MMC_CTRL		(0x0800)
+#define RNP_MMC_RSTONRD	RTE_BIT32(2)
+/* Tx Good And Bad Bytes Base */
+#define RNP_MMC_TX_GBOCTGB	(0x0814)
+/* Tx Good And Bad Frame Num Base */
+#define RNP_MMC_TX_GBFRMB	(0x081c)
+/* Tx Good Broadcast Frame Num Base */
+#define RNP_MMC_TX_BCASTB	(0x0824)
+/* Tx Good Multicast Frame Num Base */
+#define RNP_MMC_TX_MCASTB	(0x082c)
+/* Tx 64Bytes Frame Num */
+#define RNP_MMC_TX_64_BYTESB	(0x0834)
+#define RNP_MMC_TX_65TO127_BYTESB	(0x083c)
+#define RNP_MMC_TX_128TO255_BYTEB	(0x0844)
+#define RNP_MMC_TX_256TO511_BYTEB	(0x084c)
+#define RNP_MMC_TX_512TO1023_BYTEB	(0x0854)
+#define RNP_MMC_TX_1024TOMAX_BYTEB	(0x085c)
+/* Tx Good And Bad Unicast Frame Num Base */
+#define RNP_MMC_TX_GBUCASTB		(0x0864)
+/* Tx Good And Bad Multicast Frame Num Base */
+#define RNP_MMC_TX_GBMCASTB		(0x086c)
+/* Tx Good And Bad Broadcast Frame NUM Base */
+#define RNP_MMC_TX_GBBCASTB		(0x0874)
+/* Tx Frame Underflow Error */
+#define RNP_MMC_TX_UNDRFLWB		(0x087c)
+/* Tx Good Frame Bytes Base */
+#define RNP_MMC_TX_GBYTESB		(0x0884)
+/* Tx Good Frame Num Base*/
+#define RNP_MMC_TX_GBRMB		(0x088c)
+/* Tx Good Pause Frame Num Base */
+#define RNP_MMC_TX_PAUSEB		(0x0894)
+/* Tx Good Vlan Frame Num Base */
+#define RNP_MMC_TX_VLANB		(0x089c)
+
+/* Rx Good And Bad Frames Num Base */
+#define RNP_MMC_RX_GBFRMB		(0x0900)
+/* Rx Good And Bad Frames Bytes Base */
+#define RNP_MMC_RX_GBOCTGB		(0x0908)
+/* Rx Good Framse Bytes Base */
+#define RNP_MMC_RX_GOCTGB		(0x0910)
+/* Rx Good Broadcast Frames Num Base */
+#define RNP_MMC_RX_BCASTGB		(0x0918)
+/* Rx Good Multicast Frames Num Base */
+#define RNP_MMC_RX_MCASTGB		(0x0920)
+/* Rx Crc Error Frames Num Base */
+#define RNP_MMC_RX_CRCERB		(0x0928)
+/* Rx Less Than 64Byes with Crc Err Base*/
+#define RNP_MMC_RX_RUNTERB		(0x0930)
+/* Receive Jumbo Frame Error */
+#define RNP_MMC_RX_JABBER_ERR		(0x0934)
+/* Shorter Than 64Bytes without Any Errora Base */
+#define RNP_MMC_RX_USIZEGB		(0x0938)
+/* Len Oversize 9k */
+#define RNP_MMC_RX_OSIZEGB		(0x093c)
+/* Rx 64Byes Frame Num Base */
+#define RNP_MMC_RX_64_BYTESB		(0x0940)
+/* Rx 65Bytes To 127Bytes Frame Num Base */
+#define RNP_MMC_RX_65TO127_BYTESB	(0x0948)
+/* Rx 128Bytes To 255Bytes Frame Num Base */
+#define RNP_MMC_RX_128TO255_BYTESB	(0x0950)
+/* Rx 256Bytes To 511Bytes Frame Num Base */
+#define RNP_MMC_RX_256TO511_BYTESB	(0x0958)
+/* Rx 512Bytes To 1023Bytes Frame Num Base */
+#define RNP_MMC_RX_512TO1203_BYTESB	(0x0960)
+/* Rx Len Bigger Than 1024Bytes Base */
+#define RNP_MMC_RX_1024TOMAX_BYTESB	(0x0968)
+/* Rx Unicast Frame Good Num Base */
+#define RNP_MMC_RX_UCASTGB		(0x0970)
+/* Rx Length Error Of Frame Part */
+#define RNP_MMC_RX_LENERRB		(0x0978)
+/* Rx received with a Length field not equal to the valid frame size */
+#define RNP_MMC_RX_OUTOF_RANGE		(0x0980)
+/* Rx Pause Frame Good Num Base */
+#define RNP_MMC_RX_PAUSEB		(0x0988)
+/* Rx Vlan Frame Good Num Base */
+#define RNP_MMC_RX_VLANGB		(0x0998)
+/* Rx With A Watchdog Timeout Err Frame Base */
+#define RNP_MMC_RX_WDOGERRB		(0x09a0)
+
 #endif /* _RNP_MAC_REGS_H_ */
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 2cda0ffe55..f1042e5ed8 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -111,6 +111,49 @@ struct rnp_proc_priv {
 struct rnp_hw_eth_stats {
 	uint64_t rx_trans_drop;         /* rx eth to dma fifo full drop */
 	uint64_t rx_trunc_drop;         /* rx mac to eth to host copy fifo full drop */
+	uint64_t rx_glen_drop;          /* pkts length bigger than hw limit */
+	uint64_t rx_slen_drop;          /* pkts length less than hw limit */
+	uint64_t rx_cksum_e_drop;       /* rx cksum error pkts drop */
+	uint64_t rx_iph_e_drop;         /* rx ip header error drop */
+};
+
+struct rnp_hw_mac_stats {
+	uint64_t rx_all_pkts;     /* Include good and bad frame packets */
+	uint64_t rx_all_bytes;    /* Include good and bad frame octes */
+	uint64_t rx_unicast;      /* rx good unicast packets */
+	uint64_t rx_broadcast;    /* rx good broadcast packets */
+	uint64_t rx_multicast;    /* rx good multicast packets */
+	uint64_t rx_pause;        /* Rx pause frame packets */
+	uint64_t rx_vlan;         /* Rx vlan frame packets */
+	uint64_t rx_oversize_9k;
+	uint64_t rx_64octes_pkts;
+	uint64_t rx_65to127_octes_pkts;
+	uint64_t rx_128to255_octes_pkts;
+	uint64_t rx_256to511_octes_pkts;
+	uint64_t rx_512to1023_octes_pkts;
+	uint64_t rx_1024tomax_octes_pkts;
+	uint64_t rx_len_err;      /* Bigger or less than len support */
+	uint64_t rx_len_invalid;  /* frame len isn't equal real len */
+	uint64_t rx_watchdog_err; /* Rx with a watchdog time out error */
+	uint64_t rx_crc_err;
+	uint64_t rx_runt_err;     /* Frame less-than-64-byte with a CRC error*/
+	uint64_t rx_jabber_err;   /* Jumbo Frame Crc Error */
+	uint64_t rx_undersize_err;/* Frame less than 64 bytes Error */
+
+	uint64_t tx_all_pkts;     /* Include good and bad frame num */
+	uint64_t tx_all_bytes;    /* Include good and bad frame octes */
+	uint64_t tx_pause_pkts;
+	uint64_t tx_vlan_pkts;
+	uint64_t tx_all_multicast;
+	uint64_t tx_all_unicast;
+	uint64_t tx_all_broadcast;
+	uint64_t tx_64octes_pkts;
+	uint64_t tx_65to127_octes_pkts;
+	uint64_t tx_128to255_octes_pkts;
+	uint64_t tx_256to511_octes_pkts;
+	uint64_t tx_512to1023_octes_pkts;
+	uint64_t tx_1024tomax_octes_pkts;
+	uint64_t tx_underflow_err;
 };
 
 struct rnp_eth_port {
@@ -123,6 +166,7 @@ struct rnp_eth_port {
 
 	struct rnp_hw_eth_stats eth_stats_old;
 	struct rnp_hw_eth_stats eth_stats;
+	struct rnp_hw_mac_stats mac_stats;
 
 	struct rte_eth_rss_conf rss_conf;
 	uint16_t last_rx_num;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 6e91601c98..5ea6007023 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -811,16 +811,111 @@ struct rte_rnp_xstats_name_off {
 };
 
 static const struct rte_rnp_xstats_name_off rte_rnp_rx_eth_stats_str[] = {
-	{"eth rx full drop", offsetof(struct rnp_hw_eth_stats,
+	{"rx_trans_drop", offsetof(struct rnp_hw_eth_stats,
 			rx_trans_drop), RNP_ETH_RXTRANS_DROP, false},
-	{"eth_rx_fifo_drop", offsetof(struct rnp_hw_eth_stats,
+	{"rx_trunc_drop", offsetof(struct rnp_hw_eth_stats,
 			rx_trunc_drop), RNP_ETH_RXTRUNC_DROP, false},
+	{"rx_undersize_err_packets", offsetof(struct rnp_hw_eth_stats,
+			rx_slen_drop), RNP_ETH_RXSLAN_DROP, false},
+	{"rx_oversize_err_packets", offsetof(struct rnp_hw_eth_stats,
+			rx_glen_drop), RNP_ETH_RXGLAN_DROP, false},
+	{"rx_iph_err_packet", offsetof(struct rnp_hw_eth_stats,
+			rx_cksum_e_drop), RNP_ETH_RXCKSUM_E_DROP, false},
+	{"rx_cksum_err_packet", offsetof(struct rnp_hw_eth_stats,
+			rx_iph_e_drop), RNP_ETH_RXIPH_E_DROP, false},
 };
+
+static const struct rte_rnp_xstats_name_off rte_rnp_mac_stats_str[] = {
+	{"rx_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_all_pkts), RNP_MMC_RX_GBFRMB, true},
+	{"rx_bytes", offsetof(struct rnp_hw_mac_stats,
+			rx_all_bytes), RNP_MMC_RX_GBOCTGB, true},
+	{"rx_unicast_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_unicast), RNP_MMC_RX_UCASTGB, true},
+	{"rx_broadcast_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_broadcast), RNP_MMC_RX_BCASTGB, true},
+	{"rx_multicast_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_multicast), RNP_MMC_RX_MCASTGB, true},
+	{"rx_pause_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_pause), RNP_MMC_RX_PAUSEB, true},
+	{"rx_vlan_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_vlan), RNP_MMC_RX_VLANGB, true},
+	{"rx_64_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_64octes_pkts), RNP_MMC_RX_64_BYTESB, true},
+	{"rx_65_to_127_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_65to127_octes_pkts), RNP_MMC_RX_65TO127_BYTESB, true},
+	{"rx_128_to_255_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_128to255_octes_pkts), RNP_MMC_RX_128TO255_BYTESB, true},
+	{"rx_256_to_511_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_256to511_octes_pkts), RNP_MMC_RX_256TO511_BYTESB, true},
+	{"rx_512_to_1023_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_512to1023_octes_pkts), RNP_MMC_RX_512TO1203_BYTESB, true},
+	{"rx_1024_to_max_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_1024tomax_octes_pkts), RNP_MMC_RX_1024TOMAX_BYTESB, true},
+	{"rx_len_over_9k", offsetof(struct rnp_hw_mac_stats,
+			rx_oversize_9k), RNP_MMC_RX_OSIZEGB, false},
+	{"rx_crc_errors", offsetof(struct rnp_hw_mac_stats,
+			rx_crc_err), RNP_MMC_RX_CRCERB, true},
+	{"rx_crc_errors_small_packets", offsetof(struct rnp_hw_mac_stats,
+			rx_runt_err), RNP_MMC_RX_RUNTERB, false},
+	{"rx_jabber_errors", offsetof(struct rnp_hw_mac_stats,
+			rx_jabber_err), RNP_MMC_RX_JABBER_ERR, false},
+	{"rx_length_errors", offsetof(struct rnp_hw_mac_stats,
+			rx_len_err), RNP_MMC_RX_LENERRB, true},
+	{"rx_out_of_range_errors", offsetof(struct rnp_hw_mac_stats,
+			rx_len_invalid), RNP_MMC_RX_OUTOF_RANGE, true},
+	{"rx_watchdog_errors", offsetof(struct rnp_hw_mac_stats,
+			rx_watchdog_err), RNP_MMC_RX_WDOGERRB, true},
+
+	{"tx_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_all_pkts), RNP_MMC_TX_GBFRMB, true},
+	{"tx_bytes", offsetof(struct rnp_hw_mac_stats,
+			tx_all_bytes), RNP_MMC_TX_GBOCTGB, true},
+	{"tx_unicast_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_all_unicast), RNP_MMC_TX_GBUCASTB, true},
+	{"tx_broadcast_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_all_broadcast), RNP_MMC_TX_BCASTB, true},
+	{"tx_multicast_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_all_multicast), RNP_MMC_TX_MCASTB, true},
+	{"tx_vlan_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_vlan_pkts), RNP_MMC_TX_VLANB, true},
+	{"tx_pause_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_pause_pkts), RNP_MMC_TX_PAUSEB, true},
+	{"tx_64_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_64octes_pkts), RNP_MMC_TX_64_BYTESB, true},
+	{"tx_65_to_127_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_65to127_octes_pkts), RNP_MMC_TX_65TO127_BYTESB, true},
+	{"tx_128_to_255_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_128to255_octes_pkts), RNP_MMC_TX_128TO255_BYTEB, true},
+	{"tx_256_to_511_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_256to511_octes_pkts), RNP_MMC_TX_256TO511_BYTEB, true},
+	{"tx_512_to_1023_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_512to1023_octes_pkts), RNP_MMC_TX_512TO1023_BYTEB, true},
+	{"tx_1024_to_max_byte_packets", offsetof(struct rnp_hw_mac_stats,
+			tx_1024tomax_octes_pkts), RNP_MMC_TX_1024TOMAX_BYTEB, true},
+	{"tx_underflow_errors", offsetof(struct rnp_hw_mac_stats,
+			tx_underflow_err), RNP_MMC_TX_UNDRFLWB, true},
+};
+
+#define RNP_NB_HW_MAC_STATS (RTE_DIM(rte_rnp_mac_stats_str))
 #define RNP_NB_RX_HW_ETH_STATS (RTE_DIM(rte_rnp_rx_eth_stats_str))
 #define RNP_GET_E_HW_COUNT(stats, offset)            \
-	((uint64_t *)(((char *)stats) + (offset)))
+	((uint64_t *)(((char *)(stats)) + (offset)))
 #define RNP_ADD_INCL_COUNT(stats, offset, val)       \
-	((*(RNP_GET_E_HW_COUNT(stats, (offset)))) += val)
+	((*(RNP_GET_E_HW_COUNT((stats), (offset)))) += (val))
+static inline void
+rnp_store_hw_stats(struct rnp_hw_mac_stats *stats,
+		   uint32_t offset, uint64_t val)
+{
+	*(uint64_t *)(((char *)stats) + offset) = val;
+}
+
+static int rnp_dev_cal_xstats_num(void)
+{
+	int cnt = RNP_NB_HW_MAC_STATS + RNP_NB_RX_HW_ETH_STATS;
+
+	return cnt;
+}
 
 static inline void
 rnp_update_eth_stats_32bit(struct rnp_hw_eth_stats *new,
@@ -851,20 +946,46 @@ static void rnp_get_eth_count(struct rnp_hw *hw,
 	}
 }
 
+static void
+rnp_get_mmc_info(struct rnp_hw *hw,
+		 uint16_t lane,
+		 struct rnp_hw_mac_stats *stats,
+		 const struct rte_rnp_xstats_name_off *ptr)
+{
+	uint64_t count = 0;
+	uint32_t offset;
+	uint64_t hi_reg;
+
+	if (ptr->reg_base) {
+		count = RNP_MAC_REG_RD(hw, lane, ptr->reg_base);
+		if (ptr->hi_addr_en) {
+			offset = ptr->reg_base + 4;
+			hi_reg = RNP_MAC_REG_RD(hw, lane, offset);
+			count += (hi_reg << 32);
+		}
+		rnp_store_hw_stats(stats, ptr->offset, count);
+	}
+}
+
 static void rnp_get_hw_stats(struct rte_eth_dev *dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
 	struct rnp_hw_eth_stats *old = &port->eth_stats_old;
 	struct rnp_hw_eth_stats *new = &port->eth_stats;
+	struct rnp_hw_mac_stats *stats = &port->mac_stats;
 	const struct rte_rnp_xstats_name_off *ptr;
 	uint16_t lane = port->attr.nr_lane;
 	struct rnp_hw *hw = port->hw;
-	uint16_t i;
+	uint32_t i;
 
 	for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
 		ptr = &rte_rnp_rx_eth_stats_str[i];
 		rnp_get_eth_count(hw, lane, new, old, ptr);
 	}
+	for (i = 0; i < RNP_NB_HW_MAC_STATS; i++) {
+		ptr = &rte_rnp_mac_stats_str[i];
+		rnp_get_mmc_info(hw, lane, stats, ptr);
+	}
 }
 
 static int
@@ -873,6 +994,7 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
 	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
+	struct rnp_hw_mac_stats *mac_stats = &port->mac_stats;
 	struct rte_eth_dev_data *data = dev->data;
 	uint16_t i = 0;
 
@@ -905,6 +1027,9 @@ rnp_dev_stats_get(struct rte_eth_dev *dev,
 		}
 	}
 	stats->imissed = eth_stats->rx_trans_drop + eth_stats->rx_trunc_drop;
+	stats->ierrors = mac_stats->rx_crc_err + mac_stats->rx_len_err;
+	stats->ierrors += mac_stats->rx_watchdog_err;
+	stats->oerrors = mac_stats->tx_underflow_err;
 
 	return 0;
 }
@@ -936,6 +1061,94 @@ rnp_dev_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static inline uint64_t
+rnp_get_statistic_value(void *stats_ptr, uint32_t offset)
+{
+	stats_ptr = (char *)stats_ptr + offset;
+
+	return *((uint64_t *)stats_ptr);
+}
+
+static int
+rnp_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		   unsigned int n __rte_unused)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
+	struct rnp_hw_mac_stats *mac_stats = &port->mac_stats;
+	int count = 0;
+	uint32_t i;
+
+	if (xstats != NULL) {
+		rnp_get_hw_stats(dev);
+		for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
+			xstats[count].value = rnp_get_statistic_value(eth_stats,
+					rte_rnp_rx_eth_stats_str[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+		for (i = 0; i < RNP_NB_HW_MAC_STATS; i++) {
+			xstats[count].value = rnp_get_statistic_value(mac_stats,
+					rte_rnp_mac_stats_str[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+	} else {
+		return rnp_dev_cal_xstats_num();
+	}
+
+	return count;
+}
+
+static int
+rnp_dev_xstats_reset(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t reg;
+
+	/* set MMC reset hw counter when read event */
+	reg = RNP_MAC_REG_RD(hw, lane, RNP_MMC_CTRL);
+	reg |= RNP_MMC_RSTONRD;
+	RNP_MAC_REG_WR(hw, lane, RNP_MMC_CTRL, reg);
+
+	rnp_dev_stats_reset(dev);
+	rnp_get_hw_stats(dev);
+	reg = RNP_MAC_REG_RD(hw, lane, RNP_MMC_CTRL);
+	reg &= ~RNP_MMC_RSTONRD;
+	RNP_MAC_REG_WR(hw, lane, RNP_MMC_CTRL, reg);
+
+	return 0;
+}
+
+static int
+rnp_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
+			 struct rte_eth_xstat_name *xstats_names,
+			 __rte_unused unsigned int size)
+{
+	int count = 0;
+	uint32_t i;
+
+	if (xstats_names == NULL)
+		return rnp_dev_cal_xstats_num();
+
+	for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
+		strlcpy(xstats_names[count].name,
+				rte_rnp_rx_eth_stats_str[i].name,
+				sizeof(xstats_names[count].name));
+		count++;
+	}
+	for (i = 0; i < RNP_NB_HW_MAC_STATS; i++) {
+		strlcpy(xstats_names[count].name,
+				rte_rnp_mac_stats_str[i].name,
+				sizeof(xstats_names[count].name));
+		count++;
+	}
+
+	return count;
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -967,6 +1180,9 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	/* stats */
 	.stats_get                    = rnp_dev_stats_get,
 	.stats_reset                  = rnp_dev_stats_reset,
+	.xstats_get                   = rnp_dev_xstats_get,
+	.xstats_reset                 = rnp_dev_xstats_reset,
+	.xstats_get_names             = rnp_dev_xstats_get_names,
 	/* link impl */
 	.link_update                  = rnp_dev_link_update,
 	.dev_set_link_up              = rnp_dev_set_link_up,
-- 
2.25.1

