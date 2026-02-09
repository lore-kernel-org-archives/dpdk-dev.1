Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260AE81BA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 236BC40669;
	Mon,  9 Feb 2026 12:58:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3601440663
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638309; x=1802174309;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m5N1qaIHED/b4NR+SmUhuVP+RmMf5Aq+gl8DGUqsoc0=;
 b=F683D7Xl8q8Pd8Yxg3Jb7SYmR0OgZom7lbAg8rW6lYIO4aWSj1HstVKZ
 8DVyxR/N/mUH00BLR0ZQVWUPzZImoCQZ4MSKsLbRXalMoIQJJdKjsEzFB
 G1VmJTi4Pb3Xure0U+K5zPCQ+eOCmZwFrxEB5yOk0g+wZvz5C1UMWN45p
 JWhKQPiZvnXVRFjFpwx1u7wfhCmjpbl/qssEb2M5isULibD7b0nQ5mQdc
 GwFPLQFtfFUNI5/rQIIEbMyNGgqGntjrOmTbUl/rBjXVhcCSkvSpuQhGd
 FSwk7wY/ypm4LIyRPjJAbtftuLfnbhfDgH8LilSBA9N1EHYxQlbPMYuGb Q==;
X-CSE-ConnectionGUID: QcHirY16RCC0LOiJtgsYRw==
X-CSE-MsgGUID: n+XYQhzqRrK+QiVBL8qNnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640973"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:29 -0800
X-CSE-ConnectionGUID: tMJ4J7xlTnuR9cOHZ4eTvQ==
X-CSE-MsgGUID: GwuW/bWvQZikUzNtQAg6AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627106"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:27 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v2 5/7] net/ice: add L2TPv2 hardware packet generation
Date: Mon,  9 Feb 2026 17:26:55 +0530
Message-Id: <20260209115657.636525-6-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209115657.636525-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20260209115657.636525-1-shaiq.wani@intel.com>
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
hardware packet generation for FDIR rule programming.

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

