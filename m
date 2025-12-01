Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF0D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:47:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DE2640DD5;
	Mon,  1 Dec 2025 12:45:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id F1F9740A89;
 Mon,  1 Dec 2025 12:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589525; x=1796125525;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e0uYFT5LhWx2f3vmdE1N+jl8oirVljOrnpd+BhcPoDA=;
 b=LLmouyH0tIwTxNxeeURgdzpax6MU+aNVpCEUvI87e44YyOqQwCsbTsVE
 6ce4s1n6c0CdQA8xxOWuYHQ80GW0DIx0fWP+99V8RnfuIElf+XNdS7Vr2
 jfIvJOZQdM7Otohvr9w+LDfMSz3SWN8WppVPVPRRKRvCSOJ1zBkvi7acY
 e54llFrgxfbM+PWa5fsDu/YOb9KtiHQ7E+WPNSl45htf2OdeSTyMV+Dl/
 AJLCz6R653AJLNvxAYiUv55zVyFcWmxlktWBUuE+P09pvR04XhLZpmjgX
 QEO+MfU9GEw6Msw1oIGzzaFcft6/BVk+uLCZ41mwQg2iO+xnUERA4FsoT Q==;
X-CSE-ConnectionGUID: MzaNWxRZSa2lekAGmqy9aA==
X-CSE-MsgGUID: ddRvs40fRNSd6+PVa1Q4cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991753"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991753"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:25 -0800
X-CSE-ConnectionGUID: PaBgE8jMQJ2rlbQ4suqp0A==
X-CSE-MsgGUID: nqhDBuQtQgejwkrmtdyzvA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:24 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 20/31] app/pdump: fix warning about shadowed variable
Date: Mon,  1 Dec 2025 11:44:37 +0000
Message-ID: <20251201114448.1441377-21-bruce.richardson@intel.com>
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

The variable name "optarg" is a standard global variable in getopt, so
use of that name for function parameters causes shadowing warnings.
Rename the variable to avoid these issues.

Fixes: caa7028276b8 ("app/pdump: add tool for packet capturing")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/pdump/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index 68bda487a7..1e62c8adc1 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -247,7 +247,7 @@ parse_uint_value(const char *key, const char *value, void *extra_args)
 }
 
 static int
-parse_pdump(const char *optarg)
+parse_pdump(const char *arg)
 {
 	struct rte_kvargs *kvlist;
 	int ret = 0, cnt1, cnt2;
@@ -257,9 +257,9 @@ parse_pdump(const char *optarg)
 	pt = &pdump_t[num_tuples];
 
 	/* initial check for invalid arguments */
-	kvlist = rte_kvargs_parse(optarg, valid_pdump_arguments);
+	kvlist = rte_kvargs_parse(arg, valid_pdump_arguments);
 	if (kvlist == NULL) {
-		printf("--pdump=\"%s\": invalid argument passed\n", optarg);
+		printf("--pdump=\"%s\": invalid argument passed\n", arg);
 		return -1;
 	}
 
@@ -268,7 +268,7 @@ parse_pdump(const char *optarg)
 	cnt2 = rte_kvargs_count(kvlist, PDUMP_PCI_ARG);
 	if (!((cnt1 == 1 && cnt2 == 0) || (cnt1 == 0 && cnt2 == 1))) {
 		printf("--pdump=\"%s\": must have either port or "
-			"device_id argument\n", optarg);
+			"device_id argument\n", arg);
 		ret = -1;
 		goto free_kvlist;
 	} else if (cnt1 == 1) {
@@ -290,7 +290,7 @@ parse_pdump(const char *optarg)
 	/* queue parsing and validation */
 	cnt1 = rte_kvargs_count(kvlist, PDUMP_QUEUE_ARG);
 	if (cnt1 != 1) {
-		printf("--pdump=\"%s\": must have queue argument\n", optarg);
+		printf("--pdump=\"%s\": must have queue argument\n", arg);
 		ret = -1;
 		goto free_kvlist;
 	}
@@ -303,7 +303,7 @@ parse_pdump(const char *optarg)
 	cnt2 = rte_kvargs_count(kvlist, PDUMP_TX_DEV_ARG);
 	if (cnt1 == 0 && cnt2 == 0) {
 		printf("--pdump=\"%s\": must have either rx-dev or "
-			"tx-dev argument\n", optarg);
+			"tx-dev argument\n", arg);
 		ret = -1;
 		goto free_kvlist;
 	} else if (cnt1 == 1 && cnt2 == 1) {
-- 
2.51.0

