Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D234EA813E
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D54E540E11;
	Tue, 10 Feb 2026 17:14:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id CE56B40BA3
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740058; x=1802276058;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=s/lycNwBvmBMZUO0P6WZ8my5qBZzbAs37+pXM7Xze0k=;
 b=C6QYqn5j8P72ZHX7I76J6+JH7TFwnjGOEgAeFxzawQCH3qw/CkAYYiml
 7T1WDjvVUH0Y1RQI3VUPLOmDLkU+QGEMrBA+hVMaG4j5Ul+wNMiUmBwaZ
 iEePDQVcMLxaPuLj2rf3L6DnBpGxZuL7WMs28Jm2el6XbTRUBeRvnvlxk
 Gl1J9oJt1Z35LgEVUMrYY9uz2YBwPnDX9EZ8ndeUwRUEGr/UTkXOWlFc0
 JZCUXrgLhq3U+/ugc1BvjIokvlWcPeZ3NpoKNXWe7VxS3bQJgnflv9SMM
 oZxVEJwIRIZib8phM1E8UQ9CrhuoeWHfuI2llEg3S9K78C3YIqH11mOmc Q==;
X-CSE-ConnectionGUID: EJLIHbShQYmosF3xSaFA7Q==
X-CSE-MsgGUID: +dz+yvhqRG6HO05jRgBNTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286205"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286205"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:18 -0800
X-CSE-ConnectionGUID: dRJRWVEsTh2ylevmj6D/1Q==
X-CSE-MsgGUID: c+mFX59sSPSrdLmEuSySqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127759"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:17 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 12/26] net/i40e: avoid rte malloc in VF resource queries
Date: Tue, 10 Feb 2026 16:13:41 +0000
Message-ID: <63a48a50b429881ffb34c0627545bf5ecb1e3a22.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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

