Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF9E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFAB140E0F;
	Wed, 11 Feb 2026 14:54:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8486640DFD
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818041; x=1802354041;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=j0sbtdJMBvkJdtXKwMUIQ2OHmYf6SUHFc/96gim3icc=;
 b=b8cDGhILuLkDBe4xJzVgka+kFax9HOWv5t4z81R3uBxSRLEkfVG87ZdY
 zz4Mz8JwmPzmtIz1SwX4GeX81IrDWfFY/lEGW45C+1BVVdidGREiwtFdN
 dBaxiK/FWM35O/DCZOlf3TH/etOFlQXzGFxU8z5KdeIR7uckQ3IZRXc7b
 zW2uYqVRDAVNsto3pY5xuJolHCqspX2AFPN3HYU3/nAyjXjBpP/mo944n
 XXDRG4LJHPXT4LEquq0G7b18oh59e+T/SDxaDN/mpxZNjFHPqHZiFCxBv
 fc1+36hd2d7Qa3wMw6CxnRKjyCMhIvGyevuBtC7XwiKGXbgUrfnMMXlqd w==;
X-CSE-ConnectionGUID: Ssa5zv5RSZaRciGnVgBmlA==
X-CSE-MsgGUID: VUGSvuTRQrGUdk7XkFQR/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808276"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808276"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:54:01 -0800
X-CSE-ConnectionGUID: qd2hPLyrQyu5pOFsWvPnYQ==
X-CSE-MsgGUID: BSjK1gH+Q4Ov+QOyY8oOVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359699"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:54:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 24/27] net/ice: avoid rte malloc in RSS RETA operations
Date: Wed, 11 Feb 2026 13:53:06 +0000
Message-ID: <044d93fba29393da2c437eac5df84696ff7efc10.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

