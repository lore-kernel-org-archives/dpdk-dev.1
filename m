Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8893CD41168
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 10:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 192BE40E32;
	Thu, 15 Jan 2026 11:38:46 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 872494003C;
 Thu, 15 Jan 2026 11:38:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768473524; x=1800009524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eBmHzyWg5fJEfJUP+Fm8WTF8VUFnZkiEvuj6oICjW1w=;
 b=g8kyA9Io17v+sESVJhwBjOXJK2LFareBSbX3Iz4F5f9QHl66va5hFV7L
 CAO5MrstyRFX4Ip13J9zWWfec0l17rgk3Q2PrUM9/k1dgOwb+fYsK/4Wf
 WrqB62p/VvMHPmQiUO71dNR3aO8WiWDpwAp9U9daT234UZaT4cfcfkfw6
 HML0UdMc/Garx0G2hJVF+Zwyr7tOYbMEXIVqex6Mdn0yOwv1gPtu40pgx
 0Fo6X0BbNdvzFlOZ8+yASCZ07nDAKBsMtoSfMejuakZMOGHv5qWpCxb7V
 Sq3FJSV59N5/ALUhHLeOqWVvCB2elfUFI4+ve7yuL506gIvsh9izkp/Ge w==;
X-CSE-ConnectionGUID: dSpnMWsSQzSvOq6W7bYdaA==
X-CSE-MsgGUID: we+AgyuKRsCqp2wkiX8dmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87187957"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="87187957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2026 02:38:43 -0800
X-CSE-ConnectionGUID: JibWW0OFQLeA+C2XIs9nWw==
X-CSE-MsgGUID: TDElvtCeQ9+Uv1uQ+4HQxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; d="scan'208";a="205204788"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by fmviesa008.fm.intel.com with ESMTP; 15 Jan 2026 02:38:42 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/3] net/ice: check for null before dereferencing
Date: Thu, 15 Jan 2026 10:38:21 +0000
Message-ID: <20260115103824.1982220-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115103824.1982220-1-ciara.loftus@intel.com>
References: <20260115103824.1982220-1-ciara.loftus@intel.com>
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

When commiting a new Tx scheduler hierarchy we assume the user has
created a root node. However if they have not, it leads to an invalid
memory access. While this would be an invalid configuration by the user
we should still prevent the invalid memory access from happening. Do so
by ensuring the root node is non null before dereferencing.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index f2d8e12181..db895613cc 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -816,8 +816,13 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 	uint16_t nodes_created_per_level[ICE_TM_MAX_LAYERS] = {0};
 	uint8_t q_lvl = ice_get_leaf_level(pf);
 	uint8_t qg_lvl = q_lvl - 1;
-
 	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
+
+	if (sw_root == NULL) {
+		PMD_DRV_LOG(ERR, "No root node defined in TM hierarchy");
+		return -1;
+	}
+
 	/* handle case where VSI node needs to move DOWN the hierarchy */
 	while (new_vsi_root->tx_sched_layer < new_root_level) {
 		if (new_vsi_root->num_children == 0)
-- 
2.43.0

