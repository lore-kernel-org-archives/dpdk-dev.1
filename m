Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFEEC369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 09:42:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9877E40609;
	Fri, 18 Apr 2025 11:42:06 +0200 (CEST)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by mails.dpdk.org (Postfix) with ESMTP id 2D761400D5
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:42:03 +0200 (CEST)
X-QQ-mid: esmtpsz20t1744969317te02916f5
X-QQ-Originating-IP: 3w3gpfVlFN4aIeVa1Mu5hd5wG8DUcU8bT+R88B+KE90=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.24.64.252])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 18 Apr 2025 17:41:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12377841458483460016
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH 2/2] net/txgbe: add basic code for Amber-Liter NIC
 configuration
Date: Fri, 18 Apr 2025 17:41:30 +0800
Message-Id: <20250418094131.24136-3-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Nk95pFOiOwFYenZ/mt++oM+E9deD2DB1D07wanM3f3/PHUHUxpvy+9zY
 MMoUsYPVoUizrXRrqd4PG4W0dJdEl69IBjI5LPBBBI/CGBZ/2mHDw+96NTio/MU6fiM6eUL
 aGkcIV5gJfuqAsTil89tFrsDIYchUIZGQejF47j0pLCfEhXXUb8LGa9VsZk606nZagpQU15
 1XaH8udPCvFZTsa1/WvMybS9SJfjwcZFpph1QtWwVYACZlMyAGizRs5Y+Sh89MmiE2Fmbm9
 fJaDgU/EVvy1dqsrLGbAevdiIDwqIt9Vza+YYF6H0zdEcoZXAp/0/0Sp4w0QAvl4KF55rwT
 lmsgZLIlzLm1zGjIjepOn7DdntvjTEzMuZd8WuRlcnJRzMUjYGKfUuIdDQez+xeFygPtJZ8
 gnVs+Nl8MVAlAPAThY0ttNCLxgwJtkdjVJSVuF9XrNmS9DePE+3kwvpeHO129Tj5vadm+a3
 Fn2jSUFlLXFLg31QBcTrWASfp9u+2/fIEI4mqeT60RghBfP+fWvOS1ziRg9/UYhs1Kk6CUG
 O/I9THm+GmkQ5VhIgquQ1ERPZMZFqffYwNC2SzE3/feC45IoTw26L0LS+2lL1XKVywmDkcW
 TKTpPUk8AQkVmg0UkBz9ml6JqPJ4GljvvRhsnv8IVphPmw2laiM61+Wnra9/U9T+A0izhFl
 nlCkJ0lekDjyuxOK4rniHJefg2kRmf2cXqEHI3rF0YF7vu8erZOYnfhq6jH6IPjnxKVSNtF
 LEIAD9HcZkaVmPwBMugwI6ZOSwmAEEGZ9D6zp4jRQR+Ety78XAe5ZRAjlYWRJzn+IFyIm74
 QNhNK9EWaBbSgBPbpmnUMUMw9t1zkAheE30yU+Q5jjH6yJHP54wP92hvWb5Im9pD771OftD
 Wu7t9s3exPMf1bi2YA5bAjhlotUQiNaBhb//hORYYR9DI8qHl7WCUFD9ghDPnVYoSzs+Fl/
 PIs2J+yaXF845+mj3+mF9vrtyL9IO10jdubAn93sLhjeCYKj+Mdg/gH0fjVRbhfjXrQY77m
 Ub4S5QVOw2jPuSmrxkUYj/N0NmN7jfZPLOQY51C8KngiBENuZdlb8aSLRH2Yi2+DbzCmCV8
 w==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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

Due to minimal hardware differences between Amber-Lite and Wangxun
10G NICs, we continue to support both within the txgbe driver
instead of developing a new one.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/meson.build    |    4 +
 drivers/net/txgbe/base/txgbe_aml.c    |  345 +++
 drivers/net/txgbe/base/txgbe_aml.h    |   11 +
 drivers/net/txgbe/base/txgbe_aml40.c  |  196 ++
 drivers/net/txgbe/base/txgbe_aml40.h  |   11 +
 drivers/net/txgbe/base/txgbe_e56.c    | 3371 +++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56.h    | 1784 +++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.c | 2238 ++++++++++++++++
 drivers/net/txgbe/base/txgbe_e56_bp.h |   13 +
 drivers/net/txgbe/base/txgbe_hw.c     |   10 +-
 drivers/net/txgbe/base/txgbe_hw.h     |    2 +-
 drivers/net/txgbe/base/txgbe_osdep.h  |    4 +
 drivers/net/txgbe/base/txgbe_phy.h    |   17 +
 drivers/net/txgbe/base/txgbe_regs.h   |   21 +-
 drivers/net/txgbe/base/txgbe_type.h   |   33 +
 15 files changed, 8054 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56.h
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.c
 create mode 100644 drivers/net/txgbe/base/txgbe_e56_bp.h

diff --git a/drivers/net/txgbe/base/meson.build b/drivers/net/txgbe/base/meson.build
index 4cf90a394a..7b191e1d29 100644
--- a/drivers/net/txgbe/base/meson.build
+++ b/drivers/net/txgbe/base/meson.build
@@ -6,10 +6,14 @@ sources = [
         'txgbe_dcb.c',
         'txgbe_eeprom.c',
         'txgbe_hw.c',
+        'txgbe_aml.c',
+        'txgbe_aml40.c',
         'txgbe_mbx.c',
         'txgbe_mng.c',
         'txgbe_phy.c',
         'txgbe_vf.c',
+        'txgbe_e56.c',
+        'txgbe_e56_bp.c',
 ]
 
 error_cflags = []
diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
new file mode 100644
index 0000000000..fdcab65809
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -0,0 +1,345 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2025 Beijing WangXun Technology Co., Ltd.
+ * Copyright(c) 2010-2017 Intel Corporation
+ */
+
+#include "txgbe_type.h"
+#include "txgbe_mbx.h"
+#include "txgbe_phy.h"
+#include "txgbe_dcb.h"
+#include "txgbe_vf.h"
+#include "txgbe_eeprom.h"
+#include "txgbe_mng.h"
+#include "txgbe_hw.h"
+#include "txgbe_aml.h"
+#include "txgbe_e56.h"
+#include "txgbe_e56_bp.h"
+
+void txgbe_init_ops_aml(struct txgbe_hw *hw);
+s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw,
+			       u32 *speed,
+			       bool *link_up, bool link_up_wait_to_complete);
+s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
+				      u32 *speed, bool *autoneg);
+u32 txgbe_get_media_type_aml(struct txgbe_hw *hw);
+s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw, u32 speed,
+			       bool autoneg_wait_to_complete);
+void txgbe_init_mac_link_ops_aml(struct txgbe_hw *hw);
+
+s32 txgbe_check_mac_link_aml(struct txgbe_hw *hw, u32 *speed,
+				 bool *link_up, bool link_up_wait_to_complete)
+{
+	u32 links_reg, links_orig;
+	u32 i;
+
+	/* clear the old state */
+	links_orig = rd32(hw, TXGBE_PORTSTAT);
+
+	links_reg = rd32(hw, TXGBE_PORTSTAT);
+
+	if (links_orig != links_reg) {
+		DEBUGOUT("LINKS changed from %08X to %08X",
+			  links_orig, links_reg);
+	}
+
+	if (link_up_wait_to_complete) {
+		for (i = 0; i < hw->mac.max_link_up_time; i++) {
+			if (!(links_reg & TXGBE_PORTSTAT_UP)) {
+				*link_up = false;
+			} else {
+				*link_up = true;
+				break;
+			}
+			msec_delay(100);
+			links_reg = rd32(hw, TXGBE_PORTSTAT);
+		}
+	} else {
+		if (links_reg & TXGBE_PORTSTAT_UP)
+			*link_up = true;
+		else
+			*link_up = false;
+	}
+
+	if (link_up) {
+		switch (links_reg & TXGBE_CFG_PORT_ST_AML_LINK_MASK) {
+		case TXGBE_CFG_PORT_ST_AML_LINK_25G:
+			*speed = TXGBE_LINK_SPEED_25GB_FULL;
+			break;
+		case TXGBE_CFG_PORT_ST_AML_LINK_10G:
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
+			break;
+		default:
+			*speed = TXGBE_LINK_SPEED_UNKNOWN;
+		}
+	} else
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+
+s32 txgbe_get_link_capabilities_aml(struct txgbe_hw *hw,
+				      u32 *speed,
+				      bool *autoneg)
+{
+	if (hw->phy.multispeed_fiber) {
+		*speed = TXGBE_LINK_SPEED_10GB_FULL |
+			 TXGBE_LINK_SPEED_25GB_FULL;
+		*autoneg = true;
+	} else if (hw->phy.sfp_type == txgbe_sfp_type_25g_sr_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_sr_core1 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_lr_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_lr_core1) {
+		*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		*autoneg = false;
+	} else if (hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core1 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_5m_da_cu_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_5m_da_cu_core1 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_fcpi4_lmt_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_fcpi4_lmt_core1) {
+		*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		*autoneg = false;
+	}
+
+	return 0;
+}
+
+u32 txgbe_get_media_type_aml(struct txgbe_hw *hw)
+{
+	UNREFERENCED_PARAMETER(hw);
+	return txgbe_media_type_fiber;
+}
+
+s32 txgbe_setup_mac_link_aml(struct txgbe_hw *hw,
+			       u32 speed,
+			       bool autoneg_wait_to_complete)
+{
+	bool autoneg = false;
+	s32 status = 0;
+	s32 ret_status = 0;
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+	int i;
+	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
+	u32 value = 0;
+
+	UNREFERENCED_PARAMETER(autoneg_wait_to_complete);
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+		DEBUGOUT("SFP not detected, skip setup mac link");
+		return 0;
+	}
+
+	/* Check to see if speed passed in is supported. */
+	status = hw->mac.get_link_capabilities(hw,
+			&link_capabilities, &autoneg);
+	if (status)
+		return status;
+
+	speed &= link_capabilities;
+	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
+		return TXGBE_ERR_LINK_SETUP;
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_25g_5m_da_cu_core0 ||
+	    hw->phy.sfp_type == txgbe_sfp_type_25g_5m_da_cu_core1||
+	    hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core0 ||
+	    hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core1) {
+		rte_spinlock_lock(&hw->phy_lock);
+		txgbe_e56_set_link_to_kr(hw);
+		rte_spinlock_unlock(&hw->phy_lock);
+		return 0;
+	}
+
+	value = rd32(hw, TXGBE_GPIOEXT);
+	if (value & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS))
+		return status;
+
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			break;
+		msleep(250);
+	}
+
+	if (link_speed == speed && link_up &&
+	   !(speed == TXGBE_LINK_SPEED_25GB_FULL &&
+	   !(hw->fec_mode & hw->cur_fec_link))) {
+		hw->tx_speed = speed;
+		return status;
+	}
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL &&
+			link_speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		txgbe_e56_fec_polling(hw, &link_up);
+
+		if (link_up)
+			return status;
+	}
+
+	rte_spinlock_lock(&hw->phy_lock);
+	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+	hw->tx_speed = speed;
+
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		return status;
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		txgbe_e56_fec_polling(hw, &link_up);
+	} else {
+		for (i = 0; i < 4; i++) {
+			txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+			if (link_up)
+				return status;;
+			msleep(250);
+		}
+	}
+
+	return status;
+}
+
+/**
+ *  txgbe_setup_mac_link_multispeed_fiber_aml - Set MAC link speed
+ *  @hw: pointer to hardware structure
+ *  @speed: new link speed
+ *  @autoneg_wait_to_complete: true when waiting for completion is needed
+ *
+ *  Set the link speed in the MAC and/or PHY register and restarts link.
+ **/
+static s32 txgbe_setup_mac_link_multispeed_fiber_aml(struct txgbe_hw *hw,
+					  u32 speed,
+					  bool autoneg_wait_to_complete)
+{
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	u32 highest_link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	s32 status = 0;
+	u32 speedcnt = 0;
+	bool autoneg, link_up = false;
+
+	/* Mask off requested but non-supported speeds */
+	status = hw->mac.get_link_capabilities(hw, &link_speed, &autoneg);
+	if (status != 0)
+		return status;
+
+	speed &= link_speed;
+
+	/* Try each speed one by one, highest priority first.  We do this in
+	 * software because 10Gb fiber doesn't support speed autonegotiation.
+	 */
+	if (speed & TXGBE_LINK_SPEED_25GB_FULL) {
+		speedcnt++;
+		highest_link_speed = TXGBE_LINK_SPEED_25GB_FULL;
+
+		/* If we already have link at this speed, just jump out */
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+
+		if ((link_speed == TXGBE_LINK_SPEED_25GB_FULL) && link_up &&
+		    hw->fec_mode & hw->cur_fec_link)
+			goto out;
+
+		/* Allow module to change analog characteristics (1G->10G) */
+		msec_delay(40);
+
+		status = hw->mac.setup_mac_link(hw,
+				TXGBE_LINK_SPEED_25GB_FULL,
+				autoneg_wait_to_complete);
+		if (status != 0)
+			return status;
+
+		/*aml wait link in setup,no need to repeatly wait*/
+		/* If we have link, just jump out */
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+
+		if (link_up)
+			goto out;
+
+	}
+
+	if (speed & TXGBE_LINK_SPEED_10GB_FULL) {
+		speedcnt++;
+		if (highest_link_speed == TXGBE_LINK_SPEED_UNKNOWN)
+			highest_link_speed = TXGBE_LINK_SPEED_10GB_FULL;
+
+		/* If we already have link at this speed, just jump out */
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+
+		if ((link_speed == TXGBE_LINK_SPEED_10GB_FULL) && link_up)
+			goto out;
+
+		/* Allow module to change analog characteristics (25G->10G) */
+		msec_delay(40);
+
+		status = hw->mac.setup_mac_link(hw, TXGBE_LINK_SPEED_10GB_FULL,
+				autoneg_wait_to_complete);
+		if (status != 0)
+			return status;
+
+		/*aml wait link in setup,no need to repeatly wait*/
+		/* If we have link, just jump out */
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+
+		if (link_up)
+			goto out;
+	}
+
+	/* We didn't get link.  Configure back to the highest speed we tried,
+	 * (if there was more than one).  We call ourselves back with just the
+	 * single highest speed that the user requested.
+	 */
+	if (speedcnt > 1)
+		status = txgbe_setup_mac_link_multispeed_fiber_aml(hw,
+						      highest_link_speed,
+						      autoneg_wait_to_complete);
+
+out:
+	/* Set autoneg_advertised value based on input link speed */
+	hw->phy.autoneg_advertised = 0;
+
+	if (speed & TXGBE_LINK_SPEED_25GB_FULL)
+		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_25GB_FULL;
+
+	if (speed & TXGBE_LINK_SPEED_10GB_FULL)
+		hw->phy.autoneg_advertised |= TXGBE_LINK_SPEED_10GB_FULL;
+
+	return status;
+}
+
+void txgbe_init_mac_link_ops_aml(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+
+	if (hw->phy.media_type == txgbe_media_type_fiber ||
+	    hw->phy.media_type == txgbe_media_type_fiber_qsfp) {
+		mac->disable_tx_laser =
+			txgbe_disable_tx_laser_multispeed_fiber;
+		mac->enable_tx_laser =
+			txgbe_enable_tx_laser_multispeed_fiber;
+		mac->flap_tx_laser =
+			txgbe_flap_tx_laser_multispeed_fiber;
+
+		if (hw->phy.multispeed_fiber) {
+			/* Set up dual speed SFP+ support */
+			mac->setup_link = txgbe_setup_mac_link_multispeed_fiber_aml;
+			mac->setup_mac_link = txgbe_setup_mac_link_aml;
+			mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
+		} else {
+			mac->setup_link = txgbe_setup_mac_link_aml;
+			mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
+		}
+	}
+}
+
+void txgbe_init_ops_aml(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_aml;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_aml;
+	mac->check_link = txgbe_check_mac_link_aml;
+}
\ No newline at end of file
diff --git a/drivers/net/txgbe/base/txgbe_aml.h b/drivers/net/txgbe/base/txgbe_aml.h
new file mode 100644
index 0000000000..8cda8d46ef
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2025 Beijing WangXun Technology Co., Ltd.
+ * Copyright(c) 2010-2017 Intel Corporation
+ */
+
+#ifndef _TXGBE_AML_H_
+#define _TXGBE_AML_H_
+
+#include "txgbe_type.h"
+
+#endif /* _TXGBE_AML_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
new file mode 100644
index 0000000000..2b9b354afe
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2025 Beijing WangXun Technology Co., Ltd.
+ * Copyright(c) 2010-2017 Intel Corporation
+ */
+
+#include "txgbe_type.h"
+#include "txgbe_mbx.h"
+#include "txgbe_phy.h"
+#include "txgbe_dcb.h"
+#include "txgbe_vf.h"
+#include "txgbe_eeprom.h"
+#include "txgbe_mng.h"
+#include "txgbe_hw.h"
+#include "txgbe_aml.h"
+#include "txgbe_e56.h"
+#include "txgbe_e56_bp.h"
+
+void txgbe_init_ops_aml40(struct txgbe_hw *hw);
+s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw,
+			       u32 *speed,
+			       bool *link_up, bool link_up_wait_to_complete);
+s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
+				      u32 *speed, bool *autoneg);
+u32 txgbe_get_media_type_aml40(struct txgbe_hw *hw);
+s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw, u32 speed,
+			       bool autoneg_wait_to_complete);
+void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw);
+
+s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw, u32 *speed,
+				 bool *link_up, bool link_up_wait_to_complete)
+{
+	u32 links_reg, links_orig;
+	u32 i;
+
+	/* clear the old state */
+	links_orig = rd32(hw, TXGBE_PORTSTAT);
+
+	links_reg = rd32(hw, TXGBE_PORTSTAT);
+
+	if (links_orig != links_reg) {
+		DEBUGOUT("LINKS changed from %08X to %08X",
+			  links_orig, links_reg);
+	}
+
+	if (link_up_wait_to_complete) {
+		for (i = 0; i < hw->mac.max_link_up_time; i++) {
+			if (!hw->link_valid) {
+				*link_up = false;
+
+				msleep(100);
+				continue;
+			}
+
+			if (!(links_reg & TXGBE_PORTSTAT_UP)) {
+				*link_up = false;
+			} else {
+				*link_up = true;
+				break;
+			}
+			msec_delay(100);
+			links_reg = rd32(hw, TXGBE_PORTSTAT);
+		}
+	} else {
+		if (links_reg & TXGBE_PORTSTAT_UP)
+			*link_up = true;
+		else
+			*link_up = false;
+	}
+
+	if (!hw->link_valid)
+		*link_up = false;
+
+
+	if (link_up) {
+		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_40G)
+			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+	} else 
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+
+	return 0;
+}
+
+s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
+				      u32 *speed,
+				      bool *autoneg)
+{
+	if (hw->phy.sfp_type == txgbe_sfp_type_40g_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_40g_core1) {
+		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = false;
+	} else if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+		/*
+		 * Temporary workaround: set speed to 40G even if sfp not present
+		 * to avoid TXGBE_ERR_LINK_SETUP returned by setup_mac_link, but
+		 * a more reasonable solution is don't execute setup_mac_link when
+		 * sfp module not present.
+		 */
+		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = true;
+	}
+
+	return 0;
+}
+
+u32 txgbe_get_media_type_aml40(struct txgbe_hw *hw)
+{
+	UNREFERENCED_PARAMETER(hw);
+	return txgbe_media_type_fiber_qsfp;
+}
+
+s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw,
+			       u32 speed,
+			       bool autoneg_wait_to_complete)
+{
+	bool autoneg = false;
+	s32 status = 0;
+	s32 ret_status = 0;
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
+	int i;
+	u32 link_capabilities = TXGBE_LINK_SPEED_UNKNOWN;
+
+	UNREFERENCED_PARAMETER(autoneg_wait_to_complete);
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_not_present) {
+		DEBUGOUT("SFP not detected, skip setup mac link");
+		return 0;
+	}
+
+	/* Check to see if speed passed in is supported. */
+	status = hw->mac.get_link_capabilities(hw,
+			&link_capabilities, &autoneg);
+	if (status)
+		return status;
+
+	speed &= link_capabilities;
+	if (speed == TXGBE_LINK_SPEED_UNKNOWN)
+		return TXGBE_ERR_LINK_SETUP;
+
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			break;
+		msleep(250);
+	}
+
+	if (link_speed == speed && link_up)
+		return status;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	ret_status = txgbe_set_link_to_amlite(hw, speed);
+	rte_spinlock_unlock(&hw->phy_lock);
+	hw->tx_speed = speed;
+
+	if (ret_status == TXGBE_ERR_TIMEOUT)
+		hw->link_valid = false;
+
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			return status;
+		msleep(250);
+	}
+
+	return status;
+}
+
+void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+
+	mac->disable_tx_laser =
+		txgbe_disable_tx_laser_multispeed_fiber;
+	mac->enable_tx_laser =
+		txgbe_enable_tx_laser_multispeed_fiber;
+	mac->flap_tx_laser =
+		txgbe_flap_tx_laser_multispeed_fiber;
+
+	mac->setup_link = txgbe_setup_mac_link_aml40;
+	mac->set_rate_select_speed = txgbe_set_hard_rate_select_speed;
+}
+
+void txgbe_init_ops_aml40(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_aml40;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
+	mac->check_link = txgbe_check_mac_link_aml40;
+}
diff --git a/drivers/net/txgbe/base/txgbe_aml40.h b/drivers/net/txgbe/base/txgbe_aml40.h
new file mode 100644
index 0000000000..cd0f46eaf3
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml40.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015-2025 Beijing WangXun Technology Co., Ltd.
+ * Copyright(c) 2010-2017 Intel Corporation
+ */
+
+#ifndef _TXGBE_AML40_H_
+#define _TXGBE_AML40_H_
+
+#include "txgbe_type.h"
+
+#endif /* _TXGBE_AML40_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_e56.c b/drivers/net/txgbe/base/txgbe_e56.c
new file mode 100644
index 0000000000..8168d5c526
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56.c
@@ -0,0 +1,3371 @@
+#include "txgbe_e56.h"
+#include "../txgbe_logs.h"
+
+void
+set_fields_e56(unsigned int *src_data, unsigned int bit_high,
+	       unsigned int bit_low, unsigned int set_value)
+{
+	unsigned int i;
+
+	/* Single bit field handling */
+	if (bit_high == bit_low) {
+		if (set_value == 0) {
+			/* clear single bit */
+			*src_data &= ~(1 << bit_low);
+		} else {
+			/* set single bit */
+			*src_data |= (1 << bit_low);
+		}
+	} else {
+		/* first, clear the bit fields */
+		for (i = bit_low; i <= bit_high; i++) {
+			/* clear single bit */
+			*src_data &= ~(1 << i);
+		}
+
+		/* second, or the bit fields with set value */
+		*src_data |= (set_value << bit_low);
+	}
+}
+
+/*
+ * compare function for qsort()
+ */
+static inline
+int compare(const void *a, const void *b)
+{
+	const int *num1 = (const int *)a;
+	const int *num2 = (const int *)b;
+
+	if (*num1 < *num2)
+		return -1;
+
+	else if (*num1 > *num2)
+		return 1;
+
+	else
+		return 0;
+}
+
+s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
+				bool *link_up)
+{
+	u32 rdata = 0;
+	u32 links_reg = 0;
+
+	/* must read it twice because the state may
+	 * not be correct the first time you read it
+	 */
+	rdata = rd32_epcs(hw, 0x30001);
+	rdata = rd32_epcs(hw, 0x30001);
+
+	if (rdata & TXGBE_E56_PHY_LINK_UP)
+		*link_up = true;
+	else
+		*link_up = false;
+
+	if (!hw->link_valid)
+		*link_up = false;
+
+	links_reg = rd32(hw, TXGBE_PORTSTAT);
+	if (*link_up) {
+		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_40G)
+			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_25G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_25G)
+			*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		else if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_10G) ==
+				TXGBE_CFG_PORT_ST_AML_LINK_10G)
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
+	} else {
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
+
+
+static inline u32
+txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw, u32 speed)
+{
+	u32 addr;
+
+	u32 ffe_main, pre1, pre2, post;
+	if (hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core0 ||
+	hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core1) {
+		ffe_main = S25G_TX_FFE_CFG_DAC_MAIN;
+		pre1 = S25G_TX_FFE_CFG_DAC_PRE1;
+		pre2 = S25G_TX_FFE_CFG_DAC_PRE2;
+		post = S25G_TX_FFE_CFG_DAC_POST;
+	} else {
+		ffe_main = S25G_TX_FFE_CFG_MAIN;
+		pre1 = S25G_TX_FFE_CFG_PRE1;
+		pre2 = S25G_TX_FFE_CFG_PRE2;
+		post = S25G_TX_FFE_CFG_POST;
+	}
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		addr = 0x141c;
+		wr32_ephy(hw, addr, S10G_TX_FFE_CFG_MAIN);
+
+		addr = 0x1420;
+		wr32_ephy(hw, addr, S10G_TX_FFE_CFG_PRE1);
+
+		addr = 0x1424;
+		wr32_ephy(hw, addr, S10G_TX_FFE_CFG_PRE2);
+
+		addr = 0x1428;
+		wr32_ephy(hw, addr, S10G_TX_FFE_CFG_POST);
+	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		addr = 0x141c;
+		wr32_ephy(hw, addr, ffe_main);
+
+		addr = 0x1420;
+		wr32_ephy(hw, addr, pre1);
+
+		addr = 0x1424;
+		wr32_ephy(hw, addr, pre2);
+
+		addr = 0x1428;
+		wr32_ephy(hw, addr, post);
+	}
+
+	return 0;
+}
+
+int
+txgbe_e56_get_temp(struct txgbe_hw *hw, int *pTempData)
+{
+	int data_code, temp_data, temp_fraction;
+	u32 rdata;
+	u32 timer = 0;
+
+	while (1) {
+		rdata = rd32(hw, 0x1033c);
+		if (((rdata >> 12) & 0x1) != 0)
+			break;
+		if (timer++ > PHYINIT_TIMEOUT)
+			return -1;
+	}
+
+	data_code = rdata & 0xFFF;
+	temp_data = 419400 + 2205 * (data_code * 1000 / 4094 - 500);
+
+	/* Change double Temperature to int */
+	*pTempData = temp_data / 10000;
+	temp_fraction = temp_data - (*pTempData * 10000);
+	if (temp_fraction >= 5000)
+		*pTempData += 1;
+
+	return 0;
+}
+
+u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+	int i;
+
+	//CMS Config Master
+	addr  = E56G_CMS_ANA_OVRDVAL_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56G_CMS_ANA_OVRDVAL_9_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	//TXS Config Master
+	for (i = 0; i < 4; i++) {
+		addr  = E56PHY_TXS_TXS_CFG_1_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_WKUP_CNT_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+		set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_PIN_OVRDVAL_6_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 19, 16, 0x6);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_PIN_OVRDEN_0_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_ANA_OVRDVAL_1_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_TXS_ANA_OVRDEN_0_ADDR + (E56PHY_TXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+	}
+	//Setting TX FFE
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_10GB_FULL);
+
+	//RXS Config master
+	for (i = 0; i < 4; i++) {
+		addr  = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_test_in_i = 0x1;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_RXS_CFG_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+		set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->prediv0 = 0xfa0;
+		((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->target_cnt0= 0x203a;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_range_sel0= 0x2;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->vco_code_init= 0x7ff;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_current_boost_en0= 0x1;
+		((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->bbcdr_current_boost0 = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK, 0xc);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK, 0xf);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+		set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_INTL_CONFIG_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_INTL_CONFIG_0 *)&rdata)->adc_intl2slice_delay0 = 0x5555;
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_INTL_CONFIG_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		((E56G_RXS0_INTL_CONFIG_2 *)&rdata)->interleaver_hbw_disable0 = 0x1;
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1e8);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0x78);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_TXFFE_TRAINING_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+		set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_VGA_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_VGA_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1, S10G_PHY_RX_CTLE_TAP_FRACP1);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2, S10G_PHY_RX_CTLE_TAP_FRACP2);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3, S10G_PHY_RX_CTLE_TAP_FRACP3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_CTLE_TRAINING_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1, S10G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2, S10G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+		set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3, S10G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8, 0xc);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_FFE_TRAINING_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_IDLE_DETECT_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+		set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS3_ANA_OVRDVAL_11_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw ,addr);
+		((E56G__RXS3_ANA_OVRDVAL_11 *)&rdata)->ana_test_adc_clkgen_i = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56G__RXS0_ANA_OVRDEN_2_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw ,addr);
+		((E56G__RXS0_ANA_OVRDEN_2 *)&rdata)->ovrd_en_ana_test_adc_clkgen_i = 0x0;
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 4,0, 0x6);
+		set_fields_e56(&rdata, 14,13, 0x2);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I, 0x1);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 2,0, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 13, 13, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 13, 13, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_EYE_SCAN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS_RINGO_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 9, 4, 0x366);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	// PDIG Config master
+	addr  = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2, 0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+u32
+txgbe_e56_cfg_25g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+
+	addr = E56PHY_CMS_PIN_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDVAL_0_INT_PLL0_TX_SIGNAL_TYPE_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDEN_0_OVRD_EN_PLL0_TX_SIGNAL_TYPE_I,
+		       0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDVAL_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_VCO_SWING_CTRL_I,
+		       0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CMS_ANA_OVRDVAL_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 27, 24, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_25GB_FULL);
+
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1, 0x700);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1, 0x2418);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_RANGE_SEL1, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_VCO_CODE_INIT, 0x7fb);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_CURRENT_BOOST_EN1, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_BBCDR_CURRENT_BOOST1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_0_ADC_INTL2SLICE_DELAY1, 0x3333);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_2_INTERLEAVER_HBW_DISABLE1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1f8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0xf0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G__RXS0_FOM_18__ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFL_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFL_HINT__LSB, 0x0);
+	/* change 0x90 to 0x0 to fix 25G link up keep when cable unplugged */
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFH_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFH_HINT__LSB, 0x0);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__LSB, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1,
+		       S25G_PHY_RX_CTLE_TAP_FRACP1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2,
+		       S25G_PHY_RX_CTLE_TAP_FRACP2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3,
+		       S25G_PHY_RX_CTLE_TAP_FRACP3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3,
+		       S25G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_11, ana_test_adc_clkgen_i, 0x0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_test_adc_clkgen_i,
+			      0x0);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x0);
+	set_fields_e56(&rdata, 14, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 21, 12, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+u32
+txgbe_e56_cfg_10g(struct txgbe_hw *hw)
+{
+	u32 addr;
+	u32 rdata = 0;
+
+	addr = E56G_CMS_ANA_OVRDVAL_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G_CMS_ANA_OVRDVAL_9_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_test_in_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 19, 16, 0x6);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	//Setting TX FFE
+	txgbe_e56_tx_ffe_cfg(hw, TXGBE_LINK_SPEED_10GB_FULL);
+
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->prediv0 = 0xfa0;
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->target_cnt0 = 0x203a;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_range_sel0 = 0x2;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->vco_code_init = 0x7ff;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_current_boost_en0 = 0x1;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->bbcdr_current_boost0 = 0x0;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xc);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_0 *)&rdata)->adc_intl2slice_delay0 = 0x5555;
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_2 *)&rdata)->interleaver_hbw_disable0 = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1e8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0x78);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1,
+		       S10G_PHY_RX_CTLE_TAP_FRACP1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2,
+		       S10G_PHY_RX_CTLE_TAP_FRACP2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3,
+		       S10G_PHY_RX_CTLE_TAP_FRACP3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT2);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3,
+		       S10G_PHY_RX_CTLE_TAPWT_WEIGHT3);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_11, ana_test_adc_clkgen_i, 0x0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_test_adc_clkgen_i,
+			      0x0);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x6);
+	set_fields_e56(&rdata, 14, 13, 0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 9, 4, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+static inline int
+txgbe_e56_rxs_osc_init_for_temp_track_range(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int addr, rdata, timer;
+	int T = 40;
+	int RX_COARSE_MID_TD, CMVAR_RANGE_H = 0, CMVAR_RANGE_L = 0;
+	int OFFSET_CENTRE_RANGE_H, OFFSET_CENTRE_RANGE_L, RANGE_FINAL;
+	int i = 0;
+	int lane_num = 1;
+
+	txgbe_e56_get_temp(hw, &T);
+
+	for (i = 0; i < lane_num; i++) {
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, CMVAR_RANGE_H);
+		wr32_ephy(hw, addr, rdata);
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, (0x1 << i));
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0;
+		timer = 0;
+		while((rdata >> (i * 8) & 0x3f) != 0x9) {
+			usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_INTR_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if(rdata & (0x100 << i))
+				break;
+
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+				return -1;
+			}
+		}
+
+		rdata = 0;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		OFFSET_CENTRE_RANGE_H = (rdata >> 4) & 0xf;
+		if(OFFSET_CENTRE_RANGE_H > RX_COARSE_MID_TD) {
+			OFFSET_CENTRE_RANGE_H = OFFSET_CENTRE_RANGE_H - RX_COARSE_MID_TD;
+		} else {
+			OFFSET_CENTRE_RANGE_H = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_H;
+		}
+
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		timer = 0;
+		while(1) {
+		usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if(((rdata >> (i * 8)) & 0x3f) == 0x21) { break; }
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+				return -1;
+			}
+		}
+
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		usec_delay(500);
+		addr  = E56PHY_INTR_0_ADDR;
+		wr32_ephy(hw, addr, rdata);
+	   
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, CMVAR_RANGE_L);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDEN_0_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, (0x1 << i));
+		wr32_ephy(hw, addr, rdata);
+		
+		timer = 0;
+		while(((rdata >> (i * 8)) & 0x3f) != 0x9) {
+			usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_INTR_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if((rdata & 0x100) == 0x100)
+				break;
+
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+				return -1;
+			}
+		}
+
+		rdata = 0;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		OFFSET_CENTRE_RANGE_L = (rdata >> 4) & 0xf;
+		if(OFFSET_CENTRE_RANGE_L > RX_COARSE_MID_TD) {
+			OFFSET_CENTRE_RANGE_L = OFFSET_CENTRE_RANGE_L - RX_COARSE_MID_TD;
+		} else {
+			OFFSET_CENTRE_RANGE_L = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_L;
+		}
+		if (OFFSET_CENTRE_RANGE_L < OFFSET_CENTRE_RANGE_H) {
+			RANGE_FINAL = CMVAR_RANGE_L;
+		}
+		else {
+			RANGE_FINAL = CMVAR_RANGE_H;
+		}
+		rdata = 0;
+		addr  = E56PHY_PMD_CFG_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		timer = 0;
+		while(1) {
+		usec_delay(500);
+			rdata = 0;
+			addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			if(((rdata  >> (i * 8)) & 0x3f) == 0x21) { break; }
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+				return -1;
+			}
+		}
+
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
+		wr32_ephy(hw, addr, rdata);
+
+		usec_delay(500);
+		rdata = 0;
+		addr  = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I, RANGE_FINAL);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDEN_0_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+	}
+	rdata = 0;
+	addr  = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL)
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0xf);
+	else
+		set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	return status;
+}
+
+static int txgbe_e56_set_rxs_ufine_le_max_40g(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	unsigned int ULTRAFINE_CODE;
+	int i = 0;
+	unsigned int CMVAR_UFINE_MAX = 0;
+	u32 addr;
+
+	for (i = 0; i < 4; i++) {
+		if (speed == TXGBE_LINK_SPEED_10GB_FULL || speed == TXGBE_LINK_SPEED_40GB_FULL ) {
+			CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+		}
+		else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+			CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+		}
+
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+		while (ULTRAFINE_CODE > CMVAR_UFINE_MAX) {
+			ULTRAFINE_CODE = ULTRAFINE_CODE - 1;
+			addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE;
+			wr32_ephy(hw, addr, rdata);
+
+			addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			wr32_ephy(hw, addr, rdata);
+
+			msleep(10);
+		}
+	}
+	return status;
+}
+
+
+static inline
+int txgbe_e56_set_rxs_ufine_le_max(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	unsigned int ULTRAFINE_CODE;
+
+	unsigned int CMVAR_UFINE_MAX = 0;
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL)
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+	else if (speed == TXGBE_LINK_SPEED_25GB_FULL)
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+
+	/* a. Assign software defined variables as below */
+	/* ii. ULTRAFINE_CODE = ALIAS::RXS::ULTRAFINE */
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	/* b. Perform the below logic sequence */
+	while (ULTRAFINE_CODE > CMVAR_UFINE_MAX) {
+		ULTRAFINE_CODE = ULTRAFINE_CODE - 1;
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+				      ULTRAFINE_CODE);
+		/* Set ovrd_en=1 to overide ASIC value */
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i,
+				      1);
+		/*  Wait until 1milliseconds or greater */
+		msleep(10);
+	}
+
+	return status;
+}
+
+int txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane)
+{
+	int status = 0, i, N, median;
+	unsigned int rdata;
+	u32 addr;
+	int arraySize, RXS_BBCDR_SECOND_ORDER_ST[5];
+
+	//Set ovrd_en=0 to read ASIC value
+	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (lane *  E56PHY_RXS_OFFSET);
+	rdata = rd32_ephy(hw, addr);
+	EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i) = 0;
+	wr32_ephy(hw, addr, rdata);
+
+	N =5;
+	for (i=0; i<N; i=i+1) {
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (lane *  E56PHY_RXS_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_int_cstm_i);
+		usec_delay(100);
+	}
+
+	arraySize = sizeof(RXS_BBCDR_SECOND_ORDER_ST) / sizeof(RXS_BBCDR_SECOND_ORDER_ST[0]);
+	qsort(RXS_BBCDR_SECOND_ORDER_ST, arraySize, sizeof(int), compare);
+
+	median = ( (N+1)/2 ) -1;
+	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
+
+	return status;
+}
+
+int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE)
+{
+	int status = 0, i, N, median;
+	unsigned int rdata;
+	int arraySize, RXS_BBCDR_SECOND_ORDER_ST[5];
+
+
+	/* Set ovrd_en=0 to read ASIC value */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_int_cstm_i, 0);
+
+	/*
+	 * As status update from RXS hardware is asynchronous to read status
+	 * of SECOND_ORDER, follow sequence mentioned below.
+	 */
+	N = 5;
+	for (i = 0; i < N; i = i + 1) {
+		/* set RXS_BBCDR_SECOND_ORDER_ST[i] = RXS::ANA_OVRDVAL[5]::ana_bbcdr_int_cstm_i[4:0] */
+		EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+		RXS_BBCDR_SECOND_ORDER_ST[i] = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+					       ana_bbcdr_int_cstm_i);
+		usec_delay(100);
+	}
+
+	/* sort array RXS_BBCDR_SECOND_ORDER_ST[i] */
+	arraySize = sizeof(RXS_BBCDR_SECOND_ORDER_ST) / sizeof(
+			    RXS_BBCDR_SECOND_ORDER_ST[0]);
+	qsort(RXS_BBCDR_SECOND_ORDER_ST, arraySize, sizeof(int), compare);
+
+	median = ((N + 1) / 2) -1;
+	*SECOND_CODE = RXS_BBCDR_SECOND_ORDER_ST[median];
+
+	return status;
+}
+
+/*
+ * 2.3.4 RXS post CDR lock temperature tracking sequence
+ *
+ * Below sequence must be run before the temperature drifts by >5degC
+ * after the CDR locks for the first time or after the ious time this
+ * sequence was run. It is recommended to call this sequence periodically
+ * (eg: once every 100ms) or trigger sequence if the temperature drifts
+ * by >=5degC. Temperature must be read from an on-die temperature sensor.
+ */
+static inline
+int txgbe_phy_rxs_post_cdr_lock_temp_track_seq_40g(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	int SECOND_CODE;
+	int COARSE_CODE;
+	int FINE_CODE;
+	int ULTRAFINE_CODE;
+
+	int CMVAR_SEC_LOW_TH  ;
+	int CMVAR_UFINE_MAX = 0;
+	int CMVAR_FINE_MAX  ;
+	int CMVAR_UFINE_UMAX_WRAP = 0;
+	int CMVAR_COARSE_MAX  ;
+	int CMVAR_UFINE_FMAX_WRAP = 0;
+	int CMVAR_FINE_FMAX_WRAP = 0;
+	int CMVAR_SEC_HIGH_TH  ;
+	int CMVAR_UFINE_MIN  ;
+	int CMVAR_FINE_MIN  ;
+	int CMVAR_UFINE_UMIN_WRAP ;
+	int CMVAR_COARSE_MIN  ;
+	int CMVAR_UFINE_FMIN_WRAP ;
+	int CMVAR_FINE_FMIN_WRAP ;
+	int i;
+	u32 addr;
+	for (i = 0; i < 4; i++){
+		if(speed == TXGBE_LINK_SPEED_10GB_FULL || speed == TXGBE_LINK_SPEED_40GB_FULL) {
+			CMVAR_SEC_LOW_TH	  = S10G_CMVAR_SEC_LOW_TH	 ;
+			CMVAR_UFINE_MAX	   = S10G_CMVAR_UFINE_MAX	  ;
+			CMVAR_FINE_MAX		= S10G_CMVAR_FINE_MAX	   ;
+			CMVAR_UFINE_UMAX_WRAP = S10G_CMVAR_UFINE_UMAX_WRAP;
+			CMVAR_COARSE_MAX	  = S10G_CMVAR_COARSE_MAX	 ;
+			CMVAR_UFINE_FMAX_WRAP = S10G_CMVAR_UFINE_FMAX_WRAP;
+			CMVAR_FINE_FMAX_WRAP  = S10G_CMVAR_FINE_FMAX_WRAP ;
+			CMVAR_SEC_HIGH_TH	 = S10G_CMVAR_SEC_HIGH_TH	;
+			CMVAR_UFINE_MIN	   = S10G_CMVAR_UFINE_MIN	  ;
+			CMVAR_FINE_MIN		= S10G_CMVAR_FINE_MIN	   ;
+			CMVAR_UFINE_UMIN_WRAP = S10G_CMVAR_UFINE_UMIN_WRAP;
+			CMVAR_COARSE_MIN	  = S10G_CMVAR_COARSE_MIN	 ;
+			CMVAR_UFINE_FMIN_WRAP = S10G_CMVAR_UFINE_FMIN_WRAP;
+			CMVAR_FINE_FMIN_WRAP  = S10G_CMVAR_FINE_FMIN_WRAP ;
+		}
+		else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+			CMVAR_SEC_LOW_TH	  = S25G_CMVAR_SEC_LOW_TH	 ;
+			CMVAR_UFINE_MAX	   = S25G_CMVAR_UFINE_MAX	  ;
+			CMVAR_FINE_MAX		= S25G_CMVAR_FINE_MAX	   ;
+			CMVAR_UFINE_UMAX_WRAP = S25G_CMVAR_UFINE_UMAX_WRAP;
+			CMVAR_COARSE_MAX	  = S25G_CMVAR_COARSE_MAX	 ;
+			CMVAR_UFINE_FMAX_WRAP = S25G_CMVAR_UFINE_FMAX_WRAP;
+			CMVAR_FINE_FMAX_WRAP  = S25G_CMVAR_FINE_FMAX_WRAP ;
+			CMVAR_SEC_HIGH_TH	 = S25G_CMVAR_SEC_HIGH_TH	;
+			CMVAR_UFINE_MIN	   = S25G_CMVAR_UFINE_MIN	  ;
+			CMVAR_FINE_MIN		= S25G_CMVAR_FINE_MIN	   ;
+			CMVAR_UFINE_UMIN_WRAP = S25G_CMVAR_UFINE_UMIN_WRAP;
+			CMVAR_COARSE_MIN	  = S25G_CMVAR_COARSE_MIN	 ;
+			CMVAR_UFINE_FMIN_WRAP = S25G_CMVAR_UFINE_FMIN_WRAP;
+			CMVAR_FINE_FMIN_WRAP  = S25G_CMVAR_FINE_FMIN_WRAP ;
+		}
+
+		status |= txgbe_e56_rx_rd_second_code_40g(hw, &SECOND_CODE, i);
+
+		addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		COARSE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i);
+		FINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i);
+		ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+		if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
+			if (ULTRAFINE_CODE < CMVAR_UFINE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (FINE_CODE < CMVAR_FINE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (COARSE_CODE < CMVAR_COARSE_MAX) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMAX_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE + 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else {
+				;
+			}
+		} else if (SECOND_CODE >= CMVAR_SEC_HIGH_TH) {
+			if (ULTRAFINE_CODE > CMVAR_UFINE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = ULTRAFINE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (FINE_CODE > CMVAR_FINE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else if (COARSE_CODE > CMVAR_COARSE_MIN) {
+				addr = E56G__RXS0_ANA_OVRDVAL_5_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMIN_WRAP;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE - 1;
+				wr32_ephy(hw, addr, rdata);
+
+				addr = E56G__RXS0_ANA_OVRDEN_1_ADDR + (E56PHY_RXS_OFFSET * i);
+				rdata = rd32_ephy(hw, addr);
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+				EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+				wr32_ephy(hw, addr, rdata);
+			} else {
+				;
+			}
+		}
+	}
+	return status;
+}
+
+/*
+ * 2.3.4 RXS post CDR lock temperature tracking sequence
+ *
+ * Below sequence must be run before the temperature drifts by >5degC
+ * after the CDR locks for the first time or after the ious time this
+ * sequence was run. It is recommended to call this sequence periodically
+ * (eg: once every 100ms) or trigger sequence if the temperature drifts
+ * by >=5degC. Temperature must be read from an on-die temperature sensor.
+ */
+
+int txgbe_temp_track_seq(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+	int SECOND_CODE;
+	int COARSE_CODE;
+	int FINE_CODE;
+	int ULTRAFINE_CODE;
+
+	int CMVAR_SEC_LOW_TH ;
+	int CMVAR_UFINE_MAX = 0;
+	int CMVAR_FINE_MAX ;
+	int CMVAR_UFINE_UMAX_WRAP = 0;
+	int CMVAR_COARSE_MAX ;
+	int CMVAR_UFINE_FMAX_WRAP = 0;
+	int CMVAR_FINE_FMAX_WRAP = 0;
+	int CMVAR_SEC_HIGH_TH ;
+	int CMVAR_UFINE_MIN ;
+	int CMVAR_FINE_MIN ;
+	int CMVAR_UFINE_UMIN_WRAP ;
+	int CMVAR_COARSE_MIN ;
+	int CMVAR_UFINE_FMIN_WRAP ;
+	int CMVAR_FINE_FMIN_WRAP ;
+	int temperature;
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		CMVAR_SEC_LOW_TH = S10G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S10G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S10G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S10G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S10G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S10G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S10G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S10G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S10G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S10G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S10G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S10G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S10G_CMVAR_FINE_FMIN_WRAP ;
+	} else if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		CMVAR_SEC_LOW_TH = S25G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S25G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S25G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S25G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S25G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S25G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S25G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S25G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S25G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S25G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S25G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S25G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S25G_CMVAR_FINE_FMIN_WRAP;
+	} else {
+		return 0;
+	}
+
+	status = txgbe_e56_get_temp(hw, &temperature);
+	if (status)
+		temperature = DEFAULT_TEMP;
+
+	hw->temperature = temperature;
+
+	/*
+	 * Assign software defined variables as below
+	 * a. SECOND_CODE = ALIAS::RXS::SECOND_ORDER
+	 */
+	status |= txgbe_e56_rx_rd_second_code(hw, &SECOND_CODE);
+
+	/*
+	 * b. COARSE_CODE = ALIAS::RXS::COARSE
+	 * c. FINE_CODE = ALIAS::RXS::FINE
+	 * d. ULTRAFINE_CODE = ALIAS::RXS::ULTRAFINE
+	 */
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	COARSE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i);
+	FINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
+		if (ULTRAFINE_CODE < CMVAR_UFINE_MAX) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE + 1);
+			/* Set ovrd_en=1 to overide ASIC value */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE < CMVAR_FINE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			/*
+			 * Note: All two of above code updates should be written in a single register write
+			 * Set ovrd_en=1 to overide ASIC value
+			 */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE < CMVAR_COARSE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			/*
+			 * Note: All three of above code updates should be written in a single register write
+			 * Set ovrd_en=1 to overide ASIC value
+			 */
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else {
+			;
+		}
+	} else if (SECOND_CODE >= CMVAR_SEC_HIGH_TH) {
+		if (ULTRAFINE_CODE > CMVAR_UFINE_MIN) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE - 1);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE > CMVAR_FINE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE > CMVAR_COARSE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else {
+			;
+		}
+	}
+
+	return status;
+}
+
+static inline int
+txgbe_e56_ctle_bypass_seq(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0;
+	unsigned int rdata;
+
+
+	/* 1. Program the following RXS registers as mentioned below. */
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+
+	/* 2. Program the following PDIG registers as mentioned below. */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 1;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS1_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS2_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+		txgbe_e56_ephy_config(E56G__RXS3_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+
+		EPHY_RREG(E56G__PMD_RXS1_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS1_OVRDVAL_1);
+		EPHY_RREG(E56G__PMD_RXS2_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS2_OVRDVAL_1);
+		EPHY_RREG(E56G__PMD_RXS3_OVRDVAL_1);
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_en_i) = 0;
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS3_OVRDVAL_1);
+
+		EPHY_RREG(E56G__PMD_RXS1_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS1_OVRDEN_1, ovrd_en_rxs1_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS1_OVRDEN_1);
+		EPHY_RREG(E56G__PMD_RXS2_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS2_OVRDEN_1, ovrd_en_rxs2_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS2_OVRDEN_1);
+		EPHY_RREG(E56G__PMD_RXS3_OVRDEN_1);
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_en_i) = 1;
+		EPHY_XFLD(E56G__PMD_RXS3_OVRDEN_1, ovrd_en_rxs3_rx0_ctle_train_done_o) = 1;
+		EPHY_WREG(E56G__PMD_RXS3_OVRDEN_1);
+
+	}
+	return status;
+}
+
+static int txgbe_e56_rxs_calib_adapt_seq_40G(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0, i, j;
+	u32 addr, timer;
+	u32 rdata = 0x0;
+	u32 bypassCtle = true;
+
+	for (i = 0; i < 4; i++) {
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_2_ADDR + (i * E56PHY_PMD_RX_OFFSET);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	if (bypassCtle == 1)
+		txgbe_e56_ctle_bypass_seq(hw, speed);
+
+	txgbe_e56_rxs_osc_init_for_temp_track_range(hw, speed);
+
+	addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+	timer = 0;
+	rdata = 0;
+	while(EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx0_st) != E56PHY_RX_RDY_ST &&
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx1_st) != E56PHY_RX_RDY_ST &&
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx2_st) != E56PHY_RX_RDY_ST &&
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx3_st) != E56PHY_RX_RDY_ST) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT){
+			rdata = 0;
+			addr  = E56PHY_PMD_CFG_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+			wr32_ephy(hw, addr, rdata);
+			return TXGBE_ERR_TIMEOUT;
+			}
+	}
+
+	rdata = 0;
+	timer = 0;
+	while(EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	rdata = 0;
+	timer = 0;
+	while(EPHY_XFLD(E56G__PMD_RXS1_OVRDVAL_1, rxs1_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS1_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+	rdata = 0;
+	timer = 0;
+	while(EPHY_XFLD(E56G__PMD_RXS2_OVRDVAL_1, rxs2_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS2_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	rdata = 0;
+	timer = 0;
+	while(EPHY_XFLD(E56G__PMD_RXS3_OVRDVAL_1, rxs3_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS3_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	for (i = 0; i < 4; i++) {
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I , 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O , 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		timer = 0;
+		while(((rdata >>  E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB) & 1) != 1) {
+			rdata = rd32_ephy(hw, addr);
+			usec_delay(1000);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+			}
+		}
+
+		for(j = 0; j < 16; j++) {
+			//a. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b1 
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+			wr32_ephy(hw, addr, rdata);
+
+			addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			timer = 0;
+			while(EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_ofst_adapt_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+				if (timer++ > PHYINIT_TIMEOUT) {
+					break;
+				}
+			}
+
+			rdata = 0x0000;
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0x0000;
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+			wr32_ephy(hw, addr, rdata);
+
+			addr = E56G__PMD_RXS0_OVRDEN_2_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_2, ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0;
+			timer = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			while(EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_gain_adapt_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+
+				if (timer++ > PHYINIT_TIMEOUT) {
+					break;
+				}
+			}
+
+			addr  = E56PHY_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+			wr32_ephy(hw, addr, rdata);
+		}
+		addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_done_o) = 0;
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0;
+		timer = 0;
+		addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		while(EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_done_o) != 1) {
+			rdata = rd32_ephy(hw, addr);
+			usec_delay(500);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+			}
+		}
+
+		if(bypassCtle == 0) {
+			addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			rdata = rd32_ephy(hw, addr);
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 0;
+			wr32_ephy(hw, addr, rdata);
+
+			rdata = 0;
+			timer = 0;
+			addr = E56G__PMD_RXS0_OVRDVAL_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+			while(EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) != 1) {
+				rdata = rd32_ephy(hw, addr);
+				usec_delay(500);
+
+				if (timer++ > PHYINIT_TIMEOUT) {
+					break;
+				}
+			}
+		}
+
+		addr = E56G__PMD_RXS0_OVRDEN_1_ADDR + (E56PHY_PMD_RX_OFFSET * i);
+		rdata = rd32_ephy(hw, addr);
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+		if(bypassCtle == 0) {
+			EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+		}
+		wr32_ephy(hw, addr, rdata);
+	}
+	return status;
+}
+static inline int
+txgbe_e56_rxs_calib_adapt_seq(struct txgbe_hw *hw, u32 speed)
+{
+	int status = 0, i;
+	u32 addr, timer;
+	u32 rdata = 0x0;
+	u32 bypassCtle = 1;
+
+	if (hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core0 ||
+	hw->phy.sfp_type == txgbe_sfp_type_25g_da_cu_core1)
+		bypassCtle = 0;
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		msleep(350);
+		rdata = rd32(hw, TXGBE_GPIOEXT);
+		if (rdata & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS)) {
+			return TXGBE_ERR_PHY_INIT_NOT_DONE;
+		}
+	}
+
+	rdata = 0;
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I
+		       , 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	if (bypassCtle == 1)
+		txgbe_e56_ctle_bypass_seq(hw, speed);
+
+	/*
+	 * 2. Follow sequence described in 2.3.2 RXS Osc Initialization for temperature
+	 * tracking range here. RXS would be enabled at the end of this sequence. For the case
+	 * when PAM4 KR training is not enabled (including PAM4 mode without KR training),
+	 * wait until ALIAS::PDIG::CTRL_FSM_RX_ST would return RX_TRAIN_15_ST (RX_RDY_ST).
+	 */
+	txgbe_e56_rxs_osc_init_for_temp_track_range(hw, speed);
+
+	addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+	timer = 0;
+	rdata = 0;
+	while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0,
+			 ctrl_fsm_rx0_st) != E56PHY_RX_RDY_ST) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(500);
+		EPHY_RREG(E56G__PMD_CTRL_FSM_RX_STAT_0);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			rdata = 0;
+			addr  = E56PHY_PMD_CFG_0_ADDR;
+			rdata = rd32_ephy(hw, addr);
+			set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+			wr32_ephy(hw, addr, rdata);
+			return TXGBE_ERR_TIMEOUT;
+		}
+	}
+
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			return TXGBE_ERR_TIMEOUT;
+	}
+
+	/*
+	 * 4. Disable VGA and CTLE training so that they don't interfere with ADC calibration
+	 * a. Set ALIAS::RXS::VGA_TRAIN_EN = 0b0
+	 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/* b. Set ALIAS::RXS::CTLE_TRAIN_EN = 0b0 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/*
+	 * 5. Perform ADC interleaver calibration
+	 * a. Remove the OVERRIDE on ALIAS::RXS::ADC_INTL_CAL_DONE
+	 */
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O
+		       , 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	timer = 0;
+	while (((rdata >> E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB) & 1)
+	       != 1) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(1000);
+		if (timer++ > PHYINIT_TIMEOUT)
+			break;
+	}
+
+	/*
+	 * 6. Perform ADC offset adaptation and ADC gain adaptation,
+	 * repeat them a few times and after that keep it disabled.
+	 */
+	for (i = 0; i < 16; i++) {
+		//a. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b1
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		//b. Wait for 1ms or greater
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_ofst_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+
+		/* c. ALIAS::RXS::ADC_OFST_ADAPT_EN = 0b0 */
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		/* d. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b1 */
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		/* e. Wait for 1ms or greater */
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_gain_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+
+		/* f. ALIAS::RXS::ADC_GAIN_ADAPT_EN = 0b0 */
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+	}
+	/* g. Repeat #a to #f total 16 times */
+
+	/*
+	 * 7. Perform ADC interleaver adaptation for 10ms or greater, and after that disable it
+	 * a. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b1
+	 */
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+	/* b. Wait for 10ms or greater */
+	msleep(10);
+
+	/* c. ALIAS::RXS::ADC_INTL_ADAPT_EN = 0b0 */
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_intl_adapt_en_i, 0);
+
+	/*
+	 * 8. Now re-enable VGA and CTLE trainings, so that it continues to adapt tracking changes in temperature or voltage
+	 * <1> Set ALIAS::RXS::VGA_TRAIN_EN = 0b1
+	 *     Set ALIAS::RXS::CTLE_TRAIN_EN = 0b1
+	 */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_en_i) = 1;
+	if (bypassCtle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	/*
+	 * <2> wait for ALIAS::RXS::VGA_TRAIN_DONE = 1
+	 *     wait for ALIAS::RXS::CTLE_TRAIN_DONE = 1
+	 */
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+			      ovrd_en_rxs0_rx0_vga_train_done_o, 0);
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_done_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(500);
+		if (timer++ > PHYINIT_TIMEOUT)
+			break;
+	}
+
+	if (bypassCtle == 0) {
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+				      ovrd_en_rxs0_rx0_ctle_train_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(500);
+			if (timer++ > PHYINIT_TIMEOUT)
+				break;
+		}
+	}
+
+	/* a. Remove the OVERRIDE on ALIAS::RXS::VGA_TRAIN_EN */
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+	/* b. Remove the OVERRIDE on ALIAS::RXS::CTLE_TRAIN_EN */
+	if (bypassCtle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	return status;
+}
+
+static inline u32
+txgbe_e56_cfg_temp(struct txgbe_hw *hw)
+{
+	u32 status;
+	u32 value;
+	int temp;
+
+	status = txgbe_e56_get_temp(hw, &temp);
+	if (status)
+		temp = DEFAULT_TEMP;
+
+	if (temp < DEFAULT_TEMP) {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN0);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL2);
+		set_fields_e56(&value, 20, 16, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL2, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 12, 12, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL7);
+		set_fields_e56(&value, 8, 4, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL7, value);
+	} else if (temp > HIGH_TEMP) {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN0);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL2);
+		set_fields_e56(&value, 20, 16, 0x3);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL2, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 12, 12, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL7);
+		set_fields_e56(&value, 8, 4, 0x3);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL7, value);
+	} else {
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 4, 4, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL4);
+		set_fields_e56(&value, 24, 24, 0x1);
+		set_fields_e56(&value, 31, 29, 0x4);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL4, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL5);
+		set_fields_e56(&value, 1, 0, 0x0);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDEN1);
+		set_fields_e56(&value, 23, 23, 0x1);
+		wr32_ephy(hw, CMS_ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL9);
+		set_fields_e56(&value, 24, 24, 0x1);
+		set_fields_e56(&value, 31, 29, 0x4);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL9, value);
+
+		value = rd32_ephy(hw, CMS_ANA_OVRDVAL10);
+		set_fields_e56(&value, 1, 0, 0x0);
+		wr32_ephy(hw, CMS_ANA_OVRDVAL10, value);
+	}
+
+	return 0;
+}
+
+static int txgbe_e56_config_rx_40G(struct txgbe_hw *hw, u32 speed)
+{
+	s32 status;
+
+	status = txgbe_e56_rxs_calib_adapt_seq_40G(hw, speed);
+	if (status)
+		return status;
+
+	//Step 2 of 2.3.4
+	txgbe_e56_set_rxs_ufine_le_max_40g(hw, speed);
+
+	//2.3.4 RXS post CDR lock temperature tracking sequence
+	txgbe_phy_rxs_post_cdr_lock_temp_track_seq_40g(hw, speed);
+
+	hw->link_valid = true;
+
+	return 0;
+}
+
+static int txgbe_e56_config_rx(struct txgbe_hw *hw, u32 speed)
+{
+	s32 status;
+
+	status = txgbe_e56_rxs_calib_adapt_seq(hw, speed);
+	if (status)
+		return status;
+
+	/* Step 2 of 2.3.4 */
+	txgbe_e56_set_rxs_ufine_le_max(hw, speed);
+
+	/* 2.3.4 RXS post CDR lock temperature tracking sequence */
+	txgbe_temp_track_seq(hw, speed);
+
+	return 0;
+}
+
+//--------------------------------------------------------------
+//2.2.10 SEQ::RX_DISABLE 
+//Use PDIG::PMD_CFG[0]::rx_en_cfg[<lane no.>] = 0b0 to powerdown specific RXS lanes. 
+//Completion of RXS powerdown can be confirmed by observing ALIAS::PDIG::CTRL_FSM_RX_ST = POWERDN_ST
+//--------------------------------------------------------------
+static int txgbe_e56_disable_rx40G(struct txgbe_hw *hw)
+{
+	int status = 0;
+	unsigned int rdata, timer;
+	unsigned int addr;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		rdata = 0x0000;
+		addr = E56G__RXS0_ANA_OVRDEN_0_ADDR + (i * E56PHY_RXS_OFFSET);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	addr = E56G__PMD_BASER_PMD_CONTROL_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln0) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln1) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln2) = 0;
+	EPHY_XFLD(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln3) = 0;
+	wr32_ephy(hw, addr, rdata);
+	
+	timer = 0;
+	
+	while (EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx0_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx1_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx2_st) != 0x21 ||
+		EPHY_XFLD(E56G__PMD_CTRL_FSM_RX_STAT_0, ctrl_fsm_rx3_st) != 0x21) {
+		rdata = 0;
+		addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(100);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			printf("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!!!\n");
+			break;
+		}
+	}
+
+	return status;
+}
+
+//--------------------------------------------------------------
+//2.2.10 SEQ::RX_DISABLE
+//Use PDIG::PMD_CFG[0]::rx_en_cfg[<lane no.>] = 0b0 to powerdown specific RXS lanes.
+//Completion of RXS powerdown can be confirmed by observing ALIAS::PDIG::CTRL_FSM_RX_ST = POWERDN_ST
+//--------------------------------------------------------------
+static int txgbe_e56_disable_rx(struct txgbe_hw *hw)
+{
+	int status = 0;
+	unsigned int rdata, timer;
+	unsigned int addr, temp;
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_bbcdr_osc_range_sel_i, 0);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_3);
+	temp = EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_3, ovrd_en_rxs0_rx0_spareout_o) = temp & 0x8F;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_3);
+
+	EPHY_RREG(E56G__RXS0_DIG_OVRDEN_1);
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, top_comp_th_ovrd_en) = 0;
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, mid_comp_th_ovrd_en) = 0;
+	EPHY_XFLD(E56G__RXS0_DIG_OVRDEN_1, bot_comp_th_ovrd_en) = 0;
+	EPHY_WREG(E56G__RXS0_DIG_OVRDEN_1);
+
+	txgbe_e56_ephy_config(E56G__RXS0_DFT_1, ber_en, 0);
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_3, ovrd_en_ana_sel_lpbk_i, 0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_2, ovrd_en_ana_en_adccal_lpbk_i, 0);
+
+	txgbe_e56_ephy_config(E56G__RXS0_RXS_CFG_0, train_clk_gate_bypass_en, 0x1FFF);
+
+	txgbe_e56_ephy_config(E56G__PMD_BASER_PMD_CONTROL, training_enable_ln0, 0);
+
+	txgbe_e56_ephy_config(E56G__PMD_PMD_CFG_5, rx_to_tx_lpbk_en, 0);
+
+	txgbe_e56_ephy_config(E56G__PMD_PMD_CFG_0, rx_en_cfg, 0);
+
+	timer = 0;
+	while (1) {
+		rdata = 0;
+		addr  = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x3f) == 0x21)
+			break;
+		usec_delay(100);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			printf("ERROR: Wait E56PHY_CTRL_FSM_RX_STAT_0_ADDR Timeout!!!\n");
+			break;
+		}
+	}
+
+	return status;
+}
+
+int txgbe_e56_reconfig_rx(struct txgbe_hw *hw, u32 speed)
+{
+	u32 addr;
+	u32 rdata;
+	int status = 0;
+
+	wr32m(hw, TXGBE_MACTXCFG, TXGBE_MACTXCFG_TXE,
+	      ~TXGBE_MACTXCFG_TXE);
+	wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+	      ~TXGBE_MACRXCFG_ENA);
+
+	hw->mac.disable_sec_tx_path(hw);
+
+	if (hw->mac.type == txgbe_mac_aml) {
+		rdata = rd32(hw, TXGBE_GPIOEXT);
+		if (rdata & (TXGBE_SFP1_MOD_ABS_LS | TXGBE_SFP1_RX_LOS_LS)) {
+			return TXGBE_ERR_TIMEOUT;
+		}
+	}
+
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, 0x0);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, 0x0);
+
+	if (hw->mac.type == txgbe_mac_aml40) {
+		txgbe_e56_disable_rx40G(hw);
+		status = txgbe_e56_config_rx_40G(hw, speed);
+	} else {
+		txgbe_e56_disable_rx(hw);
+		status = txgbe_e56_config_rx(hw, speed);
+	}
+
+	addr = E56PHY_INTR_0_ADDR;
+	wr32_ephy(hw, addr, E56PHY_INTR_0_IDLE_ENTRY1);
+
+	addr = E56PHY_INTR_1_ADDR;
+	wr32_ephy(hw, addr, E56PHY_INTR_1_IDLE_EXIT1);
+
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+
+	hw->mac.enable_sec_tx_path(hw);
+	wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+	      TXGBE_MACRXCFG_ENA);
+
+	return status;
+}
+
+int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed)
+{
+	u32 value = 0;
+	u32 ppl_lock = false;
+	int status = 0;
+	u32 reset = 0;
+
+	if ((rd32(hw, TXGBE_EPHY_STAT) & TXGBE_EPHY_STAT_PPL_LOCK)
+	== TXGBE_EPHY_STAT_PPL_LOCK) {
+		ppl_lock = true;
+		wr32m(hw, TXGBE_MACTXCFG, TXGBE_MACTXCFG_TXE,
+		      ~TXGBE_MACTXCFG_TXE);
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,
+		      ~TXGBE_MACRXCFG_ENA);
+
+		hw->mac.disable_sec_tx_path(hw);
+	}
+
+	hw->mac.disable_tx_laser(hw);
+
+	if (hw->bus.lan_id == 0)
+		reset = TXGBE_RST_EPHY_LAN_0;
+
+	else
+		reset = TXGBE_RST_EPHY_LAN_1;
+
+	wr32(hw, TXGBE_RST,
+	     reset | rd32(hw, TXGBE_RST));
+	txgbe_flush(hw);
+	usec_delay(10);
+
+	/* XLGPCS REGS Start */
+	value = rd32_epcs(hw, VR_PCS_DIG_CTRL1);
+	value |= 0x8000;
+	wr32_epcs(hw, VR_PCS_DIG_CTRL1, value);
+
+	usec_delay(1000);
+	value = rd32_epcs(hw, VR_PCS_DIG_CTRL1);
+	if ((value & 0x8000)) {
+		status = TXGBE_ERR_PHY_INIT_NOT_DONE;
+		goto out;
+	}
+
+	value = rd32_epcs(hw, SR_AN_CTRL);
+	set_fields_e56(&value, 12, 12, 0);
+	wr32_epcs(hw, SR_AN_CTRL, value);
+
+	if (speed == TXGBE_LINK_SPEED_40GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 0x3);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 0x4);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL0);
+		set_fields_e56(&value, 29, 29, 0x1);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL5);
+		set_fields_e56(&value, 24, 24, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN1);
+		set_fields_e56(&value, 30,30, 0x1);
+		set_fields_e56(&value, 25,25, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, PLL0_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL0_CFG0, value);
+
+		value = rd32_ephy(hw, PLL0_CFG2);
+		set_fields_e56(&value, 12, 8, 0x4);
+		wr32_ephy(hw, PLL0_CFG2, value);
+
+		value = rd32_ephy(hw, PLL1_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL1_CFG0, value);
+
+		value = rd32_ephy(hw, PLL1_CFG2);
+		set_fields_e56(&value, 12, 8, 0x8);
+		wr32_ephy(hw, PLL1_CFG2, value);
+
+		value = rd32_ephy(hw, PLL0_DIV_CFG0);
+		set_fields_e56(&value, 18, 8, 0x294);
+		set_fields_e56(&value, 4, 0, 0x8);
+		wr32_ephy(hw, PLL0_DIV_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG0);
+		set_fields_e56(&value, 30, 28, 0x7);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 14, 12, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG1);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 2, 0, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG1, value);
+
+		value = rd32_ephy(hw, AN_CFG1);
+		set_fields_e56(&value, 4, 0, 0x2);
+		wr32_ephy(hw, AN_CFG1, value);
+
+		txgbe_e56_cfg_temp(hw);
+		txgbe_e56_cfg_40g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0xf); //TX_EN set
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+
+		status = txgbe_e56_config_rx_40G(hw, speed);
+	}
+
+	if (speed == TXGBE_LINK_SPEED_25GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 5);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 7);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
+
+		value = rd32_epcs(hw, SR_PMA_CTRL2);
+		set_fields_e56(&value, 6, 0, 0x39);
+		wr32_epcs(hw, SR_PMA_CTRL2, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL0);
+		set_fields_e56(&value, 29, 29, 0x1);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL5);
+		/* Update to 0 from SNPS for PIN CLKP/N: Enable the termination of the input buffer */
+		set_fields_e56(&value, 24, 24, 0x0);
+		wr32_ephy(hw, ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN1);
+		set_fields_e56(&value, 30, 30, 0x1);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, PLL0_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL0_CFG0, value);
+
+		value = rd32_ephy(hw, PLL0_CFG2);
+		set_fields_e56(&value, 12, 8, 0x4);
+		wr32_ephy(hw, PLL0_CFG2, value);
+
+		value = rd32_ephy(hw, PLL1_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL1_CFG0, value);
+
+		value = rd32_ephy(hw, PLL1_CFG2);
+		set_fields_e56(&value, 12, 8, 0x8);
+		wr32_ephy(hw, PLL1_CFG2, value);
+
+		value = rd32_ephy(hw, PLL0_DIV_CFG0);
+		set_fields_e56(&value, 18, 8, 0x294);
+		set_fields_e56(&value, 4, 0, 0x8);
+		wr32_ephy(hw, PLL0_DIV_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG0);
+		set_fields_e56(&value, 30, 28, 0x7);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 18, 16, 0x3);
+		set_fields_e56(&value, 14, 12, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG1);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		set_fields_e56(&value, 18, 16, 0x3);
+		set_fields_e56(&value, 2, 0, 0x3);
+		wr32_ephy(hw, DATAPATH_CFG1, value);
+
+		value = rd32_ephy(hw, AN_CFG1);
+		set_fields_e56(&value, 4, 0, 0x9);
+		wr32_ephy(hw, AN_CFG1, value);
+
+		txgbe_e56_cfg_temp(hw);
+		txgbe_e56_cfg_25g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0x1); /* TX_EN set */
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+
+		status = txgbe_e56_config_rx(hw, speed);
+
+	}
+
+	if (speed == TXGBE_LINK_SPEED_10GB_FULL) {
+		value = rd32_epcs(hw, SR_PCS_CTRL1);
+		set_fields_e56(&value, 5, 2, 0);
+		wr32_epcs(hw, SR_PCS_CTRL1, value);
+
+		value = rd32_epcs(hw, SR_PCS_CTRL2);
+		set_fields_e56(&value, 3, 0, 0);
+		wr32_epcs(hw, SR_PCS_CTRL2, value);
+
+		value = rd32_epcs(hw, SR_PMA_CTRL2);
+		set_fields_e56(&value, 6, 0, 0xb);
+		wr32_epcs(hw, SR_PMA_CTRL2, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL0);
+		set_fields_e56(&value, 29, 29, 0x1);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDVAL5);
+		set_fields_e56(&value, 24, 24, 0x1);
+		wr32_ephy(hw, ANA_OVRDVAL5, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN0, value);
+
+		value = rd32_ephy(hw, ANA_OVRDEN1);
+		set_fields_e56(&value, 30, 30, 0x1);
+		set_fields_e56(&value, 25, 25, 0x1);
+		wr32_ephy(hw, ANA_OVRDEN1, value);
+
+		value = rd32_ephy(hw, PLL0_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL0_CFG0, value);
+
+		value = rd32_ephy(hw, PLL0_CFG2);
+		set_fields_e56(&value, 12, 8, 0x4);
+		wr32_ephy(hw, PLL0_CFG2, value);
+
+		value = rd32_ephy(hw, PLL1_CFG0);
+		set_fields_e56(&value, 25, 24, 0x1);
+		set_fields_e56(&value, 17, 16, 0x3);
+		wr32_ephy(hw, PLL1_CFG0, value);
+
+		value = rd32_ephy(hw, PLL1_CFG2);
+		set_fields_e56(&value, 12, 8, 0x8);
+		wr32_ephy(hw, PLL1_CFG2, value);
+
+		value = rd32_ephy(hw, PLL0_DIV_CFG0);
+		set_fields_e56(&value, 18, 8, 0x294);
+		set_fields_e56(&value, 4, 0, 0x8);
+		wr32_ephy(hw, PLL0_DIV_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG0);
+		set_fields_e56(&value, 30, 28, 0x7);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 14, 12, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG0, value);
+
+		value = rd32_ephy(hw, DATAPATH_CFG1);
+		set_fields_e56(&value, 26, 24, 0x5);
+		set_fields_e56(&value, 10, 8, 0x5);
+		set_fields_e56(&value, 18, 16, 0x5);
+		set_fields_e56(&value, 2, 0, 0x5);
+		wr32_ephy(hw, DATAPATH_CFG1, value);
+
+		value = rd32_ephy(hw, AN_CFG1);
+		set_fields_e56(&value, 4, 0, 0x2);
+		wr32_ephy(hw, AN_CFG1, value);
+
+		txgbe_e56_cfg_temp(hw);
+		txgbe_e56_cfg_10g(hw);
+
+		value = rd32_ephy(hw, PMD_CFG0);
+		set_fields_e56(&value, 21, 20, 0x3);
+		set_fields_e56(&value, 19, 12, 0x1); /* TX_EN set */
+		set_fields_e56(&value, 8, 8, 0x0);
+		set_fields_e56(&value, 1, 1, 0x1);
+		wr32_ephy(hw, PMD_CFG0, value);
+
+		status = txgbe_e56_config_rx(hw, speed);
+	}
+
+	value = rd32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR);
+	set_fields_e56(&value, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0x28);
+	set_fields_e56(&value, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0xa);
+	wr32_ephy(hw, E56PHY_RXS_IDLE_DETECT_1_ADDR, value);
+
+	wr32_ephy(hw, E56PHY_INTR_0_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+	wr32_ephy(hw, E56PHY_INTR_0_ENABLE_ADDR, E56PHY_INTR_0_IDLE_ENTRY1);
+	wr32_ephy(hw, E56PHY_INTR_1_ENABLE_ADDR, E56PHY_INTR_1_IDLE_EXIT1);
+
+	if (hw->fec_mode != TXGBE_PHY_FEC_AUTO) {
+		hw->cur_fec_link = hw->fec_mode;
+		txgbe_e56_fec_set(hw);
+	}
+
+out:
+	if (ppl_lock) {
+		hw->mac.enable_sec_tx_path(hw);
+		wr32m(hw, TXGBE_MACRXCFG, TXGBE_MACRXCFG_ENA,//todo
+		      TXGBE_MACRXCFG_ENA);
+	}
+
+	hw->mac.enable_tx_laser(hw);
+
+	return status;
+}
+
+s32 txgbe_e56_fec_set(struct txgbe_hw *hw)
+{
+	u32 value;
+
+	if (hw->cur_fec_link  & TXGBE_PHY_FEC_RS) {
+		/* disable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 0);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+
+		/* enable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x68c1);
+		wr32_epcs(hw, 0x180a4, 0x3321);
+		wr32_epcs(hw, 0x180a5, 0x973e);
+		wr32_epcs(hw, 0x180a6, 0xccde);
+
+		wr32_epcs(hw, 0x38018, 1024);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 1);
+		wr32_epcs(hw, 0x100c8, value);
+	} else if (hw->cur_fec_link & TXGBE_PHY_FEC_BASER) {
+		/* disable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x7690);
+		wr32_epcs(hw, 0x180a4, 0x3347);
+		wr32_epcs(hw, 0x180a5, 0x896f);
+		wr32_epcs(hw, 0x180a6, 0xccb8);
+		wr32_epcs(hw, 0x38018, 0x3fff);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 0);
+		wr32_epcs(hw, 0x100c8, value);
+
+		/* enable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 1);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+	} else {
+		/* disable RS FEC */
+		wr32_epcs(hw, 0x180a3, 0x7690);
+		wr32_epcs(hw, 0x180a4, 0x3347);
+		wr32_epcs(hw, 0x180a5, 0x896f);
+		wr32_epcs(hw, 0x180a6, 0xccb8);
+		wr32_epcs(hw, 0x38018, 0x3fff);
+		value = rd32_epcs(hw, 0x100c8);
+		set_fields_e56(&value, 2, 2, 0);
+		wr32_epcs(hw, 0x100c8, value);
+
+		/* disable BASER FEC */
+		value = rd32_epcs(hw, SR_PMA_KR_FEC_CTRL);
+		set_fields_e56(&value, 0, 0, 0);
+		wr32_epcs(hw, SR_PMA_KR_FEC_CTRL, value);
+	}
+
+	return 0;
+}
+
+s32 txgbe_e56_fec_polling(struct txgbe_hw *hw, bool *link_up)
+{
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	s32 status = 0, i =0, j = 0;
+
+	do {
+		if (!(hw->fec_mode & BIT(j))) {
+			j += 1;
+			continue;
+		}
+
+		hw->cur_fec_link = hw->fec_mode & BIT(j);
+
+		/*
+		 * If in fec auto mode, try another fec mode after no link in 1s
+		 * for lr sfp, enable KR-FEC to link up with mellonax and intel
+		 */
+		rte_spinlock_lock(&hw->phy_lock);
+		txgbe_e56_fec_set(hw);
+		rte_spinlock_unlock(&hw->phy_lock);
+
+		for (i = 0; i < 4; i++) {
+			msleep(250);
+			txgbe_e56_check_phy_link(hw, &link_speed, link_up);
+			if (*link_up)
+				return 0;
+		}
+		j += 1;
+	} while (j < 3);
+
+	return status;
+}
\ No newline at end of file
diff --git a/drivers/net/txgbe/base/txgbe_e56.h b/drivers/net/txgbe/base/txgbe_e56.h
new file mode 100644
index 0000000000..bb56236b6f
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56.h
@@ -0,0 +1,1784 @@
+#ifndef _TXGBE_E56_H_
+#define _TXGBE_E56_H_
+
+#include "txgbe_type.h"
+#include "txgbe_hw.h"
+#include "txgbe_osdep.h"
+#include "txgbe_phy.h"
+
+#define EPHY_RREG(REG) \
+	do {\
+		rdata = 0; \
+		rdata = rd32_ephy(hw, REG##_ADDR); \
+	} while(0)
+
+#define EPHY_WREG(REG) \
+	do { \
+		wr32_ephy(hw, REG##_ADDR, rdata); \
+	} while(0)
+
+#define EPCS_RREG(REG) \
+	do {\
+		rdata = 0; \
+		rdata = rd32_epcs(hw, REG##_ADDR); \
+	} while(0)
+
+#define EPCS_WREG(REG) \
+	do { \
+		wr32_epcs(hw, REG##_ADDR, rdata); \
+	} while(0)
+
+#define txgbe_e56_ephy_config(reg, field, val) \
+	do { \
+		EPHY_RREG(reg); \
+		EPHY_XFLD(reg, field) = (val); \
+		EPHY_WREG(reg); \
+	} while(0)
+
+#define txgbe_e56_epcs_config(reg, field, val) \
+	do { \
+		EPCS_RREG(reg); \
+		EPCS_XFLD(reg, field) = (val); \
+		EPCS_WREG(reg); \
+	} while(0)
+
+//--------------------------------
+//LAN GPIO define for SFP+ module
+//--------------------------------
+//-- Fields
+#define SFP1_RS0  5,5
+#define SFP1_RS1  4,4
+#define SFP1_RX_LOS  3,3
+#define SFP1_MOD_ABS  2,2
+#define SFP1_TX_DISABLE  1,1
+#define SFP1_TX_FAULT  0,0
+#define EPHY_XFLD(REG, FLD) ((REG *)&rdata)->FLD
+#define EPCS_XFLD(REG, FLD) ((REG *)&rdata)->FLD
+
+typedef union {
+	struct {
+		u32 ana_refclk_buf_daisy_en_i : 1;
+		u32 ana_refclk_buf_pad_en_i : 1;
+		u32 ana_vddinoff_dcore_dig_o : 1;
+		u32 ana_lcpll_en_clkout_hf_left_top_i : 1;
+		u32 ana_lcpll_en_clkout_hf_right_top_i : 1;
+		u32 ana_lcpll_en_clkout_hf_left_bot_i : 1;
+		u32 ana_lcpll_en_clkout_hf_right_bot_i : 1;
+		u32 ana_lcpll_en_clkout_lf_left_top_i : 1;
+		u32 ana_lcpll_en_clkout_lf_right_top_i : 1;
+		u32 ana_lcpll_en_clkout_lf_left_bot_i : 1;
+		u32 ana_lcpll_en_clkout_lf_right_bot_i : 1;
+		u32 ana_bg_en_i : 1;
+		u32 ana_en_rescal_i : 1;
+		u32 ana_rescal_comp_o : 1;
+		u32 ana_en_ldo_core_i : 1;
+		u32 ana_lcpll_hf_en_bias_i : 1;
+		u32 ana_lcpll_hf_en_loop_i : 1;
+		u32 ana_lcpll_hf_en_cp_i : 1;
+		u32 ana_lcpll_hf_set_lpf_i : 1;
+		u32 ana_lcpll_hf_en_vco_i : 1;
+		u32 ana_lcpll_hf_vco_amp_status_o : 1;
+		u32 ana_lcpll_hf_en_odiv_i : 1;
+		u32 ana_lcpll_lf_en_bias_i : 1;
+		u32 ana_lcpll_lf_en_loop_i : 1;
+		u32 ana_lcpll_lf_en_cp_i : 1;
+		u32 ana_lcpll_lf_set_lpf_i : 1;
+		u32 ana_lcpll_lf_en_vco_i : 1;
+		u32 ana_lcpll_lf_vco_amp_status_o : 1;
+		u32 ana_lcpll_lf_en_odiv_i : 1;
+		u32 ana_lcpll_hf_refclk_select_i : 1;
+		u32 ana_lcpll_lf_refclk_select_i : 1;
+		u32 rsvd0 : 1;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_0;
+
+#define E56G_CMS_ANA_OVRDVAL_0_ADDR 0xcb0
+/* AMLITE ETH PHY Registers */
+#define VR_PCS_DIG_CTRL1                        0x38000
+#define SR_PCS_CTRL1                            0x30000
+#define SR_PCS_CTRL2                            0x30007
+#define SR_PMA_CTRL2                            0x10007
+#define VR_PCS_DIG_CTRL3                        0x38003
+#define VR_PMA_CTRL3                            0x180a8
+#define VR_PMA_CTRL4                            0x180a9
+#define SR_PMA_RS_FEC_CTRL                      0x100c8
+#define CMS_ANA_OVRDEN0                         0xca4
+#define ANA_OVRDEN0                             0xca4
+#define ANA_OVRDEN1                             0xca8
+#define ANA_OVRDVAL0                            0xcb0
+#define ANA_OVRDVAL5                            0xcc4
+#define OSC_CAL_N_CDR4                          0x14
+#define PLL0_CFG0                               0xc10
+#define PLL0_CFG2                               0xc18
+#define PLL0_DIV_CFG0                           0xc1c
+#define PLL1_CFG0                               0xc48
+#define PLL1_CFG2                               0xc50
+#define CMS_PIN_OVRDEN0                         0xc8c
+#define CMS_PIN_OVRDVAL0                        0xc94
+#define DATAPATH_CFG0                           0x142c
+#define DATAPATH_CFG1                           0x1430
+#define AN_CFG1                                 0x1438
+#define SPARE52                                 0x16fc
+#define RXS_CFG0                                0x000
+#define PMD_CFG0                                0x1400
+#define SR_PCS_STS1                             0x30001
+#define PMD_CTRL_FSM_TX_STAT0                   0x14dc
+#define CMS_ANA_OVRDEN0                         0xca4
+#define CMS_ANA_OVRDEN1                         0xca8
+#define CMS_ANA_OVRDVAL2                        0xcb8
+#define CMS_ANA_OVRDVAL4                        0xcc0
+#define CMS_ANA_OVRDVAL5                        0xcc4
+#define CMS_ANA_OVRDVAL7                        0xccc
+#define CMS_ANA_OVRDVAL9                        0xcd4
+#define CMS_ANA_OVRDVAL10                       0xcd8
+
+#define TXS_TXS_CFG1                            0x804
+#define TXS_WKUP_CNT                            0x808
+#define TXS_PIN_OVRDEN0                         0x80c
+#define TXS_PIN_OVRDVAL6                        0x82c
+#define TXS_ANA_OVRDVAL1                        0x854
+
+#define E56PHY_CMS_BASE_ADDR  0x0C00
+
+#define E56PHY_CMS_PIN_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR+0x8C)
+#define E56PHY_CMS_PIN_OVRDEN_0_OVRD_EN_PLL0_TX_SIGNAL_TYPE_I 12,12
+
+#define E56PHY_CMS_PIN_OVRDVAL_0_ADDR   (E56PHY_CMS_BASE_ADDR+0x94)
+#define E56PHY_CMS_PIN_OVRDVAL_0_INT_PLL0_TX_SIGNAL_TYPE_I 10,10
+
+#define E56PHY_CMS_ANA_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR+0xA4)
+
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I 29,29
+
+
+#define E56PHY_CMS_ANA_OVRDEN_1_ADDR   (E56PHY_CMS_BASE_ADDR+0xA8)
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I 4,4
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ADDR   (E56PHY_CMS_BASE_ADDR+0xB8)
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_VCO_SWING_CTRL_I 31,28
+
+#define E56PHY_CMS_ANA_OVRDVAL_4_ADDR   (E56PHY_CMS_BASE_ADDR+0xC0)
+
+
+#define E56PHY_TXS_BASE_ADDR   0x0800
+#define E56PHY_TXS1_BASE_ADDR  0x0900
+#define E56PHY_TXS2_BASE_ADDR  0x0A00
+#define E56PHY_TXS3_BASE_ADDR  0x0B00
+#define E56PHY_TXS_OFFSET      0x0100
+
+#define E56PHY_PMD_RX_OFFSET   0x02C
+
+#define E56PHY_TXS_TXS_CFG_1_ADDR   (E56PHY_TXS_BASE_ADDR+0x04)
+#define E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256 7,4
+#define E56PHY_TXS_WKUP_CNT_ADDR   (E56PHY_TXS_BASE_ADDR+0x08)
+#define E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32 7,0
+#define E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32 15,8
+
+
+#define E56PHY_TXS_PIN_OVRDEN_0_ADDR   (E56PHY_TXS_BASE_ADDR+0x0C)
+#define E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I 28,28
+
+#define E56PHY_TXS_PIN_OVRDVAL_6_ADDR   (E56PHY_TXS_BASE_ADDR+0x2C)
+
+#define E56PHY_TXS_ANA_OVRDVAL_1_ADDR   (E56PHY_TXS_BASE_ADDR+0x54)
+#define E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I 23,8
+
+#define E56PHY_TXS_ANA_OVRDEN_0_ADDR   (E56PHY_TXS_BASE_ADDR+0x44)
+#define E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I 13,13
+
+#define E56PHY_RXS_BASE_ADDR   0x0000
+#define E56PHY_RXS1_BASE_ADDR  0x0200
+#define E56PHY_RXS2_BASE_ADDR  0x0400
+#define E56PHY_RXS3_BASE_ADDR  0x0600
+#define E56PHY_RXS_OFFSET      0x0200
+
+#define E56PHY_RXS_RXS_CFG_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x000)
+#define E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL 1,1
+#define E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN 17,4
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x008)
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1 15,0
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1_LSB 0
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1 31,16
+#define E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1_LSB 16
+
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR   (E56PHY_RXS_BASE_ADDR+0x014)
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_RANGE_SEL1 3,2
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_VCO_CODE_INIT 18,8
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_CURRENT_BOOST_EN1 21,21
+#define E56PHY_RXS_OSC_CAL_N_CDR_4_BBCDR_CURRENT_BOOST1 27,26
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR   (E56PHY_RXS_BASE_ADDR+0x018)
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH 3,2
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK 15,12
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK 19,16
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK 23,20
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK 27,24
+#define E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT 30,28
+
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR   (E56PHY_RXS_BASE_ADDR+0x01C)
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK 3,0
+#define E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK 7,4
+
+#define E56PHY_RXS_INTL_CONFIG_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x020)
+#define E56PHY_RXS_INTL_CONFIG_0_ADC_INTL2SLICE_DELAY1 31,16
+
+#define E56PHY_RXS_INTL_CONFIG_2_ADDR   (E56PHY_RXS_BASE_ADDR+0x028)
+#define E56PHY_RXS_INTL_CONFIG_2_INTERLEAVER_HBW_DISABLE1 1,1
+
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x02C)
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH 18,12
+#define E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH 26,20
+
+#define E56PHY_RXS_TXFFE_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x030)
+#define E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH 8,0
+#define E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH 20,12
+
+#define E56PHY_RXS_TXFFE_TRAINING_2_ADDR   (E56PHY_RXS_BASE_ADDR+0x034)
+#define E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH 8,0
+#define E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH 20,12
+
+
+#define E56PHY_RXS_TXFFE_TRAINING_3_ADDR   (E56PHY_RXS_BASE_ADDR+0x038)
+#define E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH 8,0
+#define E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH 20,12
+#define E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE 26,21
+
+#define E56PHY_RXS_VGA_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x04C)
+#define E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET 18,12
+
+
+#define E56PHY_RXS_VGA_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x050)
+#define E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0 4,0
+#define E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0 12,8
+#define E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123 20,16
+#define E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123 28,24
+
+#define E56PHY_RXS_CTLE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x054)
+#define E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0 24,20
+#define E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123 31,27
+
+#define E56PHY_RXS_CTLE_TRAINING_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x058)
+#define E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT 24,0
+
+#define E56PHY_RXS_CTLE_TRAINING_2_ADDR   (E56PHY_RXS_BASE_ADDR+0x05C)
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1 5,0
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2 13,8
+#define E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3 21,16
+
+
+#define E56PHY_RXS_CTLE_TRAINING_3_ADDR   (E56PHY_RXS_BASE_ADDR+0x060)
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1 9,8
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2 11,10
+#define E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3 13,12
+
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x064)
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT 5,4
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT 9,8
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8 31,28
+
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x068)
+#define E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG 31,28
+
+#define E56PHY_RXS_FFE_TRAINING_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x070)
+#define E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN 23,8
+
+#define E56PHY_RXS_IDLE_DETECT_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x088)
+#define E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX 22,16
+#define E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN 30,24
+
+#define E56PHY_RXS_ANA_OVRDEN_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x08C)
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I 0,0
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_TRIM_RTERM_I 1,1
+#define E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I 29,29
+
+#define E56PHY_RXS_ANA_OVRDEN_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x090)
+#define E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I 0,0
+#define E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I 9,9
+
+#define E56PHY_RXS_ANA_OVRDEN_3_ADDR   (E56PHY_RXS_BASE_ADDR+0x098)
+#define E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I 15,15
+#define E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I 25,25
+
+#define E56PHY_RXS_ANA_OVRDEN_4_ADDR   (E56PHY_RXS_BASE_ADDR+0x09C)
+#define E56PHY_RXS_ANA_OVRDVAL_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x0A0)
+#define E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I 0,0
+
+#define E56PHY_RXS_ANA_OVRDVAL_6_ADDR   (E56PHY_RXS_BASE_ADDR+0x0B8)
+#define E56PHY_RXS_ANA_OVRDVAL_14_ADDR   (E56PHY_RXS_BASE_ADDR+0x0D8)
+#define E56PHY_RXS_ANA_OVRDVAL_15_ADDR   (E56PHY_RXS_BASE_ADDR+0x0DC)
+#define E56PHY_RXS_ANA_OVRDVAL_17_ADDR   (E56PHY_RXS_BASE_ADDR+0x0E4)
+#define E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I 18,16
+
+#define E56PHY_RXS_EYE_SCAN_1_ADDR   (E56PHY_RXS_BASE_ADDR+0x1A4)
+#define E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER 31,0
+
+#define E56PHY_RXS_ANA_OVRDVAL_5_ADDR   (E56PHY_RXS_BASE_ADDR+0x0B4)
+#define E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I 1,0
+
+#define E56PHY_RXS_RINGO_0_ADDR   (E56PHY_RXS_BASE_ADDR+0x1FC)
+
+#define E56PHY_PMD_BASE_ADDR  0x1400
+#define E56PHY_PMD_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x000)
+#define E56PHY_PMD_CFG_0_RX_EN_CFG 19,16
+
+#define E56PHY_PMD_CFG_3_ADDR   (E56PHY_PMD_BASE_ADDR+0x00C)
+#define E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K 31,24
+#define E56PHY_PMD_CFG_4_ADDR   (E56PHY_PMD_BASE_ADDR+0x010)
+#define E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K 7,0
+#define E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K 15,8
+#define E56PHY_PMD_CFG_5_ADDR   (E56PHY_PMD_BASE_ADDR+0x014)
+#define E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET 12,12
+#define E56PHY_CTRL_FSM_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x040)
+#define E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_OFST_CAL_ERR 4,4
+#define E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR 5,5
+#define E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL 9,8
+#define E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN 31,24
+
+
+#define E56PHY_CTRL_FSM_CFG_1_ADDR   (E56PHY_PMD_BASE_ADDR+0x044)
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096 7,0
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096 15,8
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096 23,16
+#define E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096 31,24
+
+#define E56PHY_CTRL_FSM_CFG_2_ADDR   (E56PHY_PMD_BASE_ADDR+0x048)
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096 7,0
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096 15,8
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096 23,16
+#define E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096 31,24
+
+#define E56PHY_CTRL_FSM_CFG_3_ADDR   (E56PHY_PMD_BASE_ADDR+0x04C)
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096 7,0
+
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096 15,8
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096 23,16
+#define E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096 31,24
+
+#define E56PHY_CTRL_FSM_CFG_4_ADDR   (E56PHY_PMD_BASE_ADDR+0x050)
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096 7,0
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096 15,8
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096 23,16
+#define E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096 31,24
+
+#define E56PHY_CTRL_FSM_CFG_7_ADDR   (E56PHY_PMD_BASE_ADDR+0x05C)
+#define E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN 15,0
+#define E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_8_ADDR   (E56PHY_PMD_BASE_ADDR+0x060)
+#define E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_12_ADDR   (E56PHY_PMD_BASE_ADDR+0x070)
+#define E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_13_ADDR   (E56PHY_PMD_BASE_ADDR+0x074)
+#define E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN 15,0
+#define E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_14_ADDR   (E56PHY_PMD_BASE_ADDR+0x078)
+#define E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_15_ADDR   (E56PHY_PMD_BASE_ADDR+0x07C)
+#define E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN 15,0
+
+#define E56PHY_CTRL_FSM_CFG_17_ADDR   (E56PHY_PMD_BASE_ADDR+0x084)
+#define E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN 15,0
+
+#define E56PHY_CTRL_FSM_CFG_18_ADDR   (E56PHY_PMD_BASE_ADDR+0x088)
+#define E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN 15,0
+
+#define E56PHY_CTRL_FSM_CFG_29_ADDR   (E56PHY_PMD_BASE_ADDR+0x0B4)
+#define E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN 31,16
+
+#define E56PHY_CTRL_FSM_CFG_33_ADDR   (E56PHY_PMD_BASE_ADDR+0x0C4)
+#define E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL 15,0
+#define E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL 31,16
+
+#define E56PHY_CTRL_FSM_CFG_34_ADDR   (E56PHY_PMD_BASE_ADDR+0x0C8)
+#define E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL 15,0
+#define E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL 31,16
+
+#define E56PHY_CTRL_FSM_RX_STAT_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x0FC)
+#define E56PHY_RXS0_OVRDEN_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x130)
+#define E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O 27,27
+
+#define E56PHY_RXS0_OVRDEN_1_ADDR   (E56PHY_PMD_BASE_ADDR+0x134)
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I 14,14
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I 16,16
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CDR_EN_I 18,18
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_EN_I 23,23
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O 24,24
+#define E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB 24
+
+
+#define E56PHY_RXS0_OVRDEN_2_ADDR   (E56PHY_PMD_BASE_ADDR+0x138)
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_OFST_ADAPT_EN_I 0,0
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_GAIN_ADAPT_EN_I 3,3
+#define E56PHY_RXS0_OVRDEN_2_OVRD_EN_RXS0_RX0_ADC_INTL_ADAPT_EN_I 6,6
+
+#define E56PHY_RXS0_OVRDVAL_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x140)
+#define E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O 22,22
+
+#define E56PHY_RXS0_OVRDVAL_1_ADDR   (E56PHY_PMD_BASE_ADDR+0x144)
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I 7,7
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I 9,9
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CDR_EN_I 11,11
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I 16,16
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O 17,17
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB 17
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I 25,25
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I 28,28
+#define E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I 31,31
+
+#define E56PHY_INTR_0_IDLE_ENTRY1              0x10000000
+#define E56PHY_INTR_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x1EC)
+#define E56PHY_INTR_0_ENABLE_ADDR   (E56PHY_PMD_BASE_ADDR+0x1E0)
+
+#define E56PHY_INTR_1_IDLE_EXIT1               0x1
+#define E56PHY_INTR_1_ADDR   (E56PHY_PMD_BASE_ADDR+0x1F0)
+#define E56PHY_INTR_1_ENABLE_ADDR   (E56PHY_PMD_BASE_ADDR+0x1E4)
+
+#define E56PHY_KRT_TFSM_CFG_ADDR   (E56PHY_PMD_BASE_ADDR+0x2B8)
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K 7,0
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K 15,8
+#define E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K 23,16
+
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR   (E56PHY_PMD_BASE_ADDR+0x2BC)
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2 9,8
+#define E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_3 13,12
+
+#define PHYINIT_TIMEOUT 1000 //PHY initialization timeout value in 0.5ms unit
+
+#define E56G__BASEADDR 0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_vco_swing_ctrl_i : 4;
+		u32 ana_lcpll_lf_lpf_setcode_calib_i : 5;
+		u32 rsvd0 : 3;
+		u32 ana_lcpll_lf_vco_coarse_bin_i : 5;
+		u32 rsvd1 : 3;
+		u32 ana_lcpll_lf_vco_fine_therm_i : 8;
+		u32 ana_lcpll_lf_clkout_fb_ctrl_i : 2;
+		u32 rsvd2 : 2;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_7;
+#define E56G_CMS_ANA_OVRDVAL_7_ADDR                   (E56G__BASEADDR+0xccc)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_lcpll_hf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_bias_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_loop_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_cp_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_base_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_fine_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_setcode_calib_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_set_lpf_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_vco_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_coarse_bin_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_fine_therm_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_test_bias_i : 1;
+		u32 ovrd_en_ana_test_slicer_i : 1;
+		u32 ovrd_en_ana_test_sampler_i : 1;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDEN_1;
+
+#define E56G_CMS_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR+0xca8)
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_test_in_i : 32;
+	};
+	u32 reg;
+} E56G_CMS_ANA_OVRDVAL_9;
+
+#define E56G_CMS_ANA_OVRDVAL_9_ADDR                   (E56G__BASEADDR+0xcd4)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_bbcdr_vcofilt_byp_i : 1;
+		u32 ovrd_en_ana_bbcdr_coarse_i : 1;
+		u32 ovrd_en_ana_bbcdr_fine_i : 1;
+		u32 ovrd_en_ana_bbcdr_ultrafine_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_i : 1;
+		u32 ovrd_en_ana_bbcdr_divctrl_i : 1;
+		u32 ovrd_en_ana_bbcdr_int_cstm_i : 1;
+		u32 ovrd_en_ana_bbcdr_prop_step_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_clk_i : 1;
+		u32 ovrd_en_ana_test_bbcdr_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_elv_cnt_ping_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_elv_cnt_pong_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_cnt_sync_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_elv_cnt_rd_i : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_rdout_270_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_ping_270_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_elv_cnt_pong_270_o : 1;
+		u32 ovrd_en_ana_en_bbcdr_samp_dac_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac0_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac90_i : 1;
+		u32 ovrd_en_ana_vga2_cload_in_cstm_i : 1;
+		u32 ovrd_en_ana_intlvr_cut_bw_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_1;
+
+#define E56G__RXS0_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR+0x90)
+
+//-----Access structure typedef for Register:E56G__RXS0_OSC_CAL_N_CDR_0
+typedef union {
+	struct {
+		u32 prediv0 : 16;
+		u32 target_cnt0 : 16;
+	};
+	u32 reg;
+} E56G_RXS0_OSC_CAL_N_CDR_0;
+//-----MACRO defines for Register:E56G__RXS0_OSC_CAL_N_CDR_0
+#define E56G_RXS0_OSC_CAL_N_CDR_0_ADDR                  (E56G__BASEADDR+0x4)
+
+typedef union {
+	struct {
+		u32 osc_range_sel0 : 2;
+		u32 osc_range_sel1 : 2;
+		u32 osc_range_sel2 : 2;
+		u32 osc_range_sel3 : 2;
+		u32 vco_code_init : 11;
+		u32 calibrate_range_sel : 1;
+		u32 osc_current_boost_en0 : 1;
+		u32 osc_current_boost_en1 : 1;
+		u32 osc_current_boost_en2 : 1;
+		u32 osc_current_boost_en3 : 1;
+		u32 bbcdr_current_boost0 : 2;
+		u32 bbcdr_current_boost1 : 2;
+		u32 bbcdr_current_boost2 : 2;
+		u32 bbcdr_current_boost3 : 2;
+	};
+	u32 reg;
+} E56G_RXS0_OSC_CAL_N_CDR_4;
+//-----MACRO defines for Register:E56G__RXS0_OSC_CAL_N_CDR_4
+#define E56G_RXS0_OSC_CAL_N_CDR_4_ADDR                 (E56G__BASEADDR+0x14)
+
+//-----Access structure typedef for Register:E56G__RXS0_INTL_CONFIG_0
+typedef union {
+	struct {
+		u32 adc_intl2slice_delay0 : 16;
+		u32 adc_intl2slice_delay1 : 16;
+	};
+	u32 reg;
+} E56G_RXS0_INTL_CONFIG_0;
+//-----MACRO defines for Register:E56G__RXS0_INTL_CONFIG_0
+#define E56G_RXS0_INTL_CONFIG_0_ADDR                   (E56G__BASEADDR+0x20)
+
+//-----Access structure typedef for Register:E56G__RXS0_INTL_CONFIG_2
+typedef union {
+	struct {
+		u32 interleaver_hbw_disable0 : 1;
+		u32 interleaver_hbw_disable1 : 1;
+		u32 interleaver_hbw_disable2 : 1;
+		u32 interleaver_hbw_disable3 : 1;
+		u32 rsvd0 : 28;
+	};
+	u32 reg;
+} E56G_RXS0_INTL_CONFIG_2;
+//-----MACRO defines for Register:E56G__RXS0_INTL_CONFIG_2
+#define E56G_RXS0_INTL_CONFIG_2_ADDR                   (E56G__BASEADDR+0x28)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_bbcdr_dac180_i : 1;
+		u32 ovrd_en_ana_bbcdr_dac270_i : 1;
+		u32 ovrd_en_ana_bbcdr_en_samp_cal_cnt_i : 1;
+		u32 ovrd_en_ana_bbcdr_clrz_samp_cal_cnt_i : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_0_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_90_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_180_o : 1;
+		u32 ovrd_en_ana_bbcdr_samp_cnt_270_o : 1;
+		u32 ovrd_en_ana_en_adcbuf1_i : 1;
+		u32 ovrd_en_ana_test_adcbuf1_i : 1;
+		u32 ovrd_en_ana_en_adc_clk4ui_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew0_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew90_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew180_i : 1;
+		u32 ovrd_en_ana_adc_clk_skew270_i : 1;
+		u32 ovrd_en_ana_adc_update_skew_i : 1;
+		u32 ovrd_en_ana_en_adc_pi_i : 1;
+		u32 ovrd_en_ana_adc_pictrl_quad_i : 1;
+		u32 ovrd_en_ana_adc_pctrl_code_i : 1;
+		u32 ovrd_en_ana_adc_clkdiv_i : 1;
+		u32 ovrd_en_ana_test_adc_clkgen_i : 1;
+		u32 ovrd_en_ana_en_adc_i : 1;
+		u32 ovrd_en_ana_en_adc_vref_i : 1;
+		u32 ovrd_en_ana_vref_cnfg_i : 1;
+		u32 ovrd_en_ana_adc_data_cstm_o : 1;
+		u32 ovrd_en_ana_en_adccal_lpbk_i : 1;
+		u32 ovrd_en_ana_sel_adcoffset_cal_i : 1;
+		u32 ovrd_en_ana_sel_adcgain_cal_i : 1;
+		u32 ovrd_en_ana_adcgain_cal_swing_ctrl_i : 1;
+		u32 ovrd_en_ana_adc_gain_i : 1;
+		u32 ovrd_en_ana_vga_cload_out_cstm_i : 1;
+		u32 ovrd_en_ana_vga2_cload_out_cstm_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_2;
+//-----MACRO defines for Register:E56G__RXS0_ANA_OVRDEN_2
+#define E56G__RXS0_ANA_OVRDEN_2_ADDR                    (E56G__BASEADDR+0x94)
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_adc_offset_i         : 1;
+		u32 ovrd_en_ana_adc_slice_addr_i     : 1;
+		u32 ovrd_en_ana_slice_wr_i           : 1;
+		u32 ovrd_en_ana_test_adc_i           : 1;
+		u32 ovrd_en_ana_test_adc_o           : 1;
+		u32 ovrd_en_ana_spare_o              : 8;
+		u32 ovrd_en_ana_sel_lpbk_i           : 1;
+		u32 ovrd_en_ana_ana_debug_sel_i      : 1;
+		u32 ovrd_en_ana_anabs_config_i       : 1;
+		u32 ovrd_en_ana_en_anabs_i           : 1;
+		u32 ovrd_en_ana_anabs_rxn_o          : 1;
+		u32 ovrd_en_ana_anabs_rxp_o          : 1;
+		u32 ovrd_en_ana_dser_clk_en_i        : 1;
+		u32 ovrd_en_ana_dser_clk_config_i    : 1;
+		u32 ovrd_en_ana_en_mmcdr_clk_obs_i   : 1;
+		u32 ovrd_en_ana_skew_coarse0_fine1_i : 1;
+		u32 ovrd_en_ana_vddinoff_acore_dig_o : 1;
+		u32 ovrd_en_ana_vddinoff_dcore_dig_o : 1;
+		u32 ovrd_en_ana_vga2_boost_cstm_i    : 1;
+		u32 ovrd_en_ana_adc_sel_vbgr_bias_i  : 1;
+		u32 ovrd_en_ana_adc_nbuf_cnfg_i      : 1;
+		u32 ovrd_en_ana_adc_pbuf_cnfg_i      : 1;
+		u32 rsvd0                            : 3;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_3;
+//-----MACRO defines for Register:E56G__RXS0_ANA_OVRDEN_3
+#define E56G__RXS0_ANA_OVRDEN_3_NUM                                         1
+#define E56G__RXS0_ANA_OVRDEN_3_ADDR                    (E56G__BASEADDR+0x98)
+
+//-----Access structure typedef for Register:E56G__RXS0_RXS_CFG_0
+typedef union {
+	struct {
+		u32 pam4_ab_swap_en          : 1;
+		u32 dser_data_sel            : 1;
+		u32 signal_type              : 1;
+		u32 precode_en               : 1;
+		u32 train_clk_gate_bypass_en : 14;
+		u32 rsvd0                    : 14;
+	};
+	u32 reg;
+} E56G__RXS0_RXS_CFG_0;
+//-----MACRO defines for Register:E56G__RXS0_RXS_CFG_0
+#define E56G__RXS0_RXS_CFG_0_NUM                                            1
+#define E56G__RXS0_RXS_CFG_0_ADDR                        (E56G__BASEADDR+0x0)
+
+//-----Access structure typedef for Register:E56G__PMD_BASER_PMD_CONTROL
+typedef union {
+	struct {
+		u32 restart_training_ln0 : 1;
+		u32 training_enable_ln0  : 1;
+		u32 restart_training_ln1 : 1;
+		u32 training_enable_ln1  : 1;
+		u32 restart_training_ln2 : 1;
+		u32 training_enable_ln2  : 1;
+		u32 restart_training_ln3 : 1;
+		u32 training_enable_ln3  : 1;
+		u32 rsvd0                : 24;
+	};
+	u32 reg;
+} E56G__PMD_BASER_PMD_CONTROL;
+//-----MACRO defines for Register:E56G__PMD_BASER_PMD_CONTROL
+#define E56G__PMD_BASER_PMD_CONTROL_NUM                                     1
+#define E56G__PMD_BASER_PMD_CONTROL_ADDR              (E56G__BASEADDR+0x1640)
+
+//-----Access structure typedef for Register:E56G__PMD_PMD_CFG_5
+typedef union {
+	struct {
+		u32 rx_to_tx_lpbk_en         : 4;
+		u32 sel_wp_pmt_out           : 4;
+		u32 sel_wp_pmt_clkout        : 4;
+		u32 use_recent_marker_offset : 1;
+		u32 interrupt_debug_mode     : 1;
+		u32 rsvd0                    : 2;
+		u32 tx_ffe_coeff_update      : 4;
+		u32 rsvd1                    : 12;
+	};
+	u32 reg;
+} E56G__PMD_PMD_CFG_5;
+//-----MACRO defines for Register:E56G__PMD_PMD_CFG_5
+#define E56G__PMD_PMD_CFG_5_NUM                                             1
+#define E56G__PMD_PMD_CFG_5_ADDR                      (E56G__BASEADDR+0x1414)
+
+//-----Access structure typedef for Register:E56G__PMD_PMD_CFG_0
+typedef union {
+	struct {
+		u32 soft_reset             : 1;
+		u32 pmd_en                 : 1;
+		u32 rsvd0                  : 2;
+		u32 pll_refclk_sel         : 2;
+		u32 rsvd1                  : 2;
+		u32 pmd_mode               : 1;
+		u32 rsvd2                  : 3;
+		u32 tx_en_cfg              : 4;
+		u32 rx_en_cfg              : 4;
+		u32 pll_en_cfg             : 2;
+		u32 rsvd3                  : 2;
+		u32 pam4_precode_no_krt_en : 4;
+		u32 rsvd4                  : 4;
+	};
+	u32 reg;
+} E56G__PMD_PMD_CFG_0;
+//-----MACRO defines for Register:E56G__PMD_PMD_CFG_0
+#define E56G__PMD_PMD_CFG_0_NUM                                             1
+#define E56G__PMD_PMD_CFG_0_ADDR                      (E56G__BASEADDR+0x1400)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS0_OVRDEN_0
+typedef union {
+  struct {
+    u32 ovrd_en_rxs0_rx0_rstn_i               : 1;
+    u32 ovrd_en_rxs0_rx0_bitclk_divctrl_i     : 1;
+    u32 ovrd_en_rxs0_rx0_bitclk_rate_i        : 1;
+    u32 ovrd_en_rxs0_rx0_symdata_width_i      : 1;
+    u32 ovrd_en_rxs0_rx0_symdata_o            : 1;
+    u32 ovrd_en_rxs0_rx0_precode_en_i         : 1;
+    u32 ovrd_en_rxs0_rx0_signal_type_i        : 1;
+    u32 ovrd_en_rxs0_rx0_sync_detect_en_i     : 1;
+    u32 ovrd_en_rxs0_rx0_sync_o               : 1;
+    u32 ovrd_en_rxs0_rx0_rate_select_i        : 1;
+    u32 ovrd_en_rxs0_rx0_rterm_en_i           : 1;
+    u32 ovrd_en_rxs0_rx0_bias_en_i            : 1;
+    u32 ovrd_en_rxs0_rx0_ldo_en_i             : 1;
+    u32 ovrd_en_rxs0_rx0_ldo_rdy_i            : 1;
+    u32 ovrd_en_rxs0_rx0_blwc_en_i            : 1;
+    u32 ovrd_en_rxs0_rx0_ctle_en_i            : 1;
+    u32 ovrd_en_rxs0_rx0_vga_en_i             : 1;
+    u32 ovrd_en_rxs0_rx0_osc_sel_i            : 1;
+    u32 ovrd_en_rxs0_rx0_osc_en_i             : 1;
+    u32 ovrd_en_rxs0_rx0_clkgencdr_en_i       : 1;
+    u32 ovrd_en_rxs0_rx0_ctlecdr_en_i         : 1;
+    u32 ovrd_en_rxs0_rx0_samp_en_i            : 1;
+    u32 ovrd_en_rxs0_rx0_adc_en_i             : 1;
+    u32 ovrd_en_rxs0_rx0_osc_cal_en_i         : 1;
+    u32 ovrd_en_rxs0_rx0_osc_cal_done_o       : 1;
+    u32 ovrd_en_rxs0_rx0_osc_freq_error_o     : 1;
+    u32 ovrd_en_rxs0_rx0_samp_cal_en_i        : 1;
+    u32 ovrd_en_rxs0_rx0_samp_cal_done_o      : 1;
+    u32 ovrd_en_rxs0_rx0_samp_cal_err_o       : 1;
+    u32 ovrd_en_rxs0_rx0_adc_ofst_cal_en_i    : 1;
+    u32 ovrd_en_rxs0_rx0_adc_ofst_cal_done_o  : 1;
+    u32 ovrd_en_rxs0_rx0_adc_ofst_cal_error_o : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS0_OVRDEN_0;
+//-----MACRO defines for Register:E56G__PMD_RXS0_OVRDEN_0
+#define E56G__PMD_RXS0_OVRDEN_0_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_0_ADDR                  (E56G__BASEADDR+0x1530)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS0_OVRDEN_3
+typedef union {
+  struct {
+    u32 ovrd_en_rxs0_rx0_sparein_i  : 8;
+    u32 ovrd_en_rxs0_rx0_spareout_o : 8;
+    u32 rsvd0                       : 16;
+  };
+  u32 reg;
+} E56G__PMD_RXS0_OVRDEN_3;
+//-----MACRO defines for Register:E56G__PMD_RXS0_OVRDEN_3
+#define E56G__PMD_RXS0_OVRDEN_3_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_3_ADDR                  (E56G__BASEADDR+0x153c)
+
+//-----Access structure typedef for Register:E56G__RXS0_DIG_OVRDEN_1
+typedef union {
+  struct {
+    u32 vco_code_cont_adj_done_ovrd_en : 1;
+    u32 dfe_coeffl_ovrd_en             : 1;
+    u32 dfe_coeffh_ovrd_en             : 1;
+    u32 rsvd0                          : 1;
+    u32 top_comp_th_ovrd_en            : 1;
+    u32 mid_comp_th_ovrd_en            : 1;
+    u32 bot_comp_th_ovrd_en            : 1;
+    u32 rsvd1                          : 1;
+    u32 level_target_ovrd_en           : 4;
+    u32 ffe_coeff_c0to3_ovrd_en        : 4;
+    u32 ffe_coeff_c4to7_ovrd_en        : 4;
+    u32 ffe_coeff_c8to11_ovrd_en       : 4;
+    u32 ffe_coeff_c12to15_ovrd_en      : 4;
+    u32 ffe_coeff_update_ovrd_en       : 1;
+    u32 rsvd2                          : 3;
+  };
+  u32 reg;
+} E56G__RXS0_DIG_OVRDEN_1;
+//-----MACRO defines for Register:E56G__RXS0_DIG_OVRDEN_1
+#define E56G__RXS0_DIG_OVRDEN_1_NUM                                         1
+#define E56G__RXS0_DIG_OVRDEN_1_ADDR                   (E56G__BASEADDR+0x160)
+
+//-----Access structure typedef for Register:E56G__RXS0_DFT_1
+typedef union {
+  struct {
+    u32 ber_en                            : 1;
+    u32 rsvd0                             : 3;
+    u32 read_mode_en                      : 1;
+    u32 rsvd1                             : 3;
+    u32 err_cnt_mode_all0_one1            : 1;
+    u32 rsvd2                             : 3;
+    u32 init_lfsr_mode_continue0_restart1 : 1;
+    u32 rsvd3                             : 3;
+    u32 pattern_sel                       : 4;
+    u32 rsvd4                             : 12;
+  };
+  u32 reg;
+} E56G__RXS0_DFT_1;
+//-----MACRO defines for Register:E56G__RXS0_DFT_1
+#define E56G__RXS0_DFT_1_NUM                                                1
+#define E56G__RXS0_DFT_1_ADDR                   (E56G__BASEADDR+0xec)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS0_OVRDEN_2
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_ofst_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_adapt_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_samp_th_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_samp_th_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_efuse_bits_i : 1;
+		u32 ovrd_en_rxs0_rx0_wp_pmt_in_i : 1;
+		u32 ovrd_en_rxs0_rx0_wp_pmt_out_o : 1;
+		u32 rsvd0 : 15;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_2;
+//-----MACRO defines for Register:E56G__PMD_RXS0_OVRDEN_2
+#define E56G__PMD_RXS0_OVRDEN_2_ADDR                  (E56G__BASEADDR+0x1538)
+
+typedef union {
+	struct {
+		u32 ana_bbcdr_osc_range_sel_i : 2;
+		u32 rsvd0 : 2;
+		u32 ana_bbcdr_coarse_i : 4;
+		u32 ana_bbcdr_fine_i : 3;
+		u32 rsvd1 : 1;
+		u32 ana_bbcdr_ultrafine_i : 3;
+		u32 rsvd2 : 1;
+		u32 ana_bbcdr_divctrl_i : 2;
+		u32 rsvd3 : 2;
+		u32 ana_bbcdr_int_cstm_i : 5;
+		u32 rsvd4 : 3;
+		u32 ana_bbcdr_prop_step_i : 4;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_5;
+//-----MACRO defines for Register:E56G__RXS0_ANA_OVRDVAL_5
+#define E56G__RXS0_ANA_OVRDVAL_5_ADDR                   (E56G__BASEADDR+0xb4)
+
+typedef union {
+	struct {
+		u32 ana_adc_pictrl_quad_i : 2;
+		u32 rsvd0 : 2;
+		u32 ana_adc_clkdiv_i : 2;
+		u32 rsvd1 : 2;
+		u32 ana_test_adc_clkgen_i : 4;
+		u32 ana_vref_cnfg_i : 4;
+		u32 ana_adcgain_cal_swing_ctrl_i : 4;
+		u32 ana_adc_gain_i : 4;
+		u32 ana_adc_offset_i : 4;
+		u32 ana_ana_debug_sel_i : 4;
+	};
+	u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_11;
+//-----MACRO defines for Register:E56G__RXS3_ANA_OVRDVAL_11
+#define E56G__RXS3_ANA_OVRDVAL_11_ADDR                 (E56G__BASEADDR+0x6cc)
+
+typedef union {
+	struct {
+		u32 rxs0_rx0_fe_ofst_cal_error_o : 1;
+		u32 rxs0_rx0_fom_en_i : 1;
+		u32 rxs0_rx0_idle_detect_en_i : 1;
+		u32 rxs0_rx0_idle_o : 1;
+		u32 rxs0_rx0_txffe_train_en_i : 1;
+		u32 rxs0_rx0_txffe_train_enack_o : 1;
+		u32 rxs0_rx0_txffe_train_done_o : 1;
+		u32 rxs0_rx0_vga_train_en_i : 1;
+		u32 rxs0_rx0_vga_train_done_o : 1;
+		u32 rxs0_rx0_ctle_train_en_i : 1;
+		u32 rxs0_rx0_ctle_train_done_o : 1;
+		u32 rxs0_rx0_cdr_en_i : 1;
+		u32 rxs0_rx0_cdr_rdy_o : 1;
+		u32 rxs0_rx0_ffe_train_en_i : 1;
+		u32 rxs0_rx0_ffe_train_done_o : 1;
+		u32 rxs0_rx0_mmpd_en_i : 1;
+		u32 rxs0_rx0_adc_intl_cal_en_i : 1;
+		u32 rxs0_rx0_adc_intl_cal_done_o : 1;
+		u32 rxs0_rx0_adc_intl_cal_error_o : 1;
+		u32 rxs0_rx0_dfe_train_en_i : 1;
+		u32 rxs0_rx0_dfe_train_done_o : 1;
+		u32 rxs0_rx0_vga_adapt_en_i : 1;
+		u32 rxs0_rx0_vga_adapt_done_o : 1;
+		u32 rxs0_rx0_ctle_adapt_en_i : 1;
+		u32 rxs0_rx0_ctle_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_en_i : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_ofst_adapt_error_o : 1;
+		u32 rxs0_rx0_adc_gain_adapt_en_i : 1;
+		u32 rxs0_rx0_adc_gain_adapt_done_o : 1;
+		u32 rxs0_rx0_adc_gain_adapt_error_o : 1;
+		u32 rxs0_rx0_adc_intl_adapt_en_i : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDVAL_1;
+#define E56G__PMD_RXS0_OVRDVAL_1_ADDR                 (E56G__BASEADDR+0x1544)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS1_OVRDVAL_1
+typedef union {
+  struct {
+    u32 rxs1_rx0_fe_ofst_cal_error_o    : 1;
+    u32 rxs1_rx0_fom_en_i               : 1;
+    u32 rxs1_rx0_idle_detect_en_i       : 1;
+    u32 rxs1_rx0_idle_o                 : 1;
+    u32 rxs1_rx0_txffe_train_en_i       : 1;
+    u32 rxs1_rx0_txffe_train_enack_o    : 1;
+    u32 rxs1_rx0_txffe_train_done_o     : 1;
+    u32 rxs1_rx0_vga_train_en_i         : 1;
+    u32 rxs1_rx0_vga_train_done_o       : 1;
+    u32 rxs1_rx0_ctle_train_en_i        : 1;
+    u32 rxs1_rx0_ctle_train_done_o      : 1;
+    u32 rxs1_rx0_cdr_en_i               : 1;
+    u32 rxs1_rx0_cdr_rdy_o              : 1;
+    u32 rxs1_rx0_ffe_train_en_i         : 1;
+    u32 rxs1_rx0_ffe_train_done_o       : 1;
+    u32 rxs1_rx0_mmpd_en_i              : 1;
+    u32 rxs1_rx0_adc_intl_cal_en_i      : 1;
+    u32 rxs1_rx0_adc_intl_cal_done_o    : 1;
+    u32 rxs1_rx0_adc_intl_cal_error_o   : 1;
+    u32 rxs1_rx0_dfe_train_en_i         : 1;
+    u32 rxs1_rx0_dfe_train_done_o       : 1;
+    u32 rxs1_rx0_vga_adapt_en_i         : 1;
+    u32 rxs1_rx0_vga_adapt_done_o       : 1;
+    u32 rxs1_rx0_ctle_adapt_en_i        : 1;
+    u32 rxs1_rx0_ctle_adapt_done_o      : 1;
+    u32 rxs1_rx0_adc_ofst_adapt_en_i    : 1;
+    u32 rxs1_rx0_adc_ofst_adapt_done_o  : 1;
+    u32 rxs1_rx0_adc_ofst_adapt_error_o : 1;
+    u32 rxs1_rx0_adc_gain_adapt_en_i    : 1;
+    u32 rxs1_rx0_adc_gain_adapt_done_o  : 1;
+    u32 rxs1_rx0_adc_gain_adapt_error_o : 1;
+    u32 rxs1_rx0_adc_intl_adapt_en_i    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS1_OVRDVAL_1;
+//-----MACRO defines for Register:E56G__PMD_RXS1_OVRDVAL_1
+#define E56G__PMD_RXS1_OVRDVAL_1_ADDR                 (E56G__BASEADDR+0x1570)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS2_OVRDVAL_1
+typedef union {
+  struct {
+    u32 rxs2_rx0_fe_ofst_cal_error_o    : 1;
+    u32 rxs2_rx0_fom_en_i               : 1;
+    u32 rxs2_rx0_idle_detect_en_i       : 1;
+    u32 rxs2_rx0_idle_o                 : 1;
+    u32 rxs2_rx0_txffe_train_en_i       : 1;
+    u32 rxs2_rx0_txffe_train_enack_o    : 1;
+    u32 rxs2_rx0_txffe_train_done_o     : 1;
+    u32 rxs2_rx0_vga_train_en_i         : 1;
+    u32 rxs2_rx0_vga_train_done_o       : 1;
+    u32 rxs2_rx0_ctle_train_en_i        : 1;
+    u32 rxs2_rx0_ctle_train_done_o      : 1;
+    u32 rxs2_rx0_cdr_en_i               : 1;
+    u32 rxs2_rx0_cdr_rdy_o              : 1;
+    u32 rxs2_rx0_ffe_train_en_i         : 1;
+    u32 rxs2_rx0_ffe_train_done_o       : 1;
+    u32 rxs2_rx0_mmpd_en_i              : 1;
+    u32 rxs2_rx0_adc_intl_cal_en_i      : 1;
+    u32 rxs2_rx0_adc_intl_cal_done_o    : 1;
+    u32 rxs2_rx0_adc_intl_cal_error_o   : 1;
+    u32 rxs2_rx0_dfe_train_en_i         : 1;
+    u32 rxs2_rx0_dfe_train_done_o       : 1;
+    u32 rxs2_rx0_vga_adapt_en_i         : 1;
+    u32 rxs2_rx0_vga_adapt_done_o       : 1;
+    u32 rxs2_rx0_ctle_adapt_en_i        : 1;
+    u32 rxs2_rx0_ctle_adapt_done_o      : 1;
+    u32 rxs2_rx0_adc_ofst_adapt_en_i    : 1;
+    u32 rxs2_rx0_adc_ofst_adapt_done_o  : 1;
+    u32 rxs2_rx0_adc_ofst_adapt_error_o : 1;
+    u32 rxs2_rx0_adc_gain_adapt_en_i    : 1;
+    u32 rxs2_rx0_adc_gain_adapt_done_o  : 1;
+    u32 rxs2_rx0_adc_gain_adapt_error_o : 1;
+    u32 rxs2_rx0_adc_intl_adapt_en_i    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS2_OVRDVAL_1;
+//-----MACRO defines for Register:E56G__PMD_RXS2_OVRDVAL_1
+#define E56G__PMD_RXS2_OVRDVAL_1_ADDR                 (E56G__BASEADDR+0x159c)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS3_OVRDVAL_1
+typedef union {
+  struct {
+    u32 rxs3_rx0_fe_ofst_cal_error_o    : 1;
+    u32 rxs3_rx0_fom_en_i               : 1;
+    u32 rxs3_rx0_idle_detect_en_i       : 1;
+    u32 rxs3_rx0_idle_o                 : 1;
+    u32 rxs3_rx0_txffe_train_en_i       : 1;
+    u32 rxs3_rx0_txffe_train_enack_o    : 1;
+    u32 rxs3_rx0_txffe_train_done_o     : 1;
+    u32 rxs3_rx0_vga_train_en_i         : 1;
+    u32 rxs3_rx0_vga_train_done_o       : 1;
+    u32 rxs3_rx0_ctle_train_en_i        : 1;
+    u32 rxs3_rx0_ctle_train_done_o      : 1;
+    u32 rxs3_rx0_cdr_en_i               : 1;
+    u32 rxs3_rx0_cdr_rdy_o              : 1;
+    u32 rxs3_rx0_ffe_train_en_i         : 1;
+    u32 rxs3_rx0_ffe_train_done_o       : 1;
+    u32 rxs3_rx0_mmpd_en_i              : 1;
+    u32 rxs3_rx0_adc_intl_cal_en_i      : 1;
+    u32 rxs3_rx0_adc_intl_cal_done_o    : 1;
+    u32 rxs3_rx0_adc_intl_cal_error_o   : 1;
+    u32 rxs3_rx0_dfe_train_en_i         : 1;
+    u32 rxs3_rx0_dfe_train_done_o       : 1;
+    u32 rxs3_rx0_vga_adapt_en_i         : 1;
+    u32 rxs3_rx0_vga_adapt_done_o       : 1;
+    u32 rxs3_rx0_ctle_adapt_en_i        : 1;
+    u32 rxs3_rx0_ctle_adapt_done_o      : 1;
+    u32 rxs3_rx0_adc_ofst_adapt_en_i    : 1;
+    u32 rxs3_rx0_adc_ofst_adapt_done_o  : 1;
+    u32 rxs3_rx0_adc_ofst_adapt_error_o : 1;
+    u32 rxs3_rx0_adc_gain_adapt_en_i    : 1;
+    u32 rxs3_rx0_adc_gain_adapt_done_o  : 1;
+    u32 rxs3_rx0_adc_gain_adapt_error_o : 1;
+    u32 rxs3_rx0_adc_intl_adapt_en_i    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS3_OVRDVAL_1;
+//-----MACRO defines for Register:E56G__PMD_RXS3_OVRDVAL_1
+#define E56G__PMD_RXS3_OVRDVAL_1_ADDR                 (E56G__BASEADDR+0x15c8)
+
+//-----Access structure typedef for Register:E56G__PMD_CTRL_FSM_RX_STAT_0
+typedef union {
+	struct {
+		u32 ctrl_fsm_rx0_st : 6;
+		u32 rsvd0 : 2;
+		u32 ctrl_fsm_rx1_st : 6;
+		u32 rsvd1 : 2;
+		u32 ctrl_fsm_rx2_st : 6;
+		u32 rsvd2 : 2;
+		u32 ctrl_fsm_rx3_st : 6;
+		u32 rsvd3 : 2;
+	};
+	u32 reg;
+} E56G__PMD_CTRL_FSM_RX_STAT_0;
+//-----MACRO defines for Register:E56G__PMD_CTRL_FSM_RX_STAT_0
+#define E56G__PMD_CTRL_FSM_RX_STAT_0_ADDR             (E56G__BASEADDR+0x14fc)
+
+typedef union {
+	struct {
+		u32 ana_en_rterm_i : 1;
+		u32 ana_en_bias_i : 1;
+		u32 ana_en_ldo_i : 1;
+		u32 ana_rstn_i : 1;
+		u32 ana_en_blwc_i : 1;
+		u32 ana_en_acc_amp_i : 1;
+		u32 ana_en_acc_dac_i : 1;
+		u32 ana_en_afe_offset_cal_i : 1;
+		u32 ana_clk_offsetcal_i : 1;
+		u32 ana_acc_os_comp_o : 1;
+		u32 ana_en_ctle_i : 1;
+		u32 ana_ctle_bypass_i : 1;
+		u32 ana_en_ctlecdr_i : 1;
+		u32 ana_cdr_ctle_boost_i : 1;
+		u32 ana_en_vga_i : 1;
+		u32 ana_en_bbcdr_vco_i : 1;
+		u32 ana_bbcdr_vcofilt_byp_i : 1;
+		u32 ana_en_bbcdr_i : 1;
+		u32 ana_en_bbcdr_clk_i : 1;
+		u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_ping_i : 1;
+		u32 ana_bbcdr_clrz_elv_cnt_pong_i : 1;
+		u32 ana_bbcdr_clrz_cnt_sync_i : 1;
+		u32 ana_bbcdr_en_elv_cnt_rd_i : 1;
+		u32 ana_bbcdr_elv_cnt_ping_0_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_90_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_180_o : 1;
+		u32 ana_bbcdr_elv_cnt_ping_270_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_0_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_90_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_180_o : 1;
+		u32 ana_bbcdr_elv_cnt_pong_270_o : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_0;
+#define E56G__RXS0_ANA_OVRDVAL_0_ADDR                   (E56G__BASEADDR+0xa0)
+
+//-----Access structure typedef for Register:E56G__RXS1_ANA_OVRDVAL_0
+typedef union {
+  struct {
+    u32 ana_en_rterm_i                     : 1;
+    u32 ana_en_bias_i                      : 1;
+    u32 ana_en_ldo_i                       : 1;
+    u32 ana_rstn_i                         : 1;
+    u32 ana_en_blwc_i                      : 1;
+    u32 ana_en_acc_amp_i                   : 1;
+    u32 ana_en_acc_dac_i                   : 1;
+    u32 ana_en_afe_offset_cal_i            : 1;
+    u32 ana_clk_offsetcal_i                : 1;
+    u32 ana_acc_os_comp_o                  : 1;
+    u32 ana_en_ctle_i                      : 1;
+    u32 ana_ctle_bypass_i                  : 1;
+    u32 ana_en_ctlecdr_i                   : 1;
+    u32 ana_cdr_ctle_boost_i               : 1;
+    u32 ana_en_vga_i                       : 1;
+    u32 ana_en_bbcdr_vco_i                 : 1;
+    u32 ana_bbcdr_vcofilt_byp_i            : 1;
+    u32 ana_en_bbcdr_i                     : 1;
+    u32 ana_en_bbcdr_clk_i                 : 1;
+    u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+    u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+    u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+    u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+  };
+  u32 reg;
+} E56G__RXS1_ANA_OVRDVAL_0;
+//-----MACRO defines for Register:E56G__RXS1_ANA_OVRDVAL_0
+#define E56G__RXS1_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR+0x2a0)
+
+//-----Access structure typedef for Register:E56G__RXS2_ANA_OVRDVAL_0
+typedef union {
+  struct {
+    u32 ana_en_rterm_i                     : 1;
+    u32 ana_en_bias_i                      : 1;
+    u32 ana_en_ldo_i                       : 1;
+    u32 ana_rstn_i                         : 1;
+    u32 ana_en_blwc_i                      : 1;
+    u32 ana_en_acc_amp_i                   : 1;
+    u32 ana_en_acc_dac_i                   : 1;
+    u32 ana_en_afe_offset_cal_i            : 1;
+    u32 ana_clk_offsetcal_i                : 1;
+    u32 ana_acc_os_comp_o                  : 1;
+    u32 ana_en_ctle_i                      : 1;
+    u32 ana_ctle_bypass_i                  : 1;
+    u32 ana_en_ctlecdr_i                   : 1;
+    u32 ana_cdr_ctle_boost_i               : 1;
+    u32 ana_en_vga_i                       : 1;
+    u32 ana_en_bbcdr_vco_i                 : 1;
+    u32 ana_bbcdr_vcofilt_byp_i            : 1;
+    u32 ana_en_bbcdr_i                     : 1;
+    u32 ana_en_bbcdr_clk_i                 : 1;
+    u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+    u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+    u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+    u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+  };
+  u32 reg;
+} E56G__RXS2_ANA_OVRDVAL_0;
+//-----MACRO defines for Register:E56G__RXS2_ANA_OVRDVAL_0
+#define E56G__RXS2_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR+0x4a0)
+
+//-----Access structure typedef for Register:E56G__RXS3_ANA_OVRDVAL_0
+typedef union {
+  struct {
+    u32 ana_en_rterm_i                     : 1;
+    u32 ana_en_bias_i                      : 1;
+    u32 ana_en_ldo_i                       : 1;
+    u32 ana_rstn_i                         : 1;
+    u32 ana_en_blwc_i                      : 1;
+    u32 ana_en_acc_amp_i                   : 1;
+    u32 ana_en_acc_dac_i                   : 1;
+    u32 ana_en_afe_offset_cal_i            : 1;
+    u32 ana_clk_offsetcal_i                : 1;
+    u32 ana_acc_os_comp_o                  : 1;
+    u32 ana_en_ctle_i                      : 1;
+    u32 ana_ctle_bypass_i                  : 1;
+    u32 ana_en_ctlecdr_i                   : 1;
+    u32 ana_cdr_ctle_boost_i               : 1;
+    u32 ana_en_vga_i                       : 1;
+    u32 ana_en_bbcdr_vco_i                 : 1;
+    u32 ana_bbcdr_vcofilt_byp_i            : 1;
+    u32 ana_en_bbcdr_i                     : 1;
+    u32 ana_en_bbcdr_clk_i                 : 1;
+    u32 ana_bbcdr_en_elv_cnt_ping0_pong1_i : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_ping_i      : 1;
+    u32 ana_bbcdr_clrz_elv_cnt_pong_i      : 1;
+    u32 ana_bbcdr_clrz_cnt_sync_i          : 1;
+    u32 ana_bbcdr_en_elv_cnt_rd_i          : 1;
+    u32 ana_bbcdr_elv_cnt_ping_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_ping_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_ping_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_ping_270_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_0_o         : 1;
+    u32 ana_bbcdr_elv_cnt_pong_90_o        : 1;
+    u32 ana_bbcdr_elv_cnt_pong_180_o       : 1;
+    u32 ana_bbcdr_elv_cnt_pong_270_o       : 1;
+  };
+  u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_0;
+//-----MACRO defines for Register:E56G__RXS3_ANA_OVRDVAL_0
+#define E56G__RXS3_ANA_OVRDVAL_0_ADDR                  (E56G__BASEADDR+0x6a0)
+
+//-----Access structure typedef for Register:E56G__RXS0_ANA_OVRDEN_0
+typedef union {
+	struct {
+		u32 ovrd_en_ana_en_rterm_i : 1;
+		u32 ovrd_en_ana_trim_rterm_i : 1;
+		u32 ovrd_en_ana_en_bias_i : 1;
+		u32 ovrd_en_ana_test_bias_i : 1;
+		u32 ovrd_en_ana_en_ldo_i : 1;
+		u32 ovrd_en_ana_test_ldo_i : 1;
+		u32 ovrd_en_ana_rstn_i : 1;
+		u32 ovrd_en_ana_en_blwc_i : 1;
+		u32 ovrd_en_ana_en_acc_amp_i : 1;
+		u32 ovrd_en_ana_en_acc_dac_i : 1;
+		u32 ovrd_en_ana_en_afe_offset_cal_i : 1;
+		u32 ovrd_en_ana_clk_offsetcal_i : 1;
+		u32 ovrd_en_ana_acc_os_code_i : 1;
+		u32 ovrd_en_ana_acc_os_comp_o : 1;
+		u32 ovrd_en_ana_test_acc_i : 1;
+		u32 ovrd_en_ana_en_ctle_i : 1;
+		u32 ovrd_en_ana_ctle_bypass_i : 1;
+		u32 ovrd_en_ana_ctle_cz_cstm_i : 1;
+		u32 ovrd_en_ana_ctle_cload_cstm_i : 1;
+		u32 ovrd_en_ana_test_ctle_i : 1;
+		u32 ovrd_en_ana_lfeq_ctrl_cstm_i : 1;
+		u32 ovrd_en_ana_en_ctlecdr_i : 1;
+		u32 ovrd_en_ana_cdr_ctle_boost_i : 1;
+		u32 ovrd_en_ana_test_ctlecdr_i : 1;
+		u32 ovrd_en_ana_en_vga_i : 1;
+		u32 ovrd_en_ana_vga_gain_cstm_i : 1;
+		u32 ovrd_en_ana_vga_cload_in_cstm_i : 1;
+		u32 ovrd_en_ana_test_vga_i : 1;
+		u32 ovrd_en_ana_en_bbcdr_vco_i : 1;
+		u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+		u32 ovrd_en_ana_sel_vga_gain_byp_i : 1;
+		u32 ovrd_en_ana_vga2_gain_cstm_i : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDEN_0;
+//-----MACRO defines for Register:E56G__RXS0_ANA_OVRDEN_0
+#define E56G__RXS0_ANA_OVRDEN_0_ADDR                    (E56G__BASEADDR+0x8c)
+
+//-----Access structure typedef for Register:E56G__RXS1_ANA_OVRDEN_0
+typedef union {
+  struct {
+    u32 ovrd_en_ana_en_rterm_i            : 1;
+    u32 ovrd_en_ana_trim_rterm_i          : 1;
+    u32 ovrd_en_ana_en_bias_i             : 1;
+    u32 ovrd_en_ana_test_bias_i           : 1;
+    u32 ovrd_en_ana_en_ldo_i              : 1;
+    u32 ovrd_en_ana_test_ldo_i            : 1;
+    u32 ovrd_en_ana_rstn_i                : 1;
+    u32 ovrd_en_ana_en_blwc_i             : 1;
+    u32 ovrd_en_ana_en_acc_amp_i          : 1;
+    u32 ovrd_en_ana_en_acc_dac_i          : 1;
+    u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+    u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+    u32 ovrd_en_ana_acc_os_code_i         : 1;
+    u32 ovrd_en_ana_acc_os_comp_o         : 1;
+    u32 ovrd_en_ana_test_acc_i            : 1;
+    u32 ovrd_en_ana_en_ctle_i             : 1;
+    u32 ovrd_en_ana_ctle_bypass_i         : 1;
+    u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+    u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+    u32 ovrd_en_ana_test_ctle_i           : 1;
+    u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+    u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+    u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+    u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+    u32 ovrd_en_ana_en_vga_i              : 1;
+    u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+    u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+    u32 ovrd_en_ana_test_vga_i            : 1;
+    u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+    u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+    u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+    u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+  };
+  u32 reg;
+} E56G__RXS1_ANA_OVRDEN_0;
+//-----MACRO defines for Register:E56G__RXS1_ANA_OVRDEN_0
+#define E56G__RXS1_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR+0x28c)
+
+//-----Access structure typedef for Register:E56G__RXS2_ANA_OVRDEN_0
+typedef union {
+  struct {
+    u32 ovrd_en_ana_en_rterm_i            : 1;
+    u32 ovrd_en_ana_trim_rterm_i          : 1;
+    u32 ovrd_en_ana_en_bias_i             : 1;
+    u32 ovrd_en_ana_test_bias_i           : 1;
+    u32 ovrd_en_ana_en_ldo_i              : 1;
+    u32 ovrd_en_ana_test_ldo_i            : 1;
+    u32 ovrd_en_ana_rstn_i                : 1;
+    u32 ovrd_en_ana_en_blwc_i             : 1;
+    u32 ovrd_en_ana_en_acc_amp_i          : 1;
+    u32 ovrd_en_ana_en_acc_dac_i          : 1;
+    u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+    u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+    u32 ovrd_en_ana_acc_os_code_i         : 1;
+    u32 ovrd_en_ana_acc_os_comp_o         : 1;
+    u32 ovrd_en_ana_test_acc_i            : 1;
+    u32 ovrd_en_ana_en_ctle_i             : 1;
+    u32 ovrd_en_ana_ctle_bypass_i         : 1;
+    u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+    u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+    u32 ovrd_en_ana_test_ctle_i           : 1;
+    u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+    u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+    u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+    u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+    u32 ovrd_en_ana_en_vga_i              : 1;
+    u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+    u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+    u32 ovrd_en_ana_test_vga_i            : 1;
+    u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+    u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+    u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+    u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+  };
+  u32 reg;
+} E56G__RXS2_ANA_OVRDEN_0;
+//-----MACRO defines for Register:E56G__RXS2_ANA_OVRDEN_0
+#define E56G__RXS2_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR+0x48c)
+
+//-----Access structure typedef for Register:E56G__RXS3_ANA_OVRDEN_0
+typedef union {
+  struct {
+    u32 ovrd_en_ana_en_rterm_i            : 1;
+    u32 ovrd_en_ana_trim_rterm_i          : 1;
+    u32 ovrd_en_ana_en_bias_i             : 1;
+    u32 ovrd_en_ana_test_bias_i           : 1;
+    u32 ovrd_en_ana_en_ldo_i              : 1;
+    u32 ovrd_en_ana_test_ldo_i            : 1;
+    u32 ovrd_en_ana_rstn_i                : 1;
+    u32 ovrd_en_ana_en_blwc_i             : 1;
+    u32 ovrd_en_ana_en_acc_amp_i          : 1;
+    u32 ovrd_en_ana_en_acc_dac_i          : 1;
+    u32 ovrd_en_ana_en_afe_offset_cal_i   : 1;
+    u32 ovrd_en_ana_clk_offsetcal_i       : 1;
+    u32 ovrd_en_ana_acc_os_code_i         : 1;
+    u32 ovrd_en_ana_acc_os_comp_o         : 1;
+    u32 ovrd_en_ana_test_acc_i            : 1;
+    u32 ovrd_en_ana_en_ctle_i             : 1;
+    u32 ovrd_en_ana_ctle_bypass_i         : 1;
+    u32 ovrd_en_ana_ctle_cz_cstm_i        : 1;
+    u32 ovrd_en_ana_ctle_cload_cstm_i     : 1;
+    u32 ovrd_en_ana_test_ctle_i           : 1;
+    u32 ovrd_en_ana_lfeq_ctrl_cstm_i      : 1;
+    u32 ovrd_en_ana_en_ctlecdr_i          : 1;
+    u32 ovrd_en_ana_cdr_ctle_boost_i      : 1;
+    u32 ovrd_en_ana_test_ctlecdr_i        : 1;
+    u32 ovrd_en_ana_en_vga_i              : 1;
+    u32 ovrd_en_ana_vga_gain_cstm_i       : 1;
+    u32 ovrd_en_ana_vga_cload_in_cstm_i   : 1;
+    u32 ovrd_en_ana_test_vga_i            : 1;
+    u32 ovrd_en_ana_en_bbcdr_vco_i        : 1;
+    u32 ovrd_en_ana_bbcdr_osc_range_sel_i : 1;
+    u32 ovrd_en_ana_sel_vga_gain_byp_i    : 1;
+    u32 ovrd_en_ana_vga2_gain_cstm_i      : 1;
+  };
+  u32 reg;
+} E56G__RXS3_ANA_OVRDEN_0;
+//-----MACRO defines for Register:E56G__RXS3_ANA_OVRDEN_0
+#define E56G__RXS3_ANA_OVRDEN_0_NUM                                         1
+#define E56G__RXS3_ANA_OVRDEN_0_ADDR                   (E56G__BASEADDR+0x68c)
+
+//-----Access structure typedef for Register:E56G__RXS0_ANA_OVRDVAL_3
+typedef union {
+	struct {
+		u32 ana_ctle_cz_cstm_i : 5;
+		u32 rsvd0 : 3;
+		u32 ana_ctle_cload_cstm_i : 5;
+		u32 rsvd1 : 3;
+		u32 ana_test_ctle_i : 2;
+		u32 rsvd2 : 2;
+		u32 ana_lfeq_ctrl_cstm_i : 4;
+		u32 ana_test_ctlecdr_i : 2;
+		u32 rsvd3 : 2;
+		u32 ana_vga_cload_in_cstm_i : 3;
+		u32 rsvd4 : 1;
+	};
+	u32 reg;
+} E56G__RXS0_ANA_OVRDVAL_3;
+//-----MACRO defines for Register:E56G__RXS0_ANA_OVRDVAL_3
+#define E56G__RXS0_ANA_OVRDVAL_3_NUM                                        1
+#define E56G__RXS0_ANA_OVRDVAL_3_ADDR                   (E56G__BASEADDR+0xac)
+
+//-----Access structure typedef for Register:E56G__RXS1_ANA_OVRDVAL_3
+typedef union {
+  struct {
+    u32 ana_ctle_cz_cstm_i      : 5;
+    u32 rsvd0                   : 3;
+    u32 ana_ctle_cload_cstm_i   : 5;
+    u32 rsvd1                   : 3;
+    u32 ana_test_ctle_i         : 2;
+    u32 rsvd2                   : 2;
+    u32 ana_lfeq_ctrl_cstm_i    : 4;
+    u32 ana_test_ctlecdr_i      : 2;
+    u32 rsvd3                   : 2;
+    u32 ana_vga_cload_in_cstm_i : 3;
+    u32 rsvd4                   : 1;
+  };
+  u32 reg;
+} E56G__RXS1_ANA_OVRDVAL_3;
+//-----MACRO defines for Register:E56G__RXS1_ANA_OVRDVAL_3
+#define E56G__RXS1_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR+0x2ac)
+
+//-----Access structure typedef for Register:E56G__RXS2_ANA_OVRDVAL_3
+typedef union {
+  struct {
+    u32 ana_ctle_cz_cstm_i      : 5;
+    u32 rsvd0                   : 3;
+    u32 ana_ctle_cload_cstm_i   : 5;
+    u32 rsvd1                   : 3;
+    u32 ana_test_ctle_i         : 2;
+    u32 rsvd2                   : 2;
+    u32 ana_lfeq_ctrl_cstm_i    : 4;
+    u32 ana_test_ctlecdr_i      : 2;
+    u32 rsvd3                   : 2;
+    u32 ana_vga_cload_in_cstm_i : 3;
+    u32 rsvd4                   : 1;
+  };
+  u32 reg;
+} E56G__RXS2_ANA_OVRDVAL_3;
+//-----MACRO defines for Register:E56G__RXS2_ANA_OVRDVAL_3
+#define E56G__RXS2_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR+0x4ac)
+
+//-----Access structure typedef for Register:E56G__RXS3_ANA_OVRDVAL_3
+typedef union {
+  struct {
+    u32 ana_ctle_cz_cstm_i      : 5;
+    u32 rsvd0                   : 3;
+    u32 ana_ctle_cload_cstm_i   : 5;
+    u32 rsvd1                   : 3;
+    u32 ana_test_ctle_i         : 2;
+    u32 rsvd2                   : 2;
+    u32 ana_lfeq_ctrl_cstm_i    : 4;
+    u32 ana_test_ctlecdr_i      : 2;
+    u32 rsvd3                   : 2;
+    u32 ana_vga_cload_in_cstm_i : 3;
+    u32 rsvd4                   : 1;
+  };
+  u32 reg;
+} E56G__RXS3_ANA_OVRDVAL_3;
+//-----MACRO defines for Register:E56G__RXS3_ANA_OVRDVAL_3
+#define E56G__RXS3_ANA_OVRDVAL_3_ADDR                  (E56G__BASEADDR+0x6ac)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS0_OVRDEN_1
+typedef union {
+	struct {
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_gain_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_fe_ofst_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_fom_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_idle_detect_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_idle_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_coeff_rst_i : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_enack_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_txffe_coeff_change_o : 1;
+		u32 ovrd_en_rxs0_rx0_vga_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_vga_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_cdr_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_cdr_rdy_o : 1;
+		u32 ovrd_en_rxs0_rx0_ffe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ffe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_mmpd_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_adc_intl_cal_error_o : 1;
+		u32 ovrd_en_rxs0_rx0_dfe_train_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_dfe_train_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_vga_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_vga_adapt_done_o : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_adapt_en_i : 1;
+		u32 ovrd_en_rxs0_rx0_ctle_adapt_done_o : 1;
+	};
+	u32 reg;
+} E56G__PMD_RXS0_OVRDEN_1;
+//-----MACRO defines for Register:E56G__PMD_RXS0_OVRDEN_1
+#define E56G__PMD_RXS0_OVRDEN_1_NUM                                         1
+#define E56G__PMD_RXS0_OVRDEN_1_ADDR                  (E56G__BASEADDR+0x1534)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS1_OVRDEN_1
+typedef union {
+  struct {
+    u32 ovrd_en_rxs1_rx0_adc_gain_cal_en_i    : 1;
+    u32 ovrd_en_rxs1_rx0_adc_gain_cal_done_o  : 1;
+    u32 ovrd_en_rxs1_rx0_adc_gain_cal_error_o : 1;
+    u32 ovrd_en_rxs1_rx0_fe_ofst_cal_en_i     : 1;
+    u32 ovrd_en_rxs1_rx0_fe_ofst_cal_done_o   : 1;
+    u32 ovrd_en_rxs1_rx0_fe_ofst_cal_error_o  : 1;
+    u32 ovrd_en_rxs1_rx0_fom_en_i             : 1;
+    u32 ovrd_en_rxs1_rx0_idle_detect_en_i     : 1;
+    u32 ovrd_en_rxs1_rx0_idle_o               : 1;
+    u32 ovrd_en_rxs1_rx0_txffe_train_en_i     : 1;
+    u32 ovrd_en_rxs1_rx0_txffe_coeff_rst_i    : 1;
+    u32 ovrd_en_rxs1_rx0_txffe_train_enack_o  : 1;
+    u32 ovrd_en_rxs1_rx0_txffe_train_done_o   : 1;
+    u32 ovrd_en_rxs1_rx0_txffe_coeff_change_o : 1;
+    u32 ovrd_en_rxs1_rx0_vga_train_en_i       : 1;
+    u32 ovrd_en_rxs1_rx0_vga_train_done_o     : 1;
+    u32 ovrd_en_rxs1_rx0_ctle_train_en_i      : 1;
+    u32 ovrd_en_rxs1_rx0_ctle_train_done_o    : 1;
+    u32 ovrd_en_rxs1_rx0_cdr_en_i             : 1;
+    u32 ovrd_en_rxs1_rx0_cdr_rdy_o            : 1;
+    u32 ovrd_en_rxs1_rx0_ffe_train_en_i       : 1;
+    u32 ovrd_en_rxs1_rx0_ffe_train_done_o     : 1;
+    u32 ovrd_en_rxs1_rx0_mmpd_en_i            : 1;
+    u32 ovrd_en_rxs1_rx0_adc_intl_cal_en_i    : 1;
+    u32 ovrd_en_rxs1_rx0_adc_intl_cal_done_o  : 1;
+    u32 ovrd_en_rxs1_rx0_adc_intl_cal_error_o : 1;
+    u32 ovrd_en_rxs1_rx0_dfe_train_en_i       : 1;
+    u32 ovrd_en_rxs1_rx0_dfe_train_done_o     : 1;
+    u32 ovrd_en_rxs1_rx0_vga_adapt_en_i       : 1;
+    u32 ovrd_en_rxs1_rx0_vga_adapt_done_o     : 1;
+    u32 ovrd_en_rxs1_rx0_ctle_adapt_en_i      : 1;
+    u32 ovrd_en_rxs1_rx0_ctle_adapt_done_o    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS1_OVRDEN_1;
+//-----MACRO defines for Register:E56G__PMD_RXS1_OVRDEN_1
+#define E56G__PMD_RXS1_OVRDEN_1_ADDR                  (E56G__BASEADDR+0x1560)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS2_OVRDEN_1
+typedef union {
+  struct {
+    u32 ovrd_en_rxs2_rx0_adc_gain_cal_en_i    : 1;
+    u32 ovrd_en_rxs2_rx0_adc_gain_cal_done_o  : 1;
+    u32 ovrd_en_rxs2_rx0_adc_gain_cal_error_o : 1;
+    u32 ovrd_en_rxs2_rx0_fe_ofst_cal_en_i     : 1;
+    u32 ovrd_en_rxs2_rx0_fe_ofst_cal_done_o   : 1;
+    u32 ovrd_en_rxs2_rx0_fe_ofst_cal_error_o  : 1;
+    u32 ovrd_en_rxs2_rx0_fom_en_i             : 1;
+    u32 ovrd_en_rxs2_rx0_idle_detect_en_i     : 1;
+    u32 ovrd_en_rxs2_rx0_idle_o               : 1;
+    u32 ovrd_en_rxs2_rx0_txffe_train_en_i     : 1;
+    u32 ovrd_en_rxs2_rx0_txffe_coeff_rst_i    : 1;
+    u32 ovrd_en_rxs2_rx0_txffe_train_enack_o  : 1;
+    u32 ovrd_en_rxs2_rx0_txffe_train_done_o   : 1;
+    u32 ovrd_en_rxs2_rx0_txffe_coeff_change_o : 1;
+    u32 ovrd_en_rxs2_rx0_vga_train_en_i       : 1;
+    u32 ovrd_en_rxs2_rx0_vga_train_done_o     : 1;
+    u32 ovrd_en_rxs2_rx0_ctle_train_en_i      : 1;
+    u32 ovrd_en_rxs2_rx0_ctle_train_done_o    : 1;
+    u32 ovrd_en_rxs2_rx0_cdr_en_i             : 1;
+    u32 ovrd_en_rxs2_rx0_cdr_rdy_o            : 1;
+    u32 ovrd_en_rxs2_rx0_ffe_train_en_i       : 1;
+    u32 ovrd_en_rxs2_rx0_ffe_train_done_o     : 1;
+    u32 ovrd_en_rxs2_rx0_mmpd_en_i            : 1;
+    u32 ovrd_en_rxs2_rx0_adc_intl_cal_en_i    : 1;
+    u32 ovrd_en_rxs2_rx0_adc_intl_cal_done_o  : 1;
+    u32 ovrd_en_rxs2_rx0_adc_intl_cal_error_o : 1;
+    u32 ovrd_en_rxs2_rx0_dfe_train_en_i       : 1;
+    u32 ovrd_en_rxs2_rx0_dfe_train_done_o     : 1;
+    u32 ovrd_en_rxs2_rx0_vga_adapt_en_i       : 1;
+    u32 ovrd_en_rxs2_rx0_vga_adapt_done_o     : 1;
+    u32 ovrd_en_rxs2_rx0_ctle_adapt_en_i      : 1;
+    u32 ovrd_en_rxs2_rx0_ctle_adapt_done_o    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS2_OVRDEN_1;
+//-----MACRO defines for Register:E56G__PMD_RXS2_OVRDEN_1
+#define E56G__PMD_RXS2_OVRDEN_1_ADDR                  (E56G__BASEADDR+0x158c)
+
+//-----Access structure typedef for Register:E56G__PMD_RXS3_OVRDEN_1
+typedef union {
+  struct {
+    u32 ovrd_en_rxs3_rx0_adc_gain_cal_en_i    : 1;
+    u32 ovrd_en_rxs3_rx0_adc_gain_cal_done_o  : 1;
+    u32 ovrd_en_rxs3_rx0_adc_gain_cal_error_o : 1;
+    u32 ovrd_en_rxs3_rx0_fe_ofst_cal_en_i     : 1;
+    u32 ovrd_en_rxs3_rx0_fe_ofst_cal_done_o   : 1;
+    u32 ovrd_en_rxs3_rx0_fe_ofst_cal_error_o  : 1;
+    u32 ovrd_en_rxs3_rx0_fom_en_i             : 1;
+    u32 ovrd_en_rxs3_rx0_idle_detect_en_i     : 1;
+    u32 ovrd_en_rxs3_rx0_idle_o               : 1;
+    u32 ovrd_en_rxs3_rx0_txffe_train_en_i     : 1;
+    u32 ovrd_en_rxs3_rx0_txffe_coeff_rst_i    : 1;
+    u32 ovrd_en_rxs3_rx0_txffe_train_enack_o  : 1;
+    u32 ovrd_en_rxs3_rx0_txffe_train_done_o   : 1;
+    u32 ovrd_en_rxs3_rx0_txffe_coeff_change_o : 1;
+    u32 ovrd_en_rxs3_rx0_vga_train_en_i       : 1;
+    u32 ovrd_en_rxs3_rx0_vga_train_done_o     : 1;
+    u32 ovrd_en_rxs3_rx0_ctle_train_en_i      : 1;
+    u32 ovrd_en_rxs3_rx0_ctle_train_done_o    : 1;
+    u32 ovrd_en_rxs3_rx0_cdr_en_i             : 1;
+    u32 ovrd_en_rxs3_rx0_cdr_rdy_o            : 1;
+    u32 ovrd_en_rxs3_rx0_ffe_train_en_i       : 1;
+    u32 ovrd_en_rxs3_rx0_ffe_train_done_o     : 1;
+    u32 ovrd_en_rxs3_rx0_mmpd_en_i            : 1;
+    u32 ovrd_en_rxs3_rx0_adc_intl_cal_en_i    : 1;
+    u32 ovrd_en_rxs3_rx0_adc_intl_cal_done_o  : 1;
+    u32 ovrd_en_rxs3_rx0_adc_intl_cal_error_o : 1;
+    u32 ovrd_en_rxs3_rx0_dfe_train_en_i       : 1;
+    u32 ovrd_en_rxs3_rx0_dfe_train_done_o     : 1;
+    u32 ovrd_en_rxs3_rx0_vga_adapt_en_i       : 1;
+    u32 ovrd_en_rxs3_rx0_vga_adapt_done_o     : 1;
+    u32 ovrd_en_rxs3_rx0_ctle_adapt_en_i      : 1;
+    u32 ovrd_en_rxs3_rx0_ctle_adapt_done_o    : 1;
+  };
+  u32 reg;
+} E56G__PMD_RXS3_OVRDEN_1;
+//-----MACRO defines for Register:E56G__PMD_RXS3_OVRDEN_1
+#define E56G__PMD_RXS3_OVRDEN_1_ADDR                  (E56G__BASEADDR+0x15b8)
+
+#define E56G__RXS0_FOM_18__ADDR                       (E56G__BASEADDR+0x1f8)
+#define E56G__RXS0_FOM_18__DFE_COEFFL_HINT__MSB                             11
+#define E56G__RXS0_FOM_18__DFE_COEFFL_HINT__LSB                              0
+#define E56G__RXS0_FOM_18__DFE_COEFFH_HINT__MSB                             23
+#define E56G__RXS0_FOM_18__DFE_COEFFH_HINT__LSB                             12
+#define E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__MSB                         25
+#define E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__LSB                         25
+
+#define DEFAULT_TEMP                            40
+#define HIGH_TEMP                               70
+
+#define E56PHY_RX_RDY_ST    0x1B
+
+#define S10G_CMVAR_RANGE_H          0x3
+#define S10G_CMVAR_RANGE_L          0x2
+#define S25G_CMVAR_RANGE_H          0x1
+#define S25G_CMVAR_RANGE_L          0x0
+
+#define S25G_CMVAR_RANGE_H          0x1
+#define S25G_CMVAR_RANGE_L          0x0
+#define S25G_CMVAR_SEC_LOW_TH       0x1A
+#define S25G_CMVAR_SEC_HIGH_TH      0x1D
+#define S25G_CMVAR_UFINE_MAX        0x2
+#define S25G_CMVAR_FINE_MAX         0x7
+#define S25G_CMVAR_COARSE_MAX       0xF
+#define S25G_CMVAR_UFINE_UMAX_WRAP  0x0
+#define S25G_CMVAR_UFINE_FMAX_WRAP  0x0
+#define S25G_CMVAR_FINE_FMAX_WRAP   0x2
+#define S25G_CMVAR_UFINE_MIN        0x0
+#define S25G_CMVAR_FINE_MIN         0x0
+#define S25G_CMVAR_COARSE_MIN       0x1
+#define S25G_CMVAR_UFINE_UMIN_WRAP  0x2
+#define S25G_CMVAR_UFINE_FMIN_WRAP  0x2
+#define S25G_CMVAR_FINE_FMIN_WRAP   0x5
+
+#define S10G_CMVAR_RANGE_H          0x3
+#define S10G_CMVAR_RANGE_L          0x2
+#define S10G_CMVAR_SEC_LOW_TH       0x1A
+#define S10G_CMVAR_SEC_HIGH_TH      0x1D
+#define S10G_CMVAR_UFINE_MAX        0x7
+#define S10G_CMVAR_FINE_MAX         0x7
+#define S10G_CMVAR_COARSE_MAX       0xF
+#define S10G_CMVAR_UFINE_UMAX_WRAP  0x6
+#define S10G_CMVAR_UFINE_FMAX_WRAP  0x7
+#define S10G_CMVAR_FINE_FMAX_WRAP   0x1
+#define S10G_CMVAR_UFINE_MIN        0x0
+#define S10G_CMVAR_FINE_MIN         0x0
+#define S10G_CMVAR_COARSE_MIN       0x1
+#define S10G_CMVAR_UFINE_UMIN_WRAP  0x2
+#define S10G_CMVAR_UFINE_FMIN_WRAP  0x2
+#define S10G_CMVAR_FINE_FMIN_WRAP   0x5
+
+#define S10G_TX_FFE_CFG_MAIN        0x24242424
+#define S10G_TX_FFE_CFG_PRE1        0x0
+#define S10G_TX_FFE_CFG_PRE2        0x0
+#define S10G_TX_FFE_CFG_POST        0x0
+#define S25G_TX_FFE_CFG_MAIN        49
+#define S25G_TX_FFE_CFG_PRE1        4
+#define S25G_TX_FFE_CFG_PRE2        1
+#define S25G_TX_FFE_CFG_POST        9
+
+#define S25G_TX_FFE_CFG_DAC_MAIN            0x2a2a2a2a
+#define S25G_TX_FFE_CFG_DAC_PRE1            0x03
+#define S25G_TX_FFE_CFG_DAC_PRE2            0x0
+#define S25G_TX_FFE_CFG_DAC_POST            0x11
+
+#define BYPASS_CTLE_TAG        0x0
+
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT2      0x0
+#define S10G_PHY_RX_CTLE_TAPWT_WEIGHT3      0x0
+#define S10G_PHY_RX_CTLE_TAP_FRACP1      0x18
+#define S10G_PHY_RX_CTLE_TAP_FRACP2      0x0
+#define S10G_PHY_RX_CTLE_TAP_FRACP3      0x0
+
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT1      0x1
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT2      0x0
+#define S25G_PHY_RX_CTLE_TAPWT_WEIGHT3      0x0
+#define S25G_PHY_RX_CTLE_TAP_FRACP1      0x18
+#define S25G_PHY_RX_CTLE_TAP_FRACP2      0x0
+#define S25G_PHY_RX_CTLE_TAP_FRACP3      0x0
+
+#define TXGBE_E56_PHY_LINK_UP            0x4
+
+void set_fields_e56(unsigned int *src_data, unsigned int bit_high,
+		    unsigned int bit_low, unsigned int set_value);
+int txgbe_e56_rx_rd_second_code_40g(struct txgbe_hw *hw, int *SECOND_CODE, int lane);
+int txgbe_e56_rx_rd_second_code(struct txgbe_hw *hw, int *SECOND_CODE);
+u32 txgbe_e56_cfg_40g(struct txgbe_hw *hw);
+u32 txgbe_e56_cfg_25g(struct txgbe_hw *hw);
+u32 txgbe_e56_cfg_10g(struct txgbe_hw *hw);
+int txgbe_temp_track_seq(struct txgbe_hw *hw, u32 speed);
+int txgbe_e56_get_temp(struct txgbe_hw *hw, int *pTempData);
+int txgbe_set_link_to_amlite(struct txgbe_hw *hw, u32 speed);
+int txgbe_e56_reconfig_rx(struct txgbe_hw *hw, u32 speed);
+s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
+				bool *link_up);
+s32 txgbe_e56_fec_set(struct txgbe_hw *hw);
+s32 txgbe_e56_fec_polling(struct txgbe_hw *hw, bool *link_up);
+
+#endif /* _TXGBE_E56_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.c b/drivers/net/txgbe/base/txgbe_e56_bp.c
new file mode 100644
index 0000000000..e80db9ca0d
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.c
@@ -0,0 +1,2238 @@
+#include "txgbe_e56.h"
+#include "txgbe_hw.h"
+#include "txgbe_osdep.h"
+#include "txgbe_phy.h"
+#include "txgbe_e56_bp.h"
+#include "txgbe.h"
+#include "../txgbe_logs.h"
+
+#define CL74_KRTR_TRAINNING_TIMEOUT     2000
+#define AN74_TRAINNING_MODE             1
+
+typedef union {
+	struct {
+		u32 tx0_cursor_factor : 7;
+		u32 rsvd0 : 1;
+		u32 tx1_cursor_factor : 7;
+		u32 rsvd1 : 1;
+		u32 tx2_cursor_factor : 7;
+		u32 rsvd2 : 1;
+		u32 tx3_cursor_factor : 7;
+		u32 rsvd3 : 1;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_1;
+
+#define E56G__PMD_TX_FFE_CFG_1_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_1_ADDR                   (E56G__BASEADDR+0x141c)
+#define E56G__PMD_TX_FFE_CFG_1_PTR ((volatile E56G__PMD_TX_FFE_CFG_1*)(E56G__PMD_TX_FFE_CFG_1_ADDR))
+#define E56G__PMD_TX_FFE_CFG_1_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_1_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_1_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_1_READ_MSB                                    30
+#define E56G__PMD_TX_FFE_CFG_1_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_1_WRITE_MSB                                   30
+#define E56G__PMD_TX_FFE_CFG_1_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_1_RESET_VALUE                         0x3f3f3f3f
+
+typedef union {
+	struct {
+		u32 tx0_precursor1_factor : 6;
+		u32 rsvd0 : 2;
+		u32 tx1_precursor1_factor : 6;
+		u32 rsvd1 : 2;
+		u32 tx2_precursor1_factor : 6;
+		u32 rsvd2 : 2;
+		u32 tx3_precursor1_factor : 6;
+		u32 rsvd3 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_2;
+
+#define E56G__PMD_TX_FFE_CFG_2_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_2_ADDR                   (E56G__BASEADDR+0x1420)
+#define E56G__PMD_TX_FFE_CFG_2_PTR ((volatile E56G__PMD_TX_FFE_CFG_2*)(E56G__PMD_TX_FFE_CFG_2_ADDR))
+#define E56G__PMD_TX_FFE_CFG_2_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_2_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_2_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_2_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_2_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_2_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_2_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_2_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 tx0_precursor2_factor : 6;
+		u32 rsvd0 : 2;
+		u32 tx1_precursor2_factor : 6;
+		u32 rsvd1 : 2;
+		u32 tx2_precursor2_factor : 6;
+		u32 rsvd2 : 2;
+		u32 tx3_precursor2_factor : 6;
+		u32 rsvd3 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_3;
+#define E56G__PMD_TX_FFE_CFG_3_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_3_ADDR                   (E56G__BASEADDR+0x1424)
+#define E56G__PMD_TX_FFE_CFG_3_PTR ((volatile E56G__PMD_TX_FFE_CFG_3*)(E56G__PMD_TX_FFE_CFG_3_ADDR))
+#define E56G__PMD_TX_FFE_CFG_3_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_3_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_3_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_3_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_3_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_3_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_3_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_3_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 tx0_postcursor_factor : 6;
+		u32 rsvd0 : 2;
+		u32 tx1_postcursor_factor : 6;
+		u32 rsvd1 : 2;
+		u32 tx2_postcursor_factor : 6;
+		u32 rsvd2 : 2;
+		u32 tx3_postcursor_factor : 6;
+		u32 rsvd3 : 2;
+	};
+	u32 reg;
+} E56G__PMD_TX_FFE_CFG_4;
+#define E56G__PMD_TX_FFE_CFG_4_NUM                                          1
+#define E56G__PMD_TX_FFE_CFG_4_ADDR                   (E56G__BASEADDR+0x1428)
+#define E56G__PMD_TX_FFE_CFG_4_PTR ((volatile E56G__PMD_TX_FFE_CFG_4*)(E56G__PMD_TX_FFE_CFG_4_ADDR))
+#define E56G__PMD_TX_FFE_CFG_4_STRIDE                                       4
+#define E56G__PMD_TX_FFE_CFG_4_SIZE                                        32
+#define E56G__PMD_TX_FFE_CFG_4_ACC_SIZE                                    32
+#define E56G__PMD_TX_FFE_CFG_4_READ_MSB                                    29
+#define E56G__PMD_TX_FFE_CFG_4_READ_LSB                                     0
+#define E56G__PMD_TX_FFE_CFG_4_WRITE_MSB                                   29
+#define E56G__PMD_TX_FFE_CFG_4_WRITE_LSB                                    0
+#define E56G__PMD_TX_FFE_CFG_4_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_vco_swing_ctrl_i : 4;
+		u32 ana_lcpll_lf_lpf_setcode_calib_i : 5;
+		u32 rsvd0 : 3;
+		u32 ana_lcpll_lf_vco_coarse_bin_i : 5;
+		u32 rsvd1 : 3;
+		u32 ana_lcpll_lf_vco_fine_therm_i : 8;
+		u32 ana_lcpll_lf_clkout_fb_ctrl_i : 2;
+		u32 rsvd2 : 2;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDVAL_7;
+#define E56G__CMS_ANA_OVRDVAL_7_NUM                                         1
+#define E56G__CMS_ANA_OVRDVAL_7_ADDR                   (E56G__BASEADDR+0xccc)
+#define E56G__CMS_ANA_OVRDVAL_7_PTR ((volatile E56G__CMS_ANA_OVRDVAL_7*)(E56G__CMS_ANA_OVRDVAL_7_ADDR))
+#define E56G__CMS_ANA_OVRDVAL_7_STRIDE                                      4
+#define E56G__CMS_ANA_OVRDVAL_7_SIZE                                       32
+#define E56G__CMS_ANA_OVRDVAL_7_ACC_SIZE                                   32
+#define E56G__CMS_ANA_OVRDVAL_7_READ_MSB                                   29
+#define E56G__CMS_ANA_OVRDVAL_7_READ_LSB                                    0
+#define E56G__CMS_ANA_OVRDVAL_7_WRITE_MSB                                  29
+#define E56G__CMS_ANA_OVRDVAL_7_WRITE_LSB                                   0
+#define E56G__CMS_ANA_OVRDVAL_7_RESET_VALUE                               0x0
+
+typedef union {
+	struct {
+		u32 ovrd_en_ana_lcpll_hf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_bias_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_loop_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_cp_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_base_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_icp_fine_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_lpf_setcode_calib_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_set_lpf_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_vco_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_coarse_bin_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_fine_therm_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_vco_amp_status_o : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkout_fb_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clkdiv_ctrl_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_en_odiv_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_in_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_test_out_o : 1;
+		u32 ovrd_en_ana_lcpll_hf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_refclk_select_i : 1;
+		u32 ovrd_en_ana_lcpll_hf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_lcpll_lf_clk_ref_sel_i : 1;
+		u32 ovrd_en_ana_test_bias_i : 1;
+		u32 ovrd_en_ana_test_slicer_i : 1;
+		u32 ovrd_en_ana_test_sampler_i : 1;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDEN_1;
+#define E56G__CMS_ANA_OVRDEN_1_NUM                                          1
+#define E56G__CMS_ANA_OVRDEN_1_ADDR                    (E56G__BASEADDR+0xca8)
+#define E56G__CMS_ANA_OVRDEN_1_PTR ((volatile E56G__CMS_ANA_OVRDEN_1*)(E56G__CMS_ANA_OVRDEN_1_ADDR))
+#define E56G__CMS_ANA_OVRDEN_1_STRIDE                                       4
+#define E56G__CMS_ANA_OVRDEN_1_SIZE                                        32
+#define E56G__CMS_ANA_OVRDEN_1_ACC_SIZE                                    32
+#define E56G__CMS_ANA_OVRDEN_1_READ_MSB                                    31
+#define E56G__CMS_ANA_OVRDEN_1_READ_LSB                                     0
+#define E56G__CMS_ANA_OVRDEN_1_WRITE_MSB                                   31
+#define E56G__CMS_ANA_OVRDEN_1_WRITE_LSB                                    0
+#define E56G__CMS_ANA_OVRDEN_1_RESET_VALUE                                0x0
+
+typedef union {
+	struct {
+		u32 ana_lcpll_lf_test_in_i : 32;
+	};
+	u32 reg;
+} E56G__CMS_ANA_OVRDVAL_9;
+#define E56G__CMS_ANA_OVRDVAL_9_NUM                                         1
+#define E56G__CMS_ANA_OVRDVAL_9_ADDR                   (E56G__BASEADDR+0xcd4)
+#define E56G__CMS_ANA_OVRDVAL_9_PTR ((volatile E56G__CMS_ANA_OVRDVAL_9*)(E56G__CMS_ANA_OVRDVAL_9_ADDR))
+#define E56G__CMS_ANA_OVRDVAL_9_STRIDE                                      4
+#define E56G__CMS_ANA_OVRDVAL_9_SIZE                                       32
+#define E56G__CMS_ANA_OVRDVAL_9_ACC_SIZE                                   32
+#define E56G__CMS_ANA_OVRDVAL_9_READ_MSB                                   31
+#define E56G__CMS_ANA_OVRDVAL_9_READ_LSB                                    0
+#define E56G__CMS_ANA_OVRDVAL_9_WRITE_MSB                                  31
+#define E56G__CMS_ANA_OVRDVAL_9_WRITE_LSB                                   0
+#define E56G__CMS_ANA_OVRDVAL_9_RESET_VALUE                               0x0
+
+#define SFP2_RS0  5
+#define SFP2_RS1  4
+#define SFP2_TX_DISABLE  1
+#define SFP2_TX_FAULT  0
+#define SFP2_RX_LOS_BIT  3
+#ifdef PHYINIT_TIMEOUT
+#undef PHYINIT_TIMEOUT
+#define PHYINIT_TIMEOUT   2000
+#endif
+
+#define E56PHY_CMS_ANA_OVRDEN_0_ADDR   (E56PHY_CMS_BASE_ADDR+0xA4)
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_DAISY_EN_I 0,0
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_PAD_EN_I 1,1
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_REFCLK_BUF_PAD_EN_I_LSB 1
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_VDDINOFF_DCORE_DIG_O 2,2
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_EN_I 11,11
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_EN_I_LSB 11
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_TESTIN_I 12,12
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_BG_TESTIN_I_LSB 12
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RESCAL_I 13,13
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RESCAL_I_LSB 13
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_COMP_O 14,14
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_COMP_O_LSB 14
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_CODE_I 15,15
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_RESCAL_CODE_I_LSB 15
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_LDO_CORE_I 16,16
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_LDO_CORE_I_LSB 16
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_LDO_I 17,17
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_LDO_I_LSB 17
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_ANA_DEBUG_SEL_I 18,18
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_ANA_DEBUG_SEL_I_LSB 18
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_BIAS_I 19,19
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_BIAS_I_LSB 19
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_LOOP_I 20,20
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_LOOP_I_LSB 20
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_CP_I 21,21
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_EN_CP_I_LSB 21
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_BASE_I 22,22
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_BASE_I_LSB 22
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_FINE_I 23,23
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_ICP_FINE_I_LSB 23
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_CTRL_I 24,24
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_CTRL_I_LSB 24
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I 25,25
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I_LSB 25
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_SET_LPF_I 26,26
+#define E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I 29,29
+
+#define E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I 20,16
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I 12,12
+#define E56PHY_CMS_ANA_OVRDVAL_7_ADDR   (E56PHY_CMS_BASE_ADDR+0xCC)
+#define E56PHY_CMS_ANA_OVRDVAL_5_ADDR   (E56PHY_CMS_BASE_ADDR+0xC4)
+#define E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_TEST_IN_I 23,23
+#define E56PHY_CMS_ANA_OVRDVAL_9_ADDR   (E56PHY_CMS_BASE_ADDR+0xD4)
+#define E56PHY_CMS_ANA_OVRDVAL_10_ADDR   (E56PHY_CMS_BASE_ADDR+0xD8)
+#define E56PHY_CMS_ANA_OVRDVAL_7_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I 8,4
+#define E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR 5,5
+
+static void
+txgbe_e56_set_rxs_ufine_le_max(struct txgbe_hw *hw, u32 speed)
+{
+	u32 rdata;
+	u32 ULTRAFINE_CODE;
+
+	u32 CMVAR_UFINE_MAX = 0;
+
+	if (speed == 10)
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+	else if (speed == 25)
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	while (ULTRAFINE_CODE > CMVAR_UFINE_MAX) {
+		ULTRAFINE_CODE = ULTRAFINE_CODE - 1;
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+				      ULTRAFINE_CODE);
+		txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i,
+				      1);
+		msleep(20);
+	}
+}
+
+static int txgbe_e56_rxs_osc_init_for_temp_track_range(struct txgbe_hw *hw,
+		u32 speed)
+{
+	int OFFSET_CENTRE_RANGE_H, OFFSET_CENTRE_RANGE_L, RANGE_FINAL;
+	int RX_COARSE_MID_TD, CMVAR_RANGE_H = 0, CMVAR_RANGE_L = 0;
+	int T = 40;
+	u32 addr, rdata, timer;
+	int status = 0;
+
+	/* 1. Read the temperature T just before RXS is enabled. */
+	txgbe_e56_get_temp(hw, &T);
+
+	/* 2. Define software variable RX_COARSE_MID_TD */
+	if (T < -5)
+		RX_COARSE_MID_TD = 10;
+	else if (T < 30)
+		RX_COARSE_MID_TD = 9;
+	else if (T < 65)
+		RX_COARSE_MID_TD = 8;
+	else if (T < 100)
+		RX_COARSE_MID_TD = 7;
+	else
+		RX_COARSE_MID_TD = 6;
+
+	/* Set CMVAR_RANGE_H/L based on the link speed mode */
+	if (speed == 10 || speed == 40) {
+		CMVAR_RANGE_H = S10G_CMVAR_RANGE_H;
+		CMVAR_RANGE_L = S10G_CMVAR_RANGE_L;
+	} else if (speed == 25) {
+		CMVAR_RANGE_H = S25G_CMVAR_RANGE_H;
+		CMVAR_RANGE_L = S25G_CMVAR_RANGE_L;
+	}
+
+	/* TBD select all lane */
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I,
+		       CMVAR_RANGE_H);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/* 4. Do SEQ::RX_ENABLE to enable RXS */
+	rdata = 0x0000;
+	addr = E56PHY_RXS0_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS0_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	timer = 0;
+	while ((rdata & 0x3f) != 0x9) {
+		usec_delay(100);
+		rdata = 0;
+		addr = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x100) == 0x100)
+			break;
+		rdata = 0;
+		addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+			return -1;
+		}
+	}
+
+	rdata = 0;
+	addr = E56PHY_RXS_ANA_OVRDVAL_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	OFFSET_CENTRE_RANGE_H = (rdata >> 4) & 0xf;
+	if (OFFSET_CENTRE_RANGE_H > RX_COARSE_MID_TD)
+		OFFSET_CENTRE_RANGE_H = OFFSET_CENTRE_RANGE_H - RX_COARSE_MID_TD;
+	else
+		OFFSET_CENTRE_RANGE_H = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_H;
+
+	rdata = 0;
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	timer = 0;
+	while (1) {
+		usec_delay(100);
+		rdata = 0;
+		addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x3f) == 0x21)
+			break;
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+			return -1;
+		}
+	}
+
+	rdata = 0;
+	addr = E56PHY_INTR_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	wr32_ephy(hw, addr, 0);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I,
+		       CMVAR_RANGE_L);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_BBCDR_OSC_RANGE_SEL_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS0_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_0_RXS0_RX0_SAMP_CAL_DONE_O, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS0_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	/* poll CTRL_FSM_RX_ST */
+	timer = 0;
+	while ((rdata & 0x3f) != 0x9) {
+		usec_delay(100);
+		rdata = 0;
+		addr = E56PHY_INTR_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x100) == 0x100)
+			break;
+		rdata = 0;
+		addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+			return -1;
+		}
+	}
+
+	rdata = 0;
+	addr = E56PHY_RXS_ANA_OVRDVAL_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	OFFSET_CENTRE_RANGE_L = (rdata >> 4) & 0xf;
+	if (OFFSET_CENTRE_RANGE_L > RX_COARSE_MID_TD)
+		OFFSET_CENTRE_RANGE_L = OFFSET_CENTRE_RANGE_L - RX_COARSE_MID_TD;
+
+	else
+		OFFSET_CENTRE_RANGE_L = RX_COARSE_MID_TD - OFFSET_CENTRE_RANGE_L;
+
+	/*13. Perform below calculation in software. */
+	if (OFFSET_CENTRE_RANGE_L < OFFSET_CENTRE_RANGE_H)
+		RANGE_FINAL = CMVAR_RANGE_L;
+	else
+		RANGE_FINAL = CMVAR_RANGE_H;
+
+	/* 14. SEQ::RX_DISABLE to disable RXS. Poll ALIAS::PDIG::CTRL_FSM_RX_ST */
+	rdata = 0;
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x0);
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	wr32_ephy(hw, addr, rdata);
+
+	timer = 0;
+	while (1) {
+		usec_delay(100);
+		rdata = 0;
+		addr = E56PHY_CTRL_FSM_RX_STAT_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		if ((rdata & 0x3f) == 0x21)
+			break;
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+			return -1;
+		}
+	}
+
+	/* 15. Since RX power-up fsm is stopped in RX_SAMP_CAL_ST */
+	rdata = 0;
+	addr = E56PHY_INTR_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	wr32_ephy(hw, addr, 0);
+
+	/* 16. Program ALIAS::RXS::RANGE_SEL = RANGE_FINAL */
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_RXS_ANA_OVRDVAL_5_ANA_BBCDR_OSC_RANGE_SEL_I,
+		       RANGE_FINAL);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS0_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_RXS0_OVRDEN_0_OVRD_EN_RXS0_RX0_SAMP_CAL_DONE_O,
+		       0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0;
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_0_RX_EN_CFG, 0x1);
+	addr = E56PHY_PMD_CFG_0_ADDR;
+	wr32_ephy(hw, addr, rdata);
+
+	return status;
+}
+
+static int txgbe_e56_rxs_post_cdr_lock_temp_track_seq(struct txgbe_hw *hw,
+		u32 speed)
+{
+	int status = 0;
+	u32 rdata;
+	int SECOND_CODE;
+	int COARSE_CODE;
+	int FINE_CODE;
+	int ULTRAFINE_CODE;
+
+	int CMVAR_SEC_LOW_TH ;
+	int CMVAR_UFINE_MAX = 0;
+	int CMVAR_FINE_MAX ;
+	int CMVAR_UFINE_UMAX_WRAP = 0;
+	int CMVAR_COARSE_MAX ;
+	int CMVAR_UFINE_FMAX_WRAP = 0;
+	int CMVAR_FINE_FMAX_WRAP = 0;
+	int CMVAR_SEC_HIGH_TH ;
+	int CMVAR_UFINE_MIN ;
+	int CMVAR_FINE_MIN ;
+	int CMVAR_UFINE_UMIN_WRAP ;
+	int CMVAR_COARSE_MIN ;
+	int CMVAR_UFINE_FMIN_WRAP ;
+	int CMVAR_FINE_FMIN_WRAP ;
+
+	if (speed == 10) {
+		CMVAR_SEC_LOW_TH = S10G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S10G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S10G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S10G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S10G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S10G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S10G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S10G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S10G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S10G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S10G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S10G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S10G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S10G_CMVAR_FINE_FMIN_WRAP;
+	} else if (speed == 25) {
+		CMVAR_SEC_LOW_TH = S25G_CMVAR_SEC_LOW_TH;
+		CMVAR_UFINE_MAX = S25G_CMVAR_UFINE_MAX;
+		CMVAR_FINE_MAX = S25G_CMVAR_FINE_MAX;
+		CMVAR_UFINE_UMAX_WRAP = S25G_CMVAR_UFINE_UMAX_WRAP;
+		CMVAR_COARSE_MAX = S25G_CMVAR_COARSE_MAX;
+		CMVAR_UFINE_FMAX_WRAP = S25G_CMVAR_UFINE_FMAX_WRAP;
+		CMVAR_FINE_FMAX_WRAP = S25G_CMVAR_FINE_FMAX_WRAP;
+		CMVAR_SEC_HIGH_TH = S25G_CMVAR_SEC_HIGH_TH;
+		CMVAR_UFINE_MIN = S25G_CMVAR_UFINE_MIN;
+		CMVAR_FINE_MIN = S25G_CMVAR_FINE_MIN;
+		CMVAR_UFINE_UMIN_WRAP = S25G_CMVAR_UFINE_UMIN_WRAP;
+		CMVAR_COARSE_MIN = S25G_CMVAR_COARSE_MIN;
+		CMVAR_UFINE_FMIN_WRAP = S25G_CMVAR_UFINE_FMIN_WRAP;
+		CMVAR_FINE_FMIN_WRAP = S25G_CMVAR_FINE_FMIN_WRAP;
+	}
+
+	status |= txgbe_e56_rx_rd_second_code(hw, &SECOND_CODE);
+
+	EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+	COARSE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i);
+	FINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i);
+	ULTRAFINE_CODE = EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i);
+
+	if (SECOND_CODE <= CMVAR_SEC_LOW_TH) {
+		if (ULTRAFINE_CODE < CMVAR_UFINE_MAX) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE + 1);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE < CMVAR_FINE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE < CMVAR_COARSE_MAX) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMAX_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE + 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		}
+	} else if (SECOND_CODE >= CMVAR_SEC_HIGH_TH) {
+		if (ULTRAFINE_CODE > CMVAR_UFINE_MIN) {
+			txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_ultrafine_i,
+					      ULTRAFINE_CODE - 1);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (FINE_CODE > CMVAR_FINE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_UMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = FINE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		} else if (COARSE_CODE > CMVAR_COARSE_MIN) {
+			EPHY_RREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5,
+				  ana_bbcdr_ultrafine_i) = CMVAR_UFINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_fine_i) = CMVAR_FINE_FMIN_WRAP;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDVAL_5, ana_bbcdr_coarse_i) = COARSE_CODE - 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDVAL_5);
+			EPHY_RREG(E56G__RXS0_ANA_OVRDEN_1);
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_coarse_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_fine_i) = 1;
+			EPHY_XFLD(E56G__RXS0_ANA_OVRDEN_1, ovrd_en_ana_bbcdr_ultrafine_i) = 1;
+			EPHY_WREG(E56G__RXS0_ANA_OVRDEN_1);
+		}
+	}
+
+	return status;
+}
+
+static int txgbe_e56_ctle_bypass_seq(struct txgbe_hw *hw)
+{
+	int status = 0;
+	u32 rdata;
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_0, ana_ctle_bypass_i, 1);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_bypass_i, 1);
+
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDVAL_3, ana_ctle_cz_cstm_i, 0);
+	txgbe_e56_ephy_config(E56G__RXS0_ANA_OVRDEN_0, ovrd_en_ana_ctle_cz_cstm_i, 1);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 1;
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_done_o) = 1;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	return status;
+}
+
+static int txgbe_e56_rxs_adc_adapt_seq(struct txgbe_hw *hw, u32 bypass_ctle)
+{
+	u32 rdata, timer, addr;
+	int status = 0, i;
+
+	rdata = 0;
+	timer = 0;
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_cdr_rdy_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(100);
+
+		if (timer++ > PHYINIT_TIMEOUT) {
+			return 1;
+		}
+	}
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_VGA_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_VGA_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_CTLE_TRAIN_EN_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_CTLE_TRAIN_EN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDEN_1_OVRD_EN_RXS0_RX0_ADC_INTL_CAL_DONE_O
+		       , 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	timer = 0;
+	while (((rdata >> E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_CAL_DONE_O_LSB) & 1)
+	       != 1) {
+		rdata = rd32_ephy(hw, addr);
+		usec_delay(100);
+
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+		}
+	}
+
+	for (i = 0; i < 16; i++) {
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_ofst_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(100);
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+			}
+		}
+
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_OFST_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+				      ovrd_en_rxs0_rx0_adc_ofst_adapt_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1,
+				 rxs0_rx0_adc_gain_adapt_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(100);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+			}
+		}
+
+		addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_GAIN_ADAPT_EN_I, 0x0);
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	addr = E56PHY_RXS0_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS0_OVRDVAL_1_RXS0_RX0_ADC_INTL_ADAPT_EN_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+	msleep(10);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_intl_adapt_en_i, 0);
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_en_i) = 1;
+	if (bypass_ctle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_en_i) = 1;
+
+	EPHY_WREG(E56G__PMD_RXS0_OVRDVAL_1);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+			      ovrd_en_rxs0_rx0_vga_train_done_o, 0);
+	rdata = 0;
+	timer = 0;
+	while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_vga_train_done_o) != 1) {
+		EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+		usec_delay(100);
+
+		if (timer++ > PHYINIT_TIMEOUT) {
+			break;
+		}
+	}
+
+	if (bypass_ctle == 0) {
+		txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+				      ovrd_en_rxs0_rx0_ctle_train_done_o, 0);
+		rdata = 0;
+		timer = 0;
+		while (EPHY_XFLD(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_ctle_train_done_o) != 1) {
+			EPHY_RREG(E56G__PMD_RXS0_OVRDVAL_1);
+			usec_delay(100);
+
+			if (timer++ > PHYINIT_TIMEOUT) {
+				break;
+			}
+		}
+	}
+
+	EPHY_RREG(E56G__PMD_RXS0_OVRDEN_1);
+	EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_vga_train_en_i) = 0;
+	if (bypass_ctle == 0)
+		EPHY_XFLD(E56G__PMD_RXS0_OVRDEN_1, ovrd_en_rxs0_rx0_ctle_train_en_i) = 0;
+	EPHY_WREG(E56G__PMD_RXS0_OVRDEN_1);
+
+	return status;
+}
+
+static int txgbe_e56_phy_rxs_calib_adapt_seq(struct txgbe_hw *hw,
+		u8 by_link_mode, u32 bypass_ctle)
+{
+	int status = 0;
+	u32 rdata;
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_ofst_adapt_en_i,
+			      0);
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_ofst_adapt_en_i, 1);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_gain_adapt_en_i,
+			      0);
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_gain_adapt_en_i, 1);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_intl_cal_en_i, 0);
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+			      ovrd_en_rxs0_rx0_adc_intl_cal_en_i, 1);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_intl_cal_done_o,
+			      1);
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_1,
+			      ovrd_en_rxs0_rx0_adc_intl_cal_done_o, 1);
+
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDVAL_1, rxs0_rx0_adc_intl_adapt_en_i,
+			      0);
+	txgbe_e56_ephy_config(E56G__PMD_RXS0_OVRDEN_2,
+			      ovrd_en_rxs0_rx0_adc_intl_adapt_en_i, 1);
+
+	if (bypass_ctle != 0)
+		status |= txgbe_e56_ctle_bypass_seq(hw);
+
+	status |= txgbe_e56_rxs_osc_init_for_temp_track_range(hw, by_link_mode);
+
+	/* Wait an fsm_rx_sts 25G */
+	status |= kr_read_poll(rd32_ephy, rdata, ((rdata & 0x3f) == 0x1b), 1000,
+			       500000, hw, E56PHY_CTRL_FSM_RX_STAT_0_ADDR);
+
+	return status;
+}
+
+static int txgbe_e56_cms_cfg_for_temp_track_range(struct txgbe_hw *hw,
+		u8 by_link_mode)
+{
+	UNREFERENCED_PARAMETER(by_link_mode);
+	int status = 0, T = 40;
+	u32 addr, rdata;
+
+	status = txgbe_e56_get_temp(hw, &T);
+	if (T < 40) {
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_2_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_7_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDVAL_7_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+	} else if (T > 70) {
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_0_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_2_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_LPF_SETCODE_CALIB_I, 0x3);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I, 0x1);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_7_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata,
+			       E56PHY_CMS_ANA_OVRDVAL_7_ANA_LCPLL_LF_LPF_SETCODE_CALIB_I, 0x3);
+		wr32_ephy(hw, addr, rdata);
+	} else {
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I,
+			       0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_4_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 24, 24, 0x1);
+		set_fields_e56(&rdata, 31, 29, 0x4);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_5_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 1, 0, 0x0);
+		wr32_ephy(hw, addr, rdata);
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_LF_TEST_IN_I,
+			       0x1);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_9_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 24, 24, 0x1);
+		set_fields_e56(&rdata, 31, 29, 0x4);
+		wr32_ephy(hw, addr, rdata);
+
+		rdata = 0x0000;
+		addr = E56PHY_CMS_ANA_OVRDVAL_10_ADDR;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 1, 0, 0x0);
+		wr32_ephy(hw, addr, rdata);
+	}
+	return status;
+}
+
+static int txgbe_e56_tx_ffe_cfg(struct txgbe_hw *hw)
+{
+	/* Setting the TX EQ main/pre1/pre2/post value */
+	wr32_ephy(hw, 0x141c, S25G_TX_FFE_CFG_DAC_MAIN);
+	wr32_ephy(hw, 0x1420, S25G_TX_FFE_CFG_DAC_PRE1);
+	wr32_ephy(hw, 0x1424, S25G_TX_FFE_CFG_DAC_PRE2);
+	wr32_ephy(hw, 0x1428, S25G_TX_FFE_CFG_DAC_POST);
+
+	return 0;
+}
+
+static int txgbe_e56_bp_cfg_25g(struct txgbe_hw *hw)
+{
+	u32 addr, rdata;
+
+	rdata = 0x0000;
+	addr = E56PHY_CMS_PIN_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDVAL_0_INT_PLL0_TX_SIGNAL_TYPE_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CMS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_PIN_OVRDEN_0_OVRD_EN_PLL0_TX_SIGNAL_TYPE_I,
+		       0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CMS_ANA_OVRDVAL_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDVAL_2_ANA_LCPLL_HF_VCO_SWING_CTRL_I,
+		       0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CMS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata,
+		       E56PHY_CMS_ANA_OVRDEN_0_OVRD_EN_ANA_LCPLL_HF_VCO_SWING_CTRL_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CMS_ANA_OVRDVAL_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr  = E56PHY_CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CMS_ANA_OVRDEN_1_OVRD_EN_ANA_LCPLL_HF_TEST_IN_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 27, 24, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_tx_ffe_cfg(hw);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_PREDIV1, 0x700);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_1_TARGET_CNT1, 0x2418);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_RANGE_SEL1, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_VCO_CODE_INIT, 0x7fb);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_OSC_CURRENT_BOOST_EN1, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_4_BBCDR_CURRENT_BOOST1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_0_ADC_INTL2SLICE_DELAY1, 0x3333);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_INTL_CONFIG_2_INTERLEAVER_HBW_DISABLE1, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1f8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0xf0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56G__RXS0_FOM_18__ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFL_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFL_HINT__LSB, 0x0);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFFH_HINT__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFFH_HINT__LSB, 0x0);
+	set_fields_e56(&rdata, E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__MSB,
+		       E56G__RXS0_FOM_18__DFE_COEFF_HINT_LOAD__LSB, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1, 18);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2, 0);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3, 0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1, 1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2, 0);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3, 0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = 0x6cc;
+	rdata = 0x8020000;
+	wr32_ephy(hw, addr, rdata);
+	addr = 0x94;
+	rdata = 0;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x0);
+	set_fields_e56(&rdata, 14, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 21, 12, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+static int txgbe_e56_bp_cfg_10g(struct txgbe_hw *hw)
+{
+	u32 addr, rdata;
+
+	rdata = 0x0000;
+	addr = E56G__CMS_ANA_OVRDVAL_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G__CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56G__CMS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G__CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_vco_swing_ctrl_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56G__CMS_ANA_OVRDVAL_9_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 23, 0, 0x260000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56G__RXS0_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G__CMS_ANA_OVRDEN_1 *)&rdata)->ovrd_en_ana_lcpll_lf_test_in_i = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_TXS_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_TXS_CFG_1_ADAPTATION_WAIT_CNT_X256, 0xf);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_WKUP_CNT_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTLDO_WKUP_CNT_X32, 0xff);
+	set_fields_e56(&rdata, E56PHY_TXS_WKUP_CNTDCC_WKUP_CNT_X32, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_PIN_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 19, 16, 0x6);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_PIN_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_PIN_OVRDEN_0_OVRD_EN_TX0_EFUSE_BITS_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_ANA_OVRDVAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDVAL_1_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_TXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_TXS_ANA_OVRDEN_0_OVRD_EN_ANA_TEST_DAC_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	txgbe_e56_tx_ffe_cfg(hw);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_RXS_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_DSER_DATA_SEL, 0x0);
+	set_fields_e56(&rdata, E56PHY_RXS_RXS_CFG_0_TRAIN_CLK_GATE_BYPASS_EN, 0x1fff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr  = E56PHY_RXS_OSC_CAL_N_CDR_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->prediv0 = 0xfa0;
+	((E56G_RXS0_OSC_CAL_N_CDR_0 *)&rdata)->target_cnt0 = 0x203a;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_range_sel0 = 0x2;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->vco_code_init = 0x7ff;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->osc_current_boost_en0 = 0x1;
+	((E56G_RXS0_OSC_CAL_N_CDR_4 *)&rdata)->bbcdr_current_boost0 = 0x0;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_SDM_WIDTH, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_PROP_STEP_POSTLOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_POSTLOCK,
+		       0xc);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BB_CDR_GAIN_CTRL_PRELOCK,
+		       0xf);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_5_BBCDR_RDY_CNT, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OSC_CAL_N_CDR_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_PRELOCK, 0x7);
+	set_fields_e56(&rdata, E56PHY_RXS_OSC_CAL_N_CDR_6_PI_GAIN_CTRL_POSTLOCK, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_INTL_CONFIG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_0 *)&rdata)->adc_intl2slice_delay0 = 0x5555;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_INTL_CONFIG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	((E56G_RXS0_INTL_CONFIG_2 *)&rdata)->interleaver_hbw_disable0 = 0x1;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_LTH, 0x56);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_0_ADC_DATA_PEAK_UTH, 0x6a);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_LTH, 0x1e8);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_1_C1_UTH, 0x78);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_LTH, 0x100);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_2_CM1_UTH, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_TXFFE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_LTH, 0x4);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_CM2_UTH, 0x37);
+	set_fields_e56(&rdata, E56PHY_RXS_TXFFE_TRAINING_3_TXFFE_TRAIN_MOD_TYPE, 0x38);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_0_VGA_TARGET, 0x34);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_VGA_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT0, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA1_CODE_INIT123, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_VGA_TRAINING_1_VGA2_CODE_INIT123, 0xa);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT0, 0x9);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_0_CTLE_CODE_INIT123, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_1_LFEQ_LUT, 0x1ffffea);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P1, 0x18);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P2, 0);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_2_ISI_TH_FRAC_P3, 0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_CTLE_TRAINING_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P1, 1);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P2, 0);
+	set_fields_e56(&rdata, E56PHY_RXS_CTLE_TRAINING_3_TAP_WEIGHT_P3, 0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_SLICE_DATA_AVG_CNT,
+		       0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_ADC_DATA_AVG_CNT, 0x3);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_0_FE_OFFSET_DAC_CLK_CNT_X8,
+		       0xc);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_OFFSET_N_GAIN_CAL_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_OFFSET_N_GAIN_CAL_1_SAMP_ADAPT_CFG, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_FFE_TRAINING_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_FFE_TRAINING_0_FFE_TAP_EN, 0xf9ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_IDLE_DETECT_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MAX, 0xa);
+	set_fields_e56(&rdata, E56PHY_RXS_IDLE_DETECT_1_IDLE_TH_ADC_PEAK_MIN, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	addr = 0x6cc;
+	rdata = 0x8020000;
+	wr32_ephy(hw, addr, rdata);
+	addr = 0x94;
+	rdata = 0;
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_0_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_0_OVRD_EN_ANA_EN_RTERM_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_6_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 4, 0, 0x6);
+	set_fields_e56(&rdata, 14, 13, 0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_BBCDR_VCOFILT_BYP_I,
+		       0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_1_OVRD_EN_ANA_TEST_BBCDR_I, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 2, 0, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDVAL_17_ANA_VGA2_BOOST_CSTM_I, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_ANABS_CONFIG_I, 0x1);
+	set_fields_e56(&rdata, E56PHY_RXS_ANA_OVRDEN_3_OVRD_EN_ANA_VGA2_BOOST_CSTM_I,
+		       0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDVAL_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_ANA_OVRDEN_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 13, 13, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_EYE_SCAN_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_RXS_EYE_SCAN_1_EYE_SCAN_REF_TIMER, 0x400);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_RXS_RINGO_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 21, 12, 0x366);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_3_CTRL_FSM_TIMEOUT_X64K, 0x80);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_ON_PERIOD_X64K, 0x18);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_4_TRAIN_DC_PERIOD_X512K, 0x3e);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_PMD_CFG_5_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_PMD_CFG_5_USE_RECENT_MARKER_OFFSET, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_CONT_ON_ADC_GAIN_CAL_ERR, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_DO_RX_ADC_OFST_CAL, 0x3);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_0_RX_ERR_ACTION_EN, 0x40);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_1_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST0_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST1_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST2_WAIT_CNT_X4096, 0xff);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_1_TRAIN_ST3_WAIT_CNT_X4096, 0xff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_2_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST4_WAIT_CNT_X4096, 0x1);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST5_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST6_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_2_TRAIN_ST7_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_3_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST8_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST9_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST10_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_3_TRAIN_ST11_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_4_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST12_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST13_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST14_WAIT_CNT_X4096, 0x4);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_4_TRAIN_ST15_WAIT_CNT_X4096, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_7_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST4_EN, 0x4bf);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_7_TRAIN_ST5_EN, 0xc4bf);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_8_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_8_TRAIN_ST7_EN, 0x47ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_12_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_12_TRAIN_ST15_EN, 0x67ff);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_13_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST0_DONE_EN, 0x8001);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_13_TRAIN_ST1_DONE_EN, 0x8002);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_14_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_14_TRAIN_ST3_DONE_EN, 0x8008);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_15_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_15_TRAIN_ST4_DONE_EN, 0x8004);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_17_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_17_TRAIN_ST8_DONE_EN, 0x20c0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_18_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_18_TRAIN_ST10_DONE_EN, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_29_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_29_TRAIN_ST15_DC_EN, 0x3f6d);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_33_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN0_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_33_TRAIN1_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_CTRL_FSM_CFG_34_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN2_RATE_SEL, 0x8000);
+	set_fields_e56(&rdata, E56PHY_CTRL_FSM_CFG_34_TRAIN3_RATE_SEL, 0x8000);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_KRT_TFSM_CFG_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X1000K, 0x49);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_MAX_WAIT_TIMER_X8000K, 0x37);
+	set_fields_e56(&rdata, E56PHY_KRT_TFSM_CFGKRT_TFSM_HOLDOFF_TIMER_X256K, 0x2f);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = E56PHY_FETX_FFE_TRAIN_CFG_0_ADDR;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, E56PHY_FETX_FFE_TRAIN_CFG_0_KRT_FETX_INIT_FFE_CFG_2,
+		       0x2);
+	wr32_ephy(hw, addr, rdata);
+
+	return 0;
+}
+
+static int txgbe_set_phy_link_mode(struct txgbe_hw *hw,
+				   u8 by_link_mode)
+{
+	int status = 0;
+	u32 addr, rdata;
+
+	rdata = 0x0000;
+	addr = 0x030000;
+	rdata = rd32_epcs(hw, addr);
+	/* 10G mode */
+	if (by_link_mode == 10)
+		set_fields_e56(&rdata, 5, 2, 0);
+	/* 25G mode */
+	else if (by_link_mode == 25)
+		set_fields_e56(&rdata, 5, 2, 5);
+	wr32_epcs(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0x030007;
+	rdata = rd32_epcs(hw, addr);
+	/* 10G mode */
+	if (by_link_mode == 10)
+		set_fields_e56(&rdata, 3, 0, 0);
+	/* 25G mode */
+	else if (by_link_mode == 25)
+		set_fields_e56(&rdata, 3, 0, 7);
+	wr32_epcs(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0x010007;
+	rdata = rd32_epcs(hw, addr);
+	/* 10G mode */
+	if (by_link_mode == 10)
+		set_fields_e56(&rdata, 6, 0, 0xb);
+	/* 25G mode */
+	else if (by_link_mode == 25)
+		set_fields_e56(&rdata, 6, 0, 0x39);
+	wr32_epcs(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xcb0;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 29, 29, 0x1);
+	set_fields_e56(&rdata, 1, 1, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xcc4;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 24, 24, 0x0);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xca4;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 1, 1, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xca8;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 30, 30, 0x1);
+	set_fields_e56(&rdata, 25, 25, 0x1);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xc10;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 25, 24, 0x1);
+	set_fields_e56(&rdata, 17, 16, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xc18;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 12, 8, 0x4);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xc48;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 25, 24, 0x1);
+	set_fields_e56(&rdata, 17, 16, 0x3);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xc50;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 12, 8, 0x8);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0xc1c;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 18, 8, 0x294);
+	set_fields_e56(&rdata, 4, 0, 0x8);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0x142c;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 30, 28, 0x7);
+	set_fields_e56(&rdata, 26, 24, 0x5);
+	if (by_link_mode == 10)
+		set_fields_e56(&rdata, 18, 16, 0x5);
+	else if (by_link_mode == 25)
+		set_fields_e56(&rdata, 18, 16, 0x3);
+	set_fields_e56(&rdata, 14, 12, 0x5);
+	set_fields_e56(&rdata, 10, 8, 0x5);
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0x1430;
+	rdata = rd32_ephy(hw, addr);
+	set_fields_e56(&rdata, 26, 24, 0x5);
+	set_fields_e56(&rdata, 10, 8, 0x5);
+	if (by_link_mode == 10) {
+		set_fields_e56(&rdata, 18, 16, 0x5);
+		set_fields_e56(&rdata, 2, 0, 0x5);
+	} else if (by_link_mode == 25) {
+		set_fields_e56(&rdata, 18, 16, 0x3);
+		set_fields_e56(&rdata, 2, 0, 0x3);
+	}
+	wr32_ephy(hw, addr, rdata);
+
+	rdata = 0x0000;
+	addr = 0x1438;
+	rdata = rd32_ephy(hw, addr);
+	if (by_link_mode == 10)
+		set_fields_e56(&rdata, 4, 0, 0x2);
+	else if (by_link_mode == 25)
+		set_fields_e56(&rdata, 4, 0, 0x9);
+	wr32_ephy(hw, addr, rdata);
+
+	status = txgbe_e56_cms_cfg_for_temp_track_range(hw, by_link_mode);
+
+	if (by_link_mode == 10)
+		txgbe_e56_bp_cfg_10g(hw);
+	else
+		txgbe_e56_bp_cfg_25g(hw);
+
+	if (by_link_mode == 10) {
+		rdata = 0x0000;
+		addr = 0x1400;
+		rdata = rd32_ephy(hw, addr);
+		set_fields_e56(&rdata, 21, 20, 0x3); /* pll en */
+		set_fields_e56(&rdata, 19, 12, 0x1); /* tx/rx en */
+		set_fields_e56(&rdata, 8, 8, 0x0); /* pmd mode */
+		set_fields_e56(&rdata, 1, 1, 0x1); /* pmd en */
+		wr32_ephy(hw, addr, rdata);
+	}
+
+	return status;
+}
+
+int txgbe_e56_set_link_to_kr(struct txgbe_hw *hw)
+{
+	int status = 0;
+	u32 rdata;
+
+	/* pcs + phy rst */
+	rdata = rd32(hw, 0x1000c);
+	if (hw->bus.lan_id == 1)
+		rdata |= BIT(16);
+	else
+		rdata |= BIT(19);
+	wr32(hw, 0x1000c, rdata);
+	msleep(20);
+
+	/* enable pcs intr */
+	wr32_epcs(hw, VR_AN_INTR_MSK, 0xf);
+
+	/* clear interrupt */
+	wr32_epcs(hw, 0x070000, 0);
+	wr32_epcs(hw, 0x078002, 0x0000);
+	wr32_epcs(hw, 0x030000, 0x8000);
+	rdata = rd32_epcs(hw, 0x070000);
+	set_fields_e56(&rdata, 12, 12, 0x1);
+	wr32_epcs(hw, 0x070000, rdata);
+	wr32_epcs(hw, 0x070010, 0x0001);
+	/* 25KR */
+	wr32_epcs(hw, 0x070011, 0xC080);
+
+	/* BASE-R FEC */
+	wr32_epcs(hw, 0x070012, 0xc000);
+	wr32_epcs(hw, 0x070016, 0x0000);
+	wr32_epcs(hw, 0x070017, 0x0);
+	wr32_epcs(hw, 0x070018, 0x0);
+
+	/* config timer */
+	wr32_epcs(hw, 0x078004, 0x003c);
+	wr32_epcs(hw, 0x078005, CL74_KRTR_TRAINNING_TIMEOUT);
+	wr32_epcs(hw, 0x078006, 25);
+	wr32_epcs(hw, 0x078000, 0x0008);
+
+	rdata = rd32_epcs(hw, 0x038000);
+	wr32_epcs(hw, 0x038000, rdata | BIT(15));
+
+	status = kr_read_poll(rd32_epcs, rdata,
+			      (((rdata >> 15) & 1) == 0), 100,
+			      200000, hw,
+			      0x038000);
+	if (status)
+		return status;
+
+	/* wait rx/tx/cm powerdn_st */
+	msleep(20);
+	/* set phy an status to 0 */
+	wr32_ephy(hw, 0x1640, 0x0000);
+	rdata = rd32_ephy(hw, 0x1434);
+	set_fields_e56(&rdata, 7, 4, 0xe);
+	wr32_ephy(hw, 0x1434, rdata);
+
+	status = txgbe_set_phy_link_mode(hw, 10);
+	if (status)
+		return status;
+
+	status = txgbe_e56_rxs_osc_init_for_temp_track_range(hw, 10);
+	if (status)
+		return status;
+
+	/* Wait an 10g fsm_rx_sts */
+	status = kr_read_poll(rd32_ephy, rdata,
+			      ((rdata & 0x3f) == 0xb), 1000,
+			      200000, hw,
+			      E56PHY_CTRL_FSM_RX_STAT_0_ADDR);
+
+	return status;
+}
+
+static int txgbe_e56_cl72_trainning(struct txgbe_hw *hw)
+{
+	u32 bylinkmode = hw->bp_link_mode;
+	int status = 0, pTempData = 0;
+	u8 bypassCtle = 0;
+	u32 rdata;
+
+	status = txgbe_set_phy_link_mode(hw, bylinkmode);
+
+	/* set phy an status to 1 */
+	rdata = rd32_ephy(hw, 0x1434);
+	set_fields_e56(&rdata, 7, 4, 0xf);
+	wr32_ephy(hw, 0x1434, rdata);
+
+	/* kr training */
+	rdata = rd32_ephy(hw, 0x1640);
+	set_fields_e56(&rdata, 7, 0, 0x3);
+	wr32_ephy(hw, 0x1640, rdata);
+
+	/* enable CMS and its internal PLL and tx enable */
+	rdata = rd32_ephy(hw, 0x1400);
+	set_fields_e56(&rdata, 21, 20, 0x3);//pll en
+	set_fields_e56(&rdata, 19, 12, 0x1);// tx/rx en
+	set_fields_e56(&rdata, 8, 8, 0x0);// pmd mode
+	set_fields_e56(&rdata, 1, 1, 0x1);// pmd en
+	wr32_ephy(hw, 0x1400, rdata);
+
+	status = txgbe_e56_phy_rxs_calib_adapt_seq(hw, bylinkmode, bypassCtle);
+
+	txgbe_e56_set_rxs_ufine_le_max(hw, bylinkmode);
+
+	status = txgbe_e56_get_temp(hw, &pTempData);
+	status = txgbe_e56_rxs_post_cdr_lock_temp_track_seq(hw, bylinkmode);
+
+	status = kr_read_poll(rd32_ephy, rdata, (rdata & BIT(1)), 100,
+				   200000, hw, 0x163c);
+
+	status = txgbe_e56_rxs_adc_adapt_seq(hw, bypassCtle);
+
+	/* Wait an RLU */
+	status = kr_read_poll(rd32_epcs, rdata, (rdata & BIT(2)),
+				   100, 500000, hw, 0x30001);
+
+	return status;
+}
+
+int handle_e56_bkp_an73_flow(struct txgbe_hw *hw)
+{
+	int status = 0;
+
+	status = txgbe_e56_cl72_trainning(hw);
+	return status;
+}
+
+void txgbe_e65_bp_down_event(struct txgbe_hw *hw)
+{
+	if (!(hw->devarg.auto_neg == 1))
+		return;
+}
diff --git a/drivers/net/txgbe/base/txgbe_e56_bp.h b/drivers/net/txgbe/base/txgbe_e56_bp.h
new file mode 100644
index 0000000000..f959b58ff7
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_e56_bp.h
@@ -0,0 +1,13 @@
+#ifndef _TXGBE_E56_BP_H_
+#define _TXGBE_E56_BP_H_
+
+#define TXGBE_10G_FEC_REQ       BIT(15)
+#define TXGBE_10G_FEC_ABL       BIT(14)
+#define TXGBE_25G_BASE_FEC_REQ  BIT(13)
+#define TXGBE_25G_RS_FEC_REQ    BIT(12)
+
+int txgbe_e56_set_link_to_kr(struct txgbe_hw *hw);
+void txgbe_e65_bp_down_event(struct txgbe_hw *hw);
+int handle_e56_bkp_an73_flow(struct txgbe_hw *hw);
+
+#endif
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 85dbbc5eff..4750b84802 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,10 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_e56.h"
+#include "txgbe_e56_bp.h"
+#include "txgbe_aml.h"
+#include "txgbe_aml40.h"
 
 #define TXGBE_RAPTOR_MAX_TX_QUEUES 128
 #define TXGBE_RAPTOR_MAX_RX_QUEUES 128
