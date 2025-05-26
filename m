Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C02BC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 08:34:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1BA5640667;
	Mon, 26 May 2025 10:33:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 60BD6402A0
 for <dev@dpdk.org>; Mon, 26 May 2025 10:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748248435; x=1779784435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qSs99kAO8tbXer0roLYv/i4MPOVvNGzDTLfjxfpTMy0=;
 b=VcJK6O6mKwOzd7b4uNfFILCK+NWyf+I5k4AzLgh5gi8YAS3xTTC0oDXY
 Nfelxh8xEiyQ1dfZLo1HTITJrT1kRi14RElKe9XbPDZsd/1iJmWIXK9QH
 XhbKCqP3OXD+q5O8ZNCcMiz+XQz0APVz6YC4lz1ehidDj1/+MrEz69pBr
 G+O3ZM/PRgUlCun3ZpiFIsrqSCfNoQqUiPgfxU3ODg102EIpNYARM13ny
 Cylo23fy20J+VsXqt8EPz+mYEXa20I2mNYcpRh+fVb5h8uEy48iLcqNp6
 C0iD2bKrjXE8MTVxOUuoQ1rwOC8PsP5R6ncxOdFaIUjN770uj/IINanVY g==;
X-CSE-ConnectionGUID: D441rwCyTOugoFf+lCEqvQ==
X-CSE-MsgGUID: oOhel3ptSfy4jYjzidh8rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="54009008"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="54009008"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 01:33:55 -0700
X-CSE-ConnectionGUID: DFyPR15LSNCyydI1Xs9t3A==
X-CSE-MsgGUID: PGyT4pFZRPa7ronoaW9mgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="142293450"
Received: from unknown (HELO silpixa00401120.ir.intel.com) ([10.55.128.58])
 by fmviesa007.fm.intel.com with ESMTP; 26 May 2025 01:33:54 -0700
From: Dhanya Pillai <dhanya.r.pillai@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Paul Greenwalt <paul.greenwalt@intel.com>,
 Dhanya Pillai <dhanya.r.pillai@intel.com>
Subject: [PATCH 2/9] net/ice/base: typo fix in media type check
Date: Mon, 26 May 2025 08:33:04 +0000
Message-ID: <20250526083325.248384-3-dhanya.r.pillai@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
References: <20250526083325.248384-1-dhanya.r.pillai@intel.com>
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

