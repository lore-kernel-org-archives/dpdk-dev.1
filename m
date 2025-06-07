Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4298BC5B543
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 01:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63A3D402C5;
	Sun,  8 Jun 2025 03:18:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id B01FB400EF
 for <dev@dpdk.org>; Sun,  8 Jun 2025 03:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749345522; x=1780881522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iLo9mnn9+0kVVyafAzWEeH7EweOQ+q4WX5/371Guncc=;
 b=KPZ2I/UkKjAzg1+m5oH3FyKPxXGx2HraNebaW4kAE9zY2XeWi1VjCPy/
 Po3CDPzaTqWAGtpklgBUlZBzbcRUPPzHGozZ4Fpdd3l40zFvBLznYOG6i
 UG4wIeDoFUh1t/f9jHcUbr8He+DVw5K2nW9/vm7U68pGm/f18kZaJhCnS
 E5FoR5UmF9UpEANgcOlVzRQ1ZYM8ZlCcYIBAXBgnJhqYsCTQyDyUseTaO
 6WSY34RYN4m8S8/+awMUaxgMQ1vNRuhYD4zxZnRzr2XSBh/QKwyiiKu+9
 AyW8mgfE0KkoKdzgy8fR3QfiTohb8GyZ19Bp3iQEh6yqyo/1n4Me0JXpY w==;
X-CSE-ConnectionGUID: 8lj6eld2S12a39e+leSJYQ==
X-CSE-MsgGUID: xD5ZJi/LRXuJu0EbvpvVPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11457"; a="62856894"
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="62856894"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2025 18:18:42 -0700
X-CSE-ConnectionGUID: wwNT5wgCTr2VxJrnYrDvtQ==
X-CSE-MsgGUID: 5T/pSKLtSNesqKY+1dxokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,219,1744095600"; d="scan'208";a="146676562"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa010.fm.intel.com with ESMTP; 07 Jun 2025 18:18:41 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com, manoj.kumar.subbarao@intel.com,
 Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v2 1/6] net/intel: update E830 Tx Time Queue Context Structure
Date: Sat,  7 Jun 2025 17:08:59 +0000
Message-ID: <20250607170904.480937-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607170904.480937-1-soumyadeep.hore@intel.com>
References: <20250606211947.473544-2-soumyadeep.hore@intel.com>
 <20250607170904.480937-1-soumyadeep.hore@intel.com>
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
index fce9b070cf..d6be991fe3 100644
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

