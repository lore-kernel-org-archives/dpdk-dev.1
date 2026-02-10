Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFFEA813A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 15:52:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802DA40A80;
	Tue, 10 Feb 2026 16:52:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id D316C40A72
 for <dev@dpdk.org>; Tue, 10 Feb 2026 16:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770738743; x=1802274743;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=v7fBa3QaIJ7/erSleJCJsSkadnuzxS1GwTDKHkOfeeY=;
 b=LBk37kEeTqFT3oIFTACX8wr4P9NHq+guhtwQTAH82UZ20l3v2b9cg0zc
 HKQgw1REAmLZr81gHOZCgWAJA6jUpw/QFCU5gkRfVnEeiTpTaruXaMty+
 A273szwkzViw8HC+DBqYqwec06UJiRpniekSKDIgm5fHfwn8JtDlgxQ7I
 3OD1U4XtpmWAL5v2eP8kedKLKeporHrBAB+4v3KkmUH8Ap1aQWegupbeo
 Ayf9CotKWBpvsRmydjDyQyevVVG2Twl7otLnO2jRIWOMNOJ3TWNu5T5/H
 Wed8tuAogfVodZXA3WZaV3alz+4CLV4tJk5lsgJtjSb4mSJ8fkSRCXcmX A==;
X-CSE-ConnectionGUID: Zp3T/cvLT66N3jnDVleDJg==
X-CSE-MsgGUID: UxTWArZrTAGfOZnurbBObQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71080901"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71080901"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 07:52:22 -0800
X-CSE-ConnectionGUID: 8GOZ+UP+SH23iiefsVo3qQ==
X-CSE-MsgGUID: 8lmdwKBSQ0KeDMxflBOrrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211285390"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 10 Feb 2026 07:52:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Ting Xu <ting.xu@intel.com>, Qiming Yang <qiming.yang@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2 7/7] net/ice: fix memory leak in DCF QoS bandwidth config
Date: Tue, 10 Feb 2026 15:52:09 +0000
Message-ID: <14b8241f0abc1b23a8d3fd8249a9a69f58ef6e1d.1770738711.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com>
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

