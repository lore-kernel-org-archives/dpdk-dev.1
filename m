Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377FFC7115C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:48:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3779F40E13;
	Wed, 25 Jun 2025 06:47:51 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BB06440E09
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:48 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONTIBc000654;
 Tue, 24 Jun 2025 21:47:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 BZumREjB4faLj9tdL2gzX47x6SBDNuN30mUT2QKibU=; b=d0IYHxZrUHdSSBR4x
 9n4cOBMUzGxJ2fBjRL7AWA0n731w3YZR5663Y3IRWBVXIBKZWeqrFMSuQgvPvM2r
 dGyBUIVWe511H77WW1/XUi0qOWtSPnd4W7Hc0gMQSFNGhyfuoxvwNZLvvEss3PPc
 9Y99xrJvDksif2cQttvXj6fVm4gRYLe64fnKpBeNryk3Z5+4U3FIAy9ahtNbODCs
 REM/YueNafqPfppSzj83Kqu3LIOcZYH5RwBxmWIaxHw6VpS0BCy++uCr9zpKKYbT
 BW+BYjpmBo/vLL50WH3Zd73gDif8p9elntxHId0pkEydE9ojfZT+X9lBjp3lbJ09
 EqZdQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47g5qsrhs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:47 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:46 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 0DEDB3F705C;
 Tue, 24 Jun 2025 21:47:43 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 4/8] lib/pmu: do not try enabling perf counter access on
 arm64
Date: Wed, 25 Jun 2025 06:47:26 +0200
Message-ID: <20250625044730.2435526-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfX78A+P7kiNDQX
 nBILi2oCvlmtuF7SU2fNmZwKmuNy20LIVrktfgu/PYwvOQehY16ZJ/OFbG+tvceX+guV4djGPmi
 9yjC1Vo0e2WeAX4E6hwW1iNp6xCrfnZKyfADx1CIzd8YSpJm/JMz5RBtAtP/RGVenSN5FS2hp8h
 vnSBAvUqa3C4TskEm2419LmmGYrIxs/zxEyL1dLjasTE8Wpq0JML2yq52ONPZyuo/+xfYl/0f1N
 6YwudOx8vDfClMv/royPE99EuWZLXsqoPxSdPOM/HOuRQdfQjkPVJ4iWYXo/4sB1ConeF7Ukrjg
 PW4vWoThncaeTaUm3UW6tBd4+JHhlIK5ICeTtIJeSxlYNvrRb1xFn5x0voUylDI6wgvcgXiFrBd
 f1kC6VJnbWd0mwVx7rImEaLedFQVFQgUkdRXF1Uesi/UmhgbScj6fkB7VoTd3Oyqhrt+jTWG
X-Authority-Analysis: v=2.4 cv=AaqxH2XG c=1 sm=1 tr=0 ts=685b7f73 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Oq_oc4OIQJrBT0az780A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: zZWo5scDVjICMyHAUBJnZImKuaBqn7aH
X-Proofpoint-ORIG-GUID: zZWo5scDVjICMyHAUBJnZImKuaBqn7aH
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
index 0709f5e58c..3cae29891c 100644
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

