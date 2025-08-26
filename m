Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65912EDF032
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 04:53:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DB314060C;
	Thu, 12 Feb 2026 05:53:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id EADF4402E2
 for <dev@dpdk.org>; Thu, 12 Feb 2026 05:52:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770871976; x=1802407976;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doigNYn8mbt3BmpE6ZNueFYuJUchwJAOFVYgb9kAbFI=;
 b=eY+sgTJfgJEGcey5hzc7YTWUVqjFWGjAU7pqg9BQQB7VBD6AiRhSbEAY
 5bXwq4FoDZ/fvevYZ8IrIYqoZ3jWeYdFW4Lr71hfn3ymoeMAE6xNCveFb
 E3y4kbo0wv6Ao0XlWJw0NLsvL7cPbAO0ufm3RAXHv9+bTpek8wbAKHtXB
 oMrVNCO+Xb3249B56CvioFFtHNK4OoufDW/97M/XlHrmrEKhlQGcznnxs
 BTe5JTunINzuFZVvtJnGgcWL+QAdtHEs/XkQDYb5Nx/flaMPlTcS7T6KI
 sXBOxFjHB5KORt2haJrLXzmB9UG8WByUmvOPzQmz4FoTu3asaFJ6I7PUM g==;
X-CSE-ConnectionGUID: EyRPGnx0Q4m9Ankqxad5IA==
X-CSE-MsgGUID: bu57pQ8uSmOXj9GsZMCPnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71940237"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71940237"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 20:52:55 -0800
X-CSE-ConnectionGUID: tJn3yBjwSdiHZyqLC7/unQ==
X-CSE-MsgGUID: xpWEUo+cSsiribN8xQztBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="216715410"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa004.fm.intel.com with ESMTP; 11 Feb 2026 20:52:53 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v4 2/7] net/ice: add L2TPv2 tunnel type definition
Date: Tue, 26 Aug 2025 21:56:59 +0530
Message-Id: <20250826162704.4636-3-shaiq.wani@intel.com>
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

