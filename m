Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2C3109025C
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 17:14:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22B2B40647;
	Thu, 19 Mar 2026 18:13:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id EDBA3402B9;
 Thu, 19 Mar 2026 18:13:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773940436; x=1805476436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bhDIRBhUDpsdtfjQTo/oxJC/amA42TYHYwVYnAEAbBI=;
 b=mnSc3sCxOT8HuNsx0t1faea60mJaQJ4vVRZ5bmdvH1jOYYHmw87rcr9x
 BZm/pz3JV+i/LJQGsqQNgdpYm0fQALHFDIkxleN6DYUmJUppvfpcNB7Ew
 8KKQvrWWT2t6d+24pwNc6TarmKhhbk3C/S5JoscSHG+5ckvCKdf6No3WK
 ecAvYZQ6mwJC1D/sU0cCNt+1P7My/2sxh0w0Vy0mff0p7JAkJKSty7iYh
 WirGjgASxGFm0y0YH9gDQJH4MuqWj/pfPcGbpt0ebnX6KMHFO8x/pMpDT
 EEf8T7/BU6Knm2UcOSVRfgk1GbC8JX9dAxxnnN51qzu3fGctfIanbvnKh w==;
X-CSE-ConnectionGUID: eNgcD3HdRwO7NNOSzphARg==
X-CSE-MsgGUID: ObzkiYIdS+ebNjicaHOdPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="85648033"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="85648033"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 10:13:42 -0700
X-CSE-ConnectionGUID: ICYAZvzESiGl4UDC1MdIkg==
X-CSE-MsgGUID: uVzh72NoQyKJrJTSUnTlMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="227979624"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa005.jf.intel.com with ESMTP; 19 Mar 2026 10:13:41 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: lylavoie@iol.unh.edu, probb@iol.unh.edu, david.marchand@redhat.com,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH 2/7] test/eal_flags: skip test on FreeBSD
Date: Thu, 19 Mar 2026 17:11:36 +0000
Message-ID: <20260319171334.1151425-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171334.1151425-1-bruce.richardson@intel.com>
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
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

EAL flags tests depend on running secondary or multiple DPDK instances
so will not work on FreeBSD. Report these as SKIPPED tests on that
OS.

Bugzilla ID: 761 (partial fix)
Fixes: 764bf26873b9 ("add FreeBSD support")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_eal_flags.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

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
 
-- 
2.51.0

