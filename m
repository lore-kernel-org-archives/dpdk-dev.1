Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D510BC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 07:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 055B840E72;
	Mon, 10 Feb 2025 08:27:34 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 5B02F40E44
 for <dev@dpdk.org>; Mon, 10 Feb 2025 08:27:31 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 99B0AA3351; Mon, 10 Feb 2025 15:27:04 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v8 07/28] net/rnp: add support mac promisc mode
Date: Mon, 10 Feb 2025 15:26:34 +0800
Message-Id: <1739172415-48507-8-git-send-email-caowenbo@mucse.com>
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

add support two method of mac unicast promisc
mulcast promisc broadcast promisc mode

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   2 +
 doc/guides/nics/rnp.rst             |   5 ++
 drivers/net/rnp/base/rnp_common.c   |   5 ++
 drivers/net/rnp/base/rnp_eth_regs.h |  15 ++++
 drivers/net/rnp/base/rnp_hw.h       |  12 ++-
 drivers/net/rnp/base/rnp_mac.c      | 114 +++++++++++++++++++++++++++-
 drivers/net/rnp/base/rnp_mac.h      |   2 +
 drivers/net/rnp/base/rnp_mac_regs.h |  39 ++++++++++
 drivers/net/rnp/base/rnp_osdep.h    |   5 ++
 drivers/net/rnp/rnp_ethdev.c        |  43 +++++++++++
 10 files changed, 240 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/rnp/base/rnp_mac_regs.h

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 6766130a68..65f1ed3da0 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -5,5 +5,7 @@
 ;
 [Features]
 Speed capabilities   = Y
+Promiscuous mode     = Y
+Allmulticast mode    = Y
 Linux                = Y
 x86-64               = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 618baa836a..62585acd4b 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -7,6 +7,11 @@ RNP Poll Mode driver
 The RNP ETHDEV PMD (**librte_net_rnp**) provides poll mode ethdev
 driver support for the inbuilt network device found in the **Mucse RNP**
 
