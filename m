Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59DDC77B7C
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 04:47:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B31BB40B9C;
	Wed, 25 Jun 2025 06:47:43 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8D37340B8F
 for <dev@dpdk.org>; Wed, 25 Jun 2025 06:47:42 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ONTmwA007855;
 Tue, 24 Jun 2025 21:47:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=RScSH2Sjm3jRpcC2c
 a8BLkEOjj/Nfge8QuosK3qb8GOH46cNL/WnRywutZuICMQ2DSlvSv63pSnzZS2Lx
 HmNOj7oOZ7sdKLRxT/U0zNNofW+zSvv/juurCGNmXMwpQswNxyoE5BVqkKbiIkv8
 5LVScTHYbtL3b7yemr7PmXXamOZpa/wNt084NBzwWqN4zmeH7y8n91OM0Xevxvgf
 yrpCX7cQ+hFV4sJubKdOt89MQdvA/tWMGfgqkRUoGpLrOwMkIuDwWaBGuZ6+iHPO
 MMkr2b/tcMTse3a6miapdfN0ggAPW+xWxOD4cFjTBfKP/ldADiQ3BKLUyzFAi7sX
 tpXBw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47g5r90gm1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Jun 2025 21:47:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 24 Jun 2025 21:47:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Jun 2025 21:47:41 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 6E5763F705C;
 Tue, 24 Jun 2025 21:47:38 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v5 2/8] lib/pmu: export only necessary arch headers
Date: Wed, 25 Jun 2025 06:47:24 +0200
Message-ID: <20250625044730.2435526-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625044730.2435526-1-tduszynski@marvell.com>
References: <20250624122930.1783177-1-tduszynski@marvell.com>
 <20250625044730.2435526-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: GOLNVEILheKgEB-3X1HrBcyQXoVYeIFn
X-Authority-Analysis: v=2.4 cv=GYMXnRXL c=1 sm=1 tr=0 ts=685b7f6d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: GOLNVEILheKgEB-3X1HrBcyQXoVYeIFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAzNCBTYWx0ZWRfX4z6UqW76evS2
 33mwQDxdZ/wASC8luSFuyp0fMS6fyU2Oypn1BjfrX/+0ge04KmxJ8dL4EhTom5NX/Hl4tYM8gfO
 0tHk53I5wKTwnPe0J03H7NqYVB8l049KkWxF6IoWUISC8roL+ajobFyUQ4C8RFUok81ocp274H4
 OBlD96dXP9mcR020jTL+uDoO4mFYK8t3ljZGJlAmdLywYQykoxq4RZlrgDOB/dFT9PW4+CtJuBK
 e+Jm+kIUZkksL+BL/W8QfFninERVh+qY1HmrRFenbbrWgT5s3ldg4GUUvTxFSlHDbXGGgtEETHH
 5MYBmVvlbsvoFwB/vyyHa7zqxaccKiseHyFLN62iAN234HSgat1enGEPK9j/f9LVPXYQG12T62Y
 5b/lLbXIH8ZRB2RHHujRovC1VCJt1vHx7Kl3Ilsp4x059YjePSDy8LwvXmKGA3eWCIvCvAGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
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

