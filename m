Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CEB109879E
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE13B40656;
	Fri, 20 Mar 2026 17:11:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 8011840652;
 Fri, 20 Mar 2026 17:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774023085; x=1805559085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pA7/kB0gJC2zetQkoMc3HhVqYijW4ryz9AbDAyvZrvw=;
 b=QZECS4F+UPKbmZ0T6PC70nomyBe8fZWBSDxlhNF95QKjzat0j/gcoIVL
 NcdpBHNc7vWH94ozMvbsL3YnHMWfuZ/8ftwjNjiLY+48dc+xWGT5fVkeA
 8we3QhRMZAJbLqQ1YfK7h0do95T/Z7Dv3ZJ2m8uhc2Ou1JyqJXEXDmfJT
 CK3YnCpfrjl/H92bi5pdu9sN5QDoPqZ+n78EqCBuVg1CdGRgt/X5XYbJq
 eDADmgWbNoJCwSmCGGiSYF6h0qSKDeiVr5XoZ6qB8PWOGarN8RCSvPex+
 C1AyDkKFfa1u8+VDRNB4A7tDMad7ClXyXEC44KcQKXuBcnsPL5Eox+S96 A==;
X-CSE-ConnectionGUID: A3rDC15zSJeKu8W493Kqxg==
X-CSE-MsgGUID: zJByFmfIRFWfVNcD1fJLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74995173"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="74995173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 09:11:21 -0700
X-CSE-ConnectionGUID: cTC+xCCcTjKBIoQHIULlEg==
X-CSE-MsgGUID: IKwq5e86RfSn7k1KdFpkEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223546894"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 20 Mar 2026 09:11:19 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, probb@iol.unh.edu,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/2] test: fix failing tests on FreeBSD
Date: Fri, 20 Mar 2026 16:11:07 +0000
Message-ID: <20260320161108.331745-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320161108.331745-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260320161108.331745-1-bruce.richardson@intel.com>
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

Many autotests were failing on FreeBSD, mostly because of the lack of
secondary process support. Skip these tests, and also fix the debug
autotest which crashes on FreeBSD if telemetry is not disabled for the
extra spawned process.

Bugzilla ID: 761
Fixes: 764bf26873b9 ("add FreeBSD support")
Fixes: 50247fe03fe0 ("test/timer: exercise new APIs in secondary process")
Fixes: 086eb64db39e ("test/pdump: add unit test for pdump library")
Fixes: b270daa43b3d ("test: support external memory")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 app/test/test_debug.c           |  6 +++---
 app/test/test_eal_flags.c       | 26 +++++++++++++-------------
 app/test/test_external_mem.c    |  4 ++--
 app/test/test_interrupts.c      |  2 +-
 app/test/test_mp_secondary.c    |  4 ++--
 app/test/test_pdump.c           |  4 ++++
 app/test/test_timer_secondary.c |  4 ++--
 7 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/app/test/test_debug.c b/app/test/test_debug.c
index bfda4d1aa3..eda9c3e0e1 100644
--- a/app/test/test_debug.c
+++ b/app/test/test_debug.c
@@ -154,15 +154,15 @@ test_debug(void)
 	test_args[2] = "-l";
 	test_args[3] = core;
 
