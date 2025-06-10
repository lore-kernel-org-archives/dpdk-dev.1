Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04B2C61DB2
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Jun 2025 21:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77351402BD;
	Tue, 10 Jun 2025 23:21:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3E286400EF
 for <dev@dpdk.org>; Tue, 10 Jun 2025 23:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749590498; x=1781126498;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Dfy6gCCbDGN1oTj37YDKuiDOkZpeHYTr6AD/YTmZPyA=;
 b=PBfZnuA1J6njIZfNDqJJ/ii/iUV44Z7eZXAQujBt5XLXN7MAn068t4mJ
 nNGxEry5tnykylmON0Wbkz4Rx33Slbv57arP573OhKmII3aL65WkqnONB
 1DWyPcV/g0wKDCH8gYMuYPa7ha/WrwQ0BJBW9cNgVFHzPkpxfLgj6hlS/
 Eo6l5c1jrvQ5q69By6aqnSlZ7FHy5MAt6WY5ruYu8fqfNpYTFnyPvek6u
 +QOoHKO8kBN9dSyqcp4YrQQbIPQE5qcg2tjsQT4QwvFldSlHMXssTaQJ2
 ZoVgsEI28hHAeYxnaAUfldY6UOhGp8knqs3276hN2fHuE0tHseqBMuL1y w==;
X-CSE-ConnectionGUID: FH9GSGHmT5mmEK/PW4CkfQ==
X-CSE-MsgGUID: Zks2EUD2TOKozaRikipq0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51710198"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="51710198"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 14:21:37 -0700
X-CSE-ConnectionGUID: nBuPVvcMQ4+zONz14TDTIQ==
X-CSE-MsgGUID: c225NowDTuONFp3XF0mxhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="170157907"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa002.fm.intel.com with ESMTP; 10 Jun 2025 14:21:35 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com,
 Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v4 1/6] net/intel: update E830 Tx Time Queue Context Structure
Date: Tue, 10 Jun 2025 13:11:54 +0000
Message-ID: <20250610131159.495566-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610131159.495566-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250610131159.495566-1-soumyadeep.hore@intel.com>
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

Updated the Tx Time Queue Context Structure to align with HAS.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 4de9f37989..dfc2fd69e7 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -1671,17 +1671,17 @@ const struct ice_ctx_ele ice_txtime_ctx_info[] = {
 	ICE_CTX_STORE(ice_txtime_ctx, cpuid,			8,	82),
 	ICE_CTX_STORE(ice_txtime_ctx, tphrd_desc,		1,	90),
 	ICE_CTX_STORE(ice_txtime_ctx, qlen,			13,	91),
-	ICE_CTX_STORE(ice_txtime_ctx, timer_num,		3,	104),
-	ICE_CTX_STORE(ice_txtime_ctx, txtime_ena_q,		1,	107),
-	ICE_CTX_STORE(ice_txtime_ctx, drbell_mode_32,		1,	108),
-	ICE_CTX_STORE(ice_txtime_ctx, ts_res,			4,	109),
-	ICE_CTX_STORE(ice_txtime_ctx, ts_round_type,		2,	113),
-	ICE_CTX_STORE(ice_txtime_ctx, ts_pacing_slot,		3,	115),
-	ICE_CTX_STORE(ice_txtime_ctx, merging_ena,		1,	118),
-	ICE_CTX_STORE(ice_txtime_ctx, ts_fetch_prof_id,		4,	119),
-	ICE_CTX_STORE(ice_txtime_ctx, ts_fetch_cache_line_aln_thld, 4,	123),
-	ICE_CTX_STORE(ice_txtime_ctx, tx_pipe_delay_mode,	1,	127),
-	ICE_CTX_STORE(ice_txtime_ctx, int_q_state,		70,	128),
+	ICE_CTX_STORE(ice_txtime_ctx, timer_num,		1,	104),
+	ICE_CTX_STORE(ice_txtime_ctx, txtime_ena_q,		1,	105),
+	ICE_CTX_STORE(ice_txtime_ctx, drbell_mode_32,		1,	106),
+	ICE_CTX_STORE(ice_txtime_ctx, ts_res,			4,	107),
+	ICE_CTX_STORE(ice_txtime_ctx, ts_round_type,		2,	111),
+	ICE_CTX_STORE(ice_txtime_ctx, ts_pacing_slot,		3,	113),
+	ICE_CTX_STORE(ice_txtime_ctx, merging_ena,		1,	116),
+	ICE_CTX_STORE(ice_txtime_ctx, ts_fetch_prof_id,		4,	117),
+	ICE_CTX_STORE(ice_txtime_ctx, ts_fetch_cache_line_aln_thld, 4,	121),
+	ICE_CTX_STORE(ice_txtime_ctx, tx_pipe_delay_mode,	1,	125),
+	ICE_CTX_STORE(ice_txtime_ctx, int_q_state,		70,	126),
 	{ 0 }
 };
 
-- 
2.47.1

