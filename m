Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA669C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 18:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 342344067A;
	Mon, 26 May 2025 20:03:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 7D90840674
 for <dev@dpdk.org>; Mon, 26 May 2025 20:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748282612; x=1779818612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eDSnU4M1FRcLAi9SsfKa4i9qay+277UoDpfrtIjjk7Y=;
 b=OPODtQ/GIuEydMBP9CSPqOB2qcwODPTPlHZzO3booLcwdPCHaf6PAIxC
 DHh4I0ywz/EqjUzaRuy1DC1AkdcUOv1EFF5tFjrPokl54bWjeJ7AgUz9G
 vJtNoZwcKHBkZ8HtzlIiImbngCmx5DOWmrO4qu7JZjci8tjLJ6V39ajjB
 cXxnBhEmpxbcPiDzBiRhVz75ESzWhccDiibBsQbrAJJIHGZFdUAUhgSTw
 TlAS+q0ZIzGl3XNZq9mYY2R3CamcazxxPf+avXHjNYZ2cmbjtHvh/b6qK
 oL/QIkLd99NQ2whfvDuwAgUCy0M2CExRIqBG3ddXyVtJMfDje6+ZBdbRy A==;
X-CSE-ConnectionGUID: XO+npAdXRh6J+nCxyXmV4A==
X-CSE-MsgGUID: iWvLMbXVT7G7RMzJPjwvMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50375164"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="50375164"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 11:03:32 -0700
X-CSE-ConnectionGUID: mVp3e1N3TkePJfJ6htDaRQ==
X-CSE-MsgGUID: ADvNNYUBRtWbHtgYBaMYFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; d="scan'208";a="142478300"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 11:03:31 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v2 02/10] net/ice/base: typo fix in media type check
Date: Mon, 26 May 2025 18:02:50 +0000
Message-ID: <20250526180311.4573-3-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
References: <20250526180311.4573-1-dhanya.r.pillai@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

Found a typo in original implementation of ice_set_media_type,
where one of the checks for FIBER checks for C2C media type
instead of C2M. This results in failure of this check for some
AOC devices, consequently setting  the media type as AUI.
Bug was found in ethtool.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Dhanya Pillai <dhanya.r.pillai@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index fce9b070cf..69070b740e 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -452,7 +452,7 @@ static void ice_set_media_type(struct ice_port_info *pi)
 		 ((phy_type_low & ICE_MEDIA_OPT_PHY_TYPE_LOW_M ||
 		   phy_type_high & ICE_MEDIA_OPT_PHY_TYPE_HIGH_M) &&
 		  (phy_type_low & ICE_MEDIA_C2M_PHY_TYPE_LOW_M ||
-		   phy_type_high & ICE_MEDIA_C2C_PHY_TYPE_HIGH_M)))
+		   phy_type_high & ICE_MEDIA_C2M_PHY_TYPE_HIGH_M)))
 		*media_type = ICE_MEDIA_FIBER;
 	/* else if PHY types are only DA, or DA and C2C, then media type DA */
 	else if (ice_phy_maps_to_media(phy_type_low, phy_type_high,
-- 
2.43.0

