Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47AC3600C
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:16:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF2740696;
	Fri, 28 Mar 2025 06:15:16 +0100 (CET)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
 by mails.dpdk.org (Postfix) with ESMTP id 92D9E4065D
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:15:13 +0100 (CET)
X-QQ-mid: bizesmtpsz12t1743138901t2b6e2
X-QQ-Originating-IP: raKNWsJO7q22M2XU1wu3DhGUqhp59qirHqcDAx4Appc=
Received: from steven.localdomain ( [103.233.162.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 28 Mar 2025 13:14:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 719841421592324315
EX-QQ-RecipientCnt: 7
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Anatoly Burakov <anatoly.burakov@intel.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, yaojun@mucse.com,
 Wenbo Cao <caowenbo@mucse.com>, Ferruh Yigit <ferruh.yigit@amd.com>
Subject: [PATCH v17 05/29] net/rnp: add device init and uninit
Date: Fri, 28 Mar 2025 05:14:20 +0000
Message-Id: <20250328051444.1019208-6-caowenbo@mucse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328051444.1019208-1-caowenbo@mucse.com>
References: <20250328051444.1019208-1-caowenbo@mucse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz5a-0
X-QQ-XMAILINFO: OK7DM3eVak3cKvhkWloxhifQavDzOR2xlQ0HP5lxhlVbONqGCDbOp+UD
 3W7J1LTMpmA9kOAH7rnzYNZCFAEk9alRc361Pid/L169gyxrRYUQZg8ehxkJ2y/+qqOetCX
 3nXpxXtGB2WFpir8aNO+uhLBiz3SUKPEIRPyzHa/zvf23LITXcwxBcxX7za48DrpoWX64fM
 UdliDJpeP/2OtdgtGB3LAWbuYTnn/zcMLAEarsEi3fNz4atxCekQcj1+wsnZ/4RfrLncZOY
 L65JZQoA9YNd9hYxhOt4heGqE9S+OKmK/qxGodj1/UyyrPJ7TE7A4TRMIZbMDpgEwALdYGI
 4NbGsjDYxbJix1WyWSNl1wVEDzzTl6rBa1NkwJrCDxrPiciBCJxYjakvk2YFn4xBayh3/9f
 5KckTqPeQGxpIGxh+2Bba/HCxSN3PcB1EDqHVfJMOujbNA8kH8jkwMrZGpwxq8XAzwS1Vyl
 9ZYXftcbozAfv6f39AhqTUx05b0i3iW+6YoN+q7dl4hP/E0f/e98+y5t243GO8q1CyzJ9SB
 vRsHZdv/VfMEfJyBioD73H1sMvPctDd97+WiQiPSjCQvBy6i678ST8P737rZeHVkvY8ixHq
 ffRIqt7y1wDFlVid78LylUZQyFG9/bH7qCBUHyTT7TTf8HNn6yDW3LfLSKLXre/fMxTOXli
 yfqsZeddRiTpD9Zlu6UWFDuDgMzOBg0dk5zCRNIyG3IxuyeLjRoqsN/I43P0Ep5Jmmgmv/E
 rjEPr2Oh+YBRgDOVnKC9R5m9sNRV8oq6B+s3LD36PzOyMRj8rczIKUIFvoPhf22ZjruYI9+
 iJTXTI0/similb/sPdhESRVxNBAfOhhzGVum1/iDCScUOt3dDpMduYtmPGfilUSMUQ9K3pj
 Z9kjnTrH9/tRUSTnci7aj8iov1W970lljGYrl6/GN7C3ArvK4B8IDFjM9zR8tNZ1bmgEt/R
 HlKgBIibF0Jj6f2DZXkos3B20GqUD8TCFw79QpsN+hfKNEsD+I8zHkfADjMjdGUlJkImO4n
 qsVAU/KBKspUxrLoEBosroLA9jjFNUMoWWngNN6N+Vh6MttGF9HRv60ibM6l4NVoPn5iKTk
 A==
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

add firmware communic method and basic device
init, uninit and close resource function.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Ferruh Yigit <ferruh.yigit@amd.com>
---
 doc/guides/nics/rnp.rst             |  10 +
 drivers/net/rnp/base/meson.build    |   4 +
 drivers/net/rnp/base/rnp_common.c   |  73 ++++++
 drivers/net/rnp/base/rnp_common.h   |  12 +
 drivers/net/rnp/base/rnp_dma_regs.h |  13 ++
 drivers/net/rnp/base/rnp_eth_regs.h |  15 ++
 drivers/net/rnp/base/rnp_fw_cmd.c   |  75 +++++++
 drivers/net/rnp/base/rnp_fw_cmd.h   | 216 ++++++++++++++++++
 drivers/net/rnp/base/rnp_hw.h       |  39 ++++
 drivers/net/rnp/base/rnp_mac.c      |  28 +++
 drivers/net/rnp/base/rnp_mac.h      |  14 ++
 drivers/net/rnp/base/rnp_mbx_fw.c   | 337 ++++++++++++++++++++++++++++
 drivers/net/rnp/base/rnp_mbx_fw.h   |  18 ++
 drivers/net/rnp/base/rnp_osdep.h    |  91 ++++++++
 drivers/net/rnp/meson.build         |   1 +
 drivers/net/rnp/rnp.h               |  44 ++++
 drivers/net/rnp/rnp_ethdev.c        | 321 +++++++++++++++++++++++++-
 17 files changed, 1302 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/rnp/base/rnp_common.c
 create mode 100644 drivers/net/rnp/base/rnp_common.h
 create mode 100644 drivers/net/rnp/base/rnp_dma_regs.h
 create mode 100644 drivers/net/rnp/base/rnp_eth_regs.h
 create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.c
 create mode 100644 drivers/net/rnp/base/rnp_fw_cmd.h
 create mode 100644 drivers/net/rnp/base/rnp_mac.c
 create mode 100644 drivers/net/rnp/base/rnp_mac.h
 create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.c
 create mode 100644 drivers/net/rnp/base/rnp_mbx_fw.h

diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 89c2f64d35..77337a68ad 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -47,3 +47,13 @@ Limitations or Known issues
 ---------------------------
 
 X86-32, BSD, Armv7, RISC-V, Windows, are not supported yet.
+
+Supported APIs
+--------------
+
+rte_eth APIs
+~~~~~~~~~~~~
+
+Listed below are the rte_eth functions supported:
+* ``rte_eth_dev_close``
+* ``rte_eth_dev_stop``
diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
index 22e7d0ee4b..10026e0425 100644
--- a/drivers/net/rnp/base/meson.build
+++ b/drivers/net/rnp/base/meson.build
@@ -3,6 +3,10 @@
 
 sources = [
         'rnp_mbx.c',
+        'rnp_fw_cmd.c',
+        'rnp_mbx_fw.c',
+        'rnp_common.c',
+        'rnp_mac.c',
 ]
 
 c_args = cflags
diff --git a/drivers/net/rnp/base/rnp_common.c b/drivers/net/rnp/base/rnp_common.c
new file mode 100644
index 0000000000..5cd4ec133e
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_common.c
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include "rnp_osdep.h"
+#include "rnp_hw.h"
+#include "rnp_eth_regs.h"
+#include "rnp_dma_regs.h"
+#include "rnp_common.h"
+#include "rnp_mbx_fw.h"
+#include "rnp_mac.h"
+#include "../rnp.h"
+
+static void
+rnp_hw_reset(struct rnp_hw *hw)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	RNP_E_REG_WR(hw, RNP_NIC_RESET, 0);
+	/* hardware reset valid must be 0 -> 1 */
+	wmb();
+	RNP_E_REG_WR(hw, RNP_NIC_RESET, 1);
+	RNP_PMD_DRV_LOG(INFO, "PF[%d] reset nic finish", hw->mbx.pf_num);
+}
+
+int rnp_init_hw(struct rnp_hw *hw)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(hw->back->eth_dev);
+	u32 version = 0;
+	int ret = -1;
+	u32 state;
+
+	PMD_INIT_FUNC_TRACE();
+	version = RNP_E_REG_RD(hw, RNP_DMA_VERSION);
+	RNP_PMD_DRV_LOG(INFO, "nic hw version:0x%.2x", version);
+	rnp_fw_init(hw);
+	RNP_E_REG_WR(hw, RNP_DMA_HW_EN, FALSE);
+	do {
+		state = RNP_E_REG_RD(hw, RNP_DMA_HW_STATE);
+	} while (state == 0);
+	ret = rnp_mbx_fw_get_capability(port);
+	if (ret) {
+		RNP_PMD_ERR("mbx_get_capability error! errcode=%d", ret);
+		return ret;
+	}
+	rnp_hw_reset(hw);
+	rnp_mbx_fw_reset_phy(hw);
+	/* rx packet protocol engine bypass */
+	RNP_E_REG_WR(hw, RNP_E_ENG_BYPASS, FALSE);
+	/* enable host filter */
+	RNP_E_REG_WR(hw, RNP_E_FILTER_EN, TRUE);
+	/* enable vxlan parse */
+	RNP_E_REG_WR(hw, RNP_E_VXLAN_PARSE_EN, TRUE);
+	/* enable flow direct engine */
+	RNP_E_REG_WR(hw, RNP_E_REDIR_EN, TRUE);
+	/* enable dma engine */
+	RNP_E_REG_WR(hw, RNP_DMA_HW_EN, RNP_DMA_EN_ALL);
+#define RNP_TARGET_TC_PORT		(2)
+#define RNP_PORT_OFF_QUEUE_NUM		(2)
+	if (hw->nic_mode == RNP_DUAL_10G && hw->max_port_num == 2)
+		RNP_E_REG_WR(hw, RNP_TC_PORT_OFFSET(RNP_TARGET_TC_PORT),
+				RNP_PORT_OFF_QUEUE_NUM);
+
+	return 0;
+}
+
+int
+rnp_setup_common_ops(struct rnp_hw *hw)
+{
+	rnp_mac_ops_init(hw);
+
+	return 0;
+}
diff --git a/drivers/net/rnp/base/rnp_common.h b/drivers/net/rnp/base/rnp_common.h
new file mode 100644
index 0000000000..aaf77a6dad
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_COMMON_H_
+#define _RNP_COMMON_H_
+
+#define RNP_NIC_RESET		_NIC_(0x0010)
+int rnp_init_hw(struct rnp_hw *hw);
+int rnp_setup_common_ops(struct rnp_hw *hw);
+
+#endif /* _RNP_COMMON_H_ */
diff --git a/drivers/net/rnp/base/rnp_dma_regs.h b/drivers/net/rnp/base/rnp_dma_regs.h
new file mode 100644
index 0000000000..00f8aff944
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_dma_regs.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_DMA_REGS_H_
+#define _RNP_DMA_REGS_H_
+
+#define RNP_DMA_VERSION		(0)
+#define RNP_DMA_HW_EN		(0x10)
+#define RNP_DMA_EN_ALL		(0b1111)
+#define RNP_DMA_HW_STATE	(0x14)
+
+#endif /* _RNP_DMA_REGS_H_ */
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
new file mode 100644
index 0000000000..6957866d76
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_ETH_REGS_H
+#define _RNP_ETH_REGS_H
+
+#define RNP_E_ENG_BYPASS	_ETH_(0x8000)
+#define RNP_E_VXLAN_PARSE_EN	_ETH_(0x8004)
+#define RNP_E_FILTER_EN		_ETH_(0x801c)
+#define RNP_E_REDIR_EN		_ETH_(0x8030)
+
+#define RNP_TC_PORT_OFFSET(lane)	_ETH_(0xe840 + 0x04 * (lane))
+
+#endif /* _RNP_ETH_REGS_H */
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.c b/drivers/net/rnp/base/rnp_fw_cmd.c
new file mode 100644
index 0000000000..676c5a2521
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_fw_cmd.c
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include "rnp_fw_cmd.h"
+
+static void
+rnp_build_phy_abalities_req(struct rnp_mbx_fw_cmd_req *req,
+			    struct rnp_fw_req_arg *req_arg __rte_unused,
+			    void *cookie)
+{
+	struct rnp_get_phy_ablity *arg = (struct rnp_get_phy_ablity *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_GET_PHY_ABALITY;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->requester = RNP_REQUEST_BY_DPDK;
+}
+
+static void
+rnp_build_reset_phy_req(struct rnp_mbx_fw_cmd_req *req,
+			void *cookie)
+{
+	req->flags = 0;
+	req->opcode = RNP_RESET_PHY;
+	req->datalen = 0;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+	req->cookie = cookie;
+}
+
+static void
+rnp_build_get_macaddress_req(struct rnp_mbx_fw_cmd_req *req,
+			     struct rnp_fw_req_arg *req_arg,
+			     void *cookie)
+{
+	struct rnp_mac_addr_req *arg = (struct rnp_mac_addr_req *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_GET_MAC_ADDRESS;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->lane_mask = RTE_BIT32(req_arg->param0);
+	arg->pfvf_num = req_arg->param1;
+}
+
+int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
+			struct rnp_fw_req_arg *arg,
+			void *cookie)
+{
+	int err = 0;
+
+	switch (arg->opcode) {
+	case RNP_GET_PHY_ABALITY:
+		rnp_build_phy_abalities_req(req, arg, cookie);
+		break;
+	case RNP_RESET_PHY:
+		rnp_build_reset_phy_req(req, cookie);
+		break;
+	case RNP_GET_MAC_ADDRESS:
+		rnp_build_get_macaddress_req(req, arg, cookie);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.h b/drivers/net/rnp/base/rnp_fw_cmd.h
new file mode 100644
index 0000000000..87f0823dba
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_FW_CMD_H_
+#define _RNP_FW_CMD_H_
+
+#include "rnp_osdep.h"
+
+#define RNP_FW_LINK_SYNC	(0x000c)
+#define RNP_LINK_MAGIC_CODE	(0xa5a40000)
+#define RNP_LINK_MAGIC_MASK	RTE_GENMASK32(31, 16)
+
+enum RNP_GENERIC_CMD {
+	/* general */
+	RNP_GET_FW_VERSION		= 0x0001,
+	RNP_READ_REG			= 0xFF03,
+	RNP_WRITE_REG			= 0xFF04,
+	RNP_MODIFY_REG			= 0xFF07,
+
+	/* virtualization */
+	RNP_IFUP_DOWN			= 0x0800,
+	RNP_PTP_EVENT			= 0x0801,
+	RNP_DRIVER_INSMOD		= 0x0803,
+	RNP_SYSTEM_SUSPUSE		= 0x0804,
+	RNP_FORCE_LINK_ON_CLOSE		= 0x0805,
+
+	/* link configuration admin commands */
+	RNP_GET_PHY_ABALITY		= 0x0601,
+	RNP_GET_MAC_ADDRESS		= 0x0602,
+	RNP_RESET_PHY			= 0x0603,
+	RNP_LED_SET			= 0x0604,
+	RNP_GET_LINK_STATUS		= 0x0607,
+	RNP_LINK_STATUS_EVENT		= 0x0608,
+	RNP_SET_LANE_FUN		= 0x0609,
+	RNP_GET_LANE_STATUS		= 0x0610,
+	RNP_SFP_SPEED_CHANGED_EVENT	= 0x0611,
+	RNP_SET_EVENT_MASK		= 0x0613,
+	RNP_SET_LANE_EVENT_EN		= 0x0614,
+	RNP_SET_LOOPBACK_MODE		= 0x0618,
+	RNP_PLUG_EVENT			= 0x0620,
+	RNP_SET_PHY_REG			= 0x0628,
+	RNP_GET_PHY_REG			= 0x0629,
+	RNP_PHY_LINK_SET		= 0x0630,
+	RNP_GET_PHY_STATISTICS		= 0x0631,
+	RNP_GET_PCS_REG			= 0x0633,
+	RNP_MODIFY_PCS_REG		= 0x0634,
+	RNP_MODIFY_PHY_REG		= 0x0635,
+
+	/*sfp-module*/
+	RNP_SFP_MODULE_READ		= 0x0900,
+	RNP_SFP_MODULE_WRITE		= 0x0901,
+
+	/* fw update */
+	RNP_FW_UPDATE			= 0x0700,
+	RNP_FW_MAINTAIN			= 0x0701,
+	RNP_EEPROM_OP			= 0x0705,
+	RNP_EMI_SYNC			= 0x0706,
+
+	RNP_GET_DUMP			= 0x0a00,
+	RNP_SET_DUMP			= 0x0a10,
+	RNP_GET_TEMP			= 0x0a11,
+	RNP_SET_WOL			= 0x0a12,
+	RNP_LLDP_TX_CTL			= 0x0a13,
+	RNP_LLDP_STAT			= 0x0a14,
+	RNP_SFC_OP			= 0x0a15,
+	RNP_SRIOV_SET			= 0x0a16,
+	RNP_SRIOV_STAT			= 0x0a17,
+
+	RNP_SN_PN			= 0x0b00,
+
+	RNP_ATU_OBOUND_SET		= 0xFF10,
+	RNP_SET_DDR_CSL			= 0xFF11,
+};
+
+/* firmware -> driver reply */
+struct __rte_aligned(4) __rte_packed_begin rnp_phy_abilities_rep {
+	u8 link_stat;
+	u8 lane_mask;
+
+	u32 speed;
+	u16 phy_type;
+	u16 nic_mode;
+	u16 pfnum;
+	u32 fw_version;
+	u32 nic_clock;
+	union  {
+		u8 port_ids[4];
+		u32 port_idf;
+	};
+	u32 fw_ext;
+	u32 phy_id;
+	u32 wol_status; /* bit0-3 wol supported . bit4-7 wol enable */
+	union {
+		u32 ext_ablity;
+		struct {
+			u32 valid			: 1; /* 0 */
+			u32 wol_en			: 1; /* 1 */
+			u32 pci_preset_runtime_en	: 1; /* 2 */
+			u32 smbus_en			: 1; /* 3 */
+			u32 ncsi_en			: 1; /* 4 */
+			u32 rpu_en			: 1; /* 5 */
+			u32 v2				: 1; /* 6 */
+			u32 pxe_en			: 1; /* 7 */
+			u32 mctp_en			: 1; /* 8 */
+			u32 yt8614			: 1; /* 9 */
+			u32 pci_ext_reset		: 1; /* 10 */
+			u32 rpu_available		: 1; /* 11 */
+			u32 fw_lldp_ablity		: 1; /* 12 */
+			u32 lldp_enabled		: 1; /* 13 */
+			u32 only_1g			: 1; /* 14 */
+			u32 force_link_down_en		: 4; /* lane0 - lane4 */
+			u32 force_link_supported	: 1;
+			u32 ports_is_sgmii_valid	: 1;
+			u32 lane_is_sgmii		: 4; /* 24 bit */
+			u32 rsvd			: 7;
+		} e;
+	};
+} __rte_packed_end;
+
+struct rnp_mac_addr_rep {
+	u32 lanes;
+	struct rnp_mac_addr {
+		/* for macaddr:01:02:03:04:05:06
+		 *  mac-hi=0x01020304 mac-lo=0x05060000
+		 */
+		u8 mac[8];
+	} addrs[4];
+	u32 pcode;
+};
+
+#define RNP_FW_REP_DATA_NUM	(40)
+struct rnp_mbx_fw_cmd_reply {
+	u16 flags;
+	u16 opcode;
+	u16 error_code;
+	u16 datalen;
+	union {
+		struct {
+			u32 cookie_lo;
+			u32 cookie_hi;
+		};
+		void *cookie;
+	};
+	u8 data[RNP_FW_REP_DATA_NUM];
+};
+
+struct rnp_fw_req_arg {
+	u16 opcode;
+	u32 param0;
+	u32 param1;
+	u32 param2;
+	u32 param3;
+	u32 param4;
+	u32 param5;
+};
+
+static_assert(sizeof(struct rnp_mbx_fw_cmd_reply) == 56,
+		"firmware request cmd size changed: rnp_mbx_fw_cmd_reply");
+
+#define RNP_FW_REQ_DATA_NUM	(32)
+/* driver op -> firmware */
+struct rnp_mac_addr_req {
+	u32 lane_mask;
+	u32 pfvf_num;
+	u32 rsv[2];
+};
+
+struct rnp_get_phy_ablity {
+	u32 requester;
+#define RNP_REQUEST_BY_DPDK (0xa1)
+#define RNP_REQUEST_BY_DRV  (0xa2)
+#define RNP_REQUEST_BY_PXE  (0xa3)
+	u32 rsv[7];
+};
+
+struct rnp_mbx_fw_cmd_req {
+	u16 flags;
+	u16 opcode;
+	u16 datalen;
+	u16 ret_value;
+	union {
+		struct {
+			u32 cookie_lo; /* 8-11 */
+			u32 cookie_hi; /* 12-15 */
+		};
+		void *cookie;
+	};
+	u32 reply_lo;
+	u32 reply_hi;
+
+	u8 data[RNP_FW_REQ_DATA_NUM];
+};
+
+static_assert(sizeof(struct rnp_mbx_fw_cmd_req) == 56,
+		"firmware request cmd size changed: rnp_mbx_fw_cmd_req");
+
+#define RNP_MBX_REQ_HDR_LEN	(24)
+#define RNP_MBX_REPLYHDR_LEN	(16)
+#define RNP_MAX_SHARE_MEM	(8 * 8)
+struct rnp_mbx_req_cookie {
+	u32 magic;
+#define RNP_COOKIE_MAGIC	(0xCE)
+	u32 timeout_ms;
+	u32 errcode;
+
+	/* wait_queue_head_t wait; */
+	volatile u32 done;
+	u32 priv_len;
+	u8 priv[RNP_MAX_SHARE_MEM];
+};
+
+int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
+			struct rnp_fw_req_arg *arg,
+			void *cookie);
+#endif /* _RNP_FW_CMD_H_ */
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 326b850560..3d1d5cd87b 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -7,6 +7,8 @@
 
 #include "rnp_osdep.h"
 
+#define RNP_MAX_PORT_OF_PF	(4)
+
 struct rnp_hw;
 /* Mailbox Operate Info */
 enum RNP_MBX_ID {
@@ -56,7 +58,34 @@ struct rnp_mbx_info {
 	struct rnp_mbx_sync syncs[RNP_MBX_FW + 1];
 };
 
+struct rnp_eth_port;
+/* mac operations */
+struct rnp_mac_ops {
+	/* update mac packet filter mode */
+	int (*get_macaddr)(struct rnp_eth_port *port, u8 *mac);
+};
+
 struct rnp_eth_adapter;
+struct rnp_fw_info {
+	char cookie_name[RTE_MEMZONE_NAMESIZE];
+	struct rnp_dma_mem mem;
+	void *cookie_pool;
+	bool fw_irq_en;
+	bool msg_alloced;
+
+	u64 fw_features;
+	spinlock_t fw_lock; /* mc-sp Protect firmware logic */
+};
+
+#define rnp_call_hwif_impl(port, f, arg...) \
+	(((f) != NULL) ? ((f) (port, arg)) : (-ENODEV))
+
+enum rnp_nic_mode {
+	RNP_SINGLE_40G = 0,
+	RNP_SINGLE_10G = 1,
+	RNP_DUAL_10G = 2,
+	RNP_QUAD_10G = 3,
+};
 
 /* hw device description */
 struct rnp_hw {
@@ -70,8 +99,18 @@ struct rnp_hw {
 	u16 vendor_id;
 	u16 max_vfs;			/* device max support vf */
 
+	char device_name[RTE_DEV_NAME_MAX_LEN];
+
+	u8 max_port_num;	/* max sub port of this nic */
+	u8 lane_mask;		/* lane enabled bit */
+	u8 nic_mode;
 	u16 pf_vf_num;
+	/* hardware port sequence info */
+	u8 phy_port_ids[RNP_MAX_PORT_OF_PF];	/* port id: for lane0~3: value:0 ~ 7*/
+	u8 lane_of_port[RNP_MAX_PORT_OF_PF];	/* lane_id: hw lane map port 1:0 0:1 or 0:0 1:1 */
+	bool lane_is_sgmii[RNP_MAX_PORT_OF_PF];
 	struct rnp_mbx_info mbx;
+	struct rnp_fw_info fw_info;
 };
 
 #endif /* _RNP_HW_H_ */
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
new file mode 100644
index 0000000000..b063f4ca0b
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include "rnp_osdep.h"
+
+#include "rnp_mbx_fw.h"
+#include "rnp_mac.h"
+#include "../rnp.h"
+
+const struct rnp_mac_ops rnp_mac_ops_pf = {
+	.get_macaddr = rnp_mbx_fw_get_macaddr,
+};
+
+int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->get_macaddr, mac);
+}
+
+void rnp_mac_ops_init(struct rnp_hw *hw)
+{
+	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
+
+	proc_priv->mac_ops = &rnp_mac_ops_pf;
+}
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
new file mode 100644
index 0000000000..8a12aa4dcd
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_MAC_H_
+#define _RNP_MAC_H_
+
+#include "rnp_osdep.h"
+#include "rnp_hw.h"
+
+void rnp_mac_ops_init(struct rnp_hw *hw);
+int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac);
+
+#endif /* _RNP_MAC_H_ */
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
new file mode 100644
index 0000000000..43197cb4c6
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -0,0 +1,337 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <strings.h>
+
+#include "rnp_mbx_fw.h"
+#include "rnp_fw_cmd.h"
+#include "rnp_mbx.h"
+#include "../rnp.h"
+
+#define RNP_MBX_API_MAX_RETRY	(10)
+#define RNP_POLL_WAIT_MS	(10)
+
+static int rnp_mbx_fw_post_req(struct rnp_eth_port *port,
+			       struct rnp_mbx_fw_cmd_req *req,
+			       struct rnp_mbx_req_cookie *cookie)
+{
+	const struct rnp_mbx_ops *ops = RNP_DEV_PP_TO_MBX_OPS(port->eth_dev);
+	struct rnp_hw *hw = port->hw;
+	u32 timeout_cnt;
+	int err = 0;
+
+	cookie->done = 0;
+
+	spin_lock(&hw->fw_info.fw_lock);
+
+	/* down_interruptible(&pf_cpu_lock); */
+	err = ops->write(hw, (u32 *)req,
+			(req->datalen + RNP_MBX_REQ_HDR_LEN) / 4, RNP_MBX_FW);
+	if (err) {
+		RNP_PMD_LOG(ERR, "rnp_write_mbx failed!");
+		goto quit;
+	}
+
+	timeout_cnt = cookie->timeout_ms / RNP_POLL_WAIT_MS;
+	while (timeout_cnt > 0) {
+		mdelay(RNP_POLL_WAIT_MS);
+		timeout_cnt--;
+		if (cookie->done)
+			break;
+	}
+quit:
+	spin_unlock(&hw->fw_info.fw_lock);
+	return err;
+}
+
+static int
+rnp_fw_send_cmd_wait(struct rnp_eth_port *port,
+		     struct rnp_mbx_fw_cmd_req *req,
+		     struct rnp_mbx_fw_cmd_reply *reply)
+{
+	const struct rnp_mbx_ops *ops = RNP_DEV_PP_TO_MBX_OPS(port->eth_dev);
+	struct rnp_hw *hw = port->hw;
+	u16 try_count = 0;
+	int err = 0;
+
+	if (ops == NULL || ops->write_posted == NULL)
+		return -EINVAL;
+	spin_lock(&hw->fw_info.fw_lock);
+	err = ops->write_posted(hw, (u32 *)req,
+			(req->datalen + RNP_MBX_REQ_HDR_LEN) / 4, RNP_MBX_FW);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: write_posted failed!"
+				" err:0x%x", __func__, err);
+		spin_unlock(&hw->fw_info.fw_lock);
+		return err;
+	}
+	/* ignore non target information */
+fw_api_try:
+	err = ops->read_posted(hw, (u32 *)reply,
+			sizeof(*reply) / 4, RNP_MBX_FW);
+	if (err) {
+		RNP_PMD_LOG(ERR,
+				"%s: read_posted failed! err:0x%x"
+				" req-op:0x%x",
+				__func__,
+				err,
+				req->opcode);
+		goto err_quit;
+	}
+	if (req->opcode != reply->opcode) {
+		try_count++;
+		if (try_count < RNP_MBX_API_MAX_RETRY)
+			goto fw_api_try;
+		RNP_PMD_LOG(ERR,
+				"%s: read reply msg failed! err:0x%x"
+				" req-op:0x%x",
+				__func__,
+				err,
+				req->opcode);
+		err = -EIO;
+	}
+	if (reply->error_code) {
+		RNP_PMD_LOG(ERR,
+				"%s: reply err:0x%x. req-op:0x%x",
+				__func__,
+				reply->error_code,
+				req->opcode);
+		err = -reply->error_code;
+		goto err_quit;
+	}
+	spin_unlock(&hw->fw_info.fw_lock);
+
+	return err;
+err_quit:
+
+	spin_unlock(&hw->fw_info.fw_lock);
+	RNP_PMD_LOG(ERR,
+			"%s:PF[%d]: req:%08x_%08x_%08x_%08x "
+			"reply:%08x_%08x_%08x_%08x",
+			__func__,
+			hw->mbx.pf_num,
+			((int *)req)[0],
+			((int *)req)[1],
+			((int *)req)[2],
+			((int *)req)[3],
+			((int *)reply)[0],
+			((int *)reply)[1],
+			((int *)reply)[2],
+			((int *)reply)[3]);
+
+	return err;
+}
+
+static int
+rnp_fw_send_norep_cmd(struct rnp_eth_port *port,
+		      struct rnp_fw_req_arg *arg)
+{
+	const struct rnp_mbx_ops *ops = RNP_DEV_PP_TO_MBX_OPS(port->eth_dev);
+	struct rnp_mbx_fw_cmd_req req;
+	struct rnp_hw *hw = port->hw;
+	int err = 0;
+
+	if (ops == NULL || ops->write_posted == NULL)
+		return -EINVAL;
+	memset(&req, 0, sizeof(req));
+	spin_lock(&hw->fw_info.fw_lock);
+	rnp_build_fwcmd_req(&req, arg, &req);
+	err = ops->write_posted(hw, (u32 *)&req,
+			(req.datalen + RNP_MBX_REQ_HDR_LEN) / 4, RNP_MBX_FW);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: write_posted failed!"
+				" err:0x%x", __func__, err);
+		spin_unlock(&hw->fw_info.fw_lock);
+		return err;
+	}
+	spin_unlock(&hw->fw_info.fw_lock);
+
+	return 0;
+}
+
+static int
+rnp_fw_send_cmd(struct rnp_eth_port *port,
+		struct rnp_fw_req_arg *arg,
+		void *respond)
+{
+	struct rnp_mbx_fw_cmd_reply reply;
+	struct rnp_mbx_fw_cmd_req req;
+	struct rnp_hw *hw = port->hw;
+	int err = 0;
+
+	memset(&req, 0, sizeof(req));
+	memset(&reply, 0, sizeof(reply));
+	if (hw->fw_info.fw_irq_en) {
+		struct rnp_mbx_req_cookie *cookie = rnp_dma_mem_alloc(hw,
+				&hw->fw_info.mem, sizeof(*cookie),
+				hw->fw_info.cookie_name);
+		if (!cookie)
+			return -ENOMEM;
+		memset(cookie->priv, 0, cookie->priv_len);
+		rnp_build_fwcmd_req(&req, arg, cookie);
+		err = rnp_mbx_fw_post_req(port, &req, cookie);
+		if (err)
+			return err;
+		if (respond)
+			memcpy(respond, cookie->priv, sizeof(cookie->priv));
+	} else {
+		rnp_build_fwcmd_req(&req, arg, &req);
+		err = rnp_fw_send_cmd_wait(port, &req, &reply);
+		if (err)
+			return err;
+		if (respond)
+			memcpy(respond, reply.data, RNP_FW_REP_DATA_NUM);
+	}
+
+	return 0;
+}
+
+int rnp_fw_init(struct rnp_hw *hw)
+{
+	struct rnp_fw_info *fw_info = &hw->fw_info;
+	struct rnp_mbx_req_cookie *cookie = NULL;
+
+	snprintf(fw_info->cookie_name, RTE_MEMZONE_NAMESIZE,
+			"fw_req_cookie_%s",
+			hw->device_name);
+	fw_info->cookie_pool = rnp_dma_mem_alloc(hw, &fw_info->mem,
+			sizeof(struct rnp_mbx_req_cookie),
+			fw_info->cookie_name);
+	cookie = (struct rnp_mbx_req_cookie *)fw_info->cookie_pool;
+	if (cookie == NULL)
+		return -ENOMEM;
+	cookie->timeout_ms = 1000;
+	cookie->magic = RNP_COOKIE_MAGIC;
+	cookie->priv_len = RNP_MAX_SHARE_MEM;
+	spin_lock_init(&fw_info->fw_lock);
+	fw_info->fw_irq_en = false;
+
+	return 0;
+}
+
+static int
+rnp_fw_get_phy_capability(struct rnp_eth_port *port,
+			  struct rnp_phy_abilities_rep *abil)
+{
+	u8 data[RNP_FW_REP_DATA_NUM] = {0};
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	RTE_BUILD_BUG_ON(sizeof(*abil) != RNP_FW_REP_DATA_NUM);
+
+	memset(&arg, 0, sizeof(arg));
+	arg.opcode = RNP_GET_PHY_ABALITY;
+	err = rnp_fw_send_cmd(port, &arg, &data);
+	if (err)
+		return err;
+	memcpy(abil, &data, sizeof(*abil));
+
+	return 0;
+}
+
+int rnp_mbx_fw_get_capability(struct rnp_eth_port *port)
+{
+	struct rnp_phy_abilities_rep ability;
+	u8 port_ids[4] = {0, 0, 0, 0};
+	struct rnp_hw *hw = port->hw;
+	u32 is_sgmii_bits = 0;
+	bool is_sgmii = false;
+	u16 lane_bit = 0;
+	u32 lane_cnt = 0;
+	int err = -EIO;
+	u16 temp_mask;
+	u8 lane_idx;
+	u32 idx;
+
+	memset(&ability, 0, sizeof(ability));
+	err = rnp_fw_get_phy_capability(port, &ability);
+	if (!err) {
+		memcpy(&port_ids, &ability.port_ids, 4);
+		hw->lane_mask = ability.lane_mask;
+		hw->nic_mode = ability.nic_mode;
+		/* get phy<->lane mapping info */
+		lane_cnt = rte_popcount32(hw->lane_mask);
+		temp_mask = hw->lane_mask;
+		if (ability.e.ports_is_sgmii_valid)
+			is_sgmii_bits = ability.e.lane_is_sgmii;
+		for (idx = 0; idx < lane_cnt; idx++) {
+			hw->phy_port_ids[idx] = port_ids[idx];
+			lane_bit = ffs(temp_mask) - 1;
+			lane_idx = port_ids[idx] % lane_cnt;
+			hw->lane_of_port[lane_idx] = lane_bit;
+			is_sgmii = lane_bit & is_sgmii_bits ? 1 : 0;
+			hw->lane_is_sgmii[lane_idx] = is_sgmii;
+			temp_mask &= ~RTE_BIT32(lane_bit);
+		}
+		hw->max_port_num = lane_cnt;
+	}
+	if (lane_cnt <= 0 || lane_cnt > 4)
+		return -EIO;
+
+	RNP_PMD_LOG(INFO, "nic-mode:%u lane_cnt:%u lane_mask:%x"
+			  " pfvfnum:%x, fw_version:0x%08x,"
+			  " ports:%u-%u-%u-%u ncsi_en:%u",
+			  hw->nic_mode,
+			  lane_cnt,
+			  hw->lane_mask,
+			  hw->pf_vf_num,
+			  ability.fw_version,
+			  port_ids[0],
+			  port_ids[1],
+			  port_ids[2],
+			  port_ids[3],
+			  ability.e.ncsi_en);
+
+	return err;
+}
+
+int rnp_mbx_fw_reset_phy(struct rnp_hw *hw)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(hw->back->eth_dev);
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.opcode = RNP_RESET_PHY;
+	err = rnp_fw_send_norep_cmd(port, &arg);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+int
+rnp_mbx_fw_get_macaddr(struct rnp_eth_port *port,
+		       u8 *mac_addr)
+{
+	u8 data[RNP_FW_REP_DATA_NUM] = {0};
+	u32 nr_lane = port->attr.nr_lane;
+	struct rnp_mac_addr_rep *mac;
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	if (!mac_addr)
+		return -EINVAL;
+	RTE_BUILD_BUG_ON(sizeof(*mac) != RNP_FW_REP_DATA_NUM);
+	memset(&arg, 0, sizeof(arg));
+	mac = (struct rnp_mac_addr_rep *)&data;
+	arg.opcode = RNP_GET_MAC_ADDRESS;
+	arg.param0 = nr_lane;
+	arg.param1 = port->hw->pf_vf_num;
+
+	err = rnp_fw_send_cmd(port, &arg, &data);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
+		return err;
+	}
+	if (RTE_BIT32(nr_lane) & mac->lanes) {
+		memcpy(mac_addr, mac->addrs[nr_lane].mac,
+				sizeof(mac->addrs[0].mac));
+		return 0;
+	}
+
+	return -ENOMSG;
+}
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.h b/drivers/net/rnp/base/rnp_mbx_fw.h
new file mode 100644
index 0000000000..255d913a97
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mbx_fw.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_MBX_FW_H_
+#define _RNP_MBX_FW_H_
+
+#include "rnp_osdep.h"
+#include "rnp_hw.h"
+
+struct rnp_eth_port;
+
+int rnp_mbx_fw_get_macaddr(struct rnp_eth_port *port, u8 *mac_addr);
+int rnp_mbx_fw_get_capability(struct rnp_eth_port *port);
+int rnp_mbx_fw_reset_phy(struct rnp_hw *hw);
+int rnp_fw_init(struct rnp_hw *hw);
+
+#endif /* _RNP_MBX_FW_H_ */
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index ded32ba37f..21d8a29a43 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -10,22 +10,54 @@
 #include <inttypes.h>
 
 #include <rte_io.h>
