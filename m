Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C425EA8130
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:14:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CDA5240697;
	Tue, 10 Feb 2026 17:14:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A2E8F40677
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740049; x=1802276049;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+VitgqdSj+SJhl+szIBg9z2h9niAe0VvQoh81CGOesU=;
 b=HDzVthWWX9em5dwOArsqvDjZkiCH5RO+Y7jcxkMqBCnFvhIZKRbwUmfK
 q0BLirfa/A5jPmyY1Md41bbsFKXMihV4WiR4YASKvru6kcPRoi4b0Zdfm
 n0OKrZOdjTNZZLItXsuD6J5j79587W5lIFZ77jOqfpngLZRZR5Ccv2347
 w1635+IYaAMdoJFYeKl3VoCSss4gJSFMBmrgB0OOz9QN+WlHjQSa4QfWU
 zon5L33DtPDcbJd5XVOJv3SMzwigDmvKgP4EO+gYAXgKhbhfxvKgi82K3
 1lFJ+lGvpviSHeuCQdyAYnm0X4piP9bwrvCuDNOiLCFkkNL2Ev147vk2G Q==;
X-CSE-ConnectionGUID: dhybOMyEQU+XtKoOH7g+Kg==
X-CSE-MsgGUID: ctSovBMLSQeEK+G9/CKBCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286176"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286176"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:05 -0800
X-CSE-ConnectionGUID: ef1GE6RtSdqdEcW9jB52Qw==
X-CSE-MsgGUID: zpd2TCNoQsiNuNUs86LCrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127707"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:05 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 01/26] net/ixgbe: remove MAC type check macros
Date: Tue, 10 Feb 2026 16:13:30 +0000
Message-ID: <684868caadd5ae593db0663610f3b7511d764590.1770739924.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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
index 5393c81363..55b121b15d 100644
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
index 27d2ba1132..a1245bb906 100644
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

