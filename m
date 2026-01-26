Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6AD19503
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 16:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B145402D0;
	Mon, 26 Jan 2026 17:45:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8A6B8400D7
 for <dev@dpdk.org>; Mon, 26 Jan 2026 17:45:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769445935; x=1800981935;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Zux4z2fP7ajwwMfklLe14ix7sHl9kQH7vcQjl6e9UO8=;
 b=Q4nbSZqZaEOhMJAVtP+HJ+YKnH/0xTcDOYpBe7qZ7v4drNv4tSIfvvxC
 ncSsNMMLXkbFqcLM/nn2VUEUB5kYD1zreULPanlqgrP8D6aUq65qJm6/2
 ukJ54IkpEnVdnOsZDNRvcisXRHjciWBv0RkIaJhQEF11m7hxnrCH/a7rY
 l7NEv4EOpjDtVPitmYb+bI3iKFQb8mjN2HDSCnEYM/W+eltPaKvPzbjJd
 n1Dk5cwCW2nEq0GnZ0XWEo6/YtpGBIzJo1LUklf11TEVBc58BbxLD8r8/
 ISyaikoUG6NIURwe4MiG31d8Ekl8Xk8h8e9hW06hVdlP1cCjKsSFQwIV7 g==;
X-CSE-ConnectionGUID: qIZCjr9uRqaEoI8y1DVOnw==
X-CSE-MsgGUID: sQm+A6SkQlKgo8ysRu2b6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70531536"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="70531536"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 08:45:34 -0800
X-CSE-ConnectionGUID: v1wlpVAfRUORjYDFyqJtrg==
X-CSE-MsgGUID: vIwb7c4jTd29vtpcoS8VwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; d="scan'208";a="206838186"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 26 Jan 2026 08:45:33 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/2] test/eal_flags: add EAL debug logs to recursive calls
Date: Mon, 26 Jan 2026 16:45:19 +0000
Message-ID: <20260126164519.3029952-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126164519.3029952-1-bruce.richardson@intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
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

When we make recursive calls to dpdk-test to check flag support, either
as a secondary process or as another primary process, add the log-level
flag to give extra EAL output to help with debugging any issues. For
calls that are spawning another primary process, pass in --no-pci flag
too, to skip device probing.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_flags.c | 229 ++++++++++++++++++++------------------
 1 file changed, 122 insertions(+), 107 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 659a6745fd..1f8255cb3d 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -121,6 +121,9 @@ test_misc_flags(void)
 #define no_shconf "--no-shconf"
 #define allow "--allow"
 #define vdev "--vdev"
+#define no_pci "--no-pci"
+#define eal_debug_logs "--log-level=lib.eal:debug"
+#define bus_debug_logs "--log-level=bus.*:debug"
 #define memtest "memtest"
 #define memtest1 "memtest1"
 #define memtest2 "memtest2"
@@ -340,26 +343,26 @@ test_allow_flag(void)
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 #endif
 
