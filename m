Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17633CD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:30:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B00A40659;
	Tue,  5 May 2026 07:30:49 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id F1312402E8
 for <dev@dpdk.org>; Tue,  5 May 2026 07:30:47 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6454CPgf296239; Mon, 4 May 2026 22:30:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 O+ILIxzi2UNzIuMBSZdCTDeS7DUyMgLXz96b5m8eaE=; b=cd2lL/elixm0S21a1
 MP4OAa29jW1QKvKqGAtV9vCXrzE/tbpMZcPktCbRVjbqS6AvinSO2/fClQG7gXT9
 7YJ0BLWABfpsWu84t23vhCjQjqb/y9aqoNqfPuwMd4by5/f/7m3GD+s03WvgVmlu
 5vkdnpdpQeY7/xRQe1kPz5QJXCja8Hql8lIGxHwtVMtJSFVy9uLOtPCxug2SfoQe
 dCZVpQw76elo8Y8elI6n4LH5Ic7CqtktsuFP2lSHrXZK3EjI4H7KU6Xb88ygeabP
 TFM05uby8T66oMOh87muwTdamkh/JICcSsm6BYVa5jZs4WvL6t2YLzvRnNDt4xhq
 2pxwA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dx218vt3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 04 May 2026 22:30:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 4 May 2026 22:30:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 4 May 2026 22:30:43 -0700
Received: from localhost.localdomain (unknown [10.28.36.154])
 by maili.marvell.com (Postfix) with ESMTP id EE3763F70B3;
 Mon,  4 May 2026 22:30:40 -0700 (PDT)
From: rkudurumalla <rkudurumalla@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>, <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <ndabilpuram@marvell.com>, <mb@smartsharesystems.com>, Rakesh Kudurumalla
 <rkudurumalla@marvell.com>
Subject: [PATCH v2 4/5] lib/pmu: fix out-of-bound access
Date: Tue, 5 May 2026 11:00:22 +0530
Message-ID: <20260505053023.3854665-4-rkudurumalla@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260505053023.3854665-1-rkudurumalla@marvell.com>
References: <20251024054830.933910-8-tduszynski@marvell.com>
 <20260505053023.3854665-1-rkudurumalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA0OCBTYWx0ZWRfX+zxsU2Bv+BZy
 zB7uPmsanFw4zHa2Uqn6wI/trJeDuImmsHKLzky0634FSxjEMl2OS+fuXOlpxkzaqWIJDM54/K9
 fv0Ly0BUD+TomolIZK7KvRT5COT0gnl10jy0GmEyoSey+ra9Vj8RnYKpdfsnHOnHhyp/vOeTvyM
 QyXbKXi8Mp4BicD8GkzotE5HwkKmPMLvbod7YC3FybHBIBYG4frJ6xkt1XMR5uM9667122EBNIJ
 Py2unbRxDVRKYDZXfLjDuHsUKMWCvAFlRJZ8WGi27WbjU8DOVCbMEtHSxU6SwV03B4p7AUHeWBy
 zh5ELTj6nc0Bf/G82+bAIx8LzhlvjczI490iL19XzL8ZPa182brOVo/D0+sSzpAzvQlIWUi3tDO
 D5nRGRh8o8y+8P2yZ+iIRzYrxEGJMCEJkGMMifB3eRpsEiWVH3reUwal3j0Na4Y0e9MNxMFALG5
 rgoZKbKhlHdUwPsz1gg==
X-Proofpoint-ORIG-GUID: isUKfpTLmwR1crmAHM3pItAwy9-4dnBp
X-Authority-Analysis: v=2.4 cv=coqrVV4i c=1 sm=1 tr=0 ts=69f98084 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=qf4gfuq51q0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=M5GUcnROAAAA:8 a=0tJRoPSv-UADiWfFSEwA:9 a=3ZKOabzyN94A:10
 a=k40Crp0UdiQA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: isUKfpTLmwR1crmAHM3pItAwy9-4dnBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
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

From: Rakesh Kudurumalla <rkudurumalla@marvell.com>

Make sure that out-of-bound access does not happen by saving one byte in
buffer for NUL terminator.

