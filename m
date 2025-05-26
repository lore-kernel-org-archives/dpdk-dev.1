Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7EDC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A99C940673;
	Mon, 26 May 2025 10:34:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id CA17A40670
 for <dev@dpdk.org>; Mon, 26 May 2025 10:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248443; x=1779784443;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zfXUa8VLU+iCrAIqpjmanz7rr5J4m1fVs30Fk2wE+PI=;
 b=lAPdY6RHWqtFa72VQ2q3QZOAQqgAz5Ht7kiYTna+7Tihvh91wKxlfbnu
 LBdZKjH4KHkNicY1HHoXQSX9rhy6OkIR8B2UbNAHlWGBGnndZj1JZBhGk
 aZ4sPgdxfQeqbUnGeKCT5xoi3uDZ3PhpHb6JEbTeJPFwx6iHBc1KbGc71
 qoOAz+st6qHgNa9zzG74DVRcgA8RviY2/nvwm7MB0TQ3LpJ9dsNDyBGaB
 YigyYzGyeXERd5lGohx+CM5/QYTo1eVihPh1xE9RkGgaqvCgRwc3yPj7f
 08HbMSz8QHbmYzXDEQvlyzUI95gZOC7Sg7dwMoF7pPWhMlPKmndXacYZ8 Q==;
X-CSE-ConnectionGUID: h8J1i/1HTHGo1It7nahP2w==
X-CSE-MsgGUID: VrV4GlF5ScOkPtgdEWicHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009025"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009025"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:34:02 -0700
X-CSE-ConnectionGUID: ameqMEjfQTiSfsdr4to7VA==
X-CSE-MsgGUID: fzFL/iGZQYaZrRFVf9+dhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293527"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:34:01 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Lukasz Krakowiak <lukaszx.krakowiak@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 4/9] net/ice/base: set speculative execution barrier
Date: Mon, 26 May 2025 08:33:06 +0000
Message-ID: <20250526083325.248384-5-dhanya.r.pillai@intel.com>
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

From: Lukasz Krakowiak <lukaszx.krakowiak@intel.com>

Fix Coverity issues related to SPECULATIVE_EXECUTION_DATA_LEAK.
This changes set speculative execution barrier to functions:

* ice_sched_add_vsi_child_nodes,
* ice_sched_add_vsi_support_nodes,
* ice_sched_move_vsi_to_agg,
* ice_prof_has_mask_idx,
* ice_alloc_prof_mask.

Also, Added memfence definations.

Coverity issue: 1207094, 1207095, 1207096, 1207099, 1207104
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_flex_pipe.c | 2 ++
 drivers/net/intel/ice/base/ice_osdep.h     | 6 ++++++
 drivers/net/intel/ice/base/ice_sched.c     | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_flex_pipe.c b/drivers/net/intel/ice/base/ice_flex_pipe.c
index 6dd5588f85..dc8c92e203 100644
--- a/drivers/net/intel/ice/base/ice_flex_pipe.c
+++ b/drivers/net/intel/ice/base/ice_flex_pipe.c
@@ -1280,6 +1280,7 @@ ice_prof_has_mask_idx(struct ice_hw *hw, enum ice_block blk, u8 prof, u16 idx,
 			if (hw->blk[blk].masks.masks[i].in_use &&
 			    hw->blk[blk].masks.masks[i].idx == idx) {
 				found = true;
+				ice_memfence_read();
 				if (hw->blk[blk].masks.masks[i].mask == mask)
 					match = true;
 				break;
@@ -1648,6 +1649,7 @@ ice_alloc_prof_mask(struct ice_hw *hw, enum ice_block blk, u16 idx, u16 mask,
 			/* if mask is in use and it exactly duplicates the
 			 * desired mask and index, then in can be reused
 			 */
+			ice_memfence_read();
 			if (hw->blk[blk].masks.masks[i].mask == mask &&
 			    hw->blk[blk].masks.masks[i].idx == idx) {
 				found_copy = true;
diff --git a/drivers/net/intel/ice/base/ice_osdep.h b/drivers/net/intel/ice/base/ice_osdep.h
index ad6cde9896..7588ad3dbc 100644
--- a/drivers/net/intel/ice/base/ice_osdep.h
+++ b/drivers/net/intel/ice/base/ice_osdep.h
@@ -203,6 +203,12 @@ struct __rte_packed_begin ice_virt_mem {
 #define ice_memset(a, b, c, d) memset((a), (b), (c))
 #define ice_memcpy(a, b, c, d) rte_memcpy((a), (b), (c))
 
+/* Memory fence barrier */
+#define ice_memfence_read()
+#define ice_memfence_read_write()
+#define ice_memfence_write()
+
+
 /* SW spinlock */
 struct ice_lock {
 	rte_spinlock_t spinlock;
diff --git a/drivers/net/intel/ice/base/ice_sched.c b/drivers/net/intel/ice/base/ice_sched.c
index a8a149f541..be9393a7d6 100644
--- a/drivers/net/intel/ice/base/ice_sched.c
+++ b/drivers/net/intel/ice/base/ice_sched.c
@@ -1748,6 +1748,7 @@ ice_sched_add_vsi_child_nodes(struct ice_port_info *pi, u16 vsi_handle,
 				node = node->sibling;
 			}
 		} else {
+			ice_memfence_read();
 			parent = parent->children[0];
 		}
 	}
@@ -1840,6 +1841,7 @@ ice_sched_add_vsi_support_nodes(struct ice_port_info *pi, u16 vsi_handle,
 		/* The newly added node can be a new parent for the next
 		 * layer nodes
 		 */
+		ice_memfence_read();
 		if (num_added)
 			parent = ice_sched_find_node_by_teid(tc_node,
 							     first_node_teid);
@@ -2431,6 +2433,7 @@ ice_sched_move_vsi_to_agg(struct ice_port_info *pi, u16 vsi_handle, u32 agg_id,
 		/* The newly added node can be a new parent for the next
 		 * layer nodes
 		 */
+		ice_memfence_read();
 		if (num_nodes_added)
 			parent = ice_sched_find_node_by_teid(tc_node,
 							     first_node_teid);
-- 
2.43.0

