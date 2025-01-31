Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F4C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB02A427AC;
	Fri, 31 Jan 2025 13:59:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6229F427D3
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328366; x=1769864366;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZcZXai6ZiID9ORNjZd5koOOB2FeLbS5Yw5E4QYBkkcI=;
 b=SQ54vEa+7izG+SnXlRST93gKHAZ46fWIqqHEKTTn/waQ/mz9ol0V6for
 COZ7ROBpY2vRgvw5DxdThBqvYoISZPIXkagmUkcFPyWeuLet/Ba7JxGVT
 Cw03xrnmvH+gglfxs7vMIP/bXKDl5EumnWQfL/3UeIbo3ehDGJzlv1YB5
 vxSsQKi1SvykqR4mCaN8zH4B0zTUiA8dVZo6KdtsdHNmhozlRepG7NjLK
 B9sWPsSdBGiYFMW4uzLmf1W9gkF92uRyDyVmWAwTTFYq9i3xDEbH03Ggc
 xFUAFcR00HQCODvbXSVymiW7l6Kfyqv43pQp06kW3ouVqdaL/RSGHr6ly A==;
X-CSE-ConnectionGUID: wQXYEZtGQpiEzPj2Q481Tg==
X-CSE-MsgGUID: epkD5315SqSRajL/0akriQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315611"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315611"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:25 -0800
X-CSE-ConnectionGUID: e8ssOn5TSVGb9CeGeBRlJA==
X-CSE-MsgGUID: FD8Y7vywTgWGf8KkgLzcvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503349"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 04/42] net/e1000/base: add LED blink support for i225
Date: Fri, 31 Jan 2025 12:58:17 +0000
Message-ID: <0a8a6cb83ff43ace5fba3fb194167213153a88bb.1738328107.git.anatoly.burakov@intel.com>
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

Add LED blink support for i225 series NICs. This is mostly identical to
IGC driver, with some minor differences due to the way IGC driver was
originally generated.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 44 +++++++++++++++++++++++
 drivers/net/intel/e1000/base/e1000_i225.h | 15 ++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index ccabfdca83..a7a42e2f0e 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -50,6 +50,11 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 
 	mac->ops.write_vfta = e1000_write_vfta_generic;
 
+	/* LED */
+	mac->ops.cleanup_led = e1000_cleanup_led_generic;
+	mac->ops.id_led_init = e1000_id_led_init_i225;
+	mac->ops.blink_led = e1000_blink_led_i225;
+
 	return E1000_SUCCESS;
 }
 
@@ -316,3 +321,42 @@ s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active)
 	E1000_WRITE_REG(hw, E1000_I225_PHPM, data);
 	return E1000_SUCCESS;
 }
+
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
diff --git a/drivers/net/intel/e1000/base/e1000_i225.h b/drivers/net/intel/e1000/base/e1000_i225.h
index fd79f08216..03e0f4fb89 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.h
+++ b/drivers/net/intel/e1000/base/e1000_i225.h
@@ -5,9 +5,24 @@
 #ifndef _E1000_I225_H_
 #define _E1000_I225_H_
 
+s32 e1000_id_led_init_i225(struct e1000_hw *hw);
+s32 e1000_blink_led_i225(struct e1000_hw *hw);
 s32 e1000_init_hw_i225(struct e1000_hw *hw);
 s32 e1000_setup_copper_link_i225(struct e1000_hw *hw);
 s32 e1000_set_d0_lplu_state_i225(struct e1000_hw *hw, bool active);
 s32 e1000_set_d3_lplu_state_i225(struct e1000_hw *hw, bool active);
 
+#define ID_LED_DEFAULT_I225		((ID_LED_OFF1_ON2  << 8) | \
+					 (ID_LED_DEF1_DEF2 <<  4) | \
+					 (ID_LED_OFF1_OFF2))
+#define ID_LED_DEFAULT_I225_SERDES	((ID_LED_DEF1_DEF2 << 8) | \
+					 (ID_LED_DEF1_DEF2 <<  4) | \
+					 (ID_LED_OFF1_ON2))
+
+/* LED Control */
+#define E1000_GLOBAL_BLINK_MODE	0x00000020 /*Blink at 200 ms on and 200 ms off.*/
+#define E1000_LED1_MODE_MASK	0x00000F00
+#define E1000_LED1_BLINK	0x00008000
+#define E1000_LED2_MODE_MASK	0x000F0000
+
 #endif
-- 
2.43.5

