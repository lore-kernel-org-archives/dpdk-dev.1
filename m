Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CBC83F22
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 17:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37CBA4013F;
	Wed, 16 Jul 2025 19:39:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8BCD2400D6;
 Wed, 16 Jul 2025 19:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752687571; x=1784223571;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TsxKc9yiqpSYiUpKyv76ilWpWwZEn/ci6/c7EznCNmw=;
 b=EATPJwzYlk9C2+jywVUxYApymoqMlU9aS+57kHxg1i9T+gRO1qJRvnUt
 GRMIyCyma+4x+BPcmUGxspsGP4yGOXPOHZCMO9PLy28bRj83zHa8P/4P/
 rMejHfgvPjQORxejkN2fhtBIQWgXdwxoq2MrNgc6VfIyZtgjX4UTzEBBJ
 B1Vq7sR6n+OCBBTHf9+85cFoCHPvDINzpN/0KHgy9h3u5UdZVRvc1DLeY
 AIE1rOs82LYawH98zJ0Mx3Yk2ccDoXUx1fQW0qzKbFWlKw84xWlzA7hhr
 qZ00Be7tD/cd3xjBiKN6iDo8bdo4C//SbtvdtnbceBC+OWtLiMT9gHiF+ w==;
X-CSE-ConnectionGUID: 6RmFEbHmTeSmdQ51VpmEtQ==
X-CSE-MsgGUID: ms0CVSF6RsmsMht0FdWGxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58755084"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="58755084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2025 10:39:28 -0700
X-CSE-ConnectionGUID: goiCdQ35TP+HQb6lSMJqUQ==
X-CSE-MsgGUID: OJEj/s8gQYeitNxWHoIkBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; d="scan'208";a="161863875"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa005.fm.intel.com with ESMTP; 16 Jul 2025 10:39:27 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/ice: fix assumption about tag placement order
Date: Wed, 16 Jul 2025 18:39:22 +0100
Message-ID: <20250716173922.688476-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

The specific placement of outer/inner VLAN tags in E810 and related NICs
is configurable. Therefore, remove the assumption that if the L2Tag2
field is filled in, that the L2Tag1 must also be. Instead, check the
existing mbuf VLAN flags, and move tags and set flags as appropriate.
This fixes an issue where, with QinQ packets with different Tag ethtypes
(0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
having had one tag stripped.

Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index da508592aa..f965aab6ee 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -1835,9 +1835,13 @@ ice_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ci_rx_flex_desc *rxdp)
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
 	    (1 << ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
-		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ |
-				RTE_MBUF_F_RX_VLAN_STRIPPED | RTE_MBUF_F_RX_VLAN;
-		mb->vlan_tci_outer = mb->vlan_tci;
+		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) == 0) {
+			mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		} else {
+			/* if two tags, move Tag1 to outer tag field */
+			mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ;
+			mb->vlan_tci_outer = mb->vlan_tci;
+		}
 		mb->vlan_tci = rte_le_to_cpu_16(rxdp->wb.l2tag2_2nd);
 		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2: %u",
 			   rte_le_to_cpu_16(rxdp->wb.l2tag2_1st),
-- 
2.48.1

