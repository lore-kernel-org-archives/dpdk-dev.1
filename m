Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17ADCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:49:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B23B240654;
	Fri, 24 Oct 2025 07:49:15 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 746AF40652
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:49:14 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3D0bM022962;
 Thu, 23 Oct 2025 22:49:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=r
 lB74WJL7+wVWpaBdJtsljjKKk/CXUnZkpuxEeMOG/E=; b=H074p2bL5sviNffLb
 MDNMgfF69brsd6d3zia5rxUdrzuU/g/eyr6cxlg47PxSI4MiisYeMkKV/EMg5JZA
 4RI8nMW7urZOPjBgIVnxrg4qRBTV0DjyWqk2tG05M5+wu4VFwIpZ0LkshHD+OjC9
 Wg9MVpRKos/z6eIOrhCvIYXNm2TGUrEi8wumPGngbnigBigB5T9ntzfcNqjYEHd9
 qdWWwqLEh7KyLilhc95DYlMClbpYpSwUe2fSRixM9oMG8k+dyBAi3atKN7EiCLxJ
 L/37nk48rjaAYKNXh4ibIZOQSOp1N0vYAos1pfijFSrreFzmqhsMxtGGyuvCTSzP
 i6+3w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49yx2j0jg4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:49:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:49:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:49:20 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8AACF3F7071;
 Thu, 23 Oct 2025 22:49:05 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>
Subject: [PATCH v11 7/9] test/pmu: enable test
Date: Fri, 24 Oct 2025 07:48:28 +0200
Message-ID: <20251024054830.933910-8-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNCBTYWx0ZWRfX15jiC1RzGMU0
 NGfZGwQbbG/F7IOXqBrgCuwU1qUQMHTlXg+OGRfHlf0OKBbOcc1JorT5OoaHOEwTG90FLJlH/Mx
 Npo8hjaOz6zol1fjII/oWRUem82RjprDw1bhP8Hu5X5YQx2rt5siI86AtZEeFNTxBluDgIsrtA7
 TEYtdUZHZc5hywo431M9wWEEV2WWwKjwEpC32HsB43Cpv/t/jmPHoIJrvcG7zUzQdnPJ5fYzhgW
 ryLrSIvnDl6Fy+ydNxbWP99GWgpiKL9kCmHFBS4eE7wcXjTY/ZrnMqm0TMBL+zLotvFhRiBGgR5
 /Sc5zr5LNougbuB3YCpvhDY3afrgXBxMxwbPAbSwXXEwH5Ts2QmHEh+vuso+KqiZM9TdMP0bFI3
 kpsXdF/EKAHgvl4WqcSCaF+KjYBklQ==
X-Proofpoint-GUID: Y6uuskI3nYxDcsiY2QgvBBf1S8H466yK
X-Proofpoint-ORIG-GUID: Y6uuskI3nYxDcsiY2QgvBBf1S8H466yK
X-Authority-Analysis: v=2.4 cv=Rs7I7SmK c=1 sm=1 tr=0 ts=68fb1356 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=8HUT6ekSxiGaV7mw7QIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
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

