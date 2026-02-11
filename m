Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921BEE9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D8C540648;
	Wed, 11 Feb 2026 14:53:35 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0251B4026A
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818014; x=1802354014;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vkvpH9u2HRk8b0SZZ59F4T9csJb4aZR6h/MrQBMxfxA=;
 b=b5M7CFTJbVtZZaF79ofg4Wf8+uD6O66zfiI3naMFkBMN3NGW3bAbe29e
 Y9I3dsWrOmAsqT8DGZAeLOcj3kTmytsy2TACCoXz17iUlnQsjeJh0TAVP
 WmcGsmdpPv0gWMTbCIiEHU/lYU3VDPrbE9/bVVSCxZd4OPMCib9s/dVXW
 CSmXupDIVCwlv/YIMiXKyFOza80Swh1Hai9+VwZB/5zcL0coJ/E+xVaPs
 xr79D6fkOfCgeR1dCzwtJZyMIr85DCdiGFKt7kj2GKUKKoL0OXWAcvQrC
 oVoEaZVmcI/XdufcgELr3PUQAV42kurykQ/jAr1ASEOJdYqRq4vFT9LKe Q==;
X-CSE-ConnectionGUID: 5F3O264nR1CO+7zbvcOM2g==
X-CSE-MsgGUID: uKThnBX7RPeQZ4h5R7zvGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808225"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808225"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:33 -0800
X-CSE-ConnectionGUID: BAT/anCxQC608J/JUwVdcA==
X-CSE-MsgGUID: rNFKDPn7TCO5NegN4p6g+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359555"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:32 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 01/27] net/ixgbe: remove MAC type check macros
Date: Wed, 11 Feb 2026 13:52:43 +0000
Message-ID: <e9fa029039ae5da4f3ec3533a4d826210a6a1d2e.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
References: 
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

The macros used were not informative and did not add any value beyond code
golf, so remove them and make MAC type checks explicit.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 12 ------------
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 5dbd659941..7dc02a472b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -137,18 +137,6 @@
 #define IXGBE_MAX_FDIR_FILTER_NUM       (1024 * 32)
 #define IXGBE_MAX_L2_TN_FILTER_NUM      128
 
-#define MAC_TYPE_FILTER_SUP_EXT(type)    do {\
-	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540)\
-		return -ENOTSUP;\
-} while (0)
-
-#define MAC_TYPE_FILTER_SUP(type)    do {\
-	if ((type) != ixgbe_mac_82599EB && (type) != ixgbe_mac_X540 &&\
-		(type) != ixgbe_mac_X550 && (type) != ixgbe_mac_X550EM_x &&\
-		(type) != ixgbe_mac_X550EM_a && (type) != ixgbe_mac_E610)\
-		return -ENOTSUP;\
-} while (0)
-
 /* Link speed for X550 auto negotiation */
 #define IXGBE_LINK_SPEED_X550_AUTONEG	(IXGBE_LINK_SPEED_100_FULL | \
 					 IXGBE_LINK_SPEED_1GB_FULL | \
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 066a69eb12..61a328363d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -621,7 +621,9 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
-	MAC_TYPE_FILTER_SUP_EXT(hw->mac.type);
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540)
+		return -ENOTSUP;
 
 	ret = cons_parse_ntuple_filter(attr, pattern, actions, filter, error);
 
@@ -861,7 +863,13 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
-	MAC_TYPE_FILTER_SUP(hw->mac.type);
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
 
 	ret = cons_parse_ethertype_filter(attr, pattern,
 					actions, filter, error);
@@ -1150,7 +1158,13 @@ ixgbe_parse_syn_filter(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
-	MAC_TYPE_FILTER_SUP(hw->mac.type);
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540 &&
+			hw->mac.type != ixgbe_mac_X550 &&
+			hw->mac.type != ixgbe_mac_X550EM_x &&
+			hw->mac.type != ixgbe_mac_X550EM_a &&
+			hw->mac.type != ixgbe_mac_E610)
+		return -ENOTSUP;
 
 	ret = cons_parse_syn_filter(attr, pattern,
 					actions, filter, error);
-- 
2.47.3

