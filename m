Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9357FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86EEE4066A;
	Mon, 27 Apr 2026 04:40:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 8175C4060F
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257609; x=1808793609;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xAiHIqudguEPaJ5+Oi2lldklvHUdrj6tSfGpGDt8Aw8=;
 b=Yn+KrcLWO2WWBM6qn3TosnqqYHFfoz02yACmoMQZVipKMfnQgFVtDXAX
 7Qc7+Zh3o1HaYrSkNvy+DwqJBKQ9yDKw1TcO0wuxtUHEks9Lw4PEj8U8l
 Vi8RqXJxD/qAKGW4+Ed2FcTe8s25oLwvT0b5it8JLQyA33gQDM9FWyz6M
 qp4ebdwug4+4IKLLy0CpZCoU0OpEs9QMwyLpJCktrV/d3IewqgifZXh6A
 sw/onxFxk9nsnJf7/twNbrKgf2hEWjeDca/lSaVvy5DizVuoWmwAtcgBH
 gUVua7XTQsosZalLeu6jl5M+0x1jhhGqHJ7L5DJB8y6Xt+r3xl5D8uFiZ Q==;
X-CSE-ConnectionGUID: 9woafzVSS7upmN7JNOEu+A==
X-CSE-MsgGUID: K2e45WRtR5aVx7RPW7pl1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703511"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:08 -0700
X-CSE-ConnectionGUID: AhHhlQgZTjmVsWdTAXG/Dg==
X-CSE-MsgGUID: h1ykcTThSCurquU3vbZQuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637700"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:40:07 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 7/7] net/ice: pin outer Ethertype for L2TPv2 flow rules
Date: Mon, 27 Apr 2026 08:01:15 +0530
Message-ID: <20260427023115.1225843-8-shaiq.wani@intel.com>
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

L2TPv2 flow rules do not include the outer Ethertype in the input set,
so a rule created for outer IPv6 also matches packets with outer IPv4
(and vice versa). The hardware profile cannot distinguish the two
families because nothing in the match key differentiates them.

Add ICE_INSET_ETHERTYPE to input_set_o and set ext_data.ether_type to
0x0800 or 0x86DD based on the outer L3 item, so the profile includes
the Ethertype field and rejects cross-family mismatches.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 5ea74a4a5c..2f843d66b9 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -2958,6 +2958,19 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	    input_set_i == 0 && !ppp_present)
 		tunnel_type = ICE_FDIR_TUNNEL_TYPE_NONE;
 
+	/* Match outer IPv4/IPv6 for L2TPv2 via Ethertype. */
+	if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2) {
+		if (l3 == RTE_FLOW_ITEM_TYPE_IPV4) {
+			input_set_o |= ICE_INSET_ETHERTYPE;
+			filter->input.ext_data.ether_type =
+				rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		} else if (l3 == RTE_FLOW_ITEM_TYPE_IPV6) {
+			input_set_o |= ICE_INSET_ETHERTYPE;
+			filter->input.ext_data.ether_type =
+				rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6);
+		}
+	}
+
 	filter->tunnel_type = tunnel_type;
 	filter->input.flow_type = flow_type;
 	filter->input_set_o = input_set_o;
-- 
2.43.0

