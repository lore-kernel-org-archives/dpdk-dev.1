Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A9EC3ABBF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 10:01:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD09402F2;
	Wed,  7 May 2025 12:01:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id C041E4025A
 for <dev@dpdk.org>; Wed,  7 May 2025 12:01:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746612089; x=1778148089;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RzHa5of77EOJQw4EoOzRsksZ8HRb/DUzlY2mEjxjTxg=;
 b=U93C2MIm/gqbJMnpo7PO4drcCifXRAnkpma3qEWd40FZIORTUaOvM12f
 8lXQHxrDSgsNeoZYGhwQOhw3ShIEN1SU6oZWooKC1ZRYd9i6mu/g7mehJ
 lkwKmSP2GTYUOKNd2g+Ii1mLnsSkL6i4elV4tonv6XJY5K01WA1mwa0p+
 rYeqgClL09FLnXtIhD9usJIk/1MW8zJCYHB5atCnQRdY5mNU0ISCA3k37
 cawjBTuAJ9tFdYypbSLyF5SrQ3iO5PXj7pkSbKB+7z62LHiCCvQs50smI
 lgD/xoTjpjrtPFS72g3hgtLYFo6QiWxx/V72BLnYSd2OcMY5itpPWlMH5 A==;
X-CSE-ConnectionGUID: cKTOKiFvSa+aaRyY4NeTXg==
X-CSE-MsgGUID: mmvNdGhDS7W3fR7O96K0GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58527596"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="58527596"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 03:01:28 -0700
X-CSE-ConnectionGUID: 7gdqeJe4Rl+N3uarV5mHNg==
X-CSE-MsgGUID: oS26WhJ2Rn2jaj9ypWa9GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="159199438"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa002.fm.intel.com with ESMTP; 07 May 2025 03:01:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 2/2] app/testpmd: add sleep command
Date: Wed,  7 May 2025 11:01:24 +0100
Message-ID: <b5b6383151f103def85d94a9c2554ff29d752bf3.1746612074.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <e8234c26b5dd91aaa9e7b1e38887b1d6fdb2d053.1746612074.git.anatoly.burakov@intel.com>
References: 
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

Test-pmd already has a way to run a list of commands from file, but there
is no way to pause execution for a specified amount of time between two
commands. This may be necessary for simple automation, particularly for
waiting on some asynchronous operation such as link status update.

Add a simple sleep command to wait until certain number of seconds has
passed, using the newly added cmdline library floating point support.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    v1 -> v2:
    - Add floating point support to cmdline
    - Use floating point format for pause command

 app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d4bb3ec998..b6152c07e6 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 
 			"quit\n"
 			"    Quit to prompt.\n\n"
+
+			"sleep secs\n"
+			"    Sleep for secs seconds (can be fractional).\n\n"
 		);
 	}
 
@@ -7768,6 +7771,37 @@ static cmdline_parse_inst_t cmd_quit = {
 	},
 };
 
+/* *** SLEEP *** */
+struct cmd_sleep_result {
+	cmdline_fixed_string_t sleep;
+	double secs;
+};
+
+static void cmd_sleep_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	struct cmd_sleep_result *res = parsed_result;
+
+	rte_delay_us_sleep(res->secs * 1E6);
+}
+
+static cmdline_parse_token_string_t cmd_sleep_sleep =
+	TOKEN_STRING_INITIALIZER(struct cmd_sleep_result, sleep, "sleep");
+static cmdline_parse_token_num_t cmd_sleep_seconds =
+	TOKEN_NUM_INITIALIZER(struct cmd_sleep_result, secs, RTE_FLOAT_DOUBLE);
+
+static cmdline_parse_inst_t cmd_sleep = {
+	.f = cmd_sleep_parsed,
+	.data = NULL,
+	.help_str = "sleep <secs>: Sleep for a specified number of seconds",
+	.tokens = {
+		(void *)&cmd_sleep_sleep,
+		(void *)&cmd_sleep_seconds,
+		NULL,
+	},
+};
+
 /* *** ADD/REMOVE MAC ADDRESS FROM A PORT *** */
 struct cmd_mac_addr_result {
 	cmdline_fixed_string_t mac_addr_cmd;
@@ -13711,6 +13745,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_showdevice,
 	&cmd_showcfg,
 	&cmd_showfwdall,
+	&cmd_sleep,
 	&cmd_start,
 	&cmd_start_tx_first,
 	&cmd_start_tx_first_n,
-- 
2.47.1

