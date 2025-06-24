Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BDC77B7F
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Jun 2025 12:29:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F253409FA;
	Tue, 24 Jun 2025 14:29:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 879B240A6E
 for <dev@dpdk.org>; Tue, 24 Jun 2025 14:29:42 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O5Bbsa031396;
 Tue, 24 Jun 2025 05:29:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=F9pdOJmP5djonejw6
 YBzcDYwMl2/JQ7e/VmOB08EO1tQ4fzIEdSHt23Ra0IIVPcawnMDQLAeiltsmdtZq
 Vg3XAz2X4DI7xr+tOShku8MbKBTnBp5My0ZCDr5y0ASoZsnWYHt7JclA8XPaxcQQ
 RuL4dheN3beTBFr2k8FDBwwP90/7aJ4a5cbh9RTXobNfhyHJgEyGrCqBsGsAIUob
 /ulup/RKQ8/S3w9Pe1+ka6Il9c/k33GqpBFAXbSEZ/ilBOdqRtfyYIghs+00s+yT
 2RAKibd5GpRDkXID16fnZHacPURgNxvtWmzMGaHk7Oz/IMvz1n9lZOhaWYkjAPvq
 vKKbA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47fnnbru08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 05:29:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 05:29:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 05:29:40 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 29A7B3F7061;
 Tue, 24 Jun 2025 05:29:37 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v4 1/7] lib/pmu: export only necessary arch headers
Date: Tue, 24 Jun 2025 14:29:24 +0200
Message-ID: <20250624122930.1783177-2-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624122930.1783177-1-tduszynski@marvell.com>
References: <20250620120551.613148-1-tduszynski@marvell.com>
 <20250624122930.1783177-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEwNSBTYWx0ZWRfX0CaTflm4TzFU
 szQK1VgrM4IV8rRBcpoO2M7bOh4ayvit9P9WmIKSdD+7JoDRZZi73Qzri+XfOzlZI1wLAYY8QBP
 NIWGLalI3r8mNJYhgsZOkfwyS0KZ5eNW3TWBLhZt5hSiUkJSZr0A368+vQjhHuJXttXc9aARM2G
 SvVWCD6DU8/LxV/RvGhzV7IcUsVAw+wj3HVBGWFyMAbV5pGX2Q9Qa1HAT+6rq/92PunZTTWITew
 jYesfRhGrvnEMSee0ZvII3Vm0mlVCMnub7IN+2FIr/uUCCvr957hKJgCm1Gmj5Upvnz3e8adOvH
 z+2WYK2grId1zLPWNEdcLAq5Wqgtzflo/ynjUXsdd0crniJjDxU/L15OwydgBtQU6NyY4ge5Q2G
 geyrOnMklpGD07k8iiSUbqysagqfmoBcMGN49Y76R+S40A8xJy4CcoW97Psry5c2l8SktQKm
X-Authority-Analysis: v=2.4 cv=IPECChvG c=1 sm=1 tr=0 ts=685a9a35 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: tFGbX1kURCJ5uL0JgIEj58_8ZVDCBlNH
X-Proofpoint-ORIG-GUID: tFGbX1kURCJ5uL0JgIEj58_8ZVDCBlNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01
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

Install only architecture specific headers to avoid header pollution.

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 lib/pmu/meson.build | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/pmu/meson.build b/lib/pmu/meson.build
index bcb6d10f1a..53013d0ed6 100644
--- a/lib/pmu/meson.build
+++ b/lib/pmu/meson.build
@@ -10,13 +10,13 @@ endif
 headers = files('rte_pmu.h')
 sources = files('pmu.c')
 
-indirect_headers += files(
-        'rte_pmu_pmc_arm64.h',
-        'rte_pmu_pmc_x86_64.h',
-)
-
 if dpdk_conf.has('RTE_ARCH_ARM64')
+    indirect_headers += files('rte_pmu_pmc_arm64.h')
     sources += files('pmu_arm64.c')
 endif
 
+if dpdk_conf.has('RTE_ARCH_X86_64')
+    indirect_headers += files('rte_pmu_pmc_x86_64.h')
+endif
+
 deps += ['log']
-- 
2.34.1

