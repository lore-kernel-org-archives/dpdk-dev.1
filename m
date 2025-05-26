Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8498DC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:04:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B395140A84;
	Mon, 26 May 2025 20:03:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 954F540A6F
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282622; x=1779818622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v5n2tP2s1SLf0ky5juQRN5KJRVlM8uZ8RLTFUyBvcyc=;
 b=iDnixBsScTsh98tGUJK0OJomitI9xKTdGejCbscDGjDn2oOnrQZ9C3T+
 BPMijU26ZKzDuR7whTH+uE6nuhhPRuqPfap9NwhLCDyHmYzfLRkcIBMGd
 YPZ9wApD1OxLAqEAJuCjC/+0WITWkdcNayImhT/amlJ82wVzsyzE1feLf
 TojVKQ4LcVoTvdBsR4YE/oCYUpVOKOjcaZ9oQrCoCZSnS2qn4ZCRxKmMB
 x+Pl4Tu5a+0DRuXi9g65k3WAJhnZfy+GtdCDAs2IJpZiqND5Xado42p39
 1rovaYc3io1/NhlRBa82DrWuxAu4jpiJQUnUXvveuZIB7aw07f0Nu0hx1 w==;
X-CSE-ConnectionGUID: 8X0W8qhdTp+sZilzOtKPwg==
X-CSE-MsgGUID: r/Wexm0cRISP/HKs+BroFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375177"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375177"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:41 -0700
X-CSE-ConnectionGUID: Jwr0bKl0RCebwDQ2LdxUgQ==
X-CSE-MsgGUID: t+bcvuJmRYeKSI7i+t+M7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478314"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:40 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Oleg Akhrem <oleg.akhrem@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 06/10] net/ice/base: ptp minimal refactoring
Date: Mon, 26 May 2025 18:02:54 +0000
Message-ID: <20250526180311.4573-7-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

From: Oleg Akhrem <oleg.akhrem@intel.com>

Removed redundant code. The *clk_freq and *clk_src are not modified.

Signed-off-by: Oleg Akhrem <oleg.akhrem@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_ptp_hw.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ptp_hw.c b/drivers/net/intel/ice/base/ice_ptp_hw.c
index 1e92e5ff21..7d16965674 100644
--- a/drivers/net/intel/ice/base/ice_ptp_hw.c
+++ b/drivers/net/intel/ice/base/ice_ptp_hw.c
@@ -520,9 +520,6 @@ ice_cfg_cgu_pll_e825c(struct ice_hw *hw, enum ice_time_ref_freq *clk_freq,
 		  ice_clk_src_str(dw23.field.time_ref_sel),
 		  ice_clk_freq_str(dw9.field.time_ref_freq_sel));
 
-	*clk_freq = (enum ice_time_ref_freq)dw9.field.time_ref_freq_sel;
-	*clk_src = (enum ice_clk_src)dw23.field.time_ref_sel;
-
 	return 0;
 }
 
@@ -798,11 +795,11 @@ static int ice_init_cgu_e82x(struct ice_hw *hw)
 		ice_warn(hw, "Failed to lock TS PLL to predefined frequency. Retrying with fallback frequency.\n");
 
 		/* Try to lock to internal 25 MHz TCXO as a fallback */
+		time_ref_freq = ICE_TIME_REF_FREQ_25_000;
+		clk_src = ICE_CLK_SRC_TCX0;
 		if (hw->phy_model == ICE_PHY_ETH56G)
 			time_ref_freq = ICE_TIME_REF_FREQ_156_250;
-		else
-			time_ref_freq = ICE_TIME_REF_FREQ_25_000;
-		clk_src = ICE_CLK_SRC_TCX0;
+
 		if (ice_is_e825c(hw))
 			err = ice_cfg_cgu_pll_e825c(hw, &time_ref_freq,
 						    &clk_src);
-- 
2.43.0

