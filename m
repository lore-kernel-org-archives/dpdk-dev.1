Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF45E9B25B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DB4D4067C;
	Tue, 24 Feb 2026 13:24:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 73DBC4064F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935833; x=1803471833;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yJLgr8E7zUf6+gQ0ajQTiTzcm4Sq/xaf9ucCsvvU99s=;
 b=D9gs2z+CT8ovUG56lQAZl6yHq/Jzds+Bj/cLtdNcTUKwjGautd9uGGyT
 fkWTNAFYD238DNdpRHy1SLgcL3m/1IPtodIMB8tj/ZFoyJjI/J9L3VIpd
 FpjW+pxPKPIVZBIzTHByDeMMognlUXqw7dcm0IWNOSfSzXeoe3DDYazUE
 PpvTG3MCv4vKj5iwRsk1o8VZr/cqJ6iJaJkitiGRaKg+H3AeOVzXA8U75
 9SEoCwudTdoDkkkIbl1NumeQzkU99d9e/Cx2HSOvyd/7WPwjxXfQhElPj
 erMNiXnAlSSafbtBEjq2rkl7K4tGQXCsvvxIuMXMUpqTWQOkVfpdfTov6 g==;
X-CSE-ConnectionGUID: eTzvr36pT/W96F6e5e9wAg==
X-CSE-MsgGUID: pLHRFaF2QTmdFgqXDpwTng==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158118"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158118"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:23:52 -0800
X-CSE-ConnectionGUID: rP4p1DbmSVeQYB/VLNxz7Q==
X-CSE-MsgGUID: UN1qb5mESb2P5oOroC92hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854439"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:23:51 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 10/26] net/i40e: avoid rte malloc in RSS RETA operations
Date: Tue, 24 Feb 2026 12:23:19 +0000
Message-ID: <1353dfc8611a2c400aad0182fa37c29eafda2d18.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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

