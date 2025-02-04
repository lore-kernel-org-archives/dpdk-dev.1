Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30482C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10034427AF;
	Tue,  4 Feb 2025 16:12:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4687242798
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681908; x=1770217908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uord3vLxbsMbK30TgZOSM+2WOjd6OgPf/ceKLPC4QP0=;
 b=FL0OR75hWCPHPdDuu/dvbHlzIlwYHwTX6ZY+boD8cl029XwRrCc2Ia2P
 i0TwqIXd8WSH09IQgBww4vjp2eeY7GG/BdH15QXuPfQb+9aWjGCwHr/j6
 jT9haeoSXFiGT6mILLF45g/FbZCZc7sc9ZKnt0uZI9ZapEZOnWmrxQdAP
 L8VEIdcQKI0JI2D+F62Uh+mRqz8MdiWoDzHe7SRAr88/AgiZn0/x7o8NI
 z2TDI7bkE1YWzri8tT7a0W3IPcKvZCqXHfc7hI4HaPQcG8EYCJdp4Tlg/
 GVO77R4Awtd3tEvN7Bc/XFj7Qfg9BTcNFaI25v8ePirpDLExUsQI0FI7h A==;
X-CSE-ConnectionGUID: EltFycCjRNW5XZyRwF0+TQ==
X-CSE-MsgGUID: cSw1oVxsS+KdnUfVSsGUCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097117"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097117"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:47 -0800
X-CSE-ConnectionGUID: kdZQ3nyFR1q9Yhv5LrVhWQ==
X-CSE-MsgGUID: 17zzCmk6TzG7Tsrgv0GIEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792626"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 15/54] net/e1000/base: increase PHY power up delay
Date: Tue,  4 Feb 2025 15:10:21 +0000
Message-ID: <fc512cdad2d37827e278cf6ab01b1a7d493b7fc6.1738681726.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

PHY specification for i225 requires 300 microsecond delay after power up
sequence, so increase the delay after power up to 300 microseconds.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 6e8f4ff4ea..eb0c6d7c53 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -3568,6 +3568,7 @@ void e1000_power_up_phy_copper(struct e1000_hw *hw)
 	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
 	mii_reg &= ~MII_CR_POWER_DOWN;
 	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
+	usec_delay(300);
 }
 
 /**
-- 
2.43.5

