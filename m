Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321E9E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:25:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68D8B40666;
	Thu, 19 Feb 2026 12:25:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 39AB84042E
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500294; x=1803036294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CPm+vNBGFlBegd/n17OCA+gOGnDFPdoByHVv9AkcQ6U=;
 b=jTq8J6kKRiDiaRf++fLjzEdpMoAXd68TdZ2QjwC1waHW+XcCvih0i/h6
 B00ZrBVAOXb5z8iERo28iavlsC5oAWxji5yoJfcJ7sxvp6QgE94DKr1nz
 k2mst0YRebz5RZ0KOKHDLcm1yR4XDEN6umC2IkcS4DRzD9m8Jekxu48G1
 yl3B/Y1Y7lVpxoFEQmplXgmm05P+HfPXUy4UjnA4jry0fxGq0CLFPx8sK
 KGdyeaavUtdM8rDTzrRhmwrc6ztX/hUqPZnyGm3oy6CJ3HX4FB9205rPF
 5GwrkV/4kkM9iwlpicC0zUP8uM8AuLOkrcHHiCefIwlK0foG9pKEKQjgn Q==;
X-CSE-ConnectionGUID: Sfv52c2sT8+PfGc0P4Tgaw==
X-CSE-MsgGUID: IqGCw738Q6yYKbHat8WicQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198680"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:54 -0800
X-CSE-ConnectionGUID: qsIRcxXlSa6FMb7eKxm3tQ==
X-CSE-MsgGUID: xPkT9d+BQm6IvlX0yg1c8w==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:52 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v7 6/7] net/ice: add L2TPv2 hardware packet generation
Date: Thu, 19 Feb 2026 16:51:02 +0530
Message-Id: <20260219112103.2370766-7-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219112103.2370766-1-shaiq.wani@intel.com>
References: <20260202094244.447966-2-shaiq.wani@intel.com>
 <20260219112103.2370766-1-shaiq.wani@intel.com>
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

Add L2TPv2 packet type cases to ice_fdir_get_gen_prgm_pkt() to enable
hardware packet generation for flow rule programming.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/base/ice_fdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_fdir.c b/drivers/net/intel/ice/base/ice_fdir.c
index f62313c559..2c0cb99854 100644
--- a/drivers/net/intel/ice/base/ice_fdir.c
+++ b/drivers/net/intel/ice/base/ice_fdir.c
@@ -4027,6 +4027,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 				   ICE_NONDMA_TO_NONDMA);
 			loc = &pkt[ICE_FDIR_V6_V4_GTPOGRE_EH_PKT_OFF];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV4_L2TPV2_PPP_IPV4_TCP:
@@ -4038,6 +4041,9 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
 						      idx, offset, tun);
 			loc = &pkt[pos];
 			break;
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_CONTROL:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2:
+		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_UDP:
 		case ICE_FLTR_PTYPE_NONF_IPV6_L2TPV2_PPP_IPV4_TCP:
-- 
2.34.1

