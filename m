Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643BFC021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E27F740E0F;
	Wed, 26 Feb 2025 08:42:59 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 7A05C40B97
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:51 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id D814F54B9DD; Wed, 26 Feb 2025 15:42:50 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 25/29] net/rnp: support VLAN offloads
Date: Wed, 26 Feb 2025 15:42:12 +0800
Message-Id: <1740555736-19894-26-git-send-email-caowenbo@mucse.com>
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

add support rx vlan strip,filter,tx vlan/qinq insert.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   2 +
 doc/guides/nics/rnp.rst             |   4 +
 drivers/net/rnp/base/rnp_bdq_if.h   |   2 +-
 drivers/net/rnp/base/rnp_eth_regs.h |   5 +
 drivers/net/rnp/base/rnp_hw.h       |   2 +
 drivers/net/rnp/base/rnp_mac.c      |  53 ++++++++-
 drivers/net/rnp/base/rnp_mac.h      |   1 +
 drivers/net/rnp/base/rnp_mac_regs.h |  41 ++++++-
 drivers/net/rnp/rnp.h               |   7 ++
 drivers/net/rnp/rnp_ethdev.c        | 170 +++++++++++++++++++++++++++-
 drivers/net/rnp/rnp_rxtx.c          |  22 +++-
 11 files changed, 303 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index f6feb9aa70..c1ab91697a 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -20,6 +20,8 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 MTU update           = Y
 Unicast MAC filter   = Y
+VLAN offload         = Y
+QinQ offload         = P
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index b9c983d07e..320f19451b 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -58,6 +58,7 @@ Features
 - Packet type parsing
 - Checksum offload
 - TSO offload
+- VLAN stripping and VLAN/QINQ insertion
 
 Prerequisites and Pre-conditions
 --------------------------------
@@ -101,6 +102,9 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_mac_addr_add``
 * ``rte_eth_dev_mac_addr_remove``
 * ``rte_eth_dev_get_supported_ptypes``
+* ``rte_eth_dev_get_vlan_offload``
+* ``rte_eth_dev_set_vlan_offload``
+* ``rte_eth_dev_set_vlan_strip_on_queue``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/rnp_bdq_if.h b/drivers/net/rnp/base/rnp_bdq_if.h
index 7a6d0b21ec..182a8a715d 100644
--- a/drivers/net/rnp/base/rnp_bdq_if.h
+++ b/drivers/net/rnp/base/rnp_bdq_if.h
@@ -87,7 +87,7 @@ struct rnp_tx_desc {
 #define RNP_RX_TUNNEL_MASK	RTE_GENMASK32(14, 13)
 #define RNP_RX_PTYPE_VXLAN	(0x01UL << RNP_RX_TUNNEL_TYPE_S)
 #define RNP_RX_PTYPE_NVGRE	(0x02UL << RNP_RX_TUNNEL_TYPE_S)
-#define RNP_RX_PTYPE_VLAN	RTE_BIT32(15)
+#define RNP_RX_STRIP_VLAN	RTE_BIT32(15)
 /* mark_data */
 #define RNP_RX_L3TYPE_VALID	RTE_BIT32(31)
 /* tx data cmd */
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index e096ec90e6..f84386d93a 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -57,6 +57,11 @@
 #define RNP_MAC_HASH_MASK		RTE_GENMASK32(11, 0)
 #define RNP_MAC_MULTICASE_TBL_EN	RTE_BIT32(2)
 #define RNP_MAC_UNICASE_TBL_EN		RTE_BIT32(3)
+/* vlan strip ctrl */
+#define RNP_VLAN_Q_STRIP_CTRL(n)	_ETH_(0x8040 + 0x4 * ((n) / 32))
+/* vlan filter ctrl */
+#define RNP_VLAN_FILTER_CTRL	_ETH_(0x9118)
+#define RNP_VLAN_FILTER_EN	RTE_BIT32(30)
 /* rss function ctrl */
 #define RNP_RSS_INNER_CTRL	_ETH_(0x805c)
 #define RNP_INNER_RSS_EN	(1)
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index e5a19a1918..c7e5a2f506 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -74,6 +74,8 @@ struct rnp_mac_ops {
 	/* Receive Address Filter table */
 	int (*set_rafb)(struct rnp_eth_port *port, const u8 *mac, u32 index);
 	int (*clear_rafb)(struct rnp_eth_port *port, u32 index);
+	/* receive vlan filter */
+	int (*vlan_f_en)(struct rnp_eth_port *port, bool en);
 };
 
 struct rnp_eth_adapter;
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index 6ad2ca0a4a..b6b969a020 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -166,11 +166,53 @@ rnp_clear_mac_indep(struct rnp_eth_port *port, u32 index)
 	return 0;
 }
 
