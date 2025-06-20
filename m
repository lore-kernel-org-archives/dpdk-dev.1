Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BAFC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5BEA42F05;
	Fri, 20 Jun 2025 14:06:12 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 60D8D42F05
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:11 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4iXuu028355;
 Fri, 20 Jun 2025 05:06:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=a
 SvuN3kLrzYKdEIqtxCYsnikgBpAcke/wrd8BTU+DLA=; b=P597Nxw6vxlDsvLzT
 NmcqeR5rr6OjWa5SEuJj4BjRLhOdBhltfbG6VboCyRas2eMu01V3PFeL2hsctiqJ
 TT2BUeyPDSGePwfs2PxgbjxRYqk67YSJH/Myk1YDJvnQNziGy5Tu6bUUiVQ3E9cB
 OCcWgLilSFxdXiODPri7NfFVLpNs1oeNJxJQCUBQrLo/Nk5LkEaV7woj5AwX4bBt
 GjnEeUwjCOAq1HpBtV2tU9L7QdwVg9MGGWSgbQXM60U+MIg1Iv5jgu5TJY29Fwes
 kBbo3vDsbFi1chZMsLponwMtoFqvU/qazdKybdVHiOfY4PX+32cqWfDl2vOtoCcv
 5X/5A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47d0vb0r15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:06:10 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:06:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:06:09 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 3D73A5B692D;
 Fri, 20 Jun 2025 05:06:06 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 4/7] lib/pmu: use build system defined RTE_LIB_PMU macro
Date: Fri, 20 Jun 2025 14:05:48 +0200
Message-ID: <20250620120551.613148-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
 <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 0GJKS1Q6uQ0TpS7N1K-oq0sMNy1QS_jC
X-Authority-Analysis: v=2.4 cv=O+s5vA9W c=1 sm=1 tr=0 ts=68554eb2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=esutNisFxaaDPwP1l9cA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 0GJKS1Q6uQ0TpS7N1K-oq0sMNy1QS_jC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfX/+/vN02EaXUu
 ND4Us1IHx9mMEeCIEU4UDgUXBG5NqQJ5KBzMDOu9/PKtgjxcgy5IvP2hoMdQEBAhP14zcMe6Ecz
 4+FElA3mv7+WOIstz5nly6PvedVhbMriiNKdGpuoalQPKBZrQ2Bj/kVqseagrSFDNHbYU704zXn
 ojRoAOWAlGsD7x2MetEKvwLPEC4TdL68+dKqru2AOisEj/adFSbywkNOVOWWEP22BAhxB3B2MVT
 7PltITqivThffbh/bh70JdcqAVwA84MXam+pdRbZGFT71qGHCYRToYnJpfsy8anTE8dMUseP1Mf
 pszkBnt9jc9CQsMHao7uByDqdya7LKimkl+mzbCHCg3A+pEzoSXU+ABEi+P/Ujp8MSlPV66nBu9
 F1mRwbaTEtSkxwZePODkWmk9olqu154MCTVhjuB9zGhKY3uVxhp2RTCOzE0K8QOOvPBGj8+z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_05,2025-06-18_03,2025-03-28_01
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

