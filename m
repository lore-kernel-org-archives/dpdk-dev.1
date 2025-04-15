Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C32C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44B9D4066D;
	Tue, 15 Apr 2025 14:11:22 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 89AF64066D
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:20 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9ngIX021049;
 Tue, 15 Apr 2025 05:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
 6BiDaaZgXoKkCnx1j8rFE+k5TarM/avmNwAL/f65EE=; b=GN6XBzi+WqWFOCK9G
 NX8JrTMiNQazuvRsZLKuaxz/yRNIT8o3lgfEP2siFIfqDsQWRszRnGuK3THL10Pu
 cAsksK8NXucUfOTA7/1RGV5gB9PIHN6xwLKwAmF1ZMKwDvqUjA4BzDL4ygijZEmy
 pMWtv5V5BpNGmuS9wTD6M5fYWx+wpssiUupWRCMLY9gnrlZM4hBHkLzhD9tI/L/Z
 vI/+MX3FFITylb37nWW2TY9Qzz4Sly3cMxaxOHZiAFlF1ffsvJSIxa+MBoo9bz0p
 S2hBROAiYHVGX1nTFbNztnkD8Qa+0tp7QgcHiGNbdOJuUacgsewnUNIphjikCmyO
 eX0JA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjee80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:18 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id AF3FC6739A;
 Tue, 15 Apr 2025 05:11:15 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 01/12] fib: move macro to header file
Date: Tue, 15 Apr 2025 17:40:41 +0530
Message-ID: <20250415121052.1497155-2-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QGxOZ8Dc9T8JDAZPGSa5Gzk81X_w97P8
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67fe4ce7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=vxp6wFEekYbuhhetsVcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: QGxOZ8Dc9T8JDAZPGSa5Gzk81X_w97P8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
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

Moves RTE_FIB_NAMESIZE to header file, in order to use it outside the fib
library.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/fib/rte_fib.c | 3 ---
 lib/fib/rte_fib.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 2c05d46500..184210f380 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -28,9 +28,6 @@ static struct rte_tailq_elem rte_fib_tailq = {
 };
 EAL_REGISTER_TAILQ(rte_fib_tailq)
 
-/* Maximum length of a FIB name. */
-#define RTE_FIB_NAMESIZE	64
-
 #if defined(RTE_LIBRTE_FIB_DEBUG)
 #define FIB_RETURN_IF_TRUE(cond, retval) do {		\
 	if (cond)					\
diff --git a/lib/fib/rte_fib.h b/lib/fib/rte_fib.h
index 53f04b8049..874bf1688b 100644
--- a/lib/fib/rte_fib.h
+++ b/lib/fib/rte_fib.h
@@ -27,6 +27,9 @@ extern "C" {
 struct rte_fib;
 struct rte_rib;
 
+/* Maximum length of a FIB name. */
+#define RTE_FIB_NAMESIZE	64
+
 /** Maximum depth value possible for IPv4 FIB. */
 #define RTE_FIB_MAXDEPTH	32
 
-- 
2.25.1

