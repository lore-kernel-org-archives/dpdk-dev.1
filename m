Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11DFC61CE8
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:13:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2076B41133;
	Thu, 12 Jun 2025 13:12:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8D69F410FD
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726732; x=1781262732;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WkeOksPvEHN3GAJlCulS0FoxRGdAjYoRDWA3vbh8ZqE=;
 b=JehWt8dOlvkXBU/+n/B36SwaAJtCaMbc9KZmuDU2jlbn884zKAimbgeA
 QqIw9Lp6PGPmUvwu23NW29H29GZUUc6L/Cw4yRcY68LlCPvcCybY/Ta7X
 HRwlQMLUYLCC3k13Y+dMXiuYgn5KeqVOUoeP4iELlJpNVBaTIh+sRE93K
 SJTF2OLCxwYRrj7iVTxqKfPSh8JcC7PIO/Gf313ED8KSwwi4Z8TMlPVcD
 4W5ZHUK7YW813Woy/LBsaYrsA+0KS06x4EhSZ/wULTE61sREKcJp1Vq2r
 fbu7q7NHdosilvUJK0UT+zg63HKW4oyr3TYQSZQIBVGSVX4Zq1EsEyIOH w==;
X-CSE-ConnectionGUID: YPX2XgQYQ/GVLIVlkh5FNg==
X-CSE-MsgGUID: yZXgn3ihR8K+t+TpOrHIIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177550"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177550"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:12 -0700
X-CSE-ConnectionGUID: U6A48GfqTIepinfba72zGw==
X-CSE-MsgGUID: 6hQCpEMXQOqzU6fWhzg+Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371333"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 10/33] net/ixgbe: adjust indentation
Date: Thu, 12 Jun 2025 12:11:16 +0100
Message-ID: <5cd1a275650664acabbbb6e6cb33757b76f8cf01.1749726639.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1749726639.git.anatoly.burakov@intel.com>
 <cover.1749726639.git.anatoly.burakov@intel.com>
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

