Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BC5D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 563C540A6F;
	Mon,  1 Dec 2025 12:45:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D602C40B8F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589526; x=1796125526;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fyQlm/py9JVzXBT6o1stdj7v17Ar+vHTL05i+NtvBJY=;
 b=jNGU4XXzMpSCT/3UTcgwZ8lpH2c59yxHrIMDj2pAZULOfcQtMKbz/biY
 OQtx78POuBstDUyc+l/H5vcehdEXnlxcLTNmx5yRTUNcROa83JVitzM6y
 CLuRRN4x9bHKpNWBYLgJoGwauOG81dmNJSDPh5IEX+H+qegb5bilvFUVe
 yeAgjp4FcV8RusICylFESX6sjTbygJttBTsbzLAiffG5DPw+BhWQPsBVL
 EoeKV49KTtJzMa+piyflTnwkoblvmd5pl6j3YOd4o6xOoFpSZEQVHmWvr
 Xsn7Uh36cgRUeYPc14BLY5ytwVAQk5hu+tt+YCXB8uhkvGdQAYZ2Cr8sp A==;
X-CSE-ConnectionGUID: SmwB3pcuRrmPOHLf69Paqg==
X-CSE-MsgGUID: vQt0gZrJSTiDX1qsBlggOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991756"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991756"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:25 -0800
X-CSE-ConnectionGUID: irmfmyTjQBG++OAoiiyAIw==
X-CSE-MsgGUID: EYeHwYzZRrG3iJGMHT9gMQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:25 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 21/31] app/test-bbdev: remove shadow warning from next max
 calls
Date: Mon,  1 Dec 2025 11:44:38 +0000
Message-ID: <20251201114448.1441377-22-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

