Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0034C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D45FF40E49;
	Thu,  6 Feb 2025 17:09:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C1F864029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858142; x=1770394142;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0hf9Ssg4SEJ3gAFBJJufI07NWh1Tgvt3crHtMLEl/lU=;
 b=GnLfNmp2Wahwbwylseff9VJ0aQGWOK3TtvSRt5/X2M2gk49T+By1cR+U
 zjSvf9JKCSzX0heBanJMpTkhnKtPXf0Nxw2PLENLihKoCuN3FZKhbJbCG
 P4Yf93symX3khB+UCRDK73QXnGUNJwz9EqUcfwmCZQfGn+TX+axQ2L7iW
 E3E72dwEDwddO+U3bFy1qnfg484JB8qMJslD9np+IX8vun/jXnoG3kcTm
 EA/UYegRevvduRFG4gZI8ccXOD/tYfIA0LbGyNyRzme1i4ZRIReQwTs1X
 wb3q64ksF0veOEUVPno8g9FgUXvk+Id27tGPM1OqvvNQzVTMnOe4XiTbZ g==;
X-CSE-ConnectionGUID: XvhSvUVNQrO+sHdWV+F/fg==
X-CSE-MsgGUID: SNZmmSoSQnGk1Kvxyt4Xnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860708"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860708"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:01 -0800
X-CSE-ConnectionGUID: Zbxpn9iWTwWP7g6h3yP1xw==
X-CSE-MsgGUID: mUJZzmagR5WQ7BHfcVhmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166609"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Alvin Zhang <alvinx.zhang@intel.com>, Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 01/24] net/igc/base: fix deadlock in i225
Date: Thu,  6 Feb 2025 16:08:24 +0000
Message-ID: <edb5d0a2ee7c6ad57ad837dcf69c647d83ff9bfc.1738858026.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Currently, when writing GPY PHY registers, semaphor is acquired before
writing. However, if writing fails, semaphor is not released, causing
a deadlock down the line. Fix the issue by removing premature return.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                             | 1 +
 drivers/net/intel/igc/base/igc_phy.c | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 9209a716e0..3faff80f0e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -358,6 +358,7 @@ Dhruv Tripathi <dhruv.tripathi@arm.com>
 Diana Wang <na.wang@corigine.com>
 Didier Pallard <didier.pallard@6wind.com>
 Dilshod Urazov <dilshod.urazov@oktetlabs.ru>
+Dima Ruinskiy <dima.ruinskiy@intel.com>
 Ding Zhi <zhi.ding@6wind.com>
 Diogo Behrens <diogo.behrens@huawei.com>
 Dirk-Holger Lenz <dirk.lenz@ng4t.com>
diff --git a/drivers/net/intel/igc/base/igc_phy.c b/drivers/net/intel/igc/base/igc_phy.c
index 2906bae21a..ddc2b6ecc1 100644
--- a/drivers/net/intel/igc/base/igc_phy.c
+++ b/drivers/net/intel/igc/base/igc_phy.c
@@ -4148,8 +4148,6 @@ s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
 		if (ret_val)
 			return ret_val;
 		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
@@ -4182,8 +4180,6 @@ s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
 		if (ret_val)
 			return ret_val;
 		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
 		hw->phy.ops.release(hw);
 	} else {
 		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
-- 
2.43.5

