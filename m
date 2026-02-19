Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410FAE9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 11:25:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1F724060C;
	Thu, 19 Feb 2026 12:24:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 8E53F402E4
 for <dev@dpdk.org>; Thu, 19 Feb 2026 12:24:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771500289; x=1803036289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doigNYn8mbt3BmpE6ZNueFYuJUchwJAOFVYgb9kAbFI=;
 b=gpkKfsTHBS/O+r2m5qqFPUxJUSOuqCOhmvLBixex9Vt3OHOeCHgDE06c
 Do5wj63c3jSw9Qvg6i0DazzEYvM8+v94IRn5XNRqlqeqLTnx5R+ZVS0hs
 UP2bgYu0k4u24SngGcU6VkWYWnKCYaK2KninwbnWSH4/QBX5bDCrGGlUz
 diWdFnd8PoO0DYEt/yAl/peuMJM7NJ3aEzCgHL+yob3CBZYBCii6bFbmx
 iri1Qao7dy9cZDa1hbHJDbk6x6QI18ntMLn9C9d+d6mFNDZIEqG9jML2A
 QWtZL0KGIIgqF+sVEZSV/qqcwgxCwqn2fF9lzGuUuac3cOFKqoOc/cb2F g==;
X-CSE-ConnectionGUID: Pfvhv9jUQyGBSnVH5b8PDQ==
X-CSE-MsgGUID: zEHPz/8ER3OE8vc45m0UQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="76198675"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; d="scan'208";a="76198675"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 03:24:48 -0800
X-CSE-ConnectionGUID: ttAj3b5dTTaMfu3wHxwp0g==
X-CSE-MsgGUID: MZ8asKxARiqpi5zCkAD3wg==
X-ExtLoop1: 1
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa003.fm.intel.com with ESMTP; 19 Feb 2026 03:24:46 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v7 2/7] net/ice: add L2TPv2 tunnel type definition
Date: Thu, 19 Feb 2026 16:50:58 +0530
Message-Id: <20260219112103.2370766-3-shaiq.wani@intel.com>
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

