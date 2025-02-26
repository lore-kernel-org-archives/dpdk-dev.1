Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCC8C021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:45:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF8B540E1B;
	Wed, 26 Feb 2025 08:43:03 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 89ABE40BA6
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:56 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id E0D8154B9DD; Wed, 26 Feb 2025 15:42:55 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 29/29] net/rnp: add multicast MAC filter operation
Date: Wed, 26 Feb 2025 15:42:16 +0800
Message-Id: <1740555736-19894-30-git-send-email-caowenbo@mucse.com>
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

add mac filter for single/multiple port.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   1 +
 doc/guides/nics/rnp.rst             |   1 +
 drivers/net/rnp/base/rnp_crc32.c    |  18 ++++-
 drivers/net/rnp/base/rnp_crc32.h    |   1 +
 drivers/net/rnp/base/rnp_eth_regs.h |   3 +
 drivers/net/rnp/base/rnp_hw.h       |   4 +
 drivers/net/rnp/base/rnp_mac.c      | 121 +++++++++++++++++++++++++++-
 drivers/net/rnp/base/rnp_mac.h      |   2 +
 drivers/net/rnp/base/rnp_mac_regs.h |   2 +
 drivers/net/rnp/rnp.h               |   4 +
 drivers/net/rnp/rnp_ethdev.c        |  26 ++++++
 11 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 48d250c86b..801a8de711 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -20,6 +20,7 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 MTU update           = Y
 Unicast MAC filter   = Y
+Multicast MAC filter = Y
 VLAN filter          = Y
 VLAN offload         = Y
 QinQ offload         = P
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index e9f96c4eb0..6926f699a6 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -101,6 +101,7 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_default_mac_addr_set``
 * ``rte_eth_dev_mac_addr_add``
 * ``rte_eth_dev_mac_addr_remove``
+* ``rte_eth_dev_set_mc_addr_list``
 * ``rte_eth_dev_get_supported_ptypes``
 * ``rte_eth_dev_get_vlan_offload``
 * ``rte_eth_dev_set_vlan_offload``
diff --git a/drivers/net/rnp/base/rnp_crc32.c b/drivers/net/rnp/base/rnp_crc32.c
index c287b35759..9d03754a4b 100644
--- a/drivers/net/rnp/base/rnp_crc32.c
+++ b/drivers/net/rnp/base/rnp_crc32.c
@@ -5,6 +5,7 @@
 #include "rnp_osdep.h"
 #include "rnp_crc32.h"
 
