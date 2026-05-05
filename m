Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C41ACD3427
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 12:32:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D1004027F;
	Tue,  5 May 2026 14:32:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id BF42A4026C;
 Tue,  5 May 2026 14:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777984338; x=1809520338;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QlOCcWhM19cin7os0yWWxhQ5uyUQrCTwbcRUxMygAgw=;
 b=MD+VLvDVsHQZlkNo67mXt3hcpJYSpezFRgnQ1ovTaLlQQEOeKsnYs2b8
 fiWBd/vbqkVTCMcf9WBIoN7+W+G5WCMp1BxCv8Q+T2shCpuDUgeEU7kAj
 kUkSRyjoAPlpukFwQyvtl4RVA/aqV4dpMS/cTo+37anATDYIT4kpKnj1h
 X0cUWbCFsa/e+KMKAKM3IzmgpsxfVU0q5wcYSJgtn5TBUPicuWNfBF9Ba
 EQMgRTy0Tcf8U62aTeB96ZNu5DkQFm8asjjtviLkLX1gvzT1pTu/YByIV
 vsw+H9kUfmtySnCr/BJ5hJ2KGVr6mqsLdsKqJIM7+LqC58hxajcZVrE9f Q==;
X-CSE-ConnectionGUID: lFOb8247Qc6ueEIvqIMmGA==
X-CSE-MsgGUID: /t6PH+VgSF+PawBcvpWeOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90226826"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="90226826"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 05:32:17 -0700
X-CSE-ConnectionGUID: 4HWqHlK1RLurKjXeW5l6tA==
X-CSE-MsgGUID: 3DqjvK7wQXikuTxLul/PGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="237576320"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa004.fm.intel.com with ESMTP; 05 May 2026 05:32:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix TM node ID validation against configured queues
Date: Tue,  5 May 2026 12:31:57 +0000
Message-ID: <20260505123157.1387791-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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
`RTE_MAX_QUEUES_PER_PORT` (1024) rather than the number of Tx queues
configured for the port. The rte_tm specification reserves IDs 0 to
(N-1) for leaf nodes, where N is the configured queue count, so using
the constant produces wrong results whenever N is less than 1024. Fix by
replacing the constant with the runtime queue count.

Also add an explicit check in the non-leaf validation path that rejects
IDs in the leaf-reserved range. This condition can be triggered
two ways: adding a leaf node before its parent chain is complete (the
node resolves to a non-leaf level), or assigning a leaf-range ID to a
node intended as non-leaf.

Fixes: 715d449a965b ("net/ice: enhance Tx scheduler hierarchy support")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_tm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_tm.c b/drivers/net/intel/ice/ice_tm.c
index ff53f2acfd..7ee4070007 100644
--- a/drivers/net/intel/ice/ice_tm.c
+++ b/drivers/net/intel/ice/ice_tm.c
@@ -88,6 +88,7 @@ ice_node_param_check(uint32_t node_id,
 		      uint32_t priority, uint32_t weight,
 		      const struct rte_tm_node_params *params,
 		      bool is_leaf,
+		      uint16_t nb_txq,
 		      struct rte_tm_error *error)
 {
 	/* checked all the unsupported parameter */
@@ -123,6 +124,11 @@ ice_node_param_check(uint32_t node_id,
 
 	/* for non-leaf node */
 	if (!is_leaf) {
+		if (node_id < nb_txq) {
+			error->type = RTE_TM_ERROR_TYPE_NODE_ID;
+			error->message = "node ID is reserved for leaf nodes";
+			return -EINVAL;
+		}
 		if (params->nonleaf.wfq_weight_mode) {
 			error->type =
 				RTE_TM_ERROR_TYPE_NODE_PARAMS_WFQ_WEIGHT_MODE;
@@ -146,7 +152,7 @@ ice_node_param_check(uint32_t node_id,
 	}
 
 	/* for leaf node */
-	if (node_id >= RTE_MAX_QUEUES_PER_PORT) {
+	if (node_id >= nb_txq) {
 		error->type = RTE_TM_ERROR_TYPE_NODE_ID;
 		error->message = "Node ID out of range for a leaf node.";
 		return -EINVAL;
@@ -440,7 +446,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 			return -EINVAL;
 		}
 
-		ret = ice_node_param_check(node_id, priority, weight, params, false, error);
+		ret = ice_node_param_check(node_id, priority, weight, params, false,
+				dev->data->nb_tx_queues, error);
 		if (ret)
 			return ret;
 
@@ -479,7 +486,8 @@ ice_tm_node_add(struct rte_eth_dev *dev, uint32_t node_id,
 	}
 
 	ret = ice_node_param_check(node_id, priority, weight,
-			params, level_id == ice_get_leaf_level(pf), error);
+			params, level_id == ice_get_leaf_level(pf),
+			dev->data->nb_tx_queues, error);
 	if (ret)
 		return ret;
 
-- 
2.43.0

