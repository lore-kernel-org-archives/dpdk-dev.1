Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0243FC8303C
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 11:18:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 614C940649;
	Mon,  7 Jul 2025 13:18:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id B2AF740647
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:18:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751887091; x=1783423091;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7dX/lrM4iZiLFNJCB5EcTz8XyNiR8qfLQlLlnrJnzj8=;
 b=cYVHxrnQSAGROOGHUNDDR2I90Qr03qoz0Csn2gYa5TCSF37eCus4XS0c
 cEluX6j3l0ksvBgu+JCeXKldMjxWD+RTVsYKvzI8LaCpFj9K84DiOqccN
 jP0moYQ/d3PIsBpAgvmYEGEmtKogcCaZXSiMHpiOqGSEezCTa+CYLogcF
 Kg4AgZYy3lcIDtnqytfXJowma01nzpJ1PICSKBCLvbTZqbZQLJlSCrju2
 +EgTaYOCOjs7X+fw3goCGEtFMkFQs5Acbw6a4ahG7bCihE88BZpoGhFwi
 H+5Ee2+URFx4AoX+43iAqKzqI7D0WfYpA6yfV5d1aWVJ8+EVjP4YkutcV w==;
X-CSE-ConnectionGUID: R/b0BTt6TlGINUH/IZO4Hg==
X-CSE-MsgGUID: UPuh6w8gQ3KfGbglvtDGaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54228342"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="54228342"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 04:18:11 -0700
X-CSE-ConnectionGUID: qAB3tSyAR+qHdUPWEy5vkA==
X-CSE-MsgGUID: ythn+3UHTzehpQHy/sRwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="155670942"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 07 Jul 2025 04:18:10 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 2/3] app/testpmd: allow multiple commandline file parameters
Date: Mon,  7 Jul 2025 12:17:50 +0100
Message-ID: <20250707111751.183469-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250707111751.183469-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250707111751.183469-1-bruce.richardson@intel.com>
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
 app/test-pmd/parameters.c                   | 17 +++++++++++------
 app/test-pmd/testpmd.c                      | 13 +++++++++----
 app/test-pmd/testpmd.h                      | 13 +++++++++++--
 doc/guides/testpmd_app_ug/run_app.rst       |  3 ++-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  6 +++---
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 1132972913..ce2ba1c826 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -960,13 +960,18 @@ launch_args_parse(int argc, char** argv)
 			exit(EXIT_SUCCESS);
 			break;
 		case TESTPMD_OPT_CMDLINE_FILE_NUM:
-			echo_cmdline_file = true;
-			/* fall-through */
 		case TESTPMD_OPT_CMDLINE_FILE_NOECHO_NUM:
-			printf("CLI commands to be read from %s\n",
-				optarg);
-			strlcpy(cmdline_filename, optarg,
-				sizeof(cmdline_filename));
+			if (cmdline_file_count >= RTE_DIM(cmdline_files)) {
+				fprintf(stderr, "Too many cmdline files specified (maximum %zu)\n",
+					RTE_DIM(cmdline_files));
+				exit(EXIT_FAILURE);
+			}
+			printf("CLI commands to be read from %s\n", optarg);
+			strlcpy(cmdline_files[cmdline_file_count].filename, optarg,
+				sizeof(cmdline_files[cmdline_file_count].filename));
+			cmdline_files[cmdline_file_count].echo =
+				(opt == TESTPMD_OPT_CMDLINE_FILE_NUM);
+			cmdline_file_count++;
 			break;
 		case TESTPMD_OPT_TX_FIRST_NUM:
 			printf("Ports to start sending a burst of "
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index b498e6d9fe..505e0283fa 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -105,8 +105,8 @@ int testpmd_logtype; /**< Log type for testpmd logs */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
-char cmdline_filename[PATH_MAX] = {0};
-bool echo_cmdline_file;
+struct cmdline_file_info cmdline_files[MAX_CMDLINE_FILENAMES] = {0};
+unsigned int cmdline_file_count;
 
 /*
  * NUMA support configuration.
@@ -4508,8 +4508,13 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE,
 			"Could not initialise cmdline context.\n");
 
-	if (strlen(cmdline_filename) != 0)
-		cmdline_read_from_file(cmdline_filename, echo_cmdline_file);
+	for (unsigned int i = 0; i < cmdline_file_count; i++) {
+		if (cmdline_read_from_file(cmdline_files[i].filename, cmdline_files[i].echo) != 0) {
+			fprintf(stderr, "Failed to process cmdline file: %s\n",
+					cmdline_files[i].filename);
+			break;
+		}
+	}
 
 	if (interactive == 1) {
 		if (auto_start) {
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 1d34f40deb..6ee229cb5c 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -36,6 +36,15 @@
 extern uint8_t cl_quit;
 extern volatile uint8_t f_quit;
 
+/* Max number of cmdline files we can take on testpmd cmdline */
+#define MAX_CMDLINE_FILENAMES 16
+
+/* Structure to track cmdline files and their echo settings */
+struct cmdline_file_info {
+	char filename[PATH_MAX];  /**< Path to the cmdline file */
+	bool echo;                /**< Whether to echo commands from this file */
+};
+
 /*
  * It is used to allocate the memory for hash key.
  * The hash key size is NIC dependent.
@@ -509,8 +518,8 @@ extern int testpmd_logtype; /**< Log type for testpmd logs */
 extern uint8_t  interactive;
 extern uint8_t  auto_start;
 extern uint8_t  tx_first;
-extern char cmdline_filename[PATH_MAX]; /**< offline commands file */
-extern bool echo_cmdline_file;  /** unset if cmdline-file-noecho is used */
+extern struct cmdline_file_info cmdline_files[MAX_CMDLINE_FILENAMES]; /**< offline commands files */
+extern unsigned int cmdline_file_count; /**< number of cmdline files */
 extern uint8_t  numa_support; /**< set by "--numa" parameter */
 extern uint16_t port_topology; /**< set by "--port-topology" parameter */
 extern uint8_t no_flush_rx; /**<set by "--no-flush-rx" parameter */
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 330c37f2d9..680ecefac2 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -41,8 +41,9 @@ The command line options are:
 
 *   ``--cmdline-file=filename, --cmdline-file-noecho=filename``
 
-    Read and execute commands from a file.
+    At startup, read and execute commands from a file.
     The file should contain the same commands that can be entered interactively.
+    This option can be specified multiple times to process several files in sequence.
     When using ``cmdline-file``, each command is printed as it is executed.
     When using ``cmdline-file-noecho``, the commands are executed silently.
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e12585f025..b8a401fa6f 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -67,13 +67,13 @@ Command File Functions
 To facilitate loading large number of commands or to avoid cutting and pasting where not
 practical or possible testpmd supports alternative methods for executing commands.
 
-* If started with the ``--cmdline-file=FILENAME`` command line argument testpmd
-  will execute all CLI commands contained within the file immediately before
+* If started with the ``--cmdline-file=FILENAME`` or ``--cmdline-file-noecho=FILENAME`` command line argument,
+  testpmd will execute all CLI commands contained within the file immediately before
   starting packet forwarding or entering interactive mode.
 
 .. code-block:: console
 
-   ./dpdk-testpmd -n4 -r2 ... -- -i --cmdline-file=/home/ubuntu/flow-create-commands.txt
+   ./dpdk-testpmd ... -- -i --cmdline-file-noecho=/home/ubuntu/flow-create-commands.txt
    Interactive-mode selected
    CLI commands to be read from /home/ubuntu/flow-create-commands.txt
    Configuring Port 0 (socket 0)
-- 
2.48.1

