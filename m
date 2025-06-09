Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A76C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:39:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59FE942794;
	Mon,  9 Jun 2025 17:38:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E80054278E
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483483; x=1781019483;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WkeOksPvEHN3GAJlCulS0FoxRGdAjYoRDWA3vbh8ZqE=;
 b=NlB5Ggm4bsHbQq2MuKvFaivqJuTsVq2mOXI6Vi+Enmpfd9iENbd5WlXO
 YlF33mwu++WzA804xicpH++jfSnn+RBvfKl1C8W8Nefv8lWtnrwbTXIzO
 i3tqsRpndxDTbxFsf7wSYqSteePEUs2Wy8jz9u232mv8Zhgd+xlPb1YjH
 cNSmeKmTNuDdkUBE+mKxHQ45jGRxxpfWjk2sk+JbIX6hAx286xbJN8kW3
 o75pa7RO3/uuxdTYs+7Oj8etdCFcFnYq3GrhLwB/js6mBeP88jV98gx6S
 JuDobqA3ZYu7ND0Y+rfuXDdvZz3oiJdTIioN6XLY+1s5KZY5F57PapsQY g==;
X-CSE-ConnectionGUID: xdi8ycptQvmo6fbUPiXqng==
X-CSE-MsgGUID: JxG31dOlQGO2cT8KtdEVYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012173"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012173"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:03 -0700
X-CSE-ConnectionGUID: Zg3Mi2esQROyNGpcwIMwXA==
X-CSE-MsgGUID: kjZdDMIDRWWTd7PvoCUGMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419628"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 10/33] net/ixgbe: adjust indentation
Date: Mon,  9 Jun 2025 16:37:08 +0100
Message-ID: <c28049f8bfce2c4040b27ba18f1284b9166f5925.1749483382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749483381.git.anatoly.burakov@intel.com>
 <cover.1749483381.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

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

