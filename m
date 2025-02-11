Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB32C021A2
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:52:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4BDF409FA;
	Tue, 11 Feb 2025 09:51:16 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 9069A40A6E
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:51:11 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id C79A7A3A71; Tue, 11 Feb 2025 16:50:42 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v9 20/28] net/rnp: add support xstats operation
Date: Tue, 11 Feb 2025 16:50:10 +0800
Message-Id: <1739263818-59770-21-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
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
 drivers/net/rnp/base/rnp_eth_regs.h |   3 +
 drivers/net/rnp/base/rnp_mac_regs.h |  80 +++++++++
 drivers/net/rnp/rnp.h               |  51 ++++++
 drivers/net/rnp/rnp_ethdev.c        | 243 ++++++++++++++++++++++++++++
 5 files changed, 378 insertions(+)

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
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 391688bd80..ada42be8e9 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -25,6 +25,9 @@
 #define RNP_RING_FC_THRESH(n)	_ETH_(0x8a00 + ((0x4) * (n)))
 /* ETH Statistic */
 #define RNP_ETH_RXTRANS_DROP	_ETH_(0x8904)
+#define RNP_ETH_RXGLAN_DROP	_ETH_(0x8918)
+#define RNP_ETH_RXIPH_E_DROP	_ETH_(0x891c)
+#define RNP_ETH_RXCKSUM_E_DROP	_ETH_(0x8920)
 #define RNP_ETH_RXTRUNC_DROP	_ETH_(0x8928)
 /* Mac Host Filter  */
 #define RNP_MAC_FCTRL		_ETH_(0x9110)
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 1ae880143d..94aeba9d6c 100644
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
+/* Len Oversize Than Support */
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
index bd2eb8caff..8ef0658d67 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -108,6 +108,56 @@ struct rnp_proc_priv {
 struct rnp_hw_eth_stats {
 	uint64_t rx_trans_drop;         /* rx eth to dma fifo full drop */
 	uint64_t rx_trunc_drop;         /* rx mac to eth to host copy fifo full drop */
+	uint64_t rx_glen_drop;          /* pkts length bigger than hw limit */
+	uint64_t rx_cksum_e_drop;       /* rx cksum error pkts drop */
+	uint64_t rx_iph_e_drop;         /* rx ip header error drop */
+};
+
+struct rnp_hw_mac_stats {
+	uint64_t rx_all_pkts;     /* Include Good And Bad Frame Num */
+	uint64_t rx_all_bytes;    /* Include Good And Bad Pkts octes */
+	uint64_t rx_good_pkts;
+	uint64_t rx_good_bytes;
+	uint64_t rx_broadcast;
+	uint64_t rx_multicast;
+	uint64_t rx_crc_err;
+	uint64_t rx_runt_err;     /* Frame Less-than-64-byte with a CRC error*/
+	uint64_t rx_jabber_err;   /* Jumbo Frame Crc Error */
+	uint64_t rx_undersize_err;/* Frame Less Than 64 bytes Error */
+	uint64_t rx_oversize_err; /* Bigger Than Max Support Length Frame */
+	uint64_t rx_64octes_pkts;
+	uint64_t rx_65to127_octes_pkts;
+	uint64_t rx_128to255_octes_pkts;
+	uint64_t rx_256to511_octes_pkts;
+	uint64_t rx_512to1023_octes_pkts;
+	uint64_t rx_1024tomax_octes_pkts;
+	uint64_t rx_unicast;
+	uint64_t rx_len_err;     /* Bigger Or Less Than Len Support */
+	uint64_t rx_len_invalid; /* Frame Len Isn't equal real Len */
+	uint64_t rx_pause; /* Rx Pause Frame Num */
+	uint64_t rx_vlan;  /* Rx Vlan Frame Num */
+	uint64_t rx_watchdog_err; /* Rx with a watchdog time out error */
+	uint64_t rx_bad_pkts;
+
+	uint64_t tx_all_pkts;     /* Include Good And Bad Frame Num */
+	uint64_t tx_all_bytes;    /* Include Good And Bad Pkts octes */
+	uint64_t tx_broadcast;
+	uint64_t tx_multicast;
+	uint64_t tx_64octes_pkts;
+	uint64_t tx_65to127_octes_pkts;
+	uint64_t tx_128to255_octes_pkts;
+	uint64_t tx_256to511_octes_pkts;
+	uint64_t tx_512to1023_octes_pkts;
+	uint64_t tx_1024tomax_octes_pkts;
+	uint64_t tx_all_unicast;
+	uint64_t tx_all_multicase;
+	uint64_t tx_all_broadcast;
+	uint64_t tx_underflow_err;
+	uint64_t tx_good_pkts;
+	uint64_t tx_good_bytes;
+	uint64_t tx_pause_pkts;
+	uint64_t tx_vlan_pkts;
+	uint64_t tx_bad_pkts;
 };
 
 struct rnp_eth_port {
@@ -120,6 +170,7 @@ struct rnp_eth_port {
 
 	struct rnp_hw_eth_stats eth_stats_old;
 	struct rnp_hw_eth_stats eth_stats;
+	struct rnp_hw_mac_stats mac_stats;
 
 	struct rte_eth_rss_conf rss_conf;
 	uint16_t last_rx_num;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 694a40a026..138349ebeb 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -794,12 +794,126 @@ static const struct rte_rnp_xstats_name_off rte_rnp_rx_eth_stats_str[] = {
 			rx_trans_drop), RNP_ETH_RXTRANS_DROP, false},
 	{"eth_rx_fifo_drop", offsetof(struct rnp_hw_eth_stats,
 			rx_trunc_drop), RNP_ETH_RXTRUNC_DROP, false},
+	{"eth rx pkts bigger than mtu", offsetof(struct rnp_hw_eth_stats,
+			rx_glen_drop), RNP_ETH_RXGLAN_DROP, false},
+	{"eth rx cksum error drop", offsetof(struct rnp_hw_eth_stats,
+			rx_cksum_e_drop), RNP_ETH_RXCKSUM_E_DROP, false},
+	{"eth rx iph error drop", offsetof(struct rnp_hw_eth_stats,
+			rx_iph_e_drop), RNP_ETH_RXIPH_E_DROP, false},
 };
+
+static const struct rte_rnp_xstats_name_off rte_rnp_rx_mac_stats_str[] = {
+	{"Rx good bad Pkts", offsetof(struct rnp_hw_mac_stats,
+			rx_all_pkts), RNP_MMC_RX_GBFRMB, true},
+	{"Rx good bad bytes", offsetof(struct rnp_hw_mac_stats,
+			rx_all_bytes), RNP_MMC_RX_GBOCTGB, true},
+	{"Rx good Pkts", offsetof(struct rnp_hw_mac_stats,
+			rx_good_pkts), 0, false},
+	{"RX good Bytes", offsetof(struct rnp_hw_mac_stats,
+			rx_good_bytes), RNP_MMC_RX_GOCTGB, true},
+	{"Rx Broadcast Pkts", offsetof(struct rnp_hw_mac_stats,
+			rx_broadcast), RNP_MMC_RX_BCASTGB, true},
+	{"Rx Multicast Pkts", offsetof(struct rnp_hw_mac_stats,
+			rx_multicast), RNP_MMC_RX_MCASTGB, true},
+	{"Rx Crc Frames Err Pkts", offsetof(struct rnp_hw_mac_stats,
+			rx_crc_err), RNP_MMC_RX_CRCERB, true},
+	{"Rx len Err with Crc err", offsetof(struct rnp_hw_mac_stats,
+			rx_runt_err), RNP_MMC_RX_RUNTERB, false},
+	{"Rx jabber Error ", offsetof(struct rnp_hw_mac_stats,
+			rx_jabber_err), RNP_MMC_RX_JABBER_ERR, false},
+	{"Rx len Err Without Other Error", offsetof(struct rnp_hw_mac_stats,
+			rx_undersize_err), RNP_MMC_RX_USIZEGB, false},
+	{"Rx Len Shorter 64Bytes Without Err", offsetof(struct rnp_hw_mac_stats,
+			rx_undersize_err), RNP_MMC_RX_USIZEGB, false},
+	{"Rx Len Oversize 9K", offsetof(struct rnp_hw_mac_stats,
+			rx_oversize_err), RNP_MMC_RX_OSIZEGB, false},
+	{"Rx 64Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_64octes_pkts), RNP_MMC_RX_64_BYTESB, true},
+	{"Rx 65Bytes To 127Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_65to127_octes_pkts), RNP_MMC_RX_65TO127_BYTESB, true},
+	{"Rx 128Bytes To 255Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_128to255_octes_pkts), RNP_MMC_RX_128TO255_BYTESB, true},
+	{"Rx 256Bytes To 511Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_256to511_octes_pkts), RNP_MMC_RX_256TO511_BYTESB, true},
+	{"Rx 512Bytes To 1023Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_512to1023_octes_pkts), RNP_MMC_RX_512TO1203_BYTESB, true},
+	{"Rx Bigger 1024Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_1024tomax_octes_pkts), RNP_MMC_RX_1024TOMAX_BYTESB, true},
+	{"Rx Unicast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_unicast), RNP_MMC_RX_UCASTGB, true},
+	{"Rx Len Err Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_len_err), RNP_MMC_RX_LENERRB, true},
+	{"Rx Len Not Equal Real data_len", offsetof(struct rnp_hw_mac_stats,
+			rx_len_invalid), RNP_MMC_RX_OUTOF_RANGE, true},
+	{"Rx Pause Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_pause), RNP_MMC_RX_PAUSEB, true},
+	{"Rx Vlan Frame Num", offsetof(struct rnp_hw_mac_stats,
+			rx_vlan), RNP_MMC_RX_VLANGB, true},
+	{"Rx Hw Watchdog Frame Err", offsetof(struct rnp_hw_mac_stats,
+			rx_watchdog_err), RNP_MMC_RX_WDOGERRB, true},
+};
+
+static const struct rte_rnp_xstats_name_off rte_rnp_tx_mac_stats_str[] = {
+	{"Tx Good Bad Pkts Num", offsetof(struct rnp_hw_mac_stats,
+			tx_all_pkts), RNP_MMC_TX_GBFRMB, true},
+	{"Tx Good Bad Bytes", offsetof(struct rnp_hw_mac_stats,
+			tx_all_bytes), RNP_MMC_TX_GBOCTGB, true},
+	{"Tx Good Broadcast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_broadcast), RNP_MMC_TX_BCASTB, true},
+	{"Tx Good Multicast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_multicast), RNP_MMC_TX_MCASTB, true},
+	{"Tx 64Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_64octes_pkts), RNP_MMC_TX_64_BYTESB, true},
+	{"Tx 65 To 127 Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_65to127_octes_pkts), RNP_MMC_TX_65TO127_BYTESB, true},
+	{"Tx 128 To 255 Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_128to255_octes_pkts), RNP_MMC_TX_128TO255_BYTEB, true},
+	{"Tx 256 To 511 Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_256to511_octes_pkts), RNP_MMC_TX_256TO511_BYTEB, true},
+	{"Tx 512 To 1023 Bytes Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_512to1023_octes_pkts), RNP_MMC_TX_512TO1023_BYTEB, true},
+	{"Tx Bigger Than 1024 Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_1024tomax_octes_pkts), RNP_MMC_TX_1024TOMAX_BYTEB, true},
+	{"Tx Good And Bad Unicast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_all_unicast), RNP_MMC_TX_GBUCASTB, true},
+	{"Tx Good And Bad Multicast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_all_multicase), RNP_MMC_TX_GBMCASTB, true},
+	{"Tx Good And Bad Broadcast Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_all_broadcast), RNP_MMC_TX_GBBCASTB, true},
+	{"Tx Underflow Frame Err Num", offsetof(struct rnp_hw_mac_stats,
+			tx_underflow_err), RNP_MMC_TX_UNDRFLWB, true},
+	{"Tx Good Frame Bytes", offsetof(struct rnp_hw_mac_stats,
+			tx_good_bytes), RNP_MMC_TX_GBYTESB, true},
+	{"Tx Good Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_good_pkts), RNP_MMC_TX_GBFRMB, true},
+	{"Tx Pause Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_pause_pkts), RNP_MMC_TX_PAUSEB, true},
+	{"Tx Vlan Frame Num", offsetof(struct rnp_hw_mac_stats,
+			tx_vlan_pkts), RNP_MMC_TX_VLANB, true},
+};
+
+#define RNP_NB_RX_HW_MAC_STATS (RTE_DIM(rte_rnp_rx_mac_stats_str))
+#define RNP_NB_TX_HW_MAC_STATS (RTE_DIM(rte_rnp_tx_mac_stats_str))
 #define RNP_NB_RX_HW_ETH_STATS (RTE_DIM(rte_rnp_rx_eth_stats_str))
 #define RNP_GET_E_HW_COUNT(stats, offset)            \
 	((uint64_t *)(((char *)stats) + (offset)))
 #define RNP_ADD_INCL_COUNT(stats, offset, val)       \
 	((*(RNP_GET_E_HW_COUNT(stats, (offset)))) += val)
+static inline void
+rnp_store_hw_stats(struct rnp_hw_mac_stats *stats,
+		   uint32_t offset, uint64_t val)
+{
+	*(uint64_t *)(((char *)stats) + offset) = val;
+}
+
+static uint32_t rnp_dev_cal_xstats_num(void)
+{
+	uint32_t cnt = RNP_NB_RX_HW_MAC_STATS + RNP_NB_TX_HW_MAC_STATS;
+
+	cnt += RNP_NB_RX_HW_ETH_STATS;
+
+	return cnt;
+}
 
 static inline void
 rnp_update_eth_stats_32bit(struct rnp_hw_eth_stats *new,
@@ -830,11 +944,33 @@ static void rnp_get_eth_count(struct rnp_hw *hw,
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
@@ -844,6 +980,19 @@ static void rnp_get_hw_stats(struct rte_eth_dev *dev)
 		ptr = &rte_rnp_rx_eth_stats_str[i];
 		rnp_get_eth_count(hw, lane, new, old, ptr);
 	}
+	for (i = 0; i < RNP_NB_RX_HW_MAC_STATS; i++) {
+		ptr = &rte_rnp_rx_mac_stats_str[i];
+		rnp_get_mmc_info(hw, lane, stats, ptr);
+	}
+	for (i = 0; i < RNP_NB_TX_HW_MAC_STATS; i++) {
+		ptr = &rte_rnp_tx_mac_stats_str[i];
+		rnp_get_mmc_info(hw, lane, stats, ptr);
+	}
+	stats->rx_good_pkts = stats->rx_all_pkts - stats->rx_crc_err -
+		stats->rx_len_err - stats->rx_watchdog_err;
+	stats->rx_bad_pkts = stats->rx_crc_err + stats->rx_len_err +
+		stats->rx_watchdog_err;
+	stats->tx_bad_pkts = stats->tx_underflow_err;
 }
 
 static int
@@ -926,6 +1075,97 @@ rnp_dev_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+rnp_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
+		   unsigned int n __rte_unused)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_hw_eth_stats *eth_stats = &port->eth_stats;
+	struct rnp_hw_mac_stats *mac_stats = &port->mac_stats;
+	uint32_t count = 0;
+	uint16_t i;
+
+	if (xstats != NULL) {
+		rnp_get_hw_stats(dev);
+		for (i = 0; i < RNP_NB_RX_HW_MAC_STATS; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)mac_stats) +
+					rte_rnp_rx_mac_stats_str[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+		for (i = 0; i < RNP_NB_TX_HW_MAC_STATS; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)mac_stats) +
+					rte_rnp_tx_mac_stats_str[i].offset);
+			xstats[count].id = count;
+			count++;
+		}
+		for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
+			xstats[count].value = *(uint64_t *)(((char *)eth_stats) +
+					rte_rnp_rx_eth_stats_str[i].offset);
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
+	RNP_MAC_REG_WR(hw, lane, RNP_MMC_CTRL, RNP_MMC_RSTONRD);
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
+	uint32_t xstats_cnt = rnp_dev_cal_xstats_num();
+	uint32_t i, count = 0;
+
+	if (xstats_names != NULL) {
+		for (i = 0; i < RNP_NB_RX_HW_MAC_STATS; i++) {
+			strlcpy(xstats_names[count].name,
+					rte_rnp_rx_mac_stats_str[i].name,
+					sizeof(xstats_names[count].name));
+			count++;
+		}
+
+		for (i = 0; i < RNP_NB_TX_HW_MAC_STATS; i++) {
+			strlcpy(xstats_names[count].name,
+					rte_rnp_tx_mac_stats_str[i].name,
+					sizeof(xstats_names[count].name));
+			count++;
+		}
+		for (i = 0; i < RNP_NB_RX_HW_ETH_STATS; i++) {
+			strlcpy(xstats_names[count].name,
+					rte_rnp_rx_eth_stats_str[i].name,
+					sizeof(xstats_names[count].name));
+			count++;
+		}
+	}
+
+	return xstats_cnt;
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -952,6 +1192,9 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
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
2.34.1

