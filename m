Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344CCC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:47:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92B9242E6A;
	Fri,  7 Feb 2025 13:46:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id CA0C242E15
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932366; x=1770468366;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DL+lr0sLlv/m1xax7zF0nhmdXee/dTBiOHPU01q9dNo=;
 b=VFP8r2UiBU3AsoYTt3oGA00lobBWgrzU2YYQfsx26xfH05EDKK3/od1m
 xAZSIGmRqCAvy92fQra+u3pPOxhjC52qbD8AGRSEbNrBM7sNQHoLBfISv
 5nzx/3/QgfYSiQ8YQVKBM+QD3X/FuMoow+mc2JLnjcUm8OVgGtTxcFsc2
 wGsbcax5J88dAmYK+5as3GP1U6KHyrnvPPGNvqI6Q5VlLkcZmZJURIzXX
 hviD/NO/yFSFzTX79s8fa0cBfh+xhuQ7qGwduvl718Mys1I5KN53o5sDx
 KIk6KEqTIni6MjIi6yixUOjIhhO64MwvqilsEbGRz2uYy0DSkxchqUksB w==;
X-CSE-ConnectionGUID: 8P6VdxU4TEWw2oxWp80Osw==
X-CSE-MsgGUID: M1h0G+A4RTSd8lDYA0mKMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331774"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:06 -0800
X-CSE-ConnectionGUID: eNKLVNp7SP6f05LGmjpupw==
X-CSE-MsgGUID: Is/a2/C6RYWE2sHC3wEiqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953569"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 12/36] net/e1000/base: add PHY power management control
Date: Fri,  7 Feb 2025 12:45:04 +0000
Message-ID: <872a0eb37e95919957937619f2b3b2e00bf3bdb4.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

PHY power management control is expected to provide a reliable and
accurate indication of PHY reset completion, which allows us to decrease
the delay time after a PHY reset.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  2 ++
 drivers/net/intel/e1000/base/e1000_phy.c     | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 2037e006c4..2c3b806c92 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1100,6 +1100,8 @@
 
 #define PHY_CONTROL_LB		0x4000 /* PHY Loopback bit */
 
+#define E1000_PHY_RST_COMP	0x0100 /* Internal PHY reset completion */
+
 /* NVM Control */
 #define E1000_EECD_SK		0x00000001 /* NVM Clock */
 #define E1000_EECD_CS		0x00000002 /* NVM Chip Select */
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index 4b6401b06a..d3d7ff6ba8 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -2918,6 +2918,10 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
+	if (hw->mac.type == e1000_i225) {
+		E1000_READ_REG(hw, E1000_I225_PHPM);
+	}
+
 	ctrl = E1000_READ_REG(hw, E1000_CTRL);
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_PHY_RST);
 	E1000_WRITE_FLUSH(hw);
@@ -2927,7 +2931,17 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl);
 	E1000_WRITE_FLUSH(hw);
 
-	usec_delay(150);
+	if (hw->mac.type == e1000_i225) {
+		u32 phpm = 0, timeout = 10000;
+		/* SW should guarantee 100us for the completion of the PHY reset */
+		usec_delay(100);
+		do {
+			phpm = E1000_READ_REG(hw, E1000_I225_PHPM);
+			timeout--;
+			usec_delay(1);
+		} while (!(phpm & E1000_PHY_RST_COMP) && timeout);
+	}
+	usec_delay(100);
 
 	phy->ops.release(hw);
 
-- 
2.43.5

