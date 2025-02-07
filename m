Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8FCC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:48:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3404F42EA1;
	Fri,  7 Feb 2025 13:46:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 8C0B642E4C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932384; x=1770468384;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wwoEvfKGF+I7+P3IjkDHruwWOc7gdoxGS+K1khBq0yI=;
 b=dsR1nFIYNAgNkjpc9RyBEU6xsU9TndMYr9R1zJ4yDFmMORQ3NRamSd79
 ijzVymN5JgkU1SYsQlT1qsPNfHhF+a5gGz+CFvWxETq6e5328kQ3yJt9Z
 HWNQbMZykDPdXdvyhv+ExB50YQysRG8nJGzFIjisDl3giBegWVmd/F1cN
 6C1mJONUmNFYGEdNEQfXA2BPLODo2Papl8JeaaQfS1sctKVL448iZ0gzH
 swMLeUmR3W9R82gFP0zjBfFtq0Cnyg1SXAtFOzzyqBQPH1NfE0lf1pm0L
 tBOxrN4xUjmWZxwoeSOwu1O6kUW3/F5ORfAeBwRuRRKoCMEBiRcmoh/26 g==;
X-CSE-ConnectionGUID: GI/Z3JqiRwK4FPsnpUmbyQ==
X-CSE-MsgGUID: cZH2hDWeQduleg4ukvXr6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331861"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331861"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:24 -0800
X-CSE-ConnectionGUID: LSyzNBPDQ6CHzxiHG0knhw==
X-CSE-MsgGUID: XkKx+8lGTTqk6kGh2FlXnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953758"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:22 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 25/36] net/e1000/base: use longer ULP exit timeout on more
 HW
Date: Fri,  7 Feb 2025 12:45:17 +0000
Message-ID: <2333ec9b90b1468ac642d005f23d889292e6bff9.1738932115.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

Add some definitions related to ULP WoL, and set longer ULP exit timeout on
more MAC types.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_hw.h      | 1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 2 +-
 drivers/net/intel/e1000/base/e1000_ich8lan.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 1b8292191a..0ab21ed669 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1021,6 +1021,7 @@ struct e1000_dev_spec_ich8lan {
 	u16 eee_lp_ability;
 	enum e1000_ulp_state ulp_state;
 	bool ulp_capability_disabled;
+	bool wake_on_ulp_exit;
 	bool during_suspend_flow;
 	bool during_dpg_exit;
 	u16 lat_enc;
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 57c724523c..0bb67ca621 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -1293,7 +1293,7 @@ s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
 			E1000_WRITE_REG(hw, E1000_H2ME, mac_reg);
 		}
 
-		if (hw->mac.type == e1000_pch_cnp)
+		if (hw->mac.type >= e1000_pch_cnp)
 			ulp_exit_timeout = 100;
 
 		while (E1000_READ_REG(hw, E1000_FWSM) &
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index 4780417bae..fbe118723c 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -48,6 +48,7 @@
 
 #define E1000_H2ME		0x05B50    /* Host to ME */
 #define E1000_H2ME_ULP		0x00000800 /* ULP Indication Bit */
+#define E1000_H2ME_HOST_WOL_ON_ULP_EXIT	0x00000008 /* Host WOL on ULP exit */
 #define E1000_H2ME_ENFORCE_SETTINGS	0x00001000 /* Enforce Settings */
 
 #define ID_LED_DEFAULT_ICH8LAN	((ID_LED_DEF1_DEF2 << 12) | \
-- 
2.43.5

