Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC4AC54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B083A4069F;
	Tue, 27 May 2025 15:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id B678340662;
 Tue, 27 May 2025 15:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748351871; x=1779887871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D4bkCudJhbX60DMIv9HOgktEbnTzawE/GA8lA1T2sjs=;
 b=I1N/7UZ/cSyPJ7Nx5kvp+jNfnYcPz8RwjUVdf5mew2qoEC7bpR3twQ1e
 G3HGj1JHUUgEjZs7glAU9TaX/d1+aFo6IjMCS8cgB8vrkiQaNbJONeXs2
 ZSq/UA0Psb6+DH/xj8LjFYPAWPE+235I31Ga1PLVtQiUVe+7mHE0EoZU6
 pWcwtPMOEptS27fR/toSVkVwrXgpmcjCiffqHpb/KB1YJuO+T+48ENCu6
 NFB7GnuR9KVf/cWdBTO3xLZ27Jmu3D9h2cJWqZQBGAyAG+zLoefk5TzrQ
 xGAkn0euRbDVtkVfPBeGy9NGUAetoqX091FzHfB1ITGCoJ2krgo9Y4DpL w==;
X-CSE-ConnectionGUID: qhqWNC91QyaGW024YQK57w==
X-CSE-MsgGUID: bwqB7wCIS1e4yqklRXQQ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67884825"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="67884825"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 06:17:50 -0700
X-CSE-ConnectionGUID: IZ1069iUQQC4MveHeU3Jeg==
X-CSE-MsgGUID: sJm2qbSjQNuOLQDeDXE7vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; d="scan'208";a="143150031"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa008.fm.intel.com with ESMTP; 27 May 2025 06:17:49 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ian Stokes <ian.stokes@intel.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Alice Michael <alice.michael@intel.com>
Cc: dev@dpdk.org, stable@dpdk.org, Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH v3 02/10] net/ice/base: fix typo in media type check
Date: Tue, 27 May 2025 13:17:21 +0000
Message-ID: <20250527131741.7606-3-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
References: <20250527131741.7606-1-dhanya.r.pillai@intel.com>
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

Fixes: e7bd7d54a26b ("net/ice/base: improve PHY media capabilities handling")
Cc: stable@dpdk.org
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

