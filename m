Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA2FC3ABAC
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 May 2025 13:08:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2252D402D2;
	Tue,  6 May 2025 15:08:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5A5F640150
 for <dev@dpdk.org>; Tue,  6 May 2025 15:08:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746536905; x=1778072905;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=RzHa5of77EOJQw4EoOzRsksZ8HRb/DUzlY2mEjxjTxg=;
 b=B3+Pa/jfa63W+9fSOBQ12bPdpGxsEtjjcmWM9SqC35u+pkR6606AftJ+
 8Emhg54mfo3EWjIehopNgaWEXgBLelNFKttocj2FymjriUW3Ck7gdkpgb
 qAjReiNoGOrfTbLB4dRBjkOpyWULSU2wIL2Iy7TVVOZvq8kM6r92A+sQC
 DNL9I6vRc5pCnazTixk1tdmCDYwud6sWYVpbfB8uaDqmYazrD/zqqZkUb
 TD0HKThdbubxBotCz3Jto9kZM0bbRgM1t67man6FYGyjC7QLa557/r/0J
 4rpK/zEzWGQJ15aMcD3u5qeSNkD+PXECOfl69pfDfp3JsNyrq9QD933mc w==;
X-CSE-ConnectionGUID: qR+7qyMbT5CulN4KdC3AIA==
X-CSE-MsgGUID: s8DOI1hcQAuAEwicH9KVHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="65612884"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="65612884"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 06:08:24 -0700
X-CSE-ConnectionGUID: VXe2pEEQS7qTxuNtNPM+xg==
X-CSE-MsgGUID: DXUDLsJ3QaK/MIEb3kOAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="139678034"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa003.fm.intel.com with ESMTP; 06 May 2025 06:08:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 2/2] app/testpmd: add sleep command
Date: Tue,  6 May 2025 14:08:19 +0100
Message-ID: <fecaa83e97180aac59bf0f963beab9a65d0d8570.1746536891.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cc5198a753f4a86242c0135914affba97d7d4d1c.1746536891.git.anatoly.burakov@intel.com>
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

