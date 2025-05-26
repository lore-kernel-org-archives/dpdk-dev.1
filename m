Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A28C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:03:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3484340663;
	Mon, 26 May 2025 20:03:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 9A3A94066A
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282610; x=1779818610;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gh3+2SRE8v0zV1T1XmwaXebmlHL7MLrIvnzDgGhTYdo=;
 b=a6Q1gllujrkbtrg4BzWHkiKTuSjJPmCPaP+o82CmhhuWXblAtNnlpVmC
 wojKZqTNAjkFTAOIJPiMg3SYGdsS23caOu3mtX1u8dNufPmR6Ywra/djB
 RQFPSuhPgFqlnzL5DB/m2OzPbRbXjlvh2cMtmFeoRw/DfeKylygJ08B09
 aWd+5+d4PElCZ1MyHgH88grZXkOXPokrTNH9pdjdyo2EAW5xTD0vJEoO4
 CQz4w6bwHwzbHEx1fJLLhpZX3VWJ8CoSbnhCsHIX5CXyQvXCyoNCMCjAW
 PXa224L4QQFFXfmcswuDOjSVH4O6wVJaj9MH2z9nMT1cSbVno0l2R+EHL A==;
X-CSE-ConnectionGUID: Ggd0/bFiTg+vYItYxAy2vQ==
X-CSE-MsgGUID: sHg2lJhZRkKgFyIFjoK4vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375157"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375157"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:29 -0700
X-CSE-ConnectionGUID: ScuteQOiSQKDnEfYjpRjPQ==
X-CSE-MsgGUID: Ga39j9RTSQaU5ntCJWqQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478296"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:28 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, "Dworakowski, Waldemar" <waldemar.dworakowski@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 01/10] net/ice/base: type conversion fix
Date: Mon, 26 May 2025 18:02:49 +0000
Message-ID: <20250526180311.4573-2-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

From: "Dworakowski, Waldemar" <waldemar.dworakowski@intel.com>

In ice_sched_move_vsi_to_agg() int16 is used to pass 8 bit value
what causes compiler warning:
warning C4244: 'function' : conversion from 'UINT16' to 'UINT8',
possible loss of data
Changed variable type to avoid conversion

Signed-off-by: Waldemar Dworakowski <waldemar.dworakowski@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_sched.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_sched.c b/drivers/net/intel/ice/base/ice_sched.c
index 1f520bb7c0..a8a149f541 100644
--- a/drivers/net/intel/ice/base/ice_sched.c
+++ b/drivers/net/intel/ice/base/ice_sched.c
@@ -2383,7 +2383,8 @@ ice_sched_move_vsi_to_agg(struct ice_port_info *pi, u16 vsi_handle, u32 agg_id,
 	u16 num_nodes_added;
 	u8 aggl, vsil;
 	int status;
-	u16 i;
+	u16 j;
+	u8 i;
 
 	tc_node = ice_sched_get_tc_node(pi, tc);
 	if (!tc_node)
@@ -2409,9 +2410,9 @@ ice_sched_move_vsi_to_agg(struct ice_port_info *pi, u16 vsi_handle, u32 agg_id,
 		num_nodes[i] = 1;
 
 	/* Check if the aggregator subtree has any free node to add the VSI */
-	for (i = 0; i < agg_node->num_children; i++) {
+	for (j = 0; j < agg_node->num_children; j++) {
 		parent = ice_sched_get_free_vsi_parent(pi->hw,
-						       agg_node->children[i],
+						       agg_node->children[j],
 						       num_nodes);
 		if (parent)
 			goto move_nodes;
-- 
2.43.0

