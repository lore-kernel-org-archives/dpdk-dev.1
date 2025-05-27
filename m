Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF5C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E002540697;
	Tue, 27 May 2025 15:18:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 775C140685
 for <dev@dpdk.org>; Tue, 27 May 2025 15:17:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351879; x=1779887879;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v5n2tP2s1SLf0ky5juQRN5KJRVlM8uZ8RLTFUyBvcyc=;
 b=YMtiWsHeNbnsrWDyYFBOzqWtQOsD7yKJXXZJsK4+7RBJTAGfCFhWdVEr
 Ij2gnbmW4QhiGceYyfG5W1og62MsGQg8gLEQrs25ausqAczjT3uc2hXVE
 AXgNTxiBEYHA1myWr12IHHYn1Bg/iVGqDULj121WotLHQTmljY+SDEpu1
 7UpNe61FlU5ZLZf/4IAlm6Il219NWGIkZZb+mCduLKhASxb9O8Lbva7cO
 1cwVHrI8qm0xdVxrfyMF2IfvR2g8XYEkeQEITUxoKowSEQOEKpCHFOGXR
 VkinFiXBvxjcKLxP3cW/1LVYzrp2ty33lTfPNzZhNXo0xxjHU0ajT2/QD Q==;
X-CSE-ConnectionGUID: NZ3KNmxiTeWVrwJRvOrxpw==
X-CSE-MsgGUID: 26DgVaDoQXixTLIj4Wh9og==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884844"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884844"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:58 -0700
X-CSE-ConnectionGUID: eO4FfwTlSeSl0i8yf1zesg==
X-CSE-MsgGUID: OLdZNJMWTZymLzycncUxxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150071"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:57 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Oleg Akhrem <oleg.akhrem@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 06/10] net/ice/base: ptp minimal refactoring
Date: Tue, 27 May 2025 13:17:25 +0000
Message-ID: <20250527131741.7606-7-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