+static int
+rnp_en_vlan_filter_pf(struct rnp_eth_port *port, bool en)
+{
+	struct rnp_hw *hw = port->hw;
+	u32 ctrl;
+
+	/* enable/disable all vlan filter configuration */
+	ctrl = RNP_E_REG_RD(hw, RNP_VLAN_FILTER_CTRL);
+	if (en)
+		ctrl |= RNP_VLAN_FILTER_EN;
+	else
+		ctrl &= ~RNP_VLAN_FILTER_EN;
+	RNP_E_REG_WR(hw, RNP_VLAN_FILTER_CTRL, ctrl);
+
+	return 0;
+}
+
+static int
+rnp_en_vlan_filter_indep(struct rnp_eth_port *port, bool en)
+{
+	u16 lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u32 flt_reg, vlan_reg;
+
+	flt_reg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_PKT_FLT_CTRL);
+	vlan_reg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_VLAN_TAG);
+	if (en) {
+		flt_reg |= RNP_MAC_VTFE;
+		vlan_reg |= (RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV | \;
+			     RNP_MAC_VLAN_HASH_EN);
+	} else {
+		flt_reg &= ~RNP_MAC_VTFE;
+		vlan_reg &= ~(RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV | \;
+			      RNP_MAC_VLAN_HASH_EN);
+	}
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_PKT_FLT_CTRL, flt_reg);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_VLAN_TAG, vlan_reg);
+
+	return 0;
+}
+
 const struct rnp_mac_ops rnp_mac_ops_pf = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
 	.update_mpfm = rnp_update_mpfm_pf,
 	.set_rafb = rnp_set_mac_addr_pf,
-	.clear_rafb = rnp_clear_mac_pf
+	.clear_rafb = rnp_clear_mac_pf,
+	.vlan_f_en = rnp_en_vlan_filter_pf,
 };
 
 const struct rnp_mac_ops rnp_mac_ops_indep = {
@@ -178,6 +220,7 @@ const struct rnp_mac_ops rnp_mac_ops_indep = {
 	.update_mpfm = rnp_update_mpfm_indep,
 	.set_rafb = rnp_set_mac_addr_indep,
 	.clear_rafb = rnp_clear_mac_indep,
+	.vlan_f_en = rnp_en_vlan_filter_indep,
 };
 
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
@@ -213,6 +256,14 @@ int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index)
 	return rnp_call_hwif_impl(port, mac_ops->clear_rafb, index);
 }
 
+int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->vlan_f_en, en);
+}
+
 void rnp_mac_ops_init(struct rnp_hw *hw)
 {
 	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 865fc348df..4a5206ded3 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -28,5 +28,6 @@ int rnp_set_macaddr(struct rnp_eth_port *port, u8 *mac, u32 index);
 int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index);
 int rnp_update_mpfm(struct rnp_eth_port *port,
 		    u32 mode, bool en);
+int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en);
 
 #endif /* _RNP_MAC_H_ */
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 56ad6ec015..045fc28ec9 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -69,8 +69,45 @@
 /* Hash or Perfect Filter */
 #define RNP_MAC_HPF		RTE_BIT32(10)
 #define RNP_MAC_VTFE		RTE_BIT32(16)
