Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CAFC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E11C440274;
	Thu, 10 Sep 2026 17:08:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id F40404025F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 17:08:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789052929; x=1820588929;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CUbkJLDlw3PPhMZa7X/MqntHWeZYEQhb8ntU9pN27+A=;
 b=EjYjlRiziVgVyIrhKK12aJ/sJ1UdDk0INKbhe6k2ptxkgr1dgXbqpiPg
 IuNDtwt5WwyBFEwG0puzZBpm3N/TT1VY1bCALkoWwXSxzo7Deh5Ij3EjX
 z+SWMzqzpajyf0dk1n95mRku1TJwblltMSa7Prk7ZktWm71V0F/nsCZKs
 5MOkF42bv2F1NyU365ONVRdMkyXbjZWw1dOW28FCPYClJ851zPl40PcQT
 UgisJGmwjQGAHOvedMWBShJjwJEFLKFjqymO+1sIOhpobFVCleJS12Dg7
 7raXekonjPxhFD8vYynNYmUJ7+9GB9taNwTCGU6Zm8OfuqgEQ0Tc0d2WT Q==;
X-CSE-ConnectionGUID: /+gBe2idTDOOIoTHpsutIQ==
X-CSE-MsgGUID: eK/jOzXYSI+4D83RcnvtOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89438689"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89438689"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 08:08:40 -0700
X-CSE-ConnectionGUID: 8y9qQeEcS72QR06u8SP4Ow==
X-CSE-MsgGUID: MMC8nr+ZRVixgkNWN4jAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270312465"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by orviesa010.jf.intel.com with ESMTP; 10 Sep 2026 08:08:39 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 2/2] net/ice: disable link negotiation for fixed speed
 selection
Date: Thu, 10 Sep 2026 16:08:17 +0100
Message-ID: <20260910150817.1521317-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910150817.1521317-1-bruce.richardson@intel.com>
References: <20260910150817.1521317-1-bruce.richardson@intel.com>
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

When the user has requested fixed link parameters, e.g. speed, duplex,
etc., disable the HW link negotiation, i.e. AN Clause 28, Clause 37 etc.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index dc955d130b..592e7c4c21 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -124,7 +124,8 @@ static int ice_dev_info_get(struct rte_eth_dev *dev,
 			    struct rte_eth_dev_info *dev_info);
 static int ice_phy_conf_link(struct ice_hw *hw,
 					u16 force_speed,
-					bool link_up);
+					bool link_up,
+					bool link_autoneg);
 static int ice_link_update(struct rte_eth_dev *dev,
 			   int wait_to_complete);
 static int ice_dev_set_link_up(struct rte_eth_dev *dev);
@@ -4941,13 +4942,15 @@ ice_apply_link_speed(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	return ice_phy_conf_link(hw, speed, true);
+	bool link_autoneg = (conf->link_speeds & RTE_ETH_LINK_SPEED_FIXED) == 0;
+	return ice_phy_conf_link(hw, speed, true, link_autoneg);
 }
 
 static int
 ice_phy_conf_link(struct ice_hw *hw,
 		   u16 link_speeds_bitmap,
-		   bool link_up)
+		   bool link_up,
+		   bool link_autoneg)
 {
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
 	struct ice_port_info *pi = hw->port_info;
@@ -4991,6 +4994,10 @@ ice_phy_conf_link(struct ice_hw *hw,
 
 	cfg.caps = phy_caps->caps | ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
 	cfg.low_power_ctrl_an = phy_caps->low_power_ctrl_an;
+	if (!link_autoneg)
+		cfg.low_power_ctrl_an &= ~(ICE_AQC_PHY_AN_EN_CLAUSE28 |
+				ICE_AQC_PHY_AN_EN_CLAUSE73 |
+				ICE_AQC_PHY_AN_EN_CLAUSE37);
 	cfg.eee_cap = phy_caps->eee_cap;
 	cfg.eeer_value = phy_caps->eeer_value;
 	cfg.link_fec_opt = phy_caps->link_fec_options;
@@ -5018,7 +5025,7 @@ ice_dev_set_link_down(struct rte_eth_dev *dev)
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	uint8_t speed = ICE_LINK_SPEED_UNKNOWN;
 
-	return ice_phy_conf_link(hw, speed, false);
+	return ice_phy_conf_link(hw, speed, false, true);
 }
 
 static int
-- 
2.53.0

