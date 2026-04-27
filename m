Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CA5FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F14FE40653;
	Mon, 27 Apr 2026 04:40:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 04E4940611
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257603; x=1808793603;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2giAAdbScPWoGvkW+fngalQpIp15n97jhBCqlIPBBF0=;
 b=G/2Bpxt4rKWekAqFhDoZKEmQO7EmXUJh5CPH3muSbQAHHiD7a9kuTGIW
 aMhQtd0IM377sI0aHxS4SBKovkIDR54VT+B3/iPaNCNolus5zxvOpG7BP
 QduYPE60JKbnfzjAfBh0oxVwLXXJsAhfMou0V2OxKdBnX7Trv2jxrXpto
 l/cGOAHR0vA+QzMa2m7mE+QgLYLrKTNgH7AQG+VqnSETuoFVBu4+NAM1v
 bsAlm70aWcJBrTi9goR4lvkxOK8aAKDrKJU/BClJjbNB2CI3shigZoELy
 285GnBU4b8WygYyM5LLsXjcgXHMRCLt0QtQ7BYbpuTIwakFiGPJ72Q2Th g==;
X-CSE-ConnectionGUID: JfpNUVKWScunzy51rpo+EQ==
X-CSE-MsgGUID: Ugqr3javQ1aBacS9zR5SzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703505"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703505"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:03 -0700
X-CSE-ConnectionGUID: e3cudI5QR4+JQTDYUrLg2Q==
X-CSE-MsgGUID: 6ScJLfb/Ru+pqNvQM741dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637687"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:40:01 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 3/7] net/ice: fix L2TPv2 inner segment header setup
Date: Mon, 27 Apr 2026 08:01:11 +0530
Message-ID: <20260427023115.1225843-4-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427023115.1225843-1-shaiq.wani@intel.com>
References: <20260427023115.1225843-1-shaiq.wani@intel.com>
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

ice_fdir_input_set_hdrs() sets identical headers on both outer and
inner segments and groups all PPP variants into a single fall-through,
so the HW cannot distinguish inner IPv4 from IPv6 or TCP from UDP.

Add a seg_idx parameter and expand each L2TPv2/PPP ptype into its own
case with per-segment header selection.  Also ensure the inner segment
headers are always programmed even when no inner fields are extracted,
so ptype-only narrowing works correctly.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 160 +++++++++++++++++++++---
 1 file changed, 145 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 5ee9edc442..a0cddaeaef 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1022,7 +1022,8 @@ ice_fdir_input_set_parse(uint64_t inset, enum ice_flow_field *field)
 }
 
 static void
-ice_fdir_input_set_hdrs(enum ice_fltr_ptype flow, struct ice_flow_seg_info *seg)
+ice_fdir_input_set_hdrs(enum ice_fltr_ptype flow, struct ice_flow_seg_info *seg,
+		       int seg_idx)
 {
 	switch (flow) {
 	case ICE_FLTR_PTYPE_NONF_IPV4_UDP:
@@ -1130,16 +1131,77 @@ ice_fdir_input_set_hdrs(enum ice_fltr_ptype flow, struct ice_flow_seg_info *seg)
 				  ICE_FLOW_SEG_HDR_IPV_OTHER);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
-	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_UDP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_TCP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6:
-	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_UDP:
-		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
-				  ICE_FLOW_SEG_HDR_PPP |
-				  ICE_FLOW_SEG_HDR_IPV6 |
-				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_UDP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_TCP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
@@ -1148,16 +1210,77 @@ ice_fdir_input_set_hdrs(enum ice_fltr_ptype flow, struct ice_flow_seg_info *seg)
 				  ICE_FLOW_SEG_HDR_IPV_OTHER);
 		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
-	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_UDP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_TCP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6:
-	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
 	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_UDP:
-		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
-				  ICE_FLOW_SEG_HDR_PPP |
-				  ICE_FLOW_SEG_HDR_IPV4 |
-				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_UDP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_TCP:
+		if (seg_idx == 0)
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+					  ICE_FLOW_SEG_HDR_PPP |
+					  ICE_FLOW_SEG_HDR_IPV4 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		else
+			ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_TCP |
+					  ICE_FLOW_SEG_HDR_IPV6 |
+					  ICE_FLOW_SEG_HDR_IPV_OTHER);
 		break;
 
 	default:
@@ -1192,15 +1315,22 @@ ice_fdir_input_set_conf(struct ice_pf *pf, enum ice_fltr_ptype flow,
 	for (k = 0; k <= ICE_FD_HW_SEG_TUN; k++) {
 		seg = &seg_tun[k];
 		input_set = (k == ICE_FD_HW_SEG_TUN) ? inner_input_set : outer_input_set;
-		if (input_set == 0)
+		if (input_set == 0) {
+			/* For tunnel inner segment, always set headers for
+			 * correct ptype narrowing even if no fields extracted.
+			 */
+			if (k == ICE_FD_HW_SEG_TUN &&
+			    ice_fdir_is_tunnel_profile(ttype))
+				ice_fdir_input_set_hdrs(flow, seg, k);
 			continue;
+		}
 
 		for (i = 0; i < ICE_FLOW_FIELD_IDX_MAX; i++)
 			field[i] = ICE_FLOW_FIELD_IDX_MAX;
 
 		ice_fdir_input_set_parse(input_set, field);
 
-		ice_fdir_input_set_hdrs(flow, seg);
+		ice_fdir_input_set_hdrs(flow, seg, k);
 
 		for (i = 0; field[i] != ICE_FLOW_FIELD_IDX_MAX; i++) {
 			ice_flow_set_fld(seg, field[i],
-- 
2.43.0

