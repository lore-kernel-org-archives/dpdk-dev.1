Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2CEDF150
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:26:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3C834060A;
	Fri, 13 Feb 2026 11:26:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id A374A40287
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:26:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978411; x=1802514411;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=i7bZiy9CGmI+DrrUZy/uGj5tQ16NiPUg4OXoIYlnC1Y=;
 b=DqLltFG8gP+Blchtq6XNHqBPkh2GlIJV1Lqhcg+pT5KI36pMvEIS+a0Z
 sFqAa9FoP4FDlE9grwHVtVaVy3K97iEE+iAAqQ4RG/25dUIYaZprfkezI
 Gzq+D4/rWe4JkLWKGo2wj2lGVj5L5SIrm54oelt6mvxk2+FqW5XisFJQv
 OkXmO8IRkK0PETf1MCdmbQlsrvsitBhfR81MHmacQkqUKI3XqM5f7Oq9M
 P4LTW6ms1hlX32SI/mt2Gx2Ho/49ue2B+aWOLn66YEyK90ZtnIVy39Y3g
 GXEaI8nru7Gb56wId6P611C04Wr8JvEDmVjMRR+GdMvGXugWYmcAraowJ g==;
X-CSE-ConnectionGUID: VT5Lety1TxC4uANXUUdknw==
X-CSE-MsgGUID: 7bGEkUt8RYGVRTmXof1Q8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603063"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603063"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:26:50 -0800
X-CSE-ConnectionGUID: 26EMCdvfTkuofV3c6/nY/Q==
X-CSE-MsgGUID: 03QyaoDUSKqlC99bah0SeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028027"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:26:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 01/27] net/ixgbe: remove MAC type check macros
Date: Fri, 13 Feb 2026 10:26:12 +0000
Message-ID: <f0047b363fea648bf7b6815889c0b26b883f56c5.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

