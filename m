Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D4DC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C649242F07;
	Fri, 20 Jun 2025 14:06:16 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 611C542EFE
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:15 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3TjcQ015666;
 Fri, 20 Jun 2025 05:06:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
 043FfoYGVvYAk9rso4bQThRiBqVxyoPfPVOtwl14GY=; b=XCyO2K6AKdtX2OMIs
 U08i5bajSlvhHD1pEcD/LUhQJyIEwDY+Biyg2ubu9JXvLMdptafzUT68bDoI0IXb
 5b8TBXMJrtoQwkOGU0rNJHa08ad9lYWfYFYYllOOrZ6PbfIiIQchXe2T54DrOWB5
 mxIudbv8TVh2J6qrDmEDPsbboXj+8zbeX1FgP6PEv8hsZNg3d85oboFTYbQljjOY
 Xl1kZi9za8hx4sYqhYdwMCBCEuDoXHg407Ll88GgBhbm19gDHBh1bRK502ORClK6
 0VDJbzvryf4reC31WR7qAgefbXS+7TSKpsRtxYCevRy+elnBpG0en6cPJylaGkD2
 7ArOQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgva1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:06:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:06:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:06:13 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 4D7515B692E;
 Fri, 20 Jun 2025 05:06:10 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 5/7] test/pmu: enable fast test
Date: Fri, 20 Jun 2025 14:05:49 +0200
Message-ID: <20250620120551.613148-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
 <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=68554eb6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8
 a=M5GUcnROAAAA:8 a=Smj5QJchIq_J3ojvSm4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfX3kxpAVzqx9iu
 NEmAgD1MXwk4sDnmBa34HjR1q/hWYjmU/MOO3VjjeH8hDZNLFkl8BlAC5zzD3mgWeBcGPZq2FmM
 dwuQZ/K0fXPgHpilbz1DsS1Hy6+i6rxVyCSRUMWF3d23GXUR3ej0jVa2znc+si2jLMR4rmfC3CB
 u/SHOIp+I+HUu2JnVbN6ybLrEDPfI2g4CyNkDj2ODraNMzpfzaIf9SJprN1q92Xope/napR5Sdo
 46EfnXG44ask/QX6MJFmCxdBwq4P66ELwZuknvWmrL0ql1KyZCo3HUZ/fkfyXmkMIp9VsFCMb2w
 +PuZWsdiWOHtQZOPvgzE7An/GXkJMLxsSZHXh2hOkAiUDLFtkvZvC7pCUgKULYEI9oKwSYMsnuL
 mXuaxx5xLKBwUOIJALf/wM9Dh16J1EH7HvzpNhW6JvFwb1L5mpIyuKF2lS69icWrJiUiDOvA
X-Proofpoint-ORIG-GUID: jA58TT1bOaRphu97YST_Un9Tj3sboYu1
X-Proofpoint-GUID: jA58TT1bOaRphu97YST_Un9Tj3sboYu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-18_03,2025-03-28_01
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
 app/test/test_pmu.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/app/test/test_pmu.c b/app/test/test_pmu.c
index 10513bf9c9..dd23046f59 100644
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
 
@@ -52,6 +92,4 @@ test_pmu(void)
 	return unit_test_suite_runner(&pmu_tests);
 }
 
-/* disabled because of reported failures, waiting for a fix
- * REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
- */
+REGISTER_FAST_TEST(pmu_autotest, true, true, test_pmu);
-- 
2.34.1

