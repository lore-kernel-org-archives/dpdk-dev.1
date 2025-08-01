Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A555C87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:22:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03C4240696;
	Fri,  1 Aug 2025 12:21:42 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 940B64067B
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:40 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719XmFB006490;
 Fri, 1 Aug 2025 03:21:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=XFoTQZ76KMaEyXFk1
 kqz2+ariJ/sFygZmnX+7LHyTF4spyCWaCml6SwRKQGU98blde48Xh5spFvkY4FXU
 Cen8otMEzzNASwLVC2e15+i1kul0GFkUj6kXX54dXPF1U6lOvnc43iUCbTLesqEx
 OzPpsHTMN9CoHEnyGk6O9IhiURzy3FXmn+ivSlf1JbUkBkSo/w7axR837zMs96Cu
 9tmL9/FssZ+2mXssLaWpBxsSAaFcRSsWWkn4pTQv0Hdyuiw3GOhX1SDZws7TnYz5
 skpAThVIW8mQmwKTRDmeZLQQVpR6HFmeELCdaIfMY/+Df3Pcio+2lmEk1DHMw9fO
 j9Pbw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488u2cr2vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:40 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id DF3BA3F7079;
 Fri,  1 Aug 2025 03:21:35 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 07/10] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Fri, 1 Aug 2025 12:21:06 +0200
Message-ID: <20250801102109.3544901-8-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=688c9533 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: fYYK-wsTlM-wRPvKnulReBeycUT7Qmzz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfX+Y234yU8msM6
 jVEk1ucbX11O8d76IS906OtpfcalGjGKn/8gMnKeTv7sPzJhR29FA8WbxEPCxcso3T0DMfh9Ncj
 iG2DOFnUOOOSTw0SDCb52Y/85IOOGnMwuCIX64BFwxXnWIdppDBSoTqzx2LbRSg40IB4dxF2UQs
 t6dBnQvyLkFcOcJUnfzRysrRTP5uYVULJuNXAp8yRnmVcxP3VuR4XzrSyFKKORcP+5m5DRIEVUe
 mDVLGPWTQVDx7WaYuNolDH1GSTqUWTqQ0O+S+igHL0MnVMxPDmhqgtK7T5occbBTtSrf1KTowVC
 aWrT5m71lrhFBblhhmXiilo+FMfcETnNTA8wrW/qLkFbjgl6munQL6nCaBuhGsa0T7thE499OtG
 2TnP69JUvvXkuFn7qrTd4EUgXNEjKSij8unjfLAdMisihOlP6lJ5Dr65KpK49IPM6mnF3otP
X-Proofpoint-ORIG-GUID: fYYK-wsTlM-wRPvKnulReBeycUT7Qmzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
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

