Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D875C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:41:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F82E40A4B;
	Fri, 27 Jun 2025 17:41:33 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 23B9240691
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:31 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55REJkRE017269;
 Fri, 27 Jun 2025 08:41:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 lB74WJL7+wVWpaBdJtsljjKKk/CXUnZkpuxEeMOG/E=; b=KPQkv2e47H8X4ZHjl
 HukLriDVas3x1IGBaz3W9tGMjI4e8ZccdgACDce12VNnfEZrM/w9h/4R2ab1EcKt
 PrOpqBC4jbuEs1++WaYy7at+CsqifuepV6G/l3I6cCUKTgg48BBPFdMfiXp2I/9t
 tnntMXNaS2hjnlPJgNL0o2ImNxYHjCCGal1flBN67k1Py35qIRpKOMempM0At++n
 vfgVG6pblZS8L6KIsucTVSl8+6owwosssLmVgNDGXrGfhiH25Km01F+aDv8bnoH1
 OwqN7HZk/Mg6d0eae7sSwECPIPBbkeZEa4pMcIIaWS3WgzBFTcZsyxY1YaQTHGss
 HnAKw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hfxphym8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:29 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 6EA0E3F705C;
 Fri, 27 Jun 2025 08:41:27 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 6/8] test/pmu: enable test
Date: Fri, 27 Jun 2025 17:41:05 +0200
Message-ID: <20250627154107.3405768-7-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfX3dH4cA8ButvV
 YCPZ9RNCpsq0DDa54L9oq0p5bgtcWFVX8JBn2NW2KktQ1okFd6fc5qC8Zt25S2nRKJ0nkIgmlkg
 9uCMBSIDIItCarEBikioYY9gbhDqrZxrQwCY0GdPXmPz3tgdYWnWjPmcTDgr7LM1CaMpxqYwk5g
 9hoZIvbWa/XTiwEjKad32a+xbws1PShE66hp8yb6a337fCZYWD0Poj0wE/Az2J73+b3O0kKahJ6
 hZNVS6b95IdunjGjYPBJB30NQwrXDJRZqsEYPpnK5YMn3WyguI4FrUWLip/1GwLeEWHLNghE19i
 Tn1lk4/VgBdTw8l232TW9KC/z/gPVLMypemXq0zD6bJ8bTp7FH9mj1TBVNwXL0GOdXFYMVriPV3
 W2pv8XOnmTE1wXojF2UfQDROBAAXRZ2NpFAwF5undCFaVoPOWtYztrDoWriM8j9bbFY3Iagq
X-Proofpoint-GUID: bgvZYpHY4LtG1Nzgf7s_tmFJSZY1YPlU
X-Proofpoint-ORIG-GUID: bgvZYpHY4LtG1Nzgf7s_tmFJSZY1YPlU
X-Authority-Analysis: v=2.4 cv=D/BHKuRj c=1 sm=1 tr=0 ts=685ebbab cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=M5GUcnROAAAA:8 a=8HUT6ekSxiGaV7mw7QIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

Enable test to allow users to verify basic functionality. Due to varying
configuration options across distributions and kernels user should
ensure that all requirements are satisfied before starting test.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 app/test/test_pmu.c | 60 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..7f450b3566 100644
--- a/app/test/test_pmu.c
+++ b/app/test/test_pmu.c
@@ -2,10 +2,48 @@
  * Copyright(C) 2025 Marvell International Ltd.
  */
 
+#include <stdbool.h>
+#include <stdio.h>
+#include <sys/types.h>
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
@@ -24,8 +62,15 @@ test_pmu_read(void)
 		return TEST_SKIPPED;
 	}
 
-	if (rte_pmu_init() < 0)
-		return TEST_FAILED;
+	if ((getuid() != 0) && !perf_allowed_quirk()) {
+		printf("self-monitoring disabled\n");
+		return TEST_SKIPPED;
+	}
+
+	if (rte_pmu_init() < 0) {
+		printf("PMU not initialized\n");
+		return TEST_SKIPPED;
+	}
 
 	event = rte_pmu_add_event(name);
 	while (tries--)
@@ -33,7 +78,12 @@ test_pmu_read(void)
 
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
@@ -52,6 +102,4 @@ test_pmu(void)
 	return unit_test_suite_runner(&pmu_tests);
 }
 
-/* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
- */
+REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
-- 
2.34.1

