Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C46E9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A31DB40B95;
	Wed, 11 Feb 2026 14:53:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5B99F40A82
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818027; x=1802354027;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=s/lycNwBvmBMZUO0P6WZ8my5qBZzbAs37+pXM7Xze0k=;
 b=kuvYpC13Wtcp4FEwnyE9cXIsCWRBEOFkJ9tWTiI3/GmUCBUFMyhHbKBc
 MjOlro8TwZr6/RBpVCtZNVXBcr5uF6UfDwrNy2iynDxhNuEgk0YkaTB9r
 EsVnDS97iAHRVDvjo6ET5uSJU6Rba6shiWA/+er8J3vm0KJkUhjcmdIpi
 tzXYI7Y69Jo0aJ5RJI6hPAGABGIZu780FdcC1c3p4wvFpQYr/d0BZeo3F
 5abwuY6vPbT05TF1HBsby2NCZu89VT94kCURy8lFRl5OFualcGAaLlt+d
 uuR17sDXA00Adky4+i4+0oZV1eHQcRsZPIP0UoGEPB9pd0uaenCXdRhwV g==;
X-CSE-ConnectionGUID: ch9x1UFFQ7OA2ogmWapMkw==
X-CSE-MsgGUID: r9KdlLxpRgWfB/sEfEpJhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808252"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808252"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:47 -0800
X-CSE-ConnectionGUID: h6Sp9WClT4aoICY6YlhRWw==
X-CSE-MsgGUID: rnTUHRFoRvqNvROMq+dhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359594"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 12/27] net/i40e: avoid rte malloc in VF resource queries
Date: Wed, 11 Feb 2026 13:52:54 +0000
Message-ID: <506b85c8822496fa6f1628834a353975ffc71302.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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
rte_free. This is not needed as the response is only used temporarily,
so replace it with a stack-allocated structure (the allocation is fixed
in size and pretty small).

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_pf.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_pf.c b/drivers/net/intel/i40e/i40e_pf.c
index ebe1deeade..2a5637b0c1 100644
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
+	uint32_t len = sizeof(res);
 	struct i40e_hw *hw = I40E_PF_TO_HW(vf->pf);
-	uint32_t len = 0;
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

