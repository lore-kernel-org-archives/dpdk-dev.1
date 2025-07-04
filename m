Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE12FC8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 14:06:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EABF040298;
	Fri,  4 Jul 2025 16:06:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 02A1B40267
 for <dev@dpdk.org>; Fri,  4 Jul 2025 16:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751637960; x=1783173960;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NikOTRpBT24Bto1wnELH6bNSBznJKvkO3kK9z3lXR9w=;
 b=cqt/XqypU481YXEDhoktFgMT2bIeQOIMAM0kdYJEtp+eZKIjcEhZG8bN
 cbwRZ9LwBCiptqx6DOzAtX0v9tk+JEEbHKeghcLiOlRBNSuaqGhUTfzOJ
 0ndGQ4XI9DOsCCcDVdPuF+5JUFA0d0Y0kaoozEezujCVZ0lROZ/0FWTRi
 JdZSM7G5FKlhPZJgwOt0wFGJ8t4a1Nxj7taRWVARKUS2wPW7cHY1sHUe3
 Qr+Ni+Q9sT+rtgRYteGkoynA+i0aU8mqEqwxGvus3DVtRTLg3ePD0rvq8
 n5OP2ZPCLV78XRCjdWuAqTtP8aK+C8Rkb0lMC0RXiuD9eZTRKiaTvABeh w==;
X-CSE-ConnectionGUID: e26PiASET3CGybgBG3hv6w==
X-CSE-MsgGUID: GFuboXaVSZGGH6iEPtsATg==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="53693994"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="53693994"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 07:05:59 -0700
X-CSE-ConnectionGUID: TeKuVBLfQtmDdOaqyQKoAA==
X-CSE-MsgGUID: jyezSEU3RyaRHqGo561jfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="155012893"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa009.fm.intel.com with ESMTP; 04 Jul 2025 07:05:58 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/testpmd: allow multiple cmdline-file parameters
Date: Fri,  4 Jul 2025 15:05:51 +0100
Message-ID: <20250704140551.4151993-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

