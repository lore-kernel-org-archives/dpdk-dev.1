Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB5BC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 04:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F41B4067D;
	Wed, 23 Jul 2025 06:41:36 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id B7C814067E
 for <dev@dpdk.org>; Wed, 23 Jul 2025 06:41:34 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MNXckr026919;
 Tue, 22 Jul 2025 21:41:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=POuEL4gls6yWrpk4K
 x+Tq3AuOh7z/bNR6NTIcVbQvX2Qe0ehIoqdEjhshstQVJWnX0pbe0CcxJ9Gs4OUj
 7vFArHDE/+VmoPddG4zmbJFPH40DfadiuZixhd5XVpiZWO30npTLTklPplxYJmwA
 Fnp5+CBLlKwgD0JS+dQI9u8455ESoyNbrH4iv7mUiqDsnCwQlgqsoSzXQmcMm8eu
 1YeYaV7MXciRr1gKdZcXJZgeDtEyJMZbesCCr4bODUbhSZJdZL5obwDnrJB+a2qw
 qKM8jrEVm2n58pXXTS9UK8JzoDWEmdXBBRRQxiPGFPocYRBxy46Omon+G/8GH/UN
 43Tmw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 482jy50pk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Jul 2025 21:41:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 22 Jul 2025 21:41:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 22 Jul 2025 21:41:33 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 119A13F707E;
 Tue, 22 Jul 2025 21:41:29 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>, <thomas@monjalon.net>
Subject: [PATCH v9 2/8] lib/pmu: export only necessary arch headers
Date: Wed, 23 Jul 2025 06:41:12 +0200
Message-ID: <20250723044118.2962318-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723044118.2962318-1-tduszynski@marvell.com>
References: <20250722120041.2718227-1-tduszynski@marvell.com>
 <20250723044118.2962318-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zPM-wbK3WiwLumP4go0TIvhTT_mKPUr3
X-Authority-Analysis: v=2.4 cv=OdqYDgTY c=1 sm=1 tr=0 ts=688067fd cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: zPM-wbK3WiwLumP4go0TIvhTT_mKPUr3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDAzNyBTYWx0ZWRfXyzb/3iui+WC3
 X32cWG3frcFsZsx92uH8MHqMTs0YHkGLF2cOz4EXigk0/WkMgZ6hqQ0HTbm/z5iZylwIgK+yUeo
 CZzlxUBDGDVqkBsCKrXRx8PWui2REGwtibOEKkpG11wslr5FMgoRPtzCdBePXxZrxn8x/68THDQ
 k3UxTpeKpnI2vY/E2j1tgZ5JCwWc+/rKLPxrjpHfH8ne9+Pz/qbqkh0qut+JrPmQToPXVMY7+MG
 eCBGnoR2CqBBm/aTK+pPdpgSqsf81HCq34RGSRB1gzCdEAPjed5CjW86W356E0NqaxwpKqLejzd
 Ylw3ORnAX19Xrsjm9k7Lq03sIwcDR48PyPFwMnorl69ot4yqVs2AOkHxNpNFrCC9ch8OLp9LHV8
 tPbNtnUccx5Norp25/lspr0Kxv6jcYcR7sPSrV6AgbjWMu9RMIPvDcHuAxsuTKechdqbp4Xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
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