-
-#define RNP_MAC_VFE		RTE_BIT32(16)
+/* mac vlan ctrl reg */
+#define RNP_MAC_VLAN_TAG	(0x50)
+/* En Double Vlan Processing */
+#define RNP_MAC_VLAN_EDVLP	RTE_BIT32(26)
+/* VLAN Tag Hash Table Match Enable */
+#define RNP_MAC_VLAN_VTHM	RTE_BIT32(25)
+/*  Enable VLAN Tag in Rx status */
+#define RNP_MAC_VLAN_EVLRXS	RTE_BIT32(24)
+/* Disable VLAN Type Check */
+#define RNP_MAC_VLAN_DOVLTC	RTE_BIT32(20)
+/* Enable S-VLAN */
+#define RNP_MAC_VLAN_ESVL	RTE_BIT32(18)
+/* Enable 12-Bit VLAN Tag Comparison Filter */
+#define RNP_MAC_VLAN_ETV	RTE_BIT32(16)
+/* enable vid valid  */
+#define RNP_MAC_VLAN_HASH_EN	RTE_GENMASK32(15, 0)
+/* MAC VLAN CTRL INSERT REG */
+#define RNP_MAC_VLAN_INCL	(0x60)
+#define RNP_MAC_INNER_VLAN_INCL	(0x64)
+/* VLAN_Tag Insert From Description */
+#define RNP_MAC_VLAN_VLTI	RTE_BIT32(20)
+/* C-VLAN or S-VLAN */
+#define RNP_MAC_VLAN_CSVL		RTE_BIT32(19)
+#define RNP_MAC_VLAN_INSERT_CVLAN	(0 << 19)
+#define RNP_MAC_VLAN_INSERT_SVLAN	(1 << 19)
+/* VLAN Tag Control in Transmit Packets */
+#define RNP_MAC_VLAN_VLC		RTE_GENMASK32(17, 16)
+/* VLAN Tag Control Offset Bit */
+#define RNP_MAC_VLAN_VLC_SHIFT		(16)
+/* Don't Anything ON TX VLAN*/
+#define RNP_MAC_VLAN_VLC_NONE		(0x0 << RNP_MAC_VLAN_VLC_SHIFT)
+/* MAC Delete VLAN */
+#define RNP_MAC_VLAN_VLC_DEL		(0x1 << RNP_MAC_VLAN_VLC_SHIFT)
+/* MAC Add VLAN */
+#define RNP_MAC_VLAN_VLC_ADD		(0x2 << RNP_MAC_VLAN_VLC_SHIFT)
+/* MAC Replace VLAN */
+#define RNP_MAC_VLAN_VLC_REPLACE	(0x3 << RNP_MAC_VLAN_VLC_SHIFT)
+/* VLAN Tag for Transmit Packets For Insert/Remove */
+#define RNP_MAC_VLAN_VLT		RTE_GENMASK32(15, 0)
 /* mac link ctrl */
 #define RNP_MAC_LPI_CTRL	(0xd0)
 /* PHY Link Status Disable */
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index c32eb2291c..1ee326ca03 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -167,6 +167,11 @@ struct rnp_hw_mac_stats {
 	uint64_t tx_underflow_err;
 };
 
