Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EDCC5518E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C435740B9C;
	Fri, 20 Feb 2026 11:15:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7A0A740659
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582508; x=1803118508;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q0tSkQucXUCXECYI4tHDsQ1rXzzaq4fbICmrELlCfus=;
 b=N5IBzsgz1c9fxUmjpZTDMOFwZ3vBrrR7uih5ErSaDEHYVWHP0tf89YtK
 ZMaWDV2m/MOwc5cPrXV4zIb6AdUC29m2/pYXpns0RR3fU5zvBwURKTBaM
 nCGS7d0KJ3B29AsoSisyb/KW6B7cxAAIxhTvroiT7q/DRpd6LtvaqGw+8
 73hcgetBR/Wuw35VY9U9ZVR3zQSbqUdeIKFAZ6cuXtSlnDqGRY7/hPvTb
 HvYkurZbf0D5DM8ZGSmRm3DZrFrhOLj+X77i+tDGzTREDowZFfsFxOvou
 pOyVZjEYjD5OQauVswrr0hxMaR++nueEbtp+GXqjD7g5j6gKSKXBaL4nj w==;
X-CSE-ConnectionGUID: QMFXFTKCShSxYNDQYQyBCQ==
X-CSE-MsgGUID: yf7kmGsKT0aSf82dR20UOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283359"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:07 -0800
X-CSE-ConnectionGUID: ro/nQ8BiQHCdaAFtOej0Uw==
X-CSE-MsgGUID: mVJOIVJ5SkS+UPO9HDCA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038527"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Date: Fri, 20 Feb 2026 10:14:22 +0000
Message-ID: <706acb56bb58c319565c1e34ee8768ba8d8d27d8.1771582363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771582362.git.anatoly.burakov@intel.com>
 <cover.1771582362.git.anatoly.burakov@intel.com>
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

