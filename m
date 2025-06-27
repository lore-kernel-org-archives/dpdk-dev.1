Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA441C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 10:58:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4AE264068A;
	Fri, 27 Jun 2025 12:58:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 53CAA4068A
 for <dev@dpdk.org>; Fri, 27 Jun 2025 12:58:01 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R9xnBx018602;
 Fri, 27 Jun 2025 03:58:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=NDm/0YgcJQ0Cyfm8F
 BkHqC1/nEdZL9uxs2u0JR3cji+xRe1ysVWhT9jecENiS+ngDtyU8MKnOHk5VAxsd
 DuB5uWGsZ4s9QrRKwLjKjXzS1tEG/u5kEQhVTGuWr5+ppZzfAjObFJeKFGjC2Abs
 vk8rRCSQGIwA1sPjBzlMS895i5+YBlSjb5dq3kYu/Q8Ubr6ZVeEx+rU0sNBDW83K
 drOyELViOoRZEaw4h2TTwupZd8A4fE4Ui88fWMCwfsvw1YBkJtVnuohQDHC+etyT
 AUDtJqSM1vVpG86l+zORuEiqQMqCWABYJ9NhYxKf4xOP/iGVb5Mr8AZvdM93Y2lE
 fwOqg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47hs5c83nu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 03:58:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 03:57:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 03:57:59 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id B256F5C68E3;
 Fri, 27 Jun 2025 03:57:56 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v6 5/8] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Fri, 27 Jun 2025 12:57:37 +0200
Message-ID: <20250627105740.3388237-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627105740.3388237-1-tduszynski@marvell.com>
References: <20250625044730.2435526-1-tduszynski@marvell.com>
 <20250627105740.3388237-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8XodNyJ-xNNRJcViQfpjrbWTrT2o0J4z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDA4OSBTYWx0ZWRfX08+CJ+c+ULpu
 owbignbBittyL7h1SngtQWsHi+WdA52dRl//FWXddOXmtAKXRxnqLeFEwWcDg7rqH5eEOWNmnrq
 SLlV9e1E47sKp2eUIG2h7c34XFNQy6Q6R+NwV36Io1Me4zBd1N+mBaqt9pVo4XwvUpg7qh5j1Mv
 5Hh27Mv0BxCkI+VoCqExGThDnmte7ArdnbqSQEdygXuq+gzm+CfymOZ1qp6t9nagYQb8gPqn9XJ
 qfKuXYQqfmpXyqMMSQYLZjuYKqumtZkAVt+TB0aqcEkCZRgsicNQx4r8YY3XR0EB7LKHpmnBlLR
 yoXFSQevnXnPC3iYRZ3qZaUXsVTPcpvmVT+Yf7kZRO1kpMenOZuy0pvzkzkmxocakqKIEwsbEoE
 wqulHjuodF72fGpgEIQfN0w2pqV+OkBXgfZk3Xl23wRsFl0VxKjwHGqbR0+WuJRPPwunRJ5T
X-Proofpoint-GUID: 8XodNyJ-xNNRJcViQfpjrbWTrT2o0J4z
X-Authority-Analysis: v=2.4 cv=BNOzrEQG c=1 sm=1 tr=0 ts=685e7938 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

RTE_LIB_PMU is defined by build system automatically if DPDK is build
for Linux. Otherwise it's missing.

That said all cases where conditional compilation is required
can be handled without introducing other macros.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index 84a5d522d1..e997f62334 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -33,13 +33,10 @@
 #include <rte_compat.h>
 #include <rte_lcore.h>
 
-#define RTE_PMU_SUPPORTED
 #if defined(RTE_ARCH_ARM64)
 #include "rte_pmu_pmc_arm64.h"
 #elif defined(RTE_ARCH_X86_64)
 #include "rte_pmu_pmc_x86_64.h"
-#else
-#undef RTE_PMU_SUPPORTED
 #endif
 
 #ifdef __cplusplus
-- 
2.34.1

