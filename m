Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B82C8303C
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Jul 2025 21:54:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E86944028B;
	Sat,  5 Jul 2025 23:54:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5E23C4025F;
 Sat,  5 Jul 2025 23:54:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751752465; x=1783288465;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1oWSRKTiDq36IbRly+VDCHe4xLdUpDLPMARcApcYIDU=;
 b=bHFv2j/a+CByICOL5R/7+raH/Unc0nt2b+tnlgTW94jM70qsY8Y9tGeP
 KeVUZlHS2JDFcTQGKZyMUsEopbru+n6+7iAfhMLCxt8ip9tkPMGie2XxK
 45Yimd+TI+efkDia4tV5bWne5Ct+wKqkVbDf+fEMyVclTcZmji2XWKkoQ
 QhpT3+lQOsqUdr2O4FKUS8sDxP6RPCanQ+2zz+wO6t4T8holi8M8ku1Y9
 gYKDtdIDvLtUTKNHY1GXkGI8nIABgvlqbh/IN0lsRAFXovp0KRKyoKz0U
 8bfqsyhXaBK3tIE6UoWZX5hinQ0mhmnYR0O8cjZig4CNVRHO0ZBbdNJ0Y w==;
X-CSE-ConnectionGUID: 52YnN1j6RaGY43Xixl9s3w==
X-CSE-MsgGUID: RcccNo7hQvK1vXWFxMdyVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11485"; a="64622121"
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; d="scan'208";a="64622121"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2025 14:54:24 -0700
X-CSE-ConnectionGUID: fiRxsNVwRjOBIv04bBorog==
X-CSE-MsgGUID: FM6+TFXkTue9SgbADJ+zUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,291,1744095600"; d="scan'208";a="160422696"
Received: from silpixa00401120.ir.intel.com ([10.55.128.58])
 by fmviesa004.fm.intel.com with ESMTP; 05 Jul 2025 14:54:22 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Kirill Rybalchenko <kirill.rybalchenko@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Cc: dev@dpdk.org, Dhanya Pillai <dhanya.r.pillai@intel.com>, stable@dpdk.org
Subject: [PATCH] net/i40e: fix missing support for RSS IPv4
Date: Sat,  5 Jul 2025 21:54:07 +0000
Message-ID: <20250705215412.200958-1-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
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

Currently, i40e driver is missing support for RTE_ETH_RSS_IPV4
flag. Configuring rss function to RTE_ETH_RSS_IPV4 returns
invalid rss hash function value.

Fixes: a286ebeb0714 ("net/i40e: add dynamic mapping of SW flow types to HW pctypes")
Cc: stable@dpdk.org

Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 0b06130fe5..aba3c11ee5 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3657,6 +3657,8 @@ i40e_set_default_pctype_table(struct rte_eth_dev *dev)
 	ad->flow_types_mask = 0ULL;
 	ad->pctypes_mask = 0ULL;
 
+	ad->pctypes_tbl[RTE_ETH_FLOW_IPV4] =
+				(1ULL << I40E_FILTER_PCTYPE_NONF_IPV4_OTHER);
 	ad->pctypes_tbl[RTE_ETH_FLOW_FRAG_IPV4] =
 				(1ULL << I40E_FILTER_PCTYPE_FRAG_IPV4);
 	ad->pctypes_tbl[RTE_ETH_FLOW_NONFRAG_IPV4_UDP] =
-- 
2.43.0

