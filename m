Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C0610F9963
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 17:44:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55C65402B5;
	Wed,  8 Apr 2026 19:44:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id DA1724014F;
 Wed,  8 Apr 2026 19:44:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775670255; x=1807206255;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WiY8p/WSwfxAwVADuCUPykYoGmJ5y+tjushuYw8l6Tw=;
 b=YICumcWJnh+Dr/uqHMM2FXwSOjkrpBTSJwxiuzeE0+UtZ5Ba/Ft5MkqS
 THzaTmqIRcDZzXw6ptVCejVFm+oTiLDujQ9lyA3rjyOf6ml004HUD4FMI
 S9YsWhFGk7rIvhuVxadPdqoGwte85PEjfAvJfB+ZE1LowRACYe1kJ3AO3
 b7ELbPFAkTuU8BGRlOz/yO6rUO6ydrtpbqZeAgA8ET5ztuRuozCwKCgNd
 f1aIAYy+wHlIIhY/Algp4rbwVR0zOaIUdFj3zkdNQy8R5Q9m0uLDghmZ9
 95pdzgnYYqqUX+sBe3UyLvd1XFLTXnoNGTg0qN+y1LwyxgPbzi0MY4CXy A==;
X-CSE-ConnectionGUID: p90VlPtoSNiB9t+vCuWQfQ==
X-CSE-MsgGUID: uqjgSZnWSBeBjBjNNQYCHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76851156"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76851156"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 10:44:14 -0700
X-CSE-ConnectionGUID: Ma0CD1NRQHKGrCOGovhXCA==
X-CSE-MsgGUID: v1nDvrEjQD6ih/k+rxrPCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="266510685"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 08 Apr 2026 10:44:12 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: david.marchand@redhat.com, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Adam Hassick <ahassick@iol.unh.edu>
Subject: [PATCH v3 1/2] test: fix failing tests on FreeBSD
Date: Wed,  8 Apr 2026 18:44:03 +0100
Message-ID: <20260408174404.2002743-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408174404.2002743-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260408174404.2002743-1-bruce.richardson@intel.com>
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
Tested-by: Adam Hassick <ahassick@iol.unh.edu>
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
index 218eacb3bf..d89419c253 100644
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
+	printf("Multiprocess support only present on Linux, skipping test\n");
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
index 57ab39130d..529774f4d0 100644
--- a/app/test/test_timer_secondary.c
+++ b/app/test/test_timer_secondary.c
@@ -18,11 +18,11 @@
 
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

