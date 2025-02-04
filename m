Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65137C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:11:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00998410ED;
	Tue,  4 Feb 2025 16:11:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 69F1140E0C
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681893; x=1770217893;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ifXUk+J/ZCGSa+wPJTTiYEc0MpqKxfy6v+MPIOKEKcg=;
 b=mldtSkwO8YDJbipivHMnbueitDVQjeNggNpI3xCUFpfLybfejuV5yKQa
 xcjlpVKVp9NfZY1FZP2PW8piQkaTtGqrNU+IIkwx1JYKAXoSy94QYLoHf
 tlVzzxC4op41FWEoGwjQBEcWc6HfUoJ8quAEDyToR9uERzD9CoCy5Yp2D
 Qj/4bMy8ZlAgzMoR97rKQO1w8x4+VVPVIDoTAAr1MbWBMMZPkLEaHWuIG
 iZWsXo3YzIKtWess4x0iTWRMIignsj5CZyCZX5ZlWMzv7K/A6pjx3tQuQ
 9Mdz81nYJOXi4lFRzaZSu3iOTf6oA54phfT2jhZxSFYDZI1ffZiS1AFyz A==;
X-CSE-ConnectionGUID: nxeH+NQMQsCvluvXz6lcug==
X-CSE-MsgGUID: Cg9GVCcaQFKOACM3869wwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097088"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097088"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:29 -0800
X-CSE-ConnectionGUID: +i4CrW07SR+xqh25X8RRYA==
X-CSE-MsgGUID: K1Qcb2pQTv+wad+AuqXcaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792550"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 02/54] net/e1000: merge igc with e1000
Date: Tue,  4 Feb 2025 15:10:08 +0000
Message-ID: <321a79ef4fff4812dc4c42b81f2a26766148d7ef.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

