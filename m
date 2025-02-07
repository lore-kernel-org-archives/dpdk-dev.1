Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAF1C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF7C242E6D;
	Fri,  7 Feb 2025 13:46:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id D328442E72
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932371; x=1770468371;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=k0pwJ0cfO2iVD+urDEkAxzSa9mY8G6fhLu+lIXZzE5s=;
 b=SxZyS6dMuqN+1YLTCyXjfrWFC54yjg/wPjozOUYDIiUjqVHKH2WWIsgX
 dtqp+8Q3nUqZUtNYu9nYO0HIGi4OPJzxpAsTzx1Gr8rTKe2JGElefhK7c
 By+LciLO5MrRzbi5TF9pz/3AlQ2FCDfbFvz6yL8BUaH4aQdmSdUGPaop4
 CdPXxa0M5kJa+0noi7MdlrtO4OQ0zM6SA/qSi+ZgdrQrqL78D8Ktu/W19
 N+ifx/Q+FVydxWiHLDqM9aqeJUM/knpubydQVz+hSql9PMxIdUlEsHTiW
 BngKyxTo63fAgNRjMPgsiwoSkv1QJ+MnJJqfj/Plq/Ym1GkNJfWLKOrpE A==;
X-CSE-ConnectionGUID: ajVO9kMISMqLkvDIjQStbg==
X-CSE-MsgGUID: 7m3z58kSTEqWrmy6y+mUtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331830"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331830"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:11 -0800
X-CSE-ConnectionGUID: ZIkK8KPJTum31FOp9oc/Ww==
X-CSE-MsgGUID: DJNcQa2nQzW04hu53Pp8ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953612"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Thomas Monjalon <thomas@monjalon.net>
Subject: [PATCH v3 14/36] net/e1000/base: add LED blink support for i225
Date: Fri,  7 Feb 2025 12:45:06 +0000
Message-ID: <86b3dfd4dab01f3b545299271613a20bdede8412.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

From: Menachem Fogel <menachem.fogel@intel.com>

Implement LED blinking for i225.

Signed-off-by: Menachem Fogel <menachem.fogel@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                                  |  1 +
 drivers/net/intel/e1000/base/e1000_i225.c | 44 +++++++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h |  8 +++++
 3 files changed, 53 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8ffd20cba5..857af326e3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -991,6 +991,7 @@ Maxime Gouin <maxime.gouin@6wind.com>
 Maxime Leroy <maxime.leroy@6wind.com>
 Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
 Megha Ajmera <megha.ajmera@intel.com>
+Menachem Fogel <menachem.fogel@intel.com>
 Meijuan Zhao <meijuanx.zhao@intel.com>
 Meir Levi <mlevi4@marvell.com>
 Meir Tseitlin <mirots@gmail.com>
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index d9e3ab2cbc..7ea551014e 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -123,6 +123,11 @@ static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 
 	mac->ops.write_vfta = e1000_write_vfta_generic;
 
+	/* LED */
+	mac->ops.cleanup_led = e1000_cleanup_led_generic;
+	mac->ops.id_led_init = e1000_id_led_init_i225;
+	mac->ops.blink_led = e1000_blink_led_i225;
+
 	/* Disable EEE by default */
 	dev_spec->eee_disable = true;
 
@@ -1220,6 +1225,45 @@ s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active)
 	return E1000_SUCCESS;
 }
 
+/**
+ *  e1000_blink_led_i225 - Blink SW controllable LED
+ *  @hw: pointer to the HW structure
+ *
+ *  This starts the adapter LED blinking.
+ *  Request the LED to be setup first.
+ **/
+s32 e1000_blink_led_i225(struct e1000_hw *hw)
+{
+	u32 blink = 0;
+
+	DEBUGFUNC("e1000_blink_led_i225");
+
+	e1000_id_led_init_i225(hw);
+
+	blink = hw->mac.ledctl_default;
+	blink &= ~(E1000_GLOBAL_BLINK_MODE | E1000_LED1_MODE_MASK | E1000_LED2_MODE_MASK);
+	blink |= E1000_LED1_BLINK;
+
+	E1000_WRITE_REG(hw, E1000_LEDCTL, blink);
+
+	return E1000_SUCCESS;
+}
+
+/**
+ *  e1000_id_led_init_i225 - store LED configurations in SW
+ *  @hw: pointer to the HW structure
+ *
+ *  Initializes the LED config in SW.
+ **/
+s32 e1000_id_led_init_i225(struct e1000_hw *hw)
+{
+	DEBUGFUNC("e1000_id_led_init_i225");
+
+	hw->mac.ledctl_default = E1000_READ_REG(hw, E1000_LEDCTL);
+
+	return E1000_SUCCESS;
+}
+
 /**
  *  e1000_set_eee_i225 - Enable/disable EEE support
  *  @hw: pointer to the HW structure
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index ef4e646e02..61b049b1f4 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -17,6 +17,8 @@ s32 e1000_set_flsw_flash_burst_counter_i225(struct e1000_hw *hw,
 					    u32 burst_counter);
 s32 e1000_write_erase_flash_command_i225(struct e1000_hw *hw, u32 opcode,
 					 u32 address);
+s32 e1000_id_led_init_i225(struct e1000_hw *hw);
+s32 e1000_blink_led_i225(struct e1000_hw *hw);
 s32 e1000_check_for_link_i225(struct e1000_hw *hw);
 s32 e1000_acquire_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
 void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask);
@@ -105,4 +107,10 @@ s32 e1000_set_eee_i225(struct e1000_hw *hw, bool adv2p5G, bool adv1G,
 #define E1000_RXDADV_PKTTYPE_ETQF_MASK	0x00000070 /* ETQF has 8 indices */
 #define E1000_RXDADV_PKTTYPE_ETQF_SHIFT	4 /* Right-shift 4 bits */
 
+/* LED Control */
+#define E1000_GLOBAL_BLINK_MODE	0x00000020 /*Blink at 200 ms on and 200 ms off.*/
+#define E1000_LED1_MODE_MASK	0x00000F00
+#define E1000_LED1_BLINK	0x00008000
+#define E1000_LED2_MODE_MASK	0x000F0000
+
 #endif
-- 
2.43.5