+#define RNP_CRC32_POLY_LE 0xedb88320
 static inline int get_bitmask_order(u32 count)
 {
 	int order;
@@ -30,7 +31,22 @@ u32 rnp_vid_crc32_calc(u32 crc_init, u16 vid_le)
 		crc >>= 1;
 		data_byte >>= 1;
 		if (temp)
-			crc ^= 0xedb88320;
+			crc ^= RNP_CRC32_POLY_LE;
+	}
+
+	return crc;
+}
+
+u32 rnp_calc_crc32(u32 seed, u8 *mac, u32 len)
+{
+	u32 crc = seed;
+	u32 i;
+
+	while (len--) {
+		crc ^= *mac++;
+		for (i = 0; i < 8; i++)
+			crc = (crc >> 1) ^ ((crc & 1) ?
+					RNP_CRC32_POLY_LE : 0);
 	}
 
 	return crc;
diff --git a/drivers/net/rnp/base/rnp_crc32.h b/drivers/net/rnp/base/rnp_crc32.h
index e117dcfc2f..dc3026ddf8 100644
--- a/drivers/net/rnp/base/rnp_crc32.h
+++ b/drivers/net/rnp/base/rnp_crc32.h
@@ -6,5 +6,6 @@
 #define _RNP_CRC32_H_
 
 u32 rnp_vid_crc32_calc(u32 crc_init, u16 vid_le);
+u32 rnp_calc_crc32(u32 seed, u8 *mac, u32 len);
 
 #endif /* _RNP_CRC32_H_ */
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 5c3f7f906c..1378328add 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -57,6 +57,8 @@
 #define RNP_MAC_HASH_MASK		RTE_GENMASK32(11, 0)
 #define RNP_MAC_MULTICASE_TBL_EN	RTE_BIT32(2)
 #define RNP_MAC_UNICASE_TBL_EN		RTE_BIT32(3)
+#define RNP_HTA_BIT_SHIFT		(5)
+#define RNP_HTA_BIT_MASK		((1 << RNP_HTA_BIT_SHIFT) - 1)
 /* vlan strip ctrl */
 #define RNP_VLAN_Q_STRIP_CTRL(n)	_ETH_(0x8040 + 0x4 * ((n) / 32))
 /* vlan filter ctrl */
@@ -87,5 +89,6 @@
 #define RNP_RAL_BASE_ADDR(n)	_ETH_(0xA000 + (0x04 * (n)))
 #define RNP_RAH_BASE_ADDR(n)	_ETH_(0xA400 + (0x04 * (n)))
 #define RNP_MAC_FILTER_EN	RTE_BIT32(31)
+#define RNP_MC_HASH_TABLE(n)	_ETH_(0xAC00 + ((0x04) * ((n))))
 
 #endif /* _RNP_ETH_REGS_H */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 8cf57db185..8dc29b6873 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -74,6 +74,10 @@ struct rnp_mac_ops {
 	/* Receive Address Filter table */
 	int (*set_rafb)(struct rnp_eth_port *port, const u8 *mac, u32 index);
 	int (*clear_rafb)(struct rnp_eth_port *port, u32 index);
+	/* update multicast address table */
+	int (*update_mta)(struct rnp_eth_port *port, u8 *mc_addr);
+	/* clear all multicast hash table */
+	int (*clear_mta)(struct rnp_eth_port *port, bool en);
 	/* receive vlan filter */
 	int (*vlan_f_en)(struct rnp_eth_port *port, bool en);
 	int (*update_vlan)(struct rnp_eth_port *port, u16 vid, bool en);
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index b723c29ac5..96750e1cde 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -46,7 +46,7 @@ rnp_update_mpfm_indep(struct rnp_eth_port *port, u32 mode, bool en)
 		reg |= disable;
 	}
 	/* disable common filter when indep mode */
-	reg |= RNP_MAC_HPF;
+	reg |= RNP_MAC_HPF | RNP_MAC_HMC;
 	RNP_MAC_REG_WR(hw, nr_lane, RNP_MAC_PKT_FLT_CTRL, reg);
 	RNP_MAC_REG_WR(hw, nr_lane, RNP_MAC_FCTRL, RNP_MAC_FCTRL_BYPASS);
 
@@ -283,11 +283,112 @@ rnp_update_vlan_filter_indep(struct rnp_eth_port *port,
 	return 0;
 }
 
