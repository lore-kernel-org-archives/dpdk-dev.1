Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD0E9DE5D
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 07:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BEA3440430;
	Thu,  9 Apr 2026 09:49:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 84B9C402D1
 for <dev@dpdk.org>; Thu,  9 Apr 2026 09:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775720971; x=1807256971;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aP4eQErvM5zmsEQ1YXRVcQop+nA/Xnx7YNo+fbxO4hU=;
 b=DPHf8z99b2UGU6xZt2Z8H7zwtvOHUrgzf/6ZW9PydYU+j6bDs7GOayVI
 y6wGiSP/1IBtXOmuwoxyAyeUp9HcqCrHXGxR9vwOthziml2CJOZ+2LOJ7
 5g9jgN4E0aAyrfDhMkhHEYz8vc3H75IAkcdWhpnnEvhdA7gcGDwV3m0zO
 Dkp2FRWm/PwhhdBBIyws17/n3s7loI9BxaBqqZe5yTKH4omdn9CLuVDSJ
 3+J2O8E+gMhKUzuQeHEcvlwizX/x+ltLMKFt+i+YfnsO0W9+rCep6obX4
 R+dr34r0ikLHZ7CEyXEu9VVN30NZzgxv3+77xDpPYK7o/kSJjhfZOihDW Q==;
X-CSE-ConnectionGUID: nySKdYdXTrC47U/uT3CTAw==
X-CSE-MsgGUID: vRSZFC2DQ4274DbJ6xvJkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88105662"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="88105662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:49:30 -0700
X-CSE-ConnectionGUID: 8RYLPdNlRIquOY6eOBvqpA==
X-CSE-MsgGUID: 6xpv5saMRTqfM5kPxwf2FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="222200550"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2026 00:49:29 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3] net/ice: fix L2TPv2 outer MAC in training packet
Date: Thu,  9 Apr 2026 13:14:41 +0530
Message-ID: <20260409074441.3424824-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409074441.3424824-1-shaiq.wani@intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
 <20260409074441.3424824-1-shaiq.wani@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In ice_fdir_get_gen_prgm_pkt() there are two pointers into the
training-packet buffer:

pkt  – start of the full packet (outer Ethernet header, offset 0)
loc  – start of the current protocol segment; equals pkt for
       non-tunnel flows but points past the tunnel header for
       tunnel flows

The L2TPv2 cases wrote the outer source and destination MAC addresses
through loc.  For non-tunnel L2TPv2, loc == pkt so this happened to
work, but it is semantically wrong: outer Ethernet fields must always
be written relative to pkt so the code remains correct regardless of
the tunnel/non-tunnel path taken.

Replace loc with pkt in the four L2TPv2 MAC-insertion case blocks
(IPv4 control, IPv4 data/PPP, IPv6 control, IPv6 data/PPP)

Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v3:
- Fixed checkpatch issue.
- Moved comment after all declarations.
v2:
- Split from combined outer-MAC patch into separate fix.
- Add comment documenting difference between pkt vs loc pointers.

 drivers/net/intel/ice/base/ice_fdir.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index 2c0cb99854..1846fbc515 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -3835,6 +3835,12 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	u16 pos;
 	u16 offset;
 
+	/* pkt  = start of full packet buffer (outer Ethernet header, offset 0).
+	 * loc  = start of current protocol segment; equals pkt for non-tunnel
+	 *        flows, but points past the tunnel header for tunnel flows.
+	 * Use pkt for outer L2 fields, loc for the active segment.
+	 */
+
 	if (input->flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER) {
 		switch (input->ip.v4.proto) {
 		case ICE_IP_PROTO_TCP:
@@ -4599,16 +4605,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
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
@@ -4622,16 +4628,16 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
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
-- 
2.43.0

