Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72604C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 04:42:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96608402E0;
	Thu, 31 Jul 2025 06:42:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 659AF4025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 06:42:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753936936; x=1785472936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zyr00bc1UYapFqsU79QNSdkIrY0F17yZJcoaWelUcig=;
 b=f7erVaFPCaTQ030Yegf+2xAykGur8neWaYyIsrpZl59lgjDaF8+BOiZS
 gl95YcCa88B6TQ7o+Xz/tpNOEI0Lq35wDlz2N7x/P1ToZ8XW3VDtf2ha4
 Gt/q3MBbhzKuZ2NK26eIr/X9irGbTdvY9dAAuWVt6/cqbqWoINlVLkkHB
 UyMI8V+eUZfRCftncpwwGqdjbRyRiRfWfRKeC8PVzvpzp3E1YUK9p3eTL
 yNT5/jm1bBLqccJbvxIBlGPVcBOcQZ7p4tHLQAwobuZ/0jTAyhvZbsuz6
 egk1JGe/WP/ymdRQPhBmRsEB56VVJO0awQlV0UkVjYV6Vh5y1GR/BUnxY w==;
X-CSE-ConnectionGUID: eI31inhHRxOcMpSrpGQtMA==
X-CSE-MsgGUID: F5QBl+hXQHGA3xHWufmtyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="81702736"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="81702736"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 21:42:16 -0700
X-CSE-ConnectionGUID: TYfa9a8zRHehAHcFh3OY0Q==
X-CSE-MsgGUID: faaSPuVZRAidtoQU9K/USQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163614039"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jul 2025 21:42:14 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Jeff Shaw <jeffrey.b.shaw@intel.com>
Subject: [PATCH 1/2] net/ice: add flag for direction lookup to occur
Date: Thu, 31 Jul 2025 10:11:31 +0530
Message-Id: <20250731044132.110174-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250731044132.110174-1-shaiq.wani@intel.com>
References: <20250731044132.110174-1-shaiq.wani@intel.com>
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

The tx packets were dropped when creating drop any rule
for ingress direction only. Added a direction lookup flag
to fix the issue.

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c   | 8 ++++----
 drivers/net/intel/ice/ice_switch_filter.c | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 777fc88d01..9b2c4536e0 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -8273,10 +8273,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	 */
 	ice_get_compat_fv_bitmap(hw, rinfo, fv_bitmap);
 
-	status = ice_get_sw_fv_list(hw, lkup_exts, fv_bitmap, &rm->fv_list);
-	if (status)
-		goto err_unroll;
-
 	/* Create any special protocol/offset pairs, such as looking at tunnel
 	 * bits by extracting metadata
 	 */
@@ -8284,6 +8280,10 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (status)
 		goto err_free_lkup_exts;
 
+	status = ice_get_sw_fv_list(hw, lkup_exts, fv_bitmap, &rm->fv_list);
+	if (status)
+		goto err_unroll;
+
 	/* Group match words into recipes using preferred recipe grouping
 	 * criteria.
 	 */
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 28bc775a2c..358387ad8f 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -1594,6 +1594,7 @@ ice_switch_parse_dcf_action(struct ice_dcf_adapter *ad,
 			return -rte_errno;
 
 		case RTE_FLOW_ACTION_TYPE_DROP:
+			rule_info->add_dir_lkup = 1;
 			rule_info->sw_act.fltr_act = ICE_DROP_PACKET;
 			break;
 
@@ -1676,6 +1677,7 @@ ice_switch_parse_action(struct ice_pf *pf,
 			break;
 
 		case RTE_FLOW_ACTION_TYPE_DROP:
+			rule_info->add_dir_lkup = 1;
 			rule_info->sw_act.fltr_act =
 				ICE_DROP_PACKET;
 			break;
-- 
2.34.1

