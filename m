Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C6C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:10:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5DAD40DDD;
	Fri,  6 Jun 2025 19:09:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 6E83340DD2
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229784; x=1780765784;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aLTAVM2AQW7+OYcaNQpsB8LCOkTKXyUdJvSa5a1iheY=;
 b=ZExsk61NQdOdcu98B8rWBBtE7n4FnQfHkUjzNBxMHGFSdkUSRqskyMX+
 U409MWjaG2dzhVgdLU7Sj7Mkt22KrCPb6AizyfhAmcRmuT9VDV0iERx01
 eCSWRpwbyxA6lKHqwhzPalFd4V03/rfY4pfJA+BU61sBGko3i+GLheCeu
 oQ4+X78T+XwRXoPN3x+alCnfC5du9U/LNRWNwrD3ZTHCxLUSH5uFuhYs9
 qvIJUXQmUhtS88g70eT0za1QB3vePGjciUs9qnj1Ogk24JJ2s/nDERGhn
 EyQM/OFEZgD534TFK8jquwrX4EhJtv2oAjCGd791QrR0OYEwcE6pGQAza g==;
X-CSE-ConnectionGUID: OfSb068zQa2ocRX4+mmuvQ==
X-CSE-MsgGUID: em3DWK9+RMCL2C9Us3kpcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828417"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828417"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:44 -0700
X-CSE-ConnectionGUID: mZRffBlTStGX1pWWkQDs9Q==
X-CSE-MsgGUID: GVQImJM8QsSlvbhSuBqjFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808165"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 09/34] net/ixgbe: simplify packet type support check
Date: Fri,  6 Jun 2025 18:08:48 +0100
Message-ID: <a1e038e421a1bd7a58b4be0cdec953223ef967f0.1749229650.git.anatoly.burakov@intel.com>
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

There are no differences between scalar and vector paths when it comes to
packet type support, and the only data path currently not covered by the
check is the VF representor path, because it's not meant to be used
directly anyway. Simplify the check to reflect that fact.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v5:
    - Add this commit

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

