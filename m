Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF3E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45D074067D;
	Thu, 19 Feb 2026 17:23:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id E35E44065D
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518209; x=1803054209;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Vn51x1K46k8bqsgXcdYbrNFCL4z/Ll3ZZVpzbwcHBy0=;
 b=RQlqNAOCRjQWjZqngb+ApRltkN8e3uO4VgZlPPYfcf2rmlrQ8URBcAzc
 uLSTfvR9/jV29Nfp3UxIcK2gbPeJ9GauhygoAwgIxO1ltGSoigdxiSg3P
 r2nqW9dsvfbxEkigFilkRdJIebZwAZG/Zd9df3ksOqKmGPKAahrUMpMA8
 cVz7ozRmI3wtf/43GDK/udXa2pMK/VlyO3y8MEUZcLZm4jVnLGeZbjTcM
 4BnZJr0vwrhgFN2Vp3t4Gir3hPoQNNQX6rbSMAUfpQKqbAyzEfmYzgupj
 7oBiWmeyXidTovaRz/2LgTUnAXVWjo9hJs7vaedcM2r0F+hpMdkWoWF9Y A==;
X-CSE-ConnectionGUID: M52jlmgCTrqrCu0Gddb19A==
X-CSE-MsgGUID: Hj1H0JwUQGq/btzendL1dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231439"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231439"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:29 -0800
X-CSE-ConnectionGUID: RTpOQT2iRBm6AkD8tI3cyA==
X-CSE-MsgGUID: Vx+UUux3TyuNd0CLko0vvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699854"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Date: Thu, 19 Feb 2026 16:22:53 +0000
Message-ID: <1e3b77560b41bd1467a0db6b6c83bf4b6db43759.1771518103.git.anatoly.burakov@intel.com>
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

Currently, when updating or querying RSS redirection table (RETA), we
are using rte_zmalloc followed by an immediate rte_free. This memory does
not need to be stored in hugepage memory and the maximum LUT size is 512
bytes, so replace it with stack-based allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index d3404d7720..d1f8e12689 100644
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

