Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C664CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 372BD40684;
	Tue,  2 Sep 2025 19:27:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id ED0084066A;
 Tue,  2 Sep 2025 19:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834046; x=1788370046;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mltyd+ww/hiGNOs/w+wMxPPt/cPAmV1CgIIBLd7wXek=;
 b=AfiSy9usqabUt7kUgk3NXd5FQ9bOAEGfOxBSqT2qeJuqQ5e/XjfMIUQG
 07sjBiWclWhOCt8uv0xv4Enr4AKLzModhO4+IT1gF1c30fn9E//w3jAOK
 27kBcojsNcOKAWhK+akzRvD9+Zw+yX6sWw1vbvFIx73lM8M4I1cPC00Xi
 lIvGZhNAqlcI5iOwcOCPKyA4cMYUBxBlrT2SEUsgavwXc/HqLzUQSCurB
 grMN0SCLZrhJSLK7SGrZItScOdkTQBG1c2GCNWH0XxUU7fB7envldMHJP
 iGPJx1oX8kMYwcYqJgB+2atn4Ncs7XVL7Xn3sS9gJO0ljKtP+dmGLW0zN w==;
X-CSE-ConnectionGUID: HOPjNgieRs6La2sIXu7Dgg==
X-CSE-MsgGUID: Hmvs9LYjTDSfR0fX+CORJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731988"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731988"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:19 -0700
X-CSE-ConnectionGUID: Ufkzj3iPRLWrTSZDMuHElw==
X-CSE-MsgGUID: ZY+o1WUmS/WAU8vixGcMqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229114"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Grishma Kotecha <grishma.kotecha@intel.com>,
 Leyi Rong <leyi.rong@intel.com>, Qi Zhang <qi.z.zhang@intel.com>,
 Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 04/12] net/ice/base: fix memory leak in recipe handling
Date: Tue,  2 Sep 2025 18:26:54 +0100
Message-ID: <bc0a3f0b28bfb84d7a8a372d43950c4730c4a189.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
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

From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>

Advanced filter operations (apply/remove GENEVE/VXLAN filters) trigger
the call chain: ice_add_adv_rule()/ice_rem_adv_rule() -> ice_find_recp()
-> ice_get_recp_frm_fw(). Each call to ice_get_recp_frm_fw() creates new
linked list entries for SW recipe tracking without cleaning up previous
entries for the same recipe ID. The linked list then continuously grows
with each filter add/remove operation, leading to excessive heap usage
over time.

Fix the memory leak by adding logic to remove the duplicate entries
before adding new ones for the same recipe ID.

Fixes: fed0c5ca5f19 ("net/ice/base: support programming a new switch recipe")
Cc: stable@dpdk.org

Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index f16bec044c..628473f100 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -2435,6 +2435,7 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 		    bool *refresh_required)
 {
 	ice_declare_bitmap(result_bm, ICE_MAX_FV_WORDS);
+	struct ice_recp_grp_entry *rg, *tmprg_entry;
 	struct ice_aqc_recipe_data_elem *tmp;
 	u16 num_recps = ICE_MAX_NUM_RECIPES;
 	struct ice_prot_lkup_ext *lkup_exts;
@@ -2481,6 +2482,15 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 	 */
 	lkup_exts = &recps[rid].lkup_exts;
 
+	/* Remove duplicate entries */
+	LIST_FOR_EACH_ENTRY_SAFE(rg, tmprg_entry, &recps[rid].rg_list,
+	                         ice_recp_grp_entry, l_entry) {
+		if (rg->rid == rid) {
+			LIST_DEL(&rg->l_entry);
+			ice_free(hw, rg);
+		}
+	}
+
 	for (sub_recps = 0; sub_recps < num_recps; sub_recps++) {
 		struct ice_aqc_recipe_data_elem root_bufs = tmp[sub_recps];
 		struct ice_recp_grp_entry *rg_entry;
-- 
2.47.3

