Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A41FE6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C171F40A76;
	Tue, 17 Feb 2026 13:14:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7B2F540676
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330493; x=1802866493;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=s/lycNwBvmBMZUO0P6WZ8my5qBZzbAs37+pXM7Xze0k=;
 b=k4jZROwsjp1SS9yDtHubFKGWKKP/YVaIX+eUx9JeuuVJzqbtvzZ7Ifsl
 e7OeEsH4pK4ZZUqz3w43Qgr+8yKm5dl6rdRwERMew5xG3PRne801WUyGx
 JKADb2sk9pgMEnhpLX5yWF1Y1WYv7UutGC0GVGp3HmwdbL/A5d4656zG/
 MQTtdLPWtjYX7FX+z2FRNWNMy4TWONl98BlNd9ly+b2s3V9WDCrB6zzTA
 XkwBZcC4Li069fWL79B5DCHc0VSo+s2XPGeJFp8iZRnjSui80W0XpvhOR
 0+7MI8SkLkeaD3GtCxuBMdWDRBtLVfQyhWAL8EHMpIbEP11H+3kIw683O Q==;
X-CSE-ConnectionGUID: l+hqJyPnT0STSy8Knxp0AA==
X-CSE-MsgGUID: /SLeNaMzT3ar8/m7rjkCRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996033"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996033"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:52 -0800
X-CSE-ConnectionGUID: tgSsHgmrRHCbIhf9z7AdJg==
X-CSE-MsgGUID: QWaRAHmXShCG2A8kas1OHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396803"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 12/27] net/i40e: avoid rte malloc in VF resource queries
Date: Tue, 17 Feb 2026 12:14:01 +0000
Message-ID: <11cf1e51890103ae2c6cd3b569b4c676d843b5e1.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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