-	if (rte_eal_has_hugepages()) {
+	if (rte_eal_has_hugepages() && RTE_EXEC_ENV_IS_LINUX) {
 		test_args[4] = "";
 		test_args[5] = "";
 		test_args[6] = "";
 		test_args[7] = "";
 	} else {
 		test_args[4] = "--no-huge";
-		test_args[5] = "-m";
-		test_args[6] = "2048";
+		test_args[5] = "-m2048";
+		test_args[6] = "--no-telemetry";
 #ifdef RTE_ARCH_PPC_64
 		/* iova=pa is the default, but fails on ppc64 with --no-huge */
 		test_args[7] = "--iova-mode=va";
diff --git a/app/test/test_eal_flags.c b/app/test/test_eal_flags.c
index b3a8d0ae6f..12280e7a39 100644
--- a/app/test/test_eal_flags.c
+++ b/app/test/test_eal_flags.c
@@ -10,88 +10,88 @@
 #include <string.h>
 #include <stdarg.h>
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 static int
 test_missing_c_flag(void)
 {
-	printf("missing_c_flag not supported on Windows, skipping test\n");
+	printf("missing_c_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_main_lcore_flag(void)
 {
-	printf("main_lcore_flag not supported on Windows, skipping test\n");
+	printf("main_lcore_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_invalid_n_flag(void)
 {
-	printf("invalid_n_flag not supported on Windows, skipping test\n");
+	printf("invalid_n_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_no_hpet_flag(void)
 {
-	printf("no_hpet_flag not supported on Windows, skipping test\n");
+	printf("no_hpet_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_no_huge_flag(void)
 {
-	printf("no_huge_flag not supported on Windows, skipping test\n");
+	printf("no_huge_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_allow_flag(void)
 {
-	printf("allow_flag not supported on Windows, skipping test\n");
+	printf("allow_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_invalid_b_flag(void)
 {
-	printf("invalid_b_flag not supported on Windows, skipping test\n");
+	printf("invalid_b_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_invalid_vdev_flag(void)
 {
-	printf("invalid_vdev_flag not supported on Windows, skipping test\n");
+	printf("invalid_vdev_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_invalid_r_flag(void)
 {
-	printf("invalid_r_flag not supported on Windows, skipping test\n");
+	printf("invalid_r_flag only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_memory_flags(void)
 {
-	printf("memory_flags not supported on Windows, skipping test\n");
+	printf("memory_flags only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_file_prefix(void)
 {
-	printf("file_prefix not supported on Windows, skipping test\n");
+	printf("file_prefix only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
 static int
 test_misc_flags(void)
 {
-	printf("misc_flags not supported on Windows, skipping test\n");
+	printf("misc_flags only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
diff --git a/app/test/test_external_mem.c b/app/test/test_external_mem.c
index 1c977b749b..53300983ed 100644
--- a/app/test/test_external_mem.c
+++ b/app/test/test_external_mem.c
@@ -10,11 +10,11 @@
 #include <string.h>
 #include <fcntl.h>
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 static int
 test_external_mem(void)
 {
-	printf("external_mem not supported on Windows, skipping test\n");
+	printf("external_mem only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 
diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 2eb876e65a..3a5be92cd7 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -429,7 +429,7 @@ test_interrupt(void)
 	int ret = -1;
 	struct rte_intr_handle *test_intr_handle;
 
-	if (RTE_EXEC_ENV_IS_WINDOWS)
+	if (RTE_EXEC_ENV_IS_WINDOWS || RTE_EXEC_ENV_IS_FREEBSD)
 		return TEST_SKIPPED;
 
 	if (test_interrupt_init() < 0) {
diff --git a/app/test/test_mp_secondary.c b/app/test/test_mp_secondary.c
index 218eacb3bf..93fcfd735b 100644
--- a/app/test/test_mp_secondary.c
+++ b/app/test/test_mp_secondary.c
@@ -15,11 +15,11 @@
 #include <string.h>
 #include <unistd.h>
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 int
 test_mp_secondary(void)
 {
-	printf("mp_secondary not supported on Windows, skipping test\n");
+	printf("Multiprocess support on present on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 #else
diff --git a/app/test/test_pdump.c b/app/test/test_pdump.c
index 824caef2d4..64f1bbf21c 100644
--- a/app/test/test_pdump.c
+++ b/app/test/test_pdump.c
@@ -198,6 +198,10 @@ int
 test_pdump(void)
 {
 	int ret = 0;
+
+	if (RTE_EXEC_ENV_IS_FREEBSD)
+		return TEST_SKIPPED;
+
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		printf("IN PRIMARY PROCESS\n");
 		ret = run_pdump_server_tests();
diff --git a/app/test/test_timer_secondary.c b/app/test/test_timer_secondary.c
index 0fc07dcbad..8582557035 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -16,11 +16,11 @@
 
 #include "test.h"
 
-#ifdef RTE_EXEC_ENV_WINDOWS
+#ifndef RTE_EXEC_ENV_LINUX
 int
 test_timer_secondary(void)
 {
-	printf("timer_secondary not supported on Windows, skipping test\n");
+	printf("timer_secondary only supported on Linux, skipping test\n");
 	return TEST_SKIPPED;
 }
 #else
-- 
2.51.0

