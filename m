Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAC9E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:23:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0873C4060C;
	Thu, 19 Feb 2026 17:23:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 9DD24402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518200; x=1803054200;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HncUITjFb1xs8u27TBgmMBbGkV24vE/hXS/mkaG9/y4=;
 b=LZZCLx46LYqBYvIYj5TRwqMhUiBd4ocVg0GmkNB6ZOndnqFjCrUlfhBS
 KZugZrhe4kIhBE4LiOUBYYZxRIoNVMleQydEZ9csXTVXqYaMItacUdjQt
 l5q4HbNCVUzvwAaqMI+WSpxsAn/q5aqeYF1siZoGQL2moR9lUyN3tAjVk
 43EaxxDFHbqWvsRae9MZ0/StSZLbHKiav8DzVZiA/fRzYd+xNxAJJLp0i
 9ZYUl5JcBYXQXTXykBMUXEHlbgW3a2y2Uqv8gDJVgAi86f8gskAwGinr0
 AbbxfYs+9cWZaoEP26Yc0cAfXy9nl74SqYKfErt3mCe3+C6oj1wX1QSar A==;
X-CSE-ConnectionGUID: BbswAS+RRNem5AvD+rVcpg==
X-CSE-MsgGUID: /m/JyC8oTwySpeVCALhKXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231422"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231422"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:19 -0800
X-CSE-ConnectionGUID: qascqlD5TkqRpdDhXGLbaw==
X-CSE-MsgGUID: hXDjku70Rk6vOtHB0w81Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699779"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 01/27] net/ixgbe: remove MAC type check macros
Date: Thu, 19 Feb 2026 16:22:44 +0000
Message-ID: <0f044de7025d3b68236fbb4ccb26513644512bc7.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

