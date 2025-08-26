Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6A4EDF032
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 04:53:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EE5A40656;
	Thu, 12 Feb 2026 05:53:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id CE4A740291
 for <dev@dpdk.org>; Thu, 12 Feb 2026 05:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770871979; x=1802407979;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dt113HJlQjGGilL+6JIgFAx5dbbTLCLJ8KTCkXQMLEI=;
 b=E+rQZ3YJv5wIvNaHD6sIae4nLeEc070gPePEwWBPb1sH5cKApdP1cfht
 UJQkVmTAd6ETWPnAXsOKrWpcewsAXUnhZ079LCAjlNI0mcAODbPfhcY2A
 Kf45gyOt+IA+7qU3Q1y6cLb3W7LovXQQ/y+U3dPyBYR66MbH0xQ8lXFU3
 hIeNJwtPoXgnn6flPYw9aiwKkTuqLJ61ij7PozbFw9rbuNIUt1sIb9YsG
 LSccW0MEQ5CnhvzSycXaJvyrE5fJ6EGIX+FltN9Ppg52gj/r9Mi+PbZ77
 c/hsIbcg7AkMX/lozWUpnz9ALs0mDoUDUnug3kz0I+eXHgor5+lYNW0da A==;
X-CSE-ConnectionGUID: sCspPUEDTTKGDnkWZgm9XA==
X-CSE-MsgGUID: 9+56EcDRRLWmJVO2OSiYcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71940241"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71940241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 20:52:59 -0800
X-CSE-ConnectionGUID: LQaOmUJgQHqVsUJVQqZBnA==
X-CSE-MsgGUID: shKDhWeKTQ6FFnl7mW4JcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216715420"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2026 20:52:56 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v4 4/7] net/ice: add L2TPv2 flow patterns and FDIR support
Date: Tue, 26 Aug 2025 21:57:01 +0530
Message-Id: <20250826162704.4636-5-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826162704.4636-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826162704.4636-1-shaiq.wani@intel.com>
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

Implement comprehensive L2TPv2 support for Flow Director
-Flow pattern definitions for different L2TPv2 packet combinations
-FDIR filter parsing logic
-Flow type assignment for proper packet classification

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c  | 451 ++++++++++++++++++++---
 drivers/net/intel/ice/ice_generic_flow.c | 177 +++++++++
 2 files changed, 573 insertions(+), 55 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index f7730ec6ab..6a5d605f03 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -107,6 +107,31 @@
 	ICE_INSET_IPV6_SRC | ICE_INSET_IPV6_DST | \
 	ICE_INSET_NAT_T_ESP_SPI)
 
