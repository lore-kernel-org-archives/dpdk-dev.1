Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3605FCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 16:41:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B01B4111C;
	Mon,  5 Oct 2026 18:39:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id B88E640E54
 for <dev@dpdk.org>; Mon,  5 Oct 2026 18:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791218348; x=1822754348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=VUC7KFx4l9wV1xnHXqvtxmI3IorMff0R9ja1XEAp7a8=;
 b=cA3Lr+1hcZuQUbFkzj0hsyZx9Lz8P2q6on4cqopoZPVcuRGf/JJr2Kt5
 r/7MBM3ZHxjOlJEEWFCdq6Gz6damUMgB96MAn3eOCDPhVGu3FESnkvQg2
 wCvVrBSKyrW7NX3GnCwul6McdOpkf/B7icLt+YecEl1hFsMEAfpMeGyHa
 r7kNaxnJYbdE2HxUQeIa6n6/JPrHVexaRZobSTaN0aPek7BGOqznZqe+N
 2V/e9a+mnvJLlr4Ji4HKyie+Amckrrfz8CvXAEhrHGPrrpOi/+LatjQDi
 2mLk+prnPpYw8HEKznpwOqAg6NScYHB0FbFWHSm/5/rfBdl3jmO9hgzlJ Q==;
X-CSE-ConnectionGUID: auaL3eiaSm2gkZoY8qjbVg==
X-CSE-MsgGUID: xgkN8zCiRc+Q1DEsW2YSvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="90665376"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; d="scan'208";a="90665376"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2026 09:39:07 -0700
X-CSE-ConnectionGUID: wMwRo39MREmlcCTeishw8Q==
X-CSE-MsgGUID: FLvvGIp4RxOtmfHS0ySlOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="945858"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 05 Oct 2026 09:39:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 24/24] net/i40e: advertise flow keep capability
Date: Mon,  5 Oct 2026 17:38:19 +0100
Message-ID: <e89ccbb4b65007a28e70e50b4dd8ed3b1ee0e2c2.1791218157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791218154.git.anatoly.burakov@intel.com>
 <cover.1791218154.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 doc/guides/rel_notes/release_26_11.rst | 5 +++++
 drivers/net/intel/i40e/i40e_ethdev.c   | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index f4d88938bc3..e9e9fdec9cd 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -109,6 +109,11 @@ New Features
   * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
     as flow rules were already kept across device restart.
 
+* **Updated Intel i40e driver.**
+
+  * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
+    as flow rules were already kept across device restart.
+
 * **Updated NXP DPAA2 ethernet driver.**
 
   * Added the inner IP header to the RSS hash so tunneled traffic is
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 932e8b2674f..226f4819c3a 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -3631,7 +3631,8 @@ i40e_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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

