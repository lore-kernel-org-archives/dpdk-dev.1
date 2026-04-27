Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E86FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BF2140648;
	Mon, 27 Apr 2026 04:40:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id F1E254025F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:39:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257600; x=1808793600;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zkQQAtYmsq0q6yMYv7E0QAy5RuGsexetGH3iwVECXEc=;
 b=U4WG5BhzP8Aup1FICYQhVR09+y9uA1cBXvWUCRHDJvgoEuDgpuXE7FnI
 daTKy554hWz4+SiY6ClLBS+BkaPs9WG0iiE2XVq+syJk9bn4WgXLDGpEJ
 kit5hF8UHj+Ew7YDlF9yIOKdkQBciEs+Q4Yvvr0Fy3TNbVLYQAYAyh3wN
 xh8C+cjJX/jZ6dTHs2pIs4xrgbVmjFpEoRBGCKd5/mPlcRf6jeLP7zyJ1
 QwRbAFLjcwQ4Lp3YGe46Wx7oRb5Nq//0bty/UYJn+tmw/WyADXHbc6DvL
 zpSyI//ljx629Vb8F0r2H6IVDfQrug+2eIgmF5ArUpWH66z97U9i4t5fa g==;
X-CSE-ConnectionGUID: TZJiR60rTmi60NOtiCegWA==
X-CSE-MsgGUID: uMVO/B1+RqCdXVITAjczGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703503"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703503"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:00 -0700
X-CSE-ConnectionGUID: 9BIJcpmJQp++JYuC1cv3kA==
X-CSE-MsgGUID: fMdOrMitQAOkEem9PfIDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637678"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:39:58 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 1/7] net/ice: use granular PTYPEs for L2TPv2 PPP
Date: Mon, 27 Apr 2026 08:01:09 +0530
Message-ID: <20260427023115.1225843-2-shaiq.wani@intel.com>
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

All L2TPv2 PPP variants map to ICE_MAC_IPV4_L2TPV2 (398), so inner
protocol type is not differentiated, allowing cross-protocol flow
matches (e.g. a PPP/IPv4 rule hitting a PPP/IPv6 packet).

Fix ice_ptype_map[] to use the 30 granular L2TPv2 PTYPEs (396-425)
defined by the DDP package. Also add PPP inner protocol flow types to
ice_fdir_gen_l2tpv2_pkt() so training packets get dynamically built
L2TPv2 headers instead of static templates.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Fixes: bf662653976e ("net/ice/base: support L2TPv2 flow rule")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.c    | 12 ++++++++++
 drivers/net/intel/ice/ice_generic_flow.c | 28 ++++++++++++------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index 1846fbc515..a30e87ddcc 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -3886,6 +3886,12 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_TCP:
 			offset = ICE_FDIR_IPV4_L2TPV2_PPP_PKT_OFF;
 			ice_fdir_gen_l2tpv2_pkt(pkt, &input->l2tpv2_data,
 						idx, offset, tun);
@@ -3893,6 +3899,12 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_UDP:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_TCP:
 			offset = ICE_FDIR_IPV6_L2TPV2_PPP_PKT_OFF;
 			ice_fdir_gen_l2tpv2_pkt(pkt, &input->l2tpv2_data,
 						idx, offset, tun);
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 62f0c334a1..f838a987e7 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -2183,21 +2183,21 @@ static struct ice_ptype_match ice_ptype_map[] = {
 	{pattern_eth_ipv4_ah,				ICE_MAC_IPV4_AH},
 	{pattern_eth_ipv4_l2tp,				ICE_MAC_IPV4_L2TPV3},
 	{pattern_eth_ipv4_udp_l2tpv2,		ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp,		ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV4_L2TPV2},
-	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp,		ICE_MAC_IPV4_PPPOL2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV4_PPPOL2TPV2_IPV4_PAY},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV4_PPPOL2TPV2_IPV4_UDP_PAY},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV4_PPPOL2TPV2_IPV4_TCP},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV4_PPPOL2TPV2_IPV6_PAY},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV4_PPPOL2TPV2_IPV6_UDP_PAY},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV4_PPPOL2TPV2_IPV6_TCP},
 	{pattern_eth_ipv6_udp_l2tpv2,		ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp,		ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV6_L2TPV2},
-	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp,		ICE_MAC_IPV6_PPPOL2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV6_PPPOL2TPV2_IPV4_PAY},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV6_PPPOL2TPV2_IPV4_UDP_PAY},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV6_PPPOL2TPV2_IPV4_TCP},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV6_PPPOL2TPV2_IPV6_PAY},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV6_PPPOL2TPV2_IPV6_UDP_PAY},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV6_PPPOL2TPV2_IPV6_TCP},
 
 	{pattern_eth_ipv4_pfcp,				ICE_MAC_IPV4_PFCP_SESSION},
 	{pattern_eth_ipv6,				ICE_PTYPE_IPV6_PAY},
-- 
2.43.0

