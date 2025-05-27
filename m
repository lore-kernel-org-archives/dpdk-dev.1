Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FD9C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:17:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74B1C4067A;
	Tue, 27 May 2025 15:17:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id C01814027A;
 Tue, 27 May 2025 15:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351869; x=1779887869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bgT8RXnzDusNhq0Yhq44mejoHunl76jnckHJHCe7aCY=;
 b=QLvnjQp+tWVwWrV0K9+RRJF8PEQ8n72/tJWL1t9yXpQF4z99Zsj7RHkI
 wrrq5LjiOzu6bGcONaPqUlq9FJm0qbo0O/bkRGz4Y167IQEtCcHE938l/
 lTqtk9VB6NoHKRktLwWDPbO23wb9A3zVIjQKsvfyDH1x4/hhrj2DpMzx2
 zeD7S7kqaO7iVAKtLtWvYsztx8QVx6HmsdZ2n3Odd2qY6eXJ6rdcM9/bb
 7otuKsc5nV5KAnHhxJnewasbEegR7qP1kM9bQ984WqOWY2wivfjogaofq
 DSxxyzZVC80rBE3SgK5h3BdiCRCqmybMmE/GRsG6Bry4GSrOvgWnpGXBC g==;
X-CSE-ConnectionGUID: scp72cTcRminCMBCOuE0VQ==
X-CSE-MsgGUID: 1TRfUs6uQ9aSIPW+rJuJyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884823"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:48 -0700
X-CSE-ConnectionGUID: tRZSi2BfT3uWwCQCBlh7FA==
X-CSE-MsgGUID: yv5zzDOnSP+HKf8vLCEfbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150026"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:46 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 Wenzhuo Lu <wenzhuo.lu@intel.com>
Cc: dev@dpdk.org, Waldemar Dworakowski <waldemar.dworakowski@intel.com>,
 stable@dpdk.org, Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 01/10] net/ice/base: fix type conversion
Date: Tue, 27 May 2025 13:17:20 +0000
Message-ID: <20250527131741.7606-2-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

From: Waldemar Dworakowski <waldemar.dworakowski@intel.com>

In ice_sched_move_vsi_to_agg() int16 is used to pass 8 bit value
what causes compiler warning:
warning C4244: 'function' : conversion from 'UINT16' to 'UINT8',
possible loss of data
Changed variable type to avoid conversion

Fixes: 29a0c11489ef ("net/ice/base: clean code")
Cc: stable@dpdk.org
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

