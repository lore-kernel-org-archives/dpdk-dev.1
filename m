Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1B2C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 15:41:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 313E240685;
	Fri, 27 Jun 2025 17:41:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 61A374067E
 for <dev@dpdk.org>; Fri, 27 Jun 2025 17:41:22 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RDqVio019858;
 Fri, 27 Jun 2025 08:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=HFJ6xKPg1dzO4/IEo
 47v3dXMMktdt+Xr3c2gmuNlcPBgdygiXpSg5TeM5AX2NiBKeZ46iZ80k0P8GXbrh
 4Yapz8mt/GkK73U9gnIuJHa1O+7dR9vZLA94JbadR6PYq4nDZ4A2f3ZX+rabeWwg
 SFmwZ323yTfs7ij+4mVlu4W47yZSA/zoY1dG36N+LpIdJIxH6FUm32s1CyLcSsoT
 29GyoaCxGtmTu2nj7xZgj0J4pBRRtDn8qF+XVpfOAZ523sRrnMhMoY8VA1KE01Ur
 Fjhh5Gjysl/OY0vJBhz9iepIW55TCFC+8VUeAjx7bHf+OyIsf+SvVrMpmQFGPpYd
 EOPQA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47hfx69xwj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jun 2025 08:41:19 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 27 Jun 2025 08:41:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 27 Jun 2025 08:41:18 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 60C913F705D;
 Fri, 27 Jun 2025 08:41:16 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v7 2/8] lib/pmu: export only necessary arch headers
Date: Fri, 27 Jun 2025 17:41:01 +0200
Message-ID: <20250627154107.3405768-3-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627154107.3405768-1-tduszynski@marvell.com>
References: <20250627105740.3388237-1-tduszynski@marvell.com>
 <20250627154107.3405768-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDEyNyBTYWx0ZWRfX6hBnvGYxdu0+
 EqjEUn9QltpCy2chK5m3RPDr9sgjDRh4+EqMobQlWiDHYBGS0Fw2Oh73H7LMQH2z5frdluksTH9
 Fcye4UO1AHKKE+e2G2KvidhqH6vvvIzymase+JsvZXIHH/J58B1aNNhp5scpWfGi9QE+8XuzO1x
 zZSMXwLMxZLaEFsDSQa4PdsCmBr577FlNgxOcVxS/i+zTMujOqQCEFS8/WgqTvSXp4utgOpTnit
 JvceRyDOsmoAaycGi6FD16/ealQXHGaJfhXG5eQz4uYoRb8HaaZDDs5uhI/7+JYyZVMvVBTvQGq
 1Y2QmqfuugWy28p1wxcsUqIFP4hn75z3oxoVAv7Cg+C1Y2O2p7jv83p0IJxnuvHy+PuPL0CVemH
 55lOyXOXzKcQC2mOAbQl7J0RnArOLF26gVKIRmwhCx5w9dTu9ATvYb/3vCu3KiqHduWoHUWJ
X-Proofpoint-GUID: a0gsXZ5_4pJzOwgfpFFYlgeQOGlIxEFp
X-Proofpoint-ORIG-GUID: a0gsXZ5_4pJzOwgfpFFYlgeQOGlIxEFp
X-Authority-Analysis: v=2.4 cv=N+4pF39B c=1 sm=1 tr=0 ts=685ebb9f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
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

