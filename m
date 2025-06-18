Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16FBC71157
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Jun 2025 06:56:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C977B427C9;
	Wed, 18 Jun 2025 08:56:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1475F427BC
 for <dev@dpdk.org>; Wed, 18 Jun 2025 08:56:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HM2JE0010890;
 Tue, 17 Jun 2025 23:56:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=PMJ6YqHUZT2SzDH+E
 QYuHqVTQce70lVVwqDY/PnGIDTaKWCvIJn/Ws/fU4UTDtJ8lxE1aa6A+RKg67m0z
 9srz+GDnngQJK7+JgXJEBZuAWDTU+kflF92L0YNeQQVO5IuCCLUypG70KtDwbTYK
 x5Sk4xWGlDpZkNuJSasUk35njtTDP/E0bqq4zIkuhq71SkiglVODR/ZLfo2CjTOo
 Fb0wEfD73fwVYjbjFe3Xz45NdzZlomSLcOuvjt6m9Ti2P6KU/Yw095rXT0SDsjNL
 ys1c1BNw4WnRFRJmzUfk5BoAapcdELRctLwnWjrLQ3Ifx5EOg+blXYP4QoAM3DxY
 0KfOw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47bgt9gvkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Jun 2025 23:56:30 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 17 Jun 2025 23:56:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 17 Jun 2025 23:56:29 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id E3C053F7043;
 Tue, 17 Jun 2025 23:56:26 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <dev@dpdk.org>, <jerinj@marvell.com>, <thomas@monjalon.net>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>
Subject: [PATCH v2 2/6] lib/pmu: export only necessary arch headers
Date: Wed, 18 Jun 2025 08:56:14 +0200
Message-ID: <20250618065618.4045910-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618065618.4045910-1-tduszynski@marvell.com>
References: <20250616065341.3233106-1-tduszynski@marvell.com>
 <20250618065618.4045910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=IrYecK/g c=1 sm=1 tr=0 ts=6852631e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: aJb4hOVciOcjDtp05S5-zkyGh-FSTyFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA1OCBTYWx0ZWRfX1DwxubFmbUa+
 L3bskHdwMf++NHQqd/R/hUuRmJnF3/uAKX4BzFCO/LeADEt3LUyfoliGm7gmhp3i1MyeHqJKfXC
 x2U03D+grQ6tk1mpBca2A4ek7gbgc5sqTDMj0HWHoF0U1noU+HJMkfkq+1wZg6A/M9ORRMNlb+/
 eSS+kCZlf9hLSIVwrFJlcO0/wRdoKZzlqo9Xuqoyv0P3bv/pDG2D/7kapVImwe8gLBfMR8ufvpZ
 aOVPlX+x/H2I4bNjvoo3EqG0/xIhgNufN/4bf9oQzvUW7MlySDzOBaU0G+rAuF58LmodH6q8x9V
 8ID/vtNqJZpr/CdgTGNF+yj1gLPmPMJUIEp3SxZrZVJtT5e25cs3Jd4fjYsmWo5BOCZybGQ0LRK
 R4mche7gygeNoxVecdQPISLa4JKjXgiqz4WtlhkJYat0vx8V0ZSEvKptqTbVQnqa/At8dUxa
X-Proofpoint-ORIG-GUID: aJb4hOVciOcjDtp05S5-zkyGh-FSTyFQ
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

