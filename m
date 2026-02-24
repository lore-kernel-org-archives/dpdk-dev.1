Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B546E9B25B
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:25:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2994066F;
	Tue, 24 Feb 2026 13:24:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 1DFCB40656
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:24:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935841; x=1803471841;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=fTMvvzADNT/VsPV+vO48YjDbLKbWwNkqNj9enIo/VZs=;
 b=CjFzbA+PRm/Nu91dQXuB71S5KTYC+yOXBjLV3oTZD//pWABclGqxWK7P
 A+35jNrawnIAXbgro006Hh1HEv50qBT/YMvg5vSTdLUxjRTtCW2w7/eC8
 ksUiCGvZCmbeTUCU12Qtu35fxPuqTjvsbmk59orHqj3JyKig+4OddqLbv
 Uu+GhbsexzhoCk1jKBCTSC/v8+DdWVowLfqNvN/PDqy9xiVaiI5lXHi/Z
 W00o1YMiKKZEGZLA4aBa8uni7UnZ7hgT7K7WGbhdFjdXxPKJq2rsA2sSL
 Ct4nhypHz+EHd0CzNSyDRm05SWIHu73rIepgWwVCh0sPKdwzXKpRttZBE w==;
X-CSE-ConnectionGUID: ZNLkFcOdTOadkxcfgPxhVA==
X-CSE-MsgGUID: yeAdEGD3R5yt/xGLE0wUVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158139"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:24:01 -0800
X-CSE-ConnectionGUID: WxZ4YZdyRVqJ5OM4fF12Xg==
X-CSE-MsgGUID: pBZqOeZJQuWil101opNrHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854475"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:24:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v8 19/26] net/iavf: avoid rte malloc in RSS configuration
Date: Tue, 24 Feb 2026 12:23:28 +0000
Message-ID: <afd113f110bdc253ade69596a8fb641b9e6a8fa5.1771935744.git.anatoly.burakov@intel.com>
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

Currently, when configuring RSS (redirection table, lookup table, and
hash key), we are using rte_zmalloc followed by an immediate rte_free.
This memory does not need to be stored in hugepage memory, and in context
of IAVF we do not define how big these structures can be, so replace the
allocations with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 4 ++--
 drivers/net/intel/iavf/iavf_vchnl.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index b45da4d8b1..4e0df2ca05 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1553,7 +1553,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -1573,7 +1573,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 	ret = iavf_configure_rss_lut(adapter);
 	if (ret) /* revert back */
 		rte_memcpy(vf->rss_lut, lut, reta_size);
-	rte_free(lut);
+	free(lut);
 
 	return ret;
 }
diff --git a/drivers/net/intel/iavf/iavf_vchnl.c b/drivers/net/intel/iavf/iavf_vchnl.c
index 9ad39300c6..55986ef909 100644
--- a/drivers/net/intel/iavf/iavf_vchnl.c
+++ b/drivers/net/intel/iavf/iavf_vchnl.c
@@ -1159,7 +1159,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 	int len, err = 0;
 
 	len = sizeof(*rss_lut) + vf->vf_res->rss_lut_size - 1;
-	rss_lut = rte_zmalloc("rss_lut", len, 0);
+	rss_lut = calloc(1, len);
 	if (!rss_lut)
 		return -ENOMEM;
 
@@ -1178,7 +1178,7 @@ iavf_configure_rss_lut(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_CONFIG_RSS_LUT");
 
-	rte_free(rss_lut);
+	free(rss_lut);
 	return err;
 }
 
@@ -1191,7 +1191,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 	int len, err = 0;
 
 	len = sizeof(*rss_key) + vf->vf_res->rss_key_size - 1;
-	rss_key = rte_zmalloc("rss_key", len, 0);
+	rss_key = calloc(1, len);
 	if (!rss_key)
 		return -ENOMEM;
 
@@ -1210,7 +1210,7 @@ iavf_configure_rss_key(struct iavf_adapter *adapter)
 		PMD_DRV_LOG(ERR,
 			    "Failed to execute command of OP_CONFIG_RSS_KEY");
 
-	rte_free(rss_key);
+	free(rss_key);
 	return err;
 }
 
-- 
2.47.3

