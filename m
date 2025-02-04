Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1AC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE5E4427B0;
	Tue,  4 Feb 2025 16:12:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7855F42799
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681909; x=1770217909;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XUTZVD2UcbrmvTGJtgawmQkZzAuzRFvghKRy/YJiQGQ=;
 b=BBoILE8ITWRAUZep4jJplNxpKK63kTnEEFkPCd+BEKHyQ4dhF0RXUD6/
 EFZyCagFEZn6DRsPEnA1IWN5e1lWvUREiXwsYjkUm8dwXDVIsyJC+MzjM
 UyITHgpFOTJxmKgDUkYJrNrr114VclJxRnzODaquYZj/QA9ltBwA/FWkM
 /n/MdrarE5KVbUQTL2El6ZjInCIq1opbFk8VncM8tMLSoE/aMjXyTRiZV
 tV/30Gq21ApC0pMc2oDgMjnYvzFS1ON0lP1Xc5d9JQhTDUD26fO8JOWmy
 kK0U5mMjd8vSHDQNPi0pf8DQIfBfnWRcap+2XLLSJkTGGnKgEn3ueHdSt w==;
X-CSE-ConnectionGUID: 1mGOMWjvTCuq/4CypdK5YQ==
X-CSE-MsgGUID: +QNA6jCERDScipai66t5tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097119"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:49 -0800
X-CSE-ConnectionGUID: zomUgwxeSDO3o38vY7T4lQ==
X-CSE-MsgGUID: TD11R1NZTwWH374FBfvqxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792630"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:47 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 16/54] net/e1000/base: fix deadlock in i225
Date: Tue,  4 Feb 2025 15:10:22 +0000
Message-ID: <a2c7995b0545fcb1b8fd0720c207bec049ab66c8.1738681726.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Currently, when writing GPY PHY registers, semaphor is acquired before
writing. However, if writing fails, semaphor is not released, causing
a deadlock down the line. Fix the issue by removing premature return.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index eb0c6d7c53..1b5fd76ada 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -4193,8 +4193,6 @@ s32 e1000_write_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 data)
 		if (ret_val)
 			return ret_val;
 		ret_val = e1000_write_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = e1000_write_xmdio_reg(hw, (u16)offset, dev_addr,
@@ -4227,8 +4225,6 @@ s32 e1000_read_phy_reg_gpy(struct e1000_hw *hw, u32 offset, u16 *data)
 		if (ret_val)
 			return ret_val;
 		ret_val = e1000_read_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = e1000_read_xmdio_reg(hw, (u16)offset, dev_addr,
-- 
2.43.5

