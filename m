Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C557D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 18:10:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACAC24021F;
	Mon,  1 Dec 2025 19:10:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 18F114013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 19:10:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764612638; x=1796148638;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=nqQ+YdtPKsn0m1wcZnPX+NoDctdF8BxYcZFGuHotMjU=;
 b=WoIFEVCq64o6pWB7MHWpSkyIkWgvlq0qNB8TlJu7aMnYwD/VjLk9S+EZ
 P+cYmHs6VpH0BFSVq/nW/0ZCKWabGAIdb68Y29Ypenz2vXtW+5H2hmGX1
 otlK7rs84bGxw9BhfFK22Y/ut1VyPBaM/XMkyCfonwNhx2addQmc5aIl3
 44KIIWwrfXPwjfEUVH77tA83qQ3ImfHACCaJjKpEBzBrkvrEOROYxZqdw
 GWDpe3cqX1sMplCFjKV7vnJ367Lq+ZCAPAc+2n1xPKJKh6YhbxdIdjSZF
 oCBlIs5/g0MdgDKxabRhessfHokaqmovsP+6NrRYIdRZTGW6ZhO1W8DNn g==;
X-CSE-ConnectionGUID: w+6oDW4sQR20X1VzMnb/Uw==
X-CSE-MsgGUID: 1I2YFzUvSjqwxXux8y6BOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="77192384"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="77192384"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 10:10:37 -0800
X-CSE-ConnectionGUID: Z2FrAqKNRnKZTFz7hP7cLA==
X-CSE-MsgGUID: wiQbywcqQfuYdBKmr7K0YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; d="scan'208";a="194351256"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 01 Dec 2025 10:10:36 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] app/test: remove use of coremasks
Date: Mon,  1 Dec 2025 18:10:24 +0000
Message-ID: <20251201181024.1583767-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

A number of test cases spawned off secondary processes and used the
"-c", or coremask, EAL option to do so. This option is deprecated, so
replace it with "-l" in tests.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_mp_secondary.c    | 13 ++++++-------
 app/test/test_pdump.c           |  7 +++----
 app/test/test_timer_secondary.c |  6 +++---
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index f3694530a8..2593454b2c 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -66,7 +66,7 @@ static int
 run_secondary_instances(void)
 {
 	int ret = 0;
-	char coremask[10];
+	char core_str[10];
 
 #ifdef RTE_EXEC_ENV_LINUX
 	char tmp[PATH_MAX] = {0};
@@ -81,29 +81,28 @@ run_secondary_instances(void)
 
 	/* good case, using secondary */
 	const char *argv1[] = {
-			prgname, "-c", coremask, "--proc-type=secondary",
+			prgname, "-l", core_str, "--proc-type=secondary",
 			prefix
 	};
 	/* good case, using auto */
 	const char *argv2[] = {
-			prgname, "-c", coremask, "--proc-type=auto",
+			prgname, "-l", core_str, "--proc-type=auto",
 			prefix
 	};
 	/* bad case, using invalid type */
 	const char *argv3[] = {
-			prgname, "-c", coremask, "--proc-type=ERROR",
+			prgname, "-l", core_str, "--proc-type=ERROR",
 			prefix
 	};
 #ifdef RTE_EXEC_ENV_LINUX
 	/* bad case, using invalid file prefix */
 	const char *argv4[]  = {
-			prgname, "-c", coremask, "--proc-type=secondary",
+			prgname, "-l", core_str, "--proc-type=secondary",
 					"--file-prefix=ERROR"
 	};
 #endif
 
-	snprintf(coremask, sizeof(coremask), "%x", \
-			(1 << rte_get_main_lcore()));
+	snprintf(core_str, sizeof(core_str), "%u", rte_get_main_lcore());
 
 	ret |= launch_proc(argv1);
 	printf("### Testing rte_mp_disable() reject:\n");
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 9f7769707e..1d3fe6e2d5 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -173,7 +173,7 @@ int
 run_pdump_server_tests(void)
 {
 	int ret = 0;
-	char coremask[10];
+	char core_str[10];
 
 #ifdef RTE_EXEC_ENV_LINUX
 	char tmp[PATH_MAX] = { 0 };
@@ -187,12 +187,11 @@ run_pdump_server_tests(void)
 
 	/* good case, using secondary */
 	const char *const argv1[] = {
-		prgname, "-c", coremask, "--proc-type=secondary",
+		prgname, "-l", core_str, "--proc-type=secondary",
 		prefix
 	};
 
-	snprintf(coremask, sizeof(coremask), "%x",
-		 (1 << rte_get_main_lcore()));
+	snprintf(core_str, sizeof(core_str), "%u", rte_get_main_lcore());
 
 	ret = test_pdump_init();
 	ret |= launch_p(argv1);
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 4e220559b4..60ce8c7507 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -50,7 +50,7 @@ struct test_info {
 static int
 timer_secondary_spawn_wait(unsigned int lcore)
 {
-	char coremask[10];
+	char core_str[10];
 #ifdef RTE_EXEC_ENV_LINUXAPP
 	char tmp[PATH_MAX] = {0};
 	char prefix[PATH_MAX] = {0};
@@ -63,12 +63,12 @@ timer_secondary_spawn_wait(unsigned int lcore)
 #endif
 	char const *argv[] = {
 		prgname,
-		"-c", coremask,
+		"-l", core_str,
 		"--proc-type=secondary",
 		prefix
 	};
 
-	snprintf(coremask, sizeof(coremask), "%x", (1 << lcore));
+	snprintf(core_str, sizeof(core_str), "%u", lcore);
 
 	return launch_proc(argv);
 }
-- 
2.51.0

