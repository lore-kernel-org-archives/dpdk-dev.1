Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC076D25B44
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 11:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E222402E7;
	Wed, 28 Jan 2026 12:41:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id A17AE402EA
 for <dev@dpdk.org>; Wed, 28 Jan 2026 12:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769600483; x=1801136483;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TZDuXU3+XbFVbuEUBp5iXX2WYrWdFGMVugXOq+meRxY=;
 b=WooK1wszN9Mrbs+38tKQQ46Ak8nd9JQNqPGXv485eXuHbfXJtAHXj/JE
 NJ2xcWjFLcQm0rsffs3xFdOwIcnTjdhLGNGkiqEJED2xTGpd8RBiVT21R
 MiW+tsjmIoBNMeuOdnSNpAsULsC2sO5FuVbRY3TxHjoeB9jpoEBV7G0gi
 uWbYiIDto68JKY/BFrRIOKZ/zkRN/hiUKxjcIXdWtWkjtv0gPE7PjYAxX
 lWArm+ku+Qy9Fvv8yZMmgDe1p5wXPwMWgGZkqra91HZlRPaZ0XHhKC5wW
 uqmT7HrUdo3MFby6AiqRzs08oOkgRwePeDnpXsHBA0SrhjI3Ycx1gtb8x Q==;
X-CSE-ConnectionGUID: 6fmEg4vQRDielSYHVf5pfw==
X-CSE-MsgGUID: aWwvlEWVR6G5f00MsugQ8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69825796"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="69825796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 03:41:22 -0800
X-CSE-ConnectionGUID: 2Di28sGcRbK5ruAUct6UHw==
X-CSE-MsgGUID: Z3qrCLJCSXqNaRYLl3DOTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; d="scan'208";a="208264259"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa008.jf.intel.com with ESMTP; 28 Jan 2026 03:41:21 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/ice: ensure correct vector flag after reconfiguration
Date: Wed, 28 Jan 2026 11:41:10 +0000
Message-ID: <20260128114110.39253-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

After configuring the Tx path to be used, the ice driver sets the
tx_vec_allowed flag if a vector path is chosen. However, on
reconfiguration, the flag is not cleared if a scalar path is chosen,
leading to crashes on driver shutdown as the wrong cleanup function
would be used in that case. Fix issue, by always setting the flag to
true or false explicitly.

Fixes: d3206e40c435 ("net/ice: use common Tx path selection infrastructure")

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 59ff4c31c8..816733819f 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3721,8 +3721,8 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 						ICE_TX_DEFAULT);
 
 out:
-	if (ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256)
-		ad->tx_vec_allowed = true;
+	ad->tx_vec_allowed =
+		(ice_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_256);
 
 	dev->tx_pkt_burst = mbuf_check ? ice_xmit_pkts_check :
 					 ice_tx_path_infos[ad->tx_func_type].pkt_burst;
-- 
2.51.0