+#define ICE_FDIR_INSET_L2TPV2 (\
+	ICE_INSET_SMAC | ICE_INSET_DMAC | ICE_INSET_L2TPV2OIP_SESSION_ID)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV4 (\
+	ICE_INSET_TUN_IPV4_SRC | ICE_INSET_TUN_IPV4_DST)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV4_UDP (\
+	ICE_FDIR_INSET_L2TPV2_PPP_IPV4 | ICE_INSET_TUN_UDP_SRC_PORT | \
+	ICE_INSET_TUN_UDP_DST_PORT)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV4_TCP (\
+	ICE_FDIR_INSET_L2TPV2_PPP_IPV4 | ICE_INSET_TUN_TCP_SRC_PORT | \
+	ICE_INSET_TUN_TCP_DST_PORT)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV6 (\
+	ICE_INSET_TUN_IPV6_SRC | ICE_INSET_TUN_IPV6_DST)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV6_UDP (\
+	ICE_FDIR_INSET_L2TPV2_PPP_IPV6 | ICE_INSET_TUN_UDP_SRC_PORT | \
+	ICE_INSET_TUN_UDP_DST_PORT)
+
+#define ICE_FDIR_INSET_L2TPV2_PPP_IPV6_TCP (\
+	ICE_FDIR_INSET_L2TPV2_PPP_IPV6 | ICE_INSET_TUN_TCP_SRC_PORT | \
+	ICE_INSET_TUN_TCP_DST_PORT)
+
 static struct ice_pattern_match_item ice_fdir_supported_pattern[] = {
 	{pattern_raw,					ICE_INSET_NONE,			ICE_INSET_NONE,			ICE_INSET_NONE},
 	{pattern_ethertype,				ICE_FDIR_INSET_ETH,		ICE_INSET_NONE,			ICE_INSET_NONE},
@@ -132,10 +157,26 @@ static struct ice_pattern_match_item ice_fdir_supported_pattern[] = {
 	{pattern_eth_ipv4_udp_vxlan_eth_ipv4_tcp,	ICE_FDIR_INSET_ETH_IPV4_VXLAN,	ICE_FDIR_INSET_ETH_IPV4_TCP,	ICE_INSET_NONE},
 	{pattern_eth_ipv4_udp_vxlan_eth_ipv4_sctp,	ICE_FDIR_INSET_ETH_IPV4_VXLAN,	ICE_FDIR_INSET_ETH_IPV4_SCTP,	ICE_INSET_NONE},
 	/* duplicated GTPU input set in 3rd column to align with shared code behavior. Ideally, only put GTPU field in 2nd column. */
-	{pattern_eth_ipv4_gtpu,				ICE_FDIR_INSET_IPV4_GTPU,	ICE_FDIR_INSET_IPV4_GTPU,	ICE_INSET_NONE},
-	{pattern_eth_ipv4_gtpu_eh,			ICE_FDIR_INSET_IPV4_GTPU_EH,	ICE_FDIR_INSET_IPV4_GTPU_EH,	ICE_INSET_NONE},
-	{pattern_eth_ipv6_gtpu,				ICE_FDIR_INSET_IPV6_GTPU,	ICE_FDIR_INSET_IPV6_GTPU,	ICE_INSET_NONE},
-	{pattern_eth_ipv6_gtpu_eh,			ICE_FDIR_INSET_IPV6_GTPU_EH,	ICE_FDIR_INSET_IPV6_GTPU_EH,	ICE_INSET_NONE},
+	{pattern_eth_ipv4_gtpu,				ICE_FDIR_INSET_IPV4_GTPU,	ICE_FDIR_INSET_IPV4_GTPU,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_gtpu_eh,			ICE_FDIR_INSET_IPV4_GTPU_EH,	ICE_FDIR_INSET_IPV4_GTPU_EH,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_gtpu,				ICE_FDIR_INSET_IPV6_GTPU,	ICE_FDIR_INSET_IPV6_GTPU,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_gtpu_eh,			ICE_FDIR_INSET_IPV6_GTPU_EH,	ICE_FDIR_INSET_IPV6_GTPU_EH,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2,			ICE_FDIR_INSET_L2TPV2,		ICE_INSET_NONE,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp,		ICE_FDIR_INSET_L2TPV2,		ICE_INSET_NONE,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2,			ICE_FDIR_INSET_L2TPV2,		ICE_INSET_NONE,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp,		ICE_FDIR_INSET_L2TPV2,		ICE_INSET_NONE,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4,		ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4_UDP,	ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4_TCP,	ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4,		ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4_UDP,	ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV4_TCP,	ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6,		ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6,		ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6_UDP,	ICE_INSET_NONE},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6_TCP,	ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6,		ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6,		ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6_UDP,	ICE_INSET_NONE},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp,	ICE_FDIR_INSET_L2TPV2,		ICE_FDIR_INSET_L2TPV2_PPP_IPV6_TCP,	ICE_INSET_NONE},
 };
 
 static int
@@ -957,6 +998,7 @@ ice_fdir_input_set_parse(uint64_t inset, enum ice_flow_field *field)
 		{ICE_INSET_VXLAN_VNI, ICE_FLOW_FIELD_IDX_VXLAN_VNI},
 		{ICE_INSET_ESP_SPI, ICE_FLOW_FIELD_IDX_ESP_SPI},
 		{ICE_INSET_NAT_T_ESP_SPI, ICE_FLOW_FIELD_IDX_NAT_T_ESP_SPI},
