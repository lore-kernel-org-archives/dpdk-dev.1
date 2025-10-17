Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0073FCCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:06:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B928742D72;
	Fri, 17 Oct 2025 13:06:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id EDECC40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 13:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699206; x=1792235206;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XV3dFu59TV6hhTkhA6QJrQ+Y9EU7Z8UhO4zS+O0xlmc=;
 b=S5r5GD7VLdRWdgl9VjwkZZIz5O6JDOxS0Fo7wX4oca5woK3DQXOXuma+
 /K9m1RXgzZmMSQbNqGEnWuBptkRBPU21Yj11Ju5bYc76oLyYAzT0Ov9rp
 ph79IxSmwsmkWGxnxAGI4xcSymh8aCXV03bTiVvXWTcU+IppKwT+CSbB5
 JS3sWZZHoim4cp+h9P+VXgkkastVqhwwX5hCS8acBluQLuEKYRQ2C6933
 GbfvcCb6YjhFS9aHYw5+dLvR8gI49XtgcSkrzLu38J6V/KU3rQ26FbFeG
 Fw7Dhje93L0isPPQFSWy7P3vsC2gY+6DFItATYWOI2awje5+QQjGTlAy0 Q==;
X-CSE-ConnectionGUID: 9fAO0o2ST9+TGfhVmO2RWg==
X-CSE-MsgGUID: nDceEzwzT4+UM3bbbL0DsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="85525400"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="85525400"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:06:45 -0700
X-CSE-ConnectionGUID: njxHa7EOR5eXKUIFfpqGfw==
X-CSE-MsgGUID: Ke0RYTTnRsqhCeVFr9mskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="186969082"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 17 Oct 2025 04:06:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] app/pdump: improve cmdline argument handling
Date: Fri, 17 Oct 2025 12:06:37 +0100
Message-ID: <20251017110638.1094371-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251017110638.1094371-1-bruce.richardson@intel.com>
References: <20251017110638.1094371-1-bruce.richardson@intel.com>
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

Rework the argc/argv handling in pdump a little to improve things.
Issues with the original implementation:
* assumed user would never pass proc-type parameter on the commandline
* did not null-terminate the argv array (generally harmless but not in
  spec)
* did not handle case where arg processing in eal_init would reorder
  non-flag args to the end to be handled by the app.

Fix these - all-be-it minor issues, by having a separate count value for
the number of arguments we put in the argp array, rather than assuming
that its argc + 1 (for proc-type flag). Properly set the last argv entry
to NULL, and when processing app args, reuse the argp array passed to
eal_init rather than reverting back to the original argv array.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/pdump/main.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index f3ac81cb80..89347d70dc 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -983,7 +983,8 @@ main(int argc, char **argv)
 	int i;
 
 	char mp_flag[] = "--proc-type=secondary";
-	char *argp[argc + 1];
+	char *argp[argc + 2];  /* add proc-type, and final NULL entry */
+	int n_argp = 0;
 
 	/* catch ctrl-c so we can cleanup on exit */
 	sigemptyset(&action.sa_mask);
@@ -994,27 +995,27 @@ main(int argc, char **argv)
 	if (origaction.sa_handler == SIG_DFL)
 		sigaction(SIGHUP, &action, NULL);
 
-	argp[0] = argv[0];
-	argp[1] = mp_flag;
+	argp[n_argp++] = argv[0];
+	argp[n_argp++] = mp_flag;
 
-	for (i = 1; i < argc; i++)
-		argp[i + 1] = argv[i];
-
-	argc += 1;
+	for (i = 1; i < argc; i++) {
+		argp[n_argp] = argv[i];
+		/* drop any user-provided proc-type to avoid dup flags */
+		if (strncmp(argv[i], mp_flag, strlen("--proc-type")) != 0)
+			n_argp++;
+	}
+	argp[n_argp] = NULL;
 
-	diag = rte_eal_init(argc, argp);
+	diag = rte_eal_init(n_argp, argp);
 	if (diag < 0)
 		rte_panic("Cannot init EAL\n");
 
 	if (rte_eth_dev_count_avail() == 0)
 		rte_exit(EXIT_FAILURE, "No Ethernet ports - bye\n");
 
-	argc -= diag;
-	argv += (diag - 1);
-
 	/* parse app arguments */
-	if (argc > 1) {
-		ret = launch_args_parse(argc, argv, argp[0]);
+	if (n_argp - diag > 1) {
+		ret = launch_args_parse(n_argp - diag, argp + diag, argp[0]);
 		if (ret < 0)
 			rte_exit(EXIT_FAILURE, "Invalid argument\n");
 	}
-- 
2.48.1

