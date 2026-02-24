Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133DF3C991
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54B3F40697;
	Tue, 24 Feb 2026 16:15:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id D92214064F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946092; x=1803482092;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fda2A26vqB1nKmzQfF0mNUfBxMNCyT8g8GXE45afWRk=;
 b=mceCliendmLcKI/f/DJxDwe/xkqTqSiP8wH3zhy4eNE9pqPjWFoFuoqG
 Sm7BAWkSni5qMUX4EkJ9LjuGVTwA5BfX8aXwhDwURkFaCtPQmMndi73ja
 r+JAmLpLIptMo8ChqQ4oiliKSqgLXx2YU5EmNfzjM+qmbVTYDo5o4Lric
 1OUt/qLxWOjqq/B/R2hPhdZTHMHMUl1A6ciLEF8zVOLNoD59tRxctPxHy
 +bkl6TEHni2/Fb/Y86FRKfIUOjoChirC1puB8DU7GqIKg1otl668KcX1l
 soCGaYDb6Qa6RWSwXNGY3a2ZEviGfCtGqkmC9ncVvpkbo4pWh/JHues4U Q==;
X-CSE-ConnectionGUID: JM4s1znETNChUlD28gqHzA==
X-CSE-MsgGUID: e/KLgjjeSA62CCYheWL4kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056258"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056258"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:51 -0800
X-CSE-ConnectionGUID: AIMfaejISH+xIH9AXth+UA==
X-CSE-MsgGUID: xSMhEgVOR8CXWHdPGFAN4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526154"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 12/26] net/i40e: avoid rte malloc in VF resource queries
Date: Tue, 24 Feb 2026 15:14:17 +0000
Message-ID: <db1f2f400c639314ac5dadb1d56ed62a630a2046.1771945933.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771945933.git.anatoly.burakov@intel.com>
 <cover.1771945933.git.anatoly.burakov@intel.com>
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

Currently, when responding to VF resource queries, we are dynamically
allocating a temporary buffer with rte_zmalloc followed by an immediate
rte_free. This memory does not need to be stored in hugepage memory and
the allocation size is pretty small, so replace it with stack allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_pf.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index ebe1deeade..08cdd6bc4d 100644
--- a/drivers/net/intel/i40e/i40e_pf.c
+++ b/drivers/net/intel/i40e/i40e_pf.c
@@ -309,9 +309,14 @@ static int
 i40e_pf_host_process_cmd_get_vf_resource(struct i40e_pf_vf *vf, uint8_t *msg,
 					 bool b_op)
 {
-	struct virtchnl_vf_resource *vf_res = NULL;
+	/* only have 1 VSI by default */
+	struct {
+		struct virtchnl_vf_resource vf_res;
+		struct virtchnl_vsi_resource vsi_res;
+	} res = {0};
+	struct virtchnl_vf_resource *vf_res = &res.vf_res;
 	struct i40e_hw *hw = I40E_PF_TO_HW(vf->pf);
-	uint32_t len = 0;
+	uint32_t len = sizeof(res);
 	uint64_t default_hena = I40E_RSS_HENA_ALL;
 	int ret = I40E_SUCCESS;
 
@@ -322,20 +327,6 @@ i40e_pf_host_process_cmd_get_vf_resource(struct i40e_pf_vf *vf, uint8_t *msg,
 		return ret;
 	}
 
-	/* only have 1 VSI by default */
-	len =  sizeof(struct virtchnl_vf_resource) +
-				I40E_DEFAULT_VF_VSI_NUM *
-		sizeof(struct virtchnl_vsi_resource);
-
-	vf_res = rte_zmalloc("i40e_vf_res", len, 0);
-	if (vf_res == NULL) {
-		PMD_DRV_LOG(ERR, "failed to allocate mem");
-		ret = I40E_ERR_NO_MEMORY;
-		vf_res = NULL;
-		len = 0;
-		goto send_msg;
-	}
-
 	if (VF_IS_V10(&vf->version)) /* doesn't support offload negotiate */
 		vf->request_caps = VIRTCHNL_VF_OFFLOAD_L2 |
 				   VIRTCHNL_VF_OFFLOAD_VLAN;
@@ -377,11 +368,8 @@ i40e_pf_host_process_cmd_get_vf_resource(struct i40e_pf_vf *vf, uint8_t *msg,
 	rte_ether_addr_copy(&vf->mac_addr,
 		(struct rte_ether_addr *)vf_res->vsi_res[0].default_mac_addr);
 
-send_msg:
 	i40e_pf_host_send_msg_to_vf(vf, VIRTCHNL_OP_GET_VF_RESOURCES,
 					ret, (uint8_t *)vf_res, len);
-	rte_free(vf_res);
-
 	return ret;
 }
 
-- 
2.47.3

