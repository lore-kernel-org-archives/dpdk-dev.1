Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6306D109B463
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 026FB40B8C;
	Tue, 31 Mar 2026 15:02:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 5238040A89;
 Tue, 31 Mar 2026 15:02:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774962147; x=1806498147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u3YefqiEurOlEzewNG0JPt0bFoVuDKTwKTuYRWwwxLk=;
 b=nQzA9kqxot+b1M0Vm40BbtuZL3g7ThWKRpKb6G35z7puhXcseVfEjwX9
 Ghg36oVWrzPmuml3RKZkPzMKDdcwcc6pHXM0YREG0oUnNMxDd1WqOZAT0
 izPD7h8TCjiskiHRBVfsVaNFEsgL/UODc1aJhcDKOTOENtd4pp9FC9Pqf
 hogTNEPo7Zv0vcQlZ4QbJIKF5DCSJ29HP2nnMxnMud+jXMMQXRNGcylMl
 TqDmAqjHmNmNamwkTTUIfAseHz7mWFmvFcSHbFS6Donnw/9+fRq1WYEBD
 iXxgpqL7NS2Uw1ZvBQ3bFACqOviIwTzebSY23NSXn3w/PUjsTeezMBApH Q==;
X-CSE-ConnectionGUID: DFe22BUyTk2nPgGc6Rx8wA==
X-CSE-MsgGUID: 2UIbtoOVRNybNd59O4Wm1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75868440"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="75868440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 06:02:26 -0700
X-CSE-ConnectionGUID: UXl2vIy/TUKkVO//J6pMGQ==
X-CSE-MsgGUID: d9OiunLDSJGkFh4PSDxV/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="223481814"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 31 Mar 2026 06:02:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 4/4] net/iavf: fix reset handling error log
Date: Tue, 31 Mar 2026 13:01:20 +0000
Message-ID: <20260331130120.2471971-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331130120.2471971-1-ciara.loftus@intel.com>
References: <20260331130120.2471971-1-ciara.loftus@intel.com>
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

Commit f665790a5dba ("drivers: remove redundant newline from logs")
intended to remove the newline from the log, however an unwanted
character was left over. Remove it.

Fixes: f665790a5dba ("drivers: remove redundant newline from logs")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 111bfa1934..cf98d7e5e9 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3204,7 +3204,7 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	goto exit;
 
 error:
-	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%dn", ret);
+	PMD_DRV_LOG(DEBUG, "RESET recover with error code=%d", ret);
 exit:
 	/* Call the post reset callback */
 	if (vf->post_reset_cb != NULL)
-- 
2.43.0

