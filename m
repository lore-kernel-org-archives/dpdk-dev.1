Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B5CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 14:11:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9055F40A72;
	Wed, 12 Nov 2025 15:11:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 78B9C406B6;
 Wed, 12 Nov 2025 15:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762956667; x=1794492667;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rdWAI6wVIa7McQBpu6nsBf8kLqVbhX+iHNaEkcmsmCo=;
 b=m/fvXMR/by8koVvpSTVY4I7g3sEky7V/3s+La9JZa9kEQHcC36vOQSLw
 6ux7r/68JwjxQWH0UcD8lzCWjU7anMPS3z+awJrPQACOc/QegUH/Mzo4P
 dTwPeEF9PfSIQcryQp1p/lAoLqKXDn+00EbeshXsUWCeVbVufFu/YohNE
 M8J4i2I0bFDoU4RjOpVgfB8manwSnfbyC4yfRgpr8/FWy4yCw40AKR/eO
 kmFVwWdYlL1gJ70+A1zaE7PeYg8RqyS6TQCKzVqNRPW804pbaLTxkypdT
 E7Syu3AtB6fDctBWwczOx+3NX2IyfNaoTHpTA25Zba8yKyDiHv3MoWSP3 Q==;
X-CSE-ConnectionGUID: DP6DgM5LQY2TcatzvhLdOw==
X-CSE-MsgGUID: wyC9nH60SESqVoGebbpatQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82415960"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="82415960"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 06:11:06 -0800
X-CSE-ConnectionGUID: j9f+cTsYSTKDaHK3qLE9Pg==
X-CSE-MsgGUID: sEe1wtnFSK2oem+h6tJA0A==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226500129"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 12 Nov 2025 06:11:05 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Sunil Kumar Kori <skori@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v2 2/3] net/ixgbe: fix null packet prepare function
Date: Wed, 12 Nov 2025 14:10:58 +0000
Message-ID: <20251112141059.1576919-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251112141059.1576919-1-bruce.richardson@intel.com>
References: <20251110122457.2575615-1-skori@marvell.com>
 <20251112141059.1576919-1-bruce.richardson@intel.com>
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

As per recent change by the following commit:

commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")

framework unconditionally invokes dev->tx_pkt_prepare. Ensure
dev->tx_pkt_prepare is not NULL when vector or simple TX paths are
selected, by assigning rte_eth_tx_pkt_prepare_dummy.

This aligns with expectations with above mentioned commit.

Fixes: 7829b8d52be0 ("net/ixgbe: add Tx preparation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 897ee2b671..a7583c178a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2653,7 +2653,7 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 #endif
 			(txq->tx_rs_thresh >= IXGBE_TX_MAX_BURST)) {
 		PMD_INIT_LOG(DEBUG, "Using simple tx code path");
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		if (txq->tx_rs_thresh <= IXGBE_TX_MAX_FREE_BUF_SZ &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128 &&
 				(rte_eal_process_type() != RTE_PROC_PRIMARY ||
-- 
2.48.1

