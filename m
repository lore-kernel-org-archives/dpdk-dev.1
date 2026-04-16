Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C28F8DFC5
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 21:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57229402B2;
	Thu, 16 Apr 2026 23:12:12 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 13208402A3
 for <dev@dpdk.org>; Thu, 16 Apr 2026 23:12:10 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GGNSl81882195; Thu, 16 Apr 2026 14:12:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=j
 QwPv7fpvE396Vt8YPQ3L8+j88K50JNCvrWfUo2sFkI=; b=YwvHn5bhc2Ah31QU5
 0ZZZCuUyT1aJOGruWTCIn5Y/BARqEzRzeCZYYfK979CqdzNvgLuOOZozxB1I2TLw
 /urMQrT1w8oFc/5sRXyRbDTFJCbNbZjGtNZt5WKKRbe1iuKNDQYfTvkRS29Pm/Mu
 Vw3OCOTuAr5ORuA5r2vqV6smmH3TTslLgD65byyIvj5C3ZKKnowDL8OHqM2FBnsH
 ooBsInOgCP/Lv6GZAVO1pet/3NM4RgObAs2elhHXXLEq7H97vSZvpDr2Q362wJGR
 hSw6dnooNs9xatiXVgwhkTsdvGLwiSwWe53w/O06DuxSt5MTSvoNWCPc6w5GyBiO
 3uoiw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4djmcujykd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 14:12:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Apr 2026 14:12:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Apr 2026 14:12:04 -0700
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 765B93F704F;
 Thu, 16 Apr 2026 14:12:02 -0700 (PDT)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH v2 1/2] config: add mbuf burst size configuration
Date: Fri, 17 Apr 2026 02:41:57 +0530
Message-ID: <20260416211159.44785-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260220230745.26418-1-pbhagavatula@marvell.com>
References: <20260220230745.26418-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDIwMCBTYWx0ZWRfX73vULDCX7vSX
 +s6QxlMudWDmnrR+Qv11W+uN9R64k+WSohN2lm8I+vyhRIYWCEG9LvV9DeliyAea6J2mJsOBYh1
 AizpWz0HPMeRnbyxfM1f/N/HruPGvUeBeRK+AZgJ71kGuZNjg3CrH4fn8/4Wdq6C0SYUGj4162L
 +UFhCuvUY3tgNpsIR9g5m/90/MgvHTXAvGU3eNHmMWBRbrS7xZrgqGcdDbsThpTaWj/CXL66FMv
 IRLfFlGdStBsxsL6DbXL19igXQSJ+8rfEh0/wLWSIVQtsbsygASAUDOjXoWTzsbfeaDaifoZQfT
 ZIwU7RymgXgEWdj1ODOmUpUnaMUJuvn33/Ypj5J6JOPSYDm+OkXSQaFD7wBF3nuKz89mSuMZR5k
 +BUMiEZ8w1pDMjZLSSrLcjMUV1/w6NzWaN2RPuF5E7lGUM95LZJ7N+CvgBdm7HMUD1MN3zsHhhc
 kx1QhOOPJiCc3MoS4tA==
X-Proofpoint-GUID: Bz3YZS05A8QHRSoXTx-x5fMLliyJuElp
X-Proofpoint-ORIG-GUID: Bz3YZS05A8QHRSoXTx-x5fMLliyJuElp
X-Authority-Analysis: v=2.4 cv=F4hnsKhN c=1 sm=1 tr=0 ts=69e150a5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=0ouuwSWPl8E_Yop2Dz4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Add configurable mbuf burst size macros:
- RTE_MBUF_BURST_SIZE_THROUGHPUT: optimized for throughput (default 32)
- RTE_MBUF_BURST_SIZE_LATENCY: optimized for low latency (default 4)
- RTE_MBUF_BURST_SIZE_DEFAULT: references the selected profile

Add meson option 'mbuf_burst_size_default' to select between
'throughput' (default) and 'latency' profiles.

Platform-specific configurations can override
RTE_MBUF_BURST_SIZE_THROUGHPUT.
Set to 64 for CN10K which benefits from larger bursts.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
v2 Changes:
- Contain the changes to performance applications in app and examples.

 config/arm/meson.build |  1 +
 config/meson.build     | 15 +++++++++++++++
 meson_options.txt      |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 5a9c16b9b16c..3b1b5664f0b2 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -481,6 +481,7 @@ soc_cn10k = {
         ['RTE_MAX_LCORE', 24],
         ['RTE_MAX_NUMA_NODES', 1],
         ['RTE_MEMPOOL_ALIGN', 128],
+        ['RTE_MBUF_BURST_SIZE_THROUGHPUT', 64],
     ],
     'part_number': '0xd49',
     'extra_march_features': ['crypto'],
diff --git a/config/meson.build b/config/meson.build
index 9ba7b9a3384f..eba2b9ae366e 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -399,10 +399,25 @@ if get_option('mbuf_refcnt_atomic')
 endif
 dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))

+# Recommended mbuf burst sizes for generic applications.
+# Platform-specific configs may override these values.
+# RTE_MBUF_BURST_SIZE_THROUGHPUT: Burst size optimized for throughput.
+dpdk_conf.set('RTE_MBUF_BURST_SIZE_THROUGHPUT', 32)
+# RTE_MBUF_BURST_SIZE_LATENCY: Burst size optimized for low latency.
+dpdk_conf.set('RTE_MBUF_BURST_SIZE_LATENCY', 4)
+
 compile_time_cpuflags = []
 subdir(arch_subdir)
 dpdk_conf.set('RTE_COMPILE_TIME_CPUFLAGS', ','.join(compile_time_cpuflags))

+# RTE_MBUF_BURST_SIZE_DEFAULT: Default burst size used by examples and testpmd.
+# Controlled by -Dmbuf_burst_size_default option (throughput or latency).
+if get_option('mbuf_burst_size_default') == 'latency'
+    dpdk_conf.set('RTE_MBUF_BURST_SIZE_DEFAULT', 'RTE_MBUF_BURST_SIZE_LATENCY')
+else
+    dpdk_conf.set('RTE_MBUF_BURST_SIZE_DEFAULT', 'RTE_MBUF_BURST_SIZE_THROUGHPUT')
+endif
+
 # apply cross-specific options
 if meson.is_cross_build()
     # configure RTE_MAX_LCORE and RTE_MAX_NUMA_NODES from cross file
diff --git a/meson_options.txt b/meson_options.txt
index e28d24054cf1..2caf0be91d39 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -46,6 +46,8 @@ option('enable_iova_as_pa', type: 'boolean', value: true, description:
        'Support the use of physical addresses for IO addresses, such as used by UIO or VFIO in no-IOMMU mode. When disabled, DPDK can only run with IOMMU support for address mappings, but will have more space available in the mbuf structure.')
 option('mbuf_refcnt_atomic', type: 'boolean', value: true, description:
        'Atomically access the mbuf refcnt.')
+option('mbuf_burst_size_default', type: 'combo', choices: ['throughput', 'latency'], value: 'throughput', description:
+       'Default mbuf burst size profile: throughput-optimized or latency-optimized.')
 option('platform', type: 'string', value: 'native', description:
        'Platform to build, either "native", "generic" or a SoC. Please refer to the Linux build guide for more information.')
 option('pkt_mbuf_headroom', type: 'integer', value: 128, description:
--
2.50.1 (Apple Git-155)

