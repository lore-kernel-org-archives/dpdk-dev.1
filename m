Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A8C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B044740F16;
	Thu,  6 Feb 2025 17:09:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 93B9A40ED3
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858152; x=1770394152;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cbemJGSjxAR7opooj1muviIvcEFbc5BdcMfvgzO2FaA=;
 b=AkhviqI0ZIg0Ix5vPpKuZ8vJLcCoPmNNKDC2WT9urZ89L4OGIRlNYBvG
 U8hYnvAvOoHLCuV9WxLhEC7Ll4CzWfBykIOOAdPTy6T2MFaVBHvqcJH16
 zvtQEZGjgUaKqNCMwgwCMXBPsT8xNBrjuuQdIjEzUD48FhPkx7arGdP2w
 fsMFaDBOpk7A0Bb6tO+VdgiQNGFk22s7j8bfgPr7WZ7ImBl7XfxrgTdgu
 j0xBIC7A0ORmBPbbQY0ZnpgYlQR01zsexNL6uvQJSZH+MQiRtFGYysjGI
 lKRdTtJ0VvE1BNLNqQECtxnYU+2UtHKOjSesbkea1lHJkBVPe+yqTJFBh Q==;
X-CSE-ConnectionGUID: 4RaR/7sJTRahy3BA4vwRPg==
X-CSE-MsgGUID: hxug8uniQx25NYJWLR6XAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860721"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860721"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:10 -0800
X-CSE-ConnectionGUID: EOqzXE9SSN67BY4FDbAz0w==
X-CSE-MsgGUID: y5xKRYVeQ7+RK5ytE8lozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166723"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@intel.com>,
 Alvin Zhang <alvinx.zhang@intel.com>
Subject: [PATCH v1 07/24] net/igc/base: fix typo in LTR calculation
Date: Thu,  6 Feb 2025 16:08:30 +0000
Message-ID: <d3f5c66b0a631237b2e5e15d1d833072d5083a4b.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

The LTR maximum value was incorrectly written using the scale from the
LTR minimum value. This would cause incorrect values to be sent, in cases
where the initial calculation lead to different min/max scales. Fix the
typo to correctly calculate the LTR maximum value.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index e701d00f80..c7c2ec8ffe 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -1086,7 +1086,7 @@ static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
 		ltrv = IGC_READ_REG(hw, IGC_LTRMAXV);
 		if (ltr_max != (ltrv & IGC_LTRMAXV_LTRV_MASK)) {
 			ltrv = IGC_LTRMAXV_LSNP_REQ | ltr_max |
-			      (scale_min << IGC_LTRMAXV_SCALE_SHIFT);
+			      (scale_max << IGC_LTRMAXV_SCALE_SHIFT);
 			IGC_WRITE_REG(hw, IGC_LTRMAXV, ltrv);
 		}
 	}
-- 
2.43.5

