Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFC2C8303C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 09:09:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1380E40156;
	Fri, 11 Jul 2025 11:09:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 82B8B400D6;
 Fri, 11 Jul 2025 11:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752224973; x=1783760973;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vPe5eHSLEG0BFhNpUepxuVNc4Q0m+TwLDpj9OXaJzpg=;
 b=Pn+52IDSTdlL4JPH5N0Z4fRX0uTbvjEnQAXjsLx2oF31Kf8cNo1YAnGg
 stW19+wBDWvvQdWP46Ur1g1BJb6f1n4gHD8sn7DHDhqTfZgaJuC5ePuDD
 XoGU9jm9hj8QUtXAlMp55XahMmHu+1pO+sRRr63BNfCBfv6gjBxktkqxT
 8PH0D49s0RKDJ3SF8jnIyJOMso1K1MLdJGQ3YIOywRmn8rqagsqeyIq2H
 lFwQIjFs8mMg38P76VB5iYd2JGUrtlgo7M/Z+E57XUB7nMCmSlqIfBSgZ
 XVaTFxdSVSO5S+RReFx8unYXuSsmE/fN6+/e0heEXU+CusXvsAMEaCnjc A==;
X-CSE-ConnectionGUID: 7C6fGIzXRDiyDuQfm8xbRg==
X-CSE-MsgGUID: fGGSuFOSTSynt1HHtZOMvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="72100818"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="72100818"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 02:09:27 -0700
X-CSE-ConnectionGUID: KHNKqFfhQJq6jcs/BonhOg==
X-CSE-MsgGUID: Fj+SR3GnS/OHnd6Yq7b7Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="187325754"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.210])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 02:09:24 -0700
From: Yuan Wang <yuanx.wang@intel.com>
To: anatoly.burakov@intel.com,
	vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	Yuan Wang <yuanx.wang@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ixgbe: fix L4 protocol mask condition
Date: Fri, 11 Jul 2025 17:04:03 +0800
Message-ID: <20250711090403.204852-1-yuanx.wang@intel.com>
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

Currently, we initialize the rule mask to all 1 and mask L4 protocol
if port mask is 0. However, this causes some hardware programming issues.

1. raw IPv4 rule incorrectly sets the L4P bit to 0 because it doesn't
   change port mask.
2. on 82599, SCTP rule incorrectly programe the TCP/UDP/SCTP mask
   register to 0 because it doesn't change the mask either.
3. SCTP rule on 82599 incorrectly configure the L4P bit to 1
   if rule mask is initialized to 0.

This patch fixes these issues by changing mask default to 0
and using the flow type as the L4P setting condition.

Fixes: 11777435c727 ("net/ixgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Yuan Wang <yuanx.wang@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 1 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 3 ++-
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 9 ++++-----
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 4f0343245e..88c3cb2534 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1470,6 +1470,7 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 		return -ENOMEM;
 	}
 	fdir_info->mask_added = FALSE;
+	fdir_info->flow_type = 0;
 
 	return 0;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 86da9fc89b..13b77cec58 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -212,6 +212,7 @@ struct ixgbe_hw_fdir_info {
 	struct ixgbe_fdir_filter **hash_map;
 	struct rte_hash *hash_handle; /* cuckoo hash handler */
 	bool mask_added; /* If already got mask from consistent filter */
+	enum ixgbe_atr_flow_type flow_type;
 };
 
 struct ixgbe_rte_flow_rss_conf {
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index b6351bc2cf..a686bd4ca5 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -273,7 +273,7 @@ fdir_set_input_mask_82599(struct rte_eth_dev *dev)
 	 * a VLAN of 0 is unspecified, so mask that out as well.  L4type
 	 * cannot be masked out in this implementation.
 	 */
-	if (info->mask.dst_port_mask == 0 && info->mask.src_port_mask == 0)
+	if ((info->flow_type & IXGBE_ATR_L4TYPE_MASK) == 0)
 		/* use the L4 protocol mask for raw IPv4/IPv6 traffic */
 		fdirm |= IXGBE_FDIRM_L4P;
 
@@ -1271,6 +1271,7 @@ ixgbe_fdir_flush(struct rte_eth_dev *dev)
 	info->f_remove = 0;
 	info->add = 0;
 	info->remove = 0;
+	info->flow_type = 0;
 
 	return ret;
 }
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6278646720..c0374be977 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -1641,11 +1641,6 @@ ixgbe_parse_fdir_filter_normal(struct rte_eth_dev *dev,
 	 * value. So, we need not do anything for the not provided fields later.
 	 */
 	memset(rule, 0, sizeof(struct ixgbe_fdir_rule));
-	memset(&rule->mask, 0xFF, sizeof(struct ixgbe_hw_fdir_mask));
-	rule->mask.vlan_tci_mask = 0;
-	rule->mask.flex_bytes_mask = 0;
-	rule->mask.dst_port_mask = 0;
-	rule->mask.src_port_mask = 0;
 
 	/**
 	 * The first not void item should be
@@ -2759,6 +2754,8 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 {
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct ixgbe_hw_fdir_info *fdir_info =
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	fdir_conf->drop_queue = IXGBE_FDIR_DROP_QUEUE;
 
@@ -2804,6 +2801,8 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 	if (rule->queue >= dev->data->nb_rx_queues)
 		return -ENOTSUP;
 
+	fdir_info->flow_type = rule->ixgbe_fdir.formatted.flow_type;
+
 	return ret;
 }
 
-- 
2.24.0

