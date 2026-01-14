Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039BD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:47:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3106040E4A;
	Wed, 14 Jan 2026 16:45:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 69DB440E37;
 Wed, 14 Jan 2026 16:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405537; x=1799941537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e0uYFT5LhWx2f3vmdE1N+jl8oirVljOrnpd+BhcPoDA=;
 b=VnhzQDJuapzfGJRWf5kp+SzG/5EQq5myZhoUBw+BksDMM98An+AY8RYj
 lxWz+1inS6BOohU7zFmc497E2rpFggaMLab/1PvfLSoskYVtcnrMhjbn/
 wIzWCNY7ENU25DGa6N4ELQhsmXj+wQX8S0lxQBX/F1DlMkGVGHEgrPm6x
 DUWsq02npwsm3yfInWaAkF/tTiQe34wJ2TAmDxvgBMlI0/42a0rU1b/+M
 XmOOiO0mOf9tOAOan658PAjNFDrp6X+4Xd31dmcILsRzgdpQs9ExjGTbf
 d0ainiG6ujpTCj0FbxKD0Q7ycmcbQjtJSBA0omLZs/IGlUhsvTF9WKfB/ g==;
X-CSE-ConnectionGUID: 5P1RX+bwRvisC1rwFbx4/g==
X-CSE-MsgGUID: 8cUJRr4xQi+HROe/B/PvgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870908"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870908"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:37 -0800
X-CSE-ConnectionGUID: bzwy8Js0QGu2fwnkjlV9TQ==
X-CSE-MsgGUID: N94eVgkzTOeal6NhyQszVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925038"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:34 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>,
 Reshma Pattan <reshma.pattan@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v4 20/31] app/pdump: fix warning about shadowed variable
Date: Wed, 14 Jan 2026 15:44:34 +0000
Message-ID: <20260114154450.2969716-21-bruce.richardson@intel.com>
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

