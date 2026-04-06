Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1CEF4EC3
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Apr 2026 08:18:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EE034026A;
	Mon,  6 Apr 2026 10:18:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 5E68740265
 for <dev@dpdk.org>; Mon,  6 Apr 2026 10:18:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775463530; x=1806999530;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jDy3xZFgHhN5RiadsgY8cuUSOq5jJqNa7azAfId/BCY=;
 b=c0qdCRXSC0rNf1ggXepoCM6w79KJ8eSkph9eXIV8Y0BpPh41FvhrlC0d
 diYjpUSbGuGqo1noc9gm4A1/78w/MNXTZD8WegcKyiIpEXPccHbaGMfOc
 CZOIM7r4FI1Xfg1AnDoJ0SXxRKRqjla0Za3O1sma59F9ApV7rUJcskz1Y
 XRmBQUFlPtApKfbdQDWyJfMMuZvu+Wev6YlZahVCDXvkTRKPr9i4lQ5JX
 DgbIRheImOWdVO8fJTp7ad7rjpqADEDoTYmF5dFGRAVzVimhgLEMQXSjR
 Cl8tDAgauSl5+huDSMFGLiiceM0qSl82/NTcVSKZlChL//xMFXIwwWyCX w==;
X-CSE-ConnectionGUID: gAkSzWJZTkidXDoi7fRUbw==
X-CSE-MsgGUID: 3rbLtbAMSp+jOPEEJTYYqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="87037951"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="87037951"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 01:18:49 -0700
X-CSE-ConnectionGUID: cmuKNu5DT9CcJ71LwhWBBw==
X-CSE-MsgGUID: DPbLCWn4T2WuAXFw+TtyKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="232684114"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa005.fm.intel.com with ESMTP; 06 Apr 2026 01:18:48 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH] net/ice: fix L2TPv2 outer MAC address in training packet
Date: Mon,  6 Apr 2026 13:43:55 +0530
Message-ID: <20260406081355.3241393-1-shaiq.wani@intel.com>
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

flow rules with eth + l2tpv2 patterns fail to match because outer MACs
are written to the wrong location in the training packet.

The pre-scan loop does not detect L2TPV2, so tunnel_type is still 0
when the ETH item is parsed and MACs land in ext_data (inner) instead
of ext_data_outer. Also, ice_fdir_get_gen_prgm_pkt() uses the 'loc'
pointer (past the L2TPv2 header) instead of 'pkt' (Ethernet offset 0).

Detect L2TPV2 in pre-scan, and use 'pkt' for MAC insertion in all
four L2TPv2 training-packet cases.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.c   | 16 ++++++++--------
 drivers/net/intel/ice/ice_fdir_filter.c |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index 2c0cb99854..e1d8b65972 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -4599,16 +4599,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 				     input->ip.v6.tc);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
-		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
-		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
+		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
+		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
 					input->ext_data_outer.src_mac);
 		ice_pkt_insert_u16(loc, ICE_IPV4_L2TPV2_LEN_SESS_ID_OFFSET,
 				   input->l2tpv2_data.session_id);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
-		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
-		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
+		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
+		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
 					input->ext_data_outer.src_mac);
 		flags_version = BE16_TO_CPU(input->l2tpv2_data.flags_version);
 		if (flags_version & ICE_L2TPV2_FLAGS_LEN) {
@@ -4622,16 +4622,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 		}
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
-		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
-		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
+		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
+		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
 					input->ext_data_outer.src_mac);
 		ice_pkt_insert_u16(loc, ICE_IPV6_L2TPV2_LEN_SESS_ID_OFFSET,
 				   input->l2tpv2_data.session_id);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
-		ice_pkt_insert_mac_addr(loc, input->ext_data_outer.dst_mac);
-		ice_pkt_insert_mac_addr(loc + ETH_ALEN,
+		ice_pkt_insert_mac_addr(pkt, input->ext_data_outer.dst_mac);
+		ice_pkt_insert_mac_addr(pkt + ETH_ALEN,
 					input->ext_data_outer.src_mac);
 		flags_version = BE16_TO_CPU(input->l2tpv2_data.flags_version);
 		if (flags_version & ICE_L2TPV2_FLAGS_LEN) {
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3522d77123..1cbc613020 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1911,6 +1911,8 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
 		if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN)
 			tunnel_type = ICE_FDIR_TUNNEL_TYPE_VXLAN;
+		if (item->type == RTE_FLOW_ITEM_TYPE_L2TPV2)
+			tunnel_type = ICE_FDIR_TUNNEL_TYPE_L2TPV2;
 		/* To align with shared code behavior, save gtpu outer
 		 * fields in inner struct.
 		 */
-- 
2.43.0

