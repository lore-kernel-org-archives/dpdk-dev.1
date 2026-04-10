Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56D9F44863
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:13:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DF4E402F1;
	Fri, 10 Apr 2026 15:13:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7528E402D8
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826815; x=1807362815;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=dRjChGPKpaKx2g/MZIZYJIM5HuVYFn0h3v5WDUzKIvA=;
 b=nR36h7OgCoVt3xMQW3tf3pvk45zSq3rw80v4GDPxemLeiSK9z44hENQd
 EX8z9OieNLXBQ4BqC9mn8fxAOeUrHn2PR7cwCupvLU0IN50HkGfqHk0tr
 ODS5XVmvgNwZToLJT43v4WtT2EAjKTTrBODaSLMgC3/ioRRka9eLk5tVu
 DOkFjnA6GO7X6q0aHy17NmXg0oDsHwIdkECalsfjXMwUP4x8nGO1l05mF
 KQK/BtarXbAXywVcI7GkoBktKV0uoKjb3PZPzlTElL+zODwMdTU4WvB5V
 y0jPlwF6whEp4EBgwEV4TuID8S/LxDiSjkhMFyy5cKSQdWsR/2H5y1o8E g==;
X-CSE-ConnectionGUID: KBu0lmBgRLGsywmLRZBUjw==
X-CSE-MsgGUID: sbxYWhwcQES6tW+rFy0TUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736314"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736314"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:34 -0700
X-CSE-ConnectionGUID: LVzHTQqRT5GXCAa2GYrF8w==
X-CSE-MsgGUID: wv+TFuHtRYOCTkOxWNdYrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084620"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:33 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 02/29] net/ixgbe: store max VFs in adapter
Date: Fri, 10 Apr 2026 14:12:56 +0100
Message-ID: <84517425625dba8bc3713c8ffa5f78d5c8f4d062.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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

Currently, rte_flow-related checks use `rte_eth_dev` to check for max VFs.
With coming rework of flows, the aim is to make the code as multiprocess
agnostic as possible, and `rte_eth_dev` pointer is process-local.

To support this in VF-related checks, cache max_vfs in ixgbe adapter
during device init and read it in the rte_flow check paths to avoid direct
dependency on `rte_eth_dev`.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 3 ++-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 4 ++++
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 8 ++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 6f758b802d..4cfaf47a38 100644
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
index a014dbff10..04e5e014d9 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -491,6 +491,7 @@ struct ixgbe_adapter {
 
 	/* Used for limiting SDP3 TX_DISABLE checks */
 	uint8_t sdp3_no_tx_disable;
+	uint16_t max_vfs;
 
 	/* Used for VF link sync with PF's physical and logical (by checking
 	 * mailbox status) link status.
@@ -515,6 +516,9 @@ uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts
 #define IXGBE_DEV_FDIR_CONF(dev) \
 	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
 
+#define IXGBE_DEV_PRIVATE_TO_ADAPTER(adapter) \
+	((struct ixgbe_adapter *)adapter)
+
 #define IXGBE_DEV_PRIVATE_TO_HW(adapter)\
 	(&((struct ixgbe_adapter *)adapter)->hw)
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 01cd4f9bde..c40ef02f23 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1272,7 +1272,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	const struct rte_flow_item_e_tag *e_tag_mask;
 	const struct rte_flow_action *act;
 	const struct rte_flow_action_vf *act_vf;
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
 	if (!pattern) {
 		rte_flow_error_set(error, EINVAL,
@@ -1404,7 +1404,7 @@ cons_parse_l2_tn_filter(struct rte_eth_dev *dev,
 		act_vf = (const struct rte_flow_action_vf *)act->conf;
 		filter->pool = act_vf->id;
 	} else {
-		filter->pool = pci_dev->max_vfs;
+		filter->pool = ad->max_vfs;
 	}
 
 	/* check if the next not void item is END */
@@ -1430,7 +1430,7 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 {
 	int ret = 0;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
+	struct ixgbe_adapter *ad = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	uint16_t vf_num;
 
 	ret = cons_parse_l2_tn_filter(dev, attr, pattern,
@@ -1447,7 +1447,7 @@ ixgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	vf_num = pci_dev->max_vfs;
+	vf_num = ad->max_vfs;
 
 	if (l2_tn_filter->pool > vf_num)
 		return -rte_errno;
-- 
2.47.3

