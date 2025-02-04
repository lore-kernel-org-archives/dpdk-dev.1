Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA685C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8296442E6E;
	Tue,  4 Feb 2025 16:12:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id ECD48427D0;
 Tue,  4 Feb 2025 16:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681950; x=1770217950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rAb6+rTAskPMNhNkzrQoEwuo0SJeWIr1cYKLnK/dL8U=;
 b=Ir4Z/s1qJjBs/QzFkKw+kq6JkSyO2+uRDkx4JLUN0Du61udVhF4nDMYZ
 cuRFczMZQjUrHM4M/kyiPE/3TB887FeBBl4GR+Bo0DioKnK0FM4AhEjNF
 CMcNLWQOmi8Pp91w1BEa3t05i23zb/K67WOKAq6NOThqaeVVaXmuxtuRF
 Slm3+seUD0XPx5z+Zzvrx5xSny/ofhrv/PyHe76IFZRdeYvuVXhzKjDKD
 Ds+eNdGWqFgpPoZCcl69C8oxe6VEebOeatQVrkolP5fiCLxm0wZmpbJYF
 say85nseZq8CAuVIllOiX6wDT8C0nRFdA6dpa4MYV5c+Y0jPLB61AzSBp A==;
X-CSE-ConnectionGUID: sLVEOmZyS0+vFzrilipMQg==
X-CSE-MsgGUID: M4K0Pa9MTxah5LJZbjYnNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097197"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097197"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:29 -0800
X-CSE-ConnectionGUID: PSUkbyxfQK6TQYEn7jaZZA==
X-CSE-MsgGUID: zKo3s/ZPSdCKN7va6OQUZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792782"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 48/54] net/e1000/base: fix reset for 82580
Date: Tue,  4 Feb 2025 15:10:54 +0000
Message-ID: <19b6d4e612fed6d90e9365ea0ec032441fc51f0a.1738681726.git.anatoly.burakov@intel.com>
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
index ff5a5cad80..34b315a540 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -2272,7 +2272,7 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	s32 ret_val = E1000_SUCCESS;
 	/* BH SW mailbox bit in SW_FW_SYNC */
 	u16 swmbsw_mask = E1000_SW_SYNCH_MB;
-	u32 ctrl;
+	u32 ctrl, status;
 	bool global_device_reset = hw->dev_spec._82575.global_device_reset;
 
 	DEBUGFUNC("e1000_reset_hw_82580");
@@ -2337,7 +2337,8 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	}
 
 	/* clear global device reset status bit */
-	E1000_WRITE_REG(hw, E1000_STATUS, E1000_STAT_DEV_RST_SET);
+	status = E1000_READ_REG(hw, E1000_STATUS);
+	E1000_WRITE_REG(hw, E1000_STATUS, status | E1000_STAT_DEV_RST_SET);
 
 	/* Clear any pending interrupt events. */
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
-- 
2.43.5