+Features
+--------
+
+- Promiscuous mode
+
 Prerequisites
 -------------
 More information can be found at `Mucse, Official Website
diff --git a/drivers/net/rnp/base/rnp_common.c b/drivers/net/rnp/base/rnp_common.c
index 5cd4ec133e..5655126ae0 100644
--- a/drivers/net/rnp/base/rnp_common.c
+++ b/drivers/net/rnp/base/rnp_common.c
@@ -4,6 +4,7 @@
 
 #include "rnp_osdep.h"
 #include "rnp_hw.h"
+#include "rnp_mac_regs.h"
 #include "rnp_eth_regs.h"
 #include "rnp_dma_regs.h"
 #include "rnp_common.h"
@@ -28,6 +29,7 @@ int rnp_init_hw(struct rnp_hw *hw)
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(hw->back->eth_dev);
 	u32 version = 0;
 	int ret = -1;
+	u32 idx = 0;
 	u32 state;
 
 	PMD_INIT_FUNC_TRACE();
@@ -60,6 +62,9 @@ int rnp_init_hw(struct rnp_hw *hw)
 	if (hw->nic_mode == RNP_DUAL_10G && hw->max_port_num == 2)
 		RNP_E_REG_WR(hw, RNP_TC_PORT_OFFSET(RNP_TARGET_TC_PORT),
 				RNP_PORT_OFF_QUEUE_NUM);
+	/* setup mac resiger ctrl base */
+	for (idx = 0; idx < hw->max_port_num; idx++)
+		hw->mac_base[idx] = (u8 *)hw->e_ctrl + RNP_MAC_BASE_OFFSET(idx);
 
 	return 0;
 }
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index 6957866d76..c4519ba1e5 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -10,6 +10,21 @@
 #define RNP_E_FILTER_EN		_ETH_(0x801c)
 #define RNP_E_REDIR_EN		_ETH_(0x8030)
 
+/* Mac Host Filter  */
+#define RNP_MAC_FCTRL		_ETH_(0x9110)
+#define RNP_MAC_FCTRL_MPE	RTE_BIT32(8)  /* Multicast Promiscuous En */
+#define RNP_MAC_FCTRL_UPE	RTE_BIT32(9)  /* Unicast Promiscuous En */
+#define RNP_MAC_FCTRL_BAM	RTE_BIT32(10) /* Broadcast Accept Mode */
+#define RNP_MAC_FCTRL_BYPASS	(\
+		RNP_MAC_FCTRL_MPE | \
+		RNP_MAC_FCTRL_UPE | \
+		RNP_MAC_FCTRL_BAM)
+/* Mucast unicast mac hash filter ctrl */
+#define RNP_MAC_MCSTCTRL		_ETH_(0x9114)
+#define RNP_MAC_HASH_MASK		RTE_GENMASK32(11, 0)
+#define RNP_MAC_MULTICASE_TBL_EN	RTE_BIT32(2)
+#define RNP_MAC_UNICASE_TBL_EN		RTE_BIT32(3)
+
 #define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
 
 #endif /* _RNP_ETH_REGS_H */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 3f0ef6cb83..dd9649ddbc 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -59,9 +59,18 @@ struct rnp_mbx_info {
 
 struct rnp_eth_port;
 /* mac operations */
+enum rnp_mpf_modes {
+	RNP_MPF_MODE_NONE = 0,
+	RNP_MPF_MODE_MULTI,    /* Multitle Filter */
+	RNP_MPF_MODE_ALLMULTI, /* Multitle Promisc */
+	RNP_MPF_MODE_PROMISC,  /* Unicast Promisc */
+};
+
 struct rnp_mac_ops {
-	/* update mac packet filter mode */
+	/* get default mac address */
 	int (*get_macaddr)(struct rnp_eth_port *port, u8 *mac);
+	/* update mac packet filter mode */
+	int (*update_mpfm)(struct rnp_eth_port *port, u32 mode, bool en);
 };
 
 struct rnp_eth_adapter;
@@ -91,6 +100,7 @@ struct rnp_hw {
 	struct rnp_eth_adapter *back;	/* backup to the adapter handle */
 	void __iomem *e_ctrl;           /* ethernet control bar */
 	void __iomem *c_ctrl;           /* crypto control bar */
+	void __iomem *mac_base[RNP_MAX_PORT_OF_PF]; /* mac ctrl register base */
 	u32 c_blen;                     /* crypto bar size */
 
 	/* pci device info */
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index b063f4ca0b..2c9499f1da 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -6,10 +6,110 @@
 
 #include "rnp_mbx_fw.h"
 #include "rnp_mac.h"
+#include "rnp_eth_regs.h"
+#include "rnp_mac_regs.h"
 #include "../rnp.h"
 
+static int
+rnp_update_mpfm_indep(struct rnp_eth_port *port, u32 mode, bool en)
+{
+	u32 nr_lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u32 disable = 0, enable = 0;
+	u32 reg;
+
+	reg = RNP_MAC_REG_RD(hw, nr_lane, RNP_MAC_PKT_FLT_CTRL);
+	/* make sure not all receive modes are available */
+	reg &= ~RNP_MAC_RA;
+	switch (mode) {
+	case RNP_MPF_MODE_NONE:
+		break;
+	case RNP_MPF_MODE_MULTI:
+		disable = RNP_MAC_PM | RNP_MAC_PROMISC_EN;
+		enable = RNP_MAC_HPF;
+		break;
+	case RNP_MPF_MODE_ALLMULTI:
+		enable = RNP_MAC_PM;
+		disable = 0;
+		break;
+	case RNP_MPF_MODE_PROMISC:
+		enable = RNP_MAC_PROMISC_EN;
+		disable = 0;
+		break;
+	default:
+		RNP_PMD_LOG(ERR, "update_mpfm argument is invalid");
+		return -EINVAL;
+	}
+	if (en) {
+		reg &= ~disable;
+		reg |= enable;
+	} else {
+		reg &= ~enable;
+		reg |= disable;
+	}
+	/* disable common filter when indep mode */
+	reg |= RNP_MAC_HPF;
+	RNP_MAC_REG_WR(hw, nr_lane, RNP_MAC_PKT_FLT_CTRL, reg);
+	RNP_MAC_REG_WR(hw, nr_lane, RNP_MAC_FCTRL, RNP_MAC_FCTRL_BYPASS);
+
+	return 0;
+}
+
+static int
+rnp_update_mpfm_pf(struct rnp_eth_port *port, u32 mode, bool en)
+{
+	u32 nr_lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	u32 mac_filter_ctrl;
+	u32 filter_ctrl;
+	u32 bypass_ctrl;
+	u32 bypass = 0;
+
+	bypass_ctrl = RNP_E_REG_RD(hw, RNP_MAC_FCTRL);
+	bypass_ctrl |= RNP_MAC_FCTRL_BAM;
+
+	filter_ctrl = RNP_MAC_MULTICASE_TBL_EN | RNP_MAC_UNICASE_TBL_EN;
+	RNP_E_REG_WR(hw, RNP_MAC_MCSTCTRL, filter_ctrl);
+
+	switch (mode) {
+	case RNP_MPF_MODE_NONE:
+		bypass = 0;
+		break;
+	case RNP_MPF_MODE_MULTI:
+		bypass = RNP_MAC_FCTRL_MPE;
+		break;
+	case RNP_MPF_MODE_ALLMULTI:
+		bypass = RNP_MAC_FCTRL_MPE;
+		break;
+	case RNP_MPF_MODE_PROMISC:
+		bypass = RNP_MAC_FCTRL_UPE | RNP_MAC_FCTRL_MPE;
+		break;
+	default:
+		RNP_PMD_LOG(ERR, "update_mpfm argument is invalid");
+		return -EINVAL;
+	}
+	if (en)
+		bypass_ctrl |= bypass;
+	else
+		bypass_ctrl &= ~bypass;
+
+	RNP_E_REG_WR(hw, RNP_MAC_FCTRL, bypass_ctrl);
+	mac_filter_ctrl = RNP_MAC_REG_RD(hw, nr_lane, RNP_MAC_PKT_FLT_CTRL);
+	mac_filter_ctrl |= RNP_MAC_PM | RNP_MAC_PROMISC_EN;
+	mac_filter_ctrl &= ~RNP_MAC_RA;
+	RNP_MAC_REG_WR(hw, nr_lane, RNP_MAC_PKT_FLT_CTRL, mac_filter_ctrl);
+
+	return 0;
+}
+
 const struct rnp_mac_ops rnp_mac_ops_pf = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
+	.update_mpfm = rnp_update_mpfm_pf,
+};
+
+const struct rnp_mac_ops rnp_mac_ops_indep = {
+	.get_macaddr = rnp_mbx_fw_get_macaddr,
+	.update_mpfm = rnp_update_mpfm_indep,
 };
 
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
@@ -20,9 +120,21 @@ int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
 	return rnp_call_hwif_impl(port, mac_ops->get_macaddr, mac);
 }
 
+int rnp_update_mpfm(struct rnp_eth_port *port,
+		    u32 mode, bool en)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->update_mpfm, mode, en);
+}
+
 void rnp_mac_ops_init(struct rnp_hw *hw)
 {
 	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
 
-	proc_priv->mac_ops = &rnp_mac_ops_pf;
+	if (rnp_pf_is_multiple_ports(hw->device_id))
+		proc_priv->mac_ops = &rnp_mac_ops_indep;
+	else
+		proc_priv->mac_ops = &rnp_mac_ops_pf;
 }
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 8a12aa4dcd..57cbd9e3d5 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -10,5 +10,7 @@
 
 void rnp_mac_ops_init(struct rnp_hw *hw);
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac);
+int rnp_update_mpfm(struct rnp_eth_port *port,
+		    u32 mode, bool en);
 
 #endif /* _RNP_MAC_H_ */
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
new file mode 100644
index 0000000000..1dc0668b48
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_MAC_REGS_H_
+#define _RNP_MAC_REGS_H_
+
+#define RNP_MAC_BASE_OFFSET(n)  (_MAC_(0) + ((0x10000) * (n)))
+
+#define RNP_MAC_PKT_FLT_CTRL	(0x8)
+/* Receive All */
+#define RNP_MAC_RA		RTE_BIT32(31)
+/* Pass Control Packets */
+#define RNP_MAC_PCF		RTE_GENMASK32(7, 6)
+#define RNP_MAC_PCF_S		(6)
+/* Mac Filter ALL Ctrl Frame */
+#define RNP_MAC_PCF_FAC		(0)
+/* Mac Forward ALL Ctrl Frame Except Pause */
+#define RNP_MAC_PCF_NO_PAUSE	(1)
+/* Mac Forward All Ctrl Pkt */
+#define RNP_MAC_PCF_PA		(2)
+/* Mac Forward Ctrl Frame Match Unicast */
+#define RNP_MAC_PCF_PUN		(3)
+/* Promiscuous Mode */
+#define RNP_MAC_PROMISC_EN	RTE_BIT32(0)
+/* Hash Unicast */
+#define RNP_MAC_HUC		RTE_BIT32(1)
+/* Hash Multicast */
+#define RNP_MAC_HMC		RTE_BIT32(2)
+/*  Pass All Multicast */
+#define RNP_MAC_PM		RTE_BIT32(4)
+/* Disable Broadcast Packets */
+#define RNP_MAC_DBF		RTE_BIT32(5)
+/* Hash or Perfect Filter */
+#define RNP_MAC_HPF		RTE_BIT32(10)
+#define RNP_MAC_VTFE		RTE_BIT32(16)
+
+
+#endif /* _RNP_MAC_REGS_H_ */
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index f8c7bddc6e..8817a4985c 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -45,6 +45,7 @@ typedef rte_iova_t dma_addr_t;
 
 #define _ETH_(off)	((off) + (0x10000))
 #define _NIC_(off)	((off) + (0x30000))
+#define _MAC_(off)	((off) + (0x60000))
 #define _MSI_(off)	((off) + (0xA0000))
 
 #ifndef _PACKED_ALIGN4
@@ -140,5 +141,9 @@ rnp_dma_mem_free(__rte_unused struct rnp_hw *hw,
 #define RNP_REG_WR(base, offset, val)	rnp_reg_write32(base, offset, val)
 #define RNP_E_REG_WR(hw, off, value)	rnp_reg_write32((hw)->e_ctrl, (off), (value))
 #define RNP_E_REG_RD(hw, off)		rnp_reg_read32((hw)->e_ctrl, (off))
+#define RNP_MAC_REG_WR(hw, lane, off, value) \
+	rnp_reg_write32((hw)->mac_base[lane], (off), (value))
+#define RNP_MAC_REG_RD(hw, lane, off) \
+	rnp_reg_read32((hw)->mac_base[lane], (off))
 
 #endif /* _RNP_OSDEP_H_ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 1d09910527..39736b01d0 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -190,11 +190,54 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	return 0;
 }
 
+static int rnp_promiscuous_enable(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	PMD_INIT_FUNC_TRACE();
+
+	return rnp_update_mpfm(port, RNP_MPF_MODE_PROMISC, 1);
+}
+
+static int rnp_promiscuous_disable(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	PMD_INIT_FUNC_TRACE();
+
+	return rnp_update_mpfm(port, RNP_MPF_MODE_PROMISC, 0);
+}
+
+static int rnp_allmulticast_enable(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	PMD_INIT_FUNC_TRACE();
+
+	return rnp_update_mpfm(port, RNP_MPF_MODE_ALLMULTI, 1);
+}
+
+static int rnp_allmulticast_disable(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+
+	PMD_INIT_FUNC_TRACE();
+	if (eth_dev->data->promiscuous == 1)
+		return 0;
+	return rnp_update_mpfm(port, RNP_MPF_MODE_ALLMULTI, 0);
+}
+
 /* Features supported by this driver */
 static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.dev_close                    = rnp_dev_close,
 	.dev_stop                     = rnp_dev_stop,
 	.dev_infos_get                = rnp_dev_infos_get,
+
+	/* PROMISC */
+	.promiscuous_enable           = rnp_promiscuous_enable,
+	.promiscuous_disable          = rnp_promiscuous_disable,
+	.allmulticast_enable          = rnp_allmulticast_enable,
+	.allmulticast_disable         = rnp_allmulticast_disable,
 };
 
 static void
-- 
2.34.1

