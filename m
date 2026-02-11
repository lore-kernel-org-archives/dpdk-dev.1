Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008EAE9E302
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF57440670;
	Wed, 11 Feb 2026 14:04:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 356D34065B
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:04:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770815056; x=1802351056;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v7fBa3QaIJ7/erSleJCJsSkadnuzxS1GwTDKHkOfeeY=;
 b=RMwDarqi9qBNzy9jwAbjT8XqlE5NG8dQbGIffR7Duqu7dxI9zgmNGTxa
 OWVJ2HRjBWJSXHUA7QY42yHVpVNhcwjJQNbeSZ3f8tGrtXix+hEN2nXi/
 WJRjhZeTczjx9iBOtrVpItrQBHXdTGjlRMcOoFqaposhkVZQaJ60ViBCB
 4YBtItgqyjKiHlMarAzEq0xi5Q1iQnwqxuhFzXCZ69ozZKYniKexZnu/Z
 WHpYIZLe3cAdNE2TDz/3BetJ2dQ+Hll7p8pD0uc3YCmi87wWNkK4IJipY
 bBFCq2mN0N/xCGZuOd6MAkpXn72uIGAgp62dQh0RK8bob81vzNClF7c0E g==;
X-CSE-ConnectionGUID: pXQfPwJOSs2vP2S3cNIybw==
X-CSE-MsgGUID: 5+zlYE8yT0mDOJ9q7wPWQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="59529080"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="59529080"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:04:16 -0800
X-CSE-ConnectionGUID: VafJrWMdReWizZfq/RIGhQ==
X-CSE-MsgGUID: bEWRJCzsTGuFjvMnQh7Fcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="217206439"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 11 Feb 2026 05:04:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ting Xu <ting.xu@intel.com>, Qiming Yang <qiming.yang@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v3 7/8] net/ice: fix memory leak in DCF QoS bandwidth config
Date: Wed, 11 Feb 2026 13:03:52 +0000
Message-ID: <0696763fed8c2dac3cdec6c824bd1ace8b3eaf16.1770814868.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770814868.git.anatoly.burakov@intel.com>
 <cover.1770814868.git.anatoly.burakov@intel.com>
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

