Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3871ACDB47F
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2C0D40677;
	Thu, 25 Jun 2026 11:36:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id A052940280;
 Thu, 25 Jun 2026 11:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782380201; x=1813916201;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rDfK6fx4EwNrt6Ohhbs3jjjVxjwpeQnSSYVxGPEogeY=;
 b=RCbXT9q3Dd64EvRREmUWJj/CzADEeCRZrarXfUpFC2R70illJyYgw/J4
 5pzpHPMcK1H4qyiuJxOuyJ/YRHGUVR4xEgR3dB/J82WPE5Z8L7UVQTfcR
 9zGWDoiRJbiUuIKvoPSQRYSPXr6yDXFOzkmVg2iy0f4HQALyIP6f9IpNc
 UwjareSMGD5LkhT33m0e9/Gjv4nd59f3BV0OigPdHrbNDLtuDeBPs3bIV
 l3zMCaesWoPRnECdERgPvUeQ739fVhDeBvIyP3yK3y/auZAik398uqrzu
 ZesFyCk5LoDOufyPAcEfs1KorEe1jq2VbATPHR756O03PHgYJvGLCKAoT A==;
X-CSE-ConnectionGUID: 9ugqmJPjRTuSEOl4fbYfvw==
X-CSE-MsgGUID: ZVG/QLZiRCSEcKAyFK9U4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100579271"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100579271"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 02:36:40 -0700
X-CSE-ConnectionGUID: EXSt0P3SSIeWf8X9qQT4zg==
X-CSE-MsgGUID: rxqt1NLmQmOe3IpOglBkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254298890"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 25 Jun 2026 02:36:40 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/3] net/ice: fix DCF Rx packets statistics underflow
Date: Thu, 25 Jun 2026 09:36:18 +0000
Message-ID: <20260625093619.726471-3-ciara.loftus@intel.com>
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
from separate sources and the order in which they are read cannot be
guaranteed. Under load, rx_discards can therefore momentarily exceed the
sum of the unicast, multicast and broadcast counters. As ipackets is
unsigned, the subtraction then wraps to a huge bogus value, reported to
the application as an enormous Rx packet count and packet rate.

The read order cannot be guaranteed, so use a saturating subtraction:
when rx_discards exceeds the sum of the unicast, multicast and broadcast
counters essentially nothing was delivered, so report zero instead of
underflowing.

Fixes: c9f889e99616 ("net/ice: enable stats for DCF")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 4fce59617e..c78b290b0d 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -1523,8 +1523,16 @@ ice_dcf_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *stats,
 	ret = ice_dcf_query_stats(hw, &pstats);
 	if (ret == 0) {
 		ice_dcf_update_stats(&hw->eth_stats_offset, &pstats);
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