+enum rnp_vlan_type {
+	RNP_CVLAN_TYPE = 0,
+	RNP_SVLAN_TYPE = 1,
+};
+
 struct rnp_eth_port {
 	struct rnp_proc_priv *proc_priv;
 	struct rte_ether_addr mac_addr;
@@ -189,6 +194,8 @@ struct rnp_eth_port {
 	uint16_t cur_mtu;
 	bool jumbo_en;
 
+	enum rnp_vlan_type outvlan_type;
+	enum rnp_vlan_type invlan_type;
 	rte_spinlock_t rx_mac_lock;
 	bool port_stopped;
 };
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 5756625fbf..c7438101eb 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -307,6 +307,94 @@ static int rnp_enable_all_tx_queue(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static void
+rnp_vlan_strip_queue_set(struct rte_eth_dev *dev, uint16_t queue,
+			 int on)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	struct rnp_rx_queue *rxq = NULL;
+	struct rnp_hw *hw = port->hw;
+	uint16_t index;
+	uint32_t reg;
+
+	rxq = dev->data->rx_queues[queue];
+	if (rxq) {
+		index = rxq->attr.index;
+		reg = RNP_E_REG_RD(hw, RNP_VLAN_Q_STRIP_CTRL(index));
+		if (on) {
+			reg |= 1 << (index % 32);
+			rxq->rx_offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+		} else {
+			reg &= ~(1 << (index % 32));
+			rxq->rx_offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+		}
+		RNP_E_REG_WR(hw, RNP_VLAN_Q_STRIP_CTRL(index), reg);
+	}
+}
+
+static void
+rnp_vlan_strip_enable(struct rnp_eth_port *port, bool en)
+{
+	int i = 0;
+
+	for (i = 0; i < port->eth_dev->data->nb_rx_queues; i++) {
+		if (port->eth_dev->data->rx_queues[i] == NULL) {
+			RNP_PMD_ERR("Strip queue[%d] is NULL.", i);
+			continue;
+		}
+		rnp_vlan_strip_queue_set(port->eth_dev, i, en);
+	}
+}
+
+static void
+rnp_double_vlan_enable(struct rnp_eth_port *port, bool on)
+{
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t ctrl;
+
+	/* En Double Vlan Engine */
+	ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_VLAN_TAG);
+	if (on)
+		ctrl |= RNP_MAC_VLAN_EDVLP | RNP_MAC_VLAN_ESVL;
+	else
+		ctrl &= ~(RNP_MAC_VLAN_EDVLP | RNP_MAC_VLAN_ESVL);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_VLAN_TAG, ctrl);
+}
+
+static int
+rnp_vlan_offload_set(struct rte_eth_dev *dev, int mask)
+{
+	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	if (mask & RTE_ETH_QINQ_STRIP_MASK) {
+		RNP_PMD_ERR("QinQ Strip isn't supported.");
+		return -ENOTSUP;
+	}
+	if (mask & RTE_ETH_VLAN_FILTER_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_FILTER)
+			rnp_rx_vlan_filter_en(port, true);
+		else
+
+			rnp_rx_vlan_filter_en(port, false);
+	}
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			rnp_vlan_strip_enable(port, true);
+		else
+			rnp_vlan_strip_enable(port, false);
+	}
+	if (mask & RTE_ETH_VLAN_EXTEND_MASK) {
+		if (rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_EXTEND)
+			rnp_double_vlan_enable(port, true);
+		else
+			rnp_double_vlan_enable(port, false);
+	}
+
+	return 0;
+}
+
 static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
@@ -472,10 +560,79 @@ static void rnp_set_rx_cksum_offload(struct rte_eth_dev *dev)
 	}
 }
 
