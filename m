Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94794C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 16:44:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8421402C9;
	Tue, 11 Feb 2025 17:44:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id B9A7D402A1
 for <dev@dpdk.org>; Tue, 11 Feb 2025 17:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739292251; x=1770828251;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=X3HATIrOCR4TlS+9smLnBaapfM5wrE66j91jrqmGPSA=;
 b=dkR5f9CwUuqNcJN7dA/kNX2DxQsPKAFwguu/ZzpGvm1NnVeo3aAYz9N4
 p50snV+1MFucx9fDODeBD31f/u6b6zebUefWbC/QmehkVvbTfRouA8fA3
 jBcf1vP3JssHQ6cgHWdaSKiakKpa1cZltSxaKS5Egl8UA6BpKbbJ5a+sM
 eQ+OzqEITVF6j40nsiFCq5x8Ewu2+Dg7koKjYIpFDugW6Embor19FUQ9K
 VVAy1a4t7wgSOy6N9OxK6te6J4yXchm9RW/zrsEP0pOOQM0F0FTpNNldf
 Fl3g4vD5eq2uBTkUmsvq/LUF/K/KiORuQTA2PS6G/LS9E+IJjc7994e+e Q==;
X-CSE-ConnectionGUID: vvfj9RI6RFutRb/pfzsL2g==
X-CSE-MsgGUID: 962LBrdFRZeVj/eGyLE1iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50905074"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; d="scan'208";a="50905074"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2025 08:44:10 -0800
X-CSE-ConnectionGUID: CjlucMMHQp2LJiC6ufFhoQ==
X-CSE-MsgGUID: siYyUhceQEmw3aKboxvqiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; d="scan'208";a="112326941"
Received: from silpixa00401197coob.ir.intel.com (HELO
 silpixa00401385.ir.intel.com) ([10.237.214.45])
 by orviesa009.jf.intel.com with ESMTP; 11 Feb 2025 08:44:09 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: pdamouny@nvidia.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH] app/test-pmd: add option to run startup cmds without echo
Date: Tue, 11 Feb 2025 16:44:02 +0000
Message-ID: <20250211164402.99941-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
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

Depending on the scenario, a user may want to run testpmd with
pre-canned startup commands either with or without echoing of those
commands as they are executed. To observe progress of each command, or
to help determine what command an error response is printed for, echoing
is useful. When running a large number of commands, performance can be
improved by disabling the echo of each one.

Therefore, we can add a new cmdline-file-noecho command to testpmd to
allow running without echo. Behaviour is otherwise the same as
cmdline-file command.

When adding the new command also:
* fix leak of the fd when using the existing cmdline-file flag
* add cmdline-file (and cmdline-file-noecho) to the testpmd docs

Bugzilla ID: 1612

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c                | 29 ++++++++++++++++++---------
 app/test-pmd/parameters.c             |  9 ++++++++-
 app/test-pmd/testpmd.c                |  1 +
 app/test-pmd/testpmd.h                |  1 +
 doc/guides/testpmd_app_ug/run_app.rst |  7 +++++++
 5 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 2897e44c34..1381ee6874 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -13855,24 +13855,29 @@ void
 cmdline_read_from_file(const char *filename)
 {
 	struct cmdline *cl;
+	int fd = -1;
 
-	/* cmdline_file_new does not produce any output which is not ideal here.
-	 * Much better to show output of the commands, so we open filename directly
+	/* cmdline_file_new does not produce any output
+	 * so when echoing is requested we open filename directly
 	 * and then pass that to cmdline_new with stdout as the output path.
 	 */
-	int fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		fprintf(stderr, "Failed to open file %s: %s\n",
-			filename, strerror(errno));
-		return;
-	}
+	if (!echo_cmdline_file) {
+		cl = cmdline_file_new(main_ctx, "testpmd> ", filename);
+	} else {
+		fd = open(filename, O_RDONLY);
+		if (fd < 0) {
+			fprintf(stderr, "Failed to open file %s: %s\n",
+				filename, strerror(errno));
+			return;
+		}
 
-	cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
+		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
+	}
 	if (cl == NULL) {
 		fprintf(stderr,
 			"Failed to create file based cmdline context: %s\n",
 			filename);
-		return;
+		goto end;
 	}
 
 	cmdline_interact(cl);
