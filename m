Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976CC02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8081342E4F;
	Tue,  4 Feb 2025 16:12:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id AA6E842DBE
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681944; x=1770217944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E9WcT8nwVsgxSnWhSy4FliUWe45T7M65ZxXDkCqfRyA=;
 b=Yu9OsPLeHsvSDmuqkYCTJASJqUtK8tSIdFVTNKKTgmbHaL7HgVx9I6n1
 aI5K/NQx/ZCmzwA3rw0g3pkaTxCPuqfJgQKM3UgNo4oTTfELeNHZYNOF5
 o6CConTrMFzxECwm6o8yS09hk5tIC4PaVEdTW0r0fcZNGTngXLJ88DjPS
 GMt12TBarENGauGPzidKYDeSPrztrJV2H9rmIwnlwtpXapHcQoLrnUKX2
 np2VlKzwvzYyhfQhZLSzk8dFg53UDQE6Rr2F2g5mhl/K8Bq24R6WoztDY
 LZE2kfnbL96ztiHnRFRp/3BkptODb4M5CHgHG4+jIBRye3B8beusLazZf Q==;
X-CSE-ConnectionGUID: VEypqF32T6+y2RUHf7vTPQ==
X-CSE-MsgGUID: ROGg6cS0TS6mEnteqhCfOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097178"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097178"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:23 -0800
X-CSE-ConnectionGUID: Kit7E+B6TFGG1huAnyQYjA==
X-CSE-MsgGUID: 1kIXZr8bRX2MmVlGwCPqpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792767"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 44/54] net/e1000/base: introduce PHY ID retry mechanism
Date: Tue,  4 Feb 2025 15:10:50 +0000
Message-ID: <4bfb08aa63fe3a030befb18f591d8073d207411a.1738681726.git.anatoly.burakov@intel.com>
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
index 062a195a66..a1f4c5524b 100644
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

