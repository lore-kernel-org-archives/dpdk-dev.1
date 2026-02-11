Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BBEB5969
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 06:10:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A7E640612;
	Wed, 11 Feb 2026 07:10:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 2CEBA402D9
 for <dev@dpdk.org>; Wed, 11 Feb 2026 07:10:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770790230; x=1802326230;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=doigNYn8mbt3BmpE6ZNueFYuJUchwJAOFVYgb9kAbFI=;
 b=itUpAimQRHe12YptERipA/T0aNdnQiLOMJIuyIi8dDgsNX/6iAZZ1BCH
 JZnZVzq2ZX+qXY4aqv6WeAVbCXi8RZ/rd/I4jlJ7gWbmnlzuA1hghVA/p
 wKjU6piLnNJHh0ajdFuEiRrAuGo6wZl+XGXbldJ/GEWbS3epug3v2Q4+H
 0LjtM6hkRvX3HWvlOrJ6UBHX/K1b/J8mE6NtG6fvtF1+cYQE42n7lE1gA
 UIDuwERmkmwCPWwDOEN73MD+dvmywxtvzNAoCKge2dXJH+bej0FfC+9zI
 nY3Q4gGe1rnV93PrVq+fCQPyoP4QL6XOs8jWHNJ+IlMncoCDjK1BEeog1 Q==;
X-CSE-ConnectionGUID: C7rwYPW7TfGEgBK8M3DE5g==
X-CSE-MsgGUID: jKm1XTG/Saie1JVex6hKSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71829053"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71829053"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:10:29 -0800
X-CSE-ConnectionGUID: 97uNSj8UQjiYo6kPNerLxA==
X-CSE-MsgGUID: f7ZVPyYgSZyIDtVuUGBr8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216655463"
Received: from unknown (HELO srv24..) ([10.138.182.231])
 by fmviesa005.fm.intel.com with ESMTP; 10 Feb 2026 22:10:27 -0800
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: Song Jiale <songx.jiale@intel.com>
Subject: [PATCH v3 2/7] net/ice: add L2TPv2 tunnel type definition
Date: Wed, 11 Feb 2026 11:39:05 +0530
Message-Id: <20260211060910.219419-3-shaiq.wani@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211060910.219419-1-shaiq.wani@intel.com>
References: <20260202094244.447966-1-shaiq.wani@intel.com>
 <20260211060910.219419-1-shaiq.wani@intel.com>
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