While testpmd allows a set of pre-prepared commands to be passed into it
at startup via the "cmdline-file" (and cmdline-file-noecho) parameters,
this is currently limited to a single file. By extending this support
to allow the parameter to be passed multiple (up to 16) times, we enable
users to have a library of pre-canned cmdline files and pass multiple of
these in to the same run, e.g. have one cmdline file per NIC feature and
enable multiple features by passing in multiple filenames.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c    | 11 ++++++++---
 app/test-pmd/parameters.c | 15 +++++++++++----
 app/test-pmd/testpmd.c    | 12 +++++++++---
 app/test-pmd/testpmd.h    |  8 ++++++--
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 7b4e27eddf..ad4094fa29 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -11646,7 +11646,9 @@ cmd_load_from_file_parsed(
 {
 	struct cmd_cmdfile_result *res = parsed_result;
 
-	cmdline_read_from_file(res->filename);
+	if (cmdline_read_from_file(res->filename) != 0) {
+		fprintf(stderr, "Failed to load commands from file: %s\n", res->filename);
+	}
 }
 
 static cmdline_parse_inst_t cmd_load_from_file = {
@@ -14151,11 +14153,12 @@ init_cmdline(void)
 }
 
 /* read cmdline commands from file */
-void
+int
 cmdline_read_from_file(const char *filename)
 {
 	struct cmdline *cl;
 	int fd = -1;
+	int ret = 0;
 
 	/* cmdline_file_new does not produce any output
 	 * so when echoing is requested we open filename directly
@@ -14168,7 +14171,7 @@ cmdline_read_from_file(const char *filename)
 		if (fd < 0) {
 			fprintf(stderr, "Failed to open file %s: %s\n",
 				filename, strerror(errno));
-			return;
+			return -1;
 		}
 
 		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
@@ -14177,6 +14180,7 @@ cmdline_read_from_file(const char *filename)
 		fprintf(stderr,
 			"Failed to create file based cmdline context: %s\n",
 			filename);
+		ret = -1;
 		goto end;
 	}
 
@@ -14190,6 +14194,7 @@ cmdline_read_from_file(const char *filename)
 end:
 	if (fd >= 0)
 		close(fd);
+	return ret;
 }
 
 void
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..64c16b4f36 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -963,10 +963,17 @@ launch_args_parse(int argc, char** argv)
 			echo_cmdline_file = true;
 			/* fall-through */
 		case TESTPMD_OPT_CMDLINE_FILE_NOECHO_NUM:
-			printf("CLI commands to be read from %s\n",
-				optarg);
-			strlcpy(cmdline_filename, optarg,
-				sizeof(cmdline_filename));
+			if (cmdline_file_count >= RTE_DIM(cmdline_filenames)) {
+				fprintf(stderr, "Too many cmdline files specified (maximum %zu)\n",
+					RTE_DIM(cmdline_filenames));
+				exit(EXIT_FAILURE);
+			}
+			printf("CLI commands to be read from %s\n", optarg);
+			strlcpy(cmdline_filenames[cmdline_file_count], optarg,
+				sizeof(cmdline_filenames[cmdline_file_count]));
+			cmdline_file_count++;
+			/* reset flag for next time */
+			echo_cmdline_file = false;
 			break;
 		case TESTPMD_OPT_TX_FIRST_NUM:
 			printf("Ports to start sending a burst of "
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..3f82c1018d 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -105,7 +105,8 @@ int testpmd_logtype; /**< Log type for testpmd logs */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
-char cmdline_filename[PATH_MAX] = {0};
+char cmdline_filenames[MAX_CMDLINE_FILENAMES][PATH_MAX] = {0};
+unsigned int cmdline_file_count;
 bool echo_cmdline_file;
 
 /*
@@ -4508,8 +4509,13 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE,
 			"Could not initialise cmdline context.\n");
 
-	if (strlen(cmdline_filename) != 0)
-		cmdline_read_from_file(cmdline_filename);
+	for (unsigned int i = 0; i < cmdline_file_count; i++) {
+		if (cmdline_read_from_file(cmdline_filenames[i]) != 0) {
+			fprintf(stderr, "Failed to process cmdline file: %s\n",
+					cmdline_filenames[i]);
+			break;
+		}
+	}
 
 	if (interactive == 1) {
 		if (auto_start) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index e629edaa02..9525a04626 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -36,6 +36,9 @@
 extern uint8_t cl_quit;
 extern volatile uint8_t f_quit;
 
+/* Max number of cmdline files we can take on testpmd cmdline */
+#define MAX_CMDLINE_FILENAMES 16
+
 /*
  * It is used to allocate the memory for hash key.
  * The hash key size is NIC dependent.
@@ -509,7 +512,8 @@ extern int testpmd_logtype; /**< Log type for testpmd logs */
 extern uint8_t  interactive;
 extern uint8_t  auto_start;
 extern uint8_t  tx_first;
-extern char cmdline_filename[PATH_MAX]; /**< offline commands file */
+extern char cmdline_filenames[MAX_CMDLINE_FILENAMES][PATH_MAX]; /**< offline commands files */
+extern unsigned int cmdline_file_count; /**< number of cmdline files */
 extern bool echo_cmdline_file;  /** unset if cmdline-file-noecho is used */
 extern uint8_t  numa_support; /**< set by "--numa" parameter */
 extern uint16_t port_topology; /**< set by "--port-topology" parameter */
@@ -928,7 +932,7 @@ unsigned int parse_hdrs_list(const char *str, const char *item_name,
 			unsigned int *parsed_items);
 void launch_args_parse(int argc, char** argv);
 void cmd_reconfig_device_queue(portid_t id, uint8_t dev, uint8_t queue);
-void cmdline_read_from_file(const char *filename);
+int cmdline_read_from_file(const char *filename);
 int init_cmdline(void);
 void prompt(void);
 void prompt_exit(void);
-- 
2.48.1