+#include <rte_bitops.h>
 #include <rte_log.h>
 #include <rte_cycles.h>
+#include <rte_byteorder.h>
+#include <rte_spinlock.h>
+#include <rte_common.h>
+#include <rte_memzone.h>
+#include <rte_memory.h>
+#include <rte_string_fns.h>
+#include <rte_dev.h>
 
 #include "../rnp_logs.h"
 
 typedef uint8_t u8;
+typedef int8_t s8;
 typedef uint16_t u16;
 typedef uint32_t u32;
+typedef uint64_t u64;
+
+#ifndef dma_addr_t
+#define dma_addr_t rte_iova_t
+#endif
 
 #define mb()	rte_mb()
 #define wmb()	rte_wmb()
+#ifndef ffs
+#define ffs(x) (rte_fls_u32((x) & (-x)))
+#endif
 
 #define udelay(x) rte_delay_us(x)
+#define mdelay(x) rte_delay_ms(x)
+
+#define spinlock_t			rte_spinlock_t
+#define spin_lock_init(spinlock_v)	rte_spinlock_init(spinlock_v)
+#define spin_lock(spinlock_v)		rte_spinlock_lock(spinlock_v)
+#define spin_unlock(spinlock_v)		rte_spinlock_unlock(spinlock_v)
 
