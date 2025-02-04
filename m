Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C58C02197
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92B31427A7;
	Tue,  4 Feb 2025 16:12:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 20FF54275B
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681907; x=1770217907;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q6KmfjXljdP/cD2FqfDl4YxBmD6CSvczlgaaRu2z+3w=;
 b=YNFjv6kkBBQ9g8mkWV9ROi6vpWn/sLEkXNacZrRPIdpvV5puxbyPHwuz
 3a2L5eQWXwMoYQ7zujy5fVk8aVdsyNVF6Rw3amYixKplavcDoHRAyQDkB
 ubQLyPgYyAEI/KML7jmZqS3d7feGYgSWguZ+rWGUXQ0PZDOZnN7GPSPJj
 kFnkpmTNjOZZ9Lamuq0RyDx/PWmeNHcIuvLAFOV9ce9GSxgQByva2wrgT
 hO68UPb+mLwvQUSXfUCrHd902dzvD9HkJ8eJ4svtPSaBPXPqKC4yNJoiw
 TY/ClnzBm93d4+DfUTzmp/c2eB0UbgeoGB7lopwTdQJn5auAEtOOjfhkO g==;
X-CSE-ConnectionGUID: EpxOvwE2T++8GUBbPP5fDg==
X-CSE-MsgGUID: pFAS4Aa7TNWsyy8CXMw1ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097115"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097115"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:46 -0800
X-CSE-ConnectionGUID: uRiCDndSRWyHQ8Nl7xJZDg==
X-CSE-MsgGUID: 6QY5Z4hWT+eQzeHTn9fqhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792622"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:44 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 14/54] net/e1000/base: add LED blink support for i225
Date: Tue,  4 Feb 2025 15:10:20 +0000
Message-ID: <2bca48a34db2ac82ef3d43fa50bcd286d41a8bf1.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

Signed-off-by: Fogel Menachem <menachem.fogel@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 44 +++++++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h |  8 +++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index a6f113608b..a2d4faa0a9 100644
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
 
@@ -1213,6 +1218,45 @@ s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active)
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

