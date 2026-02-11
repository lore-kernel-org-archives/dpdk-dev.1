Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65925E9E30C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:55:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE46440DF5;
	Wed, 11 Feb 2026 14:54:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 75DAA40B9E
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:53:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818035; x=1802354035;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZJjRF0L+9jwpPyf8EIrVm/M0vJKDhKUuTbpFlKne7zs=;
 b=Vzl4Veim/onxtFzok+FFc3tSRygmEzAFOv0tA16xR7s8olI8SDFTEeAM
 Qcki5tSbnH0eSYRHf10YK6Cq1YKZ3AB50tnzyPRNFAM3RYlJHdAnPS3Oq
 PglI2P7iViv3BaNUtj+xR7R8iYKltzFIFsBJk6EKoUtkUlAUsuiex0igB
 d0aDkyj/9BtsbvoUsMDB4Ku7TPMAlLOD+V+Aoj37SY3lxXmgq8E+dodhe
 1D1UA1xJWsqfJXCjlknezh2PXuvdHHyHFTLpQPn0mofOgAiKTkQxSyGct
 12Gm9U8a2do3bOrSbLAWWKGnUCl8+rDJJ0nyLMu5kDtdeVPckNkhXS+xK Q==;
X-CSE-ConnectionGUID: uXt6uhRST3Ky+nI7TjLw5w==
X-CSE-MsgGUID: 27PIFKL+QCyE4AK5fO+sWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808268"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808268"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:53:55 -0800
X-CSE-ConnectionGUID: OTxlDqjGT0qvsO7kpbEWqw==
X-CSE-MsgGUID: wTw3ceByQJeR0WfmLaHkpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359648"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:53:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 19/27] net/iavf: avoid rte malloc in RSS configuration
Date: Wed, 11 Feb 2026 13:53:01 +0000
Message-ID: <1a24208b2136553b30e2a6048cae6ff7e4e16842.1770817884.git.anatoly.burakov@intel.com>
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

Currently, when configuring RSS (redirection table, lookup table, and
hash key), we are using rte_zmalloc followed by an immediate rte_free.
This is not needed as this memory is not being stored anywhere, so
replace it with regular malloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 4 ++--
 drivers/net/intel/iavf/iavf_vchnl.c  | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 70eb7e7ec5..d3fa47fd5e 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1554,7 +1554,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
-	lut = rte_zmalloc("rss_lut", reta_size, 0);
+	lut = calloc(1, reta_size);
 	if (!lut) {
 		PMD_DRV_LOG(ERR, "No memory can be allocated");
 		return -ENOMEM;
@@ -1574,7 +1574,7 @@ iavf_dev_rss_reta_update(struct rte_eth_dev *dev,
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