@@ -2469,9 +2473,7 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
-	case txgbe_mac_aml:
-	case txgbe_mac_aml40:
-		status = txgbe_init_ops_pf(hw);
+		status = txgbe_init_ops_sp(hw);
 		break;
 	case txgbe_mac_raptor_vf:
 		status = txgbe_init_ops_vf(hw);
@@ -2781,7 +2783,7 @@ s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data)
  *  Initialize the function pointers and assign the MAC type.
  *  Does not touch the hardware.
  **/
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
+s32 txgbe_init_ops_sp(struct txgbe_hw *hw)
 {
 	struct txgbe_bus_info *bus = &hw->bus;
 	struct txgbe_mac_info *mac = &hw->mac;
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 1ed2892f61..79355ee9a3 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -86,7 +86,7 @@ s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw);
+s32 txgbe_init_ops_sp(struct txgbe_hw *hw);
 s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
 u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw);
diff --git a/drivers/net/txgbe/base/txgbe_osdep.h b/drivers/net/txgbe/base/txgbe_osdep.h
index a1477653e2..d8c0e10552 100644
--- a/drivers/net/txgbe/base/txgbe_osdep.h
+++ b/drivers/net/txgbe/base/txgbe_osdep.h
@@ -164,6 +164,10 @@ static inline u64 REVERT_BIT_MASK64(u64 mask)
 
 #define IOMEM
 
