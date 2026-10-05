Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF93CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:40:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA7D640E30;
	Mon,  5 Oct 2026 18:38:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 675F640B9D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218329; x=1822754329;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5zjxQG17D+oR7lnkYAQSAwgK6dUAkkyygu24VSC7QQA=;
 b=eWHXOq+N5XJiZL65jidCn7xez8OIvl/AefgW8+eKmM+WKtFr+wo2npe0
 eMtmPk8uCDbUH0Pd6tc9XB25ZI3niho7XTj+wby+BQvz6/u6KZls2kptj
 B4b1tQ6HzHgZTJMy971xm9Qjy46KuyjkCpofYO0GV6i3vxUi0AotP1VPS
 EMir60nir11PEr63K2E+yr6peoZaqcRw+rqVzJJ/xZo6cIBms7CNZomlN
 iwzZGu/yIcPyqFKLbtZf8uj99eOqVr7vnf+j+Vwuc0XSl1b3HW71pMxNb
 /xNoGCeYmkloK/DZ737ONTuczIohVj+V1tetz3sZ2Ym80bMAk7muZkf6j w==;
X-CSE-ConnectionGUID: eGuwo1TnTgWSlYdRWYEQlA==
X-CSE-MsgGUID: /ZLJn/U3QBqX8NnsBzffdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665314"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665314"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:38:49 -0700
X-CSE-ConnectionGUID: JUW/DEyPTKypyYwPogogyw==
X-CSE-MsgGUID: sbTa/3l7RG6zOku927igNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945746"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:38:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wei Zhao <wei.zhao1@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>, Wei Dai <wei.dai@picocom.com>
Subject: [PATCH v4 11/24] net/ixgbe: fix ntuple filter priority
Date: Mon,  5 Oct 2026 17:38:06 +0100
Message-ID: <6044d52cf0c3d823761aa4ddc38e937102891b9b.1791218156.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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
index c9c13a93fd7..ac7c164ba35 100644
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

