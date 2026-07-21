Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E6BC44532
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3EA440695;
	Tue, 21 Jul 2026 15:08:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8E65440294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 15:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784639311; x=1816175311;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MgpR5J6iSTNvcWGwSHUEJYHnJS02MXPG/fp7ptyjhGQ=;
 b=JrOHDRtCJlKhPIQzK/rZBxI1/0EHxTxFGM3Bxgzb8QhoBbwmIJdQbyZp
 Pwx9T/EP/+Emk+SsA3spqg0Mn7vL6IisYUYVWTEnNPfsnSALH5qKZ4hHO
 vSALt7gobI+2Ev5+0lyKiL1hE9SCKf7fRAK9lcG1v/ywO6t/W1BtZ+soI
 rRkwa7o0gJ+bv85C0jScGUOImTEMP9ALqQR2Wc/KcduUnoy9Et76C7L5w
 7VVzDdz7lX5aiZMebQwcUJY4jxXNZzQUu5j4Q05wgkjxeu4IcHKrOAxkk
 sEHRJwH5jMIAAuxgddR8oQqj8pIMF83cT1N64SNFbkR54uB7O5PNj6QPo g==;
X-CSE-ConnectionGUID: xm5PEMczSwq4bo2PAm432A==
X-CSE-MsgGUID: uyYIfA94Szu4hmohcRkELQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="108027791"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="108027791"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:08:31 -0700
X-CSE-ConnectionGUID: smxkFSSVSdiSf6qflySXWA==
X-CSE-MsgGUID: ZaGQ0OkoRe+n5FCbS732/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="254360086"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 21 Jul 2026 06:08:29 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 2/2] net/iavf: restore promiscuous mode only after VF reset
Date: Tue, 21 Jul 2026 13:08:14 +0000
Message-ID: <20260721130814.2950332-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721130814.2950332-1-ciara.loftus@intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
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

The promiscuous and all-multicast settings persist in hardware across
a port stop/start and are only cleared by a VF reset. Despite this,
the ethdev start path re-applied them on every `dev_start` through the
config restore logic. Together with the driver's own restore after a
reset, a reset followed by a start reprogrammed them twice and issued
redundant requests to the PF.

Implement the `get_restore_flags` callback to clear
`RTE_ETH_RESTORE_PROMISC` and `RTE_ETH_RESTORE_ALLMULTI` so ethdev
skips them on start; the driver restores them only after a VF reset.
A queue reconfiguration in `iavf_dev_configure` also triggers a reset,
so the states are re-applied there too, except during reset recovery
where the reset handler already restores them once.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 34 ++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 829573983a..183d986831 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -163,6 +163,9 @@ static int iavf_set_mc_addr_list(struct rte_eth_dev *dev,
 			struct rte_ether_addr *mc_addrs,
 			uint32_t mc_addrs_num);
 static int iavf_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *arg);
+static uint64_t iavf_get_restore_flags(struct rte_eth_dev *dev,
+				       enum rte_eth_dev_operation op);
+static int iavf_post_reset_reconfig(struct rte_eth_dev *dev);
 
 static const struct rte_pci_id pci_id_iavf_map[] = {
 	{ RTE_PCI_DEVICE(IAVF_INTEL_VENDOR_ID, IAVF_DEV_ID_ADAPTIVE_VF) },
@@ -262,6 +265,7 @@ static const struct eth_dev_ops iavf_eth_dev_ops = {
 	.tx_done_cleanup	    = iavf_dev_tx_done_cleanup,
 	.get_monitor_addr           = iavf_get_monitor_addr,
 	.tm_ops_get                 = iavf_tm_ops_get,
+	.get_restore_flags          = iavf_get_restore_flags,
 };
 
 static int
@@ -282,6 +286,19 @@ iavf_tm_ops_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+static uint64_t
+iavf_get_restore_flags(__rte_unused struct rte_eth_dev *dev,
+		       __rte_unused enum rte_eth_dev_operation op)
+{
+	/*
+	 * The unicast and multicast promiscuous settings persist across a
+	 * stop/start; they are only cleared by a VF reset, which the driver
+	 * restores itself. So ethdev does not need to restore them on start.
+	 */
+	return RTE_ETH_RESTORE_ALL & ~(RTE_ETH_RESTORE_PROMISC |
+				       RTE_ETH_RESTORE_ALLMULTI);
+}
+
 __rte_unused
 static int
 iavf_vfr_inprogress(struct iavf_hw *hw)
@@ -673,6 +690,7 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 	struct iavf_info *vf =  IAVF_DEV_PRIVATE_TO_VF(ad);
 	uint16_t num_queue_pairs = RTE_MAX(dev->data->nb_rx_queues,
 		dev->data->nb_tx_queues);
+	bool reset_done = false;
 	int ret;
 
 	if (ad->closed)
@@ -702,6 +720,7 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 		ret = iavf_queues_req_reset(dev, num_queue_pairs);
 		if (ret)
 			return ret;
+		reset_done = true;
 
 		ret = iavf_get_max_rss_queue_region(ad);
 		if (ret) {
@@ -720,6 +739,7 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 			ret = iavf_queues_req_reset(dev, num_queue_pairs);
 			if (ret)
 				return ret;
+			reset_done = true;
 
 			vf->lv_enabled = false;
 		}
@@ -735,6 +755,20 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 			return -1;
 		}
 	}
+
+	/*
+	 * A queue reconfiguration above triggers a VF reset, which clears the
+	 * promiscuous and all-multicast settings in hardware. Re-apply the
+	 * pre-reset states here, unless this configure is itself part of reset
+	 * recovery, in which case the reset handler restores them once at the
+	 * end (avoiding a double restore).
+	 */
+	if (reset_done && !vf->in_reset_recovery) {
+		ret = iavf_post_reset_reconfig(dev);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.43.0

