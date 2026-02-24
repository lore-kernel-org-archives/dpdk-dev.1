Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB45F3C997
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:14:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02406402ED;
	Tue, 24 Feb 2026 16:14:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEF7400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946082; x=1803482082;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HncUITjFb1xs8u27TBgmMBbGkV24vE/hXS/mkaG9/y4=;
 b=f+BsBMxzjuJXcoSIqAVT761UhxFfZ5gDHSQ2yRvzT050Z+fKzDy2IZlu
 JQSh+SpOyuVPhTt9IwT/adv5qn0ag0Emo2QSAxxxk4siJgD63QrrzlpFu
 aRxjf/imTeHWBgEJEx/PJWHhFlhrGSquVhGFmYD+oPdgeWnyutPZYh59G
 FEt7fxrO8F3yHU6pRDmLx/HYX+vwDXOt2o0EJ1xgJcaJy5ETHiIrlTtyG
 45aVn04TX25nUCGZ0tokFGsGAJW/n9wvqmtZ65pG00lfCN6+KSRBdOtTr
 SZmlLAXvCXScAJ/UOEqtUzgcuDMIkm8O8+dsk8hqpwS1fDbnrkuxN/54h A==;
X-CSE-ConnectionGUID: u4c6PxDKR26BK7m3jZvUkQ==
X-CSE-MsgGUID: 9QQIPQWzQiG79ys+Lnbaew==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056235"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056235"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:41 -0800
X-CSE-ConnectionGUID: +Q1nF8LdQeq0YRK7Gt889Q==
X-CSE-MsgGUID: bZ62JUCJS0CKKyQXMwck1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526066"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v9 01/26] net/ixgbe: remove MAC type check macros
Date: Tue, 24 Feb 2026 15:14:06 +0000
Message-ID: <4da12ca72e34a674d91ab7463000d369cf6947f9.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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
index 6a7edc6377..c8d6237f27 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -654,7 +654,9 @@ ixgbe_parse_ntuple_filter(struct rte_eth_dev *dev,
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 
-	MAC_TYPE_FILTER_SUP_EXT(hw->mac.type);
+	if (hw->mac.type != ixgbe_mac_82599EB &&
+			hw->mac.type != ixgbe_mac_X540)
+		return -ENOTSUP;
 
 	ret = cons_parse_ntuple_filter(attr, pattern, actions, filter, error);
 
@@ -894,7 +896,13 @@ ixgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
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
@@ -1183,7 +1191,13 @@ ixgbe_parse_syn_filter(struct rte_eth_dev *dev,
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

