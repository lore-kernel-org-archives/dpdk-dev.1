Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED588EF0702
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D1E640DD6;
	Tue, 10 Feb 2026 17:14:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8B4EE40A7A
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740056; x=1802276056;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=L2JbbECeKjNdzt1A0ekdFvPkp1R0uJ7jTa/ad/ZlAQ4=;
 b=i1Cn8pkutb6dtlgPgZzNyAXT1R2BrXZ27Qf+ovvNItGqRrkD0txlppuU
 fa0VDS3lU3tOTxWidmBe+g5jzL6TLJjK95B1S8P+HwMDO3FdOunB03crD
 HN2gI7WOOutETGzNwI3Y5uRngLOoh5jQlLxNQL5F6fhzGvPG/2CLBUtUe
 biOQxiqbmGwhfXrDCRhV/iXhCV/9gTNjXpNjwgUlVZyWYh39weFj4rtoL
 D1s+YRiM3MDGyI5iSdO070KfjwFRLTiEKVRkXNNdunDQi4DNrbPqWdkxh
 vpPktrgWRu3LRHx5Aiph/CnukDAUCd+pQVyDQHby0sikxiiTGD68m89vm w==;
X-CSE-ConnectionGUID: 5HIOdfYaTMqoclFqrQyNyw==
X-CSE-MsgGUID: 5UsxLhBKQZOKJA2EyHDzbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286201"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286201"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:15 -0800
X-CSE-ConnectionGUID: x4tET4zQSrGNkIiUeoQXgQ==
X-CSE-MsgGUID: qi28cZv/TpCqlwhkN+99Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127750"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 10/26] net/i40e: avoid rte malloc in RSS RETA operations
Date: Tue, 10 Feb 2026 16:13:39 +0000
Message-ID: <53bbb4f1a754df0a31d0ab3db9635117d6c5520b.1770739925.git.anatoly.burakov@intel.com>
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

Currently, when updating or querying RSS redirection table (RETA), we
are using rte_zmalloc followed by an immediate rte_free. This is not
needed as this memory is not being stored anywhere, so replace it with
regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 06430e6319..654b0e5d16 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -4630,7 +4630,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -4649,7 +4649,7 @@ i40e_dev_rss_reta_update(struct rte_eth_dev *dev,
 	pf->adapter->rss_reta_updated = 1;
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
@@ -4673,7 +4673,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("i40e_rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -4690,7 +4690,7 @@ i40e_dev_rss_reta_query(struct rte_eth_dev *dev,
 	}
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
-- 
2.47.3

