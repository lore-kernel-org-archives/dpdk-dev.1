Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F168FCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:49:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A187640613;
	Fri, 24 Oct 2025 07:49:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B174040648
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:49:03 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3D5DG027374;
 Thu, 23 Oct 2025 22:49:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 kyEZwZ+A8KNcbnEbh5JbLOUWkOgZIOwPgUdm/ie7w0=; b=cTs4sK+Q/R+pjRUhC
 HxeUoc6lwZVV0KUQgvNNWokt+N1MWMVFCViUbfY6flu2BeJ4AcQPHTDDjHvgIPTF
 KW99fqqwTRKnF3FkumCZvsm3pIDmEMP0F6pabu88dAUTB/GuxDh1ZNje81CCAul+
 xGFf18LxjjZpDGF/IOxO+A6Bb+dwI8R7BrD2agt4j9FRoV4gmRxqxLJj3vXPAQj/
 IbK24ZtHzIIF7ypPLAQEAOz+sVsKXd5XBYQkgM5Ly5OgcSNdNzmjgVmcuYedwsh+
 JnPSP6sa1qI4Gj+D9v9twUZbESKLV+r1TfP0NaksoWuBtxp2Vp9a5XzPeS9WTigh
 gTTjQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49yx9prh86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:49:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:48:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:48:58 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id DE0653F7071;
 Thu, 23 Oct 2025 22:48:55 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>, <zhoumin@loongson.cn>
Subject: [PATCH v11 5/9] lib/pmu: do not try enabling perf counter access on
 arm64
Date: Fri, 24 Oct 2025 07:48:26 +0200
Message-ID: <20251024054830.933910-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R3oQuna342RQb6Ydg1N3MHjjIi7dg2XS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNyBTYWx0ZWRfXzsUCH87JQWC8
 /TpjvI0HXBPkhdeLB8IYHGzEmSQRdTMZokXv21SevkeKXk1eodC8P+DZdbvYCIEVFnnoSchia1S
 WJ2CQ6sHCJwouQNMo0c2lppTeVcowTbWLvH3uDm+2+6KmX5+WrE9Jra80Lk7EviX/GxcxAhI8R2
 tiKmyVQFtfWoSO6AxjjCqqbCmBA+q0ejjAkkSesZnzxB9QOfWe2wl7sI/EkXYjc7k6D8ktyt6i/
 ydkVceuj6jYpBBM4eqs3F0Q3BbuwUQYtHKgVRmjqWez7MomTmwcTpLzEhOA4/xhAsAYD9FrJGn5
 ljOHqDGdeZONTkMPT6//QQewzvkILjVsfKkwy7nnaPTLGNnXHxAGykw0D/AQQJSQJcqz/e+1TWx
 iiAGzwXsgRKT2KRF2tsoKgtZJSfr0w==
X-Proofpoint-GUID: R3oQuna342RQb6Ydg1N3MHjjIi7dg2XS
X-Authority-Analysis: v=2.4 cv=Wvom8Nfv c=1 sm=1 tr=0 ts=68fb134c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=Oq_oc4OIQJrBT0az780A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
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

