Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F843EB7EB8
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 11:16:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF22C4066C;
	Wed,  4 Mar 2026 12:16:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A249B4003C;
 Wed,  4 Mar 2026 12:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772622999; x=1804158999;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ojdk+BthBxB6PPbRobadIrD9ljabZRc8xDB3LmLZ7KE=;
 b=jcB9nJcQtz1Ee6qgggDvlSkYshqw7l1wCn3kntJP7DLGcGHx6h0j7UQM
 weOzyrYOTbUN5gUZBuDNDmn/xmFH5n2Ymr1mOjvpTLOksKdWUn1/kCunQ
 Gr66YQ7XjFh0etFihYQpcT8eVGSbh9IOnUJ2D8tnz7yuwO4OjEjfWP31R
 ZTjNjyfpYDyJvXy+/VT2pwK49AyLfO9F6XPpaNgtNbfRYaz9pUh535upw
 o0Nv4rc3RZaCMxnNqP3GfOWKy5aE8vTQ1hfNUxwUNd3n1gqXhArjhkduF
 5/6c+qgiCJnBylvqtltaw2BeNtnnBsuqZiayikBTXWt5rRx7fR6BwePMz g==;
X-CSE-ConnectionGUID: g6vaydL9Sw+9r5VQNrzuAA==
X-CSE-MsgGUID: jnhDdFIgTfi/QcmCFgtNdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="73587943"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="73587943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 03:16:38 -0800
X-CSE-ConnectionGUID: SntvednkSUifpDfnPNnMQg==
X-CSE-MsgGUID: H4YyqEOeQZeXwTRxDo3ipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; d="scan'208";a="222808408"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 03:16:36 -0800
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, vladimir.medvedkin@intel.com,
 albe19021990@gmail.com, Anurag Mandal <anurag.mandal@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/iavf: fix old primary MAC deletion
Date: Wed,  4 Mar 2026 11:16:06 +0000
Message-Id: <20260304111606.283035-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Old Primary MAC removal operation fails while trying to set the
default MAC address on a VF via rte_eth_dev_default_mac_addr_set()
when VF is yet to be started post initialization.
This happens due to non-assignment of the old MAC as
VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF as it did not
invoke iavf_dev_start() yet to do the same post initialization.
Logs indicate old primary MAC removal failure even though
rte_eth_dev_default_mac_addr_set() returns success causing ambiguity.

This patch fixes the issue by introducing the flag "mac_primary_set"
in the iavf_adapter & is set to 'false' upon VF initialization.
It is set to 'true' when any MAC address gets assigned as
VIRTCHNL_ETHER_ADDR_PRIMARY MAC on the VF. This flags gets enabled
only once for a VF.

Bugzilla ID: 1897
Fixes: b335e7203475 ("net/iavf: fix lack of MAC type when set MAC address")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 33ba3115d0..f7f3522d6b 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -383,6 +383,7 @@ struct iavf_adapter {
 	enum iavf_tx_func_type tx_func_type;
 	uint16_t fdir_ref_cnt;
 	struct iavf_devargs devargs;
+	bool mac_primary_set;
 };
 
 /* IAVF_DEV_PRIVATE_TO */
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index c1160c8967..7da92bd31e 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1042,6 +1042,9 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	/* Set all mac addrs */
 	iavf_add_del_all_mac_addr(adapter, true);
 
+	if (!adapter->mac_primary_set)
+		adapter->mac_primary_set = true;
+
 	/* Set all multicast addresses */
 	iavf_add_del_mc_addr_list(adapter, vf->mc_addrs, vf->mc_addrs_num,
 				  true);
@@ -1718,11 +1721,13 @@ iavf_dev_set_default_mac_addr(struct rte_eth_dev *dev,
 	if (rte_is_same_ether_addr(old_addr, mac_addr))
 		return 0;
 
-	ret = iavf_add_del_eth_addr(adapter, old_addr, false, VIRTCHNL_ETHER_ADDR_PRIMARY);
-	if (ret)
-		PMD_DRV_LOG(ERR, "Fail to delete old MAC:"
-			    RTE_ETHER_ADDR_PRT_FMT,
-				RTE_ETHER_ADDR_BYTES(old_addr));
+	if (adapter->mac_primary_set) {  /* delete old PRIMARY MAC only if set */
+		ret = iavf_add_del_eth_addr(adapter, old_addr, false, VIRTCHNL_ETHER_ADDR_PRIMARY);
+		if (ret)
+			PMD_DRV_LOG(ERR, "Fail to delete old MAC:"
+				    RTE_ETHER_ADDR_PRT_FMT,
+					RTE_ETHER_ADDR_BYTES(old_addr));
+	}
 
 	ret = iavf_add_del_eth_addr(adapter, mac_addr, true, VIRTCHNL_ETHER_ADDR_PRIMARY);
 	if (ret)
@@ -1733,6 +1738,9 @@ iavf_dev_set_default_mac_addr(struct rte_eth_dev *dev,
 	if (ret)
 		return -EIO;
 
+	if (!adapter->mac_primary_set)
+		adapter->mac_primary_set = true;
+
 	rte_ether_addr_copy(mac_addr, (struct rte_ether_addr *)hw->mac.addr);
 	return 0;
 }
@@ -2789,6 +2797,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	hw->back = IAVF_DEV_PRIVATE_TO_ADAPTER(eth_dev->data->dev_private);
 	adapter->dev_data = eth_dev->data;
 	adapter->stopped = 1;
+	adapter->mac_primary_set = false;
 
 	if (iavf_dev_event_handler_init())
 		goto init_vf_err;
-- 
2.34.1

