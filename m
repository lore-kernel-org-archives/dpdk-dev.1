Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA1C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18B3C42D27;
	Tue,  4 Feb 2025 16:12:16 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8C074427A6;
 Tue,  4 Feb 2025 16:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681921; x=1770217921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0ZYgsEOT2x8k3J27jGc/1oQ4EP2wm438WAJ2coYNVuE=;
 b=Pok/D/8J+O1oV+I+u64J+B1Oh0TgiiUAJNjSc9qmN9CX51ahH6F+6Qb4
 xl1aH3pbthGLQddrLVj78S725vQE+aUEHgC7wPBE5/cqMEG3wmBT7fHgS
 D5dfptgCyJ07+/3jcBWL/OFZ8Ler/VP7JZSwH2YGAltKH8LTRuoEWlxgK
 sG63VxgoHUYYjWNcAljWvVMh4JiJe1+Zc29/Nmx3464o5RJ+O9OM9arIA
 97bFyE2VE+lWps2Xz+dgGE491IysqzyEeNktIRPoSvvIGy1gsQfTWnA61
 Q1lVqwAM0CLIkcxP5la3xt+7pM31n/gIvTE+n7pRe7ojJfV5IRPwG8atM g==;
X-CSE-ConnectionGUID: mNgL1Th1Se2Cfo93FKAiig==
X-CSE-MsgGUID: cemi1WTeRBe30WQeI1Osdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097139"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097139"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:01 -0800
X-CSE-ConnectionGUID: DpqJzjWbRbmJrSKELLz9EA==
X-CSE-MsgGUID: g7lkowj1Q4W/BTqDnKkM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792685"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Markos Chandras <mchandras@suse.de>
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 26/54] net/e1000/base: correct mPHY access logic
Date: Tue,  4 Feb 2025 15:10:32 +0000
Message-ID: <621e26e2e7f428b27875470ead3663b3c2d63ff6.1738681726.git.anatoly.burakov@intel.com>
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
index 1b5fd76ada..5ac8322af3 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -4284,13 +4284,12 @@ s32 e1000_read_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 *data)
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
@@ -4350,13 +4349,12 @@ s32 e1000_write_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 data,
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

