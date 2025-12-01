Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC08D111A8
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE21A40A89;
	Mon,  1 Dec 2025 12:45:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id DBB2440BA6
 for <dev@dpdk.org>; Mon,  1 Dec 2025 12:45:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589528; x=1796125528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YvTPk4YyKbf0a2TrIhLP6RHAugBOrz0fS32Glz8o7ko=;
 b=l0P09Xfz2TzSDZj+8MQRnBXr5y1DG/xSIoB+D/F8HCtv9rXi6Rc54srB
 /5UYGmqaloQjOMbe/ubtxjOczEh5LDNdyU3s/Kyd8aVYWSWTWyptQXeRc
 TvvmOp2aO/dVMZbdtqkKRa4u+6X7QJC6nvxH2ZdHmn5uFHb0/ByWdrrhq
 LtU8VDqMYzV3VYJJsl4bsnY20bXr5nx2P6fndv4u/qmlp/D1Tjq3nWHS5
 uxuw1QuW++8Twtzn1PsZ8wJTaEg0Odtlp+QQJkPL1mh1VWPMfg6e+VkQA
 e+rz2vDMkHcwk5AZomhK8FLpcUozXTG22JN5xwn8Q7lUbujFsI5VTPV4P Q==;
X-CSE-ConnectionGUID: xBsrBDPrS9SK/HUpBoaBKQ==
X-CSE-MsgGUID: dBXC7x1gQnWIXrnR0+K7uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991761"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991761"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:27 -0800
X-CSE-ConnectionGUID: PIKbHwnHT8yJOtBDbQUtWg==
X-CSE-MsgGUID: 0cDE80ySRTuIamfZ1sAekw==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:27 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 23/31] app/test-crypto-perf: rename local vars to fix
 shadowing
Date: Mon,  1 Dec 2025 11:44:40 +0000
Message-ID: <20251201114448.1441377-24-bruce.richardson@intel.com>
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

