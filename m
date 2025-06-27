Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A719C77B7F
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:41:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78184406B7;
	Fri, 27 Jun 2025 17:41:30 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8410B40A70
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:29 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RDqVix019858;
 Fri, 27 Jun 2025 08:41:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=AzQ28MfvLabZdBzuY
 K2HU5n+E9GRXAN6tV1pZ/in9gQXPcO+8DJQD85RD2vXKrvcxnNU3fHhIlkSwsAHX
 WoFp5E8wk220oucNVbradm7WKlKUEk9Ma8n0CBu3IHXMzB1Q6gS7qtDFh7S+uhJt
 MNp2SiviZTNbXxJ0Y340zMCrp7osYM4foBlryZOsBxl433fEAKoBP3yy6smLddqb
 mm7YOK5V2EiF1ITeOvhP3UMKQxkI+RPVtejlnpGgFS8s4fjIfzaB+wAoSHdkTZ70
 EkkZwW1olcIoyzO22tqqJc61Y1rEmpAR+ucuLWlaW/Gn1d3Sx35Oh6P+OczYWq9e
 /fxWg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47hfx69xyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:26 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id A3C353F705C;
 Fri, 27 Jun 2025 08:41:24 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 5/8] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Fri, 27 Jun 2025 17:41:04 +0200
Message-ID: <20250627154107.3405768-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfX0Xs0xOrE+lvk
 Qcf8XKQLmvhko6IgZTmRxy/SABFGU3u1/DL0YAsvKShQHQzW0Y9u4VinZmvcOq4hJKPfp4PeUU2
 AZW1QeyJXS8xj5zVbS2OrnNe53gyRgAQt+i8Ug7kiUXmXOLMS7JABXjZ9Vum0+8KG+PTjKP1+sy
 81Bgbg8UWDInnBBprwzsxFfy3FBkZ27e9P9eTfKWLQSWLHYgcIqq8DAHDDN7/uSTuLHlf1R8C8m
 BdwRl/prW9rbpyfYGmaLk1tpPmh8X8y2A7uTqB21953NsLnBBZnmWfAJ7z+3SMYlLzOl2hmuspi
 EQDjiudqX+/8uNlT6RLf5chQDEjEzib7KIEMJ40AIKKWoI+GawKOVY0vfchKS9f65bnDMRTb7fc
 pZilK2YeRlr74UcxLmIZ+yee5LW6cNMaadsn6+8pFL5GUn3jg2oevN2kndeWz+mO/tp7IqqA
X-Proofpoint-GUID: fd2HAnz4HdNMKQHW0a6PdaKy8gtGwUQW
X-Proofpoint-ORIG-GUID: fd2HAnz4HdNMKQHW0a6PdaKy8gtGwUQW
X-Authority-Analysis: v=2.4 cv=N+4pF39B c=1 sm=1 tr=0 ts=685ebba8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
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