+#ifndef BIT
+#define BIT(nr)         (1UL << (nr))
+#endif
+
 #define prefetch(x) rte_prefetch0(x)
 
 #define ARRAY_SIZE(x) ((int32_t)RTE_DIM(x))
diff --git a/drivers/net/txgbe/base/txgbe_phy.h b/drivers/net/txgbe/base/txgbe_phy.h
index 4dfe18930c..cf9142dc0c 100644
--- a/drivers/net/txgbe/base/txgbe_phy.h
+++ b/drivers/net/txgbe/base/txgbe_phy.h
@@ -105,6 +105,8 @@
 #define   VR_AN_INTR_CMPLT		  MS16(0, 0x1)
 #define   VR_AN_INTR_LINK		  MS16(1, 0x1)
 #define   VR_AN_INTR_PG_RCV		  MS16(2, 0x1)
+#define   TXGBE_E56_AN_TXDIS              MS16(3, 0x1)
+#define   TXGBE_E56_AN_PG_RCV             MS16(4, 0x1)
 #define VR_AN_KR_MODE_CL                  0x078003
 #define   VR_AN_KR_MODE_CL_PDET		  MS16(0, 0x1)
 #define VR_XS_OR_PCS_MMD_DIGI_CTL1        0x038000
@@ -405,6 +407,21 @@
 #define TXGBE_BP_M_NAUTO                     0
 #define TXGBE_BP_M_AUTO                      1
 
