Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9DACCFA13
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0265140A7F;
	Thu, 30 Apr 2026 13:15:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 71B2940674
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547703; x=1809083703;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hKDH2323BiFDOaL5FcCS4RC1LNXnhVYxv0H/CPOJJRE=;
 b=OObU90kvIFmkYCKk2OGTlEmD/kz4YWcEARVCcCfgyyyf1Y//2bi4IR7s
 D/EaYDY9DM56i2da8bPYx79GN9pI2nY7EyiLKwCrZVQ7eiPD7W8t/B3GC
 0FJqb0ePuYae7DJVEqHONkiW3/mk0BJP9oiV+08cdI7Yp3Gr166dG6Jg9
 kf05dBayXDn9dunh5J9TQC7ua/6iuq8mSeu5/aRspknIZdwJyC0xhxhgb
 vWvzA0XUmww4LRhFT6VGUE81o+sbPDlD/nvhJEYsuofa4gDJCojj6mfiM
 EDyEBQw5o/xH5O4/TVY6ND7epjPaal7qmk8XSaoBfrXz/dD/E4m0y2+D6 A==;
X-CSE-ConnectionGUID: XrMFriL6Sc6U6geQW28nXg==
X-CSE-MsgGUID: 3v5OyUS/StClAteAnPqpBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482277"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482277"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:03 -0700
X-CSE-ConnectionGUID: hFMvT5XnQ0mI2i7vT52xdw==
X-CSE-MsgGUID: 31CO6RhNQuOV0dG/LuCWHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444759"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 08/15] net/ixgbe: do not use flow list to count flows
Date: Thu, 30 Apr 2026 12:14:37 +0100
Message-ID: <57737980689706695c04d3fd0492b2403633eb52.1777547413.git.anatoly.burakov@intel.com>
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

Currently, FDIR code will use emptiness of its flow list as an indicator
that there are no flows (and that we can install a mask). That usage is the
only thing preventing us from getting rid of the FDIR flow list
altogether, so introduce a new mechanism for flow count tracking.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 1 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.h | 1 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c   | 8 +++++---
 drivers/net/intel/ixgbe/ixgbe_flow.c   | 3 ++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 1c4a2e1177..ee1b499b49 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -1465,6 +1465,7 @@ static int ixgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 		rte_hash_free(fdir_info->hash_handle);
 		return -ENOMEM;
 	}
+	fdir_info->n_flows = 0;
 	fdir_info->mask_added = FALSE;
 
 	return 0;
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 2fb6d55387..6147cd6bdf 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -199,6 +199,7 @@ struct ixgbe_hw_fdir_info {
 	struct ixgbe_fdir_filter **hash_map;
 	struct rte_hash *hash_handle; /* cuckoo hash handler */
 	bool mask_added; /* If already got mask from consistent filter */
+	uint32_t    n_flows;
 };
 
 struct ixgbe_rte_flow_rss_conf {
diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index f51582a4bf..5f7159abf2 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -1362,20 +1362,22 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *fdir_filter;
-	struct ixgbe_fdir_filter *filter_flag;
+	bool had_flows;
 	int ret = 0;
 
+	had_flows = (fdir_info->n_flows != 0);
+
 	/* flush flow director */
 	rte_hash_reset(fdir_info->hash_handle);
 	memset(fdir_info->hash_map, 0,
 	       sizeof(struct ixgbe_fdir_filter *) * IXGBE_MAX_FDIR_FILTER_NUM);
-	filter_flag = TAILQ_FIRST(&fdir_info->fdir_list);
 	while ((fdir_filter = TAILQ_FIRST(&fdir_info->fdir_list))) {
 		TAILQ_REMOVE(&fdir_info->fdir_list,
 			     fdir_filter,
 			     entries);
 		rte_free(fdir_filter);
 	}
+	fdir_info->n_flows = 0;
 
 	/* reset internal FDIR state */
 	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
@@ -1383,7 +1385,7 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 	fdir_info->mask_added = FALSE;
 	fdir_conf->mode = RTE_FDIR_MODE_NONE;
 
-	if (filter_flag != NULL)
+	if (had_flows)
 		ret = ixgbe_fdir_flush(dev);
 
 	return ret;
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index e641a9d405..b68934e911 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3241,6 +3241,7 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 					&fdir_rule_ptr->base, entries);
 				flow->rule = fdir_rule_ptr;
 				flow->filter_type = RTE_ETH_FILTER_FDIR;
+				fdir_info->n_flows++;
 
 				return flow;
 			}
@@ -3477,7 +3478,7 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			TAILQ_REMOVE(&flow_lists->fdir_list,
 				&fdir_rule_ptr->base, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&flow_lists->fdir_list)) {
+			if (fdir_info->n_flows > 0 && --(fdir_info->n_flows) == 0) {
 				fdir_info->mask_added = false;
 				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
 				fdir_info->flex_bytes_offset = 0;
-- 
2.47.3

