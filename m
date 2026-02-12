Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951DBEB491F
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5906B40A6B;
	Thu, 12 Feb 2026 13:54:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 69B63406B6
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900840; x=1802436840;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gDd9AczrYnoTIRe4Q4hK9+F18Jh14GUPYxXCcuExWzM=;
 b=gLpMTLlS0RaRj6+HbiNH8k7M9yRBNeQNxKAVPCunFTEBUYasXn73DoU1
 L5v0SlNzRni32akGG+iglQkLHs3fgqYTcKMf/UwHT6GkxbwUjF8n4gFsv
 vfv/q01UT/BjGMo6ZYtUB9d2grYspaLH8zTN4pcm4FhMISJLSfyUa9g2w
 Aout62BuzASab7KlHS5R2XO3yaPQ4yzlrQVEqj2d7FOx4t5HTt4VzW7EK
 IqOSYAXzriS9dAFged2cAkyd65vMXSKbnGwV4urW/vUzR88sF+ke1rERB
 lN64B7MrtOPvJYoK2dIVdpeWtnStFYP6YFcqO+gQvVBc81kgnSp9oJ4da w==;
X-CSE-ConnectionGUID: f4btE9TzS2mcQ0hmyrDKIw==
X-CSE-MsgGUID: A80tToRpSVS8MDOFcmgWKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785501"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:59 -0800
X-CSE-ConnectionGUID: 82upx4ULTVC8dSQcUziOog==
X-CSE-MsgGUID: o6U0MyWnT4+Rw85lYKMsYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179206"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Ting Xu <ting.xu@intel.com>
Subject: [PATCH v5 11/12] net/ice: fix memory leak in DCF QoS bandwidth config
Date: Thu, 12 Feb 2026 12:53:34 +0000
Message-ID: <06060cc0f1bafe1ad0a8a3d5db7fe93658909ea7.1770900758.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770900757.git.anatoly.burakov@intel.com>
 <cover.1770900757.git.anatoly.burakov@intel.com>
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

