Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7434FCCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:53:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AB5940E50;
	Fri,  7 Nov 2025 16:51:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id D9AB040E44;
 Fri,  7 Nov 2025 16:51:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530692; x=1794066692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mVz08qZVsoehC13gjM7ztO1QJLuMvsw86QetxYlJVz0=;
 b=jPPrvhVSLs45JGs58HtH85yJHqpg4vJFVhcqsS53VAZmARCKhlcnZ8ov
 pFaCcOuF8olDkRNbkhSBMsEomfS+IpyFR0pnd84bWnY0VwBuTdb4wQT5v
 kdj6AQmjKz5i89HIwkMZx/5tsf6/PTu2H+osxUak9XZH5kGQuTO/4aP22
 gbIj4tflHi8STwKggCO/SJ3myuf/BtVO0EFf1bfy7ptLTZzOavLwON8cs
 3572zPvuLCiyOarmJsCUKeu87/udpqxklMREhQE2iMf06VWojOmDrHPf3
 ZmRjEns33tlVN0MmzI5Ju2ZcE5Up4seR2gluilDSAxTWTyLSJXI+oXOMf A==;
X-CSE-ConnectionGUID: XFcnFh21QnuBSFJonpH/Hg==
X-CSE-MsgGUID: jtQs345OQveLXLaU2V1EMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151865"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151865"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:31 -0800
X-CSE-ConnectionGUID: sHGdi7OCTaaoIMFJscj6Og==
X-CSE-MsgGUID: ka5XJwFYTQODW5qmY2YBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321746"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:31 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Reshma Pattan <reshma.pattan@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [RFC PATCH v2 21/33] app/pdump: fix warning about shadowed variable
Date: Fri,  7 Nov 2025 15:50:17 +0000
Message-ID: <20251107155034.436809-22-bruce.richardson@intel.com>
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

The variable name "optarg" is a standard global variable in getopt, so
use of that name for function parameters causes shadowing warnings.
Rename the variable to avoid these issues.

Fixes: caa7028276b8 ("app/pdump: add tool for packet capturing")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/pdump/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..5be382f8ca 100644
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
2.48.1

