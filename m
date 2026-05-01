Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3180CCD3424
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 May 2026 10:59:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6CF84066A;
	Fri,  1 May 2026 12:59:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4BBAC40299;
 Fri,  1 May 2026 12:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777633146; x=1809169146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ufg29xFxKX6D+k4HGYEfmy52L5qE7QMa3/sGexR8Q1E=;
 b=jhm9e4yEzW9WQ5PnCjWY70sQUV4v6Ksk9mttVOc4BEYW5IGobPh51ykC
 U/keE0kV44sFVc3bQ1LrznjbsK6rM/ShFswf6+I2wCGdPI2pADl1YF9gZ
 il0U8O3pxUBTah8LY6Kf3TKM8qeOa8OIKQ/J/oYeHGnt+r/CmJ1pwPJ6G
 Bf3tbKw5cV1bRNO6uccc6MyvpdGD2g/T2EM2HEoSfVcAP+kYSe8t9C6HO
 wqvUGQU730nGFC5Epxp3AvGqky/7OSid/jVb2bU3prozDI3xxuNhnfGGh
 MKzkVm0JpvIs5reMNBZQn5NPBhx9n4HDem5QCv9frScp/5FE/tFEQ+s+T w==;
X-CSE-ConnectionGUID: PdJke1cVTamEiXSWWBfKoQ==
X-CSE-MsgGUID: l6z1N9ZdTeu2wAzCw9rYsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="89971702"
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="89971702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2026 03:59:04 -0700
X-CSE-ConnectionGUID: 1TmDIGRPQ5qlEXi2Hwkqqg==
X-CSE-MsgGUID: Df00RhPtRSq86blv6CSdHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,209,1770624000"; d="scan'208";a="239162082"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa004.jf.intel.com with ESMTP; 01 May 2026 03:59:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/2] net/ice: fix shaper profile reference count tracking
Date: Fri,  1 May 2026 10:57:55 +0000
Message-ID: <20260501105755.1136087-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501105755.1136087-1-ciara.loftus@intel.com>
References: <20260501105755.1136087-1-ciara.loftus@intel.com>
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
---
 drivers/net/intel/ice/ice_tm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 4dcfb15c27..d1f3d80ac7 100644
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

