Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D20C3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:17:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4EF640DCE;
	Fri, 28 Mar 2025 06:15:45 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 6E66040664
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:42 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138937tws13x
X-QQ-Originating-IP: LJiQc2Z07/hf7rzKsEsngb183kwbGzV4q+b1/Tq41cE=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 448659904614502960
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 21/29] net/rnp: add unicast MAC filter operation
Date: Fri, 28 Mar 2025 05:14:36 +0000
Message-Id: <20250328051444.1019208-22-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: NdzMBwfAowx1kXrKsYivisDTguMyCrlTNqKD9Vd2bGgz4ibFZ7r8B83S
 dSBUtb4cUfcS1cG4+NmoPpa6o/74Mn3i+t9xNtED1974v9sNoBbtMeOVmUOGj08NN5XY7aA
 Pv5vOJdHgZXc3ChrbIF4RVOKoeWIW8/x0UXFLfa8XDCIbJHsTz6q+gRpDsb8s18zC9h3MvL
 yrei8FilrHzehMVD/vAx6nYru6UzXFaV+jm1++gOChyLa2e9/2m5PMfdVnXtxj9b53o7vkB
 stTtZLtTDtM+DhDG7lLfyTwKGEHEB6ax1W0IgBGfbfnjcR0FPcVeFOM/+FXvS8nCBzIuHSK
 uGWGJLoMUOg5Z7xMnhxib2kfOQj5AEml3Kqd9Nk6AJODvHqVJ5YRV+OE8TciLrsEkuXXazN
 eAFmrvhaekOFZT8UPYcs2v1MaxJgNA7ypAFmQoC2k/i5qjaNeVxB/S33Ax92iUlGIDgRsxm
 cLh8976KrOC/vnRsemV1AkQpt54Ijl8kPxICE1jdyojCl6c58zvUKwPm+FiQdYFZaYQOUVn
 I3sBY8WXUk64n8UU5s2IDDOE5HWEXKr8nnLvbjtXvpUL3qc2SZoG2cNm2a1tjUMQ15/JXl4
 MC2xOV+5+yNWyPOPNv4QQlo6QpNrufCwMhIurCfXBf7ZdtM0A3EXeClppgbRbOhlcDmeNxv
 d4//iycp0USF9U0b4yqKWDFCZybq4Lzv7Z/RR6FZQzq8iBlwXFzU2vWLhAMm0F8oqKbYlDc
 sr9v2j9rbm8izcqocCSVioMG9t7gSYKiBSpMIkcv5XBgtAUKDZCWzS/AUZxTafDBHMkrP/f
 5C9JdPToE2YROr/jCbEZnrUMsNfnGKf0bVRcJa1tL5kCPbF0XWSt77uoIpFOyyJRyziE2iU
 XCuYfOs35aMO/gmnjX16LAxA6cD35eFe9XcWG7CT4DsujLMzRSUJehBihxoRP9abNRb/WdN
 ilM9zmCFGVFDvra7dLaqdaZo1iAsSdYB6Tqs277Nb69PVSQcfvXqEn7JVn0Mnn+SObLUZwW
 k80q1G8qPf0yB35Dlo553eca9fpYqI/gE2Ped/e2WE4RaoibbnGHeaKomv5E88CyqDfwAqG
 p1qKQr8xk5XfZ9nx3/Nxdk=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

add mac filter for single/multiple port.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |  1 +
 doc/guides/nics/rnp.rst             |  6 ++
 drivers/net/rnp/base/rnp_eth_regs.h |  4 ++
 drivers/net/rnp/base/rnp_hw.h       |  3 +
 drivers/net/rnp/base/rnp_mac.c      | 91 +++++++++++++++++++++++++++++
 drivers/net/rnp/base/rnp_mac.h      |  2 +
 drivers/net/rnp/base/rnp_mac_regs.h |  4 ++
 drivers/net/rnp/rnp.h               |  4 ++
 drivers/net/rnp/rnp_ethdev.c        | 62 ++++++++++++++++++--
 9 files changed, 171 insertions(+), 6 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 14ff88fec1..00b23b0fa2 100644
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
index e1e6b6d843..1e1f471673 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -44,6 +44,7 @@ Features
 - Promiscuous mode
 - Link state information
 - MTU update
+- MAC filtering
 - Jumbo frames
 - Scatter-Gather IO support
 - Port hardware statistic
@@ -86,6 +87,9 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_set_link_up``
 * ``rte_eth_dev_get_mtu``
 * ``rte_eth_dev_set_mtu``
+* ``rte_eth_dev_default_mac_addr_set``
+* ``rte_eth_dev_mac_addr_add``
+* ``rte_eth_dev_mac_addr_remove``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
@@ -101,3 +105,5 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_xstats_get``
 * ``rte_eth_xstats_reset``
 * ``rte_eth_xstats_get_names``
+* ``rte_eth_macaddr_get``
+* ``rte_eth_macaddrs_get``
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index adac817df2..49860135bd 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -64,5 +64,9 @@
 #define RNP_RSS_KEY_TABLE(idx)	_ETH_(0x92d0 + ((idx) * 0x4))
 
 #define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
+/* host mac address filter */
+#define RNP_RAL_BASE_ADDR(n)	_ETH_(0xA000 + (0x04 * (n)))
+#define RNP_RAH_BASE_ADDR(n)	_ETH_(0xA400 + (0x04 * (n)))
+#define RNP_MAC_FILTER_EN	RTE_BIT32(31)
 
 #endif /* _RNP_ETH_REGS_H */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 72e66338a0..e5a19a1918 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -71,6 +71,9 @@ struct rnp_mac_ops {
 	int (*get_macaddr)(struct rnp_eth_port *port, u8 *mac);
 	/* update mac packet filter mode */
 	int (*update_mpfm)(struct rnp_eth_port *port, u32 mode, bool en);