+#define _ETH_(off)	((off) + (0x10000))
+#define _NIC_(off)	((off) + (0x30000))
 #define _MSI_(off)	((off) + (0xA0000))
 
+#if RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	#error "__BIG_ENDIAN is not support now."
+#endif
+
+#define FALSE               0
+#define TRUE                1
+
 #define __iomem
 static inline u32
 rnp_reg_read32(const void *base, size_t offset)
@@ -43,6 +75,65 @@ rnp_reg_write32(volatile void *base, size_t offset, u32 val)
 	rte_write32(val, ((volatile u8 *)base + offset));
 }
 
+struct rnp_dma_mem {
+	void *va;
+	dma_addr_t pa;
+	u32 size;
+	const void *mz;
+};
+
+struct rnp_hw;
+
+static inline void *
+rnp_dma_mem_alloc(__rte_unused struct rnp_hw *hw,
+		 struct rnp_dma_mem *mem, u64 size, const char *name)
+{
+	static RTE_ATOMIC(uint64_t)rnp_dma_memzone_id;
+	char z_name[RTE_MEMZONE_NAMESIZE] = "";
+	const struct rte_memzone *mz = NULL;
+
+	if (!mem)
+		return NULL;
+	if (name) {
+		rte_strscpy(z_name, name, RTE_MEMZONE_NAMESIZE);
+		mz = rte_memzone_lookup((const char *)z_name);
+		if (mz)
+			return mem->va;
+	} else {
+		snprintf(z_name, sizeof(z_name), "rnp_dma_%" PRIu64,
+				(uint64_t)rte_atomic_fetch_add_explicit(&rnp_dma_memzone_id, 1,
+				rte_memory_order_relaxed));
+	}
+	mz = rte_memzone_reserve_bounded(z_name, size, SOCKET_ID_ANY, 0,
+			0, RTE_PGSIZE_2M);
+	if (!mz)
+		return NULL;
+
+	mem->size = size;
+	mem->va = mz->addr;
+	mem->pa = mz->iova;
+	mem->mz = (const void *)mz;
+	RNP_PMD_DRV_LOG(DEBUG, "memzone %s allocated with physical address: "
+			"%"PRIu64, mz->name, mem->pa);
+
+	return mem->va;
+}
+
+static inline void
+rnp_dma_mem_free(__rte_unused struct rnp_hw *hw,
+		 struct rnp_dma_mem *mem)
+{
+	RNP_PMD_DRV_LOG(DEBUG, "memzone %s to be freed with physical address: "
+			"%"PRIu64, ((const struct rte_memzone *)mem->mz)->name,
+			mem->pa);
+	if (mem->mz) {
+		rte_memzone_free((const struct rte_memzone *)mem->mz);
+		mem->mz = NULL;
+		mem->va = NULL;
+		mem->pa = (dma_addr_t)0;
+	}
+}
+
 #define RNP_REG_RD(base, offset)	rnp_reg_read32(base, offset)
 #define RNP_REG_WR(base, offset, value)	rnp_reg_write32(base, offset, value)
 #define RNP_E_REG_WR(hw, off, value)	rnp_reg_write32((hw)->e_ctrl, (off), (value))
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
index af7957d5c6..6b28a443cf 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -16,6 +16,7 @@ endif
 subdir('base')
 objs = [base_objs]
 
