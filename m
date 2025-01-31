Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF2C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6FDC42D97;
	Fri, 31 Jan 2025 13:59:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E8763427E9
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328370; x=1769864370;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0ZrXI/nfu3ZvqxwqgRzfG5gj/W0OWQzSxyCTgKrYC8c=;
 b=HA8awSARJavvhv2DFPIkUNk1bCIQoJBSJM2TERGVDQa7YQOAwNHTUYed
 VMLJ/LBv2FSCHPfhWGdmp804hHHJo2e5oYqKtANKeGhbSVc8HXumv0wwH
 1du3iAo2ErzDY8zn478fX6xVy/cHOVRyFYTvSor51G1/KsjhChRQM98So
 hzI8kr36trVGHOnMutT3J3o7KLNZr7Jk9cYWRMjCUrd/6mV3VKDg+mQNn
 XrnrGpIsNIPG9ja9tCgXwvgY/JhGxdfgXkl3DloNP+2Ii7Tx+FupSwir7
 LskrlMvkWOB18AjdhYMxzEw2jV7ow6/3EmWuY4qtvfSN4SwXcOfsY42L6 A==;
X-CSE-ConnectionGUID: zzqoY0TBSUaqZ9ujHCaKfg==
X-CSE-MsgGUID: hccDffiLTYSGQloeiAFtfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315618"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315618"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:29 -0800
X-CSE-ConnectionGUID: W3WDx432TTmGWPlXJADcoA==
X-CSE-MsgGUID: aPa/awUJRc2hMwPti2hoaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503357"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 07/42] net/e1000/base: add eee support for i225
Date: Fri, 31 Jan 2025 12:58:20 +0000
Message-ID: <6b15c0cedca9c07738811033637709c3343012d3.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add EEE advertising support for i225 series NICs. This is mostly
identical to IGC driver, with some minor differences due to the way IGC
driver was originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  9 +++
 drivers/net/intel/e1000/base/e1000_i225.c    | 68 ++++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h    |  2 +
 drivers/net/intel/e1000/base/e1000_regs.h    |  1 +
 4 files changed, 80 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 10009d7a19..a32100195a 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -863,6 +863,15 @@
 #define E1000_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
 #define E1000_EEE_LP_ADV_DEV_I210	7          /* EEE LP Adv Device */
 #define E1000_EEE_LP_ADV_ADDR_I210	61         /* EEE LP Adv Register */
+#define E1000_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
+#define E1000_EEE_LP_ADV_DEV_I225	7          /* EEE LP Adv Device */
+#define E1000_EEE_LP_ADV_ADDR_I225	61         /* EEE LP Adv Register */
+#define E1000_EEE_LP_ADV_2_5G           0          /* EEE LP Adv 2.5G */
+#define E1000_EEE_LP_ADV_1G             2          /* EEE LP Adv 1G */
+#define E1000_EEE_LP_ADV_100M           1          /* EEE LP Adv 100M */
+#define E1000_ANEG_EEE_AN_LPAB1_I225    26         /* EEE LP Ability 1 Offset */
+#define E1000_ANEG_EEE_AN_LPAB2_I225    0x2A       /* EEE LP Ability 2 Offset */
+
 /* PCI Express Control */
 #define E1000_GCR_RXD_NO_SNOOP		0x00000001
 #define E1000_GCR_RXDSCW_NO_SNOOP	0x00000002
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 9a512f3baf..067ec8924d 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -128,6 +128,9 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->ops.id_led_init = e1000_id_led_init_i225;
 	mac->ops.blink_led = e1000_blink_led_i225;
 
+	/* Disable EEE by default */
+	dev_spec->eee_disable = true;
+
 	return E1000_SUCCESS;
 }
 
@@ -1183,6 +1186,7 @@ s32 e1000_init_hw_i225(struct e1000_hw *hw)
 
 	hw->phy.ops.get_cfg_done = e1000_get_cfg_done_i225;
 	ret_val = e1000_init_hw_base(hw);
+	e1000_set_eee_i225(hw, false, false, false);
 	return ret_val;
 }
 
@@ -1282,3 +1286,67 @@ s32 e1000_id_led_init_i225(struct e1000_hw *hw)
 
 	return E1000_SUCCESS;
 }