+static void
+rnp_qinq_insert_offload_en(struct rnp_eth_port *port, bool on)
+{
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t cvlan_ctrl, svlan_ctrl;
+
+	/* en double vlan engine */
+	rnp_double_vlan_enable(port, on);
+	/* setup inner vlan mode*/
+	cvlan_ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_INNER_VLAN_INCL);
+	if (on) {
+		cvlan_ctrl |= RNP_MAC_VLAN_VLTI;
+		cvlan_ctrl &= ~RNP_MAC_VLAN_CSVL;
+		if (port->invlan_type == RNP_SVLAN_TYPE)
+			cvlan_ctrl |= RNP_MAC_VLAN_INSERT_SVLAN;
+		cvlan_ctrl &= ~RNP_MAC_VLAN_VLC;
+		cvlan_ctrl |= RNP_MAC_VLAN_VLC_ADD;
+	} else {
+		cvlan_ctrl = 0;
+	}
+	/* setup outer vlan mode */
+	svlan_ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_VLAN_INCL);
+	if (on) {
+		svlan_ctrl |= RNP_MAC_VLAN_VLTI;
+		svlan_ctrl &= ~RNP_MAC_VLAN_CSVL;
+		if (port->outvlan_type == RNP_SVLAN_TYPE)
+			svlan_ctrl |= RNP_MAC_VLAN_INSERT_SVLAN;
+		svlan_ctrl &= ~RNP_MAC_VLAN_VLC;
+		svlan_ctrl |= RNP_MAC_VLAN_VLC_ADD;
+	} else {
+		svlan_ctrl = 0;
+	}
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_INNER_VLAN_INCL, cvlan_ctrl);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_VLAN_INCL, svlan_ctrl);
+}
+
+static void
+rnp_vlan_insert_offload_en(struct rnp_eth_port *port, bool on)
+{
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t ctrl;
+
+	ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_VLAN_INCL);
+	if (on) {
+		ctrl |= RNP_MAC_VLAN_VLTI;
+		ctrl &= ~RNP_MAC_VLAN_CSVL;
+		if (port->invlan_type == RNP_SVLAN_TYPE)
+			ctrl |= RNP_MAC_VLAN_INSERT_SVLAN;
+		ctrl &= ~RNP_MAC_VLAN_VLC;
+		ctrl |= RNP_MAC_VLAN_VLC_ADD;
+	} else {
+		ctrl = 0;
+	}
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_VLAN_INCL, ctrl);
+}
+
 static int rnp_dev_configure(struct rte_eth_dev *eth_dev)
 {
+	struct rte_eth_txmode *txmode = &eth_dev->data->dev_conf.txmode;
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 
+	if (txmode->offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT &&
+	    txmode->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT)
+		rnp_qinq_insert_offload_en(port, true);
+	else
+		rnp_qinq_insert_offload_en(port, false);
+	if (txmode->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT &&
+	    !(txmode->offloads & RTE_ETH_TX_OFFLOAD_QINQ_INSERT))
+		rnp_vlan_insert_offload_en(port, true);
+	if (!(txmode->offloads & RTE_ETH_TX_OFFLOAD_VLAN_INSERT))
+		rnp_vlan_insert_offload_en(port, false);
 	if (port->last_rx_num != eth_dev->data->nb_rx_queues)
 		port->rxq_num_changed = true;
 	else
@@ -667,9 +824,12 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->reta_size = RNP_RSS_INDIR_SIZE;
 	/* speed cap info */
 	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
+	/* per queue offload */
+	dev_info->rx_queue_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	/* rx support offload cap */
 	dev_info->rx_offload_capa = RNP_RX_CHECKSUM_SUPPORT |
 				    RTE_ETH_RX_OFFLOAD_SCATTER;
+	dev_info->rx_offload_capa |= dev_info->rx_queue_offload_capa;
 	/* tx support offload cap */
 	dev_info->tx_offload_capa = 0 |
 				    RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
@@ -680,7 +840,9 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 				    RTE_ETH_TX_OFFLOAD_TCP_TSO |
 				    RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
 				    RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |
-				    RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+				    RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+				    RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
+				    RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
 	/* default ring configure */
 	dev_info->default_rxportconf.burst_size = 32;
 	dev_info->default_txportconf.burst_size = 32;
@@ -1331,6 +1493,9 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.mac_addr_set                 = rnp_dev_mac_addr_set,
 	.mac_addr_add                 = rnp_dev_mac_addr_add,
 	.mac_addr_remove              = rnp_dev_mac_addr_remove,
+	/* vlan offload */
+	.vlan_offload_set             = rnp_vlan_offload_set,
+	.vlan_strip_queue_set         = rnp_vlan_strip_queue_set,
 	.dev_supported_ptypes_get     = rnp_dev_supported_ptypes_get,
 };
 
@@ -1367,6 +1532,9 @@ rnp_setup_port_attr(struct rnp_eth_port *port,
 		attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
 		attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
 	}
