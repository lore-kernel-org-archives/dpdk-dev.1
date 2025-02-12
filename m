Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D20C021A1
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 14:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09510427B8;
	Wed, 12 Feb 2025 15:36:44 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 5AA6F4279B
 for <dev@dpdk.org>; Wed, 12 Feb 2025 15:36:39 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 88F6A6654DA; Wed, 12 Feb 2025 22:36:38 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v11 06/28] net/rnp: add get device information operation
Date: Wed, 12 Feb 2025 22:36:03 +0800
Message-Id: <1739370987-3989-7-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
References: <1739370987-3989-1-git-send-email-caowenbo@mucse.com>
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

add get device hardware capability function

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini  |   1 +
 drivers/net/rnp/base/rnp_fw_cmd.c |  20 ++++++
 drivers/net/rnp/base/rnp_fw_cmd.h |  80 +++++++++++++++++++++
 drivers/net/rnp/base/rnp_mbx_fw.c |  58 ++++++++++++++++
 drivers/net/rnp/base/rnp_mbx_fw.h |   1 +
 drivers/net/rnp/rnp.h             |  73 ++++++++++++++++++-
 drivers/net/rnp/rnp_ethdev.c      | 112 +++++++++++++++++++++++++++++-
 7 files changed, 343 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 2ad04ee330..6766130a68 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -4,5 +4,6 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Speed capabilities   = Y
 Linux                = Y
 x86-64               = Y
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.c b/drivers/net/rnp/base/rnp_fw_cmd.c
index 064ba9e045..34a88a154f 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.c
+++ b/drivers/net/rnp/base/rnp_fw_cmd.c
@@ -51,6 +51,23 @@ rnp_build_get_macaddress_req(struct rnp_mbx_fw_cmd_req *req,
 	arg->pfvf_num = req_arg->param1;
 }
 
+static inline void
+rnp_build_get_lane_status_req(struct rnp_mbx_fw_cmd_req *req,
+			      struct rnp_fw_req_arg *req_arg,
+			      void *cookie)
+{
+	struct rnp_get_lane_st_req *arg = (struct rnp_get_lane_st_req *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_GET_LANE_STATUS;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->nr_lane = req_arg->param0;
+}
+
 int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 			struct rnp_fw_req_arg *arg,
 			void *cookie)
@@ -67,6 +84,9 @@ int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 	case RNP_GET_MAC_ADDRESS:
 		rnp_build_get_macaddress_req(req, arg, cookie);
 		break;
+	case RNP_GET_LANE_STATUS:
+		rnp_build_get_lane_status_req(req, arg, cookie);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.h b/drivers/net/rnp/base/rnp_fw_cmd.h
index 0a0521b824..6dde717390 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.h
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -129,6 +129,80 @@ struct rnp_mac_addr_rep {
 	u32 pcode;
 };
 
