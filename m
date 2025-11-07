Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74572CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:53:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 566F840E64;
	Fri,  7 Nov 2025 16:51:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F2C5840E49
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530693; x=1794066693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mI9EbBnOq1KFxtraJmzFuw/huAMzTHwVbO1bOYjg94E=;
 b=XQjrrVCcPJjq4zJnTtKZKNZBi2pE7RTWfO+g6pnhlLkwGXmQhJPrWQft
 hzmfrqI15SCS1niK99qFrn4eJUy8fUFYj0DqZo0ko03lwU71C7AISLz+6
 Gf28OXkcuaMY4ek2C5pEK7gTepbRNuzPvWWhzWLfM04SJxQ4lLmn5RIY0
 PaCOp1knR9XAMCyMPsEbgNzRJQRK7qn96CkEYOM6R426OJPd83Z36DOMG
 wQx5XRpAZWGWTIVXvmF4Pb49w5LEJ5hMwdG5brams+Huyf2w+vL7Cbeqt
 5zKnBO/8+TWEibUFy4MtvWUosGDaJD5Ztj5HS13bpO4oilnViemzxOUeN g==;
X-CSE-ConnectionGUID: mz0/upamR9qQ5DiT8zFQlA==
X-CSE-MsgGUID: 2RosJKioTWKRXFtmaP9tXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151868"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151868"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:32 -0800
X-CSE-ConnectionGUID: djqCiquqTYObxrwHw54FTA==
X-CSE-MsgGUID: SUKORW43TF+Wn1OSRmMOSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321752"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:32 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Nicolas Chautru <nicolas.chautru@intel.com>
Subject: [RFC PATCH v2 22/33] app/test-bbdev: use RTE_MAX3 to remove variable
 shadowing
Date: Fri,  7 Nov 2025 15:50:18 +0000
Message-ID: <20251107155034.436809-23-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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
2.48.1