+		{ICE_INSET_L2TPV2OIP_SESSION_ID, ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID},
 	};
 
 	for (i = 0, j = 0; i < RTE_DIM(ice_inset_map); i++) {
@@ -1068,6 +1110,43 @@ ice_fdir_input_set_hdrs(enum ice_fltr_ptype flow, struct ice_flow_seg_info *seg)
 				  ICE_FLOW_SEG_HDR_IPV6 |
 				  ICE_FLOW_SEG_HDR_IPV_OTHER);
 		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+				  ICE_FLOW_SEG_HDR_IPV6 |
+				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_UDP:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+				  ICE_FLOW_SEG_HDR_PPP |
+				  ICE_FLOW_SEG_HDR_IPV6 |
+				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+				  ICE_FLOW_SEG_HDR_IPV4 |
+				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_TCP:
+	case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_UDP:
+		ICE_FLOW_SET_HDRS(seg, ICE_FLOW_SEG_HDR_L2TPV2 |
+				  ICE_FLOW_SEG_HDR_PPP |
+				  ICE_FLOW_SEG_HDR_IPV4 |
+				  ICE_FLOW_SEG_HDR_IPV_OTHER);
+		break;
+
 	default:
 		PMD_DRV_LOG(ERR, "not supported filter type.");
 		break;
@@ -1170,7 +1249,10 @@ ice_fdir_uninit(struct ice_adapter *ad)
 static int
 ice_fdir_is_tunnel_profile(enum ice_fdir_tunnel_type tunnel_type)
 {
-	if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_VXLAN)
+	if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_VXLAN ||
+	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 ||
+	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_GTPU ||
+	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_GTPU_EH)
 		return 1;
 	else
 		return 0;
@@ -1239,6 +1321,9 @@ ice_fdir_extract_fltr_key(struct ice_fdir_fltr_pattern *key,
 	rte_memcpy(&key->gtpu_data, &input->gtpu_data, sizeof(key->gtpu_data));
 	rte_memcpy(&key->gtpu_mask, &input->gtpu_mask, sizeof(key->gtpu_mask));
 
+	rte_memcpy(&key->l2tpv2_data, &input->l2tpv2_data, sizeof(key->l2tpv2_data));
+	rte_memcpy(&key->l2tpv2_mask, &input->l2tpv2_mask, sizeof(key->l2tpv2_mask));
+
 	key->tunnel_type = filter->tunnel_type;
 }
 
@@ -1797,16 +1882,22 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	const struct rte_flow_item_gtp *gtp_spec, *gtp_mask;
 	const struct rte_flow_item_gtp_psc *gtp_psc_spec, *gtp_psc_mask;
 	const struct rte_flow_item_esp *esp_spec, *esp_mask;
+	const struct rte_flow_item_l2tpv2 *l2tpv2_spec, *l2tpv2_mask;
+	const struct rte_flow_item_ppp *ppp_spec, *ppp_mask;
 	uint64_t input_set_i = ICE_INSET_NONE; /* only for tunnel inner */
 	uint64_t input_set_o = ICE_INSET_NONE; /* non-tunnel and tunnel outer */
 	uint64_t *input_set;
 	uint8_t flow_type = ICE_FLTR_PTYPE_NONF_NONE;
+	enum rte_flow_item_type inner_l3 = RTE_FLOW_ITEM_TYPE_END;
+	enum rte_flow_item_type inner_l4 = RTE_FLOW_ITEM_TYPE_END;
+	enum rte_flow_item_type current_l3 = RTE_FLOW_ITEM_TYPE_END;
+	bool ppp_present = false;
 	uint8_t  ipv6_addr_mask[16] = {
 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
 		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
 	};
 	uint32_t vtc_flow_cpu;
-	uint16_t ether_type;
+	uint16_t ether_type = 0, flags_version = 0;
 	enum rte_flow_item_type next_type;
 	bool is_outer = true;
 	struct ice_fdir_extra *p_ext_data;
