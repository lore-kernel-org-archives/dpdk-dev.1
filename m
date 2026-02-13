Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A6EDF023
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:11:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A936406B4;
	Fri, 13 Feb 2026 10:10:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2FC1A4068E
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973839; x=1802509839;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gDd9AczrYnoTIRe4Q4hK9+F18Jh14GUPYxXCcuExWzM=;
 b=oBcKbSCmUGvYf6mrHOcLH7ez1c+pL8zvwDWodZLN5byhTD9zU2IB9kT1
 ktqHYWhFq2qosEHvOyita4pZtVhnBRhKgVk80e2wsd+jFbF+00Ibdjic8
 uXCha13rKHxxsm05KZuvqKb+vPqsDmnqQs5prdpgQo8jtXg3B7PF/VH/9
 pxV6k8CEGZGbNyTpj5cfh/PvlPTODQr4wN6VW2EifD+zyZuzfecIJUz2l
 qRc4klyCXZi6wM4TN6u+TnApRFKHTuOaBJplTzNEros6Jl0Z0wIZBoTwC
 72KvIvmXJoMgVNihJaSufEAIgXenDjMrD/SdVirEgTwxTX86KOKSsKFph A==;
X-CSE-ConnectionGUID: 2K04jtbmRHmbq3hTeWtECA==
X-CSE-MsgGUID: 7WJaJHZjQEm8fRgOnoLvtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567897"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567897"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:39 -0800
X-CSE-ConnectionGUID: wAyK4L3hSAiBzdgbMogqHQ==
X-CSE-MsgGUID: CtFGfE5dQJq9TU24iHfLeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966105"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ting Xu <ting.xu@intel.com>,
 Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v6 11/12] net/ice: fix memory leak in DCF QoS bandwidth config
Date: Fri, 13 Feb 2026 09:10:13 +0000
Message-ID: <8a84fd1d069448735369a273a08c8b353628dc6f.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770973745.git.anatoly.burakov@intel.com>
 <cover.1770973745.git.anatoly.burakov@intel.com>
References: 
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

Currently, when committing DCF QoS bandwidth configuration for VFs and TCs,
we are using rte_zmalloc followed by copying the data to persistent storage
and then discarding the temporary buffers. This is not needed as these
temporary buffers are not being stored anywhere, so replace them with
regular calloc. However, because the original code was missing a
corresponding `rte_free()` call for these temporary allocations, this
also fixes a memory leak.

Fixes: 3a6bfc37eaf4 ("net/ice: support QoS config VF bandwidth in DCF")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/ice_dcf_sched.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 2832d223d1..948774a282 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2010-2017 Intel Corporation
  */
+#include <stdlib.h>
+
 #include <rte_tm_driver.h>
 
 #include "base/ice_sched.h"
@@ -746,8 +748,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 {
 	struct ice_dcf_adapter *adapter = dev->data->dev_private;
 	struct ice_dcf_hw *hw = &adapter->real_hw;
-	struct virtchnl_dcf_bw_cfg_list *vf_bw;
-	struct virtchnl_dcf_bw_cfg_list *tc_bw;
+	struct virtchnl_dcf_bw_cfg_list *vf_bw = NULL;
+	struct virtchnl_dcf_bw_cfg_list *tc_bw = NULL;
 	struct ice_dcf_tm_node_list *vsi_list = &hw->tm_conf.vsi_list;
 	struct rte_tm_shaper_params *profile;
 	struct ice_dcf_tm_node *tm_node;
@@ -770,12 +772,12 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	size = sizeof(struct virtchnl_dcf_bw_cfg_list) +
 		sizeof(struct virtchnl_dcf_bw_cfg) *
 		(hw->tm_conf.nb_tc_node - 1);
-	vf_bw = rte_zmalloc("vf_bw", size, 0);
+	vf_bw = calloc(1, size);
 	if (!vf_bw) {
 		ret_val = ICE_ERR_NO_MEMORY;
 		goto fail_clear;
 	}
-	tc_bw = rte_zmalloc("tc_bw", size, 0);
+	tc_bw = calloc(1, size);
 	if (!tc_bw) {
 		ret_val = ICE_ERR_NO_MEMORY;
 		goto fail_clear;
@@ -875,6 +877,11 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
 	return ret_val;
 
 fail_clear:
+	if (vf_bw != NULL)
+		free(vf_bw);
+	if (tc_bw != NULL)
+		free(tc_bw);
+
 	/* clear all the traffic manager configuration */
 	if (clear_on_fail) {
 		ice_dcf_tm_conf_uninit(dev);
-- 
2.47.3

