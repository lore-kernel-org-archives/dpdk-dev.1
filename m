Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1889BCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 10:51:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 28A4E42D72;
	Wed,  7 Oct 2026 12:50:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id C0A8D427E4
 for <dev@dpdk.org>; Wed,  7 Oct 2026 12:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791370247; x=1822906247;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Ax/K7fhn64gfAvOTCki1zPI0D63FLo2g9OSBSRqQOdk=;
 b=OcWUS7IXIn0TVYZVpSI5dGR0rDlMt/Tcm/Qd5MnPytTpOb+fKEM2iVCS
 O6c8k7EABZjOiIsiGBdLnHCvJpjDpvJqXI1/xiBcBmq+Ej6Dsdl5IFpxe
 SIGux640+gxRQXP77LKlGowyRZ40OOjJISDO56yyLdeJCztYrQMc265aA
 eoq8gW+aYH2NmW+sNmmarKYfdS80Jj+u4Fi8OTgBPrbS85p/rnpRem2M8
 JZdN9V9MhYk3QP9dUw8r5NBeJHTNeeev2JCD/qz6gWMvewVILR+vndaXl
 vcmohVCGahrtUqsyItLUaT9ft/ZXzA5fHfVL0+hX9R3GKWlWhvHWJy1LQ Q==;
X-CSE-ConnectionGUID: +Kf+qYcfQ52Jc7M8y1lejA==
X-CSE-MsgGUID: 7vtdR/3KS6aSnZeKKMW39Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="121823"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="121823"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 03:50:46 -0700
X-CSE-ConnectionGUID: XwepanbMS92B8ZK+dLGamg==
X-CSE-MsgGUID: k+bk+WmxSlOHIZN+EIwZMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="280652115"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 07 Oct 2026 03:50:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Dai <wei.dai@picocom.com>,
 Beilei Xing <beilei.xing@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v5 11/25] net/ixgbe: fix ntuple filter priority
Date: Wed,  7 Oct 2026 11:50:06 +0100
Message-ID: <2de07b0cfdb7a7c1fd8326d7443181d11f8ab4f7.1791369981.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791369979.git.anatoly.burakov@intel.com>
 <cover.1791369979.git.anatoly.burakov@intel.com>
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

Currently, handling of ntuple filter priority is incorrect: it directly
translates values inside the valid range (001b-111b), and clamps all
invalid to 1. This leads to equivalence between rte_flow highest priority
value (0), and rte_flow lower priority values (8+), both of which are
mapped to 1 (lowest priority), while the 1-7 range is reversed (in ntuple,
111b is highest priority, but in rte_flow it is the lowest).

Fix the calculation by

- Translating highest rte_flow priority to highest ntuple priority
- Only clamping low priority values to 1 (lowest priority)
- Reversing the 1-7 mapping to preserve semantic meaning

Fixes: 672be56d76a2 ("net/ixgbe: parse n-tuple filter")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index 76eec33839b..547c6621d3e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -209,6 +209,7 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 	const struct rte_flow_item_vlan *vlan_mask;
 	struct rte_flow_item_eth eth_null;
 	struct rte_flow_item_vlan vlan_null;
+	uint16_t priority;
 
 	/* Priority must be 16-bit */
 	if (attr->priority > UINT16_MAX) {
@@ -503,9 +504,21 @@ cons_parse_ntuple_filter(const struct rte_flow_attr *attr,
 
 	filter->queue = q_act->index;
 
-	filter->priority = (uint16_t)attr->priority;
-	if (attr->priority < IXGBE_MIN_N_TUPLE_PRIO || attr->priority > IXGBE_MAX_N_TUPLE_PRIO)
-		filter->priority = 1;
+	/*
+	 * rte_flow priority: 0 through UINT32_MAX, 0 is highest
+	 *
+	 * ntuple priority: 001b through 111b, 111b is highest
+	 *
+	 * which means we need to transform priority from rte_flow to ntuple:
+	 *
+	 * 1) clamp max value
+	 * 2) reverse
+	 * 3) add min value
+	 */
+	priority = RTE_MIN(IXGBE_MAX_N_TUPLE_PRIO - 1, (uint16_t)attr->priority);
+	priority = IXGBE_MAX_N_TUPLE_PRIO - 1 - priority;
+	priority += IXGBE_MIN_N_TUPLE_PRIO;
+	filter->priority = priority;
 
 	return 0;
 }
-- 
2.52.0

