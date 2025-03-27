Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19A8C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 14:24:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E379040DD6;
	Thu, 27 Mar 2025 15:24:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 1641E402E6
 for <dev@dpdk.org>; Thu, 27 Mar 2025 15:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743085459; x=1774621459;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=W2HpVcR4n1j5FJjvgJwdLteFM3t8y26uysd9NkelObc=;
 b=VoWD4s2ymjfTpJHe6AEO+U/rMKJCG0iZjH6ehl/1AI4CBvsJWabTaBcW
 EmAlAww9eLmxgobU/pGjg1/dNuEn5Iz/m7sLM2O8sSZe47CrB+Hyig4Je
 soVMcR/mn07sBsp6iG2xdnN7OmiljwYhl1XHLAHzArZam/OYZ8gwV/CH+
 9EFsm33PZ1+YsgQQ1uyrWvFKAkkFJE6yG0F+R19pcZ/LzsZTtqC4BT10w
 Y+KQDuZnqqfjfbSRqSNfeGQcObHTPIIDRSNwlFmrExm6r7eSzZxudyMbA
 9gLLZDC1k/hkRq+r1fuuISotoQR6GlN+BQgjpEMM5vxA+Gtbm5anUvvpl Q==;
X-CSE-ConnectionGUID: GXOKYWGnTZySll0E+fCXfQ==
X-CSE-MsgGUID: wbatd6EPQBKo0gzymXVnVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="54620731"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="54620731"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 07:24:17 -0700
X-CSE-ConnectionGUID: fgKEn9JlQdGxXSoFOSyGWQ==
X-CSE-MsgGUID: j2A+qsRVSJCxopTIzPrfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125171301"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa006.jf.intel.com with ESMTP; 27 Mar 2025 07:24:16 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v1 1/3] net/ixgbe: use check for VF function
Date: Thu, 27 Mar 2025 14:24:11 +0000
Message-ID: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

In a couple of places, we are using explicit mac type comparisons to
trigger a VF-specific path, but we already have a function that does the
same thing, so use it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 0c8a9ec763..b216e0612a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -87,6 +87,9 @@
 #define rte_ixgbe_prefetch(p)   do {} while (0)
 #endif
 
+/* forward-declare some functions */
+static int ixgbe_is_vf(struct rte_eth_dev *dev);
+
 /*********************************************************************
  *
  *  TX functions
@@ -2766,12 +2769,7 @@ ixgbe_dev_tx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modification to set VFTDT for virtual function if vf is detected
 	 */
-	if (hw->mac.type == ixgbe_mac_82599_vf ||
-	    hw->mac.type == ixgbe_mac_E610_vf ||
-	    hw->mac.type == ixgbe_mac_X540_vf ||
-	    hw->mac.type == ixgbe_mac_X550_vf ||
-	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
-	    hw->mac.type == ixgbe_mac_X550EM_a_vf)
+	if (ixgbe_is_vf(dev))
 		txq->qtx_tail = IXGBE_PCI_REG_ADDR(hw, IXGBE_VFTDT(queue_idx));
 	else
 		txq->qtx_tail = IXGBE_PCI_REG_ADDR(hw, IXGBE_TDT(txq->reg_idx));
@@ -3154,12 +3152,7 @@ ixgbe_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	/*
 	 * Modified to setup VFRDT for Virtual Function
 	 */
-	if (hw->mac.type == ixgbe_mac_82599_vf ||
-	    hw->mac.type == ixgbe_mac_E610_vf ||
-	    hw->mac.type == ixgbe_mac_X540_vf ||
-	    hw->mac.type == ixgbe_mac_X550_vf ||
-	    hw->mac.type == ixgbe_mac_X550EM_x_vf ||
-	    hw->mac.type == ixgbe_mac_X550EM_a_vf) {
+	if (ixgbe_is_vf(dev)) {
 		rxq->rdt_reg_addr =
 			IXGBE_PCI_REG_ADDR(hw, IXGBE_VFRDT(queue_idx));
 		rxq->rdh_reg_addr =
-- 
2.47.1