@@ -2001,22 +2092,30 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				   &eth_spec->hdr.ether_type, sizeof(eth_spec->hdr.ether_type));
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV4:
-			flow_type = ICE_FLTR_PTYPE_NONF_IPV4_OTHER;
-			l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+			/* Only set flow_type for outer IPv4, track inner L3 for tunnels */
+			if (is_outer || !tunnel_type) {
+				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_OTHER;
+				l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+				current_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+			} else {
+				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+				current_l3 = RTE_FLOW_ITEM_TYPE_IPV4;
+			}
+
 			ipv4_spec = item->spec;
 			ipv4_last = item->last;
 			ipv4_mask = item->mask;
 			p_v4 = (tunnel_type && is_outer) ?
-			       &filter->input.ip_outer.v4 :
-			       &filter->input.ip.v4;
+					&filter->input.ip_outer.v4 :
+					&filter->input.ip.v4;
 
 			if (!(ipv4_spec && ipv4_mask))
 				break;
 
 			/* Check IPv4 mask and update input set */
 			if (ipv4_mask->hdr.version_ihl ||
-			    ipv4_mask->hdr.total_length ||
-			    ipv4_mask->hdr.hdr_checksum) {
+				ipv4_mask->hdr.total_length ||
+				ipv4_mask->hdr.hdr_checksum) {
 				rte_flow_error_set(error, EINVAL,
 						   RTE_FLOW_ERROR_TYPE_ITEM,
 						   item,
@@ -2048,10 +2147,20 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				ipv4_mask->hdr.dst_addr != UINT32_MAX)
 				return -rte_errno;
 
-			if (ipv4_mask->hdr.dst_addr == UINT32_MAX)
-				*input_set |= ICE_INSET_IPV4_DST;
-			if (ipv4_mask->hdr.src_addr == UINT32_MAX)
-				*input_set |= ICE_INSET_IPV4_SRC;
+			if (ipv4_mask->hdr.dst_addr == UINT32_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_IPV4_DST;
+				else
+					*input_set |= ICE_INSET_IPV4_DST;
+			}
+			if (ipv4_mask->hdr.src_addr == UINT32_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_IPV4_SRC;
+				else
+					*input_set |= ICE_INSET_IPV4_SRC;
+			}
 			if (ipv4_mask->hdr.time_to_live == UINT8_MAX)
 				*input_set |= ICE_INSET_IPV4_TTL;
 			if (ipv4_mask->hdr.next_proto_id == UINT8_MAX)
@@ -2092,8 +2201,15 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 
 			break;
 		case RTE_FLOW_ITEM_TYPE_IPV6:
-			flow_type = ICE_FLTR_PTYPE_NONF_IPV6_OTHER;
-			l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+			if (is_outer || !tunnel_type) {
+				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_OTHER;
+				l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+				current_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+			} else {
+				inner_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+				current_l3 = RTE_FLOW_ITEM_TYPE_IPV6;
+			}
+
 			ipv6_spec = item->spec;
 			ipv6_mask = item->mask;
 			p_v6 = (tunnel_type && is_outer) ?
@@ -2113,15 +2229,24 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			}
 
 			if (!memcmp(&ipv6_mask->hdr.src_addr, ipv6_addr_mask,
-				    sizeof(ipv6_mask->hdr.src_addr)))
-				*input_set |= ICE_INSET_IPV6_SRC;
+				    sizeof(ipv6_mask->hdr.src_addr))) {
+				if (tunnel_type && !is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_IPV6_SRC;
+				else
+					*input_set |= ICE_INSET_IPV6_SRC;
+			}
 			if (!memcmp(&ipv6_mask->hdr.dst_addr, ipv6_addr_mask,
-				    sizeof(ipv6_mask->hdr.dst_addr)))
-				*input_set |= ICE_INSET_IPV6_DST;
-
+				    sizeof(ipv6_mask->hdr.dst_addr))) {
+				if (tunnel_type && !is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_IPV6_DST;
+				else
+					*input_set |= ICE_INSET_IPV6_DST;
+			}
 			if ((ipv6_mask->hdr.vtc_flow &
-			     rte_cpu_to_be_32(ICE_IPV6_TC_MASK))
-			    == rte_cpu_to_be_32(ICE_IPV6_TC_MASK))
+			     rte_cpu_to_be_32(ICE_IPV6_TC_MASK)) ==
+			    rte_cpu_to_be_32(ICE_IPV6_TC_MASK))
 				*input_set |= ICE_INSET_IPV6_TC;
 			if (ipv6_mask->hdr.proto == UINT8_MAX)
 				*input_set |= ICE_INSET_IPV6_NEXT_HDR;