+static u32
+rnp_sample_mac_vector(struct rnp_eth_port *port, u8 *mc_addr)
+{
+	u32 vector = 0;
+
+	switch (port->hash_filter_type) {
+	case 0:   /* Use bits [11:0] of the address */
+		vector = ((mc_addr[4] << 8) | (((u16)mc_addr[5])));
+		break;
+	case 1:   /* Use bits [12:1] of the address */
+		vector = ((mc_addr[4] << 7) | (((u16)mc_addr[5]) >> 1));
+		break;
+	case 2:   /* Use bits [13:2] of the address */
+		vector = ((mc_addr[4] << 6) | (((u16)mc_addr[5]) >> 2));
+		break;
+	case 3:   /* Use bits [14:3] of the address */
+		vector = ((mc_addr[4] << 4) | (((u16)mc_addr[5]) >> 4));
+		break;
+	default:  /* Invalid mc_filter_type */
+		RNP_PMD_ERR("Mac Hash filter type param set incorrect");
+		break;
+	}
+	vector &= RNP_MAC_HASH_MASK;
+
+	return vector;
+}
+
+static int
+rnp_update_mta_pf(struct rnp_eth_port *port, u8 *mc_addr)
+{
+	struct rnp_hw *hw = port->hw;
+	u32 vector, hash_bit;
+	u32 mta_row, mta_col;
+	u32 value, reg;
+
+	vector = rnp_sample_mac_vector(port, mc_addr);
+	mta_row = (vector >> RNP_HTA_BIT_SHIFT) & 0x7f;
+	mta_col = vector & (RNP_HTA_BIT_MASK);
+	hash_bit = 1 << mta_col;
+	value = port->mc_hash_table[mta_row];
+	if (!(value & hash_bit)) {
+		port->mc_hash_table[mta_row] |= hash_bit;
+		reg = port->mc_hash_table[mta_row];
+		RNP_E_REG_WR(hw, RNP_MC_HASH_TABLE(mta_row), reg);
+	}
+
+	return 0;
+}
+
+static int
+rnp_clear_mta_pf(struct rnp_eth_port *port, bool en __rte_unused)
+{
+	struct rnp_hw *hw = port->hw;
+	u16 idx = 0;
+
+	for (idx = 0; idx < port->attr.mc_hash_tb_size; idx++)
+		RNP_E_REG_WR(hw, RNP_MC_HASH_TABLE(idx), 0);
+	memset(&port->mc_hash_table, 0, sizeof(port->mc_hash_table));
+
+	return 0;
+}
+
+static int
+rnp_update_mta_indep(struct rnp_eth_port *port, u8 *mc_addr)
+{
+	u32 hash_bit, mta_row, mta_col;
+	u16 lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u32 crc, value, reg;
+
+	crc = bitrev32(~rnp_calc_crc32(~0, mc_addr, RTE_ETHER_ADDR_LEN));
+	crc >>= port->attr.hash_table_shift;
+	mta_row = (crc >> RNP_HTA_BIT_SHIFT) & 0x07;
+	mta_col = crc & RNP_HTA_BIT_MASK;
+	value = port->mc_hash_table[mta_row];
+	hash_bit = 1 << mta_col;
+	if (!(value & hash_bit)) {
+		port->mc_hash_table[mta_row] |= hash_bit;
+		reg = port->mc_hash_table[mta_row];
+		RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_HASH_TB(mta_row), reg);
+	}
+
+	return 0;
+}
+
+static int
+rnp_clear_mta_indep(struct rnp_eth_port *port, bool en __rte_unused)
+{
+	u16 lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u16 idx = 0;
+
+	for (idx = 0; idx < port->attr.mc_hash_tb_size; idx++)
+		RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_HASH_TB(idx), 0);
+	memset(&port->mc_hash_table, 0, sizeof(port->mc_hash_table));
+
+	return 0;
+}
+
 const struct rnp_mac_ops rnp_mac_ops_pf = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
 	.update_mpfm = rnp_update_mpfm_pf,
 	.set_rafb = rnp_set_mac_addr_pf,
 	.clear_rafb = rnp_clear_mac_pf,
+	.update_mta = rnp_update_mta_pf,
+	.clear_mta = rnp_clear_mta_pf,
 	.vlan_f_en = rnp_en_vlan_filter_pf,
 	.update_vlan = rnp_update_vlan_filter_pf,
 };
@@ -297,6 +398,8 @@ const struct rnp_mac_ops rnp_mac_ops_indep = {
 	.update_mpfm = rnp_update_mpfm_indep,
 	.set_rafb = rnp_set_mac_addr_indep,
 	.clear_rafb = rnp_clear_mac_indep,
+	.update_mta = rnp_update_mta_indep,
+	.clear_mta = rnp_clear_mta_indep,
 	.vlan_f_en = rnp_en_vlan_filter_indep,
 	.update_vlan = rnp_update_vlan_filter_indep,
 };
@@ -334,6 +437,22 @@ int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index)
 	return rnp_call_hwif_impl(port, mac_ops->clear_rafb, index);
 }
 
+int rnp_update_mc_hash(struct rnp_eth_port *port, u8 *mc_addr)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->update_mta, mc_addr);
+}
+
+int rnp_clear_mc_hash(struct rnp_eth_port *port)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->clear_mta, TRUE);
+}
+
 int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en)
 {
 	const struct rnp_mac_ops *mac_ops =
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 6f22c8279a..44d500a9df 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -26,6 +26,8 @@ void rnp_mac_ops_init(struct rnp_hw *hw);
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac);
 int rnp_set_macaddr(struct rnp_eth_port *port, u8 *mac, u32 index);
 int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index);
+int rnp_update_mc_hash(struct rnp_eth_port *port, u8 *mc_addr);
+int rnp_clear_mc_hash(struct rnp_eth_port *port);
 int rnp_update_mpfm(struct rnp_eth_port *port,
 		    u32 mode, bool en);
 int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en);
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index f15d7b2d72..d76efb2f39 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -114,6 +114,8 @@
 #define RNP_MAC_VLAN_VLC_REPLACE	(0x3 << RNP_MAC_VLAN_VLC_SHIFT)
 /* VLAN Tag for Transmit Packets For Insert/Remove */
 #define RNP_MAC_VLAN_VLT		RTE_GENMASK32(15, 0)
