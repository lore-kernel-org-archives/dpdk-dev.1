Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9036FC87FD2
	for <dpdk-dev@archiver.kernel.org>; Fri,  1 Aug 2025 10:21:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9251640684;
	Fri,  1 Aug 2025 12:21:32 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8A6D040678
 for <dev@dpdk.org>; Fri,  1 Aug 2025 12:21:30 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5719Xt4f006664;
 Fri, 1 Aug 2025 03:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
 sEDkKW1iDJMGMekH2u76KGFzXdnHq2XbYLlXIOm2/8=; b=gSq34Mu0UIafwpSqr
 o2eCBdroTzfJtNmTeGnjoCCSUezsYeVbjSOponGkvNbSOLeKyhmGZDb4Wjbx/pgj
 rsiFUP3ZjK/Gv2dqQU6X45gBvLVtUYMIdw8KB2YSDj9RWurD4TKBqEmGsZNkL0Nh
 DyGzMOCFfhys2/tD6K39uMk7YFEAR2tRkCKUgs3BWeEMScsDKgzYXttAYHZ2/TP2
 aqKZ2rBd+3Id+sPqOKaKRZb3umEAhFelIcmu3svfBmDsScKilTq1ELZjrKE/rz5e
 sIJFD7xOzTGXuujsObAevciny757oZ7y39Ut8eYe+ejlBp+Uu71db8S6lk2AJWvv
 h+/vA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 488u2cr2uy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Aug 2025 03:21:29 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 1 Aug 2025 03:21:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 1 Aug 2025 03:21:30 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 134353F7079;
 Fri,  1 Aug 2025 03:21:25 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <david.marchand@redhat.com>, <dev@dpdk.org>, 
 <jerinj@marvell.com>, <mb@smartsharesystems.com>,
 <thomas@monjalon.net>, <stephen@networkplumber.org>
Subject: [PATCH v10 04/10] lib/pmu: export only necessary arch headers
Date: Fri, 1 Aug 2025 12:21:03 +0200
Message-ID: <20250801102109.3544901-5-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801102109.3544901-1-tduszynski@marvell.com>
References: <20250723044118.2962318-1-tduszynski@marvell.com>
 <20250801102109.3544901-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=688c9529 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=2OwXVqhp2XgA:10 a=M5GUcnROAAAA:8 a=r8mbcy_HfW-B3KRPtLcA:9 a=zZCYzV9kfG8A:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: FC3TVL8elrGu3AFjcqH25F8duBQosII6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NiBTYWx0ZWRfXxDkjzO5Z8z/r
 wPUirQbfp4orIFwZ0Vxt6IT8kN9HceemAeWxFbmbw86BRYD+XPJypK9uaaIfK/x3ZkkP6QrLOhP
 6ibf4VPQYJmh/YjR0zQiWZVsMpRqoJlwYru6D126X6lThyM7WwE5g+ff2rWxhDzyCTdMwnXqnpY
 set7I87xUNbeV5l04ZbN/VUuyxPc2CrMlz1pjUVSJHjziGwBRZYbh9to4ZT35cTn236UMjGMmA7
 4suI4yTtap3uLsBITjYB028UBigRyzx5SuaATIUNPQsYc+d5Mpqy/Z1mOzufFAu/jGDaexTPKWG
 r0CyU/SFCpuYOmpB915fmKnMG1uUoH+dvOSHIVedPl1dfjyT9CIC/FHH9VzzzD23zrKjLnbxsIO
 bWZIH5I3EoMfT4MMdauwrR56Eo6dJ7rtm/Bo3bn2LlKfsCeGTK6ITNzIB00ekOUTzQ5uaH6g
X-Proofpoint-ORIG-GUID: FC3TVL8elrGu3AFjcqH25F8duBQosII6
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

