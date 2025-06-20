Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157BFC71155
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E4DE42ED9;
	Fri, 20 Jun 2025 14:06:03 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EBBCD402F2
 for <dev@dpdk.org>; Fri, 20 Jun 2025 14:06:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4hagX027299;
 Fri, 20 Jun 2025 05:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
 CzihbAge/nUgibmxIPtrUyradGl1xecWfRUGs2CmFQ=; b=cAHyXH3w92ujGqI3v
 4W9jS23HGSVFYqe0EbKlr6zuPHby+5HyLNVdhgeXXpvSMojrYN1veDAUrtflqlW5
 dGCaf0C058LqeHnHradpLYIDFUwkszwzghLl0HSFuz3kSXsFx5B28Lfsk+iO6IYE
 7Ifa/ZjtcxRfm+ueEIU/2dTrBfOr6G/qEcto/5U4VMfOnAmnLFNZLHXKk6DUM/No
 W2bdWFvLy+Ke1yDIKCBoKqaAYsShOC/sWgL9H/ZHQieQmdub3kZA0OmzwMscazsr
 IaWAaGUiTPrfNW1sbD+NAWsJwwBKeDS1hvGPl5S3umXn+a6nBR68MDFsjGkWS24r
 gtOcA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47d0vb0r0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Jun 2025 05:05:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 20 Jun 2025 05:05:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 20 Jun 2025 05:05:57 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id 1522D5B692D;
 Fri, 20 Jun 2025 05:05:54 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <tduszynski@marvell.com>
CC: <bruce.richardson@intel.com>, <dev@dpdk.org>, <jerinj@marvell.com>,
 <mb@smartsharesystems.com>, <thomas@monjalon.net>,
 <david.marchand@redhat.com>
Subject: [PATCH v3 0/7] lib/pmu: cleanups and trace integration
Date: Fri, 20 Jun 2025 14:05:44 +0200
Message-ID: <20250620120551.613148-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618065618.4045910-1-tduszynski@marvell.com>
References: <20250618065618.4045910-1-tduszynski@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6Ckc7UY1kd_OSaxOQwivc1pGfnXK7syn
X-Authority-Analysis: v=2.4 cv=O+s5vA9W c=1 sm=1 tr=0 ts=68554ea7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=iR-xy-VhiHNNf1baXf0A:9
X-Proofpoint-ORIG-GUID: 6Ckc7UY1kd_OSaxOQwivc1pGfnXK7syn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA4NiBTYWx0ZWRfX3Lbt3EAQ8EO0
 NFjao2BApNBpWbbZi7++voDnrmEpZM2nyvyF22NlvzeMmRq2usWCxj4FgrPwgAa6t4eX3a/YNnG
 jbVFcz1WUVBR0/Td6SDn77fwC9o4h1+SP0dbJRzcO72rIoBSX1P1xhq7KfQQtnXCUyg4s1QCl0x
 qJA/w0SWV7Ahmbc1ucyaivQsHpBK8f9FpHoORlCmp6kPX1buQdMOszdWiaGQifIsTOgIXBXwxto
 c1/FT9Ee1XXiARt6jeuSHXULDNge/y2mbI7QqScexndJjNk27lGkE6eYb2KPsLTkGRPIy+bhBHQ
 1Jv2rCnwa2/mIsqGZqeUCMQXykU9XArW0NEU1r5B/b5mWTFTfj6/DzFZSEOCAuoMocoy1Jh+asM
 b9nbYqauYWokLPbHw96O0Oz6ikjr83b3p2P7Agn97l3ZItzQxcTc2q4Z1IBUws9UiMUntN+5
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

This series does some cleanup and refactoring around the rc1 code like: trimming unused headers,
switching to callbacks for per-arch handling, and adding trace support. It also re-enables existing
base test to help catch reported issues on some architectures.

v3:
- do not export __rte_pmu_trace_read because that breaks compilation
  on windows - script generating map files does not handle conditional
  compilation
- skip testing if paranoia is at wrong level
v2:
- explicitly check against NULL
- make pmu lib optional by checking if dpdk config has RTE_LIB_PMU

Tomasz Duszynski (7):
  lib/pmu: quiesce rte_pmu_read deprecation warning in chkincs
  lib/pmu: export only necessary arch headers
  lib/pmu: reimplement per-arch ops as callbacks
  lib/pmu: use build system defined RTE_LIB_PMU macro
  test/pmu: enable fast test
  trace: add PMU
  lib/pmu: fix out-of-bound access

 MAINTAINERS                                |  1 +
 app/test/test_pmu.c                        | 44 ++++++++++-
 app/test/test_trace_perf.c                 | 10 +++
 doc/guides/prog_guide/profile_app.rst      |  5 ++
 doc/guides/prog_guide/trace_lib.rst        | 31 ++++++++
 doc/guides/rel_notes/release_25_07.rst     |  2 +
 lib/eal/common/eal_common_trace.c          |  5 +-
 lib/eal/common/eal_common_trace_pmu.c      | 38 ++++++++++
 lib/eal/common/eal_common_trace_points.c   |  5 ++
 lib/eal/common/eal_trace.h                 |  4 +
 lib/eal/common/meson.build                 |  1 +
 lib/eal/include/rte_eal_trace.h            | 16 ++++
 lib/eal/include/rte_trace_point.h          |  7 ++
 lib/eal/include/rte_trace_point_register.h |  2 +
 lib/eal/meson.build                        |  3 +
 lib/meson.build                            |  2 +-
 lib/pmu/meson.build                        | 10 +--
 lib/pmu/pmu.c                              | 88 +++++++++++++++++-----
 lib/pmu/pmu_arm64.c                        | 22 ++++--
 lib/pmu/pmu_private.h                      | 43 +++++++++--
 lib/pmu/rte_pmu.h                          | 31 +++++++-
 21 files changed, 325 insertions(+), 45 deletions(-)
 create mode 100644 lib/eal/common/eal_common_trace_pmu.c

--
2.34.1

