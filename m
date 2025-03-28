Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC6C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:15:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7F734067C;
	Fri, 28 Mar 2025 06:15:13 +0100 (CET)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id 7A18E4066D
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:11 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138905timlru
X-QQ-Originating-IP: /gOYVuZLgJEPvmB6ZdkAcomIirrbCFz4hGBki8KGmko=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:15:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15672572872729603090
EX-QQ-RecipientCnt: 5
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH v17 07/29] net/rnp: add support MAC promisc mode
Date: Fri, 28 Mar 2025 05:14:22 +0000
Message-Id: <20250328051444.1019208-8-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: MxZCU/CcMqmTTMvp9g86S3uMQuAHkvHkLImoNHRa//hzenYiOt9mDee7
 oUu5w22sFobsjqn8dR4OWy929TS2cnxJqfq98KnRmFMg4sKyYt/OGAAUD1+AnnYGYuKmKon
 xScZcH5IVBT4h/BRKqDxsiV0qLQ1s8d/NCOlJXf8tkzrVOuopLnwmzUMsFcDJgC7DStujUx
 f/Kj4aVd9HaHShOGnFCjLfW7J3L0vrtFd/o5xMnCfuE9PmVcr8WJv31GKomXF49YhC+5keA
 tzCp2XLFrRO8k9akatf08S1VUlWrf/koStkyBuwOARqnaNoSy7BS8f8Bf4G1jAesLUEOF83
 QhI84QXWN4MGL2Wndl79xXmDrwfhiSykiQQ0lx1c0GwqtD8QLiE4fPXk3gh/gpDlo60P3bG
 O65lPMmQVSkSI4wNBr6P55ASJBaDwgNIMgH06aCW16qLms8nNHI7rMZw7cra7IBJ3lTvaO7
 x6LiQULuey6MZ9vUJR4i1rQws5Zh0EB8nNNgUDxkco59ZvejL2QRuFtgUWRrrsEBejhda79
 /b0Llx1AIvVQpiiZyCzEH1j7XELuTAeFfizv/onLNDzRk2NICSVoiIfCBHnffRk1wf+oAbt
 6VAL5TaFnwVOtbGhDDAXk7PNmFONOlMAAumczwLB8tekRiQTT6luj2ARvQFGZcN8pKm7499
 IpKpsDkaEOa1CkUhu3o4qJ6QVLk285g8SNrdx3KiF6tdmmN7VXA4nloF6F2UbDl38c/W5ng
 ob6MVNGHLUgHgS8ctaNfuYsH2xHwBaZ1iCcuO5Y2ZCpaNYfT2/6Y/qcIvDVscHXJrLVKizl
 rLqpR+l19iff/bXjJK6KRPIpZjbLjeE3X9IGxK5ERPavGAQ3iO/67cg8ywkt6VLC21gmxy8
 abYn0w5bfmynI/i3TZXkTgxrrHbk8ZV3e3Rpk+nZriZKNud0BYiI1ZY8EtSK0gbIk9MqIqo
 0Hm+fQcYXqf9DFwthJSE4qt9JC6UtEdm+oRRsp2KpxmSOMadqGuADPo8GvdT6mh61ok3/O1
 0mXeLjMOzK5/5xkX+ftl73jqV8YFhmBQbc6DopvwmZYwqddBa+LbhvOU0uHso=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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

add support two method of MAC unicast promisc
mulcast promisc broadcast promisc mode

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |   2 +
 doc/guides/nics/rnp.rst             |  11 +++
 drivers/net/rnp/base/rnp_common.c   |   5 ++
 drivers/net/rnp/base/rnp_eth_regs.h |  15 ++++
 drivers/net/rnp/base/rnp_hw.h       |  11 ++-
 drivers/net/rnp/base/rnp_mac.c      | 107 +++++++++++++++++++++++++++-
 drivers/net/rnp/base/rnp_mac.h      |   2 +
 drivers/net/rnp/base/rnp_mac_regs.h |  39 ++++++++++
 drivers/net/rnp/base/rnp_osdep.h    |   5 ++
 drivers/net/rnp/rnp_ethdev.c        |  43 +++++++++++
 10 files changed, 238 insertions(+), 2 deletions(-)
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
index d6934ffdb9..767353644c 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -34,6 +34,11 @@ N10 has two functions, each function support muiple ports(1 to 8),which not same
 
    rnp mucse nic port.
 
+Features
+--------
+
+- Promiscuous mode
+
 Prerequisites and Pre-conditions
 --------------------------------
 - Prepare the system as recommended by DPDK suite.
@@ -58,3 +63,9 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_close``
 * ``rte_eth_dev_stop``
 * ``rte_eth_dev_infos_get``
+* ``rte_eth_promiscuous_disable``
+* ``rte_eth_promiscuous_enable``
+* ``rte_eth_allmulticast_enable``
+* ``rte_eth_allmulticast_disable``
+* ``rte_eth_promiscuous_get``
+* ``rte_eth_allmulticast_get``
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
index 3d1d5cd87b..8e4ca54d45 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -60,9 +60,17 @@ struct rnp_mbx_info {
 
 struct rnp_eth_port;
 /* mac operations */
+enum rnp_mpf_modes {
+	RNP_MPF_MODE_NONE = 0,
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
@@ -92,6 +100,7 @@ struct rnp_hw {
 	struct rnp_eth_adapter *back;	/* backup to the adapter handle */
 	void __iomem *e_ctrl;           /* ethernet control bar */
 	void __iomem *c_ctrl;           /* crypto control bar */
+	void __iomem *mac_base[RNP_MAX_PORT_OF_PF]; /* mac ctrl register base */
 	u32 c_blen;                     /* crypto bar size */
 
 	/* pci device info */
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index b063f4ca0b..52d8a47437 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -6,10 +6,103 @@
 
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
@@ -20,9 +113,21 @@ int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
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
index 21d8a29a43..ccbef0ad7b 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -49,6 +49,7 @@ typedef uint64_t u64;
 
 #define _ETH_(off)	((off) + (0x10000))
 #define _NIC_(off)	((off) + (0x30000))
+#define _MAC_(off)	((off) + (0x60000))
 #define _MSI_(off)	((off) + (0xA0000))
 
 #if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
@@ -142,5 +143,9 @@ rnp_dma_mem_free(__rte_unused struct rnp_hw *hw,
 	rnp_reg_write32((hw)->c_ctrl, ((off) & ((hw)->c_blen - 1)), (value))
 #define RNP_C_REG_RD(hw, off)		\
 	rnp_reg_read32((hw)->c_ctrl, ((off) & ((hw)->c_blen - 1)))
+#define RNP_MAC_REG_WR(hw, lane, off, value) \
+	rnp_reg_write32((hw)->mac_base[lane], (off), (value))
+#define RNP_MAC_REG_RD(hw, lane, off) \
+	rnp_reg_read32((hw)->mac_base[lane], (off))
 
 #endif /* _RNP_OSDEP_H_ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 30f5b8a1bf..a7b6eabb7f 100644
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
2.25.1

