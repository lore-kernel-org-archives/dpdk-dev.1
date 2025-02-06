Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A64C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3095B410FB;
	Thu,  6 Feb 2025 17:09:26 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3B32E41104
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858162; x=1770394162;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vsyJij3QpZRs8gEuh7k4Xf4RINCQPQOvQ73rh5O54mA=;
 b=kczYvEtncAwT7cMDnKTs6h7GU8g3fYyTB4TZkiGwgzIbksqAUNLvN/Ig
 EQErp6Tos0gz6s1rkVV3T84eZrC4KqRBfGCaBzAGEs0UjrNUD8qUC4dGn
 ThxXSFZhu0Bpm7TQOP4DxNUpUX9t3n35O70m3n8DMowqTvTh0sZ6OOjYQ
 a8W08BN2gkbkWhFGqj5BDhi+W+TXCe60BVrHyU0WpihEjjoQ3SspHAv5E
 hsV/AEi6D4wxAHzdfMhFfJXgxOLJuK58/VHKFX3vS1e7x2d+i04/xFFOL
 UHNQlNiHaOM69l+ZJVungIfua4bicnn9eLrbeZ+Wg7yBe7YNGau3kEe9i g==;
X-CSE-ConnectionGUID: E6Tdc050QEur0c+ziwJxlQ==
X-CSE-MsgGUID: 9wj5H2G4RLi0MR/5sKNEIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860755"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860755"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:21 -0800
X-CSE-ConnectionGUID: +lYnkyhtQaKypKAfuOg9cQ==
X-CSE-MsgGUID: G9zPQy8lTUCFnHRbN4o8dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166782"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Markos Chandras <mchandras@suse.de>
Subject: [PATCH v1 15/24] net/e1000/base: correct mPHY access logic
Date: Thu,  6 Feb 2025 16:08:38 +0000
Message-ID: <ab21d3c47869efa7961e982f411559defb5f536b.1738858026.git.anatoly.burakov@intel.com>
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

The original code had incorrect indentation, and the fix was applied to
follow the indentation, i.e. adding brackets making the indentation valid.
However, the actual issue was incorrect indentation and not missing braces,
so the fix was incorrect.

This fix restores the original logic and corrects indentation.

Fixes: d5e39d1ca460 ("net/e1000/base: fix build with gcc 6")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 62d0be5080..208fb3f81b 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -4134,13 +4134,12 @@ s32 e1000_read_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 *data)
 	*data = E1000_READ_REG(hw, E1000_MPHY_DATA);
 
 	/* Disable access to mPHY if it was originally disabled */
-	if (locked) {
+	if (locked)
 		ready = e1000_is_mphy_ready(hw);
-		if (!ready)
-			return -E1000_ERR_PHY;
-		E1000_WRITE_REG(hw, E1000_MPHY_ADDR_CTRL,
-				E1000_MPHY_DIS_ACCESS);
-	}
+	if (!ready)
+		return -E1000_ERR_PHY;
+	E1000_WRITE_REG(hw, E1000_MPHY_ADDR_CTRL,
+			E1000_MPHY_DIS_ACCESS);
 
 	return E1000_SUCCESS;
 }
@@ -4200,13 +4199,12 @@ s32 e1000_write_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 data,
 	E1000_WRITE_REG(hw, E1000_MPHY_DATA, data);
 
 	/* Disable access to mPHY if it was originally disabled */
-	if (locked) {
+	if (locked)
 		ready = e1000_is_mphy_ready(hw);
-		if (!ready)
-			return -E1000_ERR_PHY;
-		E1000_WRITE_REG(hw, E1000_MPHY_ADDR_CTRL,
-				E1000_MPHY_DIS_ACCESS);
-	}
+	if (!ready)
+		return -E1000_ERR_PHY;
+	E1000_WRITE_REG(hw, E1000_MPHY_ADDR_CTRL,
+			E1000_MPHY_DIS_ACCESS);
 
 	return E1000_SUCCESS;
 }
-- 
2.43.5

