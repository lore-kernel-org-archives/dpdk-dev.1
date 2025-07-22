Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE8C83F27
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 12:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 49B6D40647;
	Tue, 22 Jul 2025 14:01:05 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 58B3B4066F
 for <dev@dpdk.org>; Tue, 22 Jul 2025 14:01:03 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LNTdr8007862;
 Tue, 22 Jul 2025 05:01:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=ggtMh5e/goffivgOs
 EqqrKZj44TJ73HFnXDhApKK5zPlCpO4odmq29T2KyN1IT3rGipSM4au3XcMP1mYc
 4kNeRSyUZx+8mLP4iVZPJIVs7sccURI222R4rUpJMwP3itvNuiTzT9dlQJH/XsWl
 IBv4zQ/6Yxf/pFd8oIrjsXN+Bv+4zL7s/68lNig84LyzhvgfbCTut3g23XsDb38M
 EUU+j+5z29QGT5QQ9cz2VEB7nmwp3ZbouJ+TIhDS7iM+3yuZlfm15M/3xFLkjLT5
 8G/vYs0EZWwvd7eodngglSxZPuvTPoWbEMBr6qERsHrBhdDCybYs9Ncp9ce/WGDm
 wjnMg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 481y91sbdt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 05:01:02 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 05:01:01 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 05:01:01 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 7BEBD3F7045;
 Tue, 22 Jul 2025 05:00:58 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v8 5/8] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Tue, 22 Jul 2025 14:00:38 +0200
Message-ID: <20250722120041.2718227-6-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722120041.2718227-1-tduszynski@marvell.com>
References: <20250627154107.3405768-1-tduszynski@marvell.com>
 <20250722120041.2718227-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OCBTYWx0ZWRfX6b6V0E9dYT97
 U8wjQbnBxyqXKbASC8+9REbMz3ZSiLjfmyBP+gzgCagD016fajVrai2OyR8cgaQ6ai0OvrcjfSN
 G9v72m8u8qyzTOd16Ke3MwTAEiRd/kFF9FM6gJzCvjkt31LS8aiMzve1F/1CihPY0ju3dPbhN3m
 LAK8hYdpvJz5V3LxOgwBuDzJaYAwfWPY5aIx2GqI65iswBYzlwN78bGzKPtZywpRWNN3ooJ4EuJ
 OFvKnm0KceLPt/SR1tY652ct3HK86wTYmEH5kgdh7TPdcjuLis7qE+KPawaXGM9ar4VD8GR7E9R
 dsm64yO1moO9xe1dAdAYeTmQ9OBps/Bm+8a/io5cQlSXlorte9D5upp36ToP1m9guX8XdDr0jqK
 PDzAOTMQlOiT3sKVhpWWfzu/10tPdNxqm+ESNbAeYg0/v2Pg17p6S3O8w1owC2SxyiCUbqpc
X-Proofpoint-ORIG-GUID: ibCkwB3Aq8W02n7PWtqvRYUrKBvtNu6S
X-Proofpoint-GUID: ibCkwB3Aq8W02n7PWtqvRYUrKBvtNu6S
X-Authority-Analysis: v=2.4 cv=RfGQC0tv c=1 sm=1 tr=0 ts=687f7d7e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
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

