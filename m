Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32DC02194
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0273642E1C;
	Fri, 31 Jan 2025 13:59:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3ECA942DCE;
 Fri, 31 Jan 2025 13:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328381; x=1769864381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QRQFitCztcgKaDkgp9goH1JgU2u4kLFWmYNphoaGBGI=;
 b=Fhez/yW6VINQArgJjlHQWFPqlkW45BzRqMx1ihbahE7Z3zVwDJFbB7vl
 TS6ARZ1nHQMZmYQoMCRbqYP+o4Emsp/reTeLRhwCTcc0FpkmHsKtSZqJn
 o8UwJaVfV+zOX4W9LPIcfE4y4TD1LcHtBTmnahfo0Hw2avCRxdNKDw/Vo
 HmzH9phtHB/4MSPDcXtMxlwF0l8E+foY97vt7S2FYylNEKGPx/sr27N3H
 /EZv/i6Nwswf+ITerN81mcjzcjgtlz2XT+qUAcQZeENiqzhRIJTP/yuKq
 H0HKQfMssC4jvUNNsjWV6LKi6TqWTfIbO23HzA1mdeCjwf7BqDSGiR8Lm A==;
X-CSE-ConnectionGUID: vIGJ6NshSHy3ZhaNB/TH3g==
X-CSE-MsgGUID: DGlB8U9OSgarhiV3D7Stbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315632"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315632"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:40 -0800
X-CSE-ConnectionGUID: Q8BdvJLiR2Kgi0QAT/7k2w==
X-CSE-MsgGUID: 0BXmIuXtRHm2rVnA5Q2K1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503385"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:38 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Markos Chandras <mchandras@suse.de>
Cc: stable@dpdk.org
Subject: [PATCH v1 14/42] net/e1000/base: correct mPHY access logic
Date: Fri, 31 Jan 2025 12:58:27 +0000
Message-ID: <a9c4700ec4475aa9e71582ec6bc50bc31762a693.1738328107.git.anatoly.burakov@intel.com>
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
index 60d6bdfa4e..102fae6bf0 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -4285,13 +4285,12 @@ s32 e1000_read_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 *data)
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
@@ -4351,13 +4350,12 @@ s32 e1000_write_phy_reg_mphy(struct e1000_hw *hw, u32 address, u32 data,
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

