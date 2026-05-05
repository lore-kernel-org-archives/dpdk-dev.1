Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A540CD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:31:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 411C340664;
	Tue,  5 May 2026 07:30:52 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 42C0E40664
 for <dev@dpdk.org>; Tue,  5 May 2026 07:30:50 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644NRnkX3164635; Mon, 4 May 2026 22:30:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
 VMfahwMh+Plz2XPmyVAmFnh7mJsRLZ016oNHPSda8s=; b=Ukb4Sj/vZYnTjT3e6
 LrwGlSuC9AdIxBcRmisnmaaBSCL2HnebYOot9mZ7LFdeCPQlwtD6lZwPLPqapQfH
 q2O1gm0kgmY6G91yawGYjaJt3UjAx9MXJ2+taoyGkxo2joB18/KdbkM/GTKSLXqW
 WziCiboFkvIqcfjtl3Q//b8mlL56wJz68UAQ0okfmlFGJSCEQk8zEJTmARdnA3rx
 J5NTEHBaBLrtnCJFNteCYu91NSaQRbYWGPKO3hPGwaFbLNULZPZHE8/P16LILPk0
 r4GuJxb0/tbGM4Uj0jDV7xMo3HKTC3flPYZRtK6ctTr4nSqQSzKrPoeIiRjSdRlc
 XbsGw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4dy55brn3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:30:49 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 22:30:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 22:30:48 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id D0D4A3F70B3;
 Mon,  4 May 2026 22:30:45 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>, <mb@smartsharesystems.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 5/5] test/pmu: improve error handling and enable test
Date: Tue, 5 May 2026 11:00:23 +0530
Message-ID: <20260505053023.3854665-5-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260505053023.3854665-1-rkudurumalla@marvell.com>
References: <20251024054830.933910-8-tduszynski@marvell.com>
 <20260505053023.3854665-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ju4HhCMII8q7wAfyUEa2o6EXlApJERml
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA0OCBTYWx0ZWRfX+p7xu/jb2u8i
 pdop6XIsXLbDqcFfJR0eb+W9ozMIoY//W1DvoiD4QvD4KigqMKE9MpzKsuwuxwx8gT4NBeLKdqv
 g5x71cUej5nrBEHkQ719dTpkSYM8tozZA7B+yylymN1I/Ef5QWjZFYayN1E+rDxamDmLFCzzDHT
 erZWENKowOvFXOtWbyEk25FpktW3SVQhKlNrqGIEIpMyQn5bLkyykoZUWwRN1cKDbSzEnRRiDlp
 t6tYv63gQI8OpTj4EQUTTOpMM74GrN8w060U+rYbguVm75VdS49RyD8w4cnh1HUovc20hYzgSAx
 FaC0mVa2HOEUpSwwIiJg0bQBHSUJ/QW1vjZfki97hxPraKyWr2e0XBAFJBNfBgxko9G4LmUjmkc
 ZT8yx4nmZWuxp/q2Y0eRvU5NQR9T0mfv4DAtV/Jz+T0Hs5WRxoMvdpc2j2zo3kJCbbFcUKhH/aG
 BdwNtfJzH4/gYf/G2kg==
X-Proofpoint-ORIG-GUID: ju4HhCMII8q7wAfyUEa2o6EXlApJERml
X-Authority-Analysis: v=2.4 cv=KMdqylFo c=1 sm=1 tr=0 ts=69f98089 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=qf4gfuq51q0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=Pi-TTh1At0rvmWiH9OMA:9 a=3ZKOabzyN94A:10
 a=k40Crp0UdiQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Improve test_pmu error handling to distinguish between different
failure scenarios based on rte_pmu_init() return codes.

Changes:
- Handle -ENODEV (no hardware) -> return TEST_SKIPPED
  This is not a test failure, just missing hardware

- Handle -EACCES (permission denied) -> return TEST_FAILED
  This indicates a configuration issue that user must fix
  Provide helpful hint about adjusting perf_event_paranoid

- Handle other errors -> return TEST_FAILED
  Unexpected errors should fail the test

- Add error checking for rte_pmu_add_event()
  Print event name if addition fails
  Properly cleanup with rte_pmu_fini()

- Check if PMU counter returned zero
  Print message to help diagnose the issue

