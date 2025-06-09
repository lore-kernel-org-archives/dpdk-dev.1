Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131BAC61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:17:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45B6640DD5;
	Mon,  9 Jun 2025 12:16:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 5A41D40658
 for <dev@dpdk.org>; Mon,  9 Jun 2025 12:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749464214; x=1781000214;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=k4MqfbsD6u98OTWiRm2t6dEzVi1HCyMvlAf5QyZDpck=;
 b=L6Mr19RnnOy8z0X4tMjgktcPgWQLM5XYFZ9X2GneY/mV66cd6J1olMxw
 8DESNQ0Pzxz7uqGsg6jcBu95mj35ehdhDqwZCD2r1CqhChTPPvt0wI1zL
 Resz50ijCg0RrBA8uVXRbxLLtM/cIUisc/G/D7cOlX3D6gLNNX/22TToC
 202pCmIINNrI6LYqdMasv04Jnc+mIiz0vs4cLPBNaVqPYLM1YE99lNZJK
 h9Wnh+L9KO12K0fOpBje4Obg1nU2Hl/+pk8oi2GRirEUqv8yBYDicJ25S
 EoR7ghBDDh8m6qgkpBdffIghZo7ALSIP/FE8yYhqQ9qmhKMZx05YKLAXU w==;
X-CSE-ConnectionGUID: I7UzvrZeSp6ZGr9d/H/lCQ==
X-CSE-MsgGUID: tkdmTFaKR0WGJfeXgBIZhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="74067651"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="74067651"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 03:16:53 -0700
X-CSE-ConnectionGUID: 0Rj6UaQ/Sgyr+0P0cigmgA==
X-CSE-MsgGUID: JmLhRJ06TTqigbCWIeUpvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151345670"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 03:16:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>
Subject: [PATCH v1 1/2] net/e1000: better clock synchronization workaround
Date: Mon,  9 Jun 2025 11:16:41 +0100
Message-ID: <1a8eb4a20513e1856bba0d6df25ce378aa8d7fae.1749464159.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749464159.git.anatoly.burakov@intel.com>
References: 
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

There was a workaround for clock synchronization issue already in place,
however this workaround has a high power penalty. Fix the issue by
reconfiguring the k1 exit timeout, thereby avoiding the side effect of high
power draw.

Fixes: 90f456cea0c2 ("net/e1000/base: correct clock synchronization")

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 82 +++++++++++++++++---
 drivers/net/intel/e1000/base/e1000_ich8lan.h |  4 +
 2 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 6b7eb245a6..ece61650f7 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -284,6 +284,43 @@ STATIC void e1000_toggle_lanphypc_pch_lpt(struct e1000_hw *hw)
 	}
 }
 
+/**
+ * e1000_reconfigure_k1_exit_timeout
+ * @hw: pointer to the HW structure
+ *
+ * Reconfigure K1 exit timeout as a workaround to the PHY sycndhronization issue
+ * on MTL, LNL, PTL and WCL.
+ *
+ * Assuming PHY semaphore is taken prior to this function call.
+ **/
+STATIC s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
+{
+	s32 ret_val = E1000_SUCCESS;
+	u32 fextnvm12;
+	u16 phy_timeout;
+
+	DEBUGFUNC("e1000_reconfigure_k1_exit_timeout");
+
+	if (hw->mac.type < e1000_pch_mtp)
+		return E1000_SUCCESS;
+
+	fextnvm12 = E1000_READ_REG(hw, E1000_FEXTNVM12);
+	fextnvm12 |= (1 << 23);
+	fextnvm12 &= ~((1 << 22));
+	E1000_WRITE_REG(hw, E1000_FEXTNVM12, fextnvm12);
+
+	msec_delay_irq(1);
+
+	ret_val = hw->phy.ops.read_reg_locked(hw, E1000_PHY_TIMEOUTS_REG,
+					      &phy_timeout);
+	phy_timeout &= ~E1000_PHY_TIMEOUTS_K1_EXIT_TO_MASK;
+	phy_timeout |= 0xF00;
+	ret_val = hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG,
+					       phy_timeout);
+
+	return ret_val;
+}
+
 /**
  *  e1000_init_phy_workarounds_pchlan - PHY initialization workarounds
  *  @hw: pointer to the HW structure
@@ -332,6 +369,14 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 	case e1000_pch_adp:
 	case e1000_pch_mtp:
 	case e1000_pch_ptp:
+		/* Due to clock synchronization issue on MTL and above prior to
+		 * disabling k1 it is required to disable P0s state and
+		 * reconfigure PHY k1 exit timeout. At this point the PHY might
+		 * be inaccessible so don't propagate the failure.
+		 */
+		if (hw->mac.type >= e1000_pch_mtp)
+			e1000_reconfigure_k1_exit_timeout(hw);
+
 		if (e1000_phy_is_accessible_pchlan(hw))
 			break;
 
