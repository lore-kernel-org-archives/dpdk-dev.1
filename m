Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6867AC531FF
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:16:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98DD0406BB;
	Fri, 20 Feb 2026 11:15:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id CBDFD4067E
 for <dev@dpdk.org>; Fri, 20 Feb 2026 11:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771582501; x=1803118501;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yJLgr8E7zUf6+gQ0ajQTiTzcm4Sq/xaf9ucCsvvU99s=;
 b=NlCRjLLpDs+cteHf3GJRMKvcv0i8oOn+dxVtJAxw8HXxxgOZoSd9y0eG
 sVBkWB8zaJqIouAzvVXSYLsjXV0mWn7V1E6bHsD7nwa/hyGY9jQXkQ2Mf
 Pj/U5pVt/udiebS2hbf4wlwagal9AU8ENv5cEmaPju/U1T66cpzgy+uu5
 Mzi01iqZHQWXJysRNQTh1vKRGPSbw/nQfmhpVBccCHJHRncJKBtH/083Q
 O3M6E/ND+Y/nvbIrAXpstuS6G9zkq7kNptrpzUEadOM4brqq0WGInzCuH
 Evuz8el6Hd7Dt1bgRugUMySBx77/C3S5lpbkKzs+3oi8ZIAbOZt0T+Kc0 g==;
X-CSE-ConnectionGUID: 7/z2D/q7SmGnXNxxHuZ2BQ==
X-CSE-MsgGUID: QYPQw6nOQAGKMmWBqtOf5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="75283349"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="75283349"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2026 02:15:00 -0800
X-CSE-ConnectionGUID: 138PMj9SQ1WyYS+7x2SXXA==
X-CSE-MsgGUID: QedaMixxTfmMjheuOfD6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; d="scan'208";a="214038491"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 20 Feb 2026 02:15:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Date: Fri, 20 Feb 2026 10:14:17 +0000
Message-ID: <018a7c04efc96eb3a66e756ed56914364ca278b4.1771582362.git.anatoly.burakov@intel.com>
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

Currently, when updating or querying RSS redirection table (RETA), we
are using rte_zmalloc followed by an immediate rte_free. This memory does
not need to be stored in hugepage memory and the maximum LUT size is 512
bytes, so replace it with stack-based allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index f9e86b82b7..ba66f9e3fd 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4619,7 +4619,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512] = {0};
 	int ret;
 
 	if (reta_size != lut_size ||
@@ -4630,14 +4630,9 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
 	ret = i40e_get_rss_lut(pf->main_vsi, lut, reta_size);
 	if (ret)
-		goto out;
+		return ret;
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
 		shift = i % RTE_ETH_RETA_GROUP_SIZE;
@@ -4648,9 +4643,6 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 
 	pf->adapter->rss_reta_updated = 1;
 
-out:
-	rte_free(lut);
-
 	return ret;
 }
 
@@ -4662,7 +4654,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 	struct i40e_pf *pf = I40E_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[RTE_ETH_RSS_RETA_SIZE_512] = {0};
 	int ret;
 
 	if (reta_size != lut_size ||
@@ -4673,15 +4665,9 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
-
 	ret = i40e_get_rss_lut(pf->main_vsi, lut, reta_size);
 	if (ret)
-		goto out;
+		return ret;
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
 		shift = i % RTE_ETH_RETA_GROUP_SIZE;
@@ -4689,9 +4675,6 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 			reta_conf[idx].reta[shift] = lut[i];
 	}
 
-out:
-	rte_free(lut);
-
 	return ret;
 }
 
-- 
2.47.3

