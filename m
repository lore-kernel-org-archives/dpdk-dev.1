Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790B5C87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 16:01:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AC8F4060C;
	Thu, 31 Jul 2025 18:01:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 99C7B402AB
 for <dev@dpdk.org>; Thu, 31 Jul 2025 18:01:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753977686; x=1785513686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KnoHfM4O+5dX05BrCpckZONRkgPwEoBo+BSGcKxWrUA=;
 b=AEQljEWT/gtuhPXA9Ad84FWxl3E23wCNpVLqO/ThXB9rr5LXCtsBbHBh
 GqcydHGNa99KTx/CerJhKDypm/yRawi9BKItHDyXDk4rf6KgmDT390TTf
 zKqTLn0hEZu2HfSj2x80ueZgzwUEqn46VCLrb8WM6v4CSgS9eCgyCYvAx
 IxJIoEqcD9ysiI9EsLbikl6lU363C5Zad7gENOoRBwtC6Fi7d90RmGbHy
 wYc8R4AcOX5xJz4cqS3k2CsF18xrHDvd/7pwLhISL00Rm/8H641DtoFDk
 nSekmIGKlfed7I8K6XQFJ5nD+Sd7HqTlDy4EvHvJ8fcULva1iTU0wkTYC Q==;
X-CSE-ConnectionGUID: sPqfZGQjRguiUTvwvG1Q9Q==
X-CSE-MsgGUID: yldvUjGjQfO6t1WE8nw0ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78857980"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="78857980"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 09:01:03 -0700
X-CSE-ConnectionGUID: e2Qg01gXSx66/eFur9qq5A==
X-CSE-MsgGUID: CvsmLvvtQX67tpMqfOEjrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="167543415"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa005.fm.intel.com with ESMTP; 31 Jul 2025 09:01:02 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, andremue@linux.microsoft.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 2/4] app/testpmd: explicitly set command echoing on file
 load
Date: Thu, 31 Jul 2025 16:00:39 +0000
Message-ID: <20250731160041.914837-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250731160041.914837-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250731160041.914837-1-bruce.richardson@intel.com>
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

The echoing of commands contained in a file loaded via the "load"
command on testpmd CLI is governed by whether or not a cmdline-file or
cmdline-file-noecho had been passed to testpmd on the commandline.

Remove the use of a global setting for this, and explicitly add a
"load_echo" command to match the "load" command.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c                      | 51 +++++++++++++++++++--
 app/test-pmd/testpmd.c                      |  2 +-
 app/test-pmd/testpmd.h                      |  2 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  2 +-
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..5433678b5e 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -11646,7 +11646,9 @@ cmd_load_from_file_parsed(
 {
 	struct cmd_cmdfile_result *res = parsed_result;
 
-	cmdline_read_from_file(res->filename);
+	if (cmdline_read_from_file(res->filename, false) != 0) {
+		fprintf(stderr, "Failed to load commands from file: %s\n", res->filename);
+	}
 }
 
 static cmdline_parse_inst_t cmd_load_from_file = {
@@ -11660,6 +11662,41 @@ static cmdline_parse_inst_t cmd_load_from_file = {
 	},
 };
 
+/* command to load a file with echoing commands */
+struct cmd_load_echo_result {
+	cmdline_fixed_string_t load_echo;
+	cmdline_fixed_string_t filename;
+};
+
+/* CLI fields for file load with echo command */
+static cmdline_parse_token_string_t cmd_load_echo =
+	TOKEN_STRING_INITIALIZER(struct cmd_load_echo_result, load_echo, "load_echo");
+static cmdline_parse_token_string_t cmd_load_echo_filename =
+	TOKEN_STRING_INITIALIZER(struct cmd_load_echo_result, filename, NULL);
+
+static void
+cmd_load_echo_file_parsed(
+	void *parsed_result,
+	__rte_unused struct cmdline *cl,
+	__rte_unused void *data)
+{
+	struct cmd_load_echo_result *res = parsed_result;
+
+	if (cmdline_read_from_file(res->filename, true) != 0)
+		fprintf(stderr, "Failed to load commands from file: %s\n", res->filename);
+}
+
+static cmdline_parse_inst_t cmd_load_echo_file = {
+	.f = cmd_load_echo_file_parsed,
+	.data = NULL,
+	.help_str = "load_echo <filename>",
+	.tokens = {
+		(void *)&cmd_load_echo,
+		(void *)&cmd_load_echo_filename,
+		NULL,
+	},
+};
+
 /* Get Rx offloads capabilities */
 struct cmd_rx_offload_get_capa_result {
 	cmdline_fixed_string_t show;
@@ -13865,6 +13902,7 @@ static cmdline_parse_ctx_t builtin_ctx[] = {
 	&cmd_help_long,
 	&cmd_quit,
 	&cmd_load_from_file,
+	&cmd_load_echo_file,
 	&cmd_showport,
 	&cmd_showqueue,
 	&cmd_showeeprom,
@@ -14151,24 +14189,25 @@ init_cmdline(void)
 }
 
 /* read cmdline commands from file */
-void
-cmdline_read_from_file(const char *filename)
+int
+cmdline_read_from_file(const char *filename, bool echo)
 {
 	struct cmdline *cl;
 	int fd = -1;
+	int ret = 0;
 
 	/* cmdline_file_new does not produce any output
 	 * so when echoing is requested we open filename directly
 	 * and then pass that to cmdline_new with stdout as the output path.
 	 */
-	if (!echo_cmdline_file) {
+	if (!echo) {
 		cl = cmdline_file_new(main_ctx, "testpmd> ", filename);
 	} else {
 		fd = open(filename, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Failed to open file %s: %s\n",
 				filename, strerror(errno));
-			return;
+			return -1;
 		}
 
 		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
@@ -14177,6 +14216,7 @@ cmdline_read_from_file(const char *filename)
 		fprintf(stderr,
 			"Failed to create file based cmdline context: %s\n",
 			filename);
+		ret = -1;
 		goto end;
 	}
 
@@ -14190,6 +14230,7 @@ cmdline_read_from_file(const char *filename)
 end:
 	if (fd >= 0)
 		close(fd);
+	return ret;
 }
 
 void
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..b498e6d9fe 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -4509,7 +4509,7 @@ main(int argc, char** argv)
 			"Could not initialise cmdline context.\n");
 
 	if (strlen(cmdline_filename) != 0)
-		cmdline_read_from_file(cmdline_filename);
+		cmdline_read_from_file(cmdline_filename, echo_cmdline_file);
 
 	if (interactive == 1) {
 		if (auto_start) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..1d34f40deb 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -928,7 +928,7 @@ unsigned int parse_hdrs_list(const char *str, const char *item_name,
 			unsigned int *parsed_items);
 void launch_args_parse(int argc, char** argv);
 void cmd_reconfig_device_queue(portid_t id, uint8_t dev, uint8_t queue);
-void cmdline_read_from_file(const char *filename);
+int cmdline_read_from_file(const char *filename, bool echo);
 int init_cmdline(void);
 void prompt(void);
 void prompt_exit(void);
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 6ad83ae50d..e12585f025 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -95,7 +95,7 @@ practical or possible testpmd supports alternative methods for executing command
 
 
 * At run-time additional commands can be loaded in bulk by invoking the ``load FILENAME``
-  command.
+  or ``load_echo FILENAME`` command.
 
 .. code-block:: console
 
-- 
2.48.1

