Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBF4FD8FD3
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:45:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7DF804066C;
	Thu, 26 Feb 2026 17:44:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 9AE4C40608
 for <dev@dpdk.org>; Thu, 26 Feb 2026 17:44:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772124296; x=1803660296;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=PP72m9jy/xDUtKkEkQNzS6Ey3yPukd26EF90UbdDuzc=;
 b=FKEmQAGbW/nbZ8I0Gb9FA77DQ0o4NOi7rdGxhNszjpilwJT17kNrVJZM
 hqMTUPIm/Xx7HYFrTMWg+gaHwzKk7eSPa/MMdiw280Dxs80lGy1mGzi1F
 j3nAEzxGyr/c0oAKKK64JiHWlcnQqbiIwLlT7vDflNLApcoh20KMyLd1E
 JtQ2UJo44k6M0MPiYumVfCyvNl2j8t54Hk7hloQQBC8T/4p9hWJEQL4Y3
 xmRXz+C3/l8tBOrdbhXWV1a0838F2GpojS1iz8Hm+kxxGD8MgbyuhEFJC
 j4MNp3c42jyXRFHKODmIiwQvUtpE3Zl7QszsbGlQ/2LNmOeT3FPIkidQ1 A==;
X-CSE-ConnectionGUID: SXqM9e2vQRmcj5fZHtWeEw==
X-CSE-MsgGUID: knQEwTqjQ/a5gM/r/HoIWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73375868"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="73375868"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 08:44:55 -0800
X-CSE-ConnectionGUID: pBuwxucFSl6VdAfecJaTyQ==
X-CSE-MsgGUID: 0TKGupRBQeGucDOEOAjzqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="216523521"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 26 Feb 2026 08:44:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v12 3/3] app/testpmd: add sleep command
Date: Thu, 26 Feb 2026 16:44:50 +0000
Message-ID: <9190a614adc2b641b4be3f3160ec109cb087cb24.1772124281.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <253bd83015321590b266eee7c5f774b7c8956831.1772124281.git.anatoly.burakov@intel.com>
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
index c33c66f327..766c83c944 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -152,6 +152,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 
 			"quit\n"
 			"    Quit to prompt.\n\n"
+
+			"sleep secs\n"
+			"    Sleep for secs seconds (can be fractional).\n\n"
 		);
 	}
 
@@ -8044,6 +8047,37 @@ static cmdline_parse_inst_t cmd_quit = {
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
+	.help_str = "sleep <secs>: sleep for a specified number of seconds",
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
@@ -14088,6 +14122,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_showdevice,
 	&cmd_showcfg,
 	&cmd_showfwdall,
+	&cmd_sleep,
 	&cmd_start,
 	&cmd_start_tx_first,
 	&cmd_start_tx_first_n,
-- 
2.47.3

