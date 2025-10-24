Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB15CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:48:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 963B5402AF;
	Fri, 24 Oct 2025 07:48:46 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0E7AD402AC
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:48:44 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3rL4M005087;
 Thu, 23 Oct 2025 22:48:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
 Babk8fNuAZMuGhm3phyhr8A2mISUxwNbOp72Gm1nKE=; b=XNm99w9e24iDuHu8S
 v2nfkb1h/s7RuzsP7YVwQoP6nX78twnABSytt0zEvWoW3QH/L2A2m6F2GheJidRl
 RYw/QxFLZlAnrhzhHo0MxdkZGdeR2zsfgUzPm0EDpphOtA9M06qwgUJgPRYcI3B2
 gRK4YJ961Tm178gyhGiW57LJv8Os+DIgit7GEDTsbA+jF2f5kWLI5oaELO5ccrCV
 zfzk3u3myqgiXD7/JJVPm1RNB1TV8/lDarNjO2gpOahSTQDmSqyG9L8urvN9mOj8
 xONDPDw3PxnudX0IO+qHpvV8CoJT8cL2aqS6FZiixTByzbu4gkBBrC/+ihU4KbMW
 gPTyQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4a01xn84st-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:48:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:48:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:48:39 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 90CB53F7071;
 Thu, 23 Oct 2025 22:48:37 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>
Subject: [PATCH v11 1/9] pmu: quiesce chkincs warnings
Date: Fri, 24 Oct 2025 07:48:22 +0200
Message-ID: <20251024054830.933910-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cn5tqIko7Xo6CEYbKMtMx4G6MAxYnoT4
X-Proofpoint-GUID: cn5tqIko7Xo6CEYbKMtMx4G6MAxYnoT4
X-Authority-Analysis: v=2.4 cv=JfmxbEKV c=1 sm=1 tr=0 ts=68fb133a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=S849gBgu0BXtzdSz8A8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDAzMSBTYWx0ZWRfX8UawjQW5eLty
 AKK/dnfZlza6a4PUT3iv7PdCbzzgUCuhqeBWs9o/M+rliosQ55fnGLuq1QOParKPmfr+rKdODdG
 XRSbdLlXljEcRhuOrck6zZcHwt+IIBH0jWJC27585fRXyzr1cG2E+PlBaoVwtl8guxqc8DL6lme
 BsYKGOOEvqofKdb9Qw32c2jwycUmpInIxFHM8jPpEtzZ/o0UA8mzNBD1FxWnBSEfWLbQSpw5vQb
 GuE71l3UNrRwiToKdtxQkv3W6lkKQ7Yxea/G8lXHjwg+VTKO0Tvz7qnwqmzb8ZiYiEChLPrabCn
 qDQrsplylEQxDkO9rD4kljUvh5PZCg4eJcAO5PTiyFEWEYupAt6dGNkNoJSNttRI3OOlk6pNRO2
 hDfDEGJ/OWt+mLKgNuV404SQQapMwg==
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

chkincs tool produces warnings if internal functions are called
directly.

There are multiple ways to quiesce these warnings but common pattern now
is excluding experimental code from build and triggering abort in
runtime.

Follow that pattern here.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 57b634ecd8..fcf125a908 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -31,6 +31,7 @@
 #include <rte_branch_prediction.h>
 #include <rte_common.h>
 #include <rte_compat.h>
+#include <rte_debug.h>
 #include <rte_lcore.h>
 
 #define RTE_PMU_SUPPORTED
@@ -181,12 +182,6 @@ __rte_experimental
 int
 rte_pmu_add_event(const char *name);
 
-/* quiesce warnings produced by chkincs caused by calling internal functions directly */
-#ifndef ALLOW_EXPERIMENTAL_API
-#define __rte_pmu_enable_group(group) ({ RTE_SET_USED(group); 0; })
-#define __rte_pmu_read_userpage(pc) ({ RTE_SET_USED(pc); 0; })
-#endif
-
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change without prior notice.
@@ -211,6 +206,7 @@ __rte_experimental
 static __rte_always_inline uint64_t
 rte_pmu_read(unsigned int index)
 {
+#ifdef ALLOW_EXPERIMENTAL_API
 	unsigned int lcore_id = rte_lcore_id();
 	struct rte_pmu_event_group *group;
 
@@ -231,6 +227,10 @@ rte_pmu_read(unsigned int index)
 	}
 
 	return __rte_pmu_read_userpage(group->mmap_pages[index]);
+#else
+	RTE_SET_USED(index);
+	RTE_VERIFY(false);
+#endif
 }
 
 #ifdef __cplusplus
-- 
2.34.1

