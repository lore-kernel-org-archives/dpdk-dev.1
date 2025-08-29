Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7E1CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:02:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F129A40668;
	Fri, 29 Aug 2025 16:02:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CB01D40263
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756476164; x=1788012164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/Vig4YE/gSvLLGg+9DaMHIm/Equ8T6lzXEpj+fO+NwM=;
 b=hj/lsksQ5w4YJF/ZdOk8Qz7Kw92yagdk907u/p4caKWRUDLw/sddQCa8
 W4ITpW3uiVevG46yTMLaB6TjZGD6XJSXOlPya4w9DhTJlztxn8KclmaLe
 5L4Vv4iXxYYSUGTHD/8KVv6NSPMnrVmZ2/f+mAM9fuDHuPgJ1Pqbc+6j/
 PlVZ5hIL/Et8ZueKpJrmXFfI9NrCPmyhlSoVjIO46TJMSrAn3NlP7Yva9
 Y/Ak1UuwNFBH7c6MO3Q6FfGymALxMUAE8MVw1kLfgiS3mFAcrL5XBTqnN
 vhFzf/jD/meSU3dCBl4PugjrvEv8QGa0wwZF20RvaxKxQIpJc4Z2YCjMm g==;
X-CSE-ConnectionGUID: mW/WzgohS828dq9iwiGjVw==
X-CSE-MsgGUID: cN76mI0GT2mHVDVQEzB0kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84166951"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="84166951"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:02:42 -0700
X-CSE-ConnectionGUID: nbY31W55SjCSMiLB+bFeig==
X-CSE-MsgGUID: 197//wHhSF+VA8anJqBvzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170295676"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2025 07:02:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 2/3] net/ice: implement the link state on close device op
Date: Fri, 29 Aug 2025 14:02:23 +0000
Message-Id: <20250829140224.1748255-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829140224.1748255-1-ciara.loftus@intel.com>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
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

Implement the callback that allows for configuration of the link state
when the device is closed or stopped. The default behaviour remains the
same, that being that the link is restored to its original state on
device closure.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 20 +++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..37aee45abc 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -194,6 +194,8 @@ static int ice_fec_get(struct rte_eth_dev *dev, uint32_t *fec_capa);
 static int ice_fec_set(struct rte_eth_dev *dev, uint32_t fec_capa);
 static const uint32_t *ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev,
 						size_t *no_of_elements);
+static int ice_link_state_on_close_set(struct rte_eth_dev *dev,
+				       enum rte_eth_link_state_on_close state);
 
 static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E823L_BACKPLANE) },
@@ -324,6 +326,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.fec_get                      = ice_fec_get,
 	.fec_set                      = ice_fec_set,
 	.buffer_split_supported_hdr_ptypes_get = ice_buffer_split_supported_hdr_ptypes_get,
+	.link_state_on_close_set      = ice_link_state_on_close_set,
 };
 
 /* store statistics names and its offset in stats structure */
@@ -2811,7 +2814,9 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	/* disable all queue interrupts */
 	ice_vsi_disable_queues_intr(main_vsi);
 
-	if (pf->init_link_up)
+	if (pf->adapter->link_state_on_close == RTE_ETH_LINK_STATE_ON_CLOSE_UP ||
+			(pf->adapter->link_state_on_close == RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL &&
+			pf->init_link_up))
 		ice_dev_set_link_up(dev);
 	else
 		ice_dev_set_link_down(dev);
@@ -3695,6 +3700,8 @@ ice_dev_configure(struct rte_eth_dev *dev)
 		}
 	}
 
+	ad->link_state_on_close = RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL;
+
 	return 0;
 }
 
@@ -7000,6 +7007,17 @@ ice_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 	return ptypes;
 }
 
+static int
+ice_link_state_on_close_set(struct rte_eth_dev *dev, enum rte_eth_link_state_on_close state)
+{
+	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ice_adapter *ad = (struct ice_adapter *)hw->back;
+
+	ad->link_state_on_close = state;
+
+	return 0;
+}
+
 static unsigned int
 ice_fec_get_capa_num(struct ice_aqc_get_phy_caps_data *pcaps,
 			   struct rte_eth_fec_capa *speed_fec_capa)
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8e5799f8b4..408684631f 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -663,6 +663,7 @@ struct ice_adapter {
 	bool tx_use_avx2;
 	bool tx_use_avx512;
 	bool rx_vec_offload_support;
+	enum rte_eth_link_state_on_close link_state_on_close; /* link state on device closure. */
 };
 
 struct ice_vsi_vlan_pvid_info {
-- 
2.34.1

