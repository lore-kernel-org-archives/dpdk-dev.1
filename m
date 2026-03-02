Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A977E9B36B
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Mar 2026 11:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BCA740E24;
	Mon,  2 Mar 2026 12:48:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id C6533400D7
 for <dev@dpdk.org>; Mon,  2 Mar 2026 12:48:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772452130; x=1803988130;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FCWDwyXNC1wUsN20I1Xi5KJKOGkoYNDZ1XSkmW9+kUA=;
 b=HqlTzihzqWe2jhiVfNZBpb+VKbXU4DUGVuy23DRIAvdGdgdiUbUzoyHm
 EvxR9fNc8PUWxactymzx3o2H1j8CfDatcj4+IVOviuGqikpXWoCQPB+BL
 tprF1L2jsWdi4YoBv84GCrkW0RKQhqf/qG9ORHssvEjCLg43+aCSHk4nt
 vd+UMzJG8+uhXYSnVzm/uQCfspeSkUK45L4vc5e2OCgBiUATUm1By/CTH
 qjZCI8qWZ6QX7g7+4mTFXV9I1tzzo8hlYjdQ/reJ+VBIls5JuuveKBJ2f
 BghG66yHaclUp8UqKbHIYSAaW+K1B9gCrqCPl58vxcyZumbZajmKjjDxC Q==;
X-CSE-ConnectionGUID: gmoxQ3z0RyWZ5ALuEMXtYA==
X-CSE-MsgGUID: O9+rffa3Si6mzJUWeyx0HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77294773"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="77294773"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 03:48:50 -0800
X-CSE-ConnectionGUID: hv9oeTtXRmCA3QpwRBd8Lw==
X-CSE-MsgGUID: MA5PbVoUTeqm6W6UuWIEew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="222266611"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa005.fm.intel.com with ESMTP; 02 Mar 2026 03:48:49 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 2/2] net/ice: get link status updates via adminq message
Date: Mon,  2 Mar 2026 11:48:42 +0000
Message-ID: <20260302114842.946182-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302114842.946182-1-bruce.richardson@intel.com>
References: <20260227110205.4099981-1-bruce.richardson@intel.com>
 <20260302114842.946182-1-bruce.richardson@intel.com>
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

Rather than relying directly on an interrupt we get link status updates
from the device firmware via adminq messages.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 48 ++++++++++--------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index a59ca2e047..8286816f06 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -1397,7 +1397,9 @@ ice_pf_enable_irq0(struct ice_hw *hw)
 	ICE_WRITE_REG(hw, PFINT_OICR_ENA, 0);
 	ICE_READ_REG(hw, PFINT_OICR);
 
-#ifdef ICE_LSE_SPT
+	/* Enable all OICR causes except link-state-change: LSC is delivered
+	 * as an unsolicited AdminQ get-link-status notification.
+	 */
 	ICE_WRITE_REG(hw, PFINT_OICR_ENA,
 		      (uint32_t)(PFINT_OICR_ENA_INT_ENA_M &
 				 (~PFINT_OICR_LINK_STAT_CHANGE_M)));
@@ -1413,9 +1415,6 @@ ice_pf_enable_irq0(struct ice_hw *hw)
 		      ((0 << PFINT_FW_CTL_ITR_INDX_S) &
 		       PFINT_FW_CTL_ITR_INDX_M) |
 		      PFINT_FW_CTL_CAUSE_ENA_M);
-#else
-	ICE_WRITE_REG(hw, PFINT_OICR_ENA, PFINT_OICR_ENA_INT_ENA_M);
-#endif
 
 	ICE_WRITE_REG(hw, GLINT_DYN_CTL(0),
 		      GLINT_DYN_CTL_INTENA_M |
@@ -1434,7 +1433,6 @@ ice_pf_disable_irq0(struct ice_hw *hw)
 	ice_flush(hw);
 }
 
