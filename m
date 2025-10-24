Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54950CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 05:49:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97B6240612;
	Fri, 24 Oct 2025 07:49:11 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id C34A7402D3
 for <dev@dpdk.org>; Fri, 24 Oct 2025 07:49:09 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3D0bL022962;
 Thu, 23 Oct 2025 22:49:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
 hyCDoCAt+EPv0mBMXf4rRHl7BNmnOiieHAlgK+Vibo=; b=c81rhqatZcj4T6Vok
 pNaqO48CN/lS9FC5A5ZJZC4VQThCi1ftCtGwEa5RwIRZH5B4W9K2wvoDzHJn8+J/
 bonhzIRmWwjf9Uwd9dNQEP7cTop8LgM7S89sHmLmNnsinErOttjBR63q3nUBlgs6
 Gh1eAJufSgBggrbF0Ekv28MGODAxQcWR3SdlctX1GbO/9iU/WMmF9bOwWEuPUQTm
 X4FtzinW1AjqpMVAnPSaBMz3pSzjZSE1g/xfkwfrHQTbsY0xx1oMPFBMxLxeRjEd
 kjwsYijo/pOuz+m9JRr2aqmnDhgcjMmtSohrgELyvGL5hvrZbNTVVg8x4BOBmBbo
 UZ0AA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49yx2j0jg1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 22:49:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 23 Oct 2025 22:49:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 23 Oct 2025 22:49:15 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 8A6BE3F7071;
 Thu, 23 Oct 2025 22:49:00 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: Tomasz Duszynski <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <Ruifeng.Wang@arm.com>, <bruce.richardson@intel.com>,
 <david.marchand@redhat.com>, <jerinj@marvell.com>,
 <konstantin.v.ananyev@yandex.ru>, <mattias.ronnblom@ericsson.com>,
 <mb@smartsharesystems.com>, <roretzla@linux.microsoft.com>,
 <stephen@networkplumber.org>, <thomas@monjalon.net>,
 <zhoumin@loongson.cn>, <wathsala.vithanage@arm.com>
Subject: [PATCH v11 6/9] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Fri, 24 Oct 2025 07:48:27 +0200
Message-ID: <20251024054830.933910-7-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024054830.933910-1-tduszynski@marvell.com>
References: <20250801102109.3544901-1-tduszynski@marvell.com>
 <20251024054830.933910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDIxNCBTYWx0ZWRfX2ZQ5bd8In2nZ
 LfiVOgUAkxRprKfm88DTsFpYMj/yDNtHMDDUbWL0KwSpO9SETA24n7KPlzSNaK0HdhXRlNg9Ba3
 //MHoSKnv/RTFiRCpeOLdSgt3ugqGFSsc3lE3PO5XrrPKuMIfm8WGNF5TiVBrcS2GMRIH2tcvsZ
 sn/9emcBI57/+ucr3a8/l+iU2325+1KSzpgH9VLRr1JwNebNXa8M9NcbcRosVsNJFdL/3zJ03Fh
 b108VF3m51apu7WLllz6CpOSKwe0l5P/S2Iq8yP2uW9bEdDGJwVhQwHBfwsziuu24ijfN0P9eOj
 7VEmwk4gT7W/gmf+wlblmR+v1mcDAKU/AtPQCR5gH12ovcIVAm0qA+YcREpOb7r/OCnW2jVI9u2
 0/5im1AZzIqK32igefa+1y9jlPVLwg==
X-Proofpoint-GUID: wzNHx5mPVzz6k195wNEorgy4GvAjMQd-
X-Proofpoint-ORIG-GUID: wzNHx5mPVzz6k195wNEorgy4GvAjMQd-
X-Authority-Analysis: v=2.4 cv=Rs7I7SmK c=1 sm=1 tr=0 ts=68fb1351 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=4ao0HVNFi0lqQHF77aQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
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

RTE_LIB_PMU is defined by build system automatically if DPDK is build
for Linux. Otherwise it's missing.

That said all cases where conditional compilation is required
can be handled without introducing other macros.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/rte_pmu.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/pmu/rte_pmu.h b/lib/pmu/rte_pmu.h
index fcf125a908..2e3678d966 100644
--- a/lib/pmu/rte_pmu.h
+++ b/lib/pmu/rte_pmu.h
@@ -34,13 +34,10 @@
 #include <rte_debug.h>
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

