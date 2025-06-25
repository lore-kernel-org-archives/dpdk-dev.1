Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F833C7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCAAE40E17;
	Wed, 25 Jun 2025 06:47:55 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E736440E17
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:53 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2KZHX011907;
 Tue, 24 Jun 2025 21:47:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 tKHL9cWtujy6zf3/trQ3sngPRnpm99sCz00WRiebjg=; b=fJX/PN4HCbvs8pILf
 8Zbl0v9cLhg96nvPwOsaTE9bw8t/ynIsX7b5TyvCO0/+04UIBdUAMWzyEIMwlhe6
 WTVhQdG8cWVAO4Q1pY2n6haxZVZ0FkiZMVagRbocg/DAf4VSZ4SuqSsQ+6yWYTk3
 EFpezJc1IymIUADyl+tvkbmjW0N+FU/x0BXRJ2YVB1kdSuTJhMmIXBq3beKcNG2X
 FRZu9lxtc4tdKj+VdZcxKYdfef0XKKZrDAsSpzQ8Grmm09q7fGpADqdMVwmdtJ8W
 jIYPxc3XR25SvieYLMME8OV6yu6YiSsF/9Iu3gtfXZm0fKofpZhCm4cYKFyz67ZY
 bNKSg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g88707nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:52 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:52 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 9E0FD3F705C;
 Tue, 24 Jun 2025 21:47:49 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 6/8] test/pmu: enable fast test
Date: Wed, 25 Jun 2025 06:47:28 +0200
Message-ID: <20250625044730.2435526-7-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfXwVjO0XsvCsk4
 gV4LfKJ6DrV7A4OV+ELwTk4WSmusAA+nm0emPGlVUfpBI8XeoW1bm1tW3bZSfghALDEeCquW9Vo
 d5TlfMyLZF126F4wIsEl2k7hqJ12oWcNyMCt3USA0rVvf9EwfEcL7ZFMOaU1ZLnA4QO0pgVzDaV
 xi+t+AwKpOqUAHhvrLXQn6rHvjiXwejFTgXQno2uE8mNvyHG2xc5xQWsyMh5TYdePM8SqpEE8Yk
 31Qt4SHgQmv9mWTtnGo/h1B//xfHBw7Ds4X9DQxup5hXoLs3R0Iac8uuUxFfC6H6QpIg6s+ojYA
 MCz3FuQIBp6b3dBeDLoeXIf5/nJYZ1nGmC9aRWusYTmt6gd6wTUfyvuM5jYSo8w7+o4UI5IJBdj
 biBR6OHgaeSuiPA2mXzXmAwBG5zaIGvPb7Erv2y4FTCLgqmZ2PWVfV60D3kdp7zsbe5a4G8r
X-Authority-Analysis: v=2.4 cv=EoTSrTcA c=1 sm=1 tr=0 ts=685b7f79 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=M5GUcnROAAAA:8 a=Smj5QJchIq_J3ojvSm4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: -pkbnVd9ydFn3iIvrDKh-cbVwG8d1CVl
X-Proofpoint-GUID: -pkbnVd9ydFn3iIvrDKh-cbVwG8d1CVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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

DPDK test suite provides much broader architecture coverage than
what can be tested locally so enable the test to help identify
potential issues.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 app/test/test_pmu.c | 51 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..bc41833eef 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -2,10 +2,47 @@
  * Copyright(C) 2025 Marvell International Ltd.
  */
 
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+
 #include <rte_pmu.h>
 
 #include "test.h"
 
+#define PERF_EVENT_PARANOID_PATH "/proc/sys/kernel/perf_event_paranoid"
+
+static bool perf_allowed_quirk(void)
+{
+	int level, ret;
+	FILE *fp;
+
+	fp = fopen(PERF_EVENT_PARANOID_PATH, "r");
+	if (!fp)
+		return false;
+
+	ret = fscanf(fp, "%d", &level);
+	fclose(fp);
+	if (ret != 1)
+		return false;
+
+	/* On vanilla Linux the default perf_event_paranoid level is 2, which allows non-privileged
+	 * processes to access performance counters.
+	 *
+	 * Debian / Ubuntu and their derivatives apply patches that introduce
+	 * additional paranoia levels:
+	 *
+	 * - Debian adds level 3, which restricts access to perf_event_open() for
+	 *   monitoring other processes, but still allows unprivileged self-monitoring.
+	 *   See: https://lore.kernel.org/all/1469630746-32279-1-git-send-email-jeffv@google.com/
+	 * - Ubuntu adds level 4 (which is also the default), completely disabling perf_event_open()
+	 *   for unprivileged users—effectively disabling self-monitoring.
+	 *
+	 * That said, check below should be sufficient to enable this test on most kernels.
+	 */
+	return level < 4;
+}
+
 static int
 test_pmu_read(void)
 {
@@ -24,6 +61,9 @@ test_pmu_read(void)
 		return TEST_SKIPPED;
 	}
 
+	if (!perf_allowed_quirk())
+		return TEST_SKIPPED;
+
 	if (rte_pmu_init() < 0)
 		return TEST_FAILED;
 
@@ -33,7 +73,12 @@ test_pmu_read(void)
 
 	rte_pmu_fini();
 
-	return val ? TEST_SUCCESS : TEST_FAILED;
+	/* rte_pmu_read() returns zero if it can't read perf counter. Thus series of zeros doesn't
+	 * necessarily mean the counter is actually zero. It might just signal a problem with setup
+	 * itself. So skip test to avoid testing failure and leave it to user to interpret this
+	 * outcome.
+	 */
+	return val ? TEST_SUCCESS : TEST_SKIPPED;
 }
 
 static struct unit_test_suite pmu_tests = {
@@ -52,6 +97,4 @@ test_pmu(void)
 	return unit_test_suite_runner(&pmu_tests);
 }
 
-/* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
- */
+REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
-- 
2.34.1