@@ -2167,10 +2292,16 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 			break;
 
 		case RTE_FLOW_ITEM_TYPE_TCP:
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_TCP;
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_TCP;
+			if (!is_outer && tunnel_type) {
+				/* For inner TCP in tunnels, track inner_l4 */
+				inner_l4 = RTE_FLOW_ITEM_TYPE_TCP;
+			} else {
+				/* For outer TCP, update flow_type normally */
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_TCP;
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_TCP;
+			}
 
 			tcp_spec = item->spec;
 			tcp_mask = item->mask;
@@ -2201,28 +2332,44 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				tcp_mask->hdr.dst_port != UINT16_MAX)
 				return -rte_errno;
 
-			if (tcp_mask->hdr.src_port == UINT16_MAX)
-				*input_set |= ICE_INSET_TCP_SRC_PORT;
-			if (tcp_mask->hdr.dst_port == UINT16_MAX)
-				*input_set |= ICE_INSET_TCP_DST_PORT;
+			if (tcp_mask->hdr.src_port == UINT16_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_TCP_SRC_PORT;
+				else
+					*input_set |= ICE_INSET_TCP_SRC_PORT;
+			}
+			if (tcp_mask->hdr.dst_port == UINT16_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_TCP_DST_PORT;
+				else
+					*input_set |= ICE_INSET_TCP_DST_PORT;
+			}
 
 			/* Get filter info */
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+			if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
 				assert(p_v4);
 				p_v4->dst_port = tcp_spec->hdr.dst_port;
 				p_v4->src_port = tcp_spec->hdr.src_port;
-			} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+			} else if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
 				assert(p_v6);
 				p_v6->dst_port = tcp_spec->hdr.dst_port;
 				p_v6->src_port = tcp_spec->hdr.src_port;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_UDP:
-			l4 = RTE_FLOW_ITEM_TYPE_UDP;
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_UDP;
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_UDP;
+			if (!is_outer && tunnel_type) {
+				/* For inner UDP in tunnels, track inner_l4 */
+				inner_l4 = RTE_FLOW_ITEM_TYPE_UDP;
+			} else {
+				/* For outer UDP, update flow_type normally */
+				l4 = RTE_FLOW_ITEM_TYPE_UDP;
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_UDP;
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_UDP;
+			}
 
 			udp_spec = item->spec;
 			udp_mask = item->mask;
@@ -2248,27 +2395,43 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				udp_mask->hdr.dst_port != UINT16_MAX)
 				return -rte_errno;
 
-			if (udp_mask->hdr.src_port == UINT16_MAX)
-				*input_set |= ICE_INSET_UDP_SRC_PORT;
-			if (udp_mask->hdr.dst_port == UINT16_MAX)
-				*input_set |= ICE_INSET_UDP_DST_PORT;
+			if (udp_mask->hdr.src_port == UINT16_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_UDP_SRC_PORT;
+				else
+					*input_set |= ICE_INSET_UDP_SRC_PORT;
+			}
+			if (udp_mask->hdr.dst_port == UINT16_MAX) {
+				if (!is_outer &&
+				    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
+					*input_set |= ICE_INSET_TUN_UDP_DST_PORT;
+				else
+					*input_set |= ICE_INSET_UDP_DST_PORT;
+			}
 
 			/* Get filter info */
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+			if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
 				assert(p_v4);
 				p_v4->dst_port = udp_spec->hdr.dst_port;
 				p_v4->src_port = udp_spec->hdr.src_port;
-			} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+			} else if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
 				assert(p_v6);
 				p_v6->src_port = udp_spec->hdr.src_port;
 				p_v6->dst_port = udp_spec->hdr.dst_port;
 			}
 			break;
 		case RTE_FLOW_ITEM_TYPE_SCTP:
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV4_SCTP;
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
-				flow_type = ICE_FLTR_PTYPE_NONF_IPV6_SCTP;
+			if (!is_outer && tunnel_type) {
+				/* For inner SCTP in tunnels, track inner_l4 */
+				inner_l4 = RTE_FLOW_ITEM_TYPE_SCTP;
+			} else {
+				/* For outer SCTP, update flow_type normally */
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV4)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_SCTP;
+				if (l3 == RTE_FLOW_ITEM_TYPE_IPV6)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_SCTP;
+			}
 
 			sctp_spec = item->spec;
 			sctp_mask = item->mask;
