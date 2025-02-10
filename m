Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A7C0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:30:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 735C5427AE;
	Mon, 10 Feb 2025 08:28:02 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 57C7740EDD
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:27:49 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id CCBA3A3A40; Mon, 10 Feb 2025 15:27:20 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v8 21/28] net/rnp: add unicast MAC filter operation
Date: Mon, 10 Feb 2025 15:26:48 +0800
Message-Id: <1739172415-48507-22-git-send-email-caowenbo@mucse.com>
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

add mac filter for single/multiple port.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |  1 +
 doc/guides/nics/rnp.rst             |  1 +
 drivers/net/rnp/base/rnp_eth_regs.h |  4 ++
 drivers/net/rnp/base/rnp_hw.h       |  3 +
 drivers/net/rnp/base/rnp_mac.c      | 91 +++++++++++++++++++++++++++++
 drivers/net/rnp/base/rnp_mac.h      |  2 +
 drivers/net/rnp/base/rnp_mac_regs.h |  5 +-
 drivers/net/rnp/rnp.h               |  4 ++
 drivers/net/rnp/rnp_ethdev.c        | 61 +++++++++++++++++--
 9 files changed, 166 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index c782efe2fb..de7e72c023 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -14,6 +14,7 @@ Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 MTU update           = Y
+Unicast MAC filter   = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index ec6f3f9dbb..3315ff7f53 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -17,6 +17,7 @@ Features
 - Promiscuous mode
 - Link state information
 - MTU update
+- MAC filtering
 - Jumbo frames
 - Scatter-Gather IO support
 - Port hardware statistic
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index ada42be8e9..8a448b9eec 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -63,5 +63,9 @@
 #define RNP_RSS_KEY_TABLE(idx)	_ETH_(0x92d0 + ((idx) * 0x4))
 
 #define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
+/* host mac address filter */
+#define RNP_RAL_BASE_ADDR(n)	_ETH_(0xA000 + (0x04 * (n)))
+#define RNP_RAH_BASE_ADDR(n)	_ETH_(0xA400 + (0x04 * (n)))
+#define RNP_MAC_FILTER_EN	RTE_BIT32(31)
 
 #endif /* _RNP_ETH_REGS_H */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 0ec536e488..73fe34ad4e 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -71,6 +71,9 @@ struct rnp_mac_ops {
 	int (*get_macaddr)(struct rnp_eth_port *port, u8 *mac);
 	/* update mac packet filter mode */
 	int (*update_mpfm)(struct rnp_eth_port *port, u32 mode, bool en);
+	/* Receive Address Filter table */
+	int (*set_rafb)(struct rnp_eth_port *port, u8 *mac, u32 index);
+	int (*clear_rafb)(struct rnp_eth_port *port, u32 index);
 };
 
 struct rnp_eth_adapter;
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index 2c9499f1da..01929fd574 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -102,14 +102,89 @@ rnp_update_mpfm_pf(struct rnp_eth_port *port, u32 mode, bool en)
 	return 0;
 }
 
+static int
+rnp_set_mac_addr_pf(struct rnp_eth_port *port,
+		    u8 *addr, u32 index)
+{
+	struct rnp_hw *hw = port->hw;
+	u32 addr_hi = 0, addr_lo = 0;
+	u8 *mac = NULL;
+
+	mac = (u8 *)&addr_hi;
+	mac[0] = addr[1];
+	mac[1] = addr[0];
+	mac = (u8 *)&addr_lo;
+	mac[0] = addr[5];
+	mac[1] = addr[4];
+	mac[2] = addr[3];
+	mac[3] = addr[2];
+	addr_hi |= RNP_MAC_FILTER_EN;
+	RNP_E_REG_WR(hw, RNP_RAH_BASE_ADDR(index), addr_hi);
+	RNP_E_REG_WR(hw, RNP_RAL_BASE_ADDR(index), addr_lo);
+
+	return 0;
+}
+
+static int
+rnp_set_mac_addr_indep(struct rnp_eth_port *port,
+		       u8 *addr, u32 index)
+{
+	u16 lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u32 addr_hi = 0, addr_lo = 0;
+	u8 *mac = NULL;
+
+	mac = (u8 *)&addr_lo;
+	mac[0] = addr[0];
+	mac[1] = addr[1];
+	mac[2] = addr[2];
+	mac[3] = addr[3];
+	mac = (u8 *)&addr_hi;
+	mac[0] = addr[4];
+	mac[1] = addr[5];
+
+	addr_hi |= RNP_MAC_AE;
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_HI(index), addr_hi);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_LO(index), addr_lo);
+
+	return 0;
+}
+
+static int
+rnp_clear_mac_pf(struct rnp_eth_port *port, u32 index)
+{
+	struct rnp_hw *hw = port->hw;
+
+	RNP_E_REG_WR(hw, RNP_RAL_BASE_ADDR(index), 0);
+	RNP_E_REG_WR(hw, RNP_RAH_BASE_ADDR(index), 0);
+
+	return 0;
+}
+
+static int
+rnp_clear_mac_indep(struct rnp_eth_port *port, u32 index)
+{
+	u16 lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_HI(index), 0);
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_ADDR_LO(index), 0);
+
+	return 0;
+}
+
 const struct rnp_mac_ops rnp_mac_ops_pf = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
 	.update_mpfm = rnp_update_mpfm_pf,
+	.set_rafb = rnp_set_mac_addr_pf,
+	.clear_rafb = rnp_clear_mac_pf
 };
 
 const struct rnp_mac_ops rnp_mac_ops_indep = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
 	.update_mpfm = rnp_update_mpfm_indep,
