Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA72C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0643542ED2;
	Fri,  7 Feb 2025 13:46:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id A748142EB1
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932394; x=1770468394;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=k9Bw1pV/PLB6pzllVCiH9Lnq44I2/GORnRsPaR3LKgg=;
 b=OvoA4TdY4mobCVwsxzCT2o8a5JlRL3FfK6pH2crPYE8hnBqa5zbXfi2w
 OK93pUER7n4zODwvggwrdZ3ZVGXaU3YmwPQNQdYUzq+qoOvtGmZzoRBFY
 VkwxYm6pyL95mSO17LFs4sJ/+b6jk2OAmXZmCa1lj7FIgxMekEHBJ0+vx
 bjKO7uiyw1roWIM6XJY7I+q59Va0s3xQcT39616n+OaKwD39ria28Z6ir
 nDjxtzpf95u8VFJOrnjkTWTFxrRPE1gsvQXzHm+c2yKXvGKPCtpYEx2EI
 /+8nc+1OtZb+ewknMZpqpzTU/374NVubiMJLYuLeM4tUJ5MJ82KPXCPrK A==;
X-CSE-ConnectionGUID: gsHZmp2NRXm+d9RWdmKx1w==
X-CSE-MsgGUID: BcIUvW7pS2WvF5dop6cXaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331884"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331884"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:34 -0800
X-CSE-ConnectionGUID: fKn+ZQx/RiaeGFcHkRUa8g==
X-CSE-MsgGUID: tf+mKjL7T1SrO5rQN4GDhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953827"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 33/36] net/e1000/base: introduce PHY ID retry mechanism
Date: Fri,  7 Feb 2025 12:45:25 +0000
Message-ID: <09a7377cd3c670fb02c647eabd13b1e3cb0e081e.1738932115.git.anatoly.burakov@intel.com>
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

On some customer platforms it was observed that invalid PHY ID (0x0000) was
returned on first try. This patch introduces PHY ID retry mechanism to
perform retries on PHY ID read for up to a second. Because the original
code was intentionally not checking PHY ID due to a different issue, this
fix only checks if PHY ID is non-zero, but otherwise considers any PHY ID
as valid.

In addition, IEEE standard defines format of PHY ID, so extract these bits
from PHY ID value.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  1 +
 drivers/net/intel/e1000/base/e1000_hw.h      |  1 +
 drivers/net/intel/e1000/base/e1000_i225.c    | 44 +++++++++++++++++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 51bc5a069b..eb93675823 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1382,6 +1382,7 @@
 #define BCM54616_E_PHY_ID	0x03625D10
 #define M88_VENDOR		0x0141
 #define I225_I_PHY_ID		0x67C9DC00
+#define I225_I_PHY_ID_MASK	0xFFFFFC00
 #define I226_LM_PHY_ID		0x67C9DC10
 
 /* M88E1000 Specific Registers */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index d5dea74c22..4bc5a8e0f2 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1049,6 +1049,7 @@ struct e1000_dev_spec_vf {
 struct e1000_dev_spec_i225 {
 	bool global_device_reset;
 	bool eee_disable;
+	bool wait_for_valid_phy_id_read;
 	bool clear_semaphore_once;
 	bool module_plugged;
 	u8 media_port;
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 68c81c3101..0077696464 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -143,8 +143,10 @@ static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 static s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 {
 	struct e1000_phy_info *phy = &hw->phy;
+	u16 phy_id_retries = 1, phy_id_retries_interval_ms = 100;
 	s32 ret_val = E1000_SUCCESS;
 	u32 ctrl_ext;
+	u16 i = 0;
 
 	DEBUGFUNC("e1000_init_phy_params_i225");
 
@@ -184,10 +186,48 @@ static s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 	phy->ops.read_reg = e1000_read_phy_reg_gpy;
 	phy->ops.write_reg = e1000_write_phy_reg_gpy;
 
-	ret_val = e1000_get_phy_id(hw);
-	phy->type = e1000_phy_i225;
+	if (hw->dev_spec._i225.wait_for_valid_phy_id_read) {
+		phy_id_retries = 10;
+		DEBUGOUT1("Going to wait %d ms for a valid PHY ID read...\n",
+			  phy_id_retries * phy_id_retries_interval_ms);
+	}
 
+	for (i = 0; i < phy_id_retries; i++) {
+		ret_val = e1000_get_phy_id(hw);
+		phy->id &= I225_I_PHY_ID_MASK;
+		DEBUGOUT1("PHY ID value = 0x%08x\n", phy->id);
 
+		/*
+		* IGC/IGB merge note: in base code, there was a PHY ID check for
+		* I225 at this point. However, in DPDK version of IGC this check
+		* was removed because it interfered with some i225-based NICs,
+		* and it was deemed unnecessary because only the i225 NIC
+		* would've called this code anyway because it was in the IGC
+		* driver.
+		*
+		* This code was then amended apparently because there were
+		* issues wih reading PHY ID on some platforms, and PHY ID read
+		* was to be retried multiple times. However, the original fix in
+		* the base code still had the PHY ID check, and it is now
+		* necessary because there is a chance to read an invalid PHY ID.
+		* So, in backport, it was decided to replace the equality check
+		* with a non-zero condition, because the "invalid" PHY ID as
+		* reported in the original issue, was 0. So, as long as we read
+		* a non-zero PHY ID, we consider it valid.
+		*/
+		if (phy->id != 0) {
+			phy->type = e1000_phy_i225;
+			phy->ops.set_d0_lplu_state = e1000_set_d0_lplu_state_i225;
+			phy->ops.set_d3_lplu_state = e1000_set_d3_lplu_state_i225;
+
+			return ret_val;
+		}
+
+		msec_delay(phy_id_retries_interval_ms);
+	}
+
+	DEBUGOUT("Failed to read PHY ID\n");
+	ret_val = E1000_ERR_PHY;
 out:
 	return ret_val;
 }
-- 
2.43.5