-	const char *wlinval[][7] = {
-		{prgname, prefix, mp_flag,
+	const char *wlinval[][8] = {
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "error", "", ""},
-		{prgname, prefix, mp_flag,
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "0:0:0", "", ""},
-		{prgname, prefix, mp_flag,
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "0:error:0.1", "", ""},
-		{prgname, prefix, mp_flag,
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "0:0:0.1error", "", ""},
-		{prgname, prefix, mp_flag,
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "error0:0:0.1", "", ""},
-		{prgname, prefix, mp_flag,
+		{prgname, prefix, mp_flag, eal_debug_logs,
 				allow, "0:0:0.1.2", "", ""},
 	};
 	/* Test with valid allow option */
-	const char *wlval1[] = {prgname, prefix, mp_flag,
+	const char *wlval1[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			allow, "00FF:09:0B.3"};
-	const char *wlval2[] = {prgname, prefix, mp_flag,
+	const char *wlval2[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			allow, "09:0B.3", allow, "0a:0b.1"};
-	const char *wlval3[] = {prgname, prefix, mp_flag,
+	const char *wlval3[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			allow, "09:0B.3,type=test",
 			allow, "08:00.1,type=normal",
 	};
@@ -408,16 +411,16 @@ test_invalid_b_flag(void)
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 #endif
 
-	const char *blinval[][5] = {
-		{prgname, prefix, mp_flag, "-b", "error"},
-		{prgname, prefix, mp_flag, "-b", "0:0:0"},
-		{prgname, prefix, mp_flag, "-b", "0:error:0.1"},
-		{prgname, prefix, mp_flag, "-b", "0:0:0.1error"},
-		{prgname, prefix, mp_flag, "-b", "error0:0:0.1"},
-		{prgname, prefix, mp_flag, "-b", "0:0:0.1.2"},
+	const char *blinval[][6] = {
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "error"},
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0:0"},
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:error:0.1"},
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0:0.1error"},
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "error0:0:0.1"},
+		{prgname, prefix, mp_flag, eal_debug_logs, "-b", "0:0:0.1.2"},
 	};
 	/* Test with valid blocklist option */
-	const char *blval[] = {prgname, prefix, mp_flag,
+	const char *blval[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			       "-b", "FF:09:0B.3"};
 
 	int i;
@@ -454,18 +457,18 @@ test_invalid_vdev_flag(void)
 #endif
 
 	/* Test with invalid vdev option */
-	const char *vdevinval[] = {prgname, prefix, no_huge,
-				vdev, "eth_dummy"};
+	const char *vdevinval[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs, vdev, "eth_dummy"};
 
 	/* Test with valid vdev option */
-	const char *vdevval1[] = {prgname, prefix, no_huge,
-	vdev, "net_ring0"};
+	const char *vdevval1[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs,	vdev, "net_ring0"};
 
-	const char *vdevval2[] = {prgname, prefix, no_huge,
-	vdev, "net_ring0,args=test"};
+	const char *vdevval2[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs, vdev, "net_ring0,args=test"};
 
-	const char *vdevval3[] = {prgname, prefix, no_huge,
-	vdev, "net_ring0,nodeaction=r1:0:CREATE"};
+	const char *vdevval3[] = {prgname, prefix, no_huge, eal_debug_logs,
+				bus_debug_logs, vdev, "net_ring0,nodeaction=r1:0:CREATE"};
 
 	if (launch_proc(vdevinval) == 0) {
 		printf("Error (line %d) - process did run ok with invalid vdev parameter\n",
@@ -514,14 +517,14 @@ test_invalid_r_flag(void)
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
 #endif
 
-	const char *rinval[][5] = {
-			{prgname, prefix, mp_flag, "-r", "error"},
-			{prgname, prefix, mp_flag, "-r", "0"},
-			{prgname, prefix, mp_flag, "-r", "-1"},
-			{prgname, prefix, mp_flag, "-r", "17"},
+	const char *rinval[][6] = {
+			{prgname, prefix, mp_flag, eal_debug_logs, "-r", "error"},
+			{prgname, prefix, mp_flag, eal_debug_logs, "-r", "0"},
+			{prgname, prefix, mp_flag, eal_debug_logs, "-r", "-1"},
+			{prgname, prefix, mp_flag, eal_debug_logs, "-r", "17"},
 	};
 	/* Test with valid blocklist option */
-	const char *rval[] = {prgname, prefix, mp_flag, "-r", "16"};
+	const char *rval[] = {prgname, prefix, mp_flag, eal_debug_logs, "-r", "16"};
 
 	int i;
 
@@ -560,77 +563,77 @@ test_missing_c_flag(void)
 #endif
 
 	/* -c flag but no coremask value */
-	const char *argv1[] = { prgname, prefix, mp_flag, "-c"};
+	const char *argv1[] = { prgname, prefix, mp_flag, eal_debug_logs, "-c"};
 	/* No -c, -l or --lcores flag at all */
 	const char *argv2[] = { prgname, prefix, mp_flag};
 	/* bad coremask value */
-	const char *argv3[] = { prgname, prefix, mp_flag,
+	const char *argv3[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "error" };
 	/* sanity check of tests - valid coremask value */
-	const char *argv4[] = { prgname, prefix, mp_flag,
+	const char *argv4[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "1" };
 	/* -l flag but no corelist value */
-	const char *argv5[] = { prgname, prefix, mp_flag,
+	const char *argv5[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l"};
-	const char *argv6[] = { prgname, prefix, mp_flag,
+	const char *argv6[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", " " };
 	/* bad corelist values */
-	const char *argv7[] = { prgname, prefix, mp_flag,
+	const char *argv7[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "error" };
-	const char *argv8[] = { prgname, prefix, mp_flag,
+	const char *argv8[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "1-" };
-	const char *argv9[] = { prgname, prefix, mp_flag,
+	const char *argv9[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "1," };
-	const char *argv10[] = { prgname, prefix, mp_flag,
+	const char *argv10[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "-l", "1#2" };
 	/* core number is negative value */
-	const char * const argv11[] = { prgname, prefix, mp_flag,
+	const char * const argv11[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "-5" };
-	const char * const argv12[] = { prgname, prefix, mp_flag,
+	const char * const argv12[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "-5-7" };
 	/* core number is maximum value */
-	const char * const argv13[] = { prgname, prefix, mp_flag,
+	const char * const argv13[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", RTE_STR(RTE_MAX_LCORE) };
-	const char * const argv14[] = { prgname, prefix, mp_flag,
+	const char * const argv14[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-l", "1-"RTE_STR(RTE_MAX_LCORE) };
 	/* sanity check test - valid corelist value */
-	const char * const argv15[] = { prgname, prefix, mp_flag,
+	const char * const argv15[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "-l", "1-2,3" };
 
 	/* --lcores flag but no lcores value */
-	const char * const argv16[] = { prgname, prefix, mp_flag,
+	const char * const argv16[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores" };
-	const char * const argv17[] = { prgname, prefix, mp_flag,
+	const char * const argv17[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", " " };
 	/* bad lcores value */
-	const char * const argv18[] = { prgname, prefix, mp_flag,
+	const char * const argv18[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "1-3-5" };
-	const char * const argv19[] = { prgname, prefix, mp_flag,
+	const char * const argv19[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "0-1,,2" };
-	const char * const argv20[] = { prgname, prefix, mp_flag,
+	const char * const argv20[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "0-,1" };
-	const char * const argv21[] = { prgname, prefix, mp_flag,
+	const char * const argv21[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "(0-,2-4)" };
-	const char * const argv22[] = { prgname, prefix, mp_flag,
+	const char * const argv22[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "(-1,2)" };
-	const char * const argv23[] = { prgname, prefix, mp_flag,
+	const char * const argv23[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "(2-4)@(2-4-6)" };
-	const char * const argv24[] = { prgname, prefix, mp_flag,
+	const char * const argv24[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "(a,2)" };
-	const char * const argv25[] = { prgname, prefix, mp_flag,
+	const char * const argv25[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "1-3@(1,3)" };
-	const char * const argv26[] = { prgname, prefix, mp_flag,
+	const char * const argv26[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "3@((1,3)" };
-	const char * const argv27[] = { prgname, prefix, mp_flag,
+	const char * const argv27[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "(4-7)=(1,3)" };
-	const char * const argv28[] = { prgname, prefix, mp_flag,
+	const char * const argv28[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "[4-7]@(1,3)" };
 	/* sanity check of tests - valid lcores value */
-	const char * const argv29[] = { prgname, prefix, mp_flag,
+	const char * const argv29[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores",
 				 "0-1,2@(5-7),(3-5)@(0,2),(0,6),7"};
 	/* check an invalid cpu value >= CPU_SETSIZE */
-	const char * const argv30[] = { prgname, prefix, mp_flag,
+	const char * const argv30[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				 "--lcores", "3@" RTE_STR(CPU_SETSIZE) };
 
 	if (launch_proc(argv2) != 0) {
@@ -722,21 +725,21 @@ test_main_lcore_flag(void)
 		return TEST_SKIPPED;
 
 	/* --main-lcore flag but no value */
-	const char *argv1[] = { prgname, prefix, mp_flag,
+	const char *argv1[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "3", "--main-lcore"};
 	/* --main-lcore flag with invalid value */
-	const char *argv2[] = { prgname, prefix, mp_flag,
+	const char *argv2[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "3", "--main-lcore", "-1"};
-	const char *argv3[] = { prgname, prefix, mp_flag,
+	const char *argv3[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "3", "--main-lcore", "X"};
 	/* main lcore not in coremask */
-	const char *argv4[] = { prgname, prefix, mp_flag,
+	const char *argv4[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "3", "--main-lcore", "2"};
 	/* valid value */
-	const char *argv5[] = { prgname, prefix, mp_flag,
+	const char *argv5[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"-c", "3", "--main-lcore", "1"};
 	/* valid value set before coremask */
-	const char *argv6[] = { prgname, prefix, mp_flag,
+	const char *argv6[] = { prgname, prefix, mp_flag, eal_debug_logs,
 				"--main-lcore", "1", "-c", "3"};
 
 	if (launch_proc(argv1) == 0
@@ -832,9 +835,9 @@ test_no_hpet_flag(void)
 #endif
 
 	/* With --no-hpet */
-	const char *argv1[] = {prgname, prefix, mp_flag, no_hpet};
+	const char *argv1[] = {prgname, prefix, mp_flag, eal_debug_logs, no_hpet};
 	/* Without --no-hpet */
-	const char *argv2[] = {prgname, prefix, mp_flag};
+	const char *argv2[] = {prgname, prefix, mp_flag, eal_debug_logs};
 
 	if (launch_proc(argv1) != 0) {
 		printf("Error (line %d) - process did not run ok with --no-hpet flag\n", __LINE__);
@@ -997,105 +1000,117 @@ test_misc_flags(void)
 	 * No further testing of output done.
 	 */
 	/* sanity check - failure with invalid option */
-	const char *argv0[] = {prgname, prefix, mp_flag, "--invalid-opt"};
+	const char *argv0[] = {prgname, prefix, mp_flag, eal_debug_logs, "--invalid-opt"};
 
 	/* With --no-pci */
-	const char *argv1[] = {prgname, prefix, mp_flag, "--no-pci"};
+	const char *argv1[] = {prgname, prefix, mp_flag, eal_debug_logs, "--no-pci"};
 	/* With -v */
-	const char *argv2[] = {prgname, prefix, mp_flag, "-v"};
+	const char *argv2[] = {prgname, prefix, mp_flag, eal_debug_logs, "-v"};
 	/* With valid --syslog */
-	const char *argv3[] = {prgname, prefix, mp_flag, "--syslog=user"};
+	const char *argv3[] = {prgname, prefix, mp_flag, eal_debug_logs, "--syslog=user"};
 	/* With empty --syslog (now defaults) */
-	const char *argv4[] = {prgname, prefix, mp_flag, "--syslog"};
+	const char *argv4[] = {prgname, prefix, mp_flag, eal_debug_logs, "--syslog"};
 	/* With invalid --syslog */
-	const char *argv5[] = {prgname, prefix, mp_flag, "--syslog=invalid"};
+	const char *argv5[] = {prgname, prefix, mp_flag, eal_debug_logs, "--syslog=invalid"};
 
 	/* With no-sh-conf, also use no-huge to ensure this test runs on BSD */
-	const char *argv6[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+	const char *argv6[] = {prgname, eal_debug_logs, no_pci, "-m", DEFAULT_MEM_SIZE,
 			no_shconf, nosh_prefix, no_huge};
 
 	/* With --huge-dir */
 	const char *argv7[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath};
 	/* With empty --huge-dir (should fail) */
 	const char *argv8[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir"};
 	/* With invalid --huge-dir */
 	const char *argv9[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", "invalid"};
 	/* With invalid --huge-dir sub-directory */
 	const char *argv10[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath_dir};
 	/* With valid --huge-dir sub-directory */
 	const char *argv11[] = {prgname, "-m", DEFAULT_MEM_SIZE,
+			eal_debug_logs, no_pci,
 			"--file-prefix=hugedir", "--huge-dir", hugepath_dir2};
 	/* Secondary process with invalid --huge-dir (should run as flag has no
 	 * effect on secondary processes) */
-	const char *argv12[] = {prgname, prefix, mp_flag,
+	const char *argv12[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			"--huge-dir", "invalid"};
 
 	/* try running with base-virtaddr param */
 	const char *argv13[] = {prgname, "--file-prefix=virtaddr",
+			eal_debug_logs, no_pci,
 			"--base-virtaddr=0x23456789"};
 
 	/* try running with --vfio-intr INTx flag */
 	const char *argv14[] = {prgname, "--file-prefix=intr",
+			eal_debug_logs, no_pci,
 			"--vfio-intr=legacy"};
 
 	/* try running with --vfio-intr MSI flag */
 	const char *argv15[] = {prgname, "--file-prefix=intr",
+			eal_debug_logs, no_pci,
 			"--vfio-intr=msi"};
 
 	/* try running with --vfio-intr MSI-X flag */
 	const char *argv16[] = {prgname, "--file-prefix=intr",
+			eal_debug_logs, no_pci,
 			"--vfio-intr=msix"};
 
 	/* try running with --vfio-intr invalid flag */
 	const char *argv17[] = {prgname, "--file-prefix=intr",
+			eal_debug_logs, no_pci,
 			"--vfio-intr=invalid"};
 
 	/* With process type as auto-detect */
 	const char * const argv18[] = {prgname, "--file-prefix=auto",
+			eal_debug_logs, no_pci,
 			"--proc-type=auto"};
 
 	/* With process type as auto-detect with no-shconf */
-	const char * const argv19[] = {prgname, "--proc-type=auto",
+	const char * const argv19[] = {prgname, "--proc-type=auto", eal_debug_logs, no_pci,
 			no_shconf, nosh_prefix, no_huge};
 
 	/* With process type as --create-uio-dev flag */
 	const char * const argv20[] = {prgname, "--file-prefix=uiodev",
+			eal_debug_logs, no_pci,
 			"--create-uio-dev"};
 
 	/* Try running with --huge-worker-stack flag */
-	const char * const argv21[] = {prgname, prefix, mp_flag,
+	const char * const argv21[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--huge-worker-stack"};
 
 	/* Try running with --huge-worker-stack=512 flag */
-	const char * const argv22[] = {prgname, prefix, mp_flag,
+	const char * const argv22[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--huge-worker-stack=512"};
 
 	/* Try running with --log-timestamp */
-	const char * const argv23[] = {prgname, prefix, mp_flag,
+	const char * const argv23[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-timestamp" };
 
 	/* Try running with --log-timestamp=iso */
-	const char * const argv24[] = {prgname, prefix, mp_flag,
+	const char * const argv24[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-timestamp=iso" };
 
 	/* Try running with invalid timestamp */
-	const char * const argv25[] = {prgname, prefix, mp_flag,
+	const char * const argv25[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-timestamp=invalid" };
 
 	/* Try running with --log-color */
-	const char * const argv26[] = {prgname, prefix, mp_flag,
+	const char * const argv26[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-color" };
 
 	/* Try running with --log-color=never */
-	const char * const argv27[] = {prgname, prefix, mp_flag,
+	const char * const argv27[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-color=never" };
 
 	/* Try running with --log-color=invalid */
-	const char * const argv28[] = {prgname, prefix, mp_flag,
+	const char * const argv28[] = {prgname, prefix, mp_flag, eal_debug_logs,
 				       "--log-color=invalid" };
 
 	/* run all tests also applicable to FreeBSD first */
@@ -1285,47 +1300,47 @@ test_file_prefix(void)
 #endif
 
 	/* this should fail unless the test itself is run with "memtest" prefix */
-	const char *argv0[] = {prgname, mp_flag, "-m",
+	const char *argv0[] = {prgname, mp_flag, eal_debug_logs, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest };
 
 	/* primary process with memtest1 and default mem mode */
-	const char *argv1[] = {prgname, "-m",
+	const char *argv1[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest1 };
 
 	/* primary process with memtest1 and legacy mem mode */
-	const char *argv2[] = {prgname, "-m",
+	const char *argv2[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest1,
 			"--legacy-mem" };
 
 	/* primary process with memtest2 and legacy mem mode */
-	const char *argv3[] = {prgname, "-m",
+	const char *argv3[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest2,
 			"--legacy-mem" };
 
 	/* primary process with memtest2 and default mem mode */
-	const char *argv4[] = {prgname, "-m",
+	const char *argv4[] = {prgname, eal_debug_logs, no_pci, "-m",
 			DEFAULT_MEM_SIZE, "--file-prefix=" memtest2 };
 
 	/* primary process with --in-memory mode */
-	const char * const argv5[] = {prgname, "-m",
+	const char * const argv5[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory" };
 
 	/* primary process with memtest1 and --in-memory mode */
-	const char * const argv6[] = {prgname, "-m",
+	const char * const argv6[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory",
 		"--file-prefix=" memtest1 };
 
 	/* primary process with parent file-prefix and --in-memory mode */
-	const char * const argv7[] = {prgname, "-m",
+	const char * const argv7[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--in-memory", "--file-prefix", prefix };
 
 	/* primary process with memtest1 and --single-file-segments mode */
-	const char * const argv8[] = {prgname, "-m",
+	const char * const argv8[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--single-file-segments",
 		"--file-prefix=" memtest1 };
 
 	/* primary process with memtest1 and --huge-unlink=never mode */
-	const char * const argv9[] = {prgname, "-m",
+	const char * const argv9[] = {prgname, eal_debug_logs, no_pci, "-m",
 		DEFAULT_MEM_SIZE, "--huge-unlink=never",
 		"--file-prefix=" memtest1 };
 
@@ -1581,45 +1596,45 @@ test_memory_flags(void)
 #endif
 
 	/* valid -m flag and mp flag */
-	const char *argv0[] = {prgname, prefix, mp_flag,
+	const char *argv0[] = {prgname, prefix, mp_flag, eal_debug_logs,
 			"-m", DEFAULT_MEM_SIZE};
 
 	/* valid -m flag */
-	const char *argv1[] = {prgname,
+	const char *argv1[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "-m", DEFAULT_MEM_SIZE};
 
 	/* valid (zero) --socket-mem flag */
 	char arg2_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv2[] = {prgname,
+	const char *argv2[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg2_socket_mem};
 
 	/* invalid (incomplete) --socket-mem flag */
 	char arg3_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv3[] = {prgname,
+	const char *argv3[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg3_socket_mem};
 
 	/* invalid (mixed with invalid data) --socket-mem flag */
 	char arg4_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv4[] = {prgname,
+	const char *argv4[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg4_socket_mem};
 
 	/* invalid (with numeric value as last character) --socket-mem flag */
 	char arg5_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv5[] = {prgname,
+	const char *argv5[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg5_socket_mem};
 
 	/* invalid (with empty socket) --socket-mem flag */
 	char arg6_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv6[] = {prgname,
+	const char *argv6[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, arg6_socket_mem};
 
 	/* invalid (null) --socket-mem flag */
-	const char *argv7[] = {prgname,
+	const char *argv7[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "--socket-mem="};
 
 	/* valid --socket-mem specified together with -m flag */
 	char arg8_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv8[] = {prgname,
+	const char *argv8[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, "-m", DEFAULT_MEM_SIZE,
 			arg8_socket_mem};
 
@@ -1637,12 +1652,12 @@ test_memory_flags(void)
 
 	/* invalid --socket-mem flag (with extra socket) */
 	char invalid_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv9[] = {prgname,
+	const char *argv9[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, invalid_socket_mem};
 
 	/* valid --socket-mem flag */
 	char valid_socket_mem[SOCKET_MEM_STRLEN];
-	const char *argv10[] = {prgname,
+	const char *argv10[] = {prgname, eal_debug_logs, no_pci,
 			"--file-prefix=" memtest, valid_socket_mem};
 
 	if (launch_proc(argv0) != 0) {
-- 
2.51.0