+deps += ['net']
 includes += include_directories('base')
 
 sources = files(
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index acace75765..1750b6f0f3 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -16,20 +16,64 @@
 #define RNP_DEV_ID_N10G_X8	(0x1060)
 #define RNP_MAX_VF_NUM		(64)
 #define RNP_MISC_VEC_ID		RTE_INTR_VEC_ZERO_OFFSET
+/* maximum frame size supported */
+#define RNP_MAC_MAXFRM_SIZE	(9590)
+
+struct rnp_port_attr {
+	uint16_t max_mac_addrs;	/* max support mac address */
+	uint16_t port_id;	/* platform manage port sequence id */
+	uint8_t port_offset;	/* port queue offset */
+	uint8_t sw_id;		/* software port init sequence id */
+	uint16_t nr_lane;	/* phy lane of This PF:0~3 */
+};
 
 struct rnp_proc_priv {
+	const struct rnp_mac_ops *mac_ops;
 	const struct rnp_mbx_ops *mbx_ops;
 };
 
 struct rnp_eth_port {
+	struct rnp_proc_priv *proc_priv;
+	struct rte_ether_addr mac_addr;
+	struct rte_eth_dev *eth_dev;
+	struct rnp_port_attr attr;
+	struct rnp_hw *hw;
 };
 
 struct rnp_eth_adapter {
 	struct rnp_hw hw;
+	struct rte_pci_device *pdev;
 	struct rte_eth_dev *eth_dev; /* alloc eth_dev by platform */
+
+	struct rnp_eth_port *ports[RNP_MAX_PORT_OF_PF];
+	uint16_t closed_ports;
+	uint16_t inited_ports;
+	bool intr_registered;
 };
 
+#define RNP_DEV_TO_PORT(eth_dev) \
+	((struct rnp_eth_port *)(eth_dev)->data->dev_private)
+#define RNP_DEV_TO_ADAPTER(eth_dev) \
+	((struct rnp_eth_adapter *)(RNP_DEV_TO_PORT(eth_dev))->hw->back)
 #define RNP_DEV_TO_PROC_PRIV(eth_dev) \
 	((struct rnp_proc_priv *)(eth_dev)->process_private)
+#define RNP_DEV_PP_TO_MBX_OPS(priv) \
+	(((RNP_DEV_TO_PROC_PRIV(priv))->mbx_ops))
+#define RNP_DEV_PP_TO_MAC_OPS(priv) \
+	(((RNP_DEV_TO_PROC_PRIV(priv))->mac_ops))
+
+static inline int
+rnp_pf_own_ports(uint32_t id)
+{
+	return (id == 0) ? 1 : (id == 1) ? 2 : 4;
+}
+
+static inline int
+rnp_pf_is_multiple_ports(uint32_t device_id)
+{
+	uint32_t verbit = (device_id >> 5) & 0x3;
+
+	return rnp_pf_own_ports(verbit) == 1 ? 0 : 1;
+}
 
 #endif /* __RNP_H__ */
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 7fe93edcf6..ad77c48e61 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -3,37 +3,340 @@
  */
 
 #include <ethdev_pci.h>
+#include <ethdev_driver.h>
 #include <rte_io.h>
+#include <rte_malloc.h>
 
 #include "rnp.h"
+#include "rnp_logs.h"
+#include "base/rnp_mbx.h"
+#include "base/rnp_mac.h"
+#include "base/rnp_eth_regs.h"
+#include "base/rnp_common.h"
+
+static struct rte_eth_dev *
+rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
+{
+	struct rte_eth_dev *eth_dev = NULL;
+	struct rnp_eth_port *port = NULL;
+
+	eth_dev = rte_eth_dev_allocate(name);
+	if (!eth_dev) {
+		RNP_PMD_ERR("Could not allocate eth_dev for %s", name);
+		return NULL;
+	}
+	port = rte_zmalloc_socket(name,
+			sizeof(*port),
+			RTE_CACHE_LINE_SIZE,
+			pci->device.numa_node);
+	if (!port) {
+		RNP_PMD_ERR("Could not allocate rnp_eth_port for %s", name);
+		goto fail_calloc;
+	}
+	rte_eth_copy_pci_info(eth_dev, pci);
+	eth_dev->data->dev_private = port;
+	eth_dev->device = &pci->device;
+
+	return eth_dev;
+fail_calloc:
+	rte_free(port);
+	rte_eth_dev_release_port(eth_dev);
+
+	return NULL;
+}
+
+static void rnp_dev_interrupt_handler(void *param)
+{
+	RTE_SET_USED(param);
+}
+
+static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
+{
+	RTE_SET_USED(eth_dev);
+
+	return 0;
+}
+
+static int rnp_dev_close(struct rte_eth_dev *eth_dev)
+{
+	struct rnp_eth_adapter *adapter = RNP_DEV_TO_ADAPTER(eth_dev);
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+	ret = rnp_dev_stop(eth_dev);
+	if (ret < 0)
+		return ret;
+	if (adapter->closed_ports == adapter->inited_ports) {
+		struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+		if (adapter->intr_registered) {
+			/* disable uio irq before callback unregister */
+			rte_intr_disable(pci_dev->intr_handle);
+			rte_intr_callback_unregister(pci_dev->intr_handle,
+					rnp_dev_interrupt_handler,
+					(void *)eth_dev);
+			adapter->intr_registered = false;
+		}
+		rnp_dma_mem_free(&adapter->hw, &adapter->hw.fw_info.mem);
+		rte_free(adapter);
+	}
+	adapter->closed_ports++;
+
+	return 0;
+}
+
+/* Features supported by this driver */
+static const struct eth_dev_ops rnp_eth_dev_ops = {
+	.dev_close                    = rnp_dev_close,
+	.dev_stop                     = rnp_dev_stop,
+};
+
+static void
+rnp_setup_port_attr(struct rnp_eth_port *port,
+		    struct rte_eth_dev *eth_dev,
+		    uint8_t sw_id)
+{
+	struct rnp_port_attr *attr = &port->attr;
+	struct rnp_hw *hw = port->hw;
+	uint32_t lane;
+
+	PMD_INIT_FUNC_TRACE();
+
+	lane = hw->phy_port_ids[sw_id] & (hw->max_port_num - 1);
+	attr->port_id = eth_dev->data->port_id;
+	attr->port_offset = RNP_E_REG_RD(hw, RNP_TC_PORT_OFFSET(lane));
+	attr->nr_lane = lane;
+	attr->sw_id = sw_id;
+	attr->max_mac_addrs = 1;
+
+	RNP_PMD_INFO("PF[%d] SW-ETH-PORT[%d]<->PHY_LANE[%d]",
+			hw->mbx.pf_num, sw_id, lane);
+}
+
+static int
+rnp_init_port_resource(struct rnp_eth_adapter *adapter,
+		       struct rte_eth_dev *eth_dev,
+		       char *name,
+		       uint8_t p_id)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rte_pci_device *pci_dev = adapter->pdev;
+	char mac_str[RTE_ETHER_ADDR_FMT_SIZE] = " ";
+
+	PMD_INIT_FUNC_TRACE();
+
+	port->eth_dev = eth_dev;
+	port->hw = &adapter->hw;
+
+	eth_dev->dev_ops = &rnp_eth_dev_ops;
+	eth_dev->device = &pci_dev->device;
+	eth_dev->data->mtu = RTE_ETHER_MTU;
+
+	rnp_setup_port_attr(port, eth_dev, p_id);
+	eth_dev->data->mac_addrs = rte_zmalloc(name,
+			sizeof(struct rte_ether_addr) *
+			port->attr.max_mac_addrs, 0);
+	if (!eth_dev->data->mac_addrs) {
+		RNP_PMD_ERR("zmalloc for mac failed! Exiting.");
+		return -ENOMEM;
+	}
+	rnp_get_mac_addr(port, port->mac_addr.addr_bytes);
+	rte_ether_format_addr(mac_str, RTE_ETHER_ADDR_FMT_SIZE,
+					&port->mac_addr);
+	RNP_PMD_INFO("get mac addr from firmware %s", mac_str);
+	if (!rte_is_valid_assigned_ether_addr(&port->mac_addr)) {
+		RNP_PMD_WARN("get mac_addr is invalid, just use random");
+		rte_eth_random_addr(port->mac_addr.addr_bytes);
+	}
+	rte_ether_addr_copy(&port->mac_addr, &eth_dev->data->mac_addrs[0]);
+
+	adapter->ports[p_id] = port;
+	adapter->inited_ports++;
+
+	return 0;
+}
+
+static int
+rnp_proc_priv_init(struct rte_eth_dev *dev)
+{
+	struct rnp_proc_priv *priv;
+
+	priv = rte_zmalloc_socket("rnp_proc_priv",
+			sizeof(struct rnp_proc_priv),
+			RTE_CACHE_LINE_SIZE,
+			dev->device->numa_node);
+	if (!priv)
+		return -ENOMEM;
+	dev->process_private = priv;
+
+	return 0;
+}
 
 static int
 rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	char name[RTE_ETH_NAME_MAX_LEN] = " ";
