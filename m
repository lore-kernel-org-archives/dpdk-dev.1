Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D35C77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 12:30:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D54740A7F;
	Tue, 24 Jun 2025 14:29:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D6F0B40664
 for <dev@dpdk.org>; Tue, 24 Jun 2025 14:29:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5BO0S031285;
 Tue, 24 Jun 2025 05:29:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 BZumREjB4faLj9tdL2gzX47x6SBDNuN30mUT2QKibU=; b=lYVu0GqMztR7xH6bf
 KC0Jkvl+Sqy4a2FdTeSXIfSFxEOK9B7Qwyb/y7A1EWlXxhemXu7gV8WbT8AsWKPv
 ISjtfhjtIfFKfPEpvwJrsIDuOlct/WxbT+wRscI//ep8DFXVh7FyotXkZOuNNHZL
 HMqUO2IOGURBWGzZUGWFRukahAeFC4ib8C8B3/W7aKGDGJlRz5OdsU+wlle79eza
 yjZbdJN3N7WaLOvh4zQOTTKU0rY5AShgYZENaS//jyqN4bmwcUbYnS7gjGtRtPzS
 xFfcwbhaNG8r+FrQrTJ1s8oMY9GJnFNBsC+TBwd8GzQfReI7HZzuRE2IKxOzzXc8
 AAnPA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fnnbru0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 05:29:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 05:29:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 05:29:46 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id BF3933F705E;
 Tue, 24 Jun 2025 05:29:43 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v4 3/7] lib/pmu: do not try enabling perf counter access on
 arm64
Date: Tue, 24 Jun 2025 14:29:26 +0200
Message-ID: <20250624122930.1783177-4-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624122930.1783177-1-tduszynski@marvell.com>
References: <20250620120551.613148-1-tduszynski@marvell.com>
 <20250624122930.1783177-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwNSBTYWx0ZWRfXy2rxDCsxYeYO
 r2eR00BwdODkwgVAaWeJboTfbsLFuK9NfX6Yv7IAPboKK6gxVL4NM3eOPYZR/OcUprpW/DX6N1i
 lSmdAr7QOkPRqfDbw3a/JPF2+PXkUVwVClL0yRCpN3HL9wi+xjKXXyXBtyEEb6f6ugf7vRyuexq
 Z8OziwmUpSL588yi188w5Gt74kmR6QPhiya1D/Oe9iuYoOw5lQtonejgTTtXc27tq73M30KerXz
 UMs7FbzJVvgI6AoRqffd91AjndyBmNnF5toCoF9Vv7adNkimZOfcXEDKhjsWSgSqfdmUNjKeiQT
 24aeTECJr2S5fL8RsxDkQXuJqGxseInuDBowsSnUh4uZFaGPngTZ5AhwjQLTy+O06AeO8ZMl18/
 G2AcsUWzDJ3sevOTFz4FmANO5psDhudVols7Fw27PYfRKJ33JFGu15MuJXTY1hsK1W/1+qve
X-Authority-Analysis: v=2.4 cv=IPECChvG c=1 sm=1 tr=0 ts=685a9a3b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Oq_oc4OIQJrBT0az780A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: XAM0fIccbXt1BLncCkNSb8OxH6vUJHN_
X-Proofpoint-ORIG-GUID: XAM0fIccbXt1BLncCkNSb8OxH6vUJHN_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
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

