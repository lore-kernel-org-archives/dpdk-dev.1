Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C1ACCA468
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 10:00:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F7D340BA6;
	Tue, 30 Sep 2025 12:00:33 +0200 (CEST)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
 by mails.dpdk.org (Postfix) with ESMTP id E6DF8406B8
 for <dev@dpdk.org>; Tue, 30 Sep 2025 12:00:31 +0200 (CEST)
X-QQ-mid: esmtpgz13t1759226428t40bf64e2
X-QQ-Originating-IP: q4OxtwBWU+amVE8QMRZ1oiyFhCmV6Kf962UeYM4B7+U=
Received: from DSK-zaiyuwang.trustnetic.com ( [115.220.225.164])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 30 Sep 2025 18:00:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3895156737126014456
EX-QQ-RecipientCnt: 4
From: Zaiyu Wang <zaiyuwang@trustnetic.com>
To: dev@dpdk.org
Cc: Zaiyu Wang <zaiyuwang@trustnetic.com>, Jiawen Wu <jiawenwu@trustnetic.com>,
 Jian Wang <jianwang@trustnetic.com>
Subject: [PATCH v4 05/20] net/txgbe: add basic link configuration for
 Amber-Lite NICs
Date: Tue, 30 Sep 2025 17:59:37 +0800
Message-Id: <20250930095953.18508-6-zaiyuwang@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20250930095953.18508-1-zaiyuwang@trustnetic.com>
References: <20250418094131.24136-1-zaiyuwang@trustnetic.com>
 <20250930095953.18508-1-zaiyuwang@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: NGHdgOcrWZQ9LlMyySY/GRzIIIEKkD7jDV3TPnt6B0rYCmDZQ8Rd6Dkn
 tU6WJHRKR/jmMd0jTxDXKHTk7cvdVs5/l4MiuMgOjaUnSBrjyWEvryFmSF0GFYXRXBDdl9L
 4zK0H9+Dhe3BocypGA35AvR8hzqwUXZUfV/PH76sI62dl4Vw60Qp2w2QEZzTai+TEt6g4yO
 RLCK/9tsUjS+MuUIr9XQaeK3MP46rO5Z/y62A/C5FeTcDpU8DYBYj5Ij6gB1OQk8G0+SRUs
 +NV45ImHO33zwNIVBAo8/R2I3MeJGO3kOe2UXhM2AmkiLLC3ThmDwOg5gTPKfR7yf/h1bNj
 KaigO95sXP0EmUM7KDlKTiMQrs8I/qQE4k5X14cdbYRLgZG60gASOoyZDHQE0Jw+5M07Zeu
 mfzED6c+iRQ3Bcrf9DkEibZcNanv2jQDhb9xBESp4ykgH7ZNHLIIllaXYGPiNUpivU0XZFT
 UMn9y0lmdS5lkoJvvuvBpzdzEJka1jf4xCAiOUpmcbtBJzp955EOk1b/PXfDc7kX/gZkIHR
 CB+yQXEQ4XHW0G+8xGISnUAGlbU6lyCVYklWzjw05GGyq8b6H52N/nZM0MtPs7Tmdzoa2Rt
 myc+IPSIj/IGykrkajhf2GnE4C0cBiW/e2p/LG5MKZ6Z6tkfbNXrOH4NFUmGtkmFrt4WPU9
 6e75HI/OGcmgH0Mdn4pN/k0adNTp79l5DgGvxZuAniXTzwipdJmM5IUVHayTUbWcYKLygRL
 ERdiO8g/T651RHFszUO89UZ3ofviGlhGWgfLdf0tE1EYt8p36VPOXMncWqJB9N5OpnSHEZI
 aF0yV5G29JemD9UCN7h9fGUVL4swzqxAAjUlQyE87Wg4WD130DycnuGyQYGviwitScSYwEG
 vQeg3t2KF3kI+wqpdvqq//ITgggTpv5KbtuQR8NX6ocskthZ/c/sEWFajVpDd+43YEWG7ra
 zhiiVeVq0YCaB2nZZnMjHrVAwpYNIuwE3uYtUmP8hOTZAaCMqf8Alo+cl87NLvIIOmmxSQt
 w+MrOdL8hSQisMmG4AGdnDNDkt6yDPpG1SAtRnUvJ7UDVlVB3ZwPhcr+unPWgKB442Ysl5+
 i25Mpqk2YXBv53ZmN+ak8w=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
 drivers/net/txgbe/base/txgbe_aml.c   | 296 +++++++++++++++++++++++++++
 drivers/net/txgbe/base/txgbe_aml.h   |  21 ++
 drivers/net/txgbe/base/txgbe_aml40.c | 126 ++++++++++++
 drivers/net/txgbe/base/txgbe_aml40.h |  20 ++
 drivers/net/txgbe/base/txgbe_hw.c    |  49 ++++-
 drivers/net/txgbe/base/txgbe_hw.h    |   2 +
 drivers/net/txgbe/base/txgbe_regs.h  |   9 +
 drivers/net/txgbe/base/txgbe_type.h  |   1 +
 drivers/net/txgbe/txgbe_ethdev.c     |   8 +
 10 files changed, 528 insertions(+), 6 deletions(-)
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
index 0000000000..b172622ac7
--- /dev/null
+++ b/drivers/net/txgbe/base/txgbe_aml.c
@@ -0,0 +1,296 @@
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
+	u32 link_speed = TXGBE_LINK_SPEED_UNKNOWN;
+	bool link_up = false;
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
+	 * software because 25Gb fiber doesn't support speed autonegotiation.
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
+		/* Allow module to change analog characteristics (10G -> 25G) */
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
index 81e686fdf1..1bfc07d930 100644
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
@@ -2466,7 +2468,7 @@ s32 txgbe_setup_mac_link_multispeed_fiber(struct txgbe_hw *hw,
  **/
 s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 {
-	s32 status;
+	s32 status = 0;
 
 	/*
 	 * Set the mac type
@@ -2479,9 +2481,13 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 		txgbe_init_ops_sp(hw);
 		break;
 	case txgbe_mac_aml:
+		txgbe_init_ops_aml(hw);
+		break;
 	case txgbe_mac_aml40:
+		txgbe_init_ops_aml40(hw);
 		break;
 	case txgbe_mac_sp_vf:
+	case txgbe_mac_aml_vf:
 		status = txgbe_init_ops_vf(hw);
 		break;
 	default:
@@ -2617,7 +2623,7 @@ s32 txgbe_init_phy_raptor(struct txgbe_hw *hw)
 		goto init_phy_ops_out;
 
 	/* Setup function pointers based on detected SFP module and speeds */
-	txgbe_init_mac_link_ops_sp(hw);
+	hw->mac.init_mac_link_ops(hw);
 
 	/* If copper media, overwrite with copper function pointers */
 	if (phy->media_type == txgbe_media_type_copper) {
@@ -2652,7 +2658,7 @@ s32 txgbe_setup_sfp_modules(struct txgbe_hw *hw)
 	if (hw->phy.sfp_type == txgbe_sfp_type_unknown)
 		return 0;
 
-	txgbe_init_mac_link_ops_sp(hw);
+	hw->mac.init_mac_link_ops(hw);
 
 	/* PHY config will finish before releasing the semaphore */
 	err = hw->mac.acquire_swfw_sync(hw, TXGBE_MNGSEM_SWPHY);
@@ -2811,7 +2817,6 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	bus->set_lan_id = txgbe_set_lan_id_multi_port;
 
 	/* PHY */
-	phy->get_media_type = txgbe_get_media_type_raptor;
 	phy->identify = txgbe_identify_phy;
 	phy->init = txgbe_init_phy_raptor;
 	phy->read_reg = txgbe_read_phy_reg;
@@ -2879,8 +2884,6 @@ s32 txgbe_init_ops_generic(struct txgbe_hw *hw)
 	mac->fc_autoneg = txgbe_fc_autoneg;
 
 	/* Link */
-	mac->get_link_capabilities = txgbe_get_link_capabilities_raptor;
-	mac->check_link = txgbe_check_mac_link;
 	mac->setup_pba = txgbe_set_pba;
 
 	/* Manageability interface */
@@ -3886,3 +3889,37 @@ s32 txgbe_reset_pipeline_raptor(struct txgbe_hw *hw)
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
index 62c027c850..7afc800f8d 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -116,4 +116,6 @@ s32 txgbe_reinit_fdir_tables(struct txgbe_hw *hw);
 bool txgbe_verify_lesm_fw_enabled_raptor(struct txgbe_hw *hw);
 s32 txgbe_fmgr_cmd_op(struct txgbe_hw *hw, u32 cmd, u32 cmd_addr);
 s32 txgbe_flash_read_dword(struct txgbe_hw *hw, u32 addr, u32 *data);
+s32 txgbe_e56_check_phy_link(struct txgbe_hw *hw, u32 *speed,
+				bool *link_up);
 #endif /* _TXGBE_HW_H_ */
diff --git a/drivers/net/txgbe/base/txgbe_regs.h b/drivers/net/txgbe/base/txgbe_regs.h
index ab1a11230c..5709245068 100644
--- a/drivers/net/txgbe/base/txgbe_regs.h
+++ b/drivers/net/txgbe/base/txgbe_regs.h
@@ -1581,6 +1581,15 @@ enum txgbe_5tuple_protocol {
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
index 4d825bec44..8be0c6cd57 100644
--- a/drivers/net/txgbe/base/txgbe_type.h
+++ b/drivers/net/txgbe/base/txgbe_type.h
@@ -828,6 +828,7 @@ struct txgbe_hw {
 		u64 rx_qp_mc_packets;
 	} qp_last[TXGBE_MAX_QP];
 
+	rte_spinlock_t phy_lock;
 	/*amlite: new SW-FW mbox */
 	u8 swfw_index;
 	rte_atomic32_t swfw_busy;
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 82cec488f4..0e2f25ad76 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -3069,6 +3069,14 @@ txgbe_dev_link_update_share(struct rte_eth_dev *dev,
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

