Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E82E9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7DE34042F;
	Thu, 19 Feb 2026 17:23:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5C5A340684
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518219; x=1803054219;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aIDXmRPm9mUgJgSzT0/Cl6AnojAeMvpXUEx5ulSTS1Y=;
 b=eb9MrIAqt8+LUr6c/2JVd2a4yo/laURsUP5I1eb3h8AJqvuKgNK5MbIu
 0uPh5nMvHbdye+yZ86B0lMhAdVne2xz3nsM6BMWTBhwCCvwWIWVTVLzhm
 bF4xiVBgwH1OWOmNMyhZyoK+Y0wMcl/+PIItPRJyJguqWKyumoYXGP7bc
 /5NF3KXgboagWxkXKCjunqUl4CpTg5tmyySLgYvEeKxAZnCwlkG8k4lHr
 OXlE4B2GFSQ90sMR3XruyKsIM1/bZGVRPN5ImdG4w5EyxATG+bmYo3akf
 OYfdL1SjUFsUeChaWXAUvS90QQz4fmAH1vd232otOFgJ7HsfDT2dl0N0s w==;
X-CSE-ConnectionGUID: b+0bnGerR+Wtm0VmrpJACw==
X-CSE-MsgGUID: PF636SH6Q5GnKaCrRkoOeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231456"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231456"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:38 -0800
X-CSE-ConnectionGUID: d/M2xAnjRUeGq8xVLXwgaQ==
X-CSE-MsgGUID: HYmDNyp/RXSRkpVid2nlKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699925"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:38 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v6 19/27] net/iavf: avoid rte malloc in RSS configuration
Date: Thu, 19 Feb 2026 16:23:02 +0000
Message-ID: <951e0f840485661bef27f28ea707740d4df8f652.1771518103.git.anatoly.burakov@intel.com>
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
index e978284bf2..f74a0cb21f 100644
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

