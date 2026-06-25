Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B00CDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 09:37:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C828440689;
	Thu, 25 Jun 2026 11:36:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CF8E4065F;
 Thu, 25 Jun 2026 11:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782380202; x=1813916202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ru1aupfQJ6WF5J1JclLSqZLqfo7QeC1vOF84j76RWE4=;
 b=QvSlyFAKGZr3QKFn8h1btFfKEFtIiKGcgBr4DrRBLETEtNmyIE17A7dM
 0BFzVIADCK1Hv1k1yn8NnwSFjfhYcTXpapaoKe8exUGVxuaTj2yrIC/QR
 tIQl86A1/0E9F1Ove6/PZzt1J+rUzv6yoaMXtDmd+ezy/ZxsZ89g3lux/
 pQLBjxl38CLda17R1cRg5LLAELp2PovHazgF8D4rP3jnsUV/LgJDFvPtd
 xTRjXNqfna7EjpIplrF9NNw1uFaE/MKjxrQN2+nJLSlmGJK20gdjWFIrb
 c6w7G85vst7KCz5qemRIJlVpkOguILpawSlU4QPrGiGNS1JTjwB8+Gc48 Q==;
X-CSE-ConnectionGUID: AHoMYTsiT1+3XRjAMCdd8Q==
X-CSE-MsgGUID: nEfushnJSqyWOOrj3ju0mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100579274"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100579274"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 02:36:41 -0700
X-CSE-ConnectionGUID: 0YVFpkWaQ9S/OeXU+ugg5A==
X-CSE-MsgGUID: d2JcMr//SIWTEvuUEZd+PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254298898"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 25 Jun 2026 02:36:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/3] net/iavf: fix Rx packets statistics underflow
Date: Thu, 25 Jun 2026 09:36:19 +0000
Message-ID: <20260625093619.726471-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625093619.726471-1-ciara.loftus@intel.com>
References: <20260625093619.726471-1-ciara.loftus@intel.com>
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

The number of Rx packets is computed as the sum of the unicast,
multicast and broadcast packet counters, minus the discarded packet
count:

    ipackets = rx_unicast + rx_multicast + rx_broadcast - rx_discards

The unicast, multicast and broadcast counters already include the
packets that were subsequently dropped, so subtracting rx_discards
yields only the packets delivered to the application. These values are
provided by the PF in a virtchnl_eth_stats message; the PF samples them
from separate sources and the VF cannot guarantee the order in which
they are read. Under load, rx_discards can therefore momentarily exceed
the sum of the unicast, multicast and broadcast counters. As ipackets is
unsigned, the subtraction then wraps to a huge bogus value, reported to
the application as an enormous Rx packet count and packet rate.

The read order cannot be guaranteed from the VF, so use a saturating
subtraction: when rx_discards exceeds the sum of the unicast, multicast
and broadcast counters essentially nothing was delivered, so report zero
instead of underflowing.

Fixes: e71ffcc1008e ("net/iavf: fix Rx total stats")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index ec1ad02826..f2b100e290 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1887,8 +1887,16 @@ iavf_dev_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 					 RTE_ETH_RX_OFFLOAD_KEEP_CRC) ? 0 :
 					 RTE_ETHER_CRC_LEN;
 		iavf_update_stats(vsi, &pstats);
-		stats->ipackets = pstats.rx_unicast + pstats.rx_multicast +
-				pstats.rx_broadcast - pstats.rx_discards;
+		stats->ipackets = pstats.rx_unicast + pstats.rx_multicast + pstats.rx_broadcast;
+		/*
+		 * Unicast/multicast/broadcast counters include discarded packets, so subtract
+		 * rx_discards to report only the packets delivered to the application. The
+		 * counters are sampled from separate sources and can be momentarily inconsistent
+		 * under load. If rx_discards exceeds their sum then essentially nothing was
+		 * delivered, so saturate at zero rather than underflow.
+		 */
+		stats->ipackets = stats->ipackets >= pstats.rx_discards ?
+					stats->ipackets - pstats.rx_discards : 0;
 		stats->opackets = pstats.tx_broadcast + pstats.tx_multicast +
 						pstats.tx_unicast;
 		stats->imissed = pstats.rx_discards;
-- 
2.43.0

