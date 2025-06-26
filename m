Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D917C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 08:09:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81FA640EAB;
	Thu, 26 Jun 2025 10:09:21 +0200 (CEST)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
 by mails.dpdk.org (Postfix) with ESMTP id BE64F40EAB
 for <dev@dpdk.org>; Thu, 26 Jun 2025 10:09:18 +0200 (CEST)
X-QQ-mid: zesmtpsz9t1750925354tba1e5c8d
X-QQ-Originating-IP: RJK41CdUvlWMn9ZZvC7IdcyDeG5/5shm639qj1B/4sI=
Received: from DSK-zaiyuwang.trustnetic.com ( [36.27.0.255])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 26 Jun 2025 16:09:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6387721868545007169
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v3 04/15] net/txgbe: add basic link configuration for
 Amber-Lite NICs
Date: Thu, 26 Jun 2025 16:02:09 +0800
Message-Id: <20250626080221.22488-5-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250626080221.22488-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250626080221.22488-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Mcz+6SYYNHCpwrfZkxs9ugbu8swfyZ0greJegJqdnG11BHh/WBu4BdiR
 7TfayTSECZXTa7ZPcQ22ZUzL2TqWup0R8Ax7eCknap4ExWf2cTCSvRUf+M8+FogSRJOgjmN
 HY/+F9YWjFHqAul9oRJBYRruEKJ8lETHshjIqs/s6W4MeMdgvdBqkGjbaiEty921pGL8UBM
 OLEcnNl04ENUER4efBlqAJr6eCkS3OgQb0gY5ngi87uXJxmGzGYJw6lpXcKWf6HhNi//h8f
 xy7nK7OXxeBfdnmdV7g/zT4Pi0LxSD1439wKl0y7kcxLP/onEWEJEZ0jleKdoZFn6Hm3qBX
 2U5M14porxFKDcWRHCnHi6oX0QB5Cvr6tolWgRiPAcq7S5L1+5tpEbrvDLSPUpNLssJ/Vpl
 TNkaw5hxyP8GvxjT8SX/YKD1kUMGobfdKn/SoFm2GvhyGuzKd4zecUQV6+g2oB+WBCx0TE5
 Tw6lkUY1p6B3OIjh6SUFovGkP6fV0ELn91O95wwAf60ttCkguYj6B91ku+NjglzwgDlUyAO
 bgxjbwg1il9rM70I7mwuPkB+83c/5X2Ev5SVAItgl3YwDegv0mUaf7fHE8c+g3dJEZMJUn9
 exhCGj071KgeltJ0j2wZDcb3lmxugA/R15K42nA2g5R1mW1hUp+rhCJ7JNGIux/LUaVTG/B
 mvEeFXb17QLBWEHLx59LN5XbKBtyW5NEjjRTOPBJ70NrQyhYZEM6/AIvtH8ycMkeb464lj2
 UNfNjJJ6PedN7h/HMLhvY1N2arAsGlah+muyepnQMA3rjI+znCQqoHEcKVygBCFVr55SISo
 EMUIzicRTKnup+HoRA+W2zSOjDLhbh6F6gfSG+PW/kvG6ZFJP/Otjr3Je+jTZvHxVYQmiL4
 293sFowVrWwqzKq7P9VVbOgtTgr+i4tLmgIIL9mIu4pRMzVglslBpnkbMlktw91wFeiAGEn
 uJblt9kQlV2GYAqoTZjKTDV0HNEQ1heeCRnF1akyklM4eyTBHCig0oUP3K+wqudhx/2AUdr
 TISj9jvDmmXhx0vSZsVG50TpB0xR85YN1lNQ8KioEInsAU5NNHfLz7CTOGhINiz3BxDcEkE
 VNm7fJ78/Xu
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

Due to Amber-Lite's significant differences from our 10G NICs, we split
link configuration components (setup_link, check_link, etc.) into new
files.

