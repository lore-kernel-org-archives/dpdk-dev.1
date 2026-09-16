Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F56C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04F6342F7A;
	Wed, 16 Sep 2026 14:19:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 52CB142EF9
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:19:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561142; x=1821097142;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=QIvEwcmZWYS4SvcMuW81TpVyT2Opn0nf/SNZ8FhdHkk=;
 b=TGbPWGebQjoOc28skUe8i8o9uMdypaZHLGkbuBmxQwzhNAzCstcROHVL
 sociUgjbHKvigCEuj3YYhPQ6w+Ny4kXyMT/JOG/C4CXDBj0bFkPrTs4PA
 nUai8umy9ceiAoqGtJXbCGsxQaSj7bPvRP8eaTAzTCmDMsKQzvY11/aQ6
 SSKf+FjyQ5PqFL1+7jbhwKh7jxJkBZndVJFNnw1b8rfbiSWDSzuC9aXSd
 JTX8l7B/5qJktJzCenhTus1RzTRwuhlSuhrCdEsckzzXwl5hWjLx6eExJ
 nCh9KvgCemMzuMf280zP5Iv7x5wMe39Gqq49lmS7/0LrMBTRzizHy+A99 Q==;
X-CSE-ConnectionGUID: xswsT9gRTjykOqiAnizGuw==
X-CSE-MsgGUID: tbeOtKjQSsu+TvC8nDjlyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112702976"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="112702976"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:19:01 -0700
X-CSE-ConnectionGUID: wAxSkBDVSZmeG/VHYSXZEw==
X-CSE-MsgGUID: +4kqUTvDTLqZZM/nbHol1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="272850313"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 16 Sep 2026 05:19:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 19/19] net/i40e: advertise flow keep capability
Date: Wed, 16 Sep 2026 13:18:25 +0100
Message-ID: <3f39e844c2a4858092a67a4c79750d1048011e87.1789560946.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1789560943.git.anatoly.burakov@intel.com>
 <cover.1789560943.git.anatoly.burakov@intel.com>
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

The i40e driver's rte_flow implementation has always endeavored to keep
flows across device restart, however it never advertised this capability.
Advertise it explicitly.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index cca60e2889f..4e8a6a83b15 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3664,7 +3664,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->dev_capa =
 		RTE_ETH_DEV_CAPA_RUNTIME_RX_QUEUE_SETUP |
 		RTE_ETH_DEV_CAPA_RUNTIME_TX_QUEUE_SETUP;
-	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
+	/* rte_flow rules are kept across dev_stop/dev_start and replayed on start */
+	dev_info->dev_capa |= RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->hash_key_size = (I40E_PFQF_HKEY_MAX_INDEX + 1) *
 						sizeof(uint32_t);
-- 
2.52.0