-#ifdef ICE_LSE_SPT
 static void
 ice_handle_aq_msg(struct rte_eth_dev *dev)
 {
@@ -1453,10 +1451,9 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 		ret = ice_clean_rq_elem(hw, cq, &event, &pending);
 
 		if (ret != ICE_SUCCESS) {
-			PMD_DRV_LOG(INFO,
-				    "Failed to read msg from AdminQ, "
-				    "adminq_err: %u",
-				    hw->adminq.sq_last_status);
+			if (hw->adminq.sq_last_status != 0)
+				PMD_DRV_LOG(INFO, "Failed to read msg from AdminQ, adminq_err: %u",
+						hw->adminq.sq_last_status);
 			break;
 		}
 		opcode = rte_le_to_cpu_16(event.desc.opcode);
@@ -1475,7 +1472,6 @@ ice_handle_aq_msg(struct rte_eth_dev *dev)
 		}
 	}
 }
-#endif
 
 /**
  * Interrupt handler triggered by NIC for handling
@@ -1494,24 +1490,18 @@ ice_interrupt_handler(void *param)
 {
 	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
 	uint32_t oicr;
 	uint32_t reg;
 	uint8_t pf_num;
 	uint8_t event;
 	uint16_t queue;
-	int ret;
-#ifdef ICE_LSE_SPT
-	uint32_t int_fw_ctl;
-#endif
 
 	/* Disable interrupt */
 	ice_pf_disable_irq0(hw);
 
 	/* read out interrupt causes */
 	oicr = ICE_READ_REG(hw, PFINT_OICR);
-#ifdef ICE_LSE_SPT
-	int_fw_ctl = ICE_READ_REG(hw, PFINT_FW_CTL);
-#endif
 
 	/* No interrupt event indicated */
 	if (!(oicr & PFINT_OICR_INTEVENT_M)) {
@@ -1519,20 +1509,8 @@ ice_interrupt_handler(void *param)
 		goto done;
 	}
 
-#ifdef ICE_LSE_SPT
-	if (int_fw_ctl & PFINT_FW_CTL_INTEVENT_M) {
-		PMD_DRV_LOG(INFO, "FW_CTL: link state change event");
-		ice_handle_aq_msg(dev);
-	}
-#else
-	if (oicr & PFINT_OICR_LINK_STAT_CHANGE_M) {
-		PMD_DRV_LOG(INFO, "OICR: link state change event");
-		ret = ice_link_update(dev, 0);
-		if (!ret)
-			rte_eth_dev_callback_process
-				(dev, RTE_ETH_EVENT_INTR_LSC, NULL);
-	}
-#endif
+	/* Always drain the AdminQ on any misc interrupt. */
+	ice_handle_aq_msg(dev);
 
 	if (oicr & PFINT_OICR_MAL_DETECT_M) {
 		PMD_DRV_LOG(WARNING, "OICR: MDD event");
@@ -1581,7 +1559,10 @@ ice_interrupt_handler(void *param)
 done:
 	/* Enable interrupt */
 	ice_pf_enable_irq0(hw);
-	rte_intr_ack(dev->intr_handle);
+	rte_intr_ack(pci_dev->intr_handle);
+
+	/* Re-drain AdminQ to catch events that arrived during the CLEARPBA window */
+	ice_handle_aq_msg(dev);
 }
 
 static void
@@ -4393,6 +4374,7 @@ ice_dev_start(struct rte_eth_dev *dev)
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
+	struct rte_pci_device *pci_dev = ICE_DEV_TO_PCI(dev);
 	struct ice_adapter *ad =
 			ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint16_t nb_rxq = 0;
@@ -4443,6 +4425,8 @@ ice_dev_start(struct rte_eth_dev *dev)
 	if (ice_rxq_intr_setup(dev))
 		return -EIO;
 
+	rte_intr_enable(pci_dev->intr_handle);
+
 	/* Enable receiving broadcast packets and transmitting packets */
 	ice_set_bit(ICE_PROMISC_BCAST_RX, pmask);
 	ice_set_bit(ICE_PROMISC_BCAST_TX, pmask);
-- 
2.51.0

