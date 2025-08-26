Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBB1EDF038
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 05:32:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EBDB40670;
	Thu, 12 Feb 2026 06:31:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id E16E840656
 for <dev@dpdk.org>; Thu, 12 Feb 2026 06:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770874298; x=1802410298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m5N1qaIHED/b4NR+SmUhuVP+RmMf5Aq+gl8DGUqsoc0=;
 b=VX8bqB/ixY7oQPs03eTSCLM93LXPFvo0HJAcJAleBnsDd6e93yIW4IL3
 Iq5c7j9HRmCScOu2jq19jaz0PbwDg3Rc5bMn9Io5NwFLVeuyJMPB2kZ+v
 sBxW0mtGwVMsNOcM+aaVB96bkVPL8iJ6Z8nMANxG7w+hc0jB/OGrBdKCu
 JBW2y7QY28EWe6xY0DOgjTFTptDYMYQSsi/OnK3v1r0pGGUYipblRw125
 bvAuggZAoRRaTrQ9EZ07wco+/I2t+7SdwCsMzMZJDI5XgODjUIzFZ7Epf
 bK10qMR0F45AHIqRxTvgD+bLTNzr01vYtHVJ8ThDFiSUVu88qeISnSb+J w==;
X-CSE-ConnectionGUID: 5YVbDzP3QBKTJWj88SJGHg==
X-CSE-MsgGUID: +TXACrrXR3mgfwLV5M8GAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="83405351"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="83405351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 21:31:37 -0800
X-CSE-ConnectionGUID: ymvli4Z/TE6y6T3odq1pvw==
X-CSE-MsgGUID: Dhh0sSZcRCCAJ/2t5rIWfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="212581407"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 21:31:36 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v5 5/7] net/ice: add L2TPv2 hardware packet generation
Date: Tue, 26 Aug 2025 22:35:39 +0530
Message-Id: <20250826170541.5010-6-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826170541.5010-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20250826170541.5010-1-shaiq.wani@intel.com>
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