+/* Mac Hash Table */
+#define RNP_MAC_ADDR_HASH_TB(n)	(0x10 + ((n) * 0x4))
 /* mac link ctrl */
 #define RNP_MAC_LPI_CTRL	(0xd0)
 /* PHY Link Status Disable */
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 301e6ef203..3a2185329d 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -71,6 +71,7 @@
 #define RNP_PORT_MAX_MACADDR         (32)
 #define RNP_PORT_MAX_MC_HASH_TB      (8)
 #define RNP_PORT_MAX_MC_MAC_SIZE     (RNP_PORT_MAX_MC_HASH_TB * 32)
+#define RNP_PORT_HASH_SHIFT          (26 - (RNP_PORT_MAX_MC_MAC_SIZE >> 7))
 /* hardware media type */
 enum rnp_media_type {
 	RNP_MEDIA_TYPE_UNKNOWN,
@@ -99,6 +100,7 @@ struct rnp_port_attr {
 	uint16_t max_mc_mac_hash; /* max hash multicast mac size */
 	uint16_t uc_hash_tb_size; /* max unicast hash table block num */
 	uint16_t mc_hash_tb_size; /* max multicast hash table block num */
+	uint16_t hash_table_shift;/* hash mac table shift num */
 	uint16_t max_rx_queues;   /* belong to this port rxq resource */
 	uint16_t max_tx_queues;   /* belong to this port txq resource */
 
@@ -200,6 +202,8 @@ struct rnp_eth_port {
 	bool reta_has_cfg;
 	bool hw_rss_en;
 	uint32_t indirtbl[RNP_RSS_INDIR_SIZE];
+	uint32_t mc_hash_table[RNP_MAC_MC_HASH_TABLE];
+	uint8_t hash_filter_type;
 
 	uint16_t cur_mtu;
 	bool jumbo_en;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 227dc8e4ca..2ee1975667 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1431,6 +1431,29 @@ rnp_dev_mac_addr_remove(struct rte_eth_dev *dev,
 	rnp_clear_macaddr(port, index);
 }
 
+static int
+rnp_dev_set_mc_addr_list(struct rte_eth_dev *dev,
+			 struct rte_ether_addr *mc_addr_list,
+			 uint32_t nb_mc_addr)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint32_t idx = 0;
+
+	if (nb_mc_addr > port->attr.max_mc_mac_hash)
+		return -EINVAL;
+	rnp_clear_mc_hash(port);
+	for (idx = 0; idx < nb_mc_addr; idx++) {
+		if (!rte_is_multicast_ether_addr(&mc_addr_list[idx])) {
+			RNP_PMD_ERR("mc_list[%d] isn't a valid multicast", idx);
+			return -EINVAL;
+		}
+	}
+	for (idx = 0; idx < nb_mc_addr; idx++)
+		rnp_update_mc_hash(port, (uint8_t *)&mc_addr_list[idx]);
+
+	return 0;
+}
+
 static uint32_t *rnp_support_ptypes_get(void)
 {
 	static uint32_t ptypes[] = {
@@ -1507,6 +1530,7 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.mac_addr_set                 = rnp_dev_mac_addr_set,
 	.mac_addr_add                 = rnp_dev_mac_addr_add,
 	.mac_addr_remove              = rnp_dev_mac_addr_remove,
+	.set_mc_addr_list             = rnp_dev_set_mc_addr_list,
 	/* vlan offload */
 	.vlan_offload_set             = rnp_vlan_offload_set,
 	.vlan_strip_queue_set         = rnp_vlan_strip_queue_set,
@@ -1540,12 +1564,14 @@ rnp_setup_port_attr(struct rnp_eth_port *port,
 		attr->max_mc_mac_hash = RNP_PORT_MAX_MC_MAC_SIZE;
 		attr->uc_hash_tb_size = 0;
 		attr->mc_hash_tb_size = RNP_PORT_MAX_MC_HASH_TB;
+		attr->hash_table_shift = RNP_PORT_HASH_SHIFT;
 	} else {
 		attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
 		attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
 		attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
 		attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
 		attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+		attr->hash_table_shift = 0;
 	}
 	port->outvlan_type = RNP_SVLAN_TYPE;
 	port->invlan_type = RNP_CVLAN_TYPE;
-- 
2.25.1

