Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D6D37E57
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E62CE40E2F;
	Wed, 14 Jan 2026 16:45:42 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id DAF5440E4C
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405541; x=1799941541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YvTPk4YyKbf0a2TrIhLP6RHAugBOrz0fS32Glz8o7ko=;
 b=TPT6WrLM16uyfjv2hEjWmW/uci7IwqE0Cp0nseGHet7uEKQXJDEkXp4P
 Gt4tAzCWOQvuFTY3eDG9v1+ecmz0O2AQcP9axRjv7wK24/fc0LlHxjnfY
 gzzXGBy2WkFdx5uQKa5qtVNhvvz5qV4IIJqcQ/6l5FBCdWdZxyBSQySne
 31kQH1EGPMCkqSsTP4RkVgjLIltolFrzI39jG3pUivqlkmSA8OfgTW3je
 6aRWhNk2uDmjWBSsJE2v/dOzdtnTna62tEu7dD1ef1UzeTpb5YZvJ99bY
 96N4RR5RaNqySXFy0dNQXIuXSB0jSORGeSUyI0fF+hnTs8KUyBp/L5ZvJ Q==;
X-CSE-ConnectionGUID: ZPocsrEASCyRaFRQVg3Itg==
X-CSE-MsgGUID: iJi3CLd/TdOTOuct/J2z6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870924"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870924"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:40 -0800
X-CSE-ConnectionGUID: HVhMq4rSTa+u4xx39SYIrQ==
X-CSE-MsgGUID: zJkFNlnSQIe4RGFOyKnx0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925051"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:38 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Kai Ji <kai.ji@intel.com>
Subject: [PATCH v4 23/31] app/test-crypto-perf: rename local vars to fix
 shadowing
Date: Wed, 14 Jan 2026 15:44:37 +0000
Message-ID: <20260114154450.2969716-24-bruce.richardson@intel.com>
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

The global variable iv_offset was shadowed by a local var. Rename the
local variable to a shorter form to solve the issue.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0