- Re-enable the test by adding REGISTER_FAST_TEST()
  Test was previously disabled due to failures
  With improved error handling, failures can be properly diagnosed

This makes test results more informative:
- TEST_SKIPPED: No PMU hardware (expected on some platforms)
- TEST_FAILED: Configuration issue or real bug (requires action)
- TEST_SUCCESS: PMU working correctly

Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 app/test/test_pmu.c | 74 +++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 49 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index a73594d73d..d1ec68e428 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -2,53 +2,18 @@
  * Copyright(C) 2025 Marvell International Ltd.
  */
 
-#include <stdbool.h>
+#include <errno.h>
 #include <stdio.h>
-#include <sys/types.h>
-#include <unistd.h>
 
 #include <rte_pmu.h>
 
 #include "test.h"
 
-#define PERF_EVENT_PARANOID_PATH "/proc/sys/kernel/perf_event_paranoid"
-
-static bool perf_allowed_quirk(void)
-{
-	int level, ret;
-	FILE *fp;
-
-	fp = fopen(PERF_EVENT_PARANOID_PATH, "r");
-	if (!fp)
-		return false;
-
-	ret = fscanf(fp, "%d", &level);
-	fclose(fp);
-	if (ret != 1)
-		return false;
-
-	/* On vanilla Linux the default perf_event_paranoid level is 2, which allows non-privileged
-	 * processes to access performance counters.
-	 *
-	 * Debian / Ubuntu and their derivatives apply patches that introduce
-	 * additional paranoia levels:
-	 *
-	 * - Debian adds level 3, which restricts access to perf_event_open() for
-	 *   monitoring other processes, but still allows unprivileged self-monitoring.
-	 *   See: https://lore.kernel.org/all/1469630746-32279-1-git-send-email-jeffv@google.com/
-	 * - Ubuntu adds level 4 (which is also the default), completely disabling perf_event_open()
-	 *   for unprivileged users—effectively disabling self-monitoring.
-	 *
-	 * That said, check below should be sufficient to enable this test on most kernels.
-	 */
-	return level < 4;
-}
-
 static int
 test_pmu_read(void)
 {
 	const char *name = NULL;
-	int tries = 10, event;
+	int ret, tries = 10, event;
 	uint64_t val = 0;
 
 #if defined(RTE_ARCH_ARM64)
@@ -62,28 +27,39 @@ test_pmu_read(void)
 		return TEST_SKIPPED;
 	}
 
-	if ((getuid() != 0) && !perf_allowed_quirk()) {
-		printf("self-monitoring disabled\n");
+	ret = rte_pmu_init();
+	if (ret == -ENODEV) {
+		printf("PMU hardware not available or kernel lacks PMU support\n");
 		return TEST_SKIPPED;
 	}
-
-	if (rte_pmu_init() < 0) {
-		printf("PMU not initialized\n");
-		return TEST_SKIPPED;
+	if (ret == -EACCES) {
+		printf("Insufficient privileges for PMU access\n");
+		printf("Try: echo 0 | sudo tee /proc/sys/kernel/perf_event_paranoid\n");
+		return TEST_FAILED;
+	}
+	if (ret < 0) {
+		printf("PMU initialization failed: %d\n", ret);
+		return TEST_FAILED;
 	}
 
 	event = rte_pmu_add_event(name);
+	if (event < 0) {
+		printf("Failed to add event '%s': %d\n", name, event);
+		rte_pmu_fini();
+		return TEST_FAILED;
+	}
+
 	while (tries--)
 		val += rte_pmu_read(event);
 
 	rte_pmu_fini();
 
-	/* rte_pmu_read() returns zero if it can't read perf counter. Thus series of zeros doesn't
-	 * necessarily mean the counter is actually zero. It might just signal a problem with setup
-	 * itself. So skip test to avoid testing failure and leave it to user to interpret this
-	 * outcome.
-	 */
-	return val ? TEST_SUCCESS : TEST_SKIPPED;
+	if (val == 0) {
+		printf("PMU counter read returned zero\n");
+		return TEST_FAILED;
+	}
+
+	return TEST_SUCCESS;
 }
 
 static struct unit_test_suite pmu_tests = {
-- 
2.25.1

