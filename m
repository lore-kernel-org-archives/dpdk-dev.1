Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADEDE6817B
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:15:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8702A40A6B;
	Tue, 17 Feb 2026 13:14:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 288B940431
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330490; x=1802866490;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=d68qu7kr/SMBwCl4cULxEiJo8ZI4bNVqN7E1kBYCfbE=;
 b=P8UenZ7/Nb577qYIBf0MiAnkkpQF1FJW0wpmAf+okZcx2jWDf5me5adi
 D8JPcl6ZK5QfI1boCku+1Ap1Vi4qcmYQwILKWSgcNe3XsvK4HG8puypb1
 lY7f3i6J/80BXxSOfafuJMOKbhiqVyViH+9KiFgpHKZUDEsoGPO7hbino
 jTXugx5SNy3J81xyvcVDkAsxtOm/aVuvDpRSERuiQDJmJpLFbpa+9ir7d
 z8OA6el5iCwz9jiPuqKHslJwFrDR3knrgkQV2Z2Z0cdxDIj+y6mUL+rE+
 aw4WSYgIMIOtuPU0QAYEPrsTW77GePBpv0xE/aBSuSfekPfZN31WmAIZ2 A==;
X-CSE-ConnectionGUID: fD6CsKdRR0mIkmlJaP9Mpw==
X-CSE-MsgGUID: Q30K+u4kSCqHhp2SdkYT0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996029"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996029"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:50 -0800
X-CSE-ConnectionGUID: 41isGD4tTQ+Zxi0ltrar5w==
X-CSE-MsgGUID: cQv7fvoJSPeM15M/8hvZaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396797"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:50 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 10/27] net/i40e: avoid rte malloc in RSS RETA operations
Date: Tue, 17 Feb 2026 12:13:59 +0000
Message-ID: <54caed108d52866d602a9583b37e0d019b8ef736.1771330391.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/i40e/i40e_ethdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index d3404d7720..23a8f625ef 100644
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