@@ -417,6 +462,16 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		ret_val = hw->phy.ops.check_reset_block(hw);
 		if (ret_val)
 			ERROR_REPORT("ME blocked access to PHY after reset\n");
+
+		if (hw->mac.type >= e1000_pch_mtp) {
+			ret_val = hw->phy.ops.acquire(hw);
+			if (ret_val) {
+				DEBUGOUT("Failed to reconfigure K1 exit timeout\n");
+				goto out;
+			}
+			ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+			hw->phy.ops.release(hw);
+		}
 	}
 
 out:
@@ -2463,18 +2518,6 @@ s32 e1000_configure_k1_ich8lan(struct e1000_hw *hw, bool k1_enable)
 
 	DEBUGFUNC("e1000_configure_k1_ich8lan");
 
-	/* Due to clock synchronization issue on MTL and above prior to
-	 * disabling k1 it is required to disable P0s state
-	 */
-	if ((!k1_enable) && (hw->mac.type >= e1000_pch_mtp)) {
-		u32 fextnvm12 = E1000_READ_REG(hw, E1000_FEXTNVM12);
-		fextnvm12 |= (1 << 23);
-		fextnvm12 &= ~((1 << 22));
-		E1000_WRITE_REG(hw, E1000_FEXTNVM12, fextnvm12);
-
-		usec_delay(100);
-	}
-
 	ret_val = e1000_read_kmrn_reg_locked(hw, E1000_KMRNCTRLSTA_K1_CONFIG,
 					     &kmrn_reg);
 	if (ret_val)
@@ -5086,6 +5129,21 @@ STATIC s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 
 	e1000_initialize_hw_bits_ich8lan(hw);
 
+
+	if (hw->mac.type >= e1000_pch_mtp) {
+		ret_val = hw->phy.ops.acquire(hw);
+		if (ret_val)
+			return ret_val;
+
+		ret_val = e1000_reconfigure_k1_exit_timeout(hw);
+		hw->phy.ops.release(hw);
+
+		if (ret_val) {
+			DEBUGOUT("Error reconfiguring PHY K1 exit timeout\n");
+			return ret_val;
+		}
+	}
+
 	/* Initialize identification LED */
 	ret_val = mac->ops.id_led_init(hw);
 	/* An error is not fatal and we should not stop init due to this */
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index fbe118723c..f2ba910ea6 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -218,6 +218,10 @@
 #define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
 #define I217_PLL_CLOCK_GATE_MASK	0x07FF
 
+/* PHY Timeouts */
+#define E1000_PHY_TIMEOUTS_REG		PHY_REG(770, 21)
+#define E1000_PHY_TIMEOUTS_K1_EXIT_TO_MASK	0x0FC0
+
 #define SW_FLAG_TIMEOUT		1000 /* SW Semaphore flag timeout in ms */
 
 /* Inband Control */
-- 
2.47.1

