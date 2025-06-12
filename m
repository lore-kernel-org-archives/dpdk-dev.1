Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03BBC71136
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 11:12:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12581410E3;
	Thu, 12 Jun 2025 13:12:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 539E3410FD
 for <dev@dpdk.org>; Thu, 12 Jun 2025 13:12:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749726731; x=1781262731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e65+CW+oRr+mmfLVocqYXU65BN2lSvN45H3HYpJDGlw=;
 b=JK9Itqj8e+aIG5JqSnOnMJmGtG3uqELRwAcNNmyVnIOpMyiBiRDxZFfa
 hUHI+3IWtYE70xaj6oh7pjg36JSkKsYwDi8MyCWgX0s5TQGfg1WZW7wva
 bWxM7M8FOm7R4HzvAu0iYMKfsPaCL8mzBgKv42lRPpwlM6IIPO0KuTr2/
 2CEPxZrO3zPkGigN8oxeVl9cusXCjCwfSfHnolekGOyObWmff51LFLHqH
 ZGwcATRm0R/QJIfnJRj8VnCckFonuaTrXNNTj5k4iFk4aeCrOm3Din1bI
 cGxU0fnjhl2YDzANu+DQDARxLFGhWN90un2uTH5MrIbKXqFGLLiOPr/Y6 g==;
X-CSE-ConnectionGUID: RtmwJZZGR2CHV+bHAcNRdA==
X-CSE-MsgGUID: 8hFHMhxbTEWb1el9E0rWNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62177544"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="62177544"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 04:12:10 -0700
X-CSE-ConnectionGUID: yETfr1EuQpOFdqF1sYYWqQ==
X-CSE-MsgGUID: NaMz+kg6Rf6Er0ju+K8+Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="147371327"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jun 2025 04:12:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v7 09/33] net/ixgbe: simplify packet type support check
Date: Thu, 12 Jun 2025 12:11:15 +0100
Message-ID: <54d8613619fbcba2356b09fdaed0239d121919d6.1749726639.git.anatoly.burakov@intel.com>
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

