Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0294E98FB0
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 05:23:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0CF5402F0;
	Thu,  9 Apr 2026 07:23:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id E4F89402D3
 for <dev@dpdk.org>; Thu,  9 Apr 2026 07:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775712206; x=1807248206;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=iR5T+/HAf2AFzl9X6dNTfO5XWva1TEaBs3u0GqHZhxM=;
 b=nfFrv99D9KTvzBoke4N7taOLXcNN1K30Y+P1foMmv3xv83rS/7nczPVm
 bEsiuTjECGjeAOE//bQGCtQPiVRSetk8g39wCgsLgiCCnMJ82tJa3YtHL
 9G+DFFc5teo9FH4quazx+8oxAgMhBXMLjmS4HuHn59hy+bo7ITJideRpe
 mpManCh1ofLS1KIDMA8l9dRSptNt72LaltXHcV5zbHvCNqCSXnnhn8oFN
 c4AqifcLJ8fQdMJPTbS7cZqrxBq7gMTdFnkjWJafhrWyIPW6VMpaLp1gk
 dOm91xsIRFZtcf/E2qi9FXkm1XkK8bCVM8jqMJqCRyJZu4LUKdpwFcUny A==;
X-CSE-ConnectionGUID: Fun+4eiCTE2hTwqHsvTtDg==
X-CSE-MsgGUID: Z4V8tahZSp6vqbGk25DNIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75744483"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="75744483"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:23:25 -0700
X-CSE-ConnectionGUID: Yv7jyqR8QeaMxfDPC5+s/A==
X-CSE-MsgGUID: 6q9xRHAGTjeFbXRWhQY8+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="225495965"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa007.fm.intel.com with ESMTP; 08 Apr 2026 22:23:24 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2] net/ice: fix L2TPv2 outer MAC in training packet
Date: Thu,  9 Apr 2026 10:48:35 +0530
Message-ID: <20260409051835.3413336-2-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409051835.3413336-1-shaiq.wani@intel.com>
References: <20260409051835.3413336-1-shaiq.wani@intel.com>
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

v2:
- Split from combined outer-MAC patch into separate fix.
- Add comment documenting difference between pkt vs loc pointers.

 drivers/net/intel/ice/base/ice_fdir.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index 2c0cb99854..f6c826e5b5 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -3830,6 +3830,12 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 	enum ice_fltr_ptype flow;
 	u16 tnl_port;
 	u8 *loc;
+
+	/* pkt  = start of full packet buffer (outer Ethernet header, offset 0).
+	 * loc  = start of current protocol segment; equals pkt for non-tunnel
+	 *        flows, but points past the tunnel header for tunnel flows.
+	 * Use pkt for outer L2 fields, loc for the active segment.
+	 */
 	u16 idx;
 	u16 flags_version;
 	u16 pos;
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

