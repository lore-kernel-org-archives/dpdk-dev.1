Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65581C71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 08:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B97D040B8D;
	Tue, 17 Jun 2025 10:24:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3B00A402DC
 for <dev@dpdk.org>; Tue, 17 Jun 2025 10:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750148655; x=1781684655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZSws1TvGDUlxmhbQiDqWqRS9TQuD+MDib9pIS/C79dU=;
 b=nBcxvIdpQfGFXs3aFxDM8lB5NjyPuZh7gjNw8sh/FzqlofTj2+Wq1Ab8
 31Y7gekmEB0NuzyndkhVnwI4m4qNs6VHpw78wP1r9KYp4O+4F05OjPHqW
 B3EzMvVwQ6ufgI8t0jKAmAtgRQgVnSJ9qHJp7XjoKA7XyBBxzxnhjZ4kw
 MmCUJsLY1JbGrALB/koo7etJJFg/yOQ4OnGZcaVx9+wFQ62VRxRXa9bCM
 z3Y1+YQBFW7qmigvoTJ/Xx8jaedS0ZcdLcblOCaR9N6KBetgWDqNumW+L
 t0CjgpHOae5q4nCIbO5qifKcwglQvmf4cclP+cp+HS6EnO3p5S85y95dQ Q==;
X-CSE-ConnectionGUID: 1uzshsjDTdGAgrun9cTTig==
X-CSE-MsgGUID: SJRXg8gPQsO3OCxI2hq5pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52449726"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52449726"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 01:24:14 -0700
X-CSE-ConnectionGUID: 2zV42EJ8QtCmsnpl9Ba4lQ==
X-CSE-MsgGUID: 8mU1NV0pSIWGomJNwCs1zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="148563827"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa006.fm.intel.com with ESMTP; 17 Jun 2025 01:24:12 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com,
 Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v5 1/4] net/ice: update E830 Tx Time Queue Context Structure
Date: Tue, 17 Jun 2025 00:14:26 +0000
Message-ID: <20250617001429.551262-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617001429.551262-1-soumyadeep.hore@intel.com>
References: <20250610131159.495566-2-soumyadeep.hore@intel.com>
 <20250617001429.551262-1-soumyadeep.hore@intel.com>
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
2.43.0