+#define RNP_SPEED_CAP_UNKNOWN    (0)
+#define RNP_SPEED_CAP_10M_FULL   RTE_BIT32(2)
+#define RNP_SPEED_CAP_100M_FULL  RTE_BIT32(3)
+#define RNP_SPEED_CAP_1GB_FULL   RTE_BIT32(4)
+#define RNP_SPEED_CAP_10GB_FULL  RTE_BIT32(5)
+#define RNP_SPEED_CAP_40GB_FULL  RTE_BIT32(6)
+#define RNP_SPEED_CAP_25GB_FULL  RTE_BIT32(7)
+#define RNP_SPEED_CAP_50GB_FULL  RTE_BIT32(8)
+#define RNP_SPEED_CAP_100GB_FULL RTE_BIT32(9)
+#define RNP_SPEED_CAP_10M_HALF   RTE_BIT32(10)
+#define RNP_SPEED_CAP_100M_HALF  RTE_BIT32(11)
+#define RNP_SPEED_CAP_1GB_HALF   RTE_BIT32(12)
+
+enum rnp_pma_phy_type {
+	RNP_PHY_TYPE_NONE = 0,
+	RNP_PHY_TYPE_1G_BASE_KX,
+	RNP_PHY_TYPE_SGMII,
+	RNP_PHY_TYPE_10G_BASE_KR,
+	RNP_PHY_TYPE_25G_BASE_KR,
+	RNP_PHY_TYPE_40G_BASE_KR4,
+	RNP_PHY_TYPE_10G_BASE_SR,
+	RNP_PHY_TYPE_40G_BASE_SR4,
+	RNP_PHY_TYPE_40G_BASE_CR4,
+	RNP_PHY_TYPE_40G_BASE_LR4,
+	RNP_PHY_TYPE_10G_BASE_LR,
+	RNP_PHY_TYPE_10G_BASE_ER,
+	RNP_PHY_TYPE_10G_TP,
+};
+
+struct rnp_lane_stat_rep {
+	u8 nr_lane;		/* 0-3 cur port correspond with hw lane */
+	u8 pci_gen		: 4; /* nic cur pci speed genX: 1,2,3 */
+	u8 pci_lanes		: 4; /* nic cur pci x1 x2 x4 x8 x16 */
+	u8 pma_type;
+	u8 phy_type;		/* interface media type */
+
+	u16 linkup		: 1; /* cur port link state */
+	u16 duplex		: 1; /* duplex state only RJ45 valid */
+	u16 autoneg		: 1; /* autoneg state */
+	u16 fec			: 1; /* fec state */
+	u16 rev_an		: 1;
+	u16 link_traing		: 1; /* link-traing state */
+	u16 media_available	: 1;
+	u16 is_sgmii		: 1; /* 1: Twisted Pair 0: FIBRE */
+	u16 link_fault		: 4;
+#define RNP_LINK_LINK_FAULT	RTE_BIT32(0)
+#define RNP_LINK_TX_FAULT	RTE_BIT32(1)
+#define RNP_LINK_RX_FAULT	RTE_BIT32(2)
+#define RNP_LINK_REMOTE_FAULT	RTE_BIT32(3)
+	u16 is_backplane	: 1;   /* Backplane Mode */
+	u16 is_speed_10G_1G_auto_switch_enabled : 1;
+	u16 rsvd0		: 2;
+	union {
+		u8 phy_addr;	/* Phy MDIO address */
+		struct {
+			u8 mod_abs : 1;
+			u8 fault   : 1;
+			u8 tx_dis  : 1;
+			u8 los     : 1;
+			u8 rsvd1   : 4;
+		} sfp;
+	};
+	u8 sfp_connector;
+	u32 speed;		/* Current Speed Value */
+
+	u32 si_main;
+	u32 si_pre;
+	u32 si_post;
+	u32 si_tx_boost;
+	u32 supported_link;	/* Cur nic Support Link cap */
+	u32 phy_id;
+	u32 rsvd;
+};
+
 #define RNP_FW_REP_DATA_NUM	(40)
 struct rnp_mbx_fw_cmd_reply {
 	u16 flags;
@@ -174,6 +248,12 @@ struct rnp_get_phy_ablity {
 	u32 rsv[7];
 };
 
+struct rnp_get_lane_st_req {
+	u32 nr_lane;
+
+	u32 rsv[7];
+};
+
 struct rnp_mbx_fw_cmd_req {
 	u16 flags;
 	u16 opcode;
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index 75e7b53f15..00926f2a1b 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -336,3 +336,61 @@ rnp_mbx_fw_get_macaddr(struct rnp_eth_port *port,
 
 	return -ENOMSG;
 }
+
+int
+rnp_mbx_fw_get_lane_stat(struct rnp_eth_port *port)
+{
+	struct rnp_phy_meta *phy_meta = &port->attr.phy_meta;
+	u8 data[RNP_FW_REP_DATA_NUM] = {0};
+	struct rnp_lane_stat_rep *lane_stat;
+	u32 nr_lane = port->attr.nr_lane;
+	struct rnp_fw_req_arg arg;
+	u32 user_set_speed = 0;
+	int err;
+
+	RTE_BUILD_BUG_ON(sizeof(*lane_stat) != RNP_FW_REP_DATA_NUM);
+	memset(&arg, 0, sizeof(arg));
+	lane_stat = (struct rnp_lane_stat_rep *)&data;
+	arg.opcode = RNP_GET_LANE_STATUS;
+	arg.param0 = nr_lane;
+
+	err = rnp_fw_send_cmd(port, &arg, &data);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
+		return err;
+	}
+	phy_meta->supported_link = lane_stat->supported_link;
+	phy_meta->is_backplane = lane_stat->is_backplane;
+	phy_meta->phy_identifier = lane_stat->phy_addr;
+	phy_meta->link_autoneg = lane_stat->autoneg;
+	phy_meta->link_duplex = lane_stat->duplex;
+	phy_meta->phy_type = lane_stat->phy_type;
+	phy_meta->is_sgmii = lane_stat->is_sgmii;
+	phy_meta->fec = lane_stat->fec;
+
+	if (phy_meta->is_sgmii) {
+		phy_meta->media_type = RNP_MEDIA_TYPE_COPPER;
+		phy_meta->supported_link |=
+			RNP_SPEED_CAP_100M_HALF | RNP_SPEED_CAP_10M_HALF;
+	} else if (phy_meta->is_backplane) {
+		phy_meta->media_type = RNP_MEDIA_TYPE_BACKPLANE;
+	} else {
+		phy_meta->media_type = RNP_MEDIA_TYPE_FIBER;
+	}
+	if (phy_meta->phy_type == RNP_PHY_TYPE_10G_TP) {
+		phy_meta->supported_link |= RNP_SPEED_CAP_1GB_FULL;
+		phy_meta->supported_link |= RNP_SPEED_CAP_10GB_FULL;
+	}
+	if (!phy_meta->link_autoneg) {
+		/* firmware don't support upload info just use user info */
+		if (phy_meta->media_type == RNP_MEDIA_TYPE_COPPER) {
+			user_set_speed = port->eth_dev->data->dev_conf.link_speeds;
+			if (user_set_speed & RTE_ETH_LINK_SPEED_FIXED)
+				phy_meta->link_autoneg = 0;
+			else
+				phy_meta->link_autoneg = 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.h b/drivers/net/rnp/base/rnp_mbx_fw.h
index 255d913a97..fd0110b539 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.h
+++ b/drivers/net/rnp/base/rnp_mbx_fw.h
@@ -12,6 +12,7 @@ struct rnp_eth_port;
 
 int rnp_mbx_fw_get_macaddr(struct rnp_eth_port *port, u8 *mac_addr);
 int rnp_mbx_fw_get_capability(struct rnp_eth_port *port);
+int rnp_mbx_fw_get_lane_stat(struct rnp_eth_port *port);
 int rnp_mbx_fw_reset_phy(struct rnp_hw *hw);
 int rnp_fw_init(struct rnp_hw *hw);
 
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 5db92566cc..b777aa2a4a 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -14,10 +14,81 @@
 #define RNP_MAX_VF_NUM		(64)
 #define RNP_MISC_VEC_ID		RTE_INTR_VEC_ZERO_OFFSET
 /* maximum frame size supported */
+#define RNP_ETH_OVERHEAD \
+	(RTE_ETHER_HDR_LEN + RTE_VLAN_HLEN * 2)
 #define RNP_MAC_MAXFRM_SIZE	(9590)
 
+#define RNP_RX_MAX_MTU_SEG	(64)
+#define RNP_TX_MAX_MTU_SEG	(32)
+#define RNP_RX_MAX_SEG		(150)
+#define RNP_TX_MAX_SEG		(UINT8_MAX)
+#define RNP_MIN_DMA_BUF_SIZE	(1024)
+/* rss support info */
+#define RNP_RSS_INDIR_SIZE	(128)
+#define RNP_MAX_HASH_KEY_SIZE	(10)
+#define RNP_SUPPORT_RSS_OFFLOAD_ALL ( \
+		RTE_ETH_RSS_IPV4 | \
+		RTE_ETH_RSS_FRAG_IPV4 | \
+		RTE_ETH_RSS_NONFRAG_IPV4_OTHER | \
+		RTE_ETH_RSS_NONFRAG_IPV4_TCP | \
+		RTE_ETH_RSS_NONFRAG_IPV4_UDP | \
+		RTE_ETH_RSS_NONFRAG_IPV4_SCTP |\
+		RTE_ETH_RSS_IPV6 | \
+		RTE_ETH_RSS_FRAG_IPV6 | \
+		RTE_ETH_RSS_NONFRAG_IPV6_OTHER | \
+		RTE_ETH_RSS_IPV6_EX | \
+		RTE_ETH_RSS_IPV6_TCP_EX | \
+		RTE_ETH_RSS_NONFRAG_IPV6_TCP | \
+		RTE_ETH_RSS_NONFRAG_IPV6_UDP | \
+		RTE_ETH_RSS_IPV6_UDP_EX | \
+		RTE_ETH_RSS_NONFRAG_IPV6_SCTP)
+/* Ring info special */
+#define RNP_MAX_BD_COUNT	(4096)
+#define RNP_MIN_BD_COUNT	(128)
+#define RNP_BD_ALIGN		(2)
+/* Hardware resource info */
+#define RNP_MAX_MSIX_NUM		(64)
+#define RNP_MAX_RX_QUEUE_NUM		(128)
+#define RNP_MAX_TX_QUEUE_NUM		(128)
+/* l2 filter hardware resource info */
+#define RNP_MAX_MAC_ADDRS		(128)	/* max unicast extract mac num */
+#define RNP_MAX_HASH_UC_MAC_SIZE	(4096)	/* max unicast hash mac num */
+#define RNP_MAX_HASH_MC_MAC_SIZE	(4096)	/* max multicast hash mac num */
+#define RNP_MAX_UC_HASH_TABLE		(128)	/* max unicast hash mac filter table */
+#define RNP_MAC_MC_HASH_TABLE		(128)	/* max multicast hash mac filter table*/
+/* hardware media type */
+enum rnp_media_type {
+	RNP_MEDIA_TYPE_UNKNOWN,
+	RNP_MEDIA_TYPE_FIBER,
+	RNP_MEDIA_TYPE_COPPER,
+	RNP_MEDIA_TYPE_BACKPLANE,
+	RNP_MEDIA_TYPE_NONE,
+};
+
+struct rnp_phy_meta {
+	uint32_t speed_cap;
+	uint32_t supported_link;
+	uint16_t link_duplex;
+	uint16_t link_autoneg;
+	uint32_t phy_identifier;
+	uint16_t phy_type;
+	uint8_t media_type;
+	bool is_sgmii;
+	bool is_backplane;
+	bool fec;
+};
+
 struct rnp_port_attr {
-	uint16_t max_mac_addrs;	/* max support mac address */
+	uint16_t max_mac_addrs;	  /* max support mac address */
+	uint16_t max_uc_mac_hash; /* max hash unicast mac size */
+	uint16_t max_mc_mac_hash; /* max hash multicast mac size */
+	uint16_t uc_hash_tb_size; /* max unicast hash table block num */
+	uint16_t mc_hash_tb_size; /* max multicast hash table block num */
+	uint16_t max_rx_queues;   /* belong to this port rxq resource */
+	uint16_t max_tx_queues;   /* belong to this port txq resource */
+
+	struct rnp_phy_meta phy_meta;
+
 	uint16_t port_id;	/* platform manage port sequence id */
 	uint8_t port_offset;	/* port queue offset */
 	uint8_t sw_id;		/* software port init sequence id */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 41973f2a2e..e746401d6e 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -10,6 +10,7 @@
 #include "rnp.h"
 #include "rnp_logs.h"
 #include "base/rnp_mbx.h"
+#include "base/rnp_fw_cmd.h"
 #include "base/rnp_mbx_fw.h"
 #include "base/rnp_mac.h"
 #include "base/rnp_eth_regs.h"
@@ -89,10 +90,110 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static uint32_t
+rnp_get_speed_caps(struct rte_eth_dev *dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint32_t speed_cap = 0;
+	uint32_t i = 0, speed;
+	uint32_t support_link;
+	uint32_t link_types;
+
+	support_link = port->attr.phy_meta.supported_link;
+	link_types = rte_popcount64(support_link);
+	if (!link_types)
+		return 0;
+	for (i = 0; i < link_types; i++) {
+		speed = ffs(support_link) - 1;
+		switch (RTE_BIT32(speed)) {
+		case RNP_SPEED_CAP_10M_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_10M;
+			break;
+		case RNP_SPEED_CAP_100M_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_100M;
+			break;
+		case RNP_SPEED_CAP_1GB_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_1G;
+			break;
+		case RNP_SPEED_CAP_10GB_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_10G;
+			break;
+		case RNP_SPEED_CAP_40GB_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_40G;
+			break;
+		case RNP_SPEED_CAP_25GB_FULL:
+			speed_cap |= RTE_ETH_LINK_SPEED_25G;
+			break;
+		case RNP_SPEED_CAP_10M_HALF:
+			speed_cap |= RTE_ETH_LINK_SPEED_10M_HD;
+			break;
+		case RNP_SPEED_CAP_100M_HALF:
+			speed_cap |= RTE_ETH_LINK_SPEED_100M_HD;
+			break;
+		}
+		support_link &= ~RTE_BIT32(speed);
+	}
+	if (!port->attr.phy_meta.link_autoneg)
+		speed_cap |= RTE_ETH_LINK_SPEED_FIXED;
+
+	return speed_cap;
+}
+
+static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
+			     struct rte_eth_dev_info *dev_info)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim){
+		.nb_max = RNP_MAX_BD_COUNT,
+		.nb_min = RNP_MIN_BD_COUNT,
+		.nb_align = RNP_BD_ALIGN,
+		.nb_seg_max = RNP_RX_MAX_SEG,
+		.nb_mtu_seg_max = RNP_RX_MAX_MTU_SEG,
+	};
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim){
+		.nb_max = RNP_MAX_BD_COUNT,
+		.nb_min = RNP_MIN_BD_COUNT,
+		.nb_align = RNP_BD_ALIGN,
+		.nb_seg_max = RNP_TX_MAX_SEG,
+		.nb_mtu_seg_max = RNP_TX_MAX_MTU_SEG,
+	};
+
+	dev_info->max_rx_pktlen = RNP_MAC_MAXFRM_SIZE;
+	dev_info->min_mtu = RTE_ETHER_MIN_MTU;
+	dev_info->max_mtu = dev_info->max_rx_pktlen - RNP_ETH_OVERHEAD;
+	dev_info->min_rx_bufsize = RNP_MIN_DMA_BUF_SIZE;
+	dev_info->max_rx_queues = port->attr.max_rx_queues;
+	dev_info->max_tx_queues = port->attr.max_tx_queues;
+	/* mac filter info */
+	dev_info->max_mac_addrs = port->attr.max_mac_addrs;
+	dev_info->max_hash_mac_addrs = port->attr.max_uc_mac_hash;
+	/* for RSS offload just support four tuple */
+	dev_info->flow_type_rss_offloads = RNP_SUPPORT_RSS_OFFLOAD_ALL;
+	dev_info->hash_key_size = RNP_MAX_HASH_KEY_SIZE * sizeof(uint32_t);
+	dev_info->reta_size = RNP_RSS_INDIR_SIZE;
+	/* speed cap info */
+	dev_info->speed_capa = rnp_get_speed_caps(eth_dev);
+
+	dev_info->default_rxconf = (struct rte_eth_rxconf) {
+		.rx_drop_en = 0,
+		.offloads = 0,
+	};
+
+	dev_info->default_txconf = (struct rte_eth_txconf) {
+		.offloads = 0,
+	};
+
+	return 0;
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_close                    = rnp_dev_close,
 	.dev_stop                     = rnp_dev_stop,
+	.dev_infos_get                = rnp_dev_infos_get,
 };
 
 static void
