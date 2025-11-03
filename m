Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5641CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Nov 2025 13:38:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01EA240285;
	Mon,  3 Nov 2025 14:38:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id C94F940281
 for <dev@dpdk.org>; Mon,  3 Nov 2025 14:38:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762177110; x=1793713110;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=82c3nI6jE4jd731TsgKR39XelmUGVFYotY87tSrzkq0=;
 b=AExHvk8TbAgsMoHKBCPZSXw6C4BWBrqE/2f89HQpyz/Qg4Z4QBB1TRg+
 FM7MZreADim5kwwxafaIBA6EVZobCdqOt737zXgfXF8U+AYWzN/nRJxuK
 I5Qfzy/YFBSiMfI3PM82mE8I5d+iKk5d67ht8BTEKqHie+lpqVNlzFg27
 iy4u7kg9tvza5tZwbiETKT/1ex0lvbz6M8j71rAhO3tOgsAfSnwhtvzta
 l5LBHGYNldtERkm9mxHSzKnPS880aOxFFK148WnE8KKJ2Jy2AH9Qf98FS
 19vv47LGLcr7Up0KNH8rMpSTzdctDdRsM5K6oJjVHv/zQtk8Z7TM+Nkxp Q==;
X-CSE-ConnectionGUID: VF50jUpuQwyN+nnF6js1aA==
X-CSE-MsgGUID: J/xqu4QST+C0coVcb+Q03A==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64289486"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="64289486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 05:38:21 -0800
X-CSE-ConnectionGUID: GpRQnm9BSLS3yuDjLquerA==
X-CSE-MsgGUID: U2vhydSjROqMsKakrVaDLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; d="scan'208";a="186108721"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa006.jf.intel.com with ESMTP; 03 Nov 2025 05:38:20 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH] net/ixgbe: add E610 NIC speed support
Date: Mon,  3 Nov 2025 19:08:04 +0530
Message-Id: <20251103133804.585506-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
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

Added a switch case for the E610 NIC adapter to set all supported link
speeds (10M, 100M, 1G, 2.5G, 5G, 10G) in the ixgbe driver.
Previously, E610 was not explicitly handled.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index bfc091c367..c01f53d8ad 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2797,6 +2797,11 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 			allowed_speeds = RTE_ETH_LINK_SPEED_10M |
 				RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G;
 		break;
+	case ixgbe_mac_E610:
+		allowed_speeds = RTE_ETH_LINK_SPEED_10M | RTE_ETH_LINK_SPEED_100M |
+			RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
+			RTE_ETH_LINK_SPEED_5G | RTE_ETH_LINK_SPEED_10G;
+		break;
 	default:
 		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
 			RTE_ETH_LINK_SPEED_10G;
-- 
2.34.1

