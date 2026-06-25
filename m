Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E23DCDB466
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9E68640663;
	Thu, 25 Jun 2026 11:36:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2893C4025F;
 Thu, 25 Jun 2026 11:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782380200; x=1813916200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NhyZXeNN+2eaXJDPOdVFvnFbsN1qKuzeCsSK+rDRR1c=;
 b=TgTtJIjQf1EOgEP19rx54s5/yxfJzbIMVM/NQP2LA9nXjHRPeqOIYbwN
 riZY/D3XL5lukYtySBzL8CVa0kbMxqHzXphnkzkTA+SIUKfT2xwZeYA8R
 KxU6b1i3GjOeTrwbUbQgk7x09NpDw2IFHEYFcOySqE1LrCRQqOXMg9o0b
 /VQyJMep0xZkrPrnShJyc0cIsg9U3u+Wqma4tSFd7S5AnyVFsoxA6WvJe
 oJxsJSmIdjCpT12LaiorSeW2twJGiJoR+xAumbjwTT68n6JGC/SH+uvLH
 spZh4wBOmaA5r4xKyqsPVx/1usiQ5DjkhROWKY+lLfDxbWCnkCWQjveGW g==;
X-CSE-ConnectionGUID: NDGrkTNjTGKhQSc/vyy47g==
X-CSE-MsgGUID: mR9ei7LeQFGk8Ovgf1DVAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="100579267"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="100579267"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 02:36:39 -0700
X-CSE-ConnectionGUID: xgMKWFG/QvuH8v/fXV8HhQ==
X-CSE-MsgGUID: pUNNoRy2TKKgIj9q9G/47w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="254298882"
Received: from silpixa00401921.ir.intel.com ([10.20.224.96])
 by orviesa003.jf.intel.com with ESMTP; 25 Jun 2026 02:36:39 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/3] net/ice: fix Rx packets statistics underflow
Date: Thu, 25 Jun 2026 09:36:17 +0000
Message-ID: <20260625093619.726471-2-ciara.loftus@intel.com>
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
yields only the packets delivered to the application. However, each of
these counters is read from a separate hardware register, and the reads
happen at slightly different instants. Under load, rx_discards (read
last) can momentarily exceed the sum of the unicast, multicast and
broadcast counters (read earlier). As ipackets is unsigned, the
subtraction then wraps to a huge bogus value, reported to the
application as an enormous Rx packet count and packet rate.

Read the rx_discards register before the unicast, multicast and
broadcast registers. As all of these counters only ever increase, and
the unicast, multicast and broadcast counters always include the
discarded packets, sampling rx_discards first guarantees it can never
exceed the later sum of the other three, so the subtraction can never
underflow.

Fixes: a37bde56314d ("net/ice: support statistics")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index ad9c49b339..94e07446be 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6457,6 +6457,15 @@ ice_update_vsi_stats(struct ice_vsi *vsi)
 	struct ice_hw *hw = ICE_VSI_TO_HW(vsi);
 	int idx = rte_le_to_cpu_16(vsi->vsi_id);
 
+	/*
+	 * Unicast/multicast/broadcast counters include discarded packets. Received packets is
+	 * calculated by deducting discards from unicast/multicast/broadcast. To prevent a
+	 * potential underflow, read discards first to guarantee it is smaller than
+	 * unicast/multicast/broadcast.
+	 */
+	ice_stat_update_32(hw, GLV_RDPC(idx), vsi->offset_loaded,
+			   &oes->rx_discards, &nes->rx_discards);
+
 	ice_stat_update_40(hw, GLV_GORCH(idx), GLV_GORCL(idx),
 			   vsi->offset_loaded, &oes->rx_bytes,
 			   &nes->rx_bytes);
@@ -6483,8 +6492,6 @@ ice_update_vsi_stats(struct ice_vsi *vsi)
 	nes->rx_bytes -= (nes->rx_unicast + nes->rx_multicast +
 			  nes->rx_broadcast) * RTE_ETHER_CRC_LEN;
 
-	ice_stat_update_32(hw, GLV_RDPC(idx), vsi->offset_loaded,
-			   &oes->rx_discards, &nes->rx_discards);
 	/* GLV_REPC not supported */
 	/* GLV_RMPC not supported */
 	ice_stat_update_32(hw, GLSWID_RUPP(idx), vsi->offset_loaded,
-- 
2.43.0

