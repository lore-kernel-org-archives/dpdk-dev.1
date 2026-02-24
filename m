Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C982F3C995
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:16:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2393F40672;
	Tue, 24 Feb 2026 16:15:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 0443A402E9
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946090; x=1803482090;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yJLgr8E7zUf6+gQ0ajQTiTzcm4Sq/xaf9ucCsvvU99s=;
 b=DKBVS3vKBo7E8K7bAGqCNi1ODchx1Coa/a60eTfKRU/BOs8tPkStgN1+
 wrOd0PTBsEf9EBsGnas1JiRKhqgTQjzOoMgmP1uYtFpnxdvCB58EDVfzs
 i6YvCVibNo+GsfaER1ALG91FF3Ju/dUto+xoVUpjRwDcCgPPttxXkofT/
 kvKTGUbQG5dnAv2jivfdRPrvXzisAUFyupHsyal0UjiIqGyQbnFocnyK2
 zWzTv4q0Yg2FPW/BbgZrAfUpDo80SNIKWn1r1mT8XBE87AwZcCOIGY1N6
 qUbBF1ilIZog9q1UOD+9zLTH8QveEM2JVc57Dva6nilNo9H72xj5YVZ9d Q==;
X-CSE-ConnectionGUID: Wpv1A/mnSdSeXY2qA5Djmw==
X-CSE-MsgGUID: lKUI4xDSRjO6ErzkAE+R2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056252"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056252"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:49 -0800
X-CSE-ConnectionGUID: uzhKcllbTgqv76nVPlVccg==
X-CSE-MsgGUID: FDNzW02QTEGOZqZnlhmNcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526145"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 10/26] net/i40e: avoid rte malloc in RSS RETA operations
Date: Tue, 24 Feb 2026 15:14:15 +0000
Message-ID: <1353dfc8611a2c400aad0182fa37c29eafda2d18.1771945933.git.anatoly.burakov@intel.com>
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

