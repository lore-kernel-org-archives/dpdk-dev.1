Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D072D58CBB
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 02:59:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3556140268;
	Mon, 23 Mar 2026 03:59:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 855E84025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 03:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774234786; x=1805770786;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cw7RBKquUidyv+8AwIcULeSE75yIS2X3eOPDQol6oM0=;
 b=T42fXCncQxTBbjZeC0nVs6w0uuDIFE60s5DkbO5hlkVBAmDyNcPOCWVo
 aPcsmxJZDIIcNp99AjnqFblRp4xbtqrubHAmDl7F/JYjUue31eNSJNmPb
 k0jjVb+WEXkG+PoKrHXrlGZFdCYDxeJ/vCnJzz/Z1eCJQF0yose4Osw4/
 KV7fP0agl2SjtAZcUU5DbfBYJDn34pdUzGAywMHmBXSNCRAdMCeKtfySW
 t4to+wdtBnWjMGkVzDSjT2qRodCNDWY4MG57b10DkXaYZr2Bw/YeDBJEi
 T3c7dS7YTDEoI+qCDcgdHqsIct1/MVmxelNyfgAkP7M1f6nhuQtQ/5nGl A==;
X-CSE-ConnectionGUID: zvtBdmasS160piqowF2r1w==
X-CSE-MsgGUID: JBgKtzVMThWHVP79YE/meA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="77838450"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="77838450"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2026 19:59:45 -0700
X-CSE-ConnectionGUID: 8l0oZY5yTkOfDWj49ZnuJA==
X-CSE-MsgGUID: BYmn9NzgRki3a697PQH3DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="222961515"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa006.jf.intel.com with ESMTP; 22 Mar 2026 19:59:43 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v1] net/ice: fix FDIR flow type for tunnel inner items
Date: Mon, 23 Mar 2026 08:24:18 +0530
Message-ID: <20260323025418.651923-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
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

The inner_l3/inner_l4 tracking was introduced  to handle L2TPv2 tunnel
inner protocols separately from outer ones. However, the conditions used
to branch into the inner tracking than specifically L2TPv2 tunnels.

This caused VXLAN and GTPU FDIR rules with inner L3/L4 items to fail
because the inner IPv4/IPv6/TCP/UDP/SCTP items no longer updated
flow_type and l3, resulting in stale flow_type values.

Fix by narrowing the inner protocol tracking conditions to only apply
when tunnel_type is ICE_FDIR_TUNNEL_TYPE_L2TPV2.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 34 ++++++++++++-------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 5b27f5a077..3522d77123 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2094,13 +2094,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				   &eth_spec->hdr.ether_type, sizeof(eth_spec->hdr.ether_type));
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
-			/* Only set flow_type for outer IPv4, track inner L3 for tunnels */
-			if (is_outer || !tunnel_type) {
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_OTHER;
-				l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+			if (!is_outer &&
+			    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
+				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
 				current_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
 			} else {
-				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_OTHER;
+				l3 = RTE_FLOW_ITEM_TYPE_IPV4;
 				current_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
 			}
 
@@ -2203,12 +2203,13 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
-			if (is_outer || !tunnel_type) {
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_OTHER;
-				l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+			if (!is_outer &&
+			    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
+				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
 				current_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
 			} else {
-				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_OTHER;
+				l3 = RTE_FLOW_ITEM_TYPE_IPV6;
 				current_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
 			}
 
@@ -2294,11 +2295,10 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_TCP:
-			if (!is_outer && tunnel_type) {
-				/* For inner TCP in tunnels, track inner_l4 */
+			if (!is_outer &&
+			    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
 				inner_l4 = RTE_FLOW_ITEM_TYPE_TCP;
 			} else {
-				/* For outer TCP, update flow_type normally */
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
 					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_TCP;
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
@@ -2361,11 +2361,10 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
-			if (!is_outer && tunnel_type) {
-				/* For inner UDP in tunnels, track inner_l4 */
+			if (!is_outer &&
+			    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
 				inner_l4 = RTE_FLOW_ITEM_TYPE_UDP;
 			} else {
-				/* For outer UDP, update flow_type normally */
 				l4 = RTE_FLOW_ITEM_TYPE_UDP;
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
 					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_UDP;
@@ -2424,11 +2423,10 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_SCTP:
-			if (!is_outer && tunnel_type) {
-				/* For inner SCTP in tunnels, track inner_l4 */
+			if (!is_outer &&
+			    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
 				inner_l4 = RTE_FLOW_ITEM_TYPE_SCTP;
 			} else {
-				/* For outer SCTP, update flow_type normally */
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
 					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_SCTP;
 				if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-- 
2.43.0

