Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9000CC87FCC
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 16:01:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71BA040657;
	Thu, 31 Jul 2025 18:01:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8E6824064C
 for <dev@dpdk.org>; Thu, 31 Jul 2025 18:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753977690; x=1785513690;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YXIzLyfaIVu28Kik1gbWCJSFyaJcylcS0UjylD7E4P8=;
 b=PF6VdALqqSh0xpFDqDBlgI+V6Br5T/NkMkQHGJ44kQf7h0Vu31dh8lqo
 fXV+1y2HIjLNP+wyWk1j0SaereDFwxuxiqOORWERdBzN48Ye/WMW49xng
 zyXsRniIJGmdcF71b5qyIbM7Uljo8/xxdTTezov4Oui9ObqExpIDb+PNF
 Q1K5FHmfC8xEPtEt7LQp3GCdhi2MXeYeqJ3ObKgZCf9yjmmkQFr3lzYPI
 bJTWNcMcnRfT+Yg40MKXtd0caeohPE/EvzzSkhl7fVToXnmuqQN8832NJ
 /qvdnUJaF+zKxGPKVq87pvQaKnu+6m1MMrIMFoeEi/nmQck2/gRXtoTnS Q==;
X-CSE-ConnectionGUID: JEryDcMFSCKyzEqpv7ElkQ==
X-CSE-MsgGUID: eZcif8zYTWKH+RwLBwFdqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="78858046"
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="78858046"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 09:01:09 -0700
X-CSE-ConnectionGUID: eH1s68thRIymt2YFIk7tGw==
X-CSE-MsgGUID: xZCyt1jLTye9ne5U55X8Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,254,1747724400"; d="scan'208";a="167543449"
Received: from silpixa00401874.ir.intel.com (HELO
 silpixa00401874.ger.corp.intel.com) ([10.55.129.54])
 by fmviesa005.fm.intel.com with ESMTP; 31 Jul 2025 09:01:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, andremue@linux.microsoft.com,
 Bruce Richardson <bruce.richardson@intel.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 4/4] app/testpmd: improve output when processing cmdline
 files
Date: Thu, 31 Jul 2025 16:00:41 +0000
Message-ID: <20250731160041.914837-5-bruce.richardson@intel.com>
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
 app/test-pmd/cmdline.c                      | 18 +++++++++++++++---
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  4 ++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index 5433678b5e..c436a2fa21 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -14203,6 +14203,12 @@ cmdline_read_from_file(const char *filename, bool echo)
 	if (!echo) {
 		cl = cmdline_file_new(main_ctx, "testpmd> ", filename);
 	} else {
+		/* use basename(filename) as prompt */
+		char prompt[32] = "[] ";
+
+		rte_basename(filename, &prompt[1], sizeof(prompt) - strlen(prompt));
+		strlcat(prompt, "] ", sizeof(prompt));
+
 		fd = open(filename, O_RDONLY);
 		if (fd < 0) {
 			fprintf(stderr, "Failed to open file %s: %s\n",
@@ -14210,7 +14216,7 @@ cmdline_read_from_file(const char *filename, bool echo)
 			return -1;
 		}
 
-		cl = cmdline_new(main_ctx, "testpmd> ", fd, STDOUT_FILENO);
+		cl = cmdline_new(main_ctx, prompt, fd, STDOUT_FILENO);
 	}
 	if (cl == NULL) {
 		fprintf(stderr,
@@ -14221,11 +14227,17 @@ cmdline_read_from_file(const char *filename, bool echo)
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

