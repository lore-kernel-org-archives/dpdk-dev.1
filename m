Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30321CD13DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2543A40A6E;
	Thu, 30 Apr 2026 13:15:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 445DF406BB
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547702; x=1809083702;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=NnWi0Ag/8MSfI+6WeWfp19X7ycvvi0rZtoUWCFZ1uPg=;
 b=oHvOAwqiII3AiKPbA4w/N2NqyKWa1/MBfDl5WLYhPf7R2IgpoQghhqSd
 19/guCfASRUhjFF9SWPbkyco3KgTVrwHXoscqpfanemKzvdatBgl41kfJ
 HIQGvOGQC23rCfSREEJZ/g2o90uokUA5K23k7ev80y92qRQvdXMaFRn+r
 Z0od1QGELT3B37nqkZ0gYzj6TFJKsBA8vkMbOPIfkmaT5VGHY13+pTW0f
 8TuBusG6KYpMBXkyBKWbkEMkm+wm1lQD6Wba3p8x+UyiQU7Dn+EsTeVdH
 ButD2z1bJlllafxoCLu8dlz47v9TjUl7Hp6mqd/RehDgfvdfZuUVifQEJ g==;
X-CSE-ConnectionGUID: zFJbulLDTrG9JlO/kKysUg==
X-CSE-MsgGUID: nEjB665DTZmAgpSDNoO5dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482273"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482273"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:02 -0700
X-CSE-ConnectionGUID: 2l8YZFGzRquBAzWMJmeaaA==
X-CSE-MsgGUID: KVF/s8pRRnm2v+hWFaRFUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444748"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:02 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 07/15] net/ixgbe: store max VFs in adapter
Date: Thu, 30 Apr 2026 12:14:36 +0100
Message-ID: <359f4b27c0f27fb23f88f0e576ba0a7c508671e8.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
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

Currently, `rte_flow`-related checks use `rte_eth_dev` to check for max
VFs. With coming rework of flows, the aim is to make the code as
multiprocess agnostic as possible, and `rte_eth_dev` pointer is
process-local.

To support this in VF-related checks, cache max_vfs in ixgbe adapter
during device init and read it in the rte_flow check paths to avoid direct
dependency on `rte_eth_dev`.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 ++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 1 +
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 5c95507d60..1c4a2e1177 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1084,7 +1084,7 @@ ixgbe_parse_devargs(struct ixgbe_adapter *adapter,
 static int
 eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 {
-	struct ixgbe_adapter *ad = eth_dev->data->dev_private;
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(eth_dev->data->dev_private);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct ixgbe_hw *hw =
@@ -1151,6 +1151,7 @@ eth_ixgbe_dev_init(struct rte_eth_dev *eth_dev, void *init_params __rte_unused)
 	hw->vendor_id = pci_dev->id.vendor_id;
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
 	hw->allow_unsupported_sfp = 1;
+	ad->max_vfs = pci_dev->max_vfs;
 
 	/* Initialize the shared code (base driver) */
 #ifdef RTE_LIBRTE_IXGBE_BYPASS
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index a0a2ea23b2..2fb6d55387 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -506,6 +506,7 @@ struct ixgbe_adapter {
 
 	/* Used for limiting SDP3 TX_DISABLE checks */
 	uint8_t sdp3_no_tx_disable;
+	uint16_t max_vfs;
 
 	/* Used for VF link sync with PF's physical and logical (by checking
 	 * mailbox status) link status.
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index b73037d4c3..e641a9d405 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1263,7 +1263,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	const struct rte_flow_item_e_tag *e_tag_mask;
 	const struct rte_flow_action *act;
 	const struct rte_flow_action_vf *act_vf;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL,
@@ -1395,7 +1395,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 		act_vf = (const struct rte_flow_action_vf *)act->conf;
 		filter->pool = act_vf->id;
 	} else {
-		filter->pool = pci_dev->max_vfs;
+		filter->pool = ad->max_vfs;
 	}
 
 	/* check if the next not void item is END */
@@ -1421,7 +1421,7 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 {
 	int ret = 0;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint16_t vf_num;
 
 	ret = cons_parse_l2_tn_filter(dev, attr, pattern,
@@ -1438,7 +1438,7 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	vf_num = pci_dev->max_vfs;
+	vf_num = ad->max_vfs;
 
 	if (l2_tn_filter->pool > vf_num)
 		return -rte_errno;
-- 
2.47.3

