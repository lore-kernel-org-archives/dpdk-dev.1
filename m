Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64A3CD343F
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 13:00:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B09584065B;
	Thu,  7 May 2026 15:00:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 1CDF640265;
 Thu,  7 May 2026 15:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778158808; x=1809694808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cKVaeYAM+Oy8B5zHGIGvjDV3ZTx+TKs3HQ87YbU+fUY=;
 b=ROLnc6XkRUUoF2m2ccyXQF5t2KG0i/n3qTcy7qBXYFkK2lG7dqzyPqW6
 1Crxdcrg3WVA7VgCMgz0bL23FV3GMohD30c4F4AiIkqtc4kaEEChX3+NL
 XgtxVmP/pb5r49ABFfMCNdgz8pXQnC0dCeF+XkICKguWU8pFGm3YhCwOG
 aJJpWVU7HOKXN3qLr9BXOKPKKJvkBDiF9IISPGAB/H7xCcnHEUbY3EGar
 OOt9PPvfhgGWCuIZNY29yN8+aC1yU9S3ZuJznpPcdCmkJpEo+15gX5Yh3
 /NJhyiKOoutzHTZiP+Pyfs3MfeSJHRipLnXUexueJkXrMrzB1obQ4hA1C g==;
X-CSE-ConnectionGUID: 4cTmyMaKQxqhM3vicMej/g==
X-CSE-MsgGUID: kFeWBvOgT1SZnCz9At3V6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78133388"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="78133388"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 06:00:07 -0700
X-CSE-ConnectionGUID: jSy+zyGeTHmVdp8BfC8GxQ==
X-CSE-MsgGUID: 5McrInLZRlyHYmqaI14EeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="240783670"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 07 May 2026 06:00:05 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 2/2] net/ice: fix shaper profile reference count tracking
Date: Thu,  7 May 2026 12:59:30 +0000
Message-ID: <20260507125930.1668860-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507125930.1668860-1-ciara.loftus@intel.com>
References: <20260507125930.1668860-1-ciara.loftus@intel.com>
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

Currently, when a TM node is added with a shaper profile assigned,
the profile's reference count is not incremented. Equally, when a node
is deleted, the count is not decremented. As a result, the guard that
blocks deletion of an in-use profile never triggers, allowing the profile
to be freed while nodes still hold a pointer to it.

Fix by maintaining the reference count correctly when nodes take or
release a shaper profile, so that deletion of an in-use profile is
properly rejected.

Fixes: 8c481c3bb65b ("net/ice: support queue and queue group bandwidth limit")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 2bb684bb02..015a827d7a 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -456,6 +456,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->parent = NULL;
 		tm_node->reference_count = 0;
 		tm_node->shaper_profile = shaper_profile;
+		if (shaper_profile != NULL)
+			shaper_profile->reference_count++;
 		tm_node->children = RTE_PTR_ADD(tm_node, sizeof(struct ice_tm_node));
 		tm_node->params = *params;
 		pf->tm_conf.root = tm_node;
@@ -518,6 +520,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	tm_node->parent = parent_node;
 	tm_node->level = level_id;
 	tm_node->shaper_profile = shaper_profile;
+	if (shaper_profile != NULL)
+		shaper_profile->reference_count++;
 	tm_node->children = RTE_PTR_ADD(tm_node, sizeof(struct ice_tm_node));
 	tm_node->parent->children[tm_node->parent->reference_count++] = tm_node;
 	tm_node->params = *params;
@@ -568,6 +572,8 @@ ice_tm_node_delete(struct rte_eth_dev *dev, uint32_t node_id,
 
 	/* root node */
 	if (tm_node->level == 0) {
+		if (tm_node->shaper_profile != NULL)
+			tm_node->shaper_profile->reference_count--;
 		rte_free(tm_node);
 		pf->tm_conf.root = NULL;
 		return 0;
@@ -582,6 +588,8 @@ ice_tm_node_delete(struct rte_eth_dev *dev, uint32_t node_id,
 		tm_node->parent->children[j] = tm_node->parent->children[j + 1];
 
 	tm_node->parent->reference_count--;
+	if (tm_node->shaper_profile != NULL)
+		tm_node->shaper_profile->reference_count--;
 	rte_free(tm_node);
 
 	return 0;
-- 
2.43.0