+	struct rnp_eth_adapter *adapter;
+	struct rte_eth_dev *sub_eth_dev;
+	struct rnp_hw *hw;
+	uint16_t p_id;
+	int ret = -1;
+
+	PMD_INIT_FUNC_TRACE();
+
+	snprintf(name, sizeof(name), "rnp_adapter_%d", eth_dev->data->port_id);
+	adapter = rte_zmalloc(name, sizeof(struct rnp_eth_adapter), 0);
+	if (!adapter) {
+		RNP_PMD_ERR("rnp_adapter zmalloc mem failed");
+		return -ENOMEM;
+	}
+	hw = &adapter->hw;
+	adapter->pdev = pci_dev;
+	adapter->eth_dev = eth_dev;
+	adapter->ports[0] = port;
+	hw->back = (void *)adapter;
+	port->eth_dev = eth_dev;
+	port->hw = hw;
+
+	hw->e_ctrl = (u8 *)pci_dev->mem_resource[4].addr;
+	hw->c_ctrl = (u8 *)pci_dev->mem_resource[0].addr;
+	hw->c_blen = pci_dev->mem_resource[0].len;
+	hw->device_id = pci_dev->id.device_id;
+	hw->vendor_id = pci_dev->id.vendor_id;
+	hw->mbx.en_vfs = pci_dev->max_vfs;
+	if (hw->mbx.en_vfs > hw->max_vfs) {
+		ret = -EINVAL;
+		RNP_PMD_ERR("sriov vfs max support 64");
+		goto free_ad;
+	}
+
+	strlcpy(hw->device_name, pci_dev->device.name,
+			strlen(pci_dev->device.name) + 1);
+	ret = rnp_proc_priv_init(eth_dev);
+	if (ret < 0) {
+		RNP_PMD_ERR("proc_priv_alloc failed");
+		goto free_ad;
+	}
+	ret = rnp_init_mbx_pf(hw);
+	if (ret < 0) {
+		RNP_PMD_ERR("mailbox hardware init failed");
+		goto free_ad;
+	}
+	ret = rnp_init_hw(hw);
+	if (ret < 0) {
+		RNP_PMD_ERR("Hardware initialization failed");
+		goto free_ad;
+	}
+	ret = rnp_setup_common_ops(hw);
+	if (ret < 0) {
+		RNP_PMD_ERR("hardware common ops setup failed");
+		goto free_ad;
+	}
+	for (p_id = 0; p_id < hw->max_port_num; p_id++) {
+		/* port 0 resource has been allocated when probe */
+		if (!p_id) {
+			sub_eth_dev = eth_dev;
+		} else {
+			if (strlen(hw->device_name) + 4 > sizeof(name))
+				return -EINVAL;
+			snprintf(name, sizeof(name),
+					"%s_%d", hw->device_name, p_id);
+			sub_eth_dev = rnp_alloc_eth_port(pci_dev, name);
+			if (!sub_eth_dev) {
+				RNP_PMD_ERR("%s sub_eth alloc failed",
+						hw->device_name);
+				ret = -ENOMEM;
+				goto eth_alloc_error;
+			}
+			ret = rnp_proc_priv_init(sub_eth_dev);
+			if (ret < 0) {
+				RNP_PMD_ERR("proc_priv_alloc failed");
+				goto eth_alloc_error;
+			}
+			memcpy(sub_eth_dev->process_private,
+					eth_dev->process_private,
+					sizeof(struct rnp_proc_priv));
+		}
+		ret = rnp_init_port_resource(adapter, sub_eth_dev, name, p_id);
+		if (ret)
+			goto eth_alloc_error;
+		if (p_id) {
+			/* port 0 will be probe by platform */
+			rte_eth_dev_probing_finish(sub_eth_dev);
+		}
+	}
+	/* enable link update event interrupt */
+	rte_intr_callback_register(intr_handle,
+			rnp_dev_interrupt_handler, adapter);
+	rte_intr_enable(intr_handle);
+	adapter->intr_registered = true;
+	hw->fw_info.fw_irq_en = true;
+
+	return 0;
+
+eth_alloc_error:
+	for (p_id = 0; p_id < adapter->inited_ports; p_id++) {
+		port = adapter->ports[p_id];
+		if (!port)
+			continue;
+		if (port->eth_dev) {
+			rnp_dev_close(port->eth_dev);
+			/* just release eth_dev allocated by myself */
+			if (port->eth_dev != adapter->eth_dev)
+				rte_eth_dev_release_port(port->eth_dev);
+		}
+	}
+free_ad:
+	if (hw->fw_info.cookie_pool)
+		rnp_dma_mem_free(hw, &hw->fw_info.mem);
+	rte_free(adapter);
+
+	return ret;
 