+	.set_rafb = rnp_set_mac_addr_indep,
+	.clear_rafb = rnp_clear_mac_indep,
 };
 
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
@@ -129,6 +204,22 @@ int rnp_update_mpfm(struct rnp_eth_port *port,
 	return rnp_call_hwif_impl(port, mac_ops->update_mpfm, mode, en);
 }
 
+int rnp_set_macaddr(struct rnp_eth_port *port, u8 *mac, u32 index)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->set_rafb, mac, index);
+}
+
+int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->clear_rafb, index);
+}
+
 void rnp_mac_ops_init(struct rnp_hw *hw)
 {
 	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 1dac903396..865fc348df 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -24,6 +24,8 @@
 
 void rnp_mac_ops_init(struct rnp_hw *hw);
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac);
+int rnp_set_macaddr(struct rnp_eth_port *port, u8 *mac, u32 index);
+int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index);
 int rnp_update_mpfm(struct rnp_eth_port *port,
 		    u32 mode, bool en);
 
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 94aeba9d6c..85308a749e 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -77,7 +77,10 @@
 #define RNP_MAC_PLSDIS		RTE_BIT32(18)
 /* PHY Link Status */
 #define RNP_MAC_PLS		RTE_BIT32(17)
-
+/* Rx macaddr filter ctrl */
+#define RNP_MAC_ADDR_HI(n)	(0x0300 + ((n) * 0x8))
+#define RNP_MAC_AE		RTE_BIT32(31)
+#define RNP_MAC_ADDR_LO(n)	(0x0304 + ((n) * 0x8))
 /* Mac Manage Counts */
 #define RNP_MMC_CTRL		(0x0800)
 #define RNP_MMC_RSTONRD	RTE_BIT32(2)
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 8ef0658d67..af930800c6 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -56,6 +56,10 @@
 #define RNP_MAX_HASH_MC_MAC_SIZE	(4096)	/* max multicast hash mac num */
 #define RNP_MAX_UC_HASH_TABLE		(128)	/* max unicast hash mac filter table */
 #define RNP_MAC_MC_HASH_TABLE		(128)	/* max multicast hash mac filter table*/
+/* Peer port own independent resource */
+#define RNP_PORT_MAX_MACADDR         (32)
+#define RNP_PORT_MAX_UC_HASH_TB      (8)
+#define RNP_PORT_MAX_UC_MAC_SIZE     (RNP_PORT_MAX_UC_HASH_TB * 32)
 /* hardware media type */
 enum rnp_media_type {
 	RNP_MEDIA_TYPE_UNKNOWN,
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 29cf60a9bd..2b66f572e7 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -1155,6 +1155,44 @@ rnp_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
 	return xstats_cnt;
 }
 
+static int
+rnp_dev_mac_addr_set(struct rte_eth_dev *dev,
+		     struct rte_ether_addr *mac_addr)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	return rnp_set_macaddr(port, (u8 *)mac_addr, 0);
+}
+
+static int
+rnp_dev_mac_addr_add(struct rte_eth_dev *dev,
+		     struct rte_ether_addr *mac_addr,
+		     uint32_t index,
+		     uint32_t vmdq __rte_unused)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	if (index >= port->attr.max_mac_addrs) {
+		RNP_PMD_ERR("mac add index %d is of range", index);
+		return -EINVAL;
+	}
+
+	return rnp_set_macaddr(port, (u8 *)mac_addr, index);
+}
+
+static void
+rnp_dev_mac_addr_remove(struct rte_eth_dev *dev,
+			uint32_t index)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	if (index >= port->attr.max_mac_addrs) {
+		RNP_PMD_ERR("mac add index %d is of range", index);
+		return;
+	}
+	rnp_clear_macaddr(port, index);
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -1188,6 +1226,10 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.link_update                  = rnp_dev_link_update,
 	.dev_set_link_up              = rnp_dev_set_link_up,
 	.dev_set_link_down            = rnp_dev_set_link_down,
+	/* mac address filter */
+	.mac_addr_set                 = rnp_dev_mac_addr_set,
+	.mac_addr_add                 = rnp_dev_mac_addr_add,
+	.mac_addr_remove              = rnp_dev_mac_addr_remove,
 };
 
 static void
@@ -1210,11 +1252,19 @@ rnp_setup_port_attr(struct rnp_eth_port *port,
 	attr->max_rx_queues = RNP_MAX_RX_QUEUE_NUM / hw->max_port_num;
 	attr->max_tx_queues = RNP_MAX_TX_QUEUE_NUM / hw->max_port_num;
 
-	attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
-	attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
-	attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
-	attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
-	attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+	if (hw->nic_mode > RNP_SINGLE_10G) {
+		attr->max_mac_addrs = RNP_PORT_MAX_MACADDR;
+		attr->max_uc_mac_hash = RNP_PORT_MAX_UC_MAC_SIZE;
+		attr->max_mc_mac_hash = 0;
+		attr->uc_hash_tb_size = RNP_PORT_MAX_UC_HASH_TB;
+		attr->mc_hash_tb_size = 0;
+	} else {
+		attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
+		attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
+		attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
+		attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
+		attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+	}
 	rnp_mbx_fw_get_lane_stat(port);
 
 	RNP_PMD_INFO("PF[%d] SW-ETH-PORT[%d]<->PHY_LANE[%d]",
@@ -1257,6 +1307,7 @@ rnp_init_port_resource(struct rnp_eth_adapter *adapter,
 		rte_eth_random_addr(port->mac_addr.addr_bytes);
 	}
 	rte_ether_addr_copy(&port->mac_addr, &eth_dev->data->mac_addrs[0]);
+	rnp_set_macaddr(port, (u8 *)&port->mac_addr, 0);
 
 	rte_spinlock_init(&port->rx_mac_lock);
 	adapter->ports[p_id] = port;
-- 
2.34.1