+#define kr_read_poll(op, val, cond, sleep_us, \
+		     times, args...) \
+({ \
+	unsigned long __sleep_us = (sleep_us); \
+	u32 __times = (times); \
+	u32 i; \
+	for (i = 0; i < __times; i++) { \
+		(val) = op(args); \
+		if (cond) \
+			break; \
+		usleep(__sleep_us);\
+	} \
+	(cond) ? 0 : -1; \
+})
+
 #ifndef CL72_KRTR_PRBS_MODE_EN
 #define CL72_KRTR_PRBS_MODE_EN	0xFFFF	/* open kr prbs check */
 #endif
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index a27860ac84..ac21c14d37 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -156,6 +156,12 @@
 #define TXGBE_LOCKPF               0x010008
 #define TXGBE_RST                  0x01000C
 #define   TXGBE_RST_SW             MS(0, 0x1)
+#define   TXGBE_RST_FW             MS(3, 0x1)
+#define   TXGBE_RST_DMA            MS(4, 0x1)
+#define   TXGBE_RST_EPHY_LAN_1     MS(16, 0x1)
+#define   TXGBE_RST_EPHY_LAN_0     MS(19, 0x1)
+#define   TXGBE_RST_MAC_LAN_1      MS(17, 0x1)
+#define   TXGBE_RST_MAC_LAN_0      MS(20, 0x1)
 #define   TXGBE_RST_LAN(i)         MS(((i) + 1), 0x1)
 #define   TXGBE_RST_FW             MS(3, 0x1)
 #define   TXGBE_RST_ETH(i)         MS(((i) + 29), 0x1)
