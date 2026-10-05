Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D65CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A320940EDF;
	Mon,  5 Oct 2026 18:39:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id CB9A340E96
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218338; x=1822754338;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ot4Wz1CCB8fMPkHjB6t62Z9P2EdpmlnKJ25M2lqYAjM=;
 b=Twu7dkoDjO2G7mwwwr3eCOkGp/aZFv/ohnYE/0HSKmJe9Wo7ud3x8kh7
 7fOb26SZO4au/CRNfI7iaja9LKo8aXU3mBWh8LVAnXjkF9TUah0IYlgKK
 hrGVKZxsRCSWEQMBWWDuwn07RLm2iluDUzU4+YA6pv1ji0PaHDdqhzJlx
 EW2D0uz1FimlDSsOK4upqhw0YcCs1/YdNlRhN3VwdCulUig4sEOJJyE6t
 /XphFozBFzW59PckmFjLbW1gXQ04lEFlbDIRedBZ0OUnWi1la0Xr0EZY1
 wVYZPog1FIjQBeZM0PStWoXpI0m1Foa8l+ldVOPe62V/bcLl/VbkVhPZW g==;
X-CSE-ConnectionGUID: 2E2fnycRSTOqxnCIrVf9zA==
X-CSE-MsgGUID: rPWFqVygQoai3L39i3yc+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665343"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665343"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:57 -0700
X-CSE-ConnectionGUID: R4k6r0/NTCGEYQZ3SUiFuA==
X-CSE-MsgGUID: N/wlsQfiQw26vJ7F7jMAtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945784"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 17/24] net/ixgbe: advertise flow keep capability
Date: Mon,  5 Oct 2026 17:38:12 +0100
Message-ID: <5c45b3b53333a9c92837ef6be20e4399f306b081.1791218156.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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
index 52a54117b78..5200fab866d 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -3914,6 +3914,9 @@ ixgbe_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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

