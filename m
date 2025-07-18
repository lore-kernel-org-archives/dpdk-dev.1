Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A15DC83F1A
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Jul 2025 15:43:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F6EC40BA2;
	Fri, 18 Jul 2025 17:43:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 219D6402DB;
 Fri, 18 Jul 2025 17:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752853397; x=1784389397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gN74Lff0DuA2pj9mgmHVMQqCdn/o3qLfFUza/oum7UI=;
 b=AeRgjr12+ZjPDC7EBuTX5Z4klme5r1Y8RU0LuIcy+XoxlrBdmKiVEMy3
 Ewktqxa2/Q431Mfqt3T+abPnFn1FR/JSdeMlP1Tn7iWTmwiwSxOMQKCPR
 QOYrQSsowdFa7XeqbLBaWDQ0V0A1cwWyDBpVNjX8re2ytsId/6ZNGkdwr
 AMt4v+EFhxfyMOUDdHQ/CmX3EKKhvlHszP/YkeskwK+3EHSA174GYkEv5
 jU3qP0G2spvUTjH177JrBybtk8CTzyI/7GBv7611xNrdQQY+U13EJtGIA
 DZZy6MAex6+fzbKSaCSn81fICKUbWGC0ai+KpPDrq5Q0Z/kr53dHR+J8z w==;
X-CSE-ConnectionGUID: 0UhyziCqT9+aVVeJNRu36A==
X-CSE-MsgGUID: uZN8UXhhSiyS9DkkpKOZKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="57764546"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="57764546"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2025 08:43:16 -0700
X-CSE-ConnectionGUID: 3u/cz3MqTzSBF9c2IuFsuQ==
X-CSE-MsgGUID: nKOJ1DdNTCab1qzssfwZ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; d="scan'208";a="157746978"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa007.fm.intel.com with ESMTP; 18 Jul 2025 08:43:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] net/intel: fix assumption about tag placement order
Date: Fri, 18 Jul 2025 16:43:12 +0100
Message-ID: <20250718154312.1716432-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250716173922.688476-1-bruce.richardson@intel.com>
References: <20250716173922.688476-1-bruce.richardson@intel.com>
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

The specific placement of outer/inner VLAN tags in NIC descriptors
is configurable. Therefore, remove the assumption that if the L2Tag2
field is filled in, that the L2Tag1 must also be. Instead, check the
existing mbuf VLAN flags, and move tags and set flags as appropriate.
This fixes an issue where, with QinQ packets with different Tag ethtypes
(0x88a8 vs 0x8100), we get an mbuf reporting two valid tags, but only
having had one tag stripped.

Fixes: cc9d0456b870 ("i40e: support double vlan stripping and insertion")
Fixes: 1e728b01120c ("net/iavf: rework Tx path")
Fixes: e0dcf94a0d7f ("net/ice: support VLAN ops")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 10 +++++++---
 drivers/net/intel/iavf/iavf_rxtx.c | 12 +++++++-----
 drivers/net/intel/ice/ice_rxtx.c   | 10 +++++++---
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index aba3c11ee5..a1fc320d05 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -128,9 +128,13 @@ i40e_rxd_to_vlan_tci(struct rte_mbuf *mb, volatile union ci_rx_desc *rxdp)
 #ifndef RTE_NET_INTEL_USE_16BYTE_DESC
 	if (rte_le_to_cpu_16(rxdp->wb.qword2.ext_status) &
 		(1 << I40E_RX_DESC_EXT_STATUS_L2TAG2P_SHIFT)) {
-		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ |
-			RTE_MBUF_F_RX_VLAN_STRIPPED | RTE_MBUF_F_RX_VLAN;
-		mb->vlan_tci_outer = mb->vlan_tci;
+		if ((mb->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) == 0) {
+			mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
+		} else {
+			/* if two tags, move Tag1 to outer tag field */
+			mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED | RTE_MBUF_F_RX_QINQ;
+			mb->vlan_tci_outer = mb->vlan_tci;
+		}
 		mb->vlan_tci = rte_le_to_cpu_16(rxdp->wb.qword2.l2tag2_2);
 		PMD_RX_LOG(DEBUG, "Descriptor l2tag2_1: %u, l2tag2_2: %u",
 			   rte_le_to_cpu_16(rxdp->wb.qword2.l2tag2_1),
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 7033a74610..887dcd1b2f 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -1169,11 +1169,13 @@ iavf_flex_rxd_to_vlan_tci(struct rte_mbuf *mb,
 
 	if (rte_le_to_cpu_16(rxdp->wb.status_error1) &
 	    (1 << IAVF_RX_FLEX_DESC_STATUS1_L2TAG2P_S)) {
-		mb->ol_flags |= RTE_MBUF_F_RX_QINQ_STRIPPED |
-				RTE_MBUF_F_RX_QINQ |
-				RTE_MBUF_F_RX_VLAN_STRIPPED |
-				RTE_MBUF_F_RX_VLAN;
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

