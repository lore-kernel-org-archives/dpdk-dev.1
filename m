Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B648CCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 11:06:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3A7542D0C;
	Fri, 17 Oct 2025 13:06:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 3F0E340269;
 Fri, 17 Oct 2025 13:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760699205; x=1792235205;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hB6M8n+A+A1+sX6vsvGTaRTBDp5LAp6kJZRtUAlagx4=;
 b=biYLpfsVzG5EM1ag3LJY5D1Pr9G48EVPNrrFWuWL39AdOhomPwvVvNTE
 bKQIklpN1psLLXARkcaVDppxhnCuuUbwuSNPwsGgGP6lzRBOCjdqIW/9b
 QInFNdyuo6ajFFDi6ibpV6zBycsw1wgU0mzHX51oDrS6xjoq+HiyFJzxr
 76ar9EoeQksCRPXMqoBKMv1JFizF+I5090qiCPriVGIyXvxf2AkeIwWf3
 OGyBZi2JYmCGhdr2k+CRRYk2ukU0TRVMPgssO5IBCWTkhUgu8qLPQl9h8
 KNe4hWjVP25Cp71dgtUAYPQQ4o8CSTc1vHaDMkYWRGNgqOkCUySBxt+yP w==;
X-CSE-ConnectionGUID: R5CtP7CSTcCx4x1rvq2Qug==
X-CSE-MsgGUID: AsZN4TpER1iii7GQLa5VXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="85525398"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="85525398"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 04:06:44 -0700
X-CSE-ConnectionGUID: xbu63ECmS2iNSFgBhJo9Hg==
X-CSE-MsgGUID: wqPVjMaCRpOlBMZapfLHWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="186969074"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 17 Oct 2025 04:06:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
	stable@dpdk.org
Subject: [PATCH 1/2] app/pdump: remove hard-coded memory channels EAL arg
Date: Fri, 17 Oct 2025 12:06:36 +0100
Message-ID: <20251017110638.1094371-1-bruce.richardson@intel.com>
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

The pdump main function modifies argc/argv before calling EAL init
function. It needs to do so in order to add the proc-type=secondary
flag, but also adds in "-n4" as parameter. This parameter is unnecessary
and also causes duplicate parameter errors if the user also passes in -n
flag on the commandline. Just remove this flag.

Fixes: caa7028276b8 ("app/pdump: add tool for packet capturing")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/pdump/main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/app/pdump/main.c b/app/pdump/main.c
index fa85859703..f3ac81cb80 100644
--- a/app/pdump/main.c
+++ b/app/pdump/main.c
@@ -982,9 +982,8 @@ main(int argc, char **argv)
 	int ret;
 	int i;
 
-	char n_flag[] = "-n4";
 	char mp_flag[] = "--proc-type=secondary";
-	char *argp[argc + 2];
+	char *argp[argc + 1];
 
 	/* catch ctrl-c so we can cleanup on exit */
 	sigemptyset(&action.sa_mask);
@@ -996,13 +995,12 @@ main(int argc, char **argv)
 		sigaction(SIGHUP, &action, NULL);
 
 	argp[0] = argv[0];
-	argp[1] = n_flag;
-	argp[2] = mp_flag;
+	argp[1] = mp_flag;
 
 	for (i = 1; i < argc; i++)
-		argp[i + 2] = argv[i];
+		argp[i + 1] = argv[i];
 
-	argc += 2;
+	argc += 1;
 
 	diag = rte_eal_init(argc, argp);
 	if (diag < 0)
@@ -1012,7 +1010,7 @@ main(int argc, char **argv)
 		rte_exit(EXIT_FAILURE, "No Ethernet ports - bye\n");
 
 	argc -= diag;
-	argv += (diag - 2);
+	argv += (diag - 1);
 
 	/* parse app arguments */
 	if (argc > 1) {
-- 
2.48.1

