Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E846CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:07:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7066040676;
	Wed, 20 May 2026 17:07:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id C3A204042F;
 Wed, 20 May 2026 17:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779289654; x=1810825654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iT5qrU2O6AQjd4U+XeEV8N0xn+2S4u0Opciv5J38Pt0=;
 b=CwlplyieMlWFk65qNWld4uuVPkdDtQt8iz5z2cCUCjCPIy/L7hOWK46u
 RGhYmPaZvECvfjR7x6rP/5jS46ds4BjFdEXwH4mM/XufjJFYzAikNXDMq
 Bg+eLfgGzSPf9dAk2Yui523ZlIPfdAimz/do68CQzUCYyNco25vpzmz0x
 Dt1mlwliY1YEhIYUV6jMVC5VJGrDzZeuZPQHQrCQ1/3YbqnLBl/ntRGTN
 rApbKx5a918IjDhw9Rvxh9zpmKOjY9ZFKaxYMUi0eynEYO53hM91HLyUI
 75C9kgZJlKytKxI/TRsCogo2rECsmM5Ol8xm5NIjhyhf5Ech6rNIy1Fhg w==;
X-CSE-ConnectionGUID: ENq961FpS4WnPr8Ph1N49Q==
X-CSE-MsgGUID: w7ue6/dpQbO7Xxsy3z2XOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97761447"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="97761447"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 08:07:33 -0700
X-CSE-ConnectionGUID: afXXE7HBTOaF1uvJ//3lXw==
X-CSE-MsgGUID: kNuE+tljTem6x1NgybsJmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="245217360"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 20 May 2026 08:07:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] net/ice: fix TM node ID validation against configured
 queues
Date: Wed, 20 May 2026 15:07:16 +0000
Message-ID: <20260520150717.365942-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505123157.1387791-1-ciara.loftus@intel.com>
References: <20260505123157.1387791-1-ciara.loftus@intel.com>
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

The leaf node ID boundary is checked against the compile-time constant
`RTE_MAX_QUEUES_PER_PORT` (1024) rather than the number of configured Tx
queues. The rte_tm specification reserves IDs 0 to N-1 for leaf nodes
where N is the configured queue count, so using the constant produces
wrong results whenever N is less than 1024.

Fix by using `nb_tx_queues` as the boundary when queues have been
configured, falling back to `RTE_MAX_QUEUES_PER_PORT` when `nb_tx_queues`
is zero. The zero case arises when the TM hierarchy is built before port
queue configuration, which is required to support queue counts beyond
the hardware default.

Also add an explicit check in the non-leaf validation path that rejects
IDs in the leaf-reserved range. This condition can be triggered two ways:
adding a leaf node before its parent chain is complete (the node resolves
to a non-leaf level), or assigning a leaf-range ID to a node intended
as non-leaf.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index 015a827d7a..bf2ac117b1 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -88,8 +88,11 @@ ice_node_param_check(uint32_t node_id,
 		      uint32_t priority, uint32_t weight,
 		      const struct rte_tm_node_params *params,
 		      bool is_leaf,
+		      uint16_t nb_txq,
 		      struct rte_tm_error *error)
 {
+	uint32_t max_leaf_id = (nb_txq != 0) ? nb_txq : RTE_MAX_QUEUES_PER_PORT;
+
 	/* checked all the unsupported parameter */
 	if (node_id == RTE_TM_NODE_ID_NULL) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
@@ -123,6 +126,11 @@ ice_node_param_check(uint32_t node_id,
 
 	/* for non-leaf node */
 	if (!is_leaf) {
+		if (node_id < max_leaf_id) {
+			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+			error->message = "node ID is reserved for leaf nodes";
+			return -EINVAL;
+		}
 		if (params->nonleaf.wfq_weight_mode) {
 			error->type =
 				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
@@ -146,7 +154,7 @@ ice_node_param_check(uint32_t node_id,
 	}
 
 	/* for leaf node */
-	if (node_id >= RTE_MAX_QUEUES_PER_PORT) {
+	if (node_id >= max_leaf_id) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 		error->message = "Node ID out of range for a leaf node.";
 		return -EINVAL;
@@ -440,7 +448,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 			return -EINVAL;
 		}
 
-		ret = ice_node_param_check(node_id, priority, weight, params, false, error);
+		ret = ice_node_param_check(node_id, priority, weight, params, false,
+				dev->data->nb_tx_queues, error);
 		if (ret)
 			return ret;
 
@@ -481,7 +490,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	}
 
 	ret = ice_node_param_check(node_id, priority, weight,
-			params, level_id == ice_get_leaf_level(pf), error);
+			params, level_id == ice_get_leaf_level(pf),
+			dev->data->nb_tx_queues, error);
 	if (ret)
 		return ret;
 
-- 
2.43.0

