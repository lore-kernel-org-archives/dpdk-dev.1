Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604C8D2ED0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 11:26:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E24740E21;
	Tue, 20 Jan 2026 12:26:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 76E7440E18
 for <dev@dpdk.org>; Tue, 20 Jan 2026 12:26:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768908384; x=1800444384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z868nQ89upuqXbUWoncakzUtSY39Tg3gZ7FnxffOE2g=;
 b=Bc2OJFutVXML3GyThhrMW2RxqywZlz+seJEk8JatMbW9OefXxuB+aUg6
 hnuk0L/vjOLSL+bbpK2KyWCnB1NXokpGd+tP5uotjdTVJ/Xyv1EB7b4tt
 DQxAxeXGig0DoWLAh4WdMAuGAU+kK4o7GW5ihqeErPvBWmpIOldsgM1EX
 9BjaRXkoE/avQixKpfYRyf8/vOCw0yWy3B1qoOYMq3JBQBN7xRcfsPaxw
 xDG5DyraSShqmy2SbG0NdHuNjlVlvYJ2B4FisXIEL8hFZxGlAJfm6+Nwz
 cvy4t3j0m1vTLR+BSDi9+9NCQ74vbcmk8EAIZc+MDgM5M5L8+ac2uGeQU A==;
X-CSE-ConnectionGUID: jmF6TmMPQ26DxxhiUzRcBA==
X-CSE-MsgGUID: fuaraMZTQT25TmTl5Rv25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69314496"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="69314496"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 03:26:23 -0800
X-CSE-ConnectionGUID: SiQjHXFSSBCII58MDbpcVQ==
X-CSE-MsgGUID: ZcAcXd5ZTF+9DFpd7ayBDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="205253404"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 20 Jan 2026 03:26:22 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 2/3] test/eal_flags: add line numbers to error messages
Date: Tue, 20 Jan 2026 11:25:51 +0000
Message-ID: <20260120112552.921243-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120112552.921243-1-bruce.richardson@intel.com>
References: <20260120112552.921243-1-bruce.richardson@intel.com>
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

To aid in debugging any problems, and because there are sometimes
multiple very similar error messages in tests, add line numbers to the
error message printouts.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_flags.c | 368 +++++++++++++++++++++-----------------
 1 file changed, 207 insertions(+), 161 deletions(-)

diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index 4ddcafdecb..aa70f11434 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -179,7 +179,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 			sizeof(hugefile_prefix), "%smap_", prefix);
 	if (prefix_len <= 0 || prefix_len >= (int)sizeof(hugefile_prefix)
 			|| prefix_len >= (int)sizeof(dirent->d_name)) {
-		printf("Error creating hugefile filename prefix\n");
+		printf("Error (line %d) - cannot create hugefile filename prefix\n", __LINE__);
 		return -1;
 	}
 
@@ -187,7 +187,7 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 	hugedir_handle = fopen("/proc/mounts", "r");
 
 	if (hugedir_handle == NULL) {
-		printf("Error parsing /proc/mounts!\n");
+		printf("Error (line %d) - cannot parse /proc/mounts!\n", __LINE__);
 		return -1;
 	}
 
@@ -201,7 +201,8 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 		/* check if directory exists */
 		if ((hugepage_dir = opendir(hugedir)) == NULL) {
 			fclose(hugedir_handle);
-			printf("Error reading %s: %s\n", hugedir, strerror(errno));
+			printf("Error (line %d) - cannot open %s: %s\n",
+					__LINE__, hugedir, strerror(errno));
 			return -1;
 		}
 
@@ -227,8 +228,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 
 					/* remove file */
 					if (remove(file_path) < 0) {
-						printf("Error deleting %s - %s!\n",
-								dirent->d_name, strerror(errno));
+						printf("Error (line %d) - cannot delete %s - %s!\n",
+								__LINE__,
+								dirent->d_name,
+								strerror(errno));
 						closedir(hugepage_dir);
 						result = -1;
 						goto end;
@@ -243,8 +246,10 @@ process_hugefiles(const char * prefix, enum hugepage_action action)
 
 					/* this shouldn't happen */
 					if (fd == -1) {
-						printf("Error opening %s - %s!\n",
-								dirent->d_name, strerror(errno));
+						printf("Error (line %d) - cannot open %s - %s!\n",
+								__LINE__,
+								dirent->d_name,
+								strerror(errno));
 						closedir(hugepage_dir);
 						result = -1;
 						goto end;
@@ -299,7 +304,8 @@ get_number_of_sockets(void)
 			printf("No NUMA nodes detected: assuming 1 available socket\n");
 			return 1;
 		}
-		printf("Error opening %s: %s\n", nodedir, strerror(errno));
+		printf("Error (line %d) - cannot open %s: %s\n",
+				__LINE__, nodedir, strerror(errno));
 		return -1;
 	}
 
