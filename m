Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715FDC7115D
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4975542EF1;
	Fri, 20 Jun 2025 14:06:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 6405D42EF1
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:05 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K3TjcI015666;
 Fri, 20 Jun 2025 05:06:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=kKlCnKS0AB8BgqlcI
 +d7kqrWRzaQmLcAUzzJHsBfYaR3V7tfO4c+tKO/ZRupmJMEjtt5b3XfSyz6rWsQA
 4ONoC0JkgqOdaD8OygiZ+8jRLSxyfd7gDHmQTIlhUPpzZkEsbVDRxsnDDpUl7duh
 XQ7cuNY9Jw07Qtq9UsAVbY5aL8MvPmjIrAOWHvwKhJr3J3dU1TemIqpKDpX1gvyS
 WMHsbdgUjqVdj36s4s/bEoBhDAK0ocIUjXV8EaRHGEiQtYgX/H4nIuAMOFDf07nZ
 EJJ+VdSa+00ZYeJL4uHVapCgiQ1W7u6DVeI05gTNPZR2sTMJwO7C/2wSg5kxrqhC
 jUeVQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47cyshgv7w-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:06:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:06:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:06:03 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 1F1F75B692D;
 Fri, 20 Jun 2025 05:06:00 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 2/7] lib/pmu: export only necessary arch headers
Date: Fri, 20 Jun 2025 14:05:46 +0200
Message-ID: <20250620120551.613148-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620120551.613148-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
 <20250620120551.613148-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TuzmhCXh c=1 sm=1 tr=0 ts=68554eac cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfXzZNpVJeT//lB
 /JAY2HM7PD3agfREM1NSpBvalzOV55BAQtolHQ1s31XQ+0rF/QuCYckmoI5VJbyT/VNzBDEGIGr
 paFDilj6SIVUa58/unhNBEOzJekITvSz4RGUbUyS4Ub+EV7nULFxijYi3Pikz10ElmyrKNWum/N
 WxQlmV/5kwMlydAbOgY7Mdbxt8pvlANZTskydzETF6R+Fd3/5sLMTQI/vqVaOnHw4OOEdEDzzni
 UhH+dWrnI34jhqHHgfkBl9xLAnJB12mgT61Cuoi5NiVZEGEV3T9QW0sTnat6zZQ9hb8sK6FESl+
 JuRH4WZlxpSZey88Ygzk7iot7JBrM6DKCujzS1tMAFKDuN7X/Xikz+ONoNPyk7xQYNL4n7NnaNJ
 O2eG9qohH/M/pFrnoBzaxgOWJqz0iX5OXrQYbbIisfWjGQapCqKiyK1k1UZC41fX6qSZS2wB
X-Proofpoint-ORIG-GUID: dJFlN9-759VeEsrj2xZmWCqBMa7GT_QL
X-Proofpoint-GUID: dJFlN9-759VeEsrj2xZmWCqBMa7GT_QL
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

