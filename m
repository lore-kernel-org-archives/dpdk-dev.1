Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7439C71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:56:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BC20427CC;
	Wed, 18 Jun 2025 08:56:38 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 854E4427D0
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:56:36 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNSaAN016705;
 Tue, 17 Jun 2025 23:56:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=SRTm0AepAi6yHLXuO
 yJRTYDWQ2nq9MgRUfZfU8OQb7r6vkbWyKP2tmeRZRbQUsyeeENl1gSZ8w7JSko2m
 X4B/6OlXgbDM3D7UKQ3weagGA+oxfjB6mbYYb7SDc8kfvxP3H9laLZewu2qpYD0K
 zsevAtETzZjv/csPe3oHjRP23TJB5Ru4oWP0C/qxz4d+e0YLkvmGbemDE1ob63Ty
 7X/6PlG11kkGzVbVi0EhB5WURnGN5bjrKfTjURSH34j3rwJ9Xk7DFBqhBYsDW3T1
 qV7JzcCatGfVY0s5hOar5nQWzPpiaAspw61B6RD1ctpZHo8dG8CT1hciJRZmDJFQ
 zMjJQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47bj2kgqpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 23:56:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:56:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:56:34 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 769F33F7043;
 Tue, 17 Jun 2025 23:56:32 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 4/6] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Wed, 18 Jun 2025 08:56:16 +0200
Message-ID: <20250618065618.4045910-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618065618.4045910-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Q9jS452a c=1 sm=1 tr=0 ts=68526323 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfXyEK9KvtCbHYS
 auhbmcllXOh09WJPcUaUX9LC5fW+tCz+fDbfd/yoMvN8HlEecN+1zpqD/TnH6MDkAlLEjRoxCk9
 okbXDlVS2C07o2H+ys2WO+9eXnPNUxu6R2quaFRU6WTd3dNrMnWsMSVdbDgULlfnirft1UdsY/s
 lLsKy+AyDWaYnwr3sI74RePR7hVvaTrLGva3Z0WgUbc2NC3MEQxs0Tkwt9ObfT24KwWOMOXRmoi
 X5kZbGP2IhAIZvFgtiuIGN3HztKMOk3I5oDLr2wahwreaaYGlLnr2KQAcOTCNNCw8kC4ZtI3IIU
 zUbSORb8wU06fLM76v0TwlK4waL6GokIMVteAOptJzkCfwEzh55qBJ3peryvql1vNZ+KyDcV813
 03S7SghhD/7iDz+pUSu5BEjfKksOhfGx/MkMTFuoq9R9litfnA4M5+PzotGNs6+yhc3vqf9V
X-Proofpoint-GUID: qfVo0hI7nC2WtikXFNT5x8ATqtmq-Zav
X-Proofpoint-ORIG-GUID: qfVo0hI7nC2WtikXFNT5x8ATqtmq-Zav
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
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

