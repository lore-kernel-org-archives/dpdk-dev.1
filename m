Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ABAC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 10:34:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E29040269;
	Tue,  6 May 2025 12:34:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 18E8B40150;
 Tue,  6 May 2025 12:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746527672; x=1778063672;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=XPYNQJmBDEYnrBkK2lUqk+sWi+XimzK+40sGveNVriE=;
 b=AYV5sssOMuri7ei7UK+TgZdfJufVj85F+gaduPg0BD5gicj8Lzf/kB35
 wDm/Drqy0pfHHAHBSH6eEIHMCZJG4O2PM8P0CNJn3zKFrMNw5xCj5kRzT
 jCe5DXCslKQsMxG0XIBlb0S1tMQbA7Epxo78nA9iM0dSEa3gbtX4w/ArC
 Ye2C/4HMqWyYNo8UYP6xyP4PpI3Rq/yuHKgqw+wiezWQS8wdF2L/m4uVb
 iizbuT035tNzNC6D7RaH3QFJnpzh1Ig6LjxMIRQk/+QTWwY8gU7uZZw8v
 96c7i74MTo6nAjgOF2vMT4yLChlRJZ8UT6Bg1JbukEQImQY0XUNXuvCHg A==;
X-CSE-ConnectionGUID: mZmxRm0CQbmsF5cCUoN/mA==
X-CSE-MsgGUID: /at/zoRPTY6/N4kihrBgkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47291169"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="47291169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 03:34:30 -0700
X-CSE-ConnectionGUID: xDduL5r/RSWuFffmgd0mcw==
X-CSE-MsgGUID: iJJJhfxyTYiUe9CTdvy3lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="136522893"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa008.jf.intel.com with ESMTP; 06 May 2025 03:34:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/ice: fix support for 3 scheduler levels
Date: Tue,  6 May 2025 11:34:14 +0100
Message-ID: <20250506103414.892849-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

When using only 3 scheduler levels, the VSI node needs to be a node
further down the scheduler hierarchy, rather than one up it as with all
other possible level settings (5-9). Take account of this possibility in
the code.

Fixes: 4ace7701eb44 ("net/ice: provide parameter to limit scheduler layers")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index ff3a6cd77f..f2d8e12181 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -818,6 +818,18 @@ commit_new_hierarchy(struct rte_eth_dev *dev)
 	uint8_t qg_lvl = q_lvl - 1;
 
 	struct ice_sched_node *new_vsi_root = hw->vsi_ctx[pf->main_vsi->idx]->sched.vsi_node[0];
+	/* handle case where VSI node needs to move DOWN the hierarchy */
+	while (new_vsi_root->tx_sched_layer < new_root_level) {
+		if (new_vsi_root->num_children == 0)
+			return -1;
+		/* remove all child nodes but the first */
+		while (new_vsi_root->num_children > 1)
+			free_sched_node_recursive(pi, new_vsi_root,
+					new_vsi_root->children[1],
+					new_vsi_root->vsi_handle);
+		new_vsi_root = new_vsi_root->children[0];
+	}
+	/* handle case where VSI node needs to move UP the hierarchy */
 	while (new_vsi_root->tx_sched_layer > new_root_level)
 		new_vsi_root = new_vsi_root->parent;
 
-- 
2.45.2

