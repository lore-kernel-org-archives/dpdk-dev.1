Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC60C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:33:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0675F40656;
	Mon, 26 May 2025 10:33:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id B95CE40615
 for <dev@dpdk.org>; Mon, 26 May 2025 10:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248433; x=1779784433;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zzaYh+RklezDIFAl4uTbLV3p0q7a+PpezaZCKqG0Pog=;
 b=Bc5yLNsn1L0C8rQHx4o1Kcbt4FSiXSo3wgnQhoTU/bCxcvJKKqziiLly
 mk7v+/MoWWimTw2ZvZs/OZVxCp7FVj2q8ZV30eOpXkdwCDtGvXVdZ4yHl
 gljajfePJSKmP9DxpCo9cJPRfwUjJ5kg4LN3ZwXHliaL2QNHiDXSdVyKs
 eIjEGHjzPlwtAbf36xHwF2O0KT6roEvmYncbYMAO/cRNMIwNrv5cuHOU6
 JiRofq+Q7FPHEobG2cSMLfbpvKAlm7XDyDCFRVCRgCyW/6RDqsR1WtB3N
 rRKsBlZoagaIBRWnicg4czmFJgIPUvWh9oWBr7sNyvrOVq3J0h8oei95N w==;
X-CSE-ConnectionGUID: le3E3ZWjR/+kZ0dkD9KktA==
X-CSE-MsgGUID: Twmr5cWYSheiqohqqXzW1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009000"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009000"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:33:52 -0700
X-CSE-ConnectionGUID: HVRIQlCdQtyKE7OmHfNKBA==
X-CSE-MsgGUID: XkGzpfScQFqwWJOeFcpV+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293421"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:33:51 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, "Dworakowski, Waldemar" <waldemar.dworakowski@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 1/9] net/ice/base: type conversion fix
Date: Mon, 26 May 2025 08:33:03 +0000
Message-ID: <20250526083325.248384-2-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