-	return -ENODEV;
 }
 
 static int
 rnp_eth_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	RTE_SET_USED(eth_dev);
+	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+	uint16_t port_id;
+	int err = 0;
 
-	return -ENODEV;
+	/* Free up other ports and all resources */
+	RTE_ETH_FOREACH_DEV_OF(port_id, &pci_dev->device)
+		err |= rte_eth_dev_close(port_id);
+
+	return err == 0 ? 0 : -EIO;
 }
 
 static int
 rnp_pci_remove(struct rte_pci_device *pci_dev)
 {
-	struct rte_eth_dev *eth_dev;
-
-	eth_dev = rte_eth_dev_allocated(pci_dev->device.name);
+	char device_name[RTE_ETH_NAME_MAX_LEN] = "";
+	struct rte_eth_dev *eth_dev = NULL;
+	uint16_t idx = 0;
 
+	/* Find a port belong to pf that not be called dev_close */
+	for (idx = 0; idx < RNP_MAX_PORT_OF_PF; idx++) {
+		if (idx)
+			snprintf(device_name, sizeof(device_name), "%s_%d",
+					pci_dev->device.name,
+					idx);
+		else
+			snprintf(device_name, sizeof(device_name), "%s",
+					pci_dev->device.name);
+		eth_dev = rte_eth_dev_allocated(device_name);
+		if (eth_dev)
+			break;
+	}
 	if (eth_dev)
 		/* Cleanup eth dev */
-		return rte_eth_dev_pci_generic_remove(pci_dev,
-				rnp_eth_dev_uninit);
+		return rnp_eth_dev_uninit(eth_dev);
 	return -ENODEV;
 }
 
-- 
2.25.1

