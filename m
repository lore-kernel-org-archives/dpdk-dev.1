Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF92E6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:17:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 278B840B9F;
	Tue, 17 Feb 2026 13:15:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id E57D640B9E
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330507; x=1802866507;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j0sbtdJMBvkJdtXKwMUIQ2OHmYf6SUHFc/96gim3icc=;
 b=Ix4+H6EA7WGzlOYo6BFCwEAg43c5Rxg2T/GLtyxssYXWsGT5HZ6qWi/g
 mTqWVr/iBV370ouYtXiElKRkczp5VuDo3wiNe3L2OQrd17wwRBln1PI47
 DyRMFHz/cqd3ylfkwXkJXyFpXkfXo8oclQp7JX0UcOaQX0u9OimxcNZ5G
 0t4GadpQ3iZbBtjCeFsqAe/uVk9eODylWsMzkF8GHdQdXaIgnYtYpduwp
 kfFXY2lSAoEU/YRzRYHCHGf8IvegPNS8EGwGJIYc0OKcPQKcbNgw/4oFO
 XamU93+n188p+1s/TUTIJhjIuFQJsFFgES3QNtu89Smq9M+sHk6EwOvy8 Q==;
X-CSE-ConnectionGUID: PeZH7m65T7SwgLyadavB2A==
X-CSE-MsgGUID: GZx1PE7ZRo6am0JN7+Rbpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996068"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996068"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:06 -0800
X-CSE-ConnectionGUID: Xv6O/imFTU2RxIVx2u6qzA==
X-CSE-MsgGUID: cCxJBESdRfOZfV5KMQN51w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396850"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 24/27] net/ice: avoid rte malloc in RSS RETA operations
Date: Tue, 17 Feb 2026 12:14:13 +0000
Message-ID: <151efbaf3069a6982a127de132b47be402027c40.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ice/ice_dcf_ethdev.c | 4 ++--
 drivers/net/intel/ice/ice_ethdev.c     | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

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
index ade13600de..fbd7c0f2f2 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5583,7 +5583,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	/* It MUST use the current LUT size to get the RSS lookup table,
 	 * otherwise if will fail with -100 error code.
 	 */
-	lut = rte_zmalloc(NULL,  RTE_MAX(reta_size, lut_size), 0);
+	lut = calloc(1, RTE_MAX(reta_size, lut_size));
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -5607,7 +5607,7 @@ ice_rss_reta_update(struct rte_eth_dev *dev,
 	}
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
@@ -5632,7 +5632,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc(NULL, reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -5650,7 +5650,7 @@ ice_rss_reta_query(struct rte_eth_dev *dev,
 	}
 
 out:
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
-- 
2.47.3