Fixes: a8926a65ad1d ("pmu: support Arm")
Fixes: 960c43184c4d ("pmu: introduce library for reading PMU events")
Cc: tduszynski@marvell.com

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
Signed-off-by: Rakesh Kudurumalla <rkudurumalla@marvell.com>
---
 lib/pmu/pmu.c       | 54 +++++++++++++++++++++++++++++++++++++++++++--
 lib/pmu/pmu_arm64.c |  3 ++-
 lib/pmu/rte_pmu.h   | 12 +++++++++-
 3 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/lib/pmu/pmu.c b/lib/pmu/pmu.c
index c14ffa5a2a..3f57d72a53 100644
--- a/lib/pmu/pmu.c
+++ b/lib/pmu/pmu.c
@@ -126,7 +126,7 @@ get_event_config(const char *name, uint64_t config[3])
 	if (fp == NULL)
 		return -errno;
 
-	ret = fread(buf, 1, sizeof(buf), fp);
+	ret = fread(buf, 1, sizeof(buf) - 1, fp);
 	if (ret == 0) {
 		fclose(fp);
 
@@ -419,6 +419,45 @@ rte_pmu_add_event(const char *name)
 	return event->index;
 }
 
+static int
+check_perf_permissions(void)
+{
+	const char *paranoid_path = "/proc/sys/kernel/perf_event_paranoid";
+	int level, ret;
+	FILE *fp;
+
+	/* Check if user is root */
+	if (getuid() == 0)
+		return 0;  /* Root has access */
+
+	fp = fopen(paranoid_path, "r");
+	if (!fp)
+		return -ENOENT;  /* File doesn't exist */
+
+	ret = fscanf(fp, "%d", &level);
+	fclose(fp);
+
+	if (ret != 1)
+		return -EINVAL;
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
+	 */
+	if (level >= 4)
+		return -EACCES;  /* Insufficient privileges */
+
+	return 0;  /* Allowed */
+}
+
 static int
 add_events(const char *pattern)
 {
@@ -492,10 +531,21 @@ rte_pmu_init(void)
 	if (rte_pmu.initialized && ++rte_pmu.initialized)
 		return 0;
 
+	/* Check permissions first */
+	ret = check_perf_permissions();
+	if (ret == -EACCES) {
+		PMU_LOG(ERR, "Insufficient privileges for PMU access (check perf_event_paranoid)");
+		return -EACCES;
+	}
+	if (ret == -ENOENT) {
+		PMU_LOG(ERR, "Cannot access perf_event_paranoid file");
+		return -ENODEV;
+	}
+
 	ret = scan_pmus();
 	if (ret) {
 		PMU_LOG(ERR, "Failed to scan for event sources");
-		goto out;
+		return -ENODEV;  /* No PMU hardware found */
 	}
 
 	ret = pmu_arch_init();
diff --git a/lib/pmu/pmu_arm64.c b/lib/pmu/pmu_arm64.c
index 2c40b5f702..f3a817b42f 100644
--- a/lib/pmu/pmu_arm64.c
+++ b/lib/pmu/pmu_arm64.c
@@ -24,12 +24,13 @@ read_attr_int(const char *path, int *val)
 	if (fd == -1)
 		return -errno;
 
-	ret = read(fd, buf, sizeof(buf));
+	ret = read(fd, buf, sizeof(buf) - 1);
 	if (ret == -1) {
 		close(fd);
 
 		return -errno;
 	}
+	buf[ret] = '\0';
 
 	*val = strtol(buf, NULL, 10);
 	close(fd);
diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 9970282c76..0c2a5d9298 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -150,10 +150,20 @@ __rte_pmu_enable_group(struct rte_pmu_event_group *group);
  *
  * Initialize PMU library.
  *
+ * This function initializes the Performance Monitoring Unit (PMU) library
+ * by checking permissions, scanning for available PMU hardware, and setting up
+ * necessary architecture-specific internals.
+ *
  * It's safe to call it multiple times.
  *
  * @return
- *   0 in case of success, negative value otherwise.
+ *   0 on success.
+ *   -ENODEV if PMU hardware is not available or kernel lacks PMU support.
+ *   -EACCES if insufficient privileges to access PMU.
+ *           User should check /proc/sys/kernel/perf_event_paranoid settings.
+ *   -ENOMEM if memory allocation failed.
+ *   -EINVAL if invalid configuration detected.
+ *   Other negative errno values on other failures.
  */
 __rte_experimental
 int
-- 
2.25.1