@@ -111,7 +212,16 @@ rnp_setup_port_attr(struct rnp_eth_port *port,
 	attr->port_offset = RNP_E_REG_RD(hw, RNP_TC_PORT_OFFSET(lane));
 	attr->nr_lane = lane;
 	attr->sw_id = sw_id;
-	attr->max_mac_addrs = 1;
+
+	attr->max_rx_queues = RNP_MAX_RX_QUEUE_NUM / hw->max_port_num;
+	attr->max_tx_queues = RNP_MAX_TX_QUEUE_NUM / hw->max_port_num;
+
+	attr->max_mac_addrs = RNP_MAX_MAC_ADDRS;
+	attr->max_uc_mac_hash = RNP_MAX_HASH_UC_MAC_SIZE;
+	attr->max_mc_mac_hash = RNP_MAX_HASH_MC_MAC_SIZE;
+	attr->uc_hash_tb_size = RNP_MAX_UC_HASH_TABLE;
+	attr->mc_hash_tb_size = RNP_MAC_MC_HASH_TABLE;
+	rnp_mbx_fw_get_lane_stat(port);
 
 	RNP_PMD_INFO("PF[%d] SW-ETH-PORT[%d]<->PHY_LANE[%d]",
 			hw->mbx.pf_num, sw_id, lane);
-- 
2.34.1

