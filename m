Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CF8FF885D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 02:40:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EAD840658;
	Mon, 27 Apr 2026 04:40:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id BAAD34064C
 for <dev@dpdk.org>; Mon, 27 Apr 2026 04:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777257606; x=1808793606;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=G/cPM9Ju98GQnFDMxKGyFtVx0E5afXqvy636q9G/L7c=;
 b=TTYZTOTTK8Ucz4uT0WLtL6muKrtsuO8pimMJ7qSWfJuAsnUap1OX+95W
 dMOk66OgKoKQYqufCpOoDVpyX52wU8Ca9fN3dGG23EyY1065qKuW/yCQL
 j1+7D0OPMsY+DIGxVFn19fR5JjDlEicivfqEmhRJJH7ZdyfxGshP4Qxlz
 AP/qJ2Il8T+EvpDrXj132ETiSIBh2ynALQlh5OCvCEhXEOMRh+Wjy12R7
 PV94doVGQfNQjx5p6OWG+ysnJEZRvOzKYm1wx+YkboEgspQT0yRY4PXkh
 oyDXCOXquCinwImKYrrwezTfl0ajhY31OFqIfvaPOu5zUnOssCYUovrmH w==;
X-CSE-ConnectionGUID: aeOCaOLeSmCTtHDG0AMUTA==
X-CSE-MsgGUID: LyY0rAgDTOuI1HsR0JywBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="95703509"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="95703509"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2026 19:40:06 -0700
X-CSE-ConnectionGUID: m4gxHFqGRAud7yDmxLqHDQ==
X-CSE-MsgGUID: dsam+pztRy+Ody6NS3Mgqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; d="scan'208";a="271637693"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by orviesa001.jf.intel.com with ESMTP; 26 Apr 2026 19:40:04 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH 5/7] net/ice: fix GTP-U failure due to wrong tunnel profile
Date: Mon, 27 Apr 2026 08:01:13 +0530
Message-ID: <20260427023115.1225843-6-shaiq.wani@intel.com>
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

Remove GTP-U tunnel types from ice_fdir_is_tunnel_profile().
GTP-U uses a non-tunnel profile path and should not be marked
as tunnel, which causes training packet generation to fail.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
 drivers/net/intel/ice/ice_fdir_filter.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index c2fd07e527..0531208066 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1393,9 +1393,7 @@ static int
 ice_fdir_is_tunnel_profile(enum ice_fdir_tunnel_type tunnel_type)
 {
 	if (tunnel_type == ICE_FDIR_TUNNEL_TYPE_VXLAN ||
-	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2 ||
-	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_GTPU ||
-	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_GTPU_EH)
+	    tunnel_type == ICE_FDIR_TUNNEL_TYPE_L2TPV2)
 		return 1;
 	else
 		return 0;
-- 
2.43.0