@@ -13881,6 +13886,10 @@ cmdline_read_from_file(const char *filename)
 	cmdline_free(cl);
 
 	printf("Read CLI commands from %s\n", filename);
+
+end:
+	if (fd >= 0)
+		close(fd);
 }
 
 void
diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index 7b31b94542..1132972913 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -51,6 +51,8 @@ enum {
 	TESTPMD_OPT_LONG_MIN_NUM = 256,
 #define TESTPMD_OPT_CMDLINE_FILE "cmdline-file"
 	TESTPMD_OPT_CMDLINE_FILE_NUM,
+#define TESTPMD_OPT_CMDLINE_FILE_NOECHO "cmdline-file-noecho"
+	TESTPMD_OPT_CMDLINE_FILE_NOECHO_NUM,
 #define TESTPMD_OPT_ETH_PEERS_CONFIGFILE "eth-peers-configfile"
 	TESTPMD_OPT_ETH_PEERS_CONFIGFILE_NUM,
 #define TESTPMD_OPT_ETH_PEER "eth-peer"
@@ -269,6 +271,7 @@ static const struct option long_options[] = {
 	NO_ARG(TESTPMD_OPT_HELP),
 	NO_ARG(TESTPMD_OPT_INTERACTIVE),
 	REQUIRED_ARG(TESTPMD_OPT_CMDLINE_FILE),
+	REQUIRED_ARG(TESTPMD_OPT_CMDLINE_FILE_NOECHO),
 	REQUIRED_ARG(TESTPMD_OPT_ETH_PEERS_CONFIGFILE),
 	REQUIRED_ARG(TESTPMD_OPT_ETH_PEER),
 	NO_ARG(TESTPMD_OPT_TX_FIRST),
@@ -387,7 +390,8 @@ usage(char* progname)
 	printf("\nUsage: %s [EAL options] -- [testpmd options]\n\n",
 	       progname);
 	printf("  --interactive: run in interactive mode.\n");
-	printf("  --cmdline-file: execute cli commands before startup.\n");
+	printf("  --cmdline-file: execute cli commands before startup, echoing each command as it is run.\n");
+	printf("  --cmdline-file-noecho: execute cli commands before startup, without echoing each command.\n");
 	printf("  --auto-start: start forwarding on init "
 	       "[always when non-interactive].\n");
 	printf("  --help: display this message and quit.\n");
@@ -956,6 +960,9 @@ launch_args_parse(int argc, char** argv)
 			exit(EXIT_SUCCESS);
 			break;
 		case TESTPMD_OPT_CMDLINE_FILE_NUM:
+			echo_cmdline_file = true;
+			/* fall-through */
+		case TESTPMD_OPT_CMDLINE_FILE_NOECHO_NUM:
 			printf("CLI commands to be read from %s\n",
 				optarg);
 			strlcpy(cmdline_filename, optarg,
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index ac654048df..f7dc6a9590 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -106,6 +106,7 @@ uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
 char cmdline_filename[PATH_MAX] = {0};
+bool echo_cmdline_file;
 
 /*
  * NUMA support configuration.
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 260e4761bd..425b608e3e 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -508,6 +508,7 @@ extern uint8_t  interactive;
 extern uint8_t  auto_start;
 extern uint8_t  tx_first;
 extern char cmdline_filename[PATH_MAX]; /**< offline commands file */
+extern bool echo_cmdline_file;  /** unset if cmdline-file-noecho is used */
 extern uint8_t  numa_support; /**< set by "--numa" parameter */
 extern uint16_t port_topology; /**< set by "--port-topology" parameter */
 extern uint8_t no_flush_rx; /**<set by "--no-flush-rx" parameter */
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 48717707a7..330c37f2d9 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -39,6 +39,13 @@ The command line options are:
 
     Display a help message and quit.
 
+*   ``--cmdline-file=filename, --cmdline-file-noecho=filename``
+
+    Read and execute commands from a file.
+    The file should contain the same commands that can be entered interactively.
+    When using ``cmdline-file``, each command is printed as it is executed.
+    When using ``cmdline-file-noecho``, the commands are executed silently.
+
 *   ``-a, --auto-start``
 
     Start forwarding on initialization.
-- 
2.43.0

