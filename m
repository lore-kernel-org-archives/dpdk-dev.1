Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE69EE81BA6
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 11:58:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7402040655;
	Mon,  9 Feb 2026 12:58:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id B200140612
 for <dev@dpdk.org>; Mon,  9 Feb 2026 12:58:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770638304; x=1802174304;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doigNYn8mbt3BmpE6ZNueFYuJUchwJAOFVYgb9kAbFI=;
 b=lXOczF8sVBA3hqHzYfTVL3Ar0ZCfESF3nEIVVJMVEacdEV8YER2Z3MXV
 Fvc83H4IHV6bqm7sYREFsFd+jBhYjwuG1RbJo1rKzws/ZGAvGgQqAW1yu
 57ckf9Qm5NqDLI55nsBAuXkCUZhzlUO3YKgEkwbpl4KPgYPYHo359G2F4
 wEpOiI9EYGRiYjSCKqkrsMIvGGS2KJQ+joneljAvbSb2XrvjUw44maZvb
 wI5/Rh7Dgjl2VY9YTIYWTIQmp3FmRRlM+R3dNowDJVNErWPeoHgshxaMA
 dvNWtLKBo3CnSsDCEJuUwEAIom5SkSFn06Zm14K1goqqyM1t+fOtgCN3R Q==;
X-CSE-ConnectionGUID: EVb0+1rQS8+MXIbe1LQRNQ==
X-CSE-MsgGUID: 7/QihahcR3i+jd+IJPo5VQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71640958"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71640958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 03:58:23 -0800
X-CSE-ConnectionGUID: mt5VFWyNQ3OUTIgjOdn4hA==
X-CSE-MsgGUID: iLKjX6GlQ1OsCJ2504GDag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="211627083"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by orviesa007.jf.intel.com with ESMTP; 09 Feb 2026 03:58:22 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v2 2/7] net/ice: add L2TPv2 tunnel type definition
Date: Mon,  9 Feb 2026 17:26:52 +0530
Message-Id: <20260209115657.636525-3-shaiq.wani@intel.com>
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

Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 to the tunnel type enum and
extend ice_fdir_fltr_pattern structure to include L2TPv2 data and
mask fields.

Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Tested-by: Song Jiale <songx.jiale@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 9562b2b8f1..4b3718f715 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -369,6 +369,7 @@ enum ice_fdir_tunnel_type {
 	ICE_FDIR_TUNNEL_TYPE_VXLAN,
 	ICE_FDIR_TUNNEL_TYPE_GTPU,
 	ICE_FDIR_TUNNEL_TYPE_GTPU_EH,
+	ICE_FDIR_TUNNEL_TYPE_L2TPV2,
 };
 
 struct rte_flow;
@@ -405,6 +406,9 @@ struct ice_fdir_fltr_pattern {
 	struct ice_fdir_udp_gtp gtpu_data;
 	struct ice_fdir_udp_gtp gtpu_mask;
 
+	struct ice_fdir_l2tpv2 l2tpv2_data;
+	struct ice_fdir_l2tpv2 l2tpv2_mask;
+
 	struct ice_fdir_extra ext_data;
 	struct ice_fdir_extra ext_mask;
 
-- 
2.34.1