@@ -1570,6 +1576,13 @@ enum txgbe_5tuple_protocol {
 #define     TXGBE_PORTSTAT_BW_100M      MS(3, 0x1)
 #define   TXGBE_PORTSTAT_ID(r)          RS(r, 8, 0x1)
 
+/* amlite: diff from sapphire */
+#define TXGBE_CFG_PORT_ST_AML_LINK_MASK     MS(1, 0xF)
+#define TXGBE_CFG_PORT_ST_AML_LINK_10G      MS(4, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_25G      MS(3, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_40G      MS(2, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_50G      MS(1, 0x1)
+
 #define TXGBE_VXLAN                     0x014410
 #define TXGBE_VXLAN_GPE                 0x014414
 #define TXGBE_GENEVE                    0x014418
@@ -1594,7 +1607,10 @@ enum txgbe_5tuple_protocol {
 #define TXGBE_GPIOINTSTAT               0x014840
 #define TXGBE_GPIORAWINTSTAT            0x014844
 #define TXGBE_GPIOEOI                   0x01484C
-
+#define TXGBE_GPIOEXT                   0x014850
+#define   TXGBE_SFP1_MOD_PRST_LS        0x00000010U /* GPIO_EXT SFP ABSENT*/
+#define   TXGBE_SFP1_MOD_ABS_LS         0x00000004U /* GPIO_EXT SFP ABSENT*/
+#define   TXGBE_SFP1_RX_LOS_LS          0x00000008U /* GPIO_EXT RX LOSS */
 
 #define TXGBE_ARBPOOLIDX                0x01820C
 #define TXGBE_ARBTXRATE                 0x018404
@@ -1689,6 +1705,9 @@ enum txgbe_5tuple_protocol {
 #define   TXGBE_MACTXCFG_SPEED_10G      LS(0, 29, 0x3)
 #define   TXGBE_MACTXCFG_SPEED_1G       LS(3, 29, 0x3)
 
+#define TXGBE_EPHY_STAT                 0x13404
+#define TXGBE_EPHY_STAT_PPL_LOCK        0x3
+
 #define TXGBE_ISBADDRL                  0x000160
 #define TXGBE_ISBADDRH                  0x000164
 
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index 1a5e4326a7..8d6491e053 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -214,6 +214,18 @@ enum txgbe_sfp_type {
 	txgbe_sfp_type_1g_sx_core1,
 	txgbe_sfp_type_1g_lx_core0,
 	txgbe_sfp_type_1g_lx_core1,
+	txgbe_sfp_type_25g_sr_core0,
+	txgbe_sfp_type_25g_sr_core1,
+	txgbe_sfp_type_25g_lr_core0,
+	txgbe_sfp_type_25g_lr_core1,
+	txgbe_sfp_type_25g_da_cu_core0,
+	txgbe_sfp_type_25g_da_cu_core1,
+	txgbe_sfp_type_25g_fcpi4_lmt_core0,
+	txgbe_sfp_type_25g_fcpi4_lmt_core1,
+	txgbe_sfp_type_25g_5m_da_cu_core0,
+	txgbe_sfp_type_25g_5m_da_cu_core1,
+	txgbe_sfp_type_40g_core0,
+	txgbe_sfp_type_40g_core1,
 	txgbe_sfp_type_not_present = 0xFFFE,
 	txgbe_sfp_type_not_known = 0xFFFF
 };
@@ -539,6 +551,7 @@ struct txgbe_mac_info {
 	s32 (*prot_autoc_read)(struct txgbe_hw *hw, bool *locked, u64 *value);
 	s32 (*prot_autoc_write)(struct txgbe_hw *hw, bool locked, u64 value);
 	s32 (*negotiate_api_version)(struct txgbe_hw *hw, int api);
+	void (*init_mac_link_ops)(struct txgbe_hw *hw);
 
 	/* Link */
 	void (*disable_tx_laser)(struct txgbe_hw *hw);
@@ -765,6 +778,12 @@ struct txgbe_devargs {
 	u16 sgmii;
 };
 
+#define TXGBE_PHY_FEC_RS	MS(0, 0x1)
+#define TXGBE_PHY_FEC_BASER	MS(1, 0x1)
+#define TXGBE_PHY_FEC_OFF	MS(2, 0x1)
+#define TXGBE_PHY_FEC_AUTO 	(TXGBE_PHY_FEC_OFF | TXGBE_PHY_FEC_BASER |\
+				 TXGBE_PHY_FEC_RS)
+
 struct txgbe_hw {
 	void IOMEM *hw_addr;
 	void *back;
@@ -821,6 +840,20 @@ struct txgbe_hw {
 		u64 tx_qp_bytes;
 		u64 rx_qp_mc_packets;
 	} qp_last[TXGBE_MAX_QP];
+
+	rte_spinlock_t phy_lock;
+	/*amlite: new SW-FW mbox */
+	u8 swfw_index;
+	rte_atomic32_t swfw_busy;
+	bool link_valid;
+	bool reconfig_rx;
+	/* workaround for temperature alarm */
+	bool overheat;
+	u32 fec_mode;
+	u32 cur_fec_link;
+	int temperature;
+	u32 tx_speed;
+	u32 bp_link_mode;
 };
 
 struct txgbe_backplane_ability {
-- 
2.21.0.windows.1

