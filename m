Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE8C83F07
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Jul 2025 11:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 881A040650;
	Mon,  7 Jul 2025 13:18:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2B27E40650
 for <dev@dpdk.org>; Mon,  7 Jul 2025 13:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751887095; x=1783423095;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cMKAUSg6G9wy0otjezFmcnNpcB2k/NAyJjhAUnJATUY=;
 b=RJ8VqS6QK38IelYyR3QM1QVtq8HO6jzOkssrDtQUXsLrQXupGkp/hFgp
 FoTiZ2ikPH+N2Qv1hgEYD0kZ6yb+2k6oGaml3MLH5RcGRZ7k5M0/1q3sG
 ZTKJgopA7P0TmVyZuwA3Pp9iZwC1T+MaNxOkv/2z/m5Kd5f46ZZVvZad4
 MsYIHTDtZ7H4wbBh6WNGqr8jtpQVBc4yUvw/bENlHVlT5zwg2baVfyvXY
 08SExTCKMVm4KvOORE7is9fZOlaSe1WvlqM4b9akJP7m0neWPvf0hmMz9
 B43rIT78Bjs8OxLyezRJZqmzTxNCYNz2PxwNwRlZXHsS+j+p1H8QUybs+ g==;
X-CSE-ConnectionGUID: YMlTCbUDTROg6eaQVYxdFg==
X-CSE-MsgGUID: q7yReckpT32apeRYpKKzLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="54228352"
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="54228352"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 04:18:14 -0700
X-CSE-ConnectionGUID: F0cynDhoQmOyr6vJiOjGbA==
X-CSE-MsgGUID: 4uIDTDmqR5K/mMSPma7Zmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="155670965"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa008.jf.intel.com with ESMTP; 07 Jul 2025 04:18:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 3/3] app/testpmd: improve output when processing cmdline
 files
Date: Mon,  7 Jul 2025 12:17:51 +0100
Message-ID: <20250707111751.183469-4-bruce.richardson@intel.com>
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

Owing to limitations of whats available on windows, e.g. no basename
function, the windows implementation prints N characters from the end of
the filename, if its too long. While I don't think this is as good as the
basename version used on Linux/Unix, if we want to have common code, we can
just use that as a common version everywhere and drop the basename version.

---
 app/test-pmd/cmdline.c                      | 49 +++++++++++++++++++--
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 +-
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 5433678b5e..0c58abe1e4 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -14,6 +14,9 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <sys/queue.h>
+#ifndef RTE_EXEC_ENV_WINDOWS
+#include <libgen.h>
+#endif

 #include <rte_common.h>
 #include <rte_byteorder.h>
@@ -14195,6 +14198,7 @@ cmdline_read_from_file(const char *filename, bool echo)
 	struct cmdline *cl;
 	int fd = -1;
 	int ret = 0;
+	char *prompt = NULL;

 	/* cmdline_file_new does not produce any output
 	 * so when echoing is requested we open filename directly
@@ -14203,6 +14207,38 @@ cmdline_read_from_file(const char *filename, bool echo)
 	if (!echo) {
 		cl = cmdline_file_new(main_ctx, "testpmd> ", filename);
 	} else {
+#ifndef RTE_EXEC_ENV_WINDOWS
+		/* use basename(filename) as prompt */
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
+#else /* !WINDOWS */
+		/* No libgen and basename on windows, so just use short filename as prompt.
+		 * if filename is longer than N chars, copy to prompt only the
+		 * last N - 3 (since we add "...") chars, otherwise copy the whole filename.
+		 */
+#define FILE_STR_LEN 18
+		const unsigned int len = strlen(filename);
+		prompt = malloc(FILE_STR_LEN + 4); /* 4 for "[] " + '\0' */
+
+		if (prompt == NULL) {
+			fprintf(stderr, "Failed to allocate memory for prompt\n");
+			return -1;
+		}
+		if (len > FILE_STR_LEN)
+			sprintf(prompt, "[...%s] ", &filename[len - (FILE_STR_LEN - 3)]);
+		else
+			sprintf(prompt, "[%s] ", filename);
+#endif /* !WINDOWS */
+
 		fd = open(filename, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Failed to open file %s: %s\n",
@@ -14210,7 +14246,7 @@ cmdline_read_from_file(const char *filename, bool echo)
 			return -1;
 		}

-		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
+		cl = cmdline_new(main_ctx, prompt, fd, STDOUT_FILENO);
 	}
 	if (cl == NULL) {
 		fprintf(stderr,
@@ -14221,15 +14257,22 @@ cmdline_read_from_file(const char *filename, bool echo)
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

