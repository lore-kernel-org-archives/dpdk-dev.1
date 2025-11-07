Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B20CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:53:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9518B40E72;
	Fri,  7 Nov 2025 16:51:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 585354066F
 for <dev@dpdk.org>; Fri,  7 Nov 2025 16:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530695; x=1794066695;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zBqwOXgsvfgbtdR5nGj7aEI4gqKWpBcvqbD/IIsjGu4=;
 b=dovcGEEZ0cSIyjne62s+oUct9kPgaAcaBsh9hg2UsrvGMywia/xhQ2ko
 ikrgsSGJoeyJrbZCRRljmw36zvSiWn7O3oIQH+dlTK08qWtttc9UqdlpU
 J2+uNWEhP/CW6fwN97GJAsnok2IaSAltAockNjK9ctvKsnRPRaYtEOXjM
 o80yk5m1tg3UfH3+EpAcrOU1O8AHUdeIZp03Eoyvd+UTr3qnfYkDLIBXi
 hc+k1F1W8AIXA7XhV7ta4omfZh/YLjSXQxnEUaS6720WFfEX6NcyzsKT8
 zBJLWhDjflD89NDm+6F6HaKIjt/b1bIBDqopU6TsAX7al1qa/eeIcsV8Z Q==;
X-CSE-ConnectionGUID: zD/PjK1ZQh+gCNKo9NjOOQ==
X-CSE-MsgGUID: tZWdKDEtSAKVST55A+LAnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151873"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:35 -0800
X-CSE-ConnectionGUID: 7KezM4VMTPSqgPUic31jdg==
X-CSE-MsgGUID: Ct0a7hgkQHOcnoU1w9gufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321764"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:35 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	Kai Ji <kai.ji@intel.com>
Subject: [RFC PATCH v2 24/33] app/test-crypto-perf: fix shadowed variable
Date: Fri,  7 Nov 2025 15:50:20 +0000
Message-ID: <20251107155034.436809-25-bruce.richardson@intel.com>
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

The global variable iv_offset was shadowed by a local var. Rename the
local variable to a shorter form to solve the issue.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-crypto-perf/cperf_test_pmd_cyclecount.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/app/test-crypto-perf/cperf_test_pmd_cyclecount.c b/app/test-crypto-perf/cperf_test_pmd_cyclecount.c
index 07a842f40a..5e3153b9dd 100644
--- a/app/test-crypto-perf/cperf_test_pmd_cyclecount.c
+++ b/app/test-crypto-perf/cperf_test_pmd_cyclecount.c
@@ -111,15 +111,13 @@ cperf_pmd_cyclecount_test_constructor(struct rte_mempool *sess_mp,
 	ctx->test_vector = test_vector;
 
 	/* IV goes at the end of the crypto operation */
-	uint16_t iv_offset = sizeof(struct rte_crypto_op) +
-			sizeof(struct rte_crypto_sym_op);
+	uint16_t iv_ofs = sizeof(struct rte_crypto_op) + sizeof(struct rte_crypto_sym_op);
 
 	if (*sess != NULL) {
 		ctx->sess = *sess;
 		ctx->sess_owner = false;
 	} else {
-		ctx->sess = op_fns->sess_create(sess_mp, dev_id, options, test_vector,
-			iv_offset);
+		ctx->sess = op_fns->sess_create(sess_mp, dev_id, options, test_vector, iv_ofs);
 		if (ctx->sess == NULL)
 			goto err;
 		*sess = ctx->sess;
-- 
2.48.1

