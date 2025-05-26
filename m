Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD5C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EDE84068A;
	Mon, 26 May 2025 10:34:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 28C6A4067A
 for <dev@dpdk.org>; Mon, 26 May 2025 10:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248449; x=1779784449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=se9bGSzE98XtEP5lpaZSTcMWw9DDKREJ9D+TmGaGk7g=;
 b=BNdkYv17XbmIbZtqTkxI86x8B1b8gX2UcLZRFIr32g+ZM2Agu1cqF0Do
 CdV87aezTz9dlwKYVv+taRQGPsd+oWZ5MWOwZIP2Rqv54gTR+V1dCzUUB
 O+2mxaS171ixTMFx7jMeAG7mUGGo1tVUuZgTnMWc93Wib2VoP+Alp0ly9
 a9PLokWV53dX+79yd+wzspRkqBiwQ5OwA93uv7MAdp537poW9/oWlOwGA
 q8kJbFf8NJ4lw6v8ivL44uJ4TPP3JC55kEJEUM5c5IUIIhiK/JDiCQOXk
 d6cxYGxMiGmIy1WbyD60h2jdtatc9uAANcibxZRSZ5OYpAxpQk6a9PzVi g==;
X-CSE-ConnectionGUID: 9xQc4a8GTQORah+iLjKH9w==
X-CSE-MsgGUID: pzCwjnwOS3CuPs6IrinkLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009033"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:34:09 -0700
X-CSE-ConnectionGUID: YshwQD5DQuyp1C2WRq3zIA==
X-CSE-MsgGUID: xhumjgHBQvyu0sFD7ekxJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293564"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:34:08 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Oleg Akhrem <oleg.akhrem@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 6/9] net/ice/base: ptp minimal refactoring
Date: Mon, 26 May 2025 08:33:08 +0000
Message-ID: <20250526083325.248384-7-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