Signed-off-by: Zaiyu Wang <zaiyuwang@trustnetic.com>
---
 drivers/net/txgbe/base/meson.build   |   2 +
 drivers/net/txgbe/base/txgbe_aml.c   | 323 +++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h   |  21 ++
 drivers/net/txgbe/base/txgbe_aml40.c | 126 +++++++++++
 drivers/net/txgbe/base/txgbe_aml40.h |  20 ++
 drivers/net/txgbe/base/txgbe_hw.c    |  78 ++++++-
 drivers/net/txgbe/base/txgbe_hw.h    |  13 +-
 drivers/net/txgbe/base/txgbe_regs.h  |   9 +
 drivers/net/txgbe/base/txgbe_type.h  |   2 +
 drivers/net/txgbe/txgbe_ethdev.c     |   8 +
 10 files changed, 585 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml.h
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.c
 create mode 100644 drivers/net/txgbe/base/txgbe_aml40.h

diff --git a/drivers/net/txgbe/base/meson.build b/drivers/net/txgbe/base/meson.build
index 0bb0782c92..ac4a05005e 100644
--- a/drivers/net/txgbe/base/meson.build
+++ b/drivers/net/txgbe/base/meson.build
@@ -6,6 +6,8 @@ base_sources = files(
         'txgbe_dcb.c',
         'txgbe_eeprom.c',
         'txgbe_hw.c',
+        'txgbe_aml.c',
+        'txgbe_aml40.c',
         'txgbe_mbx.c',
         'txgbe_mng.c',
         'txgbe_phy.c',
diff --git a/drivers/net/txgbe/base/txgbe_aml.c b/drivers/net/txgbe/base/txgbe_aml.c
new file mode 100644
index 0000000000..c622d46082
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -0,0 +1,323 @@
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
+
+void txgbe_init_ops_aml(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	txgbe_init_ops_generic(hw);
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_aml;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_aml;
+	mac->check_link = txgbe_check_mac_link_aml;
+}
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
+	} else {
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
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
+		hw->phy.sfp_type == txgbe_sfp_type_25g_sr_core1 ||
+		hw->phy.sfp_type == txgbe_sfp_type_25g_lr_core0 ||
+		hw->phy.sfp_type == txgbe_sfp_type_25g_lr_core1) {
+		*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		*autoneg = false;
+	} else if (hw->phy.sfp_type == txgbe_sfp_type_25g_aoc_core0 ||
+		   hw->phy.sfp_type == txgbe_sfp_type_25g_aoc_core1) {
+		*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		*autoneg = false;
+	} else {
+		/* SFP */
+		if (hw->phy.sfp_type == txgbe_sfp_type_not_present)
+			*speed = TXGBE_LINK_SPEED_25GB_FULL;
+		else
+			*speed = TXGBE_LINK_SPEED_10GB_FULL;
+		*autoneg = true;
+	}
+
+	return 0;
+}
+
+u32 txgbe_get_media_type_aml(struct txgbe_hw *hw)
+{
+	u8 device_type = hw->subsystem_device_id & 0xF0;
+	enum txgbe_media_type media_type;
+
+	switch (device_type) {
+	case TXGBE_DEV_ID_KR_KX_KX4:
+		media_type = txgbe_media_type_backplane;
+		break;
+	case TXGBE_DEV_ID_SFP:
+		media_type = txgbe_media_type_fiber;
+		break;
+	default:
+		media_type = txgbe_media_type_unknown;
+		break;
+	}
+
+	return media_type;
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
+	   !(speed == TXGBE_LINK_SPEED_25GB_FULL))
+		return status;
+
+	rte_spinlock_lock(&hw->phy_lock);
+	ret_status = 0;
+	rte_spinlock_unlock(&hw->phy_lock);
+
+	if (ret_status == TXGBE_ERR_PHY_INIT_NOT_DONE)
+		return status;
+
+	for (i = 0; i < 4; i++) {
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+		if (link_up)
+			return status;
+		msleep(250);
+		}
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
+		if (link_speed == TXGBE_LINK_SPEED_25GB_FULL && link_up)
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
+		/* Aml wait link in setup, no need to repeatedly wait */
+		/* If we have link, just jump out */
+		txgbe_e56_check_phy_link(hw, &link_speed, &link_up);
+
+		if (link_up)
+			goto out;
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
+		if (link_speed == TXGBE_LINK_SPEED_10GB_FULL && link_up)
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
+		/* Aml wait link in setup, no need to repeatedly wait */
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
diff --git a/drivers/net/txgbe/base/txgbe_aml.h b/drivers/net/txgbe/base/txgbe_aml.h
new file mode 100644
index 0000000000..18f683a746
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml.h
@@ -0,0 +1,21 @@
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
+#endif /* _TXGBE_AML_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_aml40.c b/drivers/net/txgbe/base/txgbe_aml40.c
new file mode 100644
index 0000000000..d11773916b
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml40.c
@@ -0,0 +1,126 @@
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
+#include "txgbe_aml40.h"
+
+void txgbe_init_ops_aml40(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	txgbe_init_ops_generic(hw);
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_aml40;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_aml40;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_aml40;
+	mac->check_link = txgbe_check_mac_link_aml40;
+}
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
+		if ((links_reg & TXGBE_CFG_PORT_ST_AML_LINK_40G) ==
+			TXGBE_CFG_PORT_ST_AML_LINK_40G)
+			*speed = TXGBE_LINK_SPEED_40GB_FULL;
+	} else {
+		*speed = TXGBE_LINK_SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
+
+s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
+				      u32 *speed,
+				      bool *autoneg)
+{
+	if (hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core0 ||
+	    hw->phy.sfp_type == txgbe_qsfp_type_40g_cu_core1) {
+		*speed = TXGBE_LINK_SPEED_40GB_FULL;
+		*autoneg = false;
+	} else {
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
+	return 0;
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
diff --git a/drivers/net/txgbe/base/txgbe_aml40.h b/drivers/net/txgbe/base/txgbe_aml40.h
new file mode 100644
index 0000000000..f31360c899
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml40.h
@@ -0,0 +1,20 @@
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
+void txgbe_init_ops_aml40(struct txgbe_hw *hw);
+s32 txgbe_check_mac_link_aml40(struct txgbe_hw *hw,
+			       u32 *speed, bool *link_up, bool link_up_wait_to_complete);
+s32 txgbe_get_link_capabilities_aml40(struct txgbe_hw *hw,
+				      u32 *speed, bool *autoneg);
+u32 txgbe_get_media_type_aml40(struct txgbe_hw *hw);
+s32 txgbe_setup_mac_link_aml40(struct txgbe_hw *hw, u32 speed,
+			       bool autoneg_wait_to_complete);
+void txgbe_init_mac_link_ops_aml40(struct txgbe_hw *hw);
+#endif /* _TXGBE_AML40_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index 85dbbc5eff..b14ab90466 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -11,6 +11,8 @@
 #include "txgbe_eeprom.h"
 #include "txgbe_mng.h"
 #include "txgbe_hw.h"
+#include "txgbe_aml.h"
+#include "txgbe_aml40.h"
 
 #define TXGBE_RAPTOR_MAX_TX_QUEUES 128
 #define TXGBE_RAPTOR_MAX_RX_QUEUES 128
@@ -1906,7 +1908,7 @@ static bool txgbe_need_crosstalk_fix(struct txgbe_hw *hw)
  *
  *  Reads the links register to determine if link is up and the current speed
  **/
-s32 txgbe_check_mac_link(struct txgbe_hw *hw, u32 *speed,
+s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw, u32 *speed,
 				 bool *link_up, bool link_up_wait_to_complete)
 {
 	u32 links_reg, links_orig;
@@ -2459,7 +2461,7 @@ s32 txgbe_setup_mac_link_multispeed_fiber(struct txgbe_hw *hw,
  **/
 s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 {
-	s32 status;
+	s32 status = 0;
 
 	/*
 	 * Set the mac type
@@ -2469,11 +2471,16 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	txgbe_init_ops_dummy(hw);
 	switch (hw->mac.type) {
 	case txgbe_mac_raptor:
+		txgbe_init_ops_sp(hw);
+		break;
 	case txgbe_mac_aml:
+		txgbe_init_ops_aml(hw);
+		break;
 	case txgbe_mac_aml40:
-		status = txgbe_init_ops_pf(hw);
+		txgbe_init_ops_aml40(hw);
 		break;
 	case txgbe_mac_raptor_vf:
+	case txgbe_mac_aml_vf:
 		status = txgbe_init_ops_vf(hw);
 		break;
 	default:
@@ -2539,7 +2546,7 @@ s32 txgbe_set_mac_type(struct txgbe_hw *hw)
 	return err;
 }
 
-void txgbe_init_mac_link_ops(struct txgbe_hw *hw)
+void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw)
 {
 	struct txgbe_mac_info *mac = &hw->mac;
 
@@ -2599,7 +2606,7 @@ s32 txgbe_init_phy_raptor(struct txgbe_hw *hw)
 		goto init_phy_ops_out;
 
 	/* Setup function pointers based on detected SFP module and speeds */
-	txgbe_init_mac_link_ops(hw);
+	hw->mac.init_mac_link_ops(hw);
 
 	/* If copper media, overwrite with copper function pointers */
 	if (phy->media_type == txgbe_media_type_copper) {
@@ -2634,7 +2641,7 @@ s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw)
 	if (hw->phy.sfp_type == txgbe_sfp_type_unknown)
 		return 0;
 
-	txgbe_init_mac_link_ops(hw);
+	hw->mac.init_mac_link_ops(hw);
 
 	/* PHY config will finish before releasing the semaphore */
 	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
@@ -2781,7 +2788,7 @@ s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data)
  *  Initialize the function pointers and assign the MAC type.
  *  Does not touch the hardware.
  **/
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
+s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 {
 	struct txgbe_bus_info *bus = &hw->bus;
 	struct txgbe_mac_info *mac = &hw->mac;
@@ -2793,7 +2800,6 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
 	bus->set_lan_id = txgbe_set_lan_id_multi_port;
 
 	/* PHY */
-	phy->get_media_type = txgbe_get_media_type_raptor;
 	phy->identify = txgbe_identify_phy;
 	phy->init = txgbe_init_phy_raptor;
 	phy->read_reg = txgbe_read_phy_reg;
@@ -2861,8 +2867,6 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
 	mac->fc_autoneg = txgbe_fc_autoneg;
 
 	/* Link */
-	mac->get_link_capabilities = txgbe_get_link_capabilities_raptor;
-	mac->check_link = txgbe_check_mac_link;
 	mac->setup_pba = txgbe_set_pba;
 
 	/* Manageability interface */
@@ -2901,6 +2905,22 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
 	return 0;
 }
 
+void txgbe_init_ops_sp(struct txgbe_hw *hw)
+{
+	struct txgbe_mac_info *mac = &hw->mac;
+	struct txgbe_phy_info *phy = &hw->phy;
+
+	txgbe_init_ops_generic(hw);
+
+	/* PHY */
+	phy->get_media_type = txgbe_get_media_type_sp;
+
+	/* LINK */
+	mac->init_mac_link_ops = txgbe_init_mac_link_ops_sp;
+	mac->get_link_capabilities = txgbe_get_link_capabilities_sp;
+	mac->check_link = txgbe_check_mac_link_sp;
+}
+
 /**
  *  txgbe_get_link_capabilities_raptor - Determines link capabilities
  *  @hw: pointer to hardware structure
@@ -2909,7 +2929,7 @@ s32 txgbe_init_ops_pf(struct txgbe_hw *hw)
  *
  *  Determines the link capabilities by reading the AUTOC register.
  **/
-s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
+s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
 				      u32 *speed,
 				      bool *autoneg)
 {
@@ -3015,7 +3035,7 @@ s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
  *
  *  Returns the media type (fiber, copper, backplane)
  **/
-u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw)
+u32 txgbe_get_media_type_sp(struct txgbe_hw *hw)
 {
 	u32 media_type;
 
@@ -3849,3 +3869,37 @@ s32 txgbe_reset_pipeline_raptor(struct txgbe_hw *hw)
 	return err;
 }
 
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
+	if (rdata & TXGBE_AML_PHY_LINK_UP)
+		*link_up = true;
+	else
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
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 1ed2892f61..476a9688bd 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -56,7 +56,7 @@ s32 txgbe_set_vlvf(struct txgbe_hw *hw, u32 vlan, u32 vind,
 s32 txgbe_clear_vfta(struct txgbe_hw *hw);
 s32 txgbe_find_vlvf_slot(struct txgbe_hw *hw, u32 vlan, bool vlvf_bypass);
 
-s32 txgbe_check_mac_link(struct txgbe_hw *hw,
+s32 txgbe_check_mac_link_sp(struct txgbe_hw *hw,
 			       u32 *speed,
 			       bool *link_up, bool link_up_wait_to_complete);
 
@@ -86,10 +86,11 @@ s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
-s32 txgbe_init_ops_pf(struct txgbe_hw *hw);
-s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
+s32 txgbe_init_ops_generic(struct txgbe_hw *hw);
+void txgbe_init_ops_sp(struct txgbe_hw *hw);
+s32 txgbe_get_link_capabilities_sp(struct txgbe_hw *hw,
 				      u32 *speed, bool *autoneg);
-u32 txgbe_get_media_type_raptor(struct txgbe_hw *hw);
+u32 txgbe_get_media_type_sp(struct txgbe_hw *hw);
 void txgbe_disable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
 void txgbe_enable_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
 void txgbe_flap_tx_laser_multispeed_fiber(struct txgbe_hw *hw);
@@ -103,7 +104,7 @@ s32 txgbe_start_mac_link_raptor(struct txgbe_hw *hw,
 s32 txgbe_setup_mac_link(struct txgbe_hw *hw, u32 speed,
 			       bool autoneg_wait_to_complete);
 s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw);
-void txgbe_init_mac_link_ops(struct txgbe_hw *hw);
+void txgbe_init_mac_link_ops_sp(struct txgbe_hw *hw);
 s32 txgbe_reset_hw(struct txgbe_hw *hw);
 s32 txgbe_start_hw_raptor(struct txgbe_hw *hw);
 s32 txgbe_init_phy_raptor(struct txgbe_hw *hw);
@@ -114,4 +115,6 @@ s32 txgbe_reinit_fdir_tables(struct txgbe_hw *hw);
 bool txgbe_verify_lesm_fw_enabled_raptor(struct txgbe_hw *hw);
 s32 txgbe_fmgr_cmd_op(struct txgbe_hw *hw, u32 cmd, u32 cmd_addr);
 s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data);
+s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
+				bool *link_up);
 #endif /* _TXGBE_HW_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index 03c517f055..4777b0335b 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1577,6 +1577,15 @@ enum txgbe_5tuple_protocol {
 #define     TXGBE_PORTSTAT_BW_100M      MS(3, 0x1)
 #define   TXGBE_PORTSTAT_ID(r)          RS(r, 8, 0x1)
 
+/* amlite: diff from sapphire */
+#define TXGBE_CFG_PORT_ST_AML_LINK_MASK     MS(1, 0xF)
+#define TXGBE_CFG_PORT_ST_AML_LINK_10G      MS(4, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_25G      MS(3, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_40G      MS(2, 0x1)
+#define TXGBE_CFG_PORT_ST_AML_LINK_50G      MS(1, 0x1)
+
+#define TXGBE_AML_PHY_LINK_UP               MS(2, 0x1)
+
 #define TXGBE_VXLAN                     0x014410
 #define TXGBE_VXLAN_GPE                 0x014414
 #define TXGBE_GENEVE                    0x014418
diff --git a/drivers/net/txgbe/base/txgbe_type.h b/drivers/net/txgbe/base/txgbe_type.h
index b6dce31473..8eeea54f98 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -551,6 +551,7 @@ struct txgbe_mac_info {
 	s32 (*prot_autoc_read)(struct txgbe_hw *hw, bool *locked, u64 *value);
 	s32 (*prot_autoc_write)(struct txgbe_hw *hw, bool locked, u64 value);
 	s32 (*negotiate_api_version)(struct txgbe_hw *hw, int api);
+	void (*init_mac_link_ops)(struct txgbe_hw *hw);
 
 	/* Link */
 	void (*disable_tx_laser)(struct txgbe_hw *hw);
@@ -834,6 +835,7 @@ struct txgbe_hw {
 		u64 rx_qp_mc_packets;
 	} qp_last[TXGBE_MAX_QP];
 
+	rte_spinlock_t phy_lock;
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
 	rte_atomic32_t swfw_busy;
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 2431057485..e6b7775f3a 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3068,6 +3068,14 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
 	case TXGBE_LINK_SPEED_10GB_FULL:
 		link.link_speed = RTE_ETH_SPEED_NUM_10G;
 		break;
+
+	case TXGBE_LINK_SPEED_25GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_25G;
+		break;
+
+	case TXGBE_LINK_SPEED_40GB_FULL:
+		link.link_speed = RTE_ETH_SPEED_NUM_40G;
+		break;
 	}
 
 	/* Re configure MAC RX */
-- 
2.21.0.windows.1

