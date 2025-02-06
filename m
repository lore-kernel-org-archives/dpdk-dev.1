Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F98C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 915F940EE6;
	Thu,  6 Feb 2025 17:09:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 2F9F840E96
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858150; x=1770394150;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0OgAHM7c3u/VbAAu2K9MBr/5NL/6r7Lm/BI3AOjsFZU=;
 b=T9jPsElRuITdodi1Xpe41igTsBOYNCfyP0ahnsjSwF42Z+Tw8rMBNHGM
 D0P93ltzJSSmQ7mpjRf5GHG6EhgDnbFZ44ohK5JKm1BWyR1BW+Fd84vVo
 okf6FUZffPVzscHb/OdpuS7D3WjowDt4UkSDWMgp4oHf+taf+5o1tBno2
 BQ7Nowxf7VQy5Xri7W+mfJclWnsaiX0DhVs/WaiC2J3CgnFTqxCKk5Vfj
 khSVG7aUSJfnPFdMYEaujkIBdyrWvtHncCZIi+jq3AKwBsn5og8dI4WZ9
 uNHyHyTu4cVHgAQb1HXqjzc717EAI1bsc20bFd/QGgniqrx2v+wmXdBLi Q==;
X-CSE-ConnectionGUID: dRETniApQKy+co3tX0/cnw==
X-CSE-MsgGUID: hu5d2vJ3SrK8WW4w/47u0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860720"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860720"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:09 -0800
X-CSE-ConnectionGUID: kYnx0quMS0CIiRDhBaZ0Mg==
X-CSE-MsgGUID: ADsJ+TqeThOibRnyCb4NoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166690"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 06/24] net/igc/base: fix LTR for i225
Date: Thu,  6 Feb 2025 16:08:29 +0000
Message-ID: <6b671dbcfb6eb8aa802926d494c6808351ae1cae.1738858026.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

i225 specification recommends minus 1 microsecond from a value
calculated for a LTR. Fix the calculation to match spec.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index 003c060215..e701d00f80 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -1071,7 +1071,9 @@ static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
 		scale_max = (ltr_max / 1024) < 1024 ? IGC_LTRMAXV_SCALE_1024 :
 			    IGC_LTRMAXV_SCALE_32768;
 		ltr_min /= scale_min == IGC_LTRMINV_SCALE_1024 ? 1024 : 32768;
+		ltr_min -= 1;
 		ltr_max /= scale_max == IGC_LTRMAXV_SCALE_1024 ? 1024 : 32768;
+		ltr_max -= 1;
 
 		/* Only write the LTR thresholds if they differ from before. */
 		ltrv = IGC_READ_REG(hw, IGC_LTRMINV);
-- 
2.43.5

