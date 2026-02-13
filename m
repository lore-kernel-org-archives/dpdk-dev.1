Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47487EDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:28:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED157406B4;
	Fri, 13 Feb 2026 11:27:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F112A40431
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978424; x=1802514424;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=L2JbbECeKjNdzt1A0ekdFvPkp1R0uJ7jTa/ad/ZlAQ4=;
 b=SA7kOa2521LCWX0FfbCYSV6UglR0P2s/UT3dQPC8VrSCVME9+HIGH3Mu
 AjBFg/rUV0yOxMWNJeTmXLEXV3+S2NrreyeCZC28wWSfrY/HAxeh3mG+y
 F/2n/Rh2wwXMpleRWf6cca+fzyxA68wzs6JtRoND+qf5sdLRcG5wELC+o
 HtU9mkgkb1AcBSiKGcGfiJ7DH2n7pnb5+zRYKI3uDHy1MkW9kZ+a3S7+Q
 9Gy0VkdSk5wx4ubu/9IULQUkShqQBX1qAJYX3Yb9FhRqoOkL2PJzy1ofU
 PPIL31v47GAnkzrgfW87rkwwKRCImzLfttH5BZHTiIqIhP1f21p44Cd/N g==;
X-CSE-ConnectionGUID: jrg87FJITlKHoDj7SA1BIw==
X-CSE-MsgGUID: Q+feBwDQQb+oIrnRupuRyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603087"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603087"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:03 -0800
X-CSE-ConnectionGUID: rlccPJgXSHu9fnSdKnyT/A==
X-CSE-MsgGUID: EqwYRAOtTpmH1SRLMqYcRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028077"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Date: Fri, 13 Feb 2026 10:26:21 +0000
Message-ID: <31787437b2b25f055fae608dcf78fb0980940aab.1770978324.git.anatoly.burakov@intel.com>
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

