Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA1C3600B
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Mar 2025 15:12:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EE4940DDE;
	Thu, 27 Mar 2025 16:12:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 78B0140DD6
 for <dev@dpdk.org>; Thu, 27 Mar 2025 16:12:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743088349; x=1774624349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W2HpVcR4n1j5FJjvgJwdLteFM3t8y26uysd9NkelObc=;
 b=TuJAq9cY02SxInVRFz5D7K8Fs5YC6SQ2HXc9qa2RCIr4LudEyq08l+Y6
 2feZZW2+yXEIP0Jc+LjGFYO9QuXKdgBARfXXEagUyqTDzVvlz9lxBGlGU
 HCc47Y/3R+lNb0E0eDTgzpJXOIeHAC/8mf7wVBWajGN0k1cWb3WhPUgc0
 lwli/muFhyKxnjOWv89GKEfKHPGQCjWO8yUwuoYHclesowZWVcXfu+FhS
 YZMmenoYtf+wmd/S2IeIvxq7wRDEFp/5Kqu/Cnao/NeRRvJUfCTgcEfV0
 QaAkSmrtppLRzWv0uXtSYvBma91We/S0Xnu39d3Rbc0G8MVuM0vvk3IUM Q==;
X-CSE-ConnectionGUID: sOKwddlXT/Oau7/xa7t1KA==
X-CSE-MsgGUID: yOnSgDV6TWOvSxvsizovig==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="61959389"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="61959389"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 08:12:23 -0700
X-CSE-ConnectionGUID: H3pTCeeSSvqvRoh4OXvFLw==
X-CSE-MsgGUID: jEUszJJ1QXOya9iukBeYjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="156162851"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 27 Mar 2025 08:12:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 1/3] net/ixgbe: use check for VF function
Date: Thu, 27 Mar 2025 15:12:17 +0000
Message-ID: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743088329.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
References: <91f6e1e3f59faf66e6d5f32e4198bfd13b30a317.1743085431.git.anatoly.burakov@intel.com>
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