@@ -327,7 +333,7 @@ test_allow_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -359,21 +365,23 @@ test_allow_flag(void)
 
 	for (i = 0; i < RTE_DIM(wlinval); i++) {
 		if (launch_proc(wlinval[i]) == 0) {
-			printf("Error - process did run ok with invalid "
-			    "allow parameter\n");
+			printf("Error (line %d) - process did run ok with invalid "
+			    "allow parameter\n", __LINE__);
 			return -1;
 		}
 	}
 	if (launch_proc(wlval1) != 0 ) {
-		printf("Error - process did not run ok with valid allow\n");
+		printf("Error (line %d) - process did not run ok with valid allow\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(wlval2) != 0 ) {
-		printf("Error - process did not run ok with valid allow value set\n");
+		printf("Error (line %d) - process did not run ok with valid allow value set\n",
+				__LINE__);
 		return -1;
 	}
 	if (launch_proc(wlval3) != 0 ) {
-		printf("Error - process did not run ok with valid allow + args\n");
+		printf("Error (line %d) - process did not run ok with valid allow + args\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -393,7 +401,7 @@ test_invalid_b_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -415,13 +423,14 @@ test_invalid_b_flag(void)
 
 	for (i = 0; i != RTE_DIM(blinval); i++) {
 		if (launch_proc(blinval[i]) == 0) {
-			printf("Error - process did run ok with invalid "
-			    "blocklist parameter\n");
+			printf("Error (line %d) - process did run ok with invalid "
+			    "blocklist parameter\n", __LINE__);
 			return -1;
 		}
 	}
 	if (launch_proc(blval) != 0) {
-		printf("Error - process did not run ok with valid blocklist value\n");
+		printf("Error (line %d) - process did not run ok with valid blocklist value\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -458,25 +467,26 @@ test_invalid_vdev_flag(void)
 	vdev, "net_ring0,nodeaction=r1:0:CREATE"};
 
 	if (launch_proc(vdevinval) == 0) {
-		printf("Error - process did run ok with invalid "
-			"vdev parameter\n");
+		printf("Error (line %d) - process did run ok with invalid "
+			"vdev parameter\n", __LINE__);
 		return -1;
 	}
 
 	if (launch_proc(vdevval1) != 0) {
-		printf("Error - process did not run ok with valid vdev value\n");
+		printf("Error (line %d) - process did not run ok with valid vdev value\n",
+				__LINE__);
 		return -1;
 	}
 
 	if (launch_proc(vdevval2) != 0) {
-		printf("Error - process did not run ok with valid vdev value,"
-			"with dummy args\n");
+		printf("Error (line %d) - process did not run ok with valid vdev value with dummy args\n",
+				__LINE__);
 		return -1;
 	}
 
 	if (launch_proc(vdevval3) != 0) {
-		printf("Error - process did not run ok with valid vdev value,"
-			"with valid args\n");
+		printf("Error (line %d) - process did not run ok with valid vdev value with valid args\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -497,7 +507,7 @@ test_invalid_r_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -516,13 +526,14 @@ test_invalid_r_flag(void)
 
 	for (i = 0; i != RTE_DIM(rinval); i++) {
 		if (launch_proc(rinval[i]) == 0) {
-			printf("Error - process did run ok with invalid "
-			    "-r (rank) parameter\n");
+			printf("Error (line %d) - process did run ok with invalid "
+			    "-r (rank) parameter\n", __LINE__);
 			return -1;
 		}
 	}
 	if (launch_proc(rval) != 0) {
-		printf("Error - process did not run ok with valid -r (rank) value\n");
+		printf("Error (line %d) - process did not run ok with valid -r (rank) value\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -541,7 +552,7 @@ test_missing_c_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -622,20 +633,20 @@ test_missing_c_flag(void)
 				 "--lcores", "3@" RTE_STR(CPU_SETSIZE) };
 
 	if (launch_proc(argv2) != 0) {
-		printf("Error - "
-		       "process did not run ok when missing -c flag\n");
+		printf("Error (line %d) - "
+		       "process did not run ok when missing -c flag\n", __LINE__);
 		return -1;
 	}
 
 	if (launch_proc(argv1) == 0
 			|| launch_proc(argv3) == 0) {
-		printf("Error - "
-		       "process ran without error with invalid -c flag\n");
+		printf("Error (line %d) - "
+		       "process ran without error with invalid -c flag\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(argv4) != 0) {
-		printf("Error - "
-		       "process did not run ok with valid coremask value\n");
+		printf("Error (line %d) - "
+		       "process did not run ok with valid coremask value\n", __LINE__);
 		return -1;
 	}
 
@@ -650,15 +661,15 @@ test_missing_c_flag(void)
 			|| launch_proc(argv12) == 0
 			|| launch_proc(argv13) == 0
 			|| launch_proc(argv14) == 0) {
-		printf("Error - "
-		       "process ran without error with invalid -l flag\n");
+		printf("Error (line %d) - "
+		       "process ran without error with invalid -l flag\n", __LINE__);
 		return -1;
 	}
 	if (rte_lcore_is_enabled(0) && rte_lcore_is_enabled(1) &&
 	    rte_lcore_is_enabled(2) && rte_lcore_is_enabled(3) &&
 	    launch_proc(argv15) != 0) {
-		printf("Error - "
-		       "process did not run ok with valid corelist value\n");
+		printf("Error (line %d) - "
+		       "process did not run ok with valid corelist value\n", __LINE__);
 		return -1;
 	}
 
@@ -670,8 +681,8 @@ test_missing_c_flag(void)
 	    launch_proc(argv24) == 0 || launch_proc(argv25) == 0 ||
 	    launch_proc(argv26) == 0 || launch_proc(argv27) == 0 ||
 	    launch_proc(argv28) == 0 || launch_proc(argv30) == 0) {
-		printf("Error - "
-		       "process ran without error with invalid --lcores flag\n");
+		printf("Error (line %d) - "
+		       "process ran without error with invalid --lcores flag\n", __LINE__);
 		return -1;
 	}
 
@@ -680,8 +691,8 @@ test_missing_c_flag(void)
 	    rte_lcore_is_enabled(4) && rte_lcore_is_enabled(5) &&
 	    rte_lcore_is_enabled(6) && rte_lcore_is_enabled(7) &&
 	    launch_proc(argv29) != 0) {
-		printf("Error - "
-		       "process did not run ok with valid corelist value\n");
+		printf("Error (line %d) - "
+		       "process did not run ok with valid corelist value\n", __LINE__);
 		return -1;
 	}
 
@@ -700,7 +711,7 @@ test_main_lcore_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -731,12 +742,14 @@ test_main_lcore_flag(void)
 			|| launch_proc(argv2) == 0
 			|| launch_proc(argv3) == 0
 			|| launch_proc(argv4) == 0) {
-		printf("Error - process ran without error with wrong --main-lcore\n");
+		printf("Error (line %d) - process ran without error with wrong --main-lcore\n",
+				__LINE__);
 		return -1;
 	}
 	if (launch_proc(argv5) != 0
 			|| launch_proc(argv6) != 0) {
-		printf("Error - process did not run ok with valid --main-lcore\n");
+		printf("Error (line %d) - process did not run ok with valid --main-lcore\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -757,7 +770,7 @@ test_invalid_n_flag(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -781,16 +794,17 @@ test_invalid_n_flag(void)
 	if (launch_proc(argv1) == 0
 			|| launch_proc(argv2) == 0
 			|| launch_proc(argv3) == 0) {
-		printf("Error - process ran without error when"
-		       "invalid -n flag\n");
+		printf("Error (line %d) - process ran without error when invalid -n flag\n",
+				__LINE__);
 		return -1;
 	}
 	if (launch_proc(argv4) != 0) {
-		printf("Error - process did not run ok with valid num-channel value\n");
+		printf("Error (line %d) - process did not run ok with valid num-channel value\n",
+				__LINE__);
 		return -1;
 	}
 	if (launch_proc(argv5) != 0) {
-		printf("Error - process did not run ok without -n flag\n");
+		printf("Error (line %d) - process did not run ok without -n flag\n", __LINE__);
 		return -1;
 	}
 
@@ -810,7 +824,7 @@ test_no_hpet_flag(void)
 #else
 	char tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -822,11 +836,12 @@ test_no_hpet_flag(void)
 	const char *argv2[] = {prgname, prefix, mp_flag};
 
 	if (launch_proc(argv1) != 0) {
-		printf("Error - process did not run ok with --no-hpet flag\n");
+		printf("Error (line %d) - process did not run ok with --no-hpet flag\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(argv2) != 0) {
-		printf("Error - process did not run ok without --no-hpet flag\n");
+		printf("Error (line %d) - process did not run ok without --no-hpet flag\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -868,11 +883,12 @@ test_no_huge_flag(void)
 			"--huge-worker-stack=512"};
 
 	if (launch_proc(argv1) != 0) {
-		printf("Error - process did not run ok with --no-huge flag\n");
+		printf("Error (line %d) - process did not run ok with --no-huge flag\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(argv2) != 0) {
-		printf("Error - process did not run ok with --no-huge and -m flags\n");
+		printf("Error (line %d) - process did not run ok with --no-huge and -m flags\n",
+				__LINE__);
 		return -1;
 	}
 #ifdef RTE_EXEC_ENV_FREEBSD
@@ -881,21 +897,23 @@ test_no_huge_flag(void)
 #endif
 
 	if (launch_proc(argv3) == 0) {
-		printf("Error - process run ok with --no-huge and --socket-mem "
-				"flags\n");
+		printf("Error (line %d) - process run ok with --no-huge and --socket-mem "
+				"flags\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(argv4) == 0) {
-		printf("Error - process run ok with --no-huge, -m and "
-				"--socket-mem flags\n");
+		printf("Error (line %d) - process run ok with --no-huge, -m and "
+				"--socket-mem flags\n", __LINE__);
 		return -1;
 	}
 	if (launch_proc(argv5) == 0) {
-		printf("Error - process run ok with --no-huge and --huge-worker-stack flags");
+		printf("Error (line %d) - process run ok with --no-huge and --huge-worker-stack flags\n",
+				__LINE__);
 		return -1;
 	}
 	if (launch_proc(argv6) == 0) {
-		printf("Error - process run ok with --no-huge and --huge-worker-stack=size flags");
+		printf("Error (line %d) - process run ok with --no-huge and --huge-worker-stack=size flags\n",
+				__LINE__);
 		return -1;
 	}
 	return 0;
@@ -920,7 +938,7 @@ test_misc_flags(void)
 	unsigned i, isempty = 1;
 
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -933,7 +951,7 @@ test_misc_flags(void)
 	hugedir_handle = fopen("/proc/mounts", "r");
 
 	if (hugedir_handle == NULL) {
-		printf("Error opening /proc/mounts!\n");
+		printf("Error (line %d) - cannot open /proc/mounts!\n", __LINE__);
 		return -1;
 	}
 
@@ -962,14 +980,14 @@ test_misc_flags(void)
 	snprintf(hugepath_dir2, sizeof(hugepath_dir2), "%s/dpdk.dir", hugepath);
 
 	if (mkdir(hugepath_dir2, 0700) != 0 && errno != EEXIST) {
-		printf("Error - failed to mkdir(%s)\n", hugepath_dir2);
+		printf("Error (line %d) - failed to mkdir(%s)\n", __LINE__, hugepath_dir2);
 		return -1;
 	}
 
 	snprintf(hugepath_dir3, sizeof(hugepath_dir3), "%s/dpdk.dir/sub", hugepath);
 
 	if (mkdir(hugepath_dir3, 0700) != 0 && errno != EEXIST) {
-		printf("Error - failed to mkdir(%s)\n", hugepath_dir3);
+		printf("Error (line %d) - failed to mkdir(%s)\n", __LINE__, hugepath_dir3);
 		goto fail;
 	}
 
@@ -1082,19 +1100,20 @@ test_misc_flags(void)
 	/* run all tests also applicable to FreeBSD first */
 
 	if (launch_proc(argv0) == 0) {
-		printf("Error - process ran ok with invalid flag\n");
+		printf("Error (line %d) - process ran ok with invalid flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv1) != 0) {
-		printf("Error - process did not run ok with --no-pci flag\n");
+		printf("Error (line %d) - process did not run ok with --no-pci flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv2) != 0) {
-		printf("Error - process did not run ok with -v flag\n");
+		printf("Error (line %d) - process did not run ok with -v flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv6) != 0) {
-		printf("Error - process did not run ok with --no-shconf flag\n");
+		printf("Error (line %d) - process did not run ok with --no-shconf flag\n",
+				__LINE__);
 		goto fail;
 	}
 
@@ -1104,110 +1123,124 @@ test_misc_flags(void)
 #endif
 
 	if (launch_proc(argv3) != 0) {
-		printf("Error - process did not run ok with --syslog=user flag\n");
+		printf("Error (line %d) - process did not run ok with --syslog=user flag\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv4) != 0) {
-		printf("Error - process did not run ok with --syslog flag\n");
+		printf("Error (line %d) - process did not run ok with --syslog flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv5) == 0) {
-		printf("Error - process run ok with --syslog=invalid flag\n");
+		printf("Error (line %d) - process run ok with --syslog=invalid flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv7) != 0) {
-		printf("Error - process did not run ok with --huge-dir flag\n");
+		printf("Error (line %d) - process did not run ok with --huge-dir flag\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv8) == 0) {
-		printf("Error - process run ok with empty --huge-dir flag\n");
+		printf("Error (line %d) - process run ok with empty --huge-dir flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv9) == 0) {
-		printf("Error - process run ok with invalid --huge-dir flag\n");
+		printf("Error (line %d) - process run ok with invalid --huge-dir flag\n", __LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv10) == 0) {
-		printf("Error - process run ok with invalid --huge-dir sub-dir flag\n");
+		printf("Error (line %d) - process run ok with invalid --huge-dir sub-dir flag\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv11) != 0) {
-		printf("Error - process did not run ok with --huge-dir subdir flag\n");
+		printf("Error (line %d) - process did not run ok with --huge-dir subdir flag\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv12) != 0) {
-		printf("Error - secondary process did not run ok with invalid --huge-dir flag\n");
+		printf("Error (line %d) - secondary process did not run ok with invalid --huge-dir flag\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv13) != 0) {
-		printf("Error - process did not run ok with --base-virtaddr parameter\n");
+		printf("Error (line %d) - process did not run ok with --base-virtaddr parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv14) != 0) {
-		printf("Error - process did not run ok with "
-				"--vfio-intr INTx parameter\n");
+		printf("Error (line %d) - process did not run ok with --vfio-intr INTx parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv15) != 0) {
-		printf("Error - process did not run ok with "
-				"--vfio-intr MSI parameter\n");
+		printf("Error (line %d) - process did not run ok with --vfio-intr MSI parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv16) != 0) {
-		printf("Error - process did not run ok with "
-				"--vfio-intr MSI-X parameter\n");
+		printf("Error (line %d) - process did not run ok with --vfio-intr MSI-X parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv17) == 0) {
-		printf("Error - process run ok with "
-				"--vfio-intr invalid parameter\n");
+		printf("Error (line %d) - process run ok with --vfio-intr invalid parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv18) != 0) {
-		printf("Error - process did not run ok with "
-				"--proc-type as auto parameter\n");
+		printf("Error (line %d) - process did not run ok with --proc-type as auto parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv19) != 0) {
-		printf("Error - process did not run ok with "
-				"--proc-type and --no-shconf parameter\n");
+		printf("Error (line %d) - process did not run ok with --proc-type and --no-shconf parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv20) != 0) {
-		printf("Error - process did not run ok with "
-				"--create-uio-dev parameter\n");
+		printf("Error (line %d) - process did not run ok with --create-uio-dev parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv21) != 0) {
-		printf("Error - process did not run ok with --huge-worker-stack parameter\n");
+		printf("Error (line %d) - process did not run ok with --huge-worker-stack parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv22) != 0) {
-		printf("Error - process did not run ok with --huge-worker-stack=size parameter\n");
+		printf("Error (line %d) - process did not run ok with --huge-worker-stack=size parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv23) != 0) {
-		printf("Error - process did not run ok with --log-timestamp parameter\n");
+		printf("Error (line %d) - process did not run ok with --log-timestamp parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv24) != 0) {
-		printf("Error - process did not run ok with --log-timestamp=iso parameter\n");
+		printf("Error (line %d) - process did not run ok with --log-timestamp=iso parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv25) == 0) {
-		printf("Error - process did run ok with --log-timestamp=invalid parameter\n");
+		printf("Error (line %d) - process did run ok with --log-timestamp=invalid parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv26) != 0) {
-		printf("Error - process did not run ok with --log-color parameter\n");
+		printf("Error (line %d) - process did not run ok with --log-color parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv27) != 0) {
-		printf("Error - process did not run ok with --log-color=never parameter\n");
+		printf("Error (line %d) - process did not run ok with --log-color=never parameter\n",
+				__LINE__);
 		goto fail;
 	}
 	if (launch_proc(argv28) == 0) {
-		printf("Error - process did run ok with --log-timestamp=invalid parameter\n");
+		printf("Error (line %d) - process did run ok with --log-timestamp=invalid parameter\n",
+				__LINE__);
 		goto fail;
 	}
 
@@ -1245,7 +1278,7 @@ test_file_prefix(void)
 	return 0;
 #else
 	if (get_current_prefix(prefix, sizeof(prefix)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 #endif
@@ -1297,13 +1330,15 @@ test_file_prefix(void)
 
 	/* check if files for current prefix are present */
 	if (process_hugefiles(prefix, HUGEPAGE_CHECK_EXISTS) != 1) {
-		printf("Error - hugepage files for %s were not created!\n", prefix);
+		printf("Error (line %d) - hugepage files for %s were not created!\n",
+				__LINE__, prefix);
 		return -1;
 	}
 
 	/* checks if files for current prefix are locked */
 	if (process_hugefiles(prefix, HUGEPAGE_CHECK_LOCKED) != 1) {
-		printf("Error - hugepages for current process aren't locked!\n");
+		printf("Error (line %d) - hugepages for current process aren't locked!\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -1311,32 +1346,37 @@ test_file_prefix(void)
 	if (process_hugefiles(memtest, HUGEPAGE_CHECK_EXISTS) == 1) {
 		/* check if they are not locked */
 		if (process_hugefiles(memtest, HUGEPAGE_CHECK_LOCKED) == 1) {
-			printf("Error - hugepages for current process are locked!\n");
+			printf("Error (line %d) - hugepages for current process are locked!\n",
+					__LINE__);
 			return -1;
 		}
 		/* they aren't locked, delete them */
 		else {
 			if (process_hugefiles(memtest, HUGEPAGE_DELETE) != 1) {
-				printf("Error - deleting hugepages failed!\n");
+				printf("Error (line %d) - deleting hugepages failed!\n",
+						__LINE__);
 				return -1;
 			}
 		}
 	}
 
 	if (launch_proc(argv0) == 0) {
-		printf("Error - secondary process ran ok without primary process\n");
+		printf("Error (line %d) - secondary process ran ok without primary process\n",
+				__LINE__);
 		return -1;
 	}
 
 	/* check if files for current prefix are present */
 	if (process_hugefiles(prefix, HUGEPAGE_CHECK_EXISTS) != 1) {
-		printf("Error - hugepage files for %s were not created!\n", prefix);
+		printf("Error (line %d) - hugepage files for %s were not created!\n",
+				__LINE__, prefix);
 		return -1;
 	}
 
 	/* checks if files for current prefix are locked */
 	if (process_hugefiles(prefix, HUGEPAGE_CHECK_LOCKED) != 1) {
-		printf("Error - hugepages for current process aren't locked!\n");
+		printf("Error (line %d) - hugepages for current process aren't locked!\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -1344,15 +1384,15 @@ test_file_prefix(void)
 	 * should clean up after itself on exit and leave no hugepages behind.
 	 */
 	if (launch_proc(argv1) != 0) {
-		printf("Error - failed to run with --file-prefix=%s\n",
-				memtest1);
+		printf("Error (line %d) - failed to run with --file-prefix=%s\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
 	/* check if memtest1_map0 is present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were not deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were not deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
@@ -1360,35 +1400,35 @@ test_file_prefix(void)
 	 * mem mode - this should leave behind hugepage files.
 	 */
 	if (launch_proc(argv2) != 0) {
-		printf("Error - failed to run with --file-prefix=%s\n",
-				memtest1);
+		printf("Error (line %d) - failed to run with --file-prefix=%s\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
 	/* check if memtest1_map0 is present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 1) {
-		printf("Error - hugepage files for %s were not created!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were not created!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
 	if (launch_proc(argv3) != 0) {
-		printf("Error - failed to run with --file-prefix=%s\n",
-				memtest2);
+		printf("Error (line %d) - failed to run with --file-prefix=%s\n",
+				__LINE__, memtest2);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest2 are present */
 	if (process_hugefiles(memtest2, HUGEPAGE_CHECK_EXISTS) != 1) {
-		printf("Error - hugepage files for %s were not created!\n",
-				memtest2);
+		printf("Error (line %d) - hugepage files for %s were not created!\n",
+				__LINE__, memtest2);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest1 are present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were not deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were not deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
@@ -1396,22 +1436,22 @@ test_file_prefix(void)
 	 * hugepage files behind.
 	 */
 	if (launch_proc(argv4) != 0) {
-		printf("Error - failed to run with --file-prefix=%s\n",
-				memtest2);
+		printf("Error (line %d) - failed to run with --file-prefix=%s\n",
+				__LINE__, memtest2);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest2 are present */
 	if (process_hugefiles(memtest2, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were not deleted!\n",
-				memtest2);
+		printf("Error (line %d) - hugepage files for %s were not deleted!\n",
+				__LINE__, memtest2);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest1 are present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were not deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were not deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
@@ -1421,7 +1461,8 @@ test_file_prefix(void)
 
 	/* test case to check eal-options with --in-memory mode */
 	if (launch_proc(argv5) != 0) {
-		printf("Error - failed to run with --in-memory mode\n");
+		printf("Error (line %d) - failed to run with --in-memory mode\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -1429,14 +1470,14 @@ test_file_prefix(void)
 	 * custom file-prefix.
 	 */
 	if (launch_proc(argv6) != 0) {
-		printf("Error - failed to run with --in-memory mode\n");
+		printf("Error (line %d) - failed to run with --in-memory mode\n", __LINE__);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest1 are present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were created and not deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were created and not deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
@@ -1444,7 +1485,7 @@ test_file_prefix(void)
 	 * parent file-prefix.
 	 */
 	if (launch_proc(argv7) != 0) {
-		printf("Error - failed to run with --file-prefix=%s\n", prefix);
+		printf("Error (line %d) - failed to run with --file-prefix=%s\n", __LINE__, prefix);
 		return -1;
 	}
 
@@ -1452,14 +1493,15 @@ test_file_prefix(void)
 	 * so it should not leave any hugepage files behind.
 	 */
 	if (launch_proc(argv8) != 0) {
-		printf("Error - failed to run with --single-file-segments mode\n");
+		printf("Error (line %d) - failed to run with --single-file-segments mode\n",
+				__LINE__);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest1 are present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) != 0) {
-		printf("Error - hugepage files for %s were not deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were not deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 
@@ -1467,18 +1509,18 @@ test_file_prefix(void)
 	 * so it should not remove hugepage files when it exits
 	 */
 	if (launch_proc(argv9) != 0) {
-		printf("Error - failed to run with --huge-unlink=never\n");
+		printf("Error (line %d) - failed to run with --huge-unlink=never\n", __LINE__);
 		return -1;
 	}
 
 	/* check if hugefiles for memtest1 are present */
 	if (process_hugefiles(memtest1, HUGEPAGE_CHECK_EXISTS) == 0) {
-		printf("Error - hugepage files for %s were deleted!\n",
-				memtest1);
+		printf("Error (line %d) - hugepage files for %s were deleted!\n",
+				__LINE__, memtest1);
 		return -1;
 	}
 	if (process_hugefiles(memtest1, HUGEPAGE_DELETE) != 1) {
-		printf("Error - deleting hugepages failed!\n");
+		printf("Error (line %d) - deleting hugepages failed!\n", __LINE__);
 		return -1;
 	}
 
@@ -1531,7 +1573,7 @@ test_memory_flags(void)
 #else
 	char prefix[PATH_MAX], tmp[PATH_MAX];
 	if (get_current_prefix(tmp, sizeof(tmp)) == NULL) {
-		printf("Error - unable to get current prefix!\n");
+		printf("Error (line %d) - unable to get current prefix!\n", __LINE__);
 		return -1;
 	}
 	snprintf(prefix, sizeof(prefix), "--file-prefix=%s", tmp);
@@ -1588,7 +1630,7 @@ test_memory_flags(void)
 #endif
 
 	if (num_sockets <= 0) {
-		printf("Error - cannot get number of sockets!\n");
+		printf("Error (line %d) - cannot get number of sockets!\n", __LINE__);
 		return -1;
 	}
 
@@ -1603,7 +1645,8 @@ test_memory_flags(void)
 			"--file-prefix=" memtest, valid_socket_mem};
 
 	if (launch_proc(argv0) != 0) {
-		printf("Error - secondary process failed with valid -m flag !\n");
+		printf("Error (line %d) - secondary process failed with valid -m flag !\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -1613,14 +1656,15 @@ test_memory_flags(void)
 #endif
 
 	if (launch_proc(argv1) != 0) {
-		printf("Error - process failed with valid -m flag!\n");
+		printf("Error (line %d) - process failed with valid -m flag!\n", __LINE__);
 		return -1;
 	}
 
 	populate_socket_mem_param(num_sockets, "0", "",
 		arg2_socket_mem, sizeof(arg2_socket_mem));
 	if (launch_proc(argv2) != 0) {
-		printf("Error - process failed with valid (zero) --socket-mem!\n");
+		printf("Error (line %d) - process failed with valid (zero) --socket-mem!\n",
+				__LINE__);
 		return -1;
 	}
 
@@ -1628,25 +1672,24 @@ test_memory_flags(void)
 		populate_socket_mem_param(num_sockets - 1, "2", ",",
 			arg3_socket_mem, sizeof(arg3_socket_mem));
 		if (launch_proc(argv3) == 0) {
-			printf("Error - process run ok with invalid "
-				"(incomplete) --socket-mem!\n");
+			printf("Error (line %d) - process run ok with invalid (incomplete) --socket-mem!\n",
+					__LINE__);
 			return -1;
 		}
 
 		populate_socket_mem_param(num_sockets - 1, "2", ",Fred",
 			arg4_socket_mem, sizeof(arg4_socket_mem));
 		if (launch_proc(argv4) == 0) {
-			printf("Error - process run ok with invalid "
-				"(mixed with invalid input) --socket-mem!\n");
+			printf("Error (line %d) - process run ok with invalid (mixed with invalid input) --socket-mem!\n",
+					__LINE__);
 			return -1;
 		}
 
 		populate_socket_mem_param(num_sockets - 1, "2", ",Fred0",
 			arg5_socket_mem, sizeof(arg5_socket_mem));
 		if (launch_proc(argv5) == 0) {
-			printf("Error - process run ok with invalid "
-				"(mixed with invalid input with a numeric value as "
-				"last character) --socket-mem!\n");
+			printf("Error (line %d) - process run ok with invalid (mixed with invalid input with a numeric value as last character) --socket-mem!\n",
+					__LINE__);
 			return -1;
 		}
 	}
@@ -1655,35 +1698,38 @@ test_memory_flags(void)
 		populate_socket_mem_param(num_sockets - 2, "2", ",,2",
 			arg6_socket_mem, sizeof(arg6_socket_mem));
 		if (launch_proc(argv6) == 0) {
-			printf("Error - process run ok with invalid "
-				"(with empty socket) --socket-mem!\n");
+			printf("Error (line %d) - process run ok with invalid (with empty socket) --socket-mem!\n",
+					__LINE__);
 			return -1;
 		}
 	}
 
 	if (launch_proc(argv7) == 0) {
-		printf("Error - process run ok with invalid (null) --socket-mem!\n");
+		printf("Error (line %d) - process run ok with invalid (null) --socket-mem!\n",
+				__LINE__);
 		return -1;
 	}
 
 	populate_socket_mem_param(num_sockets, "2", "",
 		arg8_socket_mem, sizeof(arg8_socket_mem));
 	if (launch_proc(argv8) == 0) {
-		printf("Error - process run ok with --socket-mem and -m specified!\n");
+		printf("Error (line %d) - process run ok with --socket-mem and -m specified!\n",
+				__LINE__);
 		return -1;
 	}
 
 	populate_socket_mem_param(num_sockets + 1, "2", "",
 		invalid_socket_mem, sizeof(invalid_socket_mem));
 	if (launch_proc(argv9) == 0) {
-		printf("Error - process run ok with extra socket in --socket-mem!\n");
+		printf("Error (line %d) - process run ok with extra socket in --socket-mem!\n",
+				__LINE__);
 		return -1;
 	}
 
 	populate_socket_mem_param(num_sockets, "2", "",
 		valid_socket_mem, sizeof(valid_socket_mem));
 	if (launch_proc(argv10) != 0) {
-		printf("Error - process failed with valid --socket-mem!\n");
+		printf("Error (line %d) - process failed with valid --socket-mem!\n", __LINE__);
 		return -1;
 	}
 
-- 
2.51.0