@@ -2299,11 +2462,11 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				*input_set |= ICE_INSET_SCTP_DST_PORT;
 
 			/* Get filter info */
-			if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+			if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
 				assert(p_v4);
 				p_v4->dst_port = sctp_spec->hdr.dst_port;
 				p_v4->src_port = sctp_spec->hdr.src_port;
-			} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+			} else if (current_l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
 				assert(p_v6);
 				p_v6->dst_port = sctp_spec->hdr.dst_port;
 				p_v6->src_port = sctp_spec->hdr.src_port;
@@ -2406,6 +2569,115 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 				filter->input.ip.v6.sec_parm_idx =
 					esp_spec->hdr.spi;
 			break;
+		case RTE_FLOW_ITEM_TYPE_L2TPV2: {
+			struct ice_fdir_l2tpv2 l2tpv2_be;
+
+			l2tpv2_spec = item->spec;
+			l2tpv2_mask = item->mask;
+
+			if (!(l2tpv2_spec && l2tpv2_mask))
+				break;
+
+			flags_version =
+				rte_be_to_cpu_16(l2tpv2_spec->hdr.common.flags_version);
+			if ((flags_version == RTE_L2TPV2_MSG_TYPE_CONTROL &&
+			     l2tpv2_mask->hdr.type3.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA &&
+			     l2tpv2_mask->hdr.type7.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L &&
+			     l2tpv2_mask->hdr.type6.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_S &&
+			     l2tpv2_mask->hdr.type5.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_O &&
+			     l2tpv2_mask->hdr.type4.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S &&
+			     l2tpv2_mask->hdr.type3.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_O &&
+			     l2tpv2_mask->hdr.type2.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_S_O &&
+			     l2tpv2_mask->hdr.type1.session_id == UINT16_MAX) ||
+			    (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S_O &&
+			     l2tpv2_mask->hdr.type0.session_id == UINT16_MAX)) {
+				input_set_o |= ICE_INSET_L2TPV2OIP_SESSION_ID;
+			}
+
+			tunnel_type = ICE_FDIR_TUNNEL_TYPE_L2TPV2;
+			memset(&l2tpv2_be, 0, sizeof(l2tpv2_be));
+
+			if (flags_version == RTE_L2TPV2_MSG_TYPE_CONTROL) {
+				l2tpv2_be.length = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.length);
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.session_id);
+				l2tpv2_be.ns = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.ns);
+				l2tpv2_be.nr = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.nr);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA) {
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type7.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type7.session_id);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L) {
+				l2tpv2_be.length = rte_cpu_to_be_16(l2tpv2_spec->hdr.type6.length);
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type6.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type6.session_id);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_S) {
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type5.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type5.session_id);
+				l2tpv2_be.ns = rte_cpu_to_be_16(l2tpv2_spec->hdr.type5.ns);
+				l2tpv2_be.nr = rte_cpu_to_be_16(l2tpv2_spec->hdr.type5.nr);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_O) {
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type4.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type4.session_id);
+				l2tpv2_be.offset_size = rte_cpu_to_be_16(l2tpv2_spec->hdr.type4.offset_size);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S) {
+				l2tpv2_be.length = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.length);
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.session_id);
+				l2tpv2_be.ns = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.ns);
+				l2tpv2_be.nr = rte_cpu_to_be_16(l2tpv2_spec->hdr.type3.nr);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_O) {
+				l2tpv2_be.length = rte_cpu_to_be_16(l2tpv2_spec->hdr.type2.length);
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type2.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type2.session_id);
+				l2tpv2_be.offset_size = rte_cpu_to_be_16(l2tpv2_spec->hdr.type2.offset_size);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_S_O) {
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type1.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type1.session_id);
+				l2tpv2_be.ns = rte_cpu_to_be_16(l2tpv2_spec->hdr.type1.ns);
+				l2tpv2_be.nr = rte_cpu_to_be_16(l2tpv2_spec->hdr.type1.nr);
+				l2tpv2_be.offset_size = rte_cpu_to_be_16(l2tpv2_spec->hdr.type1.offset_size);
+			} else if (flags_version == RTE_L2TPV2_MSG_TYPE_DATA_L_S_O) {
+				l2tpv2_be.length = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.length);
+				l2tpv2_be.tunnel_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.tunnel_id);
+				l2tpv2_be.session_id = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.session_id);
+				l2tpv2_be.ns = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.ns);
+				l2tpv2_be.nr = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.nr);
+				l2tpv2_be.offset_size = rte_cpu_to_be_16(l2tpv2_spec->hdr.type0.offset_size);
+			}
+
+			/* Copy converted values to filter */
+			filter->input.l2tpv2_data.flags_version = rte_cpu_to_be_16(flags_version);
+			filter->input.l2tpv2_data.length = l2tpv2_be.length;
+			filter->input.l2tpv2_data.tunnel_id = l2tpv2_be.tunnel_id;
+			filter->input.l2tpv2_data.session_id = l2tpv2_be.session_id;
+			filter->input.l2tpv2_data.ns = l2tpv2_be.ns;
+			filter->input.l2tpv2_data.nr = l2tpv2_be.nr;
+			filter->input.l2tpv2_data.offset_size = l2tpv2_be.offset_size;
+			break;
+		}
+		case RTE_FLOW_ITEM_TYPE_PPP:
+			ppp_spec = item->spec;
+			ppp_mask = item->mask;
+
+			/* PPP marks transition from outer to inner in L2TPv2 tunnels */
+			if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
+				is_outer = false;
+				ppp_present = true;
+			}
+
+			if (ppp_spec && ppp_mask) {
+				filter->input.ppp_data.addr = ppp_spec->hdr.addr;
+				filter->input.ppp_data.ctrl = ppp_spec->hdr.ctrl;
+				filter->input.ppp_data.proto_id = ppp_spec->hdr.proto_id;
+			}
+			break;
 		default:
 			rte_flow_error_set(error, EINVAL,
 					   RTE_FLOW_ERROR_TYPE_ITEM,
@@ -2439,6 +2711,74 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_VXLAN &&
 		flow_type == ICE_FLTR_PTYPE_NONF_IPV4_OTHER)
 		flow_type = ICE_FLTR_PTYPE_NONF_IPV4_UDP_VXLAN_IPV4_OTHER;
