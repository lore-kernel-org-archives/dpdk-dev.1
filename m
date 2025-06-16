Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF26C71136
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 06:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2183140DD8;
	Mon, 16 Jun 2025 08:54:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id D034540B9F
 for <dev@dpdk.org>; Mon, 16 Jun 2025 08:54:07 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G1Sc4Y015914;
 Sun, 15 Jun 2025 23:54:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=N8KmHFixF1tGyldyp
 eV4qnqx0xEQ7oD+iSJYhxO0KhDPIxS0iHI0CMaPMB4cEeYTAkczTvb0YXVfKPAhh
 TaDP7YljGFrFflRTvlWuNJBupB1lgriRUz4q0n3pPzI3NmDCujdjABd8iYM1H+pW
 fgg03yz0YLI3EzYZMKQSLXN6g8+/nHzkO2WrT9ck4FZWQS/J7IH+C57MXav794l5
 41C03iti1E0yfLVq8g7BitpDCXfjcoM3D3vK6/lvZUMfaSxbmVYr1OIphRVYsla/
 n2dA8V6r0i8OPlWIWFYAzODK1U9krQRDC1HkuEPfCXHjviGuPeUkAtVVSSmsPodH
 1vukw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47a7wt0kyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 15 Jun 2025 23:54:07 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 15 Jun 2025 23:54:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 15 Jun 2025 23:54:06 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 6FBCA5E6875;
 Sun, 15 Jun 2025 23:54:04 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Tomasz Duszynski <tduszynski@marvell.com>
CC: <jerinj@marvell.com>, <thomas@monjalon.net>
Subject: [PATCH 4/6] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Mon, 16 Jun 2025 08:53:39 +0200
Message-ID: <20250616065341.3233106-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616065341.3233106-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA0NCBTYWx0ZWRfX5oJdlcdK+FCY
 wbLH/PEvNyez7AkDmiKMT1j9L4YFycLtR/pkgNMjnRcjNl3wBSemxKQ6KV/iqUDhnSrx8bvJ0hk
 TdSYmSXpEAyiJF2uLeRl+kOF9IEMsqyAABCAPxYd9Nxj4pdQfC20S3cE6RiwHJ3EDrRW+vSwkNZ
 QkkPJYsSw96zvcfQoF3800958Xzv5MK6S1RAiCnfpTdaetrzUYTQ8jf4RoYdgsCDIpxlkEGOV2t
 yIjrWtwtNK3jnnCphbbUM529f+6uLud0YMCBCIHjYV9M38pAYstuu6Pu5Ln7VuE4ymjVjM1iqFG
 huiuL8TjMPX36zfgOZomuEpokUWcqxmGvT5qF3KnFIMcf16YWvW9eRmgJOGDKMg7ZxB7reCWQbd
 nJCq/eGrIvLsegQIsDlyisIZLCDypK8MLuc2uVC7gRUZvyisPCGbObW67FILiLNpHMBZhPsI
X-Proofpoint-ORIG-GUID: B_FhfqSvbzFurqvByz0JGl404QL13AoF
X-Proofpoint-GUID: B_FhfqSvbzFurqvByz0JGl404QL13AoF
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=684fbf8f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_02,2025-06-13_01,2025-03-28_01
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

