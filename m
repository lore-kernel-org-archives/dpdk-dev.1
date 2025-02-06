Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B84C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22B9840E72;
	Thu,  6 Feb 2025 17:09:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id E8AE84029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858149; x=1770394149;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QJJe80Ve+hAb/BhoHb6JWDFpP6R15pBiewir3way0lw=;
 b=Vss4xNWznJ3KdXFWdbPnA5o4YzdgvYa47UPRm6K4wjnlrVE9a6fZAp04
 BXXt6ulw4We5erNx3B/PgtJqA066bapRuMfy3TMS+a0WBOBIg5WUjy0BO
 xp8s7USbehsHD3jGY0M0qlIUeBJ6IgpE01rgTciobBk1M04RsqIAnkDhb
 0/Amy38c1YHuynXzZCyr/sSknTTC+3obxJdmij2rvaY7gJeBOp8dLcs+D
 1Y0cruWKJggu4s6e3pTx76kNQmxgEi1/ic8+R+BjoJI58amnKQrLqRQ3W
 tCDHuQBYJKVS4XApRvuEzzsqcsk4th61C5e6MmzakHQ//bl1D9RLUeHPl g==;
X-CSE-ConnectionGUID: N4dp9fYATOePbtymzWxPtA==
X-CSE-MsgGUID: 8wCvFJu5S7CuEKN2iqVfXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860715"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860715"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:06 -0800
X-CSE-ConnectionGUID: K9c//MP+T8+62NBw4bji/A==
X-CSE-MsgGUID: 1kV6opCTR5CbZl3UR41l/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166661"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 04/24] net/igc/base: increase PHY power up delay
Date: Thu,  6 Feb 2025 16:08:27 +0000
Message-ID: <194882f1b3168225d05b1a8b647c5dea84f481a2.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

PHY specification for i225 requires 300 microsecond delay after power up
sequence, so increase the delay after power up to 300 microseconds.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/igc/base/igc_phy.c b/drivers/net/intel/igc/base/igc_phy.c
index ddc2b6ecc1..706f037f0e 100644
--- a/drivers/net/intel/igc/base/igc_phy.c
+++ b/drivers/net/intel/igc/base/igc_phy.c
@@ -3523,6 +3523,7 @@ void igc_power_up_phy_copper(struct igc_hw *hw)
 	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
 	mii_reg &= ~MII_CR_POWER_DOWN;
 	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
+	usec_delay(300);
 }
 
 /**
-- 
2.43.5