+	/* Receive Address Filter table */
+	int (*set_rafb)(struct rnp_eth_port *port, const u8 *mac, u32 index);
+	int (*clear_rafb)(struct rnp_eth_port *port, u32 index);
 };
 
 struct rnp_eth_adapter;
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index 52d8a47437..6ad2ca0a4a 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -95,14 +95,89 @@ rnp_update_mpfm_pf(struct rnp_eth_port *port, u32 mode, bool en)
 	return 0;
 }
 
+static int
+rnp_set_mac_addr_pf(struct rnp_eth_port *port,
+		    const u8 *addr, u32 index)
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
+		       const u8 *addr, u32 index)
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
@@ -122,6 +197,22 @@ int rnp_update_mpfm(struct rnp_eth_port *port,
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
index 4fd907a601..56ad6ec015 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -78,6 +78,10 @@
 /* PHY Link Status */
 #define RNP_MAC_PLS		RTE_BIT32(17)
 
+/* Rx macaddr filter ctrl */
+#define RNP_MAC_ADDR_HI(n)	(0x0300 + ((n) * 0x8))
+#define RNP_MAC_AE		RTE_BIT32(31)
+#define RNP_MAC_ADDR_LO(n)	(0x0304 + ((n) * 0x8))
 /* Mac Manage Counts */
 #define RNP_MMC_CTRL		(0x0800)
 #define RNP_MMC_RSTONRD	RTE_BIT32(2)
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index f1042e5ed8..e4c677a179 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -59,6 +59,10 @@
 #define RNP_MAX_HASH_MC_MAC_SIZE	(4096)	/* max multicast hash mac num */
 #define RNP_MAX_UC_HASH_TABLE		(128)	/* max unicast hash mac filter table */
 #define RNP_MAC_MC_HASH_TABLE		(128)	/* max multicast hash mac filter table*/
+/* Peer port own independent resource */
+#define RNP_PORT_MAX_MACADDR         (32)
+#define RNP_PORT_MAX_MC_HASH_TB      (8)
+#define RNP_PORT_MAX_MC_MAC_SIZE     (RNP_PORT_MAX_MC_HASH_TB * 32)
 /* hardware media type */
 enum rnp_media_type {
 	RNP_MEDIA_TYPE_UNKNOWN,
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 00f3ec6a65..c963cc755f 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -599,7 +599,6 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->max_tx_queues = port->attr.max_tx_queues;
 	/* mac filter info */
 	dev_info->max_mac_addrs = port->attr.max_mac_addrs;
-	dev_info->max_hash_mac_addrs = port->attr.max_uc_mac_hash;
 	/* for RSS offload just support four tuple */
 	dev_info->flow_type_rss_offloads = RNP_SUPPORT_RSS_OFFLOAD_ALL;
 	dev_info->hash_key_size = RNP_MAX_HASH_KEY_SIZE * sizeof(uint32_t);
@@ -1149,6 +1148,44 @@ rnp_dev_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
 	return count;
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
+		RNP_PMD_ERR("mac add index %u is of range", index);
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
+		RNP_PMD_ERR("mac add index %u is of range", index);
+		return;
+	}
+	rnp_clear_macaddr(port, index);
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_configure                = rnp_dev_configure,
@@ -1187,6 +1224,10 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.link_update                  = rnp_dev_link_update,
 	.dev_set_link_up              = rnp_dev_set_link_up,
 	.dev_set_link_down            = rnp_dev_set_link_down,
+	/* mac address filter */
+	.mac_addr_set                 = rnp_dev_mac_addr_set,
+	.mac_addr_add                 = rnp_dev_mac_addr_add,
+	.mac_addr_remove              = rnp_dev_mac_addr_remove,
 };
 
 static void
@@ -1209,11 +1250,19 @@ rnp_setup_port_attr(struct rnp_eth_port *port,
 	attr->max_rx_queues = RNP_MAX_RX_QUEUE_NUM / hw->max_port_num;
 	attr->max_tx_queues = RNP_MAX_TX_QUEUE_NUM / hw->max_port_num;
 
-	attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
-	attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
-	attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
-	attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
-	attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+	if (hw->nic_mode > RNP_SINGLE_10G) {
+		attr->max_mac_addrs = RNP_PORT_MAX_MACADDR;
+		attr->max_uc_mac_hash = 0;
+		attr->max_mc_mac_hash = RNP_PORT_MAX_MC_MAC_SIZE;
+		attr->uc_hash_tb_size = 0;
+		attr->mc_hash_tb_size = RNP_PORT_MAX_MC_HASH_TB;
+	} else {
+		attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
+		attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
+		attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
+		attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
+		attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+	}
 	rnp_mbx_fw_get_lane_stat(port);
 
 	RNP_PMD_INFO("PF[%d] SW-ETH-PORT[%d]<->PHY_LANE[%d]",
@@ -1256,6 +1305,7 @@ rnp_init_port_resource(struct rnp_eth_adapter *adapter,
 		rte_eth_random_addr(port->mac_addr.addr_bytes);
 	}
 	rte_ether_addr_copy(&port->mac_addr, &eth_dev->data->mac_addrs[0]);
+	rnp_set_macaddr(port, (u8 *)&port->mac_addr, 0);
 
 	rte_spinlock_init(&port->rx_mac_lock);
 	adapter->ports[p_id] = port;
-- 
2.25.1

