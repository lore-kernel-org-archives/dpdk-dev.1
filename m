Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B4ECCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 10:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 108F64060A;
	Fri, 16 Oct 2026 12:23:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9BC88402DA
 for <dev@dpdk.org>; Fri, 16 Oct 2026 12:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792146190; x=1823682190;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5VheyGNBDkuzHbi4d8zJ5nALeBJL0TMnHUQNYlXmGeA=;
 b=SF0+pYA9dp6xVM6N5MQUP183HKVYAgo17q/VRriJUNFpYMUATqf7rLGY
 CYza80vpD3OW9wxNh8UeNAdxUMD1HJk7oqOlvv3YaRkkLh5TGZExY1YDp
 0HtLEqACoqfgfdDMiMHHAzIWRH41BLKTxQMMywex9vHmPuNMGJkPT1j+q
 E1rRRWHMm2D6wS92zOjLtM1/X5hPs5Ce76bGDWWHHhE4/hCwjeJQbX+Jn
 TwaVWxtiJYHXqT0oTSXYOZ6shbtx8avSFlRzjwWAkPnRNv1wwtZ09xh0j
 4xZZ6AG2Q/Rbq+86eJWOxbrWck+lFTndgV7ca0nlIqRKhg1PgnD0GwSex Q==;
X-CSE-ConnectionGUID: 0JAKEba/QtC0WXunjnGNiQ==
X-CSE-MsgGUID: E11DcQlHQHCVFGGi9houCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="809306"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="809306"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 03:23:09 -0700
X-CSE-ConnectionGUID: la9/CH/VSNCfrSdO2UNchA==
X-CSE-MsgGUID: cHS4e+qdQNelbCCMtzYk+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2292837"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2026 03:23:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 3/3] net/e1000/base: enable ULP on LANPHYPC
Date: Fri, 16 Oct 2026 11:23:01 +0100
Message-ID: <b31747271046334d6d0e24d13d4efd1f5afd79d1.1792146148.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792146148.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

When the system enters Sx without wakeup configured, the PHY is powered
down autonomously via LANPHYPC.

Set `I218_ULP_CONFIG1_EN_ULP_LANPHYPC` when configuring ULP in
`e1000_enable_ulp_lpt_lp()` so that the PHY also enters ULP on
LANPHYPC, for additional power savings.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index b020639563..ed86c24af6 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -1283,6 +1283,7 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
 	if (ret_val)
 		goto release;
 	phy_reg |= (I218_ULP_CONFIG1_RESET_TO_SMBUS |
+		    I218_ULP_CONFIG1_EN_ULP_LANPHYPC |
 		    I218_ULP_CONFIG1_DISABLE_SMB_PERST);
 	if (to_sx) {
 		if (E1000_READ_REG(hw, E1000_WUFC) & E1000_WUFC_LNKC)
-- 
2.52.0