+	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+		flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP &&
+		flags_version != RTE_L2TPV2_MSG_TYPE_CONTROL &&
+		!ppp_present)
+		flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2;
+	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+		flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP &&
+		flags_version != RTE_L2TPV2_MSG_TYPE_CONTROL &&
+		!ppp_present)
+		flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2;
+	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+		flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP &&
+		flags_version == RTE_L2TPV2_MSG_TYPE_CONTROL &&
+		!ppp_present)
+		flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL;
+	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+		flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP &&
+		flags_version == RTE_L2TPV2_MSG_TYPE_CONTROL &&
+		!ppp_present)
+		flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL;
+	/* Handle L2TPV2 with PPP and inner protocols */
+	else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 &&
+		ppp_present &&
+		inner_l3 != RTE_FLOW_ITEM_TYPE_END) {
+		/* L2TPV2 with inner IPv4/IPv6 */
+		if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP) {
+			/* Outer IPv4 + inner protocol */
+			if (inner_l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+				if (inner_l4 == RTE_FLOW_ITEM_TYPE_TCP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP;
+				else if (inner_l4 == RTE_FLOW_ITEM_TYPE_UDP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP;
+				else
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4;
+			} else if (inner_l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+				if (inner_l4 == RTE_FLOW_ITEM_TYPE_TCP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_TCP;
+				else if (inner_l4 == RTE_FLOW_ITEM_TYPE_UDP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6_UDP;
+				else
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV6;
+			}
+		} else if (flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP) {
+			/* Outer IPv6 + inner protocol */
+			if (inner_l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+				if (inner_l4 == RTE_FLOW_ITEM_TYPE_TCP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP;
+				else if (inner_l4 == RTE_FLOW_ITEM_TYPE_UDP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP;
+				else
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4;
+			} else if (inner_l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+				if (inner_l4 == RTE_FLOW_ITEM_TYPE_TCP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_TCP;
+				else if (inner_l4 == RTE_FLOW_ITEM_TYPE_UDP)
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6_UDP;
+				else
+					flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV6;
+			}
+		}
+	} else if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 && ppp_present &&
+		inner_l3 == RTE_FLOW_ITEM_TYPE_END) {
+		/* Handle L2TPV2 with PPP but no inner protocol specified */
+		if (flow_type == ICE_FLTR_PTYPE_NONF_IPV4_UDP)
+			flow_type = ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP;
+		else if (flow_type == ICE_FLTR_PTYPE_NONF_IPV6_UDP)
+			flow_type = ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP;
+	}
 
 	filter->tunnel_type = tunnel_type;
 	filter->input.flow_type = flow_type;
@@ -2482,9 +2822,10 @@ ice_fdir_parse(struct ice_adapter *ad,
 	input_set = filter->input_set_o | filter->input_set_i;
 	input_set = raw ? ~input_set : input_set;
 
-	if (!input_set || filter->input_set_o &
-	    ~(item->input_set_mask_o | ICE_INSET_ETHERTYPE) ||
-	    filter->input_set_i & ~item->input_set_mask_i) {
+	if (!input_set ||
+	    (filter->input_set_o &
+	     ~(item->input_set_mask_o | ICE_INSET_ETHERTYPE)) ||
+	    (filter->input_set_i & ~item->input_set_mask_i)) {
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_ITEM_SPEC,
 				   pattern,
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 4049157eab..644958cccf 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -1794,6 +1794,166 @@ enum rte_flow_item_type pattern_eth_ipv6_pfcp[] = {
 	RTE_FLOW_ITEM_TYPE_PFCP,
 	RTE_FLOW_ITEM_TYPE_END,
 };
+enum rte_flow_item_type pattern_eth_ipv4_l2tpv2[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_l2tpv2[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+/* PPPoL2TPv2oUDP */
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV4,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+enum rte_flow_item_type pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp[] = {
+	RTE_FLOW_ITEM_TYPE_ETH,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_UDP,
+	RTE_FLOW_ITEM_TYPE_L2TPV2,
+	RTE_FLOW_ITEM_TYPE_PPP,
+	RTE_FLOW_ITEM_TYPE_IPV6,
+	RTE_FLOW_ITEM_TYPE_TCP,
+	RTE_FLOW_ITEM_TYPE_END,
+};
+
 
 typedef bool (*parse_engine_t)(struct ice_adapter *ad,
 			       struct rte_flow *flow,
@@ -2021,6 +2181,23 @@ static struct ice_ptype_match ice_ptype_map[] = {
 	{pattern_eth_ipv4_udp_esp,			ICE_MAC_IPV4_NAT_T_ESP},
 	{pattern_eth_ipv4_ah,				ICE_MAC_IPV4_AH},
 	{pattern_eth_ipv4_l2tp,				ICE_MAC_IPV4_L2TPV3},
+	{pattern_eth_ipv4_udp_l2tpv2,		ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp,		ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv4_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV4_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2,		ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp,		ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4,		ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_udp,	ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv4_tcp,	ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6,		ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_udp,	ICE_MAC_IPV6_L2TPV2},
+	{pattern_eth_ipv6_udp_l2tpv2_ppp_ipv6_tcp,	ICE_MAC_IPV6_L2TPV2},
+
 	{pattern_eth_ipv4_pfcp,				ICE_MAC_IPV4_PFCP_SESSION},
 	{pattern_eth_ipv6,				ICE_PTYPE_IPV6_PAY},
 	{pattern_eth_ipv6_udp,				ICE_PTYPE_IPV6_UDP_PAY},
-- 
2.34.1

