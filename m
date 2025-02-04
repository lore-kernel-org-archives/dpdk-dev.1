Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD813C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29A11427A0;
	Tue,  4 Feb 2025 16:11:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7B2534275A
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681904; x=1770217904;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2xr9rD7hNn4lcy/+tpcTzpKTTLCkXIbaos7w3sUDUMQ=;
 b=HWtvaOxQ5cml/XzQCHfnvD6/1u8jSOC5wXrzlaZiz3nIT6twLyE3Fjou
 M67pq5S62Z9ToF3Qgnv21IRg5xNgsl8yhNXsmo9M9dmXDU7pD0mldbaYB
 13CbssbOc0HGfl5Nxd5OkrlhXoKkpnot7no4y8PnbEaQxosYwdh73V0Uf
 KY4jlVRxE6EnzMWHuXhFIEVdVKLtDUjrHFFxpQq15dLq4WDC1fQeYeUCi
 CGXWDl2Rdvk9noGs2fD1uMWCymd/5q6n7ANByixQdm3CxsFMGxOgEHbDi
 By1thybuk/3HpwQ/ZV7x5kNIUHCO5LlGW6K+q1u20uutLr02Nb4JpnEaI Q==;
X-CSE-ConnectionGUID: GSCee4P4TCmMG32EEh1x1g==
X-CSE-MsgGUID: mKhtarnDTBOMkXdD+zm6/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097110"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097110"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:44 -0800
X-CSE-ConnectionGUID: 72ekFzYMSFKoENw7V4I43Q==
X-CSE-MsgGUID: KxZI/W6ORJOzO6XzxxfUlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792608"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 12/54] net/e1000/base: add PHY power management control
Date: Tue,  4 Feb 2025 15:10:18 +0000
Message-ID: <5b24f60fc0b4bb1cdbf0fecaf49031bd40816cc3.1738681726.git.anatoly.burakov@intel.com>
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

It is expected that PHY power management control should provide a reliable
and accurate indication of PHY reset completion and decrease the delay time
after a PHY reset.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h |  2 ++
 drivers/net/intel/e1000/base/e1000_phy.c     | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index b1e616781e..8dfdce7dad 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -1099,6 +1099,8 @@
 
 #define PHY_CONTROL_LB		0x4000 /* PHY Loopback bit */
 
+#define E1000_PHY_RST_COMP	0x0100 /* Internal PHY reset completion */
+
 /* NVM Control */
 #define E1000_EECD_SK		0x00000001 /* NVM Clock */
 #define E1000_EECD_CS		0x00000002 /* NVM Chip Select */
diff --git a/drivers/net/intel/e1000/base/e1000_phy.c b/drivers/net/intel/e1000/base/e1000_phy.c
index ff37a54b6b..6e8f4ff4ea 100644
--- a/drivers/net/intel/e1000/base/e1000_phy.c
+++ b/drivers/net/intel/e1000/base/e1000_phy.c
@@ -2917,6 +2917,10 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
 	if (ret_val)
 		return ret_val;
 
+	if (hw->mac.type == e1000_i225) {
+		E1000_READ_REG(hw, E1000_I225_PHPM);
+	}
+
 	ctrl = E1000_READ_REG(hw, E1000_CTRL);
 	E1000_WRITE_REG(hw, E1000_CTRL, ctrl | E1000_CTRL_PHY_RST);
 	E1000_WRITE_FLUSH(hw);
@@ -2926,7 +2930,17 @@ s32 e1000_phy_hw_reset_generic(struct e1000_hw *hw)
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

