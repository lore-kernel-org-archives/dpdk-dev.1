Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71535CA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AB8242E44;
	Wed,  7 Oct 2026 12:50:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6D96040DCF
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370257; x=1822906257;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2Vj4I/MC84eCA3XrktF6rKihUM5A3WQvcymMPJ39M8g=;
 b=hSbSutaA/BLZwntyxOfy2Y7NyP4B50Dms4SL+DYdag4UQf3Yncgv20Sq
 6aTL+LqBv5InbTN9GSSMcJY9o1iVVH9D/ORKRvqybv2dR0MLSqxa6c3Ck
 j2nDn3vmvlh3zaUSzOGfKk0UqMFA9E9uTAou5TXmioHYI4RXJY8idrvtC
 i6SXhxHnW3K6Mt7sa/AqJCQlwjjtyav8NhMzTqJtwcMqk07ho3+G9l2pn
 QThtAOMS5d1fHale8arGOEzA9hmZhbPzgzsUodA5F6HKIP+BfjGEGDMiD
 LYZ9EwgLx27ZcoKSTCJbIULURXlNUoDx60fsRkC/ltoNKNgrnmxBIK44n Q==;
X-CSE-ConnectionGUID: YPgobwiGRkK/PpIuJBcQ3Q==
X-CSE-MsgGUID: y4zLRmAmT6ispV/c5GZfzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121831"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121831"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:56 -0700
X-CSE-ConnectionGUID: eCczLcfbTVWcqVhDMGAHaQ==
X-CSE-MsgGUID: V6c6WtVBTLuWPrriUJgB1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652151"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:55 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 18/25] net/ixgbe: advertise flow keep capability
Date: Wed,  7 Oct 2026 11:50:13 +0100
Message-ID: <e024f7ec094acd9cb4fb8a7aa8c97102f0fb607b.1791369981.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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

The ixgbe driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst | 7 +++++--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index b23eb389f7d..f4d88938bc3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -103,8 +103,11 @@ New Features
 
 * **Updated Intel ixgbe driver.**
 
-  Added ``fdir_buffer_size`` devarg to select the Flow Director table size
-  (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+  * Added ``fdir_buffer_size`` devarg to select the Flow Director table size
+    (``64k``, ``128k`` or ``256k``) at probe time. The default remains ``64k``.
+
+  * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
+    as flow rules were already kept across device restart.
 
 * **Updated NXP DPAA2 ethernet driver.**
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index cccc20980f2..0dd26ac974b 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3916,6 +3916,9 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->reta_size = ixgbe_reta_size_get(hw->mac.type);
 	dev_info->flow_type_rss_offloads = IXGBE_RSS_OFFLOAD_ALL;
 
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+
 	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_10G;
 	if (hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T ||
 			hw->device_id == IXGBE_DEV_ID_X550EM_A_1G_T_L)
-- 
2.52.0

