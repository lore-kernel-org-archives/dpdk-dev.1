Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7A606A31A
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UVuola9z
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 275444068A;
	Thu, 22 Oct 2026 18:52:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 9A56240664;
 Thu, 22 Oct 2026 18:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687933; x=1824223933;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RwemnS2AX3LrpSFXeYYz7B75eeS1M58jGfPLazLt5Yc=;
 b=UVuola9zazsgiWFa6NZw/VsBPj7OzfgzyVJphID4sixcJRxQEo8oTT9f
 WSw8uyWAFWNnbHeaDexwhyXOHhp3k0EuT2H3h6HBPUMuO7cjjEAOapKzn
 dRaUlvcL70G6PP7G41evf5sS1Rnuk97e/Mksxva4iy0Z2A/jCoW+b0cQZ
 e8moUPvo9px5x++DcQh7oJr9WFk7NFWpJXmOLaguUP+C1uGGB77O2M/c6
 vZGAd/OyZEulq/enURpTQsdIrRiGHwQyW+e8llR2grO2DBqFNdo0MioFZ
 wTqLr+msOa9lDqmp/7a6exKhV/qrYM1uwQlXUtucpS5pDf70YFkD+pS9P g==;
X-CSE-ConnectionGUID: Kuwnm0kdR5iwlgbk17vJkg==
X-CSE-MsgGUID: mTiyi5LUSgGvb1PBRpiZ9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341027"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341027"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:13 -0700
X-CSE-ConnectionGUID: jp2dOcq/QkifF5rMAalvww==
X-CSE-MsgGUID: YWIjFv2NT/ihp2jpWnPXMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507816"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:11 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Krzysztof Galazka <krzysztof.galazka@intel.com>, stable@dpdk.org,
 Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH 2/9] net/ice/base: fix integer overflow in RL profile
 calculation
Date: Thu, 22 Oct 2026 16:51:58 +0000
Message-ID: <20261022165205.1830735-3-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Krzysztof Galazka <krzysztof.galazka@intel.com>

When calculating the Tx rate limit profile, BIT_ULL(i) multiplied by
ICE_RL_PROF_TS_MULTIPLIER overflows to zero for large values of i,
resulting in a division by zero. Divide the PSM clock frequency by the
multiplier once before the loop instead.

Fixes: 93e84b1bfc92 ("net/ice/base: add basic Tx scheduler")
Cc: stable@dpdk.org

Signed-off-by: Krzysztof Galazka <krzysztof.galazka@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_sched.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_sched.c b/drivers/net/intel/ice/base/ice_sched.c
index 2b867b74de..7e1defa955 100644
--- a/drivers/net/intel/ice/base/ice_sched.c
+++ b/drivers/net/intel/ice/base/ice_sched.c
@@ -4014,32 +4014,30 @@ static int
 ice_sched_bw_to_rl_profile(struct ice_hw *hw, u32 bw,
 			   struct ice_aqc_rl_profile_elem *profile)
 {
-	s64 bytes_per_sec, ts_rate, mv_tmp;
-	int status = ICE_ERR_PARAM;
+	u32 ts_freq = hw->psm_clk_freq / ICE_RL_PROF_TS_MULTIPLIER;
+	u64 bytes_per_sec, ts_rate, mv_tmp;
+	int i, status = ICE_ERR_PARAM;
 	bool found = false;
 	s32 encode = 0;
-	s64 mv = 0;
-	s32 i;
+	u64 mv = 0;
 
 	/* Bw settings range is from 0.5Mb/sec to 100Gb/sec */
 	if (bw < ICE_SCHED_MIN_BW || bw > ICE_SCHED_MAX_BW)
 		return status;
 
 	/* Bytes per second from Kbps */
-	bytes_per_sec = DIV_S64((s64)bw * 1000, BITS_PER_BYTE);
+	bytes_per_sec = DIV_U64((u64)bw * 1000, BITS_PER_BYTE);
 
 	/* encode is 6 bits but really useful are 5 bits */
 	for (i = 0; i < 64; i++) {
 		u64 pow_result = BIT_ULL(i);
 
-		ts_rate = DIV_S64((s64)hw->psm_clk_freq,
-				  pow_result * ICE_RL_PROF_TS_MULTIPLIER);
-		if (ts_rate <= 0)
+		ts_rate = DIV_U64(ts_freq, pow_result);
+		if (ts_rate == 0)
 			continue;
 
 		/* Multiplier value */
-		mv_tmp = DIV_S64(bytes_per_sec * ICE_RL_PROF_MULTIPLIER,
-				 ts_rate);
+		mv_tmp = DIV_U64(bytes_per_sec * ICE_RL_PROF_MULTIPLIER, ts_rate);
 
 		/* Round to the nearest ICE_RL_PROF_MULTIPLIER */
 		mv = round_up_64bit(mv_tmp, ICE_RL_PROF_MULTIPLIER);
-- 
2.43.0

