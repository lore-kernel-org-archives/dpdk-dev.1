Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF10CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 15:05:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35FC0402A8;
	Tue,  4 Nov 2025 16:05:15 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id A19C240269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 16:05:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762268714; x=1793804714;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/5CXog+P433sNUa1NKE+eWmjCQdL4v8vp18mi2E/phY=;
 b=Iv5wu4EIMT4bjAHcWocTOo8EQf/IOknjuBxNmUOqdSJ9GoaQfnDaUJwX
 vT3XGA+kwm5FZ7c4PTsTUDo+eqE1NRt9ru8+/uzbZwYKtCO7NdmFFJEIV
 xpMo8vNez6yE+NeFAFR9vc0TQNE5WT0BhNFqwgibKqPY6kFPipwF1BeLW
 LY5LjCQLe9WYNRsS+Hy0I81MTqhk5Mjx1hD/VdnQOmj3YSVV94GnwKlwF
 JhBwtJ1JkSmMxBKgFYz9P1dxhwBaHkYNbXFjlSvqk0TfLhxRW1ugJ0USV
 TQHUOTrlGRalx1LOlE7yWU6kbUAa+TpcpBuAWnL2HWuj1kPdxnLQCj+Xl w==;
X-CSE-ConnectionGUID: rAbRhNFaRBCsYXoVu3B4wg==
X-CSE-MsgGUID: R1Nu96qGTnaZHU/3WTsJqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64292175"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64292175"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 07:05:12 -0800
X-CSE-ConnectionGUID: cdHR5Z5UTRiP0kMVyvvdXA==
X-CSE-MsgGUID: hTShbPItRyCbMTisT4GEZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187484315"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2025 07:05:11 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Cc: aman.deep.singh@intel.com
Subject: [PATCH v2] net/ixgbe: add E610 NIC speed support
Date: Tue,  4 Nov 2025 20:31:13 +0530
Message-Id: <20251104150113.729184-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103133804.585506-1-shaiq.wani@intel.com>
References: <20251103133804.585506-1-shaiq.wani@intel.com>
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
speeds (100M, 1G, 2.5G, 5G, 10G) in the ixgbe driver.
Previously, E610 was not explicitly handled.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>

v2:
*removed 10M speed since E610 does not support it.
---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index bfc091c367..89a799762f 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -2797,6 +2797,11 @@ ixgbe_dev_start(struct rte_eth_dev *dev)
 			allowed_speeds = RTE_ETH_LINK_SPEED_10M |
 				RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G;
 		break;
+	case ixgbe_mac_E610:
+		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
+			RTE_ETH_LINK_SPEED_2_5G | RTE_ETH_LINK_SPEED_5G |
+			RTE_ETH_LINK_SPEED_10G;
+		break;
 	default:
 		allowed_speeds = RTE_ETH_LINK_SPEED_100M | RTE_ETH_LINK_SPEED_1G |
 			RTE_ETH_LINK_SPEED_10G;
-- 
2.34.1