+
+/**
+ *  e1000_set_eee_i225 - Enable/disable EEE support
+ *  @hw: pointer to the HW structure
+ *  @adv2p5G: boolean flag enabling 2.5G EEE advertisement
+ *  @adv1G: boolean flag enabling 1G EEE advertisement
+ *  @adv100M: boolean flag enabling 100M EEE advertisement
+ *
+ *  Enable/disable EEE based on setting in dev_spec structure.
+ *
+ **/
+s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
+		       bool adv100M)
+{
+	u32 ipcnfg, eeer;
+
+	DEBUGFUNC("e1000_set_eee_i225");
+
+	if (hw->mac.type != e1000_i225 ||
+	    hw->phy.media_type != e1000_media_type_copper)
+		goto out;
+	ipcnfg = E1000_READ_REG(hw, E1000_IPCNFG);
+	eeer = E1000_READ_REG(hw, E1000_EEER);
+
+	/* enable or disable per user setting */
+	if (!(hw->dev_spec._i225.eee_disable)) {
+		u32 eee_su = E1000_READ_REG(hw, E1000_EEE_SU);
+
+		if (adv100M)
+			ipcnfg |= E1000_IPCNFG_EEE_100M_AN;
+		else
+			ipcnfg &= ~E1000_IPCNFG_EEE_100M_AN;
+
+		if (adv1G)
+			ipcnfg |= E1000_IPCNFG_EEE_1G_AN;
+		else
+			ipcnfg &= ~E1000_IPCNFG_EEE_1G_AN;
+
+		if (adv2p5G)
+			ipcnfg |= E1000_IPCNFG_EEE_2_5G_AN;
+		else
+			ipcnfg &= ~E1000_IPCNFG_EEE_2_5G_AN;
+
+		eeer |= (E1000_EEER_TX_LPI_EN | E1000_EEER_RX_LPI_EN |
+			E1000_EEER_LPI_FC);
+
+		/* This bit should not be set in normal operation. */
+		if (eee_su & E1000_EEE_SU_LPI_CLK_STP)
+			DEBUGOUT("LPI Clock Stop Bit should not be set!\n");
+	} else {
+		ipcnfg &= ~(E1000_IPCNFG_EEE_2_5G_AN | E1000_IPCNFG_EEE_1G_AN |
+			E1000_IPCNFG_EEE_100M_AN);
+		eeer &= ~(E1000_EEER_TX_LPI_EN | E1000_EEER_RX_LPI_EN |
+			E1000_EEER_LPI_FC);
+	}
+	E1000_WRITE_REG(hw, E1000_IPCNFG, ipcnfg);
+	E1000_WRITE_REG(hw, E1000_EEER, eeer);
+	E1000_READ_REG(hw, E1000_IPCNFG);
+	E1000_READ_REG(hw, E1000_EEER);
+out:
+
+	return E1000_SUCCESS;
+}
+
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index cd6e7d0f6f..d9e02383c3 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -27,6 +27,8 @@ s32 e1000_init_hw_i225(struct e1000_hw *hw);
 s32 e1000_setup_copper_link_i225(struct e1000_hw *hw);
 s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active);
 s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active);
+s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
+		       bool adv100M);
 
 #define ID_LED_DEFAULT_I225		((ID_LED_OFF1_ON2  << 8) | \
 					 (ID_LED_DEF1_DEF2 <<  4) | \
diff --git a/drivers/net/intel/e1000/base/e1000_regs.h b/drivers/net/intel/e1000/base/e1000_regs.h
index 04bb94f819..3a4779f80b 100644
--- a/drivers/net/intel/e1000/base/e1000_regs.h
+++ b/drivers/net/intel/e1000/base/e1000_regs.h
@@ -688,6 +688,7 @@
 #define E1000_LTRC	0x01A0 /* Latency Tolerance Reporting Control */
 #define E1000_EEER	0x0E30 /* Energy Efficient Ethernet "EEE"*/
 #define E1000_EEE_SU	0x0E34 /* EEE Setup */
+#define E1000_EEE_SU_2P5	0x0E3C /* EEE 2.5G Setup */
 #define E1000_TLPIC	0x4148 /* EEE Tx LPI Count - TLPIC */
 #define E1000_RLPIC	0x414C /* EEE Rx LPI Count - RLPIC */
 
-- 
2.43.5

