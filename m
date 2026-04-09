Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4578BE9DE5D
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 07:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFA71402E4;
	Thu,  9 Apr 2026 09:49:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id DC2B7402D1
 for <dev@dpdk.org>; Thu,  9 Apr 2026 09:49:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775720970; x=1807256970;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=MS7nAFpotnv4zPCRAvRBNWMrYqqwgEyDhfL+IvFqY5M=;
 b=fCOYO9lDRvGNJ7Ilw8Ibd3trO6jU5SQkt9duKwO4XBPW7mqhY88M/lIV
 LS+O3A45ol+EOt+pbfVjhq4T+1XAMVFwrmTfCVUSNfqACDI2iWnMpxcSb
 1DBZw1iIsUUHfC50ezL+WaiOdpNNqSMD2aUXJjMiQUbY6slXVETCvO8I7
 FEICI6PrdCN3rpP/I2gTtB+X7oHEAFbfHRkMnYnBhf97aKLFoQTndvm6V
 PVUpYmBNoD+kQRv1AcyEbd0PIbqmZrxx/8GbhWtgCUuX0T5Dn61enN1sk
 ZH2eYBIOlRuWwz0+NPWh12epRgKn4gzyi/NG6x0X4PwJXHTtkifBzdX98 A==;
X-CSE-ConnectionGUID: HDBOZFogT2ew74U8myi7sA==
X-CSE-MsgGUID: fTGayolkTLSLF89NZWj9xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="88105661"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="88105661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:49:29 -0700
X-CSE-ConnectionGUID: MvCWQBsmSSCO3a6KpmGhCg==
X-CSE-MsgGUID: MAqmUNK0TzaJ1jdKVquWQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="222200547"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2026 00:49:27 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v3] net/ice: detect L2TPv2 tunnel type in pre-scan loop
Date: Thu,  9 Apr 2026 13:14:40 +0530
Message-ID: <20260409074441.3424824-1-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406081355.3241393-1-shaiq.wani@intel.com>
References: <20260406081355.3241393-1-shaiq.wani@intel.com>
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

The pre-scan in ice_fdir_parse_pattern() recognises VXLAN and
GTPU items but not L2TPV2.  When an L2TPv2 item is present, tunnel_type
stays NONE, so the ETH item handler stores MAC addresses in the inner
ext_data struct instead of ext_data_outer resulting in rule not matching.

Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 detection alongside the existing VXLAN
check.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v3:
- Fixed check-patch issue.
v2:
- Split from combined outer-MAC patch into a seperate fix.

 drivers/net/intel/ice/ice_fdir_filter.c | 2 ++
 1 file changed, 2 insertions(+)

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

