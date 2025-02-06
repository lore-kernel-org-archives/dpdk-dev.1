Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F40C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:11:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E15A142799;
	Thu,  6 Feb 2025 17:09:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 392F64161A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858170; x=1770394170;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9gmzmfhLD1qwaxcpoGqZMrV7UNULtVQ4ryn4AkUmWY0=;
 b=aL1OV34nXqPwnNuf2IsPYBjBbxcM9AkWWCfZMtJlEjBzCRfGyNbp0jkd
 u1iTY8LTOhbV5mCrXHe1d1d/6WmdXPCFg8DXVInvcN/f7fVc3k0Be1UxK
 iLSNMtGVngSbdpM/Rn+5Z2e+tIAo7EGiMhL7+kl4cu5h2LWUFzfIVTwUU
 VCgLcj+y8NJvildGQv/XtBlD4f+ir33ze6lJU7hInxyH+gu+XyXgICAhL
 ibB/i7kibgQ4bjD0qjEPQOpIDe4MjLSGu3wPEj7+cXpUEBtkd8dohelI8
 BNKzkeDrTaQbztIcWjBic6ilM3v3Uej55BbIaVlwv5GQMzFzTztRhyWqJ Q==;
X-CSE-ConnectionGUID: wYnPzqyMSCqgwU4c5FtvnA==
X-CSE-MsgGUID: iP5+Al/kSh+Dgw2cEXtC5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860771"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860771"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:30 -0800
X-CSE-ConnectionGUID: fI1gT463SZ2lBuz07k5JVQ==
X-CSE-MsgGUID: +VDgYl/tS+mGKtsSa/jJNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166830"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:29 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 22/24] net/e1000/base: fix reset for 82580
Date: Thu,  6 Feb 2025 16:08:45 +0000
Message-ID: <bf6a15965c5777781966b9c11d61953a02c84278.1738858026.git.anatoly.burakov@intel.com>
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

From: Barbara Skobiej <barbara.skobiej@intel.com>

Fix setting device reset status bit in e1000_reset_hw_82580() function
for 82580 by first reading the register value, and then setting the
device reset bit.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Barbara Skobiej <barbara.skobiej@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_82575.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index 53900cf8f1..948c80f2fa 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -2280,7 +2280,7 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	s32 ret_val = E1000_SUCCESS;
 	/* BH SW mailbox bit in SW_FW_SYNC */
 	u16 swmbsw_mask = E1000_SW_SYNCH_MB;
-	u32 ctrl;
+	u32 ctrl, status;
 	bool global_device_reset = hw->dev_spec._82575.global_device_reset;
 
 	DEBUGFUNC("e1000_reset_hw_82580");
@@ -2345,7 +2345,8 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	}
 
 	/* clear global device reset status bit */
-	E1000_WRITE_REG(hw, E1000_STATUS, E1000_STAT_DEV_RST_SET);
+	status = E1000_READ_REG(hw, E1000_STATUS);
+	E1000_WRITE_REG(hw, E1000_STATUS, status | E1000_STAT_DEV_RST_SET);
 
 	/* Clear any pending interrupt events. */
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
-- 
2.43.5

