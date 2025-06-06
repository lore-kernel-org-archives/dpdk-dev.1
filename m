Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B332C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:10:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB17840BA0;
	Fri,  6 Jun 2025 19:09:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C9B6640DD5
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229786; x=1780765786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yYHfG1HaywZNktZPAdy3vNiRimDV384wweEFNKdX++M=;
 b=Xvrw2bKIXPf3fV3OixLEhEWI9E4foLCHi+njM3qCZGxwt4x+ECJQPS3B
 ZN3iqvH/quRAViZdMv3PLxQJRrSdkVwQFZW/e+h/dV5CAbhBpJ/dSAxKM
 2kKuLYKb+WnTLYenbf1AHnefEoIQsGZgxTmrz5jhgfw/WbZuZ32164I6U
 PvsChwll4hyBNukM8wAvhXwEyz1H3ou9wN5vNFECZvQwbPXc2gRGDB2f1
 imY0uSUY9ya51ZYj/nPf1hMTGbYSRi0f+hdqB1bp2qmtIDwaSSQzi8w5e
 mpOqRSM7/4bDxOcYoVLXaXtPMmf9TeTve7ItOU7ZMM1AhMQPm0qswPRE0 g==;
X-CSE-ConnectionGUID: Lygynz5rQaiaC3Gz0m1/Pw==
X-CSE-MsgGUID: Wk6rxpBOTQKu7Bqy+YBeoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828421"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828421"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:45 -0700
X-CSE-ConnectionGUID: qMQJxI62RlKLbbV/lyWBEA==
X-CSE-MsgGUID: iPyjAmyHTqWQD0AzfSO0wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808169"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 10/34] net/ixgbe: adjust indentation
Date: Fri,  6 Jun 2025 18:08:49 +0100
Message-ID: <34b198c37a77842b6d721a6e6e1264b9f0404c67.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749229650.git.anatoly.burakov@intel.com>
 <cover.1749229650.git.anatoly.burakov@intel.com>
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

There is wrong indentation in `ixgbe_set_tx_function`. Fix it.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Add this commit

 drivers/net/intel/ixgbe/ixgbe_rxtx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index f75821029d..8fbb795097 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2682,8 +2682,9 @@ ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq)
 			dev->recycle_tx_mbufs_reuse = ixgbe_recycle_tx_mbufs_reuse_vec;
 #endif
 			dev->tx_pkt_burst = ixgbe_xmit_pkts_vec;
-		} else
-		dev->tx_pkt_burst = ixgbe_xmit_pkts_simple;
+		} else {
+			dev->tx_pkt_burst = ixgbe_xmit_pkts_simple;
+		}
 	} else {
 		PMD_INIT_LOG(DEBUG, "Using full-featured tx code path");
 		PMD_INIT_LOG(DEBUG,
-- 
2.47.1

