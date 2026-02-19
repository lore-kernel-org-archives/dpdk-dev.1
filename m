Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFB0E9A04D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:25:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3010B4067C;
	Thu, 19 Feb 2026 17:23:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 81FF540655
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518215; x=1803054215;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=igVkS4mMQ8xmyg2uWVOhoYVAQ2jjp5Rut2wD2iuppN4=;
 b=ehcm1r/waDN9wGwFv4vokAzK02HYO4j2A9BnHqamjvYztQxxKua2Js7X
 XUYaSfDwqAP6uW+4Vr1PU5ojLUit79OwyM4GkBRmzBnRypFL4Qo7O0U74
 vuWYo5fh+MuBOwXkihdT85fGKazCrHow6SK+wyNq9KENGaczgmzPxe2Tx
 Fo4LK9WEIMR6NMTmXomW2xD2Y0w1noXB+b0ps/d/dLKRXC87XzKpkn29i
 FWhxiKsA8tdkz6O0BvE+3DWwjkHOIgVhcl+8GwllwI0XqkaOQSQnqZJuP
 ByEPq7hMYG6ygvBiFDwAEg32h6qcS4eYrEkj0vqsS0xNC4ju4dpoy2OBZ w==;
X-CSE-ConnectionGUID: zke5agqBR+aEAwYc0SBmHQ==
X-CSE-MsgGUID: aVWkDQ3YTiKE6fKjpZTjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231447"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231447"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:34 -0800
X-CSE-ConnectionGUID: 7eS8FUBRTY6pVSXKfLHUVA==
X-CSE-MsgGUID: 5jXd3p2gSHGPTVacnzyDfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699896"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 15/27] net/i40e: avoid rte malloc in DDP ptype handling
Date: Thu, 19 Feb 2026 16:22:58 +0000
Message-ID: <6a5b0d22a7d2dde773c915365de88048c7306250.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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
index fff832fba1..faf35acde0 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -11718,8 +11718,7 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 {
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint32_t pctype_num;
-	struct rte_pmd_i40e_ptype_info *pctype;
-	uint32_t buff_size;
+	struct rte_pmd_i40e_ptype_info pctype[I40E_CUSTOMIZED_MAX] = {0};
 	struct i40e_customized_pctype *new_pctype = NULL;
 	uint8_t proto_id;
 	uint8_t pctype_value;
@@ -11745,19 +11744,16 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
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
 
@@ -11838,7 +11834,6 @@ i40e_update_customized_pctype(struct rte_eth_dev *dev, uint8_t *pkg,
 		}
 	}
 
-	rte_free(pctype);
 	return 0;
 }
 
@@ -11848,11 +11843,10 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
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
@@ -11883,31 +11877,20 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
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
@@ -12042,8 +12025,6 @@ i40e_update_customized_ptype(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(ERR, "Failed to update ptype mapping table.");
 
-	rte_free(ptype_mapping);
-	rte_free(ptype);
 	return ret;
 }
 
@@ -12078,7 +12059,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	}
 
 	buff_size = proto_num * sizeof(struct rte_pmd_i40e_proto_info);
-	proto = rte_zmalloc("new_proto", buff_size, 0);
+	proto = calloc(proto_num, sizeof(struct rte_pmd_i40e_proto_info));
 	if (!proto) {
 		PMD_DRV_LOG(ERR, "Failed to allocate memory");
 		return;
@@ -12090,7 +12071,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 					RTE_PMD_I40E_PKG_INFO_PROTOCOL_LIST);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to get protocol list");
-		rte_free(proto);
+		free(proto);
 		return;
 	}
 
@@ -12128,7 +12109,7 @@ i40e_update_customized_info(struct rte_eth_dev *dev, uint8_t *pkg,
 	if (ret)
 		PMD_DRV_LOG(INFO, "No ptype is updated.");
 
-	rte_free(proto);
+	free(proto);
 }
 
 /* Create a QinQ cloud filter
-- 
2.47.3