+	port->outvlan_type = RNP_SVLAN_TYPE;
+	port->invlan_type = RNP_CVLAN_TYPE;
+
 	rnp_mbx_fw_get_lane_stat(port);
 
 	RNP_PMD_INFO("PF[%d] SW-ETH-PORT[%d]<->PHY_LANE[%d]",
diff --git a/drivers/net/rnp/rnp_rxtx.c b/drivers/net/rnp/rnp_rxtx.c
index 3e0ac47f9d..6504d62f62 100644
--- a/drivers/net/rnp/rnp_rxtx.c
+++ b/drivers/net/rnp/rnp_rxtx.c
@@ -716,6 +716,7 @@ rnp_dev_rx_offload(struct rnp_rx_queue *rxq,
 		   volatile struct rnp_rx_desc rxbd)
 {
 	uint32_t rss = rte_le_to_cpu_32(rxbd.wb.qword0.rss_hash);
+	uint16_t vlan_tci = rxbd.wb.qword1.vlan_tci;
 	uint16_t cmd = rxbd.wb.qword1.cmd;
 
 	if (rxq->rx_offloads & RNP_RX_CHECKSUM_SUPPORT) {
@@ -731,6 +732,13 @@ rnp_dev_rx_offload(struct rnp_rx_queue *rxq,
 		m->hash.rss = rss;
 		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
 	}
+	if (rxq->rx_offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP) {
+		if (vlan_tci && cmd & RNP_RX_STRIP_VLAN) {
+			m->ol_flags |= RTE_MBUF_F_RX_VLAN |
+				RTE_MBUF_F_RX_VLAN_STRIPPED;
+			m->vlan_tci = vlan_tci;
+		}
+	}
 }
 
 static __rte_always_inline void
@@ -1144,7 +1152,8 @@ rnp_need_ctrl_desc(uint64_t flags)
 	static uint64_t mask = RTE_MBUF_F_TX_OUTER_IP_CKSUM |
 			       RTE_MBUF_F_TX_TCP_SEG |
 			       RTE_MBUF_F_TX_TUNNEL_VXLAN |
-			       RTE_MBUF_F_TX_TUNNEL_GRE;
+			       RTE_MBUF_F_TX_TUNNEL_GRE |
+			       RTE_MBUF_F_TX_QINQ;
 	return (flags & mask) ? 1 : 0;
 }
 
@@ -1171,6 +1180,10 @@ rnp_build_tx_control_desc(struct rnp_tx_queue *txq,
 		txbd->c.qword0.mss = rnp_cal_tso_seg(mbuf);
 		txbd->c.qword0.l4_len = mbuf->l4_len;
 	}
+	if (flags & RTE_MBUF_F_TX_QINQ) {
+		txbd->c.qword0.vlan_tci = mbuf->vlan_tci;
+		txbd->c.qword1.cmd |= RNP_TX_QINQ_INSERT;
+	}
 #define GRE_TUNNEL_KEY (4)
 #define GRE_TUNNEL_SEQ (4)
 	switch (flags & RTE_MBUF_F_TX_TUNNEL_MASK) {
@@ -1317,6 +1330,13 @@ rnp_setup_tx_offload(struct rnp_tx_queue *txq,
 	    flags & RTE_MBUF_F_TX_TCP_SEG ||
 	    flags & RTE_MBUF_F_TX_IP_CKSUM)
 		rnp_setup_csum_offload(tx_pkt, txbd);
+	if (flags & (RTE_MBUF_F_TX_VLAN |
+		     RTE_MBUF_F_TX_QINQ)) {
+		txbd->d.cmd |= RNP_TX_VLAN_VALID;
+		txbd->d.vlan_tci = (flags & RTE_MBUF_F_TX_QINQ) ?
+			tx_pkt->vlan_tci_outer : tx_pkt->vlan_tci;
+		txbd->d.cmd |= RNP_TX_VLAN_INSERT;
+	}
 }
 
 static __rte_always_inline uint16_t
-- 
2.25.1

