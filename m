Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E2C8303D
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 18:35:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3170C4067A;
	Fri,  4 Jul 2025 20:34:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 0D7E440677
 for <dev@dpdk.org>; Fri,  4 Jul 2025 20:34:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751654097; x=1783190097;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HQ0fxI9Qp/zsSXBs+2KXjNzaeK+jkoX1W7lV+NZCjF0=;
 b=lsx8ImZYEuzSDl8nm55/dZaMAllh4V3TTRp9e9VRBhRaZNgb7sC+s46Y
 T6yS+xTbjFTiWwfDqLp11Pkn5se502/w+MSzloYc26sd0HAOgT8ZYLWKU
 nPOfoqM1cr/T8Pvw02HPLcWigDnX2z0yeZMFkOryJiou4QaFA0x9LhcZ6
 uKuNO1htEFOPL8sW0w2LO9Q7/kbJAOIDMw7uZ0dja3o4ANiEosAT8zkhg
 tnDzK5rPEKAYaHcyE8smkZPuTO9fjpgxKMB7PD6JG19hUhfD2xxZPH0mv
 yHocKEGcYgCjhXGTH3wfwoRuoLlvvnCMg6SJ+FtLZRefdP9jzqveVg2OX A==;
X-CSE-ConnectionGUID: 1xdUKOjSTleAhdAFfwGx3Q==
X-CSE-MsgGUID: f8hYzUMETy+fIRcAJ4LVPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11484"; a="41613075"
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; d="scan'208";a="41613075"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 11:34:57 -0700
X-CSE-ConnectionGUID: aYlRQa84SpG51LXwMDMCUA==
X-CSE-MsgGUID: OM4OnSScRRiqtBIh9QZYsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,288,1744095600"; d="scan'208";a="159042661"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa003.jf.intel.com with ESMTP; 04 Jul 2025 11:34:56 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] app/testpmd: improve output when processing cmdline
 files
Date: Fri,  4 Jul 2025 19:34:36 +0100
Message-ID: <20250704183437.25901-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250704183437.25901-1-bruce.richardson@intel.com>
References: <20250704140551.4151993-1-bruce.richardson@intel.com>
 <20250704183437.25901-1-bruce.richardson@intel.com>
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

Two small improvements for the cmdline file processing in testpmd.

* Now that we support multiple files, change the prompt to indicate what
  file is currently being processed, and just print an EOF message when
  done.
* When not echoing, the "Read" verb in the message "Read CLI commands..."
  is a little ambiguous, as it could mean "I have read", or "Go and read",
  i.e. job done or job about to start. Tweak the text to "Finished reading"
  which is unambiguous.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test-pmd/cmdline.c                      | 27 ++++++++++++++++++---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 +--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 5433678b5e..b2a7aa8afd 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -10,6 +10,7 @@
 #include <stdio.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <libgen.h>
 #include <string.h>
 #include <unistd.h>
 #include <inttypes.h>
@@ -14195,6 +14196,7 @@ cmdline_read_from_file(const char *filename, bool echo)
 	struct cmdline *cl;
 	int fd = -1;
 	int ret = 0;
+	char *prompt = NULL;
 
 	/* cmdline_file_new does not produce any output
 	 * so when echoing is requested we open filename directly
@@ -14203,6 +14205,18 @@ cmdline_read_from_file(const char *filename, bool echo)
 	if (!echo) {
 		cl = cmdline_file_new(main_ctx, "testpmd> ", filename);
 	} else {
+		char *filename_copy = strdup(filename);
+
+		if (filename_copy == NULL) {
+			fprintf(stderr, "Failed to allocate memory for filename\n");
+			return -1;
+		}
+		if (asprintf(&prompt, "[%s] ", basename(filename_copy)) < 0) {
+			fprintf(stderr, "Failed to allocate prompt string\n");
+			return -1;
+		}
+		free(filename_copy);
+
 		fd = open(filename, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Failed to open file %s: %s\n",
@@ -14210,7 +14224,7 @@ cmdline_read_from_file(const char *filename, bool echo)
 			return -1;
 		}
 
-		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
+		cl = cmdline_new(main_ctx, prompt, fd, STDOUT_FILENO);
 	}
 	if (cl == NULL) {
 		fprintf(stderr,
@@ -14221,15 +14235,22 @@ cmdline_read_from_file(const char *filename, bool echo)
 	}
 
 	cmdline_interact(cl);
-	cmdline_quit(cl);
+	/* when done, if we have echo, we only need to print end of file,
+	 * but if no echo, we need to use printf and include the filename.
+	 */
+	if (echo)
+		cmdline_printf(cl, "<End-Of-File>\n");
+	else
+		printf("Finished reading CLI commands from %s\n", filename);
 
+	cmdline_quit(cl);
 	cmdline_free(cl);
 
-	printf("Read CLI commands from %s\n", filename);
 
 end:
 	if (fd >= 0)
 		close(fd);
+	free(prompt);
 	return ret;
 }
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index b8a401fa6f..2b0c4897ba 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -90,7 +90,7 @@ practical or possible testpmd supports alternative methods for executing command
    ...
    Flow rule #498 created
    Flow rule #499 created
-   Read all CLI commands from /home/ubuntu/flow-create-commands.txt
+   Finished reading all CLI commands from /home/ubuntu/flow-create-commands.txt
    testpmd>
 
 
@@ -106,7 +106,7 @@ practical or possible testpmd supports alternative methods for executing command
    ...
    Flow rule #498 created
    Flow rule #499 created
-   Read all CLI commands from /home/ubuntu/flow-create-commands.txt
+   Finished reading all CLI commands from /home/ubuntu/flow-create-commands.txt
    testpmd>
 
 
-- 
2.48.1

