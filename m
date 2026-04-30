Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992CFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:15:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC9840689;
	Thu, 30 Apr 2026 13:15:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1FBE9406BB
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547701; x=1809083701;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=V6qXlV2fRdn9U+aWaKgOpx2tj+T7Z101SLYVs4g4a9g=;
 b=IrM1Rvp73QLN8bTmxklrpYz+xDOs+8zkvlS9MI3iL87QV8NbPQkuVRvP
 wciN/SFnkjxCH+GQ1HbFF7yF5NAGWFZ9V4n6zwEAUqqy3OR0zjLc/H+8R
 GTkxGco25pzsRIJKRSTjw/+RH/+jWkFylHziWlQ1z91JPOMt911DNfW0o
 m9nGAg3mQD78AUprTtzAIqD/qgo2SjWI6hN+KO+bQ9YyWKj0JqXMjRpAQ
 oE9HHjnI5hABBFI1ce2VRdEl3wsijXuQaYcPOE+VrGhSe+0q3GUUevVdY
 zvUC6Vqv9bLaE3rPPRiIAnSFsi+qrG9Gms03Wn7jnPYyQNwecKj16P5eq g==;
X-CSE-ConnectionGUID: HNhAMy61TXuZHaZvZxXABg==
X-CSE-MsgGUID: oiDJ2PSkQaK9eOrnQn4g+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482272"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482272"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:01 -0700
X-CSE-ConnectionGUID: 0IPL6I6OQMely6xcIoMcBA==
X-CSE-MsgGUID: BxVqVT9IQL+6tKUmmDKxOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444742"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:14:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Dai <wei.dai@intel.com>, Beilei Xing <beilei.xing@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v1 06/15] net/ixgbe: reset flow state on clear paths
Date: Thu, 30 Apr 2026 12:14:35 +0100
Message-ID: <57f6080d8e2a88cb3a3e761173ff12c909432e4a.1777547413.git.anatoly.burakov@intel.com>
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

When all FDIR rules are removed (either through destroy or flush), the
driver does not fully reset its state. This can result in picking up stale
state in some circumstances.

Fix by clearing internal state when FDIR flow list is empty.

Fixes: 11777435c727 ("net/ixgbe: parse flow director filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_fdir.c | 7 +++++++
 drivers/net/intel/ixgbe/ixgbe_flow.c | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_fdir.c b/drivers/net/intel/ixgbe/ixgbe_fdir.c
index 38f589623e..f51582a4bf 100644
--- a/drivers/net/intel/ixgbe/ixgbe_fdir.c
+++ b/drivers/net/intel/ixgbe/ixgbe_fdir.c
@@ -1358,6 +1358,7 @@ ixgbe_fdir_filter_restore(struct rte_eth_dev *dev)
 int
 ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 {
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 	struct ixgbe_hw_fdir_info *fdir_info =
 		IXGBE_DEV_PRIVATE_TO_FDIR_INFO(dev->data->dev_private);
 	struct ixgbe_fdir_filter *fdir_filter;
@@ -1376,6 +1377,12 @@ ixgbe_clear_all_fdir_filter(struct rte_eth_dev *dev)
 		rte_free(fdir_filter);
 	}
 
+	/* reset internal FDIR state */
+	fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
+	fdir_info->flex_bytes_offset = 0;
+	fdir_info->mask_added = FALSE;
+	fdir_conf->mode = RTE_FDIR_MODE_NONE;
+
 	if (filter_flag != NULL)
 		ret = ixgbe_fdir_flush(dev);
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 6e87d373ad..b73037d4c3 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -3473,11 +3473,16 @@ ixgbe_flow_destroy(struct rte_eth_dev *dev,
 			sizeof(struct ixgbe_fdir_rule));
 		ret = ixgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
 		if (!ret) {
+			struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 			TAILQ_REMOVE(&flow_lists->fdir_list,
 				&fdir_rule_ptr->base, entries);
 			rte_free(fdir_rule_ptr);
-			if (TAILQ_EMPTY(&flow_lists->fdir_list))
+			if (TAILQ_EMPTY(&flow_lists->fdir_list)) {
 				fdir_info->mask_added = false;
+				fdir_info->mask = (struct ixgbe_hw_fdir_mask){0};
+				fdir_info->flex_bytes_offset = 0;
+				fdir_conf->mode = RTE_FDIR_MODE_NONE;
+			}
 		}
 		break;
 	case RTE_ETH_FILTER_L2_TUNNEL:
-- 
2.47.3

