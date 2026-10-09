Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2649ECA6019
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:01:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED5C540E1D;
	Fri,  9 Oct 2026 12:59:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 6FD8740E0C
 for <dev@dpdk.org>; Fri,  9 Oct 2026 12:59:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791543590; x=1823079590;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OfzZXVcrwzhGjr3TZ+Tbmm/T110ZFLdDfrx2Oe0a7hU=;
 b=kRiYtDpHt13yvvFEtTgrryoX3EmEuLnY5XHcuPzuSiKzqmxzXlnoUvMD
 z8mYpM0y3tjUbir2DU6LfKD/DRxevEGDHlXH+mOAV8mnu5of4biNFQqlC
 7bu1W6jqMwkQpRYYjRtRmAdzsSu7oWtsKlxlUREWLRqoYcchGAvzOQHUJ
 etwa5zivivEQKw4t6tshTI/i+P795nZT1XTxpilLX6r/VUhqkl/8rG9sA
 yUekJPHPhNYf+rEWe0hsICA4kmweqs4hN6cKNqe7hNnxM4SCM+WuniUV1
 39eekU3AoKMauKZ4ykzbhrE/mUyO+eyeeoOZGSILAzkjE7MaqhJWNL+/V A==;
X-CSE-ConnectionGUID: ARr7SCArRguqErZtW1qUzw==
X-CSE-MsgGUID: KJLL3f+ISouIj9NoRzLecA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="241441"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="241441"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 03:59:50 -0700
X-CSE-ConnectionGUID: 5QIsaFk6SaGcXWX9ljQNZg==
X-CSE-MsgGUID: phPEwBmnTW69PkcVbuh5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2088439"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 09 Oct 2026 03:59:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 18/25] net/ixgbe: advertise flow keep capability
Date: Fri,  9 Oct 2026 11:59:08 +0100
Message-ID: <f78800b563ad310ad06dffc586e62717e85d4e11.1791543155.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791543153.git.anatoly.burakov@intel.com>
 <cover.1791543153.git.anatoly.burakov@intel.com>
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
index d5a9b295e94..c7b20a9205a 100644
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

