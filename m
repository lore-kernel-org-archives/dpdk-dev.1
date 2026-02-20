Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EA8C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 23:07:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC7374025A;
	Sat, 21 Feb 2026 00:07:57 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 91A8840150
 for <dev@dpdk.org>; Sat, 21 Feb 2026 00:07:55 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61K84xF91084254; Fri, 20 Feb 2026 15:07:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
 1+jv+mQ3wUDK3w92PYz97uypmFVyVizl/6wjwbFeHI=; b=Th6AOEmQzuEt4J4pW
 W3vPqThzkwolZdBl/nEO/ZlufORJmJPz5wJyszu6jjpRwEBYYEpXgAz1H4qDdBwW
 UPdG5Wmw6mb5Uu2CE5zIE0zeUMOnvRm5alykrRCnEaImT6WJZMtxNW9qwQTkK9Mt
 7TTlbspkPG+feCMijXuzXlHEkZk6WWRuQ2OCXvMh2dtAlg11xRymb8qKYNAdatmV
 TiCHq3kunX1Gl8AjK62V5uToc4o8Kw4EetqGDqLNfnt9mZu0O/BXPXPTcX4BQkbX
 cZA7RRdvW4MstZBR9iinzku8klOME7e+joW4nr2SUZA7UZ+2O+42gLIANJ9R0ZoK
 YWyiQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4cdkmrdy0m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Feb 2026 15:07:52 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 20 Feb 2026 15:08:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 20 Feb 2026 15:08:08 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.165.174])
 by maili.marvell.com (Postfix) with ESMTP id 0DBBB5B6943;
 Fri, 20 Feb 2026 15:07:48 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <mb@smartsharesystems.com>, <jerinj@marvell.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH 1/2] config: add mbuf burst size configuration
Date: Sat, 21 Feb 2026 04:37:43 +0530
Message-ID: <20260220230745.26418-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126082414.91933-1-pbhagavatula@marvell.com>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Sh4canSOio6CERXoL7tuwMpj-burZ8nK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE4OSBTYWx0ZWRfX436Z9rgTzhE4
 OZdhrrxx12N3dija8QOksHcYl2I0SPioPeIZq88aqrzr79oYn99g6KD9lJtLU+ZExN5zHBoDi1O
 qLoNx7m3n5HMr1Wc4pHl7N90ErZjipL65tZMIzaduI5cZm7SA7tC4MdtI3LCVQ1cQEPLhun7KZJ
 UZIY7VCuTQdG8U/LIln7Ms+itGUZyS5+Lm8YqMJtTBWuDGE4B7KA0qmZmNZf82Spbr/IDJ1EToM
 BymrJ+9IhGpMaNpFyCRdYX0IBekFXcSoi1ebz1rmNig2jRhiobvnsbqkLsBcgK97NAxkTC8PuQ3
 HdoxQsvXN6DLk8VjoijCPNZCSX47lhSH9dz9pGcn1aNwK0fNmDaZ4m50xrTezicRrcjhifM1R7t
 VIcVzA/BZCKnz8kRIoUXInT9rASVaBYvTdk8wGrg5EElt1TIndZVgmVEJqfxdDalJdHcawo52iR
 ESlnvn6LJKbIXGfO+gg==
X-Authority-Analysis: v=2.4 cv=J76nLQnS c=1 sm=1 tr=0 ts=6998e948 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=M5GUcnROAAAA:8 a=0ouuwSWPl8E_Yop2Dz4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Sh4canSOio6CERXoL7tuwMpj-burZ8nK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_04,2026-02-20_04,2025-10-01_01
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
v1 Changes:
- Renamed RTE_OPTIMAL_BURST_SIZE to RTE_MBUF_BURST_SIZE_DEFAULT,
- Added RTE_MBUF_BURST_SIZE_THROUGHPUT/RTE_MBUF_BURST_SIZE_LATENCY
  macros with meson option mbuf_burst_size_default to select profile.

 config/arm/meson.build |  1 +
 config/meson.build     | 15 +++++++++++++++
 meson_options.txt      |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/config/arm/meson.build b/config/arm/meson.build
index 523b0fc0ed50..1b2cdbd25774 100644
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
index 02e2798ccaf1..578b561a4fd1 100644
--- a/config/meson.build
+++ b/config/meson.build
@@ -393,10 +393,25 @@ if get_option('mbuf_refcnt_atomic')
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

