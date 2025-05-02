Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C85C3ABA3
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 May 2025 12:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A126D402A0;
	Fri,  2 May 2025 14:27:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CBD7E4029E
 for <dev@dpdk.org>; Fri,  2 May 2025 14:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746188854; x=1777724854;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TiX7RmH7D8bv7S1ClqkkIyW6p1RSNsXKHXhaG195EKc=;
 b=fgpDULU/bePd+dQtPzCl9AsWmbDjbL/fk7eWlM69iMcSMtQUiz/sN9nJ
 HZNK+vtGZ6OQHR4hLBjYYBIfCi5WKsMHuxykRPZDjg3AjcdqQbkzVZMQU
 DI9RBCVUa7ZXm+KjCjWjaRyk5OBms/QeZH5pJWUIurmR99qgU2tSMcPfk
 DBHw763Q5qpTVG1yJBtxtwHfUN9Ptt7WAqiHs4BtHyd8zgu4B4mUMozii
 cLvr0soESDATx6iYtqsR3+KB19ihXvrsswh7wOKOEt2r3lLfnanJX2LdP
 4pxaIpEjaLBFlvToBzWTbAMM/Q51KJnoA4v2kuVicEUZPwTQGpfne97ml Q==;
X-CSE-ConnectionGUID: M5s8pO43Q+mej9s9OoWc4Q==
X-CSE-MsgGUID: DSrt10NSSqyRpsdf/QbOGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47955043"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="47955043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2025 05:27:32 -0700
X-CSE-ConnectionGUID: mCA6vTupQxKIVFGum/VHIA==
X-CSE-MsgGUID: 6DGdkYF0Q8S64rNmU5QiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; d="scan'208";a="135591859"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa009.fm.intel.com with ESMTP; 02 May 2025 05:27:31 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v1 1/1] app/testpmd: add sleep command
Date: Fri,  2 May 2025 13:27:29 +0100
Message-ID: <7ac1444b7d2d64dc467a22e7ac65cf3cc16246dc.1746188833.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

Add a simple sleep command to wait until certain number of milliseconds has
passed.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test-pmd/cmdline.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index d4bb3ec998..1e429e6d0a 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -151,6 +151,9 @@ static void cmd_help_long_parsed(void *parsed_result,
 
 			"quit\n"
 			"    Quit to prompt.\n\n"
+
+			"sleep ms\n"
+			"    Sleep for ms milliseconds.\n\n"
 		);
 	}
 
@@ -7768,6 +7771,37 @@ static cmdline_parse_inst_t cmd_quit = {
 	},
 };
 
+/* *** SLEEP *** */
+struct cmd_sleep_result {
+	cmdline_fixed_string_t sleep;
+	uint32_t ms;
+};
+
+static void cmd_sleep_parsed(void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	struct cmd_sleep_result *res = parsed_result;
+
+	rte_delay_us_sleep(res->ms * 1000);
+}
+
+static cmdline_parse_token_string_t cmd_sleep_sleep =
+	TOKEN_STRING_INITIALIZER(struct cmd_sleep_result, sleep, "sleep");
+static cmdline_parse_token_num_t cmd_sleep_seconds =
+	TOKEN_NUM_INITIALIZER(struct cmd_sleep_result, ms, RTE_UINT32);
+
+static cmdline_parse_inst_t cmd_sleep = {
+	.f = cmd_sleep_parsed,
+	.data = NULL,
+	.help_str = "sleep <ms>: Sleep for a specified number of milliseconds",
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
@@ -13701,6 +13735,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_help_brief,
 	&cmd_help_long,
 	&cmd_quit,
+	&cmd_sleep,
 	&cmd_load_from_file,
 	&cmd_showport,
 	&cmd_showqueue,
-- 
2.47.1

