Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC538C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:22:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E270740691;
	Fri,  1 Aug 2025 12:21:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 47D2D40668
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:39 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56VLr8gn018110;
 Fri, 1 Aug 2025 03:21:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=I
 I9LAkwtCZ3UOEd6164qnQSGtORVPo3b2noq/XGQVKw=; b=X+6fKyNjM1eyEd1JI
 6BUTfIAp+T7ygJuYgRLll0W+8LPYtU37Jym29gfZsGhOb7pRq41entX8asDYooCb
 OtTHSFGkptfodWQNy6jKVKsvOZ1zzK2bEdqiVh+VR6q7nNweNJvThQ5fLJIw1zDf
 fZthjF3CVDDkro5aFXeC9vzHLfqfnoH4+uvQ8XAUdRe7bHvOUft6XVS6e2w9Kiwq
 UIEHwQJKzVL2xR0+W3c4FHN1i8YCgZSlA2riI5+3CDK9WtQ/B14eIoEpGecJmX5F
 Ss05HS/9XZGYAgJdh7A5x1X5HhpV0ehzyrJLxamteC1dN/0OFYEDdDE2m8RNzDyU
 O8AVw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488gsuh88h-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:37 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8EE8E3F7079;
 Fri,  1 Aug 2025 03:21:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 06/10] lib/pmu: do not try enabling perf counter access on
 arm64
Date: Fri, 1 Aug 2025 12:21:05 +0200
Message-ID: <20250801102109.3544901-7-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: BTriYG3hMhn9qqv9UsWRaAhop8rm3t4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfX3DR+tnXB+sSE
 JdM0G+gOiiA1FTsp0RpDIrJOqFFwyIs3XlkR2kXvpfLF0fZStk5+BA7OnjQLU6q4p+sNQ/gfIth
 /RNHNvr7KVEsPQc0uV8M4ThvKwjJK14mlfw9FfVVc9Ol19W9pd1qtwdqCBw3UhzUxfs5mz1ySB7
 xlnmra0/Ss3DsMj8ywVs8dJ337JnEyHI6RXPiw8egfU0Fd/rN1UjaCi/k+PidjrRYYmaBeuJicP
 RCEvNLKrk3SjpsfabIUaMZwwMUZJEV+N9mRjnOV/rpgDyex0xfaGG+y1B8Uripsp2vNBWUT8AXv
 UqMwK4f3tcveDuq6VCaWXkTxhCiyZo+Bq+bJ3NTcoqdV3fpdxov5KT7lJ9H5y1ISsEcM3UM369F
 pWJ2EuReq3R6SF8ii07+q27n8Binzkh1UDI5g+fpPrDx3KzVOiC3wezQUQwrISXyDFgwyZ6x
X-Authority-Analysis: v=2.4 cv=EbHIQOmC c=1 sm=1 tr=0 ts=688c9530 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=Oq_oc4OIQJrBT0az780A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: BTriYG3hMhn9qqv9UsWRaAhop8rm3t4Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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

/proc/sys/kernel/perf_user_access attribute allow user process to access
perf counters. Though in order to change it binary requires elevated
capabilities or must be run as root. If that's not the case counter
access remains disabled. Hence to avoid confusion log message that
that warns user about that.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/pmu.c         |  4 ----
 lib/pmu/pmu_arm64.c   | 39 +++++++--------------------------------
 lib/pmu/pmu_private.h |  8 ++++++++
 3 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index 8cf2e89c69..97bab80368 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -25,10 +25,6 @@
 #define FIELD_PREP(m, v) (((uint64_t)(v) << (rte_ffs64(m) - 1)) & (m))
 
 RTE_LOG_REGISTER_DEFAULT(rte_pmu_logtype, INFO)
-#define RTE_LOGTYPE_PMU rte_pmu_logtype
-
-#define PMU_LOG(level, ...) \
-	RTE_LOG_LINE(level, PMU, ## __VA_ARGS__)
 
 /* A structure describing an event */
 struct rte_pmu_event {
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index 3f4f5fa297..2c40b5f702 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -14,8 +14,6 @@
 
 #define PERF_USER_ACCESS_PATH "/proc/sys/kernel/perf_user_access"
 
-static int restore_uaccess;
-
 static int
 read_attr_int(const char *path, int *val)
 {
@@ -39,49 +37,26 @@ read_attr_int(const char *path, int *val)
 	return 0;
 }
 
-static int
-write_attr_int(const char *path, int val)
-{
-	char buf[BUFSIZ];
-	int num, ret, fd;
-
-	fd = open(path, O_WRONLY);
-	if (fd == -1)
-		return -errno;
-
-	num = snprintf(buf, sizeof(buf), "%d", val);
-	ret = write(fd, buf, num);
-	if (ret == -1) {
-		close(fd);
-
-		return -errno;
-	}
-
-	close(fd);
-
-	return 0;
-}
-
 static int
 pmu_arm64_init(void)
 {
-	int ret;
+	int uaccess, ret;
 
-	ret = read_attr_int(PERF_USER_ACCESS_PATH, &restore_uaccess);
+	ret = read_attr_int(PERF_USER_ACCESS_PATH, &uaccess);
 	if (ret)
 		return ret;
 
-	/* user access already enabled */
-	if (restore_uaccess == 1)
-		return 0;
+	if (uaccess != 1)
+		PMU_LOG(WARNING, "access to perf counters disabled, "
+			"run 'echo 1 > %s' to enable",
+			PERF_USER_ACCESS_PATH);
 
-	return write_attr_int(PERF_USER_ACCESS_PATH, 1);
+	return ret;
 }
 
 static void
 pmu_arm64_fini(void)
 {
-	write_attr_int(PERF_USER_ACCESS_PATH, restore_uaccess);
 }
 
 static void
diff --git a/lib/pmu/pmu_private.h b/lib/pmu/pmu_private.h
index d74f7f4092..82118df8b3 100644
--- a/lib/pmu/pmu_private.h
+++ b/lib/pmu/pmu_private.h
@@ -5,6 +5,14 @@
 #ifndef PMU_PRIVATE_H
 #define PMU_PRIVATE_H
 
+#include <rte_log.h>
+
+extern int rte_pmu_logtype;
+#define RTE_LOGTYPE_PMU rte_pmu_logtype
+
+#define PMU_LOG(level, ...) \
+	RTE_LOG_LINE(level, PMU, ## __VA_ARGS__)
+
 /**
  * Structure describing architecture specific PMU operations.
  */
-- 
2.34.1

