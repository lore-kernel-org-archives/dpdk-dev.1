Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F67DC83F25
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE48D40689;
	Wed, 23 Jul 2025 06:41:41 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9477140697
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:40 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNT7iZ024004;
 Tue, 22 Jul 2025 21:41:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 kyEZwZ+A8KNcbnEbh5JbLOUWkOgZIOwPgUdm/ie7w0=; b=iAk4dJx08Cgmlo7m2
 Icnh+y6tmjpGx0MlgHUShmB+88Y1RZJhImN0OXfAeju5GICJGUTt89cwztcOeTse
 fqNAHEwDCIjJ47KI2d3GjJbbuFaZrYHAjKFUUGCc6r/cZaAnaVIykXhtCxtg0JY9
 Es2OOu9FgZQMSHLqxiZPD4nzL1Mne+lpItHxunqQrb6MI36qQ2t1TKZoJO/xfqex
 NqTeAxjvR0OZQFDPtnrq7uDMlsqHPAHVMTp4QVhlreQRyFC1DoUMYawjbvsbir5D
 kXf+d9XKFLrDfJ6sDolrT4+pUsDxPsnRnrO/hemsUkJ+ZLIg4fvOH4nrBH2KWm3K
 yJt2w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482mbpghwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:39 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:39 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id E01623F707E;
 Tue, 22 Jul 2025 21:41:35 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 4/8] lib/pmu: do not try enabling perf counter access on
 arm64
Date: Wed, 23 Jul 2025 06:41:14 +0200
Message-ID: <20250723044118.2962318-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RfCxWKKuGq5JSSNRx1MBtc9gkkWA5M_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfX8rG1CIsv0waw
 ZkjHyWkVk6LOwPE6M4dd3O0eEcSidMYBLGx9aT1kC3TNEUyLdePoumNVQOXEX6eTuOpKgvxGr1H
 VfdFQEwqgM9xCKJwhaMhPek+aoz4IC1aT7szUCQ+AoJcHJWVwk8vKWw2+WwNxGOldKBvA4lVTc8
 QqYRh66tx3qex9B3Xz8YChoU6Gxo9CL4OjHFrNuF0rPSnFWvvUwKwe5qQuQh7r23DMO7wQID5Sr
 yot8Z9m3V3Kixc29oRSHxkXOTgs0P+9H2IabkVZdwhC0P1g6iIqdOAEj3utpjiWCXMME8sy0P7u
 +3A7duEC0iWUYGruG8UKJ1GEsJHjS9NguV/+qfWk89UBmBQ8urJGlrvIAw4hj7E/AjOBu7OdWUX
 xA4Vnjg8hdON4blazjzW77apfBva6NNwBaa3rxLUUwBTb2fIephiKJZnWtcvtk/ju0FWCRrX
X-Authority-Analysis: v=2.4 cv=dYKA3WXe c=1 sm=1 tr=0 ts=68806803 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=Oq_oc4OIQJrBT0az780A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: RfCxWKKuGq5JSSNRx1MBtc9gkkWA5M_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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
index d8212ca898..e4d4f146d1 100644
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