IGC and E1000 drivers are derived from the same base code. Now that e1000
code has enabled support for i225 devices, move IGC ethdev code to e1000
directory (renaming references to base code from igc_* to e1000_*).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/{igc => e1000}/igc_ethdev.c | 910 +++++++++---------
 drivers/net/intel/{igc => e1000}/igc_ethdev.h |  32 +-
 drivers/net/intel/{igc => e1000}/igc_filter.c |  84 +-
 drivers/net/intel/{igc => e1000}/igc_filter.h |   0
 drivers/net/intel/{igc => e1000}/igc_flow.c   |   2 +-
 drivers/net/intel/{igc => e1000}/igc_flow.h   |   0
 drivers/net/intel/{igc => e1000}/igc_logs.c   |   2 +-
 drivers/net/intel/{igc => e1000}/igc_txrx.c   | 376 ++++----
 drivers/net/intel/{igc => e1000}/igc_txrx.h   |   6 +-
 drivers/net/intel/e1000/meson.build           |  11 +
 drivers/net/meson.build                       |   1 -
 11 files changed, 717 insertions(+), 707 deletions(-)
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.c (73%)
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.h (91%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.c (81%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.c (99%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_logs.c (90%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.c (87%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.h (97%)

diff --git a/drivers/net/intel/igc/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
similarity index 73%
rename from drivers/net/intel/igc/igc_ethdev.c
rename to drivers/net/intel/e1000/igc_ethdev.c
index 87d7f7caa0..5563cee09c 100644
--- a/drivers/net/intel/igc/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -13,7 +13,7 @@
 #include <rte_malloc.h>
 #include <rte_alarm.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
@@ -106,18 +106,18 @@ static const struct rte_eth_desc_lim tx_desc_lim = {
 };
 
 static const struct rte_pci_id pci_id_igc_map[] = {
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_LM) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_LMVP) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_I)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_LMVP)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_LM)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_BLANK_NVM)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LM) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LM)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_BLANK_NVM)  },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -128,64 +128,64 @@ struct rte_igc_xstats_name_off {
 };
 
 static const struct rte_igc_xstats_name_off rte_igc_stats_strings[] = {
-	{"rx_crc_errors", offsetof(struct igc_hw_stats, crcerrs)},
-	{"rx_align_errors", offsetof(struct igc_hw_stats, algnerrc)},
-	{"rx_errors", offsetof(struct igc_hw_stats, rxerrc)},
-	{"rx_missed_packets", offsetof(struct igc_hw_stats, mpc)},
-	{"tx_single_collision_packets", offsetof(struct igc_hw_stats, scc)},
-	{"tx_multiple_collision_packets", offsetof(struct igc_hw_stats, mcc)},
-	{"tx_excessive_collision_packets", offsetof(struct igc_hw_stats,
+	{"rx_crc_errors", offsetof(struct e1000_hw_stats, crcerrs)},
+	{"rx_align_errors", offsetof(struct e1000_hw_stats, algnerrc)},
+	{"rx_errors", offsetof(struct e1000_hw_stats, rxerrc)},
+	{"rx_missed_packets", offsetof(struct e1000_hw_stats, mpc)},
+	{"tx_single_collision_packets", offsetof(struct e1000_hw_stats, scc)},
+	{"tx_multiple_collision_packets", offsetof(struct e1000_hw_stats, mcc)},
+	{"tx_excessive_collision_packets", offsetof(struct e1000_hw_stats,
 		ecol)},
-	{"tx_late_collisions", offsetof(struct igc_hw_stats, latecol)},
-	{"tx_total_collisions", offsetof(struct igc_hw_stats, colc)},
-	{"tx_deferred_packets", offsetof(struct igc_hw_stats, dc)},
-	{"tx_no_carrier_sense_packets", offsetof(struct igc_hw_stats, tncrs)},
-	{"tx_discarded_packets", offsetof(struct igc_hw_stats, htdpmc)},
-	{"rx_length_errors", offsetof(struct igc_hw_stats, rlec)},
-	{"rx_xon_packets", offsetof(struct igc_hw_stats, xonrxc)},
-	{"tx_xon_packets", offsetof(struct igc_hw_stats, xontxc)},
-	{"rx_xoff_packets", offsetof(struct igc_hw_stats, xoffrxc)},
-	{"tx_xoff_packets", offsetof(struct igc_hw_stats, xofftxc)},
-	{"rx_flow_control_unsupported_packets", offsetof(struct igc_hw_stats,
+	{"tx_late_collisions", offsetof(struct e1000_hw_stats, latecol)},
+	{"tx_total_collisions", offsetof(struct e1000_hw_stats, colc)},
+	{"tx_deferred_packets", offsetof(struct e1000_hw_stats, dc)},
+	{"tx_no_carrier_sense_packets", offsetof(struct e1000_hw_stats, tncrs)},
+	{"tx_discarded_packets", offsetof(struct e1000_hw_stats, htdpmc)},
+	{"rx_length_errors", offsetof(struct e1000_hw_stats, rlec)},
+	{"rx_xon_packets", offsetof(struct e1000_hw_stats, xonrxc)},
+	{"tx_xon_packets", offsetof(struct e1000_hw_stats, xontxc)},
+	{"rx_xoff_packets", offsetof(struct e1000_hw_stats, xoffrxc)},
+	{"tx_xoff_packets", offsetof(struct e1000_hw_stats, xofftxc)},
+	{"rx_flow_control_unsupported_packets", offsetof(struct e1000_hw_stats,
 		fcruc)},
-	{"rx_size_64_packets", offsetof(struct igc_hw_stats, prc64)},
-	{"rx_size_65_to_127_packets", offsetof(struct igc_hw_stats, prc127)},
-	{"rx_size_128_to_255_packets", offsetof(struct igc_hw_stats, prc255)},
-	{"rx_size_256_to_511_packets", offsetof(struct igc_hw_stats, prc511)},
-	{"rx_size_512_to_1023_packets", offsetof(struct igc_hw_stats,
+	{"rx_size_64_packets", offsetof(struct e1000_hw_stats, prc64)},
+	{"rx_size_65_to_127_packets", offsetof(struct e1000_hw_stats, prc127)},
+	{"rx_size_128_to_255_packets", offsetof(struct e1000_hw_stats, prc255)},
+	{"rx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, prc511)},
+	{"rx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		prc1023)},
-	{"rx_size_1024_to_max_packets", offsetof(struct igc_hw_stats,
+	{"rx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		prc1522)},
-	{"rx_broadcast_packets", offsetof(struct igc_hw_stats, bprc)},
-	{"rx_multicast_packets", offsetof(struct igc_hw_stats, mprc)},
-	{"rx_undersize_errors", offsetof(struct igc_hw_stats, ruc)},
-	{"rx_fragment_errors", offsetof(struct igc_hw_stats, rfc)},
-	{"rx_oversize_errors", offsetof(struct igc_hw_stats, roc)},
-	{"rx_jabber_errors", offsetof(struct igc_hw_stats, rjc)},
-	{"rx_no_buffers", offsetof(struct igc_hw_stats, rnbc)},
-	{"rx_management_packets", offsetof(struct igc_hw_stats, mgprc)},
-	{"rx_management_dropped", offsetof(struct igc_hw_stats, mgpdc)},
-	{"tx_management_packets", offsetof(struct igc_hw_stats, mgptc)},
-	{"rx_total_packets", offsetof(struct igc_hw_stats, tpr)},
-	{"tx_total_packets", offsetof(struct igc_hw_stats, tpt)},
-	{"rx_total_bytes", offsetof(struct igc_hw_stats, tor)},
-	{"tx_total_bytes", offsetof(struct igc_hw_stats, tot)},
-	{"tx_size_64_packets", offsetof(struct igc_hw_stats, ptc64)},
-	{"tx_size_65_to_127_packets", offsetof(struct igc_hw_stats, ptc127)},
-	{"tx_size_128_to_255_packets", offsetof(struct igc_hw_stats, ptc255)},
-	{"tx_size_256_to_511_packets", offsetof(struct igc_hw_stats, ptc511)},
-	{"tx_size_512_to_1023_packets", offsetof(struct igc_hw_stats,
+	{"rx_broadcast_packets", offsetof(struct e1000_hw_stats, bprc)},
+	{"rx_multicast_packets", offsetof(struct e1000_hw_stats, mprc)},
+	{"rx_undersize_errors", offsetof(struct e1000_hw_stats, ruc)},
+	{"rx_fragment_errors", offsetof(struct e1000_hw_stats, rfc)},
+	{"rx_oversize_errors", offsetof(struct e1000_hw_stats, roc)},
+	{"rx_jabber_errors", offsetof(struct e1000_hw_stats, rjc)},
+	{"rx_no_buffers", offsetof(struct e1000_hw_stats, rnbc)},
+	{"rx_management_packets", offsetof(struct e1000_hw_stats, mgprc)},
+	{"rx_management_dropped", offsetof(struct e1000_hw_stats, mgpdc)},
+	{"tx_management_packets", offsetof(struct e1000_hw_stats, mgptc)},
+	{"rx_total_packets", offsetof(struct e1000_hw_stats, tpr)},
+	{"tx_total_packets", offsetof(struct e1000_hw_stats, tpt)},
+	{"rx_total_bytes", offsetof(struct e1000_hw_stats, tor)},
+	{"tx_total_bytes", offsetof(struct e1000_hw_stats, tot)},
+	{"tx_size_64_packets", offsetof(struct e1000_hw_stats, ptc64)},
+	{"tx_size_65_to_127_packets", offsetof(struct e1000_hw_stats, ptc127)},
+	{"tx_size_128_to_255_packets", offsetof(struct e1000_hw_stats, ptc255)},
+	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
+	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct igc_hw_stats,
+	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
-	{"tx_multicast_packets", offsetof(struct igc_hw_stats, mptc)},
-	{"tx_broadcast_packets", offsetof(struct igc_hw_stats, bptc)},
-	{"tx_tso_packets", offsetof(struct igc_hw_stats, tsctc)},
-	{"rx_sent_to_host_packets", offsetof(struct igc_hw_stats, rpthc)},
-	{"tx_sent_by_host_packets", offsetof(struct igc_hw_stats, hgptc)},
-	{"interrupt_assert_count", offsetof(struct igc_hw_stats, iac)},
+	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
+	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
+	{"tx_tso_packets", offsetof(struct e1000_hw_stats, tsctc)},
+	{"rx_sent_to_host_packets", offsetof(struct e1000_hw_stats, rpthc)},
+	{"tx_sent_by_host_packets", offsetof(struct e1000_hw_stats, hgptc)},
+	{"interrupt_assert_count", offsetof(struct e1000_hw_stats, iac)},
 	{"rx_descriptor_lower_threshold",
-		offsetof(struct igc_hw_stats, icrxdmtc)},
+		offsetof(struct e1000_hw_stats, icrxdmtc)},
 };
 
 #define IGC_NB_XSTATS (sizeof(rte_igc_stats_strings) / \
@@ -391,24 +391,24 @@ eth_igc_configure(struct rte_eth_dev *dev)
 static int
 eth_igc_set_link_up(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	if (hw->phy.media_type == igc_media_type_copper)
-		igc_power_up_phy(hw);
+	if (hw->phy.media_type == e1000_media_type_copper)
+		e1000_power_up_phy(hw);
 	else
-		igc_power_up_fiber_serdes_link(hw);
+		e1000_power_up_fiber_serdes_link(hw);
 	return 0;
 }
 
 static int
 eth_igc_set_link_down(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	if (hw->phy.media_type == igc_media_type_copper)
-		igc_power_down_phy(hw);
+	if (hw->phy.media_type == e1000_media_type_copper)
+		e1000_power_down_phy(hw);
 	else
-		igc_shutdown_fiber_serdes_link(hw);
+		e1000_shutdown_fiber_serdes_link(hw);
 	return 0;
 }
 
@@ -418,17 +418,17 @@ eth_igc_set_link_down(struct rte_eth_dev *dev)
 static void
 igc_intr_other_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
 		dev->data->dev_conf.intr_conf.lsc) {
-		IGC_WRITE_REG(hw, IGC_EIMC, 1u << IGC_MSIX_OTHER_INTR_VEC);
+		E1000_WRITE_REG(hw, E1000_EIMC, 1u << IGC_MSIX_OTHER_INTR_VEC);
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMC, ~0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMC, ~0);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -438,17 +438,17 @@ static inline void
 igc_intr_other_enable(struct rte_eth_dev *dev)
 {
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
 		dev->data->dev_conf.intr_conf.lsc) {
-		IGC_WRITE_REG(hw, IGC_EIMS, 1u << IGC_MSIX_OTHER_INTR_VEC);
+		E1000_WRITE_REG(hw, E1000_EIMS, 1u << IGC_MSIX_OTHER_INTR_VEC);
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMS, intr->mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMS, intr->mask);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -459,14 +459,14 @@ static void
 eth_igc_interrupt_get_status(struct rte_eth_dev *dev)
 {
 	uint32_t icr;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
 
 	/* read-on-clear nic registers here */
-	icr = IGC_READ_REG(hw, IGC_ICR);
+	icr = E1000_READ_REG(hw, E1000_ICR);
 
 	intr->flags = 0;
-	if (icr & IGC_ICR_LSC)
+	if (icr & E1000_ICR_LSC)
 		intr->flags |= IGC_FLAG_NEED_LINK_UPDATE;
 }
 
@@ -474,7 +474,7 @@ eth_igc_interrupt_get_status(struct rte_eth_dev *dev)
 static int
 eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_eth_link link;
 	int link_check, count;
 
@@ -485,20 +485,20 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	for (count = 0; count < IGC_LINK_UPDATE_CHECK_TIMEOUT; count++) {
 		/* Read the real link status */
 		switch (hw->phy.media_type) {
-		case igc_media_type_copper:
+		case e1000_media_type_copper:
 			/* Do the work to read phy */
-			igc_check_for_link(hw);
+			e1000_check_for_link(hw);
 			link_check = !hw->mac.get_link_status;
 			break;
 
-		case igc_media_type_fiber:
-			igc_check_for_link(hw);
-			link_check = (IGC_READ_REG(hw, IGC_STATUS) &
-				      IGC_STATUS_LU);
+		case e1000_media_type_fiber:
+			e1000_check_for_link(hw);
+			link_check = (E1000_READ_REG(hw, E1000_STATUS) &
+				      E1000_STATUS_LU);
 			break;
 
-		case igc_media_type_internal_serdes:
-			igc_check_for_link(hw);
+		case e1000_media_type_internal_serdes:
+			e1000_check_for_link(hw);
 			link_check = hw->mac.serdes_has_link;
 			break;
 
@@ -524,11 +524,11 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_SPEED_FIXED);
 
 		if (speed == SPEED_2500) {
-			uint32_t tipg = IGC_READ_REG(hw, IGC_TIPG);
-			if ((tipg & IGC_TIPG_IPGT_MASK) != 0x0b) {
-				tipg &= ~IGC_TIPG_IPGT_MASK;
+			uint32_t tipg = E1000_READ_REG(hw, E1000_TIPG);
+			if ((tipg & E1000_TIPG_IPGT_MASK) != 0x0b) {
+				tipg &= ~E1000_TIPG_IPGT_MASK;
 				tipg |= 0x0b;
-				IGC_WRITE_REG(hw, IGC_TIPG, tipg);
+				E1000_WRITE_REG(hw, E1000_TIPG, tipg);
 			}
 		}
 	} else {
@@ -622,24 +622,24 @@ igc_update_queue_stats_handler(void *param)
 static void
 eth_igc_rxtx_control(struct rte_eth_dev *dev, bool enable)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t tctl, rctl;
 
-	tctl = IGC_READ_REG(hw, IGC_TCTL);
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
+	tctl = E1000_READ_REG(hw, E1000_TCTL);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
 
 	if (enable) {
 		/* enable Tx/Rx */
-		tctl |= IGC_TCTL_EN;
-		rctl |= IGC_RCTL_EN;
+		tctl |= E1000_TCTL_EN;
+		rctl |= E1000_RCTL_EN;
 	} else {
 		/* disable Tx/Rx */
-		tctl &= ~IGC_TCTL_EN;
-		rctl &= ~IGC_RCTL_EN;
+		tctl &= ~E1000_TCTL_EN;
+		rctl &= ~E1000_RCTL_EN;
 	}
-	IGC_WRITE_REG(hw, IGC_TCTL, tctl);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_TCTL, tctl);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -650,7 +650,7 @@ static int
 eth_igc_stop(struct rte_eth_dev *dev)
 {
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rte_eth_link link;
@@ -662,11 +662,11 @@ eth_igc_stop(struct rte_eth_dev *dev)
 	eth_igc_rxtx_control(dev, false);
 
 	/* disable all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EIMC, 0x1f);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, 0x1f);
+	E1000_WRITE_FLUSH(hw);
 
 	/* clear all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EICR, 0x1f);
+	E1000_WRITE_REG(hw, E1000_EICR, 0x1f);
 
 	igc_intr_other_disable(dev);
 
@@ -675,17 +675,17 @@ eth_igc_stop(struct rte_eth_dev *dev)
 	/* disable intr eventfd mapping */
 	rte_intr_disable(intr_handle);
 
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* disable all wake up */
-	IGC_WRITE_REG(hw, IGC_WUC, 0);
+	E1000_WRITE_REG(hw, E1000_WUC, 0);
 
 	/* disable checking EEE operation in MAC loopback mode */
-	igc_read_reg_check_clear_bits(hw, IGC_EEER, IGC_EEER_EEE_FRC_AN);
+	igc_read_reg_check_clear_bits(hw, E1000_EEER, IGC_EEER_EEE_FRC_AN);
 
 	/* Set bit for Go Link disconnect */
-	igc_read_reg_check_set_bits(hw, IGC_82580_PHY_POWER_MGMT,
-			IGC_82580_PM_GO_LINKD);
+	igc_read_reg_check_set_bits(hw, E1000_82580_PHY_POWER_MGMT,
+			E1000_82580_PM_GO_LINKD);
 
 	/* Power down the phy. Needed to make the link go Down */
 	eth_igc_set_link_down(dev);
@@ -721,7 +721,7 @@ eth_igc_stop(struct rte_eth_dev *dev)
  *  msix-vector, valid 0,1,2,3,4
  */
 static void
-igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
+igc_write_ivar(struct e1000_hw *hw, uint8_t queue_index,
 		bool tx, uint8_t msix_vector)
 {
 	uint8_t offset = 0;
@@ -744,15 +744,15 @@ igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
 	if (queue_index & 1)
 		offset += 16;
 
-	val = IGC_READ_REG_ARRAY(hw, IGC_IVAR0, reg_index);
+	val = E1000_READ_REG_ARRAY(hw, E1000_IVAR0, reg_index);
 
 	/* clear bits */
 	val &= ~((uint32_t)0xFF << offset);
 
 	/* write vector and valid bit */
-	val |= (uint32_t)(msix_vector | IGC_IVAR_VALID) << offset;
+	val |= (uint32_t)(msix_vector | E1000_IVAR_VALID) << offset;
 
-	IGC_WRITE_REG_ARRAY(hw, IGC_IVAR0, reg_index, val);
+	E1000_WRITE_REG_ARRAY(hw, E1000_IVAR0, reg_index, val);
 }
 
 /* Sets up the hardware to generate MSI-X interrupts properly
@@ -762,7 +762,7 @@ igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
 static void
 igc_configure_msix_intr(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
@@ -785,9 +785,9 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 	}
 
 	/* turn on MSI-X capability first */
-	IGC_WRITE_REG(hw, IGC_GPIE, IGC_GPIE_MSIX_MODE |
-				IGC_GPIE_PBA | IGC_GPIE_EIAME |
-				IGC_GPIE_NSICR);
+	E1000_WRITE_REG(hw, E1000_GPIE, E1000_GPIE_MSIX_MODE |
+				E1000_GPIE_PBA | E1000_GPIE_EIAME |
+				E1000_GPIE_NSICR);
 
 	nb_efd = rte_intr_nb_efd_get(intr_handle);
 	if (nb_efd < 0)
@@ -799,14 +799,14 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 		intr_mask |= (1u << IGC_MSIX_OTHER_INTR_VEC);
 
 	/* enable msix auto-clear */
-	igc_read_reg_check_set_bits(hw, IGC_EIAC, intr_mask);
+	igc_read_reg_check_set_bits(hw, E1000_EIAC, intr_mask);
 
 	/* set other cause interrupt vector */
-	igc_read_reg_check_set_bits(hw, IGC_IVAR_MISC,
-		(uint32_t)(IGC_MSIX_OTHER_INTR_VEC | IGC_IVAR_VALID) << 8);
+	igc_read_reg_check_set_bits(hw, E1000_IVAR_MISC,
+		(uint32_t)(IGC_MSIX_OTHER_INTR_VEC | E1000_IVAR_VALID) << 8);
 
 	/* enable auto-mask */
-	igc_read_reg_check_set_bits(hw, IGC_EIAM, intr_mask);
+	igc_read_reg_check_set_bits(hw, E1000_EIAM, intr_mask);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		igc_write_ivar(hw, i, 0, vec);
@@ -815,7 +815,7 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 			vec++;
 	}
 
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /**
@@ -832,9 +832,9 @@ igc_lsc_interrupt_setup(struct rte_eth_dev *dev, uint8_t on)
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
 
 	if (on)
-		intr->mask |= IGC_ICR_LSC;
+		intr->mask |= E1000_ICR_LSC;
 	else
-		intr->mask &= ~IGC_ICR_LSC;
+		intr->mask &= ~E1000_ICR_LSC;
 }
 
 /*
@@ -845,7 +845,7 @@ static void
 igc_rxq_interrupt_setup(struct rte_eth_dev *dev)
 {
 	uint32_t mask;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int misc_shift = rte_intr_allow_others(intr_handle) ? 1 : 0;
@@ -862,16 +862,16 @@ igc_rxq_interrupt_setup(struct rte_eth_dev *dev)
 		return;
 
 	mask = RTE_LEN2MASK(nb_efd, uint32_t) << misc_shift;
-	IGC_WRITE_REG(hw, IGC_EIMS, mask);
+	E1000_WRITE_REG(hw, E1000_EIMS, mask);
 }
 
 /*
  *  Get hardware rx-buffer size.
  */
 static inline int
-igc_get_rx_buffer_size(struct igc_hw *hw)
+igc_get_rx_buffer_size(struct e1000_hw *hw)
 {
-	return (IGC_READ_REG(hw, IGC_RXPBS) & 0x3f) << 10;
+	return (E1000_READ_REG(hw, E1000_RXPBS) & 0x3f) << 10;
 }
 
 /*
@@ -880,13 +880,13 @@ igc_get_rx_buffer_size(struct igc_hw *hw)
  * that the driver is loaded.
  */
 static void
-igc_hw_control_acquire(struct igc_hw *hw)
+igc_hw_control_acquire(struct e1000_hw *hw)
 {
 	uint32_t ctrl_ext;
 
 	/* Let firmware know the driver has taken over */
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_DRV_LOAD);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext | E1000_CTRL_EXT_DRV_LOAD);
 }
 
 /*
@@ -895,18 +895,18 @@ igc_hw_control_acquire(struct igc_hw *hw)
  * driver is no longer loaded.
  */
 static void
-igc_hw_control_release(struct igc_hw *hw)
+igc_hw_control_release(struct e1000_hw *hw)
 {
 	uint32_t ctrl_ext;
 
 	/* Let firmware taken over control of h/w */
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT,
-			ctrl_ext & ~IGC_CTRL_EXT_DRV_LOAD);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT,
+			ctrl_ext & ~E1000_CTRL_EXT_DRV_LOAD);
 }
 
 static int
-igc_hardware_init(struct igc_hw *hw)
+igc_hardware_init(struct e1000_hw *hw)
 {
 	uint32_t rx_buf_size;
 	int diag;
@@ -915,10 +915,10 @@ igc_hardware_init(struct igc_hw *hw)
 	igc_hw_control_acquire(hw);
 
 	/* Issue a global reset */
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* disable all wake up */
-	IGC_WRITE_REG(hw, IGC_WUC, 0);
+	E1000_WRITE_REG(hw, E1000_WUC, 0);
 
 	/*
 	 * Hardware flow control
@@ -937,14 +937,14 @@ igc_hardware_init(struct igc_hw *hw)
 	hw->fc.low_water = hw->fc.high_water - 1500;
 	hw->fc.pause_time = IGC_FC_PAUSE_TIME;
 	hw->fc.send_xon = 1;
-	hw->fc.requested_mode = igc_fc_full;
+	hw->fc.requested_mode = e1000_fc_full;
 
-	diag = igc_init_hw(hw);
+	diag = e1000_init_hw(hw);
 	if (diag < 0)
 		return diag;
 
-	igc_get_phy_info(hw);
-	igc_check_for_link(hw);
+	e1000_get_phy_info(hw);
+	e1000_check_for_link(hw);
 
 	return 0;
 }
@@ -952,7 +952,7 @@ igc_hardware_init(struct igc_hw *hw)
 static int
 eth_igc_start(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
@@ -967,11 +967,11 @@ eth_igc_start(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 
 	/* disable all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EIMC, 0x1f);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, 0x1f);
+	E1000_WRITE_FLUSH(hw);
 
 	/* clear all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EICR, 0x1f);
+	E1000_WRITE_REG(hw, E1000_EICR, 0x1f);
 
 	/* disable uio/vfio intr/eventfd mapping */
 	if (!adapter->stopped)
@@ -981,7 +981,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 	eth_igc_set_link_up(dev);
 
 	/* Put the address into the Receive Address Array */
-	igc_rar_set(hw, hw->mac.addr, 0);
+	e1000_rar_set(hw, hw->mac.addr, 0);
 
 	/* Initialize the hardware */
 	if (igc_hardware_init(hw)) {
@@ -1025,36 +1025,36 @@ eth_igc_start(struct rte_eth_dev *dev)
 		adapter->base_time = 0;
 		adapter->cycle_time = NSEC_PER_SEC;
 
-		IGC_WRITE_REG(hw, IGC_TSSDP, 0);
-		IGC_WRITE_REG(hw, IGC_TSIM, TSINTR_TXTS);
-		IGC_WRITE_REG(hw, IGC_IMS, IGC_ICR_TS);
+		E1000_WRITE_REG(hw, E1000_TSSDP, 0);
+		E1000_WRITE_REG(hw, E1000_TSIM, TSINTR_TXTS);
+		E1000_WRITE_REG(hw, E1000_IMS, E1000_ICR_TS);
 
-		IGC_WRITE_REG(hw, IGC_TSAUXC, 0);
-		IGC_WRITE_REG(hw, IGC_I350_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
-		IGC_WRITE_REG(hw, IGC_TXPBS, IGC_TXPBSIZE_TSN);
+		E1000_WRITE_REG(hw, E1000_TSAUXC, 0);
+		E1000_WRITE_REG(hw, E1000_I350_DTXMXPKTSZ, E1000_DTXMXPKTSZ_TSN);
+		E1000_WRITE_REG(hw, E1000_TXPBS, E1000_TXPBSIZE_TSN);
 
-		tqavctrl = IGC_READ_REG(hw, IGC_I210_TQAVCTRL);
-		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
-			    IGC_TQAVCTRL_ENHANCED_QAV;
-		IGC_WRITE_REG(hw, IGC_I210_TQAVCTRL, tqavctrl);
+		tqavctrl = E1000_READ_REG(hw, E1000_I210_TQAVCTRL);
+		tqavctrl |= E1000_TQAVCTRL_TRANSMIT_MODE_TSN |
+			    E1000_TQAVCTRL_ENHANCED_QAV;
+		E1000_WRITE_REG(hw, E1000_I210_TQAVCTRL, tqavctrl);
 
-		IGC_WRITE_REG(hw, IGC_QBVCYCLET_S, adapter->cycle_time);
-		IGC_WRITE_REG(hw, IGC_QBVCYCLET, adapter->cycle_time);
+		E1000_WRITE_REG(hw, E1000_QBVCYCLET_S, adapter->cycle_time);
+		E1000_WRITE_REG(hw, E1000_QBVCYCLET, adapter->cycle_time);
 
 		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			IGC_WRITE_REG(hw, IGC_STQT(i), 0);
-			IGC_WRITE_REG(hw, IGC_ENDQT(i), NSEC_PER_SEC);
+			E1000_WRITE_REG(hw, E1000_STQT(i), 0);
+			E1000_WRITE_REG(hw, E1000_ENDQT(i), NSEC_PER_SEC);
 
-			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
-			IGC_WRITE_REG(hw, IGC_TXQCTL(i), txqctl);
+			txqctl |= E1000_TXQCTL_QUEUE_MODE_LAUNCHT;
+			E1000_WRITE_REG(hw, E1000_TXQCTL(i), txqctl);
 		}
 
 		clock_gettime(CLOCK_REALTIME, &system_time);
-		IGC_WRITE_REG(hw, IGC_SYSTIML, system_time.tv_nsec);
-		IGC_WRITE_REG(hw, IGC_SYSTIMH, system_time.tv_sec);
+		E1000_WRITE_REG(hw, E1000_SYSTIML, system_time.tv_nsec);
+		E1000_WRITE_REG(hw, E1000_SYSTIMH, system_time.tv_sec);
 
-		nsec = IGC_READ_REG(hw, IGC_SYSTIML);
-		sec = IGC_READ_REG(hw, IGC_SYSTIMH);
+		nsec = E1000_READ_REG(hw, E1000_SYSTIML);
+		sec = E1000_READ_REG(hw, E1000_SYSTIMH);
 		systime = (int64_t)sec * NSEC_PER_SEC + (int64_t)nsec;
 
 		if (systime > adapter->base_time) {
@@ -1066,11 +1066,11 @@ eth_igc_start(struct rte_eth_dev *dev)
 
 		baset_h = adapter->base_time / NSEC_PER_SEC;
 		baset_l = adapter->base_time % NSEC_PER_SEC;
-		IGC_WRITE_REG(hw, IGC_BASET_H, baset_h);
-		IGC_WRITE_REG(hw, IGC_BASET_L, baset_l);
+		E1000_WRITE_REG(hw, E1000_BASET_H, baset_h);
+		E1000_WRITE_REG(hw, E1000_BASET_L, baset_l);
 	}
 
-	igc_clear_hw_cntrs_base_generic(hw);
+	e1000_clear_hw_cntrs_base_generic(hw);
 
 	/* VLAN Offload Settings */
 	eth_igc_vlan_offload_set(dev,
@@ -1080,7 +1080,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 	/* Setup link speed and duplex */
 	speeds = &dev->data->dev_conf.link_speeds;
 	if (*speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		hw->phy.autoneg_advertised = IGC_ALL_SPEED_DUPLEX_2500;
+		hw->phy.autoneg_advertised = E1000_ALL_SPEED_DUPLEX_2500;
 		hw->mac.autoneg = 1;
 	} else {
 		int num_speeds = 0;
@@ -1129,7 +1129,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 			goto error_invalid_config;
 	}
 
-	igc_setup_link(hw);
+	e1000_setup_link(hw);
 
 	if (rte_intr_allow_others(intr_handle)) {
 		/* check if lsc interrupt is enabled */
@@ -1167,13 +1167,13 @@ eth_igc_start(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.lpbk_mode == 1) {
 		uint32_t reg_val;
 
-		reg_val = IGC_READ_REG(hw, IGC_CTRL);
+		reg_val = E1000_READ_REG(hw, E1000_CTRL);
 		reg_val &= ~IGC_CTRL_SPEED_MASK;
-		reg_val |= IGC_CTRL_SLU | IGC_CTRL_FRCSPD |
-			IGC_CTRL_FRCDPX | IGC_CTRL_FD | IGC_CTRL_SPEED_2500;
-		IGC_WRITE_REG(hw, IGC_CTRL, reg_val);
+		reg_val |= E1000_CTRL_SLU | E1000_CTRL_FRCSPD |
+			E1000_CTRL_FRCDPX | E1000_CTRL_FD | IGC_CTRL_SPEED_2500;
+		E1000_WRITE_REG(hw, E1000_CTRL, reg_val);
 
-		igc_read_reg_check_set_bits(hw, IGC_EEER, IGC_EEER_EEE_FRC_AN);
+		igc_read_reg_check_set_bits(hw, E1000_EEER, IGC_EEER_EEE_FRC_AN);
 	}
 
 	return 0;
@@ -1186,7 +1186,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 }
 
 static int
-igc_reset_swfw_lock(struct igc_hw *hw)
+igc_reset_swfw_lock(struct e1000_hw *hw)
 {
 	int ret_val;
 
@@ -1194,7 +1194,7 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 	 * Do mac ops initialization manually here, since we will need
 	 * some function pointers set by this call.
 	 */
-	ret_val = igc_init_mac_params(hw);
+	ret_val = e1000_init_mac_params(hw);
 	if (ret_val)
 		return ret_val;
 
@@ -1203,10 +1203,10 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 	 * it is due to an improper exit of the application.
 	 * So force the release of the faulty lock.
 	 */
-	if (igc_get_hw_semaphore_generic(hw) < 0)
+	if (e1000_get_hw_semaphore_generic(hw) < 0)
 		PMD_DRV_LOG(DEBUG, "SMBI lock released");
 
-	igc_put_hw_semaphore_generic(hw);
+	e1000_put_hw_semaphore_generic(hw);
 
 	if (hw->mac.ops.acquire_swfw_sync != NULL) {
 		uint16_t mask;
@@ -1216,7 +1216,7 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 		 * If this is the case, it is due to an improper exit of the
 		 * application. So force the release of the faulty lock.
 		 */
-		mask = IGC_SWFW_PHY0_SM;
+		mask = E1000_SWFW_PHY0_SM;
 		if (hw->mac.ops.acquire_swfw_sync(hw, mask) < 0) {
 			PMD_DRV_LOG(DEBUG, "SWFW phy%d lock released",
 				    hw->bus.func);
@@ -1229,14 +1229,14 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 		 * that if lock can not be taken it is due to an improper lock
 		 * of the semaphore.
 		 */
-		mask = IGC_SWFW_EEP_SM;
+		mask = E1000_SWFW_EEP_SM;
 		if (hw->mac.ops.acquire_swfw_sync(hw, mask) < 0)
 			PMD_DRV_LOG(DEBUG, "SWFW common locks released");
 
 		hw->mac.ops.release_swfw_sync(hw, mask);
 	}
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
 /*
@@ -1265,7 +1265,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	int retry = 0;
 	int ret = 0;
@@ -1291,7 +1291,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 		DELAY(200 * 1000); /* delay 200ms */
 	} while (retry++ < 5);
 
-	igc_phy_hw_reset(hw);
+	e1000_phy_hw_reset(hw);
 	igc_hw_control_release(hw);
 	igc_dev_free_queues(dev);
 
@@ -1304,7 +1304,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 static void
 igc_identify_hardware(struct rte_eth_dev *dev, struct rte_pci_device *pci_dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	hw->vendor_id = pci_dev->id.vendor_id;
 	hw->device_id = pci_dev->id.device_id;
@@ -1317,7 +1317,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	int i, error = 0;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1348,50 +1348,50 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
 
 	igc_identify_hardware(dev, pci_dev);
-	if (igc_setup_init_funcs(hw, false) != IGC_SUCCESS) {
+	if (e1000_setup_init_funcs(hw, false) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
-	igc_get_bus_info(hw);
+	e1000_get_bus_info(hw);
 
 	/* Reset any pending lock */
-	if (igc_reset_swfw_lock(hw) != IGC_SUCCESS) {
+	if (igc_reset_swfw_lock(hw) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
 	/* Finish initialization */
-	if (igc_setup_init_funcs(hw, true) != IGC_SUCCESS) {
+	if (e1000_setup_init_funcs(hw, true) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
 	hw->mac.autoneg = 1;
 	hw->phy.autoneg_wait_to_complete = 0;
-	hw->phy.autoneg_advertised = IGC_ALL_SPEED_DUPLEX_2500;
+	hw->phy.autoneg_advertised = E1000_ALL_SPEED_DUPLEX_2500;
 
 	/* Copper options */
-	if (hw->phy.media_type == igc_media_type_copper) {
+	if (hw->phy.media_type == e1000_media_type_copper) {
 		hw->phy.mdix = 0; /* AUTO_ALL_MODES */
 		hw->phy.disable_polarity_correction = 0;
-		hw->phy.ms_type = igc_ms_hw_default;
+		hw->phy.ms_type = e1000_ms_hw_default;
 	}
 
 	/*
 	 * Start from a known state, this is important in reading the nvm
 	 * and mac from that.
 	 */
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* Make sure we have a good EEPROM before we read from it */
-	if (igc_validate_nvm_checksum(hw) < 0) {
+	if (e1000_validate_nvm_checksum(hw) < 0) {
 		/*
 		 * Some PCI-E parts fail the first check due to
 		 * the link being in sleep state, call it again,
 		 * if it fails a second time its a real issue.
 		 */
-		if (igc_validate_nvm_checksum(hw) < 0) {
+		if (e1000_validate_nvm_checksum(hw) < 0) {
 			PMD_INIT_LOG(ERR, "EEPROM checksum invalid");
 			error = -EIO;
 			goto err_late;
@@ -1399,7 +1399,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	}
 
 	/* Read the permanent MAC address out of the EEPROM */
-	if (igc_read_mac_addr(hw) != 0) {
+	if (e1000_read_mac_addr(hw) != 0) {
 		PMD_INIT_LOG(ERR, "EEPROM error while reading MAC address");
 		error = -EIO;
 		goto err_late;
@@ -1432,7 +1432,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	igc->stopped = 0;
 
 	/* Indicate SOL/IDER usage */
-	if (igc_check_reset_block(hw) < 0)
+	if (e1000_check_reset_block(hw) < 0)
 		PMD_INIT_LOG(ERR,
 			"PHY reset is blocked due to SOL/IDER session.");
 
@@ -1489,55 +1489,55 @@ eth_igc_reset(struct rte_eth_dev *dev)
 static int
 eth_igc_promiscuous_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl |= (IGC_RCTL_UPE | IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_promiscuous_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl &= (~IGC_RCTL_UPE);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl &= (~E1000_RCTL_UPE);
 	if (dev->data->all_multicast == 1)
-		rctl |= IGC_RCTL_MPE;
+		rctl |= E1000_RCTL_MPE;
 	else
-		rctl &= (~IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+		rctl &= (~E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_allmulticast_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl |= IGC_RCTL_MPE;
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl |= E1000_RCTL_MPE;
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_allmulticast_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
 	if (dev->data->promiscuous == 1)
 		return 0;	/* must remain in all_multicast mode */
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl &= (~IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl &= (~E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
@@ -1545,11 +1545,11 @@ static int
 eth_igc_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 		       size_t fw_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_fw_version fw;
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_fw_version fw;
 	int ret;
 
-	igc_get_fw_version(hw, &fw);
+	e1000_get_fw_version(hw, &fw);
 
 	/* if option rom is valid, display its version too */
 	if (fw.or_valid) {
@@ -1584,7 +1584,7 @@ eth_igc_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 static int
 eth_igc_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	dev_info->min_rx_bufsize = 256; /* See BSIZE field of RCTL register. */
 	dev_info->max_rx_pktlen = MAX_RX_JUMBO_FRAME_SIZE;
@@ -1637,17 +1637,17 @@ eth_igc_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 static int
 eth_igc_led_on(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	return igc_led_on(hw) == IGC_SUCCESS ? 0 : -ENOTSUP;
+	return e1000_led_on(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
 static int
 eth_igc_led_off(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	return igc_led_off(hw) == IGC_SUCCESS ? 0 : -ENOTSUP;
+	return e1000_led_off(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
 static const uint32_t *
@@ -1678,12 +1678,12 @@ eth_igc_supported_ptypes_get(__rte_unused struct rte_eth_dev *dev,
 static int
 eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = mtu + IGC_ETH_OVERHEAD;
 	uint32_t rctl;
 
 	/* if extend vlan has been enabled */
-	if (IGC_READ_REG(hw, IGC_CTRL_EXT) & IGC_CTRL_EXT_EXT_VLAN)
+	if (E1000_READ_REG(hw, E1000_CTRL_EXT) & IGC_CTRL_EXT_EXT_VLAN)
 		frame_size += VLAN_TAG_SIZE;
 
 	/*
@@ -1696,14 +1696,14 @@ eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EINVAL;
 	}
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
 	if (mtu > RTE_ETHER_MTU)
-		rctl |= IGC_RCTL_LPE;
+		rctl |= E1000_RCTL_LPE;
 	else
-		rctl &= ~IGC_RCTL_LPE;
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+		rctl &= ~E1000_RCTL_LPE;
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size);
 
 	return 0;
 }
@@ -1712,9 +1712,9 @@ static int
 eth_igc_rar_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 		uint32_t index, uint32_t pool)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_rar_set(hw, mac_addr->addr_bytes, index);
+	e1000_rar_set(hw, mac_addr->addr_bytes, index);
 	RTE_SET_USED(pool);
 	return 0;
 }
@@ -1723,18 +1723,18 @@ static void
 eth_igc_rar_clear(struct rte_eth_dev *dev, uint32_t index)
 {
 	uint8_t addr[RTE_ETHER_ADDR_LEN];
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	memset(addr, 0, sizeof(addr));
-	igc_rar_set(hw, addr, index);
+	e1000_rar_set(hw, addr, index);
 }
 
 static int
 eth_igc_default_mac_addr_set(struct rte_eth_dev *dev,
 			struct rte_ether_addr *addr)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_rar_set(hw, addr->addr_bytes, 0);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	e1000_rar_set(hw, addr->addr_bytes, 0);
 	return 0;
 }
 
@@ -1743,8 +1743,8 @@ eth_igc_set_mc_addr_list(struct rte_eth_dev *dev,
 			 struct rte_ether_addr *mc_addr_set,
 			 uint32_t nb_mc_addr)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	e1000_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
 	return 0;
 }
 
@@ -1752,7 +1752,7 @@ eth_igc_set_mc_addr_list(struct rte_eth_dev *dev,
  * Read hardware registers
  */
 static void
-igc_read_stats_registers(struct igc_hw *hw, struct igc_hw_stats *stats)
+igc_read_stats_registers(struct e1000_hw *hw, struct e1000_hw_stats *stats)
 {
 	int pause_frames;
 
@@ -1763,119 +1763,119 @@ igc_read_stats_registers(struct igc_hw *hw, struct igc_hw_stats *stats)
 	uint64_t old_rpthc = stats->rpthc;
 	uint64_t old_hgptc = stats->hgptc;
 
-	stats->crcerrs += IGC_READ_REG(hw, IGC_CRCERRS);
-	stats->algnerrc += IGC_READ_REG(hw, IGC_ALGNERRC);
-	stats->rxerrc += IGC_READ_REG(hw, IGC_RXERRC);
-	stats->mpc += IGC_READ_REG(hw, IGC_MPC);
-	stats->scc += IGC_READ_REG(hw, IGC_SCC);
-	stats->ecol += IGC_READ_REG(hw, IGC_ECOL);
+	stats->crcerrs += E1000_READ_REG(hw, E1000_CRCERRS);
+	stats->algnerrc += E1000_READ_REG(hw, E1000_ALGNERRC);
+	stats->rxerrc += E1000_READ_REG(hw, E1000_RXERRC);
+	stats->mpc += E1000_READ_REG(hw, E1000_MPC);
+	stats->scc += E1000_READ_REG(hw, E1000_SCC);
+	stats->ecol += E1000_READ_REG(hw, E1000_ECOL);
 
-	stats->mcc += IGC_READ_REG(hw, IGC_MCC);
-	stats->latecol += IGC_READ_REG(hw, IGC_LATECOL);
-	stats->colc += IGC_READ_REG(hw, IGC_COLC);
+	stats->mcc += E1000_READ_REG(hw, E1000_MCC);
+	stats->latecol += E1000_READ_REG(hw, E1000_LATECOL);
+	stats->colc += E1000_READ_REG(hw, E1000_COLC);
 
-	stats->dc += IGC_READ_REG(hw, IGC_DC);
-	stats->tncrs += IGC_READ_REG(hw, IGC_TNCRS);
-	stats->htdpmc += IGC_READ_REG(hw, IGC_HTDPMC);
-	stats->rlec += IGC_READ_REG(hw, IGC_RLEC);
-	stats->xonrxc += IGC_READ_REG(hw, IGC_XONRXC);
-	stats->xontxc += IGC_READ_REG(hw, IGC_XONTXC);
+	stats->dc += E1000_READ_REG(hw, E1000_DC);
+	stats->tncrs += E1000_READ_REG(hw, E1000_TNCRS);
+	stats->htdpmc += E1000_READ_REG(hw, E1000_HTDPMC);
+	stats->rlec += E1000_READ_REG(hw, E1000_RLEC);
+	stats->xonrxc += E1000_READ_REG(hw, E1000_XONRXC);
+	stats->xontxc += E1000_READ_REG(hw, E1000_XONTXC);
 
 	/*
 	 * For watchdog management we need to know if we have been
 	 * paused during the last interval, so capture that here.
 	 */
-	pause_frames = IGC_READ_REG(hw, IGC_XOFFRXC);
+	pause_frames = E1000_READ_REG(hw, E1000_XOFFRXC);
 	stats->xoffrxc += pause_frames;
-	stats->xofftxc += IGC_READ_REG(hw, IGC_XOFFTXC);
-	stats->fcruc += IGC_READ_REG(hw, IGC_FCRUC);
-	stats->prc64 += IGC_READ_REG(hw, IGC_PRC64);
-	stats->prc127 += IGC_READ_REG(hw, IGC_PRC127);
-	stats->prc255 += IGC_READ_REG(hw, IGC_PRC255);
-	stats->prc511 += IGC_READ_REG(hw, IGC_PRC511);
-	stats->prc1023 += IGC_READ_REG(hw, IGC_PRC1023);
-	stats->prc1522 += IGC_READ_REG(hw, IGC_PRC1522);
-	stats->gprc += IGC_READ_REG(hw, IGC_GPRC);
-	stats->bprc += IGC_READ_REG(hw, IGC_BPRC);
-	stats->mprc += IGC_READ_REG(hw, IGC_MPRC);
-	stats->gptc += IGC_READ_REG(hw, IGC_GPTC);
+	stats->xofftxc += E1000_READ_REG(hw, E1000_XOFFTXC);
+	stats->fcruc += E1000_READ_REG(hw, E1000_FCRUC);
+	stats->prc64 += E1000_READ_REG(hw, E1000_PRC64);
+	stats->prc127 += E1000_READ_REG(hw, E1000_PRC127);
+	stats->prc255 += E1000_READ_REG(hw, E1000_PRC255);
+	stats->prc511 += E1000_READ_REG(hw, E1000_PRC511);
+	stats->prc1023 += E1000_READ_REG(hw, E1000_PRC1023);
+	stats->prc1522 += E1000_READ_REG(hw, E1000_PRC1522);
+	stats->gprc += E1000_READ_REG(hw, E1000_GPRC);
+	stats->bprc += E1000_READ_REG(hw, E1000_BPRC);
+	stats->mprc += E1000_READ_REG(hw, E1000_MPRC);
+	stats->gptc += E1000_READ_REG(hw, E1000_GPTC);
 
 	/* For the 64-bit byte counters the low dword must be read first. */
 	/* Both registers clear on the read of the high dword */
 
 	/* Workaround CRC bytes included in size, take away 4 bytes/packet */
-	stats->gorc += IGC_READ_REG(hw, IGC_GORCL);
-	stats->gorc += ((uint64_t)IGC_READ_REG(hw, IGC_GORCH) << 32);
+	stats->gorc += E1000_READ_REG(hw, E1000_GORCL);
+	stats->gorc += ((uint64_t)E1000_READ_REG(hw, E1000_GORCH) << 32);
 	stats->gorc -= (stats->gprc - old_gprc) * RTE_ETHER_CRC_LEN;
-	stats->gotc += IGC_READ_REG(hw, IGC_GOTCL);
-	stats->gotc += ((uint64_t)IGC_READ_REG(hw, IGC_GOTCH) << 32);
+	stats->gotc += E1000_READ_REG(hw, E1000_GOTCL);
+	stats->gotc += ((uint64_t)E1000_READ_REG(hw, E1000_GOTCH) << 32);
 	stats->gotc -= (stats->gptc - old_gptc) * RTE_ETHER_CRC_LEN;
 
-	stats->rnbc += IGC_READ_REG(hw, IGC_RNBC);
-	stats->ruc += IGC_READ_REG(hw, IGC_RUC);
-	stats->rfc += IGC_READ_REG(hw, IGC_RFC);
-	stats->roc += IGC_READ_REG(hw, IGC_ROC);
-	stats->rjc += IGC_READ_REG(hw, IGC_RJC);
+	stats->rnbc += E1000_READ_REG(hw, E1000_RNBC);
+	stats->ruc += E1000_READ_REG(hw, E1000_RUC);
+	stats->rfc += E1000_READ_REG(hw, E1000_RFC);
+	stats->roc += E1000_READ_REG(hw, E1000_ROC);
+	stats->rjc += E1000_READ_REG(hw, E1000_RJC);
 
-	stats->mgprc += IGC_READ_REG(hw, IGC_MGTPRC);
-	stats->mgpdc += IGC_READ_REG(hw, IGC_MGTPDC);
-	stats->mgptc += IGC_READ_REG(hw, IGC_MGTPTC);
-	stats->b2ospc += IGC_READ_REG(hw, IGC_B2OSPC);
-	stats->b2ogprc += IGC_READ_REG(hw, IGC_B2OGPRC);
-	stats->o2bgptc += IGC_READ_REG(hw, IGC_O2BGPTC);
-	stats->o2bspc += IGC_READ_REG(hw, IGC_O2BSPC);
+	stats->mgprc += E1000_READ_REG(hw, E1000_MGTPRC);
+	stats->mgpdc += E1000_READ_REG(hw, E1000_MGTPDC);
+	stats->mgptc += E1000_READ_REG(hw, E1000_MGTPTC);
+	stats->b2ospc += E1000_READ_REG(hw, E1000_B2OSPC);
+	stats->b2ogprc += E1000_READ_REG(hw, E1000_B2OGPRC);
+	stats->o2bgptc += E1000_READ_REG(hw, E1000_O2BGPTC);
+	stats->o2bspc += E1000_READ_REG(hw, E1000_O2BSPC);
 
-	stats->tpr += IGC_READ_REG(hw, IGC_TPR);
-	stats->tpt += IGC_READ_REG(hw, IGC_TPT);
+	stats->tpr += E1000_READ_REG(hw, E1000_TPR);
+	stats->tpt += E1000_READ_REG(hw, E1000_TPT);
 
-	stats->tor += IGC_READ_REG(hw, IGC_TORL);
-	stats->tor += ((uint64_t)IGC_READ_REG(hw, IGC_TORH) << 32);
+	stats->tor += E1000_READ_REG(hw, E1000_TORL);
+	stats->tor += ((uint64_t)E1000_READ_REG(hw, E1000_TORH) << 32);
 	stats->tor -= (stats->tpr - old_tpr) * RTE_ETHER_CRC_LEN;
-	stats->tot += IGC_READ_REG(hw, IGC_TOTL);
-	stats->tot += ((uint64_t)IGC_READ_REG(hw, IGC_TOTH) << 32);
+	stats->tot += E1000_READ_REG(hw, E1000_TOTL);
+	stats->tot += ((uint64_t)E1000_READ_REG(hw, E1000_TOTH) << 32);
 	stats->tot -= (stats->tpt - old_tpt) * RTE_ETHER_CRC_LEN;
 
-	stats->ptc64 += IGC_READ_REG(hw, IGC_PTC64);
-	stats->ptc127 += IGC_READ_REG(hw, IGC_PTC127);
-	stats->ptc255 += IGC_READ_REG(hw, IGC_PTC255);
-	stats->ptc511 += IGC_READ_REG(hw, IGC_PTC511);
-	stats->ptc1023 += IGC_READ_REG(hw, IGC_PTC1023);
-	stats->ptc1522 += IGC_READ_REG(hw, IGC_PTC1522);
-	stats->mptc += IGC_READ_REG(hw, IGC_MPTC);
-	stats->bptc += IGC_READ_REG(hw, IGC_BPTC);
-	stats->tsctc += IGC_READ_REG(hw, IGC_TSCTC);
+	stats->ptc64 += E1000_READ_REG(hw, E1000_PTC64);
+	stats->ptc127 += E1000_READ_REG(hw, E1000_PTC127);
+	stats->ptc255 += E1000_READ_REG(hw, E1000_PTC255);
+	stats->ptc511 += E1000_READ_REG(hw, E1000_PTC511);
+	stats->ptc1023 += E1000_READ_REG(hw, E1000_PTC1023);
+	stats->ptc1522 += E1000_READ_REG(hw, E1000_PTC1522);
+	stats->mptc += E1000_READ_REG(hw, E1000_MPTC);
+	stats->bptc += E1000_READ_REG(hw, E1000_BPTC);
+	stats->tsctc += E1000_READ_REG(hw, E1000_TSCTC);
 
-	stats->iac += IGC_READ_REG(hw, IGC_IAC);
-	stats->rpthc += IGC_READ_REG(hw, IGC_RPTHC);
-	stats->hgptc += IGC_READ_REG(hw, IGC_HGPTC);
-	stats->icrxdmtc += IGC_READ_REG(hw, IGC_ICRXDMTC);
+	stats->iac += E1000_READ_REG(hw, E1000_IAC);
+	stats->rpthc += E1000_READ_REG(hw, E1000_RPTHC);
+	stats->hgptc += E1000_READ_REG(hw, E1000_HGPTC);
+	stats->icrxdmtc += E1000_READ_REG(hw, E1000_ICRXDMTC);
 
 	/* Host to Card Statistics */
-	stats->hgorc += IGC_READ_REG(hw, IGC_HGORCL);
-	stats->hgorc += ((uint64_t)IGC_READ_REG(hw, IGC_HGORCH) << 32);
+	stats->hgorc += E1000_READ_REG(hw, E1000_HGORCL);
+	stats->hgorc += ((uint64_t)E1000_READ_REG(hw, E1000_HGORCH) << 32);
 	stats->hgorc -= (stats->rpthc - old_rpthc) * RTE_ETHER_CRC_LEN;
-	stats->hgotc += IGC_READ_REG(hw, IGC_HGOTCL);
-	stats->hgotc += ((uint64_t)IGC_READ_REG(hw, IGC_HGOTCH) << 32);
+	stats->hgotc += E1000_READ_REG(hw, E1000_HGOTCL);
+	stats->hgotc += ((uint64_t)E1000_READ_REG(hw, E1000_HGOTCH) << 32);
 	stats->hgotc -= (stats->hgptc - old_hgptc) * RTE_ETHER_CRC_LEN;
-	stats->lenerrs += IGC_READ_REG(hw, IGC_LENERRS);
+	stats->lenerrs += E1000_READ_REG(hw, E1000_LENERRS);
 }
 
 /*
  * Write 0 to all queue status registers
  */
 static void
-igc_reset_queue_stats_register(struct igc_hw *hw)
+igc_reset_queue_stats_register(struct e1000_hw *hw)
 {
 	int i;
 
 	for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-		IGC_WRITE_REG(hw, IGC_PQGPRC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGPTC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGORC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGOTC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQMPRC(i), 0);
-		IGC_WRITE_REG(hw, IGC_RQDPC(i), 0);
-		IGC_WRITE_REG(hw, IGC_TQDPC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGPRC(i), 0);
+		E1000_WRITE_REG(hw, E1000_PQGPTC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGORC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGOTC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQMPRC(i), 0);
+		E1000_WRITE_REG(hw, E1000_RQDPC(i), 0);
+		E1000_WRITE_REG(hw, IGC_TQDPC(i), 0);
 	}
 }
 
@@ -1885,7 +1885,7 @@ igc_reset_queue_stats_register(struct igc_hw *hw)
 static void
 igc_read_queue_stats_register(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_hw_queue_stats *queue_stats =
 				IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 	int i;
@@ -1908,49 +1908,49 @@ igc_read_queue_stats_register(struct rte_eth_dev *dev)
 		 * then we add the high 4 bytes by 1 and replace the low 4
 		 * bytes by the new value.
 		 */
-		tmp = IGC_READ_REG(hw, IGC_PQGPRC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGPRC(i));
 		value.ddword = queue_stats->pqgprc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgprc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGPTC(i));
+		tmp = E1000_READ_REG(hw, E1000_PQGPTC(i));
 		value.ddword = queue_stats->pqgptc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgptc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGORC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGORC(i));
 		value.ddword = queue_stats->pqgorc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgorc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGOTC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGOTC(i));
 		value.ddword = queue_stats->pqgotc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgotc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQMPRC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQMPRC(i));
 		value.ddword = queue_stats->pqmprc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqmprc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_RQDPC(i));
+		tmp = E1000_READ_REG(hw, E1000_RQDPC(i));
 		value.ddword = queue_stats->rqdpc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->rqdpc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_TQDPC(i));
+		tmp = E1000_READ_REG(hw, IGC_TQDPC(i));
 		value.ddword = queue_stats->tqdpc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
@@ -1963,8 +1963,8 @@ static int
 eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
 {
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *stats = IGC_DEV_PRIVATE_STATS(dev);
 	struct igc_hw_queue_stats *queue_stats =
 			IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 	int i;
@@ -2025,8 +2025,8 @@ static int
 eth_igc_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 		   unsigned int n)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats =
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats =
 			IGC_DEV_PRIVATE_STATS(dev);
 	unsigned int i;
 
@@ -2054,8 +2054,8 @@ eth_igc_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 static int
 eth_igc_xstats_reset(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
 	struct igc_hw_queue_stats *queue_stats =
 			IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 
@@ -2124,8 +2124,8 @@ static int
 eth_igc_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		uint64_t *values, unsigned int n)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
 	unsigned int i;
 
 	igc_read_stats_registers(hw, hw_stats);
@@ -2185,7 +2185,7 @@ eth_igc_queue_stats_mapping_set(struct rte_eth_dev *dev,
 static int
 eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
@@ -2195,8 +2195,8 @@ eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	uint32_t mask = 1u << (queue_id + vec);
 
-	IGC_WRITE_REG(hw, IGC_EIMC, mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, mask);
+	E1000_WRITE_FLUSH(hw);
 
 	return 0;
 }
@@ -2204,7 +2204,7 @@ eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
@@ -2214,8 +2214,8 @@ eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	uint32_t mask = 1u << (queue_id + vec);
 
-	IGC_WRITE_REG(hw, IGC_EIMS, mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMS, mask);
+	E1000_WRITE_FLUSH(hw);
 
 	rte_intr_enable(intr_handle);
 
@@ -2225,7 +2225,7 @@ eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t ctrl;
 	int tx_pause;
 	int rx_pause;
@@ -2240,13 +2240,13 @@ eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	 * Return rx_pause and tx_pause status according to actual setting of
 	 * the TFCE and RFCE bits in the CTRL register.
 	 */
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	if (ctrl & IGC_CTRL_TFCE)
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
+	if (ctrl & E1000_CTRL_TFCE)
 		tx_pause = 1;
 	else
 		tx_pause = 0;
 
-	if (ctrl & IGC_CTRL_RFCE)
+	if (ctrl & E1000_CTRL_RFCE)
 		rx_pause = 1;
 	else
 		rx_pause = 0;
@@ -2266,7 +2266,7 @@ eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 static int
 eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rx_buf_size;
 	uint32_t max_high_water;
 	uint32_t rctl;
@@ -2291,16 +2291,16 @@ eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 
 	switch (fc_conf->mode) {
 	case RTE_ETH_FC_NONE:
-		hw->fc.requested_mode = igc_fc_none;
+		hw->fc.requested_mode = e1000_fc_none;
 		break;
 	case RTE_ETH_FC_RX_PAUSE:
-		hw->fc.requested_mode = igc_fc_rx_pause;
+		hw->fc.requested_mode = e1000_fc_rx_pause;
 		break;
 	case RTE_ETH_FC_TX_PAUSE:
-		hw->fc.requested_mode = igc_fc_tx_pause;
+		hw->fc.requested_mode = e1000_fc_tx_pause;
 		break;
 	case RTE_ETH_FC_FULL:
-		hw->fc.requested_mode = igc_fc_full;
+		hw->fc.requested_mode = e1000_fc_full;
 		break;
 	default:
 		PMD_DRV_LOG(ERR, "unsupported fc mode: %u", fc_conf->mode);
@@ -2312,23 +2312,23 @@ eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	hw->fc.low_water      = fc_conf->low_water;
 	hw->fc.send_xon	      = fc_conf->send_xon;
 
-	err = igc_setup_link_generic(hw);
-	if (err == IGC_SUCCESS) {
+	err = e1000_setup_link_generic(hw);
+	if (err == E1000_SUCCESS) {
 		/**
 		 * check if we want to forward MAC frames - driver doesn't have
 		 * native capability to do that, so we'll write the registers
 		 * ourselves
 		 **/
-		rctl = IGC_READ_REG(hw, IGC_RCTL);
+		rctl = E1000_READ_REG(hw, E1000_RCTL);
 
 		/* set or clear MFLCN.PMCF bit depending on configuration */
 		if (fc_conf->mac_ctrl_frame_fwd != 0)
-			rctl |= IGC_RCTL_PMCF;
+			rctl |= E1000_RCTL_PMCF;
 		else
-			rctl &= ~IGC_RCTL_PMCF;
+			rctl &= ~E1000_RCTL_PMCF;
 
-		IGC_WRITE_REG(hw, IGC_RCTL, rctl);
-		IGC_WRITE_FLUSH(hw);
+		E1000_WRITE_REG(hw, E1000_RCTL, rctl);
+		E1000_WRITE_FLUSH(hw);
 
 		return 0;
 	}
@@ -2342,7 +2342,7 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_reta_entry64 *reta_conf,
 			uint16_t reta_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
@@ -2374,8 +2374,8 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 		if (mask == IGC_RSS_RDT_REG_SIZE_MASK)
 			reg.dword = 0;
 		else
-			reg.dword = IGC_READ_REG_LE_VALUE(hw,
-					IGC_RETA(i / IGC_RSS_RDT_REG_SIZE));
+			reg.dword = E1000_READ_REG_LE_VALUE(hw,
+					E1000_RETA(i / IGC_RSS_RDT_REG_SIZE));
 
 		/* update the register */
 		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
@@ -2386,8 +2386,8 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 			else
 				reta.bytes[j] = reg.bytes[j];
 		}
-		IGC_WRITE_REG_LE_VALUE(hw,
-			IGC_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
+		E1000_WRITE_REG_LE_VALUE(hw,
+			E1000_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
 	}
 
 	return 0;
@@ -2398,7 +2398,7 @@ eth_igc_rss_reta_query(struct rte_eth_dev *dev,
 		       struct rte_eth_rss_reta_entry64 *reta_conf,
 		       uint16_t reta_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
@@ -2428,8 +2428,8 @@ eth_igc_rss_reta_query(struct rte_eth_dev *dev,
 
 		/* read register and get the queue index */
 		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
-		reta.dword = IGC_READ_REG_LE_VALUE(hw,
-				IGC_RETA(i / IGC_RSS_RDT_REG_SIZE));
+		reta.dword = E1000_READ_REG_LE_VALUE(hw,
+				E1000_RETA(i / IGC_RSS_RDT_REG_SIZE));
 		for (j = 0; j < IGC_RSS_RDT_REG_SIZE; j++) {
 			if (mask & (1u << j))
 				reta_conf[idx].reta[shift + j] = reta.bytes[j];
@@ -2443,7 +2443,7 @@ static int
 eth_igc_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	igc_hw_rss_hash_set(hw, rss_conf);
 	return 0;
 }
@@ -2452,7 +2452,7 @@ static int
 eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t *hash_key = (uint32_t *)rss_conf->rss_key;
 	uint32_t mrqc;
 	uint64_t rss_hf;
@@ -2470,32 +2470,32 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 		/* read RSS key from register */
 		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
-			hash_key[i] = IGC_READ_REG_LE_VALUE(hw, IGC_RSSRK(i));
+			hash_key[i] = E1000_READ_REG_LE_VALUE(hw, E1000_RSSRK(i));
 	}
 
 	/* get RSS functions configured in MRQC register */
-	mrqc = IGC_READ_REG(hw, IGC_MRQC);
-	if ((mrqc & IGC_MRQC_ENABLE_RSS_4Q) == 0)
+	mrqc = E1000_READ_REG(hw, E1000_MRQC);
+	if ((mrqc & E1000_MRQC_ENABLE_RSS_4Q) == 0)
 		return 0;
 
 	rss_hf = 0;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4)
 		rss_hf |= RTE_ETH_RSS_IPV4;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4_TCP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_TCP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6)
 		rss_hf |= RTE_ETH_RSS_IPV6;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_EX;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_TCP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_TCP_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_TCP_EX;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4_UDP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_UDP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_UDP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_UDP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_UDP_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_UDP_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_UDP_EX;
 
 	rss_conf->rss_hf |= rss_hf;
@@ -2505,20 +2505,20 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 static int
 eth_igc_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_vfta *shadow_vfta = IGC_DEV_PRIVATE_VFTA(dev);
 	uint32_t vfta;
 	uint32_t vid_idx;
 	uint32_t vid_bit;
 
-	vid_idx = (vlan_id >> IGC_VFTA_ENTRY_SHIFT) & IGC_VFTA_ENTRY_MASK;
-	vid_bit = 1u << (vlan_id & IGC_VFTA_ENTRY_BIT_SHIFT_MASK);
+	vid_idx = (vlan_id >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK;
+	vid_bit = 1u << (vlan_id & E1000_VFTA_ENTRY_BIT_SHIFT_MASK);
 	vfta = shadow_vfta->vfta[vid_idx];
 	if (on)
 		vfta |= vid_bit;
 	else
 		vfta &= ~vid_bit;
-	IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, vid_idx, vfta);
+	E1000_WRITE_REG_ARRAY(hw, E1000_VFTA, vid_idx, vfta);
 
 	/* update local VFTA copy */
 	shadow_vfta->vfta[vid_idx] = vfta;
@@ -2529,54 +2529,54 @@ eth_igc_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 static void
 igc_vlan_hw_filter_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_read_reg_check_clear_bits(hw, IGC_RCTL,
-			IGC_RCTL_CFIEN | IGC_RCTL_VFE);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	igc_read_reg_check_clear_bits(hw, E1000_RCTL,
+			E1000_RCTL_CFIEN | E1000_RCTL_VFE);
 }
 
 static void
 igc_vlan_hw_filter_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_vfta *shadow_vfta = IGC_DEV_PRIVATE_VFTA(dev);
 	uint32_t reg_val;
 	int i;
 
 	/* Filter Table Enable, CFI not used for packet acceptance */
-	reg_val = IGC_READ_REG(hw, IGC_RCTL);
-	reg_val &= ~IGC_RCTL_CFIEN;
-	reg_val |= IGC_RCTL_VFE;
-	IGC_WRITE_REG(hw, IGC_RCTL, reg_val);
+	reg_val = E1000_READ_REG(hw, E1000_RCTL);
+	reg_val &= ~E1000_RCTL_CFIEN;
+	reg_val |= E1000_RCTL_VFE;
+	E1000_WRITE_REG(hw, E1000_RCTL, reg_val);
 
 	/* restore VFTA table */
 	for (i = 0; i < IGC_VFTA_SIZE; i++)
-		IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, i, shadow_vfta->vfta[i]);
+		E1000_WRITE_REG_ARRAY(hw, E1000_VFTA, i, shadow_vfta->vfta[i]);
 }
 
 static void
 igc_vlan_hw_strip_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_read_reg_check_clear_bits(hw, IGC_CTRL, IGC_CTRL_VME);
+	igc_read_reg_check_clear_bits(hw, E1000_CTRL, E1000_CTRL_VME);
 }
 
 static void
 igc_vlan_hw_strip_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_read_reg_check_set_bits(hw, IGC_CTRL, IGC_CTRL_VME);
+	igc_read_reg_check_set_bits(hw, E1000_CTRL, E1000_CTRL_VME);
 }
 
 static int
 igc_vlan_hw_extend_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = dev->data->mtu + IGC_ETH_OVERHEAD;
 	uint32_t ctrl_ext;
 
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
 	/* if extend vlan hasn't been enabled */
 	if ((ctrl_ext & IGC_CTRL_EXT_EXT_VLAN) == 0)
@@ -2588,20 +2588,20 @@ igc_vlan_hw_extend_disable(struct rte_eth_dev *dev)
 			frame_size, VLAN_TAG_SIZE + RTE_ETHER_MIN_MTU);
 		return -EINVAL;
 	}
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size - VLAN_TAG_SIZE);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size - VLAN_TAG_SIZE);
 
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext & ~IGC_CTRL_EXT_EXT_VLAN);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext & ~IGC_CTRL_EXT_EXT_VLAN);
 	return 0;
 }
 
 static int
 igc_vlan_hw_extend_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = dev->data->mtu + IGC_ETH_OVERHEAD;
 	uint32_t ctrl_ext;
 
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
 	/* if extend vlan has been enabled */
 	if (ctrl_ext & IGC_CTRL_EXT_EXT_VLAN)
@@ -2613,9 +2613,9 @@ igc_vlan_hw_extend_enable(struct rte_eth_dev *dev)
 			frame_size, MAX_RX_JUMBO_FRAME_SIZE);
 		return -EINVAL;
 	}
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size);
 
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_EXT_VLAN);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_EXT_VLAN);
 	return 0;
 }
 
@@ -2654,15 +2654,15 @@ eth_igc_vlan_tpid_set(struct rte_eth_dev *dev,
 		      enum rte_vlan_type vlan_type,
 		      uint16_t tpid)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t reg_val;
 
 	/* only outer TPID of double VLAN can be configured*/
 	if (vlan_type == RTE_ETH_VLAN_TYPE_OUTER) {
-		reg_val = IGC_READ_REG(hw, IGC_VET);
+		reg_val = E1000_READ_REG(hw, E1000_VET);
 		reg_val = (reg_val & (~IGC_VET_EXT)) |
 			((uint32_t)tpid << IGC_VET_EXT_SHIFT);
-		IGC_WRITE_REG(hw, IGC_VET, reg_val);
+		E1000_WRITE_REG(hw, E1000_VET, reg_val);
 
 		return 0;
 	}
@@ -2675,42 +2675,42 @@ eth_igc_vlan_tpid_set(struct rte_eth_dev *dev,
 static int
 eth_igc_timesync_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct timespec system_time;
 	struct igc_rx_queue *rxq;
 	uint32_t val;
 	uint16_t i;
 
-	IGC_WRITE_REG(hw, IGC_TSAUXC, 0x0);
+	E1000_WRITE_REG(hw, E1000_TSAUXC, 0x0);
 
 	clock_gettime(CLOCK_REALTIME, &system_time);
-	IGC_WRITE_REG(hw, IGC_SYSTIML, system_time.tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, system_time.tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, system_time.tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, system_time.tv_sec);
 
 	/* Enable timestamping of received PTP packets. */
-	val = IGC_READ_REG(hw, IGC_RXPBS);
-	val |= IGC_RXPBS_CFG_TS_EN;
-	IGC_WRITE_REG(hw, IGC_RXPBS, val);
+	val = E1000_READ_REG(hw, E1000_RXPBS);
+	val |= E1000_RXPBS_CFG_TS_EN;
+	E1000_WRITE_REG(hw, E1000_RXPBS, val);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		val = IGC_READ_REG(hw, IGC_SRRCTL(i));
+		val = E1000_READ_REG(hw, E1000_SRRCTL(i));
 		/* For now, only support retrieving Rx timestamp from timer0. */
-		val |= IGC_SRRCTL_TIMER1SEL(0) | IGC_SRRCTL_TIMER0SEL(0) |
-		       IGC_SRRCTL_TIMESTAMP;
-		IGC_WRITE_REG(hw, IGC_SRRCTL(i), val);
+		val |= E1000_SRRCTL_TIMER1SEL(0) | E1000_SRRCTL_TIMER0SEL(0) |
+		       E1000_SRRCTL_TIMESTAMP;
+		E1000_WRITE_REG(hw, E1000_SRRCTL(i), val);
 	}
 
-	val = IGC_TSYNCRXCTL_ENABLED | IGC_TSYNCRXCTL_TYPE_ALL |
-	      IGC_TSYNCRXCTL_RXSYNSIG;
-	IGC_WRITE_REG(hw, IGC_TSYNCRXCTL, val);
+	val = E1000_TSYNCRXCTL_ENABLED | E1000_TSYNCRXCTL_TYPE_ALL |
+	      E1000_TSYNCRXCTL_RXSYNSIG;
+	E1000_WRITE_REG(hw, E1000_TSYNCRXCTL, val);
 
 	/* Enable Timestamping of transmitted PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED |
-		      IGC_TSYNCTXCTL_TXSYNSIG);
+	E1000_WRITE_REG(hw, E1000_TSYNCTXCTL, E1000_TSYNCTXCTL_ENABLED |
+		      E1000_TSYNCTXCTL_TXSYNSIG);
 
 	/* Read TXSTMP registers to discard any timestamp previously stored. */
-	IGC_READ_REG(hw, IGC_TXSTMPL);
-	IGC_READ_REG(hw, IGC_TXSTMPH);
+	E1000_READ_REG(hw, E1000_TXSTMPL);
+	E1000_READ_REG(hw, E1000_TXSTMPH);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
@@ -2723,10 +2723,10 @@ eth_igc_timesync_enable(struct rte_eth_dev *dev)
 static int
 eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	ts->tv_nsec = IGC_READ_REG(hw, IGC_SYSTIML);
-	ts->tv_sec = IGC_READ_REG(hw, IGC_SYSTIMH);
+	ts->tv_nsec = E1000_READ_REG(hw, E1000_SYSTIML);
+	ts->tv_sec = E1000_READ_REG(hw, E1000_SYSTIMH);
 
 	return 0;
 }
@@ -2734,10 +2734,10 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 static int
 eth_igc_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	IGC_WRITE_REG(hw, IGC_SYSTIML, ts->tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, ts->tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, ts->tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, ts->tv_sec);
 
 	return 0;
 }
@@ -2745,20 +2745,20 @@ eth_igc_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 static int
 eth_igc_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t nsec, sec;
 	uint64_t systime, ns;
 	struct timespec ts;
 
-	nsec = (uint64_t)IGC_READ_REG(hw, IGC_SYSTIML);
-	sec = (uint64_t)IGC_READ_REG(hw, IGC_SYSTIMH);
+	nsec = (uint64_t)E1000_READ_REG(hw, E1000_SYSTIML);
+	sec = (uint64_t)E1000_READ_REG(hw, E1000_SYSTIMH);
 	systime = sec * NSEC_PER_SEC + nsec;
 
 	ns = systime + delta;
 	ts = rte_ns_to_timespec(ns);
 
-	IGC_WRITE_REG(hw, IGC_SYSTIML, ts.tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, ts.tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, ts.tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, ts.tv_sec);
 
 	return 0;
 }
@@ -2803,18 +2803,18 @@ static int
 eth_igc_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 			       struct timespec *timestamp)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_eth_link link;
 	uint32_t val, nsec, sec;
 	uint64_t tx_timestamp;
 	int adjust = 0;
 
-	val = IGC_READ_REG(hw, IGC_TSYNCTXCTL);
-	if (!(val & IGC_TSYNCTXCTL_VALID))
+	val = E1000_READ_REG(hw, E1000_TSYNCTXCTL);
+	if (!(val & E1000_TSYNCTXCTL_VALID))
 		return -EINVAL;
 
-	nsec = (uint64_t)IGC_READ_REG(hw, IGC_TXSTMPL);
-	sec = (uint64_t)IGC_READ_REG(hw, IGC_TXSTMPH);
+	nsec = (uint64_t)E1000_READ_REG(hw, E1000_TXSTMPL);
+	sec = (uint64_t)E1000_READ_REG(hw, E1000_TXSTMPH);
 	tx_timestamp = sec * NSEC_PER_SEC + nsec;
 
 	/* Get current link speed. */
@@ -2845,22 +2845,22 @@ eth_igc_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 static int
 eth_igc_timesync_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t val;
 
 	/* Disable timestamping of transmitted PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCTXCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TSYNCTXCTL, 0);
 
 	/* Disable timestamping of received PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCRXCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TSYNCRXCTL, 0);
 
-	val = IGC_READ_REG(hw, IGC_RXPBS);
-	val &= ~IGC_RXPBS_CFG_TS_EN;
-	IGC_WRITE_REG(hw, IGC_RXPBS, val);
+	val = E1000_READ_REG(hw, E1000_RXPBS);
+	val &= ~E1000_RXPBS_CFG_TS_EN;
+	E1000_WRITE_REG(hw, E1000_RXPBS, val);
 
-	val = IGC_READ_REG(hw, IGC_SRRCTL(0));
-	val &= ~IGC_SRRCTL_TIMESTAMP;
-	IGC_WRITE_REG(hw, IGC_SRRCTL(0), val);
+	val = E1000_READ_REG(hw, E1000_SRRCTL(0));
+	val &= ~E1000_SRRCTL_TIMESTAMP;
+	E1000_WRITE_REG(hw, E1000_SRRCTL(0), val);
 
 	return 0;
 }
diff --git a/drivers/net/intel/igc/igc_ethdev.h b/drivers/net/intel/e1000/igc_ethdev.h
similarity index 91%
rename from drivers/net/intel/igc/igc_ethdev.h
rename to drivers/net/intel/e1000/igc_ethdev.h
index d3d3ddd6f6..7fa7877adf 100644
--- a/drivers/net/intel/igc/igc_ethdev.h
+++ b/drivers/net/intel/e1000/igc_ethdev.h
@@ -9,10 +9,10 @@
 #include <rte_flow.h>
 #include <rte_time.h>
 
-#include "base/igc_osdep.h"
-#include "base/igc_hw.h"
-#include "base/igc_i225.h"
-#include "base/igc_api.h"
+#include "base/e1000_osdep.h"
+#include "base/e1000_hw.h"
+#include "base/e1000_i225.h"
+#include "base/e1000_api.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -55,13 +55,13 @@ extern "C" {
 #define IGC_RX_DESCRIPTOR_MULTIPLE	8
 
 #define IGC_RXD_ALIGN	((uint16_t)(IGC_ALIGN / \
-		sizeof(union igc_adv_rx_desc)))
+		sizeof(union e1000_adv_rx_desc)))
 #define IGC_TXD_ALIGN	((uint16_t)(IGC_ALIGN / \
-		sizeof(union igc_adv_tx_desc)))
+		sizeof(union e1000_adv_tx_desc)))
 #define IGC_MIN_TXD	IGC_TX_DESCRIPTOR_MULTIPLE
-#define IGC_MAX_TXD	((uint16_t)(0x80000 / sizeof(union igc_adv_tx_desc)))
+#define IGC_MAX_TXD	((uint16_t)(0x80000 / sizeof(union e1000_adv_tx_desc)))
 #define IGC_MIN_RXD	IGC_RX_DESCRIPTOR_MULTIPLE
-#define IGC_MAX_RXD	((uint16_t)(0x80000 / sizeof(union igc_adv_rx_desc)))
+#define IGC_MAX_RXD	((uint16_t)(0x80000 / sizeof(union e1000_adv_rx_desc)))
 
 #define IGC_TX_MAX_SEG		UINT8_MAX
 #define IGC_TX_MAX_MTU_SEG	UINT8_MAX
@@ -224,8 +224,8 @@ TAILQ_HEAD(igc_flow_list, rte_flow);
  * Structure to store private data for each driver instance (for each port).
  */
 struct igc_adapter {
-	struct igc_hw		hw;
-	struct igc_hw_stats	stats;
+	struct e1000_hw		hw;
+	struct e1000_hw_stats	stats;
 	struct igc_hw_queue_stats queue_stats;
 	int16_t txq_stats_map[IGC_QUEUE_PAIRS_NUM];
 	int16_t rxq_stats_map[IGC_QUEUE_PAIRS_NUM];
@@ -268,27 +268,27 @@ struct igc_adapter {
 	(&((struct igc_adapter *)(_dev)->data->dev_private)->flow_list)
 
 static inline void
-igc_read_reg_check_set_bits(struct igc_hw *hw, uint32_t reg, uint32_t bits)
+igc_read_reg_check_set_bits(struct e1000_hw *hw, uint32_t reg, uint32_t bits)
 {
-	uint32_t reg_val = IGC_READ_REG(hw, reg);
+	uint32_t reg_val = E1000_READ_REG(hw, reg);
 
 	bits |= reg_val;
 	if (bits == reg_val)
 		return;	/* no need to write back */
 
-	IGC_WRITE_REG(hw, reg, bits);
+	E1000_WRITE_REG(hw, reg, bits);
 }
 
 static inline void
-igc_read_reg_check_clear_bits(struct igc_hw *hw, uint32_t reg, uint32_t bits)
+igc_read_reg_check_clear_bits(struct e1000_hw *hw, uint32_t reg, uint32_t bits)
 {
-	uint32_t reg_val = IGC_READ_REG(hw, reg);
+	uint32_t reg_val = E1000_READ_REG(hw, reg);
 
 	bits = reg_val & ~bits;
 	if (bits == reg_val)
 		return;	/* no need to write back */
 
-	IGC_WRITE_REG(hw, reg, bits);
+	E1000_WRITE_REG(hw, reg, bits);
 }
 
 #ifdef __cplusplus
diff --git a/drivers/net/intel/igc/igc_filter.c b/drivers/net/intel/e1000/igc_filter.c
similarity index 81%
rename from drivers/net/intel/igc/igc_filter.c
rename to drivers/net/intel/e1000/igc_filter.c
index bff98df200..3df7183dbb 100644
--- a/drivers/net/intel/igc/igc_filter.c
+++ b/drivers/net/intel/e1000/igc_filter.c
@@ -3,7 +3,7 @@
  */
 
 #include "rte_malloc.h"
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
@@ -57,7 +57,7 @@ int
 igc_del_ethertype_filter(struct rte_eth_dev *dev,
 			const struct igc_ethertype_filter *filter)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	int ret;
 
@@ -77,8 +77,8 @@ igc_del_ethertype_filter(struct rte_eth_dev *dev,
 
 	igc->ethertype_filters[ret].ether_type = 0;
 
-	IGC_WRITE_REG(hw, IGC_ETQF(ret), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_ETQF(ret), 0);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -86,7 +86,7 @@ int
 igc_add_ethertype_filter(struct rte_eth_dev *dev,
 			const struct igc_ethertype_filter *filter)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	uint32_t etqf;
 	int ret, empty;
@@ -114,13 +114,13 @@ igc_add_ethertype_filter(struct rte_eth_dev *dev,
 	ret = empty;
 
 	etqf = filter->ether_type;
-	etqf |= IGC_ETQF_FILTER_ENABLE | IGC_ETQF_QUEUE_ENABLE;
+	etqf |= E1000_ETQF_FILTER_ENABLE | E1000_ETQF_QUEUE_ENABLE;
 	etqf |= (uint32_t)filter->queue << IGC_ETQF_QUEUE_SHIFT;
 
 	memcpy(&igc->ethertype_filters[ret], filter, sizeof(*filter));
 
-	IGC_WRITE_REG(hw, IGC_ETQF(ret), etqf);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_ETQF(ret), etqf);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -128,13 +128,13 @@ igc_add_ethertype_filter(struct rte_eth_dev *dev,
 static void
 igc_clear_all_ethertype_filter(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	int i;
 
 	for (i = 0; i < IGC_MAX_ETQF_FILTERS; i++)
-		IGC_WRITE_REG(hw, IGC_ETQF(i), 0);
-	IGC_WRITE_FLUSH(hw);
+		E1000_WRITE_REG(hw, E1000_ETQF(i), 0);
+	E1000_WRITE_FLUSH(hw);
 
 	memset(&igc->ethertype_filters, 0, sizeof(igc->ethertype_filters));
 }
@@ -196,59 +196,59 @@ static void
 igc_enable_tuple_filter(struct rte_eth_dev *dev,
 			const struct igc_adapter *igc, uint8_t index)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	const struct igc_ntuple_filter *filter = &igc->ntuple_filters[index];
 	const struct igc_ntuple_info *info = &filter->tuple_info;
-	uint32_t ttqf, imir, imir_ext = IGC_IMIREXT_SIZE_BP;
+	uint32_t ttqf, imir, imir_ext = E1000_IMIREXT_SIZE_BP;
 
 	imir = info->dst_port;
-	imir |= (uint32_t)info->priority << IGC_IMIR_PRIORITY_SHIFT;
+	imir |= (uint32_t)info->priority << E1000_IMIR_PRIORITY_SHIFT;
 
 	/* 0b means not compare. */
 	if (info->dst_port_mask == 0)
-		imir |= IGC_IMIR_PORT_BP;
+		imir |= E1000_IMIR_PORT_BP;
 
-	ttqf = IGC_TTQF_DISABLE_MASK | IGC_TTQF_QUEUE_ENABLE;
-	ttqf |= (uint32_t)filter->queue << IGC_TTQF_QUEUE_SHIFT;
+	ttqf = E1000_TTQF_DISABLE_MASK | E1000_TTQF_QUEUE_ENABLE;
+	ttqf |= (uint32_t)filter->queue << E1000_TTQF_QUEUE_SHIFT;
 	ttqf |= info->proto;
 
 	if (info->proto_mask)
-		ttqf &= ~IGC_TTQF_MASK_ENABLE;
+		ttqf &= ~E1000_TTQF_MASK_ENABLE;
 
 	/* TCP flags bits setting. */
 	if (info->tcp_flags & RTE_NTUPLE_TCP_FLAGS_MASK) {
 		if (info->tcp_flags & RTE_TCP_URG_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_URG;
+			imir_ext |= E1000_IMIREXT_CTRL_URG;
 		if (info->tcp_flags & RTE_TCP_ACK_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_ACK;
+			imir_ext |= E1000_IMIREXT_CTRL_ACK;
 		if (info->tcp_flags & RTE_TCP_PSH_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_PSH;
+			imir_ext |= E1000_IMIREXT_CTRL_PSH;
 		if (info->tcp_flags & RTE_TCP_RST_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_RST;
+			imir_ext |= E1000_IMIREXT_CTRL_RST;
 		if (info->tcp_flags & RTE_TCP_SYN_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_SYN;
+			imir_ext |= E1000_IMIREXT_CTRL_SYN;
 		if (info->tcp_flags & RTE_TCP_FIN_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_FIN;
+			imir_ext |= E1000_IMIREXT_CTRL_FIN;
 	} else {
-		imir_ext |= IGC_IMIREXT_CTRL_BP;
+		imir_ext |= E1000_IMIREXT_CTRL_BP;
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMIR(index), imir);
-	IGC_WRITE_REG(hw, IGC_TTQF(index), ttqf);
-	IGC_WRITE_REG(hw, IGC_IMIREXT(index), imir_ext);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMIR(index), imir);
+	E1000_WRITE_REG(hw, E1000_TTQF(index), ttqf);
+	E1000_WRITE_REG(hw, E1000_IMIREXT(index), imir_ext);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /* Reset hardware register values */
 static void
 igc_disable_tuple_filter(struct rte_eth_dev *dev, uint8_t index)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	IGC_WRITE_REG(hw, IGC_TTQF(index), IGC_TTQF_DISABLE_MASK);
-	IGC_WRITE_REG(hw, IGC_IMIR(index), 0);
-	IGC_WRITE_REG(hw, IGC_IMIREXT(index), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_TTQF(index), E1000_TTQF_DISABLE_MASK);
+	E1000_WRITE_REG(hw, E1000_IMIR(index), 0);
+	E1000_WRITE_REG(hw, E1000_IMIREXT(index), 0);
+	E1000_WRITE_FLUSH(hw);
 }
 
 int
@@ -310,7 +310,7 @@ int
 igc_set_syn_filter(struct rte_eth_dev *dev,
 		const struct igc_syn_filter *filter)
 {
-	struct igc_hw *hw;
+	struct e1000_hw *hw;
 	struct igc_adapter *igc;
 	uint32_t synqf, rfctl;
 
@@ -331,7 +331,7 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 	synqf = (uint32_t)filter->queue << IGC_SYN_FILTER_QUEUE_SHIFT;
 	synqf |= IGC_SYN_FILTER_ENABLE;
 
-	rfctl = IGC_READ_REG(hw, IGC_RFCTL);
+	rfctl = E1000_READ_REG(hw, E1000_RFCTL);
 	if (filter->hig_pri)
 		rfctl |= IGC_RFCTL_SYNQFP;
 	else
@@ -340,9 +340,9 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 	memcpy(&igc->syn_filter, filter, sizeof(igc->syn_filter));
 	igc->syn_filter.enable = 1;
 
-	IGC_WRITE_REG(hw, IGC_RFCTL, rfctl);
-	IGC_WRITE_REG(hw, IGC_SYNQF(0), synqf);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_RFCTL, rfctl);
+	E1000_WRITE_REG(hw, E1000_SYNQF(0), synqf);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -350,11 +350,11 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 void
 igc_clear_syn_filter(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 
-	IGC_WRITE_REG(hw, IGC_SYNQF(0), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_SYNQF(0), 0);
+	E1000_WRITE_FLUSH(hw);
 
 	memset(&igc->syn_filter, 0, sizeof(igc->syn_filter));
 }
diff --git a/drivers/net/intel/igc/igc_filter.h b/drivers/net/intel/e1000/igc_filter.h
similarity index 100%
rename from drivers/net/intel/igc/igc_filter.h
rename to drivers/net/intel/e1000/igc_filter.h
diff --git a/drivers/net/intel/igc/igc_flow.c b/drivers/net/intel/e1000/igc_flow.c
similarity index 99%
rename from drivers/net/intel/igc/igc_flow.c
rename to drivers/net/intel/e1000/igc_flow.c
index b778ac2613..b947cf8b08 100644
--- a/drivers/net/intel/igc/igc_flow.c
+++ b/drivers/net/intel/e1000/igc_flow.c
@@ -3,7 +3,7 @@
  */
 
 #include "rte_malloc.h"
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
diff --git a/drivers/net/intel/igc/igc_flow.h b/drivers/net/intel/e1000/igc_flow.h
similarity index 100%
rename from drivers/net/intel/igc/igc_flow.h
rename to drivers/net/intel/e1000/igc_flow.h
diff --git a/drivers/net/intel/igc/igc_logs.c b/drivers/net/intel/e1000/igc_logs.c
similarity index 90%
rename from drivers/net/intel/igc/igc_logs.c
rename to drivers/net/intel/e1000/igc_logs.c
index 9cb8da527e..df91d173dd 100644
--- a/drivers/net/intel/igc/igc_logs.c
+++ b/drivers/net/intel/e1000/igc_logs.c
@@ -4,7 +4,7 @@
 
 #include <rte_common.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 
 RTE_LOG_REGISTER_SUFFIX(igc_logtype_init, init, INFO);
 RTE_LOG_REGISTER_SUFFIX(igc_logtype_driver, driver, INFO);
diff --git a/drivers/net/intel/igc/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
similarity index 87%
rename from drivers/net/intel/igc/igc_txrx.c
rename to drivers/net/intel/e1000/igc_txrx.c
index fabab5b1a3..9b2eb343ef 100644
--- a/drivers/net/intel/igc/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -8,7 +8,7 @@
 #include <ethdev_driver.h>
 #include <rte_net.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 
 #ifdef RTE_PMD_USE_PREFETCH
@@ -24,16 +24,16 @@
 #endif
 
 /* Multicast / Unicast table offset mask. */
-#define IGC_RCTL_MO_MSK			(3u << IGC_RCTL_MO_SHIFT)
+#define E1000_RCTL_MO_MSK			(3u << E1000_RCTL_MO_SHIFT)
 
 /* Loopback mode. */
-#define IGC_RCTL_LBM_SHIFT		6
-#define IGC_RCTL_LBM_MSK		(3u << IGC_RCTL_LBM_SHIFT)
+#define E1000_RCTL_LBM_SHIFT		6
+#define E1000_RCTL_LBM_MSK		(3u << E1000_RCTL_LBM_SHIFT)
 
 /* Hash select for MTA */
-#define IGC_RCTL_HSEL_SHIFT		8
-#define IGC_RCTL_HSEL_MSK		(3u << IGC_RCTL_HSEL_SHIFT)
-#define IGC_RCTL_PSP			(1u << 21)
+#define E1000_RCTL_HSEL_SHIFT		8
+#define E1000_RCTL_HSEL_MSK		(3u << E1000_RCTL_HSEL_SHIFT)
+#define E1000_RCTL_PSP			(1u << 21)
 
 /* Receive buffer size for header buffer */
 #define IGC_SRRCTL_BSIZEHEADER_SHIFT	8
@@ -109,14 +109,14 @@ rx_desc_statuserr_to_pkt_flags(uint32_t statuserr)
 	uint64_t pkt_flags = 0;
 	uint32_t tmp;
 
-	if (statuserr & IGC_RXD_STAT_VP)
+	if (statuserr & E1000_RXD_STAT_VP)
 		pkt_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 
-	tmp = !!(statuserr & (IGC_RXD_STAT_L4CS | IGC_RXD_STAT_UDPCS));
+	tmp = !!(statuserr & (IGC_RXD_STAT_L4CS | E1000_RXD_STAT_UDPCS));
 	tmp = (tmp << 1) | (uint32_t)!!(statuserr & IGC_RXD_EXT_ERR_L4E);
 	pkt_flags |= l4_chksum_flags[tmp];
 
-	tmp = !!(statuserr & IGC_RXD_STAT_IPCS);
+	tmp = !!(statuserr & E1000_RXD_STAT_IPCS);
 	tmp = (tmp << 1) | (uint32_t)!!(statuserr & IGC_RXD_EXT_ERR_IPE);
 	pkt_flags |= l3_chksum_flags[tmp];
 
@@ -193,7 +193,7 @@ rx_desc_pkt_info_to_pkt_type(uint32_t pkt_info)
 		[IGC_PACKET_TYPE_IPV4_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_SCTP,
 	};
-	if (unlikely(pkt_info & IGC_RXDADV_PKTTYPE_ETQF))
+	if (unlikely(pkt_info & E1000_RXDADV_PKTTYPE_ETQF))
 		return RTE_PTYPE_UNKNOWN;
 
 	pkt_info = (pkt_info >> IGC_PACKET_TYPE_SHIFT) & IGC_PACKET_TYPE_MASK;
@@ -203,7 +203,7 @@ rx_desc_pkt_info_to_pkt_type(uint32_t pkt_info)
 
 static inline void
 rx_desc_get_pkt_info(struct igc_rx_queue *rxq, struct rte_mbuf *rxm,
-		union igc_adv_rx_desc *rxd, uint32_t staterr)
+		union e1000_adv_rx_desc *rxd, uint32_t staterr)
 {
 	uint64_t pkt_flags;
 	uint32_t hlen_type_rss;
@@ -237,18 +237,18 @@ uint16_t
 igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct igc_rx_queue * const rxq = rx_queue;
-	volatile union igc_adv_rx_desc * const rx_ring = rxq->rx_ring;
+	volatile union e1000_adv_rx_desc * const rx_ring = rxq->rx_ring;
 	struct igc_rx_entry * const sw_ring = rxq->sw_ring;
 	uint16_t rx_id = rxq->rx_tail;
 	uint16_t nb_rx = 0;
 	uint16_t nb_hold = 0;
 
 	while (nb_rx < nb_pkts) {
-		volatile union igc_adv_rx_desc *rxdp;
+		volatile union e1000_adv_rx_desc *rxdp;
 		struct igc_rx_entry *rxe;
 		struct rte_mbuf *rxm;
 		struct rte_mbuf *nmb;
-		union igc_adv_rx_desc rxd;
+		union e1000_adv_rx_desc rxd;
 		uint32_t staterr;
 		uint16_t data_len;
 
@@ -262,14 +262,14 @@ igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 */
 		rxdp = &rx_ring[rx_id];
 		staterr = rte_cpu_to_le_32(rxdp->wb.upper.status_error);
-		if (!(staterr & IGC_RXD_STAT_DD))
+		if (!(staterr & E1000_RXD_STAT_DD))
 			break;
 		rxd = *rxdp;
 
 		/*
 		 * End of packet.
 		 *
-		 * If the IGC_RXD_STAT_EOP flag is not set, the RX packet is
+		 * If the E1000_RXD_STAT_EOP flag is not set, the RX packet is
 		 * likely to be invalid and to be dropped by the various
 		 * validation checks performed by the network stack.
 		 *
@@ -391,7 +391,7 @@ igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			"port_id=%u queue_id=%u rx_tail=%u nb_hold=%u nb_rx=%u",
 			rxq->port_id, rxq->queue_id, rx_id, nb_hold, nb_rx);
 		rx_id = (rx_id == 0) ? (rxq->nb_rx_desc - 1) : (rx_id - 1);
-		IGC_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
 		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
@@ -403,7 +403,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
 	struct igc_rx_queue * const rxq = rx_queue;
-	volatile union igc_adv_rx_desc * const rx_ring = rxq->rx_ring;
+	volatile union e1000_adv_rx_desc * const rx_ring = rxq->rx_ring;
 	struct igc_rx_entry * const sw_ring = rxq->sw_ring;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
@@ -413,11 +413,11 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint16_t nb_hold = 0;
 
 	while (nb_rx < nb_pkts) {
-		volatile union igc_adv_rx_desc *rxdp;
+		volatile union e1000_adv_rx_desc *rxdp;
 		struct igc_rx_entry *rxe;
 		struct rte_mbuf *rxm;
 		struct rte_mbuf *nmb;
-		union igc_adv_rx_desc rxd;
+		union e1000_adv_rx_desc rxd;
 		uint32_t staterr;
 		uint16_t data_len;
 
@@ -432,7 +432,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 */
 		rxdp = &rx_ring[rx_id];
 		staterr = rte_cpu_to_le_32(rxdp->wb.upper.status_error);
-		if (!(staterr & IGC_RXD_STAT_DD))
+		if (!(staterr & E1000_RXD_STAT_DD))
 			break;
 		rxd = *rxdp;
 
@@ -559,7 +559,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * update the pointer to the last mbuf of the current scattered
 		 * packet and continue to parse the RX ring.
 		 */
-		if (!(staterr & IGC_RXD_STAT_EOP)) {
+		if (!(staterr & E1000_RXD_STAT_EOP)) {
 			last_seg = rxm;
 			goto next_desc;
 		}
@@ -631,7 +631,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			"port_id=%u queue_id=%u rx_tail=%u nb_hold=%u nb_rx=%u",
 			rxq->port_id, rxq->queue_id, rx_id, nb_hold, nb_rx);
 		rx_id = (rx_id == 0) ? (rxq->nb_rx_desc - 1) : (rx_id - 1);
-		IGC_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
 		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
@@ -676,7 +676,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 	 */
 #define IGC_RXQ_SCAN_INTERVAL 4
 
-	volatile union igc_adv_rx_desc *rxdp;
+	volatile union e1000_adv_rx_desc *rxdp;
 	struct igc_rx_queue *rxq;
 	uint16_t desc = 0;
 
@@ -685,7 +685,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 
 	while (desc < rxq->nb_rx_desc - rxq->rx_tail) {
 		if (unlikely(!(rxdp->wb.upper.status_error &
-				IGC_RXD_STAT_DD)))
+				E1000_RXD_STAT_DD)))
 			return desc;
 		desc += IGC_RXQ_SCAN_INTERVAL;
 		rxdp += IGC_RXQ_SCAN_INTERVAL;
@@ -693,7 +693,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 	rxdp = &rxq->rx_ring[rxq->rx_tail + desc - rxq->nb_rx_desc];
 
 	while (desc < rxq->nb_rx_desc &&
-		(rxdp->wb.upper.status_error & IGC_RXD_STAT_DD)) {
+		(rxdp->wb.upper.status_error & E1000_RXD_STAT_DD)) {
 		desc += IGC_RXQ_SCAN_INTERVAL;
 		rxdp += IGC_RXQ_SCAN_INTERVAL;
 	}
@@ -718,7 +718,7 @@ int eth_igc_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		desc -= rxq->nb_rx_desc;
 
 	status = &rxq->rx_ring[desc].wb.upper.status_error;
-	if (*status & rte_cpu_to_le_32(IGC_RXD_STAT_DD))
+	if (*status & rte_cpu_to_le_32(E1000_RXD_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
 	return RTE_ETH_RX_DESC_AVAIL;
@@ -733,7 +733,7 @@ igc_alloc_rx_queue_mbufs(struct igc_rx_queue *rxq)
 
 	/* Initialize software ring entries. */
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
-		volatile union igc_adv_rx_desc *rxd;
+		volatile union e1000_adv_rx_desc *rxd;
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
 
 		if (mbuf == NULL) {
@@ -769,16 +769,16 @@ static uint8_t default_rss_key[40] = {
 void
 igc_rss_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t mrqc;
 
-	mrqc = IGC_READ_REG(hw, IGC_MRQC);
-	mrqc &= ~IGC_MRQC_ENABLE_MASK;
-	IGC_WRITE_REG(hw, IGC_MRQC, mrqc);
+	mrqc = E1000_READ_REG(hw, E1000_MRQC);
+	mrqc &= ~E1000_MRQC_ENABLE_MASK;
+	E1000_WRITE_REG(hw, E1000_MRQC, mrqc);
 }
 
 void
-igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf)
+igc_hw_rss_hash_set(struct e1000_hw *hw, struct rte_eth_rss_conf *rss_conf)
 {
 	uint32_t *hash_key = (uint32_t *)rss_conf->rss_key;
 	uint32_t mrqc;
@@ -789,38 +789,38 @@ igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf)
 
 		/* Fill in RSS hash key */
 		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
-			IGC_WRITE_REG_LE_VALUE(hw, IGC_RSSRK(i), hash_key[i]);
+			E1000_WRITE_REG_LE_VALUE(hw, E1000_RSSRK(i), hash_key[i]);
 	}
 
 	/* Set configured hashing protocols in MRQC register */
 	rss_hf = rss_conf->rss_hf;
-	mrqc = IGC_MRQC_ENABLE_RSS_4Q; /* RSS enabled. */
+	mrqc = E1000_MRQC_ENABLE_RSS_4Q; /* RSS enabled. */
 	if (rss_hf & RTE_ETH_RSS_IPV4)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4_TCP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4_TCP;
 	if (rss_hf & RTE_ETH_RSS_IPV6)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6;
 	if (rss_hf & RTE_ETH_RSS_IPV6_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_EX;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_EX;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_TCP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_TCP;
 	if (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_TCP_EX;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_TCP_EX;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4_UDP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4_UDP;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_UDP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_UDP;
 	if (rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_UDP_EX;
-	IGC_WRITE_REG(hw, IGC_MRQC, mrqc);
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_UDP_EX;
+	E1000_WRITE_REG(hw, E1000_MRQC, mrqc);
 }
 
 static void
 igc_rss_configure(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rss_conf rss_conf;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	/* Fill in redirection table. */
@@ -833,8 +833,8 @@ igc_rss_configure(struct rte_eth_dev *dev)
 		reta_idx = i % sizeof(reta);
 		reta.bytes[reta_idx] = q_idx;
 		if (reta_idx == sizeof(reta) - 1)
-			IGC_WRITE_REG_LE_VALUE(hw,
-				IGC_RETA(i / sizeof(reta)), reta.dword);
+			E1000_WRITE_REG_LE_VALUE(hw,
+				E1000_RETA(i / sizeof(reta)), reta.dword);
 	}
 
 	/*
@@ -903,7 +903,7 @@ igc_add_rss_filter(struct rte_eth_dev *dev, struct igc_rss_filter *rss)
 		.rss_key_len = rss->conf.key_len,
 		.rss_hf = rss->conf.types,
 	};
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_rss_filter *rss_filter = IGC_DEV_PRIVATE_RSS_FILTER(dev);
 	uint32_t i, j;
 
@@ -950,8 +950,8 @@ igc_add_rss_filter(struct rte_eth_dev *dev, struct igc_rss_filter *rss)
 		reta_idx = i % sizeof(reta);
 		reta.bytes[reta_idx] = q_idx;
 		if (reta_idx == sizeof(reta) - 1)
-			IGC_WRITE_REG_LE_VALUE(hw,
-				IGC_RETA(i / sizeof(reta)), reta.dword);
+			E1000_WRITE_REG_LE_VALUE(hw,
+				E1000_RETA(i / sizeof(reta)), reta.dword);
 	}
 
 	if (rss_conf.rss_key == NULL)
@@ -1008,7 +1008,7 @@ int
 igc_rx_init(struct rte_eth_dev *dev)
 {
 	struct igc_rx_queue *rxq;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint64_t offloads = dev->data->dev_conf.rxmode.offloads;
 	uint32_t max_rx_pktlen;
 	uint32_t rctl;
@@ -1024,21 +1024,21 @@ igc_rx_init(struct rte_eth_dev *dev)
 	 * Make sure receives are disabled while setting
 	 * up the descriptor ring.
 	 */
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl & ~IGC_RCTL_EN);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl & ~E1000_RCTL_EN);
 
 	/* Configure support of jumbo frames, if any. */
 	if (dev->data->mtu > RTE_ETHER_MTU)
-		rctl |= IGC_RCTL_LPE;
+		rctl |= E1000_RCTL_LPE;
 	else
-		rctl &= ~IGC_RCTL_LPE;
+		rctl &= ~E1000_RCTL_LPE;
 
 	max_rx_pktlen = dev->data->mtu + IGC_ETH_OVERHEAD;
 	/*
 	 * Set maximum packet length by default, and might be updated
 	 * together with enabling/disabling dual VLAN.
 	 */
-	IGC_WRITE_REG(hw, IGC_RLPML, max_rx_pktlen);
+	E1000_WRITE_REG(hw, E1000_RLPML, max_rx_pktlen);
 
 	/* Configure and enable each RX queue. */
 	rctl_bsize = 0;
@@ -1066,16 +1066,16 @@ igc_rx_init(struct rte_eth_dev *dev)
 				RTE_ETHER_CRC_LEN : 0;
 
 		bus_addr = rxq->rx_ring_phys_addr;
-		IGC_WRITE_REG(hw, IGC_RDLEN(rxq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_RDLEN(rxq->reg_idx),
 				rxq->nb_rx_desc *
-				sizeof(union igc_adv_rx_desc));
-		IGC_WRITE_REG(hw, IGC_RDBAH(rxq->reg_idx),
+				sizeof(union e1000_adv_rx_desc));
+		E1000_WRITE_REG(hw, E1000_RDBAH(rxq->reg_idx),
 				(uint32_t)(bus_addr >> 32));
-		IGC_WRITE_REG(hw, IGC_RDBAL(rxq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_RDBAL(rxq->reg_idx),
 				(uint32_t)bus_addr);
 
 		/* set descriptor configuration */
-		srrctl = IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
+		srrctl = E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 		srrctl |= (uint32_t)(RTE_PKTMBUF_HEADROOM / 64) <<
 				IGC_SRRCTL_BSIZEHEADER_SHIFT;
@@ -1093,11 +1093,11 @@ igc_rx_init(struct rte_eth_dev *dev)
 			 * determines the RX packet buffer size.
 			 */
 
-			srrctl |= ((buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT) &
-				   IGC_SRRCTL_BSIZEPKT_MASK);
+			srrctl |= ((buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT) &
+				   E1000_SRRCTL_BSIZEPKT_MASK);
 			buf_size = (uint16_t)((srrctl &
-					IGC_SRRCTL_BSIZEPKT_MASK) <<
-					IGC_SRRCTL_BSIZEPKT_SHIFT);
+					E1000_SRRCTL_BSIZEPKT_MASK) <<
+					E1000_SRRCTL_BSIZEPKT_SHIFT);
 
 			/* It adds dual VLAN length for supporting dual VLAN */
 			if (max_rx_pktlen > buf_size)
@@ -1113,19 +1113,19 @@ igc_rx_init(struct rte_eth_dev *dev)
 
 		/* Set if packets are dropped when no descriptors available */
 		if (rxq->drop_en)
-			srrctl |= IGC_SRRCTL_DROP_EN;
+			srrctl |= E1000_SRRCTL_DROP_EN;
 
-		IGC_WRITE_REG(hw, IGC_SRRCTL(rxq->reg_idx), srrctl);
+		E1000_WRITE_REG(hw, E1000_SRRCTL(rxq->reg_idx), srrctl);
 
 		/* Enable this RX queue. */
-		rxdctl = IGC_RXDCTL_QUEUE_ENABLE;
+		rxdctl = E1000_RXDCTL_QUEUE_ENABLE;
 		rxdctl |= ((uint32_t)rxq->pthresh << IGC_RXDCTL_PTHRESH_SHIFT) &
 				IGC_RXDCTL_PTHRESH_MSK;
 		rxdctl |= ((uint32_t)rxq->hthresh << IGC_RXDCTL_HTHRESH_SHIFT) &
 				IGC_RXDCTL_HTHRESH_MSK;
 		rxdctl |= ((uint32_t)rxq->wthresh << IGC_RXDCTL_WTHRESH_SHIFT) &
 				IGC_RXDCTL_WTHRESH_MSK;
-		IGC_WRITE_REG(hw, IGC_RXDCTL(rxq->reg_idx), rxdctl);
+		E1000_WRITE_REG(hw, E1000_RXDCTL(rxq->reg_idx), rxdctl);
 	}
 
 	if (offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
@@ -1141,19 +1141,19 @@ igc_rx_init(struct rte_eth_dev *dev)
 	 * register, since the code above configures the SRRCTL register of
 	 * the RX queue in such a case.
 	 * All configurable sizes are:
-	 * 16384: rctl |= (IGC_RCTL_SZ_16384 | IGC_RCTL_BSEX);
-	 *  8192: rctl |= (IGC_RCTL_SZ_8192  | IGC_RCTL_BSEX);
-	 *  4096: rctl |= (IGC_RCTL_SZ_4096  | IGC_RCTL_BSEX);
-	 *  2048: rctl |= IGC_RCTL_SZ_2048;
-	 *  1024: rctl |= IGC_RCTL_SZ_1024;
-	 *   512: rctl |= IGC_RCTL_SZ_512;
-	 *   256: rctl |= IGC_RCTL_SZ_256;
+	 * 16384: rctl |= (E1000_RCTL_SZ_16384 | E1000_RCTL_BSEX);
+	 *  8192: rctl |= (E1000_RCTL_SZ_8192  | E1000_RCTL_BSEX);
+	 *  4096: rctl |= (E1000_RCTL_SZ_4096  | E1000_RCTL_BSEX);
+	 *  2048: rctl |= E1000_RCTL_SZ_2048;
+	 *  1024: rctl |= E1000_RCTL_SZ_1024;
+	 *   512: rctl |= E1000_RCTL_SZ_512;
+	 *   256: rctl |= E1000_RCTL_SZ_256;
 	 */
 	if (rctl_bsize > 0) {
 		if (rctl_bsize >= 512) /* 512 <= buf_size < 1024 - use 512 */
-			rctl |= IGC_RCTL_SZ_512;
+			rctl |= E1000_RCTL_SZ_512;
 		else /* 256 <= buf_size < 512 - use 256 */
-			rctl |= IGC_RCTL_SZ_256;
+			rctl |= E1000_RCTL_SZ_256;
 	}
 
 	/*
@@ -1162,61 +1162,61 @@ igc_rx_init(struct rte_eth_dev *dev)
 	igc_dev_mq_rx_configure(dev);
 
 	/* Update the rctl since igc_dev_mq_rx_configure may change its value */
-	rctl |= IGC_READ_REG(hw, IGC_RCTL);
+	rctl |= E1000_READ_REG(hw, E1000_RCTL);
 
 	/*
 	 * Setup the Checksum Register.
 	 * Receive Full-Packet Checksum Offload is mutually exclusive with RSS.
 	 */
-	rxcsum = IGC_READ_REG(hw, IGC_RXCSUM);
-	rxcsum |= IGC_RXCSUM_PCSD;
+	rxcsum = E1000_READ_REG(hw, E1000_RXCSUM);
+	rxcsum |= E1000_RXCSUM_PCSD;
 
 	/* Enable both L3/L4 rx checksum offload */
 	if (offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM)
-		rxcsum |= IGC_RXCSUM_IPOFL;
+		rxcsum |= E1000_RXCSUM_IPOFL;
 	else
-		rxcsum &= ~IGC_RXCSUM_IPOFL;
+		rxcsum &= ~E1000_RXCSUM_IPOFL;
 
 	if (offloads &
 		(RTE_ETH_RX_OFFLOAD_TCP_CKSUM | RTE_ETH_RX_OFFLOAD_UDP_CKSUM)) {
-		rxcsum |= IGC_RXCSUM_TUOFL;
+		rxcsum |= E1000_RXCSUM_TUOFL;
 		offloads |= RTE_ETH_RX_OFFLOAD_SCTP_CKSUM;
 	} else {
-		rxcsum &= ~IGC_RXCSUM_TUOFL;
+		rxcsum &= ~E1000_RXCSUM_TUOFL;
 	}
 
 	if (offloads & RTE_ETH_RX_OFFLOAD_SCTP_CKSUM)
-		rxcsum |= IGC_RXCSUM_CRCOFL;
+		rxcsum |= E1000_RXCSUM_CRCOFL;
 	else
-		rxcsum &= ~IGC_RXCSUM_CRCOFL;
+		rxcsum &= ~E1000_RXCSUM_CRCOFL;
 
-	IGC_WRITE_REG(hw, IGC_RXCSUM, rxcsum);
+	E1000_WRITE_REG(hw, E1000_RXCSUM, rxcsum);
 
 	/* Setup the Receive Control Register. */
 	if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
-		rctl &= ~IGC_RCTL_SECRC; /* Do not Strip Ethernet CRC. */
+		rctl &= ~E1000_RCTL_SECRC; /* Do not Strip Ethernet CRC. */
 	else
-		rctl |= IGC_RCTL_SECRC; /* Strip Ethernet CRC. */
+		rctl |= E1000_RCTL_SECRC; /* Strip Ethernet CRC. */
 
-	rctl &= ~IGC_RCTL_MO_MSK;
-	rctl &= ~IGC_RCTL_LBM_MSK;
-	rctl |= IGC_RCTL_EN | IGC_RCTL_BAM | IGC_RCTL_LBM_NO |
-			IGC_RCTL_DPF |
-			(hw->mac.mc_filter_type << IGC_RCTL_MO_SHIFT);
+	rctl &= ~E1000_RCTL_MO_MSK;
+	rctl &= ~E1000_RCTL_LBM_MSK;
+	rctl |= E1000_RCTL_EN | E1000_RCTL_BAM | E1000_RCTL_LBM_NO |
+			E1000_RCTL_DPF |
+			(hw->mac.mc_filter_type << E1000_RCTL_MO_SHIFT);
 
 	if (dev->data->dev_conf.lpbk_mode == 1)
-		rctl |= IGC_RCTL_LBM_MAC;
+		rctl |= E1000_RCTL_LBM_MAC;
 
-	rctl &= ~(IGC_RCTL_HSEL_MSK | IGC_RCTL_CFIEN | IGC_RCTL_CFI |
-			IGC_RCTL_PSP | IGC_RCTL_PMCF);
+	rctl &= ~(E1000_RCTL_HSEL_MSK | E1000_RCTL_CFIEN | E1000_RCTL_CFI |
+			E1000_RCTL_PSP | E1000_RCTL_PMCF);
 
 	/* Make sure VLAN Filters are off. */
-	rctl &= ~IGC_RCTL_VFE;
+	rctl &= ~E1000_RCTL_VFE;
 	/* Don't store bad packets. */
-	rctl &= ~IGC_RCTL_SBP;
+	rctl &= ~E1000_RCTL_SBP;
 
 	/* Enable Receives. */
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 
 	/*
 	 * Setup the HW Rx Head and Tail Descriptor Pointers.
@@ -1226,21 +1226,21 @@ igc_rx_init(struct rte_eth_dev *dev)
 		uint32_t dvmolr;
 
 		rxq = dev->data->rx_queues[i];
-		IGC_WRITE_REG(hw, IGC_RDH(rxq->reg_idx), 0);
-		IGC_WRITE_REG(hw, IGC_RDT(rxq->reg_idx), rxq->nb_rx_desc - 1);
+		E1000_WRITE_REG(hw, E1000_RDH(rxq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_RDT(rxq->reg_idx), rxq->nb_rx_desc - 1);
 
-		dvmolr = IGC_READ_REG(hw, IGC_DVMOLR(rxq->reg_idx));
+		dvmolr = E1000_READ_REG(hw, E1000_DVMOLR(rxq->reg_idx));
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
-			dvmolr |= IGC_DVMOLR_STRVLAN;
+			dvmolr |= E1000_DVMOLR_STRVLAN;
 		else
-			dvmolr &= ~IGC_DVMOLR_STRVLAN;
+			dvmolr &= ~E1000_DVMOLR_STRVLAN;
 
 		if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
-			dvmolr &= ~IGC_DVMOLR_STRCRC;
+			dvmolr &= ~E1000_DVMOLR_STRCRC;
 		else
-			dvmolr |= IGC_DVMOLR_STRCRC;
+			dvmolr |= E1000_DVMOLR_STRCRC;
 
-		IGC_WRITE_REG(hw, IGC_DVMOLR(rxq->reg_idx), dvmolr);
+		E1000_WRITE_REG(hw, E1000_DVMOLR(rxq->reg_idx), dvmolr);
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	}
 
@@ -1250,7 +1250,7 @@ igc_rx_init(struct rte_eth_dev *dev)
 static void
 igc_reset_rx_queue(struct igc_rx_queue *rxq)
 {
-	static const union igc_adv_rx_desc zeroed_desc = { {0} };
+	static const union e1000_adv_rx_desc zeroed_desc = { {0} };
 	unsigned int i;
 
 	/* Zero out HW ring memory */
@@ -1270,7 +1270,7 @@ eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	const struct rte_memzone *rz;
 	struct igc_rx_queue *rxq;
 	unsigned int size;
@@ -1317,17 +1317,17 @@ eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 	 *  handle the maximum ring size is allocated in order to allow for
 	 *  resizing in later calls to the queue setup function.
 	 */
-	size = sizeof(union igc_adv_rx_desc) * IGC_MAX_RXD;
+	size = sizeof(union e1000_adv_rx_desc) * IGC_MAX_RXD;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
 				      IGC_ALIGN, socket_id);
 	if (rz == NULL) {
 		igc_rx_queue_release(rxq);
 		return -ENOMEM;
 	}
-	rxq->rdt_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_RDT(rxq->reg_idx));
-	rxq->rdh_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_RDH(rxq->reg_idx));
+	rxq->rdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDT(rxq->reg_idx));
+	rxq->rdh_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDH(rxq->reg_idx));
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union igc_adv_rx_desc *)rz->addr;
+	rxq->rx_ring = (union e1000_adv_rx_desc *)rz->addr;
 
 	/* Allocate software ring. */
 	rxq->sw_ring = rte_zmalloc("rxq->sw_ring",
@@ -1457,7 +1457,7 @@ static uint32_t igc_tx_launchtime(uint64_t txtime, uint16_t port_id)
  */
 static inline void
 igc_set_xmit_ctx(struct igc_tx_queue *txq,
-		volatile struct igc_adv_tx_context_desc *ctx_txd,
+		volatile struct e1000_adv_tx_context_desc *ctx_txd,
 		uint64_t ol_flags, union igc_tx_offload tx_offload,
 		uint64_t txtime)
 {
@@ -1475,7 +1475,7 @@ igc_set_xmit_ctx(struct igc_tx_queue *txq,
 	type_tucmd_mlhl = 0;
 
 	/* Specify which HW CTX to upload. */
-	mss_l4len_idx = (ctx_curr << IGC_ADVTXD_IDX_SHIFT);
+	mss_l4len_idx = (ctx_curr << E1000_ADVTXD_IDX_SHIFT);
 
 	if (ol_flags & RTE_MBUF_F_TX_VLAN)
 		tx_offload_mask.vlan_tci = 0xffff;
@@ -1484,51 +1484,51 @@ igc_set_xmit_ctx(struct igc_tx_queue *txq,
 	if (ol_flags & IGC_TX_OFFLOAD_SEG) {
 		/* implies IP cksum in IPv4 */
 		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV4 |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV4 |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 		else
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV6 |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV6 |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_TCP;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_TCP;
 		else
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_UDP;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_UDP;
 
 		tx_offload_mask.data |= TX_TSO_CMP_MASK;
 		mss_l4len_idx |= (uint32_t)tx_offload.tso_segsz <<
-				IGC_ADVTXD_MSS_SHIFT;
+				E1000_ADVTXD_MSS_SHIFT;
 		mss_l4len_idx |= (uint32_t)tx_offload.l4_len <<
-				IGC_ADVTXD_L4LEN_SHIFT;
+				E1000_ADVTXD_L4LEN_SHIFT;
 	} else { /* no TSO, check if hardware checksum is needed */
 		if (ol_flags & (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_L4_MASK))
 			tx_offload_mask.data |= TX_MACIP_LEN_CMP_MASK;
 
 		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV4;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV4;
 
 		switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 		case RTE_MBUF_F_TX_TCP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_TCP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_TCP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_tcp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		case RTE_MBUF_F_TX_UDP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_UDP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_UDP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_udp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		case RTE_MBUF_F_TX_SCTP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_SCTP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_SCTP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_sctp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		default:
 			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_RSV |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			break;
 		}
 	}
@@ -1556,8 +1556,8 @@ static inline uint32_t
 tx_desc_vlan_flags_to_cmdtype(uint64_t ol_flags)
 {
 	uint32_t cmdtype;
-	static uint32_t vlan_cmd[2] = {0, IGC_ADVTXD_DCMD_VLE};
-	static uint32_t tso_cmd[2] = {0, IGC_ADVTXD_DCMD_TSE};
+	static uint32_t vlan_cmd[2] = {0, E1000_ADVTXD_DCMD_VLE};
+	static uint32_t tso_cmd[2] = {0, E1000_ADVTXD_DCMD_TSE};
 	cmdtype = vlan_cmd[(ol_flags & RTE_MBUF_F_TX_VLAN) != 0];
 	cmdtype |= tso_cmd[(ol_flags & IGC_TX_OFFLOAD_SEG) != 0];
 	return cmdtype;
@@ -1582,8 +1582,8 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct igc_tx_queue * const txq = tx_queue;
 	struct igc_tx_entry * const sw_ring = txq->sw_ring;
 	struct igc_tx_entry *txe, *txn;
-	volatile union igc_adv_tx_desc * const txr = txq->tx_ring;
-	volatile union igc_adv_tx_desc *txd;
+	volatile union e1000_adv_tx_desc * const txr = txq->tx_ring;
+	volatile union e1000_adv_tx_desc *txd;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
@@ -1691,7 +1691,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		/*
 		 * Check that this descriptor is free.
 		 */
-		if (!(txr[tx_end].wb.status & IGC_TXD_STAT_DD)) {
+		if (!(txr[tx_end].wb.status & E1000_TXD_STAT_DD)) {
 			if (nb_tx == 0)
 				return 0;
 			goto end_of_tx;
@@ -1701,43 +1701,43 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * Set common flags of all TX Data Descriptors.
 		 *
 		 * The following bits must be set in all Data Descriptors:
-		 *   - IGC_ADVTXD_DTYP_DATA
-		 *   - IGC_ADVTXD_DCMD_DEXT
+		 *   - E1000_ADVTXD_DTYP_DATA
+		 *   - E1000_ADVTXD_DCMD_DEXT
 		 *
 		 * The following bits must be set in the first Data Descriptor
 		 * and are ignored in the other ones:
-		 *   - IGC_ADVTXD_DCMD_IFCS
-		 *   - IGC_ADVTXD_MAC_1588
-		 *   - IGC_ADVTXD_DCMD_VLE
+		 *   - E1000_ADVTXD_DCMD_IFCS
+		 *   - E1000_ADVTXD_MAC_1588
+		 *   - E1000_ADVTXD_DCMD_VLE
 		 *
 		 * The following bits must only be set in the last Data
 		 * Descriptor:
-		 *   - IGC_TXD_CMD_EOP
+		 *   - E1000_TXD_CMD_EOP
 		 *
 		 * The following bits can be set in any Data Descriptor, but
 		 * are only set in the last Data Descriptor:
-		 *   - IGC_TXD_CMD_RS
+		 *   - E1000_TXD_CMD_RS
 		 */
 		cmd_type_len = txq->txd_type |
-			IGC_ADVTXD_DCMD_IFCS | IGC_ADVTXD_DCMD_DEXT;
+			E1000_ADVTXD_DCMD_IFCS | E1000_ADVTXD_DCMD_DEXT;
 		if (tx_ol_req & IGC_TX_OFFLOAD_SEG)
 			pkt_len -= (tx_pkt->l2_len + tx_pkt->l3_len +
 					tx_pkt->l4_len);
-		olinfo_status = (pkt_len << IGC_ADVTXD_PAYLEN_SHIFT);
+		olinfo_status = (pkt_len << E1000_ADVTXD_PAYLEN_SHIFT);
 
 		/*
 		 * Timer 0 should be used to for packet timestamping,
 		 * sample the packet timestamp to reg 0
 		 */
 		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
-			cmd_type_len |= IGC_ADVTXD_MAC_TSTAMP;
+			cmd_type_len |= E1000_ADVTXD_MAC_TSTAMP;
 
 		if (tx_ol_req) {
 			/* Setup TX Advanced context descriptor if required */
 			if (new_ctx) {
-				volatile struct igc_adv_tx_context_desc *
+				volatile struct e1000_adv_tx_context_desc *
 					ctx_txd = (volatile struct
-					igc_adv_tx_context_desc *)&txr[tx_id];
+					e1000_adv_tx_context_desc *)&txr[tx_id];
 
 				txn = &sw_ring[txe->next_id];
 				RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
@@ -1769,7 +1769,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			olinfo_status |=
 				tx_desc_cksum_flags_to_olinfo(tx_ol_req);
 			olinfo_status |= (uint32_t)txq->ctx_curr <<
-					IGC_ADVTXD_IDX_SHIFT;
+					E1000_ADVTXD_IDX_SHIFT;
 		}
 
 		m_seg = tx_pkt;
@@ -1803,7 +1803,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * and Report Status (RS).
 		 */
 		txd->read.cmd_type_len |=
-			rte_cpu_to_le_32(IGC_TXD_CMD_EOP | IGC_TXD_CMD_RS);
+			rte_cpu_to_le_32(E1000_TXD_CMD_EOP | E1000_TXD_CMD_RS);
 	}
 end_of_tx:
 	rte_wmb();
@@ -1811,7 +1811,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/*
 	 * Set the Transmit Descriptor Tail (TDT).
 	 */
-	IGC_PCI_REG_WRITE_RELAXED(txq->tdt_reg_addr, tx_id);
+	E1000_PCI_REG_WRITE_RELAXED(txq->tdt_reg_addr, tx_id);
 	PMD_TX_LOG(DEBUG, "port_id=%u queue_id=%u tx_tail=%u nb_tx=%u",
 		txq->port_id, txq->queue_id, tx_id, nb_tx);
 	txq->tx_tail = tx_id;
@@ -1833,7 +1833,7 @@ int eth_igc_tx_descriptor_status(void *tx_queue, uint16_t offset)
 		desc -= txq->nb_tx_desc;
 
 	status = &txq->tx_ring[desc].wb.status;
-	if (*status & rte_cpu_to_le_32(IGC_TXD_STAT_DD))
+	if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD))
 		return RTE_ETH_TX_DESC_DONE;
 
 	return RTE_ETH_TX_DESC_FULL;
@@ -1887,16 +1887,16 @@ igc_reset_tx_queue(struct igc_tx_queue *txq)
 	/* Initialize ring entries */
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile union igc_adv_tx_desc *txd = &txq->tx_ring[i];
+		volatile union e1000_adv_tx_desc *txd = &txq->tx_ring[i];
 
-		txd->wb.status = IGC_TXD_STAT_DD;
+		txd->wb.status = E1000_TXD_STAT_DD;
 		txe[i].mbuf = NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
 
-	txq->txd_type = IGC_ADVTXD_DTYP_DATA;
+	txq->txd_type = E1000_ADVTXD_DTYP_DATA;
 	igc_reset_tx_queue_stat(txq);
 }
 
@@ -1935,7 +1935,7 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 {
 	const struct rte_memzone *tz;
 	struct igc_tx_queue *txq;
-	struct igc_hw *hw;
+	struct e1000_hw *hw;
 	uint32_t size;
 
 	if (nb_desc % IGC_TX_DESCRIPTOR_MULTIPLE != 0 ||
@@ -1980,7 +1980,7 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 * handle the maximum ring size is allocated in order to allow for
 	 * resizing in later calls to the queue setup function.
 	 */
-	size = sizeof(union igc_adv_tx_desc) * IGC_MAX_TXD;
+	size = sizeof(union e1000_adv_tx_desc) * IGC_MAX_TXD;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
 				      IGC_ALIGN, socket_id);
 	if (tz == NULL) {
@@ -1997,10 +1997,10 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->reg_idx = queue_idx;
 	txq->port_id = dev->data->port_id;
 
-	txq->tdt_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_TDT(txq->reg_idx));
+	txq->tdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_TDT(txq->reg_idx));
 	txq->tx_ring_phys_addr = tz->iova;
 
-	txq->tx_ring = (union igc_adv_tx_desc *)tz->addr;
+	txq->tx_ring = (union e1000_adv_tx_desc *)tz->addr;
 	/* Allocate software ring */
 	txq->sw_ring = rte_zmalloc("txq->sw_ring",
 				   sizeof(struct igc_tx_entry) * nb_desc,
@@ -2026,7 +2026,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 {
 	struct igc_tx_queue *txq = txqueue;
 	struct igc_tx_entry *sw_ring;
-	volatile union igc_adv_tx_desc *txr;
+	volatile union e1000_adv_tx_desc *txr;
 	uint16_t tx_first; /* First segment analyzed. */
 	uint16_t tx_id;    /* Current segment being processed. */
 	uint16_t tx_last;  /* Last segment in the current packet. */
@@ -2067,7 +2067,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 
 		if (sw_ring[tx_last].mbuf) {
 			if (!(txr[tx_last].wb.status &
-					rte_cpu_to_le_32(IGC_TXD_STAT_DD)))
+					rte_cpu_to_le_32(E1000_TXD_STAT_DD)))
 				break;
 
 			/* Get the start of the next packet. */
@@ -2139,7 +2139,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 void
 igc_tx_init(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint64_t offloads = dev->data->dev_conf.txmode.offloads;
 	uint32_t tctl;
 	uint32_t txdctl;
@@ -2151,17 +2151,17 @@ igc_tx_init(struct rte_eth_dev *dev)
 		struct igc_tx_queue *txq = dev->data->tx_queues[i];
 		uint64_t bus_addr = txq->tx_ring_phys_addr;
 
-		IGC_WRITE_REG(hw, IGC_TDLEN(txq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_TDLEN(txq->reg_idx),
 				txq->nb_tx_desc *
-				sizeof(union igc_adv_tx_desc));
-		IGC_WRITE_REG(hw, IGC_TDBAH(txq->reg_idx),
+				sizeof(union e1000_adv_tx_desc));
+		E1000_WRITE_REG(hw, E1000_TDBAH(txq->reg_idx),
 				(uint32_t)(bus_addr >> 32));
-		IGC_WRITE_REG(hw, IGC_TDBAL(txq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_TDBAL(txq->reg_idx),
 				(uint32_t)bus_addr);
 
 		/* Setup the HW Tx Head and Tail descriptor pointers. */
-		IGC_WRITE_REG(hw, IGC_TDT(txq->reg_idx), 0);
-		IGC_WRITE_REG(hw, IGC_TDH(txq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_TDT(txq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_TDH(txq->reg_idx), 0);
 
 		/* Setup Transmit threshold registers. */
 		txdctl = ((uint32_t)txq->pthresh << IGC_TXDCTL_PTHRESH_SHIFT) &
@@ -2170,8 +2170,8 @@ igc_tx_init(struct rte_eth_dev *dev)
 				IGC_TXDCTL_HTHRESH_MSK;
 		txdctl |= ((uint32_t)txq->wthresh << IGC_TXDCTL_WTHRESH_SHIFT) &
 				IGC_TXDCTL_WTHRESH_MSK;
-		txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
-		IGC_WRITE_REG(hw, IGC_TXDCTL(txq->reg_idx), txdctl);
+		txdctl |= E1000_TXDCTL_QUEUE_ENABLE;
+		E1000_WRITE_REG(hw, E1000_TXDCTL(txq->reg_idx), txdctl);
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	}
 
@@ -2185,16 +2185,16 @@ igc_tx_init(struct rte_eth_dev *dev)
 		}
 	}
 
-	igc_config_collision_dist(hw);
+	e1000_config_collision_dist(hw);
 
 	/* Program the Transmit Control Register. */
-	tctl = IGC_READ_REG(hw, IGC_TCTL);
-	tctl &= ~IGC_TCTL_CT;
-	tctl |= (IGC_TCTL_PSP | IGC_TCTL_RTLC | IGC_TCTL_EN |
-		 ((uint32_t)IGC_COLLISION_THRESHOLD << IGC_CT_SHIFT));
+	tctl = E1000_READ_REG(hw, E1000_TCTL);
+	tctl &= ~E1000_TCTL_CT;
+	tctl |= (E1000_TCTL_PSP | E1000_TCTL_RTLC | E1000_TCTL_EN |
+		 ((uint32_t)E1000_COLLISION_THRESHOLD << E1000_CT_SHIFT));
 
 	/* This write will effectively turn on the transmit unit. */
-	IGC_WRITE_REG(hw, IGC_TCTL, tctl);
+	E1000_WRITE_REG(hw, E1000_TCTL, tctl);
 }
 
 void
@@ -2237,7 +2237,7 @@ void
 eth_igc_vlan_strip_queue_set(struct rte_eth_dev *dev,
 			uint16_t rx_queue_id, int on)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_rx_queue *rxq = dev->data->rx_queues[rx_queue_id];
 	uint32_t reg_val;
 
@@ -2247,14 +2247,14 @@ eth_igc_vlan_strip_queue_set(struct rte_eth_dev *dev,
 		return;
 	}
 
-	reg_val = IGC_READ_REG(hw, IGC_DVMOLR(rx_queue_id));
+	reg_val = E1000_READ_REG(hw, E1000_DVMOLR(rx_queue_id));
 	if (on) {
-		reg_val |= IGC_DVMOLR_STRVLAN;
+		reg_val |= E1000_DVMOLR_STRVLAN;
 		rxq->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	} else {
-		reg_val &= ~(IGC_DVMOLR_STRVLAN | IGC_DVMOLR_HIDVLAN);
+		reg_val &= ~(E1000_DVMOLR_STRVLAN | E1000_DVMOLR_HIDVLAN);
 		rxq->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	}
 
-	IGC_WRITE_REG(hw, IGC_DVMOLR(rx_queue_id), reg_val);
+	E1000_WRITE_REG(hw, E1000_DVMOLR(rx_queue_id), reg_val);
 }
diff --git a/drivers/net/intel/igc/igc_txrx.h b/drivers/net/intel/e1000/igc_txrx.h
similarity index 97%
rename from drivers/net/intel/igc/igc_txrx.h
rename to drivers/net/intel/e1000/igc_txrx.h
index ad7d3b4ca5..1e63ddb5aa 100644
--- a/drivers/net/intel/igc/igc_txrx.h
+++ b/drivers/net/intel/e1000/igc_txrx.h
@@ -23,7 +23,7 @@ struct igc_rx_entry {
  */
 struct igc_rx_queue {
 	struct rte_mempool  *mb_pool;   /**< mbuf pool to populate RX ring. */
-	volatile union igc_adv_rx_desc *rx_ring;
+	volatile union e1000_adv_rx_desc *rx_ring;
 	/**< RX ring virtual address. */
 	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
 	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
@@ -107,7 +107,7 @@ struct igc_tx_entry {
  * Structure associated with each TX queue.
  */
 struct igc_tx_queue {
-	volatile union igc_adv_tx_desc *tx_ring; /**< TX ring address */
+	volatile union e1000_adv_tx_desc *tx_ring; /**< TX ring address */
 	uint64_t               tx_ring_phys_addr; /**< TX ring DMA address. */
 	struct igc_tx_entry    *sw_ring; /**< virtual address of SW ring. */
 	volatile uint32_t      *tdt_reg_addr; /**< Address of TDT register. */
@@ -156,7 +156,7 @@ int igc_rx_init(struct rte_eth_dev *dev);
 void igc_tx_init(struct rte_eth_dev *dev);
 void igc_rss_disable(struct rte_eth_dev *dev);
 void
-igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf);
+igc_hw_rss_hash_set(struct e1000_hw *hw, struct rte_eth_rss_conf *rss_conf);
 int igc_del_rss_filter(struct rte_eth_dev *dev);
 void igc_rss_conf_set(struct igc_rss_filter *out,
 		const struct rte_flow_action_rss *rss);
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index 296ec25f2c..620c877283 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -14,4 +14,15 @@ sources = files(
         'igb_rxtx.c',
 )
 
+# do not build IGC on Windows
+if not is_windows
+    sources += files(
+        'igc_ethdev.c',
+        'igc_logs.c',
+        'igc_filter.c',
+        'igc_flow.c',
+        'igc_txrx.c',
+    )
+endif
+
 includes += include_directories('base')
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 02a3f5a0b6..060b79c85c 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -31,7 +31,6 @@ drivers = [
         'intel/iavf',
         'intel/ice',
         'intel/idpf',
-        'intel/igc',
         'intel/ipn3ke',
         'intel/ixgbe',
         'ionic',
-- 
2.43.5

