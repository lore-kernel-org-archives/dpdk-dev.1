Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA94E6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:16:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D87340BA6;
	Tue, 17 Feb 2026 13:15:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id D637940A75
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:15:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330501; x=1802866501;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZJjRF0L+9jwpPyf8EIrVm/M0vJKDhKUuTbpFlKne7zs=;
 b=mSqPwRpYkcBidoYJQ64yRGJj+pYsxxlFCK97xNilfMVCoDAwS9F9KM+W
 StALRxdHydifI/s8mifKU4ffxuwaHG3QVSIm1zsts9OyeY3JQEOwcTTC6
 ROE98Cbng3cLgMBRsPGkB0bUAnB8TtaSUq2nmjFk6x37WhGlRkv+f8zgG
 yLlpe6Pvo2cgKwRfoEULfMHmO2khizmTT8/A6YT975uZvxaAQLcFppNCs
 oMJqmvFzHe4XVUHi0P0W2v/9WSYV752Ont8OlegfhD8cYbTpJHQkUXUMO
 YnnT2uw7WmHJeVs0KuJqn1rNTQjficBLSiMelWkWxHb3GE+ckbuAWVse9 g==;
X-CSE-ConnectionGUID: d0WPAKX4RMGJMeHP75LGQQ==
X-CSE-MsgGUID: pPeD4htVTkKLRerwzeg51g==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996047"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996047"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:15:00 -0800
X-CSE-ConnectionGUID: 2lyiJT6jR8CPEEoVcFvi8A==
X-CSE-MsgGUID: 6cG5MmUrQSOnuJNKTv453w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396830"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:15:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v5 19/27] net/iavf: avoid rte malloc in RSS configuration
Date: Tue, 17 Feb 2026 12:14:08 +0000
Message-ID: <488c803b331811adc38e1067c6ac1e6947ba89cf.1771330391.git.anatoly.burakov@intel.com>
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

