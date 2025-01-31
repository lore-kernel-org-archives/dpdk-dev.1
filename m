Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A0C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D8FB42E90;
	Fri, 31 Jan 2025 14:00:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5944242E6B
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328400; x=1769864400;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NoMun2c6z3xqaZJRqXcLcipkVmVegd/dDBLbKjNNj8w=;
 b=bYyv4oRc9A+1LzR13p1dP2ho7dBnabYCdFbJmK1ZrfPfNH8wdR6LZDmH
 rtRtKPB8g/WO7oLolqnsgwWJfNLbAOuXykbE0rIqP0S1gP5FoeVwhumHc
 pIt//PCfRXpxHmHL9UMJDewqi8J2HjdDKaK6tjtOoV/ouYjidI2GR/hd5
 K8JJyJUk0vntJ2n5vV1EnCwE3dP1XhwXjGRF/I3UoF3N5bdkreyxK6UEQ
 RImDg6imDekJWGPgGbkHxcRdSjEsTjMFjEGhGVR3Sf2FbonZwPCZf3jnM
 mIcPqtbVFEsDJxg2Kbi7ESNkjVq63jEn534OklU3E5cd1vEp5SSwXovHg A==;
X-CSE-ConnectionGUID: y+doHXVuSquwEvAruMCvUA==
X-CSE-MsgGUID: wzQb/WflQaOCmhCECrfCHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315663"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315663"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:59 -0800
X-CSE-ConnectionGUID: g5wjQnzjQkSxSRhyoRjn1g==
X-CSE-MsgGUID: Asj73/kGQCG+1vvowxIAUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503432"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 32/42] net/e1000/base: introduce PHY ID retry mechanism
Date: Fri, 31 Jan 2025 12:58:45 +0000
Message-ID: <b1ae7a898befb1e6b052d0b91b0fe92b11005cc3.1738328108.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/e1000/base/e1000_i225.c    | 56 +++++++++++++++-----
 3 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 0b370977f3..41922d7477 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1381,6 +1381,7 @@
 #define BCM54616_E_PHY_ID	0x03625D10
 #define M88_VENDOR		0x0141
 #define I225_I_PHY_ID		0x67C9DC00
+#define I225_I_PHY_ID_MASK	0xFFFFFC00
 #define I226_LM_PHY_ID		0x67C9DC10
 
 /* M88E1000 Specific Registers */
diff --git a/drivers/net/intel/e1000/base/e1000_hw.h b/drivers/net/intel/e1000/base/e1000_hw.h
index 2777922a6b..2c425fd799 100644
--- a/drivers/net/intel/e1000/base/e1000_hw.h
+++ b/drivers/net/intel/e1000/base/e1000_hw.h
@@ -1040,6 +1040,7 @@ struct e1000_dev_spec_vf {
 struct e1000_dev_spec_i225 {
 	bool global_device_reset;
 	bool eee_disable;
+	bool wait_for_valid_phy_id_read;
 	bool clear_semaphore_once;
 	bool module_plugged;
 	u8 media_port;
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 1dc7138856..aff334230f 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -143,8 +143,10 @@ STATIC s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 {
 	struct e1000_phy_info *phy = &hw->phy;
+	u16 phy_id_retries = 1, phy_id_retries_interval_ms = 100;
 	s32 ret_val = E1000_SUCCESS;
 	u32 ctrl_ext;
+	u16 i = 0;
 
 	DEBUGFUNC("e1000_init_phy_params_i225");
 
@@ -184,20 +186,48 @@ STATIC s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 	phy->ops.read_reg = e1000_read_phy_reg_gpy;
 	phy->ops.write_reg = e1000_write_phy_reg_gpy;
 
-	ret_val = e1000_get_phy_id(hw);
-
-	/*
-	 * IGC/IGB merge note: in base code, there was a PHY ID check for I225
-	 * at this point. However, in DPDK version of IGC this check was
-	 * removed because it interfered with some i225-based NICs, and it was
-	 * deemed unnecessary because only the i225 NIC would've called this
-	 * code anyway because it was in the IGC driver.
-	 *
-	 * In merged IGB/IGC, this code is still only called by i225-based NICs,
-	 * so the previous fix is applicable.
-	 */
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
+
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

