Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33539F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F44B40A75;
	Tue, 24 Feb 2026 16:15:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 92F234065B
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946094; x=1803482094;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q0tSkQucXUCXECYI4tHDsQ1rXzzaq4fbICmrELlCfus=;
 b=aIVcc6dI12P3O+lzjYucJQW+IHrWM+uty4I+ubRaVW6tCHWg9sJoSzRl
 uCetPlKkFHNcFv99TMCjDKVzYp4CmL9u3RW+EDO1f+pi1QZH6Fm+6w0bY
 0GkfGPasSyIQyp1ixMxQEi5i1nU+gh0A2SPqIK+BUmRa38xsc7XAaT2bB
 3J1SDhfOiAlPTSGR11JQzipFEB8EnKesXXn4Aie8hs/hy8Nz+km254+ki
 /C+j7GAzeFm/z9Mtfkm2Z7gFHs/FqRBhHfJu7tM1L4cjdEbL/RWjQr545
 I0uvGm6flDEBz3pxwVIWIv/1g+bzqLdYo5qNzSw8V/d37BJISFBivWd0C g==;
X-CSE-ConnectionGUID: NQ1g+q2ITpWil7sLsPC3Gw==
X-CSE-MsgGUID: MAw0Ke3OS2+/LlHHB+hX8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056262"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:54 -0800
X-CSE-ConnectionGUID: b4r8i0S4SM6emhQ1M6jRZg==
X-CSE-MsgGUID: PsU+Wk4tQOaR0j8S/HEdsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526176"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:53 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 15/26] net/i40e: avoid rte malloc in DDP ptype handling
Date: Tue, 24 Feb 2026 15:14:20 +0000
Message-ID: <72021acae569b65188ac82c80d3c0cdb1c847e3a.1771945933.git.anatoly.burakov@intel.com>
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

Currently, when updating customized protocol and packet type information
via DDP packages, we are using rte_zmalloc followed by immediate
rte_free. This memory does not need to be stored in hugepage memory, so
replace it with stack allocation or regular calloc/free as appropriate.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 43 ++++++++--------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index cd648285d1..af736f59be 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11716,8 +11716,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint32_t pctype_num;
-	struct rte_pmd_i40e_ptype_info *pctype;
-	uint32_t buff_size;
+	struct rte_pmd_i40e_ptype_info pctype[I40E_CUSTOMIZED_MAX] = {0};
 	struct i40e_customized_pctype *new_pctype = NULL;
 	uint8_t proto_id;
 	uint8_t pctype_value;
@@ -11743,19 +11742,16 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 		return -1;
 	}
 
-	buff_size = pctype_num * sizeof(struct rte_pmd_i40e_proto_info);
-	pctype = rte_zmalloc("new_pctype", buff_size, 0);
-	if (!pctype) {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory");
+	if (pctype_num > RTE_DIM(pctype)) {
+		PMD_DRV_LOG(ERR, "Pctype number exceeds maximum supported");
 		return -1;
 	}
 	/* get information about new pctype list */
 	ret = rte_pmd_i40e_get_ddp_info(pkg, pkg_size,
-					(uint8_t *)pctype, buff_size,
+					(uint8_t *)pctype, sizeof(pctype),
 					RTE_PMD_I40E_PKG_INFO_PCTYPE_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get pctype list");
-		rte_free(pctype);
 		return -1;
 	}
 
@@ -11836,7 +11832,6 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 		}
 	}
 
-	rte_free(pctype);
 	return 0;
 }
 
@@ -11846,11 +11841,10 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 			     struct rte_pmd_i40e_proto_info *proto,
 			     enum rte_pmd_i40e_package_op op)
 {
-	struct rte_pmd_i40e_ptype_mapping *ptype_mapping;
+	struct rte_pmd_i40e_ptype_mapping ptype_mapping[I40E_MAX_PKT_TYPE] = {0};
 	uint16_t port_id = dev->data->port_id;
 	uint32_t ptype_num;
-	struct rte_pmd_i40e_ptype_info *ptype;
-	uint32_t buff_size;
+	struct rte_pmd_i40e_ptype_info ptype[I40E_MAX_PKT_TYPE] = {0};
 	uint8_t proto_id;
 	char name[RTE_PMD_I40E_DDP_NAME_SIZE];
 	uint32_t i, j, n;
@@ -11881,31 +11875,20 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 		return -1;
 	}
 
-	buff_size = ptype_num * sizeof(struct rte_pmd_i40e_ptype_info);
-	ptype = rte_zmalloc("new_ptype", buff_size, 0);
-	if (!ptype) {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory");
+	if (ptype_num > RTE_DIM(ptype)) {
+		PMD_DRV_LOG(ERR, "Too many ptypes");
 		return -1;
 	}
 
 	/* get information about new ptype list */
 	ret = rte_pmd_i40e_get_ddp_info(pkg, pkg_size,
-					(uint8_t *)ptype, buff_size,
+					(uint8_t *)ptype, sizeof(ptype),
 					RTE_PMD_I40E_PKG_INFO_PTYPE_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get ptype list");
-		rte_free(ptype);
 		return ret;
 	}
 
-	buff_size = ptype_num * sizeof(struct rte_pmd_i40e_ptype_mapping);
-	ptype_mapping = rte_zmalloc("ptype_mapping", buff_size, 0);
-	if (!ptype_mapping) {
-		PMD_DRV_LOG(ERR, "Failed to allocate memory");
-		rte_free(ptype);
-		return -1;
-	}
-
 	/* Update ptype mapping table. */
 	for (i = 0; i < ptype_num; i++) {
 		ptype_mapping[i].hw_ptype = ptype[i].ptype_id;
@@ -12040,8 +12023,6 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to update ptype mapping table.");
 
-	rte_free(ptype_mapping);
-	rte_free(ptype);
 	return ret;
 }
 
@@ -12076,7 +12057,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = proto_num * sizeof(struct rte_pmd_i40e_proto_info);
-	proto = rte_zmalloc("new_proto", buff_size, 0);
+	proto = calloc(proto_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!proto) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return;
@@ -12088,7 +12069,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PROTOCOL_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get protocol list");
-		rte_free(proto);
+		free(proto);
 		return;
 	}
 
@@ -12126,7 +12107,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(INFO, "No ptype is updated.");
 
-	rte_free(proto);
+	free(proto);
 }
 
 /* Create a QinQ cloud filter
-- 
2.47.3

