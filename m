Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2584EDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E709740B8C;
	Fri, 13 Feb 2026 11:27:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 4D88440A82
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978434; x=1802514434;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ZJjRF0L+9jwpPyf8EIrVm/M0vJKDhKUuTbpFlKne7zs=;
 b=C6/CQlDerUCRDTJJJHGu0vREBqF/KIrFMh7hAKg61u22vjBHC0ZJWhBl
 dTT0HKWgWgRXFn5R91O40mAr33CVGoy5DcoZbqTxqTPbtetnkn8DT97u5
 NtjUlRDJmZaykyEzKZbnW54OMT8fa0zBkmtAn6QQBkMfThuLvkM5/QUc/
 4AmJ8PnVCv13/wESS4S4pXDs7B3u9aMjEpS9pX//doUmfGTSZWDrLo0pt
 OrHLuO0Zpht97QeQOElRMNelbgo1ZBXacMI2riIPlXpSzz6whIuCluCrx
 0ecrgAs95iMNCsTyTgTO/iIcso5/EKgMHoAmuX1RaFTTAkC12I/bm7Y02 w==;
X-CSE-ConnectionGUID: z9RyMf5fTHy+f2rZ3mJVNA==
X-CSE-MsgGUID: sChn3FmdQ8+XJc/2viYw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603109"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603109"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:14 -0800
X-CSE-ConnectionGUID: 9H0hgEauTUexEeFQAbmqXg==
X-CSE-MsgGUID: taRZ35GIR+yXmcXEpm3Ccg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028121"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:14 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 19/27] net/iavf: avoid rte malloc in RSS configuration
Date: Fri, 13 Feb 2026 10:26:30 +0000
Message-ID: <e69a82ff71fb3cf38056a3882c915c73cd84a7d3.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

