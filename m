Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BCBC7EE31
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2C3B406A2;
	Fri, 27 Jun 2025 12:58:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D742406FF
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:58:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QNUd2W019206;
 Fri, 27 Jun 2025 03:58:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 BHn5/93tocKcPlUEYB076XMKFKVYNIMEmak+sTFhSw=; b=T1nE5YE00rC7k7Nvr
 XlTftZR6O+GJnQBrHhXVZKxTY/ejDu/a9DuQZ8H1LgIxRAc/is1y8PQ9fX/bC+fD
 YdJt6qJcTdIIzcMURp8xGCVwB5PN+Wyzyvccj/JhOlKEioBO4l0XV+CUrMCtQp92
 wGUwY3gFo6qBr9CiLGQ1vEC25uqI0aoZlFCEmpDhXUAAIBJVCjp5UTbgctMN1tYS
 X26C/YiXaZCPBUeK0+mNsoB8UpPTp93/3dDr1e8XbJdJay1RCXZNiUQlLmAlMQYm
 xm8izdMK4eR0w4UXXOpvIk4HqUC56gfIkeh9eARr/Q4u2g9CEBU9d3UBJD2NH72y
 vVpKg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47hfx69635-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:58:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:58:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:58:01 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8E0125C68E3;
 Fri, 27 Jun 2025 03:57:59 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 6/8] test/pmu: enable test
Date: Fri, 27 Jun 2025 12:57:38 +0200
Message-ID: <20250627105740.3388237-7-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX9fglz62qnOTV
 YC3W971YZEQSWtu5cVn9ldyrYw5bzHfWJ5P/XDoulPk/dFhglUnhTyf+zMRTk0O6el6q9iEotNt
 wFaAzjEj/nEFepaLtARKgUqcdS8LDNvqncnU6iR0a+OcGx0+yeuNoVUonC3rD81aFSPSnbfYgzF
 Q2vCpSSOww7GK41JM57aF2nKbvzzhuXnWYLgXOydRrbTy4o/fQgJxxBm8Dt2LEDCwVVOSa7ZGzD
 ZTwSDVh1gsTQR/IGTaWT7EoP+2um3ljQlLpp761jR5l7wvgDN4bE9g1qgGxjrmvL4aaEHB/1uer
 nDMBLA65hLBJBNuhSuaOwrtCbdoSb8Xksw9iIkFeausH4kDlmPAdbUKICbKKK17IItFuzIEB05T
 qzY3Dsh2o5dSqRVUn4zOrM12qcproBola80yBv3CEXTl58AYPvpTbPAt1i/8Ql8s0lEON4Ng
X-Proofpoint-GUID: juiXFX2yC2JAQdPLF7dd1TYrFFnTpzRj
X-Proofpoint-ORIG-GUID: juiXFX2yC2JAQdPLF7dd1TYrFFnTpzRj
X-Authority-Analysis: v=2.4 cv=N+4pF39B c=1 sm=1 tr=0 ts=685e793b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
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
 app/test/test_pmu.c | 58 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..cfdde37ff1 100644
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
+	if ((getuid() != 0) && !perf_allowed_quirk()) {
+		printf("self-monitoring disabled\n");
+		return TEST_SKIPPED;
+	}
+
+	if (rte_pmu_init() < 0) {
+		printf("PMU not initialized\n");
 		return TEST_FAILED;
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

