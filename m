Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548F1E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:26:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66C4340B9F;
	Thu, 19 Feb 2026 17:23:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id AE5484065C
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518224; x=1803054224;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uyzHvb3vAWEzr4JM+QJQmrtrBOMyXYno3J5Zo7K9vQ0=;
 b=fAK2YazubufSBNhsuLFpWpiPXNzar6xjYmSz8swx/92AfYbbrlwqsbBG
 aQpHW/LhqDVvSpywAaJkpoUAwYLOROdCPr9aj3eRzSJfB9/0ST3zQPyNT
 yy/samq9mvwt4gRExxfSKIr7kNW+cYx+u2DS6s1ooJs/chauLUehofc34
 danEWnIKi2BzNF1EsKC2o33VjRBOuMN4IEQvUkoGpQoJPqKPXF1+ZVyS3
 pkA6WJiIyAYUi4j3qDtnpcQCVOm4V4Qpw4+RXohsT2YK6aHMOjXVQ8LmC
 Mx3IoRpHZtdoaEbMpfFJVYCrSL9yogBirDeBkHnhuSJ/k71P0k4J78Vob g==;
X-CSE-ConnectionGUID: fQfgpv4GQaGRY25Polmdwg==
X-CSE-MsgGUID: Ld4XEfmmTyqmZ7FwHijfQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231471"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231471"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:44 -0800
X-CSE-ConnectionGUID: FJaB1eRETk+CHZVqU4sa3A==
X-CSE-MsgGUID: o8u10DhuSymC69VoUq/0yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699994"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:43 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 24/27] net/ice: avoid rte malloc in RSS RETA operations
Date: Thu, 19 Feb 2026 16:23:07 +0000
Message-ID: <e1f480034a736388731e08f35dfdb9dfe3196d6f.1771518103.git.anatoly.burakov@intel.com>
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
not need to be stored in hugepage memory, so replace it with stack
allocation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c |  4 ++--
 drivers/net/intel/ice/ice_ethdev.c     | 29 ++++++--------------------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 81da5a4656..037382b336 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1338,7 +1338,7 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -1358,7 +1358,7 @@ ice_dcf_dev_rss_reta_update(struct rte_eth_dev *dev,
 	ret = ice_dcf_configure_rss_lut(hw);
 	if (ret) /* revert back */
 		rte_memcpy(hw->rss_lut, lut, reta_size);
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index ade13600de..b9d8b2a3ac 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5566,7 +5566,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K] = {0};
 	int ret;
 
 	if (reta_size != ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128 &&
@@ -5583,14 +5583,9 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	/* It MUST use the current LUT size to get the RSS lookup table,
 	 * otherwise if will fail with -100 error code.
 	 */
-	lut = rte_zmalloc(NULL,  RTE_MAX(reta_size, lut_size), 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
 	ret = ice_get_rss_lut(pf->main_vsi, lut, lut_size);
 	if (ret)
-		goto out;
+		return ret;
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -5606,10 +5601,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 		pf->hash_lut_size = reta_size;
 	}
 
-out:
-	rte_free(lut);
-
-	return ret;
+	return 0;
 }
 
 static int
@@ -5620,7 +5612,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	uint16_t i, lut_size = pf->hash_lut_size;
 	uint16_t idx, shift;
-	uint8_t *lut;
+	uint8_t lut[ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_2K] = {0};
 	int ret;
 
 	if (reta_size != lut_size) {
@@ -5632,15 +5624,9 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc(NULL, reta_size, 0);
-	if (!lut) {
-		PMD_DRV_LOG(ERR, "No memory can be allocated");
-		return -ENOMEM;
-	}
-
 	ret = ice_get_rss_lut(pf->main_vsi, lut, reta_size);
 	if (ret)
-		goto out;
+		return ret;
 
 	for (i = 0; i < reta_size; i++) {
 		idx = i / RTE_ETH_RETA_GROUP_SIZE;
@@ -5649,10 +5635,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 			reta_conf[idx].reta[shift] = lut[i];
 	}
 
-out:
-	rte_free(lut);
-
-	return ret;
+	return 0;
 }
 
 static int
-- 
2.47.3

