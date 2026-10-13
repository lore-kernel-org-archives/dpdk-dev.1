Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB610CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 12:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D0340B8D;
	Tue, 13 Oct 2026 14:03:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E3C5D40A84
 for <dev@dpdk.org>; Tue, 13 Oct 2026 14:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791893029; x=1823429029;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Hi6/q1bDKPqndSW96jySaa7LrRsVNJQP9pgH8M0kCYQ=;
 b=iWBHEzQYtQQhlFnLajn4Fm3EWTvMav00cTZtEaxDe+WH7D1yL+1vYpZU
 IHauv4gvce/Ivi2JBbfQtymJlfMXM14+WqTY7yt27yeNZf/QsH308my8l
 cXahdM3QI1dSvb40/EzfPJL+8HlY4mhHk6nC9Irmwi3wsR9HW1yXRrtwJ
 R4Ij9hZC62l5vqD4xUQ+9LmF4H4fGR97GrbPivDFtMQg6zbN5lQE/7MWP
 Hy3mSpXlBzIdCsfQmwIPSBdE2aXGLhGvBdXOIvJszNgfvKkoPEu75NAxo
 XaZXJ/ijCWCn3ale2DnJhfpSZVvOB1nU9jyS5egoEzDSV/YrhG3QgqdE3 w==;
X-CSE-ConnectionGUID: Y1cuPVonTdCVWQg5bm4DLw==
X-CSE-MsgGUID: CH2RyjI+T4aSLJOPofAx+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="608379"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="608379"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 05:03:49 -0700
X-CSE-ConnectionGUID: HgiPIM1oQwajqS8InVIogA==
X-CSE-MsgGUID: ZUwvtDDCTaiKB0QOqFYR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2908605"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa013.fm.intel.com with ESMTP; 13 Oct 2026 05:03:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Wei Dai <wei.dai@picocom.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Beilei Xing <beilei.xing@intel.com>, Wei Zhao <wei.zhao1@intel.com>
Subject: [PATCH v7 11/25] net/ixgbe: fix ntuple filter priority
Date: Tue, 13 Oct 2026 13:03:09 +0100
Message-ID: <37504ed761da8222637ee7476fb7d1c78a7831a3.1791892576.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791892574.git.anatoly.burakov@intel.com>
 <cover.1791892574.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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

