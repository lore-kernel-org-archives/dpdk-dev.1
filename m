Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8884EE9E309
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF6D40697;
	Wed, 11 Feb 2026 14:49:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CE58240613
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770817783; x=1802353783;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v7fBa3QaIJ7/erSleJCJsSkadnuzxS1GwTDKHkOfeeY=;
 b=LWrniGYszOYd9bD4yudk8tIDEwc6Y+3gvPq4fnWa8fhTuBqFB2odn9Av
 PnPtfH199iZsObLvfEsH19kfmy/MjmQ3VcXVkbb+0ARQb1tE5gYhMsndu
 iq6Nc+FwqGCYTxzjusRe3dkVRQl4aAUy1sLTy3MKIVBCZxCbJbNE4EuqJ
 HVw6ijDGaXjwhnIFGNDrjUWA2TJzk6luanAhi8rYRibEK6z3DK2XgELK9
 76mXnNHTD16SZUaoZmzTFsb9UCaj+NUc7wOzNuXsRMtzcNsJYKq61YeAL
 SYbNwV80cmBfqZouBsLwytxYr07bPYHsHdMhqQGuQ0Rwk1ye//ib/oulS g==;
X-CSE-ConnectionGUID: C5Dja4pkSZ6EL7VlzoSiag==
X-CSE-MsgGUID: vQb/6ZNmRouWBWJ/c4DIrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83332531"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="83332531"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:49:42 -0800
X-CSE-ConnectionGUID: 2hQ+0Q7CTymoZExvJ6c6nw==
X-CSE-MsgGUID: s14XZ4v/T7y+6Hbz+Hrf+w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 11 Feb 2026 05:49:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Ting Xu <ting.xu@intel.com>,
 Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v4 8/9] net/ice: fix memory leak in DCF QoS bandwidth config
Date: Wed, 11 Feb 2026 13:49:15 +0000
Message-ID: <3e0063a306042e649f5c090013896595eabff878.1770817694.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817694.git.anatoly.burakov@intel.com>
 <cover.1770817694.git.anatoly.burakov@intel.com>
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
---
 drivers/net/intel/ice/ice_dcf_sched.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_sched.c b/drivers/net/intel/ice/ice_dcf_sched.c
index 2832d223d1..645f1373f4 100644
--- a/drivers/net/intel/ice/ice_dcf_sched.c
+++ b/drivers/net/intel/ice/ice_dcf_sched.c
@@ -746,8 +746,8 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
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
@@ -770,12 +770,12 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
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
@@ -875,6 +875,11 @@ static int ice_dcf_hierarchy_commit(struct rte_eth_dev *dev,
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

