Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723D8D37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65BC740E4C;
	Wed, 14 Jan 2026 16:45:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9870F40E09
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405538; x=1799941538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fyQlm/py9JVzXBT6o1stdj7v17Ar+vHTL05i+NtvBJY=;
 b=H0Ga5dxzHU5jEGCRNsyMzlOnmKcyACzFPnKcrMKbMLLeZ7vTV3CZMThz
 huG77kwgCwP3KVTXB02RNq8X3E/avcnAiR7Za4EGg/LgVOArXZgpw+dE7
 mVjJHksFT2bLmQ//sO1L2brhnu0XE8Iw0NqWcNn85nX149FVtKt8ptSq+
 xBH0iDHrtypNXUc1KDAZ6cCguSjoy2qqWJiTwgVrcZ1B/G9Q6lFSF41Kg
 rIbCT6FNJsLDQWct/54qYUBRQN7FUOANWkt8IVCIR5AFGqI5KZoCOrEsC
 wWsrv2jh6nJbzs0NT5XwRxRUpLpDtuoj+XkF/TpqZuq2uOHc6qbxpMWB9 A==;
X-CSE-ConnectionGUID: BqvHDZ/PRXOlb8ZLK7Z9HA==
X-CSE-MsgGUID: 38Vgo8kxShOwpqWQ73UzYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870914"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870914"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:38 -0800
X-CSE-ConnectionGUID: TAJa2AgQTgy+a2mYoQMlAA==
X-CSE-MsgGUID: ttPR8Ww6QsiZgM06zozTkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925044"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [PATCH v4 21/31] app/test-bbdev: remove shadow warning from next max
 calls
Date: Wed, 14 Jan 2026 15:44:35 +0000
Message-ID: <20260114154450.2969716-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

Nested use of RTE_MAX leads to variable shadowing for the internal
variables, so use RTE_MAX3 rather than two nested calls.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-bbdev/test_bbdev_perf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/app/test-bbdev/test_bbdev_perf.c b/app/test-bbdev/test_bbdev_perf.c
index 27b0a6f523..9fb0a25948 100644
--- a/app/test-bbdev/test_bbdev_perf.c
+++ b/app/test-bbdev/test_bbdev_perf.c
@@ -552,12 +552,11 @@ create_mempools(struct active_device *ad, int socket_id,
 			&test_vector.entries[DATA_HARQ_OUTPUT];
 
 	/* allocate ops mempool */
-	ops_pool_size = optimal_mempool_size(RTE_MAX(
+	ops_pool_size = optimal_mempool_size(RTE_MAX3(
 			/* Ops used plus 1 reference op */
-			RTE_MAX((unsigned int)(ad->nb_queues * num_ops + 1),
+			(unsigned int)(ad->nb_queues * num_ops + 1),
 			/* Minimal cache size plus 1 reference op */
-			(unsigned int)(1.5 * rte_lcore_count() *
-					OPS_CACHE_SIZE + 1)),
+			(unsigned int)(1.5 * rte_lcore_count() * OPS_CACHE_SIZE + 1),
 			OPS_POOL_SIZE_MIN));
 
 	if (org_op_type == RTE_BBDEV_OP_NONE)
-- 
2.51.0

