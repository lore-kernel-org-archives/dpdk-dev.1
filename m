Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28D4C678DA
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 15:38:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DB7142797;
	Mon,  9 Jun 2025 17:38:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 82EAE415D7
 for <dev@dpdk.org>; Mon,  9 Jun 2025 17:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749483482; x=1781019482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e65+CW+oRr+mmfLVocqYXU65BN2lSvN45H3HYpJDGlw=;
 b=fcDYTWl5gKRC7GnBzjFpYC7c4GW3oo7PgI3EzAo5VqcD6CdbzVKmi1Ak
 RDSm8NlHQRt7h4Hj7Yw2cjDIhjv0QULcwZJRu9kjOrbXu97sLCq0PQ0eP
 GXwNunAqlFErX+M3ifaQ2xpxbMUjlu+RNzVtkHlR/4ZE3TG0I79+jt9hS
 IB/jqZDwFkjoLo38+cbobs+UZlgReBCi50xq+ZRS1YWlfMj9xaOhSa3Bi
 GB6UiNnXTVwvK9bdSTOXBDx/AeF2s5SzAsrFpzDduE3CVt7/5QlFS6nVN
 xd2l0jOcwFVrvwP3rOfXkh8V0gyzDlWBDk+4rEz+0EsI67hZ2YyHMOpOx Q==;
X-CSE-ConnectionGUID: 7NxTfX77Q/m7nD4PsxzoRA==
X-CSE-MsgGUID: DAMta4rNRkqs+56Ad+2mpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="69012170"
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="69012170"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2025 08:38:01 -0700
X-CSE-ConnectionGUID: ZoSQlxVqSyGsSiGafgb80g==
X-CSE-MsgGUID: yxGEG2DSTVawQSr16XmDtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,222,1744095600"; d="scan'208";a="151419618"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jun 2025 08:38:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v6 09/33] net/ixgbe: simplify packet type support check
Date: Mon,  9 Jun 2025 16:37:07 +0100
Message-ID: <45137f4f58c1eb9e5fd3e5cc31ed802209d491ad.1749483382.git.anatoly.burakov@intel.com>
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

There are no differences between scalar and vector paths when it comes to
packet type support, and the only data path currently not covered by the
check is the VF representor path, because it's not meant to be used
directly anyway. Simplify the check to reflect that fact.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---

Notes:
    v5:
    - Add this patch

 drivers/net/intel/ixgbe/ixgbe_ethdev.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index f1fd271a0a..928ac57a93 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -4067,21 +4067,14 @@ ixgbe_dev_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		RTE_PTYPE_INNER_L4_UDP,
 	};
 
-	if (dev->rx_pkt_burst == ixgbe_recv_pkts ||
-	    dev->rx_pkt_burst == ixgbe_recv_pkts_lro_single_alloc ||
-	    dev->rx_pkt_burst == ixgbe_recv_pkts_lro_bulk_alloc ||
-	    dev->rx_pkt_burst == ixgbe_recv_pkts_bulk_alloc) {
+	/*
+	 * Currently, all Rx functions support all packet types, except for VF representor Rx
+	 * function which has no data path and is not meant to be used directly.
+	 */
+	if (dev->rx_pkt_burst != NULL && dev->rx_pkt_burst != ixgbe_vf_representor_rx_burst) {
 		*no_of_elements = RTE_DIM(ptypes);
 		return ptypes;
 	}
-
-#if defined(RTE_ARCH_X86) || defined(__ARM_NEON)
-	if (dev->rx_pkt_burst == ixgbe_recv_pkts_vec ||
-	    dev->rx_pkt_burst == ixgbe_recv_scattered_pkts_vec) {
-		*no_of_elements = RTE_DIM(ptypes);
-		return ptypes;
-	}
-#endif
 	return NULL;
 }
 
-- 
2.47.1

